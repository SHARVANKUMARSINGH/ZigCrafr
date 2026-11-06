//! Transpiled from Horizon Rust crate
//! Module: horizon-world_density
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Bounded decoding of density registries into the immutable core graph.
//! Named registry holders and raw numeric tokens preserve compilation behavior.
// use super::*;
// use horizon_core::{
    // rust: density::{
    // rust: BlendedNoise, CubicSpline, DistanceMetric, RoundMode, ShiftNoiseKind, SplinePoint,
    // rust: TilingMode, WorldField,
    // rust: graph::{DensityGraph, FunctionId, GraphBinary, GraphNode, GraphUnary, NoiseId},
    // rust: },
    // rust: geometry::Axis,
}
// use std::{collections::BTreeSet, sync::Arc};

    // rust: pub(super) fn identifier(name: &str) -> Result<String, DecodeError> {
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let namespace = if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: let valid = |c: u8| c.is_ascii_lowercase() || c.is_ascii_digit() || b"_.-".contains(&c);
    // rust: if !namespace.bytes().all(valid)
    // rust: || !path.bytes().all(|c| valid(c) || c == b'/')
    // rust: || path.is_empty()
    // rust: {
    // rust: return Err(DecodeError::Registry(format!(
    // rust: "invalid registry identifier: {name}"
    // rust: )));
}
    // rust: Ok(format!("{namespace}:{path}"))
}
pub fn string(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(serde_json::from_str(raw.get())?)
}
pub fn float(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("float"))
}
pub fn noise_value(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = float(raw)?;
    // rust: if (-1e6..=1e6).contains(&value) {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(DecodeError::Field("density value"))
}
}
pub fn axis(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match string(raw)?.as_str() {
    // rust: "x" => Ok(Axis::X),
    // rust: "y" => Ok(Axis::Y),
    // rust: "z" => Ok(Axis::Z),
    // rust: _ => Err(DecodeError::Field("axis")),
}
}

/// All entries are loaded atomically. Named child references resolve through
/// distinct registry holders; returned entry values are their direct graphs.
pub const DensityRegistry = struct {
    graph: DensityGraph,
    values: BTreeMap<[]const u8,
    noises: BTreeMap<[]const u8,
};
    // rust: impl DensityRegistry {
    /// Input keys are registry identifiers, and values contain original JSON.
    /// This API accepts acyclic registries, at most 256 nested graph levels and
    /// at most 256 interval branches. Inline noise holders are not yet supported.
    // rust: pub fn from_json(
    // rust: noises: &BTreeMap<String, String>,
    // rust: densities: &BTreeMap<String, String>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let mut loader = Loader {
    // rust: graph: DensityGraph::new(),
    // rust: noises: BTreeMap::new(),
    // rust: definitions: BTreeMap::new(),
    // rust: values: BTreeMap::new(),
    // rust: active: BTreeSet::new(),
}
    // rust: for (name, json) in noises {
    // rust: let name = identifier(name)?;
    // rust: let noise = loader
    // rust: .graph
    // rust: .register_noise(name.clone(), decode_noise(json)?)?;
    // rust: loader.noises.insert(name, noise);
}
    // rust: for (name, json) in densities {
    // rust: let name = identifier(name)?;
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: if loader.definitions.insert(name.clone(), raw).is_some() {
    // rust: return Err(DecodeError::Registry(format!(
    // rust: "duplicate density identifier: {name}"
    // rust: )));
}
}
    // rust: let names: Vec<_> = loader.definitions.keys().cloned().collect();
    // rust: for name in names {
    // rust: loader.resolve(&name, 0)?;
}
    // rust: Ok(Self {
    // rust: graph: loader.graph,
    // rust: values: loader.values,
    // rust: noises: loader.noises,
    // rust: })
}
pub fn graph(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.graph
}
pub fn into_graph(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.graph
}
pub fn entries(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.values.iter().map(|(name, id)| (name.as_str(), *id))
}
pub fn value(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.values.get(name).copied()
}
pub fn reference(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.graph.function(name)
}
    /// Decode direct roots against this registry, retaining shared named holders.
    /// All roots are added atomically; a failure leaves existing IDs and graphs
    /// intact. Roots are not registered as additional named density entries.
pub fn decode_functions(self: *Self, json: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut loader = Loader {
    // rust: graph: self.graph.clone(),
    // rust: noises: self.noises.clone(),
    // rust: definitions: BTreeMap::new(),
    // rust: values: BTreeMap::new(),
    // rust: active: BTreeSet::new(),
}
    // rust: let roots = json
    // rust: .iter()
    // rust: .map(|json| {
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: loader.decode(&raw, 0)
    // rust: })
    // rust: .collect::<Result<_, _>>()?;
    // rust: self.graph = loader.graph;
    // rust: Ok(roots)
}
}
pub const Loader = struct {
    graph: DensityGraph,
    noises: BTreeMap<[]const u8,
    definitions: BTreeMap<[]const u8,
    values: BTreeMap<[]const u8,
    active: BTreeSet<[]const u8>,
};
    // rust: impl Loader {
pub fn resolve(self: *Self, name: []const u8, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(id) = self.graph.function(name) {
    // rust: return Ok(id);
}
    // rust: if depth > 256 {
    // rust: return Err(DecodeError::Field("density nesting"));
}
    // rust: if !self.active.insert(name.to_owned()) {
    // rust: return Err(DecodeError::Registry(format!(
    // rust: "cyclic density reference: {name}"
    // rust: )));
}
    // rust: let raw = self
    // rust: .definitions
    // rust: .get(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown density reference: {name}")))?
    // rust: .clone();
    // rust: let value = self.decode(&raw, depth + 1)?;
    // rust: let reference = self.graph.register_function(name.to_owned(), value)?;
    // rust: self.values.insert(name.to_owned(), value);
    // rust: self.active.remove(name);
    // rust: Ok(reference)
}
    // rust: fn input(
    // rust: &mut self,
    // rust: object: &Object,
    // rust: name: &'static str,
    // rust: depth: usize,
    // rust: ) -> Result<FunctionId, DecodeError> {
    // rust: self.decode(required(object, name)?, depth + 1)
}
    // rust: fn optional_input(
    // rust: &mut self,
    // rust: object: &Object,
    // rust: name: &'static str,
    // rust: fallback: f32,
    // rust: depth: usize,
    // rust: ) -> Result<FunctionId, DecodeError> {
    // rust: match optional(object, name) {
    // rust: Some(raw) => self.decode(raw, depth + 1),
    // rust: None => Ok(self.graph.insert(GraphNode::Constant(fallback))?),
}
}
pub fn noise(self: *Self, object: *Object) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw = required(object, "noise")?;
    // rust: if !raw.get().starts_with('"') {
    // rust: return Err(DecodeError::Field("inline noise holder unsupported"));
}
    // rust: let name = identifier(&string(raw)?)?;
    // rust: self.noises
    // rust: .get(&name)
    // rust: .copied()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown noise reference: {name}")))
}
pub fn decode(self: *Self, raw: *RawValue, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 256 {
    // rust: return Err(DecodeError::Field("density nesting"));
}
    // rust: if raw.get().starts_with('"') {
    // rust: return self.resolve(&identifier(&string(raw)?)?, depth);
}
    // rust: if !raw.get().starts_with('{') {
    // rust: return Ok(self.graph.insert(GraphNode::Constant(noise_value(raw)?))?);
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let kind = identifier(&string(required(&object, "type")?)?)?;
    // rust: let unary = match kind.as_str() {
    // rust: "minecraft:abs" => Some(GraphUnary::Abs),
    // rust: "minecraft:square" => Some(GraphUnary::Square),
    // rust: "minecraft:cube" => Some(GraphUnary::Cube),
    // rust: "minecraft:sqrt" => Some(GraphUnary::Sqrt),
    // rust: "minecraft:half_negative" => Some(GraphUnary::HalfNegative),
    // rust: "minecraft:quarter_negative" => Some(GraphUnary::QuarterNegative),
    // rust: "minecraft:reciprocal" => Some(GraphUnary::Reciprocal),
    // rust: "minecraft:negate" => Some(GraphUnary::Negate),
    // rust: "minecraft:squeeze" => Some(GraphUnary::Squeeze),
    // rust: "minecraft:log" => Some(GraphUnary::Log),
    // rust: "minecraft:sign" => Some(GraphUnary::Sign),
    // rust: _ => None,
}
    // rust: let binary = match kind.as_str() {
    // rust: "minecraft:add" => Some(GraphBinary::Add),
    // rust: "minecraft:sub" => Some(GraphBinary::Subtract),
    // rust: "minecraft:mul" => Some(GraphBinary::Multiply),
    // rust: "minecraft:div" => Some(GraphBinary::Divide),
    // rust: "minecraft:min" => Some(GraphBinary::Minimum),
    // rust: "minecraft:max" => Some(GraphBinary::Maximum),
    // rust: _ => None,
}
    // rust: let node = if let Some(kind) = unary {
    // rust: GraphNode::Unary {
    // rust: kind,
    // rust: input: self.input(&object, "input", depth)?,
}
    // rust: } else if let Some(kind) = binary {
    // rust: GraphNode::Binary {
    // rust: kind,
    // rust: left: self.input(&object, "left", depth)?,
    // rust: right: self.input(&object, "right", depth)?,
}
    // rust: } else {
    // rust: match kind.as_str() {
    // rust: "minecraft:constant" => {
    // rust: GraphNode::Constant(noise_value(required(&object, "value")?)?)
}
    // rust: "minecraft:blend_alpha" => GraphNode::WorldField(WorldField::BlendAlpha),
    // rust: "minecraft:blend_offset" => GraphNode::WorldField(WorldField::BlendOffset),
    // rust: "minecraft:beardifier" => GraphNode::WorldField(WorldField::Beardifier),
    // rust: "minecraft:end_outer_islands" => GraphNode::EndIslands,
    // rust: "minecraft:cache" => GraphNode::Cache(self.input(&object, "input", depth)?),
    // rust: "minecraft:blend_density" => {
    // rust: GraphNode::BlendDensity(self.input(&object, "input", depth)?)
}
    // rust: "minecraft:pow" => GraphNode::Power {
    // rust: base: self.input(&object, "base", depth)?,
    // rust: exponent: self.input(&object, "exponent", depth)?,
    // rust: },
    // rust: "minecraft:floor" | "minecraft:round" | "minecraft:ceil" | "minecraft:truncate" => {
    // rust: GraphNode::Round {
    // rust: mode: match kind.as_str() {
    // rust: "minecraft:floor" => RoundMode::Floor,
    // rust: "minecraft:round" => RoundMode::Round,
    // rust: "minecraft:ceil" => RoundMode::Ceil,
    // rust: _ => RoundMode::Truncate,
    // rust: },
    // rust: input: self.input(&object, "input", depth)?,
    // rust: multiple: self.optional_input(&object, "multiple", 1.0, depth)?,
}
}
    // rust: "minecraft:gradient" => {
    // rust: let from = integer(required(&object, "from_coordinate")?)?;
    // rust: let to = integer(required(&object, "to_coordinate")?)?;
    // rust: if from == to {
    // rust: return Err(DecodeError::Field("gradient coordinates"));
}
    // rust: GraphNode::Gradient {
    // rust: axis: axis(required(&object, "axis")?)?,
    // rust: tiling: match optional(&object, "tiling")
    // rust: .map(string)
    // rust: .transpose()?
    // rust: .as_deref()
    // rust: .unwrap_or("clamp_to_edge")
    // rust: {
    // rust: "clamp_to_edge" => TilingMode::ClampToEdge,
    // rust: "repeat" => TilingMode::Repeat,
    // rust: "mirrored_repeat" => TilingMode::MirroredRepeat,
    // rust: _ => return Err(DecodeError::Field("tiling")),
    // rust: },
    // rust: from,
    // rust: to,
    // rust: low: noise_value(required(&object, "from_value")?)?,
    // rust: high: noise_value(required(&object, "to_value")?)?,
}
}
    // rust: "minecraft:noise" => GraphNode::Noise {
    // rust: noise: self.noise(&object)?,
    // rust: xz_scale: double(required(&object, "xz_scale")?)?,
    // rust: y_scale: double(required(&object, "y_scale")?)?,
    // rust: shift_x: self.optional_input(&object, "shift_x", 0.0, depth)?,
    // rust: shift_y: self.optional_input(&object, "shift_y", 0.0, depth)?,
    // rust: shift_z: self.optional_input(&object, "shift_z", 0.0, depth)?,
    // rust: },
    // rust: "minecraft:shift" | "minecraft:shift_a" | "minecraft:shift_b" => {
    // rust: GraphNode::OffsetNoise {
    // rust: noise: self.noise(&object)?,
    // rust: kind: match kind.as_str() {
    // rust: "minecraft:shift" => ShiftNoiseKind::Shift,
    // rust: "minecraft:shift_a" => ShiftNoiseKind::ShiftA,
    // rust: _ => ShiftNoiseKind::ShiftB,
    // rust: },
}
}
    // rust: "minecraft:old_blended_noise" => GraphNode::BlendedNoise(BlendedNoise {
    // rust: xz_scale: double_range(
    // rust: required(&object, "xz_scale")?,
    // rust: "xz_scale",
    // rust: 0.001,
    // rust: 1000.0,
    // rust: )?,
    // rust: y_scale: double_range(required(&object, "y_scale")?, "y_scale", 0.001, 1000.0)?,
    // rust: xz_factor: double_range(
    // rust: required(&object, "xz_factor")?,
    // rust: "xz_factor",
    // rust: 0.001,
    // rust: 1000.0,
    // rust: )?,
    // rust: y_factor: double_range(
    // rust: required(&object, "y_factor")?,
    // rust: "y_factor",
    // rust: 0.001,
    // rust: 1000.0,
    // rust: )?,
    // rust: smear_scale_multiplier: double_range(
    // rust: required(&object, "smear_scale_multiplier")?,
    // rust: "smear_scale_multiplier",
    // rust: 1.0,
    // rust: 8.0,
    // rust: )?,
    // rust: }),
    // rust: "minecraft:slice" => GraphNode::Slice {
    // rust: axis: axis(required(&object, "axis")?)?,
    // rust: coordinate: integer(required(&object, "coordinate")?)?,
    // rust: input: self.input(&object, "input", depth)?,
    // rust: },
    // rust: "minecraft:interpolated" => GraphNode::Interpolated {
    // rust: input: self.input(&object, "input", depth)?,
    // rust: xz: int_range(
    // rust: required(&object, "cell_size_xz")?,
    // rust: "cell_size_xz",
    // rust: 1,
    // rust: i32::MAX,
    // rust: )?,
    // rust: y: int_range(
    // rust: required(&object, "cell_size_y")?,
    // rust: "cell_size_y",
    // rust: 1,
    // rust: i32::MAX,
    // rust: )?,
    // rust: },
    // rust: "minecraft:find_top_surface" => GraphNode::Surface {
    // rust: density: self.input(&object, "density", depth)?,
    // rust: upper: self.input(&object, "upper_bound", depth)?,
    // rust: lower: int_range(
    // rust: required(&object, "lower_bound")?,
    // rust: "lower_bound",
    // rust: -4064,
    // rust: 4062,
    // rust: )?,
    // rust: height: int_range(
    // rust: required(&object, "cell_height")?,
    // rust: "cell_height",
    // rust: 1,
    // rust: i32::MAX,
    // rust: )?,
    // rust: },
    // rust: "minecraft:clamp" => {
    // rust: let min = noise_value(required(&object, "min")?)?;
    // rust: let max = noise_value(required(&object, "max")?)?;
    // rust: if max < min {
    // rust: return Err(DecodeError::Field("clamp bounds"));
}
    // rust: GraphNode::Clamp {
    // rust: input: self.input(&object, "input", depth)?,
    // rust: min,
    // rust: max,
}
}
    // rust: "minecraft:range_choice" => GraphNode::Choice {
    // rust: input: self.input(&object, "input", depth)?,
    // rust: min: noise_value(required(&object, "min_inclusive")?)?,
    // rust: max: noise_value(required(&object, "max_exclusive")?)?,
    // rust: inside: self.input(&object, "when_in_range", depth)?,
    // rust: outside: self.input(&object, "when_out_of_range", depth)?,
    // rust: },
    // rust: "minecraft:lerp" => GraphNode::Lerp {
    // rust: alpha: self.input(&object, "alpha", depth)?,
    // rust: first: self.input(&object, "first", depth)?,
    // rust: second: self.input(&object, "second", depth)?,
    // rust: },
    // rust: "minecraft:interval_select" => {
    // rust: let thresholds: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "thresholds")?.get())?;
    // rust: let thresholds: Vec<f32> = thresholds
    // rust: .iter()
    // rust: .map(|raw| noise_value(raw))
    // rust: .collect::<Result<_, _>>()?;
    // rust: let functions: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "functions")?.get())?;
    // rust: if functions.len() < 2
    // rust: || functions.len() > 256
    // rust: || functions.len() != thresholds.len() + 1
    // rust: || thresholds
    // rust: .windows(2)
    // rust: .any(|pair| pair[0].total_cmp(&pair[1]).is_gt())
    // rust: {
    // rust: return Err(DecodeError::Field("interval selection"));
}
    // rust: let input = self.input(&object, "input", depth)?;
    // rust: let branches = functions
    // rust: .iter()
    // rust: .map(|raw| self.decode(raw, depth + 1))
    // rust: .collect::<Result<_, _>>()?;
    // rust: GraphNode::IntervalSelect {
    // rust: input,
    // rust: thresholds: Arc::from(thresholds),
    // rust: branches,
}
}
    // rust: "minecraft:distance_to_point" => {
    // rust: let raw: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "point")?.get())?;
    // rust: if raw.len() != 3 {
    // rust: return Err(DecodeError::Field("point"));
}
    // rust: let point = [integer(&raw[0])?, integer(&raw[1])?, integer(&raw[2])?];
    // rust: let metric = match string(required(&object, "metric")?)?.as_str() {
    // rust: "euclidean" => DistanceMetric::Euclidean,
    // rust: "euclidean_squared" => DistanceMetric::EuclideanSquared,
    // rust: "manhattan" => DistanceMetric::Manhattan,
    // rust: "chebyshev" => DistanceMetric::Chebyshev,
    // rust: _ => return Err(DecodeError::Field("metric")),
}
    // rust: GraphNode::DistanceToPoint { point, metric }
}
    // rust: "minecraft:spline" => {
    // rust: GraphNode::Spline(self.spline(required(&object, "spline")?, depth + 1)?)
}
    // rust: _ => {
    // rust: return Err(DecodeError::Registry(format!(
    // rust: "unknown density type: {kind}"
    // rust: )));
}
}
}
    // rust: Ok(self.graph.insert(node)?)
}
    // rust: fn spline(
    // rust: &mut self,
    // rust: raw: &RawValue,
    // rust: depth: usize,
    // rust: ) -> Result<CubicSpline<FunctionId>, DecodeError> {
    // rust: if depth > 256 {
    // rust: return Err(DecodeError::Field("spline nesting"));
}
    // rust: if !raw.get().starts_with('{') {
    // rust: return Ok(CubicSpline::Constant(float(raw)?));
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let coordinate = self.input(&object, "coordinate", depth)?;
    // rust: let points: Vec<Box<RawValue>> = serde_json::from_str(required(&object, "points")?.get())?;
    // rust: let points = points
    // rust: .iter()
    // rust: .map(|raw| {
    // rust: let point: Object = serde_json::from_str(raw.get())?;
    // rust: Ok(SplinePoint {
    // rust: location: float(required(&point, "location")?)?,
    // rust: derivative: float(required(&point, "derivative")?)?,
    // rust: value: self.spline(required(&point, "value")?, depth + 1)?,
    // rust: })
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: CubicSpline::multipoint(coordinate, points)
    // rust: .map_err(|error| DecodeError::Graph(error.into()))
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::density::{SamplerContext, graph::DensityCompiler};
pub fn numeric_tokens_keep_negative_zero_and_avoid_double_rounding() void {
}
    // rust: let densities = BTreeMap::from([
    // rust: ("minecraft:negative_zero".into(), "-0".into()),
    // rust: (
    // rust: "minecraft:rounded".into(),
    // rust: "1.0000000596046447753906250000000001".into(),
    // rust: ),
    // rust: ]);
    // rust: let registry = DensityRegistry::from_json(&BTreeMap::new(), &densities).unwrap();
    // rust: let zero = registry.value("minecraft:negative_zero").unwrap();
    // rust: let rounded = registry.value("minecraft:rounded").unwrap();
    // rust: let compiler = DensityCompiler::new(registry.into_graph());
    // rust: let mut context = SamplerContext::default();
    // rust: assert_eq!(
    // rust: compiler
    // rust: .compile_raw(zero)
    // rust: .unwrap()
    // rust: .sample_value(&mut context, [0; 3])
    // rust: .unwrap()
    // rust: .to_bits(),
    // rust: 0x8000_0000
    // rust: );
    // rust: assert_eq!(
    // rust: compiler
    // rust: .compile_raw(rounded)
    // rust: .unwrap()
    // rust: .sample_value(&mut context, [0; 3])
    // rust: .unwrap()
    // rust: .to_bits(),
    // rust: 0x3f80_0001
    // rust: );
}
pub fn forward_references_share_named_holders_and_reject_cycles_or_missing_values() void {
}
    // rust: let mut densities = BTreeMap::from([
    // rust: (
    // rust: "minecraft:a".into(),
    // rust: r#"{"type":"add","left":"z","right":"minecraft:z"}"#.into(),
    // rust: ),
    // rust: ("minecraft:z".into(), "0.5".into()),
    // rust: ]);
    // rust: let registry = DensityRegistry::from_json(&BTreeMap::new(), &densities).unwrap();
    // rust: let root = registry.value("minecraft:a").unwrap();
    // rust: let compiler = DensityCompiler::new(registry.into_graph());
    // rust: assert_eq!(
    // rust: compiler
    // rust: .compile_raw(root)
    // rust: .unwrap()
    // rust: .sample_value(&mut SamplerContext::default(), [0; 3])
    // rust: .unwrap(),
    // rust: 1.0
    // rust: );
    // rust: densities.insert("minecraft:z".into(), r#""a""#.into());
    // rust: assert!(DensityRegistry::from_json(&BTreeMap::new(), &densities).is_err());
    // rust: densities.remove("minecraft:z");
    // rust: assert!(DensityRegistry::from_json(&BTreeMap::new(), &densities).is_err());
}
pub fn codec_validation_rejects_invalid_gradients_intervals_and_splines() void {
}
    // rust: for json in [
    // rust: r#"{"type":"gradient","axis":"y","from_coordinate":0,"to_coordinate":0,"from_value":0,"to_value":1}"#,
    // rust: r#"{"type":"interval_select","input":0,"thresholds":[0,-0],"functions":[0,1,2]}"#,
    // rust: r#"{"type":"interpolated","input":0,"cell_size_xz":0,"cell_size_y":8}"#,
    // rust: r#"{"type":"spline","spline":{"coordinate":0,"points":[]}}"#,
    // rust: r#"{"type":"clamp","input":0,"min":1,"max":-1}"#,
    // rust: ] {
    // rust: assert!(
    // rust: DensityRegistry::from_json(
    // rust: &BTreeMap::new(),
    // rust: &BTreeMap::from([("minecraft:a".into(), json.into())])
    // rust: )
    // rust: .is_err(),
    // rust: "{json}"
    // rust: );
}
}
}
