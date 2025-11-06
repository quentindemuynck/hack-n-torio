local Panel = require("guilib/Panel")

---comment
---@param root LuaGuiElement
function create_button_root(root)
    root.caption = "Open Todo"
end

function create_todo_root(root)
    root.auto_center = true
    root.caption = "Todo list"

root.add({type = "button",
    name = "hack_close",
    caption = "Close"})
end

---@type Panel
local button = Panel.new("show_todo", create_button_root, "button")
---@type Panel
local todo_window = Panel.new("todo_window", create_todo_root, "frame")
local joined = false

script.on_event( defines.events.on_player_joined_game ,function (event)
    if joined then return end

    joined = true
    button:Show(game.get_player(event.player_index))
    todo_window:Hide(game.get_player(event.player_index))
end)

script.on_event("hack-reload-ui", function(event)
    game.reload_mods()

    local player = game.get_player(event.player_index)
    if not player then return end

    recreate_menus(player)
    game.print("UI reloaded")
end )

script.on_event("hack-todo-open", function(event)
    todo_window:ToggleVisibility(game.get_player(event.player_index))
    
end )

script.on_event(defines.events.on_gui_click, function (event)

    if event.element.name == "show_todo" then
        todo_window:ToggleVisibility(game.get_player(event.player_index))
    end

    if event.element.name == "hack_close" then
        todo_window:Hide(game.get_player(event.player_index))
    end
end)


function recreate_menus(player)
    button:build(player)
    todo_window:build(player)
    todo_window:Hide(player)
end

