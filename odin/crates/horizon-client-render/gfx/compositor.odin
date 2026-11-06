//! Transpiled from Horizon Rust crate
package horizon_client_render_compositor

import "core:fmt"
import "core:mem"
import "core:math"

// Splitscreen: several players' renderers draw offscreen on one device, and the
// compositor copies each frame into its place on a window's surface. A window holds views but
// never owns them, so a view can later move to another window (another monitor, detached).
// use super::Renderer;
// use crate::Result;
// use std::sync::Arc;
// use winit::window::Window;

Compositor :: struct {
    surface: wgpu::Surface<'static>,
    device: wgpu::Device,
    queue: wgpu::Queue,
    config: wgpu::SurfaceConfiguration,
    present_modes: [dynamic]wgpu::PresentMode,
    suspended: bool,
}

    // rust: impl Renderer {
    // A compositor for `window` on this renderer's device, presenting on the surface it gave up.
compositor :: proc(self: ^Self, window: ^Window) -> R {
    // Ported from Horizon
    return {}
}
        // The surface this renderer set aside for its successor (`release_surface`), else a new
        // one: a window can't keep two.
    // rust: let spare = self
    // rust: .spare_surface
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .take();
    // rust: let surface = match spare {
    // rust: Some(surface) => surface,
    // rust: None => self.instance.create_surface(window.clone())?,
}
    // rust: Compositor::new(
    // rust: surface,
    // rust: &self.adapter,
    // rust: &self.device,
    // rust: &self.queue,
    // rust: window.inner_size().into(),
    // rust: )
}

    // The last offscreen frame (`--offscreen`), for the compositor.
offscreen_frame :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.offscreen.as_ref()
}

    // Splitscreen turned off: a compositor's surface, set aside for the renderer that draws on
    // the window again (it takes it, as after `release_surface`).
take_back :: proc(self: ^Self, compositor: Compositor) {
}
    // rust: *self
    // rust: .spare_surface
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) = Some(compositor.surface);
}
}

    // rust: impl Compositor {
    // Present offscreen BGRA frames on a compatible surface using their existing device.
    // The surface must support COPY_DST and Bgra8Unorm; unsupported surfaces return an error.
    // rust: pub fn new(
    // rust: surface: wgpu::Surface<'static>,
    // rust: adapter: &wgpu::Adapter,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: size: [u32; 2],
    // rust: ) -> Result<Self> {
    // rust: let caps = surface.get_capabilities(adapter);
        // ponytail: a plain texture copy needs the offscreen frames' format; a blit pass would
        // take any surface format (Rgba8Unorm on some Linux drivers).
    // rust: if !caps.usages.contains(wgpu::TextureUsages::COPY_DST) {
    // rust: return Err("surface does not support copying offscreen frames".into());
}
    // rust: let format = wgpu::TextureFormat::Bgra8Unorm;
    // rust: if !caps.formats.contains(&format) {
    // rust: return Err(format!(
    // rust: "splitscreen needs a {format:?} surface; this one offers {:?}",
    // rust: caps.formats
    // rust: )
    // rust: .into());
}
    // rust: let max = device.limits().max_texture_dimension_2d;
    // rust: let config = wgpu::SurfaceConfiguration {
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_DST,
    // rust: format,
    // rust: width: size[0].clamp(1, max),
    // rust: height: size[1].clamp(1, max),
    // rust: present_mode: wgpu::PresentMode::Fifo,
    // rust: desired_maximum_frame_latency: 2,
    // rust: alpha_mode: wgpu::CompositeAlphaMode::Opaque,
    // rust: view_formats: vec![],
    // rust: color_space: wgpu::SurfaceColorSpace::default(),
}
    // rust: surface.configure(device, &config);
    // rust: Ok(Compositor {
    // rust: surface,
    // rust: device: device.clone(),
    // rust: queue: queue.clone(),
    // rust: config,
    // rust: present_modes: caps.present_modes,
    // rust: suspended: !super::drawable_size(size[0], size[1], max),
    // rust: })
}

    // Vsync on: presents wait for the display. Off: they don't (Mailbox, else Immediate).
set_vsync :: proc(self: ^Self, vsync: bool) {
}
    // rust: let mode = [wgpu::PresentMode::Mailbox, wgpu::PresentMode::Immediate]
    // rust: .into_iter()
    // rust: .find(|m| !vsync && self.present_modes.contains(m))
    // rust: .unwrap_or(wgpu::PresentMode::Fifo);
    // rust: if mode != self.config.present_mode {
    // rust: self.config.present_mode = mode;
    // rust: self.surface.configure(&self.device, &self.config);
}
}

resize :: proc(self: ^Self, width: u32, height: u32) {
}
    // rust: self.suspended =
    // rust: !super::drawable_size(width, height, self.device.limits().max_texture_dimension_2d);
    // rust: if !self.suspended {
    // rust: self.config.width = width;
    // rust: self.config.height = height;
    // rust: self.surface.configure(&self.device, &self.config);
}
}

    // Copy each view's frame to its top-left corner on the window and present. Frames that
    // don't fit are clipped; parts of the window no view covers (a view before its first frame,
    // one still at its old size after a resize) are black. Nothing when the window has no frame
    // to give (occluded, resized, timed out). Returns true when a frame was submitted.
present :: proc(self: ^Self, views: ^[(^wgpu::Texture) {
}
    // rust: if self.suspended {
    // rust: return false;
}
    // rust: let frame = match self.surface.get_current_texture() {
    // rust: wgpu::CurrentSurfaceTexture::Success(f)
    // rust: | wgpu::CurrentSurfaceTexture::Suboptimal(f) => f,
    // rust: wgpu::CurrentSurfaceTexture::Outdated | wgpu::CurrentSurfaceTexture::Lost => {
    // rust: self.surface.configure(&self.device, &self.config);
    // rust: return false;
}
    // rust: _ => return false,
}
    // rust: let mut encoder = self
    // rust: .device
    // rust: .create_command_encoder(&wgpu::CommandEncoderDescriptor {
    // rust: label: Some("Splitscreen compositor"),
    // rust: });
    // rust: let target = frame.texture.create_view(&Default::default());
    // rust: drop(encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Splitscreen compositor clear"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &target,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: }));
    // rust: for &(texture, [x, y]) in views {
    // rust: let [width, height] = clipped_size(
    // rust: [texture.width(), texture.height()],
    // rust: [x, y],
    // rust: [self.config.width, self.config.height],
    // rust: );
    // rust: if width == 0 || height == 0 {
    // rust: continue;
}
    // rust: encoder.copy_texture_to_texture(
    // rust: texture.as_image_copy(),
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: origin: wgpu::Origin3d { x, y, z: 0 },
    // rust: ..frame.texture.as_image_copy()
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
}
    // rust: self.queue.submit([encoder.finish()]);
    // rust: self.queue.present(frame);
    // rust: true
}
}

// Copies never reach past the surface, including while a resized view still has its old frame.
clipped_size :: proc(view: [u32; 2], at: [u32; 2], surface: [u32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: view[0].min(surface[0].saturating_sub(at[0])),
    // rust: view[1].min(surface[1].saturating_sub(at[1])),
    // rust: ]
}

    // rust: mod tests {
//     use super::*;

frames_are_clipped_to_the_window_during_resize :: proc() {
}
    // rust: assert_eq!(clipped_size([640, 480], [0, 0], [1280, 720]), [640, 480]);
    // rust: assert_eq!(
    // rust: clipped_size([640, 480], [1000, 600], [1280, 720]),
    // rust: [280, 120]
    // rust: );
    // rust: assert_eq!(clipped_size([640, 480], [1280, 720], [1280, 720]), [0, 0]);
    // rust: assert_eq!(
    // rust: clipped_size([640, 480], [u32::MAX, 0], [1280, 720]),
    // rust: [0, 480]
    // rust: );
}
}
