//! Transpiled from Horizon Rust crate
package horizon_world_block_state_properties

import "core:fmt"
import "core:mem"
import "core:math"

// A block state's properties: a few name/value pairs, sorted by name, read
// like the `BTreeMap<String, String>` they replace. A registry's states share
// their strings (35,723 vanilla states hold 158,409 properties made of 237
// distinct strings): one string for the whole process instead of a B-tree
// leaf (544 bytes) and two allocations per property. Shared strings are
// never freed, nor counted: cloning a state copies pointers, so world
// generation threads cloning the same states don't contend on counters.
// use std::{
    // rust: borrow::Borrow,
    // rust: cmp::Ordering,
    // rust: collections::BTreeMap,
    // rust: fmt,
    // rust: hash::{Hash, Hasher},
    // rust: ops::Deref,
    // rust: sync::Mutex,
}

// A property name or value: owned, or one string a registry shares.
Text :: enum {
    Owned(String),
    Shared(&'static String),
}
    // rust: impl Deref for Text {
    // rust: type Target = String;
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Owned(s) => s,
    // rust: Self::Shared(s) => s,
}
}
}
    // rust: impl Text {
into_string :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Owned(s) => s,
    // rust: Self::Shared(s) => s.clone(),
}
}
to_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let Self::Shared(s) = self {
    // rust: *self = Self::Owned((**s).clone());
}
    // rust: match self {
    // rust: Self::Owned(s) => s,
    // rust: Self::Shared(_) => unreachable!(),
}
}
}

    // rust: type Interned = horizon_core::fast_hash::FxHashMap<&'static str, &'static String>;
// Every string a registry's states share, for the process: registries'
// names and values only (a few hundred), never a player's.
INTERNED :: Mutex::new(None)

// The strings one registry's states share ([`BlockProperties::share`]):
// the process's, with the ones already met at hand.
SharedStrings :: struct {
    // rust: impl SharedStrings {
get :: proc(self: ^Self, text: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(shared) = self.0.get(text) {
    // rust: return shared;
}
    // rust: let mut interned = INTERNED.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let interned = interned.get_or_insert_with(Interned::default);
    // rust: let shared = match interned.get(text) {
    // rust: Some(shared) => *shared,
    // rust: None => {
    // rust: let shared: &'static String = Box::leak(Box::new(text.to_owned()));
    // rust: interned.insert(shared.as_str(), shared);
    // rust: shared
}
}
    // rust: self.0.insert(shared.as_str(), shared);
    // rust: shared
}
}

// A block state's properties by name, in name order.
BlockProperties :: struct {

    // rust: impl BlockProperties {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    Self: :default(),
}
    // rust: fn position<Q: Ord + ?Sized>(&self, key: &Q) -> Result<usize, usize>
    // rust: where
    // rust: String: Borrow<Q>,
    // rust: {
    // rust: self.0.binary_search_by(|(k, _)| (**k).borrow().cmp(key))
}
    // rust: pub fn get<Q: Ord + ?Sized>(&self, key: &Q) -> Option<&String>
    // rust: where
    // rust: String: Borrow<Q>,
    // rust: {
    // rust: self.position(key).ok().map(|i| &*self.0[i].1)
}
    // rust: pub fn get_mut<Q: Ord + ?Sized>(&mut self, key: &Q) -> Option<&mut String>
    // rust: where
    // rust: String: Borrow<Q>,
    // rust: {
    // rust: let i = self.position(key).ok()?;
    // rust: Some(self.0[i].1.to_mut())
}
    // rust: pub fn contains_key<Q: Ord + ?Sized>(&self, key: &Q) -> bool
    // rust: where
    // rust: String: Borrow<Q>,
    // rust: {
    // rust: self.position(key).is_ok()
}
    // Sets `key` to `value`; the value it had, if any.
insert :: proc(self: ^Self, key: string, value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.position(key.as_str()) {
    // rust: Ok(i) => Some(std::mem::replace(&mut self.0[i].1, Text::Owned(value)).into_string()),
    // rust: Err(i) => {
    // rust: let mut pairs = std::mem::take(&mut self.0).into_vec();
    // rust: pairs.insert(i, (Text::Owned(key), Text::Owned(value)));
    // rust: self.0 = pairs.into_boxed_slice();
    // rust: None
}
}
}
    // rust: pub fn remove<Q: Ord + ?Sized>(&mut self, key: &Q) -> Option<String>
    // rust: where
    // rust: String: Borrow<Q>,
    // rust: {
    // rust: let i = self.position(key).ok()?;
    // rust: let mut pairs = std::mem::take(&mut self.0).into_vec();
    // rust: let (_, value) = pairs.remove(i);
    // rust: self.0 = pairs.into_boxed_slice();
    // rust: Some(value.into_string())
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.len()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.is_empty()
}
iter :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: Iter(self.0.iter())
}
keys :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter().map(|(k, _)| &**k)
}
values :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0.iter().map(|(_, v)| &**v)
}
    // These properties over the strings `strings` holds, which other states
    // share (a registry's states, built once). Strings already shared stay.
share :: proc(self: ^Self, strings: ^SharedStrings) {
}
    // rust: for text in self.0.iter_mut().flat_map(|(k, v)| [k, v]) {
    // rust: if let Text::Owned(owned) = text {
    // rust: *text = Text::Shared(strings.get(owned));
}
}
}
    // Shared names and values, collected as a `BTreeMap` collects them.
from_shared :: proc(mut pairs: Vec<(^'static string) {
}
    // rust: pairs.sort_by(|a, b| a.0.cmp(b.0));
    // rust: let mut kept: Vec<(Text, Text)> = Vec::with_capacity(pairs.len());
    // rust: for (k, v) in pairs {
    // rust: match kept.last_mut() {
    // rust: Some(last) if *last.0 == *k => last.1 = Text::Shared(v),
    // rust: _ => kept.push((Text::Shared(k), Text::Shared(v))),
}
}
    // rust: Self(kept.into_boxed_slice())
}
}

Iter :: struct {
    // rust: impl<'a> Iterator for Iter<'a> {
    // rust: type Item = (&'a String, &'a String);
next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.next().map(|(k, v)| (&**k, &**v))
}
size_hint :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: self.0.size_hint()
}
}
    // rust: impl DoubleEndedIterator for Iter<'_> {
next_back :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.next_back().map(|(k, v)| (&**k, &**v))
}
}
    // rust: impl ExactSizeIterator for Iter<'_> {}

    // rust: impl<'a> IntoIterator for &'a BlockProperties {
    // rust: type Item = (&'a String, &'a String);
    // rust: type IntoIter = Iter<'a>;
into_iter :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.iter()
}
}
    // rust: impl IntoIterator for BlockProperties {
    // rust: type Item = (String, String);
    // rust: type IntoIter = IntoIter;
into_iter :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: IntoIter(self.0.into_vec().into_iter())
}
}
IntoIter :: struct {
    // rust: impl Iterator for IntoIter {
    // rust: type Item = (String, String);
next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .next()
    // rust: .map(|(k, v)| (k.into_string(), v.into_string()))
}
size_hint :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: self.0.size_hint()
}
}
// As a `BTreeMap` collects: sorted by name, the last value of a name wins.
    // rust: impl FromIterator<(String, String)> for BlockProperties {
    // rust: fn from_iter<I: IntoIterator<Item = (String, String)>>(iter: I) -> Self {
    // rust: let mut pairs: Vec<(String, String)> = iter.into_iter().collect();
        // Stable: equal names keep their order, and the last one is kept.
    // rust: pairs.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: let mut kept: Vec<(Text, Text)> = Vec::with_capacity(pairs.len());
    // rust: for (k, v) in pairs {
    // rust: match kept.last_mut() {
    // rust: Some(last) if *last.0 == k => last.1 = Text::Owned(v),
    // rust: _ => kept.push((Text::Owned(k), Text::Owned(v))),
}
}
    // rust: Self(kept.into_boxed_slice())
}
}
    // rust: impl Extend<(String, String)> for BlockProperties {
    // rust: fn extend<I: IntoIterator<Item = (String, String)>>(&mut self, iter: I) {
    // rust: for (k, v) in iter {
    // rust: self.insert(k, v);
}
}
}
    // rust: impl<const N: usize> From<[(String, String); N]> for BlockProperties {
from :: proc(pairs: [(string) {
}
    // rust: pairs.into_iter().collect()
}
}
    // rust: impl From<BTreeMap<String, String>> for BlockProperties {
from :: proc(map: BTreeMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(
    // rust: map.into_iter()
    // rust: .map(|(k, v)| (Text::Owned(k), Text::Owned(v)))
    // rust: .collect(),
    // rust: )
}
}
    // rust: impl From<BlockProperties> for BTreeMap<String, String> {
from :: proc(properties: BlockProperties) -> S {
    // Ported from Horizon
    return {}
}
    // rust: properties.into_iter().collect()
}
}

    // rust: impl<Q: Ord + ?Sized> std::ops::Index<&Q> for BlockProperties
    // rust: where
    // rust: String: Borrow<Q>,
    // rust: {
    // rust: type Output = String;
    // Panics when the key is missing, as a `BTreeMap` does.
index :: proc(self: ^Self, key: ^Q) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.get(key).expect("no entry found for key")
}
}
    // rust: impl serde::Serialize for BlockProperties {
    // rust: fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
    // rust: serializer.collect_map(self.iter())
}
}
    // rust: impl<'de> serde::Deserialize<'de> for BlockProperties {
    // rust: fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
    // rust: BTreeMap::<String, String>::deserialize(deserializer).map(Self::from)
}
}

// Compared, ordered and hashed as the `BTreeMap` they replace: pair by pair.
    // rust: impl PartialEq for BlockProperties {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.iter().eq(other.iter())
}
}
    // rust: impl Eq for BlockProperties {}
    // rust: impl PartialEq<BTreeMap<String, String>> for BlockProperties {
eq :: proc(self: ^Self, other: ^BTreeMap<string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.iter().eq(other.iter())
}
}
    // rust: impl PartialOrd for BlockProperties {
partial_cmp :: proc(self: ^Self, other: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.cmp(other))
}
}
    // rust: impl Ord for BlockProperties {
cmp :: proc(self: ^Self, other: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.iter().cmp(other.iter())
}
}
    // rust: impl Hash for BlockProperties {
    // rust: fn hash<H: Hasher>(&self, state: &mut H) {
    // rust: state.write_usize(self.len());
    // rust: for pair in self {
    // rust: pair.hash(state);
}
}
}
    // rust: impl fmt::Debug for BlockProperties {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_map().entries(self.iter()).finish()
}
}

    // rust: mod tests {
//     use super::*;

map :: proc(pairs: ^[(string) {
}
    // rust: pairs
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect()
}

reads_and_writes_as_the_map_it_replaces :: proc() {
}
    // rust: let pairs = [
    // rust: ("waterlogged", "false"),
    // rust: ("facing", "north"),
    // rust: ("half", "top"),
    // rust: ];
    // rust: let mut map = map(&pairs);
    // rust: let mut properties: BlockProperties = pairs
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect();
    // rust: let same = |p: &BlockProperties, m: &BTreeMap<String, String>| {
    // rust: assert!(p.iter().eq(m.iter()));
    // rust: assert_eq!(p.len(), m.len());
    // rust: assert_eq!(format!("{p:?}"), format!("{m:?}"));
}
    // rust: same(&properties, &map);
    // rust: assert_eq!(properties.get("facing"), map.get("facing"));
    // rust: assert_eq!(properties.get("shape"), None);
    // rust: assert_eq!(
    // rust: properties.insert("facing".into(), "east".into()),
    // rust: map.insert("facing".into(), "east".into())
    // rust: );
    // rust: assert_eq!(
    // rust: properties.insert("axis".into(), "y".into()),
    // rust: map.insert("axis".into(), "y".into())
    // rust: );
    // rust: *properties.get_mut("half").unwrap() = "bottom".into();
    // rust: *map.get_mut("half").unwrap() = "bottom".into();
    // rust: assert_eq!(properties.remove("waterlogged"), map.remove("waterlogged"));
    // rust: assert_eq!(properties.remove("waterlogged"), None);
    // rust: same(&properties, &map);
    // rust: assert_eq!(BTreeMap::from(properties), map);
}

collects_as_a_map_does :: proc() {
}
    // rust: let pairs = [("b", "1"), ("a", "2"), ("b", "3")];
    // rust: let properties: BlockProperties = pairs
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect();
    // rust: assert!(properties.iter().eq(map(&pairs).iter()));
}

orders_and_hashes_as_the_map_does :: proc() {
}
    // rust: let sets = [
    // rust: vec![],
    // rust: vec![("a", "1")],
    // rust: vec![("a", "2")],
    // rust: vec![("a", "1"), ("b", "1")],
    // rust: vec![("b", "0")],
    // rust: ];
    // rust: let hash = |value: &dyn Fn(&mut std::collections::hash_map::DefaultHasher)| {
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: value(&mut hasher);
    // rust: hasher.finish()
}
    // rust: for a in &sets {
    // rust: for b in &sets {
    // rust: let (pa, pb) = (BlockProperties::from(map(a)), BlockProperties::from(map(b)));
    // rust: assert_eq!(pa.cmp(&pb), map(a).cmp(&map(b)), "{a:?} {b:?}");
    // rust: assert_eq!(pa == pb, map(a) == map(b));
}
    // rust: let p = BlockProperties::from(map(a));
    // rust: assert_eq!(hash(&|h| p.hash(h)), hash(&|h| map(a).hash(h)));
}
}

shared_strings_read_and_change_as_owned_ones :: proc() {
}
    // rust: let mut strings = SharedStrings::default();
    // rust: let pairs = map(&[("facing", "north"), ("lit", "true")]);
    // rust: let mut a = BlockProperties::from(pairs.clone());
    // rust: let mut b = BlockProperties::from(pairs.clone());
    // rust: a.share(&mut strings);
    // rust: b.share(&mut strings);
    // rust: assert_eq!(a, BlockProperties::from(pairs.clone()));
        // One string for both states' value.
    // rust: let (Text::Shared(x), Text::Shared(y)) = (&a.0[0].1, &b.0[0].1) else {
    // rust: panic!("not shared");
}
    // rust: assert!(std::ptr::eq(*x, *y));
        // Changing one state's value leaves the other's.
    // rust: a.get_mut("facing").unwrap().push_str("_east");
    // rust: assert_eq!(a.get("facing").map(String::as_str), Some("north_east"));
    // rust: assert_eq!(b.get("facing").map(String::as_str), Some("north"));
    // rust: assert_eq!(BTreeMap::from(b), pairs);
}
}
