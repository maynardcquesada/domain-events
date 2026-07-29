using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Simulation }

EventHubTooltip<internal><localizes>:message = "Point this at the Domain Event Hub device in your level"

# Knows the hub, not the listeners.
activity_producer_device<public> := class(creative_device):

    @editable{ToolTip := EventHubTooltip}
    EventHub<private>:?domain_event_hub_device = false

    # Checked once at start-up so the publish path doesn't re-check.
    var IsWired<private>:logic = false

    OnBegin<override>()<suspends>:void =
        if (EventHub?):
            set IsWired = true
        else:
            Print("[activity_producer] EventHub not set, this device will not publish. Assign it in the Details panel.")

    # Call once the outcome is decided, so no listener sees a half-finished activity.
    ReportCompletion<public>(Participant:agent, WasSuccessful:logic):void =
        if (not IsWired?):
            return

        if (Hub := EventHub?):
            Hub.ActivityCompletedEvent.Signal(
                activity_completed_payload{Participant := Participant, WasSuccessful := WasSuccessful})
        else:
            Print("[activity_producer] EventHub went missing, dropped a completion.")
