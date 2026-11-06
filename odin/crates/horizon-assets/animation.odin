//! Transpiled from Horizon Rust crate
package horizon_assets_animation

import "core:fmt"
import "core:mem"
import "core:math"

// Java Edition 26.3 animation metadata and sprite tick selection.
// use crate::json::*;
// use serde_json::value::RawValue;

AnimationFrame :: struct {
    index: i32,
    time: Maybe(i32),
}

AnimationMetadata :: struct {
    frames: Maybe([dynamic]AnimationFrame),
    width: Maybe(i32),
    height: Maybe(i32),
    frame_time: i32,
    interpolate: bool,
}

    // rust: fn optional<'a>(object: &Object<'a>, name: &str) -> Option<&'a RawValue> {
    // rust: object.get(name).copied().filter(|v| v.get() != "null")
}
bounded_integer :: proc(value: ^RawValue, minimum: i32) -> R {
    // Ported from Horizon
    return {}
}
    // A lenient JsonParser exposes scanner failures as strings, which the
    // uncompressed numeric codec rejects. Model streams instead reject them
    // globally, even inside ignored fields.
    // rust: if !native_number_token(value.get()) {
    // rust: return Err(error(
    // rust: "native reader classifies animation number as a string",
    // rust: ));
}
    // rust: let value = integer(value)?;
    // rust: if value < minimum {
    // rust: return Err(error("animation integer outside codec range"));
}
    // rust: Ok(value)
}
    // rust: impl AnimationMetadata {
    // Decode the animation section itself, using the uncompressed JsonOps codec
    // rules. Numeric primitives truncate and wrap as Java Number.intValue does;
    // strings and booleans are not numbers. Null optional fields are absent.
from_json :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let raw: &RawValue = serde_json::from_str(text)?;
    // rust: let fields = object(raw)?;
    // rust: let positive = |name| {
    // rust: optional(&fields, name)
    // rust: .map(|v| bounded_integer(v, 1))
    // rust: .transpose()
}
    // rust: let frames = optional(&fields, "frames")
    // rust: .map(|v| {
    // rust: array(v)?
    // rust: .into_iter()
    // rust: .map(|v| {
    // rust: if v.get().starts_with('{') {
    // rust: let fields = object(v)?;
    // rust: Ok(AnimationFrame {
    // rust: index: bounded_integer(required(&fields, "index")?, 0)?,
    // rust: time: optional(&fields, "time")
    // rust: .map(|v| bounded_integer(v, 1))
    // rust: .transpose()?,
    // rust: })
    // rust: } else {
    // rust: Ok(AnimationFrame {
    // rust: index: bounded_integer(v, 0)?,
    // rust: time: None,
    // rust: })
}
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()
    // rust: })
    // rust: .transpose()?;
    // rust: Ok(Self {
    // rust: frames,
    // rust: width: positive("width")?,
    // rust: height: positive("height")?,
    // rust: frame_time: positive("frametime")?.unwrap_or(1),
    // rust: interpolate: optional(&fields, "interpolate")
    // rust: .map(|v| serde_json::from_str(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: })
}

frame_size :: proc(self: ^Self, image_width: i32, image_height: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match (self.width, self.height) {
    // rust: (Some(w), Some(h)) => [w, h],
    // rust: (Some(w), None) => [w, image_height],
    // rust: (None, Some(h)) => [image_width, h],
    // rust: (None, None) => [image_width.min(image_height); 2],
}
}

    // Build the animation after image/frame dimensions have been validated by
    // the resource loader. Out-of-image indices are removed, preserving order
    // and repeats. Zero or one remaining entries mean static physical frame 0.
clip :: proc(self: ^Self, physical_frames: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.frame_time <= 0 {
    // rust: return Err(error("nonpositive default animation duration"));
}
    // rust: let sequence: Vec<_> = match &self.frames {
    // rust: Some(frames) => frames
    // rust: .iter()
    // rust: .filter_map(|v| {
    // rust: let time = v.time.unwrap_or(self.frame_time);
    // rust: (v.index >= 0 && (v.index as u32) < physical_frames && time > 0)
    // rust: .then_some((v.index as u32, time as u32))
    // rust: })
    // rust: .collect(),
    // rust: None => (0..physical_frames)
    // rust: .map(|i| (i, self.frame_time as u32))
    // rust: .collect(),
}
    // rust: if sequence.len() <= 1 {
    // rust: return Ok(None);
}
    // rust: let mut duration = 0u64;
    // rust: let ends = sequence
    // rust: .iter()
    // rust: .map(|&(_, time)| {
    // rust: duration = duration
    // rust: .checked_add(u64::from(time))
    // rust: .ok_or_else(|| error("animation duration overflow"))?;
    // rust: Ok(duration)
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: Ok(Some(AnimationClip {
    // rust: sequence,
    // rust: ends,
    // rust: duration,
    // rust: interpolate: self.interpolate,
    // rust: }))
}
}

AnimationClip :: struct {
    sequence: Vec<(u32,
    ends: [dynamic]u64,
    duration: u64,
    interpolate: bool,
}
AnimationSample :: struct {
    sequence_index: uint,
    sub_frame: u32,
    frame: u32,
    next_frame: u32,
    dirty: bool,
    needs_draw: bool,
    // Native drawToAtlas encodes floor((subFrame / time) * 1000) in its
    // first-vertex argument. This is not a claim about GPU interpolation pixels.
    interpolation_millis: u32,
}
    // rust: impl AnimationClip {
sequence :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.sequence
}
duration :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.duration
}
interpolates :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.interpolate
}

    // Random access to the state after `tick` native ticks. Binary search avoids
    // advancing every missed tick when a render frame takes longer than 50 ms.
sample :: proc(self: ^Self, tick: u64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let time = tick % self.duration;
    // rust: let index = self.ends.partition_point(|end| *end <= time);
    // rust: let start = if index == 0 { 0 } else { self.ends[index - 1] };
    // rust: let sub_frame = (time - start) as u32;
    // rust: let (frame, duration) = self.sequence[index];
    // rust: let previous = (index + self.sequence.len() - 1) % self.sequence.len();
    // rust: let dirty = tick == 0 || (sub_frame == 0 && frame != self.sequence[previous].0);
    // rust: AnimationSample {
    // rust: sequence_index: index,
    // rust: sub_frame,
    // rust: frame,
    // rust: next_frame: self.sequence[(index + 1) % self.sequence.len()].0,
    // rust: dirty,
    // rust: needs_draw: self.interpolate || dirty,
    // rust: interpolation_millis: ((sub_frame as f32 / duration as f32) * 1000.0) as u32,
}
}
}
