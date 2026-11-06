//! Transpiled from Horizon Rust crate
package horizon_world_growth

import "core:fmt"
import "core:mem"
import "core:math"

// Feature-placing growth: `TreeGrower.growTree` (saplings, mangrove
// propagules, azaleas), huge mushrooms and nether fungi, run on the live level
// through [`LiveFeatures`].
// use super::{Behaviours, LevelAccess, LevelEvent, Sim, feature_world::LevelFeatureWorld, flags};
// use crate::{registry::BlockStateId, worldgen::live::LiveFeatures};
// use horizon_core::{position::BlockPos, random::RandomSource};
// use std::sync::{Arc, OnceLock};

// Runtime extensions of [`Behaviours`] that depend on the worldgen bundle.
Growth :: struct {
    features: OnceLock<^LiveFeatures>,
}

    // rust: impl Behaviours {
    // Install the live feature registry used by sapling growth and bone meal.
    // Without it, saplings report [`LevelEvent::GrowTree`] instead of growing.
set_live_features :: proc(self: ^Self, features: ^LiveFeatures) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.growth.features.set(features).is_ok()
}
live_features :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.growth.features.get()
}
    // `JigsawPlacement.generateJigsaw`: `assemble` builds the pieces (from
    // the generation context's own random), then each piece is placed into
    // the level with the level random, an unbounded box and `reference` as
    // the origin; `keep_jigsaws` skips the jigsaw replacement. Returns whether pieces were assembled
    // and the entities the pieces carried (their NBT, for the caller to spawn).
    // rust: pub fn place_jigsaw<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut super::Ticks,
    // rust: reference: [i32; 3],
    // rust: keep_jigsaws: bool,
    // rust: assemble: impl FnOnce() -> Option<crate::worldgen::generator::JigsawPieces>,
    // rust: ) -> (bool, Vec<crate::nbt::Compound>) {
    // rust: let Some(features) = self.live_features() else {
    // rust: return (false, Vec::new());
}
    // rust: let Some(jigsaw) = assemble() else {
    // rust: return (false, Vec::new());
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let mut random = sim.random().clone();
    // rust: let entities = {
    // rust: let mut world = LevelFeatureWorld {
    // rust: sim: &mut sim,
    // rust: features,
    // rust: entities: Vec::new(),
}
    // rust: let unbounded =
    // rust: crate::worldgen::structure::BoundingBox::new([i32::MIN; 3], [i32::MAX; 3]);
    // rust: for piece in &jigsaw.pieces {
    // rust: let mut place_feature =
    // rust: |w: &mut LevelFeatureWorld<'_, '_, L>,
    // rust: r: &mut horizon_core::random::LegacyRandom,
    // rust: name: &str,
    // rust: p: [i32; 3]| { Ok(features.place_placed(name, w, r, p)) };
    // rust: if let Err(e) = piece.place(
    // rust: &mut world,
    // rust: &jigsaw.resources,
    // rust: &mut random,
    // rust: unbounded,
    // rust: reference,
    // rust: keep_jigsaws,
    // rust: &mut place_feature,
    // rust: ) {
    // rust: eprintln!("Horizon: placing a jigsaw piece failed: {e}");
}
}
    // rust: world.entities
}
    // rust: *sim.random() = random;
    // rust: (true, entities)
}
    // `/place structure`: `PlaceCommand.placeStructure` after the start is
    // generated, `StructureStart.placeInChunk` for every chunk of the start's
    // bounding box (`ChunkPos.rangeClosed` of its corners), each clipped to
    // the chunk's whole height, drawing from the level random. False when the
    // level has no structure resources, or a piece failed to place. The
    // entities the pieces carried (villagers, guardians, template entities)
    // come back as NBT for the caller to spawn.
    // rust: pub fn place_structure<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut super::Ticks,
    // rust: start: &crate::worldgen::structure::start::StructureStart,
    // rust: ) -> (bool, Vec<crate::nbt::Compound>) {
    // rust: let Some(features) = self.live_features() else {
    // rust: return (false, Vec::new());
}
    // rust: let (Some(resources), Some(blocks)) = (features.structures(), features.tree_blocks())
    // rust: else {
    // rust: return (false, Vec::new());
}
    // rust: let (min, max) = (start.bounding_box.min, start.bounding_box.max);
    // rust: let (cx0, cx1) = (min[0] >> 4, max[0] >> 4);
    // rust: let (cz0, cz1) = (min[2] >> 4, max[2] >> 4);
    // rust: let mut sim = self.sim(level, ticks);
        // PlaceCommand's per-chunk clip box: BoundingBox(minX, getMinY(), minZ,
        // maxX, getMaxY() + 1, maxZ), the level's whole height of the chunk
        // (`max_y` is exclusive here, so the top layer is `max_y - 1`).
    // rust: let (low_y, high_y) = (sim.level.min_y(), sim.level.max_y() - 1);
    // rust: let mut random = sim.random().clone();
    // rust: let mut placed = true;
    // rust: let entities = {
    // rust: let mut world = LevelFeatureWorld {
    // rust: sim: &mut sim,
    // rust: features,
    // rust: entities: Vec::new(),
}
    // rust: let mut place_feature =
    // rust: |w: &mut LevelFeatureWorld<'_, '_, L>,
    // rust: r: &mut horizon_core::random::LegacyRandom,
    // rust: name: &str,
    // rust: p: [i32; 3]| { Ok(features.place_placed(name, w, r, p)) };
    // rust: for cx in cx0..=cx1 {
    // rust: for cz in cz0..=cz1 {
    // rust: let chunk_box = crate::worldgen::structure::BoundingBox::new(
    // rust: [cx * 16, low_y, cz * 16],
    // rust: [cx * 16 + 15, high_y, cz * 16 + 15],
    // rust: );
    // rust: if crate::worldgen::structure::start::place_in_chunk(
    // rust: start,
    // rust: &mut world,
    // rust: resources,
    // rust: &blocks,
    // rust: &mut random,
    // rust: chunk_box,
    // rust: &mut place_feature,
    // rust: )
    // rust: .is_err()
    // rust: {
    // rust: placed = false;
}
}
}
    // rust: world.entities
}
    // rust: *sim.random() = random;
    // rust: (placed, entities)
}
}

// The four (state, position) pairs of a 2x2 sapling square.
    // rust: type Saplings = [(BlockStateId, BlockPos); 4];

// `TreeGrower` (vanilla's registered growers, by name).
    // rust: pub(crate) struct TreeGrower {
    // rust: pub name: &'static str,
    // rust: trees: &'static [(&'static str, i32)],
    // rust: mega_trees: &'static [(&'static str, i32)],
    // rust: flower_trees: &'static [(&'static str, i32)],
    // rust: shortest: Option<&'static str>,
}

    // rust: pub(crate) const GROWERS: &[TreeGrower] = &[
    // rust: TreeGrower {
    // rust: name: "oak",
    // rust: trees: &[("minecraft:oak", 9), ("minecraft:fancy_oak", 1)],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[
    // rust: ("minecraft:oak_bees_005", 9),
    // rust: ("minecraft:fancy_oak_bees_005", 1),
    // rust: ],
    // rust: shortest: Some("minecraft:oak"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "spruce",
    // rust: trees: &[("minecraft:spruce", 1)],
    // rust: mega_trees: &[("minecraft:mega_spruce", 1), ("minecraft:mega_pine", 1)],
    // rust: flower_trees: &[],
    // rust: shortest: Some("minecraft:spruce"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "mangrove",
    // rust: trees: &[("minecraft:mangrove", 15), ("minecraft:tall_mangrove", 85)],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[],
    // rust: shortest: Some("minecraft:mangrove"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "azalea",
    // rust: trees: &[("minecraft:azalea_tree", 1)],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[],
    // rust: shortest: Some("minecraft:azalea_tree"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "birch",
    // rust: trees: &[("minecraft:birch", 1)],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[("minecraft:birch_bees_005", 1)],
    // rust: shortest: Some("minecraft:birch"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "jungle",
    // rust: trees: &[("minecraft:jungle_tree_no_vine", 1)],
    // rust: mega_trees: &[("minecraft:mega_jungle_tree", 1)],
    // rust: flower_trees: &[],
    // rust: shortest: Some("minecraft:jungle_tree_no_vine"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "acacia",
    // rust: trees: &[("minecraft:acacia", 1)],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[],
    // rust: shortest: Some("minecraft:acacia"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "cherry",
    // rust: trees: &[("minecraft:cherry", 1)],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[("minecraft:cherry_bees_005", 1)],
    // rust: shortest: Some("minecraft:cherry"),
    // rust: },
    // rust: TreeGrower {
    // rust: name: "dark_oak",
    // rust: trees: &[],
    // rust: mega_trees: &[("minecraft:dark_oak", 1)],
    // rust: flower_trees: &[],
    // rust: shortest: None,
    // rust: },
    // rust: TreeGrower {
    // rust: name: "pale_oak",
    // rust: trees: &[],
    // rust: mega_trees: &[("minecraft:pale_oak_bonemeal", 1)],
    // rust: flower_trees: &[],
    // rust: shortest: None,
    // rust: },
    // rust: TreeGrower {
    // rust: name: "poplar",
    // rust: trees: &[
    // rust: ("minecraft:red_poplar", 1),
    // rust: ("minecraft:orange_poplar", 1),
    // rust: ("minecraft:yellow_poplar", 1),
    // rust: ],
    // rust: mega_trees: &[],
    // rust: flower_trees: &[],
    // rust: shortest: Some("minecraft:red_poplar"),
    // rust: },
    // rust: ];

    // rust: pub(crate) fn grower(name: &str) -> Option<&'static TreeGrower> {
    // rust: GROWERS.iter().find(|g| g.name == name)
}

// `WeightedList.getRandom`: no draw for an empty list.
    // rust: fn weighted<R: RandomSource>(
    // rust: list: &'static [(&'static str, i32)],
    // rust: random: &mut R,
    // rust: ) -> Option<&'static str> {
    // rust: let total: i32 = list.iter().map(|e| e.1).sum();
    // rust: if total == 0 {
    // rust: return None;
}
    // rust: let mut selection = random.next_int_bound(total).unwrap_or(0);
    // rust: for &(name, weight) in list {
    // rust: if selection < weight {
    // rust: return Some(name);
}
    // rust: selection -= weight;
}
    // rust: None
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // `ConfiguredFeature.place(level, generator, level.random, pos)`. The
    // feature draws from a copy of the level random that replaces it after.
    // rust: pub(crate) fn place_configured_feature(&mut self, name: &str, pos: BlockPos) -> bool {
    // rust: let b = self.b;
    // rust: let Some(features) = b.live_features() else {
    // rust: return false;
}
    // rust: let mut random = self.random().clone();
    // rust: let placed = {
    // rust: let mut world = LevelFeatureWorld {
    // rust: sim: self,
    // rust: features,
    // rust: entities: Vec::new(),
}
    // rust: features.place_configured(name, &mut world, &mut random, [pos.x, pos.y, pos.z])
}
    // rust: *self.random() = random;
    // rust: placed
}
    // `PlacedFeature.place(level, generator, level.random, pos)`.
    // rust: pub(crate) fn place_placed_feature(&mut self, name: &str, pos: BlockPos) -> bool {
    // rust: let b = self.b;
    // rust: let Some(features) = b.live_features() else {
    // rust: return false;
}
    // rust: let mut random = self.random().clone();
    // rust: let placed = {
    // rust: let mut world = LevelFeatureWorld {
    // rust: sim: self,
    // rust: features,
    // rust: entities: Vec::new(),
}
    // rust: features.place_placed(name, &mut world, &mut random, [pos.x, pos.y, pos.z])
}
    // rust: *self.random() = random;
    // rust: placed
}
feature_exists :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b
    // rust: .live_features()
    // rust: .is_some_and(|f| f.configured(name).is_some())
}

    // `TreeGrower.hasFlowers`: a flower within 2 blocks horizontally, 1 vertically.
tree_has_flowers :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let Some(flowers) = b.tag("minecraft:flowers") else {
    // rust: return false;
}
    // rust: for y in -1..=1 {
    // rust: for z in -2..=2 {
    // rust: for x in -2..=2 {
    // rust: if b.in_set(self.state(pos.offset(x, y, z)), flowers) {
    // rust: return true;
}
}
}
}
    // rust: false
}
    // `TreeGrower.findTwoByTwoSaplingPos`.
two_by_two :: proc(self: ^Self, state: BlockStateId, pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let block = self.b.block(state);
    // rust: for dx in [0, -1] {
    // rust: for dz in [0, -1] {
    // rust: let at = |x: i32, z: i32| {
    // rust: let p = pos.offset(dx + x, 0, dz + z);
    // rust: (self.state(p), p)
}
    // rust: let around = [at(0, 0), at(1, 0), at(0, 1), at(1, 1)];
    // rust: if around.iter().all(|(s, _)| self.b.is_block(*s, block)) {
    // rust: return Some((dx, dz, around));
}
}
}
    // rust: None
}
    // `TreeGrower.removeSapling`: the fluid's legacy block, flags 818.
remove_sapling :: proc(self: ^Self, pos: BlockPos) {
}
    // rust: let empty = self.b.legacy_block(self.fluid_at(pos));
    // rust: self.set_block(
    // rust: pos,
    // rust: empty,
    // rust: flags::UPDATE_SKIP_ALL_SIDEEFFECTS | flags::UPDATE_CLIENTS,
    // rust: );
}
    // `TreeGrower.growTree`.
    // rust: pub(crate) fn grow_tree(
    // rust: &mut self,
    // rust: grower: &TreeGrower,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> bool {
    // rust: if let Some(mega) = weighted(grower.mega_trees, self.random())
    // rust: && self.feature_exists(mega)
    // rust: && let Some((dx, dz, around)) = self.two_by_two(state, pos)
    // rust: {
    // rust: for &(_, p) in &around {
    // rust: self.remove_sapling(p);
}
    // rust: if self.place_configured_feature(mega, pos.offset(dx, 0, dz)) {
    // rust: return true;
}
    // rust: for &(s, p) in &around {
    // rust: self.set_block(p, s, flags::UPDATE_NONE);
}
    // rust: return false;
}
    // rust: let flowers = self.tree_has_flowers(pos);
    // rust: let list = if flowers && !grower.flower_trees.is_empty() {
    // rust: grower.flower_trees
    // rust: } else {
    // rust: grower.trees
}
    // rust: let Some(feature) = weighted(list, self.random()) else {
    // rust: return false;
}
    // rust: if !self.feature_exists(feature) {
    // rust: return false;
}
    // rust: self.remove_sapling(pos);
    // rust: if self.place_configured_feature(feature, pos) {
    // rust: return true;
}
    // rust: self.set_block(pos, state, flags::UPDATE_NONE);
    // rust: false
}
    // `TreeGrower.canGrow` (draws as vanilla: feature, then mega feature).
    // rust: pub(crate) fn tree_can_grow(
    // rust: &mut self,
    // rust: grower: &TreeGrower,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> bool {
    // rust: let flowers = self.tree_has_flowers(pos);
    // rust: let list = if flowers && !grower.flower_trees.is_empty() {
    // rust: grower.flower_trees
    // rust: } else {
    // rust: grower.trees
}
    // rust: let feature = weighted(list, self.random());
    // rust: let mega = weighted(grower.mega_trees, self.random());
    // rust: if feature.is_none() && mega.is_some() {
    // rust: self.two_by_two(state, pos).is_some()
    // rust: } else {
    // rust: true
}
}
    // `TreeGrower.getMinimumHeight`: the shortest tree's trunk base height.
    // rust: pub(crate) fn tree_minimum_height(&self, grower: &TreeGrower) -> i32 {
    // rust: grower
    // rust: .shortest
    // rust: .and_then(|name| self.b.live_features()?.configured_json(name))
    // rust: .filter(|json| json["type"] == "minecraft:tree")
    // rust: .and_then(|json| json["trunk_placer"]["base_height"].as_i64())
    // rust: .map_or(0, |h| h as i32)
}
    // `SaplingBlock.advanceTree` with the grower run inline when features are
    // installed; otherwise reported as [`LevelEvent::GrowTree`].
    // rust: pub(crate) fn advance_tree(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.table.int(state, b.props.stage) == 0 {
    // rust: self.set_block(pos, b.table.cycle(state, b.props.stage), flags::UPDATE_NONE);
    // rust: return;
}
    // rust: let Some(name) = b.data(state).feature.clone() else {
    // rust: return;
}
    // rust: match grower(&name) {
    // rust: Some(g) if b.live_features().is_some() => {
    // rust: self.grow_tree(g, pos, state);
}
    // rust: _ => self.emit(LevelEvent::GrowTree {
    // rust: pos,
    // rust: state,
    // rust: grower: name,
    // rust: }),
}
}
    // `MushroomBlock.growMushroom`.
    // rust: pub(crate) fn grow_mushroom(&mut self, pos: BlockPos, state: BlockStateId) -> bool {
    // rust: let Some(feature) = self.b.data(state).feature.clone() else {
    // rust: return false;
}
    // rust: if !self.feature_exists(&feature) {
    // rust: return false;
}
    // rust: self.remove_block(pos, false);
    // rust: if self.place_configured_feature(&feature, pos) {
    // rust: return true;
}
    // rust: self.set_block_and_update(pos, state);
    // rust: false
}
}
