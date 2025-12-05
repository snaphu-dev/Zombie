local Action = {}

export type action = {
    
    idle:boolean;
    wandering:boolean;
    suspicious:boolean;
    chasing:boolean;
    throttledUpdates:boolean;
    
};

return Action;
