//! Transpiled from Horizon Rust crate
//! Module: horizon-client_level_particles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Level events whose client handler (`LevelEventHandler`) spawns particles
//! on a block: bone meal's growth (1505), dragon egg teleportation (2015), a
//! consumable's teleport (2017), an enderman's (2018), electric sparks (3002),
//! waxing (3003), wax off (3004) and scraping (3005), plus the smoke, drips,
//! egg and dragon fireball particles of 1501, 1502, 1504, 2006, 2009, 2012
//! and 3009.
// use super::Game;
// use horizon_client::items::ItemStack;
// use horizon_client::particles::{self, ParticleOptions, ParticleType};
// use horizon_core::{geometry::trig, position::BlockPos, random::RandomSource};
// use horizon_world::level::LevelEvent;
// use horizon_world::registry::BlockStateId;

    // rust: impl Game<'_> {
    // rust: pub(super) fn dragon_egg_particles(&mut self, pos: [i32; 3], data: i32) {
    // rust: self.particles.block_teleportation(pos, data, [16, 8, 16]);
}
    /// Event 2016: `Shulker.teleportSomewhere`'s particles between the
    /// shell's old and new cells.
    // rust: pub(super) fn shulker_teleport_particles(&mut self, pos: [i32; 3], data: i32) {
    // rust: self.particles.block_teleportation(pos, data, [8, 8, 8]);
}
    /// Event 2017: `TeleportRandomlyConsumeEffect`'s directional particles.
    // rust: pub(super) fn consume_teleport_particles(&mut self, pos: [i32; 3], data: i32) {
    // rust: self.particles
    // rust: .block_teleportation(pos, data, [127, 127, 127]);
}
    /// Event 2018: an enderman's portal trail.
    // rust: pub(super) fn enderman_teleport_particles(&mut self, pos: [i32; 3], data: i32) {
    // rust: self.particles
    // rust: .enderman_teleportation(pos, data, self.settings.particles);
}
    /// `LevelEventHandler.levelEvent` 3002 to 3005, drawing from the client
    /// level's random.
    // rust: pub(super) fn block_particle_event(&mut self, id: i32, pos: BlockPos, data: i32) {
    // rust: let ty = match id {
    // rust: 3002 => ParticleType::ElectricSpark,
    // rust: 3003 => ParticleType::WaxOn,
    // rust: 3004 => ParticleType::WaxOff,
    // rust: 3005 => ParticleType::Scrape,
    // rust: _ => return,
}
    // rust: let p = [pos.x, pos.y, pos.z];
    // rust: let mut spawned = Vec::new();
    // rust: let random = self.particles.level_random();
        // 3002 with an axis: a lightning rod; otherwise copper cleaned by lightning.
    // rust: match usize::try_from(data) {
    // rust: Ok(axis) if id == 3002 && axis < 3 => {
    // rust: particles::along_axis(random, axis, p, (10, 19), |p, v| spawned.push((p, v)));
}
    // rust: _ => particles::on_block_faces(random, p, |p, v| spawned.push((p, v))),
}
    // rust: let options = ParticleOptions::simple(ty);
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    /// `BoneMealItem.addGrowthParticles` (event 1505, `count` the data):
    /// happy villager sparks over a spreading block's neighbourhood (grass,
    /// nylium, netherrack, moss) or water, or inside a growing block.
    // rust: pub(super) fn growth_particles(&mut self, pos: BlockPos, count: i32) {
    // rust: let p = [pos.x, pos.y, pos.z];
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let facts = self.res.facts();
        // ParticleUtils.spawnParticles(level, pos, count, xzSpread, ySpread,
        // allowFloatingParticles, particle).
    // rust: let (at, count, xz, height, floating) = match self.res.behaviours().bone_meal_spreads(state)
    // rust: {
    // rust: Some(spreads) => {
                // BonemealableBlock.getParticlePos: below for rooted dirt
                // (its hanging roots) and mangrove leaves (their propagule).
    // rust: let at = match &*facts.get(state).name {
    // rust: "minecraft:rooted_dirt" | "minecraft:mangrove_leaves" => [p[0], p[1] - 1, p[2]],
    // rust: _ => p,
}
    // rust: if spreads {
    // rust: (at, count * 3, 3.0, 1.0, false)
    // rust: } else {
                    // ParticleUtils.spawnParticleInBlock: up to the
                    // block's shape (a full block when air).
    // rust: (at, count, 0.5, self.block_shape_top(at), true)
}
}
    // rust: None if &*facts.get(state).name == "minecraft:water" => (p, count * 3, 3.0, 1.0, false),
            // A mod block the level answered bone meal for: the port knows no
            // `BonemealableBlock.Type` for it, and vanilla's `GROWER` is the
            // one a block growing itself has, so the sparks stay inside it
            // rather than spreading over its neighbours.
    // rust: None if !facts.get(state).name.starts_with("minecraft:") => {
    // rust: (p, count, 0.5, self.block_shape_top(p), true)
}
    // rust: None => return,
}
    // rust: self.spawn_particles(at, count, xz, height, floating, ParticleType::HappyVillager);
}
    /// `BlockState.getShape(..).max(Y)` of the block at `at`, 1.0 for air.
pub fn block_shape_top(self: *Self, at: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let facts = self.res.facts();
    // rust: let inside = self.world.block(at[0], at[1], at[2]);
    // rust: if facts.is_air(inside) {
    // rust: 1.0
    // rust: } else {
    // rust: facts
    // rust: .get(inside)
    // rust: .outline
    // rust: .iter()
    // rust: .map(|b| b[4])
    // rust: .fold(0.0, f64::max)
}
}
    /// `ParticleUtils.spawnParticles`: `count` slow particles spread over
    /// `xz` blocks around `at` and `height` up, only above solid ground
    /// unless floating ones are allowed.
    // rust: fn spawn_particles(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: count: i32,
    // rust: xz: f64,
    // rust: height: f64,
    // rust: floating: bool,
    // rust: ty: ParticleType,
    // rust: ) {
    // rust: let options = ParticleOptions::simple(ty);
    // rust: for _ in 0..count.max(0) {
    // rust: let r = self.particles.level_random();
    // rust: let v = [0.0; 3].map(|_: f64| r.next_gaussian() * 0.02);
    // rust: let start = 0.5 - xz;
    // rust: let x = f64::from(at[0]) + start + r.next_double() * xz * 2.0;
    // rust: let y = f64::from(at[1]) + r.next_double() * height;
    // rust: let z = f64::from(at[2]) + start + r.next_double() * xz * 2.0;
    // rust: let below = [x.floor() as i32, y.floor() as i32 - 1, z.floor() as i32];
    // rust: if floating
    // rust: || !self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(below[0], below[1], below[2]))
    // rust: {
    // rust: self.particles.add(&options, [x, y, z], v);
}
}
}
    /// `LevelEventHandler` 2012 (a turtle egg laid on sand):
    /// `ParticleUtils.spawnParticleInBlock` with happy villager sparks.
    // rust: pub(super) fn turtle_egg_particles(&mut self, pos: BlockPos, count: i32) {
    // rust: let at = [pos.x, pos.y, pos.z];
    // rust: let height = self.block_shape_top(at);
    // rust: self.spawn_particles(at, count, 0.5, height, true, ParticleType::HappyVillager);
}
    /// `LevelEventHandler` 3009 (a sniffer egg cracking on moss):
    /// `spawnParticlesOnBlockFaces(.., EGG_CRACK, UniformInt.of(3, 6))`.
    // rust: pub(super) fn sniffer_egg_crack_particles(&mut self, pos: BlockPos) {
    // rust: let mut spawned = Vec::new();
    // rust: particles::on_block_faces_between(
    // rust: self.particles.level_random(),
    // rust: [pos.x, pos.y, pos.z],
    // rust: 3,
    // rust: 6,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: let options = ParticleOptions::simple(ParticleType::EggCrack);
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    /// `LevelEventHandler` 1501 (lava put out) and 2009 (a wet sponge dried):
    /// eight puffs just above the block, drawn after the sound.
    // rust: pub(super) fn puffs_above_block(&mut self, pos: BlockPos, ty: ParticleType) {
    // rust: let options = ParticleOptions::simple(ty);
    // rust: for _ in 0..8 {
    // rust: let r = self.particles.level_random();
    // rust: let x = f64::from(pos.x) + r.next_double();
    // rust: let z = f64::from(pos.z) + r.next_double();
    // rust: self.particles
    // rust: .add(&options, [x, f64::from(pos.y) + 1.2, z], [0.0; 3]);
}
}
    /// `LevelEventHandler` 1502 (a redstone torch burning out): five smoke
    /// puffs inside the block, drawn after the sound.
    // rust: pub(super) fn torch_burnout_smoke(&mut self, pos: BlockPos) {
    // rust: let options = ParticleOptions::simple(ParticleType::Smoke);
    // rust: for _ in 0..5 {
    // rust: let r = self.particles.level_random();
    // rust: let x = f64::from(pos.x) + r.next_double() * 0.6 + 0.2;
    // rust: let y = f64::from(pos.y) + r.next_double() * 0.6 + 0.2;
    // rust: let z = f64::from(pos.z) + r.next_double() * 0.6 + 0.2;
    // rust: self.particles.add(&options, [x, y, z], [0.0; 3]);
}
}
    /// `LevelEventHandler` 1503: smoke on the inserted eye.
    // rust: pub(super) fn end_portal_frame_smoke(&mut self, pos: BlockPos) {
    // rust: let options = ParticleOptions::simple(ParticleType::Smoke);
    // rust: for _ in 0..16 {
    // rust: let r = self.particles.level_random();
    // rust: let x = f64::from(pos.x) + (5.0 + r.next_double() * 6.0) / 16.0;
    // rust: let z = f64::from(pos.z) + (5.0 + r.next_double() * 6.0) / 16.0;
    // rust: self.particles
    // rust: .add(&options, [x, f64::from(pos.y) + 0.8125, z], [0.0; 3]);
}
}
    /// `LevelEventHandler` 2006 (`DragonFireball.onHit`): 200 dragon breath
    /// particles thrown outwards, then the explosion sound when `data` is 1.
    // rust: pub(super) fn dragon_fireball_burst(&mut self, pos: BlockPos, data: i32) {
    // rust: for _ in 0..200 {
    // rust: let r = self.particles.level_random();
    // rust: let dist = r.next_float() * 4.0;
    // rust: let angle = r.next_float() * std::f32::consts::TAU;
    // rust: let vx = f64::from(trig::cos(f64::from(angle)) * dist);
    // rust: let vy = 0.01 + r.next_double() * 0.5;
    // rust: let vz = f64::from(trig::sin(f64::from(angle)) * dist);
    // rust: let options = ParticleOptions {
    // rust: scale: dist,
    // rust: ..ParticleOptions::simple(ParticleType::DragonBreath)
}
    // rust: self.particles.add(
    // rust: &options,
    // rust: [
    // rust: f64::from(pos.x) + vx * 0.1,
    // rust: f64::from(pos.y) + 0.3,
    // rust: f64::from(pos.z) + vz * 0.1,
    // rust: ],
    // rust: [vx, vy, vz],
    // rust: );
}
    // rust: if data == 1 {
    // rust: let at = [pos.x, pos.y, pos.z].map(|v| f64::from(v) + 0.5);
    // rust: let pitch = self.world.random.next_float() * 0.1 + 0.9;
    // rust: self.audio.play(
    // rust: "minecraft:entity.dragon_fireball.explode",
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
}
    /// `SpeleothemBlock.isStalactite`: a speleothem whose tip points down.
pub fn is_stalactite(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.res.facts().get(state).has_class("SpeleothemBlock")
    // rust: && self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("vertical_direction"))
    // rust: .is_some_and(|d| d == "down")
}
    /// `LevelEventHandler` 1504: `PointedDripstoneBlock.spawnDripParticle` at
    /// the tip `pos`. The fluid above the stalactite's root picks the drip;
    /// with none, the dimension's default (lava in the Nether).
    // rust: pub(super) fn dripstone_drip_particle(&mut self, pos: BlockPos) {
    // rust: let tip_state = self.world.block(pos.x, pos.y, pos.z);
    // rust: if !self.is_stalactite(tip_state) {
    // rust: return;
}
        // findRootBlock: up through the same stalactite, at most 11 steps.
    // rust: let tip_name = self.res.facts().get(tip_state).name.clone();
    // rust: let mut root = None;
    // rust: for step in 1..11 {
    // rust: let y = pos.y + step;
    // rust: if !(self.world.bottom_y()..self.world.top_y()).contains(&y) {
    // rust: break;
}
    // rust: let state = self.world.block(pos.x, y, pos.z);
    // rust: if self.res.facts().get(state).name != tip_name {
    // rust: root = Some(y);
    // rust: break;
}
    // rust: if !self.is_stalactite(state) {
    // rust: break;
}
}
    // rust: let Some(root_y) = root else {
    // rust: return;
}
    // rust: let above = self.world.block(pos.x, root_y + 1, pos.z);
    // rust: let above_facts = self.res.facts().get(above);
    // rust: let nether = self.dim == super::Dim::Nether;
    // rust: let fluid = if &*above_facts.name == "minecraft:mud" && !nether {
    // rust: horizon_client::blocks::Fluid::Water
    // rust: } else {
    // rust: above_facts.fluid
}
    // rust: let ty = match fluid {
    // rust: horizon_client::blocks::Fluid::Water => ParticleType::DrippingDripstoneWater,
    // rust: horizon_client::blocks::Fluid::Lava => ParticleType::DrippingDripstoneLava,
    // rust: horizon_client::blocks::Fluid::None if nether => ParticleType::DrippingDripstoneLava,
    // rust: horizon_client::blocks::Fluid::None => ParticleType::DrippingDripstoneWater,
}
    // rust: let offset = self
    // rust: .pack
    // rust: .context
    // rust: .tables
    // rust: .offset(tip_state, pos.x, pos.z)
    // rust: .unwrap_or([0.0; 3]);
        // The tip shape starts 5/16 up; the particle sits a pixel below that.
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ty),
    // rust: [
    // rust: f64::from(pos.x) + 0.5 + offset[0],
    // rust: f64::from(pos.y) + 5.0 / 16.0 - 0.0625,
    // rust: f64::from(pos.z) + 0.5 + offset[2],
    // rust: ],
    // rust: [0.0; 3],
    // rust: );
}
    /// `ServerLevel.globalLevelEvent`: heard by every player on the server
    /// (an end portal opening, the dragon's death roar): here, and sent to
    /// every guest whatever their dimension.
    // rust: pub(super) fn global_level_event(&mut self, id: i32, pos: [i32; 3], data: i32) {
        // ServerLevel.globalLevelEvent: without global_sound_events it is a
        // plain level event, which the client has no sound for (1023, 1028
        // and 1038 are only in `LevelEventHandler.globalLevelEvent`).
    // rust: if !self.ui.rules.bool("global_sound_events") {
    // rust: return;
}
    // rust: self.global_level_event_sound(id, pos);
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_global_events.push((id, pos, data));
}
}
    /// `LevelEventHandler.globalLevelEvent`: the sound two blocks from the
    /// camera towards the event, so it is heard from anywhere.
    // rust: pub(super) fn global_level_event_sound(&mut self, id: i32, pos: [i32; 3]) {
    // rust: let (sound, volume) = match id {
    // rust: 1023 => ("minecraft:entity.wither.spawn", 1.0),
    // rust: 1028 => ("minecraft:entity.ender_dragon.death", 5.0),
    // rust: 1038 => ("minecraft:block.end_portal.spawn", 1.0),
    // rust: _ => return,
}
    // rust: let at = self.eye_position().map(|eye| {
    // rust: let d = [
    // rust: f64::from(pos[0]) + 0.5 - eye[0],
    // rust: f64::from(pos[1]) + 0.5 - eye[1],
    // rust: f64::from(pos[2]) + 0.5 - eye[2],
    // rust: ];
    // rust: let length = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if length < 1.0e-4 {
    // rust: return eye;
}
    // rust: [0, 1, 2].map(|k| eye[k] + d[k] / length * 2.0)
    // rust: });
        // Each guest plays it from the global packet.
    // rust: self.audio.play_unshared(sound, at, volume, 1.0);
}
    /// `ClientLevel.addBreakingBlockEffects`: the block's hit sound (only for
    /// `play_sound`) and one crumb on the face being mined; nothing for air.
    // rust: pub(super) fn breaking_block_effects(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: play_sound: bool,
    // rust: ) {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.res.facts().is_air(state) {
    // rust: return;
}
    // rust: if play_sound {
    // rust: let sounds = self.res.facts().get(state).sounds.clone();
            // Each guest plays it from the level event itself.
    // rust: self.audio.play_unshared(
    // rust: &sounds.hit,
    // rust: Some(pos.map(|v| f64::from(v) + 0.5)),
    // rust: (sounds.volume + 1.0) / 8.0,
    // rust: sounds.pitch * 0.5,
    // rust: );
}
    // rust: self.crack_particle(pos, face, state);
}
    /// `LevelEventHandler.potionSplashParticles` (2002 with `Effect`, 2007
    /// with `InstantEffect`): eight splash potion crumbs, and a hundred
    /// spell particles in the potion's colour `data`, flung out in a disc.
    // rust: pub(super) fn potion_splash_particles(&mut self, pos: BlockPos, data: i32, instant: bool) {
    // rust: let ty = if instant {
    // rust: ParticleType::InstantEffect
    // rust: } else {
    // rust: ParticleType::Effect
}
        // Vec3.atBottomCenterOf.
    // rust: let at = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y),
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: let crumb = self.item_particle(&ItemStack::new("minecraft:splash_potion", 1));
    // rust: let r = self.particles.level_random();
    // rust: let crumbs: Vec<[f64; 3]> = (0..8)
    // rust: .map(|_| {
    // rust: [
    // rust: r.next_gaussian() * 0.15,
    // rust: r.next_double() * 0.2,
    // rust: r.next_gaussian() * 0.15,
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: for v in crumbs {
    // rust: self.particles.add(&crumb, at, v);
}
    // rust: let channel = |shift: i32| ((data >> shift) & 0xFF) as f32 / 255.0;
    // rust: let color = [channel(16), channel(8), channel(0)];
    // rust: for _ in 0..100 {
    // rust: let r = self.particles.level_random();
    // rust: let dist = r.next_double() * 4.0;
    // rust: let angle = r.next_double() * std::f64::consts::PI * 2.0;
    // rust: let velocity = [
    // rust: angle.cos() * dist,
    // rust: 0.01 + r.next_double() * 0.5,
    // rust: angle.sin() * dist,
    // rust: ];
    // rust: let brightness = 0.75 + r.next_float() * 0.25;
    // rust: let options = ParticleOptions {
    // rust: color: [
    // rust: color[0] * brightness,
    // rust: color[1] * brightness,
    // rust: color[2] * brightness,
    // rust: 1.0,
    // rust: ],
    // rust: scale: dist as f32,
    // rust: ..ParticleOptions::simple(ty)
}
    // rust: self.particles.add(
    // rust: &options,
    // rust: [
    // rust: at[0] + velocity[0] * 0.1,
    // rust: at[1] + 0.3,
    // rust: at[2] + velocity[2] * 0.1,
    // rust: ],
    // rust: velocity,
    // rust: );
}
}
    /// Queue and play level event `id` at `pos` (`Level.levelEvent`).
    // rust: pub(super) fn level_event_at(&mut self, id: i32, pos: [i32; 3], data: i32) {
    // rust: self.level_events.push(LevelEvent::LevelEvent {
    // rust: id,
    // rust: pos: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: data,
    // rust: });
    // rust: let _ = self.process_level_events();
}
}
