//! Transpiled from Horizon Rust crate
//! Module: horizon-client_remote_projectiles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Primed TNT, falling blocks, projectiles, tridents, firework rockets and
//! end crystals on a server's client (`ClientPacketListener.handleAddEntity`
//! and `handleSetEntityData`): the server simulates them, the client draws
//! them where it says and interpolates their moves.
// use super::{FallStep, FallingBlock, Game, fireworks::fireworks_of};
// use horizon_client::items::ItemStack;
// use horizon_client::projectiles::{Hit, Projectile, ProjectileKind, ProjectileWorld};
// use horizon_client::{
    // rust: collisions::SceneCollisions,
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{geometry::Vec3, position::BlockPos, random::RandomSource};
// use horizon_protocol::entity_data::Value;
// use horizon_world::registry::BlockStateId;

/// An `AreaEffectCloud` a server tracks: what its client tick reads.
    // rust: pub(super) struct RemoteCloud {
    // rust: id: u32,
    // rust: pub(super) at: [f64; 3],
    // rust: pub(super) radius: f32,
    // rust: waiting: bool,
    // rust: particle: ParticleOptions,
}

/// `AreaEffectCloud.DEFAULT_PARTICLE`: a white entity effect.
pub fn default_cloud_particle() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ParticleOptions::colored(ParticleType::EntityEffect, [1.0; 4])
}

/// `AreaEffectCloud.clientTick`: while waiting, now and then two particles
/// near the middle; then about one per square block of the disc, drifting
/// (an entity effect stays still).
    // rust: pub(super) fn cloud_client_tick(
    // rust: particles: &mut horizon_client::particles::ParticleEngine,
    // rust: at: [f64; 3],
    // rust: radius: f32,
    // rust: waiting: bool,
    // rust: particle: &ParticleOptions,
    // rust: ) {
    // rust: if waiting && particles.random().next_boolean() {
    // rust: return;
}
    // rust: let (count, spread) = if waiting {
    // rust: (2, 0.2)
    // rust: } else {
    // rust: (
    // rust: (std::f32::consts::PI * radius * radius).ceil() as i32,
    // rust: radius,
    // rust: )
}
    // rust: for _ in 0..count {
    // rust: let r = particles.random();
    // rust: let angle = r.next_float() * std::f32::consts::TAU;
    // rust: let distance = r.next_float().sqrt() * spread;
    // rust: let at = [
    // rust: at[0] + f64::from(angle.cos() * distance),
    // rust: at[1],
    // rust: at[2] + f64::from(angle.sin() * distance),
    // rust: ];
    // rust: let (options, velocity) = if particle.ty == ParticleType::EntityEffect {
    // rust: let default = waiting && r.next_boolean();
    // rust: let options = if default {
    // rust: default_cloud_particle()
    // rust: } else {
    // rust: particle.clone()
}
    // rust: (options, [0.0; 3])
    // rust: } else if waiting {
    // rust: (particle.clone(), [0.0; 3])
    // rust: } else {
    // rust: let v = [
    // rust: (0.5 - r.next_double()) * 0.15,
    // rust: f64::from(0.01f32),
    // rust: (0.5 - r.next_double()) * 0.15,
    // rust: ];
    // rust: (particle.clone(), v)
}
        // `addAlwaysVisibleParticle`.
    // rust: particles.add_with(&options, at, velocity, false, true);
}
}

/// The projectile a type id names, as Horizon models it.
pub fn projectile_kind(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match kind {
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" => ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: "minecraft:snowball" => ProjectileKind::Snowball,
    // rust: "minecraft:egg" => ProjectileKind::Egg,
    // rust: "minecraft:ender_pearl" => ProjectileKind::EnderPearl,
    // rust: "minecraft:small_fireball" => ProjectileKind::SmallFireball,
    // rust: "minecraft:fireball" => ProjectileKind::LargeFireball { power: 1 },
    // rust: "minecraft:llama_spit" => ProjectileKind::LlamaSpit,
    // rust: "minecraft:wind_charge" => ProjectileKind::WindCharge,
    // rust: "minecraft:breeze_wind_charge" => ProjectileKind::BreezeWindCharge,
        // Homing state stays on the server; the client interpolates its positions.
    // rust: "minecraft:shulker_bullet" => ProjectileKind::ShulkerBullet {
    // rust: target: Some(horizon_client::mobs::Who::Player),
    // rust: dir: None,
    // rust: steps: 0,
    // rust: delta: [0.0; 3],
    // rust: seed: 0,
    // rust: },
    // rust: "minecraft:wither_skull" => ProjectileKind::WitherSkull { dangerous: false },
    // rust: _ => ProjectileKind::Thrown(horizon_client::projectiles::thrown_type(kind)?),
    // rust: })
}

/// A server's client ticks a projectile itself: it flies on between the
/// tracker's updates (10 to 20 ticks apart) with its own gravity and drag,
/// and a block stops it there; only the server decides what it hits.
    // rust: pub(super) fn remote_projectile_tick(p: &mut Projectile, w: &impl ProjectileWorld) {
    // rust: if !matches!(p.tick(w).1, Hit::None) {
    // rust: p.velocity = Vec3::ZERO;
}
}

/// `Entity.getRandomX(0.5)` / `getRandomY` / `getRandomZ(0.5)` for a shulker
/// bullet (`EntityType.SHULKER_BULLET` is 0.3125 x 0.3125).
pub fn shulker_bullet_trail_at(at: Vec3, random: *mut impl RandomSource) [ {
    // Implementation ported from Horizon
    return undefined;
}
pub const SIZE: f64 = 0.3125;
    // rust: [
    // rust: at.x + SIZE * (2.0 * random.next_double() - 1.0) * 0.5,
    // rust: at.y + SIZE * random.next_double(),
    // rust: at.z + SIZE * (2.0 * random.next_double() - 1.0) * 0.5,
    // rust: ]
}

/// `ClientPacketListener.handleSetEntityData`'s `Fireball.DATA_ITEM_STACK`:
/// the item the guest draws the fireball as, through `Fireball.setItem`;
/// a kind that is no `Fireball` has none.
    // rust: pub(super) fn remote_projectile_item(projectiles: &mut [Projectile], id: u32, stack: ItemStack) {
    // rust: if let Some(p) = projectiles
    // rust: .iter_mut()
    // rust: .find(|p| p.id == id && p.kind.is_item_fireball())
    // rust: {
    // rust: p.set_item(stack);
}
}

/// `ClientPacketListener.handleProjectilePowerPacket`: the power a hurting
/// projectile (`AbstractHurtingProjectile`) accelerates by, found by id;
/// anything else is ignored.
    // rust: pub(super) fn remote_projectile_power(projectiles: &mut [Projectile], id: i32, power: f64) {
    // rust: if let Some(p) = projectiles.iter_mut().find(|p| p.id == id as u32)
    // rust: && matches!(
    // rust: p.kind,
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. }
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: )
    // rust: {
    // rust: p.acceleration = power;
}
}

/// `AbstractHurtingProjectile.getTrailParticle`: smoke for every one of them
/// but the wind charges (no trail) and the dragon's fireball (its own).
    // rust: pub(super) fn has_smoke_trail(kind: &ProjectileKind) -> bool {
    // rust: matches!(
    // rust: kind,
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. }
    // rust: )
}

    // rust: impl Game<'_> {
    /// `Arrow.tick` and `SpectralArrow.tick` on a client: a tipped arrow
    /// sheds two entity-effect swirls in its colour while flying, one every
    /// fifth tick in a block; a spectral arrow an effect sparkle at its
    /// position while flying.
pub fn arrow_effect_particles(self: *Self) void {
}
    // rust: let mut puffs: Vec<(Vec3, i32, u32)> = Vec::new();
    // rust: for p in &self.creatures.projectiles {
    // rust: let Some(a) = p.arrow.as_ref().filter(|_| p.is_arrow()) else {
    // rust: continue;
}
    // rust: let at = p.position;
    // rust: if p.is_spectral_arrow() {
    // rust: if !p.stuck {
    // rust: let options = ParticleOptions::simple(ParticleType::Effect);
    // rust: self.particles.add(&options, [at.x, at.y, at.z], [0.0; 3]);
}
    // rust: continue;
}
    // rust: let count = match (p.stuck, a.in_ground_time % 5) {
    // rust: (true, 0) => 1,
    // rust: (true, _) => 0,
    // rust: (false, _) => 2,
}
    // rust: puffs.push((at, a.effect_color, count));
}
    // rust: for (at, color, count) in puffs {
    // rust: self.arrow_makeparticle(at, color, count);
}
}

    /// `Arrow.makeParticle`: `count` entity-effect swirls in `color` (an ARGB
    /// int, -1 for none) inside the arrow's 0.5 x 0.5 box.
pub fn arrow_makeparticle(self: *Self, at: Vec3, color: i32, count: u32) void {
}
        // `EntityType.ARROW` is 0.5 x 0.5.
pub const SIZE: f64 = 0.5;
    // rust: if color == -1 {
    // rust: return;
}
        // ColorParticleOption.create(ENTITY_EFFECT, colour): ARGB as floats.
    // rust: let channel = |shift: u32| (color as u32 >> shift & 255) as f32 / 255.0;
    // rust: let options = ParticleOptions::colored(
    // rust: ParticleType::EntityEffect,
    // rust: [channel(16), channel(8), channel(0), channel(24)],
    // rust: );
    // rust: for _ in 0..count {
            // getRandomX(0.5), getRandomY, getRandomZ(0.5).
    // rust: let r = self.particles.random();
    // rust: let x = at.x + SIZE * (2.0 * r.next_double() - 1.0) * 0.5;
    // rust: let y = at.y + SIZE * r.next_double();
    // rust: let z = at.z + SIZE * (2.0 * r.next_double() - 1.0) * 0.5;
    // rust: self.particles.add(&options, [x, y, z], [0.0; 3]);
}
}

    /// `Arrow.handleEntityEvent(0)`: a tipped arrow stuck for 600 ticks bursts
    /// into twenty particles in its colour. The server turns it into a plain
    /// arrow and does not send the colour again, so it stops here.
    // rust: pub(super) fn remote_arrow_puff(&mut self, id: u32) {
    // rust: let Some(p) = self.creatures.projectiles.iter_mut().find(|p| p.id == id) else {
    // rust: return;
}
    // rust: let Some(a) = p.arrow.as_mut() else {
    // rust: return;
}
    // rust: let (at, color) = (p.position, std::mem::replace(&mut a.effect_color, -1));
    // rust: self.arrow_makeparticle(at, color, 20);
}

    /// `AbstractHurtingProjectile.createParticleTrail`: one smoke puff half a
    /// block above each position.
    // rust: pub(super) fn smoke_trails(&mut self, at: impl IntoIterator<Item = Vec3>) {
    // rust: let smoke = ParticleOptions::simple(ParticleType::Smoke);
    // rust: for p in at {
    // rust: self.particles.add(&smoke, [p.x, p.y + 0.5, p.z], [0.0; 3]);
}
}

    // rust: pub(super) fn throwable_bubbles(&mut self, at: Vec<([f64; 3], [f64; 3])>) {
    // rust: let bubble = ParticleOptions::simple(ParticleType::Bubble);
    // rust: for (position, speed) in at {
    // rust: for _ in 0..4 {
    // rust: self.particles.add(&bubble, position, speed);
}
}
}

    /// `ShulkerBullet.tick` on a client: two `END_ROD` particles in its
    /// 0.3125 box (`getRandomX(0.5)`, `getRandomY`, `getRandomZ(0.5)`).
    // rust: pub(super) fn shulker_bullet_trails(&mut self) {
    // rust: let bullets: Vec<Vec3> = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .filter(|p| matches!(p.kind, ProjectileKind::ShulkerBullet { .. }))
    // rust: .map(|p| p.position)
    // rust: .collect();
    // rust: let options = ParticleOptions::simple(ParticleType::EndRod);
    // rust: for at in bullets {
    // rust: for _ in 0..2 {
    // rust: let p = shulker_bullet_trail_at(at, self.particles.random());
    // rust: self.particles.add(&options, p, [0.0; 3]);
}
}
}

    /// `handleAddEntity` for these types; false when `kind` isn't one.
    // rust: pub(super) fn spawn_remote_projectile(
    // rust: &mut self,
    // rust: id: i32,
    // rust: kind: &str,
    // rust: position: [f64; 3],
    // rust: rotation: (f32, f32),
    // rust: velocity: [f64; 3],
    // rust: data: i32,
    // rust: ) -> bool {
    // rust: let id = id as u32;
    // rust: let at = Vec3::new(position[0], position[1], position[2]);
    // rust: let velocity = Vec3::new(velocity[0], velocity[1], velocity[2]);
    // rust: let (yaw, pitch) = rotation;
    // rust: self.remove_remote_projectile(id);
    // rust: match kind {
    // rust: "minecraft:evoker_fangs" => self.insert_fangs(id, position, yaw, 0, 0),
    // rust: "minecraft:tnt" => self.tnts.push(super::tnt::PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: fuse: 80,
    // rust: on_ground: false,
    // rust: owner: None,
    // rust: guest: None,
    // rust: power: 4.0,
    // rust: block_state: None,
    // rust: }),
            // FallingBlockEntity.recreateFromPacket: the block state is the data.
    // rust: "minecraft:falling_block" => self.falling.push(FallingBlock {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id,
    // rust: state: BlockStateId(data.max(0) as u32),
    // rust: start_pos: BlockPos::default(),
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: age: 0,
    // rust: no_gravity: false,
    // rust: portal: Default::default(),
    // rust: drop_item: false,
    // rust: fall_distance: 0.0,
    // rust: stuck: Vec3::ZERO,
    // rust: damage: Default::default(),
    // rust: saved: None,
    // rust: }),
    // rust: "minecraft:trident" => {
    // rust: let mut t = super::trident::ThrownTrident::remote(id, at, yaw, pitch);
    // rust: t.velocity = velocity;
                // Projectile.getAddEntityPacket: the owner's id is the data.
    // rust: t.owner = data as u32;
    // rust: self.tridents.push(t);
}
    // rust: "minecraft:firework_rocket" => {
    // rust: self.rockets
    // rust: .push(super::fireworks::Rocket::remote(id, at, velocity));
}
    // rust: "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:experience_bottle" => {
    // rust: self.potions.add_remote_thrown(id, kind, at, velocity);
}
    // rust: "minecraft:dragon_fireball" => self
    // rust: .dragon_fireballs
    // rust: .push(super::dragon::DragonFireball::remote(id, at, velocity)),
    // rust: "minecraft:area_effect_cloud" => self.potions.clouds.push(RemoteCloud {
    // rust: id,
    // rust: at: position,
    // rust: radius: 3.0,
    // rust: waiting: false,
    // rust: particle: default_cloud_particle(),
    // rust: }),
    // rust: "minecraft:eye_of_ender" => {
    // rust: self.end
    // rust: .add_remote_eye(id, position, [velocity.x, velocity.y, velocity.z])
}
            // FishingHook.recreateFromPacket: the owner's id is the data.
    // rust: "minecraft:fishing_bobber" => self.spawn_remote_hook(id, at, velocity, data),
    // rust: "minecraft:end_crystal" => {
                // EndCrystal's constructor starts `time` from the crystal's own
                // random, so each placed crystal spins from its own phase.
    // rust: let time = horizon_client::mobs::entity_random(id, at)
    // rust: .next_int_bound(100_000)
    // rust: .unwrap_or(0);
    // rust: self.crystals.push(super::dragon::Crystal {
    // rust: id,
    // rust: position: at,
    // rust: show_bottom: true,
    // rust: time,
    // rust: beam: None,
    // rust: invulnerable: false,
    // rust: });
}
    // rust: _ => {
    // rust: let Some(k) = projectile_kind(kind) else {
    // rust: return false;
}
    // rust: if k == ProjectileKind::LlamaSpit {
    // rust: self.particles
    // rust: .llama_spit_burst(position, [velocity.x, velocity.y, velocity.z]);
}
    // rust: let mut p = Projectile::new(k, at, None);
                // SpectralArrow: its own type; its pickup item says so.
    // rust: if kind == "minecraft:spectral_arrow"
    // rust: && let Some(a) = p.arrow.as_mut()
    // rust: {
    // rust: a.pickup_item = ItemStack::new("minecraft:spectral_arrow", 1);
}
    // rust: p.id = id;
    // rust: p.velocity = velocity;
    // rust: p.yaw = yaw;
    // rust: p.pitch = pitch;
    // rust: self.add_projectile(p);
}
}
    // rust: true
}

    /// `handleSetEntityData` for these types: what changes how they look.
    // rust: pub(super) fn remote_projectile_data(&mut self, id: i32, values: &[(u8, i32, Value)]) {
    // rust: let id = id as u32;
    // rust: self.remote_hook_data(id, values);
    // rust: if let Some(at) = self
    // rust: .potions
    // rust: .clouds
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| c.at)
    // rust: {
            // AreaEffectCloud.DATA_RADIUS, DATA_WAITING and DATA_PARTICLE.
    // rust: for (index, _, value) in values {
    // rust: let particle = match (index, value) {
    // rust: (10, Value::Particle(p)) => self.received_particle(p, at),
    // rust: _ => None,
}
    // rust: let Some(c) = self.potions.clouds.iter_mut().find(|c| c.id == id) else {
    // rust: return;
}
    // rust: match (index, value) {
    // rust: (8, Value::Float(r)) => c.radius = *r,
    // rust: (9, Value::Bool(w)) => c.waiting = *w,
    // rust: (10, _) => c.particle = particle.unwrap_or_else(default_cloud_particle),
    // rust: _ => {}
}
}
    // rust: return;
}
    // rust: if self.rockets.iter().any(|r| r.id == id) {
    // rust: for (index, _, value) in values {
    // rust: match (index, value) {
                    // FireworkRocketEntity.DATA_ID_FIREWORKS_ITEM: its
                    // explosions for `createFireworks`.
    // rust: (8, Value::Item(stack)) => {
    // rust: if let Some(stack) = self.to_stack(stack)
    // rust: && let Some(r) = self.rockets.iter_mut().find(|r| r.id == id)
    // rust: {
    // rust: let (_, explosions) = fireworks_of(&stack);
    // rust: r.explosions = explosions;
    // rust: r.item = stack;
}
}
                    // DATA_ATTACHED_TO_TARGET (OptionalInt: the id plus 1).
    // rust: (9, Value::Id(v)) => {
    // rust: let v = (*v > 0).then(|| (*v - 1) as u32);
    // rust: if let Some(r) = self.rockets.iter_mut().find(|r| r.id == id) {
    // rust: r.attached_to = v;
}
}
                    // DATA_SHOT_AT_ANGLE.
    // rust: (10, Value::Bool(a)) => {
    // rust: if let Some(r) = self.rockets.iter_mut().find(|r| r.id == id) {
    // rust: r.angled = *a;
}
}
    // rust: _ => {}
}
}
}
    // rust: if self.potions.has_thrown(id) {
            // ThrowableItemProjectile.DATA_ITEM_STACK: the potion it is.
    // rust: for (index, _, value) in values {
    // rust: if let (8, Value::Item(stack)) = (index, value)
    // rust: && let Some(stack) = self.to_stack(stack)
    // rust: {
    // rust: self.potions.remote_thrown_item(id, stack);
}
}
    // rust: return;
}
        // Fireball.DATA_ITEM_STACK: the item a fireball is drawn as.
    // rust: if let Some(stack) = values
    // rust: .iter()
    // rust: .find_map(|(index, _, value)| match (index, value) {
    // rust: (8, Value::Item(stack)) => Some(stack),
    // rust: _ => None,
    // rust: })
    // rust: && let Some(stack) = self.to_stack(stack)
    // rust: {
    // rust: remote_projectile_item(&mut self.creatures.projectiles, id, stack);
}
    // rust: for (index, _, value) in values {
    // rust: if let Some(t) = self.tnts.iter_mut().find(|t| t.id == id) {
                // PrimedTnt.DATA_FUSE_ID.
    // rust: if let (8, Value::Int(fuse)) = (index, value) {
    // rust: t.fuse = *fuse;
}
    // rust: } else if let Some(f) = self.falling.iter_mut().find(|f| f.id == id) {
                // FallingBlockEntity.DATA_START_POS (the model's seed).
    // rust: if let (8, Value::Pos(p)) = (index, value) {
    // rust: f.start_pos = BlockPos::new(p[0], p[1], p[2]);
}
    // rust: } else if let Some(c) = self.crystals.iter_mut().find(|c| c.id == id) {
                // EndCrystal.DATA_BEAM_TARGET and DATA_SHOW_BOTTOM.
    // rust: match (index, value) {
    // rust: (8, Value::OptPos(beam)) => c.beam = *beam,
    // rust: (9, Value::Bool(show)) => c.show_bottom = *show,
    // rust: _ => {}
}
    // rust: } else if let Some(t) = self.tridents.iter_mut().find(|t| t.id == id) {
                // AbstractArrow.ID_FLAGS (no physics) and IN_GROUND, and
                // ThrownTrident.ID_LOYALTY.
    // rust: match (index, value) {
                    // Clients retain the server's fire flag until the next update.
    // rust: (0, Value::Byte(flags)) => t.fire_ticks = i32::from(flags & 1),
    // rust: (8, Value::Byte(flags)) => t.no_physics = flags & 2 != 0,
    // rust: (10, Value::Bool(in_ground)) => t.in_ground = *in_ground,
    // rust: (11, Value::Byte(loyalty)) => t.loyalty = u32::from(*loyalty as u8),
    // rust: _ => {}
}
    // rust: } else if let Some(p) = self.creatures.projectiles.iter_mut().find(|p| p.id == id) {
    // rust: match (&mut p.kind, index, value) {
                    // Entity.DATA_SHARED_FLAGS_ID's FLAG_ONFIRE: Entity.isOnFire on
                    // a client, which draws the flames. A client doesn't count the
                    // fire down: the flag goes off when the server's fire is out.
    // rust: (_, 0, Value::Byte(flags)) => {
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.synced_fire = flags & 1 != 0;
}
}
                    // AbstractArrow.ID_FLAGS (critical) and IN_GROUND.
    // rust: (ProjectileKind::Arrow { critical, .. }, 8, Value::Byte(flags)) => {
    // rust: *critical = flags & 1 != 0;
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.no_physics = flags & 2 != 0;
}
}
    // rust: (ProjectileKind::Arrow { .. }, 5, Value::Bool(no_gravity)) => {
    // rust: p.no_gravity = *no_gravity;
}
    // rust: (ProjectileKind::Arrow { .. }, 10, Value::Bool(in_ground)) => {
                        // AbstractArrow.onSyncedDataUpdated: IN_GROUND turning true after
                        // the first tick starts the shake.
    // rust: if *in_ground
    // rust: && !p.stuck
    // rust: && p.age > 0
    // rust: && let Some(a) = p.arrow.as_mut()
    // rust: && a.shake <= 0
    // rust: {
    // rust: a.shake = 7;
}
    // rust: p.stuck = *in_ground;
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.in_ground = *in_ground;
}
}
                    // Arrow.ID_EFFECT_COLOR.
    // rust: (ProjectileKind::Arrow { .. }, 11, Value::Int(color)) => {
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.effect_color = *color;
}
}
                    // WitherSkull.DATA_DANGEROUS.
    // rust: (ProjectileKind::WitherSkull { dangerous }, 8, Value::Bool(d)) => {
    // rust: *dangerous = *d;
}
    // rust: _ => {}
}
}
}
}

    /// A move's rotation for a projectile or trident.
    // rust: pub(super) fn turn_remote_projectile(&mut self, id: i32, rotation: Option<(f32, f32)>) {
    // rust: let (id, Some((yaw, pitch))) = (id as u32, rotation) else {
    // rust: return;
}
    // rust: if let Some(p) = self.creatures.projectiles.iter_mut().find(|p| p.id == id) {
    // rust: p.yaw = yaw;
    // rust: p.pitch = pitch;
    // rust: } else if let Some(t) = self.tridents.iter_mut().find(|t| t.id == id) {
    // rust: t.yaw = yaw;
    // rust: t.pitch = pitch;
}
}

    /// `Entity.getEyePosition` of a projectile's owner: this game's player or
    /// another player the server sent.
pub fn remote_eye(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remote_player_id() == Some(id) {
    // rust: let eye = self.eye_position()?;
    // rust: return Some(Vec3::new(eye[0], eye[1], eye[2]));
}
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: Some(Vec3::new(
    // rust: m.position.x,
    // rust: m.position.y + m.eye_height(),
    // rust: m.position.z,
    // rust: ))
}

    /// This client's own player's entity id on the server.
pub fn remote_player_id(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote
    // rust: .as_ref()
    // rust: .and_then(|r| u32::try_from(r.entity_id).ok())
}

    /// `FireworkRocketEntity.tick` for the rockets attached to this client's
    /// own player, once the player has moved (it ticks before them in
    /// `ClientLevel.tickEntities`), each with its spark.
    // rust: pub(super) fn tick_own_rockets(&mut self) {
    // rust: let Some(me) = self.remote_player_id() else {
    // rust: return;
}
    // rust: if !self.clock.runs_normally()
    // rust: || self.player.is_none()
    // rust: || !self.rockets.iter().any(|r| r.attached_to == Some(me))
    // rust: {
    // rust: return;
}
    // rust: let mut rockets = std::mem::take(&mut self.rockets);
    // rust: for r in rockets.iter_mut().filter(|r| r.attached_to == Some(me)) {
    // rust: self.follow_own_player(r);
    // rust: self.rocket_spark(r);
}
    // rust: self.rockets = rockets;
}

    /// One tick of interpolation, as `tick_remote_objects`.
    // rust: pub(super) fn tick_remote_projectiles(&mut self, mut step: impl FnMut(u32, Vec3) -> Vec3) {
    // rust: self.tick_remote_fangs();
        // PrimedTnt.tick runs on a client too: it falls, bounces and burns its
        // fuse down (the swell and flash follow it) between the server's
        // updates (every 10 ticks), and a client discards it when the fuse
        // runs out; only the server explodes it.
    // rust: let (world, collision, assets, facts, fluids, border, blocks) = (
    // rust: &self.world,
    // rust: self.collision,
    // rust: &self.pack.assets,
    // rust: self.res.facts(),
    // rust: &self.res.motion().fluids,
    // rust: Some(self.border.geometry()),
    // rust: Some(&self.res.motion().blocks),
    // rust: );
    // rust: self.tnts.retain_mut(|t| {
            // A fluid lookup that fails leaves it where its move put it.
    // rust: let _ = t.tick(world, collision, assets, facts, fluids, border, blocks);
    // rust: t.fuse > 0
    // rust: });
        // PrimedTnt.tick: while the fuse is still lit, a client adds one SMOKE
        // particle at (x, y + 0.5, z). The server's Level.addParticle never
        // reaches this window.
    // rust: let smoking: Vec<Vec3> = self.tnts.iter().map(|t| t.position).collect();
    // rust: let smoke = ParticleOptions::simple(ParticleType::Smoke);
    // rust: for p in smoking {
    // rust: self.particles.add(&smoke, [p.x, p.y + 0.5, p.z], [0.0; 3]);
}
        // FallingBlockEntity.tick runs on a client too: the block falls by
        // itself between the server's updates (every 20 ticks), then waits
        // where it lands for the server to place it and remove it.
    // rust: let mut falling = std::mem::take(&mut self.falling);
    // rust: for f in &mut falling {
    // rust: if let Ok(FallStep::Landed(_)) = self.fall_step(f, false) {
                // Block.updateEntityMovementAfterFallOn, then the air drag.
    // rust: f.velocity = Vec3::new(f.velocity.x * 0.98, 0.0, f.velocity.z * 0.98);
}
}
    // rust: self.falling = falling;
        // Projectiles tick on the client too and fly on between the tracker's
        // updates (10 to 20 ticks apart); a block stops them there, and only
        // the server decides what they hit.
    // rust: let mut projectiles = std::mem::take(&mut self.creatures.projectiles);
    // rust: let bubbles: Vec<_> = projectiles
    // rust: .iter()
    // rust: .filter_map(Projectile::water_bubbles)
    // rust: .collect();
    // rust: let mut tridents = std::mem::take(&mut self.tridents);
    // rust: let mut arrow_events = Vec::new();
    // rust: let rain = self.arrow_rain();
    // rust: let arrow_scene = self.arrow_scene(&rain);
    // rust: {
    // rust: let w = self.mob_world_base(&[]);
    // rust: let world = super::creatures::ProjWorld {
    // rust: w: &w,
    // rust: targets: Vec::new(),
    // rust: border: Some(self.border.bounds()),
}
    // rust: for p in &mut projectiles {
    // rust: match p.kind {
    // rust: ProjectileKind::Arrow { .. } => {
    // rust: let _ = horizon_client::arrows::tick_client(p, &arrow_scene);
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: arrow_events.extend(
    // rust: std::mem::take(&mut a.events)
    // rust: .into_iter()
    // rust: .map(|event| (p.position, event)),
    // rust: );
}
}
                    // ShulkerBullet.tick: only the server steers it.
    // rust: ProjectileKind::ShulkerBullet { .. } => {
    // rust: p.set_old_pos_and_rot();
    // rust: p.age += 1;
    // rust: p.position = p.position.add_vector(p.velocity);
}
    // rust: _ => remote_projectile_tick(p, &world),
}
}
    // rust: for t in &mut tridents {
    // rust: t.remote_tick(&world, self.remote_eye(t.owner));
}
}
    // rust: drop(rain);
    // rust: self.creatures.projectiles = projectiles;
    // rust: self.tridents = tridents;
    // rust: for (at, event) in arrow_events {
    // rust: self.arrow_event(at, event);
}
    // rust: self.arrow_effect_particles();
    // rust: let trails: Vec<Vec3> = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .filter(|p| has_smoke_trail(&p.kind))
    // rust: .map(|p| p.position)
    // rust: .collect();
    // rust: self.smoke_trails(trails);
    // rust: self.shulker_bullet_trails();
    // rust: self.throwable_bubbles(bubbles);
        // FireworkRocketEntity.tick: a rocket attached to another entity
        // follows it, and every rocket leaves its spark trail on a client. One
        // boosting this client's own player ticks after it (`tick_own_rockets`).
    // rust: let me = self.remote_player_id();
    // rust: let mut rockets = std::mem::take(&mut self.rockets);
    // rust: for r in &mut rockets {
    // rust: r.remote_step(&mut SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
    // rust: });
    // rust: if let Some(target) = r.attached_to {
    // rust: if me == Some(target) {
    // rust: continue;
}
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == target) {
                    // Another player's motion is not known here: its step.
    // rust: r.velocity = Vec3::new(
    // rust: m.position.x - r.previous.x,
    // rust: m.position.y - r.previous.y,
    // rust: m.position.z - r.previous.z,
    // rust: );
    // rust: r.position = m.position;
}
}
    // rust: self.rocket_spark(r);
}
    // rust: self.rockets = rockets;
    // rust: for c in &mut self.crystals {
    // rust: c.time += 1;
    // rust: c.position = step(c.id, c.position);
}
    // rust: self.step_remote_thrown();
    // rust: self.tick_remote_hooks();
    // rust: self.end.step_remote_eyes();
    // rust: self.tick_remote_clouds();
        // The dragon's fireballs fly on between the tracker's updates, with
        // their dragon_breath trail (`AbstractHurtingProjectile.getTrailParticle`).
    // rust: let trail = ParticleOptions::simple(ParticleType::DragonBreath);
    // rust: for b in &mut self.dragon_fireballs {
    // rust: let at = b.position;
    // rust: let water = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ))
    // rust: .fluid
    // rust: == horizon_client::blocks::Fluid::Water;
    // rust: if water {
                // applyInertia, before the move: four bubbles on the motion
                // the fireball already has.
    // rust: let (at, speed) = horizon_client::projectiles::water_bubble_at(
    // rust: [at.x, at.y, at.z],
    // rust: [b.velocity.x, b.velocity.y, b.velocity.z],
    // rust: );
    // rust: let bubble = ParticleOptions::simple(ParticleType::Bubble);
    // rust: for _ in 0..4 {
    // rust: self.particles.add(&bubble, at, speed);
}
}
    // rust: b.remote_step(water);
    // rust: let p = b.position;
    // rust: self.particles.add(&trail, [p.x, p.y + 0.5, p.z], [0.0; 3]);
}
}

    /// `AreaEffectCloud.clientTick` for each cloud a server tracks.
pub fn tick_remote_clouds(self: *Self) void {
}
    // rust: for c in &self.potions.clouds {
    // rust: cloud_client_tick(&mut self.particles, c.at, c.radius, c.waiting, &c.particle);
}
}

    // rust: pub(super) fn remove_remote_projectile(&mut self, id: u32) {
    // rust: self.fangs.list.retain(|f| f.id != id);
    // rust: self.tnts.retain(|t| t.id != id);
    // rust: self.falling.retain(|f| f.id != id);
    // rust: self.creatures.projectiles.retain(|p| p.id != id);
    // rust: self.tridents.retain(|t| t.id != id);
    // rust: self.rockets.retain(|r| r.id != id);
    // rust: self.crystals.retain(|c| c.id != id);
    // rust: self.potions.remove_remote_thrown(id);
    // rust: self.potions.clouds.retain(|c| c.id != id);
    // rust: self.dragon_fireballs.retain(|b| b.id != id);
    // rust: self.end.remove_remote_eye(id);
    // rust: self.remove_remote_hook(id);
}

    /// Every one a server sent (a new connection, level or dimension).
    // rust: pub(super) fn clear_remote_projectiles(&mut self) {
    // rust: self.fangs.list.clear();
    // rust: self.tnts.clear();
    // rust: self.falling.clear();
    // rust: self.creatures.projectiles.clear();
    // rust: self.tridents.clear();
    // rust: self.rockets.clear();
    // rust: self.crystals.clear();
        // The dragon a server sent goes with its crystals.
    // rust: self.dragon = None;
    // rust: self.potions.clear_thrown();
    // rust: self.potions.clouds.clear();
    // rust: self.dragon_fireballs.clear();
    // rust: self.end.clear_remote_eyes();
    // rust: self.clear_remote_hooks();
}

    /// Their kind and place, for `status`.
    // rust: pub(super) fn projectiles_status(&self) -> Vec<serde_json::Value> {
//         use serde_json::json;
    // rust: let at = |p: Vec3| [p.x, p.y, p.z];
    // rust: let mut out = Vec::new();
    // rust: for f in &self.fangs.list {
    // rust: out.push(
    // rust: json!({"id": f.id, "kind": "minecraft:evoker_fangs", "position": f.pos,
    // rust: "yaw": f.yaw, "started": f.started, "life": f.life}),
    // rust: );
}
    // rust: for t in &self.tnts {
    // rust: out.push(json!({"id": t.id, "kind": "minecraft:tnt", "position": at(t.position), "fuse": t.fuse}));
}
    // rust: for f in &self.falling {
    // rust: out.push(json!({"id": f.id, "kind": "minecraft:falling_block", "position": at(f.position), "velocity": at(f.velocity), "state": f.state.0}));
}
    // rust: for b in &self.boats {
    // rust: out.push(json!({"id": b.id, "kind": "minecraft:boat", "position": at(b.position), "velocity": at(b.velocity)}));
}
    // rust: for c in &self.carts {
    // rust: out.push(json!({"id": c.id, "kind": "minecraft:minecart", "position": at(c.position), "velocity": at(c.velocity)}));
}
    // rust: for c in &self.crystals {
    // rust: out.push(json!({"id": c.id, "kind": "minecraft:end_crystal", "position": at(c.position), "show_bottom": c.show_bottom}));
}
    // rust: for t in &self.tridents {
    // rust: out.push(json!({"id": t.id, "kind": "minecraft:trident", "position": at(t.position), "velocity": at(t.velocity), "on_fire": t.fire_ticks > 0}));
}
    // rust: for r in &self.rockets {
    // rust: out.push(json!({"id": r.id, "kind": "minecraft:firework_rocket", "position": at(r.position), "velocity": at(r.velocity)}));
}
    // rust: for p in &self.creatures.projectiles {
    // rust: out.push(json!({"id": p.id, "kind": format!("{:?}", p.kind).split([' ', '{']).next().unwrap_or(""), "position": at(p.position), "velocity": at(p.velocity),
    // rust: "player_owned": p.owner == Some(horizon_client::mobs::Who::Player),
    // rust: "on_fire": p.arrow.as_ref().is_some_and(|a| a.on_fire())}));
}
    // rust: for (kind, p, _) in self.potions.thrown_entities() {
    // rust: out.push(json!({"kind": kind, "position": at(p)}));
}
    // rust: for (id, p) in self.end.eye_positions() {
    // rust: out.push(json!({"id": id, "kind": "minecraft:eye_of_ender", "position": p}));
}
    // rust: out.extend(self.hooks_status());
    // rust: out
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::mobs::Who;
//     use horizon_core::geometry::Aabb;

    /// A world with nothing in it: the client tick of a projectile only
    /// needs the blocks around it.
pub const Empty = struct {};
    // rust: impl ProjectileWorld for Empty {
pub fn clip(self: *Self, _: Vec3, _: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn in_water(self: *Self, _: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn targets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &[]
}
}

    /// A thrown item, as a server's client tracks it: the spawn position and
    /// the motion the server gave it.
pub fn thrown(kind: ProjectileKind) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Projectile::new(kind, Vec3::new(0.0, 100.0, 0.0), None);
    // rust: p.velocity = Vec3::new(1.5, 0.0, 0.0);
    // rust: p
}

    /// The same, under the id a server tracks it by.
pub fn tracked(kind: ProjectileKind, id: u32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = thrown(kind);
    // rust: p.id = id;
    // rust: p
}

pub fn a_shulker_bullet_trail_stays_inside_its_box() void {
}
    // rust: let at = Vec3::new(10.0, 20.0, 30.0);
    // rust: let mut random = horizon_core::random::LegacyRandom::new(1);
    // rust: for _ in 0..32 {
    // rust: let [x, y, z] = shulker_bullet_trail_at(at, &mut random);
    // rust: assert!((x - at.x).abs() <= 0.3125 * 0.5 + 1e-12, "{x}");
    // rust: assert!((0.0..0.3125 + 1e-12).contains(&(y - at.y)), "{y}");
    // rust: assert!((z - at.z).abs() <= 0.3125 * 0.5 + 1e-12, "{z}");
}
}

    /// `Entity.setOldPosAndRot`: what the renderer interpolates a projectile's
    /// rotation from is the rotation the last tick ended with. An arrow shot
    /// straight up at the lowest power a bow fires turns over within a few
    /// ticks, so every tick has to carry the value of the one before it.
pub fn a_thrown_item_flies_on_between_the_server_updates() void {
}
        // A thrown egg, an ender pearl and a wind charge (#1762): the server
        // sends their position every 10 ticks, and the client ticks them
        // itself in between, as vanilla's no-op interpolation handler does.
    // rust: for kind in [
    // rust: ProjectileKind::Egg,
    // rust: ProjectileKind::EnderPearl,
    // rust: ProjectileKind::WindCharge,
    // rust: ] {
    // rust: let mut p = thrown(kind);
    // rust: remote_projectile_tick(&mut p, &Empty);
    // rust: assert!(p.position.x > 1.0, "the projectile did not fly on: {p:?}");
            // A second tick moves it further: it keeps flying, not a hop.
    // rust: let first = p.position.x;
    // rust: remote_projectile_tick(&mut p, &Empty);
    // rust: assert!(p.position.x > first, "the projectile stopped: {p:?}");
}
}

pub fn a_thrown_item_falls_and_drags_like_a_throwable_projectile() void {
}
        // ThrowableProjectile.tick: gravity 0.03, then the air drag 0.99F
        // (`getAirDrag`, a float widened to the double it scales by).
    // rust: let drag = f64::from(0.99_f32);
    // rust: let mut p = thrown(ProjectileKind::Egg);
    // rust: remote_projectile_tick(&mut p, &Empty);
    // rust: assert!((p.velocity.x - 1.5 * drag).abs() < 1e-9, "{p:?}");
    // rust: assert!((p.velocity.y - (-0.03 * drag)).abs() < 1e-9, "{p:?}");
        // A wind charge keeps its speed: no gravity and no drag
        // (AbstractWindCharge: acceleration 0, inertia 1).
    // rust: let mut p = thrown(ProjectileKind::WindCharge);
    // rust: remote_projectile_tick(&mut p, &Empty);
    // rust: assert!((p.velocity.x - 1.5).abs() < 1e-9, "{p:?}");
    // rust: assert!((p.velocity.y - 0.0).abs() < 1e-9, "{p:?}");
}

pub fn a_power_packet_gives_a_fireball_the_power_its_next_tick_uses() void {
}
        // ClientPacketListener.handleProjectilePowerPacket: the fireball with
        // id 12 gets the power the server sends bundled with its motion.
    // rust: let mut list = vec![tracked(ProjectileKind::LargeFireball { power: 1 }, 12)];
    // rust: remote_projectile_power(&mut list, 12, 0.5);
    // rust: assert_eq!(list[0].acceleration, 0.5);
        // AbstractHurtingProjectile.applyInertia: (1.5 + 0.5) * (double) 0.95f.
    // rust: remote_projectile_tick(&mut list[0], &Empty);
    // rust: assert_eq!(list[0].velocity.x, 1.899_999_976_158_142);
}

pub fn a_power_packet_ignores_an_arrow_an_unknown_id_and_a_thrown_item() void {
}
        // Vanilla's instanceof AbstractHurtingProjectile: an arrow and a
        // thrown egg are none, and no entity is id 99.
    // rust: let mut list = vec![
    // rust: tracked(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: 3,
    // rust: ),
    // rust: tracked(ProjectileKind::Egg, 4),
    // rust: tracked(ProjectileKind::LargeFireball { power: 1 }, 12),
    // rust: ];
    // rust: remote_projectile_power(&mut list, 3, 0.5);
    // rust: remote_projectile_power(&mut list, 4, 0.5);
    // rust: remote_projectile_power(&mut list, 99, 0.5);
    // rust: assert_eq!(
    // rust: list.iter().map(|p| p.acceleration).collect::<Vec<_>>(),
    // rust: [0.1; 3]
    // rust: );
}

pub fn a_guest_draws_a_fireball_as_the_item_the_server_sends() void {
}
        // `ClientPacketListener.handleSetEntityData` of
        // Fireball.DATA_ITEM_STACK: the item `Fireball.getItem` returns, which
        // is the fire charge the default was until the server says otherwise.
    // rust: let mut list = vec![
    // rust: tracked(ProjectileKind::LargeFireball { power: 1 }, 12),
    // rust: tracked(ProjectileKind::SmallFireball, 13),
    // rust: tracked(ProjectileKind::Snowball, 14),
    // rust: ];
    // rust: remote_projectile_item(&mut list, 12, ItemStack::new("minecraft:diamond", 4));
    // rust: assert_eq!(
    // rust: list[0].item.as_ref().map(|i| (&*i.item, i.count)),
    // rust: Some(("minecraft:diamond", 1)),
    // rust: "one of it, as `setItem` keeps"
    // rust: );
        // The default fire charge goes back when the server sends an empty
        // stack, and a snowball is no `Fireball`: it has no item to set.
    // rust: remote_projectile_item(&mut list, 13, ItemStack::new("minecraft:air", 1));
    // rust: assert_eq!(
    // rust: list[1].item.as_ref().map(|i| (&*i.item, i.count)),
    // rust: Some(("minecraft:fire_charge", 1))
    // rust: );
    // rust: remote_projectile_item(&mut list, 14, ItemStack::new("minecraft:diamond", 1));
    // rust: assert_eq!(list[2].item, None);
}
}
