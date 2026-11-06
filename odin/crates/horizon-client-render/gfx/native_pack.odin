//! Transpiled from Horizon Rust crate
package horizon_client_render_native_pack

import "core:fmt"
import "core:mem"
import "core:math"

// One of Horizon's own shader packs while it runs (docs/shaders.md): the frame its stages
// read, its sky, material and post stages, and the timer of their passes.

// use horizon_shader_api::{Report, StageKind};

// use super::displace::Displacement;
// use super::native_material::{DisplacedShape, NativeMaterial, TerrainShape};
// use super::native_post::{NativeFrame, NativePost};
// use super::native_shadow::{NativeShadow, ShadowGrid};
// use super::native_sky::NativeSky;
// use super::pack_timing::PassTiming;

NativePack :: struct {
    frame: NativeFrame,
    sky: Maybe(NativeSky),
    material: Maybe(NativeMaterial),
    post: Maybe(NativePost),
    // With a sky stage, what of Minecraft's sky still draws over it (`[sky]`).
    vanilla_clouds: bool,
    vanilla_sun: bool,
    vanilla_stars: bool,
    weather: Maybe(wgpu::RenderPipeline),
    // The draw of the shadow map the stages read, if the pack asks for one.
    shadow: Maybe(NativeShadow),
    // `[displacement]`'s grid, while it is on and the resource packs have height maps.
    displacement: Maybe(Displacement),
    // `[[particle_lights]]`.
    particle_lights: [dynamic]horizon_shader_api::manifest::ParticleLight,
    // `[[lights]]`, for the colour of held and dropped items' light.
    light_colors: [dynamic]horizon_shader_api::manifest::LightColor,
    // GPU time of each pass, while the renderer asks for it (`pack_timing.rs`).
    timing: Maybe(PassTiming),
}

// Whether the option `id` (a bool, or a number above 0) is on, or there is none to ask.
option_on :: proc(constants: ^[(string) {
}
    // rust: id.is_none_or(|id| {
    // rust: constants
    // rust: .iter()
    // rust: .find(|(k, _)| k == id)
    // rust: .is_none_or(|(_, v)| *v != 0.0)
    // rust: })
}

// `[displacement]`'s cells: the value of its `cells_option`, if any.
    // rust: fn chosen_cells(
    // rust: d: &horizon_shader_api::manifest::Displacement,
    // rust: options: &[horizon_shader_api::manifest::PackOption],
    // rust: constants: &[(String, f64)],
    // rust: ) -> u32 {
    // rust: let chosen = d.cells_option.as_ref().and_then(|id| {
    // rust: let option = options.iter().find(|o| o.id == *id)?;
    // rust: let horizon_shader_api::manifest::OptionKind::Choice { values, .. } = &option.kind else {
    // rust: return None;
}
    // rust: let (_, index) = constants.iter().find(|(k, _)| k == id)?;
    // rust: values.get(*index as usize)?.parse().ok()
    // rust: });
    // rust: chosen.unwrap_or(d.cells)
}

// `[shadow]` with the option values `constants`: none while its `option` is off, else the
// resolution and distance its `resolution_option` and `distance_option` pick.
    // rust: fn chosen_shadow(
    // rust: s: &horizon_shader_api::manifest::Shadow,
    // rust: options: &[horizon_shader_api::manifest::PackOption],
    // rust: constants: &[(String, f64)],
    // rust: ) -> Option<horizon_shader_api::manifest::Shadow> {
    // rust: let number = |id: Option<&String>| {
    // rust: let option = options.iter().find(|o| Some(&o.id) == id)?;
    // rust: let (_, value) = constants.iter().find(|(k, _)| *k == option.id)?;
    // rust: option.kind.number(*value)
}
    // rust: option_on(constants, s.option.as_ref()).then(|| horizon_shader_api::manifest::Shadow {
    // rust: resolution: number(s.resolution_option.as_ref()).map_or(s.resolution, |r| r as u32),
    // rust: distance: number(s.distance_option.as_ref()).map_or(s.distance, |d| d as f32),
    // rust: ..s.clone()
    // rust: })
}

    // rust: impl NativePack {
    // The pack of the checked stages `report` with the option values `constants`, drawing
    // onto the world's targets as `terrain` describes; the sky reads the terrain's group 0.
    // Also returns its stages' labels, in the order they draw. Errors name the stage wgpu
    // refused.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: terrain: &TerrainShape<'_>,
    // rust: report: Report,
    // rust: constants: &[(String, f64)],
    // rust: lights: super::block_light::LightTable,
    // rust: ) -> Result<(Self, Vec<String>), String> {
    // rust: let (globals, format) = (terrain.globals, terrain.format);
    // rust: let textures = super::native_post::pack_textures(device, queue, &report);
        // `[shadow]`, unless its option is off, at the size its options pick.
    // rust: let chosen = report
    // rust: .shadow
    // rust: .as_ref()
    // rust: .and_then(|s| chosen_shadow(s, &report.manifest.options, constants));
    // rust: let settings = chosen
    // rust: .as_ref()
    // rust: .map(|settings| super::native_shadow::fitted(device, settings));
    // rust: let mut frame = NativeFrame::new(device, settings.as_ref(), textures, lights, terrain.pbr);
        // `[displacement]`, unless its option is off; nothing to displace without heights.
    // rust: let displacement = report
    // rust: .manifest
    // rust: .displacement
    // rust: .as_ref()
    // rust: .filter(|d| option_on(constants, d.option.as_ref()))
    // rust: .filter(|_| terrain.pbr.is_some())
    // rust: .map(|d| {
                // No more cells than the height maps have texels.
    // rust: let texels = terrain.pbr.map_or(16, |p| p[0].width());
    // rust: let cells = chosen_cells(d, &report.manifest.options, constants)
    // rust: .min(texels)
    // rust: .max(1);
    // rust: let steps =
    // rust: d.steps_option.is_some() && option_on(constants, d.steps_option.as_ref());
    // rust: Displacement::new(
    // rust: device,
    // rust: d.distance,
    // rust: cells,
    // rust: steps,
    // rust: &frame.pbr[0],
    // rust: report.shadow.is_some(),
    // rust: )
    // rust: });
    // rust: let shadow = chosen
    // rust: .as_ref()
    // rust: .map(|s| {
    // rust: let vertex = report.stages.iter().find(|s| s.kind == StageKind::Vertex);
                // `[displacement]`'s grid casts too, from the material's module.
    // rust: let material = report.stages.iter().find(|s| s.kind == StageKind::Material);
    // rust: let grid = displacement.as_ref().and_then(|d| {
    // rust: let picks = d.shadow.as_ref()?;
    // rust: Some(ShadowGrid {
    // rust: distance: d.distance,
    // rust: cells: picks.cells,
    // rust: steps: picks.steps,
    // rust: material: material?,
    // rust: layout: &d.draw_layout,
    // rust: normals: &frame.pbr[0],
    // rust: })
    // rust: });
    // rust: NativeShadow::new(
    // rust: device,
    // rust: terrain,
    // rust: &frame,
    // rust: &s.solid_materials,
    // rust: vertex,
    // rust: constants,
    // rust: grid,
    // rust: )
    // rust: })
    // rust: .transpose()?;
        // The mirror is drawn for a material that reads it, while `[reflection] option` is on.
    // rust: let option = report.reflection.as_ref().and_then(|r| r.option.as_ref());
    // rust: frame.reflects = report
    // rust: .stages
    // rust: .iter()
    // rust: .find(|s| s.kind == StageKind::Material)
    // rust: .is_some_and(|s| s.reads("reflection"))
    // rust: && option_on(constants, option);
    // rust: let fog = report.material_fog;
    // rust: let keeps = |key: fn(&horizon_shader_api::Stage) -> Option<bool>| {
    // rust: report.sky.as_ref().and_then(key).unwrap_or(true)
}
    // rust: let vanilla_clouds = keeps(|s| s.clouds);
    // rust: let vanilla_sun = keeps(|s| s.sun);
    // rust: let vanilla_stars = keeps(|s| s.stars);
    // rust: let weather = report
    // rust: .stages
    // rust: .iter()
    // rust: .find(|s| s.kind == StageKind::Weather)
    // rust: .map(|stage| {
    // rust: super::weather::native_pipeline(
    // rust: device,
    // rust: format,
    // rust: terrain.weather_groups[0],
    // rust: terrain.weather_groups[1],
    // rust: &frame,
    // rust: stage,
    // rust: constants,
    // rust: )
    // rust: })
    // rust: .transpose()?;
    // rust: let weather_label = report
    // rust: .stages
    // rust: .iter()
    // rust: .find(|s| s.kind == StageKind::Weather)
    // rust: .map(|s| s.label.clone());
    // rust: let has_vertex = report.stages.iter().any(|s| s.kind == StageKind::Vertex);
    // rust: let (post, others): (Vec<_>, Vec<_>) = report
    // rust: .stages
    // rust: .into_iter()
    // rust: .partition(|s| s.kind == StageKind::Post);
    // rust: let sky = others
    // rust: .iter()
    // rust: .find(|s| s.kind == StageKind::Sky)
    // rust: .map(|stage| NativeSky::new(device, globals, &frame, stage, constants, format))
    // rust: .transpose()?;
    // rust: let material = others
    // rust: .iter()
    // rust: .find(|s| s.kind == StageKind::Material)
    // rust: .map(|stage| {
    // rust: let displaced = displacement.as_ref().map(|d| DisplacedShape {
    // rust: distance: d.distance,
    // rust: cells: d.view.cells,
    // rust: steps: d.view.steps,
    // rust: layout: &d.draw_layout,
    // rust: });
    // rust: NativeMaterial::new(
    // rust: device,
    // rust: terrain,
    // rust: &frame,
    // rust: stage,
    // rust: constants,
    // rust: fog,
    // rust: has_vertex,
    // rust: displaced.as_ref(),
    // rust: )
    // rust: })
    // rust: .transpose()?;
    // rust: let post = (!post.is_empty())
    // rust: .then(|| NativePost::new(device, post, &report.manifest, constants, format, &frame))
    // rust: .transpose()?;
    // rust: let mut labels: Vec<String> = sky.iter().map(|s| s.label.clone()).collect();
    // rust: labels.extend(
    // rust: others
    // rust: .iter()
    // rust: .filter(|s| material.is_some() && s.kind == StageKind::Material)
    // rust: .map(|s| s.label.clone()),
    // rust: );
    // rust: labels.extend(weather_label);
    // rust: if let Some(post) = &post {
    // rust: labels.extend(post.labels().into_iter().map(str::to_owned));
}
    // rust: let pack = Self {
    // rust: particle_lights: report.manifest.particle_lights.clone(),
    // rust: light_colors: report.manifest.lights.clone(),
    // rust: frame,
    // rust: sky,
    // rust: material,
    // rust: post,
    // rust: vanilla_clouds,
    // rust: vanilla_sun,
    // rust: vanilla_stars,
    // rust: weather,
    // rust: shadow,
    // rust: displacement,
    // rust: timing: None,
}
    // rust: Ok((pack, labels))
}

    // Whether the pack draws anything the game runs today.
draws :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sky.is_some()
    // rust: || self.material.is_some()
    // rust: || self.weather.is_some()
    // rust: || self.post.is_some()
}
}

    // rust: mod tests {
//     use super::chosen_shadow;
//     use horizon_shader_api::manifest::{OptionKind, PackOption, Shadow};

option :: proc(id: string, kind: OptionKind) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PackOption {
    // rust: id: id.into(),
    // rust: name: id.into(),
    // rust: description: String::new(),
    // rust: kind,
}
}

the_shadow_map_follows_its_options :: proc() {
}
    // rust: let options = [
    // rust: option("shadows", OptionKind::Bool { default: true }),
    // rust: option(
    // rust: "quality",
    // rust: OptionKind::Choice {
    // rust: values: vec!["1024".into(), "4096".into()],
    // rust: default: 0,
    // rust: },
    // rust: ),
    // rust: option(
    // rust: "reach",
    // rust: OptionKind::Int {
    // rust: default: 96,
    // rust: min: 32,
    // rust: max: 512,
    // rust: },
    // rust: ),
    // rust: ];
    // rust: let shadow = Shadow {
    // rust: option: Some("shadows".into()),
    // rust: resolution_option: Some("quality".into()),
    // rust: distance_option: Some("reach".into()),
    // rust: ..Shadow::default()
}
    // rust: let values = |on: f64, quality: f64, reach: f64| {
    // rust: [("shadows", on), ("quality", quality), ("reach", reach)].map(|(k, v)| (k.into(), v))
}
    // rust: let size = |values: &[(String, f64)]| {
    // rust: chosen_shadow(&shadow, &options, values).map(|s| (s.resolution, s.distance))
}
    // rust: assert_eq!(size(&values(1.0, 1.0, 200.0)), Some((4096, 200.0)));
    // rust: assert_eq!(size(&values(1.0, 0.0, 64.0)), Some((1024, 64.0)));
    // rust: assert_eq!(size(&values(0.0, 1.0, 200.0)), None);
        // Without the options' keys: the manifest's own numbers, always drawn.
    // rust: assert_eq!(
    // rust: chosen_shadow(&Shadow::default(), &options, &values(0.0, 1.0, 200.0))
    // rust: .map(|s| (s.resolution, s.distance)),
    // rust: Some((2048, 128.0))
    // rust: );
}
}
