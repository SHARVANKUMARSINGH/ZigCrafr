//! Transpiled from Horizon Rust crate
//! Module: horizon-client_join_seq
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! PURPOSE: the join sequence: when each entity joined the level, kept in one
//! counter that rises with every join, whatever the kind.
//! WHY: ids do not say it (primed TNT, falling blocks, projectiles, tridents and
//! rockets take theirs late, in kind-list order), and vanilla ticks entities in
//! the order they were added, so a walk in that order needs a number that does
//! (#6509, tick order slice).
//! REFS: vanilla `EntityLookup` / `EntitySectionStorage` insertion order,
//! `PersistentEntitySectionManager.addEntity`; issue #6509; PR #7808.
//! LOGS: none. READS-BY: `game/entity.rs` (the join-order walk, the save order).
//! ENDS-WHEN: kinds share one stored entity list, which is its own order.

// use std::ops::{Deref, DerefMut};
// use std::sync::atomic::{AtomicU64, Ordering};

pub const NEXT: AtomicU64 = AtomicU64::new(1);

/// When an entity joined: a number above every earlier join's. Zero means it
/// has not joined a list yet. One counter for the process, so entities of
/// different levels compare too; only the order of the numbers means anything.
pub const JoinSeq = struct {};

    // rust: impl JoinSeq {
    /// Not joined yet.
pub const UNJOINED: Self = Self(0);
    /// The next number: one relaxed add, and only when something joins.
pub fn next() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(NEXT.fetch_add(1, Ordering::Relaxed))
}
    /// Above every number a join can get.
pub const MAX: Self = Self(u64::MAX);
    /// The number the next join will get or a later one: every entity that has
    /// joined so far is below it.
pub fn upcoming() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(NEXT.load(Ordering::Relaxed))
}
pub fn is_joined(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 != 0
}
pub fn get(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
}
}

/// A kind that stores when it joined.
    // rust: pub trait Joined {
pub fn join_seq(self: *Self) J;
pub fn set_join_seq(self: *Self, seq: JoinSeq) void;
}

/// Implements [`Joined`] for a struct with a `join: JoinSeq` field.
    // rust: macro_rules! impl_joined {
    // rust: ($($ty:ty),* $(,)?) => {$(
    // rust: impl $crate::join_seq::Joined for $ty {
pub fn join_seq(self: *Self) $ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.join
}
pub fn set_join_seq(self: *Self, seq: $crate::join_seq::JoinSeq) void {
}
    // rust: self.join = seq;
}
}
    // rust: )*};
}

/// One kind's entity list. It is a `Vec` in every way but one: an entity that
/// is put in without a join number (`push`, `insert`, `extend`) gets the next
/// one, so a join cannot be missed by a spawn site. One already numbered (taken
/// out and put back, or a list rebuilt) keeps its number.
pub const JoinList = struct {};

    // rust: impl<T> Default for JoinList<T> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(Vec::new())
}
}

    // rust: impl<T> From<Vec<T>> for JoinList<T> {
    /// A list put back after a tick took it: the same storage, nothing copied
    /// and nothing renumbered. An entity in it that never joined stays
    /// unnumbered, which the join-order walk reports.
pub fn from(list: std.ArrayList(T)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(list)
}
}

    // rust: impl<T> From<JoinList<T>> for Vec<T> {
pub fn from(list: JoinList<T>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: list.0
}
}

    // rust: impl<T> Deref for JoinList<T> {
    // rust: type Target = Vec<T>;
pub fn deref(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
}
    // rust: impl<T> DerefMut for JoinList<T> {
pub fn deref_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.0
}
}

    // rust: impl<T: Joined> JoinList<T> {
pub fn number(entity: *mut T) void {
}
    // rust: if !entity.join_seq().is_joined() {
    // rust: entity.set_join_seq(JoinSeq::next());
}
}
pub fn push(self: *Self, mut entity: T) void {
}
    // rust: Self::number(&mut entity);
    // rust: self.0.push(entity);
}
pub fn insert(self: *Self, index: usize, mut entity: T) void {
}
    // rust: Self::number(&mut entity);
    // rust: self.0.insert(index, entity);
}
pub fn extend(self: *Self, entities: impl IntoIterator<Item = T>) void {
}
    // rust: for entity in entities {
    // rust: self.push(entity);
}
}
}

    // rust: impl<'a, T> IntoIterator for &'a JoinList<T> {
    // rust: type Item = &'a T;
    // rust: type IntoIter = std::slice::Iter<'a, T>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.iter()
}
}
    // rust: impl<'a, T> IntoIterator for &'a mut JoinList<T> {
    // rust: type Item = &'a mut T;
    // rust: type IntoIter = std::slice::IterMut<'a, T>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.iter_mut()
}
}
    // rust: impl<T> IntoIterator for JoinList<T> {
    // rust: type Item = T;
    // rust: type IntoIter = std::vec::IntoIter<T>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.into_iter()
}
}
