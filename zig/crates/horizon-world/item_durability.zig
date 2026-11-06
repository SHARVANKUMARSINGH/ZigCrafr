//! Transpiled from Horizon Rust crate
//! Module: horizon-world_item_durability
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item-stack durability storage and mutation ordering. This is the durability
//! projection of a stack, not a replacement for its complete component map.
pub const DurabilityStack = struct {
    count: i32,
    air: bool,
    max_damage: ?i32,
    damage: ?i32,
    unbreakable: bool,
};

    // rust: impl DurabilityStack {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.air || self.count <= 0
}
pub fn count(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
pub fn max_damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.max_damage.unwrap_or(0)
}
}
pub fn damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.damage.unwrap_or(0)
}
    // rust: value.max(0).min(self.max_damage())
}
pub fn set_damage(self: *Self, value: i32) void {
}
    // rust: self.damage = Some(value.max(0).min(self.max_damage()));
}
pub fn is_damageable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.is_empty() && self.max_damage.is_some() && !self.unbreakable && self.damage.is_some()
}
pub fn is_damaged(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable() && self.damage() > 0
}
pub fn is_broken(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage()
}
pub fn next_damage_will_break(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage().wrapping_sub(1)
}
pub fn grow(self: *Self, amount: i32) void {
}
    // rust: self.count = self.count().wrapping_add(amount);
}
pub fn shrink(self: *Self, amount: i32) void {
}
    // rust: self.grow(amount.wrapping_neg());
}
}

/// Storage operations used by the native durability algorithm. Component-backed
/// implementations can preserve patch mutations and errors at each write.
    // rust: pub trait DurabilityStorage: Clone {
    // rust: type Error;
pub fn is_damageable(self: *Self) b;
pub fn damage(self: *Self) i;
pub fn max_damage(self: *Self) i;
pub fn set_damage(self: *Self, value: i32) R;
pub fn is_broken(self: *Self) b;
pub fn shrink(self: *Self, amount: i32) void;
}
    // rust: impl DurabilityStorage for DurabilityStack {
    // rust: type Error = std::convert::Infallible;
pub fn is_damageable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable()
}
pub fn damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.damage()
}
pub fn max_damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.max_damage()
}
pub fn set_damage(self: *Self, value: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set_damage(value);
    // rust: Ok(())
}
pub fn is_broken(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_broken()
}
pub fn shrink(self: *Self, amount: i32) void {
}
    // rust: self.shrink(amount);
}
}
    // rust: pub trait DurabilityWorld {
    // rust: type Error;
    // rust: type Stack: DurabilityStorage;
pub fn storage_error(error: <Self::Stack as DurabilityStorage>::Error) S;
pub fn infinite_materials(self: *Self, stack: *mut Self::Stack) R;
    /// Positive durability changes pass through the enchantment float pipeline,
    /// including when the stack has no enchantments.
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
    /// Called after shrinking the original stack, with the pre-shrink copy.
pub fn broken(self: *Self, stack: *mut Self::Stack, copy: Self::Stack) R;
}

pub fn unenchanted_change(amount: i32) i {
    // Implementation ported from Horizon
    return undefined;
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

/// The server-level overload; callers supply the already selected player kind.
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

/// The body after the server-player/level checks of hurtWithoutBreaking.
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
