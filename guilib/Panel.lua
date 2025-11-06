---@class Panel
local Panel = 
{
    name = "no_name",
    root_element = nil,
    ---@type LuaPlayer
    builder_callback = nil,
    ---@type GuiElementType
    root_type = nil
}
Panel.__index = Panel

---comment
---@param name any
---@param builder_callback any
---@param type GuiElementType
---@return Panel
function Panel.new(name, builder_callback, type)
    local self = setmetatable({}, Panel)

    self.name = name
    self.builder_callback = builder_callback
    self.root_type = type

    return self
end

function Panel:Show(player)

    local root = player.gui.screen[self.name]
    if not root or not root.valid then root = self:build(player) end

    root.visible = true
end

function Panel:Hide(player)
    local root = player.gui.screen[self.name]
    if not root or not root.valid then root = self:build(player) end
    
    root.visible = false
end

function Panel:ToggleVisibility (player)
    local root = player.gui.screen[self.name]
    if not root or not root.valid then root = self:build(player) end
    
    root.visible = not root.visible
end

function Panel:build(player)
    self:clear(player)

    local root = player.gui.screen.add{
    type = self.root_type,
    name = self.name,
    direction = "vertical"
    }
    self.builder_callback(root)

    return root

end

function Panel:get(player)
  local root = player.gui.screen[self.name]
  return root
end

function Panel:clear(player)

    local root = player.gui.screen[self.name]
    if not root or not root.valid then return end

  for _, child in pairs(root.children) do
    if child.valid then child.destroy() end
  end

  root.destroy()
end

return Panel