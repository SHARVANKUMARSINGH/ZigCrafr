//! Transpiled from Horizon Rust crate
//! Module: horizon-core_face
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::{ShapeError, VoxelShape, volume};
// use crate::geometry::{Aabb, Axis, COLLISION_EPSILON, Direction, Vec3};

    // rust: impl VoxelShape {
    /// Native face selection samples just inside the unit-block boundary. The
    /// result preserves identity on empty/cube-like axes and caches other faces.
pub fn face_shape(self: *Self, direction: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (axis, _) = face_axis(direction);
    // rust: if self.is_empty() || self.cube_like_along(axis) {
    // rust: return Ok(self.clone());
}
    // rust: self.identity
    // rust: .faces
    // rust: .get_or_init(|| Box::new(std::array::from_fn(|_| std::sync::OnceLock::new())))
    // rust: [direction as usize]
    // rust: .get_or_init(|| self.calculate_face(direction))
    // rust: .clone()
}
    /// [`Self::face_shape`] that keeps no face it had to calculate on this
    /// shape: for a one-off pass over a whole table at load, whose faces
    /// nothing asks for again (kept, they held tens of MB).
pub fn face_shape_transient(self: *Self, direction: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (axis, _) = face_axis(direction);
    // rust: if self.is_empty() || self.cube_like_along(axis) {
    // rust: return Ok(self.clone());
}
    // rust: match self
    // rust: .identity
    // rust: .faces
    // rust: .get()
    // rust: .and_then(|faces| faces[direction as usize].get())
    // rust: {
    // rust: Some(face) => face.clone(),
    // rust: None => self.calculate_face(direction),
}
}
pub fn cube_like_along(self: *Self, axis: Axis) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let coords = self.coordinates(axis);
    // rust: coords.len() == 2
    // rust: && coords[0].abs() <= COLLISION_EPSILON
    // rust: && (coords[1] - 1.0).abs() <= COLLISION_EPSILON
}
pub fn calculate_face(self: *Self, direction: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (axis, positive) = face_axis(direction);
    // rust: let a = axis as usize;
    // rust: let index = self.find_index(
    // rust: axis,
    // rust: if positive {
    // rust: 0.9999999
    // rust: } else {
    // rust: COLLISION_EPSILON
    // rust: },
    // rust: );
    // rust: let mut starts = [0; 3];
    // rust: starts[a] = index;
    // rust: let mut ends = self.sizes.map(|v| v as i32);
    // rust: ends[a] = index + 1;
        // SubShape extrema clamp the parent bounds; they are not recomputed
        // from the selected occupancy. Sparse slices can therefore be nonempty
        // by native metadata even when their decomposition contains no boxes.
    // rust: let min =
    // rust: std::array::from_fn(|i| self.discrete_min[i].clamp(starts[i], ends[i]) - starts[i]);
    // rust: let max =
    // rust: std::array::from_fn(|i| self.discrete_max[i].clamp(starts[i], ends[i]) - starts[i]);
    // rust: if (0..3).any(|i| min[i] >= max[i]) {
    // rust: return Ok(Self::empty());
}
    // rust: let mut coords = self.coords.to_vecs();
    // rust: coords[a] = vec![0.0, 1.0];
    // rust: if (0..3).all(|i| {
    // rust: coords[i].len() == 2
    // rust: && coords[i][0].abs() <= COLLISION_EPSILON
    // rust: && (coords[i][1] - 1.0).abs() <= COLLISION_EPSILON
    // rust: }) {
    // rust: return Ok(Self::block());
}
    // rust: let sizes = std::array::from_fn(|i| coords[i].len() - 1);
    // rust: let mut occupied = Vec::with_capacity(volume(sizes)?);
    // rust: for x in 0..sizes[0] {
    // rust: for y in 0..sizes[1] {
    // rust: for z in 0..sizes[2] {
    // rust: let mut p = [x as i32, y as i32, z as i32];
    // rust: p[a] = index;
    // rust: occupied.push(self.is_full(p[0], p[1], p[2]));
}
}
}
    // rust: let mut cubes = self.coordinate_cubes;
    // rust: cubes[a] = true;
    // rust: let mut result = Self::build(coords, &occupied, false, cubes)?;
    // rust: result.discrete_min = min;
    // rust: result.discrete_max = max;
    // rust: result.bounds = Some(Aabb::new(
    // rust: Vec3::new(
    // rust: result.min(Axis::X),
    // rust: result.min(Axis::Y),
    // rust: result.min(Axis::Z),
    // rust: ),
    // rust: Vec3::new(
    // rust: result.max(Axis::X),
    // rust: result.max(Axis::Y),
    // rust: result.max(Axis::Z),
    // rust: ),
    // rust: ));
    // rust: Ok(result)
}
}
pub fn face_axis(direction: Direction) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match direction {
    // rust: Direction::Down => (Axis::Y, false),
    // rust: Direction::Up => (Axis::Y, true),
    // rust: Direction::North => (Axis::Z, false),
    // rust: Direction::South => (Axis::Z, true),
    // rust: Direction::West => (Axis::X, false),
    // rust: Direction::East => (Axis::X, true),
}
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;
pub fn face_cache_is_lazy_shared_and_does_not_retain_parent() void {
}
    // rust: let shape = VoxelShape::from_cube(
    // rust: [2, 2, 2],
    // rust: &[true, false, false, false, false, false, false, false],
    // rust: )
    // rust: .unwrap();
    // rust: assert!(shape.identity.faces.get().is_none());
    // rust: let weak = Arc::downgrade(&shape.identity);
    // rust: let face = shape.face_shape(Direction::Down).unwrap();
    // rust: assert!(!face.same_identity(&shape));
    // rust: assert!(face.same_identity(&shape.clone().face_shape(Direction::Down).unwrap()));
    // rust: assert!(shape.fresh_identity().identity.faces.get().is_none());
    // rust: assert!(shape.moved(Vec3::ZERO).identity.faces.get().is_none());
    // rust: drop(shape);
    // rust: assert!(weak.upgrade().is_none());
    // rust: assert!(!face.is_empty());
}

    /// A transient face is the cached one's geometry, keeps nothing, and
    /// returns the cached face once there is one.
pub fn transient_faces_are_not_kept() void {
}
    // rust: let shape = VoxelShape::from_cube(
    // rust: [2, 2, 2],
    // rust: &[true, false, false, false, false, false, false, false],
    // rust: )
    // rust: .unwrap();
    // rust: for direction in Direction::ALL {
    // rust: let kept = |shape: &VoxelShape| {
    // rust: shape
    // rust: .identity
    // rust: .faces
    // rust: .get()
    // rust: .is_some_and(|faces| faces[direction as usize].get().is_some())
}
    // rust: let transient = shape.face_shape_transient(direction).unwrap();
    // rust: assert!(!kept(&shape), "{direction:?}");
    // rust: let cached = shape.face_shape(direction).unwrap();
    // rust: assert!(kept(&shape));
    // rust: assert_eq!(transient.boxes(), cached.boxes(), "{direction:?}");
    // rust: let again = shape.face_shape_transient(direction).unwrap();
    // rust: assert!(again.same_identity(&cached));
}
}
}
