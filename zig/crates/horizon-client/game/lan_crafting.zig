//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_crafting
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Crafting for LAN guests: the inventory's 2x2 grid (window 0) and the
//! crafting table (`minecraft:crafting`) run the host's menu engine
//! (`horizon_client::menu`, `Kind::Inventory` / `Kind::Crafting`) over the
//! guest's inventory, with vanilla's packets: OpenScreen, container clicks
//! and their corrections, and the grid back into the inventory when the menu
//! closes (`AbstractContainerMenu.clearContainer`).
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: furnace::FurnaceCooking,
    // rust: items::ItemStack,
    // rust: lan::{guest::Guest, menu::Slots},
    // rust: menu::{Env, Input, Kind, Menu},
}
// use horizon_protocol::packets::play::{self, Clientbound as C};

/// `AbstractContainerMenu.dropOrPlaceInInventory`: actual network disconnects
/// drop inputs; a live close still returns them to the inventory.
    // rust: pub(super) enum MenuRemoval {
    // rust: Live,
    // rust: Disconnected,
}

/// The guest's menus the game runs: kept between clicks, so a drag (quick
/// craft) spans them as in vanilla.
    // rust: pub(super) struct GuestCrafting {
    /// The inventory menu; its grid lives in the hub's guest.
    // rust: inventory: Option<Box<Menu>>,
    /// The open crafting table: its window, state id, menu and block.
    // rust: pub(super) table: Option<(i32, i32, Box<Menu>, [i32; 3])>,
    /// The open furnace's or brewing stand's window and menu (`AbstractFurnaceMenu`,
    /// `BrewingStandMenu`); its slots live in the block entity and the hub's
    /// container menu keeps the client in sync.
    // rust: pub(super) machine: Option<(i32, Box<Menu>)>,
}

/// ServerboundContainerClickPacket's input.
    // rust: pub(super) fn input(id: i32) -> Input {
    // rust: match id {
    // rust: 0 => Input::Pickup,
    // rust: 1 => Input::QuickMove,
    // rust: 2 => Input::Swap,
    // rust: 3 => Input::Clone,
    // rust: 4 => Input::Throw,
    // rust: 5 => Input::QuickCraft,
    // rust: _ => Input::PickupAll,
}
}

/// The armor's player-container slots, head to feet (`Inventory` 39..36).
pub const ARMOR: [usize; 4] = [39, 38, 37, 36];
pub const OFFHAND: usize = 40;

/// The guest's inventory, armor, off hand, selection and carried stack into `menu`.
pub fn load_player(menu: *mut Menu, g: *Guest) void {
}
    // rust: for i in 0..36 {
    // rust: menu.set_player_item(i, g.inventory[i].clone());
}
    // rust: for (k, slot) in ARMOR.into_iter().enumerate() {
    // rust: menu.set_player_item(slot, g.armor[k].clone());
}
    // rust: menu.set_player_item(OFFHAND, g.offhand.clone());
    // rust: menu.selected = g.selected;
    // rust: menu.creative = g.creative();
    // rust: menu.levels = g.xp_level;
    // rust: menu.carried = g.carried.clone();
}

/// `load_player` back.
pub fn store_player(menu: *mut Menu, g: *mut Guest) void {
}
    // rust: for i in 0..36 {
    // rust: g.inventory[i] = menu.player_item(i).cloned();
}
    // rust: for (k, slot) in ARMOR.into_iter().enumerate() {
    // rust: g.armor[k] = menu.player_item(slot).cloned();
}
    // rust: g.offhand = menu.player_item(OFFHAND).cloned();
    // rust: g.carried = menu.carried.take();
}

/// Inventory.placeItemBackInInventory for each stack: what doesn't fit is
/// left for Player.drop (creative players keep it too).
pub fn place_back(menu: *mut Menu, env: *Env, stacks: std.ArrayList(ItemStack)) void {
}
    // rust: menu.creative = false;
    // rust: for mut stack in stacks {
    // rust: menu.give(env, &mut stack);
    // rust: if stack.count > 0 {
    // rust: menu.dropped.push(stack);
}
}
}

    // rust: impl Game<'_> {
    /// `LocalPlayer.doLimitedCrafting`: whether limited crafting is active.
pub fn limited_crafting(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote.as_ref().map_or_else(
    // rust: || self.ui.rules.bool("limited_crafting"),
    // rust: |r| r.do_limited_crafting,
    // rust: )
}

    // rust: pub(super) fn menu_env(&self) -> Env<'_> {
    // rust: Env {
    // rust: items: self.items(),
    // rust: recipes: self.recipes(),
    // rust: brewing: &self.stations().brewing,
    // rust: banners: &self.stations().banners,
    // rust: station_recipes: &self.stations().recipes,
    // rust: enchantments: &self.stations().enchantments,
    // rust: names: &self.pack.names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: self.limited_crafting(),
    // rust: known_recipes: Some(&self.level.recipe_book),
}
}

    /// Runs `op` on the guest's menu with their inventory copied in and back.
    // rust: pub(super) fn guest_menu_op<R>(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: gi: usize,
    // rust: menu: &mut Menu,
    // rust: op: impl FnOnce(&mut Menu, &Env) -> R,
    // rust: ) -> R {
        // The cartography table reads and makes the host level's maps.
    // rust: let maps = (menu.kind() == Kind::Cartography).then(|| {
    // rust: let g = &host.hub.guests[gi];
    // rust: let held: Vec<ItemStack> = (0..menu.slot_count())
    // rust: .filter_map(|s| menu.slot(s).cloned())
    // rust: .chain(g.inventory.iter().flatten().cloned())
    // rust: .chain(g.carried.clone())
    // rust: .collect();
    // rust: self.level_maps(&held)
    // rust: });
    // rust: let env = Env {
    // rust: maps: maps.as_ref().map(|m| m as &dyn horizon_client::menu::Maps),
    // rust: limited_crafting: host.hub.limited_crafting,
    // rust: known_recipes: Some(&host.hub.guests[gi].recipe_book),
    // rust: ..self.menu_env()
}
    // rust: load_player(menu, &host.hub.guests[gi]);
    // rust: let result = op(menu, &env);
    // rust: if let Some(maps) = maps {
    // rust: self.register_made_maps(maps);
}
        // A taken anvil result waits for AnvilCraftEvent.Pre: what the click
        // dropped waits with it (lan_station_op throws it or refuses the take).
    // rust: let dropped = if menu.anvil_craft.is_some() {
    // rust: Vec::new()
    // rust: } else {
    // rust: std::mem::take(&mut menu.dropped)
}
    // rust: let equipped = std::mem::take(&mut menu.equipped);
    // rust: let brewed = std::mem::take(&mut menu.brewed);
    // rust: let crafted = std::mem::take(&mut menu.crafted);
    // rust: let item_crafted = std::mem::take(&mut menu.item_crafted);
    // rust: menu.drops.clear();
    // rust: store_player(menu, &mut host.hub.guests[gi]);
    // rust: if !brewed.is_empty() {
    // rust: let conn = host.hub.guests[gi].conn;
    // rust: self.as_guest(host, conn, |g| {
    // rust: for stack in &brewed {
    // rust: g.trigger_brewed_potion(stack);
}
    // rust: });
}
    // rust: if !crafted.is_empty() {
    // rust: let conn = host.hub.guests[gi].conn;
    // rust: self.as_guest(host, conn, |g| {
    // rust: for (recipe, ingredients) in &crafted {
    // rust: g.trigger_recipe_crafted(recipe, ingredients);
}
    // rust: });
}
    // rust: if !item_crafted.is_empty() {
    // rust: let conn = host.hub.guests[gi].conn;
    // rust: self.as_guest(host, conn, |g| {
    // rust: let player = g.native_acting_id();
    // rust: for (recipe, stack) in &item_crafted {
    // rust: g.native_item_crafted(player, recipe, stack);
}
    // rust: });
}
    // rust: if !equipped.is_empty() {
    // rust: let conn = host.hub.guests[gi].conn;
    // rust: self.as_guest(host, conn, |g| {
    // rust: for (slot, stack) in equipped {
    // rust: g.player_equipped(slot, stack.as_ref());
}
    // rust: });
}
    // rust: self.drop_guest_items(host, gi, dropped);
    // rust: result
}

    /// A click on the guest's inventory menu (window 0): `InventoryMenu`,
    /// crafting grid included. False for other windows.
    // rust: pub(super) fn lan_inventory_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: if p.container != 0 {
    // rust: return false;
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return true;
}
    // rust: if host.hub.guests[gi].spectator() {
    // rust: return true;
}
    // rust: let crafting = host.play.entry(conn).or_default();
    // rust: let mut menu = crafting
    // rust: .crafting
    // rust: .inventory
    // rust: .take()
    // rust: .unwrap_or_else(|| Box::new(Menu::new(Kind::Inventory)));
    // rust: let grid = host.hub.guests[gi].craft_grid.clone();
    // rust: let changed = self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: for (k, s) in grid.into_iter().enumerate() {
    // rust: menu.set_slot(env, 1 + k, s);
}
    // rust: let before: Vec<_> = (0..menu.slot_count())
    // rust: .map(|s| menu.slot(s).cloned())
    // rust: .collect();
    // rust: let _ = menu.click(env, i32::from(p.slot), i32::from(p.button), input(p.input));
    // rust: (0..menu.slot_count())
    // rust: .filter(|&s| menu.slot(s) != before[s].as_ref())
    // rust: .collect::<Vec<_>>()
    // rust: });
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: let mut result = menu.slot(0).cloned();
    // rust: self.native_prepare_item_craft(uuid, &name, None, &mut result);
    // rust: let env = self.menu_env();
    // rust: menu.set_slot(&env, 0, result);
    // rust: let g = &mut host.hub.guests[gi];
    // rust: for k in 0..4 {
    // rust: g.craft_grid[k] = menu.slot(1 + k).cloned();
}
    // rust: g.craft_result = menu.slot(0).cloned();
    // rust: host.play.entry(conn).or_default().crafting.inventory = Some(menu);
    // rust: host.hub.inventory_clicked(conn, p, &self.world, &changed);
    // rust: true
}

    /// A click on the guest's open furnace, blast furnace, smoker or brewing stand:
    /// the host's `AbstractFurnaceMenu` (fuel slot, take-only result, quick moves by
    /// recipe and fuel), `BrewingStandMenu` (one bottle per slot, ingredient and
    /// blaze powder slots) or a content mod's menu type (`Kind::Mod`) over the
    /// block entity's slots. False for other windows.
    // rust: pub(super) fn lan_machine_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return false;
}
    // rust: let Some((pos, mod_type, hidden)) = host.hub.guests[gi]
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|m| p.container != 0 && m.window == p.container)
    // rust: .and_then(|m| match m.slots {
    // rust: Slots::Block(pos) => Some((pos, m.mod_type, m.hidden.clone())),
    // rust: _ => None,
    // rust: })
    // rust: else {
    // rust: return false;
}
    // rust: let (kind, items) = match self.world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::Furnace(f)) => {
    // rust: let recipe = match f.kind.recipe_type() {
    // rust: "minecraft:blasting" => "blasting",
    // rust: "minecraft:smoking" => "smoking",
    // rust: _ => "smelting",
}
    // rust: (Kind::Furnace(recipe), f.items.to_vec())
}
    // rust: Some(BlockEntity::Brewing(b)) => (Kind::Brewing, b.items.to_vec()),
    // rust: Some(BlockEntity::Crafter(c)) => (Kind::CrafterBlock, c.items.to_vec()),
            // A content mod's menu type, with its slots' rules.
    // rust: Some(BlockEntity::Mod(m)) => match mod_type {
    // rust: Some(t) => {
    // rust: let mut items = m.items.clone();
    // rust: items.resize(t.slots, None);
    // rust: (Kind::Mod(t), items)
}
    // rust: None => return false,
    // rust: },
    // rust: _ => return false,
}
    // rust: let furnace = matches!(kind, Kind::Furnace(_));
        // CrafterBlockEntity.containerData: the disabled slots, then triggered.
    // rust: let crafter_data = match self.world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::Crafter(c)) => Some((c.disabled, c.triggered)),
    // rust: _ => None,
}
    // rust: if host.hub.guests[gi].spectator() {
            // handleContainerClick: nothing changes, and sendAllDataToRemote
            // takes back what the client predicted.
    // rust: host.hub.resend_menu(conn, p.container, &self.world);
    // rust: return true;
}
    // rust: let mut menu = host
    // rust: .play
    // rust: .entry(conn)
    // rust: .or_default()
    // rust: .crafting
    // rust: .machine
    // rust: .take()
    // rust: .filter(|(window, m)| *window == p.container && m.kind() == kind)
    // rust: .map_or_else(|| Box::new(Menu::new(kind)), |(_, m)| m);
    // rust: for &slot in &hidden {
    // rust: menu.hide_slot(slot);
}
    // rust: let changed = self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: for (k, s) in items.iter().enumerate() {
    // rust: menu.set_slot(env, k, s.clone());
}
            // After the slots: setting a disabled slot (CrafterBlockEntity.setItem) enables it.
    // rust: if let Some((disabled, triggered)) = crafter_data {
    // rust: for (k, d) in disabled.iter().enumerate() {
    // rust: menu.data[k] = i32::from(*d);
}
    // rust: menu.data[9] = i32::from(triggered);
}
    // rust: let before: Vec<_> = (0..menu.slot_count())
    // rust: .map(|s| menu.slot(s).cloned())
    // rust: .collect();
    // rust: let _ = menu.click(env, i32::from(p.slot), i32::from(p.button), input(p.input));
    // rust: (0..menu.slot_count())
    // rust: .filter(|&s| menu.slot(s) != before[s].as_ref())
    // rust: .collect::<Vec<_>>()
    // rust: });
    // rust: match self.world.block_entities.get_mut(&pos) {
    // rust: Some(BlockEntity::Furnace(f)) => {
    // rust: for k in 0..3 {
    // rust: f.items[k] = menu.slot(k).cloned();
}
                // AbstractFurnaceBlockEntity.setItem: only a new input restarts cooking.
    // rust: f.input_clicked(world_recipes!(self), items[0].clone());
}
            // BrewingStandBlockEntity.serverTick notices a new ingredient itself.
    // rust: Some(BlockEntity::Brewing(b)) => {
    // rust: for k in 0..5 {
    // rust: b.items[k] = menu.slot(k).cloned();
}
}
            // The mod's items past its menu's slots stay as they were.
    // rust: Some(BlockEntity::Mod(m)) => {
    // rust: let n = items.len();
    // rust: if m.items.len() < n {
    // rust: m.items.resize(n, None);
}
    // rust: for (k, slot) in m.items.iter_mut().take(n).enumerate() {
    // rust: *slot = menu.slot(k).cloned();
}
}
            // CrafterBlockEntity.setItem: filling a disabled slot enables it.
    // rust: Some(BlockEntity::Crafter(c)) => {
    // rust: for k in 0..9 {
    // rust: c.items[k] = menu.slot(k).cloned();
    // rust: c.disabled[k] = menu.data[k] == 1;
}
}
    // rust: _ => {}
}
        // FurnaceResultSlot.checkTakeAchievements: the guest took from the output.
    // rust: let count = |s: Option<&ItemStack>| s.map_or(0, |s| s.count);
    // rust: if furnace && count(menu.slot(2)) < count(items[2].as_ref()) {
    // rust: let at = host.hub.guests[gi].position;
    // rust: let guest = &host.hub.guests[gi];
    // rust: let output = items[2].as_ref();
    // rust: if let Some(output) = output {
    // rust: self.native_furnace_extract(
    // rust: guest.uuid,
    // rust: &guest.name,
    // rust: [pos.0, pos.1, pos.2],
    // rust: &output.item,
    // rust: output.count - count(menu.slot(2)),
    // rust: );
}
    // rust: self.award_furnace_recipes(pos, at);
}
        // Slot.setChanged on a changed container slot: BlockEntity.setChanged,
        // so the chunk is saved and comparators read the block again.
    // rust: if changed.iter().any(|&s| s < items.len()) {
    // rust: self.container_changed(pos);
}
    // rust: host.play.entry(conn).or_default().crafting.machine = Some((p.container, menu));
    // rust: host.hub.inventory_clicked(conn, p, &self.world, &changed);
    // rust: true
}

    /// `ServerGamePacketListenerImpl.handleContainerSlotStateChanged`: a
    /// guest's crafter slot toggle (`CrafterBlockEntity.setSlotState`) in
    /// their open crafter window.
    // rust: pub(super) fn lan_crafter_slot_state(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: i32,
    // rust: slot: i32,
    // rust: enabled: bool,
    // rust: ) {
    // rust: let Some(pos) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .filter(|g| !g.spectator())
    // rust: .and_then(|g| g.menu.as_ref())
    // rust: .filter(|m| window != 0 && m.window == window)
    // rust: .and_then(|m| match m.slots {
    // rust: Slots::Block(pos) => Some(pos),
    // rust: _ => None,
    // rust: })
    // rust: else {
    // rust: return;
}
    // rust: if let (Some(BlockEntity::Crafter(c)), Ok(slot)) = (
    // rust: self.world.block_entities.get_mut(&pos),
    // rust: usize::try_from(slot),
    // rust: ) {
    // rust: c.set_slot_state(slot, enabled);
    // rust: self.world.modified.insert((pos.0 >> 4, pos.2 >> 4));
}
}

    /// ServerGamePacketListenerImpl.handlePlaceRecipe: the guest's recipe
    /// book places a known recipe in their inventory grid or crafting table
    /// (`ServerPlaceRecipe`), and answers with a ghost recipe when the items
    /// are missing.
    // rust: pub(super) fn lan_place_recipe(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &horizon_protocol::packets::recipes::PlaceRecipe,
    // rust: ) {
//         use horizon_client::menu::place::PostPlace;
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let g = &host.hub.guests[gi];
    // rust: if g.spectator() {
    // rust: return;
}
        // The server menu uses the world's active data-pack tables, the same
        // tables used by the guest menu below. The base resources can have a
        // different display registry or placement for an overridden recipe.
    // rust: let Some(id) = world_stations!(self)
    // rust: .recipe_index
    // rust: .recipe_of_display(p.recipe)
    // rust: .map(str::to_owned)
    // rust: else {
    // rust: return;
}
        // An unknown or impossible recipe is refused outright.
    // rust: if !g.recipe_book.knows(&id)
    // rust: || world_recipes!(self)
    // rust: .placement(&id)
    // rust: .is_none_or(|placement| placement.impossible())
    // rust: {
    // rust: return;
}
    // rust: let (player, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_recipe_book_click(player, &name, &id, p.use_max);
    // rust: let creative = g.creative();
    // rust: let placed = if p.container == 0 {
    // rust: let crafting = host.play.entry(conn).or_default();
    // rust: let mut menu = crafting
    // rust: .crafting
    // rust: .inventory
    // rust: .take()
    // rust: .unwrap_or_else(|| Box::new(Menu::new(Kind::Inventory)));
    // rust: let grid = host.hub.guests[gi].craft_grid.clone();
    // rust: let placed = self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: for (k, s) in grid.into_iter().enumerate() {
    // rust: menu.set_slot(env, 1 + k, s);
}
    // rust: menu.place_recipe(env, &id, p.use_max, creative, None)
    // rust: });
    // rust: let g = &mut host.hub.guests[gi];
    // rust: for k in 0..4 {
    // rust: g.craft_grid[k] = menu.slot(1 + k).cloned();
}
    // rust: g.craft_result = menu.slot(0).cloned();
    // rust: host.play.entry(conn).or_default().crafting.inventory = Some(menu);
    // rust: host.hub.send_inventory(gi);
    // rust: placed
    // rust: } else {
    // rust: let Some((window, state, mut menu, pos)) = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|play| play.crafting.table.take_if(|(w, ..)| *w == p.container))
    // rust: else {
    // rust: return;
}
    // rust: let placed = self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: menu.place_recipe(env, &id, p.use_max, creative, None)
    // rust: });
    // rust: host.play.entry(conn).or_default().crafting.table = Some((window, state, menu, pos));
    // rust: self.lan_send_table_content(host, conn);
    // rust: placed
}
    // rust: if placed == PostPlace::Ghost {
    // rust: host.hub.send_ghost_recipe(conn, p.container, &id);
}
}

    /// The guest opened a crafting table (`CraftingTableBlock.getMenuProvider`).
    // rust: pub(super) fn lan_open_crafting(&mut self, host: &mut LanHost, conn: u32, pos: [i32; 3]) {
    // rust: if !self.guest_may_open(host, conn, "minecraft:crafting", Some(pos)) {
    // rust: return;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: let title = horizon_protocol::text::translatable("container.crafting", &[]);
    // rust: let Some(window) = host.hub.open_window(conn, "minecraft:crafting", title) else {
    // rust: return;
}
    // rust: let menu = Box::new(Menu::new(Kind::Crafting));
    // rust: host.play.entry(conn).or_default().crafting.table = Some((window, 0, menu, pos));
    // rust: self.lan_send_table_content(host, conn);
}

    /// A click on the guest's crafting table window; false for other windows.
    // rust: pub(super) fn lan_crafting_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: let Some(play) = host.play.get_mut(&conn) else {
    // rust: return false;
}
    // rust: let Some((window, state, mut menu, pos)) = play
    // rust: .crafting
    // rust: .table
    // rust: .take_if(|(window, ..)| *window == p.container)
    // rust: else {
    // rust: return false;
}
        // handleContainerClick: broadcastFullState only for a click on an old
        // state, else only what the client got wrong. The whole menu after every
        // click would undo the clicks it has predicted since.
    // rust: let mut agreed = false;
        // A table that is no longer valid takes no clicks (handleContainerClick).
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn)
    // rust: && !host.hub.guests[gi].spectator()
    // rust: && self.lan_table_valid(&host.hub.guests[gi], pos)
    // rust: {
    // rust: let mut changed = self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: let before: Vec<_> = (0..menu.slot_count())
    // rust: .map(|s| menu.slot(s).cloned())
    // rust: .collect();
    // rust: let _ = menu.click(env, i32::from(p.slot), i32::from(p.button), input(p.input));
    // rust: (0..menu.slot_count())
    // rust: .filter(|&s| menu.slot(s) != before[s].as_ref())
    // rust: .collect::<Vec<_>>()
    // rust: });
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: let mut result = menu.slot(0).cloned();
    // rust: let vanilla = result.clone();
    // rust: self.native_prepare_item_craft(uuid, &name, Some(pos), &mut result);
    // rust: if result != vanilla && !changed.contains(&0) {
    // rust: changed.push(0);
}
    // rust: let env = self.menu_env();
    // rust: menu.set_slot(&env, 0, result);
    // rust: agreed = p.state == state
    // rust: && host.hub.click_agreed(
    // rust: gi,
    // rust: p,
    // rust: menu.slot_count(),
    // rust: &|s| menu.slot(s).cloned(),
    // rust: &changed,
    // rust: );
    // rust: if agreed {
                // The inventory menu's sync isn't to send what the click settled.
    // rust: let g = &mut host.hub.guests[gi];
    // rust: for &s in changed.iter().filter(|&&s| s >= 10) {
    // rust: g.menu_sent[s - 1] = menu.slot(s).cloned();
}
}
}
    // rust: host.play.entry(conn).or_default().crafting.table = Some((window, state, menu, pos));
    // rust: if !agreed {
    // rust: self.lan_send_table_content(host, conn);
}
    // rust: true
}

    /// `CraftingMenu.stillValid`: the block is still a crafting table and the
    /// guest is within reach of it.
    // rust: pub(super) fn lan_table_valid(&self, g: &Guest, pos: [i32; 3]) -> bool {
    // rust: let name = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name;
    // rust: &**name == "minecraft:crafting_table" && g.within_block_range(pos, 4.0)
}

    /// `ServerPlayer.tick`'s `stillValid`: a guest's crafting table closes
    /// once it is gone or out of reach, giving its grid back.
    // rust: pub(super) fn lan_tables_tick(&mut self, host: &mut LanHost) {
    // rust: let invalid: Vec<(u32, i32)> = host
    // rust: .play
    // rust: .iter()
    // rust: .filter_map(|(c, p)| p.crafting.table.as_ref().map(|t| (*c, t.0, t.3)))
    // rust: .filter(|&(c, _, pos)| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == c)
    // rust: .is_some_and(|g| host.hub.here(g) && !self.lan_table_valid(g, pos))
    // rust: })
    // rust: .map(|(c, window, _)| (c, window))
    // rust: .collect();
    // rust: for (conn, window) in invalid {
    // rust: self.lan_crafting_closed(host, conn, Some(window));
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerClose(play::ContainerClose { container: window }),
    // rust: );
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) {
    // rust: self.guest_carried_back(host, gi);
}
}
}

    /// The whole crafting table menu for the client (`sendAllDataToRemote`).
pub fn lan_send_table_content(self: *Self, host: *mut LanHost, conn: u32) void {
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let Some((window, state, menu, _)) = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|p| p.crafting.table.as_mut())
    // rust: else {
    // rust: return;
}
    // rust: *state = (*state + 1) & 0x7FFF;
    // rust: let (window, state) = (*window, *state);
    // rust: let mut items: Vec<Option<ItemStack>> = (0..10).map(|s| menu.slot(s).cloned()).collect();
    // rust: let g = &host.hub.guests[gi];
    // rust: items.extend((9..36).chain(0..9).map(|i| g.inventory[i].clone()));
    // rust: let carried = g.carried.clone();
    // rust: let items = items.iter().map(|s| host.hub.stack(s)).collect();
    // rust: let carried = host.hub.stack(&carried);
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: window,
    // rust: state,
    // rust: items,
    // rust: carried,
    // rust: }),
    // rust: );
    // rust: host.hub.guests[gi].inventory_told();
}

    /// `AbstractContainerMenu.removed` of a crafting menu: the closed window
    /// (`window`; None closes the table whichever it is, and 0 the inventory
    /// menu) gives its grid back to the inventory, what doesn't fit is
    /// dropped. False when no such window is open.
    /// The open crafting table's own slots (result and grid) before the
    /// player's inventory, if the guest has one open.
    // rust: pub(super) fn lan_crafting_table_own_slots(host: &LanHost, conn: u32) -> Option<usize> {
    // rust: let (_, _, menu, _) = host.play.get(&conn)?.crafting.table.as_ref()?;
    // rust: Some(menu.slot_count() - 36)
}

    // rust: pub(super) fn lan_crafting_closed(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: ) -> bool {
    // rust: self.lan_crafting_removed(host, conn, window, MenuRemoval::Live)
}

    /// `AbstractContainerMenu.clearContainer`: only input slots are removed;
    /// `dropOrPlaceInInventory` chooses drops for a disconnected player.
    // rust: pub(super) fn lan_crafting_removed(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: removal: MenuRemoval,
    // rust: ) -> bool {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return false;
}
    // rust: let crafting = &mut host.play.entry(conn).or_default().crafting;
    // rust: let grid: Vec<ItemStack> = if window == Some(0) {
    // rust: crafting.inventory = None;
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.craft_result = None;
    // rust: g.craft_grid.iter_mut().filter_map(Option::take).collect()
    // rust: } else {
    // rust: match crafting
    // rust: .table
    // rust: .take_if(|(w, ..)| window.is_none_or(|window| *w == window))
    // rust: {
    // rust: Some((_, _, menu, _)) => (1..10).filter_map(|s| menu.slot(s).cloned()).collect(),
    // rust: None => return false,
}
}
    // rust: if !grid.is_empty() {
    // rust: match removal {
    // rust: MenuRemoval::Live => self.lan_place_back(host, gi, grid),
    // rust: MenuRemoval::Disconnected => self.drop_guest_items(host, gi, grid),
}
}
    // rust: true
}

    /// `Inventory.placeItemBackInInventory` of `stacks` for guest `gi`, what
    /// doesn't fit dropped (`clearContainer`).
    // rust: pub(super) fn lan_place_back(&mut self, host: &mut LanHost, gi: usize, stacks: Vec<ItemStack>) {
    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: place_back(menu, env, stacks)
    // rust: });
}

    /// A guest left: what their crafting grids and workstation held goes back into their
    /// inventory before it is saved (dropped where they stood if full).
    // rust: pub(super) fn lan_crafting_left(&mut self, host: &mut LanHost, g: &mut Guest) {
        // The guest's play state stays: their statistics are awarded and saved
        // after this (`HostEvent::Left`), which removes it.
    // rust: let play = host.play.get_mut(&g.conn);
    // rust: let mut grid: Vec<ItemStack> = g.craft_grid.iter_mut().filter_map(Option::take).collect();
    // rust: g.craft_result = None;
    // rust: if let Some(play) = play {
    // rust: if let Some((_, _, menu, _)) = play.crafting.table.take() {
    // rust: grid.extend((1..10).filter_map(|s| menu.slot(s).cloned()));
}
            // A workstation's inputs too.
    // rust: if let Some(station) = play.station.take() {
    // rust: grid.extend(super::lan_stations::station_inputs(&station));
}
}
    // rust: if grid.is_empty() {
    // rust: return;
}
    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: load_player(&mut menu, g);
    // rust: place_back(&mut menu, &self.menu_env(), grid);
    // rust: let dropped = std::mem::take(&mut menu.dropped);
    // rust: store_player(&mut menu, g);
    // rust: for stack in dropped {
    // rust: self.spawn_item(stack, g.position, [0.0, 0.1, 0.0], 40);
}
}
}
