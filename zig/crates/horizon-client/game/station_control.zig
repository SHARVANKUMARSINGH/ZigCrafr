//! Transpiled from Horizon Rust crate
//! Module: horizon-client_station_control
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Control-socket commands for menus and item components, so scripts can
//! drive the workstation screens (`horizon-ctl click-slot 600`, ...).
// use super::{Game, Screen};
// use horizon_client::{Result, items::ItemStack};
// use serde_json::{Value, json};

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "xp LEVELS                      add (or remove) experience levels",
    // rust: "setblock X Y Z BLOCK           place a block's default state (with its block entity)",
    // rust: "use X Y Z                      open the block's menu as if right-clicked",
    // rust: "click-slot ID [right] [shift]  click a menu slot (0-35 inventory, 300+ container, 600+ station, 650 result)",
    // rust: "click-gui X Y [right] [shift]  click at GUI pixel X Y relative to the menu's top-left corner",
    // rust: "book [next|back|take|sign|done] the open book or lectern: its page, or press one of its buttons",
    // rust: "type TEXT | type-back          type into the anvil name box / delete one character",
    // rust: "enchant ID LEVEL               enchant the held item (books store the enchantment)",
    // rust: "potion ITEM POTION             give a potion item (potion, splash_potion, lingering_potion, tipped_arrow)",
    // rust: "menu                           JSON dump of the open menu, carried stack and inventory",
    // rust: "effect ID SECONDS [AMPLIFIER]  give a status effect (effect clear removes all)",
    // rust: "effects                        list active status effects",
    // rust: "trade PROFESSION [LEVEL] [TYPE] open a villager trading menu (offers from the world's trade sequences)",
    // rust: "mount-menu [tame] [chest]      open the inventory of the nearest horse, donkey or mule (tame, chest set those)",
    // rust: "close                          close the open menu",
    // rust: ];
pub fn id(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
}
pub fn stack_json(s: *ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "item": &*s.item,
    // rust: "count": s.count,
    // rust: "damage": s.damage,
    // rust: "enchantments": s.enchantments().iter().map(|(e, l)| json!([&**e, l])).collect::<Vec<_>>(),
    // rust: "stored_enchantments": s.stored_enchantments().iter().map(|(e, l)| json!([&**e, l])).collect::<Vec<_>>(),
    // rust: "repair_cost": s.repair_cost(),
    // rust: "custom_name": s.custom_name(),
    // rust: "potion": s.potion(),
    // rust: "trim": s.data().and_then(|d| d.trim.as_ref()).map(|(m, p)| json!([&**m, &**p])),
    // rust: })
}

    // rust: impl Game<'_> {
pub fn click_at(self: *Self, x: f32, y: f32, right: bool, shift: bool) void {
}
//         use winit::keyboard::KeyCode;
    // rust: let saved = self.cursor;
    // rust: self.cursor = (x, y);
    // rust: let held = shift.then(|| {
    // rust: horizon_client_input::modifiers::hold(
    // rust: &mut self.modifiers,
    // rust: &mut self.physical_keys,
    // rust: KeyCode::ShiftLeft,
    // rust: )
    // rust: });
    // rust: self.click_inventory(right);
    // rust: if let Some(held) = held {
    // rust: horizon_client_input::modifiers::restore(
    // rust: &mut self.modifiers,
    // rust: &mut self.physical_keys,
    // rust: held,
    // rust: );
}
    // rust: self.cursor = saved;
}
    // rust: pub(super) fn gui_origin(&self) -> Result<(f32, f32)> {
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| [r.config.width, r.config.height])
    // rust: .ok_or("no renderer yet")?;
    // rust: Ok(self.inventory_origin(&horizon_client::hud::HudBatch::new(size)))
}
    /// Commands not known to control.rs; None when unknown here too.
    // rust: pub(super) fn station_command(&mut self, words: &[&str]) -> Result<Option<Value>> {
    // rust: let arg = |i: usize| {
    // rust: words
    // rust: .get(i)
    // rust: .copied()
    // rust: .ok_or_else(|| format!("{} needs more arguments", words[0]))
}
    // rust: let flag = |name: &str| words.iter().skip(1).any(|w| *w == name);
    // rust: let ok = || Ok(Some(json!({ "ok": true })));
    // rust: match words.first().copied().unwrap_or("") {
    // rust: "xp" => {
    // rust: let n: i32 = arg(1)?.parse()?;
    // rust: self.give_levels(n);
    // rust: Ok(Some(json!({ "ok": true, "level": self.experience.level })))
}
    // rust: "setblock" => {
    // rust: let pos = [arg(1)?.parse()?, arg(2)?.parse()?, arg(3)?.parse()?];
    // rust: let name = id(arg(4)?);
    // rust: if !self.set_state_named(pos, &name, &[])? {
    // rust: return Err(format!("cannot place {name}").into());
}
    // rust: if let Some(entity) = horizon_client::containers::BlockEntity::for_block(&name) {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert((pos[0], pos[1], pos[2]), entity);
}
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: ok()
}
    // rust: "use" => {
    // rust: let pos = [arg(1)?.parse()?, arg(2)?.parse()?, arg(3)?.parse()?];
    // rust: self.open_menu(pos);
    // rust: Ok(Some(
    // rust: json!({ "ok": true, "station": self.station.as_ref().map(|s| format!("{:?}", s.kind)) }),
    // rust: ))
}
    // rust: "click-slot" => {
    // rust: let slot: usize = arg(1)?.parse()?;
    // rust: let (ox, oy) = self.gui_origin()?;
    // rust: let (sx, sy) = self.slot_position(slot);
    // rust: self.click_at(ox + sx + 8.0, oy + sy + 8.0, flag("right"), flag("shift"));
    // rust: ok()
}
    // rust: "click-gui" => {
    // rust: let (x, y): (f32, f32) = (arg(1)?.parse()?, arg(2)?.parse()?);
    // rust: let (ox, oy) = self.gui_origin()?;
    // rust: self.click_at(ox + x, oy + y, flag("right"), flag("shift"));
    // rust: ok()
}
    // rust: "type" => {
    // rust: let text = words[1..].join(" ");
    // rust: self.station_text(Some(&text), false);
    // rust: ok()
}
    // rust: "type-back" => {
    // rust: self.station_text(None, true);
    // rust: ok()
}
    // rust: "enchant" => {
    // rust: let e = id(arg(1)?);
    // rust: let level: u32 = arg(2)?.parse()?;
    // rust: if self.stations().enchantments.get(&e).is_none() {
    // rust: return Err(format!("unknown enchantment {e}").into());
}
    // rust: let held = self.inventory[self.selected]
    // rust: .as_mut()
    // rust: .ok_or("no held item")?;
    // rust: held.enchant(&e, level);
    // rust: self.apply_equipment();
    // rust: ok()
}
    // rust: "book" => Ok(Some(self.book_control(words.get(1).copied())?)),
    // rust: "potion" => {
    // rust: let stack = ItemStack::new(&id(arg(1)?), 1).with_potion(&id(arg(2)?));
    // rust: let rest = self.give(stack);
    // rust: Ok(Some(json!({ "ok": rest.is_none() })))
}
    // rust: "menu" => {
    // rust: let slots: Vec<Value> = self
    // rust: .slots()
    // rust: .into_iter()
    // rust: .filter_map(|i| {
    // rust: let s = if i == 200 {
    // rust: self.craft_result()
    // rust: } else {
    // rust: self.slot_mut(i).clone()
}
    // rust: s.map(|s| json!({ "slot": i, "stack": stack_json(&s) }))
    // rust: })
    // rust: .collect();
    // rust: Ok(Some(json!({
    // rust: "screen": if self.screen == Screen::Inventory { "inventory" } else { "other" },
    // rust: "station": self.station.as_ref().map(|s| format!("{:?}", s.kind)),
    // rust: "name": self.station.as_ref().map(|s| s.name.clone()),
    // rust: "info": self.station_info(),
    // rust: "carried": self.carried.as_ref().map(stack_json),
    // rust: "level": self.experience.level,
    // rust: "xp_seed": self.level.xp_seed,
    // rust: "slots": slots,
    // rust: })))
}
    // rust: "effect" => {
    // rust: if arg(1)? == "clear" {
    // rust: self.potions.effects.clear();
    // rust: return ok();
}
    // rust: let def = horizon_client::brewing::effect(arg(1)?).ok_or("unknown effect")?;
    // rust: let seconds: i32 = arg(2)?.parse()?;
    // rust: let amp: i32 = words.get(3).map_or(Ok(0), |a| a.parse())?;
    // rust: self.potions
    // rust: .effects
    // rust: .add(horizon_client::effects::EffectInstance::new(
    // rust: def.id,
    // rust: seconds * 20,
    // rust: amp,
    // rust: ));
    // rust: ok()
}
    // rust: "trade" => {
    // rust: let profession = arg(1)?.trim_start_matches("minecraft:").to_owned();
    // rust: if !horizon_client::merchant::PROFESSIONS.contains(&profession.as_str()) {
    // rust: return Err(format!("unknown profession {profession}").into());
}
    // rust: let level: i32 = words.get(2).map_or(Ok(1), |l| l.parse())?;
    // rust: let variant = id(words.get(3).copied().unwrap_or("plains"));
    // rust: self.open_merchant(&profession, &variant, level);
    // rust: ok()
}
    // rust: "effects" => Ok(Some(
    // rust: json!({ "effects": self.effects_json(), "health": self.player.as_ref().map(|p| p.health.health()) }),
    // rust: )),
    // rust: "mount-menu" => {
    // rust: let eye = self.eye_position().ok_or("no player")?;
    // rust: let index = (0..self.mobs.len())
    // rust: .filter(|&i| horizon_client::mobs::equine::is_equine(self.mobs[i].species()))
    // rust: .min_by(|&a, &b| {
    // rust: let d = |i: usize| {
    // rust: let c = self.mobs[i].center();
    // rust: (c[0] - eye[0]).powi(2)
    // rust: + (c[1] - eye[1]).powi(2)
    // rust: + (c[2] - eye[2]).powi(2)
}
    // rust: d(a).total_cmp(&d(b))
    // rust: })
    // rust: .ok_or("no horse around")?;
    // rust: if flag("tame") {
    // rust: self.mobs[index].extra.tame = true;
}
    // rust: if flag("chest") {
    // rust: self.mobs[index].extra.chested = true;
}
    // rust: self.open_mount_menu(index);
    // rust: ok()
}
    // rust: "close" => {
    // rust: self.close_container();
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
    // rust: ok()
}
    // rust: _ => Ok(None),
}
}
}
