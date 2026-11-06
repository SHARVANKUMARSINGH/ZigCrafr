//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_graphics
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon's own graphics settings, beyond vanilla's options: kept in
//! `horizon-graphics.txt` next to `options.txt` so that file stays exactly
//! vanilla's. Every default reproduces vanilla's rendering; only choices the
//! player makes here depart from it.
// use std::{
    // rust: fs,
    // rust: path::Path,
    // rust: sync::atomic::{AtomicU32, Ordering},
}

pub const FILE: []const u8 = "horizon-graphics.txt";
/// Written beside it before HDR output is switched on and removed once the first HDR frame is
/// presented. Found at the next start, it means HDR output took the game down, so HDR starts off.
pub const HDR_MARKER: []const u8 = "horizon-hdr-pending";

/// What the system reports for the display HDR output goes to, in nits in HDR output's
/// scale: where its SDR white sits (the desktop's white) and the peak.
pub const Reported = struct {
    paper_white: u32,
    peak: u32,
    /// The display's darkest black, in hundredths of a nit.
    black: u32,
};

pub const REPORTED: [AtomicU32; 3] = [AtomicU32::new(0), AtomicU32::new(0), AtomicU32::new(0)];

/// Sets what the system reports (the renderer, when it opens its surface).
pub fn report(reported: ?Reported) void {
}
    // rust: let (paper_white, peak, black) =
    // rust: reported.map_or((0, 0, 0), |r| (r.paper_white, r.peak, r.black));
    // rust: REPORTED[0].store(paper_white, Ordering::Relaxed);
    // rust: REPORTED[1].store(peak, Ordering::Relaxed);
    // rust: REPORTED[2].store(black, Ordering::Relaxed);
}
/// What the system reports, if it does.
pub fn reported() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [paper_white, peak, black] = REPORTED.each_ref().map(|n| n.load(Ordering::Relaxed));
    // rust: (peak > 0).then_some(Reported {
    // rust: paper_white,
    // rust: peak,
    // rust: black,
    // rust: })
}

/// Simple-level presets. `Custom` leaves every option as the player set it.
pub const Preset = enum {
    Performance,
    Balanced,
    Quality,
    Ultra,
    Custom,
};
    // rust: impl Preset {
    // rust: pub const ALL: [Preset; 5] = [
    // rust: Preset::Performance,
    // rust: Preset::Balanced,
    // rust: Preset::Quality,
    // rust: Preset::Ultra,
    // rust: Preset::Custom,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Preset::Performance => "performance",
    // rust: Preset::Balanced => "balanced",
    // rust: Preset::Quality => "quality",
    // rust: Preset::Ultra => "ultra",
    // rust: Preset::Custom => "custom",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Preset::Performance => "Performance",
    // rust: Preset::Balanced => "Balanced",
    // rust: Preset::Quality => "Quality",
    // rust: Preset::Ultra => "Ultra",
    // rust: Preset::Custom => "Custom",
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|p| p.name() == s)
    // rust: .unwrap_or_default()
}
}

/// Entity occlusion strategy. The synchronous mode preserves the original
/// same-frame CPU test; asynchronous results only hide a mesh when their
/// camera, bounds and occluder evidence still match.
pub const EntityCullingMode = enum {
    Off,
    Synchronous,
    Asynchronous,
};
    // rust: impl EntityCullingMode {
    // rust: pub const ALL: [EntityCullingMode; 3] = [
    // rust: EntityCullingMode::Off,
    // rust: EntityCullingMode::Synchronous,
    // rust: EntityCullingMode::Asynchronous,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Off => "off",
    // rust: Self::Synchronous => "sync",
    // rust: Self::Asynchronous => "async",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Off => "Off",
    // rust: Self::Synchronous => "Synchronous",
    // rust: Self::Asynchronous => "Asynchronous",
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match s {
            // Keep graphics files written before the mode selector readable.
    // rust: "true" | "synchronous" | "sync" => Self::Synchronous,
    // rust: "false" | "off" => Self::Off,
    // rust: "asynchronous" | "async" => Self::Asynchronous,
    // rust: _ => Self::default(),
}
}
}

/// Particle visibility strategy, independent of Entity Culling.
pub const ParticleCullingMode = enum {
    Off,
    Synchronous,
    Asynchronous,
};
    // rust: impl ParticleCullingMode {
    // rust: pub const ALL: [ParticleCullingMode; 3] = [
    // rust: ParticleCullingMode::Off,
    // rust: ParticleCullingMode::Synchronous,
    // rust: ParticleCullingMode::Asynchronous,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Off => "off",
    // rust: Self::Synchronous => "sync",
    // rust: Self::Asynchronous => "async",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Off => "Off",
    // rust: Self::Synchronous => "Synchronous",
    // rust: Self::Asynchronous => "Asynchronous",
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match s {
    // rust: "synchronous" | "sync" => Self::Synchronous,
    // rust: "asynchronous" | "async" => Self::Asynchronous,
    // rust: "off" => Self::Off,
    // rust: _ => Self::default(),
}
}
}

/// How the swapchain presents frames.
pub const PresentMode = enum {
    /// Vanilla's choice: Fifo with VSync on, else the first of Immediate,
    /// Mailbox and Fifo the surface supports. The other modes apply only
    /// with VSync off: VSync on always presents with Fifo.
    Auto,
    Fifo,
    Mailbox,
    Immediate,
};
    // rust: impl PresentMode {
    // rust: pub const ALL: [PresentMode; 4] = [
    // rust: PresentMode::Auto,
    // rust: PresentMode::Fifo,
    // rust: PresentMode::Mailbox,
    // rust: PresentMode::Immediate,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: PresentMode::Auto => "auto",
    // rust: PresentMode::Fifo => "fifo",
    // rust: PresentMode::Mailbox => "mailbox",
    // rust: PresentMode::Immediate => "immediate",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: PresentMode::Auto => "Auto (VSync)",
    // rust: PresentMode::Fifo => "FIFO",
    // rust: PresentMode::Mailbox => "Mailbox",
    // rust: PresentMode::Immediate => "Immediate",
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|p| p.name() == s)
    // rust: .unwrap_or_default()
}
}

/// The graphics API the renderer runs on. Windows picks Vulkan, DirectX 12 or
/// OpenGL; Linux picks Vulkan or OpenGL; macOS always uses its one backend
/// (Metal). Applies at the next start.
pub const GraphicsApi = enum {
    /// Vulkan, then DirectX 12 (Windows), then OpenGL when neither has a surface, adapter or device.
    Auto,
    Vulkan,
    Dx12,
    /// OpenGL, for GPUs with no Vulkan or DirectX 12 driver (Windows and Linux).
    OpenGl,
};
    // rust: impl GraphicsApi {
    // rust: pub const ALL: [GraphicsApi; 4] = [
    // rust: GraphicsApi::Auto,
    // rust: GraphicsApi::Vulkan,
    // rust: GraphicsApi::Dx12,
    // rust: GraphicsApi::OpenGl,
    // rust: ];
    /// The APIs this system offers, in the order the setting cycles through
    /// them: DirectX 12 is Windows' third backend, and macOS has no choice.
pub fn choices() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const WINDOWS: [GraphicsApi; 4] = [
    // rust: GraphicsApi::Auto,
    // rust: GraphicsApi::Vulkan,
    // rust: GraphicsApi::Dx12,
    // rust: GraphicsApi::OpenGl,
    // rust: ];
    // rust: const LINUX: [GraphicsApi; 3] =
    // rust: [GraphicsApi::Auto, GraphicsApi::Vulkan, GraphicsApi::OpenGl];
pub const MACOS: [GraphicsApi; 1] = [GraphicsApi::Auto];
    // rust: if cfg!(windows) {
    // rust: &WINDOWS
    // rust: } else if cfg!(target_os = "macos") {
    // rust: &MACOS
    // rust: } else {
    // rust: &LINUX
}
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: GraphicsApi::Auto => "auto",
    // rust: GraphicsApi::Vulkan => "vulkan",
    // rust: GraphicsApi::Dx12 => "dx12",
    // rust: GraphicsApi::OpenGl => "opengl",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: GraphicsApi::Auto => "Auto",
    // rust: GraphicsApi::Vulkan => "Vulkan",
    // rust: GraphicsApi::Dx12 => "DirectX 12",
    // rust: GraphicsApi::OpenGl => "OpenGL",
}
}
    /// The API a name stands for, ignoring case; `None` for anything else.
pub fn from_name(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|api| api.name().eq_ignore_ascii_case(s.trim()))
}
    /// `HORIZON_GRAPHICS_API` (auto, vulkan, dx12 or opengl) if set, else the setting.
pub fn with_env(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var("HORIZON_GRAPHICS_API")
    // rust: .ok()
    // rust: .and_then(|v| Self::from_name(&v))
    // rust: .unwrap_or(self)
}
}

/// What the frame limiter does in the last half millisecond before a frame.
pub const Pacing = enum {
    /// Sleep the whole wait: no CPU spent spinning, a little less precise; frames
    /// keep to a fixed grid of slots, so late wake-ups don't lower the frame rate.
    Efficient,
    /// Vanilla's `FramerateLimiter`: sleep, then spin until the deadline.
    Precise,
};

/// The performance overlay drawn over the HUD.
pub const Overlay = enum {
    Off,
    /// Frames per second and frame time.
    Fps,
    /// The numbers and a graph of recent frame times.
    Graph,
};

/// How finely far terrain is drawn (`FarDetail` in the LOD options).
pub const FarDetail = enum {
    /// Each tile level starts at eight times its size from the camera.
    Full,
    /// Coarser levels start at half that distance: about a quarter of the
    /// far quads, for GPUs that far terrain slows down. Changes the picture.
    Reduced,
};
    // rust: impl FarDetail {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: FarDetail::Full => "full",
    // rust: FarDetail::Reduced => "reduced",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: FarDetail::Full => "Full",
    // rust: FarDetail::Reduced => "Reduced",
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if s == "reduced" {
    // rust: FarDetail::Reduced
    // rust: } else {
    // rust: FarDetail::Full
}
}
}

/// Frame generation: a frame made between each two real ones.
pub const FrameGeneration = enum {
    Off,
    /// AMD FidelityFX Super Resolution 3.1's frame interpolation, ported to WGSL.
    Fsr31,
};
    // rust: impl FrameGeneration {
pub const ALL: [FrameGeneration; 2] = [FrameGeneration::Off, FrameGeneration::Fsr31];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: FrameGeneration::Off => "off",
    // rust: FrameGeneration::Fsr31 => "fsr3.1",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: FrameGeneration::Off => "Off",
    // rust: FrameGeneration::Fsr31 => "FSR 3.1",
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|f| f.name() == s)
    // rust: .unwrap_or_default()
}
}

/// What the section mesher does with leaf faces inside a canopy. Terrain
/// geometry only: entities, particles and block entities are untouched.
pub const LeafCullingMode = enum {
    /// Every leaf face, as vanilla's fancy leaves draw them.
    Off,
    /// Drops a face between two leaves when the leaf it faces has a leaf or
    /// a full opaque cube behind it too: that face only shows through two
    /// cutout layers. The faces behind the outer layer stay, so a crown
    /// looks the same from outside. The faced leaf must be in the section
    /// (as `Hollow`), so the block behind it is at most a border cell of the
    /// next section, whose edits remesh this one.
    Hidden,
    /// Leaves surrounded on all six sides by leaves or full opaque cubes draw
    /// in the opaque layer, so their cutouts no longer show the layers behind.
    Solid,
    /// Like `Solid`, but a leaf with one open side draws opaque too: the
    /// exposed shell thins by a layer and the canopy looks chunkier.
    SolidAggressive,
    /// Drops the faces two leaves share. Faces toward air, cavities, partial
    /// models, unknown neighbours and section boundaries stay.
    Hollow,
};
    // rust: impl LeafCullingMode {
    // rust: pub const ALL: [LeafCullingMode; 5] = [
    // rust: LeafCullingMode::Off,
    // rust: LeafCullingMode::Hidden,
    // rust: LeafCullingMode::Solid,
    // rust: LeafCullingMode::SolidAggressive,
    // rust: LeafCullingMode::Hollow,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: LeafCullingMode::Off => "off",
    // rust: LeafCullingMode::Hidden => "hidden",
    // rust: LeafCullingMode::Solid => "solid",
    // rust: LeafCullingMode::SolidAggressive => "solid_aggressive",
    // rust: LeafCullingMode::Hollow => "hollow",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: LeafCullingMode::Off => "Off",
    // rust: LeafCullingMode::Hidden => "Hidden Faces",
    // rust: LeafCullingMode::Solid => "Solid",
    // rust: LeafCullingMode::SolidAggressive => "Solid Aggressive",
    // rust: LeafCullingMode::Hollow => "Hollow",
}
}
    /// Whether this mode draws interior leaf faces in the solid layer.
pub fn is_interior(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self,
    // rust: LeafCullingMode::Solid | LeafCullingMode::SolidAggressive
    // rust: )
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|mode| mode.name() == s)
    // rust: .unwrap_or_default()
}
}

/// TAA upscaling: the world renders this much smaller than the resolution scale's size,
/// and TAA builds the full-size picture from the jittered frames (FSR's and DLSS's ratios).
pub const Upscaling = enum {
    Native,
    Quality,
    Balanced,
    Performance,
    UltraPerformance,
};
    // rust: impl Upscaling {
    // rust: pub const ALL: [Upscaling; 5] = [
    // rust: Upscaling::Native,
    // rust: Upscaling::Quality,
    // rust: Upscaling::Balanced,
    // rust: Upscaling::Performance,
    // rust: Upscaling::UltraPerformance,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Upscaling::Native => "native",
    // rust: Upscaling::Quality => "quality",
    // rust: Upscaling::Balanced => "balanced",
    // rust: Upscaling::Performance => "performance",
    // rust: Upscaling::UltraPerformance => "ultraPerformance",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Upscaling::Native => "Native",
    // rust: Upscaling::Quality => "Quality",
    // rust: Upscaling::Balanced => "Balanced",
    // rust: Upscaling::Performance => "Performance",
    // rust: Upscaling::UltraPerformance => "Ultra Performance",
}
}
    /// Output pixels per rendered pixel, along each axis.
pub fn ratio(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Upscaling::Native => 1.0,
    // rust: Upscaling::Quality => 1.5,
    // rust: Upscaling::Balanced => 1.7,
    // rust: Upscaling::Performance => 2.0,
    // rust: Upscaling::UltraPerformance => 3.0,
}
}
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|u| u.name() == s)
    // rust: .unwrap_or_default()
}
}

pub const REDUCED_SUGGESTED: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);
/// Whether the settings suggest Reduced far detail: set when the renderer
/// starts, on the GPUs `lod_capped` names (far terrain slows them most).
pub fn suggest_reduced_far_detail(on: bool) void {
}
    // rust: REDUCED_SUGGESTED.store(on, std::sync::atomic::Ordering::Relaxed);
}
pub fn reduced_far_detail_suggested() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: REDUCED_SUGGESTED.load(std::sync::atomic::Ordering::Relaxed)
}

/// The name the options screen waits on to bind `Graphics::hdr_key`.
pub const HDR_KEY: []const u8 = "horizon.hdrSettings";
/// The Screenshot Quality choices, times the game's resolution.
pub const SCREENSHOT_QUALITIES: [u32; 4] = [1, 2, 4, 8];
pub const HDR_OFFERED: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);
/// Whether the display path offers HDR output (HDR10 or scRGB): set when the renderer
/// opens its surface; the settings open HDR's screen only then.
pub fn offer_hdr(on: bool) void {
}
    // rust: HDR_OFFERED.store(on, std::sync::atomic::Ordering::Relaxed);
}
pub fn hdr_offered() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HDR_OFFERED.load(std::sync::atomic::Ordering::Relaxed)
}

    // rust: static TRANSLUCENT_BATCHING_OFFERED: std::sync::atomic::AtomicBool =
    // rust: std::sync::atomic::AtomicBool::new(false);
/// Whether the device can batch translucent quads (`Graphics::translucent_batching`): set when
/// the renderer starts; not without indirect multi-draw or on OpenGL, which loops over a
/// multi-draw's entries on the CPU, nor where vanilla frames draw flat (they read the section
/// arena's translucent quads). Where it can't, the settings grey its switch out.
pub fn offer_translucent_batching(on: bool) void {
}
    // rust: TRANSLUCENT_BATCHING_OFFERED.store(on, std::sync::atomic::Ordering::Relaxed);
}
pub fn translucent_batching_offered() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TRANSLUCENT_BATCHING_OFFERED.load(std::sync::atomic::Ordering::Relaxed)
}

    // rust: static SMOOTH_GRADIENTS_OFFERED: std::sync::atomic::AtomicBool =
    // rust: std::sync::atomic::AtomicBool::new(false);
/// Whether the device can draw, blend and filter the 16-bit frame (`Graphics::hdr_smooth_gradients`):
/// set when the renderer starts. Where it can't, the settings grey its switch out.
pub fn offer_smooth_gradients(on: bool) void {
}
    // rust: SMOOTH_GRADIENTS_OFFERED.store(on, std::sync::atomic::Ordering::Relaxed);
}
pub fn smooth_gradients_offered() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SMOOTH_GRADIENTS_OFFERED.load(std::sync::atomic::Ordering::Relaxed)
}

/// Whether GPU Culling (`Graphics::gpu_culling`) can be switched on here, and why not: set when a
/// renderer starts, and again when its pass can't be set up or its buffers stop fitting in video
/// memory. Where it isn't offered the settings grey its switch out with the reason, and the saved
/// value waits for a renderer that offers it.
pub const GpuCullingOffer = enum {
    /// No count draws the GPU wrote, compute shaders or working first instances (OpenGL, Metal,
    /// Vulkan without `VK_KHR_draw_indirect_count`, Intel Gen11/Gen12's Vulkan driver), vanilla
    /// frames drawn flat, or a pass the driver couldn't build.
    Unsupported = 0,
    /// A software adapter (WARP, lavapipe): the pass would run on the CPU, beside the frame.
    Software = 1,
    /// Its buffers stopped fitting in video memory: off until the next renderer.
    OutOfMemory = 2,
    /// DX12 with flat page groups, whose count draws leave each draw's base vertex out of
    /// what the near sections' packed faces are read by (`gpu_culling::loses_base_vertex`).
    Dx12 = 3,
    /// The graphics device was lost while its frames were drawn (`lose_gpu_culling`): off
    /// for the renderers after it, until Horizon restarts.
    DeviceLost = 5,
    Offered = 4,
};
    // rust: impl GpuCullingOffer {
    /// The greyed switch's tooltip; `None` where it is offered.
pub fn reason(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Unsupported => Some("Your GPU or graphics API doesn't support it."),
    // rust: Self::Software => Some("Not with software rendering, which runs it on the CPU."),
    // rust: Self::OutOfMemory => Some("Out of video memory: off until the next start."),
    // rust: Self::Dx12 => Some("Not on DirectX 12 yet: try the Vulkan graphics API."),
    // rust: Self::DeviceLost => Some("The graphics device was lost: off until the next start."),
    // rust: Self::Offered => None,
}
}
}
    // rust: static GPU_CULLING_OFFER: std::sync::atomic::AtomicU8 =
    // rust: std::sync::atomic::AtomicU8::new(GpuCullingOffer::Unsupported as u8);
pub fn offer_gpu_culling(offer: GpuCullingOffer) void {
}
    // rust: GPU_CULLING_OFFER.store(offer as u8, std::sync::atomic::Ordering::Relaxed);
}
pub fn gpu_culling_offer() G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match GPU_CULLING_OFFER.load(std::sync::atomic::Ordering::Relaxed) {
    // rust: 1 => GpuCullingOffer::Software,
    // rust: 2 => GpuCullingOffer::OutOfMemory,
    // rust: 3 => GpuCullingOffer::Dx12,
    // rust: 4 => GpuCullingOffer::Offered,
    // rust: 5 => GpuCullingOffer::DeviceLost,
    // rust: _ => GpuCullingOffer::Unsupported,
}
}
/// Set once the graphics device was lost while GPU culling drew the frames (the game's
/// `recover_device`): the renderers made after it don't offer it (`GpuCullingOffer::DeviceLost`),
/// so a fault in its frames can't lose the device again after every recovery.
pub const GPU_CULLING_LOST: std::sync::atomic::AtomicBool = std::sync::atomic::AtomicBool::new(false);
pub fn lose_gpu_culling() void {
}
    // rust: GPU_CULLING_LOST.store(true, std::sync::atomic::Ordering::Relaxed);
}
pub fn gpu_culling_lost() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: GPU_CULLING_LOST.load(std::sync::atomic::Ordering::Relaxed)
}

/// The farthest LOD Distance, in chunks, on integrated GPUs other than
/// Apple's: they share the CPU's memory bandwidth, and past it far terrain
/// costs them more frame time than it is worth.
pub const INTEGRATED_LOD_DISTANCE: u32 = 128;
/// Whether `INTEGRATED_LOD_DISTANCE` applies to this adapter. Apple's GPUs
/// are integrated too, with memory and bandwidth enough for every distance.
pub fn lod_capped(info: *wgpu::AdapterInfo) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: info.device_type == wgpu::DeviceType::IntegratedGpu && !info.name.starts_with("Apple")
}
/// A LOD distance as far terrain uses it on this adapter.
pub fn lod_distance_capped(distance: u32, info: *wgpu::AdapterInfo) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let distance = distance.min(crate::lod::MAX_CHUNKS);
    // rust: if lod_capped(info) {
    // rust: distance.min(INTEGRATED_LOD_DISTANCE)
    // rust: } else {
    // rust: distance
}
}
    // rust: impl Graphics {
    /// `lod_distance` as far terrain uses it on this adapter.
pub fn lod_distance_on(self: *Self, info: *wgpu::AdapterInfo) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lod_distance_capped(self.lod_distance, info)
}
    /// Whether the selected packs leave vanilla's block models in place.
    /// Horizon's occlusion assumptions (entity and leaf culling) hold only
    /// for those: a pack can replace an opaque cube's model or a leaf's.
pub fn vanilla_models(self: *Self, resource_packs: *[[]const u8]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: resource_packs.iter().all(|id| id == "vanilla")
}
    /// The same check including packs overlaid by the connected server.
    /// Their ids are namespaced as `server/...`, so an active server pack
    /// disables model-dependent occlusion assumptions.
    // rust: pub fn vanilla_models_with_server_packs<'a>(
    // rust: &self,
    // rust: resource_packs: impl IntoIterator<Item = &'a str>,
    // rust: server_packs: impl IntoIterator<Item = &'a str>,
    // rust: ) -> bool {
    // rust: resource_packs
    // rust: .into_iter()
    // rust: .chain(server_packs)
    // rust: .all(|id| id == "vanilla")
}
    /// The leaf culling the mesher may apply. A pack that can replace leaf
    /// models falls back to `Off`, which draws exactly vanilla's leaves.
pub fn leaf_culling_effective(self: *Self, resource_packs: *[[]const u8]) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.vanilla_models(resource_packs) {
    // rust: self.leaf_culling
    // rust: } else {
    // rust: LeafCullingMode::Off
}
}
    /// The effective mode when local and server resource packs are active.
    // rust: pub fn leaf_culling_effective_with_server_packs<'a>(
    // rust: &self,
    // rust: resource_packs: impl IntoIterator<Item = &'a str>,
    // rust: server_packs: impl IntoIterator<Item = &'a str>,
    // rust: ) -> LeafCullingMode {
    // rust: if self.vanilla_models_with_server_packs(resource_packs, server_packs) {
    // rust: self.leaf_culling
    // rust: } else {
    // rust: LeafCullingMode::Off
}
}
}
pub const Graphics = struct {
    preset: Preset,
    /// Distant surface terrain range, in chunks; 0 disables LODs.
    lod_distance: u32,
    /// How finely far terrain is drawn; Full unless the player picks Reduced.
    far_detail: FarDetail,
    /// Far terrain from servers' BlueMap web maps; no server has one unless
    /// the player names it (`blueMap:` lines) or turns on auto-detect.
    blue_map: crate::bluemap::Settings,
    /// Skip sections hidden behind closed ones (vanilla's occlusion graph).
    cave_culling: bool,
    /// Near solid terrain culled, and its draws listed, on the GPU (`gfx::gpu_culling`), where it
    /// is offered (`gpu_culling_offer`). Off by default (GPU Culling, Performance graphics); it
    /// applies at once, and no preset sets it. Every save writes it, so a default turned on later
    /// needs a new key, as `batchTranslucent` did.
    gpu_culling: bool,
    /// Skip drawing entities hidden behind opaque terrain, synchronously or asynchronously.
    entity_culling: EntityCullingMode,
    /// Minimum entity population for coarse AABB culling; zero disables it.
    entity_culling_precheck: u32,
    /// Skip particles outside the view or hidden behind opaque terrain.
    particle_culling: ParticleCullingMode,
    /// Terrain leaf faces inside a canopy (see [`LeafCullingMode`]); `Off` draws
    /// vanilla's fancy leaves. Ignored with a resource pack that may replace
    /// the vanilla leaf models ([`Graphics::leaf_culling_effective`]).
    leaf_culling: LeafCullingMode,
    /// Cache settled shulker-box models.
    cache_shulker_boxes: bool,
    /// Cache sign-text geometry.
    cache_signs: bool,
    /// Cache decorated pots outside their wobble animation.
    cache_decorated_pots: bool,
    /// Cache bells while they are not ringing.
    cache_bells: bool,
    /// Cache closed chests, including copper variants.
    cache_chests: bool,
    /// Cache banner poles while leaving their flags animated.
    cache_banners: bool,
    /// Cache copper-golem statue models.
    cache_copper_golem_statues: bool,
    /// Meshed sections uploaded per frame; 0 uploads all that are ready.
    chunk_updates: u32,
    /// Section mesh bytes uploaded per frame, in KiB; 0 is unlimited.
    upload_budget_kib: u32,
    /// The block textures' video memory (their top mip level), in MiB; 0 leaves it to
    /// Horizon (`sprites::DEFAULT_TEXTURE_BUDGET`). Applies when resources next load.
    texture_budget_mib: u32,
    sky: bool,
    fog: bool,
    weather: bool,
    animated_textures: bool,
    /// Dithers the small mip levels of cutouts from 64 texels up, so a high-resolution pack's
    /// fine plants keep their coverage in the distance; off is vanilla's look.
    dither_cutout_mips: bool,
    present_mode: PresentMode,
    pacing: Pacing,
    /// Chunk worker threads; 0 uses every core but one. Applies at the next start.
    workers: u32,
    overlay: Overlay,
    /// World resolution as a percentage of the window's (50..=200).
    resolution_scale: u32,
    /// FXAA over the world.
    fxaa: bool,
    /// TAA over the world (FXAA is off while it is on).
    taa: bool,
    /// TAA upscaling; anything but `Native` comes with `taa` on.
    upscaling: Upscaling,
    /// F2 screenshots at this many times the game's resolution: 1, 2, 4 or 8.
    screenshot_quality: u32,
    /// Frame generation (Horizon setting), off by default.
    frame_generation: FrameGeneration,
    /// HDR output (HDR10, or scRGB), where the display path offers it.
    hdr: bool,
    /// HDR paper white (where SDR white sits), in nits; 0 is Auto: the desktop's SDR
    /// white, as the system reports it ([`Graphics::paper_white_nits`]).
    hdr_paper_white: u32,
    /// HDR peak brightness the world's highlights reach, in nits; 0 is Auto:
    /// what the system reports for the display ([`Graphics::peak_nits`]).
    hdr_peak: u32,
    /// HDR black level: the display's darkest black, in hundredths of a nit; 0 is Auto:
    /// what the system reports, else true black. Shadows are lifted onto it, and the HDR
    /// metadata says it.
    hdr_black_level: u32,
    /// HDR brightness of the HUD and menus, in percent of paper white (25..=100); the
    /// first-person hand stays at the world's.
    hdr_ui_brightness: u32,
    /// HDR Lighting: Horizon's own HDR look, light sources, the sun and sunlight above paper
    /// white. Off, HDR output shows the same picture as SDR, for shader packs or the vanilla look.
    hdr_lighting: bool,
    /// A vanilla key name (`HDR_KEY`): opens HDR's settings from the game. Unbound by default.
    hdr_key: []const u8,
    /// Battery mode: at most 60 frames per second in a world and 30 in menus
    /// or behind other windows, and half the worker threads. Off by default;
    /// it changes when frames are drawn, never what they show or the ticks.
    battery: bool,
    /// Reuse the shader pack's last shadow map when sun, view, scene revision and
    /// pack uniforms still match. Off by default: vanilla loaders redraw every frame
    /// (or every `shadowInterval`), and a hit with a stale key shows old shadows.
    shadow_cache: bool,
    /// The graphics API (Windows only; see `GraphicsApi`).
    api: GraphicsApi,
    /// Translucent quads in vertex buffers of their own (`gfx`'s translucent arena), so their
    /// back-to-front draws go out in a few calls, for a little more video memory. On by
    /// default (Translucent Batching, Advanced graphics); read when a renderer is made (start,
    /// resource-pack reload), where it is offered (`translucent_batching_offered`). Its key is
    /// `batchTranslucent`: `translucentBatching`, which every save wrote as false while it was
    /// off by default and had no switch, stays ignored.
    translucent_batching: bool,
    /// Smooth Gradients (HDR page, on by default): with HDR output on, the frame is drawn in
    /// 16 bits, so dark gradients don't band (`Renderer::frame_format`). Read when a renderer
    /// is made (start, resource-pack reload), like `translucent_batching`, where it is offered
    /// (`smooth_gradients_offered`).
    hdr_smooth_gradients: bool,
    /// The shader pack picked in `shaderpacks/` (`shader_pack_list`); empty: none. Its key is
    /// not `shaderPack`, which versions before the clean-room rewrite saved and which stays
    /// ignored.
    shader_pack: []const u8,
};
    // rust: impl Default for Graphics {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: preset: Preset::Custom,
    // rust: lod_distance: 0,
    // rust: far_detail: FarDetail::Full,
    // rust: blue_map: crate::bluemap::Settings::default(),
    // rust: cave_culling: true,
    // rust: gpu_culling: false,
    // rust: entity_culling: EntityCullingMode::Off,
    // rust: entity_culling_precheck: 64,
    // rust: particle_culling: ParticleCullingMode::Off,
    // rust: leaf_culling: LeafCullingMode::Off,
    // rust: cache_shulker_boxes: false,
            // Sign text has used its renderer cache independently of the new model caches.
    // rust: cache_signs: true,
    // rust: cache_decorated_pots: false,
    // rust: cache_bells: false,
    // rust: cache_chests: false,
    // rust: cache_banners: false,
    // rust: cache_copper_golem_statues: false,
    // rust: chunk_updates: 0,
    // rust: upload_budget_kib: 0,
    // rust: texture_budget_mib: 0,
    // rust: sky: true,
    // rust: fog: true,
    // rust: weather: true,
    // rust: animated_textures: true,
    // rust: dither_cutout_mips: false,
    // rust: present_mode: PresentMode::Auto,
    // rust: pacing: Pacing::Efficient,
    // rust: workers: 0,
    // rust: overlay: Overlay::Off,
    // rust: resolution_scale: 100,
    // rust: fxaa: false,
    // rust: taa: false,
    // rust: upscaling: Upscaling::Native,
    // rust: screenshot_quality: 1,
    // rust: frame_generation: FrameGeneration::Off,
    // rust: hdr: false,
    // rust: hdr_paper_white: 0,
    // rust: hdr_peak: 0,
    // rust: hdr_black_level: 0,
    // rust: hdr_ui_brightness: 100,
    // rust: hdr_lighting: true,
    // rust: hdr_key: "key.keyboard.unknown".into(),
    // rust: battery: false,
    // rust: shadow_cache: false,
    // rust: api: GraphicsApi::Auto,
    // rust: translucent_batching: true,
    // rust: hdr_smooth_gradients: true,
    // rust: shader_pack: String::new(),
}
}
}
pub fn bool_text(v: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v { "true" } else { "false" }
}
    // rust: impl Graphics {
pub fn load(dir: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut g: Self = fs::read_to_string(dir.join(FILE))
    // rust: .map(|t| Self::parse(&t))
    // rust: .unwrap_or_default();
    // rust: g.blue_map.servers = match fs::read_to_string(dir.join(crate::bluemap::SERVERS_FILE)) {
    // rust: Ok(text) => crate::bluemap::Settings::parse_servers(&text),
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => Vec::new(),
    // rust: Err(e) => {
    // rust: log::warn!("{}: {e}; no BlueMap is named", crate::bluemap::SERVERS_FILE);
    // rust: Vec::new()
}
}
    // rust: if fs::remove_file(dir.join(HDR_MARKER)).is_ok() && g.hdr {
    // rust: g.hdr = false;
    // rust: g.save(dir);
    // rust: log::warn!(
    // rust: "the last start ended before HDR output showed a frame; HDR is off now (graphics option hdr, in {FILE})"
    // rust: );
}
    // rust: g
}
pub fn parse(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut g = Self::default();
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
    // rust: let number = |d: u32| value.parse().unwrap_or(d);
    // rust: match key.trim() {
    // rust: "preset" => g.preset = Preset::parse(value),
    // rust: "lodDistance" => {
    // rust: g.lod_distance = number(g.lod_distance).min(crate::lod::MAX_CHUNKS)
}
    // rust: "farDetail" => g.far_detail = FarDetail::parse(value),
    // rust: "blueMapRadius" => {
    // rust: if let Some(radius) = crate::bluemap::Settings::parse_radius(value) {
    // rust: g.blue_map.radius = radius;
}
}
    // rust: "blueMapAutoDetect" => g.blue_map.auto_detect = flag(g.blue_map.auto_detect),
    // rust: "caveCulling" => g.cave_culling = flag(g.cave_culling),
    // rust: "gpuCulling" => g.gpu_culling = flag(g.gpu_culling),
    // rust: "entityCulling" => g.entity_culling = EntityCullingMode::parse(value),
    // rust: "entityCullingPrecheck" => {
    // rust: g.entity_culling_precheck = number(g.entity_culling_precheck).min(512)
}
    // rust: "particleCulling" => g.particle_culling = ParticleCullingMode::parse(value),
    // rust: "leafCulling" => g.leaf_culling = LeafCullingMode::parse(value),
    // rust: "blockEntityCache" => {
    // rust: let enabled = flag(false);
    // rust: g.cache_shulker_boxes = enabled;
    // rust: g.cache_signs = enabled;
    // rust: g.cache_decorated_pots = enabled;
    // rust: g.cache_bells = enabled;
    // rust: g.cache_chests = enabled;
    // rust: g.cache_banners = enabled;
    // rust: g.cache_copper_golem_statues = enabled;
}
    // rust: "blockEntityCacheShulkerBoxes" => {
    // rust: g.cache_shulker_boxes = flag(g.cache_shulker_boxes)
}
    // rust: "blockEntityCacheSigns" => g.cache_signs = flag(g.cache_signs),
    // rust: "blockEntityCacheDecoratedPots" => {
    // rust: g.cache_decorated_pots = flag(g.cache_decorated_pots)
}
    // rust: "blockEntityCacheBells" => g.cache_bells = flag(g.cache_bells),
    // rust: "blockEntityCacheChests" => g.cache_chests = flag(g.cache_chests),
    // rust: "blockEntityCacheBanners" => g.cache_banners = flag(g.cache_banners),
    // rust: "blockEntityCacheCopperGolemStatues" => {
    // rust: g.cache_copper_golem_statues = flag(g.cache_copper_golem_statues)
}
    // rust: "chunkUpdates" => g.chunk_updates = number(g.chunk_updates).min(512),
    // rust: "uploadBudgetKiB" => g.upload_budget_kib = number(g.upload_budget_kib).min(65536),
    // rust: "textureBudgetMiB" => {
    // rust: g.texture_budget_mib = number(g.texture_budget_mib).min(16384);
}
    // rust: "sky" => g.sky = flag(g.sky),
    // rust: "fog" => g.fog = flag(g.fog),
    // rust: "weather" => g.weather = flag(g.weather),
    // rust: "animatedTextures" => g.animated_textures = flag(g.animated_textures),
    // rust: "ditherCutoutMips" => g.dither_cutout_mips = flag(g.dither_cutout_mips),
    // rust: "presentMode" => g.present_mode = PresentMode::parse(value),
    // rust: "framePacing" => {
    // rust: g.pacing = if value == "precise" {
    // rust: Pacing::Precise
    // rust: } else {
    // rust: Pacing::Efficient
}
}
    // rust: "workers" => g.workers = number(g.workers).min(64),
    // rust: "resolutionScale" => g.resolution_scale = number(g.resolution_scale).clamp(50, 200),
    // rust: "fxaa" => g.fxaa = flag(g.fxaa),
    // rust: "taa" => g.taa = flag(g.taa),
    // rust: "upscaling" => g.upscaling = Upscaling::parse(value),
    // rust: "screenshotQuality" => {
    // rust: g.screenshot_quality = Some(number(0))
    // rust: .filter(|q| SCREENSHOT_QUALITIES.contains(q))
    // rust: .unwrap_or(1)
}
    // rust: "frameGeneration" => g.frame_generation = FrameGeneration::parse(value),
    // rust: "hdr" => g.hdr = flag(g.hdr),
    // rust: "hdrLighting" => g.hdr_lighting = flag(g.hdr_lighting),
    // rust: "hdrPaperWhite" => {
    // rust: g.hdr_paper_white = match number(g.hdr_paper_white) {
    // rust: 0 => 0,
    // rust: n => n.clamp(10, 480),
}
}
    // rust: "hdrPeak" => {
    // rust: g.hdr_peak = match number(g.hdr_peak) {
    // rust: 0 => 0,
    // rust: n => n.clamp(200, 2000),
}
}
    // rust: "hdrBlackLevel" => g.hdr_black_level = number(g.hdr_black_level).min(100),
    // rust: "hdrUiBrightness" => {
    // rust: g.hdr_ui_brightness = number(g.hdr_ui_brightness).clamp(25, 100)
}
    // rust: "hdrKey" if value.starts_with("key.") => g.hdr_key = value.to_owned(),
    // rust: "batteryMode" => g.battery = flag(g.battery),
    // rust: "shadowCache" => g.shadow_cache = flag(g.shadow_cache),
    // rust: "batchTranslucent" => g.translucent_batching = flag(g.translucent_batching),
    // rust: "hdrSmoothGradients" => g.hdr_smooth_gradients = flag(g.hdr_smooth_gradients),
    // rust: "graphicsApi" => g.api = GraphicsApi::from_name(value).unwrap_or_default(),
    // rust: "pickedShaderPack" => g.shader_pack = value.to_owned(),
    // rust: "overlay" => {
    // rust: g.overlay = match value {
    // rust: "fps" => Overlay::Fps,
    // rust: "graph" => Overlay::Graph,
    // rust: _ => Overlay::Off,
}
}
    // rust: _ => {}
}
}
    // rust: g
}
pub fn serialize(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut text = format!(
    // rust: "preset:{}\nlodDistance:{}\nfarDetail:{}\ncaveCulling:{}\nentityCulling:{}\nentityCullingPrecheck:{}\nparticleCulling:{}\nleafCulling:{}\nblockEntityCacheShulkerBoxes:{}\nblockEntityCacheSigns:{}\nblockEntityCacheDecoratedPots:{}\nblockEntityCacheBells:{}\nblockEntityCacheChests:{}\nblockEntityCacheBanners:{}\nblockEntityCacheCopperGolemStatues:{}\nchunkUpdates:{}\nuploadBudgetKiB:{}\ntextureBudgetMiB:{}\nsky:{}\nfog:{}\nweather:{}\nanimatedTextures:{}\nditherCutoutMips:{}\npresentMode:{}\nframePacing:{}\nworkers:{}\noverlay:{}\nresolutionScale:{}\nfxaa:{}\ntaa:{}\nupscaling:{}\nscreenshotQuality:{}\nframeGeneration:{}\nhdr:{}\nhdrPaperWhite:{}\nhdrPeak:{}\nhdrBlackLevel:{}\nhdrUiBrightness:{}\nhdrLighting:{}\nhdrKey:{}\nbatteryMode:{}\nshadowCache:{}\ngraphicsApi:{}\npickedShaderPack:{}\nbatchTranslucent:{}\nhdrSmoothGradients:{}\ngpuCulling:{}\n",
    // rust: self.preset.name(),
    // rust: self.lod_distance,
    // rust: self.far_detail.name(),
    // rust: bool_text(self.cave_culling),
    // rust: self.entity_culling.name(),
    // rust: self.entity_culling_precheck,
    // rust: self.particle_culling.name(),
    // rust: self.leaf_culling.name(),
    // rust: bool_text(self.cache_shulker_boxes),
    // rust: bool_text(self.cache_signs),
    // rust: bool_text(self.cache_decorated_pots),
    // rust: bool_text(self.cache_bells),
    // rust: bool_text(self.cache_chests),
    // rust: bool_text(self.cache_banners),
    // rust: bool_text(self.cache_copper_golem_statues),
    // rust: self.chunk_updates,
    // rust: self.upload_budget_kib,
    // rust: self.texture_budget_mib,
    // rust: bool_text(self.sky),
    // rust: bool_text(self.fog),
    // rust: bool_text(self.weather),
    // rust: bool_text(self.animated_textures),
    // rust: bool_text(self.dither_cutout_mips),
    // rust: self.present_mode.name(),
    // rust: match self.pacing {
    // rust: Pacing::Efficient => "efficient",
    // rust: Pacing::Precise => "precise",
    // rust: },
    // rust: self.workers,
    // rust: match self.overlay {
    // rust: Overlay::Off => "off",
    // rust: Overlay::Fps => "fps",
    // rust: Overlay::Graph => "graph",
    // rust: },
    // rust: self.resolution_scale,
    // rust: bool_text(self.fxaa),
    // rust: bool_text(self.taa),
    // rust: self.upscaling.name(),
    // rust: self.screenshot_quality,
    // rust: self.frame_generation.name(),
    // rust: bool_text(self.hdr),
    // rust: self.hdr_paper_white,
    // rust: self.hdr_peak,
    // rust: self.hdr_black_level,
    // rust: self.hdr_ui_brightness,
    // rust: bool_text(self.hdr_lighting),
    // rust: self.hdr_key,
    // rust: bool_text(self.battery),
    // rust: bool_text(self.shadow_cache),
    // rust: self.api.name(),
    // rust: self.shader_pack,
    // rust: bool_text(self.translucent_batching),
    // rust: bool_text(self.hdr_smooth_gradients),
    // rust: bool_text(self.gpu_culling),
    // rust: );
    // rust: text += &self.blue_map.serialize();
    // rust: text
}
    /// Binds Horizon's graphics key `name` (`HDR_KEY`); false for another name.
pub fn set_key(self: *Self, name: []const u8, value: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: HDR_KEY => self.hdr_key = value,
    // rust: _ => return false,
}
    // rust: true
}
pub fn save(self: *Self, dir: *Path) void {
}
    // rust: let _ = fs::write(dir.join(FILE), self.serialize());
}
    /// Whether a renderer made now draws its frame in 16 bits (`Renderer::new`'s `wide_frame`):
    /// HDR on, with Smooth Gradients.
pub fn wide_frame(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hdr && self.hdr_smooth_gradients
}
    /// Paper white, in nits: the player's, or on Auto the desktop's SDR white as the
    /// system reports it, else 203 (BT.2408's reference white).
pub fn paper_white_nits(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.hdr_paper_white {
    // rust: 0 => reported().map_or(203, |r| r.paper_white),
    // rust: n => n,
}
}
    /// The peak the world's highlights reach, in nits: the player's, or on Auto
    /// what the system reports, else 1000.
pub fn peak_nits(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.hdr_peak {
    // rust: 0 => reported().map_or(1000, |r| r.peak),
    // rust: n => n,
}
}
    /// The black level, in nits: the player's, or on Auto what the system reports, else 0.
pub fn black_level_nits(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hundredths = match self.hdr_black_level {
    // rust: 0 => reported().map_or(0, |r| r.black),
    // rust: n => n,
}
    // rust: hundredths as f32 / 100.0
}
    /// Worker threads for chunk generation and meshing.
pub fn worker_threads(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.workers > 0 {
    // rust: return self.workers as usize;
}
        // Vanilla's count (Util.maxAllowedExecutorThreads: every core but
        // one). The pool never takes every core: a pool that fills them all
        // starves the render and server threads, and the frame rate collapses
        // while the workers saturate the CPU and its memory bandwidth. One
        // core left is enough with the workers behind those two threads
        // (horizon_threads: niced on Linux; on macOS and Windows the server
        // and render threads are raised above four cores, where vanilla
        // raises its server thread). Leaving two idled a core of a 4-thread
        // laptop while a world loaded: a teleport there took ~15% longer.
    // rust: let auto = horizon_threads::worker_count().saturating_sub(1).max(1);
    // rust: if self.battery { auto.div_ceil(2) } else { auto }
}
    /// The frame cap battery mode adds: 60 in a world, 30 in menus without a
    /// world or while another window has focus.
pub fn battery_limit(self: *Self, limit: i32, in_world: bool, focused: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.battery {
    // rust: limit
    // rust: } else if in_world && focused {
    // rust: limit.min(60)
    // rust: } else {
    // rust: limit.min(30)
}
}
}

/// A preset's values for vanilla's options and Horizon's own.
pub fn apply_preset(preset: Preset, s: *mut crate::settings::Settings) void {
}
    // rust: let (rd, sim, clouds, particles, shadows, blend, mipmaps, entity, leaves, weather_r) =
    // rust: match preset {
    // rust: Preset::Performance => (8, 6, "false", 2, false, 0, 0, 0.5, false, 3),
    // rust: Preset::Balanced => (12, 8, "fast", 1, true, 1, 2, 0.75, true, 5),
    // rust: Preset::Quality => (16, 12, "true", 0, true, 2, 4, 1.0, true, 10),
    // rust: Preset::Ultra => (24, 12, "true", 0, true, 3, 4, 1.5, true, 10),
    // rust: Preset::Custom => return,
}
    // rust: s.render_distance = rd;
    // rust: s.simulation_distance = sim;
    // rust: s.clouds = clouds.into();
    // rust: s.particles = particles;
    // rust: s.entity_shadows = shadows;
    // rust: s.biome_blend = blend;
    // rust: s.mipmap_levels = mipmaps;
    // rust: s.entity_distance = entity;
    // rust: s.cutout_leaves = leaves;
    // rust: s.weather_radius = weather_r;
    // rust: s.graphics_preset = "custom".into();
    // rust: let g = &mut s.horizon;
    // rust: g.preset = preset;
    // rust: g.cave_culling = true;
    // rust: g.animated_textures = true;
    // rust: g.chunk_updates = 0;
    // rust: g.upload_budget_kib = 0;
    // rust: g.sky = true;
    // rust: g.fog = true;
    // rust: g.weather = true;
}

    // rust: mod tests {
//     use super::*;

pub fn the_api_choice_matches_the_system() void {
}
    // rust: let choices = GraphicsApi::choices();
    // rust: if cfg!(windows) {
    // rust: assert_eq!(choices, GraphicsApi::ALL);
    // rust: } else if cfg!(target_os = "macos") {
    // rust: assert_eq!(choices, [GraphicsApi::Auto]);
    // rust: } else {
    // rust: assert_eq!(
    // rust: choices,
    // rust: [GraphicsApi::Auto, GraphicsApi::Vulkan, GraphicsApi::OpenGl]
    // rust: );
}
}

pub fn round_trips() void {
}
    // rust: let g = Graphics {
    // rust: preset: Preset::Balanced,
    // rust: lod_distance: 256,
    // rust: far_detail: FarDetail::Reduced,
    // rust: blue_map: crate::bluemap::Settings {
    // rust: radius: 40,
    // rust: auto_detect: true,
                // In their own file (`bluemap::SERVERS_FILE`).
    // rust: servers: Vec::new(),
    // rust: },
    // rust: cave_culling: false,
    // rust: gpu_culling: true,
    // rust: entity_culling: EntityCullingMode::Synchronous,
    // rust: entity_culling_precheck: 128,
    // rust: particle_culling: ParticleCullingMode::Asynchronous,
    // rust: leaf_culling: LeafCullingMode::SolidAggressive,
    // rust: cache_shulker_boxes: true,
    // rust: cache_signs: true,
    // rust: cache_decorated_pots: true,
    // rust: cache_bells: true,
    // rust: cache_chests: true,
    // rust: cache_banners: true,
    // rust: cache_copper_golem_statues: true,
    // rust: chunk_updates: 12,
    // rust: upload_budget_kib: 4096,
    // rust: texture_budget_mib: 1536,
    // rust: sky: false,
    // rust: fog: false,
    // rust: weather: false,
    // rust: animated_textures: false,
    // rust: dither_cutout_mips: true,
    // rust: present_mode: PresentMode::Mailbox,
    // rust: pacing: Pacing::Precise,
    // rust: workers: 6,
    // rust: overlay: Overlay::Graph,
    // rust: resolution_scale: 75,
    // rust: fxaa: true,
    // rust: taa: true,
    // rust: upscaling: Upscaling::Balanced,
    // rust: screenshot_quality: 4,
    // rust: frame_generation: FrameGeneration::Fsr31,
    // rust: hdr: true,
    // rust: hdr_paper_white: 240,
    // rust: hdr_peak: 1400,
    // rust: hdr_black_level: 12,
    // rust: hdr_ui_brightness: 60,
    // rust: hdr_lighting: false,
    // rust: hdr_key: "key.keyboard.h".into(),
    // rust: battery: true,
    // rust: shadow_cache: true,
    // rust: api: GraphicsApi::Dx12,
    // rust: translucent_batching: false,
    // rust: hdr_smooth_gradients: false,
    // rust: shader_pack: "Golden Hour".into(),
}
    // rust: assert_eq!(Graphics::parse(&g.serialize()), g);
    // rust: for mode in EntityCullingMode::ALL {
    // rust: let graphics = Graphics {
    // rust: entity_culling: mode,
    // rust: ..Graphics::default()
}
    // rust: assert_eq!(Graphics::parse(&graphics.serialize()), graphics);
}
    // rust: for mode in ParticleCullingMode::ALL {
    // rust: let graphics = Graphics {
    // rust: particle_culling: mode,
    // rust: ..Graphics::default()
}
    // rust: assert_eq!(
    // rust: Graphics::parse(&graphics.serialize()).particle_culling,
    // rust: mode
    // rust: );
}
    // rust: assert_eq!(
    // rust: Graphics::parse("entityCulling:true\n").entity_culling,
    // rust: EntityCullingMode::Synchronous
    // rust: );
    // rust: assert_eq!(
    // rust: Graphics::parse("entityCulling:false\n").entity_culling,
    // rust: EntityCullingMode::Off
    // rust: );
        // A map named here (a shared instance's, a pack's) is no map.
    // rust: assert!(
    // rust: Graphics::parse("blueMap:play.example.net https://map.example.net\n")
    // rust: .blue_map
    // rust: .servers
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(Graphics::parse(""), Graphics::default());
        // Translucent Batching is on, in files from before it too; only false turns it off,
        // and only under its key: the old one held the false every save wrote while it was
        // off by default, not a choice.
    // rust: assert!(Graphics::default().translucent_batching);
    // rust: assert!(!Graphics::parse("batchTranslucent:false\n").translucent_batching);
        // Smooth Gradients is on, and draws a 16-bit frame only with HDR on.
    // rust: assert!(Graphics::default().hdr_smooth_gradients && !Graphics::default().wide_frame());
    // rust: assert!(Graphics::parse("hdr:true\n").wide_frame());
    // rust: assert!(!Graphics::parse("hdr:true\nhdrSmoothGradients:false\n").wide_frame());
    // rust: assert!(Graphics::parse("translucentBatching:false\n").translucent_batching);
        // GPU Culling is opt-in: only the file or its switch turns it on.
    // rust: assert!(!Graphics::default().gpu_culling);
    // rust: assert!(Graphics::parse("gpuCulling:true\n").gpu_culling);
        // 0 is Auto; anything else is a peak the slider reaches.
    // rust: assert_eq!(Graphics::parse("hdrPeak:0\n").hdr_peak, 0);
    // rust: assert_eq!(Graphics::parse("hdrPeak:50\n").hdr_peak, 200);
    // rust: assert_eq!(Graphics::parse("hdrPaperWhite:0\n").hdr_paper_white, 0);
    // rust: assert_eq!(Graphics::parse("hdrPaperWhite:5\n").hdr_paper_white, 10);
        // Only the button's choices.
    // rust: assert_eq!(
    // rust: Graphics::parse("screenshotQuality:8\n").screenshot_quality,
    // rust: 8
    // rust: );
    // rust: assert_eq!(
    // rust: Graphics::parse("screenshotQuality:3\n").screenshot_quality,
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: Graphics::parse("screenshotQuality:16\n").screenshot_quality,
    // rust: 1
    // rust: );
        // The old menus' Simple / Advanced choice is ignored, and so is the
        // shader pack older versions saved.
    // rust: assert_eq!(Graphics::parse("level:advanced\n"), Graphics::default());
    // rust: assert_eq!(
    // rust: Graphics::parse("shaderPack:Pack.zip\n"),
    // rust: Graphics::default()
    // rust: );
    // rust: assert_eq!(
    // rust: Graphics::parse(
    // rust: "workers:abc\nsky:maybe\ncullLeaves:true\nentityCulling:maybe\nleafCulling:maybe\n"
    // rust: ),
    // rust: Graphics::default()
    // rust: );
}

pub fn leaf_culling_round_trips_its_stable_names() void {
}
    // rust: assert_eq!(Graphics::default().leaf_culling, LeafCullingMode::Off);
    // rust: for mode in LeafCullingMode::ALL {
    // rust: let g = Graphics {
    // rust: leaf_culling: mode,
    // rust: ..Graphics::default()
}
    // rust: assert_eq!(Graphics::parse(&g.serialize()), g, "{mode:?}");
    // rust: assert_eq!(
    // rust: Graphics::parse(&format!("leafCulling:{}\n", mode.name())).leaf_culling,
    // rust: mode
    // rust: );
}
    // rust: for text in [
    // rust: "leafCulling:other\n",
    // rust: "leafCulling:\n",
    // rust: "leafCulling:SOLID\n",
    // rust: ] {
    // rust: assert_eq!(
    // rust: Graphics::parse(text).leaf_culling,
    // rust: LeafCullingMode::Off,
    // rust: "{text:?}"
    // rust: );
}
}

pub fn presets_keep_the_leaf_culling_choice() void {
}
    // rust: for mode in LeafCullingMode::ALL {
    // rust: for preset in Preset::ALL {
    // rust: let mut s = crate::settings::Settings::default();
    // rust: s.horizon.leaf_culling = mode;
    // rust: apply_preset(preset, &mut s);
    // rust: assert_eq!(s.horizon.leaf_culling, mode, "{preset:?}");
    // rust: assert_eq!(Graphics::parse(&s.horizon.serialize()), s.horizon);
}
}
}

pub fn custom_packs_turn_leaf_culling_off() void {
}
    // rust: let g = Graphics {
    // rust: leaf_culling: LeafCullingMode::Hollow,
    // rust: ..Graphics::default()
}
    // rust: assert!(g.vanilla_models(&["vanilla".into()]));
    // rust: assert_eq!(
    // rust: g.leaf_culling_effective(&["vanilla".into()]),
    // rust: LeafCullingMode::Hollow
    // rust: );
    // rust: assert!(!g.vanilla_models(&["vanilla".into(), "My Pack".into()]));
    // rust: assert_eq!(
    // rust: g.leaf_culling_effective(&["vanilla".into(), "My Pack".into()]),
    // rust: LeafCullingMode::Off
    // rust: );
    // rust: assert_eq!(g.leaf_culling_effective(&[]), LeafCullingMode::Hollow);
}

pub fn server_pack_apply_disables_leaf_culling_and_removal_restores_it() void {
}
    // rust: let g = Graphics {
    // rust: leaf_culling: LeafCullingMode::Solid,
    // rust: ..Graphics::default()
}
    // rust: let selected = ["vanilla"];
    // rust: let applied_server_pack = ["server/0123456789abcdef/model-pack.zip"];

    // rust: assert_eq!(
    // rust: g.leaf_culling_effective_with_server_packs(selected, applied_server_pack),
    // rust: LeafCullingMode::Off,
    // rust: "an applied server pack can replace block models"
    // rust: );
    // rust: assert!(!g.vanilla_models_with_server_packs(selected, applied_server_pack));

    // rust: assert_eq!(
    // rust: g.leaf_culling_effective_with_server_packs(selected, []),
    // rust: LeafCullingMode::Solid,
    // rust: "removing the server pack restores the selected local mode"
    // rust: );
    // rust: assert!(g.vanilla_models_with_server_packs(selected, []));
}

pub fn integrated_gpus_other_than_apple_cap_the_lod_distance() void {
}
    // rust: let adapter = |name: &str, device_type| wgpu::AdapterInfo {
    // rust: name: name.into(),
    // rust: vendor: 0,
    // rust: device: 0,
    // rust: device_type,
    // rust: device_pci_bus_id: String::new(),
    // rust: driver: String::new(),
    // rust: driver_info: String::new(),
    // rust: backend: wgpu::Backend::Vulkan,
    // rust: subgroup_min_size: 0,
    // rust: subgroup_max_size: 0,
    // rust: transient_saves_memory: None,
    // rust: limit_bucket: None,
}
    // rust: let hd620 = adapter(
    // rust: "Intel(R) HD Graphics 620 (KBL GT2)",
    // rust: wgpu::DeviceType::IntegratedGpu,
    // rust: );
    // rust: let m4 = adapter("Apple M4 Pro", wgpu::DeviceType::IntegratedGpu);
    // rust: let discrete = adapter("NVIDIA GeForce RTX 4070", wgpu::DeviceType::DiscreteGpu);
    // rust: for (distance, capped) in [(0, 0), (64, 64), (128, 128), (256, 128), (1024, 128)] {
    // rust: let g = Graphics {
    // rust: lod_distance: distance,
    // rust: ..Graphics::default()
}
    // rust: assert_eq!(g.lod_distance_on(&hd620), capped);
    // rust: assert_eq!(g.lod_distance_on(&m4), distance);
    // rust: assert_eq!(g.lod_distance_on(&discrete), distance);
}
    // rust: assert!(
    // rust: crate::graphics_ui::rows()
    // rust: .into_iter()
    // rust: .flat_map(|(_, groups)| groups.into_iter().flat_map(|(_, rows)| rows))
    // rust: .any(|r| r
    // rust: .text
    // rust: .contains(&format!("{INTEGRATED_LOD_DISTANCE} chunks"))),
    // rust: "the LOD Distance description names the cap"
    // rust: );
}

pub fn lod_distance_is_opt_in_and_bounded() void {
}
    // rust: assert_eq!(Graphics::default().lod_distance, 0);
    // rust: for distance in [0, 64, 128, 256, 512, 1024, 65_536, crate::lod::MAX_CHUNKS] {
    // rust: let g = Graphics::parse(&format!("lodDistance:{distance}\n"));
    // rust: assert_eq!(g.lod_distance, distance);
    // rust: assert_eq!(Graphics::parse(&g.serialize()), g);
}
    // rust: assert_eq!(
    // rust: Graphics::parse("lodDistance:99999999\n").lod_distance,
    // rust: crate::lod::MAX_CHUNKS
    // rust: );
    // rust: assert_eq!(Graphics::parse("lodDistance:-1\n").lod_distance, 0);
    // rust: assert_eq!(Graphics::parse("lodDistance:invalid\n").lod_distance, 0);
}

pub fn far_detail_is_full_unless_reduced_is_picked() void {
}
    // rust: assert_eq!(Graphics::default().far_detail, FarDetail::Full);
    // rust: assert_eq!(
    // rust: Graphics::parse("farDetail:reduced\n").far_detail,
    // rust: FarDetail::Reduced
    // rust: );
    // rust: for text in ["farDetail:full\n", "farDetail:other\n", ""] {
    // rust: assert_eq!(Graphics::parse(text).far_detail, FarDetail::Full);
}
        // No preset changes it.
    // rust: for preset in Preset::ALL {
    // rust: let mut s = crate::settings::Settings::default();
    // rust: apply_preset(preset, &mut s);
    // rust: assert_eq!(s.horizon.far_detail, FarDetail::Full, "{preset:?}");
}
}

pub fn every_preset_keeps_the_animated_textures_on() void {
}
        // The Performance preset used to turn them off, which froze the fire,
        // the water, the lava and the portals (#2064).
    // rust: assert!(Graphics::default().animated_textures);
    // rust: for preset in Preset::ALL {
    // rust: let mut s = crate::settings::Settings::default();
    // rust: apply_preset(preset, &mut s);
    // rust: assert!(
    // rust: s.horizon.animated_textures,
    // rust: "{preset:?} turned the animated textures off"
    // rust: );
}
}

pub fn automatic_workers_leave_a_core_as_vanilla_does() void {
}
    // rust: let g = Graphics::default();
    // rust: assert_eq!(g.workers, 0);
    // rust: let cores = horizon_threads::worker_count();
    // rust: assert_eq!(g.worker_threads(), cores.saturating_sub(1).max(1));
        // A manual count is the player's own choice, kept as asked.
    // rust: let manual = Graphics { workers: 3, ..g };
    // rust: assert_eq!(manual.worker_threads(), 3);
}

pub fn battery_mode_only_lowers_the_frame_cap() void {
}
    // rust: let mut g = Graphics::default();
    // rust: assert_eq!(g.battery_limit(260, true, true), 260);
    // rust: g.battery = true;
    // rust: assert_eq!(g.battery_limit(260, true, true), 60);
    // rust: assert_eq!(g.battery_limit(30, true, true), 30);
    // rust: assert_eq!(g.battery_limit(260, false, true), 30);
    // rust: assert_eq!(g.battery_limit(260, true, false), 30);
    // rust: assert_eq!(g.battery_limit(10, true, false), 10);
}
}
