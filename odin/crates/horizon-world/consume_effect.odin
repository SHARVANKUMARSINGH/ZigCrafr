//! Transpiled from Horizon Rust crate
package horizon_world_consume_effect

import "core:fmt"
import "core:mem"
import "core:math"

// Concrete non-teleport consume effects. Actor status storage and sound
// delivery are supplied by the world; effect instance copies are native copies.
// use crate::status_effect::EffectInstance;
// use horizon_core::{position::BlockPos, random::RandomSource};

ConsumeEffect :: enum {
    ApplyStatus {,
    effects: Vec<EffectInstance<H>>,
    probability: f32,
    // rust: },
    RemoveStatus(Set),
    ClearStatus,
    PlaySound(S),
}
    // rust: impl<H: PartialEq, S: PartialEq, Set: PartialEq> PartialEq for ConsumeEffect<H, S, Set> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (self, other) {
    // rust: (
    // rust: Self::ApplyStatus {
    // rust: effects: a,
    // rust: probability: p,
    // rust: },
    // rust: Self::ApplyStatus {
    // rust: effects: b,
    // rust: probability: q,
    // rust: },
    // rust: ) => {
    // rust: let bits = |v: f32| if v.is_nan() { 0x7fc00000 } else { v.to_bits() };
    // rust: a == b && bits(*p) == bits(*q)
}
    // rust: (Self::RemoveStatus(a), Self::RemoveStatus(b)) => a == b,
    // rust: (Self::ClearStatus, Self::ClearStatus) => true,
    // rust: (Self::PlaySound(a), Self::PlaySound(b)) => a == b,
    // rust: _ => false,
}
}
}
    // rust: pub trait EffectWorld<H, S, Set> {
    // rust: type Error;
    // rust: type Level: Copy;
    // rust: type Random: Copy;
    // rust: type Source: RandomSource;
    // rust: type SoundCategory;
get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
random_source :: proc(self: ^Self, random: Self::Random) -> ^ {
    // Ported from Horizon
    return {}
}
add_effect :: proc(self: ^Self, effect: EffectInstance<H>) -> R {
    // Ported from Horizon
    return {}
}
    // Resolve direct or named holder sets when execution begins. Native tag
    // rebinding replaces the list; the current iteration retains its list.
effect_set :: proc(self: ^Self, set: ^Set) -> V {
    // Ported from Horizon
    return {}
}
remove_effect :: proc(self: ^Self, effect: H) -> R {
    // Ported from Horizon
    return {}
}
remove_all_effects :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
sound_category :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Excluded entity is null; volume and pitch are both one.
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: position: BlockPos,
    // rust: sound: S,
    // rust: category: Self::SoundCategory,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: impl<H: Clone, S: Clone, Set> ConsumeEffect<H, S, Set> {
    // rust: pub fn apply<W: EffectWorld<H, S, Set>>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: level: W::Level,
    // rust: ) -> Result<bool, W::Error> {
    // rust: match self {
    // rust: Self::ApplyStatus {
    // rust: effects,
    // rust: probability,
    // rust: } => {
    // rust: let random = world.get_random()?;
    // rust: if world.random_source(random).next_float() >= *probability {
    // rust: return Ok(false);
}
    // rust: let mut changed = false;
    // rust: for effect in effects {
    // rust: if world.add_effect(effect.copy_instance())? {
    // rust: changed = true;
}
}
    // rust: Ok(changed)
}
    // rust: Self::RemoveStatus(effects) => {
    // rust: let effects = world.effect_set(effects);
    // rust: let mut changed = false;
    // rust: for effect in effects {
    // rust: if world.remove_effect(effect)? {
    // rust: changed = true;
}
}
    // rust: Ok(changed)
}
    // rust: Self::ClearStatus => world.remove_all_effects(),
    // rust: Self::PlaySound(sound) => {
    // rust: let position = world.block_position()?;
    // rust: let sound = sound.clone();
    // rust: let category = world.sound_category()?;
    // rust: world.play_sound(level, position, sound, category)?;
    // rust: Ok(true)
}
}
}
}
