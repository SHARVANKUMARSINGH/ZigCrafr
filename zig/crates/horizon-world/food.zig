//! Transpiled from Horizon Rust crate
//! Module: horizon-world_food
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Hunger, saturation, exhaustion and server-side natural regeneration.
pub const Difficulty = enum {
    Peaceful,
    Easy,
    Normal,
    Hard,
};
pub const FoodData = struct {
    food: i32,
    saturation: f32,
    exhaustion: f32,
    timer: i32,
};
    // rust: impl Default for FoodData {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: exhaustion: 0.0,
    // rust: timer: 0,
}
}
}
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
pub fn max(a: f32, b: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() & b.to_bits())
    // rust: } else {
    // rust: a.max(b)
}
}
pub fn clamp(v: f32, lo: f32, hi: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v < lo { lo } else { min(v, hi) }
}
    // rust: impl FoodData {
pub fn eat(self: *Self, nutrition: i32, saturation_modifier: f32) void {
}
    // rust: self.eat_properties(nutrition, nutrition as f32 * saturation_modifier * 2.0);
}
pub fn eat_properties(self: *Self, nutrition: i32, saturation: f32) void {
}
    // rust: self.food = nutrition.wrapping_add(self.food).clamp(0, 20);
    // rust: self.saturation = clamp(saturation + self.saturation, 0.0, self.food as f32);
}
pub fn add_exhaustion(self: *Self, value: f32) void {
}
    // rust: self.exhaustion = min(self.exhaustion + value, 40.0);
}
pub fn has_enough_food(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.food as f32 > 6.0
}
pub fn needs_food(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.food < 20
}
    // rust: pub fn tick<W: FoodWorld>(&mut self, world: &mut W) -> Result<(), W::Error> {
    // rust: let level = world.level(self)?;
    // rust: let difficulty = world.difficulty(level, self)?;
    // rust: if self.exhaustion > 4.0 {
    // rust: self.exhaustion -= 4.0;
    // rust: if self.saturation > 0.0 {
    // rust: self.saturation = max(self.saturation - 1.0, 0.0);
    // rust: } else if difficulty != Difficulty::Peaceful {
    // rust: self.food = self.food.wrapping_sub(1).max(0);
}
}
    // rust: let regenerate = world.natural_regeneration(level, self)?;
    // rust: if regenerate && self.saturation > 0.0 && world.is_hurt(self)? && self.food >= 20 {
    // rust: self.timer = self.timer.wrapping_add(1);
    // rust: if self.timer >= 10 {
    // rust: let amount = min(self.saturation, 6.0);
    // rust: world.heal(self, amount / 6.0)?;
    // rust: self.add_exhaustion(amount);
    // rust: self.timer = 0;
}
    // rust: } else if regenerate && self.food >= 18 && world.is_hurt(self)? {
    // rust: self.timer = self.timer.wrapping_add(1);
    // rust: if self.timer >= 80 {
    // rust: world.heal(self, 1.0)?;
    // rust: self.add_exhaustion(6.0);
    // rust: self.timer = 0;
}
    // rust: } else if self.food <= 0 {
    // rust: self.timer = self.timer.wrapping_add(1);
    // rust: if self.timer >= 80 {
    // rust: if world.health(self)? > 10.0
    // rust: || difficulty == Difficulty::Hard
    // rust: || (world.health(self)? > 1.0 && difficulty == Difficulty::Normal)
    // rust: {
    // rust: world.hurt_starvation(level, self, 1.0)?;
}
    // rust: self.timer = 0;
}
    // rust: } else {
    // rust: self.timer = 0;
}
    // rust: Ok(())
}
}
/// World hooks preserve short-circuit query order. Callbacks can mutate food
/// state; errors retain earlier writes and effects. The level is captured once.
    // rust: pub trait FoodWorld {
    // rust: type Error;
    // rust: type Level: Copy;
pub fn level(self: *Self, food: *mut FoodData) R;
    // rust: fn difficulty(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: food: &mut FoodData,
    // rust: ) -> Result<Difficulty, Self::Error>;
    // rust: fn natural_regeneration(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: food: &mut FoodData,
    // rust: ) -> Result<bool, Self::Error>;
pub fn is_hurt(self: *Self, food: *mut FoodData) R;
pub fn heal(self: *Self, food: *mut FoodData, amount: f32) R;
pub fn health(self: *Self, food: *mut FoodData) R;
    /// Resolve the player's starvation damage source and dispatch hurtServer on
    /// the captured level; the native boolean hurt result is ignored.
    // rust: fn hurt_starvation(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: food: &mut FoodData,
    // rust: amount: f32,
    // rust: ) -> Result<(), Self::Error>;
}
