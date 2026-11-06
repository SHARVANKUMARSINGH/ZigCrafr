//! Transpiled from Horizon Rust crate
package horizon_client_powder_snow

import "core:fmt"
import "core:mem"
import "core:math"

// `PowderSnowBlock.entityInside`, shared by living and other entities.
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, sweep_intersected_blocks},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

// Living entities must have their feet in snow; other entities only need
// their swept box to touch it. Preserve callback order and visit each cell once.
    // rust: pub fn contacts(
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: bounds: Aabb,
    // rust: living: bool,
    // rust: mut is_snow: impl FnMut(BlockPos) -> bool,
    // rust: ) -> Vec<BlockPos> {
    // rust: if living && !is_snow(BlockPos::containing(to)) {
    // rust: return Vec::new();
}
    // rust: let epsilon = f64::from(1.0e-5_f32);
    // rust: let bounds = bounds.deflate(Vec3::new(epsilon, epsilon, epsilon));
    // rust: let mut visited = std::collections::HashSet::new();
    // rust: let mut contacts = Vec::new();
    // rust: let _ = sweep_intersected_blocks(from, to, bounds, 1_000_000, |p, step| {
    // rust: if step >= 16 {
    // rust: return false;
}
    // rust: if visited.insert(p) && is_snow(p) {
    // rust: contacts.push(p);
}
    // rust: true
    // rust: });
    // rust: contacts
}

// The server's movement gate and Boolean/float draws, in Java order.
particle_velocity :: proc(known_movement: Vec3, random: ^impl RandomSource) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if (known_movement.x == 0.0 && known_movement.z == 0.0) || !random.next_boolean() {
    // rust: return None;
}
    // rust: let x = (random.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: let z = (random.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: Some([f64::from(x), f64::from(0.05_f32), f64::from(z)])
}

    // rust: mod tests {
//     use super::*;

swept_contacts_cover_nonliving_entities_and_gate_living_feet :: proc() {
}
    // rust: let from = Vec3::new(0.5, 0.0, 0.5);
    // rust: let to = Vec3::new(3.5, 0.0, 0.5);
    // rust: let bounds = Aabb::new(Vec3::new(3.25, 0.0, 0.25), Vec3::new(3.75, 0.5, 0.75));
    // rust: let snow = BlockPos::new(1, 0, 0);
    // rust: assert_eq!(contacts(from, to, bounds, false, |p| p == snow), vec![snow]);
    // rust: assert!(contacts(from, to, bounds, true, |p| p == snow).is_empty());
    // rust: let feet = BlockPos::new(3, 0, 0);
    // rust: assert_eq!(contacts(to, to, bounds, true, |p| p == feet), vec![feet]);
}
}
