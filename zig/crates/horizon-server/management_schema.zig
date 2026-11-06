//! Transpiled from Horizon Rust crate
//! Module: horizon-server_management_schema
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What vanilla's management protocol offers, as `rpc.discover` describes it (OpenRPC 1.3.2): every method
//! vanilla 26.3 registers (`IncomingRpcMethods`, `OutgoingRpcMethods`) with its parameter and result, and the
//! schemas they name (`api/Schema`). `tools/test_management_protocol_parity.py` compares the document with
//! the one vanilla's data generator writes (`reports/json-rpc-api-schema.json`).

// use serde_json::{Value, json};

/// A method: its name under `minecraft:`, its description, its parameter and its result (none for a
/// notification), each a name and a schema. A schema is `boolean`, `integer`, `number` or `string`,
/// `#name` for one of [`components`], or `[schema]` for an array of them.
    // rust: pub type Method = (
    // rust: &'static str,
    // rust: &'static str,
    // rust: Option<(&'static str, &'static str)>,
    // rust: Option<(&'static str, &'static str)>,
    // rust: );

/// In vanilla's order: what clients call, then the notifications the server sends.
    // rust: pub const METHODS: &[Method] = &[
    // rust: ("allowlist", "Get the allowlist", None, Some(("allowlist", "[#player]"))),
    // rust: ("allowlist/set", "Set the allowlist", Some(("players", "[#player]")), Some(("allowlist", "[#player]"))),
    // rust: ("allowlist/add", "Add players to allowlist", Some(("add", "[#player]")), Some(("allowlist", "[#player]"))),
    // rust: ("allowlist/remove", "Remove players from allowlist", Some(("remove", "[#player]")), Some(("allowlist", "[#player]"))),
    // rust: ("allowlist/clear", "Clear all players in allowlist", None, Some(("allowlist", "[#player]"))),
    // rust: ("bans", "Get the ban list", None, Some(("banlist", "[#user_ban]"))),
    // rust: ("bans/set", "Set the banlist", Some(("bans", "[#user_ban]")), Some(("banlist", "[#user_ban]"))),
    // rust: ("bans/add", "Add players to ban list", Some(("add", "[#user_ban]")), Some(("banlist", "[#user_ban]"))),
    // rust: ("bans/remove", "Remove players from ban list", Some(("remove", "[#player]")), Some(("banlist", "[#user_ban]"))),
    // rust: ("bans/clear", "Clear all players in ban list", None, Some(("banlist", "[#user_ban]"))),
    // rust: ("ip_bans", "Get the ip ban list", None, Some(("banlist", "[#ip_ban]"))),
    // rust: ("ip_bans/set", "Set the ip banlist", Some(("banlist", "[#ip_ban]")), Some(("banlist", "[#ip_ban]"))),
    // rust: ("ip_bans/add", "Add ip to ban list", Some(("add", "[#incoming_ip_ban]")), Some(("banlist", "[#ip_ban]"))),
    // rust: ("ip_bans/remove", "Remove ip from ban list", Some(("ip", "[string]")), Some(("banlist", "[#ip_ban]"))),
    // rust: ("ip_bans/clear", "Clear all ips in ban list", None, Some(("banlist", "[#ip_ban]"))),
    // rust: ("players", "Get all connected players", None, Some(("players", "[#player]"))),
    // rust: ("players/kick", "Kick players", Some(("kick", "[#kick_player]")), Some(("kicked", "[#player]"))),
    // rust: ("operators", "Get all oped players", None, Some(("operators", "[#operator]"))),
    // rust: ("operators/set", "Set all oped players", Some(("operators", "[#operator]")), Some(("operators", "[#operator]"))),
    // rust: ("operators/add", "Op players", Some(("add", "[#operator]")), Some(("operators", "[#operator]"))),
    // rust: ("operators/remove", "Deop players", Some(("remove", "[#player]")), Some(("operators", "[#operator]"))),
    // rust: ("operators/clear", "Deop all players", None, Some(("operators", "[#operator]"))),
    // rust: ("server/status", "Get server status", None, Some(("status", "#server_state"))),
    // rust: ("server/save", "Save server state", Some(("flush", "boolean")), Some(("saving", "boolean"))),
    // rust: ("server/stop", "Stop server", None, Some(("stopping", "boolean"))),
    // rust: ("server/system_message", "Send a system message", Some(("message", "#system_message")), Some(("sent", "boolean"))),
    // rust: ("serversettings/autosave", "Get whether automatic world saving is enabled on the server", None, Some(("enabled", "boolean"))),
    // rust: ("serversettings/autosave/set", "Enable or disable automatic world saving on the server", Some(("enable", "boolean")), Some(("enabled", "boolean"))),
    // rust: ("serversettings/difficulty", "Get the current difficulty level of the server", None, Some(("difficulty", "#difficulty"))),
    // rust: ("serversettings/difficulty/set", "Set the difficulty level of the server", Some(("difficulty", "#difficulty")), Some(("difficulty", "#difficulty"))),
    // rust: ("serversettings/enforce_allowlist", "Get whether allowlist enforcement is enabled (kicks players immediately when removed from allowlist)", None, Some(("enforced", "boolean"))),
    // rust: ("serversettings/enforce_allowlist/set", "Enable or disable allowlist enforcement (when enabled, players are kicked immediately upon removal from allowlist)", Some(("enforce", "boolean")), Some(("enforced", "boolean"))),
    // rust: ("serversettings/use_allowlist", "Get whether the allowlist is enabled on the server", None, Some(("used", "boolean"))),
    // rust: ("serversettings/use_allowlist/set", "Enable or disable the allowlist on the server (controls whether only allowlisted players can join)", Some(("use", "boolean")), Some(("used", "boolean"))),
    // rust: ("serversettings/max_players", "Get the maximum number of players allowed to connect to the server", None, Some(("max", "integer"))),
    // rust: ("serversettings/max_players/set", "Set the maximum number of players allowed to connect to the server", Some(("max", "integer")), Some(("max", "integer"))),
    // rust: ("serversettings/pause_when_empty_seconds", "Get the number of seconds before the game is automatically paused when no players are online", None, Some(("seconds", "integer"))),
    // rust: ("serversettings/pause_when_empty_seconds/set", "Set the number of seconds before the game is automatically paused when no players are online", Some(("seconds", "integer")), Some(("seconds", "integer"))),
    // rust: ("serversettings/player_idle_timeout", "Get the number of seconds before idle players are automatically kicked from the server", None, Some(("seconds", "integer"))),
    // rust: ("serversettings/player_idle_timeout/set", "Set the number of seconds before idle players are automatically kicked from the server", Some(("seconds", "integer")), Some(("seconds", "integer"))),
    // rust: ("serversettings/allow_flight", "Get whether flight is allowed for players in Survival mode", None, Some(("allowed", "boolean"))),
    // rust: ("serversettings/allow_flight/set", "Allow or disallow flight for players in Survival mode", Some(("allow", "boolean")), Some(("allowed", "boolean"))),
    // rust: ("serversettings/motd", "Get the server's message of the day displayed to players", None, Some(("message", "string"))),
    // rust: ("serversettings/motd/set", "Set the server's message of the day displayed to players", Some(("message", "string")), Some(("message", "string"))),
    // rust: ("serversettings/spawn_protection_radius", "Get the spawn protection radius in blocks (only operators can edit within this area)", None, Some(("radius", "integer"))),
    // rust: ("serversettings/spawn_protection_radius/set", "Set the spawn protection radius in blocks (only operators can edit within this area)", Some(("radius", "integer")), Some(("radius", "integer"))),
    // rust: ("serversettings/force_game_mode", "Get whether players are forced to use the server's default game mode", None, Some(("forced", "boolean"))),
    // rust: ("serversettings/force_game_mode/set", "Enable or disable forcing players to use the server's default game mode", Some(("force", "boolean")), Some(("forced", "boolean"))),
    // rust: ("serversettings/game_mode", "Get the server's default game mode", None, Some(("mode", "#game_type"))),
    // rust: ("serversettings/game_mode/set", "Set the server's default game mode", Some(("mode", "#game_type")), Some(("mode", "#game_type"))),
    // rust: ("serversettings/view_distance", "Get the server's view distance in chunks", None, Some(("distance", "integer"))),
    // rust: ("serversettings/view_distance/set", "Set the server's view distance in chunks", Some(("distance", "integer")), Some(("distance", "integer"))),
    // rust: ("serversettings/simulation_distance", "Get the server's simulation distance in chunks", None, Some(("distance", "integer"))),
    // rust: ("serversettings/simulation_distance/set", "Set the server's simulation distance in chunks", Some(("distance", "integer")), Some(("distance", "integer"))),
    // rust: ("serversettings/accept_transfers", "Get whether the server accepts player transfers from other servers", None, Some(("accepted", "boolean"))),
    // rust: ("serversettings/accept_transfers/set", "Enable or disable accepting player transfers from other servers", Some(("accept", "boolean")), Some(("accepted", "boolean"))),
    // rust: ("serversettings/status_heartbeat_interval", "Get the interval in seconds between server status heartbeats", None, Some(("seconds", "integer"))),
    // rust: ("serversettings/status_heartbeat_interval/set", "Set the interval in seconds between server status heartbeats", Some(("seconds", "integer")), Some(("seconds", "integer"))),
    // rust: ("serversettings/operator_user_permission_level", "Get default operator permission level", None, Some(("level", "integer"))),
    // rust: ("serversettings/operator_user_permission_level/set", "Set default operator permission level", Some(("level", "integer")), Some(("level", "integer"))),
    // rust: ("serversettings/hide_online_players", "Get whether the server hides online player information from status queries", None, Some(("hidden", "boolean"))),
    // rust: ("serversettings/hide_online_players/set", "Enable or disable hiding online player information from status queries", Some(("hide", "boolean")), Some(("hidden", "boolean"))),
    // rust: ("serversettings/status_replies", "Get whether the server responds to connection status requests", None, Some(("enabled", "boolean"))),
    // rust: ("serversettings/status_replies/set", "Enable or disable the server responding to connection status requests", Some(("enable", "boolean")), Some(("enabled", "boolean"))),
    // rust: ("serversettings/entity_broadcast_range", "Get the entity broadcast range as a percentage", None, Some(("percentage_points", "integer"))),
    // rust: ("serversettings/entity_broadcast_range/set", "Set the entity broadcast range as a percentage", Some(("percentage_points", "integer")), Some(("percentage_points", "integer"))),
    // rust: ("gamerules", "Get the available game rule keys and their current values", None, Some(("gamerules", "[#typed_game_rule]"))),
    // rust: ("gamerules/update", "Update game rule value", Some(("gamerule", "#untyped_game_rule")), Some(("gamerule", "#typed_game_rule"))),
    // rust: ("notification/server/started", "Server started", None, None),
    // rust: ("notification/server/stopping", "Server shutting down", None, None),
    // rust: ("notification/server/saving", "Server save started", None, None),
    // rust: ("notification/server/saved", "Server save completed", None, None),
    // rust: ("notification/server/activity", "Server activity occurred. Rate limited to 1 notification per 30 seconds", None, None),
    // rust: ("notification/world/upgrade_started", "World upgrade started", None, None),
    // rust: ("notification/world/upgrade_progress", "World upgrade progress. Rate limited to 1 notification per second", Some(("progress", "number")), None),
    // rust: ("notification/world/upgrade_finished", "World upgrade finished", None, None),
    // rust: ("notification/world/upgrade_failed", "World upgrade failed", Some(("reason", "string")), None),
    // rust: ("notification/players/joined", "Player joined", Some(("player", "#player")), None),
    // rust: ("notification/players/left", "Player left", Some(("player", "#player")), None),
    // rust: ("notification/operators/added", "Player was oped", Some(("player", "#operator")), None),
    // rust: ("notification/operators/removed", "Player was deoped", Some(("player", "#operator")), None),
    // rust: ("notification/allowlist/added", "Player was added to allowlist", Some(("player", "#player")), None),
    // rust: ("notification/allowlist/removed", "Player was removed from allowlist", Some(("player", "#player")), None),
    // rust: ("notification/ip_bans/added", "Ip was added to ip ban list", Some(("player", "#ip_ban")), None),
    // rust: ("notification/ip_bans/removed", "Ip was removed from ip ban list", Some(("player", "string")), None),
    // rust: ("notification/bans/added", "Player was added to ban list", Some(("player", "#user_ban")), None),
    // rust: ("notification/bans/removed", "Player was removed from ban list", Some(("player", "#player")), None),
    // rust: ("notification/gamerules/updated", "Gamerule was changed", Some(("gamerule", "#typed_game_rule")), None),
    // rust: ("notification/server/status", "Server status heartbeat, including before the server has spun up", Some(("status", "#server_state")), None),
    // rust: ];

pub fn schema(spec: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(inner) = spec.strip_prefix('[').and_then(|s| s.strip_suffix(']')) {
    // rust: json!({ "type": "array", "items": schema(inner) })
    // rust: } else if let Some(name) = spec.strip_prefix('#') {
    // rust: json!({ "$ref": format!("#/components/schemas/{name}") })
    // rust: } else {
    // rust: json!({ "type": spec })
}
}

/// The schemas methods refer to by `#name`.
pub fn components() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let string = || json!({ "type": "string" });
    // rust: let player = || schema("#player");
    // rust: let ban = |extra: (&str, Value)| {
    // rust: let mut b = json!({ "expires": string(), "reason": string(), "source": string() });
    // rust: b[extra.0] = extra.1;
    // rust: b
}
    // rust: let both = json!(["boolean", "integer"]);
    // rust: json!({
    // rust: "difficulty": { "type": "string", "enum": ["peaceful", "easy", "normal", "hard"] },
    // rust: "game_type": { "type": "string", "enum": ["survival", "creative", "adventure", "spectator"] },
    // rust: "incoming_ip_ban": { "type": "object", "properties": {
    // rust: "expires": string(), "ip": string(), "player": player(), "reason": string(), "source": string(),
    // rust: } },
    // rust: "ip_ban": { "type": "object", "properties": ban(("ip", string())) },
    // rust: "kick_player": { "type": "object", "properties": {
    // rust: "message": schema("#message"), "player": player(),
    // rust: } },
    // rust: "message": { "type": "object", "properties": {
    // rust: "literal": string(), "translatable": string(), "translatableParams": schema("[string]"),
    // rust: } },
    // rust: "operator": { "type": "object", "properties": {
    // rust: "bypassesPlayerLimit": schema("boolean"), "permissionLevel": schema("integer"), "player": player(),
    // rust: } },
    // rust: "player": { "type": "object", "properties": { "id": string(), "name": string() } },
    // rust: "server_state": { "type": "object", "properties": {
    // rust: "players": schema("[#player]"), "started": schema("boolean"), "version": schema("#version"),
    // rust: } },
    // rust: "system_message": { "type": "object", "properties": {
    // rust: "message": schema("#message"), "overlay": schema("boolean"), "receivingPlayers": schema("[#player]"),
    // rust: } },
    // rust: "typed_game_rule": { "type": "object", "properties": {
    // rust: "type": { "type": "string", "enum": ["integer", "boolean"] }, "key": string(), "value": { "type": both },
    // rust: } },
    // rust: "untyped_game_rule": { "type": "object", "properties": { "key": string(), "value": { "type": both } } },
    // rust: "user_ban": { "type": "object", "properties": ban(("player", player())) },
    // rust: "version": { "type": "object", "properties": { "name": string(), "protocol": schema("integer") } },
    // rust: })
}

/// `rpc.discover`'s result.
pub fn discover() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let methods: Vec<Value> = METHODS
    // rust: .iter()
    // rust: .map(|(name, description, param, result)| {
    // rust: let mut m = json!({
    // rust: "name": format!("minecraft:{name}"),
    // rust: "description": description,
    // rust: "params": param.map_or_else(Vec::new, |(name, spec)| {
    // rust: vec![json!({ "name": name, "required": true, "schema": schema(spec) })]
    // rust: }),
    // rust: });
    // rust: if let Some((name, spec)) = result {
    // rust: m["result"] = json!({ "name": name, "schema": schema(spec) });
}
    // rust: m
    // rust: })
    // rust: .collect();
    // rust: json!({
    // rust: "openrpc": "1.3.2",
    // rust: "info": { "title": "Minecraft Server JSON-RPC", "version": "3.1.0" },
    // rust: "methods": methods,
    // rust: "components": { "schemas": components() },
    // rust: })
}

/// A method clients may call (not a notification), by its full name.
pub fn incoming(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let short = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: METHODS
    // rust: .iter()
    // rust: .find(|m| m.0 == short && !m.0.starts_with("notification/"))
}
