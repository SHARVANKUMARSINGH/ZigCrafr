//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_textures

import "core:fmt"
import "core:mem"
import "core:math"

// A shader pack's custom textures (`texture.<stage>.<name>`, `texture.noise`) on the GPU, and
// which of them a program's sampler reads.

// use horizon_shaders::{CustomTexture, Group, Kind, Texels, Texture, TextureDim, TextureSource};

// What a custom texture is once uploaded: an image of ours, or one the game already has.
    // rust: pub(super) enum Image {
    // rust: View(wgpu::TextureView),
    // rust: Lightmap,
    // rust: Atlas,
}

    // rust: pub(super) struct PackTexture {
    // rust: pub(super) stage: String,
    // rust: pub(super) name: String,
    // rust: pub(super) dimension: wgpu::TextureViewDimension,
    // rust: pub(super) sample_type: wgpu::TextureSampleType,
    // rust: pub(super) blur: bool,
    // rust: pub(super) clamp: bool,
    // Decoded from a PNG, the pack's or the game's (not a raw dump, not a generated texture).
    // rust: pub(super) png: bool,
    // rust: pub(super) image: Image,
}

// Uploads `textures`, with a note for each the game can't provide.
    // rust: pub(super) fn upload(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: textures: Vec<CustomTexture>,
    // rust: notes: &mut Vec<String>,
    // rust: ) -> Vec<PackTexture> {
    // rust: let features = device.features();
    // rust: let mut out = Vec::new();
    // rust: for t in textures {
    // rust: let (image, dimension, sample_type, blur, clamp, png) = match t.source {
    // rust: TextureSource::Image(texture) => {
    // rust: let (view, sample_type) = match create(device, queue, &texture, features) {
    // rust: Ok(created) => created,
    // rust: Err(e) => {
    // rust: notes.push(format!("{}: {e}", key(&t.stage, &t.name)));
    // rust: continue;
}
}
    // rust: let dimension = match texture.dim {
    // rust: TextureDim::D1 => wgpu::TextureViewDimension::D1,
    // rust: TextureDim::D2 => wgpu::TextureViewDimension::D2,
    // rust: TextureDim::D3 => wgpu::TextureViewDimension::D3,
}
    // rust: (
    // rust: Image::View(view),
    // rust: dimension,
    // rust: sample_type,
    // rust: texture.blur,
    // rust: texture.clamp,
    // rust: !texture.raw,
    // rust: )
}
    // rust: TextureSource::Resource(location) => {
    // rust: let path = location.strip_prefix("minecraft:").unwrap_or(&location);
    // rust: let image = if path.starts_with("dynamic/lightmap") {
    // rust: Image::Lightmap
    // rust: } else if path.starts_with("textures/atlas/blocks") || path == "dynamic/atlas" {
    // rust: Image::Atlas
    // rust: } else {
    // rust: notes.push(format!(
    // rust: "{}: `{location}` is not provided yet",
    // rust: key(&t.stage, &t.name)
    // rust: ));
    // rust: continue;
}
    // rust: let float = wgpu::TextureSampleType::Float { filterable: true };
    // rust: (
    // rust: image,
    // rust: wgpu::TextureViewDimension::D2,
    // rust: float,
    // rust: true,
    // rust: true,
    // rust: false,
    // rust: )
}
}
    // rust: out.push(PackTexture {
    // rust: stage: t.stage,
    // rust: name: t.name,
    // rust: dimension,
    // rust: sample_type,
    // rust: blur,
    // rust: clamp,
    // rust: png,
    // rust: image,
    // rust: });
}
    // rust: out
}

// The stage name of `texture.<stage>.*` a program of `group` reads.
    // rust: pub(super) fn stage(group: Group) -> &'static str {
    // rust: match group {
    // rust: Group::Gbuffers | Group::Translucent | Group::Shadow => "gbuffers",
    // rust: Group::Setup => "setup",
    // rust: Group::Begin => "begin",
    // rust: Group::Prepare => "prepare",
    // rust: Group::Deferred => "deferred",
    // rust: Group::Composite | Group::Final => "composite",
    // rust: Group::ShadowComp => "shadowcomp",
}
}

// The custom texture a `ty name` sampler of a `group` program reads: same stage, the same
// name (or another name of the same buffer, `gaux1` for `colortex4`) and dimension. A unit
// may hold one texture per dimension. Without one, a `customTexture` of that name and
// dimension, which every program reads.
    // rust: pub(super) fn find(textures: &[PackTexture], group: Group, ty: &str, name: &str) -> Option<usize> {
    // rust: let dimension = if ty.contains("1D") {
    // rust: wgpu::TextureViewDimension::D1
    // rust: } else if ty.contains("3D") {
    // rust: wgpu::TextureViewDimension::D3
    // rust: } else {
    // rust: wgpu::TextureViewDimension::D2
}
    // rust: let buffer = horizon_shaders::buffer_index(name);
    // rust: let staged = textures.iter().position(|t| {
    // rust: t.stage == stage(group)
    // rust: && t.dimension == dimension
    // rust: && (t.name == name
    // rust: || buffer.is_some() && horizon_shaders::buffer_index(&t.name) == buffer)
    // rust: });
    // rust: staged.or_else(|| {
    // rust: textures.iter().position(|t| {
    // rust: t.stage == horizon_shaders::EVERY_STAGE && t.dimension == dimension && t.name == name
    // rust: })
    // rust: })
}

// The `shaders.properties` key a texture came from, for notes.
key :: proc(stage: string, name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match stage {
    // rust: horizon_shaders::EVERY_STAGE => format!("customTexture.{name}"),
    // rust: _ => format!("texture.{stage}.{name}"),
}
}

// `texture.noise`, if the pack has one.
    // rust: pub(super) fn noise(textures: &[PackTexture]) -> Option<&wgpu::TextureView> {
    // rust: textures
    // rust: .iter()
    // rust: .find(|t| t.stage == "noise" && t.dimension == wgpu::TextureViewDimension::D2)
    // rust: .and_then(|t| match &t.image {
    // rust: Image::View(v) => Some(v),
    // rust: _ => None,
    // rust: })
}

// The wgpu format a texture of `texture.format` is stored in: sampled, never rendered to, so
// any format whose texels hold the values.
format :: proc(texture: ^Texture) -> w {
    // Ported from Horizon
    return {}
}
//     use wgpu::TextureFormat as T;
    // rust: let f = texture.format;
    // rust: let pick = |r, rg, rgba| match texture.components() {
    // rust: 1 => r,
    // rust: 2 => rg,
    // rust: _ => rgba,
}
    // rust: match (f.kind, f.bits) {
    // rust: (Kind::Unorm, b) if b <= 8 => pick(T::R8Unorm, T::Rg8Unorm, T::Rgba8Unorm),
    // rust: (Kind::Snorm, 8) => pick(T::R8Snorm, T::Rg8Snorm, T::Rgba8Snorm),
    // rust: (Kind::Float, 32) => pick(T::R32Float, T::Rg32Float, T::Rgba32Float),
    // rust: (Kind::Int, 8) => pick(T::R8Sint, T::Rg8Sint, T::Rgba8Sint),
    // rust: (Kind::Int, 16) => pick(T::R16Sint, T::Rg16Sint, T::Rgba16Sint),
    // rust: (Kind::Int, _) => pick(T::R32Sint, T::Rg32Sint, T::Rgba32Sint),
    // rust: (Kind::Uint, 8) => pick(T::R8Uint, T::Rg8Uint, T::Rgba8Uint),
    // rust: (Kind::Uint, 16) => pick(T::R16Uint, T::Rg16Uint, T::Rgba16Uint),
    // rust: (Kind::Uint, _) => pick(T::R32Uint, T::Rg32Uint, T::Rgba32Uint),
        // 16-bit and packed normalized formats, half floats and the small floats: halves hold
        // them closely enough.
    // rust: _ => pick(T::R16Float, T::Rg16Float, T::Rgba16Float),
}
}

// `texture`'s texels as the bytes of `format`, row after row.
bytes :: proc(texture: ^Texture, format: wgpu::TextureFormat) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match (&texture.texels, format) {
    // rust: (Texels::Float(v), f) if f.block_copy_size(None) == Some(texture.components() as u32) => {
    // rust: if matches!(
    // rust: f,
    // rust: wgpu::TextureFormat::R8Snorm
    // rust: | wgpu::TextureFormat::Rg8Snorm
    // rust: | wgpu::TextureFormat::Rgba8Snorm
    // rust: ) {
    // rust: v.iter()
    // rust: .map(|x| (x.clamp(-1.0, 1.0) * 127.0).round() as i8 as u8)
    // rust: .collect()
    // rust: } else {
    // rust: v.iter()
    // rust: .map(|x| (x.clamp(0.0, 1.0) * 255.0).round() as u8)
    // rust: .collect()
}
}
    // rust: (Texels::Float(v), f)
    // rust: if f.block_copy_size(None) == Some(4 * texture.components() as u32) =>
    // rust: {
    // rust: v.iter().flat_map(|x| x.to_le_bytes()).collect()
}
    // rust: (Texels::Float(v), _) => v
    // rust: .iter()
    // rust: .flat_map(|&x| half::f16::from_f32(x).to_le_bytes())
    // rust: .collect(),
    // rust: (Texels::Int(v), f) => {
    // rust: let width = f.block_copy_size(None).unwrap_or(4) as usize / texture.components();
    // rust: v.iter()
    // rust: .flat_map(|x| x.to_le_bytes().into_iter().take(width))
    // rust: .collect()
}
    // rust: (Texels::Uint(v), f) => {
    // rust: let width = f.block_copy_size(None).unwrap_or(4) as usize / texture.components();
    // rust: v.iter()
    // rust: .flat_map(|x| x.to_le_bytes().into_iter().take(width))
    // rust: .collect()
}
}
}

    // rust: fn create(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: texture: &Texture,
    // rust: features: wgpu::Features,
    // rust: ) -> Result<(wgpu::TextureView, wgpu::TextureSampleType), String> {
    // rust: let format = format(texture);
    // rust: let bytes = bytes(texture, format);
    // rust: let [width, height, depth] = texture.size;
    // rust: let limits = device.limits();
    // rust: let largest = match texture.dim {
    // rust: TextureDim::D1 => limits.max_texture_dimension_1d,
    // rust: TextureDim::D2 => limits.max_texture_dimension_2d,
    // rust: TextureDim::D3 => limits.max_texture_dimension_3d,
}
    // rust: if [width, height, depth].iter().any(|&n| n > largest) {
    // rust: return Err(format!(
    // rust: "{width}x{height}x{depth} is larger than this device's {largest}"
    // rust: ));
}
    // rust: let row = width * format.block_copy_size(None).unwrap_or(4);
    // rust: if bytes.len() as u64 != u64::from(row) * u64::from(height) * u64::from(depth) {
    // rust: return Err(format!(
    // rust: "{} bytes of texels for {width}x{height}x{depth}",
    // rust: bytes.len()
    // rust: ));
}
    // rust: let size = wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: depth,
}
    // rust: let dimension = match texture.dim {
    // rust: TextureDim::D1 => wgpu::TextureDimension::D1,
    // rust: TextureDim::D2 => wgpu::TextureDimension::D2,
    // rust: TextureDim::D3 => wgpu::TextureDimension::D3,
}
    // rust: let tex = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack custom texture"),
    // rust: size,
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: queue.write_texture(
    // rust: tex.as_image_copy(),
    // rust: &bytes,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(row),
    // rust: rows_per_image: Some(height),
    // rust: },
    // rust: size,
    // rust: );
    // rust: let sample_type = format
    // rust: .sample_type(None, Some(features))
    // rust: .unwrap_or(wgpu::TextureSampleType::Float { filterable: false });
    // rust: Ok((tex.create_view(&Default::default()), sample_type))
}

    // rust: mod tests {
//     use super::*;
//     use horizon_shaders::Format;

lightmap :: proc(stage: string, name: string, dimension: wgpu::TextureViewDimension) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PackTexture {
    // rust: stage: stage.into(),
    // rust: name: name.into(),
    // rust: dimension,
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: blur: false,
    // rust: clamp: false,
    // rust: png: false,
    // rust: image: Image::Lightmap,
}
}

texture :: proc(format: string, texels: Texels) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Texture {
    // rust: dim: TextureDim::D2,
    // rust: size: [1, 1, 1],
    // rust: format: Format::parse(format).unwrap(),
    // rust: texels,
    // rust: blur: false,
    // rust: clamp: false,
    // rust: raw: true,
}
}

samplers_find_their_stage_name_and_dimension :: proc() {
}
//         use wgpu::TextureViewDimension as D;
    // rust: let textures = [
    // rust: lightmap("composite", "colortex4", D::D2),
    // rust: lightmap("composite", "noisetex", D::D3),
    // rust: lightmap("gbuffers", "gaux2", D::D2),
    // rust: lightmap("composite", "noisetex", D::D1),
    // rust: ];
    // rust: assert_eq!(find(&textures, Group::Final, "sampler2D", "gaux1"), Some(0));
    // rust: assert_eq!(
    // rust: find(&textures, Group::Composite, "sampler3D", "noisetex"),
    // rust: Some(1)
    // rust: );
    // rust: assert_eq!(
    // rust: find(&textures, Group::Composite, "sampler1D", "noisetex"),
    // rust: Some(3)
    // rust: );
    // rust: assert_eq!(
    // rust: find(&textures, Group::Composite, "sampler2D", "noisetex"),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: find(&textures, Group::Shadow, "sampler2D", "colortex5"),
    // rust: Some(2)
    // rust: );
    // rust: assert_eq!(
    // rust: find(&textures, Group::Deferred, "sampler2D", "colortex4"),
    // rust: None
    // rust: );
}

    // Iris's `customTexture.<name>`: every program reads it under its own name and dimension;
    // a `texture.<stage>.<name>` of the same name comes first in its stage.
custom_textures_reach_every_program :: proc() {
}
//         use wgpu::TextureViewDimension as D;
    // rust: let every = horizon_shaders::EVERY_STAGE;
    // rust: let textures = [
    // rust: lightmap(every, "texClouds", D::D3),
    // rust: lightmap("composite", "texClouds", D::D3),
    // rust: lightmap(every, "colortex4", D::D2),
    // rust: ];
    // rust: for group in [
    // rust: Group::Gbuffers,
    // rust: Group::Translucent,
    // rust: Group::Shadow,
    // rust: Group::Prepare,
    // rust: Group::Deferred,
    // rust: Group::ShadowComp,
    // rust: ] {
    // rust: assert_eq!(
    // rust: find(&textures, group, "sampler3D", "texClouds"),
    // rust: Some(0),
    // rust: "{group:?}"
    // rust: );
}
        // `final` reads the `composite` stage's textures too.
    // rust: for group in [Group::Composite, Group::Final] {
    // rust: assert_eq!(find(&textures, group, "sampler3D", "texClouds"), Some(1));
}
    // rust: assert_eq!(
    // rust: find(&textures, Group::Gbuffers, "sampler2D", "texClouds"),
    // rust: None
    // rust: );
        // Only its own name: no other name of the same buffer.
    // rust: assert_eq!(find(&textures, Group::Final, "sampler2D", "gaux1"), None);
    // rust: assert_eq!(
    // rust: find(&textures, Group::Final, "sampler2D", "colortex4"),
    // rust: Some(2)
    // rust: );
}

texels_pack_into_their_format :: proc() {
}
    // rust: let t = texture("RGBA8", Texels::Float(vec![0.0, 0.5, 1.0, 2.0]));
    // rust: assert_eq!(format(&t), wgpu::TextureFormat::Rgba8Unorm);
    // rust: assert_eq!(bytes(&t, format(&t)), [0, 128, 255, 255]);
    // rust: let t = texture("RG8_SNORM", Texels::Float(vec![-1.0, 0.5]));
    // rust: assert_eq!(format(&t), wgpu::TextureFormat::Rg8Snorm);
    // rust: assert_eq!(bytes(&t, format(&t)), [0x81, 64]);
    // rust: let t = texture("R32F", Texels::Float(vec![1.0]));
    // rust: assert_eq!(bytes(&t, format(&t)), 1.0f32.to_le_bytes());
    // rust: let t = texture("R16F", Texels::Float(vec![1.0]));
    // rust: assert_eq!(format(&t), wgpu::TextureFormat::R16Float);
    // rust: assert_eq!(bytes(&t, format(&t)), [0x00, 0x3c]);
    // rust: let t = texture("RG16I", Texels::Int(vec![-2, 3]));
    // rust: assert_eq!(format(&t), wgpu::TextureFormat::Rg16Sint);
    // rust: assert_eq!(bytes(&t, format(&t)), [0xfe, 0xff, 3, 0]);
    // rust: let t = texture("R8UI", Texels::Uint(vec![7]));
    // rust: assert_eq!(format(&t), wgpu::TextureFormat::R8Uint);
    // rust: assert_eq!(bytes(&t, format(&t)), [7]);
}
}
