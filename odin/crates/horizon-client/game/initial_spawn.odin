//! Transpiled from Horizon Rust crate
package horizon_client_initial_spawn

import "core:fmt"
import "core:mem"
import "core:math"

// A new world's spawn and its first player's position: MinecraftServer.
// setInitialSpawn walks a chunk spiral around NoiseBasedChunkGenerator.
// getOrigin, then PlayerSpawnFinder.findSpawn picks a free column around
// the world spawn within the respawn radius.
// use super::{Game, dispenser::entity_random};
// use horizon_client::{
    // rust: Result,
    // rust: assets::Properties,
    // rust: collisions::{SceneCollisions, no_collision_or_liquid},
    // rust: world::World,
    // rust: world_spawn::{
    // rust: PlayerSpawnFinder, SpawnCandidate, SpawnLevel, level_respawn_pos, spawn_pos_in_chunk,
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry, collision_context::CollisionContext,
    // rust: heightmap::HeightmapType, level::flags::UPDATE_CLIENTS, registry::BlockStateId,
    // rust: worldgen::terrain::TerrainBlockStates,
}

// The loaded world as the spawn searches query it.
Columns :: struct {
    world: ^'a World,
    properties: ^'a Properties,
    binding: ^'a BlockCollisionRegistry<'r>,
    has_ceiling: bool,
    // `ChunkGenerator.getSpawnHeight` (64 for the vanilla generators).
    spawn_height: i32,
}
    // rust: impl SpawnLevel for Columns<'_, '_> {
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.world.bottom_y()
}
height :: proc(self: ^Self, kind: HeightmapType, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.world.bottom_y()..self.world.top_y())
    // rust: .rev()
    // rust: .find(|&y| kind.is_opaque(self.properties.heightmap_state(self.world.block(x, y, z))))
    // rust: .map_or(self.world.bottom_y(), |y| y + 1)
}
has_fluid :: proc(self: ^Self, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
//         use horizon_world::heightmap::HeightmapState;
    // rust: self.properties
    // rust: .heightmap_state(self.world.block(x, y, z))
    // rust: .has_fluid()
}
top_face_full :: proc(self: ^Self, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.world,
    // rust: binding: self.binding,
    // rust: subject: None,
}
    // rust: let state = self.world.block(x, y, z);
    // rust: let Ok(shape) = self.binding.collision_shape_with_context(
    // rust: &mut scene,
    // rust: state,
    // rust: BlockPos::new(x, y, z),
    // rust: &CollisionContext::empty(false),
    // rust: ) else {
    // rust: return false;
}
    // rust: shape.face_shape(Direction::Up).is_ok_and(|face| {
    // rust: VoxelShape::block()
    // rust: .join_is_not_empty(&face, ShapeOp::XOR)
    // rust: .is_ok_and(|differs| !differs)
    // rust: })
}
has_ceiling :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_ceiling
}
spawn_height :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.spawn_height
}
}

    // rust: impl Game<'_> {
spawn_columns :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Columns {
    // rust: world: &self.world,
    // rust: properties: &self.pack.assets.properties,
    // rust: binding: self.collision,
            // The spawn searches are the overworld's (PlayerSpawnFinder); a
            // ceiling starts them at the generator's spawn height.
    // rust: has_ceiling: self.level_shapes.overworld.has_ceiling,
    // rust: spawn_height: self.spawn_origin.map_or(64, |(_, height)| height),
}
}
    // ChunkGenerator.getOrigin and getSpawnHeight of the overworld.
spawn_origin :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(flat) =
    // rust: horizon_client::save::world_gen_settings(&self.world_root).and_then(|s| {
    // rust: horizon_client::flatgen::FlatTerrain::from_settings(
    // rust: &s,
    // rust: self.pack.assets.registry,
    // rust: world_biomes!(self),
    // rust: self.level_shapes.overworld,
    // rust: )
    // rust: })
    // rust: {
    // rust: return Ok(((0, 0), flat.spawn_height()));
}
    // rust: if self.options.test_terrain {
    // rust: return Ok(((0, 0), 64));
}
    // rust: let origin = match self.end.locator() {
    // rust: Some(terrain) => terrain.origin()?,
    // rust: None => horizon_core::position::ChunkPos::new(0, 0),
}
    // rust: Ok(((origin.x, origin.z), 64))
}
    // MinecraftServer.setInitialSpawn: the first chunk of the spiral with a
    // valid respawn column gives the world spawn, else the origin chunk's
    // centre at the spawn height. None while a chunk to test is loading.
    // rust: pub(super) fn find_world_spawn(&mut self) -> Result<Option<[i32; 3]>> {
    // rust: let ((ox, oz), height) = match self.spawn_origin {
    // rust: Some(origin) => origin,
    // rust: None => *self.spawn_origin.insert(self.spawn_origin()?),
}
    // rust: while let Some((dx, dz)) = self.spawn_spiral.current() {
    // rust: if self.spawn_spiral.tested() {
    // rust: let (cx, cz) = (ox + dx, oz + dz);
    // rust: if self.standalone_server() {
                    // getChunk(FULL) of the tested chunk alone: its 3x3 is decorated.
    // rust: if !self.world.chunks.contains_key(&(cx, cz)) {
    // rust: let area = [((cx, cz), -1)];
    // rust: if self.streaming.extra != area {
    // rust: self.streaming.extra = area.to_vec();
    // rust: self.streaming.rank_full_task(cx, cz);
}
    // rust: return Ok(None);
}
    // rust: } else if !self.streaming.is_lit(cx, cz) {
    // rust: self.streaming.center = (cx, cz);
    // rust: return Ok(None);
}
    // rust: if let Some(pos) = spawn_pos_in_chunk(&self.spawn_columns(), cx, cz) {
    // rust: return Ok(Some(pos));
}
}
    // rust: self.spawn_spiral.advance();
}
    // rust: Ok(Some([ox * 16 + 8, height, oz * 16 + 8]))
}
    // MinecraftServer.setInitialSpawn's bonus chest: BonusChestFeature.place
    // in the spawn chunk, a chest with the spawn bonus loot and a torch on
    // each side that can hold one, on the first free column of a shuffled
    // walk over the chunk. Skipped while the chunk is not loaded.
    // rust: pub(super) fn place_bonus_chest(&mut self, origin: [i32; 3]) -> Result<()> {
//         use horizon_client::containers::BlockEntity;
    // rust: let (cx, cz) = (origin[0] >> 4, origin[2] >> 4);
    // rust: let registry = &self.pack.assets.registry;
    // rust: let (Some(chest), Some(torch)) = (
    // rust: registry.default_state("minecraft:chest"),
    // rust: registry.default_state("minecraft:torch"),
    // rust: ) else {
    // rust: return Ok(());
}
    // rust: if !self.streaming.is_lit(cx, cz) {
    // rust: return Ok(());
}
        // `level.getRandom()`. Util.toShuffledList of the chunk's x and z.
    // rust: let random = &mut self.world.random;
    // rust: let mut shuffled = |min: i32| -> [i32; 16] {
    // rust: let mut values: [i32; 16] = std::array::from_fn(|i| min + i as i32);
    // rust: for end in (2..=16usize).rev() {
    // rust: let other = random.next_int_bound(end as i32).unwrap_or(0) as usize;
    // rust: values.swap(end - 1, other);
}
    // rust: values
}
    // rust: let (xs, zs) = (shuffled(cx * 16), shuffled(cz * 16));
    // rust: for x in xs {
    // rust: for z in zs {
    // rust: let y = self
    // rust: .spawn_columns()
    // rust: .height(HeightmapType::MotionBlockingNoLeaves, x, z);
    // rust: if self.world.block(x, y, z) != self.world.air && !self.collision_empty([x, y, z]) {
    // rust: continue;
}
    // rust: self.set_block_clients([x, y, z], chest)?;
    // rust: let seed = self.world.random.next_long();
    // rust: self.world
    // rust: .block_entities
    // rust: .insert((x, y, z), BlockEntity::Chest(Vec::new()));
    // rust: self.load_block_entity_nbt(
    // rust: [x, y, z],
    // rust: &format!(
    // rust: "{{LootTable:\"minecraft:chests/spawn_bonus_chest\",LootTableSeed:{seed}L}}"
    // rust: ),
    // rust: );
    // rust: for [dx, dz] in [[0, -1], [1, 0], [0, 1], [-1, 0]] {
    // rust: let at = [x + dx, y, z + dz];
    // rust: let survives = self.with_level(|b, level, ticks| {
    // rust: b.can_survive(level, ticks, BlockPos::new(at[0], at[1], at[2]), torch)
    // rust: });
    // rust: if survives {
    // rust: self.set_block_clients(at, torch)?;
}
}
    // rust: return Ok(());
}
}
    // rust: Ok(())
}
    // `Level.setBlock(pos, state, UPDATE_CLIENTS)`: no neighbour updates.
set_block_clients :: proc(self: ^Self, pos: [i32; 3], state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(
    // rust: level,
    // rust: ticks,
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: state,
    // rust: UPDATE_CLIENTS,
    // rust: );
    // rust: });
    // rust: self.process_level_events()
}
    // The block at `pos` has no collision shape.
    // rust: pub(super) fn collision_empty(&self, pos: [i32; 3]) -> bool {
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: self.collision
    // rust: .collision_shape_with_context(
    // rust: &mut scene,
    // rust: self.world.block(pos[0], pos[1], pos[2]),
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: &CollisionContext::empty(false),
    // rust: )
    // rust: .is_ok_and(|shape| shape.is_empty())
}
    // PlayerSpawnFinder.findSpawn around the world spawn, as far as the loaded
    // chunks allow: the feet of the first free column within the respawn
    // radius, else the suggestion's own column. The finder waits in `state`
    // (None to begin); Err gives the chunk of the candidate being waited for,
    // which the caller must have loaded (the finder tries at most 1024
    // columns).
    // rust: pub(super) fn search_spawn(
    // rust: &self,
    // rust: suggestion: [i32; 3],
    // rust: state: &mut Option<PlayerSpawnFinder>,
    // rust: ) -> std::result::Result<Vec3, (i32, i32)> {
    // rust: let mut finder = state
    // rust: .take()
    // rust: .unwrap_or_else(|| self.spawn_finder(suggestion));
    // rust: let suggestion = finder.suggestion;
    // rust: loop {
    // rust: let Some(candidate) = finder.next_candidate() else {
    // rust: return Ok(self.fixup_spawn_height(suggestion));
}
    // rust: let (x, z) = match candidate {
    // rust: SpawnCandidate::Column(x, z) => (x, z),
    // rust: SpawnCandidate::Suggestion => (suggestion[0], suggestion[2]),
}
    // rust: if !self.streaming.is_lit(x >> 4, z >> 4) {
    // rust: finder.retry();
    // rust: *state = Some(finder);
    // rust: return Err((x >> 4, z >> 4));
}
    // rust: match candidate {
    // rust: SpawnCandidate::Column(x, z) => {
    // rust: if let Some(pos) = level_respawn_pos(&self.spawn_columns(), x, z)
    // rust: && self.player_fits(pos)
    // rust: {
    // rust: return Ok(bottom_center(pos));
}
}
    // rust: SpawnCandidate::Suggestion => return Ok(self.fixup_spawn_height(suggestion)),
}
}
}
    // PlayerSpawnFinder.findSpawn around the world spawn: the feet of a
    // player who has no position yet. None while a candidate's chunk loads.
    // rust: pub(super) fn find_player_spawn(&mut self, suggestion: [i32; 3]) -> Result<Option<Vec3>> {
    // rust: let mut state = self.player_spawn.take();
    // rust: match self.search_spawn(suggestion, &mut state) {
    // rust: Ok(feet) => Ok(Some(feet)),
    // rust: Err(chunk) => {
    // rust: self.streaming.center = chunk;
    // rust: self.player_spawn = state;
    // rust: Ok(None)
}
}
}
    // A new PlayerSpawnFinder around `suggestion`: the respawn radius, cut
    // by the world border; the suggestion itself in adventure mode.
spawn_finder :: proc(self: ^Self, suggestion: [i32; 3]) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if self.level.game_mode == 2 {
    // rust: let mut finder = PlayerSpawnFinder::new(suggestion, 0, |_| 0);
    // rust: finder.next_candidate();
    // rust: return finder;
}
    // rust: let mut radius = self.ui.rules.int("respawn_radius").max(0);
    // rust: let to_border = self
    // rust: .border
    // rust: .distance(f64::from(suggestion[0]), f64::from(suggestion[2]))
    // rust: .floor() as i32;
    // rust: if to_border < radius {
    // rust: radius = to_border;
}
    // rust: if to_border <= 1 {
    // rust: radius = 1;
}
    // rust: PlayerSpawnFinder::new(suggestion, radius, |n| {
    // rust: entity_random().next_int_bound(n).unwrap_or(0)
    // rust: })
}
    // ServerPlayer.adjustSpawnLocation for a server's new player: where
    // PlayerSpawnFinder.findSpawn puts their feet around the world spawn
    // (`spawn`, the feet there), so that players new to a world don't all
    // stand in one spot. Vanilla waits for each candidate's chunk; a server
    // tick can't, so a candidate in a chunk not loaded yet is passed over,
    // and `spawn` stays when the search never reaches a loaded column.
    // rust: pub(super) fn server_player_spawn(&self, spawn: [f64; 3]) -> [f64; 3] {
    // rust: let suggestion = spawn.map(|v| v.floor() as i32);
    // rust: let mut finder = self.spawn_finder(suggestion);
    // rust: while let Some(candidate) = finder.next_candidate() {
    // rust: let (x, z) = match candidate {
    // rust: SpawnCandidate::Column(x, z) => (x, z),
    // rust: SpawnCandidate::Suggestion => (suggestion[0], suggestion[2]),
}
    // rust: if !self.streaming.is_lit(x >> 4, z >> 4) {
    // rust: continue;
}
    // rust: let feet = match candidate {
    // rust: SpawnCandidate::Column(x, z) => level_respawn_pos(&self.spawn_columns(), x, z)
    // rust: .filter(|&pos| self.player_fits(pos))
    // rust: .map(bottom_center),
    // rust: SpawnCandidate::Suggestion => Some(self.fixup_spawn_height(suggestion)),
}
    // rust: if let Some(feet) = feet {
    // rust: return [feet.x, feet.y, feet.z];
}
}
    // rust: spawn
}
    // PlayerSpawnFinder.noCollisionNoLiquid: a player's box standing at the
    // block's bottom centre touches no block or liquid.
player_fits :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let feet = bottom_center(pos);
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(feet.x - 0.3, feet.y, feet.z - 0.3),
    // rust: Vec3::new(feet.x + 0.3, feet.y + 1.8, feet.z + 0.3),
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: no_collision_or_liquid(&mut scene, bounds)
}
    // PlayerSpawnFinder.fixupSpawnHeight: up out of anything solid, then
    // down onto the ground.
fixup_spawn_height :: proc(self: ^Self, pos: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let [x, mut y, z] = pos;
    // rust: while !self.player_fits([x, y, z]) && y < self.world.top_y() - 1 {
    // rust: y += 1;
}
    // rust: y -= 1;
    // rust: while self.player_fits([x, y, z]) && y > self.world.bottom_y() {
    // rust: y -= 1;
}
    // rust: bottom_center([x, y + 1, z])
}
}

// Vec3.atBottomCenterOf.
bottom_center :: proc(pos: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: )
}
