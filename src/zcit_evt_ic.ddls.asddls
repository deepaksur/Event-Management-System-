@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Event Session Consumption View'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZCIT_EVT_IC
  as projection on ZCIT_EVT_II
{
  key EventId,
  key SessionNumber,
      @Search.defaultSearchElement: true
      SessionTopic,
      SpeakerName,
      SessionRoom,
      SessionStart,
      SessionEnd,
      SessionDate,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      /* Associations */
      _event : redirected to parent ZCIT_EVT_HC
}
