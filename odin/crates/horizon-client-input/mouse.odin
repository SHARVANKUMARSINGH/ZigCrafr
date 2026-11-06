//! Transpiled from Horizon Rust crate
package horizon_client_input_mouse

import "core:fmt"
import "core:mem"
import "core:math"

// Mouse look and scrolling of 26.3: `MouseHandler` (accumulated movement,
// sensitivity curve, cinematic smoothing, inversion), `SmoothDouble`,
// `ScrollWheelHandler` and `Entity.turn`.

// `SmoothDouble`.
SmoothDouble :: struct {
    target_value: f64,
    remaining_value: f64,
    last_amount: f64,
}

    // rust: impl SmoothDouble {
get_new_delta_value :: proc(self: ^Self, target_delta: f64, time: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.target_value += target_delta;
    // rust: let mut delta = self.target_value - self.remaining_value;
    // rust: let new_last_amount = self.last_amount + 0.5 * (delta - self.last_amount);
    // rust: let delta_sign = java_signum(delta);
    // rust: if delta_sign * delta > delta_sign * self.last_amount {
    // rust: delta = new_last_amount;
}
    // rust: self.last_amount = new_last_amount;
    // rust: self.remaining_value += delta * time;
    // rust: delta * time
}
reset :: proc(self: ^Self) {
}
    // rust: *self = Self::default();
}
}

// `Math.signum(double)`.
java_signum :: proc(v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v == 0.0 || v.is_nan() {
    // rust: v
    // rust: } else {
    // rust: v.signum()
}
}

// `ScrollWheelHandler`.
ScrollWheelHandler :: struct {
    accumulated_x: f64,
    accumulated_y: f64,
}

    // rust: impl ScrollWheelHandler {
    // `onMouseScroll`: whole wheel steps `(x, y)` once enough has accumulated.
on_mouse_scroll :: proc(self: ^Self, x: f64, y: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.accumulated_x != 0.0 && java_signum(x) != java_signum(self.accumulated_x) {
    // rust: self.accumulated_x = 0.0;
}
    // rust: if self.accumulated_y != 0.0 && java_signum(y) != java_signum(self.accumulated_y) {
    // rust: self.accumulated_y = 0.0;
}
    // rust: self.accumulated_x += x;
    // rust: self.accumulated_y += y;
        // Java's double-to-int cast saturates and maps NaN to zero, like Rust's.
    // rust: let wheel_x = self.accumulated_x as i32;
    // rust: let wheel_y = self.accumulated_y as i32;
    // rust: if wheel_x == 0 && wheel_y == 0 {
    // rust: return (0, 0);
}
    // rust: self.accumulated_x -= f64::from(wheel_x);
    // rust: self.accumulated_y -= f64::from(wheel_y);
    // rust: (wheel_x, wheel_y)
}

    // `getNextScrollWheelSelection`.
next_selection :: proc(wheel: f64, current_selected: i32, limit: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let step = java_signum(wheel) as i32;
    // rust: let mut current = (current_selected - step).max(-1);
    // rust: while current < 0 {
    // rust: current += limit;
}
    // rust: while current >= limit {
    // rust: current -= limit;
}
    // rust: current
}
}

// `MouseHandler.onScroll` with the spectator menu closed. Only vertical whole
// wheel steps adjust `Abilities.flyingSpeed`; horizontal scrolling does not.
spectator_flying_speed :: proc(speed: f32, vertical_steps: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (speed + vertical_steps as f32 * 0.005).clamp(0.0, 0.2)
}

// Entity rotation as `Entity.turn` keeps it.
Rotation :: struct {
    x_rot: f32,
    y_rot: f32,
    x_rot_o: f32,
    y_rot_o: f32,
}

    // rust: impl Rotation {
set_x_rot :: proc(self: ^Self, x_rot: f32) {
}
    // rust: if x_rot.is_finite() {
    // rust: self.x_rot = (x_rot % 360.0).clamp(-90.0, 90.0);
}
}
set_y_rot :: proc(self: ^Self, y_rot: f32) {
}
    // rust: if y_rot.is_finite() {
    // rust: self.y_rot = y_rot;
}
}
    // `Entity.turn(xo, yo)`: mouse deltas in, 0.15 degrees per unit, pitch clamped.
turn :: proc(self: ^Self, xo: f64, yo: f64) {
}
    // rust: let x_delta = (yo as f32) * 0.15;
    // rust: let y_delta = (xo as f32) * 0.15;
    // rust: self.set_x_rot(self.x_rot + x_delta);
    // rust: self.set_y_rot(self.y_rot + y_delta);
    // rust: self.set_x_rot(mth_clamp(self.x_rot, -90.0, 90.0));
    // rust: self.x_rot_o += x_delta;
    // rust: self.y_rot_o += y_delta;
    // rust: self.x_rot_o = mth_clamp(self.x_rot_o, -90.0, 90.0);
}
}

// `Mth.clamp(float, float, float)`.
mth_clamp :: proc(value: f32, min: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if value < min {
    // rust: min
    // rust: } else if value.is_nan() || max.is_nan() {
    // rust: f32::NAN
    // rust: } else {
    // rust: value.min(max)
}
}

// The options `turnPlayer` reads.
LookOptions :: struct {
    sensitivity: f64,
    smooth_camera: bool,
    // First-person camera and the player is scoping (spyglass).
    scoping: bool,
    invert_x: bool,
    invert_y: bool,
}

// The input state of `MouseHandler` that drives the camera and the hotbar.
MouseLook :: struct {
    xpos: f64,
    ypos: f64,
    ignore_first_move: bool,
    smooth_turn_x: SmoothDouble,
    smooth_turn_y: SmoothDouble,
    accumulated_dx: f64,
    accumulated_dy: f64,
    scroll: ScrollWheelHandler,
    last_handle_movement_time: f64,
}

    // rust: impl Default for MouseLook {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: xpos: 0.0,
    // rust: ypos: 0.0,
    // rust: ignore_first_move: true,
    // rust: smooth_turn_x: SmoothDouble::default(),
    // rust: smooth_turn_y: SmoothDouble::default(),
    // rust: accumulated_dx: 0.0,
    // rust: accumulated_dy: 0.0,
    // rust: scroll: ScrollWheelHandler::default(),
            // Double.MIN_VALUE
    // rust: last_handle_movement_time: 4.9e-324,
}
}
}

    // rust: impl MouseLook {
    // `setIgnoreFirstMove`.
set_ignore_first_move :: proc(self: ^Self) {
}
    // rust: self.ignore_first_move = true;
}

    // `onMove`: relative motion counts while the pointer is grabbed, absolute
    // motion otherwise.
    // rust: pub fn on_move(
    // rust: &mut self,
    // rust: xpos: f64,
    // rust: ypos: f64,
    // rust: xrel: f64,
    // rust: yrel: f64,
    // rust: window_active: bool,
    // rust: grabbed: bool,
    // rust: ) {
    // rust: if self.ignore_first_move {
    // rust: self.xpos = xpos;
    // rust: self.ypos = ypos;
    // rust: self.ignore_first_move = false;
    // rust: } else {
    // rust: if window_active {
    // rust: if grabbed {
    // rust: self.accumulated_dx += xrel;
    // rust: self.accumulated_dy += yrel;
    // rust: } else {
    // rust: self.accumulated_dx += xpos - self.xpos;
    // rust: self.accumulated_dy += ypos - self.ypos;
}
}
    // rust: self.xpos = xpos;
    // rust: self.ypos = ypos;
}
}

    // `onMove` with the pointer grabbed, for relative motion an agent makes
    // (`horizon-ctl mouse-move`): added to the frame's accumulated movement.
add_motion :: proc(self: ^Self, dx: f64, dy: f64) {
}
    // rust: self.accumulated_dx += dx;
    // rust: self.accumulated_dy += dy;
}

    // Movement accumulated since the last frame (for screens' mouse-moved events).
accumulated :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (self.accumulated_dx, self.accumulated_dy)
}

    // `handleAccumulatedMovement` for a frame at `time` seconds: the
    // `(xo, yo)` passed to `Entity.turn` when the pointer is grabbed and the
    // window is active. The accumulators are cleared either way.
    // rust: pub fn handle_accumulated_movement(
    // rust: &mut self,
    // rust: time: f64,
    // rust: window_active: bool,
    // rust: grabbed_with_player: bool,
    // rust: look: LookOptions,
    // rust: ) -> Option<(f64, f64)> {
    // rust: let mousea = time - self.last_handle_movement_time;
    // rust: self.last_handle_movement_time = time;
    // rust: let turn = (window_active && grabbed_with_player).then(|| self.turn_player(mousea, look));
    // rust: self.accumulated_dx = 0.0;
    // rust: self.accumulated_dy = 0.0;
    // rust: turn
}

turn_player :: proc(self: ^Self, mousea: f64, look: LookOptions) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (sensitivity_mod, sens) = sensitivity_scales(look.sensitivity);
    // rust: let (xo, yo) = if look.smooth_camera {
    // rust: (
    // rust: self.smooth_turn_x
    // rust: .get_new_delta_value(self.accumulated_dx * sens, mousea * sens),
    // rust: self.smooth_turn_y
    // rust: .get_new_delta_value(self.accumulated_dy * sens, mousea * sens),
    // rust: )
    // rust: } else if look.scoping {
    // rust: self.smooth_turn_x.reset();
    // rust: self.smooth_turn_y.reset();
    // rust: (
    // rust: self.accumulated_dx * sensitivity_mod,
    // rust: self.accumulated_dy * sensitivity_mod,
    // rust: )
    // rust: } else {
    // rust: self.smooth_turn_x.reset();
    // rust: self.smooth_turn_y.reset();
    // rust: (self.accumulated_dx * sens, self.accumulated_dy * sens)
}
    // rust: (
    // rust: if look.invert_x { -xo } else { xo },
    // rust: if look.invert_y { -yo } else { yo },
    // rust: )
}

    // `onScroll` for the in-game case (no screen, player present): the wheel
    // value `wheel` the hotbar or spectator speed reacts to, and the raw
    // wheel steps. `None` when no whole step has accumulated.
    // rust: pub fn on_scroll(
    // rust: &mut self,
    // rust: xoffset: f64,
    // rust: yoffset: f64,
    // rust: discrete: bool,
    // rust: wheel_sensitivity: f64,
    // rust: ) -> Option<(i32, (i32, i32))> {
    // rust: let scale = |v: f64| (if discrete { java_signum(v) } else { v }) * wheel_sensitivity;
    // rust: let (x, y) = self.scroll.on_mouse_scroll(scale(xoffset), scale(yoffset));
    // rust: if x == 0 && y == 0 {
    // rust: return None;
}
    // rust: let wheel = if y == 0 { -x } else { y };
    // rust: Some((wheel, (x, y)))
}
}

// `MouseHandler.turnPlayer`'s scales: `sensitivityMod = (s*0.6F+0.2F)^3`
// and `sens = sensitivityMod * 8`.
sensitivity_scales :: proc(sensitivity: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let ss = sensitivity * f64::from(0.6f32) + f64::from(0.2f32);
    // rust: let sensitivity_mod = ss * ss * ss;
    // rust: (sensitivity_mod, sensitivity_mod * 8.0)
}

// Degrees `Entity.turn` turns per unit of mouse motion: 0.15 x `sens`
// (`sensitivityMod` while scoping). With the cinematic camera the same total
// is reached, spread over the following frames.
degrees_per_count :: proc(look: LookOptions) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (sensitivity_mod, sens) = sensitivity_scales(look.sensitivity);
    // rust: let scale = if look.scoping && !look.smooth_camera {
    // rust: sensitivity_mod
    // rust: } else {
    // rust: sens
}
    // rust: 0.15 * scale
}

// The mouse motion that turns the view by `dyaw` and `dpitch` degrees with
// these options, the inverted axes included.
motion_for_turn :: proc(dyaw: f64, dpitch: f64, look: LookOptions) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let per_count = degrees_per_count(look);
    // rust: let flip = |inverted: bool| if inverted { -1.0 } else { 1.0 };
    // rust: (
    // rust: dyaw / per_count * flip(look.invert_x),
    // rust: dpitch / per_count * flip(look.invert_y),
    // rust: )
}

// Ease-in-out (a half cosine) over `t` in 0..=1: how much of a spread-out
// turn is done at that point of its time.
ease_in_out :: proc(t: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let t = t.clamp(0.0, 1.0);
    // rust: 0.5 - 0.5 * (std::f64::consts::PI * t).cos()
}

// `MouseHandler.grabMouse` / `releaseMouse`: the mouse position is the
// window's centre whenever the pointer's grab state changes, so a screen
// opened from gameplay starts with the cursor in the middle. A release of
// an already free pointer (or a grab of an already grabbed one) leaves the
// position where it is, as vanilla does.
    // rust: pub fn mouse_position_after_grab_change(
    // rust: grab: bool,
    // rust: was_grabbed: bool,
    // rust: size: [u32; 2],
    // rust: scale: f32,
    // rust: ) -> Option<(f32, f32)> {
    // rust: if grab == was_grabbed {
    // rust: None
    // rust: } else {
    // rust: Some((size[0] as f32 / 2.0 / scale, size[1] as f32 / 2.0 / scale))
}
}

// `MacosUtil.setCtrlClickEmulatesRightClick`: with the option on (and only on
// macOS), a left click made with Control held is a right click, and so is
// its release, whatever Control does in between.
RightClickEmulation :: struct {
    emulating: bool,
}
    // rust: impl RightClickEmulation {
    // Whether the left button's `pressed` or released event is a right click.
    // `enabled` is the option on macOS.
is_right_click :: proc(self: ^Self, pressed: bool, control: bool, enabled: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if pressed {
    // rust: self.emulating = enabled && control;
}
    // rust: let right = self.emulating;
    // rust: if !pressed {
    // rust: self.emulating = false;
}
    // rust: right
}
}

    // rust: mod tests {
//     use super::*;

    // rust: const PLAIN: LookOptions = LookOptions {
    // rust: sensitivity: 0.5,
    // rust: smooth_camera: false,
    // rust: scoping: false,
    // rust: invert_x: false,
    // rust: invert_y: false,
}

    // One frame of motion `(dx, dy)` through `onMove`'s grabbed path,
    // `handleAccumulatedMovement` and `Entity.turn`.
frame :: proc(look: ^MouseLook, rot: ^Rotation, time: f64, d: (f64) {
}
    // rust: look.add_motion(d.0, d.1);
    // rust: if let Some((xo, yo)) = look.handle_accumulated_movement(time, true, true, o) {
    // rust: rot.turn(xo, yo);
}
}

rotation :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: Rotation {
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot_o: 0.0,
    // rust: y_rot_o: 0.0,
}
}

turn_player_matches_the_vanilla_formula :: proc() {
}
        // MouseHandler.turnPlayer: ss = sensitivity*0.6F + 0.2F, sens = ss^3 * 8,
        // then Entity.turn: yRot += (float)xo * 0.15F, xRot += (float)yo * 0.15F.
    // rust: for sensitivity in [0.0, 0.25, 0.5, 0.75, 1.0] {
    // rust: for (dx, dy) in [(1.0, 0.0), (37.0, -12.5), (-400.0, 250.0)] {
    // rust: let o = LookOptions {
    // rust: sensitivity,
    // rust: ..PLAIN
}
    // rust: let ss = sensitivity * f64::from(0.6f32) + f64::from(0.2f32);
    // rust: let sens = ss * ss * ss * 8.0;
    // rust: let mut look = MouseLook::default();
    // rust: let mut rot = rotation();
    // rust: frame(&mut look, &mut rot, 1.0, (dx, dy), o);
    // rust: let yaw = (dx * sens) as f32 * 0.15;
    // rust: let pitch = ((dy * sens) as f32 * 0.15).clamp(-90.0, 90.0);
    // rust: assert_eq!(
    // rust: (rot.y_rot, rot.x_rot),
    // rust: (yaw, pitch),
    // rust: "s {sensitivity} d {dx},{dy}"
    // rust: );
}
}
}

inverted_and_scoping_turns :: proc() {
}
    // rust: let mut look = MouseLook::default();
    // rust: let mut rot = rotation();
    // rust: let o = LookOptions {
    // rust: invert_y: true,
    // rust: ..PLAIN
}
    // rust: frame(&mut look, &mut rot, 1.0, (0.0, 10.0), o);
    // rust: assert!(rot.x_rot < 0.0, "inverted Y looks up: {}", rot.x_rot);
        // Scoping drops the factor 8.
    // rust: let scoped = LookOptions {
    // rust: scoping: true,
    // rust: ..PLAIN
}
    // rust: assert!((degrees_per_count(PLAIN) / degrees_per_count(scoped) - 8.0).abs() < 1e-12);
}

motion_for_turn_round_trips_through_turn_player :: proc() {
}
    // rust: for o in [
    // rust: PLAIN,
    // rust: LookOptions {
    // rust: sensitivity: 0.9,
    // rust: invert_x: true,
    // rust: invert_y: true,
    // rust: ..PLAIN
    // rust: },
    // rust: LookOptions {
    // rust: scoping: true,
    // rust: ..PLAIN
    // rust: },
    // rust: ] {
    // rust: let (dx, dy) = motion_for_turn(73.5, -21.25, o);
    // rust: let mut look = MouseLook::default();
    // rust: let mut rot = rotation();
    // rust: frame(&mut look, &mut rot, 1.0, (dx, dy), o);
    // rust: assert!((rot.y_rot - 73.5).abs() < 1e-3, "{o:?}: {}", rot.y_rot);
    // rust: assert!((rot.x_rot + 21.25).abs() < 1e-3, "{o:?}: {}", rot.x_rot);
}
}

cinematic_camera_spreads_the_same_motion_over_frames :: proc() {
}
        // SmoothDouble: the first frame turns part of the way, later frames
        // without new motion carry on towards the same total.
    // rust: let o = LookOptions {
    // rust: smooth_camera: true,
    // rust: ..PLAIN
}
    // rust: let (dx, _) = motion_for_turn(30.0, 0.0, o);
    // rust: let mut look = MouseLook::default();
    // rust: let mut rot = rotation();
    // rust: frame(&mut look, &mut rot, 0.0, (0.0, 0.0), o);
    // rust: frame(&mut look, &mut rot, 1.0 / 60.0, (dx, 0.0), o);
    // rust: let first = rot.y_rot;
    // rust: assert!(first > 0.0 && first < 30.0, "{first}");
    // rust: for i in 2..600 {
    // rust: frame(&mut look, &mut rot, f64::from(i) / 60.0, (0.0, 0.0), o);
}
    // rust: assert!((rot.y_rot - 30.0).abs() < 0.05, "{}", rot.y_rot);
}

ease_in_out_starts_and_ends_slowly :: proc() {
}
    // rust: assert_eq!(ease_in_out(0.0), 0.0);
    // rust: assert!((ease_in_out(0.5) - 0.5).abs() < 1e-12);
    // rust: assert!((ease_in_out(1.0) - 1.0).abs() < 1e-12);
    // rust: assert!(ease_in_out(0.1) < 0.1 && ease_in_out(0.9) > 0.9);
    // rust: assert_eq!(ease_in_out(2.0), 1.0);
}
default_sensitivity_turns_point_fifteen_degrees_per_count_at_one :: proc() {
}
    // rust: let mut look = MouseLook::default();
    // rust: look.on_move(0.0, 0.0, 0.0, 0.0, true, true);
    // rust: look.on_move(1.0, 0.0, 1.0, 0.0, true, true);
    // rust: let (xo, _) = look
    // rust: .handle_accumulated_movement(
    // rust: 1.0,
    // rust: true,
    // rust: true,
    // rust: LookOptions {
    // rust: sensitivity: 0.5,
    // rust: smooth_camera: false,
    // rust: scoping: false,
    // rust: invert_x: false,
    // rust: invert_y: false,
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: let mut rot = Rotation {
    // rust: x_rot: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot_o: 0.0,
    // rust: y_rot_o: 0.0,
}
    // rust: rot.turn(xo, 0.0);
    // rust: assert!((rot.y_rot - 0.15 * 1.0).abs() < 1e-6, "{}", rot.y_rot);
}
scroll_accumulates_fractions :: proc() {
}
    // rust: let mut look = MouseLook::default();
    // rust: assert_eq!(look.on_scroll(0.0, 0.4, false, 1.0), None);
    // rust: assert_eq!(look.on_scroll(0.0, 0.7, false, 1.0), Some((1, (0, 1))));
}
the_mouse_position_is_the_centre_when_the_grab_changes :: proc() {
}
        // A grab of a free pointer and a release of a grabbed one both put
        // the position at the window's centre (`MouseHandler.grabMouse`,
        // `MouseHandler.releaseMouse`).
    // rust: assert_eq!(
    // rust: mouse_position_after_grab_change(true, false, [1920, 1080], 1.0),
    // rust: Some((960.0, 540.0))
    // rust: );
    // rust: assert_eq!(
    // rust: mouse_position_after_grab_change(false, true, [1920, 1080], 2.0),
    // rust: Some((480.0, 270.0))
    // rust: );
        // Without a change of the grab state the position stays where it is.
    // rust: assert_eq!(
    // rust: mouse_position_after_grab_change(false, false, [1920, 1080], 1.0),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: mouse_position_after_grab_change(true, true, [1920, 1080], 1.0),
    // rust: None
    // rust: );
}

control_click_is_a_right_click_until_released :: proc() {
}
    // rust: let mut e = RightClickEmulation::default();
        // The option off, or no Control: a left click stays one.
    // rust: assert!(!e.is_right_click(true, true, false));
    // rust: assert!(!e.is_right_click(false, true, false));
    // rust: assert!(!e.is_right_click(true, false, true));
    // rust: assert!(!e.is_right_click(false, true, true));
        // Control held at the press: the press and the release are right clicks,
        // even when Control was let go before the release.
    // rust: assert!(e.is_right_click(true, true, true));
    // rust: assert!(e.is_right_click(false, false, true));
        // The next left click is its own.
    // rust: assert!(!e.is_right_click(true, false, true));
    // rust: assert!(!e.is_right_click(false, false, true));
}
}
