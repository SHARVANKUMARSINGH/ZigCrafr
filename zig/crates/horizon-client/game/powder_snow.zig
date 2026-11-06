//! Transpiled from Horizon Rust crate
//! Module: horizon-client_powder_snow
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Powder snow around the player: its snowflakes, fire put out by it, and the
//! bucket that picks it up (`BucketItem.use` on a `BucketPickup` block). The
//! sinking, slowing, climbing and freezing are `PlayerMotion`'s
//! (`crate::motion`); placing it is the powder snow bucket's `BlockItem.place`.
// use super::Game;
// use horizon_client::{Result, items::ItemStack, mobs::Who};
// use horizon_core::{position::BlockPos, random::RandomSource};

    // rust: impl Game<'_> {
    /// Entity.playEntityOnFireExtinguishedSound
    // rust: pub(super) fn extinguish_sound(&mut self, at: [f64; 3]) {
    // rust: let r = self.particles.random();
    // rust: let pitch = 1.6 + (r.next_float() - r.next_float()) * 0.4;
    // rust: self.audio.play(
    // rust: "minecraft:entity.generic.extinguish_fire",
    // rust: Some(at),
    // rust: 0.7,
    // rust: pitch,
    // rust: );
}
    /// `Entity.applyEffectsFromBlocks`: a burning player in the rain
    /// (`isInRain`) has the fire put out (`clearFire`), with the extinguish
    /// sound that everyone near hears.
    // rust: pub(super) fn rain_extinguish_player(&mut self) {
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let (at, top) = (player.position, player.bounds().max_position().y);
    // rust: if player.fire_ticks <= 0 || !self.in_rain(at, top) {
    // rust: return;
}
    // rust: if let Some(player) = self.player.as_mut() {
    // rust: player.fire_ticks = 0;
}
    // rust: self.extinguish_sound([at.x, at.y, at.z]);
}
    /// Whether the block at `pos` is powder snow.
    // rust: pub(super) fn is_powder_snow(&self, pos: [i32; 3]) -> bool {
    // rust: &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: == "minecraft:powder_snow"
}
    /// `BucketItem.use` with an empty bucket on powder snow:
    /// `PowderSnowBlock.pickupBlock` (air, level event 2001), the used
    /// statistic, the fill sound, FLUID_PICKUP, `ItemUtils.createFilledResult`
    /// and the filled_bucket trigger.
    // rust: pub(super) fn pick_up_powder_snow(&mut self, pos: [i32; 3]) -> Result<()> {
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let creative = self.creative;
    // rust: let picked = self.with_level(|b, level, ticks| b.bucket_pickup(level, ticks, at, creative));
    // rust: self.process_level_events()?;
    // rust: let Some(filled) = picked else {
    // rust: return Ok(());
}
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: self.award_stat("used", "minecraft:bucket", 1);
    // rust: if let Some(eye) = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z])
    // rust: {
    // rust: self.audio.play(
    // rust: "minecraft:item.bucket.fill_powder_snow",
    // rust: Some(eye),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: self.post_block_game_event("minecraft:fluid_pickup", pos, Some(Who::Player), None);
    // rust: let filled = ItemStack::new(filled, 1);
    // rust: self.filled_result(filled.clone());
    // rust: self.trigger_item("minecraft:filled_bucket", &filled);
    // rust: self.swing_arm();
    // rust: Ok(())
}
    /// `ItemUtils.createFilledResult(held, player, filled)` for the held stack.
    // rust: pub(super) fn filled_result(&mut self, filled: ItemStack) {
    // rust: if self.creative {
            // Kept, and the filled one added unless the inventory has it.
    // rust: let has = self
    // rust: .inventory
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|s| s.same_item_same_components(&filled));
    // rust: if !has {
    // rust: let _ = self.give(filled);
}
    // rust: return;
}
    // rust: let held = self.held_mut();
    // rust: let last = held.as_ref().is_none_or(|s| s.count <= 1);
    // rust: if last {
    // rust: *held = Some(filled);
    // rust: return;
}
    // rust: if let Some(s) = held.as_mut() {
    // rust: s.count -= 1;
}
    // rust: if let Some(rest) = self.give(filled) {
    // rust: self.player_drop(rest);
}
}
}
