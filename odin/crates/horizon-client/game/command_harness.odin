//! Transpiled from Horizon Rust crate
package horizon_client_command_harness

import "core:fmt"
import "core:mem"
import "core:math"

// Headless command runner for `tools/test_command_exec_parity.py`: with
// `HORIZON_COMMAND_SCRIPT` and `HORIZON_COMMAND_OUTPUT` set, the opened world
// runs on its server thread with a connected, headless client. Each script
// line is a JSON operation: `cmd` runs a
// command as the player (Commands.performPrefixedCommand) and records every
// system message it produced, as styled spans, with the results reported to
// the player's `CommandResultCallback`; `tick` advances the game; `settle`
// waits until the terrain and entities around the player are loaded;
// `use_item` dispatches the main-hand server packet; `map_state` reads saved map metadata;
// `use_block` uses the main hand at a block top;
// `break` destroys a block as the server player; `portal` sends the player
// through the nether portal it stands in; `falling` counts physical falling
// blocks by dimension, block and gravity.
// use super::Game;
// use horizon_client::{Result, text::Text};
// use serde_json::{Value, json};
// use std::{
    // rust: path::Path,
    // rust: time::{Duration, Instant},
}

// A message as `[text, style]` runs with adjacent equal styles merged; the
// style lists colour, bold, italic, underlined, strikethrough, obfuscated
// and the suggested command.
    // rust: pub(super) fn spans(text: &Text) -> Value {
    // rust: let mut out: Vec<(String, Value)> = Vec::new();
    // rust: for span in &text.spans {
    // rust: if span.text.is_empty() {
    // rust: continue;
}
    // rust: let s = &span.style;
    // rust: let style = json!([
    // rust: s.color,
    // rust: s.bold == Some(true),
    // rust: s.italic == Some(true),
    // rust: s.underlined == Some(true),
    // rust: s.strikethrough == Some(true),
    // rust: s.obfuscated == Some(true),
    // rust: ]);
    // rust: match out.last_mut() {
    // rust: Some((t, last)) if *last == style => t.push_str(&span.text),
    // rust: _ => out.push((span.text.clone(), style)),
}
}
    // rust: Value::Array(out.into_iter().map(|(t, s)| json!([t, s])).collect())
}

    // rust: impl Game<'_> {
    // Pump the real client's connection, without predicting movement: the
    // oracle's player stays where commands put it. Errors cross the server
    // boundary through Integrated::stop, including script and save failures.
    // rust: pub(super) fn wait_command_harness(&mut self) -> Result<()> {
    // rust: let server = self.integrated.take().ok_or("command harness: no server")?;
    // rust: let client_config = std::env::var_os("HORIZON_HARNESS_CLIENT_CONFIG");
    // rust: let mut wrote_config = false;
    // rust: while !server.stopped() {
    // rust: self.poll_stationary_client()?;
    // rust: if !wrote_config
    // rust: && let Some(path) = &client_config
    // rust: && let Some(remote) = self.remote.as_ref().filter(|r| r.logged_in && r.joined)
    // rust: {
    // rust: std::fs::write(
    // rust: path,
    // rust: json!({
    // rust: "view_distance": remote.view_distance,
    // rust: "simulation_distance": remote.simulation_distance,
    // rust: "render_setting": self.settings.render_distance,
    // rust: "simulation_setting": self.settings.simulation_distance,
    // rust: "logged_in": remote.logged_in, "joined": remote.joined,
    // rust: })
    // rust: .to_string(),
    // rust: )?;
    // rust: wrote_config = true;
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
    // rust: server.stop()
}

    // The owner's authoritative body and level, using the same swaps as a
    // server command. Always put them back, also when a script operation fails.
    // rust: fn harness_owner<T>(&mut self, f: impl FnOnce(&mut Self) -> Result<T>) -> Result<T> {
    // rust: let owner = self
    // rust: .serving
    // rust: .as_ref()
    // rust: .ok_or("command harness: not a server")?
    // rust: .owner;
    // rust: let mut host = self.lan.take().ok_or("command harness: no hub")?;
    // rust: let guest = host.hub.guests.iter().find(|g| g.uuid == owner && g.placed);
    // rust: let Some(guest) = guest else {
    // rust: self.lan = Some(host);
    // rust: return Err("command harness: owner is not connected".into());
}
    // rust: let (conn, dim, back) = (guest.conn, super::Dim::from_id(&guest.dimension), self.dim);
    // rust: if let Err(error) = self.enter_level(Some(&mut host), dim) {
    // rust: self.lan = Some(host);
    // rust: return Err(error);
}
    // rust: let swap = self
    // rust: .enter_guest(&mut host, conn, back)
    // rust: .expect("the owner is not already acting");
    // rust: self.lan = Some(host);
    // rust: let result = f(self);
    // rust: let mut host = self.lan.take().expect("the operation puts the hub back");
    // rust: self.leave_guest(&mut host, swap);
    // rust: host.hub.sync_all_effects();
    // rust: self.run_level_teleports(&mut host);
    // rust: let restored = self.enter_level(Some(&mut host), back);
    // rust: self.lan = Some(host);
    // rust: restored?;
    // rust: result
}

    // The connected owner's authoritative block/crafting menu, without
    // client prediction. Only its own slots are counted (not the inventory).
harness_owner_menu :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let owner = self.serving.as_ref().ok_or("menu state: no server")?.owner;
    // rust: self.in_owner_level(|g| {
    // rust: let host = g.lan.as_ref().ok_or("menu state: no hub")?;
    // rust: let guest = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|p| p.uuid == owner && p.placed)
    // rust: .ok_or("menu state: owner is not connected")?;
    // rust: if let Some(menu) = &guest.menu {
    // rust: return Ok((guest.conn, menu.size, menu.window));
}
    // rust: if let Some((window, _, menu, _)) = host
    // rust: .play
    // rust: .get(&guest.conn)
    // rust: .and_then(|p| p.crafting.table.as_ref())
    // rust: {
    // rust: return Ok((guest.conn, menu.slot_count() - 36, *window));
}
    // rust: Ok((guest.conn, 0, 0))
    // rust: })
}

    // The player's portal process finished in the nether portal it stands
    // in (the oracle's player is not ticked, so neither is the wait).
harness_portal :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (conn, plan) = self.harness_owner(|g| {
    // rust: let p = g
    // rust: .player
    // rust: .as_ref()
    // rust: .ok_or("command harness: portal without a player")?;
    // rust: let entry = horizon_core::position::BlockPos::containing(p.position);
    // rust: let block = g.world.block(entry.x, entry.y, entry.z);
    // rust: if &*g.res.facts().get(block).name != "minecraft:nether_portal" {
    // rust: return Err("command harness: the player is not in a nether portal".into());
}
    // rust: let plan = g.portal_plan(
    // rust: entry,
    // rust: p.position,
    // rust: p.dimensions.width,
    // rust: p.dimensions.height,
    // rust: true,
    // rust: );
    // rust: Ok((
    // rust: g.lan_acting.ok_or("command harness: no acting owner")?,
    // rust: plan,
    // rust: ))
    // rust: })?;
        // Start travel after restoring the owner's body: change_level updates
        // its hub record, which leave_guest would otherwise overwrite.
    // rust: self.in_owner_level(|g| {
    // rust: let mut host = g.lan.take().ok_or("command harness: no hub")?;
    // rust: g.start_server_trip(&mut host, conn, plan.dim, Some(plan));
    // rust: g.lan = Some(host);
    // rust: Ok(())
    // rust: })
}
    // Load terrain until the player stands in lit chunks.
harness_settle :: proc(self: ^Self, deadline: Instant, required: Maybe(^Value)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: self.update_world();
            // The oracle's settle takes its tickets at once (getChunk runs the
            // DistanceManager updates); a tick would refresh these too, but a
            // settle runs none, and `/execute if loaded` reads them.
    // rust: self.update_chunk_tickets();
    // rust: if let Some(p) = &self.player {
    // rust: let (cx, cz) = (
    // rust: (p.position.x.floor() as i32) >> 4,
    // rust: (p.position.z.floor() as i32) >> 4,
    // rust: );
                // Finish requested terrain before inspecting it, so worker
                // timing cannot change which command positions are loaded.
    // rust: if (std::env::var_os("HORIZON_HARNESS_TERRAIN_ONLY").is_some()
    // rust: || !self.streaming.busy())
    // rust: && required.and_then(Value::as_array).map_or_else(
    // rust: || {
    // rust: (-1..=1).all(|dz| {
    // rust: (-1..=1).all(|dx| self.streaming.is_lit(cx + dx, cz + dz))
    // rust: })
    // rust: },
    // rust: |chunks| {
    // rust: chunks.iter().all(|chunk| {
    // rust: chunk[0]
    // rust: .as_i64()
    // rust: .zip(chunk[1].as_i64())
    // rust: .is_some_and(|(x, z)| self.streaming.is_lit(x as i32, z as i32))
    // rust: })
    // rust: },
    // rust: )
    // rust: {
                    // The oracle's settle also waits for the entities saved
                    // in those chunks (areEntitiesActuallyLoadedAndTicking):
                    // after a dimension change they come back from the save.
    // rust: self.spawn_loaded_entities();
    // rust: return Ok(());
}
}
    // rust: if std::env::var_os("HORIZON_HARNESS_DEBUG").is_some() {
    // rust: eprintln!(
    // rust: "settle: player {:?} center {:?} chunks {} pending {}",
    // rust: self.player.as_ref().map(|p| p.position),
    // rust: self.streaming.center,
    // rust: self.world.chunks.len(),
    // rust: self.streaming.pending()
    // rust: );
}
    // rust: if Instant::now() > deadline {
    // rust: return Err("command harness: terrain did not load".into());
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
}
    // rust: pub(super) fn run_command_harness(&mut self, script: &Path, output: &Path) -> Result<()> {
    // rust: let deadline = Instant::now()
    // rust: + Duration::from_secs(
    // rust: std::env::var("HORIZON_HARNESS_TIMEOUT")
    // rust: .ok()
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(600),
    // rust: );
        // Join/configuration uses the normal hub, but never advances the world.
    // rust: while !self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|h| h.hub.guests.iter().any(|g| g.placed && g.loaded))
    // rust: {
    // rust: self.tick_server(true)?;
    // rust: if Instant::now() > deadline {
    // rust: return Err("command harness: owner did not connect".into());
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
    // rust: self.harness_owner(|g| g.harness_settle(deadline, None))?;
    // rust: if let Some(path) = std::env::var_os("HORIZON_FISHING_TICK_REFERENCE") {
    // rust: let rows = self.harness_owner(|g| Ok(g.fishing_tick_reference()))?;
    // rust: std::fs::write(path, serde_json::to_vec(&rows)?)?;
}
    // rust: if let Some(path) = std::env::var_os("HORIZON_FISHING_BOBBING_REFERENCE") {
    // rust: let rows = self.harness_owner(|g| Ok(g.fishing_bobbing_reference()))?;
    // rust: std::fs::write(path, serde_json::to_vec(&rows)?)?;
}
    // rust: if let Some(path) = std::env::var_os("HORIZON_FISHING_FALLBACK_REFERENCE") {
    // rust: let rows = self.harness_owner(|g| Ok(g.fishing_fallback_reference()))?;
    // rust: std::fs::write(path, serde_json::to_vec(&rows)?)?;
}
    // rust: let mut out = String::new();
    // rust: for line in std::fs::read_to_string(script)?.lines() {
    // rust: if line.trim().is_empty() {
    // rust: continue;
}
    // rust: let op: Value = serde_json::from_str(line)?;
    // rust: match op["op"].as_str().unwrap_or("") {
    // rust: "cmd" => {
    // rust: let command = op["cmd"].as_str().unwrap_or("");
    // rust: self.chat_capture = Some(Vec::new());
    // rust: self.cmds.results = Some(Vec::new());
    // rust: self.harness_owner(|g| {
    // rust: g.as_console(|g| {
    // rust: g.run_command(command.strip_prefix('/').unwrap_or(command))
    // rust: });
    // rust: Ok(())
    // rust: })?;
    // rust: let messages = self.chat_capture.take().unwrap_or_default();
    // rust: let results = self.cmds.results.take().unwrap_or_default();
    // rust: if op["record"].as_bool() != Some(false) || op["trace"].as_bool() == Some(true)
    // rust: {
    // rust: let record = json!({
    // rust: "cmd": command,
    // rust: "messages": messages.iter().map(spans).collect::<Vec<_>>(),
    // rust: "results": results.iter().map(|(s, v)| json!([s, v])).collect::<Vec<_>>(),
    // rust: });
    // rust: if op["trace"].as_bool() == Some(true) {
    // rust: eprintln!("command trace: {record}");
}
    // rust: if op["record"].as_bool() != Some(false) {
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
}
}
    // rust: "mob_anger" => {
                    // Metadata-state equality through the production writer, not packet delivery.
    // rust: let uuid = u128::from_str_radix(
    // rust: &op["uuid"]
    // rust: .as_str()
    // rust: .ok_or("anger state: missing UUID")?
    // rust: .replace('-', ""),
    // rust: 16,
    // rust: )?;
    // rust: let index = op["index"].as_u64().ok_or("anger state: missing index")? as u8;
    // rust: let state = self.harness_owner(|g| {
    // rust: let Some(super::commands::Target::Mob(id)) = g.target_by_uuid(uuid) else {
    // rust: return Err("anger state: UUID is not a loaded mob".into());
}
    // rust: let actual = g
    // rust: .persist
    // rust: .uuids
    // rust: .get(&id)
    // rust: .copied()
    // rust: .ok_or("anger state: no saved UUID")?;
    // rust: if horizon_client::lan::playerdata::ints_uuid(actual) != uuid {
    // rust: return Err("anger state: UUID mismatch".into());
}
    // rust: let m = g
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && m.alive() && !m.removed)
    // rust: .ok_or("anger state: missing live actor")?;
    // rust: if Some(m.kind.id.as_str()) != op["kind"].as_str() {
    // rust: return Err("anger state: wrong actor type".into());
}
    // rust: let hub = &g.lan.as_ref().ok_or("anger state: no connected hub")?.hub;
    // rust: let (mut meta, mut defaults) = (Vec::new(), Vec::new());
    // rust: super::lan::mob_meta(
    // rust: m,
    // rust: hub,
    // rust: None,
    // rust: g.world.game_time,
    // rust: &mut meta,
    // rust: &mut defaults,
    // rust: );
    // rust: let entry = meta
    // rust: .iter()
    // rust: .find(|e| e.0 == index)
    // rust: .or_else(|| defaults.iter().find(|e| e.0 == index))
    // rust: .ok_or("anger state: metadata entry/default absent")?;
    // rust: if entry.1 != horizon_protocol::entity_data::serializer::LONG {
    // rust: return Err("anger state: metadata serializer is not LONG".into());
}
    // rust: let horizon_protocol::entity_data::Value::Long(value) = &entry.2 else {
    // rust: return Err("anger state: metadata value is not long".into());
}
    // rust: Ok(json!({"uuid":actual,"kind":m.kind.id,"index":index,
    // rust: "serializer":entry.1,"value":value,"game_time":g.world.game_time}))
    // rust: })?;
    // rust: out.push_str(
    // rust: &json!({"cmd":format!("#mob_anger {}",op["label"].as_str().unwrap_or("")),
    // rust: "messages":[],"results":[],"state":state})
    // rust: .to_string(),
    // rust: );
    // rust: out.push('\n');
}
    // rust: "server_distances" => {
    // rust: let state = self.harness_owner(|g| {
    // rust: let hub = &g.lan.as_ref().ok_or("no connected hub")?.hub;
    // rust: Ok([hub.config.view_distance, hub.config.simulation_distance])
    // rust: })?;
    // rust: out.push_str(
    // rust: &json!({"cmd": "#server_distances", "messages": [],
    // rust: "results": state.map(|n| json!([true, n]))})
    // rust: .to_string(),
    // rust: );
    // rust: out.push('\n');
}
    // rust: "chunk_ready" => {
    // rust: let [x, z] =
    // rust: std::array::from_fn(|i| op["chunk"][i].as_i64().unwrap_or(0) as i32);
    // rust: let state = self.harness_owner(|g| {
    // rust: let resident = g.world.chunks.contains_key(&(x, z));
    // rust: Ok([
    // rust: resident,
    // rust: g.streaming.is_lit(x, z),
    // rust: resident
    // rust: && !g
    // rust: .world
    // rust: .loaded_entities
    // rust: .iter()
    // rust: .any(|(key, _)| *key == (x, z)),
    // rust: ])
    // rust: })?;
    // rust: out.push_str(
    // rust: &json!({"cmd": format!("#chunk_ready {x} {z}"), "messages": [],
    // rust: "results": state.map(|ready| json!([true, i32::from(ready)]))})
    // rust: .to_string(),
    // rust: );
    // rust: out.push('\n');
}
    // rust: "wait_chunks" => {
    // rust: let targets: Vec<(i32, i32)> = op["chunks"]
    // rust: .as_array()
    // rust: .ok_or("missing chunks")?
    // rust: .iter()
    // rust: .map(|p| {
    // rust: (
    // rust: p[0].as_i64().unwrap_or(0) as i32,
    // rust: p[1].as_i64().unwrap_or(0) as i32,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: self.harness_owner(|g| {
    // rust: loop {
    // rust: g.update_world();
    // rust: g.spawn_loaded_entities();
    // rust: if targets.iter().all(|&(x, z)| {
    // rust: g.world.chunks.contains_key(&(x, z))
    // rust: && g.streaming.is_lit(x, z)
    // rust: && !g
    // rust: .world
    // rust: .loaded_entities
    // rust: .iter()
    // rust: .any(|(key, _)| *key == (x, z))
    // rust: }) {
    // rust: break;
}
    // rust: if Instant::now() > deadline {
    // rust: return Err("initial target readiness timed out".into());
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
    // rust: Ok(())
    // rust: })?;
}
    // rust: "weather_state" => {
                    // Saved state guards, separate from effective-weather predicates.
    // rust: let state = self.harness_owner(|g| {
    // rust: let w = g.world.weather;
    // rust: Ok([
    // rust: i32::from(w.raining),
    // rust: i32::from(w.thundering),
    // rust: w.clear_time,
    // rust: w.rain_time,
    // rust: w.thunder_time,
    // rust: ])
    // rust: })?;
    // rust: let record = json!({
    // rust: "cmd": format!("#weather_state {}", op["label"].as_str().unwrap_or("")),
    // rust: "messages": [],
    // rust: "results": state.iter().map(|value| json!([true, value])).collect::<Vec<_>>(),
    // rust: });
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "mobs" => {
                    // Observe authoritative AI state without a control-socket race.
    // rust: let record = self.harness_owner(|g| Ok(g.control_mobs(128.0)))?;
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "player_loop" => {
    // rust: let ticks = op["n"].as_u64().unwrap_or(1);
    // rust: let count = |g: &mut Self| {
    // rust: Ok(g.stats
    // rust: .values
    // rust: .get("minecraft:custom")
    // rust: .and_then(|m| m.get("minecraft:play_time"))
    // rust: .copied()
    // rust: .unwrap_or(0))
}
    // rust: let before = self.harness_owner(count)?;
    // rust: self.chat_capture = Some(Vec::new());
    // rust: for _ in 0..ticks {
    // rust: self.tick_server(false)?;
}
    // rust: let messages = self.chat_capture.take().unwrap_or_default();
    // rust: let delta = self.harness_owner(count)? - before;
    // rust: if delta != ticks as i32 {
    // rust: return Err(format!(
    // rust: "player loop did not advance play_time: {delta}/{ticks}"
    // rust: )
    // rust: .into());
}
    // rust: let record = json!({"cmd": format!("#player_loop {}",op["label"].as_str().unwrap_or("")), "messages": messages.iter().map(spans).collect::<Vec<_>>(), "results": [[true,delta]]});
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "player_state" => {
    // rust: let state = self.harness_owner(|g| {
    // rust: let p = g.player.as_ref().ok_or("player state: no actor")?;
    // rust: let mut loaded = Vec::new();
    // rust: let mut done = std::collections::BTreeMap::new();
    // rust: for a in g.adv.tree.list.iter().filter(|a| a.id.starts_with("h311:")) {
    // rust: loaded.push(a.id.clone()); done.insert(a.id.clone(),g.adv.progress.done(a));
}
    // rust: loaded.sort();
    // rust: Ok(json!({"health":p.health.health(),"poison_ticks":g.potions.effects.list.iter().find(|e|e.id=="poison").map_or(0,|e|e.duration),"loaded":loaded,"done":done}))
    // rust: })?;
    // rust: let record = json!({"cmd":format!("#player_state {}",op["label"].as_str().unwrap_or("")),"messages":[],"results":[],"state":state});
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "tick" => {
    // rust: self.chat_capture = Some(Vec::new());
    // rust: let paced_start = Instant::now();
    // rust: for i in 0..op["n"].as_u64().unwrap_or(1) {
                        // The oracle's profile resolver answers at once; the
                        // game's asks the services (none here: they refuse at
                        // once) on a thread, which a tick can outrun.
    // rust: let asked = Instant::now();
    // rust: while self.profile_fetches_pending()
    // rust: && asked.elapsed() < Duration::from_secs(10)
    // rust: {
    // rust: std::thread::sleep(Duration::from_millis(1));
}
    // rust: self.tick_server(false)?;
    // rust: if let Some(ms) = op["pace_ms"].as_u64() {
    // rust: std::thread::sleep(
    // rust: Duration::from_millis(ms * (i + 1))
    // rust: .saturating_sub(paced_start.elapsed()),
    // rust: );
}
}
    // rust: if op["pace_ms"].is_number() {
    // rust: eprintln!(
    // rust: "harness paced wait: {} ticks, {} ms",
    // rust: op["n"],
    // rust: paced_start.elapsed().as_millis()
    // rust: );
}
    // rust: let messages = self.chat_capture.take().unwrap_or_default();
    // rust: if op["record"].as_bool() == Some(true) {
    // rust: let record = json!({
    // rust: "cmd": "#tick",
    // rust: "messages": messages.iter().map(spans).collect::<Vec<_>>(),
    // rust: "results": [],
    // rust: });
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
}
    // rust: "settle" => {
                    // Finish portal arrivals using connection-only passes too.
    // rust: while !self.server_trips.is_empty() {
    // rust: self.tick_server(true)?;
    // rust: if Instant::now() > deadline {
    // rust: return Err("command harness: portal did not arrive".into());
}
    // rust: std::thread::sleep(Duration::from_millis(2));
}
    // rust: self.harness_owner(|g| g.harness_settle(deadline, op.get("required_chunks")))?;
}
    // rust: "use_item" if op.get("sequence").is_some() => {
                    // Exercise the connected owner's normal server packet route.
    // rust: let sequence = op["sequence"].as_i64().unwrap_or(0) as i32;
    // rust: let yaw = op["yaw"].as_f64().unwrap_or(0.0) as f32;
    // rust: let pitch = op["pitch"].as_f64().unwrap_or(0.0) as f32;
    // rust: let owner = self
    // rust: .serving
    // rust: .as_ref()
    // rust: .ok_or("command harness: no server")?
    // rust: .owner;
    // rust: self.in_owner_level(|g| -> Result<()> {
    // rust: let conn = g
    // rust: .lan
    // rust: .as_ref()
    // rust: .and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|guest| guest.uuid == owner && guest.placed)
    // rust: .map(|guest| guest.conn)
    // rust: })
    // rust: .ok_or("command harness: owner is not connected")?;
    // rust: let mut host = g.lan.take().ok_or("command harness: no hub")?;
    // rust: g.lan_guest_packet(
    // rust: &mut host,
    // rust: conn,
    // rust: horizon_protocol::packets::play::Serverbound::UseItem(
    // rust: horizon_protocol::packets::play::UseItem {
    // rust: hand: 0,
    // rust: yaw,
    // rust: pitch,
    // rust: sequence,
    // rust: },
    // rust: ),
    // rust: );
    // rust: let ack = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .is_some_and(|g| g.ack_up_to.get() >= sequence);
    // rust: g.lan = Some(host);
    // rust: if !ack {
    // rust: return Err("command harness: UseItem was not acknowledged".into());
}
    // rust: Ok(())
    // rust: })?;
}
                // Java produced the fixture file before this world was opened; map_state loads it.
    // rust: "crafter_max_map_fixture" => {}
    // rust: "use_item" => {
    // rust: let owner = self
    // rust: .serving
    // rust: .as_ref()
    // rust: .ok_or("command harness: no server")?
    // rust: .owner;
    // rust: self.in_owner_level(|g| -> Result<()> {
    // rust: let conn = g
    // rust: .lan
    // rust: .as_ref()
    // rust: .and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|guest| guest.uuid == owner && guest.placed)
    // rust: .map(|guest| guest.conn)
    // rust: })
    // rust: .ok_or("command harness: owner is not connected")?;
    // rust: let mut host = g.lan.take().ok_or("command harness: no hub")?;
    // rust: g.lan_guest_packet(
    // rust: &mut host,
    // rust: conn,
    // rust: horizon_protocol::packets::play::Serverbound::UseItem(
    // rust: horizon_protocol::packets::play::UseItem {
    // rust: hand: 0,
    // rust: sequence: 0,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: },
    // rust: ),
    // rust: );
    // rust: g.lan = Some(host);
    // rust: Ok(())
    // rust: })?;
}
    // rust: "frame_map_state" => {
                    // Read saved-map association and live decorations, not network delivery.
    // rust: let uuid = u128::from_str_radix(
    // rust: &op["uuid"]
    // rust: .as_str()
    // rust: .ok_or("frame map: missing UUID")?
    // rust: .replace('-', ""),
    // rust: 16,
    // rust: )?;
    // rust: let map_id = op["id"].as_i64().ok_or("frame map: missing map id")? as i32;
    // rust: let state = self.harness_owner(|g| {
    // rust: let Some(super::commands::Target::Frame(id)) = g.target_by_uuid(uuid) else {
    // rust: return Err("frame map: UUID is not a live frame".into());
}
    // rust: let actual = *g.persist.uuids.get(&id).ok_or("frame map: no UUID")?;
    // rust: let frame = g.item_frames.iter().find(|f| f.id == id)
    // rust: .ok_or("frame map: missing frame")?.clone();
    // rust: if horizon_client::lan::playerdata::ints_uuid(actual) != uuid {
    // rust: return Err("frame map: UUID mismatch".into());
}
    // rust: let map = g.map(map_id).ok_or("frame map: no backed map")?;
    // rust: let saved = map.to_nbt();
    // rust: let data = saved.get("data").ok_or("frame map: no saved data compound")?;
    // rust: let records = match data.get("frames") {
    // rust: None => &[][..], // the CODEC omits an empty list
    // rust: Some(horizon_world::nbt::Tag::List(list)) => list.as_slice(),
    // rust: _ => return Err("frame map: frames is not a list".into()),
}
    // rust: let record = records.iter().find(|r|
    // rust: horizon_client::save::number(r.get("entity_id")) == Some(i64::from(id)));
    // rust: let pos = record.map(|r| match r.get("pos") {
    // rust: Some(horizon_world::nbt::Tag::IntArray(pos)) => Ok(pos.clone()),
    // rust: _ => Err("frame map: invalid saved position"),
    // rust: }).transpose()?;
    // rust: let rotation = record.map(|r|
    // rust: horizon_client::save::number(r.get("rotation"))
    // rust: .ok_or("frame map: missing rotation")).transpose()?;
    // rust: Ok(json!({"id":map_id,"uuid":actual,"kind":frame.kind(),"pos":frame.pos,
    // rust: "center":map.center,"scale":map.scale,"dimension":map.dimension,
    // rust: "saved":record.is_some(),"saved_pos":pos,"saved_rotation":rotation,
    // rust: "decoration":map.decorations.iter().any(|d|d.key==super::maps::Key::Frame(id as i32)),
    // rust: "frame_records":records.len(),
    // rust: "frame_decorations":map.decorations.iter().filter(|d|d.sprite=="map/decorations/frame").count()}))
    // rust: })?;
    // rust: out.push_str(
    // rust: &json!({"cmd":format!("#frame_map {}",op["label"].as_str().unwrap_or("")),
    // rust: "messages":[],"results":[],"state":state})
    // rust: .to_string(),
    // rust: );
    // rust: out.push('\n');
}
    // rust: "map_state" => {
    // rust: let id = op["id"].as_i64().ok_or("command harness: map id")? as i32;
    // rust: let value = self.harness_owner(|g| {
    // rust: Ok(match g.map(id) {
    // rust: Some(m) => format!(
    // rust: "scale={},locked={},center={},{}",
    // rust: m.scale, m.locked, m.center[0], m.center[1]
    // rust: ),
    // rust: None => "missing".to_owned(),
    // rust: })
    // rust: })?;
    // rust: let record = json!({"cmd": format!("#map_state {id}"),
    // rust: "messages": [spans(&Text::literal(value))], "results": []});
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "light" => {
    // rust: let pos = std::array::from_fn::<_, 3, _>(|i| {
    // rust: op["pos"][i].as_i64().unwrap_or(0) as i32
    // rust: });
    // rust: let levels = self.harness_owner(|g| {
//                         use horizon_client::mobs::spawn_rules::SpawnLevel;
    // rust: let level = g.natural_level();
    // rust: Ok([
    // rust: level.block_light(pos[0], pos[1], pos[2]),
    // rust: level.sky_light(pos[0], pos[1], pos[2]),
    // rust: ])
    // rust: })?;
    // rust: let record = json!({"cmd": format!("#light {}", op["pos"]),
    // rust: "messages": [], "results": levels.map(|v| (true, v))});
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "menu_state" => {
    // rust: let (_, own_slots, _) = self.harness_owner_menu()?;
    // rust: let record = json!({"cmd": format!("#menu_state {}", op["label"].as_str().unwrap_or("")),
    // rust: "messages": [], "results": [], "state": {"own_slots": own_slots}});
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "close_menu" => {
    // rust: let (conn, _, window) = self.harness_owner_menu()?;
    // rust: self.in_owner_level(|g| -> Result<()> {
    // rust: let mut host = g.lan.take().ok_or("close menu: no hub")?;
    // rust: g.lan_guest_packet(
    // rust: &mut host,
    // rust: conn,
    // rust: horizon_protocol::packets::play::Serverbound::ContainerClose(
    // rust: horizon_protocol::packets::play::ContainerClose {
    // rust: container: window,
    // rust: },
    // rust: ),
    // rust: );
    // rust: g.lan = Some(host);
    // rust: Ok(())
    // rust: })?;
}
    // rust: "use_block" => {
                    // Exercise the connected owner's normal server packet route.
    // rust: let pos = std::array::from_fn(|i| op["pos"][i].as_i64().unwrap_or(0) as i32);
    // rust: let sequence = op["sequence"].as_i64().unwrap_or(0) as i32;
    // rust: let face = op["face"].as_i64().unwrap_or(1) as i32;
    // rust: let owner = self
    // rust: .serving
    // rust: .as_ref()
    // rust: .ok_or("command harness: no server")?
    // rust: .owner;
    // rust: self.in_owner_level(|g| -> Result<()> {
    // rust: let conn = g
    // rust: .lan
    // rust: .as_ref()
    // rust: .and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|guest| guest.uuid == owner && guest.placed)
    // rust: .map(|guest| guest.conn)
    // rust: })
    // rust: .ok_or("command harness: owner is not connected")?;
    // rust: let mut host = g.lan.take().ok_or("command harness: no hub")?;
    // rust: g.lan_guest_packet(
    // rust: &mut host,
    // rust: conn,
    // rust: horizon_protocol::packets::play::Serverbound::UseItemOn(
    // rust: horizon_protocol::packets::play::UseItemOn {
    // rust: hand: 0,
    // rust: pos,
    // rust: face,
    // rust: cursor: [0.5, 1.0, 0.5],
    // rust: inside: false,
    // rust: world_border: false,
    // rust: sequence,
    // rust: },
    // rust: ),
    // rust: );
    // rust: let acknowledged = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .is_some_and(|p| p.ack_up_to.get() >= sequence);
    // rust: g.lan = Some(host);
    // rust: if !acknowledged {
    // rust: return Err("use block: owner packet was not acknowledged".into());
}
    // rust: Ok(())
    // rust: })?;
}
    // rust: "crafter_tick" => {
    // rust: let [x, y, z] =
    // rust: std::array::from_fn(|i| op["pos"][i].as_i64().unwrap_or(0) as i32);
    // rust: self.harness_owner(|g| {
    // rust: let state = g.world.block(x, y, z);
    // rust: if &*g.res.facts().get(state).name != "minecraft:crafter" {
    // rust: return Err("command harness: crafter tick without a crafter".into());
}
    // rust: g.dispense_from(horizon_core::position::BlockPos::new(x, y, z), state)
    // rust: })?;
}
    // rust: "break" => {
    // rust: let pos = std::array::from_fn(|i| op["pos"][i].as_i64().unwrap_or(0) as i32);
    // rust: self.harness_owner(|g| g.break_block(pos))?;
}
    // rust: "portal" => self.harness_portal()?,
    // rust: "destroy_progress" => {
    // rust: let pos = std::array::from_fn(|i| op["pos"][i].as_i64().unwrap_or(0) as i32);
    // rust: let bits = self.harness_owner(|g| {
    // rust: if let Some(player) = g.player.as_mut() {
    // rust: player.ground.on_ground = true;
}
    // rust: Ok(g.destroy_progress(pos).to_bits())
    // rust: })?;
    // rust: let record = json!({
    // rust: "cmd": "#destroy_progress",
    // rust: "messages": [],
    // rust: "results": [[true, bits]],
    // rust: });
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: "falling" => {
                    // Physical falling blocks are not command-selector targets
                    // yet. Inspect the actual level rather than that unrelated gap.
    // rust: let dimension = op["dimension"].as_str().unwrap_or("minecraft:overworld");
    // rust: let block = op["block"].as_str().unwrap_or("minecraft:sand");
    // rust: let no_gravity = op["no_gravity"].as_bool().unwrap_or(false);
    // rust: let back = self.dim;
    // rust: self.enter_level(None, super::Dim::from_id(dimension))?;
    // rust: let facts = self.res.facts();
    // rust: let matches = |f: &super::FallingBlock| {
    // rust: &*facts.get(f.state).name == block && f.no_gravity == no_gravity
}
    // rust: let count = self.falling.iter().filter(|f| matches(f)).count();
    // rust: if op["discard"].as_bool() == Some(true) {
    // rust: self.falling.retain(|f| !matches(f));
}
    // rust: self.enter_level(None, back)?;
    // rust: let record = json!({
    // rust: "cmd": format!("#falling {dimension} {block} {no_gravity}"),
    // rust: "messages": [],
    // rust: "results": [[true, count]],
    // rust: });
    // rust: out.push_str(&record.to_string());
    // rust: out.push('\n');
}
    // rust: other => return Err(format!("command harness: unknown op {other}").into()),
}
}
    // rust: std::fs::write(output, out)?;
    // rust: Ok(())
}
}
