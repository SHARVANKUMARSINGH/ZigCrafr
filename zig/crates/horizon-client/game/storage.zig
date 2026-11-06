//! Transpiled from Horizon Rust crate
//! Module: horizon-client_storage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shulker boxes (`ShulkerBoxBlockEntity`: 27 slots that refuse other boxes,
//! kept in the dropped item's `container` component) and ender chests (the
//! player's `PlayerEnderChestContainer`, saved as `EnderItems`).
// use super::Game;
// use horizon_client::{
    // rust: containers::{BlockEntity, ChestHalf, is_chest_block},
    // rust: items::ItemStack,
    // rust: text::Text,
}
// use horizon_core::random::RandomSource;

    // rust: pub(super) fn is_shulker_box(name: &str) -> bool {
    // rust: name.ends_with("shulker_box")
}
    // rust: impl Game<'_> {
    /// `ServerPlayerGameMode.useItemOn` for a spectator: the block's menu
    /// (`BlockState.getMenuProvider`) opens, and nothing else happens. The
    /// lid, its sound and the `container_open` game event come from
    /// `ContainerOpenersCounter`, which spectators never join
    /// (`ChestBlockEntity.startOpen`); the stat, the piglins' anger and the
    /// shulker box's room check are `useWithoutItem`'s, which is not called.
    /// Only the block containers whose clicks the server takes back from a
    /// spectator (`handleContainerClick`) open here: storage, the furnaces,
    /// the brewing stand and the crafter.
    // rust: pub(super) fn spectator_open_menu(&mut self, pos: [i32; 3]) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: .clone();
    // rust: let container = is_shulker_box(&name)
    // rust: || matches!(
    // rust: name.trim_start_matches("minecraft:"),
    // rust: "chest"
    // rust: | "trapped_chest"
    // rust: | "barrel"
    // rust: | "hopper"
    // rust: | "dispenser"
    // rust: | "dropper"
    // rust: | "furnace"
    // rust: | "blast_furnace"
    // rust: | "smoker"
    // rust: | "brewing_stand"
    // rust: | "crafter"
    // rust: );
        // ChestBlock.getMenuProvider: none while either half is blocked.
    // rust: if !container || self.chest_menu_blocked(key, &name) {
    // rust: return;
}
        // BaseContainerBlockEntity.canOpen: a spectator opens no container that still
        // has a loot table to unpack (it clears while it rolls, on first open).
    // rust: if self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(key.0 >> 4, key.2 >> 4))
    // rust: .and_then(|c| c.saved.as_ref())
    // rust: .is_some_and(|s| s.rolled_loot.iter().any(|r| r.pos == key))
    // rust: {
    // rust: return;
}
    // rust: let Some(entity) = BlockEntity::for_block(&name) else {
    // rust: return;
}
    // rust: self.world.block_entities.get_or_insert_with(key, || entity);
    // rust: self.container = Some(key);
    // rust: self.screen = super::Screen::Inventory;
    // rust: self.capture(false);
    // rust: self.right = false;
}
    /// The custom name of the open container, or its default title
    /// (a double chest is named by whichever half has a name).
    // rust: pub(super) fn container_title(&self, default: String) -> String {
    // rust: self.container_parts()
    // rust: .iter()
    // rust: .find_map(|(key, _)| self.world.block_names.get(key))
    // rust: .cloned()
    // rust: .unwrap_or(default)
}
    /// ShulkerBoxSlot.mayPlace: no shulker box inside a shulker box.
    // rust: pub(super) fn refuses(&self, slot: usize, stack: &ItemStack) -> bool {
    // rust: (300..400).contains(&slot)
    // rust: && is_shulker_box(&stack.item)
    // rust: && self.container.is_some_and(|k| {
    // rust: is_shulker_box(&self.res.facts().get(self.world.block(k.0, k.1, k.2)).name)
    // rust: })
}
    /// Opening an ender chest shows the player's ender inventory in its place.
    // rust: pub(super) fn open_ender_chest(&mut self, key: (i32, i32, i32)) {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(key, BlockEntity::Chest(self.ender_items.clone()));
    // rust: self.container = Some(key);
    // rust: self.ender_open = Some(key);
}
    /// The block above `key` is a redstone conductor.
pub fn conductor_above(self: *Self, key: (i32) void {
}
    // rust: let above = self.world.block(key.0, key.1 + 1, key.2);
    // rust: self.res.behaviours().facts(above).flags
    // rust: & horizon_world::level::data::state_flags::CONDUCTOR
    // rust: != 0
}
    /// `ChestBlock.isChestBlockedAt`: a redstone conductor above the chest or
    /// a cat sitting on it.
pub fn chest_blocked_at(self: *Self, key: (i32) void {
}
    // rust: if self.conductor_above(key) {
    // rust: return true;
}
        // isCatSittingOnChest: a cat whose box meets the block above.
    // rust: let area = horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(
    // rust: f64::from(key.0),
    // rust: f64::from(key.1 + 1),
    // rust: f64::from(key.2),
    // rust: ),
    // rust: horizon_core::geometry::Vec3::new(
    // rust: f64::from(key.0 + 1),
    // rust: f64::from(key.1 + 2),
    // rust: f64::from(key.2 + 1),
    // rust: ),
    // rust: );
    // rust: self.mobs.iter().any(|m| {
    // rust: m.species() == horizon_client::mobs::Species::Cat
    // rust: && m.alive()
    // rust: && horizon_client::mobs::tame::cat_sitting(m)
    // rust: && m.bounds().intersects(area)
    // rust: })
}
    /// `ChestBlock.getMenuProvider` (`combine(.., false)`) and
    /// `EnderChestBlock.useWithoutItem`: a blocked chest, or a double chest
    /// with either half blocked, opens no menu.
    // rust: pub(super) fn chest_menu_blocked(&self, key: (i32, i32, i32), name: &str) -> bool {
    // rust: match name {
    // rust: n if is_chest_block(n) => {
    // rust: self.chest_blocked_at(key)
    // rust: || self
    // rust: .chest_partner(key)
    // rust: .is_some_and(|(other, _)| self.chest_blocked_at(other))
}
            // The ender chest only looks at the block above (no cat check).
    // rust: "minecraft:ender_chest" => self.conductor_above(key),
    // rust: _ => false,
}
}
    /// Closing it copies the items back and leaves no block-entity contents.
    // rust: pub(super) fn close_ender_chest(&mut self) {
    // rust: let Some(key) = self.ender_open.take() else {
    // rust: return;
}
    // rust: if let Some(BlockEntity::Chest(items)) = self.world.block_entities.remove(&key) {
    // rust: self.ender_items = items;
}
}
}

// ---- chest menus: double chests, titles and shift-click ----

/// A chest block state's half: its block, `type` and `facing`.
pub fn chest_half(state: *horizon_world::chunk::BlockState) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(ChestHalf {
    // rust: block: &state.name,
    // rust: kind: state.properties.get("type")?,
    // rust: facing: state.properties.get("facing")?,
    // rust: })
}
pub fn facing_step(facing: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "north" => (0, -1),
    // rust: "south" => (0, 1),
    // rust: "west" => (-1, 0),
    // rust: _ => (1, 0),
}
}

    // rust: impl Game<'_> {
    /// The other half of the open double chest and whether the open one is
    /// the right half (`ChestBlock.getConnectedDirection`).
    // rust: pub(super) fn chest_partner(&self, key: (i32, i32, i32)) -> Option<((i32, i32, i32), bool)> {
    // rust: let registry = self.pack.assets.registry;
    // rust: let state = registry.state(self.world.block(key.0, key.1, key.2))?;
    // rust: if !is_chest_block(&state.name) {
    // rust: return None;
}
    // rust: let own = chest_half(state)?;
    // rust: let (dx, dz) = own.connected_step()?;
    // rust: let other = (key.0 + dx, key.1, key.2 + dz);
    // rust: let other_state = registry.state(self.world.block(other.0, other.1, other.2))?;
    // rust: let paired = own.pairs_with(&chest_half(other_state)?)
    // rust: && matches!(
    // rust: self.world.block_entities.get(&other),
    // rust: Some(BlockEntity::Chest(items)) if items.len() == 27
    // rust: );
    // rust: paired.then_some((other, own.kind == "right"))
}
    /// The open or close sound of a container block (`ChestBlockEntity.playSound`,
    /// `BarrelBlockEntity.playSound`, `ShulkerBoxBlockEntity.startOpen`): volume
    /// 0.5 and pitch 0.9 to 1.0. A double chest sounds once from the middle of
    /// both halves, a barrel from the face it opens on.
    // rust: pub(super) fn container_sound(&mut self, sound: &str, key: (i32, i32, i32), name: &str) {
    // rust: let mut at = [
    // rust: f64::from(key.0) + 0.5,
    // rust: f64::from(key.1) + 0.5,
    // rust: f64::from(key.2) + 0.5,
    // rust: ];
    // rust: if let Some((other, _)) = self.chest_partner(key) {
    // rust: at[0] = f64::from(key.0 + other.0) / 2.0 + 0.5;
    // rust: at[2] = f64::from(key.2 + other.2) / 2.0 + 0.5;
    // rust: } else if name == "minecraft:barrel"
    // rust: && let Some(state) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(self.world.block(key.0, key.1, key.2))
    // rust: && let Some(facing) = state.properties.get("facing")
    // rust: {
    // rust: let (dx, dy, dz) = match facing.as_str() {
    // rust: "up" => (0.0, 0.5, 0.0),
    // rust: "down" => (0.0, -0.5, 0.0),
    // rust: f => {
    // rust: let (x, z) = facing_step(f);
    // rust: (f64::from(x) / 2.0, 0.0, f64::from(z) / 2.0)
}
}
    // rust: at = [at[0] + dx, at[1] + dy, at[2] + dz];
}
    // rust: let pitch = self.world.random.next_float() * 0.1 + 0.9;
        // A server's `playSound(null, …)`: every player around, the opener too.
        // `Audio::play` captures the sound while the world is open to the
        // network and `lan_broadcast_effects` sends that tick to every guest,
        // so nothing is queued separately (a second queue played it twice).
    // rust: self.audio.play(sound, Some(at), 0.5, pitch);
}
    /// The open or close sound of the container block at `key`, if it has one.
    /// Callers play it only when the opener count crosses zero
    /// (`ContainerOpenersCounter.onOpen` / `onClose`).
    // rust: pub(super) fn container_edge_sound(&mut self, key: (i32, i32, i32), open: bool) {
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(key.0, key.1, key.2))
    // rust: .name
    // rust: .clone();
    // rust: let sound = if is_shulker_box(&name) {
    // rust: if open {
    // rust: "minecraft:block.shulker_box.open"
    // rust: } else {
    // rust: "minecraft:block.shulker_box.close"
}
    // rust: } else if &*name == "minecraft:ender_chest" {
    // rust: if open {
    // rust: "minecraft:block.ender_chest.open"
    // rust: } else {
    // rust: "minecraft:block.ender_chest.close"
}
    // rust: } else if name.contains("chest") {
    // rust: if open {
    // rust: "minecraft:block.chest.open"
    // rust: } else {
    // rust: "minecraft:block.chest.close"
}
    // rust: } else if &*name == "minecraft:barrel" {
    // rust: if open {
    // rust: "minecraft:block.barrel.open"
    // rust: } else {
    // rust: "minecraft:block.barrel.close"
}
    // rust: } else {
    // rust: return;
}
    // rust: self.container_sound(sound, key, &name);
}
    /// The other half of a double chest at `key`, for neighbour updates.
    // rust: pub(super) fn chest_other_half(&self, key: (i32, i32, i32)) -> Option<(i32, i32, i32)> {
    // rust: self.chest_partner(key).map(|p| p.0)
}
    /// The block entities of the open container in menu order, with their
    /// sizes: a double chest is its right half then its left half.
    // rust: pub(super) fn container_parts(&self) -> Vec<((i32, i32, i32), usize)> {
    // rust: let Some(key) = self.container else {
    // rust: return Vec::new();
}
    // rust: let Some(entity) = self.world.block_entities.get(&key) else {
    // rust: return Vec::new();
}
    // rust: let own = (key, entity.slots().len());
    // rust: match self.chest_partner(key) {
    // rust: Some((other, true)) => vec![own, (other, 27)],
    // rust: Some((other, false)) => vec![(other, 27), own],
    // rust: None => vec![own],
}
}
    /// `Container.stillValidBlockEntity`: the open block container closes once
    /// the player's eyes are out of reach of any of its blocks (a 4-block buffer).
    // rust: pub(super) fn tick_container_reach(&mut self) {
        // A server's menu ends when the server closes it.
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return;
}
    // rust: if self
    // rust: .container
    // rust: .is_none_or(|k| k.1 == super::minecarts::CART_KEY_Y)
    // rust: {
    // rust: return;
}
    // rust: let range = self.reach() + 4.0;
    // rust: let near = self.container_parts().iter().all(|&((x, y, z), _)| {
    // rust: horizon_client::lan::guest::within_block_range(eye, range, [x, y, z])
    // rust: });
    // rust: if !near {
    // rust: self.close_container();
    // rust: self.screen = super::Screen::Playing;
    // rust: self.capture(true);
}
}
    /// `CraftingMenu.stillValid`: the open crafting table closes once its
    /// block is no longer a crafting table or the player's eyes are out of
    /// reach (a 4-block buffer).
    // rust: pub(super) fn tick_craft_table(&mut self) {
        // A server's menu ends when the server closes it.
    // rust: if self.remote.is_some() || self.craft_size != 3 {
    // rust: return;
}
    // rust: let (Some(pos), Some(eye)) = (self.craft_table, self.eye_position()) else {
    // rust: return;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let table = &*self.res.facts().get(state).name == "minecraft:crafting_table";
    // rust: let range = self.reach() + 4.0;
    // rust: if !(table && horizon_client::lan::guest::within_block_range(eye, range, pos)) {
    // rust: self.close_container();
    // rust: self.screen = super::Screen::Playing;
    // rust: self.capture(true);
}
}
    /// The number of slots of the open container.
    // rust: pub(super) fn container_size(&self) -> usize {
    // rust: self.container_parts().iter().map(|p| p.1).sum()
}
    /// Container slot `n` (menu slot `300 + n`).
    // rust: pub(super) fn container_slot_mut(&mut self, mut n: usize) -> &mut Option<ItemStack> {
    // rust: let mut target = None;
    // rust: for (pos, size) in self.container_parts() {
    // rust: if n < size {
    // rust: target = Some((pos, n));
    // rust: break;
}
    // rust: n -= size;
}
    // rust: match target.and_then(|(pos, i)| {
    // rust: self.world
    // rust: .block_entities
    // rust: .get_mut(&pos)
    // rust: .and_then(|e| e.slots_mut().get_mut(i))
    // rust: }) {
    // rust: Some(slot) => slot,
    // rust: None => &mut self.scratch_slot,
}
}
    // rust: pub(super) fn container_block_is_shulker(&self) -> bool {
    // rust: self.container_block()
    // rust: .as_deref()
    // rust: .is_some_and(is_shulker_box)
}
pub fn container_block(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let k = self.container?;
    // rust: Some(
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(k.0, k.1, k.2))
    // rust: .name
    // rust: .clone(),
    // rust: )
}
    /// Rows of the open generic 9-wide container (`ChestMenu`), or None for
    /// the other menus (hoppers, dispensers, shulker boxes, furnaces...).
    // rust: pub(super) fn chest_rows(&self) -> Option<usize> {
    // rust: if let Some((rows, _)) = self.remote_chest_menu() {
    // rust: return Some(rows);
}
    // rust: if !matches!(self.container_kind()?, BlockEntity::Chest(_)) {
    // rust: return None;
}
    // rust: let generic = match self.container_block().as_deref() {
    // rust: Some("minecraft:barrel" | "minecraft:ender_chest") => true,
    // rust: Some(n) if is_chest_block(n) => true,
    // rust: _ => self.open_cart_kind() == Some(super::minecarts::CartKind::Chest),
}
    // rust: generic.then(|| self.container_size() / 9)
}
    /// The title of the open chest-like menu.
pub fn chest_title(self: *Self, rows: usize) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some((_, title)) = self.remote_chest_menu() {
    // rust: return title;
}
    // rust: let (key, fallback) = match self.container_block().as_deref() {
    // rust: Some("minecraft:barrel") => ("container.barrel", "Barrel"),
    // rust: Some("minecraft:ender_chest") => ("container.enderchest", "Ender Chest"),
    // rust: _ if self.open_cart_kind().is_some() => {
    // rust: ("entity.minecraft.chest_minecart", "Minecart with Chest")
}
    // rust: _ if rows > 3 => ("container.chestDouble", "Large Chest"),
    // rust: _ => ("container.chest", "Chest"),
}
    // rust: Text::literal(self.container_title(self.translate(key, fallback))).resolve_legacy()
}
    /// `ContainerScreen` / `ShulkerBoxScreen`: the background with its
    /// container rows, the title and the inventory label.
    // rust: pub(super) fn draw_chest_screen(
    // rust: &self,
    // rust: batch: &mut horizon_client::hud::HudBatch,
    // rust: ox: f32,
    // rust: oy: f32,
    // rust: ) {
//         use horizon_client::hud::rgba;
    // rust: let atlas = &self.gui.atlas;
    // rust: let grey = rgba(64, 64, 64, 255);
    // rust: if self
    // rust: .container_block()
    // rust: .as_deref()
    // rust: .is_some_and(is_shulker_box)
    // rust: {
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/container/shulker_box",
    // rust: [ox, oy, 176.0, 167.0],
    // rust: 256.0,
    // rust: 256.0,
    // rust: );
            // ShulkerBoxScreen draws the menu's title: the box's custom name
            // (BaseContainerBlockEntity.getDisplayName) or its default name.
    // rust: let title = self.remote_menu_title().unwrap_or_else(|| {
    // rust: Text::literal(
    // rust: self.container_title(self.translate("container.shulkerBox", "Shulker Box")),
    // rust: )
    // rust: .resolve_legacy()
    // rust: });
    // rust: super::screen_info::name_container(|| title.plain());
    // rust: batch.text_styled(atlas, &title, ox + 8.0, oy + 6.0, grey, false);
    // rust: let inventory = self.translate("container.inventory", "Inventory");
    // rust: batch.text(atlas, &inventory, ox + 8.0, oy + 73.0, grey, false);
    // rust: return;
}
    // rust: let rows = self.chest_rows().unwrap_or(3);
    // rust: let top = rows as f32 * 18.0 + 17.0;
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/container/generic_54",
    // rust: [ox, oy, 176.0, top],
    // rust: 256.0,
    // rust: 256.0,
    // rust: );
        // The player half of the texture starts at v = 126.
    // rust: if let Some(mut r) = atlas.sprites.get("gui/container/generic_54").copied() {
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: r.v0 += 126.0 * dv;
    // rust: r.v1 = r.v0 + 96.0 * dv;
    // rust: r.u1 = r.u0 + 176.0 * du;
    // rust: batch.rect_uv(ox, oy + top, 176.0, 96.0, r, u32::MAX);
}
    // rust: let title = self.chest_title(rows);
    // rust: super::screen_info::name_container(|| title.plain());
    // rust: batch.text_styled(atlas, &title, ox + 8.0, oy + 6.0, grey, false);
    // rust: let inventory = self.translate("container.inventory", "Inventory");
    // rust: batch.text(
    // rust: atlas,
    // rust: &inventory,
    // rust: ox + 8.0,
    // rust: oy + 114.0 + rows as f32 * 18.0 - 94.0,
    // rust: grey,
    // rust: false,
    // rust: );
}
}

    // rust: impl Game<'_> {
    /// `quickMoveStack` of the open chest-like, hopper, dispenser or furnace
    /// menu for a shift-click on `slot`, run by the verified menu engine
    /// (`horizon_client::menu`); false when the menu has none.
    // rust: pub(super) fn container_quick_move(&mut self, slot: usize) -> bool {
    // rust: self.menu_click(Some(slot), 0, horizon_client::menu::Input::QuickMove)
}
}

    // rust: mod tests {
//     use super::*;

pub fn double_chest_halves_connect_around_the_facing() void {
}
    // rust: let half = |kind, facing| ChestHalf {
    // rust: block: "minecraft:chest",
    // rust: kind,
    // rust: facing,
}
        // A left half facing north connects east, a right half west.
    // rust: assert_eq!(half("left", "north").connected_step(), Some((1, 0)));
    // rust: assert_eq!(half("right", "north").connected_step(), Some((-1, 0)));
    // rust: assert_eq!(half("left", "south").connected_step(), Some((-1, 0)));
    // rust: assert_eq!(half("right", "east").connected_step(), Some((0, -1)));
    // rust: assert_eq!(half("single", "east").connected_step(), None);
}
pub fn copper_chests_join_like_chests() void {
}
    // rust: let half = |block, kind| ChestHalf {
    // rust: block,
    // rust: kind,
    // rust: facing: "north",
}
    // rust: for block in [
    // rust: "minecraft:chest",
    // rust: "minecraft:trapped_chest",
    // rust: "minecraft:copper_chest",
    // rust: "minecraft:waxed_weathered_copper_chest",
    // rust: ] {
    // rust: assert!(is_chest_block(block));
    // rust: assert!(half(block, "left").pairs_with(&half(block, "right")));
}
        // ChestBlock.combine needs the same block on both halves.
    // rust: let copper = half("minecraft:copper_chest", "left");
    // rust: assert!(!copper.pairs_with(&half("minecraft:exposed_copper_chest", "right")));
    // rust: assert!(!is_chest_block("minecraft:ender_chest"));
}
pub fn shulker_boxes_are_recognised_by_name() void {
}
    // rust: assert!(is_shulker_box("minecraft:red_shulker_box"));
    // rust: assert!(is_shulker_box("minecraft:shulker_box"));
    // rust: assert!(!is_shulker_box("minecraft:chest"));
}
}
