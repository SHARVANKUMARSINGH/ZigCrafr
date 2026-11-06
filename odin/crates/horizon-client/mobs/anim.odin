//! Transpiled from Horizon Rust crate
package horizon_client_anim

import "core:fmt"
import "core:mem"
import "core:math"

// Model animation: ports of each vanilla `EntityModel.setupAnim` family
// (quadrupeds, humanoids, creepers, spiders, chickens...) applied to a map of
// part poses before the model is drawn.
// use super::{Mob, Part, keyframes::AnimationState, living::wrap};
// use crate::fast_hash::{FxHashMap, FxHashSet};
// use horizon_core::geometry::trig::Mth;
// use std::collections::HashMap;
// use std::f32::consts::{FRAC_PI_6, PI};

// The setupAnim implementation a model uses.
Anim :: enum {
    Nautilus,
    HappyGhast,
    Sniffer,
    Breeze,
    Warden,
    Allay,
    Creaking,
    Camel,
    Wither,
    Vex,
    Ravager,
    Guardian,
    Shulker,
    Quadruped,
    Sheep,
    Chicken,
    Zombie,
    Drowned,
    ZombieVillager,
    Skeleton,
    Creeper,
    Spider,
    Enderman,
    Silverfish,
    Slime,
    MagmaCube,
    Witch,
    Villager,
    IronGolem,
    SnowGolem,
    CopperGolem,
    Illager,
    Piglin,
    ZombifiedPiglin,
    Hoglin,
    Wolf,
    Feline,
    Fox,
    Rabbit,
    Horse,
    Llama,
    Goat,
    Panda,
    PolarBear,
    Parrot,
    Bee,
    Turtle,
    Armadillo,
    Frog,
    Axolotl,
    Squid,
    Fish,
    Pufferfish,
    Dolphin,
    Bat,
    Phantom,
    Ghast,
    Blaze,
    Strider,
    // The humanoid model of the earlier simple renderer.
    Humanoid {,
    zombie_arms: bool,
    // rust: },
}
// Client-side animation clocks advanced each tick.
AnimState :: struct {
    attack_anim: f32,
    attack_anim_o: f32,
    flap: f32,
    flap_o: f32,
    flap_speed: f32,
    flap_speed_o: f32,
    flapping: f32,
    // Generic per-species keyframe animation states.
    states: [AnimationState,
    // Per-species animation values (tail wag, squid tentacles, squish...)
    // with their previous-tick copies for interpolation.
    v: [f32,
    vo: [f32,
}
    // rust: impl AnimState {
begin_tick :: proc(self: ^Self) {
}
    // rust: self.attack_anim_o = self.attack_anim;
    // rust: self.vo = self.v;
}
    // Interpolated value `i` at the render partial tick.
lerp :: proc(self: ^Self, i: uint, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.vo[i] + (self.v[i] - self.vo[i]) * partial
}
end_tick :: proc(self: ^Self, _swinging: bool) {
}
}
// A part name as `Poses` keys it: its Fx hash, so filling a pose map allocates
// nothing (a mob farm resets one per layer per mob each frame). Names are short
// and few per model; `no_two_part_names_share_a_key` checks every vanilla model.
    // rust: pub(crate) fn key(name: &str) -> u64 {
//     use std::hash::Hasher;
    // rust: let mut h = crate::fast_hash::FxHasher::default();
    // rust: h.write(name.as_bytes());
    // The length too, so "a" and "a\0" differ (str's own Hash adds a terminator).
    // rust: h.write_usize(name.len());
    // rust: h.finish()
}
// Part poses for one draw, keyed by part name.
Poses :: struct {
    map: FxHashMap<u64,
    dummy: [f32,
    // Parts with `skipDraw` set: their own cubes are not drawn, children are.
    skipped: FxHashSet<u64>,
    // Parts with `visible` cleared: neither they nor their children draw.
    hidden: FxHashSet<u64>,
    // Names this content: a fresh number at each change, kept by copies
    // ([`Poses::version`]).
    version: u64,
}
// The next [`Poses::version`].
NEXT_VERSION :: std::sync::atomic::AtomicU64::new(1)
    // rust: thread_local! {
    // Spare `Poses` for [`Poses::pooled`].
POOL :: const { std::cell::RefCell::new(Vec::new()) }
}
// A [`Poses`] from this thread's pool, given back when dropped.
PooledPoses :: struct {
    // rust: impl std::ops::Deref for PooledPoses {
    // rust: type Target = Poses;
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0
}
}
    // rust: impl std::ops::DerefMut for PooledPoses {
deref_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.0
}
}
    // rust: impl Drop for PooledPoses {
drop :: proc(self: ^Self) {
}
    // rust: let poses = std::mem::take(&mut self.0);
        // A few per thread: a mob's body and layers, a rider's.
    // rust: let _ = POOL.try_with(|pool| {
    // rust: let mut pool = pool.borrow_mut();
    // rust: if pool.len() < 8 {
    // rust: pool.push(poses);
}
    // rust: });
}
}
    // rust: impl Poses {
new :: proc(model: ^Part) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut poses = Self::default();
    // rust: poses.reset(model);
    // rust: poses
}
    // Spare `Poses` of an earlier draw on this thread, to fill with `reset` or
    // `copy_from` before use: a mob farm poses every mob each frame, and fresh
    // maps grow (and rehash) part by part.
pooled :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: PooledPoses(
    // rust: POOL.try_with(|pool| pool.borrow_mut().pop())
    // rust: .ok()
    // rust: .flatten()
    // rust: .unwrap_or_default(),
    // rust: )
}
    // Names the content: two `Poses` with the same version pose every part
    // alike (one is a copy of the other, neither changed since). A draw of
    // the same model under the same matrix with the same version can reuse
    // the first's part matrices (`skin::Skin::draw`).
version :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.version
}
changed :: proc(self: ^Self) {
}
    // rust: self.version = NEXT_VERSION.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
}
    // Makes this a copy of `other`, keeping this one's capacity.
copy_from :: proc(self: ^Self, other: ^Poses) {
}
    // rust: self.map.clone_from(&other.map);
    // rust: self.dummy = other.dummy;
    // rust: self.skipped.clone_from(&other.skipped);
    // rust: self.hidden.clone_from(&other.hidden);
    // rust: self.version = other.version;
}
    // Refills this for another model, keeping the map and the sets' capacity:
    // a mob draws its body and every equipment layer each frame.
reset :: proc(self: ^Self, model: ^Part) {
}
walk :: proc(p: ^Part, map: ^FxHashMap<u64) {
}
            // ModelPart.createPartLookup fills its map with putIfAbsent: the first part keeps a name.
    // rust: map.entry(key(&p.name)).or_insert(p.pose);
    // rust: for c in &p.children {
    // rust: walk(c, map);
}
}
    // rust: self.map.clear();
    // rust: self.dummy = [0.0; 9];
    // rust: self.skipped.clear();
    // rust: self.hidden.clear();
    // rust: walk(model, &mut self.map);
    // rust: self.changed();
}
get :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.changed();
    // rust: match self.map.get_mut(&key(name)) {
    // rust: Some(p) => p,
    // rust: None => &mut self.dummy,
}
}
pose :: proc(self: ^Self, part: ^Part) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.map.get(&key(&part.name)).copied().unwrap_or(part.pose)
}
skip_draw :: proc(self: ^Self, name: string) {
}
    // rust: if self.skipped.insert(key(name)) {
    // rust: self.changed();
}
}
skips :: proc(self: ^Self, part: ^Part) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.skips_named(&part.name)
}
    // `skips` by the part's name.
skips_named :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.skipped.is_empty() && self.skipped.contains(&key(name))
}
has :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.map.contains_key(&key(name))
}
xrot :: proc(self: ^Self, n: string, v: f32) {
}
    // rust: self.get(n)[3] = v;
}
yrot :: proc(self: ^Self, n: string, v: f32) {
}
    // rust: self.get(n)[4] = v;
}
zrot :: proc(self: ^Self, n: string, v: f32) {
}
    // rust: self.get(n)[5] = v;
}
    // `ModelPart.visible = v`; a hidden part and its children do not draw.
visible :: proc(self: ^Self, n: string, v: bool) {
}
    // rust: let changed = if v {
    // rust: self.hidden.remove(&key(n))
    // rust: } else {
    // rust: self.map.contains_key(&key(n)) && self.hidden.insert(key(n))
}
    // rust: if changed {
    // rust: self.changed();
}
}
is_hidden :: proc(self: ^Self, part: ^Part) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_hidden_named(&part.name)
}
    // `is_hidden` by the part's name.
is_hidden_named :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.hidden.is_empty() && self.hidden.contains(&key(name))
}
}
// The LivingEntityRenderState values setupAnim reads.
State :: struct {
    pos: f32,
    speed: f32,
    age: f32,
    // Head yaw relative to the body, degrees.
    y_rot: f32,
    // Head pitch, degrees.
    x_rot: f32,
    swing: f32,
    baby: bool,
    partial: f32,
}
// `WalkAnimationState.position(partial)`: babies' legs move 3 times as far.
walk_position :: proc(m: ^Mob, alpha: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (m.limb_position - m.limb_speed * (1.0 - alpha)) * if m.is_baby() { 3.0 } else { 1.0 }
}
state :: proc(m: ^Mob, alpha: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let body = m.previous_body_yaw + wrap(m.body_yaw - m.previous_body_yaw) * alpha;
    // rust: let head = m.previous_head_yaw + wrap(m.head_yaw - m.previous_head_yaw) * alpha;
    // rust: let mut swing = m.anim.attack_anim - m.anim.attack_anim_o;
    // rust: if swing < 0.0 {
    // rust: swing += 1.0;
}
    // rust: let swing = m.anim.attack_anim_o + swing * alpha;
    // LivingEntityRenderer.extractRenderState: riding motion is not walking.
    // rust: let walking = m.alive() && !m.extra.passenger;
    // rust: State {
    // rust: pos: if walking {
    // rust: walk_position(m, alpha)
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: speed: if walking {
    // rust: (m.previous_limb_speed + (m.limb_speed - m.previous_limb_speed) * alpha).min(1.0)
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: age: m.age as f32 + alpha,
    // rust: y_rot: wrap(head - body),
    // rust: x_rot: m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha,
    // rust: swing,
    // rust: baby: m.is_baby(),
    // rust: partial: alpha,
}
}
head :: proc(p: ^Poses, s: ^State) {
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
}
// QuadrupedModel.setupAnim
    // rust: pub(super) fn quadruped(p: &mut Poses, s: &State) {
    // rust: head(p, s);
    // rust: let (pos, sp) = (s.pos, s.speed);
    // rust: p.xrot("right_hind_leg", (pos * 0.6662).mcos() * 1.4 * sp);
    // rust: p.xrot("left_hind_leg", (pos * 0.6662 + PI).mcos() * 1.4 * sp);
    // rust: p.xrot("right_front_leg", (pos * 0.6662 + PI).mcos() * 1.4 * sp);
    // rust: p.xrot("left_front_leg", (pos * 0.6662).mcos() * 1.4 * sp);
}
// AnimationUtils.bobModelPart
bob :: proc(p: ^Poses, n: string, age: f32, scale: f32) {
}
    // rust: let q = p.get(n);
    // rust: q[5] += scale * ((age * 0.09).mcos() * 0.05 + 0.05);
    // rust: q[3] += scale * ((age * 0.067).msin() * 0.05);
}
ArmPose :: enum {
    Empty,
    Item,
    Block,
    Bow,
    CrossbowHold,
    CrossbowCharge,
    // Raising a trident to throw it (or to launch with Riptide).
    ThrowTrident,
    // Playing a goat horn.
    TootHorn,
    // Looking through a spyglass (`HumanoidModel.ArmPose.SPYGLASS`).
    Spyglass,
    // A spear held out (`HumanoidModel.ArmPose.SPEAR`), at rest or charging.
    Spear,
    // A brush being used (`HumanoidModel.ArmPose.BRUSH`).
    Brush,
}
// HumanoidModel.setupAnim with empty hands (endermen).
// Passes `isPassenger` so a seated enderman keeps the humanoid riding pose
// (vanilla EndermanModel.setupAnim calls super first, then halves/clamps xRot).
humanoid_pub :: proc(p: ^Poses, s: ^State, m: ^Mob) {
}
    // rust: let mut h = Hum::new(ArmPose::Empty, ArmPose::Empty);
    // rust: h.passenger = m.extra.passenger;
    // rust: humanoid(p, s, &h);
}
// `AnimationUtils.swingWeaponDown`: the main arm swings down, the other
// one hangs and bobs.
    // rust: pub(super) fn swing_weapon_down(p: &mut Poses, swing: f32, age: f32, left_main: bool) {
    // rust: let attack2 = (swing * PI).msin();
    // rust: let attack = ((1.0 - (1.0 - swing) * (1.0 - swing)) * PI).msin();
    // rust: let (main, off) = if left_main {
    // rust: ("left_arm", "right_arm")
    // rust: } else {
    // rust: ("right_arm", "left_arm")
}
    // rust: p.zrot("right_arm", 0.0);
    // rust: p.zrot("left_arm", 0.0);
    // rust: p.yrot("right_arm", PI / 20.0);
    // rust: p.yrot("left_arm", -PI / 20.0);
    // rust: p.xrot(main, -1.884_955_8 + (age * 0.09).mcos() * 0.15);
    // rust: p.xrot(off, -0.0 + (age * 0.19).mcos() * 0.5);
    // rust: p.get(main)[3] += attack2 * 2.2 - attack * 0.4;
    // rust: p.get(off)[3] += attack2 * 1.2 - attack * 0.4;
    // rust: bob(p, "right_arm", age, 1.0);
    // rust: bob(p, "left_arm", age, -1.0);
}
// What `HumanoidModel.setupAnim` reads besides the walk and head inputs.
Hum :: struct {
    right: ArmPose,
    left: ArmPose,
    crouching: bool,
    passenger: bool,
    fall_flying: bool,
    fly_speed_scale: f32,
    // `Some(aggressive)` for `ZombieModel`-style `animateZombieArms`.
    zombie: Maybe(bool),
    // The main hand holds something (`getMainHandItemStack() != EMPTY`).
    holding: bool,
    // `maxCrossbowChargeDuration`, `ticksUsingItem`.
    charge: (f32,
    // `PiglinModel.setupAttackAnimation`: swing a held weapon down.
    weapon_swing: bool,
    // `swimAmount` at this frame.
    swim: f32,
    // `isUsingItem`: the swim stroke leaves the arms alone.
    using_item: bool,
    // The arm the current swing moves (`Some(true)` for the right one).
    swing_right_arm: Maybe(bool),
    // The swing is a STAB (`SwingAnimationType` 2): a spear's jab.
    stab: bool,
    // `mainArm` is the left one (`Mob.isLeftHanded`): a mob's swing uses it.
    left_main: bool,
    // The spear each arm (right, left) holds, and how long that arm has
    // been using it (`ticksUsingItem(arm)`, 0 when it is not).
    spear: [Maybe(crate::spear::Kinetic),
    spear_ticks: [f32,
}
    // rust: impl Hum {
new :: proc(right: ArmPose, left: ArmPose) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: right,
    // rust: left,
    // rust: crouching: false,
    // rust: passenger: false,
    // rust: fall_flying: false,
    // rust: fly_speed_scale: 1.0,
    // rust: zombie: None,
    // rust: holding: false,
    // rust: charge: (0.0, 0.0),
    // rust: weapon_swing: false,
    // rust: swim: 0.0,
    // rust: using_item: false,
    // rust: swing_right_arm: None,
    // rust: stab: false,
    // rust: left_main: false,
    // rust: spear: [None; 2],
    // rust: spear_ticks: [0.0; 2],
}
}
}
    // rust: impl ArmPose {
two_handed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::Bow | Self::CrossbowHold | Self::CrossbowCharge)
}
affects_offhand :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.two_handed() || self == Self::ThrowTrident
}
}
// `AnimationUtils.animateCrossbowHold`.
    // rust: pub(super) fn crossbow_hold(p: &mut Poses, hx: f32, hy: f32, in_right: bool) {
    // rust: let (hold, shoot) = if in_right {
    // rust: ("right_arm", "left_arm")
    // rust: } else {
    // rust: ("left_arm", "right_arm")
}
    // rust: p.yrot(hold, if in_right { -0.3 } else { 0.3 } + hy);
    // rust: p.yrot(shoot, if in_right { 0.6 } else { -0.6 } + hy);
    // rust: p.xrot(hold, -PI / 2.0 + hx + 0.1);
    // rust: p.xrot(shoot, -1.5 + hx);
}
// `AnimationUtils.animateCrossbowCharge`.
    // rust: pub(super) fn crossbow_charge(p: &mut Poses, max: f32, ticks: f32, in_right: bool) {
    // rust: let (hold, pull) = if in_right {
    // rust: ("right_arm", "left_arm")
    // rust: } else {
    // rust: ("left_arm", "right_arm")
}
    // rust: p.yrot(hold, if in_right { -0.8 } else { 0.8 });
    // rust: p.xrot(hold, -0.970_796_35);
    // rust: p.xrot(pull, -0.970_796_35);
    // rust: let use_ticks = ticks.clamp(0.0, max);
    // rust: let alpha = use_ticks / max;
    // rust: let lerp = |a: f32, p0: f32, p1: f32| p0 + a * (p1 - p0);
    // rust: p.yrot(
    // rust: pull,
    // rust: lerp(alpha, 0.4, 0.85) * if in_right { 1.0 } else { -1.0 },
    // rust: );
    // rust: let x = lerp(alpha, p.get(pull)[3], -PI / 2.0);
    // rust: p.xrot(pull, x);
}
// `HumanoidModel.SPYGLASS_ARM_ROT_X`.
SPYGLASS_ARM_ROT_X :: 1.919_862_2
// `HumanoidModel.poseRightArm` / `poseLeftArm`.
pose_arm :: proc(p: ^Poses, pose: ArmPose, right: bool, h: ^Hum) {
}
    // rust: let arm = if right { "right_arm" } else { "left_arm" };
    // rust: let (hx, hy) = (p.get("head")[3], p.get("head")[4]);
    // rust: match pose {
    // rust: ArmPose::Empty => p.yrot(arm, 0.0),
    // rust: ArmPose::Item => {
    // rust: let x = p.get(arm)[3];
    // rust: p.xrot(arm, x * 0.5 - PI / 10.0);
    // rust: p.yrot(arm, 0.0);
}
        // Vanilla's BRUSH case: the ITEM pose with twice the drop.
    // rust: ArmPose::Brush => {
    // rust: let x = p.get(arm)[3];
    // rust: p.xrot(arm, x * 0.5 - PI / 5.0);
    // rust: p.yrot(arm, 0.0);
}
    // rust: ArmPose::Block => {
    // rust: let x = p.get(arm)[3] * 0.5 - 0.942_477_9 + hx.clamp(-1.396_263_4, 0.436_332_32);
    // rust: p.xrot(arm, x);
    // rust: p.yrot(
    // rust: arm,
    // rust: if right { -FRAC_PI_6 } else { FRAC_PI_6 } + hy.clamp(-FRAC_PI_6, FRAC_PI_6),
    // rust: );
}
    // rust: ArmPose::Bow => {
    // rust: p.yrot("right_arm", -0.1 + hy - if right { 0.0 } else { 0.4 });
    // rust: p.yrot("left_arm", 0.1 + hy + if right { 0.4 } else { 0.0 });
    // rust: p.xrot("right_arm", -PI / 2.0 + hx);
    // rust: p.xrot("left_arm", -PI / 2.0 + hx);
}
    // rust: ArmPose::ThrowTrident => {
    // rust: let x = p.get(arm)[3];
    // rust: p.xrot(arm, x * 0.5 - PI);
    // rust: p.yrot(arm, 0.0);
}
    // rust: ArmPose::Spyglass => {
    // rust: let crouch = if h.crouching { 0.261_799_4 } else { 0.0 };
    // rust: p.xrot(arm, (hx - SPYGLASS_ARM_ROT_X - crouch).clamp(-2.4, 3.3));
    // rust: p.yrot(arm, hy + if right { -0.261_799_4 } else { 0.261_799_4 });
}
    // rust: ArmPose::TootHorn => {
    // rust: p.xrot(arm, hx.clamp(-1.2, 1.2) - 1.483_529_8);
    // rust: p.yrot(arm, hy + if right { -FRAC_PI_6 } else { FRAC_PI_6 });
}
    // rust: ArmPose::CrossbowHold => crossbow_hold(p, hx, hy, right),
    // rust: ArmPose::CrossbowCharge => crossbow_charge(p, h.charge.0, h.charge.1, right),
        // SpearAnimations.thirdPersonHandUse.
    // rust: ArmPose::Spear => {
    // rust: let side = usize::from(!right);
    // rust: let Some(kinetic) = h.spear[side] else {
    // rust: return;
}
    // rust: let (x, y, z) = crate::spear::third_person_arm(
    // rust: &kinetic,
    // rust: h.spear_ticks[side],
    // rust: right,
    // rust: (hx, hy),
    // rust: h.fall_flying || h.swim > 0.0,
    // rust: );
    // rust: p.xrot(arm, x);
    // rust: p.yrot(arm, y);
    // rust: p.get(arm)[5] += z;
}
}
}
// `HumanoidModel.setupAnim` (and `ZombieModel.setupAttackAnimation`).
    // rust: pub(super) fn humanoid(p: &mut Poses, s: &State, h: &Hum) {
    // rust: head(p, s);
    // rust: if h.fall_flying {
    // rust: p.xrot("head", -std::f32::consts::FRAC_PI_4);
}
    // rust: let (pos, sp) = (s.pos, s.speed / h.fly_speed_scale);
    // rust: p.xrot("right_arm", (pos * 0.6662 + PI).mcos() * 2.0 * sp * 0.5);
    // rust: p.xrot("left_arm", (pos * 0.6662).mcos() * 2.0 * sp * 0.5);
    // rust: p.xrot("right_leg", (pos * 0.6662).mcos() * 1.4 * sp);
    // rust: p.xrot("left_leg", (pos * 0.6662 + PI).mcos() * 1.4 * sp);
    // rust: p.yrot("right_leg", 0.005);
    // rust: p.yrot("left_leg", -0.005);
    // rust: p.zrot("right_leg", 0.005);
    // rust: p.zrot("left_leg", -0.005);
    // rust: if h.passenger {
    // rust: p.get("right_arm")[3] += -PI / 5.0;
    // rust: p.get("left_arm")[3] += -PI / 5.0;
    // rust: p.xrot("right_leg", -1.413_716_7);
    // rust: p.yrot("right_leg", PI / 10.0);
    // rust: p.zrot("right_leg", 0.078_539_82);
    // rust: p.xrot("left_leg", -1.413_716_7);
    // rust: p.yrot("left_leg", -PI / 10.0);
    // rust: p.zrot("left_leg", -0.078_539_82);
}
    // The main arm is the right one: the off-hand pose goes first unless it
    // needs both hands.
    // rust: if h.left.two_handed() {
    // rust: pose_arm(p, h.right, true, h);
    // rust: if !h.right.affects_offhand() {
    // rust: pose_arm(p, h.left, false, h);
}
    // rust: } else {
    // rust: pose_arm(p, h.left, false, h);
    // rust: if !h.left.affects_offhand() {
    // rust: pose_arm(p, h.right, true, h);
}
}
    // setupAttackAnimation: a WHACK or STAB swing of the swinging hand's arm.
    // rust: let hx = p.get("head")[3];
    // rust: let swing = s.swing;
    // rust: let swing_left = h.swing_right_arm.map_or(h.left_main, |right| !right);
    // rust: if swing > 0.0 && h.weapon_swing {
    // rust: swing_weapon_down(p, swing, s.age, h.left_main);
    // rust: } else if swing > 0.0 {
    // rust: let mut body_y = (swing.sqrt() * PI * 2.0).msin() * 0.2;
    // rust: if swing_left {
    // rust: body_y = -body_y;
}
    // rust: p.yrot("body", body_y);
    // rust: let age_scale = if s.baby { 0.5 } else { 1.0 };
    // rust: {
    // rust: let r = p.get("right_arm");
    // rust: r[2] = body_y.msin() * 5.0 * age_scale;
    // rust: r[0] = -body_y.mcos() * 5.0 * age_scale;
}
    // rust: {
    // rust: let l = p.get("left_arm");
    // rust: l[2] = -body_y.msin() * 5.0 * age_scale;
    // rust: l[0] = body_y.mcos() * 5.0 * age_scale;
}
    // rust: let arm = if swing_left { "left_arm" } else { "right_arm" };
    // rust: if h.stab {
            // SpearAnimations.thirdPersonAttackHand: the arms keep their turn.
    // rust: p.get(arm)[3] += crate::spear::third_person_attack_arm(swing);
    // rust: } else {
    // rust: p.get("right_arm")[4] += body_y;
    // rust: p.get("left_arm")[4] += body_y;
    // rust: p.get("left_arm")[3] += body_y;
            // Ease.outQuart
    // rust: let eased = 1.0 - (1.0 - swing).powi(4);
    // rust: let aa = (eased * PI).msin();
    // rust: let bb = (swing * PI).msin() * -(hx - 0.7) * 0.75;
    // rust: let r = p.get(arm);
    // rust: r[3] -= aa * 1.2 + bb;
    // rust: r[4] += body_y * 2.0;
    // rust: r[5] += (swing * PI).msin() * -0.4;
}
}
    // AnimationUtils.animateZombieArms leaves the arms of a spear alone.
    // rust: let using_spear = h.right == ArmPose::Spear || h.left == ArmPose::Spear;
    // rust: if let Some(aggressive) = h.zombie.filter(|_| !using_spear) {
        // AnimationUtils.animateZombieArms
    // rust: let raise = !s.baby || !h.holding;
    // rust: let drop = if raise {
    // rust: -PI / if aggressive { 1.5 } else { 2.25 }
    // rust: } else {
    // rust: 0.0
}
    // rust: let ym = if raise { 1.0 } else { -1.0 } * (swing * PI).msin();
    // rust: let xm = ((1.0 - (1.0 - swing) * (1.0 - swing)) * PI).msin();
    // rust: let x = drop + ym * 1.2 - xm * 0.4;
    // rust: let y = 0.1 - ym * 0.6;
        // An arm raising a trident keeps its pose.
    // rust: if h.right != ArmPose::ThrowTrident {
    // rust: p.xrot("right_arm", x);
    // rust: p.yrot("right_arm", if raise { -y } else { y });
    // rust: p.zrot("right_arm", 0.0);
}
    // rust: if h.left != ArmPose::ThrowTrident {
    // rust: p.xrot("left_arm", x);
    // rust: p.yrot("left_arm", if raise { y } else { -y });
    // rust: p.zrot("left_arm", 0.0);
}
}
    // rust: if h.crouching {
    // rust: p.xrot("body", 0.5);
    // rust: p.get("right_arm")[3] += 0.4;
    // rust: p.get("left_arm")[3] += 0.4;
    // rust: p.get("right_leg")[2] += 4.0;
    // rust: p.get("left_leg")[2] += 4.0;
    // rust: p.get("head")[1] += 4.2;
    // rust: p.get("body")[1] += 3.2;
    // rust: p.get("left_arm")[1] += 3.2;
    // rust: p.get("right_arm")[1] += 3.2;
}
    // rust: bob(p, "right_arm", s.age, 1.0);
    // rust: bob(p, "left_arm", s.age, -1.0);
    // rust: if h.swim > 0.0 {
    // rust: swim(p, s.pos, h);
}
}
// `Mth.rotLerpRad`.
rot_lerp_rad :: proc(a: f32, from: f32, to: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut diff = to - from;
    // rust: while diff < -PI {
    // rust: diff += PI * 2.0;
}
    // rust: while diff >= PI {
    // rust: diff -= PI * 2.0;
}
    // rust: from + a * diff
}
// `DrownedModel.setupSwimAnimation`: the arms reach up and sway, the legs
// kick and the head lies straight.
drowned_swim :: proc(p: ^Poses, s: ^State, amount: f32) {
}
    // rust: if amount <= 0.0 {
    // rust: return;
}
    // rust: let sway = amount * 0.35 * (0.1 * s.age).msin();
    // rust: let kick = amount * 0.55 * (0.1 * s.age).msin();
    // rust: let reach = -PI * 4.0 / 5.0;
    // rust: let (right_x, left_x) = (p.get("right_arm")[3], p.get("left_arm")[3]);
    // rust: let (right_z, left_z) = (p.get("right_arm")[5], p.get("left_arm")[5]);
    // rust: p.xrot("right_arm", rot_lerp_rad(amount, right_x, reach) + sway);
    // rust: p.xrot("left_arm", rot_lerp_rad(amount, left_x, reach) - sway);
    // rust: p.zrot("right_arm", rot_lerp_rad(amount, right_z, -0.15));
    // rust: p.zrot("left_arm", rot_lerp_rad(amount, left_z, 0.15));
    // rust: let (left_leg, right_leg) = (p.get("left_leg")[3], p.get("right_leg")[3]);
    // rust: p.xrot("left_leg", left_leg - kick);
    // rust: p.xrot("right_leg", right_leg + kick);
    // rust: p.xrot("head", 0.0);
}
// `HumanoidModel.setupSwimAnimation`: the stroke of both arms over 26
// walk-animation units, the head down and a slow flutter kick. The left arm
// eases the short way round, the right one linearly, as in vanilla.
swim :: proc(p: ^Poses, pos: f32, h: ^Hum) {
}
    // rust: let amount = h.swim;
    // rust: if !h.fall_flying {
    // rust: let x = p.get("head")[3];
    // rust: p.xrot(
    // rust: "head",
    // rust: rot_lerp_rad(amount, x, -std::f32::consts::FRAC_PI_4),
    // rust: );
}
    // rust: let swim_pos = pos % 26.0;
    // rust: let right_amount = if h.swing_right_arm == Some(true) {
    // rust: 0.0
    // rust: } else {
    // rust: amount
}
    // rust: let left_amount = if h.swing_right_arm == Some(false) {
    // rust: 0.0
    // rust: } else {
    // rust: amount
}
    // rust: let lerp = |a: f32, from: f32, to: f32| from + a * (to - from);
    // rust: let quadratic = |x: f32| -65.0 * x + x * x;
    // rust: if !h.using_item {
        // Targets (x, y, z) for the left and right arm.
    // rust: let targets = if swim_pos < 14.0 {
    // rust: let stroke = 1.870_796_4 * quadratic(swim_pos) / quadratic(14.0);
    // rust: Some(([0.0, PI, PI + stroke], [0.0, PI, PI - stroke]))
    // rust: } else if swim_pos < 22.0 {
    // rust: let t = (swim_pos - 14.0) / 8.0;
    // rust: let x = PI / 2.0 * t;
    // rust: Some((
    // rust: [x, PI, 5.012_389 - 1.870_796_4 * t],
    // rust: [x, PI, 1.270_796_3 + 1.870_796_4 * t],
    // rust: ))
    // rust: } else if swim_pos < 26.0 {
    // rust: let t = (swim_pos - 22.0) / 4.0;
    // rust: let x = PI / 2.0 - PI / 2.0 * t;
    // rust: Some(([x, PI, PI], [x, PI, PI]))
    // rust: } else {
    // rust: None
}
    // rust: if let Some((left, right)) = targets {
    // rust: for (i, target) in left.into_iter().enumerate() {
    // rust: let angle = &mut p.get("left_arm")[3 + i];
    // rust: *angle = rot_lerp_rad(left_amount, *angle, target);
}
    // rust: for (i, target) in right.into_iter().enumerate() {
    // rust: let angle = &mut p.get("right_arm")[3 + i];
    // rust: *angle = lerp(right_amount, *angle, target);
}
}
}
    // rust: let x = p.get("left_leg")[3];
    // rust: p.xrot(
    // rust: "left_leg",
    // rust: lerp(amount, x, 0.3 * (pos * 0.333_333_34 + PI).mcos()),
    // rust: );
    // rust: let x = p.get("right_leg")[3];
    // rust: p.xrot(
    // rust: "right_leg",
    // rust: lerp(amount, x, 0.3 * (pos * 0.333_333_34).mcos()),
    // rust: );
}
// Apply the mob's model animation to `p` (at rest), then the emote it plays, if any.
    // rust: pub fn setup(
    // rust: m: &Mob,
    // rust: s: &State,
    // rust: p: &mut Poses,
    // rust: w_anims: &HashMap<String, super::keyframes::Animation>,
    // rust: ) {
    // rust: let Some(playing) = &m.emote else {
    // rust: return vanilla_setup(m, s, p, w_anims);
}
    // rust: let rest = horizon_cosmetics::BODY.map(|b| p.has(b.part()).then(|| *p.get(b.part())));
    // rust: vanilla_setup(m, s, p, w_anims);
    // rust: emote(playing, s.age, rest, p);
}

// Poses the bones `rest` names (those the model has; at rest) as `playing` has them at `age`.
    // rust: fn emote(
    // rust: playing: &horizon_cosmetics::Playing,
    // rust: age: f32,
    // rust: rest: [Option<[f32; 9]>; 6],
    // rust: p: &mut Poses,
    // rust: ) {
    // rust: let (Some(emote), Some((t, weight))) = (&playing.item.emote, playing.at(age)) else {
    // rust: return;
}
IDENTITY :: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0]
    // rust: let bones = horizon_cosmetics::BODY;
    // rust: let at_rest = rest.map(|r| r.unwrap_or(IDENTITY));
    // rust: let mut poses: [[f32; 9]; 6] =
    // rust: std::array::from_fn(|i| rest[i].map_or(IDENTITY, |_| *p.get(bones[i].part())));
    // rust: emote.pose_body(t, weight, &at_rest, &mut poses);
    // rust: for (i, pose) in poses.into_iter().enumerate() {
    // rust: if rest[i].is_some() {
    // rust: *p.get(bones[i].part()) = pose;
}
}
}

    // rust: fn vanilla_setup(
    // rust: m: &Mob,
    // rust: s: &State,
    // rust: p: &mut Poses,
    // rust: w_anims: &HashMap<String, super::keyframes::Animation>,
    // rust: ) {
    // rust: if super::body_anim::anim(m, s, p, w_anims) {
    // rust: return;
}
    // rust: match m.kind.anim {
    // rust: Anim::Camel => super::camel::anim(m, s, p, w_anims),
    // rust: Anim::Breeze => super::breeze::anim(m, s, p, w_anims),
    // rust: Anim::Sniffer => super::sniffer::anim(m, s, p, w_anims),
    // rust: Anim::CopperGolem => super::copper_golem::anim(m, s, p, w_anims),
    // rust: Anim::HappyGhast => super::happy_ghast::anim(m, s, p),
    // rust: Anim::Nautilus => super::nautilus::anim(m, s, p, w_anims),
        // body_anim::llama runs first.
    // rust: Anim::Llama => quadruped(p, s),
    // rust: Anim::Warden => super::warden::anim(m, s, p, w_anims),
    // rust: Anim::Allay => super::allay::anim(m, s, p),
    // rust: Anim::Creaking => super::creaking::anim(m, s, p, w_anims),
    // rust: Anim::Squid | Anim::Fish | Anim::Pufferfish | Anim::Dolphin => {
    // rust: super::aquatic::anim(m, s, p)
}
    // rust: Anim::Quadruped | Anim::PolarBear | Anim::Panda | Anim::Goat => quadruped(p, s),
    // rust: Anim::Sheep => {
    // rust: quadruped(p, s);
            // SheepModel: lower the head while eating grass.
    // rust: let t = m.extra.anim_ticks;
    // rust: let partial = s.partial;
    // rust: let pos_scale = if t <= 0 {
    // rust: 0.0
    // rust: } else if (4..=36).contains(&t) {
    // rust: 1.0
    // rust: } else if t < 4 {
    // rust: (t as f32 - partial) / 4.0
    // rust: } else {
    // rust: -((t - 40) as f32 - partial) / 4.0
}
    // rust: let angle = if t > 4 && t <= 36 {
    // rust: let f = ((t - 4) as f32 - partial) / 32.0;
    // rust: PI / 5.0 + 0.219_911_49 * (f * 28.7).msin()
    // rust: } else if t > 0 {
    // rust: PI / 5.0
    // rust: } else {
    // rust: s.x_rot.to_radians()
}
    // rust: let age_scale = if s.baby { 0.5 } else { 1.0 };
    // rust: p.get("head")[1] += pos_scale * 9.0 * age_scale;
    // rust: p.xrot("head", angle);
}
    // rust: Anim::Chicken => {
    // rust: let flap = m.anim.flap_o + (m.anim.flap - m.anim.flap_o) * s.partial;
    // rust: let flap_speed =
    // rust: m.anim.flap_speed_o + (m.anim.flap_speed - m.anim.flap_speed_o) * s.partial;
    // rust: let angle = (flap.msin() + 1.0) * flap_speed;
    // rust: p.xrot("right_leg", (s.pos * 0.6662).mcos() * 1.4 * s.speed);
    // rust: p.xrot("left_leg", (s.pos * 0.6662 + PI).mcos() * 1.4 * s.speed);
    // rust: p.zrot("right_wing", angle);
    // rust: p.zrot("left_wing", -angle);
    // rust: if !s.baby {
    // rust: head(p, s);
}
}
    // rust: Anim::Zombie
    // rust: | Anim::Drowned
    // rust: | Anim::ZombieVillager
    // rust: | Anim::ZombifiedPiglin
    // rust: | Anim::Humanoid { zombie_arms: true } => {
            // DrownedRenderer.getArmPose: an aggressive drowned raises the
            // trident in its main arm.
    // rust: let throwing = m.kind.anim == Anim::Drowned
    // rust: && m.ai.aggressive
    // rust: && m.extra.main_hand.as_deref() == Some("minecraft:trident");
            // HumanoidMobRenderer.getArmPose: the arm holding a spear (at rest too).
    // rust: let spear = m
    // rust: .extra
    // rust: .main_hand
    // rust: .as_deref()
    // rust: .and_then(crate::spear::Kinetic::of);
    // rust: let main = if throwing {
    // rust: ArmPose::ThrowTrident
    // rust: } else if spear.is_some() {
    // rust: ArmPose::Spear
    // rust: } else {
    // rust: ArmPose::Empty
}
    // rust: let mut h = if m.main_arm_left() {
    // rust: Hum::new(ArmPose::Empty, main)
    // rust: } else {
    // rust: Hum::new(main, ArmPose::Empty)
}
    // rust: h.left_main = m.main_arm_left();
    // rust: let main_side = usize::from(m.main_arm_left());
    // rust: if main == ArmPose::Spear {
    // rust: h.spear[main_side] = spear;
    // rust: if m.extra.using_item > 0 && !m.extra.using_off_hand {
    // rust: h.spear_ticks[main_side] = m.extra.using_item as f32 + s.partial;
}
}
    // rust: h.zombie = Some(m.ai.aggressive);
    // rust: h.holding = m.extra.main_hand.is_some();
    // rust: h.crouching = m.extra.crouching;
    // rust: h.passenger = m.extra.passenger;
    // rust: humanoid(p, s, &h);
    // rust: if m.kind.anim == Anim::Drowned {
    // rust: drowned_swim(p, s, m.extra.swim.amount(s.partial));
}
    // rust: if m.kind.anim == Anim::ZombifiedPiglin {
    // rust: super::piglin::ears(p, s);
}
}
    // rust: Anim::Skeleton | Anim::Humanoid { zombie_arms: false } => {
    // rust: let bow = m.extra.main_hand.as_deref() == Some("minecraft:bow");
    // rust: let player = matches!(m.kind.anim, Anim::Humanoid { .. });
    // rust: let right = if bow && m.ai.aggressive {
    // rust: ArmPose::Bow
    // rust: } else if player && m.extra.main_hand.is_some() {
    // rust: ArmPose::Item
    // rust: } else {
    // rust: ArmPose::Empty
}
    // rust: let using_main = m.extra.using_item > 0 && !m.extra.using_off_hand;
    // rust: let using_off = m.extra.using_item > 0 && m.extra.using_off_hand;
            // AvatarRenderer.getArmPose: an arm holding a spear (at rest too).
    // rust: let spear_in = |hand: &Option<std::sync::Arc<str>>| {
    // rust: hand.as_deref()
    // rust: .filter(|_| player)
    // rust: .and_then(crate::spear::Kinetic::of)
}
    // rust: let (main_spear, off_spear) =
    // rust: (spear_in(&m.extra.main_hand), spear_in(&m.extra.off_hand));
    // rust: let pose = if player {
    // rust: match m.extra.main_hand.as_deref() {
    // rust: Some(_) if using_main && m.extra.blocking => ArmPose::Block,
    // rust: Some("minecraft:bow") if using_main => ArmPose::Bow,
    // rust: Some("minecraft:trident") if using_main => ArmPose::ThrowTrident,
    // rust: Some("minecraft:spyglass") if using_main => ArmPose::Spyglass,
    // rust: Some("minecraft:goat_horn") if using_main => ArmPose::TootHorn,
    // rust: Some("minecraft:crossbow") if using_main && !m.extra.charged => {
    // rust: ArmPose::CrossbowCharge
}
    // rust: Some("minecraft:crossbow") if m.extra.charged && s.swing == 0.0 => {
    // rust: ArmPose::CrossbowHold
}
    // rust: Some("minecraft:brush") if using_main => ArmPose::Brush,
    // rust: Some(_) if main_spear.is_some() => ArmPose::Spear,
    // rust: Some(_) => ArmPose::Item,
    // rust: None => ArmPose::Empty,
}
    // rust: } else {
    // rust: right
}
    // rust: let off = if player && m.extra.off_hand.is_some() && !pose.affects_offhand() {
    // rust: if off_spear.is_some() {
    // rust: ArmPose::Spear
    // rust: } else if using_off && m.extra.blocking {
    // rust: ArmPose::Block
    // rust: } else if using_off && m.extra.off_hand.as_deref() == Some("minecraft:spyglass") {
    // rust: ArmPose::Spyglass
    // rust: } else if using_off && m.extra.off_hand.as_deref() == Some("minecraft:goat_horn") {
    // rust: ArmPose::TootHorn
    // rust: } else if using_off && m.extra.off_hand.as_deref() == Some("minecraft:brush") {
    // rust: ArmPose::Brush
    // rust: } else {
    // rust: ArmPose::Item
}
    // rust: } else {
    // rust: ArmPose::Empty
}
    // rust: let mut h = if m.main_arm_left() {
    // rust: Hum::new(off, pose)
    // rust: } else {
    // rust: Hum::new(pose, off)
}
    // rust: h.charge = (m.extra.ints[5] as f32, m.extra.using_item as f32);
    // rust: h.fall_flying = m.extra.fall_flying;
    // rust: if h.fall_flying {
    // rust: let v = m.velocity;
    // rust: h.fly_speed_scale =
    // rust: (((v.x * v.x + v.y * v.y + v.z * v.z) as f32 / 0.2).powi(3)).max(1.0);
}
    // rust: h.crouching = m.extra.crouching;
    // rust: h.passenger = m.extra.passenger;
    // rust: h.swim = m.extra.swim.amount(s.partial);
    // rust: h.using_item = m.extra.using_item > 0;
    // rust: h.swing_right_arm = m.extra.swing_right_arm;
    // rust: h.stab = m.extra.swing_stab;
    // rust: h.left_main = m.main_arm_left();
    // rust: let main_side = usize::from(m.main_arm_left());
    // rust: h.spear[main_side] = main_spear;
    // rust: h.spear[1 - main_side] = off_spear;
    // rust: if m.extra.using_item > 0 {
    // rust: let using_side = if m.extra.using_off_hand {
    // rust: 1 - main_side
    // rust: } else {
    // rust: main_side
}
    // rust: h.spear_ticks[using_side] = m.extra.using_item as f32 + s.partial;
}
    // rust: humanoid(p, s, &h);
    // rust: if player {
    // rust: player_model_visibility(p, m.extra.hidden_model_parts, m.extra.spectator);
}
    // rust: if m.ai.aggressive && !bow {
                // SkeletonModel melee pose.
    // rust: let sw = s.swing;
    // rust: let s2 = (sw * PI).msin();
    // rust: let s1 = ((1.0 - (1.0 - sw) * (1.0 - sw)) * PI).msin();
    // rust: p.zrot("right_arm", 0.0);
    // rust: p.zrot("left_arm", 0.0);
    // rust: p.yrot("right_arm", -(0.1 - s2 * 0.6));
    // rust: p.yrot("left_arm", 0.1 - s2 * 0.6);
    // rust: p.xrot("right_arm", -PI / 2.0 - (s2 * 1.2 - s1 * 0.4));
    // rust: p.xrot("left_arm", -PI / 2.0 - (s2 * 1.2 - s1 * 0.4));
    // rust: bob(p, "right_arm", s.age, 1.0);
    // rust: bob(p, "left_arm", s.age, -1.0);
}
            // BoggedModel.setupAnim: the mushrooms on the head come off once sheared.
    // rust: if m.species() == super::Species::Bogged {
    // rust: p.visible("mushrooms", !m.extra.sheared);
}
}
    // rust: Anim::Witch => super::witch::anim(m, s, p),
    // rust: Anim::Villager => super::villager::anim(m, s, p),
    // rust: Anim::Wolf => super::tame::anim(m, s, p),
    // rust: Anim::IronGolem => super::golem::iron_anim(m, s, p),
    // rust: Anim::Illager => super::illager::anim(m, s, p),
    // rust: Anim::Piglin => super::piglin::piglin_anim(m, s, p),
    // rust: Anim::Phantom => super::phantom::anim(m, s, p),
    // rust: Anim::Guardian => super::guardian::anim(m, s, p),
    // rust: Anim::Vex => super::vex::anim(m, s, p),
    // rust: Anim::Wither => super::wither::anim(m, s, p),
    // rust: Anim::Ravager => super::ravager::anim(m, s, p),
    // rust: Anim::Shulker => super::shulker::anim(m, s, p),
    // rust: Anim::Horse => {
    // rust: super::equine::anim(m, s, p);
            // DonkeyModel: the chests show once fitted.
    // rust: if !m.extra.chested {
    // rust: for part in ["left_chest", "right_chest"] {
    // rust: p.visible(part, false);
}
}
            // EquineSaddleModel.setupAnim: the reins show only while ridden
            // (`isRidden` is `Entity.isVehicle`: a player or a mob rides it).
    // rust: for part in ["left_saddle_line", "right_saddle_line"] {
    // rust: p.visible(part, m.rider.is_some() || m.extra.rider.is_some());
}
}
    // rust: Anim::Hoglin => super::piglin::hoglin_anim(m, s, p),
    // rust: Anim::Blaze => super::nether::blaze_anim(s, p),
    // rust: Anim::Ghast => super::nether::ghast_anim(s, p),
    // rust: Anim::Feline => super::tame::cat_anim(m, s, p),
    // rust: Anim::Enderman => super::enderman::anim(m, s, p),
    // rust: Anim::Slime | Anim::MagmaCube => super::cube::anim(m, s, p),
    // rust: Anim::Creeper => {
    // rust: head(p, s);
            // CreeperModel binds its fields to the opposite-side parts, so the
            // left formulas drive the right parts and the reverse.
    // rust: p.xrot("left_hind_leg", (s.pos * 0.6662).mcos() * 1.4 * s.speed);
    // rust: p.xrot(
    // rust: "right_hind_leg",
    // rust: (s.pos * 0.6662 + PI).mcos() * 1.4 * s.speed,
    // rust: );
    // rust: p.xrot(
    // rust: "left_front_leg",
    // rust: (s.pos * 0.6662 + PI).mcos() * 1.4 * s.speed,
    // rust: );
    // rust: p.xrot("right_front_leg", (s.pos * 0.6662).mcos() * 1.4 * s.speed);
}
    // rust: Anim::Spider => {
    // rust: head(p, s);
    // rust: let pos = s.pos * 0.6662;
    // rust: let sp = s.speed;
    // rust: let swing = |o: f32| -((pos * 2.0 + o).mcos() * 0.4) * sp;
    // rust: let step = |o: f32| ((pos + o).msin() * 0.4).abs() * sp;
    // rust: let legs = [
    // rust: ("right_hind_leg", "left_hind_leg", 0.0f32, 0.0f32),
    // rust: ("right_middle_hind_leg", "left_middle_hind_leg", PI, PI),
    // rust: (
    // rust: "right_middle_front_leg",
    // rust: "left_middle_front_leg",
    // rust: PI / 2.0,
    // rust: PI / 2.0,
    // rust: ),
    // rust: (
    // rust: "right_front_leg",
    // rust: "left_front_leg",
    // rust: PI * 3.0 / 2.0,
    // rust: PI * 3.0 / 2.0,
    // rust: ),
    // rust: ];
    // rust: for (right, left, so, to) in legs {
    // rust: let (sw, st) = (swing(so), step(to));
    // rust: p.get(right)[4] += sw;
    // rust: p.get(left)[4] -= sw;
    // rust: p.get(right)[5] += st;
    // rust: p.get(left)[5] -= st;
}
}
    // rust: _ => {
    // rust: if p.has("head") {
    // rust: head(p, s);
}
    // rust: if p.has("right_hind_leg") {
    // rust: quadruped(p, s);
}
}
}
}

// `PlayerModel.setupAnim`'s visibility: a spectator shows only its head (`showBody`), and the
// skin layers the player hid (`PlayerModelPart`, bit set = hidden) are off.
player_model_visibility :: proc(p: ^Poses, hidden: u8, spectator: bool) {
}
    // rust: for part in ["body", "right_arm", "left_arm", "right_leg", "left_leg"] {
    // rust: p.visible(part, !spectator);
}
    // rust: for (bit, part) in [
    // rust: (1, "jacket"),
    // rust: (2, "left_sleeve"),
    // rust: (3, "right_sleeve"),
    // rust: (4, "left_pants"),
    // rust: (5, "right_pants"),
    // rust: (6, "hat"),
    // rust: ] {
    // rust: p.visible(part, hidden & (1 << bit) == 0);
}
}
    // rust: mod emote_tests {
//     use super::*;

an_emote_poses_the_bones_the_model_has_after_its_animation :: proc() {
}
        // The right arm up to 90° about z at tick 10, the body hopping 4 px; the model has no legs.
    // rust: let item = horizon_cosmetics::Item::parse(
    // rust: br#"{"format": 1, "id": "up", "slot": "emote", "parts": [],
    // rust: "emote": {"length": 20, "blend": 0, "tracks": [
    // rust: {"part": "right_arm", "keys": [{"t": 10, "rotation": [0, 0, 90]}]},
    // rust: {"part": "root", "keys": [{"t": 0, "offset": [0, -4, 0]}]}]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let rest = |x: f32, y: f32| [x, y, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0];
    // rust: let mut p = Poses {
    // rust: map: [("head", rest(0.0, 0.0)), ("right_arm", rest(-5.0, 2.0))]
    // rust: .into_iter()
    // rust: .map(|(n, pose)| (key(n), pose))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let at_rest = horizon_cosmetics::BODY.map(|b| p.has(b.part()).then(|| *p.get(b.part())));
        // What the walk animation did: the head looks aside, the arm swings.
    // rust: p.get("head")[4] = 0.4;
    // rust: p.get("right_arm")[3] = 0.7;
    // rust: let playing = horizon_cosmetics::Playing {
    // rust: item: std::sync::Arc::new(item),
    // rust: start: 100.0,
    // rust: stop: None,
}
    // rust: emote(&playing, 110.0, at_rest, &mut p);
    // rust: let arm = *p.get("right_arm");
    // rust: assert!(
    // rust: (arm[5] - std::f32::consts::FRAC_PI_2).abs() < 1e-5 && arm[3].abs() < 1e-5,
    // rust: "{arm:?}"
    // rust: );
    // rust: assert!((arm[0] + 5.0).abs() < 1e-5 && (arm[1] - (2.0 - 4.0)).abs() < 1e-5);
        // The head keeps looking aside, lifted with the body.
    // rust: let head = *p.get("head");
    // rust: assert!((head[4] - 0.4).abs() < 1e-5 && (head[1] + 4.0).abs() < 1e-5);
        // Nothing was added for the bones the model lacks, and past its end the emote is gone.
    // rust: assert_eq!(p.map.len(), 2);
    // rust: let before = *p.get("right_arm");
    // rust: emote(&playing, 125.0, at_rest, &mut p);
    // rust: assert_eq!(*p.get("right_arm"), before);
}
}

    // rust: mod flight_pose_tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

spectators_show_only_the_head_and_its_hat :: proc() {
}
    // rust: let mut p = Poses {
    // rust: map: [
    // rust: "head",
    // rust: "hat",
    // rust: "body",
    // rust: "jacket",
    // rust: "right_arm",
    // rust: "left_arm",
    // rust: "right_leg",
    // rust: "left_leg",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: player_model_visibility(&mut p, 0, true);
    // rust: for part in ["body", "right_arm", "left_arm", "right_leg", "left_leg"] {
    // rust: assert!(p.hidden.contains(&key(part)), "{part}");
}
    // rust: assert!(!p.hidden.contains(&key("head")) && !p.hidden.contains(&key("hat")));
        // Back in another mode they all show, but for the layers the player hid.
    // rust: player_model_visibility(&mut p, 1 << 6, false);
    // rust: assert!(!p.hidden.contains(&key("body")) && !p.hidden.contains(&key("left_leg")));
    // rust: assert!(p.hidden.contains(&key("hat")));
}
blocking_arm_follows_the_head_with_limits_in_both_hands :: proc() {
}
    // rust: for right in [false, true] {
    // rust: for (pitch, yaw, expected_pitch, expected_yaw) in [
    // rust: (0.0, 0.0, -0.742_477_9, 0.0),
    // rust: (2.0, 2.0, -0.306_145_58, FRAC_PI_6),
    // rust: (-2.0, -2.0, -2.138_741_3, -FRAC_PI_6),
    // rust: ] {
    // rust: let mut p = Poses {
    // rust: map: ["head", "right_arm", "left_arm"]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let arm = if right { "right_arm" } else { "left_arm" };
    // rust: p.xrot("head", pitch);
    // rust: p.yrot("head", yaw);
    // rust: p.xrot(arm, 0.4);
    // rust: pose_arm(
    // rust: &mut p,
    // rust: ArmPose::Block,
    // rust: right,
    // rust: &Hum::new(ArmPose::Empty, ArmPose::Empty),
    // rust: );
    // rust: let pose = *p.get(arm);
    // rust: assert!((pose[3] - expected_pitch).abs() < 1e-6);
    // rust: let side = if right { -FRAC_PI_6 } else { FRAC_PI_6 };
    // rust: assert!((pose[4] - (side + expected_yaw)).abs() < 1e-6);
    // rust: assert_eq!(p.get(if right { "left_arm" } else { "right_arm" })[3], 0.0);
}
}
}
    // HumanoidModel.poseRightArm / poseLeftArm's SPYGLASS case: pitch, yaw,
    // crouching, and the arm's pitch.
a_spyglass_raises_the_arm_with_the_head_in_both_hands :: proc() {
}
    // rust: for right in [false, true] {
    // rust: for (pitch, yaw, crouching, expected_pitch) in [
    // rust: (0.0, 0.0, false, -1.919_862_2),
    // rust: (0.5, 0.3, false, -1.419_862_2),
    // rust: (0.0, 0.0, true, -2.181_661_6),
                // Looking up: limited to -2.4.
    // rust: (-1.5, 0.0, false, -2.4),
    // rust: ] {
    // rust: let mut p = Poses {
    // rust: map: ["head", "right_arm", "left_arm"]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let arm = if right { "right_arm" } else { "left_arm" };
    // rust: p.xrot("head", pitch);
    // rust: p.yrot("head", yaw);
    // rust: let mut h = Hum::new(ArmPose::Empty, ArmPose::Empty);
    // rust: h.crouching = crouching;
    // rust: pose_arm(&mut p, ArmPose::Spyglass, right, &h);
    // rust: let pose = *p.get(arm);
    // rust: assert!((pose[3] - expected_pitch).abs() < 1e-6, "{pose:?}");
    // rust: let side = if right { -0.261_799_4 } else { 0.261_799_4 };
    // rust: assert!((pose[4] - (yaw + side)).abs() < 1e-6, "{pose:?}");
    // rust: assert_eq!(p.get(if right { "left_arm" } else { "right_arm" })[3], 0.0);
}
}
}
    // EndermanModel.setupAnim (#4565): humanoid_pub forwards isPassenger so the
    // riding leg y/z survive; only xRot is halved and clamped to ±0.4 after.
a_seated_enderman_keeps_the_riding_leg_twist :: proc() {
}
//         use super::super::enderman;
//         use super::super::{Mob, Species};
//         use horizon_core::geometry::Vec3;
//         use std::sync::Arc;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::Enderman;
    // rust: let mut seated = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: seated.extra.passenger = true;
    // rust: let state = State {
    // rust: pos: 0.0,
    // rust: speed: 0.0,
    // rust: age: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot: 0.0,
    // rust: swing: 0.0,
    // rust: baby: false,
    // rust: partial: 0.0,
}
    // rust: let mut poses = Poses {
    // rust: map: [
    // rust: "head",
    // rust: "hat",
    // rust: "body",
    // rust: "right_arm",
    // rust: "left_arm",
    // rust: "right_leg",
    // rust: "left_leg",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: enderman::anim(&seated, &state, &mut poses);
    // rust: let right = *poses.get("right_leg");
    // rust: let left = *poses.get("left_leg");
    // rust: assert!((right[3] - (-0.4)).abs() < 1e-5, "right xRot {}", right[3]);
    // rust: assert!((left[3] - (-0.4)).abs() < 1e-5, "left xRot {}", left[3]);
    // rust: assert!(
    // rust: (right[4] - PI / 10.0).abs() < 1e-5,
    // rust: "right yRot {}",
    // rust: right[4]
    // rust: );
    // rust: assert!(
    // rust: (left[4] - (-PI / 10.0)).abs() < 1e-5,
    // rust: "left yRot {}",
    // rust: left[4]
    // rust: );
    // rust: assert!(
    // rust: (right[5] - 0.078_539_82).abs() < 1e-5,
    // rust: "right zRot {}",
    // rust: right[5]
    // rust: );
    // rust: assert!(
    // rust: (left[5] - (-0.078_539_82)).abs() < 1e-5,
    // rust: "left zRot {}",
    // rust: left[5]
    // rust: );
}

flight_slows_limbs_and_sets_the_head_pose :: proc() {
}
    // rust: let state = State {
    // rust: pos: 0.0,
    // rust: speed: 1.0,
    // rust: age: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot: 0.0,
    // rust: swing: 0.0,
    // rust: baby: false,
    // rust: partial: 0.0,
}
    // rust: let make = || Poses {
    // rust: map: [
    // rust: "head",
    // rust: "right_arm",
    // rust: "left_arm",
    // rust: "right_leg",
    // rust: "left_leg",
    // rust: "body",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let mut ground = make();
    // rust: let mut flight = make();
    // rust: let mut h = Hum::new(ArmPose::Empty, ArmPose::Empty);
    // rust: humanoid(&mut ground, &state, &h);
    // rust: h.fall_flying = true;
    // rust: h.fly_speed_scale = 8.0;
    // rust: humanoid(&mut flight, &state, &h);
    // rust: assert_eq!(flight.get("head")[3], -std::f32::consts::FRAC_PI_4);
    // rust: assert_eq!(flight.get("right_leg")[3], ground.get("right_leg")[3] / 8.0);
        // THROW_TRIDENT: the arm goes up over the head, and zombie arms leave it there.
    // rust: let mut throw = make();
    // rust: let mut h = Hum::new(ArmPose::ThrowTrident, ArmPose::Item);
    // rust: h.zombie = Some(true);
    // rust: humanoid(&mut throw, &state, &h);
    // rust: let still = (state.pos * 0.6662 + PI).mcos() * 2.0 * 0.5;
    // rust: assert_eq!(throw.get("right_arm")[3], still * 0.5 - PI);
    // rust: assert_eq!(throw.get("right_arm")[4], 0.0);
    // rust: assert_eq!(throw.get("left_arm")[3], -PI / 1.5);
}

swimming_strokes_the_arms_and_kicks :: proc() {
}
    // rust: let state = State {
    // rust: pos: 7.0,
    // rust: speed: 1.0,
    // rust: age: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot: 30.0,
    // rust: swing: 0.0,
    // rust: baby: false,
    // rust: partial: 0.0,
}
    // rust: let make = || Poses {
    // rust: map: ["head", "right_arm", "left_arm", "right_leg", "left_leg"]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let same_angle = |a: f32, b: f32| ((a - b + PI).rem_euclid(PI * 2.0) - PI).abs() < 1e-5;
    // rust: let mut h = Hum::new(ArmPose::Empty, ArmPose::Empty);
    // rust: h.swim = 1.0;
    // rust: let mut p = make();
    // rust: humanoid(&mut p, &state, &h);
        // Mid-stroke: both arms sweep out from overhead by the quadratic.
    // rust: let stroke = 1.870_796_4 * (-65.0 * 7.0 + 49.0) / (-65.0 * 14.0 + 196.0);
    // rust: assert_eq!(p.get("right_arm")[5], PI - stroke);
    // rust: assert!(same_angle(p.get("left_arm")[5], PI + stroke));
    // rust: assert_eq!(p.get("right_arm")[4], PI);
    // rust: assert!(same_angle(p.get("head")[3], -std::f32::consts::FRAC_PI_4));
    // rust: assert!(same_angle(
    // rust: p.get("right_leg")[3],
    // rust: 0.3 * (7.0f32 * 0.333_333_34).mcos()
    // rust: ));
        // Using an item keeps the arms; a swing frees its own arm only.
    // rust: let mut using = make();
    // rust: h.using_item = true;
    // rust: humanoid(&mut using, &state, &h);
    // rust: assert_eq!(using.get("right_arm")[4], 0.0);
    // rust: h.using_item = false;
    // rust: h.swing_right_arm = Some(true);
    // rust: let mut swinging = make();
    // rust: humanoid(
    // rust: &mut swinging,
    // rust: &State {
    // rust: swing: 0.5,
    // rust: ..state
    // rust: },
    // rust: &h,
    // rust: );
    // rust: assert!(swinging.get("right_arm")[4] < 1.0);
    // rust: assert!(same_angle(swinging.get("left_arm")[4], PI));
        // A STAB swing turns that arm's pitch alone, by the spear's curve.
    // rust: let mut stabbing = make();
    // rust: h.swim = 0.0;
    // rust: h.stab = true;
    // rust: let mut still = make();
    // rust: humanoid(
    // rust: &mut still,
    // rust: &state,
    // rust: &Hum::new(ArmPose::Empty, ArmPose::Empty),
    // rust: );
    // rust: let stab = State {
    // rust: swing: 0.2,
    // rust: ..state
}
    // rust: humanoid(&mut stabbing, &stab, &h);
    // rust: let arm_pitch = crate::spear::third_person_attack_arm(0.2);
    // rust: assert!(same_angle(
    // rust: stabbing.get("right_arm")[3],
    // rust: still.get("right_arm")[3] + arm_pitch
    // rust: ));
    // rust: assert_eq!(stabbing.get("left_arm")[3], still.get("left_arm")[3]);
        // Out of the pose nothing changes.
    // rust: let mut dry = make();
    // rust: humanoid(&mut dry, &state, &Hum::new(ArmPose::Empty, ArmPose::Empty));
    // rust: assert_eq!(dry.get("head")[3], 30.0f32.to_radians());
}

walk_position_triples_for_babies :: proc() {
}
        // WalkAnimationState.position(partial) = (position - speed * (1 - partial)) * scale.
    // rust: let mut m = player();
    // rust: m.limb_position = 2.0;
    // rust: m.limb_speed = 0.5;
    // rust: assert!(!m.is_baby());
    // rust: assert_eq!(walk_position(&m, 0.5), 1.75);
    // rust: m.extra.age = -100;
    // rust: assert!(m.is_baby());
    // rust: assert_eq!(walk_position(&m, 0.5), 5.25);
}

    // A player: a humanoid model with a shield in its main hand.
player :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.anim = Anim::Humanoid { zombie_arms: false };
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

a_raised_shield_holds_the_arm_across_the_body :: proc() {
}
        // AvatarRenderer.getArmPose: the used item's use animation decides
        // the arm's pose, and a shield (an item with `blocks_attacks`) uses
        // the BLOCK animation, so the arm is held up across the body
        // (#2289).
    // rust: let state = State {
    // rust: pos: 0.0,
    // rust: speed: 0.0,
    // rust: age: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot: 0.0,
    // rust: swing: 0.0,
    // rust: baby: false,
    // rust: partial: 0.0,
}
    // rust: let mut p = Poses {
    // rust: map: ["head", "right_arm", "left_arm"]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let mut m = player();
    // rust: m.extra.main_hand = Some("minecraft:shield".into());
    // rust: m.extra.using_item = 20;
    // rust: m.extra.blocking = true;
    // rust: setup(&m, &state, &mut p, &HashMap::new());
        // HumanoidModel.setupAnim's BLOCK pose.
    // rust: assert!((p.get("right_arm")[3] + 0.942_477_9).abs() < 1e-6);
    // rust: assert!((p.get("right_arm")[4] + FRAC_PI_6).abs() < 1e-6);
        // An item that does not block attacks leaves the arm holding it.
    // rust: let mut m = player();
    // rust: m.extra.main_hand = Some("minecraft:stick".into());
    // rust: m.extra.using_item = 20;
    // rust: let mut p = Poses {
    // rust: map: ["head", "right_arm", "left_arm"]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: setup(&m, &state, &mut p, &HashMap::new());
    // rust: assert!((p.get("right_arm")[3] + PI / 10.0).abs() < 1e-6);
}

a_brush_being_used_sweeps_the_arm_lower_than_a_plain_item :: proc() {
}
        // AvatarRenderer.getArmPose: a brush being used is the BRUSH pose, and
        // HumanoidModel.poseRightArm drops that arm twice as far as ITEM
        // (#4273: brushing had no third-person arm pose at all).
    // rust: let state = State {
    // rust: pos: 0.0,
    // rust: speed: 0.0,
    // rust: age: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot: 0.0,
    // rust: swing: 0.0,
    // rust: baby: false,
    // rust: partial: 0.0,
}
    // rust: let make = || Poses {
    // rust: map: ["head", "right_arm", "left_arm"]
    // rust: .into_iter()
    // rust: .map(|n| (key(n), [0.0; 9]))
    // rust: .collect(),
    // rust: dummy: [0.0; 9],
    // rust: skipped: Default::default(),
    // rust: hidden: Default::default(),
    // rust: version: 0,
}
    // rust: let mut m = player();
    // rust: m.extra.main_hand = Some("minecraft:brush".into());
    // rust: m.extra.using_item = 20;
    // rust: let mut p = make();
    // rust: setup(&m, &state, &mut p, &HashMap::new());
        // HumanoidModel.setupAnim's BRUSH pose.
    // rust: assert!((p.get("right_arm")[3] + PI / 5.0).abs() < 1e-6);
    // rust: assert_eq!(p.get("right_arm")[4], 0.0);
        // An item with no use animation keeps the ITEM pose: BRUSH cannot leak.
    // rust: let mut m = player();
    // rust: m.extra.main_hand = Some("minecraft:stick".into());
    // rust: m.extra.using_item = 20;
    // rust: let mut p = make();
    // rust: setup(&m, &state, &mut p, &HashMap::new());
    // rust: assert!((p.get("right_arm")[3] + PI / 10.0).abs() < 1e-6);
    // rust: assert_eq!(p.get("right_arm")[4], 0.0);
        // AvatarRenderer.getArmPose builds the pose per hand: brushing with the
        // brush in the off hand is BRUSH on the left arm, and the main hand
        // keeps its ITEM pose (the two must not swap).
    // rust: let mut m = player();
    // rust: m.extra.main_hand = Some("minecraft:stick".into());
    // rust: m.extra.off_hand = Some("minecraft:brush".into());
    // rust: m.extra.using_item = 20;
    // rust: m.extra.using_off_hand = true;
    // rust: let mut p = make();
    // rust: setup(&m, &state, &mut p, &HashMap::new());
    // rust: assert!((p.get("left_arm")[3] + PI / 5.0).abs() < 1e-6);
    // rust: assert_eq!(p.get("left_arm")[4], 0.0);
    // rust: assert!((p.get("right_arm")[3] + PI / 10.0).abs() < 1e-6);
    // rust: assert_eq!(p.get("right_arm")[4], 0.0);
}

    // ModelPart.createPartLookup fills the name map with putIfAbsent, so of two
    // parts sharing a name the first registered keeps it, not the last.
a_name_two_parts_share_belongs_to_the_first :: proc() {
}
    // rust: let child = |xrot: f32| Part {
    // rust: name: "leg".into(),
    // rust: pose: [0.0, 0.0, 0.0, xrot, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
}
    // rust: let root = Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0; 9],
    // rust: polygons: Vec::new(),
    // rust: children: vec![child(0.5), child(-0.5)],
}
    // rust: let mut p = Poses::new(&root);
    // rust: assert_eq!(p.get("leg")[3], 0.5);
}
}
