CLASS lhc_EventHeader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR EventHeader
      RESULT result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR EventHeader
      RESULT result.
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE EventHeader.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE EventHeader.
    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE EventHeader.
    METHODS read FOR READ
      IMPORTING keys FOR READ EventHeader RESULT result.
    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK EventHeader.
    METHODS rba_Session FOR READ
      IMPORTING keys_rba FOR READ EventHeader\_session
      FULL result_requested RESULT result LINK association_links.
    METHODS cba_Session FOR MODIFY
      IMPORTING entities_cba FOR CREATE EventHeader\_session.
ENDCLASS.

CLASS lhc_EventHeader IMPLEMENTATION.
  METHOD get_instance_authorizations. ENDMETHOD.
  METHOD get_global_authorizations.   ENDMETHOD.
  METHOD lock.                        ENDMETHOD.

  METHOD create.
    DATA ls_hdr TYPE zcit_evt_h.
    LOOP AT entities INTO DATA(ls_ent).
      ls_hdr = CORRESPONDING #( ls_ent MAPPING FROM ENTITY ).
      IF ls_hdr-eventid IS NOT INITIAL.
        SELECT FROM zcit_evt_h FIELDS *
          WHERE eventid = @ls_hdr-eventid INTO TABLE @DATA(lt_chk).
        IF sy-subrc NE 0.
          DATA(lo_util) = zcit_evt_util=>get_instance( ).
          lo_util->set_hdr_value(
            EXPORTING im_hdr = ls_hdr
            IMPORTING ex_created = DATA(lv_ok) ).
          IF lv_ok = abap_true.
            APPEND VALUE #( %cid = ls_ent-%cid
                            eventid = ls_hdr-eventid ) TO mapped-eventheader.
            APPEND VALUE #(
              %cid = ls_ent-%cid eventid = ls_hdr-eventid
              %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
                v1 = 'Event Created' severity = if_abap_behv_message=>severity-success )
            ) TO reported-eventheader.
          ENDIF.
        ELSE.
          APPEND VALUE #( %cid = ls_ent-%cid eventid = ls_hdr-eventid ) TO failed-eventheader.
          APPEND VALUE #(
            %cid = ls_ent-%cid eventid = ls_hdr-eventid
            %msg = new_message( id = 'ZCIT_EVT_MSG' number = 002
              v1 = 'Duplicate Event ID' severity = if_abap_behv_message=>severity-error )
          ) TO reported-eventheader.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA ls_hdr TYPE zcit_evt_h.
    LOOP AT entities INTO DATA(ls_ent).
      ls_hdr = CORRESPONDING #( ls_ent MAPPING FROM ENTITY ).
      IF ls_hdr-eventid IS NOT INITIAL.
        SELECT FROM zcit_evt_h FIELDS *
          WHERE eventid = @ls_hdr-eventid INTO TABLE @DATA(lt_chk).
        IF sy-subrc EQ 0.
          DATA(lo_util) = zcit_evt_util=>get_instance( ).
          lo_util->set_hdr_value(
            EXPORTING im_hdr = ls_hdr
            IMPORTING ex_created = DATA(lv_ok) ).
          IF lv_ok = abap_true.
            APPEND VALUE #( eventid = ls_hdr-eventid ) TO mapped-eventheader.
            APPEND VALUE #(
              %key = ls_ent-%key
              %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
                v1 = 'Event Updated' severity = if_abap_behv_message=>severity-success )
            ) TO reported-eventheader.
          ENDIF.
        ELSE.
          APPEND VALUE #( %cid = ls_ent-%cid_ref eventid = ls_hdr-eventid ) TO failed-eventheader.
          APPEND VALUE #(
            %cid = ls_ent-%cid_ref eventid = ls_hdr-eventid
            %msg = new_message( id = 'ZCIT_EVT_MSG' number = 003
              v1 = 'Event Not Found' severity = if_abap_behv_message=>severity-error )
          ) TO reported-eventheader.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    DATA(lo_util) = zcit_evt_util=>get_instance( ).
    LOOP AT keys INTO DATA(ls_key).
      lo_util->set_hdr_for_del(
        im_hdr = VALUE #( eventid = ls_key-eventid ) ).
      lo_util->set_hdr_del_flag( im_flag = abap_true ).
      APPEND VALUE #(
        %cid = ls_key-%cid_ref eventid = ls_key-eventid
        %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
          v1 = 'Event Deleted' severity = if_abap_behv_message=>severity-success )
      ) TO reported-eventheader.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    LOOP AT keys INTO DATA(ls_key).
      SELECT SINGLE FROM zcit_evt_h FIELDS *
        WHERE eventid = @ls_key-eventid INTO @DATA(ls_hdr).
      IF sy-subrc = 0.
        APPEND CORRESPONDING #( ls_hdr ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD rba_Session.
    LOOP AT keys_rba INTO DATA(ls_key).
      SELECT FROM zcit_evt_i FIELDS *
        WHERE eventid = @ls_key-eventid INTO TABLE @DATA(lt_itms).
      LOOP AT lt_itms INTO DATA(ls_itm).
        APPEND CORRESPONDING #( ls_itm ) TO result.
        APPEND VALUE #(
          source-eventid = ls_key-eventid
          target-eventid = ls_itm-eventid
          target-sessionnumber = ls_itm-sessionnumber ) TO association_links.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD cba_Session.
    DATA ls_itm TYPE zcit_evt_i.
    LOOP AT entities_cba INTO DATA(ls_cba).
      ls_itm = CORRESPONDING #( ls_cba-%target[ 1 ] ).
      IF ls_itm-eventid IS NOT INITIAL AND ls_itm-sessionnumber IS NOT INITIAL.
        SELECT FROM zcit_evt_i FIELDS *
          WHERE eventid = @ls_itm-eventid
          AND sessionnumber = @ls_itm-sessionnumber INTO TABLE @DATA(lt_chk).
        IF sy-subrc NE 0.
          DATA(lo_util) = zcit_evt_util=>get_instance( ).
          lo_util->set_itm_value(
            EXPORTING im_itm = ls_itm
            IMPORTING ex_created = DATA(lv_ok) ).
          IF lv_ok = abap_true.
            APPEND VALUE #(
              %cid = ls_cba-%target[ 1 ]-%cid
              eventid = ls_itm-eventid
              sessionnumber = ls_itm-sessionnumber ) TO mapped-eventsession.
            APPEND VALUE #(
              %cid = ls_cba-%target[ 1 ]-%cid
              eventid = ls_itm-eventid
              %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
                v1 = 'Session Created' severity = if_abap_behv_message=>severity-success )
            ) TO reported-eventsession.
          ENDIF.
        ELSE.
          APPEND VALUE #(
            %cid = ls_cba-%target[ 1 ]-%cid
            eventid = ls_itm-eventid
            sessionnumber = ls_itm-sessionnumber ) TO failed-eventsession.
          APPEND VALUE #(
            %cid = ls_cba-%target[ 1 ]-%cid
            eventid = ls_itm-eventid
            %msg = new_message( id = 'ZCIT_EVT_MSG' number = 002
              v1 = 'Duplicate Session' severity = if_abap_behv_message=>severity-error )
          ) TO reported-eventsession.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
