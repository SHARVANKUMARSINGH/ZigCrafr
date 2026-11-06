//! Transpiled from Horizon Rust crate
package horizon_client_management

import "core:fmt"
import "core:mem"
import "core:math"

// The management protocol's list edits, which `horizon-server` forwards on the control endpoint as
// `management <connection> {"method", "entries"}` (its management_methods.rs): vanilla 26.3's
// `AllowlistService`, `BanlistService`, `IpBanlistService` and `OperatorService` on the running server's lists. Players are found as
// `MinecraftPlayerListService.getUser` finds them, each change is logged as `JsonRpcLogger` logs it, and the
// players a change shuts out are disconnected. The supervisor answers with the lists, from their files.
// use super::{GAME_MODES, ServerState, auto_save, log, set_auto_save};
// use crate::game::Game;
// use horizon_client::{
    // rust: command::vanilla::DIFFICULTIES,
    // rust: gamerules::{self, Value as GameRuleValue},
    // rust: server::{
    // rust: profiles,
    // rust: user_lists::{BanEntry, NameAndId, OpEntry, WhiteEntry},
    // rust: },
    // rust: text::Text,
}
// use horizon_protocol::text::translatable;
// use serde_json::{Value, json};

// A `UserBan`: the player, the reason, the source, the end.
    // rust: type Ban = BanEntry<NameAndId>;
// An `IpBan`: the address, the reason, the source, the end.
    // rust: type IpBan = BanEntry<String>;

// `OperatorService.Op`: the player and the level and bypass asked for, which a stored operator always has.
Op :: struct {
    user: NameAndId,
    level: Maybe(i32),
    bypass: Maybe(bool),
}

// A `GameRuleUpdate` as `TYPED_CODEC` writes it: the rule's id, its type and its value.
typed_rule :: proc(rule: ^gamerules::Rule, value: GameRuleValue) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (kind, value) = match value {
    // rust: GameRuleValue::Bool(b) => ("boolean", json!(b)),
    // rust: GameRuleValue::Int(i) => ("integer", json!(i)),
}
    // rust: json!({ "key": format!("minecraft:{}", rule.name), "type": kind, "value": value })
}

// `NameAndId`'s record `toString`, as vanilla's log lines show it.
shown :: proc(user: ^NameAndId) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "NameAndId[id={}, name={}]",
    // rust: horizon_protocol::crypto::uuid_string(user.id),
    // rust: user.name
    // rust: )
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn management(&mut self, state: &mut ServerState, request: &str) -> Value {
    // rust: let (connection, body) = request.split_once(' ').unwrap_or((request, "{}"));
    // rust: let rpc =
    // rust: |message: String| log("INFO", &format!("RPC Connection #{connection}: {message}"));
    // rust: let Ok(body) = serde_json::from_str::<Value>(body) else {
    // rust: return json!({ "error": "a management request is a connection number and a JSON object" });
}
    // rust: let entries = body["entries"].as_array().cloned().unwrap_or_default();
    // rust: let lists = state.lists.clone();
    // rust: match body["method"].as_str().unwrap_or_default() {
            // `GameRulesService.get`: every rule the server has, with its type and current value.
    // rust: "gamerules" => {
    // rust: let rules = &self.ui.rules;
    // rust: let all: Vec<Value> = rules
    // rust: .available_rules()
    // rust: .map(|r| typed_rule(r, rules.get(r.name).unwrap_or(r.default)))
    // rust: .collect();
    // rust: return json!({ "value": all });
}
            // `GameRulesService.update` through `MinecraftGameRuleServiceImpl.updateGameRule`: the rule is set,
            // logged and told on every update, even to the value it has (as vanilla's sends its notification
            // then too, which the parity script checks). What doesn't fit answers with the texts of vanilla's
            // codecs, as the parity script saw them.
    // rust: "gamerules/update" => {
    // rust: let update = &body["value"];
    // rust: let Some(key) = update["key"].as_str() else {
    // rust: return json!({ "invalid": format!("No key key in MapLike[{update}]") });
}
    // rust: let rule = gamerules::rule(key).filter(|r| self.ui.rules.get(r.name).is_some());
    // rust: let Some(rule) = rule else {
    // rust: let key = if key.contains(':') {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{key}")
}
    // rust: return json!({ "invalid": format!(
    // rust: "Unknown registry key in ResourceKey[minecraft:root / minecraft:game_rule]: {key}"
    // rust: ) });
}
    // rust: let wanted = &update["value"];
    // rust: let value = match (rule.default, wanted) {
    // rust: (GameRuleValue::Bool(_), Value::Bool(b)) => Ok(GameRuleValue::Bool(*b)),
    // rust: (GameRuleValue::Bool(_), other) => Err(format!("Not a boolean: {other}")),
    // rust: (GameRuleValue::Int(_), other) => match other.as_i64() {
    // rust: Some(n) if (i64::from(rule.min)..=i64::from(rule.max)).contains(&n) => {
    // rust: Ok(GameRuleValue::Int(n as i32))
}
    // rust: Some(n) => Err(format!(
    // rust: "Value {n} outside of range [{}:{}]",
    // rust: rule.min, rule.max
    // rust: )),
    // rust: None => Err(format!("Not a number: {other}")),
    // rust: },
}
    // rust: let value = match value {
    // rust: Ok(value) => value,
    // rust: Err(invalid) => return json!({ "invalid": invalid }),
}
    // rust: let current = self.ui.rules.get(rule.name).unwrap_or(rule.default);
    // rust: rpc(format!(
    // rust: "Game rule '{}' updated from '{current}' to '{value}'",
    // rust: rule.name
    // rust: ));
    // rust: self.set_game_rule(rule, value);
    // rust: return json!({ "value": typed_rule(rule, value) });
}
    // rust: "serversettings/autosave" => {
    // rust: return json!({ "value": auto_save(state) });
}
    // rust: "serversettings/autosave/set" => {
    // rust: let Some(enabled) = body["value"].as_bool() else {
    // rust: return json!({ "error": "autosave must be a boolean" });
}
    // rust: rpc(format!(
    // rust: "Update autosave from {} to {}",
    // rust: auto_save(state),
    // rust: enabled
    // rust: ));
    // rust: set_auto_save(&state.lists, enabled);
    // rust: return json!({ "value": auto_save(state) });
}
    // rust: "serversettings/pause_when_empty_seconds" => {
    // rust: return json!({ "value": state.pause_when_empty_seconds });
}
    // rust: "serversettings/pause_when_empty_seconds/set" => {
    // rust: let Some(seconds) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: else {
    // rust: return json!({ "error": "pause when empty seconds must be an integer" });
}
    // rust: rpc(format!(
    // rust: "Update pause when empty from {} seconds to {} seconds",
    // rust: state.pause_when_empty_seconds, seconds
    // rust: ));
    // rust: self.set_pause_when_empty_seconds(state, seconds);
    // rust: return json!({ "value": state.pause_when_empty_seconds });
}
    // rust: "serversettings/motd" => {
    // rust: return json!({
    // rust: "value": self.lan.as_ref().map(|lan| lan.hub.lan.shared.motd()).unwrap_or_default()
    // rust: });
}
    // rust: "serversettings/motd/set" => {
    // rust: let Some(value) = body["value"].as_str() else {
    // rust: return json!({ "error": "MOTD must be a string" });
}
    // rust: if let Some(lan) = &self.lan {
    // rust: rpc(format!(
    // rust: "Update MOTD from '{}' to '{}'",
    // rust: lan.hub.lan.shared.motd(),
    // rust: value
    // rust: ));
    // rust: lan.hub.lan.shared.set_motd(value.to_owned());
}
                // DedicatedServer.setMotd: server.properties keeps it too.
    // rust: self.store_property("motd", value.to_owned());
    // rust: return json!({ "value": value });
}
    // rust: "serversettings/game_mode" => {
    // rust: return json!({ "value": GAME_MODES[state.game_mode as usize] });
}
    // rust: "serversettings/game_mode/set" => {
    // rust: let Some(value) = body["value"].as_str() else {
    // rust: return json!({ "error": "game mode must be a string" });
}
    // rust: let Some(index) = GAME_MODES.iter().position(|name| *name == value) else {
    // rust: return json!({ "error": format!("unknown game mode {value:?}") });
}
    // rust: rpc(format!(
    // rust: "Update game mode from '{}' to '{}'",
    // rust: GAME_MODES[state.game_mode as usize], value
    // rust: ));
    // rust: self.store_property("gamemode", value.to_owned());
    // rust: state.game_mode = index as i32;
    // rust: self.set_default_game_mode(state.game_mode);
    // rust: return json!({ "value": GAME_MODES[state.game_mode as usize] });
}
    // rust: "serversettings/entity_broadcast_range" => {
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(100, |host| host.hub.entity_range_percent)
    // rust: });
}
    // rust: "serversettings/entity_broadcast_range/set" => {
    // rust: let Some(percentage) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: else {
    // rust: return json!({
    // rust: "error": "entity broadcast range percentage must be an integer"
    // rust: });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(100, |host| host.hub.entity_range_percent);
                // MinecraftServerSettingsServiceImpl logs the value asked for; the
                // DedicatedServerProperties deserializer clamps what is applied and saved.
    // rust: rpc(format!(
    // rust: "Update entity broadcast range percentage from {current}% to {percentage}%"
    // rust: ));
    // rust: let percentage = percentage.clamp(10, 1000);
    // rust: self.set_entity_broadcast_range_percentage(percentage);
    // rust: self.store_property("entity-broadcast-range-percentage", percentage.to_string());
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(100, |host| host.hub.entity_range_percent)
    // rust: });
}
    // rust: "serversettings/simulation_distance" => {
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(0, |host| host.hub.config.simulation_distance)
    // rust: });
}
    // rust: "serversettings/simulation_distance/set" => {
    // rust: let Some(distance) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: else {
    // rust: return json!({ "error": "simulation distance must be an integer" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(0, |host| host.hub.config.simulation_distance);
    // rust: rpc(format!(
    // rust: "Update simulation distance from {current} to {distance}"
    // rust: ));
    // rust: self.set_simulation_distance(distance);
    // rust: state.view.1 = distance.max(0) as u32;
    // rust: self.store_property("simulation-distance", distance.to_string());
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(0, |host| host.hub.config.simulation_distance)
    // rust: });
}
    // rust: "serversettings/view_distance" => {
    // rust: return json!({
    // rust: "value": self.lan.as_ref().map_or(0, |host| host.hub.config.view_distance)
    // rust: });
}
    // rust: "serversettings/view_distance/set" => {
    // rust: let Some(distance) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: else {
    // rust: return json!({ "error": "view distance must be an integer" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(0, |host| host.hub.config.view_distance);
    // rust: rpc(format!("Update view distance from {current} to {distance}"));
    // rust: self.set_view_distance(distance);
    // rust: state.view.0 = distance.max(0) as u32;
    // rust: self.store_property("view-distance", distance.to_string());
    // rust: return json!({
    // rust: "value": self.lan.as_ref().map_or(0, |host| host.hub.config.view_distance)
    // rust: });
}
    // rust: "serversettings/operator_user_permission_level" => {
    // rust: return json!({ "value": state.op_level });
}
    // rust: "serversettings/operator_user_permission_level/set" => {
    // rust: let Some(level) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: .filter(|level| (0..=4).contains(level))
    // rust: else {
    // rust: return json!({
    // rust: "error": "operator user permission level must be an integer between 0 and 4"
    // rust: });
}
    // rust: rpc(format!(
    // rust: "Update operator user permission level from {} to {}",
    // rust: state.op_level, level
    // rust: ));
    // rust: state.op_level = level;
    // rust: state.lists.lock().unwrap().op_level = level;
    // rust: self.store_property("op-permission-level", level.to_string());
    // rust: return json!({ "value": state.op_level });
}
    // rust: "serversettings/force_game_mode" => {
    // rust: return json!({ "value": state.force_game_mode });
}
    // rust: "serversettings/force_game_mode/set" => {
    // rust: let Some(force) = body["value"].as_bool() else {
    // rust: return json!({ "error": "force game mode must be a boolean" });
}
    // rust: rpc(format!(
    // rust: "Update force game mode from {} to {}",
    // rust: state.force_game_mode, force
    // rust: ));
    // rust: self.store_property("force-gamemode", force.to_string());
    // rust: state.force_game_mode = force;
    // rust: self.set_force_game_mode(force);
    // rust: return json!({ "value": state.force_game_mode });
}
    // rust: "serversettings/spawn_protection_radius" => {
    // rust: return json!({
    // rust: "value": self.lan.as_ref().map_or(0, |host| host.hub.spawn_protection)
    // rust: });
}
    // rust: "serversettings/spawn_protection_radius/set" => {
    // rust: let Some(radius) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: else {
    // rust: return json!({ "error": "spawn protection radius must be an integer" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(0, |host| host.hub.spawn_protection);
    // rust: rpc(format!(
    // rust: "Update spawn protection radius from {current} to {radius}"
    // rust: ));
    // rust: self.set_spawn_protection(radius);
    // rust: self.store_property("spawn-protection", radius.to_string());
    // rust: return json!({
    // rust: "value": self.lan.as_ref().map_or(0, |host| host.hub.spawn_protection)
    // rust: });
}
    // rust: "serversettings/allow_flight" => {
    // rust: return json!({
    // rust: "value": self.lan.as_ref().is_some_and(|host| host.hub.config.allow_flight)
    // rust: });
}
    // rust: "serversettings/allow_flight/set" => {
    // rust: let Some(allow) = body["value"].as_bool() else {
    // rust: return json!({ "error": "allow flight must be a boolean" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.config.allow_flight);
    // rust: rpc(format!("Update allow flight from {current} to {allow}"));
    // rust: self.set_allow_flight(allow);
    // rust: self.store_property("allow-flight", allow.to_string());
    // rust: return json!({
    // rust: "value": self.lan.as_ref().is_some_and(|host| host.hub.config.allow_flight)
    // rust: });
}
    // rust: "serversettings/hide_online_players" => {
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.hide_online_players())
    // rust: });
}
    // rust: "serversettings/hide_online_players/set" => {
    // rust: let Some(hide) = body["value"].as_bool() else {
    // rust: return json!({ "error": "hide online players must be a boolean" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.hide_online_players());
    // rust: rpc(format!(
    // rust: "Update hide online players from {current} to {hide}"
    // rust: ));
    // rust: self.set_hide_online_players(hide);
    // rust: self.store_property("hide-online-players", hide.to_string());
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.hide_online_players())
    // rust: });
}
    // rust: "serversettings/status_replies" => {
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.enable_status())
    // rust: });
}
    // rust: "serversettings/status_replies/set" => {
    // rust: let Some(enable) = body["value"].as_bool() else {
    // rust: return json!({ "error": "status replies must be a boolean" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.enable_status());
    // rust: rpc(format!("Update status replies from {current} to {enable}"));
    // rust: self.set_status_replies(enable);
    // rust: self.store_property("enable-status", enable.to_string());
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.enable_status())
    // rust: });
}
    // rust: "serversettings/accept_transfers" => {
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.accepts_transfers())
    // rust: });
}
    // rust: "serversettings/accept_transfers/set" => {
    // rust: let Some(accept) = body["value"].as_bool() else {
    // rust: return json!({ "error": "accepts transfers must be a boolean" });
}
    // rust: let current = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.accepts_transfers());
    // rust: rpc(format!(
    // rust: "Update accepts transfers from {current} to {accept}"
    // rust: ));
    // rust: self.set_accepts_transfers(accept);
    // rust: return json!({
    // rust: "value": self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| host.hub.lan.shared.accepts_transfers())
    // rust: });
}
    // rust: "serversettings/player_idle_timeout" => {
    // rust: return json!({ "value": state.lists.lock().unwrap().player_idle_timeout });
}
    // rust: "serversettings/player_idle_timeout/set" => {
    // rust: let Some(minutes) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| i32::try_from(value).ok())
    // rust: else {
    // rust: return json!({ "error": "player idle timeout must be an integer" });
}
    // rust: rpc(format!(
    // rust: "Update player idle timeout from {} minutes to {} minutes",
    // rust: state.lists.lock().unwrap().player_idle_timeout,
    // rust: minutes
    // rust: ));
    // rust: self.set_player_idle_timeout(&state.lists.clone(), minutes);
    // rust: return json!({ "value": state.lists.lock().unwrap().player_idle_timeout });
}
    // rust: "serversettings/max_players" => {
    // rust: return json!({ "value": state.max_players });
}
    // rust: "serversettings/max_players/set" => {
    // rust: let Some(max_players) = body["value"]
    // rust: .as_i64()
    // rust: .and_then(|value| usize::try_from(value).ok())
    // rust: else {
    // rust: return json!({ "error": "max players must be a non-negative integer" });
}
    // rust: rpc(format!(
    // rust: "Update max players from {} to {}",
    // rust: state.max_players, max_players
    // rust: ));
    // rust: self.set_max_players(state, max_players);
    // rust: return json!({ "value": state.max_players });
}
    // rust: "serversettings/use_allowlist" => {
    // rust: return json!({
    // rust: "value": lists.lock().unwrap().use_whitelist
    // rust: });
}
    // rust: "serversettings/use_allowlist/set" => {
    // rust: let Some(use_allowlist) = body["value"].as_bool() else {
    // rust: return json!({ "error": "using allowlist must be a boolean" });
}
    // rust: let current = lists.lock().unwrap().use_whitelist;
    // rust: rpc(format!(
    // rust: "Update using allowlist from {} to {}",
    // rust: current, use_allowlist
    // rust: ));
    // rust: self.set_using_whitelist(&lists, use_allowlist);
    // rust: self.kick_unlisted_players(&lists);
    // rust: return json!({
    // rust: "value": lists.lock().unwrap().use_whitelist
    // rust: });
}
    // rust: "serversettings/enforce_allowlist" => {
    // rust: return json!({
    // rust: "value": lists.lock().unwrap().enforce_whitelist
    // rust: });
}
    // rust: "serversettings/enforce_allowlist/set" => {
    // rust: let Some(enforce) = body["value"].as_bool() else {
    // rust: return json!({ "error": "enforce allowlist must be a boolean" });
}
    // rust: let current = lists.lock().unwrap().enforce_whitelist;
    // rust: rpc(format!(
    // rust: "Update enforce allowlist from {} to {}",
    // rust: current, enforce
    // rust: ));
    // rust: self.set_enforce_whitelist(&lists, enforce);
    // rust: self.kick_unlisted_players(&lists);
    // rust: return json!({
    // rust: "value": lists.lock().unwrap().enforce_whitelist
    // rust: });
}
    // rust: "serversettings/difficulty" => {
    // rust: return json!({ "value": DIFFICULTIES[self.level.difficulty_id() as usize] });
}
    // rust: "serversettings/difficulty/set" => {
    // rust: let Some(value) = body["value"].as_str() else {
    // rust: return json!({ "error": "difficulty must be a string" });
}
    // rust: let Some(index) = DIFFICULTIES.iter().position(|name| *name == value) else {
    // rust: return json!({ "error": format!("unknown difficulty {value:?}") });
}
    // rust: rpc(format!(
    // rust: "Update difficulty from '{}' to '{}'",
    // rust: DIFFICULTIES[self.level.difficulty_id() as usize],
    // rust: value
    // rust: ));
                // DedicatedServer.setDifficulty stores the property and then forces the world
                // difficulty, including hardcore's always-hard rule and the player broadcast.
    // rust: self.store_property("difficulty", value.to_owned());
    // rust: self.set_difficulty_forced(if self.level.hardcore { 3 } else { index as u8 });
    // rust: return json!({ "value": DIFFICULTIES[self.level.difficulty_id() as usize] });
}
    // rust: "allowlist/add" => {
    // rust: for user in entries.iter().filter_map(|e| self.management_user(e)) {
    // rust: rpc(format!("Add player '{}' to allowlist", shown(&user)));
    // rust: lists.lock().unwrap().white.add(WhiteEntry { user });
}
}
    // rust: "allowlist/remove" => {
    // rust: for user in entries.iter().filter_map(|e| self.management_user(e)) {
    // rust: rpc(format!("Remove player '{}' from allowlist", shown(&user)));
    // rust: lists.lock().unwrap().white.remove(&user);
}
    // rust: rpc("Kick unlisted players".into());
    // rust: self.kick_unlisted_players(&lists);
}
    // rust: "allowlist/set" => {
    // rust: let wanted: Vec<NameAndId> = entries
    // rust: .iter()
    // rust: .filter_map(|e| self.management_user(e))
    // rust: .collect();
    // rust: let current: Vec<NameAndId> = lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .white
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.clone())
    // rust: .collect();
    // rust: for user in current.iter().filter(|u| !wanted.contains(u)) {
    // rust: rpc(format!("Remove player '{}' from allowlist", shown(user)));
    // rust: lists.lock().unwrap().white.remove(user);
}
    // rust: for user in wanted.iter().filter(|u| !current.contains(u)) {
    // rust: rpc(format!("Add player '{}' to allowlist", shown(user)));
    // rust: lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .white
    // rust: .add(WhiteEntry { user: user.clone() });
}
    // rust: rpc("Kick unlisted players".into());
    // rust: self.kick_unlisted_players(&lists);
}
    // rust: "allowlist/clear" => {
    // rust: rpc("Clear allowlist".into());
    // rust: lists.lock().unwrap().white.clear();
}
    // rust: "bans/add" => {
    // rust: let bans: Vec<Ban> = entries
    // rust: .iter()
    // rust: .filter_map(|e| self.management_ban(e))
    // rust: .collect();
    // rust: for ban in bans {
    // rust: self.management_add_ban(&rpc, state, ban);
}
}
    // rust: "bans/remove" => {
    // rust: for user in entries.iter().filter_map(|e| self.management_user(e)) {
    // rust: rpc(format!("Remove player '{}' from banlist", shown(&user)));
    // rust: lists.lock().unwrap().bans.remove(&user);
}
}
    // rust: "bans/set" => {
    // rust: let wanted: Vec<Ban> = entries
    // rust: .iter()
    // rust: .filter_map(|e| self.management_ban(e))
    // rust: .collect();
    // rust: let current: Vec<Ban> = lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .bans
    // rust: .entries()
    // rust: .into_iter()
    // rust: .cloned()
    // rust: .collect();
    // rust: for ban in current.iter().filter(|b| !wanted.contains(b)) {
    // rust: rpc(format!("Remove player '{}' from banlist", shown(&ban.user)));
    // rust: lists.lock().unwrap().bans.remove(&ban.user);
}
    // rust: for ban in wanted.into_iter().filter(|b| !current.contains(b)) {
    // rust: self.management_add_ban(&rpc, state, ban);
}
}
            // MinecraftBanListServiceImpl.clearUserBans logs nothing.
    // rust: "bans/clear" => lists.lock().unwrap().bans.clear(),
    // rust: "ip_bans/add" => {
    // rust: for entry in &entries {
                    // An address, else the address of the player named, if online.
    // rust: let ip = entry["ip"]
    // rust: .as_str()
    // rust: .filter(|ip| ip.parse::<std::net::IpAddr>().is_ok());
    // rust: let ip = ip.map(str::to_owned).or_else(|| {
    // rust: let player = entry.get("player")?;
    // rust: self.management_online(player).map(|(_, ip)| ip)
    // rust: });
    // rust: if let Some(ip) = ip {
    // rust: self.management_ip_ban(&rpc, state, management_ip_ban(entry, ip));
}
}
}
    // rust: "ip_bans/remove" => {
    // rust: for ip in entries.iter().filter_map(|e| e["ip"].as_str()) {
    // rust: rpc(format!("Remove ip '{ip}' from ban list"));
    // rust: lists.lock().unwrap().ip_bans.remove(&ip.to_owned());
}
}
    // rust: "ip_bans/set" => {
    // rust: let wanted: Vec<IpBan> = entries
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: let ip = e["ip"]
    // rust: .as_str()
    // rust: .filter(|ip| ip.parse::<std::net::IpAddr>().is_ok())?;
    // rust: Some(management_ip_ban(e, ip.to_owned()))
    // rust: })
    // rust: .collect();
    // rust: let current: Vec<IpBan> = lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .ip_bans
    // rust: .entries()
    // rust: .into_iter()
    // rust: .cloned()
    // rust: .collect();
    // rust: for ban in current.iter().filter(|b| !wanted.contains(b)) {
    // rust: rpc(format!("Remove ip '{}' from ban list", ban.user));
    // rust: lists.lock().unwrap().ip_bans.remove(&ban.user);
}
    // rust: for ban in wanted.into_iter().filter(|b| !current.contains(b)) {
    // rust: self.management_ip_ban(&rpc, state, ban);
}
}
    // rust: "ip_bans/clear" => {
    // rust: rpc("Clear ip ban list".into());
    // rust: lists.lock().unwrap().ip_bans.clear();
}
    // rust: "operators/add" => {
    // rust: let ops: Vec<Op> = entries
    // rust: .iter()
    // rust: .filter_map(|e| self.management_op(e))
    // rust: .collect();
    // rust: for op in ops {
    // rust: self.management_add_op(&rpc, state, op);
}
}
    // rust: "operators/remove" => {
    // rust: for user in entries.iter().filter_map(|e| self.management_user(e)) {
    // rust: rpc(format!("Deop '{}'", shown(&user)));
    // rust: lists.lock().unwrap().ops.remove(&user);
}
    // rust: self.sync_ops(&lists);
}
    // rust: "operators/set" => {
    // rust: let wanted: Vec<Op> = entries
    // rust: .iter()
    // rust: .filter_map(|e| self.management_op(e))
    // rust: .collect();
    // rust: let current: Vec<Op> = lists
    // rust: .lock()
    // rust: .unwrap()
    // rust: .ops
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| Op {
    // rust: user: e.user.clone(),
    // rust: level: Some(e.level),
    // rust: bypass: Some(e.bypasses_player_limit),
    // rust: })
    // rust: .collect();
    // rust: for op in current.iter().filter(|o| !wanted.contains(o)) {
    // rust: rpc(format!("Deop '{}'", shown(&op.user)));
    // rust: lists.lock().unwrap().ops.remove(&op.user);
}
    // rust: for op in wanted.into_iter().filter(|o| !current.contains(o)) {
    // rust: self.management_add_op(&rpc, state, op);
}
    // rust: self.sync_ops(&lists);
}
    // rust: "operators/clear" => {
    // rust: rpc("Clear operator list".into());
    // rust: lists.lock().unwrap().ops.clear();
    // rust: self.sync_ops(&lists);
}
    // rust: other => return json!({ "error": format!("unknown management method {other:?}") }),
}
    // rust: json!({ "ok": true })
}

    // `addUserBan`, then the banned player, if online, is sent away.
management_add_ban :: proc(self: ^Self, rpc: ^impl Fn(string) {
}
    // rust: let reason = ban.reason.clone().unwrap_or_else(|| {
    // rust: Text::translate("multiplayer.disconnect.banned.reason.default", &[]).plain()
    // rust: });
    // rust: rpc(format!(
    // rust: "Add player '{}' to banlist. Reason: '{reason}'",
    // rust: ban.user.name
    // rust: ));
    // rust: let id = ban.user.id;
    // rust: state.lists.lock().unwrap().bans.add(ban);
    // rust: self.kick_uuid(id, translatable("multiplayer.disconnect.banned", &[]));
}

    // `addIpBan`, then whoever is online from that address is sent away.
management_ip_ban :: proc(self: ^Self, rpc: ^impl Fn(string) {
}
    // rust: rpc(format!("Add ip '{}' to ban list", ban.user));
    // rust: let ip = ban.user.clone();
    // rust: state.lists.lock().unwrap().ip_bans.add(ban);
    // rust: let banned: Vec<u128> = self.lan.as_ref().map_or_else(Vec::new, |h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.address.ip().to_string() == ip)
    // rust: .map(|g| g.uuid)
    // rust: .collect()
    // rust: });
    // rust: for uuid in banned {
    // rust: self.kick_uuid(uuid, translatable("multiplayer.disconnect.ip_banned", &[]));
}
}

    // `PlayerList.op`: the level asked for, else `op-permission-level`; the bypass asked for, else the one
    // the player had. The commands an online player may run follow (`sync_ops`, after the edit).
management_add_op :: proc(self: ^Self, rpc: ^impl Fn(string) {
}
    // rust: rpc(format!("Op '{}'", shown(&op.user)));
    // rust: let mut lists = state.lists.lock().unwrap();
    // rust: let had = lists
    // rust: .ops
    // rust: .get(&op.user)
    // rust: .is_some_and(|e| e.bypasses_player_limit);
    // rust: let entry = OpEntry {
    // rust: level: op.level.unwrap_or(lists.op_level),
    // rust: bypasses_player_limit: op.bypass.unwrap_or(had),
    // rust: user: op.user,
}
    // rust: lists.ops.add(entry);
    // rust: drop(lists);
    // rust: self.sync_ops(&state.lists);
}

    // An `OperatorDto`: the player found, and the level and bypass when given.
management_op :: proc(self: ^Self, entry: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Op {
    // rust: user: self.management_user(&entry["player"])?,
    // rust: level: entry["permissionLevel"].as_i64().map(|l| l as i32),
    // rust: bypass: entry["bypassesPlayerLimit"].as_bool(),
    // rust: })
}

    // `PlayerListService.getPlayer(id, name)`: an online player, by id first; their address.
management_online :: proc(self: ^Self, player: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = player["id"]
    // rust: .as_str()
    // rust: .and_then(|s| u128::from_str_radix(s, 16).ok());
    // rust: let name = player["name"].as_str();
    // rust: let guest = self
    // rust: .lan
    // rust: .as_ref()?
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| match (id, name) {
    // rust: (Some(id), _) => g.uuid == id,
    // rust: (None, Some(name)) => g.name.eq_ignore_ascii_case(name),
    // rust: (None, None) => false,
    // rust: })?;
    // rust: Some((guest.uuid, guest.address.ip().to_string()))
}

    // `UserBanDto.toUserBan`: the player found, the source "Management server" unless one is given; the ban
    // starts now.
management_ban :: proc(self: ^Self, entry: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let user = self.management_user(&entry["player"])?;
    // rust: let source = entry["source"].as_str().unwrap_or("Management server");
    // rust: let reason = entry["reason"].as_str().map(str::to_owned);
    // rust: Some(BanEntry::new(
    // rust: user,
    // rust: Some(source.to_owned()),
    // rust: entry["expires"].as_i64(),
    // rust: reason,
    // rust: ))
}

    // `MinecraftPlayerListService.getUser`: by id, the user cache, else the session service; by name, the
    // user cache, else the profile service (an offline server's offline player).
management_user :: proc(self: ^Self, player: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(id) = player["id"]
    // rust: .as_str()
    // rust: .and_then(|s| u128::from_str_radix(s, 16).ok())
    // rust: {
    // rust: let cached = super::USER_CACHE
    // rust: .lock()
    // rust: .unwrap()
    // rust: .as_mut()
    // rust: .and_then(|c| c.get_by_id(id));
    // rust: return cached.or_else(|| profiles::find_by_id(&profiles::discovery_url(), id));
}
    // rust: self.resolve_name(player["name"].as_str()?)
}
}

// `IpBan`: the reason, the source "Management server" unless one is given, the end; it starts now.
management_ip_ban :: proc(entry: ^Value, ip: string) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let source = entry["source"].as_str().unwrap_or("Management server");
    // rust: let reason = entry["reason"].as_str().map(str::to_owned);
    // rust: BanEntry::new(
    // rust: ip,
    // rust: Some(source.to_owned()),
    // rust: entry["expires"].as_i64(),
    // rust: reason,
    // rust: )
}

    // rust: mod tests {
//     use super::*;

a_game_rule_is_written_as_vanillas_typed_codec_does :: proc() {
}
    // rust: let pvp = gamerules::rule("pvp").unwrap();
    // rust: assert_eq!(
    // rust: typed_rule(pvp, GameRuleValue::Bool(false)),
    // rust: json!({ "key": "minecraft:pvp", "type": "boolean", "value": false })
    // rust: );
    // rust: let tick = gamerules::rule("minecraft:random_tick_speed").unwrap();
    // rust: assert_eq!(
    // rust: typed_rule(tick, GameRuleValue::Int(3)),
    // rust: json!({ "key": "minecraft:random_tick_speed", "type": "integer", "value": 3 })
    // rust: );
}
}
