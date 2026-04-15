CLASS lsc_ZCIT_EVT_HI DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize        REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save            REDEFINITION.
    METHODS cleanup         REDEFINITION.
    METHODS cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lsc_ZCIT_EVT_HI IMPLEMENTATION.
  METHOD finalize.          ENDMETHOD.
  METHOD check_before_save. ENDMETHOD.

  METHOD save.
    DATA(lo_util) = zcit_evt_util=>get_instance( ).
    lo_util->get_hdr_value( IMPORTING ex_hdr = DATA(ls_hdr) ).
    lo_util->get_itm_value( IMPORTING ex_itm = DATA(ls_itm) ).
    lo_util->get_hdr_for_del( IMPORTING ex_hdrs = DATA(lt_del_hdr) ).
    lo_util->get_itm_for_del( IMPORTING ex_itms = DATA(lt_del_itm) ).
    lo_util->get_del_flags( IMPORTING ex_hdr_del = DATA(lv_hdr_del) ).

    " 1. Save / Update Header
    IF ls_hdr IS NOT INITIAL.
      MODIFY zcit_evt_h FROM @ls_hdr.
    ENDIF.

    " 2. Save / Update Session
    IF ls_itm IS NOT INITIAL.
      MODIFY zcit_evt_i FROM @ls_itm.
    ENDIF.

    " 3. Handle Deletions
    IF lv_hdr_del = abap_true.
      " Delete header + all related sessions
      LOOP AT lt_del_hdr INTO DATA(ls_del_h).
        DELETE FROM zcit_evt_h WHERE eventid = @ls_del_h-eventid.
        DELETE FROM zcit_evt_i WHERE eventid = @ls_del_h-eventid.
      ENDLOOP.
    ELSE.
      " Delete only listed headers
      LOOP AT lt_del_hdr INTO ls_del_h.
        DELETE FROM zcit_evt_h WHERE eventid = @ls_del_h-eventid.
      ENDLOOP.
      " Delete individual sessions
      LOOP AT lt_del_itm INTO DATA(ls_del_i).
        DELETE FROM zcit_evt_i
          WHERE eventid = @ls_del_i-eventid
          AND sessionnumber = @ls_del_i-sessionnumber.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
    zcit_evt_util=>get_instance( )->cleanup_buffer( ).
  ENDMETHOD.

  METHOD cleanup_finalize. ENDMETHOD.
ENDCLASS.
