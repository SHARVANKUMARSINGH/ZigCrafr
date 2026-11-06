//! Transpiled from Horizon Rust crate
package horizon_client_native_falling

import "core:fmt"
import "core:mem"
import "core:math"

// Falling blocks for native server mods (docs/native-mods.md, "Falling
// blocks"): a mod throws a block as a `FallingBlockEntity` that flies, lands
// and places itself (or drops as an item) as sand does. It acts where the
// world is simulated, in the level in place, which it names by its
// `dimension` (`minecraft:overworld`) as `native_set_block` does.
// use super::{FallingBlock, Game};
// use horizon_core::{geometry::Vec3, position::BlockPos};
// use horizon_world::registry::BlockStateId;

// The most falling blocks a level holds before `native_spawn_falling_block`
// refuses more: a mod's debris shouldn't take the server's tick with it.
    // rust: pub(super) const NATIVE_FALLING_MAX: usize = 1024;
// The largest speed a thrown block starts with, in blocks a tick on each
// axis (`Entity.setDeltaMovement` takes any; a packet's speed is cut to 3.9).
NATIVE_FALLING_MAX_SPEED :: 3.9

// What a mod's falling block does when it lands and when it hits.
NativeFalling :: struct {
    // `FallingBlockEntity.dropItem`: whether it drops as an item where it
    // can't be placed.
    drop_item: bool,
    // `FallingBlockEntity.hurtEntities`, at 2 a block fallen and at most 40,
    // an anvil's.
    hurts: bool,
}

    // rust: impl Default for NativeFalling {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: drop_item: true,
    // rust: hurts: false,
}
}
}

// `velocity` with each axis cut to the largest start speed; none for a
// value that isn't finite.
start_velocity :: proc(velocity: [f64; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: velocity.iter().all(|v| v.is_finite()).then(|| {
    // rust: let [x, y, z] =
    // rust: velocity.map(|v| v.clamp(-NATIVE_FALLING_MAX_SPEED, NATIVE_FALLING_MAX_SPEED));
    // rust: Vec3::new(x, y, z)
    // rust: })
}

    // rust: impl Game<'_> {
    // Throws a falling block of `state` from `pos` (its bottom centre) at
    // `velocity` (blocks a tick) in the level in place, `dimension`: it
    // falls, lands and places itself as sand does, or drops as an item
    // where it can't. The block at `pos` is left as it is: take it away first
    // with `native_set_block` to make a block fall out of the world. False,
    // with nothing thrown, on a client's copy of the world, for another
    // dimension, an air or unknown state, a chunk that isn't loaded, a value
    // that isn't finite, or with 1024 falling blocks in the level already.
    // Each axis of `velocity` is cut to 3.9. API 81.
    // rust: pub(super) fn native_spawn_falling_block(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: state: BlockStateId,
    // rust: pos: [f64; 3],
    // rust: velocity: [f64; 3],
    // rust: falling: NativeFalling,
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: || self.pack.assets.registry.state(state).is_none()
    // rust: || self.res.facts().is_air(state)
    // rust: || self.falling.len() >= NATIVE_FALLING_MAX
    // rust: || !pos.iter().all(|v| v.is_finite() && v.abs() <= 30_000_000.0)
    // rust: {
    // rust: return false;
}
    // rust: let Some(velocity) = start_velocity(velocity) else {
    // rust: return false;
}
    // rust: let cell = BlockPos::new(
    // rust: pos[0].floor() as i32,
    // rust: pos[1].floor() as i32,
    // rust: pos[2].floor() as i32,
    // rust: );
    // rust: if !self.world.chunks.contains_key(&(cell.x >> 4, cell.z >> 4)) {
    // rust: return false;
}
    // rust: let mut damage =
    // rust: horizon_client::falling_block::Damage::falling(&self.res.facts().get(state).name);
    // rust: if falling.hurts {
    // rust: damage.hurt_entities = true;
    // rust: damage.per_distance = 2.0;
    // rust: damage.max = 40;
}
    // rust: let at = Vec3::new(pos[0], pos[1], pos[2]);
    // rust: self.next_entity += 1;
    // rust: self.falling.push(FallingBlock {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id: self.next_entity,
    // rust: state,
    // rust: start_pos: cell,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: age: 0,
    // rust: no_gravity: false,
    // rust: drop_item: falling.drop_item,
    // rust: fall_distance: 0.0,
    // rust: stuck: Vec3::ZERO,
    // rust: damage,
    // rust: saved: None,
    // rust: portal: Default::default(),
    // rust: });
    // rust: true
}
}

    // rust: mod tests {
//     use super::*;

a_throw_is_cut_to_the_largest_speed_and_refuses_what_isnt_finite :: proc() {
}
    // rust: assert_eq!(
    // rust: start_velocity([0.5, 9.0, -9.0]),
    // rust: Some(Vec3::new(
    // rust: 0.5,
    // rust: NATIVE_FALLING_MAX_SPEED,
    // rust: -NATIVE_FALLING_MAX_SPEED
    // rust: ))
    // rust: );
    // rust: assert_eq!(start_velocity([0.0, f64::NAN, 0.0]), None);
    // rust: assert_eq!(start_velocity([f64::INFINITY, 0.0, 0.0]), None);
}
}
