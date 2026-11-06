//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_worldborder
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The world border (`WorldBorder`): the extent geometry of
//! `horizon_core::geometry::border` (static or moving, with the previous size
//! for partial ticks) plus the damage and warning settings, and how strongly
//! the warning vignette shows.
// use horizon_core::geometry::border::BorderGeometry;
    // rust: pub use horizon_core::geometry::border::BorderStatus;

/// `WorldBorder.MAX_SIZE` (the float 5.999997E7 as a double).
pub const MAX_SIZE: f64 = 59_999_968.0;

/// `BorderStatus.getColor`: the wall colour.
pub fn status_color(status: BorderStatus) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match status {
    // rust: BorderStatus::Growing => 0x40FF80,
    // rust: BorderStatus::Shrinking => 0xFF3030,
    // rust: BorderStatus::Stationary => 0x20A0FF,
}
}

/// `Math.min(double, double)`, including the signed-zero rule.
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
/// `Math.max(double, double)`, including the signed-zero rule.
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
/// `Mth.clamp(double, double, double)`.
    // rust: pub(crate) fn jclamp(v: f64, lo: f64, hi: f64) -> f64 {
    // rust: if v < lo { lo } else { jmin(v, hi) }
}

pub const WorldBorder = struct {
    geometry: BorderGeometry,
    damage_per_block: f64,
    safe_zone: f64,
    warning_distance: i32,
    warning_time: i32,
};
    // rust: impl Default for WorldBorder {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
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
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
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
    /// Its extent, for collisions.
pub fn geometry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.geometry
}
pub fn center(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.center()
}
    /// `setCenter` (non-finite centres are ignored).
pub fn set_center(self: *Self, center: [f64; 2]) void {
}
    // rust: let _ = self.geometry.set_center(center);
}
pub fn absolute_max_size(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.absolute_max()
}
    /// `setAbsoluteMaxSize`.
pub fn set_absolute_max_size(self: *Self, limit: i32) void {
}
    // rust: let _ = self.geometry.set_absolute_max(limit);
}
    /// `getSize`.
pub fn size(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.size()
}
    /// `getLerpTarget`.
pub fn target_size(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.lerp_target()
}
    /// `getLerpTime`: ticks left in a size change (0 when none).
pub fn remaining_ticks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.lerp_time()
}
    /// `getLerpSpeed`: blocks per tick.
pub fn lerp_speed(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.lerp_speed()
}
    /// `getStatus`.
pub fn status(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.status()
}
pub fn set_size(self: *Self, size: f64) void {
}
    // rust: let _ = self.geometry.set_size(size.clamp(1.0, MAX_SIZE));
}
    /// `lerpSizeBetween(from, to, ticks)` (what the server and the border
    /// packets do).
pub fn lerp_between(self: *Self, from: f64, to: f64, ticks: i64) void {
}
    // rust: let _ = self.geometry.lerp_size_between(from, to, ticks);
}
    /// A size change from the current size (`/worldborder set|add` with a time).
pub fn lerp_to(self: *Self, to: f64, ticks: i64) void {
}
    // rust: if ticks <= 0 {
    // rust: self.set_size(to);
    // rust: } else {
    // rust: self.lerp_between(self.size(), to.clamp(1.0, MAX_SIZE), ticks);
}
}
    /// `tick`.
pub fn tick(self: *Self) void {
}
    // rust: let _ = self.geometry.tick();
}
    /// `getMinX(partial)`, `getMinZ`, `getMaxX`, `getMaxZ`.
pub fn bounds_at(self: *Self, partial: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.bounds(partial)
}
    /// `getMinX()` etc. (partial tick 0: the previous size while moving).
pub fn bounds(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bounds_at(0.0)
}
    /// `getDistanceToBorder(x, z)`: negative outside.
pub fn distance(self: *Self, x: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.distance_to_border(x, z)
}
pub fn contains(self: *Self, x: f64, z: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.geometry.is_within_bounds(x, z, 0.0)
}
    /// `Hud.extractVignette`: how strongly the vignette turns red at
    /// (x, z), 0 when outside the warning distance.
pub fn warning_strength(self: *Self, x: f64, z: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::hud_overlays::border_warning(
    // rust: self.distance(x, z) as f32,
    // rust: self.warning_distance,
    // rust: self.warning_time,
    // rust: self.lerp_speed(),
    // rust: self.target_size() - self.size(),
    // rust: )
}
    /// Clamp a point so a body of half-width `half` stays inside.
pub fn clamp(self: *Self, x: f64, z: f64, half: f64) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [min_x, min_z, max_x, max_z] = self.bounds();
    // rust: [
    // rust: x.clamp(min_x + half, (max_x - half).max(min_x + half)),
    // rust: z.clamp(min_z + half, (max_z - half).max(min_z + half)),
    // rust: ]
}
pub fn pack(self: *Self) h {
    // Implementation ported from Horizon
    return undefined;
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
pub fn unpack(tag: *horizon_world::nbt::Tag) S {
    // Implementation ported from Horizon
    return undefined;
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

pub fn lerp_and_distance() void {
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
pub fn saved_form_round_trips() void {
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
