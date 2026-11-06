//! Transpiled from Horizon Rust crate
package horizon_client_native_components

import "core:fmt"
import "core:mem"
import "core:math"

// Native item data component helpers.
// use super::Game;
// use horizon_client::items::ItemStack;
// use horizon_world::nbt::Tag;

// Failure to access a native item component.
NativeComponentError :: enum {
    UnknownType,
    InvalidValue(horizon_protocol::Error),
}
    // rust: impl std::fmt::Display for NativeComponentError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::UnknownType => f.write_str("unregistered component type"),
    // rust: Self::InvalidValue(error) => write!(f, "invalid component value: {error}"),
}
}
}
    // rust: impl std::error::Error for NativeComponentError {}

// Native mods use these helpers.
    // rust: impl Game<'_> {
    // Read a native component, including the item's default when not patched.
    // rust: pub(super) fn native_component<'a>(
    // rust: &'a self,
    // rust: stack: &'a ItemStack,
    // rust: id: &str,
    // rust: ) -> Result<Option<&'a Tag>, NativeComponentError> {
    // rust: if horizon_protocol::item::custom::id(id).is_none() {
    // rust: return Err(NativeComponentError::UnknownType);
}
    // rust: if let Some(data) = stack.data() {
    // rust: if data.other(&format!("!{id}")).is_some() {
    // rust: return Ok(None);
}
    // rust: if let Some(value) = data.other(id) {
    // rust: return Ok(Some(value));
}
}
    // rust: Ok(self
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|item| item.custom_components.get(id)))
}

    // Set a registered native component after checking the network NBT limits.
    // rust: pub(super) fn native_set_component(
    // rust: &self,
    // rust: stack: &mut ItemStack,
    // rust: id: &str,
    // rust: value: Tag,
    // rust: ) -> Result<(), NativeComponentError> {
    // rust: if horizon_protocol::item::custom::id(id).is_none() {
    // rust: return Err(NativeComponentError::UnknownType);
}
    // rust: horizon_protocol::item::custom::validate(&value)
    // rust: .map_err(NativeComponentError::InvalidValue)?;
    // rust: let default = self
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|item| item.custom_components.get(id));
    // rust: let value = (default != Some(&value)).then_some(value);
    // rust: let removed = format!("!{id}");
    // rust: let data = stack.data_mut();
    // rust: data.set_other(&removed, None);
    // rust: data.set_other(id, value);
    // rust: stack.tidy();
    // rust: Ok(())
}

    // Remove a native component, including its item default.
    // rust: pub(super) fn native_remove_component(
    // rust: &self,
    // rust: stack: &mut ItemStack,
    // rust: id: &str,
    // rust: ) -> Result<(), NativeComponentError> {
    // rust: if horizon_protocol::item::custom::id(id).is_none() {
    // rust: return Err(NativeComponentError::UnknownType);
}
    // rust: let default = self
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|item| item.custom_components.contains_key(id));
    // rust: let removed = format!("!{id}");
    // rust: let data = stack.data_mut();
    // rust: data.set_other(id, None);
    // rust: data.set_other(&removed, default.then(|| Tag::Compound(Default::default())));
    // rust: stack.tidy();
    // rust: Ok(())
}
}
