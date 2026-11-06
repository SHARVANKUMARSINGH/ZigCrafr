//! Transpiled from Horizon Rust crate
package horizon_world_effect_particles

import "core:fmt"
import "core:mem"
import "core:math"

// Pinned registered MobEffect particle factories and native option identity.
// use crate::{DATA_VERSION, compression::invalid, synced_values::SyncedValue};
// use serde_json::Value;
// use std::{collections::BTreeMap, io, sync::Arc};

AMBIENT_ALPHA :: 38

ParticleData :: struct {
    kind: string,
    color: Maybe(u32),
}
// ColorParticleOption and SimpleParticleType use object equality. Cloning an
// option retains that object; constructing a color option creates a new one.
Particle :: struct {
    // rust: impl Particle {
data :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0
}
same_reference :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Arc::ptr_eq(&self.0, &other.0)
}
}
    // rust: impl PartialEq for Particle {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.same_reference(other)
}
}
    // rust: impl Eq for Particle {}

Factory :: enum {
    Color(u32),
    Constant(Particle),
}
Catalog :: struct {
    effects: BTreeMap<string,
}
    // rust: impl Catalog {
    // The native exporter verifies inherited factories, captured arguments,
    // option classes and identity. No recovered game assets are embedded here.
from_json :: proc(value: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if value["data_version"].as_i64() != Some(i64::from(DATA_VERSION))
    // rust: || value["ambient_alpha"].as_u64() != Some(u64::from(AMBIENT_ALPHA))
    // rust: {
    // rust: return Err(invalid("effect particle catalog version mismatch"));
}
    // rust: let mut effects = BTreeMap::new();
    // rust: let mut simple = BTreeMap::<String, Particle>::new();
    // rust: for item in value["effects"]
    // rust: .as_array()
    // rust: .ok_or_else(|| invalid("missing effects"))?
    // rust: {
    // rust: let id = identifier(&item["id"])?;
    // rust: let factory = match item["factory"].as_str() {
    // rust: Some("color") => Factory::Color(color(&item["color"])?),
    // rust: Some("constant") => {
    // rust: let p = &item["particle"];
    // rust: let kind = identifier(&p["type"])?;
    // rust: if !p["color"].is_null() {
    // rust: return Err(invalid("expected registered simple constant particle"));
}
    // rust: let particle = simple
    // rust: .entry(kind.clone())
    // rust: .or_insert_with(|| Particle(Arc::new(ParticleData { kind, color: None })))
    // rust: .clone();
    // rust: Factory::Constant(particle)
}
    // rust: _ => return Err(invalid("unknown registered particle factory")),
}
    // rust: if effects.insert(id, factory).is_some() {
    // rust: return Err(invalid("duplicate effect particle definition"));
}
}
    // rust: Ok(Self { effects })
}
contains :: proc(self: ^Self, effect: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.effects.contains_key(effect)
}
    // Actual registered factories are pure: only the ambient flag changes a
    // colored option. Constant options retain their registry object identity.
create :: proc(self: ^Self, effect: string, ambient: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match self.effects.get(effect)? {
    // rust: Factory::Color(color) => Particle(Arc::new(ParticleData {
    // rust: kind: "minecraft:entity_effect".into(),
    // rust: color: Some(
    // rust: (u32::from(if ambient { AMBIENT_ALPHA } else { 255 }) << 24)
    // rust: | (color & 0xffffff),
    // rust: ),
    // rust: })),
    // rust: Factory::Constant(particle) => particle.clone(),
    // rust: })
}
}
identifier :: proc(value: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let name = value
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid("expected particle identifier"))?;
    // rust: let canonical =
    // rust: crate::identifier::Identifier::parse(name).map_err(|e| invalid(format!("{e:?}")))?;
    // rust: if canonical.to_string() != name {
    // rust: return Err(invalid("noncanonical particle identifier"));
}
    // rust: Ok(name.into())
}
color :: proc(value: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: value
    // rust: .as_u64()
    // rust: .and_then(|v| u32::try_from(v).ok())
    // rust: .ok_or_else(|| invalid("invalid particle color"))
}

// The three synchronized value kinds used for living effect presentation.
// Lists compare element object identity, including repeated fresh colors.
EffectValue :: enum {
    Flags(u8),
    Ambient(bool),
    Particles(Arc<[Particle]>),
}
    // rust: impl SyncedValue for EffectValue {
native_equal :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == other
}
}
