//! Transpiled from Horizon Rust crate
package horizon_client_native_inventories

import "core:fmt"
import "core:mem"
import "core:math"

// Another player's inventories for server mods (API 132):
// what an operator's `/invsee` or `/endersee` needs. A player online is read
// and changed live; a player who isn't on the server is read from, and
// written to, their file (`players/data/<uuid>.dat`, as the server saves
// it), never while they are logging in, dead or swapped in. One stack moves
// at a time, checked against what the mod last showed, so a menu built on
// these never copies or loses an item. Server menus are in `native_menus.rs`;
// maps a mod draws in `native_send_map` below.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: lan::{guest::Guest, playerdata},
    // rust: save::{Level, read_dat, write_dat},
}
// use std::path::Path;

// Which of a player's inventories (`native_inventory`).
    // rust: pub(crate) enum NativeInventoryKind {
    // 41 slots: 0..9 the hotbar, 9..36 the rest (as `Inventory`), 36..40
    // the armour (feet, legs, chest, head), 40 the off hand.
    // rust: Player,
    // The ender chest's 27 slots.
    // rust: Ender,
}

    // rust: impl NativeInventoryKind {
    // rust: pub(crate) fn size(self) -> usize {
    // rust: match self {
    // rust: Self::Player => 41,
    // rust: Self::Ender => 27,
}
}
}

// A player's inventory as `native_inventory` read it: its slots, and
// whether it is the live one (the player is on the server) or their file's.
    // rust: pub(crate) struct NativeInventory {
    // rust: pub slots: Vec<Option<ItemStack>>,
    // rust: pub online: bool,
}

// `Level.inventory`'s slot numbers (the file's) for our 41.
file_slot :: proc(i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match i {
    // rust: 0..36 => Some(i as u8),
    // rust: 36..40 => Some(100 + (i - 36) as u8),
    // rust: 40 => Some(150),
    // rust: _ => None,
}
}

guest_slots :: proc(g: ^Guest, kind: NativeInventoryKind) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: NativeInventoryKind::Player => {
    // rust: let mut s = g.inventory.clone();
    // rust: s.resize(36, None);
            // `armor` is head first.
    // rust: s.extend([3, 2, 1, 0].map(|i| g.armor[i].clone()));
    // rust: s.push(g.offhand.clone());
    // rust: s
}
    // rust: NativeInventoryKind::Ender => {
    // rust: let mut s = g.ender_items.clone();
    // rust: s.resize(27, None);
    // rust: s
}
}
}

set_guest_slots :: proc(g: ^Guest, kind: NativeInventoryKind, mut s: [dynamic]Maybe(ItemStack)) {
}
    // rust: match kind {
    // rust: NativeInventoryKind::Player => {
    // rust: g.offhand = s.pop().flatten();
    // rust: for (k, i) in [3, 2, 1, 0].into_iter().enumerate() {
    // rust: g.armor[i] = s[36 + k].take();
}
    // rust: s.truncate(36);
    // rust: g.inventory = s;
}
    // rust: NativeInventoryKind::Ender => g.ender_items = s,
}
}

level_slots :: proc(level: ^Level, kind: NativeInventoryKind) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: NativeInventoryKind::Player => {
    // rust: let mut s = vec![None; 41];
    // rust: for (slot, item, count, damage) in &level.inventory {
    // rust: if let Some(i) = (0..41).find(|&i| file_slot(i) == Some(*slot)) {
    // rust: s[i] = Some(ItemStack {
    // rust: item: item.as_str().into(),
    // rust: count: (*count).max(1),
    // rust: damage: *damage,
    // rust: extra: level.inventory_components.get(slot).cloned(),
    // rust: });
}
}
    // rust: s
}
    // rust: NativeInventoryKind::Ender => {
    // rust: let mut s = level.ender_items.clone();
    // rust: s.resize(27, None);
    // rust: s
}
}
}

set_level_slots :: proc(level: ^Level, kind: NativeInventoryKind, s: [dynamic]Maybe(ItemStack)) {
}
    // rust: match kind {
    // rust: NativeInventoryKind::Player => {
    // rust: level.inventory.clear();
    // rust: level.inventory_components.clear();
    // rust: for (i, stack) in s.into_iter().enumerate() {
    // rust: if let (Some(slot), Some(st)) = (file_slot(i), stack) {
    // rust: level
    // rust: .inventory
    // rust: .push((slot, st.item.to_string(), st.count, st.damage));
    // rust: if let Some(extra) = st.extra {
    // rust: level.inventory_components.insert(slot, extra);
}
}
}
}
    // rust: NativeInventoryKind::Ender => level.ender_items = s,
}
}

// A saved player's file read as `playerdata::load` reads it, kept whole
// (`player_extra`) so writing it back changes only what was edited.
read_level :: proc(world: ^Path, uuid: u128) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let file = playerdata::path(world, uuid);
    // rust: let tag = read_dat(&file)?;
    // rust: let mut level = Level {
    // rust: health: 20.0,
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: ..Level::default()
}
    // rust: level.read_player(&tag);
    // rust: level.player_extra = Some(tag);
    // rust: Some(level)
}

// Where one side of a move lives while it is made.
Side :: enum {
    // A guest's index in the hub.
    Live(usize),
    // A player's file, read.
    File(Box<Level>),
}

// Another player's inventories, for server mods. API 132.
    // rust: impl Game<'_> {
    // The player `uuid`'s inventory `kind`: the live one when they are on
    // the server, else their file's. Err while they are logging in, dead,
    // swapped in (inside a player's hook: call from `native_menu_clicked` or
    // `native_server_tick`), or when they have never played here.
    // rust: pub(super) fn native_inventory(
    // rust: &self,
    // rust: uuid: u128,
    // rust: kind: NativeInventoryKind,
    // rust: ) -> Result<NativeInventory, String> {
    // rust: match self.native_inventory_side(uuid)? {
    // rust: Side::Live(i) => {
    // rust: let host = self.lan.as_ref().expect("live");
    // rust: Ok(NativeInventory {
    // rust: slots: guest_slots(&host.hub.guests[i], kind),
    // rust: online: true,
    // rust: })
}
    // rust: Side::File(level) => Ok(NativeInventory {
    // rust: slots: level_slots(&level, kind),
    // rust: online: false,
    // rust: }),
}
}

native_inventory_side :: proc(self: ^Self, uuid: u128) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.lan_acting.is_some() {
    // rust: return Err("inside a player's turn".into());
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return Err("no server".into());
}
    // rust: if let Some(i) = host.hub.guests.iter().position(|g| g.uuid == uuid) {
    // rust: let g = &host.hub.guests[i];
    // rust: return if !g.placed {
    // rust: Err("the player is logging in".into())
    // rust: } else if g.dead {
    // rust: Err("the player is dead".into())
    // rust: } else {
    // rust: Ok(Side::Live(i))
}
}
    // rust: if self.world_root.as_os_str().is_empty() {
    // rust: return Err("no world".into());
}
    // rust: read_level(&self.world_root, uuid)
    // rust: .map(|l| Side::File(Box::new(l)))
    // rust: .ok_or_else(|| "no saved player".into())
}

    // Moves the stack in slot `from_slot` of `from`'s inventory `from_kind`,
    // which must still be exactly `expected`, into `to`'s inventory
    // `to_kind` where it fits whole (onto equal stacks first, then empty
    // slots; for `Player`, the 36 main slots, never armour or off hand), or
    // nothing moves and the Err says why. Each side is live or its file
    // (`native_inventory`); at most one may be a file, which is written
    // before the live side changes. Their screens follow with the tick's
    // sync.
    // rust: pub(super) fn native_move_stack(
    // rust: &mut self,
    // rust: from: (u128, NativeInventoryKind, usize),
    // rust: expected: &ItemStack,
    // rust: to: (u128, NativeInventoryKind),
    // rust: ) -> Result<(), String> {
    // rust: let (from_uuid, from_kind, from_slot) = from;
    // rust: let (to_uuid, to_kind) = to;
    // rust: if from_uuid == to_uuid && from_kind == to_kind {
    // rust: return Err("the same inventory".into());
}
        // A just-disconnected player can already be absent from the hub.
        // Drain before reading or replacing their offline file.
    // rust: let _ = self.finish_player_autosaves(true);
    // rust: let a = self.native_inventory_side(from_uuid)?;
    // rust: let b = if from_uuid == to_uuid {
    // rust: None
    // rust: } else {
    // rust: Some(self.native_inventory_side(to_uuid)?)
}
    // rust: if matches!(a, Side::File(_)) && matches!(b, Some(Side::File(_))) {
    // rust: return Err("both players are away".into());
}
    // rust: let items = self.res.items();
    // rust: let max = |s: &ItemStack| items.get(&s.item).map_or(64, |i| i.max_stack);
    // rust: let read = |side: &Side, kind| match side {
    // rust: Side::Live(i) => guest_slots(&self.lan.as_ref().expect("live").hub.guests[*i], kind),
    // rust: Side::File(level) => level_slots(level, kind),
}
    // rust: let mut src = read(&a, from_kind);
    // rust: let mut dst = read(b.as_ref().unwrap_or(&a), to_kind);
    // rust: match src.get_mut(from_slot) {
    // rust: Some(s) if s.as_ref() == Some(expected) => *s = None,
    // rust: _ => return Err("that stack changed".into()),
}
    // rust: let room = match to_kind {
    // rust: NativeInventoryKind::Player => 36,
    // rust: NativeInventoryKind::Ender => 27,
}
    // rust: if !super::native_menus::fit(&mut dst[..room], std::slice::from_ref(expected), &max) {
    // rust: return Err("no room".into());
}
        // The file first: when it can't be written, nothing has moved.
    // rust: let world = self.world_root.clone();
    // rust: let write =
    // rust: |side: Side, kind, slots: Vec<Option<ItemStack>>, uuid| -> Result<Side, String> {
    // rust: if let Side::File(mut level) = side {
    // rust: set_level_slots(&mut level, kind, slots);
    // rust: write_dat(&playerdata::path(&world, uuid), level.player_tag())
    // rust: .map_err(|e| format!("the player's file: {e}"))?;
    // rust: return Ok(Side::File(level));
}
    // rust: Ok(side)
}
    // rust: let (a, b) = match b {
    // rust: None => {
                // Two inventories of one player: their file or live.
    // rust: let mut both = a;
    // rust: if let Side::File(level) = &mut both {
    // rust: set_level_slots(level, from_kind, src.clone());
}
    // rust: let both = write(both, to_kind, dst.clone(), from_uuid)?;
    // rust: (both, None)
}
    // rust: Some(b) if matches!(b, Side::File(_)) => {
    // rust: let b = write(b, to_kind, dst.clone(), to_uuid)?;
    // rust: (a, Some(b))
}
    // rust: Some(b) => {
    // rust: let a = write(a, from_kind, src.clone(), from_uuid)?;
    // rust: (a, Some(b))
}
}
    // rust: let host = self.lan.as_mut().expect("checked");
    // rust: if let Side::Live(i) = a {
    // rust: set_guest_slots(&mut host.hub.guests[i], from_kind, src);
    // rust: if b.is_none() {
    // rust: set_guest_slots(&mut host.hub.guests[i], to_kind, dst);
    // rust: return Ok(());
}
}
    // rust: if let Some(Side::Live(i)) = b {
    // rust: set_guest_slots(&mut host.hub.guests[i], to_kind, dst);
}
    // rust: Ok(())
}

    // Sends the player `uuid` the whole picture of map `map_id`: 128 x 128
    // colours (`MapColor` ids times 4 plus the shade, row by row), scale 0,
    // locked, no decorations, as `ClientboundMapItemDataPacket`. A filled
    // map the mod gives with that `minecraft:map_id` then shows it in hand
    // and in item frames; the server keeps nothing (a map id with no saved
    // map is never sent again by the game), so send it again after the
    // player joins. Use ids far from the world's own (they count up from 0).
    // False for a player not here, or `colors` not 16384 long.
    // API 132.
    // rust: pub(super) fn native_send_map(&mut self, uuid: u128, map_id: i32, colors: &[u8]) -> bool {
//         use horizon_protocol::packets::play::{Clientbound, MapItemData, MapPatch};
    // rust: if colors.len() != 128 * 128 {
    // rust: return false;
}
    // rust: self.native_send(
    // rust: uuid,
    // rust: Clientbound::MapItemData(MapItemData {
    // rust: map_id,
    // rust: scale: 0,
    // rust: locked: true,
    // rust: decorations: None,
    // rust: patch: Some(MapPatch {
    // rust: width: 128,
    // rust: height: 128,
    // rust: start_x: 0,
    // rust: start_y: 0,
    // rust: colors: colors.to_vec(),
    // rust: }),
    // rust: }),
    // rust: )
}
}

    // rust: mod tests {
//     use super::*;

stack :: proc(item: string, count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack {
    // rust: item: item.into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
}
}

a_files_slots_map_to_the_41_and_back :: proc() {
}
    // rust: let mut level = Level::default();
    // rust: let mut s = vec![None; 41];
    // rust: s[0] = Some(stack("minecraft:stone", 5));
    // rust: s[35] = Some(stack("minecraft:dirt", 1));
    // rust: s[36] = Some(stack("minecraft:iron_boots", 1));
    // rust: s[39] = Some(stack("minecraft:iron_helmet", 1));
    // rust: s[40] = Some(stack("minecraft:shield", 1));
    // rust: set_level_slots(&mut level, NativeInventoryKind::Player, s.clone());
    // rust: let slots: Vec<u8> = level.inventory.iter().map(|e| e.0).collect();
    // rust: assert_eq!(slots, [0, 35, 100, 103, 150]);
    // rust: assert_eq!(level_slots(&level, NativeInventoryKind::Player), s);
}

a_saved_player_file_round_trips_its_inventory_and_keeps_the_rest :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("native-inv-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let uuid = 0x1234_u128;
    // rust: let file = playerdata::path(&dir, uuid);
    // rust: std::fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: let mut level = Level {
    // rust: health: 13.0,
    // rust: xp_level: 7,
    // rust: ..Level::default()
}
    // rust: level.ender_items = vec![None; 27];
    // rust: level.ender_items[2] = Some(stack("minecraft:diamond", 3));
    // rust: let mut s = vec![None; 41];
    // rust: s[4] = Some(stack("minecraft:bread", 12));
    // rust: set_level_slots(&mut level, NativeInventoryKind::Player, s);
    // rust: write_dat(&file, level.player_tag()).unwrap();
    // rust: let mut back = read_level(&dir, uuid).unwrap();
    // rust: assert_eq!(back.health, 13.0);
    // rust: assert_eq!(back.xp_level, 7);
    // rust: assert_eq!(
    // rust: level_slots(&back, NativeInventoryKind::Ender)[2],
    // rust: Some(stack("minecraft:diamond", 3))
    // rust: );
    // rust: let mut inv = level_slots(&back, NativeInventoryKind::Player);
    // rust: assert_eq!(inv[4], Some(stack("minecraft:bread", 12)));
    // rust: inv[4] = None;
    // rust: set_level_slots(&mut back, NativeInventoryKind::Player, inv);
    // rust: write_dat(&file, back.player_tag()).unwrap();
    // rust: let again = read_level(&dir, uuid).unwrap();
    // rust: assert!(
    // rust: level_slots(&again, NativeInventoryKind::Player)
    // rust: .iter()
    // rust: .all(Option::is_none)
    // rust: );
    // rust: assert_eq!(again.xp_level, 7);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
