//! Transpiled from Horizon Rust crate
//! Module: horizon-client_server_packs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A server's resource packs bound to the game (`ClientCommonPacketListenerImpl.
//! handleResourcePackPush` and `handleResourcePackPop`, its `PackConfirmScreen`,
//! and `DownloadedPackSource` as `Minecraft` drives it): the prompt, the
//! server list's setting, downloads into `downloads/`, and a resource reload
//! with the server's packs on top of the player's own.
// use super::{Game, packs::ReloadKind};
// use horizon_client::{
    // rust: Result,
    // rust: confirm_screen::Confirm,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: java_text, multiplayer, packs,
    // rust: scoreboard::{comp_text, tag_to_json},
    // rust: server_packs::{Prompt, ServerPacks, action, download, parse_sha1, valid_url},
    // rust: text::{Text, named_color},
    // rust: toasts::SystemToast,
    // rust: ui,
}
// use horizon_core::jmath;
// use horizon_protocol::{packets::configuration::ResourcePackPush, servers};
// use std::{
    // rust: path::PathBuf,
    // rust: sync::mpsc::{Receiver, TryRecvError},
}

/// `ClientCommonPacketListenerImpl.PackConfirmScreen`: the packs it asks
/// about, whether the last one is required, and the server's message.
    // rust: pub(super) struct PackPrompt {
    // rust: requests: Vec<(u128, String, String)>,
    // rust: required: bool,
    // rust: prompt: Option<Text>,
}
    // rust: impl PackPrompt {
pub fn texts(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = |key: &str| Text::translate(key, &[]);
    // rust: let (title, line2) = if self.required {
    // rust: let yellow = named_color("yellow").unwrap_or(0xFFFF55);
    // rust: (
    // rust: t("multiplayer.requiredTexturePrompt.line1"),
    // rust: t("multiplayer.requiredTexturePrompt.line2")
    // rust: .with_color(yellow)
    // rust: .bold(),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: t("multiplayer.texturePrompt.line1"),
    // rust: t("multiplayer.texturePrompt.line2"),
    // rust: )
}
        // preparePackPrompt.
    // rust: let message = match &self.prompt {
    // rust: Some(prompt) => Text::translate(
    // rust: "multiplayer.texturePrompt.serverPrompt",
    // rust: &[line2, prompt.clone()],
    // rust: ),
    // rust: None => line2,
}
    // rust: let buttons = if self.required {
    // rust: [t("gui.proceed"), t("menu.disconnect")]
    // rust: } else {
    // rust: [t("gui.yes"), t("gui.no")]
}
    // rust: (title, message, buttons)
}
pub fn layout(self: *Self, atlas: *HudAtlas, size: (f32) void {
}
    // rust: let (title, message, _) = self.texts();
    // rust: Confirm::new(&atlas.font, size, &title, &message)
}
}

    // rust: impl ServerPackState {
    /// The `ToastManager` slots the download toasts hold.
    // rust: pub(super) fn toast_slots(&self) -> impl Iterator<Item = usize> + '_ {
    // rust: self.notifiers
    // rust: .iter()
    // rust: .filter_map(|n| n.toast.as_ref())
    // rust: .chain(self.load_fail.as_ref())
    // rust: .chain(self.chunk_io.iter().flatten())
    // rust: .filter_map(|t| t.slot)
}
}

/// The game's `DownloadedPackSource`.
    // rust: pub(super) struct ServerPackState {
    // rust: packs: ServerPacks,
    /// `downloads/` in the game folder, opened at the first download.
    // rust: queue: Option<download::Queue>,
    // rust: pub(super) prompt: Option<PackPrompt>,
    /// The server list entry the setting is saved to (none: a direct join).
    // rust: pub(super) address: Option<String>,
    /// The account the downloads are made for (the download headers).
    // rust: user: (String, u128),
    /// The packs loaded on top of the player's own, bottom first.
    // rust: pub(super) active: Vec<packs::Pack>,
    /// The download batches' notifiers, oldest first.
    // rust: notifiers: Vec<PackNotifier>,
    /// `SystemToastId.PACK_LOAD_FAILURE`: the toast `Minecraft.clearResourcePacksOnError` adds.
    // rust: pub(super) load_fail: Option<SystemToast>,
    /// `SystemToastId.LOW_DISK_SPACE`, `CHUNK_LOAD_FAILURE` and `CHUNK_SAVE_FAILURE`:
    /// the toasts the integrated server's chunk IO reports add (`chunk_io`).
    // rust: pub(super) chunk_io: [Option<SystemToast>; 3],
}
/// `DownloadedPackSource.createDownloadNotifier`: one batch's progress in its
/// own `SystemToast`.
pub const PackNotifier = struct {
    progress: Receiver<download::Progress>,
    total: usize,
    /// `count`: the requests started.
    count: usize,
    /// `failCount`.
    failed: usize,
    /// `totalBytes`: the Content-Length of the request in flight.
    size: ?u64,
    /// The bytes it has written so far: none before the first response.
    bytes: ?u64,
    /// The last request has finished.
    done: bool,
    toast: ?SystemToast,
};
    // rust: impl PackNotifier {
pub fn new(progress: Receiver<download::Progress>, total: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: progress,
    // rust: total,
    // rust: count: 0,
    // rust: failed: 0,
    // rust: size: None,
    // rust: bytes: None,
    // rust: done: false,
    // rust: toast: None,
}
}
    /// The batch's events since the last call, with the toast updated once
    /// for all of them. False once the batch has ended and its toast is gone.
pub fn poll(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut changed, mut hide) = (false, false);
    // rust: let ended = loop {
    // rust: let event = match self.progress.try_recv() {
    // rust: Ok(event) => event,
    // rust: Err(e) => break e == TryRecvError::Disconnected,
}
    // rust: changed |= match event {
    // rust: download::Progress::RequestStart => {
    // rust: self.count += 1;
    // rust: true
}
    // rust: download::Progress::DownloadStart(size) => {
    // rust: self.size = size;
    // rust: self.bytes = Some(0);
    // rust: true
}
    // rust: download::Progress::Bytes(bytes) => {
    // rust: self.bytes = Some(bytes);
    // rust: true
}
    // rust: download::Progress::RequestFinished(ok) => {
    // rust: self.failed += usize::from(!ok);
    // rust: self.done = self.count == self.total;
                    // Every pack came: forceHide; else the failure title.
    // rust: hide |= self.done && self.failed == 0;
    // rust: self.done && self.failed > 0
}
}
}
    // rust: if changed {
    // rust: let (title, message) = self.text();
    // rust: let (title, message) = (title.plain(), message.map(|m| m.plain()));
            // SystemToast.addOrUpdate.
    // rust: match &mut self.toast {
    // rust: Some(toast) => toast.reset(title, message),
    // rust: None => self.toast = Some(SystemToast::new(title, message)),
}
}
    // rust: if hide && let Some(toast) = &mut self.toast {
    // rust: toast.force_hide();
}
    // rust: !ended || self.toast.is_some()
}
    /// The toast's title and message.
pub fn text(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.done && self.failed > 0 {
    // rust: let failed = Text::tr("download.pack.failed", &[&self.failed, &self.total]);
    // rust: return (failed, None);
}
    // rust: let title = Text::tr("download.pack.title", &[&self.count, &self.total]);
    // rust: let message = self.bytes.map(|bytes| match self.size {
    // rust: Some(size) if size > 0 => {
    // rust: Text::tr("download.pack.progress.percent", &[&(bytes * 100 / size)])
}
    // rust: _ => Text::tr("download.pack.progress.bytes", &[&human_readable(bytes)]),
    // rust: });
    // rust: (title, message)
}
}
/// `com.mojang.realmsclient.Unit.humanReadable`, for
/// `download.pack.progress.bytes`.
pub fn human_readable(bytes: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if bytes < 1024 {
    // rust: return format!("{bytes} B");
}
    // rust: let exp = (jmath::log(bytes as f64) / jmath::log(1024.0)) as i32;
    // rust: let prefix = &"KMGTPE"[exp as usize - 1..exp as usize];
    // rust: let value = bytes as f64 / 1024f64.powi(exp);
    // rust: format!("{} {prefix}B", java_text::format_fixed(value, 1))
}

    // rust: pub(super) fn saves() -> PathBuf {
    // rust: std::env::current_dir().unwrap_or_default().join("saves")
}

/// `WorldOpenFlows.WORLD_PACK_ID`: the id of a world's own resource pack.
pub const WORLD_PACK_ID: u128 = 0x640a6a92_b6cb_48a0_b391_831586500359;

    // rust: impl Game<'_> {
    /// `WorldOpenFlows.loadBundledResourcePack`: a world's own
    /// `resourcepacks/resources.zip` is pushed as a local pack before the world
    /// connects, after `configureForLocalWorld` so the pack is accepted at once.
    // rust: pub(super) fn server_packs_world_pack(&mut self, folder: &str) {
    // rust: let path = saves()
    // rust: .join(folder)
    // rust: .join("resourcepacks")
    // rust: .join("resources.zip");
    // rust: if path.is_file() {
    // rust: self.server_packs.packs.local_world();
    // rust: self.server_packs.packs.push_local(WORLD_PACK_ID, path);
}
}
    /// `ConnectScreen`: the server's setting decides what its packs do
    /// (`configureForServerControl`); single player's own server takes them
    /// all, quietly (`configureForLocalWorld`).
    // rust: pub(super) fn server_packs_connect(&mut self, address: Option<&str>, user: (String, u128)) {
    // rust: let state = &mut self.server_packs;
    // rust: state.user = user;
    // rust: state.prompt = None;
    // rust: state.notifiers.clear();
    // rust: let Some(address) = address else {
    // rust: state.address = None;
    // rust: state.packs.local_world();
    // rust: return;
}
    // rust: let file = multiplayer::servers_file(&saves());
    // rust: let entry = servers::load(&file).into_iter().find(|s| s.ip == address);
    // rust: let setting = entry.as_ref().and_then(|e| e.accept_textures);
    // rust: state.address = entry.map(|e| e.ip);
    // rust: state.packs.connect(Prompt::for_server(setting));
        // GetServerDetailsTask.scheduleResourcePackDownload: the Realm's own pack, which the
        // player agreed to before connecting (`allowServerPacks`, then `pushPack`).
    // rust: if let Some(pack) = horizon_client::realms::take_pending_pack(address) {
    // rust: state.packs.allow();
    // rust: state.packs.push(pack.id, &pack.url, parse_sha1(&pack.hash));
}
}
    /// `Minecraft.clearDownloadedResourcePacks`: every server pack goes at once.
    // rust: pub(super) fn server_packs_disconnect(&mut self) {
    // rust: self.server_packs.prompt = None;
    // rust: self.server_packs.notifiers.clear();
    // rust: self.server_packs.packs.disconnect();
    // rust: self.tick_server_packs();
}

    /// `handleResourcePackPush`.
    // rust: pub(super) fn handle_pack_push(&mut self, p: ResourcePackPush) {
    // rust: if !valid_url(&p.url) {
    // rust: self.send_pack_status(p.id, action::INVALID_URL);
    // rust: return;
}
    // rust: let setting = self.server_setting();
    // rust: let prompt = Prompt::for_server(setting);
    // rust: if prompt != Prompt::Pending && (!p.required || prompt != Prompt::Declined) {
    // rust: self.server_packs
    // rust: .packs
    // rust: .push(p.id, &p.url, parse_sha1(&p.hash));
    // rust: return;
}
        // addOrUpdatePackPrompt: one prompt for every pack pushed before it is answered.
    // rust: let text = p.prompt.as_ref().map(|t| comp_text(&tag_to_json(t)));
    // rust: let state = &mut self.server_packs;
    // rust: let open = state.prompt.get_or_insert(PackPrompt {
    // rust: requests: Vec::new(),
    // rust: required: p.required,
    // rust: prompt: None,
    // rust: });
    // rust: open.requests.push((p.id, p.url, p.hash));
    // rust: open.required = p.required;
    // rust: open.prompt = text;
        // Gui.setScreen: KeyMapping.releaseAll, so no walking behind the prompt.
    // rust: self.keys.clear();
    // rust: self.capture(false);
}
    /// `handleResourcePackPop`: one pack, or all of them.
    // rust: pub(super) fn handle_pack_pop(&mut self, id: Option<u128>) {
    // rust: match id {
    // rust: Some(id) => self.server_packs.packs.pop(id),
    // rust: None => self.server_packs.packs.pop_all(),
}
}
    /// The joined server's entry in the server list: its `acceptTextures`.
pub fn server_setting(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let address = self.server_packs.address.as_deref()?;
    // rust: servers::load(&multiplayer::servers_file(&saves()))
    // rust: .into_iter()
    // rust: .find(|s| s.ip == address)?
    // rust: .accept_textures
}
pub fn send_pack_status(self: *Self, id: u128, status: i32) void {
}
    // rust: if let Some(r) = &self.remote {
    // rust: r.session.send_pack_status(id, status);
}
}

    /// Splitscreen: this player's answer for the server's packs, once it gave one (or its
    /// server list entry did).
    // rust: pub(super) fn pack_answer(&self) -> Option<bool> {
    // rust: match self.server_packs.packs.prompt() {
    // rust: Prompt::Allowed => Some(true),
    // rust: Prompt::Declined => Some(false),
    // rust: Prompt::Pending => None,
}
}
    /// Splitscreen: this player is asked about a server's packs right now.
    // rust: pub(super) fn pack_prompt_open(&self) -> bool {
    // rust: self.server_packs.prompt.is_some()
}
    /// The prompt's answer (`PackConfirmScreen`'s callback): the server's
    /// setting follows it, declining a required pack disconnects, and every
    /// pack it asked about is pushed.
    // rust: pub(super) fn answer_pack_prompt(&mut self, yes: bool) -> Result<()> {
    // rust: let Some(prompt) = self.server_packs.prompt.take() else {
    // rust: return Ok(());
}
    // rust: if self.player.is_some() && self.screen == super::Screen::Playing {
    // rust: self.capture(true);
}
    // rust: let setting = if yes {
    // rust: self.server_packs.packs.allow();
    // rust: Some(true)
    // rust: } else {
    // rust: self.server_packs.packs.reject();
    // rust: if prompt.required {
    // rust: let reason = Text::translate("multiplayer.requiredTexturePrompt.disconnect", &[]);
    // rust: return self.leave_server(Some(reason.plain()));
}
    // rust: Some(false)
}
    // rust: for (id, url, hash) in prompt.requests {
    // rust: self.server_packs.packs.push(id, &url, parse_sha1(&hash));
}
        // ServerList.saveSingleServer.
    // rust: if let Some(address) = &self.server_packs.address {
    // rust: let file = multiplayer::servers_file(&saves());
    // rust: let mut list = servers::load(&file);
    // rust: for entry in list.iter_mut().filter(|s| &s.ip == address) {
    // rust: entry.accept_textures = setting;
}
    // rust: if let Err(e) = servers::save(&file, &list) {
    // rust: log::warn!("Horizon: could not save {}: {e}", file.display());
}
}
    // rust: Ok(())
}

    /// Runs what the packs need (`createUpdateScheduler`): the downloads
    /// that finished, the ones to start, a resource reload when the active
    /// packs change, and the statuses for the server.
    // rust: pub(super) fn tick_server_packs(&mut self) {
        // SystemToast.addOrUpdate's addToast: mods hear each new toast, so a
        // cancelled one is asked again at the batch's next change.
    // rust: let mut notifiers = std::mem::take(&mut self.server_packs.notifiers);
    // rust: notifiers.retain_mut(|n| {
    // rust: let new = n.toast.is_none();
    // rust: let keep = n.poll();
    // rust: if new && n.toast.is_some() && !self.toast_allowed("system", "pack_download") {
    // rust: n.toast = None;
}
    // rust: keep
    // rust: });
    // rust: notifiers.append(&mut self.server_packs.notifiers);
    // rust: self.server_packs.notifiers = notifiers;
    // rust: self.drive_mod_browser();
        // A reload waits for the world's resources (`reload_packs`).
    // rust: if self.rest_loader.is_some() {
    // rust: return;
}
    // rust: self.drive_pack_reload();
    // rust: self.drive_pack_browser();
        // One reload at a time: the player's own waits under its overlay
        // before the server's packs can ask for theirs (`ServerPacks` keeps
        // its own reload from overlapping).
    // rust: let selection_reloading = self
    // rust: .pack_reload
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.kind() == ReloadKind::Selection);
    // rust: let finished = self
    // rust: .server_packs
    // rust: .queue
    // rust: .as_ref()
    // rust: .map(download::Queue::finished)
    // rust: .unwrap_or_default();
    // rust: for batch in finished {
    // rust: self.server_packs.packs.downloaded(batch);
}
    // rust: while !selection_reloading && self.server_packs.packs.wants_tick() {
    // rust: let tick = self.server_packs.packs.tick();
    // rust: if !tick.download.is_empty() {
    // rust: self.start_pack_downloads(tick.download);
}
    // rust: if let Some(load) = tick.reload {
    // rust: self.start_pack_reload(&load);
}
}
    // rust: for (id, status) in self.server_packs.packs.take_replies() {
    // rust: self.send_pack_status(id, status);
}
}
pub fn start_pack_downloads(self: *Self, requests: std.ArrayList(horizon_client::server_packs::Request)) void {
}
    // rust: let state = &mut self.server_packs;
    // rust: if state.queue.is_none() {
    // rust: let dir = std::env::current_dir()
    // rust: .unwrap_or_default()
    // rust: .join("downloads");
    // rust: match download::Queue::open(dir) {
    // rust: Ok(queue) => state.queue = Some(queue),
    // rust: Err(e) => {
    // rust: log::error!("Horizon: failed to open the download queue: {e}");
                    // Every request failed, as the notifier would hear it.
    // rust: let (progress, events) = std::sync::mpsc::channel();
    // rust: for _ in &requests {
    // rust: let _ = progress.send(download::Progress::RequestStart);
    // rust: let _ = progress.send(download::Progress::RequestFinished(false));
}
    // rust: state
    // rust: .notifiers
    // rust: .push(PackNotifier::new(events, requests.len()));
    // rust: let failed = requests.iter().map(|r| r.id).collect();
    // rust: state.packs.downloaded(horizon_client::server_packs::Batch {
    // rust: downloaded: Vec::new(),
    // rust: failed,
    // rust: });
    // rust: return;
}
}
}
    // rust: let headers = download::headers(&state.user.0, state.user.1);
    // rust: let (progress, events) = std::sync::mpsc::channel();
    // rust: state
    // rust: .notifiers
    // rust: .push(PackNotifier::new(events, requests.len()));
    // rust: if let Some(queue) = &state.queue {
    // rust: queue.download(requests, headers, progress);
}
}
    /// `DownloadedPackSource.startReload`: the packs on top of the player's
    /// own, staged on a worker (`Minecraft.reloadResourcePacks` under a
    /// `LoadingOverlay`); `drive_pack_reload` applies it. A pack with no
    /// readable `pack.mcmeta` fails the reload at once, as `onFailure`.
pub fn start_pack_reload(self: *Self, load: *[(u128) void {
}
    // rust: let server: Option<Vec<_>> = load
    // rust: .iter()
    // rust: .map(|(id, path)| packs::server_pack(*id, path))
    // rust: .collect();
    // rust: let Some(server) = server else {
    // rust: log::warn!("Horizon: invalid pack metadata in a server pack, ignoring all");
    // rust: self.finish_pack_reload(false);
    // rust: return;
}
    // rust: self.server_packs.active = server;
    // rust: if let Err(e) = self.spawn_pack_reload(ReloadKind::Server) {
    // rust: log::error!("Horizon: could not start the pack reload worker: {e}");
    // rust: self.finish_pack_reload(false);
}
}
    /// `ServerPacks::reloaded` and the recovery reload it can ask for.
    // rust: pub(super) fn finish_pack_reload(&mut self, ok: bool) {
    // rust: if let Some(recovery) = self.server_packs.packs.reloaded(ok) {
    // rust: self.start_pack_reload(&recovery);
}
}

    // rust: pub(super) fn draw_pack_prompt(&self, batch: &mut HudBatch) {
    // rust: let Some(prompt) = &self.server_packs.prompt else {
    // rust: return;
}
    // rust: horizon_client::widgets::cover_frame();
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: if self.player.is_none() {
            // In place of the connecting screen, on its background.
    // rust: batch.fill(
    // rust: atlas,
    // rust: 0.0,
    // rust: 0.0,
    // rust: w,
    // rust: h,
    // rust: horizon_client::hud::rgba(20, 20, 20, 255),
    // rust: );
}
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.player.is_some());
    // rust: let (title, message, [yes, no]) = prompt.texts();
        // PackConfirmScreen is a ConfirmScreen.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: super::screen_info::confirm("pack_prompt", &title.plain(), &message.plain())
    // rust: });
    // rust: let mut layout = prompt.layout(atlas, (w, h));
    // rust: layout.declare_no();
    // rust: layout.draw(batch, atlas, self.cursor, [&yes, &no]);
}
    /// `IntegratedServer.reportChunkLoadFailure` and the like: what the server
    /// thread reported since the last frame, each in `SystemToast.addOrUpdate`
    /// (a toast still shown is reset, else a new one).
pub fn add_chunk_io_toasts(self: *Self) void {
}
    // rust: let pending = horizon_client::chunk_io::take();
    // rust: let toasts = [
    // rust: pending
    // rust: .low_disk_space
    // rust: .then(horizon_client::chunk_io::low_disk_space_toast),
    // rust: pending
    // rust: .load_failure
    // rust: .map(|(x, z)| horizon_client::chunk_io::load_failure_toast(x, z)),
    // rust: pending
    // rust: .save_failure
    // rust: .map(|(x, z)| horizon_client::chunk_io::save_failure_toast(x, z)),
    // rust: ];
    // rust: let ids = ["low_disk_space", "chunk_load_failure", "chunk_save_failure"];
    // rust: for (i, (new, id)) in toasts.into_iter().zip(ids).enumerate() {
    // rust: let Some(new) = new else { continue };
    // rust: if let Some(shown) = self.server_packs.chunk_io[i].as_mut() {
    // rust: shown.reset_from(new);
    // rust: } else if self.toast_allowed("system", id) {
    // rust: self.server_packs.chunk_io[i] = Some(new);
}
}
}

    /// The download notifiers' toasts, each in a free 32-pixel slot of the
    /// `ToastManager` (`hidden`, F1, keeps them timing out undrawn).
    // rust: pub(super) fn draw_pack_toasts(&mut self, batch: &mut HudBatch, hidden: bool) {
    // rust: let multiplier = f64::from(self.settings.notification_display_time);
    // rust: self.add_chunk_io_toasts();
    // rust: let mut used = self.toast_slots_used();
    // rust: let packs = &mut self.server_packs;
    // rust: for slot_toast in packs
    // rust: .notifiers
    // rust: .iter_mut()
    // rust: .map(|n| &mut n.toast)
    // rust: .chain(std::iter::once(&mut packs.load_fail))
    // rust: .chain(packs.chunk_io.iter_mut())
    // rust: {
    // rust: let Some(toast) = slot_toast else {
    // rust: continue;
}
    // rust: if toast.slot.is_none() {
    // rust: let Some(slot) = (0..Self::TOAST_SLOTS).find(|s| used & (1 << s) == 0) else {
    // rust: continue;
}
    // rust: used |= 1 << slot;
    // rust: toast.slot = Some(slot);
}
    // rust: let (sound, finished) = toast.update(multiplier);
    // rust: if let Some(show) = sound {
    // rust: let event = if show { "ui.toast.in" } else { "ui.toast.out" };
    // rust: self.audio
    // rust: .play(&format!("minecraft:{event}"), None, 1.0, 1.0);
}
    // rust: if finished {
    // rust: *slot_toast = None;
    // rust: continue;
}
    // rust: if let (false, Some(slot)) = (hidden, toast.slot) {
    // rust: toast.draw(&self.gui.atlas, batch, 32.0 * slot as f32);
}
}
    // rust: self.draw_split_hud(batch, hidden);
}
    /// A left click on the prompt: its answer when it hit a button.
    // rust: pub(super) fn pack_prompt_click(&mut self) -> Result<()> {
    // rust: let Some(prompt) = &self.server_packs.prompt else {
    // rust: return Ok(());
}
    // rust: let answer = prompt
    // rust: .layout(&self.gui.atlas, self.gui_size())
    // rust: .answer_at(self.cursor);
    // rust: match answer {
    // rust: Some(yes) => {
    // rust: self.audio.play_button_click();
    // rust: self.answer_pack_prompt(yes)
}
    // rust: None => Ok(()),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use download::Progress::*;

pub fn notifier(total: usize, events: *[download::Progress]) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (send, receive) = std::sync::mpsc::channel();
    // rust: for event in events {
    // rust: send.send(*event).unwrap();
}
    // rust: let mut notifier = PackNotifier::new(receive, total);
    // rust: assert!(notifier.poll());
    // rust: notifier
}
pub fn texts(n: *PackNotifier) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (title, message) = n.text();
    // rust: (title.component(), message.map(|m| m.component()))
}

pub fn the_toast_counts_requests_and_shows_progress() void {
}
    // rust: let n = notifier(2, &[RequestStart]);
    // rust: let (title, message) = texts(&n);
    // rust: assert_eq!(title["translate"], "download.pack.title");
    // rust: assert_eq!(title["with"], serde_json::json!([1, 2]));
    // rust: assert_eq!(message, None);
    // rust: let n = notifier(2, &[RequestStart, DownloadStart(Some(400)), Bytes(100)]);
    // rust: assert_eq!(
    // rust: texts(&n).1.unwrap(),
    // rust: serde_json::json!({"translate": "download.pack.progress.percent", "with": [25]})
    // rust: );
    // rust: let n = notifier(1, &[RequestStart, DownloadStart(None), Bytes(1280)]);
    // rust: assert_eq!(
    // rust: texts(&n).1.unwrap()["with"],
    // rust: serde_json::json!([{"text": "1.3 KB"}])
    // rust: );
}

pub fn a_failed_pack_turns_the_toast_into_the_failure_count() void {
}
    // rust: let events = [
    // rust: RequestStart,
    // rust: RequestFinished(false),
    // rust: RequestStart,
    // rust: DownloadStart(Some(3)),
    // rust: Bytes(3),
    // rust: ];
    // rust: let (send, receive) = std::sync::mpsc::channel();
    // rust: for event in events {
    // rust: send.send(event).unwrap();
}
    // rust: let mut n = PackNotifier::new(receive, 2);
    // rust: assert!(n.poll());
        // Not the last request yet: still downloading.
    // rust: assert_eq!(texts(&n).0["translate"], "download.pack.title");
    // rust: send.send(RequestFinished(true)).unwrap();
    // rust: drop(send);
    // rust: assert!(n.poll(), "the failure toast stays until it slides out");
    // rust: let (title, message) = texts(&n);
    // rust: assert_eq!(
    // rust: title,
    // rust: serde_json::json!({"translate": "download.pack.failed", "with": [1, 2]})
    // rust: );
    // rust: assert_eq!(message, None);
}

pub fn a_finished_batch_without_a_toast_is_dropped() void {
}
    // rust: let (send, receive) = std::sync::mpsc::channel::<download::Progress>();
    // rust: drop(send);
    // rust: assert!(!PackNotifier::new(receive, 1).poll());
}

pub fn sizes_read_as_realms_unit_human_readable() void {
}
        // com.mojang.realmsclient.Unit.humanReadable, run on the 26.3 jar.
    // rust: for (bytes, text) in [
    // rust: (0, "0 B"),
    // rust: (1023, "1023 B"),
    // rust: (1024, "1.0 KB"),
    // rust: (1280, "1.3 KB"),
    // rust: (1535, "1.5 KB"),
    // rust: (10_000, "9.8 KB"),
    // rust: (1_048_575, "1024.0 KB"),
    // rust: (1_048_576, "1.0 MB"),
    // rust: (52_428_800, "50.0 MB"),
    // rust: (262_144_000, "250.0 MB"),
    // rust: (1_073_741_824, "1.0 GB"),
    // rust: ] {
    // rust: assert_eq!(human_readable(bytes), text, "{bytes}");
}
}
}
