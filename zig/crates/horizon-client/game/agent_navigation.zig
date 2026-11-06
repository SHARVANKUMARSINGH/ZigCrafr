//! Transpiled from Horizon Rust crate
//! Module: horizon-client_agent_navigation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use std::{
    // rust: cmp::Reverse,
    // rust: collections::{BinaryHeap, HashMap},
}

    // rust: pub(crate) type Node = [i32; 3];

    // rust: pub(crate) struct Cell {
    // rust: pub solid: bool,
    // rust: pub fluid: bool,
    // rust: pub lava: bool,
}

    // rust: pub(crate) struct Plan {
    // rust: pub nodes: Vec<Node>,
    // rust: pub complete: bool,
}

pub fn solid(query: *impl Fn(Node) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: query(n).is_none_or(|b| b.solid)
}

pub fn walkable(query: *impl Fn(Node) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(feet) = query(n) else {
    // rust: return false;
}
    // rust: let Some(below) = query([n[0], n[1] - 1, n[2]]) else {
    // rust: return false;
}
    // rust: let Some(head) = query([n[0], n[1] + 1, n[2]]) else {
    // rust: return false;
}
    // rust: (below.solid || below.fluid) && !feet.solid && !head.solid && !feet.lava && !below.lava
}

    // rust: pub(crate) fn find_path(
    // rust: from: Node,
    // rust: goal: [f64; 3],
    // rust: near: f64,
    // rust: blocked: &[(Node, Node)],
    // rust: query: impl Fn(Node) -> Option<Cell>,
    // rust: ) -> Option<Plan> {
    // rust: let reached = |n: Node| {
    // rust: let c = [
    // rust: f64::from(n[0]) + 0.5,
    // rust: f64::from(n[1]),
    // rust: f64::from(n[2]) + 0.5,
    // rust: ];
    // rust: ((c[0] - goal[0]).powi(2) + (c[2] - goal[2]).powi(2)).sqrt() <= near.max(0.5)
    // rust: && (c[1] - goal[1]).abs() <= near.max(1.0) + 0.5
}
    // rust: let h = |n: Node| {
    // rust: ((f64::from(n[0]) + 0.5 - goal[0]).abs()
    // rust: + (f64::from(n[1]) - goal[1]).abs()
    // rust: + (f64::from(n[2]) + 0.5 - goal[2]).abs())
    // rust: * 10.0
}
    // rust: let mut open = BinaryHeap::new();
    // rust: let mut cost: HashMap<Node, u32> = HashMap::new();
    // rust: let mut came: HashMap<Node, Node> = HashMap::new();
    // rust: cost.insert(from, 0);
    // rust: open.push(Reverse((h(from) as u32, from)));
    // rust: let distance = |n: Node| {
    // rust: (f64::from(n[0]) + 0.5 - goal[0]).powi(2)
    // rust: + (f64::from(n[1]) - goal[1]).powi(2)
    // rust: + (f64::from(n[2]) + 0.5 - goal[2]).powi(2)
}
    // rust: let mut best = from;
    // rust: let mut expanded = 0;
    // rust: while let Some(Reverse((_, n))) = open.pop() {
    // rust: if reached(n) {
    // rust: return Some(reconstruct(n, &came, true));
}
    // rust: if distance(n) < distance(best) {
    // rust: best = n;
}
    // rust: expanded += 1;
    // rust: if expanded >= 30_000 {
    // rust: break;
}
    // rust: let base = cost[&n];
    // rust: for d in [[1, 0], [-1, 0], [0, 1], [0, -1]] {
    // rust: for dy in [0, 1, -1, -2, -3] {
    // rust: let m = [n[0] + d[0], n[1] + dy, n[2] + d[1]];
                // A step up needs head room above the start; a drop needs
                // the column in front clear down to the landing.
    // rust: let clear = match dy {
    // rust: 1 => !solid(&query, [n[0], n[1] + 2, n[2]]),
    // rust: d if d < 0 => (m[1]..=n[1] + 1).all(|y| !solid(&query, [m[0], y, m[2]])),
    // rust: _ => true,
}
    // rust: if !clear || !walkable(&query, m) {
    // rust: continue;
}
    // rust: if blocked
    // rust: .iter()
    // rust: .any(|&(a, b)| (a == n && b == m) || (a == m && b == n))
    // rust: {
    // rust: break;
}
    // rust: let water = query(m).is_some_and(|b| b.fluid);
    // rust: let step = 10 + if dy != 0 { 5 } else { 0 } + if water { 30 } else { 0 };
    // rust: let c = base + step;
    // rust: if cost.get(&m).is_none_or(|&old| c < old) {
    // rust: cost.insert(m, c);
    // rust: came.insert(m, n);
    // rust: open.push(Reverse((c + h(m) as u32, m)));
}
    // rust: break;
}
}
}
    // rust: (best != from && distance(best) + 1e-6 < distance(from))
    // rust: .then(|| reconstruct(best, &came, false))
}

pub fn reconstruct(end: Node, came: *HashMap<Node, complete: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut nodes = vec![end];
    // rust: let mut at = end;
    // rust: while let Some(&previous) = came.get(&at) {
    // rust: nodes.push(previous);
    // rust: at = previous;
}
    // rust: nodes.reverse();
    // rust: Plan { nodes, complete }
}

    // rust: impl Plan {
    // rust: pub(crate) fn aim(&self, p: [f64; 3], next: &mut usize, target: [f64; 3]) -> Option<[f64; 3]> {
    // rust: while *next < self.nodes.len() {
    // rust: let n = self.nodes[*next];
    // rust: let c = [
    // rust: f64::from(n[0]) + 0.5,
    // rust: f64::from(n[1]),
    // rust: f64::from(n[2]) + 0.5,
    // rust: ];
    // rust: let last = *next + 1 == self.nodes.len();
    // rust: if ((p[0] - c[0]).powi(2) + (p[2] - c[2]).powi(2)).sqrt()
    // rust: < if last { 0.3 } else { 0.45 }
    // rust: && (p[1] - c[1]).abs() < 1.1
    // rust: {
    // rust: *next += 1;
    // rust: } else {
    // rust: return Some(c);
}
}
    // rust: self.complete.then_some(target)
}
}

    // rust: pub(crate) fn arrived(p: [f64; 3], target: [f64; 3], near: f64) -> bool {
    // rust: ((p[0] - target[0]).powi(2) + (p[2] - target[2]).powi(2)).sqrt() <= near
    // rust: && (p[1] - target[1]).abs() <= near.max(1.0) + 1.0
}

pub fn horizontal_distance(p: [f64; 3], aim: [f64; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((p[0] - aim[0]).powi(2) + (p[2] - aim[2]).powi(2)).sqrt()
}

    // rust: pub(crate) struct Progress {
    // rust: best_distance: f64,
}
    // rust: impl Progress {
    // rust: pub(crate) fn new(position: [f64; 3], aim: [f64; 3]) -> Self {
    // rust: Self {
    // rust: best_distance: horizontal_distance(position, aim),
}
}
    // rust: pub(crate) fn advance(&mut self, p: [f64; 3], aim: [f64; 3]) -> bool {
    // rust: let distance = horizontal_distance(p, aim);
    // rust: if self.best_distance - distance >= 0.25 {
    // rust: self.best_distance = distance;
    // rust: true
    // rust: } else {
    // rust: false
}
}
}

    // rust: mod tests {
//     use super::*;

pub const Terrain = struct {
    floors: HashMap<(i32,
    cells: HashMap<Node,
};
    // rust: impl Terrain {
pub fn flat(x: std::ops::RangeInclusive<i32>, z: std::ops::RangeInclusive<i32>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut t = Self::default();
    // rust: for x in x {
    // rust: for z in z.clone() {
    // rust: t.floors.insert((x, z), 63);
}
}
    // rust: t
}
pub fn query(self: *Self, n: Node) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let floor = self.floors.get(&(n[0], n[2]))?;
    // rust: Some(self.cells.get(&n).copied().unwrap_or(Cell {
    // rust: solid: n[1] <= *floor,
    // rust: ..Cell::default()
    // rust: }))
}
pub fn path(self: *Self, from: Node, goal: [f64; 3], blocked: *[(Node) void {
}
    // rust: find_path(from, goal, 0.6, blocked, |n| self.query(n))
}
}

pub fn short_path_is_complete() void {
}
    // rust: let p = Terrain::flat(0..=5, 0..=0)
    // rust: .path([0, 64, 0], [5.5, 64.0, 0.5], &[])
    // rust: .unwrap();
    // rust: assert!(p.complete);
    // rust: assert_eq!(p.nodes.last(), Some(&[5, 64, 0]));
}

pub fn loaded_frontier_continues_after_chunks_extend() void {
}
    // rust: let mut t = Terrain::flat(0..=5, 0..=0);
    // rust: let goal = [10.5, 64.0, 0.5];
    // rust: let partial = t
    // rust: .path([0, 64, 0], goal, &[])
    // rust: .expect("loaded frontier should be usable");
    // rust: assert!(!partial.complete);
    // rust: assert_eq!(partial.nodes.last(), Some(&[5, 64, 0]));
    // rust: let endpoint = *partial.nodes.last().unwrap();
    // rust: assert!(
    // rust: t.path(endpoint, goal, &[]).is_none(),
    // rust: "unchanged frontier must stop"
    // rust: );
    // rust: for x in 6..=10 {
    // rust: t.floors.insert((x, 0), 63);
}
    // rust: let complete = t.path(endpoint, goal, &[]).unwrap();
    // rust: assert!(complete.complete);
    // rust: assert_eq!(complete.nodes.last(), Some(&[10, 64, 0]));
}

pub fn no_closer_endpoint_fails() void {
}
    // rust: assert!(
    // rust: Terrain::flat(-4..=0, 0..=0)
    // rust: .path([0, 64, 0], [10.5, 64.0, 0.5], &[])
    // rust: .is_none()
    // rust: );
}

pub fn complete_path_can_initially_move_away() void {
}
    // rust: let mut t = Terrain::flat(-2..=0, 0..=0);
    // rust: for z in 0..=2 {
    // rust: t.floors.insert((-2, z), 63);
}
    // rust: for x in -2..=5 {
    // rust: t.floors.insert((x, 2), 63);
}
    // rust: for z in 0..=2 {
    // rust: t.floors.insert((5, z), 63);
}
    // rust: let p = t.path([0, 64, 0], [5.5, 64.0, 0.5], &[]).unwrap();
    // rust: assert!(p.complete);
    // rust: assert_eq!(p.nodes[1], [-1, 64, 0]);
}

pub fn failed_edge_uses_bypass() void {
}
    // rust: let blocked = [([0, 64, 0], [1, 64, 0])];
    // rust: let p = Terrain::flat(0..=3, 0..=1)
    // rust: .path([0, 64, 0], [3.5, 64.0, 0.5], &blocked)
    // rust: .unwrap();
    // rust: assert!(p.complete);
    // rust: assert!(
    // rust: !p.nodes
    // rust: .windows(2)
    // rust: .any(|w| w == [blocked[0].0, blocked[0].1])
    // rust: );
    // rust: assert_eq!(p.nodes[1], [0, 64, 1]);
}

pub fn failed_edge_without_bypass_stops() void {
}
    // rust: assert!(
    // rust: Terrain::flat(0..=1, 0..=0)
    // rust: .path([0, 64, 0], [1.5, 64.0, 0.5], &[([0, 64, 0], [1, 64, 0])])
    // rust: .is_none()
    // rust: );
}

pub fn lava_and_unknown_terrain_are_not_walked() void {
}
    // rust: let mut t = Terrain::flat(0..=1, 0..=0);
    // rust: t.cells.insert(
    // rust: [1, 63, 0],
    // rust: Cell {
    // rust: lava: true,
    // rust: fluid: true,
    // rust: solid: false,
    // rust: },
    // rust: );
    // rust: assert!(t.path([0, 64, 0], [1.5, 64.0, 0.5], &[]).is_none());
    // rust: t.cells.remove(&[1, 63, 0]);
    // rust: t.cells.insert(
    // rust: [1, 64, 0],
    // rust: Cell {
    // rust: lava: true,
    // rust: fluid: true,
    // rust: solid: false,
    // rust: },
    // rust: );
    // rust: assert!(t.path([0, 64, 0], [1.5, 64.0, 0.5], &[]).is_none());
    // rust: assert!(
    // rust: Terrain::flat(0..=0, 0..=0)
    // rust: .path([0, 64, 0], [5.5, 64.0, 0.5], &[])
    // rust: .is_none()
    // rust: );
}

pub fn one_step_up_and_three_step_drop_only_with_clearance() void {
}
    // rust: let mut t = Terrain::flat(0..=1, 0..=0);
    // rust: t.floors.insert((1, 0), 64);
    // rust: assert!(t.path([0, 64, 0], [1.5, 65.0, 0.5], &[]).unwrap().complete);
    // rust: t.cells.insert(
    // rust: [0, 66, 0],
    // rust: Cell {
    // rust: solid: true,
    // rust: ..Cell::default()
    // rust: },
    // rust: );
    // rust: assert!(t.path([0, 64, 0], [1.5, 65.0, 0.5], &[]).is_none());
    // rust: t.cells.clear();
    // rust: t.floors.insert((1, 0), 65);
    // rust: assert!(t.path([0, 64, 0], [1.5, 66.0, 0.5], &[]).is_none());
    // rust: t.floors.insert((1, 0), 60);
    // rust: assert!(t.path([0, 64, 0], [1.5, 61.0, 0.5], &[]).unwrap().complete);
    // rust: t.cells.insert(
    // rust: [1, 64, 0],
    // rust: Cell {
    // rust: solid: true,
    // rust: ..Cell::default()
    // rust: },
    // rust: );
    // rust: assert!(t.path([0, 64, 0], [1.5, 61.0, 0.5], &[]).is_none());
    // rust: t.cells.clear();
    // rust: t.floors.insert((1, 0), 59);
    // rust: assert!(t.path([0, 64, 0], [1.5, 60.0, 0.5], &[]).is_none());
}

pub fn dry_bypass_costs_less_than_water() void {
}
    // rust: let mut t = Terrain::flat(0..=2, 0..=1);
    // rust: t.cells.insert(
    // rust: [1, 64, 0],
    // rust: Cell {
    // rust: fluid: true,
    // rust: ..Cell::default()
    // rust: },
    // rust: );
    // rust: let p = t.path([0, 64, 0], [2.5, 64.0, 0.5], &[]).unwrap();
    // rust: assert!(p.complete);
    // rust: assert!(!p.nodes.contains(&[1, 64, 0]));
}

pub fn search_budget_returns_progress_instead_of_discarding_it() void {
}
    // rust: let p = Terrain::flat(0..=30_010, 0..=0)
    // rust: .path([0, 64, 0], [40_000.5, 64.0, 0.5], &[])
    // rust: .unwrap();
    // rust: assert!(!p.complete);
    // rust: assert!(p.nodes.len() > 2 && p.nodes.len() <= 30_001);
}
pub fn consumed_partial_never_aims_at_unknown_goal_or_arrives() void {
}
    // rust: let plan = Plan {
    // rust: nodes: vec![[0, 64, 0], [1, 64, 0]],
    // rust: complete: false,
}
    // rust: let p = [1.5, 64.0, 0.5];
    // rust: let goal = [10.5, 64.0, 0.5];
    // rust: let mut next = 1;
    // rust: assert_eq!(plan.aim(p, &mut next, goal), None);
    // rust: assert!(!arrived(p, goal, 0.6));
}

pub fn replacement_path_uses_its_new_waypoint() void {
}
    // rust: let plan = Plan {
    // rust: nodes: vec![[0, 64, 0], [0, 64, 1], [1, 64, 1]],
    // rust: complete: false,
}
    // rust: assert_eq!(
    // rust: plan.aim([0.5, 64.0, 0.5], &mut 1, [5.5, 64.0, 0.5]),
    // rust: Some([0.5, 64.0, 1.5])
    // rust: );
    // rust: assert!(arrived([5.5, 64.0, 0.5], [5.5, 64.0, 0.5], 0.6));
}
pub fn jumping_in_place_does_not_reset_stuck_timer() void {
}
    // rust: let start = [0.5, 64.0, 0.5];
    // rust: let aim = [4.5, 64.0, 0.5];
    // rust: let mut progress = Progress::new(start, aim);
    // rust: assert!(!progress.advance([0.5, 65.0, 0.5], aim));
    // rust: assert!(!progress.advance([0.6, 64.0, 0.6], aim));
    // rust: assert!(progress.advance([0.8, 64.0, 0.5], aim));
}
pub fn oscillation_and_vertical_drift_do_not_count_as_progress() void {
}
    // rust: let aim = [4.5, 64.0, 0.5];
    // rust: let mut progress = Progress::new([0.5, 64.0, 0.5], aim);
    // rust: for tick in 0..400 {
    // rust: let x = if tick % 2 == 0 { 0.2 } else { 0.5 };
    // rust: assert!(
    // rust: !progress.advance([x, 64.0, 0.5], aim),
    // rust: "oscillation reset at {tick}"
    // rust: );
}
    // rust: assert!(!progress.advance([0.5, 66.0, 0.5], aim));
}

pub fn only_new_best_distance_counts_and_waypoint_switch_resets_baseline() void {
}
    // rust: let aim = [4.5, 64.0, 0.5];
    // rust: let start = [0.5, 64.0, 0.5];
    // rust: let mut progress = Progress::new(start, aim);
    // rust: assert!(!progress.advance([0.6, 64.0, 0.5], aim));
    // rust: assert!(progress.advance([0.8, 64.0, 0.5], aim));
    // rust: assert!(!progress.advance(start, aim));
    // rust: assert!(!progress.advance([0.8, 64.0, 0.5], aim));
    // rust: assert!(progress.advance([1.1, 64.0, 0.5], aim));
    // rust: let detour_aim = [1.1, 64.0, 2.5];
    // rust: let mut progress = Progress::new([1.1, 64.0, 0.5], detour_aim);
    // rust: assert!(progress.advance([1.1, 64.0, 0.8], detour_aim));
}
}
