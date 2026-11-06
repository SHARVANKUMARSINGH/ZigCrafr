//! Transpiled from Horizon Rust crate
package horizon_client_tweaks

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's inventory extras (#332, `docs/extras.md`), Mouse Tweaks-style
// controls and sorting, both off by default: while an extra is off its
// hooks return false and the screen clicks exactly as vanilla's. Each action is made of ordinary slot clicks
// (the menu engine's, or `ContainerClick`s on a server), so it works
// wherever vanilla's clicks do. They run in the player inventory, the
// chest-like containers (chests, barrels, ender chests, shulker boxes,
// hoppers, dispensers), furnaces and crafting tables.
//
// - Right-drag holding a stack: one item into each slot entered, at once.
// - Left-drag holding a stack, before vanilla's drag has spread over a
//   second slot: each slot entered holding the same item is gathered into
//   the hand (when it all fits); with Shift, those slots are quick-moved.
// - Shift + left-drag with an empty hand: every slot entered is quick-moved.
// - The wheel over a slot, with an empty hand: down moves one of its items
//   where a Shift click would send it (`quickMoveStack`: fuel to the fuel
//   slot, a smeltable to the input), up brings one of the same item from the
//   other side. Down over a result slot takes one craft or the whole furnace
//   output to the inventory; nothing ever goes into a result slot.
//
// Sorting draws a small button by the container's title and one by the
// inventory's (an optional key sorts the part under the cursor); the
// clicks come from `inv_sort::plan`.
// use super::{Creative, Game, Screen};
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: hud::{HudBatch, rgba},
    // rust: inv_sort,
    // rust: items::ItemStack,
    // rust: keybinds,
    // rust: menu::Input,
    // rust: stations::hover_name,
}
// use winit::{event::MouseButton, keyboard::KeyCode};

// A sort button's side in GUI pixels.
SORT_BUTTON :: 9.0

    // rust: pub(super) struct Tweaks {
    // rust: drag: Option<Drag>,
    // Wheel steps not yet acted on (a trackpad scrolls in fractions).
    // rust: wheel: f32,
}
// A server's menu the tweaks run in: their clicks are vanilla's in these,
// and the menu engine knows which slot takes what. Not the menus whose slots
// cost or trigger something (anvils, enchanting, merchants, beacons, crafters).
    // rust: pub(super) fn tweak_menu(name: &str) -> bool {
    // rust: name == "inventory"
    // rust: || name.starts_with("minecraft:generic_9x")
    // rust: || matches!(
    // rust: name,
    // rust: "minecraft:shulker_box"
    // rust: | "minecraft:hopper"
    // rust: | "minecraft:generic_3x3"
    // rust: | "minecraft:furnace"
    // rust: | "minecraft:blast_furnace"
    // rust: | "minecraft:smoker"
    // rust: | "minecraft:crafting"
    // rust: )
}
// A drag the tweaks follow.
Drag :: struct {
    right: bool,
    // The stack in hand at the press and its count since, as the drag's
    // own clicks change it (a server answers them later).
    held: Maybe(ItemStack),
    // The drag replaced vanilla's: its release clicks nothing.
    active: bool,
    visited: [dynamic]uint,
}

    // rust: impl Game<'_> {
    // The open screen is one the tweaks run in, with the extra on.
    // rust: pub(super) fn tweaks_on(&self) -> bool {
    // rust: if !self.settings.extras.mouse_tweaks
    // rust: || self.screen != Screen::Inventory
    // rust: || self.station.is_some()
    // rust: || self.mount_active()
    // rust: {
    // rust: return false;
}
    // rust: if self.remote.is_some() {
    // rust: self.remote_menu_type().is_none_or(tweak_menu)
    // rust: } else {
    // rust: matches!(self.container_kind(), None | Some(BlockEntity::Chest(_)))
}
}
    // One ordinary click on a game slot. False when nothing took it.
    // rust: pub(super) fn tweak_click(&mut self, slot: usize, button: i32, input: Input) -> bool {
    // rust: if self.remote.is_some() {
    // rust: return self.remote_menu_ops(&[(Some(slot), button, input)]);
}
    // rust: if !self.menu_click(Some(slot), button, input) {
    // rust: return false;
}
    // rust: if let Some(key) = self.container {
    // rust: self.container_changed(key);
}
    // rust: true
}
    // Puts the hand's stack (`right`: one of it) in `slot`, as a one-slot
    // drag (`QUICK_CRAFT`) and not a click: a server that has the hand empty
    // (the stack it was to come from just burned as fuel) ignores a drag, but
    // a click would pick up what's in `slot`.
tweak_put :: proc(self: ^Self, slot: uint, right: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let kind = i32::from(right) << 2;
    // rust: let ops = [
    // rust: (None, kind, Input::QuickCraft),
    // rust: (Some(slot), kind | 1, Input::QuickCraft),
    // rust: (None, kind | 2, Input::QuickCraft),
    // rust: ];
    // rust: if self.remote.is_some() {
    // rust: return self.remote_menu_ops(&ops);
}
    // rust: if !self.menu_ops(&ops) {
    // rust: return false;
}
    // rust: if let Some(key) = self.container {
    // rust: self.container_changed(key);
}
    // rust: true
}
    // A press on `slot`: true when the tweaks took it (a right-drag
    // placing), else vanilla's press runs and the tweaks watch the drag.
    // rust: pub(super) fn tweak_press(&mut self, slot: Option<usize>, right: bool, shift: bool) -> bool {
    // rust: self.tweaks.drag = None;
    // rust: let Some(slot) = slot.filter(|&s| s != 200 && s < Creative::DISPLAY) else {
    // rust: return false;
}
    // rust: if !self.tweaks_on() {
    // rust: return false;
}
    // rust: let held = self.carried.clone();
    // rust: if right {
            // A result slot takes nothing: its press stays vanilla's.
    // rust: if shift || held.is_none() || self.tweak_result(slot) {
    // rust: return false;
}
            // RMB: the press places at once, then the drag goes on.
    // rust: let mut drag = Drag {
    // rust: right,
    // rust: held,
    // rust: active: true,
    // rust: visited: vec![slot],
}
    // rust: self.tweak_place(&mut drag, slot);
    // rust: self.inv_drag = None;
    // rust: self.inv_clicks.skip_release();
    // rust: self.tweaks.drag = Some(drag);
    // rust: return true;
}
    // rust: if held.is_some() || shift {
    // rust: self.tweaks.drag = Some(Drag {
    // rust: right,
    // rust: held,
    // rust: active: false,
    // rust: visited: vec![slot],
    // rust: });
}
    // rust: false
}
    // Places one held item in `slot` when it takes it.
tweak_place :: proc(self: ^Self, drag: ^Drag, slot: uint) {
}
    // rust: let Some(held) = drag.held.clone() else {
    // rust: return;
}
    // rust: if self.tweak_takes_one(slot, &held) && self.tweak_put(slot, true) {
    // rust: drag.held = (held.count > 1).then(|| ItemStack {
    // rust: count: held.count - 1,
    // rust: ..held
    // rust: });
}
}
    // The cursor moved while a button is held: true when the tweaks own
    // the drag (vanilla's quick craft drag doesn't grow).
    // rust: pub(super) fn tweak_drag_move(&mut self, slot: Option<usize>) -> bool {
    // rust: let Some(mut drag) = self.tweaks.drag.take() else {
    // rust: return false;
}
    // rust: let active = drag.active;
    // rust: let entered =
    // rust: slot.filter(|s| *s != 200 && *s < Creative::DISPLAY && !drag.visited.contains(s));
    // rust: if let Some(slot) = entered {
    // rust: drag.visited.push(slot);
    // rust: let stack = self.slot_view(slot);
    // rust: let shift = self.has_shift_down();
    // rust: if drag.right {
    // rust: self.tweak_place(&mut drag, slot);
    // rust: } else if let Some(held) = drag.held.clone() {
                // Holding a stack: only slots of the same item, and only
                // while vanilla's drag hasn't spread.
    // rust: let spread = self.inv_drag.as_ref().is_some_and(|(_, s)| s.len() > 1);
    // rust: if let Some(s) = stack.filter(|s| s.same_item_same_components(&held))
    // rust: && (drag.active || !spread)
    // rust: {
    // rust: if !drag.active {
    // rust: drag.active = true;
    // rust: self.inv_drag = None;
    // rust: self.inv_clicks.skip_release();
}
    // rust: if shift {
    // rust: self.tweak_click(slot, 0, Input::QuickMove);
    // rust: } else if held.count + s.count <= self.max_stack(&s)
    // rust: && self.tweak_click(slot, 0, Input::Pickup)
    // rust: && self.tweak_click(slot, 0, Input::Pickup)
    // rust: {
                        // Put the hand's stack in the slot, then take it all.
    // rust: drag.held = Some(ItemStack {
    // rust: count: held.count + s.count,
    // rust: ..held
    // rust: });
}
}
    // rust: } else if shift && stack.is_some() {
    // rust: drag.active = true;
    // rust: self.tweak_click(slot, 0, Input::QuickMove);
}
}
    // rust: let owned = drag.active || active;
    // rust: self.tweaks.drag = Some(drag);
    // rust: owned
}
    // The button went up: the drag ends.
    // rust: pub(super) fn tweak_release(&mut self) {
    // rust: self.tweaks.drag = None;
}
    // The wheel over an inventory screen: true when the tweaks used it.
    // rust: pub(super) fn tweak_scroll(&mut self, delta: f32, slot: Option<usize>) -> bool {
    // rust: if !self.settings.extras.mouse_tweaks_wheel || !self.tweaks_on() || self.carried.is_some() {
    // rust: return false;
}
    // rust: let Some(slot) = slot else {
    // rust: self.tweaks.wheel = 0.0;
    // rust: return false;
}
    // rust: self.tweaks.wheel += delta;
    // rust: let steps = self.tweaks.wheel.trunc();
    // rust: self.tweaks.wheel -= steps;
    // rust: for _ in 0..steps.abs() as u32 {
    // rust: if steps < 0.0 {
    // rust: self.tweak_push(slot);
    // rust: } else {
    // rust: self.tweak_pull(slot);
}
}
    // rust: true
}
    // `slot` is a result slot of the open menu.
tweak_result :: proc(self: ^Self, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = false;
    // rust: self.menu_session(|menu, _, to_menu| {
    // rust: result = to_menu(slot).is_some_and(|i| menu.is_result(i));
    // rust: Some(false)
    // rust: });
    // rust: result
}
    // `slot` takes one more of `stack`, by the open menu's rules.
tweak_takes_one :: proc(self: ^Self, slot: uint, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut takes = false;
    // rust: self.menu_session(|menu, env, to_menu| {
    // rust: takes = to_menu(slot).is_some_and(|i| menu.takes_one(env, i, stack));
    // rust: Some(false)
    // rust: });
    // rust: takes
}
    // Where vanilla's quick move would put `slot`'s items, tried on a copy
    // of the menu that's dropped (`Some(false)` keeps nothing).
tweak_landing :: proc(self: ^Self, slot: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let slots = self.slots();
    // rust: let mut landing = Vec::new();
    // rust: self.menu_session(|menu, env, to_menu| {
    // rust: let from = to_menu(slot)?;
    // rust: landing = menu
    // rust: .quick_move_landing(env, from)
    // rust: .into_iter()
    // rust: .filter_map(|i| slots.iter().copied().find(|&g| to_menu(g) == Some(i)))
    // rust: .collect();
    // rust: Some(false)
    // rust: });
    // rust: landing
}
    // The slots across from `slot`: a container's or crafting grid's face
    // the inventory (hotbar first, from the right), the inventory's face
    // them; without one, hotbar and main inventory trade.
other_side :: proc(self: ^Self, slot: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let table = self.craft_size == 3;
    // rust: let own: Vec<usize> = self
    // rust: .slots()
    // rust: .into_iter()
    // rust: .filter(|s| (300..500).contains(s) || (table && (100..109).contains(s)))
    // rust: .collect();
    // rust: let player = || (0..9).rev().chain((9..36).rev());
    // rust: match slot {
    // rust: 100..109 | 300..500 => player().collect(),
    // rust: 0..36 if !own.is_empty() => own,
    // rust: 0..9 => (9..36).collect(),
    // rust: 9..36 => (0..9).collect(),
    // rust: _ => Vec::new(),
}
}
    // Wheel down: one item of `slot` to where a quick move sends it. A
    // result can't be split or put back: one craft (or the furnace's whole
    // output) goes, when it all fits.
tweak_push :: proc(self: ^Self, slot: uint) {
}
    // rust: let Some(stack) = self.slot_view(slot) else {
    // rust: return;
}
    // rust: let landing = self.tweak_landing(slot);
    // rust: let Some(&target) = landing.first() else {
    // rust: return;
}
    // rust: if self.tweak_result(slot) {
    // rust: if self.tweak_click(slot, 0, Input::Pickup) {
    // rust: for target in landing {
    // rust: self.tweak_put(target, false);
}
}
    // rust: return;
}
    // rust: if self.tweak_click(slot, 0, Input::Pickup) {
    // rust: self.tweak_put(target, true);
    // rust: if stack.count > 1 {
    // rust: self.tweak_put(slot, false);
}
}
}
    // Wheel up: one item of the same kind from the other side into `slot`.
    // A result slot takes none and gives none.
tweak_pull :: proc(self: ^Self, slot: uint) {
}
    // rust: let Some(stack) = self.slot_view(slot) else {
    // rust: return;
}
    // rust: if !self.tweak_takes_one(slot, &stack) {
    // rust: return;
}
    // rust: let mut source = None;
    // rust: for s in self.other_side(slot) {
    // rust: if let Some(v) = self.slot_view(s)
    // rust: && v.same_item_same_components(&stack)
    // rust: && !self.tweak_result(s)
    // rust: {
    // rust: source = Some((s, v.count));
    // rust: break;
}
}
    // rust: let Some((source, count)) = source else {
    // rust: return;
}
    // rust: if self.tweak_click(source, 0, Input::Pickup) {
    // rust: self.tweak_put(slot, true);
    // rust: if count > 1 {
    // rust: self.tweak_put(source, false);
}
}
}
}

    // rust: impl Game<'_> {
    // The sort buttons of the open screen, with the extra on: their
    // corner (from the screen's) and the slots each sorts. The container's
    // (chest-like ones only) sits by its title, the main inventory's by
    // the "Inventory" label's line.
sort_buttons :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if !self.settings.extras.sort
    // rust: || self.screen != Screen::Inventory
    // rust: || self.station.is_some()
    // rust: || self.mount_active()
    // rust: {
    // rust: return Vec::new();
}
    // rust: let chest_like = if self.remote.is_some() {
    // rust: if !self.remote_storage_open() {
    // rust: return Vec::new();
}
    // rust: true
    // rust: } else {
    // rust: match self.container_kind() {
    // rust: None => false,
    // rust: Some(BlockEntity::Chest(_)) => {
    // rust: self.chest_rows().is_some() || self.container_block_is_shulker()
}
    // rust: Some(_) => return Vec::new(),
}
}
    // rust: let mut buttons = Vec::new();
    // rust: let container: Vec<usize> = self
    // rust: .slots()
    // rust: .into_iter()
    // rust: .filter(|s| (300..500).contains(s))
    // rust: .collect();
    // rust: if chest_like && !container.is_empty() {
    // rust: buttons.push(((160.0, 5.0), container));
}
    // rust: buttons.push(((160.0, self.screen_height() - 95.0), (9..36).collect()));
    // rust: buttons
}
    // The sort buttons: a bordered square with three bars, lighter under
    // the cursor.
    // rust: pub(super) fn draw_sort_buttons(&self, batch: &mut HudBatch, ox: f32, oy: f32) {
    // rust: let atlas = &self.gui.atlas;
    // rust: for ((x, y), _) in self.sort_buttons() {
    // rust: let (x, y) = (ox + x, oy + y);
    // rust: let (cx, cy) = self.cursor;
    // rust: let hovered = cx >= x && cx < x + SORT_BUTTON && cy >= y && cy < y + SORT_BUTTON;
    // rust: let face = if hovered {
    // rust: rgba(220, 220, 220, 255)
    // rust: } else {
    // rust: rgba(160, 160, 160, 255)
}
    // rust: batch.fill(atlas, x, y, SORT_BUTTON, SORT_BUTTON, rgba(55, 55, 55, 255));
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: SORT_BUTTON - 2.0,
    // rust: SORT_BUTTON - 2.0,
    // rust: face,
    // rust: );
    // rust: for (i, w) in [5.0, 4.0, 3.0].into_iter().enumerate() {
    // rust: let by = y + 2.0 + 2.0 * i as f32;
    // rust: batch.fill(atlas, x + 2.0, by, w, 1.0, rgba(55, 55, 55, 255));
}
}
}
    // A left press on a sort button sorts its slots (true).
    // rust: pub(super) fn sort_press(&mut self) -> bool {
    // rust: let Some(r) = self.renderer.as_ref() else {
    // rust: return false;
}
    // rust: let batch = HudBatch::new([r.config.width, r.config.height]);
    // rust: let (ox, oy) = self.inventory_origin(&batch);
    // rust: let (cx, cy) = self.cursor;
    // rust: let hit = self.sort_buttons().into_iter().find(|((x, y), _)| {
    // rust: let (x, y) = (ox + x, oy + y);
    // rust: cx >= x && cx < x + SORT_BUTTON && cy >= y && cy < y + SORT_BUTTON
    // rust: });
    // rust: let Some((_, slots)) = hit else {
    // rust: return false;
}
    // rust: self.sort_slots(&slots);
    // rust: true
}
    // The sort key: sorts the part under the cursor (the container when
    // the cursor is over no slot).
    // rust: pub(super) fn sort_key_press(&mut self, key: KeyCode) -> bool {
    // rust: keybinds::key_name(key).is_some_and(|name| self.sort_input(name))
}
    // rust: pub(super) fn sort_mouse_press(&mut self, button: MouseButton) -> bool {
    // rust: self.sort_input(&keybinds::mouse_name(button))
}
    // The HDR settings key (`Graphics::hdr_key`): opens the graphics screen's HDR page from the game, where
    // the display offers HDR; Done goes back to the game.
    // rust: pub(super) fn hdr_key_press(&mut self, key: KeyCode) -> bool {
    // rust: keybinds::key_name(key).is_some_and(|name| self.hdr_input(name))
}
    // rust: pub(super) fn hdr_mouse_press(&mut self, button: MouseButton) -> bool {
    // rust: self.hdr_input(&keybinds::mouse_name(button))
}
hdr_input :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.screen != Screen::Playing
    // rust: || self.title.is_some()
    // rust: || self.settings.horizon.hdr_key != name
    // rust: || !horizon_client::graphics::hdr_offered()
    // rust: {
    // rust: return false;
}
    // rust: self.capture(false);
    // rust: self.open_options_at(false, horizon_client::options_ui::Page::GraphicsHdr);
    // rust: self.options_to_game = true;
    // rust: true
}
sort_input :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let e = &self.settings.extras;
    // rust: if !e.sort || e.sort_key != name || self.recipe_search_focused() {
    // rust: return false;
}
    // rust: let buttons = self.sort_buttons();
    // rust: let hovered = self.inventory_target().0;
    // rust: let slots = buttons
    // rust: .iter()
    // rust: .find(|(_, slots)| hovered.is_some_and(|h| slots.contains(&h)))
    // rust: .or(buttons.first())
    // rust: .map(|(_, slots)| slots.clone());
    // rust: let Some(slots) = slots else {
    // rust: return false;
}
    // rust: self.sort_slots(&slots);
    // rust: true
}
    // Sorts `slots` with ordinary left clicks (needs an empty hand).
sort_slots :: proc(self: ^Self, slots: ^[uint]) {
}
    // rust: if self.carried.is_some() {
    // rust: return;
}
    // rust: let views: Vec<Option<ItemStack>> = slots.iter().map(|&s| self.slot_view(s)).collect();
    // rust: let clicks = {
    // rust: let names = |id: &str| self.pack.names.display_item(id);
    // rust: let rank = |s: &ItemStack| {
    // rust: let order = self.creative_screen.order_of(s).unwrap_or(usize::MAX);
    // rust: (order, hover_name(&names, s))
}
    // rust: let max = |s: &ItemStack| self.max_stack(s);
    // rust: inv_sort::plan(&views, &rank, &max)
}
    // rust: for i in clicks {
    // rust: self.tweak_click(slots[i], 0, Input::Pickup);
}
}
}

    // rust: mod tests {
//     use super::tweak_menu;

the_tweaks_run_in_the_menus_with_plain_click_rules :: proc() {
}
    // rust: for menu in [
    // rust: "inventory",
    // rust: "minecraft:generic_9x1",
    // rust: "minecraft:generic_9x6",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:hopper",
    // rust: "minecraft:generic_3x3",
    // rust: "minecraft:furnace",
    // rust: "minecraft:blast_furnace",
    // rust: "minecraft:smoker",
    // rust: "minecraft:crafting",
    // rust: ] {
    // rust: assert!(tweak_menu(menu), "{menu}");
}
    // rust: for menu in [
    // rust: "minecraft:anvil",
    // rust: "minecraft:enchantment",
    // rust: "minecraft:merchant",
    // rust: "minecraft:beacon",
    // rust: "minecraft:grindstone",
    // rust: "minecraft:stonecutter",
    // rust: "minecraft:loom",
    // rust: "minecraft:brewing_stand",
    // rust: "minecraft:crafter_3x3",
    // rust: ] {
    // rust: assert!(!tweak_menu(menu), "{menu}");
}
}
}
