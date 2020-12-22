if string.sub(mods["base"],1,4) == "0.18" then
--0.17
	sp = 	{
					"automation-science-pack",
					"logistic-science-pack", 
					"chemical-science-pack", 
					"military-science-pack", 
					"production-science-pack",
					"utility-science-pack"
				}
else
	--0.16	
	sp =	{	"science-pack-1",
					"science-pack-2",
					"science-pack-3",
					"military-science-pack",
					"production-science-pack",
					"high-tech-science-pack"
				}
	--flags_main = {"goes-to-main-inventory"}
	--flags_quickbar = {"goes-to-quickbar"}
	flags = {"goes-to-main-inventory"}
end


data:extend({
  {
		type = "technology",
		name = "laser-rifle-1",
		icon = "__laser_rifle__/thumbnail.png",
		effects =
		{{
			type = "unlock-recipe",
			recipe = "laserrifle-charger"
		},
		{
			type = "unlock-recipe",
			recipe = "laserrifle"
		}},
		prerequisites = { "modular-armor"},
		unit = {
			count = 250,
			ingredients = {
				{sp[1], 1},
				{sp[2], 1},},
			time = 30
		},
		order = "c-e-c",
		icon_size = 144,

  },
    {
		type = "technology",
		name = "laser-rifle-2",
		icon = "__laser_rifle__/thumbnail.png",
		effects =
		{{
			type = "nothing",
			effect_description = {"modifier-description.laser-rifle-2"},
		}},
		prerequisites = { "military-4","laser-rifle-1"},
		unit = {
			count = 200,
			ingredients = {
				{sp[1], 1},
				{sp[2], 1},
				{sp[3], 1},
				{sp[4], 1},
				{sp[5], 1}},
			time = 30
		},
		order = "c-e-c",
		icon_size = 144,

  },
    {
		type = "technology",
		name = "laser-rifle-3",
		icon = "__laser_rifle__/thumbnail.png",
		effects =
		{{
			type = "nothing",
			effect_description = {"modifier-description.laser-rifle-3"},
		}},
		prerequisites = { "uranium-ammo","laser-rifle-2"},
		unit = {
			count = 600,
			ingredients = {
				{sp[1], 1},
				{sp[2], 1},
				{sp[3], 1},
				{sp[4], 1},
				{sp[5], 1},
				{sp[6], 1}},
			time = 30
		},
		order = "c-e-c",
		icon_size = 144,

  },
--recipe
  {
    type = "recipe",
    name = "laserrifle-charger",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"advanced-circuit", 50},
      {"steel-plate", 20},
      {"battery", 50}
    },
    result = "laserrifle-charger"
  },
--item
  {
    type = "item",
    name = "laserrifle-charger",
    icons = {{icon="__laser_rifle__/charger2.png",tint={r=1.0, g=1.0, b=1.0}},{icon="__laser_rifle__/charger3.png",tint={r=1.0, g=1.0, b=1.0}}},
    icon_size = 144,
	flags = flags,
    placed_as_equipment_result = "laserrifle-charger",
    subgroup = "equipment",
    order = "e[robotics]-a[personal-roboport-equipment]",
    stack_size = 20
  },
--equipment
  {
    type = "battery-equipment",
    name = "laserrifle-charger",
    sprite =
    {layers={{
      filename = "__laser_rifle__/charger2.png",
      width = 144,
      height = 144,
      priority = "medium",
	  tint={r=1.0, g=1.0, b=1.0}
    },{
      filename = "__laser_rifle__/charger3.png",
      width = 144,
      height = 144,
      priority = "medium",
	  tint={r=1.0, g=1.0, b=1.0}
    }}},
    shape =
    {
      width = 1,
      height = 1,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "750KJ",
      input_flow_limit = "750KW",
      drain = "0W",
	  output_flow_limit = "0W",
      usage_priority = "primary-input"
    },
    categories = {"armor"},
    order = "b-i-c"
  }
 })