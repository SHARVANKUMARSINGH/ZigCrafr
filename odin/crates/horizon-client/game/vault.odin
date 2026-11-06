//! Transpiled from Horizon Rust crate
package horizon_client_vault

import "core:fmt"
import "core:mem"
import "core:math"

// Vaults in the game: `VaultBlockEntity.Server.tick` for every vault
// (`vault`), the block's state as it changes, the rewards it ejects, the
// keys players insert (`VaultBlock.useItemOn`) and the display item spinning
// inside (`VaultRenderer`).
// use super::Game;
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: Result,
    // rust: block_entity_render::vertex_light,
    // rust: containers::BlockEntity,
    // rust: item_render,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: vault::{Vault, VaultEvent, VaultLevel, VaultPlayer, VaultState},
}
// use horizon_core::random::LegacyRandom;

    // rust: type Pos = (i32, i32, i32);

// What a vault reads: the game time and the players.
Players :: struct {
    time: i64,
    players: [dynamic]VaultPlayer,
}
    // rust: impl VaultLevel for Players {
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.time
}
players :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.players.clone()
}
}

    // rust: impl Game<'_> {
vault_players :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let host = self.player.as_ref().map(|p| VaultPlayer {
    // rust: uuid: self.acting_uuid(),
    // rust: block: [p.position.x, p.position.y, p.position.z].map(|v| v.floor() as i32),
    // rust: spectator: self.spectator(),
    // rust: });
    // rust: let guests = self.lan_present().into_iter().map(|g| VaultPlayer {
    // rust: uuid: g.uuid,
    // rust: block: g.position.map(|v| v.floor() as i32),
    // rust: spectator: g.spectator,
    // rust: });
    // rust: Players {
    // rust: time: self.world.game_time,
    // rust: players: host.into_iter().chain(guests).collect(),
}
}
    // The vault at `key` with its block's state and ominous flag.
    // rust: pub(super) fn take_vault(&mut self, key: Pos) -> Option<(Box<Vault>, VaultState, bool)> {
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let block = self.pack.assets.registry.state(state)?;
    // rust: if block.name != "minecraft:vault" {
    // rust: return None;
}
    // rust: let current = block
    // rust: .properties
    // rust: .get("vault_state")
    // rust: .and_then(|s| VaultState::from_name(s))
    // rust: .unwrap_or_default();
    // rust: let ominous = block.properties.get("ominous").is_some_and(|v| v == "true");
    // rust: let Some(BlockEntity::Vault(vault)) = self.world.block_entities.take(&key) else {
    // rust: return None;
}
    // rust: Some((vault, current, ominous))
}
    // Runs `f` on the vault at `key` with the level random and a loot roll,
    // then applies its events.
    // rust: fn with_vault<T>(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: f: impl FnOnce(
    // rust: &mut Vault,
    // rust: &Players,
    // rust: &mut LegacyRandom,
    // rust: VaultState,
    // rust: bool,
    // rust: &mut horizon_client::vault::Roll<LegacyRandom>,
    // rust: &mut Vec<VaultEvent>,
    // rust: ) -> T,
    // rust: ) -> Option<Result<T>> {
    // rust: let (mut vault, current, ominous) = self.take_vault(key)?;
    // rust: let players = self.vault_players();
    // rust: let mut random = std::mem::replace(&mut self.world.random, LegacyRandom::new(0));
    // rust: let mut sequences = std::mem::take(&mut self.rand_sequences);
    // rust: let loot = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: );
    // rust: let seed = self.level.seed;
    // rust: let mut events = Vec::new();
    // rust: let out = {
            // LootTable.getRandomItems, stacks split; the reward rolls with the
            // table's random sequence.
    // rust: let mut roll = |table: &str, random: &mut LegacyRandom, sequence: bool| {
    // rust: let Some(loot) = &loot else {
    // rust: return Vec::new();
}
    // rust: let drops = match loot.random_sequence(table).filter(|_| sequence) {
    // rust: Some(s) => loot.roll_split(table, sequences.get(s, seed)),
    // rust: None => loot.roll_split(table, random),
}
    // rust: drops
    // rust: .iter()
    // rust: .map(horizon_client::structure_blocks::loot_item_with_components)
    // rust: .collect()
}
    // rust: f(
    // rust: &mut vault,
    // rust: &players,
    // rust: &mut random,
    // rust: current,
    // rust: ominous,
    // rust: &mut roll,
    // rust: &mut events,
    // rust: )
}
    // rust: self.world.random = random;
    // rust: self.rand_sequences = sequences;
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Vault(vault));
    // rust: Some(self.vault_events(key, events).map(|()| out))
}
    // The server tick of the vault at `key`, then its client tick when there
    // is a window.
    // rust: pub(super) fn tick_vault(&mut self, key: Pos) -> Result<()> {
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let ticked = self.with_vault(key, |v, l, random, state, ominous, roll, events| {
    // rust: v.server_tick(l, random, pos, state, ominous, roll, events);
    // rust: });
    // rust: if let Some(result) = ticked {
    // rust: result?;
}
    // rust: if self.options.dedicated.is_none() {
    // rust: self.client_tick_vault(key);
}
    // rust: Ok(())
}
    // `VaultBlock.useItemOn` with `held` in the hand that acts: true when the
    // vault took the click (an active vault, with anything in the hand).
    // rust: pub(super) fn use_vault(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> Result<bool> {
    // rust: let Some(stack) = held.cloned() else {
    // rust: return Ok(false);
}
    // rust: let player = self.acting_uuid();
    // rust: let used = self.with_vault(
    // rust: (pos[0], pos[1], pos[2]),
    // rust: |v, l, random, state, ominous, roll, events| {
    // rust: v.use_item_on(
    // rust: l,
    // rust: random,
    // rust: pos,
    // rust: state,
    // rust: ominous,
    // rust: player,
    // rust: Some(&stack),
    // rust: roll,
    // rust: events,
    // rust: )
    // rust: },
    // rust: );
    // rust: let Some(taken) = used.transpose()?.flatten() else {
    // rust: return Ok(false);
}
    // rust: if taken > 0 {
            // awardStat(ITEM_USED), then stackToInsert.consume(count, player).
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: for _ in 0..taken {
    // rust: self.consume_held();
}
}
        // ServerPlayerGameMode.useItemOn: the action was consumed.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, &stack);
    // rust: Ok(true)
}
vault_events :: proc(self: ^Self, key: Pos, events: [dynamic]VaultEvent) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let center = pos.map(|v| f64::from(v) + 0.5);
    // rust: for event in events {
    // rust: match event {
    // rust: VaultEvent::State(state) => self.set_vault_state(key, state)?,
    // rust: VaultEvent::BlockUpdated => self.mark_block_entity_updated(key),
    // rust: VaultEvent::LevelEvent(id, data) => self.level_event_at(id, pos, data),
    // rust: VaultEvent::Sound(name, volume, pitch) => {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{name}"), Some(center), volume, pitch)
}
                // Vec3.atBottomCenterOf(pos).relative(UP, 1.2), lowered by spawnItem.
    // rust: VaultEvent::Eject(stack, v) => {
    // rust: self.native_vault_loot(pos, &stack.item);
    // rust: self.spawn_item(stack, [center[0], center[1] + 0.7 - 0.125, center[2]], v, 0)
}
}
}
    // rust: Ok(())
}
    // `setBlockAndUpdate` with the new `vault_state`.
set_vault_state :: proc(self: ^Self, key: Pos, state: VaultState) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let current = self.world.block(key.0, key.1, key.2);
    // rust: let Some(mut block) = self.pack.assets.registry.state(current).cloned() else {
    // rust: return Ok(());
}
    // rust: block
    // rust: .properties
    // rust: .insert("vault_state".into(), state.name().into());
    // rust: let id = self.pack.assets.registry.resolve(&block)?;
    // rust: self.level_set([key.0, key.1, key.2], id)?;
    // rust: self.native_vault_change_state(self.dim.id(), [key.0, key.1, key.2], state.name());
    // rust: Ok(())
}
    // `VaultRenderer`: the display item of every vault near the camera that
    // shows one, turning above its floor.
    // rust: pub(super) fn vault_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: for (key, entity) in &self.world.block_entities {
    // rust: let BlockEntity::Vault(vault) = entity else {
    // rust: continue;
}
    // rust: let Some(stack) = &vault.display_item else {
    // rust: continue;
}
    // rust: let at = glam::DVec3::new(f64::from(key.0), f64::from(key.1), f64::from(key.2));
    // rust: if at.distance_squared(camera) >= 64.0 * 64.0 {
    // rust: continue;
}
    // rust: let state = self.resolve_item(stack, DisplayContext::Ground, None, 0);
    // rust: if state.is_empty() {
    // rust: continue;
}
    // rust: let pose =
    // rust: glam::Mat4::from_translation(
    // rust: (at - camera).as_vec3() + glam::Vec3::new(0.5, 0.4, 0.5),
    // rust: ) * glam::Mat4::from_rotation_y(vault.display_spin(alpha as f32).to_radians());
    // rust: let light = self.world.light(key.0, key.1, key.2);
    // rust: let seed =
    // rust: i64::from(self.pack.item_renderer.item_id(&stack.item)) + i64::from(stack.damage);
    // rust: for copy in item_render::cluster_poses(
    // rust: &state,
    // rust: pose,
    // rust: item_render::rendered_amount(stack.count),
    // rust: seed,
    // rust: ) {
    // rust: self.submit_item_world(&state, copy, vertex_light(light), out);
}
}
}
}
