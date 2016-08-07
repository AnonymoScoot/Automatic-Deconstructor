
local Line = {}
Line["transport-belt"] = true
Line["underground-belt"] = true
Line["splitter"] = true

local Excludes = {}
Excludes["inserter"] = true

function InsertItem( inv, ent, player )

	local item = ent.get_inventory(inv).get_item_count()

	if not ent.get_inventory(inv).is_empty() then
	
		for i, c in pairs ( ent.get_inventory(inv).get_contents() ) do
			
			for n = 1,c do
		
				if player.get_inventory(1).can_insert( { name = i, count = 1 } ) then
				
					player.insert( { name = i, count = 1 } )
				
					ent.get_inventory(inv).remove( { name = i, count = 1 } )
				
				else
				
					player.print( "Inventory is full, can't insert "..i )
				
					return
				
				end
			
			end
		
		end
	
	end

end
--/c game.player.insert{name="automatic-deconstructor",count="1"}

function HandleLine( line, ent, player )

	local item = ent.get_transport_line(line).get_item_count()
	
	if item ~= nil then
	
		for i, c in pairs ( ent.get_transport_line(line).get_contents() ) do
			
			for n = 1,c do
		
				if player.get_inventory(1).can_insert( { name = i, count = 1 } ) then
				
					player.insert( { name = i, count = 1 } )
				
					ent.get_transport_line(line).remove_item( { name = i, count = 1 } )
				
				else
				
					player.print( "Inventory is full, can't insert "..i )
				
					return
				
				end
			
			end
		
		end
	
	end

end

function Deconstruct( event )

	local player = game.players[event.player_index]

	if ( player.cursor_stack.valid_for_read == true ) and
	   ( ( player.cursor_stack.name ~= "automatic-deconstructor" ) or
	   ( event.entity.name == "deconstructible-tile-proxy" ) )
	   then 
	
		return 
	
	end
	
	local ent = event.entity
	
	if ent.type == "item-entity" then
	
		if player.get_inventory(1).can_insert( { name = ent.stack.name, count = 1 } ) then
		
			player.insert( { name = ent.stack.name, count = 1 } )
		
			ent.destroy()
			
		else
		
			player.print("Inventory is full, can't insert "..ent.stack.name)
		
			return
		
		end
		
		return
	
	end
	
	if ent.minable then
	
		local result = ent.prototype.mineable_properties.products[1].name
		local result_count = ent.prototype.mineable_properties.products[1].amount_min
		
		if Line[ent.type] == true then
		
			if ent.has_items_inside() then
			
				for i = 1, 2 do
				
					if ent.get_transport_line(i) ~= nil then
				
						HandleLine( i, ent, player )
					
					end
					
				end
			
				GrabLineEntity( ent, player, result, result_count )
				
			
			else
			
				GrabLineEntity( ent, player, result, result_count )
			
			
			end
		
			return
		
		end
		
		if ent.has_items_inside() then
	
			for i = 1, 6 do
			
				if ent.get_inventory(i) ~= nil then
			
					InsertItem( i, ent, player )
				
				end
				
			end
			
			GrabEntity( ent, player, result, result_count )
			
		else
		
			GrabEntity( ent, player, result, result_count )
		
		end
		
	end

end

function GrabLineEntity( ent, player, result, result_count )

	if player.get_inventory(1).can_insert( { name = result, count = result_count } ) then

		player.insert( { name = result, count = result_count } )
	
		ent.destroy()
	
	else

		player.print("Inventory is full, can't insert "..result)

	end

end

function GrabEntity( ent, player, result, result_count )

	if Excludes[ent.type] == true then

		if player.get_inventory(1).can_insert( { name = result, count = result_count } ) then

			player.insert( { name = result, count = result_count } )
		
			ent.destroy()
		
		else

			player.print("Inventory is full, can't insert "..result)

		end
	
		return
		
	end
	
	if player.get_inventory(1).can_insert( { name = result, count = result_count } ) and
	   ent.has_items_inside() == false
	then

		player.insert( { name = result, count = result_count } )
	
		ent.destroy()
	
	else

		player.print("Inventory is full, can't insert "..result)

	end

end

script.on_event( defines.events.on_marked_for_deconstruction, Deconstruct )
