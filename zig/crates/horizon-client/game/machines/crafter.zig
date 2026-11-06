//! Transpiled from Horizon Rust crate
//! Module: horizon-client_crafter
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The crafter (`CrafterBlock`, `CrafterBlockEntity`, `CrafterMenu`,
//! `CrafterScreen`): redstone-triggered crafting of its 3x3 grid, ejecting
//! the result and remainders into the container in front or as items, the
//! crafting animation ticks, and the menu with its toggleable slots.
// use super::*;
// use horizon_client::{
    // rust: advancements as adv,
    // rust: containers::Crafter,
    // rust: hud::{HudBatch, rgba},
    // rust: menu::{Maps as _, Menu},
}
// use horizon_protocol::packets::play::{self, Serverbound as S};
// use serde_json::Value;

/// `CrafterBlock`'s crafting animation length.
pub const CRAFTING_TICKS: i32 = 6;
pub const RESULT_SLOT: usize = 309;

pub fn center(pos: Pos) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: f64::from(pos.0) + 0.5,
    // rust: f64::from(pos.1) + 0.5,
    // rust: f64::from(pos.2) + 0.5,
    // rust: ]
}
/// Whether an advancement condition's `recipes` entry names the recipe.
pub fn recipe_matches(condition: *Value, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match condition {
    // rust: Value::String(s) => s == id,
    // rust: Value::Array(list) => list.iter().any(|v| v.as_str() == Some(id)),
    // rust: _ => true,
}
}

    // rust: impl Game<'_> {
    /// `Level.setBlock` of one boolean property of the block at `pos`.
    // rust: pub(crate) fn set_bool_prop(&mut self, pos: Pos, key: &str, value: bool, flags: i32) {
    // rust: let registry = self.pack.assets.registry;
    // rust: let old = self.world.block(pos.0, pos.1, pos.2);
    // rust: let Some(mut state) = registry.state(old).cloned() else {
    // rust: return;
}
    // rust: if !state.properties.contains_key(key) {
    // rust: return;
}
    // rust: state.properties.insert(key.to_owned(), value.to_string());
    // rust: let Ok(id) = registry.resolve(&state) else {
    // rust: return;
}
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, BlockPos::new(pos.0, pos.1, pos.2), id, flags)
    // rust: });
    // rust: let _ = self.process_level_events();
}
pub fn crafter_at(self: *Self, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.world.block_entities.get(&pos)? {
    // rust: BlockEntity::Crafter(c) => Some(c),
    // rust: _ => None,
}
}
    /// `CrafterBlockEntity.serverTick` of the crafter at `pos`, and the
    /// powered flag following the block state.
    // rust: pub(in crate::game) fn tick_crafter(&mut self, pos: Pos) {
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let triggered = self.containers().prop(state, "triggered") == Some("true");
    // rust: let mut finished = false;
    // rust: if let Some(BlockEntity::Crafter(c)) = self.world.block_entities.get_mut(&pos) {
            // CrafterBlock.neighborChanged sets the flag with the state; a
            // loaded crafter keeps its saved flag until then.
    // rust: if c.state_triggered.is_some_and(|t| t != triggered) {
    // rust: c.triggered = triggered;
}
    // rust: c.state_triggered = Some(triggered);
    // rust: let remaining = c.crafting_ticks - 1;
    // rust: if remaining >= 0 {
    // rust: c.crafting_ticks = remaining;
    // rust: finished = remaining == 0;
}
}
    // rust: if finished {
    // rust: self.set_bool_prop(
    // rust: pos,
    // rust: "crafting",
    // rust: false,
    // rust: horizon_world::level::flags::UPDATE_ALL,
    // rust: );
}
}
    /// `CrafterBlock.dispenseFrom` (the scheduled tick after a redstone pulse).
    // rust: pub(super) fn crafter_dispense(&mut self, pos: BlockPos, state: BlockStateId) -> Result<()> {
    // rust: let key = (pos.x, pos.y, pos.z);
    // rust: let Some(crafter) = self.crafter_at(key) else {
    // rust: return Ok(());
}
    // rust: let grid: Vec<Option<ItemStack>> = crafter.items.to_vec();
        // Query active world recipes with this level's saved-map context.
    // rust: let maps = self.level_maps(grid.iter().flatten());
    // rust: let found = self
    // rust: .recipes()
    // rust: .find_with(&grid, 3, &|id| maps.state(id).map(|(_, scale)| scale))
    // rust: .map(|(name, result)| (name.to_owned(), result))
    // rust: .filter(|(_, result)| result.count > 0);
    // rust: let Some((recipe, mut result)) = found else {
    // rust: self.dispenser_event(1050, key, 0);
    // rust: return Ok(());
}
    // rust: let Some(facing) = self
    // rust: .containers()
    // rust: .prop(state, "orientation")
    // rust: .and_then(|o| o.split('_').next())
    // rust: .and_then(dir_from_name)
    // rust: else {
    // rust: return Ok(());
}
    // rust: if let Some(BlockEntity::Crafter(c)) = self.world.block_entities.get_mut(&key) {
    // rust: c.crafting_ticks = CRAFTING_TICKS;
}
    // rust: self.set_bool_prop(
    // rust: key,
    // rust: "crafting",
    // rust: true,
    // rust: horizon_world::level::flags::UPDATE_CLIENTS,
    // rust: );
        // ItemStack.onCraftedBySystem invokes MapItem.onCraftedPostProcess
        // before dispensing, registering the derived map under its new id.
    // rust: Menu::map_crafted(Some(&maps), &mut result);
    // rust: self.register_made_maps(maps);
        // The remainders come from the grid as it was before anything moved.
    // rust: let remainders = self.recipes().remainders(&recipe, &grid, 3);
    // rust: self.crafter_eject(key, facing, result, &recipe);
    // rust: for rest in remainders.into_iter().flatten() {
    // rust: self.crafter_eject(key, facing, rest, &recipe);
}
    // rust: if let Some(BlockEntity::Crafter(c)) = self.world.block_entities.get_mut(&key) {
    // rust: for slot in c.items.iter_mut() {
    // rust: if let Some(s) = slot {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *slot = None;
}
}
}
}
    // rust: self.container_changed(key);
    // rust: self.native_crafter_craft([key.0, key.1, key.2], &recipe);
    // rust: Ok(())
}
    /// `CrafterBlock.dispenseItem`: into the container in front, else out as an item.
pub fn crafter_eject(self: *Self, pos: Pos, facing: Direction, stack: ItemStack, recipe: []const u8) void {
}
    // rust: let target = offset(pos, facing);
    // rust: let mut rest = stack;
    // rust: if let Some(into) = self.containers().view(target, false) {
    // rust: let one_by_one = self.crafter_at(target).is_some()
    // rust: || rest.count > self.containers().max_stack(&rest);
    // rust: while rest.count > 0 {
    // rust: let before = rest.count;
    // rust: if one_by_one {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..rest.clone()
}
    // rust: if self
    // rust: .add_item(None, &into, one, Some(facing.opposite()))
    // rust: .is_some()
    // rust: {
    // rust: break;
}
    // rust: rest.count -= 1;
    // rust: } else {
    // rust: match self.add_item(None, &into, rest.clone(), Some(facing.opposite())) {
    // rust: Some(left) => rest = left,
    // rust: None => rest.count = 0,
}
    // rust: if rest.count == before {
    // rust: break;
}
}
}
}
    // rust: if rest.count == 0 {
    // rust: return;
}
    // rust: self.spawn_dispensed(pos, facing, rest, 6);
        // CrafterRecipeCraftedTrigger: every player whose box meets the 17-block
        // box around the crafter's centre (8.5 from the centre to a face: the
        // player's own width and height reach into it, not its eye point).
        // `AABB.intersects` is strict: a box that only touches a face is out.
    // rust: let near = self.player.as_ref().is_some_and(|p| {
    // rust: let c = center(pos);
    // rust: let b = p.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: (lo.x < c[0] + 8.5 && hi.x > c[0] - 8.5)
    // rust: && (lo.y < c[1] + 8.5 && hi.y > c[1] - 8.5)
    // rust: && (lo.z < c[2] + 8.5 && hi.z > c[2] - 8.5)
    // rust: });
    // rust: if near {
    // rust: let id = horizon_client::crafting::qualified(recipe);
    // rust: let me = self.player_entity_for("minecraft:crafter_recipe_crafted");
    // rust: self.trigger("minecraft:crafter_recipe_crafted", move |c, w| {
    // rust: let ctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &ctx, w) && recipe_matches(&c["recipes"], &id)
    // rust: });
}
    // rust: self.dispenser_event(1049, pos, 0);
    // rust: self.dispenser_event(2010, pos, facing as i32);
}

    // ---- the menu ----

    /// The grid's current recipe result (`CrafterMenu.refreshRecipeResult`).
    // rust: pub(in crate::game) fn crafter_result(&self) -> Option<ItemStack> {
    // rust: let key = self.container?;
    // rust: let c = self.crafter_at(key)?;
    // rust: self.recipes().craft(&c.items, 3)
}
pub fn crafter_open(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.container_kind(), Some(BlockEntity::Crafter(_)))
}
    /// `CrafterMenu` slot layout: the grid at (26, 17), the result at (134, 35).
    // rust: pub(in crate::game) fn crafter_slot_position(&self, i: usize) -> Option<(f32, f32)> {
    // rust: if !self.crafter_open() {
    // rust: return None;
}
    // rust: match i {
    // rust: 300..309 => Some((
    // rust: 26.0 + ((i - 300) % 3) as f32 * 18.0,
    // rust: 17.0 + ((i - 300) / 3) as f32 * 18.0,
    // rust: )),
    // rust: RESULT_SLOT => Some((134.0, 35.0)),
    // rust: _ => None,
}
}
    /// `CrafterScreen`'s background, disabled slots and powered arrow (the
    /// verified `screen_layout::crafter`) and its centred title.
    // rust: pub(in crate::game) fn draw_crafter_screen(&self, batch: &mut HudBatch, ox: f32, oy: f32) {
    // rust: let Some(c) = self.container.and_then(|k| self.crafter_at(k)) else {
    // rust: return;
}
    // rust: let powered = self
    // rust: .container
    // rust: .map(|k| self.world.block(k.0, k.1, k.2))
    // rust: .is_some_and(|state| self.containers().prop(state, "triggered") == Some("true"));
    // rust: let draws =
    // rust: horizon_client::screen_layout::crafter(&horizon_client::screen_layout::CrafterView {
    // rust: width: 176,
    // rust: height: 166,
    // rust: left: 0,
    // rust: top: 0,
    // rust: disabled: c.disabled,
    // rust: powered,
    // rust: });
        // The background goes first, then the labels, then the slot decorations.
    // rust: let (background, rest) = draws.split_at(2.min(draws.len()));
    // rust: self.paint_screen(batch, ox, oy, background, true);
    // rust: let atlas = &self.gui.atlas;
    // rust: let grey = rgba(64, 64, 64, 255);
        // A server's crafter menu has the title it was given.
    // rust: let title = self.remote_menu_title().unwrap_or_else(|| {
    // rust: horizon_client::text::Text::literal(
    // rust: self.container_title(self.translate("container.crafter", "Crafter")),
    // rust: )
    // rust: .resolve_legacy()
    // rust: });
    // rust: crate::game::screen_info::name_container(|| title.plain());
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ox + ((176.0 - tw) / 2.0).trunc(),
    // rust: oy + 6.0,
    // rust: grey,
    // rust: false,
    // rust: );
    // rust: let inventory = self.translate("container.inventory", "Inventory");
    // rust: batch.text(atlas, &inventory, ox + 8.0, oy + 72.0, grey, false);
    // rust: self.paint_screen(batch, ox, oy, rest, true);
}
    /// `gui.togglable_slot` over an empty, enabled grid slot.
    // rust: pub(in crate::game) fn crafter_tooltip(&self, slot: usize) -> Option<String> {
    // rust: let c = self.container.and_then(|k| self.crafter_at(k))?;
    // rust: let i = slot.checked_sub(300).filter(|i| *i < 9)?;
    // rust: (self.carried.is_none() && c.items[i].is_none() && !c.disabled[i] && !self.spectator())
    // rust: .then(|| self.translate("gui.togglable_slot", "Click to disable slot"))
}
    /// A click in the crafter menu: `CrafterMenu` on the verified menu engine.
    // rust: pub(in crate::game) fn crafter_click(&mut self, slot: usize, shift: bool, right: bool) -> bool {
    // rust: if !self.crafter_open() {
    // rust: return false;
}
    // rust: let input = if shift {
    // rust: horizon_client::menu::Input::QuickMove
    // rust: } else {
    // rust: horizon_client::menu::Input::Pickup
}
    // rust: self.menu_click(Some(slot), i32::from(right), input);
    // rust: true
}
    /// `CrafterScreen.slotClicked`: an empty grid slot is enabled by a click
    /// (or a number key with a hotbar item) when disabled, and disabled by a
    /// click with nothing carried; the menu then gets the click itself.
    // rust: pub(in crate::game) fn crafter_slot_clicked(
    // rust: &mut self,
    // rust: slot: usize,
    // rust: button: i32,
    // rust: input: horizon_client::menu::Input,
    // rust: ) {
//         use horizon_client::menu::Input;
    // rust: if !self.crafter_open() || !(300..309).contains(&slot) || self.spectator() {
    // rust: return;
}
    // rust: let i = slot - 300;
    // rust: let Some(c) = self.container.and_then(|k| self.crafter_at(k)) else {
    // rust: return;
}
    // rust: if c.items[i].is_some() {
    // rust: return;
}
    // rust: let disabled = c.disabled[i];
    // rust: let enable = match input {
    // rust: Input::Pickup if disabled => Some(true),
    // rust: Input::Pickup if self.carried.is_none() => Some(false),
    // rust: Input::Swap if disabled => usize::try_from(button)
    // rust: .ok()
    // rust: .and_then(|b| {
    // rust: if b == 40 {
    // rust: Some(&self.offhand)
    // rust: } else {
    // rust: self.inventory.get(b)
}
    // rust: })
    // rust: .is_some_and(Option::is_some)
    // rust: .then_some(true),
    // rust: _ => None,
}
    // rust: let Some(enabled) = enable else {
    // rust: return;
}
        // ServerboundContainerSlotStateChangedPacket: CrafterBlockEntity.setSlotState.
    // rust: self.menu_session(|menu, _, _| {
    // rust: menu.set_slot_state(i, enabled);
    // rust: Some(true)
    // rust: });
    // rust: if let Some((container, _)) = self.remote.as_ref().and_then(|r| r.menu.clone()) {
    // rust: self.send(S::ContainerSlotStateChanged(
    // rust: play::ContainerSlotStateChanged {
    // rust: slot: i as i32,
    // rust: container,
    // rust: enabled,
    // rust: },
    // rust: ));
}
    // rust: let pitch = if enabled { 1.0 } else { 0.75 };
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.4, pitch);
}
}

    // rust: mod tests {
//     use super::*;

pub fn stack(item: []const u8, count: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(ItemStack::new(item, count))
}
pub fn signal_counts_filled_and_disabled_slots() void {
}
    // rust: let mut c = Crafter::default();
    // rust: assert_eq!(c.redstone_signal(), 0);
    // rust: c.items[0] = stack("minecraft:stick", 3);
    // rust: c.set_slot_state(4, false);
    // rust: assert_eq!(c.redstone_signal(), 2);
        // A filled slot cannot be disabled.
    // rust: c.set_slot_state(0, false);
    // rust: assert!(!c.disabled[0]);
    // rust: c.set_slot_state(4, true);
    // rust: assert_eq!(c.redstone_signal(), 1);
}
pub fn hoppers_fill_the_smaller_stacks_first() void {
}
    // rust: let mut c = Crafter::default();
    // rust: let stick = ItemStack::new("minecraft:stick", 1);
    // rust: c.items[0] = stack("minecraft:stick", 2);
    // rust: c.items[1] = stack("minecraft:stick", 1);
        // A later empty slot counts as smaller: stacks level out front to back.
    // rust: assert!(!c.can_place(0, &stick, 64));
    // rust: assert!(!c.can_place(1, &stick, 64));
    // rust: assert!(c.can_place(2, &stick, 64));
    // rust: c.disabled[5] = true;
    // rust: assert!(!c.can_place(5, &stick, 64));
        // With every later slot at least as big, a slot accepts again.
    // rust: for i in 2..9 {
    // rust: c.items[i] = stack("minecraft:stick", 2);
}
    // rust: assert!(c.can_place(1, &stick, 64));
        // A full stack accepts nothing.
    // rust: c.items[2] = stack("minecraft:stick", 64);
    // rust: assert!(!c.can_place(2, &stick, 64));
}
pub fn recipes_condition_accepts_a_name_or_a_list() void {
}
    // rust: assert!(recipe_matches(
    // rust: &serde_json::json!("minecraft:crafter"),
    // rust: "minecraft:crafter"
    // rust: ));
    // rust: assert!(!recipe_matches(
    // rust: &serde_json::json!(["minecraft:stick"]),
    // rust: "minecraft:crafter"
    // rust: ));
    // rust: assert!(recipe_matches(&Value::Null, "minecraft:crafter"));
}
}
