//! Transpiled from Horizon Rust crate
//! Module: horizon-core_heap
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Array heap with the pinned JDK PriorityQueue's equal-key and iterator-removal
//! behavior. Equal comparator keys are observable in saved and loaded ticks.
// use std::{cmp::Ordering, collections::VecDeque};

    // rust: pub(super) struct Heap<T> {
    // rust: pub(super) values: Vec<T>,
}
    // rust: impl<T> Default for Heap<T> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { values: Vec::new() }
}
}
    // rust: impl<T: Copy + PartialEq> Heap<T> {
    // rust: pub(super) fn peek(&self) -> Option<T> {
    // rust: self.values.first().copied()
}
    // rust: pub(super) fn push(&mut self, value: T, compare: impl Fn(T, T) -> Ordering) {
    // rust: self.values.push(value);
    // rust: self.up(self.values.len() - 1, value, &compare);
}
pub fn up(self: *Self, mut index: usize, value: T, compare: *impl Fn(T) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while index > 0 {
    // rust: let parent = (index - 1) / 2;
    // rust: if compare(value, self.values[parent]) != Ordering::Less {
    // rust: break;
}
    // rust: self.values[index] = self.values[parent];
    // rust: index = parent;
}
    // rust: self.values[index] = value;
    // rust: index
}
pub fn down(self: *Self, mut index: usize, value: T, compare: *impl Fn(T) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = self.values.len() / 2;
    // rust: while index < half {
    // rust: let mut child = index * 2 + 1;
    // rust: let right = child + 1;
    // rust: if right < self.values.len()
    // rust: && compare(self.values[child], self.values[right]) == Ordering::Greater
    // rust: {
    // rust: child = right;
}
    // rust: if compare(value, self.values[child]) != Ordering::Greater {
    // rust: break;
}
    // rust: self.values[index] = self.values[child];
    // rust: index = child;
}
    // rust: self.values[index] = value;
    // rust: index
}
    // rust: pub(super) fn pop(&mut self, compare: impl Fn(T, T) -> Ordering) -> Option<T> {
    // rust: let first = self.peek()?;
    // rust: let last = self.values.pop().unwrap();
    // rust: if !self.values.is_empty() {
    // rust: self.down(0, last, &compare);
}
    // rust: Some(first)
}
pub fn remove_at(self: *Self, index: usize, compare: *impl Fn(T) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let last = self.values.pop().unwrap();
    // rust: if index == self.values.len() {
    // rust: return None;
}
    // rust: if self.down(index, last, compare) == index && self.up(index, last, compare) != index {
    // rust: Some(last)
    // rust: } else {
    // rust: None
}
}
    // rust: pub(super) fn remove_if(
    // rust: &mut self,
    // rust: mut predicate: impl FnMut(T) -> bool,
    // rust: compare: impl Fn(T, T) -> Ordering,
    // rust: ) {
    // rust: let mut cursor = 0;
    // rust: let mut moved = VecDeque::new();
    // rust: while cursor < self.values.len() {
    // rust: let value = self.values[cursor];
    // rust: cursor += 1;
    // rust: if predicate(value) {
    // rust: if let Some(value) = self.remove_at(cursor - 1, &compare) {
    // rust: moved.push_back(value);
    // rust: } else {
    // rust: cursor -= 1;
}
}
}
    // rust: while let Some(value) = moved.pop_front() {
    // rust: if predicate(value) {
    // rust: let index = self
    // rust: .values
    // rust: .iter()
    // rust: .position(|&candidate| candidate == value)
    // rust: .unwrap();
    // rust: self.remove_at(index, &compare);
}
}
}
}
