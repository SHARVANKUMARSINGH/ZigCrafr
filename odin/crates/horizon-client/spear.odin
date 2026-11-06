//! Transpiled from Horizon Rust crate
package horizon_client_spear

import "core:fmt"
import "core:mem"
import "core:math"

// Spears: `KineticWeapon` (what holding the use button does: the speed
// conditions of a stab, `Item.Properties.spear`'s numbers) and
// `SpearAnimations` (how the spear is held in first and third person while
// it charges).
// use crate::first_person::SwingAnimation;
// use glam::{Mat4, Vec3};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3 as Vec3d, trig::Mth},
    // rust: jmath::pow,
}
// use std::f32::consts::PI;

// `KineticWeapon.Condition`.
Condition :: struct {
    max_duration_ticks: i32,
    min_speed: f32,
    min_relative_speed: f32,
}
    // rust: impl Condition {
    // rust: pub fn test(
    // rust: self,
    // rust: ticks_used: i32,
    // rust: attacker_speed: f64,
    // rust: relative_speed: f64,
    // rust: entity_factor: f64,
    // rust: ) -> bool {
    // rust: ticks_used <= self.max_duration_ticks
    // rust: && attacker_speed >= f64::from(self.min_speed) * entity_factor
    // rust: && relative_speed >= f64::from(self.min_relative_speed) * entity_factor
}
}

// `KineticWeapon`: a spear's charge.
Kinetic :: struct {
    contact_cooldown_ticks: i32,
    delay_ticks: i32,
    dismount: Condition,
    knockback: Condition,
    damage: Condition,
    forward_movement: f32,
    damage_multiplier: f32,
    sound: ^'static str,
    hit_sound: ^'static str,
    // The `attack_animation` duration, and the `piercing_weapon` sound of a
    // jab.
    attack_ticks: i32,
    attack_sound: ^'static str,
}

// `AttackRange` of a spear: the reach of its stabs.
Reach :: struct {
    min: f32,
    max: f32,
    min_creative: f32,
    max_creative: f32,
    hitbox_margin: f32,
    mob_factor: f32,
}
    // rust: pub const REACH: Reach = Reach {
    // rust: min: 2.0,
    // rust: max: 4.5,
    // rust: min_creative: 2.0,
    // rust: max_creative: 6.5,
    // rust: hitbox_margin: 0.125,
    // rust: mob_factor: 0.5,
}

    // rust: impl Kinetic {
    // The `kinetic_weapon` of a spear item (`Item.Properties.spear`).
of :: proc(item: string) -> O {
    // Ported from Horizon
    return {}
}
        // (attack duration, damage multiplier, delay, dismount time and
        // speed, knockback time and speed, damage time and speed): seconds
        // and blocks per second.
    // rust: let (attack, multiplier, delay, dismount, knockback, damage) = match item {
    // rust: "minecraft:wooden_spear" => (0.65, 0.7, 0.75, (5.0, 14.0), (10.0, 5.1), (15.0, 4.6)),
    // rust: "minecraft:stone_spear" => (0.75, 0.82, 0.7, (4.5, 13.0), (9.0, 5.1), (13.75, 4.6)),
    // rust: "minecraft:copper_spear" => (0.85, 0.82, 0.65, (4.0, 12.0), (8.25, 5.1), (12.5, 4.6)),
    // rust: "minecraft:iron_spear" => (0.95, 0.95, 0.6, (2.5, 11.0), (6.75, 5.1), (11.25, 4.6)),
    // rust: "minecraft:golden_spear" => (0.95, 0.7, 0.7, (3.5, 13.0), (8.5, 5.1), (13.75, 4.6)),
    // rust: "minecraft:diamond_spear" => (1.05, 1.075, 0.5, (3.0, 10.0), (6.5, 5.1), (10.0, 4.6)),
    // rust: "minecraft:netherite_spear" => (1.15, 1.2, 0.4, (2.5, 9.0), (5.5, 5.1), (8.75, 4.6)),
    // rust: _ => return None,
}
    // rust: let wood = item == "minecraft:wooden_spear";
    // rust: let ticks = |seconds: f32| (seconds * 20.0) as i32;
    // rust: Some(Self {
    // rust: contact_cooldown_ticks: 10,
    // rust: delay_ticks: ticks(delay),
            // `Condition.ofAttackerSpeed`, and `ofRelativeSpeed` for the damage.
    // rust: dismount: Condition {
    // rust: max_duration_ticks: ticks(dismount.0),
    // rust: min_speed: dismount.1,
    // rust: min_relative_speed: 0.0,
    // rust: },
    // rust: knockback: Condition {
    // rust: max_duration_ticks: ticks(knockback.0),
    // rust: min_speed: knockback.1,
    // rust: min_relative_speed: 0.0,
    // rust: },
    // rust: damage: Condition {
    // rust: max_duration_ticks: ticks(damage.0),
    // rust: min_speed: 0.0,
    // rust: min_relative_speed: damage.1,
    // rust: },
    // rust: forward_movement: 0.38,
    // rust: damage_multiplier: multiplier,
    // rust: sound: if wood {
    // rust: "minecraft:item.spear_wood.use"
    // rust: } else {
    // rust: "minecraft:item.spear.use"
    // rust: },
    // rust: hit_sound: if wood {
    // rust: "minecraft:item.spear_wood.hit"
    // rust: } else {
    // rust: "minecraft:item.spear.hit"
    // rust: },
    // rust: attack_ticks: ticks(attack),
    // rust: attack_sound: if wood {
    // rust: "minecraft:item.spear_wood.attack"
    // rust: } else {
    // rust: "minecraft:item.spear.attack"
    // rust: },
    // rust: })
}

    // `KineticWeapon.computeDamageUseDuration`: the delay and the time the
    // damage condition lasts.
damage_use_duration :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.delay_ticks + self.damage.max_duration_ticks
}

    // The spear's `attack_animation`: a STAB (`SwingAnimationType` 2) as long
    // as its attack duration.
attack_animation :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: SwingAnimation {
    // rust: kind: 2,
    // rust: duration: self.attack_ticks,
}
}
}

// `KineticWeapon.HIT_FEEDBACK_TICKS`.
HIT_FEEDBACK_TICKS :: 10

// `Mth.clamp` on floats (a NaN stays one).
clamp :: proc(v: f32, lo: f32, hi: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v < lo { lo } else { v.min(hi) }
}
// `SpearAnimations.progress`.
progress :: proc(time: f32, start: f32, end: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: clamp((time - start) / (end - start), 0.0, 1.0)
}
square :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: x * x
}
cube :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: x * x * x
}
p :: proc(x: f32, y: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: pow(f64::from(x), y)
}

// `net.minecraft.util.Ease`.
in_quad :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: x * x
}
out_quart :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 1.0 - square(square(1.0 - x))
}
out_cubic :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 1.0 - cube(1.0 - x)
}
out_back :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 1.0 + 2.70158 * cube(x - 1.0) + 1.70158 * square(x - 1.0)
}
in_out_sine :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: -((PI * x).mcos() - 1.0) / 2.0
}
in_out_expo :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if x < 0.5 {
    // rust: if x == 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: (p(2.0, f64::from(20.0 * x - 10.0)) / 2.0) as f32
}
    // rust: } else if x == 1.0 {
    // rust: 1.0
    // rust: } else {
    // rust: ((2.0 - p(2.0, f64::from(-20.0 * x + 10.0))) / 2.0) as f32
}
}
in_out_back :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if x < 0.5 {
    // rust: return 4.0 * x * x * (7.189_819 * x - 2.594_909_4) / 2.0;
}
    // rust: let dt = 2.0 * x - 2.0;
    // rust: (dt * dt * (3.594_909_4 * dt + 2.594_909_4) + 2.0) / 2.0
}
in_out_elastic :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if x == 0.0 {
    // rust: return 0.0;
}
    // rust: if x == 1.0 {
    // rust: return 1.0;
}
    // rust: let sin = (f64::from(20.0 * x - 11.125) * f64::from(PI * 4.0 / 9.0)).sin();
    // rust: if x < 0.5 {
    // rust: (-(p(2.0, f64::from(20.0 * x - 10.0)) * sin) / 2.0) as f32
    // rust: } else {
    // rust: (p(2.0, f64::from(-20.0 * x + 10.0)) * sin / 2.0 + 1.0) as f32
}
}
out_circ :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(1.0 - square(x - 1.0)).sqrt() as f32
}
in_circ :: proc(x: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (-f64::from(1.0 - x * x).sqrt()) as f32 + 1.0
}

// `SpearAnimations.UseParams`.
UseParams :: struct {
    raise: f32,
    raise_start: f32,
    raise_middle: f32,
    raise_end: f32,
    sway: f32,
    lower: f32,
    raise_back: f32,
    sway_intensity: f32,
    sway_slow: f32,
    sway_fast: f32,
}
    // rust: impl UseParams {
of :: proc(k: ^Kinetic, time: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let finish_raising = k.delay_ticks;
    // rust: let finish_swaying = k.dismount.max_duration_ticks + finish_raising;
    // rust: let start_swaying = finish_swaying - 20;
    // rust: let finish_lowering = k.knockback.max_duration_ticks + finish_raising;
    // rust: let start_lowering = finish_lowering - 40;
    // rust: let finish_raising_back = k.damage.max_duration_ticks + finish_raising;
    // rust: let raise = progress(time, 0.0, finish_raising as f32);
    // rust: let sway = progress(time, start_swaying as f32, finish_swaying as f32);
    // rust: let lower = out_cubic(in_out_elastic(progress(
    // rust: time - 20.0,
    // rust: start_lowering as f32,
    // rust: finish_lowering as f32,
    // rust: )));
    // rust: let raise_back = progress(
    // rust: time,
    // rust: (finish_raising_back - 5) as f32,
    // rust: finish_raising_back as f32,
    // rust: );
    // rust: let sway_intensity = 2.0 * out_circ(sway) - 2.0 * in_circ(raise_back);
    // rust: let degrees = PI / 180.0;
    // rust: Self {
    // rust: raise,
    // rust: raise_start: progress(raise, 0.0, 0.5),
    // rust: raise_middle: progress(raise, 0.5, 0.8),
    // rust: raise_end: progress(raise, 0.8, 1.0),
    // rust: sway,
    // rust: lower,
    // rust: raise_back,
    // rust: sway_intensity,
    // rust: sway_slow: (time * 19.0 * degrees).msin() * sway_intensity,
    // rust: sway_fast: (time * 30.0 * degrees).msin() * sway_intensity,
}
}
}

// `SpearAnimations.hitFeedbackAmount`.
hit_feedback :: proc(ticks_since: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.4 * (out_quart(progress(ticks_since, 1.0, 3.0))
    // rust: - in_out_sine(progress(ticks_since, 3.0, 10.0)))
}

// `PoseStack.rotateAround`.
rotate_around :: proc(rotation: Mat4, about: Vec3) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mat4::from_translation(about) * rotation * Mat4::from_translation(-about)
}

// `SpearAnimations.firstPersonUse`, after the hand's own
// `translate(invert * 0.56, -0.52, -0.72)`.
first_person_use :: proc(k: ^Kinetic, ticks_since_hit: f32, time_held: f32, right: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let u = UseParams::of(k, time_held);
    // rust: let invert = if right { 1.0 } else { -1.0 };
    // rust: let degrees = |d: f32| d.to_radians();
    // rust: let mut m = Mat4::from_translation(Vec3::new(
    // rust: invert * (u.raise * 0.15 + u.raise_end * -0.05 + u.sway * -0.1 + u.sway_slow * 0.005),
    // rust: u.raise * -0.075 + u.raise_middle * 0.075 + u.sway_fast * 0.01,
    // rust: u.raise_start * 0.05 + u.raise_end * -0.05 + u.sway_slow * 0.005,
    // rust: ));
    // rust: m *= rotate_around(
    // rust: Mat4::from_rotation_x(degrees(
    // rust: -65.0 * in_out_back(u.raise) - 35.0 * u.lower
    // rust: + 100.0 * u.raise_back
    // rust: + -0.5 * u.sway_fast,
    // rust: )),
    // rust: Vec3::new(0.0, 0.1, 0.0),
    // rust: );
    // Axis.YN: a turn the other way round.
    // rust: m *= rotate_around(
    // rust: Mat4::from_rotation_y(-degrees(
    // rust: invert * (-90.0 * progress(u.raise, 0.5, 0.55) + 90.0 * u.sway + 2.0 * u.sway_slow),
    // rust: )),
    // rust: Vec3::new(invert * 0.15, 0.0, 0.0),
    // rust: );
    // rust: m * Mat4::from_translation(Vec3::new(0.0, -hit_feedback(ticks_since_hit), 0.0))
}

// `SpearAnimations.thirdPersonHandUse`: the angles (x, y and the z added to
// the arm's own) of the arm holding a spear. `ticks_using` is the time the
// item has been in use by this arm (0 when it is not).
    // rust: pub fn third_person_arm(
    // rust: k: &Kinetic,
    // rust: ticks_using: f32,
    // rust: right: bool,
    // rust: head: (f32, f32),
    // rust: gliding_or_swimming: bool,
    // rust: ) -> (f32, f32, f32) {
    // rust: let invert = if right { 1.0 } else { -1.0 };
    // rust: let degrees = PI / 180.0;
    // rust: let mut y = -0.1 * invert + head.1;
    // rust: let mut x = -PI / 2.0 + head.0 + 0.8;
    // rust: if gliding_or_swimming {
    // rust: x -= 0.959_931_1;
}
    // rust: y = degrees * clamp(180.0 / PI * y, -60.0, 60.0);
    // rust: x = degrees * clamp(180.0 / PI * x, -120.0, 30.0);
    // rust: let mut z = 0.0;
    // rust: if ticks_using > 0.0 {
    // rust: let u = UseParams::of(k, ticks_using);
    // rust: y += -invert * u.sway_fast * degrees * u.sway_intensity;
    // rust: z = -invert * u.sway_slow * degrees * u.sway_intensity * 0.5;
    // rust: x += degrees
    // rust: * (-40.0 * u.raise_start
    // rust: + 30.0 * u.raise_middle
    // rust: + -20.0 * u.raise_end
    // rust: + 20.0 * u.lower
    // rust: + 10.0 * u.raise_back
    // rust: + 0.6 * u.sway_slow * u.sway_intensity);
}
    // rust: (x, y, z)
}

// `SpearAnimations.thirdPersonUseItem`: the spear's own pose in the hand
// held for `time_held` ticks, `swing` into the current swing.
    // rust: pub fn third_person_use_item(
    // rust: k: &Kinetic,
    // rust: time_held: f32,
    // rust: swing: f32,
    // rust: ticks_since_hit: f32,
    // rust: right: bool,
    // rust: ) -> Mat4 {
    // rust: if time_held == 0.0 {
    // rust: return Mat4::IDENTITY;
}
    // rust: let attack = in_quad(progress(swing, 0.05, 0.2));
    // rust: let retract = in_out_expo(progress(swing, 0.4, 1.0));
    // rust: let u = UseParams::of(k, time_held);
    // rust: let invert = if right { 1.0 } else { -1.0 };
    // rust: let raise_modified = 1.0 - out_back(1.0 - u.raise);
    // rust: let hit = hit_feedback(ticks_since_hit);
    // rust: let degrees = |d: f32| d.to_radians();
    // rust: Mat4::from_translation(Vec3::new(
    // rust: 0.0,
    // rust: -hit * 0.4,
    // rust: -k.forward_movement * (raise_modified - u.raise_back) + hit,
    // rust: )) * rotate_around(
    // rust: Mat4::from_rotation_x(-degrees(
    // rust: 70.0 * (u.raise - u.raise_back) - 40.0 * (attack - retract),
    // rust: )),
    // rust: Vec3::new(0.0, -0.031_25, 0.125),
    // rust: ) * rotate_around(
    // rust: Mat4::from_rotation_y(degrees(
    // rust: invert * 90.0 * (u.raise - u.sway + 3.0 * retract + attack),
    // rust: )),
    // rust: Vec3::new(0.0, 0.0, 0.125),
    // rust: )
}

// `SpearAnimations.firstPersonAttack`, after `applyItemArmTransform`: the
// jab (a STAB swing), `attack` into the swing.
first_person_attack :: proc(attack: f32, right: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let invert = if right { 1.0 } else { -1.0 };
    // rust: let start = in_out_sine(progress(attack, 0.0, 0.05));
    // rust: let middle = out_back(progress(attack, 0.05, 0.2));
    // rust: let end = in_out_expo(progress(attack, 0.4, 1.0));
    // rust: Mat4::from_translation(Vec3::new(
    // rust: invert * 0.1 * (start - middle),
    // rust: -0.075 * (start - end),
    // rust: 0.65 * (start - middle),
    // rust: )) * Mat4::from_rotation_x((-70.0 * (start - end)).to_radians())
    // rust: * Mat4::from_translation(Vec3::new(0.0, 0.0, -0.25 * (end - middle)))
}

// `SpearAnimations.thirdPersonAttackHand`: what a STAB swing adds to the
// swinging arm's `xRot`, `swing` into the swing.
third_person_attack_arm :: proc(swing: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let prepare = in_out_sine(progress(swing, 0.0, 0.05));
    // rust: let attack = in_quad(progress(swing, 0.05, 0.2));
    // rust: let retract = in_out_expo(progress(swing, 0.4, 1.0));
    // rust: (90.0 * prepare - 120.0 * attack + 30.0 * retract).to_radians()
}

// `SpearAnimations.thirdPersonAttackItem`: the item in the swinging hand
// thrust out by a STAB swing, `forward` the main hand's `forward_movement`
// (0 without a kinetic weapon there).
third_person_attack_item :: proc(swing: f32, forward: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: if swing <= 0.0 {
    // rust: return Mat4::IDENTITY;
}
    // rust: let attack = in_quad(progress(swing, 0.05, 0.2));
    // rust: let retract = in_out_expo(progress(swing, 0.4, 1.0));
    // rust: rotate_around(
    // rust: Mat4::from_rotation_x((-70.0 * (attack - retract)).to_radians()),
    // rust: Vec3::new(0.0, -0.125, 0.125),
    // rust: ) * Mat4::from_translation(Vec3::new(0.0, forward * (attack - retract), 0.0))
}

// `ProjectileUtil.getManyEntityHitResult` over `boxes`: those the segment
// `from`..`to` meets, or comes within the margin of with no block between
// (`clip`: where a segment first meets a block), each with where it is hit.
    // rust: fn hits_along(
    // rust: boxes: &[(usize, Aabb)],
    // rust: from: Vec3d,
    // rust: to: Vec3d,
    // rust: margin: f64,
    // rust: clip: &impl Fn(Vec3d, Vec3d) -> Option<Vec3d>,
    // rust: ) -> Vec<(usize, Vec3d)> {
    // rust: let grow = Vec3d::new(margin, margin, margin);
    // rust: let mut hits = Vec::new();
    // rust: for &(i, bounds) in boxes {
    // rust: let hit = if bounds.contains(from) {
    // rust: Some(from)
    // rust: } else if let Some(at) = bounds.clip(from, to) {
    // rust: Some(at)
    // rust: } else if margin > 0.0 {
    // rust: bounds.inflate(grow).clip(from, to).and_then(|outside| {
    // rust: let centre = bounds.center();
    // rust: let toward = clip(outside, centre).unwrap_or(centre);
    // rust: bounds.clip(outside, toward)
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: if let Some(at) = hit {
    // rust: hits.push((i, at));
}
}
    // rust: hits
}

// `ProjectileUtil.getHitEntitiesAlong` with an `AttackRange` of `reach` (its
// effective min and max range and hitbox margin): the boxes along `look`
// from the minimum reach to the maximum plus the attacker's own movement,
// none when a block (`clip`) is closer than the minimum.
    // rust: pub fn hits_in_reach(
    // rust: boxes: &[(usize, Aabb)],
    // rust: eye: Vec3d,
    // rust: look: Vec3d,
    // rust: movement: Vec3d,
    // rust: (min, max, margin): (f32, f32, f32),
    // rust: clip: impl Fn(Vec3d, Vec3d) -> Option<Vec3d>,
    // rust: ) -> Vec<(usize, Vec3d)> {
    // rust: let from = eye.add_vector(look.scale(f64::from(min)));
    // rust: let mut to = eye.add_vector(look.scale(f64::from(max) + movement.dot(look).max(0.0)));
    // A block closer than the minimum reach takes the whole stab.
    // rust: if let Some(block) = clip(eye, to) {
    // rust: to = block;
    // rust: if eye.distance_squared(to) < eye.distance_squared(from) {
    // rust: return Vec::new();
}
}
    // rust: hits_along(boxes, from, to, f64::from(margin), &clip)
}

    // rust: mod tests {
//     use super::*;

the_jab_starts_and_ends_at_rest :: proc() {
}
    // rust: assert_eq!(first_person_attack(0.0, true), Mat4::IDENTITY);
    // rust: assert!(first_person_attack(1.0, true).abs_diff_eq(Mat4::IDENTITY, 1e-5));
        // Thrust out and turned mid-jab, mirrored in the left hand.
    // rust: let right = first_person_attack(0.2, true);
    // rust: assert!(!right.abs_diff_eq(Mat4::IDENTITY, 1e-3));
    // rust: let left = first_person_attack(0.2, false);
    // rust: assert!((left.w_axis.x + right.w_axis.x).abs() < 1e-6);
    // rust: assert_eq!(third_person_attack_item(0.0, 0.38), Mat4::IDENTITY);
    // rust: assert!(third_person_attack_item(1.0, 0.38).abs_diff_eq(Mat4::IDENTITY, 1e-5));
        // The arm draws back, thrusts forward, then returns.
    // rust: assert_eq!(third_person_attack_arm(0.0), 0.0);
    // rust: assert!((third_person_attack_arm(0.05) - 90f32.to_radians()).abs() < 1e-5);
    // rust: assert!(third_person_attack_arm(0.2) < 0.0);
    // rust: assert!(third_person_attack_arm(1.0).abs() < 1e-5);
}
}
