//! Transpiled from Horizon Rust crate
//! Module: horizon-client_entity_culling_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use horizon_client::voxel_occlusion::Culler;

pub fn vertex(pos: [f32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vertex {
    // rust: pos,
    // rust: uv: [0.0; 2],
    // rust: layer: 0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
}
}

/// `Entity.setViewScale`: the entity distance option times the render
/// distance's boost — 1 at eight chunks, 1.5 at twelve, 2.5 at twenty.
pub fn view_scale_follows_the_render_distance() void {
}
    // rust: assert_eq!(entity_view_scale(4, 1.0), 1.0);
    // rust: assert_eq!(entity_view_scale(8, 1.0), 1.0);
    // rust: assert_eq!(entity_view_scale(12, 1.0), 1.5);
    // rust: assert_eq!(entity_view_scale(20, 1.0), 2.5);
    // rust: assert_eq!(entity_view_scale(32, 1.0), 2.5);
    // rust: assert_eq!(entity_view_scale(12, 0.5), 0.75);
}

/// `Entity.shouldRenderAtSqrDistance`: a chicken's box (0.4 by 0.7 by
/// 0.4) is drawn up to 48 blocks away at the vanilla defaults.
pub fn small_mobs_use_the_mean_edge_for_render_distance() void {
}
    // rust: let range = default_range(glam::DVec3::new(0.4, 0.7, 0.4), entity_view_scale(12, 1.0));
    // rust: assert_eq!(range, 48.0);
}

/// Dropped items keep their 0.25-block box, so their default range scales
/// with the render distance but never exceeds the vanilla clamp.
pub fn dropped_items_use_their_small_render_box() void {
}
    // rust: let item = glam::DVec3::splat(0.25);
    // rust: assert_eq!(default_range(item, entity_view_scale(12, 1.0)), 24.0);
    // rust: assert_eq!(default_range(item, entity_view_scale(16, 1.0)), 32.0);
    // rust: assert_eq!(default_range(item, entity_view_scale(32, 1.0)), 40.0);
}

pub fn invalid_render_sizes_fail_open_to_one_block() void {
}
    // rust: let range = default_range(
    // rust: glam::DVec3::new(f64::NAN, 0.7, 0.4),
    // rust: entity_view_scale(12, 1.0),
    // rust: );
    // rust: assert_eq!(range, 96.0);
}

pub fn culling_decisions_only_hide_after_a_confirmed_occlusion() void {
}
    // rust: assert!(!EntityCullDecision::Bypass.hides_entity());
    // rust: assert!(!EntityCullDecision::CheckVertices.hides_entity());
    // rust: assert!(!EntityCullDecision::Pending.hides_entity());
    // rust: assert!(EntityCullDecision::Hidden.hides_entity());
}

pub fn coarse_aabb_and_mesh_paths_agree_for_a_complete_wall() void {
}
    // rust: let camera = [0.0; 3];
    // rust: let bounds = Aabb::new(Vec3::new(8.0, -1.0, -1.0), Vec3::new(10.0, 1.0, 1.0));
    // rust: let wall = |pos: [i32; 3]| pos[0] == 4;
    // rust: assert!(Culler::new(camera, 1_000).hidden_bounds(bounds, wall));

    // rust: let mesh = [vertex([8.0, -1.0, -1.0]), vertex([10.0, 1.0, 1.0])];
    // rust: assert!(Culler::new(camera, 1_000).hidden(&mesh, 0, wall));
}

pub fn partial_wall_and_budget_exhaustion_fail_open() void {
}
    // rust: let bounds = [8.0, -4.0, -4.0];
    // rust: let max = [10.0, 4.0, 4.0];
    // rust: let culler = Culler::new([0.0; 3], 1_000);
    // rust: assert!(!culler.occluded(bounds, max, |pos| {
    // rust: pos[0] == 4 && !(pos[1] == 1 && pos[2] == 1)
    // rust: }));

    // rust: let exhausted = Culler::new([0.0; 3], 1);
    // rust: assert!(!exhausted.occluded(bounds, max, |_| true));
}

pub fn mesh_culling_keeps_geometry_before_the_entity_prefix() void {
}
    // rust: let prefix = vertex([0.0; 3]);
    // rust: let mesh = [vertex([8.0, -1.0, -1.0]), vertex([10.0, 1.0, 1.0])];
    // rust: let mut vertices = vec![prefix];
    // rust: vertices.extend(mesh);
    // rust: let hidden = Culler::new([0.0; 3], 1_000).cull_vertices(&mut vertices, 1, |pos| pos[0] == 4);
    // rust: assert!(hidden);
    // rust: assert_eq!(vertices.len(), 1);
    // rust: assert_eq!(vertices[0].pos, prefix.pos);
}
