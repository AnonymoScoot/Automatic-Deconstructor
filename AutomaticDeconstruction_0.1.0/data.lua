
data:extend({

	{
    type = "recipe",
    name = "automatic-deconstructor",
	icon = "__AutomaticDeconstruction__/graphics/icons/automatic-deconstructor.png",
    enabled = false,
    energy_required = 1,
    ingredients = { { "electronic-circuit", 20 }, { "transport-belt", 10 }, { "iron-gear-wheel", 5 } },
    results= { { "automatic-deconstructor" , 1 } },
    subgroup = "tool",
    order = "c[automated-construction]-d[deconstruction-planner]"
    },
	
	{
	type = "deconstruction-item",
    name = "automatic-deconstructor",
    icon = "__AutomaticDeconstruction__/graphics/icons/automatic-deconstructor.png",
    flags = {"goes-to-quickbar"},
    subgroup = "tool",
    order = "c[automated-construction]-d[deconstruction-planner]",
    stack_size = 1,
    selection_color = { r = 1, g = 1, b = 0 },
    alt_selection_color = { r = 0, g = 0, b = 1 },
    selection_mode = {"deconstruct"},
    alt_selection_mode = {"cancel-deconstruct"},
    selection_cursor_box_type = "not-allowed",
    alt_selection_cursor_box_type = "not-allowed"
	},
	
	{
    type = "technology",
    name = "automatic-deconstruction",
    icon = "__AutomaticDeconstruction__/graphics/icons/automatic-deconstruction.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "automatic-deconstructor"
      },
    },
    unit =
    {
      count = 45,
      ingredients = {{"science-pack-1", 1},{"science-pack-2", 1}},
      time = 10
    },
    order = "c-a"
  },

})

