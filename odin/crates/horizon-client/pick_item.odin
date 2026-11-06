//! Transpiled from Horizon Rust crate
package horizon_client_pick_item

import "core:fmt"
import "core:mem"
import "core:math"

// Pick Block on the player's inventory: `ServerGamePacketListenerImpl.tryPickItem`
// with `Inventory.findSlotMatchingItem`, `pickSlot`, `addAndPickItem` and
// `getSuitableHotbarSlot`. `items` are the 36 main slots (0-8 the hotbar).
// use crate::items::ItemStack;

// Picks `stack` (the block's clone item): selects a matching stack already
// in the hotbar, or swaps one from the main inventory into a suitable
// hotbar slot; with infinite materials (creative) it adds the item when
// none is there. Returns whether anything changed.
    // rust: pub fn pick(
    // rust: items: &mut [Option<ItemStack>],
    // rust: selected: &mut usize,
    // rust: stack: &ItemStack,
    // rust: infinite_materials: bool,
    // rust: ) -> bool {
    // rust: let existing = items.iter().position(|s| {
    // rust: s.as_ref()
    // rust: .is_some_and(|s| s.same_item_same_components(stack))
    // rust: });
    // rust: match existing {
    // rust: Some(slot) if slot < 9 => *selected = slot,
    // rust: Some(slot) => {
            // pickSlot.
    // rust: *selected = suitable_hotbar_slot(items, *selected);
    // rust: items.swap(*selected, slot);
}
    // rust: None if infinite_materials => {
            // addAndPickItem: what the hotbar slot held moves to a free slot
            // (or is replaced when there is none).
    // rust: *selected = suitable_hotbar_slot(items, *selected);
    // rust: if items[*selected].is_some()
    // rust: && let Some(free) = items.iter().position(Option::is_none)
    // rust: {
    // rust: items[free] = items[*selected].take();
}
    // rust: items[*selected] = Some(stack.clone());
}
    // rust: None => return false,
}
    // rust: true
}

// `getSuitableHotbarSlot`: from the selected slot on, the first empty one,
// else the first without enchantments, else the selected one.
suitable_hotbar_slot :: proc(items: ^[Maybe(ItemStack)], selected: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let from = |ok: &dyn Fn(&Option<ItemStack>) -> bool| {
    // rust: (0..9).map(|i| (selected + i) % 9).find(|&i| ok(&items[i]))
}
    // rust: from(&|s| s.is_none())
    // rust: .or_else(|| from(&|s| s.as_ref().is_some_and(|s| s.enchantments().is_empty())))
    // rust: .unwrap_or(selected)
}

    // rust: mod tests {
//     use super::*;

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
inventory :: proc(filled: ^[(uint) {
}
    // rust: let mut items = vec![None; 36];
    // rust: for &(i, item) in filled {
    // rust: items[i] = stack(item, 5);
}
    // rust: items
}
stone :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: stack("stone", 1).unwrap()
}

survival_selects_a_matching_hotbar_stack :: proc() {
}
    // rust: let mut items = inventory(&[(0, "dirt"), (6, "stone"), (20, "stone")]);
    // rust: let mut selected = 2;
    // rust: assert!(pick(&mut items, &mut selected, &stone(), false));
    // rust: assert_eq!(selected, 6);
    // rust: assert_eq!(
    // rust: items,
    // rust: inventory(&[(0, "dirt"), (6, "stone"), (20, "stone")])
    // rust: );
}

survival_swaps_a_main_inventory_stack_into_the_hotbar :: proc() {
}
        // The first empty hotbar slot from the selected one, wrapping round.
    // rust: let mut items = inventory(&[(3, "dirt"), (4, "dirt"), (20, "stone")]);
    // rust: let mut selected = 3;
    // rust: assert!(pick(&mut items, &mut selected, &stone(), false));
    // rust: assert_eq!(selected, 5);
    // rust: assert_eq!(items[5], stack("stone", 5));
    // rust: assert_eq!(items[20], None);
        // A full hotbar: the selected slot (nothing is enchanted) trades places.
    // rust: let mut items: Vec<_> = (0..9).map(|_| stack("dirt", 5)).collect();
    // rust: items.extend((9..36).map(|i| if i == 30 { stack("stone", 5) } else { None }));
    // rust: let mut selected = 7;
    // rust: assert!(pick(&mut items, &mut selected, &stone(), false));
    // rust: assert_eq!(selected, 7);
    // rust: assert_eq!(
    // rust: (items[7].clone(), items[30].clone()),
    // rust: (stack("stone", 5), stack("dirt", 5))
    // rust: );
}

survival_without_the_item_does_nothing_and_creative_adds_it :: proc() {
}
    // rust: let before = inventory(&[(0, "dirt")]);
    // rust: let mut items = before.clone();
    // rust: let mut selected = 0;
    // rust: assert!(!pick(&mut items, &mut selected, &stone(), false));
    // rust: assert_eq!((items, selected), (before.clone(), 0));
        // Creative: the next empty hotbar slot takes one.
    // rust: let mut items = before;
    // rust: assert!(pick(&mut items, &mut selected, &stone(), true));
    // rust: assert_eq!(selected, 1);
    // rust: assert_eq!(items[1], stack("stone", 1));
        // A full hotbar: the slot's stack moves to the first free slot.
    // rust: let mut items: Vec<_> = (0..9).map(|_| stack("dirt", 5)).collect();
    // rust: items.extend(vec![None; 27]);
    // rust: let mut selected = 4;
    // rust: assert!(pick(&mut items, &mut selected, &stone(), true));
    // rust: assert_eq!(
    // rust: (selected, items[4].clone(), items[9].clone()),
    // rust: (4, stack("stone", 1), stack("dirt", 5))
    // rust: );
}
}
