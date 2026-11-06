//! Transpiled from Horizon Rust crate
package horizon_client_inv_sort

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's sorting extra (#332, `docs/extras.md`): the left clicks that
// sort a run of slots, starting and ending with an empty hand, as a player
// could click them, so a vanilla server accepts them. Partial stacks of
// one item merge first; then the stacks go in rank order (creative tab
// order, then name), full stacks before the partial one, empty slots last.
// use crate::items::ItemStack;

// A stack's place in the order: its index in the creative tabs (items
// outside them after), then its name.
    // rust: pub type Rank = (usize, String);

// A hand and slots under `AbstractContainerMenu.doClick`'s left `PICKUP`.
Sim :: struct {
    slots: [dynamic]Maybe(ItemStack),
    hand: Maybe(ItemStack),
    max: ^'a dyn Fn(^ItemStack) -> u32,
    clicks: [dynamic]uint,
}
    // rust: impl Sim<'_> {
click :: proc(self: ^Self, i: uint) {
}
    // rust: self.clicks.push(i);
    // rust: let slot = self.slots[i].take();
    // rust: match (self.hand.take(), slot) {
            // Take the stack, or put the hand's down.
    // rust: (None, s) => self.hand = s,
    // rust: (Some(h), None) => self.slots[i] = Some(h),
            // The same item: as much as fits joins the slot.
    // rust: (Some(mut h), Some(mut s)) if s.same_item_same_components(&h) => {
    // rust: let n = (self.max)(&s).saturating_sub(s.count).min(h.count);
    // rust: s.count += n;
    // rust: h.count -= n;
    // rust: self.slots[i] = Some(s);
    // rust: self.hand = (h.count > 0).then_some(h);
}
            // Another item: they swap.
    // rust: (Some(h), Some(s)) => {
    // rust: self.slots[i] = Some(h);
    // rust: self.hand = Some(s);
}
}
}
partial :: proc(self: ^Self, i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.slots[i].as_ref().filter(|s| s.count < (self.max)(s))
}
}

// The indices of `slots` to left-click, in order, to sort them. Empty
// when they are sorted already, or when the clicks couldn't reach the
// order (stacks over their maximum).
    // rust: pub fn plan(
    // rust: slots: &[Option<ItemStack>],
    // rust: rank: &dyn Fn(&ItemStack) -> Rank,
    // rust: max: &dyn Fn(&ItemStack) -> u32,
    // rust: ) -> Vec<usize> {
    // rust: let n = slots.len();
    // rust: let mut sim = Sim {
    // rust: slots: slots.to_vec(),
    // rust: hand: None,
    // rust: max,
    // rust: clicks: Vec::new(),
}
    // Merge: each later partial stack of the item tops up the first one;
    // what doesn't fit goes back.
    // rust: for i in 0..n {
    // rust: for j in i + 1..n {
    // rust: let Some(s) = sim.partial(i) else {
    // rust: break;
}
    // rust: if !sim
    // rust: .partial(j)
    // rust: .is_some_and(|t| t.same_item_same_components(s))
    // rust: {
    // rust: continue;
}
    // rust: sim.click(j);
    // rust: sim.click(i);
    // rust: if sim.hand.is_some() {
    // rust: sim.click(j);
}
}
}
    // rust: let stacks: Vec<ItemStack> = sim.slots.iter().flatten().cloned().collect();
    // rust: let ranks: Vec<Rank> = stacks.iter().map(rank).collect();
    // rust: let mut order: Vec<usize> = (0..stacks.len()).collect();
    // rust: order.sort_by(|&a, &b| {
    // rust: ranks[a]
    // rust: .cmp(&ranks[b])
    // rust: .then(stacks[b].count.cmp(&stacks[a].count))
    // rust: });
    // rust: let target: Vec<Option<ItemStack>> = order
    // rust: .iter()
    // rust: .map(|&i| Some(stacks[i].clone()))
    // rust: .chain(std::iter::repeat(None))
    // rust: .take(n)
    // rust: .collect();
    // Order: each slot takes its stack from further on; what it held goes
    // where that stack was. A full stack clicked on the item's partial one
    // fills it and takes the rest, which comes to the same.
    // rust: for i in 0..n {
    // rust: if sim.slots[i] == target[i] {
    // rust: continue;
}
    // rust: let Some(j) = (i + 1..n).find(|&j| sim.slots[j] == target[i]) else {
    // rust: return Vec::new();
}
    // rust: sim.click(j);
    // rust: sim.click(i);
    // rust: if sim.hand.is_some() {
    // rust: sim.click(j);
}
}
    // rust: if sim.hand.is_some() || sim.slots != target {
    // rust: return Vec::new();
}
    // rust: sim.clicks
}

    // rust: mod tests {
//     use super::*;
//     use crate::menu::{Input, Kind};

stack :: proc(item: string, count: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(ItemStack {
    // rust: item: format!("minecraft:{item}").into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: })
}
rank :: proc(order: ^'static [^'static str]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: move |s| {
    // rust: let id = s.item.trim_start_matches("minecraft:");
    // rust: let i = order.iter().position(|o| *o == id).unwrap_or(usize::MAX);
    // rust: (i, id.to_owned())
}
}
max :: proc(s: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match &*s.item {
    // rust: "minecraft:ender_pearl" => 16,
    // rust: "minecraft:diamond_sword" => 1,
    // rust: _ => 64,
}
}
ORDER :: &["stone", "dirt", "diamond_sword", "ender_pearl"]

merges_partial_stacks_then_orders_full_stacks_first :: proc() {
}
    // rust: let slots = vec![
    // rust: stack("ender_pearl", 3),
    // rust: None,
    // rust: stack("dirt", 40),
    // rust: stack("stone", 64),
    // rust: stack("dirt", 40),
    // rust: stack("ender_pearl", 15),
    // rust: stack("diamond_sword", 1),
    // rust: stack("zombie_head", 1),
    // rust: ];
    // rust: let clicks = plan(&slots, &rank(ORDER), &max);
    // rust: let mut sim = Sim {
    // rust: slots: slots.clone(),
    // rust: hand: None,
    // rust: max: &max,
    // rust: clicks: Vec::new(),
}
    // rust: for i in clicks {
    // rust: sim.click(i);
}
    // rust: assert_eq!(sim.hand, None);
    // rust: assert_eq!(
    // rust: sim.slots,
    // rust: vec![
    // rust: stack("stone", 64),
    // rust: stack("dirt", 64),
    // rust: stack("dirt", 16),
    // rust: stack("diamond_sword", 1),
    // rust: stack("ender_pearl", 16),
    // rust: stack("ender_pearl", 2),
    // rust: stack("zombie_head", 1),
    // rust: None,
    // rust: ]
    // rust: );
        // Sorted slots need no clicks.
    // rust: assert!(plan(&sim.slots, &rank(ORDER), &max).is_empty());
}

the_clicks_sort_a_chest_in_the_menu_engine :: proc() {
}
        // The planned clicks replayed as left PICKUPs on a ChestMenu: the
        // engine (checked against the server jar) ends in the planned order.
    // rust: crate::menu::tests::with_menu(Kind::Chest(3), |env, menu| {
    // rust: let max = |s: &ItemStack| env.items.get(&s.item).map_or(64, |i| i.max_stack);
    // rust: let names = ["stone", "dirt", "ender_pearl", "oak_log", "snowball"];
    // rust: let mut seed = 7u32;
    // rust: for round in 0..40 {
    // rust: let slots: Vec<Option<ItemStack>> = (0..27)
    // rust: .map(|_| {
    // rust: seed = seed.wrapping_mul(1_103_515_245).wrapping_add(12_345);
    // rust: let pick = (seed >> 16) as usize % 8;
    // rust: let item = names.get(pick)?;
    // rust: let top = if *item == "ender_pearl" || *item == "snowball" {
    // rust: 16
    // rust: } else {
    // rust: 64
}
    // rust: stack(item, 1 + (seed >> 8) % top)
    // rust: })
    // rust: .collect();
    // rust: for (i, s) in slots.iter().enumerate() {
    // rust: menu.set_slot(env, i, s.clone());
}
    // rust: let clicks = plan(&slots, &rank(&["oak_log", "stone", "dirt"]), &max);
    // rust: for i in &clicks {
    // rust: menu.click(env, *i as i32, 0, Input::Pickup).unwrap();
}
    // rust: assert_eq!(menu.carried, None, "round {round}");
    // rust: let after: Vec<Option<ItemStack>> =
    // rust: (0..27).map(|i| menu.slot(i).cloned()).collect();
    // rust: let total = |v: &[Option<ItemStack>], item: &str| -> u32 {
    // rust: v.iter()
    // rust: .flatten()
    // rust: .filter(|s| s.item.ends_with(item))
    // rust: .map(|s| s.count)
    // rust: .sum()
}
    // rust: for item in names {
    // rust: assert_eq!(total(&slots, item), total(&after, item), "round {round}");
}
    // rust: assert!(plan(&after, &rank(&["oak_log", "stone", "dirt"]), &max).is_empty());
    // rust: let items: Vec<&str> = after.iter().flatten().map(|s| &*s.item).collect();
    // rust: let mut sorted = items.clone();
    // rust: sorted.sort_by_key(|id| {
    // rust: rank(&["oak_log", "stone", "dirt"])(&stack(&id[10..], 1).unwrap())
    // rust: });
    // rust: assert_eq!(items, sorted, "round {round}");
}
    // rust: });
}
}
