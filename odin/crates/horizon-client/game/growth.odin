//! Transpiled from Horizon Rust crate
package horizon_client_growth

import "core:fmt"
import "core:mem"
import "core:math"

// Client glue for sapling growth and bone meal: installs the live feature
// registry, routes `BoneMealItem.useOn` through the behaviour library, and
// crops a growing plant's head with shears (`ShearsItem.useOn`).
// use super::Game;
// use horizon_client::{Result, items::ItemStack, vanillagen};
// use horizon_core::{geometry::Direction, position::BlockPos};
// use horizon_world::{level::classes::Class, worldgen::live::LiveFeatures};
// use std::sync::Arc;

    // rust: impl Game<'_> {
    // Load the configured/placed feature registry used by saplings, fungi
    // and bone meal (once per process; shares the generator's bundle).
    // rust: pub(super) fn install_live_features(&self) {
    // rust: install_live_features(&self.res, &self.pack, &self.options);
}
    // `BoneMealItem.useOn` for the targeted block.
    // rust: pub(super) fn use_bone_meal(&mut self, stack: &ItemStack) -> Result<bool> {
    // rust: if &*stack.item != "minecraft:bone_meal" {
    // rust: return Ok(false);
}
    // rust: let Some(hit) = self.pick() else {
    // rust: return Ok(false);
}
    // rust: let face = match hit.face {
    // rust: [0, 1, 0] => Direction::Up,
    // rust: [0, -1, 0] => Direction::Down,
    // rust: [0, 0, -1] => Direction::North,
    // rust: [0, 0, 1] => Direction::South,
    // rust: [-1, 0, 0] => Direction::West,
    // rust: _ => Direction::East,
}
    // rust: let pos = BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let used = self.with_level(|b, level, ticks| b.use_bone_meal(level, ticks, pos, face));
        // ItemStack.causeUseVibration at the player, after the meal is used
        // up (shrunk even in creative): an emptied stack has no use effects.
    // rust: if used
    // rust: && stack.count > 1
    // rust: && let Some(p) = self.player.as_ref().map(|p| p.position)
    // rust: {
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:item_interact_finish", [p.x, p.y, p.z], ctx);
}
    // rust: self.process_level_events()?;
    // rust: if used {
    // rust: self.swing_arm();
            // ItemStack.useOn: an item interaction counts as a use.
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.consume_held();
}
    // rust: Ok(used)
}
    // `ShearsItem.useOn` on a growing plant's head below its top age (kelp,
    // weeping and twisting vines, cave vines): the head goes to
    // `GrowingPlantHeadBlock.getMaxAgeState` (age 25) with
    // `block.growing_plant.crop`, the level hears a `block_change`, and the
    // shears wear by one. True when it cropped (SUCCESS).
    // rust: pub(super) fn shears_crop(&mut self, pos: [i32; 3], stack: &ItemStack) -> Result<bool> {
    // rust: if &*stack.item != "minecraft:shears" {
    // rust: return Ok(false);
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let b = self.res.behaviours();
        // A head grows and carries `AGE_25`; the plant's body below it does not.
    // rust: if !b.data(state).is(Class::GrowingPlantHead) {
    // rust: return Ok(false);
}
        // `GrowingPlantHeadBlock.isMaxAge`: the property's top value.
    // rust: if b.table.int(state, b.props.age) == 25 {
    // rust: return Ok(false);
}
        // `GrowingPlantHeadBlock.getMaxAgeState`.
    // rust: let max_age = b.table.set_int(state, b.props.age, 25);
    // rust: self.audio.play(
    // rust: "minecraft:block.growing_plant.crop",
    // rust: Some([
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.level_set(pos, max_age)?;
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: pos,
    // rust: self.sculk_actor(),
    // rust: Some(max_age),
    // rust: );
    // rust: self.damage_held(1);
        // ItemStack.useOn: an item interaction counts as a use.
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
        // ServerPlayerGameMode.useItemOn: a consuming useOn reports it.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, stack);
    // rust: Ok(true)
}
}

// Shared by the initialization worker and fixture setup.
    // rust: pub(super) fn install_live_features(
    // rust: res: &super::Resources,
    // rust: pack: &super::PackResources,
    // rust: options: &super::Options,
    // rust: ) {
    // rust: if res.behaviours().live_features().is_some() {
    // rust: return;
}
    // rust: let dir = options.resources.join("worldgen");
    // rust: let started = std::time::Instant::now();
    // rust: let features = vanillagen::shared_data(&dir, pack.assets.registry)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|data| LiveFeatures::new(&data).map_err(|e| e.to_string()));
    // rust: match features {
    // rust: Ok(Some(features)) => {
    // rust: res.behaviours().set_live_features(Arc::new(features));
    // rust: log::info!("Horizon: live features ready in {:?}", started.elapsed());
}
    // rust: Ok(None) => {
    // rust: log::warn!("Horizon: the worldgen bundle has no features; saplings will not grow")
}
    // rust: Err(e) => log::warn!("Horizon: live features unavailable: {e}"),
}
}
