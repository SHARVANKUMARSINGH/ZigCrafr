//! Transpiled from Horizon Rust crate
package horizon_world_food_properties

import "core:fmt"
import "core:mem"
import "core:math"

// Food component listener: consumption sounds, stored hunger and burp ordering.
// use crate::food::FoodData;
// use horizon_core::{geometry::Vec3, random::RandomSource};
FoodProperties :: struct {
    nutrition: i32,
    saturation: f32,
    can_always_eat: bool,
}
    // rust: impl PartialEq for FoodProperties {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bits = |f: f32| if f.is_nan() { 0x7fc00000 } else { f.to_bits() };
    // rust: self.nutrition == other.nutrition
    // rust: && bits(self.saturation) == bits(other.saturation)
    // rust: && self.can_always_eat == other.can_always_eat
}
}
SoundCategory :: enum {
    Neutral,
    Players,
}
ConsumptionSound :: struct {
    level: L,
    position: Vec3,
    sound: S,
    category: SoundCategory,
    volume: f32,
    pitch: f32,
}
    // rust: pub trait FoodConsumptionWorld {
    // rust: type Error;
    // rust: type Level: Copy;
    // rust: type Sound: Clone;
    // rust: type Random: Copy;
    // rust: type Source: RandomSource;
get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
random_source :: proc(self: ^Self, random: Self::Random) -> ^ {
    // Ported from Horizon
    return {}
}
    // Entity coordinate getters read its position field directly.
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
is_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // The virtual player getter may change which stored FoodData is returned.
food_data :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Native level sound call excludes no source entity (source argument null).
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
