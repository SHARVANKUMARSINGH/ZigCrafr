//! Transpiled from Horizon Rust crate
//! Module: horizon-world_survive
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `canSurvive` and `VegetationBlock.mayPlaceOn` for every overriding class.
//! Rules mirror the natively-validated `block_survival` port; dispatch follows
//! the Java class chain so `super.canSurvive` reaches the next override.
// use super::{
    // rust: LevelAccess, Sim,
    // rust: classes::Class,
    // rust: query::is_horizontal,
    // rust: update::{HORIZONTAL, above, below, rel},
}
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, position::BlockPos};

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    /// `BlockState.canSurvive(level, pos)`.
pub fn can_survive(self: *Self, state: BlockStateId, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut survives = None;
    // rust: self.level.before_can_survive(pos, state, &mut survives);
    // rust: survives.unwrap_or_else(|| self.can_survive_at(0, state, pos))
}
pub fn can_survive_at(self: *Self, depth: usize, state: BlockStateId, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chain = &self.b.data(state).chain;
    // rust: for (index, class) in chain.iter().enumerate().skip(depth) {
    // rust: if let Some(result) = self.can_survive_class(*class, index, state, pos) {
    // rust: return result;
}
}
    // rust: true
}
    // rust: fn can_survive_class(
    // rust: &self,
    // rust: class: Class,
    // rust: depth: usize,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> Option<bool> {
    // rust: let b = self.b;
    // rust: let p = &b.props;
    // rust: let t = &b.tags;
    // rust: let n = &b.named;
    // rust: let block = b.block(state);
    // rust: Some(match class {
    // rust: Class::AmethystCluster | Class::ShelfMushroom | Class::BaseCoralWallFan => {
    // rust: let facing = b.facing(state);
    // rust: self.sturdy(rel(pos, facing.opposite()), facing)
}
    // rust: Class::BambooSapling | Class::BambooStalk => {
    // rust: b.in_set(self.below_state(pos), &t.supports_bamboo)
}
    // rust: Class::Banner | Class::Cake | Class::CandleCake | Class::StandingSign => {
    // rust: b.is_solid(self.below_state(pos))
}
    // rust: Class::BaseCoralPlantType | Class::LeafLitter => self.sturdy(below(pos), Direction::Up),
    // rust: Class::BasePressurePlate => {
    // rust: let below = below(pos);
    // rust: self.can_support_rigid_block(below) || self.can_support_center(below, Direction::Up)
}
    // rust: Class::BaseRail => self.can_support_rigid_block(below(pos)),
    // rust: Class::BaseTorch | Class::Candle => self.can_support_center(below(pos), Direction::Up),
    // rust: Class::Bell => {
    // rust: let connection = self.bell_connected_direction(state).opposite();
    // rust: if connection == Direction::Up {
    // rust: self.can_support_center(above(pos), Direction::Down)
    // rust: } else {
    // rust: self.sturdy(rel(pos, connection), connection.opposite())
}
}
    // rust: Class::BigDripleaf => {
    // rust: let below = self.below_state(pos);
    // rust: b.is_block(below, block)
    // rust: || b.is_block(below, n.big_dripleaf_stem)
    // rust: || b.in_set(below, &t.supports_big_dripleaf)
}
    // rust: Class::BigDripleafStem => {
    // rust: let below = self.below_state(pos);
    // rust: let above = self.above_state(pos);
    // rust: (b.is_block(below, block) || b.in_set(below, &t.supports_big_dripleaf))
    // rust: && (b.is_block(above, block) || b.is_block(above, n.big_dripleaf))
}
    // rust: Class::BubbleColumn => {
    // rust: let below = self.below_state(pos);
    // rust: b.is_block(below, block)
    // rust: || b.in_set(below, &t.enables_bubble_column_push_up)
    // rust: || b.in_set(below, &t.enables_bubble_column_drag_down)
}
    // rust: Class::Cactus => {
    // rust: for direction in HORIZONTAL {
    // rust: let at = rel(pos, direction);
    // rust: if b.is_solid(self.state(at)) || b.is_lava_fluid(self.fluid_at(at).kind()) {
    // rust: return Some(false);
}
}
    // rust: let below = self.below_state(pos);
    // rust: (b.is_block(below, block) || b.in_set(below, &t.supports_cactus))
    // rust: && !b.liquid(self.above_state(pos))
}
    // rust: Class::Carpet => !self.is_empty_block(below(pos)),
    // rust: Class::CeilingHangingSign => {
    // rust: b.is_face_sturdy_center(self.above_state(pos), Direction::Down)
}
    // rust: Class::ChorusFlower => {
    // rust: let below = self.below_state(pos);
    // rust: if b.is_block(below, n.chorus_plant) || b.in_set(below, &t.supports_chorus_flower) {
    // rust: return Some(true);
}
    // rust: if !b.is_air(below) {
    // rust: return Some(false);
}
    // rust: let mut one = false;
    // rust: for direction in HORIZONTAL {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: if b.is_block(neighbour, n.chorus_plant) {
    // rust: if one {
    // rust: return Some(false);
}
    // rust: one = true;
    // rust: } else if !b.is_air(neighbour) {
    // rust: return Some(false);
}
}
    // rust: one
}
    // rust: Class::ChorusPlant => {
    // rust: let below_state = self.below_state(pos);
    // rust: let vertical = !b.is_air(self.above_state(pos)) && !b.is_air(below_state);
    // rust: for direction in HORIZONTAL {
    // rust: let neighbour_pos = rel(pos, direction);
    // rust: if b.is_block(self.state(neighbour_pos), block) {
    // rust: if vertical {
    // rust: return Some(false);
}
    // rust: let under = self.below_state(neighbour_pos);
    // rust: if b.is_block(under, block) || b.in_set(under, &t.supports_chorus_plant) {
    // rust: return Some(true);
}
}
}
    // rust: b.is_block(below_state, block) || b.in_set(below_state, &t.supports_chorus_plant)
}
    // rust: Class::Cocoa => b.in_set(self.rel_state(pos, b.facing(state)), &t.supports_cocoa),
    // rust: Class::Crop => {
    // rust: self.raw_brightness(pos, 0) >= 8 && self.can_survive_at(depth + 1, state, pos)
}
    // rust: Class::Diode => b.is_face_sturdy_rigid(self.below_state(pos), Direction::Up),
    // rust: Class::Door => {
    // rust: let below_state = self.below_state(pos);
    // rust: if b.table.text(state, p.half) == "lower" {
    // rust: b.is_face_sturdy(below_state, Direction::Up)
    // rust: } else {
    // rust: b.is_block(below_state, block)
}
}
    // rust: Class::DoublePlant => {
    // rust: if b.table.text(state, p.half) != "upper" {
    // rust: return Some(self.can_survive_at(depth + 1, state, pos));
}
    // rust: let below_state = self.below_state(pos);
    // rust: b.is_block(below_state, block) && b.table.text(below_state, p.half) == "lower"
}
    // rust: Class::SmallDripleaf => {
    // rust: if b.table.text(state, p.half) == "upper" {
    // rust: return Some(self.can_survive_at(depth + 1, state, pos));
}
    // rust: let below = below(pos);
    // rust: self.may_place_on(state, self.state(below), below)
}
    // rust: Class::TallSeagrass => {
    // rust: if b.table.text(state, p.half) == "upper" {
    // rust: let below_state = self.below_state(pos);
    // rust: return Some(
    // rust: b.is_block(below_state, block)
    // rust: && b.table.text(below_state, p.half) == "lower",
    // rust: );
}
    // rust: let fluid = self.fluid_at(pos);
    // rust: self.can_survive_at(depth + 1, state, pos)
    // rust: && b.is_water_fluid(fluid.kind())
    // rust: && fluid.is_full()
}
    // rust: Class::PitcherCrop => {
    // rust: let lower =
    // rust: b.is_block(state, n.pitcher_crop) && b.table.text(state, p.half) == "lower";
    // rust: if lower && self.raw_brightness(pos, 0) < 8 {
    // rust: false
    // rust: } else {
    // rust: self.can_survive_at(depth + 1, state, pos)
}
}
    // rust: Class::FaceAttachedHorizontalDirectional => {
    // rust: let direction = self.face_attached_connected(state).opposite();
    // rust: self.sturdy(rel(pos, direction), direction.opposite())
}
    // rust: Class::Grindstone => true,
    // rust: Class::PistonHead => self.piston_head_can_survive(state, pos),
    // rust: Class::Farmland => {
    // rust: let above = self.above_state(pos);
    // rust: !b.is_solid(above) || b.in_set(above, &t.maintains_farmland)
}
    // rust: Class::Fire => {
    // rust: self.sturdy(below(pos), Direction::Up) || self.is_valid_fire_location(pos)
}
    // rust: Class::SoulFire => b.in_set(self.below_state(pos), &t.soul_fire_base_blocks),
    // rust: Class::Frogspawn => self.frogspawn_may_place_on(below(pos)),
    // rust: Class::GrowingPlant => {
    // rust: let data = b.data(state);
    // rust: let growth = data.growth_direction;
    // rust: let attached_pos = rel(pos, growth.opposite());
    // rust: let attached = self.state(attached_pos);
    // rust: if !self.growing_plant_can_attach_to(state, attached) {
    // rust: return Some(false);
}
    // rust: let (head, body) = self.growing_plant_pair(block);
    // rust: b.is_block(attached, head)
    // rust: || b.is_block(attached, body)
    // rust: || b.is_face_sturdy(attached, growth)
}
    // rust: Class::HangingMoss => {
    // rust: let neighbour = self.above_state(pos);
    // rust: b.multiface_can_attach(neighbour, Direction::Up) || b.is_block(neighbour, block)
}
    // rust: Class::HangingRoots => self.sturdy(above(pos), Direction::Down),
    // rust: Class::Ladder => {
    // rust: let facing = b.facing(state);
    // rust: self.sturdy(rel(pos, facing.opposite()), facing)
}
    // rust: Class::Lantern => {
    // rust: let direction = if b.table.bool(state, p.hanging) {
    // rust: Direction::Up
    // rust: } else {
    // rust: Direction::Down
}
    // rust: self.can_support_center(rel(pos, direction), direction.opposite())
}
    // rust: Class::MangrovePropagule => {
    // rust: if b.table.bool(state, p.hanging) {
    // rust: b.in_set(
    // rust: self.above_state(pos),
    // rust: &t.supports_hanging_mangrove_propagule,
    // rust: )
    // rust: } else {
    // rust: self.can_survive_at(depth + 1, state, pos)
}
}
    // rust: Class::MossyCarpet => {
    // rust: let below_state = self.below_state(pos);
    // rust: if b.table.bool(state, p.bottom) {
    // rust: !b.is_air(below_state)
    // rust: } else {
    // rust: b.is_block(below_state, block) && b.table.bool(below_state, p.bottom)
}
}
    // rust: Class::Multiface => {
    // rust: let mut any = false;
    // rust: for direction in Direction::ALL {
    // rust: if self.multiface_has_face(state, direction) {
    // rust: if !b.multiface_can_attach(self.rel_state(pos, direction), direction) {
    // rust: return Some(false);
}
    // rust: any = true;
}
}
    // rust: any
}
    // rust: Class::Mushroom => {
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: if b.in_set(below_state, &t.overrides_mushroom_light_requirement) {
    // rust: true
    // rust: } else {
    // rust: self.raw_brightness(pos, 0) < 13
    // rust: && self.may_place_on(state, below_state, below_pos)
}
}
    // rust: Class::Path => {
    // rust: let above = self.above_state(pos);
    // rust: !b.is_solid(above) || b.instance_of(above, Class::FenceGate)
}
    // rust: Class::RedstoneWallTorch | Class::WallTorch => {
    // rust: let facing = b.facing(state);
    // rust: self.sturdy(rel(pos, facing.opposite()), facing)
}
    // rust: Class::RedstoneWire => {
                // `RedstoneWireBlock.canSurvive`'s `canSurviveOn`, through
                // `support_state` so a retracting piston's moving base still
                // holds its dust (#4728).
    // rust: let below = below(pos);
    // rust: self.sturdy(below, Direction::Up) || b.is_block(self.state(below), n.hopper)
}
    // rust: Class::Scaffolding => self.scaffolding_distance(pos) < 7,
    // rust: Class::SeaPickle => {
    // rust: let below = below(pos);
    // rust: self.may_place_on(state, self.state(below), below)
}
    // rust: Class::SnowLayer => {
    // rust: let below_state = self.below_state(pos);
    // rust: if b.in_set(below_state, &t.cannot_support_snow_layer) {
    // rust: false
    // rust: } else if b.in_set(below_state, &t.support_override_snow_layer) {
    // rust: true
    // rust: } else {
    // rust: self.shape_info_at(below_state, below(pos)).full_faces
    // rust: & (1 << Direction::Up as u8)
    // rust: != 0
    // rust: || (b.is_block(below_state, block)
    // rust: && b.table.int(below_state, p.layers) == 8)
}
}
    // rust: Class::Speleothem => {
    // rust: let tip = b
    // rust: .table
    // rust: .dir(state, p.vertical_direction)
    // rust: .unwrap_or(Direction::Up);
    // rust: self.is_valid_speleothem_placement(block, pos, tip)
}
    // rust: Class::SporeBlossom => {
    // rust: self.can_support_center(above(pos), Direction::Down) && !self.is_water_at(pos)
}
    // rust: Class::SugarCane => {
    // rust: let below_state = self.below_state(pos);
    // rust: if b.is_block(below_state, block) {
    // rust: return Some(true);
}
    // rust: if b.in_set(below_state, &t.supports_sugar_cane) {
    // rust: let below = below(pos);
    // rust: for direction in HORIZONTAL {
    // rust: let at = rel(below, direction);
                        // Read block state before fluid state, matching vanilla's call order.
    // rust: let adjacent = self.state(at);
    // rust: let fluid = self.fluid_at(at);
    // rust: if b.fluid_in(fluid.kind(), b.fluid_tags.supports_sugar_cane_adjacently)
    // rust: || b.in_set(adjacent, &t.supports_sugar_cane_adjacently)
    // rust: {
    // rust: return Some(true);
}
}
}
    // rust: false
}
    // rust: Class::TripWireHook => {
    // rust: let facing = b.facing(state);
    // rust: is_horizontal(facing) && self.sturdy(rel(pos, facing.opposite()), facing)
}
    // rust: Class::Vegetation => {
    // rust: let below = below(pos);
    // rust: self.may_place_on(state, self.state(below), below)
}
    // rust: Class::Vine => {
    // rust: let updated = self.vine_updated_state(state, pos);
    // rust: self.vine_count_faces(updated) > 0
}
    // rust: Class::WallBanner | Class::WallSign => {
    // rust: b.is_solid(self.rel_state(pos, b.facing(state).opposite()))
}
    // rust: _ => return None,
    // rust: })
}

    /// `VegetationBlock.mayPlaceOn` (virtual) for `state`'s block.
    // rust: pub fn may_place_on(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: ground: BlockStateId,
    // rust: ground_pos: BlockPos,
    // rust: ) -> bool {
    // rust: let mut may = None;
    // rust: self.level
    // rust: .before_may_place_on(state, ground, ground_pos, &mut may);
    // rust: if let Some(may) = may {
    // rust: return may;
}
    // rust: let b = self.b;
    // rust: let t = &b.tags;
    // rust: let data = b.data(state);
    // rust: for class in &data.chain {
    // rust: let result = match class {
    // rust: Class::AttachedStem | Class::NetherFungus | Class::NetherRoots | Class::Stem => {
    // rust: data.support_tag
    // rust: .as_ref()
    // rust: .is_some_and(|tag| b.in_set(ground, tag))
}
    // rust: Class::Azalea => b.in_set(ground, &t.supports_azalea),
    // rust: Class::CactusFlower => {
    // rust: let below = self.state(ground_pos);
    // rust: b.in_set(below, &t.support_override_cactus_flower)
    // rust: || b.is_face_sturdy_center(below, Direction::Up)
}
    // rust: Class::Crop | Class::PitcherCrop => b.in_set(ground, &t.supports_crops),
    // rust: Class::DryVegetation => b.in_set(ground, &t.supports_dry_vegetation),
    // rust: Class::LilyPad => {
    // rust: let fluid = self.fluid_at(ground_pos);
    // rust: let above = self.fluid_at(above(ground_pos));
    // rust: (b.fluid_in(fluid.kind(), b.fluid_tags.supports_lily_pad)
    // rust: || b.in_set(ground, &t.supports_lily_pad))
    // rust: && above.kind() == crate::fluid::FluidKind::Empty
}
    // rust: Class::MangrovePropagule => b.in_set(ground, &t.supports_mangrove_propagule),
    // rust: Class::Mushroom => b.solid_render(ground),
    // rust: Class::NetherSprouts => b.in_set(ground, &t.supports_nether_sprouts),
    // rust: Class::NetherWart => b.in_set(ground, &t.supports_nether_wart),
    // rust: Class::SeaPickle => {
    // rust: self.shape_info_at(ground, ground_pos).nonempty_faces
    // rust: & (1 << Direction::Up as u8)
    // rust: != 0
    // rust: || b.is_face_sturdy(ground, Direction::Up)
}
    // rust: Class::Seagrass | Class::TallSeagrass => {
    // rust: b.is_face_sturdy(ground, Direction::Up)
    // rust: && !b.in_set(ground, &t.cannot_support_seagrass)
}
    // rust: Class::SmallDripleaf => {
    // rust: b.in_set(ground, &t.supports_small_dripleaf)
    // rust: || (self.fluid_at(above(ground_pos)) == crate::fluid::FluidState::WATER
    // rust: && b.in_set(ground, &t.supports_vegetation))
}
    // rust: Class::WitherRose => b.in_set(ground, &t.supports_wither_rose),
    // rust: Class::Vegetation => b.in_set(ground, &t.supports_vegetation),
    // rust: _ => continue,
}
    // rust: return result;
}
    // rust: false
}

pub fn frogspawn_may_place_on(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let fluid = self.fluid_at(pos);
    // rust: let above = self.fluid_at(above(pos));
    // rust: (b.fluid_in(fluid.kind(), b.fluid_tags.supports_frogspawn)
    // rust: || b.in_set(self.state(pos), &b.tags.supports_frogspawn))
    // rust: && above.kind() == crate::fluid::FluidKind::Empty
}

    // rust: pub(crate) fn bell_connected_direction(&self, state: BlockStateId) -> Direction {
    // rust: match self.b.table.text(state, self.b.props.attachment) {
    // rust: "floor" => Direction::Up,
    // rust: "ceiling" => Direction::Down,
    // rust: _ => self.b.facing(state).opposite(),
}
}
    /// `FaceAttachedHorizontalDirectionalBlock.getConnectedDirection`.
    // rust: pub(crate) fn face_attached_connected(&self, state: BlockStateId) -> Direction {
    // rust: match self.b.table.text(state, self.b.props.face) {
    // rust: "ceiling" => Direction::Down,
    // rust: "floor" => Direction::Up,
    // rust: _ => self.b.facing(state),
}
}
    // rust: pub(crate) fn multiface_has_face(&self, state: BlockStateId, direction: Direction) -> bool {
    // rust: self.b.table.bool(state, self.direction_prop(direction))
}
    // rust: pub(crate) fn direction_prop(&self, direction: Direction) -> super::states::PropKey {
    // rust: let p = &self.b.props;
    // rust: match direction {
    // rust: Direction::Down => p.down,
    // rust: Direction::Up => p.up,
    // rust: Direction::North => p.north,
    // rust: Direction::South => p.south,
    // rust: Direction::West => p.west,
    // rust: Direction::East => p.east,
}
}
    /// Head and body blocks of a growing-plant family.
    // rust: pub(crate) fn growing_plant_pair(
    // rust: &self,
    // rust: block: super::states::BlockId,
    // rust: ) -> (super::states::BlockId, super::states::BlockId) {
    // rust: let name = &*self.b.table.info(block).name;
    // rust: let head = name.strip_suffix("_plant").unwrap_or(name);
    // rust: let head = self.b.table.block_by_name(head).unwrap_or(block);
    // rust: let body = self
    // rust: .b
    // rust: .table
    // rust: .block_by_name(&format!("{}_plant", &*self.b.table.info(head).name))
    // rust: .unwrap_or(block);
    // rust: (head, body)
}
    /// `GrowingPlantBlock.canAttachTo` (kelp refuses `cannot_support_kelp`).
pub fn growing_plant_can_attach_to(self: *Self, state: BlockStateId, attached: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::Kelp) || b.instance_of(state, Class::KelpPlant) {
    // rust: !b.in_set(attached, &b.tags.cannot_support_kelp)
    // rust: } else {
    // rust: true
}
}
    /// `FireBlock.isValidFireLocation`.
    // rust: pub(crate) fn is_valid_fire_location(&self, pos: BlockPos) -> bool {
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .any(|direction| self.can_burn(self.rel_state(pos, direction)))
}
    /// `FireBlock.canBurn`: ignite odds above zero (waterlogged states never burn).
    // rust: pub(crate) fn can_burn(&self, state: BlockStateId) -> bool {
    // rust: self.ignite_odds(state) > 0
}
    // rust: pub(crate) fn ignite_odds(&self, state: BlockStateId) -> i32 {
    // rust: self.fire_odds(state).0
}
    // rust: pub(crate) fn burn_odds(&self, state: BlockStateId) -> i32 {
    // rust: self.fire_odds(state).1
}
    /// `FireBlock.getIgniteOdds` and `getBurnOdds`: the level's answer, else
    /// `FireBlock.bootStrap`'s table.
pub fn fire_odds(self: *Self, state: BlockStateId) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.b.is_waterlogged(state) {
    // rust: return (0, 0);
}
    // rust: let mut odds = None;
    // rust: self.level.before_fire_odds(state, &mut odds);
    // rust: odds.unwrap_or_else(|| {
    // rust: let data = self.b.data(state);
    // rust: (data.ignite_odds, data.burn_odds)
    // rust: })
}
    /// `CampfireBlock.isSmokeSource`: a hay bale, unless the level answers.
    // rust: pub(crate) fn is_smoke_source(&self, state: BlockStateId) -> bool {
    // rust: let mut smoke = None;
    // rust: self.level.before_smoke_source(state, &mut smoke);
    // rust: smoke.unwrap_or_else(|| {
    // rust: self.b
    // rust: .table
    // rust: .block_by_name("minecraft:hay_block")
    // rust: .is_some_and(|hay| self.b.is_block(state, hay))
    // rust: })
}
    /// `ScaffoldingBlock.getDistance`.
    // rust: pub(crate) fn scaffolding_distance(&self, pos: BlockPos) -> i32 {
    // rust: let b = self.b;
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: let mut distance = 7;
    // rust: if b.is_block(below_state, b.named.scaffolding) {
    // rust: distance = b.table.int(below_state, b.props.distance);
    // rust: } else if b.is_face_sturdy(below_state, Direction::Up) {
    // rust: return 0;
}
    // rust: for direction in HORIZONTAL {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: if b.is_block(neighbour, b.named.scaffolding) {
    // rust: distance = distance.min(b.table.int(neighbour, b.props.distance) + 1);
    // rust: if distance == 1 {
    // rust: break;
}
}
}
    // rust: distance
}
    /// `SpeleothemBlock.isValidSpeleothemPlacement`.
    // rust: pub(crate) fn is_valid_speleothem_placement(
    // rust: &self,
    // rust: block: super::states::BlockId,
    // rust: pos: BlockPos,
    // rust: tip: Direction,
    // rust: ) -> bool {
    // rust: let behind_pos = rel(pos, tip.opposite());
    // rust: let behind = self.state(behind_pos);
    // rust: self.b.is_face_sturdy(behind, tip)
    // rust: || (self.b.is_block(behind, block)
    // rust: && self.b.table.dir(behind, self.b.props.vertical_direction) == Some(tip))
}
    /// `VineBlock.getUpdatedState`.
    // rust: pub(crate) fn vine_updated_state(
    // rust: &self,
    // rust: mut state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let p = &b.props;
    // rust: let above_pos = above(pos);
    // rust: if b.table.bool(state, p.up) {
    // rust: let accept = b.multiface_can_attach(self.state(above_pos), Direction::Down);
    // rust: state = b.table.set_bool(state, p.up, accept);
}
    // rust: let mut above_state = None;
    // rust: for direction in HORIZONTAL {
    // rust: let key = self.direction_prop(direction);
    // rust: if b.table.bool(state, key) {
    // rust: let mut support = self.vine_can_support_at_face(state, pos, direction);
    // rust: if !support {
    // rust: let above = *above_state.get_or_insert_with(|| self.state(above_pos));
    // rust: support = b.is_block(above, b.block(state)) && b.table.bool(above, key);
}
    // rust: state = b.table.set_bool(state, key, support);
}
}
    // rust: state
}
    // rust: fn vine_can_support_at_face(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: if direction == Direction::Down {
    // rust: return false;
}
    // rust: if b.multiface_can_attach(self.rel_state(pos, direction), direction) {
    // rust: return true;
}
    // rust: if direction == Direction::Up {
    // rust: return false;
}
    // rust: let above = self.above_state(pos);
    // rust: b.is_block(above, b.block(state)) && b.table.bool(above, self.direction_prop(direction))
}
    // rust: pub(crate) fn vine_count_faces(&self, state: BlockStateId) -> usize {
    // rust: [
    // rust: Direction::Up,
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ]
    // rust: .into_iter()
    // rust: .filter(|d| self.b.table.bool(state, self.direction_prop(*d)))
    // rust: .count()
}
}
