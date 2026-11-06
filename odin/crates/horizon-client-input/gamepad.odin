//! Transpiled from Horizon Rust crate
package horizon_client_input_gamepad

import "core:fmt"
import "core:mem"
import "core:math"

// Controllers: Horizon's own feature (vanilla 26.3 has no gamepad input).
// Its default buttons are Horizon's own; analog walking and toggle sneak follow Bedrock Edition on
// consoles. See docs/controllers.md.
//
// This module is the backend-free part: positional buttons, the action
// bindings, deadzones and the look curve, button edges from successive pad
// states, and `horizon-controller.txt`, kept next to `options.txt` so that
// file stays exactly vanilla's. The game reads the pads with gilrs.
// use std::{
    // rust: collections::BTreeMap,
    // rust: fs,
    // rust: path::Path,
    // rust: time::{Duration, Instant},
}

FILE :: "horizon-controller.txt"

// A button by its position on the pad (gilrs' and SDL's layout): `South`
// is Xbox A, PlayStation ✕, Nintendo B.
Button :: enum {
    South,
    East,
    West,
    North,
    LeftBumper,
    RightBumper,
    LeftTrigger,
    RightTrigger,
    Select,
    Start,
    LeftStick,
    RightStick,
    DPadUp,
    DPadDown,
    DPadLeft,
    DPadRight,
}
    // rust: impl Button {
    // rust: pub const ALL: [Button; 16] = [
    // rust: Button::South,
    // rust: Button::East,
    // rust: Button::West,
    // rust: Button::North,
    // rust: Button::LeftBumper,
    // rust: Button::RightBumper,
    // rust: Button::LeftTrigger,
    // rust: Button::RightTrigger,
    // rust: Button::Select,
    // rust: Button::Start,
    // rust: Button::LeftStick,
    // rust: Button::RightStick,
    // rust: Button::DPadUp,
    // rust: Button::DPadDown,
    // rust: Button::DPadLeft,
    // rust: Button::DPadRight,
    // rust: ];
    // The name in `horizon-controller.txt` and `horizon-ctl pad`.
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Button::South => "south",
    // rust: Button::East => "east",
    // rust: Button::West => "west",
    // rust: Button::North => "north",
    // rust: Button::LeftBumper => "lb",
    // rust: Button::RightBumper => "rb",
    // rust: Button::LeftTrigger => "lt",
    // rust: Button::RightTrigger => "rt",
    // rust: Button::Select => "select",
    // rust: Button::Start => "start",
    // rust: Button::LeftStick => "ls",
    // rust: Button::RightStick => "rs",
    // rust: Button::DPadUp => "up",
    // rust: Button::DPadDown => "down",
    // rust: Button::DPadLeft => "left",
    // rust: Button::DPadRight => "right",
}
}
parse :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|b| b.name() == name)
}
bit :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 1 << self as u32
}
    // What is printed on the button for a pad family (`Auto` reads as Xbox).
label :: proc(self: ^Self, style: GlyphStyle) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let i = self as usize;
    // rust: match style {
    // rust: GlyphStyle::PlayStation => [
    // rust: "×", "○", "□", "△", "L1", "R1", "L2", "R2", "Create", "Options", "L3", "R3", "↑",
    // rust: "↓", "←", "→",
    // rust: ][i],
    // rust: GlyphStyle::Nintendo => [
    // rust: "B", "A", "Y", "X", "L", "R", "ZL", "ZR", "−", "+", "LS", "RS", "↑", "↓", "←", "→",
    // rust: ][i],
    // rust: GlyphStyle::Xbox | GlyphStyle::Auto => [
    // rust: "A", "B", "X", "Y", "LB", "RB", "LT", "RT", "View", "Menu", "LS", "RS", "↑", "↓",
    // rust: "←", "→",
    // rust: ][i],
}
}
    // The glyph's colour (RGB): face buttons in their family's colours,
    // the rest white.
color :: proc(self: ^Self, style: GlyphStyle) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let face = match self {
    // rust: Button::South => 0,
    // rust: Button::East => 1,
    // rust: Button::West => 2,
    // rust: Button::North => 3,
    // rust: _ => return [255, 255, 255],
}
    // rust: match style {
    // rust: GlyphStyle::PlayStation => [
    // rust: [124, 178, 232],
    // rust: [235, 110, 110],
    // rust: [222, 145, 205],
    // rust: [92, 205, 170],
    // rust: ][face],
    // rust: GlyphStyle::Nintendo => [255, 255, 255],
    // rust: GlyphStyle::Xbox | GlyphStyle::Auto => [
    // rust: [110, 200, 90],
    // rust: [235, 90, 80],
    // rust: [80, 150, 240],
    // rust: [240, 200, 60],
    // rust: ][face],
}
}
    // The face button that plays this one's part on a Nintendo pad going by its letters
    // (`PadSettings::nintendo_letters`): the A it prints on the right is South, which confirms
    // and jumps as A does on a Switch; B (bottom) is East, X (top) West, Y (left) North. It is
    // its own inverse, so it turns a part into the button playing it and back.
by_letter :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Button::South => Button::East,
    // rust: Button::East => Button::South,
    // rust: Button::West => Button::North,
    // rust: Button::North => Button::West,
    // rust: other => other,
}
}
}

// A pad's inputs at one moment. Sticks are `[x, y]` with right and up
// positive; triggers run 0..1.
PadState :: struct {
    // Digital buttons as a bit set (triggers are in `triggers`).
    buttons: u32,
    left: [f32,
    right: [f32,
    triggers: [f32,
}
    // rust: impl PadState {
set :: proc(self: ^Self, button: Button, down: bool) {
}
    // rust: if down {
    // rust: self.buttons |= button.bit();
    // rust: } else {
    // rust: self.buttons &= !button.bit();
}
}
held :: proc(self: ^Self, button: Button) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.buttons & button.bit() != 0
}
    // A Nintendo pad's buttons read by their letters (`Button::by_letter`).
by_letter :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut state = *self;
    // rust: for part in [Button::South, Button::East, Button::West, Button::North] {
    // rust: state.set(part, self.held(part.by_letter()));
}
    // rust: state
}
    // Two sources at once (a real pad and `horizon-ctl pad`): buttons held on
    // either, sticks and triggers added.
merge :: proc(self: ^Self, other: ^PadState) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let add = |a: [f32; 2], b: [f32; 2]| {
    // rust: [
    // rust: (a[0] + b[0]).clamp(-1.0, 1.0),
    // rust: (a[1] + b[1]).clamp(-1.0, 1.0),
    // rust: ]
}
    // rust: PadState {
    // rust: buttons: self.buttons | other.buttons,
    // rust: left: add(self.left, other.left),
    // rust: right: add(self.right, other.right),
    // rust: triggers: [
    // rust: (self.triggers[0] + other.triggers[0]).clamp(0.0, 1.0),
    // rust: (self.triggers[1] + other.triggers[1]).clamp(0.0, 1.0),
    // rust: ],
}
}
    // Anything pushed past the deadzones (the pad is in use).
active :: proc(self: ^Self, settings: ^PadSettings) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.buttons != 0
    // rust: || length(self.left) > settings.move_deadzone
    // rust: || length(self.right) > settings.look_deadzone
    // rust: || self
    // rust: .triggers
    // rust: .iter()
    // rust: .any(|t| *t >= settings.trigger_threshold)
}
}

// Button presses and releases between successive states. Triggers count as
// buttons past `threshold`, with a little hysteresis so a trigger resting
// near the threshold doesn't chatter.
Edges :: struct {
    held: u32,
    suppressed: u32,
}
    // rust: impl Edges {
update :: proc(self: ^Self, state: ^PadState, threshold: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut now = state.buttons;
    // rust: for (trigger, button) in [(0, Button::LeftTrigger), (1, Button::RightTrigger)] {
    // rust: let was = (self.held | self.suppressed) & button.bit() != 0;
    // rust: let value = state.triggers[trigger];
    // rust: let on = if was {
    // rust: value >= (threshold - 0.1).max(0.05)
    // rust: } else {
    // rust: value >= threshold
}
    // rust: if on {
    // rust: now |= button.bit();
    // rust: } else {
    // rust: now &= !button.bit();
}
}
    // rust: self.suppressed &= now;
    // rust: now &= !self.suppressed;
    // rust: let changed = now ^ self.held;
    // rust: self.held = now;
    // rust: Button::ALL
    // rust: .into_iter()
    // rust: .filter(|b| changed & b.bit() != 0)
    // rust: .map(|b| (b, now & b.bit() != 0))
    // rust: .collect()
}
    // Release everything (the pad was unplugged or turned off).
release_all :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let held = std::mem::take(&mut self.held);
    // rust: Button::ALL
    // rust: .into_iter()
    // rust: .filter(|b| held & b.bit() != 0)
    // rust: .map(|b| (b, false))
    // rust: .collect()
}
is_held :: proc(self: ^Self, button: Button) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.held & button.bit() != 0
}
    // Cancel a context without turning its still-held buttons into new presses.
cancel :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.suppressed |= self.held;
    // rust: self.release_all()
}
}

// Intentional activity may take input ownership; an unchanged hold may not.
Activity :: struct {
    buttons: u32,
    sticks: [[f32,
}
    // rust: impl Activity {
observe :: proc(self: ^Self, state: ^PadState, settings: ^PadSettings) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut buttons = state.buttons;
    // rust: for (i, button) in [(0, Button::LeftTrigger), (1, Button::RightTrigger)] {
    // rust: let threshold = if self.buttons & button.bit() != 0 {
    // rust: (settings.trigger_threshold - 0.1).max(0.05)
    // rust: } else {
    // rust: settings.trigger_threshold
}
    // rust: if state.triggers[i] >= threshold {
    // rust: buttons |= button.bit();
}
}
    // rust: let mut activity = buttons & !self.buttons != 0;
    // rust: self.buttons = buttons;
    // rust: for (i, (stick, deadzone)) in [
    // rust: (state.left, settings.move_deadzone),
    // rust: (state.right, settings.look_deadzone),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if length(stick) <= deadzone {
    // rust: self.sticks[i] = [0.0; 2];
    // rust: } else if length([stick[0] - self.sticks[i][0], stick[1] - self.sticks[i][1]]) > 0.08 {
    // rust: activity = true;
    // rust: self.sticks[i] = stick;
}
}
    // rust: activity
}
}

// Horizon's pad-only actions (no vanilla key mapping).
HOTBAR_PREVIOUS :: "pad.hotbarPrevious"
HOTBAR_NEXT :: "pad.hotbarNext"

// Bindable actions and their default buttons: vanilla key mappings (the
// game acts as their default key) and Horizon's pad-only actions. Start is
// always pause / back and isn't listed.
    // rust: pub const ACTIONS: &[(&str, Option<Button>)] = &[
    // rust: ("key.jump", Some(Button::South)),
    // rust: ("key.drop", Some(Button::DPadDown)),
    // rust: ("key.swapOffhand", Some(Button::West)),
    // rust: ("key.inventory", Some(Button::North)),
    // rust: (HOTBAR_PREVIOUS, Some(Button::LeftBumper)),
    // rust: (HOTBAR_NEXT, Some(Button::RightBumper)),
    // rust: ("key.use", Some(Button::LeftTrigger)),
    // rust: ("key.attack", Some(Button::RightTrigger)),
    // rust: ("key.sprint", Some(Button::LeftStick)),
    // rust: ("key.sneak", Some(Button::RightStick)),
    // rust: ("key.togglePerspective", Some(Button::Select)),
    // rust: ("key.pickItem", Some(Button::DPadLeft)),
    // rust: ("key.chat", Some(Button::DPadUp)),
    // rust: ("key.advancements", None),
    // rust: ("key.playerlist", None),
    // rust: ("key.command", None),
    // rust: ("key.screenshot", None),
    // rust: ("key.toggleGui", None),
    // rust: ("key.smoothCamera", None),
    // Horizon's emote wheel: no button is free by default; the stick's cursor picks.
    // rust: ("key.emote", None),
    // rust: ("key.fullscreen", None),
    // rust: ("key.socialInteractions", None),
    // rust: ("key.quickActions", None),
    // rust: ("key.saveToolbarActivator", None),
    // rust: ("key.loadToolbarActivator", None),
    // rust: ("key.hotbar.1", None),
    // rust: ("key.hotbar.2", None),
    // rust: ("key.hotbar.3", None),
    // rust: ("key.hotbar.4", None),
    // rust: ("key.hotbar.5", None),
    // rust: ("key.hotbar.6", None),
    // rust: ("key.hotbar.7", None),
    // rust: ("key.hotbar.8", None),
    // rust: ("key.hotbar.9", None),
    // rust: ];

// How a bindable action reaches the game: one of its own handlers, shared
// with the keyboard where the keyboard has one, or else the vanilla default
// key or button of its mapping, as a rebound keyboard key would.
Route :: enum {
    HotbarStep {,
    next: bool,
    // rust: },
    // Held, or flipped when the pad's toggle sneak is on.
    Sneak,
    Screenshot,
    SmoothCamera,
    Fullscreen,
    // Does nothing by itself: what reads it asks whether the button is held
    // (`Minecraft.handleKeybinds`' toolbar keys, held with a hotbar key).
    Held,
    Key(winit::keyboard::KeyCode),
    Mouse(winit::event::MouseButton),
}

// The route of a bindable action; `None` for one the pad can't reach.
route :: proc(action: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match action {
    // rust: HOTBAR_PREVIOUS => Some(Route::HotbarStep { next: false }),
    // rust: HOTBAR_NEXT => Some(Route::HotbarStep { next: true }),
    // rust: "key.sneak" => Some(Route::Sneak),
    // rust: "key.screenshot" => Some(Route::Screenshot),
    // rust: "key.smoothCamera" => Some(Route::SmoothCamera),
    // rust: "key.fullscreen" => Some(Route::Fullscreen),
    // rust: "key.saveToolbarActivator" | "key.loadToolbarActivator" => Some(Route::Held),
    // rust: _ => {
    // rust: let default = crate::keybinds::KeyBinds::default_of(action);
    // rust: crate::keybinds::mouse_button(default)
    // rust: .map(Route::Mouse)
    // rust: .or_else(|| crate::keybinds::key_code(default).map(Route::Key))
}
}
}

// An action's name in the binds list: vanilla's translation key, or
// Horizon's own English for the pad-only actions.
action_caption :: proc(action: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match action {
    // rust: HOTBAR_PREVIOUS => "Hotbar: Previous Slot",
    // rust: HOTBAR_NEXT => "Hotbar: Next Slot",
    // rust: other => other,
}
}

// How long a held drop button throws single items before it throws the rest of the stack.
DROP_STACK_HOLD :: Duration::from_secs(1)

// What a held drop button does now, past its press.
DropStep :: enum {
    // Held key.drop (a repeat reaches `KeyMapping.click` as a press).
    One,
    // Control + key.drop: a pad has no Control to hold, so holding on is how it asks.
    Stack,
}

// A held drop button's repeats: a tap throws one item, as Q does; held, it repeats at the pad's
// repeat delay and interval; and held for [`DROP_STACK_HOLD`] it throws what's left.
HeldDrop :: struct {
    since: Instant,
    next: Instant,
}
    // rust: impl HeldDrop {
new :: proc(now: Instant, delay: Duration) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: since: now,
    // rust: next: now + delay,
}
}
    // The step due at `now`, if any; at most one per call.
due :: proc(self: ^Self, now: Instant, interval: Duration) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if now < self.next {
    // rust: return None;
}
    // rust: self.next = now + interval;
    // rust: Some(if now.duration_since(self.since) >= DROP_STACK_HOLD {
    // rust: DropStep::Stack
    // rust: } else {
    // rust: DropStep::One
    // rust: })
}
}

// Which button pictures prompts use.
GlyphStyle :: enum {
    // From the pad's maker.
    Auto,
    Xbox,
    PlayStation,
    Nintendo,
}
    // rust: impl GlyphStyle {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: GlyphStyle::Auto => "auto",
    // rust: GlyphStyle::Xbox => "xbox",
    // rust: GlyphStyle::PlayStation => "playstation",
    // rust: GlyphStyle::Nintendo => "nintendo",
}
}
parse :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "xbox" => GlyphStyle::Xbox,
    // rust: "playstation" => GlyphStyle::PlayStation,
    // rust: "nintendo" => GlyphStyle::Nintendo,
    // rust: _ => GlyphStyle::Auto,
}
}
    // The style the player chose, else the connected pad's.
resolve :: proc(self: ^Self, detected: GlyphStyle) -> G {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: GlyphStyle::Auto => match detected {
    // rust: GlyphStyle::Auto => GlyphStyle::Xbox,
    // rust: d => d,
    // rust: },
    // rust: chosen => chosen,
}
}
    // rust: pub const ALL: [GlyphStyle; 4] = [
    // rust: GlyphStyle::Auto,
    // rust: GlyphStyle::Xbox,
    // rust: GlyphStyle::PlayStation,
    // rust: GlyphStyle::Nintendo,
    // rust: ];
    // The style for a pad by its USB ids: Sony's and Nintendo's own, and a few officially licensed
    // third-party pads made for their consoles. Microsoft, Valve's Steam Deck and Steam Input's
    // virtual pad, and everything else look like Xbox.
of_device :: proc(vendor: Maybe(u16), product: Maybe(u16)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match (vendor, product) {
    // rust: (Some(0x054c), _) => GlyphStyle::PlayStation,
    // rust: (Some(0x057e), _) => GlyphStyle::Nintendo,
            // HORIPAD 4 FPS and FPS Plus; Razer Raiju; Nacon Revolution Pro.
    // rust: (Some(0x0f0d), Some(0x0055 | 0x0066))
    // rust: | (Some(0x1532), Some(0x1000))
    // rust: | (Some(0x146b), Some(0x0d01)) => GlyphStyle::PlayStation,
            // HORIPAD for Nintendo Switch; PowerA Wired Plus; PDP Faceoff Wired Pro.
    // rust: (Some(0x0f0d), Some(0x00c1))
    // rust: | (Some(0x20d6), Some(0xa711))
    // rust: | (Some(0x0e6f), Some(0x0180)) => GlyphStyle::Nintendo,
    // rust: _ => GlyphStyle::Xbox,
}
}
}

// The on-screen keyboard A opens on a text field in focus mode.
TextKeyboard :: enum {
    // Steam's on a Steam Deck under Steam, else Horizon's.
    Auto,
    Horizon,
    Steam,
}
    // rust: impl TextKeyboard {
    // rust: pub const ALL: [TextKeyboard; 3] = [
    // rust: TextKeyboard::Auto,
    // rust: TextKeyboard::Horizon,
    // rust: TextKeyboard::Steam,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: TextKeyboard::Auto => "auto",
    // rust: TextKeyboard::Horizon => "horizon",
    // rust: TextKeyboard::Steam => "steam",
}
}
parse :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "horizon" => TextKeyboard::Horizon,
    // rust: "steam" => TextKeyboard::Steam,
    // rust: _ => TextKeyboard::Auto,
}
}
}

// Whether A on a text field asks Steam for its keyboard
// (`steam://open/keyboard`) instead of opening Horizon's: chosen, or `Auto`
// on a Steam Deck (Steam sets `SteamDeck=1` for the games it starts).
steam_keyboard :: proc(choice: TextKeyboard) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match choice {
    // rust: TextKeyboard::Steam => true,
    // rust: TextKeyboard::Horizon => false,
    // rust: TextKeyboard::Auto => std::env::var("SteamDeck").is_ok_and(|v| v == "1"),
}
}

// The controller settings (`horizon-controller.txt`).
PadSettings :: struct {
    enabled: bool,
    vibration: bool,
    // A DualSense's triggers push back (Horizon's; docs/controllers.md).
    adaptive_triggers: bool,
    lightbar: Lightbar,
    // 0..1; 0.5 is the default speed, 1 twice that.
    look_sensitivity: f32,
    invert_x: bool,
    invert_y: bool,
    move_deadzone: f32,
    look_deadzone: f32,
    trigger_threshold: f32,
    // The sneak button flips sneaking (Bedrock's default) instead of
    // holding it, unless vanilla's toggle crouch is on already.
    toggle_sneak: bool,
    glyphs: GlyphStyle,
    // A Nintendo pad's face buttons go by their letters (A confirms and jumps, as on the
    // Switch's own menus and keyboard) instead of their places (B, at the bottom, does): on
    // by default on the Switch only.
    nintendo_letters: bool,
    keyboard: TextKeyboard,
    // Menu pointer multiplier, scroll lines/second, and repeat times in seconds.
    pointer_speed: f32,
    scroll_speed: f32,
    repeat_delay: f32,
    repeat_interval: f32,
    // Action name -> button, `None` for unbound; missing means the default.
    bindings: BTreeMap<^'static str,
}
    // rust: impl Default for PadSettings {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: enabled: true,
    // rust: vibration: true,
    // rust: adaptive_triggers: true,
    // rust: lightbar: Lightbar::Health,
    // rust: look_sensitivity: 0.5,
    // rust: invert_x: false,
    // rust: invert_y: false,
    // rust: move_deadzone: 0.15,
    // rust: look_deadzone: 0.12,
    // rust: trigger_threshold: 0.4,
    // rust: toggle_sneak: true,
    // rust: glyphs: GlyphStyle::Auto,
    // rust: nintendo_letters: cfg!(target_os = "horizon"),
    // rust: keyboard: TextKeyboard::Auto,
    // rust: pointer_speed: 1.0,
    // rust: scroll_speed: 12.0,
    // rust: repeat_delay: 0.35,
    // rust: repeat_interval: 0.09,
    // rust: bindings: BTreeMap::new(),
}
}
}
bool_text :: proc(v: bool) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if v { "true" } else { "false" }
}
    // rust: impl PadSettings {
load :: proc(dir: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: fs::read_to_string(dir.join(FILE))
    // rust: .map(|t| Self::parse(&t))
    // rust: .unwrap_or_default()
}
    // Written once something differs from the defaults, so players who
    // never touch a controller get no new file.
save :: proc(self: ^Self, dir: ^Path) {
}
    // rust: let path = dir.join(FILE);
    // rust: if *self != Self::default() || path.exists() {
    // rust: let _ = fs::write(path, self.serialize());
}
}
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = Self::default();
    // rust: for line in text.lines() {
    // rust: let Some((key, value)) = line.split_once(':') else {
    // rust: continue;
}
    // rust: let value = value.trim();
    // rust: let flag = |d: bool| match value {
    // rust: "true" => true,
    // rust: "false" => false,
    // rust: _ => d,
}
    // rust: let unit = |d: f32| {
    // rust: value
    // rust: .parse::<f32>()
    // rust: .ok()
    // rust: .filter(|v| v.is_finite())
    // rust: .map_or(d, |v| v.clamp(0.0, 1.0))
}
    // rust: let bounded = |default: f32, min: f32, max: f32| {
    // rust: value
    // rust: .parse::<f32>()
    // rust: .ok()
    // rust: .filter(|v| v.is_finite())
    // rust: .map_or(default, |v| v.clamp(min, max))
}
    // rust: match key.trim() {
    // rust: "enabled" => s.enabled = flag(s.enabled),
    // rust: "vibration" => s.vibration = flag(s.vibration),
    // rust: "adaptiveTriggers" => s.adaptive_triggers = flag(s.adaptive_triggers),
    // rust: "lightbar" => s.lightbar = Lightbar::parse(value),
    // rust: "lookSensitivity" => s.look_sensitivity = unit(s.look_sensitivity),
    // rust: "invertX" => s.invert_x = flag(s.invert_x),
    // rust: "invertY" => s.invert_y = flag(s.invert_y),
    // rust: "moveDeadzone" => s.move_deadzone = unit(s.move_deadzone).min(0.9),
    // rust: "lookDeadzone" => s.look_deadzone = unit(s.look_deadzone).min(0.9),
    // rust: "triggerThreshold" => {
    // rust: s.trigger_threshold = unit(s.trigger_threshold).clamp(0.1, 0.9)
}
    // rust: "toggleSneak" => s.toggle_sneak = flag(s.toggle_sneak),
    // rust: "glyphs" => s.glyphs = GlyphStyle::parse(value),
    // rust: "nintendoLetters" => s.nintendo_letters = flag(s.nintendo_letters),
    // rust: "keyboard" => s.keyboard = TextKeyboard::parse(value),
    // rust: "pointerSpeed" => s.pointer_speed = bounded(s.pointer_speed, 0.25, 3.0),
    // rust: "scrollSpeed" => s.scroll_speed = bounded(s.scroll_speed, 1.0, 36.0),
    // rust: "repeatDelay" => s.repeat_delay = bounded(s.repeat_delay, 0.1, 1.0),
    // rust: "repeatInterval" => s.repeat_interval = bounded(s.repeat_interval, 0.03, 0.3),
    // rust: other => {
    // rust: if let Some(action) = other.strip_prefix("bind_") {
    // rust: let button = if value == "none" {
    // rust: Some(None)
    // rust: } else {
    // rust: Button::parse(value).map(Some)
}
    // rust: if let Some(button) = button {
    // rust: s.bind(action, button);
}
}
}
}
}
        // A file from before these defaults: its player's buttons stay where they were.
    // rust: if !text.is_empty() && !text.lines().any(|line| line.starts_with("bindLayout:")) {
    // rust: for (action, button) in [
    // rust: ("key.drop", Button::East),
    // rust: ("key.togglePerspective", Button::DPadUp),
    // rust: ("key.chat", Button::DPadRight),
    // rust: ("key.playerlist", Button::Select),
    // rust: ("key.advancements", Button::DPadDown),
    // rust: ] {
                // A button saved by hand stays, even one that's now this action's default.
    // rust: if !text
    // rust: .lines()
    // rust: .any(|line| line.starts_with(&format!("bind_{action}:")))
    // rust: {
    // rust: s.bindings.entry(action).or_insert(Some(button));
}
}
}
    // rust: s
}
serialize :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut text = format!(
    // rust: "enabled:{}\nvibration:{}\nadaptiveTriggers:{}\nlightbar:{}\nlookSensitivity:{}\ninvertX:{}\ninvertY:{}\nmoveDeadzone:{}\nlookDeadzone:{}\ntriggerThreshold:{}\ntoggleSneak:{}\nglyphs:{}\nnintendoLetters:{}\nkeyboard:{}\n",
    // rust: bool_text(self.enabled),
    // rust: bool_text(self.vibration),
    // rust: bool_text(self.adaptive_triggers),
    // rust: self.lightbar.name(),
    // rust: self.look_sensitivity,
    // rust: bool_text(self.invert_x),
    // rust: bool_text(self.invert_y),
    // rust: self.move_deadzone,
    // rust: self.look_deadzone,
    // rust: self.trigger_threshold,
    // rust: bool_text(self.toggle_sneak),
    // rust: self.glyphs.name(),
    // rust: bool_text(self.nintendo_letters),
    // rust: self.keyboard.name(),
    // rust: );
    // rust: text.push_str(&format!(
    // rust: "pointerSpeed:{}\nscrollSpeed:{}\nrepeatDelay:{}\nrepeatInterval:{}\n",
    // rust: self.pointer_speed, self.scroll_speed, self.repeat_delay, self.repeat_interval,
    // rust: ));
    // rust: for (action, button) in &self.bindings {
    // rust: text.push_str(&format!(
    // rust: "bind_{action}:{}\n",
    // rust: button.map_or("none", Button::name)
    // rust: ));
}
    // rust: text.push_str("bindLayout:1\n");
    // rust: text
}
default_of :: proc(action: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: ACTIONS.iter().find(|a| a.0 == action).and_then(|a| a.1)
}
    // The button an action is bound to.
binding :: proc(self: ^Self, action: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.bindings.get(action) {
    // rust: Some(button) => *button,
    // rust: None => Self::default_of(action),
}
}
    // Bind an action (`None` unbinds); unknown actions are ignored.
bind :: proc(self: ^Self, action: string, button: Maybe(Button)) {
}
    // rust: let Some((name, default)) = ACTIONS.iter().find(|a| a.0 == action) else {
    // rust: return;
}
    // rust: if button == *default {
    // rust: self.bindings.remove(name);
    // rust: } else {
    // rust: self.bindings.insert(name, button);
}
}
reset_bindings :: proc(self: ^Self) {
}
    // rust: self.bindings.clear();
}
    // Other actions on the same button (marked in the binds list).
conflicts :: proc(self: ^Self, action: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.binding(action)
    // rust: .is_some_and(|b| self.actions_of(b).iter().any(|a| *a != action))
}
is_default :: proc(self: ^Self, action: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.bindings.contains_key(action)
}
    // The actions a button triggers, in `ACTIONS` order.
actions_of :: proc(self: ^Self, button: Button) -> V {
    // Ported from Horizon
    return {}
}
    // rust: ACTIONS
    // rust: .iter()
    // rust: .map(|a| a.0)
    // rust: .filter(|a| self.binding(a) == Some(button))
    // rust: .collect()
}
}

length :: proc(v: [f32; 2]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (v[0] * v[0] + v[1] * v[1]).sqrt()
}

// 8BitDo Ultimate 2 Wireless (`2dc8:6012`). gilrs' bundled SDL DB only has a
// Windows row for it; on Linux/Bluetooth the right stick is on ABS_Z/ABS_RX
// (`LeftZ`/`RightStickX`) until an SDL mapping matches.
BITDO_ULTIMATE2_VID_PID :: (0x2dc8, 0x6012)

// Stick axes after correcting pads whose right stick gilrs still exposes on
// `LeftZ`/`RightStickX` (no matching SDL row for this device version).
// `sdl_mapped` is true when gilrs already applied an SDL gamecontroller row.
    // rust: pub fn stick_axes(
    // rust: left: [f32; 2],
    // rust: right: [f32; 2],
    // rust: left_z: f32,
    // rust: vendor: Option<u16>,
    // rust: product: Option<u16>,
    // rust: sdl_mapped: bool,
    // rust: ) -> ([f32; 2], [f32; 2]) {
    // rust: if !sdl_mapped
    // rust: && vendor == Some(BITDO_ULTIMATE2_VID_PID.0)
    // rust: && product == Some(BITDO_ULTIMATE2_VID_PID.1)
    // rust: {
        // Default map: RightStickX is the stick's Y, LeftZ its X; RightStickY
        // is the right trigger and must not drive look.
    // rust: (left, [left_z, right[0]])
    // rust: } else {
    // rust: (left, right)
}
}

// The tilt from which a stick holds a key in [`eight_direction_keys`]: holding one is full speed,
// so the small tilts past the deadzone stay still.
KEY_TILT :: 0.3
// tan(22.5 degrees): where one of the 8 sectors meets the next.
SECTOR_EDGE :: 0.414_213_57

// The movement keys (forward, backward, left, right) a move vector (`[left, forward]`) holds: the
// one of the 8 headings it is nearest, so it is at most 22.5 degrees off. An edge goes to the
// straight heading.
eight_direction_keys :: proc(forward]: [f32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if length([left, forward]) < KEY_TILT {
    // rust: return [false; 4];
}
    // rust: let along = forward.abs() > SECTOR_EDGE * left.abs();
    // rust: let across = left.abs() > SECTOR_EDGE * forward.abs();
    // rust: [
    // rust: along && forward > 0.0,
    // rust: along && forward < 0.0,
    // rust: across && left > 0.0,
    // rust: across && left < 0.0,
    // rust: ]
}

// A radial deadzone: inside it the stick is centred; beyond it the rest of
// the travel is rescaled to 0..1 in the same direction, so diagonals aren't
// clipped and the first movement past the deadzone is small.
radial :: proc(v: [f32; 2], deadzone: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let len = length(v);
    // rust: if !len.is_finite() || len <= deadzone || len == 0.0 {
    // rust: return [0.0, 0.0];
}
    // rust: let scaled = ((len - deadzone) / (1.0 - deadzone)).min(1.0);
    // rust: [v[0] / len * scaled, v[1] / len * scaled]
}

// The left stick as the player's move vector, in `KeyboardInput`'s layout
// (`[left, forward]`, length at most 1); `None` inside the deadzone.
move_vector :: proc(stick: [f32; 2], deadzone: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let v = radial(stick, deadzone);
    // rust: (v != [0.0, 0.0]).then_some([-v[0], v[1]])
}

// Degrees per second at full tilt and the default sensitivity.
YAW_SPEED :: 200.0
PITCH_SPEED :: 140.0

// The view turn from the right stick over `seconds`: `(yaw, pitch)` in
// degrees, pitch positive looking down as in `Entity.turn`. A squared
// curve keeps small tilts precise; a spyglass slows it down.
    // rust: pub fn look_delta(
    // rust: stick: [f32; 2],
    // rust: settings: &PadSettings,
    // rust: seconds: f32,
    // rust: scoping: bool,
    // rust: ) -> (f32, f32) {
    // rust: let v = radial(stick, settings.look_deadzone);
    // rust: let len = length(v);
    // rust: if len == 0.0 {
    // rust: return (0.0, 0.0);
}
    // The vector already has length `len`: scaling by it squares the tilt.
    // rust: let curve = len;
    // rust: let speed = settings.look_sensitivity * 2.0 * if scoping { 0.25 } else { 1.0 };
    // rust: let x = v[0] * curve * if settings.invert_x { -1.0 } else { 1.0 };
    // rust: let y = v[1] * curve * if settings.invert_y { -1.0 } else { 1.0 };
    // rust: (
    // rust: x * YAW_SPEED * speed * seconds,
    // rust: -y * PITCH_SPEED * speed * seconds,
    // rust: )
}

// Menu cursor speed in GUI pixels per second at full tilt.
CURSOR_SPEED :: 300.0

// How far the menu cursor moves for a stick over `seconds`, in GUI pixels
// (`y` down): a squared curve, so a light touch lands on a slot.
cursor_delta :: proc(stick: [f32; 2], deadzone: f32, seconds: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let v = radial(stick, deadzone);
    // rust: let len = length(v);
    // rust: if len == 0.0 {
    // rust: return (0.0, 0.0);
}
    // rust: let speed = (CURSOR_SPEED * len + 30.0) * seconds;
    // rust: (v[0] * speed, -v[1] * speed)
}

// The target a D-pad press moves focus to: the nearest one inside a cone
// around the direction, weighing sideways distance double.
focus_step :: proc(from: (f32) {
}
    // rust: let (dx, dy) = match button {
    // rust: Button::DPadUp => (0.0, -1.0),
    // rust: Button::DPadDown => (0.0, 1.0),
    // rust: Button::DPadLeft => (-1.0, 0.0),
    // rust: Button::DPadRight => (1.0, 0.0),
    // rust: _ => return None,
}
    // rust: targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, t)| {
    // rust: let (x, y) = (t.0 - from.0, t.1 - from.1);
    // rust: let along = x * dx + y * dy;
    // rust: let across = (x * dy - y * dx).abs();
    // rust: (along > 2.0 && across <= along * 2.0).then_some((i, along + 2.0 * across))
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(i, _)| i)
}

// A rectangle `[x, y, w, h]` in GUI pixels.
    // rust: pub type Rect = [f32; 4];

// The D-pad direction a stick points to, when pushed past `threshold`
// mostly along one axis (focus steps like the D-pad).
stick_direction :: proc(stick: [f32; 2], threshold: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y] = stick;
    // rust: if length(stick) < threshold {
    // rust: return None;
}
    // rust: Some(if x.abs() > y.abs() {
    // rust: if x > 0.0 {
    // rust: Button::DPadRight
    // rust: } else {
    // rust: Button::DPadLeft
}
    // rust: } else if y > 0.0 {
    // rust: Button::DPadUp
    // rust: } else {
    // rust: Button::DPadDown
    // rust: })
}

// How far a stick already stepping must fall back to let go: between this and
// the step threshold it holds its direction, so a stick resting on the
// threshold doesn't step again.
STICK_RELEASE :: 0.35
// How much more a stick must lean along another axis to change direction, so
// a stick resting on a diagonal doesn't flip between the two.
STICK_TURN :: 1.5

// [`stick_direction`] for a stick that may already be stepping `held`: it stays
// that way until the stick falls back past [`STICK_RELEASE`] or clearly turns.
    // rust: pub fn stick_direction_held(
    // rust: stick: [f32; 2],
    // rust: threshold: f32,
    // rust: held: Option<Button>,
    // rust: ) -> Option<Button> {
    // rust: let fresh = stick_direction(stick, threshold);
    // rust: let Some((axis, positive)) = held.and_then(direction) else {
    // rust: return fresh;
}
    // rust: if length(stick) < STICK_RELEASE {
    // rust: return None;
}
    // `direction`'s y runs down the screen, a stick's up.
    // rust: let toward = stick[axis] * if positive == (axis == 0) { 1.0 } else { -1.0 };
    // rust: if toward > 0.0 && stick[1 - axis].abs() <= toward * STICK_TURN {
    // rust: held
    // rust: } else {
    // rust: fresh
}
}

// A list drawn with a scrollbar (`ui::scrollbar`), how far it is scrolled (a list
// moving a whole row a notch draws the same rectangles, so they can't tell) and
// the ways it can still scroll.
ScrollArea :: struct {
    rect: Rect,
    amount: f32,
    up: bool,
    down: bool,
}

    // rust: impl ScrollArea {
    // A row counts while any of it is in view: the stick can leave the focus on one nearly gone.
holds :: proc(self: ^Self, r: ^Rect) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let x = r[0] + r[2] / 2.0;
    // rust: let [ax, ay, aw, ah] = self.rect;
    // rust: (ax..ax + aw).contains(&x) && r[1] < ay + ah && r[1] + r[3] > ay
}
    // All of a row is in view.
shows :: proc(self: ^Self, r: ^Rect) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let [_, ay, _, ah] = self.rect;
    // rust: self.holds(r) && r[1] + 0.5 >= ay && r[1] + r[3] <= ay + ah + 0.5
}
}

// A vertical focus step, with lists: the strict step, unless it would land
// outside the view of the list `from` is in, or only partly in it, while that
// list can still scroll that way, when there is none (`None`) and the list
// scrolls instead: its hidden rows come first and whole, as vanilla's arrow
// keys walk a selection list's entries (`ensureVisible`).
    // rust: pub fn list_step(
    // rust: from: Rect,
    // rust: button: Button,
    // rust: targets: &[Rect],
    // rust: areas: &[ScrollArea],
    // rust: ) -> Option<usize> {
    // rust: let step = focus_step_strict(from, button, targets)?;
    // rust: let can_scroll = |a: &ScrollArea| {
    // rust: if button == Button::DPadUp {
    // rust: a.up
    // rust: } else {
    // rust: a.down
}
}
    // rust: let leaves = areas
    // rust: .iter()
    // rust: .find(|a| a.holds(&from))
    // rust: .is_some_and(|a| can_scroll(a) && !a.shows(&targets[step]));
    // rust: (!leaves).then_some(step)
}

// The farthest centres of two neighbouring slots: 18 apart, 22 over the hotbar's gap.
SLOT_NEIGHBOUR :: 24.0

// A held direction's repeat stops at the edge of the slots it is walking: it
// goes on only from a slot to a slot next to it (the hotbar's small gap
// included). A fresh press may go anywhere.
repeat_crosses_slots :: proc(from: (f32) {
}
    // rust: !to_slot || (to.0 - from.0).abs().max((to.1 - from.1).abs()) > SLOT_NEIGHBOUR
}

// Arrow-key focus navigation as vanilla does it
// (`ContainerEventHandler.nextFocusPathInDirection`), over every target of
// the screen at once: from a strip one pixel past the focused edge, the
// nearest target overlapping it on the other axis wins (ties: leftmost or
// topmost); without one, the target whose facing edge's centre is nearest
// the focused edge's centre (`nextFocusPathVaguelyInDirection`). Bounds are
// inclusive as in `ScreenRectangle` (a right edge is `x + w - 1`).
focus_step_rect :: proc(from: Rect, button: Button, targets: ^[Rect]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: focus_step_strict(from, button, targets).or_else(|| focus_step_vague(from, button, targets))
}

// The direction as (axis: 0 = x, 1 = y; positive).
direction :: proc(button: Button) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match button {
    // rust: Button::DPadUp => Some((1, false)),
    // rust: Button::DPadDown => Some((1, true)),
    // rust: Button::DPadLeft => Some((0, false)),
    // rust: Button::DPadRight => Some((0, true)),
    // rust: _ => None,
}
}

// The first pass of [`focus_step_rect`]: targets overlapping the focused
// one on the other axis (a row, a column).
focus_step_strict :: proc(from: Rect, button: Button, targets: ^[Rect]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (axis, positive) = direction(button)?;
    // rust: let other = 1 - axis;
    // rust: let lo = |r: &Rect, a: usize| r[a];
    // rust: let hi = |r: &Rect, a: usize| r[a] + r[a + 2] - 1.0;
    // Bound in a direction (`getBoundInDirection`).
    // rust: let bound = |r: &Rect, a: usize, pos: bool| if pos { hi(r, a) } else { lo(r, a) };
    // rust: let after = |a: f32, b: f32| if positive { a > b + 1e-3 } else { b > a + 1e-3 };
    // `getBorder(direction)`: the strip one pixel past the focused edge.
    // rust: let mut strip = from;
    // rust: strip[axis] = bound(&from, axis, positive) + if positive { 1.0 } else { -1.0 };
    // rust: strip[axis + 2] = 1.0;
    // rust: let first = bound(&strip, axis, !positive);
    // rust: let same = |a: &Rect, b: &Rect| a.iter().zip(b).all(|(x, y)| (x - y).abs() < 0.5);
    // rust: let mut strict: Vec<(usize, f32, f32)> = targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, r)| !same(r, &from))
    // rust: .filter(|(_, r)| lo(r, other).max(lo(&strip, other)) <= hi(r, other).min(hi(&strip, other)))
    // rust: .filter(|(_, r)| {
    // rust: let child_first = bound(r, axis, !positive);
    // rust: after(child_first, first)
    // rust: || ((child_first - first).abs() < 1e-3
    // rust: && after(bound(r, axis, positive), bound(&strip, axis, positive)))
    // rust: })
    // rust: .map(|(i, r)| (i, bound(r, axis, !positive), lo(r, other)))
    // rust: .collect();
    // rust: strict.sort_by(|a, b| {
    // rust: let primary = if positive {
    // rust: a.1.total_cmp(&b.1)
    // rust: } else {
    // rust: b.1.total_cmp(&a.1)
}
    // rust: primary.then(a.2.total_cmp(&b.2))
    // rust: });
    // rust: strict.first().map(|s| s.0)
}

// The second pass of [`focus_step_rect`]: the target whose facing edge's
// centre is nearest the focused edge's centre.
focus_step_vague :: proc(from: Rect, button: Button, targets: ^[Rect]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (axis, positive) = direction(button)?;
    // rust: let other = 1 - axis;
    // rust: let lo = |r: &Rect, a: usize| r[a];
    // rust: let hi = |r: &Rect, a: usize| r[a] + r[a + 2] - 1.0;
    // rust: let bound = |r: &Rect, a: usize, pos: bool| if pos { hi(r, a) } else { lo(r, a) };
    // rust: let after = |a: f32, b: f32| if positive { a > b + 1e-3 } else { b > a + 1e-3 };
    // rust: let same = |a: &Rect, b: &Rect| a.iter().zip(b).all(|(x, y)| (x - y).abs() < 0.5);
    // rust: let mut strip = from;
    // rust: strip[axis] = bound(&from, axis, positive) + if positive { 1.0 } else { -1.0 };
    // rust: strip[axis + 2] = 1.0;
    // rust: let centre = |r: &Rect, a: usize| (hi(r, a) + lo(r, a)) / 2.0;
    // rust: let edge = bound(&strip, axis, positive);
    // rust: let mid = centre(&strip, other);
    // rust: targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, r)| !same(r, &from))
    // rust: .filter_map(|(i, r)| {
    // rust: let facing = bound(r, axis, !positive);
    // rust: after(facing, edge).then(|| {
    // rust: let (d1, d2) = (facing - edge, centre(r, other) - mid);
    // rust: (i, d1 * d1 + d2 * d2)
    // rust: })
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(i, _)| i)
}

// How far a list scrolled between two frames' targets: the vertical shift
// most targets of the same position and size agree on (targets that didn't
// move, outside the list, don't count), for a list scrolled towards its end
// (`down`: the rows moved up) or its start. `None` when nothing moved that way.
// It takes the direction because half a row's scroll votes the same both ways.
scroll_shift :: proc(before: ^[Rect], after: ^[Rect], down: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let same = |a: &Rect, b: &Rect| a.iter().zip(b).all(|(x, y)| (x - y).abs() < 0.5);
    // rust: if before.len() == after.len() && before.iter().zip(after).all(|(a, b)| same(a, b)) {
    // rust: return None;
}
    // Most votes; among equals the smallest move (the next row, not a far one).
    // rust: shift_votes(before, after)
    // rust: .into_iter()
    // rust: .filter(|v| (v.0 < 0.0) == down)
    // rust: .max_by(|a, b| a.1.cmp(&b.1).then(b.0.abs().total_cmp(&a.0.abs())))
    // rust: .map(|v| v.0)
}

// Every vertical shift that would carry a `before` target onto an `after`
// target of the same position and size, with how many it would.
shift_votes :: proc(before: ^[Rect], after: ^[Rect]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut votes: Vec<(f32, usize)> = Vec::new();
    // rust: for b in before {
    // rust: for a in after {
    // rust: let dy = a[1] - b[1];
    // rust: if (a[0] - b[0]).abs() < 0.5
    // rust: && (a[2] - b[2]).abs() < 0.5
    // rust: && (a[3] - b[3]).abs() < 0.5
    // rust: && dy.abs() >= 0.5
    // rust: {
    // rust: match votes.iter_mut().find(|v| (v.0 - dy).abs() < 0.5) {
    // rust: Some(v) => v.1 += 1,
    // rust: None => votes.push((dy, 1)),
}
}
}
}
    // rust: votes
}

// Where the focus goes when the right stick scrolled a list (`down`: towards
// its end, so the rows moved up): the rectangle moved by the list's shift;
// the same rectangle, for a widget outside the list; or, its row out of view,
// the nearest target of its kind (`after`'s flag), the list's rows before
// anything fixed. `None` when nothing moved that way, or none of its kind is
// left. It takes the direction because half a row's scroll votes the same
// both ways once a new row comes into view.
    // rust: pub fn follow_scroll(
    // rust: focus: Rect,
    // rust: down: bool,
    // rust: before: &[Rect],
    // rust: after: &[(Rect, bool)],
    // rust: ) -> Option<usize> {
    // rust: let rects: Vec<Rect> = after.iter().map(|t| t.0).collect();
    // A column that stayed put isn't the list, even spaced like its shift.
    // rust: let column = |of: &[Rect], r: &Rect| -> Vec<f32> {
    // rust: let same = |o: &&Rect| o[0] == r[0] && o[2] == r[2] && o[3] == r[3];
    // rust: of.iter().filter(same).map(|o| o[1]).collect()
}
    // rust: let moving = |r: &&Rect| column(before, r) != column(&rects, r);
    // rust: let was: Vec<Rect> = before.iter().filter(moving).copied().collect();
    // rust: let now: Vec<Rect> = rects.iter().filter(moving).copied().collect();
    // rust: let dy = shift_votes(&was, &now)
    // rust: .into_iter()
    // rust: .filter(|v| (v.0 < 0.0) == down)
    // rust: .max_by(|a, b| a.1.cmp(&b.1).then(b.0.abs().total_cmp(&a.0.abs())))?
    // rust: .0;
    // rust: let same = |a: &Rect, b: &Rect| a.iter().zip(b).all(|(x, y)| (x - y).abs() < 0.5);
    // rust: let moved = [focus[0], focus[1] + dy, focus[2], focus[3]];
    // rust: let found = |at: &Rect| rects.iter().position(|r| same(r, at));
    // rust: if !moving(&&focus) {
    // rust: return found(&focus);
}
    // rust: if let Some(i) = found(&moved).or_else(|| found(&focus)) {
    // rust: return Some(i);
}
    // rust: let in_list = |r: &Rect| {
    // rust: let was = [r[0], r[1] - dy, r[2], r[3]];
    // rust: before.iter().any(|b| same(b, &was))
}
    // rust: let centre = (moved[0] + moved[2] / 2.0, moved[1] + moved[3] / 2.0);
    // rust: let distance = |r: &Rect| (r[0] + r[2] / 2.0 - centre.0).hypot(r[1] + r[3] / 2.0 - centre.1);
    // rust: after
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, t)| t.1)
    // rust: .min_by(|(_, a), (_, b)| {
    // rust: in_list(&b.0)
    // rust: .cmp(&in_list(&a.0))
    // rust: .then(distance(&a.0).total_cmp(&distance(&b.0)))
    // rust: })
    // rust: .map(|(i, _)| i)
}

// The target a focus rectangle stands for once the screen's size changed:
// the same widget, by its place in the draw order when the screen drew as
// many; else the target nearest where its centre falls at the new size.
    // rust: pub fn refind_resized(
    // rust: focus: Rect,
    // rust: before: &[Rect],
    // rust: after: &[Rect],
    // rust: old: (f32, f32),
    // rust: new: (f32, f32),
    // rust: ) -> Option<usize> {
    // rust: let same = |r: &Rect| r.iter().zip(&focus).all(|(a, b)| (a - b).abs() < 0.5);
    // rust: if before.len() == after.len()
    // rust: && let Some(i) = before.iter().position(same)
    // rust: {
    // rust: return Some(i);
}
    // rust: let at = rescaled(
    // rust: (focus[0] + focus[2] / 2.0, focus[1] + focus[3] / 2.0),
    // rust: old,
    // rust: new,
    // rust: );
    // rust: let centres: Vec<(f32, f32)> = after
    // rust: .iter()
    // rust: .map(|r| (r[0] + r[2] / 2.0, r[1] + r[3] / 2.0))
    // rust: .collect();
    // rust: nearest(at, &centres, f32::INFINITY)
}

// A point at the same place, proportionally, on a screen of another size.
rescaled :: proc(at: (f32) {
}
    // rust: (at.0 * new.0 / old.0.max(1.0), at.1 * new.1 / old.1.max(1.0))
}

// The target a remembered focus rectangle stands for in a new frame: the
// same rectangle, else the nearest centre within `radius` (the screen
// moved it a little: a scrolled list, a resized window).
refind :: proc(focus: Rect, targets: ^[Rect], radius: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let same = |r: &Rect| r.iter().zip(&focus).all(|(a, b)| (a - b).abs() < 0.5);
    // rust: if let Some(i) = targets.iter().position(same) {
    // rust: return Some(i);
}
    // rust: let c = |r: &Rect| (r[0] + r[2] / 2.0, r[1] + r[3] / 2.0);
    // rust: let centres: Vec<(f32, f32)> = targets.iter().map(c).collect();
    // rust: nearest(c(&focus), &centres, radius)
}

// The next tab after a bumper among tab targets (left to right, then top
// to bottom), wrapping; `None` with fewer than two tabs.
tab_step :: proc(tabs: ^[(Rect) {
}
    // rust: if tabs.len() < 2 {
    // rust: return None;
}
    // rust: let mut order: Vec<usize> = (0..tabs.len()).collect();
    // rust: order.sort_by(|&a, &b| {
    // rust: let (ra, rb) = (tabs[a].0, tabs[b].0);
        // A vertical strip of tabs (a sidebar) reads top to bottom.
    // rust: ra[1].total_cmp(&rb[1]).then(ra[0].total_cmp(&rb[0]))
    // rust: });
    // rust: let n = order.len();
    // rust: let at = order.iter().position(|&i| tabs[i].1).unwrap_or(0);
    // rust: Some(
    // rust: order[if forward {
    // rust: (at + 1) % n
    // rust: } else {
    // rust: (at + n - 1) % n
    // rust: }],
    // rust: )
}

// A slider nudge: the pointer x that sets `value` (0..1) on a track
// `[start, width]` (for vanilla's sliders `x + 4` and `w - 8`:
// `AbstractSliderButton.setValueFromMouse` inverted).
slider_x :: proc(track: [f32; 2], value: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: track[0] + value.clamp(0.0, 1.0) * track[1]
}

// Pixels a held left/right moves a slider handle per step: one pixel (a
// vanilla arrow key press) at first, faster while held.
slider_step :: proc(repeats: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: [1.0, 1.0, 2.0, 2.0, 4.0, 4.0, 8.0][repeats.min(6) as usize]
}

// The target within `radius` of `at`, nearest first (the cursor settles
// onto a slot or button when the stick lets go).
nearest :: proc(at: (f32) {
}
    // rust: targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, t)| (i, (t.0 - at.0).hypot(t.1 - at.1)))
    // rust: .filter(|(_, d)| *d <= radius)
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
    // rust: .map(|(i, _)| i)
}

// Damage taken, from the player's health between polls. The baseline is
// forgotten whenever there is no player or a new player entity replaces
// the old one (a world loaded, a respawn, a server joined, a dimension
// change), so arriving with less health than before isn't damage.
HealthWatch :: struct {
    last: Maybe(f32),
}
    // rust: impl HealthWatch {
    // The health now (`None` without a player); returns the damage taken
    // since the last call.
observe :: proc(self: ^Self, health: Maybe(f32)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let before = std::mem::replace(&mut self.last, health);
    // rust: match (before, health) {
    // rust: (Some(before), Some(now)) if now < before => Some(before - now),
    // rust: _ => None,
}
}
forget :: proc(self: ^Self) {
}
    // rust: self.last = None;
}
}

// What makes the pad vibrate (Bedrock-like: short, light pulses).
Rumble :: enum {
    // The player lost this much health.
    Hurt(f32),
    BlockBroken,
    // An explosion this far away (blocks) with this power.
    Explosion {,
    distance: f64,
    radius: f32,
    // rust: },
    Totem,
}
// A vibration: the heavy (low-frequency) and light motors, 0..1, and how
// long it lasts.
Pulse :: struct {
    strong: f32,
    weak: f32,
    millis: u32,
}
    // rust: impl Rumble {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Rumble::Hurt(_) => "hurt",
    // rust: Rumble::BlockBroken => "block",
    // rust: Rumble::Explosion { .. } => "explosion",
    // rust: Rumble::Totem => "totem",
}
}
    // The pulse, or `None` when it is too faint to feel.
pulse :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Rumble::Hurt(amount) if amount > 0.0 => Some(Pulse {
    // rust: strong: (0.2 + 0.06 * amount).min(0.8),
    // rust: weak: 0.3,
    // rust: millis: (150.0 + 20.0 * amount).min(400.0) as u32,
    // rust: }),
    // rust: Rumble::Hurt(_) => None,
    // rust: Rumble::BlockBroken => Some(Pulse {
    // rust: strong: 0.0,
    // rust: weak: 0.25,
    // rust: millis: 60,
    // rust: }),
    // rust: Rumble::Explosion { distance, radius } => {
                // Felt up to four times the blast radius, fading with distance.
    // rust: let reach = f64::from(radius.max(1.0)) * 4.0;
    // rust: let near = (1.0 - distance / reach) as f32;
    // rust: (near > 0.05).then_some(Pulse {
    // rust: strong: 0.9 * near,
    // rust: weak: 0.6 * near,
    // rust: millis: 350,
    // rust: })
}
    // rust: Rumble::Totem => Some(Pulse {
    // rust: strong: 0.7,
    // rust: weak: 0.7,
    // rust: millis: 500,
    // rust: }),
}
}

    // The pulse shaped, for a pad that plays steps (a DualSense): a hit starts at full
    // strength and dies away, an explosion rolls on, a totem swells; a broken block is a tick.
shape :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = self.pulse() else {
    // rust: return Vec::new();
}
    // rust: let step = |level: f32, millis: u32| Pulse {
    // rust: strong: p.strong * level,
    // rust: weak: p.weak * level,
    // rust: millis,
}
    // rust: match self {
    // rust: Rumble::BlockBroken => vec![Pulse { millis: 35, ..p }],
    // rust: Rumble::Hurt(_) => {
    // rust: let tail = p.millis.saturating_sub(50) / 2;
    // rust: vec![step(1.0, 50), step(0.55, tail), step(0.25, tail)]
}
    // rust: Rumble::Explosion { .. } => vec![
    // rust: step(1.0, 80),
    // rust: step(0.6, 150),
    // rust: step(0.35, 150),
    // rust: step(0.15, 150),
    // rust: ],
    // rust: Rumble::Totem => vec![
    // rust: step(0.4, 100),
    // rust: step(0.7, 100),
    // rust: step(1.0, 200),
    // rust: step(0.5, 100),
    // rust: ],
}
}
}

// What a trigger feels like on a DualSense, from what its action is doing (docs/controllers.md
// "Adaptive triggers" for the choices). Only the pad's official modes: Nielk1's notes warn the
// others may leave the firmware.
TriggerFeel :: enum {
    Free,
    // Drawing a bow, charging a trident, loading a crossbow: resistance that grows with the
    // charge, 0..1.
    Draw(f32),
    // A loaded crossbow: a gun trigger's catch that gives way where it fires.
    Click,
    // Pulling it boosts (a rocket while gliding, the stick while riding a pig or a strider):
    // a lighter catch that gives way where it fires.
    Boost,
    // A shield in the use hand, raised or ready: its weight.
    Brace,
    // That shield disabled by an axe: the trigger locks until it recovers.
    Locked,
    // Mining a block of this hardness: a buzz, stronger and slower on harder blocks.
    Texture(f32),
}
    // rust: impl TriggerFeel {
    // The effect, for a trigger that presses its action at `threshold` (0..1) of its travel.
effect :: proc(self: ^Self, threshold: f32) -> h {
    // Ported from Horizon
    return {}
}
//         use horizon_dualsense::trigger;
        // The zone (of ten along the travel) where the action presses: a catch gives way there,
        // so the click and the shot coincide.
    // rust: let press = ((threshold.clamp(0.0, 1.0) * 10.0) as u8).clamp(3, 8);
    // rust: match self {
    // rust: TriggerFeel::Free => horizon_dualsense::TRIGGER_OFF,
            // From the third zone, so the press itself stays light; at most 6 of 8, as the
            // draw is held.
    // rust: TriggerFeel::Draw(charge) => {
    // rust: trigger::feedback(2, 1 + (5.0 * charge.clamp(0.0, 1.0)).round() as u8)
}
    // rust: TriggerFeel::Click => trigger::weapon((press - 2).max(2), press, 8),
    // rust: TriggerFeel::Boost => trigger::weapon((press - 2).max(2), press, 5),
    // rust: TriggerFeel::Brace => trigger::feedback(2, 3),
    // rust: TriggerFeel::Locked => trigger::feedback(1, 8),
    // rust: TriggerFeel::Texture(hardness) if hardness > 0.0 => {
                // Dirt 2, stone 3, deepslate 4, obsidian 5 of 8.
    // rust: let amplitude = (1.0 + 1.6 * hardness.sqrt()).round().clamp(1.0, 5.0);
                // Sand and dirt a fine 40 Hz grit; stone 30; wood, deepslate and ores 20;
                // obsidian a 10 Hz chisel.
    // rust: let hertz = match hardness {
    // rust: h if h < 1.0 => 40,
    // rust: h if h < 2.0 => 30,
    // rust: h if h < 5.0 => 20,
    // rust: _ => 10,
}
    // rust: trigger::vibration(1, amplitude as u8, hertz)
}
    // rust: TriggerFeel::Texture(_) => horizon_dualsense::TRIGGER_OFF,
}
}
}
    // rust: impl PadSettings {
    // The left and right triggers' effects: each feels the action bound to it, `key.use` or
    // `key.attack`.
    // rust: pub fn trigger_effects(
    // rust: &self,
    // rust: using: TriggerFeel,
    // rust: attacking: TriggerFeel,
    // rust: ) -> [horizon_dualsense::TriggerEffect; 2] {
    // rust: [Button::LeftTrigger, Button::RightTrigger].map(|trigger| {
    // rust: let actions = self.actions_of(trigger);
    // rust: let feel = if !self.adaptive_triggers {
    // rust: TriggerFeel::Free
    // rust: } else if actions.contains(&"key.use") {
    // rust: using
    // rust: } else if actions.contains(&"key.attack") {
    // rust: attacking
    // rust: } else {
    // rust: TriggerFeel::Free
}
    // rust: feel.effect(self.trigger_threshold)
    // rust: })
}
}
// What a DualSense's lightbar shows (`lightbar:`).
Lightbar :: enum {
    // Green at full health through amber to red.
    Health,
    // A colour per dimension.
    Dimension,
    // The pad's own.
    Off,
}
    // rust: impl Lightbar {
ALL :: [Lightbar::Health, Lightbar::Dimension, Lightbar::Off]
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Lightbar::Health => "health",
    // rust: Lightbar::Dimension => "dimension",
    // rust: Lightbar::Off => "off",
}
}
parse :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match name.trim() {
    // rust: "dimension" => Lightbar::Dimension,
    // rust: "off" => Lightbar::Off,
    // rust: _ => Lightbar::Health,
}
}
    // The colour for a player with this share of their health in this dimension; at half
    // brightness, as the pad's full light is glaring.
colour :: proc(self: ^Self, health: f32, dimension: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rgb = match self {
    // rust: Lightbar::Off => return None,
    // rust: Lightbar::Health => {
                // Green to amber over the top half, amber to red below it.
    // rust: let (green, amber, red) = (
    // rust: [34.0, 197.0, 94.0],
    // rust: [245.0, 158.0, 11.0],
    // rust: [239.0, 68.0, 68.0],
    // rust: );
    // rust: let h = health.clamp(0.0, 1.0);
    // rust: let (from, to, k) = if h >= 0.5 {
    // rust: (amber, green, (h - 0.5) * 2.0)
    // rust: } else {
    // rust: (red, amber, h * 2.0)
}
    // rust: [0, 1, 2].map(|i| from[i] + (to[i] - from[i]) * k)
}
    // rust: Lightbar::Dimension => match dimension {
    // rust: "minecraft:the_nether" => [234.0, 88.0, 12.0],
    // rust: "minecraft:the_end" => [139.0, 92.0, 246.0],
    // rust: _ => [14.0, 165.0, 233.0],
    // rust: },
}
    // rust: Some(rgb.map(|v| (v * 0.5).round() as u8))
}
}

// `BowItem.getPowerForTime`: a bow's draw after this many ticks, 0..1.
bow_power :: proc(ticks: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let f = ticks as f32 / 20.0;
    // rust: ((f * f + f * 2.0) / 3.0).min(1.0)
}

    // rust: mod tests {
//     use super::*;

every_bindable_action_reaches_the_game :: proc() {
}
    // rust: for (action, _) in ACTIONS {
    // rust: assert!(route(action).is_some(), "{action} has nowhere to go");
}
}

a_held_drop_repeats_then_throws_the_stack :: proc() {
}
    // rust: let t = Instant::now();
    // rust: let at = |ms: u64| t + Duration::from_millis(ms);
    // rust: let (delay, interval) = (Duration::from_millis(350), Duration::from_millis(90));
    // rust: let mut held = HeldDrop::new(t, delay);
    // rust: assert_eq!(held.due(at(100), interval), None, "a tap is one item");
    // rust: assert_eq!(held.due(at(349), interval), None);
    // rust: assert_eq!(held.due(at(350), interval), Some(DropStep::One));
    // rust: assert_eq!(held.due(at(400), interval), None, "not before the interval");
    // rust: assert_eq!(held.due(at(440), interval), Some(DropStep::One));
    // rust: assert_eq!(held.due(at(999), interval), Some(DropStep::One));
    // rust: assert_eq!(held.due(at(1000), interval), None);
    // rust: assert_eq!(held.due(at(1100), interval), Some(DropStep::Stack));
    // rust: assert_eq!(held.due(at(1200), interval), Some(DropStep::Stack));
    // rust: assert_eq!(held.due(at(1201), interval), None);
}

the_later_actions_have_no_default_button_and_leave_saved_bindings :: proc() {
}
    // rust: let defaults = PadSettings::default();
    // rust: for action in [
    // rust: "key.fullscreen",
    // rust: "key.socialInteractions",
    // rust: "key.quickActions",
    // rust: "key.saveToolbarActivator",
    // rust: "key.loadToolbarActivator",
    // rust: "key.hotbar.1",
    // rust: "key.hotbar.9",
    // rust: ] {
    // rust: assert_eq!(defaults.binding(action), None, "{action}");
}
    // rust: let read = PadSettings::parse(
    // rust: "bindLayout:1
    // rust: bind_key.jump:east
    // rust: bind_key.hotbar.2:north
    // rust: ",
    // rust: );
    // rust: assert_eq!(read.binding("key.jump"), Some(Button::East));
    // rust: assert_eq!(read.binding("key.inventory"), Some(Button::North));
    // rust: assert_eq!(
    // rust: read.actions_of(Button::North),
    // rust: ["key.inventory", "key.hotbar.2"]
    // rust: );
}

navigation_preferences_migrate_and_stay_with_each_player :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-pad-{}-{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos()
    // rust: ));
    // rust: let p2 = dir.join("P2");
    // rust: fs::create_dir_all(&p2).unwrap();
    // rust: let fresh = PadSettings::load(&dir);
    // rust: assert_eq!(fresh, PadSettings::default());
        // An older file, with the removed menuNavigation key: bindings kept.
    // rust: let legacy =
    // rust: PadSettings::parse("menuNavigation:pointer\nbind_key.jump:east\nlookSensitivity:0.7\n");
    // rust: assert_eq!(legacy.binding("key.jump"), Some(Button::East));
    // rust: assert_eq!(legacy.look_sensitivity, 0.7);
    // rust: fresh.save(&dir);
    // rust: assert!(!dir.join(FILE).exists(), "defaults write no file");
    // rust: let mut other = legacy;
    // rust: other.pointer_speed = 2.5;
    // rust: other.scroll_speed = 24.0;
    // rust: other.repeat_delay = 0.6;
    // rust: other.repeat_interval = 0.12;
    // rust: other.save(&p2);
    // rust: assert_eq!(PadSettings::load(&p2), other);
    // rust: assert_eq!(PadSettings::load(&dir), fresh, "P2 did not write P1");
    // rust: let invalid = PadSettings::parse(
    // rust: "pointerSpeed:NaN\nscrollSpeed:inf\nrepeatDelay:-10\nrepeatInterval:20\n",
    // rust: );
    // rust: assert_eq!((invalid.pointer_speed, invalid.scroll_speed), (1.0, 12.0));
    // rust: assert_eq!((invalid.repeat_delay, invalid.repeat_interval), (0.1, 0.3));
    // rust: let bounded = PadSettings::parse(
    // rust: "pointerSpeed:10\nscrollSpeed:-1\nrepeatDelay:NaN\nrepeatInterval:inf\n",
    // rust: );
    // rust: assert_eq!((bounded.pointer_speed, bounded.scroll_speed), (3.0, 1.0));
    // rust: assert_eq!(
    // rust: (bounded.repeat_delay, bounded.repeat_interval),
    // rust: (0.35, 0.09)
    // rust: );
    // rust: fs::remove_dir_all(dir).unwrap();
}

ownership_requires_new_activity_and_ignores_drift :: proc() {
}
    // rust: let settings = PadSettings::default();
    // rust: let mut p1 = Activity::default();
    // rust: let mut p2 = Activity::default();
    // rust: let mut state = PadState {
    // rust: left: [0.04, 0.03],
    // rust: ..PadState::default()
}
    // rust: assert!(!p1.observe(&state, &settings));
    // rust: state.set(Button::South, true);
    // rust: assert!(p1.observe(&state, &settings));
    // rust: assert!(
    // rust: !p1.observe(&state, &settings),
    // rust: "held pad cannot reclaim mouse ownership"
    // rust: );
    // rust: assert!(
    // rust: p2.observe(&state, &settings),
    // rust: "another player's tracker is independent"
    // rust: );
    // rust: state.set(Button::South, false);
    // rust: assert!(!p1.observe(&state, &settings));
    // rust: state.left = [0.5, 0.0];
    // rust: assert!(p1.observe(&state, &settings));
    // rust: state.left = [0.52, 0.0];
    // rust: assert!(!p1.observe(&state, &settings));
    // rust: for x in [0.54, 0.56] {
    // rust: state.left = [x, 0.0];
    // rust: assert!(!p1.observe(&state, &settings));
}
    // rust: state.left = [0.6, 0.0];
    // rust: assert!(
    // rust: p1.observe(&state, &settings),
    // rust: "slow intentional movement accumulates"
    // rust: );
    // rust: state.left = [0.0; 2];
    // rust: state.triggers[0] = 0.5;
    // rust: assert!(p1.observe(&state, &settings));
    // rust: state.triggers[0] = 0.35;
    // rust: assert!(!p1.observe(&state, &settings));
    // rust: state.triggers[0] = 0.45;
    // rust: assert!(
    // rust: !p1.observe(&state, &settings),
    // rust: "trigger threshold noise is not new activity"
    // rust: );
}

cancelled_holds_stay_released_until_neutral_then_press_again :: proc() {
}
    // rust: let mut edges = Edges::default();
    // rust: let mut state = PadState::default();
    // rust: state.set(Button::South, true);
    // rust: state.triggers[1] = 0.8;
    // rust: assert_eq!(
    // rust: edges.update(&state, 0.4),
    // rust: vec![(Button::South, true), (Button::RightTrigger, true)]
    // rust: );
    // rust: assert_eq!(
    // rust: edges.cancel(),
    // rust: vec![(Button::South, false), (Button::RightTrigger, false)]
    // rust: );
    // rust: assert!(edges.update(&state, 0.4).is_empty());
    // rust: state.triggers[1] = 0.35;
    // rust: assert!(edges.update(&state, 0.4).is_empty());
    // rust: assert!(edges.update(&PadState::default(), 0.4).is_empty());
    // rust: assert_eq!(edges.update(&state, 0.4), vec![(Button::South, true)]);
    // rust: state.triggers[1] = 0.7;
    // rust: assert_eq!(
    // rust: edges.update(&state, 0.4),
    // rust: vec![(Button::RightTrigger, true)]
    // rust: );
}

every_action_has_its_default :: proc() {
}
    // rust: let s = PadSettings::default();
    // rust: assert_eq!(s.actions_of(Button::South), ["key.jump"]);
    // rust: assert_eq!(s.actions_of(Button::RightTrigger), ["key.attack"]);
    // rust: assert_eq!(s.actions_of(Button::LeftTrigger), ["key.use"]);
    // rust: assert_eq!(s.actions_of(Button::North), ["key.inventory"]);
    // rust: assert_eq!(s.actions_of(Button::RightBumper), [HOTBAR_NEXT]);
    // rust: assert!(s.actions_of(Button::Start).is_empty());
        // Every default action names a key mapping or a pad action.
    // rust: for (action, _) in ACTIONS {
    // rust: assert!(
    // rust: action.starts_with("pad.")
    // rust: || crate::keybinds::all_mappings().any(|m| m.0 == *action),
    // rust: "{action}"
    // rust: );
}
}

a_file_from_before_these_defaults_keeps_its_buttons :: proc() {
}
        // Saved settings that never bound D-pad down: it stays on the advancements.
    // rust: let s = PadSettings::parse("vibration:false\nbind_key.chat:up\n");
    // rust: assert_eq!(s.binding("key.advancements"), Some(Button::DPadDown));
    // rust: assert_eq!(s.binding("key.chat"), Some(Button::DPadUp));
    // rust: assert_eq!(s.binding("key.drop"), Some(Button::East));
    // rust: assert_eq!(s.binding("key.togglePerspective"), Some(Button::DPadUp));
    // rust: assert_eq!(s.binding("key.playerlist"), Some(Button::Select));
    // rust: assert!(!s.conflicts("key.advancements"));
        // Advancements moved by hand stays moved, and the file stays this way from then on.
    // rust: let s = PadSettings::parse("bind_key.advancements:left\nbind_key.drop:down\n");
    // rust: assert_eq!(s.binding("key.advancements"), Some(Button::DPadLeft));
    // rust: assert_eq!(s.binding("key.drop"), Some(Button::DPadDown));
    // rust: assert_eq!(PadSettings::parse(&s.serialize()), s);
}

a_new_player_drops_on_d_pad_down_and_chats_on_d_pad_up :: proc() {
}
    // rust: for s in [PadSettings::default(), PadSettings::parse("")] {
    // rust: assert_eq!(s.binding("key.drop"), Some(Button::DPadDown));
    // rust: assert_eq!(s.binding("key.chat"), Some(Button::DPadUp));
    // rust: assert_eq!(s.binding("key.togglePerspective"), Some(Button::Select));
    // rust: assert_eq!(s.binding("key.playerlist"), None);
    // rust: assert_eq!(s.binding("key.advancements"), None);
}
    // rust: let s = PadSettings::parse(&PadSettings::default().serialize());
    // rust: assert_eq!(s, PadSettings::default());
}

settings_round_trip_and_store_only_changes :: proc() {
}
    // rust: let mut s = PadSettings::default();
    // rust: assert!(!s.serialize().contains("bind_"));
    // rust: s.bind("key.jump", Some(Button::East));
    // rust: s.bind("key.drop", None);
    // rust: s.bind("key.sneak", Some(Button::RightStick));
    // rust: s.invert_y = true;
    // rust: s.look_sensitivity = 0.75;
    // rust: s.glyphs = GlyphStyle::PlayStation;
    // rust: s.nintendo_letters = !s.nintendo_letters;
    // rust: let text = s.serialize();
    // rust: assert!(text.contains(&format!("nintendoLetters:{}\n", s.nintendo_letters)));
    // rust: assert!(text.contains("bind_key.jump:east\n"));
    // rust: assert!(text.contains("bind_key.drop:none\n"));
    // rust: assert!(!text.contains("key.sneak"));
    // rust: let back = PadSettings::parse(&text);
    // rust: assert_eq!(back, s);
    // rust: assert_eq!(back.binding("key.drop"), None);
    // rust: assert_eq!(back.actions_of(Button::East), ["key.jump"]);
        // Garbage keeps the defaults.
    // rust: let odd = PadSettings::parse(
    // rust: "lookSensitivity:NaN\nbind_key.nope:south\nbind_key.jump:x9\nbindLayout:1\n",
    // rust: );
    // rust: assert_eq!(odd, PadSettings::default());
}

ultimate2_right_stick_on_z_without_sdl :: proc() {
}
    // rust: let (left, right) = stick_axes(
    // rust: [0.2, 0.3],
    // rust: [0.7, -0.9],
    // rust: -0.5,
    // rust: Some(BITDO_ULTIMATE2_VID_PID.0),
    // rust: Some(BITDO_ULTIMATE2_VID_PID.1),
    // rust: false,
    // rust: );
    // rust: assert_eq!(left, [0.2, 0.3]);
    // rust: assert_eq!(right, [-0.5, 0.7], "X from LeftZ, Y from RightStickX");
    // rust: let kept = stick_axes(
    // rust: [0.2, 0.3],
    // rust: [0.7, -0.9],
    // rust: -0.5,
    // rust: Some(BITDO_ULTIMATE2_VID_PID.0),
    // rust: Some(BITDO_ULTIMATE2_VID_PID.1),
    // rust: true,
    // rust: );
    // rust: assert_eq!(kept, ([0.2, 0.3], [0.7, -0.9]), "SDL row already remapped");
    // rust: let other = stick_axes(
    // rust: [0.0, 0.0],
    // rust: [1.0, 0.0],
    // rust: 0.5,
    // rust: Some(0x045e),
    // rust: Some(0x028e),
    // rust: false,
    // rust: );
    // rust: assert_eq!(other, ([0.0, 0.0], [1.0, 0.0]));
}

a_nintendo_pad_by_its_letters_confirms_with_a :: proc() {
}
        // The pad's A sits on the right (East): going by letters it plays South, confirm and jump.
    // rust: let mut pad = PadState::default();
    // rust: pad.set(Button::East, true);
    // rust: pad.set(Button::LeftBumper, true);
    // rust: pad.left = [0.5, -0.25];
    // rust: let parts = pad.by_letter();
    // rust: assert!(parts.held(Button::South));
    // rust: assert!(!parts.held(Button::East));
        // Other buttons and the sticks stay; reading by letters again gives the pad back.
    // rust: assert!(parts.held(Button::LeftBumper));
    // rust: assert_eq!(parts.left, [0.5, -0.25]);
    // rust: assert_eq!(parts.by_letter(), pad);
        // A part's glyph is the letter of the button playing it.
    // rust: assert_eq!(Button::South.by_letter().label(GlyphStyle::Nintendo), "A");
    // rust: assert_eq!(Button::East.by_letter().label(GlyphStyle::Nintendo), "B");
    // rust: assert_eq!(Button::West.by_letter().label(GlyphStyle::Nintendo), "X");
    // rust: assert_eq!(Button::North.by_letter().label(GlyphStyle::Nintendo), "Y");
}

a_stick_holds_the_keys_of_its_nearest_heading :: proc() {
}
        // Forward, backward, left, right, by the heading counted from forward toward left.
    // rust: let headings = [
    // rust: [true, false, false, false],
    // rust: [true, false, true, false],
    // rust: [false, false, true, false],
    // rust: [false, true, true, false],
    // rust: [false, true, false, false],
    // rust: [false, true, false, true],
    // rust: [false, false, false, true],
    // rust: [true, false, false, true],
    // rust: ];
    // rust: for tenth in 0..3600 {
    // rust: let degrees = tenth as f32 / 10.0;
    // rust: if degrees % 45.0 == 22.5 {
    // rust: continue;
}
    // rust: for tilt in [0.31, 0.5, 1.0] {
    // rust: let (s, c) = degrees.to_radians().sin_cos();
    // rust: let keys = eight_direction_keys([tilt * s, tilt * c]);
    // rust: let sector = ((degrees / 45.0).round() as usize) % 8;
    // rust: assert_eq!(keys, headings[sector], "{degrees} at {tilt}");
    // rust: let [left, forward] =
    // rust: crate::input::keyboard_direction(keys[0], keys[1], keys[2], keys[3]);
    // rust: let off = (left.atan2(forward).to_degrees() - degrees).rem_euclid(360.0);
    // rust: assert!(off.min(360.0 - off) <= 22.5 + 1e-3, "{degrees}: {off}");
}
}
}

a_sector_edge_goes_to_the_straight_heading :: proc() {
}
    // rust: assert_eq!(
    // rust: eight_direction_keys([0.414_213_57, 1.0]),
    // rust: [true, false, false, false]
    // rust: );
    // rust: assert_eq!(
    // rust: eight_direction_keys([0.4143, 1.0]),
    // rust: [true, false, true, false]
    // rust: );
    // rust: assert_eq!(
    // rust: eight_direction_keys([1.0, 0.414_213_57]),
    // rust: [false, false, true, false]
    // rust: );
}

a_small_tilt_holds_no_key :: proc() {
}
    // rust: assert_eq!(eight_direction_keys([0.0, 0.0]), [false; 4]);
    // rust: assert_eq!(eight_direction_keys([0.2, 0.2]), [false; 4]);
    // rust: assert_eq!(
    // rust: eight_direction_keys([0.0, 0.31]),
    // rust: [true, false, false, false]
    // rust: );
}

radial_deadzone_rescales :: proc() {
}
    // rust: assert_eq!(radial([0.1, 0.05], 0.15), [0.0, 0.0]);
    // rust: let full = radial([1.0, 0.0], 0.15);
    // rust: assert!((full[0] - 1.0).abs() < 1e-6);
    // rust: let half = radial([0.0, 0.575], 0.15);
    // rust: assert!((half[1] - 0.5).abs() < 1e-6);
        // A worn stick reporting more than 1 still caps at 1.
    // rust: let over = radial([1.0, 1.0], 0.15);
    // rust: assert!((length(over) - 1.0).abs() < 1e-6);
    // rust: assert_eq!(move_vector([0.0, 0.0], 0.15), None);
    // rust: let m = move_vector([1.0, 0.0], 0.15).unwrap();
    // rust: assert!(m[0] < -0.99 && m[1] == 0.0, "right is negative left");
}

look_turns_right_and_up :: proc() {
}
    // rust: let s = PadSettings::default();
    // rust: let (yaw, pitch) = look_delta([1.0, 0.0], &s, 1.0, false);
    // rust: assert!((yaw - YAW_SPEED).abs() < 1e-3 && pitch == 0.0);
    // rust: let (_, pitch) = look_delta([0.0, 1.0], &s, 0.5, false);
    // rust: assert!((pitch + PITCH_SPEED * 0.5).abs() < 1e-3, "up looks up");
    // rust: let inverted = PadSettings {
    // rust: invert_y: true,
    // rust: ..PadSettings::default()
}
    // rust: assert!(look_delta([0.0, 1.0], &inverted, 1.0, false).1 > 0.0);
    // rust: let (small, _) = look_delta([0.5, 0.0], &s, 1.0, false);
    // rust: assert!(
    // rust: small < YAW_SPEED * 0.5,
    // rust: "the curve is gentler near the centre"
    // rust: );
    // rust: assert_eq!(look_delta([0.05, 0.05], &s, 1.0, false), (0.0, 0.0));
    // rust: assert!(look_delta([1.0, 0.0], &s, 1.0, true).0 < YAW_SPEED * 0.5);
}

edges_with_trigger_hysteresis :: proc() {
}
    // rust: let mut edges = Edges::default();
    // rust: let mut state = PadState::default();
    // rust: state.set(Button::South, true);
    // rust: assert_eq!(edges.update(&state, 0.4), [(Button::South, true)]);
    // rust: assert!(edges.update(&state, 0.4).is_empty());
    // rust: state.triggers[1] = 0.45;
    // rust: assert_eq!(edges.update(&state, 0.4), [(Button::RightTrigger, true)]);
    // rust: state.triggers[1] = 0.35;
    // rust: assert!(
    // rust: edges.update(&state, 0.4).is_empty(),
    // rust: "inside the hysteresis"
    // rust: );
    // rust: state.triggers[1] = 0.2;
    // rust: state.set(Button::South, false);
    // rust: assert_eq!(
    // rust: edges.update(&state, 0.4),
    // rust: [(Button::South, false), (Button::RightTrigger, false)]
    // rust: );
    // rust: state.set(Button::DPadUp, true);
    // rust: edges.update(&state, 0.4);
    // rust: assert_eq!(edges.release_all(), [(Button::DPadUp, false)]);
}

merge_and_activity :: proc() {
}
    // rust: let s = PadSettings::default();
    // rust: let mut a = PadState::default();
    // rust: assert!(!a.active(&s));
    // rust: a.left = [0.1, 0.0];
    // rust: assert!(!a.active(&s), "drift inside the deadzone");
    // rust: let mut b = PadState::default();
    // rust: b.set(Button::North, true);
    // rust: b.left = [0.95, 0.0];
    // rust: let m = a.merge(&b);
    // rust: assert!(m.held(Button::North) && m.left[0] == 1.0 && m.active(&s));
}

focus_moves_between_slots :: proc() {
}
        // A 3x2 grid of slots 18 apart and a button below it.
    // rust: let mut targets: Vec<(f32, f32)> = (0..6)
    // rust: .map(|i| (8.0 + (i % 3) as f32 * 18.0, 8.0 + (i / 3) as f32 * 18.0))
    // rust: .collect();
    // rust: targets.push((26.0, 80.0));
    // rust: let from = targets[0];
    // rust: assert_eq!(focus_step(from, Button::DPadRight, &targets), Some(1));
    // rust: assert_eq!(focus_step(from, Button::DPadDown, &targets), Some(3));
    // rust: assert_eq!(focus_step(from, Button::DPadUp, &targets), None);
    // rust: assert_eq!(focus_step(from, Button::DPadLeft, &targets), None);
    // rust: assert_eq!(focus_step(targets[4], Button::DPadDown, &targets), Some(6));
        // The far end of a row skips nothing in between.
    // rust: assert_eq!(focus_step(targets[2], Button::DPadLeft, &targets), Some(1));
    // rust: assert_eq!(nearest((12.0, 10.0), &targets, 9.0), Some(0));
    // rust: assert_eq!(nearest((100.0, 100.0), &targets, 9.0), None);
    // rust: let (x, y) = cursor_delta([0.0, 1.0], 0.15, 0.1);
    // rust: assert!(x == 0.0 && y < -30.0, "up moves up the screen");
    // rust: assert_eq!(cursor_delta([0.1, 0.0], 0.15, 0.1), (0.0, 0.0));
}

focus_follows_vanilla_arrow_navigation :: proc() {
}
        // An options screen: two columns of 150-wide buttons 20 high with
        // 4 pixels between rows, a full-width Done button under them.
    // rust: let mut rects: Vec<Rect> = (0..6)
    // rust: .map(|i| {
    // rust: let (col, row) = (i % 2, i / 2);
    // rust: [
    // rust: 5.0 + col as f32 * 160.0,
    // rust: 40.0 + row as f32 * 24.0,
    // rust: 150.0,
    // rust: 20.0,
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: rects.push([85.0, 120.0, 150.0, 20.0]);
    // rust: assert_eq!(
    // rust: focus_step_rect(rects[0], Button::DPadRight, &rects),
    // rust: Some(1)
    // rust: );
    // rust: assert_eq!(focus_step_rect(rects[1], Button::DPadRight, &rects), None);
    // rust: assert_eq!(focus_step_rect(rects[0], Button::DPadDown, &rects), Some(2));
    // rust: assert_eq!(focus_step_rect(rects[3], Button::DPadUp, &rects), Some(1));
    // rust: assert_eq!(focus_step_rect(rects[0], Button::DPadUp, &rects), None);
        // Done overlaps both columns: down from either bottom button lands
        // on it, up from it picks the leftmost overlapping one.
    // rust: assert_eq!(focus_step_rect(rects[5], Button::DPadDown, &rects), Some(6));
    // rust: assert_eq!(focus_step_rect(rects[4], Button::DPadDown, &rects), Some(6));
    // rust: assert_eq!(focus_step_rect(rects[6], Button::DPadUp, &rects), Some(4));
        // Nothing overlaps on the other axis: the vague pass takes the
        // nearest facing edge (a crafting result right of the grid).
    // rust: let grid: Vec<Rect> = vec![
    // rust: [10.0, 10.0, 16.0, 16.0],
    // rust: [28.0, 10.0, 16.0, 16.0],
    // rust: [10.0, 28.0, 16.0, 16.0],
    // rust: [28.0, 28.0, 16.0, 16.0],
    // rust: [80.0, 50.0, 16.0, 16.0],
    // rust: ];
    // rust: assert_eq!(focus_step_rect(grid[1], Button::DPadRight, &grid), Some(4));
    // rust: assert_eq!(focus_step_rect(grid[4], Button::DPadLeft, &grid), Some(3));
    // rust: assert_eq!(focus_step_rect(grid[0], Button::DPadDown, &grid), Some(2));
        // The focused rectangle itself is never a step, even listed twice.
    // rust: let dup = vec![grid[0], grid[0]];
    // rust: assert_eq!(focus_step_rect(grid[0], Button::DPadRight, &dup), None);
    // rust: assert_eq!(focus_step_rect(grid[0], Button::South, &grid), None);
}

follow_scroll_keeps_rows_and_fixed_widgets :: proc() {
}
        // Rows 36 tall scrolled down 18: a fifth row comes into view, so +18
        // carries as many rows as the real -18. Back, below, stays.
    // rust: let back = [296.0, 212.0, 71.0, 20.0];
    // rust: let rows = |ys: &[f32]| -> Vec<(Rect, bool)> {
    // rust: let rows = ys.iter().map(|y| ([78.0, *y, 270.0, 36.0], true));
    // rust: rows.chain([(back, false)]).collect()
}
    // rust: let rects = |t: &[(Rect, bool)]| -> Vec<Rect> { t.iter().map(|t| t.0).collect() };
    // rust: let before = rects(&rows(&[33.0, 69.0, 105.0, 141.0]));
    // rust: let after = rows(&[15.0, 51.0, 87.0, 123.0, 159.0]);
    // rust: assert_eq!(follow_scroll(before[1], true, &before, &after), Some(1));
    // rust: assert_eq!(follow_scroll(back, true, &before, &after), Some(5));
        // And back up.
    // rust: let up = rows(&[33.0, 69.0, 105.0, 141.0]);
    // rust: let was = rects(&after);
    // rust: assert_eq!(follow_scroll(was[2], false, &was, &up), Some(2));
        // Nothing moved, as on a screen with no list.
    // rust: let still = rows(&[33.0, 69.0, 105.0, 141.0]);
    // rust: assert_eq!(follow_scroll(before[1], true, &before, &still), None);
        // A sidebar's tabs spaced exactly like the list's shift stay put.
    // rust: let tab = |y: f32| [8.0, y, 112.0, 16.0];
    // rust: let with_tabs = |t: &[(Rect, bool)]| -> Vec<(Rect, bool)> {
    // rust: t.iter()
    // rust: .copied()
    // rust: .chain([(tab(100.0), true), (tab(118.0), true)])
    // rust: .collect()
}
    // rust: let was = rects(&with_tabs(&rows(&[33.0, 69.0, 105.0, 141.0])));
    // rust: let now = with_tabs(&after);
    // rust: assert_eq!(follow_scroll(tab(118.0), true, &was, &now), Some(7));
}

follow_scroll_lands_on_the_nearest_row_when_its_row_leaves :: proc() {
}
        // The row at 33 left the top; the next one is at 51. Nothing fixed.
    // rust: let row = |y: f32| [78.0, y, 270.0, 36.0];
    // rust: let before = [row(33.0), row(69.0), row(105.0)];
    // rust: let after = [(row(51.0), true), (row(87.0), true)];
    // rust: assert_eq!(follow_scroll(row(33.0), true, &before, &after), Some(0));
        // The last row left the bottom: the list's new last row, not a fixed
        // widget of its kind (at 200) nearer where the row went.
    // rust: let fixed = [78.0, 200.0, 270.0, 36.0];
    // rust: let before = [row(15.0), row(51.0), row(87.0), row(159.0), fixed];
    // rust: let after = [
    // rust: (row(33.0), true),
    // rust: (row(69.0), true),
    // rust: (row(105.0), true),
    // rust: (fixed, true),
    // rust: ];
    // rust: assert_eq!(follow_scroll(row(159.0), false, &before, &after), Some(2));
        // Nothing of its kind left.
    // rust: let other = after.map(|t| (t.0, false));
    // rust: assert_eq!(follow_scroll(row(159.0), false, &before, &other), None);
}

refind_tabs_sliders_and_stick_steps :: proc() {
}
    // rust: let rects: Vec<Rect> = vec![[0.0, 0.0, 10.0, 10.0], [0.0, 20.0, 10.0, 10.0]];
    // rust: assert_eq!(refind([0.0, 20.0, 10.0, 10.0], &rects, 8.0), Some(1));
        // A list scrolled by 4 pixels keeps the row.
    // rust: assert_eq!(refind([0.0, 24.0, 10.0, 10.0], &rects, 8.0), Some(1));
    // rust: assert_eq!(refind([90.0, 90.0, 10.0, 10.0], &rects, 8.0), None);
        // Rows 24 apart scrolled up by 24 under a fixed button.
    // rust: let before: Vec<Rect> = (0..5)
    // rust: .map(|i| [10.0, 40.0 + 24.0 * i as f32, 100.0, 20.0])
    // rust: .chain([[10.0, 200.0, 50.0, 20.0]])
    // rust: .collect();
    // rust: let after: Vec<Rect> = (0..5)
    // rust: .map(|i| [10.0, 16.0 + 24.0 * i as f32, 100.0, 20.0])
    // rust: .chain([[10.0, 200.0, 50.0, 20.0]])
    // rust: .collect();
    // rust: assert_eq!(scroll_shift(&before, &after, true), Some(-24.0));
        // Rows this far apart line up the other way too; the direction is what tells them apart.
    // rust: assert_eq!(scroll_shift(&before, &after, false), Some(24.0));
    // rust: assert_eq!(scroll_shift(&before, &before, true), None);
    // rust: let tabs = [
    // rust: ([60.0, 0.0, 26.0, 32.0], false),
    // rust: ([0.0, 0.0, 26.0, 32.0], true),
    // rust: ([30.0, 0.0, 26.0, 32.0], false),
    // rust: ];
    // rust: assert_eq!(tab_step(&tabs, true), Some(2));
    // rust: assert_eq!(tab_step(&tabs, false), Some(0), "wraps to the last");
    // rust: assert_eq!(tab_step(&tabs[..1], true), None);
    // rust: assert_eq!(slider_x([14.0, 142.0], 0.0), 14.0);
    // rust: assert_eq!(slider_x([14.0, 142.0], 1.0), 156.0);
    // rust: assert!(slider_step(0) == 1.0 && slider_step(99) == 8.0);
    // rust: assert_eq!(stick_direction([0.9, 0.2], 0.5), Some(Button::DPadRight));
    // rust: assert_eq!(stick_direction([-0.2, -0.8], 0.5), Some(Button::DPadDown));
    // rust: assert_eq!(stick_direction([0.3, 0.3], 0.5), None);
    // rust: let s = PadSettings {
    // rust: keyboard: TextKeyboard::Horizon,
    // rust: ..PadSettings::default()
}
    // rust: assert_eq!(
    // rust: PadSettings::parse(&s.serialize()).keyboard,
    // rust: TextKeyboard::Horizon
    // rust: );
    // rust: assert!(steam_keyboard(TextKeyboard::Steam) && !steam_keyboard(TextKeyboard::Horizon));
}

a_list_step_scrolls_rather_than_leave_a_list_that_can :: proc() {
}
    // rust: let rows = |n: usize| -> Vec<Rect> {
    // rust: (0..n)
    // rust: .map(|i| [100.0, 40.0 + i as f32 * 36.0, 270.0, 36.0])
    // rust: .collect()
}
    // rust: let back: Rect = [150.0, 220.0, 150.0, 20.0];
    // rust: let search: Rect = [150.0, 10.0, 150.0, 20.0];
    // rust: let mut targets = rows(4);
    // rust: targets.extend([back, search]);
    // rust: let area = |up, down| ScrollArea {
    // rust: rect: [0.0, 40.0, 380.0, 144.0],
    // rust: amount: 0.0,
    // rust: up,
    // rust: down,
}
    // rust: let (down, up) = (Button::DPadDown, Button::DPadUp);
    // rust: let step = |from, button, area: &[ScrollArea]| list_step(from, button, &targets, area);
        // A row below in view comes first.
    // rust: assert_eq!(step(targets[1], down, &[area(true, true)]), Some(2));
        // The last row in view: more below scrolls; none leaves.
    // rust: assert_eq!(step(targets[3], down, &[area(true, true)]), None);
    // rust: assert_eq!(step(targets[3], down, &[area(true, false)]), Some(4));
        // The first row in view, the same upwards.
    // rust: assert_eq!(step(targets[0], up, &[area(true, false)]), None);
    // rust: assert_eq!(step(targets[0], up, &[area(false, true)]), Some(5));
        // From outside the list it enters it, and no list means a plain step.
    // rust: assert_eq!(step(back, up, &[area(true, true)]), Some(3));
    // rust: assert_eq!(step(targets[3], down, &[]), Some(4));
}

a_list_step_shows_its_row_whole_and_starts_from_one_nearly_gone :: proc() {
}
    // rust: let area = |up, down| ScrollArea {
    // rust: rect: [0.0, 40.0, 380.0, 100.0],
    // rust: amount: 50.0,
    // rust: up,
    // rust: down,
}
    // rust: let (down, up) = (Button::DPadDown, Button::DPadUp);
        // The next row is cut by the view's bottom: it scrolls first, unless that's the end.
    // rust: let targets: Vec<Rect> = vec![[100.0, 100.0, 270.0, 25.0], [100.0, 125.0, 270.0, 25.0]];
    // rust: assert_eq!(
    // rust: list_step(targets[0], down, &targets, &[area(true, true)]),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: list_step(targets[0], down, &targets, &[area(true, false)]),
    // rust: Some(1)
    // rust: );
        // The same at its top.
    // rust: let targets: Vec<Rect> = vec![[100.0, 30.0, 270.0, 25.0], [100.0, 55.0, 270.0, 25.0]];
    // rust: assert_eq!(
    // rust: list_step(targets[1], up, &targets, &[area(true, true)]),
    // rust: None
    // rust: );
        // A focused row with its last pixels in view is still in the list: going up scrolls,
        // even with something above the list to go to.
    // rust: let row: Rect = [100.0, 18.0, 270.0, 25.0];
    // rust: let field: Rect = [150.0, 0.0, 150.0, 15.0];
    // rust: assert!(area(true, true).holds(&row));
    // rust: assert_eq!(list_step(row, up, &[row, field], &[area(true, true)]), None);
        // Above the view altogether, it isn't.
    // rust: assert!(!area(true, true).holds(&[100.0, 10.0, 270.0, 25.0]));
}

a_stick_holds_its_direction_until_it_lets_go_or_turns :: proc() {
}
    // rust: let step = 0.55;
    // rust: let (up, right) = (Some(Button::DPadUp), Some(Button::DPadRight));
        // Only a push past the threshold starts a step.
    // rust: assert_eq!(stick_direction_held([0.0, 0.5], step, None), None);
    // rust: assert_eq!(stick_direction_held([0.0, 0.6], step, None), up);
        // Wobbling on the threshold keeps it; falling back past the release lets go.
    // rust: assert_eq!(stick_direction_held([0.0, 0.5], step, up), up);
    // rust: assert_eq!(stick_direction_held([0.0, 0.3], step, up), None);
        // A diagonal doesn't flip it, but a clear turn does.
    // rust: assert_eq!(stick_direction_held([0.6, 0.55], step, up), up);
    // rust: assert_eq!(stick_direction_held([0.55, 0.6], step, right), right);
    // rust: assert_eq!(stick_direction_held([0.9, 0.3], step, up), right);
        // Straight across to the other side.
    // rust: assert_eq!(
    // rust: stick_direction_held([0.0, -0.9], step, up),
    // rust: Some(Button::DPadDown)
    // rust: );
        // Past the release on the far side, but not far enough for a step.
    // rust: assert_eq!(stick_direction_held([0.0, -0.45], step, up), None);
}

a_repeat_stops_where_the_slots_end :: proc() {
}
    // rust: let at = (100.0, 100.0);
    // rust: assert!(!repeat_crosses_slots(at, (118.0, 100.0), true));
        // The hotbar, over its small gap, is the same run of slots.
    // rust: assert!(!repeat_crosses_slots(at, (100.0, 122.0), true));
        // Another block of slots, or a button.
    // rust: assert!(repeat_crosses_slots(at, (100.0, 132.0), true));
    // rust: assert!(repeat_crosses_slots(at, (118.0, 100.0), false));
}

a_resize_keeps_the_same_widget :: proc() {
}
    // rust: let before: Vec<Rect> = vec![[10.0, 10.0, 20.0, 20.0], [100.0, 10.0, 20.0, 20.0]];
    // rust: let after: Vec<Rect> = vec![[300.0, 90.0, 20.0, 20.0], [400.0, 90.0, 20.0, 20.0]];
    // rust: let (old, new) = ((200.0, 100.0), (800.0, 400.0));
        // The same count: the same place in the draw order, however far it moved.
    // rust: assert_eq!(
    // rust: refind_resized(before[0], &before, &after, old, new),
    // rust: Some(0)
    // rust: );
        // A list showing more rows: the nearest to where it would be.
    // rust: let more: Vec<Rect> = vec![
    // rust: [30.0, 30.0, 20.0, 20.0],
    // rust: [395.0, 35.0, 20.0, 20.0],
    // rust: [700.0, 300.0, 20.0, 20.0],
    // rust: ];
    // rust: assert_eq!(refind_resized(before[1], &before, &more, old, new), Some(1));
    // rust: assert_eq!(refind_resized(before[0], &before, &[], old, new), None);
}

labels_and_conflicts :: proc() {
}
    // rust: assert_eq!(Button::South.label(GlyphStyle::Xbox), "A");
    // rust: assert_eq!(Button::South.label(GlyphStyle::PlayStation), "×");
    // rust: assert_eq!(Button::South.label(GlyphStyle::Nintendo), "B");
    // rust: assert_eq!(Button::RightTrigger.label(GlyphStyle::PlayStation), "R2");
    // rust: assert_eq!(Button::DPadLeft.label(GlyphStyle::Xbox), "←");
    // rust: assert_eq!(
    // rust: GlyphStyle::Auto.resolve(GlyphStyle::PlayStation),
    // rust: GlyphStyle::PlayStation
    // rust: );
    // rust: assert_eq!(
    // rust: GlyphStyle::Xbox.resolve(GlyphStyle::PlayStation),
    // rust: GlyphStyle::Xbox
    // rust: );
    // rust: assert_eq!(GlyphStyle::Auto.resolve(GlyphStyle::Auto), GlyphStyle::Xbox);
    // rust: let mut s = PadSettings::default();
    // rust: assert!(!s.conflicts("key.jump"));
    // rust: s.bind("key.drop", Some(Button::South));
    // rust: assert!(s.conflicts("key.jump") && s.conflicts("key.drop"));
    // rust: assert!(!s.is_default("key.drop") && s.is_default("key.jump"));
    // rust: assert_eq!(action_caption(HOTBAR_NEXT), "Hotbar: Next Slot");
    // rust: assert_eq!(action_caption("key.jump"), "key.jump");
}

health_watch_only_counts_damage_in_one_life :: proc() {
}
    // rust: let mut w = HealthWatch::default();
    // rust: assert_eq!(w.observe(Some(20.0)), None);
    // rust: assert_eq!(w.observe(Some(15.0)), Some(5.0));
    // rust: assert_eq!(w.observe(Some(18.0)), None, "healing");
        // A new player entity (world, respawn, server, dimension).
    // rust: w.forget();
    // rust: assert_eq!(w.observe(Some(6.0)), None);
        // No player in between (title, loading) forgets too.
    // rust: assert_eq!(w.observe(None), None);
    // rust: assert_eq!(w.observe(Some(2.0)), None);
    // rust: assert_eq!(w.observe(Some(1.0)), Some(1.0));
}

triggers_feel_their_action :: proc() {
}
//         use horizon_dualsense::{TRIGGER_OFF, trigger};
    // rust: let mut s = PadSettings::default();
        // Use is LT, attack RT by default.
    // rust: let [left, right] = s.trigger_effects(TriggerFeel::Draw(1.0), TriggerFeel::Texture(1.5));
    // rust: assert_eq!(left, trigger::feedback(2, 6));
    // rust: assert_eq!(right, trigger::vibration(1, 3, 30));
    // rust: assert_eq!(
    // rust: s.trigger_effects(TriggerFeel::Draw(0.0), TriggerFeel::Free),
    // rust: [trigger::feedback(2, 1), TRIGGER_OFF]
    // rust: );
        // The catch gives way in the zone where the default threshold (0.4) presses: weapon
        // 0x25, zones 2 and 4, strength 8 (stored 7) or 5 (stored 4).
    // rust: let catch = |strength| [0x25, 0x14, 0x00, strength, 0, 0, 0, 0, 0, 0, 0];
    // rust: assert_eq!(TriggerFeel::Click.effect(0.4), catch(7));
    // rust: assert_eq!(TriggerFeel::Boost.effect(0.4), catch(4));
        // A deeper threshold moves it: zones 5 and 7.
    // rust: assert_eq!(TriggerFeel::Click.effect(0.7)[1..3], [0xa0, 0x00]);
    // rust: assert_eq!(TriggerFeel::Click.effect(0.1), trigger::weapon(2, 3, 8));
    // rust: assert_eq!(TriggerFeel::Brace.effect(0.4), trigger::feedback(2, 3));
    // rust: assert_eq!(TriggerFeel::Locked.effect(0.4), trigger::feedback(1, 8));
        // Harder blocks buzz harder and slower; instant-break blocks don't.
    // rust: assert_eq!(
    // rust: TriggerFeel::Texture(0.5).effect(0.4),
    // rust: trigger::vibration(1, 2, 40)
    // rust: );
    // rust: assert_eq!(
    // rust: TriggerFeel::Texture(3.0).effect(0.4),
    // rust: trigger::vibration(1, 4, 20)
    // rust: );
    // rust: assert_eq!(
    // rust: TriggerFeel::Texture(50.0).effect(0.4),
    // rust: trigger::vibration(1, 5, 10)
    // rust: );
    // rust: assert_eq!(TriggerFeel::Texture(0.0).effect(0.4), TRIGGER_OFF);
    // rust: assert_eq!(TriggerFeel::Texture(-1.0).effect(0.4), TRIGGER_OFF);
    // rust: s.adaptive_triggers = false;
    // rust: assert_eq!(
    // rust: s.trigger_effects(TriggerFeel::Click, TriggerFeel::Boost),
    // rust: [TRIGGER_OFF; 2]
    // rust: );
    // rust: assert!(!PadSettings::parse(&s.serialize()).adaptive_triggers);
}

lightbar_colours :: proc() {
}
    // rust: let full = Lightbar::Health.colour(1.0, "minecraft:overworld").unwrap();
    // rust: let empty = Lightbar::Health.colour(0.0, "minecraft:overworld").unwrap();
    // rust: assert!(full[1] > full[0], "green at full health: {full:?}");
    // rust: assert!(empty[0] > empty[1], "red when dying: {empty:?}");
    // rust: assert_eq!(Lightbar::Health.colour(0.5, ""), Some([123, 79, 6]));
    // rust: assert_ne!(
    // rust: Lightbar::Dimension.colour(1.0, "minecraft:the_nether"),
    // rust: Lightbar::Dimension.colour(1.0, "minecraft:overworld")
    // rust: );
    // rust: assert_eq!(Lightbar::Off.colour(1.0, ""), None);
    // rust: for l in Lightbar::ALL {
    // rust: assert_eq!(Lightbar::parse(l.name()), l);
}
}

bow_draw :: proc() {
}
    // rust: assert_eq!(bow_power(0), 0.0);
    // rust: assert!((bow_power(10) - 5.0 / 12.0).abs() < 1e-6);
    // rust: assert_eq!(bow_power(20), 1.0);
    // rust: assert_eq!(bow_power(40), 1.0);
}

rumble_pulses :: proc() {
}
    // rust: let small = Rumble::Hurt(1.0).pulse().unwrap();
    // rust: let big = Rumble::Hurt(10.0).pulse().unwrap();
    // rust: assert!(big.strong > small.strong && big.millis > small.millis);
    // rust: assert!(Rumble::Hurt(100.0).pulse().unwrap().strong <= 0.8);
    // rust: assert_eq!(Rumble::Hurt(0.0).pulse(), None);
    // rust: let near = Rumble::Explosion {
    // rust: distance: 2.0,
    // rust: radius: 4.0,
}
    // rust: .pulse()
    // rust: .unwrap();
    // rust: let far = Rumble::Explosion {
    // rust: distance: 12.0,
    // rust: radius: 4.0,
}
    // rust: .pulse()
    // rust: .unwrap();
    // rust: assert!(near.strong > far.strong);
    // rust: assert_eq!(
    // rust: Rumble::Explosion {
    // rust: distance: 20.0,
    // rust: radius: 4.0
}
    // rust: .pulse(),
    // rust: None
    // rust: );
    // rust: assert_eq!(Rumble::BlockBroken.pulse().unwrap().strong, 0.0);
        // Shapes open at the pulse's strength and fade; nothing for what isn't felt.
    // rust: for rumble in [
    // rust: Rumble::Hurt(4.0),
    // rust: Rumble::Explosion {
    // rust: distance: 2.0,
    // rust: radius: 4.0,
    // rust: },
    // rust: ] {
    // rust: let (pulse, shape) = (rumble.pulse().unwrap(), rumble.shape());
    // rust: assert_eq!(shape[0].strong, pulse.strong);
    // rust: assert!(shape.windows(2).all(|w| w[1].strong < w[0].strong));
}
    // rust: let hurt: u32 = Rumble::Hurt(4.0).shape().iter().map(|s| s.millis).sum();
    // rust: assert!(hurt.abs_diff(Rumble::Hurt(4.0).pulse().unwrap().millis) <= 1);
    // rust: assert_eq!(
    // rust: Rumble::Totem.shape().iter().map(|s| s.millis).sum::<u32>(),
    // rust: 500
    // rust: );
    // rust: assert_eq!(Rumble::BlockBroken.shape()[0].millis, 35);
    // rust: assert!(Rumble::Hurt(0.0).shape().is_empty());
}

glyphs_follow_the_vendor :: proc() {
}
    // rust: let of = |vendor, product| GlyphStyle::of_device(Some(vendor), Some(product));
        // Any product of the consoles' makers.
    // rust: assert_eq!(of(0x054c, 0x0ce6), GlyphStyle::PlayStation);
    // rust: assert_eq!(of(0x054c, 0x0001), GlyphStyle::PlayStation);
    // rust: assert_eq!(of(0x057e, 0x2009), GlyphStyle::Nintendo);
        // A pad made for a console by another maker, and that maker's others.
    // rust: assert_eq!(of(0x0f0d, 0x0066), GlyphStyle::PlayStation);
    // rust: assert_eq!(of(0x0f0d, 0x00c1), GlyphStyle::Nintendo);
    // rust: assert_eq!(of(0x0f0d, 0x0067), GlyphStyle::Xbox);
    // rust: assert_eq!(of(0x20d6, 0xa711), GlyphStyle::Nintendo);
        // Valve's virtual pad, Microsoft's, nothing known, nothing reported.
    // rust: assert_eq!(of(0x28de, 0x11ff), GlyphStyle::Xbox);
    // rust: assert_eq!(of(0x045e, 0x0b12), GlyphStyle::Xbox);
    // rust: assert_eq!(of(0x1234, 0x5678), GlyphStyle::Xbox);
    // rust: assert_eq!(GlyphStyle::of_device(None, None), GlyphStyle::Xbox);
        // A vendor alone is enough only for the consoles' makers.
    // rust: assert_eq!(
    // rust: GlyphStyle::of_device(Some(0x054c), None),
    // rust: GlyphStyle::PlayStation
    // rust: );
    // rust: assert_eq!(GlyphStyle::of_device(Some(0x0f0d), None), GlyphStyle::Xbox);
}
}
