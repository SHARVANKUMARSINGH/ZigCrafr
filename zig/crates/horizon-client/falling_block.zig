//! Transpiled from Horizon Rust crate
//! Module: horizon-client_falling_block
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! FallingBlockEntity's impact damage, anvil wear, saved impact settings and
//! the blocks it moves through (cobwebs, bubble columns).
// use crate::motion::BubbleColumn;
// use crate::{
    // rust: mobs::{Damage as MobDamage, DamageKind, Mob},
    // rust: save::{float, number, put},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Direction, Vec3, sweep_intersected_blocks},
    // rust: position::BlockPos,
}
// use horizon_world::{chunk::BlockState, nbt::Tag};

pub const Damage = struct {
    hurt_entities: bool,
    cancel_drop: bool,
    per_distance: f32,
    max: i32,
};
    // rust: impl Default for Damage {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: hurt_entities: false,
    // rust: cancel_drop: false,
    // rust: per_distance: 0.0,
    // rust: max: 40,
}
}
}
    // rust: impl Damage {
pub fn anvil() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: hurt_entities: true,
    // rust: per_distance: 2.0,
    // rust: ..Self::default()
}
}
    /// A block that starts to fall: anvils hurt, and a brushable block
    /// breaks where it lands (BrushableBlock.tick: disableDrop).
pub fn falling(block: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if block.ends_with("anvil") {
    // rust: Self::anvil()
    // rust: } else {
    // rust: Self {
    // rust: cancel_drop: block.starts_with("minecraft:suspicious_"),
    // rust: ..Self::default()
}
}
}
pub fn from_nbt(tag: *Tag, anvil: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: hurt_entities: number(tag.get("HurtEntities")).map_or(anvil, |v| v != 0),
    // rust: cancel_drop: number(tag.get("CancelDrop")).is_some_and(|v| v != 0),
    // rust: per_distance: float(tag.get("FallHurtAmount")).unwrap_or(0.0) as f32,
    // rust: max: number(tag.get("FallHurtMax")).unwrap_or(40) as i32,
}
}
pub fn save(self: *Self, tag: *mut Tag) void {
}
    // rust: for (key, value) in [
    // rust: ("HurtEntities", Tag::Byte(i8::from(self.hurt_entities))),
    // rust: ("CancelDrop", Tag::Byte(i8::from(self.cancel_drop))),
    // rust: ("FallHurtAmount", Tag::Float(self.per_distance.to_bits())),
    // rust: ("FallHurtMax", Tag::Int(self.max)),
    // rust: ] {
    // rust: put(tag, key, value);
}
}
pub fn impact(self: *Self, fall_distance: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.hurt_entities {
    // rust: return None;
}
    // rust: let steps = (fall_distance - 1.0).ceil() as i32;
    // rust: if steps < 0 {
    // rust: return None;
}
    // rust: let amount = ((steps as f32 * self.per_distance).floor() as i32).min(self.max) as f32;
    // rust: Some(Impact {
    // rust: amount,
    // rust: wear_chance: if amount > 0.0 {
    // rust: 0.05 + steps as f32 * 0.05
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: })
}
}

pub const Impact = struct {
    amount: f32,
    wear_chance: f32,
};

/// AnvilBlock.damage: advance wear without changing facing; false means broken.
pub fn wear_anvil(state: *mut BlockState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: state.name = match state.name.as_str() {
    // rust: "minecraft:anvil" => "minecraft:chipped_anvil",
    // rust: "minecraft:chipped_anvil" => "minecraft:damaged_anvil",
    // rust: _ => return false,
}
    // rust: .into();
    // rust: true
}

pub fn bounds(position: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = f64::from(0.98_f32);
    // rust: Aabb::new(
    // rust: Vec3::new(position.x - size / 2.0, position.y, position.z - size / 2.0),
    // rust: Vec3::new(
    // rust: position.x + size / 2.0,
    // rust: position.y + size,
    // rust: position.z + size / 2.0,
    // rust: ),
    // rust: )
}
/// `WebBlock.entityInside`'s `makeStuckInBlock` multiplier: the next move
/// goes at a quarter of the speed across, a twentieth down.
pub fn web_multiplier() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(0.25, f64::from(0.05_f32), 0.25)
}
/// What a block a falling block moves through does to it in `entityInside`.
pub const Inside = enum {
    /// `WebBlock`: `Entity.makeStuckInBlock`.
    Cobweb,
    /// `BubbleColumnBlock`: lifts or drags it.
    BubbleColumn(BubbleColumn),
    Nothing,
};
/// `Entity.applyEffectsFromBlocks` after a falling block's move this tick
/// (`from` to `to`; `original` the move it asked for, when the move was
/// recorded; `velocity` already zeroed on the axes `Entity.move` collided on):
/// the blocks it went through (`block` says what each is) push it and reset
/// its fall. Returns whether a cobweb made it stuck, and adds to `surfaces` the
/// column blocks it is at the top of (`Entity.sendBubbleColumnParticles`).
    // rust: pub fn apply_effects_from_blocks(
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: original: Option<Vec3>,
    // rust: velocity: &mut Vec3,
    // rust: fall_distance: &mut f64,
    // rust: surfaces: &mut Vec<BlockPos>,
    // rust: mut block: impl FnMut(BlockPos) -> Inside,
    // rust: ) -> bool {
    // rust: let mut stuck = false;
    // rust: inside_blocks(from, to, original, |p, intersects| match block(p) {
    // rust: Inside::Cobweb => {
            // makeStuckInBlock forgets the fall.
    // rust: *fall_distance = 0.0;
    // rust: stuck = true;
}
        // BubbleColumnBlock.entityInside acts only when intersecting.
    // rust: Inside::BubbleColumn(column) if intersects => {
    // rust: if column.push(velocity) {
    // rust: *fall_distance = 0.0;
}
    // rust: if column.surface {
    // rust: surfaces.push(p);
}
}
    // rust: Inside::BubbleColumn(_) | Inside::Nothing => {}
    // rust: });
    // rust: stuck
}
/// Each block `checkInsideBlocks` reaches, once, in order, with
/// whether its `entityInside` counts the block as intersected (every block of a
/// movement a block or longer, else only those the box ends in). Each movement
/// sweeps its axes in `Direction.axisStepOrder` within 16 iterations, then the
/// end alone. The blocks the caller acts on (cobwebs, bubble columns) have a
/// whole-block `getEntityInsideCollisionShape`, so every one visited counts.
    // rust: fn inside_blocks(
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: original: Option<Vec3>,
    // rust: mut visit: impl FnMut(BlockPos, bool),
    // rust: ) {
    // rust: let mut seen = std::collections::HashSet::new();
    // checkInsideBlocks(from, to, ..): the iterations used plus one.
    // rust: let mut check = |from: Vec3, to: Vec3, max: i32| {
    // rust: let d = f64::from(1.0e-5_f32);
    // rust: let target = bounds(to).deflate(Vec3::new(d, d, d));
        // The move spans a block or more: Mth.square(1.0 - 1.0E-5F).
    // rust: let long = from.distance_squared(to) > (1.0 - d) * (1.0 - d);
    // rust: let mut iterations = 0;
    // rust: let _ = sweep_intersected_blocks(from, to, target, 1_000_000, |p, iteration| {
    // rust: if iteration >= max {
    // rust: return false;
}
    // rust: iterations = iteration;
    // rust: if seen.insert(p) {
    // rust: let corner = Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z));
    // rust: let inside =
    // rust: target.intersects_corners(corner, corner.add_vector(Vec3::new(1.0, 1.0, 1.0)));
    // rust: visit(p, long || inside);
}
    // rust: true
    // rust: });
    // rust: iterations + 1
}
    // rust: let delta = to.subtract(from);
    // rust: let mut budget = 16;
    // rust: match original {
    // rust: Some(original) if delta.length_squared() > 0.0 => {
    // rust: let mut at = from;
    // rust: for axis in Axis::step_order(original) {
    // rust: let step = delta.component(axis);
    // rust: if step != 0.0 {
    // rust: let positive = match axis {
    // rust: Axis::X => Direction::East,
    // rust: Axis::Y => Direction::Up,
    // rust: Axis::Z => Direction::South,
}
    // rust: let next = at.relative(positive, step);
    // rust: budget -= check(at, next, budget);
    // rust: at = next;
}
}
}
    // rust: _ => budget -= check(from, to, 16),
}
    // rust: if budget <= 0 {
    // rust: check(to, to, 1);
}
}
pub fn hurt_mobs(mobs: *mut [Mob], position: Vec3, amount: f32) void {
}
    // rust: hurt_mobs_with_kind(mobs, position, amount, DamageKind::FallingBlock);
}

pub fn hurt_mobs_with_kind(mobs: *mut [Mob], position: Vec3, amount: f32, kind: DamageKind) void {
}
    // rust: if amount <= 0.0 {
    // rust: return;
}
    // rust: let bounds = bounds(position);
    // rust: let source = MobDamage {
    // rust: kind,
    // rust: attacker: None,
    // rust: from: Some([position.x, position.y, position.z]),
    // rust: attacker_species: None,
}
    // rust: for mob in mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.alive() && bounds.intersects(m.bounds()))
    // rust: {
    // rust: mob.damage(amount, source);
}
}

    // rust: mod tests {
//     use super::*;
pub fn only_brushable_blocks_break_where_they_land() void {
}
    // rust: assert!(Damage::falling("minecraft:suspicious_gravel").cancel_drop);
    // rust: assert!(Damage::falling("minecraft:suspicious_sand").cancel_drop);
    // rust: assert!(!Damage::falling("minecraft:gravel").cancel_drop);
    // rust: assert!(Damage::falling("minecraft:chipped_anvil").hurt_entities);
}

pub fn impact_uses_ceil_distance_capped_damage_and_positive_damage_wear() void {
}
    // rust: let damage = Damage::anvil();
    // rust: assert!(Damage::default().impact(50.0).is_none());
    // rust: assert!(damage.impact(0.0).is_none());
    // rust: let short = damage.impact(1.0).unwrap();
    // rust: assert_eq!((short.amount, short.wear_chance), (0.0, 0.0));
    // rust: assert_eq!(damage.impact(1.01).unwrap().amount, 2.0);
    // rust: assert_eq!(damage.impact(5.0).unwrap().amount, 8.0);
    // rust: assert_eq!(damage.impact(100.0).unwrap().amount, 40.0);
    // rust: assert!(damage.impact(21.0).unwrap().wear_chance > 1.0);
}
pub fn damage_settings_round_trip_and_keep_vanilla_load_defaults() void {
}
    // rust: let empty = Tag::Compound(Default::default());
    // rust: assert_eq!(Damage::from_nbt(&empty, false), Damage::default());
    // rust: let loaded_anvil = Damage::from_nbt(&empty, true);
    // rust: assert!(loaded_anvil.hurt_entities);
    // rust: assert_eq!(loaded_anvil.per_distance, 0.0);
    // rust: let damage = Damage {
    // rust: hurt_entities: true,
    // rust: cancel_drop: true,
    // rust: per_distance: 3.5,
    // rust: max: 17,
}
    // rust: let mut tag = empty;
    // rust: damage.save(&mut tag);
    // rust: assert_eq!(Damage::from_nbt(&tag, false), damage);
}
pub fn anvil_wears_twice_then_breaks_preserving_facing() void {
}
    // rust: for facing in ["north", "south", "east", "west"] {
    // rust: let mut state = BlockState {
    // rust: name: "minecraft:anvil".into(),
    // rust: properties: [("facing".into(), facing.into())].into(),
}
    // rust: for name in ["minecraft:chipped_anvil", "minecraft:damaged_anvil"] {
    // rust: assert!(wear_anvil(&mut state));
    // rust: assert_eq!(state.name, name);
    // rust: assert_eq!(state.properties["facing"], facing);
}
    // rust: assert!(!wear_anvil(&mut state));
}
}
    // rust: fn passes_cobweb(
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: original: Option<Vec3>,
    // rust: is_web: impl Fn(BlockPos) -> bool,
    // rust: ) -> bool {
    // rust: let (mut velocity, mut fall) = (Vec3::ZERO, 3.0);
    // rust: let stuck = apply_effects_from_blocks(
    // rust: from,
    // rust: to,
    // rust: original,
    // rust: &mut velocity,
    // rust: &mut fall,
    // rust: &mut Vec::new(),
    // rust: |p| {
    // rust: if is_web(p) {
    // rust: Inside::Cobweb
    // rust: } else {
    // rust: Inside::Nothing
}
    // rust: },
    // rust: );
    // rust: assert_eq!(fall == 0.0, stuck);
    // rust: stuck
}
pub fn a_cobweb_on_the_path_or_at_the_end_holds_a_falling_block() void {
}
    // rust: let web = BlockPos::new(0, 5, 0);
    // rust: let is_web = |p: BlockPos| p == web;
    // rust: let at = |y: f64| Vec3::new(0.5, y, 0.5);
        // Falling through the web's block in one move, landing in it, resting in it.
    // rust: assert!(passes_cobweb(
    // rust: at(7.2),
    // rust: at(3.1),
    // rust: Some(Vec3::new(0.0, -4.1, 0.0)),
    // rust: is_web
    // rust: ));
    // rust: assert!(passes_cobweb(
    // rust: at(6.5),
    // rust: at(5.5),
    // rust: Some(Vec3::new(0.0, -1.0, 0.0)),
    // rust: is_web
    // rust: ));
    // rust: assert!(passes_cobweb(at(5.5), at(5.5), None, is_web));
        // Above it, below it, or beside it.
    // rust: assert!(!passes_cobweb(
    // rust: at(8.0),
    // rust: at(6.01),
    // rust: Some(Vec3::new(0.0, -1.99, 0.0)),
    // rust: is_web
    // rust: ));
    // rust: assert!(!passes_cobweb(
    // rust: at(4.0),
    // rust: at(3.0),
    // rust: Some(Vec3::new(0.0, -1.0, 0.0)),
    // rust: is_web
    // rust: ));
    // rust: let beside = Vec3::new(1.5, 5.5, 0.5);
    // rust: assert!(!passes_cobweb(beside, beside, None, is_web));
}
pub fn bubble_columns_lift_or_drag_a_falling_block() void {
}
        // Soul sand under x 0 lifts, magma under x 3 drags, both up to y 9.
    // rust: let block = |p: BlockPos| match (p.x, p.y, p.z) {
    // rust: (0 | 3, 0..=9, 0) => Inside::BubbleColumn(BubbleColumn {
    // rust: drag: p.x == 3,
    // rust: surface: p.y == 9,
    // rust: }),
    // rust: _ => Inside::Nothing,
}
    // rust: let tops = std::cell::RefCell::new(Vec::new());
    // rust: let step = |x: f64, from: f64, to: f64, vy: f64| {
    // rust: tops.borrow_mut().clear();
    // rust: let (from, to) = (Vec3::new(x, from, 0.5), Vec3::new(x, to, 0.5));
    // rust: let mut velocity = Vec3::new(0.0, vy, 0.0);
    // rust: let mut fall = 2.0;
    // rust: let original = Some(to.subtract(from));
    // rust: let stuck = apply_effects_from_blocks(
    // rust: from,
    // rust: to,
    // rust: original,
    // rust: &mut velocity,
    // rust: &mut fall,
    // rust: &mut tops.borrow_mut(),
    // rust: block,
    // rust: );
    // rust: assert!(!stuck);
    // rust: (velocity.y, fall)
}
    // rust: let near = |a: f64, b: f64| (a - b).abs() < 1.0e-9;
        // Released in the column: its box ends in blocks 5 and 6, each lifts
        // it by 0.06 (handleOnInsideBubbleColumn), and its fall is forgotten.
    // rust: let (vy, fall) = step(0.5, 5.5, 5.46, -0.04);
    // rust: assert!(near(vy, 0.08), "{vy}");
    // rust: assert_eq!(fall, 0.0);
        // The lift is capped at 0.7.
    // rust: assert!(near(step(0.5, 5.0, 5.3, 0.68).0, 0.7));
        // Falling a block or more into the surface block: every column
        // block on the way counts, the surface throws it up by 0.1
        // (handleOnAboveBubbleColumn), which keeps its fall.
    // rust: let (vy, fall) = step(0.5, 11.0, 9.5, -1.5);
    // rust: assert!(near(vy, -1.5 + 0.1), "{vy}");
    // rust: assert_eq!(fall, 2.0);
        // Only the surface block sends the splash and bubble particles.
    // rust: assert_eq!(*tops.borrow(), [BlockPos::new(0, 9, 0)]);
    // rust: step(0.5, 5.5, 5.46, -0.04);
    // rust: assert!(tops.borrow().is_empty());
        // Magma drags down by 0.03, at most to -0.3 inside and -0.9 at the surface.
    // rust: assert!(near(step(3.5, 5.5, 5.4, -0.1).0, -0.16));
    // rust: assert!(near(step(3.5, 5.5, 5.4, -0.29).0, -0.3));
    // rust: assert!(near(step(3.5, 9.8, 9.6, -0.89).0, -0.9));
        // A short move that leaves the column behind: the block it went
        // through no longer intersects its box, so nothing pushes it.
    // rust: assert_eq!(step(0.5, 9.95, 10.5, 0.55), (0.55, 2.0));
        // Beside the column.
    // rust: assert_eq!(step(1.5, 5.5, 5.46, -0.04), (-0.04, 2.0));
}
pub fn impact_hurts_only_living_intersecting_noninvulnerable_mobs() void {
}
//         use crate::mobs::{Mob, MobTypes};
//         use std::{path::Path, sync::Arc};
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES");
    // rust: let types = MobTypes::load(Path::new(&root)).unwrap();
    // rust: let cow = Arc::new(types.types["minecraft:cow"].clone());
    // rust: let mut mobs = vec![
    // rust: Mob::new(1, cow.clone(), Vec3::ZERO, 0.0),
    // rust: Mob::new(2, cow.clone(), Vec3::new(3.0, 0.0, 0.0), 0.0),
    // rust: Mob::new(3, cow.clone(), Vec3::ZERO, 0.0),
    // rust: Mob::new(4, cow, Vec3::ZERO, 0.0),
    // rust: ];
    // rust: mobs[2].invulnerable_flag = true;
    // rust: mobs[3].extra.head = Some("minecraft:carved_pumpkin".into());
    // rust: let initial = mobs.iter().map(|m| m.health).collect::<Vec<_>>();
    // rust: hurt_mobs(
    // rust: &mut mobs,
    // rust: Vec3::ZERO,
    // rust: Damage::anvil().impact(5.0).unwrap().amount,
    // rust: );
    // rust: assert_eq!(mobs[0].health, initial[0] - 8.0);
    // rust: assert_eq!(mobs[1].health, initial[1]);
    // rust: assert_eq!(mobs[2].health, initial[2]);
    // rust: assert_eq!(mobs[3].health, initial[3] - 6.0);
}
}
