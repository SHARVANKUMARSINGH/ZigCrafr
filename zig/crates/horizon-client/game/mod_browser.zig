//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mod_browser
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Options > Mods > Browse mods (docs/design/mod-hotload.md): reading the
//! registry's index and installing a content mod run on a worker
//! (`horizon_client::mod_registry`); each frame takes what it finished into the
//! options screen's `mod_browser`. The window's game and the startup menu each
//! have one.
// use super::Game;
// use horizon_client::{
    // rust: lang,
    // rust: mod_browser::{Listing, ModBrowser, Status},
    // rust: mod_list::ModList,
    // rust: mod_registry::{self, Done},
}
// use horizon_mods::index::Index;
// use std::path::PathBuf;
// use std::sync::{
    // rust: Arc,
    // rust: mpsc::{Receiver, TryRecvError, channel},
}

/// What the worker sends back: the index and its listings, or an install's
/// outcome with the listings after it.
pub const Finished = enum {
    Index(Result<(Arc<Index>, Vec<Listing>), String>),
    Installed(Result<Done, String>, Vec<Listing>),
};

/// One job at a time, and the index read last.
    // rust: pub(super) struct Jobs {
    // rust: running: Option<Receiver<Finished>>,
    // rust: index: Option<Arc<Index>>,
}

    // rust: impl Jobs {
    /// Browse mods opened: the index, read again from the registry (the
    /// launcher's copy when it can't be reached).
    // rust: pub(super) fn browse(&mut self, ui: &mut ModBrowser, home: PathBuf) {
    // rust: if self.running.is_some() {
    // rust: return;
}
    // rust: if ui.status != Status::Ready {
    // rust: ui.status = Status::Loading;
}
    // rust: let (send, receive) = channel();
    // rust: self.running = Some(receive);
    // rust: spawn("mod-browser-index", move || {
    // rust: let read = mod_registry::load_index(&home, &mod_registry::location()).map(|index| {
    // rust: let listings = mod_registry::listings(&index, &home);
    // rust: (Arc::new(index), listings)
    // rust: });
    // rust: let _ = send.send(Finished::Index(read));
    // rust: });
}

    /// Install or update `id` from the index read last.
    // rust: pub(super) fn install(&mut self, ui: &mut ModBrowser, home: PathBuf, id: String) {
    // rust: let Some(index) = self.index.clone() else {
    // rust: return;
}
    // rust: if self.running.is_some() {
    // rust: return;
}
    // rust: ui.installing = Some(id.clone());
    // rust: ui.message = None;
    // rust: let (send, receive) = channel();
    // rust: self.running = Some(receive);
    // rust: spawn("mod-browser-install", move || {
    // rust: let done = mod_registry::install(&index, &home, &id, &mod_registry::download);
    // rust: let listings = mod_registry::listings(&index, &home);
    // rust: let _ = send.send(Finished::Installed(done, listings));
    // rust: });
}

    /// What finished since the last frame, into `ui`. An installed mod is
    /// turned on in `mods`; the caller saves the settings and lists the mods
    /// again when this returns true.
    // rust: pub(super) fn poll(&mut self, ui: &mut ModBrowser, mods: &mut ModList) -> bool {
    // rust: let Some(running) = &self.running else {
    // rust: return false;
}
    // rust: let finished = match running.try_recv() {
    // rust: Ok(finished) => finished,
    // rust: Err(TryRecvError::Empty) => return false,
    // rust: Err(TryRecvError::Disconnected) => {
    // rust: self.running = None;
    // rust: ui.installing = None;
    // rust: if ui.status == Status::Loading {
    // rust: ui.status = Status::Failed("the worker stopped".into());
}
    // rust: return false;
}
}
    // rust: self.running = None;
    // rust: match finished {
    // rust: Finished::Index(Ok((index, listings))) => {
    // rust: self.index = Some(index);
    // rust: ui.listings = listings;
    // rust: ui.status = Status::Ready;
    // rust: false
}
    // rust: Finished::Index(Err(why)) => {
    // rust: log::warn!("Horizon: the mod registry wasn't read: {why}");
    // rust: if ui.status != Status::Ready {
    // rust: ui.status = Status::Failed(why);
}
    // rust: false
}
    // rust: Finished::Installed(done, listings) => {
    // rust: ui.installing = None;
    // rust: ui.listings = listings;
    // rust: match done {
    // rust: Ok(done) => {
    // rust: log::info!(
    // rust: "Horizon: installed the mod {} {} from the registry ({})",
    // rust: done.id,
    // rust: done.version,
    // rust: if done.verified { "signed" } else { "unsigned" }
    // rust: );
    // rust: mods.enabled.insert(done.id.clone());
    // rust: mods.disabled.remove(&done.id);
    // rust: let name = ui
    // rust: .listing(&done.id)
    // rust: .map_or(done.id.clone(), |l| l.name.clone());
    // rust: let text = lang::tr("horizon.mods.browse.done", &[&name, &done.version]);
    // rust: ui.message = Some((text, true));
    // rust: true
}
    // rust: Err(why) => {
    // rust: log::warn!("Horizon: a registry mod wasn't installed: {why}");
    // rust: let text = lang::tr("horizon.mods.browse.install_failed", &[&why]);
    // rust: ui.message = Some((text, false));
    // rust: false
}
}
}
}
}
}

pub fn spawn(name: []const u8, work: impl FnOnce() void {
}
    // rust: if let Err(e) = std::thread::Builder::new().name(name.into()).spawn(work) {
    // rust: log::warn!("Horizon: {name} did not start: {e}");
}
}

    // rust: impl Game<'_> {
    /// Each frame: what the browser's worker finished.
    // rust: pub(super) fn drive_mod_browser(&mut self) {
    // rust: let installed = self
    // rust: .mods
    // rust: .jobs
    // rust: .poll(&mut self.ui.options.mod_browser, &mut self.settings.mods);
    // rust: if installed {
    // rust: self.settings.save(&Self::options_path());
    // rust: self.start_mods();
    // rust: self.switch_mods();
            // A mod with blocks, items or worldgen waits for a restart: the
            // project page says so instead of "installed and on".
    // rust: if let (Some(note), Some((message, _))) = (
    // rust: &self.ui.options.mods_note,
    // rust: &mut self.ui.options.mod_browser.message,
    // rust: ) {
    // rust: *message = format!("{message} {note}");
}
}
}
}
