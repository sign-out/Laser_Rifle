local rifle = table.deepcopy(data.raw.gun.pistol)
local recipe = table.deepcopy(data.raw.recipe.pistol)

rifle.name = "laserrifle"
rifle.icon = "__laser_rifle__/thumbnail.png"
rifle.icon_size = 144
rifle.order = "a[basic-clips]-a[pistol]-3"
--rifle.attack_parameters.damage_modifier = 1--2 --submachinegun = 12.5
rifle.attack_parameters.ammo_category = "laser-turret"
rifle.attack_parameters.cooldown =30
rifle.attack_parameters.range = 20
rifle.attack_parameters.shell_particle = nil
rifle.attack_parameters.sound =     {
      {
        filename = "__laser_rifle__/test2.ogg",
        volume = 0.3
      },

    }

recipe.name = "laserrifle"
recipe.energy_required = 60
recipe.enabled = false
recipe.ingredients =
    {
      {"steel-plate", 10},
      {"plastic-bar", 5},
	  {"battery", 30},
	  {"small-lamp", 15}
    }
recipe.result = "laserrifle"


data:extend({
rifle, recipe,
  --{
  --  type = "ammo-category",
  --  name = "laser-rifle"
  --},
  {
    type = "projectile",
    name = "laserrifle-projectile-1",
    flags = {"not-on-map"},
    acceleration = 0.03,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          --{
          --  type = "create-entity",
          --  entity_name = "laser-bubble"
          --},
          {
            type = "damage",
            damage = { amount = 30, type = "laser"}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 10},
    animation =
    {
      filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
	  scale = 1.8,
      tint = {r=1.0, g=1.0, b=1.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    }
  },
{
    type = "ammo",
    name = "laser-ammo-1",
    icon = "__laser_rifle__/flash.png",
    icon_size = 32,
    flags = {"hidden"},
	ammo_type =
    {
      category = "laser-turret",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
            projectile = "laserrifle-projectile-1",
            starting_speed = 1,
            direction_deviation = 0.3,
            range_deviation = 0.3,
            max_range = 22
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "c[railgun]",
    stack_size = 1
  },
  {
    type = "projectile",
    name = "laserrifle-projectile-2",
    flags = {"not-on-map"},
    acceleration = 0.03,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          --{
          --  type = "create-entity",
          --  entity_name = "laser-bubble"
          --},
          {
            type = "damage",
            damage = { amount = 42, type = "laser"}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 10},
    animation =
    {
      filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
	  scale = 1.9,
      tint = {r=1.0, g=0.37, b=1.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    }
  },
{
    type = "ammo",
    name = "laser-ammo-2",
    icon = "__laser_rifle__/flash.png",
    icon_size = 32,
    flags = {"hidden"},
	ammo_type =
    {
      category = "laser-turret",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
            projectile = "laserrifle-projectile-2",
            starting_speed = 1,
            direction_deviation = 0.3,
            range_deviation = 0.3,
            max_range = 22
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "c[railgun]",
    stack_size = 1
  },
  {
    type = "projectile",
    name = "laserrifle-projectile-3",
    flags = {"not-on-map"},
    acceleration = 0.03,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          --{
          --  type = "create-entity",
          --  entity_name = "laser-bubble"
          --},
          {
            type = "damage",
            damage = { amount = 90, type = "laser"}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 10},
    animation =
    {
      filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
	  scale = 2,
      tint = {r=0.0, g=1.0, b=1.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    }
  },
{
    type = "ammo",
    name = "laser-ammo-3",
    icon = "__laser_rifle__/flash.png",
    icon_size = 32,
    flags = {"hidden"},
	ammo_type =
    {
      category = "laser-turret",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
            projectile = "laserrifle-projectile-3",
            starting_speed = 1,
            direction_deviation = 0.3,
            range_deviation = 0.3,
            max_range = 22
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "c[railgun]",
    stack_size = 1
  },
})
require("charger")
if settings.startup["laserrifle-override-color"].value then
	local r =  settings.startup["laserrifle-color-r"].value
	local g =  settings.startup["laserrifle-color-g"].value
	local b =  settings.startup["laserrifle-color-b"].value
	data.raw.projectile["laserrifle-projectile-1"].animation.tint = {r=r, g=g, b=b}
	data.raw.projectile["laserrifle-projectile-2"].animation.tint = {r=r, g=g, b=b}
	data.raw.projectile["laserrifle-projectile-3"].animation.tint = {r=r, g=g, b=b}
	data.raw.item["laserrifle-charger"].icons = {{icon="__laser_rifle__/charger2.png",tint={r=r, g=g, b=b}},{icon="__laser_rifle__/charger3.png",tint={r=1.0, g=1.0, b=1.0}}}
	data.raw["battery-equipment"]["laserrifle-charger"].sprite =
    {layers={{
      filename = "__laser_rifle__/charger2.png",
      width = 144,
      height = 144,
      priority = "medium",
	  tint={r=r, g=g, b=b}
    },{
      filename = "__laser_rifle__/charger3.png",
      width = 144,
      height = 144,
      priority = "medium",
	  tint={r=1.0, g=1.0, b=1.0}
    }}}
	if r+g+b < 1.2 and (r<0.4 and g<0.4 and b<0.4)  then
		data.raw.projectile["laserrifle-projectile-1"].animation.blend_mode = "normal"
		data.raw.projectile["laserrifle-projectile-2"].animation.blend_mode = "normal"
		data.raw.projectile["laserrifle-projectile-3"].animation.blend_mode = "normal"
	end
end