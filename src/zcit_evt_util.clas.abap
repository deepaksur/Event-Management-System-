CLASS zcit_evt_util DEFINITION
  PUBLIC FINAL CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_evt_hdr,
        eventid TYPE zcit_evtid,
      END OF ty_evt_hdr,
      BEGIN OF ty_evt_itm,
        eventid       TYPE zcit_evtid,
        sessionnumber TYPE int2,
      END OF ty_evt_itm.
    TYPES:
      tt_evt_hdr TYPE STANDARD TABLE OF ty_evt_hdr,
      tt_evt_itm TYPE STANDARD TABLE OF ty_evt_itm.

    CLASS-METHODS get_instance
      RETURNING VALUE(ro_inst) TYPE REF TO zcit_evt_util.

    METHODS:
      set_hdr_value
        IMPORTING im_hdr     TYPE zcit_evt_h
        EXPORTING ex_created TYPE abap_boolean,
      get_hdr_value
        EXPORTING ex_hdr TYPE zcit_evt_h,
      set_itm_value
        IMPORTING im_itm     TYPE zcit_evt_i
        EXPORTING ex_created TYPE abap_boolean,
      get_itm_value
        EXPORTING ex_itm TYPE zcit_evt_i,
      set_hdr_for_del
        IMPORTING im_hdr TYPE ty_evt_hdr,
      set_itm_for_del
        IMPORTING im_itm TYPE ty_evt_itm,
      get_hdr_for_del
        EXPORTING ex_hdrs TYPE tt_evt_hdr,
      get_itm_for_del
        EXPORTING ex_itms TYPE tt_evt_itm,
      set_hdr_del_flag
        IMPORTING im_flag TYPE abap_boolean,
      get_del_flags
        EXPORTING ex_hdr_del TYPE abap_boolean,
      cleanup_buffer.

  PRIVATE SECTION.
    CLASS-DATA: gs_hdr_buff    TYPE zcit_evt_h,
                gs_itm_buff    TYPE zcit_evt_i,
                gt_hdr_del     TYPE tt_evt_hdr,
                gt_itm_del     TYPE tt_evt_itm,
                gv_hdr_del     TYPE abap_boolean.
    CLASS-DATA mo_inst TYPE REF TO zcit_evt_util.
ENDCLASS.

CLASS zcit_evt_util IMPLEMENTATION.
  METHOD get_instance.
    IF mo_inst IS INITIAL.
      CREATE OBJECT mo_inst.
    ENDIF.
    ro_inst = mo_inst.
  ENDMETHOD.

  METHOD set_hdr_value.
    IF im_hdr-eventid IS NOT INITIAL.
      gs_hdr_buff = im_hdr.
      ex_created = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD get_hdr_value.
    ex_hdr = gs_hdr_buff.
  ENDMETHOD.

  METHOD set_itm_value.
    IF im_itm IS NOT INITIAL.
      gs_itm_buff = im_itm.
      ex_created = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD get_itm_value.
    ex_itm = gs_itm_buff.
  ENDMETHOD.

  METHOD set_hdr_for_del.
    APPEND im_hdr TO gt_hdr_del.
  ENDMETHOD.

  METHOD set_itm_for_del.
    APPEND im_itm TO gt_itm_del.
  ENDMETHOD.

  METHOD get_hdr_for_del.
    ex_hdrs = gt_hdr_del.
  ENDMETHOD.

  METHOD get_itm_for_del.
    ex_itms = gt_itm_del.
  ENDMETHOD.

  METHOD set_hdr_del_flag.
    gv_hdr_del = im_flag.
  ENDMETHOD.

  METHOD get_del_flags.
    ex_hdr_del = gv_hdr_del.
  ENDMETHOD.

  METHOD cleanup_buffer.
    CLEAR: gs_hdr_buff, gs_itm_buff,
           gt_hdr_del, gt_itm_del, gv_hdr_del.
  ENDMETHOD.
ENDCLASS.

