//! Transpiled from Horizon Rust crate
//! Module: horizon-client_fireworks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Firework rockets (`FireworkRocketItem`, `FireworkRocketEntity`): launching
//! from a block face, boosting a gliding player, the 1.15 horizontal
//! acceleration and 0.04 lift, the flight-duration lifetime, explosion
//! damage with line of sight, and the client explosion (`createFireworks`).
// use super::{Game, Hit, item_draw::owner_at, view_vector};
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: collisions::SceneCollisions,
    // rust: entity_nbt::RocketNbt,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{Damage, Species, Who},
    // rust: particles::{FireworkExplosion, ParticleOptions, ParticleType},
    // rust: projectiles::ProjectileWorld,
    // rust: text::Text,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}

    // rust: pub(super) const FIREWORK_EXPLODE_EVENT: i8 = 17;

/// What `ProjectileUtil.getHitResultOnMoveVector` found along a rocket's move.
pub const RocketHit = enum {
    Entity(Who),
    Block,
};

    // rust: pub(super) struct Rocket {
    /// `Entity.yRot` and `xRot` (`/tp`, `/data get ... Rotation`).
    // rust: pub rotation: [f32; 2],
    /// When it joined its list (`horizon_client::join_seq`); set by the list.
    // rust: pub(super) join: horizon_client::join_seq::JoinSeq,
    /// Its entity id: from the entity counter on the server, the server's on
    /// a client.
    // rust: pub id: u32,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) previous: Vec3,
    // rust: pub(super) velocity: Vec3,
    // rust: life: i32,
    // rust: lifetime: i32,
    // rust: pub(super) explosions: Vec<FireworkExplosion>,
    /// Boosting the player (attachedToEntity).
    // rust: pub(super) attached: bool,
    /// On a server, the guest (by connection) who launched it, or whom it
    /// boosts: `owner`'s `Who::Player` then means them, not the host.
    // rust: pub(super) guest: Option<u32>,
    /// `Projectile.getOwner`: the player who launched it, credited with
    /// what its blast hurts.
    // rust: pub(super) owner: Option<Who>,
    /// `Projectile.leftOwner`: until then it can't hit its owner.
    // rust: left_owner: bool,
    /// `DATA_ATTACHED_TO_TARGET`: the server entity the rocket follows;
    /// boosting happens when it is the local player.
    // rust: pub(super) attached_to: Option<u32>,
    /// `DATA_SHOT_AT_ANGLE` (dispensers, crossbows): constant velocity.
    // rust: pub(super) angled: bool,
    /// `DATA_ID_FIREWORKS_ITEM`: the stack it was launched from.
    // rust: pub(super) item: ItemStack,
}
    // rust: impl Rocket {
    /// A rocket a server sent (`handleAddEntity`): placed and moved by it.
    // rust: pub(super) fn remote(id: u32, position: Vec3, velocity: Vec3) -> Self {
    // rust: let item = ItemStack::new("minecraft:firework_rocket", 1);
    // rust: let (_, explosions) = fireworks_of(&item);
    // rust: Self {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id,
    // rust: position,
    // rust: previous: position,
    // rust: velocity,
    // rust: life: 0,
    // rust: lifetime: i32::MAX,
    // rust: explosions,
    // rust: attached: false,
    // rust: guest: None,
    // rust: owner: None,
    // rust: left_owner: false,
    // rust: attached_to: None,
    // rust: angled: false,
    // rust: item,
}
}
    /// `FireworkRocketEntity.addAdditionalSaveData`; the owner only when it is `player`.
    // rust: pub(super) fn to_nbt(
    // rust: &self,
    // rust: uuid: [i32; 4],
    // rust: player: Option<[i32; 4]>,
    // rust: raw: Option<&horizon_world::nbt::Tag>,
    // rust: ) -> horizon_world::nbt::Tag {
    // rust: horizon_client::entity_nbt::firework_rocket_to_nbt(
    // rust: &horizon_client::entity_nbt::RocketSave {
    // rust: rotation: self.rotation,
    // rust: position: self.position,
    // rust: motion: self.velocity,
    // rust: life: self.life,
    // rust: lifetime: self.lifetime,
    // rust: item: &self.item,
    // rust: angled: self.angled,
    // rust: owner: if matches!(self.owner, Some(Who::Player)) {
    // rust: player
    // rust: } else {
    // rust: None
    // rust: },
    // rust: left_owner: self.left_owner,
    // rust: },
    // rust: uuid,
    // rust: raw,
    // rust: )
}
    /// A rocket loaded from its NBT (`/summon`, a saved chunk).
    // rust: pub(super) fn from_nbt(r: RocketNbt) -> Self {
    // rust: let item = r
    // rust: .item
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:firework_rocket", 1));
    // rust: let (_, explosions) = fireworks_of(&item);
    // rust: Self {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id: 0,
    // rust: position: r.position,
    // rust: previous: r.position,
    // rust: velocity: r.motion,
    // rust: life: r.life,
    // rust: lifetime: r.lifetime,
    // rust: explosions,
    // rust: attached: false,
    // rust: guest: None,
    // rust: owner: r.owner,
    // rust: left_owner: r.left_owner,
    // rust: attached_to: None,
    // rust: angled: r.angled,
    // rust: item,
}
}
    /// One tick of a server's client: the rocket flies on by itself between
    /// the server's updates (a rocket that follows an entity is placed by the
    /// caller).
    // rust: pub(super) fn remote_step(&mut self, scene: &mut SceneCollisions) {
    // rust: self.previous = self.position;
    // rust: if self.attached_to.is_none() {
    // rust: self.free_flight(scene);
}
    // rust: self.life += 1;
}
    /// The move of a rocket attached to no entity: sped up and rising, or an
    /// angled one's own motion.
pub fn next_motion(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.angled {
    // rust: self.velocity
    // rust: } else {
    // rust: Vec3::new(
    // rust: self.velocity.x * 1.15,
    // rust: self.velocity.y + 0.04,
    // rust: self.velocity.z * 1.15,
    // rust: )
}
}
    /// `EntityType.FIREWORK_ROCKET`: 0.25 x 0.25.
    // rust: pub(super) fn bounds(&self) -> Aabb {
    // rust: let h = 0.125;
    // rust: Aabb::new(
    // rust: Vec3::new(self.position.x - h, self.position.y, self.position.z - h),
    // rust: Vec3::new(
    // rust: self.position.x + h,
    // rust: self.position.y + 2.0 * h,
    // rust: self.position.z + h,
    // rust: ),
    // rust: )
}
    /// `FireworkRocketEntity.tick` for a rocket attached to no entity: speed
    /// up (an angled one keeps its motion) and rise, then move.
pub fn free_flight(self: *Self, scene: *mut SceneCollisions) void {
}
    // rust: let h = 0.125;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(self.position.x - h, self.position.y, self.position.z - h),
    // rust: Vec3::new(
    // rust: self.position.x + h,
    // rust: self.position.y + 2.0 * h,
    // rust: self.position.z + h,
    // rust: ),
    // rust: );
    // rust: let wanted = self.next_motion();
    // rust: let Ok(moved) = scene.resolve(bounds, wanted, 0.0, false) else {
    // rust: return;
}
    // rust: let horizontal = (moved.x - wanted.x).abs() > 1e-7 || (moved.z - wanted.z).abs() > 1e-7;
    // rust: self.position = Vec3::new(
    // rust: self.position.x + moved.x,
    // rust: self.position.y + moved.y,
    // rust: self.position.z + moved.z,
    // rust: );
    // rust: self.velocity = if horizontal {
    // rust: Vec3::new(self.velocity.x, wanted.y, self.velocity.z)
    // rust: } else {
    // rust: wanted
}
}
    /// Position and motion (the dispenser parity fixture).
    // rust: pub(super) fn motion(&self) -> (Vec3, Vec3) {
    // rust: (self.position, self.velocity)
}
}
/// `damageAmount * (float)Math.sqrt((5.0 - this.distanceTo(target)) / 5.0)`
/// from the rocket at `from` to a target at `to`; `Entity.distanceTo` sums
/// the squared offsets in floats.
pub fn blast_damage(damage: f32, from: Vec3, to: Vec3) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, z) = (
    // rust: (from.x - to.x) as f32,
    // rust: (from.y - to.y) as f32,
    // rust: (from.z - to.z) as f32,
    // rust: );
    // rust: let distance = f64::from(x * x + y * y + z * z).sqrt() as f32;
    // rust: damage * ((5.0 - f64::from(distance)) / 5.0).sqrt() as f32
}
    // rust: pub(super) fn fireworks_of(stack: &ItemStack) -> (u8, Vec<FireworkExplosion>) {
    // The item's default component: flight 1, no explosions.
    // rust: stack
    // rust: .data()
    // rust: .and_then(|d| d.fireworks.clone())
    // rust: .unwrap_or((1, Vec::new()))
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn new_rocket(&mut self, at: Vec3, stack: &ItemStack, attached: bool) -> Rocket {
    // rust: let (flight, explosions) = fireworks_of(stack);
        // FireworkRocketEntity: motion and lifetime come from the rocket's own random.
    // rust: let r = &mut super::dispenser::entity_random();
    // rust: let tri = |r: &mut horizon_core::random::LegacyRandom| r.triangle(0.0, 0.002297);
    // rust: let velocity = Vec3::new(tri(r), 0.05, tri(r));
    // rust: let lifetime = 10 * (1 + i32::from(flight))
    // rust: + r.next_int_bound(6).unwrap_or(0)
    // rust: + r.next_int_bound(7).unwrap_or(0);
        // Entity.<init>: the id comes from the one counter at construction.
    // rust: let id = self.take_entity_id();
    // rust: Rocket {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: life: 0,
    // rust: lifetime,
    // rust: explosions,
    // rust: attached,
    // rust: guest: None,
    // rust: owner: None,
    // rust: left_owner: false,
    // rust: attached_to: None,
    // rust: angled: false,
    // rust: item: stack.clone(),
}
}
    /// `FireworkRocketItem.useOn`: launch from the clicked point.
    // rust: pub(super) fn launch_firework(&mut self, hit: &Hit, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:firework_rocket"
    // rust: || use_on_passes(self.player.as_ref().is_some_and(|p| p.fall_flying))
    // rust: {
    // rust: return false;
}
    // rust: let at = Vec3::new(
    // rust: hit.point[0] + f64::from(hit.face[0]) * 0.15,
    // rust: hit.point[1] + f64::from(hit.face[1]) * 0.15,
    // rust: hit.point[2] + f64::from(hit.face[2]) * 0.15,
    // rust: );
    // rust: let mut rocket = self.new_rocket(at, stack, false);
    // rust: rocket.owner = Some(Who::Player);
    // rust: rocket.guest = self.lan_acting;
    // rust: self.rockets.push(rocket);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: self.swing_arm();
    // rust: true
}
    /// A rocket shot at an angle (`DATA_SHOT_AT_ANGLE`): out of a dispenser
    /// (`FireworkRocketItem.asProjectile`) or a crossbow.
    // rust: pub(super) fn launch_angled_rocket(
    // rust: &mut self,
    // rust: at: Vec3,
    // rust: velocity: Vec3,
    // rust: stack: &ItemStack,
    // rust: owner: Option<Who>,
    // rust: ) {
    // rust: let mut rocket = self.new_rocket(at, stack, false);
    // rust: rocket.velocity = velocity;
    // rust: rocket.angled = true;
    // rust: rocket.owner = owner;
    // rust: rocket.guest = self.lan_acting.filter(|_| owner == Some(Who::Player));
    // rust: self.rockets.push(rocket);
}
    /// `Entity.getHandHoldingItemAngle(Items.FIREWORK_ROCKET)` for the local
    /// player: half a block out towards the hand holding the rocket while
    /// gliding, zero otherwise. A rocket only in the offhand is in the arm
    /// opposite the main one.
pub fn rocket_hand_angle(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.player.as_ref().is_some_and(|p| p.fall_flying) {
    // rust: return [0.0; 3];
}
    // rust: let is_rocket =
    // rust: |s: Option<&ItemStack>| s.is_some_and(|s| &*s.item == "minecraft:firework_rocket");
    // rust: let main = self.stack_in(self.selected);
    // rust: let offhand_only = is_rocket(self.offhand.as_ref()) && !is_rocket(main);
    // rust: let right = offhand_only == self.settings.main_hand_left;
    // rust: let arm = if right { 80 } else { -80 };
    // rust: let v = view_vector(self.yaw + arm as f32, 0.0);
    // rust: [v[0] * 0.5, v[1] * 0.5, v[2] * 0.5]
}
    /// `FireworkRocketEntity.tick` for a rocket attached to the local player:
    /// a glide is boosted towards the look, and the rocket sits at the rocket
    /// hand with the player's motion.
    // rust: pub(super) fn follow_own_player(&mut self, r: &mut Rocket) {
    // rust: let hand = self.rocket_hand_angle();
        // getLookAngle reads Mth's float sine table, as the server does; the
        // f64 sin/cos of super::view_vector drift the boost off the server's
        // path and trip the movement check while gliding under a rocket.
    // rust: let look = horizon_world::view_direction::view_vector(self.pitch, self.yaw);
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: return;
}
    // rust: if p.fall_flying {
    // rust: let m = p.velocity;
    // rust: p.velocity = Vec3::new(
    // rust: m.x + look.x * 0.1 + (look.x * 1.5 - m.x) * 0.5,
    // rust: m.y + look.y * 0.1 + (look.y * 1.5 - m.y) * 0.5,
    // rust: m.z + look.z * 0.1 + (look.z * 1.5 - m.z) * 0.5,
    // rust: );
}
    // rust: r.position = p.position.add_vector(Vec3::new(hand[0], hand[1], hand[2]));
    // rust: r.velocity = p.velocity;
}
    /// The trail (`FireworkRocketEntity.tick` on a client): a spark each tick
    /// at the rocket, drifting against its motion.
    // rust: pub(super) fn rocket_spark(&mut self, r: &Rocket) {
    // rust: let g = |g: &mut horizon_core::random::LegacyRandom| g.next_gaussian() * 0.05;
    // rust: let v = [
    // rust: g(&mut self.world.random),
    // rust: -r.velocity.y * 0.5,
    // rust: g(&mut self.world.random),
    // rust: ];
    // rust: let at = [r.position.x, r.position.y, r.position.z];
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ParticleType::Firework), at, v);
}
    /// `FireworkRocketItem.use` while gliding: drop the player's leads, then a
    /// rocket attached to the player.
    // rust: pub(super) fn boost_firework(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:firework_rocket"
    // rust: || !self.player.as_ref().is_some_and(|p| p.fall_flying)
    // rust: {
    // rust: return false;
}
        // Server path of `use`: `dropAllLeashConnections(null)`, and when that
        // drops anything `playSound(null, player, LEAD_BREAK, NEUTRAL, 1, 1)`.
        // The entity overload follows the player and excludes nobody, including
        // the guest whose action is running while its hub is swapped out.
    // rust: if self.drop_all_leash_connections() {
    // rust: self.play_player_bound_sound("minecraft:item.lead.break", 6, 1.0, 1.0, false);
}
    // rust: let at = self.player.as_ref().map_or(Vec3::ZERO, |p| p.position);
    // rust: let mut rocket = self.new_rocket(at, stack, true);
    // rust: rocket.owner = Some(Who::Player);
    // rust: rocket.guest = self.lan_acting;
    // rust: self.rockets.push(rocket);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: self.award_stat("used", "minecraft:firework_rocket", 1);
    // rust: self.swing_arm();
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_elytra_boost(player, &name);
}
    // rust: true
}
    // rust: pub(super) fn tick_rockets(&mut self) {
    // rust: let targets = if self.rockets.is_empty() {
    // rust: Vec::new()
    // rust: } else {
    // rust: self.rocket_targets()
}
    // rust: let mut i = 0;
    // rust: while i < self.rockets.len() {
    // rust: let mut r = self.rockets.remove(i);
    // rust: r.previous = r.position;
            // Projectile.tick: whether it has left its owner, before it moves.
    // rust: let owner = self.rocket_owner(&r);
    // rust: if !r.left_owner {
    // rust: let h = 0.125;
    // rust: let reach = Aabb::new(
    // rust: Vec3::new(r.position.x - h, r.position.y, r.position.z - h),
    // rust: Vec3::new(r.position.x + h, r.position.y + 2.0 * h, r.position.z + h),
    // rust: )
    // rust: .expand_towards(r.velocity)
    // rust: .inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: r.left_owner = owner.is_none_or(|o| {
    // rust: !targets
    // rust: .iter()
    // rust: .any(|(who, b)| *who == o && b.intersects(reach))
    // rust: });
}
    // rust: let skip = owner.filter(|_| !r.left_owner);
    // rust: let mut hit = None;
    // rust: if r.attached
    // rust: && let Some(conn) = r.guest
    // rust: {
                // A guest's rocket follows them; their own client boosts them.
    // rust: let guest = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .and_then(|host| host.hub.guests.iter().find(|g| g.conn == conn));
    // rust: if let Some(g) = guest {
    // rust: r.position = Vec3::new(g.position[0], g.position[1], g.position[2]);
}
    // rust: } else if r.attached {
    // rust: self.follow_own_player(&mut r);
    // rust: hit = self.rocket_struck(&targets, &r, r.velocity, skip);
    // rust: } else {
                // getHitResultOnMoveVector before the move.
    // rust: hit = self.rocket_struck(&targets, &r, r.next_motion(), skip);
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: r.free_flight(&mut scene);
}
    // rust: self.entity_powder_snow_particles(
    // rust: r.previous,
    // rust: r.position,
    // rust: r.bounds(),
    // rust: r.velocity,
    // rust: false,
    // rust: );
            // hitTargetOrDeflectSelf on an entity: a breeze turns it back
            // (ProjectileDeflection.REVERSE), anything else sets it off.
            // onHitBlock: only a rocket with explosions (hasExplosion) goes
            // off on a block; a plain one flies on to its lifetime.
    // rust: match hit {
    // rust: Some(RocketHit::Entity(Who::Mob(id)))
    // rust: if self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| m.id == id && m.species() == Species::Breeze) =>
    // rust: {
    // rust: r.velocity = r.velocity.scale(-0.5);
}
    // rust: Some(RocketHit::Entity(_)) => r.life = r.lifetime,
    // rust: Some(RocketHit::Block) if !r.explosions.is_empty() => r.life = r.lifetime,
    // rust: Some(RocketHit::Block) | None => {}
}
    // rust: let at = [r.position.x, r.position.y, r.position.z];
    // rust: if r.life == 0 {
    // rust: self.audio.play(
    // rust: "minecraft:entity.firework_rocket.launch",
    // rust: Some(at),
    // rust: 3.0,
    // rust: 1.0,
    // rust: );
}
    // rust: r.life += 1;
    // rust: self.rocket_spark(&r);
    // rust: if r.life > r.lifetime {
    // rust: self.explode_rocket(&r);
    // rust: continue;
}
    // rust: self.rockets.insert(i, r);
    // rust: i += 1;
}
}
    /// `FireworkRocketEntity.explode` and `dealExplosionDamage`.
pub fn explode_rocket(self: *Self, r: *Rocket) void {
}
    // rust: let at = [r.position.x, r.position.y, r.position.z];
        // FireworkRocketEntity.explode broadcasts before discard. Send now:
        // tick_lan removes missing tracked entities before flushing effects.
    // rust: if r.id != 0
    // rust: && let Some(host) = &self.lan
    // rust: {
    // rust: host.hub
    // rust: .entity_event(r.id as i32, FIREWORK_EXPLODE_EVENT, at);
}
    // rust: if !r.explosions.is_empty() {
    // rust: let damage = 5.0 + r.explosions.len() as f32 * 2.0;
    // rust: let from = r.position;
            // `attachedToEntity` takes the full damage, a guest as well; every
            // other player in range and in sight takes the blast.
    // rust: let boosted = r.guest.filter(|_| r.attached);
    // rust: if r.attached && boosted.is_none() {
    // rust: self.rocket_hurt_player(from, damage);
    // rust: } else {
    // rust: self.rocket_blast_player(from, damage);
}
    // rust: if let Some(conn) = boosted
    // rust: && let Some(mut host) = self.lan.take()
    // rust: {
    // rust: self.as_guest(&mut host, conn, |g| g.rocket_hurt_player(from, damage));
    // rust: self.lan = Some(host);
}
            // Every other player in the level (LAN guests, the players of a
            // server thread), each swapped in as the player.
    // rust: self.each_guest_hit_except(boosted, |g| g.rocket_blast_player(from, damage));
    // rust: let hits: Vec<(u32, f32)> = {
    // rust: let world = self.mob_world_base(&[]);
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .filter_map(|m| {
    // rust: let d2 = (m.position.x - from.x).powi(2)
    // rust: + (m.position.y - from.y).powi(2)
    // rust: + (m.position.z - from.z).powi(2);
                        // Line of sight to the feet or the middle of the mob.
    // rust: let sees = d2 <= 25.0
    // rust: && (0..2).any(|step| {
    // rust: let to = Vec3::new(
    // rust: m.position.x,
    // rust: m.position.y + f64::from(m.height()) * 0.5 * f64::from(step),
    // rust: m.position.z,
    // rust: );
    // rust: world.clear_between(from, to, false)
    // rust: });
    // rust: sees.then(|| (m.id, blast_damage(damage, from, m.position)))
    // rust: })
    // rust: .collect()
}
            // damageSources().fireworks(this, getOwner()): a guest's rocket
            // hurts as theirs, and the mobs it hit answer to them.
    // rust: let owner = r.owner;
    // rust: if let Some(conn) = r.guest.filter(|_| owner.is_some())
    // rust: && let Some(mut host) = self.lan.take()
    // rust: {
    // rust: let ran = self
    // rust: .as_guest(&mut host, conn, |g| g.rocket_hurt_mobs(&hits, owner, at))
    // rust: .is_some();
    // rust: if ran {
    // rust: for (id, _) in &hits {
    // rust: if self.mobs.iter().any(|m| m.id == *id) {
    // rust: host.mob_players.insert(*id, conn);
}
}
}
    // rust: self.lan = Some(host);
    // rust: if !ran {
    // rust: self.rocket_hurt_mobs(&hits, owner, at);
}
    // rust: } else {
    // rust: self.rocket_hurt_mobs(&hits, owner, at);
}
}
    // rust: let camera = self.eye_position().unwrap_or(at);
    // rust: let v = [r.velocity.x, r.velocity.y, r.velocity.z];
    // rust: self.particles
    // rust: .fireworks(at, v, r.explosions.clone(), camera);
    // rust: self.native_firework_explode(r.id, at, r.explosions.len());
}
pub fn rocket_hurt_mobs(self: *Self, hits: *[(u32) void {
}
    // rust: let _attacker = self.knockback_scope(if attacker == Some(Who::Player) {
    // rust: self.player.as_ref().map_or(0, |p| p.entity_id)
    // rust: } else {
    // rust: 0
    // rust: });
    // rust: for &(id, amount) in hits {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: let hurt = m.damage(amount, Damage::fireworks(attacker, at));
                // LivingEntity.hurtServer: a player's rocket makes them the
                // last player to hurt it (`setLastHurtByPlayer`), so its death
                // message names them and their item.
    // rust: if hurt && attacker == Some(Who::Player) {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
}
}
}
}
    /// The owner as `rocket_targets` names it: a guest by their entity id.
pub fn rocket_owner(self: *Self, r: *Rocket) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shooter_who(r.owner, r.guest)
}
    /// `Projectile.getOwner` as a target's `Who`: a guest's `Who::Player`
    /// (kept with the connection that shot it) is their entity, not the host.
    // rust: pub(super) fn shooter_who(&self, owner: Option<Who>, guest: Option<u32>) -> Option<Who> {
    // rust: let owner = owner?;
    // rust: let Some(conn) = guest.filter(|_| owner == Who::Player) else {
    // rust: return Some(owner);
}
    // rust: let host = self.lan.as_ref()?;
    // rust: let g = host.hub.guests.iter().find(|g| g.conn == conn)?;
    // rust: Some(Who::Mob(g.entity_id as u32))
}
    /// What a rocket can hit (`Projectile.canHitEntity`): living mobs, the
    /// dragon's parts and crystals, the player and the guests.
pub fn rocket_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut targets: Vec<(Who, Aabb)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| (Who::Mob(m.id), m.bounds()))
    // rust: .collect();
    // rust: if let Some(p) = self.player_view()
    // rust: && p.alive
    // rust: && !self.spectator()
    // rust: {
    // rust: targets.push((Who::Player, p.bounds));
}
    // rust: targets.extend(
    // rust: self.special_targets()
    // rust: .into_iter()
    // rust: .map(|(id, b)| (Who::Mob(id), b)),
    // rust: );
    // rust: targets.extend(self.lan_projectile_targets());
    // rust: targets
}
    /// `ProjectileUtil.getHitResultOnMoveVector`: the nearest target on the
    /// move, short of the block it clips (`ClipContext.Block.COLLIDER`), each
    /// box grown by `computeMargin` (`tickCount` is the rocket's life plus
    /// one); else that block.
    // rust: fn rocket_struck(
    // rust: &self,
    // rust: targets: &[(Who, Aabb)],
    // rust: r: &Rocket,
    // rust: motion: Vec3,
    // rust: skip: Option<Who>,
    // rust: ) -> Option<RocketHit> {
    // rust: let from = r.position;
    // rust: let mut to = from.add_vector(motion);
    // rust: let w = self.mob_world_base(&[]);
    // rust: let block = (super::creatures::ProjWorld {
    // rust: w: &w,
    // rust: targets: Vec::new(),
    // rust: border: Some(self.border.bounds()),
    // rust: })
    // rust: .clip(from, to);
    // rust: if let Some((at, ..)) = block {
    // rust: to = at;
}
    // rust: let margin = (f64::from(r.life - 1) / 20.0).clamp(0.0, 0.3);
    // rust: targets
    // rust: .iter()
    // rust: .filter(|(who, _)| Some(*who) != skip)
    // rust: .filter_map(|(who, b)| {
    // rust: let at = b
    // rust: .inflate(Vec3::new(margin, margin, margin))
    // rust: .clip(from, to)?;
    // rust: Some((*who, from.distance_squared(at)))
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(who, _)| RocketHit::Entity(who))
    // rust: .or(block.map(|_| RocketHit::Block))
}
    /// FireworkRocketEntity.handleEntityEvent: use the synchronized item data.
    // rust: pub(super) fn remote_firework_explosion(&mut self, id: i32) {
    // rust: let camera = self.eye_position();
    // rust: if let Some(r) = self.rockets.iter().find(|r| r.id == id as u32) {
    // rust: let at = [r.position.x, r.position.y, r.position.z];
    // rust: let v = [r.velocity.x, r.velocity.y, r.velocity.z];
    // rust: self.particles
    // rust: .fireworks(at, v, r.explosions.clone(), camera.unwrap_or(at));
}
}
    /// `dealExplosionDamage` on a player that is not the rocket's
    /// `attachedToEntity`: within 5 blocks, when the rocket sees its feet or
    /// its middle (`ClipContext.Block.COLLIDER`, no fluids).
pub fn rocket_blast_player(self: *Self, from: Vec3, damage: f32) void {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let feet = p.position;
    // rust: let d2 = (feet.x - from.x).powi(2) + (feet.y - from.y).powi(2) + (feet.z - from.z).powi(2);
    // rust: if d2 > 25.0 {
    // rust: return;
}
    // rust: let height = f64::from(p.dimensions.height);
    // rust: let sees = {
    // rust: let world = self.mob_world_base(&[]);
    // rust: (0..2).any(|step| {
    // rust: let to = Vec3::new(feet.x, feet.y + height * 0.5 * f64::from(step), feet.z);
    // rust: world.clear_between(from, to, false)
    // rust: })
}
    // rust: if sees {
    // rust: self.rocket_hurt_player(from, blast_damage(damage, from, feet));
}
}
    /// `hurtServer` with `damageSources().fireworks` from the rocket at
    /// `from`: the rocket is the direct entity, so the player is knocked away
    /// from it and the death message names it; creative and spectator
    /// players are immune.
pub fn rocket_hurt_player(self: *Self, from: Vec3, amount: f32) void {
}
    // rust: if self.creative
    // rust: || self.spectator()
    // rust: || self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_none_or(|p| p.health.dead_or_dying())
    // rust: {
    // rust: return;
}
        // No mob ever owns a rocket.
    // rust: self.combat.projectile_owner = None;
    // rust: self.combat.rocket_hit = true;
    // rust: self.combat.projectile_direct =
    // rust: Some(Text::translate("entity.minecraft.firework_rocket", &[]));
    // rust: let at = [from.x, from.y, from.z];
    // rust: self.hurt_player_from(amount, Some(at), "minecraft:fireworks", Some(None));
}
    /// `FireworkEntityRenderer.submit`: the item (GROUND) facing the camera,
    /// lit at the rocket's light probe.
    // rust: pub(super) fn rocket_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let orientation = glam::Mat4::from_quat(self.camera_orientation());
        // shouldRender: not while attached to an entity (`isAttachedToEntity`).
    // rust: for r in self
    // rust: .rockets
    // rust: .iter()
    // rust: .filter(|r| !r.attached && r.attached_to.is_none())
    // rust: {
            // FireworkRocketEntity.shouldRenderAtSqrDistance: within 64 blocks;
            // EntityRenderer.shouldRender: its 0.25 box in the view.
    // rust: if !self.standing_entity_in_view(
    // rust: camera,
    // rust: super::entity_culling::at(r.previous),
    // rust: super::entity_culling::at(r.position),
    // rust: alpha,
    // rust: 0.25,
    // rust: 0.25,
    // rust: 64.0,
    // rust: 0.0,
    // rust: ) {
    // rust: continue;
}
    // rust: let p = glam::DVec3::new(
    // rust: r.previous.x + (r.position.x - r.previous.x) * alpha,
    // rust: r.previous.y + (r.position.y - r.previous.y) * alpha,
    // rust: r.previous.z + (r.position.z - r.previous.z) * alpha,
    // rust: );
            // `updateForNonLiving`: GROUND, owned by the rocket.
    // rust: let owner = owner_at(p.to_array(), 0.0, "minecraft:firework_rocket");
    // rust: let state = self.resolve_item(&r.item, DisplayContext::Ground, Some(&owner), 0);
    // rust: if state.is_empty() {
    // rust: continue;
}
    // rust: let mut pose = glam::Mat4::from_translation((p - camera).as_vec3()) * orientation;
    // rust: if r.angled {
    // rust: pose *= glam::Mat4::from_rotation_z(std::f32::consts::PI)
    // rust: * glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_rotation_x(std::f32::consts::FRAC_PI_2);
}
            // getLightProbePosition: the eye, 0.85 of its 0.25 height.
    // rust: let light = self.world.light(
    // rust: p.x.floor() as i32,
    // rust: (p.y + 0.2125).floor() as i32,
    // rust: p.z.floor() as i32,
    // rust: );
    // rust: self.submit_item_world(&state, pose, vertex_light(light), out);
}
}
}

/// `FireworkRocketItem.useOn` returns PASS while the player is fall flying,
/// leaving the boost to `use` (a guest's UseItemOn must not launch a rocket).
pub fn use_on_passes(fall_flying: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fall_flying
}

    // rust: mod tests {
pub fn use_on_passes_only_while_gliding() void {
}
    // rust: assert!(super::use_on_passes(true));
    // rust: assert!(!super::use_on_passes(false));
}

    /// `FireworkRocketItem.use` on the server, while fall-flying: a lead on a
    /// mob within the 32-block box drops as an item and one
    /// `minecraft:item.lead.break` follows the player on NEUTRAL, heard by the
    /// acting player too. A lead outside that box, or held for another player,
    /// stays. Standing still does neither.
pub fn a_gliding_firework_drops_leads_and_plays_lead_break() void {
}
//         use crate::game::{Audio, Options, Progress, Settings, load_resources};
//         use horizon_client::mobs::{Mob, leash::Holder};
//         use horizon_core::geometry::Vec3;

    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let res: &'static _ = Box::leak(Box::new(loaded.resources));
    // rust: let mut game = super::Game::new(
    // rust: res,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.player = Some(
    // rust: horizon_client::motion::PlayerMotion::new(game.motion, Vec3::new(10.5, 64.0, -3.25))
    // rust: .unwrap(),
    // rust: );
    // rust: let feet = {
    // rust: let p = game.player.as_ref().expect("a player").position;
    // rust: [p.x, p.y, p.z]
}
    // rust: let kind = game
    // rust: .res
    // rust: .mob_types()
    // rust: .get("minecraft:cow")
    // rust: .expect("cow")
    // rust: .clone();
        // A server action keeps the guest identity while its hub is swapped out.
    // rust: game.lan_acting = Some(11);
    // rust: game.lan_acting_entity = Some(37);
    // rust: let me = game.acting_uuid();
    // rust: let someone_else = [me[0].wrapping_add(1), me[1], me[2], me[3]];
    // rust: let mut leashed = |id, at: Vec3, owner: [i32; 4]| {
    // rust: let mut mob = Mob::new(id, kind.clone(), at, 0.0);
    // rust: mob.extra.leash = Some(Holder::Player);
    // rust: mob.extra.leash_player = Some(owner);
    // rust: game.mobs.push(mob);
}
    // rust: let here = Vec3::new(feet[0] + 1.0, feet[1], feet[2]);
    // rust: leashed(1, here, me);
    // rust: leashed(2, Vec3::new(feet[0] + 40.0, feet[1], feet[2]), me);
    // rust: leashed(3, here, someone_else);
    // rust: game.inventory[game.selected] = Some(super::ItemStack::new("minecraft:firework_rocket", 1));
    // rust: let stack = game.inventory[game.selected].clone().unwrap();
    // rust: game.audio.capture = Some(Vec::new());

    // rust: assert!(!game.boost_firework(&stack));
    // rust: assert_eq!(game.mobs[0].extra.leash, Some(Holder::Player));
    // rust: assert!(game.dropped.is_empty());
    // rust: assert!(game.audio.capture.as_ref().unwrap().is_empty());

    // rust: game.player.as_mut().unwrap().fall_flying = true;
    // rust: assert!(game.boost_firework(&stack));
    // rust: assert!(
    // rust: game.mobs[0].extra.leash.is_none(),
    // rust: "the mob on the lead comes free"
    // rust: );
    // rust: assert_eq!(game.mobs[1].extra.leash, Some(Holder::Player));
    // rust: assert_eq!(game.mobs[2].extra.leash, Some(Holder::Player));
    // rust: let leads: Vec<_> = game
    // rust: .dropped
    // rust: .iter()
    // rust: .filter(|d| &*d.stack.item == "minecraft:lead")
    // rust: .collect();
    // rust: assert_eq!(leads.len(), 1);
    // rust: let heard = game.audio.capture.take().unwrap_or_default();
    // rust: let snaps: Vec<_> = heard
    // rust: .iter()
    // rust: .filter(|s| s.event == "minecraft:item.lead.break")
    // rust: .collect();
    // rust: assert_eq!(snaps.len(), 1);
    // rust: let snap = snaps[0];
    // rust: assert_eq!((snap.position, snap.volume, snap.pitch), (feet, 1.0, 1.0));
    // rust: assert_eq!(
    // rust: snap.entity,
    // rust: Some(37),
    // rust: "the snap must follow the acting guest"
    // rust: );
    // rust: assert_eq!(snap.source, 6, "SoundSource.NEUTRAL");
    // rust: assert_eq!(snap.except_entity, None, "vanilla excludes no player");
    // rust: let (packet, range) =
    // rust: horizon_client::lan::containers::captured_sound_packet(snap, None, 42);
    // rust: let horizon_protocol::packets::play::Clientbound::SoundEntity(packet) = packet else {
    // rust: panic!("a firework lead snap must use the entity-bound packet");
}
    // rust: assert_eq!((packet.id, packet.source, range), (37, 6, 16.0));
    // rust: assert_eq!(packet.sound.1.unwrap().0, "minecraft:item.lead.break");
}
}
    // rust: horizon_client::impl_joined!(Rocket);
