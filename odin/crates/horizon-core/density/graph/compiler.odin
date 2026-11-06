//! Transpiled from Horizon Rust crate
package horizon_core_compiler

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

// A compiler and cache-ID namespace for one immutable set of density inputs.
// Share resulting samplers across workers, with a separate SamplerContext per
// worker. Context cache cells must not be reused across compiler namespaces.
DensityCompiler :: struct {
    graph: DensityGraph,
    samplers: HashMap<FunctionId,
    prepared: HashMap<FunctionId,
    next_cache: uint,
    context: Maybe(seeded::SeededContext),
}
    // rust: impl DensityCompiler {
new :: proc(graph: DensityGraph) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: graph,
    // rust: samplers: HashMap::new(),
    // rust: prepared: HashMap::new(),
    // rust: next_cache: 0,
    // rust: context: None,
}
}
new_seeded :: proc(graph: DensityGraph, seed: i64, use_legacy_random: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut compiler = Self::new(graph);
    // rust: compiler.context = Some(seeded::SeededContext::new(seed, use_legacy_random));
    // rust: compiler
}
graph :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.graph
}
graph_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.graph
}
cache_count :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.next_cache
}
    // Resolve a registered noise using this compiler's fixed world seed.
    // Ordinary names reuse their sampler; Nether biome compatibility names
    // create a fresh sampler from their dedicated legacy seed on each call.
get_noise_sampler :: proc(self: ^Self, noise: NoiseId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.context
    // rust: .as_ref()
    // rust: .ok_or(CompileError::MissingSeededContext)?
    // rust: .noise(&self.graph, noise)
}
get_sampler :: proc(self: ^Self, id: FunctionId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(sampler) = self.samplers.get(&id) {
    // rust: return Ok(sampler.clone());
}
    // rust: let optimized = self.optimize(id)?;
    // rust: let sampler = self.compile_raw(optimized)?;
    // rust: self.samplers.insert(id, sampler.clone());
    // rust: Ok(sampler)
}
    // rust: fn rewrite_children(
    // rust: &mut self,
    // rust: id: FunctionId,
    // rust: mut rewrite: impl FnMut(&mut Self, FunctionId) -> Result<FunctionId, CompileError>,
    // rust: ) -> Result<FunctionId, CompileError> {
    // rust: let Definition::Node(mut node) = self.graph.entry(id)?.definition.clone() else {
    // rust: return Ok(id);
}
    // rust: if let GraphNode::Reference { input, .. } = node {
    // rust: let rewritten = rewrite(self, input)?;
    // rust: return Ok(if rewritten == input { id } else { rewritten });
}
    // rust: for child in node.children_mut() {
    // rust: *child = rewrite(self, *child)?;
}
    // rust: self.graph.insert(node)
}
optimize :: proc(self: ^Self, id: FunctionId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let prepared = self.prepare(id)?;
    // rust: self.slice_uniform_axes(prepared, 7)
}
prepare :: proc(self: ^Self, mut id: FunctionId) -> R {
    // Ported from Horizon
    return {}
}
        // Vanilla INLINE_REFERENCE unwraps one holder before detecting caches.
        // Nested holders still follow their own rewriteChildren identity rule.
    // rust: if let Definition::Node(GraphNode::Reference { input, .. }) =
    // rust: self.graph.entry(id)?.definition
    // rust: {
    // rust: id = input;
}
    // rust: if let Definition::Node(GraphNode::Cache(input)) = self.graph.entry(id)?.definition.clone()
    // rust: {
    // rust: if let Some(prepared) = self.prepared.get(&input) {
    // rust: return Ok(*prepared);
}
    // rust: let cache_id = self.next_cache;
    // rust: self.next_cache += 1;
    // rust: let optimized = self.optimize(input)?;
    // rust: let sampler = self.compile_raw(optimized)?;
    // rust: let sampler = Arc::new(CachingDensitySampler::new(cache_id, sampler)?);
    // rust: let range = self.graph.range(optimized)?;
    // rust: let axes = self.graph.domain_axes(optimized)?;
    // rust: let prepared = self.graph.bind(sampler, range, axes)?;
    // rust: self.prepared.insert(input, prepared);
    // rust: return Ok(prepared);
}
    // rust: self.rewrite_children(id, Self::prepare)
}
    // rust: fn slice_uniform_axes(
    // rust: &mut self,
    // rust: id: FunctionId,
    // rust: parent_axes: u8,
    // rust: ) -> Result<FunctionId, CompileError> {
    // rust: if matches!(
    // rust: self.graph.entry(id)?.definition,
    // rust: Definition::Node(GraphNode::Constant(_) | GraphNode::Gradient { .. })
    // rust: ) {
    // rust: return Ok(id);
}
    // rust: let axes = self.graph.domain_axes(id)?;
    // rust: let mut result = self.rewrite_children(id, |compiler, child| {
    // rust: compiler.slice_uniform_axes(child, axes)
    // rust: })?;
    // rust: if axes == parent_axes {
    // rust: return Ok(result);
}
    // rust: let mut existing = 0;
    // rust: let mut cursor = result;
    // rust: while let Definition::Node(GraphNode::Slice { axis, input, .. }) =
    // rust: self.graph.entry(cursor)?.definition
    // rust: {
    // rust: existing |= 1 << axis as u8;
    // rust: cursor = input;
}
    // rust: let remove = parent_axes & !axes & !existing;
        // X then Z places these slices adjacent for the XZ sampler specialization.
    // rust: for axis in [Axis::X, Axis::Z, Axis::Y] {
    // rust: if remove & (1 << axis as u8) != 0 {
    // rust: result = self.graph.insert(GraphNode::Slice {
    // rust: axis,
    // rust: coordinate: 0,
    // rust: input: result,
    // rust: })?;
}
}
    // rust: Ok(result)
}
constant :: proc(self: ^Self, id: FunctionId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.graph.entries[id.0].definition {
    // rust: Definition::Node(GraphNode::Constant(value)) => Some(value),
    // rust: _ => None,
}
}
    // Compile exactly the supplied definition, without rewriting. Cache nodes
    // require get_sampler's preparation pass and are rejected here.
compile_raw :: proc(self: ^Self, id: FunctionId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let node = match &self.graph.entry(id)?.definition {
    // rust: Definition::Bound { sampler, .. } => return Ok(sampler.clone()),
    // rust: Definition::Node(node) => node,
}
    // rust: let sampler: Arc<dyn DensitySampler> = match *node {
    // rust: GraphNode::Constant(value) => Arc::new(ConstantSampler(value)),
    // rust: GraphNode::Reference { input, .. } => self.compile_raw(input)?,
    // rust: GraphNode::WorldField(field) => Arc::new(ContextBoundSampler::new(field)),
    // rust: GraphNode::BlendDensity(input) => Arc::new(BlendDensitySampler {
    // rust: input: self.compile_raw(input)?,
    // rust: }),
    // rust: GraphNode::EndIslands => self
    // rust: .context
    // rust: .as_ref()
    // rust: .ok_or(CompileError::MissingSeededContext)?
    // rust: .end_islands(),
    // rust: GraphNode::Noise {
    // rust: noise,
    // rust: xz_scale,
    // rust: y_scale,
    // rust: shift_x,
    // rust: shift_y,
    // rust: shift_z,
    // rust: } => {
    // rust: let noise = self
    // rust: .context
    // rust: .as_ref()
    // rust: .ok_or(CompileError::MissingSeededContext)?
    // rust: .noise(&self.graph, noise)?;
    // rust: let zero = |id: FunctionId| matches!(self.graph.entries[id.0].definition, Definition::Node(GraphNode::Constant(value)) if value.to_bits() == 0);
    // rust: if zero(shift_x) && zero(shift_y) && zero(shift_z) {
    // rust: Arc::new(NoiseSampler {
    // rust: noise,
    // rust: xz_scale,
    // rust: y_scale,
    // rust: })
    // rust: } else {
                    // Compilation order differs from the XYZ sampler's sampling
                    // order: vanilla compiles X, then Z, then optional Y.
    // rust: let x = self.compile_raw(shift_x)?;
    // rust: let z = self.compile_raw(shift_z)?;
    // rust: let y = if zero(shift_y) {
    // rust: None
    // rust: } else {
    // rust: Some(self.compile_raw(shift_y)?)
}
    // rust: Arc::new(ShiftedNoiseSampler {
    // rust: source: NoiseSampler {
    // rust: noise,
    // rust: xz_scale,
    // rust: y_scale,
    // rust: },
    // rust: shift_x: x,
    // rust: shift_y: y,
    // rust: shift_z: z,
    // rust: })
}
}
    // rust: GraphNode::OffsetNoise { noise, kind } => compile_shift_noise(
    // rust: self.context
    // rust: .as_ref()
    // rust: .ok_or(CompileError::MissingSeededContext)?
    // rust: .noise(&self.graph, noise)?,
    // rust: kind,
    // rust: ),
    // rust: GraphNode::BlendedNoise(definition) => self
    // rust: .context
    // rust: .as_ref()
    // rust: .ok_or(CompileError::MissingSeededContext)?
    // rust: .blended(definition)?,
    // rust: GraphNode::Spline(ref spline) => {
    // rust: let mut ids = HashMap::new();
    // rust: let mut coordinates = Vec::new();
    // rust: let compiled = spline.try_map_coordinates(&mut |id| {
    // rust: if let Some(index) = ids.get(&id) {
    // rust: return Ok::<usize, CompileError>(*index);
}
    // rust: let sampler = self.compile_raw(id)?;
                    // Vanilla validates each unique coordinate range immediately
                    // after compiling it, even if sampling never selects it.
    // rust: self.graph.range(id)?;
    // rust: let index = coordinates.len();
    // rust: coordinates.push(sampler);
    // rust: ids.insert(id, index);
    // rust: Ok(index)
    // rust: })?;
    // rust: Arc::new(SplineSampler::new(&compiled, &coordinates)?)
}
    // rust: GraphNode::DistanceToPoint { point, metric } => {
    // rust: Arc::new(DistanceToPointSampler { point, metric })
}
    // rust: GraphNode::IntervalSelect {
    // rust: input,
    // rust: ref thresholds,
    // rust: ref branches,
    // rust: } => {
    // rust: let input = self.compile_raw(input)?;
    // rust: let branches = branches
    // rust: .iter()
    // rust: .map(|id| self.compile_raw(*id))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: Arc::new(
    // rust: IntervalSelectSampler::new(input, thresholds.to_vec(), branches)
    // rust: .map_err(|_| CompileError::InvalidIntervals)?,
    // rust: )
}
    // rust: GraphNode::Gradient {
    // rust: axis,
    // rust: tiling,
    // rust: from,
    // rust: to,
    // rust: low,
    // rust: high,
    // rust: } => Arc::new(GradientSampler::new(axis, tiling, from, to, low, high)),
    // rust: GraphNode::Unary { kind, input } => Arc::new(UnarySampler {
    // rust: input: self.compile_raw(input)?,
    // rust: operation: kind.operation(),
    // rust: }),
    // rust: GraphNode::Round {
    // rust: mode,
    // rust: input,
    // rust: multiple,
    // rust: } => {
    // rust: let input = self.compile_raw(input)?;
    // rust: let multiple = if self.constant(multiple) == Some(1.0) {
    // rust: None
    // rust: } else {
    // rust: Some(self.compile_raw(multiple)?)
}
    // rust: Arc::new(RoundSampler {
    // rust: mode,
    // rust: input,
    // rust: multiple,
    // rust: })
}
    // rust: GraphNode::Power { base, exponent } => {
                // Both children compile before literal selection, even when one
                // compiled child will be discarded by the specialization.
    // rust: let compiled_base = self.compile_raw(base)?;
    // rust: let compiled_exponent = self.compile_raw(exponent)?;
    // rust: if let Some(value) = self.constant(base) {
    // rust: Arc::new(UnarySampler {
    // rust: input: compiled_exponent,
    // rust: operation: UnaryOp::PowerBase(value as f64),
    // rust: })
    // rust: } else if let Some(value) = self.constant(exponent) {
    // rust: compile_constant_exponent(compiled_base, value)
    // rust: } else {
    // rust: Arc::new(PowerSampler {
    // rust: base: compiled_base,
    // rust: exponent: compiled_exponent,
    // rust: })
}
}
    // rust: GraphNode::Binary { kind, left, right } => {
    // rust: return self.compile_binary(kind, left, right);
}
    // rust: GraphNode::Clamp { input, min, max } => Arc::new(UnarySampler {
    // rust: input: self.compile_raw(input)?,
    // rust: operation: UnaryOp::Clamp { min, max },
    // rust: }),
    // rust: GraphNode::Choice {
    // rust: input,
    // rust: min,
    // rust: max,
    // rust: inside,
    // rust: outside,
    // rust: } => {
    // rust: let input = self.compile_raw(input)?;
    // rust: if let (Some(inside), Some(outside)) =
    // rust: (self.constant(inside), self.constant(outside))
    // rust: {
    // rust: Arc::new(UnarySampler {
    // rust: input,
    // rust: operation: UnaryOp::ConstantRangeChoice {
    // rust: min_inclusive: min,
    // rust: max_exclusive: max,
    // rust: inside,
    // rust: outside,
    // rust: },
    // rust: })
    // rust: } else {
    // rust: Arc::new(RangeChoiceSampler {
    // rust: input,
    // rust: min_inclusive: min,
    // rust: max_exclusive: max,
    // rust: when_in_range: self.compile_raw(inside)?,
    // rust: when_out_of_range: self.compile_raw(outside)?,
    // rust: })
}
}
    // rust: GraphNode::Lerp {
    // rust: alpha,
    // rust: first,
    // rust: second,
    // rust: } => {
    // rust: let alpha = self.compile_raw(alpha)?;
    // rust: let first_sampler = self.compile_raw(first)?;
    // rust: let second_sampler = self.compile_raw(second)?;
    // rust: let (first, second) = if let Some(value) = self.constant(first) {
    // rust: (
    // rust: DensityValue::Constant(value),
    // rust: DensityValue::Sampler(second_sampler),
    // rust: )
    // rust: } else if let Some(value) = self.constant(second) {
    // rust: (
    // rust: DensityValue::Sampler(first_sampler),
    // rust: DensityValue::Constant(value),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: DensityValue::Sampler(first_sampler),
    // rust: DensityValue::Sampler(second_sampler),
    // rust: )
}
    // rust: Arc::new(LerpSampler {
    // rust: alpha,
    // rust: first,
    // rust: second,
    // rust: })
}
    // rust: GraphNode::Slice {
    // rust: axis,
    // rust: coordinate,
    // rust: input,
    // rust: } => {
    // rust: let mut axes = match axis {
    // rust: Axis::X => SliceAxes::X(coordinate),
    // rust: Axis::Y => SliceAxes::Y(coordinate),
    // rust: Axis::Z => SliceAxes::Z(coordinate),
}
    // rust: let mut child = input;
    // rust: if let Definition::Node(GraphNode::Slice {
    // rust: axis: inner_axis,
    // rust: coordinate: inner_coordinate,
    // rust: input: inner,
    // rust: }) = self.graph.entry(input)?.definition
    // rust: {
    // rust: if axis == Axis::X && inner_axis == Axis::Z {
    // rust: axes = SliceAxes::Xz {
    // rust: x: coordinate,
    // rust: z: inner_coordinate,
}
    // rust: child = inner;
    // rust: } else if axis == Axis::Z && inner_axis == Axis::X {
    // rust: axes = SliceAxes::Xz {
    // rust: x: inner_coordinate,
    // rust: z: coordinate,
}
    // rust: child = inner;
}
}
    // rust: Arc::new(SliceSampler {
    // rust: axes,
    // rust: input: self.compile_raw(child)?,
    // rust: })
}
    // rust: GraphNode::Cache(_) => return Err(CompileError::UnpreparedCache),
    // rust: GraphNode::Interpolated { input, xz, y } => {
    // rust: Arc::new(InterpolatedSampler::new(self.compile_raw(input)?, xz, y)?)
}
    // rust: GraphNode::Surface {
    // rust: density,
    // rust: upper,
    // rust: lower,
    // rust: height,
    // rust: } => Arc::new(compile_surface_search(
    // rust: self.compile_raw(density)?,
    // rust: self.compile_raw(upper)?,
    // rust: lower,
    // rust: height,
    // rust: )?),
}
    // rust: Ok(sampler)
}
    // rust: fn compile_binary(
    // rust: &self,
    // rust: kind: GraphBinary,
    // rust: left_id: FunctionId,
    // rust: right_id: FunctionId,
    // rust: ) -> Result<Arc<dyn DensitySampler>, CompileError> {
    // rust: let left = self.compile_raw(left_id)?;
    // rust: let right = self.compile_raw(right_id)?;
    // rust: let unary = |input, operation| {
    // rust: Arc::new(UnarySampler { input, operation }) as Arc<dyn DensitySampler>
}
    // rust: let bounds = if matches!(kind, GraphBinary::Minimum | GraphBinary::Maximum) {
    // rust: let a = self.graph.range(left_id)?;
    // rust: let b = self.graph.range(right_id)?;
    // rust: if (kind == GraphBinary::Minimum && a.max() < b.min())
    // rust: || (kind == GraphBinary::Maximum && a.min() > b.max())
    // rust: {
    // rust: return Ok(left);
}
    // rust: if (kind == GraphBinary::Minimum && b.max() < a.min())
    // rust: || (kind == GraphBinary::Maximum && b.min() > a.max())
    // rust: {
    // rust: return Ok(right);
}
    // rust: Some(b)
    // rust: } else {
    // rust: None
}
    // rust: if let Some(value) = self.constant(left_id) {
    // rust: return Ok(unary(
    // rust: right,
    // rust: match kind {
    // rust: GraphBinary::Add => UnaryOp::Add(value),
    // rust: GraphBinary::Subtract => UnaryOp::SubtractFrom(value),
    // rust: GraphBinary::Multiply => UnaryOp::Multiply(value),
    // rust: GraphBinary::Divide => UnaryOp::DivideInto(value),
    // rust: GraphBinary::Minimum => UnaryOp::Minimum(value),
    // rust: GraphBinary::Maximum => UnaryOp::Maximum(value),
    // rust: },
    // rust: ));
}
    // rust: if let Some(value) = self.constant(right_id) {
    // rust: return Ok(unary(
    // rust: left,
    // rust: match kind {
    // rust: GraphBinary::Add => UnaryOp::Add(value),
    // rust: GraphBinary::Subtract => UnaryOp::Add(-value),
    // rust: GraphBinary::Multiply => UnaryOp::Multiply(value),
    // rust: GraphBinary::Divide => UnaryOp::Multiply(1.0 / value),
    // rust: GraphBinary::Minimum => UnaryOp::Minimum(value),
    // rust: GraphBinary::Maximum => UnaryOp::Maximum(value),
    // rust: },
    // rust: ));
}
    // rust: let operation = match kind {
    // rust: GraphBinary::Add => BinaryOp::Add,
    // rust: GraphBinary::Subtract => BinaryOp::Subtract,
    // rust: GraphBinary::Multiply => BinaryOp::Multiply,
    // rust: GraphBinary::Divide => BinaryOp::Divide,
    // rust: GraphBinary::Minimum => BinaryOp::Minimum {
    // rust: right_min: bounds.unwrap().min(),
    // rust: },
    // rust: GraphBinary::Maximum => BinaryOp::Maximum {
    // rust: right_max: bounds.unwrap().max(),
    // rust: },
}
    // rust: Ok(Arc::new(BinarySampler {
    // rust: left,
    // rust: right,
    // rust: operation,
    // rust: }))
}
}
