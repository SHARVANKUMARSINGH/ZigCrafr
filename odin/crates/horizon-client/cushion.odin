//! Transpiled from Horizon Rust crate
package horizon_client_cushion

import "core:fmt"
import "core:mem"
import "core:math"

// Cushion placement and support checks (`Cushion.canBePlacedAt`/`wouldSurviveAt`).
// use horizon_core::geometry::{Aabb, ShapeOp, Vec3, VoxelShape};

    // rust: pub trait World {
outline_bounds :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
collision_shapes :: proc(self: ^Self, bounds: Aabb) -> V {
    // Ported from Horizon
    return {}
}
suffocating :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
}

blocks_in :: proc(a: Aabb) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = (a.min_position(), a.max_position());
    // rust: let (x0, y0, z0) = (
    // rust: lo.x.floor() as i32,
    // rust: lo.y.floor() as i32,
    // rust: lo.z.floor() as i32,
    // rust: );
    // rust: let (x1, y1, z1) = (
    // rust: hi.x.floor() as i32,
    // rust: hi.y.floor() as i32,
    // rust: hi.z.floor() as i32,
    // rust: );
    // rust: (y0..=y1).flat_map(move |y| (z0..=z1).flat_map(move |z| (x0..=x1).map(move |x| [x, y, z])))
}

survives :: proc(world: ^impl World, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let anchor = Aabb::new(
    // rust: Vec3::new(lo.x, lo.y - 0.015625, lo.z),
    // rust: Vec3::new(hi.x.next_down(), lo.y, hi.z.next_down()),
    // rust: );
    // The extra eighth block expands the scan, not the intersection test.
    // rust: let supported = blocks_in(anchor.expand_towards(Vec3::new(0.0, -0.125, 0.0))).any(|p| {
    // rust: world
    // rust: .outline_bounds(p)
    // rust: .is_some_and(|shape| shape.intersects(anchor))
    // rust: });
    // rust: supported && !blocks_in(bounds.next_deflated()).all(|p| world.suffocating(p))
}

can_place :: proc(world: ^impl World, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !survives(world, bounds) {
    // rust: return false;
}
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let slab = Aabb::new(lo, Vec3::new(hi.x, lo.y + 0.015625, hi.z)).next_deflated();
    // rust: let Ok(mut remaining) = VoxelShape::from_box(slab) else {
    // rust: return false;
}
    // rust: for shape in world.collision_shapes(slab) {
    // rust: let Ok(next) = remaining.join(&shape, ShapeOp::ONLY_FIRST) else {
    // rust: return false;
}
    // rust: remaining = next;
    // rust: if remaining.is_empty() {
    // rust: return false;
}
}
    // rust: true
}
