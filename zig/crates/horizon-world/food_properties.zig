//! Transpiled from Horizon Rust crate
//! Module: horizon-world_food_properties
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Food component listener: consumption sounds, stored hunger and burp ordering.
// use crate::food::FoodData;
// use horizon_core::{geometry::Vec3, random::RandomSource};
pub const FoodProperties = struct {
    nutrition: i32,
    saturation: f32,
    can_always_eat: bool,
};
    // rust: impl PartialEq for FoodProperties {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bits = |f: f32| if f.is_nan() { 0x7fc00000 } else { f.to_bits() };
    // rust: self.nutrition == other.nutrition
    // rust: && bits(self.saturation) == bits(other.saturation)
    // rust: && self.can_always_eat == other.can_always_eat
}
}
pub const SoundCategory = enum {
    Neutral,
    Players,
};
pub const ConsumptionSound = struct {
    level: L,
    position: Vec3,
    sound: S,
    category: SoundCategory,
    volume: f32,
    pitch: f32,
};
    // rust: pub trait FoodConsumptionWorld {
    // rust: type Error;
    // rust: type Level: Copy;
    // rust: type Sound: Clone;
    // rust: type Random: Copy;
    // rust: type Source: RandomSource;
pub fn get_random(self: *Self) R;
pub fn random_source(self: *Self, random: Self::Random) *;
    /// Entity coordinate getters read its position field directly.
pub fn position(self: *Self) V;
pub fn is_player(self: *Self) b;
    /// The virtual player getter may change which stored FoodData is returned.
pub fn food_data(self: *Self) R;
    /// Native level sound call excludes no source entity (source argument null).
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: ConsumptionSound<Self::Level, Self::Sound>,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: impl FoodProperties {
    // rust: pub fn on_consume<W: FoodConsumptionWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: level: W::Level,
    // rust: consume_sound: W::Sound,
    // rust: burp_sound: W::Sound,
    // rust: ) -> Result<(), W::Error> {
    // rust: let random = world.get_random()?;
    // rust: let position = world.position();
    // rust: let pitch = world.random_source(random).triangle_float(1.0, 0.4);
    // rust: world.play_sound(ConsumptionSound {
    // rust: level,
    // rust: position,
    // rust: sound: consume_sound,
    // rust: category: SoundCategory::Neutral,
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: })?;
    // rust: if world.is_player() {
    // rust: world
    // rust: .food_data()?
    // rust: .eat_properties(self.nutrition, self.saturation);
    // rust: let position = world.position();
    // rust: let pitch = 0.9f32 + world.random_source(random).next_float() * (1.0f32 - 0.9f32);
    // rust: world.play_sound(ConsumptionSound {
    // rust: level,
    // rust: position,
    // rust: sound: burp_sound,
    // rust: category: SoundCategory::Players,
    // rust: volume: 0.5,
    // rust: pitch,
    // rust: })?;
}
    // rust: Ok(())
}
}
