using { /Fortnite.com/Devices }

# Events only. Gameplay logic in here would become a dependency for everything that listens.
domain_event_hub_device<public> := class(creative_device):

    ActivityCompletedEvent<public>:event(activity_completed_payload) = event(activity_completed_payload){}
