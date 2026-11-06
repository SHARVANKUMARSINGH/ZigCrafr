//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_emote
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Emotes: an item of the `emote` slot whose `emote` block keyframes the player model's bones over
//! time (rotations in degrees, offsets in pixels), one-shot or looping, with optional props: the
//! item's own parts, boxes riding a bone like any item's, which the keyframes may move too.
//!
//! Time is in game ticks from the emote's start. Between two keys a channel eases as the first key
//! says (`smooth`: a Catmull-Rom curve through the neighbouring keys, the default; `linear`;
//! `in_out`; `step`); a loop wraps from its last key to its first at `length`. The emote fades in
//! over `blend` ticks from the pose the player had, and a one-shot fades out over its last `blend`.

// use crate::item::{Bone, Error};
// use crate::pose::Pose;
// use glam::{EulerRot, Quat, Vec3};
// use serde::Deserialize;

/// The longest emote (ticks): a one-shot's length, a loop's period.
pub const MAX_LENGTH: f32 = 200.0;
/// Tracks per emote: the six bones, the root, and props.
pub const MAX_TRACKS: usize = 16;
/// Keys per track, and in all.
pub const MAX_KEYS: usize = 32;
pub const MAX_ALL_KEYS: usize = 192;
/// How far a key may turn a bone or prop about one axis (degrees); the root may turn twice round.
pub const MAX_TURN: f32 = 360.0;
pub const MAX_ROOT_TURN: f32 = 720.0;
/// How far a key may move a bone or prop from its rest (pixels), and the whole body (a hop of a
/// block at most).
pub const MAX_MOVE: f32 = 8.0;
pub const MAX_ROOT_MOVE: f32 = 16.0;

/// The player model's bones an emote poses, in the order `Emote::pose_body` takes them.
    // rust: pub const BODY: [Bone; 6] = [
    // rust: Bone::Head,
    // rust: Bone::Body,
    // rust: Bone::RightArm,
    // rust: Bone::LeftArm,
    // rust: Bone::RightLeg,
    // rust: Bone::LeftLeg,
    // rust: ];

/// The root's pivot: the feet, 24 pixels below the neck in the player model's space (y down).
pub const FEET: Vec3 = Vec3::new(0.0, 24.0, 0.0);

/// What a track moves.
pub const Target = enum {
    Bone(Bone),
    /// The whole body, about the feet.
    Root,
    /// One of the item's own parts, on top of its rest pose.
    Prop(String),
};

pub const Ease = enum {
    Smooth,
    Linear,
    InOut,
    Step,
};

/// A key: where its track is at `t` (rotation in radians).
pub const Key = struct {
    t: f32,
    offset: [f32,
    rotation: [f32,
    scale: f32,
    ease: Ease,
};

pub const Track = struct {
    target: Target,
    keys: std.ArrayList(Key),
};

/// A checked emote.
pub const Emote = struct {
    length: f32,
    looping: bool,
    blend: f32,
    tracks: std.ArrayList(Track),
};

/// Where a track is at a time: an offset (pixels), a rotation (radians), a scale.
pub const Sample = struct {
    offset: [f32,
    rotation: [f32,
    scale: f32,
};

    // rust: pub(crate) struct EmoteFile {
    // rust: length: f32,
    // rust: looping: bool,
    // rust: blend: f32,
    // rust: tracks: Vec<TrackFile>,
}

pub fn four() f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 4.0
}

pub const TrackFile = struct {
    part: []const u8,
    keys: std.ArrayList(KeyFile),
};

pub const KeyFile = struct {
    t: f32,
    offset: [f32,
    /// Degrees.
    rotation: [f32,
    scale: ?f32,
    ease: Ease,
};

pub fn invalid(text: impl Into<[]const u8>) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Error::Invalid(text.into())
}

pub fn bone_named(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BODY.into_iter().find(|b| b.part() == name)
}

    // rust: impl EmoteFile {
    /// Checks the emote; `props` names the item's own parts.
    // rust: pub(crate) fn check(self, props: &[String]) -> Result<Emote, Error> {
    // rust: let numbers = [self.length, self.blend];
    // rust: if !numbers.iter().all(|v| v.is_finite()) {
    // rust: return Err(invalid("the emote's length is not a number"));
}
    // rust: if !(4.0..=MAX_LENGTH).contains(&self.length) {
    // rust: return Err(invalid(format!("an emote lasts 4 to {MAX_LENGTH} ticks")));
}
    // rust: if !(0.0..=self.length / 2.0).contains(&self.blend) {
    // rust: return Err(invalid("an emote's blend is at most half its length"));
}
    // rust: if self.tracks.is_empty() || self.tracks.len() > MAX_TRACKS {
    // rust: return Err(invalid(format!("an emote has 1 to {MAX_TRACKS} tracks")));
}
    // rust: let all: usize = self.tracks.iter().map(|t| t.keys.len()).sum();
    // rust: if all > MAX_ALL_KEYS {
    // rust: return Err(invalid(format!("{all} keys, at most {MAX_ALL_KEYS}")));
}
    // rust: let mut tracks: Vec<Track> = Vec::new();
    // rust: for file in self.tracks {
    // rust: let target = match file.part.as_str() {
    // rust: "root" => Target::Root,
    // rust: name => match bone_named(name) {
    // rust: Some(bone) => Target::Bone(bone),
    // rust: None if props.iter().any(|p| p == name) => Target::Prop(name.to_owned()),
    // rust: None => return Err(invalid(format!("an emote moves no part {name:?}"))),
    // rust: },
}
    // rust: if tracks.iter().any(|t| t.target == target) {
    // rust: return Err(invalid(format!("two tracks move {:?}", file.part)));
}
    // rust: if file.keys.is_empty() || file.keys.len() > MAX_KEYS {
    // rust: return Err(invalid(format!("a track has 1 to {MAX_KEYS} keys")));
}
    // rust: let (turn, reach) = match target {
    // rust: Target::Root => (MAX_ROOT_TURN, MAX_ROOT_MOVE),
    // rust: _ => (MAX_TURN, MAX_MOVE),
}
    // rust: let mut keys = Vec::with_capacity(file.keys.len());
    // rust: for k in file.keys {
    // rust: let scale = k.scale.unwrap_or(1.0);
    // rust: let values = [k.t, scale].into_iter().chain(k.offset).chain(k.rotation);
    // rust: if !values.into_iter().all(f32::is_finite) {
    // rust: return Err(invalid("an emote's key is not a number"));
}
    // rust: if keys.last().is_some_and(|last: &Key| k.t <= last.t)
    // rust: || !(0.0..=self.length).contains(&k.t)
    // rust: {
    // rust: return Err(invalid("keys go forward in time within the emote"));
}
    // rust: if k.rotation.iter().any(|r| r.abs() > turn)
    // rust: || k.offset.iter().any(|o| o.abs() > reach)
    // rust: {
    // rust: return Err(invalid(format!(
    // rust: "a key of {:?} turns or moves too far",
    // rust: file.part
    // rust: )));
}
                // Only a prop grows or shrinks (it may pop in from nothing).
    // rust: if k.scale.is_some() && !matches!(target, Target::Prop(_))
    // rust: || !(0.0..=2.0).contains(&scale)
    // rust: {
    // rust: return Err(invalid("only a prop's key scales, from 0 to 2"));
}
    // rust: keys.push(Key {
    // rust: t: k.t,
    // rust: offset: k.offset,
    // rust: rotation: k.rotation.map(f32::to_radians),
    // rust: scale,
    // rust: ease: k.ease,
    // rust: });
}
    // rust: tracks.push(Track { target, keys });
}
    // rust: Ok(Emote {
    // rust: length: self.length,
    // rust: looping: self.looping,
    // rust: blend: self.blend,
    // rust: tracks,
    // rust: })
}
}

/// Catmull-Rom through `p1` to `p2`, `p0` and `p3` their neighbours.
pub fn catmull(p0: f32, p1: f32, p2: f32, p3: f32, s: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s2 = s * s;
    // rust: 0.5 * (2.0 * p1
    // rust: + (p2 - p0) * s
    // rust: + (2.0 * p0 - 5.0 * p1 + 4.0 * p2 - p3) * s2
    // rust: + (3.0 * p1 - p0 - 3.0 * p2 + p3) * s2 * s)
}

    // rust: impl Track {
    /// The track at `t` ticks into an emote of `length` (wrapped if `looping`).
pub fn sample(self: *Self, t: f32, length: f32, looping: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let keys = &self.keys;
    // rust: let n = keys.len();
    // rust: let at = |k: &Key| Sample {
    // rust: offset: k.offset,
    // rust: rotation: k.rotation,
    // rust: scale: k.scale,
}
    // rust: let t = if looping {
    // rust: t.rem_euclid(length)
    // rust: } else {
    // rust: t.clamp(0.0, length)
}
        // The segment from key i to the next: wrapping round in a loop, held at the ends else.
    // rust: let i = match keys.iter().rposition(|k| k.t <= t) {
    // rust: Some(i) => i,
    // rust: None if looping => n - 1,
    // rust: None => return at(&keys[0]),
}
    // rust: if i == n - 1 && !looping {
    // rust: return at(&keys[i]);
}
    // rust: let next = (i + 1) % n;
    // rust: let (t0, mut t1) = (keys[i].t, keys[next].t);
    // rust: let mut now = t;
    // rust: if next <= i {
    // rust: t1 += length;
    // rust: if now < t0 {
    // rust: now += length;
}
}
    // rust: let span = t1 - t0;
    // rust: let s = if span > 0.0 {
    // rust: ((now - t0) / span).clamp(0.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: let (k0, k1) = (&keys[i], &keys[next]);
    // rust: let neighbour = |j: isize| -> &Key {
    // rust: if looping {
    // rust: &keys[j.rem_euclid(n as isize) as usize]
    // rust: } else {
    // rust: &keys[j.clamp(0, n as isize - 1) as usize]
}
}
    // rust: let (kp, kn) = (neighbour(i as isize - 1), neighbour(i as isize + 2));
    // rust: let mix = |a: f32, b: f32, pa: f32, nb: f32| match k0.ease {
    // rust: Ease::Step => a,
    // rust: Ease::Linear => a + (b - a) * s,
    // rust: Ease::InOut => a + (b - a) * (s * s * (3.0 - 2.0 * s)),
    // rust: Ease::Smooth => catmull(pa, a, b, nb, s),
}
    // rust: let three = |f: fn(&Key) -> [f32; 3]| -> [f32; 3] {
    // rust: let (a, b, p, q) = (f(k0), f(k1), f(kp), f(kn));
    // rust: std::array::from_fn(|c| mix(a[c], b[c], p[c], q[c]))
}
    // rust: Sample {
    // rust: offset: three(|k| k.offset),
    // rust: rotation: three(|k| k.rotation),
    // rust: scale: mix(k0.scale, k1.scale, kp.scale, kn.scale),
}
}
}

/// `smoothstep`, clamped.
pub fn smooth01(x: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = x.clamp(0.0, 1.0);
    // rust: x * x * (3.0 - 2.0 * x)
}

pub fn quat(r: [f32; 3]) Q {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Quat::from_euler(EulerRot::ZYX, r[2], r[1], r[0])
}

    // rust: impl Emote {
    /// How much of the emote shows at `t` ticks in: fading in over `blend`, and out over the last
    /// `blend` of a one-shot. Past a one-shot's end: 0.
pub fn weight(self: *Self, t: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if t < 0.0 || !self.looping && t >= self.length {
    // rust: return 0.0;
}
    // rust: if self.blend <= 0.0 {
    // rust: return 1.0;
}
    // rust: let fade_in = smooth01(t / self.blend);
    // rust: if self.looping {
    // rust: fade_in
    // rust: } else {
    // rust: fade_in.min(smooth01((self.length - t) / self.blend))
}
}

    /// Poses the player model's bones (`BODY`'s order) `t` ticks in: `rest` is the model at
    /// rest, `poses` what its animation made of it, blended toward the emote by `weight` (1: the
    /// emote's own pose). A bone the emote doesn't key keeps its animation; the root moves all
    /// six about the feet.
pub fn pose_body(self: *Self, t: f32, weight: f32, rest: *[Pose; 6], poses: *mut [Pose; 6]) void {
}
    // rust: if weight <= 0.0 {
    // rust: return;
}
    // rust: let mut target = *poses;
    // rust: for track in &self.tracks {
    // rust: if let Target::Bone(bone) = track.target {
    // rust: let i = BODY.iter().position(|b| *b == bone).unwrap_or(0);
    // rust: let s = track.sample(t, self.length, self.looping);
    // rust: let r = rest[i];
    // rust: target[i] = [
    // rust: r[0] + s.offset[0],
    // rust: r[1] + s.offset[1],
    // rust: r[2] + s.offset[2],
    // rust: s.rotation[0],
    // rust: s.rotation[1],
    // rust: s.rotation[2],
    // rust: r[6],
    // rust: r[7],
    // rust: r[8],
    // rust: ];
}
}
    // rust: if let Some(root) = self.tracks.iter().find(|t| t.target == Target::Root) {
    // rust: let s = root.sample(t, self.length, self.looping);
    // rust: let turn = quat(s.rotation);
    // rust: let shift = Vec3::from_array(s.offset);
    // rust: for p in &mut target {
    // rust: let at = FEET + turn * (Vec3::new(p[0], p[1], p[2]) - FEET) + shift;
    // rust: let (z, y, x) = (turn * quat([p[3], p[4], p[5]])).to_euler(EulerRot::ZYX);
    // rust: p[..6].copy_from_slice(&[at.x, at.y, at.z, x, y, z]);
}
}
        // Fully in (most of an emote): the target as it is, no blending to pay for.
    // rust: if weight >= 1.0 {
    // rust: for (p, goal) in poses.iter_mut().zip(target) {
    // rust: p[..6].copy_from_slice(&goal[..6]);
}
    // rust: return;
}
    // rust: let w = weight;
    // rust: for (p, goal) in poses.iter_mut().zip(target) {
    // rust: let at = Vec3::new(p[0], p[1], p[2]).lerp(Vec3::new(goal[0], goal[1], goal[2]), w);
    // rust: let turned = quat([p[3], p[4], p[5]]).slerp(quat([goal[3], goal[4], goal[5]]), w);
    // rust: let (z, y, x) = turned.to_euler(EulerRot::ZYX);
    // rust: p[..6].copy_from_slice(&[at.x, at.y, at.z, x, y, z]);
}
}

    /// The props' poses `t` ticks in, each from its rest pose (`rest`, by part name).
    // rust: pub fn pose_props(
    // rust: &self,
    // rust: t: f32,
    // rust: rest: impl Fn(&str) -> Option<Pose>,
    // rust: mut set: impl FnMut(&str, Pose),
    // rust: ) {
    // rust: for track in &self.tracks {
    // rust: let Target::Prop(name) = &track.target else {
    // rust: continue;
}
    // rust: let Some(mut pose) = rest(name) else {
    // rust: continue;
}
    // rust: let s = track.sample(t, self.length, self.looping);
    // rust: for c in 0..3 {
    // rust: pose[c] += s.offset[c];
    // rust: pose[3 + c] += s.rotation[c];
    // rust: pose[6 + c] *= s.scale;
}
    // rust: set(name, pose);
}
}

    /// Times worth checking the props' reach at: every key, and 32 points over the length.
    // rust: pub(crate) fn sample_times(&self) -> impl Iterator<Item = f32> + '_ {
    // rust: let keys = self.tracks.iter().flat_map(|t| t.keys.iter().map(|k| k.t));
    // rust: keys.chain((0..32).map(|k| self.length * k as f32 / 32.0))
}
}

/// An emote someone plays: the item, and when it started and stopped (ticks of the clock the
/// game samples it with, such as the player's age).
pub const Playing = struct {
    item: std::sync::*crate::Item,
    start: f32,
    /// Cancelled at this time: it fades out over its blend from there.
    stop: ?f32,
};

    // rust: impl Playing {
    /// The emote's own time and weight at `now`, or `None` once it is over.
pub fn at(self: *Self, now: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let emote = self.item.emote.as_ref()?;
    // rust: let t = now - self.start;
    // rust: let mut weight = emote.weight(t);
    // rust: if let Some(stop) = self.stop {
    // rust: let fade = if emote.blend > 0.0 {
    // rust: smooth01(1.0 - (now - stop) / emote.blend)
    // rust: } else {
    // rust: 0.0
}
    // rust: weight = weight.min(fade);
}
    // rust: let over = !emote.looping && t >= emote.length || self.stop.is_some() && weight <= 0.0;
    // rust: (!over).then_some((t, weight))
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::Item;
//     use crate::pose::tests::png;
//     use std::f32::consts::{FRAC_PI_2, PI};

    /// A wave: the right arm up over 8 ticks, waved twice, down by 40; a balloon prop in the left
    /// hand that pops in.
pub fn wave(edit: impl Fn([]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = format!(
    // rust: r#"{{"format": 1, "id": "wave", "slot": "emote",
    // rust: "texture": {{"png": "{}"}},
    // rust: "parts": [{{"name": "balloon", "bone": "left_arm", "pivot": [1, 10, 0],
    // rust: "cubes": [{{"origin": [-2, -4, -2], "size": [4, 4, 4], "uv": [0, 0]}}]}}],
    // rust: "emote": {{"length": 40, "blend": 4, "tracks": [
    // rust: {{"part": "right_arm", "keys": [
    // rust: {{"t": 0}},
    // rust: {{"t": 8, "rotation": [0, 0, 150], "ease": "linear"}},
    // rust: {{"t": 16, "rotation": [0, 0, 120], "ease": "step"}},
    // rust: {{"t": 24, "rotation": [0, 0, 150]}},
    // rust: {{"t": 40}}]}},
    // rust: {{"part": "balloon", "keys": [
    // rust: {{"t": 0, "scale": 0, "ease": "in_out"}}, {{"t": 10, "offset": [0, -4, 0]}}]}}]}}}}"#,
    // rust: png(16, 16)
    // rust: );
    // rust: edit(file)
}

pub fn parse(file: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Item::parse(file.as_bytes())
}

pub fn emote(file: []const u8) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse(file).unwrap().emote.unwrap()
}

pub fn near(a: f32, b: f32) void {
}
    // rust: assert!((a - b).abs() < 1e-4, "{a} != {b}");
}

pub fn keys_are_hit_and_each_ease_runs_between_them() void {
}
    // rust: let e = emote(&wave(|f| f));
    // rust: let arm = &e.tracks[0];
    // rust: assert_eq!(arm.target, Target::Bone(crate::Bone::RightArm));
    // rust: let z = |t: f32| arm.sample(t, e.length, e.looping).rotation[2].to_degrees();
        // A smooth curve passes through its keys.
    // rust: near(z(0.0), 0.0);
    // rust: near(z(8.0), 150.0);
    // rust: near(z(24.0), 150.0);
    // rust: near(z(40.0), 0.0);
        // Linear from 8 to 16: halfway is the mean; step from 16 holds until 24.
    // rust: near(z(12.0), 135.0);
    // rust: near(z(20.0), 120.0);
    // rust: near(z(23.9), 120.0);
        // Held after the end of a one-shot.
    // rust: near(z(55.0), 0.0);
}

pub fn smooth_keys_leave_no_corner() void {
}
        // Smooth through 0, 90, 0 at 0, 10, 20: the slope is the same on both sides of each inner
        // key, and the curve tops out at the key (Catmull-Rom's tangent there is flat).
    // rust: let file = wave(|f| {
    // rust: f.replace(
    // rust: r#"{"t": 8, "rotation": [0, 0, 150], "ease": "linear"},
    // rust: {"t": 16, "rotation": [0, 0, 120], "ease": "step"},
    // rust: {"t": 24, "rotation": [0, 0, 150]},"#,
    // rust: r#"{"t": 10, "rotation": [0, 0, 90]}, {"t": 20}, {"t": 30, "rotation": [0, 0, -90]},"#,
    // rust: )
    // rust: });
    // rust: let e = emote(&file);
    // rust: let z = |t: f32| e.tracks[0].sample(t, e.length, false).rotation[2];
    // rust: for key in [10.0, 20.0] {
    // rust: let (h, k) = (1e-2, key);
    // rust: let left = (z(k) - z(k - h)) / h;
    // rust: let right = (z(k + h) - z(k)) / h;
    // rust: assert!((left - right).abs() < 0.02, "{key}: {left} vs {right}");
}
    // rust: assert!(z(9.5) < z(10.0) && z(10.5) < z(10.0));
}

pub fn a_loop_wraps_from_its_last_key_to_its_first() void {
}
    // rust: let file = wave(|f| {
    // rust: f.replace(
    // rust: r#""length": 40, "blend": 4"#,
    // rust: r#""length": 40, "loop": true"#,
    // rust: )
    // rust: .replace(
    // rust: r#"{"t": 40}"#,
    // rust: r#"{"t": 32, "rotation": [0, 0, 40], "ease": "linear"}"#,
    // rust: )
    // rust: });
    // rust: let e = emote(&file);
    // rust: let z = |t: f32| e.tracks[0].sample(t, e.length, true).rotation[2].to_degrees();
        // From 40° at 32 back to 0° at 40 (= 0), linearly: 20° at 36.
    // rust: near(z(36.0), 20.0);
        // A period later, the same.
    // rust: near(z(76.0), 20.0);
    // rust: near(z(48.0), 150.0);
        // A loop fades in, then stays.
    // rust: near(e.weight(0.0), 0.0);
    // rust: near(e.weight(2.0), 0.5);
    // rust: near(e.weight(400.0), 1.0);
}

pub fn a_one_shot_fades_in_and_out_and_a_cancel_fades_it_out() void {
}
    // rust: let item = std::sync::Arc::new(parse(&wave(|f| f)).unwrap());
    // rust: let e = item.emote.as_ref().unwrap();
    // rust: near(e.weight(2.0), 0.5);
    // rust: near(e.weight(20.0), 1.0);
    // rust: near(e.weight(38.0), 0.5);
    // rust: assert_eq!(e.weight(40.0), 0.0);
    // rust: let mut playing = Playing {
    // rust: item: item.clone(),
    // rust: start: 100.0,
    // rust: stop: None,
}
    // rust: assert_eq!(playing.at(120.0), Some((20.0, 1.0)));
    // rust: assert_eq!(playing.at(140.0), None);
        // Cancelled at 110: half gone 2 ticks later, over after the blend.
    // rust: playing.stop = Some(110.0);
    // rust: let (t, w) = playing.at(112.0).unwrap();
    // rust: near(t, 12.0);
    // rust: near(w, 0.5);
    // rust: assert_eq!(playing.at(114.0), None);
}

    /// The player model's bones at rest (`BODY`'s order) and as walking left them.
pub fn bodies() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = |x: f32, y: f32| [x, y, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0];
    // rust: let rest = [
    // rust: at(0.0, 0.0),
    // rust: at(0.0, 0.0),
    // rust: at(-5.0, 2.0),
    // rust: at(5.0, 2.0),
    // rust: at(-1.9, 12.0),
    // rust: at(1.9, 12.0),
    // rust: ];
    // rust: let mut walking = rest;
    // rust: walking[0][4] = 0.3; // the head looks aside
    // rust: walking[2][3] = 0.5; // the right arm swings
    // rust: (rest, walking)
}

pub fn keyed_bones_take_the_emotes_pose_and_others_keep_theirs() void {
}
    // rust: let e = emote(&wave(|f| f));
    // rust: let (rest, walking) = bodies();
    // rust: let mut poses = walking;
    // rust: e.pose_body(8.0, 1.0, &rest, &mut poses);
        // The right arm: rest position, 150° about z, its swing gone.
    // rust: near(poses[2][0], -5.0);
    // rust: near(poses[2][3], 0.0);
    // rust: near(poses[2][5], 150f32.to_radians());
        // The head still looks aside; the legs don't move.
    // rust: near(poses[0][4], 0.3);
    // rust: assert_eq!(poses[4], walking[4]);
        // Half blended: halfway between the swing and the emote's pose (one axis each).
    // rust: let mut half = walking;
    // rust: half[2][3] = 0.0;
    // rust: e.pose_body(8.0, 0.5, &rest, &mut half);
    // rust: near(half[2][5], 75f32.to_radians());
}

pub fn the_root_turns_and_lifts_the_whole_body_about_the_feet() void {
}
    // rust: let file = wave(|f| {
    // rust: f.replace(
    // rust: r#"{"part": "balloon","#,
    // rust: r#"{"part": "root", "keys": [{"t": 0, "offset": [0, -8, 0], "rotation": [0, 180, 0]}]},
    // rust: {"part": "balloon","#,
    // rust: )
    // rust: });
    // rust: let e = emote(&file);
    // rust: let (rest, _) = bodies();
    // rust: let mut poses = rest;
    // rust: e.pose_body(0.0, 1.0, &rest, &mut poses);
        // Half a turn about the vertical through the feet swaps the arms' sides, then 8 px up.
    // rust: near(poses[3][0], -5.0);
    // rust: near(poses[3][1], 2.0 - 8.0);
    // rust: near(poses[4][0], 1.9);
    // rust: near(poses[4][1], 12.0 - 8.0);
        // Each bone is turned with it (180° about y, whatever Euler angles say so).
    // rust: let q = quat([poses[0][3], poses[0][4], poses[0][5]]);
    // rust: assert!(q.angle_between(Quat::from_rotation_y(PI)) < 1e-3);
        // A quarter turn about x tips the head (24 px above the feet) forward along -z... or +z:
        // (0, -24) from the feet turned 90° about x is (0, 0, -24) with y down, z forward.
    // rust: let tip = wave(|f| {
    // rust: f.replace(
    // rust: r#"{"part": "balloon","#,
    // rust: r#"{"part": "root", "keys": [{"t": 0, "rotation": [90, 0, 0]}]}, {"part": "balloon","#,
    // rust: )
    // rust: });
    // rust: let mut tipped = rest;
    // rust: emote(&tip).pose_body(0.0, 1.0, &rest, &mut tipped);
    // rust: let head = Vec3::new(tipped[0][0], tipped[0][1], tipped[0][2]);
    // rust: let expected = FEET + Quat::from_rotation_x(FRAC_PI_2) * (Vec3::ZERO - FEET);
    // rust: assert!((head - expected).length() < 1e-3, "{head} {expected}");
}

pub fn props_pop_in_and_move_from_their_rest() void {
}
    // rust: let item = parse(&wave(|f| f)).unwrap();
    // rust: let e = item.emote.as_ref().unwrap();
    // rust: let mut got = Vec::new();
    // rust: e.pose_props(5.0, |n| item.rest(n), |n, p| got.push((n.to_owned(), p)));
    // rust: let (name, pose) = &got[0];
    // rust: assert_eq!(name, "balloon");
        // In-out from scale 0 at 0 to 1 at 10: half at 5; moved half of 4 px up.
    // rust: near(pose[6], 0.5);
    // rust: near(pose[1], 10.0 - 2.0);
}

pub fn refuses_emotes_past_the_limits() void {
}
    // rust: assert!(parse(&wave(|f| f)).is_ok());
    // rust: let bad = [
    // rust: (r#""length": 40"#, r#""length": 400"#),
    // rust: (r#""length": 40"#, r#""length": 2"#),
    // rust: (r#""blend": 4"#, r#""blend": 30"#),
    // rust: (r#"{"t": 16,"#, r#"{"t": 4,"#),
    // rust: (r#"{"t": 40}"#, r#"{"t": 41}"#),
    // rust: (r#""part": "right_arm""#, r#""part": "tail""#),
    // rust: (
    // rust: r#""part": "balloon", "keys""#,
    // rust: r#""part": "right_arm", "keys""#,
    // rust: ),
    // rust: (
    // rust: r#"[0, 0, 150], "ease": "linear""#,
    // rust: r#"[0, 0, 400], "ease": "linear""#,
    // rust: ),
    // rust: (r#"{"t": 0}"#, r#"{"t": 0, "scale": 2}"#),
    // rust: (r#"{"t": 0}"#, r#"{"t": 0, "offset": [9, 0, 0]}"#),
    // rust: (r#""ease": "step""#, r#""ease": "bounce""#),
    // rust: ];
    // rust: for (from, to) in bad {
    // rust: let file = wave(|f| f.replacen(from, to, 1));
    // rust: assert_ne!(file, wave(|f| f), "{from}");
    // rust: assert!(parse(&file).is_err(), "{to}");
}
        // The balloon carried past the reach: 18 px down its arm, then 8 more and twice as big.
    // rust: let far = wave(|f| {
    // rust: f.replace("[1, 10, 0]", "[1, 18, 0]").replace(
    // rust: r#""offset": [0, -4, 0]"#,
    // rust: r#""offset": [0, 8, 0], "scale": 2"#,
    // rust: )
    // rust: });
    // rust: assert!(matches!(parse(&far), Err(crate::Error::TooFar(_))));
    // rust: let many: Vec<String> = (0..=MAX_KEYS).map(|k| format!(r#"{{"t": {k}}}"#)).collect();
    // rust: let file = wave(|f| f.replacen(r#"{"t": 0}"#, &many.join(","), 1));
    // rust: assert!(parse(&file).is_err());
}

pub fn only_an_emote_has_one_and_an_emote_needs_a_texture_only_for_props() void {
}
        // A hat with an emote, an emote without one.
    // rust: let hat = wave(|f| f.replace(r#""slot": "emote""#, r#""slot": "head""#));
    // rust: assert!(parse(&hat).is_err());
    // rust: let mut bare = wave(|f| f);
    // rust: let emote_at = bare.find(r#""emote": {"#).unwrap();
    // rust: let start = bare[..emote_at].rfind(',').unwrap();
    // rust: bare.replace_range(start..bare.len() - 1, "");
    // rust: assert!(parse(&bare).is_err());
        // No props: no texture needed. Props: needed.
    // rust: let no_props = r#"{"format": 1, "id": "nod", "slot": "emote", "parts": [],
    // rust: "emote": {"length": 20, "tracks": [{"part": "head", "keys": [{"t": 0}, {"t": 10, "rotation": [30, 0, 0]}]}]}}"#;
    // rust: let item = parse(no_props).unwrap();
    // rust: assert_eq!((item.slot, item.vertices), (crate::Slot::Emote, 0));
    // rust: let untextured = wave(|f| {
    // rust: let (a, b) = (
    // rust: f.find(r#""texture""#).unwrap(),
    // rust: f.find(r#""parts""#).unwrap(),
    // rust: );
    // rust: format!("{}{}", &f[..a], &f[b..])
    // rust: });
    // rust: assert!(matches!(parse(&untextured), Err(crate::Error::Texture(_))));
}
}
