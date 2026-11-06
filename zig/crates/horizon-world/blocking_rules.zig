//! Transpiled from Horizon Rust crate
//! Module: horizon-world_blocking_rules
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Blocks-attacks scalar reduction, delay/cooldown and item-damage rules.
//! Direction calculation, component codecs, equipment mutation and sounds are
//! separate services; angles here are the native caller's radians.
    // rust: pub trait TypeMatchWorld {
    // rust: type Error;
    // rust: type Set: Copy;
pub fn source_in_set(self: *Self, set: Self::Set) R;
}
pub const DamageReduction = struct {
    horizontal_angle: f32,
    types: ?S,
    base: f32,
    factor: f32,
};
pub fn min(a: f32, b: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() | b.to_bits())
    // rust: } else {
    // rust: a.min(b)
}
}
pub fn clamp(value: f32, damage: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value < 0.0 { 0.0 } else { min(value, damage) }
}
pub fn round(value: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (f64::from(value) + 0.5).floor() as i32
}
    // rust: impl<S: Copy> DamageReduction<S> {
    // rust: pub fn resolve<W: TypeMatchWorld<Set = S>>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: damage: f32,
    // rust: angle: f64,
    // rust: ) -> Result<f32, W::Error> {
    // rust: if angle > f64::from(0.017_453_292_f32 * self.horizontal_angle) {
    // rust: return Ok(0.0);
}
    // rust: if let Some(set) = self.types {
    // rust: if !world.source_in_set(set)? {
    // rust: return Ok(0.0);
}
}
    // rust: Ok(clamp(self.base + self.factor * damage, damage))
}
}
pub const ItemDamageFunction = struct {
    threshold: f32,
    base: f32,
    factor: f32,
};
    // rust: impl ItemDamageFunction {
pub fn apply(self: *Self, damage: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if damage < self.threshold {
    // rust: 0
    // rust: } else {
    // rust: (self.base + self.factor * damage).floor() as i32
}
}
}
pub const BlockingRules = struct {
    delay_seconds: f32,
    disable_scale: f32,
    reductions: std.ArrayList(DamageReduction<S)>,
    item_damage: ItemDamageFunction,
};
    // rust: impl<S: Copy> BlockingRules<S> {
pub fn delay_ticks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: round(self.delay_seconds * 20.0)
}
pub fn disable_ticks(self: *Self, seconds: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let duration = seconds * self.disable_scale;
    // rust: if duration > 0.0 {
    // rust: round(duration * 20.0)
    // rust: } else {
    // rust: 0
}
}
    // rust: pub fn resolve<W: TypeMatchWorld<Set = S>>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: damage: f32,
    // rust: angle: f64,
    // rust: ) -> Result<f32, W::Error> {
    // rust: let mut blocked = 0.0;
    // rust: for reduction in &self.reductions {
    // rust: blocked += reduction.resolve(world, damage, angle)?;
}
    // rust: Ok(clamp(blocked, damage))
}
}
