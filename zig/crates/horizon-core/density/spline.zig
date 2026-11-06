//! Transpiled from Horizon Rust crate
//! Module: horizon-core_spline
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use std::collections::HashMap;

pub const SplineError = enum {
    EmptyPoints,
    NestingTooDeep,
    MissingCoordinate,
    NanConstant,
};
    // rust: impl std::fmt::Display for SplineError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(match self {
    // rust: Self::NanConstant => "a compiled constant spline cannot be NaN",
    // rust: Self::EmptyPoints => "a multipoint spline requires at least one point",
    // rust: Self::NestingTooDeep => "spline nesting exceeds 256 levels",
    // rust: Self::MissingCoordinate => "spline coordinate has no density sampler",
    // rust: })
}
}
    // rust: impl std::error::Error for SplineError {}

pub const SplinePoint = struct {
    location: f32,
    value: CubicSpline<C>,
    derivative: f32,
};
pub const MultipointSpline = struct {
    // rust: pub(super) coordinate: C,
    // rust: pub(super) points: Vec<SplinePoint<C>>,
    // rust: pub(super) depth: usize,
};
/// An immutable spline definition. Coordinate indices are resolved against a
/// sampler table at compilation. Point order is retained, including NaNs and
/// equal locations; codec ordering constraints belong to serialized definitions.
pub const CubicSpline = enum {
    Constant(f32),
    Multipoint(Arc<MultipointSpline<C>>),
};
    // rust: impl<C: Copy> CubicSpline<C> {
pub fn multipoint(coordinate: C, points: std.ArrayList(SplinePoint<C)>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let depth = points
    // rust: .iter()
    // rust: .map(|p| match &p.value {
    // rust: Self::Constant(_) => 0,
    // rust: Self::Multipoint(node) => node.depth,
    // rust: })
    // rust: .max()
    // rust: .ok_or(SplineError::EmptyPoints)?
    // rust: + 1;
    // rust: if depth > 256 {
    // rust: return Err(SplineError::NestingTooDeep);
}
    // rust: Ok(Self::Multipoint(Arc::new(MultipointSpline {
    // rust: coordinate,
    // rust: points,
    // rust: depth,
    // rust: })))
}
    // rust: fn sample(
    // rust: &self,
    // rust: coordinate: &mut impl FnMut(C) -> Result<f32, SampleError>,
    // rust: ) -> Result<f32, SampleError> {
    // rust: let node = match self {
    // rust: Self::Constant(value) => return Ok(*value),
    // rust: Self::Multipoint(node) => node,
}
    // rust: let input = coordinate(node.coordinate)?;
        // Vanilla binarySearch finds the first strictly greater location. Keep
        // this search even for manually supplied unsorted or NaN locations.
    // rust: let mut first = 0;
    // rust: let mut remaining = node.points.len();
    // rust: while remaining != 0 {
    // rust: let half = remaining / 2;
    // rust: let middle = first + half;
    // rust: if input < node.points[middle].location {
    // rust: remaining = half;
    // rust: } else {
    // rust: first = middle + 1;
    // rust: remaining -= half + 1;
}
}
    // rust: if first == 0 || first == node.points.len() {
    // rust: let endpoint = if first == 0 { 0 } else { first - 1 };
    // rust: let point = &node.points[endpoint];
    // rust: let value = point.value.sample(coordinate)?;
    // rust: return Ok(if point.derivative == 0.0 {
    // rust: value
    // rust: } else {
    // rust: value + point.derivative * (input - point.location)
    // rust: });
}
    // rust: let left = &node.points[first - 1];
    // rust: let right = &node.points[first];
    // rust: let width = right.location - left.location;
    // rust: let alpha = (input - left.location) / width;
    // rust: let left_value = left.value.sample(coordinate)?;
    // rust: let right_value = right.value.sample(coordinate)?;
    // rust: let left_correction = left.derivative * width - (right_value - left_value);
    // rust: let right_correction = -right.derivative * width + (right_value - left_value);
    // rust: let linear = left_value + alpha * (right_value - left_value);
    // rust: let correction = left_correction + alpha * (right_correction - left_correction);
    // rust: Ok(linear + (alpha * (1.0 - alpha)) * correction)
}
    /// Vanilla's conservative range analysis, with coordinate ranges supplied
    /// by the enclosing graph. Child ranges are evaluated in reference order.
    // rust: pub fn range(
    // rust: &self,
    // rust: coordinate: &mut impl FnMut(C) -> Interval,
    // rust: ) -> Result<Interval, IntervalError> {
    // rust: self.try_range(&mut |id| Ok(coordinate(id)))
}
    /// Fallible coordinate range lookup, preserving early returns and error order.
    // rust: pub fn try_range<E: From<IntervalError>>(
    // rust: &self,
    // rust: coordinate: &mut impl FnMut(C) -> Result<Interval, E>,
    // rust: ) -> Result<Interval, E> {
//         use super::arithmetic::{java_max, java_min};
    // rust: let node = match self {
    // rust: Self::Constant(value) => return Interval::exact(*value).map_err(E::from),
    // rust: Self::Multipoint(node) => node,
}
    // rust: let input = coordinate(node.coordinate)?;
    // rust: if input.is_nai() {
    // rust: return Ok(input);
}
    // rust: let mut minimum = f32::INFINITY;
    // rust: let mut maximum = f32::NEG_INFINITY;
    // rust: let first = &node.points[0];
    // rust: let last = node.points.last().unwrap();
    // rust: let extend = |point: &SplinePoint<C>, input: f32, value: f32| {
    // rust: if point.derivative == 0.0 {
    // rust: value
    // rust: } else {
    // rust: value + point.derivative * (input - point.location)
}
}
    // rust: if input.min() < first.location {
    // rust: let value = first.value.try_range(coordinate)?;
    // rust: let low = extend(first, input.min(), value.min());
    // rust: let high = extend(first, input.min(), value.max());
    // rust: minimum = java_min(minimum, java_min(low, high));
    // rust: maximum = java_max(maximum, java_max(low, high));
}
    // rust: if input.max() > last.location {
    // rust: let value = last.value.try_range(coordinate)?;
    // rust: let low = extend(last, input.max(), value.min());
    // rust: let high = extend(last, input.max(), value.max());
    // rust: minimum = java_min(minimum, java_min(low, high));
    // rust: maximum = java_max(maximum, java_max(low, high));
}
    // rust: let ranges = node
    // rust: .points
    // rust: .iter()
    // rust: .map(|point| point.value.try_range(coordinate))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: for range in &ranges {
    // rust: minimum = java_min(minimum, range.min());
    // rust: maximum = java_max(maximum, range.max());
}
    // rust: for (points, ranges) in node.points.windows(2).zip(ranges.windows(2)) {
    // rust: let width = points[1].location - points[0].location;
    // rust: let left = ranges[0];
    // rust: let right = ranges[1];
    // rust: let derivative_left = points[0].derivative;
    // rust: let derivative_right = points[1].derivative;
    // rust: if derivative_left == 0.0 && derivative_right == 0.0 {
    // rust: continue;
}
    // rust: let tangent_left = derivative_left * width;
    // rust: let tangent_right = derivative_right * width;
    // rust: let value_min = java_min(left.min(), right.min());
    // rust: let value_max = java_max(left.max(), right.max());
    // rust: let low_left = tangent_left - right.max() + left.min();
    // rust: let high_left = tangent_left - right.min() + left.max();
    // rust: let low_right = -tangent_right + right.min() - left.max();
    // rust: let high_right = -tangent_right + right.max() - left.min();
    // rust: minimum = java_min(minimum, value_min + 0.25 * java_min(low_left, low_right));
    // rust: maximum = java_max(maximum, value_max + 0.25 * java_max(high_left, high_right));
}
    // rust: Interval::new(minimum, maximum).map_err(E::from)
}
    // rust: pub(super) fn coordinates_mut(&mut self) -> Vec<&mut C> {
    // rust: match self {
    // rust: Self::Constant(_) => Vec::new(),
    // rust: Self::Multipoint(node) => {
    // rust: let node = Arc::make_mut(node);
    // rust: let mut coordinates = vec![&mut node.coordinate];
    // rust: for point in &mut node.points {
    // rust: coordinates.extend(point.value.coordinates_mut());
}
    // rust: coordinates
}
}
}
    // rust: pub(super) fn try_map_coordinates<D: Copy, E>(
    // rust: &self,
    // rust: map: &mut impl FnMut(C) -> Result<D, E>,
    // rust: ) -> Result<CubicSpline<D>, E> {
    // rust: Ok(match self {
    // rust: Self::Constant(value) => CubicSpline::Constant(*value),
    // rust: Self::Multipoint(node) => {
    // rust: let coordinate = map(node.coordinate)?;
    // rust: let points = node
    // rust: .points
    // rust: .iter()
    // rust: .map(|point| {
    // rust: Ok(SplinePoint {
    // rust: location: point.location,
    // rust: value: point.value.try_map_coordinates(map)?,
    // rust: derivative: point.derivative,
    // rust: })
    // rust: })
    // rust: .collect::<Result<Vec<_>, E>>()?;
    // rust: CubicSpline::Multipoint(Arc::new(MultipointSpline {
    // rust: coordinate,
    // rust: points,
    // rust: depth: node.depth,
    // rust: }))
}
    // rust: })
}
}
    // rust: impl CubicSpline {
    // rust: fn compile(
    // rust: &self,
    // rust: inputs: &[Arc<dyn DensitySampler>],
    // rust: ids: &mut HashMap<usize, usize>,
    // rust: coordinates: &mut Vec<Arc<dyn DensitySampler>>,
    // rust: ) -> Result<Self, SplineError> {
    // rust: match self {
    // rust: Self::Constant(value) => Ok(Self::Constant(*value)),
    // rust: Self::Multipoint(node) => {
    // rust: let coordinate = if let Some(index) = ids.get(&node.coordinate) {
    // rust: *index
    // rust: } else {
    // rust: let input = inputs
    // rust: .get(node.coordinate)
    // rust: .ok_or(SplineError::MissingCoordinate)?;
    // rust: let index = coordinates.len();
    // rust: coordinates.push(input.clone());
    // rust: ids.insert(node.coordinate, index);
    // rust: index
}
    // rust: let points = node
    // rust: .points
    // rust: .iter()
    // rust: .map(|point| {
    // rust: Ok(SplinePoint {
    // rust: location: point.location,
    // rust: derivative: point.derivative,
    // rust: value: point.value.compile(inputs, ids, coordinates)?,
    // rust: })
    // rust: })
    // rust: .collect::<Result<Vec<_>, SplineError>>()?;
    // rust: Self::multipoint(coordinate, points)
}
}
}
}

pub const SplineSampler = struct {
    spline: CubicSpline,
    coordinates: std.ArrayList(*dyn DensitySampler),
};
    // rust: impl SplineSampler {
    /// Equal coordinate IDs share evaluation results. Structural function
    /// identity and deduplication are supplied by the density graph compiler.
    // rust: pub fn new(
    // rust: spline: &CubicSpline,
    // rust: inputs: &[Arc<dyn DensitySampler>],
    // rust: ) -> Result<Self, SplineError> {
    // rust: if matches!(spline, CubicSpline::Constant(value) if value.is_nan()) {
    // rust: return Err(SplineError::NanConstant);
}
    // rust: let mut coordinates = Vec::new();
    // rust: let spline = spline.compile(inputs, &mut HashMap::new(), &mut coordinates)?;
    // rust: Ok(Self {
    // rust: spline,
    // rust: coordinates,
    // rust: })
}
pub fn coordinate_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.coordinates.len()
}
}
    // rust: impl DensitySampler for SplineSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: context.with_buffer(self.coordinates.len(), |context, values| {
    // rust: values.fill(f32::NAN);
    // rust: self.spline.sample(&mut |id| {
    // rust: if values[id].is_nan() {
    // rust: values[id] = self.coordinates[id].sample_value(context, position)?;
}
    // rust: Ok(values[id])
    // rust: })
    // rust: })
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: output: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(output, volume)?;
    // rust: if let CubicSpline::Constant(value) = self.spline {
    // rust: output.fill(value);
    // rust: return Ok(());
}
    // rust: check_exact_buffer(output, volume)?;
    // rust: let mut buffers: Vec<Option<Vec<f32>>> =
    // rust: (0..self.coordinates.len()).map(|_| None).collect();
    // rust: let result = (|| {
    // rust: for (index, value) in output.iter_mut().enumerate() {
    // rust: *value = self.spline.sample(&mut |id| {
    // rust: if buffers[id].is_none() {
    // rust: let mut buffer = context.scratch.pop().unwrap_or_default();
    // rust: buffer.resize(volume.size(), 0.0);
    // rust: if let Err(error) =
    // rust: self.coordinates[id].sample_volume(context, &mut buffer, volume)
    // rust: {
    // rust: context.scratch.push(buffer);
    // rust: return Err(error);
}
    // rust: buffers[id] = Some(buffer);
}
    // rust: Ok(buffers[id].as_ref().unwrap()[index])
    // rust: })?;
}
    // rust: Ok(())
    // rust: })();
        // Release in coordinate-ID order, also after a later lazy child fails.
    // rust: context.scratch.extend(buffers.into_iter().flatten());
    // rust: result
}
}
