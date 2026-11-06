//! Transpiled from Horizon Rust crate
//! Module: horizon-core_interval
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Selected vanilla interval operations used for density graph range analysis.
// use super::arithmetic::{java_max, java_min};

pub const IntervalError = enum {
    NanBound,
    InvertedBounds,
    EmptyInput,
    NanMappedBound,
};
    // rust: impl std::fmt::Display for IntervalError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(match self {
    // rust: Self::NanBound => "interval endpoint is NaN",
    // rust: Self::InvertedBounds => "interval endpoints are reversed",
    // rust: Self::EmptyInput => "at least one interval is required",
    // rust: Self::NanMappedBound => "monotonic range operator produced NaN",
    // rust: })
}
}
    // rust: impl std::error::Error for IntervalError {}

pub const Interval = struct {
    min: f32,
    max: f32,
};
    // rust: impl PartialEq for Interval {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.is_nai() && other.is_nai()) || (self.min == other.min && self.max == other.max)
}
}
    // rust: impl Eq for Interval {}
    // rust: impl Interval {
    // rust: pub const NAI: Self = Self {
    // rust: min: f32::NAN,
    // rust: max: f32::NAN,
}
    // rust: pub const INFINITE: Self = Self {
    // rust: min: f32::NEG_INFINITY,
    // rust: max: f32::INFINITY,
}
pub fn new(min: f32, max: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if max < min {
    // rust: return Err(IntervalError::InvertedBounds);
}
    // rust: if min.is_nan() || max.is_nan() {
    // rust: return Err(IntervalError::NanBound);
}
        // The reference returns a cached [0, 1], canonicalizing a negative zero.
    // rust: Ok(Self {
    // rust: min: if min == 0.0 && max == 1.0 { 0.0 } else { min },
    // rust: max,
    // rust: })
}
pub fn symmetric(value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(-value, value)
}
pub fn exact(value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(value, value)
}
pub fn min(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min
}
pub fn max(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.max
}
pub fn is_nai(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min.is_nan()
}
pub fn contains(self: *Self, value: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value >= self.min && value <= self.max
}
pub fn intersects(self: *Self, other: Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min <= other.max && self.max >= other.min
}
    /// Kept separate from Rust's Hash contract: Java compares signed zeros equal
    /// here, but its endpoint-based hash can distinguish them.
pub fn java_hash_code(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bits = |v: f32| {
    // rust: if v.is_nan() {
    // rust: 0x7fc0_0000_i32
    // rust: } else {
    // rust: v.to_bits() as i32
}
}
    // rust: bits(self.min).wrapping_mul(31).wrapping_add(bits(self.max))
}
pub fn encapsulating_values(a: f32, b: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() && b.is_nan() {
    // rust: Self::NAI
    // rust: } else if a.is_nan() {
    // rust: Self::exact(b).unwrap()
    // rust: } else if b.is_nan() {
    // rust: Self::exact(a).unwrap()
    // rust: } else {
    // rust: Self::new(java_min(a, b), java_max(a, b)).unwrap()
}
}
pub fn encapsulating(intervals: *[Self]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if intervals.is_empty() {
    // rust: return Err(IntervalError::EmptyInput);
}
    // rust: let mut min = f32::INFINITY;
    // rust: let mut max = f32::NEG_INFINITY;
    // rust: for interval in intervals {
    // rust: if !interval.is_nai() {
    // rust: min = java_min(interval.min, min);
    // rust: max = java_max(interval.max, max);
}
}
    // rust: if max < min {
    // rust: Ok(Self::NAI)
    // rust: } else {
    // rust: Self::new(min, max)
}
}
pub fn arithmetic_bounds(min: f32, max: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min.is_nan() || max.is_nan() {
    // rust: Self::NAI
    // rust: } else {
    // rust: Self::new(min, max).expect("ordered interval arithmetic")
}
}
pub fn add_range(self: *Self, right: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::arithmetic_bounds(self.min + right.min, self.max + right.max)
}
pub fn subtract_range(self: *Self, right: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::arithmetic_bounds(self.min - right.max, self.max - right.min)
}
pub fn multiply_range(self: *Self, right: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() || right.is_nai() {
    // rust: return Self::NAI;
}
    // rust: let a = mul_bound(self.min, right.min);
    // rust: let b = mul_bound(self.min, right.max);
    // rust: let c = mul_bound(self.max, right.min);
    // rust: let d = mul_bound(self.max, right.max);
    // rust: Self::new(
    // rust: java_min(java_min(a, b), java_min(c, d)),
    // rust: java_max(java_max(a, b), java_max(c, d)),
    // rust: )
    // rust: .unwrap()
}
pub fn reciprocal(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() || (self.min == 0.0 && self.max == 0.0) {
    // rust: Self::NAI
    // rust: } else if !self.contains(0.0) {
    // rust: Self::new(1.0 / self.max, 1.0 / self.min).unwrap()
    // rust: } else if self.max == 0.0 {
    // rust: Self::new(f32::NEG_INFINITY, 1.0 / self.min).unwrap()
    // rust: } else if self.min == 0.0 {
    // rust: Self::new(1.0 / self.max, f32::INFINITY).unwrap()
    // rust: } else {
    // rust: Self::INFINITE
}
}
pub fn divide_range(self: *Self, right: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.multiply_range(right.reciprocal())
}
pub fn minimum(self: *Self, right: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::arithmetic_bounds(java_min(self.min, right.min), java_min(self.max, right.max))
}
pub fn maximum(self: *Self, right: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::arithmetic_bounds(java_max(self.min, right.min), java_max(self.max, right.max))
}
pub fn clamp(self: *Self, min: f32, max: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min > max {
    // rust: return Err(IntervalError::InvertedBounds);
}
    // rust: if self.is_nai() {
    // rust: Ok(Self::NAI)
    // rust: } else if self.min >= max {
    // rust: Self::exact(max)
    // rust: } else if self.max <= min {
    // rust: Self::exact(min)
    // rust: } else {
    // rust: Self::new(java_max(self.min, min), java_min(self.max, max))
}
}
pub fn abs(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.even_bounds(f32::abs)
}
pub fn square(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.even_bounds(|v| v * v)
}
pub fn log(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() || self.max < 0.0 {
    // rust: Ok(Self::NAI)
    // rust: } else {
    // rust: self.maximum(Self::exact(0.0)?)
    // rust: .map_monotonic(|v| crate::jmath::log(v as f64) as f32)
}
}
pub fn power(self: *Self, exponent: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() || exponent.is_nai() {
    // rust: return Self::NAI;
}
    // rust: if self.min == self.max {
    // rust: return Self::power_base(self.min, exponent);
}
    // rust: let mut result = Self::encapsulating(&[
    // rust: Self::power_base(self.min, exponent),
    // rust: Self::power_base(self.max, exponent),
    // rust: ])
    // rust: .unwrap();
    // rust: if self.contains(0.0) {
    // rust: if self.max > 0.0 {
    // rust: result = Self::encapsulating(&[result, Self::power_base(0.0, exponent)]).unwrap();
}
    // rust: if self.min < 0.0 {
    // rust: result = Self::encapsulating(&[result, Self::power_base(-0.0, exponent)]).unwrap();
}
}
    // rust: result
}
pub fn including_value(self: *Self, value: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value.is_nan() {
    // rust: self
    // rust: } else if self.is_nai() {
    // rust: Self::exact(value).unwrap()
    // rust: } else {
    // rust: Self::new(java_min(self.min, value), java_max(self.max, value)).unwrap()
}
}
pub fn power_base(base: f32, exponent: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if base.is_nan() || exponent.is_nai() {
    // rust: return Self::NAI;
}
    // rust: if exponent.min == exponent.max {
    // rust: let value = java_power(base, exponent.min);
    // rust: return Self::encapsulating_values(value, value);
}
    // rust: if base == 0.0 {
    // rust: let range = if exponent.contains(0.0) {
    // rust: if exponent.max == 0.0 {
    // rust: Self::new(1.0, f32::INFINITY).unwrap()
    // rust: } else if exponent.min == 0.0 {
    // rust: Self::new(0.0, 1.0).unwrap()
    // rust: } else {
    // rust: Self::new(0.0, f32::INFINITY).unwrap()
}
    // rust: } else if exponent.max < 0.0 {
    // rust: Self::exact(f32::INFINITY).unwrap()
    // rust: } else {
    // rust: Self::exact(0.0).unwrap()
}
    // rust: return range.multiply_range(Self::exact(1.0_f32.copysign(base)).unwrap());
}
    // rust: if base == 1.0 {
    // rust: return Self::exact(1.0).unwrap();
}
    // rust: if base > 0.0 {
    // rust: if exponent.min.is_finite() && exponent.max.is_finite() {
    // rust: return Self::encapsulating_values(
    // rust: java_power(base, exponent.min),
    // rust: java_power(base, exponent.max),
    // rust: );
}
    // rust: if exponent.min.is_infinite() && exponent.max.is_infinite() {
    // rust: return Self::new(0.0, f32::INFINITY).unwrap();
}
    // rust: let (min, max) = if exponent.min.is_infinite() {
    // rust: if base < 1.0 {
    // rust: (java_power(base, exponent.max), f32::INFINITY)
    // rust: } else {
    // rust: (0.0, java_power(base, exponent.max))
}
    // rust: } else if base < 1.0 {
    // rust: (0.0, java_power(base, exponent.min))
    // rust: } else {
    // rust: (java_power(base, exponent.min), f32::INFINITY)
}
    // rust: return Self::new(min, max).unwrap();
}
    // rust: let first = (exponent.min as f64).ceil() as f32;
    // rust: let last = (exponent.max as f64).floor() as f32;
    // rust: if last < first {
    // rust: return Self::NAI;
}
    // rust: let a = java_power(base, first);
    // rust: let b = java_power(base, last);
    // rust: let mut result = Self::encapsulating_values(a, b);
    // rust: if first.is_infinite() {
    // rust: result = result.including_value(-a);
    // rust: } else if first + 1.0 < last {
    // rust: result = result.including_value(java_power(base, first + 1.0));
}
    // rust: if last.is_infinite() {
    // rust: result = result.including_value(-b);
    // rust: } else if last - 1.0 > first {
    // rust: result = result.including_value(java_power(base, last - 1.0));
}
    // rust: result
}
pub fn even_bounds(self: *Self, transform: impl Fn(f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() {
    // rust: return self;
}
    // rust: let a = transform(self.min);
    // rust: let b = transform(self.max);
    // rust: Self::new(
    // rust: if self.contains(0.0) {
    // rust: 0.0
    // rust: } else {
    // rust: java_min(a, b)
    // rust: },
    // rust: java_max(a, b),
    // rust: )
    // rust: .unwrap()
}
    /// The caller supplies a monotonic transformation. As in vanilla, this maps
    /// only the endpoints; it does not attempt to prove monotonicity.
    // rust: pub fn map_monotonic(
    // rust: self,
    // rust: mut transform: impl FnMut(f32) -> f32,
    // rust: ) -> Result<Self, IntervalError> {
    // rust: if self.is_nai() {
    // rust: return Ok(self);
}
    // rust: let a = transform(self.min);
    // rust: let b = transform(self.max);
    // rust: if a.is_nan() || b.is_nan() {
    // rust: Err(IntervalError::NanMappedBound)
    // rust: } else {
    // rust: Self::new(java_min(a, b), java_max(a, b))
}
}
pub fn lerp_ranges(self: *Self, first: Self, second: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() || first.is_nai() || second.is_nai() {
    // rust: return Self::NAI;
}
    // rust: Self::encapsulating(&[
    // rust: self.lerp_values(first.min, second.min),
    // rust: self.lerp_values(first.max, second.min),
    // rust: self.lerp_values(first.min, second.max),
    // rust: self.lerp_values(first.max, second.max),
    // rust: ])
    // rust: .unwrap()
}
pub fn lerp_values(self: *Self, first: f32, second: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() || first.is_nan() || second.is_nan() {
    // rust: return Self::NAI;
}
    // rust: if first.is_finite() && second.is_finite() {
    // rust: return Self::encapsulating_values(
    // rust: first + mul_bound(self.min, second - first),
    // rust: first + mul_bound(self.max, second - first),
    // rust: );
}
    // rust: if first == second {
    // rust: return Self::exact(first).unwrap();
}
    // rust: let a = lerp_infinite_bound(self.min, first, second);
    // rust: let b = lerp_infinite_bound(self.max, first, second);
    // rust: if a.is_nan() || b.is_nan() {
    // rust: Self::NAI
    // rust: } else {
    // rust: Self::encapsulating_values(a, b)
}
}
pub fn sign(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_nai() {
    // rust: self
    // rust: } else if self.min == self.max {
    // rust: Self::exact(if self.min == 0.0 {
    // rust: self.min
    // rust: } else {
    // rust: self.min.signum()
    // rust: })
    // rust: .unwrap()
    // rust: } else if self.contains(0.0) {
    // rust: Self::new(
    // rust: if self.min == 0.0 { 0.0 } else { -1.0 },
    // rust: if self.max == 0.0 { 0.0 } else { 1.0 },
    // rust: )
    // rust: .unwrap()
    // rust: } else {
    // rust: Self::exact(if self.min > 0.0 { 1.0 } else { -1.0 }).unwrap()
}
}
}
pub fn java_power(base: f32, exponent: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::arithmetic::java_power(base as f64, exponent as f64) as f32
}
pub fn mul_bound(a: f32, b: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a == 0.0 || b == 0.0 { 0.0 } else { a * b }
}

pub fn lerp_infinite_bound(alpha: f32, first: f32, second: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let a = mul_bound(1.0 - alpha, first);
    // rust: let b = mul_bound(alpha, second);
    // rust: if a.is_infinite() && b.is_infinite() {
    // rust: if alpha <= 0.0 {
    // rust: if second > first {
    // rust: f32::NEG_INFINITY
    // rust: } else {
    // rust: f32::INFINITY
}
    // rust: } else if alpha >= 1.0 {
    // rust: if second > first {
    // rust: f32::INFINITY
    // rust: } else {
    // rust: f32::NEG_INFINITY
}
    // rust: } else {
    // rust: f32::NAN
}
    // rust: } else {
    // rust: a + b
}
}
