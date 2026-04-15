@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Interface View – Event Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCIT_EVT_HI
  as select from zcit_evt_h as EventHeader
  composition [0..*] of ZCIT_EVT_II as _session
{
  key eventid             as EventId,
      eventname           as EventName,
      eventtype           as EventType,
      venuecity           as VenueCity,
      venueroom           as VenueRoom,
      startdate           as StartDate,
      enddate             as EndDate,
      maxcapacity         as MaxCapacity,
      @Semantics.amount.currencyCode: 'Currency'
      registrationfee     as RegistrationFee,
      currency            as Currency,
      status              as Status,
      @Semantics.user.createdBy: true
      local_created_by    as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at    as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by  as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at  as LocalLastChangedAt,
      /* Associations */
      _session
}
