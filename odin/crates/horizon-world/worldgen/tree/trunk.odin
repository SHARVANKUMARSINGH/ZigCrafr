//! Transpiled from Horizon Rust crate
package horizon_world_trunk

import "core:fmt"
import "core:mem"
import "core:math"

// Trunk placers (TrunkPlacer subclasses), in native random-draw order.
// use super::{
    // rust: FoliageAttachment, Layer, Run, TreeDecoder, TreeFeature, TreeResult, kind, read,
    // rust: sample_optional, sample_state, unit_float,
}
// use crate::registry::BlockStateId;
// use crate::worldgen::{
    // rust: DecodeError, Object,
    // rust: feature::FeatureWorld,
    // rust: int_range, optional,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: tree_blocks::{self as tb, Axis, TreeBlocks},
    // rust: value_provider::IntProvider,
}
// use horizon_core::{geometry::Direction, random::RandomSource};
// use serde_json::value::RawValue;
// use std::{collections::BTreeSet, sync::Arc};

Kind :: enum {
    Straight,
    Forking,
    Giant,
    MegaJungle,
    DarkOak,
    Fancy,
    Bending {,
    min_height_for_leaves: i32,
    bend_length: IntProvider,
    // rust: },
    UpwardsBranching {,
    extra_branch_steps: IntProvider,
    branch_probability: f32,
    extra_branch_length: IntProvider,
    can_grow_through: Arc<BTreeSet<BlockStateId>>,
    // rust: },
    Cherry {,
    branch_count: IntProvider,
    branch_horizontal_length: IntProvider,
    branch_start: [i32; 2],
    branch_end_offset: IntProvider,
    // rust: },
    Poplar {,
    trunk_height_above_branches: IntProvider,
    branch_amount: IntProvider,
    // rust: },
}
    // rust: pub(super) struct TrunkPlacer {
    // rust: base_height: i32,
    // rust: height_rand_a: i32,
    // rust: height_rand_b: i32,
    // rust: kind: Kind,
}

    // rust: fn random_horizontal(
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Result<Direction, horizon_core::random::InvalidBound> {
    // rust: Ok(tb::HORIZONTAL[random.next_int_bound(4)? as usize])
}

    // rust: impl TrunkPlacer {
    // rust: pub(super) fn decode(
    // rust: raw: &RawValue,
    // rust: decoder: &mut TreeDecoder<'_, '_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let base_height = int_range(required(&object, "base_height")?, "base_height", 0, 32)?;
    // rust: let height_rand_a = int_range(required(&object, "height_rand_a")?, "height_rand_a", 0, 24)?;
    // rust: let height_rand_b = int_range(required(&object, "height_rand_b")?, "height_rand_b", 0, 24)?;
    // rust: let kind = match kind(&object)?.as_str() {
    // rust: "minecraft:straight_trunk_placer" => Kind::Straight,
    // rust: "minecraft:forking_trunk_placer" => Kind::Forking,
    // rust: "minecraft:giant_trunk_placer" => Kind::Giant,
    // rust: "minecraft:mega_jungle_trunk_placer" => Kind::MegaJungle,
    // rust: "minecraft:dark_oak_trunk_placer" => Kind::DarkOak,
    // rust: "minecraft:fancy_trunk_placer" => Kind::Fancy,
    // rust: "minecraft:bending_trunk_placer" => Kind::Bending {
    // rust: min_height_for_leaves: optional(&object, "min_height_for_leaves")
    // rust: .map(|raw| int_range(raw, "min_height_for_leaves", 1, i32::MAX))
    // rust: .transpose()?
    // rust: .unwrap_or(1),
    // rust: bend_length: decoder.int_provider(required(&object, "bend_length")?, 1, 64)?,
    // rust: },
    // rust: "minecraft:upwards_branching_trunk_placer" => Kind::UpwardsBranching {
    // rust: extra_branch_steps: decoder.int_provider(
    // rust: required(&object, "extra_branch_steps")?,
    // rust: 1,
    // rust: i32::MAX,
    // rust: )?,
    // rust: branch_probability: unit_float(
    // rust: required(&object, "place_branch_per_log_probability")?,
    // rust: "place_branch_per_log_probability",
    // rust: )?,
    // rust: extra_branch_length: decoder.int_provider(
    // rust: required(&object, "extra_branch_length")?,
    // rust: 0,
    // rust: i32::MAX,
    // rust: )?,
    // rust: can_grow_through: decoder.block_set(required(&object, "can_grow_through")?)?,
    // rust: },
    // rust: "minecraft:cherry_trunk_placer" => {
    // rust: let start: Object =
    // rust: serde_json::from_str(required(&object, "branch_start_offset_from_top")?.get())?;
    // rust: if let Some(kind) = optional(&start, "type") {
    // rust: if serde_json::from_str::<String>(kind.get())? != "minecraft:uniform" {
    // rust: return Err(DecodeError::Field("cherry branch start type"));
}
}
    // rust: let min = int_range(required(&start, "min_inclusive")?, "branch start", -16, 0)?;
    // rust: let max = int_range(required(&start, "max_inclusive")?, "branch start", -16, 0)?;
    // rust: if max - min < 1 {
    // rust: return Err(DecodeError::Field("cherry branch start variation"));
}
    // rust: Kind::Cherry {
    // rust: branch_count: decoder.int_provider(required(&object, "branch_count")?, 1, 3)?,
    // rust: branch_horizontal_length: decoder.int_provider(
    // rust: required(&object, "branch_horizontal_length")?,
    // rust: 2,
    // rust: 16,
    // rust: )?,
    // rust: branch_start: [min, max],
    // rust: branch_end_offset: decoder.int_provider(
    // rust: required(&object, "branch_end_offset_from_top")?,
    // rust: -16,
    // rust: 16,
    // rust: )?,
}
}
    // rust: "minecraft:poplar_trunk_placer" => Kind::Poplar {
    // rust: trunk_height_above_branches: decoder.int_provider(
    // rust: required(&object, "trunk_height_above_branches")?,
    // rust: 0,
    // rust: 8,
    // rust: )?,
    // rust: branch_amount: decoder.int_provider(required(&object, "branch_amount")?, 1, 4)?,
    // rust: },
    // rust: _ => return Err(DecodeError::Field("trunk placer type")),
}
    // rust: Ok(Self {
    // rust: base_height,
    // rust: height_rand_a,
    // rust: height_rand_b,
    // rust: kind,
    // rust: })
}
    // rust: pub(super) fn tree_height<E>(&self, random: &mut impl RandomSource) -> TreeResult<i32, E> {
    // rust: let a = random.next_int_bound(self.height_rand_a + 1)?;
    // rust: let b = random.next_int_bound(self.height_rand_b + 1)?;
    // rust: Ok(self.base_height + a + b)
}
    // Virtual TrunkPlacer.validTreePos.
valid_tree_pos :: proc(self: ^Self, blocks: ^TreeBlocks, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: blocks.valid_tree_pos(state)
    // rust: || matches!(&self.kind, Kind::UpwardsBranching { can_grow_through, .. } if can_grow_through.contains(&state))
}
    // rust: pub(super) fn is_free(&self, blocks: &TreeBlocks, state: BlockStateId) -> bool {
    // rust: self.valid_tree_pos(blocks, state) || blocks.has(state, tb::LOGS)
}
    // rust: fn place_log<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: position: [i32; 3],
    // rust: axis: Option<Axis>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let here = read(run.world, position)?;
    // rust: if !self.valid_tree_pos(&tree.blocks, here) {
    // rust: return Ok(false);
}
    // rust: let mut state = sample_state(&tree.trunk_provider, run.world, run.random, position)?;
    // rust: if let Some(axis) = axis {
    // rust: state = tree.blocks.try_axis(state, axis);
}
    // rust: run.set(Layer::Trunk, position, state)?;
    // rust: Ok(true)
}
    // rust: fn place_log_if_free<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let here = read(run.world, position)?;
    // rust: if self.is_free(&tree.blocks, here) {
    // rust: self.place_log(run, tree, position, None)?;
}
    // rust: Ok(())
}
    // rust: fn place_below_trunk<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if let Some(state) =
    // rust: sample_optional(&tree.below_trunk_provider, run.world, run.random, position)?
    // rust: {
    // rust: run.set(Layer::Trunk, position, state)?;
}
    // rust: Ok(())
}
    // rust: pub(super) fn place_trunk<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<FoliageAttachment>, W::Error> {
    // rust: let below = tb::offset(origin, 0, -1, 0);
    // rust: match &self.kind {
    // rust: Kind::Straight => {
    // rust: Self::place_below_trunk(run, tree, below)?;
    // rust: for y in 0..tree_height {
    // rust: self.place_log(run, tree, tb::offset(origin, 0, y, 0), None)?;
}
    // rust: Ok(vec![FoliageAttachment::new(
    // rust: tb::offset(origin, 0, tree_height, 0),
    // rust: 0,
    // rust: false,
    // rust: )])
}
    // rust: Kind::Forking => self.forking(run, tree, tree_height, origin),
    // rust: Kind::Giant => self.giant(run, tree, tree_height, origin),
    // rust: Kind::MegaJungle => {
    // rust: let mut attachments = self.giant(run, tree, tree_height, origin)?;
    // rust: let mut branch_height = tree_height - 2 - run.random.next_int_bound(4)?;
    // rust: while branch_height > tree_height / 2 {
    // rust: let angle = run.random.next_float() * (std::f64::consts::PI * 2.0) as f32;
    // rust: let (mut bx, mut bz) = (0, 0);
    // rust: for b in 0..5 {
    // rust: bx = (1.5f32
    // rust: + horizon_core::geometry::trig::cos(f64::from(angle)) * b as f32)
    // rust: as i32;
    // rust: bz = (1.5f32
    // rust: + horizon_core::geometry::trig::sin(f64::from(angle)) * b as f32)
    // rust: as i32;
    // rust: let p = tb::offset(origin, bx, branch_height - 3 + b / 2, bz);
    // rust: self.place_log(run, tree, p, None)?;
}
    // rust: attachments.push(FoliageAttachment::new(
    // rust: tb::offset(origin, bx, branch_height, bz),
    // rust: -2,
    // rust: false,
    // rust: ));
    // rust: branch_height -= 2 + run.random.next_int_bound(4)?;
}
    // rust: Ok(attachments)
}
    // rust: Kind::DarkOak => self.dark_oak(run, tree, tree_height, origin),
    // rust: Kind::Fancy => self.fancy(run, tree, tree_height, origin),
    // rust: Kind::Bending {
    // rust: min_height_for_leaves,
    // rust: bend_length,
    // rust: } => {
    // rust: let direction = random_horizontal(run.random)?;
    // rust: let log_height = tree_height - 1;
    // rust: let mut pos = origin;
    // rust: Self::place_below_trunk(run, tree, below)?;
    // rust: let mut points = Vec::new();
    // rust: for i in 0..=log_height {
    // rust: if i + 1 >= log_height + run.random.next_int_bound(2)? {
    // rust: pos = tb::relative(pos, direction, 1);
}
    // rust: if tree.blocks.valid_tree_pos(read(run.world, pos)?) {
    // rust: self.place_log(run, tree, pos, None)?;
}
    // rust: if i >= *min_height_for_leaves {
    // rust: points.push(FoliageAttachment::new(pos, 0, false));
}
    // rust: pos = tb::offset(pos, 0, 1, 0);
}
    // rust: let length = bend_length.sample(run.random)?;
    // rust: for _ in 0..=length {
    // rust: if tree.blocks.valid_tree_pos(read(run.world, pos)?) {
    // rust: self.place_log(run, tree, pos, None)?;
}
    // rust: points.push(FoliageAttachment::new(pos, 0, false));
    // rust: pos = tb::relative(pos, direction, 1);
}
    // rust: Ok(points)
}
    // rust: Kind::UpwardsBranching {
    // rust: extra_branch_steps,
    // rust: branch_probability,
    // rust: extra_branch_length,
    // rust: ..
    // rust: } => {
    // rust: let mut attachments = Vec::new();
    // rust: for height in 0..tree_height {
    // rust: let current = origin[1].wrapping_add(height);
    // rust: let log = [origin[0], current, origin[2]];
    // rust: if self.place_log(run, tree, log, None)?
    // rust: && height < tree_height - 1
    // rust: && run.random.next_float() < *branch_probability
    // rust: {
    // rust: let direction = random_horizontal(run.random)?;
    // rust: let length = extra_branch_length.sample(run.random)?;
    // rust: let branch_pos =
    // rust: 0.max(length - extra_branch_length.sample(run.random)? - 1);
    // rust: let steps = extra_branch_steps.sample(run.random)?;
    // rust: self.upwards_branch(
    // rust: run,
    // rust: tree,
    // rust: tree_height,
    // rust: &mut attachments,
    // rust: log,
    // rust: current,
    // rust: direction,
    // rust: branch_pos,
    // rust: steps,
    // rust: )?;
}
    // rust: if height == tree_height - 1 {
    // rust: attachments.push(FoliageAttachment::new(
    // rust: [origin[0], current.wrapping_add(1), origin[2]],
    // rust: 0,
    // rust: false,
    // rust: ));
}
}
    // rust: Ok(attachments)
}
    // rust: Kind::Cherry { .. } => self.cherry(run, tree, tree_height, origin),
    // rust: Kind::Poplar {
    // rust: trunk_height_above_branches,
    // rust: branch_amount,
    // rust: } => {
    // rust: Self::place_below_trunk(run, tree, below)?;
    // rust: let up_to_branches =
    // rust: tree_height - trunk_height_above_branches.sample(run.random)?;
    // rust: for y in 0..tree_height {
    // rust: let log = tb::offset(origin, 0, y, 0);
    // rust: self.place_log(run, tree, log, None)?;
    // rust: let mut all = Direction::ALL;
    // rust: tb::shuffle(&mut all, run.random)?;
    // rust: let directions: Vec<Direction> = all
    // rust: .into_iter()
    // rust: .filter(|d| !matches!(d, Direction::Up | Direction::Down))
    // rust: .collect();
    // rust: if up_to_branches - 1 == y {
    // rust: let branches = branch_amount.sample(run.random)?;
    // rust: for direction in directions.iter().take(branches.max(0) as usize) {
    // rust: self.place_log(
    // rust: run,
    // rust: tree,
    // rust: tb::relative(log, *direction, 1),
    // rust: Some(Axis::of(*direction)),
    // rust: )?;
}
}
}
    // rust: Ok(vec![FoliageAttachment::new(
    // rust: tb::offset(origin, 0, up_to_branches, 0),
    // rust: 0,
    // rust: false,
    // rust: )])
}
}
}

    // rust: fn forking<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<FoliageAttachment>, W::Error> {
    // rust: Self::place_below_trunk(run, tree, tb::offset(origin, 0, -1, 0))?;
    // rust: let mut attachments = Vec::new();
    // rust: let lean = random_horizontal(run.random)?;
    // rust: let lean_height = tree_height - run.random.next_int_bound(4)? - 1;
    // rust: let mut lean_steps = 3 - run.random.next_int_bound(3)?;
    // rust: let (mut tx, mut tz) = (origin[0], origin[2]);
    // rust: let mut ey = None;
    // rust: for yo in 0..tree_height {
    // rust: let yy = origin[1].wrapping_add(yo);
    // rust: if yo >= lean_height && lean_steps > 0 {
    // rust: let n = lean.normal();
    // rust: tx = tx.wrapping_add(n[0]);
    // rust: tz = tz.wrapping_add(n[2]);
    // rust: lean_steps -= 1;
}
    // rust: if self.place_log(run, tree, [tx, yy, tz], None)? {
    // rust: ey = Some(yy.wrapping_add(1));
}
}
    // rust: if let Some(ey) = ey {
    // rust: attachments.push(FoliageAttachment::new([tx, ey, tz], 1, false));
}
    // rust: tx = origin[0];
    // rust: tz = origin[2];
    // rust: let branch = random_horizontal(run.random)?;
    // rust: if branch != lean {
    // rust: let branch_pos = lean_height - run.random.next_int_bound(2)? - 1;
    // rust: let mut steps = 1 + run.random.next_int_bound(3)?;
    // rust: let mut ey = None;
    // rust: let mut yo = branch_pos;
    // rust: while yo < tree_height && steps > 0 {
    // rust: if yo >= 1 {
    // rust: let yy = origin[1].wrapping_add(yo);
    // rust: let n = branch.normal();
    // rust: tx = tx.wrapping_add(n[0]);
    // rust: tz = tz.wrapping_add(n[2]);
    // rust: if self.place_log(run, tree, [tx, yy, tz], None)? {
    // rust: ey = Some(yy.wrapping_add(1));
}
}
    // rust: yo += 1;
    // rust: steps -= 1;
}
    // rust: if let Some(ey) = ey {
    // rust: attachments.push(FoliageAttachment::new([tx, ey, tz], 0, false));
}
}
    // rust: Ok(attachments)
}

    // rust: fn giant<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<FoliageAttachment>, W::Error> {
    // rust: let below = tb::offset(origin, 0, -1, 0);
    // rust: Self::place_below_trunk(run, tree, below)?;
    // rust: Self::place_below_trunk(run, tree, tb::offset(below, 1, 0, 0))?;
    // rust: Self::place_below_trunk(run, tree, tb::offset(below, 0, 0, 1))?;
    // rust: Self::place_below_trunk(run, tree, tb::offset(below, 1, 0, 1))?;
    // rust: for hh in 0..tree_height {
    // rust: self.place_log_if_free(run, tree, tb::offset(origin, 0, hh, 0))?;
    // rust: if hh < tree_height - 1 {
    // rust: self.place_log_if_free(run, tree, tb::offset(origin, 1, hh, 0))?;
    // rust: self.place_log_if_free(run, tree, tb::offset(origin, 1, hh, 1))?;
    // rust: self.place_log_if_free(run, tree, tb::offset(origin, 0, hh, 1))?;
}
}
    // rust: Ok(vec![FoliageAttachment::new(
    // rust: tb::offset(origin, 0, tree_height, 0),
    // rust: 0,
    // rust: true,
    // rust: )])
}

    // rust: fn dark_oak<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<FoliageAttachment>, W::Error> {
    // rust: let mut attachments = Vec::new();
    // rust: let below = tb::offset(origin, 0, -1, 0);
    // rust: Self::place_below_trunk(run, tree, below)?;
    // rust: Self::place_below_trunk(run, tree, tb::offset(below, 1, 0, 0))?;
    // rust: Self::place_below_trunk(run, tree, tb::offset(below, 0, 0, 1))?;
    // rust: Self::place_below_trunk(run, tree, tb::offset(below, 1, 0, 1))?;
    // rust: let lean = random_horizontal(run.random)?;
    // rust: let lean_height = tree_height - run.random.next_int_bound(4)?;
    // rust: let mut lean_steps = 2 - run.random.next_int_bound(3)?;
    // rust: let [x, y, z] = origin;
    // rust: let (mut tx, mut tz) = (x, z);
    // rust: let ey = y.wrapping_add(tree_height).wrapping_sub(1);
    // rust: for dy in 0..tree_height {
    // rust: if dy >= lean_height && lean_steps > 0 {
    // rust: let n = lean.normal();
    // rust: tx = tx.wrapping_add(n[0]);
    // rust: tz = tz.wrapping_add(n[2]);
    // rust: lean_steps -= 1;
}
    // rust: let p = [tx, y.wrapping_add(dy), tz];
    // rust: let here = read(run.world, p)?;
    // rust: if tree.blocks.has(here, tb::AIR | tb::LEAVES) {
    // rust: self.place_log(run, tree, p, None)?;
    // rust: self.place_log(run, tree, tb::offset(p, 1, 0, 0), None)?;
    // rust: self.place_log(run, tree, tb::offset(p, 0, 0, 1), None)?;
    // rust: self.place_log(run, tree, tb::offset(p, 1, 0, 1), None)?;
}
}
    // rust: attachments.push(FoliageAttachment::new([tx, ey, tz], 0, true));
    // rust: for ox in -1..=2 {
    // rust: for oz in -1..=2 {
    // rust: if (!(0..=1).contains(&ox) || !(0..=1).contains(&oz))
    // rust: && run.random.next_int_bound(3)? <= 0
    // rust: {
    // rust: let length = run.random.next_int_bound(3)? + 2;
    // rust: for branch_y in 0..length {
    // rust: self.place_log(
    // rust: run,
    // rust: tree,
    // rust: [
    // rust: x.wrapping_add(ox),
    // rust: ey.wrapping_sub(branch_y).wrapping_sub(1),
    // rust: z.wrapping_add(oz),
    // rust: ],
    // rust: None,
    // rust: )?;
}
    // rust: attachments.push(FoliageAttachment::new(
    // rust: [x.wrapping_add(ox), ey, z.wrapping_add(oz)],
    // rust: 0,
    // rust: false,
    // rust: ));
}
}
}
    // rust: Ok(attachments)
}

    // rust: fn upwards_branch<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: attachments: &mut Vec<FoliageAttachment>,
    // rust: log: [i32; 3],
    // rust: current_height: i32,
    // rust: direction: Direction,
    // rust: branch_pos: i32,
    // rust: mut steps: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let mut height_along = current_height.wrapping_add(branch_pos);
    // rust: let (mut lx, mut lz) = (log[0], log[2]);
    // rust: let mut index = branch_pos;
    // rust: let n = direction.normal();
    // rust: while index < tree_height && steps > 0 {
    // rust: if index >= 1 {
    // rust: let placement = current_height.wrapping_add(index);
    // rust: lx = lx.wrapping_add(n[0]);
    // rust: lz = lz.wrapping_add(n[2]);
    // rust: height_along = placement;
    // rust: let log = [lx, placement, lz];
    // rust: if self.place_log(run, tree, log, None)? {
    // rust: height_along = height_along.wrapping_add(1);
}
    // rust: attachments.push(FoliageAttachment::new(log, 0, false));
}
    // rust: index += 1;
    // rust: steps -= 1;
}
    // rust: if height_along.wrapping_sub(current_height) > 1 {
    // rust: let foliage = [lx, height_along, lz];
    // rust: attachments.push(FoliageAttachment::new(foliage, 0, false));
    // rust: attachments.push(FoliageAttachment::new(
    // rust: tb::offset(foliage, 0, -2, 0),
    // rust: 0,
    // rust: false,
    // rust: ));
}
    // rust: Ok(())
}

    // rust: fn cherry<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<FoliageAttachment>, W::Error> {
    // rust: let Kind::Cherry {
    // rust: branch_count,
    // rust: branch_horizontal_length,
    // rust: branch_start: [start_min, start_max],
    // rust: branch_end_offset,
    // rust: } = &self.kind
    // rust: else {
    // rust: unreachable!("cherry trunk kind");
}
    // rust: Self::place_below_trunk(run, tree, tb::offset(origin, 0, -1, 0))?;
    // rust: let first = 0.max(
    // rust: tree_height - 1
    // rust: + run
    // rust: .random
    // rust: .next_int_between_inclusive(*start_min, *start_max)?,
    // rust: );
    // rust: let mut second = 0.max(
    // rust: tree_height - 1
    // rust: + run
    // rust: .random
    // rust: .next_int_between_inclusive(*start_min, start_max - 1)?,
    // rust: );
    // rust: if second >= first {
    // rust: second += 1;
}
    // rust: let count = branch_count.sample(run.random)?;
    // rust: let middle = count == 3;
    // rust: let both = count >= 2;
    // rust: let trunk_height = if middle {
    // rust: tree_height
    // rust: } else if both {
    // rust: first.max(second) + 1
    // rust: } else {
    // rust: first + 1
}
    // rust: for y in 0..trunk_height {
    // rust: self.place_log(run, tree, tb::offset(origin, 0, y, 0), None)?;
}
    // rust: let mut attachments = Vec::new();
    // rust: if middle {
    // rust: attachments.push(FoliageAttachment::new(
    // rust: tb::offset(origin, 0, trunk_height, 0),
    // rust: 0,
    // rust: false,
    // rust: ));
}
    // rust: let direction = random_horizontal(run.random)?;
    // rust: let sideways = Axis::of(direction);
    // rust: let generate = |this: &Self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: branch_direction: Direction,
    // rust: offset: i32,
    // rust: middle_continues: bool|
    // rust: -> TreeResult<FoliageAttachment, W::Error> {
    // rust: let mut log = tb::offset(origin, 0, offset, 0);
    // rust: let end_offset = tree_height - 1 + branch_end_offset.sample(run.random)?;
    // rust: let extend = middle_continues || end_offset < offset;
    // rust: let distance = branch_horizontal_length.sample(run.random)? + i32::from(extend);
    // rust: let end = tb::offset(
    // rust: tb::relative(origin, branch_direction, distance),
    // rust: 0,
    // rust: end_offset,
    // rust: 0,
    // rust: );
    // rust: let steps = if extend { 2 } else { 1 };
    // rust: for _ in 0..steps {
    // rust: log = tb::relative(log, branch_direction, 1);
    // rust: this.place_log(run, tree, log, Some(sideways))?;
}
    // rust: let vertical = if end[1] > log[1] {
    // rust: Direction::Up
    // rust: } else {
    // rust: Direction::Down
}
    // rust: loop {
    // rust: let distance = tb::dist_manhattan(log, end);
    // rust: if distance == 0 {
    // rust: return Ok(FoliageAttachment::new(tb::offset(end, 0, 1, 0), 0, false));
}
    // rust: let chance = end[1].wrapping_sub(log[1]).wrapping_abs() as f32 / distance as f32;
    // rust: let grow_vertically = run.random.next_float() < chance;
    // rust: log = tb::relative(
    // rust: log,
    // rust: if grow_vertically {
    // rust: vertical
    // rust: } else {
    // rust: branch_direction
    // rust: },
    // rust: 1,
    // rust: );
    // rust: this.place_log(
    // rust: run,
    // rust: tree,
    // rust: log,
    // rust: if grow_vertically {
    // rust: None
    // rust: } else {
    // rust: Some(sideways)
    // rust: },
    // rust: )?;
}
}
    // rust: attachments.push(generate(
    // rust: self,
    // rust: run,
    // rust: direction,
    // rust: first,
    // rust: first < trunk_height - 1,
    // rust: )?);
    // rust: if both {
    // rust: attachments.push(generate(
    // rust: self,
    // rust: run,
    // rust: direction.opposite(),
    // rust: second,
    // rust: second < trunk_height - 1,
    // rust: )?);
}
    // rust: Ok(attachments)
}

    // rust: fn fancy<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: tree_height: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<FoliageAttachment>, W::Error> {
    // rust: let height = tree_height + 2;
    // rust: let trunk_height = (f64::from(height) * 0.618).floor() as i32;
    // rust: Self::place_below_trunk(run, tree, tb::offset(origin, 0, -1, 0))?;
    // rust: let clusters_per_y = 1.min(
    // rust: (1.382 + horizon_core::jmath::pow(1.0 * f64::from(height) / 13.0, 2.0)).floor() as i32,
    // rust: );
    // rust: let trunk_top = origin[1].wrapping_add(trunk_height);
    // rust: let mut relative_y = height - 5;
        // (attachment position, branch base y)
    // rust: let mut coords = vec![(tb::offset(origin, 0, relative_y, 0), trunk_top)];
    // rust: while relative_y >= 0 {
    // rust: let shape = tree_shape(height, relative_y);
            // tree_shape never returns NaN.
    // rust: if shape >= 0.0 {
    // rust: for _ in 0..clusters_per_y {
    // rust: let radius =
    // rust: 1.0 * f64::from(shape) * (f64::from(run.random.next_float()) + 0.328);
    // rust: let angle = f64::from(run.random.next_float() * 2.0f32) * std::f64::consts::PI;
    // rust: let x = radius * horizon_core::jmath::sin(angle) + 0.5;
    // rust: let z = radius * horizon_core::jmath::cos(angle) + 0.5;
    // rust: let check_start =
    // rust: tb::offset(origin, x.floor() as i32, relative_y - 1, z.floor() as i32);
    // rust: let check_end = tb::offset(check_start, 0, 5, 0);
    // rust: if self.make_limb(run, tree, check_start, check_end, false)? {
    // rust: let dx = origin[0].wrapping_sub(check_start[0]);
    // rust: let dz = origin[2].wrapping_sub(check_start[2]);
    // rust: let branch_height = f64::from(check_start[1])
    // rust: - f64::from(dx.wrapping_mul(dx).wrapping_add(dz.wrapping_mul(dz)))
    // rust: .sqrt()
    // rust: * 0.381;
    // rust: let branch_top = if branch_height > f64::from(trunk_top) {
    // rust: trunk_top
    // rust: } else {
    // rust: branch_height as i32
}
    // rust: let base = [origin[0], branch_top, origin[2]];
    // rust: if self.make_limb(run, tree, base, check_start, false)? {
    // rust: coords.push((check_start, base[1]));
}
}
}
}
    // rust: relative_y -= 1;
}
    // rust: self.make_limb(
    // rust: run,
    // rust: tree,
    // rust: origin,
    // rust: tb::offset(origin, 0, trunk_height, 0),
    // rust: true,
    // rust: )?;
    // rust: for (end, branch_base) in &coords {
    // rust: let base = [origin[0], *branch_base, origin[2]];
    // rust: if base != *end && trim_branches(height, branch_base.wrapping_sub(origin[1])) {
    // rust: self.make_limb(run, tree, base, *end, true)?;
}
}
    // rust: Ok(coords
    // rust: .into_iter()
    // rust: .filter(|(_, base)| trim_branches(height, base.wrapping_sub(origin[1])))
    // rust: .map(|(p, _)| FoliageAttachment::new(p, 0, false))
    // rust: .collect())
}

    // rust: fn make_limb<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: start: [i32; 3],
    // rust: end: [i32; 3],
    // rust: place: bool,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if !place && start == end {
    // rust: return Ok(true);
}
    // rust: let delta: [i32; 3] = std::array::from_fn(|i| end[i].wrapping_sub(start[i]));
    // rust: let steps = delta[0]
    // rust: .wrapping_abs()
    // rust: .max(delta[1].wrapping_abs().max(delta[2].wrapping_abs()));
    // rust: let step: [f32; 3] = delta.map(|d| d as f32 / steps as f32);
    // rust: for i in 0..=steps {
    // rust: let p: [i32; 3] = std::array::from_fn(|axis| {
    // rust: start[axis].wrapping_add((0.5f32 + i as f32 * step[axis]).floor() as i32)
    // rust: });
    // rust: if place {
    // rust: let axis = log_axis(start, p);
    // rust: self.place_log(run, tree, p, Some(axis))?;
    // rust: } else if !self.is_free(&tree.blocks, read(run.world, p)?) {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
}

log_axis :: proc(start: [i32; 3], p: [i32; 3]) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let xdiff = p[0].wrapping_sub(start[0]).wrapping_abs();
    // rust: let zdiff = p[2].wrapping_sub(start[2]).wrapping_abs();
    // rust: let max = xdiff.max(zdiff);
    // rust: if max > 0 {
    // rust: if xdiff == max { Axis::X } else { Axis::Z }
    // rust: } else {
    // rust: Axis::Y
}
}
trim_branches :: proc(height: i32, local_y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(local_y) >= f64::from(height) * 0.2
}
tree_shape :: proc(height: i32, y: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if (y as f32) < height as f32 * 0.3f32 {
    // rust: return -1.0;
}
    // rust: let radius = height as f32 / 2.0;
    // rust: let adjacent = radius - y as f32;
    // rust: let mut distance = (radius * radius - adjacent * adjacent).sqrt();
    // rust: if adjacent == 0.0 {
    // rust: distance = radius;
    // rust: } else if adjacent.abs() >= radius {
    // rust: return 0.0;
}
    // rust: distance * 0.5
}
