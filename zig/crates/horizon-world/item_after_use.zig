//! Transpiled from Horizon Rust crate
//! Module: horizon-world_item_after_use
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! ItemStack finish-use component effects over shared stack storage. The copy
//! captured before the item handler determines both remainder and cooldown.
// use crate::{
    // rust: component_patch::Prototype,
    // rust: item_cooldowns::UseCooldown,
    // rust: item_stack_refs::{ItemStacks, StackRef},
    // rust: item_stack_storage::ItemStackData,
    // rust: item_template::{ItemTemplate, ValidationRules},
    // rust: use_remainder,
}
    // rust: pub trait AfterUseWorld<I, K, V>: ValidationRules<I, K, V> {
    // rust: type Error;
    // rust: type Level;
    // rust: type Group;
pub fn remainder(self: *Self, stack: *ItemStackData<I) O;
pub fn cooldown(self: *Self, stack: *ItemStackData<I) O;
pub fn prototype(self: *Self, item: I) P;
    // rust: fn finish_item(
    // rust: &mut self,
    // rust: stack: StackRef<I, K, V>,
    // rust: level: Self::Level,
    // rust: ) -> Result<StackRef<I, K, V>, Self::Error>;
pub fn infinite_materials(self: *Self) R;
pub fn extra_item(self: *Self, stack: StackRef<I) R;
    // rust: fn apply_cooldown(
    // rust: &mut self,
    // rust: component: UseCooldown<Self::Group>,
    // rust: original: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: pub fn finish<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, W: AfterUseWorld<I, K, V>>(
    // rust: stacks: &ItemStacks<I, K, V>,
    // rust: world: &mut W,
    // rust: stack: StackRef<I, K, V>,
    // rust: level: W::Level,
    // rust: ) -> Result<StackRef<I, K, V>, W::Error> {
    // rust: let original = stacks.copy(&stack);
    // rust: let result = world.finish_item(stack, level)?;
    // rust: after_use(stacks, world, result, original)
}
    // rust: pub fn after_use<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, W: AfterUseWorld<I, K, V>>(
    // rust: stacks: &ItemStacks<I, K, V>,
    // rust: world: &mut W,
    // rust: mut result: StackRef<I, K, V>,
    // rust: original: StackRef<I, K, V>,
    // rust: ) -> Result<StackRef<I, K, V>, W::Error> {
    // rust: let remainder = world.remainder(&original.read());
    // rust: let cooldown = world.cooldown(&original.read());
    // rust: let count = original.read().count();
    // rust: if let Some(template) = remainder {
    // rust: let infinite = world.infinite_materials()?;
    // rust: result = use_remainder::convert_with(
    // rust: world,
    // rust: result,
    // rust: count,
    // rust: infinite,
    // rust: |world| {
    // rust: template
    // rust: .create(stacks, world.prototype(template.item()), world)
    // rust: .0
    // rust: },
    // rust: |world, extra| world.extra_item(extra),
    // rust: )?;
}
    // rust: if let Some(cooldown) = cooldown {
    // rust: world.apply_cooldown(cooldown, original)?;
}
    // rust: Ok(result)
}
