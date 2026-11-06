//! Transpiled from Horizon Rust crate
//! Module: horizon-client_chiseled_bookshelf
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Chiseled bookshelves: `ChiseledBookShelfBlock.useItemOn` / `useWithoutItem`
//! (a book into the slot under the crosshair, or out of it) and
//! `ChiseledBookShelfBlockEntity.updateState`, which also follows the books a
//! hopper or dropper moved (`machines::container_changed`). The slots' books
//! show through the block state's `slot_N_occupied`, which reaches a server's
//! clients with the block update.
// use super::{Game, Hit, machines::dir_from_name};
// use horizon_client::{containers::BlockEntity, items::ItemStack, mobs::Who};
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::BlockPos,
}
// use horizon_world::level::{flags, hit_slot};

pub const BLOCK: []const u8 = "minecraft:chiseled_bookshelf";

    // rust: impl Game<'_> {
    /// `useItemOn` with `held` in the acting hand, then `useWithoutItem` on
    /// the main hand's turn: None when the block passes the click, else
    /// whether the use succeeded and the arm swings (a click on an empty slot
    /// without a book only consumes it).
    // rust: pub(super) fn use_chiseled_bookshelf(
    // rust: &mut self,
    // rust: hit: &Hit,
    // rust: held: Option<&ItemStack>,
    // rust: ) -> Option<bool> {
    // rust: let pos = hit.pos;
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let info = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .filter(|s| s.name == BLOCK)?;
    // rust: let facing = info
    // rust: .properties
    // rust: .get("facing")
    // rust: .and_then(|f| dir_from_name(f))?;
    // rust: let face = Direction::ALL
    // rust: .into_iter()
    // rust: .find(|d| d.normal() == hit.face)?;
    // rust: let at = Vec3::new(hit.point[0], hit.point[1], hit.point[2]);
    // rust: let slot = hit_slot(
    // rust: facing,
    // rust: face,
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: at,
    // rust: 2,
    // rust: 3,
    // rust: )?;
    // rust: let occupied = info
    // rust: .properties
    // rust: .get(&format!("slot_{slot}_occupied"))
    // rust: .map(String::as_str)
    // rust: == Some("true");
    // rust: let book = held.filter(|s| {
    // rust: self.res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:bookshelf_books")
    // rust: .is_some_and(|m| m.contains(&*s.item))
    // rust: });
    // rust: let centre = pos.map(|v| f64::from(v) + 0.5);
    // rust: if let Some(book) = book
    // rust: && !occupied
    // rust: {
            // addBook: one book goes in (a creative player keeps theirs).
    // rust: let book = book.clone();
    // rust: self.award_stat("used", &book.item, 1);
    // rust: let sound = if &*book.item == "minecraft:enchanted_book" {
    // rust: "minecraft:block.chiseled_bookshelf.insert.enchanted"
    // rust: } else {
    // rust: "minecraft:block.chiseled_bookshelf.insert"
}
    // rust: self.bookshelf_items(pos)?[slot] = Some(ItemStack {
    // rust: count: 1,
    // rust: ..book.clone()
    // rust: });
    // rust: self.consume_held();
    // rust: self.chiseled_bookshelf_update_state(pos, slot);
    // rust: self.audio.play(sound, Some(centre), 1.0, 1.0);
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, &book);
    // rust: return Some(true);
}
        // TRY_WITH_EMPTY_HAND: only the main hand goes on to useWithoutItem.
    // rust: if self.hand != horizon_client::first_person::Hand::Main {
    // rust: return None;
}
    // rust: if !occupied {
            // useWithoutItem's CONSUME on an empty slot still consumes the
            // click (ServerPlayerGameMode.useItemOn's DEFAULT_BLOCK_USE).
    // rust: self.trigger_default_block_use(pos);
    // rust: return Some(false);
}
        // removeBook: the book goes to the inventory, or is dropped.
    // rust: let retrieved = self.bookshelf_items(pos)?[slot].take()?;
    // rust: self.chiseled_bookshelf_update_state(pos, slot);
    // rust: let sound = if &*retrieved.item == "minecraft:enchanted_book" {
    // rust: "minecraft:block.chiseled_bookshelf.pickup.enchanted"
    // rust: } else {
    // rust: "minecraft:block.chiseled_bookshelf.pickup"
}
    // rust: self.audio.play(sound, Some(centre), 1.0, 1.0);
    // rust: self.give_or_drop(retrieved);
    // rust: self.post_block_game_event("minecraft:block_change", pos, Some(Who::Player), None);
        // ServerPlayerGameMode.useItemOn: useWithoutItem consumed the click.
    // rust: self.trigger_default_block_use(pos);
    // rust: Some(true)
}

    /// The bookshelf's six slots (made if the block has no block entity yet).
pub fn bookshelf_items(self: *Self, pos: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entity = self
    // rust: .world
    // rust: .block_entities
    // rust: .get_or_insert_with((pos[0], pos[1], pos[2]), || {
    // rust: BlockEntity::ChiseledBookshelf(Box::default())
    // rust: });
    // rust: match entity {
    // rust: BlockEntity::ChiseledBookshelf(b) => Some(&mut b.items),
    // rust: _ => None,
}
}

    /// `ChiseledBookShelfBlockEntity.updateState`: `slot` becomes the last
    /// one touched, the block state takes the slots' occupancy
    /// (`setBlockAndUpdate`) and `BLOCK_CHANGE` goes out.
pub fn chiseled_bookshelf_update_state(self: *Self, pos: [i32; 3], slot: usize) void {
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::ChiseledBookshelf(b)) = self.world.block_entities.get_mut(&key)
    // rust: else {
    // rust: return;
}
    // rust: b.last_slot = slot as i32;
    // rust: let occupied: Vec<bool> = b.items.iter().map(Option::is_some).collect();
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(mut state) = registry
    // rust: .state(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
    // rust: for (i, occupied) in occupied.into_iter().enumerate() {
    // rust: state
    // rust: .properties
    // rust: .insert(format!("slot_{i}_occupied"), occupied.to_string());
}
    // rust: let Some(new) = registry.id(&state) else {
    // rust: return;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, new, flags::UPDATE_ALL));
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: self.post_block_game_event("minecraft:block_change", pos, None, Some(new));
}

    /// The books a hopper or dropper put in or took out: the slot whose
    /// occupancy no longer matches the block state is the one `setItem` or
    /// `removeItem` updated.
    // rust: pub(super) fn chiseled_bookshelf_synced(&mut self, pos: (i32, i32, i32)) {
    // rust: let Some(BlockEntity::ChiseledBookshelf(b)) = self.world.block_entities.get(&pos) else {
    // rust: return;
}
    // rust: let Some(info) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(self.world.block(pos.0, pos.1, pos.2))
    // rust: else {
    // rust: return;
}
    // rust: let moved = (0..6).rev().find(|i| {
    // rust: let shown = info
    // rust: .properties
    // rust: .get(&format!("slot_{i}_occupied"))
    // rust: .map(String::as_str);
    // rust: b.items[*i].is_some() != (shown == Some("true"))
    // rust: });
    // rust: if let Some(slot) = moved {
    // rust: self.chiseled_bookshelf_update_state([pos.0, pos.1, pos.2], slot);
}
}
}
