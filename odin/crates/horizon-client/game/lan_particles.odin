//! Transpiled from Horizon Rust crate
package horizon_client_lan_particles

import "core:fmt"
import "core:mem"
import "core:math"

// Particles a server sends its players and its clients draw:
// `ClientboundLevelParticlesPacket` (`ServerLevel.sendParticles`, which
// `/particle` uses) and `ClientboundExplodePacket` (`ServerLevel.explode`).
// use super::{Game, lan::LanHost};
// use horizon_client::lan::hub::Hub;
// use horizon_client::particles::{ParticleOptions, ParticleType};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_protocol::{
    // rust: entity_data::{MOD_PARTICLE_ID, Particle, ParticleData, PositionSource},
    // rust: packets::play::{self, Clientbound as C},
}
// use horizon_world::registry::BlockStateId;

// A particle request awaiting delivery to players in its level.
    // rust: pub(super) struct QueuedParticle {
    // rust: pub dimension: &'static str,
    // rust: pub options: ParticleOptions,
    // rust: pub state: Option<BlockStateId>,
    // rust: pub at: [f64; 3],
    // rust: pub spread: [f64; 3],
    // Per-axis maximum speed used by the packet's ALTERNATIVE randomization.
    // rust: pub speed: [f64; 3],
    // rust: pub count: i32,
    // The packet's `RandomizationType` (0 DEFAULT, 1 ALTERNATIVE).
    // rust: pub randomization: i32,
}

// `PowderSnowBlock.entityInside`'s server roll. The branch and both float
// draws follow Java's `getKnownMovement`/`randomBetween` order.
    // rust: pub(super) fn powder_snow_velocity(
    // rust: known: Vec3,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<[f64; 3]> {
    // rust: horizon_client::powder_snow::particle_velocity(known, random)
}

    // rust: fn send_native_nearby(
    // rust: host: &LanHost,
    // rust: dimension: &str,
    // rust: packet: Vec<u8>,
    // rust: horizon_only: bool,
    // rust: within_range: impl Fn([f64; 3]) -> bool,
    // rust: ) {
    // rust: for guest in host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.placed && g.dimension == dimension && within_range(g.position))
    // rust: {
        // A vanilla client cannot decode a native mod's particle id; see
        // `mod_particle_only_for_horizon`.
    // rust: if horizon_only && guest.brand != "horizon" {
    // rust: continue;
}
    // rust: guest.sender.send(packet.clone());
}
}

// A native mod's particle travels as `MOD_PARTICLE_ID` (-1) plus its name.
// Vanilla reads the id with `IdMap.byIdOrThrow`, which throws on -1 and
// drops the connection, so such a particle may only go to Horizon clients.
mod_particle_only_for_horizon :: proc(particle: ^Particle) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(particle.data, Some(ParticleData::Mod(_)))
}

// One of a packet's `count` particles (`handleParticleEvent`): its position
// and speed. DEFAULT (0) draws both from a Gaussian; ALTERNATIVE (1) and
// ALTERNATIVE_WITH_SPEED (2) spread over `[0, dist)`, the first keeping
// the speeds as they are, the second scaling each by `nextDouble`.
    // rust: fn spread(
    // rust: r: &mut impl RandomSource,
    // rust: randomization: i32,
    // rust: pos: [f64; 3],
    // rust: dist: [f64; 3],
    // rust: speed: [f64; 3],
    // rust: ) -> ([f64; 3], [f64; 3]) {
    // rust: if matches!(randomization, 1 | 2) {
    // rust: let at = [0, 1, 2].map(|k| pos[k] + r.next_double() * dist[k]);
    // rust: let v = if randomization == 2 {
    // rust: [0, 1, 2].map(|k| speed[k] * r.next_double())
    // rust: } else {
    // rust: speed
}
    // rust: (at, v)
    // rust: } else {
    // rust: let at = [0, 1, 2].map(|k| pos[k] + r.next_gaussian() * dist[k]);
    // rust: (at, [0, 1, 2].map(|k| r.next_gaussian() * speed[k]))
}
}

// An ARGB colour as the options' RGBA.
rgba :: proc(argb: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let c = |shift: i32| ((argb >> shift) & 255) as f32 / 255.0;
    // rust: [c(16), c(8), c(0), c(24)]
}
// The options' RGB as an RGB colour (`ARGB.colorFromFloat` without alpha).
rgb_int :: proc(c: [f32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let b = |v: f32| ((v.clamp(0.0, 1.0) * 255.0).round() as i32) & 255;
    // rust: (b(c[0]) << 16) | (b(c[1]) << 8) | b(c[2])
}
rgb :: proc(c: [f32; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [c[0], c[1], c[2]]
}

// `ServerLevel.sendParticles` of one soul particle moving by `velocity`
// (Soul Speed's `spawn_particles`): sent to the players within 32 blocks.
    // rust: pub(super) fn send_soul_particle(host: &super::lan::LanHost, at: [f64; 3], velocity: [f64; 3]) {
    // rust: let Some(id) = host
    // rust: .hub
    // rust: .registry_id("minecraft:particle_type", "minecraft:soul")
    // rust: else {
    // rust: return;
}
    // rust: let packet = C::LevelParticles(play::LevelParticles {
    // rust: particle: Particle { id, data: None },
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: velocity.map(|v| v as f32),
    // rust: max_speed: [1.0; 3],
    // rust: count: 0,
    // rust: randomization: 0,
    // rust: });
    // rust: for g in host.hub.guests.iter().filter(|g| host.hub.here(g)) {
    // rust: let distance: f64 = (0..3)
    // rust: .map(|k| (g.position[k].floor() + 0.5 - at[k]).powi(2))
    // rust: .sum();
    // rust: if distance < 32.0 * 32.0 {
    // rust: g.send(&packet);
}
}
}

    // rust: impl Game<'_> {
    // A snowflake from a vehicle (`PowderSnowBlock.entityInside`), to every player around.
    // rust: pub(super) fn lan_snowflake(&self, at: [f64; 3], velocity: [f64; 3]) {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: send_snowflake_particle(host, at, velocity);
}
}
}

// `PowderSnowBlock.entityInside`'s `ServerLevel.sendParticles` of one
// snowflake (`count` 1, no spread, `RandomizationType.ALTERNATIVE`).
    // rust: pub(super) fn send_snowflake_particle(
    // rust: host: &super::lan::LanHost,
    // rust: at: [f64; 3],
    // rust: velocity: [f64; 3],
    // rust: ) {
    // rust: let Some(id) = host
    // rust: .hub
    // rust: .registry_id("minecraft:particle_type", "minecraft:snowflake")
    // rust: else {
    // rust: return;
}
    // rust: let packet = C::LevelParticles(play::LevelParticles {
    // rust: particle: Particle { id, data: None },
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: [0.0; 3],
    // rust: max_speed: velocity.map(|v| v as f32),
    // rust: count: 1,
    // rust: randomization: 1,
    // rust: });
    // rust: for g in host.hub.guests.iter().filter(|g| host.hub.here(g)) {
    // rust: let distance: f64 = (0..3)
    // rust: .map(|k| (g.position[k].floor() + 0.5 - at[k]).powi(2))
    // rust: .sum();
    // rust: if distance < 32.0 * 32.0 {
    // rust: g.send(&packet);
}
}
}

// `ServerLevel.sendParticles`: sends a `ClientboundLevelParticlesPacket` to each player within 32 blocks.
    // rust: pub(super) fn send_hub_level_particles(
    // rust: hub: &Hub,
    // rust: options: &ParticleOptions,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: u32,
    // rust: state: Option<BlockStateId>,
    // rust: ) {
    // rust: let Some(particle) = Game::hub_particle(hub, options, state) else {
    // rust: return;
}
    // rust: let horizon_only = mod_particle_only_for_horizon(&particle);
    // rust: let packet = C::LevelParticles(play::LevelParticles {
    // rust: particle,
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: spread.map(|d| d as f32),
    // rust: max_speed: [speed as f32; 3],
    // rust: count: count as i32,
    // rust: randomization: 0,
    // rust: });
    // rust: for g in hub.guests.iter().filter(|g| hub.here(g)) {
    // rust: if horizon_only && g.brand != "horizon" {
    // rust: continue;
}
        // ServerLevel compares the player's block centre, strictly within 32.
    // rust: let distance: f64 = (0..3)
    // rust: .map(|k| (g.position[k].floor() + 0.5 - at[k]).powi(2))
    // rust: .sum();
    // rust: if distance < 32.0 * 32.0 {
    // rust: g.send(&packet);
}
}
}

    // rust: impl Game<'_> {
    // `SonicBoom.tick` uses `ServerLevel.sendParticles` for each ray point.
    // Keep the local event's rendering; connected players receive one at rest.
    // rust: pub(super) fn lan_sonic_boom(&self, options: &ParticleOptions, at: [f64; 3]) {
    // rust: let (Some(host), Some(particle)) = (&self.lan, self.network_particle(options, None)) else {
    // rust: return;
}
    // rust: let packet = C::LevelParticles(play::LevelParticles {
    // rust: particle,
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: [0.0; 3],
    // rust: max_speed: [0.0; 3],
    // rust: count: 0,
    // rust: randomization: 0,
    // rust: });
    // rust: for g in host.hub.guests.iter().filter(|g| host.hub.here(g)) {
            // ServerLevel compares the player's block centre, strictly within 32.
    // rust: let distance: f64 = (0..3)
    // rust: .map(|k| (g.position[k].floor() + 0.5 - at[k]).powi(2))
    // rust: .sum();
    // rust: if distance < 32.0 * 32.0 {
    // rust: g.send(&packet);
}
}
}

    // `ServerLevel.sendParticles` of a mob's particles: a packet to each
    // player within 32 blocks. The window draws its own copy. `state` is the
    // block of a block particle. `host` is the hub of a guest's turn, which
    // is out of `self.lan` meanwhile.
    // rust: pub(super) fn lan_level_particles(
    // rust: &self,
    // rust: host: Option<&LanHost>,
    // rust: options: &ParticleOptions,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: u32,
    // rust: state: Option<BlockStateId>,
    // rust: ) {
    // rust: let Some(hub) = host.or(self.lan.as_ref()).map(|h| &h.hub) else {
    // rust: return;
}
    // rust: send_hub_level_particles(hub, options, at, spread, speed, count, state);
}

    // `LivingEntity.checkFallDamage`'s `ServerLevel.sendParticles` of the
    // landing block's crumbs: drawn in this window, when it has one, and
    // sent to each player within 32 blocks. `host` is the hub of a guest's
    // turn, which is out of `self.lan` meanwhile.
    // rust: pub(super) fn landing_dust(
    // rust: &mut self,
    // rust: host: Option<&LanHost>,
    // rust: state: BlockStateId,
    // rust: at: Vec3,
    // rust: count: i32,
    // rust: speed: f64,
    // rust: ) {
    // rust: let at = [at.x, at.y, at.z];
    // rust: if self.serving.is_none() && self.options.dedicated.is_none() {
    // rust: let block = [
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 0.2).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: if let Some((sprite, tint)) = self.particle_sprite(state, block) {
    // rust: self.particles.send_particles(
    // rust: &ParticleOptions::block(ParticleType::Block, sprite, tint),
    // rust: at,
    // rust: [0.0; 3],
    // rust: speed,
    // rust: count as u32,
    // rust: );
}
}
    // rust: let Some(hub) = host.or(self.lan.as_ref()).map(|h| &h.hub) else {
    // rust: return;
}
    // rust: let Some(particle) = Self::hub_particle(
    // rust: hub,
    // rust: &ParticleOptions::simple(ParticleType::Block),
    // rust: Some(state),
    // rust: ) else {
    // rust: return;
}
    // rust: let packet = C::LevelParticles(play::LevelParticles {
    // rust: particle,
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: [0.0; 3],
    // rust: max_speed: [speed as f32; 3],
    // rust: count,
    // rust: randomization: 0,
    // rust: });
    // rust: for g in hub.guests.iter().filter(|g| hub.here(g)) {
            // ServerLevel compares the player's block centre, strictly within 32.
    // rust: let distance: f64 = (0..3)
    // rust: .map(|k| (g.position[k].floor() + 0.5 - at[k]).powi(2))
    // rust: .sum();
    // rust: if distance < 32.0 * 32.0 {
    // rust: g.send(&packet);
}
}
}

    // Shared block callback for any entity family that applies block effects.
    // rust: pub(super) fn entity_powder_snow_particles(
    // rust: &mut self,
    // rust: previous: Vec3,
    // rust: position: Vec3,
    // rust: bounds: Aabb,
    // rust: known_movement: Vec3,
    // rust: living: bool,
    // rust: ) {
        // `particle_velocity` refuses no horizontal movement before any draw,
        // so a resting entity skips the sweep (most items, orbs and carts).
    // rust: if self.remote.is_some() || (known_movement.x == 0.0 && known_movement.z == 0.0) {
    // rust: return;
}
    // rust: let snow = horizon_client::powder_snow::contacts(previous, position, bounds, living, |p| {
    // rust: &*self.res.facts().get(self.world.block(p.x, p.y, p.z)).name == "minecraft:powder_snow"
    // rust: });
    // rust: for block in snow {
    // rust: self.powder_snow_particle(block, position, known_movement);
}
}

    // `PowderSnowBlock.entityInside` for an entity with known movement.
    // rust: pub(super) fn powder_snow_particle(
    // rust: &mut self,
    // rust: block: BlockPos,
    // rust: position: Vec3,
    // rust: known_movement: Vec3,
    // rust: ) {
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let Some(velocity) = powder_snow_velocity(known_movement, &mut self.world.random) else {
    // rust: return;
}
    // rust: self.snowflake_particle([position.x, f64::from(block.y + 1), position.z], velocity);
}

    // Locally draw the level's own particle, then send it to LAN players.
    // rust: pub(super) fn snowflake_particle(&mut self, at: [f64; 3], velocity: [f64; 3]) {
    // rust: let options = ParticleOptions::simple(ParticleType::Snowflake);
    // rust: if self.options.execution_role.is_client() {
    // rust: self.particles.add(&options, at, velocity);
}
    // rust: self.lan_send_particles(QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options,
    // rust: state: None,
    // rust: at,
    // rust: spread: [0.0; 3],
    // rust: speed: velocity,
    // rust: count: 1,
    // rust: randomization: 1,
    // rust: });
}

    // `ParticleTypes.STREAM_CODEC`'s value for `options`: the type's
    // network id and the data it carries (`state` for the block particles).
    // None while not serving, or for a particle whose data isn't sent from
    // here (items, trails).
    // rust: pub(super) fn network_particle(
    // rust: &self,
    // rust: options: &ParticleOptions,
    // rust: state: Option<BlockStateId>,
    // rust: ) -> Option<Particle> {
    // rust: Self::hub_particle(&self.lan.as_ref()?.hub, options, state)
}

    // `network_particle` for a hub that is out of `self.lan` meanwhile (a
    // guest's turn).
    // rust: pub(super) fn hub_particle(
    // rust: hub: &Hub,
    // rust: options: &ParticleOptions,
    // rust: state: Option<BlockStateId>,
    // rust: ) -> Option<Particle> {
        // A native mod's own type: no registry id, so the sentinel and the name.
    // rust: if let Some(name) = &options.mod_particle {
    // rust: return Some(Particle {
    // rust: id: MOD_PARTICLE_ID,
    // rust: data: Some(ParticleData::Mod(name.clone())),
    // rust: });
}
    // rust: let name = format!("minecraft:{}", options.ty.name());
    // rust: let id = hub.registry_id("minecraft:particle_type", &name)?;
//         use ParticleType as T;
    // rust: let c = options.color;
    // rust: let data = match options.ty {
    // rust: T::Block | T::BlockMarker | T::FallingDust | T::DustPillar | T::BlockCrumble => {
    // rust: Some(ParticleData::State(state?.0 as i32))
}
    // rust: T::Dust => Some(ParticleData::ColorScale(rgb_int(rgb(c)), options.scale)),
    // rust: T::DustColorTransition => Some(ParticleData::ColorScale2(
    // rust: rgb_int(rgb(c)),
    // rust: rgb_int(options.to_color),
    // rust: options.scale,
    // rust: )),
    // rust: T::Effect | T::InstantEffect => {
    // rust: Some(ParticleData::ColorPower(rgb_int(rgb(c)), options.scale))
}
    // rust: T::EntityEffect | T::TintedLeaves => Some(ParticleData::Color(
    // rust: (((c[3].clamp(0.0, 1.0) * 255.0).round() as i32) << 24) | rgb_int(rgb(c)),
    // rust: )),
    // rust: T::DragonBreath | T::SculkCharge => Some(ParticleData::Scalar(options.scale)),
    // rust: T::Shriek => Some(ParticleData::Delay(options.scale as i32)),
    // rust: T::Geyser | T::GeyserPlume => Some(ParticleData::Geyser(options.geyser?.0)),
    // rust: T::GeyserBase | T::GeyserPoof => {
    // rust: let (water_blocks, burst_impulse_base) = options.geyser?;
    // rust: Some(ParticleData::GeyserBase(water_blocks, burst_impulse_base))
}
    // rust: T::Vibration => {
    // rust: let (source, _, ticks) = options.vibration.clone()?;
    // rust: Some(ParticleData::Vibration { source, ticks })
}
    // rust: T::Item | T::Trail => return None,
    // rust: _ => None,
}
    // rust: Some(Particle { id, data })
}

    // The options a server's particle stands for (None for a type or data
    // this client doesn't draw).
    // rust: pub(super) fn received_particle(
    // rust: &mut self,
    // rust: p: &Particle,
    // rust: at: [f64; 3],
    // rust: ) -> Option<ParticleOptions> {
    // rust: if p.id == MOD_PARTICLE_ID
    // rust: && let Some(ParticleData::Mod(name)) = &p.data
    // rust: {
    // rust: return Some(ParticleOptions::named(name.clone()));
}
    // rust: let name = self
    // rust: .remote
    // rust: .as_ref()?
    // rust: .builtin
    // rust: .get("minecraft:particle_type")?
    // rust: .name(p.id)?
    // rust: .to_owned();
    // rust: let ty = ParticleType::from_name(&name)?;
    // rust: Some(match &p.data {
    // rust: None => ParticleOptions::simple(ty),
    // rust: Some(ParticleData::State(s)) => {
    // rust: let pos = at.map(|v| v.floor() as i32);
    // rust: let (sprite, tint) = self
    // rust: .particle_sprite(BlockStateId(*s as u32), pos)
    // rust: .unwrap_or_else(|| ("block/stone".into(), 0xFFFFFF));
    // rust: ParticleOptions::block(ty, sprite, tint)
}
    // rust: Some(ParticleData::ColorScale(c, scale)) => {
    // rust: ParticleOptions::dust(rgb(rgba(*c)), *scale)
}
    // rust: Some(ParticleData::ColorScale2(from, to, scale)) => {
    // rust: ParticleOptions::dust_transition(rgb(rgba(*from)), rgb(rgba(*to)), *scale)
}
    // rust: Some(ParticleData::ColorPower(c, power)) => ParticleOptions {
    // rust: scale: *power,
    // rust: ..ParticleOptions::colored(ty, [rgba(*c)[0], rgba(*c)[1], rgba(*c)[2], 1.0])
    // rust: },
    // rust: Some(ParticleData::Color(c)) => ParticleOptions::colored(ty, rgba(*c)),
    // rust: Some(ParticleData::Scalar(v)) if ty == ParticleType::SculkCharge => {
    // rust: ParticleOptions::sculk_charge(*v)
}
    // rust: Some(ParticleData::Scalar(v)) => ParticleOptions {
    // rust: scale: *v,
    // rust: ..ParticleOptions::simple(ty)
    // rust: },
    // rust: Some(ParticleData::Delay(d)) => ParticleOptions::shriek(*d),
    // rust: Some(ParticleData::Geyser(water_blocks)) => ParticleOptions::geyser(ty, *water_blocks),
    // rust: Some(ParticleData::GeyserBase(water_blocks, burst_impulse_base)) => {
    // rust: ParticleOptions::geyser_base(ty, *water_blocks, *burst_impulse_base)
}
    // rust: Some(ParticleData::Trail(target, color, duration)) => {
    // rust: ParticleOptions::trail(*target, *color as u32 & 0xFF_FFFF, *duration)
}
    // rust: Some(ParticleData::Vibration { source, ticks }) => ParticleOptions::vibration(
    // rust: source.clone(),
    // rust: self.vibration_destination(source)?,
    // rust: *ticks,
    // rust: ),
    // rust: Some(_) => return None,
    // rust: })
}

    // `PositionSource.getPosition`: a block's centre, or an entity's feet
    // raised by the option's offset. An entity this client does not have is
    // no destination at all: vanilla makes the particle and removes it on its
    // first tick, so nothing of it is ever drawn.
vibration_destination :: proc(self: ^Self, source: ^PositionSource) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match source {
    // rust: PositionSource::Block([x, y, z]) => Some([
    // rust: f64::from(*x) + 0.5,
    // rust: f64::from(*y) + 0.5,
    // rust: f64::from(*z) + 0.5,
    // rust: ]),
    // rust: PositionSource::Entity { id, y_offset } => {
    // rust: let id = u32::try_from(*id).ok()?;
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && !m.removed)
    // rust: .map(|m| {
    // rust: [
    // rust: m.position.x,
    // rust: m.position.y + f64::from(*y_offset),
    // rust: m.position.z,
    // rust: ]
    // rust: })
}
}
}

    // `ClientPacketListener.handleParticleEvent`: no count is one particle
    // moving by speed times spread; otherwise each is spread and sped up by
    // gaussians on each axis.
    // rust: pub(super) fn remote_level_particles(&mut self, p: &play::LevelParticles) {
    // rust: let Some(options) = self.received_particle(&p.particle, p.pos) else {
    // rust: return;
}
        // Combat feel Legacy draws a hit as 1.8.9 did: no sweep, no damage hearts.
    // rust: if self.settings.extras.pvp.combat.hides_particle(options.ty) {
    // rust: return;
}
    // rust: let (d, s) = (p.dist.map(f64::from), p.max_speed.map(f64::from));
        // ClientLevel.addParticle: the camera's 32 blocks and the Particles
        // option, unless the packet or the type overrides the limiter.
    // rust: let add = |particles: &mut horizon_client::particles::ParticleEngine, at, v| {
    // rust: particles.add_with(&options, at, v, p.override_limiter, p.always_show);
}
    // rust: if p.count == 0 {
    // rust: add(
    // rust: &mut self.particles,
    // rust: p.pos,
    // rust: [s[0] * d[0], s[1] * d[1], s[2] * d[2]],
    // rust: );
    // rust: return;
}
    // rust: for _ in 0..p.count {
    // rust: let (at, v) = spread(self.particles.random(), p.randomization, p.pos, d, s);
    // rust: add(&mut self.particles, at, v);
}
}

    // `ClientPacketListener.handleExplosion`: the blast's particles (and its
    // sound, when the packet carries it), then the player's push.
    // rust: pub(super) fn remote_explode(&mut self, p: &play::Explode) {
    // rust: if p.play_sound {
    // rust: let pitch = (1.0
    // rust: + (self.particles.random().next_float() - self.particles.random().next_float())
    // rust: * 0.2)
    // rust: * 0.7;
            // The packet's explosionSound: a wind charge's burst, a bed's
            // or anchor's blast, a modded sound.
    // rust: let sound = self
    // rust: .remote_sound_name(&p.sound)
    // rust: .unwrap_or_else(|| "minecraft:entity.generic.explode".to_owned());
    // rust: self.audio.play(&sound, Some(p.center), 4.0, pitch);
}
    // rust: if let Some(options) = self.received_particle(&p.particle, p.center) {
    // rust: self.particles.add(&options, p.center, [1.0, 0.0, 0.0]);
}
        // A wind charge's burst throws none.
    // rust: if !p.block_particles.is_empty() {
    // rust: self.particles
    // rust: .track_explosion(p.center, p.radius, p.block_count.max(0) as usize);
}
        // Entity.pushFromExplosion.
    // rust: if let (Some(push), Some(player)) = (p.knockback, self.player.as_mut()) {
    // rust: player.velocity = Vec3::new(
    // rust: player.velocity.x + push[0],
    // rust: player.velocity.y + push[1],
    // rust: player.velocity.z + push[2],
    // rust: );
}
}

    // `ServerLevel.sendParticles` for the players a server serves: one
    // `ClientboundLevelParticlesPacket` to each player in the level whose
    // block is within 32 blocks of `at`. The window's own player is not
    // sent it (the caller draws it in this window). While the host holds
    // the players (a guest's turn through `as_guest`, a host's hit on a
    // guest) the packet waits for the turn to end so that it reaches every
    // player, the guest too.
    // rust: pub(super) fn lan_send_particles(&mut self, request: QueuedParticle) {
    // rust: if self.lan.is_none() {
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: self.creatures.lan_particles.push(request);
}
    // rust: return;
}
    // rust: let QueuedParticle {
    // rust: dimension,
    // rust: options,
    // rust: state,
    // rust: at,
    // rust: spread,
    // rust: speed,
    // rust: count,
    // rust: randomization,
    // rust: } = request;
    // rust: let Some(particle) = self.network_particle(&options, state) else {
    // rust: return;
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return;
}
    // rust: let horizon_only = mod_particle_only_for_horizon(&particle);
    // rust: let body = C::LevelParticles(play::LevelParticles {
    // rust: particle,
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: spread.map(|d| d as f32),
    // rust: max_speed: speed.map(|v| v as f32),
    // rust: count,
    // rust: randomization,
    // rust: })
    // rust: .encode();
        // BlockPos.closerToCenterThan(at, 32): from the centre of the
        // player's block.
    // rust: send_native_nearby(host, dimension, body, horizon_only, |position| {
    // rust: let d: f64 = (0..3)
    // rust: .map(|k| (position[k].floor() + 0.5 - at[k]).powi(2))
    // rust: .sum();
    // rust: d < 32.0 * 32.0
    // rust: });
}

    // Native sounds wait until the server host is available. An unknown
    // `minecraft:` event is dropped; a mod's goes by name (`sound_packet`).
    // rust: pub(super) fn flush_native_sounds(&mut self) {
    // rust: let Some(host) = &self.lan else { return };
    // rust: for sound in std::mem::take(&mut self.creatures.lan_sounds) {
    // rust: if sound.sound.starts_with("minecraft:")
    // rust: && host
    // rust: .hub
    // rust: .registry_id("minecraft:sound_event", &sound.sound)
    // rust: .is_none()
    // rust: {
    // rust: continue;
}
    // rust: let packet = host
    // rust: .hub
    // rust: .sound_packet(
    // rust: &sound.sound,
    // rust: sound.at,
    // rust: sound.volume,
    // rust: sound.pitch,
    // rust: sound.source,
    // rust: host.hub.next_sound_seed(),
    // rust: )
    // rust: .encode();
    // rust: let range = f64::from(sound.volume.max(1.0)) * 16.0;
    // rust: send_native_nearby(host, sound.dimension, packet, false, |position| {
    // rust: let distance: f64 = (0..3).map(|k| (position[k] - sound.at[k]).powi(2)).sum();
    // rust: distance <= range * range
    // rust: });
}
}

    // `BucketItem.emptyContents` where water evaporates: `sendParticles(
    // LARGE_SMOKE, x, y, z, 8, 1, 1, 1, 0, ALTERNATIVE)` from the block's
    // corner, so each puff lands inside the block. The window draws its own.
    // rust: pub(super) fn evaporation_smoke(&mut self, pos: [i32; 3]) {
    // rust: let options = ParticleOptions::simple(ParticleType::LargeSmoke);
    // rust: let at = pos.map(f64::from);
    // rust: for _ in 0..8 {
    // rust: let r = self.particles.random();
    // rust: let p = [
    // rust: at[0] + r.next_double(),
    // rust: at[1] + r.next_double(),
    // rust: at[2] + r.next_double(),
    // rust: ];
    // rust: self.particles.add(&options, p, [0.0; 3]);
}
    // rust: self.lan_send_particles(QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options,
    // rust: state: None,
    // rust: at,
    // rust: spread: [1.0; 3],
    // rust: speed: [0.0; 3],
    // rust: count: 8,
    // rust: randomization: 1,
    // rust: });
}

    // The particles guests' turns put off.
    // rust: pub(super) fn flush_lan_particles(&mut self) {
    // rust: for request in std::mem::take(&mut self.creatures.lan_particles) {
    // rust: self.lan_send_particles(request);
}
}

    // `ServerLevel.explode`'s packet to each player within 64 blocks, with
    // the push `pushed` holds for them (`ServerExplosion.hitPlayers`: a
    // creative player, whom nothing hurt). The sound reaches them on its own
    // (the level's sounds), and so does a hurt player's push (the motion
    // they are sent).
    // rust: pub(super) fn lan_explode(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: small: bool,
    // rust: radius: f32,
    // rust: block_count: usize,
    // rust: pushed: Vec<(u32, [f64; 3])>,
    // rust: ) {
        // In a guest's turn (their hit on an end crystal or a minecart) the
        // host holds the players (`as_guest`): the packet waits for the turn
        // to end so that it reaches every player, the guest too.
    // rust: if self.lan_acting.is_some() && self.lan.is_none() {
    // rust: self.creatures
    // rust: .lan_explosions
    // rust: .push((center, small, radius, block_count, pushed));
    // rust: return;
}
    // rust: let emitter = if small {
    // rust: "minecraft:explosion"
    // rust: } else {
    // rust: "minecraft:explosion_emitter"
}
    // rust: let sound = "minecraft:entity.generic.explode";
    // rust: if let Some(packet) =
    // rust: self.explosion_packet(center, radius, block_count, emitter, sound, true)
    // rust: {
    // rust: self.send_explosion(packet, &pushed);
}
}

    // The explosions guests' turns put off.
    // rust: pub(super) fn flush_lan_explosions(&mut self) {
    // rust: for (center, small, radius, block_count, pushed) in
    // rust: std::mem::take(&mut self.creatures.lan_explosions)
    // rust: {
    // rust: self.lan_explode(center, small, radius, block_count, pushed);
}
}

    // A wind charge's burst (`AbstractWindCharge.explode`): gust emitters,
    // no block particles, and for each player it pushed the push
    // (`ServerExplosion.hitPlayers`), which only that client applies, as
    // nothing hurt them.
    // rust: pub(super) fn lan_wind_burst(
    // rust: &self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: sound: &str,
    // rust: block_count: usize,
    // rust: pushed: &[(u32, [f64; 3])],
    // rust: ) {
    // rust: let emitter = if radius < 2.0 {
    // rust: "minecraft:gust_emitter_small"
    // rust: } else {
    // rust: "minecraft:gust_emitter_large"
}
    // rust: if let Some(packet) =
    // rust: self.explosion_packet(center, radius, block_count, emitter, sound, false)
    // rust: {
    // rust: self.send_explosion(packet, pushed);
}
}

    // `ClientboundExplodePacket` without a push, or None while not serving.
    // The sound is the level's, which the players hear already, so it isn't
    // played from the packet.
    // rust: fn explosion_packet(
    // rust: &self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: block_count: usize,
    // rust: emitter: &str,
    // rust: sound: &str,
    // rust: block_particles: bool,
    // rust: ) -> Option<play::Explode> {
    // rust: let hub = &self.lan.as_ref()?.hub;
    // rust: let particle = |name: &str| {
    // rust: Some(Particle {
    // rust: id: hub.registry_id("minecraft:particle_type", name)?,
    // rust: data: None,
    // rust: })
}
        // Level.DEFAULT_EXPLOSION_BLOCK_PARTICLES.
    // rust: let info = |particle, scaling| play::ExplosionParticle {
    // rust: particle,
    // rust: scaling,
    // rust: speed: 1.0,
    // rust: weight: 1,
}
    // rust: let block_particles = if block_particles {
    // rust: vec![
    // rust: info(particle("minecraft:poof")?, 0.5),
    // rust: info(particle("minecraft:smoke")?, 1.0),
    // rust: ]
    // rust: } else {
    // rust: Vec::new()
}
    // rust: Some(play::Explode {
    // rust: center,
    // rust: radius,
    // rust: block_count: block_count as i32,
    // rust: knockback: None,
    // rust: particle: particle(emitter)?,
    // rust: sound: match hub.registry_id("minecraft:sound_event", sound) {
    // rust: Some(id) => (id, None),
    // rust: None => (-1, Some((sound.into(), None))),
    // rust: },
    // rust: block_particles,
    // rust: play_sound: false,
    // rust: })
}

    // `packet` to each player within 64 blocks of its centre, with the push
    // `pushed` holds for them.
send_explosion :: proc(self: ^Self, mut packet: play::Explode, pushed: ^[(u32) {
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return;
}
    // rust: let center = packet.center;
    // rust: let plain = C::Explode(packet.clone()).encode();
    // rust: for g in host.hub.guests.iter().filter(|g| host.hub.here(g)) {
    // rust: let d: f64 = (0..3).map(|k| (g.position[k] - center[k]).powi(2)).sum();
    // rust: if d >= 4096.0 {
    // rust: continue;
}
    // rust: match pushed.iter().find(|(conn, _)| *conn == g.conn) {
    // rust: Some((_, push)) => {
    // rust: packet.knockback = Some(*push);
    // rust: g.send(&C::Explode(packet.clone()));
}
    // rust: None => g.sender.send(plain.clone()),
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::lan::{
    // rust: Joined, Lan, NetConfig, Out, PlayerSender,
    // rust: chunks::ChunkEncoder,
    // rust: data,
    // rust: guest::Guest,
    // rust: hub::{Hub, HubConfig},
}
//     use horizon_client::particles::{ParticleOptions, ParticleType};
//     use horizon_core::random::LegacyRandom;
//     use horizon_protocol::packets::play;

    // The Nether's evaporation smoke (ALTERNATIVE, dist 1, speed 0) lands
    // inside the block from its corner and stands still; DEFAULT spreads
    // both ways.
alternative_particles_spread_from_the_corner_over_dist :: proc() {
}
    // rust: let mut r = LegacyRandom::new(1);
    // rust: let mut below = false;
    // rust: for _ in 0..200 {
    // rust: let (at, v) = spread(&mut r, 1, [3.0, 64.0, -7.0], [1.0; 3], [0.0; 3]);
    // rust: assert!((3.0..4.0).contains(&at[0]), "{at:?}");
    // rust: assert!((64.0..65.0).contains(&at[1]), "{at:?}");
    // rust: assert!((-7.0..-6.0).contains(&at[2]), "{at:?}");
    // rust: assert_eq!(v, [0.0; 3]);
    // rust: let (_, v) = spread(&mut r, 2, [0.0; 3], [0.0; 3], [0.5, 0.0, 2.0]);
    // rust: assert!((0.0..0.5).contains(&v[0]) && v[1] == 0.0 && (0.0..2.0).contains(&v[2]));
    // rust: let (at, _) = spread(&mut r, 0, [0.0; 3], [1.0; 3], [0.0; 3]);
    // rust: below |= at.iter().any(|&c| c < 0.0);
}
    // rust: assert!(below, "DEFAULT is a Gaussian around the position");
}

    // `PowderSnowBlock.entityInside`: vertical-only movement skips the roll;
    // horizontal movement uses nextBoolean, then X and Z floats in order.
powder_snow_snowflakes_use_the_vanilla_movement_gate_and_random_order :: proc() {
}
    // rust: let mut stationary = LegacyRandom::new(1);
    // rust: let mut untouched = LegacyRandom::new(1);
    // rust: assert_eq!(
    // rust: powder_snow_velocity(Vec3::new(0.0, 1.0, 0.0), &mut stationary),
    // rust: None
    // rust: );
    // rust: assert_eq!(stationary.next_int(), untouched.next_int());

    // rust: let seed = (0..1000)
    // rust: .find(|seed| {
    // rust: let mut random = LegacyRandom::new(*seed);
    // rust: random.next_boolean()
    // rust: })
    // rust: .unwrap();
    // rust: let mut vanilla = LegacyRandom::new(seed);
    // rust: assert!(vanilla.next_boolean());
    // rust: let x = (vanilla.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: let z = (vanilla.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: let expected = [f64::from(x), f64::from(0.05_f32), f64::from(z)];
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: assert_eq!(
    // rust: powder_snow_velocity(Vec3::new(-0.2, 0.0, 0.0), &mut random),
    // rust: Some(expected)
    // rust: );
}

    // A hub whose `minecraft:particle_type` registry holds `particle_names`
    // in registry order, plus a near guest at (5, 64, 5) and a far one at
    // (100, 64, 100).
    // rust: fn test_hub(
    // rust: label: &str,
    // rust: particle_names: Vec<String>,
    // rust: ) -> (
    // rust: Hub,
    // rust: std::sync::mpsc::Receiver<Out>,
    // rust: std::sync::mpsc::Receiver<Out>,
    // rust: ) {
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: ..NetConfig::loopback(0, label.into(), 2)
}
    // rust: let mut sync = data::SyncData::empty();
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:particle_type".to_string(),
    // rust: horizon_protocol::registry::Ids::from_names(particle_names),
    // rust: );
    // rust: let sync = std::sync::Arc::new(sync);
    // rust: let lan = Lan::start_with(sync.clone(), config).unwrap();
    // rust: let encoder = ChunkEncoder::new(
    // rust: [] as [(std::sync::Arc<str>, bool); 0],
    // rust: &horizon_protocol::registry::Builtin::default(),
    // rust: &[],
    // rust: &[],
    // rust: );
    // rust: let hub_config = HubConfig {
    // rust: default_game_mode: 0,
    // rust: guest_commands: false,
    // rust: force_game_mode: false,
    // rust: hardcore: false,
    // rust: view_distance: 10,
    // rust: simulation_distance: 10,
    // rust: dimension: "minecraft:overworld".into(),
    // rust: allow_flight: false,
    // rust: seed: 0,
    // rust: max_players: 20,
    // rust: integrated: false,
    // rust: levels: Default::default(),
}
    // rust: let mut hub = Hub::new(lan, sync, encoder, hub_config);

    // rust: let guest = |conn, uuid, name: &str, at, tx| {
    // rust: let mut g = Guest::new(
    // rust: Joined {
    // rust: conn,
    // rust: uuid,
    // rust: name: name.into(),
    // rust: properties: Vec::new(),
    // rust: info: horizon_protocol::packets::configuration::ClientInformation::new(8),
    // rust: brand: "vanilla".into(),
    // rust: sender: PlayerSender::new(tx, std::sync::Arc::default()),
    // rust: latency: std::sync::Arc::new(std::sync::atomic::AtomicI32::new(0)),
    // rust: address: format!("127.0.0.1:{}", 25565 + conn).parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: 1,
    // rust: at,
    // rust: 8,
    // rust: );
    // rust: g.placed = true;
    // rust: g.dimension = "minecraft:overworld".into();
    // rust: g
}
    // rust: let (tx_near, rx_near) = std::sync::mpsc::channel();
    // rust: hub.guests
    // rust: .push(guest(1, 1, "NearPlayer", [5.0, 64.0, 5.0], tx_near));
    // rust: let (tx_far, rx_far) = std::sync::mpsc::channel();
    // rust: hub.guests
    // rust: .push(guest(2, 2, "FarPlayer", [100.0, 64.0, 100.0], tx_far));
    // rust: (hub, rx_near, rx_far)
}

    // The one `ClientboundLevelParticlesPacket` a guest receives.
level_particles :: proc(rx: ^std::sync::mpsc::Receiver<Out>) -> p {
    // Ported from Horizon
    return {}
}
    // rust: let out = rx
    // rust: .try_recv()
    // rust: .expect("guest should receive a LevelParticles packet");
    // rust: let body = match out {
    // rust: Out::Packet(body) => body,
    // rust: _ => panic!("expected Out::Packet"),
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: match play::Clientbound::decode(id, r.rest()).unwrap() {
    // rust: play::Clientbound::LevelParticles(p) => p,
    // rust: other => panic!("expected LevelParticles packet, got {other:?}"),
}
}

    // `ShulkerBullet.hurtServer`: fifteen crit particles (spread 0.2, speed 0.0)
    // are sent to tracking players within 32 blocks.
hitting_shulker_bullet_sends_15_crit_particles_to_players :: proc() {
}
    // rust: let (hub, rx_near, rx_far) = test_hub("ShulkerBulletTest", vec!["minecraft:crit".into()]);

    // rust: let at = [0.0, 64.0, 0.0];
    // rust: let options = ParticleOptions::simple(ParticleType::from_name("crit").unwrap());
    // rust: send_hub_level_particles(&hub, &options, at, [0.2, 0.2, 0.2], 0.0, 15, None);

    // rust: assert!(
    // rust: rx_far.try_recv().is_err(),
    // rust: "far guest should not receive particles"
    // rust: );

    // rust: let p = level_particles(&rx_near);
    // rust: assert_eq!(p.count, 15);
    // rust: assert_eq!(p.dist, [0.2, 0.2, 0.2]);
    // rust: assert_eq!(p.max_speed, [0.0; 3]);
    // rust: assert_eq!(p.pos, at);
    // rust: assert_eq!(p.particle.id, 0);
}

    // `VibrationSystem.Ticker.trySelectAndScheduleVibration`: the one packet
    // is at the vibration's origin, count 1, no spread or speed, and carries
    // the listener's `PositionSource` and the arrival time in ticks. The
    // block listeners send a block position; the warden and allay send
    // themselves (`EntityPositionSource`).
vibration_particles_carry_their_listener_and_arrival_ticks :: proc() {
}
        // `Particle::read` reads a vibration's data from its pinned id, 58.
    // rust: let mut names = vec!["minecraft:empty".to_string(); 58];
    // rust: names.push("minecraft:vibration".to_string());
    // rust: let (hub, rx_near, rx_far) = test_hub("VibrationTest", names);

    // rust: let source = PositionSource::Block([3, 64, -7]);
    // rust: let at = [1.25, 64.0, 3.75];
    // rust: let options = ParticleOptions::vibration(source.clone(), [3.5, 64.5, -6.5], 14);
    // rust: send_hub_level_particles(&hub, &options, at, [0.0; 3], 0.0, 1, None);

    // rust: assert!(rx_far.try_recv().is_err(), "only players within 32 blocks");
    // rust: let p = level_particles(&rx_near);
    // rust: assert_eq!(p.count, 1, "one signal");
    // rust: assert_eq!(p.dist, [0.0; 3]);
    // rust: assert_eq!(p.max_speed, [0.0; 3]);
    // rust: assert_eq!(p.randomization, 0, "DEFAULT");
    // rust: assert_eq!(p.pos, at);
    // rust: assert_eq!(p.particle.id, 58);
    // rust: assert_eq!(
    // rust: p.particle.data,
    // rust: Some(ParticleData::Vibration { source, ticks: 14 })
    // rust: );

        // A listener entity travels as `EntityPositionSource`: its id and the
        // offset to its eyes.
    // rust: let source = PositionSource::Entity {
    // rust: id: 42,
    // rust: y_offset: 1.15,
}
    // rust: let options = ParticleOptions::vibration(source.clone(), [0.5, 65.0, 0.5], 7);
    // rust: let particle = Game::hub_particle(&hub, &options, None).expect("a vibration particle");
    // rust: assert_eq!(
    // rust: particle.data,
    // rust: Some(ParticleData::Vibration { source, ticks: 7 })
    // rust: );
}
}
