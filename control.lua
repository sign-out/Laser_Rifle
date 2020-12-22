TICKS_PER_UPDATE = 20 --*3 (per 3rd tick)
ENERGY_PER_CHARGE = 749998 -- wtf 500k is buggy?
script.on_init(function()
	for _, force in pairs(game.forces) do
		if force.technologies["laser-rifle-1"].researched == true then
			force.recipes["laserrifle"].enabled = true
		end
	end
	if string.sub(game.active_mods["base"],1,4) == "0.16" then
		global.player_main = defines.inventory.player_main
		global.player_ammo = defines.inventory.player_ammo
		global.player_guns = defines.inventory.player_guns
	else
		global.player_main = defines.inventory.character_main
		global.player_ammo = defines.inventory.character_ammo
		global.player_guns = defines.inventory.character_guns
	end
end)

script.on_configuration_changed(function()
	if string.sub(game.active_mods["base"],1,4) == "0.16" then
		global.player_main = defines.inventory.player_main
		global.player_ammo = defines.inventory.player_ammo
		global.player_guns = defines.inventory.player_guns
	else
		global.player_main = defines.inventory.character_main
		global.player_ammo = defines.inventory.character_ammo
		global.player_guns = defines.inventory.character_guns
	end
end)

script.on_event(defines.events.on_player_ammo_inventory_changed, function(event)
	if global.techlevels and global.techlevels[game.players[event.player_index].force.name] then-- and not game.players[event.player_index].get_inventory(defines.inventory.player_ammo).find_item_stack("laser-ammo-"..global.techlevels[game.players[event.player_index].force.name]) then
		if game.players[event.player_index].cursor_stack.valid_for_read and string.sub(game.players[event.player_index].cursor_stack.name,1,11)=="laser-ammo-" then
			game.players[event.player_index].cursor_stack.clear()
		else
			local techlevel = global.techlevels[game.players[event.player_index].force.name]
			local stack = game.players[event.player_index].get_inventory(global.player_main).find_item_stack("laser-ammo-"..techlevel)
			if stack then
				stack.clear()
			end
		end
	end
end)


function table_length(tbl)
	if tbl == nil then
		return 0
	else
		local count = 0
		for _ in pairs(tbl) do
			count = count + 1
		end
		return count	
	end
end

script.on_nth_tick(3, function(event)
	local temp_count = table_length(game.connected_players )
	local i

	local player_count = math.floor((temp_count+(global.tick_delayer or 0))/TICKS_PER_UPDATE)
	if not (player_count > 0) then
		global.tick_delayer = (global.tick_delayer or 0) + temp_count
	else
		global.tick_delayer = 0
		
		if not global.iterate_players then
			global.iterate_players = next(game.connected_players,global.iterate_players)
		elseif not game.connected_players[global.iterate_players] then
			global.iterate_players = nil
		end
		i = 0
		--maxruns = math.min(1,player_count) --max 20/s
		while i< player_count and global.iterate_players do 	
			if game.connected_players[global.iterate_players].character then
				local player = game.connected_players [global.iterate_players]
				local techlevel = 0
				if player.force.technologies["laser-rifle-1"].researched then
					techlevel = 1
					if player.force.technologies["laser-rifle-2"].researched then
						techlevel = 2
						if player.force.technologies["laser-rifle-3"].researched then
							techlevel = 3
						end
					end
					if not global.techlevels then
						global.techlevels = {}
					end
					global.techlevels[player.force.name] = techlevel
					if player.character and player.character.grid then
						local energy = 0
						local modules = 0
						for _, eq in pairs(player.character.grid.equipment) do
							if eq.name == "laserrifle-charger" then
								energy = energy+eq.energy
								modules = modules+1
								--player.print(eq.energy)
							end
						end
						--player.print(energy.." >= ".. ENERGY_PER_CHARGE/(2.5-techlevel*0.5))
						if energy >= ENERGY_PER_CHARGE/(2.5-techlevel*0.5) then
							local gun, pos =  player.get_inventory(global.player_guns).find_item_stack("laserrifle")
							if gun then
								local count = 0
								local inserted = 0
								if not player.get_inventory(global.player_ammo)[pos].valid_for_read then
									inserted = math.min(50-count,math.floor(energy/(ENERGY_PER_CHARGE/(2.5-techlevel*0.5))))
									player.get_inventory(global.player_ammo)[pos].set_stack{name = "laser-ammo-"..techlevel, count = 1,ammo=inserted}
								elseif string.sub(player.get_inventory(global.player_ammo)[pos].name,1,11) == "laser-ammo-" then
									count = player.get_inventory(global.player_ammo)[pos].ammo
									if player.get_inventory(global.player_ammo)[pos].name ~= "laser-ammo-"..techlevel then
										player.get_inventory(global.player_ammo)[pos].set_stack{name = "laser-ammo-"..techlevel, count = count}
									end
									inserted = math.min(50-count,math.floor(energy/(ENERGY_PER_CHARGE/(2.5-techlevel*0.5))))
									if count <50 then
										player.get_inventory(global.player_ammo)[pos].ammo=count+inserted
									end
								end
								if inserted > 0 then
									for _, eq in pairs(player.character.grid.equipment) do
										if eq.name == "laserrifle-charger" then
											eq.energy = eq.energy - inserted*(ENERGY_PER_CHARGE/(2.5-techlevel*0.5))/modules
										end
									end
								end
							end
						end
					end
				end
			end
			global.iterate_players = next(game.connected_players,global.iterate_players)	--iterating...
			if not global.iterate_players then
				global.iterate_players = next(game.connected_players,global.iterate_players)
			end
			i=i+1
		end
	end
			
end)