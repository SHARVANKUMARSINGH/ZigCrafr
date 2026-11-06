//! Transpiled from Horizon Rust crate
package horizon_client_debug_stick

import "core:fmt"
import "core:mem"
import "core:math"

// `DebugStickItem`: selecting a block-state property with the left button and
// cycling its value with the right button, as vanilla does.
//
// The selected property is the `minecraft:debug_stick_state` component, a
// compound of block id to property name. Horizon keeps unmodelled components
// in `StackData::other`, so the component travels through NBT unchanged.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{Result, items::ItemStack, text::Text};
// use horizon_core::position::BlockPos;
// use horizon_world::level::flags;

DEBUG_STICK :: "minecraft:debug_stick"

is_debug_stick :: proc(stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: &*stack.item == DEBUG_STICK
}

// `Util.findNextInIterable` / `findPreviousInIterable` on an index.
//
// A missing current value starts at the first value forward and the last
// value backward; both wrap around.
relative_index :: proc(len: uint, current: Maybe(uint), backward: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match (current, backward) {
    // rust: (Some(0), true) => len - 1,
    // rust: (Some(i), true) => i - 1,
    // rust: (Some(i), false) => (i + 1) % len,
    // rust: (None, true) => len - 1,
    // rust: (None, false) => 0,
}
}

text :: proc(key: string, args: ^[string]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let args: Vec<Text> = args.iter().map(|arg| Text::literal(*arg)).collect();
    // rust: Text::translate(key, &args)
}

    // rust: impl Game<'_> {
    // `DebugStickItem.useOn`: a right click cycles the value of the property
    // in `debug_stick_state` (the first property when none is selected yet).
    // `Some` is the vanilla result (`SUCCESS`/`FAIL`), `None` another item.
    // rust: pub(super) fn debug_stick_use_on(&mut self, pos: [i32; 3]) -> Result<Option<bool>> {
    // rust: if !self.held().is_some_and(is_debug_stick) {
    // rust: return Ok(None);
}
    // rust: Ok(Some(self.debug_stick_interact(pos, true)?))
}

    // `DebugStickItem.canDestroyBlock`: a left click selects the next
    // property and never destroys the block.
    // rust: pub(super) fn debug_stick_can_destroy(&mut self, pos: [i32; 3]) -> Result<bool> {
    // rust: if !self.held().is_some_and(is_debug_stick) {
    // rust: return Ok(true);
}
    // rust: let _ = self.debug_stick_interact(pos, false)?;
    // rust: Ok(false)
}

    // `DebugStickItem.handleInteraction`: whether the interaction succeeded.
debug_stick_interact :: proc(self: ^Self, pos: [i32; 3], cycle: bool) -> R {
    // Ported from Horizon
    return {}
}
        // `Player.canUseGameMasterBlocks`: creative with game-master commands.
    // rust: if !self.can_use_game_master_blocks() {
    // rust: return Ok(false);
}
    // rust: let state_id = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let Some(state) = self.pack.assets.registry.state(state_id).cloned() else {
    // rust: return Ok(false);
}
    // rust: if state.properties.is_empty() {
    // rust: self.send_overlay_message(text(
    // rust: "item.minecraft.debug_stick.empty",
    // rust: &[state.name.as_str()],
    // rust: ));
    // rust: return Ok(false);
}

    // rust: let selected = self
    // rust: .held()
    // rust: .and_then(ItemStack::data)
    // rust: .and_then(|data| data.debug_stick_property(&state.name));
        // `Player.isSecondaryUseActive` / `isShiftKeyDown`: the acting
        // player's sneak input. `keys` holds the host's, toggled sneak
        // included; `enter_guest` fills it from the guest's sneak state.
    // rust: let backward = self.keys.held(Action::Sneak);

    // rust: if cycle {
            // `cycleState`: a property selected on another block falls back to
            // the first one. The property list is sorted by name, as vanilla's
            // `ImmutableSortedMap`.
    // rust: let (property, value) = {
    // rust: let registry = &self.pack.assets.registry;
    // rust: let property = selected
    // rust: .as_deref()
    // rust: .filter(|property| state.properties.contains_key(*property))
    // rust: .map(str::to_owned)
    // rust: .unwrap_or_else(|| state.properties.keys().next().unwrap().clone());
    // rust: let values = registry.property_values(&state.name, &property);
    // rust: if values.is_empty() {
    // rust: return Ok(false);
}
    // rust: let current = state.properties.get(&property).map(String::as_str);
    // rust: let current = current.and_then(|value| values.iter().position(|v| *v == value));
    // rust: let value = values[relative_index(values.len(), current, backward)].to_owned();
    // rust: (property, value)
}
    // rust: let mut next = state;
    // rust: next.properties.insert(property.clone(), value.clone());
    // rust: let Ok(next_id) = self.pack.assets.registry.resolve(&next) else {
    // rust: return Ok(false);
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
            // `Level.setBlock(pos, newState, 18)`: clients and the known shape,
            // without neighbour updates.
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(
    // rust: level,
    // rust: ticks,
    // rust: at,
    // rust: next_id,
    // rust: flags::UPDATE_CLIENTS | flags::UPDATE_KNOWN_SHAPE,
    // rust: );
    // rust: });
    // rust: self.process_level_events()?;
    // rust: self.send_overlay_message(text(
    // rust: "item.minecraft.debug_stick.update",
    // rust: &[property.as_str(), value.as_str()],
    // rust: ));
    // rust: } else {
            // `getRelative(properties, property, backward)`; the property list
            // is sorted, so its key order is vanilla's.
    // rust: let keys: Vec<&String> = state.properties.keys().collect();
    // rust: let current = selected
    // rust: .as_deref()
    // rust: .and_then(|selected| keys.iter().position(|key| key.as_str() == selected));
    // rust: let property = keys[relative_index(keys.len(), current, backward)].clone();
    // rust: let value = state.properties.get(&property).cloned().unwrap_or_default();
    // rust: self.set_debug_stick_property(&state.name, &property);
    // rust: self.send_overlay_message(text(
    // rust: "item.minecraft.debug_stick.select",
    // rust: &[property.as_str(), value.as_str()],
    // rust: ));
}
    // rust: Ok(true)
}

    // `DebugStickState.withProperty(block, property)` on the acting hand.
set_debug_stick_property :: proc(self: ^Self, block: string, property: string) {
}
    // rust: let Some(stack) = self.held_mut().as_mut() else {
    // rust: return;
}
    // rust: stack.data_mut().set_debug_stick_property(block, property);
    // rust: stack.tidy();
}
}

    // rust: mod tests {
//     use super::relative_index;

relative_index_wraps_like_util :: proc() {
}
    // rust: assert_eq!(relative_index(4, None, false), 0);
    // rust: assert_eq!(relative_index(4, None, true), 3);
    // rust: assert_eq!(relative_index(4, Some(0), false), 1);
    // rust: assert_eq!(relative_index(4, Some(0), true), 3);
    // rust: assert_eq!(relative_index(4, Some(2), false), 3);
    // rust: assert_eq!(relative_index(4, Some(2), true), 1);
    // rust: assert_eq!(relative_index(4, Some(3), false), 0);
    // rust: assert_eq!(relative_index(4, Some(3), true), 2);
}
}
