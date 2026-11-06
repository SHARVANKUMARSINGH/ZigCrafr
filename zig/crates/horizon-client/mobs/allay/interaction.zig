//! Transpiled from Horizon Rust crate
//! Module: horizon-client_interaction
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Client-side `Allay.mobInteract` state, before the authoritative server reply.
// use super::super::{Mob, Species};
// use crate::items::ItemStack;

pub const Interaction = enum {
    Duplicate,
    Give,
    Take(ItemStack),
};

    // rust: impl Interaction {
pub fn sound(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Duplicate => "minecraft:block.amethyst_block.chime",
    // rust: Self::Give => "minecraft:entity.allay.item_given",
    // rust: Self::Take(_) => "minecraft:entity.allay.item_taken",
}
}
}

/// `Allay.mobInteract`: clients update the hand and duplication flag too, so a
/// second click must use that predicted state. ClientLevel does not insert the
/// duplicate into its entity list; the server pairs the real child later.
    // rust: pub fn predict(
    // rust: mob: &mut Mob,
    // rust: offered: Option<&ItemStack>,
    // rust: main_hand: bool,
    // rust: duplicates: bool,
    // rust: actor: [i32; 4],
    // rust: ) -> Option<Interaction> {
    // rust: if mob.species() != Species::Allay || !mob.alive() {
    // rust: return None;
}
    // rust: let offered = offered.filter(|s| s.count > 0 && &*s.item != "minecraft:air");
    // rust: if mob.extra.flag && duplicates && offered.is_some() && mob.extra.egg_time == 0 {
    // rust: mob.extra.egg_time = 6000;
    // rust: return Some(Interaction::Duplicate);
}
    // rust: let held = mob.extra.main_hand_stack().cloned();
    // rust: if held.is_none()
    // rust: && let Some(mut given) = offered.cloned()
    // rust: {
    // rust: given.count = 1;
    // rust: mob.extra.set_main_hand_stack(Some(given));
    // rust: mob.extra.tame = true;
    // rust: mob.extra.owner = Some(actor);
    // rust: return Some(Interaction::Give);
}
    // rust: if main_hand
    // rust: && offered.is_none()
    // rust: && let Some(held) = held
    // rust: {
    // rust: mob.extra.set_main_hand(None);
    // rust: mob.extra.tame = false;
    // rust: mob.extra.owner = None;
    // rust: mob.swing();
    // rust: return Some(Interaction::Take(held));
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

pub fn allay() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let kind_mut = Arc::make_mut(&mut kind);
    // rust: kind_mut.species = Species::Allay;
    // rust: kind_mut.id = "minecraft:allay".into();
    // rust: Mob::new(37, kind, Vec3::ZERO, 0.0)
}

pub fn giving_and_taking_update_the_state_used_by_the_next_click() void {
}
    // rust: let mut mob = allay();
    // rust: let offered = ItemStack::new("minecraft:stone", 3);
    // rust: assert!(matches!(
    // rust: predict(&mut mob, Some(&offered), false, false, [1; 4]),
    // rust: Some(Interaction::Give)
    // rust: ));
    // rust: assert_eq!(mob.extra.main_hand_stack().unwrap().count, 1);
    // rust: assert_eq!(mob.extra.owner, Some([1; 4]));
    // rust: assert!(predict(&mut mob, Some(&offered), true, false, [1; 4]).is_none());
    // rust: assert!(predict(&mut mob, None, false, false, [1; 4]).is_none());
    // rust: let Some(Interaction::Take(returned)) = predict(&mut mob, None, true, false, [1; 4]) else {
    // rust: panic!("empty main hand takes the item")
}
    // rust: assert_eq!(&*returned.item, "minecraft:stone");
    // rust: assert_eq!(returned.count, 1);
    // rust: assert!(mob.extra.main_hand_stack().is_none());
    // rust: assert!(!mob.extra.tame);
    // rust: assert_eq!(mob.extra.owner, None);
    // rust: assert!(predict(&mut mob, None, true, false, [1; 4]).is_none());
}

pub fn duplication_requires_the_tag_and_ready_flag_and_is_not_repeated() void {
}
    // rust: let mut mob = allay();
    // rust: mob.extra.flag = true;
    // rust: mob.extra
    // rust: .set_main_hand_stack(Some(ItemStack::new("minecraft:stone", 1)));
    // rust: let offered = ItemStack::new("fixture:tagged_item", 2);
    // rust: assert!(predict(&mut mob, Some(&offered), false, false, [0; 4]).is_none());
    // rust: assert!(matches!(
    // rust: predict(&mut mob, Some(&offered), false, true, [0; 4]),
    // rust: Some(Interaction::Duplicate)
    // rust: ));
    // rust: assert_eq!(mob.extra.egg_time, 6000);
    // rust: assert!(predict(&mut mob, Some(&offered), false, true, [0; 4]).is_none());
    // rust: assert_eq!(
    // rust: &*mob.extra.main_hand_stack().unwrap().item,
    // rust: "minecraft:stone"
    // rust: );
}
}
