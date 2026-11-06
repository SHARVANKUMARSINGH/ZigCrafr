//! Transpiled from Horizon Rust crate
//! Module: horizon-client_face_buttons
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Linux's codes for X and Y don't say where those buttons sit.
// use gilrs::{Button, Gamepad, MappingSource};
// use horizon_client::gamepad::GlyphStyle;

/// Whether this pad's X and Y reach us crossed. The kernel defines `BTN_X` as `BTN_NORTH` and
/// `BTN_Y` as `BTN_WEST`, so an Xbox-style pad's X, on the west, sends "north". gilrs' default
/// mapping takes the names at their word; an SDL row names `x` and `y` itself and is right.
    // rust: pub(super) fn crossed(pad: &Gamepad) -> bool {
    // rust: cfg!(target_os = "linux")
    // rust: && crossed_layout(
    // rust: pad.mapping_source(),
    // rust: [
    // rust: Button::South,
    // rust: Button::East,
    // rust: Button::West,
    // rust: Button::North,
    // rust: Button::C,
    // rust: Button::Z,
    // rust: ]
    // rust: .map(|button| pad.button_code(button).is_some()),
    // rust: GlyphStyle::of_device(pad.vendor_id(), pad.product_id()),
    // rust: )
}

pub fn crossed_layout(source: MappingSource, face_buttons: [bool; 6], style: GlyphStyle) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: source == MappingSource::Driver
        // The Xbox-style layout has no C or Z.
    // rust: && face_buttons == [true, true, true, true, false, false]
        // These drivers send the same codes for what is really on the north and the west.
    // rust: && !matches!(style, GlyphStyle::PlayStation | GlyphStyle::Nintendo)
}

/// What gilrs calls the button we know as `button`, on a pad that is `crossed` or not.
    // rust: pub(super) fn named(button: Button, crossed: bool) -> Button {
    // rust: match button {
    // rust: Button::West if crossed => Button::North,
    // rust: Button::North if crossed => Button::West,
    // rust: other => other,
}
}

    // rust: mod tests {
//     use super::*;

pub const XBOX_BUTTONS: [bool; 6] = [true, true, true, true, false, false];

pub fn an_unmapped_xbox_style_pad_is_crossed() void {
}
        // The GameSir Nova Lite 2 of #7323: `3537:1098`, no SDL row, X sends BTN_NORTH.
    // rust: let style = GlyphStyle::of_device(Some(0x3537), Some(0x1098));
    // rust: assert!(crossed_layout(MappingSource::Driver, XBOX_BUTTONS, style));
}

pub fn an_sdl_row_already_names_x_and_y() void {
}
    // rust: assert!(!crossed_layout(
    // rust: MappingSource::SdlMappings,
    // rust: XBOX_BUTTONS,
    // rust: GlyphStyle::Xbox
    // rust: ));
}

pub fn a_sony_or_nintendo_pad_means_what_its_codes_say() void {
}
    // rust: for vendor in [0x054c, 0x057e] {
    // rust: let style = GlyphStyle::of_device(Some(vendor), None);
    // rust: assert!(!crossed_layout(MappingSource::Driver, XBOX_BUTTONS, style));
}
}

pub fn a_pad_with_c_or_z_is_not_xbox_style() void {
}
    // rust: for different in [
    // rust: [true, true, true, true, true, false],
    // rust: [true, true, true, true, false, true],
    // rust: ] {
    // rust: assert!(!crossed_layout(
    // rust: MappingSource::Driver,
    // rust: different,
    // rust: GlyphStyle::Xbox
    // rust: ));
}
}

pub fn only_x_and_y_change_places() void {
}
    // rust: assert_eq!(named(Button::West, true), Button::North);
    // rust: assert_eq!(named(Button::North, true), Button::West);
    // rust: assert_eq!(named(Button::South, true), Button::South);
    // rust: assert_eq!(named(Button::East, true), Button::East);
    // rust: assert_eq!(named(Button::West, false), Button::West);
    // rust: assert_eq!(named(Button::North, false), Button::North);
}
}
