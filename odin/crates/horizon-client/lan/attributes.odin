//! Transpiled from Horizon Rust crate
package horizon_client_attributes

import "core:fmt"
import "core:mem"
import "core:math"

// `ClientboundUpdateAttributesPacket`: the attribute instances a server syncs
// to its clients. `ServerEntity.sendPairingData` sends every client-syncable
// instance an entity has (`AttributeMap.getSyncableAttributes`: the instances
// created so far, not the type's defaults), `sendDirtyEntityData` the ones
// changed since (`getAttributesToSync`), to the trackers and the player itself.
// use horizon_protocol::packets::play::{AttributeModifier, AttributeSnapshot};
// use horizon_world::attributes::{
    // rust: Instance, Modifier, Operation,
    // rust: entity::{AttributeId, EntityAttributes},
    // rust: live::LiveAttributes,
}

// `AttributeModifier.Operation.id`.
operation_id :: proc(op: Operation) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match op {
    // rust: Operation::AddValue => 0,
    // rust: Operation::AddMultipliedBase => 1,
    // rust: Operation::AddMultipliedTotal => 2,
}
}

// An `Operation`'s serialized name (`add_value` ...) as its id.
operation_named :: proc(name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "add_multiplied_base" => 1,
    // rust: "add_multiplied_total" => 2,
    // rust: _ => 0,
}
}

// `AttributeSnapshot`: the base and every modifier, in the order they were added.
snapshot :: proc(attribute: AttributeId, instance: ^Instance) -> A {
    // Ported from Horizon
    return {}
}
    // rust: AttributeSnapshot {
    // rust: attribute: attribute.registry_id(),
    // rust: base: instance.base_value(),
    // rust: modifiers: instance
    // rust: .modifiers()
    // rust: .iter()
    // rust: .map(|m| AttributeModifier {
    // rust: id: m.id().to_owned(),
    // rust: amount: m.amount(),
    // rust: operation: operation_id(m.operation()),
    // rust: })
    // rust: .collect(),
}
}

// `AttributeMap.getSyncableAttributes` of a live map (a player's).
    // rust: pub fn syncable<G: FnMut() -> i32>(map: &LiveAttributes<G>) -> Vec<AttributeSnapshot> {
    // rust: let catalog = map.catalog();
    // rust: map.instances()
    // rust: .filter(|(_, key, _)| catalog.attribute(key.attribute()).syncable)
    // rust: .map(|(_, key, instance)| snapshot(key.attribute(), instance))
    // rust: .collect()
}

// `getAttributesToSync`, cleared once read (`ServerEntity.sendDirtyEntityData`).
    // rust: pub fn take_dirty<G: FnMut() -> i32>(map: &mut LiveAttributes<G>) -> Vec<AttributeSnapshot> {
    // rust: if map.sync().is_empty() {
    // rust: return Vec::new();
}
    // rust: let handles: Vec<_> = map.sync().values().flatten().cloned().collect();
    // rust: map.sync_mut().clear();
    // rust: handles
    // rust: .iter()
    // rust: .filter_map(|h| {
    // rust: let key = map.attribute(h).ok()?;
    // rust: Some(snapshot(key.attribute(), map.instance(h).ok()?))
    // rust: })
    // rust: .collect()
}

// `ClientPacketListener.handleUpdateAttributes`: each instance the server
// synced takes its base and exactly its modifiers (`removeModifiers`, then
// `addTransientModifier` for each). An attribute the map doesn't know is
// skipped, as vanilla warns and skips it.
    // rust: pub fn apply<G: FnMut() -> i32>(map: &mut LiveAttributes<G>, values: &[AttributeSnapshot]) {
    // rust: for s in values {
    // rust: let Some(key) = map
    // rust: .keys()
    // rust: .iter()
    // rust: .find(|k| k.attribute().registry_id() == s.attribute)
    // rust: .cloned()
    // rust: else {
    // rust: continue;
}
    // rust: let Ok(Some(handle)) = map.get_instance(Some(key)) else {
    // rust: continue;
}
    // rust: let modifiers: Vec<_> = s
    // rust: .modifiers
    // rust: .iter()
    // rust: .filter_map(|m| Modifier::new(&m.id, m.amount, operation(m.operation)).ok())
    // rust: .collect();
    // rust: let _ = map.edit(&handle, |instance, observer| {
    // rust: instance.set_base_value(s.base, observer)?;
    // rust: instance.remove_all(observer)?;
    // rust: for m in modifiers {
    // rust: instance.add_transient(m, observer)?;
}
    // rust: Ok(())
    // rust: });
}
}

// `AttributeModifier.Operation.BY_ID`.
operation :: proc(id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: 1 => Operation::AddMultipliedBase,
    // rust: 2 => Operation::AddMultipliedTotal,
    // rust: _ => Operation::AddValue,
}
}

// The client-syncable instances of a generic attribute map.
generic_syncable :: proc(map: ^EntityAttributes) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let catalog = map.catalog();
    // rust: catalog
    // rust: .attributes()
    // rust: .filter(|(_, a)| a.syncable)
    // rust: .filter_map(move |(id, _)| map.instance(id).map(|i| snapshot(id, i)))
}

// Adds a modifier to the snapshot of `attribute`, creating it with `base`.
    // rust: pub fn add_modifier(
    // rust: out: &mut Vec<AttributeSnapshot>,
    // rust: attribute: i32,
    // rust: base: f64,
    // rust: modifier: AttributeModifier,
    // rust: ) {
    // rust: let snapshot = instance(out, attribute, base);
    // rust: match snapshot.modifiers.iter_mut().find(|m| m.id == modifier.id) {
    // rust: Some(m) => *m = modifier,
    // rust: None => snapshot.modifiers.push(modifier),
}
}

// The snapshot of `attribute`, created with `base` if it isn't there yet.
    // rust: pub fn instance(
    // rust: out: &mut Vec<AttributeSnapshot>,
    // rust: attribute: i32,
    // rust: base: f64,
    // rust: ) -> &mut AttributeSnapshot {
    // rust: let i = match out.iter().position(|a| a.attribute == attribute) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: out.push(AttributeSnapshot {
    // rust: attribute,
    // rust: base,
    // rust: modifiers: Vec::new(),
    // rust: });
    // rust: out.len() - 1
}
}
    // rust: &mut out[i]
}

    // rust: mod tests {
//     use super::*;

modifiers_replace_by_id_and_instances_are_created_once :: proc() {
}
    // rust: let mut out = Vec::new();
    // rust: let m = |id: &str, amount| AttributeModifier {
    // rust: id: id.into(),
    // rust: amount,
    // rust: operation: 0,
}
    // rust: add_modifier(&mut out, 1, 0.0, m("minecraft:armor.helmet", 3.0));
    // rust: add_modifier(&mut out, 1, 5.0, m("minecraft:armor.chestplate", 8.0));
    // rust: add_modifier(&mut out, 1, 5.0, m("minecraft:armor.helmet", 2.0));
    // rust: assert_eq!(out.len(), 1);
    // rust: assert_eq!(out[0].base, 0.0);
    // rust: assert_eq!(
    // rust: out[0].modifiers,
    // rust: [
    // rust: m("minecraft:armor.helmet", 2.0),
    // rust: m("minecraft:armor.chestplate", 8.0)
    // rust: ]
    // rust: );
    // rust: instance(&mut out, 26, 0.7);
    // rust: assert_eq!(out.len(), 2);
}
}
