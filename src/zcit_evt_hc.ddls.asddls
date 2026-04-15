@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Event Header Consumption View'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZCIT_EVT_HC
  provider contract transactional_query
  as projection on ZCIT_EVT_HI
{
  key EventId,
      EventName,
      EventType,
      @Search.defaultSearchElement: true
      VenueCity,
      VenueRoom,
      StartDate,
      EndDate,
      MaxCapacity,
      @Semantics.amount.currencyCode: 'Currency'
      RegistrationFee,
      Currency,
      Status,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      /* Associations */
      _session : redirected to composition child ZCIT_EVT_IC
}
