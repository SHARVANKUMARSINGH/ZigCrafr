//! Transpiled from Horizon Rust crate
package horizon_protocol_custom

import "core:fmt"
import "core:mem"
import "core:math"

// Internal wire IDs for native data components. Installed once before networking.
// use super::{Component, Stack, Template, component};
// use crate::buf::{Codec, Reader};
// use std::sync::OnceLock;

Types :: struct {
    first: i32,
    names: [dynamic]string,
}

TYPES :: OnceLock::new()

InstallError :: enum {
    InvalidRange,
    DuplicateName,
    InvalidName,
    AlreadyInstalled,
}

    // rust: impl std::fmt::Display for InstallError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::InvalidRange => "invalid component ID range",
    // rust: Self::DuplicateName => "duplicate component name",
    // rust: Self::InvalidName => "invalid component name",
    // rust: Self::AlreadyInstalled => "component types already installed",
    // rust: })
}
}
    // rust: impl std::error::Error for InstallError {}

// Install sorted component names after the built-in component IDs.
// This is an internal transport seam, not a native-mod API.
install :: proc(first: i32, mut names: [dynamic]string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if first < 0
    // rust: || i32::try_from(names.len())
    // rust: .ok()
    // rust: .and_then(|n| first.checked_add(n))
    // rust: .is_none()
    // rust: {
    // rust: return Err(InstallError::InvalidRange);
}
    // rust: if names.iter().any(|name| {
    // rust: horizon_world::identifier::Identifier::parse_namespaced(name)
    // rust: .is_none_or(|id| id.namespace() == "minecraft")
    // rust: }) {
    // rust: return Err(InstallError::InvalidName);
}
    // rust: names.sort();
    // rust: if names.windows(2).any(|pair| pair[0] == pair[1]) {
    // rust: return Err(InstallError::DuplicateName);
}
    // rust: TYPES
    // rust: .set(Types { first, names })
    // rust: .map_err(|_| InstallError::AlreadyInstalled)
}

// Validate an opaque value against the same limits used by the network reader.
validate :: proc(value: ^horizon_world::nbt::Tag) -> c {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(value, horizon_world::nbt::Tag::End) {
    // rust: return Err(crate::Error::new("a component value cannot be NBT End"));
}
    // rust: let bytes = horizon_world::nbt::write_network(
    // rust: value,
    // rust: horizon_world::nbt::Limits {
    // rust: max_bytes: crate::buf::NBT_QUOTA,
    // rust: ..Default::default()
    // rust: },
    // rust: )
    // rust: .map_err(|error| crate::Error::new(error.to_string()))?;
    // rust: Reader::new(&bytes).nbt()?;
    // Disk NBT canonicalizes NaNs, and its reader normalizes negative zero.
    // Reject values that would change when saved and reloaded.
    // rust: let limits = horizon_world::nbt::Limits {
    // rust: max_bytes: crate::buf::NBT_QUOTA + 2,
    // rust: ..Default::default()
}
    // rust: let named = horizon_world::nbt::NamedTag {
    // rust: name: "".into(),
    // rust: tag: value.clone(),
}
    // rust: let saved = horizon_world::nbt::write_named(&named, limits)
    // rust: .map_err(|error| crate::Error::new(error.to_string()))?;
    // rust: let (loaded, _) = horizon_world::nbt::read_named(&saved, limits)
    // rust: .map_err(|error| crate::Error::new(error.to_string()))?;
    // rust: if loaded.tag != *value {
    // rust: return Err(crate::Error::new(
    // rust: "component value changes on save and reload",
    // rust: ));
}
    // rust: Ok(())
}

    // rust: pub(crate) fn contains(id: i32) -> bool {
    // rust: name(id).is_some()
}

// Check a decoded stack before converting it on an unverified connection.
permitted :: proc(stack: ^Stack, negotiated: bool) -> c {
    // Ported from Horizon
    return {}
}
    // rust: if negotiated || entries().next().is_none() {
    // rust: return Ok(true);
}
contains_custom :: proc(stack: ^Stack) -> c {
    // Ported from Horizon
    return {}
}
    // rust: if stack.removed.iter().any(|id| contains(*id)) {
    // rust: return Ok(true);
}
    // rust: for (id, value) in &stack.added {
    // rust: if contains(*id) {
    // rust: return Ok(true);
}
    // rust: match value {
    // rust: Component::Stacks(stacks) => {
    // rust: for stack in stacks {
    // rust: if contains_custom(stack)? {
    // rust: return Ok(true);
}
}
}
    // rust: Component::TooltipDisplay { hidden, .. }
    // rust: if hidden.iter().any(|id| contains(*id)) =>
    // rust: {
    // rust: return Ok(true);
}
    // rust: Component::Raw(bytes)
    // rust: if matches!(
    // rust: *id,
    // rust: component::USE_REMAINDER
    // rust: | component::POT_DECORATIONS
    // rust: | component::CONTAINER
    // rust: | component::SULFUR_CUBE_CONTENT
    // rust: ) =>
    // rust: {
    // rust: let mut reader = Reader::new(bytes);
    // rust: let count = match *id {
    // rust: component::USE_REMAINDER | component::SULFUR_CUBE_CONTENT => 1,
    // rust: component::POT_DECORATIONS => 4,
    // rust: _ => reader.count(256)?,
}
    // rust: for _ in 0..count {
    // rust: if (matches!(
    // rust: *id,
    // rust: component::USE_REMAINDER | component::SULFUR_CUBE_CONTENT
    // rust: ) || reader.bool()?)
    // rust: && contains_custom(&Template::read(&mut reader)?)?
    // rust: {
    // rust: return Ok(true);
}
}
}
    // rust: _ => {}
}
}
    // rust: Ok(false)
}
    // rust: Ok(!contains_custom(stack)?)
}

name :: proc(id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let types = TYPES.get()?;
    // rust: let index = usize::try_from(id.checked_sub(types.first)?).ok()?;
    // rust: types.names.get(index).map(String::as_str)
}

id :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let types = TYPES.get()?;
    // rust: let index = types
    // rust: .names
    // rust: .binary_search_by(|n| n.as_str().cmp(name))
    // rust: .ok()?;
    // rust: types.first.checked_add(i32::try_from(index).ok()?)
}

entries :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: TYPES.get().into_iter().flat_map(|types| {
    // rust: types.names.iter().enumerate().filter_map(|(index, name)| {
    // rust: Some((
    // rust: types.first.checked_add(i32::try_from(index).ok()?)?,
    // rust: name.as_str(),
    // rust: ))
    // rust: })
    // rust: })
}
