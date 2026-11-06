//! Transpiled from Horizon Rust crate
//! Module: horizon-client_levels
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A server's levels, one per dimension (`MinecraftServer.levels`).
//!
//! The game's tick code reads one level: the one in place, held in `Game`'s
//! own fields (the world, its streaming and save, block ticks, entities).
//! A server (the dedicated server and single player's server thread) keeps
//! the other dimensions' levels here and ticks each one with players or forced
//! chunks by swapping it into place (`enter_level`), the way `as_guest` swaps a player
//! in, so the tick code runs unchanged, one level at a time.
//!
//! Shared by every level, as vanilla's derived levels share the
//! Overworld's level data: the game time, the day time and the weather, the
//! game rules, the scoreboard, the maps and the entities waiting to arrive
//! through a portal.

// use super::{
    // rust: Dim, ExperienceOrb, FallingBlock, Game, ItemEntity, Mob, boats, commands,
    // rust: creaking::CreakingState, dragon, fireworks, lan::LanHost, lightning, machines, minecarts,
    // rust: ominous_item_spawner, persist, raids::Raiding, sculk::SculkState, tnt, trident,
}
// use horizon_client::{
    // rust: Result, block_entity_anim::BlockEntityAnims, random_tick_sections::RandomTickSections,
    // rust: save::SaveDir, streaming::Streaming, tick_chunk_membership::TickChunkMembership,
    // rust: ticket_levels::ChunkTickets, vanillagen::VanillaTerrain, world::World,
}
// use horizon_world::level::{LevelEvent, Ticks};
// use std::{
    // rust: collections::HashMap,
    // rust: sync::Arc,
    // rust: time::{Duration, Instant},
}

/// Server ticks a level other than the Overworld stays loaded with no player
/// in it, before it is saved and closed (vanilla unloads a level's chunks
/// once no ticket holds them; the Overworld stays loaded).
pub const IDLE_TICKS: u32 = 300;

/// A level that is not in place: every per-level field of `Game`.
    // rust: pub(super) struct Parked {
    // rust: world: World,
    // rust: streaming: Streaming,
    // rust: locator: Option<Arc<VanillaTerrain>>,
    // rust: save: Arc<SaveDir>,
    // rust: block_ticks: Ticks,
    // rust: tick_chunks: TickChunkMembership,
    // rust: tickets: ChunkTickets,
    // rust: random_tick_sections: RandomTickSections,
    // rust: level_events: Vec<LevelEvent>,
    /// Entity portal processes and cooldowns belong to this level's entities.
    // rust: portal_states: HashMap<u32, horizon_client::nether_portal::PortalState>,
    // rust: falling: horizon_client::join_seq::JoinList<FallingBlock>,
    // rust: paintings: Vec<horizon_client::entities::Painting>,
    // rust: item_frames: Vec<horizon_client::entities::ItemFrame>,
    // rust: armor_stands: horizon_client::join_seq::JoinList<horizon_client::entities::ArmorStand>,
    // rust: cushions: Vec<horizon_client::entities::Cushion>,
    // rust: others: Vec<commands::OtherEntity>,
    // rust: fangs: super::fangs::FangState,
    // rust: pub(super) boats: horizon_client::join_seq::JoinList<boats::Boat>,
    // rust: pub(super) carts: horizon_client::join_seq::JoinList<minecarts::Minecart>,
    // rust: jukebox_sounds: HashMap<(i32, i32, i32), u64>,
    // rust: bolts: Vec<lightning::Bolt>,
    // rust: crystals: Vec<dragon::Crystal>,
    // rust: dragon: Option<dragon::Dragon>,
    // rust: dragon_fireballs: Vec<dragon::DragonFireball>,
    // rust: breath_clouds: Vec<dragon::Breath>,
    // rust: tridents: horizon_client::join_seq::JoinList<trident::ThrownTrident>,
    // rust: rockets: horizon_client::join_seq::JoinList<fireworks::Rocket>,
    // rust: ominous_spawners: Vec<ominous_item_spawner::OminousItemSpawner>,
    // rust: tnts: horizon_client::join_seq::JoinList<tnt::PrimedTnt>,
    // rust: hoppers: HashMap<(i32, i32, i32), machines::HopperState>,
    // rust: pub(super) mobs: horizon_client::join_seq::JoinList<Mob>,
    /// The entity ids of the level's fence knots (`knot_ids`).
    // rust: knot_ids: HashMap<[i32; 3], u32>,
    // rust: projectiles: horizon_client::join_seq::JoinList<horizon_client::projectiles::Projectile>,
    // rust: dropped: horizon_client::join_seq::JoinList<ItemEntity>,
    // rust: orbs: horizon_client::join_seq::JoinList<ExperienceOrb>,
    // rust: persist: persist::EntityMemory,
    // rust: lectern_pulses: Vec<((i32, i32, i32), i32)>,
    // rust: lid_openers: HashMap<(i32, i32, i32), i32>,
    // rust: lan_events: Vec<(i32, [i32; 3], i32, Option<u32>)>,
    // rust: lan_block_events: Vec<([i32; 3], i32, i32, u32)>,
    // rust: lan_entity_events: Vec<(i32, i8, [f64; 3])>,
    // rust: lan_critical_hits: Vec<(Option<u32>, i32, bool)>,
    /// The hub's tracked entities of this level (`LanHost::states`), as its last tick described
    /// them: what its players' moves are checked against before this tick describes them again.
    // rust: lan_states: horizon_client::lan::entity::States,
    /// Only the per-level parts of these are used (`swap_level`).
    // rust: anims: BlockEntityAnims,
    // rust: raiding: Raiding,
    // rust: sculk: SculkState,
    // rust: creaking: CreakingState,
    /// Natural spawning's candidate cache: each level keeps its own players' squares.
    // rust: spawn_scratch: super::natural_spawning::SpawnScratch,
    /// Server ticks since a player was last in the level.
    // rust: idle: u32,
}

/// Which passes of the server tick the level in place runs: the first
/// reads the network (`Hub::poll`), the last ends the tick for every player
/// (`Hub::end_tick`). A tick with one level is both. `running` is the
/// tick rate manager's answer for this server tick, asked once before the
/// levels (`MinecraftServer.tickServer`); `None` outside `tick_server`.
    // rust: pub(super) struct Pass {
    // rust: pub first: bool,
    // rust: pub last: bool,
    // rust: pub running: Option<bool>,
    /// Set once this level's player packets were handled before block ticks.
    // rust: pub packets_drained: bool,
}

    // rust: impl Default for Pass {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: first: true,
    // rust: last: true,
    // rust: running: None,
    // rust: packets_drained: false,
}
}
}

/// The levels not in place, by dimension.
    // rust: pub(super) struct Levels {
    // rust: parked: HashMap<Dim, Parked>,
    /// The levels whose open the mods heard (`native_level_load`), each to
    /// be told closed once.
    // rust: heard_open: Vec<Dim>,
}

    // rust: impl Levels {
    /// Clear every parked level and dimensions recorded as heard open.
    // rust: pub(super) fn clear(&mut self) {
    // rust: self.parked.clear();
    // rust: self.heard_open.clear();
}

    /// A parked level, without opening or loading it.
    // rust: pub(super) fn parked_world(&self, dim: Dim) -> Option<&World> {
    // rust: self.parked.get(&dim).map(|level| &level.world)
}

    /// The worlds of the levels not in place.
    // rust: pub(super) fn parked_worlds(&self) -> impl Iterator<Item = &World> {
    // rust: self.parked.values().map(|level| &level.world)
}

    /// The world of the level not in place, in `dim`, to change.
    // rust: pub(super) fn parked_world_mut(&mut self, dim: Dim) -> Option<&mut World> {
    // rust: self.parked.get_mut(&dim).map(|level| &mut level.world)
}

    /// The level not in place, in `dim`.
    // rust: pub(super) fn parked_mut(&mut self, dim: Dim) -> Option<&mut Parked> {
    // rust: self.parked.get_mut(&dim)
}

    /// The entities of a parked level, counted as `Game::entity_count` counts the one in place.
    // rust: pub(super) fn parked_entity_count(&self, dim: Dim) -> Option<usize> {
    // rust: let l = self.parked.get(&dim)?;
    // rust: Some(
    // rust: l.mobs.iter().filter(|m| !m.removed).count()
    // rust: + l.dropped.len()
    // rust: + l.orbs.len()
    // rust: + l.projectiles.len()
    // rust: + l.carts.len()
    // rust: + l.boats.len()
    // rust: + l.falling.len()
    // rust: + l.paintings.len()
    // rust: + l.item_frames.len()
    // rust: + l.armor_stands.len()
    // rust: + l.cushions.len()
    // rust: + l.tridents.len()
    // rust: + l.rockets.len()
    // rust: + l.tnts.len(),
    // rust: )
}

    /// The mobs of a parked level.
    // rust: pub(super) fn parked_mobs(&self, dim: Dim) -> Option<&[Mob]> {
    // rust: self.parked.get(&dim).map(|level| level.mobs.as_slice())
}

    /// A parked level's loose entities, for `horizon-report`: items, experience orbs,
    /// projectiles, minecarts and boats.
    // rust: pub(super) fn parked_entity_counts(&self, dim: Dim) -> Option<[usize; 5]> {
    // rust: self.parked.get(&dim).map(|l| {
    // rust: [
    // rust: l.dropped.as_slice().len(),
    // rust: l.orbs.as_slice().len(),
    // rust: l.projectiles.as_slice().len(),
    // rust: l.carts.as_slice().len(),
    // rust: l.boats.as_slice().len(),
    // rust: ]
    // rust: })
}

    /// The levels that are not in place, by dimension.
    /// The forced chunks of every level not in place, released.
    // rust: pub(super) fn release_parked_forced_chunks(&mut self) {
    // rust: for level in self.parked.values_mut() {
    // rust: level.streaming.forced.clear();
}
}

    // rust: pub(super) fn parked_dims(&self) -> Vec<Dim> {
    // rust: self.parked.keys().copied().collect()
}
}

    // rust: impl Game<'_> {
    /// A new level for `dim`, opened from the save (`MinecraftServer.createLevels`).
pub fn open_level(self: *Self, dim: Dim) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (streaming, save, locator) = super::world_loading::make_streaming(
    // rust: &self.res,
    // rust: &self.pack,
    // rust: &self.options,
    // rust: &self.settings,
    // rust: &self.world_root,
    // rust: dim,
    // rust: self.level_shapes.get(dim.id()),
    // rust: self.level.seed,
    // rust: &self.level.enabled_features,
    // rust: )?;
    // rust: let mut world = World::new(self.res.facts().air, self.level.seed);
    // rust: world.attachments = save.load_attachments();
    // rust: world.shape = self.level_shapes.get(dim.id());
    // rust: world.fast_lava = dim == Dim::Nether;
    // rust: Ok(Parked {
    // rust: world,
    // rust: streaming,
    // rust: locator,
    // rust: save,
    // rust: block_ticks: Ticks::new(self.level.seed as i32),
    // rust: tick_chunks: Default::default(),
    // rust: tickets: Default::default(),
    // rust: random_tick_sections: Default::default(),
    // rust: level_events: Vec::new(),
    // rust: portal_states: HashMap::new(),
    // rust: falling: Default::default(),
    // rust: paintings: Vec::new(),
    // rust: item_frames: Vec::new(),
    // rust: armor_stands: Default::default(),
    // rust: cushions: Vec::new(),
    // rust: others: Vec::new(),
    // rust: fangs: Default::default(),
    // rust: boats: Default::default(),
    // rust: carts: Default::default(),
    // rust: jukebox_sounds: HashMap::new(),
    // rust: bolts: Vec::new(),
    // rust: crystals: Vec::new(),
    // rust: dragon: None,
    // rust: dragon_fireballs: Vec::new(),
    // rust: breath_clouds: Vec::new(),
    // rust: tridents: Default::default(),
    // rust: rockets: Default::default(),
    // rust: ominous_spawners: Vec::new(),
    // rust: tnts: Default::default(),
    // rust: hoppers: HashMap::new(),
    // rust: mobs: Default::default(),
    // rust: knot_ids: HashMap::new(),
    // rust: projectiles: Default::default(),
    // rust: dropped: Default::default(),
    // rust: orbs: Default::default(),
    // rust: persist: Default::default(),
    // rust: lectern_pulses: Vec::new(),
    // rust: lid_openers: HashMap::new(),
    // rust: lan_events: Vec::new(),
    // rust: lan_block_events: Vec::new(),
    // rust: lan_entity_events: Vec::new(),
    // rust: lan_critical_hits: Vec::new(),
    // rust: lan_states: Default::default(),
    // rust: anims: Default::default(),
    // rust: raiding: Default::default(),
    // rust: sculk: Default::default(),
    // rust: creaking: Default::default(),
    // rust: spawn_scratch: Default::default(),
    // rust: idle: 0,
    // rust: })
}

    /// Exchange the level in place with `p`.
pub fn swap_level(self: *Self, p: *mut Parked) void {
}
//         use std::mem::swap;
    // rust: swap(&mut self.world, &mut p.world);
    // rust: swap(&mut self.streaming, &mut p.streaming);
    // rust: let mut locator = self.end.locator();
    // rust: swap(&mut locator, &mut p.locator);
    // rust: self.end.set_locator(locator);
    // rust: self.share_spawn_conditions();
    // rust: swap(&mut self.save, &mut p.save);
    // rust: swap(&mut self.block_ticks, &mut p.block_ticks);
    // rust: swap(&mut self.tick_chunks, &mut p.tick_chunks);
    // rust: swap(&mut self.tickets, &mut p.tickets);
    // rust: swap(&mut self.random_tick_sections, &mut p.random_tick_sections);
    // rust: swap(&mut self.level_events, &mut p.level_events);
    // rust: swap(&mut self.portals.entities, &mut p.portal_states);
    // rust: swap(&mut self.falling, &mut p.falling);
    // rust: swap(&mut self.paintings, &mut p.paintings);
    // rust: swap(&mut self.item_frames, &mut p.item_frames);
    // rust: swap(&mut self.armor_stands, &mut p.armor_stands);
    // rust: swap(&mut self.cushions, &mut p.cushions);
    // rust: swap(&mut self.others, &mut p.others);
    // rust: swap(&mut self.fangs, &mut p.fangs);
    // rust: swap(&mut self.boats, &mut p.boats);
    // rust: swap(&mut self.carts, &mut p.carts);
    // rust: swap(&mut self.jukebox_sounds, &mut p.jukebox_sounds);
    // rust: swap(&mut self.bolts, &mut p.bolts);
    // rust: swap(&mut self.crystals, &mut p.crystals);
    // rust: swap(&mut self.dragon, &mut p.dragon);
    // rust: swap(&mut self.dragon_fireballs, &mut p.dragon_fireballs);
    // rust: swap(&mut self.breath_clouds, &mut p.breath_clouds);
    // rust: swap(&mut self.tridents, &mut p.tridents);
    // rust: swap(&mut self.rockets, &mut p.rockets);
    // rust: swap(&mut self.ominous_spawners, &mut p.ominous_spawners);
    // rust: swap(&mut self.tnts, &mut p.tnts);
    // rust: swap(&mut self.hoppers, &mut p.hoppers);
    // rust: swap(&mut self.mobs, &mut p.mobs);
    // rust: swap(&mut self.knot_ids, &mut p.knot_ids);
    // rust: swap(&mut self.creatures.projectiles, &mut p.projectiles);
    // rust: swap(&mut self.dropped, &mut p.dropped);
    // rust: swap(&mut self.orbs, &mut p.orbs);
    // rust: swap(&mut self.persist, &mut p.persist);
    // rust: swap(&mut self.lectern_pulses, &mut p.lectern_pulses);
    // rust: swap(&mut self.lid_openers, &mut p.lid_openers);
    // rust: swap(&mut self.lan_events, &mut p.lan_events);
    // rust: swap(&mut self.lan_block_events, &mut p.lan_block_events);
    // rust: swap(&mut self.lan_entity_events, &mut p.lan_entity_events);
    // rust: swap(&mut self.lan_critical_hits, &mut p.lan_critical_hits);
    // rust: let (a, b) = (&mut self.be_anims, &mut p.anims);
    // rust: swap(&mut a.chests, &mut b.chests);
    // rust: swap(&mut a.books, &mut b.books);
    // rust: swap(&mut a.shulkers, &mut b.shulkers);
    // rust: swap(&mut a.bells, &mut b.bells);
    // rust: swap(&mut a.conduits, &mut b.conduits);
    // rust: swap(&mut a.skulls, &mut b.skulls);
    // rust: swap(&mut a.pots, &mut b.pots);
    // rust: swap(&mut a.gateways, &mut b.gateways);
    // rust: swap(&mut a.gateway_servers, &mut b.gateway_servers);
    // rust: swap(&mut a.conduit_servers, &mut b.conduit_servers);
    // rust: self.raiding.swap_level(&mut p.raiding);
    // rust: self.sculk.swap_level(&mut p.sculk);
    // rust: self.creaking.swap_level(&mut p.creaking);
    // rust: swap(&mut self.spawn_scratch, &mut p.spawn_scratch);
        // What only the client draws starts over.
    // rust: self.particles.clear();
    // rust: self.pickups.clear();
}

    /// Put `target`'s level in place, opening it first if it is not loaded.
    /// The level that was in place is kept with the others; the shared
    /// clock and weather go with the swap. `host` is the hub when the caller
    /// holds it (`self.lan` is taken during the network tick).
    // rust: pub(super) fn enter_level(
    // rust: &mut self,
    // rust: mut host: Option<&mut LanHost>,
    // rust: target: Dim,
    // rust: ) -> Result<()> {
        // A client holds no levels.
    // rust: if self.options.execution_role.is_client() {
    // rust: return Ok(());
}
    // rust: if target != self.dim {
    // rust: let (mut p, opened) = match self.levels.parked.remove(&target) {
    // rust: Some(p) => (p, false),
    // rust: None => (self.open_level(target)?, true),
}
    // rust: p.world.game_time = self.world.game_time;
    // rust: p.world.day_time = self.world.day_time;
    // rust: p.world.weather = self.world.weather;
            // The game rules and the difficulty are the server's, not a
            // level's: natural regeneration holds in every dimension.
    // rust: p.world.health_rules = self.world.health_rules;
            // The sculk tables' watched blocks are built once per game.
    // rust: p.world.watched = std::mem::take(&mut self.world.watched);
    // rust: self.swap_level(&mut p);
            // The tracked entities go with their level: a level's moves, read before its tick
            // describes its entities again, would otherwise meet the last level's (the anticheat
            // missed the boat under a player while anyone was in another dimension).
    // rust: let states = match host.as_deref_mut() {
    // rust: Some(h) => Some(&mut h.states),
    // rust: None => self.lan.as_mut().map(|h| &mut h.states),
}
    // rust: if let Some(states) = states {
    // rust: std::mem::swap(states, &mut p.lan_states);
}
    // rust: p.idle = 0;
    // rust: let left = std::mem::replace(&mut self.dim, target);
    // rust: self.levels.parked.insert(left, p);
    // rust: if opened {
                // The new streaming's radius and meshing options.
    // rust: self.apply_settings();
    // rust: self.native_level_opened(target);
}
}
    // rust: let host = match host {
    // rust: Some(h) => Some(h),
    // rust: None => self.lan.as_mut(),
}
    // rust: if let Some(h) = host {
    // rust: h.hub.set_dimension(target.id());
}
    // rust: Ok(())
}

    /// The entity's memory (its UUID and the compound it was loaded with)
    /// moves with it from the level not in place to the level in place, so
    /// it is saved in the other level as it was.
    // rust: pub(super) fn move_entity_memory(&mut self, from: Dim, id: u32) {
    // rust: let Some(p) = self.levels.parked.get_mut(&from) else {
    // rust: return;
}
    // rust: let uuid = p.persist.uuids.remove(&id);
    // rust: let raw = p.persist.raw.remove(&id);
    // rust: if let Some(u) = uuid {
    // rust: self.persist.uuids.insert(id, u);
}
    // rust: if let Some(r) = raw {
    // rust: self.persist.raw.insert(id, r);
}
}

    /// Far terrain for a client in `dim`: the level in place may be another
    /// one, the server ticking its levels in turn.
    // rust: pub(super) fn lod_source_in(
    // rust: &self,
    // rust: dim: Dim,
    // rust: ) -> Option<Arc<dyn horizon_client::streaming::LodSource>> {
    // rust: if dim == self.dim {
    // rust: return Some(self.streaming.lod_source());
}
    // rust: let parked = self.levels.parked.get(&dim)?;
    // rust: Some(parked.streaming.lod_source())
}

    /// Put `dim`'s level in place for a command whose source is there
    /// (`execute in`, `execute at` a player in another level), opening it if
    /// nobody is in it; returns the level to put back afterwards. Only a
    /// server holds other levels.
    // rust: pub(super) fn enter_command_level(&mut self, dim: Dim) -> Option<Dim> {
    // rust: if self.options.execution_role.is_client() || dim == self.dim {
    // rust: return None;
}
    // rust: let back = self.dim;
    // rust: match self.enter_level(None, dim) {
    // rust: Ok(()) => Some(back),
    // rust: Err(e) => {
    // rust: log::error!("could not open {}: {e}", dim.id());
    // rust: None
}
}
}

    /// One server tick (`MinecraftServer.tickServer`): each level with
    /// players or forced chunks in turn (`tickChildren`), its chunks streamed
    /// and loaded and its world ticked. The first pass reads the network and runs the
    /// tick's shared parts (the clock, the weather, functions, the autosave);
    /// the next ones only their level. While `paused`, only the connections
    /// run. The native server tick hook brackets it (`ServerTickStart` before
    /// the first level, `ServerTickEnd` after the last).
    // rust: pub(super) fn tick_server(&mut self, paused: bool) -> Result<()> {
        // `tickRateManager.tick()` once per server tick, before any level
        // (each `ServerLevel.tick` only reads `runsNormally`), and the native
        // `ServerTickStart` before that level work, where NeoForge fires
        // `ServerTickEvent.Pre`. A paused pass and a held server tick nothing.
    // rust: let running = (!paused && !self.agent.hold_server).then(|| self.clock.world_runs());
    // rust: let server = self.serving.is_some() || self.options.dedicated.is_some();
        // A config edited while the server is paused (empty) still reloads.
    // rust: if server {
    // rust: self.native_configs_poll();
}
    // rust: if let Some(running) = running
    // rust: && server
    // rust: {
    // rust: self.native_lifecycle_server_tick_start(running);
}
    // rust: let observe_level =
    // rust: running.is_some() && (self.serving.is_some() || self.options.dedicated.is_some());
    // rust: let dims = self.levels_to_tick();
    // rust: let order = dims.clone();
    // rust: let n = dims.len();
    // rust: let mut result = Ok(());
    // rust: for (k, dim) in dims.into_iter().enumerate() {
            // Each level's share of the tick (the first one also reads the network and runs the
            // tick's shared parts): `horizon-report`'s `level_*` spans.
    // rust: let _level_span = horizon_client::spans::guard(match dim {
    // rust: Dim::Overworld => "level_overworld",
    // rust: Dim::Nether => "level_the_nether",
    // rust: Dim::End => "level_the_end",
    // rust: });
    // rust: if let Err(e) = self.enter_level(None, dim) {
    // rust: result = Err(e);
    // rust: break;
}
    // rust: self.level_pass = Pass {
    // rust: first: k == 0,
    // rust: last: k + 1 == n,
    // rust: running,
    // rust: packets_drained: false,
}
    // rust: if observe_level {
    // rust: self.native_level_tick_pre(dim.id());
}
    // rust: self.update_dedicated_streaming();
    // rust: self.update_world();
    // rust: result = horizon_client::block_contact::in_level(
    // rust: (self.serving.is_some() || self.options.dedicated.is_some()).then_some(dim.id()),
    // rust: || {
    // rust: if paused {
    // rust: self.tick_lan(true);
    // rust: Ok(())
    // rust: } else if k == 0 {
    // rust: self.tick()
    // rust: } else {
    // rust: let running = running.unwrap_or_else(|| self.clock.world_runs());
                        // ClientLevel.tick: the sky flash fades in a frozen level too.
    // rust: self.tick_weather_effects();
    // rust: self.tick_world(running)
}
    // rust: },
    // rust: );
    // rust: if result.is_err() {
    // rust: break;
}
    // rust: if observe_level {
    // rust: self.native_level_tick_post(dim.id());
}
    // rust: self.publish_server_debug(dim);
            // An entity that crossed into a level that already ticked this
            // server tick is in it when the tick ends (`addDuringTeleport`).
    // rust: if running == Some(true) {
    // rust: let mut moved = false;
    // rust: for &earlier in &order[..k] {
    // rust: if !self.arrival_chunks(earlier).is_empty()
    // rust: && self.enter_level(None, earlier).is_ok()
    // rust: {
    // rust: self.land_portal_arrivals();
    // rust: moved = true;
}
}
    // rust: if moved {
    // rust: self.enter_level(None, dim)?;
}
}
}
    // rust: self.level_pass = Pass::default();
    // rust: if result.is_err() {
    // rust: self.native_lifecycle.cancel_server_tick();
}
    // rust: result?;
    // rust: if let Err(error) = self.close_idle_levels() {
    // rust: self.native_lifecycle.cancel_server_tick();
    // rust: return Err(error);
}
        // `ServerTickEnd`: an errored tick or an idle-close failure (at
        // the `?` above) never reaches this site.
    // rust: self.native_lifecycle_server_tick_end(paused);
    // rust: Ok(())
}

    /// `tick_server` as a server thread runs it. With `HORIZON_SPIKES=MS`, a
    /// tick longer than MS is logged with its thread CPU time and spans.
    // rust: pub(super) fn tick_server_timed(&mut self, paused: bool) -> Result<()> {
    // rust: self.tick_server_spans(paused, |_, _, _, _| {})
}

    /// `tick_server_timed`, handing the tick's wall time, thread CPU time
    /// and spans (milliseconds, summed by name) to `record` while spans are on, with how many
    /// spans the tick itself recorded: a dedicated server's performance report turns them on to
    /// record its ticks.
    // rust: pub(super) fn tick_server_spans(
    // rust: &mut self,
    // rust: paused: bool,
    // rust: record: impl FnOnce(f32, Option<f32>, Vec<horizon_client::spans::Span>, usize),
    // rust: ) -> Result<()> {
    // rust: if self.options.spikes.is_none() && !horizon_client::spans::enabled() {
    // rust: return self.tick_server(paused);
}
        // Spans recorded since the last tick ran between ticks (the chunk pump of the wait): they
        // stay in the tick's list, but only the tick's own count as recorded in it.
    // rust: let between = horizon_client::spans::take_raw();
    // rust: let (started, cpu) = (Instant::now(), horizon_client::spans::thread_cpu());
    // rust: let result = self.tick_server(paused);
    // rust: let wall = started.elapsed().as_secs_f32() * 1000.0;
    // rust: let cpu = horizon_client::spans::thread_cpu()
    // rust: .zip(cpu)
    // rust: .map(|(end, start)| (end - start).as_secs_f32() * 1000.0);
        // Taken every tick: nothing else takes this thread's spans.
    // rust: let raw = horizon_client::spans::take_raw();
    // rust: let in_tick = raw.len();
    // rust: let spans = if between.is_empty() {
    // rust: horizon_client::spans::merge(&raw)
    // rust: } else {
    // rust: horizon_client::spans::merge(&[between, raw].concat())
}
    // rust: let notes = horizon_client::spans::take_notes();
    // rust: if let Some(threshold) = self.options.spikes
    // rust: && wall > threshold
    // rust: {
    // rust: let cpu = cpu.map_or_else(String::new, |c| format!(", cpu {c:.1} ms"));
    // rust: log::info!(
    // rust: "Horizon: slow tick {wall:.1} ms{cpu} ({} mobs): {}{}",
    // rust: self.mobs.len(),
    // rust: horizon_client::spans::describe(&spans),
    // rust: slowest_steps(&notes)
    // rust: );
}
    // rust: record(wall, cpu, spans, in_tick);
    // rust: result
}

    /// The end of `MinecraftServer.runServer`'s loop for a server thread: a
    /// finished `/tick sprint` reports to the operators as the server, then
    /// the next tick starts one tick length after this one, or straight away
    /// while the sprint runs (`checkShouldSprintThisTick`). A server more
    /// than two seconds behind skips the ticks it missed: that returns how far
    /// behind it was, for the overload warning.
    // rust: pub(super) fn wait_for_next_server_tick(
    // rust: &mut self,
    // rust: next: &mut Instant,
    // rust: paused: bool,
    // rust: ) -> Option<Duration> {
    // rust: if let Some(report) = self.clock.take_sprint_report() {
            // ServerTickRateManager.finishTickSprint: the server's sendSuccess.
    // rust: self.console_broadcast = Some(true);
    // rust: self.sprint_report(&report);
    // rust: self.console_broadcast = None;
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: self.send_admin_feedback(&mut host, None);
    // rust: self.lan = Some(host);
}
    // rust: self.admin_feedback.clear();
}
    // rust: let now = Instant::now();
    // rust: if !paused && self.clock.sprinting() {
    // rust: *next = now;
    // rust: return None;
}
    // rust: *next += self.clock.tick_duration();
    // rust: if *next > now {
            // The chunks loading (the players', force-loaded ones, a
            // `/pregen` task) keep the workers fed until the next tick.
    // rust: self.pump_chunks(*next, paused);
    // rust: let now = Instant::now();
    // rust: if *next > now {
    // rust: std::thread::sleep(*next - now);
}
    // rust: } else if now - *next > Duration::from_secs(2) {
    // rust: let behind = now - *next;
    // rust: *next = now;
    // rust: return Some(behind);
}
    // rust: None
}

    /// The levels this server tick runs, in `MinecraftServer.levels` order
    /// (the Overworld, the Nether, the End): every level with a player in
    /// it, forced chunks or a `/pregen` task, or the Overworld while idle.
    // rust: pub(super) fn levels_to_tick(&self) -> Vec<Dim> {
    // rust: let guests = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .map_or(&[][..], |h| h.hub.guests.as_slice());
    // rust: let mut dims: Vec<Dim> = [Dim::Overworld, Dim::Nether, Dim::End]
    // rust: .into_iter()
    // rust: .filter(|d| {
                // `/forceload`ed chunks, or a native mod's tickets.
    // rust: let held = |s: &Streaming| !s.forced.is_empty() || !s.mod_forced.is_empty();
    // rust: let forced = if *d == self.dim {
    // rust: held(&self.streaming)
    // rust: } else {
    // rust: self.levels
    // rust: .parked
    // rust: .get(d)
    // rust: .is_some_and(|p| held(&p.streaming))
}
    // rust: guests.iter().any(|g| g.dimension == d.id())
                    // A viewer count not yet told to 0 (`tick_mod_container_viewers`).
    // rust: || self.mod_container_viewers.keys().any(|(k, _)| *k == d.id())
    // rust: || self.player_bed_levels().any(|b| b == *d)
    // rust: || forced
                    // A game test runs in its own level, players or not.
    // rust: || self.game_tests.has_tests_in(*d)
    // rust: || self.pregen_level() == Some(*d)
                    // A pending portal arrival keeps its destination level
                    // running so it can land and tick (the portal ticket).
    // rust: || !self.arrival_chunks(*d).is_empty()
                    // A portal ticket keeps its dimension active
                    // (`TicketType.shouldKeepDimensionActive`).
    // rust: || !self.portal_ticket_chunks(*d).is_empty()
    // rust: })
    // rust: .collect();
    // rust: if dims.is_empty() {
    // rust: dims.push(Dim::Overworld);
}
    // rust: dims
}

    /// The chunks holding a portal ticket in `dim`'s level (`placePortalTicket`).
    // rust: pub(super) fn portal_ticket_chunks(&self, dim: Dim) -> Vec<(i32, i32)> {
    // rust: if dim == self.dim {
    // rust: self.tickets.portal_chunks().collect()
    // rust: } else {
    // rust: self.levels
    // rust: .parked
    // rust: .get(&dim)
    // rust: .map_or_else(Vec::new, |p| p.tickets.portal_chunks().collect())
}
}

    /// Count the parked levels' empty ticks, and save and close the ones
    /// (other than the Overworld) nobody has been in for a while.
    // rust: pub(super) fn close_idle_levels(&mut self) -> Result<()> {
    // rust: let occupied = self.levels_to_tick();
        // A vehicle waiting there for its rider's arrival in another level.
    // rust: let waiting: Vec<Dim> = self
    // rust: .levels
    // rust: .parked
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|d| self.vehicle_waits_in(*d))
    // rust: .collect();
    // rust: let mut closing = Vec::new();
    // rust: for (dim, p) in &mut self.levels.parked {
    // rust: if occupied.contains(dim) || waiting.contains(dim) {
    // rust: p.idle = 0;
    // rust: continue;
}
    // rust: p.idle += 1;
    // rust: if *dim != Dim::Overworld && p.idle >= IDLE_TICKS {
    // rust: closing.push(*dim);
}
}
    // rust: if closing.is_empty() {
    // rust: return Ok(());
}
    // rust: let back = self.dim;
    // rust: for dim in closing {
    // rust: self.enter_level(None, dim)?;
            // Its chunks leave with it: the mods hear before its last save.
    // rust: let chunks: Vec<_> = self.world.chunks.values().cloned().collect();
    // rust: self.native_chunks_changed(&chunks);
    // rust: self.save_level(true)?;
            // Its entities' attachments are saved with them; they leave memory too.
    // rust: for uuid in self.persist.uuids.values() {
    // rust: self.entity_attachments.remove(uuid);
}
    // rust: self.enter_level(None, back)?;
    // rust: self.levels.parked.remove(&dim);
    // rust: self.native_level_closed(dim);
}
    // rust: Ok(())
}

    /// The mods hear `dim`'s level open (`LevelEvent.Load`), on a server.
    // rust: pub(super) fn native_level_opened(&mut self, dim: Dim) {
    // rust: if self.remote.is_some()
    // rust: || self.options.execution_role.is_client()
    // rust: || self.levels.heard_open.contains(&dim)
    // rust: {
    // rust: return;
}
    // rust: self.levels.heard_open.push(dim);
    // rust: self.native_level_load(dim.id());
}

    /// The mods hear `dim`'s level close (`LevelEvent.Unload`), once for
    /// each open they heard.
pub fn native_level_closed(self: *Self, dim: Dim) void {
}
    // rust: let Some(i) = self.levels.heard_open.iter().position(|d| *d == dim) else {
    // rust: return;
}
    // rust: self.levels.heard_open.remove(i);
    // rust: self.native_level_unload(dim.id());
}

    /// Every level still open closes with the server, however it ends
    /// (`MinecraftServer.stopServer`'s `level.close()` loop), in vanilla's
    /// order of its levels: the Overworld, the Nether, the End.
    // rust: pub(super) fn native_levels_closing(&mut self) {
    // rust: for dim in [Dim::Overworld, Dim::Nether, Dim::End] {
    // rust: self.native_level_closed(dim);
}
}

    /// Save every parked level (`MinecraftServer.saveAllChunks`); the level
    /// in place is the caller's to save.
    // rust: pub(super) fn save_parked_levels(&mut self, wait: bool) -> Result<()> {
    // rust: if self.levels.parked.is_empty() {
    // rust: return Ok(());
}
    // rust: let back = self.dim;
    // rust: let dims: Vec<Dim> = self.levels.parked.keys().copied().collect();
    // rust: for dim in dims {
    // rust: self.enter_level(None, dim)?;
    // rust: self.save_level(wait)?;
}
    // rust: self.enter_level(None, back)
}
}

/// A slow tick's line's end: the steps it noted as its slowest (`spans::note`), whose packets
/// or which player's event, or nothing.
pub fn slowest_steps(notes: *[(f32) void {
}
    // rust: if notes.is_empty() {
    // rust: return String::new();
}
    // rust: let list: Vec<String> = notes
    // rust: .iter()
    // rust: .map(|(ms, what)| format!("{what} {ms:.1}"))
    // rust: .collect();
    // rust: format!("; slowest: {}", list.join(", "))
}

    // rust: mod tests {
//     use super::*;

pub fn levels_clear_empties_parked_and_heard_open() void {
}
    // rust: let mut levels = Levels::default();
    // rust: levels.heard_open.push(Dim::Nether);
    // rust: assert!(!levels.heard_open.is_empty());
    // rust: levels.clear();
    // rust: assert!(levels.heard_open.is_empty());
    // rust: assert!(levels.parked.is_empty());
}
}
