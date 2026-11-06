//! Transpiled from Horizon Rust crate
//! Module: horizon-client_place
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `ServerPlaceRecipe`: what the server does with a recipe book click
//! (`ServerboundPlaceRecipePacket`) in the inventory, crafting table and
//! furnace menus, with `StackedContents`' exact matching of items to
//! ingredients (`RecipePicker`). `tools/test_place_recipe_parity.py`
//! compares every placement with vanilla's.
//!
//! Vanilla keeps the available items in a `Reference2IntOpenHashMap` keyed by
//! item holders, whose iteration order follows their identity hash codes: it
//! differs between runs of the game, and decides which of several fitting
//! items fills an ingredient. `Stacked` keeps an explicit order: the order
//! items were first counted, or one given (the harness passes the oracle's).
// use super::{Env, GRID, Kind, MAIN, Menu, PLAYER, RESULT, split, tidy};
// use crate::{
    // rust: crafting::{Ingredient, Placement},
    // rust: items::ItemStack,
}
// use std::{collections::HashMap, sync::Arc};

/// `StackedContents<Holder<Item>>`: item counts in an iteration order.
pub const Stacked = struct {
    keys: std.ArrayList(*str),
    amounts: std.ArrayList(i32),
    index: HashMap<*str,
};

/// `Inventory.isUsableForCrafting`: not damaged, enchanted or renamed.
pub fn usable_for_crafting(stack: *ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack.damage == 0 && stack.enchantments().is_empty() && stack.custom_name().is_none()
}

    // rust: impl Stacked {
    /// `StackedContents.account`.
pub fn account(self: *Self, item: **str, count: i32) void {
}
    // rust: match self.index.get(item) {
    // rust: Some(&i) => self.amounts[i] += count,
    // rust: None => {
    // rust: self.index.insert(item.clone(), self.keys.len());
    // rust: self.keys.push(item.clone());
    // rust: self.amounts.push(count);
}
}
}
    /// `StackedItemContents.accountStack(stack, maxCount)`.
pub fn account_stack(self: *Self, stack: *ItemStack, max: u32) void {
}
    // rust: if stack.count > 0 {
    // rust: self.account(&stack.item, stack.count.min(max) as i32);
}
}
    /// `accountSimpleStack`.
pub fn account_simple(self: *Self, stack: *ItemStack, max: u32) void {
}
    // rust: if usable_for_crafting(stack) {
    // rust: self.account_stack(stack, max);
}
}
    /// Reorders the keys: the given items first, in that order (vanilla's hash
    /// map order for the same items), then the rest as they were.
pub fn set_order(self: *Self, order: *[[]const u8]) void {
}
    // rust: let mut keys: Vec<Arc<str>> = order
    // rust: .iter()
    // rust: .filter_map(|o| self.index.get_key_value(o.as_str()).map(|(k, _)| k.clone()))
    // rust: .collect();
    // rust: for k in &self.keys {
    // rust: if !keys.contains(k) {
    // rust: keys.push(k.clone());
}
}
    // rust: let amounts = keys.iter().map(|k| self.amounts[self.index[k]]).collect();
    // rust: self.index = keys
    // rust: .iter()
    // rust: .cloned()
    // rust: .enumerate()
    // rust: .map(|(i, k)| (k, i))
    // rust: .collect();
    // rust: self.keys = keys;
    // rust: self.amounts = amounts;
}
pub fn keys(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.keys
}
    /// `canCraft(ingredients, null)` without touching the counts (the recipe
    /// book's craftable test; the answer does not depend on the order; no
    /// ingredients at all can always be found).
pub fn can_craft(self: *Self, ingredients: *[*Ingredient]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clone().try_pick(ingredients, 1, None)
}
    /// `getResultUpperBound`.
pub fn upper_bound(self: *Self, ingredients: *[*Ingredient]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut min = i32::MAX;
    // rust: 'ingredients: for ing in ingredients {
    // rust: let mut max = 0;
    // rust: for (key, &count) in self.keys.iter().zip(&self.amounts) {
    // rust: if count > max {
    // rust: if ing.items.contains(&**key) {
    // rust: max = count;
}
    // rust: if max >= min {
    // rust: continue 'ingredients;
}
}
}
    // rust: min = max;
    // rust: if min == 0 {
    // rust: break;
}
}
    // rust: min
}
    /// `tryPick` (`canCraft(recipe, amount, output)`).
    // rust: pub fn try_pick(
    // rust: &mut self,
    // rust: ingredients: &[&Ingredient],
    // rust: amount: i32,
    // rust: output: Option<&mut Vec<Arc<str>>>,
    // rust: ) -> bool {
    // rust: Picker::new(self, ingredients).try_pick(amount, output)
}
    /// `tryPickAll` (`getBiggestCraftableStack`).
    // rust: pub fn try_pick_all(
    // rust: &mut self,
    // rust: ingredients: &[&Ingredient],
    // rust: max_size: i32,
    // rust: output: Option<&mut Vec<Arc<str>>>,
    // rust: ) -> i32 {
    // rust: Picker::new(self, ingredients).try_pick_all(max_size, output)
}
}

/// `StackedContents.RecipePicker`: augmenting paths over item-ingredient pairs.
pub const Picker = struct {
    stacked: *'a mut Stacked,
    ingredients: std.ArrayList(*'a Ingredient),
    /// Indices into the stacked keys of the items any ingredient accepts.
    items: std.ArrayList(usize),
    connection: std.ArrayList(bool),
    assigned: std.ArrayList(bool),
    satisfied: std.ArrayList(bool),
    visited_ingredient: std.ArrayList(bool),
    visited_item: std.ArrayList(bool),
    path: std.ArrayList(usize),
};

    // rust: impl<'a> Picker<'a> {
pub fn new(stacked: *'a mut Stacked, ingredients: *[*'a Ingredient]) S {
    // Implementation ported from Horizon
    return undefined;
}
        // getUniqueAvailableIngredientItems
    // rust: let items: Vec<usize> = (0..stacked.keys.len())
    // rust: .filter(|&i| {
    // rust: stacked.amounts[i] > 0
    // rust: && ingredients
    // rust: .iter()
    // rust: .any(|g| g.items.contains(&*stacked.keys[i]))
    // rust: })
    // rust: .collect();
    // rust: let (ni, nt) = (ingredients.len(), items.len());
    // rust: let mut connection = vec![false; ni * nt];
    // rust: for (g, ing) in ingredients.iter().enumerate() {
    // rust: for (t, &key) in items.iter().enumerate() {
    // rust: if ing.items.contains(&*stacked.keys[key]) {
    // rust: connection[t * ni + g] = true;
}
}
}
    // rust: Self {
    // rust: stacked,
    // rust: ingredients: ingredients.to_vec(),
    // rust: items,
    // rust: connection,
    // rust: assigned: vec![false; ni * nt],
    // rust: satisfied: vec![false; ni],
    // rust: visited_ingredient: vec![false; ni],
    // rust: visited_item: vec![false; nt],
    // rust: path: Vec::new(),
}
}
pub fn at(self: *Self, item: usize, ingredient: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item * self.ingredients.len() + ingredient
}
pub fn clear_visited(self: *Self) void {
}
    // rust: self.visited_ingredient.fill(false);
    // rust: self.visited_item.fill(false);
}
pub fn try_pick(self: *Self, capacity: i32, mut output: ?*mut std.ArrayList(*str)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if capacity <= 0 {
    // rust: return true;
}
    // rust: let mut satisfied_count = 0;
    // rust: loop {
    // rust: let Some(path) = self.try_assigning_new_item(capacity) else {
    // rust: let valid = satisfied_count == self.ingredients.len();
    // rust: let has_output = valid && output.is_some();
    // rust: self.clear_visited();
    // rust: self.satisfied.fill(false);
    // rust: for g in 0..self.ingredients.len() {
    // rust: for t in 0..self.items.len() {
    // rust: let at = self.at(t, g);
    // rust: if self.assigned[at] {
    // rust: self.assigned[at] = false;
    // rust: let key = self.items[t];
    // rust: self.stacked.amounts[key] += capacity;
    // rust: if has_output && let Some(out) = output.as_deref_mut() {
    // rust: out.push(self.stacked.keys[key].clone());
}
    // rust: break;
}
}
}
    // rust: return valid;
}
    // rust: let key = self.items[path[0]];
    // rust: self.stacked.amounts[key] -= capacity;
    // rust: self.satisfied[path[path.len() - 1]] = true;
    // rust: satisfied_count += 1;
    // rust: for i in 0..path.len() - 1 {
    // rust: if i & 1 == 0 {
    // rust: let at = self.at(path[i], path[i + 1]);
    // rust: self.assigned[at] = true;
    // rust: } else {
    // rust: let at = self.at(path[i + 1], path[i]);
    // rust: self.assigned[at] = false;
}
}
}
}
pub fn try_assigning_new_item(self: *Self, capacity: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clear_visited();
    // rust: for t in 0..self.items.len() {
    // rust: if self.stacked.amounts[self.items[t]] >= capacity
    // rust: && let Some(path) = self.find_path(t)
    // rust: {
    // rust: return Some(path);
}
}
    // rust: None
}
pub fn find_path(self: *Self, start: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.path.clear();
    // rust: self.visited_item[start] = true;
    // rust: self.path.push(start);
    // rust: while !self.path.is_empty() {
    // rust: let len = self.path.len();
    // rust: if (len - 1) & 1 == 0 {
    // rust: let item = self.path[len - 1];
    // rust: for g in 0..self.ingredients.len() {
    // rust: let at = self.at(item, g);
    // rust: if !self.visited_ingredient[g] && self.connection[at] && !self.assigned[at] {
    // rust: self.visited_ingredient[g] = true;
    // rust: self.path.push(g);
    // rust: break;
}
}
    // rust: } else {
    // rust: let ingredient = self.path[len - 1];
    // rust: if !self.satisfied[ingredient] {
    // rust: return Some(self.path.clone());
}
    // rust: for t in 0..self.items.len() {
    // rust: if !self.visited_item[t] && self.assigned[self.at(t, ingredient)] {
    // rust: self.visited_item[t] = true;
    // rust: self.path.push(t);
    // rust: break;
}
}
}
    // rust: if self.path.len() == len {
    // rust: self.path.pop();
}
}
    // rust: None
}
pub fn try_pick_all(self: *Self, max_size: i32, output: ?*mut std.ArrayList(*str)) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut min = 0i32;
        // Java int arithmetic: an empty ingredient list overflows as vanilla does.
    // rust: let mut max = max_size
    // rust: .min(self.stacked.upper_bound(&self.ingredients))
    // rust: .wrapping_add(1);
    // rust: loop {
    // rust: let mid = min.wrapping_add(max) / 2;
    // rust: if self.try_pick(mid, None) {
    // rust: if max.wrapping_sub(min) <= 1 {
    // rust: if mid > 0 {
    // rust: self.try_pick(mid, output);
}
    // rust: return mid;
}
    // rust: min = mid;
    // rust: } else {
    // rust: max = mid;
}
}
}
}

/// `RecipeBookMenu.PostPlaceAction`.
pub const PostPlace = enum {
    Nothing,
    /// The client shows the recipe as a ghost (`ClientboundPlaceGhostRecipePacket`).
    Ghost,
};

/// The menu slots a placement works on.
pub const Grid = struct {
    width: usize,
    height: usize,
    /// `inputGridSlots` and `slotsToClear` as menu slot indices.
    inputs: std.ArrayList(usize),
    clear: std.ArrayList(usize),
};

    // rust: impl Menu {
pub fn place_grid(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.kind {
    // rust: Kind::Inventory => Some(Grid {
    // rust: width: 2,
    // rust: height: 2,
    // rust: inputs: (1..5).collect(),
    // rust: clear: (1..5).collect(),
    // rust: }),
    // rust: Kind::Crafting => Some(Grid {
    // rust: width: 3,
    // rust: height: 3,
    // rust: inputs: (1..10).collect(),
    // rust: clear: (1..10).collect(),
    // rust: }),
    // rust: Kind::Furnace(_) => Some(Grid {
    // rust: width: 1,
    // rust: height: 1,
    // rust: inputs: vec![0],
    // rust: clear: vec![0, 2],
    // rust: }),
    // rust: _ => None,
}
}

    /// `Inventory.fillStackedContents` then the menu's
    /// `fillCraftSlotsStackedContents`.
pub fn stacked_contents(self: *Self, env: *Env) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stacked = Stacked::default();
    // rust: for stack in self.containers[PLAYER][..36].iter().flatten() {
    // rust: stacked.account_simple(stack, Self::max_stack(env, stack));
}
    // rust: match self.kind {
            // A furnace's SimpleContainer counts all three slots, unfiltered.
    // rust: Kind::Furnace(_) => {
    // rust: for stack in self.containers[MAIN].iter().flatten() {
    // rust: stacked.account_stack(stack, Self::max_stack(env, stack));
}
}
    // rust: _ => {
    // rust: for stack in self.containers[GRID].iter().flatten() {
    // rust: stacked.account_simple(stack, Self::max_stack(env, stack));
}
}
}
    // rust: stacked
}

    /// `RecipeBookMenu.handlePlacement` for the recipe `id`
    /// (`ServerPlaceRecipe.placeRecipe`). `allow_drop` is the player being in
    /// creative; `order` the iteration order of the counted items, if known.
    // rust: pub fn place_recipe(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: id: &str,
    // rust: use_max: bool,
    // rust: allow_drop: bool,
    // rust: order: Option<&[String]>,
    // rust: ) -> PostPlace {
    // rust: let Some(grid) = self.place_grid() else {
    // rust: return PostPlace::Nothing;
}
    // rust: let Some(placement) = env.recipes.placement(id) else {
    // rust: return PostPlace::Nothing;
}
    // rust: if placement.impossible() {
    // rust: return PostPlace::Nothing;
}
    // rust: if !allow_drop && !self.test_clear_grid(env, &grid) {
    // rust: return PostPlace::Nothing;
}
    // rust: let mut stacked = self.stacked_contents(env);
    // rust: if let Some(order) = order {
    // rust: stacked.set_order(order);
}
    // rust: let ingredients: Vec<&Ingredient> = placement.ingredients.iter().collect();
    // rust: let post = if stacked.try_pick(&ingredients, 1, None) {
    // rust: self.place(env, id, &grid, &placement, &mut stacked, use_max);
    // rust: PostPlace::Nothing
    // rust: } else {
    // rust: self.clear_grid(env, &grid);
    // rust: PostPlace::Ghost
}
        // AbstractCraftingMenu.finishPlacingRecipe: the result follows the grid.
    // rust: self.recompute(env);
    // rust: post
}

    /// `recipeMatches`: the recipe already fills the grid.
pub fn recipe_in_grid(self: *Self, env: *Env, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.kind {
    // rust: Kind::Furnace(_) => {
    // rust: let name = id.trim_start_matches("minecraft:");
    // rust: match (
    // rust: env.recipes.cooking.iter().find(|c| c.id == name),
    // rust: self.containers[MAIN][0].as_ref(),
    // rust: ) {
    // rust: (Some(c), Some(input)) => c.ingredient.test(input),
    // rust: _ => false,
}
}
    // rust: _ => env
    // rust: .recipes
    // rust: .recipe_matches(id, &self.containers[GRID], self.grid_size),
}
}

    // rust: fn place(
    // rust: &mut self,
    // rust: env: &Env,
    // rust: id: &str,
    // rust: grid: &Grid,
    // rust: placement: &Placement,
    // rust: stacked: &mut Stacked,
    // rust: use_max: bool,
    // rust: ) {
    // rust: let ingredients: Vec<&Ingredient> = placement.ingredients.iter().collect();
    // rust: let matches = self.recipe_in_grid(env, id);
    // rust: let biggest = stacked.try_pick_all(&ingredients, i32::MAX, None);
    // rust: if matches {
    // rust: for &s in &grid.inputs {
    // rust: if let Some(stack) = self.slot(s)
    // rust: && (biggest.min(Self::max_stack(env, stack) as i32) as i64)
    // rust: < i64::from(stack.count) + 1
    // rust: {
    // rust: return;
}
}
}
        // calculateAmountToCraft
    // rust: let amount = if use_max {
    // rust: biggest
    // rust: } else if matches {
    // rust: let smallest = grid
    // rust: .inputs
    // rust: .iter()
    // rust: .filter_map(|&s| self.slot(s))
    // rust: .map(|s| s.count as i32)
    // rust: .min();
    // rust: smallest.map_or(i32::MAX, |n| n + 1)
    // rust: } else {
    // rust: 1
}
    // rust: let mut used = Vec::new();
    // rust: if !stacked.try_pick(&ingredients, amount, Some(&mut used)) {
    // rust: return;
}
        // clampToMaxStackSize
    // rust: let adjusted = used.iter().fold(amount, |n, item| {
    // rust: n.min(env.items.get(item).map_or(1, |i| i.max_stack) as i32)
    // rust: });
    // rust: if adjusted != amount {
    // rust: used.clear();
    // rust: if !stacked.try_pick(&ingredients, adjusted, Some(&mut used)) {
    // rust: return;
}
}
    // rust: self.clear_grid(env, grid);
    // rust: let (w, h) = placement.shaped.unwrap_or((grid.width, grid.height));
    // rust: let slots: Vec<i32> = placement.slots.clone();
    // rust: for (ingredient, index) in
    // rust: crate::recipe_book::place_cells(grid.width, grid.height, w, h, &slots)
    // rust: {
    // rust: if ingredient == -1 {
    // rust: continue;
}
    // rust: let target = grid.inputs[index];
    // rust: let item = used[ingredient as usize].clone();
    // rust: let mut remaining = adjusted;
    // rust: while remaining > 0 {
    // rust: remaining = self.move_item_to_grid(target, &item, remaining);
    // rust: if remaining == -1 {
    // rust: break;
}
}
}
}

    /// `moveItemToGrid`: the rest still to move, or -1 when nothing matches.
pub fn move_item_to_grid(self: *Self, target: usize, item: []const u8, count: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let existing = self.slot(target).cloned();
    // rust: let found = (0..36).find(|&i| {
    // rust: self.containers[PLAYER][i].as_ref().is_some_and(|s| {
    // rust: &*s.item == item
    // rust: && usable_for_crafting(s)
    // rust: && existing
    // rust: .as_ref()
    // rust: .is_none_or(|e| e.same_item_same_components(s))
    // rust: })
    // rust: });
    // rust: let Some(i) = found else {
    // rust: return -1;
}
    // rust: let cell = &mut self.containers[PLAYER][i];
    // rust: let taken = match cell.as_mut() {
    // rust: Some(have) if (count as u32) < have.count => split(have, count as u32),
    // rust: _ => cell.take().expect("found"),
}
    // rust: tidy(cell);
    // rust: let taken_count = taken.count as i32;
    // rust: let slot = self.slots[target];
    // rust: match self.containers[slot.container][slot.index].as_mut() {
    // rust: None => self.containers[slot.container][slot.index] = Some(taken),
    // rust: Some(have) => have.count += taken.count,
}
    // rust: count - taken_count
}

    /// `clearGrid`: the slots to clear go back to the inventory (or drop),
    /// then the grid empties (`clearCraftingContent`).
pub fn clear_grid(self: *Self, env: *Env, grid: *Grid) void {
}
    // rust: for &s in &grid.clear {
    // rust: let slot = self.slots[s];
    // rust: if let Some(stack) = self.containers[slot.container][slot.index].clone() {
    // rust: let mut copy = stack;
    // rust: self.place_back(env, &mut copy);
}
}
    // rust: match self.kind {
    // rust: Kind::Furnace(_) => {
    // rust: for &s in &grid.clear {
    // rust: let slot = self.slots[s];
    // rust: self.containers[slot.container][slot.index] = None;
}
}
    // rust: _ => {
    // rust: self.containers[GRID].fill(None);
    // rust: self.containers[RESULT][0] = None;
}
}
}

    /// `Inventory.placeItemBackInInventory`.
    // rust: pub(super) fn place_back(&mut self, env: &Env, stack: &mut ItemStack) {
    // rust: while stack.count > 0 {
    // rust: let slot = self
    // rust: .slot_with_space(env, stack)
    // rust: .or_else(|| (0..36).find(|&i| self.containers[PLAYER][i].is_none()));
    // rust: let Some(slot) = slot else {
    // rust: let dropped = std::mem::replace(
    // rust: stack,
    // rust: ItemStack {
    // rust: count: 0,
    // rust: ..stack.clone()
    // rust: },
    // rust: );
    // rust: self.drop_stack(&dropped);
    // rust: break;
}
    // rust: let have = self.containers[PLAYER][slot]
    // rust: .as_ref()
    // rust: .map_or(0, |s| s.count);
    // rust: let space = Self::max_stack(env, stack).saturating_sub(have);
    // rust: let mut part = split(stack, space);
    // rust: self.inventory_add_at(env, slot, &mut part);
}
}

    /// `Inventory.add(slot, stack)`.
pub fn inventory_add_at(self: *Self, env: *Env, slot: usize, stack: *mut ItemStack) void {
}
    // rust: if stack.count == 0 {
    // rust: return;
}
    // rust: if Self::damageable(env, stack) && stack.damage > 0 {
    // rust: self.containers[PLAYER][slot] = Some(stack.clone());
    // rust: stack.count = 0;
    // rust: return;
}
    // rust: loop {
    // rust: let last = stack.count;
            // addResource(slot, stack)
    // rust: let cell = self.containers[PLAYER][slot].get_or_insert_with(|| ItemStack {
    // rust: count: 0,
    // rust: ..stack.clone()
    // rust: });
    // rust: let room = Self::max_stack(env, cell).saturating_sub(cell.count);
    // rust: let add = stack.count.min(room);
    // rust: cell.count += add;
    // rust: stack.count -= add;
    // rust: tidy(&mut self.containers[PLAYER][slot]);
    // rust: if stack.count == 0 || stack.count >= last {
    // rust: if stack.count == last && self.creative {
    // rust: stack.count = 0;
}
    // rust: return;
}
}
}

    /// `testClearGrid`: whether the inventory can take the grid back.
pub fn test_clear_grid(self: *Self, env: *Env, grid: *Grid) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut free_slots: Vec<ItemStack> = Vec::new();
    // rust: let free_in_inventory = self.containers[PLAYER][..36]
    // rust: .iter()
    // rust: .filter(|s| s.is_none())
    // rust: .count();
    // rust: for &s in &grid.inputs {
    // rust: let Some(mut stack) = self.slot(s).cloned() else {
    // rust: continue;
}
    // rust: let with_space = self.slot_with_space(env, &stack);
    // rust: if with_space.is_none() && free_slots.len() <= free_in_inventory {
    // rust: for listed in &mut free_slots {
    // rust: let max = Self::max_stack(env, listed);
    // rust: if listed.item == stack.item
    // rust: && listed.count != max
    // rust: && listed.count + stack.count <= max
    // rust: {
    // rust: listed.count += stack.count;
    // rust: stack.count = 0;
    // rust: break;
}
}
    // rust: if stack.count > 0 {
    // rust: if free_slots.len() >= free_in_inventory {
    // rust: return false;
}
    // rust: free_slots.push(stack);
}
    // rust: } else if with_space.is_none() {
    // rust: return false;
}
}
    // rust: true
}
}

    // rust: mod tests {
//     use super::*;

pub fn ing(items: *[[]const u8]) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ingredient::of(items.iter().map(|s| (*s).to_owned()).collect())
}
pub fn have(items: *[([]const u8) void {
}
    // rust: let mut s = Stacked::default();
    // rust: for (item, n) in items {
    // rust: s.account(&Arc::from(*item), *n);
}
    // rust: s
}
pub fn a_single_item_can_fill_several_ingredients() void {
}
    // rust: let planks = ing(&["minecraft:oak_planks", "minecraft:birch_planks"]);
    // rust: let reqs = [&planks, &planks, &planks, &planks];
    // rust: let mut a = have(&[("minecraft:oak_planks", 2), ("minecraft:birch_planks", 2)]);
    // rust: assert!(a.can_craft(&reqs));
        // Two sets need 8 planks, but only 4 are there.
    // rust: assert!(!a.try_pick(&reqs, 2, None));
    // rust: assert_eq!(a.try_pick_all(&reqs, i32::MAX, None), 1);
    // rust: assert_eq!(
    // rust: have(&[("minecraft:oak_planks", 64)]).try_pick_all(&reqs, i32::MAX, None),
    // rust: 16
    // rust: );
        // Picking leaves the counts as they were.
    // rust: assert!(a.try_pick(&reqs, 1, None));
    // rust: assert!(a.can_craft(&reqs));
}
pub fn the_matching_reassigns_flexible_ingredients() void {
}
        // The first ingredient takes either item, the second only the stick:
        // the first item tried (the stick) moves over to free it.
    // rust: let any = ing(&["minecraft:stick", "minecraft:bone"]);
    // rust: let stick = ing(&["minecraft:stick"]);
    // rust: let mut a = have(&[("minecraft:stick", 1), ("minecraft:bone", 1)]);
    // rust: let mut used = Vec::new();
    // rust: assert!(a.try_pick(&[&any, &stick], 1, Some(&mut used)));
    // rust: assert_eq!(&*used[0], "minecraft:bone");
    // rust: assert_eq!(&*used[1], "minecraft:stick");
    // rust: assert!(!have(&[("minecraft:stick", 1)]).can_craft(&[&any, &stick]));
}
pub fn the_order_decides_between_fitting_items() void {
}
    // rust: let planks = ing(&["minecraft:oak_planks", "minecraft:birch_planks"]);
    // rust: let mut a = have(&[("minecraft:oak_planks", 4), ("minecraft:birch_planks", 4)]);
    // rust: let mut used = Vec::new();
    // rust: a.try_pick(&[&planks], 1, Some(&mut used));
    // rust: assert_eq!(&*used[0], "minecraft:oak_planks");
    // rust: a.set_order(&["minecraft:birch_planks".to_owned()]);
    // rust: used.clear();
    // rust: a.try_pick(&[&planks], 1, Some(&mut used));
    // rust: assert_eq!(&*used[0], "minecraft:birch_planks");
}
pub fn damaged_or_named_stacks_are_not_counted() void {
}
    // rust: let mut named = ItemStack::new("minecraft:stick", 4);
    // rust: named.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("x".into()));
    // rust: let mut damaged = ItemStack::new("minecraft:iron_sword", 1);
    // rust: damaged.damage = 3;
    // rust: let mut s = Stacked::default();
    // rust: for stack in [&named, &damaged, &ItemStack::new("minecraft:stick", 2)] {
    // rust: s.account_simple(stack, 64);
}
    // rust: assert_eq!(s.keys().len(), 1);
    // rust: assert!(s.can_craft(&[&ing(&["minecraft:stick"]), &ing(&["minecraft:stick"])]));
    // rust: assert!(!s.can_craft(&[&ing(&["minecraft:stick"]); 3]));
}
}
