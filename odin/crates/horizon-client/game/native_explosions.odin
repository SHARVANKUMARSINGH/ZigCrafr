//! Transpiled from Horizon Rust crate
package horizon_client_native_explosions

import "core:fmt"
import "core:mem"
import "core:math"

// Explosions for native server mods (docs/native-mods.md, "Explosions"): a mod
// sets one off as `Level.explode` does, in the level in place, which it names
// by its `dimension` (`minecraft:overworld`) as `native_set_block` does.
// use super::{Game, explosion::BlockInteraction};

// The largest radius `native_explode` takes. A blast's cost grows with its
// radius (its 1352 rays walk `radius * 1.3` blocks at most); vanilla's
// largest is the wither's charged spawn, 7.
    // rust: pub(super) const NATIVE_EXPLOSION_MAX_RADIUS: f32 = 32.0;

// What a mod's blast does to blocks (`Level.ExplosionInteraction`). Built by
// mods only.
    // rust: pub(super) enum NativeBlast {
    // Blocks stay; entities are hurt and pushed (`ExplosionInteraction.NONE`).
    // rust: Keep,
    // Blocks break and drop by the `block_explosion_drop_decay` rule
    // (`ExplosionInteraction.BLOCK`).
    // rust: Block,
    // Blocks break and drop by the `tnt_explosion_drop_decay` rule
    // (`ExplosionInteraction.TNT`).
    // rust: Tnt,
}

// Whether `native_explode` takes this centre and radius.
blast_ok :: proc(center: [f64; 3], radius: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: center
    // rust: .into_iter()
    // rust: .all(|v| v.is_finite() && v.abs() <= 30_000_000.0)
    // rust: && radius.is_finite()
    // rust: && radius > 0.0
    // rust: && radius <= NATIVE_EXPLOSION_MAX_RADIUS
}

    // rust: impl Game<'_> {
    // Explodes at `center` in the level in place, `dimension`, as
    // `Level.explode(null, x, y, z, radius, fire, interaction)` does: the
    // blocks it reaches break (`native_explosion_detonate` sees them first),
    // entities are hurt and pushed, `fire` lights a third of the air above
    // solid blocks, and everyone near hears and sees it. False, with nothing
    // done, on a client's copy of the world, for another dimension, a chunk
    // that isn't loaded, or a radius that isn't in `0 < radius <= 32`. Call
    // it from a server hook; a blast inside `native_explosion_detonate`
    // starts that hook again. API 66.
    // rust: pub(super) fn native_explode(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: fire: bool,
    // rust: blast: NativeBlast,
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: || !blast_ok(center, radius)
    // rust: {
    // rust: return false;
}
    // rust: let chunk = (
    // rust: (center[0].floor() as i32) >> 4,
    // rust: (center[2].floor() as i32) >> 4,
    // rust: );
    // rust: if !self.world.chunks.contains_key(&chunk) {
    // rust: return false;
}
    // rust: let interaction = match blast {
    // rust: NativeBlast::Keep => BlockInteraction::Keep,
    // rust: NativeBlast::Block => self.destroy_type("block_explosion_drop_decay"),
    // rust: NativeBlast::Tnt => self.destroy_type("tnt_explosion_drop_decay"),
}
        // `Level.explode(null, ...)`: no source. Called from inside another
        // blast (`native_explosion_detonate`), it must not take that blast's
        // source, owner or flags, and that blast gets them back after.
    // rust: let outer = self.take_blast_state();
    // rust: let done = self
    // rust: .server_explode(center, radius, interaction, fire)
    // rust: .is_ok();
    // rust: self.restore_blast_state(outer);
    // rust: done
}

    // The blast going off now, cleared to a sourceless one.
take_blast_state :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let c = &mut self.combat;
    // rust: BlastState {
    // rust: source: c.explosion_source.take(),
    // rust: cause: c.explosion_cause.take(),
    // rust: source_named: std::mem::take(&mut c.explosion_source_named),
    // rust: in_water: std::mem::take(&mut c.explosion_in_water),
    // rust: hive_emptying: std::mem::take(&mut c.hive_emptying_blast),
    // rust: rail_proof: std::mem::take(&mut c.rail_proof_blast),
    // rust: owner: c.explosion_owner.take(),
}
}

    // Puts back what `take_blast_state` cleared.
restore_blast_state :: proc(self: ^Self, s: BlastState) {
}
    // rust: let c = &mut self.combat;
    // rust: c.explosion_source = s.source;
    // rust: c.explosion_cause = s.cause;
    // rust: c.explosion_source_named = s.source_named;
    // rust: c.explosion_in_water = s.in_water;
    // rust: c.hive_emptying_blast = s.hive_emptying;
    // rust: c.rail_proof_blast = s.rail_proof;
    // rust: c.explosion_owner = s.owner;
}
}

// The fields of `CombatTracker` that describe the blast going off now.
BlastState :: struct {
    source: Maybe(u32),
    cause: Maybe(horizon_client::advancements::EntityView),
    source_named: bool,
    in_water: bool,
    hive_emptying: bool,
    rail_proof: bool,
    owner: Maybe(u32),
}

    // rust: mod tests {
//     use super::*;

a_blast_needs_a_finite_centre_and_a_radius_in_range :: proc() {
}
    // rust: assert!(blast_ok([0.5, 64.0, 0.5], 4.0));
    // rust: assert!(blast_ok([0.5, 64.0, 0.5], NATIVE_EXPLOSION_MAX_RADIUS));
    // rust: assert!(!blast_ok([0.5, 64.0, 0.5], 0.0));
    // rust: assert!(!blast_ok([0.5, 64.0, 0.5], -1.0));
    // rust: assert!(!blast_ok([0.5, 64.0, 0.5], 33.0));
    // rust: assert!(!blast_ok([0.5, 64.0, 0.5], f32::NAN));
    // rust: assert!(!blast_ok([f64::INFINITY, 64.0, 0.5], 4.0));
    // rust: assert!(!blast_ok([0.5, 64.0, 4.0e7], 4.0));
}
}
