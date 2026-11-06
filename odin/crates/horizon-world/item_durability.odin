//! Transpiled from Horizon Rust crate
package horizon_world_item_durability

import "core:fmt"
import "core:mem"
import "core:math"

// Item-stack durability storage and mutation ordering. This is the durability
// projection of a stack, not a replacement for its complete component map.
DurabilityStack :: struct {
    count: i32,
    air: bool,
    max_damage: Maybe(i32),
    damage: Maybe(i32),
    unbreakable: bool,
}

    // rust: impl DurabilityStack {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.air || self.count <= 0
}
count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
max_damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.max_damage.unwrap_or(0)
}
}
damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let value = if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.damage.unwrap_or(0)
}
    // rust: value.max(0).min(self.max_damage())
}
set_damage :: proc(self: ^Self, value: i32) {
}
    // rust: self.damage = Some(value.max(0).min(self.max_damage()));
}
is_damageable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.is_empty() && self.max_damage.is_some() && !self.unbreakable && self.damage.is_some()
}
is_damaged :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable() && self.damage() > 0
}
is_broken :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage()
}
next_damage_will_break :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage().wrapping_sub(1)
}
grow :: proc(self: ^Self, amount: i32) {
}
    // rust: self.count = self.count().wrapping_add(amount);
}
shrink :: proc(self: ^Self, amount: i32) {
}
    // rust: self.grow(amount.wrapping_neg());
}
}

// Storage operations used by the native durability algorithm. Component-backed
// implementations can preserve patch mutations and errors at each write.
    // rust: pub trait DurabilityStorage: Clone {
    // rust: type Error;
is_damageable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
max_damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
set_damage :: proc(self: ^Self, value: i32) -> R {
    // Ported from Horizon
    return {}
}
is_broken :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
shrink :: proc(self: ^Self, amount: i32) {
}
}
    // rust: impl DurabilityStorage for DurabilityStack {
    // rust: type Error = std::convert::Infallible;
is_damageable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable()
}
damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.damage()
}
max_damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.max_damage()
}
set_damage :: proc(self: ^Self, value: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.set_damage(value);
    // rust: Ok(())
}
is_broken :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_broken()
}
shrink :: proc(self: ^Self, amount: i32) {
}
    // rust: self.shrink(amount);
}
}
    // rust: pub trait DurabilityWorld {
    // rust: type Error;
    // rust: type Stack: DurabilityStorage;
storage_error :: proc(error: <Self::Stack as DurabilityStorage>::Error) -> S {
    // Ported from Horizon
    return {}
}
infinite_materials :: proc(self: ^Self, stack: ^Self::Stack) -> R {
    // Ported from Horizon
    return {}
}
    // Positive durability changes pass through the enchantment float pipeline,
    // including when the stack has no enchantments.
    // rust: fn process_enchantments(
    // rust: &mut self,
    // rust: stack: &mut Self::Stack,
    // rust: amount: i32,
    // rust: ) -> Result<i32, Self::Error>;
    // rust: fn durability_changed(
    // rust: &mut self,
    // rust: stack: &mut Self::Stack,
    // rust: damage: i32,
    // rust: ) -> Result<(), Self::Error>;
    // Called after shrinking the original stack, with the pre-shrink copy.
broken :: proc(self: ^Self, stack: ^Self::Stack, copy: Self::Stack) -> R {
    // Ported from Horizon
    return {}
}
}

unenchanted_change :: proc(amount: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (amount as f32) as i32
}

    // rust: pub fn process_change<W: DurabilityWorld>(
    // rust: stack: &mut W::Stack,
    // rust: world: &mut W,
    // rust: amount: i32,
    // rust: server_player: bool,
    // rust: ) -> Result<i32, W::Error> {
    // rust: if !stack.is_damageable() || (server_player && world.infinite_materials(stack)?) {
    // rust: return Ok(0);
}
    // rust: if amount > 0 {
    // rust: world.process_enchantments(stack, amount)
    // rust: } else {
    // rust: Ok(amount)
}
}

    // rust: pub fn apply_damage<W: DurabilityWorld>(
    // rust: stack: &mut W::Stack,
    // rust: world: &mut W,
    // rust: damage: i32,
    // rust: server_player: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: apply_damage_with_break_callback(stack, world, damage, server_player, true)
}

    // rust: fn apply_damage_with_break_callback<W: DurabilityWorld>(
    // rust: stack: &mut W::Stack,
    // rust: world: &mut W,
    // rust: damage: i32,
    // rust: server_player: bool,
    // rust: notify_break: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: if server_player {
    // rust: world.durability_changed(stack, damage)?;
}
    // rust: stack.set_damage(damage).map_err(W::storage_error)?;
    // rust: if stack.is_broken() {
    // rust: let copy = stack.clone();
    // rust: stack.shrink(1);
    // rust: if notify_break {
    // rust: world.broken(stack, copy)?;
}
}
    // rust: Ok(())
}

// The server-level overload; callers supply the already selected player kind.
    // rust: pub fn hurt_and_break<W: DurabilityWorld>(
    // rust: stack: &mut W::Stack,
    // rust: world: &mut W,
    // rust: amount: i32,
    // rust: server_player: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: let amount = process_change(stack, world, amount, server_player)?;
    // rust: if amount != 0 {
    // rust: let damage = stack.damage().wrapping_add(amount);
    // rust: apply_damage(stack, world, damage, server_player)?;
}
    // rust: Ok(())
}

// The body after the server-player/level checks of hurtWithoutBreaking.
    // rust: pub fn hurt_without_breaking<W: DurabilityWorld>(
    // rust: stack: &mut W::Stack,
    // rust: world: &mut W,
    // rust: amount: i32,
    // rust: ) -> Result<(), W::Error> {
    // rust: let amount = process_change(stack, world, amount, true)?;
    // rust: if amount != 0 {
    // rust: let damage = stack
    // rust: .damage()
    // rust: .wrapping_add(amount)
    // rust: .min(stack.max_damage().wrapping_sub(1));
    // rust: apply_damage_with_break_callback(stack, world, damage, true, false)?;
}
    // rust: Ok(())
}
