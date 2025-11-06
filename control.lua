local Panel = require("guilib/Panel")

---comment
---@param root LuaGuiElement
function create_button_root(root)
    root.caption = "Open Todo"
end

function create_todo_root(root)
    root.auto_center = true

-- create title bar
    local titlebar = root.add{
        type = "flow",
        direction = "horizontal"
    }
    titlebar.drag_target = root -- makes the window draggable by the titlebar

    titlebar.add{
        type = "label",
        caption = "Todo List",
        style = "frame_title"
    }


    local dragger = titlebar.add{
      type = "empty-widget",
      ignored_by_interaction = true,
      style = "informatron_drag_handle"
    }

    -- close button
    titlebar.add{
        type = "sprite-button",
        name = "hack_close",
        sprite = "utility/close",
        style = "close_button"
    }

    -- create window
    root.add{
        type = "button",
        caption = "Random ass button"
    }

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

