//! Transpiled from Horizon Rust crate
package horizon_client_campfire_douse

import "core:fmt"
import "core:mem"
import "core:math"

// `CampfireBlock.useItemOn`: an item in `#minecraft:douses_campfires` (the
// shovels) put on a lit campfire puts it out.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{Result, animate_tick::make_campfire_smoke, items::ItemStack};
// use horizon_core::position::BlockPos;
// use horizon_world::chunk::BlockState;

    // rust: impl Game<'_> {
    // The lit campfire at `pos` that `held` puts out, when the item is in
    // `#minecraft:douses_campfires` (`CampfireBlock.useItemOn`).
campfire_to_douse :: proc(self: ^Self, pos: [i32; 3], held: Maybe(^ItemStack)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: held.filter(|s| {
    // rust: self.res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:douses_campfires")
    // rust: .is_some_and(|members| members.contains(&*s.item))
    // rust: })?;
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .filter(|s| matches!(&*s.name, "minecraft:campfire" | "minecraft:soul_campfire"))
    // rust: .filter(|s| s.properties.get("lit").map(String::as_str) == Some("true"))
    // rust: .cloned()
}

    // `CampfireBlock.useItemOn` as this client runs it before the server's
    // answer (`MultiPlayerGameMode.useItemOn`): the twenty smoke puffs of
    // `CampfireBlock.douse` and the campfire gone out, kept as predicted
    // under `seq`. The level event's sound comes from the server. True when
    // it doused (SUCCESS), which ends the click for both hands.
    // rust: pub(super) fn predict_campfire_douse(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: held: Option<&ItemStack>,
    // rust: seq: i32,
    // rust: ) -> bool {
        // Player.isSecondaryUseActive: a held item means both hands count.
    // rust: if self.keys.held(Action::Sneak) {
    // rust: return false;
}
    // rust: let Some(mut state) = self.campfire_to_douse(pos, held) else {
    // rust: return false;
}
    // rust: let signal = state.properties.get("signal_fire").map(String::as_str) == Some("true");
    // rust: for _ in 0..20 {
    // rust: make_campfire_smoke(&mut self.particles, pos, signal, true);
}
    // rust: state.properties.insert("lit".into(), "false".into());
    // rust: if let Ok(unlit) = self.pack.assets.registry.resolve(&state) {
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.predict_blocks(&vec![(at, unlit)], seq);
}
    // rust: true
}

    // `CampfireBlock.useItemOn` with `held` in the hand that acts, the block
    // at `pos` clicked: true when it doused a lit campfire (SUCCESS).
    // rust: pub(super) fn use_campfire_douse(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: held: Option<&ItemStack>,
    // rust: ) -> Result<bool> {
    // rust: let (Some(used), Some(mut state)) = (held.cloned(), self.campfire_to_douse(pos, held))
    // rust: else {
    // rust: return Ok(false);
}
    // rust: let registry = self.pack.assets.registry;
        // Level event 1009 (SOUND_EXTINGUISH_FIRE) goes to every player.
    // rust: self.level_event_at(1009, pos, 0);
        // CampfireBlock.douse: the acting client's own smoke (twenty puffs),
        // then the block change game event from the player.
    // rust: if self.lan_acting.is_none() {
    // rust: let signal = state.properties.get("signal_fire").map(String::as_str) == Some("true");
    // rust: for _ in 0..20 {
    // rust: make_campfire_smoke(&mut self.particles, pos, signal, true);
}
}
    // rust: self.post_block_game_event("minecraft:block_change", pos, self.sculk_actor(), None);
    // rust: state.properties.insert("lit".into(), "false".into());
    // rust: if let Ok(unlit) = registry.resolve(&state) {
    // rust: self.level_set(pos, unlit)?;
}
    // rust: self.damage_held(1);
        // ServerPlayerGameMode.useItemOn: the action was consumed.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, &used);
    // rust: Ok(true)
}
}
