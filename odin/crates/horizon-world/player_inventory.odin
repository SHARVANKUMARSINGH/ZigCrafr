//! Transpiled from Horizon Rust crate
package horizon_world_player_inventory

import "core:fmt"
import "core:mem"
import "core:math"

// Player inventory storage and selection. Equipment is shared with its entity;
// stack references preserve aliases across inventories and external callers.
// Pickup, ticking, menus and persistence are implemented separately.
// use crate::item_stack_refs::{ItemStacks, StackRef};
// use std::{cell::RefCell, rc::Rc};
EquipmentSlot :: enum {
    MainHand,
    OffHand,
    Feet,
    Legs,
    Chest,
    Head,
    Body,
    Saddle,
}
    // rust: impl EquipmentSlot {
    // rust: pub const ALL: [Self; 8] = [
    // rust: Self::MainHand,
    // rust: Self::OffHand,
    // rust: Self::Feet,
    // rust: Self::Legs,
    // rust: Self::Chest,
    // rust: Self::Head,
    // rust: Self::Body,
    // rust: Self::Saddle,
    // rust: ];
inventory_slot :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MainHand => None,
    // rust: Self::OffHand => Some(40),
    // rust: Self::Feet => Some(36),
    // rust: Self::Legs => Some(37),
    // rust: Self::Chest => Some(38),
    // rust: Self::Head => Some(39),
    // rust: Self::Body => Some(41),
    // rust: Self::Saddle => Some(42),
}
}
from_inventory_slot :: proc(index: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match index {
    // rust: 36 => Some(Self::Feet),
    // rust: 37 => Some(Self::Legs),
    // rust: 38 => Some(Self::Chest),
    // rust: 39 => Some(Self::Head),
    // rust: 40 => Some(Self::OffHand),
    // rust: 41 => Some(Self::Body),
    // rust: 42 => Some(Self::Saddle),
    // rust: _ => None,
}
}
}
    // rust: type EquipmentItems<I, K, V> = [Option<StackRef<I, K, V>>; 8];
EntityEquipment :: struct {
    items: Rc<RefCell<EquipmentItems<I,
    empty: StackRef<I,
}
    // rust: impl<I, K, V> Clone for EntityEquipment<I, K, V> {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: items: self.items.clone(),
    // rust: empty: self.empty.clone(),
}
}
}
    // rust: impl<I, K, V> EntityEquipment<I, K, V> {
new :: proc(empty: StackRef<I) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: items: Rc::new(RefCell::new(std::array::from_fn(|_| None))),
    // rust: empty,
}
}
get :: proc(self: ^Self, slot: EquipmentSlot) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.items.borrow()[slot as usize]
    // rust: .clone()
    // rust: .unwrap_or_else(|| self.empty.clone())
}
set :: proc(self: ^Self, slot: EquipmentSlot, stack: StackRef<I) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.items.borrow_mut()[slot as usize]
    // rust: .replace(stack)
    // rust: .unwrap_or_else(|| self.empty.clone())
}
    // Native clear preserves which enum-map entries have been populated.
clear :: proc(self: ^Self) {
}
    // rust: for s in self.items.borrow_mut().iter_mut().flatten() {
    // rust: *s = self.empty.clone();
}
}
entries :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let items = self.items.borrow();
    // rust: EquipmentSlot::ALL
    // rust: .into_iter()
    // rust: .filter_map(|s| items[s as usize].clone().map(|v| (s, v)))
    // rust: .collect()
}
}
InventoryError :: enum {
    Index,
    Selection,
}
    // rust: pub trait InventoryRules<I, K, V> {
is_enchanted :: proc(self: ^Self, stack: ^StackRef<I) -> b {
    // Ported from Horizon
    return {}
}
is_damaged :: proc(self: ^Self, stack: ^StackRef<I) -> b {
    // Ported from Horizon
    return {}
}
has_custom_name :: proc(self: ^Self, stack: ^StackRef<I) -> b {
    // Ported from Horizon
    return {}
}
}
PlayerInventory :: struct {
    items: [StackRef<I,
    equipment: EntityEquipment<I,
    stacks: ItemStacks<I,
    selected: uint,
    times_changed: i32,
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq> PlayerInventory<I, K, V> {
new :: proc(stacks: ItemStacks<I, equipment: EntityEquipment<I) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: items: std::array::from_fn(|_| stacks.empty()),
    // rust: equipment,
    // rust: stacks,
    // rust: selected: 0,
    // rust: times_changed: 0,
}
}
    // rust: pub(crate) fn stacks(&self) -> &ItemStacks<I, K, V> {
    // rust: &self.stacks
}
    // rust: pub(crate) fn set_non_equipment(
    // rust: &mut self,
    // rust: index: i32,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<(), InventoryError> {
    // rust: let index = usize::try_from(index)
    // rust: .ok()
    // rust: .filter(|i| *i < 36)
    // rust: .ok_or(InventoryError::Index)?;
    // rust: self.items[index] = stack;
    // rust: Ok(())
}
items :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.items
}
equipment :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.equipment
}
selected :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.selected
}
set_selected :: proc(self: ^Self, selected: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !(0..9).contains(&selected) {
    // rust: return Err(InventoryError::Selection);
}
    // rust: self.selected = selected as usize;
    // rust: Ok(())
}
selected_item :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.items[self.selected].clone()
}
set_selected_item :: proc(self: ^Self, stack: StackRef<I) -> S {
    // Ported from Horizon
    return {}
}
    // rust: std::mem::replace(&mut self.items[self.selected], stack)
}
get :: proc(self: ^Self, index: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if index < 0 {
    // rust: return Err(InventoryError::Index);
}
    // rust: Ok(if index < 36 {
    // rust: self.items[index as usize].clone()
    // rust: } else {
    // rust: EquipmentSlot::from_inventory_slot(index)
    // rust: .map_or_else(|| self.stacks.empty(), |s| self.equipment.get(s))
    // rust: })
}
set :: proc(self: ^Self, index: i32, stack: StackRef<I) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if index < 0 {
    // rust: return Err(InventoryError::Index);
}
    // rust: if index < 36 {
    // rust: self.items[index as usize] = stack;
    // rust: } else if let Some(s) = EquipmentSlot::from_inventory_slot(index) {
    // rust: self.equipment.set(s, stack);
}
    // rust: Ok(())
}
remove :: proc(self: ^Self, index: i32, amount: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if index < 0 || (index < 36 && amount <= 0) {
    // rust: return self.stacks.empty();
}
    // rust: let s = self.get(index).expect("nonnegative index");
    // rust: if s.read().is_empty() {
    // rust: self.stacks.empty()
    // rust: } else {
    // rust: self.stacks.split(&s, amount)
}
}
remove_no_update :: proc(self: ^Self, index: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if index < 0 {
    // rust: return Err(InventoryError::Index);
}
    // rust: Ok(if index < 36 {
    // rust: std::mem::replace(&mut self.items[index as usize], self.stacks.empty())
    // rust: } else {
    // rust: EquipmentSlot::from_inventory_slot(index).map_or_else(
    // rust: || self.stacks.empty(),
    // rust: |s| self.equipment.set(s, self.stacks.empty()),
    // rust: )
    // rust: })
}
    // The native Map.of equipment iteration order varies by JVM. The caller
    // supplies its pinned runtime order when reference aliases span equipment.
    // rust: pub fn remove_reference(
    // rust: &mut self,
    // rust: stack: &StackRef<I, K, V>,
    // rust: equipment_order: &[EquipmentSlot; 7],
    // rust: ) {
    // rust: for s in &mut self.items {
    // rust: if s.same_reference(stack) {
    // rust: *s = self.stacks.empty();
    // rust: return;
}
}
    // rust: for slot in equipment_order {
    // rust: if self.equipment.get(*slot).same_reference(stack) {
    // rust: self.equipment.set(*slot, self.stacks.empty());
    // rust: return;
}
}
}
free_slot :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.items
    // rust: .iter()
    // rust: .position(|s| s.read().is_empty())
    // rust: .map_or(-1, |i| i as i32)
}
find_matching :: proc(self: ^Self, stack: ^StackRef<I) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.items
    // rust: .iter()
    // rust: .position(|s| !s.read().is_empty() && stack.read().same_item_components(&s.read()))
    // rust: .map_or(-1, |i| i as i32)
}
contains :: proc(self: ^Self, stack: ^StackRef<I) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..43).any(|i| {
    // rust: let s = self.get(i).expect("valid slot");
    // rust: !s.read().is_empty() && s.read().same_item_components(&stack.read())
    // rust: })
}
count_item :: proc(self: ^Self, item: I) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (0..43).fold(0_i32, |n, i| {
    // rust: let s = self.get(i).expect("valid slot");
    // rust: let s = s.read();
    // rust: if s.item() == item {
    // rust: n.wrapping_add(s.count())
    // rust: } else {
    // rust: n
}
    // rust: })
}
    // rust: pub fn suitable_hotbar<R: InventoryRules<I, K, V>>(&self, rules: &R) -> usize {
    // rust: for delta in 0..9 {
    // rust: let i = (self.selected + delta) % 9;
    // rust: if self.items[i].read().is_empty() {
    // rust: return i;
}
}
    // rust: for delta in 0..9 {
    // rust: let i = (self.selected + delta) % 9;
    // rust: if !rules.is_enchanted(&self.items[i]) {
    // rust: return i;
}
}
    // rust: self.selected
}
    // rust: pub fn find_crafting<R: InventoryRules<I, K, V>>(
    // rust: &self,
    // rust: item: I,
    // rust: stack: &StackRef<I, K, V>,
    // rust: rules: &R,
    // rust: ) -> i32 {
    // rust: self.items
    // rust: .iter()
    // rust: .position(|s| {
    // rust: !s.read().is_empty()
    // rust: && s.read().item() == item
    // rust: && !rules.is_damaged(s)
    // rust: && !rules.is_enchanted(s)
    // rust: && !rules.has_custom_name(s)
    // rust: && (stack.read().is_empty() || stack.read().same_item_components(&s.read()))
    // rust: })
    // rust: .map_or(-1, |i| i as i32)
}
    // rust: pub fn add_and_pick<R: InventoryRules<I, K, V>>(
    // rust: &mut self,
    // rust: stack: StackRef<I, K, V>,
    // rust: rules: &R,
    // rust: ) {
    // rust: self.selected = self.suitable_hotbar(rules);
    // rust: if !self.items[self.selected].read().is_empty() {
    // rust: let free = self.free_slot();
    // rust: if free >= 0 {
    // rust: self.items[free as usize] = self.items[self.selected].clone();
}
}
    // rust: self.items[self.selected] = stack;
}
    // rust: pub fn pick_slot<R: InventoryRules<I, K, V>>(
    // rust: &mut self,
    // rust: index: i32,
    // rust: rules: &R,
    // rust: ) -> Result<(), InventoryError> {
    // rust: self.selected = self.suitable_hotbar(rules);
        // Selection changes even when the following list access fails.
    // rust: let index = usize::try_from(index)
    // rust: .ok()
    // rust: .filter(|i| *i < 36)
    // rust: .ok_or(InventoryError::Index)?;
    // rust: self.items.swap(self.selected, index);
    // rust: Ok(())
}
remove_selected :: proc(self: ^Self, all: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let s = self.selected_item();
    // rust: if s.read().is_empty() {
    // rust: return self.stacks.empty();
}
    // rust: let amount = if all { s.read().count() } else { 1 };
    // rust: self.remove(self.selected as i32, amount)
}
changed :: proc(self: ^Self) {
}
    // rust: self.times_changed = self.times_changed.wrapping_add(1);
}
clear :: proc(self: ^Self) {
}
    // rust: self.items.fill(self.stacks.empty());
    // rust: self.equipment.clear();
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..43).all(|i| self.get(i).expect("valid slot").read().is_empty())
}
replace_self :: proc(self: ^Self) {
}
    // rust: for i in 0..43 {
    // rust: self.set(i, self.get(i).expect("valid slot"))
    // rust: .expect("valid slot");
}
}
replace_with :: proc(self: ^Self, other: ^Self) {
}
    // rust: for i in 0..43 {
    // rust: self.set(i, other.get(i).expect("valid slot"))
    // rust: .expect("valid slot");
}
    // rust: self.selected = other.selected;
}
}
