//! Transpiled from Horizon Rust crate
//! Module: horizon-core_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Immutable density definitions and the first integrated compiler operations.
//! Seeded noise registration is supported; serialized codecs and remaining
//! function kinds are pending.
// use super::*;
// use std::collections::HashMap;
    // rust: mod compiler;
    // rust: mod seeded;
    // rust: mod tests;
    // rust: pub use compiler::DensityCompiler;

pub const FunctionId = struct {};
pub const NoiseId = struct {};
pub const HolderId = struct {};

pub const GraphUnary = enum {
    Abs,
    Square,
    Cube,
    HalfNegative,
    QuarterNegative,
    Reciprocal,
    Negate,
    Squeeze,
    Sign,
    Log,
    Sqrt,
};
    // rust: impl GraphUnary {
pub fn operation(self: *Self) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Abs => UnaryOp::Abs,
    // rust: Self::Square => UnaryOp::Square,
    // rust: Self::Cube => UnaryOp::Cube,
    // rust: Self::HalfNegative => UnaryOp::LeakyRelu(0.5),
    // rust: Self::QuarterNegative => UnaryOp::LeakyRelu(0.25),
    // rust: Self::Reciprocal => UnaryOp::Reciprocal,
    // rust: Self::Negate => UnaryOp::Negate,
    // rust: Self::Squeeze => UnaryOp::Squeeze,
    // rust: Self::Sign => UnaryOp::Sign,
    // rust: Self::Log => UnaryOp::Log,
    // rust: Self::Sqrt => UnaryOp::Sqrt,
}
}
}
pub const GraphBinary = enum {
    Add,
    Subtract,
    Multiply,
    Divide,
    Minimum,
    Maximum,
};

/// References belong to the graph that creates them. New nodes may refer only
/// to existing immutable nodes, keeping the definition graph acyclic.
pub const GraphNode = enum {
    Constant(f32),
    Spline(CubicSpline<FunctionId>),
    Noise {,
    noise: NoiseId,
    xz_scale: f64,
    y_scale: f64,
    shift_x: FunctionId,
    shift_y: FunctionId,
    shift_z: FunctionId,
    // rust: },
    OffsetNoise {,
    noise: NoiseId,
    kind: ShiftNoiseKind,
    // rust: },
    BlendedNoise(BlendedNoise),
    EndIslands,
    WorldField(WorldField),
    BlendDensity(FunctionId),
    /// A direct holder compares by value; a registry holder by identity.
    Reference {,
    input: FunctionId,
    holder: Option<HolderId>,
    // rust: },
    Gradient {,
    axis: Axis,
    tiling: TilingMode,
    from: i32,
    to: i32,
    low: f32,
    high: f32,
    // rust: },
    Unary {,
    kind: GraphUnary,
    input: FunctionId,
    // rust: },
    Binary {,
    kind: GraphBinary,
    left: FunctionId,
    right: FunctionId,
    // rust: },
    Round {,
    mode: RoundMode,
    input: FunctionId,
    multiple: FunctionId,
    // rust: },
    Power {,
    base: FunctionId,
    exponent: FunctionId,
    // rust: },
    Clamp {,
    input: FunctionId,
    min: f32,
    max: f32,
    // rust: },
    Choice {,
    input: FunctionId,
    min: f32,
    max: f32,
    inside: FunctionId,
    outside: FunctionId,
    // rust: },
    Lerp {,
    alpha: FunctionId,
    first: FunctionId,
    second: FunctionId,
    // rust: },
    Slice {,
    axis: Axis,
    coordinate: i32,
    input: FunctionId,
    // rust: },
    Cache(FunctionId),
    Interpolated {,
    input: FunctionId,
    xz: i32,
    y: i32,
    // rust: },
    Surface {,
    density: FunctionId,
    upper: FunctionId,
    lower: i32,
    height: i32,
    // rust: },
    IntervalSelect {,
    input: FunctionId,
    thresholds: Arc<[f32]>,
    branches: Vec<FunctionId>,
    // rust: },
    DistanceToPoint {,
    point: [i32; 3],
    metric: DistanceMetric,
    // rust: },
};
    // rust: impl GraphNode {
pub fn children_mut(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Spline(spline) => spline.coordinates_mut(),
    // rust: Self::Constant(_)
    // rust: | Self::Gradient { .. }
    // rust: | Self::DistanceToPoint { .. }
    // rust: | Self::OffsetNoise { .. }
    // rust: | Self::BlendedNoise(_)
    // rust: | Self::EndIslands
    // rust: | Self::WorldField(_) => vec![],
    // rust: Self::Noise {
    // rust: shift_x,
    // rust: shift_y,
    // rust: shift_z,
    // rust: ..
    // rust: } => vec![shift_x, shift_y, shift_z],
    // rust: Self::Reference { input, .. }
    // rust: | Self::Unary { input, .. }
    // rust: | Self::Clamp { input, .. }
    // rust: | Self::Slice { input, .. }
    // rust: | Self::Cache(input)
    // rust: | Self::BlendDensity(input)
    // rust: | Self::Interpolated { input, .. } => vec![input],
    // rust: Self::Binary { left, right, .. } => vec![left, right],
    // rust: Self::Round {
    // rust: input, multiple, ..
    // rust: } => vec![input, multiple],
    // rust: Self::Power { base, exponent } => vec![base, exponent],
    // rust: Self::Choice {
    // rust: input,
    // rust: inside,
    // rust: outside,
    // rust: ..
    // rust: } => vec![input, inside, outside],
    // rust: Self::Lerp {
    // rust: alpha,
    // rust: first,
    // rust: second,
    // rust: } => vec![alpha, first, second],
    // rust: Self::Surface { density, upper, .. } => vec![density, upper],
    // rust: Self::IntervalSelect {
    // rust: input, branches, ..
    // rust: } => std::iter::once(input).chain(branches.iter_mut()).collect(),
}
}
pub fn key(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = |v: f32| u64::from(if v.is_nan() { 0x7fc0_0000 } else { v.to_bits() });
    // rust: let i = |v: i32| u64::from(v as u32);
    // rust: let d = |v: f64| {
    // rust: if v.is_nan() {
    // rust: 0x7ff8_0000_0000_0000
    // rust: } else {
    // rust: v.to_bits()
}
}
    // rust: let id = |v: FunctionId| v.0 as u64;
    // rust: match *self {
    // rust: Self::Reference { input, holder } => match holder {
    // rust: Some(holder) => vec![22, 1, holder.0 as u64],
    // rust: None => vec![22, 0, id(input)],
    // rust: },
    // rust: Self::EndIslands => vec![17],
    // rust: Self::WorldField(field) => vec![20, field as u64],
    // rust: Self::BlendDensity(input) => vec![21, id(input)],
    // rust: Self::Power { base, exponent } => vec![19, id(base), id(exponent)],
    // rust: Self::Round {
    // rust: mode,
    // rust: input,
    // rust: multiple,
    // rust: } => vec![18, mode as u64, id(input), id(multiple)],
    // rust: Self::Noise {
    // rust: noise,
    // rust: xz_scale,
    // rust: y_scale,
    // rust: shift_x,
    // rust: shift_y,
    // rust: shift_z,
    // rust: } => vec![
    // rust: 14,
    // rust: noise.0 as u64,
    // rust: d(xz_scale),
    // rust: d(y_scale),
    // rust: id(shift_x),
    // rust: id(shift_y),
    // rust: id(shift_z),
    // rust: ],
    // rust: Self::OffsetNoise { noise, kind } => vec![15, noise.0 as u64, kind as u64],
    // rust: Self::BlendedNoise(v) => vec![
    // rust: 16,
    // rust: d(v.xz_scale),
    // rust: d(v.y_scale),
    // rust: d(v.xz_factor),
    // rust: d(v.y_factor),
    // rust: d(v.smear_scale_multiplier),
    // rust: ],
    // rust: Self::Spline(ref spline) => {
pub fn append(spline: *CubicSpline<FunctionId>, key: *mut std.ArrayList(u64)) void {
}
    // rust: let bits =
    // rust: |v: f32| u64::from(if v.is_nan() { 0x7fc0_0000 } else { v.to_bits() });
    // rust: match spline {
    // rust: CubicSpline::Constant(value) => key.extend([0, bits(*value)]),
    // rust: CubicSpline::Multipoint(node) => {
    // rust: key.extend([1, node.coordinate.0 as u64, node.points.len() as u64]);
    // rust: for point in &node.points {
    // rust: key.extend([bits(point.location), bits(point.derivative)]);
    // rust: append(&point.value, key);
}
}
}
}
    // rust: let mut key = vec![13];
    // rust: append(spline, &mut key);
    // rust: key
}
    // rust: Self::Constant(v) => vec![0, f(v)],
    // rust: Self::Gradient {
    // rust: axis,
    // rust: tiling,
    // rust: from,
    // rust: to,
    // rust: low,
    // rust: high,
    // rust: } => vec![
    // rust: 1,
    // rust: axis as u64,
    // rust: tiling as u64,
    // rust: i(from),
    // rust: i(to),
    // rust: f(low),
    // rust: f(high),
    // rust: ],
    // rust: Self::Unary { kind, input } => vec![2, kind as u64, id(input)],
    // rust: Self::Binary { kind, left, right } => vec![3, kind as u64, id(left), id(right)],
    // rust: Self::Clamp { input, min, max } => vec![4, id(input), f(min), f(max)],
    // rust: Self::Choice {
    // rust: input,
    // rust: min,
    // rust: max,
    // rust: inside,
    // rust: outside,
    // rust: } => vec![5, id(input), f(min), f(max), id(inside), id(outside)],
    // rust: Self::Lerp {
    // rust: alpha,
    // rust: first,
    // rust: second,
    // rust: } => vec![6, id(alpha), id(first), id(second)],
    // rust: Self::Slice {
    // rust: axis,
    // rust: coordinate,
    // rust: input,
    // rust: } => vec![7, axis as u64, i(coordinate), id(input)],
    // rust: Self::Cache(input) => vec![8, id(input)],
    // rust: Self::Interpolated { input, xz, y } => vec![9, id(input), i(xz), i(y)],
    // rust: Self::Surface {
    // rust: density,
    // rust: upper,
    // rust: lower,
    // rust: height,
    // rust: } => vec![10, id(density), id(upper), i(lower), i(height)],
    // rust: Self::IntervalSelect {
    // rust: input,
    // rust: ref thresholds,
    // rust: ref branches,
    // rust: } => {
    // rust: let mut key = vec![11, id(input), thresholds.len() as u64];
    // rust: key.push(if thresholds.iter().any(|v| v.is_nan()) {
    // rust: Arc::as_ptr(thresholds) as *const f32 as usize as u64
    // rust: } else {
    // rust: 0
    // rust: });
    // rust: key.extend(thresholds.iter().map(|v| if *v == 0.0 { 0 } else { f(*v) }));
    // rust: key.extend(branches.iter().copied().map(id));
    // rust: key
}
    // rust: Self::DistanceToPoint { point, metric } => {
    // rust: vec![12, i(point[0]), i(point[1]), i(point[2]), metric as u64]
}
}
}
}
pub const CompileError = enum {
    UnknownFunction,
    NestingTooDeep,
    InvalidAxes,
    UnpreparedCache,
    InvalidIntervals,
    UnknownNoise,
    DuplicateNoise,
    DuplicateFunction,
    UnknownHolder,
    MissingSeededContext,
    PoisonedNoiseCache,
    Noise(crate::noise::NoiseBuildError),
    Spline(SplineError),
    Range(IntervalError),
    Sample(SampleError),
};
    // rust: impl From<IntervalError> for CompileError {
pub fn from(e: IntervalError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Range(e)
}
}
    // rust: impl From<SampleError> for CompileError {
pub fn from(e: SampleError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Sample(e)
}
}
    // rust: impl From<SplineError> for CompileError {
pub fn from(e: SplineError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Spline(e)
}
}
    // rust: impl From<crate::noise::NoiseBuildError> for CompileError {
pub fn from(e: crate::noise::NoiseBuildError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Noise(e)
}
}
    // rust: impl std::fmt::Display for CompileError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "density graph compilation failed: {self:?}")
}
}
    // rust: impl std::error::Error for CompileError {}

pub const Definition = enum {
    Node(GraphNode),
    Bound {,
    sampler: Arc<dyn DensitySampler>,
    range: Interval,
    axes: u8,
    // rust: },
};
pub const Entry = struct {
    definition: Definition,
    depth: usize,
    equality_id: FunctionId,
    hash_variant: bool,
};
pub const DensityGraph = struct {
    entries: std.ArrayList(Entry),
    interned: HashMap<(std.ArrayList(u64),
    equal: HashMap<std.ArrayList(u64),
    noises: std.ArrayList(seeded::NoiseEntry),
    noise_names: HashMap<[]const u8,
    holders: std.ArrayList(FunctionId),
    function_names: HashMap<[]const u8,
};
    // rust: impl DensityGraph {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::default()
}
pub fn insert(self: *Self, node: GraphNode) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let GraphNode::Reference {
    // rust: input,
    // rust: holder: Some(holder),
    // rust: } = node
    // rust: {
    // rust: if self.holders.get(holder.0) != Some(&input) {
    // rust: return Err(CompileError::UnknownHolder);
}
}
    // rust: if let GraphNode::Noise { noise, .. } | GraphNode::OffsetNoise { noise, .. } = node {
    // rust: self.noise_entry(noise)?;
}
    // rust: if let GraphNode::IntervalSelect {
    // rust: thresholds,
    // rust: branches,
    // rust: ..
    // rust: } = &node
    // rust: {
    // rust: if branches.len() != thresholds.len().saturating_add(1) || branches.len() > 256 {
    // rust: return Err(CompileError::InvalidIntervals);
}
}
        // Fastutil threshold lists compare zeros numerically but hash their
        // signed bits. Among equal definitions, the only possible hash delta
        // is 0x80000000. Java record/list hashes use odd (31) multipliers, so
        // these deltas XOR through children and cancel in pairs. Keep equality
        // classes separate from this hash variant to reproduce Java map reuse,
        // including equal parents whose differing child hashes cancel.
    // rust: let mut hash_variant = match &node {
    // rust: GraphNode::IntervalSelect { thresholds, .. } => {
    // rust: thresholds
    // rust: .iter()
    // rust: .filter(|v| v.to_bits() == 0x8000_0000)
    // rust: .count()
    // rust: % 2
    // rust: != 0
}
    // rust: _ => false,
}
    // rust: let mut canonical = node.clone();
    // rust: let mut depth = if let GraphNode::Spline(spline) = &node {
    // rust: fn spline_depth(
    // rust: spline: &CubicSpline<FunctionId>,
    // rust: graph: &DensityGraph,
    // rust: ) -> Result<usize, CompileError> {
    // rust: Ok(match spline {
    // rust: CubicSpline::Constant(_) => 0,
    // rust: CubicSpline::Multipoint(node) => {
    // rust: let mut depth = graph.entry(node.coordinate)?.depth;
    // rust: for point in &node.points {
    // rust: depth = depth.max(spline_depth(&point.value, graph)?);
}
    // rust: depth + 1
}
    // rust: })
}
    // rust: spline_depth(spline, self)? + 1
    // rust: } else {
    // rust: 1
}
    // rust: for child in canonical.children_mut() {
    // rust: let entry = self.entry(*child)?;
    // rust: depth = depth.max(entry.depth + 1);
            // Registry references hash their holder identity, not its value.
    // rust: if !matches!(
    // rust: node,
    // rust: GraphNode::Reference {
    // rust: holder: Some(_),
    // rust: ..
}
    // rust: ) {
    // rust: hash_variant ^= entry.hash_variant;
}
    // rust: *child = entry.equality_id;
}
    // rust: let key = canonical.key();
    // rust: if let Some(id) = self.interned.get(&(key.clone(), hash_variant)) {
    // rust: return Ok(*id);
}
    // rust: if depth > 256 {
    // rust: return Err(CompileError::NestingTooDeep);
}
    // rust: let id = FunctionId(self.entries.len());
    // rust: let equality_id = *self.equal.entry(key.clone()).or_insert(id);
    // rust: self.entries.push(Entry {
    // rust: definition: Definition::Node(node),
    // rust: depth,
    // rust: equality_id,
    // rust: hash_variant,
    // rust: });
    // rust: self.interned.insert((key, hash_variant), id);
    // rust: Ok(id)
}
    /// Bind a precompiled input with its declared range and axis dependency
    /// mask (X=1, Y=2, Z=4). Each binding has distinct function identity.
    // rust: pub fn bind(
    // rust: &mut self,
    // rust: sampler: Arc<dyn DensitySampler>,
    // rust: range: Interval,
    // rust: axes: u8,
    // rust: ) -> Result<FunctionId, CompileError> {
    // rust: if axes & !7 != 0 {
    // rust: return Err(CompileError::InvalidAxes);
}
    // rust: let id = FunctionId(self.entries.len());
    // rust: self.entries.push(Entry {
    // rust: definition: Definition::Bound {
    // rust: sampler,
    // rust: range,
    // rust: axes,
    // rust: },
    // rust: depth: 1,
    // rust: equality_id: id,
    // rust: hash_variant: false,
    // rust: });
    // rust: Ok(id)
}
pub fn entry(self: *Self, id: FunctionId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.get(id.0).ok_or(CompileError::UnknownFunction)
}
    /// Register a noise under its canonical namespaced registry identifier.
    /// Definitions and names are immutable after registration.
    // rust: pub fn register_noise(
    // rust: &mut self,
    // rust: name: String,
    // rust: definition: crate::noise::NormalNoise,
    // rust: ) -> Result<NoiseId, CompileError> {
    // rust: if self.noise_names.contains_key(&name) {
    // rust: return Err(CompileError::DuplicateNoise);
}
    // rust: let id = NoiseId(self.noises.len());
    // rust: self.noise_names.insert(name.clone(), id);
    // rust: self.noises.push(seeded::NoiseEntry { name, definition });
    // rust: Ok(id)
}
    /// Register an immutable named density value and return its holder wrapper.
    /// Names must already be canonical namespaced registry identifiers.
    // rust: pub fn register_function(
    // rust: &mut self,
    // rust: name: String,
    // rust: input: FunctionId,
    // rust: ) -> Result<FunctionId, CompileError> {
    // rust: if self.function_names.contains_key(&name) {
    // rust: return Err(CompileError::DuplicateFunction);
}
    // rust: self.entry(input)?;
    // rust: let holder = HolderId(self.holders.len());
    // rust: self.holders.push(input);
    // rust: let result = self.insert(GraphNode::Reference {
    // rust: input,
    // rust: holder: Some(holder),
    // rust: });
    // rust: match result {
    // rust: Ok(id) => {
    // rust: self.function_names.insert(name, id);
    // rust: Ok(id)
}
    // rust: Err(error) => {
    // rust: self.holders.pop();
    // rust: Err(error)
}
}
}
pub fn function(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.function_names.get(name).copied()
}
pub fn noise_entry(self: *Self, id: NoiseId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.noises.get(id.0).ok_or(CompileError::UnknownNoise)
}
    /// Vanilla definition equality, separate from interned identity. Interval
    /// threshold lists can compare equal despite having different Java hashes.
pub fn java_equals(self: *Self, left: FunctionId, right: FunctionId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.entry(left)?.equality_id == self.entry(right)?.equality_id)
}
pub fn domain_axes(self: *Self, id: FunctionId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut node = match &self.entry(id)?.definition {
    // rust: Definition::Bound { axes, .. } => return Ok(*axes),
    // rust: Definition::Node(node) => node.clone(),
}
    // rust: let mask = match node {
    // rust: GraphNode::EndIslands => return Ok(5),
    // rust: GraphNode::WorldField(field) => return Ok(field.domain_axes()),
    // rust: GraphNode::OffsetNoise { kind, .. } => {
    // rust: return Ok(if kind == ShiftNoiseKind::Shift { 7 } else { 5 });
}
    // rust: GraphNode::BlendedNoise(_) => return Ok(7),
    // rust: GraphNode::Noise {
    // rust: xz_scale, y_scale, ..
    // rust: } => {
    // rust: let mut axes = if xz_scale == 0.0 { 0 } else { 5 };
    // rust: if y_scale != 0.0 {
    // rust: axes |= 2;
}
    // rust: for child in node.children_mut() {
    // rust: axes |= self.domain_axes(*child)?;
}
    // rust: return Ok(axes);
}
    // rust: GraphNode::Constant(_) => return Ok(0),
    // rust: GraphNode::Gradient { axis, .. } => return Ok(1 << axis as u8),
    // rust: GraphNode::DistanceToPoint { .. } => return Ok(7),
    // rust: GraphNode::Slice { axis, .. } => !(1 << axis as u8),
    // rust: GraphNode::Surface { .. } => !2,
    // rust: _ => 7,
}
    // rust: let mut axes = 0;
    // rust: for child in node.children_mut() {
    // rust: axes |= self.domain_axes(*child)?;
}
    // rust: Ok(axes & mask)
}
pub fn range(self: *Self, id: FunctionId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let node = match &self.entry(id)?.definition {
    // rust: Definition::Bound { range, .. } => return Ok(*range),
    // rust: Definition::Node(node) => node,
}
    // rust: Ok(match *node {
    // rust: GraphNode::EndIslands => Interval::new(-0.84375, 0.5625)?,
    // rust: GraphNode::WorldField(field) => field.range(),
    // rust: GraphNode::Noise { noise, .. } => {
    // rust: let [min, max] = self.noise_entry(noise)?.definition.range();
    // rust: Interval::new(min, max)?
}
    // rust: GraphNode::OffsetNoise { noise, .. } => {
    // rust: let [min, max] = self.noise_entry(noise)?.definition.range();
    // rust: Interval::new(min, max)?.multiply_range(Interval::exact(4.0)?)
}
    // rust: GraphNode::BlendedNoise(definition) => definition.range()?,
    // rust: GraphNode::Spline(ref spline) => spline.try_range(&mut |id| self.range(id))?,
    // rust: GraphNode::Constant(v) => Interval::exact(v)?,
    // rust: GraphNode::Gradient { low, high, .. } => Interval::encapsulating_values(low, high),
    // rust: GraphNode::DistanceToPoint { .. } => Interval::new(0.0, f32::INFINITY)?,
    // rust: GraphNode::IntervalSelect { ref branches, .. } => {
    // rust: let ranges = branches
    // rust: .iter()
    // rust: .map(|id| self.range(*id))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: Interval::encapsulating(&ranges)?
}
    // rust: GraphNode::Unary { kind, input } => {
    // rust: let range = self.range(input)?;
    // rust: match kind {
    // rust: GraphUnary::Abs => range.abs(),
    // rust: GraphUnary::Square => range.square(),
    // rust: GraphUnary::Reciprocal => range.reciprocal(),
    // rust: GraphUnary::Sign => range.sign(),
    // rust: GraphUnary::Negate => Interval::exact(0.0)?.subtract_range(range),
    // rust: GraphUnary::Log => range.log()?,
    // rust: GraphUnary::Sqrt => range.power(Interval::exact(0.5)?),
    // rust: _ => range.map_monotonic(|v| kind.operation().apply(v, false))?,
}
}
    // rust: GraphNode::Binary { kind, left, right } => {
    // rust: let left = self.range(left)?;
    // rust: let right = self.range(right)?;
    // rust: match kind {
    // rust: GraphBinary::Add => left.add_range(right),
    // rust: GraphBinary::Subtract => left.subtract_range(right),
    // rust: GraphBinary::Multiply => left.multiply_range(right),
    // rust: GraphBinary::Divide => left.divide_range(right),
    // rust: GraphBinary::Minimum => left.minimum(right),
    // rust: GraphBinary::Maximum => left.maximum(right),
}
}
    // rust: GraphNode::Round {
    // rust: mode,
    // rust: input,
    // rust: multiple,
    // rust: } => {
    // rust: let multiple = self.range(multiple)?;
    // rust: self.range(input)?
    // rust: .divide_range(multiple)
    // rust: .map_monotonic(|v| mode.integer(v))?
    // rust: .multiply_range(multiple)
}
    // rust: GraphNode::Power { base, exponent } => self.range(base)?.power(self.range(exponent)?),
    // rust: GraphNode::Clamp { input, min, max } => self.range(input)?.clamp(min, max)?,
    // rust: GraphNode::Choice {
    // rust: inside, outside, ..
    // rust: } => Interval::encapsulating(&[self.range(inside)?, self.range(outside)?])?,
    // rust: GraphNode::Lerp {
    // rust: alpha,
    // rust: first,
    // rust: second,
    // rust: } => self
    // rust: .range(alpha)?
    // rust: .lerp_ranges(self.range(first)?, self.range(second)?),
    // rust: GraphNode::Slice { input, .. }
    // rust: | GraphNode::Cache(input)
    // rust: | GraphNode::BlendDensity(input)
    // rust: | GraphNode::Reference { input, .. }
    // rust: | GraphNode::Interpolated { input, .. } => self.range(input)?,
    // rust: GraphNode::Surface { upper, lower, .. } => Interval::new(
    // rust: lower as f32,
    // rust: super::arithmetic::java_max(lower as f32, self.range(upper)?.max()),
    // rust: )?,
    // rust: })
}
    /// Inclusive `y` bounds outside which `id` is never positive, at any x
    /// and z, read from its shape: through registry references, a range
    /// choice whose input is a clamped `y` gradient and whose out-of-range
    /// branch is a constant `<= 0` (as vanilla's ore vein densities are).
    /// A side the gradient stays in range on is unbounded (`i32::MIN` or
    /// `i32::MAX`); `low > high` when the input is never in range. `None` for
    /// any other shape.
pub fn positive_y_bounds(self: *Self, id: FunctionId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(&GraphNode::Choice {
    // rust: input,
    // rust: min,
    // rust: max,
    // rust: outside,
    // rust: ..
    // rust: }) = self.resolve_references(id)?
    // rust: else {
    // rust: return Ok(None);
}
    // rust: if !matches!(self.resolve_references(outside)?, Some(&GraphNode::Constant(value)) if value <= 0.0)
    // rust: {
    // rust: return Ok(None);
}
    // rust: let Some(&GraphNode::Gradient {
    // rust: axis: Axis::Y,
    // rust: tiling: TilingMode::ClampToEdge,
    // rust: from,
    // rust: to,
    // rust: low,
    // rust: high,
    // rust: }) = self.resolve_references(input)?
    // rust: else {
    // rust: return Ok(None);
}
    // rust: let (first, last) = (from.min(to), from.max(to));
    // rust: if i64::from(last) - i64::from(first) > 1 << 16 {
    // rust: return Ok(None);
}
        // The compiled sampler's own arithmetic, at every y it varies over;
        // beyond them the clamped value is that of the nearer end.
    // rust: let gradient = GradientSampler::new(Axis::Y, TilingMode::ClampToEdge, from, to, low, high);
    // rust: let inside = |y| -> Result<bool, CompileError> {
    // rust: let value = gradient.compute(y)?;
    // rust: Ok(value >= min && value < max)
}
    // rust: let mut bounds = [i32::MAX, i32::MIN];
    // rust: for y in first..=last {
    // rust: if inside(y)? {
    // rust: bounds[0] = bounds[0].min(y);
    // rust: bounds[1] = y;
}
}
    // rust: if inside(first)? {
    // rust: bounds[0] = i32::MIN;
}
    // rust: if inside(last)? {
    // rust: bounds[1] = i32::MAX;
}
    // rust: Ok(Some(bounds))
}
    /// The node `id` names, past registry and direct references; `None` for
    /// a bound sampler.
pub fn resolve_references(self: *Self, mut id: FunctionId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: loop {
    // rust: match &self.entry(id)?.definition {
    // rust: Definition::Node(GraphNode::Reference { input, .. }) => id = *input,
    // rust: Definition::Node(node) => return Ok(Some(node)),
    // rust: Definition::Bound { .. } => return Ok(None),
}
}
}
}
