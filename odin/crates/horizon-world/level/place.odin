//! Transpiled from Horizon Rust crate
package horizon_world_place

import "core:fmt"
import "core:mem"
import "core:math"

// Block placement: `BlockItem.place`, `BlockPlaceContext`,
// `canBeReplaced(state, context)` and `getStateForPlacement` for every
// overriding class.
// use super::{
    // rust: Behaviours, LevelAccess, LevelEvent, Sim, Ticks,
    // rust: classes::Class,
    // rust: data::ItemKind,
    // rust: query::{axis_of, clockwise, counter_clockwise, is_horizontal},
    // rust: states::BlockId,
    // rust: update::{HORIZONTAL, above, below, rel},
}
// use crate::{fluid::FluidState, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::{Axis, Direction, Vec3, trig},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

// A player's use-item-on-block action (`UseOnContext` inputs).
PlaceContext :: struct {
    // The block that was hit (`BlockHitResult.getBlockPos`).
    clicked_pos: BlockPos,
    // The face that was hit.
    face: Direction,
    // Absolute hit location.
    hit: Vec3,
    // `BlockHitResult.isInside`.
    inside: bool,
    // Player view rotation in degrees (`getYRot`, `getXRot`).
    yaw: f32,
    pitch: f32,
    // `isSecondaryUseActive` (sneaking).
    sneaking: bool,
    // The item in hand (registry name, e.g. `minecraft:oak_stairs`).
    item: string,
    // `Player.canUseGameMasterBlocks` (creative operator); gates command,
    // structure, jigsaw and test blocks.
    can_use_game_master_blocks: bool,
}

PlaceOutcome :: enum {
    // The block was placed (the caller consumes the item).
    Placed { pos: BlockPos, state: BlockStateId },
    // `InteractionResult.FAIL`.
    Failed,
}

// `BlockPlaceContext` after resolving the replaced position: what
// `Block.getStateForPlacement` reads, and what a mod block is handed when it
// chooses the state it is placed in
// (`LevelAccess::before_state_for_placement`).
PlacementContext :: struct {
    // Where the block would go (`getClickedPos`): the clicked block itself
    // when it can be replaced, else the block beside it.
    pos: BlockPos,
    // The block that was clicked (`getHitResult().getBlockPos`).
    hit_pos: BlockPos,
    // The face that was clicked (`getClickedFace`).
    face: Direction,
    // Where the click landed (`getClickLocation`).
    hit: Vec3,
    // `BlockHitResult.isInside`: the click hit the inside of the clicked
    // block's shape.
    inside: bool,
    // The placer's rotation, in degrees (`getRotation`).
    yaw: f32,
    pitch: f32,
    // `isSecondaryUseActive`: the player placing it is sneaking.
    sneaking: bool,
    // The item in the placer's hand (`getItemInHand().getItem()`), as its
    // registry name: `minecraft:oak_stairs`.
    item: string,
    // Whether the clicked block is replaceable (`replacingClickedOnBlock`),
    // i.e. whether the block goes into the clicked position.
    replace_clicked: bool,
}

// `Direction.orderedByNearest(entity)`.
    // rust: pub(crate) fn ordered_by_nearest(yaw: f32, pitch: f32) -> [Direction; 6] {
    // rust: let pitch_rad = pitch * (std::f32::consts::PI / 180.0);
    // rust: let yaw_rad = -yaw * (std::f32::consts::PI / 180.0);
    // rust: let pitch_sin = trig::sin(f64::from(pitch_rad));
    // rust: let pitch_cos = trig::cos(f64::from(pitch_rad));
    // rust: let yaw_sin = trig::sin(f64::from(yaw_rad));
    // rust: let yaw_cos = trig::cos(f64::from(yaw_rad));
    // rust: let x_pos = yaw_sin > 0.0;
    // rust: let y_pos = pitch_sin < 0.0;
    // rust: let z_pos = yaw_cos > 0.0;
    // rust: let x_yaw = if x_pos { yaw_sin } else { -yaw_sin };
    // rust: let y_mag = if y_pos { -pitch_sin } else { pitch_sin };
    // rust: let z_yaw = if z_pos { yaw_cos } else { -yaw_cos };
    // rust: let x_mag = x_yaw * pitch_cos;
    // rust: let z_mag = z_yaw * pitch_cos;
    // rust: let ax = if x_pos {
    // rust: Direction::East
    // rust: } else {
    // rust: Direction::West
}
    // rust: let ay = if y_pos {
    // rust: Direction::Up
    // rust: } else {
    // rust: Direction::Down
}
    // rust: let az = if z_pos {
    // rust: Direction::South
    // rust: } else {
    // rust: Direction::North
}
    // rust: let make = |a: Direction, b: Direction, c: Direction| {
    // rust: [a, b, c, c.opposite(), b.opposite(), a.opposite()]
}
    // rust: if x_yaw > z_yaw {
    // rust: if y_mag > x_mag {
    // rust: make(ay, ax, az)
    // rust: } else if z_mag > y_mag {
    // rust: make(ax, az, ay)
    // rust: } else {
    // rust: make(ax, ay, az)
}
    // rust: } else if y_mag > z_mag {
    // rust: make(ay, az, ax)
    // rust: } else if x_mag > y_mag {
    // rust: make(az, ax, ay)
    // rust: } else {
    // rust: make(az, ay, ax)
}
}

// `Direction.fromYRot`.
    // rust: pub(crate) fn from_y_rot(yaw: f64) -> Direction {
    // rust: let value = ((yaw / 90.0 + 0.5).floor() as i64 & 3) as i32;
    // rust: super::query::from_2d(value)
}

// `RotationSegment.convertToSegment(float)`.
    // rust: pub(crate) fn rotation_segment(degrees: f32) -> i32 {
    // rust: ((degrees * (16.0 / 360.0) + 0.5).floor() as i32) & 15
}
// `RotationSegment.convertToSegment(Direction)`.
rotation_segment_of :: proc(direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if !is_horizontal(direction) {
    // rust: 0
    // rust: } else {
    // rust: super::query::data_2d(direction) << 2
}
}

    // rust: impl PlacementContext {
horizontal_direction :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: from_y_rot(f64::from(self.yaw))
}
nearest_looking_directions :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut directions = ordered_by_nearest(self.yaw, self.pitch);
    // rust: if self.replace_clicked {
    // rust: return directions;
}
    // rust: let target = self.face.opposite();
    // rust: if let Some(index) = directions.iter().position(|d| *d == target) {
    // rust: if index > 0 {
    // rust: directions.copy_within(0..index, 1);
    // rust: directions[0] = target;
}
}
    // rust: directions
}
nearest_looking_direction :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: ordered_by_nearest(self.yaw, self.pitch)[0]
}
nearest_looking_vertical :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: if self.pitch < 0.0 {
    // rust: Direction::Up
    // rust: } else {
    // rust: Direction::Down
}
}
click_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.hit.y - f64::from(self.pos.y)
}
    // `UseOnContext.getClickedPos` vs `BlockPlaceContext.getClickedPos`.
half_from_click :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
        // true = bottom
    // rust: self.face != Direction::Down && (self.face == Direction::Up || self.click_y() <= 0.5)
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
item_is :: proc(self: ^Self, ctx: ^PlacementContext, block: BlockId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !ctx.item.is_empty() && *self.b.block_data(block).item == *ctx.item
}
    // `BlockState.canBeReplaced(BlockPlaceContext)`.
    // rust: pub(crate) fn can_be_replaced(&self, state: BlockStateId, ctx: &PlacementContext) -> bool {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(state);
    // rust: let data = b.data(state);
    // rust: let default = |sim: &Self| {
    // rust: b.is_replaceable(state) && (ctx.item.is_empty() || !sim.item_is(ctx, block))
}
    // rust: for class in &data.chain {
    // rust: return match class {
    // rust: Class::Candle => {
    // rust: (!ctx.sneaking && self.item_is(ctx, block) && b.table.int(state, p.candles) < 4)
    // rust: || default(self)
}
    // rust: Class::SeaPickle => {
    // rust: (!ctx.sneaking && self.item_is(ctx, block) && b.table.int(state, p.pickles) < 4)
    // rust: || default(self)
}
    // rust: Class::TurtleEgg => {
    // rust: (!ctx.sneaking && self.item_is(ctx, block) && b.table.int(state, p.eggs) < 4)
    // rust: || default(self)
}
    // rust: Class::FlowerBed => {
    // rust: (!ctx.sneaking
    // rust: && self.item_is(ctx, block)
    // rust: && b.table.int(state, p.flower_amount) < 4)
    // rust: || default(self)
}
    // rust: Class::LeafLitter => {
    // rust: (!ctx.sneaking
    // rust: && self.item_is(ctx, block)
    // rust: && b.table.int(state, p.segment_amount) < 4)
    // rust: || default(self)
}
    // rust: Class::GrowingPlantBody => {
    // rust: let (head, _) = self.growing_plant_pair(block);
    // rust: default(self) && !self.item_is(ctx, head)
}
    // rust: Class::Multiface => {
    // rust: !self.item_is(ctx, block)
    // rust: || Direction::ALL
    // rust: .into_iter()
    // rust: .any(|d| !self.multiface_has_face(state, d))
}
    // rust: Class::PitcherCrop => false,
    // rust: Class::Scaffolding => self.item_is(ctx, block),
    // rust: Class::Slab => {
    // rust: let kind = b.table.text(state, p.kind);
    // rust: if kind == "double" || !self.item_is(ctx, block) {
    // rust: false
    // rust: } else if ctx.replace_clicked {
    // rust: let above = ctx.hit.y - f64::from(ctx.hit_pos.y) > 0.5;
    // rust: if kind == "bottom" {
    // rust: ctx.face == Direction::Up || (above && is_horizontal(ctx.face))
    // rust: } else {
    // rust: ctx.face == Direction::Down || (!above && is_horizontal(ctx.face))
}
    // rust: } else {
    // rust: true
}
}
    // rust: Class::SnowLayer => {
    // rust: let layers = b.table.int(state, p.layers);
    // rust: if !self.item_is(ctx, block) || layers >= 8 {
    // rust: layers == 1
    // rust: } else if ctx.replace_clicked {
    // rust: ctx.face == Direction::Up
    // rust: } else {
    // rust: true
}
}
    // rust: Class::Vine => {
    // rust: let clicked = self.state(ctx.pos);
    // rust: if b.is_block(clicked, block) {
    // rust: self.vine_count_faces(clicked) < 5
    // rust: } else {
    // rust: default(self)
}
}
    // rust: _ => continue,
}
}
    // rust: default(self)
}

fluid_is_water_source :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.fluid_at(pos) == FluidState::WATER || {
    // rust: let f = self.fluid_at(pos);
    // rust: f.kind() == crate::fluid::FluidKind::Water
}
}

    // `Block.getStateForPlacement(context)` for `block`, after the level's
    // hook (`LevelAccess::before_state_for_placement`), which a mod block
    // answers for itself.
    // rust: pub(crate) fn state_for_placement(
    // rust: &mut self,
    // rust: block: BlockId,
    // rust: ctx: &PlacementContext,
    // rust: ) -> Option<BlockStateId> {
    // rust: let default = self.b.default_of(block);
    // rust: let fluid = self.fluid_at(ctx.pos);
    // rust: let mut answer = None;
    // rust: self.level
    // rust: .before_state_for_placement(default, ctx, fluid, &mut answer);
    // rust: match answer {
            // A mod's answer, for a state of the block being placed, as
            // vanilla's `getStateForPlacement` returns its own `defaultBlockState`
            // set out. Another block's answer, or an id past the state table
            // (which would panic the server), leaves vanilla's state as it is.
    // rust: Some(Some(new))
    // rust: if (new.0 as usize) < self.b.table.state_count() && self.b.block(new) == block =>
    // rust: {
    // rust: return Some(new);
}
            // Vanilla's `null` return: the block goes nowhere.
    // rust: Some(None) => return None,
    // rust: _ => {}
}
    // rust: self.placement_at(block, 0, ctx)
}

    // rust: fn placement_at(
    // rust: &mut self,
    // rust: block: BlockId,
    // rust: depth: usize,
    // rust: ctx: &PlacementContext,
    // rust: ) -> Option<BlockStateId> {
    // rust: let b = self.b;
    // rust: let chain = &b.block_data(block).chain;
    // rust: for (index, class) in chain.iter().copied().enumerate().skip(depth) {
    // rust: if let Some(result) = self.placement_class(class, index, block, ctx) {
    // rust: return result;
}
}
    // rust: Some(self.b.default_of(block))
}

    // rust: fn placement_class(
    // rust: &mut self,
    // rust: class: Class,
    // rust: depth: usize,
    // rust: block: BlockId,
    // rust: ctx: &PlacementContext,
    // rust: ) -> Option<Option<BlockStateId>> {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let t = &b.tags;
    // rust: let n = b.named;
    // rust: let table = &b.table;
    // rust: let default = b.default_of(block);
    // rust: let pos = ctx.pos;
    // rust: let water_source = self.fluid_is_water_source(pos);
    // rust: let wl = |state: BlockStateId| table.set_bool(state, p.waterlogged, water_source);
    // rust: macro_rules! sup {
    // rust: () => {
    // rust: self.placement_at(block, depth + 1, ctx)
}
}
    // rust: let horizontal = ctx.horizontal_direction();
    // rust: Some(match class {
    // rust: Class::AbstractBed => {
    // rust: let relative = rel(pos, horizontal);
    // rust: if self.can_be_replaced(self.state(relative), ctx) {
    // rust: Some(table.set_dir(default, p.facing, horizontal))
    // rust: } else {
    // rust: None
}
}
    // rust: Class::AbstractFurnace
    // rust: | Class::Beehive
    // rust: | Class::CarvedPumpkin
    // rust: | Class::ChiseledBookShelf
    // rust: | Class::Diode
    // rust: | Class::GlazedTerracotta
    // rust: | Class::Loom
    // rust: | Class::Stonecutter
    // rust: | Class::Vault => Some(table.set_dir(default, p.facing, horizontal.opposite())),
    // rust: Class::Repeater => {
    // rust: let state = sup!()?;
    // rust: let locked = self.diode_is_locked(pos, state);
    // rust: Some(table.set_bool(state, p.locked, locked))
}
    // rust: Class::EndPortalFrame => Some(table.set_bool(
    // rust: table.set_dir(default, p.facing, horizontal.opposite()),
    // rust: p.eye,
    // rust: false,
    // rust: )),
    // rust: Class::Lectern => Some(table.set_bool(
    // rust: table.set_dir(default, p.facing, horizontal.opposite()),
    // rust: p.has_book,
    // rust: false,
    // rust: )),
    // rust: Class::AbstractSkull => {
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: Some(table.set_bool(default, p.powered, signal))
}
    // rust: Class::Skull => {
    // rust: let state = sup!()?;
    // rust: Some(table.set_int(state, p.rotation, rotation_segment(ctx.yaw)))
}
    // rust: Class::WallSkull => {
    // rust: let mut state = sup!()?;
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if is_horizontal(direction) {
    // rust: state = table.set_dir(state, p.facing, direction.opposite());
    // rust: if !self.can_be_replaced(self.state(rel(pos, direction)), ctx) {
    // rust: return Some(Some(state));
}
}
}
    // rust: None
}
    // rust: Class::AmethystCluster => Some(table.set_dir(wl(default), p.facing, ctx.face)),
    // rust: Class::Anvil => Some(table.set_dir(default, p.facing, clockwise(horizontal))),
    // rust: Class::BambooStalk => {
    // rust: if self.fluid_at(pos).kind() != crate::fluid::FluidKind::Empty {
    // rust: return Some(None);
}
    // rust: let below_state = self.below_state(pos);
    // rust: if !b.in_set(below_state, &t.supports_bamboo) {
    // rust: None
    // rust: } else if b.is_block(below_state, n.bamboo_sapling) {
    // rust: Some(table.set_int(default, p.age, 0))
    // rust: } else if b.is_block(below_state, n.bamboo) {
    // rust: let age = if table.int(below_state, p.age) > 0 {
    // rust: 1
    // rust: } else {
    // rust: 0
}
    // rust: Some(table.set_int(default, p.age, age))
    // rust: } else {
    // rust: let above_state = self.above_state(pos);
    // rust: if b.is_block(above_state, n.bamboo) {
    // rust: Some(table.set_int(default, p.age, table.int(above_state, p.age)))
    // rust: } else {
    // rust: Some(b.default_of(n.bamboo_sapling))
}
}
}
    // rust: Class::Banner => {
    // rust: Some(table.set_int(default, p.rotation, rotation_segment(ctx.yaw + 180.0)))
}
    // rust: Class::StandingSign => Some(wl(table.set_int(
    // rust: default,
    // rust: p.rotation,
    // rust: rotation_segment(ctx.yaw + 180.0),
    // rust: ))),
    // rust: Class::Barrel | Class::Command | Class::Dispenser => Some(table.set_dir(
    // rust: default,
    // rust: p.facing,
    // rust: ctx.nearest_looking_direction().opposite(),
    // rust: )),
    // rust: Class::Observer => {
    // rust: Some(table.set_dir(default, p.facing, ctx.nearest_looking_direction()))
}
    // rust: Class::PistonBase => Some(table.set_bool(
    // rust: table.set_dir(
    // rust: default,
    // rust: p.facing,
    // rust: ctx.nearest_looking_direction().opposite(),
    // rust: ),
    // rust: p.extended,
    // rust: false,
    // rust: )),
    // rust: Class::Barrier
    // rust: | Class::HeavyCore
    // rust: | Class::SculkSensor
    // rust: | Class::SculkShrieker
    // rust: | Class::Chain
    // rust: | Class::MangroveRoots
    // rust: | Class::WaterloggedTransparent => {
    // rust: let state = if class == Class::Chain
    // rust: || class == Class::MangroveRoots
    // rust: || class == Class::WaterloggedTransparent
    // rust: {
    // rust: sup!()?
    // rust: } else {
    // rust: default
}
    // rust: Some(wl(state))
}
    // rust: Class::CalibratedSculkSensor => {
    // rust: let state = sup!()?;
    // rust: Some(table.set_dir(state, p.facing, horizontal))
}
    // rust: Class::BaseCoralPlantType | Class::Conduit => {
    // rust: let fluid = self.fluid_at(pos);
    // rust: Some(table.set_bool(
    // rust: default,
    // rust: p.waterlogged,
    // rust: b.is_water_fluid(fluid.kind()) && fluid.is_full(),
    // rust: ))
}
    // rust: Class::BaseCoralWallFan
    // rust: | Class::WallBanner
    // rust: | Class::WallSign
    // rust: | Class::WallTorch
    // rust: | Class::ShelfMushroom
    // rust: | Class::TripWireHook
    // rust: | Class::Ladder
    // rust: | Class::Cocoa => {
    // rust: if class == Class::Ladder && !ctx.replace_clicked {
    // rust: let behind = self.state(rel(pos, ctx.face.opposite()));
    // rust: if b.is_block(behind, block) && b.facing(behind) == ctx.face {
    // rust: return Some(None);
}
}
    // rust: let mut state = match class {
    // rust: Class::BaseCoralWallFan => sup!()?,
    // rust: Class::TripWireHook => {
    // rust: table.set_bool(table.set_bool(default, p.powered, false), p.attached, false)
}
    // rust: _ => default,
}
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if is_horizontal(direction) {
    // rust: let facing = if class == Class::Cocoa {
    // rust: direction
    // rust: } else {
    // rust: direction.opposite()
}
    // rust: state = table.set_dir(state, p.facing, facing);
    // rust: if self.can_survive(state, pos) {
    // rust: return Some(Some(match class {
    // rust: Class::WallSign | Class::Ladder => wl(state),
    // rust: _ => state,
    // rust: }));
}
}
}
    // rust: None
}
    // rust: Class::RedstoneWallTorch => {
    // rust: let wall = b.default_of(table.block_by_name("minecraft:wall_torch")?);
    // rust: let mut found = None;
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if is_horizontal(direction) {
    // rust: let state = table.set_dir(wall, p.facing, direction.opposite());
    // rust: if self.can_survive(state, pos) {
    // rust: found = Some(state);
    // rust: break;
}
}
}
    // rust: found.map(|state| table.set_dir(default, p.facing, b.facing(state)))
}
    // rust: Class::WallHangingSign => {
    // rust: let mut state = default;
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if is_horizontal(direction) && axis_of(direction) != axis_of(ctx.face) {
    // rust: state = table.set_dir(state, p.facing, direction.opposite());
    // rust: if self.can_survive(state, pos)
    // rust: && self.wall_hanging_sign_can_place(state, pos)
    // rust: {
    // rust: return Some(Some(wl(state)));
}
}
}
    // rust: None
}
    // rust: Class::CeilingHangingSign => {
    // rust: let above_pos = above(pos);
    // rust: let above_state = self.state(above_pos);
    // rust: let below_hanging = b
    // rust: .tag("minecraft:all_hanging_signs")
    // rust: .is_some_and(|tag| b.in_set(above_state, tag));
    // rust: let direction = from_y_rot(f64::from(ctx.yaw));
    // rust: let mut attached_to_middle =
    // rust: !b.collision_face_full(above_state, Direction::Down) || ctx.sneaking;
    // rust: if below_hanging && !ctx.sneaking {
    // rust: if b.instance_of(above_state, Class::WallHangingSign) {
    // rust: if axis_of(b.facing(above_state)) == axis_of(direction) {
    // rust: attached_to_middle = false;
}
    // rust: } else if table.has(above_state, p.rotation) {
    // rust: let segment = table.int(above_state, p.rotation);
    // rust: let above_direction = match segment {
    // rust: 0 => Some(Direction::North),
    // rust: 4 => Some(Direction::East),
    // rust: 8 => Some(Direction::South),
    // rust: 12 => Some(Direction::West),
    // rust: _ => None,
}
    // rust: if above_direction.is_some_and(|d| axis_of(d) == axis_of(direction)) {
    // rust: attached_to_middle = false;
}
}
}
    // rust: let segment = if !attached_to_middle {
    // rust: rotation_segment_of(direction.opposite())
    // rust: } else {
    // rust: rotation_segment(ctx.yaw + 180.0)
}
    // rust: Some(wl(table.set_int(
    // rust: table.set_bool(default, p.attached, attached_to_middle),
    // rust: p.rotation,
    // rust: segment,
    // rust: )))
}
    // rust: Class::BaseFire | Class::Fire | Class::SoulFire => Some(self.fire_state_for(pos)),
    // rust: Class::BaseRail => {
    // rust: let east_west = matches!(horizontal, Direction::East | Direction::West);
    // rust: let shape = if east_west {
    // rust: "east_west"
    // rust: } else {
    // rust: "north_south"
}
    // rust: Some(wl(table.set_text(default, p.shape, shape)))
}
    // rust: Class::Bell => {
    // rust: let face = ctx.face;
    // rust: if axis_of(face) == Axis::Y {
    // rust: let attachment = if face == Direction::Down {
    // rust: "ceiling"
    // rust: } else {
    // rust: "floor"
}
    // rust: let state = table.set_dir(
    // rust: table.set_text(default, p.attachment, attachment),
    // rust: p.facing,
    // rust: horizontal,
    // rust: );
    // rust: if self.can_survive(state, pos) {
    // rust: Some(state)
    // rust: } else {
    // rust: None
}
    // rust: } else {
    // rust: let double = match axis_of(face) {
    // rust: Axis::X => {
    // rust: self.sturdy(rel(pos, Direction::West), Direction::East)
    // rust: && self.sturdy(rel(pos, Direction::East), Direction::West)
}
    // rust: _ => {
    // rust: self.sturdy(rel(pos, Direction::North), Direction::South)
    // rust: && self.sturdy(rel(pos, Direction::South), Direction::North)
}
}
    // rust: let mut state = table.set_text(
    // rust: table.set_dir(default, p.facing, face.opposite()),
    // rust: p.attachment,
    // rust: if double { "double_wall" } else { "single_wall" },
    // rust: );
    // rust: if self.can_survive(state, pos) {
    // rust: return Some(Some(state));
}
    // rust: let floor = self.sturdy(below(pos), Direction::Up);
    // rust: state = table.set_text(
    // rust: state,
    // rust: p.attachment,
    // rust: if floor { "floor" } else { "ceiling" },
    // rust: );
    // rust: if self.can_survive(state, pos) {
    // rust: Some(state)
    // rust: } else {
    // rust: None
}
}
}
    // rust: Class::BigDripleaf => {
    // rust: let below_state = self.below_state(pos);
    // rust: let dripleaf_part = b.is_block(below_state, n.big_dripleaf)
    // rust: || b.is_block(below_state, n.big_dripleaf_stem);
    // rust: let facing = if dripleaf_part {
    // rust: b.facing(below_state)
    // rust: } else {
    // rust: horizontal.opposite()
}
    // rust: let source = self.fluid_at(pos) == FluidState::WATER;
    // rust: Some(table.set_dir(
    // rust: table.set_bool(default, p.waterlogged, source),
    // rust: p.facing,
    // rust: facing,
    // rust: ))
}
    // rust: Class::Campfire => {
    // rust: let water = self.fluid_at(pos).kind() == crate::fluid::FluidKind::Water;
    // rust: let smoke = self.is_smoke_source(self.below_state(pos));
    // rust: let state = table.set_bool(default, p.waterlogged, water);
    // rust: let state = table.set_bool(state, p.signal_fire, smoke);
    // rust: let state = table.set_bool(state, p.lit, !water);
    // rust: Some(table.set_dir(state, p.facing, horizontal))
}
    // rust: Class::Candle => {
    // rust: let current = self.state(pos);
    // rust: if b.is_block(current, block) {
    // rust: Some(table.cycle(current, p.candles))
    // rust: } else {
    // rust: let state = sup!()?;
    // rust: Some(wl(state))
}
}
    // rust: Class::SeaPickle => {
    // rust: let current = self.state(pos);
    // rust: if b.is_block(current, block) {
    // rust: Some(table.set_int(
    // rust: current,
    // rust: p.pickles,
    // rust: (table.int(current, p.pickles) + 1).min(4),
    // rust: ))
    // rust: } else {
    // rust: let state = sup!()?;
    // rust: Some(wl(state))
}
}
    // rust: Class::TurtleEgg => {
    // rust: let current = self.state(pos);
    // rust: if b.is_block(current, block) {
    // rust: Some(table.set_int(current, p.eggs, (table.int(current, p.eggs) + 1).min(4)))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::SnowLayer => {
    // rust: let current = self.state(pos);
    // rust: if b.is_block(current, block) {
    // rust: Some(table.set_int(
    // rust: current,
    // rust: p.layers,
    // rust: (table.int(current, p.layers) + 1).min(8),
    // rust: ))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::FlowerBed | Class::LeafLitter => {
    // rust: let current = self.state(pos);
    // rust: let key = if class == Class::FlowerBed {
    // rust: p.flower_amount
    // rust: } else {
    // rust: p.segment_amount
}
    // rust: if b.is_block(current, block) {
    // rust: Some(table.set_int(current, key, (table.int(current, key) + 1).min(4)))
    // rust: } else {
    // rust: Some(table.set_dir(default, p.facing, horizontal.opposite()))
}
}
    // rust: Class::Chest => {
    // rust: let mut kind = "single";
    // rust: let mut facing = horizontal.opposite();
    // rust: let face = ctx.face;
    // rust: if is_horizontal(face) && ctx.sneaking {
    // rust: if let Some(neighbour_facing) =
    // rust: self.chest_candidate_partner_facing(default, pos, face.opposite())
    // rust: {
    // rust: if axis_of(neighbour_facing) != axis_of(face) {
    // rust: facing = neighbour_facing;
    // rust: kind = if counter_clockwise(facing) == face.opposite() {
    // rust: "right"
    // rust: } else {
    // rust: "left"
}
}
}
}
    // rust: if kind == "single" && !ctx.sneaking {
    // rust: if self.chest_candidate_partner_facing(default, pos, clockwise(facing))
    // rust: == Some(facing)
    // rust: {
    // rust: kind = "left";
    // rust: } else if self.chest_candidate_partner_facing(
    // rust: default,
    // rust: pos,
    // rust: counter_clockwise(facing),
    // rust: ) == Some(facing)
    // rust: {
    // rust: kind = "right";
}
}
    // rust: let state =
    // rust: wl(table.set_text(table.set_dir(default, p.facing, facing), p.kind, kind));
    // rust: Some(self.copper_chest_least_oxidized(state, pos))
}
    // rust: Class::ChorusPlant => Some(self.chorus_plant_with_connections(pos, default)),
            // A content mod's connecting block (alone, PipeBlock places as
            // Block does).
    // rust: Class::Pipe if depth == 0 => Some(self.pipe_with_connections(pos, default)),
    // rust: Class::ConcretePowder => {
    // rust: let replaced = self.state(pos);
    // rust: if b.is_water_fluid(b.fluid(replaced).kind()) || self.concrete_touches_liquid(pos) {
    // rust: Some(b.data(default).link.map_or(default, |c| b.default_of(c)))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::CopperGolemStatue | Class::EnderChest | Class::Shelf => {
    // rust: let mut state = wl(table.set_dir(default, p.facing, horizontal.opposite()));
    // rust: if class == Class::Shelf {
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: state = table.set_bool(state, p.powered, signal);
}
    // rust: Some(state)
}
    // rust: Class::Coral => {
    // rust: if !self.coral_scan_for_water(pos) {
    // rust: let delay = 60 + self.random().next_int_bound(40).unwrap_or(0);
    // rust: self.schedule_tick(pos, block, delay);
}
    // rust: Some(default)
}
    // rust: Class::Crafter => {
    // rust: let front = ctx.nearest_looking_direction().opposite();
    // rust: let top = match front {
    // rust: Direction::Down => horizontal.opposite(),
    // rust: Direction::Up => horizontal,
    // rust: _ => Direction::Up,
}
    // rust: let orientation = format!(
    // rust: "{}_{}",
    // rust: super::states::direction_name(front),
    // rust: super::states::direction_name(top)
    // rust: );
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: Some(table.set_bool(
    // rust: table.set_text(default, p.orientation, &orientation),
    // rust: p.triggered,
    // rust: signal,
    // rust: ))
}
    // rust: Class::Jigsaw => {
    // rust: let front = ctx.face;
    // rust: let top = if axis_of(front) == Axis::Y {
    // rust: horizontal.opposite()
    // rust: } else {
    // rust: Direction::Up
}
    // rust: let orientation = format!(
    // rust: "{}_{}",
    // rust: super::states::direction_name(front),
    // rust: super::states::direction_name(top)
    // rust: );
    // rust: Some(table.set_text(default, p.orientation, &orientation))
}
    // rust: Class::CreakingHeart => {
    // rust: let state =
    // rust: table.set_text(default, p.axis, super::states::axis_name(axis_of(ctx.face)));
    // rust: Some(self.heart_placement(state, ctx.pos))
}
    // rust: Class::RotatedPillar | Class::InfestedRotatedPillar => {
    // rust: Some(table.set_text(default, p.axis, super::states::axis_name(axis_of(ctx.face))))
}
    // rust: Class::DecoratedPot => {
    // rust: let state = table.set_dir(default, p.facing, horizontal);
    // rust: Some(table.set_bool(wl(state), p.cracked, false))
}
    // rust: Class::Door => {
    // rust: if pos.y < self.level.max_y() - 1
    // rust: && self.can_be_replaced(self.state(above(pos)), ctx)
    // rust: {
    // rust: let powered =
    // rust: self.has_neighbor_signal(pos) || self.has_neighbor_signal(above(pos));
    // rust: let hinge = self.door_hinge(ctx);
    // rust: let state = table.set_dir(default, p.facing, horizontal);
    // rust: let state = table.set_text(state, p.hinge, hinge);
    // rust: let state =
    // rust: table.set_bool(table.set_bool(state, p.powered, powered), p.open, powered);
    // rust: Some(table.set_text(state, p.half, "lower"))
    // rust: } else {
    // rust: None
}
}
    // rust: Class::DoublePlant => {
    // rust: if pos.y < self.level.max_y() - 1
    // rust: && self.can_be_replaced(self.state(above(pos)), ctx)
    // rust: {
    // rust: sup!()
    // rust: } else {
    // rust: None
}
}
    // rust: Class::PitcherCrop => Some(default),
    // rust: Class::SmallDripleaf => {
    // rust: let state = sup!()?;
    // rust: let state = table.set_dir(state, p.facing, horizontal.opposite());
    // rust: let water = self.is_water_at(pos);
    // rust: Some(
    // rust: table
    // rust: .with_bool(state, p.waterlogged, water)
    // rust: .unwrap_or(state),
    // rust: )
}
    // rust: Class::TallSeagrass => {
    // rust: let state = sup!()?;
    // rust: let fluid = self.fluid_at(above(pos));
    // rust: if b.is_water_fluid(fluid.kind()) && fluid.is_full() {
    // rust: Some(state)
    // rust: } else {
    // rust: None
}
}
    // rust: Class::DriedGhast => {
    // rust: let state = sup!()?;
    // rust: Some(table.set_dir(wl(state), p.facing, horizontal.opposite()))
}
    // rust: Class::EndRod => {
    // rust: let behind = self.state(rel(pos, ctx.face.opposite()));
    // rust: if b.is_block(behind, block) && b.facing(behind) == ctx.face {
    // rust: Some(table.set_dir(default, p.facing, ctx.face.opposite()))
    // rust: } else {
    // rust: Some(table.set_dir(default, p.facing, ctx.face))
}
}
    // rust: Class::LightningRod => Some(wl(table.set_dir(default, p.facing, ctx.face))),
    // rust: Class::ShulkerBox => Some(table.set_dir(default, p.facing, ctx.face)),
    // rust: Class::FaceAttachedHorizontalDirectional => {
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: let state = if axis_of(direction) == Axis::Y {
    // rust: let face = if direction == Direction::Up {
    // rust: "ceiling"
    // rust: } else {
    // rust: "floor"
}
    // rust: table.set_dir(table.set_text(default, p.face, face), p.facing, horizontal)
    // rust: } else {
    // rust: table.set_dir(
    // rust: table.set_text(default, p.face, "wall"),
    // rust: p.facing,
    // rust: direction.opposite(),
    // rust: )
}
    // rust: if self.can_survive(state, pos) {
    // rust: return Some(Some(state));
}
}
    // rust: None
}
    // rust: Class::Farmland => {
    // rust: if !self.can_survive(default, pos) {
    // rust: Some(b.default_of(b.data(default).link.unwrap_or(n.dirt)))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Path => {
    // rust: if !self.can_survive(default, pos) {
    // rust: Some(b.default_of(n.dirt))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Fence => {
    // rust: let mut state = sup!()?;
    // rust: for direction in HORIZONTAL {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: let sturdy = b.is_face_sturdy(neighbour, direction.opposite());
    // rust: let connect =
    // rust: self.fence_connects_to(default, neighbour, sturdy, direction.opposite());
    // rust: state = table.set_bool(state, self.direction_prop(direction), connect);
}
    // rust: Some(wl(state))
}
    // rust: Class::IronBars => {
    // rust: let mut state = default;
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: ] {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: let sturdy = b.is_face_sturdy(neighbour, direction.opposite());
    // rust: state = table.set_bool(
    // rust: state,
    // rust: self.direction_prop(direction),
    // rust: self.bars_attach_to(neighbour, sturdy),
    // rust: );
}
    // rust: Some(wl(state))
}
    // rust: Class::Wall => {
    // rust: let sides = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ]
    // rust: .map(|direction| {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: self.wall_connects_to(
    // rust: neighbour,
    // rust: b.is_face_sturdy(neighbour, direction.opposite()),
    // rust: direction.opposite(),
    // rust: )
    // rust: });
    // rust: let top_pos = above(pos);
    // rust: let top = self.state(top_pos);
    // rust: Some(self.wall_shape(wl(default), top_pos, top, sides))
}
    // rust: Class::FenceGate => {
    // rust: let open = self.has_neighbor_signal(pos);
    // rust: let wall = |sim: &Self, d: Direction| b.in_set(sim.rel_state(pos, d), &t.walls);
    // rust: let in_wall = match axis_of(horizontal) {
    // rust: Axis::Z => wall(self, Direction::West) || wall(self, Direction::East),
    // rust: _ => wall(self, Direction::North) || wall(self, Direction::South),
}
    // rust: let state = table.set_dir(default, p.facing, horizontal);
    // rust: let state = table.set_bool(table.set_bool(state, p.open, open), p.powered, open);
    // rust: Some(table.set_bool(state, p.in_wall, in_wall))
}
    // rust: Class::GrowingPlant => {
    // rust: let growth = b.block_data(block).growth_direction;
    // rust: let (head, body) = self.growing_plant_pair(block);
    // rust: let next = self.rel_state(pos, growth);
    // rust: if !b.is_block(next, head) && !b.is_block(next, body) {
    // rust: if b.block_data(block).is(Class::GrowingPlantHead) {
    // rust: let age = self.random().next_int_bound(25).unwrap_or(0);
    // rust: Some(table.set_int(default, p.age, age))
    // rust: } else {
    // rust: Some(default)
}
    // rust: } else {
    // rust: Some(b.default_of(body))
}
}
    // rust: Class::Kelp => {
    // rust: let fluid = self.fluid_at(pos);
    // rust: if b.is_water_fluid(fluid.kind()) && fluid.is_full() {
    // rust: sup!()
    // rust: } else {
    // rust: None
}
}
    // rust: Class::Seagrass => {
    // rust: let fluid = self.fluid_at(pos);
    // rust: if b.is_water_fluid(fluid.kind()) && fluid.is_full() {
    // rust: sup!()
    // rust: } else {
    // rust: None
}
}
    // rust: Class::HangingRoots => {
    // rust: let state = sup!()?;
    // rust: Some(wl(state))
}
    // rust: Class::Hopper => {
    // rust: let direction = ctx.face.opposite();
    // rust: let facing = if axis_of(direction) == Axis::Y {
    // rust: Direction::Down
    // rust: } else {
    // rust: direction
}
    // rust: Some(table.set_bool(table.set_dir(default, p.facing, facing), p.enabled, true))
}
    // rust: Class::HugeMushroom => {
    // rust: let mut state = default;
    // rust: for direction in Direction::ALL {
    // rust: let same = b.is_block(self.rel_state(pos, direction), block);
    // rust: state = table.set_bool(state, self.direction_prop(direction), !same);
}
    // rust: Some(state)
}
    // rust: Class::Lantern => {
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if axis_of(direction) == Axis::Y {
    // rust: let state = table.set_bool(default, p.hanging, direction == Direction::Up);
    // rust: if self.can_survive(state, pos) {
    // rust: return Some(Some(wl(state)));
}
}
}
    // rust: None
}
    // rust: Class::Leaves => {
    // rust: let state = wl(table.set_bool(default, p.persistent, true));
    // rust: let mut distance = 7;
    // rust: for direction in Direction::ALL {
    // rust: distance =
    // rust: distance.min(self.leaf_distance_at(self.rel_state(pos, direction)) + 1);
    // rust: if distance == 1 {
    // rust: break;
}
}
    // rust: Some(table.set_int(state, p.distance, distance))
}
    // rust: Class::MangrovePropagule => {
    // rust: let state = sup!()?;
    // rust: Some(table.set_int(wl(state), p.age, 4))
}
    // rust: Class::MossyCarpet => Some(self.mossy_carpet_updated_state(default, pos, true)),
    // rust: Class::Multiface => {
    // rust: let old = self.state(pos);
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if let Some(state) = self.multiface_placement(block, old, pos, direction) {
    // rust: return Some(Some(state));
}
}
    // rust: None
}
    // rust: Class::Note => Some(self.note_block_instrument(pos, default)),
    // rust: Class::RedstoneLamp => {
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: Some(table.set_bool(default, p.lit, signal))
}
    // rust: Class::RedstoneWire => {
    // rust: let cross = self.wire_cross_state(0);
    // rust: Some(self.wire_connection_state(cross, pos))
}
    // rust: Class::Scaffolding => {
    // rust: let distance = self.scaffolding_distance(pos);
    // rust: let bottom = self.scaffolding_is_bottom(pos, distance);
    // rust: let water = self.fluid_at(pos).kind() == crate::fluid::FluidKind::Water;
    // rust: let state = table.set_bool(default, p.waterlogged, water);
    // rust: Some(table.set_bool(table.set_int(state, p.distance, distance), p.bottom, bottom))
}
    // rust: Class::Slab => {
    // rust: let replaced = self.state(pos);
    // rust: if b.is_block(replaced, block) {
    // rust: return Some(Some(table.set_bool(
    // rust: table.set_text(replaced, p.kind, "double"),
    // rust: p.waterlogged,
    // rust: false,
    // rust: )));
}
    // rust: let result = wl(table.set_text(default, p.kind, "bottom"));
    // rust: if ctx.half_from_click() {
    // rust: Some(result)
    // rust: } else {
    // rust: Some(table.set_text(result, p.kind, "top"))
}
}
    // rust: Class::Stair => {
    // rust: let half = if ctx.half_from_click() {
    // rust: "bottom"
    // rust: } else {
    // rust: "top"
}
    // rust: let state =
    // rust: wl(table.set_text(table.set_dir(default, p.facing, horizontal), p.half, half));
    // rust: let shape = self.stairs_shape(state, pos);
    // rust: Some(table.set_text(state, p.shape, shape))
}
    // rust: Class::TrapDoor => {
    // rust: let mut state = if !ctx.replace_clicked && is_horizontal(ctx.face) {
    // rust: let top = ctx.hit.y - f64::from(pos.y) > 0.5;
    // rust: table.set_text(
    // rust: table.set_dir(default, p.facing, ctx.face),
    // rust: p.half,
    // rust: if top { "top" } else { "bottom" },
    // rust: )
    // rust: } else {
    // rust: let half = if ctx.face == Direction::Up {
    // rust: "bottom"
    // rust: } else {
    // rust: "top"
}
    // rust: table.set_text(
    // rust: table.set_dir(default, p.facing, horizontal.opposite()),
    // rust: p.half,
    // rust: half,
    // rust: )
}
    // rust: if self.has_neighbor_signal(pos) {
    // rust: state = table.set_bool(table.set_bool(state, p.open, true), p.powered, true);
}
    // rust: Some(wl(state))
}
    // rust: Class::Snowy => {
    // rust: let snowy = b.in_set(self.above_state(pos), &t.snow);
    // rust: Some(table.set_bool(default, p.snowy, snowy))
}
    // rust: Class::Speleothem => {
    // rust: let default_tip = ctx.nearest_looking_vertical().opposite();
    // rust: let tip = if self.is_valid_speleothem_placement(block, pos, default_tip) {
    // rust: default_tip
    // rust: } else if self.is_valid_speleothem_placement(block, pos, default_tip.opposite()) {
    // rust: default_tip.opposite()
    // rust: } else {
    // rust: return Some(None);
}
    // rust: let thickness = self.speleothem_thickness_for(block, pos, tip, !ctx.sneaking);
    // rust: let state = table.set_dir(default, p.vertical_direction, tip);
    // rust: Some(wl(table.set_text(state, p.thickness, thickness)))
}
    // rust: Class::TripWire => {
    // rust: let mut state = default;
    // rust: for direction in HORIZONTAL {
    // rust: let connect =
    // rust: self.tripwire_should_connect_to(self.rel_state(pos, direction), direction);
    // rust: state = table.set_bool(state, self.direction_prop(direction), connect);
}
    // rust: Some(state)
}
    // rust: Class::Vine => {
    // rust: let clicked = self.state(pos);
    // rust: let clicked_vine = b.is_block(clicked, block);
    // rust: let result = if clicked_vine { clicked } else { default };
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if direction != Direction::Down {
    // rust: let key = self.direction_prop(direction);
    // rust: let occupied = clicked_vine && table.bool(clicked, key);
    // rust: if !occupied && self.vine_can_support_at(result, pos, direction) {
    // rust: return Some(Some(table.set_bool(result, key, true)));
}
}
}
    // rust: if clicked_vine { Some(result) } else { None }
}
    // rust: Class::PotentSulfur => Some(self.potent_sulfur_state(default, pos)),
    // rust: Class::Nylium => sup!(),
    // rust: _ => return None,
    // rust: })
}

    // `CopperChestBlock.getLeastOxidizedChestOfConnectedBlocks`: a copper chest
    // joining another takes the less weathered of the two blocks (both unwaxed
    // when only one was waxed), keeping its own properties.
    // rust: pub(crate) fn copper_chest_least_oxidized(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> BlockStateId {
    // rust: let b = self.b;
    // rust: if !b.instance_of(state, Class::CopperChest)
    // rust: || b.table.text(state, b.props.kind) == "single"
    // rust: {
    // rust: return state;
}
    // rust: let connected = self.rel_state(pos, self.chest_connected_direction(state));
    // rust: if !b.instance_of(connected, Class::CopperChest) {
    // rust: return state;
}
    // rust: let name = |s: BlockStateId| b.table.name(s).trim_start_matches("minecraft:").to_owned();
    // rust: let weather = |n: &str| {
    // rust: let n = n.trim_start_matches("waxed_");
    // rust: ["exposed_", "weathered_", "oxidized_"]
    // rust: .iter()
    // rust: .position(|p| n.starts_with(p))
    // rust: .map_or(0, |i| i + 1)
}
    // rust: let (own, other) = (name(state), name(connected));
    // rust: let (mut own_block, mut other_block) = (own.clone(), other.clone());
    // rust: if own.starts_with("waxed_") != other.starts_with("waxed_") {
    // rust: own_block = own.trim_start_matches("waxed_").to_owned();
    // rust: other_block = other.trim_start_matches("waxed_").to_owned();
}
    // rust: let least = if weather(&own) <= weather(&other) {
    // rust: own_block
    // rust: } else {
    // rust: other_block
}
    // rust: match b.table.block_by_name(&format!("minecraft:{least}")) {
    // rust: Some(block) => b.table.with_properties_of(block, state),
    // rust: None => state,
}
}
    // `CopperChestBlock.getFromCopperBlock`: the copper chest a copper block
    // becomes under a copper golem's pumpkin, facing `facing`.
    // rust: pub(crate) fn copper_chest_from_block(
    // rust: &self,
    // rust: copper: BlockStateId,
    // rust: facing: Direction,
    // rust: pos: BlockPos,
    // rust: ) -> Option<BlockStateId> {
    // rust: let b = self.b;
    // rust: let block = b.table.name(copper).trim_start_matches("minecraft:");
    // rust: let chest = match block {
    // rust: "copper_block" => "copper_chest".to_owned(),
    // rust: "waxed_copper_block" => "waxed_copper_chest".to_owned(),
    // rust: n if n.ends_with("_copper") => format!("{n}_chest"),
    // rust: _ => "copper_chest".to_owned(),
}
    // rust: let block = b.table.block_by_name(&format!("minecraft:{chest}"))?;
    // rust: let default = b.default_of(block);
    // rust: let kind = if self.chest_candidate_partner_facing(default, pos, clockwise(facing))
    // rust: == Some(facing)
    // rust: {
    // rust: "left"
    // rust: } else if self.chest_candidate_partner_facing(default, pos, counter_clockwise(facing))
    // rust: == Some(facing)
    // rust: {
    // rust: "right"
    // rust: } else {
    // rust: "single"
}
    // rust: let state = b.table.set_text(
    // rust: b.table.set_dir(default, b.props.facing, facing),
    // rust: b.props.kind,
    // rust: kind,
    // rust: );
    // rust: Some(self.copper_chest_least_oxidized(state, pos))
}
    // rust: fn chest_candidate_partner_facing(
    // rust: &self,
    // rust: chest: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> Option<Direction> {
    // rust: let state = self.rel_state(pos, direction);
    // rust: if self.chest_can_connect_to(chest, state)
    // rust: && self.b.table.text(state, self.b.props.kind) == "single"
    // rust: {
    // rust: Some(self.b.facing(state))
    // rust: } else {
    // rust: None
}
}
    // A content mod's connecting block (a `PipeBlock` alone in its chain):
    // joined on each side to itself and to its `connects_to` tag.
    // rust: pub(crate) fn pipe_with_connections(&self, pos: BlockPos, state: BlockStateId) -> BlockStateId {
    // rust: let mut result = state;
    // rust: for direction in Direction::ALL {
    // rust: let connect = self.pipe_connects(state, self.rel_state(pos, direction));
    // rust: result = self
    // rust: .b
    // rust: .table
    // rust: .with_bool(result, self.direction_prop(direction), connect)
    // rust: .unwrap_or(result);
}
    // rust: result
}
    // Whether connecting block `state` joins `neighbour`.
    // rust: pub(crate) fn pipe_connects(&self, state: BlockStateId, neighbour: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: b.is_block(neighbour, b.block(state))
    // rust: || b.data(state)
    // rust: .support_tag
    // rust: .as_ref()
    // rust: .is_some_and(|t| b.in_set(neighbour, t))
}
    // `ChorusPlantBlock.getStateWithConnections`.
    // rust: pub(crate) fn chorus_plant_with_connections(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let flower = b.named.chorus_flower;
    // rust: let mut result = state;
    // rust: for direction in Direction::ALL {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: let mut connect = b.is_block(neighbour, block) || b.is_block(neighbour, flower);
    // rust: if direction == Direction::Down {
    // rust: connect |= b.in_set(neighbour, &b.tags.supports_chorus_plant);
}
    // rust: result = b
    // rust: .table
    // rust: .with_bool(result, self.direction_prop(direction), connect)
    // rust: .unwrap_or(result);
}
    // rust: result
}
wall_hanging_sign_can_place :: proc(self: ^Self, state: BlockStateId, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let facing = b.facing(state);
    // rust: let attach = |side: Direction, face: Direction| {
    // rust: let attach_state = self.rel_state(pos, side);
    // rust: if b.tag("minecraft:wall_hanging_signs")
    // rust: .is_some_and(|tag| b.in_set(attach_state, tag))
    // rust: {
    // rust: axis_of(b.facing(attach_state)) == axis_of(facing)
    // rust: } else {
    // rust: b.is_face_sturdy(attach_state, face)
}
}
    // rust: attach(clockwise(facing), counter_clockwise(facing))
    // rust: || attach(counter_clockwise(facing), clockwise(facing))
}
    // rust: fn multiface_placement(
    // rust: &self,
    // rust: block: BlockId,
    // rust: old: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> Option<BlockStateId> {
    // rust: let b = self.b;
    // rust: if b.is_block(old, block) && self.multiface_has_face(old, direction) {
    // rust: return None;
}
    // rust: if !b.multiface_can_attach(self.rel_state(pos, direction), direction) {
    // rust: return None;
}
    // rust: let state = if b.is_block(old, block) {
    // rust: old
    // rust: } else if b.fluid(old) == FluidState::WATER {
    // rust: b.table
    // rust: .set_bool(b.default_of(block), b.props.waterlogged, true)
    // rust: } else {
    // rust: b.default_of(block)
}
    // rust: Some(
    // rust: b.table
    // rust: .set_bool(state, self.direction_prop(direction), true),
    // rust: )
}
vine_can_support_at :: proc(self: ^Self, vine: BlockStateId, pos: BlockPos, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
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
    // rust: let above_state = self.above_state(pos);
    // rust: b.is_block(above_state, b.block(vine))
    // rust: && b.table.bool(above_state, self.direction_prop(direction))
}
    // rust: fn speleothem_thickness_for(
    // rust: &self,
    // rust: block: BlockId,
    // rust: pos: BlockPos,
    // rust: tip: Direction,
    // rust: merge: bool,
    // rust: ) -> &'static str {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let base = tip.opposite();
    // rust: let is_with = |state: BlockStateId, direction: Direction| {
    // rust: b.tag("minecraft:speleothems")
    // rust: .is_some_and(|tag| b.in_set(state, tag))
    // rust: && b.table.dir(state, p.vertical_direction) == Some(direction)
}
    // rust: let front = self.rel_state(pos, tip);
    // rust: if is_with(front, base) && b.is_block(front, block) {
    // rust: if !merge && b.table.text(front, p.thickness) != "tip_merge" {
    // rust: "tip"
    // rust: } else {
    // rust: "tip_merge"
}
    // rust: } else if !is_with(front, tip) {
    // rust: "tip"
    // rust: } else {
    // rust: let thickness = b.table.text(front, p.thickness);
    // rust: if thickness != "tip" && thickness != "tip_merge" {
    // rust: if !is_with(self.rel_state(pos, base), tip) {
    // rust: "base"
    // rust: } else {
    // rust: "middle"
}
    // rust: } else {
    // rust: "frustum"
}
}
}
    // `DoorBlock.getHinge`.
door_hinge :: proc(self: ^Self, ctx: ^PlacementContext) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let pos = ctx.pos;
    // rust: let place = ctx.horizontal_direction();
    // rust: let above_pos = above(pos);
    // rust: let left = counter_clockwise(place);
    // rust: let right = clockwise(place);
    // rust: let left_state = self.rel_state(pos, left);
    // rust: let left_above = self.rel_state(above_pos, left);
    // rust: let right_state = self.rel_state(pos, right);
    // rust: let right_above = self.rel_state(above_pos, right);
    // rust: let full = |s: BlockStateId| b.full_collision(s);
    // rust: let balance = -i32::from(full(left_state)) - i32::from(full(left_above))
    // rust: + i32::from(full(right_state))
    // rust: + i32::from(full(right_above));
    // rust: let lower_door = |s: BlockStateId| {
    // rust: b.instance_of(s, Class::Door) && b.table.text(s, b.props.half) == "lower"
}
    // rust: let door_left = lower_door(left_state);
    // rust: let door_right = lower_door(right_state);
    // rust: if (door_left && !door_right) || balance > 0 {
    // rust: return "right";
}
    // rust: if (door_right && !door_left) || balance < 0 {
    // rust: return "left";
}
    // rust: let step_x = place.normal()[0];
    // rust: let step_z = place.normal()[2];
    // rust: let click_x = ctx.hit.x - f64::from(pos.x);
    // rust: let click_z = ctx.hit.z - f64::from(pos.z);
    // rust: if (step_x >= 0 || click_z >= 0.5)
    // rust: && (step_x <= 0 || click_z <= 0.5)
    // rust: && (step_z >= 0 || click_x <= 0.5)
    // rust: && (step_z <= 0 || click_x >= 0.5)
    // rust: {
    // rust: "left"
    // rust: } else {
    // rust: "right"
}
}

    // `Block.setPlacedBy` for the blocks that place companions.
set_placed_by :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let data = b.data(state);
    // rust: let block = b.block(state);
    // rust: if data.is(Class::AbstractBed) {
    // rust: let other = rel(pos, b.facing(state));
    // rust: self.set_block_and_update(other, b.table.set_text(state, p.part, "head"));
    // rust: } else if data.is(Class::Crafter) {
    // rust: if b.table.bool(state, p.triggered) {
    // rust: self.schedule_tick(pos, block, 4);
}
    // rust: } else if data.is(Class::Diode) {
    // rust: if self.diode_should_turn_on(pos, state) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: } else if data.is(Class::Door) {
    // rust: self.set_block_and_update(above(pos), b.table.set_text(state, p.half, "upper"));
    // rust: } else if data.is(Class::DriedGhast) {
            // DriedGhastBlock.setPlacedBy: the place sound, the water one when waterlogged.
    // rust: let sound = if b.table.bool(state, p.waterlogged) {
    // rust: "minecraft:block.dried_ghast.place_in_water"
    // rust: } else {
    // rust: "minecraft:block.dried_ghast.place"
}
    // rust: self.sound(pos, &sound.into(), 1.0, 1.0);
    // rust: } else if data.is(Class::PitcherCrop) {
    // rust: } else if data.is(Class::SmallDripleaf) {
    // rust: let above_pos = above(pos);
    // rust: let upper = b.table.set_dir(
    // rust: b.table.set_text(b.default_of(block), p.half, "upper"),
    // rust: p.facing,
    // rust: b.facing(state),
    // rust: );
    // rust: let water = self.is_water_at(above_pos);
    // rust: let upper = b
    // rust: .table
    // rust: .with_bool(upper, p.waterlogged, water)
    // rust: .unwrap_or(upper);
    // rust: self.set_block_and_update(above_pos, upper);
    // rust: } else if data.is(Class::DoublePlant) {
    // rust: let above_pos = above(pos);
    // rust: let upper = b.table.set_text(b.default_of(block), p.half, "upper");
    // rust: let water = self.is_water_at(above_pos);
    // rust: let upper = b
    // rust: .table
    // rust: .with_bool(upper, p.waterlogged, water)
    // rust: .unwrap_or(upper);
    // rust: self.set_block_and_update(above_pos, upper);
    // rust: } else if data.is(Class::PistonBase) {
    // rust: self.piston_check_if_extend(pos, state);
    // rust: } else if data.is(Class::TripWireHook) {
    // rust: self.tripwire_hook_calculate(pos, state, false, false, -1, None);
    // rust: } else if data.is(Class::MossyCarpet) {
    // rust: let topper = self.mossy_carpet_topper(pos);
    // rust: if !b.is_air(topper) {
    // rust: self.set_block_and_update(above(pos), topper);
}
}
}
    // `MossyCarpetBlock.createTopperWithSideChance(level, pos, random::nextBoolean)`.
mossy_carpet_topper :: proc(self: ^Self, pos: BlockPos) -> B {
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
    // rust: let updated = self.mossy_carpet_updated_state(carpet, above_pos, true);
    // rust: let mut result = updated;
    // rust: for direction in HORIZONTAL {
    // rust: let key = self.direction_prop(direction);
    // rust: if b.table.text(result, key) != "none" && !self.random().next_boolean() {
    // rust: result = b.table.set_text(result, key, "none");
}
}
    // rust: if self.mossy_carpet_has_faces(result) && result != above_state {
    // rust: return result;
}
}
    // rust: b.air()
}

    // `BlockItem.place` (and its subclasses' overrides).
    // `BlockPlaceContext` resolution, `updatePlacementContext` and the item's
    // `getPlacementState` (survival and obstruction checks included).
    // rust: pub(crate) fn placement(
    // rust: &mut self,
    // rust: input: &PlaceContext,
    // rust: ) -> Option<(PlacementContext, super::data::ItemBinding, BlockStateId)> {
    // rust: let b = self.b;
    // rust: let binding = b.item_binding(&input.item).cloned()?;
    // rust: let mut ctx = PlacementContext {
    // rust: pos: input.clicked_pos,
    // rust: hit_pos: input.clicked_pos,
    // rust: face: input.face,
    // rust: hit: input.hit,
    // rust: inside: input.inside,
    // rust: yaw: input.yaw,
    // rust: pitch: input.pitch,
    // rust: sneaking: input.sneaking,
    // rust: item: input.item.clone(),
    // rust: replace_clicked: true,
}
    // rust: ctx.replace_clicked = self.can_be_replaced(self.state(input.clicked_pos), &ctx);
    // rust: if !ctx.replace_clicked {
    // rust: ctx.pos = rel(input.clicked_pos, input.face);
}
    // rust: if !ctx.replace_clicked && !self.can_be_replaced(self.state(ctx.pos), &ctx) {
    // rust: return None;
}
    // rust: if binding.kind == ItemKind::Scaffolding {
    // rust: ctx = self.scaffolding_update_context(&ctx, binding.block)?;
}
    // rust: if binding.game_master && !input.can_use_game_master_blocks {
    // rust: return None;
}
    // rust: let state = match binding.kind {
    // rust: ItemKind::StandingAndWall | ItemKind::HangingSign => {
    // rust: let wall = binding
    // rust: .wall_block
    // rust: .and_then(|wall| self.state_for_placement(wall, &ctx));
    // rust: let attachment = binding.attachment.unwrap_or(Direction::Down);
    // rust: let mut chosen = None;
    // rust: for direction in ctx.nearest_looking_directions() {
    // rust: if direction == attachment.opposite() {
    // rust: continue;
}
    // rust: let candidate = if direction == attachment {
    // rust: self.state_for_placement(binding.block, &ctx)
    // rust: } else {
    // rust: wall
}
    // rust: if let Some(candidate) = candidate {
    // rust: let hanging_ok = binding.kind != ItemKind::HangingSign
    // rust: || !b.instance_of(candidate, Class::WallHangingSign)
    // rust: || self.wall_hanging_sign_can_place(candidate, ctx.pos);
    // rust: if hanging_ok && self.can_survive(candidate, ctx.pos) {
    // rust: chosen = Some(candidate);
    // rust: break;
}
}
}
    // rust: chosen.filter(|state| self.level.is_unobstructed(ctx.pos, *state))
}
    // rust: _ => {
    // rust: let must_survive = binding.kind != ItemKind::Scaffolding;
    // rust: self.state_for_placement(binding.block, &ctx)
    // rust: .filter(|state| {
    // rust: (!must_survive || self.can_survive(*state, ctx.pos))
    // rust: && self.level.is_unobstructed(ctx.pos, *state)
    // rust: })
}
}
    // rust: state.map(|state| (ctx, binding, state))
}

    // `BlockItem.place` (and its subclasses' overrides).
    // rust: pub(crate) fn place(&mut self, input: &PlaceContext) -> PlaceOutcome {
    // rust: let b = self.b;
    // rust: let Some((ctx, binding, state)) = self.placement(input) else {
    // rust: return PlaceOutcome::Failed;
}
    // rust: if !self.is_in_valid_bounds(ctx.pos) {
    // rust: return PlaceOutcome::Failed;
}

    // rust: if binding.kind == ItemKind::DoubleHigh {
    // rust: let above_pos = above(ctx.pos);
    // rust: let replacement = if self.is_water_at(above_pos) {
    // rust: b.default_of(b.named.water)
    // rust: } else {
    // rust: b.air()
}
    // rust: self.set_block(above_pos, replacement, 27);
}
    // rust: if !self.set_block(ctx.pos, state, 11) {
    // rust: return PlaceOutcome::Failed;
}
    // rust: let placed = self.state(ctx.pos);
    // rust: if b.block(placed) == b.block(state) {
    // rust: self.set_placed_by(ctx.pos, placed);
}
    // rust: let placed = self.state(ctx.pos);
    // rust: let sounds = b.data(placed).sounds.clone();
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos: ctx.pos,
    // rust: sound: sounds.place.clone(),
    // rust: volume: (sounds.volume + 1.0) / 2.0,
    // rust: pitch: sounds.pitch * 0.8,
    // rust: });
    // rust: self.game_event_state(ctx.pos, "minecraft:block_place", placed);
    // rust: PlaceOutcome::Placed {
    // rust: pos: ctx.pos,
    // rust: state: placed,
}
}
    // `ScaffoldingBlockItem.updatePlacementContext`.
    // rust: fn scaffolding_update_context(
    // rust: &self,
    // rust: ctx: &PlacementContext,
    // rust: block: BlockId,
    // rust: ) -> Option<PlacementContext> {
    // rust: let b = self.b;
    // rust: let pos = ctx.pos;
    // rust: if !b.is_block(self.state(pos), block) {
    // rust: return if self.scaffolding_distance(pos) == 7 {
    // rust: None
    // rust: } else {
    // rust: Some(ctx.clone())
}
}
    // rust: let direction = if ctx.sneaking {
    // rust: if ctx.inside {
    // rust: ctx.face.opposite()
    // rust: } else {
    // rust: ctx.face
}
    // rust: } else if ctx.face == Direction::Up {
    // rust: ctx.horizontal_direction()
    // rust: } else {
    // rust: Direction::Up
}
    // rust: let mut horizontal_distance = 0;
    // rust: let mut placement = rel(pos, direction);
    // rust: while horizontal_distance < 7 {
    // rust: if !self.is_in_valid_bounds(placement) {
    // rust: break;
}
    // rust: let replaced = self.state(placement);
    // rust: if !b.is_block(replaced, block) {
    // rust: if self.can_be_replaced(replaced, ctx) {
    // rust: let [dx, dy, dz] = direction.normal();
    // rust: return Some(PlacementContext {
    // rust: pos: placement,
    // rust: hit_pos: placement,
    // rust: face: direction,
    // rust: hit: Vec3::new(
    // rust: f64::from(placement.x) + 0.5 + f64::from(dx) * 0.5,
    // rust: f64::from(placement.y) + 0.5 + f64::from(dy) * 0.5,
    // rust: f64::from(placement.z) + 0.5 + f64::from(dz) * 0.5,
    // rust: ),
    // rust: inside: false,
    // rust: replace_clicked: true,
    // rust: ..ctx.clone()
    // rust: });
}
    // rust: break;
}
    // rust: placement = rel(placement, direction);
    // rust: if is_horizontal(direction) {
    // rust: horizontal_distance += 1;
}
}
    // rust: None
}
}

    // rust: impl Behaviours {
    // `BlockItem.place` for the item in `ctx`: resolves the replaced
    // position, computes `getStateForPlacement`, checks survival and entity
    // obstruction, writes the block (flags 11), runs `setPlacedBy` (second
    // halves of doors, beds, tall plants) and reports the place sound.
    // rust: pub fn place_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: ctx: &PlaceContext,
    // rust: ) -> PlaceOutcome {
    // rust: self.sim(level, ticks).place(ctx)
}
    // `DirectionalPlaceContext.canPlace`: whether the block at the clicked
    // position can be replaced by the item (a dispenser places only there).
    // rust: pub fn directional_can_place<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: ctx: &PlaceContext,
    // rust: ) -> bool {
    // rust: let sim = self.sim(level, ticks);
    // rust: let inner = PlacementContext {
    // rust: pos: ctx.clicked_pos,
    // rust: hit_pos: ctx.clicked_pos,
    // rust: face: ctx.face,
    // rust: hit: ctx.hit,
    // rust: inside: ctx.inside,
    // rust: yaw: ctx.yaw,
    // rust: pitch: ctx.pitch,
    // rust: sneaking: ctx.sneaking,
    // rust: item: ctx.item.clone(),
    // rust: replace_clicked: true,
}
    // rust: sim.can_be_replaced(sim.state(ctx.clicked_pos), &inner)
}
    // The position and state `BlockItem.place` would place for `ctx`, without
    // writing anything (None when vanilla's placement fails).
    // rust: pub fn placement_state<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: ctx: &PlaceContext,
    // rust: ) -> Option<(BlockPos, BlockStateId)> {
    // rust: self.sim(level, ticks)
    // rust: .placement(ctx)
    // rust: .map(|(ctx, _, state)| (ctx.pos, state))
}
    // `getStateForPlacement` of `block` for `ctx` without placing anything
    // (`None` when vanilla refuses the placement). The position is resolved
    // as `BlockPlaceContext` does.
    // rust: pub fn state_for_placement<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: block: BlockId,
    // rust: input: &PlaceContext,
    // rust: ) -> Option<BlockStateId> {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let mut ctx = PlacementContext {
    // rust: pos: input.clicked_pos,
    // rust: hit_pos: input.clicked_pos,
    // rust: face: input.face,
    // rust: hit: input.hit,
    // rust: inside: input.inside,
    // rust: yaw: input.yaw,
    // rust: pitch: input.pitch,
    // rust: sneaking: input.sneaking,
    // rust: item: input.item.clone(),
    // rust: replace_clicked: true,
}
    // rust: ctx.replace_clicked = sim.can_be_replaced(sim.state(input.clicked_pos), &ctx);
    // rust: if !ctx.replace_clicked {
    // rust: ctx.pos = rel(input.clicked_pos, input.face);
}
    // rust: sim.state_for_placement(block, &ctx)
}
}
