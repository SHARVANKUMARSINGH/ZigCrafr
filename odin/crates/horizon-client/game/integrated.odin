//! Transpiled from Horizon Rust crate
package horizon_client_integrated

import "core:fmt"
import "core:mem"
import "core:math"

// The integrated server (`IntegratedServer`): single player's world runs on
// its own "Server thread", as vanilla's does, and the window joins it as a
// player through memory, so a world tick never holds up a frame.
//
// The window asks its server for what only the server knows (Open to LAN,
// the world's options) with [`Integrated::call`], as vanilla's client calls
// into its `IntegratedServer`.
//
// Every single-player world runs this way; LAN guests and dedicated servers
// use the same server code.
// use super::{
    // rust: Dim, Game, Options, PackResources, Resources, UiResources, WorldIcon,
    // rust: execution_role::ExecutionRole,
    // rust: lan::{LanSettings, Owner, SyncPreload, preload_sync_data},
    // rust: world_loading::{WorldLoader, WorldRequest},
}
// use horizon_client::level_loading::{STATUS_RADIUS, Stage};
// use horizon_client::spans::startup;
// use horizon_client::{
    // rust: Result,
    // rust: audio::Audio,
    // rust: lan::{Lan, MAX_PLAYERS, NetConfig, OwnerProfile, hub::HubConfig},
    // rust: settings::Settings,
    // rust: title::WorldOptions,
}
// use horizon_protocol::connection::Pipe;
// use horizon_protocol::{crypto::offline_uuid, text::translatable};
// use std::{
    // rust: net::TcpListener,
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, AtomicI32, AtomicU16, AtomicU32, Ordering},
    // rust: mpsc::{Receiver, RecvTimeoutError, Sender, channel, sync_channel},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::{Duration, Instant},
}

// How long the window waits for the server thread to answer a `call`.
CALL_TIMEOUT :: Duration::from_secs(10)
// The error of a `call` without an answer: the server stopped, or it was
// busy past `CALL_TIMEOUT` (the log says which).
    // rust: pub(super) const NO_ANSWER: &str =
    // rust: "the integrated server stopped or did not answer within 10 s (the game log says which)";

// `LevelLoadProgressTracker.EXPECTED_PLAYER_CHUNKS`: the 7x7 chunks around the spawn.
PLAYER_CHUNKS :: 49

// What the window tells its server thread.
Flags :: struct {
    // `Minecraft.pause`: a single-player pause screen is open.
    paused: AtomicBool,
    stop: AtomicBool,
    failure: Mutex<Maybe(string)>,
    // `IntegratedServer.getPort`: the port it is open to the LAN on, 0
    // while it is not.
    published: AtomicU16,
    smoothed_tick_ms: AtomicU32,
    // `options.renderDistance` and `options.simulationDistance`, which the
    // server follows while it runs (IntegratedServer.tickServer).
    render_distance: AtomicI32,
    simulation_distance: AtomicI32,
    // `options.entityDistanceScaling` (an `f32`'s bits), which
    // `IntegratedServer.getScaledTrackingDistance` reads on every call.
    entity_distance: AtomicU32,
    // The PvP page's legacy combat rules, which the server's hits follow from the next tick.
    legacy_rules: AtomicBool,
    // `MinecraftServer.isCurrentlySaving`: the server is autosaving.
    saving: AtomicBool,
    // Splitscreen players joined through memory (offline uuids): let in although the world is
    // not open to the LAN, and the game no longer pauses while they play.
    split_players: Mutex<[dynamic]u128>,
    // The generators of the levels the server has run, by dimension: what
    // F3's chunk generation entry asks `ServerChunkCache.getGenerator`.
    terrain: Mutex<,
    std: :collections::HashMap<^'static str,
    // rust: >,
    // What the server's `LevelLoadListener` reports, for the window's
    // `LevelLoadingScreen` (`LevelLoadTracker.serverProgress/statusView`).
    load: ^horizon_client::level_loading::ServerLoadView,
    // What the world's upgrade has done (`UpgradeProgress`): the window shows it on
    // `FileFixerProgressScreen` while the file fixers run, and its Cancel stops them.
    upgrade: ^horizon_world::datafix::progress::UpgradeProgress,
    // Where the window's debug entries want the server's lines for (its
    // dimension and feet), and the lines of the last tick there.
    debug_at: Mutex<Option<(Dim,
    debug: Mutex<super::debug_lines::ServerDebug>,
}

// Work the window hands its server thread (`MinecraftServer.execute`).
    // rust: type Task = Box<dyn FnOnce(&mut Game<'_>) + Send>;

// The window's handle on its server thread.
    // rust: pub(super) struct Integrated {
    // rust: flags: Arc<Flags>,
    // rust: thread: Option<JoinHandle<()>>,
    // rust: tasks: Sender<Task>,
    // The world's name (`level.dat`'s `LevelName`), for the pause menu.
    // rust: pub world_name: String,
}
    // rust: impl Integrated {
    // Queue every change, even if the currently published tree still has the requested state:
    // an earlier update may be waiting for a busy server thread.
queue_pregen_option :: proc(self: ^Self, enabled: bool) {
}
    // rust: let _ = self.tasks.send(Box::new(move |g| {
//             use horizon_client::command::vanilla;
    // rust: if vanilla::game_dispatcher().find("pregen").is_some() != enabled {
    // rust: vanilla::set_horizon_commands(enabled);
    // rust: g.resend_commands_filtered();
}
    // rust: }));
}
    // The generator of the server's level in `dimension`, once it has run.
    // rust: pub fn terrain(
    // rust: &self,
    // rust: dimension: &str,
    // rust: ) -> Option<Arc<horizon_client::vanillagen::VanillaTerrain>> {
    // rust: self.flags.terrain.lock().ok()?.get(dimension).cloned()
}
    // The server's load progress and chunk status map.
load_view :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.flags.load
}
    // The world's upgrade while the server opens it.
upgrade :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.flags.upgrade
}
smoothed_tick_ms :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f32::from_bits(self.flags.smoothed_tick_ms.load(Ordering::Relaxed))
}
    // Asks for the debug entries' server lines at `at`, or stops asking.
    // rust: pub(super) fn request_debug(&self, at: Option<(Dim, [i32; 3])>) {
    // rust: if let Ok(mut want) = self.flags.debug_at.lock() {
    // rust: *want = at;
}
}
    // The debug entries' server lines of the last tick.
    // rust: pub(super) fn debug(&self) -> super::debug_lines::ServerDebug {
    // rust: self.flags
    // rust: .debug
    // rust: .lock()
    // rust: .map(|d| d.clone())
    // rust: .unwrap_or_default()
}
    // `MinecraftServer.isCurrentlySaving`.
is_saving :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.flags.saving.load(Ordering::Relaxed)
}
    // `IntegratedServer.tickServer` skips the world while the game is paused.
set_paused :: proc(self: ^Self, paused: bool) {
}
    // rust: let split = !self.flags.split_players.lock().unwrap().is_empty();
    // rust: self.flags.paused.store(paused && !split, Ordering::Relaxed);
}
    // Whether splitscreen players are joined: while any is, the game runs even behind a
    // pause menu, so no window may stop ticking for one (`set_paused`, `pauses_game`).
has_split_players :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.flags.split_players.lock().unwrap().is_empty()
}
    // Splitscreen: `name` left; the game pauses again once every such player has. The owner's
    // permissions it was given go with it (a LAN player could otherwise join under that name).
leave_split :: proc(self: ^Self, name: string) {
}
    // rust: let uuid = horizon_protocol::crypto::offline_uuid(name);
    // rust: self.flags
    // rust: .split_players
    // rust: .lock()
    // rust: .unwrap()
    // rust: .retain(|&u| u != uuid);
    // rust: self.call(move |g| {
    // rust: if let Some(host) = g.lan.as_mut() {
    // rust: host.hub.ops.remove(&uuid);
}
    // rust: });
}
    // Splitscreen: a connection through memory for another player on this machine, who gets
    // the owner's permissions. `None` once the server has stopped.
join_split :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let uuid = horizon_protocol::crypto::offline_uuid(name);
    // rust: self.flags.split_players.lock().unwrap().push(uuid);
    // rust: let pipe = self
    // rust: .call(move |g| {
    // rust: let host = g.lan.as_mut()?;
    // rust: let owner = host.owner.as_ref()?.uuid;
    // rust: let level = host.hub.ops.get(&owner).copied().unwrap_or(0);
    // rust: host.hub.ops.insert(uuid, level);
    // rust: host.hub.lan.connect_local().ok()
    // rust: })
    // rust: .flatten();
    // rust: if pipe.is_none() {
    // rust: self.leave_split(name);
}
    // rust: pipe
}
    // The window's render and simulation distances and its Entity Distance
    // option, for the server to follow.
set_distances :: proc(self: ^Self, render: i32, simulation: i32, entity: f32) {
}
    // rust: self.flags.render_distance.store(render, Ordering::Relaxed);
    // rust: self.flags
    // rust: .simulation_distance
    // rust: .store(simulation, Ordering::Relaxed);
    // rust: self.flags
    // rust: .entity_distance
    // rust: .store(entity.to_bits(), Ordering::Relaxed);
}
    // The window's legacy combat rules option, for the server's hits.
set_legacy_rules :: proc(self: ^Self, on: bool) {
}
    // rust: self.flags.legacy_rules.store(on, Ordering::Relaxed);
}
    // `IntegratedServer.getPort` while `isPublished`.
published :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.flags.published.load(Ordering::Relaxed)).filter(|&p| p != 0)
}
    // `executeBlocking`: run `f` on the server thread between two ticks and
    // wait for its answer; `None` once the server has stopped, or when it has
    // not answered within `CALL_TIMEOUT` (`f` still runs there later). The log
    // tells the two apart.
    // rust: pub fn call<T: Send + 'static>(
    // rust: &self,
    // rust: f: impl FnOnce(&mut Game<'_>) -> T + Send + 'static,
    // rust: ) -> Option<T> {
    // rust: let (tx, rx) = sync_channel(1);
    // rust: self.tasks
    // rust: .send(Box::new(move |g| {
    // rust: let _ = tx.send(f(g));
    // rust: }))
    // rust: .ok()?;
    // rust: match rx.recv_timeout(CALL_TIMEOUT) {
    // rust: Ok(answer) => Some(answer),
    // rust: Err(RecvTimeoutError::Timeout) => {
    // rust: log::warn!(
    // rust: "Horizon: the server thread did not answer within {} s (running: {}, \
    // rust: autosaving: {}, smoothed tick {:.1} ms)",
    // rust: CALL_TIMEOUT.as_secs(),
    // rust: !self.stopped(),
    // rust: self.is_saving(),
    // rust: self.smoothed_tick_ms()
    // rust: );
    // rust: None
}
    // rust: Err(RecvTimeoutError::Disconnected) => None,
}
}
    // `execute`: run `f` on the server thread between two ticks, without
    // waiting for it. False once the server has stopped.
post :: proc(self: ^Self, f: impl FnOnce(^Game<'_>) {
}
    // rust: self.tasks.send(Box::new(f)).is_ok()
}
    // `IntegratedServer.halt(true)`: returns once the world is saved and let go.
stop :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.halt()
}
    // Stop on the server thread; the window polls completion while drawing.
request_stop :: proc(self: ^Self) {
}
    // rust: self.flags.stop.store(true, Ordering::Relaxed);
}
stopped :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.thread
    // rust: .as_ref()
    // rust: .is_none_or(|thread| thread.is_finished())
}
halt :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.request_stop();
    // rust: if let Some(thread) = self.thread.take() {
    // rust: thread
    // rust: .join()
    // rust: .map_err(|_| "the integrated server panicked")?;
}
    // rust: match self
    // rust: .flags
    // rust: .failure
    // rust: .lock()
    // rust: .map_err(|_| "server status poisoned")?
    // rust: .as_ref()
    // rust: {
    // rust: Some(error) => Err(error.clone().into()),
    // rust: None => Ok(()),
}
}
}
    // rust: impl Drop for Integrated {
drop :: proc(self: ^Self) {
}
    // rust: if let Err(error) = self.halt() {
    // rust: log::error!("Horizon: integrated server shutdown: {error}");
}
}
}

// The server thread's side of the window's handle (`Game::serving`).
    // rust: pub(super) struct Serving {
    // rust: flags: Arc<Flags>,
    // rust: tasks: Receiver<Task>,
    // The window's profile.
    // rust: pub(super) owner: u128,
    // Open to LAN or closed from inside a player's command, while the hub
    // is out of its place: applied after the tick.
    // rust: pending: Option<Publish>,
    // Where the load focus is and how far the player's chunks are.
    // rust: load: LoadPhase,
}
// The part of `LevelLoadListener` after `prepareLevels`: `PrepareSpawnTask`'s
// `LOAD_PLAYER_CHUNKS`.
LoadPhase :: struct {
    // `updateFocus`: the spawn chunk, once the stage started.
    focus: Option<(i32,
    // `finish(LOAD_PLAYER_CHUNKS)`.
    done: bool,
}
    // rust: impl Serving {
    // The window reads this as `MinecraftServer.isCurrentlySaving`.
    // rust: pub(super) fn set_saving(&self, saving: bool) {
    // rust: self.flags.saving.store(saving, Ordering::Relaxed);
}
}
Publish :: enum {
    Open(TcpListener, LanSettings),
    Close,
}

// What the server thread hands the window once the world is open: its end
// of the connection and the world's name, or why it failed.
    // rust: type Ready = std::result::Result<(Pipe, String), String>;

// An integrated server loading its world: the window keeps drawing its
// loading screen and joins once the server is ready, as vanilla's client
// does while its server prepares (`Minecraft.doWorldLoad`), instead of
// waiting for it frozen for the whole load.
    // rust: pub(super) struct Starting {
    // rust: pub(super) handle: Integrated,
    // rust: ready: Receiver<Ready>,
    // rust: player: String,
    // The save's folder in `saves/`, for the world icon once joined.
    // rust: folder: String,
    // `Minecraft.doWorldLoad`'s `newWorld`: the loading screen stays 500 ms
    // once the level is ready.
    // rust: new_world: bool,
}

// The world to open and the player who owns it.
Launch :: struct {
    folder: string,
    name: Maybe(string),
    seed: Maybe(i64),
    creative: bool,
    create: Maybe(WorldOptions),
    // The window's profile: the only one let in until the world is open to
    // the LAN, and the world's player.
    owner: u128,
    // Its name, for the LAN's MOTD.
    player: string,
    // The signed-in account's profile, fetched while the world loads.
    owner_profile: Maybe(^OwnerProfile),
}

    // rust: impl Game<'_> {
    // Only the owner window changes its integrated server's command tree. A remote
    // server (or a splitscreen guest) keeps its own choice and permissions.
    // rust: pub(super) fn sync_pregen_option(&self) {
    // rust: let Some(server) = &self.integrated else {
    // rust: return;
}
    // rust: let enabled = self.options.pregen || self.settings.extras.pregen;
        // Check on the server, after earlier updates have run, so a later toggle
        // wins. Do not block the window when an unrelated setting changes.
    // rust: server.queue_pregen_option(enabled);
}

    // `Minecraft.hasSingleplayerServer`: a world of this window's own, run
    // in the frame or on its server thread.
    // rust: pub(super) fn has_singleplayer_server(&self) -> bool {
    // rust: self.remote.is_none() || self.integrated.is_some()
}
    // `IntegratedServer.isPublished`: the world is open to the network.
    // rust: pub(super) fn is_published(&self) -> bool {
    // rust: self.lan.is_some()
    // rust: || self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.published().is_some())
}
    // Splitscreen: players joined through memory play on while one opens a pause menu;
    // the world keeps ticking for them (`set_paused`), so this window must keep ticking too.
    // rust: pub(super) fn has_split_players(&self) -> bool {
    // rust: self.integrated
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.has_split_players())
}
    // `Minecraft.doWorldLoad`: start the server thread on the world; the
    // window joins it through memory once it is ready (`poll_integrated_start`).
    // rust: pub(super) fn open_integrated(
    // rust: &mut self,
    // rust: folder: &str,
    // rust: name: Option<&str>,
    // rust: seed: Option<i64>,
    // rust: creative: bool,
    // rust: create: Option<&WorldOptions>,
    // rust: ) -> Result<()> {
        // The window's mod configs before the server's, as on NeoForge.
    // rust: self.native_configs_client_start();
    // rust: horizon_client::command::vanilla::set_horizon_commands(
    // rust: self.options.pregen || self.settings.extras.pregen,
    // rust: );
    // rust: let auth = horizon_client::auth::current();
    // rust: let player = auth
    // rust: .as_ref()
    // rust: .map_or_else(|| self.options.player_name(), |a| a.name.clone());
    // rust: let new_world = create.is_some();
    // rust: let launch = Launch {
    // rust: folder: folder.to_owned(),
    // rust: name: name.map(str::to_owned),
    // rust: seed,
    // rust: creative,
    // rust: create: create.cloned(),
            // An offline-mode server names its players by their offline profile.
    // rust: owner: offline_uuid(&player),
    // rust: player: player.clone(),
    // rust: owner_profile: auth.as_ref().map(|a| {
    // rust: let id = a.uuid;
    // rust: Arc::new(OwnerProfile::new(move || {
    // rust: horizon_client::skins::fetch_own_properties(id)
    // rust: .into_iter()
    // rust: .map(|(name, value, signature)| {
    // rust: horizon_protocol::packets::login::Property {
    // rust: name,
    // rust: value,
    // rust: signature,
}
    // rust: })
    // rust: .collect()
    // rust: }))
    // rust: }),
}
    // rust: let mut options = self.options.clone();
        // A server without a console: no local player, no window, no control socket.
        // Compatibility for gameplay checks outside startup/world loading.
    // rust: options.dedicated = Some(Vec::new());
    // rust: options.execution_role = ExecutionRole::IntegratedServer;
    // rust: options.control = None;
    // rust: options.benchmark = None;
    // rust: options.frames = None;
    // rust: options.world_frames = None;
    // rust: options.report = None;
    // rust: options.server = None;
    // rust: options.world = None;
    // rust: self.join_world_rest()?;
        // The window plays against the world's own biome table (its chunks
        // carry the packs' ids past the built-in list, `set_registries`
        // names them through it), as the server thread's copy does.
    // rust: let world = std::env::current_dir()?.join("saves").join(folder);
    // rust: let enabled_features = horizon_client::save::Level::read(&world)
    // rust: .map(|l| l.enabled_features)
    // rust: .unwrap_or_default();
    // rust: self.world_biomes = Some(super::world_loading::packed_biomes(
    // rust: &world,
    // rust: &self.options.resources,
    // rust: self.res.biomes(),
    // rust: &enabled_features,
    // rust: ));
    // rust: self.world_biomes_base = self.world_biomes.clone();
    // rust: let (res, pack, settings) = (self.res.clone(), self.pack.clone(), self.settings.clone());
    // rust: let flags = Arc::new(Flags::default());
    // rust: flags
    // rust: .render_distance
    // rust: .store(settings.render_distance, Ordering::Relaxed);
    // rust: flags
    // rust: .simulation_distance
    // rust: .store(settings.simulation_distance, Ordering::Relaxed);
    // rust: flags
    // rust: .entity_distance
    // rust: .store(settings.entity_distance.to_bits(), Ordering::Relaxed);
    // rust: flags
    // rust: .legacy_rules
    // rust: .store(settings.extras.pvp.combat.rules, Ordering::Relaxed);
    // rust: let (ready_tx, ready) = channel();
    // rust: let (tasks, server_tasks) = channel();
    // rust: let server_flags = flags.clone();
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("Server thread".into())
    // rust: .spawn(move || {
                // MinecraftServer.spin's Thread.setPriority(8).
    // rust: horizon_threads::favour_current();
    // rust: let result = serve(
    // rust: &res,
    // rust: pack,
    // rust: options,
    // rust: settings,
    // rust: launch,
    // rust: server_flags.clone(),
    // rust: server_tasks,
    // rust: &ready_tx,
    // rust: );
    // rust: if let Err(e) = result {
    // rust: log::error!("Horizon: integrated server: {e}");
    // rust: *server_flags.failure.lock().unwrap() = Some(e.to_string());
    // rust: let _ = ready_tx.send(Err(e.to_string()));
}
    // rust: })?;
    // rust: let handle = Integrated {
    // rust: flags,
    // rust: thread: Some(thread),
    // rust: tasks,
    // rust: world_name: String::new(),
}
    // rust: self.integrated_starting = Some(Starting {
    // rust: handle,
    // rust: ready,
    // rust: player,
    // rust: folder: folder.to_owned(),
    // rust: new_world,
    // rust: });
        // Harnesses, control scripts and runs without a window go on with the world open.
    // rust: if self.window.is_none() || super::synchronous_startup(&self.options) {
    // rust: while self.integrated_starting.is_some() {
    // rust: self.poll_integrated_start()?;
    // rust: if self.integrated_starting.is_some() {
    // rust: std::thread::sleep(Duration::from_millis(5));
}
}
}
    // rust: Ok(())
}

    // The starting server's answer, polled each frame: joined once it is ready.
    // rust: pub(super) fn poll_integrated_start(&mut self) -> Result<()> {
    // rust: if self.integrated_starting.is_none() {
    // rust: return Ok(());
}
    // rust: self.tick_load_progress();
    // rust: let Some(starting) = &self.integrated_starting else {
    // rust: return Ok(());
}
    // rust: let (pipe, world_name) = match starting.ready.try_recv() {
    // rust: Ok(Ok(ready)) => ready,
    // rust: Err(std::sync::mpsc::TryRecvError::Empty) => return Ok(()),
            // FileFixerProgressScreen's Cancel: the upgrade stopped, back to the title.
    // rust: Ok(Err(_)) if starting.handle.upgrade().is_canceled() => {
    // rust: self.integrated_starting = None;
    // rust: self.perf.cancel_world_opening();
    // rust: return Ok(());
}
    // rust: Ok(Err(e)) => {
    // rust: self.integrated_starting = None;
    // rust: return Err(e.into());
}
    // rust: Err(std::sync::mpsc::TryRecvError::Disconnected) => {
    // rust: self.integrated_starting = None;
    // rust: return Err("the integrated server stopped".into());
}
}
    // rust: let Some(Starting {
    // rust: mut handle,
    // rust: player,
    // rust: folder,
    // rust: new_world,
    // rust: ..
    // rust: }) = self.integrated_starting.take()
    // rust: else {
    // rust: return Ok(());
}
    // rust: handle.world_name = world_name;
    // rust: self.server_packs_world_pack(&folder);
    // rust: self.connect_local(pipe, &player)?;
    // rust: if let Some(r) = self.remote.as_mut() {
            // `new LevelLoadTracker(newWorld ? 500L : 0L)`.
    // rust: r.level_load = horizon_client::level_loading::LevelLoadTracker::new(if new_world {
    // rust: horizon_client::level_loading::LEVEL_LOAD_CLOSE_DELAY_MS
    // rust: } else {
    // rust: 0
    // rust: });
}
        // IntegratedServer.getWorldScreenshotFile: the client grabs the frame
        // the Select World list shows, and needs the save folder for it.
    // rust: self.world_icon = Some(WorldIcon {
    // rust: path: std::env::current_dir()?
    // rust: .join("saves")
    // rust: .join(&folder)
    // rust: .join("icon.png"),
    // rust: last_attempt: None,
    // rust: });
    // rust: self.integrated = Some(handle);
    // rust: Ok(())
}

    // `PrepareSpawnTask`'s `LOAD_PLAYER_CHUNKS`, reported to the window's
    // loading screen: the focus moves to the spawn chunk when the stage
    // starts, the 7x7 chunks around it count as they are ready, and the
    // status map around the focus follows (`ChunkLoadStatusView.get`).
    // rust: pub(super) fn publish_load_view(&mut self) {
    // rust: let Some(serving) = self.serving.as_mut() else {
    // rust: return;
}
    // rust: if serving.load.done {
    // rust: return;
}
    // rust: let view = serving.flags.load.clone();
    // rust: let focus = match serving.load.focus {
    // rust: Some(focus) => focus,
    // rust: None => {
    // rust: let Some(spawn) = self.spawn else { return };
    // rust: let focus = ((spawn.x.floor() as i32) >> 4, (spawn.z.floor() as i32) >> 4);
    // rust: view.start(Stage::LoadPlayerChunks, PLAYER_CHUNKS);
    // rust: serving.load.focus = Some(focus);
    // rust: focus
}
}
    // rust: let ready = (-3..=3)
    // rust: .flat_map(|dz| (-3..=3).map(move |dx| (focus.0 + dx, focus.1 + dz)))
    // rust: .filter(|&(x, z)| self.streaming.is_lit(x, z))
    // rust: .count();
    // rust: view.update(Stage::LoadPlayerChunks, ready, PLAYER_CHUNKS);
    // rust: let diameter = STATUS_RADIUS * 2 + 1;
    // rust: view.set_status(
    // rust: (0..diameter)
    // rust: .flat_map(|x| (0..diameter).map(move |z| (x, z)))
    // rust: .map(|(x, z)| {
    // rust: self.streaming.latest_status(
    // rust: &self.world,
    // rust: focus.0 + x - STATUS_RADIUS,
    // rust: focus.1 + z - STATUS_RADIUS,
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: if ready == PLAYER_CHUNKS {
    // rust: view.finish(Stage::LoadPlayerChunks);
    // rust: if let Some(serving) = self.serving.as_mut() {
    // rust: serving.load.done = true;
}
}
}

    // `LevelLoadingScreen.tick`'s easing of the server's progress, every 50 ms
    // of wall time (the starting server has no client tick yet).
    // rust: pub(super) fn tick_load_progress(&mut self) {
    // rust: let view = match (&self.integrated_starting, &self.integrated) {
    // rust: (Some(s), _) => s.handle.load_view().clone(),
    // rust: (None, Some(i)) => i.load_view().clone(),
    // rust: _ => return,
}
    // rust: let now = Instant::now();
    // rust: let at = self.loading_progress_at.get_or_insert(now);
    // rust: let steps = (now.duration_since(*at).as_millis() / 50).min(20) as u32;
    // rust: *at += Duration::from_millis(u64::from(steps) * 50);
    // rust: if now.duration_since(*at) > Duration::from_secs(1) {
    // rust: *at = now;
}
    // rust: for _ in 0..steps {
    // rust: self.loading_progress = horizon_client::level_loading::smooth(
    // rust: self.loading_progress,
    // rust: view.server_progress(),
    // rust: );
}
}

    // The server thread's loop (`MinecraftServer.runServer`): 20 ticks a
    // second, the world held while the window is paused.
    // rust: fn run_integrated(
    // rust: &mut self,
    // rust: launch: Launch,
    // rust: flags: Arc<Flags>,
    // rust: tasks: Receiver<Task>,
    // rust: ready: &Sender<Ready>,
    // rust: opening: Opening,
    // rust: ) -> Result<()> {
    // rust: let result = self.run_integrated_inner(launch, flags, tasks, ready, opening);
    // rust: if let Err(error) = &result {
    // rust: self.native_players_leaving();
    // rust: self.native_lifecycle_close_failed(&error.to_string());
}
    // rust: result
}

    // rust: fn run_integrated_inner(
    // rust: &mut self,
    // rust: launch: Launch,
    // rust: flags: Arc<Flags>,
    // rust: tasks: Receiver<Task>,
    // rust: ready: &Sender<Ready>,
    // rust: opening: Opening,
    // rust: ) -> Result<()> {
        // The open segment runs as one unit (`integrated_open`) so its
        // failures fire `WorldOpenFailed` with the engine's own error text.
    // rust: if let Err(e) = self.integrated_open(&launch, &flags, tasks, ready, opening) {
    // rust: self.native_lifecycle_world_failed(&e.to_string());
    // rust: return Err(e);
}
        // The server thread's `WorldOpenReady` site, before the tick loop.
    // rust: self.native_lifecycle_world_ready();
    // rust: if let (Some(script), Some(output)) = (
    // rust: std::env::var_os("HORIZON_COMMAND_SCRIPT"),
    // rust: std::env::var_os("HORIZON_COMMAND_OUTPUT"),
    // rust: ) {
            // The script owns the clock: connection setup and terrain loading
            // cannot add wall-clock-dependent world ticks to oracle output.
    // rust: let result = self.run_command_harness(script.as_ref(), output.as_ref());
    // rust: let stopped = self.stop_integrated();
    // rust: return result.and(stopped);
}
    // rust: let mut next = Instant::now();
    // rust: let mut was_paused = false;
    // rust: while !flags.stop.load(Ordering::Relaxed) {
    // rust: self.run_tasks();
    // rust: if self.agent.hold_server {
                // Keep servicing control requests so the fixture can release the barrier.
                // Unlike /tick freeze, no player's queued packets are applied here.
    // rust: self.wait_for_next_server_tick(&mut next, true);
    // rust: continue;
}
    // rust: let paused = flags.paused.load(Ordering::Relaxed);
    // rust: if paused && !was_paused {
                // IntegratedServer.tickServer: the tick the game pauses saves
                // everything (saveEverything, without flushing), as an
                // autosave does.
    // rust: log::info!("Saving and pausing game...");
    // rust: self.save_game_with(false)?;
}
    // rust: was_paused = paused;
    // rust: if paused {
                // Only the connections run.
    // rust: self.tick_server_timed(true)?;
    // rust: } else {
    // rust: self.follow_distances(&flags);
    // rust: let started = Instant::now();
    // rust: self.tick_server_timed(false)?;
                // MinecraftServer.tickServer's tick times, for /tick query.
    // rust: self.clock.record(started.elapsed());
    // rust: self.debug_charts.log_tick(started, started.elapsed());
    // rust: flags.smoothed_tick_ms.store(
    // rust: self.debug_charts.smoothed_tick_ms.to_bits(),
    // rust: Ordering::Relaxed,
    // rust: );
    // rust: if let (Some(terrain), Ok(mut terrains)) =
    // rust: (self.end.locator(), flags.terrain.lock())
    // rust: {
    // rust: terrains.insert(self.dim.id(), terrain);
}
}
    // rust: self.apply_publish();
    // rust: self.publish_load_view();
    // rust: self.wait_for_next_server_tick(&mut next, paused);
}
    // rust: self.stop_integrated()
}

    // After the level of `dim` ticked: the window's debug entries' server
    // lines, when they want them from this level.
    // rust: pub(super) fn publish_server_debug(&self, dim: Dim) {
    // rust: let Some(serving) = &self.serving else {
    // rust: return;
}
    // rust: let want = serving.flags.debug_at.lock().ok().and_then(|w| *w);
    // rust: if let Some((at, feet)) = want
    // rust: && at == dim
    // rust: {
    // rust: let lines = self.server_debug_lines(feet);
    // rust: if let Ok(mut debug) = serving.flags.debug.lock() {
    // rust: *debug = lines;
}
}
}

    // The integrated server's world open: `run_integrated`'s segment
    // from `load_world` through `settle_spawn`, whole so its failures are
    // one open failure (`WorldOpenFailed`, the engine's own error text).
    // rust: fn integrated_open(
    // rust: &mut self,
    // rust: launch: &Launch,
    // rust: flags: &Arc<Flags>,
    // rust: tasks: Receiver<Task>,
    // rust: ready: &Sender<Ready>,
    // rust: opening: Opening,
    // rust: ) -> Result<()> {
        // The mods' server configs, read before the server starts.
    // rust: if let Ok(dir) = std::env::current_dir() {
    // rust: self.native_configs_server_start(&dir.join("saves").join(&launch.folder), false);
}
        // MinecraftServer.loadLevel's start: nothing is loaded yet.
    // rust: self.native_server_about_to_start(false);
    // rust: self.native_lifecycle_open_started();
        // `load_world`, with the world `serve` started preparing.
    // rust: startup::time("server.wait_rest", || self.join_world_rest())?;
    // rust: self.perf.world_opening();
    // rust: let open_step = startup::step("server.open_world");
    // rust: self.finish_open_world(opening.world?.finish()?)?;
    // rust: drop(open_step);
    // rust: if let Some(sync) = opening.sync {
    // rust: startup::time("server.sync_adopt", || sync.adopt(&self.pack_files()));
}
    // rust: let saved = Box::new(self.level.clone());
        // IntegratedServer runs the server mods; the window the client mods.
    // rust: self.mods.dev = self.options.dev_mods.clone();
    // rust: startup::time("server.start_mods", || self.start_mods());
        // Math.max(2, options.renderDistance): past vanilla's 32 when the
        // window's render distance is (Horizon's options go to 64).
    // rust: let view_distance = self.settings.render_distance.max(2);
    // rust: let config = HubConfig {
    // rust: allow_flight: true,
    // rust: default_game_mode: self.level.mode(),
            // Only the owner until it is opened to the LAN.
    // rust: guest_commands: false,
    // rust: force_game_mode: false,
    // rust: hardcore: self.level.hardcore,
    // rust: view_distance,
    // rust: simulation_distance: self.settings.simulation_distance.max(2),
    // rust: dimension: self.dim.id().to_owned(),
    // rust: levels: self.level_shapes,
    // rust: seed: self.level.seed,
    // rust: max_players: MAX_PLAYERS,
            // No player of its own: the hub runs without a host.
    // rust: integrated: true,
}
    // rust: let owner = launch.owner;
    // rust: let published = flags.clone();
    // rust: let local_players = flags.clone();
    // rust: let net = NetConfig {
            // No network until it is opened to the LAN; the memory connection
            // is not compressed (`Connection.isMemoryConnection`).
    // rust: listen: false,
    // rust: online: horizon_client::lan::OnlineMode::lan(),
            // Registered local seats share this computer; the vanilla LAN capacity still
            // applies to other connections when the world is published.
    // rust: bypasses_limit: Some(Arc::new(move |uuid| {
    // rust: local_players.split_players.lock().unwrap().contains(&uuid)
    // rust: })),
    // rust: gate: Some(Arc::new(move |address, uuid, _| {
    // rust: refused(
    // rust: uuid == owner,
    // rust: published.published.load(Ordering::Relaxed) != 0,
    // rust: published.split_players.lock().unwrap().contains(&uuid),
    // rust: address == horizon_client::lan::conn::MEMORY_ADDRESS,
    // rust: )
    // rust: .then(|| translatable("multiplayer.disconnect.not_whitelisted", &[]))
    // rust: })),
    // rust: levels: self.level_shapes,
    // rust: owner_profile: launch.owner_profile.clone(),
            // IntegratedServer.initServer: the MOTD names the owner and the world.
    // rust: ..NetConfig::lan(
    // rust: 0,
    // rust: format!("{} - {}", launch.player, self.level.name),
    // rust: MAX_PLAYERS,
    // rust: )
}
    // rust: let settings = LanSettings {
    // rust: port: 0,
    // rust: guest_commands: false,
    // rust: force_game_mode: false,
}
    // rust: startup::time("server.lan_host", || self.lan_host(settings, net, config))?;
    // rust: let commands = self.allow_commands();
    // rust: let pipe = {
    // rust: let host = self
    // rust: .lan
    // rust: .as_mut()
    // rust: .ok_or("the integrated server did not start")?;
            // The owner is an operator when the world allows commands
            // (`IntegratedPlayerList`, `MinecraftServer.getProfilePermissions`).
    // rust: host.hub.ops.insert(owner, if commands { 4 } else { 0 });
    // rust: host.hub.singleplayer_owner = Some(owner);
    // rust: host.owner = Some(Owner {
    // rust: uuid: owner,
    // rust: saved: Some(saved),
    // rust: });
    // rust: host.hub.lan.connect_local()?
}
    // rust: self.serving = Some(Serving {
    // rust: flags: flags.clone(),
    // rust: tasks,
    // rust: owner,
    // rust: pending: None,
    // rust: load: LoadPhase::default(),
    // rust: });
        // MinecraftServer.prepareLevels: no forced chunks to load, so the
        // stage is over at once; the player's chunks come after.
    // rust: let view = &flags.load;
    // rust: view.start(Stage::LoadInitialChunks, 0);
    // rust: view.finish(Stage::LoadInitialChunks);
    // rust: let _ = ready.send(Ok((pipe, self.level.name.clone())));
    // rust: startup::time("server.settle_spawn", || self.settle_spawn())
}

    // `MinecraftServer.stopServer`: the players are saved and sent away,
    // then the world is saved.
stop_integrated :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
        // Abort background terrain generation/decoration on shutdown, matching vanilla behavior.
    // rust: self.streaming.abort_generation();
        // The close request: lifecycle observation stops.
    // rust: self.native_lifecycle.begin_close();
        // MinecraftServer.stopServer's start: everyone is still here.
    // rust: self.native_server_stopping(false);
    // rust: self.native_configs_server_stop();
    // rust: self.native_players_leaving();
        // IntegratedServer.stopServer: teardownPublishedState.
    // rust: if let Some(s) = self.serving.take() {
    // rust: s.flags.published.store(0, Ordering::Relaxed);
}
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: self.flush_native_net(&mut host);
            // PlayerList.removeAll: the owner and every guest leave the game.
    // rust: self.award_leave_game_to_all(&mut host);
    // rust: self.save_leaving_guests(&mut host);
    // rust: let conns: Vec<u32> = host.hub.guests.iter().map(|g| g.conn).collect();
    // rust: for conn in conns {
    // rust: host.hub.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.server_shutdown", &[]),
    // rust: );
}
    // rust: let has_remote_guests = host.hub.guests.iter().any(|g| g.conn != 0);
    // rust: self.lan = Some(host);
    // rust: if has_remote_guests {
    // rust: std::thread::sleep(Duration::from_millis(50));
}
}
        // ServerPlayer.disconnect: nobody is left in a bed.
    // rust: self.free_player_beds()?;
    // rust: self.save_game()?;
    // rust: self.lan_close(false);
    // rust: self.save.flush()?;
        // `WorldCloseFinal` follows a successful final save.
    // rust: self.native_lifecycle_world_closed();
    // rust: self.session_lock = None;
    // rust: Ok(())
}
}

// What the world options screen shows of an integrated server.
    // rust: pub(super) struct ServerOptions {
    // rust: pub default_mode: i32,
    // The owner's own game mode.
    // rust: pub personal_mode: i32,
    // rust: pub cheats: bool,
    // rust: pub difficulty: u8,
    // rust: pub hardcore: bool,
    // rust: pub difficulty_locked: bool,
    // rust: pub port: Option<u16>,
    // rust: pub guest_commands: bool,
    // rust: pub force: bool,
}

// The server thread's side.
    // rust: impl Game<'_> {
    // Whether this game is an integrated server's.
    // rust: pub(super) fn serving(&self) -> bool {
    // rust: self.serving.is_some()
}
    // The window's agent runs a command as single player's console does
    // (`as_console`, as without a server thread): as the world's owner, in
    // the owner's level, at the owner permission level. The feedback goes to
    // the owner's chat and is returned.
    // rust: pub(super) fn owner_console_command(&mut self, command: &str) -> Vec<String> {
    // rust: let Some(owner) = self.serving.as_ref().map(|s| s.owner) else {
    // rust: return Vec::new();
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return Vec::new();
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(g) = host.hub.guests.iter().find(|g| g.uuid == owner && g.placed) {
    // rust: let conn = g.conn;
            // Commands.performCommand runs in the player's level.
    // rust: let (back, theirs) = (self.dim, super::Dim::from_id(&g.dimension));
    // rust: let entered = theirs == back || self.enter_level(Some(&mut host), theirs).is_ok();
    // rust: if entered && let Some(swap) = self.enter_guest(&mut host, conn, back) {
    // rust: let command = command.trim_start_matches('/').to_owned();
                // The hub is back in place while the command runs, as for a
                // guest's own (`run_guest_commands`): selectors see every
                // player (`team join … @a`), and `defaultgamemode` reaches it.
    // rust: self.lan = Some(host);
    // rust: let lines = self.as_console(|g| {
    // rust: g.chat_capture = Some(Vec::new());
                    // A command a native mod registered goes to the mods
                    // first, as the owner's own chat does (the console is
                    // level 4, so every registered usage is allowed).
    // rust: if !g.perform_native_command(conn, 4, command.trim()) {
    // rust: g.run_command(&command);
}
    // rust: g.chat_capture.take().unwrap_or_default()
    // rust: });
    // rust: host = self.lan.take().expect("a command puts the hub back");
    // rust: self.leave_guest(&mut host, swap);
    // rust: host.hub.sync_all_effects();
                // A teleport into another level happens before its feedback is
                // sent, and what the command earned is announced before it too.
    // rust: self.run_level_teleports(&mut host);
    // rust: self.announce_guest_advancements(&mut host);
    // rust: for line in lines {
    // rust: out.push(line.plain());
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &horizon_protocol::packets::play::Clientbound::SystemChat(
    // rust: horizon_protocol::packets::play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(
    // rust: &line.component(),
    // rust: ),
    // rust: overlay: false,
    // rust: },
    // rust: ),
    // rust: );
}
    // rust: self.send_admin_feedback(&mut host, Some(conn));
}
    // rust: if theirs != back
    // rust: && let Err(e) = self.enter_level(Some(&mut host), back)
    // rust: {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
}
    // rust: self.lan = Some(host);
    // rust: out
}

    // Run `f` with the owner's level in place (the server holds one per
    // dimension), then put back the level that was.
    // rust: pub(super) fn in_owner_level<T>(&mut self, f: impl FnOnce(&mut Self) -> T) -> T {
    // rust: let owner = self.serving.as_ref().map(|s| s.owner);
    // rust: let dim = self.lan.as_ref().and_then(|h| {
    // rust: let g = h.hub.guests.iter().find(|g| Some(g.uuid) == owner)?;
    // rust: Some(super::Dim::from_id(&g.dimension))
    // rust: });
    // rust: let back = dim.and_then(|d| self.enter_command_level(d));
    // rust: let out = f(self);
    // rust: if let Some(back) = back {
    // rust: self.enter_command_level(back);
}
    // rust: out
}

    // The window's requests, between two ticks.
run_tasks :: proc(self: ^Self) {
}
    // rust: let tasks: Vec<Task> = match &self.serving {
    // rust: Some(s) => s.tasks.try_iter().collect(),
    // rust: None => return,
}
    // rust: for task in tasks {
    // rust: task(self);
    // rust: self.apply_publish();
}
}
    // `IntegratedServer.getPort` while published.
    // rust: pub(super) fn published_port(&self) -> Option<u16> {
    // rust: let s = self.serving.as_ref()?;
    // rust: Some(s.flags.published.load(Ordering::Relaxed)).filter(|&p| p != 0)
}
    // `IntegratedServer.publishServer`: listen on `settings.port` (0 picks
    // one) and announce the world. The socket is bound at once so a busy
    // port fails here; the hub starts listening once it is at hand.
    // rust: pub(super) fn publish(&mut self, settings: LanSettings) -> std::result::Result<u16, String> {
    // rust: let Some(s) = self.serving.as_mut() else {
    // rust: return Err("not an integrated server".into());
}
    // rust: if s.flags.published.load(Ordering::Relaxed) != 0 {
    // rust: return Err("already published".into());
}
    // rust: let listener = Lan::bind(None, settings.port).map_err(|e| e.to_string())?;
    // rust: let port = listener.local_addr().map_err(|e| e.to_string())?.port();
    // rust: log::info!("Published LAN server on port {port}");
    // rust: s.flags.published.store(port, Ordering::Relaxed);
    // rust: s.pending = Some(Publish::Open(listener, LanSettings { port, ..settings }));
    // rust: self.apply_publish();
    // rust: Ok(port)
}
    // `IntegratedServer.unpublishServer`: stop listening and send every
    // player but the owner away. False when it was not published.
    // rust: pub(super) fn unpublish(&mut self) -> bool {
    // rust: let Some(s) = self.serving.as_mut() else {
    // rust: return false;
}
    // rust: if s.flags.published.swap(0, Ordering::Relaxed) == 0 {
    // rust: return false;
}
    // rust: s.pending = Some(Publish::Close);
    // rust: self.apply_publish();
    // rust: true
}
    // Publish or unpublish for real, once the hub is in its place (a
    // player's `/publish` runs while it is out).
    // IntegratedServer.tickServer: the server follows the window's render
    // and simulation distances when they change (and Horizon's legacy combat rules).
follow_distances :: proc(self: ^Self, flags: ^Flags) {
}
        // IntegratedServer.getScaledTrackingDistance reads the option each time.
    // rust: self.settings.entity_distance =
    // rust: f32::from_bits(flags.entity_distance.load(Ordering::Relaxed));
    // rust: self.settings.extras.pvp.combat.rules = flags.legacy_rules.load(Ordering::Relaxed);
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: let view = flags.render_distance.load(Ordering::Relaxed).max(2);
    // rust: let old = host.hub.config.view_distance;
    // rust: if view != old {
    // rust: log::info!("Changing view distance to {view}, from {old}");
    // rust: host.hub.set_view_distance(view);
    // rust: self.settings.render_distance = view;
}
    // rust: let simulation = flags.simulation_distance.load(Ordering::Relaxed).max(2);
    // rust: let old = host.hub.config.simulation_distance;
    // rust: if simulation != old {
    // rust: log::info!("Changing simulation distance to {simulation}, from {old}");
    // rust: host.hub.set_simulation_distance(simulation);
    // rust: self.settings.simulation_distance = simulation;
}
}

apply_publish :: proc(self: ^Self) {
}
    // rust: if self.lan.is_none() {
    // rust: return;
}
    // rust: let Some(s) = self.serving.as_mut() else {
    // rust: return;
}
    // rust: let (Some(pending), owner) = (s.pending.take(), s.owner) else {
    // rust: return;
}
    // rust: let allow_commands = self.allow_commands();
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: match pending {
    // rust: Publish::Open(listener, settings) => {
    // rust: if let Err(e) = host.hub.lan.listen_on(listener, true) {
    // rust: log::error!("Horizon: Open to LAN: {e}");
}
    // rust: host.settings = settings;
    // rust: host.hub.config.force_game_mode = settings.force_game_mode;
                // IntegratedServer.setGuestCommandAccess, then updatePermissions.
    // rust: host.hub.config.guest_commands = settings.guest_commands && allow_commands;
    // rust: host.hub.resend_commands();
}
    // rust: Publish::Close => {
    // rust: host.hub.lan.stop_listening();
    // rust: log::info!(
    // rust: "Unpublishing integrated server (was on port {})",
    // rust: host.settings.port
    // rust: );
    // rust: let others: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.uuid != owner)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in others {
    // rust: host.hub.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.server_shutdown", &[]),
    // rust: );
}
}
}
}
    // The world options screen's state, read on the server.
    // rust: pub(super) fn server_options(&self) -> ServerOptions {
    // rust: let owner = self.serving.as_ref().map(|s| s.owner);
    // rust: let host = self.lan.as_ref();
    // rust: let personal_mode = host
    // rust: .and_then(|h| h.hub.guests.iter().find(|g| Some(g.uuid) == owner))
    // rust: .map_or(self.level.mode(), |g| g.game_mode);
    // rust: let published = self.published_port();
    // rust: ServerOptions {
    // rust: default_mode: self.level.mode(),
    // rust: personal_mode,
    // rust: cheats: self.allow_commands(),
    // rust: difficulty: self.ui.difficulty,
    // rust: hardcore: self.level.hardcore,
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: port: published,
    // rust: guest_commands: published.is_some() && host.is_some_and(|h| h.settings.guest_commands),
    // rust: force: published.is_none() || host.is_some_and(|h| h.settings.force_game_mode),
}
}
    // `IntegratedServer.setPersonalGameType`: the owner's game mode.
    // rust: pub(super) fn set_owner_mode(&mut self, mode: i32) {
    // rust: let Some(owner) = self.serving.as_ref().map(|s| s.owner) else {
    // rust: return;
}
    // rust: if let Some(host) = self.lan.as_mut()
    // rust: && let Some(conn) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.uuid == owner)
    // rust: .map(|g| g.conn)
    // rust: {
    // rust: host.hub
    // rust: .set_game_mode(conn, mode, &self.world, Some(self.collision));
}
}
    // `IntegratedServer.setWorldAllowCommands`: the owner is an operator
    // while the world allows commands; everyone's level is sent again.
    // rust: pub(super) fn owner_allow_commands(&mut self, allow: bool) {
    // rust: let Some((owner, flags)) = self.serving.as_ref().map(|s| (s.owner, s.flags.clone())) else {
    // rust: return;
}
    // rust: let published = self.published_port().is_some();
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: let level = if allow { 4 } else { 0 };
    // rust: host.hub.ops.insert(owner, level);
            // Splitscreen seats have the owner's permissions (`join_split`): they follow it.
    // rust: for &seat in flags.split_players.lock().unwrap().iter() {
    // rust: host.hub.ops.insert(seat, level);
}
    // rust: if published {
    // rust: host.hub.config.guest_commands = allow && host.settings.guest_commands;
}
    // rust: host.hub.resend_commands();
}
}
}

// The server thread: a game of its own over the shared resources.
    // rust: fn serve(
    // rust: res: &Arc<Resources>,
    // rust: pack: PackResources,
    // rust: options: Options,
    // rust: settings: Settings,
    // rust: launch: Launch,
    // rust: flags: Arc<Flags>,
    // rust: tasks: Receiver<Task>,
    // rust: ready: &Sender<Ready>,
    // rust: ) -> Result<()> {
    // The world prepares, and the registries the server sends are read, on
    // helper threads while this one builds the server's own Game: none of
    // them reads what another makes (`integrated_open` takes them up).
    // rust: let world = WorldRequest::new(
    // rust: &launch.folder,
    // rust: launch.name.as_deref(),
    // rust: launch.seed,
    // rust: launch.creative,
    // rust: launch.create.as_ref(),
    // rust: )
    // rust: .and_then(|request| {
    // rust: WorldLoader::start(
    // rust: request,
    // rust: res.clone(),
    // rust: pack.clone(),
    // rust: options.clone(),
    // rust: settings.clone(),
    // rust: flags.upgrade.clone(),
    // rust: )
    // rust: });
    // rust: let opening = Opening {
    // rust: world,
    // rust: sync: preload_sync_data(&options.resources),
}
    // rust: let mut server = match startup::time("server.game_new", || {
    // rust: server_game(res, pack, options, settings)
    // rust: }) {
    // rust: Ok(server) => server,
    // rust: Err(e) => {
            // The world's session lock is let go before the failure is told.
    // rust: if let Ok(world) = opening.world {
    // rust: drop(world.finish());
}
    // rust: return Err(e);
}
}
    // rust: server.run_integrated(launch, flags, tasks, ready, opening)
}

// What `serve` starts beside the server's own Game.
Opening :: struct {
    world: Result<WorldLoader>,
    sync: Maybe(SyncPreload),
}

// Component oracles supply their own synthetic levels and entity phases.
// They still execute on a server Game, never the client's world.
    // rust: pub(super) enum ComponentHarness {
    // rust: Dispenser(String),
    // rust: Sculk(String),
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn run_component_harness(&self, fixture: ComponentHarness) -> Result<()> {
    // rust: let (res, pack, settings) = (self.res.clone(), self.pack.clone(), self.settings.clone());
    // rust: let mut options = self.options.clone();
    // rust: options.execution_role = ExecutionRole::IntegratedServer;
    // rust: options.dedicated = Some(Vec::new());
    // rust: let result = std::thread::Builder::new()
    // rust: .name("Server thread".into())
    // rust: .spawn(move || {
    // rust: let run = || -> Result<()> {
    // rust: let mut server = server_game(&res, pack, options, settings)?;
    // rust: match fixture {
    // rust: ComponentHarness::Dispenser(spec) => server.dispense_fixture(&spec),
    // rust: ComponentHarness::Sculk(spec) => server.sculk_fixture(&spec),
}
}
    // rust: run().map_err(|e| e.to_string())
    // rust: })?
    // rust: .join()
    // rust: .map_err(|_| "the component harness server panicked")?;
    // rust: result.map_err(Into::into)
}
}

    // rust: fn server_game(
    // rust: res: &Arc<Resources>,
    // rust: pack: PackResources,
    // rust: options: Options,
    // rust: settings: Settings,
    // rust: ) -> Result<Game<'_>> {
    // rust: let gui = UiResources::server(&options.resources)?;
    // rust: let audio = Audio::silent(&options.resources);
    // rust: Game::new(res, pack, gui, options, settings, audio, None)
}

// Who the integrated server turns away: anyone but the owner until it is opened to the LAN.
// The owner and splitscreen seats are let in only through memory: their window never joins over
// the network. A host without a Microsoft account opens the world in offline mode, where a
// player's UUID comes from their name alone, so a LAN or friends player naming themselves after
// the host would otherwise get the host's UUID, kick the host and take their operator rights and
// player data (vanilla always authenticates LAN guests, so there it can't happen).
refused :: proc(owner: bool, published: bool, split_seat: bool, memory: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if owner || split_seat {
    // rust: !memory
    // rust: } else {
    // rust: !published
}
}

    // rust: mod tests {
//     use super::*;

pregen_toggle_back_is_queued_while_server_is_busy :: proc() {
}
    // rust: let (tasks, waiting_server) = channel();
    // rust: let server = Integrated {
    // rust: flags: Arc::new(Flags::default()),
    // rust: thread: None,
    // rust: tasks,
    // rust: world_name: String::new(),
}
        // The receiver deliberately does not run either task between the updates. In particular,
        // the dispatcher can still show the old value when the owner toggles back.
    // rust: server.queue_pregen_option(true);
    // rust: server.queue_pregen_option(false);
    // rust: assert!(
    // rust: waiting_server.try_recv().is_ok(),
    // rust: "enable must reach the server"
    // rust: );
    // rust: assert!(waiting_server.try_recv().is_ok(), "disable must follow it");
    // rust: assert!(waiting_server.try_recv().is_err());
}

the_owner_and_splitscreen_seats_are_let_in_only_through_memory :: proc() {
}
        // (owner, published, seat, memory)
    // rust: assert!(!refused(false, false, true, true), "a local seat joins");
    // rust: assert!(
    // rust: refused(false, true, true, false),
    // rust: "a LAN player under a seat's name"
    // rust: );
    // rust: assert!(refused(false, false, true, false));
    // rust: assert!(
    // rust: !refused(false, true, false, false),
    // rust: "anyone once open to the LAN"
    // rust: );
    // rust: assert!(refused(false, false, false, false), "nobody else before");
    // rust: assert!(!refused(true, false, false, true), "the owner");
    // rust: assert!(
    // rust: !refused(true, true, false, true),
    // rust: "the owner once open to the LAN"
    // rust: );
    // rust: assert!(
    // rust: refused(true, true, false, false),
    // rust: "a LAN player under the owner's offline name"
    // rust: );
    // rust: assert!(refused(true, false, false, false));
}

shutdown_request_does_not_join_a_server_still_saving :: proc() {
}
    // rust: let flags = Arc::new(Flags::default());
    // rust: let (release, wait) = channel();
    // rust: let (tasks, _) = channel();
    // rust: let server = Integrated {
    // rust: flags: flags.clone(),
    // rust: thread: Some(std::thread::spawn(move || wait.recv().unwrap())),
    // rust: tasks,
    // rust: world_name: String::new(),
}
    // rust: server.request_stop();
    // rust: assert!(flags.stop.load(Ordering::Relaxed));
    // rust: assert!(!server.stopped());
    // rust: release.send(()).unwrap();
    // rust: server.stop().unwrap();
}

shutdown_reports_a_failed_server_save :: proc() {
}
    // rust: let flags = Arc::new(Flags::default());
    // rust: let saving = flags.clone();
    // rust: let (tasks, _) = channel();
    // rust: let server = Integrated {
    // rust: flags,
    // rust: thread: Some(std::thread::spawn(move || {
    // rust: *saving.failure.lock().unwrap() = Some("disk write failed".into());
    // rust: })),
    // rust: tasks,
    // rust: world_name: String::new(),
}
    // rust: assert_eq!(server.stop().unwrap_err().to_string(), "disk write failed");
}
}
