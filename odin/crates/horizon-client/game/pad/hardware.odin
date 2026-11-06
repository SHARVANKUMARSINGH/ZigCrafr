//! Transpiled from Horizon Rust crate
package horizon_client_hardware

import "core:fmt"
import "core:mem"
import "core:math"

// The real controllers (the `controllers` feature): gilrs' pads, and the DualSense's own output
// over HID: its rumble, adaptive triggers, lights and HD haptics. A build without the feature (the
// server build) has the stub in pad.rs instead, and only `horizon-ctl pad`'s virtual pad.
// use super::{
    // rust: super::{Game, Screen},
    // rust: Connection, PadEvent, Pads,
}
// use horizon_client::controller_ui::Device;
// use horizon_client::gamepad::{self, Button, GlyphStyle, PadState, Rumble, TriggerFeel};
// use serde_json::{Value, json};
// use std::time::{Duration, Instant};

    // rust: mod face_buttons;
    // rust: mod triggers;

// The controllers gilrs sees and the DualSense's output.
    // rust: pub(super) struct Devices {
    // rust: gilrs: Option<gilrs::Gilrs>,
    // rust: started: bool,
    // The pads seen so far, so one already there when gilrs opens isn't news.
    // rust: known: Vec<gilrs::GamepadId>,
    // The pad last touched; only its input counts.
    // rust: active: Option<gilrs::GamepadId>,
    // Vibrations playing (an effect stops when dropped) and when they end.
    // rust: rumbles: Vec<(gilrs::ff::Effect, Instant)>,
    // The active pad is a DualSense.
    // rust: dualsense: bool,
    // Its own output over HID (rumble here; gilrs only reads it), started once this window
    // has the pad in hand; dropped, it releases the pad.
    // rust: output: Option<horizon_dualsense::Link>,
    // Its HD haptics, on USB: looked for once each time the output opens.
    // rust: haptics: Option<horizon_dualsense::haptics::Haptics>,
    // rust: haptics_tried: bool,
    // What it was last told to show.
    // rust: shown: Option<horizon_dualsense::device::State>,
    // While `PadRouter` has the reader and isn't lending it: what `pad status` lists.
    // rust: routed: Option<Vec<Value>>,
}

// `pad status`'s line for a controller. `uuid` is the id an SDL mapping row starts with, so a
// report says which row a pad needs; `mapping_source` says whether one was found.
    // rust: fn controller_status(
    // rust: id: gilrs::GamepadId,
    // rust: pad: &gilrs::Gamepad,
    // rust: active: Option<gilrs::GamepadId>,
    // rust: ) -> Value {
    // rust: let mapping_source = match pad.mapping_source() {
    // rust: gilrs::MappingSource::SdlMappings => "sdl",
    // rust: gilrs::MappingSource::Driver => "driver",
    // rust: gilrs::MappingSource::None => "none",
}
    // rust: let uuid: String = pad.uuid().iter().map(|b| format!("{b:02x}")).collect();
    // rust: json!({
    // rust: "name": pad.name(),
    // rust: "vendor": pad.vendor_id(),
    // rust: "product": pad.product_id(),
    // rust: "mapping_source": mapping_source,
    // rust: "uuid": uuid,
    // rust: "active": active == Some(id),
    // rust: })
}

    // rust: impl Devices {
    // The hardware part of `pad status`.
status :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let pads: Vec<Value> = match (&self.gilrs, &self.routed) {
    // rust: (Some(g), _) => g
    // rust: .gamepads()
    // rust: .map(|(id, p)| controller_status(id, &p, self.active))
    // rust: .collect(),
    // rust: (None, Some(routed)) => routed.clone(),
    // rust: (None, None) => Vec::new(),
}
    // rust: json!({
    // rust: "backend": self.gilrs.is_some() || self.routed.is_some(),
    // rust: "controllers": pads,
    // rust: "dualsense_output": self.output.as_ref().and_then(|o| o.open()).map(|t| format!("{t:?}")),
    // rust: "trigger_effects": self.shown.map(|s| s.triggers),
    // rust: })
}
}

gilrs_button :: proc(button: Button) -> g {
    // Ported from Horizon
    return {}
}
//     use gilrs::Button as G;
    // rust: match button {
    // rust: Button::South => G::South,
    // rust: Button::East => G::East,
    // rust: Button::West => G::West,
    // rust: Button::North => G::North,
    // rust: Button::LeftBumper => G::LeftTrigger,
    // rust: Button::RightBumper => G::RightTrigger,
    // rust: Button::LeftTrigger => G::LeftTrigger2,
    // rust: Button::RightTrigger => G::RightTrigger2,
    // rust: Button::Select => G::Select,
    // rust: Button::Start => G::Start,
    // rust: Button::LeftStick => G::LeftThumb,
    // rust: Button::RightStick => G::RightThumb,
    // rust: Button::DPadUp => G::DPadUp,
    // rust: Button::DPadDown => G::DPadDown,
    // rust: Button::DPadLeft => G::DPadLeft,
    // rust: Button::DPadRight => G::DPadRight,
}
}

is_dualsense :: proc(pad: ^gilrs::Gamepad) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!((pad.vendor_id(), pad.product_id()),
    // rust: (Some(vendor), Some(product)) if horizon_dualsense::is_dualsense(vendor, product))
}

// SDL rows gilrs' bundled DB is missing (or only ships for Windows). Newer
// than the crate's copy; `GilrsBuilder::add_mappings` prefers these. The
// Ultimate 2's Linux/BT rows put the right stick on a2/a3 — without them
// look never moves (#4343).
    // rust: const EXTRA_SDL_MAPPINGS: &str = concat!(
    // rust: "03000000c82d00001260000011010000,8BitDo Ultimate 2,a:b0,b:b1,back:b10,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b12,leftshoulder:b6,leftstick:b13,lefttrigger:a5,leftx:a0,lefty:a1,paddle1:b17,paddle2:b16,paddle3:b2,paddle4:b5,rightshoulder:b7,rightstick:b14,righttrigger:a4,rightx:a2,righty:a3,start:b11,x:b3,y:b4,platform:Linux,\n",
    // rust: "05000000c82d00001260000001000000,8BitDo Ultimate 2,a:b0,b:b1,back:b10,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b12,leftshoulder:b6,leftstick:b13,lefttrigger:a5,leftx:a0,lefty:a1,paddle1:b17,paddle2:b16,paddle3:b2,paddle4:b5,rightshoulder:b7,rightstick:b14,righttrigger:a4,rightx:a2,righty:a3,start:b11,x:b3,y:b4,platform:Linux,\n",
    // rust: "03000000c82d00000b31000014010000,8BitDo Ultimate 2,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux,\n",
    // rust: );

// The one way to open gilrs: each reader needs the extra rows.
gilrs_builder :: proc() -> g {
    // Ported from Horizon
    return {}
}
    // rust: gilrs::GilrsBuilder::new().add_mappings(EXTRA_SDL_MAPPINGS)
}

    // rust: impl Pads {
    // Open gilrs on first use. A platform without it (or a Linux without
    // udev) leaves controllers off; the game runs as before.
start :: proc(self: ^Self) {
}
    // rust: if self.devices.started {
    // rust: return;
}
    // rust: self.devices.started = true;
    // rust: self.devices.gilrs = match gilrs_builder().build() {
    // rust: Ok(g) => {
    // rust: for (id, pad) in g.gamepads() {
    // rust: log::info!("Controller connected: {}", pad.name());
    // rust: self.devices.known.push(id);
}
    // rust: Some(g)
}
    // rust: Err(gilrs::Error::NotImplemented(_)) => None,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: controllers are unavailable: {e}");
    // rust: None
}
}
}

    // Splitscreen reads the pads for every player (`PadRouter`): this game's own gilrs closes, or
    // its events would queue up unread. It opens again if this game reads the pads itself.
    // While several play, nobody gets rumble, adaptive triggers or the lightbar: the router
    // has no output path yet.
    // rust: pub(in crate::game) fn release_hardware(&mut self) {
    // rust: if self.devices.started {
    // rust: self.devices.gilrs = None;
    // rust: self.devices.started = false;
    // rust: self.devices.active = None;
    // rust: self.devices.known.clear();
    // rust: self.device = None;
    // rust: self.devices.rumbles.clear();
    // rust: self.devices.dualsense = false;
    // rust: self.devices.output = None;
}
}

    // Drain gilrs' events and read the active pad (opening gilrs the first time).
    // rust: pub(super) fn read(&mut self) -> PadState {
    // rust: self.start();
    // rust: let Some(gilrs) = self.devices.gilrs.as_mut() else {
    // rust: return PadState::default();
}
    // rust: let active = self.devices.active;
    // rust: while let Some(gilrs::Event { id, event, .. }) = gilrs.next_event() {
//             use gilrs::EventType as E;
    // rust: match event {
    // rust: E::Connected => {
    // rust: log::info!("Controller connected: {}", gilrs.gamepad(id).name());
                    // Some backends report the controllers already there as they open.
    // rust: if !self.devices.known.contains(&id) {
    // rust: self.devices.known.push(id);
    // rust: let pad = gilrs.gamepad(id);
    // rust: let style = GlyphStyle::of_device(pad.vendor_id(), pad.product_id());
    // rust: self.connections.push(Connection::Connected(style));
}
    // rust: if let Some(output) = &self.devices.output {
    // rust: output.scan();
}
}
    // rust: E::Disconnected => {
    // rust: log::info!("Controller disconnected: {}", gilrs.gamepad(id).name());
    // rust: self.devices.known.retain(|known| *known != id);
    // rust: self.connections.push(Connection::Disconnected {
    // rust: active: self.devices.active == Some(id),
    // rust: });
    // rust: if self.devices.active == Some(id) {
    // rust: self.devices.active = None;
}
    // rust: if let Some(output) = &self.devices.output {
    // rust: output.scan();
}
}
    // rust: E::ButtonPressed(..) => self.devices.active = Some(id),
    // rust: E::AxisChanged(_, value, _) | E::ButtonChanged(_, value, _)
    // rust: if value.abs() > 0.5 =>
    // rust: {
    // rust: self.devices.active = Some(id)
}
    // rust: _ => {}
}
}
        // Another pad, or none: its A going away isn't a release.
    // rust: if self.devices.active != active {
    // rust: self.menu.armed = None;
}
    // rust: let Some(pad) = self
    // rust: .devices
    // rust: .active
    // rust: .and_then(|id| gilrs.connected_gamepad(id))
    // rust: else {
            // Before any pad is touched (the virtual pad playing), a DualSense still shows it.
    // rust: self.devices.dualsense = gilrs.gamepads().any(|(_, pad)| is_dualsense(&pad));
    // rust: self.device = gilrs.gamepads().next().map(|(_, pad)| device_of(&pad));
    // rust: return PadState::default();
}
    // rust: self.device = Some(device_of(&pad));
    // rust: self.style = GlyphStyle::of_device(pad.vendor_id(), pad.product_id());
    // rust: self.devices.dualsense = is_dualsense(&pad);
    // rust: state_of(&pad)
}
}

// What the controller settings say about a pad.
device_of :: proc(pad: ^gilrs::Gamepad) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Device {
    // rust: name: pad.name().to_owned(),
    // rust: vendor: pad.vendor_id(),
    // rust: product: pad.product_id(),
}
}

// A pad's buttons, sticks and triggers now.
state_of :: proc(pad: ^gilrs::Gamepad) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut state = PadState::default();
    // rust: let crossed = face_buttons::crossed(pad);
    // rust: for button in Button::ALL {
    // rust: if !matches!(button, Button::LeftTrigger | Button::RightTrigger) {
    // rust: let named = face_buttons::named(gilrs_button(button), crossed);
    // rust: state.set(button, pad.is_pressed(named));
}
}
    // rust: let axis = |a| pad.value(a);
//     use gilrs::Axis as A;
    // rust: let sdl_mapped = pad.mapping_source() == gilrs::MappingSource::SdlMappings;
    // rust: let (left, right) = gamepad::stick_axes(
    // rust: [axis(A::LeftStickX), axis(A::LeftStickY)],
    // rust: [axis(A::RightStickX), axis(A::RightStickY)],
    // rust: axis(A::LeftZ),
    // rust: pad.vendor_id(),
    // rust: pad.product_id(),
    // rust: sdl_mapped,
    // rust: );
    // rust: state.left = left;
    // rust: state.right = right;
    // rust: state.triggers = triggers::triggers(pad);
    // rust: state
}

// A controller, as splitscreen tells them apart.
    // rust: pub(in crate::game) type PadId = gilrs::GamepadId;

// Splitscreen: one gilrs for every player's game in this process. The split decides which
// player each pad drives; this reads them.
    // rust: pub(in crate::game) struct PadRouter {
    // rust: gilrs: Option<gilrs::Gilrs>,
    // rust: started: bool,
}

    // rust: impl PadRouter {
    // Take over the reader P1 already has open, instead of opening a second and closing the
    // first. A compositor can count who holds a pad to pause its own use of it (KWin's pointer
    // emulation), and that count goes wrong when readers overlap: gilrs opens a pad twice at
    // once, which inotify can merge into one event, and closes it twice apart (#9730).
    // rust: pub(in crate::game) fn adopt(&mut self, pads: &mut Pads) {
    // rust: if !self.started
    // rust: && let Some(gilrs) = pads.devices.gilrs.take()
    // rust: {
    // rust: self.started = true;
    // rust: self.gilrs = Some(gilrs);
}
}

    // Routing ends: P1 gets the reader back, open as it was.
    // rust: pub(in crate::game) fn hand_back(&mut self, pads: &mut Pads) {
    // rust: self.started = false;
    // rust: pads.devices.routed = None;
    // rust: if let Some(gilrs) = self.gilrs.take() {
    // rust: pads.devices.gilrs = Some(gilrs);
    // rust: pads.devices.started = true;
}
}

    // Solo play uses this reader's device IDs for feedback too: another pad cannot steal
    // the active output while its input is being offered to join. Reclaimed after P1's turn.
    // rust: pub(in crate::game) fn lend_output(&mut self, pads: &mut Pads, id: PadId) {
    // rust: if pads.devices.gilrs.is_some() {
    // rust: pads.release_hardware();
}
    // rust: if pads.devices.active != Some(id) {
    // rust: pads.devices.rumbles.clear();
    // rust: pads.devices.output = None;
    // rust: pads.devices.shown = None;
}
    // rust: pads.devices.dualsense = self
    // rust: .gilrs
    // rust: .as_ref()
    // rust: .and_then(|g| g.connected_gamepad(id))
    // rust: .is_some_and(|p| is_dualsense(&p));
    // rust: pads.devices.active = Some(id);
    // rust: pads.devices.started = true;
    // rust: pads.devices.gilrs = self.gilrs.take();
}

    // rust: pub(in crate::game) fn reclaim_output(&mut self, pads: &mut Pads) {
    // rust: self.gilrs = pads.devices.gilrs.take();
}

    // `pad status` is answered in P1's turn, which can't reach this reader: leave it what the
    // reader sees. `owner`: the pad driving P1.
    // rust: pub(in crate::game) fn report_status(&self, pads: &mut Pads, owner: Option<PadId>) {
    // rust: pads.devices.routed = self.gilrs.as_ref().map(|g| {
    // rust: g.gamepads()
    // rust: .map(|(id, p)| controller_status(id, &p, owner))
    // rust: .collect()
    // rust: });
}

    // The buttons pressed and the controllers gone or back since the last call, in order.
    // rust: pub(in crate::game) fn events(&mut self) -> Vec<PadEvent> {
    // rust: if !self.started {
    // rust: self.started = true;
    // rust: self.gilrs = gilrs_builder().build().ok();
}
    // rust: let Some(gilrs) = self.gilrs.as_mut() else {
    // rust: return Vec::new();
}
    // rust: let mut events = Vec::new();
    // rust: while let Some(gilrs::Event { id, event, .. }) = gilrs.next_event() {
    // rust: match event {
    // rust: gilrs::EventType::ButtonPressed(pressed, _) => {
    // rust: let crossed = face_buttons::crossed(&gilrs.gamepad(id));
    // rust: if let Some(button) = Button::ALL
    // rust: .into_iter()
    // rust: .find(|&b| face_buttons::named(gilrs_button(b), crossed) == pressed)
    // rust: {
    // rust: events.push(PadEvent::Press(id, button));
}
}
    // rust: gilrs::EventType::Disconnected => {
    // rust: log::info!("Controller disconnected: {}", gilrs.gamepad(id).name());
    // rust: events.push(PadEvent::Gone(id));
}
    // rust: gilrs::EventType::Connected => events.push(PadEvent::Back(id)),
    // rust: _ => {}
}
}
    // rust: events
}

    // rust: pub(in crate::game) fn connected(&self, id: PadId) -> bool {
    // rust: self.gilrs
    // rust: .as_ref()
    // rust: .is_some_and(|g| g.connected_gamepad(id).is_some())
}

    // The kind of controller (its maker, model and bus; two of one model share it), to know it
    // back when it reconnects under a new id; zero when the system doesn't say.
    // rust: pub(in crate::game) fn uuid(&self, id: PadId) -> [u8; 16] {
    // rust: self.gilrs
    // rust: .as_ref()
    // rust: .map_or([0; 16], |g| g.gamepad(id).uuid())
}

    // The pad's state now (released when it is gone).
    // rust: pub(in crate::game) fn state(&self, id: PadId) -> PadState {
    // rust: self.gilrs
    // rust: .as_ref()
    // rust: .and_then(|g| g.connected_gamepad(id))
    // rust: .map_or_else(PadState::default, |pad| state_of(&pad))
}

    // Its glyphs (Xbox, PlayStation, Nintendo), as `read` finds them for the active pad.
    // rust: pub(in crate::game) fn style(&self, id: PadId) -> GlyphStyle {
    // rust: self.gilrs
    // rust: .as_ref()
    // rust: .and_then(|g| g.connected_gamepad(id))
    // rust: .map_or(GlyphStyle::Auto, |pad| {
    // rust: GlyphStyle::of_device(pad.vendor_id(), pad.product_id())
    // rust: })
}

    // rust: pub(in crate::game) fn device(&self, id: PadId) -> Option<Device> {
    // rust: self.gilrs
    // rust: .as_ref()
    // rust: .and_then(|g| g.connected_gamepad(id))
    // rust: .map(|pad| device_of(&pad))
}

    // rust: pub(in crate::game) fn name(&self, id: PadId) -> String {
    // rust: self.gilrs
    // rust: .as_ref()
    // rust: .and_then(|g| g.connected_gamepad(id))
    // rust: .map_or_else(|| "A controller".into(), |pad| pad.name().to_owned())
}
}

    // rust: impl Game<'_> {
    // Controllers are turned off: dropping the DualSense's output frees its triggers.
    // rust: pub(super) fn pad_output_off(&mut self) {
    // rust: self.pad.devices.output = None;
    // rust: self.pad.devices.shown = None;
}

    // After each poll: the DualSense's output opens once this window has the pad in hand, then
    // shows what the game is doing; vibrations that are over stop.
    // rust: pub(super) fn pad_output_frame(&mut self) {
    // rust: if self.pad.devices.dualsense
    // rust: && self.pad.in_use
    // rust: && self.focused
    // rust: && self.pad.devices.output.is_none()
    // rust: {
    // rust: self.pad.devices.output = Some(horizon_dualsense::Link::start());
}
    // rust: self.pad_haptics();
    // rust: self.pad_show();
    // rust: let now = Instant::now();
    // rust: self.pad.devices.rumbles.retain(|(_, end)| *end > now);
}

    // The DualSense's HID output, while it is the active pad, open, and this window has focus
    // (another game on the same pad keeps it otherwise).
pad_output :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let output = self.pad.devices.output.as_ref()?;
    // rust: (self.pad.devices.dualsense && self.focused && output.open().is_some()).then_some(output)
}

    // What the DualSense shows: while playing, its triggers feel what their actions do; in
    // menus, paused, unfocused or with another pad active, they are free.
pad_show :: proc(self: ^Self) {
}
    // rust: if self.pad.devices.output.is_none() {
    // rust: return;
}
    // rust: let playing = self.pad.devices.dualsense
    // rust: && self.focused
    // rust: && self.title.is_none()
    // rust: && self.screen == Screen::Playing
    // rust: && !self.pause;
    // rust: let (using, attacking) = if playing {
    // rust: self.trigger_feels()
    // rust: } else {
    // rust: (TriggerFeel::Free, TriggerFeel::Free)
}
        // The lightbar follows the player; menus keep the last colour.
    // rust: let in_world = self.title.is_none();
    // rust: let lightbar = match self.player.as_mut().filter(|_| in_world) {
    // rust: Some(p) => {
    // rust: let max = p.attribute("minecraft:max_health").unwrap_or(20.0) as f32;
    // rust: let health = p.health.health() / max.max(1.0);
    // rust: self.settings
    // rust: .controller
    // rust: .lightbar
    // rust: .colour(health, self.dim.id())
}
    // rust: None => self.pad.devices.shown.and_then(|s| s.lightbar),
}
    // rust: let lights = self.settings.controller.lightbar != gamepad::Lightbar::Off;
    // rust: let state = horizon_dualsense::device::State {
    // rust: triggers: self.settings.controller.trigger_effects(using, attacking),
    // rust: lightbar: lightbar.filter(|_| lights),
    // rust: player_leds: lights.then_some(horizon_dualsense::PLAYER_1),
}
    // rust: if self.pad.devices.shown != Some(state)
    // rust: && let Some(output) = &self.pad.devices.output
    // rust: {
    // rust: output.set(state);
    // rust: self.pad.devices.shown = Some(state);
}
}

    // What `key.use` and `key.attack` are doing, for the triggers bound to them.
trigger_feels :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let using = match self.using {
    // rust: Some((slot, ticks)) => match self.stack_in(slot) {
    // rust: Some(s) if &*s.item == "minecraft:bow" => {
    // rust: TriggerFeel::Draw(gamepad::bow_power(ticks))
}
                // TridentItem.THROW_THRESHOLD_TIME.
    // rust: Some(s) if &*s.item == "minecraft:trident" => {
    // rust: TriggerFeel::Draw(ticks as f32 / 10.0)
}
    // rust: Some(s) if &*s.item == "minecraft:crossbow" => {
    // rust: TriggerFeel::Draw(ticks as f32 / Self::charge_ticks(s).max(1) as f32)
}
    // rust: Some(s) if self.blocks_attacks(s).is_some() => TriggerFeel::Brace,
    // rust: _ => TriggerFeel::Free,
    // rust: },
    // rust: None => self.idle_use_feel(),
}
        // Creative breaks at once; blocks that can't be broken have a negative hardness.
    // rust: let attacking = match &self.mining {
    // rust: Some(m) if !self.creative => {
    // rust: let state = self.world.block(m.pos[0], m.pos[1], m.pos[2]);
    // rust: TriggerFeel::Texture(self.res.facts().get(state).hardness)
}
    // rust: _ => TriggerFeel::Free,
}
    // rust: (using, attacking)
}

    // The use trigger while nothing is in use: a loaded crossbow clicks, an item that boosts (a
    // rocket while gliding, the stick of the mount being ridden) catches, a shield weighs, and
    // locks while an axe has disabled it.
idle_use_feel :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let gliding = self.player.as_ref().is_some_and(|p| p.fall_flying);
    // rust: let mount = self
    // rust: .riding
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id));
    // rust: let mount = mount.map_or("", |m| m.kind.id.as_str());
    // rust: let feel = |stack: Option<&horizon_client::items::ItemStack>| match stack
    // rust: .map(|s| (s, &*s.item))
    // rust: {
    // rust: Some((s, "minecraft:crossbow")) if s.data().is_some_and(|d| !d.charged.is_empty()) => {
    // rust: TriggerFeel::Click
}
    // rust: Some((_, "minecraft:firework_rocket")) if gliding => TriggerFeel::Boost,
    // rust: Some((_, "minecraft:carrot_on_a_stick")) if mount == "minecraft:pig" => {
    // rust: TriggerFeel::Boost
}
    // rust: Some((_, "minecraft:warped_fungus_on_a_stick")) if mount == "minecraft:strider" => {
    // rust: TriggerFeel::Boost
}
    // rust: Some((s, _)) if self.blocks_attacks(s).is_some() => match self.shield_cooldown {
    // rust: 0 => TriggerFeel::Brace,
    // rust: _ => TriggerFeel::Locked,
    // rust: },
    // rust: _ => TriggerFeel::Free,
}
        // Use tries the main hand first.
    // rust: match feel(self.stack_in(self.selected)) {
    // rust: TriggerFeel::Free => feel(self.offhand.as_ref()),
    // rust: main => main,
}
}

    // Open the pad's haptics once its output is open over USB (its audio device is there
    // only then); close them when it goes. Opt-in with `HORIZON_DUALSENSE_HAPTICS=1` until
    // they are proven on a pad (docs/controllers.md); never for games without sound (tests).
pad_haptics :: proc(self: ^Self) {
}
    // rust: let usb = self.pad.devices.output.as_ref().and_then(|o| o.open())
    // rust: == Some(horizon_dualsense::Transport::Usb);
    // rust: if !usb {
    // rust: self.pad.devices.haptics = None;
    // rust: self.pad.devices.haptics_tried = false;
    // rust: } else if !self.pad.devices.haptics_tried {
    // rust: self.pad.devices.haptics_tried = true;
    // rust: if std::env::var_os("HORIZON_DUALSENSE_HAPTICS").is_some_and(|v| v == "1")
    // rust: && std::env::var_os("HORIZON_NO_AUDIO").is_none()
    // rust: {
    // rust: self.pad.devices.haptics = horizon_dualsense::haptics::Haptics::open();
}
}
}

    // Release the DualSense's output (the game is quitting).
    // rust: pub(in crate::game) fn pad_close_output(&mut self) {
    // rust: self.pad.devices.haptics = None;
    // rust: self.pad.devices.output = None;
}

    // Play a vibration on the active pad: a DualSense through its own report, else gilrs' force
    // feedback, which platforms without it (gilrs on macOS) skip.
    // rust: pub(super) fn pad_vibrate(&mut self, rumble: Rumble, pulse: gamepad::Pulse) {
    // rust: let level = |v: f32| (v.clamp(0.0, 1.0) * 255.0).round() as u8;
    // rust: if let Some(haptics) = self
    // rust: .pad
    // rust: .devices
    // rust: .haptics
    // rust: .as_ref()
    // rust: .filter(|_| self.pad_output().is_some())
    // rust: {
    // rust: let steps = rumble.shape().into_iter().map(|step| {
    // rust: (
    // rust: step.strong,
    // rust: step.weak,
    // rust: Duration::from_millis(u64::from(step.millis)),
    // rust: )
    // rust: });
    // rust: haptics.play(&steps.collect::<Vec<_>>());
    // rust: return;
}
    // rust: if let Some(output) = self.pad_output() {
    // rust: let steps = rumble.shape().into_iter().map(|step| {
    // rust: let length = Duration::from_millis(u64::from(step.millis));
    // rust: ([level(step.strong), level(step.weak)], length)
    // rust: });
    // rust: output.rumble(steps.collect());
    // rust: return;
}
    // rust: let (Some(gilrs), Some(id)) = (self.pad.devices.gilrs.as_mut(), self.pad.devices.active)
    // rust: else {
    // rust: return;
}
    // rust: if !gilrs
    // rust: .connected_gamepad(id)
    // rust: .is_some_and(|g| g.is_ff_supported())
    // rust: {
    // rust: return;
}
//         use gilrs::ff::{BaseEffect, BaseEffectType, EffectBuilder, Repeat, Replay, Ticks};
    // rust: let length = Ticks::from_ms(pulse.millis);
    // rust: let motor = |kind| BaseEffect {
    // rust: kind,
    // rust: scheduling: Replay {
    // rust: play_for: length,
    // rust: ..Default::default()
    // rust: },
    // rust: envelope: Default::default(),
}
    // rust: let magnitude = |v: f32| (v.clamp(0.0, 1.0) * f32::from(u16::MAX)) as u16;
    // rust: let effect = EffectBuilder::new()
    // rust: .add_effect(motor(BaseEffectType::Strong {
    // rust: magnitude: magnitude(pulse.strong),
    // rust: }))
    // rust: .add_effect(motor(BaseEffectType::Weak {
    // rust: magnitude: magnitude(pulse.weak),
    // rust: }))
    // rust: .repeat(Repeat::For(length))
    // rust: .gamepads(&[id])
    // rust: .finish(gilrs);
    // rust: match effect.and_then(|e| e.play().map(|()| e)) {
    // rust: Ok(effect) => {
    // rust: let end = Instant::now() + Duration::from_millis(u64::from(pulse.millis) + 50);
    // rust: self.pad.devices.rumbles.push((effect, end));
}
    // rust: Err(e) => log::debug!("Horizon: controller vibration: {e}"),
}
}

    // rust: pub(super) fn pad_devices_status(&self) -> Value {
    // rust: self.pad.devices.status()
}
}

    // rust: mod one_reader_tests {
//     use super::*;

    // Whether a machine can open gilrs at all; a test without it has nothing to check.
reader :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: gilrs_builder().build().ok()
}

routing_takes_p1s_reader_and_gives_it_back_without_closing_it :: proc() {
}
    // rust: let Some(gilrs) = reader() else {
    // rust: return;
}
    // rust: let mut pads = Pads::default();
    // rust: pads.devices.gilrs = Some(gilrs);
    // rust: pads.devices.started = true;
    // rust: let mut router = PadRouter::default();

    // rust: router.adopt(&mut pads);
    // rust: assert!(pads.devices.gilrs.is_none(), "P1 no longer holds it");
    // rust: assert!(router.gilrs.is_some(), "the router holds the same reader");
    // rust: assert!(router.started, "so the router won't open a second");

    // rust: pads.release_hardware();
    // rust: router.hand_back(&mut pads);
    // rust: assert!(router.gilrs.is_none());
    // rust: assert!(pads.devices.gilrs.is_some(), "P1 holds it again");
    // rust: assert!(pads.devices.started, "so P1 won't open a second");
}

    // While the router has the reader, `pad status` still says controllers can be read.
status_sees_the_routers_reader_until_it_comes_back :: proc() {
}
    // rust: let Some(gilrs) = reader() else {
    // rust: return;
}
    // rust: let mut pads = Pads::default();
    // rust: pads.devices.gilrs = Some(gilrs);
    // rust: pads.devices.started = true;
    // rust: let mut router = PadRouter::default();
    // rust: let backend = |pads: &Pads| pads.devices.status()["backend"].as_bool().unwrap();

    // rust: router.adopt(&mut pads);
    // rust: assert!(!backend(&pads), "nothing reported yet");
    // rust: router.report_status(&mut pads, None);
    // rust: assert!(backend(&pads), "the router's reader counts");

    // rust: router.hand_back(&mut pads);
    // rust: assert!(pads.devices.routed.is_none(), "P1 reads its own again");
    // rust: assert!(backend(&pads));
}

a_router_with_its_own_reader_leaves_a_lent_ones_owner_alone :: proc() {
}
    // rust: let (Some(own), Some(other)) = (reader(), reader()) else {
    // rust: return;
}
    // rust: let mut pads = Pads::default();
    // rust: pads.devices.gilrs = Some(other);
    // rust: let mut router = PadRouter {
    // rust: gilrs: Some(own),
    // rust: started: true,
}
    // rust: router.adopt(&mut pads);
    // rust: assert!(pads.devices.gilrs.is_some());
}
}
