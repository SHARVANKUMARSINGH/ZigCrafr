//! Transpiled from Horizon Rust crate
package horizon_items_random_sequences

import "core:fmt"
import "core:mem"
import "core:math"

// `RandomSequences`: the named random streams `/random` draws from.
// use horizon_core::random::{XoroshiroRandom, mix_stafford13, seed_from_hash};
// use std::collections::BTreeMap;

GOLDEN_RATIO :: 0x9e37_79b9_7f4a_7c15
SILVER_RATIO :: 0x6a09_e667_f3bc_c909

RandomSequences :: struct {
    salt: i32,
    include_world_seed: bool,
    include_sequence_id: bool,
    sequences: BTreeMap<string,
}
    // rust: impl Default for RandomSequences {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: salt: 0,
    // rust: include_world_seed: true,
    // rust: include_sequence_id: true,
    // rust: sequences: BTreeMap::new(),
}
}
}
// `RandomSequence.createSequence`.
create :: proc(id: string, world_seed: i64, salt: i32, world: bool, with_id: bool) -> X {
    // Ported from Horizon
    return {}
}
    // rust: let seed = (if world { world_seed } else { 0 }) ^ i64::from(salt);
    // rust: let mut lo = seed as u64 ^ SILVER_RATIO;
    // rust: let mut hi = lo.wrapping_add(GOLDEN_RATIO);
    // rust: if with_id {
    // rust: let [a, b] = seed_from_hash(id);
    // rust: lo ^= a;
    // rust: hi ^= b;
}
    // rust: XoroshiroRandom::from_state(mix_stafford13(lo), mix_stafford13(hi))
}
    // rust: impl RandomSequences {
get :: proc(self: ^Self, id: string, world_seed: i64) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let (salt, w, i) = (self.salt, self.include_world_seed, self.include_sequence_id);
    // rust: self.sequences
    // rust: .entry(id.to_owned())
    // rust: .or_insert_with(|| create(id, world_seed, salt, w, i))
}
    // Lends sequence `id` out (created if missing); `give_back` returns it.
lend :: proc(self: ^Self, id: string, world_seed: i64) -> X {
    // Ported from Horizon
    return {}
}
    // rust: self.get(id, world_seed);
    // rust: self.sequences.remove(id).expect("created")
}
give_back :: proc(self: ^Self, id: string, random: XoroshiroRandom) {
}
    // rust: self.sequences.insert(id, random);
}
    // `RandomSequences.CODEC` (`random_sequences.dat`'s data).
to_nbt :: proc(self: ^Self) -> h {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: let sequences = self
    // rust: .sequences
    // rust: .iter()
    // rust: .map(|(id, r)| {
    // rust: let (lo, hi) = r.state_words();
    // rust: (
    // rust: id.as_str(),
    // rust: Tag::compound([("source", Tag::LongArray(vec![lo as i64, hi as i64]))]),
    // rust: )
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: Tag::compound([
    // rust: ("salt", Tag::Int(self.salt)),
    // rust: (
    // rust: "include_world_seed",
    // rust: Tag::Byte(i8::from(self.include_world_seed)),
    // rust: ),
    // rust: (
    // rust: "include_sequence_id",
    // rust: Tag::Byte(i8::from(self.include_sequence_id)),
    // rust: ),
    // rust: ("sequences", Tag::compound(sequences)),
    // rust: ])
}
from_nbt :: proc(tag: ^horizon_world::nbt::Tag) -> S {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: let int = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: let mut out = Self {
    // rust: salt: int("salt").unwrap_or(0),
    // rust: include_world_seed: int("include_world_seed").unwrap_or(1) != 0,
    // rust: include_sequence_id: int("include_sequence_id").unwrap_or(1) != 0,
    // rust: sequences: BTreeMap::new(),
}
    // rust: if let Some(Tag::Compound(c)) = tag.get("sequences") {
    // rust: for (id, v) in c {
    // rust: let words = match v.get("source") {
    // rust: Some(Tag::LongArray(a)) if a.len() == 2 => Some((a[0] as u64, a[1] as u64)),
    // rust: Some(Tag::List(l)) if l.len() == 2 => match (&l[0], &l[1]) {
    // rust: (Tag::Long(a), Tag::Long(b)) => Some((*a as u64, *b as u64)),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
    // rust: if let Some((lo, hi)) = words {
    // rust: out.sequences
    // rust: .insert(id.to_string_lossy(), XoroshiroRandom::from_state(lo, hi));
}
}
}
    // rust: out
}
ids :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.sequences.keys().cloned().collect()
}
clear :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.sequences.len();
    // rust: self.sequences.clear();
    // rust: n
}
set_defaults :: proc(self: ^Self, salt: i32, include_world_seed: bool, include_sequence_id: bool) {
}
    // rust: self.salt = salt;
    // rust: self.include_world_seed = include_world_seed;
    // rust: self.include_sequence_id = include_sequence_id;
}
reset :: proc(self: ^Self, id: string, world_seed: i64) {
}
    // rust: let (salt, w, i) = (self.salt, self.include_world_seed, self.include_sequence_id);
    // rust: self.sequences
    // rust: .insert(id.to_owned(), create(id, world_seed, salt, w, i));
}
reset_with :: proc(self: ^Self, id: string, world_seed: i64, salt: i32, w: bool, i: bool) {
}
    // rust: self.sequences
    // rust: .insert(id.to_owned(), create(id, world_seed, salt, w, i));
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::RandomSource;

sequences_are_deterministic_and_resettable :: proc() {
}
    // rust: let mut a = RandomSequences::default();
    // rust: let first: Vec<i32> = (0..4)
    // rust: .map(|_| a.get("minecraft:x", 42).next_int_bound(100).unwrap())
    // rust: .collect();
    // rust: let mut b = RandomSequences::default();
    // rust: let again: Vec<i32> = (0..4)
    // rust: .map(|_| b.get("minecraft:x", 42).next_int_bound(100).unwrap())
    // rust: .collect();
    // rust: assert_eq!(first, again);
        // Another id or seed gives another stream.
    // rust: let other = RandomSequences::default()
    // rust: .get("minecraft:y", 42)
    // rust: .next_long();
    // rust: let same = RandomSequences::default()
    // rust: .get("minecraft:x", 42)
    // rust: .next_long();
    // rust: assert_ne!(other, same);
        // Reset restarts it.
    // rust: a.reset("minecraft:x", 42);
    // rust: assert_eq!(
    // rust: a.get("minecraft:x", 42).next_int_bound(100).unwrap(),
    // rust: first[0]
    // rust: );
        // Defaults change what new sequences start from.
    // rust: a.set_defaults(7, false, false);
    // rust: a.reset("minecraft:x", 42);
    // rust: let v = a.get("minecraft:x", 1).next_long();
    // rust: let mut c = RandomSequences::default();
    // rust: c.set_defaults(7, false, false);
    // rust: assert_eq!(c.get("minecraft:z", 999).next_long(), v);
    // rust: assert_eq!(a.clear(), 1);
}
}
