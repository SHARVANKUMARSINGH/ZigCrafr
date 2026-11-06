//! Transpiled from Horizon Rust crate
//! Module: horizon-client_enderman
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Endermen: anger from being stared at, teleporting (randomly in daylight,
//! when hit by projectiles or water, and towards a distant target), freezing
//! while looked at, and picking up / placing `enderman_holdable` blocks.
// use super::{
    // rust: Damage, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Cx, Float, Goal, HurtByTarget, JUMP, LookAtPlayer, MOVE, MeleeAttack, NearestTarget,
    // rust: RandomLookAround, Stroll, TARGET, goal_clone, reduced,
    // rust: },
}
// use crate::{
    // rust: blocks::Fluid,
    // rust: items::{ItemStack, Items},
    // rust: random_sequences::RandomSequences,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}
// use horizon_world::registry::{BlockRegistry, BlockStateId};

pub fn register(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, FreezeWhenLookedAt);
    // rust: g.add(2, MeleeAttack::new(1.0, false));
    // rust: let mut stroll = Stroll::avoiding_water(1.0);
    // rust: stroll.water_avoiding = Some(0.0);
    // rust: g.add(7, stroll);
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: g.add(10, LeaveBlock);
    // rust: g.add(11, TakeBlock);
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: LookForPlayer {
    // rust: pending: false,
    // rust: aggro: 0,
    // rust: teleport: 0,
    // rust: },
    // rust: );
    // rust: m.ai.targets.add(2, HurtByTarget::new());
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::species(&[Species::Endermite], true).reach(),
    // rust: );
    // rust: m.set_malus(super::path::PathType::Water, -1.0);
}
/// Enderman.isBeingStaredBy: the player's look within a cone of 0.025 / distance
/// of the eyes, with line of sight, and no carved pumpkin.
pub fn stared_at(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = &w.player else { return false };
    // rust: if !p.alive || p.head.as_deref() == Some("minecraft:carved_pumpkin") {
    // rust: return false;
}
    // rust: let look = p.look;
    // rust: let dir = [
    // rust: m.position.x - p.position.x,
    // rust: m.eye_y() - p.eye[1],
    // rust: m.position.z - p.position.z,
    // rust: ];
    // rust: let dist = (dir[0] * dir[0] + dir[1] * dir[1] + dir[2] * dir[2]).sqrt();
    // rust: if dist < 1.0e-6 {
    // rust: return false;
}
    // rust: let dot = (look[0] * dir[0] + look[1] * dir[1] + look[2] * dir[2]) / dist;
    // rust: dot > 1.0 - 0.025 / dist
    // rust: && w.line_of_sight(
    // rust: Vec3::new(p.eye[0], p.eye[1], p.eye[2]),
    // rust: Vec3::new(m.position.x, m.eye_y(), m.position.z),
    // rust: )
}
/// Enderman.teleport(x, y, z): never while riding something; drop to standing
/// ground, require free space without liquid.
    // rust: pub fn teleport_to(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: x: f64,
    // rust: y: f64,
    // rust: z: f64,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> bool {
    // rust: if m.extra.passenger {
    // rust: return false;
}
    // LivingEntity.randomTeleport: WorldBorder.clampVec3ToBound keeps the
    // target inside the border (Mth.clamp, 1.0E-5F inside the far edges).
    // rust: let (x, z) = match w.border {
    // rust: Some(border) => {
    // rust: let [min_x, min_z, max_x, max_z] = border.bounds(0.0);
    // rust: let clamp = |v: f64, low: f64, high: f64| if v < low { low } else { v.min(high) };
    // rust: (
    // rust: clamp(x, min_x, max_x - f64::from(1.0e-5_f32)),
    // rust: clamp(z, min_z, max_z - f64::from(1.0e-5_f32)),
    // rust: )
}
    // rust: None => (x, z),
}
    // rust: let (bx, bz) = (x.floor() as i32, z.floor() as i32);
    // rust: if !w.world.loaded(bx, bz) {
    // rust: return false;
}
    // rust: let mut by = y.floor() as i32;
    // rust: while by > w.world.bottom_y() && !w.facts.get(w.world.block(bx, by, bz)).full_collision {
    // rust: by -= 1;
}
    // rust: let ground = w.facts.get(w.world.block(bx, by, bz));
    // rust: if !ground.full_collision || ground.fluid == Fluid::Water {
    // rust: return false;
}
    // rust: let ny = f64::from(by + 1);
    // rust: let half = f64::from(m.width()) / 2.0;
    // rust: let b = Aabb::new(
    // rust: Vec3::new(x - half, ny, z - half),
    // rust: Vec3::new(x + half, ny + f64::from(m.height()), z + half),
    // rust: );
    // rust: if !w.no_collision(b) || w.fluids(b, ny + m.eye_height()).in_water || w.fluids(b, ny).in_lava {
    // rust: return false;
}
    // rust: let old = m.center();
    // rust: let old_block = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: m.position = Vec3::new(x, ny, z);
    // rust: m.previous = m.position;
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.ai.nav.stop();
    // `LivingEntity.randomTeleport(..., true)` broadcasts entity event 46
    // before the trail and the teleport sounds.
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 46,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: if !m.silent {
        // Level event 2018: the portal trail, from the old block to the new
        // one, packed as `BlockUtil.clampedPackDifferenceInPosition` does.
    // rust: let new_block = [x.floor() as i32, ny.floor() as i32, z.floor() as i32];
    // rust: let packed = |k: usize| ((new_block[k] - old_block[k]).clamp(-127, 127) + 127) & 255;
    // rust: events.push(MobEvent::LevelEvent {
    // rust: id: 2018,
    // rust: pos: old_block,
    // rust: data: packed(0) << 16 | packed(1) << 8 | packed(2),
    // rust: });
}
    // rust: events.push(MobEvent::Sound("entity.enderman.teleport", old, 1.0, 1.0));
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.enderman.teleport",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: true
}
pub fn teleport_random(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.alive() {
    // rust: return false;
}
    // rust: let x = m.position.x + (m.random.next_double() - 0.5) * 64.0;
    // rust: let y = m.position.y + f64::from(m.random.next_int_bound(64).unwrap_or(32) - 32);
    // rust: let z = m.position.z + (m.random.next_double() - 0.5) * 64.0;
    // rust: teleport_to(m, w, x, y, z, events)
}
    // rust: fn teleport_towards(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: at: Vec3,
    // rust: eye_y: f64,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> bool {
    // rust: let mut d = [
    // rust: m.position.x - at.x,
    // rust: m.position.y + f64::from(m.height()) * 0.5 - eye_y,
    // rust: m.position.z - at.z,
    // rust: ];
    // rust: let len = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt().max(1.0e-9);
    // rust: d = d.map(|c| c / len);
    // rust: let x = m.position.x + (m.random.next_double() - 0.5) * 8.0 - d[0] * 16.0;
    // rust: let y = m.position.y + f64::from(m.random.next_int_bound(16).unwrap_or(8) - 8) - d[1] * 16.0;
    // rust: let z = m.position.z + (m.random.next_double() - 0.5) * 8.0 - d[2] * 16.0;
    // rust: teleport_to(m, w, x, y, z, events)
}
/// `Enderman.SPEED_MODIFIER_ATTACKING`, an ADD_VALUE modifier `setTarget`
/// adds while the enderman has a target.
pub fn attacking_speed(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.species() == Species::Enderman && m.ai.target.is_some() {
    // rust: f64::from(0.15f32)
    // rust: } else {
    // rust: 0.0
}
}
/// Enderman.customServerAiStep: in daylight, flee by teleporting. The End has a
/// fixed time, so `Level.isBrightOutside` is never true there.
pub fn custom_server_ai_step(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if cx.w.daylight && !cx.w.end && m.age as i32 >= m.extra.counter + 600 {
    // rust: let br = super::hostile::mob_brightness(m, cx.w);
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: if br > 0.5 && cx.w.can_see_sky(x, y, z) && m.random.next_float() * 30.0 < (br - 0.4) * 2.0
    // rust: {
    // rust: m.ai.target = None;
    // rust: teleport_random(m, cx.w, cx.events);
}
}
    // Being angry (target set) makes the head "creepy" (render).
    // rust: m.extra.flag = m.ai.target.is_some();
}
/// Whether a hit teleports the enderman away instead of hurting it: any
/// projectile, unless it rides something (`!isPassenger()`).
pub fn dodges(m: *Mob, source: *Damage) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: source.is_projectile() && !m.extra.passenger
}
/// Enderman.hurtServer: projectiles miss (teleport away), others may teleport.
pub fn on_damage(m: *mut Mob, source: *Damage) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if dodges(m, source) {
        // repeatedlyTryToTeleport is applied by the next AI step.
    // rust: m.extra.counter2 = 64;
    // rust: return false;
}
    // rust: true
}
pub fn after_hurt(m: *mut Mob, source: *Damage) void {
}
    // A thrown potion's hit (`indirect_magic`, which only a splash potion
    // deals to a mob) leaves `Enderman.hurtServer` before the random chance:
    // `repeatedlyTryToTeleport` replaces it.
    // rust: if source.kind != super::DamageKind::IndirectMagic
    // rust: && source.attacker.is_none()
    // rust: && m.random.next_int_bound(10).unwrap_or(0) != 0
    // rust: {
    // rust: m.extra.counter2 = 1;
}
}
/// Pending teleports (repeatedlyTryToTeleport: up to 64 tries).
pub fn ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // Enderman.aiStep: never jumps.
    // rust: m.ai.jumping = false;
    // rust: if m.extra.counter2 > 0 {
    // rust: let tries = m.extra.counter2;
    // rust: m.extra.counter2 = 0;
        // repeatedlyTryToTeleport (64 tries) returns before any draw while riding;
        // a single `teleport()` still draws its target first.
    // rust: let tries = if tries > 1 && m.extra.passenger {
    // rust: 0
    // rust: } else {
    // rust: tries
}
    // rust: for _ in 0..tries {
    // rust: if teleport_random(m, w, events) {
    // rust: break;
}
}
}
    // rust: if (m.fluids.in_water || super::ai::in_rain(m, w)) && m.alive() {
        // Hurt by water: teleport away.
    // rust: m.extra.counter2 = m.extra.counter2.max(1);
}
}
/// EndermanModel.setupAnim: half-speed clamped limbs, held-block arms, creepy head.
/// Humanoid riding pose runs first (`isPassenger`); only xRot is halved/clamped after.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: super::anim::humanoid_pub(p, s, m);
    // rust: for part in ["right_arm", "left_arm", "right_leg", "left_leg"] {
    // rust: let x = p.get(part)[3] * 0.5;
    // rust: p.xrot(part, x.clamp(-0.4, 0.4));
}
    // rust: if m.extra.carried.is_some() {
    // rust: p.xrot("right_arm", -0.5);
    // rust: p.xrot("left_arm", -0.5);
    // rust: p.zrot("right_arm", 0.05);
    // rust: p.zrot("left_arm", -0.05);
}
    // rust: if m.extra.flag {
    // rust: p.get("head")[1] -= 5.0;
    // rust: p.get("hat")[1] += 5.0;
}
}
/// EndermanFreezeWhenLookedAt
pub const FreezeWhenLookedAt = struct {};
    // rust: impl Goal for FreezeWhenLookedAt {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JUMP | MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.ai.target != Some(Who::Player) {
    // rust: return false;
}
    // rust: let Some(p) = &cx.w.player else { return false };
    // rust: m.distance_sqr(p.position) <= 256.0 && stared_at(m, cx.w)
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(p) = &cx.w.player {
    // rust: let at = [p.position.x, p.eye[1], p.position.z];
    // rust: m.look_at(at);
}
}
}
/// EndermanLookForPlayerGoal: anger after being stared at for 5 ticks,
/// teleport away when stared at close up, or towards a far target.
pub const LookForPlayer = struct {
    pending: bool,
    aggro: i32,
    teleport: i32,
};
    // rust: impl Goal for LookForPlayer {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TARGET
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = &cx.w.player else { return false };
    // rust: self.pending = p.alive
    // rust: && !p.creative
    // rust: && m.distance_sqr(p.position) <= m.attrs.follow_range.powi(2)
    // rust: && stared_at(m, cx.w);
    // rust: self.pending
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: self.aggro = reduced(5);
    // rust: self.teleport = 0;
        // setBeingStaredAt: play the stare sound.
    // rust: m.extra.counter = m.age as i32;
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: self.pending = false;
    // rust: m.ai.target = None;
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = cx.w.player.clone() else {
    // rust: return false;
}
    // rust: if self.pending {
    // rust: if !stared_at(m, cx.w) {
    // rust: return false;
}
    // rust: m.turn_to(p.eye, 10.0, 10.0);
    // rust: return true;
}
    // rust: p.alive
    // rust: && !p.creative
    // rust: && m.ai.target == Some(Who::Player)
    // rust: && m.distance_sqr(p.position) <= m.attrs.follow_range.powi(2)
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(p) = cx.w.player.clone() else { return };
    // rust: if self.pending {
    // rust: self.aggro -= 1;
    // rust: if self.aggro <= 0 {
    // rust: self.pending = false;
    // rust: m.ai.target = Some(Who::Player);
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.enderman.stare",
    // rust: m.center(),
    // rust: 2.5,
    // rust: 1.0,
    // rust: ));
}
    // rust: } else if m.ai.target == Some(Who::Player) && !m.extra.passenger {
    // rust: if stared_at(m, cx.w) {
    // rust: if m.distance_sqr(p.position) < 16.0 {
    // rust: teleport_random(m, cx.w, cx.events);
}
    // rust: self.teleport = 0;
    // rust: } else {
    // rust: let far = m.distance_sqr(p.position) > 256.0;
    // rust: let t = self.teleport;
    // rust: if far {
    // rust: self.teleport += 1;
}
    // rust: if far
    // rust: && t >= reduced(30)
    // rust: && teleport_towards(m, cx.w, p.position, p.eye[1], cx.events)
    // rust: {
    // rust: self.teleport = 0;
}
}
}
}
}
/// EndermanTakeBlockGoal
pub const TakeBlock = struct {};
    // rust: impl Goal for TakeBlock {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
        // EndermanTakeBlockGoal.canUse: needs mobGriefing, checked before the draw.
    // rust: m.extra.carried.is_none()
    // rust: && cx.w.mob_griefing
    // rust: && m.random.next_int_bound(reduced(20)).unwrap_or(1) == 0
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let x = (m.position.x - 2.0 + m.random.next_double() * 4.0).floor() as i32;
    // rust: let y = (m.position.y + m.random.next_double() * 3.0).floor() as i32;
    // rust: let z = (m.position.z - 2.0 + m.random.next_double() * 4.0).floor() as i32;
    // rust: let state = cx.w.world.block(x, y, z);
    // rust: let name = cx.w.facts.get(state).name.to_string();
    // rust: if !cx.w.has_tag("minecraft:enderman_holdable", &name) {
    // rust: return;
}
        // Reachable: the clip from the mob's column hits this block first.
    // rust: let from = Vec3::new(
    // rust: m.position.x.floor() + 0.5,
    // rust: f64::from(y) + 0.5,
    // rust: m.position.z.floor() + 0.5,
    // rust: );
    // rust: let to = Vec3::new(f64::from(x) + 0.5, f64::from(y) + 0.5, f64::from(z) + 0.5);
    // rust: let dx = (x - m.position.x.floor() as i32).abs() + (z - m.position.z.floor() as i32).abs();
    // rust: if dx > 0
    // rust: && !cx.w.clear_between(
    // rust: from,
    // rust: Vec3::new(
    // rust: to.x - (to.x - from.x) * 0.3,
    // rust: to.y,
    // rust: to.z - (to.z - from.z) * 0.3,
    // rust: ),
    // rust: false,
    // rust: )
    // rust: {
    // rust: return;
}
    // rust: cx.events.push(MobEvent::SetBlock {
    // rust: pos: [x, y, z],
    // rust: state: cx.w.world.air,
    // rust: });
    // rust: m.extra.carried = Some(state);
}
}
/// EndermanLeaveBlockGoal
pub const LeaveBlock = struct {};
    // rust: impl Goal for LeaveBlock {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
        // EndermanLeaveBlockGoal.canUse: needs mobGriefing, checked before the draw.
    // rust: m.extra.carried.is_some()
    // rust: && cx.w.mob_griefing
    // rust: && m.random.next_int_bound(reduced(2000)).unwrap_or(1) == 0
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(carried) = m.extra.carried else {
    // rust: return;
}
    // rust: let x = (m.position.x - 1.0 + m.random.next_double() * 2.0).floor() as i32;
    // rust: let y = (m.position.y + m.random.next_double() * 2.0).floor() as i32;
    // rust: let z = (m.position.z - 1.0 + m.random.next_double() * 2.0).floor() as i32;
    // rust: let area = Aabb::new(
    // rust: Vec3::new(f64::from(x), f64::from(y), f64::from(z)),
    // rust: Vec3::new(f64::from(x + 1), f64::from(y + 1), f64::from(z + 1)),
    // rust: );
        // Keep the per-mob occupancy view: later mobs have not moved yet.
    // rust: let occupants = cx.w.others_near(area).map(|s| s.bounds).collect();
        // Game owns the mutable level, its scheduled ticks, RNG and shape hooks.
        // Defer the complete attempt, including failed candidates' shape updates.
    // rust: cx.events.push(MobEvent::EndermanPlaceBlock {
    // rust: mob: m.id,
    // rust: pos: [x, y, z],
    // rust: carried,
    // rust: occupants,
    // rust: });
}
}

/// The tool `Enderman.dropCustomDeathLoot` rolls the carried block's drops
/// with: a diamond axe enchanted by `VanillaEnchantmentProviders.ENDERMAN_LOOT_DROP`
/// (`enchantment_provider/enderman_loot_drop.json`, a single Silk Touch I),
/// so the block itself comes back.
pub fn carried_block_tool() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut axe = ItemStack::new("minecraft:diamond_axe", 1);
    // rust: axe.enchant("minecraft:silk_touch", 1);
    // rust: axe
}

/// `Enderman.dropCustomDeathLoot`: `BlockState.getDrops` of the carried
/// state with [`carried_block_tool`] and the enderman as `this` entity,
/// drawing from the block table's random sequence (`sequences`: the world's
/// sequences and seed), else `random` (the level random).
    // rust: pub fn carried_block_drops(
    // rust: items: &Items,
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: random: &mut impl RandomSource,
    // rust: sequences: Option<(&mut RandomSequences, i64)>,
    // rust: ) -> Vec<ItemStack> {
    // rust: let tool = carried_block_tool();
    // rust: items
    // rust: .block_drops_exploded(
    // rust: registry,
    // rust: state,
    // rust: Some(&tool),
    // rust: &[],
    // rust: random,
    // rust: sequences,
    // rust: None,
    // rust: true,
    // rust: )
    // rust: .into_iter()
    // rust: .filter(|s| s.count > 0 && &*s.item != "minecraft:air")
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::DamageKind;
//     use std::sync::Arc;

pub fn enderman() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::Enderman;
    // rust: Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0)
}

    /// Enderman.hurtServer: a projectile makes a free enderman teleport away
    /// unhurt, but one that rides something (`isPassenger`) takes the hit.
pub fn projectiles_hit_a_seated_enderman() void {
}
    // rust: for kind in [DamageKind::Arrow, DamageKind::Thrown, DamageKind::Fireball] {
    // rust: let mut free = enderman();
    // rust: assert!(!on_damage(&mut free, &Damage::of(kind)), "{kind:?}");
    // rust: assert_eq!(free.extra.counter2, 64);
            // The arrow handler keeps the arrow flying when the enderman dodges.
    // rust: assert!(dodges(&free, &Damage::of(kind)), "{kind:?}");

    // rust: let mut seated = enderman();
    // rust: seated.extra.passenger = true;
    // rust: assert!(on_damage(&mut seated, &Damage::of(kind)), "{kind:?}");
    // rust: assert_eq!(seated.extra.counter2, 0, "no teleport while seated");
    // rust: assert!(!dodges(&seated, &Damage::of(kind)), "{kind:?}");
}
}

    /// Enderman.teleport(x, y, z) fails for a passenger (#4865: one in a boat
    /// played the teleport sound every tick and snapped back to its seat).
    /// `repeatedlyTryToTeleport` returns before drawing; `teleport()` still
    /// draws its three values first.
pub fn a_seated_enderman_never_teleports() void {
}
    // rust: let build = |world: &mut crate::world::World, registry: &BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for cx in -2..2 {
    // rust: for cz in -2..2 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -32..32 {
    // rust: for z in -32..32 {
    // rust: world.set(x, -1, z, stone).unwrap();
}
}
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, _| {
    // rust: let mut events = Vec::new();
    // rust: let mut free = enderman();
    // rust: assert!((0..64).any(|_| teleport_random(&mut free, w, &mut events)));
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::EntityEvent { event: 46, .. })),
    // rust: "entity event 46: {events:?}"
    // rust: );

    // rust: let mut seated = enderman();
    // rust: seated.extra.passenger = true;
    // rust: events.clear();
    // rust: assert!(!(0..64).any(|_| teleport_random(&mut seated, w, &mut events)));
    // rust: assert!(events.is_empty());
    // rust: assert_eq!(seated.position, Vec3::ZERO);

    // rust: for tries in [64, 1] {
    // rust: let mut seated = enderman();
    // rust: seated.extra.passenger = true;
    // rust: let mut expected = enderman().random;
    // rust: if tries == 1 {
    // rust: expected.next_double();
    // rust: expected.next_int_bound(64).unwrap();
    // rust: expected.next_double();
}
    // rust: seated.extra.counter2 = tries;
    // rust: ai_step(&mut seated, w, &mut events);
    // rust: assert!(events.is_empty(), "{tries}");
    // rust: assert_eq!(seated.random.next_int(), expected.next_int(), "{tries}");
}
    // rust: });
}

    /// LivingEntity.randomTeleport clamps the target into the world border
    /// (`WorldBorder.clampVec3ToBound`), so an enderman never lands outside
    /// it (#7080). A border of size 10 around the origin ends at x = 5.
pub fn an_enderman_teleports_inside_the_world_border() void {
}
    // rust: let build = |world: &mut crate::world::World, registry: &BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for cx in -2..2 {
    // rust: for cz in -2..2 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -32..32 {
    // rust: for z in -32..32 {
    // rust: world.set(x, -1, z, stone).unwrap();
}
}
}
    // rust: let border =
    // rust: horizon_core::geometry::border::BorderGeometry::new([0.0, 0.0], 10.0, 29_999_984)
    // rust: .unwrap();
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, _| {
    // rust: let mut free = enderman();
    // rust: assert!(teleport_to(&mut free, w, 20.5, 0.0, 0.5, &mut Vec::new()));
    // rust: assert_eq!(free.position, Vec3::new(20.5, 0.0, 0.5), "no border");

    // rust: let w = MobWorld {
    // rust: border: Some(&border),
    // rust: ..w.clone()
}
    // rust: let mut bounded = enderman();
    // rust: assert!(teleport_to(
    // rust: &mut bounded,
    // rust: &w,
    // rust: 20.5,
    // rust: 0.0,
    // rust: -20.5,
    // rust: &mut Vec::new()
    // rust: ));
            // Mth.clamp to [min, max - 1.0E-5F] on x and z.
    // rust: let edge = 5.0 - f64::from(1.0e-5_f32);
    // rust: assert_eq!(bounded.position, Vec3::new(edge, 0.0, -5.0));
    // rust: });
}

    /// Enderman.dropCustomDeathLoot (#3513): a killed enderman drops the
    /// block it carries, mined with a silk touch diamond axe, so a grass
    /// block comes back as a grass block (not dirt) and a nylium as itself.
pub fn a_killed_enderman_drops_its_carried_block() void {
}
//         use crate::mobs::drops;
//         use horizon_world::loot::{LootData, PackOverlay};
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() || !root.join("data").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = crate::blocks::BlockFacts::load(&root, registry).unwrap();
    // rust: let items = Items::load(&root, registry, &facts, &PackOverlay::NONE).unwrap();
    // rust: let loot = LootData::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let death = |mob_drops| drops::Death {
    // rust: loot: &loot,
    // rust: damage: None,
    // rust: player: None,
    // rust: luck: 0.0,
    // rust: vehicle: None,
    // rust: mob_drops,
    // rust: world_seed: 0,
}
    // rust: let mut sequences = RandomSequences::default();
    // rust: let mut random = horizon_core::random::LegacyRandom::new(0);
    // rust: for block in [
    // rust: "minecraft:grass_block",
    // rust: "minecraft:crimson_nylium",
    // rust: "minecraft:tnt",
    // rust: ] {
    // rust: let mut m = enderman();
    // rust: m.extra.carried = registry.default_state(block);
    // rust: let (out, _) = drops::die(
    // rust: &mut m,
    // rust: &death(true),
    // rust: &mut sequences,
    // rust: &mut horizon_core::random::LegacyRandom::new(0),
    // rust: );
    // rust: let dropped: Vec<String> = out
    // rust: .into_iter()
    // rust: .flat_map(|d| match d {
    // rust: drops::Drop::CarriedBlock(state) => carried_block_drops(
    // rust: &items,
    // rust: registry,
    // rust: state,
    // rust: &mut random,
    // rust: Some((&mut sequences, 0)),
    // rust: ),
    // rust: _ => Vec::new(),
    // rust: })
    // rust: .map(|s| format!("{} {}", s.item, s.count))
    // rust: .collect();
    // rust: assert_eq!(dropped, [format!("{block} 1")], "{block}");
}
        // doMobLoot off: no dropCustomDeathLoot, so no block either.
    // rust: let mut m = enderman();
    // rust: m.extra.carried = registry.default_state("minecraft:grass_block");
    // rust: let (out, _) = drops::die(
    // rust: &mut m,
    // rust: &death(false),
    // rust: &mut sequences,
    // rust: &mut horizon_core::random::LegacyRandom::new(0),
    // rust: );
    // rust: assert!(
    // rust: !out.iter()
    // rust: .any(|d| matches!(d, drops::Drop::CarriedBlock(_))),
    // rust: "{out:?}"
    // rust: );
}
}
