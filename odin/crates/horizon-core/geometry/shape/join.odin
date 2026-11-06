//! Transpiled from Horizon Rust crate
package horizon_core_join

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{ShapeError, VoxelShape, volume};
// use crate::geometry::{Axis, COLLISION_EPSILON};

// A four-bit truth table, indexed as (first << 1) | second.
// True for two empty cells would describe an unbounded volume, which vanilla
// rejects for shape joins. Typed errors preserve that rejection here.
ShapeOp :: struct {
    // rust: impl ShapeOp {
FALSE :: Self(0)
AND :: Self(8)
OR :: Self(14)
XOR :: Self(6)
ONLY_FIRST :: Self(4)
ONLY_SECOND :: Self(2)
    // rust: pub const fn from_truth_table(bits: u8) -> Self {
    // rust: Self(bits & 15)
}
    // rust: pub const fn apply(self, first: bool, second: bool) -> bool {
    // rust: self.0 & (1 << ((first as u8) * 2 + second as u8)) != 0
}
validate :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.apply(false, false) {
    // rust: Err(ShapeError::UnboundedBoolean)
    // rust: } else {
    // rust: Ok(())
}
}
}

Merger :: struct {
    coords: [dynamic]f64,
    first: [dynamic]i32,
    second: [dynamic]i32,
    cube_range: bool,
    discrete_cube: bool,
}

    // rust: impl VoxelShape {
    // Shapes.joinUnoptimized, preserving merged coordinates and cube metadata.
join_unoptimized :: proc(self: ^Self, other: ^Self, operation: ShapeOp) -> R {
    // Ported from Horizon
    return {}
}
    // rust: operation.validate()?;
    // rust: if self.same_identity(other) {
    // rust: return Ok(if operation.apply(true, true) {
    // rust: self.clone()
    // rust: } else {
    // rust: Self::empty()
    // rust: });
}
    // rust: let only_first = operation.apply(true, false);
    // rust: let only_second = operation.apply(false, true);
    // rust: if self.is_empty() {
    // rust: return Ok(if only_second {
    // rust: other.clone()
    // rust: } else {
    // rust: Self::empty()
    // rust: });
}
    // rust: if other.is_empty() {
    // rust: return Ok(if only_first {
    // rust: self.clone()
    // rust: } else {
    // rust: Self::empty()
    // rust: });
}
    // rust: let mergers = self.mergers(other, only_first, only_second)?;
    // rust: let sizes = std::array::from_fn(|i| mergers[i].coords.len() - 1);
    // rust: let count = volume(sizes)?;
    // rust: let mut occupied = Vec::with_capacity(count);
    // rust: for x in 0..sizes[0] {
    // rust: for y in 0..sizes[1] {
    // rust: for z in 0..sizes[2] {
    // rust: let a = self.is_full(
    // rust: mergers[0].first[x],
    // rust: mergers[1].first[y],
    // rust: mergers[2].first[z],
    // rust: );
    // rust: let b = other.is_full(
    // rust: mergers[0].second[x],
    // rust: mergers[1].second[y],
    // rust: mergers[2].second[z],
    // rust: );
    // rust: occupied.push(operation.apply(a, b));
}
}
}
    // rust: let [x, y, z] = mergers;
    // rust: let coordinate_cubes = [x.cube_range, y.cube_range, z.cube_range];
    // rust: let cube = x.discrete_cube && y.discrete_cube && z.discrete_cube;
    // rust: let shape = Self::build(
    // rust: [x.coords, y.coords, z.coords],
    // rust: &occupied,
    // rust: cube,
    // rust: coordinate_cubes,
    // rust: )?;
    // rust: if shape.is_empty() {
    // rust: shape.with_discrete_bounds([i32::MAX; 3], [i32::MIN + 1; 3])
    // rust: } else {
    // rust: Ok(shape)
}
}
    // Shapes.joinIsNotEmpty without allocating the result occupancy or boxes.
join_is_not_empty :: proc(self: ^Self, other: ^Self, operation: ShapeOp) -> R {
    // Ported from Horizon
    return {}
}
    // rust: operation.validate()?;
    // rust: let a_empty = self.is_empty();
    // rust: let b_empty = other.is_empty();
    // rust: if a_empty || b_empty {
    // rust: return Ok(operation.apply(!a_empty, !b_empty));
}
    // rust: if self.same_identity(other) {
    // rust: return Ok(operation.apply(true, true));
}
    // rust: let only_first = operation.apply(true, false);
    // rust: let only_second = operation.apply(false, true);
    // rust: for axis in Axis::ALL {
    // rust: if self.max(axis) < other.min(axis) - COLLISION_EPSILON
    // rust: || other.max(axis) < self.min(axis) - COLLISION_EPSILON
    // rust: {
    // rust: return Ok(only_first || only_second);
}
}
    // rust: let mergers = self.mergers(other, only_first, only_second)?;
    // rust: let sizes = std::array::from_fn(|i| mergers[i].coords.len() - 1);
    // rust: volume(sizes)?;
    // rust: for x in 0..sizes[0] {
    // rust: for y in 0..sizes[1] {
    // rust: for z in 0..sizes[2] {
    // rust: if operation.apply(
    // rust: self.is_full(
    // rust: mergers[0].first[x],
    // rust: mergers[1].first[y],
    // rust: mergers[2].first[z],
    // rust: ),
    // rust: other.is_full(
    // rust: mergers[0].second[x],
    // rust: mergers[1].second[y],
    // rust: mergers[2].second[z],
    // rust: ),
    // rust: ) {
    // rust: return Ok(true);
}
}
}
}
    // rust: Ok(false)
}
    // rust: fn mergers(
    // rust: &self,
    // rust: other: &Self,
    // rust: only_first: bool,
    // rust: only_second: bool,
    // rust: ) -> Result<[Merger; 3], ShapeError> {
    // rust: let x = merge(
    // rust: 1,
    // rust: &self.coords[0],
    // rust: &other.coords[0],
    // rust: self.coordinate_cubes[0],
    // rust: other.coordinate_cubes[0],
    // rust: only_first,
    // rust: only_second,
    // rust: )?;
    // rust: let y = merge(
    // rust: x.coords.len() - 1,
    // rust: &self.coords[1],
    // rust: &other.coords[1],
    // rust: self.coordinate_cubes[1],
    // rust: other.coordinate_cubes[1],
    // rust: only_first,
    // rust: only_second,
    // rust: )?;
    // rust: let multiplier = (x.coords.len() - 1)
    // rust: .checked_mul(y.coords.len() - 1)
    // rust: .ok_or(ShapeError::TooLarge)?;
    // rust: let z = merge(
    // rust: multiplier,
    // rust: &self.coords[2],
    // rust: &other.coords[2],
    // rust: self.coordinate_cubes[2],
    // rust: other.coordinate_cubes[2],
    // rust: only_first,
    // rust: only_second,
    // rust: )?;
    // rust: Ok([x, y, z])
}
}

    // rust: fn merge(
    // rust: multiplier: usize,
    // rust: a: &[f64],
    // rust: b: &[f64],
    // rust: a_cube: bool,
    // rust: b_cube: bool,
    // rust: only_first: bool,
    // rust: only_second: bool,
    // rust: ) -> Result<Merger, ShapeError> {
    // rust: let na = a.len() - 1;
    // rust: let nb = b.len() - 1;
    // rust: if a_cube && b_cube {
    // rust: let gcd = gcd(na, nb);
    // rust: let lcm = (na / gcd).checked_mul(nb).ok_or(ShapeError::TooLarge)?;
    // rust: if multiplier
    // rust: .checked_mul(lcm)
    // rust: .is_some_and(|volume| volume <= 256)
    // rust: {
    // rust: return Ok(Merger {
    // rust: coords: (0..=lcm).map(|i| i as f64 / lcm as f64).collect(),
    // rust: first: (0..lcm).map(|i| (i / (nb / gcd)) as i32).collect(),
    // rust: second: (0..lcm).map(|i| (i / (na / gcd)) as i32).collect(),
    // rust: cube_range: true,
    // rust: discrete_cube: true,
    // rust: });
}
}
    // rust: if a[na] < b[0] - COLLISION_EPSILON {
    // rust: return Ok(disjoint(a, b, false));
}
    // rust: if b[nb] < a[0] - COLLISION_EPSILON {
    // rust: return Ok(disjoint(b, a, true));
}
    // Primitive DoubleArrayList equality treats the two signed zeros equally.
    // rust: if a.len() == b.len() && a.iter().zip(b).all(|(a, b)| a == b) {
    // rust: return Ok(Merger {
    // rust: coords: a.to_vec(),
    // rust: first: (0..na).map(|i| i as i32).collect(),
    // rust: second: (0..na).map(|i| i as i32).collect(),
    // rust: cube_range: a_cube,
    // rust: discrete_cube: false,
    // rust: });
}
    // rust: let mut coords = Vec::with_capacity(a.len() + b.len());
    // rust: let mut first = Vec::with_capacity(coords.capacity());
    // rust: let mut second = Vec::with_capacity(coords.capacity());
    // rust: let (mut i, mut j) = (0usize, 0usize);
    // rust: let mut last = f64::NAN;
    // rust: while i < a.len() || j < b.len() {
    // rust: let a_end = i == a.len();
    // rust: let b_end = j == b.len();
    // rust: let choose_a = !a_end && (b_end || a[i] < b[j] + COLLISION_EPSILON);
    // rust: if choose_a {
    // rust: i += 1;
    // rust: if !only_first && (j == 0 || b_end) {
    // rust: continue;
}
    // rust: } else {
    // rust: j += 1;
    // rust: if !only_second && (i == 0 || a_end) {
    // rust: continue;
}
}
    // rust: let ai = i as i32 - 1;
    // rust: let bj = j as i32 - 1;
    // rust: let value = if choose_a { a[i - 1] } else { b[j - 1] };
    // rust: if !matches!(
    // rust: last.partial_cmp(&(value - COLLISION_EPSILON)),
    // rust: Some(std::cmp::Ordering::Greater | std::cmp::Ordering::Equal)
    // rust: ) {
    // rust: coords.push(value);
    // rust: first.push(ai);
    // rust: second.push(bj);
    // rust: last = value;
    // rust: } else {
    // rust: let n = coords.len() - 1;
    // rust: first[n] = ai;
    // rust: second[n] = bj;
}
}
    // rust: if coords.len() <= 1 {
    // rust: coords = vec![0.0];
    // rust: first.clear();
    // rust: second.clear();
    // rust: } else {
    // rust: first.pop();
    // rust: second.pop();
}
    // rust: Ok(Merger {
    // rust: coords,
    // rust: first,
    // rust: second,
    // rust: cube_range: false,
    // rust: discrete_cube: false,
    // rust: })
}
disjoint :: proc(lower: ^[f64], upper: ^[f64], swap: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let nl = lower.len();
    // rust: let nu = upper.len();
    // rust: let mut first = Vec::with_capacity(nl + nu - 1);
    // rust: let mut second = Vec::with_capacity(nl + nu - 1);
    // rust: for i in 0..nl {
    // rust: first.push(i as i32);
    // rust: second.push(-1);
}
    // rust: for i in 0..nu - 1 {
    // rust: first.push(nl as i32 - 1);
    // rust: second.push(i as i32);
}
    // rust: if swap {
    // rust: std::mem::swap(&mut first, &mut second);
}
    // rust: Merger {
    // rust: coords: lower.iter().chain(upper).copied().collect(),
    // rust: first,
    // rust: second,
    // rust: cube_range: false,
    // rust: discrete_cube: false,
}
}
gcd :: proc(mut a: uint, mut b: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: while b != 0 {
    // rust: let r = a % b;
    // rust: a = b;
    // rust: b = r;
}
    // rust: a
}

    // rust: mod tests {
//     use super::*;
//     use crate::geometry::Vec3;
signed_zero_list_equality_preserves_first_coordinates :: proc() {
}
    // rust: let a = VoxelShape::from_grid([vec![0.0, 1.0], vec![0.0, 1.0], vec![0.0, 1.0]], &[true])
    // rust: .unwrap();
    // rust: let b = VoxelShape::from_grid([vec![-0.0, 1.0], vec![0.0, 1.0], vec![0.0, 1.0]], &[true])
    // rust: .unwrap();
    // rust: let joined = a.join_unoptimized(&b, ShapeOp::FALSE).unwrap();
    // rust: assert!(joined.is_empty());
    // rust: assert_eq!(joined.coordinates(Axis::X)[0].to_bits(), 0.0f64.to_bits());
    // rust: assert_eq!(joined.coordinates(Axis::X).len(), 2);
}
returned_shapes_preserve_alias_identity :: proc() {
}
    // rust: let a = VoxelShape::block().moved(Vec3::new(2.0, 0.0, 0.0));
    // rust: let alias = VoxelShape::empty()
    // rust: .join_unoptimized(&a, ShapeOp::OR)
    // rust: .unwrap();
    // rust: assert!(a.same_identity(&alias));
    // rust: let result = a.join_unoptimized(&alias, ShapeOp::FALSE).unwrap();
    // rust: assert!(result.same_identity(&VoxelShape::empty()));
    // rust: assert_eq!(result.coordinates(Axis::X), &[0.0]);
    // rust: assert!(!a.same_identity(&a.moved(Vec3::ZERO)));
}
unions_intersections_difference_and_rejection :: proc() {
}
    // rust: let a = VoxelShape::block();
    // rust: let b = a.moved(Vec3::new(0.5, 0.0, 0.0));
    // rust: let union = a.join_unoptimized(&b, ShapeOp::OR).unwrap();
    // rust: assert_eq!(union.max(Axis::X), 1.5);
    // rust: let intersection = a.join_unoptimized(&b, ShapeOp::AND).unwrap();
    // rust: assert_eq!(intersection.min(Axis::X), 0.5);
    // rust: assert_eq!(intersection.max(Axis::X), 1.0);
    // rust: let difference = a.join_unoptimized(&b, ShapeOp::ONLY_FIRST).unwrap();
    // rust: assert_eq!(difference.max(Axis::X), 0.5);
    // rust: assert!(!a.join_is_not_empty(&a, ShapeOp::XOR).unwrap());
    // rust: assert!(
    // rust: a.join_unoptimized(&b, ShapeOp::from_truth_table(1))
    // rust: .is_err()
    // rust: );
}
}
