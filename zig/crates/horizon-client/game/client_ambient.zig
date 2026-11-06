//! Transpiled from Horizon Rust crate
//! Module: horizon-client_client_ambient
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The window's own ambient effects of entities, which a client makes for
//! itself (`level().isClientSide()` branches): endermen's and endermites'
//! portal particles, blazes' smoke and burn, eyes of ender's trail. They run
//! on the game that has the window, following a server, never on
//! a server: nothing of them goes over the network.
// use super::Game;
// use horizon_client::blocks::RenderShape;
// use horizon_client::mobs::{MobEvent, ambient};
// use horizon_client::motion::{LAVA, WATER};
// use horizon_client::particles::{ParticleEngine, ParticleOptions, ParticleType};
// use horizon_client::pose::Pose;
// use horizon_core::{geometry::Vec3, random::RandomSource};

    // rust: impl Game<'_> {
    // rust: pub(super) fn tick_client_ambient(&mut self) {
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: return;
}
        // A window simulating the world already runs `WitherBoss.aiStep`.
        // One following a server does not: `Level.addParticle` on the server
        // draws nothing, so the smoke, the powered effect and the charge
        // cloud have to be made here.
    // rust: let following = self.remote.is_some();
    // rust: let mut events = Vec::new();
    // rust: let random = self.particles.level_random();
    // rust: for m in self.mobs.iter_mut().filter(|m| !m.removed) {
    // rust: ambient::client_ai_step(m, &mut events);
    // rust: ambient::client_particles(m, random, &mut events);
    // rust: if following && m.species() == horizon_client::mobs::Species::Wither {
    // rust: horizon_client::mobs::wither::head_particles(m, random, &mut events);
}
}
    // rust: for event in events {
    // rust: match event {
    // rust: MobEvent::ParticleAt { kind, at, velocity } => {
    // rust: if let Some(ty) = ParticleType::from_name(kind) {
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ty), at, velocity);
}
}
    // rust: MobEvent::Particles { kind, at, count: 0 } => {
    // rust: if let Some(ty) = ParticleType::from_name(kind) {
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ty), at, [0.0; 3]);
}
}
    // rust: MobEvent::ParticleColored {
    // rust: at,
    // rust: color: [r, g, b],
    // rust: } => {
    // rust: self.particles.add(
    // rust: &ParticleOptions::colored(ParticleType::EntityEffect, [r, g, b, 1.0]),
    // rust: at,
    // rust: [0.0; 3],
    // rust: );
}
                // Each guest of a LAN host makes its own.
    // rust: MobEvent::LocalSound(name, at, volume, pitch) => {
    // rust: self.audio
    // rust: .play_unshared(&format!("minecraft:{name}"), Some(at), volume, pitch)
}
    // rust: _ => {}
}
}
    // rust: self.eye_particles();
    // rust: self.panda_effects();
    // rust: self.sprint_dust();
    // rust: self.effect_swirls();
}

    /// `Entity.baseTick`'s `spawnSprintParticle` on a client: dust of the
    /// block under a sprinting player's feet streams back from them every
    /// tick, for the window's own player and for the other players it sees.
pub fn sprint_dust(self: *Self) void {
}
        // Each runner's feet, movement, supporting block, box width and index
        // in `mobs` (none for the window's own player).
    // rust: let mut runners: Vec<(Vec3, Vec3, Option<[i32; 3]>, f64, Option<usize>)> = Vec::new();
        // Entity.canSpawnSprintParticle.
    // rust: if let Some(p) = self.player.as_ref()
    // rust: && p.sprinting
    // rust: && !p.spectator
    // rust: && p.pose != Pose::Crouching
    // rust: && !p.health.dead_or_dying()
    // rust: && !p.fluids.was_touching_water
    // rust: && !p.is_in_lava()
    // rust: && p.fluid_height(WATER) <= 0.0
    // rust: && p.fluid_height(LAVA) <= 0.0
    // rust: {
    // rust: let support = p.ground.supporting_block.map(|b| [b.x, b.y, b.z]);
    // rust: runners.push((p.position, p.velocity, support, f64::from(0.6f32), None));
}
        // IronGolem.canSpawnSprintParticle replaces the sprinting test: one
        // tick in five while it moves at all, in water or not, drawn from the
        // golem's own random as its client copy's Entity.baseTick does.
    // rust: for (i, m) in self.mobs.iter_mut().enumerate() {
    // rust: if &*m.kind.id != "minecraft:iron_golem" {
    // rust: continue;
}
    // rust: let movement = m.position.subtract(m.previous);
    // rust: let moving =
    // rust: movement.x * movement.x + movement.z * movement.z > f64::from(2.5000003E-7_f32);
    // rust: if moving && m.random.next_int_bound(5).unwrap_or(1) == 0 {
    // rust: runners.push((m.position, movement, None, f64::from(m.width()), Some(i)));
}
}
    // rust: for (i, m) in self.mobs.iter().enumerate() {
            // Another player's fluids aren't known here: none where they stand.
    // rust: let feet = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: if &*m.kind.id == "minecraft:iron_golem" {
    // rust: continue;
}
    // rust: let movement = m.position.subtract(m.previous);
    // rust: if m.extra.sprinting
    // rust: && !m.extra.crouching
    // rust: && m.alive()
    // rust: && &*m.kind.id == "minecraft:player"
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(feet[0], feet[1], feet[2]))
    // rust: .fluid_level
    // rust: == 0
    // rust: {
    // rust: runners.push((m.position, movement, None, f64::from(0.6f32), Some(i)));
}
}
    // rust: for (position, movement, support, width, mob) in runners {
    // rust: self.sprint_particle(position, movement, support, width, |game| {
                // this.random: a mob's own, so one walking out of sight leaves
                // the particles' random alone. The window's player has none of
                // its own here; the particles' random stands in for it.
    // rust: let r = match mob {
    // rust: Some(i) => &mut game.mobs.get_mut(i)?.random,
    // rust: None => game.particles.random(),
}
    // rust: Some((r.next_double(), r.next_double()))
    // rust: });
}
}

    /// `Entity.spawnSprintParticle`: one dust crumb of the block under the
    /// feet at `position` (`getOnPosLegacy`), thrown back against `movement`,
    /// unless that block is invisible. `offsets` draws the two random
    /// `nextDouble`s for x and z (the entity's random in vanilla).
    // rust: pub(super) fn sprint_particle(
    // rust: &mut self,
    // rust: position: Vec3,
    // rust: movement: Vec3,
    // rust: support: Option<[i32; 3]>,
    // rust: width: f64,
    // rust: offsets: impl FnOnce(&mut Self) -> Option<(f64, f64)>,
    // rust: ) {
        // Entity.getOnPosLegacy: getOnPos(0.2).
    // rust: let below = (position.y - f64::from(0.2f32)).floor() as i32;
    // rust: let tall = |game: &Self, s: [i32; 3]| {
    // rust: let name = game.block_name(s);
    // rust: [
    // rust: "minecraft:fences",
    // rust: "minecraft:walls",
    // rust: "minecraft:fence_gates",
    // rust: ]
    // rust: .iter()
    // rust: .any(|tag| game.block_in_tag(tag, &name))
}
    // rust: let at = match support {
    // rust: Some(s) if tall(self, s) => s,
    // rust: Some(s) => [s[0], below, s[2]],
    // rust: None => [position.x.floor() as i32, below, position.z.floor() as i32],
}
    // rust: let state = self.world.block(at[0], at[1], at[2]);
    // rust: if self.res.facts().get(state).render_shape == RenderShape::Invisible {
    // rust: return;
}
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, at) else {
    // rust: return;
}
    // rust: let Some((rx, rz)) = offsets(self) else {
    // rust: return;
}
    // rust: let mut x = position.x + (rx - 0.5) * width;
    // rust: let mut z = position.z + (rz - 0.5) * width;
        // Clamped into the block when the feet are in another column.
    // rust: if position.x.floor() as i32 != at[0] {
    // rust: x = x.clamp(f64::from(at[0]), f64::from(at[0]) + 1.0);
}
    // rust: if position.z.floor() as i32 != at[2] {
    // rust: z = z.clamp(f64::from(at[2]), f64::from(at[2]) + 1.0);
}
    // rust: self.particles.add(
    // rust: &ParticleOptions::block(ParticleType::Block, sprite, tint),
    // rust: [x, position.y + 0.1, z],
    // rust: [movement.x * -4.0, 1.5, movement.z * -4.0],
    // rust: );
}

    /// `LivingEntity.tickEffects` on a client: the swirls around an entity
    /// with visible effects, from the particles its synched data lists. The
    /// window's player has its own effects, a server's mobs and players the
    /// list the server sent, and the mobs and guests of a game in the frame
    /// theirs.
pub fn effect_swirls(self: *Self) void {
}
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let effects = &self.potions.effects.list;
    // rust: let list: Vec<_> = effects
    // rust: .iter()
    // rust: .filter(|e| e.visible)
    // rust: .filter_map(|e| effect_particle(e.id, e.ambient))
    // rust: .collect();
    // rust: let ambient = effects.iter().filter(|e| e.visible).all(|e| e.ambient);
    // rust: let invisible = self.own_invisible();
    // rust: let size = (
    // rust: f64::from(p.dimensions.width),
    // rust: f64::from(p.dimensions.height),
    // rust: );
    // rust: swirl(
    // rust: &mut self.particles,
    // rust: p.position,
    // rust: size,
    // rust: &list,
    // rust: ambient,
    // rust: invisible,
    // rust: );
}
    // rust: for m in self.mobs.iter() {
    // rust: if !m.alive() {
    // rust: continue;
}
    // rust: let size = (f64::from(m.width()), f64::from(m.height()));
    // rust: let invisible = m.invisible || m.has_effect("minecraft:invisibility");
    // rust: if m.extra.effect_particles.is_empty() {
                // A mob of this game: its own effects, visible and not ambient.
    // rust: if m.extra.effects.is_empty() {
    // rust: continue;
}
    // rust: let list: Vec<_> = m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .filter(|e| !m.extra.hidden_effects.contains(&e.0))
    // rust: .filter_map(|e| effect_particle(e.0, m.extra.ambient_effects.contains(&e.0)))
    // rust: .collect();
    // rust: swirl(
    // rust: &mut self.particles,
    // rust: m.position,
    // rust: size,
    // rust: &list,
    // rust: false,
    // rust: invisible,
    // rust: );
    // rust: } else {
    // rust: let list = &m.extra.effect_particles;
    // rust: let ambient = m.extra.effect_ambient;
    // rust: swirl(
    // rust: &mut self.particles,
    // rust: m.position,
    // rust: size,
    // rust: list,
    // rust: ambient,
    // rust: invisible,
    // rust: );
}
}
}
}

/// `MobEffect.particleFactory`: the omens have particles of their own, any
/// other effect an entity effect in its colour, faint when ambient.
    // rust: pub(super) fn effect_particle(effect: &str, ambient: bool) -> Option<ParticleOptions> {
    // rust: Some(match effect.trim_start_matches("minecraft:") {
    // rust: "trial_omen" => ParticleOptions::simple(ParticleType::TrialOmen),
    // rust: "raid_omen" => ParticleOptions::simple(ParticleType::RaidOmen),
    // rust: other => {
    // rust: let color = horizon_client::brewing::effect(other)?.color;
    // rust: let channel = |shift: u32| ((color >> shift) & 255) as f32 / 255.0;
            // MobEffect.AMBIENT_ALPHA is 38 of 255.
    // rust: let alpha = if ambient { 38.0 / 255.0 } else { 1.0 };
    // rust: ParticleOptions::colored(
    // rust: ParticleType::EntityEffect,
    // rust: [channel(16), channel(8), channel(0), alpha],
    // rust: )
}
    // rust: })
}

/// One tick of `LivingEntity.tickEffects`' client branch: a one in four
/// chance (one in fifteen while invisible, a fifth of either when all the
/// effects are ambient) of one of the particles at a random spot of the box.
    // rust: fn swirl(
    // rust: particles: &mut ParticleEngine,
    // rust: feet: Vec3,
    // rust: size: (f64, f64),
    // rust: list: &[ParticleOptions],
    // rust: ambient: bool,
    // rust: invisible: bool,
    // rust: ) {
    // rust: if list.is_empty() {
    // rust: return;
}
    // rust: let bound = if invisible { 15 } else { 4 } * if ambient { 5 } else { 1 };
    // rust: let r = particles.random();
    // rust: let Ok(0) = r.next_int_bound(bound) else {
    // rust: return;
}
    // Util.getRandom, then getRandomX(0.5), getRandomY and getRandomZ.
    // rust: let pick = r.next_int_bound(list.len() as i32).unwrap_or_default() as usize;
    // rust: let x = feet.x + size.0 * (2.0 * r.next_double() - 1.0) * 0.5;
    // rust: let y = feet.y + size.1 * r.next_double();
    // rust: let z = feet.z + size.0 * (2.0 * r.next_double() - 1.0) * 0.5;
    // rust: particles.add(&list[pick], [x, y, z], [1.0; 3]);
}
