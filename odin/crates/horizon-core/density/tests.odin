//! Transpiled from Horizon Rust crate
package horizon_core_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::{noise::PerlinNoise, random::LegacyRandom};

tail_writes_follow_the_selected_bulk_sampler :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([2, 3, 2], [-3, -4, -5], [1, 2, 1]).unwrap();
    // rust: let mut buffer = vec![17.0; volume.size() + 2];
    // rust: ConstantSampler(-0.0)
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert!(buffer.iter().all(|v| v.to_bits() == (-0.0_f32).to_bits()));
    // rust: GradientSampler::new(Axis::Y, TilingMode::ClampToEdge, -4, 0, -1.0, 1.0)
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert_eq!(&buffer[..3], &[-1.0, 0.0, 1.0]);
    // rust: assert_eq!(buffer[volume.size()].to_bits(), (-0.0_f32).to_bits());
    // rust: let noise = NoiseSampler {
    // rust: noise: Arc::new(PerlinNoise::new(&mut LegacyRandom::new(0))),
    // rust: xz_scale: 0.1,
    // rust: y_scale: 0.2,
}
    // rust: noise
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert!(buffer[volume.size()..].iter().all(|v| v.to_bits() == 0));
}

invalid_buffer_is_rejected_before_child_evaluation :: proc() {
}
    // rust: let volume = DensityVolume::new([1, 2, 1], [0; 3], [1; 3]).unwrap();
    // rust: let mut context = SamplerContext::default();
    // rust: let mut buffer = [19.0];
    // rust: let gradient = GradientSampler::new(Axis::X, TilingMode::Repeat, 0, 0, 1.0, 2.0);
    // rust: assert_eq!(
    // rust: gradient.sample_volume(&mut context, &mut buffer, volume),
    // rust: Err(SampleError::Volume(DensityError::BufferTooShort))
    // rust: );
    // rust: assert_eq!(buffer, [19.0]);
}

scratch_returns_to_context_after_nested_sampling_errors :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let error = context.with_buffer(16, |context, _| {
    // rust: context.with_buffer(32, |_, _| Err::<(), _>(SampleError::ZeroGradientPeriod))
    // rust: });
    // rust: assert_eq!(error, Err(SampleError::ZeroGradientPeriod));
    // rust: assert_eq!(context.scratch.len(), 2);
    // rust: context
    // rust: .with_buffer(8, |context, outer| {
    // rust: outer.fill(17.0);
    // rust: context.with_buffer(8, |_, inner| {
    // rust: inner.fill(29.0);
    // rust: Ok(())
    // rust: })?;
    // rust: assert!(outer.iter().all(|v| *v == 17.0));
    // rust: Ok(())
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(context.scratch.len(), 2);
    // rust: context.clear_scratch();
    // rust: assert!(context.scratch.is_empty());
}

scalar_shortcuts_and_bulk_arithmetic_keep_distinct_results :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let multiply = BinarySampler {
    // rust: left: Arc::new(ConstantSampler(-0.0)),
    // rust: right: Arc::new(ConstantSampler(f32::NAN)),
    // rust: operation: BinaryOp::Multiply,
}
    // rust: assert_eq!(
    // rust: multiply
    // rust: .sample_value(&mut context, [0; 3])
    // rust: .unwrap()
    // rust: .to_bits(),
    // rust: 0
    // rust: );
    // rust: let mut buffer = [17.0];
    // rust: multiply
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert!(buffer[0].is_nan());
    // rust: let minimum = BinarySampler {
    // rust: left: Arc::new(ConstantSampler(0.0)),
    // rust: right: Arc::new(ConstantSampler(-0.0)),
    // rust: operation: BinaryOp::Minimum {
    // rust: right_min: f32::NEG_INFINITY,
    // rust: },
}
    // rust: assert_eq!(
    // rust: minimum
    // rust: .sample_value(&mut context, [0; 3])
    // rust: .unwrap()
    // rust: .to_bits(),
    // rust: (-0.0_f32).to_bits()
    // rust: );
    // rust: minimum
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert_eq!(buffer[0].to_bits(), 0);
}

bulk_choice_evaluates_in_range_before_a_failing_selector :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let choice = RangeChoiceSampler {
    // rust: input: Arc::new(GradientSampler::new(
    // rust: Axis::X,
    // rust: TilingMode::Repeat,
    // rust: 0,
    // rust: 0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: )),
    // rust: min_inclusive: 0.0,
    // rust: max_exclusive: 1.0,
    // rust: when_in_range: Arc::new(ConstantSampler(3.0)),
    // rust: when_out_of_range: Arc::new(ConstantSampler(7.0)),
}
    // rust: let mut buffer = [19.0];
    // rust: assert_eq!(
    // rust: choice.sample_volume(&mut context, &mut buffer, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(buffer, [3.0]);
    // rust: assert_eq!(context.scratch.len(), 1);
    // rust: let mut too_long = [19.0; 2];
    // rust: assert_eq!(
    // rust: choice.sample_volume(&mut context, &mut too_long, volume),
    // rust: Err(SampleError::ExactBufferSizeRequired)
    // rust: );
    // rust: assert_eq!(too_long, [19.0; 2]);
}

interval_branch_errors_keep_selector_output_and_return_scratch :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let selector = IntervalSelectSampler::new(
    // rust: Arc::new(ConstantSampler(-3.0)),
    // rust: vec![0.0],
    // rust: vec![
    // rust: Arc::new(ConstantSampler(7.0)),
    // rust: Arc::new(GradientSampler::new(
    // rust: Axis::X,
    // rust: TilingMode::Repeat,
    // rust: 0,
    // rust: 0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: )),
    // rust: ],
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(selector.sample_value(&mut context, [0; 3]), Ok(7.0));
    // rust: let mut buffer = [19.0];
    // rust: assert_eq!(
    // rust: selector.sample_volume(&mut context, &mut buffer, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(buffer, [-3.0]);
    // rust: assert_eq!(context.scratch.len(), 1);
    // rust: assert_eq!(context.scratch[0].len(), 2);
    // rust: assert!(IntervalSelectSampler::new(Arc::new(ConstantSampler(0.0)), vec![], vec![]).is_err());
}

range_arithmetic_and_zero_equality_match_reference_special_cases :: proc() {
}
    // rust: let zero = Interval::exact(0.0).unwrap();
    // rust: assert_eq!(zero.multiply_range(Interval::INFINITE), zero);
    // rust: assert!(zero.reciprocal().is_nai());
    // rust: assert!(
    // rust: Interval::exact(f32::INFINITY)
    // rust: .unwrap()
    // rust: .add_range(Interval::exact(f32::NEG_INFINITY).unwrap())
    // rust: .is_nai()
    // rust: );
    // rust: let cached = Interval::new(-0.0, 1.0).unwrap();
    // rust: assert_eq!(cached.min().to_bits(), 0);
    // rust: let mixed_zero = Interval::new(-0.0, 0.0).unwrap();
    // rust: assert_eq!(mixed_zero, zero);
    // rust: assert_ne!(mixed_zero.java_hash_code(), zero.java_hash_code());
    // rust: assert_eq!(Interval::NAI, Interval::NAI);
    // rust: assert_eq!(
    // rust: Interval::encapsulating(&[Interval::NAI, cached]),
    // rust: Ok(cached)
    // rust: );
    // rust: assert_eq!(Interval::encapsulating(&[]), Err(IntervalError::EmptyInput));
}

monotonic_mapping_skips_nai_and_rejects_nan_after_both_endpoints :: proc() {
}
    // rust: let mut calls = Vec::new();
    // rust: assert_eq!(
    // rust: Interval::NAI.map_monotonic(|v| {
    // rust: calls.push(v);
    // rust: v
    // rust: }),
    // rust: Ok(Interval::NAI)
    // rust: );
    // rust: assert!(calls.is_empty());
    // rust: assert_eq!(
    // rust: Interval::new(-1.0, 1.0).unwrap().map_monotonic(|v| {
    // rust: calls.push(v);
    // rust: v.sqrt()
    // rust: }),
    // rust: Err(IntervalError::NanMappedBound)
    // rust: );
    // rust: assert_eq!(calls, [-1.0, 1.0]);
    // rust: assert_eq!(
    // rust: Interval::exact(0.0)
    // rust: .unwrap()
    // rust: .lerp_values(f32::INFINITY, f32::NEG_INFINITY),
    // rust: Interval::exact(f32::INFINITY).unwrap()
    // rust: );
}

shift_b_repeats_each_horizontal_sample_and_preserves_tail :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([2, 3, 4], [-17, -64, 32], [4, 8, 16]).unwrap();
    // rust: let source = Arc::new(PerlinNoise::new(&mut LegacyRandom::new(0)));
    // rust: let sampler = compile_shift_noise(source, ShiftNoiseKind::ShiftB);
    // rust: let mut buffer = vec![19.0; volume.size() + 2];
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: for column in buffer[..volume.size()].chunks_exact(3) {
    // rust: assert!(column.iter().all(|v| v.to_bits() == column[0].to_bits()));
}
    // rust: assert_eq!(&buffer[volume.size()..], &[19.0, 19.0]);
    // rust: assert_eq!(context.scratch.len(), 1);
    // rust: assert_eq!(context.scratch[0].len(), 8);
    // rust: let mut short = [23.0; 2];
    // rust: assert_eq!(
    // rust: sampler.sample_volume(&mut context, &mut short, volume),
    // rust: Err(SampleError::Volume(DensityError::BufferTooShort))
    // rust: );
    // rust: assert_eq!(short, [23.0; 2]);
}

blended_fbm_work_bound_rejects_before_random_draws :: proc() {
}
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut expected = random.clone();
    // rust: assert!(matches!(
    // rust: create_blended_fbm(&mut random, i32::MIN, 1.0, 1.0),
    // rust: Err(crate::noise::NoiseBuildError::TooManyOctaves)
    // rust: ));
    // rust: assert!(matches!(
    // rust: create_blended_fbm(&mut random, 1, 1.0, 1.0),
    // rust: Err(crate::noise::NoiseBuildError::PositiveLegacyOctaves)
    // rust: ));
//     use crate::random::RandomSource;
    // rust: assert_eq!(random.next_long(), expected.next_long());
}

volume_lookup_requires_exact_lattice_and_preserves_java_overflow :: proc() {
}
    // rust: let volume = DensityVolume::new([2, 3, 2], [i32::MAX, -64, 32], [4, 1, 4]).unwrap();
    // rust: assert_eq!(volume.index_of_block([i32::MIN + 3, -63, 36]), Some(10));
    // rust: assert_eq!(volume.index_of_block([i32::MIN, -64, 32]), None);
    // rust: let overflow = DensityVolume::new([2, 1, 1], [0; 3], [i32::MAX, 1, 1]).unwrap();
    // rust: assert_eq!(overflow.index_of_block([0; 3]), None);
}

cache_returns_filled_failure_buffer_on_the_next_volume_request :: proc() {
}
    // rust: let mut context = SamplerContext::cached();
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let input = RangeChoiceSampler {
    // rust: input: Arc::new(GradientSampler::new(
    // rust: Axis::X,
    // rust: TilingMode::Repeat,
    // rust: 0,
    // rust: 0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: )),
    // rust: min_inclusive: 0.0,
    // rust: max_exclusive: 1.0,
    // rust: when_in_range: Arc::new(ConstantSampler(7.0)),
    // rust: when_out_of_range: Arc::new(ConstantSampler(9.0)),
}
    // rust: let cached = CachingDensitySampler::new(0, Arc::new(input)).unwrap();
    // rust: let mut buffer = [19.0];
    // rust: assert_eq!(
    // rust: cached.sample_volume(&mut context, &mut buffer, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(buffer, [19.0]);
    // rust: cached
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert_eq!(buffer, [7.0]);
    // rust: assert_eq!(cached.sample_value(&mut context, [0; 3]), Ok(7.0));
    // rust: context.clear_caches();
    // rust: assert_eq!(
    // rust: cached.sample_value(&mut context, [0; 3]),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert!(matches!(
    // rust: CachingDensitySampler::new(65536, Arc::new(ConstantSampler(0.0))),
    // rust: Err(SampleError::CacheIdOutOfRange)
    // rust: ));
}

slices_delegate_matching_volumes_and_isolate_reduced_child_failures :: proc() {
}
    // rust: let mut context = SamplerContext::default();
    // rust: let slice = SliceSampler {
    // rust: input: Arc::new(ConstantSampler(-0.0)),
    // rust: axes: SliceAxes::Xz { x: 7, z: 9 },
}
    // rust: for (sizes, minimum, delegated) in [
    // rust: ([1, 2, 1], [7, -64, 9], true),
    // rust: ([1, 2, 1], [8, -64, 9], false),
    // rust: ([2, 2, 1], [7, -64, 9], false),
    // rust: ([1, 2, 2], [7, -64, 9], false),
    // rust: ] {
    // rust: let volume = DensityVolume::new(sizes, minimum, [4, 8, 16]).unwrap();
    // rust: let mut output = vec![19.0; volume.size() + 2];
    // rust: slice
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert!(
    // rust: output[..volume.size()]
    // rust: .iter()
    // rust: .all(|v| v.to_bits() == (-0.0_f32).to_bits())
    // rust: );
    // rust: let expected_tail = if delegated { -0.0_f32 } else { 19.0 };
    // rust: assert!(
    // rust: output[volume.size()..]
    // rust: .iter()
    // rust: .all(|v| v.to_bits() == expected_tail.to_bits())
    // rust: );
}
    // rust: let failing = SliceSampler {
    // rust: axes: SliceAxes::Y(3),
    // rust: input: Arc::new(RangeChoiceSampler {
    // rust: input: Arc::new(GradientSampler::new(
    // rust: Axis::X,
    // rust: TilingMode::Repeat,
    // rust: 0,
    // rust: 0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: )),
    // rust: min_inclusive: 0.0,
    // rust: max_exclusive: 1.0,
    // rust: when_in_range: Arc::new(ConstantSampler(7.0)),
    // rust: when_out_of_range: Arc::new(ConstantSampler(9.0)),
    // rust: }),
}
    // rust: for (y, expected) in [(2, 19.0), (3, 7.0)] {
    // rust: let volume = DensityVolume::new([1; 3], [0, y, 0], [4, 8, 16]).unwrap();
    // rust: let mut output = [19.0];
    // rust: assert_eq!(
    // rust: failing.sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output, [expected]);
}
    // rust: assert!(!context.scratch.is_empty());
}

slices_preserve_reduced_volume_steps_in_cached_children :: proc() {
}
    // rust: let input = Arc::new(
    // rust: CachingDensitySampler::new(
    // rust: 0,
    // rust: Arc::new(DistanceToPointSampler {
    // rust: point: [0; 3],
    // rust: metric: DistanceMetric::Manhattan,
    // rust: }),
    // rust: )
    // rust: .unwrap(),
    // rust: );
    // rust: let mut context = SamplerContext::cached();
    // rust: let slice = SliceSampler {
    // rust: input: input.clone(),
    // rust: axes: SliceAxes::X(7),
}
    // rust: let volume = DensityVolume::new([3, 2, 2], [-17, -64, 32], [4, 8, 16]).unwrap();
    // rust: let mut output = vec![0.0; volume.size()];
    // rust: slice
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: for z in 0..2 {
    // rust: for x in 0..3 {
    // rust: assert_eq!(
    // rust: &output[(x + z * 3) * 2..(x + z * 3) * 2 + 2],
    // rust: &[103.0 + z as f32 * 16.0, 95.0 + z as f32 * 16.0]
    // rust: );
}
}
    // The following matching request must hit the cached reduced descriptor.
    // A short logical output is still rejected before touching that child.
    // rust: let reduced = DensityVolume::new([1, 2, 2], [7, -64, 32], [4, 8, 16]).unwrap();
    // rust: let mut reduced_output = [0.0; 4];
    // rust: input
    // rust: .sample_volume(&mut context, &mut reduced_output, reduced)
    // rust: .unwrap();
    // rust: assert_eq!(reduced_output, [103.0, 95.0, 119.0, 111.0]);
    // rust: let mut short = [19.0];
    // rust: assert_eq!(
    // rust: slice.sample_volume(&mut context, &mut short, volume),
    // rust: Err(SampleError::Volume(DensityError::BufferTooShort))
    // rust: );
    // rust: assert_eq!(short, [19.0]);
}

grid_interpolation_keeps_incremental_bulk_rounding :: proc() {
}
    // rust: let input = Arc::new(GradientSampler::new(
    // rust: Axis::Y,
    // rust: TilingMode::ClampToEdge,
    // rust: 0,
    // rust: 10,
    // rust: 0.0,
    // rust: 1.0,
    // rust: ));
    // rust: let sampler = InterpolatedSampler::new(input, 4, 10).unwrap();
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([1, 10, 1], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [19.0; 11];
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output[7].to_bits(), 0x3f333334);
    // rust: assert_eq!(
    // rust: sampler
    // rust: .sample_value(&mut context, [0, 7, 0])
    // rust: .unwrap()
    // rust: .to_bits(),
    // rust: 0x3f333333
    // rust: );
    // rust: assert_eq!(output[10], 19.0);
    // rust: let strided = DensityVolume::new([1, 5, 1], [0; 3], [1, 2, 1]).unwrap();
    // rust: let mut selected = [0.0; 5];
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut selected, strided)
    // rust: .unwrap();
    // rust: for (i, value) in selected.iter().enumerate() {
    // rust: assert_eq!(value.to_bits(), output[i * 2].to_bits());
}
}

grid_interpolation_uses_child_bulk_corners_and_preserves_aligned_delegation :: proc() {
}
Traced :: struct {
    volumes: std::sync::Mutex<[dynamic]DensityVolume>,
    points: std::sync::Mutex<Vec<[i32,
}
    // rust: impl DensitySampler for Traced {
    // rust: fn sample_value(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: self.points.lock().unwrap().push(position);
    // rust: Ok(-0.0)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.volumes.lock().unwrap().push(volume);
    // rust: buffer.fill(-0.0);
    // rust: Ok(())
}
}
    // rust: let traced = Arc::new(Traced::default());
    // rust: let sampler = InterpolatedSampler::new(traced.clone(), 4, 8).unwrap();
    // rust: let mut context = SamplerContext::default();
    // rust: assert_eq!(
    // rust: sampler
    // rust: .sample_value(&mut context, [-4, -8, 4])
    // rust: .unwrap()
    // rust: .to_bits(),
    // rust: (-0.0_f32).to_bits()
    // rust: );
    // rust: sampler.sample_value(&mut context, [-1, -1, -1]).unwrap();
    // rust: assert_eq!(*traced.points.lock().unwrap(), [[-4, -8, 4]]);
    // rust: assert_eq!(
    // rust: *traced.volumes.lock().unwrap(),
    // rust: [DensityVolume::new([2; 3], [-4, -8, -4], [4, 8, 4]).unwrap()]
    // rust: );
    // rust: let volume = DensityVolume::new([2, 1, 2], [-4, -8, 4], [4, 1, 4]).unwrap();
    // rust: let mut output = [19.0; 6];
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert!(output.iter().all(|v| v.to_bits() == (-0.0_f32).to_bits()));
    // rust: assert_eq!(traced.volumes.lock().unwrap()[1], volume);
    // rust: let distant = DensityVolume::new([16, 49, 16], [-8192, -64, -8192], [1024, 8, 1024]).unwrap();
    // rust: let mut output = vec![19.; distant.size()];
    // rust: sampler
    // rust: .sample_volume(&mut SamplerContext::sparse(), &mut output, distant)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: traced.volumes.lock().unwrap()[2],
    // rust: distant,
    // rust: "far samples must not expand to a block-resolution bounding box"
    // rust: );
    // rust: let unaligned = DensityVolume::new([2; 3], [-5, -9, -7], [1024, 8, 1024]).unwrap();
    // rust: let mut output = [19.; 8];
    // rust: sampler
    // rust: .sample_volume(&mut SamplerContext::sparse(), &mut output, unaligned)
    // rust: .unwrap();
    // rust: assert!(output.iter().all(|&v| v == 0.));
    // rust: assert!(
    // rust: traced.volumes.lock().unwrap()[3..]
    // rust: .iter()
    // rust: .all(|v| v.size() == 8),
    // rust: "unaligned far points use bounded corner queries"
    // rust: );
    // rust: assert!(InterpolatedSampler::new(traced.clone(), 0, 8).is_err());
    // rust: assert!(InterpolatedSampler::new(traced, 4, -1).is_err());
}

surface_search_fixes_upper_bound_y_and_visits_descending_cell_boundaries :: proc() {
}
DensityTrace :: struct {
    // rust: impl DensitySampler for DensityTrace {
    // rust: fn sample_value(
    // rust: &self,
    _: ^SamplerContext,
    position: [i32,
    // rust: ) -> Result<f32, SampleError> {
    // rust: self.0.lock().unwrap().push(position);
    // rust: Ok(match position[1] {
    // rust: 12 => f32::NAN,
    // rust: 8 => -0.0,
    // rust: _ => 1.0,
    // rust: })
}
}
    // rust: let density = Arc::new(DensityTrace::default());
    // rust: let upper = Arc::new(GradientSampler::new(
    // rust: Axis::Y,
    // rust: TilingMode::ClampToEdge,
    // rust: 0,
    // rust: 10,
    // rust: 14.0,
    // rust: 54.0,
    // rust: ));
    // rust: let sampler = compile_surface_search(density.clone(), upper, -64, 4).unwrap();
    // rust: assert_eq!(
    // rust: sampler.sample_value(&mut SamplerContext::default(), [7, 1000, -9]),
    // rust: Ok(4.0)
    // rust: );
    // rust: assert_eq!(
    // rust: *density.0.lock().unwrap(),
    // rust: [[7, 12, -9], [7, 8, -9], [7, 4, -9]]
    // rust: );
    // rust: density.0.lock().unwrap().clear();
    // rust: let shortcut =
    // rust: FindTopSurfaceSampler::new(density.clone(), Arc::new(ConstantSampler(-63.0)), -64, 8)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: shortcut.sample_value(&mut SamplerContext::default(), [0; 3]),
    // rust: Ok(-64.0)
    // rust: );
    // rust: assert!(density.0.lock().unwrap().is_empty());
    // rust: let negative_infinity = FindTopSurfaceSampler::new(
    // rust: density.clone(),
    // rust: Arc::new(ConstantSampler(f32::NEG_INFINITY)),
    // rust: -64,
    // rust: 1,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: negative_infinity.sample_value(&mut SamplerContext::default(), [0; 3]),
    // rust: Ok(-64.0)
    // rust: );
    // rust: assert!(density.0.lock().unwrap().is_empty());
}

surface_bulk_preserves_upper_bound_writes_and_sliced_error_isolation :: proc() {
}
FailSecondColumn :: struct {
    // rust: impl DensitySampler for FailSecondColumn {
    // rust: fn sample_value(
    // rust: &self,
    _: ^SamplerContext,
    position: [i32,
    // rust: ) -> Result<f32, SampleError> {
    // rust: if position[0] == 1 {
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: } else {
    // rust: Ok(if position[1] <= 4 { 1.0 } else { 0.0 })
}
}
}
    // rust: let raw = Arc::new(
    // rust: FindTopSurfaceSampler::new(
    // rust: Arc::new(FailSecondColumn),
    // rust: Arc::new(ConstantSampler(14.0)),
    // rust: -64,
    // rust: 4,
    // rust: )
    // rust: .unwrap(),
    // rust: );
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([2, 1, 1], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [19.0; 3];
    // rust: assert_eq!(
    // rust: raw.sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output, [4.0, 14.0, 14.0]);
    // rust: let volume = DensityVolume::new([2, 2, 1], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [19.0; 5];
    // rust: assert_eq!(
    // rust: raw.sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::SurfaceRequiresSingleLayer)
    // rust: );
    // rust: assert_eq!(output, [19.0; 5]);
    // rust: let sliced = SliceSampler {
    // rust: input: raw,
    // rust: axes: SliceAxes::Y(0),
}
    // rust: assert_eq!(
    // rust: sliced.sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output, [19.0; 5]);
    // rust: assert!(!context.scratch.is_empty());
}

spline_coordinate_cache_retries_nan_scalars_but_reuses_nan_volumes :: proc() {
}
//     use std::sync::atomic::{AtomicUsize, Ordering};
Counted :: struct {
    value: f32,
    scalar: AtomicUsize,
    bulk: AtomicUsize,
}
    // rust: impl DensitySampler for Counted {
sample_value :: proc(self: ^Self, _: ^SamplerContext, _: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.scalar.fetch_add(1, Ordering::Relaxed);
    // rust: Ok(self.value)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: output: &mut [f32],
    // rust: _: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.bulk.fetch_add(1, Ordering::Relaxed);
    // rust: output.fill(self.value);
    // rust: Ok(())
}
}
    // rust: let inner = CubicSpline::multipoint(
    // rust: 1,
    // rust: vec![SplinePoint {
    // rust: location: 0.0,
    // rust: derivative: -0.0,
    // rust: value: CubicSpline::Constant(7.0),
    // rust: }],
    // rust: )
    // rust: .unwrap();
    // rust: let root = CubicSpline::multipoint(
    // rust: 1,
    // rust: vec![
    // rust: SplinePoint {
    // rust: location: -1.0,
    // rust: derivative: 0.0,
    // rust: value: inner.clone(),
    // rust: },
    // rust: SplinePoint {
    // rust: location: 1.0,
    // rust: derivative: 0.0,
    // rust: value: inner,
    // rust: },
    // rust: ],
    // rust: )
    // rust: .unwrap();
    // rust: for (value, scalar_calls) in [(0.0, 1), (f32::NAN, 2)] {
    // rust: let input = Arc::new(Counted {
    // rust: value,
    // rust: scalar: AtomicUsize::new(0),
    // rust: bulk: AtomicUsize::new(0),
    // rust: });
    // rust: let sampler =
    // rust: SplineSampler::new(&root, &[Arc::new(ConstantSampler(99.0)), input.clone()]).unwrap();
    // rust: assert_eq!(sampler.coordinate_count(), 1);
    // rust: let mut context = SamplerContext::default();
    // rust: assert_eq!(sampler.sample_value(&mut context, [0; 3]), Ok(7.0));
    // rust: assert_eq!(input.scalar.load(Ordering::Relaxed), scalar_calls);
    // rust: let volume = DensityVolume::new([2, 3, 2], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [19.0; 12];
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output, [7.0; 12]);
    // rust: assert_eq!(input.bulk.load(Ordering::Relaxed), 1);
    // rust: assert_eq!(input.scalar.load(Ordering::Relaxed), scalar_calls);
}
    // rust: assert!(matches!(
    // rust: SplineSampler::new(&root, &[]),
    // rust: Err(SplineError::MissingCoordinate)
    // rust: ));
    // rust: assert!(matches!(
    // rust: CubicSpline::multipoint(0, vec![]),
    // rust: Err(SplineError::EmptyPoints)
    // rust: ));
}

spline_lazy_branch_failure_preserves_completed_output_and_returns_scratch :: proc() {
}
    // rust: let fail = CubicSpline::multipoint(
    // rust: 1,
    // rust: vec![SplinePoint {
    // rust: location: 0.0,
    // rust: derivative: 0.0,
    // rust: value: CubicSpline::Constant(11.0),
    // rust: }],
    // rust: )
    // rust: .unwrap();
    // rust: let root = CubicSpline::multipoint(
    // rust: 0,
    // rust: vec![
    // rust: SplinePoint {
    // rust: location: -1.0,
    // rust: derivative: 0.0,
    // rust: value: CubicSpline::Constant(7.0),
    // rust: },
    // rust: SplinePoint {
    // rust: location: 1.0,
    // rust: derivative: 0.0,
    // rust: value: fail,
    // rust: },
    // rust: ],
    // rust: )
    // rust: .unwrap();
    // rust: let inputs: Vec<Arc<dyn DensitySampler>> = vec![
    // rust: Arc::new(GradientSampler::new(
    // rust: Axis::X,
    // rust: TilingMode::ClampToEdge,
    // rust: 0,
    // rust: 1,
    // rust: -2.0,
    // rust: 0.0,
    // rust: )),
    // rust: Arc::new(GradientSampler::new(
    // rust: Axis::X,
    // rust: TilingMode::Repeat,
    // rust: 0,
    // rust: 0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: )),
    // rust: ];
    // rust: let sampler = SplineSampler::new(&root, &inputs).unwrap();
    // rust: let mut context = SamplerContext::default();
    // rust: let volume = DensityVolume::new([2, 1, 1], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [19.0; 2];
    // rust: assert_eq!(
    // rust: sampler.sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output, [7.0, 19.0]);
    // rust: assert_eq!(context.scratch.len(), 2);
    // rust: assert_eq!(sampler.sample_value(&mut context, [0; 3]), Ok(7.0));
}

reset_retains_scratch_but_discards_graph_caches_and_world_bindings :: proc() {
}
    // rust: let binding = Arc::new(ConstantSampler(17.0));
    // rust: let lifetime = Arc::downgrade(&binding);
    // rust: let mut context = SamplerContext::cached()
    // rust: .with_world_fields(WorldFields::default().with_field(WorldField::Beardifier, binding));
    // rust: let cached = CachingDensitySampler::new(
    // rust: 0,
    // rust: Arc::new(ContextBoundSampler::new(WorldField::Beardifier)),
    // rust: )
    // rust: .unwrap();
    // rust: let volume = DensityVolume::new([2; 3], [0; 3], [1; 3]).unwrap();
    // rust: let mut output = [0.0; 8];
    // rust: cached
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output, [17.0; 8]);
    // rust: assert_eq!(cached.sample_value(&mut context, [9; 3]), Ok(17.0));
    // rust: context
    // rust: .with_buffer(128, |_, buffer| {
    // rust: buffer.fill(99.0);
    // rust: Ok(())
    // rust: })
    // rust: .unwrap();
    // rust: let allocation = context.scratch[0].as_ptr();
    // rust: let capacity = context.scratch[0].capacity();
    // rust: context.reset();
    // rust: assert!(lifetime.upgrade().is_none());
    // rust: assert!(context.caches.as_ref().unwrap().is_empty());
    // rust: assert_eq!(context.scratch[0].as_ptr(), allocation);
    // rust: assert_eq!(context.scratch[0].capacity(), capacity);
    // Same coordinates and cache ID must resolve the new context's fallback.
    // rust: assert_eq!(cached.sample_value(&mut context, [9; 3]), Ok(0.0));
    // rust: cached
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output, [0.0; 8]);
    // A different graph may reuse IDs without inheriting scalar/volume results.
    // rust: context.reset();
    // rust: let replacement = CachingDensitySampler::new(0, Arc::new(ConstantSampler(3.0))).unwrap();
    // rust: assert_eq!(replacement.sample_value(&mut context, [9; 3]), Ok(3.0));
    // rust: replacement
    // rust: .sample_volume(&mut context, &mut output, volume)
    // rust: .unwrap();
    // rust: assert_eq!(output, [3.0; 8]);
}

reset_after_sampling_error_drops_blender_and_preserves_uncached_mode :: proc() {
}
    // rust: let blender = Arc::new(EmptyBlender);
    // rust: let lifetime = Arc::downgrade(&blender);
    // rust: let mut context =
    // rust: SamplerContext::default().with_world_fields(WorldFields::default().with_blender(blender));
    // rust: let result: Result<(), SampleError> = context.with_buffer(64, |_, buffer| {
    // rust: buffer.fill(42.0);
    // rust: Err(SampleError::RecursiveCache)
    // rust: });
    // rust: assert_eq!(result, Err(SampleError::RecursiveCache));
    // rust: let allocation = context.scratch[0].as_ptr();
    // rust: context.reset();
    // rust: assert!(lifetime.upgrade().is_none());
    // rust: assert!(context.caches.is_none());
    // rust: context
    // rust: .with_buffer(32, |_, buffer| {
    // rust: assert_eq!(buffer.as_ptr(), allocation);
    // rust: Ok(())
    // rust: })
    // rust: .unwrap();
}

unary_bulk_keeps_child_failure_writes_and_full_buffer_tail :: proc() {
}
PartialInput :: struct {
    // rust: impl DensitySampler for PartialInput {
sample_value :: proc(self: ^Self, _: ^SamplerContext, _: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Err(SampleError::ZeroGradientPeriod)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: _: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: buffer[0] = -3.0;
    // rust: Err(SampleError::ZeroGradientPeriod)
}
}
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let mut context = SamplerContext::default();
    // rust: let mut buffer = [17.0; 3];
    // rust: let sampler = UnarySampler {
    // rust: input: Arc::new(PartialInput),
    // rust: operation: UnaryOp::Square,
}
    // rust: assert_eq!(
    // rust: sampler.sample_volume(&mut context, &mut buffer, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(buffer, [-3.0, 17.0, 17.0]);
    // rust: let sampler = UnarySampler {
    // rust: input: Arc::new(ConstantSampler(-3.0)),
    // rust: operation: UnaryOp::Square,
}
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut buffer, volume)
    // rust: .unwrap();
    // rust: assert_eq!(buffer, [9.0; 3]);
}

binary_bulk_preserves_child_failure_order_and_output :: proc() {
}
Input :: struct {
    name: ^'static str,
    value: f32,
    fail: bool,
    calls: ^std::sync::Mutex<[dynamic]^'static str>,
}
    // rust: impl DensitySampler for Input {
sample_value :: proc(self: ^Self, _: ^SamplerContext, _: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: unreachable!("bulk-only fixture")
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: _: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.calls.lock().unwrap().push(self.name);
    // rust: buffer.fill(self.value);
    // rust: if self.fail {
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: } else {
    // rust: Ok(())
}
}
}
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: for left_fails in [true, false] {
    // rust: let calls = Arc::new(std::sync::Mutex::new(Vec::new()));
    // rust: let sampler = BinarySampler {
    // rust: left: Arc::new(Input {
    // rust: name: "left",
    // rust: value: 3.0,
    // rust: fail: left_fails,
    // rust: calls: calls.clone(),
    // rust: }),
    // rust: right: Arc::new(Input {
    // rust: name: "right",
    // rust: value: 7.0,
    // rust: fail: true,
    // rust: calls: calls.clone(),
    // rust: }),
    // rust: operation: BinaryOp::Multiply,
}
    // rust: let mut context = SamplerContext::default();
    // rust: let mut wrong_size = [17.0; 2];
    // rust: assert!(
    // rust: sampler
    // rust: .sample_volume(&mut context, &mut wrong_size, volume)
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!(wrong_size, [17.0; 2]);
    // rust: assert!(calls.lock().unwrap().is_empty());
    // rust: let mut output = [17.0];
    // rust: assert_eq!(
    // rust: sampler.sample_volume(&mut context, &mut output, volume),
    // rust: Err(SampleError::ZeroGradientPeriod)
    // rust: );
    // rust: assert_eq!(output, [3.0]);
    // rust: assert_eq!(
    // rust: *calls.lock().unwrap(),
    // rust: if left_fails {
    // rust: vec!["left"]
    // rust: } else {
    // rust: vec!["left", "right"]
}
    // rust: );
}
}
// A y-fixed slice's plane, kept by `SamplerContext::with_planes`, gives the
// values fresh sampling gives at other heights and vertical steps, and is
// sampled once for one x/z lattice.
kept_planes_match_fresh_slices_across_vertical_lattices :: proc() {
}
//     use std::sync::atomic::{AtomicUsize, Ordering};
Counted :: struct {
    // rust: impl DensitySampler for Counted {
sample_value :: proc(self: ^Self, c: ^SamplerContext, p: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0.sample_value(c, p)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: c: &mut SamplerContext,
    // rust: out: &mut [f32],
    // rust: v: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.1.fetch_add(1, Ordering::Relaxed);
    // rust: self.0.sample_volume(c, out, v)
}
}
    // rust: let input = Arc::new(Counted(
    // rust: NoiseSampler {
    // rust: noise: Arc::new(PerlinNoise::new(&mut LegacyRandom::new(5))),
    // rust: xz_scale: 0.3,
    // rust: y_scale: 0.7,
    // rust: },
    // rust: AtomicUsize::new(0),
    // rust: ));
    // rust: let slice = slice::SliceSampler {
    // rust: input: input.clone(),
    // rust: axes: slice::SliceAxes::Y(0),
}
    // rust: let lattices = [
    // rust: DensityVolume::new([5, 9, 4], [-8, -64, 12], [4, 64, 4]).unwrap(),
    // rust: DensityVolume::new([5, 17, 4], [-8, 0, 12], [4, 8, 4]).unwrap(),
    // rust: ];
    // rust: let mut kept = SamplerContext::sparse().with_planes();
    // rust: for (i, volume) in lattices.into_iter().enumerate() {
    // rust: let mut fresh = vec![0.0; volume.size()];
    // rust: slice
    // rust: .sample_volume(&mut SamplerContext::sparse(), &mut fresh, volume)
    // rust: .unwrap();
    // rust: let mut reused = vec![1.0; volume.size()];
    // rust: slice.sample_volume(&mut kept, &mut reused, volume).unwrap();
    // rust: assert_eq!(fresh, reused, "lattice {i}");
}
    // Two fresh evaluations and one kept plane.
    // rust: assert_eq!(input.1.load(Ordering::Relaxed), 3);
}
