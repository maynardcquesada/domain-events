using { /Verse.org/Simulation }

# One struct, so adding a field later doesn't touch call sites.
activity_completed_payload<public> := struct:
    # agent, not player. Not every participant is a player.
    Participant<public>:agent

    # Failures go out on the same event. Listeners filter.
    WasSuccessful<public>:logic
