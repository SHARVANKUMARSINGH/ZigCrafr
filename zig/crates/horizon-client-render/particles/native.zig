//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_native
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Opt-in, compiled particle behavior. The ordinary engine still owns the
//! particle, its sprite set, interpolation, rendering and total count limits.
// use super::{Particle, ParticleLevel, ParticleOptions};
// use std::fmt::Debug;

/// Requests made by one particle tick, submitted through normal spawn limits.
pub const ParticleUpdate = struct {
    /// An index in this particle's declared sprite set. Out-of-range is clamped.
    frame: ?usize,
    spawned: Vec<(ParticleOptions,
};

/// Owned behavior for a compiled native particle. Cloning a particle clones its
/// controller state. Do not retain world references; inspect `level` each tick.
    // rust: pub trait ParticleController: Clone + Debug + Send + Sync + 'static {
    /// Call `particle.advance_age()` for ordinary lifetime/interpolation, or
    /// explicitly maintain those fields for an overridden source tick.
pub fn tick(self: *Self, particle: *mut Particle, level: *ParticleLevel<'_>) P;
}

    // rust: pub(super) trait Controller: Debug + Send + Sync {
pub fn tick(self: *Self, particle: *mut Particle, level: *ParticleLevel<'_>) P;
pub fn clone_box(self: *Self) B;
}
    // rust: impl<T: ParticleController> Controller for T {
pub fn tick(self: *Self, particle: *mut Particle, level: *ParticleLevel<'_>) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ParticleController::tick(self, particle, level)
}
pub fn clone_box(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(self.clone())
}
}
    // rust: impl Clone for Box<dyn Controller> {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clone_box()
}
}

    // rust: mod tests {
//     use super::super::*;
//     use horizon_world::{
    // rust: DATA_VERSION,
    // rust: collision::CachedCollisionRegistry,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
pub const Moving = struct {};
    // rust: impl ParticleController for Moving {
pub fn tick(self: *Self, p: *mut Particle, _: *ParticleLevel<'_>) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if p.advance_age() {
    // rust: self.0 += 1;
    // rust: p.position[0] += f64::from(self.0);
}
    // rust: ParticleUpdate {
    // rust: frame: Some(self.0 as usize),
    // rust: ..Default::default()
}
}
}
pub fn engine() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut e = ParticleEngine::new(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: e.mod_sets.insert("example:orbit".into(), (0, None));
    // rust: e.set_sprites.push(vec![0, 1]);
    // rust: e.rects = vec![
    // rust: Some(Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16
    // rust: });
    // rust: 2
    // rust: ];
    // rust: e
}
pub fn controlled_particle_keeps_owned_motion_sprite_interpolation_and_expiry() void {
}
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::String("minecraft:air".into())]),
    // rust: ),
    // rust: ("defaults", Tag::compound([("minecraft:air", Tag::Int(0))])),
    // rust: ]))
    // rust: .unwrap();
    // rust: let cached = CachedCollisionRegistry::from_nbt(
    // rust: &Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::String("minecraft:air".into())]),
    // rust: ),
    // rust: ("shapes", Tag::List(vec![])),
    // rust: ("cached_shapes", Tag::IntArray(vec![-1])),
    // rust: ]),
    // rust: &registry,
    // rust: )
    // rust: .unwrap();
    // rust: let collision = BlockCollisionRegistry::new(std::sync::Arc::new(cached)).unwrap();
    // rust: let facts = BlockFacts {
    // rust: states: vec![],
    // rust: air: BlockStateId(0),
    // rust: woods: HashMap::new(),
}
    // rust: let world = World::new(BlockStateId(0), 0);
    // rust: let level = ParticleLevel {
    // rust: world: &world,
    // rust: facts: &facts,
    // rust: collision: &collision,
    // rust: player: None,
}
    // rust: let mut e = engine();
    // rust: let mut p = e
    // rust: .controlled("example:orbit", [0.0; 3], true, Moving(0))
    // rust: .unwrap();
    // rust: p.lifetime = 2;
    // rust: p.rgba[3] = 0.5;
    // rust: p.velocity = [99.0; 3]; // no vanilla drift may leak into the custom tick
    // rust: let mut copy = p.clone();
    // rust: e.tick_particle(&mut p, &level);
    // rust: e.tick_particle(&mut p, &level);
    // rust: e.tick_particle(&mut copy, &level);
    // rust: assert_eq!((p.position, p.previous), ([3.0, 0.0, 0.0], [1.0, 0.0, 0.0]));
    // rust: assert_eq!(copy.position, [1.0, 0.0, 0.0]); // controller state cloned independently
    // rust: assert!(matches!(p.sprite, Sprite::Index(1))); // clamped frame
    // rust: p.size = 0.1;
    // rust: e.particles.push(p.clone());
    // rust: let mut vertices = Vec::new();
    // rust: e.render(DVec3::ZERO, 0.0, 0.0, 0.5, &|_| 0, &mut vertices);
    // rust: assert_eq!(vertices.len(), 4);
    // rust: assert!(vertices.iter().all(
    // rust: |v| v.color >> 24 == 127 && v.layer & crate::gfx::TRANSLUCENT_PARTICLE_OVERLAY != 0
    // rust: ));
    // rust: e.particles[0].set_visible(false);
    // rust: vertices.clear();
    // rust: e.render(DVec3::ZERO, 0.0, 0.0, 0.5, &|_| 0, &mut vertices);
    // rust: assert!(vertices.is_empty());
    // rust: assert_eq!(e.particles[0].age, 2);
    // rust: e.pending.push(copy);
    // rust: e.reload(Path::new(""), &HashMap::new(), &HashSet::new());
    // rust: assert!(e.pending.is_empty());
    // rust: vertices.clear();
    // rust: e.render(DVec3::ZERO, 0.0, 0.0, 0.5, &|_| 0, &mut vertices);
    // rust: assert!(vertices.is_empty());
    // rust: e.tick_particle(&mut p, &level);
    // rust: assert!(p.removed);
    // rust: assert_eq!(p.position, [3.0, 0.0, 0.0]);
}
pub fn controlled_spawn_respects_distance_settings_and_declared_sprite_sets() void {
}
    // rust: let mut e = engine();
    // rust: assert!(
    // rust: e.controlled("example:missing", [0.0; 3], true, Moving(0))
    // rust: .is_none()
    // rust: );
    // rust: assert!(
    // rust: e.controlled("example:orbit", [33.0, 0.0, 0.0], true, Moving(0))
    // rust: .is_none()
    // rust: );
    // rust: assert!(
    // rust: e.controlled("example:orbit", [f64::NAN, 0.0, 0.0], true, Moving(0))
    // rust: .is_none()
    // rust: );
    // rust: assert!(
    // rust: e.controlled("example:orbit", [32.0, 0.0, 0.0], true, Moving(0))
    // rust: .is_some()
    // rust: );
    // rust: e.particle_level = 2;
    // rust: assert!(
    // rust: e.controlled("example:orbit", [0.0; 3], true, Moving(0))
    // rust: .is_none()
    // rust: );
}
}
