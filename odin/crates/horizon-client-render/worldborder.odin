//! Transpiled from Horizon Rust crate
package horizon_client_render_worldborder

import "core:fmt"
import "core:mem"
import "core:math"

// The world border (`WorldBorder`): the extent geometry of
// `horizon_core::geometry::border` (static or moving, with the previous size
// for partial ticks) plus the damage and warning settings, and how strongly
// the warning vignette shows.
// use horizon_core::geometry::border::BorderGeometry;
    // rust: pub use horizon_core::geometry::border::BorderStatus;

// `WorldBorder.MAX_SIZE` (the float 5.999997E7 as a double).
MAX_SIZE :: 59_999_968.0

// `BorderStatus.getColor`: the wall colour.
status_color :: proc(status: BorderStatus) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match status {
    // rust: BorderStatus::Growing => 0x40FF80,
    // rust: BorderStatus::Shrinking => 0xFF3030,
    // rust: BorderStatus::Stationary => 0x20A0FF,
}
}

// `Math.min(double, double)`, including the signed-zero rule.
    // rust: pub(crate) fn jmin(a: f64, b: f64) -> f64 {
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if a == 0.0 && b == 0.0 && b.is_sign_negative() {
    // rust: b
    // rust: } else if a <= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
// `Math.max(double, double)`, including the signed-zero rule.
    // rust: pub(crate) fn jmax(a: f64, b: f64) -> f64 {
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if a == 0.0 && b == 0.0 && a.is_sign_negative() {
    // rust: b
    // rust: } else if a >= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
// `Mth.clamp(double, double, double)`.
    // rust: pub(crate) fn jclamp(v: f64, lo: f64, hi: f64) -> f64 {
    // rust: if v < lo { lo } else { jmin(v, hi) }
}

WorldBorder :: struct {
    geometry: BorderGeometry,
    damage_per_block: f64,
    safe_zone: f64,
    warning_distance: i32,
    warning_time: i32,
}
    // rust: impl Default for WorldBorder {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: geometry: BorderGeometry::new([0.0, 0.0], MAX_SIZE, 29_999_984)
    // rust: .expect("default border"),
    // rust: damage_per_block: 0.2,
    // rust: safe_zone: 5.0,
    // rust: warning_distance: 5,
    // rust: warning_time: 300,
}
}
}
    // rust: impl PartialEq for WorldBorder {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.center() == other.center()
    // rust: && self.size() == other.size()
    // rust: && self.target_size() == other.target_size()
    // rust: && self.remaining_ticks() == other.remaining_ticks()
    // rust: && self.absolute_max_size() == other.absolute_max_size()
    // rust: && self.damage_per_block == other.damage_per_block
    // rust: && self.safe_zone == other.safe_zone
    // rust: && self.warning_distance == other.warning_distance
    // rust: && self.warning_time == other.warning_time
}
}
    // rust: impl WorldBorder {
    // Its extent, for collisions.
geometry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.geometry
}
center :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.center()
}
    // `setCenter` (non-finite centres are ignored).
set_center :: proc(self: ^Self, center: [f64; 2]) {
}
    // rust: let _ = self.geometry.set_center(center);
}
absolute_max_size :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.absolute_max()
}
    // `setAbsoluteMaxSize`.
set_absolute_max_size :: proc(self: ^Self, limit: i32) {
}
    // rust: let _ = self.geometry.set_absolute_max(limit);
}
    // `getSize`.
size :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.size()
}
    // `getLerpTarget`.
target_size :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.lerp_target()
}
    // `getLerpTime`: ticks left in a size change (0 when none).
remaining_ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.lerp_time()
}
    // `getLerpSpeed`: blocks per tick.
lerp_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.lerp_speed()
}
    // `getStatus`.
status :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.status()
}
set_size :: proc(self: ^Self, size: f64) {
}
    // rust: let _ = self.geometry.set_size(size.clamp(1.0, MAX_SIZE));
}
    // `lerpSizeBetween(from, to, ticks)` (what the server and the border
    // packets do).
lerp_between :: proc(self: ^Self, from: f64, to: f64, ticks: i64) {
}
    // rust: let _ = self.geometry.lerp_size_between(from, to, ticks);
}
    // A size change from the current size (`/worldborder set|add` with a time).
lerp_to :: proc(self: ^Self, to: f64, ticks: i64) {
}
    // rust: if ticks <= 0 {
    // rust: self.set_size(to);
    // rust: } else {
    // rust: self.lerp_between(self.size(), to.clamp(1.0, MAX_SIZE), ticks);
}
}
    // `tick`.
tick :: proc(self: ^Self) {
}
    // rust: let _ = self.geometry.tick();
}
    // `getMinX(partial)`, `getMinZ`, `getMaxX`, `getMaxZ`.
bounds_at :: proc(self: ^Self, partial: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.bounds(partial)
}
    // `getMinX()` etc. (partial tick 0: the previous size while moving).
bounds :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds_at(0.0)
}
    // `getDistanceToBorder(x, z)`: negative outside.
distance :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.distance_to_border(x, z)
}
contains :: proc(self: ^Self, x: f64, z: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.geometry.is_within_bounds(x, z, 0.0)
}
    // `Hud.extractVignette`: how strongly the vignette turns red at
    // (x, z), 0 when outside the warning distance.
warning_strength :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: crate::hud_overlays::border_warning(
    // rust: self.distance(x, z) as f32,
    // rust: self.warning_distance,
    // rust: self.warning_time,
    // rust: self.lerp_speed(),
    // rust: self.target_size() - self.size(),
    // rust: )
}
    // Clamp a point so a body of half-width `half` stays inside.
clamp :: proc(self: ^Self, x: f64, z: f64, half: f64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [min_x, min_z, max_x, max_z] = self.bounds();
    // rust: [
    // rust: x.clamp(min_x + half, (max_x - half).max(min_x + half)),
    // rust: z.clamp(min_z + half, (max_z - half).max(min_z + half)),
    // rust: ]
}
pack :: proc(self: ^Self) -> h {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: Tag::compound([
    // rust: ("center_x", Tag::Double(self.center()[0].to_bits())),
    // rust: ("center_z", Tag::Double(self.center()[1].to_bits())),
    // rust: ("size", Tag::Double(self.size().to_bits())),
    // rust: (
    // rust: "damage_per_block",
    // rust: Tag::Double(self.damage_per_block.to_bits()),
    // rust: ),
    // rust: ("safe_zone", Tag::Double(self.safe_zone.to_bits())),
    // rust: ("warning_blocks", Tag::Int(self.warning_distance)),
    // rust: ("warning_time", Tag::Int(self.warning_time)),
    // rust: ("lerp_target", Tag::Double(self.target_size().to_bits())),
    // rust: ("lerp_time", Tag::Long(self.remaining_ticks())),
    // rust: ])
}
unpack :: proc(tag: ^horizon_world::nbt::Tag) -> S {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: let d = |k: &str, default: f64| match tag.get(k) {
    // rust: Some(Tag::Double(b)) => f64::from_bits(*b),
    // rust: _ => default,
}
    // rust: let i = |k: &str, default: i32| match tag.get(k) {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => default,
}
    // rust: let size = d("size", MAX_SIZE).clamp(1.0, MAX_SIZE);
    // rust: let mut b = Self {
    // rust: damage_per_block: d("damage_per_block", 0.2),
    // rust: safe_zone: d("safe_zone", 5.0),
    // rust: warning_distance: i("warning_blocks", 5),
    // rust: warning_time: i("warning_time", 300),
    // rust: ..Self::default()
}
    // rust: b.set_center([d("center_x", 0.0), d("center_z", 0.0)]);
    // rust: b.set_size(size);
    // rust: if let Some(Tag::Long(t)) = tag.get("lerp_time")
    // rust: && *t > 0
    // rust: {
    // rust: let to = d("lerp_target", size);
    // rust: b.lerp_between(size, to.clamp(1.0, MAX_SIZE), *t);
}
    // rust: b
}
}

    // rust: mod tests {
//     use super::*;

lerp_and_distance :: proc() {
}
    // rust: let mut b = WorldBorder::default();
    // rust: b.set_size(100.0);
    // rust: assert_eq!(b.distance(0.0, 0.0), 50.0);
    // rust: assert_eq!(b.distance(60.0, 0.0), -10.0);
    // rust: assert!(b.contains(49.9, -49.9) && !b.contains(50.0, 0.0));
    // rust: b.lerp_to(200.0, 10);
    // rust: assert_eq!(b.size(), 100.0);
    // rust: assert_eq!(b.status(), BorderStatus::Growing);
    // rust: for _ in 0..5 {
    // rust: b.tick();
}
    // rust: assert_eq!(b.size(), 150.0);
    // rust: assert_eq!(b.remaining_ticks(), 5);
        // Bounds at partial tick 0 still use the previous tick's size.
    // rust: assert_eq!(b.bounds()[2], 70.0);
    // rust: assert_eq!(b.bounds_at(1.0)[2], 75.0);
    // rust: for _ in 0..5 {
    // rust: b.tick();
}
    // rust: assert_eq!((b.size(), b.remaining_ticks()), (200.0, 0));
        // An instant change and clamping a body inside.
    // rust: b.lerp_to(10.0, 0);
    // rust: assert_eq!(b.size(), 10.0);
    // rust: assert_eq!(b.status(), BorderStatus::Stationary);
    // rust: assert_eq!(b.clamp(100.0, -100.0, 0.3), [4.7, -4.7]);
    // rust: b.set_center([10.0, 0.0]);
    // rust: assert_eq!(b.bounds(), [5.0, -5.0, 15.0, 5.0]);
}
saved_form_round_trips :: proc() {
}
    // rust: let mut b = WorldBorder::default();
    // rust: b.set_size(500.0);
    // rust: b.set_center([3.5, -7.0]);
    // rust: b.damage_per_block = 1.5;
    // rust: b.warning_distance = 9;
    // rust: let back = WorldBorder::unpack(&b.pack());
    // rust: assert_eq!(back, b);
}
}
