//! Transpiled from Horizon Rust crate
package horizon_client_lightning

import "core:fmt"
import "core:mem"
import "core:math"

// Lightning (`ServerLevel.tickThunder`, `LightningBolt`,
// `LightningBoltRenderer`): strikes on the highest motion-blocking block or
// a living entity under open sky nearby, skeleton trap horses, fire,
// `thunderHit` (damage and burning, charged creepers, zombified piglins,
// witches, mooshroom colours, turtles, burnt items), lightning rods, the sky
// flash, the sounds and the branching additive bolt.
// use super::{
    // rust: Game,
    // rust: commands::Target,
    // rust: entity::{
    // rust: Entity as _, EntityHandle, ThunderHit, entity_lists_of, for_each_entity, with_entity,
    // rust: },
}
// use horizon_client::advancements::EntityView;
// use horizon_client::mobs::{Damage, DamageKind, MobEvent, SpawnSetup, Species};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

    // rust: pub(super) struct Bolt {
    // The entity id a server's players know it by (0 until it has one).
    // rust: pub id: u32,
    // rust: pub at: [f64; 3],
    // rust: life: i32,
    // rust: flashes: i32,
    // rust: seed: i64,
    // rust: visual_only: bool,
    // Mooshrooms and copper golems change once per bolt.
    // rust: converted: Vec<u32>,
    // The mobs it has struck (`hitEntities`).
    // rust: hit: Vec<u32>,
    // The dropped items in the strike box (`hitEntities` holds every entity).
    // rust: hit_items: Vec<u32>,
    // Items a cushion dropped under it, spared for 20 ticks
    // (`Cushion.dropItem`: `setInvulnerableTime(20)`).
    // rust: spared: Vec<u32>,
    // Blocks it set on fire (`blocksSetOnFire`).
    // rust: fires: i32,
    // The player who channelled it (`LightningBolt.cause`): `Some(None)` for
    // the host, `Some(Some(conn))` for a guest.
    // rust: pub cause: Option<Option<u32>>,
}
// `Pig.thunderHit`: `SpawnSetup` for mobs converted by lightning, preserving baby state.
thunder_mob_spawn_setup :: proc(m: ^horizon_client::mobs::Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: SpawnSetup {
    // rust: baby: m.is_baby(),
    // rust: yaw: m.yaw,
    // rust: persistent: true,
    // rust: ..Default::default()
}
}

// The box `LightningBolt.tick` collects the `LightningStrikeTrigger` bystanders from: 15 blocks
// around the bolt, 15 down and `6 + 15` up.
in_viewer_box :: proc(bolt: [f64; 3], p: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (p[0] - bolt[0]).abs() <= 15.0
    // rust: && (p[2] - bolt[2]).abs() <= 15.0
    // rust: && p[1] >= bolt[1] - 15.0
    // rust: && p[1] <= bolt[1] + 21.0
}
    // rust: impl Game<'_> {
    // `ServerChunkCache.tickSpawningChunk`: one `tickThunder` roll per
    // spawning chunk (within 128 blocks of a player) that is in entity
    // ticking range.
    // rust: pub(super) fn tick_thunder(&mut self) {
        // isRaining (rain level > 0.2) and isThundering (> 0.9) both need
        // Level.canHaveWeather: sky light, no ceiling and not the End.
    // rust: let (rain, thunder) = self.world.weather.levels(1.0);
    // rust: let weather = self.world.shape.sky_light
    // rust: && !self.world.shape.has_ceiling
    // rust: && self.dim != super::Dim::End;
    // rust: if rain <= 0.2 || thunder <= 0.9 || !weather || self.world_debug {
    // rust: return;
}
    // rust: let mut scratch = std::mem::take(&mut self.spawn_scratch);
    // rust: self.spawning_chunks(&self.level_players(), &mut scratch);
    // rust: let levels = self.tickets.levels();
    // rust: scratch
    // rust: .candidates
    // rust: .retain(|&(x, z)| levels.random_ticking(x, z));
    // rust: for (cx, cz) in scratch.candidates.drain(..) {
    // rust: if self.world.random.next_int_bound(100_000).unwrap_or(1) != 0 {
    // rust: continue;
}
            // getBlockRandomPos(minX, 0, minZ, 15)
    // rust: let r = self.world.random.next_int();
    // rust: let (x, z) = (cx * 16 + (r & 15), cz * 16 + (r >> 16 & 15));
    // rust: let Some(pos) = self.lightning_target(x, z) else {
    // rust: continue;
}
    // rust: let p = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: if !self.with_level(|b, level, _| b.is_raining_at(level, p)) {
    // rust: continue;
}
            // Skeleton trap: the local effective difficulty / 100
            // (`getCurrentDifficultyAt(pos)`).
    // rust: let difficulty = f64::from(
    // rust: self.local_difficulty([f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])])
    // rust: .effective,
    // rust: );
    // rust: let below = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1] - 1, pos[2]))
    // rust: .name;
    // rust: let trap = self.ui.rules.bool("spawn_mobs")
    // rust: && self.world.random.next_double() < difficulty * 0.01
    // rust: && !below.ends_with("lightning_rod");
    // rust: if !self.lightning_strike_allowed(None, pos, "weather") {
    // rust: continue;
}
    // rust: if trap {
    // rust: let at = [f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])];
                // ServerLevel.tickChunk: a trap horse waits for a player.
    // rust: if let Some(id) = self.spawn_mob("minecraft:skeleton_horse", at, false)
    // rust: && let Some(h) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: h.extra.trap = true;
    // rust: h.extra.age = 0;
}
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.spawn_bolt(at, trap);
}
    // rust: self.spawn_scratch = scratch;
}
    // `ServerLevel.findLightningRod`: `PoiManager.findClosest` over the
    // lightning rod points of interest within 128 blocks of `center` whose
    // block is the top (`WORLD_SURFACE`) of its column; the strike lands one
    // above it. Horizon keeps no point-of-interest index, so this scans the
    // loaded chunks the way `/locate poi` does.
find_lightning_rod :: proc(self: ^Self, center: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
RANGE :: 128
    // rust: let facts = self.res.facts();
    // rust: let mut is_rod: std::collections::HashMap<u32, bool> = std::collections::HashMap::new();
    // rust: let mut best: Option<(i64, [i32; 3])> = None;
    // rust: let (cx0, cz0) = ((center[0] - RANGE) >> 4, (center[2] - RANGE) >> 4);
    // rust: let (cx1, cz1) = ((center[0] + RANGE) >> 4, (center[2] + RANGE) >> 4);
    // rust: for cx in cx0..=cx1 {
    // rust: for cz in cz0..=cz1 {
    // rust: let Some(chunk) = self.world.chunks.get(&(cx, cz)) else {
    // rust: continue;
}
    // rust: for (i, section) in chunk.sections.iter().enumerate() {
    // rust: let mut rod = |state: u32| {
    // rust: *is_rod.entry(state).or_insert_with(|| {
    // rust: facts
    // rust: .get(horizon_world::registry::BlockStateId(state))
    // rust: .name
    // rust: .ends_with("lightning_rod")
    // rust: })
}
    // rust: if !section.blocks.maybe_has(&mut rod) {
    // rust: continue;
}
    // rust: let base_y = self.world.bottom_y() + 16 * i as i32;
    // rust: for j in 0..4096 {
    // rust: if !rod(section.get(j)) {
    // rust: continue;
}
    // rust: let p = [
    // rust: cx * 16 + (j & 15) as i32,
    // rust: base_y + (j >> 8) as i32,
    // rust: cz * 16 + ((j >> 4) & 15) as i32,
    // rust: ];
    // rust: let d = [p[0] - center[0], p[1] - center[1], p[2] - center[2]]
    // rust: .map(|d| i64::from(d) * i64::from(d))
    // rust: .iter()
    // rust: .sum::<i64>();
    // rust: if d > i64::from(RANGE * RANGE) || best.is_some_and(|(b, _)| d >= b) {
    // rust: continue;
}
    // rust: let surface = self.world.world_surface(p[0], p[2], |s| facts.is_air(s));
    // rust: if p[1] == surface - 1 {
    // rust: best = Some((d, p));
}
}
}
}
}
    // rust: best.map(|(_, p)| [p[0], p[1] + 1, p[2]])
}
    // `findLightningTargetAround`: the closest lightning rod, else a living
    // entity under open sky in the column (3 blocks around), else the top of
    // the column.
lightning_target :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.world.loaded(x, z) {
    // rust: return None;
}
    // rust: let top =
    // rust: self.with_level(|b, level, _| b.motion_blocking_top(level, BlockPos::new(x, 0, z)));
    // rust: if let Some(rod) = self.find_lightning_rod([x, top.y, z]) {
    // rust: return Some(rod);
}
    // rust: let sees_sky = |g: &Self, p: [i32; 3]| g.world.light(p[0], p[1], p[2]) >> 4 == 15;
    // rust: let mut candidates: Vec<[i32; 3]> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| {
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
    // rust: })
    // rust: .filter(|p| (p[0] - x).abs() <= 3 && (p[2] - z).abs() <= 3 && p[1] >= top.y - 3)
    // rust: .filter(|p| sees_sky(self, *p))
    // rust: .collect();
    // rust: if let Some(p) = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| !p.health.dead_or_dying())
    // rust: .map(|p| {
    // rust: [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ]
    // rust: })
    // rust: && (p[0] - x).abs() <= 3
    // rust: && (p[2] - z).abs() <= 3
    // rust: && p[1] >= top.y - 3
    // rust: && sees_sky(self, p)
    // rust: {
    // rust: candidates.push(p);
}
    // rust: if !candidates.is_empty() {
    // rust: let i = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(candidates.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: return Some(candidates[i]);
}
    // rust: Some([x, top.y, z])
}
    // rust: pub(super) fn spawn_bolt(&mut self, at: [f64; 3], visual_only: bool) {
    // rust: if !visual_only {
    // rust: let ctx = horizon_client::sculk::Context::default();
    // rust: self.post_game_event("minecraft:lightning_strike", at, ctx);
}
    // rust: let r = &mut self.world.random;
    // rust: let seed = r.next_long();
    // rust: let flashes = r.next_int_bound(3).unwrap_or(0) + 1;
    // rust: self.lightning_seen[0] += 1;
    // rust: let id = self.take_entity_id();
    // rust: self.bolts.push(Bolt {
    // rust: id,
    // rust: at,
    // rust: life: 2,
    // rust: flashes,
    // rust: seed,
    // rust: visual_only,
    // rust: converted: Vec::new(),
    // rust: hit: Vec::new(),
    // rust: hit_items: Vec::new(),
    // rust: spared: Vec::new(),
    // rust: fires: 0,
    // rust: cause: None,
    // rust: });
}
    // rust: pub(super) fn lightning_strike_allowed(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: pos: [i32; 3],
    // rust: cause: &str,
    // rust: ) -> bool {
    // rust: let mut cancel = false;
    // rust: self.native_lightning_strike(player, pos, cause, &mut cancel);
    // rust: !cancel
}
    // `ClientLevel.addEntity` for a server's lightning bolt: on a client it
    // only flashes, sounds and draws (`LightningBolt.tick` off the server).
    // rust: pub(super) fn spawn_remote_bolt(&mut self, id: u32, at: [f64; 3]) {
    // rust: self.bolts.retain(|b| b.id != id);
    // rust: let r = &mut self.world.random;
    // rust: let seed = r.next_long();
    // rust: let flashes = r.next_int_bound(3).unwrap_or(0) + 1;
    // rust: self.lightning_seen[0] += 1;
    // rust: self.bolts.push(Bolt {
    // rust: id,
    // rust: at,
    // rust: life: 2,
    // rust: flashes,
    // rust: seed,
    // rust: visual_only: true,
    // rust: converted: Vec::new(),
    // rust: hit: Vec::new(),
    // rust: hit_items: Vec::new(),
    // rust: spared: Vec::new(),
    // rust: fires: 0,
    // rust: cause: None,
    // rust: });
}
    // `spawnFire`: fire at the strike point and `extra` random neighbours,
    // wherever `BaseFireBlock.getState` fire can survive. Returns how many
    // blocks it set on fire.
bolt_fire :: proc(self: ^Self, at: [f64; 3], extra: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut set = 0;
    // rust: let base = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: let mut spots = vec![base];
    // rust: for _ in 0..extra {
    // rust: let r = &mut self.world.random;
    // rust: let mut d = || r.next_int_bound(3).unwrap_or(1) - 1;
    // rust: spots.push([base[0] + d(), base[1] + d(), base[2] + d()]);
}
    // rust: for p in spots {
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: if !self.res.facts().is_air(state) {
    // rust: continue;
}
            // BaseFireBlock.getState and FireBlock/SoulFireBlock.canSurvive.
    // rust: let at = BlockPos::new(p[0], p[1], p[2]);
    // rust: let fire = self.with_level(|b, level, ticks| {
    // rust: let fire = b.fire_state_for(level, ticks, at);
    // rust: b.can_survive(level, ticks, at, fire).then_some(fire)
    // rust: });
    // rust: if let Some(fire) = fire {
    // rust: if !self.native_block_ignite_allowed(at, "lightning") {
    // rust: continue;
}
    // rust: let _ = self.level_set(p, fire);
    // rust: set += 1;
}
}
    // rust: set
}
    // `LightningBolt.tick` for every bolt.
    // rust: pub(super) fn tick_bolts(&mut self) {
    // rust: let mut bolts = std::mem::take(&mut self.bolts);
    // rust: bolts.retain_mut(|b| {
    // rust: if b.life == 2 {
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.2;
    // rust: self.audio.play(
    // rust: "minecraft:entity.lightning_bolt.thunder",
    // rust: Some(b.at),
    // rust: 10000.0,
    // rust: pitch,
    // rust: );
    // rust: let pitch = 0.5 + self.world.random.next_float() * 0.2;
    // rust: self.audio.play(
    // rust: "minecraft:entity.lightning_bolt.impact",
    // rust: Some(b.at),
    // rust: 2.0,
    // rust: pitch,
    // rust: );
    // rust: if !b.visual_only {
                    // Only Normal and Hard start fires with the strike itself.
    // rust: if self.ui.difficulty >= 2 {
    // rust: b.fires += self.bolt_fire(b.at, 4);
}
    // rust: self.strike_rod(b.at);
}
                // LightningBolt.tick runs clearCopperOnLightningStrike for
                // every server bolt, a skeleton trap's visual one included;
                // a client's copy of a server bolt (spawn_remote_bolt) only
                // flashes.
    // rust: if self.remote.is_none() {
    // rust: self.bolt_clear_copper(b.at);
}
}
    // rust: b.life -= 1;
    // rust: if b.life < 0 {
    // rust: if b.flashes == 0 {
    // rust: self.lightning_strike_triggers(b);
    // rust: return false;
}
    // rust: if b.life < -self.world.random.next_int_bound(10).unwrap_or(0) {
    // rust: b.flashes -= 1;
    // rust: b.life = 1;
    // rust: b.seed = self.world.random.next_long();
    // rust: if !b.visual_only {
    // rust: b.fires += self.bolt_fire(b.at, 0);
}
}
}
    // rust: if b.life >= 0 {
    // rust: if self.flash == 0 {
    // rust: self.lightning_seen[1] += 1;
}
    // rust: self.flash = 2;
    // rust: if !b.visual_only {
    // rust: let struck = self.thunder_hit(b);
    // rust: if let Some(cause) = b.cause {
    // rust: let who = cause.map_or(Target::Player, Target::Guest);
    // rust: self.for_player(who, |g| g.trigger_channeled_lightning(&struck));
}
}
}
    // rust: true
    // rust: });
    // rust: bolts.append(&mut self.bolts);
    // rust: self.bolts = bolts;
}
    // `LightningRodBlock.onLightningStrike`: powered for 8 ticks.
strike_rod :: proc(self: ^Self, at: [f64; 3]) {
}
    // rust: let p = [
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 1.0e-6).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: if !self.res.facts().get(state).name.ends_with("lightning_rod") {
    // rust: return;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: if let Some(mut s) = registry.state(state).cloned() {
    // rust: s.properties.insert("powered".into(), "true".into());
    // rust: if let Some(powered) = registry.id(&s) {
    // rust: let _ = self.level_set(p, powered);
    // rust: self.with_level(|b, level, ticks| {
                    // `level.scheduleTick(pos, this, 8)`: the unpowering. A rod struck
                    // is the same block as before, so its placement does not schedule
                    // it, and without this it stayed powered for good.
    // rust: b.schedule_tick(level, ticks, BlockPos::new(p[0], p[1], p[2]), 8);
    // rust: if level.redstone_experiments {
    // rust: b.lightning_rod_update_neighbors(
    // rust: level,
    // rust: ticks,
    // rust: BlockPos::new(p[0], p[1], p[2]),
    // rust: state,
    // rust: );
}
    // rust: });
}
            // Level event 3002 with the rod's axis: sparks along it.
    // rust: let axis = match s.properties.get("facing").map(String::as_str) {
    // rust: Some("east" | "west") => 0,
    // rust: Some("north" | "south") => 2,
    // rust: _ => 1,
}
    // rust: self.level_event_at(3002, p, axis);
}
}
    // `LightningBolt.clearCopperOnLightningStrike` at the block the bolt struck.
bolt_clear_copper :: proc(self: ^Self, at: [f64; 3]) {
}
    // rust: let p = BlockPos::new(
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 1.0e-6).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: self.with_level(|b, level, ticks| b.lightning_clear_copper(level, ticks, p));
    // rust: let _ = self.process_level_events();
}
    // `LightningStrikeTrigger` at the bolt's discard: every player within 256
    // blocks, with the mobs in its 30-block box that it did not hit.
lightning_strike_triggers :: proc(self: ^Self, b: ^Bolt) {
}
    // rust: let at = b.at;
    // rust: let bolt = EntityView {
    // rust: kind: "minecraft:lightning_bolt".into(),
    // rust: position: at,
    // rust: blocks_set_on_fire: b.fires,
    // rust: ..Default::default()
}
    // rust: let viewers: Vec<EntityView> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive() && !b.hit.contains(&m.id))
    // rust: .filter(|m| in_viewer_box(at, [m.position.x, m.position.y, m.position.z]))
    // rust: .map(|m| self.mob_entity(m))
    // rust: .collect();
        // The item entities in the box are viewers too (`getEntities` is every entity).
    // rust: let mut viewers = viewers;
    // rust: viewers.extend(
    // rust: self.dropped
    // rust: .iter()
    // rust: .filter(|e| !b.hit_items.contains(&e.id))
    // rust: .filter(|e| in_viewer_box(at, [e.position.x, e.position.y, e.position.z]))
    // rust: .map(|e| self.item_entity_view(e)),
    // rust: );
        // The players are entities in that box too, unless the bolt struck
        // them (`thunderHit` reaches 3 blocks, 9 up: `hitEntities`).
    // rust: let struck = |p: [f64; 3]| {
    // rust: (p[0] - at[0]).abs() <= 3.0
    // rust: && (p[2] - at[2]).abs() <= 3.0
    // rust: && p[1] >= at[1] - 3.0
    // rust: && p[1] <= at[1] + 9.0
}
    // rust: self.for_each_player(|g| {
    // rust: let Some(p) = g.player.as_ref().filter(|p| !p.health.dead_or_dying()) else {
    // rust: return;
}
    // rust: let pos = [p.position.x, p.position.y, p.position.z];
    // rust: if in_viewer_box(at, pos) && !struck(pos) {
    // rust: viewers.push(g.player_entity_for("minecraft:lightning_strike"));
}
    // rust: });
    // rust: self.for_each_player(|g| {
    // rust: let Some(p) = g.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: let d2 = (p.x - at[0]).powi(2) + (p.y - at[1]).powi(2) + (p.z - at[2]).powi(2);
    // rust: if d2 < 256.0 * 256.0 {
    // rust: g.trigger_lightning_strike(&bolt, &viewers);
}
    // rust: });
}
    // How many entities of `stage` the strike reaches: one loop per list over
    // the borrowed slices, where a kind that takes no stage folds away, so a
    // stage nobody is in is skipped without walking the handles.
thunder_count :: proc(self: ^Self, strike: Aabb, stage: ThunderHit) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let lists = entity_lists_of!(self);
    // rust: let mut n = 0;
    // rust: for_each_entity!(lists, e => {
    // rust: if e.thunder_hit() == stage && strike.intersects(e.thunder_bounds()) {
    // rust: n += 1;
}
    // rust: });
    // rust: n
}
    // Whether the strike reaches `h` and its kind takes `stage`.
thunder_struck :: proc(self: ^Self, h: EntityHandle, strike: Aabb, stage: ThunderHit) -> b {
    // Ported from Horizon
    return {}
}
    // rust: with_entity!(self, h, e => e.thunder_hit() == stage && strike.intersects(e.thunder_bounds()))
}
    // `thunderHit` for entities whose box meets the strike box, 3 blocks
    // around and up to 9 above (`getEntities(this, AABB)` tests boxes, not
    // positions). Returns the mobs in that box before the hit, as
    // `CHANNELED_LIGHTNING` counts them. Boats, minecarts and experience
    // orbs are hit too (`VehicleEntity.hurtServer` adds 5 x 10 > 40 and
    // destroys them; an orb has 5 health).
thunder_hit :: proc(self: ^Self, b: ^Bolt) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let at = b.at;
    // rust: let strike = Aabb::new(
    // rust: Vec3::new(at[0] - 3.0, at[1] - 3.0, at[2] - 3.0),
    // rust: Vec3::new(at[0] + 3.0, at[1] + 9.0, at[2] + 3.0),
    // rust: );
        // Whether the box of an entity standing at `p` (half width `w`,
        // height `h`) meets the strike box.
    // rust: let meets = move |p: [f64; 3], w: f64, h: f64| {
    // rust: strike.intersects(Aabb::new(
    // rust: Vec3::new(p[0] - w, p[1], p[2] - w),
    // rust: Vec3::new(p[0] + w, p[1] + h, p[2] + w),
    // rust: ))
}
    // rust: let damage = Damage {
    // rust: kind: DamageKind::Generic,
    // rust: attacker: None,
    // rust: from: Some(b.at),
    // rust: attacker_species: None,
}
    // rust: let mut struck = Vec::new();
    // rust: let mut events = Vec::new();
    // rust: let mut powered = Vec::new();
    // rust: let peaceful = self.ui.difficulty == 0;
    // rust: let mut left = self.thunder_count(strike, ThunderHit::Mob);
    // rust: for h in self.entity_handles() {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: let EntityHandle::Mob(i) = h else { continue };
    // rust: if !self.thunder_struck(h, strike, ThunderHit::Mob) {
    // rust: continue;
}
    // rust: left -= 1;
    // rust: struck.push(self.mob_entity(&self.mobs[i]));
            // LivingConversionEvent.Pre: a canceled conversion leaves the
            // mob to the lightning's fire and damage, as `super.thunderHit`.
    // rust: let outcome = match self.mobs[i].species() {
    // rust: Species::Pig if !peaceful => Some("minecraft:zombified_piglin"),
    // rust: Species::Villager if !peaceful => Some("minecraft:witch"),
    // rust: _ => None,
}
    // rust: let mut keep = false;
    // rust: if let Some(outcome) = outcome {
    // rust: let (id, kind) = (
    // rust: self.mobs[i].id,
    // rust: super::native_hooks::mob_kind(&self.mobs[i]),
    // rust: );
    // rust: self.native_living_conversion_pre(id, &kind, outcome, &mut keep);
}
    // rust: let m = &mut self.mobs[i];
    // rust: b.hit.push(m.id);
    // rust: let setup = thunder_mob_spawn_setup;
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: match m.species() {
    // rust: Species::Pig if !peaceful && !keep => {
    // rust: m.removed = true;
    // rust: events.push(MobEvent::SpawnKind {
    // rust: kind: "minecraft:zombified_piglin".into(),
    // rust: at,
    // rust: setup: setup(m),
    // rust: });
    // rust: continue;
}
    // rust: Species::Villager if !peaceful && !keep => {
    // rust: m.removed = true;
    // rust: events.push(MobEvent::SpawnKind {
    // rust: kind: "minecraft:witch".into(),
    // rust: at,
    // rust: setup: setup(m),
    // rust: });
    // rust: continue;
}
    // rust: Species::Mooshroom => {
    // rust: if !b.converted.contains(&m.id) {
    // rust: b.converted.push(m.id);
    // rust: m.extra.variant = 1 - m.extra.variant.min(1);
    // rust: self.audio
    // rust: .play("minecraft:entity.mooshroom.convert", Some(at), 2.0, 1.0);
}
    // rust: continue;
}
    // rust: Species::Turtle => {
    // rust: m.damage(f32::MAX, damage);
    // rust: continue;
}
    // rust: Species::Creeper => {
    // rust: m.extra.charged = true;
    // rust: powered.push(m.id);
}
                // CopperGolem.thunderHit (after Entity.thunderHit's fire and
                // damage): once per bolt, an oxidized golem goes back one step
                // and its weathering timer (or wax, -2) is reset to -1.
    // rust: Species::CopperGolem if !b.converted.contains(&m.id) => {
    // rust: b.converted.push(m.id);
    // rust: if m.extra.variant > 0 {
    // rust: m.extra.vector[0] = -1.0;
    // rust: m.extra.variant =
    // rust: horizon_client::mobs::copper_golem::weather_previous(m.extra.variant);
}
}
    // rust: _ => {}
}
            // Entity.thunderHit: burning (8 seconds) and 5 lightning damage.
    // rust: m.fire_ticks += 1;
    // rust: if m.fire_ticks == 0 {
    // rust: m.ignite_for_ticks(160);
}

    // rust: m.damage(5.0, damage);
}
    // rust: if !events.is_empty() {
    // rust: let _ = self.handle_mob_events(events);
}
    // rust: for entity in powered {
    // rust: self.native_creeper_power(entity, [at[0], at[1], at[2]]);
}
        // Cushion.thunderHit: a cushion whose box meets the strike box breaks and drops its item
        // (the bolt is no player, so no creative spare). Last first, since
        // break_cushion removes the entry.
    // rust: for i in (0..self.cushions.len()).rev() {
    // rust: let (lo, hi) = self.cushions[i].bounds();
    // rust: if strike.intersects(Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: )) {
    // rust: let before = self.dropped.len();
    // rust: self.break_cushion(i, false);
    // rust: b.spared.extend(self.dropped[before..].iter().map(|e| e.id));
}
}
        // Vehicles, then orbs: `VehicleEntity.hurtServer` for 5 damage (x 10
        // over the 40 a vehicle takes) destroys them. Lightning is no fire
        // source, so a TNT cart does not prime. `ExperienceOrb.hurtServer`:
        // 5 damage off 5 health. Last first, since each removes its entry.
    // rust: let mut left = self.thunder_count(strike, ThunderHit::Vehicle)
    // rust: + self.thunder_count(strike, ThunderHit::Orb);
    // rust: for h in self.entity_handles_rev() {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: if !self.thunder_struck(h, strike, ThunderHit::Vehicle)
    // rust: && !self.thunder_struck(h, strike, ThunderHit::Orb)
    // rust: {
    // rust: continue;
}
    // rust: left -= 1;
    // rust: match h {
    // rust: EntityHandle::Boat(i) => {
    // rust: self.hurt_boat(i, 5.0, false);
}
    // rust: EntityHandle::Cart(i) => self.hurt_cart(i, 5.0, false, false),
    // rust: EntityHandle::Orb(i) if self.orbs[i].hurt(5.0) => {
    // rust: self.orbs.remove(i);
}
    // rust: _ => {}
}
}
    // rust: self.native_leaves_flush();
        // Every player in the box, the server's players too (0.6 x 1.8).
    // rust: let strike_players = move |g: &mut Self| {
    // rust: if let Some(p) = g.player.as_ref().map(|p| p.position)
    // rust: && meets([p.x, p.y, p.z], 0.3, 1.8)
    // rust: {
    // rust: if let Some(p) = g.player.as_mut() {
    // rust: p.fire_ticks += 1;
    // rust: if p.fire_ticks == 0
    // rust: && let Err(error) = p.ignite_for_ticks(160)
    // rust: {
    // rust: g.error = Some(error);
}
}
    // rust: g.hurt_player_by("minecraft:lightning_bolt", 5.0);
}
}
    // rust: strike_players(self);
    // rust: self.each_guest_hit(strike_players);
        // Dropped items burn up (ItemEntity health 5), save fire-resistant ones.
    // rust: let mut left = self.thunder_count(strike, ThunderHit::Item);
    // rust: for h in self.entity_handles_rev() {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: let EntityHandle::Item(i) = h else { continue };
    // rust: if !self.thunder_struck(h, strike, ThunderHit::Item) {
    // rust: continue;
}
    // rust: left -= 1;
    // rust: let e = &self.dropped[i];
    // rust: b.hit_items.push(e.id);
    // rust: if !(e.stack.item.contains("netherite") || (e.age < 20 && b.spared.contains(&e.id))) {
    // rust: self.dropped.remove(i);
}
}
    // rust: self.native_leaves_flush();
    // rust: struck
}
    // `LightningBolt.shouldRenderAtSqrDistance`: a bolt is drawn within 64
    // blocks times the view scale of the camera, and past that only its sky
    // flash and thunder remain. Simulation-order render inputs; seeded
    // geometry lives in the renderer.
    // rust: pub(super) fn bolt_instances(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: ) -> Vec<horizon_client::gfx::lightning::Bolt> {
    // rust: let range = 64.0 * self.view_scale();
    // rust: self.bolts
    // rust: .iter()
    // rust: .filter(|b| {
    // rust: let at = glam::DVec3::new(b.at[0], b.at[1], b.at[2]);
    // rust: at.distance_squared(camera) < range * range
    // rust: })
    // rust: .map(|b| horizon_client::gfx::lightning::Bolt {
    // rust: at: b.at,
    // rust: seed: b.seed,
    // rust: })
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::mobs::{Anim, Brain, Mob, MobType, Part, Species};
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

viewer_box_reaches_15_around_and_down_and_21_up :: proc() {
}
    // rust: let bolt = [0.0, 64.0, 0.0];
    // rust: assert!(in_viewer_box(bolt, [15.0, 49.0, -15.0]));
    // rust: assert!(in_viewer_box(bolt, [0.0, 85.0, 0.0]));
    // rust: assert!(!in_viewer_box(bolt, [0.0, 85.5, 0.0]));
    // rust: assert!(!in_viewer_box(bolt, [0.0, 48.5, 0.0]));
    // rust: assert!(!in_viewer_box(bolt, [15.5, 64.0, 0.0]));
}

    // `Pig.thunderHit`: striking a pig with lightning converts it to a zombified
    // piglin while preserving age (#7510).
a_baby_pig_hit_by_lightning_becomes_a_baby_zombified_piglin :: proc() {
}
    // rust: let make_pig = |baby: bool| {
    // rust: let kind = Arc::new(MobType {
    // rust: id: "minecraft:pig".into(),
    // rust: species: Species::Pig,
    // rust: width: 0.9,
    // rust: height: 0.9,
    // rust: eye_height: 0.85,
    // rust: category: "creature".into(),
    // rust: max_health: 10.0,
    // rust: speed: 0.25,
    // rust: flying_speed: 0.02,
    // rust: attack_damage: 0.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 16.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Default::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 80,
    // rust: flags: Default::default(),
    // rust: model: Arc::new(Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
    // rust: }),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Quadruped,
    // rust: sounds: ["", "", ""],
    // rust: step_sound: None,
    // rust: food: Default::default(),
    // rust: tempt: Default::default(),
    // rust: });
    // rust: let mut pig = Mob::new(1, kind, Vec3::ZERO, 45.0);
    // rust: if baby {
    // rust: pig.extra.age = -24000;
}
    // rust: pig
}

    // rust: let adult_pig = make_pig(false);
    // rust: assert!(!adult_pig.is_baby());
    // rust: let adult_setup = thunder_mob_spawn_setup(&adult_pig);
    // rust: assert!(!adult_setup.baby);
    // rust: assert_eq!(adult_setup.yaw, 45.0);
    // rust: assert!(adult_setup.persistent);

    // rust: let baby_pig = make_pig(true);
    // rust: assert!(baby_pig.is_baby());
    // rust: let baby_setup = thunder_mob_spawn_setup(&baby_pig);
    // rust: assert!(baby_setup.baby);
    // rust: assert_eq!(baby_setup.yaw, 45.0);
    // rust: assert!(baby_setup.persistent);

        // When setup.baby is true, apply_setup sets m.extra.age = -24000,
        // resulting in a baby mob (is_baby() == true).
    // rust: let mut zombified = Mob::new(2, adult_pig.kind.clone(), Vec3::ZERO, 0.0);
    // rust: if baby_setup.baby {
    // rust: zombified.extra.age = -24000;
}
    // rust: assert!(zombified.is_baby());
}
}
