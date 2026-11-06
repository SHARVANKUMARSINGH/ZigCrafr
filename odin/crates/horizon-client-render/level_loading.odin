//! Transpiled from Horizon Rust crate
package horizon_client_render_level_loading

import "core:fmt"
import "core:mem"
import "core:math"

// LevelLoadingScreen: "Loading terrain..." over the chunk status map and
// the server's load progress while a world opens or a portal is crossed.
// use crate::{
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::Text,
}

// `Minecraft.doWorldLoad`: `max(5, 3) + ChunkLevel.RADIUS_AROUND_FULL_CHUNK + 1`.
STATUS_RADIUS :: 8
// `LevelLoadProgressTracker.EXPECTED_PLAYER_CHUNKS`: the 7x7 chunks
// `PrepareSpawnTask` waits for around the player.
PLAYER_CHUNKS :: 49
// `LevelLoadProgressTracker.PREPARE_SERVER_WEIGHT`.
PREPARE_WEIGHT :: 10

// `ChunkStatus`, as far as the chunk status map tells them apart.
Status :: enum {
    Empty,
    StructureStarts,
    StructureReferences,
    Biomes,
    Terrain,
    Features,
    InitializeLight,
    Light,
    Spawn,
    Full,
}
    // rust: impl Status {
    // `LevelLoadingScreen.COLORS` (RGB).
color :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Empty => 0x545454,
    // rust: Self::StructureStarts => 0x999999,
    // rust: Self::StructureReferences => 0x5F6191,
    // rust: Self::Biomes => 0x80B252,
    // rust: Self::Terrain => 0x303572,
    // rust: Self::Features => 0x21C600,
    // rust: Self::InitializeLight => 0xCCCCCC,
    // rust: Self::Light => 0xFFE0A0,
    // rust: Self::Spawn => 0xF26060,
    // rust: Self::Full => 0xFFFFFF,
}
}
}

// `LevelLoadingScreen.Reason`.
Reason :: enum {
    NetherPortal,
    EndPortal,
    Other,
}

// `LevelLoadTracker.CLIENT_WAIT_TIMEOUT_MS`.
CLIENT_WAIT_TIMEOUT_MS :: 30_000
// `LevelLoadTracker.LEVEL_LOAD_CLOSE_DELAY_MS`: how long a new world's loading
// screen stays once the level is ready.
LEVEL_LOAD_CLOSE_DELAY_MS :: 500

// `ClientPacketListener.determineLevelLoadingReason`.
reason_for_respawn :: proc(player_died: bool, dimension: string, old_dimension: string) -> R {
    // Ported from Horizon
    return {}
}
NETHER :: "minecraft:the_nether"
END :: "minecraft:the_end"
    // rust: if player_died {
    // rust: Reason::Other
    // rust: } else if dimension == NETHER || old_dimension == NETHER {
    // rust: Reason::NetherPortal
    // rust: } else if dimension == END || old_dimension == END {
    // rust: Reason::EndPortal
    // rust: } else {
    // rust: Reason::Other
}
}

// `LevelLoadTracker.ClientState`, with the times in milliseconds.
ClientState :: enum {
    // `WaitingForServer`: until the loading start game event.
    WaitingForServer { timeout_after: u64 },
    // `WaitingForPlayerChunk`: until the section around the player is shown.
    WaitingForPlayerChunk {,
    player_section_ready: bool,
    timeout_after: u64,
    // rust: },
    // `ClientLevelReady`.
    Ready { ready_at: u64 },
}

// What `WaitingForPlayerChunk.isReady` asks of the player.
PlayerCheck :: struct {
    // `ClientLevel.isOutsideBuildHeight(camera y)`.
    outside_build_height: bool,
    spectator: bool,
    alive: bool,
}

// The client half of `LevelLoadTracker`: what the loading screen waits for
// after a login or a respawn, and the screen it is shown on.
LevelLoadTracker :: struct {
    state: Maybe(ClientState),
    close_delay_ms: u64,
    // `LevelLoadingScreen.reason`.
    reason: Reason,
}
    // rust: impl LevelLoadTracker {
new :: proc(close_delay_ms: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: state: None,
    // rust: close_delay_ms,
    // rust: reason: Reason::Other,
}
}
    // `startClientLoad`, for the screen `reason` (`startWaitingForNewLevel`).
start_client_load :: proc(self: ^Self, now: u64, reason: Reason) {
}
    // rust: self.state = Some(ClientState::WaitingForServer {
    // rust: timeout_after: now + CLIENT_WAIT_TIMEOUT_MS,
    // rust: });
    // rust: self.reason = reason;
}
    // The tracker's work is over and the screen has closed
    // (`ClientPacketListener.tick` drops it once the level is ready).
finish :: proc(self: ^Self) {
}
    // rust: self.state = None;
}
    // A load is under way, so its screen is up.
is_active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.state.is_some()
}
    // `loadingPacketsReceived`: `LEVEL_CHUNKS_LOAD_START` came.
loading_packets_received :: proc(self: ^Self) {
}
    // rust: if let Some(ClientState::WaitingForServer { timeout_after }) = self.state {
    // rust: self.state = Some(ClientState::WaitingForPlayerChunk {
    // rust: player_section_ready: false,
    // rust: timeout_after,
    // rust: });
}
}
    // `getPlayerCompiledSectionCallback` is not null: the renderer is to say
    // when the player's section is shown.
wants_player_section :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.state, Some(ClientState::WaitingForPlayerChunk { .. }))
}
    // The callback: the player's section is compiled and visible.
player_section_ready :: proc(self: ^Self) {
}
    // rust: if let Some(ClientState::WaitingForPlayerChunk {
    // rust: player_section_ready,
    // rust: ..
    // rust: }) = &mut self.state
    // rust: {
    // rust: *player_section_ready = true;
}
}
    // `tickClientLoad`.
tick_client_load :: proc(self: ^Self, now: u64, player: PlayerCheck) {
}
    // rust: if let Some(ClientState::WaitingForPlayerChunk {
    // rust: player_section_ready,
    // rust: timeout_after,
    // rust: }) = self.state
    // rust: {
    // rust: let ready = if now > timeout_after {
    // rust: log::warn!(
    // rust: "Timed out while waiting for the client to load chunks, letting the player into the world anyway"
    // rust: );
    // rust: true
    // rust: } else if !player.outside_build_height && !player.spectator && player.alive {
    // rust: player_section_ready
    // rust: } else {
    // rust: true
}
    // rust: if ready {
    // rust: self.state = Some(ClientState::Ready { ready_at: now });
}
}
}
    // `isLevelReady`.
is_level_ready :: proc(self: ^Self, now: u64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.state, Some(ClientState::Ready { ready_at }) if now >= ready_at + self.close_delay_ms)
}
}

// `LevelLoadListener.Stage`.
Stage :: enum {
    StartServer,
    PrepareGlobalSpawn,
    LoadInitialChunks,
    LoadPlayerChunks,
}

// `LevelLoadProgressTracker` (with `includePlayerChunks`).
ProgressTracker :: struct {
    total_weight: uint,
    finalized_weight: uint,
    segment_weight: uint,
    segment_fraction: f32,
    progress: f32,
}
    // rust: impl ProgressTracker {
tracks :: proc(stage: Stage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(stage, Stage::LoadInitialChunks | Stage::LoadPlayerChunks)
}
begin_segment :: proc(self: ^Self, weight: uint) {
}
    // rust: self.segment_weight = weight;
    // rust: self.segment_fraction = 0.0;
    // rust: self.update_progress();
}
finish_segment :: proc(self: ^Self) {
}
    // rust: self.finalized_weight += self.segment_weight;
    // rust: self.segment_weight = 0;
    // rust: self.update_progress();
}
update_progress :: proc(self: ^Self) {
}
    // rust: self.progress = if self.total_weight == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: (self.finalized_weight as f32 + self.segment_fraction * self.segment_weight as f32)
    // rust: / self.total_weight as f32
}
}
start :: proc(self: ^Self, stage: Stage, total_chunks: uint) {
}
    // rust: match stage {
    // rust: Stage::LoadInitialChunks => {
    // rust: self.total_weight = PREPARE_WEIGHT + total_chunks + PLAYER_CHUNKS;
    // rust: self.begin_segment(PREPARE_WEIGHT);
    // rust: self.finish_segment();
    // rust: self.begin_segment(total_chunks);
}
    // rust: Stage::LoadPlayerChunks => self.begin_segment(PLAYER_CHUNKS),
    // rust: _ => {}
}
}
update :: proc(self: ^Self, stage: Stage, current: uint, total: uint) {
}
    // rust: if Self::tracks(stage) {
    // rust: self.segment_fraction = if total == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: current as f32 / total as f32
}
    // rust: self.update_progress();
}
}
finish :: proc(self: ^Self, stage: Stage) {
}
    // rust: if Self::tracks(stage) {
    // rust: self.finish_segment();
}
}
}

// The integrated server's side of `LevelLoadTracker`: what its
// `LevelLoadListener` reported (`serverProgress`, `hasProgress`) and the
// chunk status map around the load focus (`ChunkLoadStatusView`), which the
// server thread writes and the window's loading screen reads.
ServerLoadView :: struct {
    tracker: std::sync::Mutex<ProgressTracker>,
    // `serverStage != null`.
    has_progress: std::sync::atomic::AtomicBool,
    // `statusView.get(x, z)` for x and z in `0..=2 * STATUS_RADIUS`.
    cells: std::sync::Mutex<[dynamic]Maybe(Status)>,
}
    // rust: impl ServerLoadView {
    // `LevelLoadListener.start`.
start :: proc(self: ^Self, stage: Stage, total_chunks: uint) {
}
    // rust: Self::lock(&self.tracker).start(stage, total_chunks);
        // `serverStage = stage`, whatever the stage.
    // rust: self.has_progress
    // rust: .store(true, std::sync::atomic::Ordering::Relaxed);
}
    // `LevelLoadListener.update`.
update :: proc(self: ^Self, stage: Stage, current: uint, total: uint) {
}
    // rust: Self::lock(&self.tracker).update(stage, current, total);
}
    // `LevelLoadListener.finish`.
finish :: proc(self: ^Self, stage: Stage) {
}
    // rust: Self::lock(&self.tracker).finish(stage);
}
    // `LevelLoadTracker.hasProgress`.
has_progress :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_progress.load(std::sync::atomic::Ordering::Relaxed)
}
    // `LevelLoadTracker.serverProgress`.
server_progress :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: Self::lock(&self.tracker).progress
}
    // The map `ChunkLoadStatusView.get` reads, replaced as a whole.
set_status :: proc(self: ^Self, cells: [dynamic]Maybe(Status)) {
}
    // rust: *Self::lock(&self.cells) = cells;
}
    // `ChunkLoadStatusView.get`.
status :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let diameter = (STATUS_RADIUS * 2 + 1) as usize;
    // rust: let (x, z) = (usize::try_from(x).ok()?, usize::try_from(z).ok()?);
    // rust: if x >= diameter || z >= diameter {
    // rust: return None;
}
    // rust: Self::lock(&self.cells)
    // rust: .get(x * diameter + z)
    // rust: .copied()
    // rust: .flatten()
}
    // rust: fn lock<T>(m: &std::sync::Mutex<T>) -> std::sync::MutexGuard<'_, T> {
    // rust: m.lock().unwrap_or_else(|e| e.into_inner())
}
}

// `LevelLoadProgressTracker.get` once the server is prepared, with `ready`
// of the player's 49 chunks loaded (no forced chunks to load first).
progress :: proc(ready: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let total = PREPARE_WEIGHT + PLAYER_CHUNKS;
    // rust: (PREPARE_WEIGHT + ready.min(PLAYER_CHUNKS)) as f32 / total as f32
}

// `LevelLoadingScreen.tick`: the bar eases a fifth of the way each tick.
smooth :: proc(smoothed: f32, progress: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: smoothed + (progress - smoothed) * 0.2
}

// `ARGB.opaque` as the batch's RGBA.
    // rust: pub const fn opaque(rgb: u32) -> u32 {
    // rust: 0xFF00_0000 | (rgb & 0xFF) << 16 | (rgb & 0xFF00) | (rgb >> 16 & 0xFF)
}

// `LoadingOverlay.LOGO_BACKGROUND_COLOR` (RGB: 239, 50, 61).
LOGO_BACKGROUND_COLOR :: opaque(0xEF323D)
// `LoadingOverlay.LOGO_BACKGROUND_COLOR_DARK` (black).
LOGO_BACKGROUND_COLOR_DARK :: opaque(0x000000)

// `LoadingOverlay.BRAND_BACKGROUND`: black when `darkMojangStudiosBackground` is set,
// Mojang red otherwise.
brand_background :: proc(dark: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if dark {
    // rust: LOGO_BACKGROUND_COLOR_DARK
    // rust: } else {
    // rust: LOGO_BACKGROUND_COLOR
}
}

// `LevelLoadingScreen.extractRenderState` over its background: the text,
// the progress bar and the chunk map, `status(x, z)` for x and z in
// `0..=2 * STATUS_RADIUS` from the map's north-west corner.
    // rust: pub fn draw(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: status: Option<&dyn Fn(i32, i32) -> Option<Status>>,
    // rust: progress: Option<f32>,
    // rust: ) {
    // rust: let (x_center, y_center) = ((batch.width as i32) / 2, (batch.height as i32) / 2);
    // rust: let text_top = match status {
    // rust: Some(status) => {
            // extractChunksForRendering(size 2, margin 0).
    // rust: let diameter = STATUS_RADIUS * 2 + 1;
    // rust: let start = (x_center - diameter, y_center - diameter);
    // rust: for x in 0..diameter {
    // rust: for z in 0..diameter {
    // rust: let color = opaque(status(x, z).map_or(0, Status::color));
    // rust: let (cx, cy) = (start.0 + x * 2, start.1 + z * 2);
    // rust: batch.fill(atlas, cx as f32, cy as f32, 2.0, 2.0, color);
}
}
    // rust: y_center - STATUS_RADIUS * 2 - 9 * 3
}
    // rust: None => y_center - 50,
}
    // rust: let text = Text::translate("multiplayer.downloadingTerrain", &[]);
    // rust: let tw = atlas.font.width_text(&text) as i32;
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &text,
    // rust: (x_center - tw / 2) as f32,
    // rust: text_top as f32,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: if let Some(progress) = progress {
        // drawProgressBar(xCenter - 100, textTop + 12, 200, 2).
    // rust: let (left, top) = ((x_center - 100) as f32, (text_top + 9 + 3) as f32);
    // rust: batch.fill(atlas, left, top, 200.0, 2.0, opaque(0));
    // rust: let done = (progress * 200.0).round();
    // rust: batch.fill(atlas, left, top, done, 2.0, opaque(0x00FF00));
}
}

// `LoadingOverlay.MOJANG_STUDIOS_LOGO_LOCATION`, from the player's own resources.
MOJANG_STUDIOS_LOGO :: "gui/title/mojangstudios"

// `LoadingOverlay.extractRenderState`'s logo on a GUI `w` x `h`: the left
// half's corner, then each half's width and height.
logo_layout :: proc(w: f32, h: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (w, h) = (f64::from(w), f64::from(h));
    // rust: let (content_x, logo_y) = ((w * 0.5) as i32, (h * 0.5) as i32);
    // rust: let logo_height = (w * 0.75).min(h) * 0.25;
    // rust: let half_height = (logo_height * 0.5) as i32;
    // rust: let half_width = (logo_height * 4.0 * 0.5) as i32;
    // rust: (
    // rust: content_x - half_width,
    // rust: logo_y - half_height,
    // rust: half_width,
    // rust: logo_height as i32,
    // rust: )
}

// `GuiGraphicsExtractor.fill(x0, y0, x1, y1, color)`: the corners in either order.
fill_corners :: proc(batch: ^HudBatch, atlas: ^HudAtlas, y1]: [i32; 4], color: u32) {
}
    // rust: let (left, right) = (x0.min(x1), x0.max(x1));
    // rust: let (top, bottom) = (y0.min(y1), y0.max(y1));
    // rust: let (w, h) = ((right - left) as f32, (bottom - top) as f32);
    // rust: batch.fill(atlas, left as f32, top as f32, w, h, color);
}

// `LoadingOverlay.extractRenderState`: fills the frame with `BRAND_BACKGROUND`
// (Mojang red, or black when `darkMojangStudiosBackground` is set), draws the
// Mojang Studios logo as its two halves side by side, and the progress bar
// at 83.25% of the height (`extractProgressBar`, unfaded), with the stage's
// line above it. The logo's `MOJANG_LOGO` pipeline adds it (`SRC_ALPHA, ONE`):
// its texels are white, which alpha blending matches but for the red channel
// of the logo's soft edges, a 16/255 difference at most.
    // rust: pub fn draw_loading_overlay(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: line: &str,
    // rust: progress: f32,
    // rust: dark: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: batch.fill(atlas, 0.0, 0.0, w, h, brand_background(dark));
    // rust: let (x, y, half_width, logo_height) = logo_layout(w, h);
    // rust: if let Some(r) = atlas.sprites.get(MOJANG_STUDIOS_LOGO).copied() {
        // blit(.., u, v, width, height, 120, 60, 120, 120): the left half
        // samples the texture's top half from u = -0.0625, the right half its
        // bottom half from u = 0.0625 (clamped, as the logo's sampler is).
    // rust: let at = |u: f32, v: f32| {
    // rust: let (u, v) = ((u / 120.0).clamp(0.0, 1.0), v / 120.0);
    // rust: (r.u0 + (r.u1 - r.u0) * u, r.v0 + (r.v1 - r.v0) * v)
}
    // rust: for (i, (u, v)) in [(-0.0625, 0.0), (0.0625, 60.0)].into_iter().enumerate() {
    // rust: let (u0, v0) = at(u, v);
    // rust: let (u1, v1) = at(u + 120.0, v + 60.0);
    // rust: let half = crate::hud::Rect {
    // rust: u0,
    // rust: v0,
    // rust: u1,
    // rust: v1,
    // rust: ..r
}
    // rust: let left = x + i as i32 * half_width;
    // rust: let (lw, lh) = (half_width as f32, logo_height as f32);
    // rust: batch.rect_uv(left as f32, y as f32, lw, lh, half, u32::MAX);
}
}
    // rust: let bar_y = (f64::from(h) * 0.8325) as i32;
    // rust: let x_center = (w as i32) / 2;
    // rust: let [x0, y0, x1, y1] = [
    // rust: x_center - half_width,
    // rust: bar_y - 5,
    // rust: x_center + half_width,
    // rust: bar_y + 5,
    // rust: ];
    // rust: let filled = (((x1 - x0) - 2) as f32 * progress.clamp(0.0, 1.0)).ceil() as i32;
    // rust: let white = u32::MAX;
    // rust: fill_corners(batch, atlas, [x0 + 2, y0 + 2, x0 + filled, y1 - 2], white);
    // rust: fill_corners(batch, atlas, [x0 + 1, y0, x1 - 1, y0 + 1], white);
    // rust: fill_corners(batch, atlas, [x0 + 1, y1, x1 - 1, y1 - 1], white);
    // rust: fill_corners(batch, atlas, [x0, y0, x0 + 1, y1], white);
    // rust: fill_corners(batch, atlas, [x1, y0, x1 - 1, y1], white);
    // rust: let text = Text::literal(line);
    // rust: let tw = atlas.font.width_text(&text) as i32;
    // rust: let text_top = (y0 - 9 - 3) as f32;
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &text,
    // rust: (x_center - tw / 2) as f32,
    // rust: text_top,
    // rust: white,
    // rust: true,
    // rust: );
}

// The startup loading screen: the stage's line and a progress bar, centred
// like `LevelLoadingScreen`'s text and bar.
draw_progress :: proc(batch: ^HudBatch, atlas: ^HudAtlas, line: string, progress: f32) {
}
    // rust: let (x_center, y_center) = ((batch.width as i32) / 2, (batch.height as i32) / 2);
    // rust: let text_top = y_center - 50;
    // rust: let text = Text::literal(line);
    // rust: let tw = atlas.font.width_text(&text) as i32;
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &text,
    // rust: (x_center - tw / 2) as f32,
    // rust: text_top as f32,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let (left, top) = ((x_center - 100) as f32, (text_top + 9 + 3) as f32);
    // rust: batch.fill(atlas, left, top, 200.0, 2.0, opaque(0));
    // rust: let done = (progress.clamp(0.0, 1.0) * 200.0).round();
    // rust: batch.fill(atlas, left, top, done, 2.0, opaque(0x00FF00));
}

// `ConnectScreen`'s Cancel button corner on a GUI `w` x `h`:
// (width / 2 - 100, height / 4 + 120 + 12), 200 x 20.
connect_cancel :: proc(w: f32, h: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: ((w / 2.0).trunc() - 100.0, (h / 4.0).trunc() + 132.0)
}

// `ConnectScreen.extractRenderState` over the menu background: the status
// centred at (width / 2, height / 2 - 50) and, while the connection can
// still be cancelled, Cancel.
    // rust: pub fn draw_connecting(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: status: &Text,
    // rust: cursor: (f32, f32),
    // rust: cancel: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let tw = atlas.font.width_text(status);
    // rust: let (x, y) = (((w - tw) / 2.0).trunc(), (h / 2.0).trunc() - 50.0);
    // rust: batch.text_styled(atlas, status, x, y, u32::MAX, true);
    // rust: if cancel {
    // rust: let (x, y) = connect_cancel(w, h);
    // rust: let hover = crate::ui::hovered(cursor, x, y, 200.0, 20.0);
    // rust: let label = Text::translate("gui.cancel", &[]);
    // rust: crate::ui::button(batch, atlas, x, y, 200.0, 20.0, &label, true, hover);
}
}

// `FileFixerProgressScreen`'s Cancel button corner on a GUI `w` x `h`:
// ((width - 200) / 2, height / 2 + 100), 200 x 20.
file_fixer_cancel :: proc(w: f32, h: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (((w as i32 - 200) / 2) as f32, (h as i32 / 2 + 100) as f32)
}

// `GuiGraphicsExtractor.centeredText` with the screen's grey (`-6250336`) or white.
    // rust: fn centered_line(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: x_center: i32,
    // rust: y: i32,
    // rust: color: u32,
    // rust: ) {
    // rust: let tw = atlas.font.width_text(text) as i32;
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: text,
    // rust: (x_center - tw / 2) as f32,
    // rust: y as f32,
    // rust: color,
    // rust: true,
    // rust: );
}

// `FileFixerProgressScreen.extractProgressBar`.
file_fixer_bar :: proc(batch: ^HudBatch, atlas: ^HudAtlas, x_center: i32, y: i32, progress: f32) {
}
    // rust: let left = x_center - 100;
    // rust: batch.fill(atlas, left as f32, y as f32, 200.0, 2.0, opaque(0));
    // rust: batch.fill(
    // rust: atlas,
    // rust: left as f32,
    // rust: y as f32,
    // rust: (progress * 200.0).round(),
    // rust: 2.0,
    // rust: opaque(0x00FF00),
    // rust: );
}

// `FileFixerProgressScreen.extractRenderState` (with `extractProgress`,
// `extractProgressBar`, `extractFileStats`, `extractFileFixerCount`,
// `extractTypeText`, `extractTypeProgress` and `extractScanning`) over the menu background: the
// title, then either the scanning line or the running fixer's bar, the
// totals, the stage, the type's label and its bar and percentage; and
// Cancel, inactive once pressed.
    // rust: pub fn draw_file_fixer(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: progress: &horizon_world::datafix::progress::UpgradeProgress,
    // rust: cursor: (f32, f32),
    // rust: ) {
GREY :: 0xFFA0_A0A0
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let (x_center, y_center) = ((w as i32) / 2, (h as i32) / 2);
    // rust: let text_top = y_center - 50;
    // rust: centered_line(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::translate("upgradeWorld.title", &[]),
    // rust: x_center,
    // rust: text_top,
    // rust: u32::MAX,
    // rust: );
    // rust: let total = progress.total_file_fix_stats();
    // rust: if total.total_operations() > 0 {
    // rust: let of_type = progress.type_file_fix_stats();
    // rust: let running = progress.running_file_fixer_stats();
    // rust: let mut y = text_top + 9 + 3;
    // rust: file_fixer_bar(batch, atlas, x_center, y, running.progress());
    // rust: y += 7;
        // extractFileStats
    // rust: let converted = Text::tr(
    // rust: "upgradeWorld.info.converted",
    // rust: &[&total.finished_operations()],
    // rust: );
    // rust: centered_line(batch, atlas, &converted, x_center, y, GREY);
    // rust: let sum = Text::tr("upgradeWorld.info.total", &[&total.total_operations()]);
    // rust: centered_line(batch, atlas, &sum, x_center, y + 9 + 3, GREY);
    // rust: y += 9 * 2 + 6;
        // extractFileFixerCount
    // rust: let stage = Text::tr(
    // rust: "upgradeWorld.info.file_fix_stage",
    // rust: &[&running.finished_operations(), &running.total_operations()],
    // rust: );
    // rust: centered_line(batch, atlas, &stage, x_center, y, GREY);
    // rust: y += 9 + 30 - 5;
        // extractTypeText
    // rust: if let Some(ty) = progress.upgrade_type() {
    // rust: let label = Text::translate(&ty.label_key(), &[]);
    // rust: centered_line(batch, atlas, &label, x_center, y, GREY);
}
    // rust: y += 9 + 3;
    // rust: file_fixer_bar(batch, atlas, x_center, y, of_type.progress());
    // rust: y += 7;
        // extractTypeProgress: Mth.floor(progress * 100)
    // rust: let percent = (of_type.progress() * 100.0).floor() as i32;
    // rust: let text = Text::tr("upgradeWorld.progress.percentage", &[&percent]);
    // rust: centered_line(batch, atlas, &text, x_center, y, GREY);
    // rust: } else {
        // extractScanning
    // rust: let scanning = Text::translate("upgradeWorld.info.scanning", &[]);
    // rust: centered_line(batch, atlas, &scanning, x_center, text_top + 9 + 3, GREY);
}
    // rust: let (x, y) = file_fixer_cancel(w, h);
    // rust: let active = !progress.is_canceled();
    // rust: let hover = crate::ui::hovered(cursor, x, y, 200.0, 20.0);
    // rust: let label = Text::translate("gui.cancel", &[]);
    // rust: crate::ui::button(batch, atlas, x, y, 200.0, 20.0, &label, active, hover);
}

    // rust: mod tests {
//     use super::*;

the_mojang_logo_is_a_quarter_of_the_shorter_side_and_four_times_as_wide :: proc() {
}
        // 320x240: min(240, 240) / 4 = 60 high, two halves of 120.
    // rust: assert_eq!(logo_layout(320.0, 240.0), (40, 90, 120, 60));
        // A tall frame sizes the logo by three quarters of its width.
    // rust: assert_eq!(logo_layout(400.0, 500.0), (50, 213, 150, 75));
}

progress_weighs_the_prepared_server_and_the_player_chunks :: proc() {
}
    // rust: assert_eq!(progress(0), 10.0 / 59.0);
    // rust: assert_eq!(progress(49), 1.0);
    // rust: assert_eq!(progress(100), 1.0);
    // rust: let eased = smooth(0.0, 1.0);
    // rust: assert_eq!(eased, 0.2);
    // rust: assert!((smooth(eased, 1.0) - 0.36).abs() < 1e-6);
}

brand_background_matches_dark_mojang_studios_setting :: proc() {
}
    // rust: assert_eq!(brand_background(true), LOGO_BACKGROUND_COLOR_DARK);
    // rust: assert_eq!(brand_background(false), LOGO_BACKGROUND_COLOR);
    // rust: assert_eq!(LOGO_BACKGROUND_COLOR_DARK, 0xFF00_0000);
    // rust: assert_eq!(LOGO_BACKGROUND_COLOR, crate::hud::rgba(239, 50, 61, 255));
}

file_fixer_cancel_sits_below_the_centre :: proc() {
}
    // rust: assert_eq!(file_fixer_cancel(427.0, 240.0), (113.0, 220.0));
    // rust: assert_eq!(file_fixer_cancel(426.0, 241.0), (113.0, 220.0));
}

colours_are_opaque_rgba :: proc() {
}
    // rust: assert_eq!(opaque(Status::Full.color()), u32::MAX);
    // rust: assert_eq!(opaque(0), 0xFF00_0000);
    // rust: assert_eq!(opaque(0x00FF00), crate::hud::rgba(0, 255, 0, 255));
    // rust: assert_eq!(
    // rust: opaque(Status::Biomes.color()),
    // rust: crate::hud::rgba(0x80, 0xB2, 0x52, 255)
    // rust: );
}
}

    // rust: mod tracker_tests {
//     use super::*;

    // rust: const ALIVE: PlayerCheck = PlayerCheck {
    // rust: outside_build_height: false,
    // rust: spectator: false,
    // rust: alive: true,
}

server_progress_follows_the_listener_like_the_progress_tracker :: proc() {
}
    // rust: let view = ServerLoadView::default();
    // rust: assert!(!view.has_progress() && view.server_progress() == 0.0);
        // A stage the tracker ignores still counts as progress being made.
    // rust: view.start(Stage::StartServer, 0);
    // rust: assert!(view.has_progress() && view.server_progress() == 0.0);
        // prepareLevels with no forced chunks: the 10 of preparing, of 59.
    // rust: view.start(Stage::LoadInitialChunks, 0);
    // rust: view.finish(Stage::LoadInitialChunks);
    // rust: assert_eq!(view.server_progress(), 10.0 / 59.0);
        // PrepareSpawnTask: the 49 player chunks.
    // rust: view.start(Stage::LoadPlayerChunks, 49);
    // rust: view.update(Stage::LoadPlayerChunks, 20, 49);
    // rust: assert_eq!(view.server_progress(), (10.0 + 20.0) / 59.0);
    // rust: assert_eq!(view.server_progress(), progress(20));
    // rust: view.update(Stage::LoadPlayerChunks, 49, 49);
    // rust: view.finish(Stage::LoadPlayerChunks);
    // rust: assert_eq!(view.server_progress(), 1.0);
}

the_status_map_is_read_from_the_north_west_corner :: proc() {
}
    // rust: let view = ServerLoadView::default();
    // rust: assert_eq!(view.status(0, 0), None);
    // rust: let diameter = (STATUS_RADIUS * 2 + 1) as usize;
    // rust: let mut cells = vec![None; diameter * diameter];
    // rust: cells[3 * diameter + 5] = Some(Status::Full);
    // rust: view.set_status(cells);
    // rust: assert_eq!(view.status(3, 5), Some(Status::Full));
    // rust: assert_eq!(view.status(5, 3), None);
    // rust: assert_eq!(view.status(-1, 0), None);
    // rust: assert_eq!(view.status(diameter as i32, 0), None);
}

the_load_waits_for_the_server_then_the_players_section :: proc() {
}
    // rust: let mut tracker = LevelLoadTracker::new(0);
    // rust: assert!(!tracker.is_active());
    // rust: tracker.start_client_load(1_000, Reason::NetherPortal);
    // rust: assert!(tracker.is_active() && tracker.reason == Reason::NetherPortal);
        // Nothing is asked of the renderer before the start event, and a
        // section shown early counts for nothing.
    // rust: assert!(!tracker.wants_player_section());
    // rust: tracker.player_section_ready();
    // rust: tracker.tick_client_load(1_050, ALIVE);
    // rust: assert!(!tracker.is_level_ready(1_050));
    // rust: tracker.loading_packets_received();
    // rust: assert!(tracker.wants_player_section());
    // rust: tracker.tick_client_load(1_100, ALIVE);
    // rust: assert!(!tracker.is_level_ready(1_100));
    // rust: tracker.player_section_ready();
    // rust: tracker.tick_client_load(1_150, ALIVE);
    // rust: assert!(tracker.is_level_ready(1_150));
    // rust: tracker.finish();
    // rust: assert!(!tracker.is_active() && !tracker.is_level_ready(2_000));
}

a_player_who_cannot_see_the_section_does_not_wait_for_it :: proc() {
}
    // rust: for player in [
    // rust: PlayerCheck {
    // rust: outside_build_height: true,
    // rust: ..ALIVE
    // rust: },
    // rust: PlayerCheck {
    // rust: spectator: true,
    // rust: ..ALIVE
    // rust: },
    // rust: PlayerCheck {
    // rust: alive: false,
    // rust: ..ALIVE
    // rust: },
    // rust: ] {
    // rust: let mut tracker = LevelLoadTracker::new(0);
    // rust: tracker.start_client_load(0, Reason::Other);
    // rust: tracker.loading_packets_received();
    // rust: tracker.tick_client_load(10, player);
    // rust: assert!(tracker.is_level_ready(10));
}
}

the_wait_times_out_after_thirty_seconds_but_only_once_the_server_has_started :: proc() {
}
    // rust: let mut tracker = LevelLoadTracker::new(0);
    // rust: tracker.start_client_load(0, Reason::Other);
    // rust: tracker.tick_client_load(CLIENT_WAIT_TIMEOUT_MS + 1, ALIVE);
    // rust: assert!(!tracker.is_level_ready(CLIENT_WAIT_TIMEOUT_MS + 1));
    // rust: tracker.loading_packets_received();
    // rust: tracker.tick_client_load(CLIENT_WAIT_TIMEOUT_MS, ALIVE);
    // rust: assert!(!tracker.is_level_ready(CLIENT_WAIT_TIMEOUT_MS));
    // rust: tracker.tick_client_load(CLIENT_WAIT_TIMEOUT_MS + 1, ALIVE);
    // rust: assert!(tracker.is_level_ready(CLIENT_WAIT_TIMEOUT_MS + 1));
}

a_new_worlds_screen_stays_for_the_close_delay :: proc() {
}
    // rust: let mut tracker = LevelLoadTracker::new(LEVEL_LOAD_CLOSE_DELAY_MS);
    // rust: tracker.start_client_load(0, Reason::Other);
    // rust: tracker.loading_packets_received();
    // rust: tracker.player_section_ready();
    // rust: tracker.tick_client_load(100, ALIVE);
    // rust: assert!(!tracker.is_level_ready(599));
    // rust: assert!(tracker.is_level_ready(600));
}

a_respawn_names_its_screen_by_the_dimensions :: proc() {
}
    // rust: let (overworld, nether, end) = (
    // rust: "minecraft:overworld",
    // rust: "minecraft:the_nether",
    // rust: "minecraft:the_end",
    // rust: );
    // rust: assert_eq!(
    // rust: reason_for_respawn(false, nether, overworld),
    // rust: Reason::NetherPortal
    // rust: );
    // rust: assert_eq!(
    // rust: reason_for_respawn(false, overworld, nether),
    // rust: Reason::NetherPortal
    // rust: );
    // rust: assert_eq!(reason_for_respawn(false, end, overworld), Reason::EndPortal);
    // rust: assert_eq!(reason_for_respawn(false, end, nether), Reason::NetherPortal);
    // rust: assert_eq!(
    // rust: reason_for_respawn(false, overworld, overworld),
    // rust: Reason::Other
    // rust: );
        // A death never shows a portal.
    // rust: assert_eq!(reason_for_respawn(true, nether, overworld), Reason::Other);
}
}
