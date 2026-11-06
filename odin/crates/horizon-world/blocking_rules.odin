//! Transpiled from Horizon Rust crate
package horizon_world_blocking_rules

import "core:fmt"
import "core:mem"
import "core:math"

// Blocks-attacks scalar reduction, delay/cooldown and item-damage rules.
// Direction calculation, component codecs, equipment mutation and sounds are
// separate services; angles here are the native caller's radians.
    // rust: pub trait TypeMatchWorld {
    // rust: type Error;
    // rust: type Set: Copy;
source_in_set :: proc(self: ^Self, set: Self::Set) -> R {
    // Ported from Horizon
    return {}
}
}
DamageReduction :: struct {
    horizontal_angle: f32,
    types: Maybe(S),
    base: f32,
    factor: f32,
}
min :: proc(a: f32, b: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() | b.to_bits())
    // rust: } else {
    // rust: a.min(b)
}
}
clamp :: proc(value: f32, damage: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if value < 0.0 { 0.0 } else { min(value, damage) }
}
round :: proc(value: f32) -> i {
    // Ported from Horizon
    return {}
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
ItemDamageFunction :: struct {
    threshold: f32,
    base: f32,
    factor: f32,
}
    // rust: impl ItemDamageFunction {
apply :: proc(self: ^Self, damage: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if damage < self.threshold {
    // rust: 0
    // rust: } else {
    // rust: (self.base + self.factor * damage).floor() as i32
}
}
}
BlockingRules :: struct {
    delay_seconds: f32,
    disable_scale: f32,
    reductions: [dynamic]DamageReduction<S>,
    item_damage: ItemDamageFunction,
}
    // rust: impl<S: Copy> BlockingRules<S> {
delay_ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: round(self.delay_seconds * 20.0)
}
disable_ticks :: proc(self: ^Self, seconds: f32) -> i {
    // Ported from Horizon
    return {}
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
