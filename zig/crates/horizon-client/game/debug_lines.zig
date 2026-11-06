//! Transpiled from Horizon Rust crate
//! Module: horizon-client_debug_lines
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The F3 overlay's text entries (26.3 `DebugEntry*`): what each enabled
//! entry of `debug-profile.json` reports to the `DebugScreenDisplayer`, in
//! `DebugScreenEntryList.rebuildCurrentList`'s order (by identifier). The
//! entries that read the server's level ask the integrated server for their
//! lines (`ServerDebug`); on another server they show what vanilla shows
//! there, nothing or `??`.
// use super::Game;
// use horizon_client::{
    // rust: debug_entries::ENTRIES, debug_overlay as overlay, debug_overlay::Displayer, java_text,
}
// use horizon_world::{
    // rust: heightmap::{HeightmapState, HeightmapType},
    // rust: worldgen::terrain::TerrainBlockStates,
}
// use std::collections::{HashMap, HashSet};

/// `DebugEntryLookingAt.RANGE`.
pub const LOOKING_AT_RANGE: f64 = 20.0;

/// The entries whose lines come from the server thread.
    // rust: const SERVER_ENTRIES: [&str; 4] = [
    // rust: "chunk_source_stats",
    // rust: "entity_spawn_counts",
    // rust: "heightmap",
    // rust: "local_difficulty",
    // rust: ];

/// What the server thread reports for the window's player
/// (`DebugScreenOverlay.getServerChunk` and its `ServerLevel`).
    // rust: pub(super) struct ServerDebug {
    /// The server chunk's heightmaps at the feet (`keepAfterWorldgen`).
    // rust: pub heights: Option<[i32; 4]>,
    // rust: pub difficulty: Option<String>,
    // rust: pub spawn_counts: Option<String>,
    // rust: pub chunks: Option<String>,
}

    // rust: impl Game<'_> {
    /// Every enabled entry's lines, by identifier.
    // rust: pub(super) fn debug_entry_lines(&self, d: &mut Displayer, framebuffer: [i32; 2]) {
    // rust: let reduced = self.reduced_debug_info();
    // rust: let mut paths: Vec<&str> = ENTRIES
    // rust: .iter()
    // rust: .map(|e| e.path)
    // rust: .filter(|path| self.debug_entries.enabled(path, self.debug, reduced))
    // rust: .collect();
    // rust: paths.sort_unstable();
    // rust: let server = self.server_debug(paths.iter().any(|p| SERVER_ENTRIES.contains(p)));
    // rust: for path in paths {
    // rust: match path {
    // rust: "biome" => self.debug_biome_line(d),
    // rust: "chunk_render_stats" => self.debug_chunk_render_line(d),
    // rust: "chunk_source_stats" => self.debug_chunk_source_lines(d, server.as_ref()),
    // rust: "day_count" => {
    // rust: if self.player.is_some() {
    // rust: d.line(format!("Day #{}", self.world.day_time.div_euclid(24000)));
}
}
    // rust: "entity_render_stats" => self.debug_entity_render_line(d),
    // rust: "entity_spawn_counts" => {
    // rust: if let Some(line) = server.as_ref().and_then(|s| s.spawn_counts.clone()) {
    // rust: d.line(line);
}
}
    // rust: "fps" => self.debug_fps_line(d),
    // rust: "game_version" => d.priority(format!(
    // rust: "Minecraft {v} ({v}/horizon)",
    // rust: v = horizon_client::save::VERSION_NAME
    // rust: )),
    // rust: "gpu_utilization" => d.line(overlay::gpu_line(self.gpu_utilization)),
    // rust: "heightmap" => self.debug_heightmap_lines(d, server.as_ref()),
    // rust: "light_levels" => {
    // rust: if let Some(feet) = self.debug_feet() {
    // rust: let light = self.world.light(feet[0], feet[1], feet[2]);
    // rust: d.group("light", [overlay::light_line(light >> 4, light & 15)]);
}
}
    // rust: "local_difficulty" => {
    // rust: if let Some(line) = server.as_ref().and_then(|s| s.difficulty.clone()) {
    // rust: d.line(line);
}
}
    // rust: "looking_at_block_state" | "looking_at_block_tags" => {
    // rust: let lines = self.debug_looking_at_block(path == "looking_at_block_state");
    // rust: d.group("looking_at_block", lines);
}
    // rust: "looking_at_entity" | "looking_at_entity_tags" => {
    // rust: let lines = self.crosshair_entity_type().map_or_else(Vec::new, |kind| {
    // rust: if path == "looking_at_entity" {
    // rust: vec![format!("{}Targeted Entity", overlay::UNDERLINE), kind]
    // rust: } else {
    // rust: overlay::tag_lines(&self.res.mob_data().entity_tags, &kind)
}
    // rust: });
    // rust: d.group("looking_at_entity", lines);
}
    // rust: "looking_at_fluid_state" | "looking_at_fluid_tags" => {
    // rust: let lines = self.debug_looking_at_fluid(path == "looking_at_fluid_state");
    // rust: d.group("looking_at_fluid", lines);
}
    // rust: "memory" => {
    // rust: if let Some(lines) = self.memory_meter.borrow_mut().lines() {
    // rust: d.group("memory", lines);
}
}
    // rust: "particle_render_stats" => d.line(format!("P: {}", self.particles.len())),
    // rust: "player_position" | "player_section_position" => {
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let mut lines = overlay::position(
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: self.yaw,
    // rust: self.pitch,
    // rust: self.dim.id(),
    // rust: self.streaming.forced.len(),
    // rust: );
    // rust: let section = lines.pop().unwrap_or_default();
    // rust: if path == "player_position" {
    // rust: d.group("position", lines);
    // rust: } else {
    // rust: d.group("position", [section]);
}
}
}
    // rust: "player_speed" => {
    // rust: if self.player.is_some() {
    // rust: let speed = self.known_player_movement();
    // rust: d.group(
    // rust: "position",
    // rust: [format!(
    // rust: "Speed: {} blocks/tick",
    // rust: java_text::format_fixed(speed.length(), 3)
    // rust: )],
    // rust: );
}
}
    // rust: "post_effects" => {
    // rust: let effects = self.requested_post_effects();
    // rust: if !effects.is_empty() {
    // rust: d.line(format!("Post: {}", effects.join(", ")));
}
}
    // rust: "simple_performance_impactors" => self.debug_performance_lines(d),
    // rust: "sound_cache" => {
    // rust: let (buffers, bytes) = self.audio.cache_stats();
    // rust: d.line(overlay::sound_cache_line(buffers, bytes));
}
    // rust: "sound_mood" => {
    // rust: if self.player.is_some() {
    // rust: d.line(overlay::sound_mood_line(
    // rust: self.audio.engine.used_channels(),
    // rust: [
    // rust: horizon_client::sound_engine::STATIC_CHANNELS,
    // rust: horizon_client::sound_engine::STREAMING_CHANNELS,
    // rust: ],
    // rust: self.ambience.moodiness,
    // rust: ));
}
}
    // rust: "system_specs" => {
    // rust: self.debug_system_lines(d, framebuffer);
                    // Horizon's own: the shader pack's GPU time per pass (an
                    // empty group would move others).
    // rust: let pass_lines = self.renderer.as_ref().map_or_else(Vec::new, |r| {
    // rust: overlay::shader_pass_lines(&r.shader_pass_times())
    // rust: });
    // rust: if self.debug && !pass_lines.is_empty() {
    // rust: d.group("shader pack", pass_lines);
}
                    // Horizon's own passes, in a group of their own.
    // rust: let own_lines = self.renderer.as_ref().map_or_else(Vec::new, |r| {
    // rust: overlay::labelled_pass_lines("Horizon GPU", &r.own_pass_times())
    // rust: });
    // rust: if self.debug && !own_lines.is_empty() {
    // rust: d.group("Horizon passes", own_lines);
}
}
    // rust: "tps" => self.debug_tps_line(d),
                // DebugEntryChunkGeneration, where the world is generated
                // here: the window's server thread publishes its generators.
    // rust: "chunk_generation_stats" => {
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let terrain = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .and_then(|server| server.terrain(self.dim.id()));
                        // `DebugEntryChunkGeneration.display`: the feet block
                        // decides whether the line is sampled again; otherwise
                        // the last result is drawn.
    // rust: let feet = [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ];
    // rust: let dim = self.dim.id();
    // rust: let mut cache = self.debug_density.borrow_mut();
    // rust: let line = cache.line(
    // rust: dim,
    // rust: feet,
    // rust: terrain.map(|t| move || t.density_debug_line(feet)),
    // rust: );
    // rust: if let Some(line) = line {
    // rust: d.group("chunk_generation", [line.to_owned()]);
}
}
}
                // detailed_memory: the JVM's memory pools, which Horizon
                // has none of. The rest are renderers (debug_renderers.rs).
    // rust: _ => {}
}
}
}

    /// The camera's feet (`Entity.blockPosition`).
pub fn debug_feet(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.player.as_ref()?;
    // rust: Some([p.position.x, p.position.y, p.position.z].map(|v| v.floor() as i32))
}

    /// The integrated server's lines when an entry wants them; the request
    /// (the dimension and the feet) goes with it, for the next server tick.
pub fn server_debug(self: *Self, wanted: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let server = self.integrated.as_ref()?;
    // rust: let at = self
    // rust: .debug_feet()
    // rust: .filter(|_| wanted)
    // rust: .map(|feet| (self.dim, feet));
    // rust: server.request_debug(at);
    // rust: at.map(|_| server.debug())
}

    /// `DebugEntryBiome`: the client level's biome at the feet, inside the
    /// build height.
pub fn debug_biome_line(self: *Self, d: *mut Displayer) void {
}
    // rust: let Some([x, y, z]) = self.debug_feet() else {
    // rust: return;
}
    // rust: if y < self.world.bottom_y() || y >= self.world.top_y() {
    // rust: return;
}
    // rust: if let Some(chunk) = self.world.chunks.get(&(x >> 4, z >> 4))
    // rust: && let Some(biome) = self.res.biomes().list.get(chunk.biome(x, y, z) as usize)
    // rust: {
    // rust: d.line(format!("Biome: {}", biome.name));
}
}

    /// `LevelExtractor.sectionStatistics`: the sections drawn of the view
    /// area's (smart culling is always on), the render distance, and
    /// `SectionRenderDispatcher.getStats` (the meshes queued; Horizon has
    /// no buffer pool, so no buffer is ever free).
pub fn debug_chunk_render_line(self: *Self, d: *mut Displayer) void {
}
    // rust: let Some(r) = self.renderer.as_ref() else {
    // rust: return;
}
    // rust: let distance = self.settings.render_distance;
    // rust: let side = (distance * 2 + 1) as usize;
    // rust: let total = side * side * (self.world.layout().height() / 16) as usize;
    // rust: d.line(format!(
    // rust: "C: {}/{total} (s) D: {distance}, pC: {:03}, aB: {:02}",
    // rust: r.drawn_sections,
    // rust: self.streaming.pending(),
    // rust: 0
    // rust: ));
}

    /// `LevelExtractor.entityStatistics`: the mobs drawn last frame of the
    /// level's entities, and the server's simulation distance.
pub fn debug_entity_render_line(self: *Self, d: *mut Displayer) void {
}
    // rust: if self.player.is_none() {
    // rust: return;
}
    // rust: let simulation = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map_or(self.settings.simulation_distance, |r| r.simulation_distance);
    // rust: d.line(format!(
    // rust: "E: {}/{}, SD: {simulation}",
    // rust: self.rendered_mobs.get(),
    // rust: self.debug_entity_count()
    // rust: ));
}

    /// `Level.getEntityCount` over the entities Horizon keeps.
pub fn debug_entity_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mobs.iter().filter(|m| !m.removed).count()
    // rust: + self.dropped.len()
    // rust: + self.orbs.len()
    // rust: + self.paintings.len()
    // rust: + self.item_frames.len()
    // rust: + self.armor_stands.len()
    // rust: + self.boats.len()
    // rust: + self.carts.len()
    // rust: + self.crystals.len()
    // rust: + self.creatures.projectiles.len()
}

    /// The sections holding a mob, an item or an orb
    /// (`EntitySectionStorage.count`).
pub fn debug_entity_sections(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sections: HashSet<[i32; 3]> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| !m.removed)
    // rust: .map(|m| [m.position.x, m.position.y, m.position.z])
    // rust: .chain(
    // rust: self.dropped
    // rust: .iter()
    // rust: .map(|i| [i.position.x, i.position.y, i.position.z]),
    // rust: )
    // rust: .chain(
    // rust: self.orbs
    // rust: .iter()
    // rust: .map(|o| [o.position.x, o.position.y, o.position.z]),
    // rust: )
    // rust: .map(|p| p.map(|v| (v.floor() as i32) >> 4))
    // rust: .collect();
    // rust: sections.len()
}

    /// `DebugEntryChunkSourceStats`: `ClientLevel.gatherChunkSourceStats`
    /// (the chunk storage's size and its loaded chunks, then the entities,
    /// the sections holding them and the chunks that tick them), and the
    /// server level's when this game runs it.
pub fn debug_chunk_source_lines(self: *Self, d: *mut Displayer, server: ?*ServerDebug) void {
}
    // rust: if self.player.is_none() {
    // rust: return;
}
    // rust: let range = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map_or(self.settings.render_distance, |r| r.view_distance);
    // rust: let side = (2 * (range.max(2) + 3) + 1) as usize;
    // rust: let loaded = self.world.chunks.len();
    // rust: d.line(format!(
    // rust: "Chunks[C] W: {}, {loaded} E: {},{},{loaded}",
    // rust: side * side,
    // rust: self.debug_entity_count(),
    // rust: self.debug_entity_sections()
    // rust: ));
    // rust: if let Some(line) = server.and_then(|s| s.chunks.clone()) {
    // rust: d.line(line);
}
}

    /// `DebugEntryHeightmap`: the client chunk's heightmaps at the feet,
    /// and the server chunk's.
pub fn debug_heightmap_lines(self: *Self, d: *mut Displayer, server: ?*ServerDebug) void {
}
    // rust: let Some([x, _, z]) = self.debug_feet() else {
    // rust: return;
}
    // rust: if !self.world.loaded(x, z) {
    // rust: return;
}
    // rust: let heights = server.and_then(|s| s.heights);
    // rust: let server_height = |kind: HeightmapType| {
    // rust: let i = [
    // rust: HeightmapType::WorldSurface,
    // rust: HeightmapType::OceanFloor,
    // rust: HeightmapType::MotionBlocking,
    // rust: HeightmapType::MotionBlockingNoLeaves,
    // rust: ]
    // rust: .iter()
    // rust: .position(|k| *k == kind)
    // rust: .unwrap_or(0);
    // rust: heights.map_or(0, |h| h[i])
}
    // rust: let lines = overlay::heightmap_lines(
    // rust: |kind| self.column_height(kind, x, z),
    // rust: heights
    // rust: .is_some()
    // rust: .then_some(&server_height as &dyn Fn(_) -> i32),
    // rust: );
    // rust: d.group("heightmaps", lines);
}

    /// `Heightmap.getFirstAvailable`: one above the highest block the
    /// heightmap counts. The chunk keeps WORLD_SURFACE; every other type is
    /// at or under it, scanned down from there.
    // rust: pub(super) fn column_height(&self, kind: HeightmapType, x: i32, z: i32) -> i32 {
    // rust: let properties = &self.pack.assets.properties;
    // rust: let surface = self
    // rust: .world
    // rust: .world_surface(x, z, |s| properties.heightmap_state(s).is_air());
    // rust: if kind == HeightmapType::WorldSurface {
    // rust: return surface;
}
    // rust: (self.world.bottom_y()..surface)
    // rust: .rev()
    // rust: .find(|&y| kind.is_opaque(properties.heightmap_state(self.world.block(x, y, z))))
    // rust: .map_or(self.world.bottom_y(), |y| y + 1)
}

    /// `Entity.pick(20, 0, false)` from the camera: the block outline hit.
pub fn debug_block_hit(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (origin, dir) = self.aim()?;
    // rust: Some(self.clip_ray(origin, dir, LOOKING_AT_RANGE)?.pos)
}

    /// `DebugEntryLookingAt.BlockStateInfo` or `BlockTagInfo`.
pub fn debug_looking_at_block(self: *Self, state: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(pos) = self.debug_block_hit() else {
    // rust: return Vec::new();
}
    // rust: let id = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let Some(s) = self.pack.assets.registry.state(id) else {
    // rust: return Vec::new();
}
    // rust: if state {
    // rust: overlay::state_lines(
    // rust: "Targeted Block",
    // rust: pos,
    // rust: &s.name,
    // rust: s.properties.iter().map(|(k, v)| (k.as_str(), v.as_str())),
    // rust: )
    // rust: } else {
    // rust: overlay::tag_lines(&self.items().block_tags, &s.name)
}
}

    /// `Entity.pick(20, 0, true)` (`ClipContext.Fluid.ANY`): the first fluid
    /// along the view, under its surface, before the block outline hit.
pub fn debug_fluid_hit(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (origin, dir) = self.aim()?;
    // rust: let block = self.clip_ray(origin, dir, LOOKING_AT_RANGE);
    // rust: let reach = block.map_or(LOOKING_AT_RANGE, |h| {
    // rust: (0..3)
    // rust: .map(|i| (h.point[i] - origin[i]).powi(2))
    // rust: .sum::<f64>()
    // rust: .sqrt()
    // rust: });
    // rust: let mut t = 0.0;
    // rust: while t <= reach {
    // rust: let p: [f64; 3] = std::array::from_fn(|i| origin[i] + dir[i] * t);
    // rust: let b = p.map(|v| v.floor() as i32);
    // rust: if let Some((height, _)) = self.fluid_height_of(b[0], b[1], b[2], None)
    // rust: && p[1] - f64::from(b[1]) <= f64::from(height)
    // rust: {
    // rust: return Some(b);
}
    // rust: t += 0.05;
}
    // rust: block.map(|h| h.pos)
}

    /// `FluidState`'s registered name and properties at `pos`: a source is
    /// `water`/`lava` with `falling`, a flowing one `flowing_*` with `level`.
pub fn fluid_state(self: *Self, pos: [i32; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::blocks::Fluid;
    // rust: let f = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]));
    // rust: let kind = match f.fluid {
    // rust: Fluid::None => return ("minecraft:empty".into(), Vec::new()),
    // rust: Fluid::Water => "water",
    // rust: Fluid::Lava => "lava",
}
    // rust: let falling = ("falling", f.fluid_falling.to_string());
    // rust: if f.fluid_level == 8 && !f.fluid_falling {
    // rust: (format!("minecraft:{kind}"), vec![falling])
    // rust: } else {
    // rust: (
    // rust: format!("minecraft:flowing_{kind}"),
    // rust: vec![falling, ("level", f.fluid_level.to_string())],
    // rust: )
}
}

    /// `DebugEntryLookingAt.FluidStateInfo` or `FluidTagInfo`.
pub fn debug_looking_at_fluid(self: *Self, state: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(pos) = self.debug_fluid_hit() else {
    // rust: return Vec::new();
}
    // rust: let (name, properties) = self.fluid_state(pos);
    // rust: if state {
    // rust: overlay::state_lines(
    // rust: "Targeted Fluid",
    // rust: pos,
    // rust: &name,
    // rust: properties.iter().map(|(k, v)| (*k, v.as_str())),
    // rust: )
    // rust: } else {
    // rust: overlay::tag_lines(fluid_tags(&self.options.resources), &name)
}
}

    /// `Minecraft.crosshairPickEntity`'s type: the nearest entity under the
    /// crosshair before any block.
pub fn crosshair_entity_type(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut best: Option<(f64, String)> = None;
    // rust: let mut offer = |hit: Option<(f64, String)>| {
    // rust: if let Some((distance, kind)) = hit
    // rust: && self.before_block(distance)
    // rust: && best.as_ref().is_none_or(|b| distance < b.0)
    // rust: {
    // rust: best = Some((distance, kind));
}
}
    // rust: offer(
    // rust: self.mob_hit()
    // rust: .map(|(i, d, _)| (d, self.mobs[i].kind.id.to_string())),
    // rust: );
    // rust: offer(
    // rust: self.boat_hit()
    // rust: .map(|(i, d)| (d, self.boats[i].entity_type())),
    // rust: );
    // rust: offer(
    // rust: self.cart_hit()
    // rust: .map(|(i, d)| (d, self.carts[i].kind.id().to_owned())),
    // rust: );
    // rust: offer(
    // rust: self.armor_stand_hit()
    // rust: .map(|(_, d, _)| (d, "minecraft:armor_stand".to_owned())),
    // rust: );
    // rust: offer(
    // rust: self.frame_hit()
    // rust: .map(|(i, d)| (d, self.item_frames[i].kind().to_owned())),
    // rust: );
    // rust: offer(
    // rust: self.painting_hit()
    // rust: .map(|(_, d)| (d, "minecraft:painting".to_owned())),
    // rust: );
    // rust: offer(
    // rust: self.dragon_hit()
    // rust: .map(|(_, d)| (d, "minecraft:ender_dragon".to_owned())),
    // rust: );
    // rust: best.map(|b| b.1)
}

    /// The server thread's half of the debug entries, in the level of
    /// `dim` while it is in place: the server chunk's heightmaps, the local
    /// difficulty, the last spawn state and the chunk source's counts.
    // rust: pub(super) fn server_debug_lines(&self, feet: [i32; 3]) -> ServerDebug {
    // rust: let [x, y, z] = feet;
    // rust: let key = (x >> 4, z >> 4);
    // rust: let loaded = self.world.chunks.contains_key(&key);
    // rust: let inside = y >= self.world.bottom_y() && y < self.world.top_y();
    // rust: let heights = loaded.then(|| {
    // rust: [
    // rust: HeightmapType::WorldSurface,
    // rust: HeightmapType::OceanFloor,
    // rust: HeightmapType::MotionBlocking,
    // rust: HeightmapType::MotionBlockingNoLeaves,
    // rust: ]
    // rust: .map(|kind| self.column_height(kind, x, z))
    // rust: });
    // rust: let difficulty = (loaded && inside).then(|| {
    // rust: let at = [f64::from(x), f64::from(y), f64::from(z)];
    // rust: overlay::local_difficulty_line(self.local_difficulty(at).effective)
    // rust: });
    // rust: let spawn_counts = self
    // rust: .spawn_counts
    // rust: .get(&self.dim)
    // rust: .map(|(chunks, counts)| overlay::spawn_counts_line(*chunks, counts));
        // ServerLevel.gatherChunkSourceStats: the chunk map's size, then
        // PersistentEntitySectionManager's known and visible entities, its
        // sections, the chunks it loaded and sees, and its two queues
        // (Horizon loads a chunk's entities with it: both stay empty).
    // rust: let (entities, loaded) = (self.debug_entity_count(), self.world.chunks.len());
    // rust: let chunks = Some(format!(
    // rust: "Chunks[S] W: {loaded} E: {entities},{entities},{},{loaded},{loaded},0,0",
    // rust: self.debug_entity_sections()
    // rust: ));
    // rust: ServerDebug {
    // rust: heights,
    // rust: difficulty,
    // rust: spawn_counts,
    // rust: chunks,
}
}
}

/// The fluid tags (`data/*/tags/fluid`), loaded once.
pub fn fluid_tags(root: *std::path::Path) * {
    // Implementation ported from Horizon
    return undefined;
}
pub const TAGS: std::sync::OnceLock<std.AutoHashMap([]const u8, std.AutoHashMap([]const u8), void)> = std::sync::OnceLock::new();
    // rust: TAGS.get_or_init(|| {
    // rust: horizon_client::items::load_tags(root, "fluid", &horizon_world::loot::PackOverlay::NONE)
    // rust: .unwrap_or_default()
    // rust: })
}
