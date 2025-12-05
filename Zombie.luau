local Zombie = {}
Zombie.__index = Zombie

export type zombie = {
    health: number;
    awareness: number;
    hasLineOfSight: boolean;
    injured: boolean;

    Model: Model; 
    Head: BasePart;
};

function Zombie.new(model: Model)
    local self = setmetatable({}, Zombie)

    self.Model = model
    self.Head = model:WaitForChild("Head")
    self.health = 100
    self.awareness = 0
    self.hasLineOfSight = false
    self.injured = false

    return self
end

function Zombie:Update(dt)
    local rayOrigin = self.Head.Position

    local rayDirection = self.Head.CFrame.LookVector * 100 

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {self.Model}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

    self.hasLineOfSight = false 

    if raycastResult then
        local hitPart = raycastResult.Instance
        local hitModel = hitPart:FindFirstAncestorOfClass("Model")

        if hitModel and hitModel:FindFirstChild("Humanoid") then
            self.hasLineOfSight = true
            self.awareness = math.min(1, self.awareness + 0.25)
            print("Target Sighted! Awareness:", self.awareness)
        end
        
    else self.hasLineOfSight = false;
        self.awareness = math.max(0, self.awareness-0.25);
        print("Target lost! Awareness:", self.awareness)
    end 
end

return Zombie;
