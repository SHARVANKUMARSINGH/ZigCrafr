//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pumpkin
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PumpkinBlock.useItemOn`: shears carve a pumpkin into a carved pumpkin
//! facing the clicked side (the side facing the player on the top and
//! bottom), and the `carve/pumpkin` seeds pop out of that side.
// use super::Game;
// use horizon_client::{Result, items::ItemStack};
// use horizon_core::random::RandomSource;

    // rust: impl Game<'_> {
    /// `PumpkinBlock.useItemOn` with `held` in the hand that acts, the block
    /// at `pos` clicked on `face`: true when shears carved it (SUCCESS).
    // rust: pub(super) fn use_pumpkin(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: held: Option<&ItemStack>,
    // rust: ) -> Result<bool> {
    // rust: let Some(shears) = held.filter(|s| &*s.item == "minecraft:shears") else {
    // rust: return Ok(false);
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if &*self.res.facts().get(state).name != "minecraft:pumpkin" {
    // rust: return Ok(false);
}
        // Up or down: player.getDirection().getOpposite().
    // rust: let (dx, dz) = if face[1] != 0 {
    // rust: match ((self.yaw / 90.0 + 0.5).floor() as i32).rem_euclid(4) {
    // rust: 0 => (0, -1),
    // rust: 1 => (1, 0),
    // rust: 2 => (0, 1),
    // rust: _ => (-1, 0),
}
    // rust: } else {
    // rust: (face[0], face[2])
}
    // rust: let facing = match (dx, dz) {
    // rust: (0, -1) => "north",
    // rust: (0, 1) => "south",
    // rust: (-1, 0) => "west",
    // rust: _ => "east",
}
        // dropFromBlockInteractLootTable(CARVE_PUMPKIN): each stack as an
        // ItemEntity in front of the carved side, moved by the level random
        // (no pickup delay).
    // rust: let (dx, dz) = (f64::from(dx), f64::from(dz));
    // rust: let table = "minecraft:carve/pumpkin";
    // rust: let mut drops = self.sequence_loot(table, table, Some(shears));
    // rust: let origin = pos.map(|c| f64::from(c) + 0.5);
    // rust: self.native_use_drops(
    // rust: table,
    // rust: origin,
    // rust: Some((pos, state)),
    // rust: None,
    // rust: Some(shears),
    // rust: &mut drops,
    // rust: );
    // rust: for seeds in drops {
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5 + dx * 0.65,
    // rust: f64::from(pos[1]) + 0.1,
    // rust: f64::from(pos[2]) + 0.5 + dz * 0.65,
    // rust: ];
    // rust: let r = &mut self.world.random;
    // rust: let vx = 0.05 * dx + r.next_double() * 0.02;
    // rust: let vz = 0.05 * dz + r.next_double() * 0.02;
    // rust: self.spawn_item(seeds, at, [vx, 0.05, vz], 0);
}
    // rust: self.audio.play(
    // rust: "minecraft:block.pumpkin.carve",
    // rust: Some([
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: let registry = self.pack.assets.registry;
    // rust: let carved = registry
    // rust: .default_state("minecraft:carved_pumpkin")
    // rust: .and_then(|d| {
    // rust: let mut s = registry.state(d)?.clone();
    // rust: s.properties.insert("facing".into(), facing.into());
    // rust: registry.resolve(&s).ok()
    // rust: });
    // rust: if let Some(carved) = carved {
    // rust: self.set_golem_head(pos, carved)?;
}
    // rust: self.damage_held(1);
    // rust: self.post_block_game_event("minecraft:shear", pos, self.sculk_actor(), None);
    // rust: self.award_stat("used", "minecraft:shears", 1);
        // ServerPlayerGameMode.useItemOn: the action was consumed.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, shears);
    // rust: Ok(true)
}
}
