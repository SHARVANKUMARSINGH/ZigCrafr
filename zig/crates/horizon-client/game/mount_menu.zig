//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mount_menu
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The horse inventory (`HorseInventoryMenu`, `HorseInventoryScreen`): the
//! saddle and body armour slots (a llama's carpet, a nautilus's armour), the
//! chest of donkeys, mules and llamas and the mount drawn following the
//! cursor. A nautilus has the same two slots and no chest
//! (`NautilusInventoryMenu`). It opens with E while riding a tamed mount or
//! with shift + use on a tamed one. On a
//! server the screen shows the server's menu (`ClientboundMountScreenOpenPacket`)
//! and its clicks go out as container clicks; a server's players get theirs
//! from game/lan_mount_menu.rs.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: mobs::{Mob, Species, equine, llama, nautilus},
}

/// Menu slot ids: the saddle, the body armour and the chest from 710.
    // rust: pub(super) const SADDLE: usize = 700;
    // rust: pub(super) const ARMOR: usize = 701;
    // rust: pub(super) const CHEST: usize = 710;
/// `AbstractChestedHorse.INV_CHEST_COUNT` and `getInventoryColumns`.
pub const CHEST_SIZE: usize = 15;
pub const COLUMNS: usize = 5;

/// `AbstractHorse.getInventoryColumns`: five for a donkey's or mule's chest,
/// a llama's strength for its chest, else none.
    // rust: pub(super) fn mount_columns(m: &Mob) -> usize {
    // rust: let species = m.species();
    // rust: if llama::is_llama(species) {
    // rust: llama::inventory_columns(m).clamp(0, 5) as usize
    // rust: } else if m.extra.chested && matches!(species, Species::Donkey | Species::Mule) {
    // rust: COLUMNS
    // rust: } else {
    // rust: 0
}
}
/// Whether the mount has a horse inventory (`AbstractHorse`, `AbstractNautilus`).
    // rust: pub(super) fn has_mount_menu(species: Species) -> bool {
    // rust: equine::is_equine(species) || llama::is_llama(species) || nautilus::is_nautilus(species)
}
/// The saddle slot is active (`canUseSlot(SADDLE)` and `CAN_EQUIP_SADDLE`):
/// not on llamas.
pub fn shows_saddle(species: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !llama::is_llama(species)
}
/// The body slot is active: horse armour, a llama's carpet, or nautilus armour.
pub fn shows_body(species: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: can_wear_horse_armor(species) || llama::is_llama(species) || nautilus::is_nautilus(species)
}

/// The open mount menu: copies of the mount's slots, written back on every change.
    // rust: pub(super) struct MountMenu {
    // rust: open: Option<Open>,
}
    // rust: impl MountMenu {
    /// The mount whose menu is open.
    // rust: pub(super) fn opened_mob(&self) -> Option<u32> {
    // rust: self.open.as_ref().map(|o| o.mob)
}
}
pub const Open = struct {
    mob: u32,
    species: Species,
    columns: usize,
    saddle: ?ItemStack,
    armor: ?ItemStack,
    items: std.ArrayList(?ItemStack),
    /// `shouldRenderSaddleSlot` / `shouldRenderArmorSlot`.
    show_saddle: bool,
    show_armor: bool,
};

/// `EntityTypeTags.CAN_WEAR_HORSE_ARMOR`.
pub fn can_wear_horse_armor(species: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(species, Species::Horse | Species::ZombieHorse)
}
/// Whether `item` fits the body slot of the species (`isEquippableInSlot`).
pub fn body_armor_fits(species: Species, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if llama::is_llama(species) {
    // rust: return item.ends_with("_carpet");
}
    // EntityTypeTags.CAN_WEAR_NAUTILUS_ARMOR: the nautilus armours.
    // rust: if nautilus::is_nautilus(species) {
    // rust: return item.ends_with("_nautilus_armor");
}
    // rust: can_wear_horse_armor(species) && item.ends_with("_horse_armor")
}

    // rust: impl Game<'_> {
    /// Whether the mount menu is the open screen.
    // rust: pub(super) fn mount_active(&self) -> bool {
    // rust: self.screen == Screen::Inventory && self.mount_menu.open.is_some()
}
pub fn mount_mob_index(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mobs.iter().position(|m| m.id == id)
}
    /// `AbstractHorse.openCustomInventoryScreen` for a tamed adult mount.
    // rust: pub(super) fn open_mount_menu(&mut self, index: usize) {
    // rust: let m = &self.mobs[index];
    // rust: let species = m.species();
    // rust: if !has_mount_menu(species) {
    // rust: return;
}
    // rust: let mut items = m.extra.items.clone();
    // rust: items.resize(CHEST_SIZE, None);
    // rust: let show_armor = shows_body(species);
    // rust: self.mount_menu.open = Some(Open {
    // rust: mob: m.id,
    // rust: species,
    // rust: columns: mount_columns(m),
    // rust: saddle: m.saddle_item(),
    // rust: armor: m
    // rust: .extra
    // rust: .head
    // rust: .as_deref()
    // rust: .filter(|_| show_armor)
    // rust: .map(|i| ItemStack::new(i, 1)),
    // rust: items,
    // rust: show_saddle: shows_saddle(species),
    // rust: show_armor,
    // rust: });
    // rust: self.show_mount_menu();
}
    /// `ClientPacketListener.handleMountScreenOpen`: a server's horse
    /// inventory over mount `entity`, its slots to come in the menu's content.
    // rust: pub(super) fn open_remote_mount_menu(&mut self, entity: u32, columns: usize) -> bool {
    // rust: let Some(species) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == entity)
    // rust: .map(Mob::species)
    // rust: .filter(|s| has_mount_menu(*s))
    // rust: else {
    // rust: return false;
}
    // rust: self.mount_menu.open = Some(Open {
    // rust: mob: entity,
    // rust: species,
    // rust: columns: columns.min(COLUMNS),
    // rust: saddle: None,
    // rust: armor: None,
    // rust: items: vec![None; CHEST_SIZE],
    // rust: show_saddle: shows_saddle(species),
    // rust: show_armor: shows_body(species),
    // rust: });
    // rust: self.show_mount_menu();
    // rust: true
}
pub fn show_mount_menu(self: *Self) void {
}
    // rust: if self.remote.is_none() && self.lan_acting.is_none() {
    // rust: self.carried = None;
}
    // rust: self.station = None;
    // rust: self.container = None;
    // rust: self.craft_size = 2;
    // rust: self.screen = Screen::Inventory;
    // rust: self.capture(false);
}
    /// E while riding a tamed mount opens its inventory instead of the player's.
    // rust: pub(super) fn open_ridden_mount_menu(&mut self) -> bool {
    // rust: let Some(id) = self.riding else {
    // rust: return false;
}
    // rust: let Some(index) = self.mount_mob_index(id) else {
    // rust: return false;
}
    // rust: let m = &self.mobs[index];
    // rust: if !has_mount_menu(m.species()) || !m.extra.tame || !m.alive() {
    // rust: return false;
}
    // rust: self.open_mount_menu(index);
    // rust: true
}
    /// Riding a mount that has a horse inventory (`HasCustomInventoryScreen`).
    // rust: pub(super) fn riding_mount_with_menu(&self) -> bool {
    // rust: self.riding
    // rust: .and_then(|id| self.mount_mob_index(id))
    // rust: .is_some_and(|i| has_mount_menu(self.mobs[i].species()))
}
    /// A server closed its window: the screen's copy goes.
    // rust: pub(super) fn mount_menu_reset(&mut self) {
    // rust: self.mount_menu.open = None;
}
    /// The entity type of the open mount menu's mount (`minecraft:horse`).
    // rust: pub(super) fn mount_menu_entity(&self) -> Option<String> {
    // rust: let open = self.mount_menu.open.as_ref()?;
    // rust: let m = self.mobs.iter().find(|m| m.id == open.mob)?;
    // rust: Some(m.kind.id.to_string())
}
    /// The chest columns of the open mount menu (the server's window's).
    // rust: pub(super) fn mount_menu_columns(&self) -> Option<usize> {
    // rust: self.mount_menu.open.as_ref().map(|o| o.columns)
}
    /// The menu ends when the mount dies or is more than 4 blocks away
    /// (`AbstractMountInventoryMenu.stillValid`).
    // rust: pub(super) fn tick_mount_menu(&mut self) {
        // A server's menu ends when the server closes it.
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let Some(open) = self.mount_menu.open.as_ref() else {
    // rust: return;
}
    // rust: let valid = self.mount_mob_index(open.mob).is_some_and(|i| {
    // rust: let m = &self.mobs[i];
    // rust: let c = m.center();
    // rust: m.alive()
    // rust: && self.eye_position().is_some_and(|e| {
    // rust: let d = (e[0] - c[0]).powi(2) + (e[1] - c[1]).powi(2) + (e[2] - c[2]).powi(2);
    // rust: d <= 16.0 + 4.0
    // rust: })
    // rust: });
    // rust: if !valid {
    // rust: self.close_container();
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    /// Closing the screen keeps what is in the slots on the mount.
    // rust: pub(super) fn mount_closed(&mut self) {
    // rust: self.mount_sync();
    // rust: self.mount_menu.open = None;
}
    /// Writes the menu slots to the mount, with the equip sounds. A
    /// server's menu is the server's to write.
pub fn mount_sync(self: *Self) void {
}
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let Some(open) = self.mount_menu.open.as_ref() else {
    // rust: return;
}
    // rust: let Some(index) = self.mount_mob_index(open.mob) else {
    // rust: return;
}
    // rust: let (saddle, armor) = (open.saddle.clone(), open.armor.clone());
    // rust: let body = open.show_armor.then_some(armor);
    // rust: let items = open.items.clone();
    // rust: self.mount_store(index, saddle, body, items);
}
    /// The slots of mount `index` as its menu shows them: the saddle, the
    /// body item (None when the slot isn't active), the chest.
    // rust: pub(super) fn mount_contents(
    // rust: &self,
    // rust: index: usize,
    // rust: ) -> (
    // rust: Option<ItemStack>,
    // rust: Option<Option<ItemStack>>,
    // rust: Vec<Option<ItemStack>>,
    // rust: ) {
    // rust: let m = &self.mobs[index];
    // rust: let species = m.species();
    // rust: let body =
    // rust: shows_body(species).then(|| m.extra.body.as_deref().map(|i| ItemStack::new(i, 1)));
    // rust: let mut items = m.extra.items.clone();
    // rust: items.resize(mount_columns(m) * 3, None);
    // rust: (m.saddle_item(), body, items)
}
    /// The menu's slots back on mount `index` (`body` None: not its slot),
    /// with the equip sound of what was put on (`Equippable.equipSound`).
    // rust: pub(super) fn mount_store(
    // rust: &mut self,
    // rust: index: usize,
    // rust: saddle: Option<ItemStack>,
    // rust: body: Option<Option<ItemStack>>,
    // rust: items: Vec<Option<ItemStack>>,
    // rust: ) {
    // rust: let m = &self.mobs[index];
    // rust: let at = m.center();
    // rust: let saddle_put_on = saddle.is_some() && !m.extra.saddled;
    // rust: let put_on = if saddle_put_on {
    // rust: saddle.as_ref()
    // rust: } else {
    // rust: body.as_ref()
    // rust: .and_then(Option::as_ref)
    // rust: .filter(|_| m.extra.body.is_none())
}
    // rust: let sound = if saddle_put_on && nautilus::is_nautilus(m.species()) {
            // AbstractNautilus.getEquipSound: its own saddle sounds.
    // rust: Some(format!("minecraft:{}", nautilus::saddle_sound(m)))
    // rust: } else {
    // rust: put_on.map(|s| {
    // rust: self.res
    // rust: .items()
    // rust: .get(&s.item)
    // rust: .and_then(|i| i.equip_sound.clone())
    // rust: .unwrap_or_else(|| "minecraft:item.armor.equip_generic".into())
    // rust: })
}
    // rust: let m = &mut self.mobs[index];
    // rust: m.set_saddle(saddle);
    // rust: if let Some(body) = body {
    // rust: m.extra.body = body.map(|a| a.item);
}
    // rust: let mut items = items;
    // rust: let keep = m.extra.items.len().max(CHEST_SIZE);
    // rust: items.resize(keep, None);
    // rust: m.extra.items = items;
    // rust: let (x, z) = (at[0].floor() as i32 >> 4, at[2].floor() as i32 >> 4);
    // rust: self.world.modified.insert((x, z));
    // rust: if let Some(sound) = sound {
    // rust: self.audio.play(&sound, Some(at), 0.5, 1.0);
}
}
    // rust: pub(super) fn mount_slots(&self) -> Option<Vec<usize>> {
    // rust: let open = self
    // rust: .mount_menu
    // rust: .open
    // rust: .as_ref()
    // rust: .filter(|_| self.mount_active())?;
    // rust: let mut v: Vec<usize> = (0..36).collect();
    // rust: if open.show_saddle {
    // rust: v.push(SADDLE);
}
    // rust: if open.show_armor {
    // rust: v.push(ARMOR);
}
    // rust: v.extend((0..open.columns * 3).map(|i| CHEST + i));
    // rust: Some(v)
}
    /// How many slots `mount_slots` lists, counted without building it
    /// (`Game::slot_count` asks every frame).
    // rust: pub(super) fn mount_slot_count(&self) -> Option<usize> {
    // rust: let open = self
    // rust: .mount_menu
    // rust: .open
    // rust: .as_ref()
    // rust: .filter(|_| self.mount_active())?;
    // rust: Some(36 + usize::from(open.show_saddle) + usize::from(open.show_armor) + open.columns * 3)
}
    // rust: pub(super) fn mount_slot_position(&self, i: usize) -> Option<(f32, f32)> {
    // rust: let open = self
    // rust: .mount_menu
    // rust: .open
    // rust: .as_ref()
    // rust: .filter(|_| self.mount_active())?;
    // rust: match i {
    // rust: SADDLE => Some((8.0, 18.0)),
    // rust: ARMOR => Some((8.0, 36.0)),
    // rust: _ if i >= CHEST => {
    // rust: let n = i - CHEST;
    // rust: (n < open.columns * 3).then(|| {
    // rust: (
    // rust: 80.0 + (n % open.columns) as f32 * 18.0,
    // rust: 18.0 + (n / open.columns) as f32 * 18.0,
    // rust: )
    // rust: })
}
    // rust: _ => None,
}
}
    // rust: pub(super) fn mount_slot_mut(&mut self, i: usize) -> &mut Option<ItemStack> {
    // rust: match self.mount_menu.open.as_mut() {
    // rust: Some(open) if i == SADDLE => &mut open.saddle,
    // rust: Some(open) if i == ARMOR => &mut open.armor,
    // rust: Some(open) if i >= CHEST && i - CHEST < CHEST_SIZE => &mut open.items[i - CHEST],
    // rust: _ => &mut self.scratch_slot,
}
}
    /// `ArmorSlot.mayPlace` and the stack limits of the mount's slots.
    // rust: pub(super) fn mount_slot_rules(&self, slot: usize, stack: &ItemStack) -> (bool, u32) {
    // rust: let Some(open) = self.mount_menu.open.as_ref() else {
    // rust: return (false, 64);
}
    // rust: match slot {
    // rust: SADDLE => (&*stack.item == "minecraft:saddle", 1),
    // rust: ARMOR => (body_armor_fits(open.species, &stack.item), 1),
    // rust: _ => (true, 64),
}
}
    /// A click in the mount menu before the generic handling.
    // rust: pub(super) fn mount_click(&mut self, right: bool) -> bool {
        // A server's menu: the click goes out like any container click.
    // rust: if !self.mount_active() || self.remote.is_some() {
    // rust: return false;
}
    // rust: let Some(r) = self.renderer.as_ref() else {
    // rust: return true;
}
    // rust: let batch = HudBatch::new([r.config.width, r.config.height]);
    // rust: let Some(slot) = self.slot_at(&batch, self.cursor.0, self.cursor.1) else {
    // rust: return true;
}
    // rust: let shift = self.has_shift_down();
    // rust: if shift {
    // rust: self.mount_quick_move(slot);
    // rust: } else if slot >= SADDLE {
    // rust: self.click_filtered(slot, right);
    // rust: } else {
    // rust: return false;
}
    // rust: self.mount_sync();
    // rust: true
}
    /// The inventory slot ids in menu order.
pub fn mount_player_slots() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (9..36).chain(0..9).collect()
}
    /// `AbstractMountInventoryMenu.quickMoveStack`.
pub fn mount_quick_move(self: *Self, slot: usize) void {
}
    // rust: let Some(open) = self.mount_menu.open.as_ref() else {
    // rust: return;
}
    // rust: let (columns, show_saddle, show_armor) = (open.columns, open.show_saddle, open.show_armor);
    // rust: let Some(mut stack) = self.slot_mut(slot).take() else {
    // rust: return;
}
    // rust: if slot >= SADDLE {
    // rust: let player = Self::mount_player_slots();
    // rust: self.move_to(&mut stack, &player, true);
    // rust: } else {
    // rust: let armor_free = self.mount_slot_mut(ARMOR).is_none();
    // rust: let saddle_free = self.mount_slot_mut(SADDLE).is_none();
    // rust: let armor_ok = show_armor && self.mount_slot_rules(ARMOR, &stack).0 && armor_free;
    // rust: let saddle_ok = show_saddle && self.mount_slot_rules(SADDLE, &stack).0 && saddle_free;
    // rust: if armor_ok {
    // rust: self.move_to(&mut stack, &[ARMOR], false);
    // rust: } else if saddle_ok {
    // rust: self.move_to(&mut stack, &[SADDLE], false);
    // rust: } else {
    // rust: let chest: Vec<usize> = (0..columns * 3).map(|i| CHEST + i).collect();
    // rust: let moved = columns > 0 && self.move_to(&mut stack, &chest, false);
    // rust: if !moved {
                    // Between the hotbar and the main inventory.
    // rust: let other: Vec<usize> = if slot < 9 {
    // rust: (9..36).collect()
    // rust: } else {
    // rust: (0..9).collect()
}
    // rust: self.move_to(&mut stack, &other, false);
}
}
}
    // rust: if stack.count > 0 {
    // rust: *self.slot_mut(slot) = Some(stack);
}
}
    /// `HorseInventoryScreen`'s background, slot frames and the mount.
    // rust: pub(super) fn draw_mount_background(&self, batch: &mut HudBatch, ox: f32, oy: f32) {
    // rust: let Some(open) = self.mount_menu.open.as_ref() else {
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
        // NautilusInventoryScreen draws its own background.
    // rust: let background = if nautilus::is_nautilus(open.species) {
    // rust: "gui/container/nautilus"
    // rust: } else {
    // rust: "gui/container/horse"
}
    // rust: batch.sprite_region(atlas, background, [ox, oy, 176.0, 166.0], 256.0, 256.0);
    // rust: if open.columns > 0 {
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/sprites/container/horse/chest_slots",
    // rust: [ox + 79.0, oy + 17.0, open.columns as f32 * 18.0, 54.0],
    // rust: 90.0,
    // rust: 54.0,
    // rust: );
}
    // rust: if open.show_saddle {
    // rust: batch.sprite(atlas, "gui/sprites/container/slot", ox + 7.0, oy + 17.0);
    // rust: if open.saddle.is_none() {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/slot/saddle",
    // rust: ox + 8.0,
    // rust: oy + 18.0,
    // rust: );
}
}
    // rust: if open.show_armor {
    // rust: batch.sprite(atlas, "gui/sprites/container/slot", ox + 7.0, oy + 35.0);
    // rust: if open.armor.is_none() {
    // rust: let sprite = if llama::is_llama(open.species) {
    // rust: "gui/sprites/container/slot/llama_armor"
    // rust: } else if nautilus::is_nautilus(open.species) {
    // rust: "gui/sprites/container/slot/nautilus_armor_inventory"
    // rust: } else {
    // rust: "gui/sprites/container/slot/horse_armor"
}
    // rust: batch.sprite(atlas, sprite, ox + 8.0, oy + 36.0);
}
}
    // rust: let grey = rgba(64, 64, 64, 255);
    // rust: let title = match self.mobs.iter().find(|m| m.id == open.mob) {
    // rust: Some(m) => m.custom_name.clone().unwrap_or_else(|| {
    // rust: let key = format!(
    // rust: "entity.minecraft.{}",
    // rust: m.kind.id.trim_start_matches("minecraft:")
    // rust: );
    // rust: self.translate(&key, &key)
    // rust: }),
    // rust: None => String::new(),
}
    // rust: super::screen_info::name_container(|| title.clone());
    // rust: batch.text(atlas, &title, ox + 8.0, oy + 6.0, grey, false);
    // rust: let inventory = self.translate("container.inventory", "Inventory");
    // rust: batch.text(atlas, &inventory, ox + 8.0, oy + 72.0, grey, false);
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == open.mob) {
    // rust: self.draw_mob_preview(
    // rust: batch,
    // rust: m,
    // rust: ox + 26.0,
    // rust: oy + 18.0,
    // rust: ox + 78.0,
    // rust: oy + 70.0,
    // rust: 17.0,
    // rust: 0.25,
    // rust: );
}
}
    /// `extractEntityInInventoryFollowsMouse` for a mob: depth-sorted,
    /// back-face-culled quads turned toward the cursor.
    // rust: fn draw_mob_preview(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: mob: &Mob,
    // rust: x0: f32,
    // rust: y0: f32,
    // rust: x1: f32,
    // rust: y1: f32,
    // rust: size: f32,
    // rust: offset_y: f32,
    // rust: ) {
    // rust: let (cx, cy) = ((x0 + x1) / 2.0, (y0 + y1) / 2.0);
    // rust: let x_angle = ((cx - self.cursor.0) / 40.0).atan();
    // rust: let y_angle = ((cy - self.cursor.1) / 40.0).atan();
    // rust: let mut m = mob.clone();
    // rust: m.previous = m.position;
    // rust: m.body_yaw = 180.0 + x_angle * 20.0;
    // rust: m.previous_body_yaw = m.body_yaw;
    // rust: m.head_yaw = m.body_yaw + x_angle * 20.0;
    // rust: m.previous_head_yaw = m.head_yaw;
    // rust: m.head_pitch = -y_angle * 20.0;
    // rust: m.previous_head_pitch = m.head_pitch;
    // rust: m.hurt_time = 0;
    // rust: m.death_time = 0;
    // rust: let camera = glam::DVec3::new(m.position.x, m.position.y, m.position.z);
    // rust: let atlas = &self.gui.atlas;
    // rust: let lookup = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
    // rust: let mut verts = Vec::new();
        // A screen preview: custom entity model animations see is_in_gui = 1.
    // rust: horizon_client::mobs::cem_anim::in_gui(|| {
    // rust: horizon_client::mobs::render::render_with(
    // rust: &m,
    // rust: 1.0,
    // rust: camera,
    // rust: &lookup,
    // rust: 240 | 240 << 8,
    // rust: self.res.mob_data(),
    // rust: &[],
    // rust: &mut verts,
    // rust: );
    // rust: });
    // rust: let height = m.kind.height as f32;
    // rust: let gui = glam::Mat4::from_translation(glam::Vec3::new(cx, cy, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(size, size, -size))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, height / 2.0 + offset_y, 0.0))
    // rust: * glam::Mat4::from_rotation_z(std::f32::consts::PI)
    // rust: * glam::Mat4::from_rotation_x((y_angle * 20.0).to_radians());
    // rust: let mut quads: Vec<(f32, [[f32; 2]; 4], [[f32; 2]; 4], u32)> = Vec::new();
    // rust: for q in verts.as_chunks::<4>().0 {
    // rust: let p: [glam::Vec3; 4] =
    // rust: std::array::from_fn(|i| gui.transform_point3(glam::Vec3::from_array(q[i].pos)));
    // rust: let n = (p[1] - p[0]).cross(p[2] - p[0]);
    // rust: if n.z >= 0.0 {
    // rust: continue;
}
    // rust: let n = n.normalize_or_zero();
    // rust: let shade = (0.55 + 0.45 * -n.z - 0.15 * n.y).clamp(0.4, 1.0);
    // rust: let c = q[0].color;
    // rust: let ch = |s: u32| ((((c >> s) & 255) as f32 * shade) as u32) << s;
    // rust: let color = (c & 0xFF00_0000) | ch(0) | ch(8) | ch(16);
    // rust: let depth = p.iter().map(|v| v.z).sum::<f32>() / 4.0;
    // rust: quads.push((
    // rust: depth,
    // rust: p.map(|v| [v.x, v.y]),
    // rust: std::array::from_fn(|i| q[i].uv),
    // rust: color,
    // rust: ));
}
    // rust: quads.sort_by(|a, b| a.0.total_cmp(&b.0));
    // rust: let start = batch.vertices.len();
    // rust: for (_, p, uv, color) in quads {
    // rust: batch.quad(p, uv, color);
}
    // rust: batch.clip_since(start, x0, y0, x1, y1);
}
}

    // rust: mod tests {
//     use super::*;

pub fn only_horses_wear_horse_armour() void {
}
    // rust: assert!(body_armor_fits(
    // rust: Species::Horse,
    // rust: "minecraft:iron_horse_armor"
    // rust: ));
    // rust: assert!(body_armor_fits(
    // rust: Species::ZombieHorse,
    // rust: "minecraft:diamond_horse_armor"
    // rust: ));
    // rust: assert!(!body_armor_fits(
    // rust: Species::Donkey,
    // rust: "minecraft:iron_horse_armor"
    // rust: ));
    // rust: assert!(!body_armor_fits(
    // rust: Species::Horse,
    // rust: "minecraft:iron_chestplate"
    // rust: ));
}

pub fn llamas_wear_carpets_and_no_saddle() void {
}
    // rust: assert!(body_armor_fits(Species::Llama, "minecraft:red_carpet"));
    // rust: assert!(!body_armor_fits(
    // rust: Species::Llama,
    // rust: "minecraft:iron_horse_armor"
    // rust: ));
    // rust: assert!(shows_body(Species::TraderLlama));
    // rust: assert!(!shows_saddle(Species::Llama));
    // rust: assert!(shows_saddle(Species::Donkey) && !shows_body(Species::Donkey));
}
}
