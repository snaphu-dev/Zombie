local Action = {}
Action.__index = Action

export type ActionState = {
    
    idle: boolean;
    wandering: boolean;
    suspicious: boolean;
    chasing: boolean;
    throttledUpdates: boolean;
    
}

function Action.new()
    
    local self = setmetatable({}, Action)

    self.idle = true;
    self.wandering = false;
    self.suspicious = false;
    self.chasing = false;
    self.throttledUpdates = false;

    return self;
    
end

return Action;
