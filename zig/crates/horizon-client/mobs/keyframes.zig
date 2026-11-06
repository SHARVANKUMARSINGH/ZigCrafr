//! Transpiled from Horizon Rust crate
//! Module: horizon-client_keyframes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla keyframe animations (`AnimationDefinition`, `AnimationChannel`,
//! `KeyframeAnimation`) exported from the client's animation definitions,
//! applied to a pose map exactly like `KeyframeAnimation.Entry.apply`.
// use serde_json::Value;

pub const Target = enum {
    Position,
    Rotation,
    Scale,
};
pub const Keyframe = struct {
    time: f32,
    pre: [f32,
    post: [f32,
    catmull: bool,
};
pub const Channel = struct {
    target: Target,
    keyframes: std.ArrayList(Keyframe),
};
pub const Animation = struct {
    length: f32,
    looping: bool,
    bones: Vec<([]const u8,
};
pub fn v3(v: *Value) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let a = |i: usize| v[i].as_f64().unwrap_or(0.0) as f32;
    // rust: [a(0), a(1), a(2)]
}
    // rust: impl Animation {
pub fn parse(v: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bones = v["bones"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(name, channels)| {
    // rust: let channels = channels
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|c| Channel {
    // rust: target: match c["target"].as_str() {
    // rust: Some("position") => Target::Position,
    // rust: Some("scale") => Target::Scale,
    // rust: _ => Target::Rotation,
    // rust: },
    // rust: keyframes: c["keyframes"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|k| Keyframe {
    // rust: time: k[0].as_f64().unwrap_or(0.0) as f32,
    // rust: pre: v3(&k[1]),
    // rust: post: v3(&k[2]),
    // rust: catmull: k[3].as_str() == Some("catmullrom"),
    // rust: })
    // rust: .collect(),
    // rust: })
    // rust: .collect();
    // rust: (name.clone(), channels)
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: length: v["length"].as_f64().unwrap_or(1.0) as f32,
    // rust: looping: v["looping"].as_bool().unwrap_or(false),
    // rust: bones,
}
}
    /// KeyframeAnimation.apply(millis, scale): offsets added to each bone's pose.
pub fn apply(self: *Self, millis: i64, scale: f32, poses: *mut super::anim::Poses) void {
}
    // rust: let mut seconds = millis as f32 / 1000.0;
    // rust: if self.looping {
    // rust: seconds %= self.length;
}
    // rust: for (bone, channels) in &self.bones {
    // rust: for c in channels {
    // rust: let v = sample(&c.keyframes, seconds, scale);
    // rust: let p = poses.get(bone);
    // rust: match c.target {
                    // ModelPart.offsetPos / offsetRotation / offsetScale.
    // rust: Target::Position => {
    // rust: p[0] += v[0];
    // rust: p[1] += v[1];
    // rust: p[2] += v[2];
}
    // rust: Target::Rotation => {
    // rust: p[3] += v[0];
    // rust: p[4] += v[1];
    // rust: p[5] += v[2];
}
    // rust: Target::Scale => {
    // rust: p[6] += v[0];
    // rust: p[7] += v[1];
    // rust: p[8] += v[2];
}
}
}
}
}
    /// KeyframeAnimation.applyWalk(pos, speed, speedFactor, scaleFactor).
    // rust: pub fn apply_walk(
    // rust: &self,
    // rust: pos: f32,
    // rust: speed: f32,
    // rust: speed_factor: f32,
    // rust: scale_factor: f32,
    // rust: poses: &mut super::anim::Poses,
    // rust: ) {
    // rust: let time = (pos * 50.0 * speed_factor) as i64;
    // rust: let scale = (speed * scale_factor).min(1.0);
    // rust: self.apply(time, scale, poses);
}
}
pub fn catmullrom(t: f32, p0: f32, p1: f32, p2: f32, p3: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0.5 * (2.0 * p1
    // rust: + (p2 - p0) * t
    // rust: + (2.0 * p0 - 5.0 * p1 + 4.0 * p2 - p3) * t * t
    // rust: + (3.0 * p1 - p0 - 3.0 * p2 + p3) * t * t * t)
}
/// KeyframeAnimation.Entry.apply interpolation.
pub fn sample(k: *[Keyframe], seconds: f32, scale: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if k.is_empty() {
    // rust: return [0.0; 3];
}
    // Mth.binarySearch(0, len, i -> seconds <= k[i].time) - 1
    // rust: let first = k.iter().position(|f| seconds <= f.time).unwrap_or(k.len());
    // rust: let prev = first.saturating_sub(1);
    // rust: let next = (prev + 1).min(k.len() - 1);
    // rust: let delta = seconds - k[prev].time;
    // rust: let alpha = if next != prev {
    // rust: (delta / (k[next].time - k[prev].time)).clamp(0.0, 1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: if k[next].catmull {
    // rust: let p0 = k[prev.saturating_sub(1)].post;
    // rust: let p1 = k[prev].post;
    // rust: let p2 = k[next].post;
    // rust: let p3 = k[(next + 1).min(k.len() - 1)].post;
    // rust: std::array::from_fn(|i| catmullrom(alpha, p0[i], p1[i], p2[i], p3[i]) * scale)
    // rust: } else {
    // rust: let a = k[prev].post;
    // rust: let b = k[next].pre;
    // rust: std::array::from_fn(|i| (a[i] + (b[i] - a[i]) * alpha) * scale)
}
}
/// AnimationState: a start time in ticks while started.
pub const AnimationState = struct {
    started: ?f32,
};
    // rust: impl AnimationState {
pub fn start(self: *Self, age: f32) void {
}
    // rust: self.started = Some(age);
}
pub fn start_if_stopped(self: *Self, age: f32) void {
}
    // rust: if self.started.is_none() {
    // rust: self.started = Some(age);
}
}
pub fn stop(self: *Self) void {
}
    // rust: self.started = None;
}
    /// `AnimationState.fastForward`: the animation is `ticks` further on.
pub fn fast_forward(self: *Self, ticks: i32) void {
}
    // rust: if let Some(s) = &mut self.started {
    // rust: *s -= ticks as f32;
}
}
pub fn animate_when(self: *Self, condition: bool, age: f32) void {
}
    // rust: if condition {
    // rust: self.start_if_stopped(age)
    // rust: } else {
    // rust: self.stop()
}
}
    /// Milliseconds since the start at render time `age` (ticks + partial).
pub fn millis(self: *Self, age: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.started.map(|s| ((age - s) * 50.0) as i64)
}
}
    // rust: mod tests {
//     use super::*;
pub fn linear_keyframes_interpolate_post_to_pre() void {
}
    // rust: let k = vec![
    // rust: Keyframe {
    // rust: time: 0.0,
    // rust: pre: [0.0; 3],
    // rust: post: [0.0; 3],
    // rust: catmull: false,
    // rust: },
    // rust: Keyframe {
    // rust: time: 1.0,
    // rust: pre: [2.0, 4.0, 6.0],
    // rust: post: [2.0, 4.0, 6.0],
    // rust: catmull: false,
    // rust: },
    // rust: ];
    // rust: let v = sample(&k, 0.5, 1.0);
    // rust: assert_eq!(v, [1.0, 2.0, 3.0]);
        // Past the end it holds the last value.
    // rust: assert_eq!(sample(&k, 3.0, 0.5), [1.0, 2.0, 3.0]);
}
pub fn catmullrom_passes_through_keyframes() void {
}
    // rust: let k = vec![
    // rust: Keyframe {
    // rust: time: 0.0,
    // rust: pre: [0.0; 3],
    // rust: post: [0.0; 3],
    // rust: catmull: true,
    // rust: },
    // rust: Keyframe {
    // rust: time: 1.0,
    // rust: pre: [1.0; 3],
    // rust: post: [1.0; 3],
    // rust: catmull: true,
    // rust: },
    // rust: Keyframe {
    // rust: time: 2.0,
    // rust: pre: [0.0; 3],
    // rust: post: [0.0; 3],
    // rust: catmull: true,
    // rust: },
    // rust: ];
    // rust: assert!((sample(&k, 1.0, 1.0)[0] - 1.0).abs() < 1e-6);
}
}
