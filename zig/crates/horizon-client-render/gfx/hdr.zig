//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_hdr
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! HDR output (Horizon setting, off by default): the frame renders exactly as
//! without it, in vanilla's gamma space, into a 16-bit target when HDR output
//! was on when the renderer was made, else an 8-bit one
//! (`Renderer::frame_format`), and one pass (`hdr.wgsl`) writes it to an HDR10
//! or scRGB swapchain at the player's paper white, expanding the world's
//! highlights towards their peak brightness. The world is copied aside before
//! the hand and HUD so only it is expanded.

/// The swapchain HDR output presents to.
pub const Output = enum {
    /// HDR10: 10-bit BT.2020 with the PQ curve, the display's own signal.
    Pq,
    /// scRGB: linear 16-bit float, BT.709 primaries, 1.0 = 80 nits.
    ScRgb,
};

    // rust: impl Output {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Pq => "HDR10 (PQ)",
    // rust: Self::ScRgb => "scRGB",
}
}
pub fn format(self: *Self) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Pq => wgpu::TextureFormat::Rgb10a2Unorm,
    // rust: Self::ScRgb => wgpu::TextureFormat::Rgba16Float,
}
}
pub fn color_space(self: *Self) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Pq => wgpu::SurfaceColorSpace::Bt2100Pq,
    // rust: Self::ScRgb => wgpu::SurfaceColorSpace::ExtendedSrgbLinear,
}
}
pub fn space(self: *Self) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Pq => wgpu::SurfaceColorSpaces::BT2100_PQ,
    // rust: Self::ScRgb => wgpu::SurfaceColorSpaces::EXTENDED_SRGB_LINEAR,
}
}
}

/// `HORIZON_HDR_OUTPUT`'s names, in order of preference.
pub const NAMES: [(Output, []const u8); 2] = [(Output::Pq, "pq"), (Output::ScRgb, "scrgb")];

/// The HDR output `caps` can present: HDR10 where offered, else scRGB.
/// `HORIZON_HDR_OUTPUT=pq` or `scrgb` allows only that one.
pub fn output(caps: *wgpu::SurfaceCapabilities) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pick(caps, std::env::var("HORIZON_HDR_OUTPUT").ok().as_deref())
}
pub fn pick(caps: *wgpu::SurfaceCapabilities, only: ?[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NAMES
    // rust: .into_iter()
    // rust: .filter(|(_, name)| only.is_none_or(|o| o == *name))
    // rust: .map(|(output, _)| output)
    // rust: .find(|o| caps.color_spaces(o.format()).contains(o.space()))
}
/// The HDR output an offscreen renderer (`--offscreen`) offers: it has no display to ask, so
/// only the one `HORIZON_HDR_OUTPUT` names, for HDR screenshots without an HDR display.
pub fn offscreen_output() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: named(std::env::var("HORIZON_HDR_OUTPUT").ok().as_deref())
}
pub fn named(name: ?[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NAMES
    // rust: .into_iter()
    // rust: .find(|(_, n)| name == Some(*n))
    // rust: .map(|(output, _)| output)
}

pub const Targets = struct {
    size: [u32,
    frame: wgpu::Texture,
    world: wgpu::Texture,
    group: wgpu::BindGroup,
};

/// How one tier of light sources (`mesher::hdr_tier`) shines: `share` of the headroom for
/// its brightest pixels, lifted from brightness `start` (none) to `full` (all of it), the
/// texel's own brightness before lighting.
pub const Tier = struct {
    share: f32,
    start: f32,
    full: f32,
};
/// Low, incandescent, bright and very bright.
    // rust: pub const TIERS: [Tier; 4] = [
    // rust: Tier {
    // rust: share: 0.2,
    // rust: start: 0.08,
    // rust: full: 0.09,
    // rust: },
    // rust: Tier {
    // rust: share: 0.5,
    // rust: start: 0.14,
    // rust: full: 0.38,
    // rust: },
    // rust: Tier {
    // rust: share: 0.6,
    // rust: start: 0.14,
    // rust: full: 0.38,
    // rust: },
    // rust: Tier {
    // rust: share: 1.0,
    // rust: start: 0.14,
    // rust: full: 0.38,
    // rust: },
    // rust: ];
/// Which pixels of a light source's sprite may shine (`hdr_stats.wgsl`), as a fraction of
/// the way from its darkest to its brightest opaque pixel: `parts` for one whose bright parts
/// shine (a torch's flame, not its handle), `whole` for one that shines all over
/// (`mesher::WHOLE`). The tier windows still decide how much.
pub const Masks = struct {
    parts: f32,
    whole: f32,
};
    // rust: pub const MASKS: Masks = Masks {
    // rust: parts: 0.32,
    // rust: whole: 0.0,
}
/// A step of HDR calibration (`crate::hdr_calibration`): its test picture is drawn in nits
/// above the controls instead of the frame.
pub const Calibration = struct {
    /// 1 black level, 2 peak brightness, 3 paper white.
    step: u32,
    /// The slider's value, in nits.
    nits: f32,
    /// Where the controls start, as a share of the height.
    band: f32,
};

pub const Hdr = struct {
    layout: wgpu::BindGroupLayout,
    /// Horizon's logo as a 1-bit mask, for calibration's test pictures.
    logo: wgpu::TextureView,
    pipeline: wgpu::RenderPipeline,
    /// Zeroes the frame's alpha once the world is kept (`keep_world`): what draws after,
    /// the hand, HUD and menus, raises it, so HDR output knows where they cover the world.
    clear_alpha: wgpu::RenderPipeline,
    /// Scales the frame's alpha down to 1/255 where the hand drew (`mark_hand`), so HDR
    /// output keeps the hand at the world's brightness.
    hand_mark: wgpu::RenderPipeline,
    params: wgpu::Buffer,
    /// The same pass drawing HDR10 for a screenshot (`capture`), with its own parameters,
    /// so it can differ from the swapchain's in one frame.
    capture_pipeline: wgpu::RenderPipeline,
    capture_params: wgpu::Buffer,
    output: Output,
    /// The frame's format: what every other pipeline draws in.
    format: wgpu::TextureFormat,
    targets: ?Targets,
    /// `HORIZON_HDR_DEBUG=1`: grey what isn't expanded, tint what is magenta.
    debug: bool,
    /// Paper white and peak brightness, in nits.
    paper_white: f32,
    peak: f32,
    /// The display's black level, in nits: shadows are lifted onto it (`hdr.wgsl`).
    black: f32,
    tiers: [Tier,
    /// The HUD and menus' brightness, as a share of paper white (0.25..=1).
    ui: f32,
    /// Which pixels of a light source shine (`Masks`).
    masks: Masks,
    /// HDR lighting: off while a shader pack's post or material stage runs, the pack's own, and
    /// with `HORIZON_HDR_LIGHTING=0`, to compare.
    lighting: bool,
    /// The HDR Lighting setting: off, nothing in the world is lifted, light sources and the
    /// sun included, so the picture is SDR's on the HDR canvas.
    look: bool,
    /// Calibration's test picture while it runs.
    calibration: ?Calibration,
};

    // rust: impl Hdr {
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: format: wgpu::TextureFormat,
    // rust: output: Output,
    // rust: ) -> Self {
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon HDR"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("../hdr.wgsl").into()),
    // rust: });
    // rust: let texture = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: false },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
}
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Horizon HDR bindings"),
    // rust: entries: &[
    // rust: texture(0),
    // rust: texture(1),
    // rust: texture(3),
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 2,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Horizon HDR"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline_for = |format| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Horizon HDR"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_hdr"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_hdr"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let alpha_pass = |label, blend| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(&device.create_pipeline_layout(&Default::default())),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_hdr"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_clear_alpha"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend,
    // rust: write_mask: wgpu::ColorWrites::ALPHA,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let clear_alpha = alpha_pass("Horizon HDR UI mask", None);
        // Alpha times the blend constant (1/255): the hand's 1 becomes 1/255, the world's 0
        // stays 0.
    // rust: let scale_alpha = wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::Constant,
    // rust: operation: wgpu::BlendOperation::Add,
}
    // rust: let hand_mark = alpha_pass(
    // rust: "Horizon HDR hand mark",
    // rust: Some(wgpu::BlendState {
    // rust: color: scale_alpha,
    // rust: alpha: scale_alpha,
    // rust: }),
    // rust: );
    // rust: let params = || {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Horizon HDR parameters"),
    // rust: size: 64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}
    // rust: Self {
    // rust: logo: logo_mask(device, queue),
    // rust: layout,
    // rust: pipeline: pipeline_for(output.format()),
    // rust: clear_alpha,
    // rust: hand_mark,
    // rust: params: params(),
    // rust: capture_pipeline: pipeline_for(Output::Pq.format()),
    // rust: capture_params: params(),
    // rust: output,
    // rust: format,
    // rust: targets: None,
    // rust: debug: std::env::var_os("HORIZON_HDR_DEBUG").is_some_and(|v| v == "1"),
    // rust: paper_white: 200.0,
    // rust: peak: 1000.0,
    // rust: black: 0.0,
    // rust: tiers: TIERS,
    // rust: ui: 1.0,
    // rust: masks: MASKS,
    // rust: lighting: true,
    // rust: look: true,
    // rust: calibration: None,
}
}

    /// The frame every pass draws into this frame, sized like the window.
pub fn frame(self: *Self, device: *wgpu::Device, size: [u32; 2]) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.targets.as_ref().is_none_or(|t| t.size != size) {
    // rust: let texture = |label, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: self.format,
    // rust: usage: usage | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let frame = texture(
    // rust: "Horizon HDR frame",
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let world = texture(
    // rust: "Horizon HDR world",
    // rust: wgpu::TextureUsages::COPY_DST | wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: );
    // rust: let view = |t: &wgpu::Texture| t.create_view(&Default::default());
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Horizon HDR bindings"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&view(&frame)),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&view(&world)),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: self.params.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&self.logo),
    // rust: },
    // rust: ],
    // rust: });
    // rust: self.targets = Some(Targets {
    // rust: size,
    // rust: frame,
    // rust: world,
    // rust: group,
    // rust: });
}
    // rust: self.targets.as_ref().unwrap().frame.clone()
}

    /// The peak the HDR metadata gives: while calibration's peak step runs, PQ's own
    /// 10 000 nits, so a compositor that clips at the declared peak (KWin) lets the test
    /// patch through as bright as the display goes and the logo under it shows.
pub fn declared_peak(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.calibration {
    // rust: Some(c) if c.step == 2 => 10_000.0,
    // rust: _ => self.peak,
}
}

    /// Keeps the world as drawn so far, before the hand and HUD cover it, then zeroes the
    /// frame's alpha: the world's marks live on in the copy, and whatever draws from here
    /// on raises the alpha where it covers the world.
    // rust: pub fn keep_world(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(t) = &self.targets else {
    // rust: return;
}
    // rust: encoder.copy_texture_to_texture(
    // rust: t.frame.as_image_copy(),
    // rust: t.world.as_image_copy(),
    // rust: t.frame.size(),
    // rust: );
    // rust: let view = t.frame.create_view(&Default::default());
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon HDR UI mask"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("HDR UI mask")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.clear_alpha);
    // rust: pass.draw(0..3, 0..1);
}

    /// After the hand: its pixels' alpha goes down to 1/255, below anything the HUD and
    /// menus leave, so HDR output tells the hand (the world's brightness, never lifted)
    /// from the UI (UI Brightness).
    // rust: pub fn mark_hand(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(t) = &self.targets else {
    // rust: return;
}
    // rust: let view = t.frame.create_view(&Default::default());
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon HDR hand mark"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("HDR hand mark")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.hand_mark);
    // rust: let a = 1.0 / 255.0;
    // rust: pass.set_blend_constant(wgpu::Color {
    // rust: r: a,
    // rust: g: a,
    // rust: b: a,
    // rust: a,
    // rust: });
    // rust: pass.draw(0..3, 0..1);
}

    /// The world as `keep_world` kept it: where the hand's marks go (its alpha, which HDR output
    /// reads for it too), and what tints the world rather than covering it.
pub fn hand_light_view(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = self.targets.as_ref()?;
    // rust: Some(t.world.create_view(&Default::default()))
}

    /// Writes the finished frame to the swapchain image `target`.
    /// The tiers' windows for the shaders that mark the frame (`Globals::hdr_windows`):
    /// where each starts, then where each is full.
pub fn windows(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [self.tiers.map(|t| t.start), self.tiers.map(|t| t.full)]
}
    // rust: pub fn present(
    // rust: &self,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: target: &wgpu::Texture,
    // rust: world: bool,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(t) = &self.targets else {
    // rust: return;
}
    // rust: queue.write_buffer(
    // rust: &self.params,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.params(world, self.output == Output::Pq)),
    // rust: );
    // rust: Self::draw(encoder, &self.pipeline, &t.group, target, timing);
}

    /// The frame `present` writes, as HDR10 (BT.2020, PQ, 10 bits a channel) whatever
    /// the swapchain is, in a texture of its own for a screenshot (`Rgb10a2Unorm`).
    // rust: pub fn capture(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: world: bool,
    // rust: ) -> Option<wgpu::Texture> {
    // rust: let t = self.targets.as_ref()?;
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Horizon HDR screenshot"),
    // rust: size: t.frame.size(),
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: Output::Pq.format(),
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = |t: &wgpu::Texture| t.create_view(&Default::default());
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Horizon HDR screenshot bindings"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&view(&t.frame)),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&view(&t.world)),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: self.capture_params.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&self.logo),
    // rust: },
    // rust: ],
    // rust: });
    // rust: queue.write_buffer(
    // rust: &self.capture_params,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.params(world, true)),
    // rust: );
    // rust: Self::draw(encoder, &self.capture_pipeline, &group, &texture, None);
    // rust: Some(texture)
}

    /// hdr.wgsl's `Params`.
pub fn params(self: *Self, world: bool, pq: bool) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let paper = self.paper_white.max(1.0);
    // rust: let c = self.calibration;
    // rust: let mut params = [0.0; 16];
    // rust: params[..5].copy_from_slice(&[
    // rust: paper / 80.0,
    // rust: (self.peak / paper).max(1.0),
    // rust: f32::from(u8::from(world && self.look)),
    // rust: f32::from(u8::from(self.debug)),
    // rust: f32::from(u8::from(pq)),
    // rust: ]);
    // rust: params[5] = self.black.clamp(0.0, paper);
    // rust: params[6] = self.ui.clamp(0.25, 1.0);
    // rust: params[7] = if self.lighting {
    // rust: scene_gain(self.peak, self.paper_white)
    // rust: } else {
    // rust: 1.0
}
    // rust: for (i, t) in self.tiers.iter().enumerate() {
    // rust: params[8 + i] = t.share;
}
    // rust: params[12] = c.map_or(0.0, |c| c.step as f32);
    // rust: params[13] = c.map_or(0.0, |c| c.nits);
    // rust: params[14] = c.map_or(0.0, |c| c.band);
    // rust: params
}

    // rust: fn draw(
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: pipeline: &wgpu::RenderPipeline,
    // rust: group: &wgpu::BindGroup,
    // rust: target: &wgpu::Texture,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let view = target.create_view(&Default::default());
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon HDR"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("HDR output")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
}

/// Horizon's icon (horizon-theme) as a 1-bit mask: its white strokes, one colour with hard
/// edges, are the logo; everything else is not.
pub fn logo_mask(device: *wgpu::Device, queue: *wgpu::Queue) w {
    // Implementation ported from Horizon
    return undefined;
}
//     use wgpu::util::DeviceExt;
    // rust: let (w, h, rgba) =
    // rust: crate::hud::decode_bytes(horizon_theme::ICON_PNG).unwrap_or((1, 1, vec![0; 4]));
    // rust: let mask: Vec<u8> = rgba
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|p| {
    // rust: if p[3] > 128 && p[..3].iter().all(|&c| c > 200) {
    // rust: 255
    // rust: } else {
    // rust: 0
}
    // rust: })
    // rust: .collect();
    // rust: device
    // rust: .create_texture_with_data(
    // rust: queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Horizon HDR calibration logo"),
    // rust: size: wgpu::Extent3d {
    // rust: width: w,
    // rust: height: h,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::R8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &mask,
    // rust: )
    // rust: .create_view(&Default::default())
}

/// What the strongest light multiplies a surface by, in HDR lighting: 4, which looked right
/// across biomes; less only where there is little headroom to ease into (`hdr.wgsl`).
pub fn scene_gain(peak: f32, paper_white: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (peak / paper_white.max(1.0) * 1.75).clamp(1.0, 4.0)
}

    // rust: mod tests {
//     use super::{Output, named, pick};
//     use wgpu::{SurfaceColorSpaces as S, TextureFormat as F};

pub fn hdr_shaders_validate() void {
}
    // rust: let entity = crate::overlay::wgsl_constants() + include_str!("../entity.wgsl");
    // rust: for source in [
    // rust: include_str!("../hdr.wgsl"),
    // rust: include_str!("../terrain.wgsl"),
    // rust: include_str!("../hdr_stats.wgsl"),
    // rust: include_str!("stars.wgsl"),
    // rust: &entity,
    // rust: ] {
    // rust: let module = naga::front::wgsl::parse_str(source).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}
}

pub fn caps(offered: *[(F) void {
}
    // rust: wgpu::SurfaceCapabilities {
    // rust: format_capabilities: offered
    // rust: .iter()
    // rust: .map(|&(format, color_spaces)| wgpu::SurfaceFormatCapabilities {
    // rust: format,
    // rust: color_spaces,
    // rust: })
    // rust: .collect(),
    // rust: ..Default::default()
}
}

pub fn hdr10_first_then_scrgb() void {
}
    // rust: let both = caps(&[
    // rust: (F::Bgra8UnormSrgb, S::SRGB),
    // rust: (F::Rgb10a2Unorm, S::BT2100_PQ | S::BT2100_HLG),
    // rust: (F::Rgba16Float, S::EXTENDED_SRGB_LINEAR),
    // rust: ]);
    // rust: assert_eq!(pick(&both, None), Some(Output::Pq));
    // rust: assert_eq!(pick(&both, Some("scrgb")), Some(Output::ScRgb));
    // rust: let scrgb = caps(&[(F::Rgba16Float, S::EXTENDED_SRGB_LINEAR)]);
    // rust: assert_eq!(pick(&scrgb, None), Some(Output::ScRgb));
    // rust: assert_eq!(pick(&scrgb, Some("pq")), None);
    // rust: assert_eq!(pick(&caps(&[(F::Bgra8UnormSrgb, S::SRGB)]), None), None);
}

pub fn offscreen_offers_only_the_named_output() void {
}
    // rust: assert_eq!(named(Some("pq")), Some(Output::Pq));
    // rust: assert_eq!(named(Some("scrgb")), Some(Output::ScRgb));
    // rust: assert_eq!(named(Some("hdr10")), None);
    // rust: assert_eq!(named(None), None);
}
}

    // rust: mod lighting_tests {
//     use super::scene_gain;

pub fn the_lighting_scales_with_the_headroom() void {
}
        // Enough headroom: the full strength, whatever the paper white.
    // rust: assert_eq!(scene_gain(1000.0, 430.0), 4.0);
    // rust: assert_eq!(scene_gain(1060.0, 203.0), 4.0);
        // Little headroom, and none.
    // rust: assert_eq!(scene_gain(600.0, 400.0), 2.625);
    // rust: assert_eq!(scene_gain(200.0, 480.0), 1.0);
}
}
