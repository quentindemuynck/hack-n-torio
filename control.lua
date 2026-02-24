local Panel = require("guilib/Panel")

---@type LuaCustomTable<string|integer, LuaPlayer>
local players = nil

---comment
---@param root LuaGuiElement
function create_todo_root(root)
    -- create window
    local tabs = root.add{
        type = "tabbed-pane",
    }

    -- players tab
    local players_tab = tabs.add{
        type = "tab",
        caption = "Players"
    }
    local players_content = tabs.add{
        type = "flow",
        direction = "vertical"
    }
    for _, player in pairs(game.players) do
        local player_display = players_content.add{
            type = "flow",
            direction = "horizontal",
            style = "hack_player_list"
        }

        player_display.add{
            type = "label",
            caption = player.name,
            style = "hack_name"
        }

        player_display.add{
            type = "progressbar",
            style = "hack_progress"
        }
    end

    tabs.add_tab(players_tab, players_content)

    -- tasks tab
    local tasks_tab = tabs.add{
        type = "tab",
        caption = "Tasks"
    }
    local tasks_content = tabs.add{
        type = "flow",
        direction = "vertical"
    }
    tasks_content.add{ type = "label", caption = "Tasks go here" }

    tabs.add_tab(tasks_tab, tasks_content)
end


---@type Panel
local todo_window = Panel.new("todo_window","Todo" , create_todo_root, "frame")
local joined = false


script.on_event( defines.events.on_player_joined_game ,function (event)
    if joined then return end

    joined = true

    todo_window:Hide(game.get_player(event.player_index))
end)

script.on_init(function ()
    players = game.players
end)

script.on_event(defines.events.on_player_created, function(event)
    players = game.players
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

script.on_event(defines.events.on_lua_shortcut, function (event)
    if event.name then todo_window:ToggleVisibility(game.get_player(event.player_index))  end
end)


function recreate_menus(player)
    todo_window:build(player)
    todo_window:Hide(player)
end

