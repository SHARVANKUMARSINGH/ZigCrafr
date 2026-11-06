//! Transpiled from Horizon Rust crate
package horizon_core_mod

import "core:fmt"
import "core:mem"
import "core:math"

// Double-precision simulation geometry for the pinned Java Edition target.
//
// Operation order and Java floating-point edge cases are deliberate. These are
// simulation coordinates; rendering may use a separate camera-relative format.

    // rust: pub mod border;
    // rust: mod movement;
    // rust: mod shape;
    // rust: mod sweep;
    // rust: mod traversal;
    // rust: pub mod trig;
// use crate::position::BlockPos;
    // rust: pub use movement::{
    // rust: block_floor_height, candidate_step_heights, entity_collision_bounds, resolve_shape_movement,
    // rust: resolve_step_movement, try_resolve_step_movement,
}
    // rust: pub use shape::{ShapeError, ShapeOp, VoxelShape};
    // rust: pub use sweep::sweep_intersected_blocks;
    // rust: pub use traversal::{TraversalError, traverse_blocks};

COLLISION_EPSILON :: 1.0e-7

Axis :: enum {
    X,
    Y,
    Z,
}

    // rust: impl Axis {
ALL :: [Self::X, Self::Y, Self::Z]
step_order :: proc(movement: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if movement.x.abs() < movement.z.abs() {
    // rust: [Self::Y, Self::Z, Self::X]
    // rust: } else {
    // rust: [Self::Y, Self::X, Self::Z]
}
}
}

Direction :: enum {
    Down,
    Up,
    North,
    South,
    West,
    East,
}

    // rust: impl Direction {
    // rust: pub const ALL: [Self; 6] = [
    // rust: Self::Down,
    // rust: Self::Up,
    // rust: Self::North,
    // rust: Self::South,
    // rust: Self::West,
    // rust: Self::East,
    // rust: ];
    // rust: pub const fn opposite(self) -> Self {
    // rust: match self {
    // rust: Self::Down => Self::Up,
    // rust: Self::Up => Self::Down,
    // rust: Self::North => Self::South,
    // rust: Self::South => Self::North,
    // rust: Self::West => Self::East,
    // rust: Self::East => Self::West,
}
}
    // rust: pub const fn normal(self) -> [i32; 3] {
    // rust: match self {
    // rust: Self::Down => [0, -1, 0],
    // rust: Self::Up => [0, 1, 0],
    // rust: Self::North => [0, 0, -1],
    // rust: Self::South => [0, 0, 1],
    // rust: Self::West => [-1, 0, 0],
    // rust: Self::East => [1, 0, 0],
}
}
approximate_nearest :: proc(vector: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = vector.components().map(|v| v as f32);
    // rust: let mut best = f32::from_bits(1);
    // rust: let mut result = Self::North;
    // rust: for direction in Self::ALL {
    // rust: let [nx, ny, nz] = direction.normal().map(|v| v as f32);
    // rust: let dot = x * nx + y * ny + z * nz;
    // rust: if dot > best {
    // rust: best = dot;
    // rust: result = direction;
}
}
    // rust: result
}
}

// Component equality follows Java Double.compare, including NaNs and -0.0.
Vec3 :: struct {
    x: f64,
    y: f64,
    z: f64,
}

    // rust: impl PartialEq for Vec3 {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.components()
    // rust: .into_iter()
    // rust: .zip(other.components())
    // rust: .all(|(a, b)| canonical_bits(a) == canonical_bits(b))
}
}
    // rust: impl Vec3 {
ZERO :: Self::new(0.0, 0.0, 0.0)
    // rust: pub const fn new(x: f64, y: f64, z: f64) -> Self {
    // rust: Self { x, y, z }
}
    // rust: pub const fn components(self) -> [f64; 3] {
    // rust: [self.x, self.y, self.z]
}
component :: proc(self: ^Self, axis: Axis) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.components()[axis as usize]
}
from_block :: proc(pos: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(pos.x as f64, pos.y as f64, pos.z as f64)
}
add_vector :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.x + other.x, self.y + other.y, self.z + other.z)
}
subtract :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.add_vector(Self::new(-other.x, -other.y, -other.z))
}
vector_to :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(other.x - self.x, other.y - self.y, other.z - self.z)
}
multiply :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.x * other.x, self.y * other.y, self.z * other.z)
}
scale :: proc(self: ^Self, scale: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.multiply(Self::new(scale, scale, scale))
}
reverse :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.scale(-1.0)
}
horizontal :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.x, 0.0, self.z)
}
dot :: proc(self: ^Self, other: Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.x * other.x + self.y * other.y + self.z * other.z
}
cross :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: self.y * other.z - self.z * other.y,
    // rust: self.z * other.x - self.x * other.z,
    // rust: self.x * other.y - self.y * other.x,
    // rust: )
}
length_squared :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.x * self.x + self.y * self.y + self.z * self.z
}
length :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.length_squared().sqrt()
}
horizontal_distance_squared :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.x * self.x + self.z * self.z
}
horizontal_distance :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.horizontal_distance_squared().sqrt()
}
distance_squared :: proc(self: ^Self, other: Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let x = self.x - other.x;
    // rust: let y = self.y - other.y;
    // rust: let z = self.z - other.z;
    // rust: x * x + y * y + z * z
}
distance :: proc(self: ^Self, other: Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.distance_squared(other).sqrt()
}
normalize :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let length = self.length();
    // rust: if length < 9.999999747378752e-6 {
    // rust: Self::ZERO
    // rust: } else {
    // rust: Self::new(self.x / length, self.y / length, self.z / length)
}
}
lerp :: proc(self: ^Self, other: Self, amount: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: lerp(amount, self.x, other.x),
    // rust: lerp(amount, self.y, other.y),
    // rust: lerp(amount, self.z, other.z),
    // rust: )
}
projected_on :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if other.length_squared() == 0.0 {
    // rust: other
    // rust: } else {
    // rust: other
    // rust: .scale(self.dot(other))
    // rust: .scale(1.0 / other.length_squared())
}
}
closer_than :: proc(self: ^Self, other: Self, distance: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.distance_squared(other) < distance * distance
}
is_finite :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.x.is_finite() && self.y.is_finite() && self.z.is_finite()
}
with_component :: proc(self: ^Self, axis: Axis, value: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut coordinates = self.components();
    // rust: coordinates[axis as usize] = value;
    // rust: Self::new(coordinates[0], coordinates[1], coordinates[2])
}
align :: proc(self: ^Self, axes: [bool; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let coordinates = std::array::from_fn::<_, 3, _>(|i| {
    // rust: if axes[i] {
    // rust: floor_i32(self.components()[i]) as f64
    // rust: } else {
    // rust: self.components()[i]
}
    // rust: });
    // rust: Self::new(coordinates[0], coordinates[1], coordinates[2])
}
relative :: proc(self: ^Self, direction: Direction, distance: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let normal = direction.normal();
    // rust: Self::new(
    // rust: self.x + distance * normal[0] as f64,
    // rust: self.y + distance * normal[1] as f64,
    // rust: self.z + distance * normal[2] as f64,
    // rust: )
}
rotate_x :: proc(self: ^Self, angle: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let c = trig::cos(angle as f64) as f64;
    // rust: let s = trig::sin(angle as f64) as f64;
    // rust: Self::new(self.x, self.y * c + self.z * s, self.z * c - self.y * s)
}
rotate_y :: proc(self: ^Self, angle: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let c = trig::cos(angle as f64) as f64;
    // rust: let s = trig::sin(angle as f64) as f64;
    // rust: Self::new(self.x * c + self.z * s, self.y, self.z * c - self.x * s)
}
rotate_z :: proc(self: ^Self, angle: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let c = trig::cos(angle as f64) as f64;
    // rust: let s = trig::sin(angle as f64) as f64;
    // rust: Self::new(self.x * c + self.y * s, self.y * c - self.x * s, self.z)
}
rotate_clockwise_90 :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(-self.z, self.y, self.x)
}
direction_from_rotation :: proc(pitch: f32, yaw: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let yaw_radians = -yaw * trig::DEG_TO_RAD - std::f32::consts::PI;
    // rust: let cy = trig::cos(yaw_radians as f64);
    // rust: let sy = trig::sin(yaw_radians as f64);
    // rust: let pitch_radians = -pitch * trig::DEG_TO_RAD;
    // rust: let cp = -trig::cos(pitch_radians as f64);
    // rust: let sp = trig::sin(pitch_radians as f64);
    // rust: Self::new((sy * cp) as f64, sp as f64, (cy * cp) as f64)
}
    // Return vanilla's (pitch, yaw) float pair in degrees.
rotation :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let yaw = ((-self.x).atan2(self.z) as f32) * trig::RAD_TO_DEG;
    // rust: let pitch = ((-self.y / self.length()).asin() as f32) * trig::RAD_TO_DEG;
    // rust: [pitch, yaw]
}
}

Aabb :: struct {
    min: Vec3,
    max: Vec3,
}

BlockHit :: struct {
    location: Vec3,
    direction: Direction,
    block: BlockPos,
    inside: bool,
}

    // rust: impl Aabb {
new :: proc(min: Vec3, max: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: min: Vec3::new(
    // rust: java_min(min.x, max.x),
    // rust: java_min(min.y, max.y),
    // rust: java_min(min.z, max.z),
    // rust: ),
    // rust: max: Vec3::new(
    // rust: java_max(min.x, max.x),
    // rust: java_max(min.y, max.y),
    // rust: java_max(min.z, max.z),
    // rust: ),
}
}
block :: proc(pos: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(Vec3::from_block(pos), Vec3::from_block(pos.offset(1, 1, 1)))
}
unit_cube :: proc(lower: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(lower, lower.add_vector(Vec3::new(1.0, 1.0, 1.0)))
}
of_size :: proc(center: Vec3, size: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: Vec3::new(
    // rust: center.x - size.x / 2.0,
    // rust: center.y - size.y / 2.0,
    // rust: center.z - size.z / 2.0,
    // rust: ),
    // rust: Vec3::new(
    // rust: center.x + size.x / 2.0,
    // rust: center.y + size.y / 2.0,
    // rust: center.z + size.z / 2.0,
    // rust: ),
    // rust: )
}
encapsulating_blocks :: proc(a: BlockPos, b: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: Vec3::from_block(BlockPos::new(a.x.min(b.x), a.y.min(b.y), a.z.min(b.z))),
    // rust: Vec3::from_block(BlockPos::new(
    // rust: a.x.max(b.x).wrapping_add(1),
    // rust: a.y.max(b.y).wrapping_add(1),
    // rust: a.z.max(b.z).wrapping_add(1),
    // rust: )),
    // rust: )
}
    // rust: pub const fn min_position(self) -> Vec3 {
    // rust: self.min
}
    // rust: pub const fn max_position(self) -> Vec3 {
    // rust: self.max
}
min :: proc(self: ^Self, axis: Axis) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.min.component(axis)
}
max :: proc(self: ^Self, axis: Axis) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.max.component(axis)
}
with_min :: proc(self: ^Self, axis: Axis, value: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = self.min.components();
    // rust: a[axis as usize] = value;
    // rust: Self::new(Vec3::new(a[0], a[1], a[2]), self.max)
}
with_max :: proc(self: ^Self, axis: Axis, value: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = self.max.components();
    // rust: a[axis as usize] = value;
    // rust: Self::new(self.min, Vec3::new(a[0], a[1], a[2]))
}
size :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.min.vector_to(self.max)
}
average_size :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let v = self.size();
    // rust: (v.x + v.y + v.z) / 3.0
}
center :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.min.lerp(self.max, 0.5)
}
bottom_center :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let v = self.center();
    // rust: Vec3::new(v.x, self.min.y, v.z)
}
move_by :: proc(self: ^Self, offset: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.min.add_vector(offset), self.max.add_vector(offset))
}
inflate :: proc(self: ^Self, amount: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: Vec3::new(
    // rust: self.min.x - amount.x,
    // rust: self.min.y - amount.y,
    // rust: self.min.z - amount.z,
    // rust: ),
    // rust: self.max.add_vector(amount),
    // rust: )
}
deflate :: proc(self: ^Self, amount: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.inflate(amount.reverse())
}
expand_towards :: proc(self: ^Self, amount: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.change_extent(amount, false)
}
contract :: proc(self: ^Self, amount: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.change_extent(amount, true)
}
change_extent :: proc(self: ^Self, amount: Vec3, contract: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut min = self.min.components();
    // rust: let mut max = self.max.components();
    // rust: for (i, v) in amount.components().into_iter().enumerate() {
    // rust: if v < 0.0 {
    // rust: min[i] = if contract { min[i] - v } else { min[i] + v };
    // rust: } else if v > 0.0 {
    // rust: max[i] = if contract { max[i] - v } else { max[i] + v };
}
}
    // rust: Self::new(
    // rust: Vec3::new(min[0], min[1], min[2]),
    // rust: Vec3::new(max[0], max[1], max[2]),
    // rust: )
}
intersect :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: Vec3::new(
    // rust: java_max(self.min.x, other.min.x),
    // rust: java_max(self.min.y, other.min.y),
    // rust: java_max(self.min.z, other.min.z),
    // rust: ),
    // rust: Vec3::new(
    // rust: java_min(self.max.x, other.max.x),
    // rust: java_min(self.max.y, other.max.y),
    // rust: java_min(self.max.z, other.max.z),
    // rust: ),
    // rust: )
}
union_bounds :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(
    // rust: Vec3::new(
    // rust: java_min(self.min.x, other.min.x),
    // rust: java_min(self.min.y, other.min.y),
    // rust: java_min(self.min.z, other.min.z),
    // rust: ),
    // rust: Vec3::new(
    // rust: java_max(self.max.x, other.max.x),
    // rust: java_max(self.max.y, other.max.y),
    // rust: java_max(self.max.z, other.max.z),
    // rust: ),
    // rust: )
}
    // `AABB.intersects(minX, minY, minZ, maxX, maxY, maxZ)`: `intersects`
    // with a box given by its corners, `min` below `max` on every axis.
intersects_corners :: proc(self: ^Self, min: Vec3, max: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.min.x < max.x
    // rust: && self.max.x > min.x
    // rust: && self.min.y < max.y
    // rust: && self.max.y > min.y
    // rust: && self.min.z < max.z
    // rust: && self.max.z > min.z
}
intersects :: proc(self: ^Self, other: Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.min.x < other.max.x
    // rust: && self.max.x > other.min.x
    // rust: && self.min.y < other.max.y
    // rust: && self.max.y > other.min.y
    // rust: && self.min.z < other.max.z
    // rust: && self.max.z > other.min.z
}
contains :: proc(self: ^Self, point: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: point.x >= self.min.x
    // rust: && point.x < self.max.x
    // rust: && point.y >= self.min.y
    // rust: && point.y < self.max.y
    // rust: && point.z >= self.min.z
    // rust: && point.z < self.max.z
}
has_nan :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.min
    // rust: .components()
    // rust: .into_iter()
    // rust: .chain(self.max.components())
    // rust: .any(f64::is_nan)
}
distance_squared_to_point :: proc(self: ^Self, point: Vec3) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let distances = Axis::ALL.map(|a| {
    // rust: java_max(
    // rust: java_max(
    // rust: self.min(a) - point.component(a),
    // rust: point.component(a) - self.max(a),
    // rust: ),
    // rust: 0.0,
    // rust: )
    // rust: });
    // rust: distances[0] * distances[0] + distances[1] * distances[1] + distances[2] * distances[2]
}
distance_squared_to_box :: proc(self: ^Self, other: Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let distances = Axis::ALL.map(|a| {
    // rust: java_max(
    // rust: java_max(self.min(a) - other.max(a), other.min(a) - self.max(a)),
    // rust: 0.0,
    // rust: )
    // rust: });
    // rust: distances[0] * distances[0] + distances[1] * distances[1] + distances[2] * distances[2]
}
next_deflated :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lo = self.min.components().map(next_up);
    // rust: let hi = self.max.components().map(next_down);
    // rust: Self::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: )
}
clip_direction :: proc(self: ^Self, start: Vec3, delta: Vec3, best: ^f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = None;
    // rust: for axis in Axis::ALL {
    // rust: let i = axis as usize;
    // rust: let j = (i + 1) % 3;
    // rust: let k = (i + 2) % 3;
    // rust: let ds = delta.components();
    // rust: let origins = start.components();
    // rust: let (plane, face) = if ds[i] > COLLISION_EPSILON {
    // rust: (
    // rust: self.min(axis),
    // rust: [Direction::West, Direction::Down, Direction::North][i],
    // rust: )
    // rust: } else if ds[i] < -COLLISION_EPSILON {
    // rust: (
    // rust: self.max(axis),
    // rust: [Direction::East, Direction::Up, Direction::South][i],
    // rust: )
    // rust: } else {
    // rust: continue;
}
    // rust: let t = (plane - origins[i]) / ds[i];
    // rust: let u = origins[j] + t * ds[j];
    // rust: let v = origins[k] + t * ds[k];
    // rust: if 0.0 < t
    // rust: && t < *best
    // rust: && self.min.components()[j] - COLLISION_EPSILON < u
    // rust: && u < self.max.components()[j] + COLLISION_EPSILON
    // rust: && self.min.components()[k] - COLLISION_EPSILON < v
    // rust: && v < self.max.components()[k] + COLLISION_EPSILON
    // rust: {
    // rust: *best = t;
    // rust: result = Some(face);
}
}
    // rust: result
}
clip :: proc(self: ^Self, start: Vec3, end: Vec3) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let delta = start.vector_to(end);
    // rust: let mut best = 1.0;
    // rust: self.clip_direction(start, delta, &mut best)
    // rust: .map(|_| start.add_vector(delta.scale(best)))
}
    // rust: pub fn clip_boxes(
    // rust: boxes: impl IntoIterator<Item = Self>,
    // rust: start: Vec3,
    // rust: end: Vec3,
    // rust: block: BlockPos,
    // rust: ) -> Option<BlockHit> {
    // rust: let delta = start.vector_to(end);
    // rust: let mut best = 1.0;
    // rust: let mut direction = None;
    // rust: for aabb in boxes {
    // rust: if let Some(face) = aabb
    // rust: .move_by(Vec3::from_block(block))
    // rust: .clip_direction(start, delta, &mut best)
    // rust: {
    // rust: direction = Some(face);
}
}
    // rust: direction.map(|face| BlockHit {
    // rust: location: start.add_vector(delta.scale(best)),
    // rust: direction: face,
    // rust: block,
    // rust: inside: false,
    // rust: })
}
collided_along_vector :: proc(self: ^Self, movement: Vec3, boxes: ^[Self]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.center();
    // rust: let end = start.add_vector(movement);
    // rust: let amount = self.size().scale(0.5).subtract(Vec3::new(
    // rust: COLLISION_EPSILON,
    // rust: COLLISION_EPSILON,
    // rust: COLLISION_EPSILON,
    // rust: ));
    // rust: boxes.iter().any(|b| {
    // rust: let b = b.inflate(amount);
    // rust: b.contains(end) || b.contains(start) || b.clip(start, end).is_some()
    // rust: })
}
}

    // rust: pub(crate) fn java_min(a: f64, b: f64) -> f64 {
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f64::from_bits(a.to_bits() | b.to_bits())
    // rust: } else if a <= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
    // rust: pub(crate) fn java_max(a: f64, b: f64) -> f64 {
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f64::from_bits(a.to_bits() & b.to_bits())
    // rust: } else if a >= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
    // rust: pub(crate) fn clamp(value: f64, min: f64, max: f64) -> f64 {
    // rust: if value < min {
    // rust: min
    // rust: } else {
    // rust: java_min(value, max)
}
}
// `Mth.floor`, which is `(int) Math.floor(v)`: truncate, then step down for
// negative fractions. A truncating conversion and a compare, where
// `f64::floor` is a libm call on baseline x86-64. Both casts saturate (NaN is
// 0), so the step down saturates too: below `i32::MIN` stays `i32::MIN`.
    // rust: pub(crate) fn floor_i32(value: f64) -> i32 {
    // rust: let truncated = value as i32;
    // rust: if value < f64::from(truncated) {
    // rust: truncated.saturating_sub(1)
    // rust: } else {
    // rust: truncated
}
}
lerp :: proc(amount: f64, start: f64, end: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: start + amount * (end - start)
}
canonical_bits :: proc(value: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if value.is_nan() {
    // rust: 0x7ff8_0000_0000_0000
    // rust: } else {
    // rust: value.to_bits()
}
}
next_up :: proc(value: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if value.is_nan() || value == f64::INFINITY {
    // rust: value
    // rust: } else if value == 0.0 {
    // rust: f64::from_bits(1)
    // rust: } else {
    // rust: f64::from_bits(if value > 0.0 {
    // rust: value.to_bits() + 1
    // rust: } else {
    // rust: value.to_bits() - 1
    // rust: })
}
}
next_down :: proc(value: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: -next_up(-value)
}

    // rust: mod tests {
//     use super::*;

floor_i32_is_mths_floor :: proc() {
}
    // rust: for v in [
    // rust: 0.0,
    // rust: -0.0,
    // rust: 0.5,
    // rust: -0.5,
    // rust: 1.0,
    // rust: -1.0,
    // rust: 2.999,
    // rust: -2.999,
    // rust: 1e-300,
    // rust: -1e-300,
    // rust: 16_777_215.5,
    // rust: -16_777_215.5,
            // Past the i32 range `(int) Math.floor` saturates (vanilla 26.3's
            // BlockCollisions and BlockPos.containing rely on it).
    // rust: 2_147_483_647.5,
    // rust: 2_147_483_648.0,
    // rust: -2_147_483_648.0,
    // rust: -2_147_483_648.5,
    // rust: -2_147_483_649.0,
    // rust: 3e9,
    // rust: -3e9,
    // rust: f64::MAX,
    // rust: f64::MIN,
    // rust: f64::INFINITY,
    // rust: f64::NEG_INFINITY,
    // rust: ] {
    // rust: assert_eq!(floor_i32(v), v.floor() as i32, "{v}");
}
    // rust: assert_eq!(floor_i32(f64::NAN), 0);
    // rust: assert_eq!(floor_i32(-3e9), i32::MIN);
    // rust: assert_eq!(floor_i32(-2_147_483_648.5), i32::MIN);
}
ray_faces_and_half_open_bounds :: proc() {
}
    // rust: let b = Aabb::block(BlockPos::new(0, 0, 0));
    // rust: assert!(b.contains(Vec3::ZERO));
    // rust: assert!(!b.contains(Vec3::new(1.0, 0.0, 0.0)));
    // rust: assert_eq!(
    // rust: b.clip(Vec3::new(-1.0, 0.5, 0.5), Vec3::new(2.0, 0.5, 0.5)),
    // rust: Some(Vec3::new(0.0, 0.5, 0.5))
    // rust: );
    // rust: assert!(
    // rust: b.clip(Vec3::new(0.5, 0.5, 0.5), Vec3::new(2.0, 0.5, 0.5))
    // rust: .is_none()
    // rust: );
    // rust: assert!(
    // rust: b.clip(Vec3::new(-1.0, 0.5, 0.5), Vec3::new(0.0, 0.5, 0.5))
    // rust: .is_none()
    // rust: );
}
numerical_boundaries :: proc() {
}
    // rust: assert_eq!(java_min(0.0, -0.0).to_bits(), (-0.0f64).to_bits());
    // rust: assert_eq!(java_max(0.0, -0.0).to_bits(), 0.0f64.to_bits());
    // rust: assert_eq!(Vec3::new(-0.0, 0.0, 0.0).normalize(), Vec3::ZERO);
    // rust: assert_ne!(Vec3::new(-0.0, 0.0, 0.0), Vec3::ZERO);
    // rust: let b = Aabb::block(BlockPos::new(i32::MAX, 0, 0));
    // rust: assert_eq!(b.min(Axis::X), i32::MIN as f64);
    // rust: assert_eq!(b.max(Axis::X), i32::MAX as f64);
    // rust: assert!(Aabb::new(Vec3::new(f64::NAN, 0.0, 0.0), Vec3::new(1.0, 1.0, 1.0)).has_nan());
}
}
