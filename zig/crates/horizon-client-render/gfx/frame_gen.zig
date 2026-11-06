//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_frame_gen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Frame generation (a Horizon setting, off by default): FSR 3.1's frame interpolation
//! makes a frame halfway between each two real ones. The world, without the hand and
//! HUD, is kept at the screen's size each frame; optical flow and the interpolation run
//! on it, the hand and HUD are drawn over the made frame as over the real one, and a
//! present thread shows the made frame, then the real one half a real frame later.
//!
//! The renderer draws into frames of its own while this is on; the present thread
//! copies each to the swapchain, which it alone acquires and presents.

    // rust: mod interpolation;
    // rust: mod motion;
    // rust: mod optical_flow;

// use glam::{DMat4, DVec3, Mat4};
// use std::{
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: mpsc,
    // rust: },
    // rust: thread,
    // rust: time::{Duration, Instant},
}

/// Frames to draw into: a pair being drawn, a pair waiting and a pair being shown.
pub const FRAMES: usize = 6;

/// `HORIZON_FRAMEGEN_DEBUG=generated`: show only made frames (AMD's debug view), so a
/// screenshot or an offscreen frame is the made one; `motion`: the same, each made frame
/// showing what moved on its own in blue (its motion vectors in red and green).
    // rust: pub(super) fn generated_only() -> bool {
    // rust: debug().is_some()
}

pub fn debug() O {
    // Implementation ported from Horizon
    return undefined;
}
pub const DEBUG: std::sync::OnceLock<?[]const u8> = std::sync::OnceLock::new();
    // rust: DEBUG
    // rust: .get_or_init(|| {
    // rust: std::env::var("HORIZON_FRAMEGEN_DEBUG")
    // rust: .ok()
    // rust: .filter(|v| v == "generated" || v == "motion")
    // rust: })
    // rust: .as_deref()
}

pub const FrameGen = struct {
    on: bool,
    /// The present thread failed to show a frame (or died): until the renderer has
    /// acquired a frame itself, the normal path runs and handles the surface.
    paused: bool,
    gpu: ?Gpu,
    presenter: ?Presenter,
    /// When the last real frame was handed over, and the time between real frames.
    last: ?Instant,
    interval: Duration,
    /// The last frame's unjittered `view_proj` and camera.
    previous: Option<(DMat4,
    /// The last frame's hand vertices and the bob and view they were drawn with.
    hand: std.ArrayList(crate::mesher::Vertex),
    hand_view: Mat4,
    /// Offscreen, the frame the made frame is drawn into.
    offscreen_generated: ?wgpu::Texture,
    /// Motion vectors for what moves on its own, made on the first frame.
    motion: ?motion::ObjectMotion,
    /// Real frames and made ones handed to the screen since `shown_since`, and the share
    /// of real frames that had a made frame over the last half second (the F3 screen's),
    /// `None` while off.
    real: u32,
    made: u32,
    shown_since: Instant,
    made_share: ?f32,
};

/// What runs on the GPU for one screen size.
pub const Gpu = struct {
    size: [u32,
    flow: optical_flow::OpticalFlow,
    interpolation: interpolation::Interpolation,
    /// This frame's world at the screen's size, and bindings that copy it or the
    /// interpolation's output (`Post::finish_with`).
    world: wgpu::TextureView,
    world_group: wgpu::BindGroup,
    output_group: wgpu::BindGroup,
    /// The next interpolation has no previous frame.
    reset: bool,
};

/// This frame's camera, for the interpolation.
pub const Camera = struct {
    /// The world's projection this frame (with TAA's jitter) and without the jitter.
    jittered: Mat4,
    view_proj: Mat4,
    depth: wgpu::TextureView,
    render_size: [u32,
    jitter: [f32,
    /// This frame's unjittered clip space to the previous frame's, `None` without one.
    reproject: ?Mat4,
    near: f32,
    far: f32,
    fov_y: f32,
};

    // rust: impl FrameGen {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: on: false,
    // rust: paused: false,
    // rust: gpu: None,
    // rust: presenter: None,
    // rust: last: None,
    // rust: interval: Duration::from_millis(16),
    // rust: previous: None,
    // rust: hand: Vec::new(),
    // rust: hand_view: Mat4::IDENTITY,
    // rust: offscreen_generated: None,
    // rust: motion: None,
    // rust: real: 0,
    // rust: made: 0,
    // rust: shown_since: Instant::now(),
    // rust: made_share: None,
}
}

    /// Ends frame generation's frames and present thread: before the surface is
    /// reconfigured or the renderer acquires from it itself.
pub fn stop(self: *Self) void {
}
    // rust: self.presenter = None;
    // rust: self.made_share = None;
    // rust: (self.real, self.made) = (0, 0);
    // rust: self.last = None;
    // rust: self.previous = None;
    // rust: self.hand.clear();
    // rust: if let Some(motion) = &mut self.motion {
    // rust: motion.reset();
}
    // rust: if let Some(gpu) = &mut self.gpu {
    // rust: gpu.reset = true;
}
}

    /// The hand for the made frame, appended to `out`: each vertex halfway between where
    /// it was on screen last frame and where it is now (the hand swings and bobs on its
    /// own, so the world's interpolation can't move it), in this frame's space
    /// (`view`: this frame's bob and view). This frame's hand where the two differ in
    /// shape (another item, the first frame).
    // rust: pub fn halfway_hand(
    // rust: &mut self,
    // rust: hand: &[crate::mesher::Vertex],
    // rust: view: Mat4,
    // rust: out: &mut Vec<crate::mesher::Vertex>,
    // rust: ) {
    // rust: let same = self.hand.len() == hand.len()
    // rust: && self
    // rust: .hand
    // rust: .iter()
    // rust: .zip(hand)
    // rust: .all(|(a, b)| a.layer == b.layer && a.uv == b.uv);
    // rust: if same {
    // rust: let back = view.inverse();
    // rust: out.extend(self.hand.iter().zip(hand).map(|(before, now)| {
    // rust: let then = self.hand_view.transform_point3(before.pos.into());
    // rust: let mid = (then + view.transform_point3(now.pos.into())) * 0.5;
    // rust: crate::mesher::Vertex {
    // rust: pos: back.transform_point3(mid).into(),
    // rust: ..*now
}
    // rust: }));
    // rust: } else {
    // rust: out.extend_from_slice(hand);
}
    // rust: self.hand.clear();
    // rust: self.hand.extend_from_slice(hand);
    // rust: self.hand_view = view;
}

    /// This frame's entity vertices (relative to `camera`) and the entity ids of their
    /// spans (`Frame::entity_motion`), for their own motion vectors; `atlas`: the
    /// entities' textures. Before `generate`, every frame.
    // rust: pub fn track_entities(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: atlas: &wgpu::TextureView,
    // rust: entities: &[crate::mesher::Vertex],
    // rust: spans: &[(u32, u64)],
    // rust: camera: DVec3,
    // rust: ) {
    // rust: self.motion
    // rust: .get_or_insert_with(|| motion::ObjectMotion::new(device, atlas.clone()))
    // rust: .track(entities, spans, camera);
}

    /// This frame's unjittered clip space to the last frame's, from their `view_proj`s
    /// (relative to `camera`); `None` on the first frame.
pub fn camera_motion(self: *Self, view_proj: Mat4, camera: DVec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let current = view_proj.as_dmat4();
    // rust: let previous = self.previous.replace((current, camera));
    // rust: previous.map(|(p, pc)| super::world_post::reprojection(p, pc, current, camera).as_mat4())
}

    /// Frames to draw the real and the made frame into, from the present thread's
    /// (started for this `config`'s surface) or, offscreen, the offscreen target and
    /// one of its own. `None` once the present thread failed or died: it is stopped and
    /// frame generation `paused`.
    // rust: pub fn frames(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: surface: Option<&Arc<wgpu::Surface<'static>>>,
    // rust: offscreen: Option<&wgpu::Texture>,
    // rust: window: &Arc<winit::window::Window>,
    // rust: config: &wgpu::SurfaceConfiguration,
    // rust: ) -> Option<(wgpu::Texture, wgpu::Texture)> {
    // rust: let Some(surface) = surface else {
    // rust: let real = offscreen.cloned().unwrap_or_else(|| frame(device, config));
    // rust: if self
    // rust: .offscreen_generated
    // rust: .as_ref()
    // rust: .is_none_or(|t| t.size() != real.size())
    // rust: {
    // rust: self.offscreen_generated = Some(frame(device, config));
}
    // rust: let generated = self.offscreen_generated.clone().expect("made above");
    // rust: return Some((real, generated));
}
    // rust: if self.presenter.as_ref().is_some_and(|p| p.config != *config) {
    // rust: self.presenter = None;
}
    // rust: let presenter = self.presenter.get_or_insert_with(|| {
    // rust: Presenter::start(device, queue, surface.clone(), window.clone(), config)
    // rust: });
        // A closed channel: the thread died.
    // rust: let pair = if presenter.failed() {
    // rust: None
    // rust: } else {
    // rust: presenter.free.recv().ok().zip(presenter.free.recv().ok())
}
    // rust: if pair.is_none() {
    // rust: self.stop();
    // rust: self.paused = true;
}
    // rust: pair
}

    /// The world's target at the screen's size this frame, where `Post::finish` draws.
    // rust: pub fn world(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: post: &super::world_post::Post,
    // rust: config: &wgpu::SurfaceConfiguration,
    // rust: ) -> wgpu::TextureView {
    // rust: let size = [config.width, config.height];
    // rust: if self.gpu.as_ref().is_none_or(|g| g.size != size) {
    // rust: let world = device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Frame generation world"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: config.format.remove_srgb_suffix(),
                    // COPY_SRC: the interpolation keeps it as the previous frame.
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default());
    // rust: let interpolation = interpolation::Interpolation::new(device, size);
    // rust: self.gpu = Some(Gpu {
    // rust: size,
    // rust: flow: optical_flow::OpticalFlow::new(device, size),
    // rust: world_group: post.bind(device, &world),
    // rust: output_group: post.bind(device, interpolation.output()),
    // rust: interpolation,
    // rust: world,
    // rust: reset: true,
    // rust: });
}
    // rust: self.gpu.as_ref().expect("made above").world.clone()
}

    /// Copy the world (`world`) onto `screen` for the real frame, and draw the made
    /// frame's world onto `generated`. Returns false when there is no made frame (the
    /// first after a reset): `generated` then holds this frame's world too.
    // rust: pub fn generate(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: post: &super::world_post::Post,
    // rust: screen: &wgpu::TextureView,
    // rust: generated: &wgpu::TextureView,
    // rust: camera: &Camera,
    // rust: ) -> bool {
    // rust: let gpu = self.gpu.as_mut().expect("world() ran this frame");
    // rust: post.finish_with(encoder, screen, &gpu.world_group, None);
    // rust: let reset = gpu.reset || camera.reproject.is_none();
    // rust: let reproject = camera.reproject.unwrap_or(Mat4::IDENTITY);
    // rust: let object_motion = self
    // rust: .motion
    // rust: .as_mut()
    // rust: .expect("track_entities() ran this frame")
    // rust: .draw(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: &camera.depth,
    // rust: camera.render_size,
    // rust: camera.jittered,
    // rust: camera.view_proj,
    // rust: reproject * camera.view_proj,
    // rust: );
    // rust: gpu.flow.dispatch(device, queue, encoder, &gpu.world, reset);
    // rust: gpu.interpolation.dispatch(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: &interpolation::Inputs {
    // rust: color: &gpu.world,
    // rust: depth: &camera.depth,
    // rust: render_size: camera.render_size,
    // rust: jitter: camera.jitter,
    // rust: reproject,
    // rust: object_motion: &object_motion,
    // rust: near: camera.near,
    // rust: far: camera.far,
    // rust: fov_y: camera.fov_y,
    // rust: reset,
    // rust: flow_vectors: gpu.flow.vectors(),
    // rust: scene_change: gpu.flow.scene_change(),
    // rust: },
    // rust: );
    // rust: gpu.reset = false;
    // rust: if debug() == Some("motion") {
    // rust: post.finish_with(encoder, generated, &post.bind(device, &object_motion), None);
    // rust: return true;
}
    // rust: if reset {
    // rust: post.finish_with(encoder, generated, &gpu.world_group, None);
    // rust: } else {
    // rust: post.finish_with(encoder, generated, &gpu.output_group, None);
}
    // rust: !reset
}

    /// Hand this frame's pair to the present thread, after the frame's submission: the
    /// made frame (when `made`) goes first.
pub fn present(self: *Self, real: wgpu::Texture, generated: wgpu::Texture, made: bool) void {
}
    // rust: let now = Instant::now();
    // rust: if let Some(last) = self.last {
            // A real frame's time, smoothed: the made frame shows for half of it.
    // rust: let dt = (now - last).min(Duration::from_millis(250));
    // rust: self.interval = self.interval.mul_f32(0.9) + dt.mul_f32(0.1);
}
    // rust: self.last = Some(now);
    // rust: self.real += 1;
    // rust: self.made += u32::from(made && !generated_only());
    // rust: if now - self.shown_since >= Duration::from_millis(500) {
    // rust: self.made_share = Some(self.made as f32 / self.real as f32);
    // rust: (self.real, self.made, self.shown_since) = (0, 0, now);
}
    // rust: let Some(send) = self.presenter.as_ref().and_then(|p| p.send.as_ref()) else {
    // rust: return;
}
    // rust: let pair = if generated_only() {
    // rust: Pair {
    // rust: first: None,
    // rust: second: generated,
    // rust: spare: Some(real),
    // rust: interval: self.interval,
}
    // rust: } else if made {
    // rust: Pair {
    // rust: first: Some(generated),
    // rust: second: real,
    // rust: spare: None,
    // rust: interval: self.interval,
}
    // rust: } else {
    // rust: Pair {
    // rust: first: None,
    // rust: second: real,
    // rust: spare: Some(generated),
    // rust: interval: self.interval,
}
}
    // rust: let _ = send.send(pair);
}
}

/// A frame to draw into, like the swapchain's.
pub fn frame(device: *wgpu::Device, config: *wgpu::SurfaceConfiguration) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Frame generation frame"),
    // rust: size: wgpu::Extent3d {
    // rust: width: config.width,
    // rust: height: config.height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: config.format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &config.view_formats,
    // rust: })
}

/// One real frame's frames for the present thread: `first` (the made frame) now,
/// `second` (the real one) half an `interval` later; `spare` goes straight back.
pub const Pair = struct {
    first: ?wgpu::Texture,
    second: wgpu::Texture,
    spare: ?wgpu::Texture,
    interval: Duration,
};

/// The thread that copies frames to the swapchain and presents them on time.
pub const Presenter = struct {
    config: wgpu::SurfaceConfiguration,
    send: ?mpsc::SyncSender<Pair>,
    free: mpsc::Receiver<wgpu::Texture>,
    /// The surface gave something other than a frame: the renderer takes it back.
    failed: *AtomicBool,
    thread: ?thread::JoinHandle<()>,
};

    // rust: impl Presenter {
    // rust: fn start(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: surface: Arc<wgpu::Surface<'static>>,
    // rust: window: Arc<winit::window::Window>,
    // rust: config: &wgpu::SurfaceConfiguration,
    // rust: ) -> Self {
        // One pair waiting at most: the renderer then waits as for a swapchain image.
    // rust: let (send, receive) = mpsc::sync_channel::<Pair>(1);
    // rust: let (give, free) = mpsc::channel();
    // rust: for _ in 0..FRAMES {
    // rust: let _ = give.send(frame(device, config));
}
    // rust: let (device, queue) = (device.clone(), queue.clone());
    // rust: let vsync = config.present_mode == wgpu::PresentMode::Fifo;
    // rust: let failed = Arc::new(AtomicBool::new(false));
    // rust: let failed_here = failed.clone();
    // rust: let thread = thread::Builder::new()
    // rust: .name("Frame generation present".into())
    // rust: .spawn(move || {
    // rust: let show = |texture: &wgpu::Texture| {
    // rust: if failed_here.load(Ordering::Relaxed) {
    // rust: return;
}
                    // Anything but a frame (outdated, lost, occluded...): the renderer
                    // stops this thread and acquires itself, handling it as it does
                    // without frame generation. A suboptimal frame still shows.
    // rust: let target = match surface.get_current_texture() {
    // rust: wgpu::CurrentSurfaceTexture::Success(t) => t,
    // rust: wgpu::CurrentSurfaceTexture::Suboptimal(t) => {
    // rust: failed_here.store(true, Ordering::Relaxed);
    // rust: t
}
    // rust: _ => {
    // rust: failed_here.store(true, Ordering::Relaxed);
    // rust: return;
}
}
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.copy_texture_to_texture(
    // rust: texture.as_image_copy(),
    // rust: target.texture.as_image_copy(),
    // rust: target.texture.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: if vsync {
    // rust: window.pre_present_notify();
}
    // rust: queue.present(target);
}
    // rust: while let Ok(pair) = receive.recv() {
    // rust: if let Some(first) = pair.first {
    // rust: let shown = Instant::now();
    // rust: show(&first);
    // rust: let _ = give.send(first);
                        // ponytail: sleep pacing; a spin for the last half millisecond
                        // if it shows uneven on some systems.
    // rust: let due = shown + pair.interval / 2;
    // rust: if let Some(wait) = due.checked_duration_since(Instant::now()) {
    // rust: thread::sleep(wait);
}
}
    // rust: show(&pair.second);
    // rust: let _ = give.send(pair.second);
    // rust: if let Some(spare) = pair.spare {
    // rust: let _ = give.send(spare);
}
}
    // rust: })
    // rust: .expect("spawn the frame generation present thread");
    // rust: Self {
    // rust: config: config.clone(),
    // rust: send: Some(send),
    // rust: free,
    // rust: failed,
    // rust: thread: Some(thread),
}
}

    /// The surface failed it or the thread died (a panic).
pub fn failed(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.failed.load(Ordering::Relaxed) || self.thread.as_ref().is_none_or(|t| t.is_finished())
}
}

    // rust: impl Drop for Presenter {
pub fn drop(self: *Self) void {
}
    // rust: self.send = None;
    // rust: if let Some(thread) = self.thread.take() {
    // rust: let _ = thread.join();
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mesher::Vertex;
//     use glam::Vec3;

pub fn vertex(pos: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vertex {
    // rust: pos: pos.into(),
    // rust: ..bytemuck::Zeroable::zeroed()
}
}

    /// A swing lands halfway; a hand still on screen while the camera turns stays still;
    /// another item shows as it is.
pub fn the_made_frame_s_hand_is_halfway_on_screen() void {
}
    // rust: let mut fg = FrameGen::new();
    // rust: let mut out = Vec::new();
    // rust: fg.halfway_hand(
    // rust: &[vertex(Vec3::new(0.0, 0.0, -1.0))],
    // rust: Mat4::IDENTITY,
    // rust: &mut out,
    // rust: );
    // rust: fg.halfway_hand(
    // rust: &[vertex(Vec3::new(0.4, 0.0, -1.0))],
    // rust: Mat4::IDENTITY,
    // rust: &mut out,
    // rust: );
    // rust: assert!((Vec3::from(out[1].pos) - Vec3::new(0.2, 0.0, -1.0)).length() < 1e-6);
        // The camera turned: the vertex turned with it, the same on screen.
    // rust: let turned = Mat4::from_rotation_y(0.3);
    // rust: let on_screen = Vec3::new(0.4, 0.0, -1.0);
    // rust: let pos = turned.inverse().transform_point3(on_screen);
    // rust: fg.halfway_hand(&[vertex(pos)], turned, &mut out);
    // rust: assert!((Vec3::from(out[2].pos) - pos).length() < 1e-6);
    // rust: let mut other = vertex(Vec3::ZERO);
    // rust: other.uv = [0.5, 0.5];
    // rust: fg.halfway_hand(&[other], turned, &mut out);
    // rust: assert_eq!(out[3].pos, [0.0; 3]);
}
}
