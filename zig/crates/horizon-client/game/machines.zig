//! Transpiled from Horizon Rust crate
//! Module: horizon-client_machines
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item-moving blocks: `HopperBlockEntity` (push, pull, item entities,
//! transfer cooldowns), `DispenserBlock` / `DropperBlock.dispenseFrom` with
//! the vanilla dispense behaviours Horizon has entities for, and container
//! comparator signals (`AbstractContainerMenu.getRedstoneSignalFromContainer`).
// use super::{Game, storage::is_shulker_box};

    // rust: mod crafter;
    // rust: pub(in crate::game) mod native_energy;
    // rust: pub(in crate::game) mod native_fluids;
    // rust: pub(in crate::game) mod native_items;
// use horizon_client::{
    // rust: Result,
    // rust: containers::{BlockEntity, HOPPER_SLOTS, ModContainer},
    // rust: items::{ItemStack, Items},
    // rust: world::World,
}
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};
// use horizon_world::{
    // rust: level::{Behaviours, LevelAccess},
    // rust: registry::BlockStateId,
}
// use std::sync::Arc;

    // rust: type Pos = (i32, i32, i32);

/// `HopperBlockEntity` transient state (`TransferCooldown`, `tickedGameTime`).
    // rust: pub(super) struct HopperState {
    // rust: cooldown: i32,
    // rust: ticked: i64,
}
    // rust: impl Default for HopperState {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: cooldown: -1,
    // rust: ticked: 0,
}
}
}

pub const Kind = enum {
    Generic,
    /// `AbstractFurnaceBlockEntity` (a `WorldlyContainer`).
    Furnace,
    Hopper,
    /// `CrafterBlockEntity`: disabled slots and the smallest-stack-first rule.
    Crafter,
    /// `BrewingStandBlockEntity` (a `WorldlyContainer`).
    Brewing,
    /// `ChiseledBookShelfBlockEntity`: books only, one to a slot.
    Bookshelf,
    /// `JukeboxBlockEntity`'s single slot: a playable disc only.
    Jukebox,
    /// A mod block's block entity (`ModContainer`).
    Mod,
    /// `ShulkerBoxBlockEntity`: a shulker box doesn't go through a face into one.
    Shulker,
    /// `ComposterBlock.getContainer` at this level (a `WorldlyContainerHolder`
    /// without a block entity): input below 7, empty at 7, bone meal at 8.
    Composter(i32),
};

/// A container: one block entity, or a double chest (`CompoundContainer`).
pub const View = struct {
    parts: Vec<(Pos,
    kind: Kind,
    /// A mod block's container rules (`Kind::Mod`).
    container: ?*ModContainer,
};
    // rust: impl View {
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.parts.iter().map(|p| p.1).sum()
}
pub fn locate(self: *Self, mut slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for &(pos, size) in &self.parts {
    // rust: if slot < size {
    // rust: return Some((pos, slot));
}
    // rust: slot -= size;
}
    // rust: None
}
    /// `WorldlyContainer.getSlotsForFace` or every slot.
pub fn slots_for_face(self: *Self, face: ?Direction) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (self.kind, face) {
    // rust: (Kind::Furnace, Some(Direction::Down)) => vec![2, 1],
    // rust: (Kind::Furnace, Some(Direction::Up)) => vec![0],
    // rust: (Kind::Furnace, Some(_)) => vec![1],
    // rust: (Kind::Brewing, Some(Direction::Up)) => vec![3],
    // rust: (Kind::Brewing, Some(Direction::Down)) => vec![0, 1, 2, 3],
    // rust: (Kind::Brewing, Some(_)) => vec![0, 1, 2, 4],
    // rust: (Kind::Composter(8), Some(Direction::Down)) => vec![0],
    // rust: (Kind::Composter(level), Some(Direction::Up)) if level < 7 => vec![0],
    // rust: (Kind::Composter(_), _) => vec![],
    // rust: (Kind::Mod, Some(face)) => self
    // rust: .container
    // rust: .as_ref()
    // rust: .map_or_else(Vec::new, |c| c.faces[face as usize].clone()),
    // rust: _ => (0..self.len()).collect(),
}
}
    /// The slots `HopperBlockEntity.addItem` tries through `face`.
pub fn slots_to_add(self: *Self, face: ?Direction) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if matches!(self.kind, Kind::Furnace | Kind::Brewing | Kind::Mod) && face.is_some() {
    // rust: self.slots_for_face(face)
    // rust: } else {
    // rust: (0..self.len()).collect()
}
}
}

    // rust: pub(super) fn dir_from_name(name: &str) -> Option<Direction> {
    // rust: Some(match name {
    // rust: "down" => Direction::Down,
    // rust: "up" => Direction::Up,
    // rust: "north" => Direction::North,
    // rust: "south" => Direction::South,
    // rust: "west" => Direction::West,
    // rust: "east" => Direction::East,
    // rust: _ => return None,
    // rust: })
}
pub fn step(d: Direction) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match d {
    // rust: Direction::Down => [0, -1, 0],
    // rust: Direction::Up => [0, 1, 0],
    // rust: Direction::North => [0, 0, -1],
    // rust: Direction::South => [0, 0, 1],
    // rust: Direction::West => [-1, 0, 0],
    // rust: Direction::East => [1, 0, 0],
}
}
pub fn offset(p: Pos, d: Direction) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = step(d);
    // rust: (p.0 + s[0], p.1 + s[1], p.2 + s[2])
}
/// State-level container queries shared by the game and comparator signals.
pub const Containers = struct {
    world: *'a World,
    behaviours: *'a Behaviours,
    items: *'a Items,
    registry: *'static horizon_world::registry::BlockRegistry,
    /// Brewing recipes, for what a brewing stand accepts (not needed for signals).
    brewing: ?*'a horizon_client::brewing::Brewing,
    /// The stack of a full composter's `OutputContainer`.
    bone_meal: ItemStack,
};
    // rust: impl Containers<'_> {
pub fn prop(self: *Self, state: BlockStateId, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get(key)
    // rust: .map(String::as_str)
}
pub fn name(self: *Self, state: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry.state(state).map_or("", |s| s.name.as_str())
}
    /// `ItemStack.getMaxStackSize`: its component, else the item's.
pub fn max_stack(self: *Self, stack: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(horizon_world::nbt::Tag::Int(n)) = stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:max_stack_size"))
    // rust: {
    // rust: return (*n).clamp(1, 99) as u32;
}
    // rust: self.items
    // rust: .get(&stack.item)
    // rust: .map_or(64, |i| i.max_stack)
    // rust: .max(1)
}
    /// `HopperBlockEntity.getBlockContainer` (double chests combined, right half
    /// first). `blocked_chests`: `ChestBlock.getContainer(.., false)` returns
    /// nothing for a chest under a redstone conductor.
pub fn view(self: *Self, pos: Pos, blocked_chests: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let name = self.name(state);
    // rust: if name == "minecraft:composter" {
    // rust: let level = self.prop(state, "level").and_then(|l| l.parse().ok())?;
    // rust: return Some(View {
    // rust: parts: vec![(pos, usize::from(level != 7))],
    // rust: kind: Kind::Composter(level),
    // rust: container: None,
    // rust: });
}
    // rust: let entity = self.world.block_entities.get(&pos)?;
        // A beehive keeps bees, not items, a campfire cooks its own and
        // suspicious sand or gravel hides its loot: none is a `Container`
        // (HopperBlockEntity.getContainerAt), so a dropper drops in front of
        // them and a hopper leaves them alone.
    // rust: if matches!(
    // rust: entity,
    // rust: BlockEntity::Beehive(_) | BlockEntity::Campfire(_) | BlockEntity::Brushable(_)
    // rust: ) {
    // rust: return None;
}
        // A mod's block entity is a container when its block says so. The one
        // ticking now is out of the world (an empty id marks its place): what
        // went into its place would be lost when it comes back.
    // rust: if let BlockEntity::Mod(m) = entity {
    // rust: if m.id.is_empty() {
    // rust: return None;
}
    // rust: let container = Arc::clone(self.world.block_entities.mod_container(state.0)?);
    // rust: return Some(View {
    // rust: parts: vec![(pos, container.slots)],
    // rust: kind: Kind::Mod,
    // rust: container: Some(container),
    // rust: });
}
    // rust: let kind = match (entity, name) {
    // rust: (BlockEntity::Furnace(_), _) => Kind::Furnace,
    // rust: (BlockEntity::Crafter(_), _) => Kind::Crafter,
    // rust: (BlockEntity::Brewing(_), _) => Kind::Brewing,
    // rust: (BlockEntity::ChiseledBookshelf(_), _) => Kind::Bookshelf,
    // rust: (BlockEntity::Jukebox(_), _) => Kind::Jukebox,
    // rust: (_, "minecraft:hopper") => Kind::Hopper,
    // rust: (_, n) if is_shulker_box(n) => Kind::Shulker,
    // rust: _ => Kind::Generic,
}
    // rust: let size = entity.slots().len();
    // rust: if horizon_client::containers::is_chest_block(name) {
    // rust: let is_blocked = |p: Pos| {
    // rust: let above = self.world.block(p.0, p.1 + 1, p.2);
    // rust: self.behaviours.facts(above).flags
    // rust: & horizon_world::level::data::state_flags::CONDUCTOR
    // rust: != 0
}
    // rust: if blocked_chests && is_blocked(pos) {
    // rust: return None;
}
    // rust: let half = |s: BlockStateId| {
    // rust: Some(horizon_client::containers::ChestHalf {
    // rust: block: self.name(s),
    // rust: kind: self.prop(s, "type")?,
    // rust: facing: self.prop(s, "facing")?,
    // rust: })
}
    // rust: if let Some(own) = half(state)
    // rust: && let Some((dx, dz)) = own.connected_step()
    // rust: {
    // rust: let other = (pos.0 + dx, pos.1, pos.2 + dz);
    // rust: let other_state = self.world.block(other.0, other.1, other.2);
    // rust: let paired = half(other_state).is_some_and(|o| own.pairs_with(&o))
    // rust: && self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&other)
    // rust: .is_some_and(|e| e.slots().len() == 27);
    // rust: if paired {
    // rust: if blocked_chests && is_blocked(other) {
    // rust: return None;
}
    // rust: let parts = if own.kind == "right" {
    // rust: vec![(pos, size), (other, 27)]
    // rust: } else {
    // rust: vec![(other, 27), (pos, size)]
}
    // rust: return Some(View {
    // rust: parts,
    // rust: kind,
    // rust: container: None,
    // rust: });
}
}
}
    // rust: Some(View {
    // rust: parts: vec![(pos, size)],
    // rust: kind,
    // rust: container: None,
    // rust: })
}
pub fn get(self: *Self, view: *View, slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Kind::Composter(level) = view.kind {
            // OutputContainer holds one bone meal; InputContainer composts at once.
    // rust: return (level == 8 && slot == 0).then_some(&self.bone_meal);
}
    // rust: let (pos, i) = view.locate(slot)?;
    // rust: self.world
    // rust: .block_entities
    // rust: .get(&pos)?
    // rust: .slots()
    // rust: .get(i)?
    // rust: .as_ref()
            // A mod can leave an empty stack in its own slots.
    // rust: .filter(|s| s.count > 0)
}
pub fn is_empty(self: *Self, view: *View) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..view.len()).all(|i| self.get(view, i).is_none())
}
    /// `Container.canPlaceItem` (+ `canPlaceItemThroughFace` for furnaces).
pub fn can_place(self: *Self, view: *View, slot: usize, stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(c) = &view.container {
    // rust: return c.inputs.contains(&slot);
}
        // ShulkerBoxBlockEntity.canPlaceItemThroughFace
    // rust: if view.kind == Kind::Shulker {
    // rust: return !is_shulker_box(&stack.item);
}
    // rust: if view.kind == Kind::Crafter {
    // rust: return match self.world.block_entities.get(&view.parts[0].0) {
    // rust: Some(BlockEntity::Crafter(c)) => {
                    // The slot's own stack sets the limit (`slotStack.getMaxStackSize`).
    // rust: let max = c.items.get(slot).and_then(Option::as_ref).unwrap_or(stack);
    // rust: c.can_place(slot, stack, self.max_stack(max))
}
    // rust: _ => false,
}
}
    // rust: if view.kind == Kind::Jukebox {
            // JukeboxBlockEntity.canPlaceItem: a playable disc, into the one
            // slot, which has to be empty first (its maximum stack is 1).
    // rust: return self
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.jukebox_song.is_some())
    // rust: && self.get(view, slot).is_none();
}
    // rust: if view.kind == Kind::Bookshelf {
            // ListBackedContainer.canPlaceItem: `acceptsItemType` (the books)
            // and a free slot, as `getMaxStackSize` is 1.
    // rust: return self
    // rust: .items
    // rust: .item_tags
    // rust: .get("minecraft:bookshelf_books")
    // rust: .is_some_and(|m| m.contains(&*stack.item))
    // rust: && self.get(view, slot).is_none();
}
    // rust: if view.kind == Kind::Brewing {
            // BrewingStandBlockEntity.canPlaceItem
    // rust: return match slot {
    // rust: 4 => self
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.brewing_fuel.is_some()),
    // rust: 3 => self.brewing.is_some_and(|b| b.is_reagent(stack)),
    // rust: _ => {
    // rust: let input = self.brewing.is_some_and(|b| b.is_bottle(stack))
    // rust: || self
    // rust: .items
    // rust: .item_tags
    // rust: .get("minecraft:brewing_potion_inputs")
    // rust: .is_some_and(|m| m.contains(&*stack.item));
    // rust: input && self.get(view, slot).is_none()
}
}
}
    // rust: if view.kind != Kind::Furnace {
    // rust: return true;
}
    // rust: match slot {
    // rust: 2 => false,
    // rust: 1 => {
    // rust: let fuel = self
    // rust: .items
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.fuel.is_some());
    // rust: let current_bucket = self
    // rust: .get(view, 1)
    // rust: .is_some_and(|s| &*s.item == "minecraft:bucket");
    // rust: fuel || (&*stack.item == "minecraft:bucket" && !current_bucket)
}
    // rust: _ => true,
}
}
    /// `canTakeItemThroughFace` (furnaces and brewing stands restrict it).
pub fn can_take(self: *Self, view: *View, slot: usize, stack: *ItemStack, face: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Kind::Composter(level) = view.kind {
            // OutputContainer.canTakeItemThroughFace.
    // rust: return level == 8 && face == Direction::Down && &*stack.item == "minecraft:bone_meal";
}
    // rust: if view.kind == Kind::Brewing {
    // rust: return slot != 3 || &*stack.item == "minecraft:glass_bottle";
}
    // rust: if let Some(c) = &view.container {
    // rust: return c.outputs.contains(&slot);
}
    // rust: view.kind != Kind::Furnace
    // rust: || face != Direction::Down
    // rust: || slot != 1
    // rust: || matches!(&*stack.item, "minecraft:water_bucket" | "minecraft:bucket")
}
    /// `HopperBlockEntity.isFullContainer`.
pub fn is_full(self: *Self, view: *View, face: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: view.slots_for_face(Some(face)).into_iter().all(|i| {
    // rust: self.get(view, i)
    // rust: .is_some_and(|s| s.count >= self.max_stack(s))
    // rust: })
}
    /// `AbstractContainerMenu.getRedstoneSignalFromContainer`.
pub fn signal(self: *Self, view: *View) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if view.kind == Kind::Crafter {
            // CrafterBlockEntity.getRedstoneSignal: filled or disabled slots.
    // rust: return match self.world.block_entities.get(&view.parts[0].0) {
    // rust: Some(BlockEntity::Crafter(c)) => c.redstone_signal(),
    // rust: _ => 0,
}
}
    // rust: let mut total = 0.0f32;
    // rust: for i in 0..view.len() {
    // rust: if let Some(s) = self.get(view, i) {
    // rust: total += s.count as f32 / self.max_stack(s) as f32;
}
}
    // rust: total /= view.len().max(1) as f32;
        // Mth.lerpDiscrete(total, 0, 15). A mod can write a stack over its own
        // limit, so the ratio itself is clamped, as vanilla's invariant does.
    // rust: (total.min(1.0) * 14.0).floor() as i32 + i32::from(total > 0.0)
}
}

/// The block columns any item entity's box reaches, so that a hopper with
/// no item over it skips the scan of every item. Kept for one block-entity
/// pass, in which items do not move: removing one leaves a superset, still
/// right, and adding one (always pushed at the end, under a new id) or
/// removing the last rebuilds the columns.
    // rust: pub(super) struct ItemColumns {
    /// The item count and last item id when last asked, if built.
    // rust: seen: Option<(usize, Option<u32>)>,
    // rust: cells: horizon_client::fast_hash::FxHashSet<(i32, i32)>,
}
    // rust: impl ItemColumns {
    /// Whether an item's box may reach into column (x, z).
    // rust: fn may_reach(
    // rust: &mut self,
    // rust: items: &[horizon_client::entities::ItemEntity],
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> bool {
    // rust: let (len, last) = (items.len(), items.last().map(|i| i.id));
    // rust: let stale = self
    // rust: .seen
    // rust: .is_none_or(|(seen_len, seen_last)| len > seen_len || last != seen_last);
    // rust: self.seen = Some((len, last));
    // rust: if stale {
    // rust: self.cells.clear();
    // rust: for item in items {
    // rust: let b = item.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for cx in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for cz in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: self.cells.insert((cx, cz));
}
}
}
}
    // rust: self.cells.contains(&(x, z))
}
}

pub fn bone_meal() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack {
    // rust: item: "minecraft:bone_meal".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
}

/// Comparator input from a container block entity (0 when there is none).
    // rust: pub(super) fn container_signal(
    // rust: world: &World,
    // rust: behaviours: &Behaviours,
    // rust: items: &Items,
    // rust: registry: &'static horizon_world::registry::BlockRegistry,
    // rust: pos: BlockPos,
    // rust: ) -> i32 {
    // rust: let c = Containers {
    // rust: world,
    // rust: behaviours,
    // rust: items,
    // rust: registry,
    // rust: brewing: None,
    // rust: bone_meal: bone_meal(),
}
    // rust: c.view((pos.x, pos.y, pos.z), true)
    // rust: .filter(|v| !matches!(v.kind, Kind::Composter(_)))
    // rust: .map_or(0, |v| c.signal(&v))
}

/// `ChiseledBookShelfBlock.getAnalogOutputSignal` and
/// `ShelfBlock.getAnalogOutputSignal`, from the block entity Horizon keeps as
/// it was loaded; `None` for any other block. `direction` points from the
/// block to the comparator.
    // rust: pub(super) fn shelf_signal(
    // rust: world: &World,
    // rust: registry: &'static horizon_world::registry::BlockRegistry,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> Option<i32> {
    // rust: let info = registry.state(state)?;
    // rust: let chiseled = info.name == "minecraft:chiseled_bookshelf";
    // rust: if !chiseled && !info.name.ends_with("_shelf") {
    // rust: return None;
}
    // rust: if chiseled {
        // The last slot touched, plus one (`lastInteractedSlot` starts at -1).
    // rust: return Some(match world.block_entities.get(&(pos.x, pos.y, pos.z)) {
    // rust: Some(BlockEntity::ChiseledBookshelf(b)) => b.last_slot + 1,
    // rust: _ => 0,
    // rust: });
}
    // Only read from the back: a bit for each of the three slots in use.
    // rust: let facing = info.properties.get("facing").and_then(|f| dir_from_name(f));
    // rust: if facing.map(Direction::opposite) != Some(direction) {
    // rust: return Some(0);
}
    // rust: let Some(BlockEntity::Shelf(shelf)) = world.block_entities.get(&(pos.x, pos.y, pos.z)) else {
    // rust: return Some(0);
}
    // rust: Some(
    // rust: shelf
    // rust: .items
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(slot, item)| i32::from(item.is_some()) << slot)
    // rust: .sum(),
    // rust: )
}

    // rust: impl Game<'_> {
pub fn containers(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Containers {
    // rust: world: &self.world,
    // rust: behaviours: self.res.behaviours(),
    // rust: items: self.items(),
    // rust: registry: self.pack.assets.registry,
    // rust: brewing: Some(&self.stations().brewing),
    // rust: bone_meal: bone_meal(),
}
}
    // rust: pub(super) fn block_can_place(&self, pos: [i32; 3], slot: usize, stack: &ItemStack) -> bool {
    // rust: let containers = self.containers();
    // rust: let Some(view) = containers.view((pos[0], pos[1], pos[2]), false) else {
    // rust: return false;
}
    // rust: view.kind == Kind::Shulker || containers.can_place(&view, slot, stack)
}
pub fn slot_mut_at(self: *Self, view: *View, slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (pos, i) = view.locate(slot)?;
    // rust: let entity = self.world.block_entities.get_mut(&pos)?;
        // A mod's slots grow to its container's count when first used.
    // rust: if let BlockEntity::Mod(m) = entity
    // rust: && m.items.len() <= i
    // rust: {
    // rust: m.items.resize(view.len(), None);
}
    // rust: entity.slots_mut().get_mut(i)
}
    /// `BlockEntity.setChanged` for every block entity of a container.
pub fn view_changed(self: *Self, view: *View) void {
}
        // A composter's containers change its block state instead.
    // rust: if let Kind::Composter(_) = view.kind {
    // rust: return;
}
    // rust: for &(pos, _) in &view.parts {
    // rust: self.container_changed(pos);
}
}
    /// `BlockEntity.setChanged` at `pos`: comparators re-read the container.
    // rust: pub(super) fn container_changed(&mut self, pos: Pos) {
    // rust: if pos.1 == super::minecarts::CART_KEY_Y {
    // rust: return;
}
    // rust: self.chiseled_bookshelf_synced(pos);
    // rust: if matches!(
    // rust: self.world.block_entities.get(&pos),
    // rust: Some(BlockEntity::Shelf(_))
    // rust: ) {
    // rust: self.mark_block_entity_updated(pos);
}
        // A double chest's other half changes with it.
    // rust: let halves: Vec<Pos> = std::iter::once(pos)
    // rust: .chain(self.chest_other_half(pos))
    // rust: .collect();
    // rust: for pos in halves {
    // rust: self.world.modified.insert((pos.0 >> 4, pos.2 >> 4));
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.container_changed(level, ticks, BlockPos::new(pos.0, pos.1, pos.2))
    // rust: });
}
}
    /// `IItemHandler.isItemValid` for a mod's container: the mods' say
    /// (`native_container_accepts`) on `stack` in `slot`, once its
    /// `ModContainer` lets the slot be filled. Any other container: true.
    // rust: fn mod_container_accepts(
    // rust: &self,
    // rust: view: &View,
    // rust: slot: usize,
    // rust: stack: &ItemStack,
    // rust: face: Option<Direction>,
    // rust: ) -> bool {
    // rust: if view.kind != Kind::Mod {
    // rust: return true;
}
    // rust: let Some((pos, i)) = view.locate(slot) else {
    // rust: return false;
}
    // rust: let Some(BlockEntity::Mod(entity)) = self.world.block_entities.get(&pos) else {
    // rust: return false;
}
    // rust: let mut cancel = false;
    // rust: self.native_container_accepts([pos.0, pos.1, pos.2], entity, i, stack, face, &mut cancel);
    // rust: !cancel
}
    /// `HopperBlockEntity.tryMoveInItem`.
    // rust: fn try_move_in_item(
    // rust: &mut self,
    // rust: from_hopper: Option<Pos>,
    // rust: view: &View,
    // rust: stack: ItemStack,
    // rust: slot: usize,
    // rust: face: Option<Direction>,
    // rust: ) -> Option<ItemStack> {
    // rust: let (rest, moved) = self.move_in_item(from_hopper, view, stack, slot, face);
    // rust: if moved {
    // rust: self.view_changed(view);
            // JukeboxBlockEntity.setTheItem through a hopper's or a dropper's
            // transfer: the disc it lands on starts playing.
    // rust: if view.kind == Kind::Jukebox {
    // rust: let (x, y, z) = view.parts[0].0;
    // rust: self.jukebox_inserted([x, y, z]);
}
}
    // rust: rest
}
    /// `tryMoveInItem` before its `setChanged`: the remainder, and whether
    /// anything moved. `face` is the side it goes in by, for a mod's say.
    // rust: fn move_in_item(
    // rust: &mut self,
    // rust: from_hopper: Option<Pos>,
    // rust: view: &View,
    // rust: mut stack: ItemStack,
    // rust: slot: usize,
    // rust: face: Option<Direction>,
    // rust: ) -> (Option<ItemStack>, bool) {
    // rust: let c = self.containers();
    // rust: if !c.can_place(view, slot, &stack) || !self.mod_container_accepts(view, slot, &stack, face)
    // rust: {
    // rust: return (Some(stack), false);
}
    // rust: let was_empty = c.is_empty(view);
    // rust: let max = c.max_stack(&stack);
    // rust: let mut success = false;
    // rust: let Some(target) = self.slot_mut_at(view, slot) else {
    // rust: return (Some(stack), false);
}
        // An empty stack a mod left in its slot: the slot is free (`isEmpty`).
    // rust: if target.as_ref().is_some_and(|s| s.count == 0) {
    // rust: *target = None;
}
    // rust: match target {
    // rust: None => {
                // HopperBlockEntity.setItem limits the accepted stack, then
                // tryMoveInItem consumes the input even when it exceeded that limit.
    // rust: *target = Some(ItemStack {
    // rust: count: stack.count.min(max),
    // rust: ..stack.clone()
    // rust: });
    // rust: stack.count = 0;
    // rust: success = true;
}
    // rust: Some(current)
                // HopperBlockEntity.canMergeItems
    // rust: if current.count <= max && current.same_item_same_components(&stack) =>
    // rust: {
    // rust: let space = max.saturating_sub(current.count);
    // rust: let count = stack.count.min(space);
    // rust: stack.count -= count;
    // rust: current.count += count;
    // rust: success = count > 0;
}
    // rust: Some(_) => {}
}
    // rust: if success && was_empty && view.kind == Kind::Hopper {
    // rust: let dest = view.parts[0].0;
    // rust: let from_ticked = from_hopper.and_then(|p| self.hoppers.get(&p).map(|h| h.ticked));
    // rust: let state = self.hoppers.entry(dest).or_default();
    // rust: if state.cooldown <= 8 {
    // rust: let skip = i32::from(from_ticked.is_some_and(|t| state.ticked >= t));
    // rust: state.cooldown = 8 - skip;
}
}
    // rust: ((stack.count > 0).then_some(stack), success)
}
    /// `HopperBlockEntity.addItem(from, container, stack, direction)`; the remainder.
    // rust: fn add_item(
    // rust: &mut self,
    // rust: from_hopper: Option<Pos>,
    // rust: view: &View,
    // rust: stack: ItemStack,
    // rust: face: Option<Direction>,
    // rust: ) -> Option<ItemStack> {
    // rust: if let Kind::Composter(_) = view.kind {
    // rust: let (x, y, z) = view.parts[0].0;
    // rust: return self.composter_container_insert([x, y, z], stack, face == Some(Direction::Up));
}
    // rust: let mut rest = Some(stack);
    // rust: for slot in view.slots_to_add(face) {
    // rust: let Some(stack) = rest.take() else { break };
    // rust: rest = self.try_move_in_item(from_hopper, view, stack, slot, face);
}
    // rust: rest
}
    /// Remove one item from a slot (`removeItem(slot, 1)`).
pub fn take_one(self: *Self, view: *View, slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let target = self.slot_mut_at(view, slot)?;
    // rust: let current = target.as_mut().filter(|s| s.count > 0)?;
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..current.clone()
}
    // rust: current.count -= 1;
    // rust: if current.count == 0 {
    // rust: *target = None;
}
    // rust: Some(one)
}
    /// Undo `take_one` after a failed move.
pub fn put_back(self: *Self, view: *View, slot: usize, one: ItemStack) void {
}
    // rust: if let Some(target) = self.slot_mut_at(view, slot) {
    // rust: match target {
    // rust: Some(current) => current.count += one.count,
    // rust: None => *target = Some(one),
}
}
}
    /// `HopperBlockEntity.pushItemsTick` of the hopper at `pos`, if its block
    /// is still a hopper (`BlockEntityType.isValid`).
    // rust: pub(super) fn tick_hopper(&mut self, pos: Pos) {
    // rust: let time = self.world.game_time;
    // rust: let waiting = {
    // rust: let state = self.hoppers.entry(pos).or_default();
    // rust: state.cooldown -= 1;
    // rust: state.ticked = time;
    // rust: state.cooldown > 0
}
    // rust: if waiting {
    // rust: return;
}
        // Most ticks only advance the cooldown: the block is checked when the
        // hopper is about to move, not on every tick it waits.
    // rust: let hopper = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos.0, pos.1, pos.2))
    // rust: .name
    // rust: .as_ref()
    // rust: == "minecraft:hopper";
    // rust: if !hopper {
    // rust: self.hoppers.remove(&pos);
    // rust: return;
}
    // rust: if let Some(state) = self.hoppers.get_mut(&pos) {
    // rust: state.cooldown = 0;
}
    // rust: self.hopper_try_move_items(pos);
}
    /// Drops the cooldowns of hoppers whose block entity is gone.
    // rust: pub(super) fn forget_gone_hoppers(&mut self) {
    // rust: let entities = &self.world.block_entities;
    // rust: self.hoppers.retain(|p, _| {
    // rust: matches!(entities.get(p), Some(BlockEntity::Chest(items)) if items.len() == HOPPER_SLOTS)
    // rust: });
}
    /// `HopperBlockEntity.tryMoveItems` with `suckInItems`.
    // rust: pub(super) fn hopper_try_move_items(&mut self, pos: Pos) {
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let c = self.containers();
    // rust: let enabled = c.prop(state, "enabled") != Some("false");
    // rust: let Some(view) = c.view(pos, false) else {
    // rust: return;
}
    // rust: if self.hoppers.get(&pos).is_some_and(|h| h.cooldown > 0) || !enabled {
    // rust: return;
}
    // rust: self.native_prepare_hopper_transfer([pos.0, pos.1, pos.2]);
    // rust: let mut changed = false;
    // rust: if !c.is_empty(&view) {
    // rust: changed = self.hopper_eject(pos, &view);
}
    // rust: let c = self.containers();
    // rust: let full =
    // rust: (0..view.len()).all(|i| c.get(&view, i).is_some_and(|s| s.count == c.max_stack(s)));
    // rust: if !full {
    // rust: changed |= self.hopper_suck(pos, &view);
}
    // rust: if changed {
    // rust: self.hoppers.entry(pos).or_default().cooldown = 8;
    // rust: self.container_changed(pos);
}
}
    /// `HopperBlockEntity.entityInside` for the item entities that moved this
    /// tick: an item whose box meets the hopper's bowl (`Hopper.INSIDE`) and
    /// its suck area runs `tryMoveItems` with that item as the pickup, in the
    /// entity phase, before the hopper's own tick counts its cooldown down.
    // rust: pub(super) fn hoppers_catch_items(&mut self) {
    // rust: let mut i = 0;
    // rust: while i < self.dropped.len() {
    // rust: let item = &self.dropped[i];
            // `ItemEntity.tick` moves 1 of 4 ticks while resting;
            // `checkInsideBlocks` only follows a move.
    // rust: let moved = item.position != item.previous
    // rust: || item.ticks.wrapping_add(item.id).is_multiple_of(4);
    // rust: if !moved || item.stack.count == 0 {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let b = item.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let mut found = None;
    // rust: 'blocks: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: let state = self.world.block(x, y, z);
    // rust: if self.res.facts().get(state).name.as_ref() != "minecraft:hopper" {
    // rust: continue;
}
                        // Hopper.INSIDE: the bowl, 2..14 wide and from 11/16 up.
    // rust: let (fx, fy, fz) = (f64::from(x), f64::from(y), f64::from(z));
    // rust: if lo.x < fx + 0.875
    // rust: && hi.x > fx + 0.125
    // rust: && lo.y < fy + 1.0
    // rust: && hi.y > fy + 11.0 / 16.0
    // rust: && lo.z < fz + 0.875
    // rust: && hi.z > fz + 0.125
    // rust: {
    // rust: found = Some((x, y, z));
    // rust: break 'blocks;
}
}
}
}
    // rust: let Some(pos) = found else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: if self.hopper_take_item(pos, i) {
    // rust: continue; // the item left the list; `i` is the next one
}
    // rust: i += 1;
}
}
    /// `tryMoveItems(…, () -> addItem(hopper, itemEntity))`; true when the
    /// item entity was taken whole.
pub fn hopper_take_item(self: *Self, pos: Pos, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let c = self.containers();
    // rust: let Some(view) = c.view(pos, false) else {
    // rust: return false;
}
    // rust: if c.prop(state, "enabled") == Some("false")
    // rust: || self.hoppers.get(&pos).is_some_and(|h| h.cooldown > 0)
    // rust: {
    // rust: return false;
}
    // rust: let mut changed = false;
    // rust: if !c.is_empty(&view) {
    // rust: changed = self.hopper_eject(pos, &view);
}
    // rust: let c = self.containers();
    // rust: let full =
    // rust: (0..view.len()).all(|n| c.get(&view, n).is_some_and(|s| s.count == c.max_stack(s)));
    // rust: let mut taken = false;
    // rust: if !full {
    // rust: let stack = self.dropped[i].stack.clone();
    // rust: let allowed = self.with_level(|_, level, _| {
    // rust: level.allow_hopper_pickup_item(
    // rust: BlockPos::new(pos.0, pos.1, pos.2),
    // rust: &stack.item,
    // rust: stack.count,
    // rust: )
    // rust: });
    // rust: match allowed
    // rust: .then(|| self.add_item(None, &view, stack, None))
    // rust: .flatten()
    // rust: {
    // rust: None if !allowed => {}
    // rust: None => {
    // rust: self.remove_dropped(i);
    // rust: taken = true;
    // rust: changed = true;
}
    // rust: Some(rest) => self.dropped[i].stack = rest,
}
}
    // rust: if changed {
    // rust: self.hoppers.entry(pos).or_default().cooldown = 8;
    // rust: self.container_changed(pos);
}
    // rust: taken
}
    /// `HopperBlockEntity.ejectItems`: into the block container in front, else
    /// a container entity there (`getContainerAt`).
pub fn hopper_eject(self: *Self, pos: Pos, hopper: *View) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let c = self.containers();
    // rust: let Some(facing) = c.prop(state, "facing").and_then(dir_from_name) else {
    // rust: return false;
}
    // rust: let front = offset(pos, facing);
    // rust: let face = facing.opposite();
    // rust: if let Some(target) = c.view(front, false) {
    // rust: self.native_hopper_inventory_search(
    // rust: [pos.0, pos.1, pos.2],
    // rust: Some([front.0, front.1, front.2]),
    // rust: None,
    // rust: );
    // rust: return self.eject_into(pos, hopper, &target, face);
}
    // rust: let Some(id) = self.entity_container_at([
    // rust: f64::from(front.0) + 0.5,
    // rust: f64::from(front.1) + 0.5,
    // rust: f64::from(front.2) + 0.5,
    // rust: ]) else {
    // rust: return false;
}
    // rust: self.native_hopper_inventory_search([pos.0, pos.1, pos.2], None, Some(id));
    // rust: self.with_entity_container(id, |g, target| g.eject_into(pos, hopper, target, face))
    // rust: .unwrap_or(false)
}
    /// Where a container is in the world for the mods: its block, or the block a chest
    /// boat or minecart is in (its view sits under a placeholder key).
pub fn container_world_pos(self: *Self, view: *View) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, z) = view.parts[0].0;
    // rust: if x == i32::MAX - 15 && y == super::minecarts::CART_KEY_Y {
    // rust: let id = z as u32;
    // rust: let at = self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| c.position)
    // rust: .or_else(|| self.boats.iter().find(|b| b.id == id).map(|b| b.position));
    // rust: if let Some(p) = at {
    // rust: return [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
}
}
    // rust: [x, y, z]
}
    /// `InventoryMoveItemEvent` for the item in `slot` of `holder` going from `source` to
    /// `destination`: whether a mod canceled the move. Nothing is looked up with no mod loaded.
    // rust: fn hopper_move_canceled(
    // rust: &self,
    // rust: holder: &View,
    // rust: slot: usize,
    // rust: source: &View,
    // rust: destination: &View,
    // rust: ) -> bool {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return false;
}
    // rust: let containers = self.containers();
    // rust: let Some(stack) = containers.get(holder, slot) else {
    // rust: return false;
}
    // rust: let mut cancel = false;
    // rust: self.native_inventory_move_item(
    // rust: self.container_world_pos(source),
    // rust: self.container_world_pos(destination),
    // rust: &stack.item,
    // rust: &mut cancel,
    // rust: );
    // rust: cancel
}
    /// The rest of `HopperBlockEntity.ejectItems`: one item into `target`.
pub fn eject_into(self: *Self, pos: Pos, hopper: *View, target: *View, face: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.containers().is_full(target, face) {
    // rust: return false;
}
    // rust: for slot in 0..hopper.len() {
    // rust: if self.hopper_move_canceled(hopper, slot, hopper, target) {
    // rust: continue;
}
    // rust: let Some(one) = self.take_one(hopper, slot) else {
    // rust: continue;
}
    // rust: match self.add_item(Some(pos), target, one, Some(face)) {
    // rust: None => {
    // rust: self.view_changed(target);
    // rust: return true;
}
    // rust: Some(rest) => self.put_back(hopper, slot, rest),
}
}
    // rust: false
}
    /// `HopperBlockEntity.suckInItems`: from the container above, or item entities.
pub fn hopper_suck(self: *Self, pos: Pos, hopper: *View) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let above = (pos.0, pos.1 + 1, pos.2);
    // rust: let at = [
    // rust: f64::from(pos.0) + 0.5,
    // rust: f64::from(pos.1) + 1.5,
    // rust: f64::from(pos.2) + 0.5,
    // rust: ];
    // rust: if let Some(took) = self.suck_from_container(above, at, hopper) {
    // rust: return took;
}
    // rust: let above_state = self.world.block(above.0, above.1, above.2);
    // rust: let blocked = self.res.facts().get(above_state).full_collision
    // rust: && !self
    // rust: .res
    // rust: .behaviours()
    // rust: .tag("minecraft:does_not_block_hoppers")
    // rust: .is_some_and(|t| t.contains(self.res.behaviours().block(above_state)));
    // rust: if blocked {
    // rust: return false;
}
        // Hopper.SUCK_AABB: the hopper bowl and the block above.
    // rust: let (min, max) = (
    // rust: [
    // rust: f64::from(pos.0),
    // rust: f64::from(pos.1) + 11.0 / 16.0,
    // rust: f64::from(pos.2),
    // rust: ],
    // rust: [
    // rust: f64::from(pos.0) + 1.0,
    // rust: f64::from(pos.1) + 2.0,
    // rust: f64::from(pos.2) + 1.0,
    // rust: ],
    // rust: );
    // rust: if let Some(columns) = self.item_columns.as_mut()
    // rust: && !columns.may_reach(&self.dropped, pos.0, pos.2)
    // rust: {
    // rust: return false;
}
    // rust: self.suck_item_entities(Some(pos), hopper, min, max)
}
    /// The container half of `HopperBlockEntity.suckInItems`: one item from the
    /// container at `above`, through its bottom face; with no block container
    /// there, from a container entity whose box meets the one around `at`
    /// (`getSourceContainerOrHandler`). `None` when there is no container.
pub fn suck_from_container(self: *Self, above: Pos, at: [f64; 3], hopper: *View) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = self.containers();
    // rust: let Some(source) = c.view(above, false) else {
    // rust: let id = self.entity_container_at(at)?;
    // rust: self.native_hopper_inventory_search(
    // rust: [
    // rust: hopper.parts[0].0.0,
    // rust: hopper.parts[0].0.1,
    // rust: hopper.parts[0].0.2,
    // rust: ],
    // rust: None,
    // rust: Some(id),
    // rust: );
    // rust: return self
    // rust: .with_entity_container(id, |g, source| g.suck_from_slots(None, source, hopper));
}
    // rust: self.native_hopper_inventory_search(
    // rust: [
    // rust: hopper.parts[0].0.0,
    // rust: hopper.parts[0].0.1,
    // rust: hopper.parts[0].0.2,
    // rust: ],
    // rust: Some([above.0, above.1, above.2]),
    // rust: None,
    // rust: );
    // rust: if let Kind::Composter(level) = source.kind {
    // rust: if level != 8 {
    // rust: return Some(false);
}
            // tryTakeInItemFromSlot on the OutputContainer: removeItem calls
            // its setChanged, which empties the composter, and so does the
            // second setChanged after the move or, when the hopper has no
            // room, the setItem putting the bone meal back into the detached
            // container (whose bone meal is lost with it).
    // rust: let bone_meal = c.bone_meal.clone();
    // rust: if !horizon_client::mod_api::mods().is_empty() {
    // rust: let mut cancel = false;
    // rust: self.native_inventory_move_item(
    // rust: [above.0, above.1, above.2],
    // rust: self.container_world_pos(hopper),
    // rust: &bone_meal.item,
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: return Some(false);
}
}
    // rust: let at = BlockPos::new(above.0, above.1, above.2);
    // rust: self.with_level(|b, level, ticks| b.composter_empty(level, ticks, at));
    // rust: let moved = self.add_item(None, hopper, bone_meal, None).is_none();
    // rust: self.with_level(|b, level, ticks| b.composter_empty(level, ticks, at));
    // rust: self.world.modified.insert((above.0 >> 4, above.2 >> 4));
    // rust: return Some(moved);
}
    // rust: let source_hopper = (source.kind == Kind::Hopper).then_some(above);
    // rust: Some(self.suck_from_slots(source_hopper, &source, hopper))
}
    /// `HopperBlockEntity.tryTakeInItemFromSlot` over the `DOWN` face of `source`.
    // rust: fn suck_from_slots(
    // rust: &mut self,
    // rust: source_hopper: Option<Pos>,
    // rust: source: &View,
    // rust: hopper: &View,
    // rust: ) -> bool {
    // rust: for slot in source.slots_for_face(Some(Direction::Down)) {
    // rust: let c = self.containers();
    // rust: let Some(stack) = c.get(source, slot) else {
    // rust: continue;
}
    // rust: if !c.can_take(source, slot, stack, Direction::Down) {
    // rust: continue;
}
    // rust: if self.hopper_move_canceled(source, slot, source, hopper) {
    // rust: continue;
}
    // rust: let Some(one) = self.take_one(source, slot) else {
    // rust: continue;
}
    // rust: match self.add_item(source_hopper, hopper, one, None) {
    // rust: None => {
    // rust: self.view_changed(source);
                    // JukeboxBlockEntity.removeItem -> setTheItem(EMPTY): a
                    // disc a hopper takes out stops the song.
    // rust: if source.kind == Kind::Jukebox {
    // rust: let (x, y, z) = source.parts[0].0;
    // rust: self.jukebox_taken([x, y, z]);
}
    // rust: return true;
}
    // rust: Some(rest) => self.put_back(source, slot, rest),
}
}
    // rust: false
}
    /// `HopperBlockEntity.getEntityContainer`: one of the alive container
    /// entities (`EntitySelector.CONTAINER_ENTITY_SELECTOR`: chest and hopper
    /// minecarts, chest boats) whose box meets the 1x1x1 box around `at`,
    /// picked at random.
pub fn entity_container_at(self: *Self, at: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let meets = |b: horizon_core::geometry::Aabb| {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: lo.x < at[0] + 0.5
    // rust: && hi.x > at[0] - 0.5
    // rust: && lo.y < at[1] + 0.5
    // rust: && hi.y > at[1] - 0.5
    // rust: && lo.z < at[2] + 0.5
    // rust: && hi.z > at[2] - 0.5
}
    // rust: let mut found: Vec<u32> = self
    // rust: .carts
    // rust: .iter()
    // rust: .filter(|c| {
    // rust: matches!(
    // rust: c.kind,
    // rust: super::minecarts::CartKind::Chest | super::minecarts::CartKind::Hopper
    // rust: ) && meets(c.bounds())
    // rust: })
    // rust: .map(|c| c.id)
    // rust: .collect();
    // rust: found.extend(
    // rust: self.boats
    // rust: .iter()
    // rust: .filter(|b| b.chest && meets(b.bounds()))
    // rust: .map(|b| b.id),
    // rust: );
    // rust: if found.is_empty() {
    // rust: return None;
}
    // rust: let pick = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(found.len() as i32)
    // rust: .unwrap_or(0);
    // rust: found.get(pick as usize).copied()
}
    /// Runs `f` on a container entity's items as a container, under the
    /// placeholder key its menu uses (the open menu's copy when it is open),
    /// then hands the items back to the entity.
    // rust: fn with_entity_container<R>(
    // rust: &mut self,
    // rust: id: u32,
    // rust: f: impl FnOnce(&mut Self, &View) -> R,
    // rust: ) -> Option<R> {
    // rust: let mut items = if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
    // rust: std::mem::take(&mut c.items)
    // rust: } else {
    // rust: std::mem::take(&mut self.boats.iter_mut().find(|b| b.id == id)?.items)
}
    // rust: let key = (i32::MAX - 15, super::minecarts::CART_KEY_Y, id as i32);
    // rust: let (view, open) = self.lend_items(key, &mut items);
    // rust: let result = f(self, &view);
    // rust: self.reclaim_items(key, open, &mut items);
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
    // rust: c.items = items;
    // rust: } else if let Some(b) = self.boats.iter_mut().find(|b| b.id == id) {
    // rust: b.items = items;
}
    // rust: Some(result)
}
    /// A vehicle's slots as a container under its placeholder `key`. When its
    /// menu is open the placeholder is the live copy and stays as it is.
    /// Returns the view and whether the menu was open.
pub fn lend_items(self: *Self, key: Pos, items: *mut std.ArrayList(?ItemStack)) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let open = self.world.block_entities.contains_key(&key);
    // rust: if !open {
    // rust: let slots = BlockEntity::Chest(std::mem::take(items));
    // rust: self.world.block_entities.insert(key, slots);
}
    // rust: let size = self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&key)
    // rust: .map_or(0, |e| e.slots().len());
    // rust: let view = View {
    // rust: parts: vec![(key, size)],
    // rust: kind: Kind::Generic,
    // rust: container: None,
}
    // rust: (view, open)
}
    /// Gives `lend_items`' slots back to the vehicle, so its own items stay
    /// the one source of truth: a menu copy that is still around (open, or
    /// left by a guest's close) gets the changed items copied to `items`.
pub fn reclaim_items(self: *Self, key: Pos, open: bool, items: *mut std.ArrayList(?ItemStack)) void {
}
    // rust: let slots = if open {
    // rust: self.world.block_entities.get(&key).cloned()
    // rust: } else {
    // rust: self.world.block_entities.remove(&key)
}
    // rust: if let Some(BlockEntity::Chest(slots)) = slots {
    // rust: *items = slots;
}
}
    /// The item half of `HopperBlockEntity.suckInItems` (`getItemsAtAndAbove`):
    /// adds the item entities that meet the box, until one is taken whole.
    // rust: fn suck_item_entities(
    // rust: &mut self,
    // rust: hopper_pos: Option<Pos>,
    // rust: hopper: &View,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: ) -> bool {
    // rust: let mut i = 0;
    // rust: while i < self.dropped.len() {
    // rust: let b = self.dropped[i].bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let inside = lo.x < max[0]
    // rust: && hi.x > min[0]
    // rust: && lo.y < max[1]
    // rust: && hi.y > min[1]
    // rust: && lo.z < max[2]
    // rust: && hi.z > min[2];
    // rust: if inside {
    // rust: let stack = self.dropped[i].stack.clone();
    // rust: let allowed = hopper_pos.is_none_or(|pos| {
    // rust: self.with_level(|_, level, _| {
    // rust: level.allow_hopper_pickup_item(
    // rust: BlockPos::new(pos.0, pos.1, pos.2),
    // rust: &stack.item,
    // rust: stack.count,
    // rust: )
    // rust: })
    // rust: });
    // rust: if !allowed {
    // rust: i += 1;
    // rust: continue;
}
    // rust: match self.add_item(None, hopper, stack, None) {
    // rust: None => {
    // rust: self.remove_dropped(i);
    // rust: return true;
}
    // rust: Some(rest) => self.dropped[i].stack = rest,
}
}
    // rust: i += 1;
}
    // rust: false
}
    /// `MinecartHopper.tick`'s `tryConsumeItems` (`suckInItems`) for an enabled
    /// hopper minecart: one item from the container above, else the item
    /// entities over it or touching it, each tick without a cooldown.
    // rust: pub(super) fn hopper_cart_suck(&mut self, cart: &mut super::minecarts::Minecart) {
        // The cart's slots are edited as a container under the placeholder key
        // its menu uses; when that menu is open the placeholder is the live copy.
    // rust: let key = (i32::MAX - 15, super::minecarts::CART_KEY_Y, cart.id as i32);
    // rust: let (view, open) = self.lend_items(key, &mut cart.items);
    // rust: let p = cart.position;
        // getLevelY is the cart's y + 0.5, so the container is the block at
        // y + 1.5, and Hopper.SUCK_AABB (moved by getLevel - 0.5) starts 11/16
        // above the cart.
    // rust: let above = (
    // rust: p.x.floor() as i32,
    // rust: (p.y + 1.5).floor() as i32,
    // rust: p.z.floor() as i32,
    // rust: );
    // rust: let at = [p.x, p.y + 1.5, p.z];
    // rust: let took = match self.suck_from_container(above, at, &view) {
    // rust: Some(took) => took,
    // rust: None => self.suck_item_entities(
    // rust: None,
    // rust: &view,
    // rust: [p.x - 0.5, p.y + 11.0 / 16.0, p.z - 0.5],
    // rust: [p.x + 0.5, p.y + 2.0, p.z + 0.5],
    // rust: ),
}
    // rust: if !took {
            // The cart's own box, inflated by 0.25 sideways.
    // rust: let b = cart.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: self.suck_item_entities(
    // rust: None,
    // rust: &view,
    // rust: [lo.x - 0.25, lo.y, lo.z - 0.25],
    // rust: [hi.x + 0.25, hi.y, hi.z + 0.25],
    // rust: );
}
    // rust: self.reclaim_items(key, open, &mut cart.items);
}

    // ---- dispensers and droppers ----

    /// `DispenserBlock.dispenseFrom` / `DropperBlock.dispenseFrom`.
    // rust: pub(super) fn dispense_from(&mut self, pos: BlockPos, state: BlockStateId) -> Result<()> {
    // rust: let key = (pos.x, pos.y, pos.z);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: if &*name == "minecraft:crafter" {
    // rust: return self.crafter_dispense(pos, state);
}
    // rust: let dropper = &*name == "minecraft:dropper";
    // rust: if !dropper && &*name != "minecraft:dispenser" {
    // rust: return Ok(());
}
    // rust: let Some(view) = self.containers().view(key, false) else {
    // rust: return Ok(());
}
        // DispenserBlockEntity.getRandomSlot
    // rust: let mut slot = None;
    // rust: let mut odds = 1;
    // rust: for i in 0..view.len() {
    // rust: if self.containers().get(&view, i).is_some() {
    // rust: if self.world.random.next_int_bound(odds).unwrap_or(1) == 0 {
    // rust: slot = Some(i);
}
    // rust: odds += 1;
}
}
    // rust: let Some(slot) = slot else {
    // rust: self.dispenser_event(1001, key, 0);
    // rust: if !dropper {
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_activate",
    // rust: [pos.x, pos.y, pos.z],
    // rust: None,
    // rust: Some(state),
    // rust: );
}
    // rust: return Ok(());
}
    // rust: let Some(facing) = self
    // rust: .containers()
    // rust: .prop(state, "facing")
    // rust: .and_then(dir_from_name)
    // rust: else {
    // rust: return Ok(());
}
    // rust: let Some(stack) = self.containers().get(&view, slot).cloned() else {
    // rust: return Ok(());
}
    // rust: let target = offset(key, facing);
    // rust: let remaining = if dropper {
    // rust: match self.containers().view(target, false) {
    // rust: None => self.dispense_default(key, facing, stack),
    // rust: Some(into) => {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: if self
    // rust: .add_item(None, &into, one, Some(facing.opposite()))
    // rust: .is_none()
    // rust: {
    // rust: self.view_changed(&into);
    // rust: Some(ItemStack {
    // rust: count: stack.count - 1,
    // rust: ..stack
    // rust: })
    // rust: .filter(|s| s.count > 0)
    // rust: } else {
    // rust: Some(stack)
}
}
}
    // rust: } else {
    // rust: self.dispense_item(key, facing, stack)?
}
    // rust: if let Some(entry) = self.slot_mut_at(&view, slot) {
    // rust: *entry = remaining;
}
    // rust: self.container_changed(key);
    // rust: Ok(())
}
}

// ---- hopper, dispenser and dropper screens ----

/// Which machine screen the open container uses.
pub const Screen = enum {
    Hopper,
    Dispenser,
    Dropper,
};

    // rust: impl Game<'_> {
pub fn machine_screen(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = self.container?;
        // A mod's screen over a hopper or dispenser menu lays out its own slots.
    // rust: if self.native_screen_inventory_y().is_some() {
    // rust: return None;
}
        // A server's menu shows by its type, whatever block (or minecart) holds it.
    // rust: if let Some(menu) = self.remote_menu_type() {
    // rust: return match menu {
    // rust: "minecraft:hopper" => Some(Screen::Hopper),
    // rust: "minecraft:generic_3x3" => Some(Screen::Dispenser),
    // rust: _ => None,
}
}
    // rust: if key.1 == super::minecarts::CART_KEY_Y {
    // rust: return (self.open_cart_kind() == Some(super::minecarts::CartKind::Hopper))
    // rust: .then_some(Screen::Hopper);
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: match &*self.res.facts().get(state).name {
    // rust: "minecraft:hopper" => Some(Screen::Hopper),
    // rust: "minecraft:dispenser" => Some(Screen::Dispenser),
    // rust: "minecraft:dropper" => Some(Screen::Dropper),
    // rust: _ => None,
}
}
    /// `imageHeight` of the open screen (HopperScreen is 133 tall).
    // rust: pub(super) fn screen_height(&self) -> f32 {
    // rust: if let Some(height) = self.native_screen_height() {
    // rust: return height;
}
    // rust: if self
    // rust: .station
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.kind == super::stations::Kind::Beacon)
    // rust: {
    // rust: return super::beacon::HEIGHT;
}
    // rust: if let Some(rows) = self.chest_rows() {
            // ContainerScreen: 114 + 18 per row.
    // rust: return 114.0 + rows as f32 * 18.0;
}
    // rust: if self.container_block_is_shulker() {
    // rust: return 167.0;
}
    // rust: if self.machine_screen() == Some(Screen::Hopper) {
    // rust: 133.0
    // rust: } else {
    // rust: 166.0
}
}
    /// HopperMenu / DispenserMenu slot layouts; None for other screens.
    // rust: pub(super) fn machine_slot_position(&self, i: usize) -> Option<(f32, f32)> {
    // rust: let screen = self.machine_screen()?;
    // rust: let inventory_y = if screen == Screen::Hopper { 51.0 } else { 84.0 };
    // rust: Some(match i {
    // rust: 0..9 => (8.0 + i as f32 * 18.0, inventory_y + 58.0),
    // rust: 9..36 => (
    // rust: 8.0 + ((i - 9) % 9) as f32 * 18.0,
    // rust: inventory_y + ((i - 9) / 9) as f32 * 18.0,
    // rust: ),
    // rust: 300..500 if screen == Screen::Hopper => (44.0 + (i - 300) as f32 * 18.0, 20.0),
    // rust: 300..500 => (
    // rust: 62.0 + ((i - 300) % 3) as f32 * 18.0,
    // rust: 17.0 + ((i - 300) / 3) as f32 * 18.0,
    // rust: ),
    // rust: _ => return None,
    // rust: })
}
    /// HopperScreen / DispenserScreen background and labels; false for other containers.
    // rust: pub(super) fn draw_machine_screen(
    // rust: &self,
    // rust: batch: &mut horizon_client::hud::HudBatch,
    // rust: ox: f32,
    // rust: oy: f32,
    // rust: ) -> bool {
    // rust: let Some(screen) = self.machine_screen() else {
    // rust: return false;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let key_is_cart = self
    // rust: .container
    // rust: .is_some_and(|k| k.1 == super::minecarts::CART_KEY_Y);
    // rust: let (texture, height, key, fallback) = match screen {
    // rust: Screen::Hopper if key_is_cart => (
    // rust: "gui/container/hopper",
    // rust: 133.0,
    // rust: "entity.minecraft.hopper_minecart",
    // rust: "Minecart with Hopper",
    // rust: ),
    // rust: Screen::Hopper => (
    // rust: "gui/container/hopper",
    // rust: 133.0,
    // rust: "container.hopper",
    // rust: "Item Hopper",
    // rust: ),
    // rust: Screen::Dispenser => (
    // rust: "gui/container/dispenser",
    // rust: 166.0,
    // rust: "container.dispenser",
    // rust: "Dispenser",
    // rust: ),
    // rust: Screen::Dropper => (
    // rust: "gui/container/dispenser",
    // rust: 166.0,
    // rust: "container.dropper",
    // rust: "Dropper",
    // rust: ),
}
    // rust: if let Some(mut r) = atlas.sprites.get(texture).copied() {
    // rust: let dv = (r.v1 - r.v0) / r.h as f32;
    // rust: let du = (r.u1 - r.u0) / r.w as f32;
    // rust: r.u1 = r.u0 + 176.0 * du;
    // rust: r.v1 = r.v0 + height * dv;
    // rust: batch.rect_uv(ox, oy, 176.0, height, r, u32::MAX);
}
    // rust: let grey = horizon_client::hud::rgba(64, 64, 64, 255);
    // rust: let title = &self.remote_menu_title().unwrap_or_else(|| {
    // rust: horizon_client::text::Text::literal(self.container_title(self.translate(key, fallback)))
    // rust: .resolve_legacy()
    // rust: });
    // rust: super::screen_info::name_container(|| title.plain());
    // rust: let title_x = if screen == Screen::Hopper {
    // rust: 8.0
    // rust: } else {
    // rust: (176.0 - atlas.font.width_text(title)) / 2.0
}
    // rust: batch.text_styled(atlas, title, ox + title_x, oy + 6.0, grey, false);
    // rust: let inventory = self.translate("container.inventory", "Inventory");
    // rust: batch.text(atlas, &inventory, ox + 8.0, oy + height - 94.0, grey, false);
    // rust: true
}
}

    // rust: mod item_column_tests {
//     use super::ItemColumns;
//     use horizon_client::{entities::ItemEntity, items::ItemStack};
//     use horizon_core::geometry::Vec3;

pub fn item(id: u32, x: f64, y: f64, z: f64) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = Vec3::new(x, y, z);
    // rust: ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: id,
    // rust: stack: ItemStack::new("minecraft:stone", 1),
    // rust: thrower: None,
    // rust: target: None,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: true,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
}
    /// `hopper_suck`'s test: some item box meets the hopper's SUCK_AABB.
pub fn scan(items: *[ItemEntity]) void {
}
    // rust: let (min, max) = (
    // rust: Vec3::new(f64::from(x), f64::from(y) + 11.0 / 16.0, f64::from(z)),
    // rust: Vec3::new(f64::from(x) + 1.0, f64::from(y) + 2.0, f64::from(z) + 1.0),
    // rust: );
    // rust: items.iter().any(|i| {
    // rust: let b = i.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: lo.x < max.x
    // rust: && hi.x > min.x
    // rust: && lo.y < max.y
    // rust: && hi.y > min.y
    // rust: && lo.z < max.z
    // rust: && hi.z > min.z
    // rust: })
}

    /// One tick of empty hoppers looking for items: each scans every item
    /// (before) or asks the columns first (after, build included).
pub fn hopper_suck_cost() void {
}
    // rust: for (hoppers, count) in [(500i32, 200u32), (2000, 500), (2000, 2000)] {
    // rust: let mut seed = 99u64;
    // rust: let mut next = |range: f64| {
    // rust: seed = seed.wrapping_mul(6_364_136_223_846_793_005).wrapping_add(1);
    // rust: (seed >> 11) as f64 / (1u64 << 53) as f64 * range
}
    // rust: let items: Vec<ItemEntity> = (0..count)
    // rust: .map(|id| item(id, next(160.0), 64.0, next(160.0)))
    // rust: .collect();
    // rust: let at: Vec<(i32, i32, i32)> = (0..hoppers)
    // rust: .map(|_| (next(160.0) as i32, 63, next(160.0) as i32))
    // rust: .collect();
    // rust: let t = std::time::Instant::now();
    // rust: let a: Vec<bool> = at.iter().map(|&h| scan(&items, h)).collect();
    // rust: let before = t.elapsed().as_secs_f64() * 1e3;
    // rust: let t = std::time::Instant::now();
    // rust: let mut columns = ItemColumns::default();
    // rust: let b: Vec<bool> = at
    // rust: .iter()
    // rust: .map(|&h| columns.may_reach(&items, h.0, h.2) && scan(&items, h))
    // rust: .collect();
    // rust: let after = t.elapsed().as_secs_f64() * 1e3;
    // rust: assert_eq!(a, b);
    // rust: println!("{hoppers} hoppers, {count} items: {before:.3} ms -> {after:.3} ms");
}
}

pub fn no_hopper_with_an_item_over_it_is_skipped() void {
}
    // rust: let mut seed = 0x1234_5678_9abc_def1u64;
    // rust: let mut next = |range: f64| {
    // rust: seed = seed.wrapping_mul(6_364_136_223_846_793_005).wrapping_add(1);
    // rust: (seed >> 11) as f64 / (1u64 << 53) as f64 * range
}
    // rust: let mut items: Vec<ItemEntity> = Vec::new();
    // rust: let mut columns = ItemColumns::default();
    // rust: let mut next_id = 0;
    // rust: let mut skipped = 0;
    // rust: for round in 0..3000 {
            // Items come and go as hoppers take them and crafters drop them.
    // rust: match round % 5 {
    // rust: 0 | 1 => {
    // rust: next_id += 1;
                    // On edges too: a quarter of them sit on a block line.
    // rust: let snap = |v: f64, edge: bool| if edge { v.floor() + 0.125 } else { v };
    // rust: let edge = round % 4 == 0;
    // rust: items.push(item(
    // rust: next_id,
    // rust: snap(next(24.0) - 12.0, edge),
    // rust: 64.0,
    // rust: snap(next(24.0) - 12.0, edge),
    // rust: ));
}
    // rust: 2 if !items.is_empty() => {
    // rust: let i = next(items.len() as f64) as usize;
    // rust: items.remove(i);
}
    // rust: _ => {}
}
    // rust: let hopper = (next(26.0) as i32 - 13, 63, next(26.0) as i32 - 13);
    // rust: let reach = columns.may_reach(&items, hopper.0, hopper.2);
    // rust: let found = scan(&items, hopper);
    // rust: assert!(
    // rust: reach || !found,
    // rust: "round {round}: skipped a hopper with an item over it"
    // rust: );
    // rust: skipped += usize::from(!reach);
}
    // rust: assert!(skipped > 1000, "skipped only {skipped}");
}
}

    // rust: mod mod_container_tests {
//     use super::{Kind, ModContainer, View};
//     use horizon_core::geometry::Direction;
//     use std::sync::Arc;

    /// A mod's container reaches the slots its block names for each face;
    /// without a face, every slot.
pub fn mod_container_slots_by_face() void {
}
    // rust: let mut faces: [Vec<usize>; 6] = Default::default();
    // rust: faces[Direction::Up as usize] = vec![0];
    // rust: faces[Direction::Down as usize] = vec![2];
    // rust: faces[Direction::North as usize] = vec![1];
    // rust: let view = View {
    // rust: parts: vec![((0, 0, 0), 3)],
    // rust: kind: Kind::Mod,
    // rust: container: Some(Arc::new(ModContainer {
    // rust: slots: 3,
    // rust: faces,
    // rust: inputs: vec![0, 1],
    // rust: outputs: vec![2],
    // rust: menu: None,
    // rust: })),
}
    // rust: assert_eq!(view.slots_for_face(Some(Direction::Up)), [0]);
    // rust: assert_eq!(view.slots_for_face(Some(Direction::Down)), [2]);
    // rust: assert_eq!(view.slots_for_face(Some(Direction::North)), [1]);
    // rust: assert!(view.slots_for_face(Some(Direction::East)).is_empty());
    // rust: assert_eq!(view.slots_for_face(None), [0, 1, 2]);
}
}
