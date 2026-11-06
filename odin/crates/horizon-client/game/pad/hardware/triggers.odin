//! Transpiled from Horizon Rust crate
package horizon_client_triggers

import "core:fmt"
import "core:mem"
import "core:math"

// Read triggers from mapped buttons, or the conventional unmapped Linux axes.
// use gilrs::{Axis, Button, Gamepad, MappingSource};
// use horizon_client::gamepad::BITDO_ULTIMATE2_VID_PID;

    // rust: pub(super) fn triggers(pad: &Gamepad) -> [f32; 2] {
    // rust: let axes = cfg!(target_os = "linux")
    // rust: && axis_triggers(
    // rust: pad.mapping_source(),
    // rust: [
    // rust: Axis::LeftStickX,
    // rust: Axis::LeftStickY,
    // rust: Axis::RightStickX,
    // rust: Axis::RightStickY,
    // rust: Axis::LeftZ,
    // rust: Axis::RightZ,
    // rust: ]
    // rust: .iter()
    // rust: .all(|&axis| pad.axis_code(axis).is_some()),
    // rust: [
    // rust: Button::South,
    // rust: Button::East,
    // rust: Button::West,
    // rust: Button::North,
    // rust: Button::C,
    // rust: Button::Z,
    // rust: ]
    // rust: .map(|button| pad.button_code(button).is_some()),
    // rust: (pad.vendor_id(), pad.product_id()),
    // rust: );
    // rust: [
    // rust: (Button::LeftTrigger2, Axis::LeftZ),
    // rust: (Button::RightTrigger2, Axis::RightZ),
    // rust: ]
    // rust: .map(|(button, axis)| {
    // rust: trigger_value(
    // rust: pad.button_code(button).is_some(),
    // rust: pad.button_data(button).map(|data| data.value()),
    // rust: pad.is_pressed(button),
    // rust: axes.then(|| pad.axis_data(axis).map(|data| data.value()))
    // rust: .flatten(),
    // rust: )
    // rust: })
}

    // rust: fn axis_triggers(
    // rust: source: MappingSource,
    // rust: six_axes: bool,
    // rust: face_buttons: [bool; 6],
    // rust: device: (Option<u16>, Option<u16>),
    // rust: ) -> bool {
    // rust: source == MappingSource::Driver
    // rust: && six_axes
        // The default Xbox-style button layout skips C and Z. A generic six-axis
        // pad can otherwise put its right stick on LeftZ/RightZ: its centred
        // value would be mistaken for a half-pulled trigger.
    // rust: && face_buttons == [true, true, true, true, false, false]
        // This model's default LeftZ is the right stick, not a trigger.
    // rust: && device != (Some(BITDO_ULTIMATE2_VID_PID.0), Some(BITDO_ULTIMATE2_VID_PID.1))
}

trigger_value :: proc(mapped: bool, value: Maybe(f32), pressed: bool, axis: Maybe(f32)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if mapped {
    // rust: if pressed {
    // rust: value.unwrap_or(0.0).max(1.0)
    // rust: } else {
    // rust: value.unwrap_or(0.0)
}
    // rust: } else {
    // rust: axis.map_or(0.0, |value| ((value + 1.0) * 0.5).clamp(0.0, 1.0))
}
}

    // rust: mod tests {
//     use super::{BITDO_ULTIMATE2_VID_PID, axis_triggers, trigger_value};
//     use gilrs::MappingSource;
//     use horizon_client::gamepad::{Button, Edges, PadState};

XBOX_BUTTONS :: [true, true, true, true, false, false]

only_unmapped_xbox_style_six_axis_layouts_use_axis_triggers :: proc() {
}
    // rust: assert!(axis_triggers(
    // rust: MappingSource::Driver,
    // rust: true,
    // rust: XBOX_BUTTONS,
    // rust: (None, None)
    // rust: ));
    // rust: assert!(!axis_triggers(
    // rust: MappingSource::SdlMappings,
    // rust: true,
    // rust: XBOX_BUTTONS,
    // rust: (None, None)
    // rust: ));
    // rust: assert!(!axis_triggers(
    // rust: MappingSource::Driver,
    // rust: false,
    // rust: XBOX_BUTTONS,
    // rust: (None, None)
    // rust: ));
    // rust: assert!(!axis_triggers(
    // rust: MappingSource::Driver,
    // rust: true,
    // rust: XBOX_BUTTONS,
    // rust: (
    // rust: Some(BITDO_ULTIMATE2_VID_PID.0),
    // rust: Some(BITDO_ULTIMATE2_VID_PID.1)
    // rust: )
    // rust: ));
    // rust: for button in 0..6 {
    // rust: let mut different = XBOX_BUTTONS;
    // rust: different[button] = !different[button];
    // rust: assert!(!axis_triggers(
    // rust: MappingSource::Driver,
    // rust: true,
    // rust: different,
    // rust: (None, None)
    // rust: ));
}
}

a_centred_stick_on_a_generic_layout_never_holds_attack_or_use :: proc() {
}
    // rust: let fallback = axis_triggers(MappingSource::Driver, true, [true; 6], (None, None));
    // rust: let mut edges = Edges::default();
    // rust: for axis in [None, Some(1.0), Some(0.0), Some(-1.0), Some(0.0)] {
    // rust: let value = trigger_value(false, None, false, axis.filter(|_| fallback));
    // rust: assert_eq!(value, 0.0);
    // rust: let state = PadState {
    // rust: triggers: [value; 2],
    // rust: ..PadState::default()
}
    // rust: assert!(edges.update(&state, 0.4).is_empty());
    // rust: assert!(!edges.is_held(Button::LeftTrigger));
    // rust: assert!(!edges.is_held(Button::RightTrigger));
}
}

eight_bit_trigger_rest_pull_and_release_generate_button_edges :: proc() {
}
    // rust: for (index, button) in [(0, Button::LeftTrigger), (1, Button::RightTrigger)] {
    // rust: let mut edges = Edges::default();
    // rust: let mut seen = Vec::new();
    // rust: for axis in [-0.9921875, 0.0, 1.0, -0.9921875] {
    // rust: let value = trigger_value(false, None, false, Some(axis));
    // rust: let mut state = PadState::default();
    // rust: state.triggers[index] = value;
    // rust: seen.extend(edges.update(&state, 0.4));
}
    // rust: assert_eq!(seen, vec![(button, true), (button, false)]);
    // rust: assert!(!edges.is_held(button));
}
}

absent_axis_is_released :: proc() {
}
    // rust: assert_eq!(trigger_value(false, None, false, None), 0.0);
}

mapped_buttons_take_precedence_even_before_first_event :: proc() {
}
    // rust: assert_eq!(trigger_value(true, None, false, Some(1.0)), 0.0);
    // rust: assert_eq!(trigger_value(true, Some(0.25), false, Some(1.0)), 0.25);
    // rust: assert_eq!(trigger_value(true, None, true, None), 1.0);
}
}
