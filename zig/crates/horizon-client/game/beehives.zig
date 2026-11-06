//! Transpiled from Horizon Rust crate
//! Module: horizon-client_beehives
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Beehives and bee nests in the game (`crate::beehive` holds their logic):
//! their server tick, bees going in, and the bees let out, angry, when a
//! player breaks the hive or fire reaches it.
// use super::Game;
// use horizon_client::{
    // rust: Result,
    // rust: beehive::{self, Beehive, BeehiveExt, HiveHost, Release},
    // rust: containers::BlockEntity,
    // rust: items::ItemStack,
    // rust: mobs::{Mob, Who, bee},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::{nbt::Tag, registry::BlockStateId};

pub const GameHive = struct {
    game: *'g mut Game<'a>,
};
    // rust: impl HiveHost for GameHive<'_, '_> {
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.game.world.random
}
pub fn bees_stay_in_hive(self: *Self, _at: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bee::bees_stay_in_hive(&self.game.mob_world_base(&[]))
}
pub fn blocked(self: *Self, at: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self
    // rust: .game
    // rust: .mob_world_base(&[])
    // rust: .block_collision_boxes(at[0], at[1], at[2])
    // rust: .is_empty()
}
pub fn set_honey_level(self: *Self, at: [i32; 3], level: i32) void {
}
    // rust: let state = self.game.world.block(at[0], at[1], at[2]);
    // rust: if let Some(state) = self.game.hive_with_honey(state, level) {
    // rust: let _ = self.game.level_set(at, state);
}
}
pub fn load(self: *Self, tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = horizon_client::entity_nbt::kind(tag)?;
    // rust: if !self
    // rust: .game
    // rust: .res
    // rust: .mob_data()
    // rust: .entity_has("minecraft:beehive_inhabitors", &kind)
    // rust: {
    // rust: return None;
}
    // rust: let id = self.game.load_mob(tag.clone(), None)?;
    // rust: let i = self.game.mobs.iter().position(|m| m.id == id)?;
    // rust: Some(self.game.mobs.remove(i))
}
pub fn add(self: *Self, m: Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.mobs.push(m);
    // rust: true
}
pub fn sound(self: *Self, name: *'static str, at: [f64; 3]) void {
}
    // rust: self.game
    // rust: .audio
    // rust: .play(&format!("minecraft:{name}"), Some(at), 1.0, 1.0);
}
}

    // rust: impl Game<'_> {
pub fn hive_with_honey(self: *Self, state: BlockStateId, level: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let mut s = registry.state(state)?.clone();
    // rust: s.properties
    // rust: .insert("honey_level".to_owned(), level.to_string());
    // rust: registry.resolve(&s).ok()
}
    /// The hive's honey level and front, from its block state.
    // rust: pub(super) fn hive_state(&self, at: [i32; 3]) -> Option<(Option<i32>, [i32; 2])> {
    // rust: let state = self.world.block(at[0], at[1], at[2]);
    // rust: let name = &self.res.facts().get(state).name;
    // rust: if !self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:beehives")
    // rust: .is_some_and(|t| t.contains(&**name))
    // rust: {
    // rust: return None;
}
    // rust: let props = &self.pack.assets.registry.state(state)?.properties;
    // rust: let honey = props.get("honey_level").and_then(|v| v.parse().ok());
    // rust: let facing = beehive::facing_step(props.get("facing").map(String::as_str));
    // rust: Some((honey, facing))
}
    /// `BeehiveBlockEntity.serverTick` of the hive at `key`, after an
    /// emergency exit if fire is beside it (`BeehiveBlock.updateShape`).
    // rust: pub(super) fn tick_beehive(&mut self, key: (i32, i32, i32)) {
    // rust: let at = [key.0, key.1, key.2];
    // rust: let Some((honey, facing)) = self.hive_state(at) else {
    // rust: return;
}
    // rust: let Some(BlockEntity::Beehive(mut hive)) = self.world.block_entities.take(&key) else {
    // rust: return;
}
    // rust: let fire = [
    // rust: [1, 0, 0],
    // rust: [-1, 0, 0],
    // rust: [0, 1, 0],
    // rust: [0, -1, 0],
    // rust: [0, 0, 1],
    // rust: [0, 0, -1],
    // rust: ]
    // rust: .iter()
    // rust: .any(|d| {
    // rust: let state = self.world.block(at[0] + d[0], at[1] + d[1], at[2] + d[2]);
    // rust: &*self.res.facts().get(state).name == "minecraft:fire"
    // rust: });
    // rust: let mut host = GameHive { game: self };
    // rust: if fire && !hive.bees.is_empty() {
    // rust: hive.release_all(at, facing, honey, Release::Emergency, &mut host);
}
    // rust: hive.server_tick(at, facing, honey, &mut host);
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Beehive(hive));
}
    /// `BeehiveBlockEntity.addOccupant` for a bee its `BeeEnterHiveGoal`
    /// sent in: off its lead, its tag stored, the bee gone.
    // rust: pub(super) fn bee_enter_hive(&mut self, mob: u32, at: [i32; 3]) {
    // rust: let key = (at[0], at[1], at[2]);
    // rust: let Some(i) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .position(|m| m.id == mob && m.alive() && !m.removed)
    // rust: else {
    // rust: return;
}
    // rust: if !matches!(self.world.block_entities.get(&key), Some(BlockEntity::Beehive(h)) if !h.full())
    // rust: {
    // rust: return;
}
    // rust: if self.mobs[i].extra.leash.is_some() {
    // rust: self.break_leash(mob, true, false);
    // rust: self.mobs[i].extra.leash = None;
}
    // rust: self.mobs[i].extra.mount = None;
    // rust: let tag = self.mob_tree_nbt(i);
    // rust: let flower = bee::get(&self.mobs[i]).and_then(|b| b.flower);
    // rust: let Some(BlockEntity::Beehive(mut hive)) = self.world.block_entities.take(&key) else {
    // rust: return;
}
    // rust: let stored = hive.add_occupant(at, tag, flower, &mut GameHive { game: self });
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Beehive(hive));
    // rust: if stored {
    // rust: let kind = self.mobs[i].kind.id.clone();
    // rust: let block = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(at[0], at[1], at[2]))
    // rust: .name
    // rust: .clone();
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.removed = true;
}
    // rust: self.native_entity_enter_block(mob, &kind, at, &block);
}
}
    /// `BeehiveBlockEntity.emptyAllLivingFromHive` with no player about.
    // rust: pub(super) fn empty_hive(&mut self, at: [i32; 3], facing: [i32; 2], status: Release) {
    // rust: let key = (at[0], at[1], at[2]);
    // rust: let Some(BlockEntity::Beehive(mut hive)) = self.world.block_entities.take(&key) else {
    // rust: return;
}
    // rust: hive.release_all(at, facing, None, status, &mut GameHive { game: self });
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Beehive(hive));
}
    /// `BeehiveBlock.playerDestroy` without silk touch: the bees come out
    /// angry at the player unless smoke calms them, then
    /// `angerNearbyBees`.
    // rust: pub(super) fn hive_broken_by_player(
    // rust: &mut self,
    // rust: at: [i32; 3],
    // rust: mut hive: Beehive,
    // rust: honey: Option<i32>,
    // rust: facing: [i32; 2],
    // rust: ) {
    // rust: let released = hive.release_all(
    // rust: at,
    // rust: facing,
    // rust: honey,
    // rust: Release::Emergency,
    // rust: &mut GameHive { game: self },
    // rust: );
    // rust: let sedated = beehive::smokey(&self.mob_world_base(&[]), at);
    // rust: if let Some(p) = self.player_view().map(|p| p.position) {
    // rust: for m in self.mobs.iter_mut().filter(|m| released.contains(&m.id)) {
    // rust: if m.distance_sqr(p) <= 16.0 {
    // rust: if sedated {
    // rust: bee::set_stay_out_of_hive_countdown(m);
    // rust: } else {
    // rust: m.ai.target = Some(Who::Player);
}
}
}
}
    // rust: self.anger_nearby_bees(at);
}
    /// `BeehiveBlock.useItemOn` with `held` in the acting hand: shears take
    /// the honeycombs and a glass bottle a honey bottle from a full hive
    /// (honey level 5), then the honey level resets and, unless a campfire
    /// smokes the hive, the bees come out angry. True when it took the click.
    // rust: pub(super) fn use_beehive(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> Result<bool> {
    // rust: let Some(held) = held else { return Ok(false) };
    // rust: let shears = &*held.item == "minecraft:shears";
    // rust: if !shears && &*held.item != "minecraft:glass_bottle" {
    // rust: return Ok(false);
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if !matches!(
    // rust: &*self.res.facts().get(state).name,
    // rust: "minecraft:beehive" | "minecraft:bee_nest"
    // rust: ) {
    // rust: return Ok(false);
}
    // rust: let prop = |key: &str| {
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get(key).cloned())
}
    // rust: if prop("honey_level").and_then(|v| v.parse::<i32>().ok()) != Some(5) {
    // rust: return Ok(false);
}
    // rust: let facing = beehive::facing_step(prop("facing").as_deref());
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: if shears {
            // dropHoneycomb (harvest/beehive), the shear sound, hurtAndBreak.
    // rust: for stack in self.sequence_loot(
    // rust: "minecraft:harvest/beehive",
    // rust: "minecraft:harvest/beehive",
    // rust: Some(held),
    // rust: ) {
    // rust: self.pop_resource(pos, stack);
}
    // rust: self.audio
    // rust: .play("minecraft:block.beehive.shear", at, 1.0, 1.0);
    // rust: self.damage_held(1);
    // rust: self.post_block_game_event("minecraft:shear", pos, self.sculk_actor(), None);
    // rust: } else {
            // shrink(1), then the honey bottle in the hand, the inventory or
            // on the ground.
    // rust: self.audio.play("minecraft:item.bottle.fill", at, 1.0, 1.0);
    // rust: let cell = self.held_mut();
    // rust: if let Some(s) = cell.as_mut() {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *cell = None;
}
}
    // rust: let bottle = ItemStack::new("minecraft:honey_bottle", 1);
    // rust: if self.held().is_none() {
    // rust: *self.held_mut() = Some(bottle);
    // rust: } else if let Some(rest) = self.give(bottle)
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
    // rust: self.spawn_item(rest, eye, [0.0, 0.1, 0.0], 40);
}
    // rust: self.post_block_game_event("minecraft:fluid_pickup", pos, self.sculk_actor(), None);
}
    // rust: self.award_stat("used", &held.item, 1);
    // rust: let smokey = beehive::smokey(&self.mob_world_base(&[]), pos);
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if !smokey
    // rust: && matches!(self.world.block_entities.get(&key), Some(BlockEntity::Beehive(h)) if !h.bees.is_empty())
    // rust: {
    // rust: self.anger_nearby_bees(pos);
}
        // resetHoneyLevel.
    // rust: if let Some(reset) = self.with_props(state, &[("honey_level", "0")]) {
    // rust: self.level_set(pos, reset)?;
}
    // rust: if !smokey
    // rust: && let Some(BlockEntity::Beehive(mut hive)) = self.world.block_entities.take(&key)
    // rust: {
            // emptyAllLivingFromHive: the bees within 4 blocks of the player
            // go for them.
    // rust: let released = hive.release_all(
    // rust: pos,
    // rust: facing,
    // rust: None,
    // rust: Release::Emergency,
    // rust: &mut GameHive { game: self },
    // rust: );
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Beehive(hive));
    // rust: if let Some(p) = self.player_view().map(|p| p.position) {
    // rust: for m in self.mobs.iter_mut().filter(|m| released.contains(&m.id)) {
    // rust: if m.distance_sqr(p) <= 16.0 {
    // rust: m.ai.target = Some(Who::Player);
}
}
}
}
        // ServerPlayerGameMode.useItemOn: the action was consumed.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, held);
    // rust: Ok(true)
}
    /// `BeehiveBlock.angerNearbyBees`: bees within 8 blocks (6 up and down)
    /// without a target go for a random player in the same box, the window's
    /// own or a guest (`None` is the window's player).
    // rust: pub(super) fn anger_nearby_bees(&mut self, at: [i32; 3]) {
    // rust: let min = Vec3::new(
    // rust: f64::from(at[0]) - 8.0,
    // rust: f64::from(at[1]) - 6.0,
    // rust: f64::from(at[2]) - 8.0,
    // rust: );
    // rust: let area = Aabb::new(min, Vec3::new(min.x + 17.0, min.y + 13.0, min.z + 17.0));
    // rust: let mut players: Vec<Option<u32>> = Vec::new();
    // rust: if self
    // rust: .player_view()
    // rust: .is_some_and(|p| p.bounds.intersects(area))
    // rust: {
    // rust: players.push(None);
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: players.extend(
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead)
    // rust: .filter(|g| super::lan_mobs::guest_bounds(g).intersects(area))
    // rust: .map(|g| Some(g.conn)),
    // rust: );
}
    // rust: if players.is_empty() {
    // rust: return;
}
    // rust: let mut bees: Vec<usize> = (0..self.mobs.len())
    // rust: .filter(|&i| {
    // rust: let m = &self.mobs[i];
    // rust: m.species() == horizon_client::mobs::Species::Bee
    // rust: && !m.removed
    // rust: && m.bounds().intersects(area)
    // rust: })
    // rust: .collect();
    // rust: bees.retain(|&i| self.mobs[i].ai.target.is_none());
    // rust: for i in bees {
            // Util.getRandom over the players.
    // rust: let pick = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(players.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: self.mobs[i].ai.target = Some(Who::Player);
            // The player a mob sees is its guest binding, else the window's.
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: match players[pick] {
    // rust: Some(conn) => host.mob_players.insert(self.mobs[i].id, conn),
    // rust: None => host.mob_players.remove(&self.mobs[i].id),
}
}
}
}
}
