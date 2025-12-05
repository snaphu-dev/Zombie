local Zombie = {}
Zombie.__index = Zombie

local action = require(script.Parent.Actions)
local zombieAction = action.new(script.Parent) 

export type zombie = {
    health: number;
    awareness: number;
    hasLineOfSight: boolean;
    injured: boolean;

    Model: Model; 
    Head: BasePart;
};

function Zombie.new(model: Model)
    
    local self = setmetatable({}, Zombie);

    self.Model = model;
    self.Head = model:WaitForChild("Head");
    self.health = 100;
    self.awareness = 0;
    self.hasLineOfSight = false;
    self.injured = false;

    return self;
    
end

function Zombie:Update(dt)
    if not self.Head then return; end

    local rayOrigin = self.Head.Position;
    local rayDirection = self.Head.CFrame.LookVector * 100;

    local raycastParams = RaycastParams.new();
    raycastParams.FilterDescendantsInstances = {self.Model};
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude;

    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams);

    local foundTarget = false;

    if raycastResult then
        local hitPart = raycastResult.Instance;
        local hitModel = hitPart:FindFirstAncestorOfClass("Model");

        if hitModel and hitModel:FindFirstChild("Humanoid") then
            foundTarget = true;
        end
    end
    if foundTarget then
        self.hasLineOfSight = true;
        self.awareness = math.min(1, self.awareness + 0.25);
    else
        self.hasLineOfSight = false;
        self.awareness = math.max(0, self.awareness - 0.25);
    end 

    if self.awareness >= 1 then
        zombieAction.chasing = true;
        zombieAction.suspicious = false;
        zombieAction.idle = false;
        print("State: Chasing")
    elseif self.awareness > 0 then
        zombieAction.chasing = false;
        zombieAction.suspicious = true;
        zombieAction.idle = false;
        print("State: Sus");
    else
        zombieAction.chasing = false;
        zombieAction.suspicious = false;
        zombieAction.idle = true;
        print("State: Idle");
    end
end

return Zombie;
