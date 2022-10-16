---@meta
---@diagnostic disable

--$Factorio 1.1.69
--$Overlay 5
--$Section LuaRecipe
-- This file is automatically generated. Edits will be overwritten.

---A crafting recipe. Recipes belong to forces (see [LuaForce](https://lua-api.factorio.com/latest/LuaForce.html)) because some recipes are unlocked by research, and researches are per-force.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html)
---@class LuaRecipe:LuaObject
---[R]  
---Category of the recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.category)
---@field category string 
---[RW]  
---Can the recipe be used?
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.enabled)
---@field enabled boolean 
---[R]  
---Energy required to execute this recipe. This directly affects the crafting time: Recipe's energy is exactly its crafting time in seconds, when crafted in an assembling machine with crafting speed exactly equal to one.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.energy)
---@field energy double 
---[R]  
---The force that owns this recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.force)
---@field force LuaForce 
---[R]  
---Group of this recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.group)
---@field group LuaGroup 
---[R]  
---Is the recipe hidden? Hidden recipe don't show up in the crafting menu.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.hidden)
---@field hidden boolean 
---[RW]  
---Is the recipe hidden from flow statistics?
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.hidden_from_flow_stats)
---@field hidden_from_flow_stats boolean 
---[R]  
---Ingredients for this recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.ingredients)
---
---### Example  
---What the "steel-chest" recipe would return 
---```
---{{type="item", name="steel-plate", amount=8}}
---```
---
---### Example  
---What the "advanced-oil-processing" recipe would return 
---```
---{{type="fluid", name="crude-oil", amount=10}, {type="fluid", name="water", amount=5}}
---```
---@field ingredients Ingredient[] 
---[R]
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.localised_description)
---@field localised_description LocalisedString 
---[R]  
---Localised name of the recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.localised_name)
---@field localised_name LocalisedString 
---[R]  
---Name of the recipe. This can be different than the name of the result items as there could be more recipes to make the same item.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.name)
---@field name string 
---[R]  
---The class name of this object. Available even when `valid` is false. For LuaStruct objects it may also be suffixed with a dotted path to a member of the struct.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.object_name)
---@field object_name string 
---[R]  
---The string used to alphabetically sort these prototypes. It is a simple string that has no additional semantic meaning.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.order)
---@field order string 
---[R]  
---The results of this recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.products)
---@field products Product[] 
---[R]  
---The prototype for this recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.prototype)
---@field prototype LuaRecipePrototype 
---[R]  
---Subgroup of this recipe.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.subgroup)
---@field subgroup LuaGroup 
---[R]  
---Is this object valid? This Lua object holds a reference to an object within the game engine. It is possible that the game-engine object is removed whilst a mod still holds the corresponding Lua object. If that happens, the object becomes invalid, i.e. this attribute will be `false`. Mods are advised to check for object validity if any change to the game state might have occurred between the creation of the Lua object and its access.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.valid)
---@field valid boolean 
local LuaRecipe={
---All methods and properties that this object supports.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.help)
---@return string
help=function()end,
---Reload the recipe from the prototype.
---
---[View documentation](https://lua-api.factorio.com/latest/LuaRecipe.html#LuaRecipe.reload)
reload=function()end,
}

