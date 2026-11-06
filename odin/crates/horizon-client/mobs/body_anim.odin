//! Transpiled from Horizon Rust crate
package horizon_client_body_anim

import "core:fmt"
import "core:mem"
import "core:math"

// `EntityModel.setupAnim` ports for the animals and monsters whose models
// have no species file of their own (goat, polar bear, panda, llama, turtle,
// strider, snow golem, silverfish, endermite, parrot, bee, bat, armadillo,
// axolotl, frog, rabbit, fox). Each reads the render-state values vanilla's
// renderer extracts, as plain structs so the differential harness can set
// them directly; `from_mob` adapters fill them from what a `Mob` tracks.
// use super::{
    // rust: Mob, Species,
    // rust: anim::{Poses, State, quadruped},
    // rust: keyframes::{Animation, AnimationState},
}
// use horizon_core::geometry::trig::Mth;
// use std::{collections::HashMap, f64::consts::PI};

    // rust: pub type Animations = HashMap<String, Animation>;
FPI :: PI 
// `(float) (Math.PI / n)` and friends, evaluated in double like Java.
rad :: proc(v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: v as f32
}
lerp :: proc(a: f32, p: f32, q: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: p + a * (q - p)
}
// `Mth.rotLerpRad`.
rot_lerp_rad :: proc(a: f32, from: f32, to: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut diff = to - from;
    // rust: while diff < -FPI {
    // rust: diff += rad(PI * 2.0);
}
    // rust: while diff >= FPI {
    // rust: diff -= rad(PI * 2.0);
}
    // rust: from + a * diff
}
head_look :: proc(p: ^Poses, s: ^State) {
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
}
// `KeyframeAnimation.apply(AnimationState, ageInTicks)`.
run :: proc(animations: ^Animations, name: string, state: ^AnimationState, s: ^State, p: ^Poses) {
}
    // rust: if let (Some(ms), Some(a)) = (state.millis(s.age), animations.get(name)) {
    // rust: a.apply(ms, 1.0, p);
}
}
walk :: proc(animations: ^Animations, name: string, s: ^State, factor: f32, scale: f32, p: ^Poses) {
}
    // rust: if let Some(a) = animations.get(name) {
    // rust: a.apply_walk(s.pos, s.speed, factor, scale, p);
}
}
adds :: proc(p: ^Poses, part: string, i: uint, v: f32) {
}
    // rust: p.get(part)[i] += v;
}

// ---- goat -----------------------------------------------------------------
Goat :: struct {
    left_horn: bool,
    right_horn: bool,
    ramming_x_head_rot: f32,
}
    // rust: impl Goat {
from_mob :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: left_horn: !m.extra.lost_horns[0],
    // rust: right_horn: !m.extra.lost_horns[1],
    // rust: ramming_x_head_rot: super::goat::ramming_x_head_rot(m),
}
}
}
// `GoatModel` / `BabyGoatModel.setupAnim`.
goat :: proc(p: ^Poses, s: ^State, g: ^Goat) {
}
    // rust: quadruped(p, s);
    // rust: p.visible("left_horn", g.left_horn);
    // rust: p.visible("right_horn", g.right_horn);
    // rust: if g.ramming_x_head_rot != 0.0 {
    // rust: p.xrot("head", g.ramming_x_head_rot);
}
    // rust: if s.baby && g.ramming_x_head_rot == 0.0 {
    // rust: p.xrot("head", rad(PI / 8.0));
}
}

// ---- polar bear -----------------------------------------------------------
// `PolarBearModel.setupAnim`.
polar_bear :: proc(p: ^Poses, s: ^State, stand_scale: f32) {
}
    // rust: quadruped(p, s);
    // rust: let stand = stand_scale * stand_scale;
    // rust: let age_scale = if s.baby { 0.5 } else { 1.0 };
    // rust: adds(p, "body", 3, -(stand * FPI * 0.35));
    // rust: adds(p, "body", 1, stand * age_scale * 2.0);
    // rust: adds(p, "right_front_leg", 1, -(stand * age_scale * 20.0));
    // rust: adds(p, "right_front_leg", 2, stand * age_scale * 4.0);
    // rust: adds(p, "right_front_leg", 3, -(stand * FPI * 0.45));
    // rust: let (y, z) = {
    // rust: let r = p.get("right_front_leg");
    // rust: (r[1], r[2])
}
    // rust: let l = p.get("left_front_leg");
    // rust: l[1] = y;
    // rust: l[2] = z;
    // rust: l[3] -= stand * FPI * 0.45;
    // rust: adds(p, "head", 1, -(stand * 24.0));
    // rust: adds(p, "head", 2, stand * 13.0);
    // rust: adds(p, "head", 3, stand * FPI * 0.15);
}

// ---- panda ----------------------------------------------------------------
Panda :: struct {
    unhappy: bool,
    sneezing: bool,
    sneeze_time: i32,
    eating: bool,
    scared: bool,
    sit_amount: f32,
    lie_on_back_amount: f32,
    roll_amount: f32,
}
// `PandaModel` / `BabyPandaModel.setupAnim`.
panda :: proc(p: ^Poses, s: ^State, st: ^Panda) {
}
    // rust: quadruped(p, s);
    // rust: let age = s.age;
    // rust: if st.unhappy {
    // rust: p.yrot("head", 0.35 * (0.6 * age).msin());
    // rust: p.zrot("head", 0.35 * (0.6 * age).msin());
    // rust: p.xrot("right_front_leg", -0.75 * (0.3 * age).msin());
    // rust: p.xrot("left_front_leg", 0.75 * (0.3 * age).msin());
    // rust: } else {
    // rust: p.zrot("head", 0.0);
}
    // rust: if st.sneezing {
    // rust: if st.sneeze_time < 15 {
    // rust: p.xrot("head", rad(-PI / 4.0) * st.sneeze_time as f32 / 14.0);
    // rust: } else if st.sneeze_time < 20 {
    // rust: let pos = ((st.sneeze_time - 15) / 5) as f32;
    // rust: p.xrot("head", rad(-PI / 4.0) + rad(PI / 4.0) * pos);
}
}
    // rust: if st.sit_amount > 0.0 {
    // rust: let a = st.sit_amount;
    // rust: if s.baby {
    // rust: let x = rot_lerp_rad(a, p.get("body")[3], rad(PI / 18.0));
    // rust: p.xrot("body", x);
    // rust: let v = lerp(a, p.get("body")[2], -1.5);
    // rust: p.get("body")[2] = v;
    // rust: let v = lerp(a, p.get("head")[2], -11.5);
    // rust: p.get("head")[2] = v;
    // rust: let v = lerp(a, p.get("head")[1], 17.5);
    // rust: p.get("head")[1] = v;
    // rust: for (part, z) in [
    // rust: ("right_front_leg", -5.0),
    // rust: ("left_front_leg", -5.0),
    // rust: ("right_hind_leg", 3.0),
    // rust: ("left_hind_leg", 3.0),
    // rust: ] {
    // rust: let v = lerp(a, p.get(part)[2], z);
    // rust: p.get(part)[2] = v;
}
    // rust: } else {
    // rust: let x = rot_lerp_rad(a, p.get("body")[3], 1.740_796_3);
    // rust: p.xrot("body", x);
    // rust: let x = rot_lerp_rad(a, p.get("head")[3], rad(PI / 2.0));
    // rust: p.xrot("head", x);
}
    // rust: p.zrot("right_front_leg", -0.270_796_42);
    // rust: p.zrot("left_front_leg", 0.270_796_42);
    // rust: p.zrot("right_hind_leg", 0.570_796_4);
    // rust: p.zrot("left_hind_leg", -0.570_796_4);
    // rust: if st.eating {
    // rust: p.xrot("head", rad(PI / 2.0) + 0.2 * (age * 0.6).msin());
    // rust: p.xrot("right_front_leg", -0.4 - 0.2 * (age * 0.6).msin());
    // rust: p.xrot("left_front_leg", -0.4 - 0.2 * (age * 0.6).msin());
}
    // rust: if st.scared {
    // rust: p.xrot("head", 2.170_796_4);
    // rust: p.xrot("right_front_leg", -0.9);
    // rust: p.xrot("left_front_leg", -0.9);
}
    // rust: } else {
    // rust: for leg in [
    // rust: "right_hind_leg",
    // rust: "left_hind_leg",
    // rust: "right_front_leg",
    // rust: "left_front_leg",
    // rust: ] {
    // rust: p.zrot(leg, 0.0);
}
}
    // rust: if st.lie_on_back_amount > 0.0 {
    // rust: p.xrot("right_hind_leg", -0.6 * (age * 0.15).msin());
    // rust: p.xrot("left_hind_leg", 0.6 * (age * 0.15).msin());
    // rust: p.xrot("right_front_leg", 0.3 * (age * 0.25).msin());
    // rust: p.xrot("left_front_leg", -0.3 * (age * 0.25).msin());
    // rust: let x = rot_lerp_rad(st.lie_on_back_amount, p.get("head")[3], rad(PI / 2.0));
    // rust: p.xrot("head", x);
}
    // rust: if st.roll_amount > 0.0 {
    // rust: let x = rot_lerp_rad(st.roll_amount, p.get("head")[3], 2.056_194_5);
    // rust: p.xrot("head", x);
    // rust: p.xrot("right_hind_leg", -0.5 * (age * 0.5).msin());
    // rust: p.xrot("left_hind_leg", 0.5 * (age * 0.5).msin());
    // rust: p.xrot("right_front_leg", 0.5 * (age * 0.5).msin());
    // rust: p.xrot("left_front_leg", -0.5 * (age * 0.5).msin());
}
}

// ---- llama ----------------------------------------------------------------
// `LlamaModel.setupAnim`.
llama :: proc(p: ^Poses, s: ^State, has_chest: bool) {
}
    // rust: quadruped(p, s);
    // rust: p.visible("right_chest", has_chest);
    // rust: p.visible("left_chest", has_chest);
}

// ---- turtle ---------------------------------------------------------------
Turtle :: struct {
    on_land: bool,
    laying_egg: bool,
    has_egg: bool,
}
// `TurtleModel` / `AdultTurtleModel.setupAnim`.
turtle :: proc(p: ^Poses, s: ^State, t: ^Turtle) {
}
    // rust: quadruped(p, s);
    // rust: let (pos, speed) = (s.pos, s.speed);
    // rust: if t.on_land {
    // rust: let lay = if t.laying_egg { 4.0 } else { 1.0 };
    // rust: let amp = if t.laying_egg { 2.0 } else { 1.0 };
    // rust: let swing = pos * 5.0;
    // rust: let front = (lay * swing).mcos();
    // rust: let hind = swing.mcos();
    // rust: p.yrot("right_front_leg", -front * 8.0 * speed * amp);
    // rust: p.yrot("left_front_leg", front * 8.0 * speed * amp);
    // rust: p.yrot("right_hind_leg", -hind * 3.0 * speed);
    // rust: p.yrot("left_hind_leg", hind * 3.0 * speed);
    // rust: } else {
    // rust: let scale = 0.5 * speed;
    // rust: let swing = (pos * 0.6662 * 0.6).mcos() * scale;
    // rust: p.xrot("right_hind_leg", swing);
    // rust: p.xrot("left_hind_leg", -swing);
    // rust: p.zrot("right_front_leg", -swing);
    // rust: p.zrot("left_front_leg", swing);
}
    // rust: if !s.baby {
    // rust: p.visible("egg_belly", t.has_egg);
    // rust: if t.has_egg {
    // rust: adds(p, "root", 1, -1.0);
}
}
}

// ---- strider --------------------------------------------------------------
// `StriderModel.animateBristle` with the rotation axis the model adds to.
bristles :: proc(p: ^Poses, age: f32, flow: f32, parts: [string; 3], axis: uint) {
}
    // rust: adds(p, parts[0], axis, flow * 0.6);
    // rust: adds(p, parts[1], axis, flow * 1.2);
    // rust: adds(p, parts[2], axis, flow * 1.3);
    // rust: adds(p, parts[0], axis, 0.1 * (age * 0.4).msin());
    // rust: adds(p, parts[1], axis, 0.1 * (age * 0.2).msin());
    // rust: adds(p, parts[2], axis, 0.05 * (age * -0.4).msin());
}
// `StriderModel` / `AdultStriderModel` / `BabyStriderModel.setupAnim`.
strider :: proc(p: ^Poses, s: ^State, ridden: bool) {
}
    // rust: let pos = s.pos;
    // rust: let speed = s.speed.min(0.25);
    // rust: if !ridden {
    // rust: p.xrot("body", s.x_rot.to_radians());
    // rust: p.yrot("body", s.y_rot.to_radians());
    // rust: } else {
    // rust: p.xrot("body", 0.0);
    // rust: p.yrot("body", 0.0);
}
    // rust: p.zrot("body", 0.1 * (pos * 1.5).msin() * 4.0 * speed);
    // rust: p.xrot("left_leg", (pos * 1.5 * 0.5).msin() * 2.0 * speed);
    // rust: p.xrot("right_leg", (pos * 1.5 * 0.5 + FPI).msin() * 2.0 * speed);
    // rust: p.zrot(
    // rust: "left_leg",
    // rust: rad(PI / 18.0) * (pos * 1.5 * 0.5).mcos() * speed,
    // rust: );
    // rust: p.zrot(
    // rust: "right_leg",
    // rust: rad(PI / 18.0) * (pos * 1.5 * 0.5 + FPI).mcos() * speed,
    // rust: );
    // rust: let flow = (pos * 1.5 + FPI).mcos() * speed;
    // rust: if !s.baby {
    // rust: p.zrot("right_bottom_bristle", -1.221_730_5);
    // rust: p.zrot("right_middle_bristle", -1.134_464);
    // rust: p.zrot("right_top_bristle", -0.872_664_63);
    // rust: p.zrot("left_top_bristle", 0.872_664_63);
    // rust: p.zrot("left_middle_bristle", 1.134_464);
    // rust: p.zrot("left_bottom_bristle", 1.221_730_5);
    // rust: bristles(
    // rust: p,
    // rust: s.age,
    // rust: flow,
    // rust: [
    // rust: "right_top_bristle",
    // rust: "right_middle_bristle",
    // rust: "right_bottom_bristle",
    // rust: ],
    // rust: 5,
    // rust: );
    // rust: bristles(
    // rust: p,
    // rust: s.age,
    // rust: flow,
    // rust: [
    // rust: "left_top_bristle",
    // rust: "left_middle_bristle",
    // rust: "left_bottom_bristle",
    // rust: ],
    // rust: 5,
    // rust: );
    // rust: p.get("body")[1] = 2.0;
    // rust: p.get("body")[1] -= 2.0 * (pos * 1.5).mcos() * 2.0 * speed;
    // rust: p.get("left_leg")[1] = 8.0 + 2.0 * (pos * 1.5 * 0.5 + FPI).msin() * 2.0 * speed;
    // rust: p.get("right_leg")[1] = 8.0 + 2.0 * (pos * 1.5 * 0.5).msin() * 2.0 * speed;
    // rust: } else {
    // rust: p.get("body")[1] = 17.25;
    // rust: p.get("body")[1] -= 1.0 * (pos * 1.5).mcos() * 2.0 * speed;
    // rust: p.get("left_leg")[1] = 20.0 + 2.0 * (pos * 1.5 * 0.5 + FPI).msin() * 2.0 * speed;
    // rust: p.get("right_leg")[1] = 20.0 + 2.0 * (pos * 1.5 * 0.5).msin() * 2.0 * speed;
    // rust: bristles(p, s.age, flow, ["bristle2", "bristle1", "bristle0"], 3);
}
}

// ---- snow golem -----------------------------------------------------------
// `SnowGolemModel.setupAnim`.
snow_golem :: proc(p: ^Poses, s: ^State) {
}
    // rust: p.yrot("head", s.y_rot * rad(PI / 180.0));
    // rust: p.xrot("head", s.x_rot * rad(PI / 180.0));
    // rust: let y = s.y_rot * rad(PI / 180.0) * 0.25;
    // rust: p.yrot("upper_body", y);
    // rust: let (sin, cos) = (y.msin(), y.mcos());
    // rust: p.yrot("left_arm", y);
    // rust: p.yrot("right_arm", y + FPI);
    // rust: p.get("left_arm")[0] = cos * 5.0;
    // rust: p.get("left_arm")[2] = -sin * 5.0;
    // rust: p.get("right_arm")[0] = -cos * 5.0;
    // rust: p.get("right_arm")[2] = sin * 5.0;
}

// ---- silverfish and endermite ---------------------------------------------
// `SilverfishModel.setupAnim`.
silverfish :: proc(p: ^Poses, s: ^State) {
}
    // rust: let mut ys = [0.0f32; 7];
    // rust: let mut xs = [0.0f32; 7];
    // rust: for i in 0..7usize {
    // rust: let d = (i as i32 - 2).abs();
    // rust: let phase = s.age * 0.9 + i as f32 * 0.15 * FPI;
    // rust: ys[i] = phase.mcos() * FPI * 0.05 * (1 + d) as f32;
    // rust: xs[i] = phase.msin() * FPI * 0.2 * d as f32;
    // rust: let name = format!("segment{i}");
    // rust: p.yrot(&name, ys[i]);
    // rust: p.get(&name)[0] = xs[i];
}
    // rust: p.yrot("layer0", ys[2]);
    // rust: p.yrot("layer1", ys[4]);
    // rust: p.get("layer1")[0] = xs[4];
    // rust: p.yrot("layer2", ys[1]);
    // rust: p.get("layer2")[0] = xs[1];
}
// `EndermiteModel.setupAnim`.
endermite :: proc(p: ^Poses, s: ^State) {
}
    // rust: for i in 0..4usize {
    // rust: let d = (i as i32 - 2).abs();
    // rust: let phase = s.age * 0.9 + i as f32 * 0.15 * FPI;
    // rust: let name = format!("segment{i}");
    // rust: p.yrot(&name, phase.mcos() * FPI * 0.01 * (1 + d) as f32);
    // rust: p.get(&name)[0] = phase.msin() * FPI * 0.1 * d as f32;
}
}

// ---- parrot ---------------------------------------------------------------
ParrotPose :: enum {
    Standing,
    Flying,
    OnShoulder,
    Sitting,
    Party,
}
// `ParrotModel.setupAnim`.
parrot :: proc(p: ^Poses, s: ^State, pose: ParrotPose, flap_angle: f32) {
}
//     use ParrotPose as P;
    // rust: match pose {
    // rust: P::Flying => {
    // rust: adds(p, "left_leg", 3, rad(PI * 2.0 / 9.0));
    // rust: adds(p, "right_leg", 3, rad(PI * 2.0 / 9.0));
}
    // rust: P::Sitting => {
    // rust: adds(p, "head", 1, 1.9);
    // rust: adds(p, "tail", 3, rad(PI / 6.0));
    // rust: adds(p, "tail", 1, 1.9);
    // rust: adds(p, "body", 1, 1.9);
    // rust: p.zrot("left_wing", -0.0873);
    // rust: adds(p, "left_wing", 1, 1.9);
    // rust: p.zrot("right_wing", 0.0873);
    // rust: adds(p, "right_wing", 1, 1.9);
    // rust: adds(p, "left_leg", 1, 1.9);
    // rust: adds(p, "right_leg", 1, 1.9);
    // rust: adds(p, "left_leg", 3, rad(PI / 2.0));
    // rust: adds(p, "right_leg", 3, rad(PI / 2.0));
}
    // rust: P::Party => {
    // rust: p.zrot("left_leg", rad(-PI / 9.0));
    // rust: p.zrot("right_leg", rad(PI / 9.0));
}
    // rust: _ => {}
}
    // rust: head_look(p, s);
    // rust: let flutter = |p: &mut Poses| {
    // rust: let bob = flap_angle * 0.3;
    // rust: adds(p, "head", 1, bob);
    // rust: adds(p, "tail", 3, (s.pos * 0.6662).mcos() * 0.3 * s.speed);
    // rust: adds(p, "tail", 1, bob);
    // rust: adds(p, "body", 1, bob);
    // rust: p.zrot("left_wing", -0.0873 - flap_angle);
    // rust: adds(p, "left_wing", 1, bob);
    // rust: p.zrot("right_wing", 0.0873 + flap_angle);
    // rust: adds(p, "right_wing", 1, bob);
    // rust: adds(p, "left_leg", 1, bob);
    // rust: adds(p, "right_leg", 1, bob);
}
    // rust: match pose {
    // rust: P::Standing => {
    // rust: adds(p, "left_leg", 3, (s.pos * 0.6662).mcos() * 1.4 * s.speed);
    // rust: adds(
    // rust: p,
    // rust: "right_leg",
    // rust: 3,
    // rust: (s.pos * 0.6662 + FPI).mcos() * 1.4 * s.speed,
    // rust: );
    // rust: flutter(p);
}
    // rust: P::Flying | P::OnShoulder => flutter(p),
    // rust: P::Sitting => {}
    // rust: P::Party => {
    // rust: let (x, y) = (s.age.mcos(), s.age.msin());
    // rust: adds(p, "head", 0, x);
    // rust: adds(p, "head", 1, y);
    // rust: p.xrot("head", 0.0);
    // rust: p.yrot("head", 0.0);
    // rust: p.zrot("head", s.age.msin() * 0.4);
    // rust: adds(p, "body", 0, x);
    // rust: adds(p, "body", 1, y);
    // rust: p.zrot("left_wing", -0.0873 - flap_angle);
    // rust: adds(p, "left_wing", 0, x);
    // rust: adds(p, "left_wing", 1, y);
    // rust: p.zrot("right_wing", 0.0873 + flap_angle);
    // rust: adds(p, "right_wing", 0, x);
    // rust: adds(p, "right_wing", 1, y);
    // rust: adds(p, "tail", 0, x);
    // rust: adds(p, "tail", 1, y);
}
}
}

// ---- bee ------------------------------------------------------------------
Bee :: struct {
    has_stinger: bool,
    on_ground: bool,
    angry: bool,
    roll_amount: f32,
}
// `BeeModel` / `AdultBeeModel.setupAnim`.
bee :: proc(p: ^Poses, s: ^State, b: ^Bee) {
}
    // rust: p.visible("stinger", b.has_stinger);
    // rust: let age = s.age;
    // rust: if !b.on_ground {
    // rust: let speed = age * 120.32113 * rad(PI / 180.0);
    // rust: p.yrot("right_wing", 0.0);
    // rust: p.zrot("right_wing", speed.mcos() * FPI * 0.15);
    // rust: let (x, y, z) = {
    // rust: let r = p.get("right_wing");
    // rust: (r[3], r[4], r[5])
}
    // rust: p.xrot("left_wing", x);
    // rust: p.yrot("left_wing", y);
    // rust: p.zrot("left_wing", -z);
    // rust: p.xrot("front_legs", rad(PI / 4.0));
    // rust: p.xrot("middle_legs", rad(PI / 4.0));
    // rust: p.xrot("back_legs", rad(PI / 4.0));
}
    // rust: if !b.angry && !b.on_ground {
    // rust: let speed = (age * 0.18).mcos();
    // rust: p.xrot("bone", 0.1 + speed * FPI * 0.025);
    // rust: adds(p, "bone", 1, -((age * 0.18).mcos() * 0.9));
    // rust: p.xrot("front_legs", -speed * FPI * 0.1 + rad(PI / 8.0));
    // rust: p.xrot("back_legs", -speed * FPI * 0.05 + rad(PI / 4.0));
    // rust: if !s.baby {
    // rust: p.xrot("left_antenna", speed * FPI * 0.03);
    // rust: p.xrot("right_antenna", speed * FPI * 0.03);
}
}
    // rust: if b.roll_amount > 0.0 {
    // rust: let x = rot_lerp_rad(b.roll_amount, p.get("bone")[3], 3.091_592_8);
    // rust: p.xrot("bone", x);
}
}

// ---- bat ------------------------------------------------------------------
// `BatModel.setupAnim`.
    // rust: pub fn bat(
    // rust: p: &mut Poses,
    // rust: s: &State,
    // rust: resting: bool,
    // rust: fly: &AnimationState,
    // rust: rest: &AnimationState,
    // rust: a: &Animations,
    // rust: ) {
    // rust: if resting {
    // rust: p.yrot("head", s.y_rot * rad(PI / 180.0));
}
    // rust: run(a, "BatAnimation.BAT_FLYING", fly, s, p);
    // rust: run(a, "BatAnimation.BAT_RESTING", rest, s, p);
}

// ---- armadillo ------------------------------------------------------------
Armadillo :: struct {
    hiding_in_shell: bool,
    roll_out: AnimationState,
    roll_up: AnimationState,
    peek: AnimationState,
}
// `ArmadilloModel.setupAnim`.
armadillo :: proc(p: ^Poses, s: ^State, st: ^Armadillo, a: ^Animations) {
}
    // rust: if st.hiding_in_shell {
    // rust: p.skip_draw("body");
    // rust: p.visible("left_hind_leg", false);
    // rust: p.visible("right_hind_leg", false);
    // rust: p.visible("tail", false);
    // rust: } else {
    // rust: p.visible("cube", false);
    // rust: p.xrot("head", s.x_rot.clamp(-22.5, 25.0) * rad(PI / 180.0));
    // rust: p.yrot("head", s.y_rot.clamp(-32.5, 32.5) * rad(PI / 180.0));
    // rust: let prefix = if s.baby {
    // rust: "BabyArmadilloAnimation.ARMADILLO_BABY_"
    // rust: } else {
    // rust: "ArmadilloAnimation.ARMADILLO_"
}
    // rust: walk(a, &format!("{prefix}WALK"), s, 16.5, 2.5, p);
}
    // rust: let prefix = if s.baby {
    // rust: "BabyArmadilloAnimation.ARMADILLO_BABY_"
    // rust: } else {
    // rust: "ArmadilloAnimation.ARMADILLO_"
}
    // rust: run(a, &format!("{prefix}ROLL_OUT"), &st.roll_out, s, p);
    // rust: run(a, &format!("{prefix}ROLL_UP"), &st.roll_up, s, p);
    // rust: run(a, &format!("{prefix}PEEK"), &st.peek, s, p);
}

// ---- axolotl --------------------------------------------------------------
Axolotl :: struct {
    playing_dead: f32,
    in_water: f32,
    on_ground: f32,
    moving: f32,
    swim: AnimationState,
    walk: AnimationState,
    idle_on_ground: AnimationState,
    idle_underwater_on_ground: AnimationState,
    idle_underwater: AnimationState,
    play_dead: AnimationState,
}
// `AdultAxolotlModel` / `BabyAxolotlModel.setupAnim`.
axolotl :: proc(p: ^Poses, s: ^State, x: ^Axolotl, a: ^Animations) {
}
    // rust: if s.baby {
    // rust: if x.walk.started.is_some() {
    // rust: walk(
    // rust: a,
    // rust: "BabyAxolotlAnimation.AXOLOTL_WALK_FLOOR",
    // rust: s,
    // rust: 15.0,
    // rust: 30.0,
    // rust: p,
    // rust: );
}
    // rust: run(a, "BabyAxolotlAnimation.BABY_AXOLOTL_SWIM", &x.swim, s, p);
    // rust: run(
    // rust: a,
    // rust: "BabyAxolotlAnimation.WALK_FLOOR_UNDERWATER",
            // The model reads `walkAnimationState` again here, not the
            // underwater state the renderer also copies.
    // rust: &x.walk,
    // rust: s,
    // rust: p,
    // rust: );
    // rust: run(
    // rust: a,
    // rust: "BabyAxolotlAnimation.BABY_AXOLOTL_IDLE_FLOOR",
    // rust: &x.idle_on_ground,
    // rust: s,
    // rust: p,
    // rust: );
    // rust: run(
    // rust: a,
    // rust: "BabyAxolotlAnimation.IDLE_UNDERWATER",
    // rust: &x.idle_underwater,
    // rust: s,
    // rust: p,
    // rust: );
    // rust: run(
    // rust: a,
    // rust: "BabyAxolotlAnimation.IDLE_FLOOR_UNDERWATER",
    // rust: &x.idle_underwater_on_ground,
    // rust: s,
    // rust: p,
    // rust: );
    // rust: run(
    // rust: a,
    // rust: "BabyAxolotlAnimation.BABY_AXOLOTL_PLAY_DEAD",
    // rust: &x.play_dead,
    // rust: s,
    // rust: p,
    // rust: );
    // rust: return;
}
    // rust: let not_moving = 1.0 - x.moving;
    // rust: let mirrored = 1.0 - x.on_ground.min(x.moving);
    // rust: adds(p, "body", 4, s.y_rot * rad(PI / 180.0));
    // rust: axolotl_swim(p, s.age, s.x_rot, x.moving.min(x.in_water));
    // rust: axolotl_hover(p, s.age, not_moving.min(x.in_water));
    // rust: axolotl_crawl(p, s.age, x.moving.min(x.on_ground));
    // rust: axolotl_lay(p, s.age, not_moving.min(x.on_ground));
    // rust: axolotl_dead(p, x.playing_dead);
    // rust: if mirrored > 1.0e-5 {
    // rust: let l_hind = [
    // rust: p.get("left_hind_leg")[3],
    // rust: p.get("left_hind_leg")[4],
    // rust: p.get("left_hind_leg")[5],
    // rust: ];
    // rust: let l_front = [
    // rust: p.get("left_front_leg")[3],
    // rust: p.get("left_front_leg")[4],
    // rust: p.get("left_front_leg")[5],
    // rust: ];
    // rust: for (part, l) in [("right_hind_leg", l_hind), ("right_front_leg", l_front)] {
    // rust: let r = p.get(part);
    // rust: r[3] += l[0] * mirrored;
    // rust: r[4] += -l[1] * mirrored;
    // rust: r[5] += -l[2] * mirrored;
}
}
}
axolotl_lay :: proc(p: ^Poses, age: f32, factor: f32) {
}
    // rust: if factor <= 1.0e-5 {
    // rust: return;
}
    // rust: let sway = age * 0.09;
    // rust: let sine = sway.msin();
    // rust: let cosine = sway.mcos();
    // rust: let movement = sine * sine - 2.0 * sine;
    // rust: let movement2 = cosine * cosine - 3.0 * sine;
    // rust: adds(p, "head", 3, -0.09 * movement * factor);
    // rust: adds(p, "head", 5, -0.2 * factor);
    // rust: adds(p, "tail", 4, (-0.1 + 0.1 * movement) * factor);
    // rust: let gill = (0.6 + 0.05 * movement2) * factor;
    // rust: adds(p, "top_gills", 3, gill);
    // rust: adds(p, "left_gills", 4, -gill);
    // rust: adds(p, "right_gills", 4, gill);
    // rust: adds(p, "left_hind_leg", 3, 1.1 * factor);
    // rust: adds(p, "left_hind_leg", 4, 1.0 * factor);
    // rust: adds(p, "left_front_leg", 3, 0.8 * factor);
    // rust: adds(p, "left_front_leg", 4, 2.3 * factor);
    // rust: adds(p, "left_front_leg", 5, -0.5 * factor);
}
axolotl_crawl :: proc(p: ^Poses, age: f32, factor: f32) {
}
    // rust: if factor <= 1.0e-5 {
    // rust: return;
}
    // rust: let sway = age * 0.11;
    // rust: let cosine = sway.mcos();
    // rust: let hind_y = (cosine * cosine - 2.0 * cosine) / 5.0;
    // rust: let front_y = 0.7 * cosine;
    // rust: let head_tail = 0.09 * cosine * factor;
    // rust: adds(p, "head", 4, head_tail);
    // rust: adds(p, "tail", 4, head_tail);
    // rust: let gill = (0.6 - 0.08 * (cosine * cosine + 2.0 * sway.msin())) * factor;
    // rust: adds(p, "top_gills", 3, gill);
    // rust: adds(p, "left_gills", 4, -gill);
    // rust: adds(p, "right_gills", 4, gill);
    // rust: let hind_x = 0.942_477_9 * factor;
    // rust: let front_x = 1.099_557_4 * factor;
    // rust: adds(p, "left_hind_leg", 3, hind_x);
    // rust: adds(p, "left_hind_leg", 4, (1.5 - hind_y) * factor);
    // rust: adds(p, "left_hind_leg", 5, -0.1 * factor);
    // rust: adds(p, "left_front_leg", 3, front_x);
    // rust: adds(p, "left_front_leg", 4, (rad(PI / 2.0) - front_y) * factor);
    // rust: adds(p, "right_hind_leg", 3, hind_x);
    // rust: adds(p, "right_hind_leg", 4, (-1.0 - hind_y) * factor);
    // rust: adds(p, "right_front_leg", 3, front_x);
    // rust: adds(p, "right_front_leg", 4, (rad(-PI / 2.0) - front_y) * factor);
}
axolotl_hover :: proc(p: ^Poses, age: f32, factor: f32) {
}
    // rust: if factor <= 1.0e-5 {
    // rust: return;
}
    // rust: let sway = age * 0.075;
    // rust: let cosine = sway.mcos();
    // rust: let sine = sway.msin() * 0.15;
    // rust: let body_x = (-0.15 + 0.075 * cosine) * factor;
    // rust: adds(p, "body", 3, body_x);
    // rust: adds(p, "body", 1, -(sine * factor));
    // rust: adds(p, "head", 3, -body_x);
    // rust: adds(p, "top_gills", 3, 0.2 * cosine * factor);
    // rust: let gill_y = (-0.3 * cosine - 0.19) * factor;
    // rust: adds(p, "left_gills", 4, gill_y);
    // rust: adds(p, "right_gills", 4, -gill_y);
    // rust: adds(
    // rust: p,
    // rust: "left_hind_leg",
    // rust: 3,
    // rust: (rad(PI * 3.0 / 4.0) - cosine * 0.11) * factor,
    // rust: );
    // rust: adds(p, "left_hind_leg", 4, 0.471_238_94 * factor);
    // rust: adds(p, "left_hind_leg", 5, 1.727_876_1 * factor);
    // rust: adds(
    // rust: p,
    // rust: "left_front_leg",
    // rust: 3,
    // rust: (rad(PI / 4.0) - cosine * 0.2) * factor,
    // rust: );
    // rust: adds(p, "left_front_leg", 4, 2.042_035 * factor);
    // rust: adds(p, "tail", 4, 0.5 * cosine * factor);
}
axolotl_swim :: proc(p: ^Poses, age: f32, x_rot: f32, factor: f32) {
}
    // rust: if factor <= 1.0e-5 {
    // rust: return;
}
    // rust: let sway = age * 0.33;
    // rust: let sine = sway.msin();
    // rust: let cosine = sway.mcos();
    // rust: let body_sway = 0.13 * sine;
    // rust: adds(p, "body", 3, (x_rot * rad(PI / 180.0) + body_sway) * factor);
    // rust: adds(p, "head", 3, -(body_sway * 1.8 * factor));
    // rust: adds(p, "body", 1, -(0.45 * cosine * factor));
    // rust: adds(p, "top_gills", 3, (-0.5 * sine - 0.8) * factor);
    // rust: let gill_y = (0.3 * sine + 0.9) * factor;
    // rust: adds(p, "left_gills", 4, gill_y);
    // rust: adds(p, "right_gills", 4, -gill_y);
    // rust: let tail = p.get("tail")[4] + 0.3 * (sway * 0.9).mcos() * factor;
    // rust: p.yrot("tail", tail);
    // rust: adds(p, "left_hind_leg", 3, 1.884_955_8 * factor);
    // rust: adds(p, "left_hind_leg", 4, -0.4 * sine * factor);
    // rust: adds(p, "left_hind_leg", 5, rad(PI / 2.0) * factor);
    // rust: adds(p, "left_front_leg", 3, 1.884_955_8 * factor);
    // rust: adds(p, "left_front_leg", 4, (-0.2 * cosine - 0.1) * factor);
    // rust: adds(p, "left_front_leg", 5, rad(PI / 2.0) * factor);
}
axolotl_dead :: proc(p: ^Poses, factor: f32) {
}
    // rust: if factor <= 1.0e-5 {
    // rust: return;
}
    // rust: adds(p, "left_hind_leg", 3, 1.413_716_7 * factor);
    // rust: adds(p, "left_hind_leg", 4, 1.099_557_4 * factor);
    // rust: adds(p, "left_hind_leg", 5, rad(PI / 4.0) * factor);
    // rust: adds(p, "left_front_leg", 3, rad(PI / 4.0) * factor);
    // rust: adds(p, "left_front_leg", 4, 2.042_035 * factor);
    // rust: adds(p, "body", 3, -0.15 * factor);
    // rust: adds(p, "body", 5, 0.35 * factor);
}

// ---- frog -----------------------------------------------------------------
Frog :: struct {
    swimming: bool,
    jump: AnimationState,
    croak: AnimationState,
    tongue: AnimationState,
    swim_idle: AnimationState,
}
// `FrogModel.setupAnim`.
frog :: proc(p: ^Poses, s: ^State, f: ^Frog, a: ^Animations) {
}
    // rust: run(a, "FrogAnimation.FROG_JUMP", &f.jump, s, p);
    // rust: run(a, "FrogAnimation.FROG_CROAK", &f.croak, s, p);
    // rust: run(a, "FrogAnimation.FROG_TONGUE", &f.tongue, s, p);
    // rust: if f.swimming {
    // rust: walk(a, "FrogAnimation.FROG_SWIM", s, 1.0, 2.5, p);
    // rust: } else {
    // rust: walk(a, "FrogAnimation.FROG_WALK", s, 1.5, 2.5, p);
}
    // rust: run(a, "FrogAnimation.FROG_IDLE_WATER", &f.swim_idle, s, p);
    // rust: p.visible("croaking_body", f.croak.started.is_some());
}

// ---- rabbit ---------------------------------------------------------------
// `RabbitModel.setupAnim`.
    // rust: pub fn rabbit(
    // rust: p: &mut Poses,
    // rust: s: &State,
    // rust: hop: &AnimationState,
    // rust: tilt: &AnimationState,
    // rust: a: &Animations,
    // rust: ) {
    // rust: if tilt.started.is_none() {
    // rust: p.yrot("head", s.y_rot * rad(PI / 180.0));
    // rust: p.xrot("head", s.x_rot * rad(PI / 180.0));
}
    // rust: let prefix = if s.baby {
    // rust: "BabyRabbitAnimation."
    // rust: } else {
    // rust: "RabbitAnimation."
}
    // rust: run(a, &format!("{prefix}HOP"), hop, s, p);
    // rust: run(a, &format!("{prefix}IDLE_HEAD_TILT"), tilt, s, p);
}

// ---- fox ------------------------------------------------------------------
Fox :: struct {
    crouching: bool,
    sleeping: bool,
    sitting: bool,
    pouncing: bool,
    faceplanted: bool,
    head_roll_angle: f32,
    crouch_amount: f32,
    // `FoxModel.legMotionPos` after this frame's `+= 0.67`.
    leg_motion_pos: f32,
}
// `FoxModel` / `AdultFoxModel` / `BabyFoxModel.setupAnim`.
fox :: proc(p: ^Poses, s: ^State, f: ^Fox, a: ^Animations) {
}
    // rust: let baby = s.baby;
    // rust: let age_scale = if baby { 0.5 } else { 1.0 };
    // setWalkingPose
    // rust: p.zrot("head", f.head_roll_angle);
    // rust: if baby {
    // rust: walk(a, "FoxBabyAnimation.FOX_BABY_WALK", s, 1.0, 2.5, p);
    // rust: } else {
    // rust: let (pos, speed) = (s.pos, s.speed);
    // rust: p.xrot("right_hind_leg", (pos * 0.6662).mcos() * 1.4 * speed);
    // rust: p.xrot("left_hind_leg", (pos * 0.6662 + FPI).mcos() * 1.4 * speed);
    // rust: p.xrot("right_front_leg", (pos * 0.6662 + FPI).mcos() * 1.4 * speed);
    // rust: p.xrot("left_front_leg", (pos * 0.6662).mcos() * 1.4 * speed);
}
    // rust: if f.crouching {
        // setCrouchingPose
    // rust: adds(p, "body", 3, 0.104_719_76);
    // rust: adds(p, "head", 1, f.crouch_amount * age_scale);
    // rust: let wiggle = s.age.mcos() * 0.05;
    // rust: p.yrot("body", wiggle);
    // rust: p.zrot("right_hind_leg", wiggle);
    // rust: p.zrot("left_hind_leg", wiggle);
    // rust: p.zrot("right_front_leg", wiggle / 2.0);
    // rust: p.zrot("left_front_leg", wiggle / 2.0);
    // rust: if baby {
    // rust: adds(p, "body", 1, f.crouch_amount / 6.0);
    // rust: } else {
    // rust: adds(p, "body", 1, f.crouch_amount);
}
    // rust: } else if f.sleeping {
        // setSleepingPose
    // rust: for leg in [
    // rust: "right_hind_leg",
    // rust: "left_hind_leg",
    // rust: "right_front_leg",
    // rust: "left_front_leg",
    // rust: ] {
    // rust: p.visible(leg, false);
}
    // rust: if baby {
    // rust: p.zrot("body", rad(-PI / 2.0));
    // rust: p.xrot("body", rad(-PI / 18.0));
    // rust: adds(p, "body", 1, 1.5);
    // rust: adds(p, "body", 2, -1.5);
    // rust: adds(p, "body", 0, -1.5);
    // rust: p.xrot("tail", rad(-PI * 5.0 / 6.0));
    // rust: p.xrot("tail", -2.181_661_6);
    // rust: adds(p, "tail", 0, -0.7);
    // rust: adds(p, "tail", 2, 0.6);
    // rust: adds(p, "tail", 1, 0.9);
    // rust: adds(p, "head", 0, -2.0);
    // rust: adds(p, "head", 1, 2.8);
    // rust: adds(p, "head", 2, -4.0);
    // rust: p.yrot("head", rad(-PI * 2.0 / 3.0));
    // rust: p.zrot("head", 0.0);
    // rust: } else {
    // rust: p.zrot("body", rad(-PI / 2.0));
    // rust: adds(p, "body", 1, 5.0);
    // rust: p.xrot("tail", rad(-PI * 5.0 / 6.0));
    // rust: adds(p, "head", 0, 2.0);
    // rust: adds(p, "head", 1, 2.99);
    // rust: p.yrot("head", rad(-PI * 2.0 / 3.0));
    // rust: p.zrot("head", 0.0);
}
    // rust: } else if f.sitting {
        // setSittingPose
    // rust: p.xrot("head", 0.0);
    // rust: p.yrot("head", 0.0);
    // rust: if baby {
    // rust: p.xrot("body", -0.959_931);
    // rust: adds(p, "body", 2, -(4.5 * age_scale));
    // rust: adds(p, "body", 1, 3.0 * age_scale);
    // rust: adds(p, "tail", 1, -0.6);
    // rust: adds(p, "tail", 2, -(2.0 * age_scale));
    // rust: p.xrot("tail", 0.959_931_14);
    // rust: adds(p, "head", 1, -0.75);
    // rust: adds(p, "head", 2, 0.0);
    // rust: p.xrot("right_front_leg", rad(-PI / 12.0));
    // rust: p.xrot("left_front_leg", rad(-PI / 12.0));
    // rust: adds(p, "right_front_leg", 2, -1.5);
    // rust: adds(p, "left_front_leg", 2, -1.5);
    // rust: adds(p, "right_front_leg", 0, 0.01);
    // rust: adds(p, "left_front_leg", 0, -0.01);
    // rust: adds(p, "right_hind_leg", 2, -3.75);
    // rust: adds(p, "left_hind_leg", 2, -3.75);
    // rust: adds(p, "right_hind_leg", 0, 0.01);
    // rust: adds(p, "left_hind_leg", 0, -0.01);
    // rust: } else {
    // rust: p.xrot("body", rad(PI / 6.0));
    // rust: adds(p, "body", 1, -7.0);
    // rust: adds(p, "body", 2, 3.0);
    // rust: p.xrot("tail", rad(PI / 4.0));
    // rust: adds(p, "head", 1, -6.5);
    // rust: adds(p, "head", 2, 2.75);
    // rust: p.xrot("right_front_leg", rad(-PI / 12.0));
    // rust: p.xrot("left_front_leg", rad(-PI / 12.0));
    // rust: p.xrot("right_hind_leg", rad(-PI * 5.0 / 12.0));
    // rust: adds(p, "right_hind_leg", 1, 4.0);
    // rust: adds(p, "right_hind_leg", 2, -0.25);
    // rust: p.xrot("left_hind_leg", rad(-PI * 5.0 / 12.0));
    // rust: adds(p, "left_hind_leg", 1, 4.0);
    // rust: adds(p, "left_hind_leg", 2, -0.25);
    // rust: adds(p, "tail", 2, -1.0);
}
}
    // rust: if f.pouncing && !baby {
    // rust: let crouch = f.crouch_amount / 2.0;
    // rust: adds(p, "body", 1, -crouch);
    // rust: adds(p, "head", 1, -crouch);
}
    // rust: if !f.sleeping && !f.faceplanted && !f.crouching {
    // rust: p.xrot("head", s.x_rot * rad(PI / 180.0));
    // rust: p.yrot("head", s.y_rot * rad(PI / 180.0));
}
    // rust: if f.sleeping {
    // rust: p.xrot("head", 0.0);
    // rust: p.yrot("head", rad(-PI * 2.0 / 3.0));
    // rust: p.zrot("head", (s.age * 0.027).mcos() / 22.0);
}
    // rust: if f.faceplanted {
    // rust: let m = f.leg_motion_pos;
    // rust: p.xrot("right_hind_leg", (m * 0.4662).mcos() * 0.1);
    // rust: p.xrot("left_hind_leg", (m * 0.4662 + FPI).mcos() * 0.1);
    // rust: p.xrot("right_front_leg", (m * 0.4662 + FPI).mcos() * 0.1);
    // rust: p.xrot("left_front_leg", (m * 0.4662).mcos() * 0.1);
}
}

// ---- adapters ---------------------------------------------------------------
// Dispatch for the species ported here; `false` when `m` is not one of them.
anim :: proc(m: ^Mob, s: ^State, p: ^Poses, a: ^Animations) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let st = &m.anim.states;
    // rust: match m.species() {
    // rust: Species::Goat => goat(p, s, &Goat::from_mob(m)),
    // rust: Species::PolarBear => polar_bear(p, s, super::polar_bear::standing_scale(m, s.partial)),
    // rust: Species::Panda => panda(p, s, &super::panda::pose(m, s.partial)),
    // rust: Species::Llama | Species::TraderLlama => {
    // rust: llama(p, s, m.extra.chested && !s.baby);
}
    // rust: Species::Turtle => turtle(
    // rust: p,
    // rust: s,
    // rust: &Turtle {
    // rust: on_land: !m.fluids.in_water && m.on_ground,
    // rust: laying_egg: m.extra.flag2,
    // rust: has_egg: m.extra.flag,
    // rust: },
    // rust: ),
    // rust: Species::Strider => strider(p, s, m.rider.is_some()),
    // rust: Species::SnowGolem => snow_golem(p, s),
    // rust: Species::Silverfish => silverfish(p, s),
    // rust: Species::Endermite => endermite(p, s),
    // rust: Species::Parrot => {
    // rust: let flap = m.anim.flap_o + (m.anim.flap - m.anim.flap_o) * s.partial;
    // rust: let speed = m.anim.flap_speed_o + (m.anim.flap_speed - m.anim.flap_speed_o) * s.partial;
            // `Parrot.isFlying` is `!onGround`, in water too.
    // rust: let pose = if m.extra.party_jukebox.is_some() {
    // rust: ParrotPose::Party
    // rust: } else if m.extra.sitting {
    // rust: ParrotPose::Sitting
    // rust: } else if !m.on_ground {
    // rust: ParrotPose::Flying
    // rust: } else {
    // rust: ParrotPose::Standing
}
    // rust: parrot(p, s, pose, (flap.msin() + 1.0) * speed);
}
    // rust: Species::Bee => bee(
    // rust: p,
    // rust: s,
    // rust: &Bee {
    // rust: has_stinger: !super::bee::has_stung(m),
    // rust: on_ground: m.on_ground && m.velocity.length_squared() < 1.0e-7,
                // The anger end time is cleared the tick after it passes.
    // rust: angry: super::bee::get(m).is_some_and(|b| b.anger_end > 0),
                // Bee.getRollAmount(partialTick).
    // rust: roll_amount: super::bee::get(m)
    // rust: .map_or(0.0, |b| b.roll_o + (b.roll - b.roll_o) * s.partial),
    // rust: },
    // rust: ),
    // rust: Species::Bat => bat(p, s, m.extra.flag, &st[0], &st[1], a),
    // rust: Species::Armadillo => armadillo(
    // rust: p,
    // rust: s,
    // rust: &Armadillo {
    // rust: hiding_in_shell: super::armadillo::hiding_in_shell(m),
    // rust: roll_out: st[0],
    // rust: roll_up: st[1],
    // rust: peek: st[2],
    // rust: },
    // rust: a,
    // rust: ),
    // rust: Species::Axolotl => axolotl(p, s, &Axolotl::from_mob(m, s.partial), a),
    // rust: Species::Frog => frog(
    // rust: p,
    // rust: s,
    // rust: &Frog {
    // rust: swimming: m.fluids.in_water,
    // rust: jump: st[0],
    // rust: croak: st[1],
    // rust: tongue: st[2],
    // rust: swim_idle: st[3],
    // rust: },
    // rust: a,
    // rust: ),
    // rust: Species::Rabbit => rabbit(p, s, &st[0], &st[1], a),
    // rust: Species::Fox => fox(p, s, &super::fox::pose(m, s.partial), a),
    // rust: _ => return false,
}
    // rust: true
}
    // rust: impl Axolotl {
from_mob :: proc(m: ^Mob, partial: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let x = &m.extra.axolotl;
    // rust: Self {
    // rust: playing_dead: x.factor(0, partial),
    // rust: in_water: x.factor(1, partial),
    // rust: on_ground: x.factor(2, partial),
    // rust: moving: x.factor(3, partial),
            // Native baby model deliberately reads walkAnimationState, not its underwater counterpart.
    // rust: walk: x.states[0],
    // rust: swim: x.states[1],
    // rust: idle_on_ground: x.states[3],
    // rust: idle_underwater: x.states[4],
    // rust: idle_underwater_on_ground: x.states[5],
    // rust: play_dead: x.states[6],
}
}
}
