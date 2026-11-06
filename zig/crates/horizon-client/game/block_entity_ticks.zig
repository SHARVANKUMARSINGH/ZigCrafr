//! Transpiled from Horizon Rust crate
//! Module: horizon-client_block_entity_ticks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Level.tickBlockEntities` for the block entities ticked together here
//! (hoppers, crafters, jukeboxes, beacons, creaking hearts, spawners, trial
//! spawners, vaults, beehives, furnaces and potent sulfur): only those whose state has a
//! ticker, in vanilla's list order (`horizon_client::block_entities`), in
//! chunks that tick blocks. Sculk, brewing stands and pistons tick in their
//! own passes.
// use super::Game;
// use horizon_client::{
    // rust: Result,
    // rust: block_entities::{Pos, Ticking},
    // rust: block_entity_anim::Ticker,
    // rust: containers::{BlockEntity, FurnaceKind, HOPPER_SLOTS},
    // rust: furnace::FurnaceCooking,
}
// use horizon_core::position::BlockPos;
// use horizon_world::registry::BlockStateId;

    // rust: impl Game<'_> {
    // rust: pub(super) fn tick_block_entities(&mut self) -> Result<()> {
    // rust: self.tick_mount_menu();
    // rust: self.tick_craft_table();
    // rust: self.tick_container_reach();
    // rust: self.load_entity_types();
    // rust: if !self.world.block_entities.has_states() {
    // rust: let states = self.ticking_states();
    // rust: self.world.block_entities.set_states(states);
    // rust: let containers = self.native_containers();
    // rust: self.world.block_entities.set_mod_containers(containers);
    // rust: let fluids = self.native_fluid_tables();
    // rust: self.world.block_entities.set_mod_fluids(fluids);
    // rust: let energy = self.native_energy_tables();
    // rust: self.world.block_entities.set_mod_energy(energy);
}
        // Only lingering cooldowns are dropped; a hopper that ticks checks
        // its own block. Once a second is soon enough for the rest.
    // rust: if self.world.game_time % 20 == 0 {
    // rust: self.forget_gone_hoppers();
}
    // rust: let ticking = self.block_ticking_area();
    // rust: let mut spawners = Vec::new();
    // rust: let mut trial_spawners = Vec::new();
    // rust: self.item_columns = Some(Default::default());
    // rust: for slot in self.world.block_entity_tickers().iter().copied() {
    // rust: let pos = slot.0;
            // Ticks before this one can remove it (`TickingBlockEntity.isRemoved`).
    // rust: if self.world.block_entities.is_asleep(&pos)
    // rust: || !self.world.block_entities.is_live(slot)
    // rust: || !ticking(pos.0, pos.2)
    // rust: || !self.border.contains(f64::from(pos.0), f64::from(pos.2))
    // rust: {
    // rust: continue;
}
    // rust: match self.world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::Chest(items)) if items.len() == HOPPER_SLOTS => {
    // rust: self.tick_hopper(pos)
}
    // rust: Some(BlockEntity::Crafter(_)) => self.tick_crafter(pos),
    // rust: Some(BlockEntity::Jukebox(_)) => self.tick_jukebox(pos),
    // rust: Some(BlockEntity::Beacon(_)) => self.tick_beacon_at(pos),
    // rust: Some(BlockEntity::CreakingHeart(_)) => self.tick_creaking_heart(pos)?,
    // rust: Some(BlockEntity::Spawner(_)) => {
    // rust: self.tick_spawner(pos)?;
    // rust: spawners.push(pos);
}
    // rust: Some(BlockEntity::TrialSpawner(_)) => {
    // rust: self.tick_trial_spawner(pos)?;
    // rust: trial_spawners.push(pos);
}
    // rust: Some(BlockEntity::Vault(_)) => self.tick_vault(pos)?,
    // rust: Some(BlockEntity::Beehive(_)) => self.tick_beehive(pos),
    // rust: Some(BlockEntity::Furnace(_)) => self.tick_furnace(pos)?,
    // rust: Some(BlockEntity::Brewing(_)) => self.tick_brewing_stand(pos)?,
    // rust: Some(BlockEntity::DaylightDetector) => self.tick_daylight_detector(pos),
    // rust: Some(BlockEntity::Campfire(_)) => self.tick_campfire(pos)?,
    // rust: Some(BlockEntity::Mod(_)) => self.tick_mod_block_entity(pos),
    // rust: Some(BlockEntity::PotentSulfur(_)) => {
    // rust: self.tick_potent_sulfur(pos)?;
                    // A window that simulates the world itself is its own
                    // client; a server's clients tick it on their own.
    // rust: if self.options.execution_role.is_client() {
    // rust: self.client_tick_potent_sulfur(pos);
}
}
    // rust: _ => {}
}
}
        // Items move between passes: the columns hold for this one only.
    // rust: self.item_columns = None;
    // rust: self.update_song_volumes();
    // rust: self.scan_for_hearts();
        // The client ticks (particles, sounds, the turning mob) are for a
        // window; a dedicated or integrated server has none.
    // rust: if self.options.dedicated.is_none() {
    // rust: self.client_tick_spawners(&spawners);
    // rust: for key in trial_spawners {
    // rust: self.client_tick_trial_spawner(key);
}
}
        // `ShulkerBoxBlockEntity.tick`: the lids of the boxes this level
        // animates. Their grown collision shape reaches the collision queries
        // through `World::shulkers`, and an opening lid pushes what it runs
        // into (`moveCollidedEntities`), as a moving piston does.
    // rust: let pushes = self.tick_shulkers();
    // rust: self.sync_shulkers();
    // rust: self.push_shulker_entities(pushes);
    // rust: Ok(())
}
    /// `ShulkerBoxBlockEntity.tick` for the boxes in block-ticking chunks, in
    /// position order: the lid's new progress, and the swept box of an opening
    /// lid for `moveCollidedEntities`. A box whose block is gone is dropped.
    /// The boxes are those the level animates: a box opens (`start_open` and
    /// block event 1) before it has one, exactly as vanilla's block entity is
    /// there from the start.
pub fn tick_shulkers(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ticking = self.block_ticking_area();
    // rust: let mut pushes = Vec::new();
    // rust: let mut gone = Vec::new();
    // rust: let positions: Vec<[i32; 3]> = self.be_anims.shulkers.keys().copied().collect();
    // rust: for pos in positions {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let Some(Ticker::Shulker { facing }) = self.be_anims.ticker(state.0) else {
    // rust: gone.push(pos);
    // rust: continue;
}
    // rust: if !ticking(pos[0], pos[2])
    // rust: || !self.border.contains(f64::from(pos[0]), f64::from(pos[2]))
    // rust: {
    // rust: continue;
}
    // rust: let tick = self
    // rust: .be_anims
    // rust: .shulkers
    // rust: .get_mut(&pos)
    // rust: .map(|shulker| shulker.tick(pos, facing));
    // rust: if let Some(push) = tick.and_then(|tick| tick.push) {
    // rust: pushes.push((pos, facing, push));
}
}
    // rust: for pos in gone {
    // rust: self.be_anims.shulkers.remove(&pos);
}
    // rust: pushes
}
    /// Copies the shulker box lids into the world, where the collision queries
    /// read them (`SceneCollisions::shulker_collision_state`), as
    /// `sync_moving_pistons` does for pistons.
    // rust: pub(super) fn sync_shulkers(&mut self) {
    // rust: self.world.shulkers.clear();
    // rust: self.world
    // rust: .shulkers
    // rust: .extend(self.be_anims.shulkers.iter().map(|(p, s)| (*p, s.clone())));
}
    /// `BlockState.getTicker` of every state, for the block entities ticked
    /// here. A creaking heart keeps its slot while uprooted (see
    /// `tick_creaking_heart`).
pub fn ticking_states(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: (0..registry.len())
    // rust: .map(|i| {
    // rust: let state = BlockStateId(i as u32);
    // rust: let name: &str = &self.res.facts().get(state).name;
    // rust: match name {
    // rust: "minecraft:hopper"
    // rust: | "minecraft:crafter"
    // rust: | "minecraft:beacon"
    // rust: | "minecraft:creaking_heart"
    // rust: | "minecraft:spawner"
    // rust: | "minecraft:trial_spawner"
    // rust: | "minecraft:vault"
    // rust: | "minecraft:beehive"
    // rust: | "minecraft:bee_nest"
    // rust: | "minecraft:brewing_stand"
    // rust: | "minecraft:daylight_detector"
                    // Lit, cookTick; unlit, cooldownTick.
    // rust: | "minecraft:campfire"
    // rust: | "minecraft:soul_campfire" => Ticking::Yes,
                    // Every state but dry has a ticker.
    // rust: "minecraft:potent_sulfur" => {
    // rust: let dry = registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("potent_sulfur_state"))
    // rust: .is_some_and(|v| v == "dry");
    // rust: if dry { Ticking::Idle } else { Ticking::Yes }
}
    // rust: "minecraft:jukebox" => {
    // rust: let record = registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("has_record"))
    // rust: .is_some_and(|v| v == "true");
    // rust: if record { Ticking::Yes } else { Ticking::Idle }
}
    // rust: n if FurnaceKind::from_block(n).is_some() => Ticking::Yes,
    // rust: n if !n.starts_with("minecraft:") && self.native_ticks(n) => Ticking::Yes,
    // rust: _ => Ticking::No,
}
    // rust: })
    // rust: .collect()
}
    /// `ServerLevel.shouldTickBlocksAt` in a block-ticking chunk
    /// (`LevelChunk.isTicking`, block coordinates), from every player's
    /// tickets (`update_chunk_tickets`).
pub fn block_ticking_area(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let levels = self.tickets.levels();
    // rust: move |x, z| levels.block_ticking_at(x, z)
}
    /// `DaylightDetectorBlock.tickEntity` of the detector at `pos`.
pub fn tick_daylight_detector(self: *Self, pos: Pos) void {
}
        // It updates every 20 game ticks (the behaviour checks this too).
    // rust: if self.world.game_time % 20 != 0 {
    // rust: return;
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| b.tick_daylight_detector(level, ticks, at));
    // rust: let _ = self.process_level_events();
}
    /// `AbstractFurnaceBlockEntity.serverTick` of the furnace at `pos`, and
    /// its block's `lit` following it.
pub fn tick_furnace(self: *Self, pos: Pos) R {
    // Implementation ported from Horizon
    return undefined;
}
        // What the hooks need from before the tick, without cloning stacks: the
        // fuel's id only while the furnace is out (it can light this tick), the
        // input's id (a last item is gone after it smelts) and the result count.
    // rust: let before = match self.world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::Furnace(f)) => (
    // rust: f.cooking_timer,
    // rust: (f.lit_remaining == 0)
    // rust: .then(|| f.items[1].as_ref().map(|s| s.item.clone()))
    // rust: .flatten(),
    // rust: f.items[0].as_ref().map(|s| s.item.clone()),
    // rust: f.items[2].as_ref().map_or(0, |s| s.count),
    // rust: ),
    // rust: _ => return Ok(()),
}
    // rust: let mut drops = Vec::new();
    // rust: let (lit, burning, smelted, smelting) = {
    // rust: let Some(BlockEntity::Furnace(f)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return Ok(());
}
    // rust: let lit = f.tick(
    // rust: world_recipes!(self),
    // rust: world_items!(self),
    // rust: self.res.providers(),
    // rust: &mut drops,
    // rust: );
    // rust: let burning = before.1.filter(|_| f.lit_remaining > 0);
    // rust: let smelted = f.items[2]
    // rust: .as_ref()
    // rust: .filter(|after| after.count > before.3)
    // rust: .map(|after| (before.2.clone(), after.item.clone()));
    // rust: let started = before.0 == 0 && f.cooking_timer > 0;
    // rust: let smelting = started
    // rust: .then(|| f.items[0].as_ref().map(|item| item.item.clone()))
    // rust: .flatten();
    // rust: (lit, burning, smelted, smelting)
}
    // rust: if let Some(item) = smelting {
    // rust: self.native_furnace_start_smelt([pos.0, pos.1, pos.2], &item);
}
    // rust: if let Some(fuel) = burning {
    // rust: self.native_furnace_burn([pos.0, pos.1, pos.2], &fuel);
}
    // rust: if let Some((Some(item), result)) = smelted {
    // rust: self.native_furnace_smelt([pos.0, pos.1, pos.2], &item, &result);
}
    // rust: for stack in drops {
    // rust: self.campfire_drop(pos, stack);
}
    // rust: let Some(lit) = lit else {
    // rust: if matches!(self.world.block_entities.get(&pos), Some(BlockEntity::Furnace(f)) if f.idle())
    // rust: {
    // rust: self.world.block_entities.sleep(pos);
}
    // rust: return Ok(());
}
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: if let Some(mut s) = self.pack.assets.registry.state(state).cloned()
    // rust: && s.properties.contains_key("lit")
    // rust: {
    // rust: s.properties.insert("lit".into(), lit.to_string());
    // rust: if let Ok(id) = self.pack.assets.registry.resolve(&s) {
    // rust: self.level_set([pos.0, pos.1, pos.2], id)?;
}
}
    // rust: Ok(())
}
}
