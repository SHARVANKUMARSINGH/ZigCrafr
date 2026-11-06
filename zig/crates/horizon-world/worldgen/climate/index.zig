//! Transpiled from Horizon Rust crate
//! Module: horizon-world_index
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Immutable climate search tree with an explicit per-worker previous result.
// use super::{TargetPoint, quantize};
// use std::cmp::Ordering;

pub const Parameter = struct {
    min: i64,
    max: i64,
};
    // rust: impl Parameter {
    /// The record constructor does not validate endpoint order.
    // rust: pub const fn new(min: i64, max: i64) -> Self {
    // rust: Self { min, max }
}
pub fn point(value: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = quantize(value);
    // rust: Self::new(value, value)
}
pub fn span(min: f32, max: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min > max {
    // rust: return Err(IndexError::InvertedSpan);
}
    // rust: Ok(Self::new(quantize(min), quantize(max)))
}
pub fn distance(self: *Self, value: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let above = value.wrapping_sub(self.max);
    // rust: if above > 0 {
    // rust: above
    // rust: } else {
    // rust: self.min.wrapping_sub(value).max(0)
}
}
pub fn union(self: *Self, other: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(self.min.min(other.min), self.max.max(other.max))
}
pub fn center(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min.wrapping_add(self.max) / 2
}
}
pub const ParameterPoint = struct {
    /// Temperature, humidity, continentalness, erosion, depth, weirdness.
    coordinates: [Parameter,
    offset: i64,
};
    // rust: impl ParameterPoint {
pub fn fitness(self: *Self, target: TargetPoint) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.coordinates.iter().zip(target.parameters()).fold(
    // rust: self.offset.wrapping_mul(self.offset),
    // rust: |sum, (parameter, value)| {
    // rust: let distance = parameter.distance(value);
    // rust: sum.wrapping_add(distance.wrapping_mul(distance))
    // rust: },
    // rust: )
}
pub fn parameter_space(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|i| {
    // rust: if i < 6 {
    // rust: self.coordinates[i]
    // rust: } else {
    // rust: Parameter::new(self.offset, self.offset)
}
    // rust: })
}
}
pub const IndexError = enum {
    Empty,
    TooManyEntries,
    InvalidBranching,
    InvertedSpan,
    NoSplit,
    NoResult,
};
    // rust: impl std::fmt::Display for IndexError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(match self {
    // rust: Self::Empty => "climate search requires at least one entry",
    // rust: Self::TooManyEntries => "climate search is limited to 65536 entries",
    // rust: Self::InvalidBranching => "climate branching must be in 2..=32",
    // rust: Self::InvertedSpan => "climate interval endpoints are inverted",
    // rust: Self::NoSplit => "climate tree could not select a split",
    // rust: Self::NoResult => "climate search found no result",
    // rust: })
}
}
    // rust: impl std::error::Error for IndexError {}

pub const Children = enum {
    Leaf(usize),
    Branch(Vec<usize>),
};
pub const Node = struct {
    space: [Parameter,
    children: Children,
};
pub fn distance(space: *[Parameter; 7], values: *[i64; 7]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: space
    // rust: .iter()
    // rust: .zip(values)
    // rust: .fold(0i64, |sum, (parameter, value)| {
    // rust: let distance = parameter.distance(*value);
    // rust: sum.wrapping_add(distance.wrapping_mul(distance))
    // rust: })
}
pub fn compare_space(a: *[Parameter; 7], b: *[Parameter; 7], axis: usize, absolute: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for i in 0..7 {
    // rust: let coordinate = (axis + i) % 7;
    // rust: let key = |p: Parameter| {
    // rust: if absolute {
    // rust: p.center().wrapping_abs()
    // rust: } else {
    // rust: p.center()
}
}
    // rust: let result = key(a[coordinate]).cmp(&key(b[coordinate]));
    // rust: if result != Ordering::Equal {
    // rust: return result;
}
}
    // rust: Ordering::Equal
}
pub const Bucket = struct {
    space: [Parameter,
    children: std.ArrayList(usize),
};
pub fn space(nodes: *[Node], children: *[usize]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut space = nodes[children[0]].space;
    // rust: for child in &children[1..] {
    // rust: for (parameter, other) in space.iter_mut().zip(nodes[*child].space) {
    // rust: *parameter = parameter.union(other);
}
}
    // rust: space
}
    // rust: fn build(
    // rust: nodes: &mut Vec<Node>,
    // rust: mut children: Vec<usize>,
    // rust: branching: usize,
    // rust: ) -> Result<usize, IndexError> {
    // rust: if children.len() == 1 {
    // rust: return Ok(children[0]);
}
    // rust: if children.len() <= branching {
        // Stable sorting matters when centers and total center distance tie.
    // rust: children.sort_by_key(|id| {
    // rust: nodes[*id]
    // rust: .space
    // rust: .iter()
    // rust: .fold(0i64, |sum, p| sum.wrapping_add(p.center().wrapping_abs()))
    // rust: });
    // rust: } else {
        // For this bounded domain this is the same bucket size as vanilla's
        // pow(branching,floor(log(length-0.01)/log(branching))). Integer powers
        // avoid depending on platform double logarithms during construction.
    // rust: let mut bucket_size = 1;
    // rust: while bucket_size * branching < children.len() {
    // rust: bucket_size *= branching;
}
    // rust: let mut best_cost = i64::MAX;
    // rust: let mut best = None;
    // rust: for axis in 0..7 {
    // rust: children.sort_by(|a, b| compare_space(&nodes[*a].space, &nodes[*b].space, axis, false));
    // rust: let buckets: Vec<_> = children
    // rust: .chunks(bucket_size)
    // rust: .map(|children| Bucket {
    // rust: space: space(nodes, children),
    // rust: children: children.to_vec(),
    // rust: })
    // rust: .collect();
    // rust: let cost = buckets.iter().fold(0i64, |sum, bucket| {
    // rust: bucket.space.iter().fold(sum, |sum, p| {
    // rust: sum.wrapping_add(p.max.wrapping_sub(p.min).wrapping_abs())
    // rust: })
    // rust: });
    // rust: if best_cost > cost {
    // rust: best_cost = cost;
    // rust: best = Some((axis, buckets));
}
}
    // rust: let (axis, mut buckets) = best.ok_or(IndexError::NoSplit)?;
    // rust: buckets.sort_by(|a, b| compare_space(&a.space, &b.space, axis, true));
    // rust: children = buckets
    // rust: .into_iter()
    // rust: .map(|bucket| build(nodes, bucket.children, branching))
    // rust: .collect::<Result<_, _>>()?;
}
    // rust: let space = space(nodes, &children);
    // rust: let id = nodes.len();
    // rust: nodes.push(Node {
    // rust: space,
    // rust: children: Children::Branch(children),
    // rust: });
    // rust: Ok(id)
}

/// The index is immutable and can be shared; each searcher owns its cache.
/// Entry count and branching are explicit limits of this bounded Rust API.
pub const ClimateIndex = struct {
    entries: Vec<(ParameterPoint,
    /// The built tree renumbered breadth first, root at 0, so each branch's
    /// children are one contiguous run and a search walks memory in order.
    spaces: Vec<[Parameter,
    /// Per node: its first child and child count, or its entry and 0 for a leaf.
    links: Vec<(u32,
};
    // rust: impl<T> ClimateIndex<T> {
pub fn new(entries: Vec<(ParameterPoint) void {
}
    // rust: Self::with_branching(entries, 19)
}
    // rust: pub fn with_branching(
    // rust: entries: Vec<(ParameterPoint, T)>,
    // rust: branching: usize,
    // rust: ) -> Result<Self, IndexError> {
    // rust: if entries.is_empty() {
    // rust: return Err(IndexError::Empty);
}
    // rust: if entries.len() > 65536 {
    // rust: return Err(IndexError::TooManyEntries);
}
    // rust: if !(2..=32).contains(&branching) {
    // rust: return Err(IndexError::InvalidBranching);
}
    // rust: let mut nodes: Vec<_> = entries
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(id, (point, _))| Node {
    // rust: space: point.parameter_space(),
    // rust: children: Children::Leaf(id),
    // rust: })
    // rust: .collect();
    // rust: let children = (0..nodes.len()).collect();
    // rust: let root = build(&mut nodes, children, branching)?;
    // rust: let mut order = vec![root];
    // rust: let mut links = Vec::with_capacity(nodes.len());
    // rust: let mut next = 0;
    // rust: while next < order.len() {
    // rust: let node = &nodes[order[next]];
    // rust: next += 1;
    // rust: links.push(match &node.children {
    // rust: Children::Leaf(entry) => (*entry as u32, 0),
    // rust: Children::Branch(children) => {
    // rust: let first = order.len() as u32;
    // rust: order.extend_from_slice(children);
    // rust: (first, children.len() as u32)
}
    // rust: });
}
    // rust: Ok(Self {
    // rust: entries,
    // rust: spaces: order.iter().map(|id| nodes[*id].space).collect(),
    // rust: links,
    // rust: })
}
pub fn entries(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.entries
}
pub fn searcher(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ClimateSearch {
    // rust: index: self,
    // rust: last: None,
}
}
    /// Vanilla's separate reference path: ties retain input-list order and do
    /// not consult or update the searcher's previous indexed result.
pub fn brute_force(self: *Self, target: TargetPoint) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut best = 0;
    // rust: let mut fitness = self.entries[0].0.fitness(target);
    // rust: for (id, (point, _)) in self.entries.iter().enumerate().skip(1) {
    // rust: let next = point.fitness(target);
    // rust: if next < fitness {
    // rust: fitness = next;
    // rust: best = id;
}
}
    // rust: &self.entries[best].1
}
    /// Preorder leaf entry indices expose stable tree layout for comparison.
pub fn leaf_order(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
pub fn walk(links: *[(u32) void {
}
    // rust: match links[id] {
    // rust: (entry, 0) => out.push(entry as usize),
    // rust: (first, count) => {
    // rust: for child in first..first + count {
    // rust: walk(links, child as usize, out);
}
}
}
}
    // rust: let mut result = Vec::with_capacity(self.entries.len());
    // rust: walk(&self.links, 0, &mut result);
    // rust: result
}
    // rust: fn search(
    // rust: &self,
    // rust: id: usize,
    // rust: values: &[i64; 7],
    // rust: previous: Option<usize>,
    // rust: ) -> Result<usize, IndexError> {
    // rust: let (first, count) = self.links[id];
    // rust: if count == 0 {
    // rust: return Ok(id);
}
    // rust: let mut best = previous;
    // rust: let mut fitness = previous.map_or(i64::MAX, |id| distance(&self.spaces[id], values));
    // rust: for child in first as usize..(first + count) as usize {
    // rust: let lower = distance(&self.spaces[child], values);
    // rust: if fitness > lower {
    // rust: let result = self.search(child, values, best)?;
    // rust: let next = if result == child {
    // rust: lower
    // rust: } else {
    // rust: distance(&self.spaces[result], values)
}
    // rust: if fitness > next {
    // rust: fitness = next;
    // rust: best = Some(result);
}
}
}
    // rust: best.ok_or(IndexError::NoResult)
}
}
pub const ClimateSearch = struct {
    index: *'a ClimateIndex<T>,
    last: ?usize,
};
    // rust: impl<'a, T> ClimateSearch<'a, T> {
pub fn find(self: *Self, target: TargetPoint) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let result = self.index.search(0, &target.parameters(), self.last)?;
    // rust: self.last = Some(result);
    // rust: let (entry, 0) = self.index.links[result] else {
    // rust: unreachable!("search returns a leaf");
}
    // rust: Ok(&self.index.entries[entry as usize].1)
}
}
