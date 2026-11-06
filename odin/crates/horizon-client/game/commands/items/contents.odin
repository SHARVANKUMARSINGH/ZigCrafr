//! Transpiled from Horizon Rust crate
package horizon_client_contents

import "core:fmt"
import "core:mem"
import "core:math"

// ContentsSlotSource's live component collections; mutable until written back.
// use super::{Game, ItemStack, Slot, SlotCandidate};

    // rust: pub(in crate::game) enum Component {
    // rust: Container,
    // rust: Bundle,
    // rust: Charged,
}
    // rust: pub(super) struct Provider<'a> {
    // rust: items: &'a [Option<ItemStack>],
    // rust: position: &'a mut usize,
    // rust: mode: &'a str,
}
    // rust: impl<'a> Provider<'a> {
    // rust: pub(super) fn new(
    // rust: items: &'a [Option<ItemStack>],
    // rust: position: &'a mut usize,
    // rust: mode: &'a str,
    // rust: ) -> Self {
    // rust: Self {
    // rust: items,
    // rust: position,
    // rust: mode,
}
}
}
    // rust: impl Component {
    // rust: pub(super) fn named(name: &str) -> Option<Self> {
    // rust: match name.strip_prefix("minecraft:").unwrap_or(name) {
    // rust: "container" => Some(Self::Container),
    // rust: "bundle_contents" => Some(Self::Bundle),
    // rust: "charged_projectiles" => Some(Self::Charged),
    // rust: _ => None,
}
}
    // rust: pub(super) fn items(self, stack: &ItemStack) -> Vec<Option<ItemStack>> {
    // rust: let Some(data) = stack.data() else {
    // rust: return Vec::new();
}
    // rust: match self {
    // rust: Self::Container => {
    // rust: let size = data
    // rust: .container
    // rust: .iter()
    // rust: .map(|(i, _)| usize::from(*i) + 1)
    // rust: .max()
    // rust: .unwrap_or(0);
    // rust: let mut out = vec![None; size];
    // rust: for (i, item) in &data.container {
    // rust: out[usize::from(*i)] = Some(item.clone());
}
    // rust: out
}
    // rust: Self::Bundle => data.bundle_contents.iter().cloned().map(Some).collect(),
    // rust: Self::Charged => data.charged.iter().cloned().map(Some).collect(),
}
}
    // ComponentSlotCollection writes a single normalized component back to
    // its live parent; all unrelated parent components remain modeled.
    // rust: pub(super) fn store(self, stack: &mut ItemStack, mut slots: Vec<Option<ItemStack>>) {
    // rust: for slot in &mut slots {
    // rust: if slot
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.count == 0 || &*s.item == "minecraft:air")
    // rust: {
    // rust: *slot = None;
}
}
    // rust: if self == Self::Bundle {
            // BundleContents.Mutable.mergeIdenticalStacks: merge into a later
            // matching entry, preserving the order of the surviving entries.
    // rust: let mut i = 0;
    // rust: while i < slots.len() {
    // rust: let Some(item) = slots[i].as_ref() else {
    // rust: slots.remove(i);
    // rust: continue;
}
    // rust: if let Some(j) = (i + 1..slots.len()).find(|&j| {
    // rust: slots[j]
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.same_item_same_components(item))
    // rust: }) {
    // rust: let count = item.count;
    // rust: slots[j].as_mut().unwrap().count += count;
    // rust: slots.remove(i);
    // rust: } else {
    // rust: i += 1;
}
}
}
    // rust: let data = stack.data_mut();
    // rust: match self {
    // rust: Self::Container => {
    // rust: data.container = slots
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, s)| s.map(|s| (i as u8, s)))
    // rust: .collect()
}
    // rust: Self::Bundle => data.bundle_contents = slots.into_iter().flatten().collect(),
    // rust: Self::Charged => data.charged = slots.into_iter().flatten().collect(),
}
    // rust: stack.tidy();
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn contents_slots(&mut self, parent: Slot, component: Component) -> Vec<Slot> {
    // rust: let size = self
    // rust: .slot_get(&parent)
    // rust: .map_or(0, |s| component.items(&s).len());
    // rust: (0..size)
    // rust: .map(|i| Slot::ContentItem(Box::new(parent.clone()), component, i))
    // rust: .collect()
}
    // rust: fn select_contents_item(
    // rust: &mut self,
    // rust: candidate: &SlotCandidate,
    // rust: selected: &mut usize,
    // rust: stack: Option<&ItemStack>,
    // rust: nonempty: bool,
    // rust: ) -> bool {
    // rust: if *selected >= candidate.limit || (nonempty && stack.is_none()) {
    // rust: return false;
}
    // rust: let air = ItemStack::new("minecraft:air", 0);
    // rust: if !candidate
    // rust: .filters
    // rust: .iter()
    // rust: .all(|f| self.loot_item_filter(f, stack.unwrap_or(&air)))
    // rust: {
    // rust: return false;
}
    // rust: *selected += 1;
    // rust: true
}
contents_can_grow :: proc(self: ^Self, component: Component, slots: ^[Maybe(ItemStack)]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match component {
    // rust: Component::Container => slots.len() < 256,
    // rust: Component::Charged => slots.len() < 1024,
    // rust: Component::Bundle => !horizon_client::bundle::Contents::from_items(
    // rust: self.res.items(),
    // rust: slots.iter().flatten().cloned().collect(),
    // rust: )
    // rust: .is_full(),
}
}
    // rust: fn contents_accepts(
    // rust: &self,
    // rust: component: Component,
    // rust: slots: &[Option<ItemStack>],
    // rust: index: usize,
    // rust: item: Option<&ItemStack>,
    // rust: ) -> bool {
    // rust: if component != Component::Bundle {
    // rust: return true;
}
    // rust: let Some(item) = item else { return true };
    // rust: if !horizon_client::bundle::can_be_in_bundle(item) {
    // rust: return false;
}
    // rust: let rest = slots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(i, _)| *i != index)
    // rust: .filter_map(|(_, s)| s.clone())
    // rust: .collect();
    // rust: horizon_client::bundle::Contents::from_items(self.res.items(), rest)
    // rust: .room_for(self.res.items(), item)
    // rust: >= item.count
}
    // ComponentSlotCollection.modifySlots: visit occupied slots only, then
    // commit the component through the same live parent slot.
    // rust: pub(super) fn modify_contents(
    // rust: &mut self,
    // rust: parent: &Slot,
    // rust: component: Component,
    // rust: candidate: &SlotCandidate,
    // rust: selected: &mut usize,
    // rust: mut modifier: impl FnMut(&mut Self, ItemStack) -> Option<ItemStack>,
    // rust: ) -> i32 {
    // rust: let Some(mut stack) = self.slot_get(parent) else {
    // rust: return 0;
}
    // rust: let mut slots = component.items(&stack);
    // rust: let mut changed = 0;
    // rust: for i in 0..slots.len() {
    // rust: if !self.select_contents_item(candidate, selected, slots[i].as_ref(), true) {
    // rust: continue;
}
    // rust: let Some(current) = slots[i].clone() else {
    // rust: continue;
}
    // rust: let next =
    // rust: modifier(self, current).filter(|s| s.count > 0 && &*s.item != "minecraft:air");
    // rust: if self.contents_accepts(component, &slots, i, next.as_ref()) {
    // rust: slots[i] = next;
    // rust: changed += 1;
}
}
    // rust: component.store(&mut stack, slots);
    // rust: if self.slot_set(parent, Some(stack)) {
    // rust: changed
    // rust: } else {
    // rust: 0
}
}
    // GrowableMutableContainer.replaceSlotItems: consume one provider shared
    // by the owner's source terms, including new component slots.
    // rust: pub(super) fn replace_contents(
    // rust: &mut self,
    // rust: parent: &Slot,
    // rust: component: Component,
    // rust: candidate: &SlotCandidate,
    // rust: selected: &mut usize,
    // rust: provider: &mut Provider<'_>,
    // rust: ) -> i32 {
    // rust: let items = provider.items;
    // rust: let position = &mut *provider.position;
    // rust: let mode = provider.mode;
    // rust: let original = self.slot_get(parent);
    // rust: let mut stack = original
    // rust: .clone()
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:air", 0));
    // rust: let mut slots = component.items(&stack);
    // rust: let mut changed = 0;
    // rust: for i in 0..slots.len() {
    // rust: if !has_next(items, *position, mode) {
    // rust: break;
}
    // rust: if !self.select_contents_item(candidate, selected, slots[i].as_ref(), false) {
    // rust: continue;
}
    // rust: let next = next_item(items, position, mode);
    // rust: if self.contents_accepts(component, &slots, i, next.as_ref()) {
    // rust: slots[i] = next;
    // rust: changed += 1;
}
}
    // rust: while has_next(items, *position, mode) && self.contents_can_grow(component, &slots) {
    // rust: if !self.select_contents_item(candidate, selected, None, false) {
    // rust: break;
}
    // rust: if component != Component::Container && !find_nonempty(items, position, mode) {
    // rust: break;
}
    // rust: let next = peek_item(items, *position, mode);
    // rust: if !self.contents_accepts(component, &slots, slots.len(), next.as_ref()) {
    // rust: break;
}
    // rust: slots.push(next_item(items, position, mode));
    // rust: changed += 1;
}
        // ItemStack.EMPTY cannot gain components, though its virtual mutable
        // collection can still report replacements.
    // rust: if original.is_none() {
    // rust: return changed;
}
    // rust: component.store(&mut stack, slots);
    // rust: if self.slot_set(parent, Some(stack)) {
    // rust: changed
    // rust: } else {
    // rust: 0
}
}
}
has_next :: proc(items: ^[Maybe(ItemStack)], position: uint, mode: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !items.is_empty() && (mode != "replace" || position < items.len())
}
peek_item :: proc(items: ^[Maybe(ItemStack)], position: uint, mode: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let index = if mode == "fill" {
    // rust: position % items.len()
    // rust: } else {
    // rust: position
}
    // rust: items
    // rust: .get(index)
    // rust: .cloned()
    // rust: .flatten()
    // rust: .filter(|s| s.count > 0 && &*s.item != "minecraft:air")
}
next_item :: proc(items: ^[Maybe(ItemStack)], position: ^uint, mode: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let next = peek_item(items, *position, mode);
    // rust: *position += 1;
    // rust: next
}
find_nonempty :: proc(items: ^[Maybe(ItemStack)], position: ^uint, mode: string) -> b {
    // Ported from Horizon
    return {}
}
    // ArrayItemProvider.findNext changes position only when it finds a match.
    // A failed component append must leave air available to later source terms.
    // rust: for offset in 0..items.len() {
    // rust: let next = *position + offset;
    // rust: if mode != "fill" && next >= items.len() {
    // rust: return false;
}
    // rust: if peek_item(items, next, mode).is_some() {
    // rust: *position = next;
    // rust: return true;
}
}
    // rust: false
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::Tag;

failed_component_growth_keeps_air_for_the_next_source_term :: proc() {
}
    // rust: let items = [None];
    // rust: let mut position = 0;
    // rust: assert!(!find_nonempty(&items, &mut position, "replace"));
    // rust: assert_eq!(position, 0);
    // rust: assert!(has_next(&items, position, "replace"));
    // rust: assert!(next_item(&items, &mut position, "replace").is_none());
    // rust: assert_eq!(position, 1);
}

component_storage_keeps_sparse_positions_and_the_live_parent :: proc() {
}
    // rust: let mut parent = ItemStack::new("minecraft:stone", 1);
    // rust: parent.data_mut().other.push((
    // rust: "minecraft:custom_data".into(),
    // rust: Tag::compound([("audit", Tag::Int(7))]),
    // rust: ));
    // rust: let mut slots = vec![None; 6];
    // rust: slots[0] = Some(ItemStack::new("minecraft:diamond", 1));
    // rust: slots[5] = Some(ItemStack::new("minecraft:dirt", 7));
    // rust: Component::Container.store(&mut parent, slots.clone());
    // rust: assert_eq!((&*parent.item, parent.count), ("minecraft:stone", 1));
    // rust: assert_eq!(
    // rust: parent.data().unwrap().other("minecraft:custom_data"),
    // rust: Some(&Tag::compound([("audit", Tag::Int(7))]))
    // rust: );
    // rust: assert_eq!(Component::Container.items(&parent), slots);
}

bundle_writeback_merges_identical_entries_but_keeps_distinct_components :: proc() {
}
    // rust: let mut parent = ItemStack::new("minecraft:bundle", 1);
    // rust: Component::Bundle.store(
    // rust: &mut parent,
    // rust: vec![Some(ItemStack::new("minecraft:gold_ingot", 1)); 64],
    // rust: );
    // rust: assert_eq!(
    // rust: parent.data().unwrap().bundle_contents,
    // rust: vec![ItemStack::new("minecraft:gold_ingot", 64)]
    // rust: );
    // rust: let plain = ItemStack::new("minecraft:gold_ingot", 1);
    // rust: let mut marked = plain.clone();
    // rust: marked.data_mut().other.push((
    // rust: "minecraft:custom_data".into(),
    // rust: Tag::compound([("audit", Tag::Int(7))]),
    // rust: ));
    // rust: Component::Bundle.store(&mut parent, vec![Some(plain.clone()), Some(marked.clone())]);
    // rust: assert_eq!(parent.data().unwrap().bundle_contents, vec![plain, marked]);
}
}
