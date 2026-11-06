//! Transpiled from Horizon Rust crate
//! Module: horizon-world_consumable
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Consumable component timing and ordered particle/sound emission.
// use horizon_core::random::RandomSource;

pub const UseAnimation = enum {
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
};

pub const Consumable = struct {
    seconds: f32,
    animation: UseAnimation,
    sound: S,
    particles: bool,
    effects: std.ArrayList(E),
};
    // rust: impl<S: PartialEq, E: PartialEq> PartialEq for Consumable<S, E> {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
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
    /// This is the supplied random source, which may differ from the actor's
    /// direct field used inside spawn_item_particles.
pub fn random_source(self: *Self, random: Self::Random) *;
pub fn spawn_item_particles(self: *Self, stack: Self::Stack, count: i32) R;
    /// Native class/interface membership, not a virtual actor call.
pub fn overrides_consume_sound(self: *Self) b;
pub fn consume_sound(self: *Self, stack: Self::Stack) R;
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: Self::Sound,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: impl<S, E> Consumable<S, E> {
pub fn ticks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.seconds * 20.0) as i32
}
pub fn should_emit(self: *Self, remaining: i32) b {
    // Implementation ported from Horizon
    return undefined;
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

/// Actor and component services used around the concrete emission and stack
/// kernels. Listener enumeration must retain the component map's native order.
    // rust: pub trait ConsumptionWorld<I, K, V, E>: EmissionWorld<Stack = StackRef<I, K, V>> {
    // rust: type Level: Copy;
    // rust: type Hand;
pub fn food(self: *Self, stack: *StackRef<I) O;
pub fn is_player(self: *Self) b;
pub fn can_eat(self: *Self, always: bool) R;
pub fn start_using(self: *Self, hand: Self::Hand) R;
pub fn level(self: *Self) R;
pub fn get_random(self: *Self) R;
pub fn is_server_player(self: *Self) b;
pub fn award_item_used(self: *Self, item: I) R;
pub fn consume_criterion(self: *Self, stack: StackRef<I) R;
    // rust: fn consume_listeners(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: stack: StackRef<I, K, V>,
    // rust: component: &Consumable<Self::Sound, E>,
    // rust: ) -> Result<(), Self::Error>;
pub fn is_client(self: *Self, level: Self::Level) R;
    // rust: fn apply_effect(
    // rust: &mut self,
    // rust: effect: &E,
    // rust: level: Self::Level,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<bool, Self::Error>;
pub fn consume_event(self: *Self, drink: bool) R;
pub fn infinite_materials(self: *Self) R;
}

pub const ConsumeResult = enum {
    Fail,
    /// Native CONSUME uses no swing; timed use has no transformed stack.
    Consume {,
    transformed: Option<T>,
    // rust: },
};
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
