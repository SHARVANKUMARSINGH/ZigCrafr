//! Transpiled from Horizon Rust crate
//! Module: horizon-hdr_wayland
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What a Wayland compositor says it shows a surface with (`wp_color_management_v1`): the
//! luminances of the surface's preferred image description. A compositor that manages
//! colour (KWin, Mutter, wlroots) maps HDR content onto the display relative to a
//! reference white and tone-maps above what the display reaches, so the game can't
//! measure the display through it: it asks instead.
//!
//! The watch runs on winit's own connection, on an event queue of its own, so winit's
//! events are left alone; winit's loop reads the socket, the watch only looks at what
//! landed on its queue.
// use std::ffi::c_void;
// use wayland_backend::client::{Backend, ObjectId};
// use wayland_client::{
    // rust: Connection, Dispatch, EventQueue, Proxy, QueueHandle,
    // rust: protocol::{wl_registry, wl_surface::WlSurface},
}
// use wayland_protocols::wp::color_management::v1::client::{
    // rust: wp_color_management_surface_feedback_v1::{self, WpColorManagementSurfaceFeedbackV1},
    // rust: wp_color_manager_v1::{self, WpColorManagerV1},
    // rust: wp_image_description_info_v1::{self, WpImageDescriptionInfoV1},
    // rust: wp_image_description_v1::{self, WpImageDescriptionV1},
}

/// A surface's preferred luminances, in cd/m² (nits).
pub const Luminances = struct {
    /// The reference white: where SDR white sits.
    reference: f32,
    /// The darkest and brightest the target display shows (`target_luminance`).
    target_min: f32,
    target_max: f32,
};

pub const State = struct {
    manager: Option<(u32,
    /// The compositor changed the surface's preferred description since the last query.
    changed: bool,
    ready: ?bool,
    reference: ?f32,
    target: Option<(f32,
    done: bool,
};

/// What a compositor says about one window, kept up to date: [`Watch::changed`] says
/// when it changes (another output, the player recalibrating the desktop).
///
/// Drop it before the window: its objects live on the window's connection.
pub const Watch = struct {
    queue: EventQueue<State>,
    state: State,
    manager: WpColorManagerV1,
    feedback: WpColorManagementSurfaceFeedbackV1,
};

    // rust: impl Watch {
    /// Starts watching `window`'s surface, with what the compositor says now. None off
    /// Wayland, or where the compositor has no `wp_color_management_v1`.
    // rust: pub fn new(
    // rust: window: &(impl wgpu::rwh::HasDisplayHandle + wgpu::rwh::HasWindowHandle),
    // rust: ) -> Option<(Self, Option<Luminances>)> {
//         use wgpu::rwh::{RawDisplayHandle, RawWindowHandle};
    // rust: let (RawDisplayHandle::Wayland(d), RawWindowHandle::Wayland(w)) = (
    // rust: window.display_handle().ok()?.as_raw(),
    // rust: window.window_handle().ok()?.as_raw(),
    // rust: ) else {
    // rust: return None;
}
        // Safety: the window's live display and surface, borrowed for the call.
    // rust: let mut watch = unsafe { Self::on(d.display.as_ptr(), w.surface.as_ptr()) }?;
    // rust: let now = watch.query();
    // rust: Some((watch, now))
}

    /// [`Watch::new`] on raw handles: `surface` (a `wl_surface*`) on `display` (a
    /// `wl_display*`).
    ///
    /// # Safety
    ///
    /// `display` and `surface` must be live libwayland objects of the same connection.
    // rust: unsafe fn on(display: *mut c_void, surface: *mut c_void) -> Option<Self> {
        // Safety: the caller's live display; a foreign one is never closed from here.
    // rust: let backend = unsafe { Backend::from_foreign_display(display.cast()) };
    // rust: let conn = Connection::from_backend(backend);
        // Safety: the caller's live wl_surface on this connection.
    // rust: let id = unsafe { ObjectId::from_ptr(WlSurface::interface(), surface.cast()) }.ok()?;
    // rust: let surface = WlSurface::from_id(&conn, id).ok()?;
    // rust: let mut queue: EventQueue<State> = conn.new_event_queue();
    // rust: let qh = queue.handle();
    // rust: let mut state = State::default();
    // rust: let registry = conn.display().get_registry(&qh, ());
    // rust: queue.roundtrip(&mut state).ok()?;
    // rust: let (name, version) = state.manager?;
    // rust: let manager: WpColorManagerV1 = registry.bind(name, version.min(1), &qh, ());
    // rust: let feedback = manager.get_surface_feedback(&surface, &qh, ());
    // rust: Some(Self {
    // rust: queue,
    // rust: state,
    // rust: manager,
    // rust: feedback,
    // rust: })
}

    /// What the compositor says now, if it changed since the last call. Cheap: it only
    /// looks at events the window's own loop already read.
pub fn changed(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.queue.dispatch_pending(&mut self.state).ok()?;
    // rust: if !std::mem::take(&mut self.state.changed) {
    // rust: return None;
}
    // rust: Some(self.query())
}

    /// The surface's preferred description now.
pub fn query(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let qh = self.queue.handle();
    // rust: let state = &mut self.state;
    // rust: (state.ready, state.reference, state.target, state.done) = (None, None, None, false);
    // rust: let description = self.feedback.get_preferred(&qh, ());
    // rust: let found = (|| {
    // rust: while state.ready.is_none() {
    // rust: self.queue.blocking_dispatch(state).ok()?;
}
    // rust: if state.ready != Some(true) {
    // rust: return None;
}
    // rust: let _info = description.get_information(&qh, ());
    // rust: while !state.done {
    // rust: self.queue.blocking_dispatch(state).ok()?;
}
    // rust: let (target_min, target_max) = state.target?;
    // rust: Some(Luminances {
    // rust: reference: state.reference?,
    // rust: target_min,
    // rust: target_max,
    // rust: })
    // rust: })();
    // rust: description.destroy();
    // rust: found
}
}

    // rust: impl Drop for Watch {
pub fn drop(self: *Self) void {
}
    // rust: self.feedback.destroy();
    // rust: self.manager.destroy();
    // rust: let _ = self.queue.flush();
}
}

    // rust: impl Dispatch<wl_registry::WlRegistry, ()> for State {
    // rust: fn event(
    // rust: state: &mut Self,
    // rust: _: &wl_registry::WlRegistry,
    // rust: event: wl_registry::Event,
    // rust: _: &(),
    // rust: _: &Connection,
    // rust: _: &QueueHandle<Self>,
    // rust: ) {
    // rust: if let wl_registry::Event::Global {
    // rust: name,
    // rust: interface,
    // rust: version,
    // rust: } = event
    // rust: && interface == WpColorManagerV1::interface().name
    // rust: {
    // rust: state.manager = Some((name, version));
}
}
}
    // rust: impl Dispatch<WpColorManagerV1, ()> for State {
    // rust: fn event(
    // rust: _: &mut Self,
    // rust: _: &WpColorManagerV1,
    // rust: _: wp_color_manager_v1::Event,
    // rust: _: &(),
    // rust: _: &Connection,
    // rust: _: &QueueHandle<Self>,
    // rust: ) {
}
}
    // rust: impl Dispatch<WpColorManagementSurfaceFeedbackV1, ()> for State {
    // rust: fn event(
    // rust: state: &mut Self,
    // rust: _: &WpColorManagementSurfaceFeedbackV1,
    // rust: event: wp_color_management_surface_feedback_v1::Event,
    // rust: _: &(),
    // rust: _: &Connection,
    // rust: _: &QueueHandle<Self>,
    // rust: ) {
    // rust: if let wp_color_management_surface_feedback_v1::Event::PreferredChanged { .. } = event {
    // rust: state.changed = true;
}
}
}
    // rust: impl Dispatch<WpImageDescriptionV1, ()> for State {
    // rust: fn event(
    // rust: state: &mut Self,
    // rust: _: &WpImageDescriptionV1,
    // rust: event: wp_image_description_v1::Event,
    // rust: _: &(),
    // rust: _: &Connection,
    // rust: _: &QueueHandle<Self>,
    // rust: ) {
    // rust: match event {
    // rust: wp_image_description_v1::Event::Ready { .. } => state.ready = Some(true),
    // rust: wp_image_description_v1::Event::Failed { .. } => state.ready = Some(false),
    // rust: _ => {}
}
}
}
    // rust: impl Dispatch<WpImageDescriptionInfoV1, ()> for State {
    // rust: fn event(
    // rust: state: &mut Self,
    // rust: _: &WpImageDescriptionInfoV1,
    // rust: event: wp_image_description_info_v1::Event,
    // rust: _: &(),
    // rust: _: &Connection,
    // rust: _: &QueueHandle<Self>,
    // rust: ) {
    // rust: match event {
    // rust: wp_image_description_info_v1::Event::Luminances { reference_lum, .. } => {
    // rust: state.reference = Some(reference_lum as f32);
}
    // rust: wp_image_description_info_v1::Event::TargetLuminance { min_lum, max_lum } => {
    // rust: state.target = Some((min_lum as f32 / 10_000.0, max_lum as f32));
}
    // rust: wp_image_description_info_v1::Event::Done => state.done = true,
    // rust: _ => {}
}
}
}
