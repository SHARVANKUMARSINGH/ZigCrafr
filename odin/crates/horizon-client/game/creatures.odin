//! Transpiled from Horizon Rust crate
package horizon_client_creatures

import "core:fmt"
import "core:mem"
import "core:math"

// Mobs in the game loop: ticking with entity snapshots, natural and
// chunk-generation spawning (`NaturalSpawner`), mob events (attacks,
// breeding, conversions, drops), projectiles, player interactions
// (feeding, shearing, milking, spawn eggs, throwing) and rendering.
    // rust: mod pufferfish_player;

// use super::{
    // rust: Dim, Game, Hand, InteractTarget, dispenser, entity_culling::EntityCullDecision,
    // rust: native_mob_draw::NativePlayerRender, native_projectiles::Impact, view_vector,
}
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: Result,
    // rust: arrows::EntityHit,
    // rust: blocks::Fluid,
    // rust: collisions::SceneCollisions,
    // rust: crafting::Recipes,
    // rust: graphics::EntityCullingMode,
    // rust: health::{HurtSource, Hurting, Knock, knockback_canceled},
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, PlayerView, Seen, SpawnSetup, Species, Who,
    // rust: ai::{eating_sound, feed_animal, takes_food},
    // rust: farm::Climate,
    // rust: spawning::{self, BiomeFacts},
    // rust: },
    // rust: mod_api::NativeLootDrops,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: projectiles::{Hit, Projectile, ProjectileKind, ProjectileWorld, clip_including_border},
    // rust: text::Text,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3, traverse_blocks, trig::Mth},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use std::sync::Arc;

// `AbstractArrow.onHitEntity` when `hurtOrSimulate` returned false.
// An enderman that teleported (`projectileReceivesSideEffectsOnHit` is
// false) leaves the arrow in flight. Every other refusal, including
// `Shulker.hurtServer` while `isClosed()`, is
// `deflect(ProjectileDeflection.REVERSE, entity, owner, false, 0.2)`.
arrow_miss :: proc(dodged: bool) -> E {
    // Ported from Horizon
    return {}
}
    // rust: if dodged {
    // rust: EntityHit::Dodged
    // rust: } else {
    // rust: EntityHit::Refused
}
}
// The world impact sound after successful arrow damage, including self-shots.
// `AbstractArrow.onHitEntity`'s damage: the crit bonus comes from the
// arrow's own random.
arrow_damage :: proc(arrow: ^Projectile, fallback: ^impl RandomSource) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut state = arrow.arrow.take();
    // rust: let damage = match state.as_mut() {
    // rust: Some(a) => arrow.arrow_damage(&mut a.random),
    // rust: None => arrow.arrow_damage(fallback),
}
    // rust: arrow.arrow = state;
    // rust: damage
}

// A sound a native mod queued, sent when the host is free.
    // rust: pub(super) struct NativeSound {
    // rust: pub dimension: &'static str,
    // rust: pub sound: String,
    // rust: pub at: [f64; 3],
    // rust: pub source: i32,
    // rust: pub volume: f32,
    // rust: pub pitch: f32,
}

// Mob-system state owned by the game.
    // rust: pub(super) struct Creatures {
    // rust: pub projectiles: horizon_client::join_seq::JoinList<Projectile>,
    // The entities a family tells the mods ticked, kept between ticks
    // (game/native_ticks.rs).
    // rust: pub tick_buffer: Vec<(u32, super::native_ticks::TickKind)>,
    // Wind bursts from a guest's turn, waiting for it to end (game/wind.rs).
    // rust: pub wind_bursts: Vec<super::wind::Burst>,
    // The wind charge whose burst is being handled, by entity id: which
    // entities have already ticked in vanilla's spawn-ordered tick list
    // (game/wind.rs).
    // rust: pub wind_source: Option<horizon_client::join_seq::JoinSeq>,
    // Wind pushes held until the entity's own tick has run, by entity id
    // (game/wind.rs `apply_late_wind_pushes`).
    // rust: pub late_wind_pushes: Vec<(u32, crate::game::Vec3)>,
    // The players a fishing hook can catch, taken as the hooks tick, and
    // the pulls on them waiting for the hub (game/fishing.rs).
    // rust: pub hook_targets: Vec<super::fishing::HookTarget>,
    // rust: pub hook_pulls: Vec<(u32, horizon_core::geometry::Vec3)>,
    // Mace smash knockback on the other players from a guest's turn, waiting
    // for it to end (game/mace.rs).
    // rust: pub smash_pushes: Vec<super::mace::SmashPush>,
    // Sweep attacks from a guest's turn, waiting for it to end
    // (game/lan_pvp.rs).
    // rust: pub sweeps: Vec<super::lan_pvp::Sweep>,
    // Explosion packets from a guest's turn, waiting for it to end
    // (centre, small, radius, blocks hit, the players it pushed;
    // game/lan_particles.rs).
    // rust: pub lan_explosions: Vec<([f64; 3], bool, f32, usize, Vec<(u32, [f64; 3])>)>,
    // Ticks left of the elder guardian's apparition (MobAppearanceParticle).
    // rust: pub elder_apparition: i32,
    // The snapshot's buffer between ticks, empty: ~400 bytes a mob, so
    // thousands of mobs would allocate and free megabytes every tick.
    // rust: seen_buf: Vec<Seen>,
    // The mobs whose own tick ran in the last `tick_creature_entities`:
    // `ServerLevel.tick` ticks only the entities in entity-ticking range, so
    // what the passes after the loop do for a mob's `aiStep`, goals or brain
    // (pickups, item searches) is for these alone.
    // rust: pub ticked: horizon_client::fast_hash::FxHashSet<u32>,
    // The wandering trader spawner's clock.
    // rust: pub trader: super::wandering_trader::Spawner,
    // When each player last put a parrot on a shoulder (`timeEntitySatOnShoulder`).
    // rust: pub shoulder_time: std::collections::HashMap<[i32; 4], i64>,
    // The cat spawner's countdown (`CatSpawner.nextTick`).
    // rust: pub cat_tick: i32,
    // Native sounds waiting for the server host to be available.
    // rust: pub lan_sounds: Vec<NativeSound>,
    // Particles from a guest's turn, waiting for it to end.
    // rust: pub lan_particles: Vec<super::lan_particles::QueuedParticle>,
}
    // rust: pub(super) struct ProjWorld<'a, 'w> {
    // rust: pub w: &'a MobWorld<'w>,
    // rust: pub targets: Vec<(Who, Aabb)>,
    // The world border's [minX, minZ, maxX, maxZ], which stops the ray as a
    // block would (`clipIncludingBorder`); None: no border.
    // rust: pub border: Option<[f64; 4]>,
}
    // rust: impl ProjectileWorld for ProjWorld<'_, '_> {
block_contacts :: proc(self: ^Self, entity: i32, kind: string, from: Vec3, to: Vec3, bounds: Aabb) {
}
    // rust: horizon_client::block_contact::swept_inside(entity, kind, from, to, bounds, |p| {
    // rust: let state = self.w.world.block(p.x, p.y, p.z);
    // rust: (state, &self.w.facts.get(state).name)
    // rust: });
}
clip :: proc(self: ^Self, from: Vec3, to: Vec3) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: self.w.world,
    // rust: binding: self.w.collision,
    // rust: subject: None,
}
    // rust: let r = traverse_blocks(from, to, 256, |p: BlockPos| {
    // rust: let state = self.w.world.block(p.x, p.y, p.z);
    // rust: if self.w.facts.is_air(state) {
    // rust: return None;
}
    // rust: let shape = self
    // rust: .w
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p)
    // rust: });
    // rust: let hit = r.ok().flatten().map(|hit| {
    // rust: (
    // rust: hit.location,
    // rust: [hit.block.x, hit.block.y, hit.block.z],
    // rust: hit.direction.normal(),
    // rust: )
    // rust: });
    // rust: match self.border {
    // rust: Some(bounds) => clip_including_border(hit, from, to, bounds),
    // rust: None => hit,
}
}
    // Entity.updateFluidInteraction over the projectile's box, not the
    // block at its feet (#3072).
in_water :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.fluids(bounds, bounds.max_position().y).in_water
}
targets :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.targets
}
    // `BaseFireBlock.entityInside` for a thrown projectile: fire and soul
    // fire set it alight for 160 ticks.
ignites :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.w.world.block(p[0], p[1], p[2]);
    // rust: matches!(
    // rust: &*self.w.facts.get(state).name,
    // rust: "minecraft:fire" | "minecraft:soul_fire"
    // rust: )
}
empty :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w.facts.is_air(self.w.world.block(p[0], p[1], p[2]))
}
solid :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.w
    // rust: .facts
    // rust: .get(self.w.world.block(p[0], p[1], p[2]))
    // rust: .full_collision
}
}

// `AbstractWindCharge` is pickable, so a thrown pearl's
// `ProjectileUtil.getEntityHitResult` can strike it (`ThrownEnderpearl.onHit`).
// `WIND_CHARGE_IDS + j` is `projectiles[j]` during `tick_projectiles`, below
// the dragon's reserved ids.
WIND_CHARGE_IDS :: super::dragon::SPECIAL - 0x10000

// The index of the wind charge a `wind_charge_hitboxes` id stands for.
    // rust: pub(super) fn wind_charge_hit(id: u32) -> Option<usize> {
    // rust: (WIND_CHARGE_IDS..super::dragon::SPECIAL)
    // rust: .contains(&id)
    // rust: .then(|| (id - WIND_CHARGE_IDS) as usize)
}

    // rust: fn wind_charge_hitboxes(
    // rust: projectiles: &[Projectile],
    // rust: alive: &[bool],
    // rust: skip: usize,
    // rust: ) -> Vec<(Who, Aabb)> {
    // rust: projectiles
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(j, q)| {
    // rust: *j != skip
    // rust: && alive[*j]
    // rust: && !q.stuck
    // rust: && matches!(
    // rust: q.kind,
    // rust: ProjectileKind::WindCharge | ProjectileKind::BreezeWindCharge
    // rust: )
    // rust: })
    // rust: .map(|(j, q)| (Who::Mob(WIND_CHARGE_IDS + j as u32), q.aabb()))
    // rust: .collect()
}

// `FlameFeatureRenderer`: fire quads stacked up a burning entity's box,
// turned to the camera around Y, at full block light. `at` is the entity's
// feet relative to the camera.
    // rust: fn flame_geometry(
    // rust: atlas: &horizon_client::hud::HudAtlas,
    // rust: at: glam::Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: camera_yaw: f32,
    // rust: light: u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let (Some(fire0), Some(fire1)) = (
    // rust: atlas.sprites.get("block/fire_0").copied(),
    // rust: atlas.sprites.get("block/fire_1").copied(),
    // rust: ) else {
    // rust: return;
}
    // rust: let s = width * 1.4;
    // rust: let mut h = height / s;
    // Mth.rotationAroundAxis(Y, camera.orientation): the camera's turn about Y.
    // rust: let turn = glam::Mat3::from_rotation_y(std::f32::consts::PI - camera_yaw.to_radians());
    // rust: let lift = 0.3 - (h as i32) as f32 * 0.02;
    // rust: let packed = (u32::from(light >> 4) * 16) | ((15 * 16) << 8);
    // rust: let (mut r, mut yo, mut zo, mut ss) = (0.5f32, 0.0f32, 0.0f32, 0);
    // rust: while h > 0.0 {
    // rust: let tex = if ss % 2 == 0 { fire0 } else { fire1 };
    // rust: let (mut u0, v0, mut u1, v1) = (tex.u0, tex.v0, tex.u1, tex.v1);
    // rust: if ss / 2 % 2 == 0 {
    // rust: std::mem::swap(&mut u0, &mut u1);
}
    // rust: for (x, y, uv) in [
    // rust: (-r, -yo, [u1, v1]),
    // rust: (r, -yo, [u0, v1]),
    // rust: (r, 1.4 - yo, [u0, v0]),
    // rust: (-r, 1.4 - yo, [u1, v0]),
    // rust: ] {
    // rust: let p = at + turn * glam::Vec3::new(x, y, zo + lift) * s;
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.to_array(),
    // rust: uv,
                // HDR output: the flames shine like fire (entity.wgsl fs_hdr_mark).
    // rust: layer: u32::from(horizon_client::mesher::INCANDESCENT) << 16,
    // rust: color: 0xFFFF_FFFF,
    // rust: light: packed,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
    // rust: h -= 0.45;
    // rust: yo -= 0.45;
    // rust: r *= 0.9;
    // rust: zo -= 0.03;
    // rust: ss += 1;
}
}
    // rust: pub(super) fn seen(m: &Mob, player: Option<[i32; 4]>) -> Seen {
    // rust: m.seen(player)
}
// Whether a mob a packet named may take the click: `mob_hit` skips a mob in
// its death animation, the one the player rides (it shares the player's root
// vehicle) and the camera entity the pick starts from, so a packet that names
// one of those does nothing rather than reaching the feed, shear, leash or
// name paths the pick path refuses.
    // rust: pub(super) fn named_mob_pickable(
    // rust: alive: bool,
    // rust: id: u32,
    // rust: riding: Option<u32>,
    // rust: camera: Option<u32>,
    // rust: ) -> bool {
    // rust: alive && Some(id) != riding && Some(id) != camera
}

// What an entity drew on the GPU path: the skin frame's mark before its draws, and their
// camera-relative bounds (`cull_skinned`).
    // rust: pub(super) type Skinned = Option<((usize, usize, u32), Option<(glam::Vec3, glam::Vec3)>)>;

    // rust: impl Game<'_> {
    // rust: pub(super) fn player_view(&self) -> Option<PlayerView> {
    // rust: let p = self.player.as_ref()?;
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(p.position.x - w, p.position.y, p.position.z - w),
    // rust: Vec3::new(
    // rust: p.position.x + w,
    // rust: p.position.y + f64::from(p.dimensions.height),
    // rust: p.position.z + w,
    // rust: ),
    // rust: );
    // rust: Some(PlayerView {
    // rust: position: p.position,
    // rust: bounds,
    // rust: eye: [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.eye_height),
    // rust: p.position.z,
    // rust: ],
    // rust: alive: !p.health.dead_or_dying(),
            // EntitySelector.NO_CREATIVE_OR_SPECTATOR.
    // rust: creative: self.creative || self.spectator(),
    // rust: sneaking: self.keys.held(Action::Sneak),
    // rust: swimming: p.swimming,
    // rust: look: view_vector(self.yaw, self.pitch),
    // rust: main_hand: self.held().map(|s| s.item.clone()),
    // rust: off_hand: self.offhand.as_ref().map(|s| s.item.clone()),
    // rust: head: self.armor[0].as_ref().map(|s| s.item.clone()),
    // rust: chest: self.armor[1].as_ref().map(|s| s.item.clone()),
    // rust: legs: self.armor[2].as_ref().map(|s| s.item.clone()),
    // rust: feet: self.armor[3].as_ref().map(|s| s.item.clone()),
    // rust: armor_cover: self.armor.iter().filter(|a| a.is_some()).count() as f32 / 4.0,
    // rust: invisible: self.potions.effects.get("invisibility").is_some(),
    // rust: spectator: self.spectator(),
    // rust: gold_armor: self.wearing_gold(),
    // rust: hurt_by: self.player_hurt_by(),
    // rust: last_hurt: self.combat.last_hurt_mob.map(|(id, at)| (Who::Mob(id), at)),
    // rust: velocity: p.velocity,
    // rust: yaw: self.yaw,
    // rust: sprinting: p.sprinting,
    // rust: riding: self.riding.is_some(),
    // rust: hero: self.potions.effects.get("hero_of_the_village").is_some(),
    // rust: effects: self.potions.effects.list.iter().map(|e| e.id).collect(),
    // rust: uuid: self.level.player_uuid.unwrap_or_default(),
    // rust: allies: std::sync::Arc::new(self.player_allies()),
    // rust: remote: false,
    // rust: sleeping: self.sleeping.is_some(),
    // rust: sleep_timer: self.sleep_timer,
    // rust: passenger: self.riding.is_some(),
    // rust: riding_vehicle: self.riding,
    // rust: vehicle: self.riding.and_then(|id| {
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == id) {
                    // A boat's box: 1.375 wide and 0.5625 high around its position.
    // rust: let w = 0.6875;
    // rust: return Some(horizon_client::mobs::Vehicle {
    // rust: nautilus: false,
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(b.position.x - w, b.position.y, b.position.z - w),
    // rust: Vec3::new(b.position.x + w, b.position.y + 0.5625, b.position.z + w),
    // rust: ),
    // rust: velocity: b.velocity,
    // rust: });
}
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: matches!(m.species(), Species::Nautilus | Species::ZombieNautilus).then(|| {
    // rust: horizon_client::mobs::Vehicle {
    // rust: nautilus: true,
    // rust: bounds: m.bounds(),
    // rust: velocity: m.velocity,
}
    // rust: })
    // rust: }),
    // rust: })
}
    // Biome facts at a position for finalizeSpawn and variant rules.
    // rust: pub(super) fn biome_facts(&self, x: i32, y: i32, z: i32) -> BiomeFacts {
    // rust: let Some(chunk) = self.world.chunks.get(&(x >> 4, z >> 4)) else {
    // rust: return BiomeFacts::default();
}
    // rust: let b = world_biomes!(self).get(chunk.biome(x, y, z));
    // rust: let tags = self.res.mob_data();
    // rust: let has = |t: &str| tags.biome_has(t, &b.name);
    // rust: let climate = if has("minecraft:spawns_warm_variant_farm_animals") {
    // rust: Climate::Warm
    // rust: } else if has("minecraft:spawns_cold_variant_farm_animals") {
    // rust: Climate::Cold
    // rust: } else {
    // rust: Climate::Temperate
}
    // rust: BiomeFacts {
    // rust: coral_nautilus: has("minecraft:spawns_coral_variant_zombie_nautilus"),
    // rust: climate,
    // rust: temperature: b.temperature,
    // rust: snowy: has("minecraft:spawns_snow_foxes")
    // rust: || b.name.contains("snow")
    // rust: || b.name.contains("frozen"),
    // rust: snow_fox: has("minecraft:spawns_snow_foxes"),
    // rust: swamp: b.name.contains("swamp"),
    // rust: ocean: has("minecraft:is_ocean"),
    // rust: mushroom: b.name == "minecraft:mushroom_fields",
    // rust: desert: b.name == "minecraft:desert",
    // rust: jungle: has("minecraft:is_jungle"),
    // rust: wolf: horizon_client::mobs::tame::wolf_variant_for(&b.name, &has),
    // rust: full_moon: (self.world.day_time / 24000).rem_euclid(8) == 0,
    // rust: frog: if has("minecraft:spawns_warm_variant_frogs") {
    // rust: 1
    // rust: } else if has("minecraft:spawns_cold_variant_frogs") {
    // rust: 2
    // rust: } else {
    // rust: 0
    // rust: },
}
}
    // Create a mob of `kind` at a position, finalized like a natural spawn.
    // rust: pub(super) fn spawn_mob(&mut self, kind: &str, at: [f64; 3], persistent: bool) -> Option<u32> {
    // rust: self.spawn_mob_for(kind, at, persistent, false)
}
    // `SummonCommand` and `SpawnEggItem`: vanilla spawns the mob, but it
    // never calls `Mob.setPersistenceRequired` for it, so the mob is not
    // persistent: the despawn rule holds it like any other mob, and only
    // its NBT can make it persistent.
    // rust: pub(super) fn spawn_mob_spawned(&mut self, kind: &str, at: [f64; 3]) -> Option<u32> {
        // Ender Dragons have their own entity implementation rather than a
        // `Mob` entry.  Spawn eggs still go through `SpawnEggItem.spawnMob`,
        // so route this special entity through the same spawned-entity path.
    // rust: if matches!(kind, "ender_dragon" | "minecraft:ender_dragon") {
    // rust: return self.spawn_dragon_spawned(at);
}
        // The spawn is not a natural one (no jockeys, the patrol leader roll
        // stays), but the mob is not persistent.
    // rust: let id = self.spawn_mob_for(kind, at, true, false)?;
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.persistent = false;
}
    // rust: Some(id)
}
    // `spawn_mob` for a patrol or raid (`EntitySpawnReason.PATROL` / `EVENT`),
    // which never rolls a patrol leader.
    // rust: pub(super) fn spawn_mob_for(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: at: [f64; 3],
    // rust: persistent: bool,
    // rust: scripted: bool,
    // rust: ) -> Option<u32> {
    // rust: self.spawn_mob_reason(kind, at, persistent, scripted, !persistent)
}
    // `spawn_mob_for` with the spawn reason's NATURAL flag explicit: only a
    // natural spawn rolls the jockey mounts of zombie horses, husks and
    // drowned (`reinforcement` and spawner spawns pass `false`).
    // rust: pub(super) fn spawn_mob_reason(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: at: [f64; 3],
    // rust: persistent: bool,
    // rust: scripted: bool,
    // rust: natural: bool,
    // rust: ) -> Option<u32> {
    // rust: let kind = if kind.contains(':') {
    // rust: kind.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{kind}")
}
    // rust: let t = self.res.mob_types().get(&kind).cloned()?;
    // rust: self.next_entity += 1;
    // rust: let yaw = self.world.random.next_float() * 360.0;
    // rust: let mut mob = Mob::new(self.next_entity, t, Vec3::new(at[0], at[1], at[2]), yaw);
    // rust: mob.persistent = persistent;
    // rust: let facts = self.biome_facts(
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: let difficulty = self.local_difficulty(at);
    // rust: spawning::finalize(&mut mob, &facts, &difficulty);
    // rust: if !scripted {
    // rust: let reason = if persistent {
    // rust: horizon_client::mobs::raider::Reason::Other
    // rust: } else {
    // rust: horizon_client::mobs::raider::Reason::Natural
}
    // rust: horizon_client::mobs::raider::finalize(&mut mob, reason);
}
    // rust: let id = mob.id;
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: if !self.mobs.iter().any(|m| m.id == id) {
    // rust: return None;
}
    // rust: self.enchant_spawn_equipment(id);
    // rust: self.halloween_spawn_head(id);
    // rust: if !persistent && !scripted {
    // rust: self.spawn_jockeys(id, natural);
}
    // rust: Some(id)
}
    // `Mob.burnUndead` for a mob in daylight with an item on its sun
    // protection slot (the head, or the body for a zombie horse or
    // nautilus): `hurtAndBreak(random.nextInt(2))` on a damageable item, and
    // when it breaks the slot empties and `onEquippedItemBroken` broadcasts
    // the break event.
wear_sun_protection :: proc(self: ^Self, id: u32) {
}
//         use horizon_world::player_inventory::EquipmentSlot;
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let body = horizon_client::mobs::drops::body_slot_species(m.species());
    // rust: let slot = if body {
    // rust: EquipmentSlot::Body
    // rust: } else {
    // rust: EquipmentSlot::Head
}
    // rust: let Some(mut stack) = m.item_by_slot(slot) else {
    // rust: return;
}
    // rust: if !horizon_client::stations::is_damageable(self.res.items(), &stack) {
    // rust: return;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let amount = m.random.next_int_bound(2).unwrap_or(0) as u32;
    // rust: if amount == 0 {
    // rust: return;
}
    // rust: let loss = self.durability_loss(&stack, amount);
    // rust: if loss == 0 {
    // rust: return;
}
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage);
    // rust: stack.damage += loss;
    // rust: let broke = stack.damage >= max;
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: match (body, broke) {
    // rust: (true, false) => m.extra.body_damage = stack.damage as i32,
    // rust: (true, true) => {
    // rust: m.extra.body = None;
    // rust: m.extra.body_damage = 0;
}
    // rust: (false, false) => m.extra.armor[0] = Some(stack),
    // rust: (false, true) => {
    // rust: m.extra.head = None;
    // rust: m.extra.armor[0] = None;
}
}
    // rust: if broke {
            // LivingEntity.entityEventForEquipmentBreak: head 49, body 65.
    // rust: self.lan_entity_event(id as i32, if body { 65 } else { 49 }, at);
}
}
    // `LivingEntity.hurtArmor` -> `LivingEntity.doHurtEquipment`, from the hit
    // `MobEvent::ArmorHurt` reported. Only `Horse` overrides `hurtArmor` for a
    // mob, and its override asks for the BODY slot alone, so the body piece is
    // the only one this wears: it loses `max(1, damage / 4)` durability,
    // Unbreaking applied, and at its maximum the slot empties and the break
    // event goes out (`LivingEntity.entityEventForEquipmentBreak`: 65 for the
    // body — 49 to 52 are the four armour slots, which only a player's own
    // pieces reach). A fire hit leaves a fire-resistant piece alone
    // (`ItemStack.canBeHurtBy`).
hurt_mob_armor :: proc(self: ^Self, id: u32, damage: f32, kind: horizon_client::mobs::DamageKind) {
}
//         use horizon_world::player_inventory::EquipmentSlot;
    // rust: if damage <= 0.0 {
    // rust: return;
}
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let amount = ((damage / 4.0) as u32).max(1);
    // rust: let name = damage_type(kind, false);
    // rust: let fire = self
    // rust: .health_resources
    // rust: .damage
    // rust: .id(name)
    // rust: .is_some_and(|d| self.health_resources.damage.in_tag(d, "minecraft:is_fire"));
        // A piece's maximum, or none when it may not lose durability at all.
        // `doHurtEquipment` starts from the item's `equippable` component
        // (`Equippable equippable = item.get(DataComponents.EQUIPPABLE)`), so a
        // damageable item with no such component — a sword put in a horse's body
        // slot by `/item replace` — never wears; `equip_damage_on_hurt` alone
        // cannot say that, since it defaults to true when the component is absent.
wearable :: proc(me: ^Game<'_>, stack: ^ItemStack, fire: bool, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let info = me.res.items().get(&stack.item)?;
    // rust: if info.equip_slot.is_none()
    // rust: || !info.equip_damage_on_hurt
    // rust: || info.max_damage == 0
    // rust: || !horizon_client::stations::is_damageable(me.res.items(), stack)
    // rust: || (fire && me.res.items().resists_fire(stack, name))
    // rust: {
    // rust: return None;
}
    // rust: Some(info.max_damage)
}
    // rust: let Some(body) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .and_then(|m| m.item_by_slot(EquipmentSlot::Body))
    // rust: else {
    // rust: return;
}
    // rust: let Some(max) = wearable(self, &body, fire, name) else {
    // rust: return;
}
    // rust: let loss = self.durability_loss(&body, amount);
    // rust: if loss == 0 {
    // rust: return;
}
    // rust: let lost = body.damage + loss;
    // rust: let broke = {
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: if lost >= max {
    // rust: m.extra.body = None;
    // rust: m.extra.body_damage = 0;
    // rust: true
    // rust: } else {
    // rust: m.extra.body_damage = lost as i32;
    // rust: false
}
}
    // rust: if broke {
            // LivingEntity.onEquippedItemBroken through the level's broadcast.
    // rust: let event =
    // rust: horizon_client::mobs::item_break::equipment_break_event(EquipmentSlot::Body);
    // rust: self.lan_entity_event(id as i32, event, at);
}
}
    // What a converted frog gets once its tadpole has grown up: the spawn
    // finalization of a conversion, then persistence.
finalize_converted :: proc(self: ^Self, id: u32) {
}
    // rust: let Some(at) = self.mobs.iter().find(|m| m.id == id).map(|m| m.position) else {
    // rust: return;
}
    // rust: let facts = self.biome_facts(
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: );
    // rust: let difficulty = self.local_difficulty([at.x, at.y, at.z]);
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: spawning::finalize(m, &facts, &difficulty);
    // rust: m.persistent = true;
}
}
    // `Mob.convertTo(type, ConversionParams.single(...))` for a mob already
    // removed: a new mob of `kind`, made without spawn finalization, takes
    // its place with what `conversion::single` carries over, and the old
    // mob's riders move onto it. A zombie that comes out of it rolls
    // `Zombie.handleAttributes(special, CONVERSION)` (the
    // `postConversionStep` of its `ConversionTracker`).
    // rust: pub(super) fn convert_to(
    // rust: &mut self,
    // rust: from: &Mob,
    // rust: kind: &str,
    // rust: params: horizon_client::mobs::conversion::Params,
    // rust: ) -> Option<u32> {
    // rust: let t = self.res.mob_types().get(kind).cloned()?;
        // LivingConversionEvent.Pre: the caller already marked the mob removed,
        // so a canceled conversion puts it back as it was.
    // rust: let mut cancel = false;
    // rust: let from_kind = super::native_hooks::mob_kind(from);
    // rust: self.native_living_conversion_pre(from.id, &from_kind, kind, &mut cancel);
    // rust: if cancel {
    // rust: match self.mobs.iter_mut().find(|m| m.id == from.id) {
    // rust: Some(kept) => kept.removed = false,
    // rust: None => {
    // rust: let mut kept = from.clone();
    // rust: kept.removed = false;
    // rust: self.mobs.push(kept);
}
}
    // rust: return None;
}
    // rust: self.next_entity += 1;
    // rust: let mut mob = Mob::new(self.next_entity, t, from.position, from.yaw);
    // rust: horizon_client::mobs::conversion::single(from, &mut mob, params);
    // rust: if matches!(from.species(), Species::Zombie | Species::Husk) {
    // rust: let at = [from.position.x, from.position.y, from.position.z];
    // rust: let special = self.local_difficulty(at).special();
    // rust: horizon_client::mobs::finalize::zombie_attributes(
    // rust: &mut mob,
    // rust: special,
    // rust: horizon_client::mobs::finalize::Reason::Conversion,
    // rust: );
}
    // rust: let id = mob.id;
        // ConversionType.SINGLE: the passengers get off and board the new mob.
    // rust: for rider in self.mobs.iter_mut() {
    // rust: if rider.extra.mount == Some(from.id) {
    // rust: rider.extra.mount = Some(id);
}
}
    // rust: if let Some(raw) = horizon_client::entity_nbt::conversion_tags(self.persist_raw(from.id)) {
    // rust: self.persist.raw.insert(id, raw);
}
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: let transformed_kind = self
    // rust: .mobs
    // rust: .last()
    // rust: .expect("converted mob was just inserted")
    // rust: .kind
    // rust: .id
    // rust: .clone();
    // rust: self.native_entity_transform(from.id, &from.kind.id, id, &transformed_kind);
    // rust: self.native_living_conversion_post(from.id, &from_kind, id, &transformed_kind);
    // rust: Some(id)
}
    // Default position for a summon command (3 blocks in front of the player).
    // rust: pub(super) fn default_summon_position(&self) -> Result<[f64; 3]> {
    // rust: let p = self.player.as_ref().ok_or("no player yet")?;
    // rust: let d = view_vector(self.yaw, 0.0);
    // rust: Ok([
    // rust: p.position.x + d[0] * 3.0,
    // rust: p.position.y,
    // rust: p.position.z + d[2] * 3.0,
    // rust: ])
}
    // The `summon` command: spawn a mob in front of the player or at a position.
    // rust: pub(super) fn summon(&mut self, kind: &str, at: Option<[f64; 3]>, baby: bool) -> Result<u32> {
    // rust: let at = match at {
    // rust: Some(a) => a,
    // rust: None => self.default_summon_position()?,
}
    // rust: let id = self
    // rust: .spawn_mob_spawned(kind, at)
    // rust: .ok_or_else(|| format!("unknown or unsupported mob {kind}"))?;
    // rust: if baby && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.extra.age = if m.species() == Species::Sniffer {
    // rust: horizon_client::mobs::sniffer::BABY_START_AGE
    // rust: } else {
    // rust: -24000
}
}
    // rust: self.spawn_jockeys(id, false);
    // rust: Ok(id)
}
    // The `mobs` command: nearby mobs with position, health and running goals.
    // rust: pub(super) fn control_mobs(&self, radius: f64) -> serde_json::Value {
    // rust: let center = self.player.as_ref().map_or(Vec3::ZERO, |p| p.position);
    // rust: self.control_mobs_at(radius, center)
}
    // rust: pub(super) fn control_mobs_at(&self, radius: f64, center: Vec3) -> serde_json::Value {
    // rust: let list: Vec<serde_json::Value> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.distance_sqr(center) <= radius * radius)
    // rust: .map(|m| {
    // rust: let mut state = serde_json::json!({
    // rust: "id": m.id,
    // rust: "kind": m.kind.id,
    // rust: "pos": [m.position.x, m.position.y, m.position.z],
    // rust: "health": m.health,
    // rust: "baby": m.is_baby(),
    // rust: "target": m.ai.target.map(|t| format!("{t:?}")),
    // rust: "goals": m.ai.goals.running_names(),
    // rust: "held": m.extra.main_hand.as_deref(),
    // rust: "mount": m.extra.mount,
    // rust: "rider": m.extra.rider,
                    // A player's input this tick, and whether it steers.
    // rust: "ridden": m.rider.map(|r| r.steer),
    // rust: "controlled": horizon_client::mobs::equine::controlled(m),
    // rust: "saddled": m.extra.saddled,
    // rust: "enchants": horizon_client::mobs::gear::gear(m).map(|g| g.slots.iter().map(|s| s.iter().map(|(e, l)| format!("{e}:{l}")).collect::<Vec<_>>()).collect::<Vec<_>>()),
    // rust: "ints": m.extra.ints,
    // rust: "pois": [m.extra.home, m.extra.bed, m.extra.meeting],
    // rust: "profession": m.extra.variant2,
    // rust: "targets": m.ai.targets.running_names(),
    // rust: "path": m.ai.nav.path.as_ref().map(|p| p.nodes.len() - p.next.min(p.nodes.len())),
    // rust: "on_ground": m.on_ground,
    // rust: "variant": m.extra.variant,
    // rust: "color": m.extra.color,
    // rust: "sheared": m.extra.sheared,
    // rust: "burning": m.fire_ticks > 0,
    // rust: "size": m.extra.size,
    // rust: "leash": m.extra.leash.map(|h| format!("{h:?}")),
    // rust: "tame": m.extra.tame,
    // rust: "sitting": m.extra.sitting,
    // rust: "temper": m.extra.variant3,
    // rust: "chested": m.extra.chested,
    // rust: });
                // Set apart: one json! with every key goes past the default macro recursion
                // limit, and horizon-client can't raise it (#8169).
    // rust: state["head"] = m.extra.head.as_deref().into();
    // rust: state["body"] = m.extra.body.as_deref().into();
    // rust: state["warden"] = serde_json::json!(horizon_client::mobs::warden::describe(m));
    // rust: state["villager"] = serde_json::json!(horizon_client::mobs::villager::ext(m).map(|e| serde_json::json!({
    // rust: "food_level": e.food_level,
    // rust: "inventory": e.inventory.iter().map(|s| format!("{}x{}", s.count, s.item)).collect::<Vec<_>>(),
    // rust: "gossips": e.gossips.len(),
    // rust: "last_slept": e.last_slept,
    // rust: "raid": e.raid,
    // rust: })));
    // rust: state["raider"] = serde_json::json!(horizon_client::mobs::raider::state(m).map(|s| serde_json::json!({
    // rust: "raid": s.raid_id,
    // rust: "wave": s.wave,
    // rust: "leader": s.patrol_leader,
    // rust: "patrolling": s.patrolling,
    // rust: "patrol_target": s.patrol_target,
    // rust: "vehicle": m.extra.mount,
    // rust: })));
                // Drawn seated (Entity.isPassenger).
    // rust: state["passenger"] = m.extra.passenger.into();
    // rust: state["guardian_beam"] = serde_json::json!(horizon_client::mobs::guardian::beam(m, 0.0));
    // rust: state
    // rust: })
    // rust: .collect();
    // rust: serde_json::json!({ "count": self.mobs.len(), "near": list, "projectiles": self.creatures.projectiles.len() })
}
    // Highest motion-blocking (no leaves) block + 1 (Heightmap MOTION_BLOCKING_NO_LEAVES).
    // rust: pub(super) fn motion_top(&self, x: i32, z: i32) -> i32 {
    // rust: let top = if self.dim == Dim::Nether { 127 } else { 319 };
    // rust: for y in (self.world.bottom_y()..=top).rev() {
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: if (f.full_collision || f.fluid != Fluid::None) && !f.name.ends_with("leaves") {
    // rust: return y + 1;
}
}
    // rust: self.world.bottom_y()
}
    // rust: pub(super) fn mob_world_base<'s>(&'s self, others: &'s [Seen]) -> MobWorld<'s> {
    // rust: let (rain, thunder) = self.weather_levels(1.0);
    // rust: let weather = self.can_have_weather();
    // rust: let player = self.player_view();
    // rust: MobWorld {
    // rust: world: &self.world,
    // rust: registry: self.pack.assets.registry,
    // rust: facts: self.res.facts(),
    // rust: fluid_tables: &self.motion.fluids,
    // rust: movement: &self.motion.blocks,
    // rust: collision: self.collision,
    // rust: suffocation: self.mob_suffocation(),
    // rust: data: self.res.mob_data(),
    // rust: controlling_player_movement: None,
    // rust: nearest_player: player.as_ref().filter(|p| !p.spectator).map(|p| p.position),
    // rust: player,
    // rust: others,
    // rust: dragon: self.dragon_target(),
    // rust: leash_boats: &self.leash_boats,
    // rust: others_grid: None,
    // rust: others_index: None,
    // rust: others_villagers: None,
    // rust: daylight: self.dim != Dim::Nether && self.sky_darken() < 4,
            // day.json: false from tick 12542, true from 23460 (a step track).
    // rust: monsters_burn: self.dim == Dim::Overworld
    // rust: && !(12542..23460).contains(&self.world.day_time.rem_euclid(24000)),
    // rust: game_time: self.world.game_time,
    // rust: day_time: self.world.day_time,
    // rust: raining: weather && rain > 0.2,
    // rust: thundering: weather && thunder > 0.9,
    // rust: nether: self.dim == Dim::Nether,
    // rust: block_tags: &self.items().block_tags,
    // rust: landing: &self.motion.landing,
    // rust: biomes: world_biomes!(self),
    // rust: mob_griefing: self.ui.rules.bool("mob_griefing"),
    // rust: universal_anger: self.ui.rules.bool("universal_anger"),
    // rust: mob_drops: self.ui.rules.bool("mob_drops"),
    // rust: max_entity_cramming: self.ui.rules.int("max_entity_cramming"),
    // rust: end: self.dim == Dim::End,
    // rust: world_seed: self.level.seed,
    // rust: sea_level: if self.dim == Dim::Nether { 32 } else { 63 },
    // rust: teams: std::sync::Arc::new(self.mob_teams()),
    // rust: items: Some(self.items()),
    // rust: lid_openers: &self.lid_openers,
    // rust: mod_effects: if self.remote.is_none() {
    // rust: Some(self)
    // rust: } else {
    // rust: None
    // rust: },
    // rust: border: Some(self.border.geometry()),
            // The first player in the level: a server has no player of its own.
    // rust: difficulty: self.local_difficulty(
    // rust: self.level_players()
    // rust: .first()
    // rust: .map_or([0.0; 3], |p| [p.position.x, p.position.y, p.position.z]),
    // rust: ),
}
}
    // What the generator finalizes this level's structure mobs with.
    // rust: pub(super) fn share_spawn_conditions(&self) {
    // rust: if let Some(terrain) = self.end.locator() {
    // rust: terrain.set_spawn_conditions(self.difficulty_id() as u8, self.world.day_time);
}
}
    // `ServerLevel.getCurrentDifficultyAt`.
    // rust: pub(super) fn local_difficulty(&self, at: [f64; 3]) -> spawning::LocalDifficulty {
//         use horizon_world::food::Difficulty;
    // rust: let base = match self.world.health_rules.difficulty {
    // rust: Difficulty::Peaceful => 0,
    // rust: Difficulty::Easy => 1,
    // rust: Difficulty::Normal => 2,
    // rust: Difficulty::Hard => 3,
}
    // rust: let key = ((at[0].floor() as i32) >> 4, (at[2].floor() as i32) >> 4);
    // rust: let (inhabited, moon) = if self.world.chunks.contains_key(&key) {
    // rust: let phase = self.world.day_time.div_euclid(24000).rem_euclid(8) as usize;
    // rust: (
    // rust: self.world.inhabited.get(&key).copied().unwrap_or(0),
    // rust: spawning::MOON_BRIGHTNESS[phase],
    // rust: )
    // rust: } else {
    // rust: (0, 0.0)
}
    // rust: spawning::LocalDifficulty::new(base, self.world.day_time, inhabited, moon)
}
    // Generation's animals for the chunks generated since, once lit: chunk
    // generation places them whether the level ticks or not.
    // rust: pub(super) fn spawn_fresh_chunks(&mut self) {
    // rust: if !self.world.chunks.has_fresh() {
    // rust: return;
}
    // rust: let fresh: Vec<(i32, i32)> = self
    // rust: .world
    // rust: .chunks
    // rust: .fresh_keys_ordered()
    // rust: .into_iter()
    // rust: .filter(|k| self.world.chunks.get(k).is_some_and(|c| c.fresh && c.lit))
    // rust: .collect();
    // rust: for key in fresh {
    // rust: if let Some(c) = self.world.chunks.get_mut(&key) {
    // rust: Arc::make_mut(c).fresh = false;
}
    // rust: self.world.chunks.remove_fresh(&key);
    // rust: self.spawn_generation_creatures(key.0, key.1);
}
}
    // Advance every mob one tick, then apply their events.
    // rust: pub(super) fn tick_creatures(&mut self) -> Result<()> {
    // rust: self.attack_ticks = self.attack_ticks.saturating_add(1);
    // rust: self.refresh_gear_knockback_resistance();
    // rust: self.tick_leads();
        // Vanilla's spawning and raids run before ChunkMap.tick.
    // rust: let from = self.lan_synced_from();
    // rust: horizon_client::spans::time("spawn_natural", || self.spawn_natural());
        // ServerChunkCache.tickChunks: the custom spawners tick only with spawn_mobs.
    // rust: if self.ui.rules.bool("spawn_mobs") {
    // rust: self.tick_wandering_trader();
    // rust: self.tick_patrol_spawner();
    // rust: self.tick_cat_spawner();
    // rust: self.tick_village_siege();
}
    // rust: self.tick_raids();
    // rust: self.lan_synced_since(from);
    // rust: let ticked =
    // rust: horizon_client::spans::time("tick_creature_entities", || self.tick_creature_entities());
    // rust: self.dismount_underwater_mob_riders();
    // rust: ticked
}
    // `DistanceManager.inEntityTickingRange` in an entity-ticking chunk
    // (block coordinates), from every player's tickets (`update_chunk_tickets`).
    // rust: pub(super) fn entity_ticking_area(&self) -> impl Fn(i32, i32) -> bool + use<> {
    // rust: let levels = self.tickets.levels();
    // rust: move |x, z| levels.entity_ticking_at(x, z)
}
    // The entity phase of `tick_creatures`: every mob's tick, deaths, and the
    // projectiles and effects that follow from them.
    // rust: pub(super) fn tick_creature_entities(&mut self) -> Result<()> {
        // Its steps as spans for `horizon-report` (nothing is read while spans are off).
    // rust: let mut laps = horizon_client::spans::laps();
        // LivingEntity.die runs when the killing blow lands: mobs killed
        // since the last tick (by the player, explosions...) die first.
    // rust: let killed: Vec<Mob> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| !m.alive() && !m.removed && !self.died.contains(&m.id))
    // rust: .cloned()
    // rust: .collect();
    // rust: for m in killed {
    // rust: self.died.insert(m.id);
    // rust: self.mob_died(&m);
}
        // Their victims have been looted and mourned: no charged creeper is
        // waiting any more.
    // rust: self.combat.charged_exploders.clear();
    // rust: self.combat.exploded.clear();
        // EntityTickEvent.Pre for the mobs about to tick, before the loop holds them.
    // rust: let mut round = self.native_tick_round();
    // rust: if round.listening() {
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut i = 0;
    // rust: while let Some(m) = self.mobs.get(i) {
    // rust: let (x, z) = (m.position.x.floor() as i32, m.position.z.floor() as i32);
    // rust: if self.world.loaded(x, z) && ticking(x, z) {
    // rust: let (id, kind) = (m.id, super::native_ticks::TickKind::Mob(m.kind.clone()));
    // rust: self.native_tick_pre_batch(&mut round, id, kind);
}
    // rust: i += 1;
}
}
    // rust: let uuid = self.level.player_uuid;
    // rust: let level_id = self.dim.id();
    // rust: let mut snapshot = std::mem::take(&mut self.creatures.seen_buf);
    // rust: snapshot.extend(self.mobs.iter().map(|m| seen(m, uuid)));
    // rust: let mut events = Vec::new();
    // rust: let mut mobs = std::mem::take(&mut self.mobs);
    // rust: let mut dead = Vec::new();
    // rust: let mut corpses = Vec::new();
    // rust: let mut died = std::mem::take(&mut self.died);
    // rust: let mut ticked = std::mem::take(&mut self.creatures.ticked);
    // rust: ticked.clear();
    // rust: let ticking = self.entity_ticking_area();
        // With guests on, each mob sees its nearest player (game/lan_mobs.rs).
    // rust: let mut guests = self.lan_guest_views();
        // What stands in a guest's slot while a mob holds that guest's view for
        // its tick (see `lent` below).
    // rust: let mut spare = guests.first().map(|g| g.1.clone());
    // rust: let players = self.level_players();
    // rust: let nearest = super::natural_spawning::NearestPlayers::new(&players);
    // rust: let mut bindings = match self.lan.as_mut() {
    // rust: Some(host) if !guests.is_empty() => std::mem::take(&mut host.mob_players),
    // rust: _ => Default::default(),
}
        // The guests' entity ids by connection, for the shulker bullets fired
        // at the guest a mob sees.
    // rust: let guest_ids: Vec<(u32, u32)> = match self.lan.as_ref() {
    // rust: Some(host) if !guests.is_empty() => host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .map(|g| (g.conn, g.entity_id as u32))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let mut guest_events = Vec::new();
        // The block writes since the last tick: mobs re-path around them.
    // rust: let path_writes = self
    // rust: .world
    // rust: .path_writes
    // rust: .get_or_insert_with(Vec::new)
    // rust: .split_off(0);
        // The mobs whose bodies go this tick: (id, feet, width, height).
    // rust: let mut gone = Vec::new();
    // rust: let level_random;
    // rust: {
            // The level random, lent to the mobs (brain behaviours draw from
            // it) and taken back after their ticks.
    // rust: let mut scratch = self.world.random.clone();
    // rust: let mut pushes = horizon_client::mobs::PendingPushes::default();
    // rust: let mut keep = Vec::with_capacity(mobs.len());
    // rust: let mut grid =
    // rust: horizon_client::mobs::seen_grid::SeenGrid::new(snapshot.iter().map(|s| s.bounds));
            // All but the snapshot is the same for every mob of the tick, so
            // build it once: the player view and the teams scan every UUID.
    // rust: self.leash_boats = self
    // rust: .boats
    // rust: .iter()
    // rust: .map(super::boat_leads::boat_state)
    // rust: .collect();
    // rust: let mut base = self.mob_world_base(&[]);
    // rust: let path_changes = horizon_client::mobs::collision_changes(&base, &path_writes);
            // Each mob keeps its snapshot slot all tick; the first slot of an
            // id answers, as a scan would.
    // rust: let mut index = horizon_client::fast_hash::FxHashMap::<u32, u32>::default();
    // rust: let mut villager_slots = Vec::new();
    // rust: for (i, s) in snapshot.iter().enumerate() {
    // rust: index.entry(s.id).or_insert(i as u32);
    // rust: if s.species == horizon_client::mobs::Species::Villager {
    // rust: villager_slots.push(i as u32);
}
}
    // rust: laps.lap("creature_prepare");
    // rust: let mut cached_difficulty: Option<((i32, i32), spawning::LocalDifficulty)> = None;
    // rust: for i in 0..mobs.len() {
    // rust: let m = &mut mobs[i];
    // rust: let (bx, bz) = (m.position.x.floor() as i32, m.position.z.floor() as i32);
    // rust: let seen_guest = if guests.is_empty() {
    // rust: None
    // rust: } else {
    // rust: let bound = bindings.get(&m.id).copied();
    // rust: let conn = super::lan_mobs::player_for(m, base.player.as_ref(), &guests, bound);
    // rust: match conn {
    // rust: Some(conn) => {
    // rust: bindings.insert(m.id, conn);
}
    // rust: None => {
    // rust: bindings.remove(&m.id);
}
}
    // rust: conn
}
    // rust: if !base.world.loaded(bx, bz) {
    // rust: keep.push(!m.hostile() || m.persistent);
    // rust: continue;
}
    // rust: let nearest_player = nearest
    // rust: .nearest(m.position.x, m.position.y, m.position.z)
    // rust: .map(|p| p.position);
                // ServerLevel.tick: every loaded entity checks despawning, but
                // only those in entity-ticking chunks (within the simulation
                // distance) tick. The despawn check reads the nearest player
                // and the difficulty, not the player the mob sees.
    // rust: if !ticking(bx, bz) {
    // rust: let w = MobWorld {
    // rust: others: &snapshot,
    // rust: others_grid: Some(&grid),
    // rust: others_index: Some(&index),
    // rust: others_villagers: Some(&villager_slots),
    // rust: nearest_player,
    // rust: player: None,
    // rust: teams: std::sync::Arc::clone(&base.teams),
    // rust: ..base
}
    // rust: let kept = horizon_client::mobs::ai::despawn_check(m, &w);
    // rust: if !kept {
    // rust: died.remove(&m.id);
    // rust: snapshot[i].alive = false;
}
    // rust: keep.push(kept);
    // rust: continue;
}
    // rust: let controlling_player_movement = horizon_client::mobs::equine::controlled(m)
    // rust: .then(|| {
    // rust: base.player
    // rust: .as_ref()
    // rust: .filter(|p| p.riding_vehicle == Some(m.id))
    // rust: .map(|p| p.velocity)
    // rust: .or_else(|| {
    // rust: guests
    // rust: .iter()
    // rust: .find(|(_, p)| p.riding_vehicle == Some(m.id))
    // rust: .map(|(_, p)| p.velocity)
    // rust: })
    // rust: })
    // rust: .flatten();
                // A mod canceled its tick: it stays as it is.
    // rust: if round.canceled(m.id) {
    // rust: keep.push(true);
    // rust: continue;
}
                // getCurrentDifficultyAt(blockPosition()): the mob's own chunk,
                // not the local player's (a server thread has no player).
    // rust: let chunk_key = (bx >> 4, bz >> 4);
    // rust: let difficulty = match cached_difficulty {
    // rust: Some((key, difficulty)) if key == chunk_key => difficulty,
    // rust: _ => {
    // rust: let difficulty =
    // rust: self.local_difficulty([m.position.x, m.position.y, m.position.z]);
    // rust: cached_difficulty = Some((chunk_key, difficulty));
    // rust: difficulty
}
}
    // rust: horizon_client::mobs::apply_mob_pushes(m, &mut pushes);
    // rust: horizon_client::mobs::blocks_changed(m, &path_changes);
    // rust: let from = events.len();
                // The guest's view is lent to the mob for its tick, not copied:
                // the tick only reads it (`&MobWorld`), and it goes back to the
                // guest's slot straight after.
    // rust: let lent = seen_guest.and_then(|conn| guests.iter().position(|g| g.0 == conn));
    // rust: let active_player = match (seen_guest, lent) {
    // rust: (None, _) => base.player.take(),
    // rust: (Some(_), Some(k)) => spare
    // rust: .take()
    // rust: .map(|stand_in| std::mem::replace(&mut guests[k].1, stand_in)),
    // rust: (Some(_), None) => None,
}
    // rust: let mut w = MobWorld {
    // rust: others: &snapshot,
    // rust: others_grid: Some(&grid),
    // rust: others_index: Some(&index),
    // rust: others_villagers: Some(&villager_slots),
    // rust: difficulty,
    // rust: nearest_player,
    // rust: player: active_player,
    // rust: teams: std::sync::Arc::clone(&base.teams),
    // rust: ..base
}
    // rust: w.controlling_player_movement = controlling_player_movement;
    // rust: ticked.insert(mobs[i].id);
                // `horizon-report`'s cost by mob type (tick_profile.rs).
    // rust: let sampled = super::tick_profile::start().map(|t| (t, mobs[i].kind.clone()));
    // rust: let kept =
    // rust: horizon_client::mobs::riders::tick(&mut mobs, i, &w, &mut scratch, &mut events);
    // rust: if let Some((started, kind)) = sampled {
    // rust: super::tick_profile::add(level_id, &kind, started);
}
    // rust: let m = &mut mobs[i];
    // rust: if seen_guest.is_none() {
    // rust: base.player = w.player;
    // rust: } else if let Some(k) = lent {
    // rust: spare = w.player.map(|v| std::mem::replace(&mut guests[k].1, v));
}
                // A killed mob's body is removed: its effects that act on
                // death run (`LivingEntity.remove` with KILLED).
    // rust: if !kept && !m.alive() && !m.removed && !m.extra.effects.is_empty() {
    // rust: corpses.push(m.clone());
}
    // rust: horizon_client::mobs::take_mob_pushes(&mut events, from, &mut pushes);
                // LivingEntity.tickDeath: after twenty ticks the body is removed.
    // rust: if !kept && !m.removed && !m.alive() && m.death_time >= 20 {
    // rust: let (width, height) = (f64::from(m.width()), f64::from(m.height()));
    // rust: gone.push((m.id, m.position, width, height));
}
    // rust: if let Some(conn) = seen_guest {
                    // ShulkerBullet.finalTarget is the guest's entity: the
                    // bullet homes on it while the projectiles tick, where
                    // `Who::Player` is the host's own player.
    // rust: if let Some(&(_, id)) = guest_ids.iter().find(|g| g.0 == conn) {
    // rust: for e in &mut events[from..] {
    // rust: if let MobEvent::Projectile(p) = e
    // rust: && let ProjectileKind::ShulkerBullet { target, .. } = &mut p.kind
    // rust: && *target == Some(Who::Player)
    // rust: {
    // rust: *target = Some(Who::Mob(id));
}
}
}
    // rust: let mut k = from;
    // rust: while k < events.len() {
    // rust: if super::lan_mobs::acts_on_player(&events[k]) {
    // rust: guest_events.push((conn, events.remove(k)));
    // rust: } else {
    // rust: k += 1;
}
}
}
                // Killed during its own tick (drowning, burning, falling...).
    // rust: if !m.alive() && !m.removed && died.insert(m.id) {
    // rust: dead.push(m.clone());
}
    // rust: if !kept {
    // rust: died.remove(&m.id);
}
    // rust: keep.push(kept);
                // ServerLevel ticks entities one after another: the ones
                // after this mob see it as it is now.
    // rust: snapshot[i] = seen(m, uuid);
    // rust: snapshot[i].alive &= kept;
    // rust: grid.update(i, snapshot[i].bounds);
    // rust: horizon_client::mobs::apply_brain_events(&mut mobs, &mut events, from);
}
    // rust: laps.lap("creature_loop");
    // rust: let mut flags = keep.into_iter();
    // rust: mobs.retain(|_| flags.next().unwrap_or(true));
    // rust: for m in &mut mobs {
    // rust: horizon_client::mobs::apply_mob_pushes(m, &mut pushes);
}
    // rust: level_random = scratch;
}
    // rust: self.world.random = level_random;
    // rust: if let Some(host) = self.lan.as_mut()
    // rust: && !guests.is_empty()
    // rust: {
            // A set: a scan of every mob for each binding is quadratic, and a
            // server's loaded mobs run into the thousands.
    // rust: let live: horizon_client::fast_hash::FxHashSet<u32> =
    // rust: mobs.iter().map(|m| m.id).collect();
    // rust: bindings.retain(|id, _| live.contains(id));
    // rust: host.mob_players = bindings;
}
        // The mobs added during the tick (into the emptied `self.mobs`) come
        // first, as `append` put them; with none, the ticked list goes back
        // as it is instead of being copied into a new one, every mob a tick.
    // rust: if self.mobs.is_empty() {
    // rust: self.mobs = mobs;
    // rust: } else {
    // rust: self.mobs.append(&mut mobs);
}
    // rust: self.died = died;
    // rust: snapshot.clear();
    // rust: self.creatures.seen_buf = snapshot;
    // rust: self.creatures.ticked = ticked;
    // rust: self.native_tick_post_batch(round);
        // ... and entity event 60 goes out as it is: the poof.
    // rust: for (id, at, width, height) in gone {
    // rust: let at = [at.x, at.y, at.z];
    // rust: self.lan_entity_event(id as i32, 60, at);
    // rust: self.death_poof(at, width, height);
}
    // rust: laps.lap("creature_retain");
    // rust: self.tick_boarding();
    // rust: self.sync_riders();
    // rust: self.tick_skeleton_traps();
    // rust: self.tick_apparition();
    // rust: self.guardian_bubbles();
    // rust: self.villager_reputation_tick();
    // rust: self.villager_item_sense();
    // rust: self.villager_pickups();
    // rust: laps.lap("creature_villagers");
    // rust: for m in dead {
    // rust: self.mob_died(&m);
}
    // rust: for mut m in corpses {
    // rust: let names: Vec<&'static str> = m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .map(|e| e.0.trim_start_matches("minecraft:"))
    // rust: .collect();
    // rust: let bounds = m.bounds();
    // rust: self.effects_on_death(&names, bounds, false, Some(m.id), Some(&mut m.random));
}
    // rust: self.handle_mob_events(events)?;
    // rust: self.lan_guest_mob_events(guest_events);
    // rust: laps.lap("creature_events");
    // rust: self.ordered_before(super::ordered_tick::Batch::Projectiles)?;
    // rust: self.tick_projectiles()?;
    // rust: self.tick_fangs();
    // rust: laps.lap("creature_projectiles");
    // rust: self.tick_allays();
    // rust: self.tick_pandas();
    // rust: self.tick_foxes();
    // rust: self.tick_dolphins();
    // rust: self.tick_mob_looting();
    // rust: self.tick_breeze_effects();
    // rust: self.tick_sniffer_effects();
    // rust: self.piglin_pickups();
    // rust: self.sulfur_cube_pickups();
    // rust: self.sulfur_cube_power_priming();
    // rust: laps.lap("creature_systems");
        // Hurt and death sounds of damage dealt outside the mob ticks.
    // rust: let mut queued = Vec::new();
    // rust: for m in &mut self.mobs {
    // rust: queued.append(&mut m.outbox);
}
    // rust: self.handle_mob_events(queued)?;
    // rust: laps.lap("creature_outbox");
    // rust: Ok(())
}
    // `LivingEntity.makePoofParticles` (entity event 60) about a mob's box.
    // rust: pub(super) fn death_poof(&mut self, at: [f64; 3], width: f64, height: f64) {
    // rust: let options = horizon_client::particles::ParticleOptions::simple(
    // rust: horizon_client::particles::ParticleType::Poof,
    // rust: );
    // rust: for _ in 0..20 {
    // rust: let r = self.particles.level_random();
    // rust: let xa = r.next_gaussian() * 0.02;
    // rust: let ya = r.next_gaussian() * 0.02;
    // rust: let za = r.next_gaussian() * 0.02;
    // rust: let x = at[0] + width * (2.0 * r.next_double() - 1.0) - xa * 10.0;
    // rust: let y = at[1] + height * r.next_double() - ya * 10.0;
    // rust: let z = at[2] + width * (2.0 * r.next_double() - 1.0) - za * 10.0;
    // rust: self.particles.add(&options, [x, y, z], [xa, ya, za]);
}
}
    // `LivingDeathEvent` for a mob whose health ran out: whether a native
    // mod canceled the death. A canceled mob stays alive at 1 health.
mob_death_canceled :: proc(self: ^Self, m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return false;
}
    // rust: let (damage_type, attacker) = match m.last_damage {
    // rust: Some((d, _)) => (source_damage_type(d), d.attacker),
    // rust: None => ("minecraft:generic", None),
}
    // rust: let attacker = match attacker {
    // rust: Some(Who::Mob(id)) => id,
    // rust: Some(Who::Player) => {
    // rust: let conn = self.last_hurt_by_player.get(&m.id).copied().flatten();
    // rust: let guests = self.lan.as_ref().map(|host| host.hub.guests.as_slice());
    // rust: let guest = guests.and_then(|all| all.iter().find(|g| Some(g.conn) == conn));
    // rust: guest.map_or(0, |g| g.entity_id as u32)
}
    // rust: None => 0,
}
    // rust: let kind = super::native_hooks::mob_kind(m);
    // rust: let mut cancel = false;
    // rust: self.native_living_death(m.id, &kind, damage_type, attacker, &mut cancel);
    // rust: if cancel {
    // rust: self.died.remove(&m.id);
    // rust: if let Some(alive) = self.mobs.iter_mut().find(|o| o.id == m.id) {
    // rust: alive.health = 1.0;
    // rust: alive.death_time = 0;
}
}
    // rust: cancel
}
    // LivingEntity.die / dropAllDeathLoot.
mob_died :: proc(self: ^Self, m: ^Mob) {
}
    // rust: if self.mob_death_canceled(m) {
    // rust: return;
}
        // LivingEntity.die: a sleeper gets up, and its bed is free again.
    // rust: if let Some(bed) = horizon_client::mobs::villager::sleeping_pos(m) {
    // rust: self.wake_villager(m.id);
            // The body may be gone already.
    // rust: self.set_bed_occupied(bed, false);
}
    // rust: let killer = self.last_hurt_by_player.remove(&m.id);
        // TamableAnimal.die, before the rest of LivingEntity.die.
    // rust: self.tell_owner_pet_died(m, killer);
    // rust: self.love_cause.remove(&m.id);
    // rust: let by_player = killer.is_some() || m.ai.last_hurt_by_player > 0;
    // rust: let mut dying = m.clone();
        // LivingEntity.die: the death is heard, and a sculk catalyst nearby
        // takes the experience (before the loot is dropped). It takes what
        // would drop, whoever killed the mob.
    // rust: self.sculk_mob_died(m);
    // rust: let mut catalyst_xp = 0;
    // rust: let consumed =
    // rust: self.catalyst_takes_experience([m.position.x, m.position.y, m.position.z], |_| {
    // rust: catalyst_xp = if horizon_client::mobs::drops::drops_experience(&dying) {
    // rust: horizon_client::mobs::drops::base_experience(&mut dying).max(0) as u32
    // rust: } else {
    // rust: 0
}
    // rust: catalyst_xp
    // rust: });
        // CatalystListener: with experience to take, the player who last hurt
        // the mob gets KILL_MOB_NEAR_SCULK_CATALYST.
    // rust: if consumed && catalyst_xp > 0 {
    // rust: let who = match killer {
    // rust: Some(Some(conn)) => Some(super::commands::Target::Guest(conn)),
    // rust: Some(None) if self.lan_acting.is_none() => Some(super::commands::Target::Player),
    // rust: _ => None,
}
    // rust: if let Some(who) = who {
    // rust: self.for_player(who, |g| {
                    // CatalystListener: trigger(player, killedEntity, damageSource).
    // rust: let view = g.mob_entity(m);
    // rust: let blow = g.last_blow(m);
    // rust: g.trigger_killed_as(
    // rust: "minecraft:kill_mob_near_sculk_catalyst",
    // rust: &view,
    // rust: blow.as_ref(),
    // rust: );
    // rust: });
}
}
    // rust: if by_player {
            // A guest's kill is theirs: their statistics, scores and
            // advancements (LivingEntity.die credits lastHurtByPlayer).
    // rust: let guest = killer.flatten().filter(|_| self.lan_acting.is_none());
    // rust: let credited = guest.is_some_and(|conn| {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return false;
}
    // rust: let done = self
    // rust: .as_guest(&mut host, conn, |g| g.credit_kill(m))
    // rust: .is_some();
    // rust: self.lan = Some(host);
    // rust: done
    // rust: });
    // rust: if !credited {
    // rust: self.credit_kill(m);
}
}
    // rust: self.score_entity_removed(m.id);
        // Raider.die's hero and Villager.tellWitnessesThatIWasMurdered go to
        // the causing entity, not the credited player: a tame wolf's kill is
        // neither its owner's heroism nor a murder by them.
    // rust: let slain_by_player = by_player && !killed_by_mob(m);
    // rust: self.raider_died(m, slain_by_player, killer.flatten());
    // rust: self.villager_murdered(m, slain_by_player, killer.flatten());
    // rust: let pos = [m.position.x, m.position.y + 0.5, m.position.z];
    // rust: let killer_entity = self.killer_loot_entity(killer.flatten());
        // LAST_DAMAGE_PLAYER only while the player-hurt memory lasts
        // (LivingEntity.dropFromLootTable's playerKilled): a mob that dies to
        // the environment long after a player's hit names no player.
    // rust: let player = killer
    // rust: .filter(|_| m.ai.last_hurt_by_player > 0)
    // rust: .and_then(|conn| self.killer_uuid(conn));
    // rust: if let Some(player) = player.filter(|_| m.extra.leash.is_some()) {
    // rust: self.lead_killers.insert(m.id, (player, self.dim));
}
    // rust: self.drop_death_loot(&mut dying, player, by_player, killer_entity, consumed, pos);
    // rust: self.create_wither_rose(m);
    // rust: if m.species() == Species::CopperGolem {
            // CopperGolem.dropEquipment: the preserved equipment too.
    // rust: self.golem_drop_equipment(&mut dying);
}
    // rust: if m.species() == Species::SulfurCube {
    // rust: self.split_sulfur_cube(m);
}
    // rust: if m.species() == Species::Slime || m.species() == Species::MagmaCube {
            // Slime.remove: split into 2-4 smaller slimes.
    // rust: let size = m.extra.size;
    // rust: if size > 1 {
    // rust: let mut n = 2 + self.world.random.next_int_bound(3).unwrap_or(0);
    // rust: let mut cancel = false;
    // rust: let mut count = n as u32;
    // rust: let kind = super::native_hooks::mob_kind(m);
    // rust: self.native_mob_split(m.id, &kind, size, size / 2, &mut count, &mut cancel);
    // rust: n = if cancel { 0 } else { count.min(64) as _ };
    // rust: for k in 0..n {
    // rust: let off = |kk: i32| (f64::from(kk % 2) - 0.5) * f64::from(size) / 4.0;
    // rust: let at = [
    // rust: m.position.x + off(k),
    // rust: m.position.y + 0.5,
    // rust: m.position.z + off(k / 2),
    // rust: ];
    // rust: if let Some(id) = self.spawn_mob(&m.kind.id, at, m.persistent)
    // rust: && let Some(c) = self.mobs.iter_mut().find(|c| c.id == id)
    // rust: {
    // rust: horizon_client::mobs::cube::set_size(c, size / 2);
}
}
}
}
}
    // The killer's side of a mob's death: `ServerPlayer.awardKillScore`'s
    // statistics and scores, and the `player_killed_entity` trigger.
credit_kill :: proc(self: ^Self, m: ^Mob) {
}
        // Player.killedEntity: the killed statistic goes to the causing
        // entity, so a kill by a mob (a tame wolf credited to its owner)
        // leaves it out; ServerPlayer.awardKillScore counts the rest.
    // rust: if !killed_by_mob(m) {
    // rust: self.award_stat("killed", &m.kind.id, 1);
}
    // rust: self.award_custom_stat("mob_kills", 1);
    // rust: self.score_player_killed(super::commands::Target::Mob(m.id));
    // rust: let view = self.mob_entity(m);
    // rust: let blow = self.last_blow(m);
    // rust: self.trigger_killed(&view, blow.as_ref());
}
    // The damage source a mob died to (`die`'s), its direct entity included when the mob
    // recorded one ([`Mob::last_direct`]).
last_blow :: proc(self: ^Self, m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (d, _) = m.last_damage?;
    // rust: let mut view = self.damage_view(d);
    // rust: if let Some(kind) = m.last_direct {
    // rust: view.direct = Some(horizon_client::advancements::EntityView {
    // rust: kind: kind.into(),
    // rust: position: d.from.unwrap_or_default(),
    // rust: ..Default::default()
    // rust: });
    // rust: view.is_direct = false;
}
    // rust: Some(view)
}
    // A mob's damage source as advancement predicates see it: its type, the
    // causing entity, and the projectile when one dealt it.
    // rust: pub(super) fn damage_view(&self, d: Damage) -> horizon_client::advancements::DamageView {
    // rust: let source = match d.attacker {
            // Its callers are KilledTrigger's: the source as their killing_blow sees it.
    // rust: Some(Who::Player) => Some(self.player_entity_for_any(&[
    // rust: "minecraft:player_killed_entity",
    // rust: "minecraft:kill_mob_near_sculk_catalyst",
    // rust: ])),
    // rust: Some(Who::Mob(id)) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .map(|o| self.mob_entity(o)),
    // rust: None => None,
}
    // rust: let projectile = match d.kind {
    // rust: DamageKind::Arrow => Some("minecraft:arrow"),
    // rust: DamageKind::Fireball => Some("minecraft:fireball"),
    // rust: DamageKind::WitherSkull => Some("minecraft:wither_skull"),
    // rust: DamageKind::Fireworks => Some("minecraft:firework_rocket"),
    // rust: _ => None,
}
    // rust: let direct = match projectile {
    // rust: Some(kind) => Some(horizon_client::advancements::EntityView {
    // rust: kind: kind.into(),
    // rust: position: d.from.unwrap_or_default(),
    // rust: ..Default::default()
    // rust: }),
    // rust: None => source.clone(),
}
    // rust: horizon_client::advancements::DamageView {
    // rust: kind: source_damage_type(d).to_owned(),
            // DamageSource.isDirect: the causing entity is the direct one.
    // rust: is_direct: projectile.is_none(),
    // rust: direct,
    // rust: source,
    // rust: ..Default::default()
}
}
    // `dropAllDeathLoot` through `mobs::drops`: the entity loot table from the
    // world's random sequence, equipment by drop chance, species extras and
    // the experience orbs, spawned in order.
    // The killing player as a loot entity: their worn and held items, read
    // from the guest who struck the last blow when a server's player did
    // (on the server thread that is every player, the window's too), so
    // Looting on their weapon counts.
killer_loot_entity :: proc(self: ^Self, guest: Maybe(u32)) -> h {
    // Ported from Horizon
    return {}
}
    // rust: let own = |g: &Self| {
    // rust: let mut e = horizon_world::loot::LootEntity::new("minecraft:player");
    // rust: let slots = [
    // rust: ("mainhand", g.stack_in(g.selected)),
    // rust: ("offhand", g.stack_in(super::shield::OFFHAND_SLOT)),
    // rust: ("head", g.armor[0].as_ref()),
    // rust: ("chest", g.armor[1].as_ref()),
    // rust: ("legs", g.armor[2].as_ref()),
    // rust: ("feet", g.armor[3].as_ref()),
    // rust: ];
    // rust: for (slot, stack) in slots {
    // rust: if let Some(stack) = stack {
    // rust: e.equipment.push((slot.into(), to_loot(stack)));
}
}
    // rust: e
}
    // rust: if let Some(conn) = guest.filter(|_| self.lan_acting.is_none())
    // rust: && let Some(mut host) = self.lan.take()
    // rust: {
    // rust: let entity = self.as_guest(&mut host, conn, |g| own(g));
    // rust: self.lan = Some(host);
    // rust: if let Some(entity) = entity {
    // rust: return entity;
}
}
    // rust: own(self)
}
    // The UUID of the player `last_hurt_by_player` keeps: the guest on
    // connection `conn` (None once they left), else the player in place
    // (None on a server, which has none of its own).
killer_uuid :: proc(self: ^Self, conn: Maybe(u32)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match conn {
            // During that guest's own turn, the hub is out of `lan`.
    // rust: Some(conn) if self.lan_acting != Some(conn) => {
    // rust: Some(self.lan.as_ref()?.hub.guest(conn)?.uuid)
}
    // rust: Some(_) => Some(self.native_acting_id()),
    // rust: None if self.lan_acting.is_none() && self.player.is_some() => {
    // rust: Some(self.native_acting_id())
}
    // rust: None => None,
}
}
    // rust: fn drop_death_loot(
    // rust: &mut self,
    // rust: m: &mut Mob,
    // rust: player_uuid: Option<u128>,
    // rust: by_player: bool,
    // rust: killer: horizon_world::loot::LootEntity,
    // rust: consumed: bool,
    // rust: pos: [f64; 3],
    // rust: ) {
//         use horizon_client::mobs::{DamageKind, Who, drops};
//         use horizon_world::loot::{LootDamage, LootEntity};
    // rust: let Some(loot) = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: ) else {
    // rust: return;
}
    // rust: let player = || killer.clone();
    // rust: let damage = m.last_damage.map(|(d, _)| {
    // rust: let source = match d.attacker {
    // rust: Some(Who::Player) => Some(player()),
    // rust: Some(Who::Mob(id)) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|o| o.id == id)
    // rust: .map(|o| drops::loot_entity(o, None))
                    // A charged creeper's blast kills after the creeper left the list.
    // rust: .or_else(|| {
    // rust: self.combat
    // rust: .charged_exploders
    // rust: .contains(&id)
    // rust: .then(|| LootEntity {
    // rust: powered: true,
    // rust: ..LootEntity::new("minecraft:creeper")
    // rust: })
    // rust: }),
    // rust: None => None,
}
    // rust: let direct = match d.kind {
    // rust: DamageKind::Arrow => Some(LootEntity {
    // rust: kind: "minecraft:arrow".into(),
    // rust: ..LootEntity::default()
    // rust: }),
    // rust: DamageKind::Fireball => Some(LootEntity {
    // rust: kind: "minecraft:fireball".into(),
    // rust: ..LootEntity::default()
    // rust: }),
    // rust: DamageKind::WitherSkull => Some(LootEntity {
    // rust: kind: "minecraft:wither_skull".into(),
    // rust: ..LootEntity::default()
    // rust: }),
    // rust: DamageKind::Fireworks => Some(LootEntity {
    // rust: kind: "minecraft:firework_rocket".into(),
    // rust: ..LootEntity::default()
    // rust: }),
    // rust: _ => source.clone(),
}
    // rust: LootDamage {
    // rust: kind: source_damage_type(d).into(),
    // rust: source,
    // rust: direct,
}
    // rust: });
    // rust: let vehicle = m
    // rust: .extra
    // rust: .mount
    // rust: .and_then(|id| self.mobs.iter().find(|o| o.id == id))
    // rust: .map(|o| LootEntity::new(&o.kind.id));
    // rust: let death = drops::Death {
    // rust: loot: &loot,
    // rust: damage,
    // rust: player: by_player.then(player),
    // rust: luck: 0.0,
    // rust: vehicle,
    // rust: mob_drops: self.ui.rules.bool("mob_drops"),
    // rust: world_seed: self.level.seed,
}
        // LootContextParams.ORIGIN of a death: the mob's position.
    // rust: let place = self.loot_place_at([m.position.x, m.position.y, m.position.z], None);
    // rust: let (items, skulls) = horizon_world::loot::with_native_loot_place(place, || {
    // rust: drops::die(m, &death, &mut self.rand_sequences, &mut self.world.random)
    // rust: });
    // rust: if skulls && let Some(Who::Mob(id)) = m.last_damage.and_then(|(d, _)| d.attacker) {
            // Creeper.droppedSkulls: one head per charged explosion.
    // rust: self.combat.charged_exploders.retain(|c| *c != id);
    // rust: if let Some(creeper) = self.mobs.iter_mut().find(|o| o.id == id) {
    // rust: creeper.extra.charged = false;
}
}
    // rust: let raider = horizon_client::mobs::raider::is_raider(m.species());
        // The item drops come before the carried block and the orbs, so the
        // mods get them all at once and they still spawn in that order.
    // rust: let mut stacks = Vec::new();
    // rust: let mut rest = Vec::new();
    // rust: for d in items {
    // rust: match d {
    // rust: drops::Drop::Item(stack) => stacks.push(
    // rust: if raider && stack.item == horizon_client::mobs::raider::BANNER {
    // rust: horizon_client::mobs::raider::ominous_banner()
    // rust: } else {
    // rust: from_loot(&stack)
    // rust: },
    // rust: ),
    // rust: drops::Drop::Stack(stack) => stacks.push(stack),
    // rust: other => rest.push(other),
}
}
    // rust: let kind = super::native_hooks::mob_kind(m);
    // rust: let table = drops::death_loot_table(m, death.mob_drops).filter(|t| loot.has_table(t));
    // rust: let context = NativeLootDrops {
    // rust: table: table.as_deref().unwrap_or_default(),
    // rust: dimension: self.dim.id(),
    // rust: origin: [m.position.x, m.position.y, m.position.z],
    // rust: block: None,
    // rust: entity: Some((m.id, &kind)),
    // rust: player: player_uuid,
    // rust: tool: None,
    // rust: explosion: None,
    // rust: used: false,
}
    // rust: self.native_loot_drops(&context, &mut stacks);
    // rust: stacks.retain(|stack| stack.count > 0 && &*stack.item != "minecraft:air");
    // rust: for item in stacks {
            // Every death drop is its own ItemEntity, and the drop entity's
            // own random (not the level's) gives it the constructor's
            // horizontal push (its motion otherwise stays [0, 0.2, 0] and
            // the drops land stacked at the mob's centre, without disturbing
            // the level random that the orbs' merge ids and block ticks read
            // next).
    // rust: self.spawn_item(item, pos, dispenser::new_item_motion(), 10);
}
    // rust: for d in rest {
    // rust: match d {
    // rust: drops::Drop::CarriedBlock(state) => {
                    // Enderman.dropCustomDeathLoot: spawnAtLocation for each
                    // of the carried block's silk-touch drops.
    // rust: let stacks = horizon_client::mobs::enderman::carried_block_drops(
    // rust: world_items!(self),
    // rust: self.pack.assets.registry,
    // rust: state,
    // rust: &mut self.world.random,
    // rust: Some((&mut self.rand_sequences, self.level.seed)),
    // rust: );
    // rust: for item in stacks {
    // rust: self.spawn_item(item, pos, dispenser::new_item_motion(), 10);
}
}
    // rust: drops::Drop::Orb(value) if !consumed => self.spawn_orbs(pos, value as u32),
    // rust: drops::Drop::Item(_) | drops::Drop::Stack(_) | drops::Drop::Orb(_) => {}
}
}
}
    // Melee or ranged damage to another mob; whether the hit landed.
mob_hits_mob :: proc(self: ^Self, target: u32, amount: f32, mut source: Damage) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if source.attacker_species.is_none()
    // rust: && let Some(Who::Mob(id)) = source.attacker
    // rust: {
    // rust: source.attacker_species = self.mobs.iter().find(|m| m.id == id).map(|m| m.species());
}
    // rust: let mut killed = false;
    // rust: let mut hurt = false;
    // rust: let mut infested = false;
    // rust: let aim = self.attacker_aim(source.attacker);
        // So `living_knockback_v2` sees who hit and what they hold.
    // rust: let _attacker = self.knockback_scope_for(source.attacker);
    // rust: if let Some(t) = self.mobs.iter_mut().find(|m| m.id == target) {
    // rust: let hit = t.damage_aimed(amount, source, aim);
    // rust: hurt = hit;
    // rust: if hit {
    // rust: killed = !t.alive();
                // The hurt or death sound the mob raised.
    // rust: let center = t.center();
    // rust: for event in std::mem::take(&mut t.outbox) {
    // rust: match event {
    // rust: MobEvent::Sound(s, _, volume, pitch) => {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{s}"), Some(center), volume, pitch);
}
    // rust: MobEvent::Infested { .. } => infested = true,
    // rust: other => {
                            // Left for the end of the tick.
    // rust: t.outbox.push(other);
}
}
}
}
}
    // rust: if hurt {
    // rust: self.resolve_player_responsible(target, source);
}
    // rust: if infested {
    // rust: self.mob_infested(target);
}
    // rust: if hurt
    // rust: && let Some(Who::Mob(attacker)) = source.attacker
    // rust: && let Some(m) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == attacker && m.species() == Species::Axolotl)
    // rust: {
    // rust: self.audio.play(
    // rust: "minecraft:entity.axolotl.attack",
    // rust: Some([m.position.x, m.position.y, m.position.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: if killed && let Some(Who::Mob(killer)) = source.attacker {
    // rust: self.zombie_killed(killer, target);
}
    // rust: hurt
}
    // `LivingEntity.resolvePlayerResponsibleForDamage` after `source` hurt a
    // mob: a tame wolf's hit is its owner's (`setLastHurtByPlayer(uuid, 100)`),
    // so the kill drops experience and player-only loot and the owner, when
    // in the world, gets the credit (`getKillCredit`); a tame wolf without an
    // owner clears it. A player's own hits are recorded where they land.
    // rust: pub(super) fn resolve_player_responsible(&mut self, victim: u32, source: Damage) {
    // rust: let Some(Who::Mob(attacker)) = source.attacker else {
    // rust: return;
}
    // rust: let Some(owner) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == attacker && m.species() == Species::Wolf && m.extra.tame)
    // rust: .map(|m| m.extra.owner)
    // rust: else {
    // rust: return;
}
    // rust: let player = owner.and_then(|uuid| self.player_with_uuid(uuid));
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == victim) else {
    // rust: return;
}
    // rust: m.ai.last_hurt_by_player = if owner.is_some() { 100 } else { 0 };
    // rust: match player {
    // rust: Some(who) => self.last_hurt_by_player.insert(victim, who),
    // rust: None => self.last_hurt_by_player.remove(&victim),
}
}
    // The player in the world with `uuid` (`EntityReference.getPlayer`), as
    // `last_hurt_by_player` keeps them: None for the player in place, else the
    // guest's connection.
player_with_uuid :: proc(self: ^Self, uuid: [i32; 4]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.player.is_some()
    // rust: && horizon_client::mobs::tame::owned_by(Some(uuid), self.acting_uuid())
    // rust: {
    // rust: return Some(self.lan_acting);
}
    // rust: let uuid = horizon_client::lan::playerdata::ints_uuid(uuid);
    // rust: self.lan
    // rust: .iter()
    // rust: .flat_map(|h| h.hub.guests.iter())
    // rust: .find(|g| g.placed && g.uuid == uuid)
    // rust: .map(|g| Some(g.conn))
}
    // `InfestedMobEffect.onMobHurt` for a mob: silverfish from half its height up.
    // rust: pub(super) fn mob_infested(&mut self, mob: u32) {
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == mob) {
    // rust: let at = [
    // rust: m.position.x,
    // rust: m.position.y + f64::from(m.height()) / 2.0,
    // rust: m.position.z,
    // rust: ];
    // rust: let look = m.view_vector();
    // rust: self.infested_hurt(at, look, Some(mob));
}
}
    // `LivingEntity.dropFromGiftLootTable`: the gift table from its random
    // sequence with the mob as `this` (a chicken's egg depends on its
    // variant); the loot data of the game's resources decides, and without it
    // the items' table engine (no entity) rolls it. Whether anything dropped.
drop_gift_loot :: proc(self: ^Self, mob: u32, table: ^'static str, at: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
//         use horizon_client::mobs::drops;
//         use horizon_world::loot::EntityLootParams;
    // rust: let loot = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: );
    // rust: let this = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map(|m| drops::loot_entity(m, None));
    // rust: let stacks = match (loot, this) {
    // rust: (Some(loot), Some(this)) if loot.has_table(table) => {
    // rust: let params = EntityLootParams {
    // rust: this,
    // rust: ..EntityLootParams::default()
}
    // rust: let seed = self.level.seed;
    // rust: match loot.random_sequence(table) {
    // rust: Some(id) => {
    // rust: let random = self.rand_sequences.get(id, seed);
    // rust: loot.roll_entity(table, random, &params)
    // rust: .iter()
    // rust: .filter(|s| !s.is_empty())
    // rust: .map(from_loot)
    // rust: .collect()
}
    // rust: None => Vec::new(),
}
}
    // rust: _ => self
    // rust: .res
    // rust: .items()
    // rust: .loot_table(table, false, None, &mut self.world.random),
}
    // rust: let dropped = !stacks.is_empty();
    // rust: for d in stacks {
            // The ItemEntity constructor's motion, from the entity's own
            // random (not the level's).
    // rust: self.spawn_item(d, at, dispenser::new_item_motion(), 10);
}
    // rust: dropped
}
    // Adds a projectile, giving it an id from the entity counter
    // (`Entity.id`, the same counter as the rest) when it has none.
    // rust: pub(super) fn add_projectile(&mut self, mut p: horizon_client::projectiles::Projectile) {
    // rust: if p.id == 0 {
    // rust: self.next_entity += 1;
    // rust: p.id = self.next_entity;
}
        // Projectile.setOwner: the acting player's or the mob's UUID, which
        // its save keeps even once the owner is gone.
    // rust: if p.owner_uuid.is_none() {
    // rust: p.owner_uuid = match p.owner {
    // rust: Some(Who::Player) => Some(self.acting_player_uuid()),
    // rust: Some(Who::Mob(id)) => Some(self.uuid_for(id)),
    // rust: None => None,
}
}
    // rust: let player = (p.owner == Some(Who::Player))
    // rust: .then(|| horizon_client::lan::playerdata::ints_uuid(self.acting_player_uuid()));
    // rust: let name = if player.is_some() {
    // rust: self.acting_player_name().to_owned()
    // rust: } else {
    // rust: String::new()
}
    // rust: let (id, kind) = (p.id, p.kind.id());
    // rust: if let Some(a) = p.arrow.as_mut()
    // rust: && !p.stuck
    // rust: {
    // rust: a.spawn_pos = Some(p.position);
    // rust: a.spawn_velocity = Some(p.velocity);
    // rust: a.spawn_rot = Some((p.pitch, p.yaw));
}
    // rust: self.creatures.projectiles.push(p);
    // rust: self.native_projectile_launch(player, &name, id, kind);
}
    // `MushroomCow.shear`'s `sendParticles(EXPLOSION, x, getY(0.5), z, 1, 0, 0, 0, 0)`:
    // one puff over a sheared mooshroom, half its `height` up, shown here and to
    // the players within range.
    // rust: pub(super) fn mooshroom_shear_puff(&mut self, at: [f64; 3], height: f64) {
    // rust: let at = [at[0], at[1] + 0.5 * height, at[2]];
    // rust: let options = ParticleOptions::simple(ParticleType::Explosion);
    // rust: self.particles
    // rust: .send_particles(&options, at, [0.0; 3], 0.0, 1);
    // rust: self.lan_level_particles(None, &options, at, [0.0; 3], 0.0, 1, None);
}
    // `Entity.sendBubbleColumnParticles` at the top of the column block `pos`: two
    // splashes and two bubbles over it, which the level random places, shown here
    // and to the players within range.
    // rust: pub(super) fn bubble_column_particles(&mut self, pos: BlockPos) {
    // rust: for _ in 0..2 {
    // rust: let r = &mut self.world.random;
    // rust: let splash = [
    // rust: f64::from(pos.x) + r.next_double(),
    // rust: f64::from(pos.y + 1),
    // rust: f64::from(pos.z) + r.next_double(),
    // rust: ];
    // rust: let bubble = [
    // rust: f64::from(pos.x) + r.next_double(),
    // rust: f64::from(pos.y + 1),
    // rust: f64::from(pos.z) + r.next_double(),
    // rust: ];
    // rust: let splash_options = ParticleOptions::simple(ParticleType::Splash);
    // rust: self.particles
    // rust: .send_particles(&splash_options, splash, [0.0; 3], 1.0, 1);
    // rust: self.lan_level_particles(None, &splash_options, splash, [0.0; 3], 1.0, 1, None);
    // rust: let bubble_options = ParticleOptions::simple(ParticleType::Bubble);
    // rust: self.particles
    // rust: .send_particles(&bubble_options, bubble, [0.0, 0.01, 0.0], 0.2, 1);
    // rust: self.lan_level_particles(
    // rust: None,
    // rust: &bubble_options,
    // rust: bubble,
    // rust: [0.0, 0.01, 0.0],
    // rust: 0.2,
    // rust: 1,
    // rust: None,
    // rust: );
}
}
    // A mob's projectile enters the level.
launch_mob_projectile :: proc(self: ^Self, mut p: Projectile) {
}
    // rust: self.next_entity += 1;
    // rust: p.id = self.next_entity;
    // rust: let (owner, at) = (p.owner, [p.position.x, p.position.y, p.position.z]);
        // LlamaSpit.recreateFromPacket: the spit's burst on the client.
    // rust: if p.kind == ProjectileKind::LlamaSpit {
    // rust: let v = p.velocity;
    // rust: self.particles.llama_spit_burst(at, [v.x, v.y, v.z]);
}
    // rust: let arrow = p.arrow.is_some();
    // rust: self.add_projectile(p);
    // rust: if arrow {
    // rust: self.projectile_event("minecraft:projectile_shoot", owner, at);
}
}
    // rust: pub(super) fn handle_mob_events(&mut self, events: Vec<MobEvent>) -> Result<()> {
    // rust: for e in events {
    // rust: match e {
    // rust: MobEvent::BubbleColumnParticles { pos } => {
    // rust: self.bubble_column_particles(BlockPos::new(pos[0], pos[1], pos[2]))
}
    // rust: MobEvent::LandingDust {
    // rust: state,
    // rust: at,
    // rust: count,
    // rust: speed,
    // rust: } => self.landing_dust(None, state, Vec3::new(at[0], at[1], at[2]), count, speed),
    // rust: MobEvent::SquidCycle { mob, at } => self.lan_entity_event(mob as i32, 19, at),
    // rust: MobEvent::RabbitHop { mob, at } => self.lan_entity_event(mob as i32, 1, at),
    // rust: MobEvent::Drown { mob, at } => {
    // rust: self.lan_entity_event(mob as i32, super::combat::DROWN_EVENT, at);
    // rust: let v = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map_or([0.0; 3], |m| [m.velocity.x, m.velocity.y, m.velocity.z]);
    // rust: self.drown_particles(at, v);
}
    // rust: MobEvent::PowderSnowParticle { at, velocity } => {
    // rust: self.snowflake_particle(at, velocity);
}
    // rust: MobEvent::SunProtectionWear { mob } => self.wear_sun_protection(mob),
    // rust: MobEvent::ArmorHurt { mob, amount, kind } => self.hurt_mob_armor(mob, amount, kind),
    // rust: MobEvent::EntityEvent { mob, event, at } => {
    // rust: self.lan_entity_event(mob as i32, event, at)
}
    // rust: MobEvent::LevelParticles {
    // rust: kind,
    // rust: at,
    // rust: spread,
    // rust: speed,
    // rust: count,
    // rust: } => {
    // rust: if let Some(ty) = horizon_client::particles::ParticleType::from_name(kind) {
    // rust: let options = horizon_client::particles::ParticleOptions::simple(ty);
    // rust: self.particles
    // rust: .send_particles(&options, at, spread, speed, count);
    // rust: self.lan_level_particles(None, &options, at, spread, speed, count, None);
}
}
                // The LAN packet has no item for a particle yet: the host's window only.
    // rust: MobEvent::ItemParticles {
    // rust: item,
    // rust: at,
    // rust: spread,
    // rust: speed,
    // rust: count,
    // rust: } => {
    // rust: let options =
    // rust: self.item_particle(&horizon_client::items::ItemStack::new(item, 1));
    // rust: self.particles
    // rust: .send_particles(&options, at, spread, speed, count);
}
    // rust: MobEvent::EntitySound {
    // rust: mob,
    // rust: name,
    // rust: at,
    // rust: volume,
    // rust: pitch,
    // rust: source,
    // rust: } => {
    // rust: let silent = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .is_some_and(|m| m.silent);
    // rust: let entity = horizon_client::sound_engine::SoundEntity::new(mob, at, silent);
    // rust: self.audio.play_bound(
    // rust: &format!("minecraft:{name}"),
    // rust: source,
    // rust: volume,
    // rust: pitch,
    // rust: entity,
    // rust: None,
    // rust: );
}
    // rust: MobEvent::Sound(name, at, volume, pitch)
    // rust: | MobEvent::LocalSound(name, at, volume, pitch) => {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{name}"), Some(at), volume, pitch)
}
    // rust: MobEvent::LevelEventSound {
    // rust: sound,
    // rust: at,
    // rust: volume,
    // rust: spread,
    // rust: } => {
                    // WitherBoss.customServerAiStep: the spawn roar is global
                    // level event 1023 at the block position.
    // rust: if sound == "entity.wither.spawn" {
    // rust: let pos = at.map(|v| v.floor() as i32);
    // rust: self.global_level_event(1023, pos, 0);
    // rust: } else {
                        // The client's own level random: nothing drawn from the server's.
    // rust: let mut r = horizon_core::random::LegacyRandom::new(
    // rust: self.world.game_time.wrapping_mul(341_873_128_712),
    // rust: );
    // rust: let pitch = (r.next_float() - r.next_float()) * spread + 1.0;
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), volume, pitch)
}
}
    // rust: MobEvent::SoundId(name, at, volume, pitch) => {
    // rust: self.audio.play(&name, Some(at), volume, pitch)
}
    // rust: MobEvent::GameEvent {
    // rust: event, at, source, ..
    // rust: } if event == "minecraft:flap"
    // rust: && self.mobs.iter().any(|m| {
    // rust: m.id == source && matches!(m.species(), Species::Chicken | Species::Parrot)
    // rust: }) =>
    // rust: {
    // rust: let ctx = self.who_context(Some(Who::Mob(source)), None);
    // rust: self.post_game_event(event, at, ctx);
}
                // A mob's own `gameEvent(..)` calls: Armadillo.rollUp/rollOut's
                // ENTITY_ACTION, Creeper.tick's PRIME_FUSE, Mob.ate's EAT, the
                // shulker's lid (Shulker.setRawPeekAmount), an evoker's vexes
                // (ENTITY_PLACE).
    // rust: MobEvent::GameEvent {
    // rust: event, at, source, ..
    // rust: } if matches!(
    // rust: event,
    // rust: "minecraft:entity_action"
    // rust: | "minecraft:prime_fuse"
    // rust: | "minecraft:eat"
    // rust: | "minecraft:container_open"
    // rust: | "minecraft:container_close"
    // rust: | "minecraft:entity_place"
    // rust: ) =>
    // rust: {
    // rust: let ctx = self.who_context(Some(Who::Mob(source)), None);
    // rust: self.post_game_event(event, at, ctx);
}
                // The sculk layer tracks steps and bee/bat flaps itself
                // (`entity_motion_events`, `tick_mob_sculk_events`). Birds
                // above use their movement's flyDist/nextFlap threshold.
    // rust: MobEvent::GameEvent { .. } => {}
    // rust: MobEvent::AttackPlayer(amount, from) => {
    // rust: self.mob_hits_player(amount, from, "minecraft:mob_attack");
}
                // doHurtTarget: the effect only when hurtServer took damage.
                // Bee.doHurtTarget: a sting that hurt leaves the stinger in the
                // body, then the poison.
    // rust: MobEvent::StingPlayer {
    // rust: amount,
    // rust: from,
    // rust: poison_ticks,
    // rust: } => {
    // rust: if self.mob_hits_player(amount, from, "minecraft:mob_attack") {
    // rust: self.combat.stuck.add_stinger();
    // rust: if poison_ticks > 0 {
    // rust: self.give_player_effect("minecraft:poison", poison_ticks, 0);
}
}
}
    // rust: MobEvent::AttackPlayerWithEffect {
    // rust: amount,
    // rust: from,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: } => {
    // rust: if self.mob_hits_player(amount, from, "minecraft:mob_attack") {
    // rust: self.give_player_effect(effect, ticks, amplifier);
}
}
    // rust: MobEvent::DamagePlayer { amount, from, kind } => {
    // rust: self.mob_hits_player(amount, from, kind);
}
    // rust: MobEvent::ElderCurse { at, silent } => self.elder_curse(at, silent),
    // rust: MobEvent::SetVelocity { target, velocity } => {
    // rust: let v = Vec3::new(velocity[0], velocity[1], velocity[2]);
    // rust: match target {
    // rust: Who::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = v;
}
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.velocity = v;
}
}
}
}
    // rust: MobEvent::RemoveKilled { target } => {
                    // The bite that killed it ran `LivingEntity.die` (loot, such
                    // as a magma cube's froglight, and experience) before
                    // `eatEntity` removes it: a removed mob never reaches the
                    // next tick's deaths, so it dies here first.
    // rust: if let Some(m) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == target && !m.alive() && !m.removed)
    // rust: .cloned()
    // rust: {
    // rust: if self.died.insert(target) {
    // rust: self.mob_died(&m);
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == target) {
    // rust: m.removed = true;
}
}
}
    // rust: MobEvent::Push { target, velocity } => {
    // rust: let v = Vec3::new(velocity[0], velocity[1], velocity[2]);
    // rust: match target {
    // rust: Who::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = p.velocity.add_vector(v);
}
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.velocity = m.velocity.add_vector(v);
}
}
}
}
    // rust: MobEvent::Knockback {
    // rust: target,
    // rust: power,
    // rust: x,
    // rust: z,
    // rust: source,
    // rust: } => match target {
                    // A player's source names no melee attacker, as its damage's doesn't.
    // rust: Who::Player => {
    // rust: let _attacker = self.knockback_scope(match source.attacker {
    // rust: Some(Who::Mob(id)) => id as i32,
    // rust: _ => 0,
    // rust: });
    // rust: let source = HurtSource {
    // rust: damage_type: source_damage_type(source),
    // rust: causing: 0,
    // rust: direct: 0,
}
    // rust: self.knock_back_player(power, x, z, source);
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.knockback(power, x, z, &source);
}
}
    // rust: },
    // rust: MobEvent::Shift { target, delta } => {
    // rust: let d = Vec3::new(delta[0], delta[1], delta[2]);
    // rust: match target {
    // rust: Who::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = p.position.add_vector(d);
}
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.position = m.position.add_vector(d);
}
}
}
}
    // rust: MobEvent::Wololo { mob } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
                        // DyeColor.RED.
    // rust: m.extra.color = 14;
}
}
    // rust: MobEvent::Fangs {
    // rust: at,
    // rust: yaw,
    // rust: delay,
    // rust: owner,
    // rust: } => self.add_fangs(at, yaw, delay, owner),
    // rust: MobEvent::Shoot(..) => {}
    // rust: MobEvent::ExplosionSource {
    // rust: mob,
    // rust: charged,
    // rust: name,
    // rust: in_water,
    // rust: } => {
    // rust: self.combat.explosion_source = Some(mob);
    // rust: self.combat.explosion_in_water = in_water;
                    // The creeper causes the blast's damage, but it is out of
                    // the mob list already: its name comes with the event.
    // rust: self.combat.exploded.push((mob, name));
    // rust: if charged {
    // rust: self.combat.charged_exploders.push(mob);
}
}
    // rust: MobEvent::LingeringCloud {
    // rust: at,
    // rust: effects,
    // rust: hidden,
    // rust: ambient,
    // rust: color,
    // rust: } => {
    // rust: self.spawn_creeper_cloud(at, effects, hidden, ambient, color);
}
    // rust: MobEvent::Explode(at, radius, species) => {
                    // The exploding mob causes the damage (Creeper.explodeCreeper).
    // rust: let noted = self.combat.explosion_source.is_some();
    // rust: let source_mob = self.combat.explosion_source.or_else(|| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: (m.position.x - at[0]).powi(2) + (m.position.z - at[2]).powi(2)
    // rust: < 1.0
    // rust: })
    // rust: .map(|m| m.id)
    // rust: .next()
    // rust: });
    // rust: self.combat.explosion_source = source_mob;
    // rust: self.combat.explosion_source_named = noted;
    // rust: self.combat.explosion_cause = match species {
    // rust: Species::Creeper => Some("minecraft:creeper"),
    // rust: Species::Wither => Some("minecraft:wither"),
    // rust: Species::SulfurCube => Some("minecraft:sulfur_cube"),
    // rust: _ => None,
}
    // rust: .map(|kind| horizon_client::advancements::EntityView {
    // rust: kind: kind.into(),
    // rust: position: at,
    // rust: ..Default::default()
    // rust: });
                    // Only a creeper or a wither empties the hives it blows up.
                    // The creeper is already gone from the list, so the event
                    // carries its kind. A sulfur cube's blast is TNT's.
    // rust: let result = match species {
    // rust: Species::Creeper | Species::Wither => {
    // rust: self.with_hive_emptying_blast(|g| g.explode(at, radius))
}
    // rust: Species::SulfurCube => self.explode_sulfur_cube(at, radius),
    // rust: _ => self.explode(at, radius),
}
    // rust: self.combat.explosion_source = None;
    // rust: self.combat.explosion_source_named = false;
    // rust: self.combat.explosion_in_water = false;
    // rust: self.combat.explosion_cause = None;
    // rust: result?
}
    // rust: MobEvent::AttackMob {
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: } => {
    // rust: self.mob_hits_mob(target, amount, source);
}
    // rust: MobEvent::AttackMobWithEffect {
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: } => {
                    // CaveSpider, Husk and WitherSkeleton.doHurtTarget: the
                    // effect sits inside the branch where the hit landed, and
                    // `LivingEntity.addEffect` takes a mob as well as a player.
    // rust: if self.mob_hits_mob(target, amount, source)
    // rust: && let Some(t) = self.mobs.iter_mut().find(|m| m.id == target)
    // rust: {
    // rust: t.add_effect(effect, ticks, amplifier);
}
}
    // rust: MobEvent::CubeHurtPlayer { cube, amount, from } => {
                    // AbstractCubeMob.dealDamage: the attack sound (and its
                    // two pitch draws, made even for a silent cube, whose
                    // Entity.playSound is then skipped) only follows a hit
                    // that landed.
    // rust: if self.hurt_player_from(
    // rust: amount,
    // rust: Some(from),
    // rust: "minecraft:mob_attack",
    // rust: Some(Some(cube)),
    // rust: ) && let Some(m) = self.mobs.iter_mut().find(|m| m.id == cube)
    // rust: {
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: let at = m.center();
    // rust: if !m.silent {
    // rust: self.handle_mob_events(vec![MobEvent::Sound(
    // rust: "entity.slime.attack",
    // rust: at,
    // rust: 1.0,
    // rust: pitch,
    // rust: )])?;
}
}
}
    // rust: MobEvent::CubeHurtMob {
    // rust: cube,
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: } => {
                    // AbstractCubeMob.dealDamage: the attack sound (and its
                    // two pitch draws, made even for a silent cube, whose
                    // Entity.playSound is then skipped) only follows a hit
                    // that landed.
    // rust: if self.mob_hits_mob(target, amount, source)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == cube)
    // rust: {
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: let at = m.center();
    // rust: if !m.silent {
    // rust: self.handle_mob_events(vec![MobEvent::Sound(
    // rust: "entity.slime.attack",
    // rust: at,
    // rust: 1.0,
    // rust: pitch,
    // rust: )])?;
}
}
}
    // rust: MobEvent::SonicBoom {
    // rust: target,
    // rust: attacker,
    // rust: from,
    // rust: direction,
    // rust: } => {
                    // SonicBoom: the push only follows a hit that landed, scaled
                    // by the target's KNOCKBACK_RESISTANCE.
    // rust: let (hurt, resistance) = match target {
    // rust: Who::Player => {
    // rust: let hurt = self.mob_hits_player(10.0, from, "minecraft:sonic_boom");
    // rust: let resistance = self.player.as_mut().map_or(0.0, |p| {
    // rust: p.attribute("minecraft:knockback_resistance").unwrap_or(0.0)
    // rust: });
    // rust: (hurt, resistance)
}
    // rust: Who::Mob(id) => {
    // rust: let source = Damage {
    // rust: kind: DamageKind::SonicBoom,
    // rust: attacker: Some(Who::Mob(attacker)),
    // rust: from: Some(from),
    // rust: attacker_species: Some(Species::Warden),
}
    // rust: let hurt = self.mob_hits_mob(id, 10.0, source);
    // rust: let resistance = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or(0.0, |m| self.mob_knockback_resistance(m));
    // rust: (hurt, resistance)
}
}
    // rust: if hurt {
    // rust: let horizontal = 2.5 * (1.0 - resistance);
    // rust: let vertical = 0.5 * (1.0 - resistance);
    // rust: let velocity = [
    // rust: direction[0] * horizontal,
    // rust: direction[1] * vertical,
    // rust: direction[2] * horizontal,
    // rust: ];
    // rust: self.handle_mob_events(vec![MobEvent::Push { target, velocity }])?;
}
}
    // rust: MobEvent::FinishAdmiring { mob } => self.finish_admiring(mob),
    // rust: MobEvent::Hiss { mob } => {
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == mob) {
    // rust: let at = m.center();
    // rust: let sound = horizon_client::mobs::finalize::variant_sound(m, "hiss")
    // rust: .unwrap_or("entity.cat.hiss");
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), 1.0, 1.0);
}
}
    // rust: MobEvent::Tamed { .. } | MobEvent::Buck { .. } | MobEvent::StabDismount { .. } => {
    // rust: self.mount_event(&e)
}
    // rust: MobEvent::Launch { target, up } => match target {
    // rust: Who::Player => {
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity.y += up;
}
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.velocity.y += up;
}
}
    // rust: },
    // rust: MobEvent::Bonemeal { pos } => {
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: if self.with_level(|b, level, ticks| b.grow_crop(level, ticks, at)) {
    // rust: self.level_events
    // rust: .push(horizon_world::level::LevelEvent::LevelEvent {
    // rust: id: 1505,
    // rust: pos: at,
    // rust: data: 15,
    // rust: });
    // rust: let _ = self.process_level_events();
}
}
    // rust: MobEvent::RingBell { bell } => {
    // rust: let pos = BlockPos::new(bell[0], bell[1], bell[2]);
    // rust: let rang = self
    // rust: .with_level(|b, level, ticks| b.bell_attempt_to_ring(level, ticks, pos));
    // rust: if rang {
    // rust: let _ = self.process_level_events();
}
}
    // rust: MobEvent::ChestOpen { chest, open } => self.golem_chest_open(chest, open),
    // rust: MobEvent::ChestSlot { chest, slot, stack } => {
    // rust: self.golem_chest_slot(chest, slot, stack)
}
    // rust: MobEvent::BecomeStatue { mob } => self.golem_become_statue(mob),
    // rust: MobEvent::EnterHive { mob, hive } => self.bee_enter_hive(mob, hive),
    // rust: MobEvent::ParrotToShoulder { mob } => self.parrot_to_shoulder(mob),
    // rust: MobEvent::Infested { mob } => self.mob_infested(mob),
    // rust: MobEvent::Gift { target, item } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == target)
    // rust: && m.saddle_item().is_none()
    // rust: {
    // rust: m.set_saddle(Some(ItemStack::new(item, 1)));
}
}
    // rust: MobEvent::HurtSelf { mob, kind, amount } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.damage(amount, horizon_client::mobs::Damage::of(kind));
}
}
    // rust: MobEvent::SetTarget { mob, target } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.ai.target = Some(target);
}
}
    // rust: MobEvent::HuntHoglin { mob, target, ticks } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.extra.ints[0] = ticks;
    // rust: if m.ai.target.is_none() {
    // rust: m.ai.target = Some(Who::Mob(target));
}
}
}
    // rust: MobEvent::Projectile(p) => self.launch_mob_projectile(p),
    // rust: MobEvent::BowShot {
    // rust: mob,
    // rust: weapon,
    // rust: mut arrow,
    // rust: } => {
    // rust: self.mob_bow_ammo(mob, &weapon, &mut arrow);
    // rust: self.launch_mob_projectile(arrow);
}
    // rust: MobEvent::CrossbowShot { ammo, mut arrow } => {
    // rust: if &*ammo.item == "minecraft:firework_rocket" {
                        // `CrossbowItem.createProjectile`: a rocket, from 0.15 under the eyes.
    // rust: let mut at = arrow.position;
    // rust: at.y -= f64::from(0.15f32) - 0.1;
    // rust: self.launch_angled_rocket(at, arrow.velocity, &ammo, arrow.owner);
    // rust: } else {
    // rust: Self::arrow_from_ammo(&ammo, &mut arrow);
    // rust: self.launch_mob_projectile(arrow);
}
}
    // rust: MobEvent::CrossbowLoad {
    // rust: mob,
    // rust: weapon,
    // rust: at,
    // rust: pitch,
    // rust: } => {
    // rust: if self.mob_crossbow_ammo(mob, &weapon) {
    // rust: self.audio.play(
    // rust: "minecraft:item.crossbow.loading_end",
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
}
    // rust: MobEvent::Spawn(mut m) => {
    // rust: self.next_entity += 1;
    // rust: m.id = self.next_entity;
    // rust: self.mobs.push(*m);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
}
    // rust: MobEvent::SpawnKind { kind, at, setup } => {
    // rust: if let Some(id) = self.spawn_mob(&kind, at, setup.persistent) {
    // rust: self.apply_setup(id, &setup);
}
}
    // rust: MobEvent::Convert { from, kind, params } => {
    // rust: let id = self.convert_to(&from, kind, params);
                    // `Piglin.finishConversion` and `Hoglin.finishConversion`:
                    // the converted mob is nauseous for 10 seconds.
    // rust: if matches!(kind, "minecraft:zombified_piglin" | "minecraft:zoglin")
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| Some(m.id) == id)
    // rust: {
    // rust: m.add_effect("minecraft:nausea", 200, 0);
}
                    // `Tadpole.ageUp`: the frog is finalized for the
                    // conversion and made persistent.
    // rust: if kind == "minecraft:frog"
    // rust: && let Some(id) = id
    // rust: {
    // rust: self.finalize_converted(id);
}
}
    // rust: MobEvent::ThrowItem {
    // rust: mob,
    // rust: stack,
    // rust: at,
    // rust: motion,
    // rust: pickup_delay,
    // rust: } => {
                    // `thrownItem.setThrower(the mob)`.
    // rust: self.spawn_item(stack, at, motion, pickup_delay);
    // rust: let thrower = self.mob_uuid(mob);
    // rust: if let Some(thrown) = self.just_spawned_item() {
    // rust: thrown.thrower = Some(thrower);
}
}
    // rust: MobEvent::DropItem {
    // rust: mob,
    // rust: item,
    // rust: count,
    // rust: at,
    // rust: } => {
    // rust: self.native_entity_drop_item(mob, &item, count as i32, at);
    // rust: self.spawn_item(
    // rust: ItemStack {
    // rust: item,
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: },
    // rust: at,
                        // The ItemEntity constructor's motion, from the entity's
                        // own random (not the level's), so spawnAtLocation drops
                        // (a fox's berries, a panda's held food, a goat's horn)
                        // land apart.
    // rust: dispenser::new_item_motion(),
    // rust: 10,
    // rust: );
}
    // rust: MobEvent::DropGoatHorn {
    // rust: mob,
    // rust: screaming,
    // rust: at,
    // rust: motion,
    // rust: } => {
    // rust: let instrument =
    // rust: horizon_client::mobs::goat::create_horn(self.mob_uuid(mob), screaming);
    // rust: let mut horn = ItemStack::new("minecraft:goat_horn", 1);
    // rust: horn.data_mut().set_other(
    // rust: "minecraft:instrument",
    // rust: Some(horizon_world::nbt::Tag::String(instrument.into())),
    // rust: );
                    // Goat.dropHorn's ItemEntity constructor leaves pickupDelay at
                    // 0 (no setDefaultPickUpDelay).
    // rust: self.spawn_item(horn, at, motion, 0);
}
    // rust: MobEvent::DropGift { table, at } => {
    // rust: let stacks =
    // rust: self.res
    // rust: .items()
    // rust: .loot_table(table, false, None, &mut self.world.random);
    // rust: for stack in stacks {
                        // The ItemEntity constructor's motion, from the
                        // entity's own random (not the level's).
    // rust: self.spawn_item(stack, at, dispenser::new_item_motion(), 10);
}
}
                // `Level.setBlockAndUpdate`: neighbour and shape updates, so a crop
                // above trampled farmland breaks and drops.
    // rust: MobEvent::SetBlock { pos, state } => self.level_set(pos, state)?,
    // rust: MobEvent::EndermanPlaceBlock {
    // rust: mob,
    // rust: pos,
    // rust: carried,
    // rust: occupants,
    // rust: } => {
    // rust: self.enderman_place_block(mob, pos, carried, &occupants)?;
}
    // rust: MobEvent::CropRaided {
    // rust: pos,
    // rust: state,
    // rust: old,
    // rust: mob,
    // rust: } => {
    // rust: self.level_set_with_flags(
    // rust: pos,
    // rust: state,
    // rust: horizon_world::level::flags::UPDATE_CLIENTS,
    // rust: )?;
    // rust: if let Some(old) = old {
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: pos,
    // rust: Some(Who::Mob(mob)),
    // rust: None,
    // rust: );
    // rust: self.level_event_at(2001, pos, old.0 as i32);
}
}
    // rust: MobEvent::CrackTurtleEgg { pos } => self.crack_turtle_egg(pos)?,
    // rust: MobEvent::BedOccupied { pos, occupied } => self.set_bed_occupied(pos, occupied),
    // rust: MobEvent::SetDoorOpen { pos, open } => {
    // rust: let pos = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.set_door_open(level, ticks, pos, open));
    // rust: self.process_level_events()?;
}
    // rust: MobEvent::BreakDoor { mob, pos } => {
                    // BreakDoorGoal.tick: removeBlock, then level events 1021
                    // and 2001 with the state that is there now.
    // rust: let kind = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map(super::native_hooks::mob_kind)
    // rust: .unwrap_or_default();
    // rust: let air = self.world.air;
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, air, 3));
    // rust: self.process_level_events()?;
    // rust: self.level_event_at(1021, pos, 0);
    // rust: let left = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.level_event_at(2001, pos, left.0 as i32);
    // rust: self.native_entity_break_door(mob, &kind, pos);
}
    // rust: MobEvent::DestroyProgress { mob, pos, progress } => {
    // rust: self.server_destroy_block_progress(mob as i32, pos, progress);
}
    // rust: MobEvent::LevelEvent { id, pos, data } => self.level_event_at(id, pos, data),
    // rust: MobEvent::SetBlockName {
    // rust: mob,
    // rust: pos,
    // rust: name,
    // rust: effect,
    // rust: flags,
    // rust: } => {
    // rust: if effect {
                        // EatBlockGoal passes the block's default state constant
                        // (Blocks.GRASS_BLOCK.defaultBlockState()), not the live state
                        // (which could be snowy).
    // rust: let old = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let state = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state(&self.res.facts().get(old).name)
    // rust: .unwrap_or(old);
    // rust: self.level_event_at(2001, pos, state.0 as i32);
}
    // rust: if let Some(state) = self.pack.assets.registry.default_state(name) {
    // rust: let old_name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: .clone();
    // rust: self.level_set_with_flags(pos, state, flags)?;
    // rust: if let Some(mob) = mob
    // rust: && let Some(m) = self.mobs.iter().find(|m| m.id == mob)
    // rust: {
    // rust: let kind = m.kind.id.clone();
    // rust: self.native_entity_change_block(mob, &kind, pos, &old_name, name);
}
}
}
    // rust: MobEvent::Infest {
    // rust: pos,
    // rust: infested,
    // rust: poof,
    // rust: } => {
    // rust: let registry = &self.pack.assets.registry;
    // rust: let old = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if let Some(mut state) = registry.state(old).cloned() {
    // rust: let (from, to) = if infested {
    // rust: ("minecraft:", "minecraft:infested_")
    // rust: } else {
    // rust: ("minecraft:infested_", "minecraft:")
}
    // rust: state.name = state.name.replacen(from, to, 1);
    // rust: if let Ok(id) = registry.resolve(&state) {
    // rust: self.level_set(pos, id)?;
}
}
    // rust: if let Some(mob) = poof {
    // rust: self.mob_poof(mob);
}
}
    // rust: MobEvent::BreakBlock { pos, drop } => {
    // rust: let old = self.world.block(pos[0], pos[1], pos[2]);
                    // InfestedBlock.spawnAfterBreak: its silverfish comes out
                    // when blocks drop.
    // rust: if drop
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .get(old)
    // rust: .name
    // rust: .starts_with("minecraft:infested_")
    // rust: && self.ui.rules.bool("block_drops")
    // rust: {
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: if let Some(id) = self.spawn_mob("minecraft:silverfish", at, false) {
    // rust: self.mob_poof(id);
}
}
                    // Block.spawnDestroyParticles: fire breaks leave nothing.
    // rust: if !self.res.facts().get(old).has_class("BaseFireBlock") {
    // rust: self.level_event_at(2001, pos, old.0 as i32);
}
    // rust: if drop {
    // rust: let mut drops = world_items!(self).block_drops_in(
    // rust: self.pack.assets.registry,
    // rust: old,
    // rust: None,
    // rust: &mut self.world.random,
    // rust: Some((&mut self.rand_sequences, self.level.seed)),
    // rust: );
    // rust: self.native_block_drops(pos, old, None, None, None, &mut drops);
    // rust: for d in drops {
    // rust: self.pop_resource(pos, d);
}
}
                    // Level.destroyBlock: setBlock(fluidState.createLegacyBlock(), 3),
                    // so water stays water and a waterlogged block leaves its water.
    // rust: let b = self.res.behaviours();
    // rust: let left = b.legacy_block(b.fluid(old));
    // rust: if left != old {
    // rust: self.level_set(pos, left)?;
}
}
    // rust: MobEvent::Particles { kind, at, count } => {
                    // Mob particle bursts (hearts, smoke, splashes) around a point.
    // rust: if let Some(ty) = horizon_client::particles::ParticleType::from_name(kind) {
    // rust: if kind.starts_with("item_") {
    // rust: self.ensure_item_particle_sprites();
}
    // rust: let options = horizon_client::particles::ParticleOptions::simple(ty);
    // rust: if ty == horizon_client::particles::ParticleType::SonicBoom {
    // rust: self.lan_sonic_boom(&options, at);
}
                        // Count 0: one particle exactly there, at rest.
    // rust: if count == 0 {
    // rust: self.particles.add(&options, at, [0.0; 3]);
}
    // rust: for _ in 0..count {
    // rust: let r = &mut self.world.random;
    // rust: let p = [
    // rust: at[0] + (f64::from(r.next_float()) - 0.5),
    // rust: at[1] + (f64::from(r.next_float()) - 0.5) * 0.5,
    // rust: at[2] + (f64::from(r.next_float()) - 0.5),
    // rust: ];
    // rust: let v = [
    // rust: r.next_gaussian() * 0.02,
    // rust: r.next_gaussian() * 0.02,
    // rust: r.next_gaussian() * 0.02,
    // rust: ];
    // rust: self.particles.add(&options, p, v);
}
}
}
    // rust: MobEvent::AroundSelf {
    // rust: mob,
    // rust: event,
    // rust: kind,
    // rust: feet,
    // rust: width,
    // rust: height,
    // rust: burst,
    // rust: } => {
    // rust: self.lan_entity_event(mob as i32, event, feet);
    // rust: self.particles_around(kind, feet, [width, height], burst)
}
    // rust: MobEvent::ParticleAt { kind, at, velocity } => {
    // rust: if let Some(ty) = horizon_client::particles::ParticleType::from_name(kind) {
    // rust: let options = horizon_client::particles::ParticleOptions::simple(ty);
    // rust: self.particles.add(&options, at, velocity);
}
}
    // rust: MobEvent::ParticleColored {
    // rust: at,
    // rust: color: [r, g, b],
    // rust: } => {
    // rust: let options = horizon_client::particles::ParticleOptions::colored(
    // rust: horizon_client::particles::ParticleType::EntityEffect,
    // rust: [r, g, b, 1.0],
    // rust: );
    // rust: self.particles.add(&options, at, [0.0; 3]);
}
    // rust: MobEvent::Experience { at, amount } => self.spawn_breeding_orb(at, amount),
    // rust: MobEvent::AxolotlSupportPlayer { mob } => {
    // rust: let previous = self
    // rust: .potions
    // rust: .effects
    // rust: .get("regeneration")
    // rust: .map_or(0, |e| e.duration);
    // rust: if (0..=2399).contains(&previous) {
    // rust: self.potions
    // rust: .effects
    // rust: .add(horizon_client::effects::EffectInstance::new(
    // rust: "regeneration",
    // rust: (previous + 100).min(2400),
    // rust: 0,
    // rust: ));
}
    // rust: self.potions
    // rust: .effects
    // rust: .list
    // rust: .retain(|e| e.id != "mining_fatigue");
    // rust: let source = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map(|m| self.mob_entity(m));
    // rust: self.trigger_effects_changed_by(source);
}
    // rust: MobEvent::DolphinTreasure { mob } => {
                    // ServerLevel.findNearestMapStructure(#dolphin_located, 50).
    // rust: let Some(at) = self.mobs.iter().find(|m| m.id == mob).map(|m| {
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
    // rust: }) else {
    // rust: continue;
}
    // rust: let names = self.structure_tag("minecraft:dolphin_located");
    // rust: let found = self
    // rust: .end
    // rust: .locator()
    // rust: .filter(|_| !names.is_empty())
    // rust: .and_then(|t| t.locate(&names, at, 50));
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.extra.home = found.map(|(_, p)| p);
}
}
    // rust: MobEvent::EffectPlayer {
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: ambient,
    // rust: } => {
    // rust: self.give_mob_effect(effect, ticks, amplifier, ambient);
}
    // rust: MobEvent::EffectMob {
    // rust: target,
    // rust: effect,
    // rust: ticks,
    // rust: amplifier,
    // rust: } => {
    // rust: if let Some(t) = self.mobs.iter_mut().find(|m| m.id == target) {
    // rust: t.add_effect(effect, ticks, amplifier);
}
}
    // rust: MobEvent::Ignite { target, seconds } => match target {
    // rust: Who::Player => {
    // rust: if !self.creative
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
    // rust: p.ignite_for_ticks(seconds * 20)?;
}
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.ignite_for_ticks(seconds * 20);
}
}
    // rust: },
    // rust: MobEvent::Breed {
    // rust: parent,
    // rust: partner,
    // rust: llama,
    // rust: } => {
    // rust: let mob_count = self.mobs.len();
    // rust: self.breed(parent, partner, llama);
    // rust: let child = self.mobs.get(mob_count).map(|m| m.id);
    // rust: self.native_entity_breed(parent, partner, child);
}
    // rust: MobEvent::LockGaze { mob, partner } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: horizon_client::mobs::animal_brain::lock_gaze(m, partner);
}
}
    // rust: MobEvent::BreedTarget { mob, partner } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: horizon_client::mobs::animal_brain::set_breed_partner(m, partner);
}
}
    // rust: MobEvent::Retreat { mob, from, at } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: horizon_client::mobs::piglin::receive_retreat(m, from, at);
}
}
    // rust: MobEvent::StartRiding { rider, vehicle } => {
    // rust: if horizon_client::mobs::riders::start_riding(&mut self.mobs, rider, vehicle) {
                        // sendEventAndTriggers: the server players already on it.
    // rust: self.note_started_riding(vehicle);
}
}
                // Applied after the fish's tick (`apply_brain_events`).
    // rust: MobEvent::StartFollowing { .. }
    // rust: | MobEvent::SchoolSize { .. }
    // rust: | MobEvent::PufferfishSting { .. } => {}
    // rust: MobEvent::LeashBreak { mob, drop, sound } => self.break_leash(mob, drop, sound),
    // rust: MobEvent::NotifyLeashHolder { holder } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == holder) {
    // rust: horizon_client::mobs::happy_ghast::notify_leash_holder(m);
}
}
    // rust: MobEvent::Vibration {
    // rust: from,
    // rust: to,
    // rust: ticks,
    // rust: source,
    // rust: } => self.mob_vibration_particle(source, from, to, ticks),
    // rust: MobEvent::DigParticles { at } => self.warden_dig_particles(at),
    // rust: MobEvent::BlockBreakEffect { pos, block } => {
                    // Turtle.aiStep broadcasts LevelEvent 2001, not the
                    // particles themselves: the event carries the particles and
                    // the sand's break sound, and reaches the clients the same
                    // way a broken block's does.
    // rust: let state = self.world.block(block[0], block[1], block[2]);
    // rust: self.level_event_at(2001, pos, state.0 as i32);
}
    // rust: MobEvent::Darkness { at, radius } => self.apply_darkness(at, radius),
    // rust: MobEvent::CreakingHurt {
    // rust: home,
    // rust: by_player,
    // rust: id,
    // rust: } => self.creaking_hurt(home, id, by_player),
    // rust: MobEvent::CreakingTearDown { center, spread } => {
    // rust: self.creaking_tear_down(center, spread)
}
    // rust: MobEvent::CureZombieVillager { mob } => self.cure_zombie_villager(mob),
    // rust: MobEvent::Reinforcements { mob, target } => self.call_reinforcements(mob, target),
    // rust: MobEvent::VillagerMeet { mob, other } => self.villager_meet(mob, other),
    // rust: MobEvent::VillagerOffers { mob } => {
    // rust: if let Some(i) = self.mobs.iter().position(|m| m.id == mob) {
    // rust: self.ensure_offers(i);
}
}
    // rust: MobEvent::VillagerBirth {
    // rust: parent,
    // rust: partner,
    // rust: child,
    // rust: } => self.villager_birth(parent, partner, child),
    // rust: MobEvent::WorkAtComposter { mob, pos } => self.villager_work_at_composter(mob, pos),
    // rust: MobEvent::GolemCheck { mob, needed } => self.villager_golem_check(mob, needed),
    // rust: MobEvent::Firework { at, color, flight } => {
    // rust: self.villager_firework(at, color, flight)
}
    // rust: MobEvent::ThrowGift { table, from, to } => self.throw_gift(&table, from, to),
    // rust: MobEvent::PatrolTarget { mob, target } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: horizon_client::mobs::raider::set_patrol_target(m, target);
}
}
    // rust: MobEvent::RaiderTarget {
    // rust: mob,
    // rust: target,
    // rust: aggressive,
    // rust: } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.ai.target = Some(target);
    // rust: m.ai.aggressive |= aggressive;
}
}
    // rust: MobEvent::PandaSneezed { mob } => self.panda_sneezed(mob),
    // rust: MobEvent::FallToPassengers {
    // rust: mob,
    // rust: distance,
    // rust: modifier,
    // rust: } => self.fall_to_passengers(mob, distance, modifier),
    // rust: MobEvent::ShedScute { mob, at, pitch } => {
                    // The mob already checked `shouldDropLoot` (a baby, `mob_drops`).
    // rust: let table = "minecraft:gameplay/armadillo_shed";
    // rust: let drops = self.sequence_loot(table, table, None);
    // rust: for d in drops {
    // rust: self.spawn_at_location(Vec3::new(at[0], at[1], at[2]), 0.0, d);
}
    // rust: self.audio.play(
    // rust: "minecraft:entity.armadillo.scute_drop",
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
    // rust: let ctx = self.who_context(Some(Who::Mob(mob)), None);
    // rust: self.post_game_event("minecraft:entity_place", at, ctx);
}
    // rust: MobEvent::LayEgg { mob, at, pitch } => {
                    // Chicken.aiStep: `dropFromGiftLootTable` says whether
                    // anything dropped; only then the sound and the game event.
    // rust: if self.drop_gift_loot(mob, "minecraft:gameplay/chicken_lay", at) {
    // rust: self.audio
    // rust: .play("minecraft:entity.chicken.egg", Some(at), 1.0, pitch);
    // rust: let ctx = self.who_context(Some(Who::Mob(mob)), None);
    // rust: self.post_game_event("minecraft:entity_place", at, ctx);
}
}
    // rust: MobEvent::GiftLoot { mob, table, at } => {
                    // Turtle.ageBoundaryReached and Panda.afterSneeze: only
                    // with mob loot on.
    // rust: if matches!(
    // rust: table,
    // rust: "minecraft:gameplay/turtle_grow" | "minecraft:gameplay/panda_sneeze"
    // rust: ) && !self.ui.rules.bool("mob_drops")
    // rust: {
    // rust: continue;
}
    // rust: self.drop_gift_loot(mob, table, at);
}
}
}
    // rust: Ok(())
}
    // `TurtleEggBlock.decreaseEggs` after an entity's step or landing won its
    // roll (`destroyEgg`): the break sound and the remaining eggs (a stack of
    // one is destroyed after it).
    // rust: pub(super) fn crack_turtle_egg(&mut self, pos: [i32; 3]) -> Result<()> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let eggs = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| s.name == "minecraft:turtle_egg")
    // rust: .and_then(|s| s.properties.get("eggs"))
    // rust: .and_then(|e| e.parse::<i32>().ok());
    // rust: if let Some(eggs) = eggs {
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.turtle_egg_destroyed_by_player(level, ticks, at, state);
    // rust: if eggs <= 1 {
    // rust: b.destroy_block(level, ticks, at, false);
}
    // rust: });
    // rust: self.process_level_events()?;
}
    // rust: Ok(())
}
    // `TurtleEggBlock.randomTick` at the last hatch stage: one baby turtle
    // per egg, a day from grown, with the egg as its home (the sound, the
    // crumbs and the block's removal came from the level).
    // rust: pub(super) fn hatch_turtles(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: ) {
    // rust: let eggs = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("eggs"))
    // rust: .and_then(|v| v.parse::<i32>().ok())
    // rust: .unwrap_or(1);
    // rust: for i in 0..eggs {
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.3 + f64::from(i) * 0.2,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.3,
    // rust: ];
    // rust: if let Some(id) = self.spawn_mob("minecraft:turtle", at, true)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: m.extra.age = -24000;
    // rust: m.extra.home = Some(pos);
    // rust: m.yaw = 0.0;
    // rust: m.body_yaw = 0.0;
    // rust: m.head_yaw = 0.0;
}
}
}
apply_setup :: proc(self: ^Self, id: u32, setup: ^SpawnSetup) {
}
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: if setup.baby {
    // rust: m.extra.age = -24000;
}
    // rust: if setup.nausea {
    // rust: m.add_effect("minecraft:nausea", 200, 0);
}
    // rust: if setup.size > 0 {
    // rust: m.extra.size = setup.size;
}
    // rust: m.yaw = setup.yaw;
    // rust: m.body_yaw = setup.yaw;
    // rust: m.head_yaw = setup.yaw;
    // rust: m.velocity = Vec3::new(setup.velocity[0], setup.velocity[1], setup.velocity[2]);
    // rust: if let Some(h) = setup.health {
    // rust: m.health = h;
}
    // rust: if let Some(v) = setup.variant {
    // rust: m.extra.variant = v;
}
    // rust: if let Some(owner) = setup.owner_mob {
    // rust: m.extra.counter2 = owner as i32;
}
    // rust: if let Some(home) = setup.home {
    // rust: m.extra.home = Some(home);
}
    // rust: if let Some(life) = setup.life {
    // rust: m.extra.egg_time = life;
}
}
    // `Animal.finalizeSpawnChildFromBreeding`'s experience orb: only when the
    // `mob_drops` game rule is on.
spawn_breeding_orb :: proc(self: ^Self, at: [f64; 3], amount: u32) {
}
    // rust: if self.ui.rules.bool("mob_drops") {
    // rust: self.spawn_orbs(at, amount);
}
}
    // `ServerPlayer.tellNeutralMobsThatIDied`: the mobs within 32 blocks
    // across and 10 up and down get `NeutralMob.playerDied`, when the
    // `forgive_dead_players` rule is on. A mob's `Who::Player` is the guest
    // it is bound to in `bindings` (game/lan_mobs.rs), else the host's
    // player, so only the mobs whose binding is `conn` (`None` for the
    // host's player) hear it.
    // rust: pub(super) fn tell_neutral_mobs_player_died(
    // rust: &mut self,
    // rust: feet: [f64; 3],
    // rust: conn: Option<u32>,
    // rust: bindings: &horizon_client::fast_hash::FxHashMap<u32, u32>,
    // rust: ) {
        // A client of someone else's world has the server's mobs only to show.
    // rust: if self.remote.is_some() || !self.ui.rules.bool("forgive_dead_players") {
    // rust: return;
}
    // rust: let block = feet.map(f64::floor);
    // rust: let area = Aabb::new(
    // rust: Vec3::new(block[0], block[1], block[2]),
    // rust: Vec3::new(block[0] + 1.0, block[1] + 1.0, block[2] + 1.0),
    // rust: )
    // rust: .inflate(Vec3::new(32.0, 10.0, 32.0));
    // rust: for m in self.mobs.iter_mut() {
    // rust: if bindings.get(&m.id).copied() == conn && m.bounds().intersects(area) {
    // rust: horizon_client::mobs::ai::forgive_dead_player(m);
}
}
}
    // Animal.spawnChildFromBreeding
    // rust: fn breed(
    // rust: &mut self,
    // rust: parent: u32,
    // rust: partner: u32,
    // rust: llama: Option<Box<horizon_client::mobs::llama::Offspring>>,
    // rust: ) {
    // rust: let Some(p) = self.mobs.iter().find(|m| m.id == parent).cloned() else {
    // rust: return;
}
        // BabyEntitySpawnEvent: not for an egg (turtle, frog, sniffer).
    // rust: if !matches!(
    // rust: p.species(),
    // rust: Species::Turtle | Species::Frog | Species::Sniffer
    // rust: ) && !horizon_client::mod_api::mods().is_empty()
    // rust: {
    // rust: let mule = matches!(
    // rust: (
    // rust: p.species(),
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == partner)
    // rust: .map(|m| m.species())
    // rust: ),
    // rust: (Species::Horse, Some(Species::Donkey)) | (Species::Donkey, Some(Species::Horse))
    // rust: );
    // rust: let kind = if mule {
    // rust: "minecraft:mule".to_owned()
    // rust: } else {
    // rust: super::native_hooks::mob_kind(&p)
}
    // rust: let conn = self
    // rust: .love_cause
    // rust: .get(&parent)
    // rust: .or(self.love_cause.get(&partner))
    // rust: .copied();
    // rust: let player = conn.and_then(|c| self.killer_uuid(c)).unwrap_or(0);
    // rust: let mut cancel = false;
    // rust: self.native_baby_entity_spawn(parent, partner, player, &kind, &mut cancel);
    // rust: if cancel {
    // rust: breeding_credit(&mut self.love_cause, parent, partner);
    // rust: if let Some(q) = self.mobs.iter_mut().find(|m| m.id == partner) {
    // rust: q.extra.age = 6000;
    // rust: q.extra.in_love = 0;
}
    // rust: return;
}
}
        // Animal.finalizeSpawnChildFromBreeding: the player who fed the parent,
        // or else the one who fed the partner.
    // rust: if let Some(cause) = breeding_credit(&mut self.love_cause, parent, partner) {
    // rust: let parent = self.mob_entity(&p);
    // rust: let partner_view = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == partner)
    // rust: .map(|m| self.mob_entity(m))
    // rust: .unwrap_or_else(|| parent.clone());
    // rust: let mut child = parent.clone();
    // rust: child.baby = true;
            // Not born yet: none of the parent's saved data is its own.
    // rust: child.nbt = None;
            // TurtleBreedGoal.breed triggers it without a child.
    // rust: let turtle = matches!(p.species(), Species::Turtle | Species::Frog);
    // rust: if matches!(
    // rust: (
    // rust: p.species(),
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == partner)
    // rust: .map(|m| m.species())
    // rust: ),
    // rust: (Species::Horse, Some(Species::Donkey)) | (Species::Donkey, Some(Species::Horse))
    // rust: ) {
    // rust: child.kind = "minecraft:mule".into();
}
    // rust: let who = cause.map_or(
    // rust: super::commands::Target::Player,
    // rust: super::commands::Target::Guest,
    // rust: );
    // rust: self.for_player(who, |g| {
    // rust: g.award_custom_stat("animals_bred", 1);
    // rust: g.trigger_bred(&parent, &partner_view, (!turtle).then_some(&child));
    // rust: });
}
    // rust: if let Some(q) = self.mobs.iter_mut().find(|m| m.id == partner) {
    // rust: q.extra.age = 6000;
    // rust: q.extra.in_love = 0;
}
    // rust: let q = self.mobs.iter().find(|m| m.id == partner).cloned();
        // Animal.finalizeSpawnChildFromBreeding: entity event 18 for the parent.
    // rust: self.mob_event_particles(parent, 18);
        // Sniffer.spawnChildFromBreeding: an egg instead of a baby.
    // rust: if p.species() == Species::Sniffer {
    // rust: self.lay_sniffer_egg(&p);
    // rust: return;
}
        // TurtleBreedGoal.breed: the goal gave the mother her egg; only the
        // experience is left, and only with mob loot on.
    // rust: if matches!(p.species(), Species::Turtle | Species::Frog) {
            // One `new ExperienceOrb` of 1 to 7 from the mother's random (not
            // split up as `ExperienceOrb.award` does).
    // rust: if self.ui.rules.bool("mob_drops")
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == parent)
    // rust: {
    // rust: let xp = 1 + m.random.next_int_bound(7).unwrap_or(0) as u32;
    // rust: self.add_orb([p.position.x, p.position.y, p.position.z], xp);
}
    // rust: return;
}
        // (Mooshroom draws its own coin in getOffspringVariant.)
    // rust: let coin = p.species() != Species::Mooshroom
    // rust: && self.world.random.next_int_bound(2).unwrap_or(0) == 0;
        // Axolotl.getBreedOffspring: useRareVariant (one in 1200) makes it blue,
        // else either parent's variant. The draws come from the mother's random.
    // rust: let axolotl = if p.species() == Species::Axolotl {
    // rust: let other = q.as_ref().map_or(p.extra.variant, |q| q.extra.variant);
    // rust: self.mobs.iter_mut().find(|m| m.id == parent).map(|m| {
    // rust: if m.random.next_int_bound(1200).unwrap_or(1) == 0 {
                    // Axolotl.Variant.getRareSpawnVariant: the one blue, still a draw.
    // rust: let _ = m.random.next_int_bound(1);
    // rust: 4
    // rust: } else if m.random.next_boolean() {
    // rust: p.extra.variant
    // rust: } else {
    // rust: other
}
    // rust: })
    // rust: } else {
    // rust: None
}
        // MushroomCow.getOffspringVariant, from the mother's random: the other
        // colour 1 time in 1024 when both parents share one, otherwise either
        // parent's colour by a coin flip.
    // rust: let mooshroom = if p.species() == Species::Mooshroom {
    // rust: let mate = q.as_ref().map_or(p.extra.variant, |q| q.extra.variant);
    // rust: let own = p.extra.variant;
    // rust: self.mobs.iter_mut().find(|m| m.id == parent).map(|m| {
    // rust: if own == mate && m.random.next_int_bound(1024).unwrap_or(1) == 0 {
    // rust: if own == 1 { 0 } else { 1 }
    // rust: } else if m.random.next_boolean() {
    // rust: own
    // rust: } else {
    // rust: mate
}
    // rust: })
    // rust: } else {
    // rust: None
}
        // A horse and a donkey have a mule.
    // rust: let kind = match (p.species(), q.as_ref().map(|q| q.species())) {
    // rust: (Species::Horse, Some(Species::Donkey)) | (Species::Donkey, Some(Species::Horse)) => {
    // rust: "minecraft:mule".to_owned()
}
    // rust: _ => p.kind.id.clone(),
}
    // rust: if let Some(id) = self.spawn_mob(&kind, [p.position.x, p.position.y, p.position.z], true)
    // rust: && let Some(child) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: child.extra.age = -24000;
            // No Mob.finalizeSpawn either: no follow range bonus, right-handed.
    // rust: spawning::bred_offspring(child);
            // getBreedOffspring creates the baby without finalizeSpawn: it keeps
            // the default (`classic`) sound variant.
    // rust: child.extra.sound_variant = None;
            // Fox.getBreedOffspring runs no finalizeSpawn: nothing in the
            // baby fox's mouth.
    // rust: if p.species() == Species::Fox {
    // rust: child.extra.main_hand = None;
}
            // Fox.FoxBreedGoal.breed: the baby trusts the players who fed its
            // parents into love.
    // rust: if p.species() == Species::Fox {
    // rust: horizon_client::mobs::fox::trust_breeders(
    // rust: child,
    // rust: p.extra.love_cause,
    // rust: q.as_ref().and_then(|q| q.extra.love_cause),
    // rust: );
}
            // Goat.getBreedOffspring: GoatAi.initMemories, then the baby
            // screams if the parent a coin toss picks does, or on a 2% roll.
    // rust: if p.species() == Species::Goat {
    // rust: child.extra.lost_horns = [false; 2];
    // rust: horizon_client::mobs::finalize::goat_init_memories(child, &mut self.world.random);
    // rust: let pick_parent = self.world.random.next_boolean();
    // rust: let parent_screams = if pick_parent {
    // rust: p.extra.screaming
    // rust: } else {
    // rust: q.as_ref().unwrap_or(&p).extra.screaming
}
    // rust: child.extra.screaming = parent_screams || self.world.random.next_double() < 0.02;
}
            // A llama's baby was drawn in the parent's tick, with the
            // experience.
    // rust: if let Some(o) = llama {
    // rust: horizon_client::mobs::llama::apply_offspring(child, &o);
    // rust: return;
}
    // rust: if horizon_client::mobs::equine::is_equine(p.species()) {
    // rust: let other = q.clone().unwrap_or_else(|| p.clone());
    // rust: let mut r = self.world.random.clone();
    // rust: horizon_client::mobs::equine::inherit(child, &p, &other, &mut r);
    // rust: if horizon_client::mobs::llama::is_llama(p.species()) {
    // rust: horizon_client::mobs::llama::offspring(child, &p, &other, &mut r);
}
                // Horse.getBreedOffspring: coat from either parent or new.
    // rust: if p.species() == Species::Horse && other.species() == Species::Horse {
    // rust: let c = r.next_int_bound(9).unwrap_or(0);
    // rust: child.extra.variant = if c < 4 {
    // rust: p.extra.variant
    // rust: } else if c < 8 {
    // rust: other.extra.variant
    // rust: } else {
    // rust: r.next_int_bound(7).unwrap_or(0) as u8
}
    // rust: let mk = r.next_int_bound(5).unwrap_or(0);
    // rust: child.extra.variant2 = if mk < 2 {
    // rust: p.extra.variant2
    // rust: } else if mk < 4 {
    // rust: other.extra.variant2
    // rust: } else {
    // rust: r.next_int_bound(5).unwrap_or(0) as u8
}
}
    // rust: self.world.random = r;
    // rust: self.breeding_orb(parent, [p.position.x, p.position.y, p.position.z]);
    // rust: return;
}
    // rust: if p.species() == Species::Cat {
                // Cat.getBreedOffspring.
    // rust: let other = q.as_ref().unwrap_or(&p);
    // rust: child.extra.variant = if coin {
    // rust: p.extra.variant
    // rust: } else {
    // rust: other.extra.variant
}
    // rust: if p.extra.tame {
    // rust: child.extra.tame = true;
    // rust: child.extra.owner = p.extra.owner;
                    // The mix needs all of `self`, so it waits until `child`'s
                    // borrow of the mob list is over.
    // rust: let mixed = dye_mix(
    // rust: world_recipes!(self),
    // rust: &mut self.world.random,
    // rust: p.extra.color,
    // rust: other.extra.color,
    // rust: );
    // rust: if let Some(c) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: c.extra.color = mixed;
}
}
    // rust: self.breeding_orb(parent, [p.position.x, p.position.y, p.position.z]);
    // rust: return;
}
    // rust: if p.species() == Species::Wolf {
                // Wolf.getBreedOffspring: a parent's variant; tame parents
                // give a tame baby with their collar colours mixed.
    // rust: let other = q.as_ref().unwrap_or(&p);
    // rust: child.extra.variant = if coin {
    // rust: p.extra.variant
    // rust: } else {
    // rust: other.extra.variant
}
    // rust: if p.extra.tame {
    // rust: horizon_client::mobs::tame::set_tame(child, true);
    // rust: child.extra.owner = p.extra.owner;
                    // The mix needs all of `self`, so it waits until `child`'s
                    // borrow of the mob list is over.
    // rust: let mixed = dye_mix(
    // rust: world_recipes!(self),
    // rust: &mut self.world.random,
    // rust: p.extra.color,
    // rust: other.extra.color,
    // rust: );
    // rust: if let Some(c) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: c.extra.color = mixed;
}
}
    // rust: self.breeding_orb(parent, [p.position.x, p.position.y, p.position.z]);
    // rust: return;
}
            // Panda.getBreedOffspring: genes from both parents.
    // rust: if p.species() == Species::Panda {
    // rust: horizon_client::mobs::panda::inherit(child, &p, q.as_ref().unwrap_or(&p));
    // rust: self.breeding_orb(parent, [p.position.x, p.position.y, p.position.z]);
    // rust: return;
}
            // Axolotl.getBreedOffspring: the drawn variant, and the baby is persistent.
    // rust: if let Some(variant) = axolotl {
    // rust: child.extra.variant = variant;
    // rust: child.persistent = true;
    // rust: self.breeding_orb(parent, [p.position.x, p.position.y, p.position.z]);
    // rust: return;
}
            // Nautilus.getBreedOffspring: a tame parent's baby is tame too.
    // rust: if p.species() == Species::Nautilus && p.extra.tame {
    // rust: child.extra.tame = true;
    // rust: child.extra.owner = p.extra.owner;
    // rust: child.persistent = true;
}
            // Offspring inherit a parent's variant (pigs/cows/chickens) or mixed wool.
    // rust: child.extra.variant = p.extra.variant;
            // Fox, Pig, Cow and Chicken.getBreedOffspring: either parent's variant.
    // rust: if matches!(
    // rust: p.species(),
    // rust: Species::Fox | Species::Pig | Species::Cow | Species::Chicken
    // rust: ) && !coin
    // rust: {
    // rust: child.extra.variant = q.as_ref().map_or(p.extra.variant, |q| q.extra.variant);
}
    // rust: if let Some(variant) = mooshroom {
    // rust: child.extra.variant = variant;
}
            // Sheep.getBreedOffspring: the lamb's wool mixes both parents' dyes.
    // rust: if p.species() == Species::Sheep {
    // rust: let other = q.as_ref().unwrap_or(&p);
    // rust: let mixed = dye_mix(
    // rust: world_recipes!(self),
    // rust: &mut self.world.random,
    // rust: p.extra.color,
    // rust: other.extra.color,
    // rust: );
    // rust: if let Some(c) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: c.extra.color = mixed;
}
}
}
    // rust: self.breeding_orb(parent, [p.position.x, p.position.y, p.position.z]);
}
    // `Animal.finalizeSpawnChildFromBreeding`'s experience, from the breeding
    // parent's own random, and only when the `mob_drops` game rule is on.
breeding_orb :: proc(self: ^Self, parent: u32, at: [f64; 3]) {
}
    // rust: if self.ui.rules.bool("mob_drops")
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == parent)
    // rust: {
    // rust: let xp = 1 + m.random.next_int_bound(7).unwrap_or(0) as u32;
    // rust: self.spawn_orbs(at, xp);
}
}
    // `MobEffectUtil.addEffectToPlayersAround` for an elder guardian:
    // mining fatigue III for five minutes unless a stronger or longer one
    // is on, with the curse sound and the elder's apparition.
elder_curse :: proc(self: ^Self, at: [f64; 3], silent: bool) {
}
    // rust: let mut cursed = Vec::new();
    // rust: self.for_each_player(|g| {
    // rust: if g.elder_curse_player(at, silent) {
    // rust: cursed.push(g.lan_acting);
}
    // rust: });
        // A guest's client shows the apparition and plays the curse itself
        // (ClientboundGameEventPacket.GUARDIAN_ELDER_EFFECT), the sound only
        // for 1: `isSilent() ? 0.0F : 1.0F`.
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: for conn in cursed.into_iter().flatten() {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &horizon_protocol::packets::play::Clientbound::GameEvent(
    // rust: horizon_protocol::packets::play::GameEvent {
    // rust: event: horizon_client::lan::hub::game_event::GUARDIAN_ELDER_EFFECT,
    // rust: param: crate::mobs::guardian::elder_curse_param(silent),
    // rust: },
    // rust: ),
    // rust: );
}
}
}
    // The curse on the player in place; whether it took.
elder_curse_player :: proc(self: ^Self, at: [f64; 3], silent: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.creative || self.spectator() {
    // rust: return false;
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return false;
}
    // rust: let d = p.position.subtract(Vec3::new(at[0], at[1], at[2]));
    // rust: if d.x * d.x + d.y * d.y + d.z * d.z >= 2500.0 || p.health.dead_or_dying() {
    // rust: return false;
}
        // The player's effects are kept by their bare name. A curse as strong
        // that won't end within the next minute stays (endsWithin(1199)).
    // rust: let active = self.potions.effects.get("mining_fatigue");
    // rust: if active.is_some_and(|e| e.amplifier >= 2 && !e.ends_within(1199)) {
    // rust: return false;
}
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: self.give_player_effect("minecraft:mining_fatigue", 6000, 2);
    // rust: if self.lan_acting.is_none() {
            // ClientPacketListener.handleGameEvent: the apparition always, the
            // curse sound unless the elder is silent.
    // rust: if crate::mobs::guardian::elder_curse_param(silent) == 1.0 {
    // rust: self.audio
    // rust: .play("minecraft:entity.elder_guardian.curse", Some(at), 1.0, 1.0);
}
    // rust: self.creatures.elder_apparition = super::mob_blocks::APPARITION_TICKS;
}
    // rust: true
}
    // Damage of a given type to the player from a point.
    // rust: pub(super) fn mob_hits_player_kind(&mut self, amount: f32, from: [f64; 3], kind: &str) {
    // rust: self.mob_hits_player(amount, from, kind);
}
    // Damage whose causing mob is known (`cause`, or none): not guessed
    // from the mob nearest to `from`.
    // rust: pub(super) fn mob_hits_player_caused(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: from: [f64; 3],
    // rust: kind: &str,
    // rust: cause: Option<u32>,
    // rust: ) {
    // rust: self.hurt_player_from(amount, Some(from), kind, Some(cause));
}
    // rust: pub(super) fn mob_hits_player(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: from: [f64; 3],
    // rust: damage_type: &str,
    // rust: ) -> bool {
    // rust: self.hurt_player_from(amount, Some(from), damage_type, None)
}
    // `hurtServer` on the player. `from` is the source's position (none: no
    // direction), `known`: the causing mob when it is given (`/damage`),
    // else the melee attacker is the mob nearest to `from`.
    // rust: pub(super) fn hurt_player_from(
    // rust: &mut self,
    // rust: amount: f32,
    // rust: from: Option<[f64; 3]>,
    // rust: damage_type: &str,
    // rust: known: Option<Option<u32>>,
    // rust: ) -> bool {
    // rust: let post_attack_if_alive = std::mem::take(&mut self.combat.post_attack_if_alive);
    // rust: let rocket = std::mem::take(&mut self.combat.rocket_hit);
        // ServerPlayer.canHarmPlayer refused another player's projectile.
    // rust: if self.creative || self.combat.refuse_player_hit {
    // rust: self.combat.forget_noted(false);
    // rust: return false;
}
        // A projectile entity dealt it: `#is_projectile`, or a firework
        // rocket (its `fireworks` type is not in the tag).
    // rust: let projectile = rocket
    // rust: || world_stations!(self)
    // rust: .enchantments
    // rust: .damage_tags
    // rust: .get("minecraft:is_projectile")
    // rust: .is_some_and(|t| t.contains(damage_type));
    // rust: let blocking = self.player_blocking(from, damage_type, false);
    // rust: let raised = blocking.is_some();
        // Melee: the attacker stands at `from` (another player's hit has no mob behind it).
    // rust: let attacker = match known {
    // rust: Some(known) => known,
    // rust: None => from
    // rust: .filter(|_| !projectile && damage_type != "minecraft:player_attack")
    // rust: .and_then(|from| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .min_by(|a, b| {
    // rust: let d = |m: &horizon_client::mobs::Mob| {
    // rust: (m.position.x - from[0]).powi(2) + (m.position.z - from[2]).powi(2)
}
    // rust: d(a).total_cmp(&d(b))
    // rust: })
    // rust: .map(|m| m.id)
    // rust: }),
}
        // The causing entity for the death message.
    // rust: let owner = self.combat.projectile_owner.take();
    // rust: let _attacker = self.knockback_scope(
    // rust: attacker
    // rust: .or(owner)
    // rust: .map_or_else(horizon_client::health::knockback_attacker, |id| id as i32),
    // rust: );
    // rust: if let Some(a) = attacker.or(owner) {
    // rust: self.note_attacker(damage_type, a);
}
    // rust: if let Some((id, name)) = self.combat.projectile_attacker.take() {
    // rust: self.note_named_attacker(damage_type, id, name);
}
        // The projectile is the direct entity: named when it has no owner.
    // rust: if let Some(name) = self.combat.projectile_direct.take() {
    // rust: self.note_direct_entity(damage_type, name);
}
        // DamageSource.scalesWithDifficulty: a mob (or its projectile's
        // owner) caused the hit, not a player.
    // rust: let living_cause = attacker.or(owner).is_some();
        // The native damage hook's causing entity: the one given, or the
        // owner of the projectile that hit (`projectile_owner` outlives a
        // projectile's other hits), not the guessed melee attacker.
    // rust: let owner = owner.filter(|_| projectile);
    // rust: let causing = known.flatten().or(owner).map_or(0, |id| id as i32);
    // rust: let mut outcome = horizon_client::health::BlockOutcome::default();
        // The hit's own push, held back until after the shield's (`hurtServer`
        // runs `applyItemBlocking` before `dealDefaultKnockback`).
    // rust: let mut default_push: Option<([f64; 2], HurtSource<'_>)> = None;
    // rust: if let Some(player) = self.player.as_mut()
    // rust: && let Some(id) = self.health_resources.damage.id(damage_type)
    // rust: && let Ok(o) = player.hurt_caused_by(
    // rust: &self.health_resources,
    // rust: self.world.health_rules,
    // rust: id,
    // rust: amount,
    // rust: blocking,
    // rust: living_cause,
    // rust: causing,
    // rust: )
    // rust: && {
    // rust: outcome = o;
    // rust: o.hurt
}
    // rust: {
            // LivingEntity.hurtServer's dealDefaultKnockback: not inside the
            // hurt cooldown (a stronger hit there only adds its difference).
    // rust: if o.knockback {
                // No source position: a random direction.
    // rust: let (xd, zd) = from.map_or((0.0, 0.0), |from| {
    // rust: (from[0] - player.position.x, from[2] - player.position.z)
    // rust: });
                // dealDefaultKnockback's `indicateDamage`, unless blocked.
    // rust: if o.blocked <= 0.0 {
    // rust: player.health.indicate_damage(xd, zd, player.yaw);
}
    // rust: let source = HurtSource {
    // rust: damage_type,
    // rust: causing,
    // rust: direct: 0,
}
    // rust: default_push = Some(([xd, zd], source));
}
            // The thorns hurt the entity that caused the hit, if there is one.
    // rust: let killed = self.player.as_ref().is_some_and(|p| {
    // rust: super::wither::killed(true, p.health.dead_or_dying(), p.health.totem_used)
    // rust: });
    // rust: if let Some(a) = attacker.or(owner)
    // rust: && !(post_attack_if_alive && killed)
    // rust: {
    // rust: self.thorns(a);
}
}
        // LivingEntity.hurtServer: ENTITY_HURT_PLAYER, unless it returned
        // early (invulnerable, or inside the hurt cooldown).
        // A hit a native mod canceled records no damage (hurtServer never ran).
    // rust: self.combat.forget_noted(outcome.canceled);
    // rust: if outcome.hurt || outcome.sound {
    // rust: let source = attacker
    // rust: .or(owner)
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id))
    // rust: .map(|m| self.mob_entity(m));
    // rust: self.trigger_entity_hurt_player(&horizon_client::advancements::DamageView {
    // rust: kind: damage_type.to_owned(),
                // Arrows and the like name no direct entity here; a
                // rocket's burst names the rocket.
    // rust: direct: if rocket {
    // rust: Some(horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:firework_rocket".to_owned(),
    // rust: position: from.unwrap_or_default(),
    // rust: ..Default::default()
    // rust: })
    // rust: } else {
    // rust: source.clone().filter(|_| !projectile)
    // rust: },
    // rust: is_direct: !projectile,
    // rust: source,
    // rust: original: amount,
    // rust: actual: amount - outcome.blocked,
    // rust: blocked: outcome.blocked > 0.0,
    // rust: });
}
    // rust: if raised {
    // rust: let source = HurtSource {
    // rust: damage_type,
    // rust: causing,
    // rust: direct: 0,
}
    // rust: self.after_block(outcome, (attacker, projectile), source);
}
        // `LivingEntity.dealDefaultKnockback`: after the item's block push, so
        // a half-blocked hit pushes the defender back the way vanilla does.
    // rust: if let Some(([xd, zd], source)) = default_push {
    // rust: self.knock_back_player(f64::from(0.4_f32), xd, zd, source);
    // rust: if let Some(p) = self.player.as_mut()
    // rust: && let Some(r) = p.hurt_log.last_mut()
    // rust: {
    // rust: r.knockback = Some([p.velocity.x, p.velocity.y, p.velocity.z]);
}
}
    // rust: outcome.hurt
}
    // `LivingEntity.knockback` on the player: pushed `power` away from the
    // direction (`xd`, `zd`), less its knockback resistance, and up only from
    // the ground.
    // The native knockback hook runs before resistance is applied, with
    // `source`, the hit's.
    // rust: pub(super) fn knock_back_player(
    // rust: &mut self,
    // rust: power: f64,
    // rust: xd: f64,
    // rust: zd: f64,
    // rust: source: HurtSource<'_>,
    // rust: ) {
    // rust: let credit = match self.player_hurt_by() {
    // rust: Some((Who::Mob(id), _)) => id as i32,
    // rust: _ => 0,
}
    // rust: let _attacker = self.knockback_scope(match horizon_client::health::knockback_attacker() {
    // rust: 0 => credit,
    // rust: attacker => attacker,
    // rust: });
    // rust: let legacy = self.legacy_rules();
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: knock_back(p, &mut self.world.random, power, (xd, zd), source, legacy);
}
}
    // A status effect from a mob, arrow or splash potion (`addEffect`).
    // rust: pub(super) fn give_player_effect(&mut self, effect: &'static str, ticks: i32, amplifier: i32) {
    // rust: self.give_mob_effect(effect, ticks, amplifier, false);
}
    // A mob's effect on the player. Creative and spectator players shrug off
    // the damaging effects here, but the nautilus's ambient Breath is plain
    // `addEffect` and lands in every game mode.
give_mob_effect :: proc(self: ^Self, effect: ^'static str, ticks: i32, amplifier: i32, ambient: bool) {
}
    // rust: let immune = self.creative || self.spectator();
    // rust: if let Some(instance) = mob_effect_instance(effect, ticks, amplifier, ambient, immune) {
    // rust: self.potions.effects.add(instance);
}
}
    // `WitherRoseBlock.entityInside` for the player: on a server level that
    // isn't peaceful, `getBeeInteractionEffect` (Wither, 40 ticks) unless the
    // player is invulnerable to wither damage (creative, spectator). A
    // server's player gets it from the server.
    // rust: pub(super) fn wither_rose_contact(&mut self) {
    // rust: if self.remote.is_some() || self.ui.difficulty == 0 {
    // rust: return;
}
    // rust: self.give_player_effect("minecraft:wither", 40, 0);
}
    // rust: pub(super) fn hurt_player_by(&mut self, damage_type: &str, amount: f32) {
    // rust: let mut canceled = false;
    // rust: if !self.creative
    // rust: && let Some(player) = self.player.as_mut()
    // rust: && let Some(id) = self.health_resources.damage.id(damage_type)
    // rust: && let Ok(o) = player.hurt_blocking(
    // rust: &self.health_resources,
    // rust: self.world.health_rules,
    // rust: id,
    // rust: amount,
    // rust: None,
    // rust: )
    // rust: {
    // rust: canceled = o.canceled;
}
    // rust: self.combat.forget_noted(canceled);
}
    // `Player.aiStep` touching arrows in its box grown by (1, 0.5, 1):
    // `AbstractArrow.playerTouch`, then `Player.take`'s pickup sound at the
    // arrow (`ClientPacketListener.handleTakeItemEntity`).
    // rust: pub(super) fn touch_arrows(&mut self) {
//         use horizon_client::arrows::Touch;
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if p.health.dead_or_dying() || self.spectator() {
    // rust: return;
}
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let reach = Aabb::new(
    // rust: Vec3::new(p.position.x - w, p.position.y, p.position.z - w),
    // rust: Vec3::new(
    // rust: p.position.x + w,
    // rust: p.position.y + f64::from(p.dimensions.height),
    // rust: p.position.z + w,
    // rust: ),
    // rust: )
    // rust: .inflate(Vec3::new(1.0, 0.5, 1.0));
        // Player.hasInfiniteMaterials.
    // rust: let creative = self.creative;
    // rust: let mut projectiles = std::mem::take(&mut self.creatures.projectiles);
    // rust: let mut picked = Vec::new();
    // rust: projectiles.retain(|shot| {
    // rust: let Some(a) = shot.arrow.as_ref().filter(|a| !a.removed) else {
    // rust: return true;
}
    // rust: let at = shot.position;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(at.x - 0.25, at.y, at.z - 0.25),
    // rust: Vec3::new(at.x + 0.25, at.y + 0.5, at.z + 0.25),
    // rust: );
    // rust: if !bounds.intersects(reach) {
    // rust: return true;
}
    // rust: let taken = match a.player_touch(creative) {
    // rust: Touch::Ignore => false,
    // rust: Touch::Take => true,
                // Inventory.add: a creative player takes what does not fit.
    // rust: Touch::Give(stack) => self.give(stack).is_none() || creative,
}
    // rust: if taken {
    // rust: let r = &mut self.world.random;
    // rust: let pitch = (r.next_float() - r.next_float()) * 1.4 + 2.0;
    // rust: self.audio.play(
    // rust: "minecraft:entity.item.pickup",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 0.2,
    // rust: pitch,
    // rust: );
    // rust: picked.push(shot.clone());
}
    // rust: !taken
    // rust: });
    // rust: self.creatures.projectiles = projectiles;
    // rust: for shot in picked {
    // rust: self.add_pickup(
    // rust: super::pickups::Taken::Arrow(Box::new(shot)),
    // rust: super::pickups::Collector::Player,
    // rust: );
}
}

tick_projectiles :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.creatures.projectiles.is_empty() {
    // rust: self.flush_lan_explosions();
    // rust: return self.flush_wind_bursts();
}
    // rust: let mut projectiles = std::mem::take(&mut self.creatures.projectiles);
    // rust: let mut hits = Vec::new();
    // rust: let mut deflections: Vec<u32> = Vec::new();
    // rust: let mut arrow_events = Vec::new();
    // rust: let mut shoot_events = Vec::new();
    // rust: let mut trails = Vec::new();
    // rust: let mut bubble_tops = Vec::new();
    // rust: let mut snow_contacts = Vec::new();
    // rust: let mut keep_flags = vec![true; projectiles.len()];
        // The impacts the mods may cancel (`native_projectile_impact`), on a server.
    // rust: let hear = self.native_hears_impacts();
    // rust: let mut impacts: Vec<Impact> = Vec::new();
    // rust: {
    // rust: let targets = self.projectile_targets();
    // rust: let breezes: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive() && m.species() == Species::Breeze)
    // rust: .map(|m| m.id)
    // rust: .collect();
            // Drawn only when a breeze could deflect a projectile: an empty
            // level must not move the level random every tick.
    // rust: let jitter = if breezes.is_empty() {
    // rust: 0.0
    // rust: } else {
    // rust: self.world.random.next_float()
}
    // rust: let w = self.mob_world_base(&[]);
    // rust: let rain = self.arrow_rain();
    // rust: let scene = self.arrow_scene(&rain);
            // Mobs' projectiles also hit the guests (game/lan_mobs.rs).
    // rust: let guests = self.lan_projectile_targets();
    // rust: let has_guests = !guests.is_empty();
    // rust: let targets_guests = if has_guests {
    // rust: let mut targets_guests = targets.clone();
    // rust: targets_guests.extend(guests);
    // rust: targets_guests
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let border = Some(self.border.bounds());
    // rust: let pw = ProjWorld {
    // rust: w: &w,
    // rust: targets,
    // rust: border,
}
    // rust: let pw_guests = ProjWorld {
    // rust: w: &w,
    // rust: targets: targets_guests,
    // rust: border,
}
            // Every guest, not only the ones a projectile can hit: a dead or
            // spectating guest's pearl or arrow still resolves to them.
    // rust: let guest_entities = self.lan_guest_entities();
            // ThrownEnderpearl.tick: a dead player's pearl is discarded in
            // place of its tick while ender_pearls_vanish_on_death is on.
    // rust: let vanish = self.ui.rules.bool("ender_pearls_vanish_on_death");
    // rust: let host_dead = self.player_view().is_some_and(|p| !p.alive);
    // rust: let dead_guests: Vec<u32> = self.lan.as_ref().map_or_else(Vec::new, |h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.dead)
    // rust: .map(|g| g.conn)
    // rust: .collect()
    // rust: });
    // rust: for i in 0..projectiles.len() {
                // A wind charge is pickable, so a pearl, an arrow or a trident can
                // strike it (`Projectile.isPickable`, `Projectile.onHit`).
    // rust: let winds = if matches!(projectiles[i].kind, ProjectileKind::EnderPearl)
    // rust: || projectiles[i].arrow.is_some()
    // rust: {
    // rust: wind_charge_hitboxes(&projectiles, &keep_flags, i)
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let p = &mut projectiles[i];
    // rust: if vanish
    // rust: && matches!(p.kind, ProjectileKind::EnderPearl)
    // rust: && p.owner == Some(Who::Player)
    // rust: && p.guest.map_or(host_dead, |c| dead_guests.contains(&c))
    // rust: {
    // rust: keep_flags[i] = false;
    // rust: continue;
}
                // The projectile as it was, to fly on if a mod cancels its impact.
    // rust: let before = (hear && !p.stuck).then(|| p.clone());
    // rust: let mob_shot = !matches!(p.owner, Some(Who::Player));
                // A player's arrows, snowballs and eggs meet every player; a
                // guest's flies from that guest (Projectile.getOwner), not
                // from the host, until it has left them.
    // rust: let pvp = !mob_shot && super::lan_pvp::meets_players(&p.kind);
    // rust: let shooter = p
    // rust: .guest
    // rust: .filter(|_| pvp)
    // rust: .and_then(|c| guest_entities.iter().find(|(g, _)| *g == c))
    // rust: .map(|&(_, id)| Who::Mob(id));
    // rust: if shooter.is_some() {
    // rust: p.owner = shooter;
}
    // rust: let use_guests = (mob_shot || pvp) && has_guests;
    // rust: let (keep, hit) = match (p.arrow.is_some(), use_guests, winds.is_empty()) {
    // rust: (true, false, true) => horizon_client::arrows::tick(p, &scene, &pw.targets),
    // rust: (true, true, true) => {
    // rust: horizon_client::arrows::tick(p, &scene, &pw_guests.targets)
}
    // rust: (true, with_guests, false) => {
    // rust: let mut targets = if with_guests {
    // rust: pw_guests.targets.clone()
    // rust: } else {
    // rust: pw.targets.clone()
}
    // rust: targets.extend(winds);
    // rust: horizon_client::arrows::tick(p, &scene, &targets)
}
    // rust: (false, false, true) => p.tick(&pw),
    // rust: (false, true, true) => p.tick(&pw_guests),
    // rust: (false, pvp_shot, false) => {
    // rust: let mut targets = if pvp_shot {
    // rust: pw_guests.targets.clone()
    // rust: } else {
    // rust: pw.targets.clone()
}
    // rust: targets.extend(winds);
    // rust: p.tick(&ProjWorld {
    // rust: w: if pvp_shot { pw_guests.w } else { pw.w },
    // rust: targets,
    // rust: border,
    // rust: })
}
}
    // rust: if (p.is_thrown() && !matches!(p.kind, ProjectileKind::LlamaSpit))
    // rust: || p.is_arrow() && p.arrow.as_ref().is_none_or(|a| !a.no_physics)
    // rust: {
    // rust: for block in horizon_client::powder_snow::contacts(
    // rust: p.previous,
    // rust: p.position,
    // rust: p.bounds(),
    // rust: false,
    // rust: |at| w.block_name(at.x, at.y, at.z) == "minecraft:powder_snow",
    // rust: ) {
    // rust: snow_contacts.push((block, p.position, p.velocity));
}
}
    // rust: if shooter.is_some() {
    // rust: p.owner = Some(Who::Player);
}
    // rust: if let Some(at) = p.take_shoot_event() {
    // rust: shoot_events.push((p.owner, p.guest, [at.x, at.y, at.z]));
}
                // AbstractHurtingProjectile.tick ends with createParticleTrail.
    // rust: if super::remote_projectiles::has_smoke_trail(&p.kind) {
    // rust: trails.push(p.position);
}
                // ThrownEnderpearl.onAboveBubbleColumn / onInsideBubbleColumn.
    // rust: if keep && hit == Hit::None && matches!(p.kind, ProjectileKind::EnderPearl) {
    // rust: let (at, h) = (p.position, 0.125);
    // rust: horizon_client::motion::bubble_column_push_over(
    // rust: w.world,
    // rust: w.registry,
    // rust: w.facts,
    // rust: w.collision,
    // rust: Aabb::new(
    // rust: Vec3::new(at.x - h, at.y, at.z - h),
    // rust: Vec3::new(at.x + h, at.y + 2.0 * h, at.z + h),
    // rust: ),
    // rust: &mut p.velocity,
    // rust: |pos| bubble_tops.push(pos),
    // rust: );
}
    // rust: let events_from = arrow_events.len();
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: arrow_events.extend(a.events.drain(..).map(|e| (p.position, e)));
}
    // rust: let wind = matches!(
    // rust: p.kind,
    // rust: ProjectileKind::WindCharge | ProjectileKind::BreezeWindCharge
    // rust: );
                // Entity.deflection: a breeze turns every projectile but wind charges away.
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && !wind
    // rust: && breezes.contains(&id)
    // rust: {
    // rust: super::wind::reverse(p, jitter);
    // rust: if p.arrow.is_some() {
    // rust: horizon_client::arrows::finish_entity_hit(p, &scene, EntityHit::Deflected);
    // rust: let a = p.arrow.as_mut().expect("an arrow");
    // rust: arrow_events.extend(a.events.drain(..).map(|e| (p.position, e)));
}
    // rust: deflections.push(id);
    // rust: continue;
}
                // AbstractWindCharge.tick: out of the world's top it bursts.
    // rust: if wind && keep && p.position.y > 350.0 {
    // rust: hits.push((
    // rust: p.clone(),
    // rust: Hit::Block {
    // rust: pos: [0; 3],
    // rust: at: p.position,
    // rust: face: [0; 3],
    // rust: },
    // rust: ));
    // rust: keep_flags[i] = false;
    // rust: continue;
}
    // rust: if hit != Hit::None {
    // rust: if let Some(before) = before {
    // rust: impacts.push(Impact {
    // rust: index: i,
    // rust: before,
    // rust: hit,
    // rust: hit_slot: hits.len(),
    // rust: events: events_from..arrow_events.len(),
    // rust: });
}
    // rust: hits.push((p.clone(), hit));
}
    // rust: keep_flags[i] = keep;
                // Projectile.onHit: the wind charge it hit turns before its own tick.
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && let Some(j) = wind_charge_hit(id)
    // rust: {
    // rust: let (owner, owner_uuid, guest) = (p.owner, p.owner_uuid, p.guest);
    // rust: let look = self.owner_look(owner, guest);
    // rust: let wind = &mut projectiles[j];
    // rust: super::deflect::aim_deflect(wind, look, owner, owner_uuid, guest);
}
}
}
    // rust: for (block, position, movement) in snow_contacts {
    // rust: self.powder_snow_particle(block, position, movement);
}
    // rust: let listed = keep_flags.clone();
    // rust: let mut idx = 0;
    // rust: projectiles.retain(|_| {
    // rust: let k = keep_flags[idx];
    // rust: idx += 1;
    // rust: k
    // rust: });
    // rust: if !impacts.is_empty() {
    // rust: self.native_settle_impacts(
    // rust: &mut projectiles,
    // rust: &listed,
    // rust: impacts,
    // rust: &mut hits,
    // rust: &mut arrow_events,
    // rust: );
}
    // rust: for (owner, guest, at) in shoot_events {
    // rust: if let Some(conn) = guest.filter(|conn| self.lan_acting != Some(*conn)) {
    // rust: let dispatched = if let Some(mut host) = self.lan.take() {
    // rust: let result = self.as_guest(&mut host, conn, |g| {
    // rust: g.projectile_event("minecraft:projectile_shoot", owner, at);
    // rust: });
    // rust: self.lan = Some(host);
    // rust: result.is_some()
    // rust: } else {
    // rust: false
}
                // An owner who left cannot resolve to the host. The event
                // still occurs, with no resolved owner (Projectile.getOwner).
    // rust: if !dispatched {
    // rust: self.projectile_event("minecraft:projectile_shoot", None, at);
}
    // rust: } else {
    // rust: self.projectile_event("minecraft:projectile_shoot", owner, at);
}
}
    // rust: self.smoke_trails(trails);
    // rust: for pos in bubble_tops {
    // rust: self.bubble_column_particles(pos);
}
    // rust: for id in deflections {
    // rust: if let Some(index) = self.mobs.iter().position(|m| m.id == id) {
    // rust: self.play_mob_bound_sound(
    // rust: index,
    // rust: "minecraft:entity.breeze.deflect",
    // rust: 5,
    // rust: 1.0,
    // rust: 1.0,
    // rust: false,
    // rust: );
}
}
    // rust: for (at, event) in arrow_events {
    // rust: self.arrow_event(at, event);
}
    // rust: self.creatures.projectiles.append(&mut projectiles);
    // rust: for (p, hit) in hits {
            // A player's arrow on another player lands as the victim's hurt.
    // rust: if let Some(victim) = self.projectile_pvp_victim(&p, hit) {
    // rust: self.projectile_hits_player(&p, hit, victim)?;
    // rust: continue;
}
            // A guest's projectile lands as theirs: a pearl takes them, what
            // it hurts answers to them. One hitting the host (`Who::Player`
            // here) stays the host's hit.
    // rust: match p.guest {
    // rust: Some(conn)
    // rust: if !matches!(
    // rust: hit,
    // rust: Hit::Entity {
    // rust: who: Who::Player,
    // rust: ..
}
    // rust: ) =>
    // rust: {
    // rust: self.guest_projectile_hit(conn, &p, hit)?;
}
    // rust: _ => self.projectile_hit(&p, hit)?,
}
}
    // rust: self.flush_lan_explosions();
    // rust: self.flush_wind_bursts()
}
    // `LivingEntity.hurtServer`'s `setLastHurtByPlayer` for a projectile a
    // player owns (a fireball they turned back): the kill is theirs, so a
    // guest's (the host on its server thread too) reaches their statistics
    // and `player_killed_entity`, as the arrow's hit does.
player_hurt_mob :: proc(self: ^Self, p: ^Projectile, id: u32) {
}
    // rust: if p.owner == Some(Who::Player) {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
}
}
    // `LivingEntity.hurtServer` for a snowball, egg or pearl (`kind`) that hurt the mob `id`,
    // 0 damage included: the hit is its owner's, and a player's fires PLAYER_HURT_ENTITY.
thrown_hurt_mob :: proc(self: ^Self, p: ^Projectile, id: u32, kind: string, amount: f32) {
}
    // rust: self.player_hurt_mob(p, id);
    // rust: if p.owner == Some(Who::Player)
    // rust: && let Some(m) = self.mobs.iter().find(|m| m.id == id)
    // rust: {
    // rust: let victim = self.mob_entity(m);
    // rust: let direct = horizon_client::advancements::EntityView {
    // rust: kind: kind.into(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: ..Default::default()
}
    // rust: self.player_hit(&victim, "minecraft:thrown", Some(direct), amount);
}
}
    // `projectile_hit` for a projectile the guest `conn` shot, run as them;
    // as the host's when they have left.
guest_projectile_hit :: proc(self: ^Self, conn: u32, p: ^Projectile, hit: Hit) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return self.projectile_hit(p, hit);
}
    // rust: let result = self.as_guest(&mut host, conn, |g| g.projectile_hit(p, hit));
        // The mob hit now answers to the guest (LivingEntity.lastHurtByPlayer).
    // rust: if result.is_some()
    // rust: && let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && self.mobs.iter().any(|m| m.id == id)
    // rust: {
    // rust: host.mob_players.insert(id, conn);
}
    // rust: self.lan = Some(host);
    // rust: match result {
    // rust: Some(r) => r,
    // rust: None => self.projectile_hit(p, hit),
}
}
    // What an arrow or a thrown trident hits an entity of type `victim`
    // for (`AbstractArrow.onHitEntity`, `ThrownTrident.onHitEntity`): a
    // trident's 8 through `EnchantmentHelper.modifyDamage` of the trident
    // (Impaling's `minecraft:damage` on `#sensitive_to_impaling`).
shot_damage :: proc(self: ^Self, shot: ^Projectile, victim: Maybe(string)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if !matches!(shot.kind, ProjectileKind::Trident) {
    // rust: return arrow_damage(shot, &mut self.world.random) + shot.bonus.damage;
}
    // rust: let Some(trident) = shot.arrow.as_ref().map(|a| a.pickup_item.clone()) else {
    // rust: return 8.0;
}
    // rust: let ctx = horizon_client::enchant::EffectContext {
    // rust: this: victim,
    // rust: attacker: (shot.owner == Some(Who::Player)).then_some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:trident"),
    // rust: damage_type: Some("minecraft:trident"),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: world_stations!(self).enchantments.modify_value(
    // rust: Some(&trident),
    // rust: "minecraft:damage",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: 8.0,
    // rust: )
}
    // A projectile's hurt of `amount` on the boat or minecart `id`
    // (`VehicleEntity.hurtServer`): even 0 shakes it (`Snowball`, `ThrownEgg`,
    // `ThrownEnderpearl` `.onHitEntity`), 5 from a small fireball destroys it.
hurt_vehicle :: proc(self: ^Self, p: ^Projectile, id: u32, amount: f32) {
}
    // rust: let creative = p.owner == Some(Who::Player) && self.creative;
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: self.hurt_boat(i, amount, creative);
    // rust: } else if let Some(i) = self.carts.iter().position(|c| c.id == id) {
    // rust: self.hurt_cart(i, amount, creative, false);
}
}
    // `BellBlock.onProjectileHit`: a projectile that strikes the bell proper
    // rings it, and a player's shot counts as the player's ring.
bell_projectile_hit :: proc(self: ^Self, p: ^Projectile, pos: [i32; 3], at: Vec3, face: [i32; 3]) {
}
    // rust: let Some(face) = Direction::ALL.into_iter().find(|d| d.normal() == face) else {
    // rust: return;
}
    // rust: let block = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let rang = self
    // rust: .with_level(|b, level, ticks| b.bell_projectile_hit(level, ticks, block, face, at.y));
    // rust: if rang {
    // rust: let _ = self.process_level_events();
    // rust: if p.owner == Some(Who::Player) {
    // rust: self.award_custom_stat("bell_ring", 1);
}
}
}
    // `AmethystBlock.onProjectileHit`: a projectile that strikes an amethyst
    // block rings `block.amethyst_block.chime` there, pitched by the level random.
amethyst_projectile_hit :: proc(self: ^Self, pos: [i32; 3]) {
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if &*self.res.facts().get(state).name != "minecraft:amethyst_block" {
    // rust: return;
}
    // rust: let pitch = 0.5 + self.world.random.next_float() * 1.2;
    // rust: self.level_events
    // rust: .push(horizon_world::level::LevelEvent::Sound {
    // rust: pos: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: sound: "minecraft:block.amethyst_block.chime".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
    // rust: let _ = self.process_level_events();
}
    // `onProjectileHit` of chorus flowers, decorated pots and speleothems
    // (pointed dripstone, sulfur spikes): an impact projectile
    // (`#impact_projectiles`) breaks the block when `Projectile.mayInteract`
    // and `Projectile.mayBreak` allow it, which takes the
    // `projectiles_can_break_blocks` rule and a shooter that may break blocks
    // (`canBreakBlockInAdventureMode`: never a mob, never an
    // adventure player). A pot is cracked first (flags 260), so it shatters.
projectile_breaks_block :: proc(self: ^Self, p: ^Projectile, pos: [i32; 3]) {
}
//         use horizon_client::command::args::GameMode;
    // rust: let impact = matches!(
    // rust: p.kind,
    // rust: ProjectileKind::Arrow { .. }
    // rust: | ProjectileKind::Trident
    // rust: | ProjectileKind::Snowball
    // rust: | ProjectileKind::Thrown(_)
    // rust: | ProjectileKind::Egg
    // rust: | ProjectileKind::SmallFireball
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WitherSkull { .. }
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: );
    // rust: let shooter_may_break = match p.owner {
    // rust: Some(Who::Player) => self.mode != GameMode::Adventure,
    // rust: Some(Who::Mob(_)) => false,
    // rust: None => true,
}
    // rust: if !impact || !shooter_may_break || !self.ui.rules.bool("projectiles_can_break_blocks") {
    // rust: return;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: match &*self.res.facts().get(state).name {
    // rust: "minecraft:chorus_flower" => {}
            // SpeleothemBlock.onProjectileHit (pointed dripstone and sulfur spikes): a
            // thrown trident faster than 0.6 breaks it.
    // rust: "minecraft:pointed_dripstone" | "minecraft:sulfur_spike"
    // rust: if matches!(p.kind, ProjectileKind::Trident)
    // rust: && p.arrow.as_ref().is_some_and(|a| a.hit_speed > 0.6) => {}
    // rust: "minecraft:decorated_pot" => {
    // rust: let registry = &self.pack.assets.registry;
    // rust: let Some(mut pot) = registry.state(state).cloned() else {
    // rust: return;
}
    // rust: pot.properties.insert("cracked".into(), "true".into());
    // rust: let Ok(cracked) = registry.resolve(&pot) else {
    // rust: return;
}
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, cracked, 260));
}
    // rust: _ => return,
}
    // rust: let _ = self.destroy_block_dropping(pos);
}
    // What an arrow's tick asked for: its particles and sounds.
    // rust: pub(super) fn arrow_event(&mut self, at: Vec3, event: horizon_client::arrows::ArrowEvent) {
//         use horizon_client::arrows::{ArrowEvent, ArrowParticle, ArrowSound, BlockReaction};
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let kind = |k| match k {
    // rust: ArrowParticle::Bubble => ParticleType::Bubble,
    // rust: ArrowParticle::Crit => ParticleType::Crit,
    // rust: ArrowParticle::Splash => ParticleType::Splash,
}
    // rust: match event {
    // rust: ArrowEvent::Particle {
    // rust: kind: k,
    // rust: position,
    // rust: velocity,
    // rust: } => self.particles.add(
    // rust: &ParticleOptions::simple(kind(k)),
    // rust: [position.x, position.y, position.z],
    // rust: [velocity.x, velocity.y, velocity.z],
    // rust: ),
            // Arrow.tick: `broadcastEntityEvent(this, 0)`. The window and the
            // guests burst the particles themselves (`remote_arrow_puff`).
    // rust: ArrowEvent::PotionPuff { id, .. } => {
    // rust: self.lan_entity_event(id as i32, 0, [at.x, at.y, at.z]);
}
    // rust: ArrowEvent::Sound {
    // rust: sound,
    // rust: volume,
    // rust: pitch,
    // rust: } => {
    // rust: let name = match sound {
    // rust: ArrowSound::Splash => "minecraft:entity.generic.splash",
    // rust: ArrowSound::HitGround => "minecraft:entity.arrow.hit",
    // rust: ArrowSound::CrossbowHit => "minecraft:item.crossbow.hit",
    // rust: ArrowSound::Extinguish => "minecraft:entity.generic.extinguish_fire",
    // rust: ArrowSound::TridentHitGround => "minecraft:item.trident.hit_ground",
    // rust: ArrowSound::TridentHit => "minecraft:item.trident.hit",
}
    // rust: self.audio
    // rust: .play(name, Some([at.x, at.y, at.z]), volume, pitch);
}
    // rust: ArrowEvent::BubbleColumnParticles { pos } => self.bubble_column_particles(pos),
    // rust: ArrowEvent::Block {
    // rust: pos,
    // rust: reaction,
    // rust: owner,
    // rust: } => match reaction {
    // rust: BlockReaction::PrimeTnt => {
                    // `TntBlock.onProjectileHit`: the arrow's owner lights it.
    // rust: if self.tnt_prime_allowed(pos) {
    // rust: self.spawn_primed_tnt(pos, false, owner, None);
    // rust: self.with_level(|b, level, ticks| b.remove_block(level, ticks, pos, false));
    // rust: let _ = self.process_level_events();
}
}
    // rust: BlockReaction::Light(lit) => {
    // rust: let _ = self.level_set([pos.x, pos.y, pos.z], lit);
}
    // rust: },
    // rust: ArrowEvent::SplashEvent => {
    // rust: self.projectile_event("minecraft:splash", None, [at.x, at.y, at.z]);
}
            // finish_arrow_hit drops the pickup, which it holds.
    // rust: ArrowEvent::ShootEvent | ArrowEvent::Drop => {}
}
}
    // `Level.isRainingAt` for arrows.
    // What a projectile can hit: the mobs, the player, the dragon's parts and
    // the End crystals (under reserved ids, game/dragon.rs).
    // The boats and minecarts a projectile can strike.
    // rust: pub(super) fn vehicle_targets(&self) -> Vec<(Who, Aabb)> {
    // rust: let mut targets: Vec<(Who, Aabb)> = self
    // rust: .boats
    // rust: .iter()
    // rust: .map(|b| (Who::Mob(b.id), b.bounds()))
    // rust: .collect();
    // rust: targets.extend(self.carts.iter().map(|c| (Who::Mob(c.id), c.bounds())));
    // rust: targets
}
    // rust: pub(super) fn projectile_targets(&self) -> Vec<(Who, Aabb)> {
    // rust: let mut targets: Vec<(Who, Aabb)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| (Who::Mob(m.id), m.bounds()))
    // rust: .collect();
    // rust: if let Some(p) = self.player_view()
    // rust: && p.alive
    // rust: {
    // rust: targets.push((Who::Player, p.bounds));
}
    // rust: targets.extend(
    // rust: self.special_targets()
    // rust: .into_iter()
    // rust: .map(|(id, b)| (Who::Mob(id), b)),
    // rust: );
        // Boats and minecarts are pickable for every projectile
        // (`VehicleEntity.isPickable`), so every kind shares this one list.
    // rust: targets.extend(self.vehicle_targets());
    // rust: targets
}
    // rust: pub(super) fn arrow_rain(&self) -> impl Fn(BlockPos) -> bool + '_ {
    // rust: move |p: BlockPos| self.raining_at(p)
}
    // The level as arrows see it.
    // rust: pub(super) fn arrow_scene<'s>(
    // rust: &'s self,
    // rust: rain: &'s dyn Fn(BlockPos) -> bool,
    // rust: ) -> horizon_client::arrows::ArrowScene<'s, 's> {
    // rust: horizon_client::arrows::ArrowScene {
    // rust: world: &self.world,
    // rust: registry: self.pack.assets.registry,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: fluids: &self.motion.fluids,
    // rust: raining: rain,
    // rust: mob_griefing: self.ui.rules.bool("mob_griefing"),
    // rust: tnt_explodes: self.ui.rules.bool("tnt_explodes"),
}
}
    // The rest of the tick of an arrow that hit an entity
    // (`arrows::finish_entity_hit`): its sounds and drop, and back among the
    // projectiles if it flies on.
finish_arrow_hit :: proc(self: ^Self, mut arrow: Projectile, outcome: EntityHit) {
}
    // rust: let keep = {
    // rust: let rain = self.arrow_rain();
    // rust: horizon_client::arrows::finish_entity_hit(&mut arrow, &self.arrow_scene(&rain), outcome)
}
    // rust: let Some(a) = arrow.arrow.as_mut() else {
    // rust: return;
}
    // rust: let (events, item) = (std::mem::take(&mut a.events), a.pickup_item.clone());
    // rust: for event in events {
    // rust: if event == horizon_client::arrows::ArrowEvent::Drop {
    // rust: self.spawn_at_location(arrow.position, f64::from(0.1f32), item.clone());
    // rust: } else {
    // rust: self.arrow_event(arrow.position, event);
}
}
    // rust: if keep {
    // rust: self.add_projectile(arrow);
}
}
    // `TargetBlock.onProjectileHit`: a target block takes its power from
    // where the projectile landed and resets after 20 ticks for an arrow, 8
    // for any other projectile. A player's shot counts as a target hit.
target_block_hit :: proc(self: ^Self, p: ^Projectile, pos: [i32; 3], at: Vec3, face: [i32; 3]) {
}
    // rust: let block = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let arrow = p.arrow.is_some();
    // rust: let location = [at.x, at.y, at.z];
    // rust: let hit = self.with_level(|b, level, ticks| {
    // rust: b.target_projectile_hit(level, ticks, block, location, face, arrow)
    // rust: });
    // rust: if let Some(strength) = hit {
    // rust: let _ = self.process_level_events();
    // rust: self.native_target_hit(self.dim.id(), pos, strength);
    // rust: if p.owner == Some(Who::Player) && (p.guest.is_none() || p.guest == self.lan_acting) {
    // rust: self.award_custom_stat("target_hit", 1);
    // rust: let kind = if p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .is_some_and(|a| &*a.pickup_item.item == "minecraft:spectral_arrow")
    // rust: {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: p.kind.id()
}
    // rust: let projectile = horizon_client::advancements::EntityView {
    // rust: kind: kind.to_owned(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: ..Default::default()
}
    // rust: self.trigger_target_hit(&projectile, strength);
}
}
}
    // rust: pub(super) fn projectile_hit(&mut self, p: &Projectile, hit: Hit) -> Result<()> {
    // rust: let _attacker = self.knockback_scope_for(p.owner);
        // Projectile.onHitBlock: BlockState.onProjectileHit, for every
        // projectile (a wind charge out of the world's top has no face).
    // rust: if let Hit::Block { pos, at, face } = hit
    // rust: && face != [0; 3]
    // rust: {
    // rust: self.bell_projectile_hit(p, pos, at, face);
    // rust: self.amethyst_projectile_hit(pos);
    // rust: if self.with_level(|b, level, ticks| {
    // rust: b.big_dripleaf_projectile_hit(level, ticks, BlockPos::new(pos[0], pos[1], pos[2]))
    // rust: }) {
    // rust: self.process_level_events()?;
}
    // rust: self.projectile_breaks_block(p, pos);
}
    // rust: self.combat.projectile_owner = match p.owner {
    // rust: Some(Who::Mob(id)) => Some(id),
    // rust: _ => None,
}
    // rust: self.combat.projectile_direct = match hit {
    // rust: Hit::Entity {
    // rust: who: Who::Player, ..
    // rust: } => {
    // rust: let spectral = p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .is_some_and(|a| &*a.pickup_item.item == "minecraft:spectral_arrow");
    // rust: let id = if spectral {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: p.kind.id()
}
    // rust: Some(Text::translate(
    // rust: &format!("entity.{}", id.replace(':', ".")),
    // rust: &[],
    // rust: ))
}
    // rust: _ => None,
}
    // rust: let at = match hit {
    // rust: Hit::Entity { at, .. } | Hit::Block { at, .. } => at,
    // rust: Hit::None => return Ok(()),
}
        // Projectile.onHitBlock: BlockState.onProjectileHit, for every
        // projectile (a wind charge out of the world's top has no face).
    // rust: if let Hit::Block { pos, face, .. } = hit
    // rust: && face != [0; 3]
    // rust: {
    // rust: self.target_block_hit(p, pos, at, face);
}
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id),
    // rust: at,
    // rust: } = hit
    // rust: && self.lan_projectile_hit(p, id, at)
    // rust: {
    // rust: return Ok(());
}
    // rust: if matches!(
    // rust: p.kind,
    // rust: ProjectileKind::WindCharge | ProjectileKind::BreezeWindCharge
    // rust: ) {
    // rust: return self.wind_charge_hit(p, hit);
}
        // A wither skull's hit on a part or crystal goes through
        // `wither_skull_hit` below, as on any entity, and then explodes.
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && id >= super::dragon::SPECIAL
    // rust: && !matches!(p.kind, ProjectileKind::WitherSkull { .. })
    // rust: {
    // rust: let by_player = p.owner == Some(Who::Player);
    // rust: if p.arrow.is_some() {
                // AbstractArrow.onHitEntity: spent if the part or crystal took
                // it, else turned back (a perched dragon sets it alight first).
    // rust: let mut arrow = p.clone();
    // rust: let amount = self.shot_damage(&mut arrow, None);
    // rust: let outcome = match self.hit_special(
    // rust: id,
    // rust: amount,
    // rust: by_player,
    // rust: horizon_client::mobs::DamageKind::Arrow,
    // rust: Some(&p.kind),
    // rust: ) {
    // rust: super::dragon::Hurt::Landed { .. } => EntityHit::Hurt,
    // rust: super::dragon::Hurt::Refused => EntityHit::Refused,
    // rust: super::dragon::Hurt::Shrugged => {
    // rust: if let Some(a) = arrow.arrow.as_mut() {
    // rust: a.ignite_for_seconds(1.0);
}
    // rust: EntityHit::Refused
}
}
    // rust: self.finish_arrow_hit(arrow, outcome);
    // rust: return Ok(());
}
    // rust: let amount = match p.kind {
    // rust: ProjectileKind::SmallFireball => 5.0,
    // rust: ProjectileKind::LargeFireball { .. } => 6.0,
    // rust: ProjectileKind::Thrown(t) => t.damage,
    // rust: _ => 0.0,
}
    // rust: let kind = match p.kind {
    // rust: ProjectileKind::SmallFireball | ProjectileKind::LargeFireball { .. } => {
    // rust: horizon_client::mobs::DamageKind::Fireball
}
    // rust: _ => horizon_client::mobs::DamageKind::Thrown,
}
    // rust: self.hit_special(id, amount, by_player, kind, Some(&p.kind));
            // ThrowableProjectile.onHit goes on after onHitEntity: a pearl
            // still takes its owner to where it broke (into the crystal's
            // blast), an egg still hatches, a snowball still breaks. A large
            // fireball still explodes (LargeFireball.onHit), whatever the
            // part or crystal made of its hit (both refuse fire), and the
            // blast takes the crystal.
    // rust: if !matches!(
    // rust: p.kind,
    // rust: ProjectileKind::EnderPearl
    // rust: | ProjectileKind::Egg
    // rust: | ProjectileKind::Snowball
    // rust: | ProjectileKind::Thrown(_)
    // rust: | ProjectileKind::LargeFireball { .. }
    // rust: ) {
    // rust: return Ok(());
}
}
    // rust: if p.arrow.is_some()
    // rust: && let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && let Some(i) = self.carts.iter().position(|c| c.id == id)
    // rust: {
            // AbstractArrow.onHitEntity on a minecart.
    // rust: let mut arrow = p.clone();
    // rust: let amount = self.shot_damage(&mut arrow, None);
    // rust: let burning = p.arrow.as_ref().is_some_and(|a| a.on_fire());
    // rust: let creative = p.owner == Some(Who::Player) && self.creative;
    // rust: self.arrow_hits_cart(i, amount, p.velocity, burning, creative);
    // rust: self.finish_arrow_hit(arrow, EntityHit::Hurt);
    // rust: return Ok(());
}
    // rust: if p.arrow.is_some()
    // rust: && let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && let Some(i) = self.boats.iter().position(|b| b.id == id)
    // rust: {
            // AbstractArrow.onHitEntity on a boat: VehicleEntity.hurtServer
            // takes the arrow's damage, and the arrow is spent.
    // rust: let mut arrow = p.clone();
    // rust: let amount = self.shot_damage(&mut arrow, None);
    // rust: let creative = p.owner == Some(Who::Player) && self.creative;
    // rust: self.hurt_boat(i, amount, creative);
    // rust: self.finish_arrow_hit(arrow, EntityHit::Hurt);
    // rust: return Ok(());
}
    // rust: let atp = [at.x, at.y, at.z];
        // Projectile.onHit: the landing is heard.
    // rust: self.projectile_event("minecraft:projectile_land", p.owner, atp);
    // rust: let source_kind = match p.kind {
    // rust: ProjectileKind::Arrow { .. } | ProjectileKind::Trident => DamageKind::Arrow,
    // rust: ProjectileKind::SmallFireball | ProjectileKind::LargeFireball { .. } => {
    // rust: DamageKind::Fireball
}
    // rust: _ => DamageKind::Thrown,
}
    // rust: let attacker_species = match p.owner {
    // rust: Some(Who::Mob(id)) => self.mobs.iter().find(|m| m.id == id).map(|m| m.species()),
    // rust: _ => None,
}
    // rust: let source = Damage {
    // rust: kind: source_kind,
    // rust: attacker: p.owner,
    // rust: from: Some([p.previous.x, p.previous.y, p.previous.z]),
    // rust: attacker_species,
}
    // rust: let aim = self.attacker_aim(source.attacker);
    // rust: match (&p.kind, hit) {
            // ThrownTrident.onHitEntity: 8 damage (Impaling on aquatic mobs),
            // dealt whether or not the hurt lands, then it bounces off.
    // rust: (ProjectileKind::Trident, Hit::Entity { who, .. }) => {
    // rust: let mut trident = p.clone();
    // rust: let victim = match who {
    // rust: Who::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.kind.id.clone()),
    // rust: Who::Player => Some("minecraft:player".to_owned()),
}
    // rust: let amount = self.shot_damage(&mut trident, victim.as_deref());
    // rust: let hurt = match who {
    // rust: Who::Player => self.mob_hits_player(
    // rust: amount,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:trident",
    // rust: ),
    // rust: Who::Mob(id) => self.mobs.iter_mut().find(|m| m.id == id).is_some_and(|m| {
    // rust: m.damage_projectile(amount, source, aim, [p.velocity.x, p.velocity.z])
    // rust: }),
}
    // rust: let outcome = if hurt {
    // rust: EntityHit::Hurt
    // rust: } else {
    // rust: EntityHit::Refused
}
    // rust: self.burning_arrow_primes(p, who);
    // rust: self.finish_arrow_hit(trident, outcome);
}
            // AbstractArrow.onHitBlock plays its sound itself (ArrowEvent).
    // rust: (ProjectileKind::Trident, Hit::Block { .. }) => {}
            // AbstractArrow.onHitEntity on a wind charge: `hurtOrSimulate` fails
            // (the charge turned in `Projectile.onHit`, which already ran), so the
            // arrow takes `deflect(REVERSE, 0.2)` instead of vanishing.
    // rust: (
    // rust: ProjectileKind::Arrow { .. },
    // rust: Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: },
    // rust: ) if wind_charge_hit(id).is_some() => {
    // rust: let mut arrow = p.clone();
    // rust: arrow_damage(&mut arrow, &mut self.world.random);
    // rust: self.finish_arrow_hit(arrow, EntityHit::Refused);
}
    // rust: (ProjectileKind::Arrow { .. }, Hit::Entity { who, .. }) => {
    // rust: let mut arrow = p.clone();
    // rust: let amount = arrow_damage(&mut arrow, &mut self.world.random) + p.bonus.damage;
    // rust: let player_fire = self.player.as_ref().map(|pl| pl.fire_ticks);
                // AbstractArrow.onHitEntity saves the fire, ignites, then puts
                // it back when hurtOrSimulate fails and the target still takes
                // a projectile's side effects.
    // rust: let mob_fire = match who {
    // rust: Who::Mob(id) => self.mobs.iter().find(|m| m.id == id).map(|m| m.fire_ticks),
    // rust: Who::Player => None,
}
    // rust: let mut dodged = false;
                // AbstractArrow.onHitEntity: a burning arrow sets its target alight.
    // rust: if p.arrow.as_ref().is_some_and(|a| a.on_fire()) {
    // rust: self.handle_mob_events(vec![MobEvent::Ignite {
    // rust: target: who,
    // rust: seconds: 5,
    // rust: }])?;
}
    // rust: let hurt = match who {
    // rust: Who::Player => {
    // rust: let hurt = self.mob_hits_player(
    // rust: amount,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:arrow",
    // rust: );
                        // AbstractArrow.onHitEntity: a hit that hurt leaves a
                        // non-piercing arrow stuck in the body.
    // rust: if hurt && p.arrow.as_ref().is_some_and(|a| a.pierce == 0) {
    // rust: self.combat.stuck.add_arrow();
}
    // rust: hurt
}
    // rust: Who::Mob(id) => {
    // rust: let hurt = self.mobs.iter_mut().find(|m| m.id == id).is_some_and(|m| {
    // rust: m.damage_projectile(amount, source, aim, [p.velocity.x, p.velocity.z])
    // rust: });
    // rust: dodged = !hurt
    // rust: && self.mobs.iter().find(|m| m.id == id).is_some_and(|m| {
    // rust: m.species() == Species::Enderman
    // rust: && horizon_client::mobs::enderman::dodges(m, &source)
    // rust: });
    // rust: if p.owner == Some(Who::Player) {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
    // rust: if hurt && let Some(m) = self.mobs.iter().find(|m| m.id == id) {
                                // LivingEntity.hurtServer: PLAYER_HURT_ENTITY.
    // rust: let victim = self.mob_entity(m);
    // rust: let spectral = p.arrow.as_ref().is_some_and(|a| {
    // rust: &*a.pickup_item.item == "minecraft:spectral_arrow"
    // rust: });
    // rust: let direct = horizon_client::advancements::EntityView {
    // rust: kind: if spectral {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: "minecraft:arrow"
}
    // rust: .into(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: ..Default::default()
}
    // rust: self.player_hit(&victim, "minecraft:arrow", Some(direct), amount);
}
                            // AbstractArrow.onHitEntity: KILLED_BY_ARROW for a kill
                            // (piercing arrows are not modelled).
    // rust: if hurt
    // rust: && let Some(m) = self.mobs.iter().find(|m| m.id == id)
    // rust: && !m.alive()
    // rust: {
    // rust: let victim = self.mob_entity(m);
    // rust: let weapon =
    // rust: p.arrow.as_ref().and_then(|a| a.fired_from_weapon.as_ref());
    // rust: self.trigger_killed_by_arrow(&[victim], weapon);
}
}
    // rust: hurt
}
}
    // rust: self.burning_arrow_primes(p, who);
                // doKnockback: Punch pushes along the flight, less the target's
                // knockback resistance.
    // rust: let flight = (p.velocity.x * p.velocity.x + p.velocity.z * p.velocity.z).sqrt();
    // rust: let resistance = match who {
    // rust: Who::Player => self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|pl| pl.attribute("minecraft:knockback_resistance").ok())
    // rust: .unwrap_or(0.0),
    // rust: Who::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or(0.0, |m| m.knockback_resistance()),
}
    // rust: let knockback = if !hurt {
    // rust: 0.0
    // rust: } else if let Some(weapon) =
    // rust: p.arrow.as_ref().and_then(|a| a.fired_from_weapon.as_ref())
    // rust: {
    // rust: let victim = match who {
    // rust: Who::Player => Some("minecraft:player"),
    // rust: Who::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.kind.id.as_str()),
}
    // rust: let owner = match p.owner {
    // rust: Some(Who::Player) => Some("minecraft:player"),
    // rust: Some(Who::Mob(id)) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.kind.id.as_str()),
    // rust: None => None,
}
    // rust: let arrow_type = if p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .is_some_and(|a| &*a.pickup_item.item == "minecraft:spectral_arrow")
    // rust: {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: "minecraft:arrow"
}
    // rust: let ctx = horizon_client::enchant::EffectContext {
    // rust: this: victim,
    // rust: attacker: owner,
    // rust: direct_attacker: Some(arrow_type),
    // rust: damage_type: Some("minecraft:arrow"),
    // rust: items: Some(self.res.items()),
    // rust: ..Default::default()
}
    // rust: self.res.stations().enchantments.modify_value(
    // rust: Some(weapon),
    // rust: "minecraft:knockback",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: 0.0,
    // rust: )
    // rust: } else {
    // rust: p.bonus.punch as f32
}
    // rust: let push = f64::from(knockback) * 0.6 * (1.0 - resistance).max(0.0);
    // rust: if hurt && push > 0.0 && flight > 1e-6 {
    // rust: let k = push / flight;
    // rust: self.handle_mob_events(vec![MobEvent::Push {
    // rust: target: who,
    // rust: velocity: [p.velocity.x * k, 0.1, p.velocity.z * k],
    // rust: }])?;
}
    // rust: if hurt {
    // rust: self.arrow_post_hurt_effects(p, who);
}
    // rust: match (hurt, who) {
    // rust: (true, _) => self.finish_arrow_hit(arrow, EntityHit::Hurt),
                    // What the player took no damage from (a raised shield)
                    // keeps its fire as it was and turns the arrow back.
    // rust: (false, Who::Player) => {
    // rust: if let (Some(pl), Some(ticks)) = (self.player.as_mut(), player_fire) {
    // rust: pl.set_remaining_fire_ticks(ticks);
}
    // rust: self.finish_arrow_hit(arrow, EntityHit::Refused);
}
                    // EnderMan.hurtServer teleported away: the arrow flies on.
    // rust: (false, Who::Mob(_)) if dodged => {
    // rust: self.finish_arrow_hit(arrow, arrow_miss(true));
}
                    // hurtOrSimulate returned false and
                    // projectileReceivesSideEffectsOnHit(false) is the default
                    // (Shulker.hurtServer on a closed shell, invulnerability).
                    // The fire the arrow just set goes back, then
                    // deflect(REVERSE, entity, owner, false, 0.2). The hit
                    // sound plays only when the hurt lands.
    // rust: (false, Who::Mob(id)) => {
    // rust: if let (Some(m), Some(ticks)) =
    // rust: (self.mobs.iter_mut().find(|m| m.id == id), mob_fire)
    // rust: {
    // rust: m.fire_ticks = ticks;
}
    // rust: self.finish_arrow_hit(arrow, arrow_miss(false));
}
}
}
            // AbstractArrow.onHitBlock plays its sound itself (ArrowEvent).
    // rust: (ProjectileKind::Arrow { .. }, Hit::Block { .. }) => {}
    // rust: (ProjectileKind::Snowball, hit) => {
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
                    // Snowball.onHitEntity: 3 damage to blazes, 0 otherwise.
    // rust: let amount = if m.species() == Species::Blaze {
    // rust: 3.0
    // rust: } else {
    // rust: 0.0
}
    // rust: if m.damage_projectile(amount, source, aim, [p.velocity.x, p.velocity.z]) {
    // rust: self.thrown_hurt_mob(p, id, "minecraft:snowball", amount);
}
    // rust: } else if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: {
                    // Snowball.onHitEntity: 0 damage, which still shakes a
                    // boat or minecart (VehicleEntity.hurtServer).
    // rust: self.hurt_vehicle(p, id, 0.0);
}
    // rust: self.thrown_break_event(p.id, atp);
    // rust: self.item_burst(atp, "minecraft:snowball");
}
            // a mod's copy of Snowball: its damage to anything it hits.
    // rust: (ProjectileKind::Thrown(t), hit) => {
    // rust: match hit {
    // rust: Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } => {
    // rust: let push = [p.velocity.x, p.velocity.z];
    // rust: let hurt = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id)
    // rust: .is_some_and(|m| m.damage_projectile(t.damage, source, aim, push));
    // rust: if hurt {
    // rust: self.player_hurt_mob(p, id);
}
                        // LivingEntity.hurtServer: PLAYER_HURT_ENTITY.
    // rust: if hurt
    // rust: && p.owner == Some(Who::Player)
    // rust: && let Some(m) = self.mobs.iter().find(|m| m.id == id)
    // rust: {
    // rust: let victim = self.mob_entity(m);
    // rust: let direct = horizon_client::advancements::EntityView {
    // rust: kind: t.id.into(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: ..Default::default()
}
    // rust: self.player_hit(&victim, "minecraft:thrown", Some(direct), t.damage);
}
}
                    // Player.hurtServer takes no 0 damage.
    // rust: Hit::Entity {
    // rust: who: Who::Player, ..
    // rust: } if t.damage > 0.0 => {
    // rust: let from = [p.previous.x, p.previous.y, p.previous.z];
    // rust: self.mob_hits_player(t.damage, from, "minecraft:thrown");
}
    // rust: _ => {}
}
    // rust: self.thrown_break_event(p.id, atp);
    // rust: self.item_burst(atp, t.item);
}
    // rust: (ProjectileKind::Egg, hit) => {
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: if m.damage_projectile(0.0, source, aim, [p.velocity.x, p.velocity.z]) {
    // rust: self.thrown_hurt_mob(p, id, "minecraft:egg", 0.0);
}
    // rust: } else if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: {
                    // ThrownEgg.onHitEntity: the same 0 damage.
    // rust: self.hurt_vehicle(p, id, 0.0);
}
                // ThrownEgg.onHit: 1/8 chance of a chick, 1/32 of four.
    // rust: if self.world.random.next_int_bound(8).unwrap_or(1) == 0 {
    // rust: let n = if self.world.random.next_int_bound(32).unwrap_or(1) == 0 {
    // rust: 4
    // rust: } else {
    // rust: 1
}
    // rust: for _ in 0..n {
    // rust: if let Some(id) = self.spawn_mob("minecraft:chicken", atp, true)
    // rust: && let Some(c) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: c.extra.age = -24000;
}
}
}
    // rust: self.thrown_break_event(p.id, atp);
    // rust: self.item_burst(atp, "minecraft:egg");
}
    // rust: (ProjectileKind::EnderPearl, hit) => {
    // rust: if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: if m.damage_projectile(0.0, source, aim, [p.velocity.x, p.velocity.z]) {
    // rust: self.thrown_hurt_mob(p, id, "minecraft:ender_pearl", 0.0);
}
    // rust: } else if let Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } = hit
    // rust: {
                    // ThrownEnderpearl.onHitEntity: the same 0 damage.
    // rust: self.hurt_vehicle(p, id, 0.0);
}
                // To where the pearl started its last tick (oldPosition).
    // rust: let mut to = p.previous;
    // rust: let mut damage = 5.0;
    // rust: let mut cancel = false;
                // EntityTeleportEvent.EnderPearl: a server player's pearl.
    // rust: if p.owner == Some(Who::Player)
    // rust: && let Some(from) = self.player.as_ref().map(|pl| pl.position)
    // rust: && let (Some(uuid), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: let mut target = [to.x, to.y, to.z];
    // rust: self.native_ender_pearl_teleport(
    // rust: uuid,
    // rust: &name,
    // rust: p.id,
    // rust: [from.x, from.y, from.z],
    // rust: &mut target,
    // rust: &mut damage,
    // rust: &mut cancel,
    // rust: );
                    // A target that is not a number keeps the pearl's.
    // rust: if target.iter().all(|v| v.is_finite()) {
    // rust: to = Vec3::new(target[0], target[1], target[2]);
}
}
                // ThrownEnderpearl.isAllowedToTeleportOwner: an owner who is
                // dead or asleep cannot take the pearl, so it is discarded
                // where it lands (no teleport and no 5 damage).
    // rust: let taken = self.player.as_ref().is_some_and(|pl| {
    // rust: horizon_client::projectiles::owner_can_take_pearl(
    // rust: !pl.health.dead_or_dying(),
    // rust: self.sleeping.is_some(),
    // rust: )
    // rust: });
    // rust: if p.owner == Some(Who::Player) && taken && !cancel {
                    // ThrownEnderpearl: 5% endermite where the player was
                    // (when monsters spawn), teleport, 5 damage.
    // rust: if self.world.random.next_float() < 0.05
    // rust: && self.ui.rules.bool("spawn_monsters")
    // rust: && self.ui.difficulty != 0
    // rust: && let Some(pl) = self.player.as_ref()
    // rust: {
    // rust: let from = pl.position;
    // rust: self.spawn_mob("minecraft:endermite", [from.x, from.y, from.z], false);
}
                    // ServerPlayer.teleport: removeVehicle before the placement.
    // rust: self.stop_riding();
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.position = to;
    // rust: pl.velocity = Vec3::ZERO;
    // rust: pl.fall_distance = 0.0;
    // rust: pl.teleported = true;
}
    // rust: self.previous_position = to;
    // rust: if damage > 0.0 {
    // rust: self.hurt_player_by("minecraft:ender_pearl", damage);
}
    // rust: self.audio.play(
    // rust: "minecraft:entity.player.teleport",
    // rust: Some([to.x, to.y, to.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
}
    // rust: (ProjectileKind::SmallFireball, hit) => match hit {
    // rust: Hit::Entity { who, .. } => match who {
    // rust: Who::Player => {
    // rust: if !self.creative {
                            // SmallFireball.onHitEntity: remember the fire, ignite,
                            // and restore it when the hurt is refused (a raised shield).
    // rust: let remaining = self.player.as_ref().map(|p| p.fire_ticks);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.ignite_for_ticks(100)?;
}
    // rust: let hurt = self.mob_hits_player(
    // rust: 5.0,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:fireball",
    // rust: );
    // rust: if !hurt
    // rust: && let Some(remaining) = remaining
    // rust: && let Some(pl) = self.player.as_mut()
    // rust: {
    // rust: pl.set_remaining_fire_ticks(remaining);
}
}
}
    // rust: Who::Mob(id) => {
    // rust: let hurt = self.mobs.iter_mut().find(|m| m.id == id).is_some_and(|m| {
    // rust: let remaining = m.fire_ticks;
    // rust: if !m.kind.flags.fire_immune {
    // rust: m.ignite_for_ticks(100);
}
    // rust: let hurt =
    // rust: m.damage_projectile(5.0, source, aim, [p.velocity.x, p.velocity.z]);
    // rust: if !hurt {
    // rust: m.fire_ticks = remaining;
}
    // rust: hurt
    // rust: });
    // rust: if hurt {
    // rust: self.player_hurt_mob(p, id);
    // rust: } else if !self.mobs.iter().any(|m| m.id == id) {
                            // SmallFireball.onHitEntity: 5 damage to a boat or minecart.
    // rust: self.hurt_vehicle(p, id, 5.0);
}
}
    // rust: },
    // rust: Hit::Block { pos, face, .. } => {
                    // SmallFireball.onHitBlock: a mob's only with mobGriefing;
                    // BaseFireBlock.getState placed with updates (the fire
                    // ticks, ages and goes out where it can't stay).
    // rust: let fire = [pos[0] + face[0], pos[1] + face[1], pos[2] + face[2]];
    // rust: let mob = matches!(p.owner, Some(Who::Mob(_)));
    // rust: if (!mob || self.ui.rules.bool("mob_griefing"))
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(fire[0], fire[1], fire[2]))
    // rust: {
    // rust: let at = BlockPos::new(fire[0], fire[1], fire[2]);
    // rust: let state =
    // rust: self.with_level(|b, level, ticks| b.fire_state_for(level, ticks, at));
    // rust: self.level_set(fire, state)?;
}
}
    // rust: Hit::None => {}
    // rust: },
    // rust: (ProjectileKind::LargeFireball { power }, hit) => {
                // Fireball explosions are caused by the shooter. A direct hit
                // on the player takes `projectile_owner`, so read the owner
                // from the fireball.
    // rust: let owner = match p.owner {
    // rust: Some(Who::Mob(id)) => Some(id),
    // rust: _ => None,
}
    // rust: if let Hit::Entity { who, .. } = hit {
    // rust: match who {
    // rust: Who::Player => {
    // rust: self.mob_hits_player(
    // rust: 6.0,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:fireball",
    // rust: );
}
    // rust: Who::Mob(id) => {
    // rust: if self.mobs.iter_mut().find(|m| m.id == id).is_some_and(|m| {
    // rust: m.damage_projectile(6.0, source, aim, [p.velocity.x, p.velocity.z])
    // rust: }) {
    // rust: self.player_hurt_mob(p, id);
}
}
}
}
    // rust: self.combat.explosion_owner = owner;
    // rust: self.combat.explosion_in_water = p.touching_water;
                // The blast's source names the owner, so a dragon it kills
                // remembers the player who shot it.
    // rust: self.set_blast_by_player(p.owner == Some(Who::Player));
                // LargeFireball.onHit: both fire and MOB block destruction
                // follow mob_griefing; other mob explosions keep their default.
    // rust: let fire = self.ui.rules.bool("mob_griefing");
    // rust: let result = self.explode_mob(atp, *power as f32, fire);
    // rust: self.set_blast_by_player(false);
    // rust: self.combat.explosion_owner = None;
    // rust: self.combat.explosion_in_water = false;
    // rust: result?;
}
            // AbstractThrownPotion.onHit, then onHitAsPotion from the stack it
            // flies as: the splash happens where the hit was, a lingering
            // potion's cloud sits at the mob it hit (ThrownLingeringPotion),
            // and the potion that lands names the hurt it deals.
    // rust: (kind @ (ProjectileKind::Potion(..) | ProjectileKind::ExperienceBottle), hit) => {
                // A bottle flies as the bottle item (`getDefaultItem`).
    // rust: let bottle;
    // rust: let stack = match kind {
    // rust: ProjectileKind::Potion(stack, _) => stack,
    // rust: _ => {
    // rust: bottle = Box::new(ItemStack::new("minecraft:experience_bottle", 1));
    // rust: &bottle
}
}
    // rust: let block = match hit {
    // rust: Hit::Block { pos, face, .. } => Some((
    // rust: pos,
    // rust: Direction::approximate_nearest(Vec3::new(
    // rust: f64::from(face[0]),
    // rust: f64::from(face[1]),
    // rust: f64::from(face[2]),
    // rust: )),
    // rust: )),
    // rust: _ => None,
}
    // rust: let mob = match hit {
    // rust: Hit::Entity {
    // rust: who: Who::Player, ..
    // rust: } => self.player.as_ref().map(|pv| pv.position),
    // rust: Hit::Entity {
    // rust: who: Who::Mob(id), ..
    // rust: } => self.mobs.iter().find(|m| m.id == id).map(|m| m.position),
    // rust: _ => None,
}
    // rust: let owner = self.potion_owner(p.owner);
    // rust: self.splash(stack, at, mob, block, p.age, &owner);
    // rust: if stack.item.as_ref() != "minecraft:experience_bottle" {
    // rust: let item = stack.item.to_string();
    // rust: self.native_potion_splash(&item, [at.x, at.y, at.z]);
}
}
            // LlamaSpit.onHitEntity hurts only when the owner is a LivingEntity.
    // rust: (ProjectileKind::LlamaSpit, Hit::Entity { .. }) if p.owner.is_none() => {}
    // rust: (ProjectileKind::LlamaSpit, Hit::Entity { who, .. }) => match who {
    // rust: Who::Player => {
    // rust: self.mob_hits_player(
    // rust: 1.0,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:spit",
    // rust: );
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.damage_projectile(1.0, source, aim, [p.velocity.x, p.velocity.z]);
}
}
    // rust: },
            // ShulkerBullet.onHitEntity: 4 damage, then levitation for 10 s.
    // rust: (ProjectileKind::ShulkerBullet { .. }, Hit::Entity { who, .. }) => match who {
    // rust: Who::Player => {
                    // Only a hit that hurt (`wasHurt`) brings the levitation.
    // rust: if !self.creative
    // rust: && self.mob_hits_player(
    // rust: 4.0,
    // rust: [p.previous.x, p.previous.y, p.previous.z],
    // rust: "minecraft:mob_projectile",
    // rust: )
    // rust: {
    // rust: self.give_player_effect("minecraft:levitation", 200, 0);
}
}
    // rust: Who::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: && m.damage_projectile(4.0, source, aim, [p.velocity.x, p.velocity.z])
    // rust: {
    // rust: m.add_effect("minecraft:levitation", 200, 0);
                        // Shulker.hurtServer: a shulker hit by a bullet.
    // rust: horizon_client::mobs::shulker::hit_by_bullet(m);
}
}
    // rust: },
    // rust: (ProjectileKind::WitherSkull { .. }, hit) => {
    // rust: let who = match hit {
    // rust: Hit::Entity { who, .. } => Some(who),
    // rust: _ => None,
}
    // rust: self.wither_skull_hit(p, who, atp)?;
}
    // rust: (ProjectileKind::ShulkerBullet { .. }, Hit::Block { .. }) => {
    // rust: self.audio
    // rust: .play("minecraft:entity.shulker_bullet.hit", Some(atp), 1.0, 1.0);
    // rust: if let Some(ty) = horizon_client::particles::ParticleType::from_name("explosion") {
    // rust: let options = horizon_client::particles::ParticleOptions::simple(ty);
    // rust: for _ in 0..2 {
    // rust: let r = &mut self.world.random;
    // rust: let at = [
    // rust: atp[0] + r.next_gaussian() * 0.2,
    // rust: atp[1] + r.next_gaussian() * 0.2,
    // rust: atp[2] + r.next_gaussian() * 0.2,
    // rust: ];
    // rust: self.particles.add(&options, at, [0.0; 3]);
}
}
}
    // rust: _ => {}
}
    // rust: Ok(())
}
    // `Snowball`/`ThrownEgg.onHit`: entity event 3 for the guests, before the
    // projectile is discarded (the clients lose it when the tracker next runs).
thrown_break_event :: proc(self: ^Self, id: u32, at: [f64; 3]) {
}
    // rust: if id != 0 {
    // rust: self.lan_entity_event(id as i32, 3, at);
}
}
    // `Snowball`/`ThrownEgg.handleEntityEvent(3)`: eight crumbs of the
    // thrown item where it broke, at rest for a snowball, scattered by the
    // client entity's random (the particle engine's here) for an egg.
    // rust: pub(super) fn item_burst(&mut self, at: [f64; 3], item: &str) {
    // rust: let options = self.item_particle(&horizon_client::items::ItemStack::new(item, 1));
    // rust: let egg = item == "minecraft:egg";
    // rust: for _ in 0..8 {
    // rust: let v = if egg {
    // rust: let r = self.particles.random();
    // rust: [
    // rust: (f64::from(r.next_float()) - 0.5) * 0.08,
    // rust: (f64::from(r.next_float()) - 0.5) * 0.08,
    // rust: (f64::from(r.next_float()) - 0.5) * 0.08,
    // rust: ]
    // rust: } else {
    // rust: [0.0; 3]
}
    // rust: self.particles.add(&options, at, v);
}
}
    // `AgeableMob.mobInteract`: whether a click with `item` on `m` gets to
    // the golden dandelion check (`canUseGoldenDandelion`, which a tadpole
    // calls with `isBaby` true). A panda that is scared or on its back and an
    // armadillo in its shell answer in their own `mobInteract` first.
    // rust: pub(super) fn age_lock_takes(&self, m: &Mob, item: &str) -> bool {
    // rust: let species = m.species();
    // rust: let baby = if species == Species::Tadpole {
    // rust: true
    // rust: } else if horizon_client::mobs::finalize::ageable(species) {
    // rust: m.is_baby()
    // rust: && !(species == Species::Panda
    // rust: && (horizon_client::mobs::panda::scared(m)
    // rust: || horizon_client::mobs::panda::is_on_back(m)))
    // rust: && !(species == Species::Armadillo && horizon_client::mobs::armadillo::scared(m))
    // rust: } else {
    // rust: false
}
    // rust: let cannot = self
    // rust: .res
    // rust: .mob_data()
    // rust: .entity_has("minecraft:cannot_be_age_locked", &m.kind.id);
    // rust: horizon_client::mobs::ai::can_use_golden_dandelion(
    // rust: item,
    // rust: baby,
    // rust: m.extra.age_lock_particle_timer,
    // rust: cannot,
    // rust: )
}
    // `AgeableMob.setAgeLocked`: a golden dandelion on mob `index` flips its
    // age lock (a tadpole's or an ageable mob's own `setAgeLockedData`) and is
    // used up; a locked mob stays (`setPersistenceRequired`), and the lock's
    // use or unuse sound plays at its block for everyone near.
    // rust: pub(super) fn set_age_locked(&mut self, index: usize) {
    // rust: let m = &mut self.mobs[index];
    // rust: if m.species() == Species::Tadpole {
    // rust: horizon_client::mobs::aquatic::set_age_locked_data(m);
    // rust: } else {
    // rust: horizon_client::mobs::ai::set_age_locked_data(m);
}
    // rust: self.consume_held();
    // rust: let m = &mut self.mobs[index];
    // rust: let locked = m.extra.age_locked;
    // rust: if locked {
    // rust: m.persistent = true;
}
        // Level.playSound(null, blockPosition, ..): the middle of the block.
    // rust: let at = [
    // rust: m.position.x.floor() + 0.5,
    // rust: m.position.y.floor() + 0.5,
    // rust: m.position.z.floor() + 0.5,
    // rust: ];
    // rust: let chunk = (
    // rust: m.position.x.floor() as i32 >> 4,
    // rust: m.position.z.floor() as i32 >> 4,
    // rust: );
    // rust: self.world.modified.insert(chunk);
    // rust: let sound = if locked {
    // rust: "minecraft:item.golden_dandelion.use"
    // rust: } else {
    // rust: "minecraft:item.golden_dandelion.unuse"
}
    // rust: self.audio.play(sound, Some(at), 1.0, 1.0);
}
    // Right click on a mob (Mob.interact / mobInteract), on the mob under the
    // crosshair or on the one a guest's interact packet named: returns true
    // when consumed.
    // rust: pub(super) fn interact_mob(&mut self, target: Option<InteractTarget>) -> Result<bool> {
    // rust: let Some((index, distance, _)) = (match target {
            // The id the packet named, under the filters the crosshair pick
            // applies (`mob_hit`): a mob in its death animation is not clicked
            // by either path, so naming one in a packet must not reach the
            // feed, shear, leash or name paths either.
    // rust: Some(t) => Self::named_entity(&self.mobs, t.id, |m| m.id)
    // rust: .filter(|&i| {
    // rust: let m = &self.mobs[i];
    // rust: named_mob_pickable(m.alive(), m.id, self.riding, self.remote_camera_id())
    // rust: })
    // rust: .map(|i| (i, 0.0, [0.0; 3])),
    // rust: None => self.mob_hit(),
    // rust: }) else {
    // rust: return Ok(false);
}
        // Only a client's own pick is stopped by a block: the range check passed.
    // rust: if target.is_none()
    // rust: && let Some(hit) = self.pick_unfiltered()
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
    // rust: let d = ((hit.point[0] - eye[0]).powi(2)
    // rust: + (hit.point[1] - eye[1]).powi(2)
    // rust: + (hit.point[2] - eye[2]).powi(2))
    // rust: .sqrt();
    // rust: if d < distance {
    // rust: return Ok(false);
}
}
        // PlayerInteractTrigger: the name tag as it was before it named the mob.
    // rust: let used = self.held().cloned();
    // rust: if self.name_mob(index) {
    // rust: if let Some(stack) = &used {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
    // rust: return Ok(true);
}
    // rust: if self
    // rust: .held()
    // rust: .is_some_and(|stack| &*stack.item == "minecraft:shears")
    // rust: {
    // rust: let mob = &self.mobs[index];
    // rust: let shearable = match mob.species() {
    // rust: Species::Sheep => !mob.extra.sheared && !mob.is_baby(),
    // rust: Species::Mooshroom => !mob.is_baby(),
    // rust: Species::SnowGolem | Species::Bogged => mob.alive() && !mob.extra.sheared,
    // rust: _ => false,
}
    // rust: if shearable
    // rust: && let (Some(player), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: let mut cancel = false;
    // rust: self.native_player_shear_entity(
    // rust: player,
    // rust: &name,
    // rust: mob.id as i32,
    // rust: self.hand == Hand::Off,
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: return Ok(true);
}
}
}
    // rust: if self.spawn_egg_offspring(index) {
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: {
    // rust: let item = self.held().map(|h| h.item.to_string()).unwrap_or_default();
    // rust: let used = self.held().cloned();
    // rust: if self.interact_leash(index, &item) {
    // rust: if let Some(stack) = &used {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity(
    // rust: "minecraft:player_interacted_with_entity",
    // rust: stack,
    // rust: &target,
    // rust: );
}
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
}
    // rust: let held = self.held().cloned();
    // rust: let item = held
    // rust: .as_ref()
    // rust: .map(|h| h.item.to_string())
    // rust: .unwrap_or_default();
        // Bucketable.bucketMobPickup: a water bucket scoops up a fish, a
        // tadpole or an axolotl, with the data its bucket carries.
    // rust: if item == "minecraft:water_bucket"
    // rust: && self.mobs[index].alive()
    // rust: && let Some((bucket, sound)) = bucketable(self.mobs[index].species())
    // rust: {
    // rust: let mut filled = ItemStack::new(bucket, 1);
    // rust: filled.extra = Some(Box::new(horizon_client::entity_nbt::bucket_components(
    // rust: &self.mobs[index],
    // rust: )));
    // rust: self.audio
    // rust: .play(sound, Some(self.mobs[index].center()), 1.0, 1.0);
    // rust: self.trigger_item("minecraft:filled_bucket", &filled);
            // PlayerInteractTrigger: the water bucket as it was, and the mob picked up.
    // rust: if let Some(stack) = &held {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
    // rust: let species = bucket.trim_end_matches("_bucket").to_owned();
    // rust: let id = self.mobs[index].id as i32;
            // Leashable.dropLeash, then discard.
    // rust: self.break_leash(id as u32, true, false);
    // rust: self.mobs[index].removed = true;
    // rust: if self.creative {
    // rust: if let Some(rest) = self.give(filled) {
    // rust: self.spawn_item(rest, self.eye_position().unwrap_or([0.0; 3]), [0.0; 3], 40);
}
    // rust: } else {
    // rust: *self.held_mut() = Some(filled);
}
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_bucket_entity(player, &name, id, &species);
}
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
        // AgeableMob.mobInteract: a golden dandelion on a baby freezes its
        // growth, or lets it grow again.
    // rust: if self.mobs[index].alive() && self.age_lock_takes(&self.mobs[index], &item) {
    // rust: let entity_id = self.mobs[index].id;
    // rust: self.set_age_locked(index);
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_toggle_entity_age_lock(
    // rust: player,
    // rust: &name,
    // rust: entity_id,
    // rust: self.mobs[index].extra.age_locked,
    // rust: );
}
    // rust: if let Some(stack) = &held {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: let creative = self.creative;
        // The hand's slot (Player.interactOn passes the hand).
    // rust: let selected = self.held_slot();
        // Panda.mobInteract: bamboo, or a click on a panda lying on its back.
    // rust: if self.mobs[index].species() == Species::Panda && self.mobs[index].alive() {
    // rust: let taken = self.interact_panda(index, &item);
    // rust: if taken {
    // rust: self.swing_arm();
}
    // rust: return Ok(taken);
}
    // rust: if self.interact_zombie_villager(index, &item) {
    // rust: return Ok(true);
}
    // rust: if self.interact_trader(index, &item)? {
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if !self.mobs[index].kind.food.contains(&item)
    // rust: && self.interact_sheep_dye(index, self.hand, false)
    // rust: {
            // PlayerInteractTrigger: the dye as it was before it coloured the sheep.
    // rust: if let Some(stack) = &held {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if self.interact_allay(index, held.as_ref()) {
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if self.interact_sulfur_cube(index, &item) {
    // rust: if let Some(stack) = &held {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if self.interact_armadillo(index, &item) {
    // rust: if let Some(stack) = &held {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if self.interact_copper_golem(index, &item) {
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if self.interact_shear_mob(index, &item) {
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
    // rust: if let Some(sheared) = self.shear_pig_saddle(index, &item) {
    // rust: if sheared {
    // rust: self.swing_arm();
}
    // rust: return Ok(sheared);
}
        // AbstractHorse.mobInteract: feed, equip or ride.
    // rust: if self.interact_mount(index, &item) {
    // rust: self.swing_arm();
    // rust: return Ok(true);
}
        // PiglinAi.mobInteract: hand over something gold to admire.
    // rust: if self.mobs[index].alive() && self.give_piglin(index, &item) {
    // rust: self.swing_arm();
    // rust: if !creative && let Some(stack) = self.stack_in_mut(selected).as_mut() {
    // rust: stack.count -= 1;
    // rust: if stack.count == 0 {
    // rust: *self.stack_in_mut(selected) = None;
}
}
    // rust: return Ok(true);
}
        // Creeper.mobInteract: any item in #creeper_igniters, damaged when it
        // is damageable and used up otherwise.
    // rust: let creeper_igniter = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:creeper_igniters")
    // rust: .is_some_and(|t| t.contains(&*item));
    // rust: let fish = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:fishes")
    // rust: .is_some_and(|t| t.contains(&*item));
    // rust: let damageable = self
    // rust: .res
    // rust: .items()
    // rust: .get(&item)
    // rust: .is_some_and(|i| i.max_damage > 0);
    // rust: let parrot_poisonous = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:parrot_poisonous_food")
    // rust: .is_some_and(|t| t.contains(&*item));
    // rust: let player_at = self.eye_position();
    // rust: let player_feet = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: let acting = self.acting_player_uuid();
    // rust: let sneaking =
    // rust: self.keys.held(Action::Sneak) || self.keys.raw(&winit::keyboard::KeyCode::ShiftRight);
    // rust: let held_damage = held.as_ref().map_or(0, |h| h.damage as i32);
    // rust: let held_extra = held.as_ref().and_then(|h| h.extra.clone());
    // rust: let m = &mut self.mobs[index];
    // rust: if !m.alive() {
    // rust: return Ok(false);
}
    // rust: let species = m.species();
    // rust: let center = m.center();
        // Wolf armor the owner takes off with shears or leaves a dropped stack of.
    // rust: let mut armor_drop: Option<ItemStack> = None;
    // rust: let mut consume = false;
    // rust: let mut give: Option<&str> = None;
    // rust: let mut sound: Option<&str> = None;
        // Sounds played as vanilla plays them: (event, volume, pitch) at the feet.
    // rust: let mut eat: Option<(&'static str, f32, f32)> = None;
    // rust: let feet = [m.position.x, m.position.y, m.position.z];
    // rust: let mut handled = true;
    // rust: let mut ignited_creeper = false;
    // rust: let mut drops: Vec<(String, u32)> = Vec::new();
        // The shearing table rolled, for the mods (none for a mooshroom).
    // rust: let mut drops_table = String::new();
    // rust: let mob = (m.id, super::native_hooks::mob_kind(m));
        // `Sheep.shear`'s drops add a spread on top of the ItemEntity's own
        // motion; `MushroomCow.shear`'s do not.
    // rust: let mut wool = false;
    // rust: let is_food = m.kind.food.contains(&item);
    // rust: let baby_turtle = species == Species::Turtle && m.is_baby();
        // MushroomCow.getEffectsFromItemStack: the item's block supplies them.
    // rust: let flower = if species == Species::Mooshroom {
    // rust: horizon_client::flowers::stew_effect(&item)
    // rust: } else {
    // rust: None
}
    // rust: let mut give_stew: Option<Vec<(Arc<str>, i32)>> = None;
        // `Some(true)` for the four spell particles, `Some(false)` for the two
        // smoke puffs of a cow that already holds effects.
    // rust: let mut stew_particles: Option<bool> = None;
        // `MushroomCow.shear`: where, and how tall, the mooshroom that was sheared stood.
    // rust: let mut shear_puff: Option<([f64; 3], f64)> = None;
        // `Ocelot.mobInteract`: whether the fish won its trust.
    // rust: let mut ocelot_trust: Option<bool> = None;
    // rust: match species {
    // rust: Species::Cow | Species::Mooshroom if item == "minecraft:bucket" && !m.is_baby() => {
    // rust: give = Some("minecraft:milk_bucket");
    // rust: consume = true;
    // rust: sound = Some("entity.cow.milk");
}
            // Goat.mobInteract: a bucket on an adult gives milk.
    // rust: Species::Goat if item == "minecraft:bucket" && !m.is_baby() => {
    // rust: give = Some("minecraft:milk_bucket");
    // rust: consume = true;
    // rust: sound = Some(if m.extra.screaming {
    // rust: "entity.goat.screaming.milk"
    // rust: } else {
    // rust: "entity.goat.milk"
    // rust: });
}
            // MushroomCow.mobInteract: a bowl gives back what a flower left as
            // a suspicious stew, or plain stew when it holds no effects.
    // rust: Species::Mooshroom if item == "minecraft:bowl" && !m.is_baby() => {
    // rust: consume = true;
    // rust: match m.extra.stew_effects.take() {
    // rust: Some(effects) => {
    // rust: give = Some("minecraft:suspicious_stew");
    // rust: give_stew = Some(effects);
                        // `playSound(.., 1.0F, 1.0F)` at the feet.
    // rust: eat = Some(("entity.mooshroom.suspicious_milk", 1.0, 1.0));
}
    // rust: None => {
    // rust: give = Some("minecraft:mushroom_stew");
    // rust: sound = Some("entity.mooshroom.milk");
}
}
}
    // rust: Species::Mooshroom if item == "minecraft:shears" && !m.is_baby() => {
                // MushroomCow.shear: becomes a cow and drops five mushrooms.
    // rust: let mushroom = if m.extra.variant == 1 {
    // rust: "minecraft:brown_mushroom"
    // rust: } else {
    // rust: "minecraft:red_mushroom"
}
    // rust: drops.push((mushroom.into(), 5));
    // rust: shear_puff = Some((
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: f64::from(m.height()),
    // rust: ));
    // rust: self.audio.play_bound(
    // rust: "minecraft:entity.mooshroom.shear",
    // rust: 7,
    // rust: 1.0,
    // rust: 1.0,
    // rust: horizon_client::sound_engine::SoundEntity::new(m.id, feet, m.silent),
    // rust: None,
    // rust: );
    // rust: m.removed = true;
    // rust: let setup = SpawnSetup {
    // rust: yaw: m.yaw,
    // rust: persistent: true,
    // rust: ..Default::default()
}
    // rust: let pos = [m.position.x, m.position.y, m.position.z];
    // rust: self.handle_mob_events(vec![MobEvent::SpawnKind {
    // rust: kind: "minecraft:cow".into(),
    // rust: at: pos,
    // rust: setup,
    // rust: }])?;
    // rust: self.damage_held_tool();
}
            // MushroomCow.mobInteract: a brown adult takes the flower's effects
            // unless it holds some already, when it only puffs smoke.
    // rust: Species::Mooshroom if m.extra.variant == 1 && !m.is_baby() && flower.is_some() => {
    // rust: if m.extra.stew_effects.is_some() {
    // rust: stew_particles = Some(false);
    // rust: } else {
    // rust: let (effect, ticks) = flower.expect("the guard checked");
    // rust: m.extra.stew_effects = Some(vec![(Arc::from(effect), ticks)]);
    // rust: consume = true;
    // rust: eat = Some(("entity.mooshroom.eat", 2.0, 1.0));
    // rust: stew_particles = Some(true);
}
}
    // rust: Species::Sheep if item == "minecraft:shears" && !m.extra.sheared && !m.is_baby() => {
    // rust: self.audio.play_bound(
    // rust: "minecraft:entity.sheep.shear",
    // rust: 7,
    // rust: 1.0,
    // rust: 1.0,
    // rust: horizon_client::sound_engine::SoundEntity::new(m.id, feet, m.silent),
    // rust: None,
    // rust: );
    // rust: m.extra.sheared = true;
    // rust: let color = horizon_client::mobs::render::DYE_NAMES[m.extra.color as usize & 15];
    // rust: drops_table = format!("minecraft:shearing/sheep/{color}");
    // rust: let stacks = world_items!(self).loot_table(
    // rust: &drops_table,
    // rust: false,
    // rust: None,
    // rust: &mut self.world.random,
    // rust: );
    // rust: drops.extend(stacks.into_iter().map(|s| (s.item.to_string(), s.count)));
    // rust: wool = true;
    // rust: self.damage_held_tool();
}
            // Entity.interact: shears take a tamed wolf's armor off for its owner.
    // rust: Species::Wolf
    // rust: if item == "minecraft:shears"
    // rust: && m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && m.extra.body.is_some()
    // rust: && !sneaking =>
    // rust: {
    // rust: let mut stack = ItemStack::new("minecraft:wolf_armor", 1);
    // rust: stack.damage = m.extra.body_damage.max(0) as u32;
    // rust: stack.extra = m.extra.body_extra.take();
    // rust: armor_drop = Some(stack);
    // rust: m.extra.body = None;
    // rust: m.extra.body_damage = 0;
    // rust: eat = Some(("item.armor.unequip_wolf", 1.0, 1.0));
    // rust: self.damage_held_tool();
}
            // Wolf.mobInteract: heal, dye the collar or sit/stand when tame;
            // a bone tames a wild one a third of the time.
    // rust: Species::Wolf if m.extra.tame && is_food && m.health < m.attrs.max_health => {
    // rust: let heal = self
    // rust: .res
    // rust: .items()
    // rust: .get(&item)
    // rust: .and_then(|i| i.food.as_ref())
    // rust: .map_or(2.0, |f| f.0 as f32 * 2.0);
                // TamableAnimal.feed(.., 2.0F, 2.0F): heals twice the nutrition,
                // then playEatingSound, which wolves leave empty.
    // rust: m.heal(heal);
    // rust: consume = true;
}
            // Wolf.mobInteract: the owner puts wolf armor on a tamed adult.
    // rust: Species::Wolf
    // rust: if item == "minecraft:wolf_armor"
    // rust: && m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && m.extra.body.is_none()
    // rust: && !m.is_baby() =>
    // rust: {
    // rust: m.extra.body = Some(item.as_str().into());
    // rust: m.extra.body_damage = held_damage;
    // rust: m.extra.body_extra = held_extra;
    // rust: consume = true;
    // rust: eat = Some(("item.armor.equip_wolf", 1.0, 1.0));
}
            // Wolf.mobInteract: an armadillo scute repairs a sitting wolf's
            // armor by an eighth of its durability.
    // rust: Species::Wolf
    // rust: if item == "minecraft:armadillo_scute"
    // rust: && m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && m.extra.sitting
    // rust: && m.extra.body.is_some()
    // rust: && m.extra.body_damage > 0 =>
    // rust: {
    // rust: m.extra.body_damage = (m.extra.body_damage
    // rust: - (horizon_client::mobs::WOLF_ARMOR_DURABILITY as f32 * 0.125) as i32)
    // rust: .max(0);
    // rust: consume = true;
    // rust: eat = Some(("item.wolf_armor.repair", 1.0, 1.0));
}
    // rust: Species::Wolf
    // rust: if m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && item.ends_with("_dye")
    // rust: && horizon_client::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|d| {
    // rust: item.trim_start_matches("minecraft:")
    // rust: .trim_end_matches("_dye")
    // rust: == *d
    // rust: })
    // rust: .is_some_and(|c| c as u8 != m.extra.color) =>
    // rust: {
    // rust: let name = item
    // rust: .trim_start_matches("minecraft:")
    // rust: .trim_end_matches("_dye");
    // rust: if let Some(c) = horizon_client::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|d| *d == name)
    // rust: {
    // rust: m.extra.color = c as u8;
}
    // rust: consume = true;
}
            // Wolf.mobInteract: Animal.mobInteract first breeds an adult or
            // grows a baby with the food; only when it did not does the owner
            // make the pet sit or stand.
    // rust: Species::Wolf
    // rust: if m.extra.tame && m.extra.owner == Some(acting) && !(is_food && takes_food(m)) =>
    // rust: {
    // rust: m.extra.sitting = !m.extra.sitting;
    // rust: m.ai.jumping = false;
    // rust: m.nav_stop();
    // rust: m.ai.target = None;
    // rust: self.world.modified.insert((
    // rust: m.position.x.floor() as i32 >> 4,
    // rust: m.position.z.floor() as i32 >> 4,
    // rust: ));
}
    // rust: Species::Wolf
    // rust: if !m.extra.tame
    // rust: && item == "minecraft:bone"
    // rust: && !horizon_client::mobs::tame::angry(m) =>
    // rust: {
    // rust: consume = true;
    // rust: let tamed = m.random.next_int_bound(3).unwrap_or(1) == 0;
    // rust: if tamed {
    // rust: horizon_client::mobs::tame::set_tame(m, true);
    // rust: m.extra.owner = Some(acting);
    // rust: m.persistent = true;
    // rust: m.nav_stop();
    // rust: m.ai.target = None;
    // rust: m.extra.sitting = true;
}
                // TamableAnimal.spawnTamingParticles (entity event 7 or 6).
    // rust: self.mob_event_particles(self.mobs[index].id, if tamed { 7 } else { 6 });
    // rust: if tamed {
    // rust: let view = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_entity("minecraft:tame_animal", "entity", &view);
}
    // rust: let m = &self.mobs[index];
    // rust: self.world.modified.insert((
    // rust: m.position.x.floor() as i32 >> 4,
    // rust: m.position.z.floor() as i32 >> 4,
    // rust: ));
}
            // Cat.mobInteract: dye, heal or sit when tame; fish may tame a wild one.
    // rust: Species::Cat
    // rust: if m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && item.ends_with("_dye")
    // rust: && horizon_client::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|d| {
    // rust: item.trim_start_matches("minecraft:")
    // rust: .trim_end_matches("_dye")
    // rust: == *d
    // rust: })
    // rust: .is_some_and(|c| c as u8 != m.extra.color) =>
    // rust: {
    // rust: let name = item
    // rust: .trim_start_matches("minecraft:")
    // rust: .trim_end_matches("_dye");
    // rust: if let Some(c) = horizon_client::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|d| *d == name)
    // rust: {
    // rust: m.extra.color = c as u8;
}
    // rust: m.persistent = true;
    // rust: consume = true;
}
    // rust: Species::Cat
    // rust: if m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && is_food
    // rust: && m.health < m.attrs.max_health =>
    // rust: {
    // rust: let heal = self
    // rust: .res
    // rust: .items()
    // rust: .get(&item)
    // rust: .and_then(|i| i.food.as_ref())
    // rust: .map_or(1.0, |f| f.0 as f32);
                // TamableAnimal.feed.
    // rust: m.heal(heal);
    // rust: consume = true;
    // rust: eat = eating_sound(m, &mut self.world.random);
}
            // Cat.mobInteract: Animal.mobInteract first breeds an adult or
            // grows a baby with the food; only when it did not does the owner
            // make the pet sit or stand.
    // rust: Species::Cat
    // rust: if m.extra.tame && m.extra.owner == Some(acting) && !(is_food && takes_food(m)) =>
    // rust: {
    // rust: m.extra.sitting = !m.extra.sitting;
    // rust: self.world.modified.insert((
    // rust: m.position.x.floor() as i32 >> 4,
    // rust: m.position.z.floor() as i32 >> 4,
    // rust: ));
}
            // Parrot.mobInteract: the owner makes a tame parrot on the ground
            // sit or stand (poisonous food is handled apart).
    // rust: Species::Parrot
    // rust: if m.extra.tame
    // rust: && m.extra.owner == Some(acting)
    // rust: && m.on_ground
    // rust: && !parrot_poisonous =>
    // rust: {
    // rust: m.extra.sitting = !m.extra.sitting;
    // rust: self.world.modified.insert((
    // rust: m.position.x.floor() as i32 >> 4,
    // rust: m.position.z.floor() as i32 >> 4,
    // rust: ));
}
    // rust: Species::Cat if !m.extra.tame && is_food => {
    // rust: consume = true;
    // rust: m.persistent = true;
    // rust: let tamed = m.random.next_int_bound(3).unwrap_or(1) == 0;
    // rust: if tamed {
    // rust: m.extra.tame = true;
    // rust: m.extra.owner = Some(acting);
    // rust: m.extra.sitting = true;
}
    // rust: eat = eating_sound(m, &mut self.world.random);
                // TamableAnimal.spawnTamingParticles (entity event 7 or 6).
    // rust: self.mob_event_particles(self.mobs[index].id, if tamed { 7 } else { 6 });
    // rust: if tamed {
    // rust: let view = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_entity("minecraft:tame_animal", "entity", &view);
}
    // rust: let m = &self.mobs[index];
    // rust: self.world.modified.insert((
    // rust: m.position.x.floor() as i32 >> 4,
    // rust: m.position.z.floor() as i32 >> 4,
    // rust: ));
}
            // IronGolem.mobInteract: an iron ingot repairs 25 health.
    // rust: Species::IronGolem
    // rust: if item == "minecraft:iron_ingot" && m.health < m.attrs.max_health =>
    // rust: {
    // rust: m.heal(25.0);
    // rust: consume = true;
    // rust: sound = Some("entity.iron_golem.repair");
}
    // rust: Species::Creeper if creeper_igniter => {
    // rust: m.extra.flag = true;
    // rust: ignited_creeper = true;
                // FIRECHARGE_USE for a fire charge, else FLINTANDSTEEL_USE,
                // at the creeper's feet with a pitch from its own random.
    // rust: let event = if item == "minecraft:fire_charge" {
    // rust: "item.firecharge.use"
    // rust: } else {
    // rust: "item.flintandsteel.use"
}
    // rust: eat = Some((event, 1.0, m.random.next_float() * 0.4 + 0.8));
    // rust: if damageable {
    // rust: self.damage_held_tool();
    // rust: } else {
    // rust: consume = true;
}
}
            // Parrot.mobInteract: #parrot_poisonous_food (a cookie) poisons the
            // parrot for 45 s and then hurts it with a player attack of
            // Float.MAX_VALUE, which an invulnerable one shrugs off.
    // rust: Species::Parrot
    // rust: if self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:parrot_poisonous_food")
    // rust: .is_some_and(|t| t.contains(&*item)) =>
    // rust: {
    // rust: consume = true;
    // rust: m.add_effect("minecraft:poison", 900, 0);
    // rust: let id = m.id;
    // rust: let hurt = m.damage(
    // rust: f32::MAX,
    // rust: horizon_client::mobs::Damage::player(player_at.unwrap_or(center)),
    // rust: );
                // The feeder gets the kill, as for a normal player attack.
    // rust: if hurt {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
}
}
            // Parrot.mobInteract: parrot food may tame a wild one (one time in
            // ten); a parrot never takes it as Animal food (isFood is false).
    // rust: Species::Parrot if !m.extra.tame && is_food => {
    // rust: consume = true;
    // rust: if !m.silent {
    // rust: let pitch = 1.0 + (m.random.next_float() - m.random.next_float()) * 0.2;
    // rust: eat = Some(("entity.parrot.eat", 1.0, pitch));
}
    // rust: let tamed = m.random.next_int_bound(10).unwrap_or(1) == 0;
    // rust: if tamed {
    // rust: m.extra.tame = true;
    // rust: m.extra.owner = Some(acting);
}
                // TamableAnimal.spawnTamingParticles (entity event 7 or 6).
    // rust: self.mob_event_particles(self.mobs[index].id, if tamed { 7 } else { 6 });
    // rust: if tamed {
    // rust: let view = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_entity("minecraft:tame_animal", "entity", &view);
}
}
            // Dolphin.mobInteract: a fish makes a baby grow by a tenth and an
            // adult remember it (`gotFish`), to swim to a treasure.
    // rust: Species::Dolphin if fish => {
    // rust: eat = Some(("entity.dolphin.eat", 1.0, 1.0));
    // rust: if horizon_client::mobs::ai::can_age_up(m) {
    // rust: let secs = ((-m.extra.age / 20) as f32 * 0.1) as i32;
    // rust: horizon_client::mobs::ai::age_up(m, secs, true);
    // rust: } else {
    // rust: m.extra.flag = true;
}
    // rust: consume = true;
}
            // Tadpole.feed: frog food ages it by a tenth of the time left to
            // grow into a frog (it grows on its next tick once past 24000).
    // rust: Species::Tadpole if is_food && !m.extra.age_locked => {
    // rust: consume = true;
    // rust: let left = 24_000 - m.extra.age;
    // rust: m.extra.age += ((left / 20) as f32 * 0.1) as i32 * 20;
                // One happy villager particle at rest about the body.
    // rust: self.particles_around_mob(
    // rust: self.mobs[index].id,
    // rust: "happy_villager",
    // rust: horizon_client::particles::Burst::HORSE_EATING,
    // rust: );
}
            // Bee.mobInteract: a wither rose or an open eyeblossom is eaten for
            // its `getBeeInteractionEffect` instead of breeding the bee.
    // rust: Species::Bee
    // rust: if is_food
    // rust: && matches!(
    // rust: &*item,
    // rust: "minecraft:wither_rose" | "minecraft:open_eyeblossom"
    // rust: ) =>
    // rust: {
    // rust: if &*item == "minecraft:wither_rose" {
    // rust: m.add_effect("minecraft:wither", 40, 0);
    // rust: } else {
    // rust: m.add_effect("minecraft:poison", 25, 0);
}
    // rust: consume = true;
}
            // Ocelot.mobInteract: raw fish from a hand within 3 blocks, while it comes for the
            // food (`temptGoal.isRunning`), is used up; one time in three it trusts the player
            // (entity event 41, hearts), otherwise smoke (event 40). Anything else is
            // `Animal.mobInteract`.
    // rust: Species::Ocelot
    // rust: if is_food
    // rust: && !m.extra.trusting
    // rust: && m.ai.goals.is_running("OcelotTemptGoal")
    // rust: && player_feet.is_some_and(|p| {
    // rust: let d = [
    // rust: p[0] - m.position.x,
    // rust: p[1] - m.position.y,
    // rust: p[2] - m.position.z,
    // rust: ];
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < 9.0
    // rust: }) =>
    // rust: {
    // rust: consume = true;
    // rust: let trusts = m.random.next_int_bound(3).unwrap_or(1) == 0;
    // rust: if trusts {
    // rust: m.extra.trusting = true;
}
    // rust: ocelot_trust = Some(trusts);
}
            // HappyGhast.canFallInLove: never, so only a ghastling takes food.
    // rust: _ if is_food
    // rust: && m.kind.flags.animal
    // rust: && species != Species::Parrot
    // rust: && (species != Species::HappyGhast || m.is_baby()) =>
    // rust: {
                // Animal.mobInteract: breed adults, speed up babies, then
                // playEatingSound (silent unless the species overrides it).
    // rust: match feed_animal(m, &mut self.world.random, Some(acting)) {
    // rust: Some(sound) => {
    // rust: consume = true;
    // rust: eat = sound;
                        // Axolotl.usePlayerItem: a tropical fish bucket is
                        // emptied into a water bucket in its place.
    // rust: if species == Species::Axolotl && &*item == "minecraft:tropical_fish_bucket"
    // rust: {
    // rust: give = Some("minecraft:water_bucket");
}
                        // Animal.setInLove: entity event 18 (a baby that
                        // only grew is not in love).
    // rust: if self.mobs[index].extra.in_love > 0 {
    // rust: let id = self.mobs[index].id;
    // rust: self.love_cause.insert(id, self.lan_acting);
    // rust: let kind = self.mobs[index].kind.id.clone();
    // rust: self.native_entity_enter_love_mode(id, &kind, self.lan_acting_uuid);
    // rust: self.mob_event_particles(id, 18);
}
}
                    // Animal.mobInteract still consumes the client click when
                    // an adult cannot breed, without swinging or taking food.
    // rust: None => return Ok(true),
}
}
    // rust: _ => handled = false,
}
    // rust: if !handled {
    // rust: return Ok(false);
}
    // rust: if ignited_creeper {
    // rust: self.native_creeper_ignite(
    // rust: self.mobs[index].id,
    // rust: horizon_client::lan::playerdata::ints_uuid(acting),
    // rust: &item,
    // rust: );
}
    // rust: if let Some(trusts) = ocelot_trust {
            // `spawnTrustingParticles` on the clients: entity event 41 (hearts) or 40 (smoke).
    // rust: self.mob_event_particles(self.mobs[index].id, if trusts { 41 } else { 40 });
}
    // rust: if let Some(fresh) = stew_particles {
            // `SpellParticleOption.create(EFFECT, -1, 1)` is the plain white
            // effect particle; the smoke is the already-fed answer.
    // rust: let ty = if fresh {
    // rust: ParticleType::Effect
    // rust: } else {
    // rust: ParticleType::Smoke
}
    // rust: let options = ParticleOptions::simple(ty);
    // rust: let at = [feet[0], feet[1] + 0.5, feet[2]];
    // rust: let (spread, count) = ([0.5, 0.0, 0.5], if fresh { 4 } else { 2 });
            // shortcut: scalar speed models DEFAULT randomization; 26.3 sends
            // ALTERNATIVE_WITH_SPEED with a per-axis maximum speed.
    // rust: self.particles
    // rust: .send_particles(&options, at, spread, 0.2, count);
    // rust: self.lan_send_particles(super::lan_particles::QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options,
    // rust: state: None,
    // rust: at,
    // rust: spread,
    // rust: speed: [0.2; 3],
    // rust: count: count as i32,
    // rust: randomization: 0,
    // rust: });
}
        // PlayerInteractTrigger: the item used on the mob, once the interaction took.
    // rust: if let Some(stack) = &held {
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", stack, &target);
}
        // Turtle.ageBoundaryReached: food that finishes a baby's growth.
    // rust: if baby_turtle && !self.mobs[index].is_baby() {
    // rust: self.handle_mob_events(vec![MobEvent::GiftLoot {
    // rust: mob: self.mobs[index].id,
    // rust: table: "minecraft:gameplay/turtle_grow",
    // rust: at: feet,
    // rust: }])?;
}
    // rust: self.swing_arm();
    // rust: if let Some(s) = sound {
    // rust: let pitch =
    // rust: (self.world.random.next_float() - self.world.random.next_float()) * 0.2 + 1.0;
    // rust: self.audio
    // rust: .play(&format!("minecraft:{s}"), Some(center), 1.0, pitch);
}
    // rust: if let Some((s, volume, pitch)) = eat {
    // rust: let event = format!("minecraft:{s}");
    // rust: if matches!(
    // rust: self.mobs[index].species(),
    // rust: Species::Frog | Species::Goat | Species::Sniffer
    // rust: ) {
    // rust: self.play_mob_bound_sound(index, &event, 6, volume, pitch, false);
    // rust: } else {
    // rust: self.audio.play(&event, Some(feet), volume, pitch);
}
}
    // rust: if consume
    // rust: && !creative
    // rust: && let Some(stack) = self.stack_in_mut(selected).as_mut()
    // rust: {
    // rust: stack.count -= 1;
    // rust: if stack.count == 0 {
    // rust: *self.stack_in_mut(selected) = None;
}
}
    // rust: if let Some(g) = give {
    // rust: let mut stack = ItemStack {
    // rust: item: g.into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: if let Some(effects) = give_stew {
    // rust: stack.extra = Some(Box::new(horizon_client::item_data::StackData {
    // rust: stew_effects: effects,
    // rust: ..Default::default()
    // rust: }));
}
    // rust: if self.stack_in(selected).is_none() {
    // rust: *self.stack_in_mut(selected) = Some(stack);
    // rust: } else if let Some(rest) = self.give(stack) {
    // rust: let at = self.eye_position().unwrap_or(center);
    // rust: self.spawn_item(rest, at, [0.0, 0.0, 0.0], 40);
}
}
    // rust: if let Some(stack) = armor_drop {
            // Mob.shearItem: PLAYER_SHEARED_EQUIPMENT with the armor and the wolf.
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_sheared_equipment", &stack, &target);
    // rust: self.spawn_item(stack, [center[0], center[1] + 0.5, center[2]], [0.0; 3], 10);
}
    // rust: if let Some((at, height)) = shear_puff {
    // rust: self.mooshroom_shear_puff(at, height);
}
    // rust: let mut drops: Vec<ItemStack> = drops
    // rust: .into_iter()
    // rust: .map(|(item, count)| ItemStack::new(&item, count))
    // rust: .collect();
    // rust: if !drops.is_empty() {
    // rust: self.native_use_drops(
    // rust: &drops_table,
    // rust: feet,
    // rust: None,
    // rust: Some((mob.0, &mob.1)),
    // rust: held.as_ref(),
    // rust: &mut drops,
    // rust: );
}
    // rust: for stack in drops {
    // rust: for _ in 0..stack.count {
                // `spawnAtLocation(stack, 1.0)`: an ItemEntity a block above
                // the feet that starts with the constructor's own motion, and
                // `setDefaultPickUpDelay`. Sheep.shear adds its spread on top;
                // MushroomCow.shear builds the entity by hand instead, so its
                // mushrooms keep the constructor's motion and no pickup delay.
    // rust: let mut v = dispenser::new_item_motion();
    // rust: if wool {
    // rust: v[0] += (self.world.random.next_float() - self.world.random.next_float())
    // rust: as f64
    // rust: * 0.1;
    // rust: v[1] += self.world.random.next_float() as f64 * 0.05;
    // rust: v[2] += (self.world.random.next_float() - self.world.random.next_float())
    // rust: as f64
    // rust: * 0.1;
}
    // rust: self.spawn_item(
    // rust: ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
    // rust: },
    // rust: [feet[0], feet[1] + 1.0, feet[2]],
    // rust: v,
    // rust: if wool { 10 } else { 0 },
    // rust: );
}
}
    // rust: Ok(true)
}
    // `SnowGolem.mobInteract` and `Bogged.mobInteract` with shears: the
    // pumpkin or the mushrooms come off (the shearing loot table), the shear
    // game event is posted and the tool takes one damage.
interact_shear_mob :: proc(self: ^Self, index: uint, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let m = &self.mobs[index];
    // rust: if item != "minecraft:shears" || !m.alive() || m.extra.sheared {
    // rust: return false;
}
    // rust: let (sound, table, height) = match m.species() {
    // rust: Species::SnowGolem => (
    // rust: "minecraft:entity.snow_golem.shear",
    // rust: "minecraft:shearing/snow_golem",
    // rust: m.eye_height(),
    // rust: ),
    // rust: Species::Bogged => (
    // rust: "minecraft:entity.bogged.shear",
    // rust: "minecraft:shearing/bogged",
    // rust: f64::from(m.height()),
    // rust: ),
    // rust: _ => return false,
}
    // rust: let at = m.position;
    // rust: let mob = (m.id, super::native_hooks::mob_kind(m));
    // rust: let tool = self.held().cloned();
    // rust: self.play_mob_bound_sound(index, sound, 7, 1.0, 1.0, false);
    // rust: self.mobs[index].extra.sheared = true;
    // rust: let mut stacks = self.sequence_loot(table, table, tool.as_ref());
    // rust: let origin = [at.x, at.y, at.z];
    // rust: self.native_use_drops(
    // rust: table,
    // rust: origin,
    // rust: None,
    // rust: Some((mob.0, &mob.1)),
    // rust: tool.as_ref(),
    // rust: &mut stacks,
    // rust: );
    // rust: for stack in stacks {
    // rust: self.spawn_at_location(at, height, stack);
}
    // rust: let ctx = self.who_context(Some(horizon_client::mobs::Who::Player), None);
    // rust: self.post_game_event("minecraft:shear", [at.x, at.y, at.z], ctx);
    // rust: self.damage_held_tool();
    // rust: true
}
    // `Armadillo.mobInteract`: a brush brushes a scute off an adult
    // (`brushOffScute`) and loses 16 durability.
interact_armadillo :: proc(self: ^Self, index: uint, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let m = &self.mobs[index];
    // rust: if item != "minecraft:brush"
    // rust: || m.species() != Species::Armadillo
    // rust: || !m.alive()
    // rust: || m.is_baby()
    // rust: {
    // rust: return false;
}
    // rust: let (id, at) = (m.id, m.position);
    // rust: let feet = [at.x, at.y, at.z];
    // rust: let tool = self.held().cloned();
    // rust: let table = "minecraft:brush/armadillo";
    // rust: let mut stacks = self.sequence_loot(table, table, tool.as_ref());
    // rust: let kind = super::native_hooks::mob_kind(&self.mobs[index]);
    // rust: self.native_use_drops(
    // rust: table,
    // rust: feet,
    // rust: None,
    // rust: Some((id, &kind)),
    // rust: tool.as_ref(),
    // rust: &mut stacks,
    // rust: );
    // rust: for d in stacks {
    // rust: self.spawn_at_location(at, 0.0, d);
}
    // rust: self.audio
    // rust: .play("minecraft:entity.armadillo.brush", Some(feet), 1.0, 1.0);
    // rust: let ctx = self.who_context(Some(Who::Mob(id)), None);
    // rust: self.post_game_event("minecraft:entity_interact", feet, ctx);
        // ItemStack.hurtAndBreak(16).
    // rust: if !self.creative
    // rust: && let Some(stack) = tool
    // rust: {
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage);
    // rust: if max > 0 {
    // rust: self.damage_held(16);
}
}
    // rust: true
}
    // `ItemStack.hurtAndBreak(1, ...)` on the held tool: Unbreaking, break sound and stat.
    // rust: pub(super) fn damage_held_tool(&mut self) {
    // rust: self.damage_held(1);
}
    // Throwables and spawn eggs (SnowballItem/EggItem/EnderpearlItem/SpawnEggItem.use).
    // rust: pub(super) fn throw_item(&mut self, stack: &ItemStack) -> Result<bool> {
    // rust: let item = &*stack.item;
    // rust: let kind = match item {
    // rust: "minecraft:snowball" => ProjectileKind::Snowball,
    // rust: "minecraft:egg" | "minecraft:blue_egg" | "minecraft:brown_egg" => ProjectileKind::Egg,
    // rust: "minecraft:ender_pearl" => ProjectileKind::EnderPearl,
    // rust: "minecraft:wind_charge" => {
    // rust: let thrown = self.throw_wind_charge()?;
    // rust: if thrown {
    // rust: self.apply_use_cooldown(stack);
}
    // rust: return Ok(thrown);
}
    // rust: _ if item.ends_with("_spawn_egg") => return self.use_spawn_egg(stack),
    // rust: _ => match horizon_client::projectiles::thrown_by_item(item) {
    // rust: Some(t) => ProjectileKind::Thrown(t),
    // rust: None => return Ok(false),
    // rust: },
}
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return Ok(false);
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return Ok(false);
}
        // Projectile.shootFromRotation adds getKnownMovement: what the thrower
        // last moved, not a velocity the server kept for a guest.
    // rust: let on_ground = p.ground.on_ground;
    // rust: let velocity = self.known_player_movement();
    // rust: let start = Vec3::new(eye[0], eye[1] - 0.1, eye[2]);
    // rust: let mut proj = Projectile::new(kind.clone(), start, Some(Who::Player));
    // rust: proj.shoot_from_rotation(
    // rust: &mut self.world.random,
    // rust: self.pitch,
    // rust: self.yaw,
    // rust: 0.0,
    // rust: 1.5,
    // rust: 1.0,
    // rust: velocity,
    // rust: on_ground,
    // rust: );
    // rust: self.add_projectile(proj);
        // ItemStack.use's applyAfterUseComponentSideEffects: the pearl's
        // second is the `use_cooldown` component, as for any thrown item.
    // rust: self.apply_use_cooldown(stack);
    // rust: let sound = match kind {
    // rust: ProjectileKind::Snowball | ProjectileKind::Thrown(_) => {
    // rust: "minecraft:entity.snowball.throw"
}
    // rust: ProjectileKind::Egg => "minecraft:entity.egg.throw",
    // rust: _ => "minecraft:entity.ender_pearl.throw",
}
    // rust: let pitch = 0.4 / (self.world.random.next_float() * 0.4 + 0.8);
    // rust: self.audio.play(sound, Some(eye), 0.5, pitch);
    // rust: self.swing_arm();
    // rust: if !self.creative
    // rust: && let Some(s) = self.held_mut().as_mut()
    // rust: {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *self.held_mut() = None;
}
}
    // rust: if kind == ProjectileKind::Egg
    // rust: && let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_egg_throw(player, &name);
}
    // rust: Ok(true)
}
    // `Mob.checkAndHandleImportantInteractions` with a spawn egg of mob
    // `index`'s own kind (`SpawnEggItem.spawnOffspringFromSpawnEgg`): a baby
    // at the mob's feet, taking the parent's variant as `getBreedOffspring`
    // does, and one egg used. False (PASS) when the mob has no baby form.
spawn_egg_offspring :: proc(self: ^Self, index: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(stack) = self.held().cloned() else {
    // rust: return false;
}
    // rust: let parent = &self.mobs[index];
    // rust: if !parent.alive()
    // rust: || !horizon_client::mobs::finalize::spawn_egg_is_for(&stack.item, &parent.kind.id)
    // rust: || !horizon_client::mobs::drops::can_be_baby(parent.species())
            // WanderingTrader.getBreedOffspring returns null: no offspring, the
            // click carries on to trading.
    // rust: || parent.species() == Species::WanderingTrader
    // rust: {
    // rust: return false;
}
    // rust: let (kind, at) = (
    // rust: parent.kind.id.clone(),
    // rust: [parent.position.x, parent.position.y, parent.position.z],
    // rust: );
    // rust: let (species, variant, color) =
    // rust: (parent.species(), parent.extra.variant, parent.extra.color);
    // rust: let mob_type = parent.kind.clone();
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: let id = if species == Species::Piglin {
            // SpawnEggItem.spawnOffspringFromSpawnEgg: a non-AgeableMob is
            // constructed, then setBaby(true), without finalizeSpawn. Giving
            // it adult spawn gear first leaves the baby holding a weapon.
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: self.mobs
    // rust: .push(Mob::new(id, mob_type, Vec3::new(at[0], at[1], at[2]), 0.0));
    // rust: id
    // rust: } else {
    // rust: let Some(id) = self.spawn_mob_spawned(&kind, at) else {
    // rust: return false;
}
    // rust: id
}
    // rust: if let Some(child) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: horizon_client::mobs::finalize::spawn_egg_offspring(child, species, variant, color);
}
    // rust: if species == Species::Piglin {
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
}
        // `Mob.checkAndHandleImportantInteractions` then calls
        // `onOffspringSpawnedFromEgg`: `Fox`'s makes the baby trust the player
        // who used the egg (a fox egg used on a block trusts nobody).
    // rust: if species == Species::Fox {
    // rust: let spawner = self.acting_player_uuid();
    // rust: if let Some(child) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: horizon_client::mobs::fox::add_trusted_entity(child, spawner);
}
}
    // rust: self.trigger_item_entity("minecraft:player_interacted_with_entity", &stack, &target);
    // rust: self.consume_held();
    // rust: true
}
    // `SpawnEggItem.use`: the SOURCE_ONLY ray must hit a liquid block.
    // rust: pub(super) fn spawn_egg_fluid_hit(&self) -> Option<super::Hit> {
    // rust: let hit = self.bucket_hit()?;
    // rust: matches!(
    // rust: &*self.block_name(hit.pos),
    // rust: "minecraft:water" | "minecraft:lava"
    // rust: )
    // rust: .then_some(hit)
}
    // Shared peaceful-mode eligibility for spawn eggs.
    // rust: pub(super) fn spawn_egg_allowed(&self, item: &str) -> bool {
    // rust: let kind = item.trim_end_matches("_spawn_egg");
    // rust: self.ui.difficulty != 0
    // rust: || self
    // rust: .res
    // rust: .mob_types()
    // rust: .get(kind)
    // rust: .is_none_or(|t| horizon_client::mobs::spawn_rules::allowed_in_peaceful(t.species))
}
    // `SpawnEggItem.useOn` for a block, or `use` for a fluid source.
use_spawn_egg :: proc(self: ^Self, stack: ^ItemStack) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let fluid = matches!(self.guest_use, Some(super::GuestUse::Item(_)));
    // rust: let Some(hit) = (if fluid {
    // rust: self.spawn_egg_fluid_hit()
    // rust: } else {
    // rust: self.pick()
    // rust: }) else {
    // rust: return Ok(false);
}
    // rust: let kind = stack.item.trim_end_matches("_spawn_egg").to_owned();
    // rust: if !self.spawn_egg_allowed(&stack.item) {
    // rust: self.use_failed = true;
    // rust: return Ok(true);
}
    // rust: if fluid
    // rust: && !self.may_build()
    // rust: && !self.can_place_on_in_adventure([
    // rust: hit.pos[0] - hit.face[0],
    // rust: hit.pos[1] - hit.face[1],
    // rust: hit.pos[2] - hit.face[2],
    // rust: ])
    // rust: {
    // rust: self.use_failed = true;
    // rust: return Ok(true);
}
        // SpawnEggItem.useOn on a spawner sets its mob (and an op's egg data).
    // rust: let (spawner_id, data) = horizon_client::block_entity_item::spawn_egg_on_spawner(
    // rust: stack,
    // rust: self.acting_player_is_op(),
    // rust: );
    // rust: if let Some(done) = self.use_spawn_egg_on_spawner(hit.pos, &spawner_id, data.as_ref()) {
    // rust: if done {
    // rust: self.swing_arm();
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.consume_held();
}
    // rust: return Ok(true);
}
        // useOn: a clicked block without a collision shape (vines, grass)
        // takes the mob itself, any other the one on the clicked face.
    // rust: let p = if fluid || self.collision_empty(hit.pos) {
    // rust: hit.pos
    // rust: } else {
    // rust: [
    // rust: hit.pos[0] + hit.face[0],
    // rust: hit.pos[1] + hit.face[1],
    // rust: hit.pos[2] + hit.face[2],
    // rust: ]
}
    // rust: let at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: let Some(id) = self.spawn_mob_spawned(&kind, at) else {
    // rust: return Ok(false);
}
        // SpawnEggItem.spawnMob: `EntityType.create` finalizes the mob, then
        // `PostSpawnProcessor` puts the egg's components on it.
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: horizon_client::entity_nbt::apply_item_components(m, stack);
}
    // rust: self.apply_spawn_egg_entity_data(id, stack);
    // rust: self.post_block_game_event("minecraft:entity_place", p, Some(Who::Player), None);
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: if !self.creative
    // rust: && let Some(s) = self.held_mut().as_mut()
    // rust: {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *self.held_mut() = None;
}
}
    // rust: Ok(true)
}
    // `EntityType.updateCustomEntityTag`: the egg's `minecraft:entity_data` on
    // the mob it spawned, once the guards let it through, as
    // `TypedEntityData.loadInto`: the mob's own compound, the data merged over
    // it, loaded back into the same mob (`/data merge entity`'s loader).
    // rust: pub(super) fn apply_spawn_egg_entity_data(&mut self, id: u32, stack: &ItemStack) {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: return;
}
    // rust: let kind = self.mobs[i].kind.id.clone();
    // rust: let op = self.acting_player_is_op();
    // rust: let Some(data) = horizon_client::block_entity_item::spawn_egg_entity_data(stack, &kind, op)
    // rust: else {
    // rust: return;
}
    // rust: let own = self.mob_tree_nbt(i);
    // rust: let tag = horizon_client::data_cmd::merged(&own, data);
        // Nothing to report: the mob's own compound always loads back.
    // rust: let _ = self.apply_entity_nbt(super::commands::Target::Mob(id), tag);
}
    // A beam target's centre (half its height), interpolated.
beam_target :: proc(self: ^Self, who: Maybe(Who), alpha: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match who? {
    // rust: Who::Player => {
    // rust: let p = self.player.as_ref()?;
    // rust: let (a, b) = (self.previous_position, p.position);
    // rust: Some(glam::DVec3::new(
    // rust: a.x + (b.x - a.x) * alpha,
    // rust: a.y + (b.y - a.y) * alpha + f64::from(p.dimensions.height) * 0.5,
    // rust: a.z + (b.z - a.z) * alpha,
    // rust: ))
}
    // rust: Who::Mob(id) => {
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: Some(glam::DVec3::new(
    // rust: m.previous.x + (m.position.x - m.previous.x) * alpha,
    // rust: m.previous.y
    // rust: + (m.position.y - m.previous.y) * alpha
    // rust: + f64::from(m.height()) * 0.5,
    // rust: m.previous.z + (m.position.z - m.previous.z) * alpha,
    // rust: ))
}
}
}
    // `Guardian.aiStep` on a client: two bubbles a tick trailing a guardian
    // that swims along, and bubbles up the beam to its target. The server
    // never draws them, so the mob's own random stays untouched.
    // rust: pub(super) fn guardian_bubbles(&mut self) {
//         use horizon_client::mobs::guardian;
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let mut swimming = Vec::new();
    // rust: let mut beams = Vec::new();
    // rust: for m in &self.mobs {
    // rust: if !m.alive() || !matches!(m.species(), Species::Guardian | Species::ElderGuardian) {
    // rust: continue;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: if m.extra.flag2 && m.fluids.in_water {
    // rust: let (width, height, _) = m.dims();
    // rust: swimming.push((at, width, height, m.view_vector()));
}
    // rust: if let Some((_, scale)) = guardian::beam(m, 0.0)
    // rust: && let Some(t) = self.beam_target(m.ai.target, 1.0)
    // rust: {
    // rust: beams.push(([at[0], m.eye_y(), at[2]], [t.x, t.y, t.z], f64::from(scale)));
}
}
    // rust: let bubble = ParticleOptions::simple(ParticleType::Bubble);
    // rust: for (at, width, height, view) in swimming {
    // rust: for _ in 0..2 {
    // rust: let (x, y, z) = {
    // rust: let r = self.particles.random();
    // rust: (r.next_double(), r.next_double(), r.next_double())
}
    // rust: let p = [
    // rust: at[0] + width * (2.0 * x - 1.0) * 0.5 - view[0] * 1.5,
    // rust: at[1] + height * y - view[1] * 1.5,
    // rust: at[2] + width * (2.0 * z - 1.0) * 0.5 - view[2] * 1.5,
    // rust: ];
    // rust: self.particles.add(&bubble, p, [0.0; 3]);
}
}
    // rust: for (eye, target, scale) in beams {
    // rust: let d = [target[0] - eye[0], target[1] - eye[1], target[2] - eye[2]];
    // rust: let length = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if length <= 0.0 {
    // rust: continue;
}
    // rust: let mut dist = self.particles.random().next_double();
    // rust: while dist < length {
    // rust: let r = self.particles.random();
    // rust: dist += 1.8 - scale + r.next_double() * (1.7 - scale);
    // rust: let f = dist / length;
    // rust: let p = [eye[0] + d[0] * f, eye[1] + d[1] * f, eye[2] + d[2] * f];
    // rust: self.particles.add(&bubble, p, [0.0; 3]);
}
}
}
    // Mob models and projectiles for the entity pass.
    // The renderer's models for the GPU path (`mobs::skin`) this frame, if it
    // poses entities: a new frame of draws, the store restarted when the
    // renderer's no longer matches. Once per frame, before any entity draws.
    // rust: pub(super) fn begin_skinning(&self) {
    // rust: let renderer = self.renderer.as_ref().filter(|r| r.skins_entities());
    // rust: match renderer.and_then(|r| r.skinned_models()) {
    // rust: Some(stored) => {
    // rust: let mut models = self.skin_models.borrow_mut();
    // rust: models.begin(&mut self.skin_frame.borrow_mut(), stored);
    // rust: models.tagged = renderer.is_some_and(|r| r.skins_tagged());
}
    // rust: None => self.skin_frame.borrow_mut().clear_draws(),
}
}

    // Whether this frame's models can be posed on the GPU (`begin_skinning`).
    // rust: pub(super) fn skinning(&self) -> bool {
    // rust: self.renderer
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.skins_entities() && r.skinned_models().is_some())
}

    // Culls one entity's vertices from `entity_start`, counting what it drew
    // on the GPU path by the corners of `skinned`'s bounds; a culled entity's
    // posed draws since `skinned`'s mark are taken back.
    // rust: pub(super) fn cull_skinned(
    // rust: &self,
    // rust: out: &mut Vec<Vertex>,
    // rust: entity_start: usize,
    // rust: skinned: Skinned,
    // rust: ) {
    // rust: let corners = skinned.and_then(|(_, bounds)| bounds);
    // rust: if out.len() == entity_start {
    // rust: if let Some((lo, hi)) = corners
    // rust: && self.cull_entity_camera_bounds(lo, hi)
    // rust: && let Some((mark, _)) = skinned
    // rust: {
    // rust: if self.pack_shadow_casters.0 {
    // rust: let mut frame = self.skin_frame.borrow_mut();
    // rust: let end = frame.vertices as usize;
    // rust: horizon_client::gfx::pack_draw::EntitySpan::hide(
    // rust: &mut frame.spans,
    // rust: mark.2 as usize,
    // rust: end,
    // rust: );
    // rust: } else {
    // rust: self.skin_frame.borrow_mut().truncate(mark);
}
}
    // rust: return;
}
    // rust: if let Some((lo, hi)) = corners {
    // rust: out.extend([lo, hi].map(|pos| Vertex {
    // rust: pos: pos.to_array(),
    // rust: ..bytemuck::Zeroable::zeroed()
    // rust: }));
}
    // rust: let len = out.len();
    // rust: let hidden = self.cull_entity_vertices(out, entity_start);
    // rust: if out.len() < len {
    // rust: if let Some((mark, _)) = skinned {
    // rust: self.skin_frame.borrow_mut().truncate(mark);
}
    // rust: } else if corners.is_some() {
    // rust: if let Some((mark, _)) = skinned {
                // Previous GPU-only entities can leave zero-length CPU spans at
                // this same offset. Use this query's result, not their metadata.
    // rust: if hidden {
    // rust: let mut skin = self.skin_frame.borrow_mut();
    // rust: let end = skin.vertices as usize;
    // rust: horizon_client::gfx::pack_draw::EntitySpan::hide(
    // rust: &mut skin.spans,
    // rust: mark.2 as usize,
    // rust: end,
    // rust: );
}
}
    // rust: out.truncate(len - 2);
            // The temporary bounds are not real geometry. Keep the culling end marker
            // at the true CPU end before the next entity appends a span there.
    // rust: for span in self.entity_spans.borrow_mut().iter_mut().rev() {
    // rust: if span.start as usize <= out.len() {
    // rust: break;
}
    // rust: span.start = out.len() as u32;
}
}
}

    // rust: pub(super) fn mob_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
        // The coarse mob bounds pay off only in dense async scenes; otherwise,
        // keep the existing exact mesh-culling path.
    // rust: if self.settings.horizon.entity_culling == EntityCullingMode::Asynchronous
    // rust: && self
    // rust: .async_occlusion_culler
    // rust: .as_ref()
    // rust: .is_some_and(|culler| culler.camera_is_stationary())
    // rust: && self.settings.horizon.entity_culling_precheck != 0
    // rust: && self.mobs.len() >= self.settings.horizon.entity_culling_precheck as usize
    // rust: && !self.pack_shadow_casters.0
    // rust: && horizon_client::mod_api::mods().is_empty()
    // rust: {
    // rust: self.mob_geometry_inner::<true>(camera, alpha, out);
    // rust: } else {
    // rust: self.mob_geometry_inner::<false>(camera, alpha, out);
}
}

    // rust: fn mob_geometry_inner<const PRECHECK: bool>(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let lookup = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
    // rust: let scale = self.view_scale();
    // rust: self.rendered_mobs.set(0);
    // rust: let skinning = self.skinning();
        // What custom entity model animations read of the frame.
    // rust: horizon_client::mobs::cem_anim::set_frame(horizon_client::mobs::cem_anim::Frame {
    // rust: time: self.world.game_time as f64 + alpha,
    // rust: day_time: self.world.day_time as f64 + alpha,
    // rust: dimension: match self.dim {
    // rust: Dim::Overworld => 0.0,
    // rust: Dim::Nether => -1.0,
    // rust: Dim::End => 1.0,
    // rust: },
    // rust: player: self.player.as_ref().map_or(camera.to_array(), |p| {
    // rust: [p.position.x, p.position.y, p.position.z]
    // rust: }),
    // rust: player_rot: [self.pitch, self.yaw],
    // rust: paused: self.pause,
    // rust: first_person: self.camera_type.first_person(),
    // rust: third_person_reversed: self.camera_type
    // rust: == super::perspective::CameraType::ThirdPersonFront,
    // rust: ..Default::default()
    // rust: });
    // rust: for mob in &self.mobs {
            // LevelRenderer: the entity the view looks out of is not drawn
            // in first person.
    // rust: if self.hides_as_camera(mob.id) {
    // rust: continue;
}
    // rust: let is_player = &*mob.kind.id == "minecraft:player";
    // rust: let d = glam::DVec3::new(mob.position.x, mob.position.y, mob.position.z) - camera;
            // Entity.shouldRenderAtSqrDistance: 64 times the bounding box's
            // mean edge, scaled by the view scale. RemotePlayer's box counts
            // ten times.
    // rust: let (w, h, _) = mob.dims();
    // rust: let edge = (w + h + w) / 3.0 * if is_player { 10.0 } else { 1.0 };
    // rust: let range = edge * 64.0 * scale;
    // rust: if d.length_squared() >= range * range {
    // rust: continue;
}
    // rust: let beam = horizon_client::mobs::guardian::beam(mob, alpha as f32);
            // EntityRenderer.shouldRender: the renderer's interpolated culling box,
            // grown by 0.5 (GuardianRenderer also draws while its beam is out).
    // rust: if let Some(view) = &self.view_frustum
    // rust: && beam.is_none()
    // rust: {
    // rust: let (lo, hi) = super::entity_culling::cull_box(mob, alpha);
    // rust: let (lo, hi) = (
    // rust: (lo - camera - glam::DVec3::splat(0.5)).as_vec3(),
    // rust: (hi - camera + glam::DVec3::splat(0.5)).as_vec3(),
    // rust: );
    // rust: if !view.intersects(lo, hi) {
    // rust: continue;
}
}
    // rust: let outline = self.mob_outline(mob);
            // Entity.DATA_SHARED_FLAGS_ID invisible: only the name tag draws (and
            // the outline of a glowing mob, LivingEntityRenderer.getRenderType).
            // A player keeps its armour, elytra and held items
            // (`LivingEntityRenderer.submit` skips only the body).
    // rust: let layers_only = mob.invisible && outline.is_none() && is_player;
    // rust: if mob.invisible && outline.is_none() && !layers_only {
    // rust: continue;
}
    // rust: let culling = if PRECHECK
    // rust: && outline.is_none()
    // rust: && !is_player
    // rust: && mob.kind.id.starts_with("minecraft:")
    // rust: && [
    // rust: &mob.extra.head,
    // rust: &mob.extra.chest,
    // rust: &mob.extra.legs,
    // rust: &mob.extra.feet,
    // rust: &mob.extra.main_hand,
    // rust: &mob.extra.off_hand,
    // rust: ]
    // rust: .iter()
    // rust: .all(|item| item.is_none())
    // rust: && beam.is_none()
    // rust: {
    // rust: self.entity_cull_decision(mob, alpha)
    // rust: } else {
    // rust: EntityCullDecision::CheckVertices
}
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let entity_start = out.len();
    // rust: self.mark_motion(entity_start, (1 << 32) | u64::from(mob.id));
    // rust: self.mark_entity(entity_start, &mob.kind.id);
    // rust: self.rendered_mobs.set(self.rendered_mobs.get() + 1);
    // rust: let light = self.world.light(
    // rust: mob.position.x.floor() as i32,
    // rust: (mob.position.y + mob.eye_height()).floor() as i32,
    // rust: mob.position.z.floor() as i32,
    // rust: );
    // rust: let mut packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
            // EntityRenderer.getBlockLightLevel: a burning mob has 15 block
            // light, and so do the Allay, Blaze, Magma Cube, Vex and Wither
            // renderers' overrides; the sky light stays the level's.
    // rust: if mob.fire_ticks > 0
    // rust: || matches!(
    // rust: mob.species(),
    // rust: Species::Allay
    // rust: | Species::Blaze
    // rust: | Species::MagmaCube
    // rust: | Species::Vex
    // rust: | Species::Wither
    // rust: )
    // rust: {
    // rust: packed = (packed & 0xFF) | ((15 * 16) << 8);
}
            // GlowSquidRenderer.getBlockLightLevel: the body brightens as the
            // dark ticks run out (the block light is the second byte).
    // rust: if mob.species() == Species::GlowSquid {
    // rust: let lit = (packed >> 12) & 15;
    // rust: let block = horizon_client::mobs::aquatic::glow_squid_block_light(mob, lit);
    // rust: packed = (packed & 0xFF) | ((block * 16) << 8);
}
            // A native mod's own model in place of the vanilla one
            // (`native_mob_submit`), before any of the vanilla model's parts
            // (a sulfur cube's swallowed block) are drawn.
            // A player's own hook (`native_player_submit`) is asked for the
            // other players in view.
    // rust: let who = is_player
    // rust: .then(|| self.remote_player_name(mob.id))
    // rust: .flatten()
    // rust: .map(|name| NativePlayerRender { name, local: false });
    // rust: let modded = if layers_only {
    // rust: false
    // rust: } else if let Some(who) = who {
    // rust: self.mod_player_geometry(mob, who, alpha as f32, camera, packed, out)
    // rust: } else {
    // rust: !is_player && self.mod_mob_geometry(mob, alpha as f32, camera, packed, out)
}
    // rust: if modded {
    // rust: if let Some(rgb) = outline {
    // rust: self.mark_outline(&out[entity_start..], rgb);
    // rust: if mob.invisible {
    // rust: out.truncate(entity_start);
    // rust: continue;
}
}
    // rust: if outline.is_none() {
    // rust: self.cull_entity_vertices(out, entity_start);
}
    // rust: continue;
}
    // rust: if mob.species() == Species::SulfurCube
    // rust: && !horizon_client::mobs::trader::is_invisible(mob)
    // rust: {
    // rust: self.sulfur_cube_body_geometry(
    // rust: mob,
    // rust: alpha as f32,
    // rust: horizon_client::mobs::render::base_transform(mob, alpha as f32, camera),
    // rust: packed,
    // rust: out,
    // rust: );
}
            // Other players on a server: PlayerRenderer's HumanoidArmorLayer.
    // rust: let armor = if is_player {
    // rust: self.worn_armor_layers(mob)
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let body = out.len();
            // The GPU path: an ordinary mob, no layers the CPU path changes after drawing them
            // (a player's, the HDR tiers below, the sulfur cube's shell). A glowing mob's
            // silhouette is posed too (`SkinFrame::outline_since`), unless it is invisible:
            // then only the outline draws.
    // rust: let silhouette_on_gpu = outline.is_none() || !mob.invisible;
    // rust: let posable = skinning
    // rust: && !is_player
    // rust: && !layers_only
    // rust: && silhouette_on_gpu
    // rust: && armor.is_empty()
    // rust: && !matches!(
    // rust: mob.species(),
    // rust: Species::Blaze | Species::MagmaCube | Species::GlowSquid | Species::SulfurCube
    // rust: );
    // rust: let mut skinned = None;
    // rust: if posable {
    // rust: let mut models = self.skin_models.borrow_mut();
    // rust: let mut frame = self.skin_frame.borrow_mut();
    // rust: let mark = frame.mark();
    // rust: let mut skin = horizon_client::mobs::skin::Skin::new(&mut models, &mut frame);
    // rust: horizon_client::mobs::render::render_skinned(
    // rust: mob,
    // rust: alpha as f32,
    // rust: camera,
    // rust: &lookup,
    // rust: packed,
    // rust: self.res.mob_data(),
    // rust: out,
    // rust: &mut skin,
    // rust: );
    // rust: skinned = Some((mark, skin.bounds));
    // rust: } else {
    // rust: let render = if layers_only {
    // rust: horizon_client::mobs::render::render_layers
    // rust: } else {
    // rust: horizon_client::mobs::render::render_with
}
    // rust: render(
    // rust: mob,
    // rust: alpha as f32,
    // rust: camera,
    // rust: &lookup,
    // rust: packed,
    // rust: self.res.mob_data(),
    // rust: &armor,
    // rust: out,
    // rust: );
}
            // HDR output: mobs that are light shine by their kind, as blocks do (entity.wgsl
            // fs_hdr_mark); a tier's window lifts only their bright texels.
    // rust: if let Some(tier) = match mob.species() {
    // rust: Species::Blaze => Some(horizon_client::mesher::BRIGHT),
    // rust: Species::MagmaCube | Species::GlowSquid => Some(horizon_client::mesher::LOW),
    // rust: _ => None,
    // rust: } {
    // rust: for v in &mut out[body..] {
    // rust: v.layer |= u32::from(tier) << 16;
}
}
            // AvatarRenderer.shouldRenderLayers: a spectator draws no layers.
    // rust: let layers = horizon_client::mobs::render::layers_shown(mob);
    // rust: if is_player && layers {
                // PlayerRenderer's CapeLayer, WingsLayer, ParrotOnShoulderLayer
                // and SpinAttackEffectLayer. Only the cape hides with the body;
                // the others have no `isInvisible` check.
    // rust: let chest = mob.extra.chest.as_deref();
    // rust: if !layers_only {
    // rust: self.player_cape_geometry(mob, chest, camera, alpha as f32, packed, out);
}
    // rust: if let Some((_, name)) = self
    // rust: .remote_player_names()
    // rust: .into_iter()
    // rust: .find(|(id, _)| *id == mob.id)
    // rust: {
    // rust: self.player_ears_geometry(mob, &name, camera, alpha as f32, packed, out);
}
    // rust: self.player_elytra_geometry(mob, chest, camera, alpha as f32, packed, out);
    // rust: self.shoulder_parrots_geometry(mob, camera, alpha as f32, packed, out);
    // rust: self.spin_attack_geometry(mob, camera, alpha as f32, packed, out);
    // rust: self.stuck_in_body_geometry(mob, mob.id as i32, camera, alpha as f32, packed, out);
}
            // Cosmetics (game/cosmetics.rs), posed on the GPU with the mob's own jobs: culled
            // with it.
    // rust: if !layers_only
    // rust: && horizon_cosmetics::enabled()
    // rust: && (is_player || &*mob.kind.id == "minecraft:mannequin")
    // rust: {
    // rust: let mark = self.skin_frame.borrow().mark();
    // rust: let base = horizon_client::mobs::render::base_transform(mob, alpha as f32, camera);
    // rust: let gpu = skinning;
    // rust: if let Some((lo, hi)) = self.cosmetics_geometry(
    // rust: mob,
    // rust: false,
    // rust: base,
    // rust: Some(camera),
    // rust: alpha as f32,
    // rust: packed,
    // rust: gpu,
    // rust: out,
    // rust: ) {
    // rust: skinned = Some(match skinned {
    // rust: Some((first, Some((l, h)))) => (first, Some((l.min(lo), h.max(hi)))),
    // rust: Some((first, None)) => (first, Some((lo, hi))),
    // rust: None => (mark, Some((lo, hi))),
    // rust: });
}
}
            // CustomHeadLayer (a pumpkin, skull or head item) included.
    // rust: if layers {
                // Held items join the GPU path's draws, their silhouette too.
    // rust: let skin = (skinning && silhouette_on_gpu).then_some(&mut skinned);
    // rust: self.mob_block_geometry(mob, camera, alpha, packed, skin, out);
                // `native_mob_layer`: a native mod's layer, over the vanilla ones.
    // rust: self.mod_mob_layer_geometry(mob, who, alpha as f32, camera, packed, out);
}
    // rust: if let Some(rgb) = outline {
    // rust: self.mark_outline(&out[entity_start..], rgb);
    // rust: if let Some(((first, _, _), _)) = skinned {
    // rust: let color = horizon_client::mobs::render::abgr(rgb);
    // rust: self.skin_frame.borrow_mut().outline_since(first, color);
}
    // rust: if mob.invisible {
    // rust: out.truncate(entity_start);
    // rust: continue;
}
}
            // Glowing outlines and a guardian's beam remain visible independently
            // of whether the body is hidden behind terrain.
    // rust: if outline.is_none() && culling.checks_vertices() && beam.is_none() {
                // What the GPU draws of the mob counts by its bounds' corners.
    // rust: self.cull_skinned(out, entity_start, skinned);
}
            // GuardianRenderer: the laser to the locked target.
    // rust: if let Some((time, scale)) = beam
    // rust: && let Some(target) = self.beam_target(mob.ai.target, alpha)
    // rust: && let Some(uv) = lookup("entity/guardian/guardian_beam")
    // rust: {
    // rust: let a = alpha;
    // rust: let eye = glam::DVec3::new(
    // rust: mob.previous.x + (mob.position.x - mob.previous.x) * a,
    // rust: mob.previous.y + (mob.position.y - mob.previous.y) * a + mob.eye_height(),
    // rust: mob.previous.z + (mob.position.z - mob.previous.z) * a,
    // rust: ) - camera;
    // rust: horizon_client::mobs::guardian::beam_geometry(
    // rust: eye.as_vec3(),
    // rust: (target - camera).as_vec3(),
    // rust: time,
    // rust: scale,
    // rust: uv,
    // rust: out,
    // rust: );
}
}
        // What follows isn't a tracked mob: close the last one's span.
    // rust: self.mark_motion(out.len(), 0);
    // rust: self.elder_apparition_geometry(alpha, out);
    // rust: self.spawner_geometry(camera, alpha, out);
        // Projectiles: the baked vanilla arrow model, the rest as item billboards.
    // rust: let (right, up) = thrown_item_axes(self.camera_type, self.yaw, self.pitch);
    // rust: let live = self.creatures.projectiles.iter().map(|a| {
    // rust: let at = [
    // rust: a.previous.x + (a.position.x - a.previous.x) * alpha,
    // rust: a.previous.y + (a.position.y - a.previous.y) * alpha,
    // rust: a.previous.z + (a.position.z - a.previous.z) * alpha,
    // rust: ];
    // rust: (a, at)
    // rust: });
        // ItemPickupParticle: a picked-up arrow flying to its collector.
    // rust: let taken = self.pickups.live.iter().filter_map(|p| match &p.taken {
    // rust: super::pickups::Taken::Arrow(a) => Some((&**a, super::pickups::position(p, alpha))),
    // rust: _ => None,
    // rust: });
        // A glowing projectile's outline: what it drew up to the next one.
    // rust: let mut glowing = None;
    // rust: for (a, at) in live.chain(taken) {
    // rust: if let Some((start, rgb)) = glowing.take() {
    // rust: self.mark_outline(&out[start..], rgb);
}
    // rust: if a.id != 0
    // rust: && let Some(rgb) = self.thing_outline(a.id, a.kind.id())
    // rust: {
    // rust: glowing = Some((out.len(), rgb));
}
    // rust: let p = glam::DVec3::from_array(at) - camera;
    // rust: let c = p.as_vec3();
            // EntityRenderer.getPackedLightCoords: the block its light probe
            // (the eye) is in, not the one under its feet.
    // rust: let light = self.world.light(
    // rust: a.position.x.floor() as i32,
    // rust: a.light_probe_y().floor() as i32,
    // rust: a.position.z.floor() as i32,
    // rust: );
    // rust: let mut packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
            // EntityRenderer.getBlockLightLevel: a shulker bullet and anything
            // on fire are drawn at 15 block light (the fireball renderers'
            // own override); the sky light stays the level's.
    // rust: if let Some(block) = a.block_light_override() {
    // rust: packed = (packed & 0xFF) | (u32::from(block) * 16) << 8;
}
    // rust: if a.is_arrow() {
    // rust: let Some(model) = self.arrow_model.as_ref() else {
    // rust: continue;
}
                // SpectralArrowRenderer, and TippableArrowRenderer's `getColor() > 0`.
    // rust: let texture = if a.is_spectral_arrow() {
    // rust: "entity/projectiles/arrow_spectral"
    // rust: } else if a.arrow.as_ref().is_some_and(|s| s.effect_color > 0) {
    // rust: "entity/projectiles/arrow_tipped"
    // rust: } else {
    // rust: "entity/projectiles/arrow"
}
    // rust: let Some(r) = atlas.sprites.get(texture).copied() else {
    // rust: continue;
}
                // ArrowRenderer: `Mth.lerp(partialTick, state.yRotO, state.yRot)`
                // and the same for the pitch, so a turning arrow is drawn
                // between the two ticks it turned over.
    // rust: let alpha32 = alpha as f32;
    // rust: let yaw = a.previous_yaw + alpha32 * (a.yaw - a.previous_yaw);
    // rust: let pitch = a.previous_pitch + alpha32 * (a.pitch - a.previous_pitch);
    // rust: let m = glam::Mat4::from_translation(c)
    // rust: * glam::Mat4::from_rotation_y((yaw - 90.0).to_radians())
    // rust: * glam::Mat4::from_rotation_z(pitch.to_radians());
                // ArrowRenderer: `state.shake = shakeTime - partialTicks`; ArrowModel.setupAnim
                // rolls the root while the shake timer runs.
    // rust: let shake = a
    // rust: .arrow
    // rust: .as_ref()
    // rust: .map_or(0.0, |s| s.shake as f32 - alpha as f32);
    // rust: let roll = if shake > 0.0 {
    // rust: -(shake * 3.0).msin() * shake * (std::f32::consts::PI / 180.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: let pose_for = |part: &horizon_client::mobs::Part| {
    // rust: let mut pose = part.pose;
    // rust: if std::ptr::eq(part, model) {
    // rust: pose[5] += roll;
}
    // rust: pose
}
    // rust: horizon_client::mobs::render_model(
    // rust: model,
    // rust: m,
    // rust: &pose_for,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: if a.arrow.as_ref().is_some_and(|s| s.on_fire()) {
    // rust: flame_geometry(atlas, c, 0.5, 0.5, self.yaw, light, out);
}
    // rust: continue;
}
            // ThrownTridentRenderer.
    // rust: if matches!(a.kind, ProjectileKind::Trident) {
    // rust: let Some(model) = self.trident_model.as_ref() else {
    // rust: continue;
}
    // rust: let Some(r) = atlas.sprites.get("entity/trident/trident").copied() else {
    // rust: continue;
}
    // rust: let m = glam::Mat4::from_translation(c)
    // rust: * glam::Mat4::from_rotation_y((a.yaw - 90.0).to_radians())
    // rust: * glam::Mat4::from_rotation_z((a.pitch + 90.0).to_radians());
    // rust: let poses = horizon_client::mobs::anim::Poses::new(model);
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: m,
    // rust: &poses,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: continue;
}
            // WindChargeRenderer.
    // rust: if matches!(
    // rust: a.kind,
    // rust: ProjectileKind::WindCharge | ProjectileKind::BreezeWindCharge
    // rust: ) {
    // rust: self.wind_charge_geometry(a, c, packed, alpha as f32, out);
    // rust: continue;
}
            // ShulkerBulletRenderer: the tumbling bullet model, then a larger
            // translucent copy of it (colour 0x26FFFFFF); always 15 block light.
    // rust: if matches!(a.kind, ProjectileKind::ShulkerBullet { .. }) {
    // rust: let model = &self.entity_models.shulker_bullet;
    // rust: if let (Some(model), Some(r)) =
    // rust: (model, atlas.sprites.get("entity/shulker/spark").copied())
    // rust: {
//                     use horizon_core::geometry::trig;
    // rust: let tc = a.age as f32 + alpha as f32;
    // rust: let mut poses = horizon_client::mobs::anim::Poses::new(model);
    // rust: poses.yrot("main", a.yaw.to_radians());
    // rust: poses.xrot("main", a.pitch.to_radians());
    // rust: let light = (packed & 0xFF) | ((15 * 16) << 8);
    // rust: let base = glam::Mat4::from_translation(c)
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.15, 0.0))
    // rust: * glam::Mat4::from_rotation_y(
    // rust: (trig::sin(f64::from(tc * 0.1)) * 180.0).to_radians(),
    // rust: )
    // rust: * glam::Mat4::from_rotation_x(
    // rust: (trig::cos(f64::from(tc * 0.1)) * 180.0).to_radians(),
    // rust: )
    // rust: * glam::Mat4::from_rotation_z(
    // rust: (trig::sin(f64::from(tc * 0.15)) * 360.0).to_radians(),
    // rust: )
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-0.5, -0.5, 0.5));
    // rust: let uv = [r.u0, r.v0, r.u1, r.v1];
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: light,
    // rust: 0,
    // rust: out,
    // rust: );
                    // The translucent shell blends over the opaque core
                    // (`RenderTypes.entityTranslucent`).
    // rust: let shell = out.len();
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base * glam::Mat4::from_scale(glam::Vec3::splat(1.5)),
    // rust: &poses,
    // rust: uv,
    // rust: 0x26FF_FFFF,
    // rust: light,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: horizon_client::gfx::mark_oit(&mut out[shell..]);
}
    // rust: continue;
}
            // WitherSkullRenderer: the skull model facing its flight.
    // rust: if let Some(dangerous) = super::wither::skull_kind(a) {
    // rust: let model = &self.entity_models.wither_skull;
    // rust: let tex = if dangerous {
    // rust: "entity/wither/wither_invulnerable"
    // rust: } else {
    // rust: "entity/wither/wither"
}
    // rust: if let (Some(model), Some(r)) = (model, atlas.sprites.get(tex).copied()) {
    // rust: let mut poses = horizon_client::mobs::anim::Poses::new(model);
    // rust: poses.yrot("head", a.yaw.to_radians());
    // rust: poses.xrot("head", a.pitch.to_radians());
    // rust: let base = glam::Mat4::from_translation(c)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0));
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: [r.u0, r.v0, r.u1, r.v1],
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
}
    // rust: continue;
}
    // rust: if let Some(stack) = a.drawn_item() {
    // rust: let owner = super::item_draw::owner_at(at, 0.0, a.kind.id());
    // rust: let state = self.resolve_item(&stack, DisplayContext::Ground, Some(&owner), 0);
    // rust: let pose = glam::Mat4::from_translation(c)
    // rust: * glam::Mat4::from_quat(self.camera_orientation());
    // rust: self.submit_item_world(&state, pose, packed, out);
    // rust: continue;
}
            // `Entity.displayFireAnimation`: a thrown item that flew through a
            // fire block burns (`ThrowableProjectile.tick`'s
            // `applyEffectsFromBlocks`), and ThrownItemRenderer draws the flame
            // over its box as any other entity renderer does.
    // rust: if a.on_fire() {
    // rust: let size = a.kind.size() as f32;
    // rust: flame_geometry(atlas, c, size, size, self.yaw, light, out);
}
            // `ThrownItemRenderer` for a fireball: the item `Fireball.getItem`
            // returns (a fire charge until `setItem` gave it another), its model
            // at the renderer's scale for the kind. `packed` is already 15, the
            // renderer's full bright.
    // rust: if let Some(stack) = a.item.as_ref() {
    // rust: let owner = super::item_draw::owner_at(at, 0.0, a.kind.id());
    // rust: let state = self.resolve_item(stack, DisplayContext::Ground, Some(&owner), 0);
    // rust: let pose = glam::Mat4::from_translation(c)
    // rust: * glam::Mat4::from_quat(self.camera_orientation())
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(a.sprite_scale()));
    // rust: self.submit_item_world(&state, pose, packed, out);
    // rust: continue;
}
    // rust: let Some(name) = a.item_sprite() else {
    // rust: continue;
}
    // rust: let Some(r) = atlas.sprites.get(name).copied() else {
    // rust: continue;
}
    // rust: let lift = is_item_billboard(&a.kind);
    // rust: let quad = thrown_item_quad(c, right, up, a.sprite_scale(), lift);
    // rust: for (v, uv) in quad
    // rust: .iter()
    // rust: .zip([[r.u0, r.v1], [r.u1, r.v1], [r.u1, r.v0], [r.u0, r.v0]])
    // rust: {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: v.to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light: packed,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: if let Some((start, rgb)) = glowing {
    // rust: self.mark_outline(&out[start..], rgb);
}
}
}
// `ThrownItemRenderer.submit` turns the item by `CameraRenderState.orientation`
// (`Camera.setRotation`): the billboard's right and up axes are the camera's.
// They stay continuous at pitch ±90, and in third-person front view they are
// the turned-round camera's, not the player's.
    // rust: fn thrown_item_axes(
    // rust: camera_type: super::perspective::CameraType,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: ) -> (glam::Vec3, glam::Vec3) {
    // rust: let orientation = super::camera_rotation(camera_type, yaw, pitch);
    // rust: (orientation * glam::Vec3::X, orientation * glam::Vec3::Y)
}
// The four corners of the item billboard, in the order its UVs are laid out.
// `ThrownItemRenderer` only scales and billboards it; the lift is
// `item/generated`'s ground display transform, `translation [0, 2, 0]` of 16
// units = 0.125 blocks, which is `0.125 * scale` == `0.5 * s`.
    // rust: fn thrown_item_quad(
    // rust: at: glam::Vec3,
    // rust: right: glam::Vec3,
    // rust: up: glam::Vec3,
    // rust: scale: f32,
    // rust: lift: bool,
    // rust: ) -> [glam::Vec3; 4] {
    // rust: let s = 0.25 * scale;
    // rust: let rise = if lift { 0.5 * s } else { 0.0 };
    // rust: let centre = at + up * rise;
    // rust: [(-1.0, -1.0), (1.0, -1.0), (1.0, 1.0), (-1.0, 1.0)]
    // rust: .map(|k| centre + right * k.0 * s + up * k.1 * s)
}
// Whether vanilla draws the kind as `ThrownItemRenderer`'s item billboard, the
// only ones that take that lift. Llama spit shares this quad but
// `LlamaSpitRenderer` is a model, with its own offset, and a fireball's item
// is drawn as the item model that carries the lift itself.
is_item_billboard :: proc(kind: ^ProjectileKind) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: kind,
    // rust: ProjectileKind::Snowball | ProjectileKind::Egg | ProjectileKind::EnderPearl
    // rust: )
}
// `Bucketable.getBucketItemStack` and `getPickupSound` of a mob that a water
// bucket picks up.
bucketable :: proc(species: Species) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let fish = "minecraft:item.bucket.fill_fish";
    // rust: Some(match species {
    // rust: Species::Cod => ("minecraft:cod_bucket", fish),
    // rust: Species::Salmon => ("minecraft:salmon_bucket", fish),
    // rust: Species::Pufferfish => ("minecraft:pufferfish_bucket", fish),
    // rust: Species::TropicalFish => ("minecraft:tropical_fish_bucket", fish),
    // rust: Species::Tadpole => (
    // rust: "minecraft:tadpole_bucket",
    // rust: "minecraft:item.bucket.fill_tadpole",
    // rust: ),
    // rust: Species::Axolotl => (
    // rust: "minecraft:axolotl_bucket",
    // rust: "minecraft:item.bucket.fill_axolotl",
    // rust: ),
    // rust: _ => return None,
    // rust: })
}
// The damage type id of a mob's damage source (`DamageSources.explosion`: a
// blast with a causing entity is `player_explosion` whoever it is, an
// exploding creeper too).
    // rust: pub(super) fn source_damage_type(d: Damage) -> &'static str {
    // rust: damage_type(d.kind, d.attacker.is_some())
}
// Whether the causing entity deals `kind` itself, so it is the source's
// direct entity too: a melee hit (`DamageSources.mobAttack`, `playerAttack`,
// a mace's or a spear's), a sting, a sonic boom, thorns.
    // rust: pub(super) fn melee(kind: horizon_client::mobs::DamageKind) -> bool {
//     use horizon_client::mobs::DamageKind as K;
    // rust: matches!(
    // rust: kind,
    // rust: K::PlayerAttack
    // rust: | K::MaceSmash
    // rust: | K::Spear
    // rust: | K::MobAttack
    // rust: | K::Sting
    // rust: | K::SonicBoom
    // rust: | K::Thorns
    // rust: )
}
// The damage type id of a Horizon damage kind. `caused`: the source has a
// causing entity (only a blast asks).
    // rust: pub(super) fn damage_type(kind: horizon_client::mobs::DamageKind, caused: bool) -> &'static str {
//     use horizon_client::mobs::DamageKind as K;
    // rust: match kind {
    // rust: K::Named(named) => named.name,
    // rust: K::PlayerAttack => "minecraft:player_attack",
    // rust: K::MaceSmash => "minecraft:mace_smash",
    // rust: K::Spear => "minecraft:spear",
    // rust: K::MobAttack => "minecraft:mob_attack",
    // rust: K::Arrow => "minecraft:arrow",
    // rust: K::Thrown => "minecraft:thrown",
    // rust: K::Fireball => "minecraft:fireball",
    // rust: K::Explosion if caused => "minecraft:player_explosion",
    // rust: K::Explosion => "minecraft:explosion",
    // rust: K::Fall => "minecraft:fall",
    // rust: K::FallingBlock => "minecraft:falling_block",
    // rust: K::FallingStalactite => "minecraft:falling_stalactite",
    // rust: K::OnFire => "minecraft:on_fire",
    // rust: K::InFire => "minecraft:in_fire",
    // rust: K::Campfire => "minecraft:campfire",
    // rust: K::Lava => "minecraft:lava",
    // rust: K::Drown => "minecraft:drown",
    // rust: K::DryOut => "minecraft:dry_out",
    // rust: K::Magic => "minecraft:magic",
    // rust: K::IndirectMagic => "minecraft:indirect_magic",
    // rust: K::Sting => "minecraft:sting",
    // rust: K::Cactus => "minecraft:cactus",
    // rust: K::SweetBerryBush => "minecraft:sweet_berry_bush",
    // rust: K::Generic => "minecraft:generic",
    // rust: K::InWall => "minecraft:in_wall",
    // rust: K::Thorns => "minecraft:thorns",
    // rust: K::SonicBoom => "minecraft:sonic_boom",
    // rust: K::Freeze => "minecraft:freeze",
    // rust: K::OutOfWorld => "minecraft:out_of_world",
    // rust: K::Cramming => "minecraft:cramming",
    // rust: K::FallingAnvil => "minecraft:falling_anvil",
    // rust: K::Fireworks => "minecraft:fireworks",
    // rust: K::GenericKill => "minecraft:generic_kill",
    // rust: K::LightningBolt => "minecraft:lightning_bolt",
    // rust: K::OutsideBorder => "minecraft:outside_border",
    // rust: K::Spit => "minecraft:spit",
    // rust: K::Stalagmite => "minecraft:stalagmite",
    // rust: K::Starve => "minecraft:starve",
    // rust: K::HotFloor => "minecraft:hot_floor",
    // rust: K::SulfurCubeHot => "minecraft:sulfur_cube_hot",
    // rust: K::WindCharge => "minecraft:wind_charge",
    // rust: K::Wither => "minecraft:wither",
    // rust: K::WitherSkull => "minecraft:wither_skull",
}
}
// A Horizon item stack as a loot stack (id, count, damage, enchantments).
to_loot :: proc(stack: ^ItemStack) -> h {
    // Ported from Horizon
    return {}
}
    // rust: horizon_world::loot::LootStack {
    // rust: item: stack.item.to_string(),
    // rust: count: stack.count as i32,
    // rust: damage: stack.damage as i32,
    // rust: enchantments: stack
    // rust: .enchantments()
    // rust: .iter()
    // rust: .map(|(e, l)| (e.to_string(), *l as i32))
    // rust: .collect(),
    // rust: potion: None,
    // rust: map: false,
    // rust: exploration: None,
    // rust: ominous_amplifier: None,
    // rust: stew_effects: Vec::new(),
    // rust: names: Vec::new(),
    // rust: components: Vec::new(),
}
}
// A generated loot stack as a Horizon item stack.
from_loot :: proc(stack: ^horizon_world::loot::LootStack) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut item = ItemStack {
    // rust: item: Arc::from(stack.item.as_str()),
    // rust: count: stack.count.max(1) as u32,
    // rust: damage: stack.damage.max(0) as u32,
    // rust: extra: None,
}
    // rust: for (id, level) in &stack.enchantments {
    // rust: item.enchant(id, (*level).max(0) as u32);
}
    // rust: if let Some(potion) = &stack.potion {
    // rust: item = item.with_potion(potion);
}
    // rust: if let Some(amplifier) = stack.ominous_amplifier.filter(|a| *a > 0) {
    // rust: item.data_mut().ominous_amplifier = Some(amplifier as u8);
}
    // rust: for (id, text) in &stack.names {
    // rust: item.data_mut().set_loot_name(id, text);
}
    // rust: for (id, value) in &stack.components {
    // rust: item.data_mut().set_loot_component(id, value);
}
    // rust: item
}
    // rust: impl Game<'_> {
    // The rest of `NetherPortalBlock.randomTick` after a won roll: with a
    // player close enough for spawning, a zombified piglin spawns on the block
    // under the portal column when it is a valid spawn.
    // rust: pub(super) fn portal_spawn(&mut self, pos: [i32; 3]) {
        // ChunkMap.anyPlayerCloseEnoughForSpawning: a non-spectator within 128
        // blocks of the chunk centre.
    // rust: let centre = [
    // rust: f64::from((pos[0] >> 4) * 16 + 8),
    // rust: f64::from((pos[2] >> 4) * 16 + 8),
    // rust: ];
    // rust: let close = self.level_players().iter().any(|p| {
    // rust: let (dx, dz) = (p.position.x - centre[0], p.position.z - centre[1]);
    // rust: !p.spectator && dx * dx + dz * dz < 16384.0
    // rust: });
    // rust: if !close {
    // rust: return;
}
    // rust: let mut y = pos[1];
    // rust: while &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], y, pos[2]))
    // rust: .name
    // rust: == "minecraft:nether_portal"
    // rust: {
    // rust: y -= 1;
}
        // isValidSpawn: a sturdy top face (portal frames emit no light).
    // rust: let below = self.res.facts().get(self.world.block(pos[0], y, pos[2]));
    // rust: if below.sturdy_full & (1 << 1) == 0 {
    // rust: return;
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(y + 1),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
        // setPortalCooldown: the new piglin does not travel at once.
    // rust: if let Some(id) = self.spawn_mob("minecraft:zombified_piglin", at, false) {
    // rust: self.set_portal_cooldown(id);
}
}
}
// `LivingEntity.knockback` on `p`: [`Game::knock_back_player`]; 1.8.9's
// `EntityLivingBase.knockBack` under `legacy` rules.
    // rust: fn knock_back(
    // rust: p: &mut horizon_client::motion::PlayerMotion,
    // rust: random: &mut horizon_core::random::LegacyRandom,
    // rust: power: f64,
    // rust: (xd, zd): (f64, f64),
    // rust: source: HurtSource<'_>,
    // rust: legacy: bool,
    // rust: ) {
    // rust: let resistance = p.attribute("minecraft:knockback_resistance").unwrap_or(0.0);
    // The native hook runs first, on the raw strength (`LivingKnockBackEvent`), then the
    // resistance scales what it left.
    // rust: let mut knock = Knock {
    // rust: strength: power,
    // rust: x: xd,
    // rust: z: zd,
}
    // rust: if knockback_canceled(Hurting::Player(p.entity_id, source), &mut knock) {
    // rust: return;
}
    // rust: let Knock {
    // rust: strength: power,
    // rust: x: mut xd,
    // rust: z: mut zd,
    // rust: } = knock;
    // rust: if legacy && horizon_client::legacy_combat::resists(resistance, random.next_double()) {
    // rust: return;
}
    // rust: let power = if legacy {
    // rust: power
    // rust: } else {
    // rust: power * (1.0 - resistance)
}
    // rust: if power <= 0.0 {
    // rust: return;
}
    // rust: while xd * xd + zd * zd < f64::from(1.0e-5_f32) {
    // rust: xd = (random.next_double() - random.next_double()) * 0.01;
    // rust: zd = (random.next_double() - random.next_double()) * 0.01;
}
    // rust: if legacy {
    // rust: let v = p.velocity;
    // rust: let [x, y, z] = horizon_client::legacy_combat::knockback([v.x, v.y, v.z], power, (xd, zd));
    // rust: p.velocity = Vec3::new(x, y, z);
    // rust: return;
}
    // rust: let l = (xd * xd + zd * zd).sqrt();
    // rust: let v = p.velocity;
    // rust: p.velocity = Vec3::new(
    // rust: v.x / 2.0 - xd / l * power,
    // rust: if p.ground.on_ground {
    // rust: (v.y / 2.0 + power).min(0.4)
    // rust: } else {
    // rust: v.y
    // rust: },
    // rust: v.z / 2.0 - zd / l * power,
    // rust: );
}

// The instance a mob effect gives the player; `None` for a creative or
// spectator player (`immune`) unless it is ambient (the nautilus's Breath).
    // rust: fn mob_effect_instance(
    // rust: effect: &'static str,
    // rust: ticks: i32,
    // rust: amplifier: i32,
    // rust: ambient: bool,
    // rust: immune: bool,
    // rust: ) -> Option<horizon_client::effects::EffectInstance> {
    // rust: if immune && !ambient {
    // rust: return None;
}
    // rust: let id = effect.strip_prefix("minecraft:").unwrap_or(effect);
    // rust: let mut instance = horizon_client::effects::EffectInstance::new(id, ticks, amplifier);
    // rust: instance.ambient = ambient;
    // rust: Some(instance)
}

    // rust: mod tests {
//     use super::super::perspective::CameraType;
//     use super::mob_effect_instance;
//     use super::thrown_item_axes;
//     use super::thrown_item_quad;
//     use super::{ProjectileKind, is_item_billboard};

    // The component-wise lowest and highest corner of the quad.
bounds :: proc(corners: ^[glam::Vec3; 4]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: corners.iter().copied().reduce(glam::Vec3::min).unwrap(),
    // rust: corners.iter().copied().reduce(glam::Vec3::max).unwrap(),
    // rust: )
}

nautilus_breath_lands_in_creative_as_ambient :: proc() {
}
        // AbstractNautilus.applyEffects: MobEffectInstance(BREATH_OF_THE_NAUTILUS,
        // 60, 0, ambient true, visible true, showIcon true), no game-mode gate.
    // rust: let e = mob_effect_instance("minecraft:breath_of_the_nautilus", 60, 0, true, true)
    // rust: .expect("applies to a creative player");
    // rust: assert_eq!(
    // rust: (e.id, e.duration, e.amplifier),
    // rust: ("breath_of_the_nautilus", 60, 0)
    // rust: );
    // rust: assert!(e.ambient && e.visible);
        // Survival gets the same ambient instance.
    // rust: let e =
    // rust: mob_effect_instance("minecraft:breath_of_the_nautilus", 60, 0, true, false).unwrap();
    // rust: assert!(e.ambient);
}

other_mob_effects_stay_blocked_in_creative :: proc() {
}
    // rust: assert!(mob_effect_instance("minecraft:poison", 140, 0, false, true).is_none());
    // rust: let e = mob_effect_instance("minecraft:poison", 140, 0, false, false).unwrap();
    // rust: assert!(!e.ambient);
}

thrown_item_billboard_lifts_by_the_generated_ground_transform :: proc() {
}
        // The kinds vanilla draws with `ThrownItemRenderer` as a billboard: the
        // only lifted ones. A fireball hands `getItem` to the item renderer
        // instead, which carries the ground transform itself.
    // rust: assert!(is_item_billboard(&ProjectileKind::Snowball));
    // rust: assert!(is_item_billboard(&ProjectileKind::Egg));
    // rust: assert!(is_item_billboard(&ProjectileKind::EnderPearl));
    // rust: assert!(!is_item_billboard(&ProjectileKind::SmallFireball));
    // rust: let large = ProjectileKind::LargeFireball { power: 1 };
    // rust: assert!(!is_item_billboard(&large));
        // A projectile at y = 100 with right = +X, up = +Y: the sprite sits
        // 0.125 blocks above the entity (2 of `item/generated`'s 16 units) and
        // stays 0.5 blocks wide, so the quad's y runs 99.875 .. 100.375.
    // rust: let at = glam::Vec3::Y * 100.0;
    // rust: let (right, up) = (glam::Vec3::X, glam::Vec3::Y);
    // rust: let lifted = is_item_billboard(&ProjectileKind::Snowball);
    // rust: let (lo, hi) = bounds(&thrown_item_quad(at, right, up, 1.0, lifted));
    // rust: assert_eq!((lo.y, hi.y), (99.875, 100.375));
    // rust: assert_eq!((lo.x, hi.x), (-0.25, 0.25));
        // Llama spit shares the quad here but is a model in vanilla
        // (`LlamaSpitRenderer`): no lift at all.
    // rust: let lifted = is_item_billboard(&ProjectileKind::LlamaSpit);
    // rust: assert!(!lifted);
    // rust: let (lo, hi) = bounds(&thrown_item_quad(at, right, up, 1.0, lifted));
    // rust: assert_eq!((lo.y, hi.y), (99.75, 100.25));
        // The rise follows the billboard's own up axis, not world up.
    // rust: let (right, up) = (glam::Vec3::Z, glam::Vec3::X);
    // rust: let lifted = is_item_billboard(&ProjectileKind::Egg);
    // rust: let (lo, hi) = bounds(&thrown_item_quad(at, right, up, 1.0, lifted));
    // rust: assert_eq!((lo.x, hi.x), (-0.125, 0.375));
    // rust: assert_eq!((lo.y, hi.y), (100.0, 100.0));
}

thrown_item_billboard_does_not_flip_at_straight_up_or_down :: proc() {
}
    // rust: for yaw in [0.0f32, 37.5, 90.0, 180.0, -135.0] {
    // rust: for (edge, near) in [(-90.0f32, -89.9f32), (90.0, 89.9)] {
    // rust: let (right_edge, up_edge) = thrown_item_axes(CameraType::FirstPerson, yaw, edge);
    // rust: let (right_near, up_near) = thrown_item_axes(CameraType::FirstPerson, yaw, near);
    // rust: assert!(
    // rust: right_edge.dot(right_near) > 0.99 && up_edge.dot(up_near) > 0.99,
    // rust: "yaw {yaw}, pitch {edge}: {right_edge}/{up_edge} vs {right_near}/{up_near} at {near}"
    // rust: );
}
}
}

thrown_item_billboard_faces_the_front_camera :: proc() {
}
        // Camera.setup turns the front camera round (yaw + 180, -pitch): its
        // right is the player's left.
    // rust: let (right, up) = thrown_item_axes(CameraType::FirstPerson, 0.0, 0.0);
    // rust: assert!(right.abs_diff_eq(glam::Vec3::NEG_X, 1e-5), "{right}");
    // rust: assert!(up.abs_diff_eq(glam::Vec3::Y, 1e-5), "{up}");
    // rust: let (right, up) = thrown_item_axes(CameraType::ThirdPersonFront, 0.0, 0.0);
    // rust: assert!(right.abs_diff_eq(glam::Vec3::X, 1e-5), "{right}");
    // rust: assert!(up.abs_diff_eq(glam::Vec3::Y, 1e-5), "{up}");
    // rust: let (right, _) = thrown_item_axes(CameraType::ThirdPersonBack, 0.0, 0.0);
    // rust: assert!(right.abs_diff_eq(glam::Vec3::NEG_X, 1e-5), "{right}");
}
}

// Whether the killing blow's causing entity (`DamageSource.getEntity`) was a
// mob, such as a tame wolf whose owner gets the kill credit.
killed_by_mob :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.last_damage
    // rust: .is_some_and(|(d, _)| matches!(d.attacker, Some(Who::Mob(_))))
}

// `Animal.finalizeSpawnChildFromBreeding`'s player: the one who fed the
// parent, or else the one who fed the partner (`getLoveCause`). `Some(None)`
// is the host, `Some(Some(conn))` a guest. Both animals are spent.
// `DyeColor.getMixedColor`: the colour of the crafting recipe that mixes
// the two dyes, else one of the two picked at random.
dye_mix :: proc(recipes: ^Recipes, random: ^impl RandomSource, a: u8, b: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(mixed) = dye_color_mix_in_recipes(recipes, a, b) {
    // rust: return mixed;
}
    // rust: if random.next_boolean() { a } else { b }
}

// `DyeColor.findColorMixInRecipes`: the dye colour a two-dye crafting recipe
// makes, when its result is a dye. The two dyes are the grid's first row
// (`CraftingInput.of(2, 1, ...)`) and the recipe manager answers for it; the
// result's `_dye` item names the colour.
dye_color_mix_in_recipes :: proc(recipes: ^Recipes, a: u8, b: u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let dye = |c: u8| {
    // rust: let name = horizon_client::mobs::render::DYE_NAMES[usize::from(c) & 15];
    // rust: Some(ItemStack::new(&format!("minecraft:{name}_dye"), 1))
}
    // rust: let grid = [dye(a), dye(b), None, None];
    // rust: let (_, result) = recipes.find(&grid, 2)?;
    // rust: let name = result
    // rust: .item
    // rust: .strip_prefix("minecraft:")?
    // rust: .strip_suffix("_dye")?;
    // rust: let index = horizon_client::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|n| *n == name)?;
    // rust: u8::try_from(index).ok()
}

    // rust: fn breeding_credit(
    // rust: love_cause: &mut std::collections::HashMap<u32, Option<u32>>,
    // rust: parent: u32,
    // rust: partner: u32,
    // rust: ) -> Option<Option<u32>> {
    // rust: let from_parent = love_cause.remove(&parent);
    // rust: let from_partner = love_cause.remove(&partner);
    // rust: from_parent.or(from_partner)
}

    // rust: mod shulker_arrow_tests {
//     use super::*;
//     use horizon_client::arrows::{ArrowEvent, deflect_reverse};
//     use horizon_core::random::LegacyRandom;

    // `AbstractArrow.onHitEntity` after `hurtOrSimulate` fails and the target
    // still takes a projectile's side effects: `deflect(REVERSE, …, 0.2)`,
    // and no hit sound. A closed shulker's refusal is that miss
    // (`shulker::tests`). An enderman's teleport is `Dodged`, not this.
a_refused_arrow_reverses_without_a_hit_sound :: proc() {
}
    // rust: assert_eq!(arrow_miss(false), EntityHit::Refused);
    // rust: assert_eq!(arrow_miss(true), EntityHit::Dodged);

    // rust: let mut arrow = Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: Vec3::new(0.0, 1.0, 0.0),
    // rust: Some(Who::Player),
    // rust: )
    // rust: .with_arrow_random(LegacyRandom::new(7));
    // rust: arrow.velocity = Vec3::new(3.0, -1.0, 2.0);
    // rust: arrow.yaw = 15.0;
    // rust: let mut oracle = LegacyRandom::new(7);
    // rust: let expect_yaw = 15.0 + 170.0 + oracle.next_float() * 20.0;
    // rust: let mut state = arrow.arrow.take().expect("an arrow");
    // rust: deflect_reverse(&mut arrow.velocity, &mut arrow.yaw, &mut state);
        // power 0.2, and REVERSE multiplies by -power * 0.5.
    // rust: assert!((arrow.velocity.x - -0.3).abs() < 1e-6);
    // rust: assert!((arrow.velocity.y - 0.1).abs() < 1e-6);
    // rust: assert!((arrow.velocity.z - -0.2).abs() < 1e-6);
    // rust: assert!((arrow.yaw - expect_yaw).abs() < 1e-4);
    // rust: assert!(!state.removed, "the reversed arrow stays in the world");
    // rust: assert!(
    // rust: state
    // rust: .events
    // rust: .iter()
    // rust: .all(|e| !matches!(e, ArrowEvent::Sound { .. })),
    // rust: "the deflect branch plays no hit sound"
    // rust: );
}
}

    // rust: mod breeding_tests {
//     use super::*;

the_player_who_fed_either_animal_is_credited :: proc() {
}
    // rust: let mut love = std::collections::HashMap::from([(1, Some(7)), (2, Some(9))]);
        // The parent's feeder first, and both animals are spent.
    // rust: assert_eq!(breeding_credit(&mut love, 1, 2), Some(Some(7)));
    // rust: assert!(love.is_empty());
        // Only the partner was fed: still credited.
    // rust: let mut love = std::collections::HashMap::from([(2, None)]);
    // rust: assert_eq!(breeding_credit(&mut love, 1, 2), Some(None));
        // Neither was fed by a player (a bred pair loaded from a save).
    // rust: assert_eq!(breeding_credit(&mut love, 1, 2), None);
}
}

    // rust: mod damage_type_tests {
//     use super::*;

named_damage_keeps_its_registry_id_with_or_without_an_attacker :: proc() {
}
    // rust: let named = horizon_client::mobs::NamedDamage::new(
    // rust: "example:fan_fire",
    // rust: horizon_client::mobs::NamedDamage::IS_FIRE,
    // rust: );
    // rust: for attacker in [None, Some(Who::Mob(7)), Some(Who::Player)] {
    // rust: assert_eq!(
    // rust: source_damage_type(Damage {
    // rust: kind: DamageKind::Named(named),
    // rust: attacker,
    // rust: from: None,
    // rust: attacker_species: None,
    // rust: }),
    // rust: "example:fan_fire"
    // rust: );
}
}

    // `DamageSources.explosion`: a blast with a causing entity is
    // `player_explosion` whoever caused it, so an exploding creeper's too.
a_creeper_blast_is_a_player_explosion :: proc() {
}
    // rust: let blast = |attacker| Damage {
    // rust: kind: DamageKind::Explosion,
    // rust: attacker,
    // rust: from: Some([0.0; 3]),
    // rust: attacker_species: None,
}
    // rust: let creeper = blast(Some(Who::Mob(7)));
    // rust: assert_eq!(source_damage_type(creeper), "minecraft:player_explosion");
        // No causing entity.
    // rust: assert_eq!(source_damage_type(blast(None)), "minecraft:explosion");
        // The other kinds do not ask.
    // rust: let bite = Damage {
    // rust: kind: DamageKind::MobAttack,
    // rust: ..creeper
}
    // rust: assert_eq!(source_damage_type(bite), "minecraft:mob_attack");
}
}

    // rust: mod pearl_tests {
//     use super::*;

    // A pearl's water test is `Entity.isInWater`: `wasTouchingWater` from the
    // last `updateFluidInteraction`, water whose surface reaches its 0.25
    // box (#3072), not the block at its feet.
a_pearl_feels_the_water_its_box_touches :: proc() {
}
        // The throwable air drag is the float 0.99 widened to a double.
    // rust: let air = f64::from(0.99f32);
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists()
    // rust: || !root.join("movement-properties.nbt").exists()
    // rust: {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, registry).unwrap();
    // rust: let motion = horizon_client::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let data = horizon_client::mobs::MobData::load(&root, &facts);
    // rust: let biomes = horizon_client::biome::Biomes::load(&root).unwrap();
    // rust: let items = horizon_client::items::Items::load(
    // rust: &root,
    // rust: registry,
    // rust: &facts,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: let collision =
    // rust: std::sync::Arc::new(horizon_client::collisions::load(&root, registry).unwrap());
    // rust: let suffocation =
    // rust: horizon_client::mobs::suffocation::bind(collision.clone(), &motion.causes_suffocation)
    // rust: .unwrap();
    // rust: let mut world = horizon_client::world::World::test_scene(&assets, &render, 3).unwrap();
        // A pool of still water one block deep at y = 4, from x = 20 on (clear of the
        // scene's pyramid): its
        // surface is at 4 + 8/9.
    // rust: let water = registry.default_state("minecraft:water").unwrap();
    // rust: for x in 20..=40 {
    // rust: for z in 0..=2 {
    // rust: world.set(x, 4, z, water).unwrap();
}
}
    // rust: let lid_openers = std::collections::HashMap::new();
    // rust: let w = MobWorld {
    // rust: teams: Default::default(),
    // rust: world: &world,
    // rust: registry,
    // rust: facts: &facts,
    // rust: fluid_tables: &motion.fluids,
    // rust: movement: &motion.blocks,
    // rust: collision: &collision,
    // rust: suffocation: &suffocation,
    // rust: data: &data,
    // rust: player: None,
    // rust: controlling_player_movement: None,
    // rust: nearest_player: None,
    // rust: others: &[],
    // rust: dragon: None,
    // rust: leash_boats: &[],
    // rust: others_grid: None,
    // rust: others_index: None,
    // rust: others_villagers: None,
    // rust: daylight: true,
    // rust: monsters_burn: false,
    // rust: game_time: 1000,
    // rust: day_time: 1000,
    // rust: raining: false,
    // rust: thundering: false,
    // rust: nether: false,
    // rust: block_tags: &items.block_tags,
    // rust: landing: &motion.landing,
    // rust: biomes: &biomes,
    // rust: mob_griefing: true,
    // rust: universal_anger: false,
    // rust: mob_drops: true,
    // rust: max_entity_cramming: 24,
    // rust: difficulty: spawning::LocalDifficulty::new(2, 1000, 0, 0.0),
    // rust: end: false,
    // rust: world_seed: 0,
    // rust: sea_level: 63,
    // rust: items: Some(&items),
    // rust: lid_openers: &lid_openers,
    // rust: mod_effects: None,
    // rust: border: None,
}
    // rust: let pw = ProjWorld {
    // rust: w: &w,
    // rust: targets: Vec::new(),
    // rust: border: None,
}
    // rust: let pearl = |x: f64, y: f64, velocity: Vec3| {
    // rust: let mut p = Projectile::new(ProjectileKind::EnderPearl, Vec3::new(x, y, 1.5), None);
    // rust: p.velocity = velocity;
    // rust: p
}
        // Skimming the pool: its feet are in the water block, its box above
        // the surface. ThrowableProjectile.applyInertia keeps the air drag.
    // rust: let mut p = pearl(25.5, 4.95, Vec3::new(0.3, 0.0, 0.0));
    // rust: p.tick(&pw);
    // rust: assert!(p.position.y > 4.9, "the pearl dipped: {p:?}");
    // rust: p.tick(&pw);
    // rust: assert!(
    // rust: (p.velocity.x - 0.3 * air * air).abs() < 1e-9,
    // rust: "a pearl above the surface slowed as in water: {p:?}"
    // rust: );
        // At the pool's edge: its feet over the dry block at x = 19, a side
        // of its box in the water at x = 20. The water drag after the first
        // tick, which still reads `wasTouchingWater` as false.
    // rust: let mut p = pearl(19.95, 4.3, Vec3::ZERO);
    // rust: p.tick(&pw);
    // rust: assert!(
    // rust: (p.velocity.y - (-0.03 * air)).abs() < 1e-9,
    // rust: "the first tick has the air drag: {p:?}"
    // rust: );
    // rust: p.tick(&pw);
    // rust: assert!(
    // rust: (p.velocity.y - (-0.03 * air - 0.03) * 0.8).abs() < 1e-9,
    // rust: "a pearl whose box is in the water kept the air drag: {p:?}"
    // rust: );
        // Thrown under water, a pearl moves with the air drag on its first
        // tick and the water drag after it.
    // rust: let mut p = pearl(30.5, 4.2, Vec3::ZERO);
    // rust: p.tick(&pw);
    // rust: assert!(
    // rust: (p.velocity.y - (-0.03 * air)).abs() < 1e-9,
    // rust: "the first tick under water has the air drag: {p:?}"
    // rust: );
    // rust: p.tick(&pw);
    // rust: assert!(
    // rust: (p.velocity.y - (-0.03 * air - 0.03) * 0.8).abs() < 1e-9,
    // rust: "the second tick under water has the water drag: {p:?}"
    // rust: );
}
}

    // rust: mod knockback_tests {
//     use super::*;
//     use horizon_client::health::KNOCKBACK;

    // What the hook of these tests saw: the player, its source (as damage
    // type, causing, direct) and the push.
    // rust: type Pushes = std::sync::Mutex<Vec<(i32, (String, i32, i32), Knock)>>;
PUSHES :: std::sync::Mutex::new(Vec::new())

    // Sets the native knockback hook of these tests (global: it stays set for
    // the process) for players 9201 to 9203: it records the push, cancels
    // 9201's and doubles 9202's strength and turns its direction around.
hook :: proc(pushed: Hurting<'_>, knock: ^Knock) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Hurting::Player(entity @ 9201..=9203, s) = pushed else {
    // rust: return false;
}
    // rust: let source = (s.damage_type.to_owned(), s.causing, s.direct);
    // rust: PUSHES.lock().unwrap().push((entity, source, *knock));
    // rust: match entity {
    // rust: 9201 => return true,
    // rust: 9202 => {
    // rust: knock.strength *= 2.0;
    // rust: knock.z = -knock.z;
}
    // rust: _ => {}
}
    // rust: false
}

    // `LivingEntity.knockback` on a player: the hook runs before the
    // knockback resistance and the motion changes; a mod's strength or
    // direction pushes, a cancel pushes nothing, and without a mod in the way
    // the push is vanilla's. Needs the prepared data in
    // `.local/horizon-client/26.3`; skipped without it.
the_native_knockback_hook_changes_or_cancels_a_players_push :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let installed = *KNOCKBACK.get_or_init(|| hook);
    // rust: assert!(std::ptr::fn_addr_eq(
    // rust: installed,
    // rust: hook as fn(Hurting<'_>, &mut Knock) -> bool
    // rust: ));
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let resources = horizon_client::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut random = horizon_core::random::LegacyRandom::new(1);
    // rust: let hit = HurtSource {
    // rust: damage_type: "minecraft:player_attack",
    // rust: causing: 5,
    // rust: direct: 5,
}
    // rust: let mut push = |entity, resistance: f64| {
    // rust: let mut p = horizon_client::motion::PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: p.entity_id = entity;
    // rust: p.ground.on_ground = true;
    // rust: if resistance != 0.0 {
    // rust: let attribute = "minecraft:knockback_resistance";
    // rust: let set = p.set_modifier(attribute, "horizon:test", resistance, "add_value", true);
    // rust: set.unwrap();
}
    // rust: knock_back(&mut p, &mut random, 0.4, (0.0, 3.0), hit, false);
    // rust: (p.velocity.x, p.velocity.y, p.velocity.z)
}
        // No mod in the way: vanilla's push, away from z = 3.
    // rust: assert_eq!(push(9200, 0.0), (0.0, 0.4, -0.4));
        // Canceled: no motion. The hook saw the push and the hit.
    // rust: assert_eq!(push(9201, 0.0), (0.0, 0.0, 0.0));
    // rust: let made = Knock {
    // rust: strength: 0.4,
    // rust: x: 0.0,
    // rust: z: 3.0,
}
    // rust: let named = ("minecraft:player_attack".to_owned(), 5, 5);
    // rust: let seen = |entity| -> Vec<_> {
    // rust: let seen = PUSHES.lock().unwrap();
    // rust: seen.iter().filter(|p| p.0 == entity).cloned().collect()
}
    // rust: assert_eq!(seen(9201), [(9201, named, made)]);
        // Twice the strength, direction turned around.
    // rust: assert_eq!(push(9202, 0.0), (0.0, 0.4, 0.8));
        // Before the resistance (`LivingKnockBackEvent`): a 0.5 resistance still hands the hook
        // the raw strength, and the push that follows is halved.
    // rust: assert_eq!(push(9203, 0.5), (0.0, 0.2, -0.2));
    // rust: assert_eq!(seen(9203)[0].2.strength, 0.4);
}
}

    // rust: mod dye_mix_tests {
//     use super::*;

    // `DyeColor.getMixedColor` for the offspring a sheep, wolf or cat breed
    // gets: the colour of the crafting recipe that mixes its parents' two
    // dyes (vanilla's `crafting_shapeless` rows: red + yellow makes orange,
    // blue + green cyan, blue + red purple), and a pair no recipe mixes
    // keeps one of the two.
two_dyes_mix_by_their_crafting_recipe :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("data/minecraft/recipe").is_dir() {
    // rust: return;
}
    // rust: let registry = horizon_world::level::data::load_registry(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, &registry).unwrap();
    // rust: let overlay = horizon_world::loot::PackOverlay::NONE;
    // rust: let items = crate::items::Items::load(&root, &registry, &facts, &overlay).unwrap();
    // rust: let recipes = Recipes::load(&root, &items, &overlay).unwrap();
    // rust: let dye = |name: &str| {
    // rust: u8::try_from(
    // rust: horizon_client::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|n| *n == name)
    // rust: .unwrap_or_else(|| panic!("{name} is not a dye colour")),
    // rust: )
    // rust: .unwrap()
}
    // rust: let mut random = horizon_core::random::LegacyRandom::new(1);
    // rust: for (first, second, mixed) in [
    // rust: ("red", "yellow", "orange"),
    // rust: ("blue", "green", "cyan"),
    // rust: ("blue", "red", "purple"),
    // rust: ("green", "white", "lime"),
    // rust: ] {
    // rust: let (a, b, made) = (dye(first), dye(second), dye(mixed));
    // rust: assert_eq!(
    // rust: dye_color_mix_in_recipes(&recipes, a, b),
    // rust: Some(made),
    // rust: "{first} + {second} makes {mixed}"
    // rust: );
            // The recipe answers, so the coin never has to.
    // rust: assert_eq!(dye_mix(&recipes, &mut random, a, b), made);
}
        // Two dyes that no recipe mixes keep one of the two colours.
    // rust: let (orange, cyan) = (dye("orange"), dye("cyan"));
    // rust: assert_eq!(dye_color_mix_in_recipes(&recipes, orange, cyan), None);
    // rust: let kept = dye_mix(&recipes, &mut random, orange, cyan);
    // rust: assert!(kept == orange || kept == cyan, "kept {kept}");
}
}

    // rust: mod conversion_tag_tests {
//     use super::*;
//     use crate::game::{Audio, Options, Progress, Settings, commands::Target, load_resources};
//     use horizon_world::nbt::Tag;

converted_mobs_keep_command_tags_at_the_new_id_and_on_save :: proc() {
}
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
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: for (number, (from, to)) in [
    // rust: ("husk", "zombie"),
    // rust: ("zombie", "drowned"),
    // rust: ("skeleton", "stray"),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let uuid = [10374, 1, 0, number as i32];
    // rust: let tags = Tag::List(vec![
    // rust: Tag::String("subject".into()),
    // rust: Tag::String(from.into()),
    // rust: ]);
    // rust: let raw = Tag::compound([
    // rust: (
    // rust: "id",
    // rust: Tag::String(format!("minecraft:{from}").as_str().into()),
    // rust: ),
    // rust: ("UUID", Tag::IntArray(uuid.to_vec())),
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(vec![
    // rust: Tag::Double(0.5_f64.to_bits()),
    // rust: Tag::Double(70.0_f64.to_bits()),
    // rust: Tag::Double(0.5_f64.to_bits()),
    // rust: ]),
    // rust: ),
    // rust: ("NoAI", Tag::Byte(1)),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ("Tags", tags.clone()),
    // rust: ("horizon:old_entity_only", Tag::Byte(1)),
    // rust: ]);
    // rust: let old_id = game.load_mob(raw, None).unwrap();
    // rust: assert_eq!(game.tags_of(Target::Mob(old_id)), ["subject", from]);
    // rust: let source = game.mobs.iter().find(|m| m.id == old_id).unwrap().clone();
    // rust: let new_id = game
    // rust: .convert_to(
    // rust: &source,
    // rust: &format!("minecraft:{to}"),
    // rust: horizon_client::mobs::conversion::Params::KEEP_ALL,
    // rust: )
    // rust: .unwrap();
    // rust: assert_ne!(old_id, new_id);
    // rust: assert_eq!(
    // rust: game.tags_of(Target::Mob(new_id)),
    // rust: ["subject", from],
    // rust: "converted ID must keep tags"
    // rust: );
    // rust: let index = game.mobs.iter().position(|m| m.id == new_id).unwrap();
    // rust: let saved = game.mob_tree_nbt(index);
    // rust: assert_eq!(saved.get("Tags"), Some(&tags));
    // rust: assert_eq!(
    // rust: horizon_client::entity_nbt::kind(&saved).as_deref(),
    // rust: Some(format!("minecraft:{to}").as_str())
    // rust: );
    // rust: assert_ne!(horizon_client::entity_nbt::uuid(&saved), Some(uuid));
    // rust: assert!(saved.get("horizon:old_entity_only").is_none());
    // rust: game.mobs.remove(index);
    // rust: let reloaded = game.load_mob(saved, None).unwrap();
    // rust: assert_eq!(game.tags_of(Target::Mob(reloaded)), ["subject", from]);
}
}
}
