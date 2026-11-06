//! Transpiled from Horizon Rust crate
package horizon_client_game_mode

import "core:fmt"
import "core:mem"
import "core:math"

// Game modes beyond survival and creative (`GameType`): adventure players
// cannot build, spectators fly through blocks and only watch.
// use super::{Game, Screen};
// use horizon_client::{collisions::SceneCollisions, command::args::GameMode};
// use horizon_world::world_movement::in_range_of_ground;

    // rust: pub(super) fn mode_id_of(mode: GameMode) -> i32 {
    // rust: match mode {
    // rust: GameMode::Survival => 0,
    // rust: GameMode::Creative => 1,
    // rust: GameMode::Adventure => 2,
    // rust: GameMode::Spectator => 3,
}
}
    // rust: pub(super) fn mode_from_id(id: i32) -> GameMode {
    // rust: match id {
    // rust: 1 => GameMode::Creative,
    // rust: 2 => GameMode::Adventure,
    // rust: 3 => GameMode::Spectator,
    // rust: _ => GameMode::Survival,
}
}
// `ChunkMap.skipPlayer`: a player is skipped when `player.isSpectator() &&
// !level.getGameRules().getBoolean(SPECTATORS_GENERATE_CHUNKS)`. A skipped
// player holds no distance-manager ticket and streams no chunks around
// itself, but still receives the chunks other players load (chunk sending
// is untouched).
    // rust: pub(super) fn loads_chunks(spectators_generate_chunks: bool, spectator: bool) -> bool {
    // rust: !spectator || spectators_generate_chunks
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn spectator(&self) -> bool {
    // rust: self.mode == GameMode::Spectator
}
    // `Abilities.mayBuild`.
    // rust: pub(super) fn may_build(&self) -> bool {
    // rust: matches!(self.mode, GameMode::Survival | GameMode::Creative)
}
    // rust: pub(super) fn mode_id(&self) -> i32 {
    // rust: mode_id_of(self.mode)
}
    // rust: pub(super) fn set_mode_id(&mut self, id: i32) {
    // rust: self.set_mode(mode_from_id(id));
}
    // `ServerPlayer.setGameMode` and `GameType.updatePlayerAbilities`.
    // rust: pub(super) fn set_mode(&mut self, mode: GameMode) {
    // rust: let was_spectator = self.spectator();
    // rust: let changed = mode != self.mode;
        // MultiPlayerGameMode.setLocalMode: the mode it leaves.
    // rust: if changed {
    // rust: self.previous_mode = Some(self.mode);
}
    // rust: self.mode = mode;
    // rust: self.creative = mode == GameMode::Creative;
        // GameType.updatePlayerAbilities applies at once.
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.invulnerable = mode == GameMode::Creative || mode == GameMode::Spectator;
    // rust: p.may_fly = p.invulnerable;
}
    // rust: if mode == GameMode::Spectator {
    // rust: self.mining = None;
    // rust: self.using = None;
    // rust: self.left = false;
    // rust: self.dismount_for_spectator();
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.flying = true;
    // rust: p.spectator = true;
}
    // rust: } else if let Some(p) = self.player.as_mut() {
    // rust: p.spectator = false;
    // rust: if was_spectator {
    // rust: p.flying_speed = 0.05;
}
    // rust: if !self.creative {
    // rust: p.flying = false;
    // rust: } else if was_spectator {
    // rust: p.flying = true;
}
}
        // ServerPlayerGameMode.changeGameModeForPlayer: a player left flying
        // by the change lands when the ground is within a block.
    // rust: let flying = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| p.flying)
    // rust: .map(|p| p.bounds());
    // rust: if changed
    // rust: && mode != GameMode::Spectator
    // rust: && let Some(bounds) = flying
    // rust: {
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if in_range_of_ground(&mut scene, bounds)
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
    // rust: p.flying = false;
}
}
    // rust: if mode == GameMode::Spectator && self.screen == Screen::Inventory {
    // rust: self.screen = Screen::Playing;
}
}
}
    // rust: impl Game<'_> {
    // `ItemStack.canBreakBlockInAdventureMode` / `canPlaceOnBlockInAdventureMode`
    // for the main-hand stack: some predicate of its `can_break` or
    // `can_place_on` component (`AdventureModePredicate`: one block predicate
    // or a list) matches the block at `pos`. Predicates with `nbt` or
    // `components` need the block entity's data and never match.
adventure_predicate :: proc(self: ^Self, component: string, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
//         use horizon_world::nbt::Tag;
    // rust: let Some(tag) = self
    // rust: .held()
    // rust: .and_then(|s| s.data())
    // rust: .and_then(|d| d.other(component))
    // rust: else {
    // rust: return false;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let name = &self.res.facts().get(state).name;
    // rust: let properties = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map(|s| &s.properties);
    // rust: let matches = |p: &Tag| {
    // rust: if p.get("nbt").is_some() || p.get("components").is_some() {
    // rust: return false;
}
    // rust: let block_ok = match p.get("blocks") {
    // rust: None => true,
    // rust: Some(Tag::String(id)) => self.block_in_holder_set(&id.to_string_lossy(), name),
    // rust: Some(Tag::List(ids)) => ids.iter().any(|id| match id {
    // rust: Tag::String(id) => self.block_in_holder_set(&id.to_string_lossy(), name),
    // rust: _ => false,
    // rust: }),
    // rust: Some(_) => false,
}
            // StatePropertiesPredicate: every property exact, or in a min/max range.
    // rust: let state_ok = match p.get("state") {
    // rust: None => true,
    // rust: Some(Tag::Compound(want)) => want.iter().all(|(key, matcher)| {
    // rust: let Some(have) = properties.and_then(|p| p.get(&key.to_string_lossy())) else {
    // rust: return false;
}
    // rust: match matcher {
    // rust: Tag::String(value) => *have == value.to_string_lossy(),
    // rust: Tag::Compound(_) => {
    // rust: let bound = |k: &str| match matcher.get(k) {
    // rust: Some(Tag::String(v)) => Some(v.to_string_lossy()),
    // rust: _ => None,
}
    // rust: let in_range = |have: &str, v: Option<String>, above: bool| {
    // rust: v.is_none_or(|v| match (have.parse::<i64>(), v.parse::<i64>()) {
    // rust: (Ok(h), Ok(b)) if above => h >= b,
    // rust: (Ok(h), Ok(b)) => h <= b,
    // rust: _ => false,
    // rust: })
}
    // rust: in_range(have, bound("min"), true)
    // rust: && in_range(have, bound("max"), false)
}
    // rust: _ => false,
}
    // rust: }),
    // rust: Some(_) => false,
}
    // rust: block_ok && state_ok
}
    // rust: match tag {
    // rust: Tag::List(list) => list.iter().any(matches),
    // rust: single => matches(single),
}
}
    // A `HolderSet<Block>` entry: a block id or a `#tag`.
block_in_holder_set :: proc(self: ^Self, entry: string, block: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let namespaced = |id: &str| {
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}
    // rust: match entry.strip_prefix('#') {
    // rust: Some(tag) => self.res.items().block_in_tag(&namespaced(tag), block),
    // rust: None => namespaced(entry) == block,
}
}
    // `Player.blockActionRestricted` for the block at `pos`: spectators never
    // act on blocks, adventure players only with a main-hand item whose
    // `can_break` matches it.
    // rust: pub(super) fn block_action_restricted(&self, pos: [i32; 3]) -> bool {
    // rust: if self.spectator() {
    // rust: return true;
}
    // rust: !self.may_build() && !self.adventure_predicate("minecraft:can_break", pos)
}
    // `ItemStack.useOn` in adventure mode: the used item's `can_place_on`
    // matches the clicked block (`Player.mayUseItemAt`).
    // rust: pub(super) fn can_place_on_in_adventure(&self, clicked: [i32; 3]) -> bool {
    // rust: self.adventure_predicate("minecraft:can_place_on", clicked)
}
    // `ServerPlayer.setGameMode(SPECTATOR)`: `stopRiding`.
dismount_for_spectator :: proc(self: ^Self) {
}
    // rust: let Some(id) = self.riding else {
    // rust: return;
}
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: self.dismount(i);
    // rust: } else if let Some(i) = self.carts.iter().position(|c| c.id == id) {
    // rust: self.dismount_cart(i);
    // rust: } else {
    // rust: self.riding = None;
}
}
}

    // rust: mod tests {
//     use super::loads_chunks;

    // `ChunkMap.skipPlayer`: only a spectator with `spectators_generate_chunks`
    // off stops loading chunks around itself.
a_skipped_spectator_loads_no_chunks :: proc() {
}
    // rust: assert!(!loads_chunks(false, true), "spectator, rule off");
    // rust: assert!(loads_chunks(true, true), "spectator, rule on");
    // rust: assert!(
    // rust: loads_chunks(false, false),
    // rust: "survival, creative or adventure"
    // rust: );
    // rust: assert!(
    // rust: loads_chunks(true, false),
    // rust: "survival, creative or adventure, rule on"
    // rust: );
}
}
