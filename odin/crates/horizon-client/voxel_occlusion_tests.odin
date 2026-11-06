//! Transpiled from Horizon Rust crate
package horizon_client_voxel_occlusion_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use std::cell::Cell;

vertex :: proc(pos: [f32; 3]) -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::mesher::Vertex {
    // rust: pos,
    // rust: uv: [0.0; 2],
    // rust: layer: 0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
}
}

bits :: proc(bounds: ([f64; 3]) {
}
    // rust: (bounds.0.map(f64::to_bits), bounds.1.map(f64::to_bits))
}

    // rust: fn per_vertex_reference(
    // rust: camera: [f64; 3],
    // rust: vertices: &[crate::mesher::Vertex],
    // rust: start: usize,
    // rust: ) -> Option<([f64; 3], [f64; 3])> {
    // rust: let points = vertices.get(start..)?;
    // rust: let mut min = [f64::INFINITY; 3];
    // rust: let mut max = [f64::NEG_INFINITY; 3];
    // rust: if points.is_empty() {
    // rust: return None;
}
    // rust: for vertex in points {
    // rust: for axis in 0..3 {
    // rust: let value = f64::from(vertex.pos[axis]) + camera[axis];
    // rust: if !value.is_finite() {
    // rust: return None;
}
    // rust: min[axis] = min[axis].min(value);
    // rust: max[axis] = max[axis].max(value);
}
}
    // rust: Some((min.map(|value| value - 0.05), max.map(|value| value + 0.05)))
}

bounds_match_per_vertex_reference_bit_for_bit :: proc() {
}
    // rust: let camera = [12.25, -64.5, 31.75];
    // rust: let vertices = [
    // rust: vertex([500.0, 500.0, 500.0]),
    // rust: vertex([-1.25, 2.5, -0.125]),
    // rust: vertex([3.75, -4.5, 1.0]),
    // rust: vertex([0.5, 0.25, 8.0]),
    // rust: ];
    // rust: let actual = Culler::bounds(camera, &vertices, 1).unwrap();
    // rust: let expected = per_vertex_reference(camera, &vertices, 1).unwrap();
    // rust: assert_eq!(bits(actual), bits(expected));

    // rust: let signed_zero_vertices = [vertex([0.0; 3]), vertex([-0.0; 3])];
    // rust: let actual = Culler::bounds([0.0; 3], &signed_zero_vertices, 0).unwrap();
    // rust: let expected = per_vertex_reference([0.0; 3], &signed_zero_vertices, 0).unwrap();
    // rust: assert_eq!(bits(actual), bits(expected));
}

bounds_fail_open_for_empty_and_non_finite_geometry :: proc() {
}
    // rust: assert_eq!(Culler::bounds([0.0; 3], &[], 0), None);
    // rust: assert_eq!(Culler::bounds([0.0; 3], &[vertex([1.0; 3])], 1), None);

    // rust: for value in [f32::NAN, f32::INFINITY, f32::NEG_INFINITY] {
    // rust: assert_eq!(
    // rust: Culler::bounds([0.0; 3], &[vertex([value, 0.0, 0.0])], 0),
    // rust: None
    // rust: );
}
    // rust: assert_eq!(
    // rust: Culler::bounds(
    // rust: [0.0; 3],
    // rust: &[vertex([1.0; 3]), vertex([0.0, f32::NAN, 0.0])],
    // rust: 0
    // rust: ),
    // rust: None
    // rust: );

    // rust: for value in [f64::NAN, f64::INFINITY, f64::NEG_INFINITY] {
    // rust: assert_eq!(
    // rust: Culler::bounds([value, 0.0, 0.0], &[vertex([1.0; 3])], 0),
    // rust: None
    // rust: );
}
}

bounds_handle_a_single_vertex_and_nonzero_start :: proc() {
}
    // rust: let vertices = [vertex([-100.0; 3]), vertex([1.25, -2.5, 4.0])];
    // rust: let actual = Culler::bounds([10.0, 20.0, 30.0], &vertices, 1).unwrap();
    // rust: assert_eq!(
    // rust: bits(actual),
    // rust: bits(([11.2, 17.45, 33.95], [11.3, 17.55, 34.05]))
    // rust: );
}

completed_mesh_culling_preserves_prior_geometry_and_protruding_parts :: proc() {
}
    // rust: let prior = vertex([0.0; 3]);
    // rust: let body = [vertex([8.0, -1.0, -1.0]), vertex([10.0, 1.0, 1.0])];
    // rust: let wall = |p: [i32; 3]| p[0] == 4 && (-1..=0).contains(&p[1]);
    // rust: let mut hidden = vec![prior];
    // rust: hidden.extend(body);
    // rust: assert!(Culler::new([0.0; 3], 1_000).cull_vertices(&mut hidden, 1, wall));
    // rust: assert_eq!(hidden.len(), 1);
    // rust: assert_eq!(hidden[0].pos, prior.pos);

    // A held item or animated part beyond the wall keeps the whole model.
    // rust: let mut exposed = vec![prior];
    // rust: exposed.extend(body);
    // rust: exposed.push(vertex([8.0, 5.0, 0.0]));
    // rust: let before = exposed.clone();
    // rust: assert!(!Culler::new([0.0; 3], 1_000).cull_vertices(&mut exposed, 1, wall));
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&exposed),
    // rust: bytemuck::cast_slice::<_, u8>(&before)
    // rust: );
    // rust: assert!(!Culler::new([0.0; 3], 0).cull_vertices(&mut exposed, 1, |_| panic!()));
}

opaque_walls_hide_bounds_in_all_directions :: proc() {
}
    // rust: for axis in 0..3 {
    // rust: for sign in [-1.0, 1.0] {
    // rust: let mut min = [-2.0; 3];
    // rust: let mut max = [2.0; 3];
    // rust: min[axis] = if sign > 0.0 { 8.0 } else { -10.0 };
    // rust: max[axis] = if sign > 0.0 { 10.0 } else { -8.0 };
    // rust: let wall = if sign > 0.0 { 4 } else { -5 };
    // rust: assert!(Culler::new([0.0; 3], 1_000).occluded(min, max, |p| p[axis] == wall));
}
}
}

windows_slits_and_partial_walls_stay_visible :: proc() {
}
    // rust: let min = [8.0, -4.0, -4.0];
    // rust: let max = [10.0, 4.0, 4.0];
    // rust: for opening in 0..3 {
    // rust: assert!(!Culler::new([0.0; 3], 1_000).occluded(min, max, |p| {
    // rust: p[0] == 4
    // rust: && match opening {
    // rust: 0 => !(p[1] == 1 && p[2] == 1),
    // rust: 1 => p[1] != 1,
    // rust: _ => p[1] < 0,
}
    // rust: }));
}
    // rust: assert!(!Culler::new([0.0; 3], 1_000).occluded(min, max, |_| false));
}

budgets_are_shared_and_exhaustion_fails_open :: proc() {
}
    // rust: let culler = Culler::new([0.0; 3], 3);
    // rust: let calls = Cell::new(0);
    // rust: for _ in 0..2 {
    // rust: assert!(!culler.occluded([8.0; 3], [10.0; 3], |_| {
    // rust: calls.set(calls.get() + 1);
    // rust: false
    // rust: }));
}
    // rust: assert_eq!(calls.get(), 3);
    // rust: assert!(!Culler::new([0.0; 3], 0).occluded([8.0; 3], [10.0; 3], |_| panic!()));
    // This plane projects to four cells: four lookups prove it covered, while a
    // budget of one runs out first.
    // rust: assert!(Culler::new([0.0; 3], 4).occluded([8.0, -4.0, -4.0], [10.0, 4.0, 4.0], |_| true));
    // rust: assert!(!Culler::new([0.0; 3], 1).occluded([8.0, -4.0, -4.0], [10.0, 4.0, 4.0], |_| true));
}

camera_inside_invalid_and_target_crossing_wall_stay_visible :: proc() {
}
    // rust: let culler = Culler::new([0.0; 3], 1_000);
    // rust: assert!(!culler.occluded([-1.0; 3], [1.0; 3], |_| panic!()));
    // rust: assert!(!culler.occluded([f64::NAN; 3], [1.0; 3], |_| panic!()));
    // rust: assert!(!culler.occluded([2.0; 3], [1.0; 3], |_| panic!()));
    // rust: assert!(!culler.occluded([4.0, -1.0, -1.0], [8.0, 1.0, 1.0], |p| p[0] == 4));
    // rust: assert!(!Culler::new([f64::INFINITY; 3], 1_000).occluded([8.0; 3], [10.0; 3], |_| panic!()));
    // rust: assert!(!Culler::new([f64::MAX; 3], 1_000).occluded([-f64::MAX; 3], [-1.0; 3], |_| panic!()));
}
