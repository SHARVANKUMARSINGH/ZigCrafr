//! Transpiled from Horizon Rust crate
//! Module: horizon-core_geometry_parity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Text adapter for differential checks; no vanilla logic lives in the adapter.
// use horizon_core::geometry::{
    // rust: Aabb, Axis, BlockHit, Direction, Vec3, VoxelShape, block_floor_height, candidate_step_heights,
    // rust: entity_collision_bounds, resolve_shape_movement, resolve_step_movement,
    // rust: sweep_intersected_blocks,
}
// use horizon_core::position::BlockPos;
// use std::io::{self, BufRead, Write};

pub const Input = struct {};
    // rust: impl Input<'_> {
pub fn word(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.next().expect("missing input")
}
pub fn integer(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.word().parse().expect("integer")
}
pub fn number(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from_bits(u64::from_str_radix(self.word(), 16).expect("double bits"))
}
pub fn vector(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(self.number(), self.number(), self.number())
}
pub fn aabb(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Aabb::new(self.vector(), self.vector())
}
pub fn pos(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockPos::new(self.integer(), self.integer(), self.integer())
}
}
pub fn bits(value: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: "{:016x}",
    // rust: if value.is_nan() {
    // rust: 0x7ff8_0000_0000_0000
    // rust: } else {
    // rust: value.to_bits()
}
    // rust: )
}
    // rust: fn positions(
    // rust: out: &mut impl Write,
    // rust: label: &str,
    // rust: iter: impl Iterator<Item = BlockPos>,
    // rust: limit: usize,
    // rust: ) -> io::Result<()> {
    // rust: let mut count = 0;
    // rust: for pos in iter.take(limit) {
    // rust: writeln!(out, "{label} {} {} {}", pos.x, pos.y, pos.z)?;
    // rust: count += 1;
}
    // rust: writeln!(out, "{label}-count {count}")
}
    // rust: fn values(
    // rust: out: &mut impl Write,
    // rust: label: &str,
    // rust: values: impl IntoIterator<Item = f64>,
    // rust: ) -> io::Result<()> {
    // rust: write!(out, "{label}")?;
    // rust: for value in values {
    // rust: write!(out, " {}", bits(value))?;
}
    // rust: writeln!(out)
}
pub fn vector(out: *mut impl Write, label: []const u8, v: Vec3) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: values(out, label, v.components())
}
pub fn aabb(out: *mut impl Write, label: []const u8, b: Aabb) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: values(
    // rust: out,
    // rust: label,
    // rust: b.min_position()
    // rust: .components()
    // rust: .into_iter()
    // rust: .chain(b.max_position().components()),
    // rust: )
}
pub fn point(out: *mut impl Write, label: []const u8, p: ?Vec3) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match p {
    // rust: Some(v) => vector(out, label, v),
    // rust: None => writeln!(out, "{label} none"),
}
}
pub fn hit(out: *mut impl Write, h: ?BlockHit) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match h {
    // rust: Some(h) => {
    // rust: write!(
    // rust: out,
    // rust: "hit {} {} {} {} {}",
    // rust: h.direction as u8,
    // rust: u8::from(h.inside),
    // rust: h.block.x,
    // rust: h.block.y,
    // rust: h.block.z
    // rust: )?;
    // rust: for c in h.location.components() {
    // rust: write!(out, " {}", bits(c))?;
}
    // rust: writeln!(out)
}
    // rust: None => writeln!(out, "hit none"),
}
}
pub fn shape_values(out: *mut impl Write, id: usize, shape: *VoxelShape) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: values(
    // rust: out,
    // rust: "axis-extrema",
    // rust: Axis::ALL
    // rust: .map(|axis| shape.min(axis))
    // rust: .into_iter()
    // rust: .chain(Axis::ALL.map(|axis| shape.max(axis))),
    // rust: )?;
    // rust: writeln!(out, "shape {id} {}", shape.boxes().len())?;
    // rust: let flags = shape.cube_coordinate_axes();
    // rust: writeln!(
    // rust: out,
    // rust: "cube {} {}",
    // rust: u8::from(shape.is_cube()),
    // rust: u8::from(flags[0]) + 2 * u8::from(flags[1]) + 4 * u8::from(flags[2])
    // rust: )?;
    // rust: for (axis, label) in Axis::ALL
    // rust: .into_iter()
    // rust: .zip(["x-coords", "y-coords", "z-coords"])
    // rust: {
    // rust: values(out, label, shape.coordinates(axis).iter().copied())?;
}
    // rust: if let Some(b) = shape.bounds() {
    // rust: aabb(out, "shape-bounds", b)?;
    // rust: } else {
    // rust: writeln!(out, "shape-bounds none")?;
}
    // rust: for b in shape.boxes() {
    // rust: aabb(out, "part", *b)?;
}
    // rust: Ok(())
}
pub fn main() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = io::BufWriter::new(io::stdout().lock());
    // rust: let mut shapes = Vec::<VoxelShape>::new();
    // rust: for (line_number, line) in io::stdin().lock().lines().enumerate() {
    // rust: let line = line?;
    // rust: let mut input = Input(line.split_whitespace());
    // rust: let operation = input.word().to_owned();
    // rust: writeln!(out, "command {} {operation}", line_number + 1)?;
    // rust: match operation.as_str() {
    // rust: "make-box" => {
    // rust: let shape = VoxelShape::from_box(input.aabb()).expect("valid box");
    // rust: shape_values(&mut out, shapes.len(), &shape)?;
    // rust: shapes.push(shape);
}
    // rust: "optimize" => {
    // rust: let shape = shapes[input.integer() as usize]
    // rust: .optimized()
    // rust: .expect("bounded optimization");
    // rust: shape_values(&mut out, shapes.len(), &shape)?;
    // rust: shapes.push(shape);
}
    // rust: "join" | "join-optimized" => {
    // rust: let optimized = operation == "join-optimized";
    // rust: let a = input.integer() as usize;
    // rust: let b = input.integer() as usize;
    // rust: let operation =
    // rust: horizon_core::geometry::ShapeOp::from_truth_table(input.integer() as u8);
    // rust: let result = if optimized {
    // rust: shapes[a].join(&shapes[b], operation)
    // rust: } else {
    // rust: shapes[a].join_unoptimized(&shapes[b], operation)
}
    // rust: match result {
    // rust: Err(horizon_core::geometry::ShapeError::UnboundedBoolean) => {
    // rust: writeln!(out, "join invalid")?
}
    // rust: Err(error) => panic!("join failed: {error}"),
    // rust: Ok(shape) => {
    // rust: writeln!(
    // rust: out,
    // rust: "overlap {}",
    // rust: u8::from(
    // rust: shapes[a]
    // rust: .join_is_not_empty(&shapes[b], operation)
    // rust: .expect("bounded Boolean")
    // rust: )
    // rust: )?;
    // rust: shape_values(&mut out, shapes.len(), &shape)?;
    // rust: shapes.push(shape);
}
}
}
    // rust: "traverse" => {
    // rust: let start = input.vector();
    // rust: let end = input.vector();
    // rust: let stop = input.integer();
    // rust: let mut count = 0;
    // rust: let result = horizon_core::geometry::traverse_blocks(start, end, 10000, |pos| {
    // rust: count += 1;
    // rust: writeln!(out, "visit {} {} {}", pos.x, pos.y, pos.z).expect("write visit");
    // rust: (count == stop).then_some(pos)
    // rust: })
    // rust: .expect("finite bounded corpus");
    // rust: match result {
    // rust: Some(pos) => writeln!(out, "traverse {} {} {} {count}", pos.x, pos.y, pos.z)?,
    // rust: None => writeln!(out, "traverse none {count}")?,
}
}
    // rust: "trig-table" => {
    // rust: for (i, value) in horizon_core::geometry::trig::sine_table()
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: writeln!(out, "sine {i} {:08x}", value.to_bits())?;
}
}
    // rust: "rotation" => {
    // rust: let v = input.vector();
    // rust: let angle = input.number();
    // rust: let pitch = input.number() as f32;
    // rust: let yaw = input.number() as f32;
    // rust: let axes = input.integer();
    // rust: let axis = Axis::ALL[input.integer() as usize];
    // rust: let direction = Direction::ALL[input.integer() as usize];
    // rust: let amount = input.number();
    // rust: values(
    // rust: &mut out,
    // rust: "trig",
    // rust: [
    // rust: horizon_core::geometry::trig::sin(angle) as f64,
    // rust: horizon_core::geometry::trig::cos(angle) as f64,
    // rust: ],
    // rust: )?;
    // rust: vector(&mut out, "rotate-x", v.rotate_x(angle as f32))?;
    // rust: vector(&mut out, "rotate-y", v.rotate_y(angle as f32))?;
    // rust: vector(&mut out, "rotate-z", v.rotate_z(angle as f32))?;
    // rust: vector(&mut out, "clockwise", v.rotate_clockwise_90())?;
    // rust: vector(&mut out, "look", Vec3::direction_from_rotation(pitch, yaw))?;
    // rust: values(&mut out, "rotation", v.rotation().map(|v| v as f64))?;
    // rust: vector(
    // rust: &mut out,
    // rust: "align",
    // rust: v.align([axes & 1 != 0, axes & 2 != 0, axes & 4 != 0]),
    // rust: )?;
    // rust: vector(&mut out, "with", v.with_component(axis, amount))?;
    // rust: vector(&mut out, "relative", v.relative(direction, amount))?;
}
    // rust: "vec" => {
    // rust: let a = input.vector();
    // rust: let b = input.vector();
    // rust: let t = input.number();
    // rust: for (label, v) in [
    // rust: ("add", a.add_vector(b)),
    // rust: ("subtract", a.subtract(b)),
    // rust: ("vector-to", a.vector_to(b)),
    // rust: ("multiply", a.multiply(b)),
    // rust: ("scale", a.scale(t)),
    // rust: ("normalize", a.normalize()),
    // rust: ("cross", a.cross(b)),
    // rust: ("lerp", a.lerp(b, t)),
    // rust: ("projected", a.projected_on(b)),
    // rust: ("reverse", a.reverse()),
    // rust: ("horizontal", a.horizontal()),
    // rust: ] {
    // rust: vector(&mut out, label, v)?;
}
    // rust: values(
    // rust: &mut out,
    // rust: "scalar",
    // rust: [
    // rust: a.dot(b),
    // rust: a.length_squared(),
    // rust: a.length(),
    // rust: a.horizontal_distance_squared(),
    // rust: a.horizontal_distance(),
    // rust: a.distance_squared(b),
    // rust: a.distance(b),
    // rust: ],
    // rust: )?;
    // rust: writeln!(
    // rust: out,
    // rust: "flags {} {} {} {}",
    // rust: u8::from(a == b),
    // rust: u8::from(a.is_finite()),
    // rust: u8::from(a.closer_than(b, t)),
    // rust: Direction::approximate_nearest(a) as u8
    // rust: )?;
    // rust: let order = Axis::step_order(a);
    // rust: writeln!(
    // rust: out,
    // rust: "order {} {} {}",
    // rust: order[0] as u8, order[1] as u8, order[2] as u8
    // rust: )?;
}
    // rust: "box" => {
    // rust: let a = input.aabb();
    // rust: let b = input.aabb();
    // rust: let start = input.vector();
    // rust: let end = input.vector();
    // rust: let amount = input.vector();
    // rust: let axis = Axis::ALL[input.integer() as usize];
    // rust: let value = input.number();
    // rust: for (label, b) in [
    // rust: ("bounds", a),
    // rust: ("move", a.move_by(amount)),
    // rust: ("inflate", a.inflate(amount)),
    // rust: ("deflate", a.deflate(amount)),
    // rust: ("contract", a.contract(amount)),
    // rust: ("expand", a.expand_towards(amount)),
    // rust: ("intersect", a.intersect(b)),
    // rust: ("union", a.union_bounds(b)),
    // rust: ("next", a.next_deflated()),
    // rust: ("set-min", a.with_min(axis, value)),
    // rust: ("set-max", a.with_max(axis, value)),
    // rust: ("of-size", Aabb::of_size(start, amount)),
    // rust: ("unit", Aabb::unit_cube(start)),
    // rust: ] {
    // rust: aabb(&mut out, label, b)?;
}
    // rust: vector(&mut out, "center", a.center())?;
    // rust: vector(&mut out, "bottom", a.bottom_center())?;
    // rust: vector(&mut out, "size", a.size())?;
    // rust: values(
    // rust: &mut out,
    // rust: "distance",
    // rust: [
    // rust: a.average_size(),
    // rust: a.distance_squared_to_point(start),
    // rust: a.distance_squared_to_box(b),
    // rust: ],
    // rust: )?;
    // rust: writeln!(
    // rust: out,
    // rust: "flags {} {} {} {}",
    // rust: u8::from(a.intersects(b)),
    // rust: u8::from(a.contains(start)),
    // rust: u8::from(a.has_nan()),
    // rust: u8::from(a.collided_along_vector(amount, &[b]))
    // rust: )?;
    // rust: point(&mut out, "clip", a.clip(start, end))?;
    // rust: hit(
    // rust: &mut out,
    // rust: Aabb::clip_boxes([a, b], start, end, BlockPos::default()),
    // rust: )?;
}
    // rust: "block-box" => {
    // rust: let a = input.pos();
    // rust: let b = input.pos();
    // rust: aabb(&mut out, "block", Aabb::block(a))?;
    // rust: aabb(&mut out, "encapsulate", Aabb::encapsulating_blocks(a, b))?;
}
    // rust: "grid" => {
    // rust: let cube = input.integer() != 0;
    // rust: let sizes = std::array::from_fn(|_| input.integer() as usize);
    // rust: let coords = std::array::from_fn(|i| {
    // rust: (0..=sizes[i]).map(|_| input.number()).collect::<Vec<_>>()
    // rust: });
    // rust: let occupied = input.word().bytes().map(|b| b == b'1').collect::<Vec<_>>();
    // rust: let occupied = if sizes.contains(&0) {
    // rust: &[][..]
    // rust: } else {
    // rust: &occupied[..]
}
    // rust: let shape = if cube {
    // rust: VoxelShape::from_cube(sizes, occupied)
    // rust: } else {
    // rust: VoxelShape::from_grid(coords, occupied)
}
    // rust: .expect("valid shape");
    // rust: writeln!(out, "shape {} {}", shapes.len(), shape.boxes().len())?;
    // rust: values(
    // rust: &mut out,
    // rust: "axis-extrema",
    // rust: Axis::ALL
    // rust: .map(|axis| shape.min(axis))
    // rust: .into_iter()
    // rust: .chain(Axis::ALL.map(|axis| shape.max(axis))),
    // rust: )?;
    // rust: if let Some(b) = shape.bounds() {
    // rust: aabb(&mut out, "shape-bounds", b)?;
    // rust: } else {
    // rust: writeln!(out, "shape-bounds none")?;
}
    // rust: for b in shape.boxes() {
    // rust: aabb(&mut out, "part", *b)?;
}
    // rust: shapes.push(shape);
}
    // rust: "query" => {
    // rust: let id = input.integer() as usize;
    // rust: let b = input.aabb();
    // rust: let start = input.vector();
    // rust: let end = input.vector();
    // rust: let p = input.vector();
    // rust: let block = input.pos();
    // rust: let axis = Axis::ALL[input.integer() as usize];
    // rust: let amount = input.number();
    // rust: let shape = &shapes[id];
    // rust: values(
    // rust: &mut out,
    // rust: "column",
    // rust: [shape.min_at(axis, p.x, p.y), shape.max_at(axis, p.x, p.y)],
    // rust: )?;
    // rust: values(&mut out, "collide", [shape.collide(axis, b, amount)])?;
    // rust: hit(&mut out, shape.clip(start, end, block))?;
    // rust: point(&mut out, "closest", shape.closest_point(p))?;
    // rust: writeln!(
    // rust: out,
    // rust: "index {} {} {}",
    // rust: shape.find_index(Axis::X, p.x),
    // rust: shape.find_index(Axis::Y, p.y),
    // rust: shape.find_index(Axis::Z, p.z)
    // rust: )?;
}
    // rust: "many" => {
    // rust: let b = input.aabb();
    // rust: let axis = Axis::ALL[input.integer() as usize];
    // rust: let amount = input.number();
    // rust: let count = input.integer();
    // rust: let selected = (0..count)
    // rust: .map(|_| &shapes[input.integer() as usize])
    // rust: .collect::<Vec<_>>();
    // rust: values(
    // rust: &mut out,
    // rust: "many",
    // rust: [VoxelShape::collide_all(axis, b, selected, amount)],
    // rust: )?;
}
    // rust: "floor-height" => {
    // rust: let shape = &shapes[input.integer() as usize];
    // rust: let below = &shapes[input.integer() as usize];
    // rust: let mut calls = 0;
    // rust: let height = block_floor_height(shape, || {
    // rust: calls += 1;
    // rust: below
    // rust: });
    // rust: values(&mut out, "floor-height", [height])?;
    // rust: writeln!(out, "below-calls {calls}")?;
}
    // rust: "block-iterate" => {
    // rust: let a = input.pos();
    // rust: let b = input.pos();
    // rust: let direction = input.vector();
    // rust: let limit = input.integer() as usize;
    // rust: positions(
    // rust: &mut out,
    // rust: "closed",
    // rust: BlockPos::between_closed(a, b).expect("bounded block box"),
    // rust: limit,
    // rust: )?;
    // rust: positions(
    // rust: &mut out,
    // rust: "direction",
    // rust: BlockPos::between_corners_in_direction(a, b, direction)
    // rust: .expect("bounded block box"),
    // rust: limit,
    // rust: )?;
}
    // rust: "box-iterate" => {
    // rust: let b = input.aabb();
    // rust: let direction = input.vector();
    // rust: let limit = input.integer() as usize;
    // rust: positions(
    // rust: &mut out,
    // rust: "closed",
    // rust: BlockPos::between_closed_box(b).expect("bounded block box"),
    // rust: limit,
    // rust: )?;
    // rust: positions(
    // rust: &mut out,
    // rust: "direction",
    // rust: BlockPos::between_box_corners_in_direction(b, direction)
    // rust: .expect("bounded block box"),
    // rust: limit,
    // rust: )?;
}
    // rust: "sweep" => {
    // rust: let start = input.vector();
    // rust: let end = input.vector();
    // rust: let b = input.aabb();
    // rust: let stop = input.integer() as usize;
    // rust: let mut visits = Vec::new();
    // rust: let completed = sweep_intersected_blocks(start, end, b, 1_000_000, |pos, step| {
    // rust: visits.push((pos, step));
    // rust: visits.len() != stop
    // rust: })
    // rust: .expect("bounded finite sweep");
    // rust: for (pos, step) in &visits {
    // rust: writeln!(out, "block-visit {} {} {} {step}", pos.x, pos.y, pos.z)?;
}
    // rust: writeln!(out, "sweep {} {}", u8::from(completed), visits.len())?;
}
    // rust: "step-motion" => {
    // rust: let b = input.aabb();
    // rust: let movement = input.vector();
    // rust: let max_step = input.number() as f32;
    // rust: let grounded = input.integer() != 0;
    // rust: let mut read_shapes = || {
    // rust: let count = input.integer();
    // rust: (0..count)
    // rust: .map(|_| &shapes[input.integer() as usize])
    // rust: .collect::<Vec<_>>()
}
    // rust: let entities = read_shapes();
    // rust: let initial = read_shapes();
    // rust: let stepping = read_shapes();
    // rust: let border = input.integer();
    // rust: aabb(
    // rust: &mut out,
    // rust: "entity-query",
    // rust: entity_collision_bounds(movement, b, max_step),
    // rust: )?;
    // rust: let mut queries = Vec::new();
    // rust: let result = resolve_step_movement(movement, b, max_step, grounded, |query| {
    // rust: let blocks = if queries.is_empty() {
    // rust: &initial
    // rust: } else {
    // rust: &stepping
}
    // rust: queries.push(query);
    // rust: let mut selected = entities.clone();
    // rust: if border >= 0 {
    // rust: selected.push(&shapes[border as usize]);
}
    // rust: selected.extend(blocks.iter().copied());
    // rust: selected
    // rust: });
    // rust: for query in &queries {
    // rust: aabb(&mut out, "block-query", *query)?;
}
    // rust: vector(&mut out, "step-motion", result)?;
    // rust: writeln!(out, "block-queries {}", queries.len())?;
}
    // rust: "motion" => {
    // rust: let b = input.aabb();
    // rust: let movement = input.vector();
    // rust: let max_step = input.number() as f32;
    // rust: let current_y = input.number() as f32;
    // rust: let count = input.integer();
    // rust: let selected = (0..count)
    // rust: .map(|_| &shapes[input.integer() as usize])
    // rust: .collect::<Vec<_>>();
    // rust: vector(
    // rust: &mut out,
    // rust: "motion",
    // rust: resolve_shape_movement(movement, b, &selected),
    // rust: )?;
    // rust: let candidates = candidate_step_heights(b, &selected, max_step, current_y);
    // rust: write!(out, "steps {}", candidates.len())?;
    // rust: for value in candidates {
    // rust: write!(
    // rust: out,
    // rust: " {:08x}",
    // rust: if value.is_nan() {
    // rust: 0x7fc0_0000
    // rust: } else {
    // rust: value.to_bits()
}
    // rust: )?;
}
    // rust: writeln!(out)?;
}
    // rust: _ => panic!("unknown command {operation}"),
}
    // rust: assert!(input.0.next().is_none(), "trailing input");
}
    // rust: out.flush()
}
