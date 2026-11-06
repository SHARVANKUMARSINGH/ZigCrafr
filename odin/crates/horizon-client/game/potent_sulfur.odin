//! Transpiled from Horizon Rust crate
package horizon_client_potent_sulfur

import "core:fmt"
import "core:mem"
import "core:math"

// Potent sulfur geysers: the tickers `PotentSulfurBlock.getTicker` gives
// `PotentSulfurBlockEntity` by the block's state. The server's make living
// entities near the gas nauseous, count a dormant or erupting geyser down to
// its next change of state and push the entities an eruption throws up. The
// client's draw the gas clouds and the eruption's plume, play its sound and
// push the local player, who moves on its own client and not on the server.
// use super::{
    // rust: Game,
    // rust: potions::{mob_can_be_affected, mob_effect_id},
}
// use horizon_client::{
    // rust: Result,
    // rust: block_entities::Pos,
    // rust: containers::BlockEntity,
    // rust: effects::EffectInstance,
    // rust: mobs::Mob,
    // rust: particles::{ParticleLevel, ParticleOptions, ParticleType as T},
    // rust: potent_sulfur::{
    // rust: can_be_reached_by_noxious_gas, find_noxious_gas_source_block, unobstructed_block_count,
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::{PositionalRandom, RandomSource, XoroshiroRandom},
}
// use horizon_world::{level::flags, registry::BlockStateId};

// `PotentSulfurBlockEntity.GEYSER_SALT`.
GEYSER_SALT :: -904_011_478
// `PotentSulfurBlockEntity.EFFECT_APPLICATION_FREQUENCY_TICKS`.
EFFECT_APPLICATION_FREQUENCY_TICKS :: 10
// `PotentSulfurBlockEntity.EFFECT_DURATION_IN_TICKS`.
EFFECT_DURATION_IN_TICKS :: 80
// `PotentSulfurBlockEntity.PARTICLE_FREQUENCY_TICKS`.
PARTICLE_FREQUENCY_TICKS :: 20
// `PotentSulfurBlockEntity.SOUND_FREQUENCY_TICKS`.
SOUND_FREQUENCY_TICKS :: 40
// `SoundEvents.GEYSER_ERUPTION_ACTIVE`.
GEYSER_ERUPTION_ACTIVE :: "minecraft:block.potent_sulfur.geyser_eruption_active"
// `SoundEvents.GEYSER_CONTINUOUS_ACTIVE`.
    // rust: const GEYSER_CONTINUOUS_ACTIVE: &str =
    // rust: "minecraft:block.potent_sulfur.geyser_continuous_eruption_active";

// `PotentSulfurState`.
Geyser :: enum {
    Dry,
    Wet,
    Dormant,
    Erupting,
    Continuous,
}

// `PotentSulfurBlockEntity.geyserPositional`: the random of the sulfur block
// at `pos`, forked from the level seed and the geyser salt.
geyser_positional :: proc(seed: i64, pos: Pos) -> X {
    // Ported from Horizon
    return {}
}
    // rust: let mut base = XoroshiroRandom::new(seed ^ GEYSER_SALT);
    // rust: base.fork_positional()
    // rust: .at(BlockPos::new(pos.0, pos.1, pos.2))
}

// `PotentSulfurBlockEntity.getNearbyLivingEntities`: the box of the source
// block grown 2.5 blocks sideways.
nearby_living_area :: proc(source: [i32; 3]) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = source.map(f64::from);
    // rust: Aabb::new(
    // rust: Vec3::new(x - 2.5, y, z - 2.5),
    // rust: Vec3::new(x + 1.0 + 2.5, y + 1.0, z + 1.0 + 2.5),
    // rust: )
}

// The box `PotentSulfurBlockEntity.LAUNCH_ENTITY_TICKER` pushes entities in:
// the block above the sulfur, `expandTowards` the unobstructed height.
launch_area :: proc(pos: Pos, height: i32) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let (x, y, z) = (f64::from(pos.0), f64::from(pos.1 + 1), f64::from(pos.2));
    // rust: let up = f64::from(height - 1);
    // rust: let (min_y, max_y) = if up < 0.0 {
    // rust: (y + up, y + 1.0)
    // rust: } else {
    // rust: (y, y + 1.0 + up)
}
    // rust: Aabb::new(Vec3::new(x, min_y, z), Vec3::new(x + 1.0, max_y, z + 1.0))
}

// `PotentSulfurBlockEntity.applyNauseaEffect` on a mob, if it can be
// affected.
    // rust: fn apply_nausea_effect_to_mob(
    // rust: mob: &mut Mob,
    // rust: tags: &std::collections::HashMap<String, std::collections::HashSet<String>>,
    // rust: ) {
    // rust: if mob_can_be_affected(tags, &mob.kind.id, "nausea")
    // rust: && let Some(nausea) = mob_effect_id("nausea")
    // rust: {
    // rust: mob.add_effect(nausea, EFFECT_DURATION_IN_TICKS, 0);
}
}

    // rust: impl Game<'_> {
    // The `potent_sulfur_state` of the block at `pos`, with its block state.
potent_sulfur_state :: proc(self: ^Self, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let value = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get("potent_sulfur_state")?;
    // rust: let geyser = match value.as_str() {
    // rust: "dry" => Geyser::Dry,
    // rust: "wet" => Geyser::Wet,
    // rust: "dormant" => Geyser::Dormant,
    // rust: "erupting" => Geyser::Erupting,
    // rust: "continuous" => Geyser::Continuous,
    // rust: _ => return None,
}
    // rust: Some((state, geyser))
}

    // `PotentSulfurBlockEntity.findNoxiousGasSourceBlock` of the sulfur at
    // `pos`.
potent_sulfur_source :: proc(self: ^Self, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let level = ParticleLevel {
    // rust: world: &self.world,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: player: None,
}
    // rust: find_noxious_gas_source_block(&level, [pos.0, pos.1, pos.2])
}

    // `PotentSulfurBlock.getTicker` on the server, for the block entity at
    // `pos`: a wet block gives nausea; a dormant one counts down, then gives
    // nausea; an erupting one pushes entities, then counts down; a continuous
    // one pushes entities. A dry block has no ticker.
    // rust: pub(super) fn tick_potent_sulfur(&mut self, pos: Pos) -> Result<()> {
    // rust: let Some((state, geyser)) = self.potent_sulfur_state(pos) else {
    // rust: return Ok(());
}
    // rust: match geyser {
    // rust: Geyser::Dry => {}
    // rust: Geyser::Wet => self.server_nausea_effect_ticker(pos),
    // rust: Geyser::Dormant => {
    // rust: self.server_waiting_countdown_ticker(pos, state, geyser)?;
    // rust: self.server_nausea_effect_ticker(pos);
}
    // rust: Geyser::Erupting => {
    // rust: self.launch_entity_ticker(pos);
    // rust: self.server_waiting_countdown_ticker(pos, state, geyser)?;
}
    // rust: Geyser::Continuous => self.launch_entity_ticker(pos),
}
    // rust: Ok(())
}

    // `PotentSulfurBlockEntity.SERVER_NAUSEA_EFFECT_TICKER`: every 10 ticks,
    // the living entities near the source block that its gas reaches (at
    // their eyes) get nausea for 4 seconds.
server_nausea_effect_ticker :: proc(self: ^Self, pos: Pos) {
}
    // rust: if self.world.game_time % EFFECT_APPLICATION_FREQUENCY_TICKS != 0 {
    // rust: return;
}
    // rust: let Some(source) = self.potent_sulfur_source(pos) else {
    // rust: return;
}
    // rust: let area = nearby_living_area(source);
    // rust: for player in self
    // rust: .fight_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive && p.bounds.intersects(area))
    // rust: {
    // rust: self.as_fight_player(player.who, |g| g.apply_nausea_effect_to_player(source));
}
    // rust: let level = ParticleLevel {
    // rust: world: &self.world,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: player: None,
}
    // rust: let tags = &self.res.stations().enchantments.entity_tags;
    // rust: for mob in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.alive() && m.bounds().intersects(area))
    // rust: {
    // rust: let eye = [mob.position.x, mob.eye_y(), mob.position.z];
    // rust: if can_be_reached_by_noxious_gas(&level, source, eye) {
    // rust: apply_nausea_effect_to_mob(mob, tags);
}
}
}

    // `PotentSulfurBlockEntity.applyNauseaEffect` on the player acting (a
    // guest is swapped in as the player) when the gas reaches their eyes;
    // spectators are not affected.
apply_nausea_effect_to_player :: proc(self: ^Self, source: [i32; 3]) {
}
    // rust: if self.spectator() {
    // rust: return;
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let eye = [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.eye_height),
    // rust: p.position.z,
    // rust: ];
    // rust: let reached = {
    // rust: let level = ParticleLevel {
    // rust: world: &self.world,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: player: None,
}
    // rust: can_be_reached_by_noxious_gas(&level, source, eye)
}
    // rust: if reached {
            // MobEffectInstance(NAUSEA, 80, 0, true, true).
    // rust: let mut nausea = EffectInstance::new("nausea", EFFECT_DURATION_IN_TICKS, 0);
    // rust: nausea.ambient = true;
    // rust: self.add_player_effect(nausea);
}
}

    // `PotentSulfurBlockEntity.SERVER_WAITING_COUNTDOWN_TICKER`: every second
    // the countdown runs down; a dormant geyser waits `10 * (water - 1)` plus
    // 15 to 30, an erupting one `water - 1` plus 1 or 2, and at zero the
    // block turns erupting (dormant) or dormant (erupting). `state` is the
    // block state the tick began with.
    // rust: fn server_waiting_countdown_ticker(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: state: BlockStateId,
    // rust: geyser: Geyser,
    // rust: ) -> Result<()> {
    // rust: if self.world.game_time % 20 != 0 {
    // rust: return Ok(());
}
    // rust: let Some(source) = self.potent_sulfur_source(pos) else {
    // rust: return Ok(());
}
    // rust: let Some(BlockEntity::PotentSulfur(sulfur)) = self.world.block_entities.get_mut(&pos)
    // rust: else {
    // rust: return Ok(());
}
    // rust: if sulfur.waiting_countdown <= 0 {
    // rust: let water_blocks = source[1] - pos.1 - 1;
    // rust: let mut positional = geyser_positional(self.level.seed, pos);
    // rust: sulfur.waiting_countdown = if geyser == Geyser::Dormant {
    // rust: 10 * (water_blocks - 1)
    // rust: + positional.next_int_between_inclusive(15, 30).unwrap_or(15)
    // rust: } else {
    // rust: positional.next_int();
    // rust: water_blocks - 1 + positional.next_int_between_inclusive(1, 2).unwrap_or(1)
}
}
    // rust: if sulfur.waiting_countdown > 0 {
    // rust: sulfur.waiting_countdown -= 1;
}
    // rust: if sulfur.waiting_countdown != 0 {
    // rust: return Ok(());
}
    // rust: let to_set = if geyser == Geyser::Dormant {
    // rust: "erupting"
    // rust: } else {
    // rust: "dormant"
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(mut next) = registry.state(state).cloned() else {
    // rust: return Ok(());
}
    // rust: next.properties
    // rust: .insert("potent_sulfur_state".into(), to_set.into());
    // rust: let Some(next) = registry.id(&next) else {
    // rust: return Ok(());
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, next, flags::UPDATE_ALL));
    // rust: self.world.modified.insert((pos.0 >> 4, pos.2 >> 4));
    // rust: if to_set == "dormant" {
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_deactivate",
    // rust: [pos.0, pos.1, pos.2],
    // rust: None,
    // rust: Some(state),
    // rust: );
}
    // rust: self.process_level_events()
}

    // `PotentSulfurBlockEntity.LAUNCH_ENTITY_TICKER` on the server: mobs and
    // items and primed TNT in the geyser's column with less than
    // `0.3 + 0.1 * water` upward speed get 0.2 more, unless they ride
    // something or are of a type geysers do not move. Players are moved by
    // their own client.
launch_entity_ticker :: proc(self: ^Self, pos: Pos) {
}
    // rust: let Some(source) = self.potent_sulfur_source(pos) else {
    // rust: return;
}
    // rust: let water_blocks = source[1] - pos.1 - 1;
    // rust: let level = ParticleLevel {
    // rust: world: &self.world,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: player: None,
}
    // rust: let height = unobstructed_block_count(&level, [pos.0, pos.1 + 1, pos.2], water_blocks);
    // rust: let area = launch_area(pos, height);
    // rust: let limit = f64::from(0.3f32) + f64::from(water_blocks) * 0.1;
    // rust: let push = f64::from(0.2f32);
    // rust: let tags = &self.res.stations().enchantments.entity_tags;
    // rust: let immune = tags.get("minecraft:not_affected_by_geysers");
    // rust: for mob in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.alive() && m.bounds().intersects(area))
    // rust: {
            // Entity.checkFallDistanceAccumulation.
    // rust: if mob.velocity.y > -0.5 && mob.fall_distance > 1.0 {
    // rust: mob.fall_distance = 1.0;
}
    // rust: if !mob.extra.passenger
    // rust: && !immune.is_some_and(|t| t.contains(&mob.kind.id))
    // rust: && mob.velocity.y < limit
    // rust: {
    // rust: mob.velocity.y += push;
}
}
    // rust: for item in self
    // rust: .dropped
    // rust: .iter_mut()
    // rust: .filter(|i| i.bounds().intersects(area))
    // rust: {
    // rust: if item.velocity.y < limit {
    // rust: item.velocity.y += push;
}
}
    // rust: for tnt in self.tnts.iter_mut().filter(|t| t.bounds().intersects(area)) {
    // rust: if tnt.velocity.y < limit {
    // rust: tnt.velocity.y += push;
}
}
}

    // `PotentSulfurBlockEntity.LAUNCH_ENTITY_TICKER` on the client: the local
    // player in the column, unless spectating, flying or riding.
launch_local_player_ticker :: proc(self: ^Self, pos: Pos) {
}
    // rust: let Some(source) = self.potent_sulfur_source(pos) else {
    // rust: return;
}
    // rust: let water_blocks = source[1] - pos.1 - 1;
    // rust: let height = {
    // rust: let level = ParticleLevel {
    // rust: world: &self.world,
    // rust: facts: self.res.facts(),
    // rust: collision: self.collision,
    // rust: player: None,
}
    // rust: unobstructed_block_count(&level, [pos.0, pos.1 + 1, pos.2], water_blocks)
}
    // rust: let area = launch_area(pos, height);
    // rust: let (spectator, riding) = (self.spectator(), self.riding.is_some());
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: return;
}
    // rust: if spectator || p.health.dead_or_dying() || !p.bounds().intersects(area) {
    // rust: return;
}
        // Entity.checkFallDistanceAccumulation.
    // rust: if p.velocity.y > -0.5 && p.fall_distance > 1.0 {
    // rust: p.fall_distance = 1.0;
}
    // rust: if !p.flying && !riding && p.velocity.y < f64::from(0.3f32) + f64::from(water_blocks) * 0.1
    // rust: {
    // rust: p.velocity.y += f64::from(0.2f32);
}
}

    // `PotentSulfurBlockEntity.spawnGeyserParticle`: the eruption particle at
    // the bottom of the source block, as high as the water column is deep.
spawn_geyser_particle :: proc(self: ^Self, sulfur: Pos, source: [i32; 3]) {
}
    // rust: let water_blocks = source[1] - sulfur.1 - 1;
    // rust: self.particles.add(
    // rust: &ParticleOptions::geyser(T::Geyser, water_blocks),
    // rust: [
    // rust: f64::from(source[0]) + 0.5,
    // rust: f64::from(source[1]),
    // rust: f64::from(source[2]) + 0.5,
    // rust: ],
    // rust: [0.0; 3],
    // rust: );
}

    // `PotentSulfurBlockEntity.spawnNoxiousGasCloudParticle` at the centre of
    // the source block.
spawn_noxious_gas_cloud_particle :: proc(self: ^Self, source: [i32; 3]) {
}
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(T::NoxiousGasCloud),
    // rust: source.map(|c| f64::from(c) + 0.5),
    // rust: [0.0; 3],
    // rust: );
}

    // `PotentSulfurBlock.getTicker` on the client, for the block entity at
    // `pos`: a wet or dormant geyser releases gas clouds every second; an
    // erupting or continuous one shows its plume every second (from its last
    // eruption event), plays its sound every two, and pushes the local
    // player.
    // rust: pub(super) fn client_tick_potent_sulfur(&mut self, pos: Pos) {
    // rust: let Some((_, geyser)) = self.potent_sulfur_state(pos) else {
    // rust: return;
}
    // rust: let time = self.world.game_time;
        // PotentSulfurBlockEntity.setLevel.
    // rust: let eruption_tick = match self.world.block_entities.get_mut(&pos) {
    // rust: Some(BlockEntity::PotentSulfur(sulfur)) => {
    // rust: if sulfur.eruption_tick == -1 {
    // rust: sulfur.eruption_tick = time;
}
    // rust: sulfur.eruption_tick
}
    // rust: _ => return,
}
    // rust: match geyser {
    // rust: Geyser::Dry => {}
            // CLIENT_NOXIOUS_GAS_TICKER.
    // rust: Geyser::Wet | Geyser::Dormant => {
    // rust: if time % PARTICLE_FREQUENCY_TICKS == 0
    // rust: && let Some(source) = self.potent_sulfur_source(pos)
    // rust: {
    // rust: self.spawn_noxious_gas_cloud_particle(source);
}
}
            // CLIENT_GEYSER_PLUME_TICKER, then LAUNCH_ENTITY_TICKER.
    // rust: Geyser::Erupting | Geyser::Continuous => {
    // rust: if let Some(source) = self.potent_sulfur_source(pos) {
    // rust: let eruption_time = time - eruption_tick;
    // rust: if eruption_time % PARTICLE_FREQUENCY_TICKS == 0 {
    // rust: self.spawn_geyser_particle(pos, source);
}
    // rust: if eruption_time % SOUND_FREQUENCY_TICKS == 0 {
    // rust: let sound = if geyser == Geyser::Erupting {
    // rust: GEYSER_ERUPTION_ACTIVE
    // rust: } else {
    // rust: GEYSER_CONTINUOUS_ACTIVE
}
    // rust: let at = source.map(|c| f64::from(c) + 0.5);
                        // playLocalSound: guests play their own.
    // rust: self.audio.play_unshared(sound, Some(at), 1.0, 1.0);
}
}
    // rust: self.launch_local_player_ticker(pos);
}
}
}

    // `ClientLevel.tickBlockEntities` for the potent sulfur of a server's
    // level: every one the client knows ticks.
    // rust: pub(super) fn tick_remote_potent_sulfur(&mut self) {
    // rust: let keys: Vec<Pos> = self
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter_map(|(k, e)| matches!(e, BlockEntity::PotentSulfur(_)).then_some(*k))
    // rust: .collect();
    // rust: for key in keys {
    // rust: self.client_tick_potent_sulfur(key);
}
}

    // `PotentSulfurBlock.triggerEvent`: the eruption block event stamps the
    // game time the plume counts from; false when `pos` holds no potent
    // sulfur block entity.
    // rust: pub(super) fn potent_sulfur_eruption_event(&mut self, pos: Pos) -> bool {
    // rust: let time = self.world.game_time;
    // rust: match self.world.block_entities.get_mut(&pos) {
    // rust: Some(BlockEntity::PotentSulfur(sulfur)) => {
    // rust: sulfur.eruption_tick = time;
    // rust: true
}
    // rust: _ => false,
}
}
}
