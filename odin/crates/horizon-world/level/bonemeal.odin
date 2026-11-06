//! Transpiled from Horizon Rust crate
package horizon_world_bonemeal

import "core:fmt"
import "core:mem"
import "core:math"

// Bone meal: `BoneMealItem.useOn` / `growCrop` / `growWaterPlant` and every
// vanilla `BonemealableBlock` (`isValidBonemealTarget`, `isBonemealSuccess`,
// `performBonemeal`), ported in vanilla's random draw order.
// use super::{
    // rust: Behaviours, LevelAccess, LevelEvent, Sim, Ticks,
    // rust: classes::{Class, Interface},
    // rust: feature_world::LevelFeatureWorld,
    // rust: growth::grower,
    // rust: update::{HORIZONTAL, above, below, rel},
}
// use crate::{fluid::FluidState, registry::BlockStateId};
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};

// The `BonemealableBlock` implementation a block uses (most derived wins).
Kind :: enum {
    Sapling,
    Propagule,
    Mushroom,
    Fungus,
    Azalea,
    Grass,
    Nylium,
    Netherrack,
    FeaturePlacer,
    RootedDirt,
    MangroveLeaves,
    Crop,
    Stem,
    Pitcher,
    BambooSapling,
    Bamboo,
    Cocoa,
    SweetBerry,
    TallGrass,
    TallFlower,
    SpreadingBush,
    FlowerBed,
    CaveVines,
    PlantHead,
    CaveVinesPlant,
    PlantBody,
    Seagrass,
    SeaPickle,
    BigDripleaf,
    BigDripleafStem,
    SmallDripleaf,
    GlowLichen,
    HangingMoss,
    MossyCarpet,
    ShortDryGrass,
    TallDryGrass,
    ShelfMushroom,
}

kind_of :: proc(class: Class) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match class {
    // rust: Class::MangrovePropagule => Kind::Propagule,
    // rust: Class::Sapling => Kind::Sapling,
    // rust: Class::Mushroom => Kind::Mushroom,
    // rust: Class::NetherFungus => Kind::Fungus,
    // rust: Class::Azalea => Kind::Azalea,
    // rust: Class::Grass => Kind::Grass,
    // rust: Class::Nylium => Kind::Nylium,
    // rust: Class::Netherrack => Kind::Netherrack,
    // rust: Class::BonemealableFeaturePlacer => Kind::FeaturePlacer,
    // rust: Class::RootedDirt => Kind::RootedDirt,
    // rust: Class::MangroveLeaves => Kind::MangroveLeaves,
    // rust: Class::Crop => Kind::Crop,
    // rust: Class::Stem => Kind::Stem,
    // rust: Class::PitcherCrop => Kind::Pitcher,
    // rust: Class::BambooSapling => Kind::BambooSapling,
    // rust: Class::BambooStalk => Kind::Bamboo,
    // rust: Class::Cocoa => Kind::Cocoa,
    // rust: Class::SweetBerryBush => Kind::SweetBerry,
    // rust: Class::TallGrass => Kind::TallGrass,
    // rust: Class::TallFlower => Kind::TallFlower,
    // rust: Class::Bush | Class::FireflyBush => Kind::SpreadingBush,
    // rust: Class::FlowerBed => Kind::FlowerBed,
    // rust: Class::CaveVines => Kind::CaveVines,
    // rust: Class::GrowingPlantHead => Kind::PlantHead,
    // rust: Class::CaveVinesPlant => Kind::CaveVinesPlant,
    // rust: Class::GrowingPlantBody => Kind::PlantBody,
    // rust: Class::Seagrass => Kind::Seagrass,
    // rust: Class::SeaPickle => Kind::SeaPickle,
    // rust: Class::BigDripleaf => Kind::BigDripleaf,
    // rust: Class::BigDripleafStem => Kind::BigDripleafStem,
    // rust: Class::SmallDripleaf => Kind::SmallDripleaf,
    // rust: Class::GlowLichen => Kind::GlowLichen,
    // rust: Class::HangingMoss => Kind::HangingMoss,
    // rust: Class::MossyCarpet => Kind::MossyCarpet,
    // rust: Class::ShortDryGrass => Kind::ShortDryGrass,
    // rust: Class::TallDryGrass => Kind::TallDryGrass,
    // rust: Class::ShelfMushroom => Kind::ShelfMushroom,
    // rust: _ => return None,
    // rust: })
}

// `Mth.nextInt(random, min, max)`.
    // rust: fn next_int_between<R: RandomSource>(random: &mut R, min: i32, max: i32) -> i32 {
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: random.next_int_bound(max - min + 1).unwrap_or(0) + min
}
}

    // rust: impl Behaviours {
    // `/place feature`: `ConfiguredFeature.place` at `pos` with the level
    // random. `None` when the feature is unknown or cannot run.
    // rust: pub fn place_feature<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: name: &str,
    // rust: pos: BlockPos,
    // rust: ) -> Option<bool> {
    // rust: self.live_features()?.configured(name)?;
    // rust: Some(self.sim(level, ticks).place_configured_feature(name, pos))
}
    // `StructureBlockEntity.placeStructure`'s `StructureTemplate.placeInWorld`
    // on the live level: `pos` is both the position and the pivot, the
    // template rots at `integrity` below 1 (`BlockRotProcessor`) drawing from
    // `LegacyRandomSource(seed)`, the loot seeds from a second one, and
    // `flags` are the `setBlock` flags. Returns whether the template placed
    // and the entities it carried (their NBT, for the caller to spawn);
    // `None` when the level has no structure resources.
    // rust: pub fn place_template<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: template: &crate::worldgen::structure::StructureTemplate,
    // rust: pos: BlockPos,
    // rust: settings: TemplateSettings,
    // rust: ) -> Option<(bool, Vec<crate::nbt::Compound>)> {
//         use crate::worldgen::structure::processor::{PlaceSettings, Processor, place_in_world};
    // rust: let features = self.live_features()?;
    // rust: let resources = features.structure_resources()?;
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let rot = Processor::BlockRot {
    // rust: rottable: None,
    // rust: integrity: settings.integrity,
}
    // rust: let mut random = horizon_core::random::LegacyRandom::new(settings.seed);
    // rust: let mut loot_random = horizon_core::random::LegacyRandom::new(settings.seed);
    // rust: let mut place = PlaceSettings::new(settings.rotation);
    // rust: place.mirror = settings.mirror;
    // rust: place.known_shape = settings.known_shape;
    // rust: place.ignore_entities = settings.ignore_entities;
    // rust: if settings.integrity < 1.0 {
    // rust: place.processors.push(&rot);
    // rust: place.random = Some(&mut random);
}
    // rust: let mut world = LevelFeatureWorld {
    // rust: sim: &mut sim,
    // rust: features,
    // rust: entities: Vec::new(),
}
    // rust: let at = [pos.x, pos.y, pos.z];
    // rust: let placed = place_in_world(
    // rust: &mut world,
    // rust: &resources,
    // rust: template,
    // rust: at,
    // rust: at,
    // rust: &mut place,
    // rust: Some(&mut loot_random),
    // rust: settings.flags,
    // rust: )
    // rust: .ok()?;
    // rust: Some((placed, world.entities))
}
    // `BoneMealItem.useOn` for a player clicking `pos` on `face`. Returns
    // whether bone meal was used (the caller then shrinks the stack unless
    // the player is in creative mode). Reports level event 1505 (growth
    // particles and sound) at the grown position.
    // rust: pub fn use_bone_meal<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: ) -> bool {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: if sim.grow_crop(pos) {
    // rust: sim.level_event(1505, pos, 15);
    // rust: return true;
}
    // rust: let clicked = sim.state(pos);
    // rust: let relative = rel(pos, face);
    // rust: if self.is_face_sturdy(clicked, face) && sim.grow_water_plant(relative, Some(face)) {
    // rust: sim.level_event(1505, relative, 15);
    // rust: return true;
}
    // rust: false
}
    // `BoneMealItem.useOn` on a client's level, where nothing grows: whether
    // it succeeds there (the server's packet does the growing). A sapling,
    // an azalea or a mushroom is only a valid target on a `ServerLevel`
    // (`isValidBonemealTarget`), so the client passes on them; `growWaterPlant`
    // takes any full water block beside a sturdy clicked face.
    // rust: pub fn bone_meal_succeeds_on_client<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: ) -> bool {
    // rust: let mut ticks = Ticks::default();
    // rust: let mut sim = self.sim(level, &mut ticks);
    // rust: let state = sim.state(pos);
        // A mod block answers `isValidBonemealTarget` on both sides, so the
        // client predicts the use with the mod's own answer.
    // rust: let answer = sim.level.is_valid_bonemeal_target(pos, state);
    // rust: if answer == Some(true) {
    // rust: return true;
}
        // Refused (`Some(false)`): growCrop fails, and only growWaterPlant
        // below can still take the meal.
    // rust: if answer.is_none()
    // rust: && let Some(kind) = self.bonemeal_kind(state)
    // rust: && !matches!(kind, Kind::Sapling | Kind::Azalea | Kind::Mushroom)
    // rust: && sim.bonemeal_valid(kind, pos, state)
    // rust: {
    // rust: return true;
}
    // rust: let water = sim.state(rel(pos, face));
    // rust: self.is_face_sturdy(state, face)
    // rust: && self.is_block(water, self.named.water)
    // rust: && self.fluid(water).amount() == 8
}
    // `BoneMealItem.growCrop` (dispensers call this directly).
    // rust: pub fn grow_crop<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).grow_crop(pos)
}
    // `BoneMealItem.growWaterPlant` (dispensers pass no clicked face).
    // rust: pub fn grow_water_plant<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Option<Direction>,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).grow_water_plant(pos, face)
}
    // The `BonemealableBlock.Type` particle spread of a block at level event
    // 1505: Some(true) for `NEIGHBOR_SPREADER` (particles over a 3-block
    // area above), Some(false) for `GROWER`, None when not bonemealable.
bone_meal_spreads :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = self.bonemeal_kind(state)?;
    // rust: Some(matches!(
    // rust: kind,
    // rust: Kind::Grass | Kind::Nylium | Kind::Netherrack | Kind::FeaturePlacer
    // rust: ))
}
bonemeal_kind :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let data = self.data(state);
    // rust: if !data.implements(Interface::Bonemealable) {
    // rust: return None;
}
    // rust: data.chain.iter().find_map(|&c| kind_of(c))
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
next_int :: proc(self: ^Self, bound: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.random().next_int_bound(bound).unwrap_or(0)
}
block_named :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: b.table.block_by_name(name).map(|id| b.default_of(id))
}
in_tag :: proc(self: ^Self, state: BlockStateId, tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.tag(tag).is_some_and(|set| self.b.in_set(state, set))
}

    // `BoneMealItem.growCrop`: true when the block is a valid target (bone
    // meal is consumed even when `isBonemealSuccess` fails).
    // rust: pub(crate) fn grow_crop(&mut self, pos: BlockPos) -> bool {
    // rust: let state = self.state(pos);
        // A mod block answers vanilla's three questions itself, ahead of the
        // `BonemealableBlock` its template would give it; a block nothing
        // answers for keeps its own, and vanilla's is what the port runs.
    // rust: match self.level.is_valid_bonemeal_target(pos, state) {
    // rust: Some(true) => {
    // rust: if self.level.is_bonemeal_success(pos, state) {
    // rust: self.level.perform_bonemeal(self.ticks, pos, state);
}
    // rust: return true;
}
            // `growCrop` returns false and keeps the meal.
    // rust: Some(false) => return false,
    // rust: None => {}
}
    // rust: let Some(kind) = self.b.bonemeal_kind(state) else {
    // rust: return false;
}
    // rust: if !self.bonemeal_valid(kind, pos, state) {
    // rust: return false;
}
    // rust: if self.bonemeal_success(kind, pos, state) {
    // rust: self.perform_bonemeal(kind, pos, state);
}
    // rust: true
}

    // `BonemealableBlock.isValidBonemealTarget`.
bonemeal_valid :: proc(self: ^Self, kind: Kind, pos: BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let up = above(pos);
    // rust: match kind {
    // rust: Kind::Sapling => {
    // rust: let Some(g) = b.data(state).feature.as_deref().and_then(grower) else {
    // rust: return false;
}
    // rust: if b.live_features().is_none() || !self.tree_can_grow(g, pos, state) {
    // rust: return false;
}
    // rust: let height = self.tree_minimum_height(g);
    // rust: self.is_inside_build_height(pos.y + height)
}
    // rust: Kind::Propagule => !b.table.bool(state, p.hanging) || b.table.int(state, p.age) != 4,
    // rust: Kind::Mushroom => {
    // rust: let Some(feature) = b.data(state).feature.as_deref() else {
    // rust: return false;
}
    // rust: let Some(json) = b.live_features().and_then(|f| f.configured_json(feature)) else {
    // rust: return false;
}
    // rust: let huge = matches!(
    // rust: json["type"].as_str(),
    // rust: Some("minecraft:huge_red_mushroom" | "minecraft:huge_brown_mushroom")
    // rust: );
    // rust: let radius = json["foliage_radius"].as_i64().unwrap_or(2) as i32;
    // rust: huge && self.is_inside_build_height(pos.y + 4 + radius)
}
    // rust: Kind::Fungus => {
    // rust: let below_state = self.below_state(pos);
    // rust: b.data(state)
    // rust: .link
    // rust: .is_some_and(|required| b.is_block(below_state, required))
    // rust: && self.is_inside_build_height(pos.y + 1)
}
    // rust: Kind::Azalea => {
    // rust: let Some(g) = grower("azalea") else {
    // rust: return false;
}
    // rust: let height = self.tree_minimum_height(g);
    // rust: self.is_inside_build_height(pos.y + height + 2)
    // rust: && self.fluid_at(up) == FluidState::EMPTY
}
    // rust: Kind::Grass | Kind::Nylium | Kind::BambooSapling => {
    // rust: b.is_air(self.state(up)) && self.is_inside_build_height(up.y)
}
    // rust: Kind::Netherrack => {
    // rust: if !b.has_flag(self.state(up), super::data::state_flags::SKYLIGHT_DOWN) {
    // rust: return false;
}
    // rust: self.netherrack_nylium_near(pos) != (false, false)
}
    // rust: Kind::FeaturePlacer => b.is_air(self.state(up)),
    // rust: Kind::RootedDirt => {
    // rust: b.is_air(self.state(below(pos))) && self.is_inside_build_height(pos.y - 1)
}
    // rust: Kind::MangroveLeaves => b.is_air(self.state(below(pos))),
    // rust: Kind::Crop => b.table.int(state, p.age) < self.crop_max_age(state),
    // rust: Kind::Stem => b.table.int(state, p.age) != 7,
    // rust: Kind::Pitcher => match self.pitcher_lower(pos, state) {
    // rust: Some((lower_pos, lower)) => {
    // rust: let age = b.table.int(lower, p.age) + 1;
    // rust: self.pitcher_can_grow(lower_pos, lower, age)
}
    // rust: None => false,
    // rust: },
    // rust: Kind::Bamboo => {
    // rust: let height_above = self.bamboo_height_above(pos);
    // rust: let height_below = self.bamboo_height_below(pos);
    // rust: let growth = pos.offset(0, height_above + 1, 0);
    // rust: height_above + height_below + 1 < 16
    // rust: && b.table
    // rust: .int(self.state(pos.offset(0, height_above, 0)), p.stage)
    // rust: != 1
    // rust: && self.is_inside_build_height(growth.y)
    // rust: && self.is_empty_block(growth)
}
    // rust: Kind::Cocoa => b.table.int(state, p.age) < 2,
    // rust: Kind::SweetBerry => b.table.int(state, p.age) < 3,
    // rust: Kind::TallGrass => {
    // rust: let Some(grown) = self.tall_grass_grown(state) else {
    // rust: return false;
}
    // rust: self.can_survive(grown, pos)
    // rust: && self.is_empty_block(up)
    // rust: && self.is_inside_build_height(up.y)
}
    // rust: Kind::TallFlower | Kind::FlowerBed | Kind::SmallDripleaf | Kind::ShortDryGrass => true,
    // rust: Kind::SpreadingBush => self.spreadable_neighbour(pos, state, false).is_some(),
    // rust: Kind::TallDryGrass => {
    // rust: let Some(short) = self.block_named("minecraft:short_dry_grass") else {
    // rust: return false;
}
    // rust: self.spreadable_neighbour(pos, short, false).is_some()
}
    // rust: Kind::PlantHead => {
    // rust: let growth = rel(pos, b.data(state).growth_direction);
    // rust: self.plant_can_grow_into(state, self.state(growth))
    // rust: && self.is_inside_build_height(growth.y)
}
    // rust: Kind::CaveVines | Kind::CaveVinesPlant => !b.table.bool(state, p.berries),
    // rust: Kind::PlantBody => match self.plant_head_pos(pos, state) {
    // rust: Some(head) => {
    // rust: let head_state = self.state(head);
    // rust: let growth = rel(head, b.data(state).growth_direction);
    // rust: self.plant_can_grow_into(head_state, self.state(growth))
    // rust: && self.is_inside_build_height(growth.y)
}
    // rust: None => false,
    // rust: },
    // rust: Kind::Seagrass => b.is_block(self.state(up), b.named.water),
    // rust: Kind::SeaPickle => {
    // rust: b.table.bool(state, p.waterlogged)
    // rust: && self.in_tag(self.below_state(pos), "minecraft:coral_blocks")
}
    // rust: Kind::BigDripleaf => self.dripleaf_can_grow_into(up),
    // rust: Kind::BigDripleafStem => {
    // rust: let Some(leaf) = b.table.block_by_name("minecraft:big_dripleaf") else {
    // rust: return false;
}
    // rust: self.top_connected(pos, b.block(state), Direction::Up, leaf)
    // rust: .is_some_and(|head| self.dripleaf_can_grow_into(above(head)))
}
    // rust: Kind::GlowLichen => Direction::ALL
    // rust: .iter()
    // rust: .any(|&face| self.lichen_can_spread_in_any_direction(state, pos, face.opposite())),
    // rust: Kind::HangingMoss => {
    // rust: let grow = below(self.hanging_moss_tip(pos, state));
    // rust: b.is_air(self.state(grow)) && self.is_inside_build_height(grow.y)
}
    // rust: Kind::MossyCarpet => {
    // rust: b.table.bool(state, p.bottom) && !b.is_air(self.mossy_topper_all_sides(pos))
}
    // rust: Kind::ShelfMushroom => b.table.int(state, p.age) < 1,
}
}

    // `BonemealableBlock.isBonemealSuccess`.
bonemeal_success :: proc(self: ^Self, kind: Kind, _pos: BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: match kind {
    // rust: Kind::Sapling | Kind::Azalea => self.random().next_float() < 0.45,
    // rust: Kind::Propagule => {
    // rust: if b.table.bool(state, b.props.hanging) {
    // rust: b.table.int(state, b.props.age) != 4
    // rust: } else {
    // rust: self.random().next_float() < 0.45
}
}
    // rust: Kind::Mushroom | Kind::Fungus => self.random().next_float() < 0.4,
    // rust: _ => true,
}
}

    // `BonemealableBlock.performBonemeal`.
perform_bonemeal :: proc(self: ^Self, kind: Kind, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let up = above(pos);
    // rust: match kind {
    // rust: Kind::Sapling => self.advance_tree(pos, state),
    // rust: Kind::Propagule => {
    // rust: if b.table.bool(state, p.hanging) && b.table.int(state, p.age) != 4 {
    // rust: self.set_block(pos, b.table.cycle(state, p.age), 2);
    // rust: } else {
    // rust: self.advance_tree(pos, state);
}
}
    // rust: Kind::Mushroom => {
    // rust: self.grow_mushroom(pos, state);
}
    // rust: Kind::Fungus => {
    // rust: if let Some(feature) = b.data(state).feature.clone() {
    // rust: self.place_configured_feature(&feature, pos);
}
}
    // rust: Kind::Azalea => {
    // rust: if let Some(g) = grower("azalea") {
    // rust: self.grow_tree(g, pos, state);
}
}
    // rust: Kind::Grass => self.grass_bonemeal(pos, state),
    // rust: Kind::Nylium => {
    // rust: if self.is_inside_build_height(up.y) {
    // rust: self.place_configured_feature("minecraft:nylium_bonemeal", up);
}
}
    // rust: Kind::Netherrack => {
    // rust: let (warped, crimson) = self.netherrack_nylium_near(pos);
    // rust: let warped_state = self.block_named("minecraft:warped_nylium");
    // rust: let crimson_state = self.block_named("minecraft:crimson_nylium");
    // rust: let next = if warped && crimson {
    // rust: if self.random().next_boolean() {
    // rust: warped_state
    // rust: } else {
    // rust: crimson_state
}
    // rust: } else if warped {
    // rust: warped_state
    // rust: } else if crimson {
    // rust: crimson_state
    // rust: } else {
    // rust: None
}
    // rust: if let Some(next) = next {
    // rust: self.set_block_and_update(pos, next);
}
}
    // rust: Kind::FeaturePlacer => {
    // rust: if let Some(feature) = b.data(state).feature.clone() {
    // rust: self.place_configured_feature(&feature, up);
}
}
    // rust: Kind::RootedDirt => {
    // rust: if let Some(roots) = self.block_named("minecraft:hanging_roots") {
    // rust: self.set_block_and_update(below(pos), roots);
}
}
    // rust: Kind::MangroveLeaves => {
    // rust: if let Some(propagule) = self.block_named("minecraft:mangrove_propagule") {
    // rust: let hanging = b.table.set_bool(propagule, p.hanging, true);
    // rust: self.set_block(below(pos), b.table.set_int(hanging, p.age, 0), 2);
}
}
    // rust: Kind::Crop => {
    // rust: let max = self.crop_max_age(state);
    // rust: let increase = self.crop_bonemeal_increase(state);
    // rust: let age = max.min(b.table.int(state, p.age) + increase);
    // rust: let next = self.crop_state_for_age(state, age);
    // rust: self.set_block(pos, next, 2);
}
    // rust: Kind::Stem => {
    // rust: let increase = next_int_between(self.random(), 2, 5);
    // rust: let age = 7.min(b.table.int(state, p.age) + increase);
    // rust: let next = b.table.set_int(state, p.age, age);
    // rust: self.set_block(pos, next, 2);
    // rust: if age == 7 {
    // rust: self.random_tick_block(next, pos);
}
}
    // rust: Kind::Pitcher => {
    // rust: if let Some((lower_pos, lower)) = self.pitcher_lower(pos, state) {
    // rust: self.pitcher_grow(lower, lower_pos, 1);
}
}
    // rust: Kind::BambooSapling => self.bamboo_sapling_grow(pos),
    // rust: Kind::Bamboo => {
    // rust: let height_above = self.bamboo_height_above(pos);
    // rust: let height_below = self.bamboo_height_below(pos);
    // rust: let total = height_above + height_below + 1;
    // rust: let count = 1 + self.next_int(2);
    // rust: for i in 0..count {
    // rust: let top = pos.offset(0, height_above + i, 0);
    // rust: let top_state = self.state(top);
    // rust: let growth = above(top);
    // rust: if total + i >= 16
    // rust: || b.table.int(top_state, p.stage) == 1
    // rust: || !self.is_empty_block(growth)
    // rust: || !self.is_inside_build_height(growth.y)
    // rust: {
    // rust: return;
}
    // rust: self.bamboo_grow(top_state, top, total + i);
}
}
    // rust: Kind::Cocoa => {
    // rust: let age = b.table.int(state, p.age);
    // rust: self.set_block(pos, b.table.set_int(state, p.age, age + 1), 2);
}
    // rust: Kind::SweetBerry => {
    // rust: let age = 3.min(b.table.int(state, p.age) + 1);
    // rust: self.set_block(pos, b.table.set_int(state, p.age, age), 2);
}
    // rust: Kind::TallGrass => {
    // rust: if let Some(grown) = self.tall_grass_grown(state) {
    // rust: self.double_plant_place_at(grown, pos, 2);
}
}
    // rust: Kind::TallFlower => self.pop_block_item(pos, state),
    // rust: Kind::SpreadingBush => {
    // rust: if let Some(at) = self.spreadable_neighbour(pos, state, true) {
    // rust: self.set_block_and_update(at, b.default_of(b.block(state)));
}
}
    // rust: Kind::TallDryGrass => {
    // rust: if let Some(short) = self.block_named("minecraft:short_dry_grass")
    // rust: && let Some(at) = self.spreadable_neighbour(pos, short, true)
    // rust: {
    // rust: self.set_block_and_update(at, short);
}
}
    // rust: Kind::ShortDryGrass => {
    // rust: if let Some(tall) = self.block_named("minecraft:tall_dry_grass") {
    // rust: self.set_block_and_update(pos, tall);
}
}
    // rust: Kind::FlowerBed => {
    // rust: let amount = b.table.int(state, p.flower_amount);
    // rust: if amount < 4 {
    // rust: self.set_block(pos, b.table.set_int(state, p.flower_amount, amount + 1), 2);
    // rust: } else {
    // rust: self.pop_block_item(pos, state);
}
}
    // rust: Kind::PlantHead => self.plant_head_bonemeal(pos, state),
    // rust: Kind::CaveVines | Kind::CaveVinesPlant => {
    // rust: self.set_block(pos, b.table.set_bool(state, p.berries, true), 2);
}
    // rust: Kind::PlantBody => {
    // rust: if let Some(head) = self.plant_head_pos(pos, state) {
    // rust: let head_state = self.state(head);
    // rust: match b.bonemeal_kind(head_state) {
    // rust: Some(Kind::CaveVines) => {
    // rust: self.set_block(head, b.table.set_bool(head_state, p.berries, true), 2);
}
    // rust: Some(Kind::PlantHead) => self.plant_head_bonemeal(head, head_state),
    // rust: _ => {}
}
}
}
    // rust: Kind::Seagrass => {
    // rust: let lower = b.default_of(b.named.tall_seagrass);
    // rust: let upper = b.table.set_text(lower, p.half, "upper");
    // rust: self.set_block(pos, lower, 2);
    // rust: self.set_block(up, upper, 2);
}
    // rust: Kind::SeaPickle => self.sea_pickle_bonemeal(pos, state),
    // rust: Kind::BigDripleaf => {
    // rust: if self.dripleaf_can_grow_into(up) {
    // rust: let facing = b.facing(state);
    // rust: let fluid = b.fluid(state);
    // rust: self.dripleaf_stem_place(pos, fluid, facing);
    // rust: let fluid_above = self.fluid_at(up);
    // rust: self.dripleaf_place(up, fluid_above, facing);
}
}
    // rust: Kind::BigDripleafStem => {
    // rust: let Some(leaf) = b.table.block_by_name("minecraft:big_dripleaf") else {
    // rust: return;
}
    // rust: if let Some(head) = self.top_connected(pos, b.block(state), Direction::Up, leaf) {
    // rust: let facing = b.facing(state);
    // rust: let fluid = self.fluid_at(head);
    // rust: self.dripleaf_stem_place(head, fluid, facing);
    // rust: let fluid_above = self.fluid_at(above(head));
    // rust: self.dripleaf_place(above(head), fluid_above, facing);
}
}
    // rust: Kind::SmallDripleaf => {
    // rust: if b.table.text(state, p.half) == "lower" {
    // rust: let empty = b.legacy_block(self.fluid_at(up));
    // rust: self.set_block(up, empty, 18);
    // rust: let facing = b.facing(state);
    // rust: self.dripleaf_place_random_height(pos, facing);
    // rust: } else {
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: if b.bonemeal_kind(below_state) == Some(Kind::SmallDripleaf) {
    // rust: self.perform_bonemeal(Kind::SmallDripleaf, below_pos, below_state);
    // rust: } else {
                        // performBonemeal on a non-dripleaf below: vanilla reads
                        // FACING/HALF of that state and would throw; do nothing.
}
}
}
    // rust: Kind::GlowLichen => self.lichen_spread_random(pos, state),
    // rust: Kind::HangingMoss => {
    // rust: let tip = below(self.hanging_moss_tip(pos, state));
    // rust: if b.is_air(self.state(tip)) {
    // rust: self.set_block_and_update(tip, b.table.set_bool(state, p.tip, true));
}
}
    // rust: Kind::MossyCarpet => {
    // rust: let topper = self.mossy_topper_all_sides(pos);
    // rust: if !b.is_air(topper) {
    // rust: self.set_block_and_update(up, topper);
}
}
    // rust: Kind::ShelfMushroom => {
    // rust: let age = b.table.int(state, p.age);
    // rust: self.set_block(pos, b.table.set_int(state, p.age, age + 1), 2);
}
}
}

    // ---- helpers ----

    // `Block.popResource(level, pos, new ItemStack(this))`.
pop_block_item :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "pop_block_item",
    // rust: });
}
    // `CropBlock.getMaxAge`.
    // rust: pub(crate) fn crop_max_age(&self, state: BlockStateId) -> i32 {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::TorchflowerCrop) {
    // rust: 2
    // rust: } else {
    // rust: b.table.int_range(state, b.props.age).map_or(7, |r| r.1)
}
}
    // `CropBlock.getStateForAge` (torchflower crops become torchflowers).
    // rust: pub(crate) fn crop_state_for_age(&self, state: BlockStateId, age: i32) -> BlockStateId {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::TorchflowerCrop)
    // rust: && age == 2
    // rust: && let Some(flower) = self.block_named("minecraft:torchflower")
    // rust: {
    // rust: return flower;
}
    // rust: b.table
    // rust: .set_int(b.default_of(b.block(state)), b.props.age, age)
}
    // `CropBlock.getBonemealAgeIncrease` and its overrides.
crop_bonemeal_increase :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::TorchflowerCrop) {
    // rust: 1
    // rust: } else if b.instance_of(state, Class::Beetroot) {
    // rust: next_int_between(self.random(), 2, 5) / 3
    // rust: } else {
    // rust: next_int_between(self.random(), 2, 5)
}
}
    // `PitcherCropBlock.getLowerHalf`.
    // rust: fn pitcher_lower(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Option<(BlockPos, BlockStateId)> {
    // rust: let b = self.b;
    // rust: let is_lower = |s: BlockStateId| {
    // rust: b.is_block(s, b.named.pitcher_crop) && b.table.text(s, b.props.half) == "lower"
}
    // rust: if is_lower(state) {
    // rust: return Some((pos, state));
}
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: is_lower(below_state).then_some((below_pos, below_state))
}
    // `PitcherCropBlock.canGrow`.
pitcher_can_grow :: proc(self: ^Self, lower_pos: BlockPos, lower: BlockStateId, new_age: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let upper = self.state(above(lower_pos));
    // rust: b.table.int(lower, b.props.age) < 4
    // rust: && self.raw_brightness(lower_pos, 0) >= 8
    // rust: && self.is_inside_build_height(lower_pos.y + 1)
    // rust: && (new_age < 3 || b.is_air(upper) || b.is_block(upper, b.named.pitcher_crop))
}
    // `TallGrassBlock.getGrownBlock`.
tall_grass_grown :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = if self.b.table.name(state) == "minecraft:fern" {
    // rust: "minecraft:large_fern"
    // rust: } else {
    // rust: "minecraft:tall_grass"
}
    // rust: self.block_named(name)
}
    // `DoublePlantBlock.placeAt`.
double_plant_place_at :: proc(self: ^Self, state: BlockStateId, lower: BlockPos, flags: i32) {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let upper = above(lower);
    // rust: let lower_state = b.table.set_text(state, p.half, "lower");
    // rust: let lower_state = b
    // rust: .table
    // rust: .with_bool(lower_state, p.waterlogged, self.is_water_at(lower))
    // rust: .unwrap_or(lower_state);
    // rust: self.set_block(lower, lower_state, flags);
    // rust: let upper_state = b.table.set_text(state, p.half, "upper");
    // rust: let upper_state = b
    // rust: .table
    // rust: .with_bool(upper_state, p.waterlogged, self.is_water_at(upper))
    // rust: .unwrap_or(upper_state);
    // rust: self.set_block(upper, upper_state, flags);
}
    // `BonemealableBlock.getSpreadableNeighbourPos` (shuffled order when
    // `shuffle`, as `findSpreadableNeighbourPos`).
    // rust: fn spreadable_neighbour(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: to_place: BlockStateId,
    // rust: shuffle: bool,
    // rust: ) -> Option<BlockPos> {
    // rust: let mut directions = HORIZONTAL;
    // rust: if shuffle {
            // Util.shuffle.
    // rust: for i in (2..=directions.len()).rev() {
    // rust: let swap = self.next_int(i as i32) as usize;
    // rust: directions.swap(i - 1, swap);
}
}
    // rust: directions
    // rust: .into_iter()
    // rust: .map(|d| rel(pos, d))
    // rust: .find(|&n| self.is_empty_block(n) && self.can_survive(to_place, n))
}
    // `NetherrackBlock`: (warped nylium nearby, crimson nylium nearby).
netherrack_nylium_near :: proc(self: ^Self, pos: BlockPos) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (mut warped, mut crimson) = (false, false);
    // rust: for x in -1..=1 {
    // rust: for y in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: let state = self.state(pos.offset(x, y, z));
    // rust: if !self.in_tag(state, "minecraft:nylium") {
    // rust: continue;
}
    // rust: match self.b.table.name(state) {
    // rust: "minecraft:warped_nylium" => warped = true,
    // rust: "minecraft:crimson_nylium" => crimson = true,
    // rust: _ => {}
}
    // rust: if warped && crimson {
    // rust: return (true, true);
}
}
}
}
    // rust: (warped, crimson)
}
    // `GrowingPlantHeadBlock.canGrowInto` of the head's block.
plant_can_grow_into :: proc(self: ^Self, head: BlockStateId, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: if b.instance_of(head, Class::Kelp) {
    // rust: b.is_block(state, b.named.water)
    // rust: } else {
    // rust: b.is_air(state)
}
}
    // `GrowingPlantHeadBlock.performBonemeal`.
plant_head_bonemeal :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let direction = b.data(state).growth_direction;
    // rust: let mut forward = rel(pos, direction);
    // rust: let mut next_age = (b.table.int(state, b.props.age) + 1).min(25);
    // rust: let count = if b.instance_of(state, Class::TwistingVines)
    // rust: || b.instance_of(state, Class::WeepingVines)
    // rust: {
            // NetherVines.getBlocksToGrowWhenBonemealed.
    // rust: let mut probability = 1.0;
    // rust: let mut count = 0;
    // rust: while self.random().next_double() < probability {
    // rust: probability *= 0.826;
    // rust: count += 1;
}
    // rust: count
    // rust: } else {
    // rust: 1
}
    // rust: for _ in 0..count {
    // rust: if !self.plant_can_grow_into(state, self.state(forward))
    // rust: || !self.is_inside_build_height(forward.y)
    // rust: {
    // rust: break;
}
    // rust: self.set_block_and_update(forward, b.table.set_int(state, b.props.age, next_age));
    // rust: forward = rel(forward, direction);
    // rust: next_age = (next_age + 1).min(25);
}
}
    // `GrowingPlantBodyBlock.getHeadPos` (`BlockUtil.getTopConnectedBlock`).
plant_head_pos :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let name = b.table.name(state);
    // rust: let head = b.table.block_by_name(name.strip_suffix("_plant")?)?;
    // rust: self.top_connected(pos, b.block(state), b.data(state).growth_direction, head)
}
    // `BlockUtil.getTopConnectedBlock`.
    // rust: fn top_connected(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: body: super::states::BlockId,
    // rust: direction: Direction,
    // rust: head: super::states::BlockId,
    // rust: ) -> Option<BlockPos> {
    // rust: let mut forward = pos;
    // rust: loop {
    // rust: forward = rel(forward, direction);
    // rust: let state = self.state(forward);
    // rust: if !self.b.is_block(state, body) {
    // rust: return self.b.is_block(state, head).then_some(forward);
}
    // rust: if !self.level.is_loaded(forward) || !self.is_in_valid_bounds(forward) {
    // rust: return None;
}
}
}
    // `HangingMossBlock.getTip`.
hanging_moss_tip :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let block = self.b.block(state);
    // rust: let mut forward = pos;
    // rust: loop {
    // rust: forward = below(forward);
    // rust: if !self.b.is_block(self.state(forward), block) || forward.y < self.level.min_y() {
    // rust: return above(forward);
}
}
}
    // `MossyCarpetBlock.createTopperWithSideChance(level, pos, () -> true)`.
mossy_topper_all_sides :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(self.state(pos));
    // rust: let above_pos = above(pos);
    // rust: let above_state = self.state(above_pos);
    // rust: let is_carpet = b.is_block(above_state, block);
    // rust: if (!is_carpet || !b.table.bool(above_state, p.bottom))
    // rust: && (is_carpet || b.is_replaceable(above_state))
    // rust: {
    // rust: let carpet = b.table.set_bool(b.default_of(block), p.bottom, false);
    // rust: let topper = self.mossy_carpet_updated_state(carpet, above_pos, true);
    // rust: if self.mossy_carpet_has_faces(topper) && topper != above_state {
    // rust: return topper;
}
}
    // rust: b.air()
}
    // `SeaPickleBlock.performBonemeal`.
sea_pickle_bonemeal :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let (mut z_span, mut z_offset) = (1, 0);
    // rust: let x_start = pos.x - 2;
    // rust: for (count, x) in (0..5).enumerate() {
    // rust: for z in 0..z_span {
    // rust: let end_y = 2 + pos.y - 1;
    // rust: for y in (end_y - 2)..end_y {
    // rust: let position = BlockPos::new(x_start + x, y, pos.z - z_offset + z);
    // rust: if position != pos
    // rust: && self.next_int(6) == 0
    // rust: && b.is_block(self.state(position), b.named.water)
    // rust: && self.in_tag(self.below_state(position), "minecraft:coral_blocks")
    // rust: {
    // rust: let pickles = self.next_int(4) + 1;
    // rust: let pickle =
    // rust: b.table
    // rust: .set_int(b.default_of(b.block(state)), p.pickles, pickles);
    // rust: self.set_block_and_update(position, pickle);
}
}
}
    // rust: if count < 2 {
    // rust: z_span += 2;
    // rust: z_offset += 1;
    // rust: } else {
    // rust: z_span -= 2;
    // rust: z_offset -= 1;
}
}
    // rust: self.set_block(pos, b.table.set_int(state, p.pickles, 4), 2);
}
    // `BigDripleafBlock.canGrowInto` / `canPlaceAt`.
dripleaf_can_grow_into :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: self.is_inside_build_height(pos.y)
    // rust: && (b.is_air(state)
    // rust: || b.is_block(state, b.named.water)
    // rust: || b.table.name(state) == "minecraft:small_dripleaf")
}
dripleaf_set :: proc(self: ^Self, name: string, pos: BlockPos, fluid: FluidState, facing: Direction) {
}
    // rust: let b = self.b;
    // rust: let Some(state) = self.block_named(name) else {
    // rust: return;
}
    // rust: let state = b
    // rust: .table
    // rust: .set_bool(state, b.props.waterlogged, fluid == FluidState::WATER);
    // rust: let state = b.table.set_dir(state, b.props.facing, facing);
    // rust: self.set_block_and_update(pos, state);
}
dripleaf_place :: proc(self: ^Self, pos: BlockPos, fluid: FluidState, facing: Direction) {
}
    // rust: self.dripleaf_set("minecraft:big_dripleaf", pos, fluid, facing);
}
dripleaf_stem_place :: proc(self: ^Self, pos: BlockPos, fluid: FluidState, facing: Direction) {
}
    // rust: self.dripleaf_set("minecraft:big_dripleaf_stem", pos, fluid, facing);
}
    // `BigDripleafBlock.placeWithRandomHeight`.
dripleaf_place_random_height :: proc(self: ^Self, bottom: BlockPos, facing: Direction) {
}
    // rust: let desired = next_int_between(self.random(), 2, 5);
    // rust: let mut pos = bottom;
    // rust: let mut height = 0;
    // rust: while height < desired && self.dripleaf_can_grow_into(pos) {
    // rust: height += 1;
    // rust: pos = above(pos);
}
    // rust: let leaf_y = bottom.y + height - 1;
    // rust: pos = bottom;
    // rust: while pos.y < leaf_y {
    // rust: let fluid = self.fluid_at(pos);
    // rust: self.dripleaf_stem_place(pos, fluid, facing);
    // rust: pos = above(pos);
}
    // rust: let fluid = self.fluid_at(pos);
    // rust: self.dripleaf_place(pos, fluid, facing);
}

    // ---- MultifaceSpreader (glow lichen, default config) ----

    // `SpreadType.getSpreadPos` for SAME_POSITION, SAME_PLANE, WRAP_AROUND.
    // rust: fn spread_positions(
    // rust: pos: BlockPos,
    // rust: spread: Direction,
    // rust: from: Direction,
    // rust: ) -> [(BlockPos, Direction); 3] {
    // rust: [
    // rust: (pos, spread),
    // rust: (rel(pos, spread), from),
    // rust: (rel(rel(pos, spread), from), spread.opposite()),
    // rust: ]
}
    // `DefaultSpreaderConfig.canSpreadInto`.
    // rust: fn lichen_can_spread_into(
    // rust: &self,
    // rust: block: super::states::BlockId,
    // rust: at: BlockPos,
    // rust: face: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let existing = self.state(at);
    // rust: let replaceable = b.is_air(existing)
    // rust: || b.is_block(existing, block)
    // rust: || (b.is_block(existing, b.named.water) && b.fluid(existing).is_source());
    // rust: replaceable
    // rust: && !(b.is_block(existing, block) && self.multiface_has_face(existing, face))
    // rust: && b.multiface_can_attach(self.state(rel(at, face)), face)
}
    // `MultifaceSpreader.getSpreadFromFaceTowardDirection`.
    // rust: fn lichen_spread_target(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: from: Direction,
    // rust: spread: Direction,
    // rust: ) -> Option<(BlockPos, Direction)> {
    // rust: if crate::level::query::axis_of(spread) == crate::level::query::axis_of(from) {
    // rust: return None;
}
    // rust: if !self.multiface_has_face(state, from) || self.multiface_has_face(state, spread) {
    // rust: return None;
}
    // rust: let block = self.b.block(state);
    // rust: Self::spread_positions(pos, spread, from)
    // rust: .into_iter()
    // rust: .find(|&(at, face)| self.lichen_can_spread_into(block, at, face))
}
    // rust: fn lichen_can_spread_in_any_direction(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: from: Direction,
    // rust: ) -> bool {
    // rust: Direction::ALL.iter().any(|&spread| {
    // rust: self.lichen_spread_target(state, pos, from, spread)
    // rust: .is_some()
    // rust: })
}
shuffled_directions :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut directions = Direction::ALL;
    // rust: for i in (2..=directions.len()).rev() {
    // rust: let swap = self.next_int(i as i32) as usize;
    // rust: directions.swap(i - 1, swap);
}
    // rust: directions
}
    // `MultifaceSpreader.spreadFromRandomFaceTowardRandomDirection`.
lichen_spread_random :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: for from in self.shuffled_directions() {
    // rust: if !self.multiface_has_face(state, from) {
    // rust: continue;
}
    // rust: for spread in self.shuffled_directions() {
    // rust: let Some((at, face)) = self.lichen_spread_target(state, pos, from, spread) else {
    // rust: continue;
}
    // rust: let old = self.state(at);
                // MultifaceBlock.getStateForPlacement then setBlock(..., 2).
    // rust: let base = if b.is_block(old, block) {
    // rust: old
    // rust: } else if b.fluid(old) == FluidState::WATER {
    // rust: b.table
    // rust: .set_bool(b.default_of(block), b.props.waterlogged, true)
    // rust: } else {
    // rust: b.default_of(block)
}
    // rust: let placed = b.table.set_bool(base, self.direction_prop(face), true);
    // rust: if self.set_block(at, placed, 2) {
    // rust: return;
}
}
}
}

    // ---- water plants and grass ----

    // `BoneMealItem.growWaterPlant`.
    // rust: pub(crate) fn grow_water_plant(&mut self, pos: BlockPos, face: Option<Direction>) -> bool {
    // rust: let b = self.b;
    // rust: let start = self.state(pos);
    // rust: if !(b.is_block(start, b.named.water) && b.fluid(start).amount() == 8) {
    // rust: return false;
}
    // rust: let seagrass = b.default_of(b.named.seagrass);
    // rust: let features = b.live_features();
    // rust: 'attempts: for j in 0..128 {
    // rust: let mut test = pos;
    // rust: let mut grow = seagrass;
    // rust: for _ in 0..j / 16 {
    // rust: let dx = self.next_int(3) - 1;
    // rust: let dy = (self.next_int(3) - 1) * self.next_int(3) / 2;
    // rust: let dz = self.next_int(3) - 1;
    // rust: test = test.offset(dx, dy, dz);
    // rust: if b.full_collision(self.state(test)) {
    // rust: continue 'attempts;
}
}
    // rust: let corals = match (features, self.level.biome_name(test)) {
    // rust: (Some(f), Some(biome)) => {
    // rust: f.biome_in_tag(biome, "minecraft:produces_corals_from_bonemeal")
}
    // rust: _ => false,
}
    // rust: if corals {
    // rust: if j == 0 && face.is_some_and(|f| !matches!(f, Direction::Up | Direction::Down)) {
    // rust: if let Some(coral) = self.random_tag_element("minecraft:wall_corals") {
    // rust: grow = coral;
    // rust: if b.table.has(grow, b.props.facing) {
    // rust: grow = b.table.set_dir(grow, b.props.facing, face.unwrap());
}
}
    // rust: } else if self.next_int(4) == 0
    // rust: && let Some(plant) = self.random_tag_element("minecraft:underwater_bonemeals")
    // rust: {
    // rust: grow = plant;
}
}
    // rust: if self.in_tag(grow, "minecraft:wall_corals") && b.table.has(grow, b.props.facing) {
    // rust: let mut d = 0;
    // rust: while !self.can_survive(grow, test) && d < 4 {
    // rust: let facing = HORIZONTAL[self.next_int(4) as usize];
    // rust: grow = b.table.set_dir(grow, b.props.facing, facing);
    // rust: d += 1;
}
}
    // rust: if self.can_survive(grow, test) {
    // rust: let test_state = self.state(test);
    // rust: if b.is_block(test_state, b.named.water) && b.fluid(test_state).amount() == 8 {
    // rust: self.set_block_and_update(test, grow);
    // rust: } else if b.is_block(test_state, b.named.seagrass)
    // rust: && b.is_block(self.state(above(test)), b.named.water)
    // rust: && self.next_int(10) == 0
    // rust: {
    // rust: self.perform_bonemeal(Kind::Seagrass, test, test_state);
}
}
}
    // rust: true
}
    // `Registry.getRandomElementOf(tag, random)`: default state of a random member.
random_tag_element :: proc(self: ^Self, tag: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let features = self.b.live_features()?;
    // rust: let entries = features.block_tag_entries(tag);
    // rust: if entries.is_empty() {
    // rust: return None;
}
    // rust: let index = self.next_int(entries.len() as i32) as usize;
    // rust: self.block_named(&entries[index])
}
    // `GrassBlock.performBonemeal`.
grass_bonemeal :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let start = above(pos);
    // rust: 'attempts: for attempt in 0..128 {
    // rust: let mut test = start;
    // rust: for _ in 0..attempt / 16 {
    // rust: let dx = self.next_int(3) - 1;
    // rust: let dy = (self.next_int(3) - 1) * self.next_int(3) / 2;
    // rust: let dz = self.next_int(3) - 1;
    // rust: test = test.offset(dx, dy, dz);
                // stopBonemealSpread
    // rust: if !b.is_block(self.below_state(test), block) || b.full_collision(self.state(test))
    // rust: {
    // rust: continue 'attempts;
}
}
    // rust: self.grass_bonemeal_effect(test);
}
}
    // `GrassBlock.placeBonemealEffect`.
grass_bonemeal_effect :: proc(self: ^Self, test: BlockPos) {
}
    // rust: let b = self.b;
    // rust: let test_state = self.state(test);
    // rust: if b.table.name(test_state) == "minecraft:short_grass"
    // rust: && self.random().next_float() < 0.1
    // rust: && self.bonemeal_valid(Kind::TallGrass, test, test_state)
    // rust: {
    // rust: self.perform_bonemeal(Kind::TallGrass, test, test_state);
}
    // rust: if b.is_air(test_state) && self.is_inside_build_height(test.y) {
    // rust: if self.random().next_float() < 0.125 {
    // rust: let Some(features) = b.live_features() else {
    // rust: return;
}
    // rust: let Some(biome) = self
    // rust: .level
    // rust: .biome_name(test)
    // rust: .and_then(|name| features.biome_id(name))
    // rust: else {
    // rust: return;
}
    // rust: let list = features.bone_meal_features(biome);
    // rust: if list.is_empty() {
    // rust: return;
}
    // rust: let feature = list[self.next_int(list.len() as i32) as usize].clone();
    // rust: self.place_configured_feature(&feature, test);
    // rust: } else {
    // rust: self.place_placed_feature("minecraft:grass_bonemeal", test);
}
}
}
}

// What `StructurePlaceSettings` a `place_template` call sets.
TemplateSettings :: struct {
    mirror: crate::worldgen::structure::Mirror,
    rotation: crate::worldgen::structure::Rotation,
    ignore_entities: bool,
    known_shape: bool,
    // `BlockRotProcessor`'s integrity; 1 places everything.
    integrity: f32,
    seed: i64,
    flags: i32,
}
