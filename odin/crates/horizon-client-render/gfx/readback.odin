//! Transpiled from Horizon Rust crate
package horizon_client_render_readback

import "core:fmt"
import "core:mem"
import "core:math"

// Screenshots of a swapchain that cannot be copied from. OpenGL's surfaces
// offer `RENDER_ATTACHMENT` only, so a frame whose pixels are read back
// (the screenshot key, a world's icon) is drawn into a texture that can be,
// then drawn onto the swapchain image as a fullscreen triangle. A 16-bit frame
// (`Renderer::frame_format`) with HDR output off goes the same way every frame.

// The texture a frame to read back is drawn into, and the pass that puts it
// on the swapchain afterwards.
Readback :: struct {
    texture: Maybe(wgpu::Texture),
    blitter: Option<(wgpu::TextureFormat,
    // A frame drew into `texture` and still has to reach the swapchain.
    drawn: bool,
}

    // rust: impl Readback {
    // The texture this frame draws into instead of the swapchain image
    // `surface`, in the frame's `format`: `None` unless that differs from the
    // swapchain's, or the frame is read back (`screenshot`) and the image
    // cannot be copied from.
    // rust: pub fn target(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: surface: &wgpu::Texture,
    // rust: format: wgpu::TextureFormat,
    // rust: screenshot: bool,
    // rust: ) -> Option<wgpu::Texture> {
    // rust: if format == surface.format().remove_srgb_suffix()
    // rust: && (!screenshot || surface.usage().contains(wgpu::TextureUsages::COPY_SRC))
    // rust: {
    // rust: return None;
}
    // rust: if self
    // rust: .texture
    // rust: .as_ref()
    // rust: .is_none_or(|t| t.size() != surface.size() || t.format() != format)
    // rust: {
    // rust: self.texture = Some(device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Horizon screenshot frame"),
    // rust: size: surface.size(),
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: }));
}
    // rust: self.drawn = true;
    // rust: self.texture.clone()
}

    // Draws the frame `target` gave onto the swapchain image `surface`; nothing
    // when this frame drew straight into it.
    // rust: pub fn present(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: surface: &wgpu::Texture,
    // rust: ) {
    // rust: if !std::mem::take(&mut self.drawn) {
    // rust: return;
}
    // rust: let Some(texture) = self.texture.clone() else {
    // rust: return;
}
    // rust: self.draw_onto(device, encoder, &texture, surface);
}

    // Draws `frame` onto the swapchain image (or offscreen target) `surface`.
    // rust: pub fn draw_onto(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &wgpu::Texture,
    // rust: surface: &wgpu::Texture,
    // rust: ) {
        // The frame's passes write the swapchain through its non-sRGB view
        // (`view_formats`), so the copy goes there unconverted too.
    // rust: let format = surface.format().remove_srgb_suffix();
    // rust: let target = surface.create_view(&wgpu::TextureViewDescriptor {
    // rust: format: Some(format),
    // rust: ..Default::default()
    // rust: });
    // rust: self.blit(device, encoder, frame, &target, format);
}

    // `frame` (a 16-bit frame) in an 8-bit texture of `format`, clamped to 0..1
    // as an 8-bit frame holds it, for a screenshot to read back.
    // rust: pub fn unorm_copy(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &wgpu::Texture,
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> wgpu::Texture {
    // rust: let copy = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Horizon screenshot copy"),
    // rust: size: frame.size(),
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let target = copy.create_view(&Default::default());
    // rust: self.blit(device, encoder, frame, &target, format);
    // rust: copy
}

    // rust: fn blit(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: source: &wgpu::Texture,
    // rust: target: &wgpu::TextureView,
    // rust: format: wgpu::TextureFormat,
    // rust: ) {
    // rust: if self.blitter.as_ref().is_none_or(|b| b.0 != format) {
    // rust: self.blitter = Some((format, wgpu::util::TextureBlitter::new(device, format)));
}
    // rust: let source = source.create_view(&Default::default());
    // rust: if let Some((_, blitter)) = &self.blitter {
    // rust: blitter.copy(device, encoder, &source, target);
}
}
}

    // rust: mod tests {
//     use super::*;

F :: wgpu::TextureFormat::Bgra8Unorm

device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

texture :: proc(device: ^wgpu::Device, usage: wgpu::TextureUsages) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 70,
    // rust: height: 3,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: F,
    // rust: usage,
    // rust: view_formats: &[],
    // rust: })
}

clear :: proc(encoder: ^wgpu::CommandEncoder, texture: ^wgpu::Texture, color: wgpu::Color) {
}
    // rust: let view = texture.create_view(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(color),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
}

read :: proc(device: ^wgpu::Device, buffer: ^wgpu::Buffer) -> V {
    // Ported from Horizon
    return {}
}
    // rust: buffer.map_async(wgpu::MapMode::Read, .., |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: buffer.get_mapped_range(..).unwrap().to_vec()
}

    // The last pixel of the last row of a 70x3 frame read back by `copy_frame`.
last_pixel :: proc(device: ^wgpu::Device, buffer: ^wgpu::Buffer) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let pixels = read(device, buffer);
    // rust: let row = 70usize * 4;
    // rust: let last = row.next_multiple_of(256) * 2 + row - 4;
    // rust: pixels[last..last + 4].to_vec()
}

    // The renderer's screenshot path on a surface like OpenGL's (#3510): the
    // frame is drawn into `target`, read back with `copy_frame` and drawn on
    // the swapchain, with no validation error (the copy used to need the
    // swapchain's missing `COPY_SRC`), and the swapchain shows the frame.
screenshot_of_a_surface_without_copy_src :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
        // Sampled only so the test can look at what reached it.
    // rust: let surface = texture(
    // rust: &device,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: );
    // rust: let check = texture(
    // rust: &device,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let blitter = wgpu::util::TextureBlitter::new(&device, F);
    // rust: let mut readback = Readback::default();
    // rust: let colors = [
    // rust: (1.0, [0, 0, 255, 255]),
            // A second screenshot reuses the texture.
    // rust: (0.0, [255, 0, 0, 255]),
    // rust: ];
    // rust: for (r, bgra) in colors {
    // rust: let color = wgpu::Color {
    // rust: r,
    // rust: g: 0.0,
    // rust: b: 1.0 - r,
    // rust: a: 1.0,
}
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let frame = readback
    // rust: .target(&device, &surface, F, true)
    // rust: .unwrap_or_else(|| surface.clone());
    // rust: clear(&mut encoder, &frame, color);
    // rust: let buffer = crate::gfx::copy_frame(&device, &mut encoder, &frame, [70, 3]);
    // rust: readback.present(&device, &mut encoder, &surface);
    // rust: queue.submit([encoder.finish()]);
    // rust: if let Some(error) = pollster::block_on(scope.pop()) {
    // rust: panic!("{error}");
}
    // rust: assert_eq!(last_pixel(&device, &buffer), bgra);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let view = |t: &wgpu::Texture| t.create_view(&Default::default());
    // rust: blitter.copy(&device, &mut encoder, &view(&surface), &view(&check));
    // rust: let buffer = crate::gfx::copy_frame(&device, &mut encoder, &check, [70, 3]);
    // rust: queue.submit([encoder.finish()]);
    // rust: assert_eq!(last_pixel(&device, &buffer), bgra);
}
    // rust: assert!(!readback.drawn);
}

    // A surface that can be copied from, or a frame nobody reads back,
    // draws straight into the swapchain image.
frames_draw_straight_to_a_readable_surface :: proc() {
}
    // rust: let Some((device, _)) = device() else {
    // rust: return;
}
    // rust: let mut readback = Readback::default();
    // rust: let readable = texture(
    // rust: &device,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: assert!(readback.target(&device, &readable, F, true).is_none());
    // rust: let surface = texture(&device, wgpu::TextureUsages::RENDER_ATTACHMENT);
    // rust: assert!(readback.target(&device, &surface, F, false).is_none());
    // rust: assert!(readback.texture.is_none() && !readback.drawn);
}

    // A 16-bit frame with HDR output off draws into a 16-bit texture of its own, and both
    // the swapchain and a screenshot's 8-bit copy get it clamped as an 8-bit frame holds it.
    // rust: fn reaches_an_8_bit_swapchain(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: format: wgpu::TextureFormat,
    // rust: color: wgpu::Color,
    // rust: expected: [u8; 4],
    // rust: ) {
    // rust: let surface = texture(
    // rust: device,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let mut readback = Readback::default();
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let frame = readback.target(device, &surface, format, false).unwrap();
    // rust: assert_eq!(frame.format(), format);
    // rust: clear(&mut encoder, &frame, color);
    // rust: let copy = readback.unorm_copy(device, &mut encoder, &frame, F);
    // rust: let screenshot = crate::gfx::copy_frame(device, &mut encoder, &copy, [70, 3]);
    // rust: readback.present(device, &mut encoder, &surface);
    // rust: let presented = crate::gfx::copy_frame(device, &mut encoder, &surface, [70, 3]);
    // rust: queue.submit([encoder.finish()]);
    // rust: if let Some(error) = pollster::block_on(scope.pop()) {
    // rust: panic!("{error}");
}
    // rust: assert_eq!(last_pixel(device, &screenshot), expected);
    // rust: assert_eq!(last_pixel(device, &presented), expected);
}

    // `Rgba16Unorm`, the frame HDR output draws into where the device can
    // (`Renderer::frame_format`).
a_16_bit_unorm_frame_reaches_an_8_bit_swapchain :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let wide = wgpu::Features::TEXTURE_FORMAT_16BIT_NORM
    // rust: | wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES;
    // rust: if !adapter.features().contains(wide) {
    // rust: return;
}
    // rust: let descriptor = wgpu::DeviceDescriptor {
    // rust: required_features: wide,
    // rust: ..Default::default()
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&descriptor)) else {
    // rust: return;
}
    // rust: let color = wgpu::Color {
    // rust: r: 1.0,
    // rust: g: 0.2,
    // rust: b: 0.0,
    // rust: a: 1.0,
}
    // rust: let unorm = wgpu::TextureFormat::Rgba16Unorm;
    // rust: reaches_an_8_bit_swapchain(&device, &queue, unorm, color, [0, 51, 255, 255]);
}
}
