//! Transpiled from Horizon Rust crate
package horizon_client_natural_spawning

import "core:fmt"
import "core:mem"
import "core:math"

// The game's side of `NaturalSpawner` (`mobs::spawn_selection`): the level
// it reads, the spawning chunks and caps of `ServerChunkCache.tickChunks`,
// and the mobs it adds (finalized with the game's `finalizeSpawn`).
// use super::{Dim, Game};
// use horizon_client::vanillagen::VanillaTerrain;
// use horizon_client::{
    // rust: biome::{BiomeInfo, SpawnEntry},
    // rust: blocks::BlockFacts,
    // rust: collisions::{SceneCollisions, no_collision_empty},
    // rust: mobs::{
    // rust: Mob, MobWorld, Species,
    // rust: data::{self, MobData},
    // rust: seen_grid::SeenGrid,
    // rust: spawn_rules::{Dimension, SpawnLevel},
    // rust: spawn_selection::{
    // rust: self, Category, Counted, Heightmap, NaturalLevel, SpawnCost, SpawnPlayer, SpawnRequest,
    // rust: SpawnState, Spawned, StructureAt, StructureSpawns,
    // rust: },
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::{LegacyRandom, RandomSource, WorldgenRandom, XoroshiroRandom},
}
// use horizon_world::{
    // rust: nbt::{Compound, Tag},
    // rust: registry::BlockStateId,
}
// use std::collections::HashMap;

// Natural spawning's candidate chunks (`ChunkMap.collectSpawningChunks`):
// the union of every player's 17×17 chunk square, in player then dx/dz
// order, each chunk once. `candidates` is one pass's working list (spawning
// shuffles and drains it); the rest is the union for the players' last chunk
// positions, kept between ticks. A chunk crossing rebuilds only the squares
// it can change, and proximity to players is checked live on every pass.
    // rust: pub(super) struct SpawnScratch {
    // rust: pub(super) candidates: Vec<(i32, i32)>,
    // Each player's chunk at the last pass.
    // rust: chunks: Vec<(i32, i32)>,
    // For each player, the others whose squares overlap its own, in order.
    // rust: neighbours: Vec<Vec<usize>>,
    // The chunks each player adds to the union: those of its square, in
    // dx/dz order, that no earlier player's square holds.
    // rust: segments: Vec<Vec<(i32, i32)>>,
    // rust: stale: Vec<bool>,
}
    // rust: impl SpawnScratch {
chunk :: proc(p: ^LevelPlayer) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: p.position.x.floor() as i32 >> 4,
    // rust: p.position.z.floor() as i32 >> 4,
    // rust: )
}
    // Whether the square around chunk `centre` holds chunk `c`.
holds :: proc(centre: (i32) {
}
    // rust: centre.0.abs_diff(c.0) <= 8 && centre.1.abs_diff(c.1) <= 8
}
overlap :: proc(a: (i32) {
}
    // rust: a.0.abs_diff(b.0) <= 16 && a.1.abs_diff(b.1) <= 16
}
    // Bring the segments up to date with the players' chunks. A segment
    // depends only on its player's chunk and those of the earlier players
    // whose squares overlap it, so a move rebuilds the mover's segment and
    // the later ones its old or new square overlaps.
prepare :: proc(self: ^Self, players: ^[LevelPlayer]) {
}
    // rust: let n = players.len();
    // rust: let all = n != self.chunks.len();
    // rust: self.stale.clear();
    // rust: self.stale.resize(n, all);
    // rust: if !all {
    // rust: let mut moved = false;
    // rust: for m in 0..n {
    // rust: let (old, new) = (self.chunks[m], Self::chunk(&players[m]));
    // rust: if old == new {
    // rust: continue;
}
    // rust: moved = true;
    // rust: self.stale[m] = true;
    // rust: for (i, p) in players.iter().enumerate().skip(m + 1) {
    // rust: let c = Self::chunk(p);
    // rust: self.stale[i] |= Self::overlap(old, c) || Self::overlap(new, c);
}
}
    // rust: if !moved {
    // rust: return;
}
}
    // rust: self.chunks.clear();
    // rust: self.chunks.extend(players.iter().map(Self::chunk));
    // rust: self.neighbours.resize_with(n, Vec::new);
    // rust: self.neighbours.truncate(n);
    // rust: self.segments.resize_with(n, Vec::new);
    // rust: self.segments.truncate(n);
    // rust: let chunks = &self.chunks;
    // rust: for (i, near) in self.neighbours.iter_mut().enumerate() {
    // rust: near.clear();
    // rust: near.extend((0..n).filter(|&j| j != i && Self::overlap(chunks[i], chunks[j])));
}
    // rust: for (i, segment) in self.segments.iter_mut().enumerate() {
    // rust: if !self.stale[i] {
    // rust: continue;
}
    // rust: let near = &self.neighbours[i];
    // rust: let earlier = &near[..near.partition_point(|&j| j < i)];
    // rust: let (pcx, pcz) = chunks[i];
    // rust: segment.clear();
    // rust: for dx in -8..=8 {
    // rust: for dz in -8..=8 {
    // rust: let c = (pcx + dx, pcz + dz);
    // rust: if !earlier.iter().any(|&j| Self::holds(chunks[j], c)) {
    // rust: segment.push(c);
}
}
}
}
}
    // Fill `candidates` with the union's chunks, in order, that are within
    // 128 blocks of a non-spectator holding them in its square and that
    // `keep` accepts. Returns the union's size.
    // rust: fn collect(
    // rust: &mut self,
    // rust: players: &[LevelPlayer],
    // rust: mut keep: impl FnMut((i32, i32)) -> bool,
    // rust: ) -> i32 {
    // rust: self.prepare(players);
    // rust: self.candidates.clear();
    // rust: let mut count = 0;
    // rust: for (i, segment) in self.segments.iter().enumerate() {
    // rust: count += segment.len();
    // rust: let near = &self.neighbours[i];
    // rust: for &c in segment {
    // rust: let close = close_enough_for_spawning(&players[i], c)
    // rust: || near.iter().any(|&j| {
    // rust: Self::holds(self.chunks[j], c) && close_enough_for_spawning(&players[j], c)
    // rust: });
    // rust: if close && keep(c) {
    // rust: self.candidates.push(c);
}
}
}
    // rust: count as i32
}
}

// A player in the level in place, as spawning and despawning see it.
    // rust: pub(super) struct LevelPlayer {
    // rust: pub(super) uuid: u128,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) bounds: Aabb,
    // rust: pub(super) alive: bool,
    // rust: pub(super) creative: bool,
    // rust: pub(super) spectator: bool,
}
    // rust: impl LevelPlayer {
distance_sqr :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (self.position.x - x).powi(2)
    // rust: + (self.position.y - y).powi(2)
    // rust: + (self.position.z - z).powi(2)
}
    // `Level.hasNearbyAlivePlayer`'s test of one player (any distance for a
    // negative range).
alive_near :: proc(self: ^Self, x: f64, y: f64, z: f64, range: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.alive && !self.spectator && (range < 0.0 || self.distance_sqr(x, y, z) < range * range)
}
}
// `ChunkMap.euclideanDistanceSquared` below 128 blocks
// (`playerIsCloseEnoughForSpawning`).
close_enough_for_spawning :: proc(p: ^LevelPlayer) {
}
    // rust: let (x, z) = (
    // rust: f64::from(cx * 16 + 8) - p.position.x,
    // rust: f64::from(cz * 16 + 8) - p.position.z,
    // rust: );
    // rust: !p.spectator && x * x + z * z < 16384.0
}
// `EntityGetter.getNearestPlayer(x, y, z, -1, false)`: the nearest
// non-spectator, alive or not.
    // rust: pub(super) fn nearest_player(
    // rust: players: &[LevelPlayer],
    // rust: x: f64,
    // rust: y: f64,
    // rust: z: f64,
    // rust: ) -> Option<&LevelPlayer> {
    // rust: let mut best: Option<(&LevelPlayer, f64)> = None;
    // rust: for p in players.iter().filter(|p| !p.spectator) {
    // rust: let d = p.distance_sqr(x, y, z);
    // rust: if best.is_none_or(|(_, b)| d < b) {
    // rust: best = Some((p, d));
}
}
    // rust: best.map(|(p, _)| p)
}

// [`nearest_player`] for many positions: the non-spectators by the 64-block
// square they stand in, searched ring by ring outwards from the position.
// Every mob asks each tick, and with players spread over the map that was a
// look at every player for every mob.
    // rust: pub(super) struct NearestPlayers<'p> {
    // rust: players: &'p [LevelPlayer],
    // rust: cells: horizon_client::fast_hash::FxHashMap<(i64, i64), Vec<usize>>,
    // The cells' bounding box: (x0, z0, x1, z1).
    // rust: bounds: (i64, i64, i64, i64),
    // Few players, or one too far out for cells: every question scans.
    // rust: scan: bool,
}
    // rust: impl<'p> NearestPlayers<'p> {
CELL :: 64.0
    // Further out than any world border: such positions are answered by a scan.
FAR :: 1.0e9
    // rust: pub(super) fn new(players: &'p [LevelPlayer]) -> Self {
    // rust: let mut cells = horizon_client::fast_hash::FxHashMap::<(i64, i64), Vec<usize>>::default();
    // rust: let mut bounds = (i64::MAX, i64::MAX, i64::MIN, i64::MIN);
    // rust: let mut scan = players.len() <= 8;
    // rust: for (i, p) in players.iter().enumerate().filter(|(_, p)| !p.spectator) {
    // rust: if !(p.position.x.abs() < Self::FAR && p.position.z.abs() < Self::FAR) {
                // Past any world border (or not a number): scans answer.
    // rust: scan = true;
    // rust: break;
}
    // rust: let key = Self::cell(p.position.x, p.position.z);
    // rust: cells.entry(key).or_default().push(i);
    // rust: bounds = (
    // rust: bounds.0.min(key.0),
    // rust: bounds.1.min(key.1),
    // rust: bounds.2.max(key.0),
    // rust: bounds.3.max(key.1),
    // rust: );
}
    // rust: Self {
    // rust: players,
    // rust: cells,
    // rust: bounds,
    // rust: scan,
}
}
cell :: proc(x: f64, z: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: (x / Self::CELL).floor() as i64,
    // rust: (z / Self::CELL).floor() as i64,
    // rust: )
}
    // The same player [`nearest_player`] finds: the nearest, the first in
    // the list among equals.
    // rust: pub(super) fn nearest(&self, x: f64, y: f64, z: f64) -> Option<&'p LevelPlayer> {
    // rust: if self.scan || !(x.abs() < Self::FAR && z.abs() < Self::FAR) {
    // rust: return nearest_player(self.players, x, y, z);
}
    // rust: if self.cells.is_empty() {
    // rust: return None;
}
    // rust: let (qx, qz) = Self::cell(x, z);
    // rust: let (x0, z0, x1, z1) = self.bounds;
    // rust: let last = (qx - x0)
    // rust: .abs()
    // rust: .max((qx - x1).abs())
    // rust: .max((qz - z0).abs())
    // rust: .max((qz - z1).abs());
    // rust: let mut best: Option<(usize, f64)> = None;
    // rust: let mut looked = 0usize;
    // rust: for ring in 0..=last {
    // rust: let mut look = |kx: i64, kz: i64| {
    // rust: looked += 1;
    // rust: for &i in self.cells.get(&(kx, kz)).into_iter().flatten() {
    // rust: let d = self.players[i].distance_sqr(x, y, z);
    // rust: if best.is_none_or(|(b, bd)| d < bd || d == bd && i < b) {
    // rust: best = Some((i, d));
}
}
}
    // rust: if ring == 0 {
    // rust: look(qx, qz);
    // rust: } else {
    // rust: for k in -ring..=ring {
    // rust: look(qx + k, qz - ring);
    // rust: look(qx + k, qz + ring);
}
    // rust: for k in 1 - ring..ring {
    // rust: look(qx - ring, qz + k);
    // rust: look(qx + ring, qz + k);
}
}
            // Everyone in a further ring is more than `ring` cells away on one
            // axis, so further than the one found.
    // rust: let bound = ring as f64 * Self::CELL;
    // rust: if best.is_some_and(|(_, d)| d <= bound * bound) {
    // rust: break;
}
    // rust: if looked > self.players.len() * 4 {
    // rust: return nearest_player(self.players, x, y, z);
}
}
    // rust: best.map(|(i, _)| &self.players[i])
}
}

// The game level as natural spawning reads it.
    // rust: pub(super) struct GameLevel<'g, 'a> {
    // rust: pub(super) game: &'g Game<'a>,
    // rust: pub(super) w: MobWorld<'g>,
    // Every player in the level ([`Game::level_players`]).
    // rust: pub(super) players: Vec<LevelPlayer>,
    // Where the non-spectators among them are (`getNearestPlayer`).
    // rust: pub(super) nearest: Vec<[f64; 3]>,
    // Boxes of the mobs this pass created, not yet in the game's list.
    // rust: pub(super) pending: std::cell::RefCell<Vec<Aabb>>,
    // The types and boxes of what a spawner created this tick.
    // rust: pub(super) pending_ids: std::cell::RefCell<Vec<(String, Aabb)>>,
    // The game's mobs by box, built once a pass has asked more than
    // [`SCANNED_QUERIES`] box queries (the mobs do not change while it
    // holds the game); the first ones scan, as the build costs a few scans.
    // rust: pub(super) boxes: std::cell::OnceCell<MobBoxes>,
    // rust: pub(super) box_queries: std::cell::Cell<u32>,
    // The entity types some biome of the level gives a spawn cost (the
    // nether's few): for any other the cost is none wherever it stands, and
    // spawning asks for one for every loaded mob each tick.
    // rust: pub(super) costed: Vec<&'g str>,
}
SCANNED_QUERIES :: 8
// A mob not removed: its index in `Game::mobs`, box, alive, and whether
// it is a living shulker.
    // rust: type MobBox = (usize, Aabb, bool, bool);
mob_box :: proc(i: uint, m: ^Mob) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let alive = m.alive();
    // rust: (
    // rust: i,
    // rust: m.bounds(),
    // rust: alive,
    // rust: alive && m.species() == Species::Shulker,
    // rust: )
}
// The boxes of the game's mobs not removed, and a grid over them.
    // rust: pub(super) struct MobBoxes {
    // rust: entries: Vec<MobBox>,
    // rust: grid: SeenGrid,
}
    // rust: impl MobBoxes {
new :: proc(mobs: ^[Mob]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let entries: Vec<_> = mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| !m.removed)
    // rust: .map(|(i, m)| mob_box(i, m))
    // rust: .collect();
    // rust: let grid = SeenGrid::new(entries.iter().map(|e| e.1));
    // rust: Self { entries, grid }
}
    // The entries whose boxes meet `area` (and possibly a few more).
near :: proc(self: ^Self, area: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut near = Vec::new();
    // rust: let indexed = self.grid.candidates(area, &mut near);
    // rust: let all = (!indexed).then(|| self.entries.iter());
    // rust: near.into_iter()
    // rust: .map(|i| self.entries[i as usize])
    // rust: .chain(all.into_iter().flatten().copied())
}
}
    // rust: impl GameLevel<'_, '_> {
    // The mobs not removed whose boxes may meet `area` (callers test them).
mobs_near :: proc(self: ^Self, area: Aabb) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let asked = self.box_queries.get() + 1;
    // rust: self.box_queries.set(asked);
    // rust: if asked <= SCANNED_QUERIES && self.boxes.get().is_none() {
    // rust: return Box::new(
    // rust: self.game
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| !m.removed)
    // rust: .map(|(i, m)| mob_box(i, m)),
    // rust: );
}
    // rust: Box::new(
    // rust: self.boxes
    // rust: .get_or_init(|| MobBoxes::new(&self.game.mobs))
    // rust: .near(area),
    // rust: )
}
biome :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let chunk = self.game.world.chunks.get(&(x >> 4, z >> 4))?;
    // rust: Some(world_biomes!(self.game).get(chunk.biome(x, y, z)))
}
    // The block whose noise cell `BiomeManager.getBiome` reads.
zoomed :: proc(self: ^Self, x: i32, y: i32, z: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let zoom = self.game.streaming.biome_zoom;
    // rust: let [qx, qy, qz] = zoom.quart_at_block(horizon_core::position::BlockPos::new(x, y, z));
    // rust: [qx << 2, qy << 2, qz << 2]
}
zoomed_biome :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = self.zoomed(x, y, z);
    // rust: self.biome(x, y, z)
}
}
    // rust: impl SpawnLevel for GameLevel<'_, '_> {
state :: proc(self: ^Self, x: i32, y: i32, z: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.w.state(x, y, z)
}
facts :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.w.facts
}
mob_data :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.w.data
}
block_tag :: proc(self: ^Self, tag: string, block: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.block_tag(tag, block)
}
    // Level.getBiome: the zoomed biome.
biome_tag :: proc(self: ^Self, tag: string, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = self.zoomed(x, y, z);
    // rust: self.w.biome_tag(tag, x, y, z)
}
sky_light :: proc(self: ^Self, x: i32, y: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.sky_light(x, y, z)
}
block_light :: proc(self: ^Self, x: i32, y: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.block_light(x, y, z)
}
sky_darken :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: SpawnLevel::sky_darken(&self.w)
}
thundering :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.thundering
}
sea_level :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.sea_level()
}
world_surface :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.world_surface(x, z)
}
peaceful :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.peaceful()
}
dimension :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: self.w.dimension()
}
surface_slime_chance :: proc(self: ^Self, x: i32, y: i32, z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.w.surface_slime_chance(x, y, z)
}
world_seed :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.world_seed
}
    // `getNearestPlayer(x, y, z, distance, true)`, over every player.
player_near :: proc(self: ^Self, x: f64, y: f64, z: f64, distance: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.players.iter().any(|p| {
    // rust: p.alive && !p.creative && !p.spectator && p.distance_sqr(x, y, z) < distance * distance
    // rust: })
}
}
    // rust: impl NaturalLevel for GameLevel<'_, '_> {
spawn_hooks :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !horizon_client::mod_api::mods().is_empty()
}
potential_spawns :: proc(self: ^Self, category: Category, pos: [i32; 3], entries: ^[dynamic]SpawnEntry) {
}
    // rust: let mut canceled = false;
    // rust: self.game.native_potential_spawns(
    // rust: self.game.dim.id(),
    // rust: category.name(),
    // rust: pos,
    // rust: entries,
    // rust: &mut canceled,
    // rust: );
    // rust: if canceled {
    // rust: entries.clear();
}
}
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.world.bottom_y()
}
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.w.world.top_y() - 1
}
ambient_light :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.game.dim {
    // rust: Dim::Nether => 0.1,
    // rust: Dim::End => 0.25,
    // rust: _ => 0.0,
}
}
has_ceiling :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.world.shape.has_ceiling
}
mob_type :: proc(self: ^Self, entity: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let t = self.game.res.mob_types().get(entity)?;
    // rust: Some((
    // rust: t.species,
    // rust: t.width as f32,
    // rust: t.height as f32,
    // rust: Category::from_name(&t.category),
    // rust: ))
}
    // The `natural_mob_spawns` attribute reads the zoomed biome
    // (fullResolutionBiomes), the spawn probability the noise cell.
biome_spawns :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.zoomed_biome(x, y, z).map(|b| &b.spawns)
}
spawn_cost :: proc(self: ^Self, entity: string, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.costed.contains(&entity) {
    // rust: return None;
}
    // rust: self.zoomed_biome(x, y, z)?.spawn_costs.get(entity).copied()
}
creature_probability :: proc(self: ^Self, x: i32, y: i32, z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.biome(x, y, z).map_or(0.1, |b| b.creature_probability)
}
    // rust: fn structures_at(
    // rust: &self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: wanted: &dyn Fn(&str) -> bool,
    // rust: ) -> Vec<StructureAt> {
    // rust: self.game
    // rust: .structures_reaching_where([x, y, z], wanted)
    // rust: .into_iter()
    // rust: .map(|(id, in_piece)| StructureAt {
    // rust: id,
    // rust: in_piece,
    // rust: in_bounds: true,
    // rust: })
    // rust: .collect()
}
structure_spawns :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: StructureSpawns::shared(&self.game.options.resources)
}
nearest_player_positions :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.nearest
}
respawn :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
        // The world spawn point lives in the overworld.
    // rust: if self.game.dim != Dim::Overworld {
    // rust: return None;
}
    // rust: self.game.level.spawn.map(|s| {
    // rust: [
    // rust: s[0].floor() as i32,
    // rust: s[1].floor() as i32,
    // rust: s[2].floor() as i32,
    // rust: ]
    // rust: })
}
can_spawn_in_chunk :: proc(self: ^Self, cx: i32, cz: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.world.chunks.contains_key(&(cx, cz))
}
no_collision :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.game.world,
    // rust: binding: self.w.collision,
    // rust: subject: None,
}
        // getEntityCollisions(null, box): living shulkers are solid.
    // rust: let grown = bounds.inflate(Vec3::new(1e-7, 1e-7, 1e-7));
    // rust: no_collision_empty(&mut scene, bounds)
    // rust: && !self
    // rust: .mobs_near(grown)
    // rust: .any(|(_, b, _, shulker)| shulker && b.intersects(grown))
    // rust: && !self
    // rust: .pending_ids
    // rust: .borrow()
    // rust: .iter()
    // rust: .any(|(id, b)| id == "minecraft:shulker" && b.intersects(grown))
}
unobstructed :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let player = self
    // rust: .players
    // rust: .iter()
    // rust: .any(|p| p.alive && !p.spectator && p.bounds.intersects(bounds));
    // rust: !player
    // rust: && !self.pending.borrow().iter().any(|b| b.intersects(bounds))
    // rust: && !self
    // rust: .mobs_near(bounds)
    // rust: .any(|(_, b, alive, _)| alive && b.intersects(bounds))
}
spawn_mobs :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.ui.rules.bool("spawn_mobs")
}
    // WORLD_SURFACE (every spawn attempt's) is the chunk's kept heightmap.
    // The others are scanned down the column: sections of air alone are
    // skipped (air counts for no heightmap). An unloaded column reads as air.
heightmap :: proc(self: ^Self, kind: Heightmap, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let world = self.w.world;
    // rust: if kind == Heightmap::WorldSurface {
    // rust: return self.w.world_surface(x, z);
}
    // rust: world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .and_then(|chunk| {
    // rust: chunk.highest(world.air.0, |y| {
    // rust: spawn_selection::heightmap_blocks(self, kind, x, y, z)
    // rust: })
    // rust: })
    // rust: .map_or(self.w.world.bottom_y(), |y| y + 1)
}
pathfindable_land :: proc(self: ^Self, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.data.state(self.state(x, y, z)).flags & data::LAND != 0
}
}
    // rust: impl horizon_client::mobs::spawner::SpawnerLevel for GameLevel<'_, '_> {
    // `Level.hasNearbyAlivePlayer`, over every player.
alive_player_near :: proc(self: ^Self, x: f64, y: f64, z: f64, range: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.players.iter().any(|p| p.alive_near(x, y, z, range))
}
spawner_blocks_work :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.ui.rules.bool("spawner_blocks_work")
}
entity_exists :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.res.mob_types().contains_key(id) || self.game.entity_type_exists(id)
}
count_entities :: proc(self: ^Self, id: string, bounds: Aabb) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mobs = self
    // rust: .mobs_near(bounds)
    // rust: .filter(|&(i, b, ..)| self.game.mobs[i].kind.id == id && b.intersects(bounds))
    // rust: .count();
    // rust: let pending = self
    // rust: .pending_ids
    // rust: .borrow()
    // rust: .iter()
    // rust: .filter(|(k, b)| k == id && b.intersects(bounds))
    // rust: .count();
    // rust: mobs + pending
}
}
// Every entity type with a spawn cost in some biome, each once.
spawn_cost_types :: proc(biomes: ^horizon_client::biome::Biomes) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut types: Vec<&str> = Vec::new();
    // rust: for t in biomes.list.iter().flat_map(|b| b.spawn_costs.keys()) {
    // rust: if !types.contains(&t.as_str()) {
    // rust: types.push(t);
}
}
    // rust: types
}
    // rust: impl<'a> Game<'a> {
    // rust: pub(super) fn natural_level(&self) -> GameLevel<'_, 'a> {
    // rust: let players = self.level_players();
    // rust: let nearest = players
    // rust: .iter()
    // rust: .filter(|p| !p.spectator)
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z])
    // rust: .collect();
    // rust: GameLevel {
    // rust: game: self,
    // rust: w: self.mob_world_base(&[]),
    // rust: players,
    // rust: nearest,
    // rust: pending: Default::default(),
    // rust: pending_ids: Default::default(),
    // rust: boxes: Default::default(),
    // rust: box_queries: Default::default(),
    // rust: costed: spawn_cost_types(world_biomes!(self)),
}
}
    // Creates a mob the spawner accepted, finalized the game's way; the
    // caller adds it with [`Game::add_spawned`].
finalize_spawned :: proc(self: ^Self, r: ^SpawnRequest, pending: ^[dynamic]Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = self.res.mob_types().get(r.entity)?.clone();
    // rust: let [x, y, z] = r.position;
    // rust: let mut mob = Mob::new(0, kind, Vec3::new(x, y, z), r.yaw);
    // rust: let facts = self.biome_facts(x.floor() as i32, y.floor() as i32, z.floor() as i32);
    // rust: let difficulty = self.local_difficulty(r.position);
    // rust: horizon_client::mobs::spawning::finalize(&mut mob, &facts, &difficulty);
    // rust: horizon_client::mobs::raider::finalize(
    // rust: &mut mob,
    // rust: horizon_client::mobs::raider::Reason::Natural,
    // rust: );
    // rust: let bounds = mob.bounds();
    // rust: pending.push(mob);
    // rust: Some(Spawned {
    // rust: bounds,
    // rust: school: true,
    // rust: })
}
    // Adds the mobs a spawn pass created: ids, enchanted gear and jockeys.
add_spawned :: proc(self: ^Self, pending: [dynamic]Mob, persistent: bool) {
}
    // rust: for mut mob in pending {
    // rust: self.next_entity += 1;
    // rust: mob.id = self.next_entity;
    // rust: mob.persistent = persistent;
    // rust: let id = mob.id;
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, true);
    // rust: self.enchant_spawn_equipment(id);
    // rust: self.halloween_spawn_head(id);
    // rust: if !persistent {
    // rust: self.spawn_jockeys(id, true);
}
}
}
    // Every player in the level in place: the local player, and the LAN
    // guests or server players in it.
    // rust: pub(super) fn level_players(&self) -> Vec<LevelPlayer> {
    // rust: self.level_players_iter().collect()
}
    // `level_players` one at a time, without collecting them.
level_players_iter :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let local = self.player_view().map(|p| LevelPlayer {
    // rust: uuid: self
    // rust: .level
    // rust: .player_uuid
    // rust: .map_or(0, horizon_client::lan::playerdata::ints_uuid),
    // rust: position: p.position,
    // rust: bounds: p.bounds,
    // rust: alive: p.alive,
    // rust: creative: p.creative,
    // rust: spectator: p.spectator,
    // rust: });
    // rust: let guests = self.lan.iter().flat_map(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| h.hub.here(g))
    // rust: .map(|g| LevelPlayer {
    // rust: uuid: g.uuid,
    // rust: position: Vec3::new(g.position[0], g.position[1], g.position[2]),
    // rust: bounds: super::lan_mobs::guest_bounds(g),
    // rust: alive: !g.dead,
    // rust: creative: g.creative(),
    // rust: spectator: g.spectator(),
    // rust: })
    // rust: });
    // rust: local.into_iter().chain(guests)
}
    // `Level.hasNearbyAlivePlayer` before a level is built for the spawn
    // code: what a spawner asks first, every tick.
    // rust: pub(super) fn alive_player_near(&self, x: f64, y: f64, z: f64, range: f64) -> bool {
    // rust: self.level_players_iter()
    // rust: .any(|p| p.alive_near(x, y, z, range))
}
    // `ChunkMap.collectSpawningChunks`: the natural spawn chunk tracker's
    // chunks (within 8 chunks of a player, `getSpawnCandidateChunks`) that
    // are ticking and within 128 blocks of a non-spectator. Also returns how
    // many chunks the tracker holds (`getNaturalSpawnChunkCount`).
    // rust: pub(super) fn spawning_chunks(
    // rust: &self,
    // rust: players: &[LevelPlayer],
    // rust: scratch: &mut SpawnScratch,
    // rust: ) -> i32 {
    // rust: let levels = self.tickets.levels();
    // rust: scratch.collect(players, |(cx, cz)| {
    // rust: levels.loaded_ticking(cx, cz) && super::ticking_chunk(&self.world, cx, cz)
    // rust: })
}
    // `ServerChunkCache.tickChunks`: the spawn state over the loaded mobs,
    // the categories under their global caps (creatures every 400 ticks),
    // then `tickSpawningChunk` in the shuffled spawning chunks of every
    // player: inhabited time, then `spawnForChunk`.
    // rust: pub(super) fn spawn_natural(&mut self) {
        // `tickChunks` does nothing in a Debug world.
    // rust: if self.world_debug {
    // rust: return;
}
    // rust: let mut laps = horizon_client::spans::laps();
    // rust: let players = self.level_players();
    // rust: if players.is_empty() {
    // rust: return;
}
    // rust: let mut scratch = std::mem::take(&mut self.spawn_scratch);
    // rust: let spawnable = self.spawning_chunks(&players, &mut scratch);
    // rust: laps.lap("sn_candidates");
    // rust: for &key in &scratch.candidates {
    // rust: *self.world.inhabited.entry(key).or_insert(0) += 1;
}
    // rust: laps.lap("sn_inhabited");
    // rust: let spawn_mobs = self.ui.rules.bool("spawn_mobs");
    // rust: let spawn_enemies = self.ui.rules.bool("spawn_monsters");
    // rust: let mut random = std::mem::replace(&mut self.world.random, LegacyRandom::new(0));
    // rust: let mut pending = Vec::new();
    // rust: let last_state;
    // rust: {
    // rust: let level = self.natural_level();
    // rust: laps.lap("sn_level");
    // rust: let counted: Vec<Counted> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| Counted {
    // rust: entity: &m.kind.id,
    // rust: category: Category::from_name(&m.kind.category),
    // rust: block: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ],
    // rust: is_mob: true,
    // rust: persistent: m.persistent
    // rust: || horizon_client::mobs::ai::requires_custom_persistence(m),
    // rust: })
    // rust: .collect();
    // rust: let players = players
    // rust: .iter()
    // rust: .map(|p| SpawnPlayer {
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: spectator: p.spectator,
    // rust: })
    // rust: .collect();
    // rust: laps.lap("sn_materialize");
    // rust: let mut state = SpawnState::new(&level, spawnable, players, &counted, |cx, cz| {
    // rust: self.world.chunks.contains_key(&(cx, cz))
    // rust: });
    // rust: laps.lap("sn_state");
    // rust: last_state = state.counts();
    // rust: let categories = if spawn_mobs {
    // rust: state.filtered_categories(spawn_enemies, self.world.game_time % 400 == 0)
    // rust: } else {
    // rust: Vec::new()
}
    // rust: laps.lap("sn_categories");
            // Util.shuffle.
    // rust: for i in (1..scratch.candidates.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32 + 1).unwrap_or(0) as usize;
    // rust: scratch.candidates.swap(i, j);
}
    // rust: laps.lap("sn_shuffle");
    // rust: spawn_selection::attempt_counters(false);
    // rust: if !categories.is_empty() {
    // rust: for chunk in scratch.candidates.drain(..) {
    // rust: let mut spawn = |l: &GameLevel, r: &SpawnRequest| {
    // rust: let spawned = l.game.finalize_spawned(r, &mut pending);
    // rust: if let Some(s) = &spawned {
    // rust: l.pending.borrow_mut().push(s.bounds);
}
    // rust: spawned
}
    // rust: spawn_selection::spawn_for_chunk(
    // rust: &level,
    // rust: &mut random,
    // rust: &mut state,
    // rust: &categories,
    // rust: chunk,
    // rust: &mut spawn,
    // rust: &mut |_| {},
    // rust: );
}
}
}
    // rust: spawn_selection::attempt_counters(true);
    // rust: laps.lap("sn_attempts");
    // rust: self.world.random = random;
        // ServerChunkCache.lastSpawnState, for the debug overlay.
    // rust: self.spawn_counts.insert(self.dim, last_state);
    // rust: self.add_spawned(pending, false);
    // rust: self.spawn_scratch = scratch;
    // rust: laps.lap("sn_finalize");
}
    // `NoiseBasedChunkGenerator.spawnOriginalMobs`: creature packs for a
    // freshly generated chunk, from the biome at its corner column's top,
    // with the chunk's decoration-seeded random, finalized with the
    // region's random as generation adds them (mobs are not generated in
    // the End).
    // rust: pub(super) fn spawn_generation_creatures(&mut self, cx: i32, cz: i32) {
    // rust: if !self.world.chunks.contains_key(&(cx, cz)) || self.dim == Dim::End {
    // rust: return;
}
    // rust: let Some(terrain) = self.end.locator() else {
    // rust: return;
}
        // `FlatLevelSource.spawnOriginalMobs` is empty: a superflat world places no packs.
    // rust: if terrain.is_flat() {
    // rust: return;
}
    // rust: let mut region = terrain.region_random(cx, cz);
    // rust: let any = region.as_any();
    // rust: let added = if let Some(r) = any.downcast_mut::<LegacyRandom>() {
    // rust: self.generation_creatures(cx, cz, &terrain, r)
    // rust: } else if let Some(r) = any.downcast_mut::<XoroshiroRandom>() {
    // rust: self.generation_creatures(cx, cz, &terrain, r)
    // rust: } else {
    // rust: return;
}
    // rust: for nbt in added {
    // rust: self.load_mob(Tag::Compound(nbt), None);
}
}
    // rust: fn generation_creatures<Q: RandomSource + 'static>(
    // rust: &self,
    // rust: cx: i32,
    // rust: cz: i32,
    // rust: terrain: &VanillaTerrain,
    // rust: region: &mut Q,
    // rust: ) -> Vec<Compound> {
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_decoration_seed(self.level.seed, cx * 16, cz * 16);
    // rust: let mut added = Vec::new();
    // rust: let mut group = None;
    // rust: let level = self.natural_level();
    // rust: let source = [cx * 16, level.max_y(), cz * 16];
    // rust: let mut spawn = |l: &GameLevel, r: &SpawnRequest, region: &mut Q| {
            // Each pack starts without group data.
    // rust: if r.group_index == 0 {
    // rust: group = None;
}
    // rust: let [x, y, z] = r.position;
    // rust: let (bx, by, bz) = (x.floor() as i32, y.floor() as i32, z.floor() as i32);
    // rust: let biome = l.zoomed_biome(bx, by, bz).map_or("", |b| b.name.as_str());
    // rust: let at = Vec3::new(x, y, z);
    // rust: match terrain.spawn_generated(r.entity, at, r.yaw, biome, region, &mut group) {
    // rust: Some(nbt) => {
    // rust: added.push(nbt);
    // rust: true
}
    // rust: None => false,
}
}
    // rust: spawn_selection::spawn_mobs_for_chunk_generation(
    // rust: &level,
    // rust: source,
    // rust: (cx, cz),
    // rust: &mut random,
    // rust: region,
    // rust: &mut spawn,
    // rust: &mut |_| {},
    // rust: );
    // rust: added
}
}

    // rust: mod tests {
//     use super::*;

player :: proc(x: f64, y: f64, z: f64, spectator: bool) -> L {
    // Ported from Horizon
    return {}
}
    // rust: LevelPlayer {
    // rust: uuid: 0,
    // rust: position: Vec3::new(x, y, z),
    // rust: bounds: Aabb::new(Vec3::new(x, y, z), Vec3::new(x, y, z)),
    // rust: alive: true,
    // rust: creative: false,
    // rust: spectator,
}
}

    // The candidates as the uncached port collected them every tick: each
    // player's square in dx/dz order into one ordered set, close to any
    // player that holds the chunk. Returns the set's size too.
uncached_candidates :: proc(players: ^[LevelPlayer]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut order = Vec::new();
    // rust: let mut close = Vec::new();
    // rust: let mut seen = HashMap::new();
    // rust: for p in players {
    // rust: let (pcx, pcz) = SpawnScratch::chunk(p);
    // rust: for dx in -8..=8 {
    // rust: for dz in -8..=8 {
    // rust: let key = (pcx + dx, pcz + dz);
    // rust: let i = *seen.entry(key).or_insert_with(|| {
    // rust: order.push(key);
    // rust: close.push(false);
    // rust: order.len() - 1
    // rust: });
    // rust: close[i] |= close_enough_for_spawning(p, key);
}
}
}
    // rust: let kept = order.iter().zip(&close).filter(|c| *c.1).map(|c| *c.0);
    // rust: (order.len() as i32, kept.collect())
}

spawn_candidates_keep_order_and_live_proximity_across_cache_hits :: proc() {
}
    // rust: let mut players = vec![
    // rust: player(0.0, 64.0, 0.0, false),
    // rust: player(16.0, 64.0, 0.0, false),
    // rust: ];
    // rust: let mut scratch = SpawnScratch::default();
        // Two adjacent 17x17 squares: the first square, then the new east edge.
    // rust: assert_eq!(scratch.collect(&players, |_| true), 306);
    // rust: assert!(scratch.candidates.contains(&(-8, 0)));
        // Spawning consumes the working list; the next pass must not care.
    // rust: scratch.candidates.reverse();
    // rust: scratch.candidates.truncate(3);
        // Moving inside its chunk takes player 0 out of range of the west edge.
    // rust: players[0].position.x = 15.5;
    // rust: assert_eq!(scratch.collect(&players, |_| true), 306);
    // rust: assert!(!scratch.candidates.contains(&(-8, 0)));
    // rust: assert_eq!(scratch.candidates, uncached_candidates(&players).1);
        // Nothing is close to spectators, though the squares still count.
    // rust: for p in &mut players {
    // rust: p.spectator = true;
}
    // rust: assert_eq!(scratch.collect(&players, |_| true), 306);
    // rust: assert!(scratch.candidates.is_empty());
    // rust: for p in &mut players {
    // rust: p.spectator = false;
}
        // Player 1 near its chunk's east side reaches the middle of chunk 9.
    // rust: players[1].position.x = 31.9;
    // rust: assert_eq!(scratch.collect(&players, |_| true), 306);
    // rust: assert!(scratch.candidates.contains(&(9, 0)));
    // rust: assert_eq!(scratch.candidates, uncached_candidates(&players).1);
        // `keep` filters without reordering.
    // rust: scratch.collect(&players, |(x, z)| x == z);
    // rust: let diagonal: Vec<_> = uncached_candidates(&players)
    // rust: .1
    // rust: .into_iter()
    // rust: .filter(|&(x, z)| x == z)
    // rust: .collect();
    // rust: assert!(diagonal.len() > 1);
    // rust: assert_eq!(scratch.candidates, diagonal);
}

    // Players walking, crossing borders, meeting, splitting, joining, leaving
    // and swapping order: every pass matches the uncached collection.
spawn_candidates_match_the_uncached_union_while_players_move :: proc() {
}
    // rust: let mut seed = 0x5DEECE66Du64;
    // rust: let mut next = move |bound: u64| {
    // rust: seed = seed
    // rust: .wrapping_mul(6364136223846793005)
    // rust: .wrapping_add(1442695040888963407);
    // rust: (seed >> 33) % bound
}
    // rust: let mut players: Vec<LevelPlayer> = [0.0, 40.0, 300.0, 1200.0, -500.0]
    // rust: .iter()
    // rust: .map(|&x| player(x, 64.0, x / 2.0, false))
    // rust: .collect();
    // rust: let mut scratch = SpawnScratch::default();
    // rust: for step in 0..3000 {
    // rust: match next(40) {
    // rust: 0 if players.len() < 8 => {
    // rust: let x = next(1200) as f64 - 600.0;
    // rust: let at = next(players.len() as u64 + 1) as usize;
    // rust: players.insert(at, player(x, 64.0, -x, false));
}
    // rust: 1 if players.len() > 1 => {
    // rust: players.remove(next(players.len() as u64) as usize);
}
    // rust: 2 if players.len() > 1 => {
    // rust: let i = next(players.len() as u64 - 1) as usize;
    // rust: players.swap(i, i + 1);
}
    // rust: 3 => {
    // rust: let i = next(players.len() as u64) as usize;
    // rust: players[i].spectator = !players[i].spectator;
}
    // rust: 4 => {
                    // Teleport onto another player: identical squares.
    // rust: let (i, j) = (next(players.len() as u64), next(players.len() as u64));
    // rust: players[i as usize].position = players[j as usize].position;
}
    // rust: _ => {
    // rust: for p in &mut players {
    // rust: p.position.x += next(13) as f64 - 6.0 + 0.37;
    // rust: p.position.z += next(13) as f64 - 6.0 - 0.21;
}
}
}
    // rust: let (count, expected) = uncached_candidates(&players);
    // rust: assert_eq!(scratch.collect(&players, |_| true), count, "step {step}");
    // rust: assert_eq!(scratch.candidates, expected, "step {step}");
}
}

    // The grid finds the same player a look at every one finds, the first of
    // two at the same distance included, and never a spectator.
nearest_players_find_what_a_scan_finds :: proc() {
}
    // rust: let mut seed = 0x9E37_79B9_7F4A_7C15u64;
    // rust: let mut next = |m: f64| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed % 1_000_000) as f64 / 1_000_000.0 * 2.0 * m - m
}
    // rust: let mut players: Vec<LevelPlayer> = (0..150)
    // rust: .map(|i| player(next(3_000.0), 64.0 + next(60.0), next(3_000.0), i % 11 == 0))
    // rust: .collect();
        // Two at the same distance from the origin, the second one first in no cell order.
    // rust: players.push(player(300.0, 64.0, 0.0, false));
    // rust: players.push(player(-300.0, 64.0, 0.0, false));
    // rust: players.push(player(0.0, 64.0, 300.0, false));
    // rust: let grid = NearestPlayers::new(&players);
    // rust: let index = |p: Option<&LevelPlayer>| p.map(|p| std::ptr::from_ref(p) as usize);
    // rust: let mut probes: Vec<(f64, f64, f64)> = (0..400)
    // rust: .map(|_| (next(3_000.0), next(100.0), next(3_000.0)))
    // rust: .collect();
    // rust: probes.extend([(0.0, 64.0, 0.0), (1.0e12, 0.0, 0.0), (f64::NAN, 0.0, 0.0)]);
    // rust: for (x, y, z) in probes {
    // rust: assert_eq!(
    // rust: index(grid.nearest(x, y, z)),
    // rust: index(nearest_player(&players, x, y, z)),
    // rust: "({x}, {y}, {z})"
    // rust: );
}
    // rust: players.push(player(NearestPlayers::FAR * 2.0, 64.0, 0.0, false));
    // rust: let grid = NearestPlayers::new(&players);
    // rust: assert!(grid.scan);
    // rust: for x in [0.0, NearestPlayers::FAR * 2.0] {
    // rust: assert_eq!(
    // rust: index(grid.nearest(x, 64.0, 0.0)),
    // rust: index(nearest_player(&players, x, 64.0, 0.0))
    // rust: );
}
    // rust: let spectators: Vec<LevelPlayer> = (0..20)
    // rust: .map(|i| player(f64::from(i) * 100.0, 0.0, 0.0, true))
    // rust: .collect();
    // rust: assert!(
    // rust: NearestPlayers::new(&spectators)
    // rust: .nearest(0.0, 0.0, 0.0)
    // rust: .is_none()
    // rust: );
}
}
