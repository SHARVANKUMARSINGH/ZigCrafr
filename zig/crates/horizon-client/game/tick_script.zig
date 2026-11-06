//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tick_script
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `HORIZON_TICK_SCRIPT=PATH` (tools/test_wire_stream_parity.py): a server's client plays a tick-indexed
//! script, the one the vanilla client plays in `VanillaTickScript.java`, so the two clients' serverbound
//! streams can be compared tick by tick. The harness writes the scenario to PATH (JSON `{"name", "ticks",
//! "steps": {"TICK": [LINE...]}}`, LINE a horizon-ctl line: `key w down`, `mouse left click`, `look 90 0`,
//! `click-slot 3`, `close`), then creates PATH with the extension `go`. From the next client tick the script
//! plays: its first tick sends `/wire-mark`, which marks it in the capture, then each tick's lines act
//! before the tick runs, as a player's input in the frame before it; when its ticks have run, the client
//! writes the scenario's name to PATH with the extension `done`.
// use super::Game;
// use super::event_loop::EventLoopCtl;
// use std::{collections::BTreeMap, path::PathBuf};

    // rust: pub(super) struct TickScript {
    /// PATH, when the variable is set.
    // rust: path: Option<PathBuf>,
    // rust: running: Option<Running>,
}

pub const Running = struct {
    name: []const u8,
    ticks: u32,
    steps: BTreeMap<u32,
    tick: u32,
};

    // rust: impl TickScript {
    // rust: pub(super) fn from_env() -> Self {
    // rust: Self {
    // rust: path: std::env::var_os("HORIZON_TICK_SCRIPT").map(PathBuf::from),
    // rust: running: None,
}
}
    /// Whether the variable is set (the frame asks before every tick).
    // rust: pub(super) fn armed(&self) -> bool {
    // rust: self.path.is_some()
}
}

/// The scenario at `text`: its name, its length in ticks and each tick's lines.
pub fn parse(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let json: serde_json::Value = serde_json::from_str(text).ok()?;
    // rust: let mut steps = BTreeMap::new();
    // rust: for (tick, lines) in json.get("steps")?.as_object()? {
    // rust: let lines = lines
    // rust: .as_array()?
    // rust: .iter()
    // rust: .filter_map(|l| l.as_str().map(str::to_owned))
    // rust: .collect();
    // rust: steps.insert(tick.parse().ok()?, lines);
}
    // rust: Some(Running {
    // rust: name: json.get("name")?.as_str()?.to_owned(),
    // rust: ticks: u32::try_from(json.get("ticks")?.as_u64()?).ok()?,
    // rust: steps,
    // rust: tick: 0,
    // rust: })
}

    // rust: impl Game<'_> {
    /// Before a client tick: start the scenario the harness handed over, or play this tick's lines.
    // rust: pub(super) fn tick_script_step(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: let Some(path) = self.tick_script.path.clone() else {
    // rust: return;
}
    // rust: if self.tick_script.running.is_none() {
    // rust: let go = path.with_extension("go");
    // rust: if self.remote.is_none() || !go.exists() {
    // rust: return;
}
    // rust: let _ = std::fs::remove_file(&go);
    // rust: let Some(script) = std::fs::read_to_string(&path).ok().and_then(|t| parse(&t)) else {
    // rust: log::warn!("Horizon: tick script {} is not a scenario", path.display());
    // rust: return;
}
    // rust: self.tick_script.running = Some(script);
    // rust: self.send_chat("/wire-mark");
}
    // rust: let Some(running) = self.tick_script.running.as_mut() else {
    // rust: return;
}
    // rust: let tick = running.tick;
    // rust: running.tick += 1;
    // rust: let lines = running.steps.remove(&tick).unwrap_or_default();
    // rust: let finished = (running.tick > running.ticks).then(|| running.name.clone());
    // rust: for line in lines {
    // rust: if !self.tick_script_click(&line) {
    // rust: self.replay_line(&line, event_loop);
}
}
    // rust: if let Some(name) = finished {
    // rust: self.tick_script.running = None;
    // rust: let _ = std::fs::write(path.with_extension("done"), name);
}
}
}

    // rust: impl Game<'_> {
    /// `click-slot SLOT [right] [shift]` without a renderer: horizon-ctl's version clicks where the
    /// slot is drawn, and `--headless` draws nothing. The vanilla driver clicks the menu itself
    /// (`MultiPlayerGameMode.handleContainerInput`), and so does this.
pub fn tick_script_click(self: *Self, line: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let words: Vec<&str> = line.split_whitespace().collect();
    // rust: let (Some(&"click-slot"), Some(Ok(slot))) =
    // rust: (words.first(), words.get(1).map(|w| w.parse()))
    // rust: else {
    // rust: return false;
}
    // rust: let input = if words.contains(&"shift") {
    // rust: horizon_client::menu::Input::QuickMove
    // rust: } else {
    // rust: horizon_client::menu::Input::Pickup
}
    // rust: self.remote_menu_ops(&[(Some(slot), i32::from(words.contains(&"right")), input)]);
    // rust: true
}
}

    // rust: mod tests {
//     use super::*;

pub fn a_scenario_names_its_ticks_and_their_lines() void {
}
    // rust: let s = parse(r#"{"name":"walk","ticks":40,"steps":{"0":["key w down"],"20":["key w up","look 90 0"]}}"#)
    // rust: .unwrap();
    // rust: assert_eq!((s.name.as_str(), s.ticks), ("walk", 40));
    // rust: assert_eq!(s.steps[&20], ["key w up", "look 90 0"]);
    // rust: assert!(parse(r#"{"name":"x","ticks":1,"steps":{"a":[]}}"#).is_none());
}
}
