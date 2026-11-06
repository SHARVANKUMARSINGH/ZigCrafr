//! Transpiled from Horizon Rust crate
//! Module: horizon-client_test_environments
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `TestEnvironmentDefinition`: what a game test batch changes in the world
//! while it runs (game rules, weather, the day time, difficulty, functions,
//! all of them), set up when the batch starts and torn down after it. The
//! definitions are the data pack's `test_environment` entries, or inline.
// use super::Game;
// use horizon_client::gamerules::{self, Value};
// use serde_json::Value as Json;

/// `Weather.Type`.
    // rust: pub(super) enum WeatherType {
    // rust: Clear,
    // rust: Rain,
    // rust: Thunder,
}

    // rust: impl WeatherType {
pub fn from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "clear" => Some(Self::Clear),
    // rust: "rain" => Some(Self::Rain),
    // rust: "thunder" => Some(Self::Thunder),
    // rust: _ => None,
}
}

    /// (clearTime, rainTime, raining, thundering).
pub fn parameters(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Clear => (100_000, 0, false, false),
    // rust: Self::Rain => (0, 100_000, true, false),
    // rust: Self::Thunder => (0, 100_000, true, true),
}
}
}

/// A `TestEnvironmentDefinition`.
    // rust: pub(super) enum Environment {
    // rust: AllOf(Vec<Environment>),
    // rust: ClockTime {
    // rust: clock: String,
    // rust: time: i64,
    // rust: },
    // rust: Difficulty(u8),
    // rust: Functions {
    // rust: setup: Option<String>,
    // rust: teardown: Option<String>,
    // rust: },
    // rust: GameRules(Vec<(String, Value)>),
    /// `timeline_attributes`: Horizon has no environment attribute system to
    /// layer timelines on, so it changes nothing.
    // rust: Timelines,
    // rust: Weather(WeatherType),
}

/// The `SavedDataType` of an activated definition.
    // rust: pub(super) enum Saved {
    // rust: AllOf(Vec<(Environment, Saved)>),
    // rust: Clock(i64),
    // rust: Difficulty(u8),
    // rust: Unit,
    // rust: GameRules(Vec<(String, Value)>),
    // rust: Weather(WeatherType),
}

/// `TestEnvironmentDefinition.Activation`.
    // rust: pub(super) struct Activation {
    // rust: environment: Environment,
    // rust: saved: Saved,
}

/// Reads a definition from its JSON (`DIRECT_CODEC`); a string is the id of
/// a registry entry, read by `load`.
    // rust: pub(super) fn parse(
    // rust: json: &Json,
    // rust: load: &dyn Fn(&str) -> Option<Json>,
    // rust: depth: u32,
    // rust: ) -> Option<Environment> {
    // rust: if depth > 16 {
    // rust: return None;
}
    // rust: if let Some(id) = json.as_str() {
    // rust: return parse(&load(id)?, load, depth + 1);
}
    // rust: let kind = json.get("type")?.as_str()?;
    // rust: let kind = kind.strip_prefix("minecraft:").unwrap_or(kind);
    // rust: Some(match kind {
    // rust: "all_of" => Environment::AllOf(
    // rust: json.get("definitions")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|d| parse(d, load, depth + 1))
    // rust: .collect::<Option<_>>()?,
    // rust: ),
    // rust: "clock_time" => Environment::ClockTime {
    // rust: clock: json.get("clock")?.as_str()?.to_owned(),
    // rust: time: json.get("time")?.as_i64().filter(|t| *t >= 0)?,
    // rust: },
    // rust: "difficulty" => Environment::Difficulty(
    // rust: ["peaceful", "easy", "normal", "hard"]
    // rust: .iter()
    // rust: .position(|d| Some(*d) == json.get("difficulty").and_then(Json::as_str))?
    // rust: as u8,
    // rust: ),
    // rust: "function" => Environment::Functions {
    // rust: setup: json.get("setup").and_then(Json::as_str).map(str::to_owned),
    // rust: teardown: json
    // rust: .get("teardown")
    // rust: .and_then(Json::as_str)
    // rust: .map(str::to_owned),
    // rust: },
    // rust: "game_rules" => Environment::GameRules(
    // rust: json.get("rules")?
    // rust: .as_object()?
    // rust: .iter()
    // rust: .map(|(name, v)| {
    // rust: let rule = gamerules::rule(name)?;
    // rust: let value = match (v.as_bool(), v.as_i64()) {
    // rust: (Some(b), _) => Value::Bool(b),
    // rust: (_, Some(i)) => Value::Int(i32::try_from(i).ok()?),
    // rust: _ => return None,
}
    // rust: Some((rule.name.to_owned(), value))
    // rust: })
    // rust: .collect::<Option<_>>()?,
    // rust: ),
    // rust: "timeline_attributes" => Environment::Timelines,
    // rust: "weather" => Environment::Weather(WeatherType::from_name(json.get("weather")?.as_str()?)?),
    // rust: _ => return None,
    // rust: })
}

    // rust: impl Game<'_> {
    /// The data pack entry `data/<ns>/test_environment/<path>.json`.
pub fn read_test_environment_json(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let file = self
    // rust: .options
    // rust: .resources
    // rust: .join("data")
    // rust: .join(ns)
    // rust: .join("test_environment")
    // rust: .join(format!("{path}.json"));
    // rust: serde_json::from_slice(&std::fs::read(file).ok()?).ok()
}

    /// The definition of a batch's environment (`batch()` of its tests).
    // rust: pub(super) fn test_environment(&self, id: &str) -> Option<Environment> {
    // rust: parse(
    // rust: &Json::String(id.to_owned()),
    // rust: &|i| self.read_test_environment_json(i),
    // rust: 0,
    // rust: )
}

    /// `TestEnvironmentDefinition.activate`.
    // rust: pub(super) fn activate_test_environment(&mut self, environment: Environment) -> Activation {
    // rust: let saved = self.set_up_environment(&environment);
    // rust: Activation { environment, saved }
}

    /// `Activation.teardown`.
    // rust: pub(super) fn tear_down_test_environment(&mut self, activation: Activation) {
    // rust: self.tear_down_environment(&activation.environment, activation.saved);
}

pub fn set_up_environment(self: *Self, environment: *Environment) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match environment {
    // rust: Environment::AllOf(all) => Saved::AllOf(
    // rust: all.iter()
    // rust: .map(|e| (e.clone(), self.set_up_environment(e)))
    // rust: .collect(),
    // rust: ),
    // rust: Environment::ClockTime { clock, time } => {
                // Only the overworld clock runs in Horizon.
    // rust: let previous = self.world.day_time;
    // rust: if clock == "minecraft:overworld" {
    // rust: self.world.day_time = *time;
    // rust: self.ui.clock.partial = 0.0;
}
    // rust: Saved::Clock(previous)
}
    // rust: Environment::Difficulty(d) => {
    // rust: let previous = self.ui.difficulty;
    // rust: self.set_difficulty_forced(*d);
    // rust: Saved::Difficulty(previous)
}
    // rust: Environment::Functions { setup, .. } => {
    // rust: if let Some(id) = setup {
    // rust: self.run_environment_function(id);
}
    // rust: Saved::Unit
}
    // rust: Environment::GameRules(rules) => {
    // rust: let original = rules
    // rust: .iter()
    // rust: .filter_map(|(name, _)| {
    // rust: let rule = gamerules::rule(name)?;
    // rust: Some((
    // rust: rule.name.to_owned(),
    // rust: self.ui.rules.get(rule.name).unwrap_or(rule.default),
    // rust: ))
    // rust: })
    // rust: .collect();
    // rust: self.set_environment_rules(rules);
    // rust: Saved::GameRules(original)
}
    // rust: Environment::Timelines => Saved::Unit,
    // rust: Environment::Weather(kind) => {
    // rust: let w = &self.world.weather;
    // rust: let previous = if w.thundering {
    // rust: WeatherType::Thunder
    // rust: } else if w.raining {
    // rust: WeatherType::Rain
    // rust: } else {
    // rust: WeatherType::Clear
}
    // rust: self.set_weather_type(*kind);
    // rust: Saved::Weather(previous)
}
}
}

pub fn tear_down_environment(self: *Self, environment: *Environment, saved: Saved) void {
}
    // rust: match (environment, saved) {
    // rust: (Environment::AllOf(_), Saved::AllOf(all)) => {
    // rust: for (e, s) in all.into_iter().rev() {
    // rust: self.tear_down_environment(&e, s);
}
}
    // rust: (Environment::ClockTime { clock, .. }, Saved::Clock(previous)) => {
    // rust: if clock == "minecraft:overworld" {
    // rust: self.world.day_time = previous;
    // rust: self.ui.clock.partial = 0.0;
}
}
    // rust: (_, Saved::Difficulty(d)) => self.set_difficulty_forced(d),
    // rust: (
    // rust: Environment::Functions {
    // rust: teardown: Some(id), ..
    // rust: },
    // rust: Saved::Unit,
    // rust: ) => self.run_environment_function(id),
    // rust: (_, Saved::GameRules(original)) => self.set_environment_rules(&original),
    // rust: (_, Saved::Weather(previous)) => {
                // resetWeatherCycle, then the saved type.
    // rust: let w = &mut self.world.weather;
    // rust: w.rain_time = 0;
    // rust: w.raining = false;
    // rust: w.thunder_time = 0;
    // rust: w.thundering = false;
    // rust: self.set_weather_type(previous);
}
    // rust: _ => {}
}
}

    /// `GameRules.setAll`.
pub fn set_environment_rules(self: *Self, rules: *[([]const u8) void {
}
    // rust: for (name, value) in rules {
    // rust: if let Some(rule) = gamerules::rule(name) {
    // rust: self.ui.rules.set(rule.name, *value);
}
}
    // rust: self.sync_rules();
}

    /// `Weather.Type.apply`: `ServerLevel.setWeatherParameters`.
pub fn set_weather_type(self: *Self, kind: WeatherType) void {
}
    // rust: let (clear, rain, raining, thundering) = kind.parameters();
    // rust: let w = &mut self.world.weather;
    // rust: w.clear_time = clear;
    // rust: w.rain_time = rain;
    // rust: w.thunder_time = rain;
    // rust: w.raining = raining;
    // rust: w.thundering = thundering;
}

    /// `Functions.run`: the function with game master permission and
    /// suppressed output; a missing one is logged.
pub fn run_environment_function(self: *Self, id: []const u8) void {
}
    // rust: let id = if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: let found = self
    // rust: .functions_named(&id)
    // rust: .ok()
    // rust: .and_then(|f| f.into_iter().next());
    // rust: match found {
    // rust: Some(function) => {
    // rust: let source = crate::game::commands::execute::Source {
    // rust: silent: true,
    // rust: ..self.server_source()
}
    // rust: self.exec.commands = 0;
    // rust: let _ = self.run_function(&function, None, source);
}
    // rust: None => log::error!("Test Batch failed for non-existent function {id}"),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

pub fn load(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:night" => Some(
    // rust: json!({"type": "minecraft:clock_time", "clock": "minecraft:overworld", "time": 18000}),
    // rust: ),
    // rust: _ => None,
}
}

pub fn definitions_parse_with_references_and_nesting() void {
}
    // rust: let json = json!({
    // rust: "type": "minecraft:all_of",
    // rust: "definitions": [
    // rust: "minecraft:night",
    // rust: {"type": "minecraft:weather", "weather": "thunder"},
    // rust: {"type": "minecraft:game_rules", "rules": {"minecraft:advance_time": false}},
    // rust: {"type": "minecraft:difficulty", "difficulty": "hard"},
    // rust: {"type": "minecraft:function", "setup": "test:on"}
    // rust: ]
    // rust: });
    // rust: let Some(Environment::AllOf(all)) = parse(&json, &load, 0) else {
    // rust: panic!("not all_of");
}
    // rust: assert_eq!(
    // rust: all[0],
    // rust: Environment::ClockTime {
    // rust: clock: "minecraft:overworld".into(),
    // rust: time: 18000
}
    // rust: );
    // rust: assert_eq!(all[1], Environment::Weather(WeatherType::Thunder));
    // rust: assert!(matches!(&all[2], Environment::GameRules(r) if r.len() == 1));
    // rust: assert_eq!(all[3], Environment::Difficulty(3));
    // rust: assert_eq!(
    // rust: all[4],
    // rust: Environment::Functions {
    // rust: setup: Some("test:on".into()),
    // rust: teardown: None
}
    // rust: );
}

pub fn unknown_or_invalid_definitions_do_not_parse() void {
}
    // rust: assert_eq!(parse(&json!("minecraft:missing"), &load, 0), None);
    // rust: assert_eq!(parse(&json!({"type": "minecraft:nothing"}), &load, 0), None);
    // rust: assert_eq!(
    // rust: parse(
    // rust: &json!({"type": "minecraft:clock_time", "clock": "c", "time": -1}),
    // rust: &load,
    // rust: 0
    // rust: ),
    // rust: None
    // rust: );
}

pub fn weather_types_set_vanillas_timers() void {
}
    // rust: assert_eq!(WeatherType::Clear.parameters(), (100_000, 0, false, false));
    // rust: assert_eq!(WeatherType::Thunder.parameters(), (0, 100_000, true, true));
}
}
