local flib_migration = require("__flib__.migration")


local migrations_table = {
	["0.2.1"] = function()
		---@type MapData
		local map_data = global
		for id, station in pairs(map_data.stations) do
			station.p_threshold = nil
		end
	end,
	["0.3.0"] = function()
		---@type MapData
		local map_data = global
		map_data.warmup_station_ids = {}
		map_data.active_station_ids = map_data.all_station_ids
		map_data.all_station_ids = nil
		mod_settings.warmup_time = settings.global["cybersyn-warmup-time"].value--[[@as int]]
	end,
	["0.4.0"] = function()
		---@type MapData
		local map_data = global
		map_data.is_player_cursor_blueprint = {}
		map_data.to_comb_params = {}
		for id, comb in pairs(map_data.to_comb) do
			map_data.to_comb_params[id] = get_comb_params(comb)
		end
	end,
	["0.4.1"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		for id, station in pairs(map_data.stations) do
			station.allows_all_trains = station.allow_all_trains or station.allows_all_trains
			station.allow_all_trains = nil
		end
	end,
	["0.4.2"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.available_trains = map_data.trains_available
		for id, train in pairs(map_data.trains) do
			local depot = train.depot
			if depot then
				train.parked_at_depot_id = depot.entity_comb.unit_number
				train.network_name = depot.network_name
				train.network_flag = depot.network_flag
				train.priority = depot.priority
			else
				train.network_name = ""
				train.network_flag = 0
				train.priority = 0
			end
		end
		for id, depot in pairs(map_data.depots) do
			map_data.depots[id] = {
				entity_comb = depot.entity_comb,
				entity_stop = depot.entity_stop,
				available_train_id = depot.available_train,
			}
		end
	end,
	["0.4.3"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		for id, station in pairs(map_data.stations) do
			set_station_from_comb_state(station)
			station.allow_all_trains = nil
		end
		for id, train in pairs(map_data.trains) do
			train.last_manifest_tick = map_data.total_ticks
		end
		mod_settings.stuck_train_time = settings.global["cybersyn-stuck-train-time"].value--[[@as int]]
	end,
	["0.4.4"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		for id, layout in pairs(map_data.layouts) do
			local new_layout = {}
			local i = 1
			for c in string.gmatch(layout, ".") do
				if c == "N" then
				elseif c == "C" then
					new_layout[i] = 1
				elseif c == "F" then
					new_layout[i] = 2
				end
				i = i + 1
			end
			map_data.layouts[id] = new_layout
		end
	end,
	["0.5.1"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.is_player_cursor_blueprint = nil
		for id, layout in pairs(map_data.layouts) do
			local new_layout = {}
			local max_i = 0
			for i, v in pairs(layout) do
				new_layout[i] = v
				if i > max_i then
					max_i = i
				end
			end
			for i = 1, max_i do
				if new_layout[i] == nil then
					new_layout[i] = 0
				end
			end
			map_data.layouts[id] = new_layout
		end
		for id, station in pairs(map_data.stations) do
			reset_station_layout(map_data, station)
		end
	end,
	["1.0.3"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.tick_data = {}
	end,
	["1.0.6"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.tick_data = {}
		for k, v in pairs(map_data.available_trains) do
			for id, _ in pairs(v) do
				local train = map_data.trains[id]
				train.is_available = true
			end
		end
		for k, v in pairs(map_data.trains) do
			v.depot = nil
			if not v.is_available then
				v.depot_id = nil
			end
		end
	end,
	["1.0.7"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.tick_data = {}
		map_data.available_trains = {}
		for id, v in pairs(map_data.trains) do
			v.parked_at_depot_id = v.depot_id
			v.depot_id = nil
			v.se_is_being_teleported = not v.entity and true or nil
			--NOTE: we are guessing here because this information was never saved
			v.se_depot_surface_i = v.entity.front_stock.surface.index
			v.is_available = nil
			if v.parked_at_depot_id and v.network_name then
				local network = map_data.available_trains[v.network_name--[[@as string]]]
				if not network then
					network = {}
					map_data.available_trains[v.network_name--[[@as string]]] = network
				end
				network[id] = true
				v.is_available = true
			end
		end
	end,
	["1.0.8"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.tick_data = {}
		for id, station in pairs(map_data.stations) do
			local params = get_comb_params(station.entity_comb1)
			if params.operation == OPERATION_PRIMARY_IO_FAILED_REQUEST then
				station.display_state = 1
			elseif params.operation == OPERATION_PRIMARY_IO_ACTIVE then
				station.display_state = 2
			else
				station.display_state = 0
			end
			station.display_failed_request = nil
			station.update_display = nil
		end
	end,
	["1.0.10"] = function()
		---@type MapData
		local map_data = global
		map_data.tick_state = STATE_INIT
		map_data.tick_data = {}
		for id, station in pairs(map_data.stations) do
			station.p_count_or_r_threshold_per_item = nil
		end
	end,
}

---@param data ConfigurationChangedData
function on_config_changed(data)
	flib_migration.on_config_changed(data, migrations_table)

	IS_SE_PRESENT = remote.interfaces["space-exploration"] ~= nil
	if IS_SE_PRESENT and not global.se_tele_old_id then
		global.se_tele_old_id = {}
	end
end
