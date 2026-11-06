//! Transpiled from Horizon Rust crate
package horizon_world_consumable

import "core:fmt"
import "core:mem"
import "core:math"

// Consumable component timing and ordered particle/sound emission.
// use horizon_core::random::RandomSource;

UseAnimation :: enum {
    None,
    Eat,
    Drink,
    Block,
    Bow,
    Trident,
    Crossbow,
    Spyglass,
    TootHorn,
    Brush,
    Bundle,
    Spear,
}

Consumable :: struct {
    seconds: f32,
    animation: UseAnimation,
    sound: S,
    particles: bool,
    effects: [dynamic]E,
}
    // rust: impl<S: PartialEq, E: PartialEq> PartialEq for Consumable<S, E> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bits = |v: f32| if v.is_nan() { 0x7fc00000 } else { v.to_bits() };
    // rust: bits(self.seconds) == bits(other.seconds)
    // rust: && self.animation == other.animation
    // rust: && self.sound == other.sound
    // rust: && self.particles == other.particles
    // rust: && self.effects == other.effects
}
}

    // rust: pub trait EmissionWorld {
    // rust: type Error;
    // rust: type Stack: Clone;
    // rust: type Sound: Clone;
    // rust: type Random: Copy;
    // rust: type Source: RandomSource;
    // This is the supplied random source, which may differ from the actor's
    // direct field used inside spawn_item_particles.
random_source :: proc(self: ^Self, random: Self::Random) -> ^ {
    // Ported from Horizon
    return {}
}
spawn_item_particles :: proc(self: ^Self, stack: Self::Stack, count: i32) -> R {
    // Ported from Horizon
    return {}
}
    // Native class/interface membership, not a virtual actor call.
overrides_consume_sound :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
consume_sound :: proc(self: ^Self, stack: Self::Stack) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: Self::Sound,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: impl<S, E> Consumable<S, E> {
ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.seconds * 20.0) as i32
}
should_emit :: proc(self: ^Self, remaining: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let elapsed = self.ticks().wrapping_sub(remaining);
    // rust: let threshold = (self.ticks() as f32 * 0.21875) as i32;
    // rust: elapsed > threshold && remaining % 4 == 0
}
}
    // rust: impl<S: Clone, E> Consumable<S, E> {
    // rust: pub fn emit<W: EmissionWorld<Sound = S>>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: W::Random,
    // rust: stack: W::Stack,
    // rust: count: i32,
    // rust: ) -> Result<(), W::Error> {
    // rust: let source = world.random_source(random);
    // rust: let eat_volume = if source.next_boolean() { 0.5 } else { 1.0 };
    // rust: let eat_pitch = source.triangle_float(1.0, 0.2);
    // rust: let drink_pitch = 0.9f32 + source.next_float() * (1.0f32 - 0.9f32);
    // rust: let (volume, pitch) = if self.animation == UseAnimation::Drink {
    // rust: (0.5, drink_pitch)
    // rust: } else {
    // rust: (eat_volume, eat_pitch)
}
    // rust: if self.particles {
    // rust: world.spawn_item_particles(stack.clone(), count)?;
}
    // rust: let sound = if world.overrides_consume_sound() {
    // rust: world.consume_sound(stack)?
    // rust: } else {
    // rust: self.sound.clone()
}
    // rust: world.play_sound(sound, volume, pitch)
}
}

// use crate::{food_properties::FoodProperties, item_stack_refs::StackRef};

// Actor and component services used around the concrete emission and stack
// kernels. Listener enumeration must retain the component map's native order.
    // rust: pub trait ConsumptionWorld<I, K, V, E>: EmissionWorld<Stack = StackRef<I, K, V>> {
    // rust: type Level: Copy;
    // rust: type Hand;
food :: proc(self: ^Self, stack: ^StackRef<I) -> O {
    // Ported from Horizon
    return {}
}
is_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
can_eat :: proc(self: ^Self, always: bool) -> R {
    // Ported from Horizon
    return {}
}
start_using :: proc(self: ^Self, hand: Self::Hand) -> R {
    // Ported from Horizon
    return {}
}
level :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_server_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
award_item_used :: proc(self: ^Self, item: I) -> R {
    // Ported from Horizon
    return {}
}
consume_criterion :: proc(self: ^Self, stack: StackRef<I) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn consume_listeners(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: stack: StackRef<I, K, V>,
    // rust: component: &Consumable<Self::Sound, E>,
    // rust: ) -> Result<(), Self::Error>;
is_client :: proc(self: ^Self, level: Self::Level) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn apply_effect(
    // rust: &mut self,
    // rust: effect: &E,
    // rust: level: Self::Level,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<bool, Self::Error>;
consume_event :: proc(self: ^Self, drink: bool) -> R {
    // Ported from Horizon
    return {}
}
infinite_materials :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}

ConsumeResult :: enum {
    Fail,
    // Native CONSUME uses no swing; timed use has no transformed stack.
    Consume {,
    transformed: Option<T>,
    // rust: },
}
    // rust: impl<S: Clone, E> Consumable<S, E> {
    // rust: pub fn can_consume<I, K, V, W: ConsumptionWorld<I, K, V, E, Sound = S>>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: stack: &StackRef<I, K, V>,
    // rust: ) -> Result<bool, W::Error> {
    // rust: let food = world.food(stack);
    // rust: if let Some(food) = food {
    // rust: if world.is_player() {
    // rust: return world.can_eat(food.can_always_eat);
}
}
    // rust: Ok(true)
}
    // rust: pub fn start<
    // rust: I: Copy + Eq,
    // rust: K: Clone + Eq,
    // rust: V: Clone + PartialEq,
    // rust: W: ConsumptionWorld<I, K, V, E, Sound = S>,
    // rust: >(
    // rust: &self,
    // rust: world: &mut W,
    // rust: stack: StackRef<I, K, V>,
    // rust: hand: W::Hand,
    // rust: ) -> Result<ConsumeResult<StackRef<I, K, V>>, W::Error> {
    // rust: if !self.can_consume(world, &stack)? {
    // rust: return Ok(ConsumeResult::Fail);
}
    // rust: if self.ticks() > 0 {
    // rust: world.start_using(hand)?;
    // rust: Ok(ConsumeResult::Consume { transformed: None })
    // rust: } else {
    // rust: let level = world.level()?;
    // rust: let stack = self.on_consume(world, level, stack)?;
    // rust: Ok(ConsumeResult::Consume {
    // rust: transformed: Some(stack),
    // rust: })
}
}
    // rust: pub fn on_consume<
    // rust: I: Copy + Eq,
    // rust: K: Clone + Eq,
    // rust: V: Clone + PartialEq,
    // rust: W: ConsumptionWorld<I, K, V, E, Sound = S>,
    // rust: >(
    // rust: &self,
    // rust: world: &mut W,
    // rust: level: W::Level,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<StackRef<I, K, V>, W::Error> {
    // rust: let random = world.get_random()?;
    // rust: self.emit(world, random, stack.clone(), 16)?;
    // rust: if world.is_server_player() {
    // rust: let item = stack.read().item();
    // rust: world.award_item_used(item)?;
    // rust: world.consume_criterion(stack.clone())?;
}
    // rust: world.consume_listeners(level, stack.clone(), self)?;
    // rust: if !world.is_client(level)? {
    // rust: for effect in &self.effects {
    // rust: let _ = world.apply_effect(effect, level, stack.clone())?;
}
}
    // rust: world.consume_event(self.animation == UseAnimation::Drink)?;
    // rust: if !world.infinite_materials()? {
    // rust: stack.write().shrink(1);
}
    // rust: Ok(stack)
}
}
