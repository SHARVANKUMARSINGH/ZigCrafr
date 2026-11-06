//! Transpiled from Horizon Rust crate
package horizon_client_armor

import "core:fmt"
import "core:mem"
import "core:math"

// Effective mob armor and toughness at the damage boundary.
// use super::{Mob, Species};
// use horizon_world::attributes::{Definition, Instance, Observer, entity::EntityAttributes};
// use std::convert::Infallible;

Calculation :: struct {
    // rust: impl Observer for Calculation {
    // rust: type Error = Infallible;
dirty :: proc(self: ^Self, _: ^Instance) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
}

    // rust: fn effective(
    // rust: map: Option<&EntityAttributes>,
    // rust: name: &str,
    // rust: base: f64,
    // rust: bonus: f64,
    // rust: maximum: f64,
    // rust: ) -> f64 {
    // rust: if let Some(map) = map
    // rust: && let Some(key) = map.catalog().id(name)
    // rust: {
    // rust: if let Some(source) = map.instance(key) {
            // Equipment and the covered shell contribute in the additive
            // phase, before multiplicative modifiers and effective clamping.
    // rust: let mut value = source.clone();
    // rust: value
    // rust: .set_base_value(source.base_value() + bonus, &mut Calculation)
    // rust: .unwrap();
    // rust: return value.value();
}
    // rust: let definition = map.catalog().attribute(key).definition;
    // rust: return definition.sanitize(map.base_value(key).unwrap_or(base) + bonus);
}
    // rust: Definition::ranged(0.0, 0.0, maximum)
    // rust: .unwrap()
    // rust: .sanitize(base + bonus)
}

// LivingEntity.getArmorValue floors the effective double before converting
// its integer result to float. Toughness converts its effective double directly.
values :: proc(mob: ^Mob) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (worn, worn_toughness) = mob.worn_armor();
    // rust: let covered = if mob.species() == Species::Shulker && mob.extra.counter == 0 {
    // rust: 20.0
    // rust: } else {
    // rust: 0.0
}
    // rust: let map = mob.extra.armor_attributes.as_deref();
    // rust: let armor = effective(
    // rust: map,
    // rust: "minecraft:armor",
    // rust: f64::from(mob.kind.armor),
    // rust: f64::from(worn) + covered,
    // rust: 30.0,
    // rust: );
    // rust: let toughness = effective(
    // rust: map,
    // rust: "minecraft:armor_toughness",
    // rust: f64::from(mob.kind.armor_toughness),
    // rust: f64::from(worn_toughness),
    // rust: 20.0,
    // rust: );
    // rust: (armor.floor() as i32 as f32, toughness as f32)
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::{Damage, DamageKind};
//     use horizon_core::geometry::Vec3;
//     use horizon_world::attributes::entity::Catalog;
//     use std::sync::Arc;

pig :: proc(armor: f64, toughness: f64) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let bits = |v: f64| format!("{:016x}", v.to_bits());
    // rust: let catalog = Arc::new(Catalog::from_json(&serde_json::json!({
    // rust: "data_version": horizon_world::DATA_VERSION,
    // rust: "attributes": [
    // rust: {"id":"minecraft:armor", "default":bits(0.0), "min":bits(0.0), "max":bits(30.0), "syncable":true},
    // rust: {"id":"minecraft:armor_toughness", "default":bits(0.0), "min":bits(0.0), "max":bits(20.0), "syncable":true}
    // rust: ],
    // rust: "entities": {"minecraft:pig":{"minecraft:armor":bits(0.0), "minecraft:armor_toughness":bits(0.0)}}
    // rust: })).unwrap());
    // rust: let mut attributes = catalog.create("minecraft:pig").unwrap();
    // rust: for (name, base) in [
    // rust: ("minecraft:armor", armor),
    // rust: ("minecraft:armor_toughness", toughness),
    // rust: ] {
    // rust: let key = catalog.id(name).unwrap();
    // rust: attributes.edit(key, |value, observer| {
    // rust: value.set_base_value(base, observer).unwrap()
    // rust: });
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:pig".into();
    // rust: ty.species = Species::Pig;
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: mob.extra.armor_attributes = Some(Box::new(attributes));
    // rust: mob.attrs.max_health = 1000.0;
    // rust: mob.health = 1000.0;
    // rust: mob
}

effective_mob_armor_controls_damage_and_fractional_armor_floors :: proc() {
}
    // rust: for (armor, toughness, source, expected) in [
    // rust: (20.0, 8.0, DamageKind::Cactus, 999039),
    // rust: (0.0, 8.0, DamageKind::Cactus, 996000),
    // rust: (0.5, 8.0, DamageKind::Cactus, 996000),
    // rust: (20.0, 8.0, DamageKind::SonicBoom, 996000),
    // rust: ] {
    // rust: let mut mob = pig(armor, toughness);
    // rust: assert!(mob.damage(4.0, Damage::of(source)));
    // rust: assert_eq!((f64::from(mob.health) * 1000.0) as i32, expected);
}
}

equipment_and_covered_shell_are_counted_once_before_effective_limits :: proc() {
}
    // rust: let mut mob = pig(20.0, 8.0);
    // rust: mob.extra.head = Some("minecraft:diamond_helmet".into());
    // rust: assert_eq!(values(&mob), (23.0, 10.0));
    // rust: mob.extra.head = None;
    // rust: Arc::make_mut(&mut mob.kind).species = Species::Shulker;
    // rust: let map = mob.extra.armor_attributes.as_deref_mut().unwrap();
    // rust: let key = map.catalog().id("minecraft:armor").unwrap();
    // rust: map.edit(key, |value, observer| {
    // rust: value.set_base_value(5.0, observer).unwrap()
    // rust: });
    // rust: mob.extra.counter = 0;
    // rust: assert_eq!(values(&mob), (25.0, 8.0));
    // rust: mob.extra.counter = 1;
    // rust: assert_eq!(values(&mob), (5.0, 8.0));
    // rust: let mob = pig(100.0, 100.0);
    // rust: assert_eq!(values(&mob), (30.0, 20.0));
}
}
