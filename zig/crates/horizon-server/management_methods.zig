//! Transpiled from Horizon Rust crate
//! Module: horizon-server_management_methods
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The methods of vanilla's management protocol (`management.rs`), as vanilla 26.3's `methods/*Service` answer
//! them: the players, the server's state, and the lists. Kicks, saves and messages go through the game's
//! console, so they log and save as an operator's command would; the lists change through the game's
//! `management` request (game/dedicated/management.rs), which finds the players and sends the shut-out away as
//! vanilla's services do.

// use crate::{
    // rust: api::{Phase, Shared},
    // rust: engine,
    // rust: management::{self, Failure, INTERNAL_ERROR, invalid_params},
}
// use horizon_server_files::properties::{ServerProperties, SystemEntropy};
// use serde_json::{Value, json};
// use std::path::Path;

/// A method's result (`short`: its name without `minecraft:`).
pub fn call(shared: *Shared, client: u32, short: []const u8, argument: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (game, lists) = (Game { shared }, Lists(&shared.dir));
    // rust: let edit = |entries: Vec<Value>| game.edit(client, short, entries);
    // rust: match short {
    // rust: "players" => Ok(Value::Array(game.online()?)),
    // rust: "players/kick" => game.kick(argument),
    // rust: "server/status" => Ok(game.status()),
    // rust: "server/save" => {
    // rust: let flush = argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params("Not a boolean"))?;
    // rust: game.console(if flush { "save-all flush" } else { "save-all" })?;
    // rust: Ok(json!(true))
}
        // `ServerStateService.stop` submits `MinecraftServer.halt(false)`: the server stops and its process exits.
    // rust: "server/stop" => {
    // rust: shared.shut_down();
    // rust: Ok(json!(true))
}
    // rust: "server/system_message" => game.system_message(argument),
    // rust: "serversettings/autosave" => game.autosave(client, None),
    // rust: "serversettings/autosave/set" => game.autosave(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/pause_when_empty_seconds" => game.pause_when_empty_seconds(client, None),
    // rust: "serversettings/pause_when_empty_seconds/set" => game.pause_when_empty_seconds(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: .ok_or_else(|| invalid_params(format!("Not a number: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "gamerules" => game.gamerules(client, None),
    // rust: "gamerules/update" => game.gamerules(client, Some(argument)),
    // rust: "serversettings/motd" => game.motd(client, None),
    // rust: "serversettings/motd/set" => game.motd(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid_params("Not a string"))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/difficulty" => game.difficulty(client, None),
    // rust: "serversettings/difficulty/set" => game.difficulty(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid_params("Not a string"))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/game_mode" => game.game_mode(client, None),
    // rust: "serversettings/game_mode/set" => game.game_mode(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid_params("Not a string"))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/view_distance" => game.view_distance(client, None),
    // rust: "serversettings/view_distance/set" => {
    // rust: game.view_distance(client, Some(management_int(argument)?))
}
    // rust: "serversettings/simulation_distance" => game.simulation_distance(client, None),
    // rust: "serversettings/simulation_distance/set" => {
    // rust: game.simulation_distance(client, Some(management_int(argument)?))
}
    // rust: "serversettings/entity_broadcast_range" => game.entity_broadcast_range(client, None),
    // rust: "serversettings/entity_broadcast_range/set" => {
    // rust: game.entity_broadcast_range(client, Some(management_int(argument)?))
}
    // rust: "serversettings/operator_user_permission_level" => {
    // rust: game.operator_user_permission_level(client, None)
}
    // rust: "serversettings/operator_user_permission_level/set" => {
    // rust: game.operator_user_permission_level(client, Some(management_int(argument)?))
}
    // rust: "serversettings/force_game_mode" => game.force_game_mode(client, None),
    // rust: "serversettings/force_game_mode/set" => game.force_game_mode(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/spawn_protection_radius" => game.spawn_protection_radius(client, None),
    // rust: "serversettings/spawn_protection_radius/set" => {
    // rust: game.spawn_protection_radius(client, Some(management_int(argument)?))
}
    // rust: "serversettings/allow_flight" => game.allow_flight(client, None),
    // rust: "serversettings/allow_flight/set" => game.allow_flight(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/hide_online_players" => game.hide_online_players(client, None),
    // rust: "serversettings/hide_online_players/set" => game.hide_online_players(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/status_heartbeat_interval" => {
    // rust: Ok(json!(management::heartbeat_seconds(shared)))
}
    // rust: "serversettings/status_heartbeat_interval/set" => {
    // rust: status_heartbeat_interval(shared, management_int(argument)?)
}
    // rust: "serversettings/status_replies" => game.status_replies(client, None),
    // rust: "serversettings/status_replies/set" => game.status_replies(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/accept_transfers" => game.accepts_transfers(client, None),
    // rust: "serversettings/accept_transfers/set" => game.accepts_transfers(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/player_idle_timeout" => game.player_idle_timeout(client, None),
    // rust: "serversettings/player_idle_timeout/set" => {
    // rust: game.player_idle_timeout(client, Some(management_int(argument)?))
}
    // rust: "serversettings/max_players" => game.max_players(client, None),
    // rust: "serversettings/max_players/set" => game.max_players(
    // rust: client,
    // rust: Some(
    // rust: argument
    // rust: .as_i64()
    // rust: .and_then(|value| usize::try_from(value).ok())
    // rust: .ok_or_else(|| invalid_params(format!("Not a number: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/use_allowlist" => game.allowlist_setting(client, "use_allowlist", None),
    // rust: "serversettings/use_allowlist/set" => game.allowlist_setting(
    // rust: client,
    // rust: "use_allowlist",
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "serversettings/enforce_allowlist" => {
    // rust: game.allowlist_setting(client, "enforce_allowlist", None)
}
    // rust: "serversettings/enforce_allowlist/set" => game.allowlist_setting(
    // rust: client,
    // rust: "enforce_allowlist",
    // rust: Some(
    // rust: argument
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {argument}")))?,
    // rust: ),
    // rust: ),
    // rust: "allowlist" => Ok(lists.allowlist()),
    // rust: "bans" => Ok(lists.bans()),
    // rust: "ip_bans" => Ok(lists.ip_bans()),
    // rust: "operators" => Ok(lists.operators()),
    // rust: "allowlist/add" | "allowlist/remove" | "allowlist/set" => {
    // rust: edit(players(argument)?)?;
    // rust: Ok(lists.allowlist())
}
    // rust: "allowlist/clear" => {
    // rust: edit(Vec::new())?;
    // rust: Ok(lists.allowlist())
}
    // rust: "bans/add" | "bans/set" => {
    // rust: let bans = list(argument)?
    // rust: .iter()
    // rust: .map(user_ban)
    // rust: .collect::<Result<_, _>>()?;
    // rust: edit(bans)?;
    // rust: Ok(lists.bans())
}
    // rust: "bans/remove" => {
    // rust: edit(players(argument)?)?;
    // rust: Ok(lists.bans())
}
    // rust: "bans/clear" => {
    // rust: edit(Vec::new())?;
    // rust: Ok(lists.bans())
}
    // rust: "ip_bans/add" | "ip_bans/remove" | "ip_bans/set" | "ip_bans/clear" => {
    // rust: let entries = list_or_none(argument)?;
    // rust: edit(match short {
    // rust: "ip_bans/add" => entries
    // rust: .iter()
    // rust: .map(incoming_ip_ban)
    // rust: .collect::<Result<_, _>>()?,
    // rust: "ip_bans/remove" => entries.iter().map(ip).collect::<Result<_, _>>()?,
    // rust: "ip_bans/set" => entries.iter().map(ip_ban).collect::<Result<_, _>>()?,
    // rust: _ => Vec::new(),
    // rust: })?;
    // rust: Ok(lists.ip_bans())
}
    // rust: "operators/add" | "operators/set" => {
    // rust: edit(
    // rust: list(argument)?
    // rust: .iter()
    // rust: .map(operator)
    // rust: .collect::<Result<_, _>>()?,
    // rust: )?;
    // rust: Ok(lists.operators())
}
    // rust: "operators/remove" => {
    // rust: edit(players(argument)?)?;
    // rust: Ok(lists.operators())
}
    // rust: "operators/clear" => {
    // rust: edit(Vec::new())?;
    // rust: Ok(lists.operators())
}
    // rust: _ => Err((
    // rust: INTERNAL_ERROR,
    // rust: Some(format!("minecraft:{short} isn't in Horizon yet")),
    // rust: )),
}
}

/// `UUIDUtil` writes a UUID as 8-4-4-4-12 lowercase hex digits.
pub fn uuid(id: u128) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = format!("{id:032x}");
    // rust: format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &h[..8],
    // rust: &h[8..12],
    // rust: &h[12..16],
    // rust: &h[16..20],
    // rust: &h[20..]
    // rust: )
}

/// A UUID as `UUID.fromString` takes it (8-4-4-4-12 hex digits), or the 32 undashed digits of `UUIDUtil`'s
/// lenient codec; anything else (a short id, a sign, dashes anywhere) is no UUID.
pub fn parse_uuid(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let digits = match text.len() {
    // rust: 32 => text.to_owned(),
    // rust: 36 => {
    // rust: let parts: Vec<&str> = text.split('-').collect();
    // rust: let lengths: Vec<usize> = parts.iter().map(|p| p.len()).collect();
    // rust: if lengths != [8, 4, 4, 4, 12] {
    // rust: return None;
}
    // rust: parts.concat()
}
    // rust: _ => return None,
}
    // rust: digits
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_hexdigit())
    // rust: .then(|| u128::from_str_radix(&digits, 16).ok())
    // rust: .flatten()
}

/// A `PlayerDto` from a request: an id, a name, or both.
pub fn player_dto(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(object) = value.as_object() else {
    // rust: return Err(invalid_params("Not a player"));
}
    // rust: let id = match object.get("id") {
    // rust: None => None,
    // rust: Some(id) => Some(
    // rust: id.as_str()
    // rust: .and_then(parse_uuid)
    // rust: .ok_or_else(|| invalid_params(format!("Invalid UUID: {id}")))?,
    // rust: ),
}
    // rust: let name = match object.get("name") {
    // rust: None => None,
    // rust: Some(name) => Some(
    // rust: name.as_str()
    // rust: .ok_or_else(|| invalid_params("Not a string: name"))?
    // rust: .to_owned(),
    // rust: ),
}
    // rust: Ok((id, name))
}

pub fn list(argument: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: argument
    // rust: .as_array()
    // rust: .ok_or_else(|| invalid_params("Not a list"))
}

/// `PlayerDto`s, as the game takes them: the id in 32 hex digits.
pub fn players(argument: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: list(argument)?.iter().map(player).collect()
}

pub fn player(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (id, name) = player_dto(value)?;
    // rust: Ok(json!({ "id": id.map(|id| format!("{id:032x}")), "name": name }))
}

/// The list a method takes, or none for a `clear`.
pub fn list_or_none(argument: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match argument {
    // rust: Value::Null => Ok(Vec::new()),
    // rust: _ => list(argument).cloned(),
}
}

/// An optional string field.
pub fn text(value: *Value, key: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value.get(key) {
    // rust: None => Ok(None),
    // rust: Some(v) => v
    // rust: .as_str()
    // rust: .map(|s| Some(s.to_owned()))
    // rust: .ok_or_else(|| invalid_params(format!("Not a string: {v}"))),
}
}

/// What a ban DTO may give: the reason, the source and the end (an ISO-8601 instant, sent in milliseconds).
pub fn ban_terms(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let expires = match text(value, "expires")? {
    // rust: None => None,
    // rust: Some(at) => Some(
    // rust: chrono::DateTime::parse_from_rfc3339(&at)
    // rust: .map_err(|e| invalid_params(format!("Failed to parse instant {at}: {e}")))?
    // rust: .timestamp_millis(),
    // rust: ),
}
    // rust: Ok(
    // rust: json!({ "reason": text(value, "reason")?, "source": text(value, "source")?, "expires": expires }),
    // rust: )
}

/// A `UserBanDto`: the player and the ban's terms.
pub fn user_ban(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(dto) = value.get("player") else {
    // rust: return Err(invalid_params("No key player"));
}
    // rust: let mut ban = ban_terms(value)?;
    // rust: ban["player"] = player(dto)?;
    // rust: Ok(ban)
}

/// An `IncomingIpBanDto`: an address or a player (whose address is banned if online), and the terms.
pub fn incoming_ip_ban(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ban = ban_terms(value)?;
    // rust: ban["ip"] = json!(text(value, "ip")?);
    // rust: if let Some(dto) = value.get("player") {
    // rust: ban["player"] = player(dto)?;
}
    // rust: Ok(ban)
}

/// An `IpBanDto`: the address and the terms.
pub fn ip_ban(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ban = ban_terms(value)?;
    // rust: ban["ip"] = ip(value.get("ip").ok_or_else(|| invalid_params("No key ip"))?)?["ip"].take();
    // rust: Ok(ban)
}

/// An address to unban, as `ip_bans/remove` takes them.
pub fn ip(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ip = value
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid_params(format!("Not a string: {value}")))?;
    // rust: Ok(json!({ "ip": ip }))
}

/// An `OperatorDto`: the player, and the permission level (0 to 4) and bypass when given.
pub fn operator(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(dto) = value.get("player") else {
    // rust: return Err(invalid_params("No key player"));
}
    // rust: let level = match value.get("permissionLevel") {
    // rust: None => None,
    // rust: Some(level) => Some(
    // rust: level
    // rust: .as_i64()
    // rust: .filter(|l| (0..=4).contains(l))
    // rust: .ok_or_else(|| invalid_params(format!("Not a valid permission level: {level}")))?,
    // rust: ),
}
    // rust: let bypass = match value.get("bypassesPlayerLimit") {
    // rust: None => None,
    // rust: Some(b) => Some(
    // rust: b.as_bool()
    // rust: .ok_or_else(|| invalid_params(format!("Not a boolean: {b}")))?,
    // rust: ),
}
    // rust: Ok(json!({ "player": player(dto)?, "permissionLevel": level, "bypassesPlayerLimit": bypass }))
}

/// `Message.asComponent` as a JSON text component; `None` when it has neither text nor key.
pub fn component(message: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(key) = message["translatable"].as_str() {
    // rust: let mut c = json!({ "translate": key });
    // rust: if let Some(with) = message["translatableParams"].as_array() {
    // rust: c["with"] = Value::Array(with.clone());
}
    // rust: return Some(c);
}
    // rust: message["literal"]
    // rust: .as_str()
    // rust: .map(|text| json!({ "text": text }))
}

/// `MinecraftServerSettingsServiceImpl.setStatusHeartbeatInterval`: the supervisor owns the heartbeat, so
/// the new interval takes effect here, and is kept in server.properties and server.toml's `[properties]`
/// (which writes server.properties again at the next start). The answer is the interval now in force: the
/// old one when the heartbeat cannot be rescheduled (`management::set_heartbeat_seconds`), which keeps
/// nothing.
pub fn status_heartbeat_interval(shared: *Shared, seconds: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !management::set_heartbeat_seconds(shared, seconds) {
    // rust: crate::supervisor::note(
    // rust: shared,
    // rust: "WARN",
    // rust: &format!(
    // rust: "The existing heartbeat was not canceled and the new heartbeat of {seconds} seconds has not been applied."
    // rust: ),
    // rust: );
    // rust: crate::supervisor::note(
    // rust: shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "The heartbeat interval was not updated to the new value of {seconds} seconds as the json rpc server is null or a pre-existing heartbeat failed to get canceled"
    // rust: ),
    // rust: );
    // rust: return Ok(json!(management::heartbeat_seconds(shared)));
}
    // rust: let path = shared.dir.join(crate::config::PROPERTIES);
    // rust: let stored = ServerProperties::from_file(&path, &mut SystemEntropy::default())
    // rust: .and_then(|p| p.update("status-heartbeat-interval", seconds.to_string()))
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
    // rust: stored
    // rust: .store(&path)
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e.to_string())))?;
    // rust: crate::config::update(
    // rust: &shared.dir,
    // rust: "properties",
    // rust: "status-heartbeat-interval",
    // rust: toml::Value::Integer(i64::from(seconds)),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
    // Vanilla reads the interval for its log line after setting it, so both numbers are the new one.
    // rust: let now = management::heartbeat_seconds(shared);
    // rust: crate::supervisor::note(
    // rust: shared,
    // rust: "INFO",
    // rust: &format!("Updated status heartbeat interval from {now} to {seconds}"),
    // rust: );
    // rust: Ok(json!(seconds))
}

/// Vanilla's `Codec.INT`: numeric input narrows through `Number.intValue`, including fractions and overflow.
pub fn management_int(value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let parsed = if let Some(number) = value.as_i64() {
    // rust: Some(number as i32)
    // rust: } else if let Some(number) = value.as_u64() {
    // rust: Some(number as i32)
    // rust: } else {
    // rust: value
    // rust: .as_f64()
    // rust: .filter(|number| number.is_finite())
    // rust: .map(|number| {
                // Gson's LazilyParsedNumber falls back to BigDecimal.intValue: truncate, then keep 32 bits.
    // rust: number.trunc().rem_euclid(4_294_967_296.0) as u32 as i32
    // rust: })
}
    // rust: parsed.ok_or_else(|| invalid_params(format!("Not a number: {value}")))
}

/// The running game, through its control endpoint.
pub const Game = struct {
    shared: *'a Shared,
};

    // rust: impl Game<'_> {
    /// `MinecraftServerSettingsServiceImpl.isUsingWhitelist`, `setUsingWhitelist`,
    /// `isEnforceWhitelist` and `setEnforceWhitelist`.
    // rust: fn allowlist_setting(
    // rust: &self,
    // rust: client: u32,
    // rust: setting: &str,
    // rust: value: Option<bool>,
    // rust: ) -> Result<Value, Failure> {
    // rust: let mut request = json!({
    // rust: "method": format!("serversettings/{setting}")
    // rust: });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!(format!("serversettings/{setting}/set"));
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: let property = match setting {
    // rust: "use_allowlist" => "whitelist",
    // rust: "enforce_allowlist" => "enforce_whitelist",
    // rust: _ => unreachable!("allowlist setting is validated by its callers"),
}
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: property,
    // rust: toml::Value::Boolean(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `GameRulesService.get` and `update`: the game's rules as typed rules, or the one `update` set.
pub fn gamerules(self: *Self, client: u32, update: ?*Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "gamerules" });
    // rust: if let Some(update) = update {
    // rust: request["method"] = json!("gamerules/update");
    // rust: request["value"] = update.clone();
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(invalid) = reply["invalid"].as_str() {
    // rust: return Err(invalid_params(invalid));
}
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.isAutoSave`: read the game's live save flag.
    /// `MinecraftServerSettingsServiceImpl.setAutoSave`: update that flag and return its new value.
pub fn autosave(self: *Self, client: u32, value: ?bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/autosave" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/autosave/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getPauseWhenEmptySeconds` and `setPauseWhenEmptySeconds`.
pub fn pause_when_empty_seconds(self: *Self, client: u32, value: ?i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/pause_when_empty_seconds" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/pause_when_empty_seconds/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "pause-when-empty-seconds",
    // rust: toml::Value::Integer(i64::from(value)),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.forceGameMode` and `setForceGameMode`.
pub fn force_game_mode(self: *Self, client: u32, value: ?bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/force_game_mode" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/force_game_mode/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "force-gamemode",
    // rust: toml::Value::Boolean(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getSpawnProtectionRadius` and `setSpawnProtectionRadius`.
pub fn spawn_protection_radius(self: *Self, client: u32, value: ?i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/spawn_protection_radius" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/spawn_protection_radius/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "spawn-protection",
    // rust: toml::Value::Integer(i64::from(value)),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.allowFlight` and `setAllowFlight`.
pub fn allow_flight(self: *Self, client: u32, value: ?bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/allow_flight" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/allow_flight/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "allow-flight",
    // rust: toml::Value::Boolean(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.hidesOnlinePlayers` and `setHidesOnlinePlayers`.
pub fn hide_online_players(self: *Self, client: u32, value: ?bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/hide_online_players" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/hide_online_players/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "hide-online-players",
    // rust: toml::Value::Boolean(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.repliesToStatus` and `setRepliesToStatus`.
pub fn status_replies(self: *Self, client: u32, value: ?bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/status_replies" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/status_replies/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "enable-status",
    // rust: toml::Value::Boolean(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.acceptsTransfers` and `setAcceptsTransfers`.
pub fn accepts_transfers(self: *Self, client: u32, value: ?bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/accept_transfers" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/accept_transfers/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "accepts-transfers",
    // rust: toml::Value::Boolean(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getPlayerIdleTimeout` and `setPlayerIdleTimeout`.
pub fn player_idle_timeout(self: *Self, client: u32, value: ?i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/player_idle_timeout" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/player_idle_timeout/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "player-idle-timeout",
    // rust: toml::Value::Integer(i64::from(value)),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getMaxPlayers` and `setMaxPlayers`.
pub fn max_players(self: *Self, client: u32, value: ?usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/max_players" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/max_players/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "server",
    // rust: "max_players",
    // rust: toml::Value::Integer(value as i64),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getGameMode` and `setGameMode`.
pub fn game_mode(self: *Self, client: u32, value: ?[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/game_mode" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/game_mode/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "world",
    // rust: "game_mode",
    // rust: toml::Value::String(value.into()),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getOperatorUserPermissions` and
    /// `setOperatorUserPermissionLevel`.
    // rust: fn operator_user_permission_level(
    // rust: &self,
    // rust: client: u32,
    // rust: value: Option<i32>,
    // rust: ) -> Result<Value, Failure> {
    // rust: let mut request = json!({
    // rust: "method": "serversettings/operator_user_permission_level"
    // rust: });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/operator_user_permission_level/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: let value = reply["value"].as_i64().unwrap_or(i64::from(value));
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "op-permission-level",
    // rust: toml::Value::Integer(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getMotd` and `setMotd`: the live server-list message.
pub fn motd(self: *Self, client: u32, value: ?[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/motd" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/motd/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
        // server.toml's `motd` writes server.properties' at each start: keep the new one there too.
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "server",
    // rust: "motd",
    // rust: toml::Value::String(value.into()),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getDifficulty` and `setDifficulty`.
pub fn difficulty(self: *Self, client: u32, value: ?[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/difficulty" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/difficulty/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "world",
    // rust: "difficulty",
    // rust: toml::Value::String(value.into()),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getViewDistance` and `setViewDistance`.
pub fn view_distance(self: *Self, client: u32, value: ?i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/view_distance" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/view_distance/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "server",
    // rust: "view_distance",
    // rust: toml::Value::Integer(i64::from(value)),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getSimulationDistance` and `setSimulationDistance`.
pub fn simulation_distance(self: *Self, client: u32, value: ?i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/simulation_distance" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/simulation_distance/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "server",
    // rust: "simulation_distance",
    // rust: toml::Value::Integer(i64::from(value)),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

    /// `MinecraftServerSettingsServiceImpl.getEntityBroadcastRangePercentage` and
    /// `setEntityBroadcastRangePercentage`.
pub fn entity_broadcast_range(self: *Self, client: u32, value: ?i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut request = json!({ "method": "serversettings/entity_broadcast_range" });
    // rust: if let Some(value) = value {
    // rust: request["method"] = json!("serversettings/entity_broadcast_range/set");
    // rust: request["value"] = json!(value);
}
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err((INTERNAL_ERROR, Some(error.to_owned())));
}
    // rust: if let Some(value) = value {
    // rust: let value = reply["value"].as_i64().unwrap_or(i64::from(value));
    // rust: crate::config::update(
    // rust: &self.shared.dir,
    // rust: "properties",
    // rust: "entity-broadcast-range-percentage",
    // rust: toml::Value::Integer(value),
    // rust: )
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(e)))?;
}
    // rust: Ok(reply["value"].clone())
}

pub fn running(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shared.state.lock().unwrap().phase == Phase::Running
}

pub fn ask(self: *Self, line: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: engine::Control::connect(&self.shared.dir)
    // rust: .and_then(|mut game| game.ask(line))
    // rust: .map_err(|e| (INTERNAL_ERROR, Some(format!("the game didn't answer: {e}"))))
}

pub fn console(self: *Self, line: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ask(&format!("console {line}"))
}

    /// A list edit, which the game makes as vanilla's services make it.
pub fn edit(self: *Self, client: u32, method: []const u8, entries: std.ArrayList(Value)) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let request = json!({ "method": method, "entries": entries });
    // rust: let reply = self.ask(&format!("management {client} {request}"))?;
    // rust: match reply["error"].as_str() {
    // rust: Some(error) => Err((INTERNAL_ERROR, Some(error.to_owned()))),
    // rust: None => Ok(()),
}
}

    /// `PlayerService.get`: the players online, as `PlayerDto`s.
pub fn online(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let status = self.ask("server-status")?;
    // rust: Ok(status["players"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|p| json!({ "id": p["uuid"], "name": p["name"] }))
    // rust: .collect())
}

    /// An online player's name, by id first, as `PlayerService.getServerPlayer` finds them.
pub fn find(self: *Self, online: *[Value], dto: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (id, name) = player_dto(dto)?;
    // rust: let found = online.iter().find(|p| match (id, &name) {
    // rust: (Some(id), _) => p["id"] == uuid(id),
    // rust: (None, Some(name)) => p["name"]
    // rust: .as_str()
    // rust: .is_some_and(|n| n.eq_ignore_ascii_case(name)),
    // rust: (None, None) => false,
    // rust: });
    // rust: Ok(found.and_then(|p| p["name"].as_str().map(str::to_owned)))
}

    /// `ServerStateService.status`.
pub fn status(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let version = json!({
    // rust: "name": horizon_core::version::VERSION_ID,
    // rust: "protocol": horizon_core::version::PROTOCOL_VERSION,
    // rust: });
    // rust: let players = if self.running() {
    // rust: self.online().ok()
    // rust: } else {
    // rust: None
}
    // rust: let Some(players) = players else {
    // rust: return json!({ "started": false, "version": version });
}
    // rust: let mut state = json!({ "started": true, "version": version });
        // An empty list is left out, as vanilla's codec leaves out its default.
    // rust: if !players.is_empty() {
    // rust: state["players"] = Value::Array(players);
}
    // rust: state
}

    /// `PlayerService.kick`: the players found, as they were asked for.
pub fn kick(self: *Self, argument: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kicks = argument
    // rust: .as_array()
    // rust: .ok_or_else(|| invalid_params("Not a list"))?;
    // rust: let online = self.online()?;
    // rust: let mut kicked = Vec::new();
    // rust: for kick in kicks {
    // rust: let Some(name) = self.find(&online, &kick["player"])? else {
    // rust: continue;
}
    // rust: let reason = kick.get("message").and_then(component).map(|c| {
    // rust: c["text"]
    // rust: .as_str()
    // rust: .or(c["translate"].as_str())
    // rust: .unwrap_or_default()
    // rust: .to_owned()
    // rust: });
    // rust: let line = match reason {
    // rust: Some(reason) if !reason.is_empty() => format!("kick {name} {reason}"),
    // rust: _ => format!("kick {name}"),
}
    // rust: self.console(&line)?;
    // rust: kicked.push(kick["player"].clone());
}
    // rust: Ok(Value::Array(kicked))
}

    /// `ServerStateService.systemMessage`: to everyone, or to the players named (those online).
pub fn system_message(self: *Self, argument: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if argument["overlay"].as_bool().is_none() {
    // rust: return Err(invalid_params("No key overlay"));
}
    // rust: let Some(text) = component(&argument["message"]) else {
    // rust: return Ok(json!(false));
}
    // rust: let targets = match argument.get("receivingPlayers").and_then(Value::as_array) {
    // rust: Some(players) if players.is_empty() => return Ok(json!(false)),
    // rust: Some(players) => {
    // rust: let online = self.online()?;
    // rust: let mut names = Vec::new();
    // rust: for p in players {
    // rust: names.extend(self.find(&online, p)?);
}
    // rust: names
}
    // rust: None => vec!["@a".to_owned()],
}
    // rust: for target in targets {
    // rust: if argument["overlay"] == true {
    // rust: self.console(&format!("title {target} actionbar {text}"))?;
    // rust: } else {
    // rust: self.console(&format!("tellraw {target} {text}"))?;
}
}
    // rust: Ok(json!(true))
}
}

/// Vanilla's lists in the server folder, as the game keeps them.
pub const Lists = struct {};

    // rust: impl Lists<'_> {
    // rust: fn load<E: horizon_server_files::user_lists::Entry>(
    // rust: &self,
    // rust: file: &str,
    // rust: ) -> horizon_server_files::user_lists::UserList<E> {
    // rust: let mut list = horizon_server_files::user_lists::UserList::new(self.0.join(file));
    // rust: let _ = list.load();
    // rust: list
}

pub fn allowlist(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list: horizon_server_files::user_lists::WhiteList = self.load("whitelist.json");
    // rust: list.entries()
    // rust: .iter()
    // rust: .map(|e| json!({ "id": uuid(e.user.id), "name": e.user.name }))
    // rust: .collect()
}

pub fn operators(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list: horizon_server_files::user_lists::OpList = self.load("ops.json");
    // rust: list.entries()
    // rust: .iter()
    // rust: .map(|e| {
    // rust: json!({
    // rust: "player": { "id": uuid(e.user.id), "name": e.user.name },
    // rust: "permissionLevel": e.level,
    // rust: "bypassesPlayerLimit": e.bypasses_player_limit,
    // rust: })
    // rust: })
    // rust: .collect()
}

pub fn bans(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list: horizon_server_files::user_lists::BanList = self.load("banned-players.json");
    // rust: list.entries()
    // rust: .iter()
    // rust: .map(|b| {
    // rust: let player = json!({ "id": uuid(b.user.id), "name": b.user.name });
    // rust: ban(("player", player), &b.reason, &b.source, b.expires)
    // rust: })
    // rust: .collect()
}

pub fn ip_bans(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list: horizon_server_files::user_lists::IpBanList = self.load("banned-ips.json");
    // rust: list.entries()
    // rust: .iter()
    // rust: .map(|b| ban(("ip", json!(b.user)), &b.reason, &b.source, b.expires))
    // rust: .collect()
}
}

/// `ServerStateService.status`, as `server/status` answers it (and the heartbeat carries it).
pub fn status(shared: *Shared) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Game { shared }.status()
}

/// The notification a change of one of the lists is, from the game's typed event (`operators_added`,
/// `bans_removed`...): `JsonRpcNotificationService`'s `playerOped`/`playerDeoped` (an `OperatorDto`),
/// `playerAddedToAllowlist`/`playerRemovedFromAllowlist` and `playerUnbanned` (a `PlayerDto`), `playerBanned`
/// (a `UserBanDto`), `ipBanned` (an `IpBanDto`) and `ipUnbanned` (the address).
pub fn list_notification(kind: []const u8, event: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let player = || json!({ "id": event["uuid"], "name": event["name"] });
    // rust: let operator = || {
    // rust: json!({
    // rust: "player": player(),
    // rust: "permissionLevel": event["level"],
    // rust: "bypassesPlayerLimit": event["bypassesPlayerLimit"],
    // rust: })
}
    // rust: let reason = event["reason"].as_str().map(str::to_owned);
    // rust: let source = event["source"].as_str().unwrap_or_default();
    // rust: let expires = event["expires"].as_i64();
    // rust: Some(match kind {
    // rust: "operators_added" => ("notification/operators/added", operator()),
    // rust: "operators_removed" => ("notification/operators/removed", operator()),
    // rust: "allowlist_added" => ("notification/allowlist/added", player()),
    // rust: "allowlist_removed" => ("notification/allowlist/removed", player()),
    // rust: "bans_added" => (
    // rust: "notification/bans/added",
    // rust: ban(("player", player()), &reason, source, expires),
    // rust: ),
        // `MinecraftServer.onGameRuleChanged`: the rule as a typed rule (the event's own `type` is its kind).
    // rust: "gamerule" => (
    // rust: "notification/gamerules/updated",
    // rust: json!({ "key": event["key"], "type": event["valueType"], "value": event["value"] }),
    // rust: ),
    // rust: "bans_removed" => ("notification/bans/removed", player()),
    // rust: "ip_bans_added" => (
    // rust: "notification/ip_bans/added",
    // rust: ban(("ip", event["ip"].clone()), &reason, source, expires),
    // rust: ),
    // rust: "ip_bans_removed" => ("notification/ip_bans/removed", event["ip"].clone()),
    // rust: _ => return None,
    // rust: })
}

/// A `UserBanDto` or `IpBanDto`: the reason when there is one, the end as an ISO-8601 instant.
pub fn ban(who: ([]const u8) void {
}
    // rust: let mut b = json!({ "source": source });
    // rust: b[who.0] = who.1;
    // rust: if let Some(reason) = reason {
    // rust: b["reason"] = json!(reason);
}
    // rust: if let Some(at) = expires.and_then(chrono::DateTime::from_timestamp_millis) {
    // rust: b["expires"] = json!(at.to_rfc3339_opts(chrono::SecondsFormat::AutoSi, true));
}
    // rust: b
}

    // rust: mod tests {
pub fn a_player_id_must_be_a_whole_uuid() void {
}
//         use super::player_dto;
    // rust: let id = |s: &str| player_dto(&serde_json::json!({ "id": s })).map(|(id, _)| id);
    // rust: let want = Some(0x0123_4567_89ab_cdef_0123_4567_89ab_cdefu128);
    // rust: assert_eq!(id("01234567-89ab-cdef-0123-456789abcdef").unwrap(), want);
    // rust: assert_eq!(id("0123456789abcdef0123456789abcdef").unwrap(), want);
    // rust: for bad in [
    // rust: "abc",
    // rust: "1",
    // rust: "+123456789abcdef0123456789abcdef",
    // rust: "0123-4567-89ab-cdef-0123456789abcdef",
    // rust: "01234567-89ab-cdef-0123-456789abcdeg",
    // rust: "",
    // rust: ] {
    // rust: assert!(id(bad).is_err(), "{bad:?} is no UUID");
}
}

//     use super::*;

pub fn shared() s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-management-methods-{}-{:?}",
    // rust: std::process::id(),
    // rust: std::thread::current().id()
    // rust: ));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: Shared::with_install(&dir, None)
}

    /// The interval is live at once, and server.properties and server.toml's `[properties]` keep it, so
    /// that a restart reads it back (what the parity harness compares with vanilla's).
pub fn the_status_heartbeat_interval_is_live_and_kept() void {
}
    // rust: let shared = shared();
    // rust: let dir = shared.dir.clone();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: std::fs::write(
    // rust: dir.join(crate::config::PROPERTIES),
    // rust: "#Minecraft server properties
    // rust: status-heartbeat-interval=0
    // rust: ",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(status_heartbeat_interval(&shared, 30).unwrap(), json!(30));
    // rust: assert_eq!(management::heartbeat_seconds(&shared), 30);
    // rust: let properties = std::fs::read_to_string(dir.join(crate::config::PROPERTIES)).unwrap();
    // rust: assert!(
    // rust: properties.contains("status-heartbeat-interval=30"),
    // rust: "{properties}"
    // rust: );
    // rust: let toml = std::fs::read_to_string(dir.join(crate::config::FILE)).unwrap();
    // rust: assert!(toml.contains("status-heartbeat-interval = 30"), "{toml}");
        // Vanilla keeps any int, and schedules nothing for 0 or less.
    // rust: assert_eq!(status_heartbeat_interval(&shared, -5).unwrap(), json!(-5));
    // rust: assert_eq!(management::heartbeat_seconds(&shared), -5);
        // A value that is no integer is refused before anything changes.
    // rust: assert!(management_int(&json!("yes")).is_err());
    // rust: assert_eq!(management::heartbeat_seconds(&shared), -5);
        // -5 cancelled the running 30 s heartbeat: vanilla cannot cancel it again, so it refuses every
        // later set, answers with the interval in force and keeps nothing.
    // rust: assert_eq!(status_heartbeat_interval(&shared, 30).unwrap(), json!(-5));
    // rust: assert_eq!(management::heartbeat_seconds(&shared), -5);
    // rust: let properties = std::fs::read_to_string(dir.join(crate::config::PROPERTIES)).unwrap();
    // rust: assert!(
    // rust: properties.contains("status-heartbeat-interval=-5"),
    // rust: "{properties}"
    // rust: );
}

    /// A set to 0 or less with no heartbeat running cancels nothing, so later sets still apply.
pub fn a_heartbeat_never_started_can_still_be_set() void {
}
    // rust: let shared = shared();
    // rust: let dir = shared.dir.clone();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: std::fs::write(
    // rust: dir.join(crate::config::PROPERTIES),
    // rust: "#Minecraft server properties
    // rust: status-heartbeat-interval=0
    // rust: ",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(status_heartbeat_interval(&shared, 0).unwrap(), json!(0));
    // rust: assert_eq!(status_heartbeat_interval(&shared, 45).unwrap(), json!(45));
    // rust: assert_eq!(management::heartbeat_seconds(&shared), 45);
}

pub fn a_change_of_a_list_is_the_notification_vanilla_sends() void {
}
    // rust: let id = "93e029a5-04a0-349d-90b2-f7e145b2644f";
    // rust: let event = |fields: Value| {
    // rust: let mut event = json!({ "name": "Kim0", "uuid": id });
    // rust: event
    // rust: .as_object_mut()
    // rust: .unwrap()
    // rust: .extend(fields.as_object().unwrap().clone());
    // rust: event
}
    // rust: let player = json!({ "id": id, "name": "Kim0" });
    // rust: let note = |kind, fields| list_notification(kind, &event(fields)).unwrap();
    // rust: assert_eq!(
    // rust: note(
    // rust: "operators_added",
    // rust: json!({ "level": 3, "bypassesPlayerLimit": true })
    // rust: ),
    // rust: (
    // rust: "notification/operators/added",
    // rust: json!({ "player": player, "permissionLevel": 3, "bypassesPlayerLimit": true })
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: note(
    // rust: "operators_removed",
    // rust: json!({ "level": 4, "bypassesPlayerLimit": false })
    // rust: )
    // rust: .0,
    // rust: "notification/operators/removed"
    // rust: );
    // rust: assert_eq!(
    // rust: note("allowlist_added", json!({})),
    // rust: ("notification/allowlist/added", player.clone())
    // rust: );
    // rust: assert_eq!(
    // rust: note("bans_removed", json!({})),
    // rust: ("notification/bans/removed", player.clone())
    // rust: );
        // A ban says why and until when, as the lists do; no reason or end leaves them out.
    // rust: assert_eq!(
    // rust: note(
    // rust: "bans_added",
    // rust: json!({ "reason": "griefing", "source": "Kim", "expires": 1_793_491_200_000_i64 })
    // rust: ),
    // rust: (
    // rust: "notification/bans/added",
    // rust: json!({ "player": player, "source": "Kim", "reason": "griefing", "expires": "2026-11-01T00:00:00Z" })
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: note(
    // rust: "ip_bans_added",
    // rust: json!({ "ip": "10.0.0.1", "source": "Rcon", "reason": null, "expires": null })
    // rust: ),
    // rust: (
    // rust: "notification/ip_bans/added",
    // rust: json!({ "ip": "10.0.0.1", "source": "Rcon" })
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: note("ip_bans_removed", json!({ "ip": "10.0.0.1" })),
    // rust: ("notification/ip_bans/removed", json!("10.0.0.1"))
    // rust: );
        // A game rule changed: the rule as a typed rule, whose `type` the event keeps as `valueType`.
    // rust: assert_eq!(
    // rust: note(
    // rust: "gamerule",
    // rust: json!({ "key": "minecraft:pvp", "valueType": "boolean", "value": false })
    // rust: ),
    // rust: (
    // rust: "notification/gamerules/updated",
    // rust: json!({ "key": "minecraft:pvp", "type": "boolean", "value": false })
    // rust: )
    // rust: );
    // rust: assert!(list_notification("kick", &event(json!({}))).is_none());
}

pub fn the_lists_read_as_vanillas_dtos() void {
}
    // rust: let shared = shared();
    // rust: let dir = &shared.dir;
    // rust: std::fs::write(
    // rust: dir.join("banned-players.json"),
    // rust: r#"[{"uuid":"93e029a5-04a0-349d-90b2-f7e145b2644f","name":"Kim0","created":"2026-10-31 14:00:00 +0000",
    // rust: "source":"Management server","expires":"2026-11-01 00:00:00 +0000","reason":"griefing"}]"#,
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: dir.join("ops.json"),
    // rust: r#"[{"uuid":"93e029a5-04a0-349d-90b2-f7e145b2644f","name":"Kim0","level":3,"bypassesPlayerLimit":true}]"#,
    // rust: )
    // rust: .unwrap();
    // rust: let lists = Lists(dir);
    // rust: assert_eq!(
    // rust: lists.bans(),
    // rust: json!([{ "player": { "id": "93e029a5-04a0-349d-90b2-f7e145b2644f", "name": "Kim0" },
    // rust: "source": "Management server", "reason": "griefing", "expires": "2026-11-01T00:00:00Z" }])
    // rust: );
    // rust: assert_eq!(lists.operators()[0]["permissionLevel"], 3);
    // rust: assert_eq!(lists.operators()[0]["bypassesPlayerLimit"], true);
    // rust: assert_eq!(lists.allowlist(), json!([]));
    // rust: assert_eq!(lists.ip_bans(), json!([]));
}

pub fn list_edits_reach_the_game_checked_and_normalized() void {
}
    // rust: let kim = json!({ "id": "93e029a5-04a0-349d-90b2-f7e145b2644f" });
    // rust: assert_eq!(
    // rust: user_ban(&json!({ "player": kim, "expires": "2027-01-01T00:00:00Z" })).unwrap(),
    // rust: json!({ "player": { "id": "93e029a504a0349d90b2f7e145b2644f", "name": null },
    // rust: "reason": null, "source": null, "expires": 1798761600000i64 })
    // rust: );
    // rust: assert!(user_ban(&json!({ "reason": "x" })).is_err());
    // rust: assert!(user_ban(&json!({ "player": kim, "expires": "tomorrow" })).is_err());
    // rust: assert_eq!(
    // rust: ip_ban(&json!({ "ip": "203.0.113.7", "source": "Bot" })).unwrap(),
    // rust: json!({ "ip": "203.0.113.7", "reason": null, "source": "Bot", "expires": null })
    // rust: );
    // rust: assert!(ip_ban(&json!({ "reason": "x" })).is_err());
    // rust: assert_eq!(
    // rust: incoming_ip_ban(&json!({ "player": { "name": "Kim0" } })).unwrap()["player"]["name"],
    // rust: "Kim0"
    // rust: );
    // rust: assert_eq!(
    // rust: operator(&json!({ "player": { "name": "Kim0" }, "permissionLevel": 2 })).unwrap(),
    // rust: json!({ "player": { "id": null, "name": "Kim0" }, "permissionLevel": 2, "bypassesPlayerLimit": null })
    // rust: );
    // rust: assert!(operator(&json!({ "player": { "name": "Kim0" }, "permissionLevel": 5 })).is_err());
    // rust: assert!(
    // rust: operator(&json!({ "player": { "name": "Kim0" }, "bypassesPlayerLimit": 1 })).is_err()
    // rust: );
    // rust: assert_eq!(list_or_none(&Value::Null).unwrap(), Vec::<Value>::new());
}

pub fn the_status_says_when_the_game_isnt_up() void {
}
    // rust: let shared = shared();
    // rust: let reply = crate::management::receive(
    // rust: &shared,
    // rust: 1,
    // rust: r#"{"jsonrpc":"2.0","id":null,"method":"server/status"}"#,
    // rust: );
    // rust: assert_eq!(
    // rust: reply.unwrap().unwrap(),
    // rust: json!({ "jsonrpc": "2.0", "id": null, "result": {
    // rust: "started": false, "version": { "name": "26.3", "protocol": 777 } } })
    // rust: );
}
}
