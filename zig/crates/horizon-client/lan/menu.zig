//! Transpiled from Horizon Rust crate
//! Module: horizon-client_menu
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Container menus for guests (AbstractContainerMenu.doClick): the player's
//! inventory menu (window 0) and block containers (chests, barrels, hoppers,
//! dispensers, shulker boxes). The click modes are pickup, quick move, swap,
//! clone, throw, quick craft (drag) and pickup all; items thrown out of a
//! menu are returned for the game to drop.
// use super::guest::Guest;
// use crate::{
    // rust: bundle::{Contents, can_be_in_bundle, toggle_selected},
    // rust: containers::BlockEntity,
    // rust: items::{ItemStack, Items},
    // rust: world::World,
}

/// What the menus need to know about items and the slots' rules.
    // rust: pub trait Rules {
pub fn items(self: *Self) *;
pub fn max_stack(self: *Self, item: []const u8) u;
    /// The armor slot (0 head .. 3 feet) an item can be worn in.
pub fn armor_index(self: *Self, item: []const u8) O;
    /// `ItemStack.getEquipmentSlot`: the `minecraft:equippable` component's
    /// slot ("head", "chest", "legs", "feet", "mainhand", "offhand").
pub fn equip_slot(self: *Self, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items().get(item)?.equip_slot.as_deref()
}
    /// `Slot.mayPickup`: whether the stack in menu slot `slot` may be taken
    /// out. A block container's slots and the player's own allow it; a mod's
    /// menu can refuse.
pub fn may_pickup(self: *Self, _slot: usize, _stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
    /// `Player.canDropItems`: a client that drops items faster than its
    /// throttle allows stops sending THROW clicks (`LocalPlayer.canDropItems`
    /// is its `dropSpamThrottler`'s answer).
pub fn can_drop_items(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
}

/// An open block container.
pub const Menu = struct {
    window: i32,
    /// The `minecraft:menu` registry id.
    kind: i32,
    pos: Option<(i32,
    /// Where the container's slots live.
    slots: Slots,
    /// Slots of the container itself (without the 36 inventory slots).
    size: usize,
    state: i32,
    /// What the client was last told, for change detection.
    sent: std.ArrayList(?ItemStack),
    /// An unfinished drag: (mode, slots).
    drag: Option<(u8,
    /// The data slots the client was last sent (ContainerSetData), a furnace's
    /// progress; None until sent, so any first value goes out.
    sent_data: std.ArrayList(?i16),
    /// Container slots the menu does not have: a mod's screen hides them, so
    /// no click or quick move reaches them (`Slot` positions are the screen's).
    hidden: std.ArrayList(usize),
    /// A content mod's menu type: its data slot count. Its clicks run on the
    /// vanilla menu engine (`menu::Kind::Mod`), not here.
    mod_type: ?*'static crate::containers::ModMenuType,
};

/// What a guest did with a native mod's menu (`Slots::Native`), for the game
/// to tell the mod once the hub is back in its hands.
pub const NativeMenuEvent = enum {
    /// A click (`ServerboundContainerClickPacket`): the menu's slot (its own
    /// first, then the player's 36; -999 outside), the button and the mode.
    Click {,
    uuid: u128,
    window: i32,
    slot: i32,
    button: i32,
    mode: i32,
    // rust: },
    /// The menu closed: by the player, by the server, another opened, or
    /// the player left.
    Closed { uuid: u128, window: i32 },
};

/// The y of the key a chest minecart's or chest boat's items are kept under
/// while a menu shows them.
pub const VEHICLE_KEY_Y: i32 = -100_000;

/// Where the slots of a container menu live.
pub const Slots = enum {
    /// One block entity.
    Block((i32, i32, i32)),
    /// A double chest (`CompoundContainer`): the first half's slots, then
    /// the second's.
    Double((i32, i32, i32), (i32, i32, i32)),
    /// The player's own ender chest inventory (`PlayerEnderChestContainer`).
    Ender,
    /// A native mod's menu (`Guest::native_menu`): items to look at, which no
    /// click moves; the clicks go to the mod.
    Native,
};

    // rust: impl Slots {
pub fn halves(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Slots::Block(k) => vec![k],
    // rust: Slots::Double(a, b) => vec![a, b],
    // rust: Slots::Ender | Slots::Native => Vec::new(),
}
}
    /// Whether the block entities behind the slots are still there
    /// (`Container.stillValid`).
pub fn valid(self: *Self, world: *World) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.halves()
    // rust: .iter()
    // rust: .all(|k| world.block_entities.contains_key(k))
}
    /// `Container.stillValid` for the guest: the block entities are there
    /// and the guest is within reach of each (`stillValidBlockEntity`). The
    /// ender chest's block is `at` (`PlayerEnderChestContainer.activeChest`).
pub fn still_valid(self: *Self, world: *World, guest: *Guest, at: Option<(i32) void {
}
    // rust: let blocks = match self {
    // rust: Slots::Ender => at.into_iter().collect(),
    // rust: Slots::Native => Vec::new(),
    // rust: _ => self.halves(),
}
        // A vehicle's container is kept under a key, not a block: the game
        // checks its reach to the vehicle (`isChestVehicleStillValid`).
    // rust: self.valid(world)
    // rust: && blocks
    // rust: .iter()
    // rust: .all(|k| k.1 == VEHICLE_KEY_Y || guest.within_block_range([k.0, k.1, k.2], 4.0))
}
    /// Container slot `n`.
pub fn get(self: *Self, world: *World, guest: *Guest, mut n: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self == Slots::Ender {
    // rust: return guest.ender_items.get(n).cloned().flatten();
}
    // rust: if self == Slots::Native {
    // rust: return guest.native_menu.get(n).cloned().flatten();
}
    // rust: for k in self.halves() {
    // rust: let slots = shown(world, k)?;
    // rust: if n < slots.len() {
    // rust: return slots[n].clone();
}
    // rust: n -= slots.len();
}
    // rust: None
}
    /// Every container slot, in menu order.
pub fn read(self: *Self, world: *World, guest: *Guest) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self == Slots::Ender {
    // rust: return Some(guest.ender_items.clone());
}
    // rust: if self == Slots::Native {
    // rust: return Some(guest.native_menu.clone());
}
    // rust: let mut items = Vec::new();
    // rust: for k in self.halves() {
    // rust: items.extend_from_slice(shown(world, k)?);
}
    // rust: Some(items)
}
    /// Store what `read` gave, changed.
pub fn write(self: *Self, world: *mut World, guest: *mut Guest, items: std.ArrayList(?ItemStack)) void {
}
    // rust: if self == Slots::Ender {
    // rust: guest.ender_items = items;
    // rust: return;
}
    // rust: if self == Slots::Native {
            // Only the mod changes what it shows.
    // rust: return;
}
    // rust: let mut rest = items.into_iter();
    // rust: for k in self.halves() {
    // rust: let n = shown(world, k).map_or(0, <[_]>::len);
    // rust: if let Some(e) = world.block_entities.get_mut(&k) {
    // rust: for slot in e.slots_mut().iter_mut().take(n) {
    // rust: *slot = rest.next().flatten();
}
}
}
}
}

/// The slots of the block entity at `k` its menu shows: a mod container's
/// count, though items past it stay saved.
pub fn shown(world: *World, k: (i32) void {
}
    // rust: let e = world.block_entities.get(&k)?;
    // rust: let slots = e.slots();
    // rust: if !matches!(e, BlockEntity::Mod(_)) {
    // rust: return Some(slots);
}
    // rust: let state = world.block(k.0, k.1, k.2).0;
    // rust: let count = world
    // rust: .block_entities
    // rust: .mod_container(state)
    // rust: .map_or(0, |c| c.slots);
    // rust: Some(&slots[..count.min(slots.len())])
}

/// Slots of a menu seen as one list.
pub const View = struct {
    guest: *'a mut Guest,
    /// The container's slots, or None for the inventory menu.
    container: ?*'a mut [Option<ItemStack]>,
    /// The container is a shulker box (`ShulkerBoxSlot`).
    shulker: bool,
    /// Container slots that do not exist in this menu (see [`Menu::hidden`]).
    hidden: *'a [usize],
};

    // rust: impl View<'_> {
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.container {
    // rust: Some(c) => c.len() + 36,
    // rust: None => 46,
}
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn get(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.container {
    // rust: Some(c) if i < c.len() => c[i].clone(),
    // rust: Some(c) => self
    // rust: .guest
    // rust: .inventory
    // rust: .get(player_slot(i - c.len()))
    // rust: .cloned()
    // rust: .flatten(),
    // rust: None => self.guest.menu_slot(i),
}
}
pub fn set(self: *Self, i: usize, item: ?ItemStack) void {
}
    // rust: match &mut self.container {
    // rust: Some(c) if i < c.len() => c[i] = item,
    // rust: Some(c) => {
    // rust: let n = c.len();
    // rust: self.guest.inventory[player_slot(i - n)] = item;
}
    // rust: None => self.guest.set_menu_slot(i, item),
}
}
    /// Whether the slot takes part in clicks at all.
pub fn enabled(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.container.is_some() || i >= 5) && !self.hidden.contains(&i)
}
pub fn may_place(self: *Self, i: usize, stack: *ItemStack, rules: *dyn Rules) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.container.is_none() && (5..=8).contains(&i) {
    // rust: return rules.armor_index(&stack.item) == Some(i - 5);
}
    // rust: if self.shulker
    // rust: && self.container.as_ref().is_some_and(|c| i < c.len())
    // rust: && !crate::menu::fits_inside_container_items(stack)
    // rust: {
    // rust: return false;
}
    // rust: self.enabled(i)
}
pub fn slot_max(self: *Self, i: usize, stack: *ItemStack, rules: *dyn Rules) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.container.is_none() && (5..=8).contains(&i) {
    // rust: return 1;
}
    // rust: rules.max_stack(&stack.item).max(1)
}
    /// `Slot.mayPickup`: whether menu slot `i` gives its stack up. The
    /// armour slots refuse while a survival player wears a binding curse
    /// (`ArmorSlot.mayPickup`: `PREVENT_ARMOR_CHANGE` and no creative); the
    /// menu's rules answer for their own slots.
pub fn may_pickup(self: *Self, i: usize, rules: *dyn Rules) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stack = self.get(i);
    // rust: if self.container.is_none()
    // rust: && (5..=8).contains(&i)
    // rust: && !self.guest.creative()
    // rust: && stack
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.enchantment_level("minecraft:binding_curse") > 0)
    // rust: {
    // rust: return false;
}
    // rust: stack.is_none_or(|s| rules.may_pickup(i, &s))
}
    /// The ranges quick move uses: (container start..end, main, hotbar).
pub fn player_ranges(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.container {
    // rust: Some(c) => (c.len()..c.len() + 27, c.len() + 27..c.len() + 36),
    // rust: None => (9..36, 36..45),
}
}
}

/// Inventory index of the n-th player slot of a container menu (27 main, then hotbar).
pub fn player_slot(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if n < 27 { 9 + n } else { n - 27 }
}

/// Inventory.add-like merge of `stack` into slots `range` (moveItemStackTo).
    // rust: fn move_to(
    // rust: view: &mut View,
    // rust: mut stack: ItemStack,
    // rust: range: std::ops::Range<usize>,
    // rust: reverse: bool,
    // rust: rules: &dyn Rules,
    // rust: ) -> Option<ItemStack> {
    // rust: let order: Vec<usize> = if reverse {
    // rust: range.rev().collect()
    // rust: } else {
    // rust: range.collect()
}
    // rust: for &i in &order {
    // rust: if stack.count == 0 {
    // rust: break;
}
    // rust: if !view.enabled(i) {
    // rust: continue;
}
    // rust: if let Some(mut existing) = view.get(i)
    // rust: && existing.same_item_same_components(&stack)
    // rust: {
    // rust: let max = view.slot_max(i, &existing, rules);
    // rust: if existing.count < max {
    // rust: let moved = (max - existing.count).min(stack.count);
    // rust: existing.count += moved;
    // rust: stack.count -= moved;
    // rust: view.set(i, Some(existing));
}
}
}
    // rust: for &i in &order {
    // rust: if stack.count == 0 {
    // rust: break;
}
    // rust: if view.enabled(i) && view.get(i).is_none() && view.may_place(i, &stack, rules) {
    // rust: let moved = stack.count.min(view.slot_max(i, &stack, rules));
    // rust: view.set(
    // rust: i,
    // rust: Some(ItemStack {
    // rust: count: moved,
    // rust: ..stack.clone()
    // rust: }),
    // rust: );
    // rust: stack.count -= moved;
}
}
    // rust: (stack.count > 0).then_some(stack)
}

pub fn quick_move(view: *mut View, i: usize, rules: *dyn Rules) void {
}
    // rust: let Some(stack) = view.get(i) else {
    // rust: return;
}
    // rust: if !view.enabled(i) {
    // rust: return;
}
    // rust: let (main, hotbar) = view.player_ranges();
    // rust: let rest = if let Some(c) = &view.container {
    // rust: let n = c.len();
    // rust: if i < n {
            // Container to inventory, filling from the hotbar's end.
    // rust: move_to(view, stack, n..n + 36, true, rules)
    // rust: } else {
    // rust: move_to(view, stack, 0..n, false, rules)
}
    // rust: } else if (5..=8).contains(&i) || i < 5 {
    // rust: move_to(view, stack, 9..45, false, rules)
    // rust: } else {
        // Wear it, otherwise the stack fills the inventory: from the main
        // slots for the hotbar and the off hand, from the hotbar for the
        // main ones. The off hand is in this arm too, so armour worn there
        // is put on like any other (InventoryMenu.quickMoveStack asks for
        // the item's equipment slot before it looks at the clicked index).
    // rust: let armor = rules
    // rust: .armor_index(&stack.item)
    // rust: .filter(|a| view.get(5 + a).is_none());
    // rust: if let Some(a) = armor {
    // rust: view.set(
    // rust: 5 + a,
    // rust: Some(ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
    // rust: }),
    // rust: );
    // rust: let mut rest = stack.clone();
    // rust: rest.count -= 1;
    // rust: (rest.count > 0).then_some(rest)
    // rust: } else if rules.equip_slot(&stack.item) == Some("offhand") && view.get(45).is_none() {
            // A shield or a totem goes to the empty off hand before the
            // hotbar (InventoryMenu.quickMoveStack's OFFHAND branch).
    // rust: let max = view.slot_max(45, &stack, rules);
    // rust: let moved = stack.count.min(max);
    // rust: view.set(
    // rust: 45,
    // rust: Some(ItemStack {
    // rust: count: moved,
    // rust: ..stack.clone()
    // rust: }),
    // rust: );
    // rust: let rest = stack.count - moved;
    // rust: (rest > 0).then_some(ItemStack {
    // rust: count: rest,
    // rust: ..stack.clone()
    // rust: })
    // rust: } else if hotbar.contains(&i) {
    // rust: move_to(view, stack, main, false, rules)
    // rust: } else if main.contains(&i) {
    // rust: move_to(view, stack, hotbar, false, rules)
    // rust: } else {
    // rust: move_to(view, stack, 9..45, false, rules)
}
}
    // rust: view.set(i, rest);
}

/// The click modes of ServerboundContainerClickPacket.
    // rust: pub mod input {
pub const PICKUP: i32 = 0;
pub const QUICK_MOVE: i32 = 1;
pub const SWAP: i32 = 2;
pub const CLONE: i32 = 3;
pub const THROW: i32 = 4;
pub const QUICK_CRAFT: i32 = 5;
pub const PICKUP_ALL: i32 = 6;
}

/// `AbstractContainerMenu.isContainerClickButton`: a pickup and a quick move
/// are clicks with the left or the right button only.
pub fn is_container_click_button(button: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: button == 0 || button == 1
}

/// Apply one click; returns the stacks thrown out and the slots changed.
    // rust: pub fn click(
    // rust: view: &mut View,
    // rust: drag: &mut Option<(u8, Vec<usize>)>,
    // rust: slot: i32,
    // rust: button: i32,
    // rust: mode: i32,
    // rust: rules: &dyn Rules,
    // rust: ) -> (Vec<ItemStack>, Vec<usize>) {
    // rust: let mut drops = Vec::new();
    // rust: let before: Vec<Option<ItemStack>> = (0..view.len()).map(|i| view.get(i)).collect();
    // rust: if mode == input::QUICK_CRAFT {
    // rust: quick_craft(view, drag, slot, button, rules);
    // rust: } else {
    // rust: *drag = None;
    // rust: match mode {
            // isContainerClickButton: PICKUP and QUICK_MOVE take buttons 0
            // and 1; any other button is no click at all, so neither the
            // slot nor the cursor moves (a modified client sends those).
    // rust: input::PICKUP | input::QUICK_MOVE if !is_container_click_button(button) => {}
    // rust: input::PICKUP | input::QUICK_MOVE if slot == -999 => {
    // rust: if mode == input::PICKUP
    // rust: && let Some(mut carried) = view.guest.carried.take()
    // rust: {
    // rust: if button == 1 && carried.count > 1 {
    // rust: let mut one = carried.clone();
    // rust: one.count = 1;
    // rust: carried.count -= 1;
    // rust: view.guest.carried = Some(carried);
    // rust: drops.push(one);
    // rust: } else {
    // rust: drops.push(carried);
}
}
}
    // rust: input::PICKUP => pickup(view, slot, button, rules),
    // rust: input::QUICK_MOVE => {
                // doClick calls quickMoveStack again while the clicked slot
                // still holds the item it moved, because moveItemStackTo fills
                // one empty slot per call. move_to here fills every empty slot
                // of its range in one pass and leaves the same remainder, so
                // one call is vanilla's loop: a full inventory keeps its stack,
                // and a stack too big for one slot spreads over several.
    // rust: if let Ok(i) = usize::try_from(slot)
    // rust: && i < view.len()
    // rust: && view.may_pickup(i, rules)
    // rust: {
    // rust: quick_move(view, i, rules);
}
}
    // rust: input::SWAP => swap(view, slot, button, rules),
    // rust: input::CLONE => {
    // rust: if view.guest.carried.is_none()
    // rust: && view.guest.creative()
    // rust: && let Ok(i) = usize::try_from(slot)
    // rust: && let Some(stack) = view.get(i)
    // rust: {
    // rust: let max = rules.max_stack(&stack.item).max(1);
    // rust: view.guest.carried = Some(ItemStack {
    // rust: count: max,
    // rust: ..stack
    // rust: });
}
}
    // rust: input::THROW => {
    // rust: if rules.can_drop_items()
    // rust: && view.guest.carried.is_none()
    // rust: && let Ok(i) = usize::try_from(slot)
    // rust: && view.enabled(i)
                    // `Slot.safeTake`: a slot that withholds its stack throws
                    // nothing, whatever the client asked for.
    // rust: && view.may_pickup(i, rules)
    // rust: && let Some(mut stack) = view.get(i)
    // rust: {
                    // doClick's THROW takes one item for button 0 and the
                    // whole stack for any other button.
    // rust: let amount = if button == 0 { 1 } else { stack.count };
    // rust: if amount >= stack.count {
    // rust: drops.push(stack);
    // rust: view.set(i, None);
    // rust: } else {
    // rust: let mut one = stack.clone();
    // rust: one.count = amount;
    // rust: stack.count -= amount;
    // rust: view.set(i, Some(stack));
    // rust: drops.push(one);
}
}
}
    // rust: input::PICKUP_ALL => pickup_all(view, slot, button, rules),
    // rust: _ => {}
}
}
    // rust: let changed = (0..view.len())
    // rust: .filter(|&i| view.get(i) != before[i])
    // rust: .collect();
    // rust: (drops, changed)
}

pub fn pickup(view: *mut View, slot: i32, button: i32, rules: *dyn Rules) void {
}
    // rust: let Ok(i) = usize::try_from(slot) else {
    // rust: return;
}
    // rust: if i >= view.len() || !view.enabled(i) {
    // rust: return;
}
    // rust: let right = button == 1;
    // rust: if bundle_click(view, i, right, rules) {
    // rust: return;
}
    // rust: let (slot_item, carried) = (view.get(i), view.guest.carried.clone());
    // rust: match (slot_item, carried) {
    // rust: (None, None) => {}
    // rust: (None, Some(mut c)) => {
    // rust: if view.may_place(i, &c, rules) {
    // rust: let amount = if right { 1 } else { c.count }.min(view.slot_max(i, &c, rules));
    // rust: view.set(
    // rust: i,
    // rust: Some(ItemStack {
    // rust: count: amount,
    // rust: ..c.clone()
    // rust: }),
    // rust: );
    // rust: c.count -= amount;
    // rust: view.guest.carried = (c.count > 0).then_some(c);
}
}
    // rust: (Some(mut s), None) => {
            // doClick's PICKUP arm takes from the slot only while
            // `Slot.mayPickup` allows it.
    // rust: if !view.may_pickup(i, rules) {
    // rust: return;
}
    // rust: let take = if right { s.count.div_ceil(2) } else { s.count };
    // rust: let taken = ItemStack {
    // rust: count: take,
    // rust: ..s.clone()
}
    // rust: s.count -= take;
    // rust: view.set(i, (s.count > 0).then_some(s));
    // rust: view.guest.carried = Some(taken);
}
    // rust: (Some(mut s), Some(mut c)) => {
            // Merging into, swapping with and topping the hand up from the
            // slot are all takes (`allowModification`: mayPickup and
            // mayPlace).
    // rust: if !view.may_pickup(i, rules) {
    // rust: return;
}
    // rust: if !view.may_place(i, &c, rules) {
                // A slot that takes nothing gives onto the same carried item,
                // as far as the hand holds (`tryRemove`).
    // rust: if s.same_item_same_components(&c) {
    // rust: let max = rules.max_stack(&c.item).max(1);
    // rust: let moved = s.count.min(max.saturating_sub(c.count));
    // rust: s.count -= moved;
    // rust: c.count += moved;
    // rust: view.set(i, (s.count > 0).then_some(s));
    // rust: view.guest.carried = Some(c);
}
    // rust: return;
}
    // rust: if s.same_item_same_components(&c) {
    // rust: let max = view.slot_max(i, &s, rules);
    // rust: let moved = if right { 1 } else { c.count }.min(max.saturating_sub(s.count));
    // rust: s.count += moved;
    // rust: c.count -= moved;
    // rust: view.set(i, Some(s));
    // rust: view.guest.carried = (c.count > 0).then_some(c);
    // rust: } else if c.count <= view.slot_max(i, &c, rules) {
    // rust: view.set(i, Some(c));
    // rust: view.guest.carried = Some(s);
}
}
}
}

/// `tryItemClickBehaviourOverride`: the carried stack's
/// `BundleItem.overrideStackedOnOther`, then the clicked one's
/// `overrideOtherStackedOnMe`. True when a bundle took the click.
pub fn bundle_click(view: *mut View, i: usize, right: bool, rules: *dyn Rules) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let items = rules.items();
    // rust: let other = view.get(i);
    // rust: if let Some(mut carried) = view.guest.carried.clone()
    // rust: && let Some(mut contents) = Contents::of(items, &carried)
    // rust: && other.is_some() != right
    // rust: {
    // rust: match other {
            // tryTransfer: as much as fits, through `safeTake`.
    // rust: Some(mut other) => {
    // rust: if can_be_in_bundle(&other) {
    // rust: let amount = other.count.min(contents.room_for(items, &other));
    // rust: if amount > 0 {
    // rust: let mut taken = other.clone();
    // rust: taken.count = amount;
    // rust: other.count -= amount;
    // rust: view.set(i, (other.count > 0).then_some(other));
    // rust: contents.try_insert(items, &mut taken);
}
}
}
            // removeOne into the empty slot (`safeInsert`); the rest goes back.
    // rust: None => {
    // rust: if let Some(mut stack) = contents.remove_one(items) {
    // rust: if view.may_place(i, &stack, rules) {
    // rust: let amount = stack.count.min(view.slot_max(i, &stack, rules));
    // rust: view.set(
    // rust: i,
    // rust: Some(ItemStack {
    // rust: count: amount,
    // rust: ..stack.clone()
    // rust: }),
    // rust: );
    // rust: stack.count -= amount;
}
    // rust: if stack.count > 0 {
    // rust: contents.try_insert(items, &mut stack);
}
}
}
}
    // rust: contents.store(&mut carried);
    // rust: view.guest.carried = Some(carried);
    // rust: return true;
}
    // rust: let Some(mut bundle) = other else {
    // rust: return false;
}
    // rust: let Some(mut contents) = Contents::of(items, &bundle) else {
    // rust: return false;
}
    // `Slot.allowModification`: `mayPickup` and `mayPlace` of the stack it
    // holds. A slot that withholds the bundle keeps what is inside it.
    // rust: let allowed = view.may_pickup(i, rules) && view.may_place(i, &bundle, rules);
    // rust: match (view.guest.carried.take(), right) {
    // rust: (Some(mut carried), false) => {
    // rust: if allowed {
    // rust: contents.try_insert(items, &mut carried);
}
    // rust: view.guest.carried = (carried.count > 0).then_some(carried);
}
    // rust: (None, true) => {
    // rust: if allowed {
    // rust: view.guest.carried = contents.remove_one(items);
}
}
    // rust: (carried, _) => {
            // toggleSelectedItem(-1), then the click goes on.
    // rust: view.guest.carried = carried;
    // rust: toggle_selected(&mut bundle, -1);
    // rust: view.set(i, Some(bundle));
    // rust: return false;
}
}
    // rust: contents.store(&mut bundle);
    // rust: view.set(i, Some(bundle));
    // rust: true
}

pub fn swap(view: *mut View, slot: i32, button: i32, rules: *dyn Rules) void {
}
    // rust: let Ok(i) = usize::try_from(slot) else {
    // rust: return;
}
    // rust: if i >= view.len() || !view.enabled(i) {
    // rust: return;
}
    // Hotbar slot `button` (0..9) or the off hand (40). A chest has no
    // off-hand slot, so F swaps with `Guest.offhand` (Inventory slot 40).
    // rust: if button == 40 && view.container.is_some() {
    // rust: let (clicked, off) = (view.get(i), view.guest.offhand.clone());
        // The stack coming out of the slot is a take like any other, and the
        // one going in must fit.
    // rust: if (clicked.is_some() && !view.may_pickup(i, rules))
    // rust: || off
    // rust: .as_ref()
    // rust: .is_some_and(|off| !view.may_place(i, off, rules))
    // rust: {
    // rust: return;
}
    // rust: view.set(i, off);
    // rust: view.guest.offhand = clicked;
    // rust: return;
}
    // rust: let other = match button {
    // rust: 0..=8 => match &view.container {
    // rust: Some(c) => c.len() + 27 + button as usize,
    // rust: None => 36 + button as usize,
    // rust: },
    // rust: 40 => 45,
    // rust: _ => return,
}
    // rust: if other == i {
    // rust: return;
}
    // rust: let (a, b) = (view.get(i), view.get(other));
    // `doClick`'s SWAP arm asks the clicked slot before anything moves: the
    // stack it holds only comes out while `Slot.mayPickup` allows it, and the
    // hotbar's stack only goes in where the slot takes it.
    // rust: if (a.is_some() && !view.may_pickup(i, rules))
    // rust: || a.as_ref().is_some_and(|a| !view.may_place(other, a, rules))
    // rust: || b.as_ref().is_some_and(|b| !view.may_place(i, b, rules))
    // rust: {
    // rust: return;
}
    // rust: view.set(i, b);
    // rust: view.set(other, a);
}

pub fn pickup_all(view: *mut View, slot: i32, button: i32, rules: *dyn Rules) void {
}
    // rust: let Ok(i) = usize::try_from(slot) else {
    // rust: return;
}
    // rust: if i >= view.len() {
    // rust: return;
}
    // rust: let Some(mut carried) = view.guest.carried.clone() else {
    // rust: return;
}
    // doClick returns when the clicked slot holds a stack it may pick up, so
    // a double-click collects from an empty slot or one that refuses.
    // rust: if view.get(i).is_some() && view.may_pickup(i, rules) {
    // rust: return;
}
    // rust: let max = rules.max_stack(&carried.item).max(1);
    // Button 0 walks the slots from the first, button 1 from the last.
    // rust: let order: Vec<usize> = if button == 0 {
    // rust: (0..view.len()).collect()
    // rust: } else {
    // rust: (0..view.len()).rev().collect()
}
    // Partial stacks first, then full ones.
    // rust: for full in [false, true] {
    // rust: for &i in &order {
    // rust: if carried.count >= max {
    // rust: break;
}
    // rust: if !view.enabled(i) || (view.container.is_none() && i == 0) {
    // rust: continue;
}
            // Each swept slot must give its stack up too.
    // rust: if !view.may_pickup(i, rules) {
    // rust: continue;
}
    // rust: let Some(mut s) = view.get(i) else {
    // rust: continue;
}
    // rust: if !s.same_item_same_components(&carried) || (s.count == max) != full {
    // rust: continue;
}
    // rust: let moved = (max - carried.count).min(s.count);
    // rust: carried.count += moved;
    // rust: s.count -= moved;
    // rust: view.set(i, (s.count > 0).then_some(s));
}
}
    // rust: view.guest.carried = Some(carried);
}

/// Dragging a stack over slots (QUICK_CRAFT): start, add slots, end.
    // rust: fn quick_craft(
    // rust: view: &mut View,
    // rust: drag: &mut Option<(u8, Vec<usize>)>,
    // rust: slot: i32,
    // rust: button: i32,
    // rust: rules: &dyn Rules,
    // rust: ) {
    // rust: let (stage, kind) = (button & 3, ((button >> 2) & 3) as u8);
    // rust: match stage {
    // rust: 0 => {
            // `getQuickcraftType` and `isValidQuickcraftType`: a charitable
            // (0) or greedy (1) drag is anyone's, a clone drag (2) needs
            // infinite materials, and 3 is no type at all. A start that is
            // not legal, or that arrives while a drag is open, leaves the
            // fields reset instead of collecting slots.
    // rust: let usable = match kind {
    // rust: 0 | 1 => true,
    // rust: 2 => view.guest.creative(),
    // rust: _ => false,
}
    // rust: *drag = (usable && drag.is_none() && view.guest.carried.is_some())
    // rust: .then_some((kind, Vec::new()));
}
    // rust: 1 => {
    // rust: if let (Some((_, slots)), Ok(i)) = (drag.as_mut(), usize::try_from(slot))
    // rust: && i < view.len()
    // rust: && !slots.contains(&i)
    // rust: && let Some(c) = &view.guest.carried
    // rust: && view.enabled(i)
    // rust: && view.may_place(i, c, rules)
    // rust: && view.get(i).is_none_or(|s| s.same_item_same_components(c))
    // rust: {
    // rust: slots.push(i);
}
}
    // rust: _ => {
    // rust: let Some((kind, slots)) = drag.take() else {
    // rust: return;
}
    // rust: let Some(mut carried) = view.guest.carried.clone() else {
    // rust: return;
}
    // rust: if slots.is_empty() {
    // rust: return;
}
    // rust: if slots.len() == 1 {
                // A single slot behaves like a plain click.
    // rust: let button = if kind == 1 { 1 } else { 0 };
    // rust: pickup(view, slots[0] as i32, button, rules);
    // rust: return;
}
    // rust: let each = match kind {
    // rust: 0 => carried.count / slots.len() as u32,
    // rust: 1 => 1,
    // rust: _ => rules.max_stack(&carried.item).max(1),
}
    // rust: for i in slots {
    // rust: if carried.count == 0 {
    // rust: break;
}
    // rust: let existing = view.get(i).map_or(0, |s| s.count);
    // rust: let max = view.slot_max(i, &carried, rules);
    // rust: let put = each.min(max.saturating_sub(existing)).min(carried.count);
    // rust: if put == 0 {
    // rust: continue;
}
    // rust: view.set(
    // rust: i,
    // rust: Some(ItemStack {
    // rust: count: existing + put,
    // rust: ..carried.clone()
    // rust: }),
    // rust: );
    // rust: if kind != 2 || !view.guest.creative() {
    // rust: carried.count -= put;
}
}
    // rust: view.guest.carried = (carried.count > 0).then_some(carried);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::lan::{Joined, PlayerSender};
//     use horizon_protocol::packets::configuration::ClientInformation;
//     use horizon_world::loot::PackOverlay;
//     use std::sync::{Arc, atomic::AtomicI32, mpsc};

pub const ItemRules = struct {};
    // rust: impl Rules for ItemRules {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
pub fn max_stack(self: *Self, item: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.get(item).map_or(64, |i| i.max_stack)
}
pub fn armor_index(self: *Self, _: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
}

pub fn guest() G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, _rx) = mpsc::channel();
    // rust: Guest::new(
    // rust: Joined {
    // rust: conn: 2,
    // rust: uuid: 2,
    // rust: name: "Alex".into(),
    // rust: properties: Vec::new(),
    // rust: info: ClientInformation::new(8),
    // rust: brand: "test".into(),
    // rust: sender: PlayerSender::new(tx, Arc::default()),
    // rust: latency: Arc::new(AtomicI32::new(0)),
    // rust: address: "127.0.0.1:25565".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: 2,
    // rust: [0.0, 64.0, 0.0],
    // rust: 8,
    // rust: )
}

    /// The prepared resources' items, or None (the test is skipped) without them.
pub fn rules() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("items.json").exists() {
    // rust: eprintln!("skipping resource-backed menu check: {}", root.display());
    // rust: return None;
}
    // rust: let registry = horizon_world::level::data::load_registry(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, &registry).unwrap();
    // rust: Some(ItemRules(
    // rust: Items::load(&root, &registry, &facts, &PackOverlay::NONE).unwrap(),
    // rust: ))
}

pub fn contents(stack: *?ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let inside = stack.as_ref().and_then(|s| s.data());
    // rust: inside.map_or(Vec::new(), |d| {
    // rust: d.bundle_contents
    // rust: .iter()
    // rust: .map(|s| (s.item.to_string(), s.count))
    // rust: .collect()
    // rust: })
}

    /// A double-click's collect walks the slots in the direction the button
    /// picks: `doClick`'s PICKUP_ALL arm starts at slot 0 with a step of +1 for
    /// button 0, and at the last slot with -1 for button 1, which is the
    /// button the screen sends for a double-click (`mouseReleased`).
pub fn pickup_all_walks_from_the_buttons_side() void {
}
    // rust: let rules = SwapRules;
    // rust: let mut g = guest();
    // rust: let mut chest = vec![None; 5];
    // rust: chest[0] = Some(ItemStack::new("minecraft:stone", 5));
    // rust: chest[1] = Some(ItemStack::new("minecraft:stone", 5));
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // `doClick` only starts the collect when the carried stack is not
        // empty and the clicked slot has no item or may not be taken
        // (`!carried.isEmpty() && (!slot.hasItem() || !slot.mayPickup(player))`),
        // so the click lands on an empty slot and the sweep picks the side.
        // One stone short of a full stack: the right double-click takes it
        // from the last matching slot.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 63));
    // rust: click(&mut view, &mut drag, 2, 1, input::PICKUP_ALL, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert_eq!(view.get(1).map(|s| s.count), Some(4));
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(64));
        // The left one takes it from the first.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 63));
    // rust: click(&mut view, &mut drag, 2, 0, input::PICKUP_ALL, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(4));
    // rust: assert_eq!(view.get(1).map(|s| s.count), Some(4));
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(64));
}

    /// A guest's chest clicks run `BundleItem`'s overrides: a carried
    /// bundle takes a slot's stack and drops its first one into an empty
    /// slot; a stack clicked onto a bundle goes in, as far as it fits.
pub fn guest_chest_clicks_fill_and_empty_bundles() void {
}
    // rust: let Some(rules) = rules() else {
    // rust: return;
}
    // rust: let mut g = guest();
    // rust: let mut chest = vec![
    // rust: Some(ItemStack::new("minecraft:stone", 48)),
    // rust: None,
    // rust: Some(ItemStack::new("minecraft:bundle", 1)),
    // rust: ];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:bundle", 1));
        // Left click with the bundle: the stone goes in.
    // rust: click(&mut view, &mut drag, 0, 0, input::PICKUP, &rules);
    // rust: assert_eq!(view.get(0), None);
    // rust: assert_eq!(
    // rust: contents(&view.guest.carried),
    // rust: [("minecraft:stone".into(), 48)]
    // rust: );
        // Right click on an empty slot: the stone comes back out.
    // rust: click(&mut view, &mut drag, 1, 1, input::PICKUP, &rules);
    // rust: assert_eq!(view.get(1).map(|s| s.count), Some(48));
    // rust: assert_eq!(contents(&view.guest.carried), []);
        // Ender pearls (1/16 each) onto the bundle in the chest: 16 fit.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:ender_pearl", 16));
    // rust: click(&mut view, &mut drag, 2, 0, input::PICKUP, &rules);
    // rust: assert_eq!(view.guest.carried, None);
    // rust: let bundle = view.get(2);
    // rust: assert_eq!(contents(&bundle), [("minecraft:ender_pearl".into(), 16)]);
        // Full: more stone stays in hand.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 5));
    // rust: click(&mut view, &mut drag, 2, 0, input::PICKUP, &rules);
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(5));
        // Right click on it with an empty hand takes the pearls out.
    // rust: view.guest.carried = None;
    // rust: click(&mut view, &mut drag, 2, 1, input::PICKUP, &rules);
    // rust: assert_eq!(
    // rust: view.guest.carried.as_ref().map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:ender_pearl", 16))
    // rust: );
    // rust: assert_eq!(contents(&view.get(2)), []);
}

    /// `Slot.allowModification`: `BundleItem.overrideOtherStackedOnMe` asks
    /// for `mayPickup` and `mayPlace` of the bundle it holds before it
    /// inserts or removes anything, so a slot whose rules refuse the pickup
    /// keeps its bundle's contents.
pub fn guest_bundle_keeps_its_contents_in_a_refusing_slot() void {
}
        /// The prepared catalog, with a menu that refuses one slot.
pub const Refusing = struct {
    items: Items,
};
    // rust: impl Rules for Refusing {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.items
}
pub fn max_stack(self: *Self, item: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.get(item).map_or(64, |i| i.max_stack)
}
pub fn armor_index(self: *Self, _: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn may_pickup(self: *Self, slot: usize, _: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: slot != 1
}
}
    // rust: let Some(ItemRules(items)) = rules() else {
    // rust: return;
}
    // rust: let rules = Refusing { items };
    // rust: let mut g = guest();
    // rust: let mut bundle = ItemStack::new("minecraft:bundle", 1);
    // rust: bundle.data_mut().bundle_contents = vec![ItemStack::new("minecraft:apple", 16)];
    // rust: let mut chest = vec![Some(ItemStack::new("minecraft:bundle", 1)), Some(bundle)];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // Left click with stone in hand over the refused bundle: nothing goes in.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 5));
    // rust: let (_, changed) = click(&mut view, &mut drag, 1, 0, input::PICKUP, &rules);
    // rust: assert!(changed.is_empty());
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(5));
    // rust: assert_eq!(contents(&view.get(1)), [("minecraft:apple".into(), 16)]);
        // A right click with an empty hand takes nothing out of it either.
    // rust: view.guest.carried = None;
    // rust: let (_, changed) = click(&mut view, &mut drag, 1, 1, input::PICKUP, &rules);
    // rust: assert!(changed.is_empty());
    // rust: assert!(view.guest.carried.is_none());
    // rust: assert_eq!(contents(&view.get(1)), [("minecraft:apple".into(), 16)]);
        // The empty bundle in the slot next to it does take the stone.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 5));
    // rust: click(&mut view, &mut drag, 0, 0, input::PICKUP, &rules);
    // rust: assert_eq!(view.guest.carried, None);
    // rust: assert_eq!(contents(&view.get(0)), [("minecraft:stone".into(), 5)]);
}

    /// A mod container saved with more items than its menu has slots: the
    /// menu reads and writes only its count, the rest stay saved.
pub fn mod_menu_shows_only_its_container_slots() void {
}
//         use crate::containers::{ModBlockEntityFields, ModContainer};
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let container = ModContainer {
    // rust: slots: 5,
    // rust: ..Default::default()
}
    // rust: world
    // rust: .block_entities
    // rust: .set_mod_containers([(0, Arc::new(container))].into_iter().collect());
    // rust: let mut items = vec![None; 9];
    // rust: items[1] = Some(ItemStack::new("minecraft:stone", 3));
    // rust: items[7] = Some(ItemStack::new("minecraft:iron_ore", 2));
    // rust: let k = (0, 64, 0);
    // rust: world.block_entities.insert(
    // rust: k,
    // rust: BlockEntity::Mod(Box::new(
    // rust: ModBlockEntityFields {
    // rust: id: "gtmod:machine".into(),
    // rust: items,
    // rust: ..Default::default()
}
    // rust: .into(),
    // rust: )),
    // rust: );
    // rust: let mut g = guest();
    // rust: let slots = Slots::Block(k);
    // rust: let mut read = slots.read(&world, &g).unwrap();
    // rust: assert_eq!(read.len(), 5);
    // rust: assert_eq!(slots.get(&world, &g, 7), None);
        // A shift-click from the hotbar (menu slot 5 + 27) lands in the
        // container's first empty slot, not past its count.
    // rust: if let Some(rules) = rules() {
    // rust: g.inventory[0] = Some(ItemStack::new("minecraft:dirt", 1));
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut read),
    // rust: shulker: false,
    // rust: hidden: &[],
}
    // rust: click(&mut view, &mut drag, 5 + 27, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.item), Some("minecraft:dirt".into()));
    // rust: } else {
    // rust: read[0] = Some(ItemStack::new("minecraft:dirt", 1));
}
    // rust: slots.write(&mut world, &mut g, read);
    // rust: let Some(BlockEntity::Mod(m)) = world.block_entities.get(&k) else {
    // rust: panic!("not a mod's");
}
    // rust: assert_eq!(m.items.len(), 9);
    // rust: assert_eq!(
    // rust: m.items[0].as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:dirt")
    // rust: );
    // rust: assert_eq!(m.items[1].as_ref().map(|s| s.count), Some(3));
    // rust: assert_eq!(m.items[7].as_ref().map(|s| s.count), Some(2));
}

    /// A slot a mod's screen hides is not in the menu: a shift-click from the
    /// inventory skips it, and a shift-click on it moves nothing.
pub fn a_hidden_slot_takes_no_quick_move() void {
}
    // rust: let Some(rules) = rules() else {
    // rust: return;
}
    // rust: let mut g = guest();
    // rust: let mut container = vec![None; 3];
    // rust: container[2] = Some(ItemStack::new("minecraft:stone", 1));
    // rust: g.inventory[0] = Some(ItemStack::new("minecraft:dirt", 1));
    // rust: let hidden = [0, 2];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut container),
    // rust: shulker: false,
    // rust: hidden: &hidden,
}
        // The hotbar's first slot (menu slot 3 + 27) lands in the one slot shown.
    // rust: click(&mut view, &mut drag, 3 + 27, 0, input::QUICK_MOVE, &rules);
    // rust: assert!(view.get(0).is_none());
    // rust: assert_eq!(view.get(1).map(|s| s.item), Some("minecraft:dirt".into()));
        // Nothing leaves a hidden slot either.
    // rust: click(&mut view, &mut drag, 2, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(2).map(|s| s.item), Some("minecraft:stone".into()));
}

    /// `AbstractContainerMenu.isValidQuickcraftType`: quick-craft type 2 (a
    /// clone drag) is for players with infinite materials only, and type 3 is
    /// no type at all. A survival guest that sends either moves nothing; a
    /// creative guest's clone drag fills the slots and keeps its stack.
pub fn a_clone_drag_needs_infinite_materials() void {
}
    // rust: let rules = SwapRules;
    // rust: let mut g = guest();
    // rust: let mut chest = vec![None; 3];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 64));
        // Start, two slots, end, for the two types a survival guest may not
        // use: 3 is no type, 2 is a clone drag.
    // rust: for kind in [3, 2] {
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: 0,
    // rust: kind << 2,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: 0,
    // rust: kind << 2 | 1,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: 1,
    // rust: kind << 2 | 1,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: -999,
    // rust: kind << 2 | 2,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: assert_eq!(view.get(0), None, "type {kind}");
    // rust: assert_eq!(view.get(1), None, "type {kind}");
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(64));
}
        // A charitable drag over the same two slots still shares the stack.
    // rust: click(&mut view, &mut drag, 0, 0, input::QUICK_CRAFT, &rules);
    // rust: click(&mut view, &mut drag, 0, 1, input::QUICK_CRAFT, &rules);
    // rust: click(&mut view, &mut drag, 1, 1, input::QUICK_CRAFT, &rules);
    // rust: click(&mut view, &mut drag, -999, 2, input::QUICK_CRAFT, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(32));
    // rust: assert_eq!(view.get(1).map(|s| s.count), Some(32));
    // rust: assert_eq!(view.guest.carried, None);
        // With infinite materials a clone drag goes through: both slots take
        // the whole stack and the cursor keeps it.
    // rust: view.guest.game_mode = crate::lan::guest::CREATIVE;
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 64));
    // rust: click(&mut view, &mut drag, 0, 2 << 2, input::QUICK_CRAFT, &rules);
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: 0,
    // rust: 2 << 2 | 1,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: 2,
    // rust: 2 << 2 | 1,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: -999,
    // rust: 2 << 2 | 2,
    // rust: input::QUICK_CRAFT,
    // rust: &rules,
    // rust: );
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(64));
    // rust: assert_eq!(view.get(2).map(|s| s.count), Some(64));
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(64));
}

pub const SwapRules = struct {};
    // rust: impl Rules for SwapRules {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: unreachable!("swap does not read the item catalog");
}
pub fn max_stack(self: *Self, _: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 64
}
pub fn armor_index(self: *Self, _: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
}

    /// `doClick`'s SWAP and THROW arms take the clicked slot's stack through
    /// `Slot.mayPickup` (`SWAP` puts it straight into the `Inventory`, and
    /// `THROW` goes through `safeTake`), so a slot that withholds its stack
    /// gives a number key, the off hand's F and a drop click nothing at all.
pub fn guest_swap_and_throw_need_the_slots_consent() void {
}
    // rust: let rules = StrictRules::new(&[0]);
    // rust: let mut g = guest();
    // rust: g.offhand = Some(ItemStack::new("minecraft:shield", 1));
    // rust: let mut chest = vec![
    // rust: Some(ItemStack::new("minecraft:stone", 5)),
    // rust: Some(ItemStack::new("minecraft:dirt", 2)),
    // rust: Some(ItemStack::new("minecraft:apple", 3)),
    // rust: ];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // Key 1 over the refused slot moves neither stack.
    // rust: click(&mut view, &mut drag, 0, 0, input::SWAP, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert!(view.guest.inventory[0].is_none());
        // F over it leaves the off hand alone too.
    // rust: click(&mut view, &mut drag, 0, 40, input::SWAP, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert_eq!(
    // rust: view.guest.offhand.as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:shield")
    // rust: );
        // A drop click throws nothing out of it.
    // rust: let (drops, _) = click(&mut view, &mut drag, 0, 1, input::THROW, &rules);
    // rust: assert!(drops.is_empty());
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
        // The slots next to it do all three.
    // rust: click(&mut view, &mut drag, 1, 1, input::SWAP, &rules);
    // rust: assert!(view.get(1).is_none());
    // rust: assert_eq!(view.guest.inventory[1].as_ref().map(|s| s.count), Some(2));
    // rust: click(&mut view, &mut drag, 2, 40, input::SWAP, &rules);
    // rust: assert_eq!(
    // rust: view.get(2).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:shield")
    // rust: );
    // rust: assert_eq!(
    // rust: view.guest.offhand.as_ref().map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:apple", 3))
    // rust: );
        // The first hotbar slot below the three chest slots (menu slot 30)
        // throws its stack.
    // rust: view.guest.inventory[0] = Some(ItemStack::new("minecraft:stick", 4));
    // rust: let (drops, _) = click(&mut view, &mut drag, 30, 1, input::THROW, &rules);
    // rust: assert_eq!(drops.iter().fold(0, |n, s| n + s.count), 4);
    // rust: assert!(view.guest.inventory[0].is_none());
}

    /// F (SWAP button 40) over a chest or the inventory below it swaps with
    /// the off hand, even though the menu has no off-hand slot.
pub fn guest_chest_f_swaps_with_the_off_hand() void {
}
    // rust: let rules = SwapRules;
    // rust: let mut g = guest();
    // rust: g.offhand = Some(ItemStack::new("minecraft:shield", 1));
    // rust: let mut chest = vec![Some(ItemStack::new("minecraft:diamond", 1)), None];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
    // rust: click(&mut view, &mut drag, 0, 40, input::SWAP, &rules);
    // rust: assert_eq!(
    // rust: view.get(0).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:shield")
    // rust: );
    // rust: assert_eq!(
    // rust: view.guest.offhand.as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:diamond")
    // rust: );
        // Empty chest slot: the off hand goes in.
    // rust: click(&mut view, &mut drag, 1, 40, input::SWAP, &rules);
    // rust: assert_eq!(
    // rust: view.get(1).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:diamond")
    // rust: );
    // rust: assert!(view.guest.offhand.is_none());
        // F over the first hotbar slot (menu slot 2 + 27).
    // rust: view.guest.offhand = Some(ItemStack::new("minecraft:oak_boat", 1));
    // rust: view.guest.inventory[0] = Some(ItemStack::new("minecraft:apple", 1));
    // rust: click(&mut view, &mut drag, 2 + 27, 40, input::SWAP, &rules);
    // rust: assert_eq!(
    // rust: view.guest.inventory[0].as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:oak_boat")
    // rust: );
    // rust: assert_eq!(
    // rust: view.guest.offhand.as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:apple")
    // rust: );
}

pub fn guest_shulker_box_menu_refuses_shulker_boxes() void {
}
    // rust: let Some(rules) = rules() else {
    // rust: return;
}
    // rust: for shulker in [true, false] {
    // rust: let mut g = guest();
    // rust: let mut container = vec![None; 27];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut container),
    // rust: shulker,
    // rust: hidden: &[],
}
            // Carried onto an empty slot, shift-clicked from the hotbar
            // (menu slot 27 + 27) and swapped in with the number key 1.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:red_shulker_box", 1));
    // rust: click(&mut view, &mut drag, 0, 0, input::PICKUP, &rules);
    // rust: assert_eq!(view.get(0).is_none(), shulker);
    // rust: view.guest.carried = None;
    // rust: view.guest.inventory[0] = Some(ItemStack::new("minecraft:shulker_box", 1));
    // rust: click(&mut view, &mut drag, 54, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.guest.inventory[0].is_some(), shulker);
    // rust: view.guest.inventory[0] = Some(ItemStack::new("minecraft:blue_shulker_box", 1));
    // rust: click(&mut view, &mut drag, 5, 0, input::SWAP, &rules);
    // rust: assert_eq!(view.get(5).is_none(), shulker);
            // Anything else goes in.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:diamond", 1));
    // rust: click(&mut view, &mut drag, 9, 0, input::PICKUP, &rules);
    // rust: assert!(view.get(9).is_some());
}
}

pub const EquipRules = struct {};
    // rust: impl Rules for EquipRules {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: unreachable!("a quick move reads no item catalog");
}
pub fn max_stack(self: *Self, _: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 64
}
pub fn armor_index(self: *Self, _: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn equip_slot(self: *Self, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (item == "minecraft:shield").then_some("offhand")
}
}

    /// A shift-click in the inventory menu puts a shield in the empty off-hand
    /// slot: `InventoryMenu.quickMoveStack` asks `getEquipmentSlotForItem` for
    /// `EquipmentSlot.OFFHAND` and moves it to slot 45 before it tries the
    /// hotbar. A full off hand, or an item with no `equippable` slot, still
    /// goes to the hotbar.
pub fn inventory_quick_move_equips_an_off_hand_item() void {
}
    // rust: let rules = EquipRules;
    // rust: let mut g = guest();
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: None,
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // Menu slot 9 is the first main-inventory slot, 45 the off hand.
    // rust: view.guest.inventory[9] = Some(ItemStack::new("minecraft:shield", 1));
    // rust: click(&mut view, &mut drag, 9, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(
    // rust: view.get(45).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:shield")
    // rust: );
    // rust: assert!(view.get(9).is_none());
    // rust: assert!(view.get(36).is_none());
        // The off hand is taken: the next shield goes to the hotbar instead.
    // rust: view.guest.inventory[9] = Some(ItemStack::new("minecraft:shield", 1));
    // rust: click(&mut view, &mut drag, 9, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(
    // rust: view.get(36).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:shield")
    // rust: );
    // rust: assert!(view.get(9).is_none());
        // An item that equips nowhere is untouched by the off-hand branch.
    // rust: view.guest.inventory[10] = Some(ItemStack::new("minecraft:diamond", 3));
    // rust: click(&mut view, &mut drag, 10, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(37).as_ref().map(|s| s.count), Some(3));
    // rust: assert_eq!(
    // rust: view.get(45).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:shield")
    // rust: );
}

    /// Rules that refuse a pickup in some menu slots and can stop drops.
pub const StrictRules = struct {
    items: Items,
    refuse: *'static [usize],
    drops: bool,
};
    // rust: impl StrictRules {
pub fn new(refuse: *'static [usize]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: items: Items::for_tests(Default::default()),
    // rust: refuse,
    // rust: drops: true,
}
}
}
    // rust: impl Rules for StrictRules {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.items
}
pub fn max_stack(self: *Self, _: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 64
}
pub fn armor_index(self: *Self, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (item == "minecraft:diamond_chestplate").then_some(1)
}
pub fn may_pickup(self: *Self, slot: usize, _: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.refuse.contains(&slot)
}
pub fn can_drop_items(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.drops
}
}

    /// `Slot.mayPickup`: a pickup and a quick move leave a slot's stack alone
    /// when the menu's rules refuse it there, while the slot next to it still
    /// gives its own stack up.
pub fn guest_pickup_and_quick_move_need_the_slots_consent() void {
}
    // rust: let rules = StrictRules::new(&[0]);
    // rust: let mut g = guest();
    // rust: let mut chest = vec![
    // rust: Some(ItemStack::new("minecraft:stone", 5)),
    // rust: Some(ItemStack::new("minecraft:dirt", 2)),
    // rust: ];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // The refused slot takes no click and gives nothing to the cursor.
    // rust: click(&mut view, &mut drag, 0, 0, input::PICKUP, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert_eq!(view.guest.carried, None);
        // A quick move out of it takes nothing with it either.
    // rust: click(&mut view, &mut drag, 0, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert!(view.get(2).is_none());
        // The slot next to it takes both clicks.
    // rust: click(&mut view, &mut drag, 1, 0, input::PICKUP, &rules);
    // rust: assert!(view.get(1).is_none());
    // rust: assert_eq!(
    // rust: view.guest.carried.as_ref().map(|s| (&*s.item, s.count)),
    // rust: Some(("minecraft:dirt", 2))
    // rust: );
    // rust: let back = view.guest.carried.take();
    // rust: view.set(1, back);
    // rust: click(&mut view, &mut drag, 1, 0, input::QUICK_MOVE, &rules);
        // A container's quick move fills the inventory from its end.
    // rust: assert_eq!(
    // rust: view.get(37).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:dirt")
    // rust: );
}

    /// `doClick`'s PICKUP_ALL arm returns when the clicked slot holds a stack
    /// it may pick up, so a double-click collects from an empty slot, or from
    /// one that refuses, only.
pub fn guest_pickup_all_starts_from_an_empty_or_refusing_slot() void {
}
    // rust: let rules = StrictRules::new(&[]);
    // rust: let mut g = guest();
    // rust: let mut chest = vec![Some(ItemStack::new("minecraft:stone", 5)), None];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // One stone short of a full stack, over a slot that holds stone.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 63));
    // rust: click(&mut view, &mut drag, 0, 1, input::PICKUP_ALL, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(63));
        // The empty slot next to it does collect that one stone.
    // rust: click(&mut view, &mut drag, 1, 1, input::PICKUP_ALL, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(4));
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(64));
        // A refusing slot is where a collect may start: the stone comes from
        // the slot that allows it, the refused one is left alone.
    // rust: let refusing = StrictRules::new(&[0]);
    // rust: view.set(0, Some(ItemStack::new("minecraft:stone", 5)));
    // rust: view.set(1, Some(ItemStack::new("minecraft:stone", 5)));
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:stone", 63));
    // rust: click(&mut view, &mut drag, 0, 1, input::PICKUP_ALL, &refusing);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert_eq!(view.get(1).map(|s| s.count), Some(4));
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(64));
}

    /// `Player.canDropItems`: a client that has dropped too fast sends THROW
    /// clicks the menu does not act on.
pub fn guest_throw_needs_can_drop_items() void {
}
    // rust: let mut rules = StrictRules::new(&[]);
    // rust: rules.drops = false;
    // rust: let mut g = guest();
    // rust: let mut chest = vec![Some(ItemStack::new("minecraft:stone", 5))];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
    // rust: let (drops, _) = click(&mut view, &mut drag, 0, 0, input::THROW, &rules);
    // rust: assert!(drops.is_empty());
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: rules.drops = true;
    // rust: let (drops, _) = click(&mut view, &mut drag, 0, 0, input::THROW, &rules);
    // rust: assert_eq!(drops.iter().fold(0, |n, s| n + s.count), 1);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(4));
}

    /// `ArmorSlot.mayPickup`: a survival guest cannot take cursed armour off;
    /// a creative one can, by a click and by a shift-click.
pub fn guest_survival_cannot_remove_cursed_armour() void {
}
    // rust: let rules = StrictRules::new(&[]);
    // rust: for (game_mode, taken) in [
    // rust: (crate::lan::guest::SURVIVAL, false),
    // rust: (crate::lan::guest::CREATIVE, true),
    // rust: ] {
    // rust: for mode in [input::PICKUP, input::QUICK_MOVE] {
    // rust: let mut g = guest();
    // rust: let mut cursed = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: cursed.set_crafting_enchantments(vec![("minecraft:binding_curse".into(), 1)]);
    // rust: g.armor[1] = Some(cursed);
    // rust: g.game_mode = game_mode;
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: None,
    // rust: shulker: false,
    // rust: hidden: &[],
}
                // Menu slot 6 is the chest slot.
    // rust: click(&mut view, &mut drag, 6, 0, mode, &rules);
    // rust: assert_eq!(view.get(6).is_some(), !taken);
    // rust: assert_eq!(view.guest.carried.is_some() || view.get(9).is_some(), taken);
}
}
}

    /// The same `ArmorSlot.mayPickup` answers a number key and a drop click:
    /// `doClick`'s SWAP arm moves the slot's stack into the `Inventory`
    /// itself and THROW calls `safeTake`, so both ask the slot first.
pub fn guest_swap_and_throw_keep_cursed_armour_on() void {
}
    // rust: let rules = StrictRules::new(&[]);
    // rust: for (game_mode, moved) in [
    // rust: (crate::lan::guest::SURVIVAL, false),
    // rust: (crate::lan::guest::CREATIVE, true),
    // rust: ] {
    // rust: for (mode, button) in [(input::THROW, 1), (input::SWAP, 0)] {
    // rust: let mut g = guest();
    // rust: let mut cursed = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: cursed.set_crafting_enchantments(vec![("minecraft:binding_curse".into(), 1)]);
    // rust: g.armor[1] = Some(cursed);
    // rust: g.game_mode = game_mode;
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: None,
    // rust: shulker: false,
    // rust: hidden: &[],
}
                // Menu slot 6 is the chest slot. A drop click throws the
                // stack out; number key 1 puts it in the first hotbar slot
                // (menu slot 36).
    // rust: let (drops, _) = click(&mut view, &mut drag, 6, button, mode, &rules);
    // rust: assert_eq!(view.get(6).is_some(), !moved, "mode {mode}");
    // rust: if mode == input::THROW {
    // rust: assert_eq!(drops.is_empty(), !moved, "mode {mode} drops");
    // rust: } else {
    // rust: assert_eq!(view.guest.inventory[0].is_some(), moved, "mode {mode}");
}
}
}
}

pub const ArmorRules = struct {};
    // rust: impl Rules for ArmorRules {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: unreachable!("a quick move reads no item catalog");
}
pub fn max_stack(self: *Self, _: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 64
}
pub fn armor_index(self: *Self, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (item == "minecraft:iron_helmet").then_some(0)
}
pub fn equip_slot(self: *Self, _: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
}

    /// A shift-click from the off-hand slot wears the armour it holds:
    /// `InventoryMenu.quickMoveStack` asks for the item's equipment slot
    /// before it looks at the clicked index, so the helmet goes to the empty
    /// helmet slot. With that slot taken, and for anything else in the off
    /// hand, the stack fills the main inventory before the hotbar.
pub fn inventory_quick_move_wears_armor_from_the_off_hand() void {
}
    // rust: let rules = ArmorRules;
    // rust: let mut g = guest();
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: None,
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // Menu slot 45 is the off hand; 5 to 8 are the armour slots, head first.
    // rust: view.guest.offhand = Some(ItemStack::new("minecraft:iron_helmet", 1));
    // rust: click(&mut view, &mut drag, 45, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(
    // rust: view.get(5).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:iron_helmet")
    // rust: );
    // rust: assert!(view.get(45).is_none());
    // rust: assert!(view.get(9).is_none());
        // The helmet slot is taken: the next helmet goes to the inventory.
    // rust: view.guest.offhand = Some(ItemStack::new("minecraft:iron_helmet", 1));
    // rust: click(&mut view, &mut drag, 45, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(
    // rust: view.get(9).as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:iron_helmet")
    // rust: );
    // rust: assert!(view.get(45).is_none());
        // Anything else fills the main inventory before the hotbar.
    // rust: view.guest.offhand = Some(ItemStack::new("minecraft:diamond", 3));
    // rust: click(&mut view, &mut drag, 45, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(10).as_ref().map(|s| s.count), Some(3));
    // rust: assert!(view.get(36).is_none());
    // rust: assert!(view.get(45).is_none());
}

    /// `doClick` repeats `quickMoveStack` while the clicked slot keeps the
    /// item, because `moveItemStackTo` fills one empty slot per call. This
    /// engine's `move_to` fills every empty slot of its range in one pass, so a
    /// single quick move must spread a stack over several slots with the same
    /// remainder vanilla's loop leaves, and a full inventory must leave the
    /// stack where it is.
pub fn one_quick_move_spreads_a_stack_like_vanillas_repeat() void {
}
pub const SmallRules = struct {};
    // rust: impl Rules for SmallRules {
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: unreachable!("a quick move reads no item catalog");
}
pub fn max_stack(self: *Self, item: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if item == "minecraft:snowball" { 16 } else { 64 }
}
pub fn armor_index(self: *Self, _: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
}
    // rust: let rules = SmallRules;
    // rust: let mut g = guest();
    // rust: let mut chest = vec![Some(ItemStack::new("minecraft:snowball", 40))];
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: Some(&mut chest),
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // A container's quick move fills the inventory from its end: 16
        // snowballs in the last hotbar slot (menu slot 36), 16 in the one
        // before it, 8 in the third, and nothing left in the chest.
    // rust: click(&mut view, &mut drag, 0, 0, input::QUICK_MOVE, &rules);
    // rust: assert!(view.get(0).is_none());
    // rust: assert_eq!(view.get(36).map(|s| s.count), Some(16));
    // rust: assert_eq!(view.get(35).map(|s| s.count), Some(16));
    // rust: assert_eq!(view.get(34).map(|s| s.count), Some(8));
        // Two slots' worth of room only: the loop vanilla runs would stop
        // after the second call, so 8 stay in the chest.
    // rust: for i in 0..36 {
    // rust: view.guest.inventory[i] = Some(ItemStack::new("minecraft:dirt", 1));
}
    // rust: view.set(0, Some(ItemStack::new("minecraft:snowball", 40)));
        // The fill starts at the hotbar's end: menu slots 36 and 35.
    // rust: view.guest.inventory[8] = None;
    // rust: view.guest.inventory[7] = None;
    // rust: click(&mut view, &mut drag, 0, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(8));
    // rust: assert_eq!(view.get(36).map(|s| s.count), Some(16));
    // rust: assert_eq!(view.get(35).map(|s| s.count), Some(16));
        // A full inventory moves nothing at all.
    // rust: for i in 0..36 {
    // rust: view.guest.inventory[i] = Some(ItemStack::new("minecraft:dirt", 1));
}
    // rust: view.set(0, Some(ItemStack::new("minecraft:snowball", 5)));
    // rust: let (drops, changed) = click(&mut view, &mut drag, 0, 0, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(0).map(|s| s.count), Some(5));
    // rust: assert!(drops.is_empty() && changed.is_empty());
}

    /// `AbstractContainerMenu.isContainerClickButton`: a pickup and a quick
    /// move exist for buttons 0 and 1 only, so a modified client's other
    /// buttons take nothing out of a slot, move nothing to the hotbar and
    /// drop nothing from the cursor. The other modes are not buttons' business.
pub fn guest_clicks_with_a_button_other_than_0_or_1_move_nothing() void {
}
    // rust: let rules = ItemRules(Items::for_tests(Default::default()));
    // rust: let mut g = guest();
    // rust: let mut drag = None;
    // rust: let mut view = View {
    // rust: guest: &mut g,
    // rust: container: None,
    // rust: shulker: false,
    // rust: hidden: &[],
}
        // Menu slot 9 stands for inventory index 9, 36 for the hotbar's first.
    // rust: view.guest.inventory[9] = Some(ItemStack::new("minecraft:diamond", 3));
    // rust: click(&mut view, &mut drag, 9, 2, input::PICKUP, &rules);
    // rust: assert_eq!(view.guest.carried, None);
    // rust: assert_eq!(view.get(9).map(|s| s.count), Some(3));
    // rust: click(&mut view, &mut drag, 9, 2, input::QUICK_MOVE, &rules);
    // rust: assert_eq!(view.get(9).map(|s| s.count), Some(3));
    // rust: assert!(view.get(36).is_none());
        // A click outside the window drops nothing either.
    // rust: view.guest.carried = Some(ItemStack::new("minecraft:dirt", 5));
    // rust: let (drops, changed) = click(&mut view, &mut drag, -999, 2, input::PICKUP, &rules);
    // rust: assert!(drops.is_empty() && changed.is_empty());
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(5));
        // Button 1 still takes half of the stack.
    // rust: view.guest.carried = None;
    // rust: click(&mut view, &mut drag, 9, 1, input::PICKUP, &rules);
    // rust: assert_eq!(view.guest.carried.as_ref().map(|s| s.count), Some(2));
    // rust: assert_eq!(view.get(9).map(|s| s.count), Some(1));
        // THROW reads its button as "one or the whole stack", not as a
        // primary or secondary action.
    // rust: view.guest.carried = None;
    // rust: view.guest.inventory[9] = Some(ItemStack::new("minecraft:diamond", 4));
    // rust: let (drops, _) = click(&mut view, &mut drag, 9, 2, input::THROW, &rules);
    // rust: assert_eq!(drops.iter().fold(0, |n, s| n + s.count), 4);
    // rust: assert!(view.get(9).is_none());
}
}
