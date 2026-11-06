//! Transpiled from Horizon Rust crate
package horizon_world_item_template

import "core:fmt"
import "core:mem"
import "core:math"

// Immutable item templates and strict stack validation. Template component
// patches are interpreted against the current item prototype when used.
// Component schemas supply typed size queries and contained-item validation.
// use crate::{
    // rust: component_patch::{Patch, Prototype},
    // rust: item_stack_refs::{ItemStacks, StackRef},
    // rust: item_stack_storage::ItemStackData,
}
// use std::{fmt, rc::Rc};

    // rust: pub trait ValidationRules<I, K, V> {
    // rust: type ContentsError;
has_max_damage :: proc(self: ^Self, stack: ^ItemStackData<I) -> b {
    // Ported from Horizon
    return {}
}
    // The component default is one, including on an empty stack.
max_stack_size :: proc(self: ^Self, stack: ^ItemStackData<I) -> i {
    // Ported from Horizon
    return {}
}
    // Validate container sizes, then bundle sizes and weight, then charged
    // projectile sizes. Only the immediate contained sizes are checked.
validate_contents :: proc(self: ^Self, stack: ^ItemStackData<I) -> R {
    // Ported from Horizon
    return {}
}
}
    // rust: pub type Creation<I, K, V, E> = (StackRef<I, K, V>, Option<ValidationError<E>>);
ValidationError :: enum {
    StackableDamageable,
    Contents(E),
    TooManyItems { count: i32, maximum: i32 },
}
    // rust: pub fn validate_strict<
    // rust: I: Copy + Eq,
    // rust: K: Clone + Eq,
    // rust: V: Clone + PartialEq,
    // rust: R: ValidationRules<I, K, V>,
    // rust: >(
    // rust: stack: &ItemStackData<I, K, V>,
    // rust: rules: &R,
    // rust: ) -> Result<(), ValidationError<R::ContentsError>> {
    // rust: if rules.has_max_damage(stack) && rules.max_stack_size(stack) > 1 {
    // rust: return Err(ValidationError::StackableDamageable);
}
    // rust: rules
    // rust: .validate_contents(stack)
    // rust: .map_err(ValidationError::Contents)?;
    // rust: let count = stack.count();
    // rust: let maximum = rules.max_stack_size(stack);
    // rust: if count > maximum {
    // rust: return Err(ValidationError::TooManyItems { count, maximum });
}
    // rust: Ok(())
}
// A rejected patch restores the original raw patch, including redundant entries.
// The error is returned for the caller's diagnostic logger.
    // rust: pub fn apply_validated<
    // rust: I: Copy + Eq,
    // rust: K: Clone + Eq,
    // rust: V: Clone + PartialEq,
    // rust: R: ValidationRules<I, K, V>,
    // rust: >(
    // rust: stack: &mut ItemStackData<I, K, V>,
    // rust: patch: &Patch<K, V>,
    // rust: rules: &R,
    // rust: ) -> Result<(), ValidationError<R::ContentsError>> {
    // rust: let previous = stack.components.as_patch();
    // rust: stack.components.apply_patch(patch);
    // rust: let result = validate_strict(stack, rules);
    // rust: if result.is_err() {
    // rust: stack.components.restore_patch(&previous);
}
    // rust: result
}
TemplateError :: enum {
    EmptyItem,
    EmptyStack,
}
    // rust: impl fmt::Display for TemplateError {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::EmptyItem => "Item must be non-empty",
    // rust: Self::EmptyStack => "Stack must be non-empty",
    // rust: })
}
}
    // rust: impl std::error::Error for TemplateError {}
Data :: struct {
    item: I,
    air: I,
    count: i32,
    patch: Patch<K,
}
ItemTemplate :: struct {
    // rust: impl<I, K, V> Clone for ItemTemplate<I, K, V> {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(self.0.clone())
}
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq> ItemTemplate<I, K, V> {
    // The native constructor rejects zero, but permits negative counts.
new :: proc(item: I, air: I, count: i32, patch: Patch<K) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if item == air || count == 0 {
    // rust: return Err(TemplateError::EmptyItem);
}
    // rust: Ok(Self(Rc::new(Data {
    // rust: item,
    // rust: air,
    // rust: count,
    // rust: patch,
    // rust: })))
}
from_stack :: proc(stack: ^ItemStackData<I, air: I) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(stack.item(), air, stack.count(), stack.visible_patch())
}
    // rust: pub fn from_non_empty_stack(
    // rust: stack: &ItemStackData<I, K, V>,
    // rust: air: I,
    // rust: ) -> Result<Self, TemplateError> {
    // rust: if stack.is_empty() {
    // rust: return Err(TemplateError::EmptyStack);
}
    // rust: Self::from_stack(stack, air)
}
    // rust: pub fn from_non_empty_stack_with_count(
    // rust: stack: &ItemStackData<I, K, V>,
    // rust: air: I,
    // rust: count: i32,
    // rust: ) -> Result<Self, TemplateError> {
    // rust: if stack.is_empty() || count <= 0 {
    // rust: return Err(TemplateError::EmptyStack);
}
    // rust: Self::new(stack.item(), air, count, stack.visible_patch())
}
same_reference :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Rc::ptr_eq(&self.0, &other.0)
}
item :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.0.item
}
count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.count
}
patch :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0.patch
}
with_count :: proc(self: ^Self, count: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if count == self.count() {
    // rust: return Ok(self.clone());
}
    // rust: Self::new(self.item(), self.0.air, count, self.0.patch.clone())
}
    // rust: pub fn component<'a>(&'a self, prototype: &'a Prototype<K, V>, key: &K) -> Option<&'a V> {
    // rust: match self.0.patch.entries().iter().find(|(k, _)| k == key) {
    // rust: Some((_, value)) => value.as_ref(),
    // rust: None => prototype.get(key),
}
}
    // Invalid creations return the store's canonical EMPTY. The optional error
    // lets the caller log the rejected template without changing game behavior.
    // rust: pub fn create<R: ValidationRules<I, K, V>>(
    // rust: &self,
    // rust: stacks: &ItemStacks<I, K, V>,
    // rust: prototype: Prototype<K, V>,
    // rust: rules: &R,
    // rust: ) -> Creation<I, K, V, R::ContentsError> {
    // rust: self.apply(stacks, prototype, self.count(), &Patch::new([]), rules)
}
    // The supplied patch is the base; this template's patch takes precedence.
    // rust: pub fn apply<R: ValidationRules<I, K, V>>(
    // rust: &self,
    // rust: stacks: &ItemStacks<I, K, V>,
    // rust: prototype: Prototype<K, V>,
    // rust: count: i32,
    // rust: base: &Patch<K, V>,
    // rust: rules: &R,
    // rust: ) -> Creation<I, K, V, R::ContentsError> {
    // rust: let stack = stacks.create(self.item(), count, prototype);
    // rust: {
    // rust: let mut data = stack.write();
    // rust: data.components.apply_patch(base);
    // rust: data.components.apply_patch(self.patch());
}
    // rust: let error = validate_strict(&stack.read(), rules).err();
    // rust: if error.is_some() {
    // rust: (stacks.empty(), error)
    // rust: } else {
    // rust: (stack, None)
}
}
}

    // rust: impl<I: PartialEq, K: Eq, V: PartialEq> PartialEq for ItemTemplate<I, K, V> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.item == other.0.item
    // rust: && self.0.count == other.0.count
    // rust: && self.0.patch == other.0.patch
}
}
