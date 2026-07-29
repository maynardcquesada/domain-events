using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }

ListenerHubTooltip<internal><localizes>:message = "Point this at the same Domain Event Hub device the producer uses"

# Knows the hub, not the producer.
activity_listener_device<public> := class(creative_device):

    @editable{ToolTip := ListenerHubTooltip}
    EventHub<private>:?domain_event_hub_device = false

    OnBegin<override>()<suspends>:void =
        if (Hub := EventHub?):
            ListenForCompletions(Hub)
        else:
            Print("[activity_listener] EventHub not set, this device will never react. Assign it in the Details panel.")

    # Await suspends, so this can't spin. A polling version would need an iteration cap.
    ListenForCompletions<private>(Hub:domain_event_hub_device)<suspends>:void =
        loop:
            Payload := Hub.ActivityCompletedEvent.Await()
            OnActivityCompleted(Payload)

    OnActivityCompleted<private>(Payload:activity_completed_payload):void =
        if (Payload.WasSuccessful?):
            Print("[activity_listener] Activity completed successfully.")
        else:
            Print("[activity_listener] Activity completed unsuccessfully.")
