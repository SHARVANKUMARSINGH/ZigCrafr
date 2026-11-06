//! Transpiled from Horizon Rust crate
package horizon_client_render_panorama

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla 26.3's CubeMapTexture and CubeMap, separate from the pixel-filtered GUI atlas.
// use crate::{Result, hud::decode_bytes};
// use glam::Mat4;
// use std::{
    // rust: path::Path,
    // rust: sync::{Arc, Mutex},
}
// use wgpu::util::DeviceExt;

// Native cube order: +X, -X, +Y, -Y, +Z, -Z (CubeMapTexture.SUFFIXES).
FACE_ORDER :: [1, 3, 5, 4, 0, 2]
// Where the cube's faces live in a resource root.
BACKGROUND :: "assets/minecraft/textures/gui/title/background"

// The title screen's six faces. The cube is on the GPU only while the title
// screen shows, and its texels are decoded from the faces' files each time it
// is made: kept decoded, they held 24 MiB through the whole game.
Faces :: struct {
    size: u32,
    // The faces' PNG files in cube order; none for a one-colour cube.
    files: [dynamic]Vec<u8>,
    // The texel of a one-colour cube.
    colour: [u8,
    // The texels decoded while loading, which the first cube takes.
    decoded: Mutex<Maybe([dynamic]u8)>,
}

    // rust: impl Faces {
    // The title artwork of `root` (the packs' overlay) over `defaults` (the
    // game's own resources). `CubeMapTexture` registers each face with the
    // resource manager, which takes the topmost pack that has it: a pack that
    // leaves a face alone keeps vanilla's, and only a cube no layer completes
    // falls back to the grey placeholder that an installation without the
    // imported panorama shows.
load :: proc(root: ^Path, defaults: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::try_load(root, defaults).unwrap_or_else(|error| {
    // rust: log::warn!(
    // rust: "Horizon: no title panorama ({error}); prepare the game again in the launcher \
    // rust: (or run horizon-prepare panorama)"
    // rust: );
    // rust: Self::colour([96, 110, 111, 255])
    // rust: })
}

    // A one-texel cube of one colour.
colour :: proc(colour: [u8; 4]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: size: 1,
    // rust: files: Vec::new(),
    // rust: colour,
    // rust: decoded: Mutex::new(None),
}
}

try_load :: proc(root: ^Path, defaults: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut size = 0;
    // rust: let mut files = Vec::with_capacity(FACE_ORDER.len());
    // rust: let mut texels = Vec::new();
    // rust: for face in FACE_ORDER {
    // rust: let (path, file, (w, h, data)) = load_face(root, defaults, face)?;
    // rust: if w != h || (size != 0 && w != size) {
    // rust: return Err(format!(
    // rust: "{}: panorama faces must be equally sized squares",
    // rust: path.display()
    // rust: )
    // rust: .into());
}
    // rust: size = w;
            // CubeMapTexture copies each original image with flipY=true. Keep every texel.
    // rust: for row in data.chunks_exact((w * 4) as usize).rev() {
    // rust: texels.extend_from_slice(row);
}
    // rust: files.push(file);
}
        // Decoded once here to check them, and kept for the first cube.
    // rust: Ok(Self {
    // rust: size,
    // rust: files,
    // rust: colour: [0; 4],
    // rust: decoded: Mutex::new(Some(texels)),
    // rust: })
}

    // The cube's texels, layer after layer.
texels :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if self.files.is_empty() {
    // rust: return self.colour.repeat(6);
}
    // rust: let loaded = self
    // rust: .decoded
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .take();
    // rust: loaded
    // rust: .or_else(|| decode_faces(&self.files).ok().map(|(_, texels)| texels))
    // rust: .unwrap_or_else(|| vec![0; (self.size * self.size * 4 * 6) as usize])
}
}

// The faces' files decoded, side by side, into one array of six layers of
// equal squares.
decode_faces :: proc(files: ^[[dynamic]u8]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let decoded: Vec<_> = std::thread::scope(|scope| {
    // rust: let threads: Vec<_> = files
    // rust: .iter()
    // rust: .map(|file| scope.spawn(|| decode_bytes(file).map_err(|e| e.to_string())))
    // rust: .collect();
    // rust: threads
    // rust: .into_iter()
    // rust: .map(|t| t.join().unwrap_or_else(|p| std::panic::resume_unwind(p)))
    // rust: .collect()
    // rust: });
    // rust: let mut size = 0;
    // rust: let mut texels = Vec::new();
    // rust: for (face, image) in FACE_ORDER.iter().zip(decoded) {
    // rust: let (w, h, data) = image?;
    // rust: if w != h || (size != 0 && w != size) {
    // rust: return Err(format!(
    // rust: "panorama_{face}.png: panorama faces must be equally sized squares"
    // rust: )
    // rust: .into());
}
    // rust: if size == 0 {
    // rust: size = w;
    // rust: texels.reserve_exact((w * w * 4) as usize * files.len());
}
        // CubeMapTexture copies each original image with flipY=true. Keep every texel.
    // rust: for row in data.chunks_exact((w * 4) as usize).rev() {
    // rust: texels.extend_from_slice(row);
}
}
    // rust: Ok((size, texels))
}

// `panorama_{face}.png` from the first layer that has one, with the path it
// came from, its file and its decoded image. Reading a face that no layer
// provides fails naming every path tried, so a report of a missing panorama
// says where the game looked.
    // rust: fn load_face(
    // rust: root: &Path,
    // rust: defaults: &Path,
    // rust: face: u8,
    // rust: ) -> Result<(std::path::PathBuf, Vec<u8>, (u32, u32, Vec<u8>))> {
    // rust: let name = format!("panorama_{face}.png");
    // rust: let mut tried: Vec<(std::path::PathBuf, String)> = Vec::new();
    // rust: for layer in [root, defaults] {
    // rust: let path = layer.join(BACKGROUND).join(&name);
        // A vanilla-only installation loads one root twice.
    // rust: if tried.first().is_some_and(|(seen, _)| *seen == path) {
    // rust: continue;
}
    // rust: let read = std::fs::read(&path)
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|file| {
    // rust: let image = decode_bytes(&file).map_err(|e| e.to_string())?;
    // rust: Ok((file, image))
    // rust: });
    // rust: match read {
    // rust: Ok((file, image)) => return Ok((path, file, image)),
    // rust: Err(error) => tried.push((path, error)),
}
}
    // rust: let tried: Vec<String> = tried
    // rust: .iter()
    // rust: .map(|(path, error)| format!("{}: {error}", path.display()))
    // rust: .collect();
    // rust: Err(tried.join("; ").into())
}

projection :: proc(width: u32, height: u32, yaw: f32, pitch: f32) -> M {
    // Ported from Horizon
    return {}
}
    // CubeMap.render: 85-degree FOV, near/far 0.05/10, rotationX(PI), rotateX, rotateY.
    // rust: Mat4::perspective_rh(
    // rust: 85.0f32.to_radians(),
    // rust: width as f32 / height.max(1) as f32,
    // rust: 0.05,
    // rust: 10.0,
    // rust: ) * Mat4::from_rotation_x(std::f32::consts::PI)
    // rust: * Mat4::from_rotation_x(pitch.to_radians())
    // rust: * Mat4::from_rotation_y(yaw.to_radians())
}

    // rust: pub(super) struct Panorama {
    // rust: pipeline: wgpu::RenderPipeline,
    // rust: layout: wgpu::BindGroupLayout,
    // rust: sampler: wgpu::Sampler,
    // rust: uniform: wgpu::Buffer,
    // rust: faces: Arc<Faces>,
    // The cube and its bindings, while the title screen shows.
    // rust: cube: Option<wgpu::BindGroup>,
}

    // rust: impl Panorama {
    // rust: pub(super) fn new(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: faces: Arc<Faces>,
    // rust: ) -> Self {
        // CubeMapTexture's blur=true metadata: linear minification and magnification, no mips.
    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Title panorama linear filtering"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Title panorama projection"),
    // rust: size: 64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Title panorama bindings"),
    // rust: entries: &[
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 1,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::Cube,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 2,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Title panorama shader"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("panorama.wgsl").into()),
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Title panorama layout"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Title panorama"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_panorama"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_panorama"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: Self {
    // rust: pipeline,
    // rust: layout,
    // rust: sampler,
    // rust: uniform,
    // rust: faces,
    // rust: cube: None,
}
}

    // Ready a title screen frame: the cube, made if it is not on the GPU.
    // rust: pub(super) fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: width: u32,
    // rust: height: u32,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: ) {
    // rust: queue.write_buffer(
    // rust: &self.uniform,
    // rust: 0,
    // rust: bytemuck::cast_slice(&projection(width, height, yaw, pitch).to_cols_array()),
    // rust: );
    // rust: if self.cube.is_none() {
    // rust: self.cube = Some(self.cube(device, queue));
}
}

    // Give the cube's video memory back: no frame draws it until the title
    // screen shows again.
    // rust: pub(super) fn release(&mut self) {
    // rust: self.cube = None;
}

cube :: proc(self: ^Self, device: ^wgpu::Device, queue: ^wgpu::Queue) -> w {
    // Ported from Horizon
    return {}
}
    // rust: let texture = device.create_texture_with_data(
    // rust: queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Title panorama cube"),
    // rust: size: wgpu::Extent3d {
    // rust: width: self.faces.size,
    // rust: height: self.faces.size,
    // rust: depth_or_array_layers: 6,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &self.faces.texels(),
    // rust: );
    // rust: let view = texture.create_view(&wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::Cube),
    // rust: ..Default::default()
    // rust: });
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Title panorama resources"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: self.uniform.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&self.sampler),
    // rust: },
    // rust: ],
    // rust: })
}

    // Draw the cube `prepare` made for this frame.
    // rust: pub(super) fn draw(&self, pass: &mut wgpu::RenderPass<'_>) {
    // rust: let Some(cube) = &self.cube else {
    // rust: return;
}
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, cube, &[]);
    // rust: pass.draw(0..36, 0..1);
}
}

// `PanoramaRenderer`: accumulate rotation so changing speed does not jump
// back to a different point on the cube. `now` is monotonic seconds.
Rotation :: struct {
    last: f32,
    yaw: f32,
}
    // rust: impl Rotation {
update :: proc(self: ^Self, now: f32, speed: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.yaw = (self.yaw - (now - self.last).max(0.0) * 2.0 * speed) % 360.0;
    // rust: self.last = now;
    // rust: self.yaw
}
}

    // rust: mod tests {
//     use super::*;
//     use std::{
    // rust: fs,
    // rust: sync::atomic::{AtomicU32, Ordering},
}

    // One resource root: a pack overlay, or the game's own resources.
Fixture :: struct {
    // rust: impl Fixture {
new :: proc(size: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let fixture = Self::bare();
    // rust: for face in 0..6 {
    // rust: fixture.write(face, size, size);
}
    // rust: fixture
}
        // A root with the faces' folder and none of the faces.
bare :: proc() -> S {
    // Ported from Horizon
    return {}
}
NEXT :: AtomicU32::new(0)
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-panorama-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed),
    // rust: ));
    // rust: let fixture = Self(root);
    // rust: fs::create_dir_all(fixture.background()).unwrap();
    // rust: fixture
}
background :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .join("assets/minecraft/textures/gui/title/background")
}
write :: proc(self: ^Self, face: u8, w: u32, h: u32) {
}
    // rust: let file =
    // rust: fs::File::create(self.background().join(format!("panorama_{face}.png"))).unwrap();
    // rust: let mut encoder = png::Encoder::new(file, w, h);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = (0..h)
    // rust: .flat_map(|y| {
    // rust: (0..w).flat_map(move |x| [face, (x % 251) as u8, (y % 253) as u8, 255])
    // rust: })
    // rust: .collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
}
    // rust: impl Drop for Fixture {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

rotation_speed_changes_preserve_position :: proc() {
}
    // rust: let mut rotation = Rotation::default();
    // rust: assert_eq!(rotation.update(5.0, 1.0), -10.0);
    // rust: assert_eq!(rotation.update(10.0, 0.0), -10.0);
    // rust: assert_eq!(rotation.update(12.0, 0.5), -12.0);
    // rust: assert_eq!(rotation.update(13.0, 1.0), -14.0);
}

original_resolution_texels_and_vanilla_cube_orientation_are_preserved :: proc() {
}
    // rust: let f = Fixture::new(1024);
    // rust: let faces = Faces::try_load(&f.0, &f.0).unwrap();
    // rust: assert_eq!(faces.size, 1024);
        // The texels decoded while loading, then decoded again for the next cube.
    // rust: let (loaded, again) = (faces.texels(), faces.texels());
    // rust: assert_eq!(loaded, again);
    // rust: assert_eq!(again.len(), 6 * 1024 * 1024 * 4);
        // CubeMapTexture's actual layer suffixes, with each source row flipped vertically.
    // rust: for (layer, source_face) in [1, 3, 5, 4, 0, 2].into_iter().enumerate() {
    // rust: for y in 0..1024 {
    // rust: for x in 0..1024 {
    // rust: let at = ((layer * 1024 + y) * 1024 + x) * 4;
    // rust: assert_eq!(
    // rust: again[at..at + 4],
    // rust: [source_face, (x % 251) as u8, ((1023 - y) % 253) as u8, 255]
    // rust: );
}
}
}
}

placeholders_load_and_incomplete_or_mismatched_cubes_fall_back :: proc() {
}
    // rust: let f = Fixture::new(1);
    // rust: assert_eq!(Faces::try_load(&f.0, &f.0).unwrap().size, 1);
    // rust: f.write(5, 2, 1);
    // rust: assert!(
    // rust: Faces::try_load(&f.0, &f.0)
    // rust: .unwrap_err()
    // rust: .to_string()
    // rust: .contains("equally sized squares")
    // rust: );
    // rust: let fallback = Faces::load(&f.0, &f.0);
    // rust: assert_eq!(fallback.texels(), [96, 110, 111, 255].repeat(6));
    // rust: f.write(5, 2, 2);
    // rust: assert!(Faces::try_load(&f.0, &f.0).is_err());
    // rust: fs::remove_file(f.background().join("panorama_5.png")).unwrap();
    // rust: assert!(Faces::try_load(&f.0, &f.0).is_err());
    // rust: assert_eq!(Faces::load(&f.0, &f.0).size, 1);
}

a_pack_without_a_face_keeps_vanillas_and_its_own_face_wins :: proc() {
}
    // rust: let vanilla = Fixture::new(4);
        // A pack that replaces one face of the cube: the other five are
        // still the game's, as the bottom of the pack stack provides them.
    // rust: let pack = Fixture::bare();
    // rust: pack.write(2, 4, 4);
    // rust: let faces = Faces::try_load(&pack.0, &vanilla.0).unwrap();
    // rust: assert_eq!(faces.size, 4);
    // rust: let texels = faces.texels();
    // rust: assert_eq!(texels.len(), 6 * 4 * 4 * 4);
        // Each face's red channel is its index (`face` above), and the cube
        // holds them in FACE_ORDER: layer 5 is face 2, the pack's, and layer 4
        // is face 0, which only the game's resources have.
    // rust: let red = |layer: usize, texel: usize| texels[(layer * 16 + texel) * 4];
    // rust: assert_eq!(red(5, 0), 2);
    // rust: assert_eq!(red(4, 0), 0);
}

a_missing_cube_names_every_path_it_tried :: proc() {
}
    // rust: let vanilla = Fixture::bare();
    // rust: let pack = Fixture::bare();
    // rust: let error = Faces::try_load(&pack.0, &vanilla.0)
    // rust: .unwrap_err()
    // rust: .to_string();
    // rust: for root in [&pack, &vanilla] {
    // rust: let path = root.background().join("panorama_1.png");
    // rust: assert!(error.contains(&path.display().to_string()), "{error}");
}
        // No layer completes the cube: the one-pixel grey placeholder, and the
        // window still has a title.
    // rust: let fallback = Faces::load(&pack.0, &vanilla.0);
    // rust: assert_eq!((fallback.size, fallback.texels().len()), (1, 24));
}

cube_shader_validates :: proc() {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("panorama.wgsl")).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}

vanilla_camera_centres_the_positive_z_face_and_pitches_ten_degrees :: proc() {
}
    // rust: let straight = projection(1920, 1080, 0.0, 0.0) * glam::Vec4::new(0.0, 0.0, 1.0, 1.0);
    // rust: assert!((straight.x / straight.w).abs() < 1e-6);
    // rust: assert!((straight.y / straight.w).abs() < 1e-6);
    // rust: assert!(straight.w > 0.0);
    // rust: let pitched = projection(1920, 1080, 0.0, 10.0) * glam::Vec4::new(0.0, 0.0, 1.0, 1.0);
    // rust: let expected_y = 10.0f32.to_radians().tan() / 42.5f32.to_radians().tan();
    // rust: assert!((pitched.y / pitched.w - expected_y).abs() < 1e-6);
}
}
