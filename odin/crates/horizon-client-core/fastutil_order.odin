//! Transpiled from Horizon Rust crate
package horizon_client_core_fastutil_order

import "core:fmt"
import "core:mem"
import "core:math"

// Iteration order of the Java hash collections vanilla's scoreboard keeps
// its names in: fastutil's `Object2ObjectOpenHashMap<String, _>` (open
// addressing with linear probing, backward-shift deletion and rehashing at
// the load factor) and `java.util.HashSet<String>` (chained buckets split on
// resize). Commands list, and `scoreboard.dat` saves, in these orders.

// The keys of a fastutil open hash map in their table slots.
OpenOrder :: struct {
    keys: [dynamic]Maybe(string),
    size: uint,
    min_n: uint,
    load: f32,
}
    // rust: impl Default for OpenOrder {
    // `new Object2ObjectOpenHashMap<>()`: 16 expected entries, load 0.75.
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(16, 0.75)
}
}
// `String.hashCode`.
java_hash :: proc(s: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: s.encode_utf16()
    // rust: .fold(0i32, |h, c| h.wrapping_mul(31).wrapping_add(i32::from(c)))
}
// `HashCommon.mix`.
mix :: proc(x: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let h = (x as u32).wrapping_mul(0x9E37_79B9);
    // rust: (h ^ (h >> 16)) as usize
}
// `HashCommon.arraySize`.
array_size :: proc(expected: uint, f: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let wanted = (expected as f64 / f64::from(f)).ceil() as usize;
    // rust: wanted.max(2).next_power_of_two()
}
// `HashCommon.maxFill`.
max_fill :: proc(n: uint, f: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((n as f64 * f64::from(f)).ceil() as usize).min(n - 1)
}
    // rust: impl OpenOrder {
new :: proc(expected: uint, load: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let n = array_size(expected, load);
    // rust: Self {
    // rust: keys: vec![None; n],
    // rust: size: 0,
    // rust: min_n: n,
    // rust: load,
}
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.size
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.size == 0
}
slot :: proc(self: ^Self, key: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: mix(java_hash(key)) & (self.keys.len() - 1)
}
contains :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mask = self.keys.len() - 1;
    // rust: let mut pos = self.slot(key);
    // rust: while let Some(k) = &self.keys[pos] {
    // rust: if k == key {
    // rust: return true;
}
    // rust: pos = (pos + 1) & mask;
}
    // rust: false
}
    // `put`: false when the key was already there.
insert :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mask = self.keys.len() - 1;
    // rust: let mut pos = self.slot(key);
    // rust: while let Some(k) = &self.keys[pos] {
    // rust: if k == key {
    // rust: return false;
}
    // rust: pos = (pos + 1) & mask;
}
    // rust: self.keys[pos] = Some(key.to_owned());
        // `if (size++ >= maxFill) rehash(arraySize(size + 1, f))`.
    // rust: let old = self.size;
    // rust: self.size += 1;
    // rust: if old >= max_fill(self.keys.len(), self.load) {
    // rust: self.rehash(array_size(self.size + 1, self.load));
}
    // rust: true
}
    // `remove`: false when the key was not there.
remove :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mask = self.keys.len() - 1;
    // rust: let mut pos = self.slot(key);
    // rust: loop {
    // rust: match &self.keys[pos] {
    // rust: None => return false,
    // rust: Some(k) if k == key => break,
    // rust: Some(_) => pos = (pos + 1) & mask,
}
}
    // rust: self.size -= 1;
    // rust: self.shift_keys(pos);
    // rust: let n = self.keys.len();
    // rust: if n > self.min_n && self.size < max_fill(n, self.load) / 4 && n > 16 {
    // rust: self.rehash(n / 2);
}
    // rust: true
}
shift_keys :: proc(self: ^Self, mut pos: uint) {
}
    // rust: let mask = self.keys.len() - 1;
    // rust: loop {
    // rust: let last = pos;
    // rust: pos = (last + 1) & mask;
    // rust: loop {
    // rust: let Some(curr) = self.keys[pos].clone() else {
    // rust: self.keys[last] = None;
    // rust: return;
}
    // rust: let slot = self.slot(&curr);
    // rust: let stop = if last <= pos {
    // rust: last >= slot || slot > pos
    // rust: } else {
    // rust: last >= slot && slot > pos
}
    // rust: if stop {
    // rust: self.keys[last] = Some(curr);
    // rust: break;
}
    // rust: pos = (pos + 1) & mask;
}
}
}
rehash :: proc(self: ^Self, new_n: uint) {
}
    // rust: let old = std::mem::replace(&mut self.keys, vec![None; new_n]);
    // rust: let mask = new_n - 1;
        // `for (int j = realSize(); j-- != 0;) { while (key[--i] == null); ... }`
    // rust: for key in old.into_iter().rev().flatten() {
    // rust: let mut pos = mix(java_hash(&key)) & mask;
    // rust: while self.keys[pos].is_some() {
    // rust: pos = (pos + 1) & mask;
}
    // rust: self.keys[pos] = Some(key);
}
}
    // `iterator()` and `forEach`: from the last slot down.
iter :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.keys.iter().rev().flatten().map(String::as_str)
}
    // `spliterator()` (what `stream()` uses): from the first slot up.
stream :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.keys.iter().flatten().map(String::as_str)
}
}

// The keys of a `java.util.HashSet<String>` in their buckets.
HashSetOrder :: struct {
    // Empty until the first insertion (`HashMap.resize` on first `put`).
    table: [dynamic]Vec<string>,
    size: uint,
}
// `HashMap.hash`.
spread :: proc(s: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let h = java_hash(s) as u32;
    // rust: (h ^ (h >> 16)) as usize
}
    // rust: impl HashSetOrder {
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.size
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.size == 0
}
contains :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.table.is_empty() {
    // rust: return false;
}
    // rust: let i = spread(key) & (self.table.len() - 1);
    // rust: self.table[i].iter().any(|k| k == key)
}
insert :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.table.is_empty() {
    // rust: self.table = vec![Vec::new(); 16];
}
    // rust: let i = spread(key) & (self.table.len() - 1);
    // rust: if self.table[i].iter().any(|k| k == key) {
    // rust: return false;
}
    // rust: self.table[i].push(key.to_owned());
    // rust: self.size += 1;
    // rust: if self.size > self.table.len() * 3 / 4 {
    // rust: self.resize();
}
    // rust: true
}
    // Doubles the table; each bucket splits into its low and high halves in order.
resize :: proc(self: ^Self) {
}
    // rust: let old = std::mem::take(&mut self.table);
    // rust: let n = old.len() * 2;
    // rust: self.table = vec![Vec::new(); n];
    // rust: for bucket in old {
    // rust: for key in bucket {
    // rust: let i = spread(&key) & (n - 1);
    // rust: self.table[i].push(key);
}
}
}
remove :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.table.is_empty() {
    // rust: return false;
}
    // rust: let i = spread(key) & (self.table.len() - 1);
    // rust: let Some(at) = self.table[i].iter().position(|k| k == key) else {
    // rust: return false;
}
    // rust: self.table[i].remove(at);
    // rust: self.size -= 1;
    // rust: true
}
iter :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.table.iter().flatten()
}
}

    // rust: mod tests {
//     use super::*;

hash_and_order :: proc() {
}
    // rust: assert_eq!(java_hash("harness"), {
    // rust: "harness"
    // rust: .chars()
    // rust: .fold(0i32, |h, c| h.wrapping_mul(31).wrapping_add(c as i32))
    // rust: });
    // rust: let mut o = OpenOrder::new(16, 0.5);
    // rust: for k in ["harness", "harness_h"] {
    // rust: o.insert(k);
}
    // rust: assert_eq!(o.iter().count(), 2);
    // rust: let mut asc: Vec<&str> = o.stream().collect();
    // rust: asc.reverse();
    // rust: assert_eq!(asc, o.iter().collect::<Vec<_>>());
    // rust: o.remove("harness");
    // rust: assert_eq!(o.iter().collect::<Vec<_>>(), vec!["harness_h"]);
    // rust: for i in 0..40 {
    // rust: o.insert(&format!("k{i}"));
}
    // rust: assert_eq!(o.iter().count(), 41);
    // rust: for i in 0..40 {
    // rust: o.remove(&format!("k{i}"));
}
    // rust: assert_eq!(o.iter().collect::<Vec<_>>(), vec!["harness_h"]);
}

hash_set_buckets :: proc() {
}
    // rust: let mut s = HashSetOrder::default();
    // rust: for i in 0..30 {
    // rust: assert!(s.insert(&format!("p{i}")));
}
    // rust: assert!(!s.insert("p3"));
    // rust: assert_eq!(s.len(), 30);
    // rust: assert!(s.remove("p3") && !s.contains("p3"));
        // "Aa" and "BB" share a hash: insertion order within the bucket.
    // rust: let mut t = HashSetOrder::default();
    // rust: t.insert("BB");
    // rust: t.insert("Aa");
    // rust: assert_eq!(t.iter().collect::<Vec<_>>(), vec!["BB", "Aa"]);
}
}
