//! Transpiled from Horizon Rust crate
//! Module: horizon-core_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use std::sync::Mutex;

pub fn power_literal_selection_retains_signed_zeros_and_negative_fallback_behavior() void {
}
    // rust: let signaling_base = UnarySampler {
    // rust: input: Arc::new(ConstantSampler(0.0)),
    // rust: operation: UnaryOp::PowerBase(f64::from_bits(0x7ff4_0000_2000_0000)),
}
    // rust: assert_eq!(
    // rust: signaling_base.sample_value(&mut SamplerContext::default(), [0; 3]),
    // rust: Ok(1.0)
    // rust: );
    // rust: let mut graph = DensityGraph::new();
    // rust: let negative_zero = graph.insert(GraphNode::Constant(-0.0)).unwrap();
    // rust: let two = graph.insert(GraphNode::Constant(2.0)).unwrap();
    // rust: let half = graph.insert(GraphNode::Constant(0.5)).unwrap();
    // rust: let minus_four = graph.insert(GraphNode::Constant(-4.0)).unwrap();
    // rust: let bound_zero = graph
    // rust: .bind(
    // rust: Arc::new(ConstantSampler(-0.0)),
    // rust: Interval::exact(-0.0).unwrap(),
    // rust: 7,
    // rust: )
    // rust: .unwrap();
    // rust: let bound_two = graph
    // rust: .bind(
    // rust: Arc::new(ConstantSampler(2.0)),
    // rust: Interval::exact(2.0).unwrap(),
    // rust: 7,
    // rust: )
    // rust: .unwrap();
    // rust: let roots = [
    // rust: (negative_zero, half),
    // rust: (bound_zero, half),
    // rust: (two, minus_four),
    // rust: (bound_two, minus_four),
    // rust: ]
    // rust: .map(|(base, exponent)| graph.insert(GraphNode::Power { base, exponent }).unwrap());
    // rust: let cached_half = graph.insert(GraphNode::Cache(half)).unwrap();
    // rust: let invalid_raw = graph
    // rust: .insert(GraphNode::Power {
    // rust: base: two,
    // rust: exponent: cached_half,
    // rust: })
    // rust: .unwrap();
    // rust: let compiler = DensityCompiler::new(graph);
    // rust: assert_eq!(
    // rust: compiler.compile_raw(invalid_raw).unwrap_err(),
    // rust: CompileError::UnpreparedCache
    // rust: );
    // rust: for (root, expected) in roots.into_iter().zip([0.0_f32, -0.0, 0.0625, 0.0625]) {
    // rust: let value = compiler
    // rust: .compile_raw(root)
    // rust: .unwrap()
    // rust: .sample_value(&mut SamplerContext::default(), [0; 3])
    // rust: .unwrap();
    // rust: assert_eq!(value.to_bits(), expected.to_bits());
}
    // rust: let sampler = PowerSampler {
    // rust: base: Arc::new(ConstantSampler(0.0)),
    // rust: exponent: Arc::new(FailingSampler),
}
    // rust: assert_eq!(
    // rust: sampler.sample_value(&mut SamplerContext::default(), [0; 3]),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: let mut output = [17.0];
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: assert_eq!(
    // rust: sampler.sample_volume(&mut SamplerContext::default(), &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output, [0.0]);
}

pub fn rounding_specializes_only_literal_one_and_preserves_input_on_multiple_failure() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let input = graph.insert(GraphNode::Constant(0.5)).unwrap();
    // rust: let one = graph.insert(GraphNode::Constant(1.0)).unwrap();
    // rust: let bound = graph
    // rust: .bind(
    // rust: Arc::new(ConstantSampler(1.0)),
    // rust: Interval::exact(1.0).unwrap(),
    // rust: 0,
    // rust: )
    // rust: .unwrap();
    // rust: let failing = graph
    // rust: .bind(Arc::new(FailingSampler), Interval::INFINITE, 7)
    // rust: .unwrap();
    // rust: let roots = [one, bound, failing].map(|multiple| {
    // rust: graph
    // rust: .insert(GraphNode::Round {
    // rust: mode: RoundMode::Round,
    // rust: input,
    // rust: multiple,
    // rust: })
    // rust: .unwrap()
    // rust: });
    // rust: let compiler = DensityCompiler::new(graph);
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [17.0; 2];
    // rust: compiler
    // rust: .compile_raw(roots[0])
    // rust: .unwrap()
    // rust: .sample_volume(&mut SamplerContext::default(), &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output, [1.0; 2]);
    // rust: assert_eq!(
    // rust: compiler.compile_raw(roots[1]).unwrap().sample_volume(
    // rust: &mut SamplerContext::default(),
    // rust: &mut output,
    // rust: volume
    // rust: ),
    // rust: Err(SampleError::ExactBufferSizeRequired)
    // rust: );
    // rust: assert_eq!(
    // rust: compiler.compile_raw(roots[2]).unwrap().sample_volume(
    // rust: &mut SamplerContext::default(),
    // rust: &mut output[..1],
    // rust: volume
    // rust: ),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output[0], 0.5);
}

pub fn end_islands_use_the_world_seed_independently_of_the_noise_algorithm() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let root = graph.insert(GraphNode::EndIslands).unwrap();
    // rust: assert_eq!(graph.domain_axes(root), Ok(5));
    // rust: assert_eq!(
    // rust: graph.range(root).unwrap(),
    // rust: Interval::new(-0.84375, 0.5625).unwrap()
    // rust: );
    // rust: assert_eq!(
    // rust: DensityCompiler::new(graph.clone())
    // rust: .compile_raw(root)
    // rust: .unwrap_err(),
    // rust: CompileError::MissingSeededContext
    // rust: );
    // rust: let volume = DensityVolume::new([3, 4, 2], [-2049, -64, 4096], [17, 8, 31]).unwrap();
    // rust: let mut outputs = Vec::new();
    // rust: for legacy in [false, true] {
    // rust: let mut compiler = DensityCompiler::new_seeded(graph.clone(), i64::MIN, legacy);
    // rust: let sampler = compiler.get_sampler(root).unwrap();
    // rust: let mut output = vec![17.0; volume.size() + 1];
    // rust: sampler
    // rust: .sample_volume(&mut SamplerContext::default(), &mut output, volume)
    // rust: .unwrap();
    // rust: for column in output[..volume.size()].chunks_exact(4) {
    // rust: assert!(column.iter().all(|&value| value == column[0]));
}
    // rust: assert_eq!(output[volume.size()], 17.0);
    // rust: outputs.push(output);
}
    // rust: assert_eq!(outputs[0], outputs[1]);
}

pub fn registered_noises_share_ordinary_instances_and_recreate_nether_instances() void {
}
    // rust: let mut builder = crate::noise::NormalNoise::builder();
    // rust: builder.set_base_octave(-3).set_octave_count(3).unwrap();
    // rust: let definition = builder.build().unwrap();
    // rust: let mut graph = DensityGraph::new();
    // rust: let ordinary = graph
    // rust: .register_noise("horizon:sample".to_owned(), definition.clone())
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: graph.register_noise("horizon:sample".to_owned(), definition.clone()),
    // rust: Err(CompileError::DuplicateNoise)
    // rust: );
    // rust: let nether = graph
    // rust: .register_noise("minecraft:nether/vegetation".to_owned(), definition)
    // rust: .unwrap();
    // rust: let unseeded = DensityCompiler::new(graph.clone());
    // rust: assert_eq!(
    // rust: unseeded.get_noise_sampler(ordinary).unwrap_err(),
    // rust: CompileError::MissingSeededContext
    // rust: );
    // rust: for legacy in [false, true] {
    // rust: let compiler = DensityCompiler::new_seeded(graph.clone(), i64::MAX, legacy);
    // rust: let a = compiler.get_noise_sampler(ordinary).unwrap();
    // rust: let b = compiler.get_noise_sampler(ordinary).unwrap();
    // rust: assert!(Arc::ptr_eq(&a, &b));
    // rust: let a = compiler.get_noise_sampler(nether).unwrap();
    // rust: let b = compiler.get_noise_sampler(nether).unwrap();
    // rust: assert!(!Arc::ptr_eq(&a, &b));
    // rust: assert_eq!(
    // rust: a.get3(-17.25, 64.0, 32.5).to_bits(),
    // rust: b.get3(-17.25, 64.0, 32.5).to_bits()
    // rust: );
}
}

pub fn noise_specialization_requires_literal_positive_zero_shifts() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let noise = graph
    // rust: .register_noise(
    // rust: "horizon:empty".to_owned(),
    // rust: crate::noise::NormalNoise::builder()
    // rust: .set_octave_count(0)
    // rust: .unwrap()
    // rust: .build()
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let zero = graph.insert(GraphNode::Constant(0.0)).unwrap();
    // rust: let negative = graph.insert(GraphNode::Constant(-0.0)).unwrap();
    // rust: let roots = [zero, negative].map(|shift_x| {
    // rust: graph
    // rust: .insert(GraphNode::Noise {
    // rust: noise,
    // rust: xz_scale: 1.0,
    // rust: y_scale: 1.0,
    // rust: shift_x,
    // rust: shift_y: zero,
    // rust: shift_z: zero,
    // rust: })
    // rust: .unwrap()
    // rust: });
    // rust: let compiler = DensityCompiler::new_seeded(graph, 1, false);
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let mut buffer = [17.0; 2];
    // rust: compiler
    // rust: .compile_raw(roots[0])
    // rust: .unwrap()
    // rust: .sample_volume(&mut SamplerContext::default(), &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert_eq!(buffer, [0.0; 2]);
    // rust: compiler
    // rust: .compile_raw(roots[1])
    // rust: .unwrap()
    // rust: .sample_volume(&mut SamplerContext::default(), &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert_eq!(buffer[0].to_bits(), 0);
    // rust: assert_eq!(buffer[1].to_bits(), (-0.0_f32).to_bits());
}

pub fn spline_range_early_return_does_not_skip_coordinate_validation_during_compilation() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let unavailable = graph
    // rust: .bind(Arc::new(FailingSampler), Interval::NAI, 2)
    // rust: .unwrap();
    // rust: let invalid = graph.insert(GraphNode::Constant(f32::NAN)).unwrap();
    // rust: let nested = CubicSpline::multipoint(
    // rust: invalid,
    // rust: vec![SplinePoint {
    // rust: location: 0.0,
    // rust: value: CubicSpline::Constant(1.0),
    // rust: derivative: 0.0,
    // rust: }],
    // rust: )
    // rust: .unwrap();
    // rust: let root = graph
    // rust: .insert(GraphNode::Spline(
    // rust: CubicSpline::multipoint(
    // rust: unavailable,
    // rust: vec![SplinePoint {
    // rust: location: 0.0,
    // rust: value: nested,
    // rust: derivative: 0.0,
    // rust: }],
    // rust: )
    // rust: .unwrap(),
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(graph.range(root), Ok(Interval::NAI));
    // rust: let compiler = DensityCompiler::new(graph);
    // rust: assert!(matches!(
    // rust: compiler.compile_raw(root),
    // rust: Err(CompileError::Range(_))
    // rust: ));
}

pub fn spline_coordinates_share_bulk_evaluation_after_graph_rewriting() void {
}
    // rust: let trace = Arc::new(VerticalTrace::default());
    // rust: let mut graph = DensityGraph::new();
    // rust: let coordinate = graph
    // rust: .bind(trace.clone(), Interval::new(-1.0, 1.0).unwrap(), 2)
    // rust: .unwrap();
    // rust: let inner = CubicSpline::multipoint(
    // rust: coordinate,
    // rust: vec![SplinePoint {
    // rust: location: 0.0,
    // rust: value: CubicSpline::Constant(3.0),
    // rust: derivative: 1.0,
    // rust: }],
    // rust: )
    // rust: .unwrap();
    // rust: let root = graph
    // rust: .insert(GraphNode::Spline(
    // rust: CubicSpline::multipoint(
    // rust: coordinate,
    // rust: vec![
    // rust: SplinePoint {
    // rust: location: -1.0,
    // rust: value: inner.clone(),
    // rust: derivative: 0.0,
    // rust: },
    // rust: SplinePoint {
    // rust: location: 1.0,
    // rust: value: inner,
    // rust: derivative: 0.0,
    // rust: },
    // rust: ],
    // rust: )
    // rust: .unwrap(),
    // rust: ))
    // rust: .unwrap();
    // rust: let mut compiler = DensityCompiler::new(graph);
    // rust: let sampler = compiler.get_sampler(root).unwrap();
    // rust: let volume = DensityVolume::new([3, 3, 2], [-1; 3], [1; 3]).unwrap();
    // rust: let mut output = vec![0.0; volume.size()];
    // rust: sampler
    // rust: .sample_volume(&mut SamplerContext::default(), &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(trace.0.lock().unwrap().len(), 1);
    // rust: for column in output.chunks_exact(3) {
    // rust: assert_eq!(column, [2.0, 3.0, 4.0]);
}
}

pub fn interval_threshold_equality_and_hashing_preserve_distinct_cache_inputs() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let one = graph.insert(GraphNode::Constant(1.0)).unwrap();
    // rust: let zero = graph.insert(GraphNode::Constant(0.0)).unwrap();
    // rust: let shared_nan: Arc<[f32]> = Arc::from([f32::NAN]);
    // rust: let mut ids = Vec::new();
    // rust: for thresholds in [
    // rust: shared_nan.clone(),
    // rust: shared_nan,
    // rust: Arc::from([f32::NAN]),
    // rust: Arc::from([0.0]),
    // rust: Arc::from([-0.0]),
    // rust: ] {
    // rust: ids.push(
    // rust: graph
    // rust: .insert(GraphNode::IntervalSelect {
    // rust: input: one,
    // rust: thresholds,
    // rust: branches: vec![zero, one],
    // rust: })
    // rust: .unwrap(),
    // rust: );
}
    // rust: assert_eq!(ids[0], ids[1]);
    // rust: assert!(!graph.java_equals(ids[0], ids[2]).unwrap());
    // rust: assert!(graph.java_equals(ids[3], ids[4]).unwrap());
    // rust: assert_ne!(ids[3], ids[4]);
    // rust: let doubled_positive = graph
    // rust: .insert(GraphNode::Binary {
    // rust: kind: GraphBinary::Add,
    // rust: left: ids[3],
    // rust: right: ids[3],
    // rust: })
    // rust: .unwrap();
    // rust: let doubled_negative = graph
    // rust: .insert(GraphNode::Binary {
    // rust: kind: GraphBinary::Add,
    // rust: left: ids[4],
    // rust: right: ids[4],
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(doubled_positive, doubled_negative);
    // rust: let caches = ids
    // rust: .into_iter()
    // rust: .map(|input| graph.insert(GraphNode::Cache(input)).unwrap())
    // rust: .collect::<Vec<_>>();
    // rust: let mut compiler = DensityCompiler::new(graph);
    // rust: for cache in caches {
    // rust: compiler.get_sampler(cache).unwrap();
}
    // rust: assert_eq!(compiler.cache_count(), 4);
}

pub fn structural_identity_preserves_java_float_keys_and_shared_cache_ids() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let positive = graph.insert(GraphNode::Constant(0.0)).unwrap();
    // rust: let negative = graph.insert(GraphNode::Constant(-0.0)).unwrap();
    // rust: assert_ne!(positive, negative);
    // rust: let nan = graph.insert(GraphNode::Constant(f32::NAN)).unwrap();
    // rust: assert_eq!(
    // rust: nan,
    // rust: graph
    // rust: .insert(GraphNode::Constant(f32::from_bits(0xffa00001)))
    // rust: .unwrap()
    // rust: );
    // rust: let first = graph.insert(GraphNode::Cache(positive)).unwrap();
    // rust: let second = graph.insert(GraphNode::Cache(positive)).unwrap();
    // rust: assert_eq!(first, second);
    // rust: let root = graph
    // rust: .insert(GraphNode::Binary {
    // rust: kind: GraphBinary::Add,
    // rust: left: first,
    // rust: right: second,
    // rust: })
    // rust: .unwrap();
    // rust: let mut compiler = DensityCompiler::new(graph);
    // rust: assert_eq!(
    // rust: compiler.compile_raw(first).unwrap_err(),
    // rust: CompileError::UnpreparedCache
    // rust: );
    // rust: let sampler = compiler.get_sampler(root).unwrap();
    // rust: assert_eq!(compiler.cache_count(), 1);
    // rust: assert!(Arc::ptr_eq(&sampler, &compiler.get_sampler(root).unwrap()));
}

pub fn failed_parent_preparation_retains_successful_child_and_consumes_new_id_on_retry() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let good = graph.insert(GraphNode::Constant(1.0)).unwrap();
    // rust: let child = graph.insert(GraphNode::Cache(good)).unwrap();
    // rust: let bad = graph.insert(GraphNode::Constant(f32::NAN)).unwrap();
    // rust: let sum = graph
    // rust: .insert(GraphNode::Binary {
    // rust: kind: GraphBinary::Add,
    // rust: left: child,
    // rust: right: bad,
    // rust: })
    // rust: .unwrap();
    // rust: let root = graph.insert(GraphNode::Cache(sum)).unwrap();
    // rust: let mut compiler = DensityCompiler::new(graph);
    // rust: assert!(matches!(
    // rust: compiler.get_sampler(root),
    // rust: Err(CompileError::Range(_))
    // rust: ));
    // rust: assert_eq!(compiler.cache_count(), 2);
    // rust: assert!(matches!(
    // rust: compiler.get_sampler(root),
    // rust: Err(CompileError::Range(_))
    // rust: ));
    // rust: assert_eq!(compiler.cache_count(), 3);
    // rust: let sampler = compiler.get_sampler(child).unwrap();
    // rust: assert_eq!(compiler.cache_count(), 3);
    // rust: assert_eq!(
    // rust: sampler.sample_value(&mut SamplerContext::default(), [3; 3]),
    // rust: Ok(1.0)
    // rust: );
}

pub const FailingSampler = struct {};
    // rust: impl DensitySampler for FailingSampler {
pub fn sample_value(self: *Self, _: *mut SamplerContext, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(SampleError::ZeroGradientPeriod)
}
}

pub fn min_range_elimination_is_strict_and_does_not_skip_child_compilation() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let one = graph.insert(GraphNode::Constant(1.0)).unwrap();
    // rust: let disjoint = graph
    // rust: .bind(
    // rust: Arc::new(FailingSampler),
    // rust: Interval::new(2.0, 3.0).unwrap(),
    // rust: 7,
    // rust: )
    // rust: .unwrap();
    // rust: let touching = graph
    // rust: .bind(
    // rust: Arc::new(FailingSampler),
    // rust: Interval::new(1.0, 3.0).unwrap(),
    // rust: 7,
    // rust: )
    // rust: .unwrap();
    // rust: let cached = graph.insert(GraphNode::Cache(disjoint)).unwrap();
    // rust: let roots: Vec<_> = [disjoint, touching, cached]
    // rust: .into_iter()
    // rust: .map(|right| {
    // rust: graph
    // rust: .insert(GraphNode::Binary {
    // rust: kind: GraphBinary::Minimum,
    // rust: left: one,
    // rust: right,
    // rust: })
    // rust: .unwrap()
    // rust: })
    // rust: .collect();
    // rust: let compiler = DensityCompiler::new(graph);
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let mut context = SamplerContext::default();
    // rust: let mut output = [17.0];
    // rust: compiler
    // rust: .compile_raw(roots[0])
    // rust: .unwrap()
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output, [1.0]);
    // rust: assert_eq!(
    // rust: compiler
    // rust: .compile_raw(roots[1])
    // rust: .unwrap()
    // rust: .sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(
    // rust: compiler.compile_raw(roots[2]).unwrap_err(),
    // rust: CompileError::UnpreparedCache
    // rust: );
}

pub const VerticalTrace = struct {};
    // rust: impl DensitySampler for VerticalTrace {
pub fn sample_value(self: *Self, _: *mut SamplerContext, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(position[1] as f32)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.0.lock().unwrap().push(volume);
    // rust: visit(volume, |index, position| {
    // rust: buffer[index] = position[1] as f32;
    // rust: Ok(())
    // rust: })
}
}

pub fn compiler_reduces_uniform_axes_and_preserves_strided_vertical_samples() void {
}
    // rust: let trace = Arc::new(VerticalTrace::default());
    // rust: let mut graph = DensityGraph::new();
    // rust: let root = graph.bind(trace.clone(), Interval::INFINITE, 2).unwrap();
    // rust: let mut compiler = DensityCompiler::new(graph);
    // rust: let sampler = compiler.get_sampler(root).unwrap();
    // rust: let volume = DensityVolume::new([3, 4, 2], [-9, -7, 11], [2, 3, 5]).unwrap();
    // rust: let mut output = vec![17.0; volume.size() + 1];
    // rust: sampler
    // rust: .sample_volume(&mut SamplerContext::default(), &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: *trace.0.lock().unwrap(),
    // rust: vec![DensityVolume::new([1, 4, 1], [0, -7, 0], [2, 3, 5]).unwrap()]
    // rust: );
    // rust: for column in output[..volume.size()].chunks_exact(4) {
    // rust: assert_eq!(column, [-7.0, -4.0, -1.0, 2.0]);
}
    // rust: assert_eq!(output[volume.size()], 17.0);
    // rust: assert_eq!(compiler.graph().domain_axes(root), Ok(2));
}

pub fn positive_y_bounds_read_a_y_range_choice_with_a_nonpositive_fallback() void {
}
    // rust: let mut graph = DensityGraph::new();
    // rust: let gradient = graph
    // rust: .insert(GraphNode::Gradient {
    // rust: axis: Axis::Y,
    // rust: tiling: TilingMode::ClampToEdge,
    // rust: from: -4064,
    // rust: to: 4062,
    // rust: low: -4064.0,
    // rust: high: 4062.0,
    // rust: })
    // rust: .unwrap();
    // rust: let y = graph
    // rust: .register_function("minecraft:y".into(), gradient)
    // rust: .unwrap();
    // rust: let noise_like = graph.insert(GraphNode::Constant(0.7)).unwrap();
    // rust: let minus_one = graph.insert(GraphNode::Constant(-1.0)).unwrap();
    // rust: let plus_one = graph.insert(GraphNode::Constant(1.0)).unwrap();
    // rust: let choice = |graph: &mut DensityGraph, input, min, max, outside| {
    // rust: graph
    // rust: .insert(GraphNode::Choice {
    // rust: input,
    // rust: min,
    // rust: max,
    // rust: inside: noise_like,
    // rust: outside,
    // rust: })
    // rust: .unwrap()
}
    // rust: let vein = choice(&mut graph, y, 0.0, 50.0, minus_one);
    // rust: let named = graph
    // rust: .register_function("horizon:vein".into(), vein)
    // rust: .unwrap();
    // rust: assert_eq!(graph.positive_y_bounds(named), Ok(Some([0, 49])));
    // rust: let half = choice(&mut graph, y, -59.5, -8.0, minus_one);
    // rust: assert_eq!(graph.positive_y_bounds(half), Ok(Some([-59, -9])));
    // The clamped gradient stays in range below its first coordinate.
    // rust: let open = choice(&mut graph, y, f32::NEG_INFINITY, 10.0, minus_one);
    // rust: assert_eq!(graph.positive_y_bounds(open), Ok(Some([i32::MIN, 9])));
    // rust: let never = choice(&mut graph, y, 5000.0, 6000.0, minus_one);
    // rust: assert_eq!(
    // rust: graph.positive_y_bounds(never),
    // rust: Ok(Some([i32::MAX, i32::MIN]))
    // rust: );
    // A positive fallback, or an input other than y, gives no bounds.
    // rust: let positive = choice(&mut graph, y, 0.0, 50.0, plus_one);
    // rust: assert_eq!(graph.positive_y_bounds(positive), Ok(None));
    // rust: let not_y = choice(&mut graph, noise_like, 0.0, 50.0, minus_one);
    // rust: assert_eq!(graph.positive_y_bounds(not_y), Ok(None));
    // rust: assert_eq!(graph.positive_y_bounds(gradient), Ok(None));
}
