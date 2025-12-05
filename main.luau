local brain = require(script.Parent.Zombie);
local pathTo = require(script.Parent.Pathfinding);
local zombie = brain.new(script.Parent);

local dead = false; 

repeat
    now = os.clock();
    dt = os.clock() - now;
    task.wait(dt);
    
    brain:Update(dt);

    if brain.hasLineOfSight then
        
    end
until dead;
