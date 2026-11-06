//! Transpiled from Horizon Rust crate
//! Module: horizon-client_no_resources
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A game started without its prepared files (the game build run by hand, not
//! through the launcher): a window that says where to get the launcher
//! (`horizon_client::no_resources`) and quits when it is closed. No loader, no
//! crash report: nothing went wrong in the game.
// use super::*;
// use horizon_client::no_resources::{Action, DOWNLOAD_URL, NoResources};
// use winit::event::MouseButton;

pub const Missing = struct {
    window: ?*Window,
    renderer: ?Renderer,
    gui: UiResources,
    screen: NoResources,
    /// The pointer in physical pixels.
    pointer: (f64,
    api: horizon_client::graphics::GraphicsApi,
    error: ?*dyn std::error::Error,
};

/// Shows the screen until the player closes it.
    // rust: pub(super) fn show(looked_in: &std::path::Path, settings: &Settings) -> Result<()> {
    // rust: let mut app = Missing {
    // rust: window: None,
    // rust: renderer: None,
    // rust: gui: UiResources {
    // rust: atlas: HudAtlas::build(looked_in)?,
    // rust: panorama: Arc::new(horizon_client::gfx::panorama::Faces::colour([0; 4])),
    // rust: },
    // rust: screen: NoResources::new(looked_in),
    // rust: pointer: (0.0, 0.0),
    // rust: api: settings.horizon.api,
    // rust: error: None,
}
    // rust: horizon_client::hud::GUI_SCALE.store(settings.gui_scale, Ordering::Relaxed);
    // rust: EventLoop::new()?.run_app(&mut app)?;
    // rust: app.error.map_or(Ok(()), Err)
}

    // rust: impl Missing {
pub fn size(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.renderer
    // rust: .as_ref()
    // rust: .map_or([1280, 720], |r| [r.config.width, r.config.height])
}

    /// `f` over a Ui of the window's size, the cursor where the pointer is.
    // rust: fn with_ui<R>(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: f: impl FnOnce(&mut horizon_client::ui_theme::Ui) -> R,
    // rust: ) -> R {
    // rust: let cursor = (
    // rust: self.pointer.0 as f32 / batch.scale,
    // rust: self.pointer.1 as f32 / batch.scale,
    // rust: );
    // rust: let mut ui = horizon_client::ui_theme::Ui::new(&self.gui.atlas, batch, cursor);
    // rust: let result = f(&mut ui);
    // rust: ui.finish();
    // rust: result
}

pub fn draw(self: *Self) void {
}
    // rust: let mut batch = HudBatch::new(self.size());
    // rust: self.with_ui(&mut batch, |ui| self.screen.draw(ui));
    // rust: let Some(renderer) = &mut self.renderer else {
    // rust: return;
}
    // rust: match renderer.render(&loading_frame(&batch)) {
    // rust: Ok(true) => return,
    // rust: Ok(false) => {}
    // rust: Err(e) => log::warn!("Horizon: frame failed: {e}"),
}
        // The frame was not shown (the first one often isn't): the glyphs it
        // rasterized never reached the atlas, so draw them again next frame.
    // rust: horizon_client::ui_theme::reset_atlas();
    // rust: if let Some(window) = &self.window {
    // rust: window.request_redraw();
}
}

pub fn click(self: *Self, event_loop: *ActiveEventLoop) void {
}
    // rust: let mut batch = HudBatch::new(self.size());
    // rust: match self.with_ui(&mut batch, |ui| self.screen.click(ui)) {
    // rust: Some(Action::Download) => packs::open_uri(DOWNLOAD_URL),
    // rust: Some(Action::Quit) => event_loop.exit(),
    // rust: None => {}
}
}
}

    // rust: impl ApplicationHandler for Missing {
pub fn resumed(self: *Self, event_loop: *ActiveEventLoop) void {
}
    // rust: if self.window.is_some() {
    // rust: return;
}
    // rust: let attributes = Window::default_attributes()
    // rust: .with_title("Horizon")
    // rust: .with_window_icon(horizon_client::window::icon())
    // rust: .with_inner_size(winit::dpi::LogicalSize::new(1040.0, 700.0));
    // rust: let made = event_loop
    // rust: .create_window(attributes)
    // rust: .map_err(Into::into)
    // rust: .and_then(|window| {
    // rust: let window = Arc::new(window);
    // rust: let renderer = loading_renderer(
    // rust: window.clone(),
    // rust: false,
    // rust: Some(&self.gui.atlas),
    // rust: Some(&self.gui.panorama),
    // rust: None,
    // rust: self.api,
    // rust: )?;
    // rust: Ok((window, renderer))
    // rust: });
    // rust: match made {
    // rust: Ok((window, renderer)) => {
    // rust: window.request_redraw();
    // rust: self.window = Some(window);
    // rust: self.renderer = Some(renderer);
}
    // rust: Err(e) => {
    // rust: self.error = Some(e);
    // rust: event_loop.exit();
}
}
}

pub fn window_event(self: *Self, event_loop: *ActiveEventLoop, id: WindowId, event: WindowEvent) void {
}
    // rust: let Some(window) = self.window.clone().filter(|w| w.id() == id) else {
    // rust: return;
}
    // rust: match event {
    // rust: WindowEvent::CloseRequested => event_loop.exit(),
    // rust: WindowEvent::Resized(size) => {
    // rust: if let Some(r) = &mut self.renderer {
    // rust: r.resize(size.width, size.height);
}
    // rust: window.request_redraw();
}
    // rust: WindowEvent::RedrawRequested => self.draw(),
    // rust: WindowEvent::CursorMoved { position, .. } => {
    // rust: self.pointer = (position.x, position.y);
    // rust: window.request_redraw();
}
    // rust: WindowEvent::MouseInput {
    // rust: state: ElementState::Released,
    // rust: button: MouseButton::Left,
    // rust: ..
    // rust: } => self.click(event_loop),
    // rust: WindowEvent::KeyboardInput { event, .. }
    // rust: if event.state == ElementState::Pressed
    // rust: && event.physical_key == PhysicalKey::Code(KeyCode::Escape) =>
    // rust: {
    // rust: event_loop.exit()
}
    // rust: _ => {}
}
}

pub fn about_to_wait(self: *Self, event_loop: *ActiveEventLoop) void {
}
    // rust: if horizon_threads::stop_requests() > 0 {
    // rust: event_loop.exit();
    // rust: return;
}
        // Wake now and then for Ctrl+C in the console; redraws come with events.
    // rust: event_loop.set_control_flow(ControlFlow::WaitUntil(
    // rust: Instant::now() + Duration::from_millis(250),
    // rust: ));
}
}
