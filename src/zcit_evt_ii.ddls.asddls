@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Child Interface View – Event Session'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZCIT_EVT_II
  as select from zcit_evt_i
  association to parent ZCIT_EVT_HI as _event
    on $projection.EventId = _event.EventId
{
  key eventid             as EventId,
  key sessionnumber       as SessionNumber,
      sessiontopic        as SessionTopic,
      speakername         as SpeakerName,
      sessionroom         as SessionRoom,
      sessionstart        as SessionStart,
      sessionend          as SessionEnd,
      sessiondate         as SessionDate,
      @Semantics.user.createdBy: true
      local_created_by    as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at    as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by  as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at  as LocalLastChangedAt,
      /* Associations */
      _event
}
