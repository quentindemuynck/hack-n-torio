data:extend({
  {
    type = "custom-input",
    name = "hack-reload-ui",          
    key_sequence = "CONTROL + G",
    consuming = "game-only"    
  }
})

data:extend({
  {
    type = "custom-input",
    name = "hack-todo-open",          
    key_sequence = "Y",
    consuming = "game-only"    
  }
})

data:extend({
  {
    type = "shortcut",
    name = "hack-open-todo",
    order = "a[tool]-z",
    action = "lua",
    localised_name = {"shortcut.my-custom-knopske"},
    icon = "__hack-n-torio__/graphics/checkmark_32.png",
    small_icon = "__hack-n-torio__/graphics/checkmark_24.png",
    small_icon_size = 24,
    icon_size = 32,
    style = "default",
    associated_control_input = "hack-todo-open",
  }
})

local style = data.raw["gui-style"]["default"]

style.hack_drag_handle = {
  type = "empty_widget_style",
  parent = "draggable_space",
  horizontally_stretchable = "on",
  height = 24,
  left_margin = 4,
  right_margin = 4
}

