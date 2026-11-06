//! Transpiled from Horizon Rust crate
//! Module: horizon-client_items
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `/item` (ItemCommands) and `if items`/`if slots`: addressing the item
//! slots of the player, mobs, armor stands, item frames and containers.
// use super::{Arg, Context, Game, R, Target, err};
// use horizon_client::{
    // rust: command::{CommandError, args::ItemInput},
    // rust: containers::BlockEntity,
    // rust: furnace::FurnaceCooking,
    // rust: items::ItemStack,
    // rust: scoreboard_cmd::{Holder, Tracker},
    // rust: text::Text,
}
// use horizon_world::nbt::Tag;

    // rust: mod contents;
// use contents::Component;

/// One addressable slot.
    // rust: pub(in crate::game) enum Slot {
    /// `inventory[0..36]`: hotbar then the main rows.
    // rust: Inv(usize),
    /// The selected hotbar slot as `weapon.mainhand` names it: the equipment's
    /// `setItemSlot`, where `hotbar.N` is the inventory's `setItem`.
    // rust: MainHand,
    /// `armor[0..4]` (head, chest, legs, feet).
    // rust: Armor(usize),
    // rust: Offhand,
    // rust: Ender(usize),
    /// A mob's equipment by name (`mainhand`, `offhand`, `head`, ...).
    // rust: Mob(u32, &'static str),
    /// An armor stand's equipment (`ArmorStand::SLOTS` index).
    // rust: Stand(u32, usize),
    // rust: Frame(u32),
    /// A chest or hopper minecart's slot (`ContainerEntity.getChestVehicleSlot`).
    // rust: Cart(u32, usize),
    // rust: Block([i32; 3], usize),
    /// A slot of another player (`for_player`): reached with their state in place.
    // rust: Guest(u32, Box<Slot>),
    /// A component collection for writes, or an indexed component item for reads.
    // rust: Contents(Box<Slot>, Component),
    // rust: ContentItem(Box<Slot>, Component, usize),
}
pub const SlotCandidate = struct {
    slot: Slot,
    filters: std.ArrayList(serde_json::Value),
    limit: usize,
};
/// Whose slots a command addresses.
    // rust: pub(in crate::game) enum Owner {
    // rust: Entity(Target),
    // rust: Block([i32; 3]),
}

/// The player's slot names and the inventory index each addresses.
pub fn player_slot_names() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = Vec::new();
    // rust: for i in 0..36 {
    // rust: v.push((format!("container.{i}"), i));
}
    // rust: for i in 0..9 {
    // rust: v.push((format!("hotbar.{i}"), i));
}
    // rust: for i in 0..27 {
    // rust: v.push((format!("inventory.{i}"), 9 + i));
}
    // rust: v
}
/// `name` against a group: `container.*` matches every `container.N`.
pub fn matches_name(pattern: []const u8, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match pattern.strip_suffix(".*") {
    // rust: Some(prefix) => name.starts_with(&format!("{prefix}.")),
    // rust: None => pattern == name,
}
}

    // rust: impl Game<'_> {
pub fn owner_of(self: *Self, ctx: *Context, prefix: []const u8, many: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = ctx
    // rust: .literals
    // rust: .iter()
    // rust: .filter(|l| matches!(l.as_str(), "entity" | "block"))
    // rust: .nth(usize::from(prefix == "source" && ctx.has("from")))
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: if kind == "block" {
    // rust: let p = self.block_pos_arg(ctx, &format!("{prefix}Pos"))?;
    // rust: return Ok(vec![Owner::Block(p)]);
}
    // rust: let targets = self.entities(ctx, prefix, false)?;
    // rust: let _ = many;
    // rust: Ok(targets.into_iter().map(Owner::Entity).collect())
}
    /// The slots a name (or wildcard group) addresses on an owner.
    // rust: pub(in crate::game) fn slots_named(&mut self, owner: &Owner, name: &str) -> Vec<Slot> {
    // rust: if let Owner::Entity(Target::Guest(conn)) = *owner {
    // rust: let slots = self.for_player(Target::Guest(conn), |g| {
    // rust: g.slots_named(&Owner::Entity(Target::Player), name)
    // rust: });
    // rust: return slots
    // rust: .unwrap_or_default()
    // rust: .into_iter()
    // rust: .map(|s| Slot::Guest(conn, Box::new(s)))
    // rust: .collect();
}
    // rust: let mut out = Vec::new();
    // rust: let mut add = |s: Slot| out.push(s);
    // rust: match owner {
    // rust: Owner::Block(p) => {
    // rust: let size = self.block_container_size(*p).unwrap_or(0);
    // rust: for i in 0..size {
    // rust: if matches_name(name, &format!("container.{i}")) {
    // rust: add(Slot::Block(*p, i));
}
}
}
    // rust: Owner::Entity(Target::Player) => {
    // rust: for (n, i) in player_slot_names() {
    // rust: if matches_name(name, &n) {
    // rust: add(Slot::Inv(i));
}
}
    // rust: for (i, n) in ["armor.head", "armor.chest", "armor.legs", "armor.feet"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if matches_name(name, n) {
    // rust: add(Slot::Armor(i));
}
}
    // rust: if matches_name(name, "weapon") || matches_name(name, "weapon.mainhand") {
    // rust: add(Slot::MainHand);
}
    // rust: if matches_name(name, "weapon.offhand") {
    // rust: add(Slot::Offhand);
}
    // rust: for i in 0..27 {
    // rust: if matches_name(name, &format!("enderchest.{i}")) {
    // rust: add(Slot::Ender(i));
}
}
}
    // rust: Owner::Entity(Target::Mob(id)) => {
    // rust: for (n, key) in [
    // rust: ("weapon", "mainhand"),
    // rust: ("weapon.mainhand", "mainhand"),
    // rust: ("weapon.offhand", "offhand"),
    // rust: ("armor.head", "head"),
    // rust: ("armor.chest", "chest"),
    // rust: ("armor.legs", "legs"),
    // rust: ("armor.feet", "feet"),
    // rust: ("armor.body", "body"),
    // rust: ("saddle", "saddle"),
    // rust: ] {
    // rust: if matches_name(name, n) {
    // rust: add(Slot::Mob(*id, key));
}
}
}
    // rust: Owner::Entity(Target::Stand(id)) => {
    // rust: for (i, key) in horizon_client::entities::ArmorStand::SLOTS
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: let aliases: &[&str] = match *key {
    // rust: "mainhand" => &["weapon", "weapon.mainhand"],
    // rust: "offhand" => &["weapon.offhand"],
    // rust: "feet" => &["armor.feet"],
    // rust: "legs" => &["armor.legs"],
    // rust: "chest" => &["armor.chest"],
    // rust: _ => &["armor.head"],
}
    // rust: if aliases.iter().any(|a| matches_name(name, a)) {
    // rust: add(Slot::Stand(*id, i));
}
}
}
    // rust: Owner::Entity(Target::Frame(id)) => {
    // rust: if matches_name(name, "container.0") || matches_name(name, "contents") {
    // rust: add(Slot::Frame(*id));
}
}
            // `getChestVehicleSlot` takes any index below `getContainerSize`.
    // rust: Owner::Entity(Target::Cart(id)) => {
    // rust: let size = self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == *id)
    // rust: .map_or(0, |c| c.kind.slots());
    // rust: for i in 0..size {
    // rust: if matches_name(name, &format!("container.{i}")) {
    // rust: add(Slot::Cart(*id, i));
}
}
}
    // rust: Owner::Entity(_) => {}
}
    // rust: out
}
    /// `ItemCommands.getSlotsFromProvider`: evaluate inline sources against
    /// the accessor's live owner. Named ranges retain their existing adapter.
pub fn command_slots(self: *Self, owner: *Owner, raw: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if raw.starts_with('{') || raw.starts_with('[') {
    // rust: let Ok((tag, _)) = horizon_world::nbt::parse_snbt(raw) else {
    // rust: return Vec::new();
}
    // rust: self.inline_slots(owner, &horizon_client::scoreboard::tag_to_json(&tag))
    // rust: } else {
    // rust: self.slots_named(owner, raw)
}
}
    /// `SlotCollection.itemCopies` / `size`: transforms apply to the
    /// collection, before a command's item predicate or item modifier.
pub fn inline_slots(self: *Self, owner: *Owner, source: *serde_json::Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(terms) = source.as_array() {
    // rust: return terms
    // rust: .iter()
    // rust: .flat_map(|s| self.inline_slots(owner, s))
    // rust: .collect();
}
    // rust: match source["type"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .trim_start_matches("minecraft:")
    // rust: {
    // rust: "group" => source["terms"].as_array().map_or_else(Vec::new, |terms| {
    // rust: terms
    // rust: .iter()
    // rust: .flat_map(|s| self.inline_slots(owner, s))
    // rust: .collect()
    // rust: }),
    // rust: "slot_range" => self.slots_named(owner, source["slots"].as_str().unwrap_or_default()),
    // rust: "contents" => {
    // rust: let Some(component) = source["component"].as_str().and_then(Component::named)
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let parents = self.inline_slots(owner, &source["slot_source"]);
    // rust: parents
    // rust: .into_iter()
    // rust: .flat_map(|p| self.contents_slots(p, component))
    // rust: .collect()
}
    // rust: "limit_slots" => {
    // rust: let mut slots = self.inline_slots(owner, &source["slot_source"]);
    // rust: slots.truncate(source["limit"].as_u64().unwrap_or(0) as usize);
    // rust: slots
}
    // rust: "filtered" => {
    // rust: let slots = self.inline_slots(owner, &source["slot_source"]);
    // rust: slots
    // rust: .into_iter()
    // rust: .filter(|slot| self.slot_filter(slot, &source["item_filter"]))
    // rust: .collect()
}
    // rust: _ => Vec::new(),
}
}
pub fn slot_filter(self: *Self, slot: *Slot, filter: *serde_json::Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stack = self
    // rust: .slot_get(slot)
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:air", 0));
    // rust: self.loot_item_filter(filter, &stack)
}
    /// `SlotCollection.modifySlots` / `replaceSlotItems`: filters inspect the
    /// live stack when visited. Limits share the command's TrackingSelector
    /// count across owners and group terms, and count selected empty slots
    /// only for replacement (not modification).
pub fn command_slot_candidates(self: *Self, owner: *Owner, raw: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let source = horizon_world::nbt::parse_snbt(raw)
    // rust: .ok()
    // rust: .map(|(tag, _)| horizon_client::scoreboard::tag_to_json(&tag));
    // rust: if raw.starts_with('{') || raw.starts_with('[') {
    // rust: let mut out = Vec::new();
    // rust: if let Some(source) = source {
    // rust: self.slot_candidates(owner, &source, &[], usize::MAX, &mut out);
}
    // rust: out
    // rust: } else {
    // rust: self.slots_named(owner, raw)
    // rust: .into_iter()
    // rust: .map(|slot| SlotCandidate {
    // rust: slot,
    // rust: filters: Vec::new(),
    // rust: limit: usize::MAX,
    // rust: })
    // rust: .collect()
}
}
    /// `CompositeSlotSource.provide` and `TransformedSlotSource.provide`:
    /// carry each leaf's filters and selection bound into live writes.
    // rust: fn slot_candidates(
    // rust: &mut self,
    // rust: owner: &Owner,
    // rust: source: &serde_json::Value,
    // rust: filters: &[serde_json::Value],
    // rust: limit: usize,
    // rust: out: &mut Vec<SlotCandidate>,
    // rust: ) {
    // rust: if let Some(terms) = source.as_array() {
    // rust: for term in terms {
    // rust: self.slot_candidates(owner, term, filters, limit, out);
}
    // rust: return;
}
    // rust: match source["type"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .trim_start_matches("minecraft:")
    // rust: {
    // rust: "group" => {
    // rust: if let Some(terms) = source["terms"].as_array() {
    // rust: for term in terms {
    // rust: self.slot_candidates(owner, term, filters, limit, out);
}
}
}
    // rust: "slot_range" => {
    // rust: for slot in self.slots_named(owner, source["slots"].as_str().unwrap_or_default()) {
    // rust: out.push(SlotCandidate {
    // rust: slot,
    // rust: filters: filters.to_vec(),
    // rust: limit,
    // rust: });
}
}
    // rust: "contents" => {
    // rust: if let Some(component) = source["component"].as_str().and_then(Component::named) {
    // rust: for parent in self.inline_slots(owner, &source["slot_source"]) {
    // rust: out.push(SlotCandidate {
    // rust: slot: Slot::Contents(Box::new(parent), component),
    // rust: filters: filters.to_vec(),
    // rust: limit,
    // rust: });
}
}
}
    // rust: "filtered" => {
    // rust: let mut filters = filters.to_vec();
    // rust: filters.push(source["item_filter"].clone());
    // rust: self.slot_candidates(owner, &source["slot_source"], &filters, limit, out);
}
    // rust: "limit_slots" => self.slot_candidates(
    // rust: owner,
    // rust: &source["slot_source"],
    // rust: filters,
    // rust: limit.min(source["limit"].as_u64().unwrap_or(0) as usize),
    // rust: out,
    // rust: ),
    // rust: _ => {}
}
}
    /// `SlotSelector.TrackingSelector.trySelectSlot`: count only slots that
    /// pass the predicate, before attempting the setter.
    // rust: fn select_slot(
    // rust: &mut self,
    // rust: candidate: &SlotCandidate,
    // rust: selected: &mut usize,
    // rust: nonempty: bool,
    // rust: ) -> bool {
    // rust: if *selected >= candidate.limit
    // rust: || (nonempty && self.slot_get(&candidate.slot).is_none())
    // rust: || !candidate
    // rust: .filters
    // rust: .iter()
    // rust: .all(|f| self.slot_filter(&candidate.slot, f))
    // rust: {
    // rust: return false;
}
    // rust: *selected += 1;
    // rust: true
}
    // rust: pub(in crate::game) fn slot_get(&mut self, s: &Slot) -> Option<ItemStack> {
    // rust: match s {
    // rust: Slot::Contents(..) => None,
    // rust: Slot::ContentItem(parent, component, index) => {
    // rust: let stack = self.slot_get(parent)?;
    // rust: component.items(&stack).get(*index).cloned().flatten()
}
    // rust: Slot::Guest(conn, slot) => self
    // rust: .for_player(Target::Guest(*conn), |g| g.slot_get(slot))
    // rust: .flatten(),
    // rust: Slot::Inv(i) => self.inventory.get(*i).cloned().flatten(),
    // rust: Slot::MainHand => self.inventory.get(self.selected).cloned().flatten(),
    // rust: Slot::Armor(i) => self.armor.get(*i).cloned().flatten(),
    // rust: Slot::Offhand => self.offhand.clone(),
    // rust: Slot::Ender(i) => self.ender_items.get(*i).cloned().flatten(),
    // rust: Slot::Mob(id, key) => {
    // rust: let m = self.mobs.iter().find(|m| m.id == *id)?;
    // rust: let item = match *key {
    // rust: "mainhand" => &m.extra.main_hand,
    // rust: "offhand" => &m.extra.off_hand,
    // rust: "head" => &m.extra.head,
    // rust: "body" => &m.extra.body,
    // rust: "chest" => &m.extra.chest,
    // rust: "legs" => &m.extra.legs,
    // rust: "feet" => &m.extra.feet,
    // rust: _ => return None,
}
    // rust: item.as_ref().map(|i| ItemStack {
    // rust: item: i.clone(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })
}
    // rust: Slot::Stand(id, i) => self
    // rust: .armor_stands
    // rust: .iter()
    // rust: .find(|a| a.id == *id)?
    // rust: .equipment
    // rust: .get(*i)
    // rust: .cloned()
    // rust: .flatten(),
    // rust: Slot::Frame(id) => self.item_frames.iter().find(|f| f.id == *id)?.item.clone(),
    // rust: Slot::Cart(id, i) => self.cart_slots(*id)?.get(*i).cloned().flatten(),
    // rust: Slot::Block(p, i) => self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&(p[0], p[1], p[2]))?
    // rust: .slots()
    // rust: .get(*i)
    // rust: .cloned()
    // rust: .flatten(),
}
}
    // rust: pub(in crate::game) fn slot_accepts(&self, s: &Slot, stack: Option<&ItemStack>) -> bool {
    // rust: let Slot::Block(p, i) = s else {
    // rust: return true;
}
    // rust: let air = ItemStack {
    // rust: item: "minecraft:air".into(),
    // rust: count: 0,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: self.block_can_place(*p, *i, stack.unwrap_or(&air))
}
pub fn block_container_size(self: *Self, p: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = match self.world.block_entities.get(&(p[0], p[1], p[2]))? {
    // rust: BlockEntity::Mod(m) if m.id.is_empty() => 0,
    // rust: BlockEntity::Mod(_) => self
    // rust: .world
    // rust: .block_entities
    // rust: .mod_container(self.world.block(p[0], p[1], p[2]).0)
    // rust: .map_or(0, |c| c.slots),
    // rust: entity => entity.slots().len(),
}
    // rust: (size > 0).then_some(size)
}
pub fn block_slot_set(self: *Self, p: [i32; 3], i: usize, stack: ?ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (p[0], p[1], p[2]);
    // rust: let Some(size) = self.block_container_size(p).filter(|&size| i < size) else {
    // rust: return false;
}
    // rust: let book = stack.as_ref().is_none_or(|s| {
    // rust: self.items()
    // rust: .item_tags
    // rust: .get("minecraft:bookshelf_books")
    // rust: .is_some_and(|m| m.contains(&*s.item))
    // rust: });
    // rust: let recipes = world_recipes!(self);
    // rust: match self.world.block_entities.get_mut(&key) {
    // rust: Some(BlockEntity::Furnace(f)) if i == 0 => f.set_input(recipes, stack),
    // rust: Some(BlockEntity::Furnace(f)) => {
    // rust: f.items[i] = stack;
    // rust: self.world.modified.insert((p[0] >> 4, p[2] >> 4));
    // rust: return true;
}
    // rust: Some(BlockEntity::ChiseledBookshelf(_)) if !book => return true,
    // rust: Some(BlockEntity::Jukebox(_)) => {
    // rust: self.jukebox_set_item(p, stack);
    // rust: return true;
}
    // rust: Some(BlockEntity::Crafter(c)) => {
    // rust: c.disabled[i] = false;
    // rust: c.items[i] = stack;
}
    // rust: Some(BlockEntity::Mod(m)) => {
    // rust: if m.items.len() < size {
    // rust: m.items.resize(size, None);
}
    // rust: m.items[i] = stack;
}
    // rust: Some(entity) => entity.slots_mut()[i] = stack,
    // rust: None => return false,
}
    // rust: self.container_changed(key);
    // rust: true
}
    /// `LivingEntity.createEquipmentSlotAccess`: every slot but head, mainhand
    /// and offhand takes only an empty stack or one whose
    /// `getEquipmentSlotForItem` is that slot (a non-equippable item is mainhand).
pub fn equipment_slot_accepts(self: *Self, s: *Slot, stack: ?*ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = match s {
    // rust: Slot::Guest(_, inner) => return self.equipment_slot_accepts(inner, stack),
    // rust: Slot::Armor(i @ 1..=3) => ["head", "chest", "legs", "feet"][*i],
    // rust: Slot::Mob(_, key) if matches!(*key, "chest" | "legs" | "feet") => key,
    // rust: _ => return true,
}
        // ItemStack.isEmpty: air or a count of 0.
    // rust: let Some(stack) = stack.filter(|s| &*s.item != "minecraft:air" && s.count > 0) else {
    // rust: return true;
}
    // rust: self.items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|info| info.equip_slot.as_deref() == Some(name))
}
    /// Put a stack (or nothing) in a slot; false when the slot cannot take it.
    // rust: pub(in crate::game) fn slot_set(&mut self, s: &Slot, stack: Option<ItemStack>) -> bool {
    // rust: match s {
    // rust: Slot::Contents(..) => false,
    // rust: Slot::ContentItem(parent, component, index) => {
    // rust: let Some(mut outer) = self.slot_get(parent) else {
    // rust: return false;
}
    // rust: let mut slots = component.items(&outer);
    // rust: let Some(slot) = slots.get_mut(*index) else {
    // rust: return false;
}
    // rust: *slot = stack;
    // rust: component.store(&mut outer, slots);
    // rust: self.slot_set(parent, Some(outer))
}
    // rust: Slot::Guest(conn, slot) => self
    // rust: .for_player(Target::Guest(*conn), |g| g.slot_set(slot, stack))
    // rust: .unwrap_or(false),
    // rust: Slot::Inv(i) => match self.inventory.get_mut(*i) {
    // rust: Some(slot) => {
    // rust: *slot = stack;
    // rust: true
}
    // rust: None => false,
    // rust: },
            // LivingEntity's equipment SlotAccess: setItemSlot, so onEquipItem.
    // rust: Slot::MainHand => match self.inventory.get_mut(self.selected) {
    // rust: Some(slot) => {
    // rust: let old = std::mem::replace(slot, stack.clone());
    // rust: self.player_on_equip("mainhand", old.as_ref(), stack.as_ref());
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Slot::Armor(i) => match self.armor.get_mut(*i) {
    // rust: Some(slot) => {
    // rust: let old = std::mem::replace(slot, stack.clone());
    // rust: let name = ["head", "chest", "legs", "feet"][*i];
    // rust: self.player_on_equip(name, old.as_ref(), stack.as_ref());
    // rust: self.apply_equipment();
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Slot::Offhand => {
    // rust: let old = std::mem::replace(&mut self.offhand, stack.clone());
    // rust: self.player_on_equip("offhand", old.as_ref(), stack.as_ref());
    // rust: true
}
    // rust: Slot::Ender(i) => match self.ender_items.get_mut(*i) {
    // rust: Some(slot) => {
    // rust: *slot = stack;
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Slot::Mob(id, key) => {
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == *id) else {
    // rust: return false;
}
    // rust: let item = stack.as_ref().map(|s| s.item.clone());
                // The worn armour stack goes with the id: a kept stack of the
                // previous piece would otherwise still be what the mob wears.
    // rust: let worn = match *key {
    // rust: "head" => Some(0),
    // rust: "chest" => Some(1),
    // rust: "legs" => Some(2),
    // rust: "feet" => Some(3),
    // rust: _ => None,
}
    // rust: if let Some(i) = worn {
    // rust: m.extra.armor[i] = stack.clone();
}
    // rust: match *key {
    // rust: "mainhand" => m.extra.set_main_hand_stack(stack),
    // rust: "offhand" => m.extra.off_hand = item,
    // rust: "head" => m.extra.head = item,
    // rust: "body" => m.extra.body = item,
    // rust: "chest" => m.extra.chest = item,
    // rust: "legs" => m.extra.legs = item,
    // rust: "feet" => m.extra.feet = item,
    // rust: _ => return false,
}
    // rust: true
}
    // rust: Slot::Stand(id, i) => {
                // LivingEntity.onEquipItem: all stand slots emit; the new
                // stack's EQUIPPABLE presence chooses equip versus unequip.
    // rust: let equippable = stack.as_ref().is_some_and(|s| {
    // rust: let data = s.data();
    // rust: !data.is_some_and(|d| d.other("!minecraft:equippable").is_some())
    // rust: && (data.is_some_and(|d| d.other("minecraft:equippable").is_some())
    // rust: || self
    // rust: .items()
    // rust: .get(&s.item)
    // rust: .is_some_and(|i| i.equip_slot.is_some()))
    // rust: });
    // rust: let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == *id) else {
    // rust: return false;
}
    // rust: let Some(slot) = a.equipment.get_mut(*i) else {
    // rust: return false;
}
    // rust: let same = match (slot.as_ref(), stack.as_ref()) {
    // rust: (None, None) => true,
    // rust: (Some(old), Some(new)) => old.same_item_same_components(new),
    // rust: _ => false,
}
    // rust: let emit = !a.first_tick && !same;
    // rust: let at = a.position;
    // rust: *slot = stack;
    // rust: if emit && self.remote.is_none() {
    // rust: self.post_game_event(
    // rust: if equippable {
    // rust: "minecraft:equip"
    // rust: } else {
    // rust: "minecraft:unequip"
    // rust: },
    // rust: [at.x, at.y, at.z],
    // rust: horizon_client::sculk::Context {
    // rust: source: Some(horizon_client::mobs::Who::Mob(*id)),
    // rust: living: true,
    // rust: ..Default::default()
    // rust: },
    // rust: );
}
    // rust: true
}
    // rust: Slot::Frame(id) => match self.item_frames.iter_mut().find(|f| f.id == *id) {
    // rust: Some(f) => {
    // rust: f.item = stack;
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Slot::Cart(id, i) => match self.cart_slots(*id).and_then(|c| c.get_mut(*i)) {
    // rust: Some(slot) => {
    // rust: *slot = stack;
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Slot::Block(p, i) => self.block_slot_set(*p, *i, stack),
}
}
pub fn owner_holder(self: *Self, o: *Owner) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match o {
    // rust: Owner::Entity(t) => Holder {
    // rust: name: String::new(),
    // rust: text: self.target_name(*t),
    // rust: display: None,
    // rust: },
    // rust: Owner::Block(p) => Holder {
    // rust: name: String::new(),
    // rust: text: Text::literal(format!("{}, {}, {}", p[0], p[1], p[2])),
    // rust: display: None,
    // rust: },
}
}
pub fn stack_name(self: *Self, s: *ItemStack) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stack_display_name(s)
}
pub fn item_from_input(self: *Self, ctx: *Context) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Arg::Item(ItemInput { id, components, .. })) = ctx.get("item").cloned() else {
    // rust: return Ok(None);
}
    // rust: let (damage, extra) = match components
    // rust: .as_deref()
    // rust: .map(horizon_client::item_data::command_components)
    // rust: {
    // rust: Some(Ok(tag)) => horizon_client::item_data::decode_components(Some(&tag)),
    // rust: Some(Err(e)) => return Err(CommandError::new(Text::literal(e))),
    // rust: None => (0, None),
}
    // rust: let count = Self::int(ctx, "count").unwrap_or(1).max(1) as u32;
    // rust: let stack = ItemStack {
    // rust: item: id.as_str().into(),
    // rust: count,
    // rust: damage,
    // rust: extra,
}
        // ItemInput.createItemStack: a count above the stack's max (its
        // max_stack_size component, else the item's) is refused.
    // rust: let max_stack = self.stack_max_size(&stack);
    // rust: if count > max_stack {
    // rust: return Err(err("arguments.item.overstacked", &[&id, &max_stack]));
}
    // rust: Ok(Some(stack))
}
    /// One item modifier (a typed object, a list or a datapack reference)
    /// applied to a stack; `None` when the stack ends up empty.
    // rust: fn apply_item_modifier(
    // rust: &self,
    // rust: m: &serde_json::Value,
    // rust: stack: Option<ItemStack>,
    // rust: rng: &mut horizon_core::random::LegacyRandom,
    // rust: this: Option<&horizon_client::advancements::EntityView>,
    // rust: origin: [f64; 3],
    // rust: depth: u32,
    // rust: ) -> Option<ItemStack> {
//         use horizon_core::random::RandomSource;
//         use serde_json::Value;
    // rust: if depth > 16 {
    // rust: return stack;
}
    // rust: let int = |v: &Value, rng: &mut horizon_core::random::LegacyRandom| -> i32 {
    // rust: if let Some(n) = v.as_f64() {
    // rust: return n as i32;
}
    // rust: let min = v["min"].as_f64().unwrap_or(0.) as i32;
    // rust: let max = v["max"].as_f64().unwrap_or(0.) as i32;
    // rust: match v["type"].as_str().unwrap_or("minecraft:constant") {
    // rust: "minecraft:uniform" | "uniform" => rng
    // rust: .next_int_between_inclusive(min, max.max(min))
    // rust: .unwrap_or(min),
    // rust: _ => v["value"].as_f64().unwrap_or(0.) as i32,
}
}
    // rust: match m {
    // rust: Value::Array(list) => list.iter().fold(stack, |s, f| {
    // rust: self.apply_item_modifier(f, s, rng, this, origin, depth + 1)
    // rust: }),
    // rust: Value::String(id) => match self.fns.store.item_modifiers.get(id) {
    // rust: Some(f) => self.apply_item_modifier(f, stack, rng, this, origin, depth + 1),
    // rust: None => stack,
    // rust: },
    // rust: Value::Object(_) => {
    // rust: let mut stack = stack?;
                // 26.3 item modifiers: a single `condition`, dispatched on `type`.
    // rust: if !m["condition"].is_null() && !self.conditions_hold(&m["condition"], this, origin)
    // rust: {
    // rust: return Some(stack);
}
    // rust: match m["type"].as_str().unwrap_or("") {
    // rust: "minecraft:sequence" => {
    // rust: return m["functions"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .fold(Some(stack), |s, f| {
    // rust: self.apply_item_modifier(f, s, rng, this, origin, depth + 1)
    // rust: });
}
    // rust: "minecraft:set_count" => {
    // rust: let n = int(&m["count"], rng);
    // rust: let base = if m["add"].as_bool() == Some(true) {
    // rust: stack.count as i32
    // rust: } else {
    // rust: 0
}
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(64, |i| i.max_stack);
    // rust: stack.count = (base + n).clamp(0, max as i32) as u32;
}
    // rust: "minecraft:limit_count" => {
    // rust: let min = m["limit"]["min"].as_i64().or(m["limit"].as_i64());
    // rust: let max = m["limit"]["max"].as_i64().or(m["limit"].as_i64());
    // rust: if let Some(min) = min {
    // rust: stack.count = stack.count.max(min as u32);
}
    // rust: if let Some(max) = max {
    // rust: stack.count = stack.count.min(max as u32);
}
}
    // rust: "minecraft:set_damage" => {
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage);
    // rust: if max > 0 {
    // rust: let f = match m["damage"].as_f64() {
    // rust: Some(f) => f as f32,
    // rust: None => {
    // rust: let lo = m["damage"]["min"].as_f64().unwrap_or(0.) as f32;
    // rust: let hi = m["damage"]["max"].as_f64().unwrap_or(0.) as f32;
    // rust: lo + rng.next_float() * (hi - lo)
}
}
    // rust: let base = if m["add"].as_bool() == Some(true) {
    // rust: 1. - stack.damage as f32 / max as f32
    // rust: } else {
    // rust: 0.
}
    // rust: let frac = (base + f).clamp(0., 1.);
    // rust: stack.damage = ((1. - frac) * max as f32).floor() as u32;
}
}
    // rust: "minecraft:set_name" => {
    // rust: if m["name"].is_null() {
    // rust: return Some(stack);
}
    // rust: if m["target"].as_str() == Some("item_name") {
    // rust: let name = horizon_client::scoreboard::json_to_tag(&m["name"]);
    // rust: edit_components(&mut stack, |c| {
    // rust: c.insert("minecraft:item_name".into(), name);
    // rust: });
    // rust: } else {
                            // SetNameFunction.run preserves the component when no entity resolver is requested.
    // rust: stack
    // rust: .data_mut()
    // rust: .set_loot_name("minecraft:custom_name", &m["name"]);
}
}
    // rust: "minecraft:set_enchantments" => {
    // rust: let add = m["add"].as_bool() == Some(true);
    // rust: let d = stack.extra.get_or_insert_with(Default::default);
    // rust: let target = if &*stack.item == "minecraft:enchanted_book" {
    // rust: &mut d.stored_enchantments
    // rust: } else {
    // rust: &mut d.enchantments
}
    // rust: for (id, level) in m["enchantments"].as_object().into_iter().flatten() {
    // rust: let n = int(level, rng).clamp(0, 255) as u32;
    // rust: let id: std::sync::Arc<str> = if id.contains(':') {
    // rust: id.as_str().into()
    // rust: } else {
    // rust: format!("minecraft:{id}").into()
}
    // rust: match target.iter_mut().find(|(e, _)| *e == id) {
    // rust: Some(e) => e.1 = if add { e.1 + n } else { n },
    // rust: None => target.push((id, n)),
}
    // rust: target.retain(|(_, l)| *l > 0);
}
}
    // rust: "minecraft:set_potion" => {
    // rust: if let Some(p) = m["id"].as_str() {
    // rust: stack.extra.get_or_insert_with(Default::default).potion =
    // rust: Some(p.into());
}
}
    // rust: "minecraft:set_lore" => {
    // rust: let lines: Vec<Tag> = m["lore"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(horizon_client::scoreboard::json_to_tag)
    // rust: .collect();
    // rust: edit_components(&mut stack, |c| {
    // rust: let old: Vec<Tag> = match c.get(&"minecraft:lore".into()) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: let new = list_operation(m, old, lines);
    // rust: c.insert("minecraft:lore".into(), Tag::List(new));
    // rust: });
}
    // rust: "minecraft:set_custom_data" => {
    // rust: let tag = match &m["tag"] {
    // rust: Value::String(snbt) => horizon_world::nbt::parse_snbt(snbt)
    // rust: .map(|(t, _)| t)
    // rust: .unwrap_or(Tag::Compound(Default::default())),
    // rust: v => horizon_client::scoreboard::json_to_tag(v),
}
    // rust: edit_components(&mut stack, |c| {
    // rust: let mut data = match c.get(&"minecraft:custom_data".into()) {
    // rust: Some(t @ Tag::Compound(_)) => t.clone(),
    // rust: _ => Tag::Compound(Default::default()),
}
    // rust: merge_compound(&mut data, &tag);
    // rust: c.insert("minecraft:custom_data".into(), data);
    // rust: });
}
    // rust: "minecraft:set_components" => {
    // rust: let patch = m["components"].clone();
    // rust: edit_components(&mut stack, |c| {
    // rust: for (k, v) in patch.as_object().into_iter().flatten() {
    // rust: let (remove, key) = match k.strip_prefix('!') {
    // rust: Some(rest) => (true, rest),
    // rust: None => (false, k.as_str()),
}
    // rust: let key = if key.contains(':') {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{key}")
}
    // rust: if remove {
    // rust: c.remove(&key.as_str().into());
    // rust: } else {
    // rust: c.insert(
    // rust: key.as_str().into(),
    // rust: horizon_client::scoreboard::json_to_tag(v),
    // rust: );
}
}
    // rust: });
}
    // rust: "minecraft:toggle_tooltips" => {
    // rust: let toggles = m["toggles"].clone();
    // rust: edit_components(&mut stack, |c| {
    // rust: let mut hidden: Vec<String> = c
    // rust: .get(&"minecraft:tooltip_display".into())
    // rust: .and_then(|d| d.get("hidden_components"))
    // rust: .and_then(|l| match l {
    // rust: Tag::List(l) => Some(
    // rust: l.iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let hide_tooltip = c
    // rust: .get(&"minecraft:tooltip_display".into())
    // rust: .and_then(|d| d.get("hide_tooltip"))
    // rust: .cloned();
    // rust: for (k, shown) in toggles.as_object().into_iter().flatten() {
    // rust: let key = if k.contains(':') {
    // rust: k.clone()
    // rust: } else {
    // rust: format!("minecraft:{k}")
}
    // rust: hidden.retain(|h| *h != key);
    // rust: if shown.as_bool() == Some(false) {
    // rust: hidden.push(key);
}
}
    // rust: let mut display: Vec<(&str, Tag)> = Vec::new();
    // rust: if let Some(h) = hide_tooltip {
    // rust: display.push(("hide_tooltip", h));
}
    // rust: if !hidden.is_empty() {
    // rust: display.push((
    // rust: "hidden_components",
    // rust: Tag::List(
    // rust: hidden
    // rust: .iter()
    // rust: .map(|h| Tag::String(h.as_str().into()))
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: c.insert("minecraft:tooltip_display".into(), Tag::compound(display));
    // rust: });
}
    // rust: "minecraft:filtered" => {
    // rust: let pass = self.loot_item_filter(&m["item_filter"], &stack);
    // rust: let branch = if pass { &m["on_pass"] } else { &m["on_fail"] };
    // rust: if branch.is_null() {
    // rust: return Some(stack);
}
    // rust: return self.apply_item_modifier(
    // rust: branch,
    // rust: Some(stack),
    // rust: rng,
    // rust: this,
    // rust: origin,
    // rust: depth + 1,
    // rust: );
}
    // rust: "minecraft:discard" => stack.count = 0,
    // rust: _ => {}
}
    // rust: (stack.count > 0).then_some(stack)
}
    // rust: _ => stack,
}
}
    /// `ItemStack.getMaxStackSize`: the max_stack_size component, else the
    /// item's.
    // rust: pub(in crate::game) fn stack_max_size(&self, s: &ItemStack) -> u32 {
    // rust: if let Some(Tag::Int(n)) = s.data().and_then(|d| d.other("minecraft:max_stack_size")) {
    // rust: return (*n).clamp(1, 99) as u32;
}
    // rust: self.items().get(&s.item).map_or(64, |i| i.max_stack)
}
    /// `ResourceOrIdArgument.getItemModifier`: an inline modifier (SNBT) or
    /// a registered one.
    // rust: pub(super) fn item_modifier_arg(&mut self, ctx: &Context, name: &str) -> R<serde_json::Value> {
    // rust: let raw = match ctx.get(name) {
    // rust: Some(Arg::Resource(s) | Arg::Str(s)) => s.clone(),
    // rust: _ => return Err(err("command.failed", &[])),
}
    // rust: if raw.starts_with('{') || raw.starts_with('[') {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(&raw)
    // rust: .map_err(|e| err("argument.nbt.invalid", &[&e]))?;
    // rust: return Ok(horizon_client::scoreboard::tag_to_json(&tag));
}
    // rust: let id = if raw.contains(':') {
    // rust: raw
    // rust: } else {
    // rust: format!("minecraft:{raw}")
}
    // rust: self.fns
    // rust: .store
    // rust: .item_modifiers
    // rust: .get(&id)
    // rust: .cloned()
    // rust: .ok_or_else(|| err("argument.item_modifier.unknown", &[&id]))
}
    /// `/item modify (entity|block) <target> <slot> <modifier>`.
    // rust: pub(super) fn cmd_item_modify(&mut self, ctx: &Context) -> R<i32> {
    // rust: self.ensure_datapacks();
    // rust: let targets = self.owner_of(ctx, "target", true)?;
    // rust: let Some(Arg::Str(slot_name)) = ctx.get("slot").cloned() else {
    // rust: return Ok(0);
}
    // rust: let modifier = self.item_modifier_arg(ctx, "modifier")?;
    // rust: let source = self.command_source.unwrap_or_else(|| self.player_source());
    // rust: let view = source.entity.map(|t| self.entity_view_asked(t, &modifier));
    // rust: let seed = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as i64);
    // rust: let mut rng = horizon_core::random::LegacyRandom::new(seed);
    // rust: let mut tracker = Tracker::default();
    // rust: let mut selected = 0;
    // rust: for o in &targets {
    // rust: let slots = self.command_slot_candidates(o, &slot_name);
    // rust: if slots.is_empty() {
    // rust: if let Owner::Block(p) = o
    // rust: && self.block_container_size(*p).is_none()
    // rust: {
    // rust: return Err(err(
    // rust: "commands.item.target.not_a_container",
    // rust: &[&p[0], &p[1], &p[2]],
    // rust: ));
}
    // rust: continue;
}
    // rust: let mut changed = 0;
    // rust: for candidate in &slots {
    // rust: if let Slot::Contents(parent, component) = &candidate.slot {
    // rust: changed += self.modify_contents(
    // rust: parent,
    // rust: *component,
    // rust: candidate,
    // rust: &mut selected,
    // rust: |g, current| {
    // rust: g.apply_item_modifier(
    // rust: &modifier,
    // rust: Some(current),
    // rust: &mut rng,
    // rust: view.as_ref(),
    // rust: source.pos,
    // rust: 0,
    // rust: )
    // rust: .map(|mut s| {
    // rust: s.count = s.count.min(g.stack_max_size(&s));
    // rust: s
    // rust: })
    // rust: },
    // rust: );
    // rust: continue;
}
    // rust: if !self.select_slot(candidate, &mut selected, true) {
    // rust: continue;
}
    // rust: let slot = &candidate.slot;
                // SlotSelector.NON_EMPTY_SLOTS
    // rust: let Some(current) = self.slot_get(slot) else {
    // rust: continue;
}
    // rust: let new = self.apply_item_modifier(
    // rust: &modifier,
    // rust: Some(current.clone()),
    // rust: &mut rng,
    // rust: view.as_ref(),
    // rust: source.pos,
    // rust: 0,
    // rust: );
                // CountingModifier: every slot set counts, changed or not;
                // ItemStack.limitSize to the (new) max stack size.
    // rust: let new = new.map(|mut s| {
    // rust: let max = self.stack_max_size(&s);
    // rust: s.count = s.count.min(max);
    // rust: s
    // rust: });
    // rust: if self.equipment_slot_accepts(slot, new.as_ref()) && self.slot_set(slot, new) {
    // rust: changed += 1;
}
}
    // rust: let h = self.owner_holder(o);
    // rust: tracker.track(&h, changed);
}
    // rust: if selected == 0 {
    // rust: return Err(
    // rust: if slot_name.starts_with('{') || slot_name.starts_with('[') {
    // rust: err("commands.item.target.no_such_slot.unnamed", &[])
    // rust: } else {
    // rust: err("commands.item.target.no_such_slot", &[&slot_name])
    // rust: },
    // rust: );
}
    // rust: let pos = match targets.first() {
    // rust: Some(Owner::Block(p)) => Some(*p),
    // rust: _ => None,
}
    // rust: let (message, total) = tracker.message(
    // rust: false,
    // rust: Some(err("commands.item.target.failed", &[])),
    // rust: |h, count| {
    // rust: let n = Text::literal(count.to_string());
    // rust: match pos {
    // rust: Some(p) => Text::translate(
    // rust: "commands.item.block.modify.success",
    // rust: &[
    // rust: n,
    // rust: Text::literal(p[0].to_string()),
    // rust: Text::literal(p[1].to_string()),
    // rust: Text::literal(p[2].to_string()),
    // rust: ],
    // rust: ),
    // rust: None => Text::translate(
    // rust: "commands.item.entity.modify.success.single",
    // rust: &[n, h.text.clone()],
    // rust: ),
}
    // rust: },
    // rust: |c, _| {
    // rust: Text::translate(
    // rust: "commands.item.entity.modify.success.multiple",
    // rust: &[Text::literal(c.to_string())],
    // rust: )
    // rust: },
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}
    /// `/item replace|fill|override <target> <slots> (with <item> [count] | from <source> <slots>)`.
    // rust: pub(super) fn cmd_item(&mut self, ctx: &Context) -> R<i32> {
    // rust: let mode = ctx
    // rust: .literals
    // rust: .iter()
    // rust: .find(|l| matches!(l.as_str(), "replace" | "fill" | "override"))
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: let targets = self.owner_of(ctx, "target", true)?;
    // rust: let Some(Arg::Str(slot_name)) = ctx.get("slots").cloned() else {
    // rust: return Ok(0);
}
        // The items to place.
    // rust: let (items, known): (Vec<Option<ItemStack>>, Option<ItemStack>) = if ctx.has("with") {
    // rust: let stack = self.item_from_input(ctx)?;
    // rust: (vec![stack.clone()], stack)
    // rust: } else {
    // rust: let sources = self.owner_of(ctx, "source", true)?;
    // rust: let Some(Arg::Str(source_slots)) = ctx.get("sourceSlots").cloned() else {
    // rust: return Ok(0);
}
    // rust: let mut found = Vec::new();
    // rust: for o in &sources {
    // rust: for s in self.command_slots(o, &source_slots) {
    // rust: found.push(self.slot_get(&s));
}
}
    // rust: if found.is_empty() {
    // rust: return Err(match &sources[..] {
                    // ItemCommands.getContainer: a block entity that is no Container
                    // (a sign, a lectern, a beacon) is no source either.
    // rust: [Owner::Block(p)] if self.block_container_size(*p).is_none() => err(
    // rust: "commands.item.source.not_a_container",
    // rust: &[&p[0], &p[1], &p[2]],
    // rust: ),
    // rust: _ if source_slots.starts_with('{') || source_slots.starts_with('[') => {
    // rust: err("commands.item.source.no_such_slot.unnamed", &[])
}
    // rust: _ => err("commands.item.source.no_such_slot", &[&source_slots]),
    // rust: });
}
            // ItemCommands.applyModifier on each source stack.
    // rust: if ctx.get("modifier").is_some() {
    // rust: let modifier = self.item_modifier_arg(ctx, "modifier")?;
    // rust: let source = self.command_source.unwrap_or_else(|| self.player_source());
    // rust: let view = source.entity.map(|t| self.entity_view_asked(t, &modifier));
    // rust: let mut rng = horizon_core::random::LegacyRandom::new(0);
    // rust: found = found
    // rust: .into_iter()
    // rust: .map(|s| {
    // rust: s.and_then(|s| {
    // rust: self.apply_item_modifier(
    // rust: &modifier,
    // rust: Some(s),
    // rust: &mut rng,
    // rust: view.as_ref(),
    // rust: source.pos,
    // rust: 0,
    // rust: )
    // rust: })
    // rust: })
    // rust: .collect();
}
            // A source with nothing in the slot contributes air.
    // rust: (found, None)
}
    // rust: let mut tracker = Tracker::default();
    // rust: let mut selected = 0;
    // rust: for o in &targets {
    // rust: let slots = self.command_slot_candidates(o, &slot_name);
    // rust: if slots.is_empty() {
    // rust: if let Owner::Block(p) = o
    // rust: && self.block_container_size(*p).is_none()
    // rust: {
    // rust: return Err(err(
    // rust: "commands.item.target.not_a_container",
    // rust: &[&p[0], &p[1], &p[2]],
    // rust: ));
}
    // rust: continue;
}
    // rust: let mut changed = 0;
    // rust: let mut i = 0;
    // rust: for candidate in &slots {
    // rust: if let Slot::Contents(parent, component) = &candidate.slot {
    // rust: changed += self.replace_contents(
    // rust: parent,
    // rust: *component,
    // rust: candidate,
    // rust: &mut selected,
    // rust: &mut contents::Provider::new(&items, &mut i, &mode),
    // rust: );
    // rust: continue;
}
    // rust: if !self.select_slot(candidate, &mut selected, false) {
    // rust: continue;
}
    // rust: let slot = &candidate.slot;
                // `fill` cycles through the items; `replace` stops when they
                // run out; `override` empties the rest.
    // rust: let item = match mode.as_str() {
    // rust: "fill" => items.get(i % items.len()).cloned().flatten(),
    // rust: "override" => items.get(i).cloned().flatten(),
    // rust: _ => match items.get(i) {
    // rust: Some(x) => x.clone(),
    // rust: None => break,
    // rust: },
}
    // rust: i += 1;
                // ItemStack.isEmpty: air (or a count of 0) is an empty slot.
                // SlotAccess.set counts every slot it sets, the same item too.
    // rust: let item = item.filter(|s| &*s.item != "minecraft:air" && s.count > 0);
    // rust: if self.equipment_slot_accepts(slot, item.as_ref()) && self.slot_set(slot, item) {
    // rust: changed += 1;
}
}
    // rust: let h = self.owner_holder(o);
    // rust: tracker.track(&h, changed);
}
    // rust: if selected == 0 {
    // rust: return Err(
    // rust: if slot_name.starts_with('{') || slot_name.starts_with('[') {
    // rust: err("commands.item.target.no_such_slot.unnamed", &[])
    // rust: } else {
    // rust: err("commands.item.target.no_such_slot", &[&slot_name])
    // rust: },
    // rust: );
}
    // rust: let block = matches!(targets.first(), Some(Owner::Block(_)));
    // rust: let pos = match targets.first() {
    // rust: Some(Owner::Block(p)) => *p,
    // rust: _ => [0; 3],
}
    // rust: let zero = match &known {
    // rust: Some(k) => err(
    // rust: "commands.item.target.failed.known_item",
                // The ItemStack itself is the argument: ItemStack.toString.
    // rust: &[&format!("{} {}", k.count, k.item)],
    // rust: ),
    // rust: None => err("commands.item.target.failed", &[]),
}
    // rust: let name = known.as_ref().map(|k| self.stack_name(k));
    // rust: let (message, total) = tracker.message(
    // rust: false,
    // rust: Some(zero),
    // rust: |h, count| {
    // rust: let n = Text::literal(count.to_string());
    // rust: match (&name, block) {
    // rust: (Some(item), true) => Text::translate(
    // rust: "commands.item.block.replace.success.known_item",
    // rust: &[
    // rust: n,
    // rust: Text::literal(pos[0].to_string()),
    // rust: Text::literal(pos[1].to_string()),
    // rust: Text::literal(pos[2].to_string()),
    // rust: item.clone(),
    // rust: ],
    // rust: ),
    // rust: (None, true) => Text::translate(
    // rust: "commands.item.block.replace.success",
    // rust: &[
    // rust: n,
    // rust: Text::literal(pos[0].to_string()),
    // rust: Text::literal(pos[1].to_string()),
    // rust: Text::literal(pos[2].to_string()),
    // rust: ],
    // rust: ),
    // rust: (Some(item), false) => Text::translate(
    // rust: "commands.item.entity.replace.success.single.known_item",
    // rust: &[n, h.text.clone(), item.clone()],
    // rust: ),
    // rust: (None, false) => Text::translate(
    // rust: "commands.item.entity.replace.success.single",
    // rust: &[n, h.text.clone()],
    // rust: ),
}
    // rust: },
    // rust: |c, _| match &name {
    // rust: Some(item) => Text::translate(
    // rust: "commands.item.entity.replace.success.multiple.known_item",
    // rust: &[Text::literal(c.to_string()), item.clone()],
    // rust: ),
    // rust: None => Text::translate(
    // rust: "commands.item.entity.replace.success.multiple",
    // rust: &[Text::literal(c.to_string())],
    // rust: ),
    // rust: },
    // rust: )?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}
    /// `if items` and `if slots`: how many items match / how many slots.
    // rust: pub(super) fn condition_items(&mut self, c: &Context) -> R<(bool, i32)> {
    // rust: let owners = self.owner_of(c, "source", true)?;
    // rust: let Some(Arg::Str(slot_name)) = c.get("slots").cloned() else {
    // rust: return Ok((false, 0));
}
    // rust: let predicate = match c.get("item_predicate") {
    // rust: Some(Arg::Item(p)) => Some(p.clone()),
    // rust: _ => None,
}
    // rust: let mut count = 0;
    // rust: for o in owners {
    // rust: if let Owner::Block(p) = o
    // rust: && self.block_container_size(p).is_none()
    // rust: {
    // rust: return Err(err(
    // rust: "commands.item.source.not_a_container",
    // rust: &[&p[0], &p[1], &p[2]],
    // rust: ));
}
    // rust: let slots = self.command_slots(&o, &slot_name);
    // rust: if predicate.is_none() {
    // rust: count += slots.len() as i32;
    // rust: continue;
}
    // rust: for s in slots {
    // rust: if let Some(stack) = self.slot_get(&s)
    // rust: && predicate
    // rust: .as_ref()
    // rust: .is_some_and(|p| self.stack_matches(p, &stack))
    // rust: {
    // rust: count += stack.count as i32;
}
}
}
    // rust: Ok((count > 0, count))
}
}

/// Edit a stack's components as their saved compound.
pub fn edit_components(stack: *mut ItemStack, f: impl FnOnce(*mut horizon_world::nbt::Compound) void {
}
    // rust: let mut c = match horizon_client::item_data::encode_components(stack) {
    // rust: Some(Tag::Compound(c)) => c,
    // rust: _ => horizon_world::nbt::Compound::new(),
}
    // rust: f(&mut c);
    // rust: let tag = Tag::Compound(c);
    // rust: let (damage, extra) = horizon_client::item_data::decode_components(Some(&tag));
    // rust: stack.damage = damage;
    // rust: stack.extra = extra;
    // rust: stack.tidy();
}
/// `CompoundTag.merge`: nested compounds merge, other values replace.
pub fn merge_compound(into: *mut Tag, from: *Tag) void {
}
    // rust: let (Tag::Compound(a), Tag::Compound(b)) = (into, from) else {
    // rust: return;
}
    // rust: for (k, v) in b {
    // rust: match (a.get_mut(k), v) {
    // rust: (Some(existing @ Tag::Compound(_)), Tag::Compound(_)) => merge_compound(existing, v),
    // rust: _ => {
    // rust: a.insert(k.clone(), v.clone());
}
}
}
}
/// `ListOperation.apply` (`mode`: replace_all, replace_section, insert,
/// append) with a 256-entry limit.
pub fn list_operation(m: *serde_json::Value, old: std.ArrayList(Tag), new: std.ArrayList(Tag)) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let offset = m["offset"].as_u64().unwrap_or(0) as usize;
    // rust: let mut out = match m["mode"].as_str().unwrap_or("") {
    // rust: "replace_all" => new,
    // rust: "insert" => {
    // rust: let at = offset.min(old.len());
    // rust: let mut out = old[..at].to_vec();
    // rust: out.extend(new);
    // rust: out.extend_from_slice(&old[at..]);
    // rust: out
}
    // rust: "replace_section" => {
    // rust: let at = offset.min(old.len());
    // rust: let size = m["size"].as_u64().map_or(new.len(), |s| s as usize);
    // rust: let mut out = old[..at].to_vec();
    // rust: out.extend(new);
    // rust: let end = (at + size).min(old.len());
    // rust: out.extend_from_slice(&old[end..]);
    // rust: out
}
    // rust: _ => {
    // rust: let mut out = old;
    // rust: out.extend(new);
    // rust: out
}
}
    // rust: out.truncate(256);
    // rust: out
}

    // rust: mod stand_equip_event_tests {
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_client::{chunk::Chunk, containers::BlockEntity, mobs::Who, sculk::Info};
//     use horizon_core::position::ChunkPos;
//     use std::sync::Arc;

pub fn candidate(game: *Game<'_>) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(BlockEntity::Sculk(sensor)) = game.world.block_entities.get(&(9, 200, 10)) else {
    // rust: panic!("actual sensor must be registered")
}
    // rust: sensor.vibration.selector.current.map(|(info, _)| info)
}

pub fn commands_post_stand_equipment_events_after_its_first_tick() void {
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
    // rust: options.game_dir =
    // rust: Some(std::env::temp_dir().join(format!("horizon-h130-unit-{}", std::process::id())));
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
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
    // rust: game.build_registries();
    // rust: game.set_allow_commands(true);
    // rust: let registry = game.pack.assets.registry;
    // rust: let sensor = registry.default_state("minecraft:sculk_sensor").unwrap();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(9, 200, 10, sensor.0);
    // rust: game.world.chunks.insert((0, 0), Arc::new(chunk));
    // rust: game.block_ticks
    // rust: .add_empty_chunk(ChunkPos::new(0, 0))
    // rust: .unwrap();
    // rust: assert!(game.run_command("forceload add 0 0"));
    // rust: assert!(game.run_command("summon armor_stand 6.5 200 10.5 {UUID:[I;130,0,0,1],NoGravity:1b,attributes:[{id:\"minecraft:movement_speed\",base:0.1d}]}"));
    // rust: let id = game.armor_stands[0].id;
    // rust: assert_eq!(game.uuid_for(id), [130, 0, 0, 1]);
    // rust: assert!(
    // rust: game.armor_stands[0].speed_instance,
    // rust: "a loaded attribute is not firstTick"
    // rust: );
    // rust: game.sculk_prepare();
    // rust: game.sculk_sync_index();
    // rust: assert!(candidate(&game).is_none());
    // rust: let prefix = "item replace entity 00000082-0000-0000-0000-000000000001 ";
    // rust: for item in ["iron_helmet", "air"] {
    // rust: assert!(game.run_command(&format!("{prefix}armor.head with {item}")));
    // rust: assert!(candidate(&game).is_none(), "first-tick suppression");
}
    // rust: game.tick_armor_stands().unwrap();
    // rust: assert!(
    // rust: game.run_command(
    // rust: "data merge entity 00000082-0000-0000-0000-000000000001 {ShowArms:1b}"
    // rust: )
    // rust: );
    // rust: for (slot, item, event) in [
    // rust: ("armor.head", "iron_helmet", Some("minecraft:equip")),
    // rust: ("armor.head", "iron_helmet", None),
    // rust: ("armor.head", "air", Some("minecraft:unequip")),
    // rust: ("armor.head", "air", None),
    // rust: ("weapon.mainhand", "stick", Some("minecraft:unequip")),
    // rust: ] {
    // rust: let Some(BlockEntity::Sculk(sensor)) = game.world.block_entities.get_mut(&(9, 200, 10))
    // rust: else {
    // rust: unreachable!()
}
    // rust: sensor.vibration = Default::default();
    // rust: assert!(game.run_command(&format!("{prefix}{slot} with {item}")));
    // rust: let heard = candidate(&game);
    // rust: assert_eq!(heard.map(|info| info.event), event, "{slot} -> {item}");
    // rust: if let Some(info) = heard {
    // rust: assert_eq!(info.source, Some(Who::Mob(id)));
    // rust: assert_eq!(info.pos, [6.5, 200.0, 10.5]);
    // rust: assert!(info.owner.is_none());
}
}
}
}
