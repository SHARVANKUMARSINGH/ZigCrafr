//! Transpiled from Horizon Rust crate
package horizon_client_join_seq

import "core:fmt"
import "core:mem"
import "core:math"

// PURPOSE: the join sequence: when each entity joined the level, kept in one
// counter that rises with every join, whatever the kind.
// WHY: ids do not say it (primed TNT, falling blocks, projectiles, tridents and
// rockets take theirs late, in kind-list order), and vanilla ticks entities in
// the order they were added, so a walk in that order needs a number that does
// (#6509, tick order slice).
// REFS: vanilla `EntityLookup` / `EntitySectionStorage` insertion order,
// `PersistentEntitySectionManager.addEntity`; issue #6509; PR #7808.
// LOGS: none. READS-BY: `game/entity.rs` (the join-order walk, the save order).
// ENDS-WHEN: kinds share one stored entity list, which is its own order.

// use std::ops::{Deref, DerefMut};
// use std::sync::atomic::{AtomicU64, Ordering};

NEXT :: AtomicU64::new(1)

// When an entity joined: a number above every earlier join's. Zero means it
// has not joined a list yet. One counter for the process, so entities of
// different levels compare too; only the order of the numbers means anything.
JoinSeq :: struct {

    // rust: impl JoinSeq {
    // Not joined yet.
UNJOINED :: Self(0)
    // The next number: one relaxed add, and only when something joins.
next :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(NEXT.fetch_add(1, Ordering::Relaxed))
}
    // Above every number a join can get.
MAX :: Self(u64::MAX)
    // The number the next join will get or a later one: every entity that has
    // joined so far is below it.
upcoming :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(NEXT.load(Ordering::Relaxed))
}
is_joined :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0 != 0
}
get :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0
}
}

// A kind that stores when it joined.
    // rust: pub trait Joined {
join_seq :: proc(self: ^Self) -> J {
    // Ported from Horizon
    return {}
}
set_join_seq :: proc(self: ^Self, seq: JoinSeq) {
}
}

// Implements [`Joined`] for a struct with a `join: JoinSeq` field.
    // rust: macro_rules! impl_joined {
    // rust: ($($ty:ty),* $(,)?) => {$(
    // rust: impl $crate::join_seq::Joined for $ty {
join_seq :: proc(self: ^Self) -> $ {
    // Ported from Horizon
    return {}
}
    // rust: self.join
}
set_join_seq :: proc(self: ^Self, seq: $crate::join_seq::JoinSeq) {
}
    // rust: self.join = seq;
}
}
    // rust: )*};
}

// One kind's entity list. It is a `Vec` in every way but one: an entity that
// is put in without a join number (`push`, `insert`, `extend`) gets the next
// one, so a join cannot be missed by a spawn site. One already numbered (taken
// out and put back, or a list rebuilt) keeps its number.
JoinList :: struct {

    // rust: impl<T> Default for JoinList<T> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(Vec::new())
}
}

    // rust: impl<T> From<Vec<T>> for JoinList<T> {
    // A list put back after a tick took it: the same storage, nothing copied
    // and nothing renumbered. An entity in it that never joined stays
    // unnumbered, which the join-order walk reports.
from :: proc(list: [dynamic]T) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(list)
}
}

    // rust: impl<T> From<JoinList<T>> for Vec<T> {
from :: proc(list: JoinList<T>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: list.0
}
}

    // rust: impl<T> Deref for JoinList<T> {
    // rust: type Target = Vec<T>;
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0
}
}
    // rust: impl<T> DerefMut for JoinList<T> {
deref_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.0
}
}

    // rust: impl<T: Joined> JoinList<T> {
number :: proc(entity: ^T) {
}
    // rust: if !entity.join_seq().is_joined() {
    // rust: entity.set_join_seq(JoinSeq::next());
}
}
push :: proc(self: ^Self, mut entity: T) {
}
    // rust: Self::number(&mut entity);
    // rust: self.0.push(entity);
}
insert :: proc(self: ^Self, index: uint, mut entity: T) {
}
    // rust: Self::number(&mut entity);
    // rust: self.0.insert(index, entity);
}
extend :: proc(self: ^Self, entities: impl IntoIterator<Item = T>) {
}
    // rust: for entity in entities {
    // rust: self.push(entity);
}
}
}

    // rust: impl<'a, T> IntoIterator for &'a JoinList<T> {
    // rust: type Item = &'a T;
    // rust: type IntoIter = std::slice::Iter<'a, T>;
into_iter :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter()
}
}
    // rust: impl<'a, T> IntoIterator for &'a mut JoinList<T> {
    // rust: type Item = &'a mut T;
    // rust: type IntoIter = std::slice::IterMut<'a, T>;
into_iter :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter_mut()
}
}
    // rust: impl<T> IntoIterator for JoinList<T> {
    // rust: type Item = T;
    // rust: type IntoIter = std::vec::IntoIter<T>;
into_iter :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.into_iter()
}
}
