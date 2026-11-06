//! Transpiled from Horizon Rust crate
//! Module: horizon-client_gossip
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Villager gossip (`GossipContainer` and `GossipType`): what a villager
//! remembers about each player, how it fades by the day, how it spreads from
//! villager to villager and the reputation it adds up to.
// use horizon_core::random::{LegacyRandom, RandomSource};
// use horizon_world::nbt::Tag;
// use std::collections::BTreeMap;

/// `ReputationEventType` amounts.
pub const REPUTATION_CHANGE_PER_EVENT: i32 = 25;
pub const REPUTATION_CHANGE_PER_TRADE: i32 = 2;
/// `GossipContainer.DISCARD_THRESHOLD`: values below this are forgotten.
pub const DISCARD_THRESHOLD: i32 = 2;

pub const GossipType = enum {
    MajorNegative,
    MinorNegative,
    MinorPositive,
    MajorPositive,
    Trading,
};
    // rust: impl GossipType {
    // rust: pub const ALL: [Self; 5] = [
    // rust: Self::MajorNegative,
    // rust: Self::MinorNegative,
    // rust: Self::MinorPositive,
    // rust: Self::MajorPositive,
    // rust: Self::Trading,
    // rust: ];
pub fn id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::MajorNegative => "major_negative",
    // rust: Self::MinorNegative => "minor_negative",
    // rust: Self::MinorPositive => "minor_positive",
    // rust: Self::MajorPositive => "major_positive",
    // rust: Self::Trading => "trading",
}
}
pub fn from_id(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|t| t.id() == id)
}
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as usize
}
pub fn weight(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::MajorNegative => -5,
    // rust: Self::MinorNegative => -1,
    // rust: Self::MinorPositive => 1,
    // rust: Self::MajorPositive => 5,
    // rust: Self::Trading => 1,
}
}
pub fn max(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::MajorNegative => 100,
    // rust: Self::MinorNegative => 200,
    // rust: Self::MinorPositive | Self::Trading => 25,
    // rust: Self::MajorPositive => 20,
}
}
pub fn decay_per_day(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::MajorNegative => 10,
    // rust: Self::MinorNegative => 20,
    // rust: Self::MinorPositive => 1,
    // rust: Self::MajorPositive => 0,
    // rust: Self::Trading => 2,
}
}
pub fn decay_per_transfer(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::MajorNegative => 10,
    // rust: Self::MinorNegative => 20,
    // rust: Self::MinorPositive => 5,
    // rust: Self::MajorPositive | Self::Trading => 20,
}
}
}

/// A UUID as four ints.
    // rust: pub type Target = [i32; 4];

/// One gossip entry (`GossipContainer.GossipEntry`).
pub const Entry = struct {
    target: Target,
    kind: GossipType,
    value: i32,
};
    // rust: impl Entry {
pub fn weighted(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value * self.kind.weight()
}
}

/// `GossipContainer`: per target, the value of each gossip type (0: none).
pub const Gossips = struct {
    map: BTreeMap<Target,
};
    // rust: impl Gossips {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.is_empty()
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.len()
}
pub fn clear(self: *Self) void {
}
    // rust: self.map.clear();
}
    /// Every (target, type, value) held.
pub fn entries(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.iter().flat_map(|(t, e)| {
    // rust: GossipType::ALL
    // rust: .into_iter()
    // rust: .filter(move |k| e[k.index()] != 0)
    // rust: .map(move |k| (*t, k, e[k.index()]))
    // rust: })
}
pub fn get(self: *Self, target: Target, kind: GossipType) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.get(&target).map_or(0, |e| e[kind.index()])
}
    /// `getReputation`: the weighted sum of every type for a target.
pub fn reputation(self: *Self, target: Target) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.get(&target).map_or(0, |e| {
    // rust: GossipType::ALL
    // rust: .into_iter()
    // rust: .map(|t| e[t.index()] * t.weight())
    // rust: .sum()
    // rust: })
}
    /// How many targets have a gossip of `kind` whose weighted value passes `test`.
pub fn count_for_type(self: *Self, kind: GossipType, test: impl Fn(f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map
    // rust: .values()
    // rust: .filter(|e| test(f64::from(e[kind.index()] * kind.weight())))
    // rust: .count()
}
    /// `add`: sums up to the type's maximum and forgets values below 2.
pub fn add(self: *Self, target: Target, kind: GossipType, amount: i32) void {
}
    // rust: let entries = self.map.entry(target).or_insert([0; 5]);
    // rust: let old = entries[kind.index()];
    // rust: entries[kind.index()] = if old == 0 {
    // rust: amount
    // rust: } else {
    // rust: let sum = old + amount;
    // rust: if sum > kind.max() {
    // rust: kind.max().max(old)
    // rust: } else {
    // rust: sum
}
}
    // rust: let value = entries[kind.index()];
    // rust: if value > kind.max() {
    // rust: entries[kind.index()] = kind.max();
}
    // rust: if value < DISCARD_THRESHOLD {
    // rust: entries[kind.index()] = 0;
}
    // rust: if entries.iter().all(|v| *v == 0) {
    // rust: self.map.remove(&target);
}
}
pub fn remove(self: *Self, target: Target, kind: GossipType) void {
}
    // rust: if let Some(e) = self.map.get_mut(&target) {
    // rust: e[kind.index()] = 0;
    // rust: if e.iter().all(|v| *v == 0) {
    // rust: self.map.remove(&target);
}
}
}
    /// `decay` (once per day): every type loses its daily amount.
pub fn decay(self: *Self) void {
}
    // rust: self.map.retain(|_, e| {
    // rust: for kind in GossipType::ALL {
    // rust: let v = e[kind.index()];
    // rust: if v == 0 {
    // rust: continue;
}
    // rust: let next = v - kind.decay_per_day();
    // rust: e[kind.index()] = if next < DISCARD_THRESHOLD { 0 } else { next };
}
    // rust: e.iter().any(|v| *v != 0)
    // rust: });
}
pub fn unpack(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: for (target, e) in &self.map {
    // rust: for kind in GossipType::ALL {
    // rust: if e[kind.index()] != 0 {
    // rust: out.push(Entry {
    // rust: target: *target,
    // rust: kind,
    // rust: value: e[kind.index()],
    // rust: });
}
}
}
    // rust: out
}
    /// `selectGossipsForTransfer`: `max_count` picks weighted by magnitude,
    /// duplicates counted once.
pub fn select_for_transfer(self: *Self, random: *mut LegacyRandom, max_count: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entries = self.unpack();
    // rust: if entries.is_empty() {
    // rust: return Vec::new();
}
    // rust: let mut ends = Vec::with_capacity(entries.len());
    // rust: let mut total = 0;
    // rust: for e in &entries {
    // rust: total += e.weighted().abs();
    // rust: ends.push(total - 1);
}
    // rust: let mut picked: Vec<usize> = Vec::new();
    // rust: for _ in 0..max_count {
    // rust: let choice = random.next_int_bound(total).unwrap_or(0);
            // Arrays.binarySearch on the strictly increasing range ends.
    // rust: let index = match ends.binary_search(&choice) {
    // rust: Ok(i) | Err(i) => i,
}
    // rust: if !picked.contains(&index) {
    // rust: picked.push(index);
}
}
    // rust: picked.into_iter().map(|i| entries[i]).collect()
}
    /// `transferFrom`: gossip heard from another villager, weakened by the
    /// retelling. Returns how many gossips were picked.
    // rust: pub fn transfer_from(
    // rust: &mut self,
    // rust: source: &Gossips,
    // rust: random: &mut LegacyRandom,
    // rust: max_count: usize,
    // rust: ) -> usize {
    // rust: let picked = source.select_for_transfer(random, max_count);
    // rust: for g in &picked {
    // rust: let decayed = g.value - g.kind.decay_per_transfer();
    // rust: if decayed >= DISCARD_THRESHOLD {
    // rust: let e = self.map.entry(g.target).or_insert([0; 5]);
    // rust: let slot = &mut e[g.kind.index()];
    // rust: *slot = (*slot).max(decayed);
}
}
    // rust: picked.len()
}

pub fn to_nbt(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(
    // rust: self.unpack()
    // rust: .into_iter()
    // rust: .map(|e| {
    // rust: Tag::compound([
    // rust: ("Target", Tag::IntArray(e.target.to_vec())),
    // rust: ("Type", Tag::String(e.kind.id().into())),
    // rust: ("Value", Tag::Int(e.value)),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: )
}
pub fn from_nbt(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Self::default();
    // rust: let Tag::List(list) = tag else { return out };
    // rust: for g in list {
    // rust: let target = match g.get("Target") {
    // rust: Some(Tag::IntArray(v)) if v.len() == 4 => [v[0], v[1], v[2], v[3]],
    // rust: _ => continue,
}
    // rust: let kind = match g.get("Type") {
    // rust: Some(Tag::String(s)) => GossipType::from_id(&s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: let value = match g.get("Value") {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => continue,
}
    // rust: if let Some(kind) = kind
    // rust: && value > 0
    // rust: {
    // rust: out.map.entry(target).or_insert([0; 5])[kind.index()] = value;
}
}
    // rust: out
}
}

    // rust: mod tests {
//     use super::*;

pub const PLAYER: Target = [1, 2, 3, 4];
pub const OTHER: Target = [5, 6, 7, 8];

pub fn reputation_adds_up_weighted() void {
}
    // rust: let mut g = Gossips::default();
    // rust: g.add(PLAYER, GossipType::MinorPositive, 25);
    // rust: g.add(PLAYER, GossipType::MajorPositive, 20);
    // rust: g.add(PLAYER, GossipType::Trading, 2);
        // 25 + 20 * 5 + 2
    // rust: assert_eq!(g.reputation(PLAYER), 127);
    // rust: g.add(PLAYER, GossipType::MajorNegative, 25);
    // rust: assert_eq!(g.reputation(PLAYER), 127 - 125);
    // rust: assert_eq!(g.reputation(OTHER), 0);
}
pub fn values_stop_at_their_maximum() void {
}
    // rust: let mut g = Gossips::default();
    // rust: for _ in 0..10 {
    // rust: g.add(PLAYER, GossipType::MajorNegative, 25);
}
    // rust: assert_eq!(g.get(PLAYER, GossipType::MajorNegative), 100);
        // The minor negative cap is 200: eight hits of 25 fill it.
    // rust: for _ in 0..12 {
    // rust: g.add(PLAYER, GossipType::MinorNegative, 25);
}
    // rust: assert_eq!(g.get(PLAYER, GossipType::MinorNegative), 200);
    // rust: assert_eq!(g.reputation(PLAYER), -500 - 200);
}
pub fn small_values_are_forgotten() void {
}
    // rust: let mut g = Gossips::default();
    // rust: g.add(PLAYER, GossipType::Trading, 1);
    // rust: assert!(g.is_empty());
    // rust: g.add(PLAYER, GossipType::Trading, 2);
    // rust: assert_eq!(g.get(PLAYER, GossipType::Trading), 2);
    // rust: g.remove(PLAYER, GossipType::Trading);
    // rust: assert!(g.is_empty());
}
pub fn gossip_decays_by_the_day() void {
}
    // rust: let mut g = Gossips::default();
    // rust: g.add(PLAYER, GossipType::MajorNegative, 25);
    // rust: g.add(PLAYER, GossipType::MinorNegative, 25);
    // rust: g.add(PLAYER, GossipType::MinorPositive, 3);
    // rust: g.add(PLAYER, GossipType::MajorPositive, 20);
    // rust: g.decay();
    // rust: assert_eq!(g.get(PLAYER, GossipType::MajorNegative), 15);
    // rust: assert_eq!(g.get(PLAYER, GossipType::MinorNegative), 5);
    // rust: assert_eq!(g.get(PLAYER, GossipType::MinorPositive), 2);
        // Major positive gossip never fades.
    // rust: assert_eq!(g.get(PLAYER, GossipType::MajorPositive), 20);
    // rust: g.decay();
    // rust: assert_eq!(g.get(PLAYER, GossipType::MajorNegative), 5);
    // rust: assert_eq!(g.get(PLAYER, GossipType::MinorNegative), 0);
    // rust: assert_eq!(g.get(PLAYER, GossipType::MinorPositive), 0);
    // rust: g.decay();
    // rust: assert_eq!(g.get(PLAYER, GossipType::MajorNegative), 0);
    // rust: assert_eq!(g.len(), 1);
}
pub fn retold_gossip_is_weaker() void {
}
    // rust: let mut source = Gossips::default();
    // rust: source.add(PLAYER, GossipType::MajorNegative, 25);
    // rust: source.add(OTHER, GossipType::Trading, 25);
    // rust: let mut heard = Gossips::default();
    // rust: let mut random = LegacyRandom::new(11);
    // rust: let n = heard.transfer_from(&source, &mut random, 50);
    // rust: assert!((1..=2).contains(&n));
        // 25 - 10 per transfer for major negative, 25 - 20 for trading.
    // rust: let major = heard.get(PLAYER, GossipType::MajorNegative);
    // rust: let trading = heard.get(OTHER, GossipType::Trading);
    // rust: assert!(major == 0 || major == 15);
    // rust: assert!(trading == 0 || trading == 5);
    // rust: assert!(major + trading > 0);
        // A second hearing keeps the stronger value.
    // rust: heard.transfer_from(&source, &mut random, 50);
    // rust: assert!(heard.get(PLAYER, GossipType::MajorNegative) <= 15);
        // Gossip too weak to survive retelling is dropped.
    // rust: let mut faint = Gossips::default();
    // rust: faint.add(PLAYER, GossipType::Trading, 5);
    // rust: let mut heard = Gossips::default();
    // rust: heard.transfer_from(&faint, &mut random, 10);
    // rust: assert!(heard.is_empty());
}
pub fn gossip_round_trips_through_nbt() void {
}
    // rust: let mut g = Gossips::default();
    // rust: g.add(PLAYER, GossipType::MajorNegative, 25);
    // rust: g.add(PLAYER, GossipType::Trading, 2);
    // rust: g.add(OTHER, GossipType::MinorPositive, 25);
    // rust: assert_eq!(Gossips::from_nbt(&g.to_nbt()), g);
}
pub fn counts_by_type() void {
}
    // rust: let mut g = Gossips::default();
    // rust: g.add(PLAYER, GossipType::MajorNegative, 25);
    // rust: g.add(OTHER, GossipType::MajorNegative, 25);
    // rust: g.add(OTHER, GossipType::Trading, 25);
    // rust: assert_eq!(g.count_for_type(GossipType::MajorNegative, |v| v < 0.0), 2);
    // rust: assert_eq!(g.count_for_type(GossipType::Trading, |v| v < 0.0), 0);
}
}
