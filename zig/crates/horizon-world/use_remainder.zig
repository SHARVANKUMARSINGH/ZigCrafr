//! Transpiled from Horizon Rust crate
//! Module: horizon-world_use_remainder
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Use-remainder conversion preserves stack identity and only creates a
//! remainder after an actual count decrease for a finite-material actor.
// use crate::item_stack_refs::StackRef;

    // rust: pub fn convert<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, E>(
    // rust: stack: StackRef<I, K, V>,
    // rust: original_count: i32,
    // rust: infinite_materials: bool,
    // rust: create: impl FnOnce() -> StackRef<I, K, V>,
    // rust: extra: impl FnOnce(StackRef<I, K, V>) -> Result<(), E>,
    // rust: ) -> Result<StackRef<I, K, V>, E> {
    // rust: convert_with(
    // rust: &mut (),
    // rust: stack,
    // rust: original_count,
    // rust: infinite_materials,
    // rust: |()| create(),
    // rust: |(), remainder| extra(remainder),
    // rust: )
}
/// Variant for creation and extra-item effects that share one mutable world.
/// The world is borrowed only for the current callback.
    // rust: pub fn convert_with<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, E, W>(
    // rust: world: &mut W,
    // rust: stack: StackRef<I, K, V>,
    // rust: original_count: i32,
    // rust: infinite_materials: bool,
    // rust: create: impl FnOnce(&mut W) -> StackRef<I, K, V>,
    // rust: extra: impl FnOnce(&mut W, StackRef<I, K, V>) -> Result<(), E>,
    // rust: ) -> Result<StackRef<I, K, V>, E> {
    // rust: if infinite_materials || stack.read().count() >= original_count {
    // rust: return Ok(stack);
}
    // rust: let remainder = create(world);
    // rust: if stack.read().is_empty() {
    // rust: return Ok(remainder);
}
    // rust: extra(world, remainder)?;
    // rust: Ok(stack)
}
