//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_items
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Items in a block's container for native server mods (docs/native-mods.md,
//! API 48): read them through a side, take them and move them, by the rules
//! hoppers follow. They act where the world is simulated, never on a client's
//! copy, and only on the level in place, which those that read or take name by
//! its `dimension` (`minecraft:overworld`), as `native_set_block` does.
// use super::{Game, Kind, View};
// use horizon_client::items::ItemStack;
// use horizon_core::geometry::Direction;

/// A slot of a container as a side reaches it (`native_container_slots`).
    // rust: pub(crate) struct NativeContainerSlot {
    /// Its number, for `native_extract_item`.
    // rust: pub(crate) slot: usize,
    // rust: pub(crate) stack: Option<ItemStack>,
    /// Whether its stack can be taken through this side: not a furnace's fuel
    /// through its bottom, unless it's a bucket, nor a brewing stand's reagent
    /// unless it's a glass bottle, nor a mod's slot outside its `outputs`.
    // rust: pub(crate) can_take: bool,
}

/// Whether a mod can take items from this container (`native_item_source`).
pub fn takes_from(view: *View) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(view.kind, Kind::Composter(_)) && view.len() > 0
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// The level in place (`minecraft:overworld`), for a hook that isn't told
    /// which it runs in. API 48.
    // rust: pub(in crate::game) fn native_dimension(&self) -> &'static str {
    // rust: self.dim.id()
}
    /// Whether this game simulates a world, as `native_set_block` asks
    /// (the fluid helpers ask it too).
    // rust: pub(super) fn native_simulates(&self) -> bool {
    // rust: self.serving.is_some() || self.options.dedicated.is_some()
}
    /// The container at `pos` in the level in place, `dimension`, if this
    /// level simulates and holds items there. A composter's bone meal is for
    /// hoppers: it empties the block, and a refused move would lose it.
pub fn native_item_source(self: *Self, dimension: []const u8, pos: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.native_simulates() || dimension != self.dim.id() {
    // rust: return None;
}
    // rust: let view = self.containers().view((pos[0], pos[1], pos[2]), false)?;
    // rust: takes_from(&view).then_some(view)
}
    /// One item into `view` through `face`, trying `slots`, without
    /// `setChanged`: the caller tells the container once it's done. The item,
    /// when nothing took it.
    // rust: fn add_one_quietly(
    // rust: &mut self,
    // rust: view: &View,
    // rust: slots: &[usize],
    // rust: one: ItemStack,
    // rust: face: Direction,
    // rust: ) -> Option<ItemStack> {
    // rust: if let Kind::Composter(_) = view.kind {
    // rust: let (x, y, z) = view.parts[0].0;
    // rust: return self.composter_container_insert([x, y, z], one, face == Direction::Up);
}
    // rust: let mut rest = Some(one);
    // rust: for &slot in slots {
    // rust: let Some(one) = rest.take() else { break };
    // rust: rest = self.move_in_item(None, view, one, slot, Some(face)).0;
}
    // rust: rest
}
    /// `native_insert_item`: `tryMoveInItem` puts all it's given in an empty
    /// slot, and a hopper gives it one item, so a bigger stack goes in one by
    /// one or it would pass the slot's limit. The rest.
    // rust: pub(in crate::game) fn insert_stack_through(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: if !self.native_simulates() {
    // rust: return Some(stack);
}
    // rust: let Some(view) = self.containers().view((pos[0], pos[1], pos[2]), false) else {
    // rust: return Some(stack);
}
    // rust: let slots = view.slots_to_add(Some(face));
    // rust: let mut left = stack.count;
    // rust: while left > 0 {
    // rust: let one = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: if self.add_one_quietly(&view, &slots, one, face).is_some() {
    // rust: break;
}
    // rust: left -= 1;
            // A composter's `InputContainer` holds one item.
    // rust: if matches!(view.kind, Kind::Composter(_)) {
    // rust: break;
}
}
    // rust: if left < stack.count {
    // rust: self.view_changed(&view);
}
    // rust: (left > 0).then_some(ItemStack {
    // rust: count: left,
    // rust: ..stack
    // rust: })
}
    /// The slots of the container at `pos` that its side `face` reaches, with
    /// their stacks. None where no container is: another dimension, a chunk
    /// that isn't loaded, a block without slots, a composter, or the mod block
    /// entity ticking now (it's out of the world, and has its items in hand).
    /// A double chest's slots are both halves'. API 48.
    // rust: pub(in crate::game) fn native_container_slots(
    // rust: &self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> Option<Vec<NativeContainerSlot>> {
    // rust: let view = self.native_item_source(dimension, pos)?;
    // rust: let c = self.containers();
    // rust: Some(
    // rust: view.slots_for_face(Some(face))
    // rust: .into_iter()
    // rust: .map(|slot| {
    // rust: let stack = c.get(&view, slot);
    // rust: NativeContainerSlot {
    // rust: slot,
    // rust: stack: stack.cloned(),
    // rust: can_take: stack.is_some_and(|s| c.can_take(&view, slot, s, face)),
}
    // rust: })
    // rust: .collect(),
    // rust: )
}
    /// Takes up to `count` items out of slot `slot` of the container at `pos`,
    /// through its side `face`; they're the mod's to place then, as a hopper's
    /// are: to hand them on without losing any, use `native_move_items`. None
    /// when nothing can be taken: see `native_container_slots`. API 48.
    // rust: pub(in crate::game) fn native_extract_item(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: slot: usize,
    // rust: count: u32,
    // rust: ) -> Option<ItemStack> {
    // rust: let view = self.native_item_source(dimension, pos)?;
    // rust: if count == 0 || !view.slots_for_face(Some(face)).contains(&slot) {
    // rust: return None;
}
    // rust: let c = self.containers();
    // rust: if !c.can_take(&view, slot, c.get(&view, slot)?, face) {
    // rust: return None;
}
    // rust: let target = self.slot_mut_at(&view, slot)?;
    // rust: let current = target.as_mut()?;
    // rust: let taken = count.min(current.count);
    // rust: let out = ItemStack {
    // rust: count: taken,
    // rust: ..current.clone()
}
    // rust: current.count -= taken;
    // rust: if current.count == 0 {
    // rust: *target = None;
}
    // rust: self.view_changed(&view);
    // rust: Some(out)
}
    /// Moves up to `max` items from the container at `from`, through its side
    /// `from_face`, into the one at `to`, through its side `to_face`, one by
    /// one as a hopper does: an item the target refuses stays in its slot, so
    /// none is lost. `item` (`minecraft:coal`) takes only that item. How many
    /// moved: 0 where `native_container_slots` is none at `from`, where no
    /// container is at `to`, and within one container. A composter takes one
    /// a call. API 48.
    // rust: pub(in crate::game) fn native_move_items(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: from: [i32; 3],
    // rust: from_face: Direction,
    // rust: to: [i32; 3],
    // rust: to_face: Direction,
    // rust: item: Option<&str>,
    // rust: max: u32,
    // rust: ) -> u32 {
    // rust: let Some(source) = self.native_item_source(dimension, from) else {
    // rust: return 0;
}
    // rust: let Some(target) = self.containers().view((to[0], to[1], to[2]), false) else {
    // rust: return 0;
}
        // A double chest's halves are one container.
    // rust: if source.parts.iter().any(|p| target.parts.contains(p)) {
    // rust: return 0;
}
    // rust: let max = if matches!(target.kind, Kind::Composter(_)) {
    // rust: max.min(1)
    // rust: } else {
    // rust: max
}
    // rust: let into = target.slots_to_add(Some(to_face));
    // rust: let mut moved = 0;
    // rust: for slot in source.slots_for_face(Some(from_face)) {
    // rust: while moved < max {
    // rust: let c = self.containers();
    // rust: let Some(stack) = c.get(&source, slot) else {
    // rust: break;
}
    // rust: if item.is_some_and(|i| i != &*stack.item)
    // rust: || !c.can_take(&source, slot, stack, from_face)
    // rust: {
    // rust: break;
}
    // rust: let Some(one) = self.take_one(&source, slot) else {
    // rust: break;
}
    // rust: if let Some(rest) = self.add_one_quietly(&target, &into, one, to_face) {
    // rust: self.put_back(&source, slot, rest);
    // rust: break;
}
    // rust: moved += 1;
}
}
    // rust: if moved > 0 {
    // rust: self.view_changed(&source);
    // rust: self.view_changed(&target);
}
    // rust: moved
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::containers::ModContainer;
//     use std::sync::Arc;

pub fn view(kind: Kind, slots: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: View {
    // rust: parts: vec![((0, 0, 0), slots)],
    // rust: kind,
    // rust: container: (kind == Kind::Mod).then(|| {
    // rust: Arc::new(ModContainer {
    // rust: slots,
    // rust: ..Default::default()
    // rust: })
    // rust: }),
}
}

pub fn a_composter_and_a_block_without_slots_give_nothing() void {
}
    // rust: assert!(takes_from(&view(Kind::Generic, 27)));
    // rust: assert!(takes_from(&view(Kind::Mod, 3)));
    // rust: assert!(!takes_from(&view(Kind::Generic, 0)));
    // rust: assert!(!takes_from(&view(Kind::Composter(8), 1)));
}

pub fn a_face_only_narrows_the_slots_of_a_worldly_container() void {
}
    // rust: assert_eq!(
    // rust: view(Kind::Furnace, 3).slots_to_add(Some(Direction::Up)),
    // rust: [0]
    // rust: );
    // rust: assert_eq!(
    // rust: view(Kind::Generic, 2).slots_to_add(Some(Direction::Up)),
    // rust: [0, 1]
    // rust: );
    // rust: assert_eq!(
    // rust: view(Kind::Shulker, 2).slots_to_add(Some(Direction::Up)),
    // rust: [0, 1]
    // rust: );
    // rust: assert_eq!(view(Kind::Furnace, 3).slots_to_add(None), [0, 1, 2]);
}
}
