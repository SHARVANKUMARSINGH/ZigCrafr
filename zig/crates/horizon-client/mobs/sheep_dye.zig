//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sheep_dye
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `DyeItem.interactLivingEntity`: the client hears it, the server changes wool.
// use super::{Mob, Species, render::DYE_NAMES};
// use crate::items::ItemStack;
// use horizon_world::nbt::Tag;

/// The sixteen vanilla DyeItems dispatch this interaction. Their DYE component
/// can be overridden or removed without changing the underlying Item class.
pub fn color(stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: let name = stack
    // rust: .item
    // rust: .strip_prefix("minecraft:")?
    // rust: .strip_suffix("_dye")?;
    // rust: let default = DYE_NAMES.iter().position(|&d| d == name)? as u8;
    // rust: if let Some(data) = stack.data() {
    // rust: if data.other("!minecraft:dye").is_some() {
    // rust: return None;
}
    // rust: if let Some(value) = data.other("minecraft:dye") {
    // rust: let Tag::String(name) = value else {
    // rust: return None;
}
    // rust: return DYE_NAMES
    // rust: .iter()
    // rust: .position(|&d| d == name.to_string_lossy())
    // rust: .map(|i| i as u8);
}
}
    // rust: Some(default)
}

/// Whether this invocation plays DYE_USE. Client state is deliberately left
/// untouched, so repeated client clicks keep playing until metadata arrives.
/// Player.interactOn's creative count restoration belongs to the caller.
pub fn interact(mob: *mut Mob, stack: *mut ItemStack, client: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if mob.species() != Species::Sheep || !mob.alive() || mob.extra.sheared {
    // rust: return false;
}
    // rust: let Some(color) = color(stack).filter(|&c| c != mob.extra.color) else {
    // rust: return false;
}
    // rust: if !client {
    // rust: mob.extra.color = color;
    // rust: stack.count -= 1;
}
    // rust: true
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

pub fn sheep() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: Arc::make_mut(&mut kind).species = Species::Sheep;
    // rust: Mob::new(37, kind, Vec3::ZERO, 0.0)
}

pub fn client_repeats_without_consuming_or_predicting_the_color() void {
}
    // rust: let mut mob = sheep();
    // rust: let mut stack = ItemStack::new("minecraft:red_dye", 2);
    // rust: for _ in 0..2 {
    // rust: assert!(interact(&mut mob, &mut stack, true));
    // rust: assert_eq!(mob.extra.color, 0);
    // rust: assert_eq!(stack.count, 2);
}
    // rust: assert!(interact(&mut mob, &mut stack, false));
    // rust: assert_eq!(mob.extra.color, 14);
    // rust: assert_eq!(stack.count, 1);
    // rust: assert!(!interact(&mut mob, &mut stack, true));
    // rust: assert!(!interact(&mut mob, &mut stack, false));
}

pub fn component_patch_controls_color_but_does_not_make_a_stone_a_dye_item() void {
}
    // rust: let mut stack = ItemStack::new("minecraft:red_dye", 1);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:dye", Some(Tag::String("blue".into())));
    // rust: assert_eq!(color(&stack), Some(11));
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("!minecraft:dye", Some(Tag::Compound(Default::default())));
    // rust: assert_eq!(color(&stack), None);
    // rust: let mut stone = ItemStack::new("minecraft:stone", 1);
    // rust: stone
    // rust: .data_mut()
    // rust: .set_other("minecraft:dye", Some(Tag::String("red".into())));
    // rust: assert_eq!(color(&stone), None);
}
}
