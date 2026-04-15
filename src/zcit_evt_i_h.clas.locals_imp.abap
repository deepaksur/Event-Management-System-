CLASS lhc_EventSession DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE EventSession.
    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE EventSession.
    METHODS read FOR READ
      IMPORTING keys FOR READ EventSession RESULT result.
    METHODS rba_Event FOR READ
      IMPORTING keys_rba FOR READ EventSession\_event
      FULL result_requested RESULT result LINK association_links.
ENDCLASS.

CLASS lhc_EventSession IMPLEMENTATION.
  METHOD update.
    DATA ls_itm TYPE zcit_evt_i.
    LOOP AT entities INTO DATA(ls_ent).
      ls_itm = CORRESPONDING #( ls_ent MAPPING FROM ENTITY ).
      IF ls_itm-eventid IS NOT INITIAL.
        SELECT FROM zcit_evt_i FIELDS *
          WHERE eventid = @ls_itm-eventid
          AND sessionnumber = @ls_itm-sessionnumber INTO TABLE @DATA(lt_chk).
        IF sy-subrc EQ 0.
          DATA(lo_util) = zcit_evt_util=>get_instance( ).
          lo_util->set_itm_value(
            EXPORTING im_itm = ls_itm
            IMPORTING ex_created = DATA(lv_ok) ).
          IF lv_ok = abap_true.
            APPEND VALUE #( eventid = ls_itm-eventid
                            sessionnumber = ls_itm-sessionnumber ) TO mapped-eventsession.
            APPEND VALUE #(
              %key = ls_ent-%key
              %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
                v1 = 'Session Updated' severity = if_abap_behv_message=>severity-success )
            ) TO reported-eventsession.
          ENDIF.
        ELSE.
          APPEND VALUE #(
            %cid = ls_ent-%cid_ref
            eventid = ls_itm-eventid
            sessionnumber = ls_itm-sessionnumber ) TO failed-eventsession.
          APPEND VALUE #(
            %cid = ls_ent-%cid_ref eventid = ls_itm-eventid
            %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
              v1 = 'Session Not Found' severity = if_abap_behv_message=>severity-error )
          ) TO reported-eventsession.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    DATA(lo_util) = zcit_evt_util=>get_instance( ).
    LOOP AT keys INTO DATA(ls_key).
      lo_util->set_itm_for_del(
        im_itm = VALUE #( eventid = ls_key-eventid
                          sessionnumber = ls_key-sessionnumber ) ).
      APPEND VALUE #(
        %cid = ls_key-%cid_ref eventid = ls_key-eventid
        sessionnumber = ls_key-sessionnumber
        %msg = new_message( id = 'ZCIT_EVT_MSG' number = 001
          v1 = 'Session Deleted' severity = if_abap_behv_message=>severity-success )
      ) TO reported-eventsession.
    ENDLOOP.
  ENDMETHOD.

  METHOD read. ENDMETHOD.

  METHOD rba_Event. ENDMETHOD.
ENDCLASS.
