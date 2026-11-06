//! Transpiled from Horizon Rust crate
package horizon_world_properties

import "core:fmt"
import "core:mem"
import "core:math"

// Compact property transitions derived from the pinned Cartesian state tables.
// use crate::registry::{BlockRegistry, BlockStateId};
// use std::collections::{BTreeMap, BTreeSet};
Address :: struct {
    block: uint,
    local: uint,
}
Property :: struct {
    identity: uint,
    name: string,
    values: [dynamic]string,
    lookup: BTreeMap<string,
    numeric: Option<BTreeMap<i32,
    stride: uint,
}
Block :: struct {
    states: [dynamic]BlockStateId,
    properties: [dynamic]Property,
}
    // rust: pub(crate) struct StateProperties {
    // rust: blocks: Vec<Block>,
    // rust: addresses: Vec<Address>,
}
    // rust: impl StateProperties {
    // rust: pub fn build(
    // rust: registry: &BlockRegistry,
    // rust: integers: &BTreeSet<(String, String)>,
    // rust: ) -> Result<Self, String> {
    // rust: let mut grouped = BTreeMap::<String, Vec<BlockStateId>>::new();
    // rust: for index in 0..registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: grouped
    // rust: .entry(registry.state(id).unwrap().name.clone())
    // rust: .or_default()
    // rust: .push(id);
}
    // rust: let mut identities = BTreeMap::new();
    // rust: let mut result = Self {
    // rust: blocks: Vec::new(),
    // rust: addresses: vec![Address { block: 0, local: 0 }; registry.len()],
}
    // rust: for (name, states) in grouped {
    // rust: let mut properties = Vec::new();
    // rust: let first = registry.state(states[0]).unwrap();
    // rust: for (property, initial) in &first.properties {
    // rust: let mut values = Vec::new();
    // rust: let mut lookup = BTreeMap::new();
    // rust: let mut stride = None;
    // rust: for (index, id) in states.iter().enumerate() {
    // rust: let state = registry.state(*id).unwrap();
    // rust: if state.properties.len() != first.properties.len() {
    // rust: return Err("inconsistent block properties".into());
}
    // rust: let value = state
    // rust: .properties
    // rust: .get(property)
    // rust: .ok_or("missing block property")?;
    // rust: if value != initial && stride.is_none() {
    // rust: stride = Some(index);
}
    // rust: if !lookup.contains_key(value) {
    // rust: lookup.insert(value.clone(), values.len());
    // rust: values.push(value.clone());
}
}
    // rust: let stride = stride.unwrap_or(1);
    // rust: for (index, id) in states.iter().enumerate() {
    // rust: if registry.state(*id).unwrap().properties[property]
    // rust: != values[(index / stride) % values.len()]
    // rust: {
    // rust: return Err("non-Cartesian property state order".into());
}
}
    // rust: let integer = integers.contains(&(name.clone(), property.clone()));
                // In the pinned registry these signatures uniquely identify
                // Java Property.equals families; the native harness checks this.
    // rust: let signature = (
    // rust: property.clone(),
    // rust: integer,
    // rust: lookup.keys().cloned().collect::<Vec<_>>(),
    // rust: );
    // rust: let next = identities.len();
    // rust: let identity = *identities.entry(signature).or_insert(next);
    // rust: let numeric = if integer {
    // rust: Some(
    // rust: values
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, s)| {
    // rust: s.parse::<i32>()
    // rust: .map(|v| (v, i))
    // rust: .map_err(|_| "invalid integer property".to_owned())
    // rust: })
    // rust: .collect::<Result<_, _>>()?,
    // rust: )
    // rust: } else {
    // rust: None
}
    // rust: properties.push(Property {
    // rust: identity,
    // rust: name: property.clone(),
    // rust: values,
    // rust: lookup,
    // rust: numeric,
    // rust: stride,
    // rust: });
}
    // rust: let mut dimensions = properties
    // rust: .iter()
    // rust: .filter(|p| p.values.len() > 1)
    // rust: .collect::<Vec<_>>();
    // rust: dimensions.sort_by_key(|p| p.stride);
    // rust: let mut size = 1usize;
    // rust: for p in dimensions {
    // rust: if p.stride != size {
    // rust: return Err("overlapping property state dimensions".into());
}
    // rust: size = size
    // rust: .checked_mul(p.values.len())
    // rust: .ok_or("property state size overflow")?;
}
    // rust: if size != states.len() {
    // rust: return Err("incomplete Cartesian state table".into());
}
    // rust: for (local, id) in states.iter().enumerate() {
    // rust: result.addresses[id.0 as usize] = Address {
    // rust: block: result.blocks.len(),
    // rust: local,
}
}
    // rust: result.blocks.push(Block { states, properties });
}
    // rust: Ok(result)
}
copy :: proc(self: ^Self, target: BlockStateId, source: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut target = *self.addresses.get(target.0 as usize)?;
    // rust: let source = *self.addresses.get(source.0 as usize)?;
    // rust: let block = &self.blocks[target.block];
    // rust: for source_property in &self.blocks[source.block].properties {
    // rust: if let Some(property) = block
    // rust: .properties
    // rust: .iter()
    // rust: .find(|p| p.identity == source_property.identity)
    // rust: {
    // rust: let value = &source_property.values
    // rust: [(source.local / source_property.stride) % source_property.values.len()];
    // rust: let index = *property.lookup.get(value)?;
    // rust: let previous = (target.local / property.stride) % property.values.len();
    // rust: target.local = target.local - previous * property.stride + index * property.stride;
}
}
    // rust: block.states.get(target.local).copied()
}
has_integer :: proc(self: ^Self, state: BlockStateId, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let address = self.addresses.get(state.0 as usize)?;
    // rust: Some(
    // rust: self.blocks[address.block]
    // rust: .properties
    // rust: .iter()
    // rust: .any(|p| p.name == name && p.numeric.is_some()),
    // rust: )
}
set_integer :: proc(self: ^Self, state: BlockStateId, name: string, value: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let address = self.addresses.get(state.0 as usize)?;
    // rust: let block = &self.blocks[address.block];
    // rust: let property = block.properties.iter().find(|p| p.name == name)?;
    // rust: let index = property.numeric.as_ref()?.get(&value)?;
    // rust: let previous = (address.local / property.stride) % property.values.len();
    // rust: block
    // rust: .states
    // rust: .get(address.local - previous * property.stride + index * property.stride)
    // rust: .copied()
}

property :: proc(self: ^Self, state: BlockStateId, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let address = *self.addresses.get(state.0 as usize)?;
    // rust: let property = self.blocks[address.block]
    // rust: .properties
    // rust: .iter()
    // rust: .find(|p| p.name == name)?;
    // rust: Some((address, property))
}
    // The state's value for a named property, or None when it has no such property.
value :: proc(self: ^Self, state: BlockStateId, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (address, property) = self.property(state, name)?;
    // rust: Some(&property.values[(address.local / property.stride) % property.values.len()])
}
    // All values of the state's named property in registry encounter order.
values :: proc(self: ^Self, state: BlockStateId, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.property(state, name).map(|(_, p)| p.values.as_slice())
}
    // Replace one property value, or None for a missing property or value.
with_value :: proc(self: ^Self, state: BlockStateId, name: string, value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (address, property) = self.property(state, name)?;
    // rust: let index = *property.lookup.get(value)?;
    // rust: let previous = (address.local / property.stride) % property.values.len();
    // rust: self.blocks[address.block]
    // rust: .states
    // rust: .get(address.local - previous * property.stride + index * property.stride)
    // rust: .copied()
}
}
