//! Transpiled from Horizon Rust crate
package horizon_client_occlusion_culling_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::game::entity::RenderEntityBounds;
// use horizon_client::chunk::ColumnLayout;
// use horizon_client::mobs::{Mob, MobData, MobTypes, Species, render};
// use horizon_core::geometry::Vec3;
// use std::path::Path;

vanilla_models_and_animations_stay_inside_the_precheck_envelope :: proc() {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: eprintln!("no prepared resources: skipped model coverage");
    // rust: return;
}
    // rust: let types = MobTypes::load(&root).unwrap();
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: MobData::load_animations(&root),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: let camera = glam::DVec3::new(3.0, 62.0, -4.0);
    // rust: let mut checked = 0;
    // rust: for kind in types.types.values() {
    // rust: for sample in 0..12 {
    // rust: let mut mob = Mob::new(1, Arc::new(kind.clone()), Vec3::new(1.5, 64.0, 3.25), 37.0);
    // rust: mob.previous = Vec3::new(1.25, 64.25, 3.0);
    // rust: mob.age = sample * 37;
    // rust: mob.limb_speed = 0.8;
    // rust: mob.limb_position = sample as f32 * 1.7;
    // rust: mob.head_pitch = if sample % 2 == 0 { 85.0 } else { -85.0 };
    // rust: mob.extra.age = if sample >= 6 { -100 } else { 0 };
    // rust: mob.death_time = if sample % 3 == 0 { 10 } else { 0 };
    // rust: mob.extra.flag = sample % 2 == 0;
    // rust: mob.extra.size = match mob.species() {
    // rust: Species::Slime | Species::MagmaCube | Species::SulfurCube | Species::Phantom => {
    // rust: if sample % 2 == 0 {
    // rust: 1
    // rust: } else {
    // rust: 4
}
}
    // rust: _ => mob.extra.size,
}
    // rust: if sample % 3 == 1 {
    // rust: mob.custom_name = Some("Dinnerbone".into());
}
    // rust: for partial in [0.0, 0.4, 1.0] {
    // rust: let bounds = mob.render_bounds(f64::from(partial));
    // rust: let lo = bounds.min_position();
    // rust: let hi = bounds.max_position();
    // rust: let lo = [lo.x, lo.y, lo.z];
    // rust: let hi = [hi.x, hi.y, hi.z];
    // rust: let mut vertices = Vec::new();
    // rust: render::render_with(
    // rust: &mob,
    // rust: partial,
    // rust: camera,
    // rust: &|_| Some([0.0, 0.0, 1.0, 1.0]),
    // rust: 0xF0F0,
    // rust: &data,
    // rust: &[],
    // rust: &mut vertices,
    // rust: );
    // rust: for vertex in &vertices {
    // rust: for axis in 0..3 {
    // rust: let world = f64::from(vertex.pos[axis]) + camera[axis];
    // rust: assert!(
    // rust: world >= lo[axis] - 1.0e-4 && world <= hi[axis] + 1.0e-4,
    // rust: "{} sample {sample} partial {partial}: {world} outside {lo:?}..{hi:?}",
    // rust: kind.id,
    // rust: );
}
}
    // rust: checked += usize::from(!vertices.is_empty());
}
}
}
    // rust: assert!(
    // rust: checked > 1_000,
    // rust: "insufficient real model coverage: {checked}"
    // rust: );
}

a_hole_inside_a_coarse_envelope_remains_visible :: proc() {
}
    // rust: let camera = [0.0; 3];
    // rust: let min = [7.95, -3.0, -3.0];
    // rust: let max = [10.05, 3.0, 3.0];
    // rust: assert!(OcclusionCuller::new(camera, 8192).occluded(min, max, |p| p[0] == 4));
    // rust: assert!(
    // rust: !OcclusionCuller::new(camera, 8192).occluded(min, max, |p| p[0] == 4 && p != [4, 1, 0])
    // rust: );
    // rust: assert!(!OcclusionCuller::new(camera, 0).occluded(min, max, |p| p[0] == 4));
}

ray_wall :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut live = Vec::new();
    // rust: let mut chunks = Vec::new();
    // rust: for chunk_z in [-1, 0] {
    // rust: let mut chunk = Chunk::with_layout(0, chunk_z, ColumnLayout::VANILLA);
    // rust: for y in -1..=0 {
    // rust: for z in -1..=0 {
    // rust: chunk.set(4, y, z & 15, 1);
}
}
    // rust: let chunk = Arc::new(chunk);
    // rust: chunks.push(((0, chunk_z), Arc::downgrade(&chunk)));
    // rust: live.push(chunk);
}
    // rust: chunks.sort_unstable_by_key(|(key, _)| *key);
    // rust: (
    // rust: Arc::new(OcclusionSnapshot {
    // rust: chunks,
    // rust: opaque_states: Arc::from([false, true]),
    // rust: }),
    // rust: live,
    // rust: )
}

hidden_cache_entries_require_the_same_camera_and_bounds :: proc() {
}
    // rust: let mut culler = AsyncOcclusionCuller::new().unwrap();
    // rust: culler.query_cache_camera_cell = Some([0; 3]);
    // rust: let bounds = Aabb::new(Vec3::new(8.0, -1.0, -1.0), Vec3::new(10.0, 1.0, 1.0));
    // rust: let original = culler.query_entity_bounds(bounds).unwrap();
    // rust: culler.query_results.push(CachedQueryResult {
    // rust: key: original,
    // rust: stamp: culler.stamp,
    // rust: camera_cell: Some([0; 3]),
    // rust: proof: Some(OcclusionProof {
    // rust: sections: Vec::new(),
    // rust: chunks: Vec::new(),
    // rust: validated_epoch: Cell::new(0),
    // rust: }),
    // rust: last_used_frame: Cell::new(0),
    // rust: });
    // rust: assert!(matches!(
    // rust: culler.query_result(&original, QuerySource::EntityAabb),
    // rust: Some((true, _))
    // rust: ));
    // rust: let moved = culler
    // rust: .query_entity_bounds(bounds.move_by(Vec3::new(0.26, 0.0, 0.0)))
    // rust: .unwrap();
    // rust: assert!(
    // rust: culler
    // rust: .query_result(&moved, QuerySource::EntityAabb)
    // rust: .is_none()
    // rust: );
    // rust: culler.camera[0] = 0.01;
    // rust: let same_subcell_camera = culler.query_entity_bounds(bounds).unwrap();
    // rust: assert!(
    // rust: culler
    // rust: .query_result(&same_subcell_camera, QuerySource::EntityAabb)
    // rust: .is_none()
    // rust: );
    // rust: culler.camera[0] = 0.26;
    // rust: culler.query_cache_camera_cell = camera_cell(culler.camera);
    // rust: let moved_camera = culler.query_entity_bounds(bounds).unwrap();
    // rust: assert!(
    // rust: culler
    // rust: .query_result(&moved_camera, QuerySource::EntityAabb)
    // rust: .is_none()
    // rust: );
}

camera_reuse_uses_quarter_block_cells :: proc() {
}
    // rust: assert_eq!(camera_cell([0.249, 0.0, -0.001]), Some([0, 0, -1]));
    // rust: assert_eq!(camera_cell([0.25, 0.0, 0.0]), Some([1, 0, 0]));
    // rust: assert_eq!(camera_cell([-0.25, 0.0, 0.0]), Some([-1, 0, 0]));
}

stale_world_results_cannot_replace_a_current_proof_in_the_same_camera_cell :: proc() {
}
    // rust: let mut culler = AsyncOcclusionCuller::new().unwrap();
    // rust: culler.query_cache_camera_cell = Some([0; 3]);
    // rust: culler.stamp = SnapshotKey {
    // rust: world_revision: 2,
    // rust: chunks_revision: 4,
    // rust: bottom_y: 0,
}
    // rust: let bounds = Aabb::new(Vec3::new(8.0, -1.0, -1.0), Vec3::new(10.0, 1.0, 1.0));
    // rust: let current_key = culler.query_entity_bounds(bounds).unwrap();
    // rust: culler.query_results.push(CachedQueryResult {
    // rust: key: current_key,
    // rust: stamp: culler.stamp,
    // rust: camera_cell: Some([0; 3]),
    // rust: proof: Some(OcclusionProof {
    // rust: sections: Vec::new(),
    // rust: chunks: Vec::new(),
    // rust: validated_epoch: Cell::new(0),
    // rust: }),
    // rust: last_used_frame: Cell::new(0),
    // rust: });

    // rust: culler.camera[0] = 0.1;
    // rust: let stale_key = culler.query_entity_bounds(bounds).unwrap();
    // rust: let mut stale = CullResults {
    // rust: stamp: SnapshotKey {
    // rust: world_revision: 1,
    // rust: chunks_revision: 4,
    // rust: bottom_y: 0,
    // rust: },
    // rust: camera: stale_key.camera,
    // rust: generation: 0,
    // rust: cancelled: false,
    // rust: hidden: vec![(
    // rust: stale_key,
    // rust: OcclusionProof {
    // rust: sections: Vec::new(),
    // rust: chunks: Vec::new(),
    // rust: validated_epoch: Cell::new(0),
    // rust: },
    // rust: )],
    // rust: visible: Vec::new(),
    // rust: scratch_queries: Vec::new(),
    // rust: worker_ns: 0,
    // rust: hidden_entities: 1,
    // rust: visible_entities: 0,
    // rust: deferred_entities: 0,
}
    // rust: culler.cache_query_results(&mut stale);

    // rust: let index = culler
    // rust: .query_results
    // rust: .binary_search_by_key(&query_bounds_key(&current_key), |entry| {
    // rust: query_bounds_key(&entry.key)
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: culler.query_results[index].stamp.world_revision, 2,
    // rust: "the stale result must not replace the current proof"
    // rust: );
}

stale_camera_visible_results_are_discarded_for_a_fresh_query :: proc() {
}
    // rust: let mut culler = AsyncOcclusionCuller::new().unwrap();
    // rust: culler.stamp = SnapshotKey {
    // rust: world_revision: 2,
    // rust: chunks_revision: 4,
    // rust: bottom_y: 0,
}
    // rust: culler.camera = [0.1, 0.0, 0.0];
    // rust: let key = culler
    // rust: .query_entity_bounds(Aabb::new(
    // rust: Vec3::new(8.0, -1.0, -1.0),
    // rust: Vec3::new(10.0, 1.0, 1.0),
    // rust: ))
    // rust: .unwrap();
    // rust: culler.camera = [0.3, 0.0, 0.0];
    // rust: culler.query_cache_camera_cell = Some([1, 0, 0]);
    // rust: let mut current_key = key;
    // rust: current_key.camera = culler.camera.map(f64::to_bits);
    // rust: let mut results = CullResults {
    // rust: stamp: culler.stamp,
    // rust: camera: key.camera,
    // rust: generation: 0,
    // rust: cancelled: false,
    // rust: hidden: Vec::new(),
    // rust: visible: vec![key],
    // rust: scratch_queries: Vec::new(),
    // rust: worker_ns: 0,
    // rust: hidden_entities: 0,
    // rust: visible_entities: 1,
    // rust: deferred_entities: 0,
}
    // rust: culler.cache_results_for_camera(&mut results, current_key.camera);
    // rust: assert!(results.visible.is_empty());
    // rust: assert!(results.hidden.is_empty());
    // rust: assert!(
    // rust: culler
    // rust: .query_result(&current_key, QuerySource::EntityAabb)
    // rust: .is_none()
    // rust: );
}

camera_relative_bounds_are_rebased_before_querying :: proc() {
}
    // rust: let mut culler = AsyncOcclusionCuller::new().unwrap();
    // rust: culler.camera = [10.25, -4.5, 7.75];
    // rust: let key = culler
    // rust: .query_camera_bounds(
    // rust: glam::Vec3::new(2.0, 4.0, -1.0),
    // rust: glam::Vec3::new(-2.0, -1.0, 3.0),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(key.min.map(f64::from_bits), [8.25, -5.5, 6.75]);
    // rust: assert_eq!(key.max.map(f64::from_bits), [12.25, -0.5, 10.75]);
    // rust: assert_eq!(culler.stats_value()["entity_vertices_scanned"], 2);
}

resetting_benchmark_counters_preserves_the_profiling_choice :: proc() {
}
    // rust: let culler = AsyncOcclusionCuller::new().unwrap();
    // rust: for enabled in [false, true] {
    // rust: culler.measure_bounds_timing.set(enabled);
    // rust: culler.reset_stats();
    // rust: assert_eq!(culler.stats_value()["profiling_enabled"], enabled);
}
}

inactive_answers_expire_while_frequently_used_proofs_stay_cached :: proc() {
}
    // rust: let mut culler = AsyncOcclusionCuller::new().unwrap();
    // rust: let bounds = |x| Aabb::new(Vec3::new(x, -1.0, -1.0), Vec3::new(x + 1.0, 1.0, 1.0));
    // rust: let hot = culler.query_entity_bounds(bounds(8.0)).unwrap();
    // rust: let cold = culler.query_entity_bounds(bounds(12.0)).unwrap();
    // rust: let fresh = culler.query_entity_bounds(bounds(16.0)).unwrap();
    // rust: for key in [hot, cold] {
    // rust: culler.query_results.push(CachedQueryResult {
    // rust: key,
    // rust: stamp: culler.stamp,
    // rust: camera_cell: Some([0; 3]),
    // rust: proof: Some(OcclusionProof {
    // rust: sections: Vec::new(),
    // rust: chunks: Vec::new(),
    // rust: validated_epoch: Cell::new(0),
    // rust: }),
    // rust: last_used_frame: Cell::new(0),
    // rust: });
}
    // rust: culler.frame = 10;
    // rust: assert!(matches!(
    // rust: culler.query_result(&hot, QuerySource::EntityAabb),
    // rust: Some((true, _))
    // rust: ));
    // rust: culler.cache_query_results(&mut CullResults {
    // rust: stamp: culler.stamp,
    // rust: camera: culler.camera.map(f64::to_bits),
    // rust: generation: 0,
    // rust: cancelled: false,
    // rust: hidden: Vec::new(),
    // rust: visible: vec![fresh],
    // rust: scratch_queries: Vec::new(),
    // rust: worker_ns: 0,
    // rust: hidden_entities: 0,
    // rust: visible_entities: 1,
    // rust: deferred_entities: 0,
    // rust: });
    // rust: assert!(matches!(
    // rust: culler.query_result(&hot, QuerySource::EntityAabb),
    // rust: Some((true, _))
    // rust: ));
    // rust: assert!(
    // rust: culler
    // rust: .query_result(&cold, QuerySource::EntityAabb)
    // rust: .is_none()
    // rust: );
    // rust: assert!(matches!(
    // rust: culler.query_result(&fresh, QuerySource::EntityAabb),
    // rust: Some((false, _))
    // rust: ));
}

entity_ray_walks_negative_axes_without_skipping_an_opaque_cell :: proc() {
}
    // rust: let (snapshot, live) = ray_wall();
    // rust: let mut last_chunk = LastChunk::default();
    // rust: let mut opacity_grid = OpacityGrid::default();
    // rust: assert!(!ray_reaches_without_opaque(
    // rust: [8.0, 0.0, 0.0],
    // rust: [0.0, 0.0, 0.0],
    // rust: &snapshot,
    // rust: &mut last_chunk,
    // rust: &mut opacity_grid,
    // rust: ));
    // rust: drop(live);
}

entity_ray_fails_open_when_the_traversal_budget_is_exhausted :: proc() {
}
    // rust: let chunk = Chunk::with_layout(0, 0, ColumnLayout::VANILLA);
    // rust: let chunk = Arc::new(chunk);
    // rust: let snapshot = OcclusionSnapshot {
    // rust: chunks: vec![((0, 0), Arc::downgrade(&chunk))],
    // rust: opaque_states: Arc::from([false, true]),
}
    // rust: let snapshot = Arc::new(snapshot);
    // rust: let mut last_chunk = LastChunk::default();
    // rust: let mut opacity_grid = OpacityGrid::default();
    // rust: assert!(ray_reaches_without_opaque(
    // rust: [0.5, 0.5, 0.5],
    // rust: [f64::from(MAX_OCCLUSION_RAY_STEPS as u32) + 1.5, 0.5, 0.5],
    // rust: &snapshot,
    // rust: &mut last_chunk,
    // rust: &mut opacity_grid,
    // rust: ));
}
