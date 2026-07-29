# domain-events
Three devices. The hub owns a typed event. The producer signals it when an activity finishes, carrying who finished and whether they succeeded. The listener awaits it and reacts. Both point at the hub and never at each other, so either can be rewritten without touching the other.
