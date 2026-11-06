//! Transpiled from Horizon Rust crate
//! Module: horizon-client_conversion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Mob.convertTo` with `ConversionType.SINGLE`: one mob turns into another
//! of a different type in its place, keeping what the old one had.
// use super::Mob;

/// `ConversionParams` of a `SINGLE` conversion.
pub const Params = struct {
    /// `keepEquipment`: the worn and held items move to the new mob, with
    /// their drop chances.
    keep_equipment: bool,
    /// `preserveCanPickUpLoot`.
    preserve_can_pick_up_loot: bool,
};
    // rust: impl Params {
    /// `ConversionParams.single(mob, true, true)`, what `ConversionTracker`
    /// uses (zombie to drowned, husk to zombie, skeleton to stray).
    // rust: pub const KEEP_ALL: Self = Self {
    // rust: keep_equipment: true,
    // rust: preserve_can_pick_up_loot: true,
}
}

/// `ConversionType.SINGLE.convert` and `ConversionType.convertCommon`: `to`
/// is a fresh mob (`EntityType.create(level, CONVERSION)`, no spawn
/// finalization) that takes `from`'s place, motion, ride, lead, equipment,
/// effects, age, name and flags. Its health stays its own type's.
pub fn single(from: *Mob, to: *mut Mob, params: Params) void {
}
    // copyPosition, setDeltaMovement and the old mob's vehicle.
    // rust: to.position = from.position;
    // rust: to.previous = from.position;
    // rust: to.yaw = from.yaw;
    // rust: to.previous_yaw = from.yaw;
    // rust: to.head_yaw = from.head_yaw;
    // rust: to.previous_head_yaw = from.head_yaw;
    // rust: to.head_pitch = from.head_pitch;
    // rust: to.previous_head_pitch = from.head_pitch;
    // rust: to.velocity = from.velocity;
    // rust: to.extra.mount = from.extra.mount;
    // rust: to.extra.passenger = from.extra.passenger;
    // rust: if params.keep_equipment {
        // Every slot, copyAndClear, and setDropChance from the old mob.
    // rust: to.extra.set_main_hand(from.extra.main_hand.clone());
    // rust: if let Some(stack) = from.extra.main_hand_stack() {
    // rust: to.extra.set_main_hand_stack(Some(stack.clone()));
}
    // rust: to.extra.off_hand = from.extra.off_hand.clone();
    // rust: to.extra.head = from.extra.head.clone();
    // rust: to.extra.body = from.extra.body.clone();
    // rust: to.extra.chest = from.extra.chest.clone();
    // rust: to.extra.legs = from.extra.legs.clone();
    // rust: to.extra.feet = from.extra.feet.clone();
    // rust: to.extra.armor = from.extra.armor.clone();
    // rust: to.extra.gear = from.extra.gear.clone();
    // rust: to.extra.drop_chances = from.extra.drop_chances.clone();
}
    // rust: to.fall_distance = from.fall_distance;
    // rust: to.extra.fall_flying = from.extra.fall_flying;
    // rust: to.ai.last_hurt_by_player = from.ai.last_hurt_by_player;
    // rust: to.hurt_time = from.hurt_time;
    // rust: to.body_yaw = from.body_yaw;
    // rust: to.previous_body_yaw = from.body_yaw;
    // rust: to.on_ground = from.on_ground;
    // rust: to.extra.leash = from.extra.leash;
    // rust: to.extra.leash_pending = from.extra.leash_pending;
    // rust: to.extra.leash_player = from.extra.leash_player;
    // convertCommon.
    // rust: to.extra.effects = from.extra.effects.clone();
    // rust: to.extra.hidden_effects = from.extra.hidden_effects.clone();
    // rust: to.extra.ambient_effects = from.extra.ambient_effects.clone();
    // rust: if from.is_baby() {
    // rust: super::finalize::set_baby(to, true);
}
    // An ageable pair keeps the exact age, an adult's breeding cooldown too.
    // rust: if super::finalize::ageable(from.species()) && super::finalize::ageable(to.species()) {
    // rust: super::finalize::set_age(to, from.extra.age);
    // rust: to.extra.forced_age = from.extra.forced_age;
    // rust: to.extra.forced_age_timer = from.extra.forced_age_timer;
}
    // rust: if params.preserve_can_pick_up_loot {
    // rust: to.extra.pick_up_loot = from.extra.pick_up_loot;
}
    // rust: to.extra.left_handed = from.extra.left_handed;
    // rust: to.no_ai = from.no_ai;
    // rust: to.persistent |= from.persistent;
    // rust: to.name_visible = from.name_visible;
    // rust: to.invulnerable_flag = from.invulnerable_flag;
    // rust: to.invulnerable = from.invulnerable;
    // rust: to.no_gravity = from.no_gravity;
    // rust: to.silent = from.silent;
    // COMPONENTS_TO_COPY: the custom name.
    // rust: to.custom_name = from.custom_name.clone();
    // rust: to.custom_name_text = from.custom_name_text.clone();
    // A zombie that turns into another zombie keeps canBreakDoors.
    // rust: if super::doors::is_zombie(from.species()) && super::doors::is_zombie(to.species()) {
    // rust: super::doors::set_can_break_doors(to, from.extra.can_break_doors);
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::{items::ItemStack, mobs::world::with_test_world};
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

pub fn a_frozen_skeleton_becomes_a_stray_that_keeps_its_bow_and_name() void {
}
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id, kind: &str| {
    // rust: Mob::new(
    // rust: id,
    // rust: Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(3.5, 70.0, -2.5),
    // rust: 0.0,
    // rust: )
}
    // rust: let mut s = mob(1, "minecraft:skeleton");
    // rust: s.yaw = 90.0;
    // rust: s.custom_name = Some("Frosty".into());
    // rust: s.no_ai = true;
    // rust: s.extra
    // rust: .set_main_hand_stack(Some(ItemStack::new("minecraft:bow", 1)));
    // rust: s.extra.chest = Some("minecraft:chainmail_chestplate".into());
    // rust: s.extra.leash = Some(crate::mobs::leash::Holder::Knot([3, 71, -3]));
    // rust: s.extra.mount = Some(7);
    // rust: s.extra.passenger = true;
    // rust: let mut st = mob(2, "minecraft:stray");
    // rust: single(&s, &mut st, Params::KEEP_ALL);
    // rust: assert_eq!(st.custom_name.as_deref(), Some("Frosty"));
    // rust: assert!(st.no_ai);
    // rust: assert_eq!(st.yaw, 90.0);
    // rust: assert_eq!(
    // rust: st.extra.main_hand_stack().map(|s| &*s.item),
    // rust: Some("minecraft:bow")
    // rust: );
    // rust: assert_eq!(
    // rust: st.extra.chest.as_deref(),
    // rust: Some("minecraft:chainmail_chestplate")
    // rust: );
    // rust: assert_eq!(
    // rust: st.extra.leash,
    // rust: Some(crate::mobs::leash::Holder::Knot([3, 71, -3]))
    // rust: );
    // rust: assert_eq!(st.extra.mount, Some(7));
            // Health is the new type's own, not copied.
    // rust: assert_eq!(st.health, mob(3, "minecraft:stray").health);
            // Without keepEquipment the gear stays behind.
    // rust: let mut bare = mob(4, "minecraft:stray");
    // rust: single(
    // rust: &s,
    // rust: &mut bare,
    // rust: Params {
    // rust: keep_equipment: false,
    // rust: preserve_can_pick_up_loot: false,
    // rust: },
    // rust: );
    // rust: assert!(bare.extra.main_hand.is_none() && bare.extra.chest.is_none());
    // rust: assert_eq!(bare.custom_name.as_deref(), Some("Frosty"));
    // rust: });
}
}
