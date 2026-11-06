//! Transpiled from Horizon Rust crate
package horizon_client_first_person

import "core:fmt"
import "core:mem"
import "core:math"

// The local player's hand: the arm swing (`LivingEntity.SwingState`,
// `getModifiedSwingDuration`), the first-person equip heights
// (`FirstPersonHandsAndItems.tick` and `itemUsed`), and the click handling
// that starts swings: `Minecraft.startAttack`, `continueAttack`,
// `startUseItem` and `handleKeybinds`' attack and use part, with
// `MultiPlayerGameMode`'s block breaking (`startDestroyBlock`,
// `continueDestroyBlock`, `stopDestroyBlock`).
//
// What those read and do in the world is behind [`HandWorld`].

// The ranged item state read by the first-person hand renderer.
ItemPose :: enum {
    Swing,
    // A STAB swing (`SwingAnimationType` 2): a spear's jab.
    Stab,
    Using,
    Eat {,
    remaining: f32,
    duration: f32,
    partial: f32,
    // rust: },
    Trident {,
    ticks_used: f32,
    // rust: },
    // Riptide's spin (`isAutoSpinAttack`): the item held up like a fork.
    SpinAttack,
    Bow {,
    ticks_used: f32,
    // rust: },
    // A brush in use (`ItemUseAnimation.BRUSH`): the ticks left of the use
    // and the partial tick.
    Brush {,
    remaining: f32,
    partial: f32,
    // rust: },
    // A spear being charged (`ItemUseAnimation.SPEAR`): the time held and
    // the ticks since its last hit's feedback.
    Spear {,
    kinetic: crate::spear::Kinetic,
    time_held: f32,
    ticks_since_hit: f32,
    // rust: },
    Crossbow {,
    ticks_used: Option<f32>,
    charge_duration: f32,
    charged: bool,
    // rust: },
}

// `submitArmWithItem`: the pose of an item in the hand on the `left` or
// right arm, before the model transform. Only the main hand's charged
// crossbow is turned aside.
item_pose :: proc(left: bool, inverse_height: f32, attack: f32, pose: ItemPose) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
//     use horizon_core::geometry::trig::Mth;
    // rust: let invert = if left { -1.0 } else { 1.0 };
    // rust: let pi = std::f32::consts::PI;
    // rust: let mut m = Mat4::from_translation(Vec3::new(
    // rust: invert * 0.56,
    // rust: -0.52 - inverse_height * 0.6,
    // rust: -0.72,
    // rust: ));
    // rust: if let ItemPose::Eat {
    // rust: remaining,
    // rust: duration,
    // rust: partial,
    // rust: } = pose
    // rust: {
    // rust: let time = remaining - partial + 1.0;
    // rust: let fraction = time / duration;
    // rust: let mut eat = Mat4::IDENTITY;
    // rust: if fraction < 0.8 {
    // rust: eat *=
    // rust: Mat4::from_translation(Vec3::new(0.0, ((time / 4.0 * pi).mcos() * 0.1).abs(), 0.0));
}
    // rust: let jiggle = 1.0 - horizon_core::jmath::pow(f64::from(fraction), 27.0) as f32;
    // rust: eat *= Mat4::from_translation(Vec3::new(jiggle * 0.6 * invert, jiggle * -0.5, 0.0));
    // rust: eat *= Mat4::from_rotation_y((invert * jiggle * 90.0).to_radians());
    // rust: eat *= Mat4::from_rotation_x((jiggle * 10.0).to_radians());
    // rust: eat *= Mat4::from_rotation_z((invert * jiggle * 30.0).to_radians());
    // rust: return eat * m;
}
    // rust: if matches!(pose, ItemPose::Using) {
    // rust: return m;
}
    // rust: if let ItemPose::Brush { remaining, partial } = pose {
    // rust: return m * brush_transform(left, remaining, partial);
}
    // The spear's own place in the hand, without the equip height.
    // rust: if let ItemPose::Spear {
    // rust: kinetic,
    // rust: time_held,
    // rust: ticks_since_hit,
    // rust: } = pose
    // rust: {
    // rust: return Mat4::from_translation(Vec3::new(invert * 0.56, -0.52, -0.72))
    // rust: * crate::spear::first_person_use(&kinetic, ticks_since_hit, time_held, !left);
}
    // rust: if matches!(pose, ItemPose::Stab) {
    // rust: return m * crate::spear::first_person_attack(attack, !left);
}
    // rust: if matches!(pose, ItemPose::SpinAttack) {
    // rust: return m
    // rust: * Mat4::from_translation(Vec3::new(invert * -0.4, 0.8, 0.3))
    // rust: * Mat4::from_rotation_y((invert * 65.0f32).to_radians())
    // rust: * Mat4::from_rotation_z((invert * -85.0f32).to_radians());
}
    // rust: let charging = match pose {
    // rust: ItemPose::Bow { ticks_used } => {
    // rust: let power = ticks_used / 20.0;
    // rust: Some((
    // rust: ticks_used,
    // rust: ((power * power + power * 2.0) / 3.0).min(1.0),
    // rust: false,
    // rust: ))
}
    // rust: ItemPose::Crossbow {
    // rust: ticks_used: Some(ticks),
    // rust: charge_duration,
    // rust: charged: false,
    // rust: } => Some((ticks, (ticks / charge_duration).min(1.0), true)),
    // rust: ItemPose::Trident { ticks_used } => Some((ticks_used, (ticks_used / 10.0).min(1.0), false)),
    // rust: _ => None,
}
    // rust: if let Some((ticks, power, crossbow)) = charging {
    // rust: let trident = matches!(pose, ItemPose::Trident { .. });
    // rust: let (x, y, z, pitch, yaw) = if trident {
    // rust: (-0.5, 0.7, 0.1, -55.0f32, 35.3f32)
    // rust: } else if crossbow {
    // rust: (-0.4785682, -0.094387, 0.05731531, -11.935f32, 65.3f32)
    // rust: } else {
    // rust: (-0.2785682, 0.18344387, 0.15731531, -13.935f32, 35.3f32)
}
    // rust: m *= Mat4::from_translation(Vec3::new(invert * x, y, z));
    // rust: m *= Mat4::from_rotation_x(pitch.to_radians());
    // rust: m *= Mat4::from_rotation_y((invert * yaw).to_radians());
    // rust: m *= Mat4::from_rotation_z((invert * -9.785f32).to_radians());
    // rust: if power > 0.1 {
    // rust: let shake = ((ticks - 0.1) * 1.3).msin() * (power - 0.1);
    // rust: m *= Mat4::from_translation(Vec3::new(0.0, shake * 0.004, 0.0));
}
    // rust: m *= Mat4::from_translation(Vec3::new(
    // rust: 0.0,
    // rust: 0.0,
    // rust: power * if trident { 0.2 } else { 0.04 },
    // rust: ));
    // rust: m *= Mat4::from_scale(Vec3::new(1.0, 1.0, 1.0 + power * 0.2));
    // rust: m *= Mat4::from_rotation_y((invert * -45.0f32).to_radians());
    // rust: } else {
    // rust: let root = attack.sqrt();
    // rust: m *= Mat4::from_translation(Vec3::new(
    // rust: invert * -0.4 * (root * pi).msin(),
    // rust: 0.2 * (root * std::f32::consts::TAU).msin(),
    // rust: -0.2 * (attack * pi).msin(),
    // rust: ));
    // rust: m *= Mat4::from_rotation_y(
    // rust: (invert * (45.0 - (attack * attack * pi).msin() * 20.0)).to_radians(),
    // rust: );
    // rust: m *= Mat4::from_rotation_z((invert * (root * pi).msin() * -20.0).to_radians());
    // rust: m *= Mat4::from_rotation_x(((root * pi).msin() * -80.0).to_radians());
    // rust: m *= Mat4::from_rotation_y((invert * -45.0f32).to_radians());
    // rust: if matches!(pose, ItemPose::Crossbow { charged: true, .. }) && attack < 0.001 {
    // rust: m *= Mat4::from_translation(Vec3::new(invert * -0.641864, 0.0, 0.0));
    // rust: m *= Mat4::from_rotation_y((invert * 10.0f32).to_radians());
}
}
    // rust: m
}

// Combat feel Legacy's first-person item (`docs/pvp.md`): Minecraft 1.8.9's
// `ItemRenderer.renderItemInFirstPerson` for a flat item, drawn through 26.3's
// model. 1.8.9 posed the item (`transformFirstPersonItem`: the arm's place,
// 45° about Y, the swing's turns, a 0.4 scale), then applied its own
// `firstperson` display (`[0, -135, 25]`, `[0, 4, 2]`, `1.7`, rotated Y, X,
// Z) and `RenderItem`'s 0.5 scale. 26.3 applies `firstperson_righthand`
// (`[0, -90, 25]`, `[1.13, 3.2, 1.13]`, `0.68`) itself after this pose, so
// the pose ends with its inverse ([`MODERN_FLAT_DISPLAY`]). `block` is a
// sword held up while use is held: 1.8.9's `doBlockTransformations`, with
// the swing's turns kept as 1.7.10 kept them (hitting while blocking swings
// the sword). None for the poses 1.8.9 had no form of (crossbow, trident,
// spear, brush), which stay modern.
    // rust: pub fn legacy_item_pose(
    // rust: left: bool,
    // rust: inverse_height: f32,
    // rust: attack: f32,
    // rust: pose: ItemPose,
    // rust: block: bool,
    // rust: ) -> Option<glam::Mat4> {
//     use glam::{Mat4, Vec3};
    // rust: let deg = |d: f32| d.to_radians();
    // rust: let pi = std::f32::consts::PI;
    // rust: let sin = |v: f32| v.sin();
    // transformFirstPersonItem(equipProgress, swingProgress).
    // rust: let first_person = |swing: f32| {
    // rust: let f = sin(swing * swing * pi);
    // rust: let f1 = sin(swing.sqrt() * pi);
    // rust: Mat4::from_translation(Vec3::new(0.56, -0.52 - inverse_height * 0.6, -0.72))
    // rust: * Mat4::from_rotation_y(deg(45.0))
    // rust: * Mat4::from_rotation_y(deg(f * -20.0))
    // rust: * Mat4::from_rotation_z(deg(f1 * -20.0))
    // rust: * Mat4::from_rotation_x(deg(f1 * -80.0))
    // rust: * Mat4::from_scale(Vec3::splat(0.4))
}
    // rust: let m = match pose {
    // rust: _ if block => {
            // doBlockTransformations.
    // rust: first_person(attack)
    // rust: * Mat4::from_translation(Vec3::new(-0.5, 0.2, 0.0))
    // rust: * Mat4::from_rotation_y(deg(30.0))
    // rust: * Mat4::from_rotation_x(deg(-80.0))
    // rust: * Mat4::from_rotation_y(deg(60.0))
}
    // rust: ItemPose::Swing => {
            // doItemUsedTransformations, then transformFirstPersonItem.
    // rust: let root = attack.sqrt();
    // rust: Mat4::from_translation(Vec3::new(
    // rust: -0.4 * sin(root * pi),
    // rust: 0.2 * sin(root * pi * 2.0),
    // rust: -0.2 * sin(attack * pi),
    // rust: )) * first_person(attack)
}
    // rust: ItemPose::Using => first_person(0.0),
    // rust: ItemPose::Eat {
    // rust: remaining,
    // rust: duration,
    // rust: partial,
    // rust: } => {
            // performDrinking.
    // rust: let time = remaining - partial + 1.0;
    // rust: let fraction = time / duration;
    // rust: let bob = if fraction >= 0.8 {
    // rust: 0.0
    // rust: } else {
    // rust: ((time / 4.0 * pi).cos() * 0.1).abs()
}
    // rust: let j = 1.0 - horizon_core::jmath::pow(f64::from(fraction), 27.0) as f32;
    // rust: Mat4::from_translation(Vec3::new(0.0, bob, 0.0))
    // rust: * Mat4::from_translation(Vec3::new(j * 0.6, j * -0.5, 0.0))
    // rust: * Mat4::from_rotation_y(deg(j * 90.0))
    // rust: * Mat4::from_rotation_x(deg(j * 10.0))
    // rust: * Mat4::from_rotation_z(deg(j * 30.0))
    // rust: * first_person(0.0)
}
    // rust: ItemPose::Bow { ticks_used } => {
            // doBowTransformations.
    // rust: let power = (ticks_used / 20.0 * (ticks_used / 20.0) + ticks_used / 20.0 * 2.0) / 3.0;
    // rust: let power = power.min(1.0);
    // rust: let mut m = first_person(0.0)
    // rust: * Mat4::from_rotation_z(deg(-18.0))
    // rust: * Mat4::from_rotation_y(deg(-12.0))
    // rust: * Mat4::from_rotation_x(deg(-8.0))
    // rust: * Mat4::from_translation(Vec3::new(-0.9, 0.2, 0.0));
    // rust: if power > 0.1 {
    // rust: let shake = sin((ticks_used - 0.1) * 1.3) * (power - 0.1);
    // rust: m *= Mat4::from_translation(Vec3::new(0.0, shake * 0.01, 0.0));
}
    // rust: m * Mat4::from_translation(Vec3::new(0.0, 0.0, power * 0.1))
    // rust: * Mat4::from_scale(Vec3::new(1.0, 1.0, 1.0 + power * 0.2))
}
    // rust: _ => return None,
}
    // 1.8.9's `firstperson` display and RenderItem's 0.5, then 26.3's display undone.
    // rust: let legacy_display = Mat4::from_translation(Vec3::new(0.0, 4.0, 2.0) / 16.0)
    // rust: * Mat4::from_rotation_y(deg(-135.0))
    // rust: * Mat4::from_rotation_z(deg(25.0))
    // rust: * Mat4::from_scale(Vec3::splat(1.7))
    // rust: * Mat4::from_scale(Vec3::splat(0.5));
    // rust: let right = m * legacy_display * modern_flat_display(false).inverse();
    // 1.8.9 had only a right main arm: the left arm mirrors it.
    // rust: let mirror = Mat4::from_scale(Vec3::new(-1.0, 1.0, 1.0));
    // rust: Some(if left { mirror * right * mirror } else { right })
}
// 26.3's `firstperson_righthand` display of a flat item (`item/generated` and
// `item/handheld`), on the `left` hand mirrored as `ItemTransform.apply` does,
// without the model's centring translation.
modern_flat_display :: proc(left: bool) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
    // rust: let s = if left { -1.0 } else { 1.0 };
    // rust: Mat4::from_translation(Vec3::new(s * 1.13, 3.2, 1.13) / 16.0)
    // rust: * Mat4::from_rotation_y((s * -90.0f32).to_radians())
    // rust: * Mat4::from_rotation_z((s * 25.0f32).to_radians())
    // rust: * Mat4::from_scale(Vec3::splat(0.68))
}
// Whether a model layer's matrix is 26.3's flat-item first-person display (a resource
// pack's own display keeps the modern pose).
is_modern_flat_display :: proc(matrix: ^glam::Mat4, left: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let expected =
    // rust: modern_flat_display(left) * glam::Mat4::from_translation(glam::Vec3::splat(-0.5));
    // rust: matrix.abs_diff_eq(expected, 1e-4)
}

// How `submitArmWithItem` holds a stack with a `minecraft:map_id`: in both
// hands when it is the main hand's and the off hand is empty
// (`renderTwoHandedMap`), else in its own hand (`renderOneHandedMap`).
MapHold :: enum {
    TwoHanded,
    OneHanded,
}
    // rust: impl MapHold {
of :: proc(hand: Hand, off_hand_empty: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if hand == Hand::Main && off_hand_empty {
    // rust: Self::TwoHanded
    // rust: } else {
    // rust: Self::OneHanded
}
}
}

// `FirstPersonHandsAndItemsRenderer.applyBrushTransform`: the brush in use,
// swept back and forth by the ticks left of its use (`remaining`).
brush_transform :: proc(left: bool, remaining: f32, partial: f32) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
//     use horizon_core::geometry::trig::Mth;
    // rust: let ticks = remaining % 10.0;
    // rust: let delta = ticks - partial + 1.0;
    // rust: let scaled = 1.0 - delta / 10.0;
    // rust: let swipe = -15.0 + 75.0 * (scaled * 2.0 * std::f32::consts::PI).mcos();
    // rust: let sweep = Mat4::from_rotation_x(swipe.to_radians());
    // rust: if left {
    // rust: Mat4::from_translation(Vec3::new(0.1, 0.83, 0.35))
    // rust: * Mat4::from_rotation_x((-80.0f32).to_radians())
    // rust: * Mat4::from_rotation_y((-90.0f32).to_radians())
    // rust: * sweep
    // rust: * Mat4::from_translation(Vec3::new(-0.3, 0.22, 0.35))
    // rust: } else {
    // rust: Mat4::from_translation(Vec3::new(-0.25, 0.22, 0.35))
    // rust: * Mat4::from_rotation_x((-80.0f32).to_radians())
    // rust: * Mat4::from_rotation_y(90.0f32.to_radians())
    // rust: * sweep
}
}

// `renderPlayerArm` up to `renderPlayerHand`: the pose of the bare `left`
// or right arm.
player_arm_pose :: proc(left: bool, inverse_height: f32, attack: f32) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
//     use horizon_core::geometry::trig::Mth;
    // rust: let f = if left { -1.0 } else { 1.0 };
    // rust: let pi = std::f32::consts::PI;
    // rust: let root = attack.sqrt();
    // rust: let x = -0.3 * (root * pi).msin();
    // rust: let y = 0.4 * (root * std::f32::consts::TAU).msin();
    // rust: let z = -0.4 * (attack * pi).msin();
    // rust: let z_rot = (attack * attack * pi).msin();
    // rust: let y_rot = (root * pi).msin();
    // rust: let deg = |d: f32| d.to_radians();
    // rust: Mat4::from_translation(Vec3::new(
    // rust: f * (x + 0.640_000_05),
    // rust: y - 0.6 + inverse_height * -0.6,
    // rust: z + -0.719_999_97,
    // rust: )) * Mat4::from_rotation_y(deg(f * 45.0))
    // rust: * Mat4::from_rotation_y(deg(f * y_rot * 70.0))
    // rust: * Mat4::from_rotation_z(deg(f * z_rot * -20.0))
    // rust: * Mat4::from_translation(Vec3::new(-f, 3.6, 3.5))
    // rust: * Mat4::from_rotation_z(deg(f * 120.0))
    // rust: * Mat4::from_rotation_x(deg(200.0))
    // rust: * Mat4::from_rotation_y(deg(f * -135.0))
    // rust: * Mat4::from_translation(Vec3::new(f * 5.6, 0.0, 0.0))
}

// `renderTwoHandedMap` up to its arms: the swing, the tilt from the view
// pitch (`calculateMapTilt`) and the turn towards the player.
two_handed_map_base :: proc(pitch: f32, inverse_height: f32, attack: f32) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
//     use horizon_core::geometry::trig::Mth;
    // rust: let pi = std::f32::consts::PI;
    // rust: let y_swing = -0.2 * (attack * pi).msin();
    // rust: let z_swing = -0.4 * (attack.sqrt() * pi).msin();
    // rust: let tilt = (1.0 - pitch / 45.0 + 0.1).clamp(0.0, 1.0);
    // rust: let tilt = -(tilt * pi).mcos() * 0.5 + 0.5;
    // rust: Mat4::from_translation(Vec3::new(0.0, -y_swing / 2.0, z_swing))
    // rust: * Mat4::from_translation(Vec3::new(
    // rust: 0.0,
    // rust: 0.04 + inverse_height * -1.2 + tilt * -0.5,
    // rust: -0.72,
    // rust: ))
    // rust: * Mat4::from_rotation_x((tilt * -85.0).to_radians())
}

// The arms under a held map, as (left arm, pose before `renderPlayerHand`):
// `renderOneHandedMap`'s arm turned 10 degrees outwards, or
// `renderTwoHandedMap`'s two `renderMapHand` arms under the map's
// `two_handed_map_base`. Vanilla skips them for an invisible player.
    // rust: pub fn map_arm_poses(
    // rust: hold: MapHold,
    // rust: left: bool,
    // rust: pitch: f32,
    // rust: inverse_height: f32,
    // rust: attack: f32,
    // rust: ) -> Vec<(bool, glam::Mat4)> {
//     use glam::{Mat4, Vec3};
    // rust: let deg = |d: f32| d.to_radians();
    // rust: match hold {
    // rust: MapHold::OneHanded => {
    // rust: let f = if left { -1.0 } else { 1.0 };
    // rust: let m = Mat4::from_translation(Vec3::new(f * 0.125, -0.125, 0.0))
    // rust: * Mat4::from_rotation_z(deg(f * 10.0))
    // rust: * player_arm_pose(left, inverse_height, attack);
    // rust: vec![(left, m)]
}
    // rust: MapHold::TwoHanded => {
    // rust: let base = two_handed_map_base(pitch, inverse_height, attack)
    // rust: * Mat4::from_rotation_y(deg(90.0));
    // rust: [false, true]
    // rust: .into_iter()
    // rust: .map(|left| {
    // rust: let f = if left { -1.0 } else { 1.0 };
    // rust: let hand = Mat4::from_rotation_y(deg(92.0))
    // rust: * Mat4::from_rotation_x(deg(45.0))
    // rust: * Mat4::from_rotation_z(deg(f * -41.0))
    // rust: * Mat4::from_translation(Vec3::new(f * 0.3, -1.1, 0.45));
    // rust: (left, base * hand)
    // rust: })
    // rust: .collect()
}
}
}

// `renderOneHandedMap` up to `renderMap`: the pose of a map in the hand on
// the `left` or right arm (its arm: [`map_arm_poses`]).
one_handed_map_pose :: proc(left: bool, inverse_height: f32, attack: f32) -> g {
    // Ported from Horizon
    return {}
}
//     use glam::{Mat4, Vec3};
//     use horizon_core::geometry::trig::Mth;
    // rust: let invert = if left { -1.0 } else { 1.0 };
    // rust: let pi = std::f32::consts::PI;
    // rust: let root = attack.sqrt();
    // rust: let x_swing = (root * pi).msin();
    // rust: Mat4::from_translation(Vec3::new(invert * 0.125, -0.125, 0.0))
    // rust: * Mat4::from_translation(Vec3::new(
    // rust: invert * 0.51,
    // rust: -0.08 + inverse_height * -1.2,
    // rust: -0.75,
    // rust: ))
    // rust: * Mat4::from_translation(Vec3::new(
    // rust: invert * -0.5 * x_swing,
    // rust: 0.4 * (root * std::f32::consts::TAU).msin() - 0.3 * x_swing,
    // rust: -0.3 * (attack * pi).msin(),
    // rust: ))
    // rust: * Mat4::from_rotation_x((x_swing * -45.0).to_radians())
    // rust: * Mat4::from_rotation_y((invert * x_swing * -30.0).to_radians())
}

// `FirstPersonHandsAndItems.evaluateWhichHandsToRender`: whether the main
// and the off hand show, from what each holds (item and whether it is a
// charged crossbow) and the item in use with its hand. A bow or crossbow
// being drawn hides the other hand, and a charged crossbow in the main hand
// hides the off hand unless the off hand is the one in use.
hands_to_render :: proc(held: [Option<(string) {
}
    // rust: let bow_like = |id: &str| matches!(id, "minecraft:bow" | "minecraft:crossbow");
    // rust: let charged_crossbow =
    // rust: |h: Option<(&str, bool)>| h.is_some_and(|(id, c)| c && id == "minecraft:crossbow");
    // rust: if !held.iter().flatten().any(|&(id, _)| bow_like(id)) {
    // rust: return [true, true];
}
    // rust: match using {
    // rust: None => [true, !charged_crossbow(held[0])],
    // rust: Some((hand, id)) if bow_like(id) => [hand == Hand::Main, hand == Hand::Off],
    // rust: Some((hand, _)) => [true, !(hand == Hand::Main && charged_crossbow(held[1]))],
}
}

// `InteractionHand`.
Hand :: enum {
    Main,
    Off,
}
    // rust: impl Hand {
BOTH :: [Hand::Main, Hand::Off]
}

// `SwingAnimation`: its type (`SwingAnimationType` ordinal) and duration.
SwingAnimation :: struct {
    kind: u8,
    duration: i32,
}
    // rust: impl SwingAnimation {
    // `SwingAnimation.DEFAULT`: WHACK for 6 ticks.
    // rust: pub const DEFAULT: SwingAnimation = SwingAnimation {
    // rust: kind: 1,
    // rust: duration: 6,
}
}

// `LivingEntity.SwingDescription`.
SwingDescription :: struct {
    hand: Hand,
    animation: SwingAnimation,
    duration_ticks: i32,
}

// `LivingEntity.SwingState`.
SwingState :: struct {
    current: Maybe(SwingDescription),
    ticks: i32,
    old_animation: f32,
    animation: f32,
}
    // rust: impl SwingState {
    // `startIfAble`: a swing restarts unless the current one is in its
    // first half (past its first tick).
start_if_able :: proc(self: ^Self, hand: Hand, animation: SwingAnimation, duration: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(c) = self.current
    // rust: && self.ticks <= c.duration_ticks / 2
    // rust: && self.ticks > 0
    // rust: {
    // rust: return false;
}
    // rust: let swing = SwingDescription {
    // rust: hand,
    // rust: animation,
    // rust: duration_ticks: duration,
}
    // rust: if self.current != Some(swing) {
    // rust: self.old_animation = 0.0;
    // rust: self.animation = 0.0;
}
    // rust: self.current = Some(swing);
    // rust: self.ticks = 0;
    // rust: true
}
    // `tick` (from `LivingEntity.baseTick`).
tick :: proc(self: ^Self) {
}
    // rust: self.old_animation = self.animation;
    // rust: if let Some(c) = self.current {
    // rust: if c.duration_ticks > 0 {
    // rust: self.animation = (self.ticks as f32 / c.duration_ticks as f32).min(1.0);
}
    // rust: let ticks = self.ticks;
    // rust: self.ticks += 1;
    // rust: if ticks > c.duration_ticks {
    // rust: self.current = None;
    // rust: self.animation = 0.0;
}
    // rust: } else {
    // rust: self.animation = 0.0;
}
}
    // `getAnimation(partialTicks)`: a restarted swing keeps moving forward.
animation :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.animation >= self.old_animation {
    // rust: crate::camera::lerp(partial, self.old_animation, self.animation)
    // rust: } else {
    // rust: crate::camera::lerp(partial, self.old_animation, self.animation + 1.0)
}
}
swinging :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.current.is_some()
}
    // The hand of the current swing (`state.attackHand`), main by default.
attack_hand :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: self.current.map_or(Hand::Main, |c| c.hand)
}
}

// `LivingEntity.getModifiedSwingDuration`: `dig_speed` is
// `MobEffectUtil.getDigSpeedAmplification` while haste or conduit power is
// active, `fatigue` the mining fatigue amplifier.
    // rust: pub fn swing_duration(
    // rust: animation: SwingAnimation,
    // rust: dig_speed: Option<i32>,
    // rust: fatigue: Option<i32>,
    // rust: ) -> i32 {
    // rust: let duration = animation.duration;
    // rust: if let Some(amplification) = dig_speed {
    // rust: duration - (1 + amplification)
    // rust: } else if let Some(amplifier) = fatigue {
    // rust: duration + (1 + amplifier) * 2
    // rust: } else {
    // rust: duration
}
}

// `FirstPersonHandsAndItems`' equip heights.
HandHeights :: struct {
    main: f32,
    old_main: f32,
    off: f32,
    old_off: f32,
}
    // rust: impl Default for HandHeights {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: HandHeights {
    // rust: main: 0.0,
    // rust: old_main: 0.0,
    // rust: off: 0.0,
    // rust: old_off: 0.0,
}
}
}
    // rust: impl HandHeights {
    // `FirstPersonHandsAndItems.tick`'s heights. `changed` says per hand
    // whether the visible item differs from the held one once
    // `shouldInstantlyReplaceVisibleItem` has run; `swap_scale` is
    // `getItemSwapScale(1.0F)`. Returns whether each hand's visible item
    // is replaced at the end.
tick :: proc(self: ^Self, hands_busy: bool, swap_scale: f32, changed: [bool; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.tick_with(hands_busy, swap_scale, changed, false)
}
    // [`Self::tick`]; `legacy` (Combat feel Legacy) raises the main hand fully whatever the
    // attack strength, as 1.8.9's `ItemRenderer.updateEquippedItem` did (no dip after a hit).
    // rust: pub fn tick_with(
    // rust: &mut self,
    // rust: hands_busy: bool,
    // rust: swap_scale: f32,
    // rust: changed: [bool; 2],
    // rust: legacy: bool,
    // rust: ) -> [bool; 2] {
    // rust: self.old_main = self.main;
    // rust: self.old_off = self.off;
    // rust: if hands_busy {
    // rust: self.main = (self.main - 0.4).clamp(0.0, 1.0);
    // rust: self.off = (self.off - 0.4).clamp(0.0, 1.0);
    // rust: } else {
    // rust: let attack = if legacy { 1.0 } else { swap_scale };
    // rust: let main_target = if changed[0] {
    // rust: 0.0
    // rust: } else {
    // rust: attack * attack * attack
}
    // rust: let off_target = if changed[1] { 0.0 } else { 1.0 };
    // rust: self.main += (main_target - self.main).clamp(-0.4, 0.4);
    // rust: self.off += (off_target - self.off).clamp(-0.4, 0.4);
}
    // rust: [self.main < 0.1, self.off < 0.1]
}
    // `itemUsed`: the hand drops to the bottom and rises again.
item_used :: proc(self: ^Self, hand: Hand) {
}
    // rust: match hand {
    // rust: Hand::Main => self.main = 0.0,
    // rust: Hand::Off => self.off = 0.0,
}
}
    // `Mth.lerp(partialTicks, oMainHandHeight, mainHandHeight)` and the
    // off hand's.
interpolated :: proc(self: ^Self, partial: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: crate::camera::lerp(partial, self.old_main, self.main),
    // rust: crate::camera::lerp(partial, self.old_off, self.off),
    // rust: ]
}
}

// `FirstPersonHandsAndItemsRenderer.submit`: the displayed stack's model
// scales the interpolated equip displacement independently for each hand.
equip_displacement :: proc(height: f32, swap_animation_scale: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: swap_animation_scale * (1.0 - height)
}

// `Mth.wrapDegrees`: an angle difference in -180..=180.
wrap_degrees :: proc(d: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let d = d % 360.0;
    // rust: if d >= 180.0 {
    // rust: d - 360.0
    // rust: } else if d < -180.0 {
    // rust: d + 360.0
    // rust: } else {
    // rust: d
}
}
// `LocalPlayer.xBob` and `yBob`: the hands lag behind the view when it
// turns. `LocalPlayer.applyInput` eases them halfway to the rotation every
// tick; `FirstPersonHandsAndItemsRenderer` turns the hands by a tenth of
// the gap left.
HandSway :: struct {
    x_bob: f32,
    y_bob: f32,
    x_bob_o: f32,
    y_bob_o: f32,
    // The yaw `tick_wrapped` has followed so far, unwrapped like vanilla's.
    y_rot: f32,
}
    // rust: impl HandSway {
    // `LocalPlayer.applyInput` with the player's `getXRot` and `getYRot`.
tick :: proc(self: ^Self, x_rot: f32, y_rot: f32) {
}
    // rust: self.y_bob_o = self.y_bob;
    // rust: self.x_bob_o = self.x_bob;
    // rust: self.x_bob += (x_rot - self.x_bob) * 0.5;
    // rust: self.y_bob += (y_rot - self.y_bob) * 0.5;
}
    // `tick` for a yaw kept in -180..180 (a boat turns its rider through the wrap). Vanilla's
    // yaw runs on without wrapping, so `yRot - yBob` is always the short way round; this
    // follows the wrapped yaw by its short steps to give `tick` the same unwrapped yaw.
tick_wrapped :: proc(self: ^Self, x_rot: f32, y_rot: f32) {
}
    // rust: self.y_rot += wrap_degrees(y_rot - self.y_rot);
    // rust: self.tick(x_rot, self.y_rot);
}
    // The degrees the hands turn about X, then Y, before either is drawn:
    // `(viewXRot - xBob) * 0.1` and `(viewYRot - yBob) * 0.1`, the bobs
    // interpolated as `extractRenderState` does.
rotation :: proc(self: ^Self, partial: f32, view_x_rot: f32, view_y_rot: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let x_bob = crate::camera::lerp(partial, self.x_bob_o, self.x_bob);
    // rust: let y_bob = crate::camera::lerp(partial, self.y_bob_o, self.y_bob);
    // rust: [
    // rust: (view_x_rot - x_bob) * 0.1,
    // rust: wrap_degrees(view_y_rot - y_bob) * 0.1,
    // rust: ]
}
    // The hands' view space to camera-relative world space, turned by the
    // sway. The hand pass draws with the camera's view, whose rotation a
    // ridden boat's turn spreads over the frames of a tick
    // (`LocalPlayer.getViewYRot`): anything else swings the hands back and
    // forth by that turn, up to 10 degrees, 20 times a second (#4583).
to_world :: proc(self: ^Self, partial: f32, camera: ^crate::camera::Camera) -> g {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y] = self.rotation(partial, camera.x_rot, camera.y_rot);
    // rust: crate::camera::view_matrix(camera.y_rot, camera.x_rot).inverse()
    // rust: * glam::Mat4::from_rotation_x(x.to_radians())
    // rust: * glam::Mat4::from_rotation_y(y.to_radians())
}
}

// `HitResult` at the crosshair (`Minecraft.hitResult`).
Hit :: enum {
    Miss,
    Block { pos: [i32; 3], face: u8 },
    Entity,
}

// `InteractionResult` as `startUseItem` reads it.
UseResult :: enum {
    // `Success` with its `SwingSource`: whether the client swings.
    Success {,
    swing: bool,
    // rust: },
    Pass,
    Fail,
}

    // rust: impl UseResult {
should_swing :: proc(self: ^Self, before: u32, after: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::Success { swing: true }) && before == after
}
}
    // rust: pub use horizon_items::use_animation::consumable_animation;
// What the click handling reads and does in the world.
    // rust: pub trait HandWorld {
hit :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
is_air :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // `MultiPlayerGameMode.localPlayerMode`.
creative :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
spectator :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `Abilities.instabuild`.
instabuild :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
hands_busy :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
using_item :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `ItemStack.isItemEnabled` for the item in a hand.
item_enabled :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
held_empty :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
held_count :: proc(self: ^Self, hand: Hand) -> i {
    // Ported from Horizon
    return {}
}
    // `Player.hasInfiniteMaterials`.
infinite_materials :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `Player.cannotAttackWithItem(heldItem, 0)`.
cannot_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // The main-hand item is a `PIERCING_WEAPON`.
piercing_weapon :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
attack_animation :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
interact_animation :: proc(self: ^Self, hand: Hand) -> S {
    // Ported from Horizon
    return {}
}
    // `MultiPlayerGameMode.piercingAttack`.
piercing_attack :: proc(self: ^Self, animation: SwingAnimation) {
}
    // `Player.attack` on the targeted entity when the item's attack range
    // allows it; false when out of range.
attack_entity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `Player.blockActionRestricted` for the game mode.
block_action_restricted :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // `WorldBorder.isWithinBounds`.
within_border :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // `BlockState.attack` on the first hit of a break.
attack_block :: proc(self: ^Self, pos: [i32; 3]) {
}
    // `BlockState.getDestroyProgress` for the player.
destroy_progress :: proc(self: ^Self, pos: [i32; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // `MultiPlayerGameMode.destroyBlock`.
destroy_block :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // A key for the main-hand stack, kept as `destroyingItem`.
main_hand_key :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // `ItemStack.isSameItemSameComponents(selected, destroyingItem)` for
    // the stack `main_hand_key` gave when the break started. Vanilla keeps
    // a reference to that stack, so it compares what it holds now.
same_destroying_item :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.main_hand_key() == key
}
    // Breaking progress shown (`destroyBlockProgress`), or cleared with `None`.
destroy_stage :: proc(self: ^Self, pos: [i32; 3], stage: Maybe(i32)) {
}
    // `player.swing(hand, animation, false)`.
swing :: proc(self: ^Self, hand: Hand, animation: SwingAnimation) {
}
    // `Player.resetAttackStrengthTicker`.
reset_attack_strength :: proc(self: ^Self) {
}
    // The targeted entity's block position is inside the world border.
entity_within_border :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // The use attempts of `startUseItem`: on the targeted entity (`None`
    // when it is out of interaction range), the targeted block, and the
    // item alone.
use_on_entity :: proc(self: ^Self, hand: Hand) -> O {
    // Ported from Horizon
    return {}
}
use_on_block :: proc(self: ^Self, hand: Hand) -> U {
    // Ported from Horizon
    return {}
}
use_item :: proc(self: ^Self, hand: Hand) -> U {
    // Ported from Horizon
    return {}
}
    // `LocalPlayer.itemUsed`.
item_used :: proc(self: ^Self, hand: Hand) {
}
    // `MultiPlayerGameMode.releaseUsingItem`.
release_using :: proc(self: ^Self) {
}
}

// `MultiPlayerGameMode`'s block breaking.
Destroying :: struct {
    delay: i32,
    active: bool,
    pos: [i32,
    face: u8,
    item: string,
    progress: f32,
    ticks: f32,
}
    // rust: impl Default for Destroying {
    // `destroyBlockPos` starts at (-1, -1, -1) and `destroyingItem` empty
    // (an empty key).
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Destroying {
    // rust: delay: 0,
    // rust: active: false,
    // rust: pos: [-1; 3],
    // rust: face: 0,
    // rust: item: String::new(),
    // rust: progress: 0.0,
    // rust: ticks: 0.0,
}
}
}
    // rust: impl Destroying {
    // `getDestroyStage`.
stage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.progress > 0.0 {
    // rust: (self.progress * 10.0) as i32
    // rust: } else {
    // rust: -1
}
}
same_target :: proc(self: ^Self, w: ^impl HandWorld, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: pos == self.pos && w.same_destroying_item(&self.item)
}
    // `startDestroyBlock`.
start :: proc(self: ^Self, w: ^impl HandWorld, pos: [i32; 3], face: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if w.block_action_restricted(pos) || !w.within_border(pos) {
    // rust: return false;
}
    // rust: if w.instabuild() {
    // rust: w.destroy_block(pos);
    // rust: self.delay = 5;
    // rust: } else if !self.active || !self.same_target(w, pos) {
    // rust: let not_air = !w.is_air(pos);
    // rust: if not_air && self.progress == 0.0 {
    // rust: w.attack_block(pos);
}
    // rust: if not_air && w.destroy_progress(pos) >= 1.0 {
    // rust: w.destroy_block(pos);
    // rust: } else {
    // rust: self.active = true;
    // rust: self.pos = pos;
    // rust: self.face = face;
    // rust: self.item = w.main_hand_key();
    // rust: self.progress = 0.0;
    // rust: self.ticks = 0.0;
    // rust: w.destroy_stage(pos, Some(self.stage()));
}
}
    // rust: true
}
    // `stopDestroyBlock`.
stop :: proc(self: ^Self, w: ^impl HandWorld) {
}
    // rust: if self.active {
    // rust: self.active = false;
    // rust: self.progress = 0.0;
    // rust: w.destroy_stage(self.pos, None);
    // rust: w.reset_attack_strength();
}
}
    // `continueDestroyBlock`: true while the hand keeps swinging.
continue_destroy :: proc(self: ^Self, w: ^impl HandWorld, pos: [i32; 3], face: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.delay > 0 {
    // rust: self.delay -= 1;
    // rust: return true;
}
    // rust: if w.instabuild() && w.within_border(pos) {
    // rust: self.delay = 5;
    // rust: w.destroy_block(pos);
    // rust: return true;
}
    // rust: if !self.same_target(w, pos) {
    // rust: return self.start(w, pos, face);
}
    // rust: if w.is_air(pos) {
    // rust: self.active = false;
    // rust: return false;
}
    // rust: self.progress += w.destroy_progress(pos);
    // rust: self.ticks += 1.0;
    // rust: if self.progress >= 1.0 {
    // rust: self.active = false;
    // rust: w.destroy_block(pos);
    // rust: self.progress = 0.0;
    // rust: self.ticks = 0.0;
    // rust: self.delay = 5;
    // rust: } else if self.face != face {
    // rust: self.face = face;
}
    // rust: w.destroy_stage(self.pos, Some(self.stage()));
    // rust: true
}
}

// `Minecraft`'s attack and use handling.
Clicks :: struct {
    miss_time: i32,
    right_click_delay: i32,
    destroying: Destroying,
}
    // rust: impl Clicks {
    // `Minecraft.startAttack`: whether the click ended the attack (broke
    // the block outright).
start_attack :: proc(self: ^Self, w: ^impl HandWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.miss_time > 0 || w.hands_busy() {
    // rust: return false;
}
    // rust: if w.spectator() {
    // rust: return true;
}
    // rust: if !w.item_enabled(Hand::Main) || w.cannot_attack() {
    // rust: return false;
}
    // rust: let animation = w.attack_animation();
    // rust: if w.piercing_weapon() {
    // rust: w.piercing_attack(animation);
    // rust: return true;
}
    // rust: let mut end = false;
    // rust: let mut miss = false;
    // rust: match w.hit() {
            // MultiPlayerGameMode.attack.
    // rust: Hit::Entity => {
    // rust: if w.attack_entity() {
    // rust: w.reset_attack_strength();
    // rust: if w.instabuild() {
    // rust: self.destroying.delay = 5;
}
}
}
    // rust: Hit::Block { pos, face } if !w.is_air(pos) => {
    // rust: self.destroying.start(w, pos, face);
    // rust: end = w.is_air(pos);
}
    // rust: Hit::Block { .. } | Hit::Miss => miss = true,
}
    // rust: if miss {
    // rust: if !w.creative() {
    // rust: self.miss_time = 10;
}
    // rust: w.reset_attack_strength();
}
    // rust: w.swing(Hand::Main, animation);
    // rust: end
}
    // `Minecraft.continueAttack`.
continue_attack :: proc(self: ^Self, w: ^impl HandWorld, down: bool) {
}
    // rust: if !down {
    // rust: self.miss_time = 0;
}
    // rust: if self.miss_time > 0 || w.using_item() || w.piercing_weapon() {
    // rust: return;
}
    // rust: let animation = w.attack_animation();
    // rust: match w.hit() {
    // rust: Hit::Block { pos, face } if down => {
    // rust: if !w.is_air(pos) && self.destroying.continue_destroy(w, pos, face) {
    // rust: w.swing(Hand::Main, animation);
}
}
    // rust: _ => self.destroying.stop(w),
}
}
    // `Minecraft.startUseItem`.
start_use_item :: proc(self: ^Self, w: ^impl HandWorld) {
}
    // rust: if self.destroying.active {
    // rust: return;
}
    // rust: self.right_click_delay = 4;
    // rust: if w.hands_busy() {
    // rust: return;
}
    // rust: for hand in Hand::BOTH {
    // rust: if !w.item_enabled(hand) {
    // rust: return;
}
    // rust: let animation = w.interact_animation(hand);
    // rust: match w.hit() {
    // rust: Hit::Entity => {
    // rust: if !w.entity_within_border() {
    // rust: return;
}
    // rust: if let Some(UseResult::Success { swing }) = w.use_on_entity(hand) {
    // rust: if swing {
    // rust: w.swing(hand, animation);
}
    // rust: return;
}
}
    // rust: Hit::Block { .. } => {
    // rust: let count = w.held_count(hand);
    // rust: match w.use_on_block(hand) {
    // rust: UseResult::Success { swing } => {
    // rust: if swing {
    // rust: w.swing(hand, animation);
    // rust: if !w.held_empty(hand)
    // rust: && (w.held_count(hand) != count || w.infinite_materials())
    // rust: {
    // rust: w.item_used(hand);
}
}
    // rust: return;
}
    // rust: UseResult::Fail => return,
    // rust: UseResult::Pass => {}
}
}
    // rust: Hit::Miss => {}
}
    // rust: if !w.held_empty(hand)
    // rust: && let UseResult::Success { swing } = w.use_item(hand)
    // rust: {
    // rust: if swing {
    // rust: w.swing(hand, animation);
}
    // rust: w.item_used(hand);
    // rust: return;
}
}
}
    // The attack and use part of `Minecraft.tick`: `rightClickDelay`, the
    // clicks `handleKeybinds` consumes, held use and attack, then
    // `missTime`. `attack_down` is `keyAttack.isDown()` with no screen and
    // the mouse grabbed.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: w: &mut impl HandWorld,
    // rust: attack_clicks: u32,
    // rust: use_clicks: u32,
    // rust: attack_down: bool,
    // rust: use_down: bool,
    // rust: ) {
    // rust: if self.right_click_delay > 0 {
    // rust: self.right_click_delay -= 1;
}
    // rust: let mut instant = false;
    // rust: if w.using_item() {
    // rust: if !use_down {
    // rust: w.release_using();
}
    // rust: } else {
    // rust: for _ in 0..attack_clicks {
    // rust: instant |= self.start_attack(w);
}
    // rust: for _ in 0..use_clicks {
    // rust: self.start_use_item(w);
}
}
    // rust: if use_down && self.right_click_delay == 0 && !w.using_item() {
    // rust: self.start_use_item(w);
}
    // rust: self.continue_attack(w, !instant && attack_down);
    // rust: if self.miss_time > 0 {
    // rust: self.miss_time -= 1;
}
}
}

    // rust: mod tests {
//     use super::*;

equip_displacement_uses_the_visible_items_scale :: proc() {
}
//         use horizon_assets::item_model::{ClientItem, ItemModels, StackView};
//         use serde_json::json;

    // rust: let mut models = ItemModels::default();
    // rust: for (item, scale) in [("minecraft:spear", 1.95), ("minecraft:sword", 1.0)] {
    // rust: models.definitions.insert(
    // rust: item.into(),
    // rust: ClientItem::decode(&json!({
    // rust: "model": { "type": "minecraft:empty" },
    // rust: "swap_animation_scale": scale,
    // rust: }))
    // rust: .unwrap(),
    // rust: );
    // rust: models.prototypes.insert(
    // rust: item.into(),
    // rust: [("minecraft:item_model".into(), json!(item))].into(),
    // rust: );
}
    // rust: let spear = StackView::new("minecraft:spear", 1);
    // rust: let sword = StackView::new("minecraft:sword", 1);
    // rust: let height = 0.5;
        // The model of the visible stack determines each hand's displacement.
    // rust: assert_eq!(
    // rust: equip_displacement(height, models.swap_animation_scale(&spear)),
    // rust: 0.975
    // rust: );
    // rust: assert_eq!(
    // rust: equip_displacement(height, models.swap_animation_scale(&sword)),
    // rust: 0.5
    // rust: );
    // rust: assert_eq!(
    // rust: equip_displacement(1.0, models.swap_animation_scale(&spear)),
    // rust: 0.0
    // rust: );

        // A component override (such as a resource-pack model) takes precedence.
    // rust: let mut overridden = spear;
    // rust: overridden.patch.insert(
    // rust: "minecraft:item_model".into(),
    // rust: Some(json!("minecraft:sword")),
    // rust: );
    // rust: assert_eq!(
    // rust: equip_displacement(height, models.swap_animation_scale(&overridden)),
    // rust: 0.5
    // rust: );
}

    // #4583: while a boat turns the player steadily, the hands keep their
    // place on screen through every frame of a tick.
the_hands_hold_still_on_screen_while_a_boat_turns :: proc() {
}
TURN :: 10.0
    // rust: let mut sway = HandSway::default();
    // rust: let mut yaw = 0.0;
    // rust: for _ in 0..30 {
    // rust: sway.tick(0.0, yaw);
    // rust: yaw += TURN;
}
    // rust: let on_screen = |partial: f32| {
    // rust: let camera = crate::camera::Camera {
    // rust: y_rot: yaw - TURN * (1.0 - partial),
    // rust: ..Default::default()
}
    // rust: crate::camera::view_matrix(camera.y_rot, 0.0) * sway.to_world(partial, &camera)
}
    // rust: let first = on_screen(0.0);
    // rust: for partial in [0.25, 0.5, 0.75, 0.99] {
    // rust: let frame = on_screen(partial);
    // rust: assert!(frame.abs_diff_eq(first, 1.0e-3), "{partial}: {frame:?}");
}
}
drawing_a_bow_or_holding_a_charged_crossbow_hides_a_hand :: proc() {
}
    // rust: let (bow, apple) = (
    // rust: Some(("minecraft:bow", false)),
    // rust: Some(("minecraft:apple", false)),
    // rust: );
    // rust: let charged = Some(("minecraft:crossbow", true));
    // rust: assert_eq!(hands_to_render([apple, apple], None), [true, true]);
    // rust: assert_eq!(hands_to_render([bow, apple], None), [true, true]);
    // rust: assert_eq!(hands_to_render([charged, apple], None), [true, false]);
    // rust: assert_eq!(hands_to_render([apple, charged], None), [true, true]);
    // rust: let drawing = |hand| Some((hand, "minecraft:bow"));
    // rust: assert_eq!(
    // rust: hands_to_render([bow, apple], drawing(Hand::Main)),
    // rust: [true, false]
    // rust: );
    // rust: assert_eq!(
    // rust: hands_to_render([apple, bow], drawing(Hand::Off)),
    // rust: [false, true]
    // rust: );
    // rust: let eating = |hand| Some((hand, "minecraft:apple"));
    // rust: assert_eq!(
    // rust: hands_to_render([apple, charged], eating(Hand::Main)),
    // rust: [true, false]
    // rust: );
    // rust: assert_eq!(
    // rust: hands_to_render([charged, apple], eating(Hand::Off)),
    // rust: [true, true]
    // rust: );
}
a_swing_lasts_its_duration_and_restarts_after_half :: proc() {
}
    // rust: let mut s = SwingState::default();
    // rust: assert!(s.start_if_able(Hand::Main, SwingAnimation::DEFAULT, 6));
    // rust: let mut seen = Vec::new();
    // rust: for _ in 0..9 {
    // rust: s.tick();
    // rust: seen.push(s.animation);
}
    // rust: assert_eq!(
    // rust: seen,
    // rust: [
    // rust: 0.0,
    // rust: 1.0 / 6.0,
    // rust: 2.0 / 6.0,
    // rust: 0.5,
    // rust: 4.0 / 6.0,
    // rust: 5.0 / 6.0,
    // rust: 1.0,
    // rust: 0.0,
    // rust: 0.0
    // rust: ]
    // rust: );
    // rust: assert!(!s.swinging());
    // rust: s.start_if_able(Hand::Main, SwingAnimation::DEFAULT, 6);
    // rust: s.tick();
    // rust: s.tick();
    // rust: assert!(!s.start_if_able(Hand::Main, SwingAnimation::DEFAULT, 6));
    // rust: s.tick();
    // rust: s.tick();
    // rust: assert!(s.start_if_able(Hand::Main, SwingAnimation::DEFAULT, 6));
    // rust: s.tick();
        // Restarting the same swing wraps forward rather than snapping back.
    // rust: assert_eq!(
    // rust: s.animation(0.5),
    // rust: (s.old_animation + s.animation + 1.0) / 2.0
    // rust: );
}
haste_shortens_and_fatigue_lengthens_swings :: proc() {
}
    // rust: let d = SwingAnimation::DEFAULT;
    // rust: assert_eq!(swing_duration(d, None, None), 6);
    // rust: assert_eq!(swing_duration(d, Some(1), Some(0)), 4);
    // rust: assert_eq!(swing_duration(d, None, Some(2)), 12);
}

legacy_hand_puts_a_flat_item_where_1_8_9_drew_it :: proc() {
}
//         use glam::{Mat4, Vec3};
        // At rest, the item's centre (model (0.5, 0.5, 0.5)) ends where 1.8.9's chain puts it:
        // translate(0.56, -0.52, -0.72) . rotY(45) . scale(0.4) . translate((0, 4, 2) / 16)
        // . ... . scale(0.5) . translate(-0.5): the centre is (0, 0.25, 0.125) scaled by 0.4,
        // turned 45 degrees about Y.
    // rust: let pose = legacy_item_pose(false, 0.0, 0.0, ItemPose::Swing, false).unwrap();
    // rust: let layer = modern_flat_display(false) * Mat4::from_translation(Vec3::splat(-0.5));
    // rust: let centre = (pose * layer).transform_point3(Vec3::splat(0.5));
    // rust: let c45 = std::f32::consts::FRAC_1_SQRT_2;
    // rust: let expected = Vec3::new(0.56 + 0.05 * c45, -0.52 + 0.1, -0.72 + 0.05 * c45);
    // rust: assert!(centre.abs_diff_eq(expected, 1e-4), "{centre} vs {expected}");
        // The left arm mirrors it.
    // rust: let left = legacy_item_pose(true, 0.0, 0.0, ItemPose::Swing, false).unwrap();
    // rust: let left_layer = modern_flat_display(true) * Mat4::from_translation(Vec3::splat(-0.5));
    // rust: let l = (left * left_layer).transform_point3(Vec3::splat(0.5));
    // rust: assert!(l.abs_diff_eq(Vec3::new(-expected.x, expected.y, expected.z), 1e-4));
        // Lowered by the equip height: 0.6 of it, straight down.
    // rust: let low = legacy_item_pose(false, 0.5, 0.0, ItemPose::Swing, false).unwrap();
    // rust: let c = (low * layer).transform_point3(Vec3::splat(0.5));
    // rust: assert!(c.abs_diff_eq(expected - Vec3::new(0.0, 0.3, 0.0), 1e-4));
        // A blocking sword sits elsewhere, and poses 1.8.9 lacked stay modern.
    // rust: let block = legacy_item_pose(false, 0.0, 0.0, ItemPose::Using, true).unwrap();
    // rust: assert!(
    // rust: !(block * layer)
    // rust: .transform_point3(Vec3::splat(0.5))
    // rust: .abs_diff_eq(expected, 0.01)
    // rust: );
    // rust: let trident = ItemPose::Trident { ticks_used: 3.0 };
    // rust: assert!(legacy_item_pose(false, 0.0, 0.0, trident, false).is_none());
}

legacy_hand_does_not_dip_after_a_hit :: proc() {
}
        // Just after a hit the attack strength is 0: 26.3 lowers the main hand to 0,
        // 1.8.9 keeps it up (it only lowers on an item change).
    // rust: let mut modern = HandHeights {
    // rust: main: 1.0,
    // rust: old_main: 1.0,
    // rust: off: 1.0,
    // rust: old_off: 1.0,
}
    // rust: let mut legacy = modern;
    // rust: modern.tick_with(false, 0.0, [false; 2], false);
    // rust: legacy.tick_with(false, 0.0, [false; 2], true);
    // rust: assert!((modern.main - 0.6).abs() < 1e-6, "falls 0.4 a tick");
    // rust: assert_eq!(legacy.main, 1.0);
        // An item change still lowers it.
    // rust: legacy.tick_with(false, 1.0, [true, false], true);
    // rust: assert!((legacy.main - 0.6).abs() < 1e-6);
}

the_flat_display_check_knows_vanillas_matrix :: proc() {
}
    // rust: let m = modern_flat_display(false) * glam::Mat4::from_translation(glam::Vec3::splat(-0.5));
    // rust: assert!(is_modern_flat_display(&m, false));
    // rust: assert!(!is_modern_flat_display(&m, true));
    // rust: assert!(!is_modern_flat_display(&glam::Mat4::IDENTITY, false));
}
}

    // rust: mod item_pose_tests {
//     use super::*;
a_map_is_two_handed_only_in_the_main_hand_with_an_empty_off_hand :: proc() {
}
    // rust: assert_eq!(MapHold::of(Hand::Main, true), MapHold::TwoHanded);
    // rust: assert_eq!(MapHold::of(Hand::Main, false), MapHold::OneHanded);
    // rust: assert_eq!(MapHold::of(Hand::Off, true), MapHold::OneHanded);
    // rust: assert_eq!(MapHold::of(Hand::Off, false), MapHold::OneHanded);
}
one_handed_maps_follow_render_one_handed_map :: proc() {
}
        // PoseStack.last().pose() from vanilla's renderOneHandedMap
        // transforms (column-major), for (left, inverse height, attack).
    // rust: let cases: [(bool, f32, f32, [f32; 16]); 3] = [
    // rust: (
    // rust: false,
    // rust: 0.0,
    // rust: 0.0,
    // rust: [
    // rust: 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, -0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.635, -0.205,
    // rust: -0.75, 1.0,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: true,
    // rust: 0.25,
    // rust: 0.3,
    // rust: [
    // rust: 0.86894435,
    // rust: -0.34686038,
    // rust: -0.35302067,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.713303,
    // rust: -0.70085573,
    // rust: 0.0,
    // rust: 0.4949098,
    // rust: 0.6090046,
    // rust: 0.61982065,
    // rust: 0.0,
    // rust: -0.1406033,
    // rust: -0.9197687,
    // rust: -0.9926984,
    // rust: 1.0,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: false,
    // rust: 0.6,
    // rust: 0.85,
    // rust: [
    // rust: 0.9919303,
    // rust: 0.024030307,
    // rust: 0.12448644,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.9818737,
    // rust: -0.18953651,
    // rust: 0.0,
    // rust: -0.12678458,
    // rust: 0.18800701,
    // rust: 0.97395027,
    // rust: 0.0,
    // rust: 0.5136029,
    // rust: -1.1862278,
    // rust: -0.88621765,
    // rust: 1.0,
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: for (left, inverse_height, attack, want) in cases {
    // rust: let got = one_handed_map_pose(left, inverse_height, attack).to_cols_array();
    // rust: for (g, w) in got.iter().zip(want) {
    // rust: assert!(
    // rust: (g - w).abs() < 1e-5,
    // rust: "{left} {inverse_height} {attack}: {got:?}"
    // rust: );
}
}
}
maps_draw_the_arms_under_them_as_vanilla :: proc() {
}
        // PoseStack.last().pose() (column-major) where renderOneHandedMap's
        // renderPlayerArm and renderTwoHandedMap's renderMapHand call
        // renderPlayerHand, replayed with vanilla's PoseStack, Axis and Mth.
    // rust: let near = |got: glam::Mat4, want: [f32; 16], what: &str| {
    // rust: let got = got.to_cols_array();
    // rust: for (g, w) in got.iter().zip(want) {
    // rust: assert!((g - w).abs() < 1e-5, "{what}: {got:?}");
}
}
        // (left, inverse height, attack, arm)
    // rust: let one: [(bool, f32, f32, [f32; 16]); 3] = [
    // rust: (false, 0.0, 0.0, [
    // rust: -0.2350201, -0.7860474, -0.5717472, 0.0,
    // rust: 0.24694103, 0.52063686, -0.8172866, 0.0,
    // rust: 0.9400987, -0.33326668, 0.07174723, 0.0,
    // rust: 0.65913033, -1.1543381, -0.73980355, 1.0,
    // rust: ]),
    // rust: (true, 0.25, 0.3, [
    // rust: -0.4967606, 0.84289914, -0.20676011, 0.0,
    // rust: 0.7202682, 0.2674863, -0.6400506, 0.0,
    // rust: -0.4841926, -0.46687466, -0.7399901, 0.0,
    // rust: -0.59715486, -1.4160433, -0.7328731, 1.0,
    // rust: ]),
    // rust: (false, 0.6, 0.85, [
    // rust: -0.47358897, -0.8403256, -0.2637542, 0.0,
    // rust: 0.081554025, 0.25634, -0.96313995, 0.0,
    // rust: 0.87696207, -0.47764266, -0.052867785, 0.0,
    // rust: 0.61887383, -1.6482887, -0.7229744, 1.0,
    // rust: ]),
    // rust: ];
    // rust: for (left, inverse_height, attack, want) in one {
    // rust: let arms = map_arm_poses(MapHold::OneHanded, left, 0.0, inverse_height, attack);
    // rust: assert_eq!(arms.len(), 1, "one arm under a one-handed map");
    // rust: assert_eq!(arms[0].0, left, "the arm of the hand holding it");
    // rust: near(
    // rust: arms[0].1,
    // rust: want,
    // rust: &format!("one {left} {inverse_height} {attack}"),
    // rust: );
}
        // (pitch, inverse height, attack, right arm, left arm)
    // rust: let two: [(f32, f32, f32, [f32; 16], [f32; 16]); 2] = [
    // rust: (0.0, 0.0, 0.0, [
    // rust: -0.7380599, 0.44766384, 0.50484115, 0.0,
    // rust: -0.67428374, -0.46198538, -0.57611704, 0.0,
    // rust: -0.024677532, -0.76561517, 0.64282537, 0.0,
    // rust: 0.5091893, -0.16204369, 0.3544525, 1.0,
    // rust: ], [
    // rust: -0.77043974, -0.3951866, -0.50025004, 0.0,
    // rust: 0.637035, -0.5076031, -0.58010805, 0.0,
    // rust: -0.024677532, -0.76561517, 0.64282537, 0.0,
    // rust: -0.48071152, -0.12760738, 0.35746527, 1.0,
    // rust: ]),
    // rust: (30.0, 0.2, 0.5, [
    // rust: -0.7380599, -0.11453738, 0.6649426, 0.0,
    // rust: -0.67428374, 0.16124588, -0.72065324, 0.0,
    // rust: -0.024677532, -0.98024535, -0.1962398, 0.0,
    // rust: 0.5091893, -0.9508533, -0.13439482, 1.0,
    // rust: ], [
    // rust: -0.77043974, 0.14373614, -0.6210978, 0.0,
    // rust: 0.637035, 0.13586378, -0.75876695, 0.0,
    // rust: -0.024677532, -0.98024535, -0.1962398, 0.0,
    // rust: -0.48071152, -0.9316926, -0.1056232, 1.0,
    // rust: ]),
    // rust: ];
    // rust: for (pitch, inverse_height, attack, right, left) in two {
    // rust: let arms = map_arm_poses(MapHold::TwoHanded, false, pitch, inverse_height, attack);
    // rust: assert_eq!(arms.len(), 2, "both arms under a two-handed map");
    // rust: assert_eq!((arms[0].0, arms[1].0), (false, true), "right, then left");
    // rust: near(arms[0].1, right, &format!("two right {pitch}"));
    // rust: near(arms[1].1, left, &format!("two left {pitch}"));
}
}
ranged_draw_uses_native_charge_curves_and_caps :: proc() {
}
    // rust: for (ticks, stretch) in [
    // rust: (0.0, 1.0),
    // rust: (10.0, 1.0 + 0.2 * 1.25 / 3.0),
    // rust: (20.0, 1.2),
    // rust: (40.0, 1.2),
    // rust: ] {
    // rust: let m = item_pose(false, 0.0, 0.0, ItemPose::Bow { ticks_used: ticks });
    // rust: assert!((m.determinant() - stretch).abs() < 0.000001);
}
    // rust: for duration in [25.0, 20.0, 15.0, 10.0] {
    // rust: let m = item_pose(
    // rust: false,
    // rust: 0.0,
    // rust: 0.0,
    // rust: ItemPose::Crossbow {
    // rust: ticks_used: Some(duration),
    // rust: charge_duration: duration,
    // rust: charged: false,
    // rust: },
    // rust: );
    // rust: assert!((m.determinant() - 1.2).abs() < 0.000001);
}
}
left_handed_ranged_poses_mirror_the_right_hand :: proc() {
}
    // rust: let reflect = glam::Mat4::from_scale(glam::Vec3::new(-1.0, 1.0, 1.0));
    // rust: for pose in [
    // rust: ItemPose::Swing,
    // rust: ItemPose::Bow { ticks_used: 10.0 },
    // rust: ItemPose::Crossbow {
    // rust: ticks_used: Some(10.0),
    // rust: charge_duration: 25.0,
    // rust: charged: false,
    // rust: },
    // rust: ItemPose::Crossbow {
    // rust: ticks_used: None,
    // rust: charge_duration: 25.0,
    // rust: charged: true,
    // rust: },
    // rust: ] {
    // rust: let left = item_pose(true, 0.2, 0.0, pose).to_cols_array();
    // rust: let right = (reflect * item_pose(false, 0.2, 0.0, pose) * reflect).to_cols_array();
    // rust: for (a, b) in left.into_iter().zip(right) {
    // rust: assert!((a - b).abs() < 0.000001);
}
}
}

drawing_bow_has_its_own_pose :: proc() {
}
    // rust: assert_ne!(
    // rust: item_pose(false, 0.0, 0.0, ItemPose::Bow { ticks_used: 10.0 }),
    // rust: item_pose(false, 0.0, 0.0, ItemPose::Swing)
    // rust: );
}
charging_crossbow_has_its_own_pose :: proc() {
}
    // rust: assert_ne!(
    // rust: item_pose(
    // rust: false,
    // rust: 0.0,
    // rust: 0.0,
    // rust: ItemPose::Crossbow {
    // rust: ticks_used: Some(10.0),
    // rust: charge_duration: 25.0,
    // rust: charged: false
}
    // rust: ),
    // rust: item_pose(false, 0.0, 0.0, ItemPose::Swing)
    // rust: );
}
charged_crossbow_is_aimed_while_idle :: proc() {
}
    // rust: assert_ne!(
    // rust: item_pose(
    // rust: false,
    // rust: 0.0,
    // rust: 0.0,
    // rust: ItemPose::Crossbow {
    // rust: ticks_used: None,
    // rust: charge_duration: 25.0,
    // rust: charged: true
}
    // rust: ),
    // rust: item_pose(false, 0.0, 0.0, ItemPose::Swing)
    // rust: );
}
}

    // rust: mod continuous_use_tests {
//     use super::*;
eating_and_throwing_have_use_poses_not_attack_poses :: proc() {
}
    // rust: let swing = item_pose(false, 0.0, 0.3, ItemPose::Swing);
    // rust: assert_ne!(
    // rust: swing,
    // rust: item_pose(
    // rust: false,
    // rust: 0.0,
    // rust: 0.3,
    // rust: ItemPose::Eat {
    // rust: remaining: 10.0,
    // rust: duration: 32.0,
    // rust: partial: 0.5
}
    // rust: )
    // rust: );
    // rust: assert_ne!(
    // rust: swing,
    // rust: item_pose(false, 0.0, 0.3, ItemPose::Trident { ticks_used: 5.0 })
    // rust: );
    // rust: assert_ne!(swing, item_pose(false, 0.0, 0.3, ItemPose::Using));
}
}

    // rust: mod action_result_tests {
//     use super::*;
only_successful_actions_swing_once :: proc() {
}
    // rust: assert!(UseResult::Success { swing: true }.should_swing(2, 2));
    // rust: for result in [
    // rust: UseResult::Fail,
    // rust: UseResult::Pass,
    // rust: UseResult::Success { swing: false },
    // rust: ] {
    // rust: assert!(!result.should_swing(2, 2));
}
    // rust: assert!(!UseResult::Success { swing: true }.should_swing(2, 3));
}
consumption_pose_requires_eat_or_drink_animation :: proc() {
}
//         use horizon_world::consumable::UseAnimation::*;
    // rust: assert_eq!(consumable_animation(&serde_json::json!({})), Eat);
    // rust: assert_eq!(
    // rust: consumable_animation(&serde_json::json!({"animation":"drink"})),
    // rust: Drink
    // rust: );
    // rust: for animation in ["none", "block", "bow", "brush"] {
    // rust: assert_eq!(
    // rust: consumable_animation(&serde_json::json!({"animation":animation})),
    // rust: None
    // rust: );
}
}

    // The hands' sway turns the short way round when the yaw wraps from 179 to -179 degrees (a
    // boat turning its rider), instead of swinging them 36 degrees the long way.
hand_sway_takes_the_short_way_over_the_yaw_wrap :: proc() {
}
    // rust: let mut sway = HandSway::default();
    // rust: sway.tick_wrapped(0.0, 179.0);
    // rust: for _ in 0..20 {
    // rust: sway.tick_wrapped(0.0, 179.0);
}
        // The view is still at 179; one tick later it reads -179 (2 degrees on).
    // rust: sway.tick_wrapped(0.0, -179.0);
    // rust: let [_, y] = sway.rotation(1.0, 0.0, -179.0);
    // rust: assert!(
    // rust: y.abs() < 0.5,
    // rust: "a 2 degree turn sways the hands by under half a degree: {y}"
    // rust: );
}
}
