//! Transpiled from Horizon Rust crate
package horizon_client_control

import "core:fmt"
import "core:mem"
import "core:math"

// Commands from the control socket (`horizon-ctl`), run on the game thread.
// use super::event_loop::EventLoopCtl;
// use super::{Game, Screen};
// use horizon_client::held::Source;
// use horizon_client::{Result, items::ItemStack};
// use horizon_core::geometry::Vec3;
// use serde_json::{Value, json};
// use std::{
    // rust: sync::mpsc::Sender,
    // rust: time::{Duration, Instant},
}
// use winit::{event::MouseButton, keyboard::KeyCode};

// The control protocol's version (`docs/api/stability.md`): before 1.0 an
// addition makes the next patch and a breaking change the next line.
PROTOCOL :: "0.1.0"

// The command groups the game serves, as `help` chains them: what `hello` reports as its features.
    // rust: const FEATURES: &[&str] = &[
    // rust: "game", "station", "blocks", "lan", "friends", "render", "sculk", "agent", "ui", "options",
    // rust: "events", "saves", "pad", "studio",
    // rust: ];

// `hello`: the protocol the socket speaks, the game's release and the command groups it serves.
hello :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({
    // rust: "protocol": PROTOCOL,
    // rust: "release": horizon_core::release::VERSION,
    // rust: "features": FEATURES,
    // rust: })
}

    // rust: const HELP: &[&str] = &[
    // rust: "hello                          the control protocol's version, the game's release and the command groups it serves",
    // rust: "status                         game, player, streaming and renderer state",
    // rust: "simulation                     authoritative projectiles in the owner's level",
    // rust: "server-hold on|off             hold simulation and player packets at a control-fixture barrier",
    // rust: "stall MILLISECONDS             stall the window thread (0..5000), leaving transport alive",
    // rust: "key KEY down|up|tap|repeat     press, release or auto-repeat a key (w a s d space shift ctrl e q esc f3 1-9 arrows ...)",
    // rust: "release                        release every key and mouse button",
    // rust: "mouse left|right|middle down|up|click",
    // rust: "look YAW PITCH                 set the view direction in degrees",
    // rust: "turn DYAW DPITCH               rotate the view",
    // rust: "tp X Y Z                       teleport the player",
    // rust: "hotbar 1-9                     select a hotbar slot",
    // rust: "give ITEM [COUNT]              add items to the inventory",
    // rust: "render-distance N              chunks, 2..128",
    // rust: "lod-distance N                 far surface chunks, 0 disables, up to1024",
    // rust: "time TICKS                     set the time of day",
    // rust: "summon KIND [X Y Z] [baby]     spawn a mob (in front of the player without a position)",
    // rust: "mobs [RADIUS]                  list mobs near the player with their AI state",
    // rust: "hurtlog                        the hurts taken and melee attacks made since the last call, per player (host and guests)",
    // rust: "fill X1 Y1 Z1 X2 Y2 Z2 BLOCK   set a box of loaded blocks",
    // rust: "resume                         leave the pause menu",
    // rust: "screenshot PATH                write the next frame as PNG",
    // rust: "chat TEXT                      send a chat line or /command as if typed",
    // rust: "type TEXT                      type into the open chat box (key enter tap sends)",
    // rust: "chat-log [N]                   the newest N chat messages (default 10)",
    // rust: "options [PAGE]                 open the options (video sound controls keybinds mouse chat accessibility language font packs mods graphics graphics-advanced graphics-hdr video-vanilla)",
    // rust: "stats [reset] [raw]            frame-time summary since the last reset (raw: every frame time too)",
    // rust: "narration                      the narrator's status and the last messages it was asked to say",
    // rust: "bench SECONDS                  reset stats, wait, then reply with the summary",
    // rust: "fly X1 Y1 Z1 X2 Y2 Z2 SECONDS [PITCH [raw]]  fly the camera along a line at constant speed, then reply with the frame summary (raw: every frame time too)",
    // rust: "open WORLD [SEED] [creative]   open or create a world from the title screen",
    // rust: "save                           save the world",
    // rust: "save-all                       save the world, rewriting every resident chunk",
    // rust: "connect HOST[:PORT] [NAME]     join a multiplayer server (offline mode) from the title screen",
    // rust: "chat MESSAGE                   send chat or a /command to the server",
    // rust: "disconnect                     leave the server for the server list",
    // rust: "respawn                        respawn after death on a server",
    // rust: "credits [poem] [SCROLL]        roll the credits (with the end poem), or hold them SCROLL pixels in",
    // rust: "quit                           save and exit",
    // rust: ];

// A straight camera path at constant speed, for repeatable benchmarks: the
// player is placed on it every frame, facing along it.
Flight :: struct {
    from: Vec3,
    to: Vec3,
    pitch: f32,
    started: Instant,
    seconds: f64,
    // Reply with every frame time too (`fly ... PITCH raw`).
    raw: bool,
    reply: Sender<string>,
    // The world's smoothed tick time each frame (the F3 server line): the
    // server thread's when single player runs on one.
    tick_ms: [dynamic]f32,
}

    // rust: impl Game<'_> {
    // Move the camera along the running flight; reply when it ends.
    // rust: pub(super) fn advance_flight(&mut self) {
    // rust: let tick_ms = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .map_or(self.debug_charts.smoothed_tick_ms, |s| s.smoothed_tick_ms());
    // rust: let Some(flight) = self.flight.as_mut() else {
    // rust: return;
}
    // rust: flight.tick_ms.push(tick_ms);
    // rust: let flight = &*flight;
    // rust: let t = (flight.started.elapsed().as_secs_f64() / flight.seconds).min(1.0);
    // rust: let (a, b) = (flight.from, flight.to);
    // rust: let d = [b.x - a.x, b.y - a.y, b.z - a.z];
    // rust: let at = Vec3::new(a.x + d[0] * t, a.y + d[1] * t, a.z + d[2] * t);
        // Minecraft yaw: 0 faces +Z, 90 faces -X.
    // rust: self.yaw = (-d[0]).atan2(d[2]).to_degrees() as f32;
    // rust: self.pitch = flight.pitch;
    // rust: if let Some(player) = self.player.as_mut() {
    // rust: player.position = at;
    // rust: player.velocity = Vec3::new(0.0, 0.0, 0.0);
    // rust: player.fall_distance = 0.0;
            // Stay where the flight ends (creative flight).
    // rust: player.flying = true;
    // rust: self.previous_position = at;
}
    // rust: if t >= 1.0
    // rust: && let Some(flight) = self.flight.take()
    // rust: {
    // rust: let mut summary = self.frame_stats.summary();
    // rust: self.add_async_occlusion_stats(&mut summary);
    // rust: let n = flight.tick_ms.len().max(1) as f32;
    // rust: summary["tick_ms"] = (flight.tick_ms.iter().sum::<f32>() / n).into();
    // rust: summary["tick_ms_max"] = flight.tick_ms.iter().copied().fold(0.0, f32::max).into();
    // rust: if flight.raw {
    // rust: summary["frame_ms"] = self.frame_stats.frame_millis().into();
    // rust: summary["cpu_ms"] = self.frame_stats.cpu_millis().into();
    // rust: summary["gpu_ms"] = self.frame_stats.gpu_millis().into();
}
    // rust: let _ = flight.reply.send(summary.to_string());
}
}
    // The game's settings a render capture records beside the renderer's own state.
render_capture_settings :: proc(self: ^Self) -> h {
    // Ported from Horizon
    return {}
}
    // rust: let s = &self.settings;
    // rust: horizon_client::gfx::capture::Settings {
    // rust: graphics_api: format!("{:?}", s.horizon.api),
    // rust: translucent_batching: s.horizon.translucent_batching,
    // rust: texture_filtering: s.file.int("textureFiltering"),
    // rust: anisotropy_bit: s.file.int("maxAnisotropyBit"),
    // rust: mipmap_levels: s.mipmap_levels.max(0) as u32,
    // rust: resolution_scale: s.horizon.resolution_scale as f32 / 100.0,
    // rust: fxaa: s.horizon.fxaa,
    // rust: taa: s.horizon.taa,
    // rust: upscale: s.horizon.upscaling.ratio(),
    // rust: render_distance: self.streaming.radius,
    // rust: lod_distance: self.far_terrain_choice().0,
    // rust: resources: self.options.resources.clone(),
    // rust: atlas: horizon_client::gfx::capture::AtlasCheck::of(&self.pack.render),
}
}
    // The frame summary, with Horizon's own passes' median GPU times while they are timed.
summary_with_passes :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut summary = self.frame_stats.summary();
    // rust: let passes = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| r.own_pass_times())
    // rust: .unwrap_or_default();
    // rust: if !passes.is_empty() {
    // rust: summary["gpu_passes"] = Value::Object(
    // rust: passes
    // rust: .into_iter()
    // rust: .map(|(name, ms)| (name, json!(ms)))
    // rust: .collect(),
    // rust: );
}
    // rust: self.add_async_occlusion_stats(&mut summary);
    // rust: summary
}

add_async_occlusion_stats :: proc(self: ^Self, summary: ^Value) {
}
    // rust: if let Some(culler) = &self.async_occlusion_culler {
    // rust: summary["async_occlusion_culling"] = culler.stats_value();
}
}

reset_frame_stats :: proc(self: ^Self) {
}
    // rust: self.frame_stats.reset();
    // rust: if let Some(culler) = &self.async_occlusion_culler {
    // rust: culler.reset_stats();
}
}
    // rust: pub(super) fn poll_control(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: if let Some((deadline, reply)) = self.pending_bench.take() {
    // rust: if Instant::now() >= deadline {
    // rust: let _ = reply.send(self.summary_with_passes().to_string());
    // rust: } else {
    // rust: self.pending_bench = Some((deadline, reply));
}
}
    // rust: horizon_client::widgets::end_frame(self.frames);
    // rust: self.narrate_screen();
    // rust: self.poll_repro(event_loop);
    // rust: self.advance_agent();
    // rust: for request in self.ui_wait.ready() {
    // rust: self.answer(request, event_loop);
}
    // rust: while let Some(request) = self.control.as_ref().and_then(|c| c.try_recv()) {
            // Once per line received, not once per handler: a deferred `ui`
            // comes back through `ui_wait` and must not be traced twice.
    // rust: self.note_socket_line(&request.line);
    // rust: self.agent_command_seen();
    // rust: self.answer(request, event_loop);
    // rust: if self.pending_save.is_some() {
    // rust: break;
}
}
        // A recording made from the F3 keys or the Settings page has no socket,
        // and still wants its events.
    // rust: if self.control.is_some() || self.repro.recording_active() {
    // rust: self.watch_events();
}
    // rust: if self.screen == Screen::Options
    // rust: && self.ui.options.page() == horizon_client::options_ui::Page::Agent
    // rust: {
    // rust: self.ui.options.agent_status = self.agent_status_lines();
    // rust: self.ui.options.agent_recording = self.repro.recording_active();
}
}

answer :: proc(self: ^Self, request: horizon_client::control::Request, event_loop: ^dyn EventLoopCtl) {
}
    // rust: let reply = match self.control_command(&request.line, &request.reply, event_loop) {
    // rust: Ok(Some(value)) => value,
            // Deferred: the command keeps its own reply channel.
    // rust: Ok(None) => return,
    // rust: Err(e) => json!({ "error": e.to_string() }),
}
    // rust: let _ = request.reply.send(reply.to_string());
}

    // Text typed at the open screen's text box by the control socket's
    // `type`: its `\b` is a backspace sentinel for the boxes that have always
    // taken one, not the characters `\` and `b`. `Err` when no text box of
    // the screen takes it.
    // rust: pub(super) fn type_into_screen(&mut self, text: &str) -> Result<()> {
    // rust: if text == "\\b" {
    // rust: match self.screen {
    // rust: Screen::WorldOptions => {
    // rust: self.world_options_text(None);
    // rust: return Ok(());
}
    // rust: Screen::Inventory if self.mod_browser_typing() => {
    // rust: self.mod_browser_text(None, true);
    // rust: return Ok(());
}
    // rust: Screen::Social => {
    // rust: self.social_backspace();
    // rust: return Ok(());
}
    // rust: _ => {}
}
}
    // rust: self.type_chars_into_screen(text)
}

    // Characters the open screen's focused text box takes: the control
    // socket's `type` and a key press's surviving characters (`charTyped`).
    // Nothing here is a key — the caller drops control characters. `Err` when
    // no text box of the screen takes them.
    // rust: pub(super) fn type_chars_into_screen(&mut self, text: &str) -> Result<()> {
    // rust: if self.book.is_some() {
    // rust: self.book_type(text);
    // rust: return Ok(());
}
    // rust: if self.sign_edit.is_some() {
    // rust: self.sign_input(None, Some(text));
    // rust: return Ok(());
}
        // The title's screens: the world name, the seed, a server's address.
        // A screen opened over the title (Options, say) keeps its own text.
    // rust: if title_owns_text(&self.screen, self.title.is_some())
    // rust: && let Some(title) = &mut self.title
    // rust: {
    // rust: title.type_text(text);
    // rust: return Ok(());
}
    // rust: match self.screen {
    // rust: Screen::Chat => self.chat_type(text),
    // rust: Screen::CommandBlock => self.command_block_type(text),
    // rust: Screen::Social => self.social_type(text),
    // rust: Screen::BlockEditor => self.block_editor_type(text),
    // rust: Screen::DebugOptions => self.debug_options_type(text),
    // rust: Screen::Options => self.ui.options.type_text(&self.gui.atlas, text),
            // The port, or the game rules' search and number boxes.
    // rust: Screen::WorldOptions => self.world_options_text(Some(text)),
    // rust: Screen::Inventory if self.mod_browser_typing() => {
    // rust: self.mod_browser_text(Some(text), false)
}
    // rust: Screen::Inventory if self.recipe_search_focused() => {
    // rust: self.recipe_text(Some(text), false)
}
            // The anvil's rename box, while it has an input to name.
    // rust: Screen::Inventory if self.station_typing() => self.station_text(Some(text), false),
    // rust: Screen::Creative if self.creative_screen.tab().search => {
                // As typed: replaces a selected query, keeps the length limit.
    // rust: self.creative_search_edit(Some(text))
}
    // rust: _ => {
    // rust: return Err(
    // rust: "type needs the chat screen (key t tap), a sign or book, the language search, the creative search, the anvil or World Options".into(),
    // rust: );
}
}
    // rust: Ok(())
}

    // rust: fn control_command(
    // rust: &mut self,
    // rust: line: &str,
    // rust: reply: &Sender<String>,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: ) -> Result<Option<Value>> {
        // A tap's or an up's release must run even when a dialog, the sign
        // editor or a screen consumes the key, there is no world, or a
        // command handler returns an error: a lost release keeps Shift down.
    // rust: let released = released_modifier(line);
    // rust: let result = self.control_command_inner(line, reply, event_loop);
    // rust: if let Some(key) = released {
    // rust: self.press_modifier_key(key, false);
}
    // rust: result
}

    // A recorded control line fed back by a replay: not new input, so the
    // trace does not see it, and its reply has no one waiting.
    // rust: pub(super) fn replay_line(&mut self, line: &str, event_loop: &dyn EventLoopCtl) {
    // rust: let (reply, _) = std::sync::mpsc::channel();
    // rust: if let Err(e) = self.control_command(line, &reply, event_loop) {
    // rust: log::warn!("Horizon: replay: {line}: {e}");
}
}

    // rust: fn control_command_inner(
    // rust: &mut self,
    // rust: line: &str,
    // rust: reply: &Sender<String>,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: ) -> Result<Option<Value>> {
    // rust: let words: Vec<&str> = line.split_whitespace().collect();
    // rust: if self.pending_save.is_some() && words.first() != Some(&"quit") {
    // rust: return Err("a world save is in progress".into());
}
    // rust: let arg = |i: usize| {
    // rust: words
    // rust: .get(i)
    // rust: .copied()
    // rust: .ok_or_else(|| format!("missing argument {i} for {}", words[0]))
}
    // rust: let ok = || Ok(Some(json!({ "ok": true })));
    // rust: if let Some(value) = self.block_command(&words)? {
    // rust: return Ok(Some(value));
}
    // rust: match self.ui_command(&words, line, reply, event_loop)? {
    // rust: super::agent::Handled::Reply(value) => return Ok(Some(value)),
    // rust: super::agent::Handled::Deferred => return Ok(None),
    // rust: super::agent::Handled::No => {}
}
    // rust: if let Some(value) = self.events_command(&words, reply)? {
    // rust: return Ok(value);
}
    // rust: if let Some(value) = self.input_trace.command(&words)? {
    // rust: return Ok(Some(value));
}
    // rust: if let Some(value) = self.repro_command(&words, line, reply)? {
    // rust: return Ok(value);
}
    // rust: if let Some(value) = self.saves_control(&words, line, reply)? {
    // rust: return Ok(value);
}
    // rust: if let Some(value) = self.options_control(&words, line)? {
    // rust: return Ok(Some(value));
}
    // rust: if let Some(value) = self.lan_control(&words)? {
    // rust: return Ok(Some(value));
}
    // rust: if let Some(value) = self.friends_control(&words)? {
    // rust: return Ok(Some(value));
}
    // rust: if let Some(value) = self.studio_control(&words)? {
    // rust: return Ok(Some(value));
}
    // rust: match self.agent_command(&words, line, reply, event_loop)? {
    // rust: super::agent::Handled::Reply(value) => return Ok(Some(value)),
    // rust: super::agent::Handled::Deferred => return Ok(None),
    // rust: super::agent::Handled::No => {}
}
    // rust: match words[0] {
    // rust: "help" => Ok(Some(json!({ "commands": HELP
    // rust: .iter()
    // rust: .chain(super::station_control::HELP)
    // rust: .chain(super::blockctl::HELP)
    // rust: .chain(super::lan::HELP)
    // rust: .chain(super::friends::HELP)
    // rust: .chain(super::render_control::HELP)
    // rust: .chain(super::sculk::HELP)
    // rust: .chain(super::agent::HELP)
    // rust: .chain(super::ui_control::HELP)
    // rust: .chain(super::options::CONTROL_HELP)
    // rust: .chain(super::events::HELP)
    // rust: .chain(super::saves_control::HELP)
    // rust: .chain(super::pad::HELP)
    // rust: .chain(super::input_trace::HELP)
    // rust: .chain(super::repro::HELP)
    // rust: .chain(super::studio::HELP)
    // rust: .collect::<Vec<_>>() }))),
    // rust: "setblock" | "fill" | "particle" | "signedit" => self.render_command(&words),
    // rust: "section-draws" => {
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: match words.get(1).copied() {
    // rust: None => {}
    // rust: Some("flat") => r.set_flat_draws(true)?,
    // rust: Some("indirect") => r.set_flat_draws(false)?,
    // rust: Some(other) => return Err(format!("unknown section draw mode {other}").into()),
}
    // rust: Ok(Some(json!({ "ok": true, "flat": r.flat_draws() })))
}
    // rust: "section-cull" => {
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: match words.get(1).copied() {
    // rust: None => {}
    // rust: Some("on") => r.set_section_cull(true)?,
    // rust: Some("off") => r.set_section_cull(false)?,
    // rust: Some(other) => return Err(format!("unknown section cull mode {other}").into()),
}
    // rust: Ok(Some(json!({ "ok": true, "cull": r.section_cull() })))
}
    // rust: "gpu-passes" => {
    // rust: match words.get(1).copied() {
    // rust: None => {}
    // rust: Some("on") => self.gpu_passes = true,
    // rust: Some("off") => self.gpu_passes = false,
    // rust: Some(other) => return Err(format!("unknown gpu pass mode {other}").into()),
}
    // rust: Ok(Some(json!({ "ok": true, "gpu_passes": self.gpu_passes })))
}
            // Every thread's spans as a timeline Perfetto opens (`spans::trace`).
    // rust: "trace" => match words.get(1).copied() {
    // rust: None => Ok(Some(
    // rust: json!({ "ok": true, "tracing": horizon_client::spans::trace::on() }),
    // rust: )),
    // rust: Some("stop") => Ok(Some(
    // rust: json!({ "ok": true, "events": horizon_client::spans::trace::stop() }),
    // rust: )),
    // rust: Some(file) => {
    // rust: let seconds = match words.get(2) {
    // rust: None => None,
    // rust: Some(s) => Some(
    // rust: s.parse::<u32>()
    // rust: .map_err(|_| "trace [FILE [SECONDS] | stop]")?,
    // rust: ),
}
    // rust: horizon_client::spans::trace::start(std::path::Path::new(file), seconds)
    // rust: .map_err(|e| format!("trace {file}: {e}"))?;
    // rust: Ok(Some(json!({ "ok": true, "tracing": true, "file": file })))
}
    // rust: },
    // rust: "render-capture" => match words.get(1).copied() {
    // rust: None => {
    // rust: let r = self.renderer.as_ref().ok_or("no renderer")?;
    // rust: Ok(Some(
    // rust: json!({ "ok": true, "keeping": r.keeps_capture_copies() }),
    // rust: ))
}
    // rust: Some("on") => {
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: if !r.keeps_capture_copies() {
    // rust: r.keep_capture_copies(true);
                        // The copies start empty: every section and far tile is meshed
                        // again, as after a relayout.
    // rust: self.clear_lod();
    // rust: self.all_sections_changed();
}
    // rust: Ok(Some(json!({ "ok": true, "keeping": true })))
}
    // rust: Some("off") => {
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: r.keep_capture_copies(false);
    // rust: Ok(Some(json!({ "ok": true, "keeping": false })))
}
    // rust: Some(_) => {
    // rust: if self.pending_render_capture.is_some() {
    // rust: return Err("a render capture is already pending".into());
}
                    // The rest of the line: a path may hold spaces.
    // rust: let dir = line
    // rust: .trim_start()
    // rust: .strip_prefix("render-capture")
    // rust: .unwrap_or("");
    // rust: let settings = self.render_capture_settings();
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: if !r.keeps_capture_copies() {
    // rust: return Err("no mesh copies kept: run render-capture on (or start with \
    // rust: HORIZON_RENDER_CAPTURE=1) and let the terrain settle first"
    // rust: .into());
}
    // rust: r.capture = Some(horizon_client::gfx::capture::Request {
    // rust: dir: dir.trim().into(),
    // rust: settings,
    // rust: });
    // rust: self.pending_render_capture = Some(reply.clone());
    // rust: Ok(None)
}
    // rust: },
    // rust: "section-sides" => {
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: match words.get(1).copied() {
    // rust: None => {}
    // rust: Some("on") => r.set_section_sides(true),
    // rust: Some("off") => r.set_section_sides(false),
    // rust: Some(other) => return Err(format!("unknown section sides mode {other}").into()),
}
    // rust: Ok(Some(json!({ "ok": true, "sides": r.section_sides() })))
}
    // rust: "gpu-culling" => {
    // rust: let r = self.renderer.as_mut().ok_or("no renderer")?;
    // rust: match words.get(1).copied() {
    // rust: None => {}
    // rust: Some(mode @ ("on" | "off")) => {
                        // Refused, with the reason, where it isn't offered.
    // rust: r.set_gpu_culling(mode == "on")?;
                        // The setting, as its switch sets it; not saved here (as
                        // `lod-distance`): settings changes and new renderers keep it.
    // rust: self.settings.horizon.gpu_culling = mode == "on";
}
    // rust: Some(other) => return Err(format!("unknown GPU culling mode {other}").into()),
}
    // rust: Ok(Some(json!({ "ok": true, "gpu_culling": r.gpu_culling() })))
}
    // rust: "sculk" => Ok(Some(self.sculk_command(&words)?)),
    // rust: "hello" => Ok(Some(hello())),
    // rust: "status" => Ok(Some(self.control_status())),
    // rust: "memory" => Ok(Some(self.memory_report())),
    // rust: "stall" => {
    // rust: let millis: u64 = arg(1)?.parse()?;
    // rust: if millis > 5000 {
    // rust: return Err("stall is limited to 5000 milliseconds".into());
}
    // rust: std::thread::sleep(Duration::from_millis(millis));
    // rust: ok()
}
    // rust: "simulation" => {
    // rust: self.require_world()?;
    // rust: let value = if let Some(server) = &self.integrated {
    // rust: server
    // rust: .call(|g| {
    // rust: g.in_owner_level(|g| {
    // rust: json!({ "game_time": g.world.game_time, "projectiles": g.projectiles_status() })
    // rust: })
    // rust: })
    // rust: .ok_or(super::integrated::NO_ANSWER)?
    // rust: } else {
    // rust: json!({ "game_time": self.world.game_time, "projectiles": self.projectiles_status() })
}
    // rust: Ok(Some(value))
}
    // rust: "server-hold" => {
    // rust: self.require_world()?;
    // rust: let held = match arg(1)? {
    // rust: "on" => true,
    // rust: "off" => false,
    // rust: _ => return Err("server-hold on|off".into()),
}
    // rust: if let Some(server) = &self.integrated {
    // rust: server
    // rust: .call(move |g| g.agent.hold_server = held)
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
    // rust: } else if self.remote.is_some() {
    // rust: return Err("server-hold requires the world's host".into());
    // rust: } else {
    // rust: self.agent.hold_server = held;
}
    // rust: ok()
}
    // rust: "pad" => Ok(Some(self.pad_command(&words)?)),
    // rust: "key" => {
    // rust: let key = key_code(arg(1)?).ok_or_else(|| format!("unknown key {}", words[1]))?;
    // rust: let action = arg(2)?;
    // rust: if !matches!(action, "down" | "up" | "tap" | "repeat") {
    // rust: return Err(format!(
    // rust: "key action must be down, up, tap or repeat, not {action}"
    // rust: )
    // rust: .into());
}
                // The command confirmation takes the keys; none go past it.
    // rust: if self.command_prompt.is_some() {
    // rust: if arg(2)? != "up" {
    // rust: self.command_prompt_key(key);
}
    // rust: return ok();
}
                // A server's dialog takes the keys, in configuration too.
    // rust: if self.dialog_open() {
    // rust: if arg(2)? != "up" {
    // rust: self.dialog_key(key, None, None)?;
}
    // rust: return ok();
}
    // rust: self.require_world()?;
                // KeyboardHandler.keyPress: the open screen's narration hears it.
    // rust: super::narrator::narrate_key(&mut self.narration, key, arg(2)? != "up");
                // The sign editor takes raw presses (Enter, arrows, Backspace, Escape).
    // rust: if self.sign_edit.is_some() {
    // rust: if arg(2)? != "up" {
    // rust: self.sign_input(Some(key), None);
}
    // rust: return ok();
}
                // A held edit modifier (`key super down`) and A/C/V/X: the
                // open book's Select All, Copy, Paste or Cut.
    // rust: if self.book.is_some() && arg(2)? != "up" {
    // rust: let held = |k: [KeyCode; 2]| k.iter().any(|k| self.keys.raw(k));
    // rust: let edit = if cfg!(target_os = "macos") {
    // rust: held([KeyCode::SuperLeft, KeyCode::SuperRight])
    // rust: } else {
    // rust: held([KeyCode::ControlLeft, KeyCode::ControlRight])
}
    // rust: let name = arg(1)?;
    // rust: let letter = name.chars().next().filter(|_| name.len() == 1);
    // rust: let shift = held([KeyCode::ShiftLeft, KeyCode::ShiftRight]);
    // rust: if let Some(shortcut) =
    // rust: horizon_client::clipboard::edit_shortcut(letter, edit, shift, false)
    // rust: {
    // rust: self.book_shortcut(shortcut);
    // rust: return ok();
}
}
                // KeyboardHandler.keyPress: the debug keys see the physical key first.
    // rust: let physical = key;
    // rust: {
//                     use horizon_client::debug_keys::KeyAction;
    // rust: let action = arg(2)?;
    // rust: self.press_modifier_key(key, action != "up");
    // rust: if action != "up" {
    // rust: self.physical_keys.insert(key);
    // rust: if self.debug_key(key, KeyAction::Press) {
    // rust: if action == "tap" {
    // rust: self.physical_keys.remove(&key);
    // rust: self.debug_key(key, KeyAction::Release);
}
    // rust: return ok();
}
}
    // rust: if action == "up" {
    // rust: self.physical_keys.remove(&key);
    // rust: self.debug_key(key, KeyAction::Release);
}
}
                // Native mods see the key as the keyboard hook does.
    // rust: let action = arg(2)?;
                // ScreenEvent.KeyPressed.Pre: the open screen hears of the
                // press before it acts on it, as the window's key event hands
                // it over. A cancelled press goes no further — not to the
                // screens, not to `native_key` — and its release still comes.
    // rust: if action != "up" && self.screen_key_pressed(physical, action == "repeat") {
    // rust: if action == "tap" {
    // rust: self.physical_keys.remove(&physical);
    // rust: self.native_key_event(physical, false, false);
}
    // rust: return ok();
}
    // rust: self.native_key_event(physical, action != "up", action == "repeat");
    // rust: if action == "tap" {
    // rust: self.native_key_event(physical, false, false);
}
                // The merchant's focused offer and the recipe book's last
                // recipe take Enter and Space, as the window's.
    // rust: if action != "up"
    // rust: && self.screen == Screen::Inventory
    // rust: && (self.merchant_key(physical) || self.recipe_book_key(physical))
    // rust: {
    // rust: return ok();
}
                // Text screens consume raw presses; releases follow key binds.
    // rust: let typing = matches!(
    // rust: self.screen,
    // rust: Screen::Chat | Screen::Options | Screen::CommandBlock | Screen::BlockEditor
    // rust: );
    // rust: let key = if typing && arg(2)? != "up" {
    // rust: key
    // rust: } else {
    // rust: match self.settings.keys.translate(key) {
    // rust: Some(Ok(k)) => k,
    // rust: Some(Err(button)) => {
    // rust: let action = arg(2)?;
    // rust: if self.screen == Screen::Playing
    // rust: && self.shared_default_acts(
    // rust: button,
    // rust: horizon_client::keybinds::key_name(physical),
    // rust: )
    // rust: {
    // rust: if action != "up" {
    // rust: self.mouse_mapping(button, true, Source::Agent)?;
}
                                // A repeat keeps the key held, as the window's.
    // rust: if action == "up" || action == "tap" {
    // rust: self.mouse_mapping(button, false, Source::Agent)?;
}
}
    // rust: if action == "tap" {
    // rust: self.physical_keys.remove(&physical);
}
    // rust: return ok();
}
    // rust: None => return ok(),
}
}
    // rust: match arg(2)? {
    // rust: "down" => self.control_key_down(key, physical)?,
    // rust: "up" => {
    // rust: self.control_key_up(key);
    // rust: self.physical_keys.remove(&key);
}
                    // The system's auto-repeat while the key is held.
    // rust: "repeat" => {
    // rust: self.physical_keys.insert(physical);
    // rust: self.mapped_key(key, true, true, key, Source::Agent)?;
}
    // rust: "tap" => {
    // rust: self.control_key_down(key, physical)?;
    // rust: self.control_key_up(key);
    // rust: self.physical_keys.remove(&physical);
    // rust: self.debug_key(physical, horizon_client::debug_keys::KeyAction::Release);
}
    // rust: _ => unreachable!("checked above"),
}
    // rust: ok()
}
    // rust: "release" => {
    // rust: self.keys.clear();
    // rust: self.physical_keys.clear();
    // rust: self.modifiers = winit::keyboard::ModifiersState::empty();
                // Sneak and sprint pressed through `key` live in the toggle
                // mappings: release them as their key's release would (a
                // toggled one stays on), or the next sync puts them back. A
                // controller still holding one keeps it.
    // rust: let options = [self.settings.toggle_crouch, self.settings.toggle_sprint];
    // rust: for (slot, name) in [(0, "key.sneak"), (1, "key.sprint")] {
    // rust: if !self.pad.holds_action(&self.settings.controller, name) {
    // rust: self.toggles.key(
    // rust: slot,
    // rust: horizon_client::keymapping::KeyAction::Release,
    // rust: false,
    // rust: options[slot],
    // rust: );
}
    // rust: self.sync_toggle(slot);
}
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: ok()
}
    // rust: "mouse" => {
    // rust: let button = match arg(1)? {
    // rust: "left" => MouseButton::Left,
    // rust: "right" => MouseButton::Right,
    // rust: "middle" => MouseButton::Middle,
    // rust: other => return Err(format!("unknown mouse button {other}").into()),
}
    // rust: self.require_world()?;
    // rust: if self.screen != Screen::Playing {
    // rust: return Err(format!(
    // rust: "mouse needs the playing screen, not {}",
    // rust: self.screen_name()
    // rust: )
    // rust: .into());
}
    // rust: match arg(2)? {
    // rust: "down" => {
    // rust: self.extras_mouse(button, true);
    // rust: self.mouse_mapping(button, true, Source::Agent)?
}
    // rust: "up" => {
    // rust: self.extras_mouse(button, false);
    // rust: self.mouse_mapping(button, false, Source::Agent)?
}
    // rust: "click" => {
    // rust: self.extras_mouse(button, true);
    // rust: self.extras_mouse(button, false);
    // rust: self.mouse_mapping(button, true, Source::Agent)?;
    // rust: self.mouse_mapping(button, false, Source::Agent)?;
}
    // rust: other => {
    // rust: return Err(
    // rust: format!("mouse action must be down, up or click, not {other}").into(),
    // rust: );
}
}
    // rust: ok()
}
    // rust: "look" => {
    // rust: self.yaw = arg(1)?.parse()?;
    // rust: self.pitch = arg(2)?.parse::<f32>()?.clamp(-90.0, 90.0);
    // rust: ok()
}
    // rust: "turn" => {
    // rust: let yaw = arg(1)?.parse::<f32>()?;
    // rust: let pitch = arg(2)?.parse::<f32>()?;
                // Degrees, as `Entity.turn` degrees.
    // rust: self.turn_player(f64::from(yaw / 0.15), f64::from(pitch / 0.15));
    // rust: ok()
}
    // rust: "tp" => {
    // rust: let to = Vec3::new(arg(1)?.parse()?, arg(2)?.parse()?, arg(3)?.parse()?);
    // rust: let player = self.player.as_mut().ok_or("no player yet")?;
    // rust: player.position = to;
    // rust: player.velocity = Vec3::new(0.0, 0.0, 0.0);
    // rust: player.fall_distance = 0.0;
    // rust: self.previous_position = to;
    // rust: ok()
}
    // rust: "emote" => match words.get(1).copied() {
    // rust: None => {
    // rust: let owned: Vec<String> =
    // rust: self.owned_emotes().iter().map(|i| i.id.clone()).collect();
    // rust: Ok(Some(
    // rust: json!({ "owned": owned, "playing": self.emote_playing() }),
    // rust: ))
}
    // rust: Some("stop") => {
    // rust: self.stop_emote();
    // rust: ok()
}
    // rust: Some(id) if self.play_emote(id) => ok(),
    // rust: Some(id) => {
    // rust: Err(format!("can't play emote {id} now (not owned, or not standing)").into())
}
    // rust: },
    // rust: "hotbar" => {
    // rust: let slot: usize = arg(1)?.parse()?;
    // rust: if !(1..=9).contains(&slot) {
    // rust: return Err("hotbar slot must be 1..9".into());
}
    // rust: self.selected = slot - 1;
    // rust: ok()
}
    // rust: "give" => {
    // rust: self.require_world()?;
    // rust: let name = arg(1)?;
    // rust: let item = if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let info = self
    // rust: .res
    // rust: .items()
    // rust: .get(&item)
    // rust: .ok_or_else(|| format!("unknown item {item}"))?;
    // rust: let count: u32 = words.get(2).map_or(Ok(1), |c| c.parse())?;
                // Single player's inventory is its server thread's player's.
    // rust: if let Some(server) = &self.integrated {
    // rust: let command = format!("give @s {item} {count}");
    // rust: server
    // rust: .call(move |g| g.owner_console_command(&command))
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
    // rust: return Ok(Some(json!({ "ok": true, "given": count })));
}
    // rust: let max = info.max_stack;
    // rust: let mut given = 0;
                // Stop once the inventory is full.
    // rust: while given < count {
    // rust: let n = (count - given).min(max);
    // rust: let rest = self
    // rust: .give(ItemStack {
    // rust: item: item.as_str().into(),
    // rust: count: n,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })
    // rust: .map_or(0, |r| r.count);
    // rust: given += n - rest;
    // rust: if rest > 0 {
    // rust: break;
}
}
    // rust: Ok(Some(json!({ "ok": true, "given": given })))
}
    // rust: "render-distance" => {
    // rust: let n: i32 = arg(1)?.parse()?;
    // rust: let max = horizon_client::options_file::MAX_RENDER_DISTANCE;
    // rust: if !(2..=max).contains(&n) {
    // rust: return Err(format!("render distance must be 2..{max}").into());
}
    // rust: self.settings.render_distance = n;
    // rust: self.apply_settings();
    // rust: ok()
}
    // rust: "lod-distance" => {
    // rust: let n: u32 = arg(1)?.parse()?;
    // rust: if n > horizon_client::lod::MAX_CHUNKS {
    // rust: return Err(format!(
    // rust: "LOD distance must be 0..{}",
    // rust: horizon_client::lod::MAX_CHUNKS
    // rust: )
    // rust: .into());
}
    // rust: self.settings.horizon.lod_distance = n;
    // rust: self.apply_settings();
    // rust: ok()
}
    // rust: "time" => {
    // rust: let time: i64 = arg(1)?.parse()?;
    // rust: self.world.day_time = time;
                // Single player's clock is its server thread's.
    // rust: if let Some(server) = &self.integrated {
    // rust: server
    // rust: .call(move |g| g.world.day_time = time)
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
}
    // rust: ok()
}
    // rust: "summon" => {
    // rust: self.require_world()?;
    // rust: let baby = words.contains(&"baby");
    // rust: let nums: Vec<f64> = words[2..].iter().filter_map(|w| w.parse().ok()).collect();
    // rust: let at = (nums.len() >= 3).then(|| [nums[0], nums[1], nums[2]]);
    // rust: let kind = arg(1)?.to_owned();
                // Single player on its server thread: spawn in the owner's level
                // so the mob enters the server tick loop and is tracked to clients.
    // rust: if let Some(server) = &self.integrated {
    // rust: let at = match at {
    // rust: Some(a) => a,
    // rust: None => self.default_summon_position()?,
}
    // rust: let id = server
    // rust: .call(move |g| {
    // rust: g.in_owner_level(|g| {
    // rust: g.summon(&kind, Some(at), baby).map_err(|e| e.to_string())
    // rust: })
    // rust: })
    // rust: .ok_or(super::integrated::NO_ANSWER)??;
    // rust: return Ok(Some(json!({ "ok": true, "id": id })));
}
    // rust: let id = self.summon(&kind, at, baby)?;
    // rust: Ok(Some(json!({ "ok": true, "id": id })))
}
    // rust: "mobs" => {
    // rust: self.require_world()?;
    // rust: let radius: f64 = words.get(1).map_or(Ok(64.0), |r| r.parse())?;
    // rust: if let Some(server) = &self.integrated {
    // rust: let center = self.player.as_ref().map_or(Vec3::ZERO, |p| p.position);
    // rust: let value = server
    // rust: .call(move |g| g.in_owner_level(|g| g.control_mobs_at(radius, center)))
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
    // rust: return Ok(Some(value));
}
    // rust: Ok(Some(self.control_mobs(radius)))
}
    // rust: "hurtlog" => {
    // rust: self.require_world()?;
    // rust: if let Some(server) = &self.integrated {
    // rust: let value = server
    // rust: .call(|g| g.control_hurt_log())
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
    // rust: return Ok(Some(value));
}
    // rust: Ok(Some(self.control_hurt_log()))
}
    // rust: "resume" => {
    // rust: if self.screen == Screen::Paused {
    // rust: self.screen = Screen::Playing;
}
    // rust: ok()
}
    // rust: "screenshot" => {
    // rust: let renderer = self.renderer.as_mut().ok_or("no renderer yet")?;
    // rust: if self.pending_screenshot.is_some() {
    // rust: return Err("a screenshot is already pending".into());
}
    // rust: arg(1)?;
                // The rest of the line: a path may hold spaces.
    // rust: let path = line.trim_start().strip_prefix("screenshot").unwrap_or("");
    // rust: renderer.screenshot = Some(horizon_client::gfx::ScreenshotRequest {
    // rust: path: path.trim().into(),
    // rust: size: None,
    // rust: scaled: false,
    // rust: });
    // rust: self.pending_screenshot = Some(reply.clone());
    // rust: Ok(None)
}
    // rust: "chat" => {
    // rust: let text = line.trim_start().strip_prefix("chat").unwrap_or("").trim();
    // rust: self.require_world()?;
                // As if typed: a client mod's command runs before the line
                // reaches the server, and the Chat option's restrictions and
                // the recent list apply to a connected server too.
    // rust: self.handle_chat_input(text);
    // rust: Ok(Some(
    // rust: json!({ "ok": true, "chat": self.ui.chat.recent_lines(5) }),
    // rust: ))
}
    // rust: "type" => {
    // rust: let text = line
    // rust: .trim_start()
    // rust: .strip_prefix("type")
    // rust: .unwrap_or("")
    // rust: .strip_prefix(' ')
    // rust: .unwrap_or("");
                // A server's dialog, in configuration too.
    // rust: if self.dialog_type(text) {
    // rust: return ok();
}
    // rust: self.require_world()?;
                // Typed keys: the open screen's narration hears them.
    // rust: self.narration.keyboard_action();
                // ScreenEvent.CharacterTyped.Pre: the open screen hears of
                // each character before a text box takes it, as the window's
                // key event fires it. A cancelled character is dropped, so
                // `type` types the survivors only.
                // `\b` is the socket's backspace sentinel, not two characters.
    // rust: let typed = if text == "\\b" {
    // rust: text.to_owned()
    // rust: } else {
    // rust: let Some(typed) = self.screen_text_typed(text) else {
    // rust: return ok();
}
    // rust: typed
}
    // rust: self.type_into_screen(&typed)?;
    // rust: ok()
}
    // rust: "options" => {
//                 use horizon_client::options_ui::Page;
    // rust: let page = match words.get(1).copied().unwrap_or("main") {
    // rust: "main" => Page::Main,
                    // What Video Settings... opens; vanilla's own layout, which no menu opens.
    // rust: "video" => Page::Graphics,
    // rust: "video-vanilla" => Page::Video,
    // rust: "sound" => Page::Sound,
    // rust: "controls" => Page::Controls,
    // rust: "keybinds" => Page::KeyBinds,
    // rust: "controller" => Page::Controller,
    // rust: "controller-binds" => Page::PadBinds,
    // rust: "mouse" => Page::Mouse,
    // rust: "chat" => Page::Chat,
    // rust: "accessibility" => Page::Accessibility,
    // rust: "language" => Page::Language,
    // rust: "font" => Page::Font,
    // rust: "packs" => Page::Packs,
    // rust: "mods" => Page::Mods,
    // rust: "shader-packs" => Page::ShaderPacks,
    // rust: "graphics" => Page::Graphics,
    // rust: "graphics-advanced" => Page::GraphicsAdvanced,
    // rust: "graphics-hdr" => Page::GraphicsHdr,
    // rust: "extras" => Page::Extras,
    // rust: "pvp" => Page::Pvp,
    // rust: "credits" => Page::Credits,
    // rust: "horizon" => Page::Horizon,
    // rust: "agent" => Page::Agent,
    // rust: other => return Err(format!("unknown options page {other}").into()),
}
    // rust: if self.screen == Screen::Playing && self.title.is_none() {
    // rust: self.capture(false);
}
    // rust: self.open_options(self.title.is_some());
    // rust: self.ui.options.show(page);
    // rust: if page == Page::ShaderPacks {
    // rust: self.settings.shader_packs =
    // rust: horizon_client::shader_pack_list::scan(&Self::shader_packs_dir());
}
    // rust: ok()
}
    // rust: "chat-log" => {
    // rust: let n = words.get(1).map_or(Ok(10), |n| n.parse())?;
    // rust: let lines = self
    // rust: .remote_chat(n)
    // rust: .unwrap_or_else(|| self.ui.chat.recent_lines(n));
    // rust: Ok(Some(json!({ "chat": lines })))
}
    // rust: "narration" => {
                // NarratorStatus's options.txt names: off, all, chat, system.
    // rust: let status = horizon_narrator::status().key().rsplit('.').next();
    // rust: Ok(Some(json!({
    // rust: "status": status,
    // rust: "active": horizon_narrator::is_active(),
    // rust: "recent": horizon_narrator::recent(),
    // rust: })))
}
    // rust: "stats" => {
    // rust: let mut summary = self.summary_with_passes();
    // rust: if words[1..].contains(&"raw") {
    // rust: summary["frame_ms"] = self.frame_stats.frame_millis().into();
    // rust: summary["cpu_ms"] = self.frame_stats.cpu_millis().into();
    // rust: summary["gpu_ms"] = self.frame_stats.gpu_millis().into();
}
    // rust: if words[1..].contains(&"reset") {
    // rust: self.reset_frame_stats();
}
    // rust: Ok(Some(summary))
}
    // rust: "bench" => {
    // rust: let seconds: f64 = arg(1)?.parse()?;
    // rust: if self.pending_bench.is_some() {
    // rust: return Err("a benchmark is already running".into());
}
    // rust: self.reset_frame_stats();
    // rust: self.pending_bench = Some((
    // rust: Instant::now() + Duration::from_secs_f64(seconds),
    // rust: reply.clone(),
    // rust: ));
    // rust: Ok(None)
}
    // rust: "fly" => {
    // rust: self.require_world()?;
    // rust: if self.flight.is_some() || self.pending_bench.is_some() {
    // rust: return Err("a benchmark is already running".into());
}
    // rust: let n = |i: usize| -> Result<f64> { Ok(arg(i)?.parse()?) };
    // rust: let pitch = words.get(8).map_or(Ok(10.0), |p| p.parse::<f32>())?;
    // rust: self.reset_frame_stats();
    // rust: self.flight = Some(Flight {
    // rust: from: Vec3::new(n(1)?, n(2)?, n(3)?),
    // rust: to: Vec3::new(n(4)?, n(5)?, n(6)?),
    // rust: pitch,
    // rust: started: Instant::now(),
    // rust: seconds: n(7)?.max(0.1),
    // rust: raw: words.get(9) == Some(&"raw"),
    // rust: reply: reply.clone(),
    // rust: tick_ms: Vec::new(),
    // rust: });
    // rust: Ok(None)
}
    // rust: "open" => {
    // rust: if self.title.is_none() {
    // rust: return Err("a world is already open".into());
}
    // rust: let folder = arg(1)?;
    // rust: let seed = words.get(2).map(|s| s.parse::<i64>()).transpose()?;
    // rust: let creative = words.get(3) == Some(&"creative");
    // rust: self.open_world(folder, Some(folder), seed, creative, None)?;
    // rust: ok()
}
    // rust: "connect" => {
    // rust: if self.title.is_none() {
    // rust: return Err("leave the current world first".into());
}
    // rust: let name = words
    // rust: .get(2)
    // rust: .map_or_else(|| self.options.player_name(), |n| (*n).to_owned());
    // rust: self.connect_server(arg(1)?, &name)?;
    // rust: ok()
}
    // rust: "credits" => {
    // rust: let poem = words.get(1) == Some(&"poem");
    // rust: let hold = words
    // rust: .get(1 + usize::from(poem))
    // rust: .map(|s| s.parse::<f32>())
    // rust: .transpose()?;
    // rust: if self.screen != Screen::Win {
    // rust: let finish = if self.screen == Screen::Options {
    // rust: super::win::Finish::Options
    // rust: } else {
    // rust: super::win::Finish::Closed
}
    // rust: self.open_win_screen(poem, finish);
}
    // rust: if let Some(scroll) = hold {
    // rust: self.hold_win_screen(scroll);
}
    // rust: ok()
}
    // rust: "respawn" => {
    // rust: if self.remote.is_none() || self.screen != Screen::Dead {
    // rust: return Err("respawn needs the death screen on a server".into());
}
    // rust: self.remote_respawn();
    // rust: ok()
}
    // rust: "disconnect" => {
    // rust: if self.remote.is_none() {
    // rust: return Err("not connected to a server".into());
}
    // rust: self.leave_server(None)?;
    // rust: ok()
}
    // rust: "save" | "save-all" => {
    // rust: self.require_world()?;
                // `save-all` is like `save-all flush`: it also rewrites chunks
                // that were not modified (the save round-trip harness compares
                // them with vanilla's files).
    // rust: let all = words[0] == "save-all";
                // Single player's world is its server thread's.
    // rust: if let Some(server) = &self.integrated {
    // rust: server
    // rust: .call(move |g| g.control_save(all).map_err(|e| e.to_string()))
    // rust: .ok_or(super::integrated::NO_ANSWER)??;
    // rust: } else if self.remote.is_none() {
    // rust: self.begin_control_save(all, reply.clone())?;
    // rust: return Ok(None);
    // rust: } else {
    // rust: self.control_save(all)?;
}
    // rust: ok()
}
    // rust: "dragon-hurt" => {
                // Test hook: damage the dragon's head as the player would.
    // rust: let amount: f32 = arg(1)?.parse()?;
    // rust: self.hit_special(
    // rust: super::dragon::SPECIAL,
    // rust: amount,
    // rust: true,
    // rust: horizon_client::mobs::DamageKind::PlayerAttack,
    // rust: None,
    // rust: );
    // rust: ok()
}
            // A splitscreen player leaves splitscreen; only P1's game ends the process.
    // rust: "quit" if self.options.split_guest => {
    // rust: if self.remote.is_some() {
    // rust: self.leave_server(None)?;
    // rust: } else if let Some(title) = self.title.as_mut() {
    // rust: title.escape();
}
    // rust: ok()
}
    // rust: "quit" => {
    // rust: self.begin_closing_save(true)?;
    // rust: ok()
}
    // rust: other => match self.station_command(&words)? {
    // rust: Some(value) => Ok(Some(value)),
    // rust: None => Err(format!("unknown command {other}; try help").into()),
    // rust: },
}
}

    // `horizon-ctl save` and `save-all`.
control_save :: proc(self: ^Self, all: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if all {
    // rust: let keys: Vec<_> = self.world.chunks.keys().copied().collect();
    // rust: self.world.modified.extend(keys);
}
    // rust: self.save_game()
}

require_world :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.title.is_some() {
    // rust: return Err("no world open; use: open WORLD [SEED] [creative]".into());
}
    // rust: Ok(())
}

control_key_down :: proc(self: ^Self, key: KeyCode, raw: KeyCode) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.physical_keys.insert(key);
        // The window's shortcuts come before any screen, here too.
    // rust: if self.screenshot_shortcut(key, false) {
    // rust: return Ok(());
}
    // rust: if self.screen == Screen::Chat {
    // rust: self.chat_key_code(key, None);
    // rust: return Ok(());
}
    // rust: if self.screen == Screen::Options {
    // rust: return self.options_key(key, None);
}
    // rust: if self.screen == Screen::CommandBlock {
    // rust: self.command_block_key_code(key, None, None);
    // rust: return Ok(());
}
    // rust: if self.screen == Screen::BlockEditor {
    // rust: self.block_editor_key_code(key, None, None);
    // rust: return Ok(());
}
    // rust: if self.keys.press(key, Source::Agent) {
    // rust: self.key_pressed(key, raw)?;
}
    // rust: Ok(())
}

    // `key ... up`: the script lets go. What it pressed as the keyboard's stand-in goes with it
    // (a fixture's untagged press), and a controller's hold stays.
control_key_up :: proc(self: ^Self, key: KeyCode) {
}
    // rust: self.keys.release(&key, Source::Agent);
    // rust: self.keys.release(&key, Source::Keyboard);
}

screen_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.screen == Screen::Win {
    // rust: return "win";
}
    // rust: if self.title.is_some() {
    // rust: return "title";
}
    // rust: match self.screen {
    // rust: Screen::Playing => "playing",
    // rust: Screen::GameModeSwitcher => "gamemode-switcher",
    // rust: Screen::EmoteWheel => "emote-wheel",
    // rust: Screen::Paused => "paused",
    // rust: Screen::Options => "options",
    // rust: Screen::Inventory => "inventory",
    // rust: Screen::Creative => "creative",
    // rust: Screen::Dead => "dead",
    // rust: Screen::Chat => "chat",
    // rust: Screen::Stats => "stats",
    // rust: Screen::Advancements => "advancements",
    // rust: Screen::WorldOptions => "world-options",
    // rust: Screen::Friends => "friends",
    // rust: Screen::Social => "social",
    // rust: Screen::ServerLinks => "server-links",
    // rust: Screen::ConfirmLink => "confirm-link",
    // rust: Screen::DialogWarning => "dialog-warning",
    // rust: Screen::CommandBlock => "command-block",
    // rust: Screen::BlockEditor => "block-editor",
    // rust: Screen::Win => "win",
    // rust: Screen::DebugOptions => "debug-options",
    // rust: Screen::Mod => "mod",
    // rust: Screen::HudEditor => "hud-editor",
}
}

    // The hurts and melee attacks each player logged since the last call
    // (`PlayerMotion::hurt_log`, `attack_log`), taken out.
control_hurt_log :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: fn drain(
    // rust: name: &str,
    // rust: hurt_log: &mut Vec<horizon_client::health::HurtRecord>,
    // rust: attack_log: &mut Vec<horizon_client::health::AttackRecord>,
    // rust: ) -> Value {
    // rust: let hurts: Vec<Value> = hurt_log
    // rust: .drain(..)
    // rust: .map(|r| {
    // rust: json!({
    // rust: "t": r.game_time, "source": r.source, "amount": r.amount,
    // rust: "blocked": r.blocked, "taken": r.taken, "hurt": r.hurt,
    // rust: "armor": r.armor, "toughness": r.toughness, "health": r.health,
    // rust: "fire_ticks": r.fire_ticks, "knockback": r.knockback,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let attacks: Vec<Value> = attack_log
    // rust: .drain(..)
    // rust: .map(|r| {
    // rust: json!({
    // rust: "t": r.game_time, "target": r.target, "id": r.id, "killed": r.killed, "amount": r.amount,
    // rust: "scale": r.scale, "crit": r.crit, "landed": r.landed, "dealt": r.dealt,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: json!({ "name": name, "hurts": hurts, "attacks": attacks })
}
    // rust: let mut players = Vec::new();
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: players.push(drain("host", &mut p.hurt_log, &mut p.attack_log));
}
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: for g in &mut host.hub.guests {
    // rust: let name = g.name.clone();
    // rust: if let Some(m) = g.motion.as_mut() {
    // rust: players.push(drain(&name, &mut m.hurt_log, &mut m.attack_log));
    // rust: } else if let Some((mut hurts, mut attacks)) = g.logs_kept.take() {
                    // Dead, not yet respawned: what its last body logged.
    // rust: players.push(drain(&name, &mut hurts, &mut attacks));
}
}
}
    // rust: json!({ "ok": true, "players": players })
}

    // rust: pub(super) fn control_status(&self) -> Value {
    // rust: let player = self.player.as_ref().map(|p| {
    // rust: json!({
    // rust: "position": [p.position.x, p.position.y, p.position.z],
    // rust: "velocity": [p.velocity.x, p.velocity.y, p.velocity.z],
    // rust: "on_ground": p.ground.on_ground,
    // rust: "health": p.health.health(),
                // The maximum the HUD's hearts last read (its cached value).
    // rust: "max_health": p
    // rust: .attributes
    // rust: .lookup(p.attributes.key("minecraft:max_health").as_ref())
    // rust: .and_then(|h| p.attributes.instance(&h).ok())
    // rust: .map(|i| i.cached_value()),
    // rust: "food": p.health.food.food,
    // rust: })
    // rust: });
    // rust: let target = self.pick().map(|hit| {
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: json!({ "pos": hit.pos, "block": &*self.res.facts().get(state).name })
    // rust: });
    // rust: let renderer = self.renderer.as_ref().map(|r| {
    // rust: let [arena_bytes, section_vertex_bytes] = r.section_vertex_bytes();
            // Device memory by the backend's allocator (Vulkan; absent elsewhere).
    // rust: let memory = r.device.generate_allocator_report();
    // rust: json!({
    // rust: "gpu": r.info.name,
    // rust: "vendor": vendor_name(r.info.vendor),
    // rust: "driver": format!("{} {}", r.info.driver, r.info.driver_info).trim(),
    // rust: "device_type": match r.info.device_type {
    // rust: wgpu::DeviceType::IntegratedGpu => "integrated",
    // rust: wgpu::DeviceType::DiscreteGpu => "discrete",
    // rust: wgpu::DeviceType::VirtualGpu => "virtual",
    // rust: wgpu::DeviceType::Cpu => "cpu",
    // rust: wgpu::DeviceType::Other => "other",
    // rust: },
    // rust: "backend": format!("{:?}", r.info.backend),
    // rust: "size": [r.config.width, r.config.height],
    // rust: "present_mode": format!("{:?}", r.config.present_mode),
    // rust: "drawn_sections": r.drawn_sections,
    // rust: "section_draws": r.section_draws,
    // rust: "section_draw_calls": r.section_draw_calls,
    // rust: "culled_sections": r.culled_sections(),
    // rust: "gpu_culling": r.gpu_culling(),
    // rust: "gpu_frame": r.gpu_frame(),
    // rust: "gpu_fading": r.gpu_fading(),
    // rust: "gpu_culling_offer": format!("{:?}", r.gpu_culling_offer()),
    // rust: "gpu_occluding": r.gpu_occluding(),
    // rust: "stats_lag": r.stats_lag(),
    // rust: "uploaded_bytes": r.uploaded_bytes,
    // rust: "resident_sections": r.resident_sections(),
    // rust: "arena_bytes": arena_bytes,
    // rust: "section_vertex_bytes": section_vertex_bytes,
    // rust: "gpu_allocated_bytes": memory.as_ref().map(|m| m.total_allocated_bytes),
    // rust: "gpu_reserved_bytes": memory.as_ref().map(|m| m.total_reserved_bytes),
    // rust: })
    // rust: });
        // The keyboard as the OS reports it (screens read Shift and Ctrl here).
    // rust: let mut physical_keys: Vec<_> = self
    // rust: .physical_keys
    // rust: .iter()
    // rust: .map(|k| format!("{k:?}"))
    // rust: .collect();
    // rust: physical_keys.sort();
    // rust: let lod = json!({
    // rust: "distance": self.settings.horizon.lod_distance,
    // rust: "effective_distance": self.lod_distance(),
    // rust: "terrain_distance": self.terrain_distance(),
    // rust: "source": if self.lod.is_none() { "none" } else if self.integrated.is_some() { "integrated" } else if self.server_far_terrain().is_some() { "server" } else if self.remote.is_some() { "server-terrain" } else { "local" },
    // rust: "source_attempted": self.lod_source_attempted,
    // rust: "active_tiles": self.lod.as_ref().map_or(0, |lod| lod.stats().0),
    // rust: "cached_tiles": self.lod.as_ref().map_or(0, |lod| lod.stats().1),
    // rust: "far_detail": self.settings.horizon.far_detail.name(),
    // rust: "resident_quads": self.renderer.as_ref().map_or(0, |r| r.lod_quads()),
    // rust: "levels": self.renderer.as_ref().map_or_else(Vec::new, |r| r.lod_levels()),
    // rust: "pending_observations": self.lod_observe.len(),
    // rust: "refined_samples": self.lod.as_ref().map_or(0, |lod| lod.refined_samples()),
    // rust: });
        // The other players' cracks this client draws (LevelRenderer.destroyingBlocks).
    // rust: let destroying: Vec<_> = self
    // rust: .destroying
    // rust: .iter()
    // rust: .map(|(id, (pos, stage, _))| json!({ "id": id, "pos": pos, "stage": stage }))
    // rust: .collect();
    // rust: let mut status = json!({
    // rust: "screen": self.screen_name(),
    // rust: "debug": {
    // rust: "overlay": self.debug,
    // rust: "hitboxes": self.debug_entry("entity_hitboxes"),
    // rust: "chunk_borders": self.debug_entry("chunk_borders"),
    // rust: "pause_menu": self.pause_menu,
    // rust: "advanced_tooltips": self.settings.file.bool("advancedItemTooltips"),
    // rust: "pause_on_lost_focus": self.settings.file.bool("pauseOnLostFocus"),
    // rust: "clipboard": self.clipboard.copied(),
    // rust: },
    // rust: "dimension": self.dim.id(),
    // rust: "creative": self.creative,
    // rust: "player": player,
    // rust: "yaw": self.yaw,
    // rust: "pitch": self.pitch,
    // rust: "target": target,
    // rust: "selected": self.selected + 1,
    // rust: "held": self.held().map(|s| json!({ "item": &*s.item, "count": s.count })),
    // rust: "offhand": self.offhand.as_ref().map(|s| json!({ "item": &*s.item, "count": s.count, "damage": s.damage })),
    // rust: "keys": self.keys.iter().map(|k| format!("{k:?}")).collect::<Vec<_>>(),
            // The keyboard as the OS reports it (Shift and Ctrl in screens).
    // rust: "fps": self.fps,
    // rust: "frames": self.frames,
    // rust: "ticks": self.ticks,
    // rust: "day_time": self.world.day_time,
    // rust: "music": self.music.current(&self.audio.engine),
    // rust: "sounds": self.audio.census(),
    // rust: "fishing": self.hook_status(),
    // rust: "tridents": self.tridents.len(),
    // rust: "rockets": self.rockets.len(),
    // rust: "fight": self.dragon_status(),
            // A client of a server (single player's server thread) knows the
            // carts it was sent.
    // rust: "carts": self.remote_carts().unwrap_or_else(|| self.carts.iter().map(|c| serde_json::json!({"kind": c.kind.id(), "position": [c.position.x, c.position.y, c.position.z], "velocity": [c.velocity.x, c.velocity.y, c.velocity.z]})).collect::<Vec<_>>()),
    // rust: "riding": self.riding,
    // rust: "using": self.using,
    // rust: "render_distance": self.streaming.radius,
    // rust: "chunks": self.world.chunks.len(),
    // rust: "mobs": self.mobs.len(),
    // rust: "block_entities": self.world.block_entities.len(),
    // rust: "pending_chunks": self.streaming.pending() + self.pending_uploads.len() + self.remote_backlog(),
    // rust: "generated_chunks": self.streaming.generated_total,
    // rust: "meshed_sections": self.streaming.meshed_total,
    // rust: "streaming": self.streaming.stages().into_iter().map(|(k, v)| (k.to_string(), v.into())).collect::<serde_json::Map<_, _>>(),
    // rust: "dirty_light": self.world.dirty_light.len(),
    // rust: "renderer": renderer,
    // rust: "display": self.window.as_deref().and_then(horizon_client::telemetry::monitor).map(|m| json!({
    // rust: "width": m.size().width,
    // rust: "height": m.size().height,
    // rust: "scale": m.scale_factor(),
    // rust: "refresh_hz": m.refresh_rate_millihertz().map(|r| r.div_ceil(1000)),
    // rust: })),
    // rust: "uptime_seconds": self.started.elapsed().as_secs_f64(),
    // rust: "server": self.remote_status(),
            // The names the name tags show now, seen from the eyes.
    // rust: "name_tags": self
    // rust: .eye_position()
    // rust: .map(|e| self.shown_name_tags(glam::DVec3::from_array(e))),
    // rust: });
    // rust: status["lod"] = lod;
    // rust: let (target, sampled) = self.lod.as_ref().map_or((0, 0), |lod| lod.progress());
    // rust: status["lod"]["target_tiles"] = target.into();
    // rust: status["lod"]["sampled_target_tiles"] = sampled.into();
    // rust: let (wanted, refined) = self
    // rust: .lod
    // rust: .as_ref()
    // rust: .map_or((0, 0), |lod| lod.detail_progress());
    // rust: status["lod"]["detail_target_columns"] = wanted.into();
    // rust: status["lod"]["refined_target_columns"] = refined.into();
    // rust: status["pending_uploads"] = self.pending_uploads.len().into();
    // rust: status["destroying"] = json!(destroying);
    // rust: status["physical_keys"] = json!(physical_keys);
    // rust: status["heard"] = json!(self.audio.heard);
    // rust: status["stopped_sounds"] = json!(self.audio.stopped);
        // Boats, minecarts, armor stands, item frames and paintings.
    // rust: status["objects"] = json!(self.objects_status());
    // rust: status["lightning"] = json!({"bolts": self.bolts.len(), "struck": self.lightning_seen[0],
    // rust: "flashes": self.lightning_seen[1], "flash": self.flash});
        // Primed TNT, falling blocks, projectiles, tridents and end crystals.
    // rust: status["projectiles"] = json!(self.projectiles_status());
    // rust: let mut fangs_vertices = Vec::new();
    // rust: self.fangs_geometry(glam::DVec3::ZERO, 0.5, &mut fangs_vertices);
    // rust: status["fangs_vertices"] = json!(fangs_vertices.len());
    // rust: status["maps"] = json!(self.maps_status());
        // The particles made so far, by type.
    // rust: status["particles"] = json!(self.particles.made());
        // The pickup particles made so far, by what was taken.
    // rust: status["pickups"] = json!(self.pickups.made());
        // The world border this side knows of.
    // rust: status["border"] = json!({ "center": self.border.center(), "size": self.border.size() });
        // The scoreboard sidebar the HUD shows.
    // rust: status["sidebar"] = self.sidebar_status();
        // Who caused the input, and whether a repro recording runs.
    // rust: let mut input = self.input_trace.summary();
    // rust: self.repro
    // rust: .fill_summary(&mut input, self.input_trace.events());
    // rust: status["input"] = input;
    // rust: status
}
}

// PCI vendor IDs of the GPU makers players have (Apple's is wgpu's Metal value).
vendor_name :: proc(id: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: 0x10de => "nvidia".into(),
    // rust: 0x1002 | 0x1022 => "amd".into(),
    // rust: 0x8086 => "intel".into(),
    // rust: 0x106b => "apple".into(),
    // rust: 0x5143 => "qualcomm".into(),
    // rust: 0x13b5 => "arm".into(),
    // rust: 0x10005 => "mesa".into(),
    // rust: 0 => String::new(),
    // rust: other => format!("{other:#06x}"),
}
}

// The key a `key <name> tap|up` command releases, whatever its handler does.
released_modifier :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut words = line.split_whitespace();
    // rust: match (words.next(), words.next(), words.next()) {
    // rust: (Some("key"), Some(key), Some("tap" | "up")) => key_code(key),
    // rust: _ => None,
}
}

key_code :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.to_ascii_lowercase();
    // The game's own names (`key.keyboard.w`), which a recording writes.
    // rust: if let Some(code) = horizon_client::keybinds::key_code(&name) {
    // rust: return Some(code);
}
    // rust: let letters = [
    // rust: KeyCode::KeyA,
    // rust: KeyCode::KeyB,
    // rust: KeyCode::KeyC,
    // rust: KeyCode::KeyD,
    // rust: KeyCode::KeyE,
    // rust: KeyCode::KeyF,
    // rust: KeyCode::KeyG,
    // rust: KeyCode::KeyH,
    // rust: KeyCode::KeyI,
    // rust: KeyCode::KeyJ,
    // rust: KeyCode::KeyK,
    // rust: KeyCode::KeyL,
    // rust: KeyCode::KeyM,
    // rust: KeyCode::KeyN,
    // rust: KeyCode::KeyO,
    // rust: KeyCode::KeyP,
    // rust: KeyCode::KeyQ,
    // rust: KeyCode::KeyR,
    // rust: KeyCode::KeyS,
    // rust: KeyCode::KeyT,
    // rust: KeyCode::KeyU,
    // rust: KeyCode::KeyV,
    // rust: KeyCode::KeyW,
    // rust: KeyCode::KeyX,
    // rust: KeyCode::KeyY,
    // rust: KeyCode::KeyZ,
    // rust: ];
    // rust: let digits = [
    // rust: KeyCode::Digit0,
    // rust: KeyCode::Digit1,
    // rust: KeyCode::Digit2,
    // rust: KeyCode::Digit3,
    // rust: KeyCode::Digit4,
    // rust: KeyCode::Digit5,
    // rust: KeyCode::Digit6,
    // rust: KeyCode::Digit7,
    // rust: KeyCode::Digit8,
    // rust: KeyCode::Digit9,
    // rust: ];
    // rust: if let [c] = name.as_bytes() {
    // rust: return match c {
    // rust: b'a'..=b'z' => Some(letters[usize::from(c - b'a')]),
    // rust: b'0'..=b'9' => Some(digits[usize::from(c - b'0')]),
    // rust: _ => None,
}
}
    // rust: Some(match name.as_str() {
    // rust: "space" => KeyCode::Space,
    // rust: "shift" | "lshift" => KeyCode::ShiftLeft,
    // rust: "ctrl" | "control" | "lctrl" => KeyCode::ControlLeft,
        // The edit modifier on macOS (Cmd+A selects all there).
    // rust: "super" | "cmd" | "meta" => KeyCode::SuperLeft,
    // rust: "esc" | "escape" => KeyCode::Escape,
    // rust: "tab" => KeyCode::Tab,
    // rust: "enter" | "return" => KeyCode::Enter,
    // rust: "f1" => KeyCode::F1,
    // rust: "f2" => KeyCode::F2,
    // rust: "f3" => KeyCode::F3,
    // rust: "f4" => KeyCode::F4,
    // rust: "f5" => KeyCode::F5,
    // rust: "f6" => KeyCode::F6,
    // rust: "f11" => KeyCode::F11,
    // rust: "slash" | "/" => KeyCode::Slash,
    // rust: "backspace" => KeyCode::Backspace,
    // rust: "pageup" => KeyCode::PageUp,
    // rust: "pagedown" => KeyCode::PageDown,
    // rust: "left" => KeyCode::ArrowLeft,
    // rust: "right" => KeyCode::ArrowRight,
    // rust: "up" => KeyCode::ArrowUp,
    // rust: "down" => KeyCode::ArrowDown,
    // rust: _ => return None,
    // rust: })
}

// The title's own screens (not one opened over it, as Options is) take the
// text: the world name, the seed, a server's address.
    // rust: pub(super) fn title_owns_text(screen: &Screen, title_up: bool) -> bool {
    // rust: title_up && *screen == Screen::Playing
}

    // rust: mod tests {
//     use super::*;

the_title_takes_text_only_on_its_own_screens :: proc() {
}
    // rust: assert!(title_owns_text(&Screen::Playing, true));
    // rust: assert!(!title_owns_text(&Screen::Playing, false));
    // rust: assert!(!title_owns_text(&Screen::Options, true));
    // rust: assert!(!title_owns_text(&Screen::Chat, true));
}

hello_names_the_protocol_the_release_and_the_command_groups :: proc() {
}
    // rust: let reply = hello();
    // rust: assert_eq!(reply["release"], horizon_core::release::VERSION);
    // rust: let protocol = reply["protocol"].as_str().unwrap();
    // rust: let parts: Vec<_> = protocol.split('.').collect();
    // rust: assert!(
    // rust: parts.len() == 3 && parts.iter().all(|p| p.parse::<u32>().is_ok()),
    // rust: "{protocol}"
    // rust: );
    // rust: let features = reply["features"].as_array().unwrap();
    // rust: assert!(!features.is_empty());
    // rust: let mut names: Vec<_> = features.iter().filter_map(Value::as_str).collect();
    // rust: assert_eq!(names.len(), features.len());
    // rust: names.sort_unstable();
    // rust: names.dedup();
    // rust: assert_eq!(names.len(), features.len(), "a group is named twice");
}

taps_and_ups_always_release_their_key :: proc() {
}
    // rust: for line in ["key shift tap", "key shift up", "key  Shift  up"] {
    // rust: assert_eq!(released_modifier(line), Some(KeyCode::ShiftLeft), "{line}");
}
    // rust: for line in [
    // rust: "key shift down",
    // rust: "key shift repeat",
    // rust: "key shift",
    // rust: "keys shift up",
    // rust: "key nope up",
    // rust: ] {
    // rust: assert_eq!(released_modifier(line), None, "{line}");
}
}
}
