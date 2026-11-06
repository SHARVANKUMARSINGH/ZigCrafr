//! Transpiled from Horizon Rust crate
package horizon_client_native_host_bridge

import "core:fmt"
import "core:mem"
import "core:math"

// `Host` forms of documented `Game` helpers that `dyn Host` could not carry:
// the generic `native_with_mod_block_entity`, the level services only the
// level hosts had (`play_sound`, `send_particles`), and what a client mod
// reads of its own player and of the block entities it draws
// (docs/native-mods.md, "Trait mods"). Each goes through the helper or the
// state the game's own code uses, so both answer alike.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: containers::{BlockEntity, ModBlockEntity},
    // rust: items::ItemStack,
    // rust: particles::ParticleOptions,
}
// use horizon_world::{player_inventory::EquipmentSlot, registry::BlockStateId};

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    // A copy of the mod block entity at `pos`, to read without changing it:
    // a press reading the basin under it, a client mod drawing a machine
    // from its neighbour's state. On a server, its saved compound, item
    // slots and data slots; on a client, what the server sent of it
    // (`native_block_entity_update_tag`, merged into `nbt`), with no item
    // slots. None for another kind of block entity, a block with none, and
    // on a server for the one ticking now, which is out of the world (as
    // for `native_with_mod_block_entity`). API @API:host_bridge@.
    // rust: pub(super) fn native_mod_block_entity(&self, pos: [i32; 3]) -> Option<ModBlockEntity> {
    // rust: match self.world.block_entities.get(&(pos[0], pos[1], pos[2])) {
    // rust: Some(BlockEntity::Mod(m)) if !m.id.is_empty() => Some(ModBlockEntity::clone(m)),
    // rust: _ => None,
}
}

    // `native_with_mod_block_entity` through `dyn Host`: runs `change` on
    // the mod block entity at `pos` (a burner heating the basin above it),
    // then, as its `setChanged` would, saves its chunk next time and lets
    // comparators read it again when its items changed. False, with
    // `change` not run, where `native_with_mod_block_entity` finds none.
    // Call `native_block_entity_sync` too when what clients draw changed.
    // API @API:host_bridge@.
    // rust: pub(super) fn native_change_mod_block_entity(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: change: &mut dyn FnMut(&mut ModBlockEntity),
    // rust: ) -> bool {
    // rust: self.native_with_mod_block_entity(pos, |m| change(m))
    // rust: .is_some()
}

    // Plays sound event `sound` at `at` for the players near it in the
    // level in place, as a level hook's `LevelWriteHost::play_sound` does
    // (`Level.playSound` with no player): a machine's hum from its block
    // entity's tick. `source` is the `SoundSource` ordinal (4 for
    // `BLOCKS`). True when queued, not heard; false off a server and where
    // the level host's `play_sound` refuses. API @API:host_bridge@.
    // rust: pub(super) fn native_level_play_sound(
    // rust: &mut self,
    // rust: sound: &str,
    // rust: at: [f64; 3],
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> bool {
    // rust: if !self.native_authoritative() {
    // rust: return false;
}
    // rust: self.with_level(|_, level, _| level.native_play_sound(sound, at, source, volume, pitch))
}

    // `ServerLevel.sendParticles` in the level in place, as a level hook's
    // `LevelWriteHost::send_particles` sends them: the players near `at`
    // see `count` particles spread by `spread` (a zero count sends one
    // moving `speed` along `spread`). `state` is the block of block
    // particles. True when accepted; false off a server and where the level
    // host's `send_particles` refuses. API @API:host_bridge@.
    // rust: pub(super) fn native_level_send_particles(
    // rust: &mut self,
    // rust: options: &ParticleOptions,
    // rust: state: Option<BlockStateId>,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: i32,
    // rust: ) -> bool {
    // rust: if !self.native_authoritative() {
    // rust: return false;
}
    // rust: self.with_level(|_, level, _| {
    // rust: level.native_send_particles(options, state, at, spread, speed, count)
    // rust: })
}

    // The stack in the player's equipment slot `slot`
    // (`LivingEntity.getItemBySlot`): on a client the player's own, as
    // goggles worn or a tank on the back show their overlay; on a server the
    // acting player's. None for an empty slot, and for `Body` and `Saddle`,
    // which a player has none of. API @API:host_bridge@.
    // rust: pub(super) fn native_equipment(&self, slot: EquipmentSlot) -> Option<ItemStack> {
    // rust: match slot {
            // The selected slot, not `held`: that is the acting hand, the off hand's stack during
            // the off-hand pass of a use (`with_hand(Hand::Off, ..)`).
    // rust: EquipmentSlot::MainHand => self.inventory.get(self.selected).cloned().flatten(),
    // rust: EquipmentSlot::OffHand => self.offhand.clone(),
    // rust: EquipmentSlot::Head => self.armor[0].clone(),
    // rust: EquipmentSlot::Chest => self.armor[1].clone(),
    // rust: EquipmentSlot::Legs => self.armor[2].clone(),
    // rust: EquipmentSlot::Feet => self.armor[3].clone(),
    // rust: EquipmentSlot::Body | EquipmentSlot::Saddle => None,
}
    // rust: .filter(|stack| stack.count > 0)
}

    // Whether the player acting now holds sneak (`Player.isShiftKeyDown`,
    // what `UseOnContext.isSecondaryUseActive` reads in a use hook): a
    // wrench that picks a block up rather than turning it, a crank turned
    // backwards. On a server the acting guest's, as their use runs
    // (`as_guest` holds sneak for them); on a client the player's own key.
    // API @API:host_bridge@.
    // rust: pub(super) fn native_sneaking(&self) -> bool {
    // rust: self.keys.held(Action::Sneak)
}
}

    // rust: mod tests {
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_client::{first_person::Hand, items::ItemStack};
//     use horizon_world::player_inventory::EquipmentSlot;

    // `LivingEntity.getItemBySlot` doesn't depend on the hand acting: in the
    // off-hand pass of a use, the main hand is still the selected slot's.
equipment_reads_the_main_hand_in_an_off_hand_pass :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let name = |stack: Option<ItemStack>| stack.map(|s| s.item.to_string());
    // rust: game.inventory[game.selected] = Some(ItemStack::new("minecraft:stick", 1));
    // rust: game.offhand = Some(ItemStack::new("minecraft:torch", 1));
    // rust: for hand in [Hand::Main, Hand::Off] {
    // rust: game.with_hand(hand, |g| {
    // rust: assert_eq!(
    // rust: name(g.native_equipment(EquipmentSlot::MainHand)).as_deref(),
    // rust: Some("minecraft:stick"),
    // rust: "{hand:?}"
    // rust: );
    // rust: assert_eq!(
    // rust: name(g.native_equipment(EquipmentSlot::OffHand)).as_deref(),
    // rust: Some("minecraft:torch"),
    // rust: "{hand:?}"
    // rust: );
    // rust: });
}
    // rust: game.inventory[game.selected] = None;
    // rust: game.with_hand(Hand::Off, |g| {
    // rust: assert!(g.native_equipment(EquipmentSlot::MainHand).is_none());
    // rust: });
}
}
