//! Transpiled from Horizon Rust crate
//! Module: horizon-client_item_break
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `LivingEntity.breakItem` as a client sees it. A server never plays the
//! break itself: `LivingEntity.onEquippedItemBroken` broadcasts the entity
//! event `entityEventForEquipmentBreak` gives for the slot, and each client's
//! `LivingEntity.handleEntityEvent` breaks the item it still draws in that
//! slot (`getItemBySlot`), with the sound and the crumbs.
// use super::Mob;
// use crate::items::ItemStack;
// use horizon_world::player_inventory::EquipmentSlot;

/// `LivingEntity.handleEntityEvent` 47 to 52, 65 and 68: the slot whose
/// item broke (the inverse of `entityEventForEquipmentBreak`).
pub fn equipment_break_slot(event: i8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match event {
    // rust: 47 => EquipmentSlot::MainHand,
    // rust: 48 => EquipmentSlot::OffHand,
    // rust: 49 => EquipmentSlot::Head,
    // rust: 50 => EquipmentSlot::Chest,
    // rust: 51 => EquipmentSlot::Legs,
    // rust: 52 => EquipmentSlot::Feet,
    // rust: 65 => EquipmentSlot::Body,
    // rust: 68 => EquipmentSlot::Saddle,
    // rust: _ => return None,
    // rust: })
}

/// `LivingEntity.entityEventForEquipmentBreak`: the event whose client side
/// breaks the item in `slot` (the inverse of `equipment_break_slot`).
pub fn equipment_break_event(slot: EquipmentSlot) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match slot {
    // rust: EquipmentSlot::MainHand => 47,
    // rust: EquipmentSlot::OffHand => 48,
    // rust: EquipmentSlot::Head => 49,
    // rust: EquipmentSlot::Chest => 50,
    // rust: EquipmentSlot::Legs => 51,
    // rust: EquipmentSlot::Feet => 52,
    // rust: EquipmentSlot::Body => 65,
    // rust: EquipmentSlot::Saddle => 68,
}
}

    // rust: impl Mob {
    /// `LivingEntity.getItemBySlot` for a mob or another player a server
    /// sends: the stack it wears or holds in `slot`, with the components
    /// `ClientboundSetEquipmentPacket` gave it where they are kept.
pub fn item_by_slot(self: *Self, slot: EquipmentSlot) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let e = &self.extra;
    // rust: let plain = |id: &Option<std::sync::Arc<str>>| id.as_deref().map(|i| ItemStack::new(i, 1));
    // rust: let worn = |index: usize, id: &Option<std::sync::Arc<str>>| {
    // rust: e.armor[index]
    // rust: .clone()
    // rust: .filter(|s| id.as_ref() == Some(&s.item))
    // rust: .or_else(|| plain(id))
}
    // rust: match slot {
    // rust: EquipmentSlot::MainHand => e.main_hand_stack().cloned().or_else(|| plain(&e.main_hand)),
    // rust: EquipmentSlot::OffHand => plain(&e.off_hand),
    // rust: EquipmentSlot::Head => worn(0, &e.head),
    // rust: EquipmentSlot::Chest => worn(1, &e.chest),
    // rust: EquipmentSlot::Legs => worn(2, &e.legs),
    // rust: EquipmentSlot::Feet => worn(3, &e.feet),
            // The body armour (a wolf's, a horse's, a llama's carpet) is
            // kept in `body`, with the durability it has lost.
    // rust: EquipmentSlot::Body => plain(&e.body).map(|s| ItemStack {
    // rust: damage: e.body_damage.max(0) as u32,
    // rust: ..s
    // rust: }),
    // rust: EquipmentSlot::Saddle => self.saddle_item(),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::Species;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

pub fn mob(id: []const u8, species: Species) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = id.into();
    // rust: k.species = species;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    /// `LivingEntity.entityEventForEquipmentBreak` and its inverse agree for
    /// every slot a mob or another player can wear something in.
pub fn the_break_event_and_its_slot_are_inverses() void {
}
    // rust: for slot in EquipmentSlot::ALL {
    // rust: let event = equipment_break_event(slot);
    // rust: assert_eq!(equipment_break_slot(event), Some(slot), "event {event}");
}
    // rust: assert_eq!(equipment_break_event(EquipmentSlot::Body), 65);
    // rust: assert_eq!(equipment_break_event(EquipmentSlot::Saddle), 68);
}

    /// `LivingEntity.entityEventForEquipmentBreak`: 47 main hand, 48 off hand,
    /// 49 to 52 head to feet, 65 body, 68 saddle; other events break nothing.
pub fn each_equipment_break_event_names_its_slot() void {
}
    // rust: let slots = [
    // rust: (47, EquipmentSlot::MainHand),
    // rust: (48, EquipmentSlot::OffHand),
    // rust: (49, EquipmentSlot::Head),
    // rust: (50, EquipmentSlot::Chest),
    // rust: (51, EquipmentSlot::Legs),
    // rust: (52, EquipmentSlot::Feet),
    // rust: (65, EquipmentSlot::Body),
    // rust: (68, EquipmentSlot::Saddle),
    // rust: ];
    // rust: for (event, slot) in slots {
    // rust: assert_eq!(equipment_break_slot(event), Some(slot), "event {event}");
}
    // rust: for event in [2, 3, 35, 46, 53, 54, 55, 60, 64, 66, 67, 69] {
    // rust: assert_eq!(equipment_break_slot(event), None, "event {event}");
}
}

    /// The stack another player (an avatar, as a mannequin) holds or wears
    /// is the one that breaks.
pub fn a_player_breaks_what_it_holds_and_wears() void {
}
    // rust: let mut p = mob("minecraft:player", Species::Mannequin);
    // rust: let mut pick = ItemStack::new("minecraft:diamond_pickaxe", 1);
    // rust: pick.damage = 1560;
    // rust: p.extra.set_main_hand_stack(Some(pick.clone()));
    // rust: p.extra.off_hand = Some("minecraft:shield".into());
    // rust: p.extra.head = Some("minecraft:iron_helmet".into());
    // rust: let mut boots = ItemStack::new("minecraft:leather_boots", 1);
    // rust: boots.damage = 64;
    // rust: p.extra.feet = Some(boots.item.clone());
    // rust: p.extra.armor[3] = Some(boots.clone());
    // rust: let item = |slot| p.item_by_slot(slot).map(|s: ItemStack| (s.item, s.damage));
    // rust: assert_eq!(
    // rust: item(EquipmentSlot::MainHand),
    // rust: Some((pick.item.clone(), 1560))
    // rust: );
    // rust: assert_eq!(
    // rust: item(EquipmentSlot::OffHand),
    // rust: Some(("minecraft:shield".into(), 0))
    // rust: );
    // rust: assert_eq!(
    // rust: item(EquipmentSlot::Head),
    // rust: Some(("minecraft:iron_helmet".into(), 0))
    // rust: );
    // rust: assert_eq!(item(EquipmentSlot::Feet), Some((boots.item.clone(), 64)));
    // rust: assert_eq!(item(EquipmentSlot::Chest), None);
    // rust: assert_eq!(item(EquipmentSlot::Body), None);
    // rust: assert_eq!(item(EquipmentSlot::Saddle), None);
}

    /// A wolf's armour is its body slot (kept in `body`), and a horse's
    /// saddle its saddle slot.
pub fn body_armour_and_saddles_break_from_their_slots() void {
}
    // rust: let mut wolf = mob("minecraft:wolf", Species::Wolf);
    // rust: wolf.extra.body = Some("minecraft:wolf_armor".into());
    // rust: wolf.extra.body_damage = 63;
    // rust: let armour = wolf.item_by_slot(EquipmentSlot::Body).unwrap();
    // rust: assert_eq!((&*armour.item, armour.damage), ("minecraft:wolf_armor", 63));
    // rust: assert_eq!(wolf.item_by_slot(EquipmentSlot::Head), None);

    // rust: let mut horse = mob("minecraft:horse", Species::Horse);
    // rust: horse.set_saddle(Some(ItemStack::new("minecraft:saddle", 1)));
    // rust: assert_eq!(
    // rust: horse.item_by_slot(EquipmentSlot::Saddle).map(|s| s.item),
    // rust: Some("minecraft:saddle".into())
    // rust: );
}

    /// `Wolf.actuallyHurt`: each time the armor's crackiness level changes it
    /// plays the crack sound and sends twenty armadillo scute particles.
pub fn a_wolfs_armor_throws_scutes_as_it_cracks() void {
}
//         use crate::mobs::MobEvent;
    // rust: let mut wolf = mob("minecraft:wolf", Species::Wolf);
    // rust: wolf.extra.body = Some("minecraft:wolf_armor".into());
        // Levels change below 95%, 69% and 32% of the 64 points left, that is
        // after 4, 20 and 44 points of wear.
    // rust: let hurt = |wolf: &mut Mob, damage: f32| {
    // rust: wolf.hurt_wolf_armor(damage);
    // rust: std::mem::take(&mut wolf.outbox)
}
    // rust: let scutes = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| {
    // rust: matches!(
    // rust: e,
    // rust: MobEvent::ItemParticles {
    // rust: item: "minecraft:armadillo_scute",
    // rust: at,
    // rust: spread,
    // rust: speed,
    // rust: count: 20,
    // rust: } if *at == [0.0, 1.0, 0.0] && *spread == [0.2, 0.1, 0.2] && *speed == 0.1
    // rust: )
    // rust: })
    // rust: .count()
}
    // rust: let cracks = |events: &[MobEvent]| {
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::Sound("item.wolf_armor.crack", ..)))
    // rust: .count()
}
        // Three points: still the first level.
    // rust: let events = hurt(&mut wolf, 3.0);
    // rust: assert_eq!((cracks(&events), scutes(&events)), (0, 0));
        // The fourth point cracks it, with the sound and the scutes together.
    // rust: let events = hurt(&mut wolf, 1.0);
    // rust: assert_eq!((cracks(&events), scutes(&events)), (1, 1));
        // Within the level: nothing.
    // rust: let events = hurt(&mut wolf, 10.0);
    // rust: assert_eq!((cracks(&events), scutes(&events)), (0, 0));
        // Over 69%: the next level.
    // rust: let events = hurt(&mut wolf, 6.0);
    // rust: assert_eq!((cracks(&events), scutes(&events)), (1, 1));
}
}
