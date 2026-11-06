//! Transpiled from Horizon Rust crate
//! Module: horizon-client_saving
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The save screen freezes simulation, but keeps pumping window events while
//! snapshots are prepared in small batches and the region workers drain.
// use super::{Game, loading_frame};
// use horizon_client::{Result, hud::HudBatch};
// use std::{
    // rust: collections::{HashSet, VecDeque},
    // rust: time::{Duration, Instant},
}

    // rust: pub(super) struct ClosingSave {
    // rust: pub quit: bool,
    // rust: close: bool,
    // rust: reply: Option<std::sync::mpsc::Sender<String>>,
    // rust: started: Instant,
    // rust: stage: Stage,
}
pub const Stage = enum {
    Generation,
    Chunks(VecDeque<(i32, i32)>),
    Entities(VecDeque<(i32, i32)>),
    Writes,
    Server,
    Quit,
};

// Bound the work in both sparse and block-entity-heavy worlds. A single chunk
// is indivisible; check the time budget after each snapshot, not each batch.
pub const SNAPSHOTS_PER_FRAME: usize = 16;
pub const SNAPSHOT_BUDGET: Duration = Duration::from_millis(2);

    // rust: impl Game<'_> {
    // rust: pub(super) fn begin_closing_save(&mut self, quit: bool) -> Result<()> {
    // rust: if let Some(save) = &mut self.pending_save {
    // rust: save.quit |= quit;
    // rust: return Ok(());
}
    // rust: if self.title.is_some() || self.saved_for_exit {
            // A quit from the title still needs the event loop to finish.
    // rust: self.pending_save = Some(ClosingSave {
    // rust: quit,
    // rust: close: true,
    // rust: reply: None,
    // rust: started: Instant::now(),
    // rust: stage: Stage::Quit,
    // rust: });
    // rust: return Ok(());
}
        // Stop client-side terrain work before the integrated server is shut down. The
        // server's own stop path aborts its workers, but the window's streaming registration
        // is dropped only after the event loop exits and would otherwise wait for queued work.
    // rust: self.streaming.abort_generation();
    // rust: if let Some(integrated) = &self.integrated {
    // rust: integrated.request_stop();
    // rust: self.pending_save = Some(ClosingSave {
    // rust: quit,
    // rust: close: true,
    // rust: reply: None,
    // rust: started: Instant::now(),
    // rust: stage: Stage::Server,
    // rust: });
    // rust: } else if self.remote.is_some() {
    // rust: if !quit {
    // rust: return self.leave_server(None);
}
    // rust: if let Some(mut remote) = self.remote.take() {
    // rust: remote.session.disconnect();
}
    // rust: self.saved_for_exit = true;
    // rust: self.pending_save = Some(ClosingSave {
    // rust: quit,
    // rust: close: true,
    // rust: reply: None,
    // rust: started: Instant::now(),
    // rust: stage: Stage::Quit,
    // rust: });
    // rust: } else {
    // rust: self.close_container();
    // rust: self.award_custom_stat("leave_game", 1);
    // rust: self.lan_close(false);
    // rust: self.free_player_beds()?;
    // rust: self.pending_save = Some(ClosingSave {
    // rust: quit,
    // rust: close: true,
    // rust: reply: None,
    // rust: started: Instant::now(),
    // rust: stage: Stage::Generation,
    // rust: });
}
    // rust: self.capture(false);
    // rust: Ok(())
}

    /// Control saves acknowledge only after durable completion, while their
    /// snapshot work is spread across event-loop turns too.
    // rust: pub(super) fn begin_control_save(
    // rust: &mut self,
    // rust: all: bool,
    // rust: reply: std::sync::mpsc::Sender<String>,
    // rust: ) -> Result<()> {
    // rust: if self.pending_save.is_some() {
    // rust: return Err("a world save is already in progress".into());
}
    // rust: if all {
    // rust: self.world
    // rust: .modified
    // rust: .extend(self.world.chunks.keys().copied());
}
    // rust: self.keys.clear();
    // rust: self.physical_keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.pending_save = Some(ClosingSave {
    // rust: quit: false,
    // rust: close: false,
    // rust: reply: Some(reply),
    // rust: started: Instant::now(),
    // rust: stage: Stage::Generation,
    // rust: });
    // rust: Ok(())
}

    /// `true` means the window can exit. The session lock stays in Game until
    /// every snapshot has been queued and every writer has synced its files.
    // rust: pub(super) fn poll_closing_save(&mut self) -> Result<bool> {
    // rust: let Some(mut save) = self.pending_save.take() else {
    // rust: return Ok(false);
}
    // rust: let result = (|| -> Result<bool> {
    // rust: match &mut save.stage {
    // rust: Stage::Quit => Ok(true),
    // rust: Stage::Server => {
    // rust: let server = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .ok_or("the integrated server stopped with an error")?;
    // rust: if !server.stopped() {
    // rust: return Ok(false);
}
                    // Drop/join only after completion; leave_server's teardown
                    // can then run without blocking on the server's writes.
    // rust: if save.quit {
    // rust: self.integrated.take().unwrap().stop()?;
    // rust: } else {
    // rust: self.leave_server(None)?;
}
    // rust: Ok(true)
}
    // rust: Stage::Generation => {
    // rust: if save.started.elapsed() > Duration::from_secs(30) {
    // rust: return Err("chunk generation did not finish before saving".into());
}
    // rust: if self.streaming.poll_save(&mut self.world) {
    // rust: save.stage = Stage::Chunks(self.world.modified.iter().copied().collect());
}
    // rust: Ok(false)
}
    // rust: Stage::Chunks(keys) => {
    // rust: let started = Instant::now();
    // rust: for _ in 0..SNAPSHOTS_PER_FRAME {
    // rust: let Some(&key) = keys.front() else { break };
    // rust: let chunks = self.with_entities(self.world.chunks.get(&key));
    // rust: self.save.save_later(
    // rust: &chunks,
    // rust: self.pack.assets.registry,
    // rust: world_biomes!(self),
    // rust: )?;
    // rust: self.world.modified.remove(&key);
    // rust: keys.pop_front();
    // rust: if started.elapsed() >= SNAPSHOT_BUDGET {
    // rust: break;
}
}
    // rust: if keys.is_empty() {
    // rust: self.spawn_loaded_entities();
    // rust: save.stage = Stage::Entities(self.world.chunks.keys().copied().collect());
}
    // rust: Ok(false)
}
    // rust: Stage::Entities(keys) => {
    // rust: let started = Instant::now();
    // rust: for _ in 0..SNAPSHOTS_PER_FRAME {
    // rust: let Some(&key) = keys.front() else { break };
    // rust: let chunks = self.entity_chunks(&HashSet::from([key]), false);
    // rust: self.save.save_entities_later(chunks)?;
    // rust: keys.pop_front();
    // rust: if started.elapsed() >= SNAPSHOT_BUDGET {
    // rust: break;
}
}
    // rust: if keys.is_empty() {
    // rust: self.prune_entity_memory();
    // rust: self.save_raids();
    // rust: self.save.save_attachments(&self.world.attachments)?;
    // rust: self.save.save_forced_chunks(&self.streaming.forced)?;
    // rust: self.save_game_metadata()?;
    // rust: save.stage = Stage::Writes;
}
    // rust: Ok(false)
}
    // rust: Stage::Writes => {
    // rust: let players = self.finish_player_autosaves(false)?;
    // rust: Ok(self.save.writes_finished()? && players)
}
}
    // rust: })();
    // rust: match result {
    // rust: Ok(true) => {
    // rust: if let Some(reply) = save.reply.take() {
    // rust: let _ = reply.send(serde_json::json!({ "ok": true }).to_string());
}
    // rust: if save.quit && !save.close {
                    // A window close during a control save still has to close
                    // containers and save the resulting inventory changes.
    // rust: self.begin_closing_save(true)?;
    // rust: return Ok(false);
}
    // rust: if save.quit {
    // rust: self.saved_for_exit = true;
    // rust: Ok(true)
    // rust: } else {
    // rust: if save.close && self.title.is_none() {
    // rust: self.finish_perf();
    // rust: self.finish_close_world()?;
}
    // rust: self.clock.reset();
    // rust: self.previous = Instant::now();
    // rust: Ok(false)
}
}
    // rust: other => {
    // rust: if let Err(error) = &other
    // rust: && let Some(reply) = save.reply.take()
    // rust: {
    // rust: let _ =
    // rust: reply.send(serde_json::json!({ "error": error.to_string() }).to_string());
}
                // Keep ownership (and the lock) on errors too. Native shutdown
                // sees the same durable-write failure instead of declaring success.
    // rust: self.pending_save = Some(save);
    // rust: other
}
}
}

    // rust: pub(super) fn render_closing_save(&mut self) -> Result<()> {
    // rust: if matches!(
    // rust: self.pending_save.as_ref().map(|save| &save.stage),
    // rust: Some(Stage::Quit)
    // rust: ) {
    // rust: return Ok(());
}
        // disconnectWithSavingScreen: a GenericMessageScreen, its title and
        // no navigation.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "saving",
    // rust: super::screen_info::tr("menu.savingLevel", &[]),
    // rust: )
    // rust: .without_navigation()
    // rust: });
    // rust: let Some(renderer) = &mut self.renderer else {
    // rust: return Ok(());
}
    // rust: let mut hud = HudBatch::new([renderer.config.width, renderer.config.height]);
    // rust: let progress = match self.pending_save.as_ref().map(|save| &save.stage) {
    // rust: Some(Stage::Chunks(_)) => 0.25,
    // rust: Some(Stage::Entities(_)) => 0.5,
    // rust: Some(Stage::Writes) => 0.9,
    // rust: _ => 0.0,
}
    // rust: horizon_client::level_loading::draw_progress(
    // rust: &mut hud,
    // rust: &self.gui.atlas,
    // rust: "Saving world...",
    // rust: progress,
    // rust: );
    // rust: renderer.render(&loading_frame(&hud))?;
    // rust: Ok(())
}
}
