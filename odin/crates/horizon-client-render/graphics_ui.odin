//! Transpiled from Horizon Rust crate
package horizon_client_render_graphics_ui

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's graphics settings screen: every video setting, vanilla's and
// Horizon's, on one list of pages (General, Quality, Performance, Shaders,
// Advanced, HDR) with a page list beside it, a search field over it and a description
// of the hovered setting with its cost. Which settings it shows, in what
// pages, with what description and cost, and its input live here; how it
// looks comes from `graphics_style`.
// use crate::{
    // rust: graphics::{
    // rust: EntityCullingMode, FarDetail, FrameGeneration, GraphicsApi, LeafCullingMode, Overlay,
    // rust: Pacing, ParticleCullingMode, PresentMode, Preset, Upscaling,
    // rust: },
    // rust: graphics_style::{self as style, Cost},
    // rust: hud::{HudAtlas, HudBatch},
    // rust: lang,
    // rust: settings::{Opt, Settings},
    // rust: settings_shell::{self as shell, Columns},
    // rust: text::Text,
    // rust: ui,
}

// The screen's pages, in its order.
Page :: enum {
    General,
    Quality,
    Performance,
    // Shader packs, either kind (`shader_pack_list`), and what they cost.
    Shaders,
    Advanced,
    // HDR output's own settings.
    Hdr,
}
    // rust: impl Page {
    // rust: pub const ALL: [Page; 6] = [
    // rust: Page::General,
    // rust: Page::Quality,
    // rust: Page::Performance,
    // rust: Page::Shaders,
    // rust: Page::Advanced,
    // rust: Page::Hdr,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Page::General => "General",
    // rust: Page::Quality => "Quality",
    // rust: Page::Performance => "Performance",
    // rust: Page::Shaders => "Shaders",
    // rust: Page::Advanced => "Advanced",
    // rust: Page::Hdr => "HDR",
}
}
    // What the page holds, in the strip while no setting is pointed at.
about :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Page::General => "How far you see, the window and the HUD.",
    // rust: Page::Quality => "The sky and weather, lighting, textures and the image.",
    // rust: Page::Performance => "Chunk loading, culling and power use.",
    // rust: Page::Shaders => "Shader packs, Horizon's and shaders/ folder ones, and their options.",
    // rust: Page::Advanced => "How frames reach the screen, and the performance overlay.",
    // rust: Page::Hdr => "Brighter-than-white output on an HDR display.",
}
}
}

// Horizon's own settings (`graphics::Graphics`).
H :: enum {
    Preset,
    LodDistance,
    FarDetail,
    BlueMapAutoDetect,
    BlueMapRadius,
    CaveCulling,
    GpuCulling,
    EntityCulling,
    EntityCullingPrecheck,
    ParticleCulling,
    LeafCulling,
    CacheShulkerBoxes,
    CacheSigns,
    CacheDecoratedPots,
    CacheBells,
    CacheChests,
    CacheBanners,
    CacheCopperGolemStatues,
    ChunkUpdates,
    UploadBudget,
    Sky,
    Fog,
    Weather,
    AnimatedTextures,
    DitherCutoutMips,
    PresentMode,
    Pacing,
    Workers,
    Overlay,
    ResolutionScale,
    Antialiasing,
    Upscaling,
    ScreenshotQuality,
    FrameGeneration,
    Hdr,
    HdrBlackLevel,
    // Binds `Graphics::hdr_key`.
    HdrKey,
    // Starts HDR calibration (`crate::hdr_calibration`).
    HdrCalibrate,
    HdrPeak,
    HdrPaperWhite,
    HdrUiBrightness,
    HdrLighting,
    BatteryMode,
    ShadowCache,
    // Opens the shader pack list (`options_ui::Page::ShaderPacks`).
    ShaderPacks,
    GraphicsApi,
    TranslucentBatching,
    HdrSmoothGradients,
}

Item :: enum {
    Vanilla(Opt),
    Horizon(H),
    // A Horizon extra that changes the picture (`extras::Item`, kept in `horizon-extras.txt`).
    Extra(crate::extras::Item),
}

Setting :: struct {
    item: Item,
    cost: Cost,
    text: ^'static str,
}
v :: proc(opt: Opt, cost: Cost, text: ^'static str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Setting {
    // rust: item: Item::Vanilla(opt),
    // rust: cost,
    // rust: text,
}
}
h :: proc(opt: H, cost: Cost, text: ^'static str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Setting {
    // rust: item: Item::Horizon(opt),
    // rust: cost,
    // rust: text,
}
}
// An extra's row: its description is its own language key.
e :: proc(item: crate::extras::Item, cost: Cost) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Setting {
    // rust: item: Item::Extra(item),
    // rust: cost,
    // rust: text: item.description_key(),
}
}

// Every page's settings, in named groups of related rows.
rows :: proc() -> V {
    // Ported from Horizon
    return {}
}
//     use Cost::*;
    // Suggested, never switched on, where far terrain costs the GPU most.
    // rust: let far = if crate::graphics::reduced_far_detail_suggested() {
    // rust: "Reduced draws far terrain coarser: faster on this integrated GPU."
    // rust: } else {
    // rust: "Reduced draws far terrain coarser, for GPUs it slows down."
}
    // rust: let mut pages = vec![
    // rust: (
    // rust: Page::General,
    // rust: vec![
    // rust: (
    // rust: "Preset",
    // rust: vec![
    // rust: h(
    // rust: H::Preset,
    // rust: None,
    // rust: "Sets the options below together. Changing one makes it Custom.",
    // rust: ),
    // rust: v(
    // rust: Opt::Preset,
    // rust: None,
    // rust: "Vanilla's own preset: sets only vanilla's options, as Minecraft does.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Distance",
    // rust: vec![
    // rust: v(
    // rust: Opt::RenderDistance,
    // rust: High,
    // rust: "Full-detail terrain range. LOD Distance can extend local worlds farther.",
    // rust: ),
    // rust: h(
    // rust: H::LodDistance,
    // rust: Medium,
    // rust: "Coarse distant terrain in local worlds. Integrated GPUs stop at 128 chunks.",
    // rust: ),
    // rust: h(H::FarDetail, Medium, far),
    // rust: h(
    // rust: H::BlueMapAutoDetect,
    // rust: None,
    // rust: "On servers, finds their BlueMap web map for far terrain. Next join.",
    // rust: ),
    // rust: h(
    // rust: H::BlueMapRadius,
    // rust: None,
    // rust: "How far around you BlueMap tiles are downloaded. Next join.",
    // rust: ),
    // rust: v(
    // rust: Opt::SimulationDistance,
    // rust: Medium,
    // rust: "How far mobs, crops and machines keep working. CPU time.",
    // rust: ),
    // rust: v(Opt::Gamma, None, "Brightens dark places."),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Display",
    // rust: vec![
    // rust: v(Opt::GuiScale, None, "Size of menus and the HUD."),
    // rust: v(Opt::Fullscreen, None, "Fills the screen (borderless)."),
    // rust: v(
    // rust: Opt::ExclusiveFullscreen,
    // rust: None,
    // rust: "Fullscreen takes the display over, at the mode below.",
    // rust: ),
    // rust: v(
    // rust: Opt::ExclusiveMode,
    // rust: None,
    // rust: "The display mode exclusive fullscreen uses. Applies when you leave.",
    // rust: ),
    // rust: v(
    // rust: Opt::Vsync,
    // rust: None,
    // rust: "Waits for the display's refresh: no tearing, a little latency.",
    // rust: ),
    // rust: v(
    // rust: Opt::MaxFps,
    // rust: None,
    // rust: "Caps frames per second; a cap saves power and heat.",
    // rust: ),
    // rust: v(
    // rust: Opt::InactivityFps,
    // rust: None,
    // rust: "Lowers the frame rate when minimised, or idle too.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Interface",
    // rust: vec![
    // rust: v(Opt::MenuBlur, Low, "Blurs the world behind menus."),
    // rust: v(Opt::AttackIndicator, None, "Shows attack cooldown."),
    // rust: v(Opt::Autosave, None, "Shows when the world saves."),
    // rust: ],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: Page::Quality,
    // rust: vec![
    // rust: (
    // rust: "Sky and weather",
    // rust: vec![
    // rust: v(
    // rust: Opt::Clouds,
    // rust: Low,
    // rust: "Cloud layer: off, flat (fast) or 3D (fancy).",
    // rust: ),
    // rust: v(Opt::CloudRange, Low, "How far clouds reach, in chunks."),
    // rust: h(H::Sky, Low, "Draws the sky, sun, moon and stars."),
    // rust: h(
    // rust: H::Fog,
    // rust: None,
    // rust: "Distance fog. Off shows the edge of the loaded world.",
    // rust: ),
    // rust: h(H::Weather, High, "Draws rain and snow."),
    // rust: v(
    // rust: Opt::WeatherRadius,
    // rust: Medium,
    // rust: "How far rain and snow fall around you.",
    // rust: ),
    // rust: v(Opt::Particles, Medium, "How many particles effects spawn."),
    // rust: e(crate::extras::Item::HideBlockParticles, None),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Lighting and entities",
    // rust: vec![
    // rust: v(
    // rust: Opt::SmoothLighting,
    // rust: Low,
    // rust: "Soft shadows in corners. Costs chunk building time only.",
    // rust: ),
    // rust: v(
    // rust: Opt::BiomeBlend,
    // rust: Low,
    // rust: "Blends grass and water colours across biomes when building chunks.",
    // rust: ),
    // rust: v(
    // rust: Opt::EntityDistance,
    // rust: Medium,
    // rust: "How far away mobs and items are drawn, as a share of normal.",
    // rust: ),
    // rust: v(
    // rust: Opt::EntityShadows,
    // rust: Low,
    // rust: "Round shadows under mobs and items.",
    // rust: ),
    // rust: v(Opt::Vignette, None, "Darkens the screen's edges."),
    // rust: v(Opt::ChunkFade, None, "Fades newly loaded chunks in."),
    // rust: e(crate::extras::Item::DynamicLights, Low),
    // rust: e(crate::extras::Item::Fullbright, None),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Textures",
    // rust: vec![
    // rust: v(
    // rust: Opt::Mipmaps,
    // rust: None,
    // rust: "Smaller copies of block textures for distant terrain: less shimmer.",
    // rust: ),
    // rust: v(
    // rust: Opt::TextureFiltering,
    // rust: Low,
    // rust: "How textures are sampled: sharper at a slant with Anisotropic.",
    // rust: ),
    // rust: v(
    // rust: Opt::MaxAnisotropy,
    // rust: Low,
    // rust: "How far Anisotropic filtering goes. Higher is sharper at a slant.",
    // rust: ),
    // rust: v(
    // rust: Opt::CutoutLeaves,
    // rust: Medium,
    // rust: "Leaves with see-through gaps. Off draws them solid.",
    // rust: ),
    // rust: v(
    // rust: Opt::ImprovedTransparency,
    // rust: Medium,
    // rust: "Sorts water and glass more exactly behind each other.",
    // rust: ),
    // rust: h(
    // rust: H::AnimatedTextures,
    // rust: Low,
    // rust: "Animates water, lava, fire and other moving textures.",
    // rust: ),
    // rust: h(
    // rust: H::DitherCutoutMips,
    // rust: Low,
    // rust: "Keeps fine plants in high-res packs from fading far away.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Image",
    // rust: vec![
    // rust: h(
    // rust: H::ResolutionScale,
    // rust: High,
    // rust: "World pixels per screen pixel. Below 100% is faster on the GPU.",
    // rust: ),
    // rust: h(
    // rust: H::Antialiasing,
    // rust: Medium,
    // rust: "Smooths jagged edges. FXAA: softer. TAA: smoothest, moving things may trail.",
    // rust: ),
    // rust: h(
    // rust: H::Upscaling,
    // rust: High,
    // rust: "Renders the world smaller and rebuilds it with TAA. Faster, softer.",
    // rust: ),
    // rust: h(
    // rust: H::ScreenshotQuality,
    // rust: None,
    // rust: "F2 screenshots at this many times the game's resolution. Higher takes longer.",
    // rust: ),
    // rust: h(
    // rust: H::FrameGeneration,
    // rust: Medium,
    // rust: "Shows a made-up frame between each two real ones: smoother, a little more lag.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: Page::Performance,
    // rust: vec![
    // rust: (
    // rust: "Chunk loading",
    // rust: vec![
    // rust: v(
    // rust: Opt::ChunkBuilder,
    // rust: Low,
    // rust: "Which chunk rebuilds wait for the frame: none, nearby or yours.",
    // rust: ),
    // rust: h(
    // rust: H::ChunkUpdates,
    // rust: Low,
    // rust: "Meshed sections uploaded per frame. Lower is smoother while loading.",
    // rust: ),
    // rust: h(
    // rust: H::UploadBudget,
    // rust: Low,
    // rust: "Mesh data sent to the GPU per frame. Lower is smoother while loading.",
    // rust: ),
    // rust: h(
    // rust: H::Workers,
    // rust: None,
    // rust: "Threads that generate, light and mesh chunks. Next start.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Culling",
    // rust: vec![
    // rust: h(
    // rust: H::CaveCulling,
    // rust: Saves,
    // rust: "Skips terrain hidden behind closed sections. Off costs a lot.",
    // rust: ),
    // rust: h(
    // rust: H::GpuCulling,
    // rust: Saves,
    // rust: "Culls nearby terrain on the GPU: less CPU at high render distance, more GPU.",
    // rust: ),
    // rust: h(
    // rust: H::EntityCulling,
    // rust: None,
    // rust: "Hides entities behind opaque blocks.",
    // rust: ),
    // rust: h(
    // rust: H::ParticleCulling,
    // rust: Saves,
    // rust: "Skips particles outside the view, below one pixel or behind terrain.",
    // rust: ),
    // rust: h(
    // rust: H::EntityCullingPrecheck,
    // rust: Saves,
    // rust: "Runs the mob AABB precheck after this many loaded mobs. Zero disables it.",
    // rust: ),
    // rust: h(
    // rust: H::LeafCulling,
    // rust: Saves,
    // rust: "Draws or drops leaf faces inside canopies. Off keeps vanilla's fancy leaves.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Block Entities",
    // rust: vec![
    // rust: h(
    // rust: H::CacheShulkerBoxes,
    // rust: Saves,
    // rust: "Reuses settled boxes; lid movement stays animated.",
    // rust: ),
    // rust: h(
    // rust: H::CacheSigns,
    // rust: Saves,
    // rust: "Reuses sign text until text, light, or font changes.",
    // rust: ),
    // rust: h(
    // rust: H::CacheDecoratedPots,
    // rust: Saves,
    // rust: "Reuses still pots; break wobble and sherd changes redraw.",
    // rust: ),
    // rust: h(
    // rust: H::CacheBells,
    // rust: Saves,
    // rust: "Reuses still bells; ringing stays animated.",
    // rust: ),
    // rust: h(
    // rust: H::CacheChests,
    // rust: Saves,
    // rust: "Reuses closed chests; moving lids stay animated.",
    // rust: ),
    // rust: h(
    // rust: H::CacheBanners,
    // rust: Saves,
    // rust: "Reuses poles; flags and pattern layers still update.",
    // rust: ),
    // rust: h(
    // rust: H::CacheCopperGolemStatues,
    // rust: Saves,
    // rust: "Reuses statue geometry until its block state changes.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Power",
    // rust: vec![h(
    // rust: H::BatteryMode,
    // rust: None,
    // rust: "60 FPS cap (30 in menus or unfocused), half the workers: less power.",
    // rust: )],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: Page::Shaders,
    // rust: vec![(
    // rust: "Shader packs",
    // rust: vec![
    // rust: h(
    // rust: H::ShaderPacks,
    // rust: High,
    // rust: "Picks a shader pack, Horizon's or a shaders/ folder one, and sets its options.",
    // rust: ),
    // rust: h(
    // rust: H::ShadowCache,
    // rust: Saves,
    // rust: "Reuses the pack shadow map when sun, view and world match. Off by default.",
    // rust: ),
    // rust: ],
    // rust: )],
    // rust: ),
    // rust: (
    // rust: Page::Advanced,
    // rust: vec![
    // rust: (
    // rust: "Frames",
    // rust: vec![
    // rust: h(
    // rust: H::PresentMode,
    // rust: None,
    // rust: "How frames reach the screen while VSync is off.",
    // rust: ),
    // rust: h(
    // rust: H::Pacing,
    // rust: None,
    // rust: "Efficient sleeps until the next frame; Precise spins, like vanilla.",
    // rust: ),
    // rust: h(
    // rust: H::GraphicsApi,
    // rust: None,
    // rust: "Vulkan, then DirectX 12 (Windows) or OpenGL (Linux) where it fails. Next start.",
    // rust: ),
    // rust: h(
    // rust: H::TranslucentBatching,
    // rust: Saves,
    // rust: "Water and glass in one buffer: fewer draw calls, a bit more VRAM. Next start.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Overlay",
    // rust: vec![h(
    // rust: H::Overlay,
    // rust: None,
    // rust: "Frame rate and frame times over the game, with a graph.",
    // rust: )],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: Page::Hdr,
    // rust: vec![
    // rust: (
    // rust: "Output",
    // rust: vec![
    // rust: h(
    // rust: H::Hdr,
    // rust: None,
    // rust: "Lava, fire and sunlight shine brighter than white. Needs an HDR display.",
    // rust: ),
    // rust: h(
    // rust: H::HdrSmoothGradients,
    // rust: Low,
    // rust: "16-bit frame: dark skies and shadows don't band. A bit more VRAM. Next start.",
    // rust: ),
    // rust: h(
    // rust: H::HdrCalibrate,
    // rust: None,
    // rust: "Sets the three below full screen, one test picture at a time.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Brightness",
    // rust: vec![
    // rust: h(
    // rust: H::HdrBlackLevel,
    // rust: None,
    // rust: "Your display's darkest black. 0 for OLED; LCDs glow a little.",
    // rust: ),
    // rust: h(
    // rust: H::HdrPeak,
    // rust: None,
    // rust: "How bright highlights get. Auto: the peak your system reports.",
    // rust: ),
    // rust: h(
    // rust: H::HdrPaperWhite,
    // rust: None,
    // rust: "How bright white paper and menus look. Auto: your desktop's white.",
    // rust: ),
    // rust: h(
    // rust: H::HdrUiBrightness,
    // rust: None,
    // rust: "How bright the HUD and menus are, against paper white.",
    // rust: ),
    // rust: h(
    // rust: H::HdrLighting,
    // rust: None,
    // rust: "Light sources, the sun and sunlight shine past white. Off: just as SDR.",
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "Shortcut",
    // rust: vec![h(
    // rust: H::HdrKey,
    // rust: None,
    // rust: "A key that opens this screen from the game. Not bound at first.",
    // rust: )],
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: ];
    // Only Windows and Linux have more than one graphics API, translucent batching (Metal
    // draws flat) and GPU culling (Metal draws no count the GPU wrote).
    // rust: if cfg!(target_os = "macos") {
    // rust: for (_, groups) in &mut pages {
    // rust: for (_, rows) in groups {
    // rust: rows.retain(|r| {
    // rust: !matches!(
    // rust: r.item,
    // rust: Item::Horizon(H::GraphicsApi | H::TranslucentBatching | H::GpuCulling)
    // rust: )
    // rust: });
}
}
}
    // rust: pages
}

// BlueMap download radii, in chunks.
BLUE_MAP_RADII :: [16, 32, 64, 128, 256]
UPLOAD_STEPS :: [0, 256, 512, 1024, 2048, 4096, 8192, 16384]
// What the LOD Distance slider stops at, in chunks: off, then each doubling
// up to the whole world.
    // rust: const LOD_STEPS: [u32; 18] = [
    // rust: 0,
    // rust: 64,
    // rust: 128,
    // rust: 256,
    // rust: 512,
    // rust: 1024,
    // rust: 2048,
    // rust: 4096,
    // rust: 8192,
    // rust: 16384,
    // rust: 32768,
    // rust: 65536,
    // rust: 131072,
    // rust: 262144,
    // rust: 524288,
    // rust: 1048576,
    // rust: 2097152,
    // rust: crate::lod::MAX_CHUNKS,
    // rust: ];

// Whether the system set HDR up for the display, and whether the player kept it.
Setup :: enum {
    // The system says nothing: the player calibrates.
    Unknown,
    // Peak Brightness and Paper White follow the system.
    Automatic,
    // The system said, and the player changed them anyway.
    Changed,
}
setup :: proc(s: ^Settings) -> S {
    // Ported from Horizon
    return {}
}
    // rust: setup_of(&s.horizon, crate::graphics::reported().is_some())
}
setup_of :: proc(g: ^crate::graphics::Graphics, reported: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if !reported {
    // rust: Setup::Unknown
    // rust: } else if g.hdr_peak == 0 && g.hdr_paper_white == 0 {
    // rust: Setup::Automatic
    // rust: } else {
    // rust: Setup::Changed
}
}
// The description beside `item` where it depends on [`setup`]; `text` otherwise.
description :: proc(item: Item, s: ^Settings, text: ^'static str) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (item, setup(s)) {
    // rust: (Item::Horizon(H::HdrCalibrate), Setup::Unknown) => {
    // rust: "Your display didn't say how bright it gets: calibrate to set it up."
}
    // rust: (Item::Horizon(H::HdrCalibrate), Setup::Automatic) => {
    // rust: "Already set up for your display. Only calibrate if HDR looks wrong."
}
    // rust: (Item::Horizon(H::HdrCalibrate), Setup::Changed) => {
    // rust: "Puts Peak Brightness and Paper White back to your display's setup."
}
    // rust: (Item::Horizon(H::HdrPeak | H::HdrPaperWhite), Setup::Automatic | Setup::Changed) => {
    // rust: "Set up for your display. Leave on Auto unless it looks wrong."
}
    // rust: (Item::Horizon(H::EntityCulling), _) => match s.horizon.entity_culling {
    // rust: EntityCullingMode::Off => "No entity occlusion culling.",
    // rust: EntityCullingMode::Synchronous => "CPU occlusion test runs this frame.",
    // rust: EntityCullingMode::Asynchronous => "Occlusion checks run on a worker thread.",
    // rust: },
    // rust: (Item::Horizon(H::LeafCulling), _) => match s.horizon.leaf_culling {
    // rust: LeafCullingMode::Off => "Every leaf face. Vanilla's fancy leaves.",
    // rust: LeafCullingMode::Hidden => {
    // rust: "Drops leaf faces behind two leaf layers: faster, same crowns."
}
    // rust: LeafCullingMode::Solid => {
    // rust: "Leaves fully inside a canopy draw solid: fewer see-through layers."
}
    // rust: LeafCullingMode::SolidAggressive => {
    // rust: "Leaves with one open side draw solid too: faster, chunkier edges."
}
    // rust: LeafCullingMode::Hollow => "Drops faces between leaves: faster, but gaps look through.",
    // rust: },
    // rust: (Item::Horizon(H::ParticleCulling), _) => match s.horizon.particle_culling {
    // rust: ParticleCullingMode::Off => "Draws every particle.",
    // rust: ParticleCullingMode::Synchronous => {
    // rust: "Skips offscreen, subpixel and terrain-hidden particles."
}
    // rust: ParticleCullingMode::Asynchronous => {
    // rust: "Skips offscreen, subpixel and terrain-hidden particles with less render-thread work."
}
    // rust: },
    // rust: _ => text,
}
}
on_off :: proc(on: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: lang::get(if on { "On" } else { "Off" })
}
// A control's caption and its value, both through the language table: Horizon's captions are
// English sentences, and some of the values ("Off", "12 chunks") are words too.
// "Caption: value" (`options.generic_value`), both looked up in the language table.
labelled :: proc(caption: string, value: impl std::fmt::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let value = value.to_string();
    // rust: Text::option_name_value(
    // rust: Text::literal(lang::get(caption)),
    // rust: Text::literal(lang::get(&value)),
    // rust: )
}
// "Caption: 50%" (`options.percent_value`, Options.percentValueLabel): French and German put a
// space before the `%`.
labelled_percent :: proc(caption: string, percent: u32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate_with_fallback(
    // rust: "options.percent_value",
    // rust: "%s: %s%%",
    // rust: &[
    // rust: Text::literal(lang::get(caption)),
    // rust: Text::literal(percent.to_string()),
    // rust: ],
    // rust: )
}

    // rust: impl H {
slider :: proc(self: ^Self, s: ^Settings) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let g = &s.horizon;
    // rust: match self {
    // rust: H::ChunkUpdates => Some(g.chunk_updates as f32 / 64.0),
    // rust: H::EntityCullingPrecheck => Some(g.entity_culling_precheck as f32 / 512.0),
    // rust: H::UploadBudget => {
    // rust: let i = UPLOAD_STEPS
    // rust: .iter()
    // rust: .position(|&b| b >= g.upload_budget_kib)
    // rust: .unwrap_or(UPLOAD_STEPS.len() - 1);
    // rust: Some(i as f32 / (UPLOAD_STEPS.len() - 1) as f32)
}
    // rust: H::LodDistance => {
    // rust: let i = LOD_STEPS
    // rust: .iter()
    // rust: .position(|&d| d >= g.lod_distance)
    // rust: .unwrap_or(LOD_STEPS.len() - 1);
    // rust: Some(i as f32 / (LOD_STEPS.len() - 1) as f32)
}
    // rust: H::Workers => Some(g.workers as f32 / max_workers() as f32),
    // rust: H::ResolutionScale => Some((g.resolution_scale as f32 - 50.0) / 150.0),
            // Auto, then 10..480 by 10.
    // rust: H::HdrPaperWhite => Some(g.hdr_paper_white as f32 / 480.0),
            // Auto, then 200..2000 by 50.
    // rust: H::HdrPeak => Some(match g.hdr_peak {
    // rust: 0 => 0.0,
    // rust: n => (n as f32 - 150.0) / 1850.0,
    // rust: }),
    // rust: H::HdrBlackLevel => Some(g.hdr_black_level as f32 / 100.0),
    // rust: H::HdrUiBrightness => Some((g.hdr_ui_brightness as f32 - 25.0) / 75.0),
    // rust: _ => None,
}
}
slider_steps :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: H::ChunkUpdates => Some(64),
    // rust: H::EntityCullingPrecheck => Some(32),
    // rust: H::UploadBudget => Some((UPLOAD_STEPS.len() - 1) as u32),
    // rust: H::Workers => Some(max_workers()),
    // rust: H::ResolutionScale => Some(30),
    // rust: H::HdrPaperWhite => Some(41),
    // rust: H::HdrPeak => Some(37),
    // rust: H::HdrBlackLevel => Some(100),
    // rust: H::HdrUiBrightness => Some(15),
    // rust: _ => None,
}
}
label :: proc(self: ^Self, s: ^Settings) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let g = &s.horizon;
    // rust: match self {
    // rust: H::Preset => labelled("Preset", g.preset.label()),
    // rust: H::LodDistance => match g.lod_distance {
    // rust: 0 => labelled("LOD Distance", "Off"),
    // rust: n => labelled("LOD Distance", lang::tr("%s chunks", &[&n])),
    // rust: },
    // rust: H::FarDetail => labelled("Far Detail", g.far_detail.label()),
    // rust: H::BlueMapAutoDetect => labelled("Find BlueMap", on_off(g.blue_map.auto_detect)),
    // rust: H::BlueMapRadius => labelled(
    // rust: "BlueMap Radius",
    // rust: lang::tr("%s chunks", &[&g.blue_map.radius_chunks()]),
    // rust: ),
    // rust: H::CaveCulling => labelled("Cave Culling", on_off(g.cave_culling)),
            // Greyed out where it isn't offered (`Item::blocked`): Off, as it is there, while
            // the saved value waits.
    // rust: H::GpuCulling => labelled(
    // rust: "GPU Culling",
    // rust: on_off(g.gpu_culling && crate::graphics::gpu_culling_offer().reason().is_none()),
    // rust: ),
    // rust: H::EntityCulling => labelled("Entity Culling", g.entity_culling.label()),
    // rust: H::EntityCullingPrecheck => labelled(
    // rust: "Entity Culling Precheck",
    // rust: if g.entity_culling_precheck == 0 {
    // rust: "Off".to_string()
    // rust: } else {
    // rust: lang::tr("%s mobs", &[&g.entity_culling_precheck])
    // rust: },
    // rust: ),
    // rust: H::ParticleCulling => labelled("Particle Culling", g.particle_culling.label()),
    // rust: H::LeafCulling => labelled("Leaf Culling", g.leaf_culling.label()),
    // rust: H::CacheShulkerBoxes => labelled("Shulker Boxes", on_off(g.cache_shulker_boxes)),
    // rust: H::CacheSigns => labelled("Signs", on_off(g.cache_signs)),
    // rust: H::CacheDecoratedPots => labelled("Decorated Pots", on_off(g.cache_decorated_pots)),
    // rust: H::CacheBells => labelled("Bells", on_off(g.cache_bells)),
    // rust: H::CacheChests => labelled("Chests", on_off(g.cache_chests)),
    // rust: H::CacheBanners => labelled("Banners", on_off(g.cache_banners)),
    // rust: H::CacheCopperGolemStatues => {
    // rust: labelled("Copper Golem Statues", on_off(g.cache_copper_golem_statues))
}
    // rust: H::ChunkUpdates => match g.chunk_updates {
    // rust: 0 => labelled("Chunk Updates", "Unlimited"),
    // rust: n => labelled("Chunk Updates", lang::tr("%s per frame", &[&n])),
    // rust: },
    // rust: H::UploadBudget => match g.upload_budget_kib {
    // rust: 0 => labelled("Upload Budget", "Unlimited"),
    // rust: k if k >= 1024 => {
    // rust: labelled("Upload Budget", lang::tr("%s MiB/frame", &[&(k / 1024)]))
}
    // rust: k => labelled("Upload Budget", lang::tr("%s KiB/frame", &[&k])),
    // rust: },
    // rust: H::Sky => labelled("Sky", on_off(g.sky)),
    // rust: H::Fog => labelled("Fog", on_off(g.fog)),
    // rust: H::Weather => labelled("Weather", on_off(g.weather)),
    // rust: H::AnimatedTextures => labelled("Animated Textures", on_off(g.animated_textures)),
    // rust: H::DitherCutoutMips => labelled("Distant Plant Dither", on_off(g.dither_cutout_mips)),
    // rust: H::PresentMode => labelled("Present Mode", g.present_mode.label()),
    // rust: H::Pacing => labelled(
    // rust: "Frame Pacing",
    // rust: match g.pacing {
    // rust: Pacing::Efficient => "Efficient",
    // rust: Pacing::Precise => "Precise",
    // rust: },
    // rust: ),
    // rust: H::Workers => match g.workers {
    // rust: 0 => labelled(
    // rust: "Worker Threads",
    // rust: lang::tr("Auto (%s)", &[&g.worker_threads()]),
    // rust: ),
    // rust: n => labelled("Worker Threads", n),
    // rust: },
    // rust: H::ResolutionScale => labelled_percent("Resolution Scale", g.resolution_scale),
    // rust: H::Antialiasing => labelled(
    // rust: "Anti-aliasing",
    // rust: match (g.fxaa, g.taa) {
    // rust: (_, true) => "TAA",
    // rust: (true, false) => "FXAA",
    // rust: (false, false) => "Off",
    // rust: },
    // rust: ),
    // rust: H::Upscaling => labelled("Upscaling", g.upscaling.label()),
    // rust: H::ScreenshotQuality => {
    // rust: labelled("Screenshot Quality", format!("{}x", g.screenshot_quality))
}
    // rust: H::FrameGeneration => labelled("Frame Generation", g.frame_generation.label()),
    // rust: H::Hdr => labelled("HDR", on_off(g.hdr)),
    // rust: H::HdrCalibrate => Text::literal(lang::get(match setup(s) {
    // rust: Setup::Unknown => "Calibrate...",
    // rust: Setup::Automatic => "Calibrate Anyway...",
    // rust: Setup::Changed => "Use Automatic Setup",
    // rust: })),
    // rust: H::HdrPaperWhite => match g.hdr_paper_white {
    // rust: 0 => labelled(
    // rust: "Paper White",
    // rust: lang::tr("Auto (%s)", &[&g.paper_white_nits()]),
    // rust: ),
    // rust: n => labelled("Paper White", n.to_string()),
    // rust: },
    // rust: H::HdrPeak => match g.hdr_peak {
    // rust: 0 => labelled("Peak Brightness", lang::tr("Auto (%s)", &[&g.peak_nits()])),
    // rust: n => labelled("Peak Brightness", n.to_string()),
    // rust: },
    // rust: H::HdrBlackLevel => match g.hdr_black_level {
    // rust: 0 => labelled(
    // rust: "Black Level",
    // rust: lang::tr("Auto (%s)", &[&format!("{:.2}", g.black_level_nits())]),
    // rust: ),
    // rust: n => labelled("Black Level", format!("{:.2}", n as f32 / 100.0)),
    // rust: },
    // rust: H::HdrUiBrightness => labelled_percent("UI Brightness", g.hdr_ui_brightness),
    // rust: H::HdrLighting => labelled("HDR Lighting", on_off(g.hdr_lighting)),
    // rust: H::HdrKey => {
    // rust: Text::translate("Shortcut: %s", &[crate::keybinds::display_name(&g.hdr_key)])
}
    // rust: H::BatteryMode => labelled("Battery Mode", on_off(g.battery)),
    // rust: H::ShadowCache => labelled("Shadow Cache", on_off(g.shadow_cache)),
            // A press across the row, as Calibrate...: the list it opens shows the pick.
    // rust: H::ShaderPacks => Text::literal(lang::get("Shader Packs...")),
    // rust: H::GraphicsApi => labelled("Graphics API", g.api.label()),
            // These two are greyed out where the device can't (`Item::blocked`): Off, as
            // they are there, while the saved value waits for a device that can.
    // rust: H::TranslucentBatching => labelled(
    // rust: "Translucent Batching",
    // rust: on_off(g.translucent_batching && crate::graphics::translucent_batching_offered()),
    // rust: ),
    // rust: H::HdrSmoothGradients => labelled(
    // rust: "Smooth Gradients",
    // rust: on_off(g.hdr_smooth_gradients && crate::graphics::smooth_gradients_offered()),
    // rust: ),
    // rust: H::Overlay => labelled(
    // rust: "Performance Overlay",
    // rust: match g.overlay {
    // rust: Overlay::Off => "Off",
    // rust: Overlay::Fps => "FPS",
    // rust: Overlay::Graph => "FPS and Graph",
    // rust: },
    // rust: ),
}
}
set_slider :: proc(self: ^Self, s: ^Settings, v: f32) {
}
    // rust: let g = &mut s.horizon;
    // rust: match self {
    // rust: H::ChunkUpdates => g.chunk_updates = (v * 64.0).round() as u32,
    // rust: H::EntityCullingPrecheck => g.entity_culling_precheck = (v * 512.0).round() as u32,
    // rust: H::UploadBudget => {
    // rust: g.upload_budget_kib =
    // rust: UPLOAD_STEPS[(v * (UPLOAD_STEPS.len() - 1) as f32).round() as usize]
}
    // rust: H::LodDistance => {
    // rust: g.lod_distance = LOD_STEPS[(v * (LOD_STEPS.len() - 1) as f32).round() as usize]
}
    // rust: H::Workers => g.workers = (v * max_workers() as f32).round() as u32,
    // rust: H::ResolutionScale => g.resolution_scale = (50.0 + (v * 30.0).round() * 5.0) as u32,
    // rust: H::HdrPaperWhite => g.hdr_paper_white = (v * 48.0).round() as u32 * 10,
    // rust: H::HdrPeak => {
    // rust: g.hdr_peak = match (v * 37.0).round() as u32 {
    // rust: 0 => 0,
    // rust: step => 150 + step * 50,
}
}
    // rust: H::HdrBlackLevel => g.hdr_black_level = (v * 100.0).round() as u32,
    // rust: H::HdrUiBrightness => g.hdr_ui_brightness = (25.0 + (v * 15.0).round() * 5.0) as u32,
    // rust: _ => {}
}
}
cycle :: proc(self: ^Self, s: ^Settings, back: bool) {
}
    // rust: fn step<T: Copy + PartialEq>(all: &[T], now: T, back: bool) -> T {
    // rust: let i = all.iter().position(|x| *x == now).unwrap_or(0);
    // rust: let n = all.len();
    // rust: all[if back { (i + n - 1) % n } else { (i + 1) % n }]
}
    // rust: if self == H::Preset {
    // rust: let preset = step(&Preset::ALL, s.horizon.preset, back);
    // rust: crate::graphics::apply_preset(preset, s);
    // rust: s.horizon.preset = preset;
    // rust: return;
}
    // rust: let g = &mut s.horizon;
    // rust: match self {
    // rust: H::FarDetail => {
    // rust: g.far_detail = step(&[FarDetail::Full, FarDetail::Reduced], g.far_detail, back)
}
    // rust: H::BlueMapAutoDetect => g.blue_map.auto_detect = !g.blue_map.auto_detect,
    // rust: H::BlueMapRadius => {
    // rust: g.blue_map.radius = step(&BLUE_MAP_RADII, g.blue_map.radius_chunks(), back)
}
    // rust: H::CaveCulling => g.cave_culling = !g.cave_culling,
    // rust: H::GpuCulling => g.gpu_culling = !g.gpu_culling,
    // rust: H::EntityCulling => {
    // rust: g.entity_culling = step(&EntityCullingMode::ALL, g.entity_culling, back)
}
    // rust: H::ParticleCulling => {
    // rust: g.particle_culling = step(&ParticleCullingMode::ALL, g.particle_culling, back)
}
    // rust: H::LeafCulling => {
    // rust: g.leaf_culling = step(&LeafCullingMode::ALL, g.leaf_culling, back);
}
    // rust: H::CacheShulkerBoxes => g.cache_shulker_boxes = !g.cache_shulker_boxes,
    // rust: H::CacheSigns => g.cache_signs = !g.cache_signs,
    // rust: H::CacheDecoratedPots => g.cache_decorated_pots = !g.cache_decorated_pots,
    // rust: H::CacheBells => g.cache_bells = !g.cache_bells,
    // rust: H::CacheChests => g.cache_chests = !g.cache_chests,
    // rust: H::CacheBanners => g.cache_banners = !g.cache_banners,
    // rust: H::CacheCopperGolemStatues => {
    // rust: g.cache_copper_golem_statues = !g.cache_copper_golem_statues
}
    // rust: H::Sky => g.sky = !g.sky,
    // rust: H::Fog => g.fog = !g.fog,
    // rust: H::Weather => g.weather = !g.weather,
    // rust: H::AnimatedTextures => g.animated_textures = !g.animated_textures,
    // rust: H::DitherCutoutMips => g.dither_cutout_mips = !g.dither_cutout_mips,
    // rust: H::PresentMode => g.present_mode = step(&PresentMode::ALL, g.present_mode, back),
            // Off, FXAA, TAA.
    // rust: H::Antialiasing => {
    // rust: let i = if g.taa { 2 } else { usize::from(g.fxaa) };
    // rust: let i = (i + if back { 2 } else { 1 }) % 3;
    // rust: (g.fxaa, g.taa) = (i == 1, i == 2);
    // rust: if !g.taa {
    // rust: g.upscaling = Upscaling::Native;
}
}
            // Upscaling is TAA's: picking a ratio turns it on.
    // rust: H::Upscaling => {
    // rust: g.upscaling = step(&Upscaling::ALL, g.upscaling, back);
    // rust: if g.upscaling != Upscaling::Native {
    // rust: (g.fxaa, g.taa) = (false, true);
}
}
    // rust: H::ScreenshotQuality => {
    // rust: g.screenshot_quality = step(
    // rust: &crate::graphics::SCREENSHOT_QUALITIES,
    // rust: g.screenshot_quality,
    // rust: back,
    // rust: )
}
    // rust: H::FrameGeneration => {
    // rust: g.frame_generation = step(&FrameGeneration::ALL, g.frame_generation, back)
}
    // rust: H::Hdr => g.hdr = !g.hdr,
    // rust: H::HdrLighting => g.hdr_lighting = !g.hdr_lighting,
    // rust: H::BatteryMode => g.battery = !g.battery,
    // rust: H::ShadowCache => g.shadow_cache = !g.shadow_cache,
    // rust: H::GraphicsApi => g.api = step(GraphicsApi::choices(), g.api, back),
    // rust: H::TranslucentBatching => g.translucent_batching = !g.translucent_batching,
    // rust: H::HdrSmoothGradients => g.hdr_smooth_gradients = !g.hdr_smooth_gradients,
    // rust: H::Pacing => {
    // rust: g.pacing = match g.pacing {
    // rust: Pacing::Efficient => Pacing::Precise,
    // rust: Pacing::Precise => Pacing::Efficient,
}
}
    // rust: H::Overlay => {
    // rust: g.overlay = step(
    // rust: &[Overlay::Off, Overlay::Fps, Overlay::Graph],
    // rust: g.overlay,
    // rust: back,
    // rust: )
}
    // rust: _ => {}
}
}
}
max_workers :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: std::thread::available_parallelism().map_or(8, |n| n.get() as u32)
}

    // rust: impl Item {
    // False for a setting whose system is not in Horizon yet (`Opt::available`).
available :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !matches!(self, Item::Vanilla(o) if !o.available())
}
    // Why a control can't be used now, when it can't: HDR's page works only where
    // the display offers HDR output, whatever `horizon-graphics.txt` says (a copied game
    // folder, a display swapped for an SDR one: the renderer leaves HDR off there, and
    // the saved values wait for an HDR display), and its sliders do something only
    // while it is on; Translucent Batching switches only where the device can batch
    // (`graphics::translucent_batching_offered`), its saved value waiting for one that can,
    // Smooth Gradients only where it can draw the 16-bit frame, the same way, and GPU Culling
    // only where it is offered (`graphics::gpu_culling_offer`), with the reason it isn't.
blocked :: proc(self: ^Self, s: ^Settings) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.available() {
    // rust: return Some("This feature is not yet available in Horizon.");
}
    // rust: match self {
    // rust: Item::Horizon(
    // rust: H::Hdr
    // rust: | H::HdrCalibrate
    // rust: | H::HdrBlackLevel
    // rust: | H::HdrPeak
    // rust: | H::HdrPaperWhite
    // rust: | H::HdrUiBrightness
    // rust: | H::HdrLighting
    // rust: | H::HdrSmoothGradients,
    // rust: ) if !crate::graphics::hdr_offered() => {
    // rust: Some("Your display or system doesn't offer HDR output.")
}
    // rust: Item::Horizon(H::HdrSmoothGradients)
    // rust: if !crate::graphics::smooth_gradients_offered() =>
    // rust: {
    // rust: Some("Your GPU or graphics API doesn't support it.")
}
    // rust: Item::Horizon(
    // rust: H::HdrCalibrate
    // rust: | H::HdrBlackLevel
    // rust: | H::HdrPeak
    // rust: | H::HdrPaperWhite
    // rust: | H::HdrUiBrightness
    // rust: | H::HdrLighting
    // rust: | H::HdrSmoothGradients,
    // rust: ) if !s.horizon.hdr => Some("Turn HDR on to use it."),
    // rust: Item::Horizon(H::TranslucentBatching)
    // rust: if !crate::graphics::translucent_batching_offered() =>
    // rust: {
    // rust: Some("Your GPU or graphics API doesn't support it.")
}
    // rust: Item::Horizon(H::EntityCullingPrecheck)
    // rust: if s.horizon.entity_culling != EntityCullingMode::Asynchronous =>
    // rust: {
    // rust: Some("Only applies to asynchronous entity culling.")
}
    // rust: Item::Horizon(H::GpuCulling) => crate::graphics::gpu_culling_offer().reason(),
            // VideoSettingsScreen.tick: Max Anisotropy only works with Anisotropic filtering.
    // rust: Item::Vanilla(Opt::MaxAnisotropy) if s.file.int("textureFiltering") != 2 => {
    // rust: Some("Only with Anisotropic texture filtering.")
}
    // rust: _ => None,
}
}
    // A value stepped between `<` `>`: not a tick box, a slider or a press.
steps :: proc(self: ^Self, s: ^Settings) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.switch(s).is_none()
    // rust: && self.slider(s).is_none()
    // rust: && !matches!(
    // rust: self,
    // rust: Item::Horizon(H::HdrKey | H::HdrCalibrate | H::ShaderPacks)
    // rust: )
}
    // On/off settings and their value.
switch :: proc(self: ^Self, s: ^Settings) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let g = &s.horizon;
    // rust: Some(match self {
    // rust: Item::Horizon(H::BlueMapAutoDetect) => g.blue_map.auto_detect,
    // rust: Item::Horizon(H::CaveCulling) => g.cave_culling,
    // rust: Item::Horizon(H::GpuCulling) => {
    // rust: g.gpu_culling && crate::graphics::gpu_culling_offer().reason().is_none()
}
    // rust: Item::Horizon(H::CacheShulkerBoxes) => g.cache_shulker_boxes,
    // rust: Item::Horizon(H::CacheSigns) => g.cache_signs,
    // rust: Item::Horizon(H::CacheDecoratedPots) => g.cache_decorated_pots,
    // rust: Item::Horizon(H::CacheBells) => g.cache_bells,
    // rust: Item::Horizon(H::CacheChests) => g.cache_chests,
    // rust: Item::Horizon(H::CacheBanners) => g.cache_banners,
    // rust: Item::Horizon(H::CacheCopperGolemStatues) => g.cache_copper_golem_statues,
    // rust: Item::Horizon(H::Sky) => g.sky,
    // rust: Item::Horizon(H::Fog) => g.fog,
    // rust: Item::Horizon(H::Weather) => g.weather,
    // rust: Item::Horizon(H::AnimatedTextures) => g.animated_textures,
    // rust: Item::Horizon(H::DitherCutoutMips) => g.dither_cutout_mips,
    // rust: Item::Horizon(H::Hdr) => g.hdr,
    // rust: Item::Horizon(H::HdrLighting) => g.hdr_lighting,
    // rust: Item::Horizon(H::BatteryMode) => g.battery,
    // rust: Item::Horizon(H::ShadowCache) => g.shadow_cache,
    // rust: Item::Horizon(H::TranslucentBatching) => {
    // rust: g.translucent_batching && crate::graphics::translucent_batching_offered()
}
    // rust: Item::Horizon(H::HdrSmoothGradients) => {
    // rust: g.hdr_smooth_gradients && crate::graphics::smooth_gradients_offered()
}
    // rust: Item::Vanilla(Opt::Vsync) => s.vsync,
    // rust: Item::Extra(e) => return e.switch(&s.extras),
    // rust: Item::Vanilla(Opt::Fullscreen) => s.fullscreen,
    // rust: Item::Vanilla(Opt::ExclusiveFullscreen) => s.file.bool("exclusiveFullscreen"),
    // rust: Item::Vanilla(Opt::SmoothLighting) => s.smooth_lighting,
    // rust: Item::Vanilla(Opt::EntityShadows) => s.entity_shadows,
    // rust: Item::Vanilla(Opt::Vignette) => s.vignette,
    // rust: Item::Vanilla(Opt::Autosave) => s.autosave_indicator,
    // rust: Item::Vanilla(Opt::CutoutLeaves) => s.cutout_leaves,
    // rust: Item::Vanilla(Opt::ImprovedTransparency) => s.improved_transparency,
    // rust: _ => return None,
    // rust: })
}
slider :: proc(self: ^Self, s: ^Settings) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Item::Vanilla(o) => o.slider_position(s),
    // rust: Item::Horizon(h) => h.slider(s),
    // rust: Item::Extra(_) => None,
}
}
label :: proc(self: ^Self, s: ^Settings) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Item::Vanilla(Opt::RenderDistance) if s.horizon.lod_distance > 0 => labelled(
    // rust: "Full Detail Distance",
    // rust: lang::tr("%s chunks", &[&s.render_distance]),
    // rust: ),
    // rust: Item::Vanilla(o) => o.label(s),
    // rust: Item::Horizon(h) => h.label(s),
    // rust: Item::Extra(e) => Text::option_name_value(
    // rust: Text::literal(e.caption_text()),
    // rust: Text::literal(e.value(&s.extras)),
    // rust: ),
}
}
set_slider :: proc(self: ^Self, s: ^Settings, v: f32) {
}
    // rust: if !self.available() || self.blocked(s).is_some() {
    // rust: return;
}
    // rust: match self {
            // Options.applyGraphicsPreset, as Video Settings' slider does it.
    // rust: Item::Vanilla(o) => crate::options_ui::set_slider(o, s, v),
    // rust: Item::Horizon(h) => h.set_slider(s, v),
    // rust: Item::Extra(_) => {}
}
    // rust: self.touched(s);
}
cycle :: proc(self: ^Self, s: ^Settings, back: bool, framebuffer: [i32; 2]) {
}
    // rust: if !self.available() {
    // rust: return;
}
    // rust: match self {
    // rust: Item::Vanilla(o) => o.cycle(s, back, framebuffer),
    // rust: Item::Horizon(h) => h.cycle(s, back),
    // rust: Item::Extra(e) => e.cycle(&mut s.extras, back),
}
    // rust: self.touched(s);
}
    // A preset no longer describes the settings once one of them changes.
touched :: proc(self: ^Self, s: ^Settings) {
}
    // rust: let presetless = matches!(
    // rust: self,
    // rust: Item::Extra(_)
    // rust: | Item::Horizon(
    // rust: H::Preset
    // rust: | H::BlueMapAutoDetect
    // rust: | H::BlueMapRadius
    // rust: | H::Overlay
    // rust: | H::ScreenshotQuality
    // rust: | H::Pacing
    // rust: | H::PresentMode
    // rust: | H::Workers
    // rust: | H::FrameGeneration
    // rust: | H::BatteryMode
    // rust: | H::ShadowCache
    // rust: | H::GraphicsApi
    // rust: | H::TranslucentBatching
    // rust: | H::HdrSmoothGradients
    // rust: | H::GpuCulling
    // rust: )
    // rust: | Item::Vanilla(
    // rust: Opt::GuiScale
    // rust: | Opt::Fullscreen
    // rust: | Opt::ExclusiveFullscreen
    // rust: | Opt::ExclusiveMode
    // rust: | Opt::Vsync
    // rust: | Opt::MaxFps
    // rust: | Opt::Gamma
    // rust: | Opt::InactivityFps
    // rust: | Opt::MenuBlur
    // rust: | Opt::ChunkFade
    // rust: | Opt::Vignette
    // rust: | Opt::Autosave
    // rust: | Opt::AttackIndicator
    // rust: )
    // rust: );
    // rust: if !presetless {
    // rust: s.horizon.preset = Preset::Custom;
}
}
slider_steps :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Item::Vanilla(o) => o.slider_steps(),
    // rust: Item::Horizon(h) => h.slider_steps(),
    // rust: Item::Extra(_) => None,
}
}
step_slider :: proc(self: ^Self, s: ^Settings, forward: bool, width: f32) {
}
    // rust: if !self.available() || self.blocked(s).is_some() {
    // rust: return;
}
    // rust: let Some(pos) = self.slider(s) else {
    // rust: return;
}
    // rust: let next_pos = shell::slider_step(pos, self.slider_steps(), width, forward);
    // rust: self.set_slider(s, next_pos);
    // rust: self.touched(s);
}
}

// What the options screen must do after an interaction here.
Action :: enum {
    ButtonClick,
    Changed,
    SliderDrag,
    // Wait for a key or mouse button to bind to this name.
    BindKey(&'static str),
    // Start HDR calibration.
    Calibrate,
    // Open the shader pack list.
    ShaderPacks,
    Done,
}

// What the keyboard or a controller can focus.
Target :: enum {
    Item(Item),
    Page(Page),
    Search,
    Undo,
    Done,
}

    // rust: type Line = shell::Line<Page, Setting>;

// Whether a setting is on the screen now: Upscaling only while TAA is, which does it.
shown :: proc(item: Item, s: ^Settings) -> b {
    // Ported from Horizon
    return {}
}
    // rust: item != Item::Horizon(H::Upscaling) || s.horizon.taa
}
// A control's label as its name and its value ("Render Distance" and "12 chunks").
parts :: proc(item: Item, s: ^Settings, binding: bool) -> ( {
    // Ported from Horizon
    return {}
}
    // The shortcut's label is one translated "Shortcut: %s"; the row shows its key apart,
    // as KeyBindsScreen does, "> key <" while it waits.
    // rust: if item == Item::Horizon(H::HdrKey) {
    // rust: let key = crate::keybinds::display_name(&s.horizon.hdr_key).plain();
    // rust: let key = if binding { format!("> {key} <") } else { key };
    // rust: return (lang::get("Shortcut"), Some(key));
}
    // rust: shell::name_and_value(&item.label(s).plain())
}

GraphicsUi :: struct {
    // The list's scroll amount and its held scrollbar (`AbstractScrollArea`).
    scroll: ui::Scroll,
    dragging: Maybe(Item),
    focus: Maybe(Target),
    can_change_value: bool,
    // The key binding the options screen is waiting on (`Action::BindKey`).
    binding: Maybe(^'static str),
    search: ui::EditBox,
    // The page the plate shows, alone, while nothing is searched.
    page: Page,
    // While searching, the page last picked in the page list: current until the list scrolls.
    picked: Maybe(Page),
    // The settings as the screen found them, for Undo, and whether they changed since.
    before: Maybe(^Settings),
    changed: bool,
}
    // rust: impl Default for GraphicsUi {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut search = ui::EditBox::new(0.0, 0.0, 0.0, 8.0);
    // rust: search.bordered = false;
    // rust: search.focused = false;
    // rust: search.message = lang::get("Search options");
    // rust: Self {
    // rust: scroll: ui::Scroll::default(),
    // rust: dragging: None,
    // rust: focus: None,
    // rust: can_change_value: false,
    // rust: binding: None,
    // rust: search,
    // rust: page: Page::General,
    // rust: picked: None,
    // rust: before: None,
    // rust: changed: false,
}
}
}

    // rust: impl GraphicsUi {
    // How far the list is scrolled (the options screen's tests).
    // rust: pub(crate) fn scroll_amount(&self) -> f32 {
    // rust: self.scroll.amount
}
    // The page the plate shows while nothing is searched.
page :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.page
}
    // The screen opens, at `page`.
open :: proc(self: ^Self, page: Page) {
}
    // rust: *self = Self {
    // rust: page,
    // rust: ..Self::default()
}
}
query :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.search.value.trim().to_lowercase()
}
    // The list's lines and its content height: the open page's settings in
    // their groups or, while searching, the settings of every page whose name
    // or description has the search in it, under their pages' names. Not
    // their values (nor the descriptions that follow them), and the row being
    // changed stays whatever it reads now: a change mustn't take its row away
    // under the pointer.
lines :: proc(self: ^Self, s: ^Settings) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let query = self.query();
    // rust: let mut lines = shell::Lines::new();
    // rust: for (page, groups) in rows() {
    // rust: if query.is_empty() && page != self.page {
    // rust: continue;
}
    // rust: let groups: Vec<(&'static str, Vec<Setting>)> = groups
    // rust: .into_iter()
    // rust: .map(|(name, rows)| {
    // rust: let rows = rows
    // rust: .into_iter()
    // rust: .filter(|r| shown(r.item, s))
    // rust: .filter(|r| {
    // rust: query.is_empty()
    // rust: || self.focus == Some(Target::Item(r.item))
    // rust: || self.dragging == Some(r.item)
    // rust: || parts(r.item, s, false).0.to_lowercase().contains(&query)
    // rust: || lang::get(r.text).to_lowercase().contains(&query)
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: (name, rows)
    // rust: })
    // rust: .filter(|(_, rows)| !rows.is_empty())
    // rust: .collect();
    // rust: if groups.is_empty() {
    // rust: continue;
}
    // rust: if !query.is_empty() {
    // rust: lines.page(page);
}
    // rust: for (name, rows) in groups {
    // rust: lines.group(page, name, rows);
}
}
    // rust: lines.finish()
}
    // The columns and the list, with the scroll kept within it.
layout :: proc(self: ^Self, s: ^Settings, w: f32, h: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let cols = Columns::of(w, h);
    // rust: let (lines, content) = self.lines(s);
    // rust: self.scroll.clamp(cols.top, cols.bottom, content);
    // rust: (cols, lines, content)
}
    // Pick `page`: the plate shows it alone or, while searching, scrolls to its matches.
pick :: proc(self: ^Self, page: Page, lines: ^[Line], cols: ^Columns, content: f32) {
}
    // rust: self.page = page;
    // rust: self.scroll.amount = 0.0;
    // rust: if self.query().is_empty() {
    // rust: return;
}
    // rust: if let Some(line) = lines.iter().find(|l| l.page == page) {
    // rust: self.scroll.amount = line.y;
    // rust: self.scroll.clamp(cols.top, cols.bottom, content);
    // rust: self.picked = Some(page);
}
}
    // Whether the page list's `page` has anything to show.
has :: proc(self: ^Self, page: Page, lines: ^[Line]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.query().is_empty() || lines.iter().any(|l| l.page == page)
}
    // The page the plate shows: the open one or, while searching, the one
    // picked, else the topmost line's.
current :: proc(self: ^Self, lines: ^[Line]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.query().is_empty() {
    // rust: return Some(self.page);
}
    // rust: self.picked.or_else(|| {
    // rust: lines
    // rust: .iter()
    // rust: .find(|l| l.y + l.h() > self.scroll.amount)
    // rust: .map(|l| l.page)
    // rust: })
}
row_y :: proc(self: ^Self, cols: ^Columns, line: ^Line) -> f {
    // Ported from Horizon
    return {}
}
    // rust: cols.top + line.y - self.scroll.amount
}
    // Remember the settings before the first change, for Undo.
keep :: proc(self: ^Self, s: ^Settings) {
}
    // rust: if self.before.is_none() {
    // rust: self.before = Some(Box::new(s.clone()));
}
}
mark :: proc(self: ^Self, actions: ^[Action]) {
}
    // rust: if actions.iter().any(|a| {
    // rust: matches!(
    // rust: a,
    // rust: Action::Changed | Action::SliderDrag | Action::BindKey(_) | Action::Calibrate
    // rust: )
    // rust: }) {
    // rust: self.changed = true;
}
}
    // Undo: what this screen edits back to what it was when the screen
    // opened: Horizon's graphics settings and the vanilla options on its rows.
    // Not the other options (the narrator, or one `horizon-ctl options-set`
    // changed meanwhile), nor fullscreen, which F11 and the window manager change.
undo :: proc(self: ^Self, s: ^Settings) {
}
    // rust: let Some(b) = self.before.as_deref() else {
    // rust: return;
}
    // rust: s.horizon = b.horizon.clone();
    // rust: s.render_distance = b.render_distance;
    // rust: s.simulation_distance = b.simulation_distance;
    // rust: s.gamma = b.gamma;
    // rust: s.gui_scale = b.gui_scale;
    // rust: s.vsync = b.vsync;
    // rust: s.max_fps = b.max_fps;
    // rust: s.inactivity_fps_limit = b.inactivity_fps_limit.clone();
    // rust: s.menu_blur = b.menu_blur;
    // rust: s.extras.fullbright = b.extras.fullbright;
    // rust: s.extras.dynamic_lights = b.extras.dynamic_lights;
    // rust: s.extras.hide_block_particles = b.extras.hide_block_particles;
    // rust: s.attack_indicator = b.attack_indicator;
    // rust: s.autosave_indicator = b.autosave_indicator;
    // rust: s.clouds = b.clouds.clone();
    // rust: s.cloud_range = b.cloud_range;
    // rust: s.weather_radius = b.weather_radius;
    // rust: s.particles = b.particles;
    // rust: s.smooth_lighting = b.smooth_lighting;
    // rust: s.biome_blend = b.biome_blend;
    // rust: s.entity_distance = b.entity_distance;
    // rust: s.entity_shadows = b.entity_shadows;
    // rust: s.vignette = b.vignette;
    // rust: s.chunk_fade = b.chunk_fade;
    // rust: s.mipmap_levels = b.mipmap_levels;
    // rust: s.cutout_leaves = b.cutout_leaves;
    // rust: s.improved_transparency = b.improved_transparency;
    // rust: s.prioritize_chunk_updates = b.prioritize_chunk_updates;
        // Presets set it beside the options above.
    // rust: s.graphics_preset = b.graphics_preset.clone();
        // The vanilla rows options.txt keeps as it read them.
    // rust: for key in [
    // rust: "exclusiveFullscreen",
    // rust: "textureFiltering",
    // rust: "maxAnisotropyBit",
    // rust: ] {
    // rust: if let Some(value) = b.file.get(key) {
    // rust: s.file.set(key, value.clone());
}
}
    // rust: s.file.fullscreen_resolution = b.file.fullscreen_resolution.clone();
    // rust: self.changed = false;
}

    // rust: pub fn draw(
    // rust: &mut self,
    // rust: s: &Settings,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: in_world: bool,
    // rust: ) {
    // rust: self.keep(s);
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let (cols, lines, content) = self.layout(s, w, h);
    // rust: shell::backdrop(batch, atlas, in_world);
    // rust: let current = self.current(&lines);
    // rust: self.draw_side(batch, atlas, &cols, &lines, current, cursor);
    // rust: let focused = self.focus == Some(Target::Search);
    // rust: shell::search_field(&mut self.search, batch, atlas, &cols, cursor, focused);

    // rust: let query = self.search.value.trim();
    // rust: let heading = if query.is_empty() {
    // rust: lang::get(current.unwrap_or(self.page).name())
    // rust: } else {
    // rust: lang::get("Results for \"%s\"").replace("%s", query)
}
    // rust: shell::plate(batch, atlas, &cols, &heading);

    // rust: let over_list = cursor.1 >= cols.top && cursor.1 < cols.bottom;
    // rust: let mut described = None;
    // rust: shell::list(
    // rust: batch,
    // rust: atlas,
    // rust: &cols,
    // rust: &lines,
    // rust: self.scroll.amount,
    // rust: Page::name,
    // rust: |batch, setting: Setting, y| {
    // rust: let item = setting.item;
    // rust: let rect = cols.row(y);
    // rust: let hover = over_list && ui::hovered(cursor, rect[0], rect[1], rect[2], rect[3]);
    // rust: let focused = self.focus == Some(Target::Item(item));
                // The pointer's row wins over the keyboard's.
    // rust: if hover || self.dragging == Some(item) || (focused && described.is_none()) {
    // rust: described = Some(setting);
}
    // rust: self.draw_row(batch, atlas, s, &cols, item, y, hover, focused);
    // rust: },
    // rust: );
    // rust: shell::scroller(batch, atlas, &cols, content, self.scroll.amount);
    // rust: self.draw_dock(batch, atlas, s, &cols, described, current);

    // rust: let mut foot = vec![(cols.button(0), "Done", Target::Done)];
        // Undo only once there is something to undo.
    // rust: if self.changed {
    // rust: foot.push((cols.button(1), "Undo", Target::Undo));
}
    // rust: for (rect, label, target) in foot {
    // rust: let label = Text::literal(lang::get(label));
    // rust: let focused = self.focus == Some(target);
    // rust: let primary = target == Target::Done;
    // rust: let declared = if primary {
    // rust: crate::widgets::Action::Done
    // rust: } else {
    // rust: crate::widgets::Action::Apply
}
    // rust: crate::widgets::declare_action(declared, rect, true);
    // rust: shell::foot_button(batch, atlas, rect, &label, cursor, (focused, primary));
}
}
    // The mark over the search field, and the page list: the open page on a
    // plate with the accent's bar beside it, the others bare text.
    // rust: fn draw_side(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cols: &Columns,
    // rust: lines: &[Line],
    // rust: current: Option<Page>,
    // rust: cursor: (f32, f32),
    // rust: ) {
    // rust: shell::mark(batch, atlas, cols, &lang::get("Graphics"));
    // rust: for (i, page) in Page::ALL.into_iter().enumerate() {
    // rust: let has = self.has(page, lines);
    // rust: let open = current == Some(page);
    // rust: let focused = self.focus == Some(Target::Page(page));
    // rust: let name = lang::get(page.name());
    // rust: let flags = (has, open, focused);
    // rust: shell::page_tab(batch, atlas, cols.page(i), &name, flags, cursor);
}
}
    // rust: fn draw_row(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: item: Item,
    // rust: y: f32,
    // rust: hover: bool,
    // rust: focused: bool,
    // rust: ) {
    // rust: let label = item.label(s).plain();
    // rust: let (name, value) = parts(item, s, self.binding.is_some());
    // rust: let view = shell::RowView {
    // rust: label: &label,
    // rust: name: &name,
    // rust: value: value.as_deref(),
    // rust: switch: item.switch(s),
    // rust: slider: item.slider(s),
    // rust: live: item.blocked(s).is_none(),
    // rust: hover,
    // rust: focused,
    // rust: held: self.dragging == Some(item),
}
    // rust: shell::row(batch, atlas, cols, y, &view);
}
    // The strip under the plate: the hovered or focused setting's name and
    // cost, then what it does (or why it can't be used now); with none, what
    // the open page holds.
    // rust: fn draw_dock(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: setting: Option<Setting>,
    // rust: current: Option<Page>,
    // rust: ) {
    // rust: let [x, y, w, _] = cols.dock;
    // rust: style::panel(batch, atlas, cols.dock);
    // rust: let left = x + 12.0;
    // rust: let (text, color) = match setting {
    // rust: Some(setting) => {
    // rust: let (name, _) = parts(setting.item, s, false);
    // rust: let cost = lang::get(setting.cost.label());
    // rust: let line = style::fit(atlas, &format!("{name} · {cost}"), w - 32.0);
    // rust: let line = Text::literal(line).with_color(setting.cost.rgb());
    // rust: let square = [left, y + 10.0, 4.0, 4.0];
    // rust: style::fill(batch, atlas, square, style::cost_color(setting.cost));
    // rust: batch.text_styled(atlas, &line, left + 8.0, y + 8.0, style::WHITE, true);
    // rust: match setting.item.blocked(s) {
    // rust: Some(why) => (lang::get(why), style::MUTED),
    // rust: None => (
    // rust: lang::get(description(setting.item, s, setting.text)),
    // rust: style::GREY,
    // rust: ),
}
}
    // rust: None => {
    // rust: let Some(page) = current else { return };
    // rust: let name = Text::literal(lang::get(page.name()));
    // rust: batch.text_styled(atlas, &name, left, y + 8.0, style::WHITE, true);
    // rust: (lang::get(page.about()), style::GREY)
}
}
    // rust: shell::dock_note(batch, atlas, cols, text, color);
}

    // A press (or a drag with `drag`) at `(x, y)`.
    // rust: pub fn click(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: (x, y): (f32, f32),
    // rust: (w, h): (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: drag: bool,
    // rust: right: bool,
    // rust: shift: bool,
    // rust: ) -> Vec<Action> {
    // rust: self.keep(s);
    // rust: let (cols, lines, content) = self.layout(s, w, h);
    // rust: let at = |[rx, ry, rw, rh]: [f32; 4]| ui::hovered((x, y), rx, ry, rw, rh);
    // rust: if drag {
            // AbstractScrollArea.mouseDragged: the held scrollbar follows the pointer.
    // rust: if self.scroll.held() && !cols.scrolls() {
    // rust: self.scroll.release();
}
    // rust: if self.scroll.held() {
    // rust: self.picked = None;
    // rust: self.scroll.drag(y, cols.top, cols.bottom, content);
    // rust: return Vec::new();
}
    // rust: if let Some(item) = self.dragging {
    // rust: item.set_slider(s, cols.slider_at(x));
    // rust: self.changed = true;
    // rust: return vec![Action::SliderDrag];
}
    // rust: return Vec::new();
}
    // rust: if right {
    // rust: return Vec::new();
}
    // rust: if cols.scrolls()
    // rust: && self
    // rust: .scroll
    // rust: .press((x, y), cols.bar_x(), cols.top, cols.bottom, content)
    // rust: {
    // rust: return Vec::new();
}
    // rust: if at(cols.search()) {
    // rust: if !self.search.value.is_empty() && at(cols.clear()) {
    // rust: self.search.set_value("");
    // rust: self.searched();
    // rust: return vec![Action::ButtonClick];
}
    // rust: self.focus = Some(Target::Search);
    // rust: self.search.reset_blink();
    // rust: self.search.move_cursor_to_end(false);
    // rust: return Vec::new();
}
    // rust: if self.focus == Some(Target::Search) {
    // rust: self.focus = None;
}
    // rust: if at(cols.button(0)) {
    // rust: self.focus = Some(Target::Done);
    // rust: return vec![Action::ButtonClick, Action::Done];
}
    // rust: if self.changed && at(cols.button(1)) {
            // Undo goes away with the change it undid.
    // rust: self.focus = None;
    // rust: self.undo(s);
    // rust: return vec![Action::ButtonClick, Action::Changed];
}
    // rust: for (i, page) in Page::ALL.into_iter().enumerate() {
    // rust: if at(cols.page(i)) && self.has(page, &lines) {
    // rust: self.focus = Some(Target::Page(page));
    // rust: self.pick(page, &lines, &cols, content);
    // rust: return vec![Action::ButtonClick];
}
}
    // rust: if y < cols.top || y >= cols.bottom {
    // rust: return Vec::new();
}
    // rust: let Some(item) = lines.iter().find_map(|line| {
    // rust: let ry = self.row_y(&cols, line);
    // rust: let setting = line.setting?;
    // rust: at([cols.list_x, ry, cols.list_w, style::ROW]).then_some(setting.item)
    // rust: }) else {
    // rust: return Vec::new();
}
        // A disabled control does nothing: no sound, no preset change.
    // rust: if item.blocked(s).is_some() {
    // rust: return Vec::new();
}
    // rust: self.focus = Some(Target::Item(item));
    // rust: let actions = self.activate(s, item, shift, framebuffer, Some((x, &cols)));
    // rust: self.mark(&actions);
    // rust: actions
}
    // Press `item`: `at` is where on its row and its slider's track (`None`
    // from the keyboard).
    // rust: fn activate(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: item: Item,
    // rust: back: bool,
    // rust: framebuffer: [i32; 2],
    // rust: at: Option<(f32, &Columns)>,
    // rust: ) -> Vec<Action> {
    // rust: match item {
    // rust: Item::Horizon(H::HdrCalibrate) if setup(s) == Setup::Changed => {
    // rust: s.horizon.hdr_peak = 0;
    // rust: s.horizon.hdr_paper_white = 0;
    // rust: vec![Action::ButtonClick, Action::Changed]
}
    // rust: Item::Horizon(H::HdrCalibrate) => vec![Action::ButtonClick, Action::Calibrate],
    // rust: Item::Horizon(H::ShaderPacks) => vec![Action::ButtonClick, Action::ShaderPacks],
    // rust: Item::Horizon(H::HdrKey) => {
    // rust: vec![
    // rust: Action::ButtonClick,
    // rust: Action::BindKey(crate::graphics::HDR_KEY),
    // rust: ]
}
    // rust: _ if item.slider(s).is_some() => {
    // rust: self.can_change_value = true;
                // A press on the track sets the value there; on the name, only focuses.
    // rust: match at {
    // rust: Some((x, cols)) if x >= cols.track().0 => {
    // rust: self.dragging = Some(item);
    // rust: item.set_slider(s, cols.slider_at(x));
    // rust: vec![Action::SliderDrag]
}
    // rust: _ => Vec::new(),
}
}
    // rust: _ => {
    // rust: self.can_change_value = false;
    // rust: item.cycle(s, back, framebuffer);
    // rust: vec![Action::ButtonClick, Action::Changed]
}
}
}
    // Lets go of a slider (true: it plays its click) or the scrollbar.
release :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.scroll.release();
    // rust: self.dragging.take().is_some()
}
    // The mouse wheel at the cursor. It scrolls the list, as vanilla's does
    // (`AbstractScrollArea.mouseScrolled`), except that a hovered value stepped by
    // `<` `>` takes the step (up goes back) while the "Scroll wheel changes settings"
    // extra is on. A slider, a tick box and a
    // focused row don't take it, wherever the focus came from: the keyboard and a
    // controller step them with Left and Right.
    // rust: pub fn wheel(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: (w, h): (f32, f32),
    // rust: (x, y): (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: amount: f32,
    // rust: ) -> Vec<Action> {
    // rust: if amount != 0.0 && s.extras.wheel_cycles_settings {
    // rust: let (cols, lines, _) = self.layout(s, w, h);
    // rust: let hovered = (y >= cols.top && y < cols.bottom)
    // rust: .then(|| {
    // rust: lines.iter().find_map(|line| {
    // rust: let setting = line.setting?;
    // rust: let ry = self.row_y(&cols, line);
    // rust: ui::hovered((x, y), cols.list_x, ry, cols.list_w, style::ROW)
    // rust: .then_some(setting.item)
    // rust: })
    // rust: })
    // rust: .flatten();
    // rust: if let Some(item) = hovered
    // rust: && item.steps(s)
    // rust: && item.blocked(s).is_none()
    // rust: {
    // rust: item.cycle(s, amount > 0.0, framebuffer);
    // rust: self.changed = true;
    // rust: return vec![Action::ButtonClick, Action::Changed];
}
}
    // rust: self.scroll(s, (w, h), amount);
    // rust: Vec::new()
}
    // The mouse wheel scrolls the list.
scroll :: proc(self: ^Self, s: ^Settings) {
}
    // rust: let (cols, _, content) = self.layout(s, w, h);
    // rust: self.picked = None;
    // rust: self.scroll
    // rust: .wheel(amount, 18.0, cols.top, cols.bottom, content);
}
    // What Tab steps through, in order, with where each is on screen (`shell::reach`).
    // rust: fn focusables(
    // rust: &self,
    // rust: s: &Settings,
    // rust: cols: &Columns,
    // rust: lines: &[Line],
    // rust: near: bool,
    // rust: ) -> Vec<(Target, [f32; 4])> {
    // rust: let mut out = vec![(Target::Search, cols.search())];
    // rust: for (i, page) in Page::ALL.into_iter().enumerate() {
    // rust: if self.has(page, lines) {
    // rust: out.push((Target::Page(page), cols.page(i)));
}
}
        // Every setting row, and whether it can take the focus.
    // rust: let rows: Vec<(Item, f32, bool)> = lines
    // rust: .iter()
    // rust: .filter_map(|line| {
    // rust: let setting = line.setting?;
    // rust: let live = setting.item.blocked(s).is_none();
    // rust: Some((setting.item, self.row_y(cols, line), live))
    // rust: })
    // rust: .collect();
    // rust: let reach = shell::reach(&rows, cols, near);
    // rust: for &(item, y, live) in &rows[reach] {
    // rust: if !live {
    // rust: continue;
}
    // rust: out.push((
    // rust: Target::Item(item),
    // rust: [cols.list_x, y, cols.list_w, style::ROW],
    // rust: ));
}
    // rust: if self.changed {
    // rust: out.push((Target::Undo, cols.button(1)));
}
    // rust: out.push((Target::Done, cols.button(0)));
    // rust: out
}
    // Focus `target`, scrolling its row into the list's view.
    // rust: fn focus_on(
    // rust: &mut self,
    // rust: s: &Settings,
    // rust: target: Target,
    // rust: rect: [f32; 4],
    // rust: cols: &Columns,
    // rust: content: f32,
    // rust: ) {
    // rust: self.focus = Some(target);
    // rust: self.can_change_value =
    // rust: matches!(target, Target::Item(i) if i.slider(s).is_some() && i.blocked(s).is_none());
    // rust: if let Target::Item(_) = target {
    // rust: shell::scroll_into_view(&mut self.scroll, rect, cols, content);
    // rust: self.picked = None;
}
}

    // Keys: typing in the search field, Tab and the arrows between controls,
    // Left and Right on a slider, Enter or Space to press. False: the screen
    // handles it (Escape closes it, as `Screen.keyPressed` does first).
    // rust: pub fn key_modifiers(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: key: winit::keyboard::KeyCode,
    // rust: text: Option<&str>,
    // rust: shift: bool,
    // rust: (w, h): (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: ) -> (Vec<Action>, bool) {
//         use winit::keyboard::KeyCode as K;
    // rust: self.keep(s);
    // rust: if key == K::Escape {
    // rust: self.can_change_value = false;
    // rust: return (Vec::new(), false);
}
    // rust: if self.focus == Some(Target::Search)
    // rust: && !matches!(key, K::Tab | K::ArrowDown | K::Enter | K::NumpadEnter)
    // rust: {
    // rust: let before = self.search.value.clone();
    // rust: if !self.search.key(key, false, shift)
    // rust: && let Some(t) = text
    // rust: {
    // rust: let typed: String = t.chars().filter(|c| !c.is_control()).collect();
    // rust: self.type_text(&typed);
}
    // rust: if self.search.value != before {
    // rust: self.searched();
}
    // rust: return (Vec::new(), true);
}
    // rust: let (cols, lines, content) = self.layout(s, w, h);
    // rust: let near = key != K::Tab;
    // rust: let focusables = self.focusables(s, &cols, &lines, near);
    // rust: let current = self
    // rust: .focus
    // rust: .and_then(|f| focusables.iter().position(|&(t, _)| t == f));
    // rust: if key == K::Tab {
    // rust: let next = shell::tab_step(focusables.len(), current, shift);
    // rust: let (target, rect) = focusables[next];
    // rust: self.focus_on(s, target, rect, &cols, content);
    // rust: return (Vec::new(), true);
}
    // rust: if matches!(key, K::ArrowLeft | K::ArrowRight)
    // rust: && self.can_change_value
    // rust: && let Some(Target::Item(item)) = self.focus
    // rust: && item.slider(s).is_some()
    // rust: && item.blocked(s).is_none()
    // rust: {
    // rust: item.step_slider(s, key == K::ArrowRight, cols.track().1 + 8.0);
    // rust: self.changed = true;
    // rust: return (vec![Action::SliderDrag], true);
}
    // rust: if matches!(
    // rust: key,
    // rust: K::ArrowUp | K::ArrowDown | K::ArrowLeft | K::ArrowRight
    // rust: ) {
    // rust: let is_row = |t: Target| matches!(t, Target::Item(_));
    // rust: let next = shell::arrow_step(&focusables, current, key, &cols, is_row);
    // rust: let Some(next) = next else {
    // rust: return (Vec::new(), false);
}
    // rust: let (target, rect) = focusables[next];
    // rust: self.focus_on(s, target, rect, &cols, content);
    // rust: self.can_change_value = false;
    // rust: return (Vec::new(), true);
}
    // rust: if matches!(key, K::Space | K::Enter | K::NumpadEnter)
    // rust: && let Some(target) = self.focus
    // rust: {
    // rust: let actions = match target {
    // rust: Target::Search => Vec::new(),
    // rust: Target::Page(page) => {
    // rust: self.pick(page, &lines, &cols, content);
    // rust: vec![Action::ButtonClick]
}
                // A row greyed out while focused does nothing, as a click on it doesn't.
    // rust: Target::Item(item) if item.blocked(s).is_some() => Vec::new(),
    // rust: Target::Item(item) if item.slider(s).is_some() => {
    // rust: self.can_change_value = !self.can_change_value;
    // rust: Vec::new()
}
    // rust: Target::Item(item) => self.activate(s, item, shift, framebuffer, None),
    // rust: Target::Undo => {
    // rust: self.undo(s);
                    // Undo goes away with the change it undid.
    // rust: self.focus = Some(Target::Done);
    // rust: return (vec![Action::ButtonClick, Action::Changed], true);
}
    // rust: Target::Done => vec![Action::ButtonClick, Action::Done],
}
    // rust: self.mark(&actions);
    // rust: return (actions, true);
}
    // rust: (Vec::new(), false)
}
    // Whether the search field takes the keys.
typing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.focus == Some(Target::Search)
}
    // Text typed into the search field (the keyboard, a controller's on-screen keyboard).
type_text :: proc(self: ^Self, text: string) {
}
    // rust: if !text.is_empty() {
    // rust: self.search.insert_text(text);
    // rust: self.searched();
}
}
    // Ctrl+A/C/V/X in the search field.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: if !self.typing() {
    // rust: return false;
}
    // rust: let before = self.search.value.clone();
    // rust: self.search.shortcut(shortcut, clipboard);
    // rust: if self.search.value != before {
    // rust: self.searched();
}
        // Whatever it did: the key is the field's, not something to type.
    // rust: true
}
    // The search changed: the list starts over at its top.
searched :: proc(self: ^Self) {
}
    // rust: self.scroll.amount = 0.0;
    // rust: self.picked = None;
}
}

    // rust: mod tests {
//     use super::*;
//     use winit::keyboard::KeyCode as K;

SIZE :: (640.0, 360.0)
FB :: [1920, 1080]
    // Held by the tests that set `offer_hdr`, which is global.
HDR_OFFER :: std::sync::Mutex::new(())

items :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: rows()
    // rust: .into_iter()
    // rust: .flat_map(|(page, groups)| {
    // rust: groups
    // rust: .into_iter()
    // rust: .flat_map(|(_, rows)| rows)
    // rust: .map(move |r| (page, r.item))
    // rust: })
    // rust: .collect()
}
    // Where `item`'s row is on screen now (its page open and the list scrolled to it first).
row :: proc(ui: ^GraphicsUi, s: ^Settings, item: Item) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if ui.query().is_empty() {
    // rust: ui.page = items().into_iter().find(|(_, i)| *i == item).unwrap().0;
}
    // rust: let (cols, lines, content) = ui.layout(s, SIZE.0, SIZE.1);
    // rust: let line = lines
    // rust: .iter()
    // rust: .find(|l| l.setting.is_some_and(|r| r.item == item))
    // rust: .copied()
    // rust: .unwrap();
    // rust: let rect = [cols.list_x, ui.row_y(&cols, &line), cols.list_w, style::ROW];
    // rust: ui.focus_on(s, Target::Item(item), rect, &cols, content);
    // rust: ui.focus = None;
    // rust: ui.can_change_value = false;
    // rust: [cols.list_x, ui.row_y(&cols, &line), cols.list_w, style::ROW]
}
press :: proc(ui: ^GraphicsUi, s: ^Settings) {
}
    // rust: ui.click(s, (x, y), SIZE, FB, false, false, false)
}
    // rust: fn press_shift(
    // rust: ui: &mut GraphicsUi,
    // rust: s: &mut Settings,
    // rust: (x, y): (f32, f32),
    // rust: shift: bool,
    // rust: ) -> Vec<Action> {
    // rust: ui.click(s, (x, y), SIZE, FB, false, false, shift)
}

one_screen_holds_every_video_setting_once_with_a_short_description :: proc() {
}
    // rust: let all = items();
    // rust: for (i, (_, item)) in all.iter().enumerate() {
    // rust: assert!(!all[..i].iter().any(|(_, x)| x == item), "{item:?} twice");
}
        // Vanilla's Video Settings options are here beside Horizon's.
    // rust: for opt in [
    // rust: Opt::RenderDistance,
    // rust: Opt::Vsync,
    // rust: Opt::GuiScale,
    // rust: Opt::Clouds,
    // rust: Opt::Mipmaps,
    // rust: ] {
    // rust: assert!(all.iter().any(|(_, i)| *i == Item::Vanilla(opt)), "{opt:?}");
}
    // rust: for page in Page::ALL {
    // rust: assert!(all.iter().any(|(p, _)| *p == page), "{page:?} is empty");
}
    // rust: for (_, groups) in rows() {
    // rust: for r in groups.into_iter().flat_map(|(_, rows)| rows) {
    // rust: assert!(!r.text.is_empty() && r.text.len() < 80, "{:?}", r.item);
}
}
}

a_picked_page_shows_alone_in_its_groups_from_the_top :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let settings = |ui: &mut GraphicsUi, s: &Settings| {
    // rust: let (_, lines, _) = ui.layout(s, SIZE.0, SIZE.1);
    // rust: assert!(
    // rust: lines[0].group.is_some(),
    // rust: "the list starts at a group's name"
    // rust: );
    // rust: lines
    // rust: .iter()
    // rust: .filter_map(|l| l.setting.map(|r| (l.page, r.item)))
    // rust: .collect::<Vec<_>>()
}
        // Upscaling shows only with TAA, off by default.
    // rust: let on = |page| -> Vec<(Page, Item)> {
    // rust: items()
    // rust: .into_iter()
    // rust: .filter(|(p, i)| *p == page && *i != Item::Horizon(H::Upscaling))
    // rust: .collect()
}
    // rust: assert_eq!(settings(&mut ui, &s), on(Page::General));
    // rust: ui.scroll(&s, SIZE, -3.0);
    // rust: assert!(ui.scroll.amount > 0.0);
    // rust: let [x, y, w, h] = Columns::of(SIZE.0, SIZE.1).page(1);
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (x + w / 2.0, y + h / 2.0)),
    // rust: [Action::ButtonClick]
    // rust: );
    // rust: assert_eq!(settings(&mut ui, &s), on(Page::Quality));
    // rust: assert_eq!(ui.scroll.amount, 0.0);
        // Groups sit apart: each name follows the gap under the panel before it.
    // rust: let (_, lines, _) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: assert_eq!(ui.current(&lines), Some(Page::Quality));
    // rust: let names: Vec<&Line> = lines.iter().filter(|l| l.group.is_some()).collect();
    // rust: assert!(names.len() > 1);
    // rust: for pair in names.windows(2) {
    // rust: let (_, panel) = pair[0].group.unwrap();
    // rust: assert_eq!(
    // rust: pair[1].y,
    // rust: pair[0].y + style::GROUP_ROW + panel + style::GROUP_GAP
    // rust: );
}
        // Opened at a page (Advanced..., the HDR key), it shows that page.
    // rust: let mut ui = GraphicsUi::default();
    // rust: ui.open(Page::Hdr);
    // rust: assert_eq!(settings(&mut ui, &s), on(Page::Hdr));
}

a_720p_window_keeps_the_page_list_the_buttons_and_five_rows :: proc() {
}
        // 1280x720 at GUI scale 3.
    // rust: let size = (427.0, 240.0);
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let cols = Columns::of(size.0, size.1);
    // rust: assert!((cols.bottom - cols.top) / style::ROW >= 5.0);
    // rust: let [x, y, w, h] = cols.page(Page::ALL.len() - 1);
    // rust: assert!(y >= 0.0 && x + w <= size.0);
        // Undo, over Done, stays clear of the page list.
    // rust: assert!(cols.button(1)[1] >= y + h);
    // rust: ui.click(
    // rust: &mut s,
    // rust: (x + w / 2.0, y + h / 2.0),
    // rust: size,
    // rust: FB,
    // rust: false,
    // rust: false,
    // rust: false,
    // rust: );
    // rust: let (_, lines, _) = ui.layout(&s, size.0, size.1);
    // rust: assert_eq!(ui.current(&lines), Some(Page::Hdr));
}

growing_the_window_keeps_the_scroll_within_the_list :: proc() {
}
    // rust: let s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: ui.scroll(&s, SIZE, -1000.0);
    // rust: assert!(ui.scroll.amount > 0.0);
    // rust: let (cols, lines, _) = ui.layout(&s, 640.0, 4000.0);
    // rust: assert_eq!(ui.scroll.amount, 0.0);
    // rust: assert_eq!(ui.row_y(&cols, &lines[0]), cols.top);
}

the_search_filters_as_you_type_and_drops_pages_left_empty :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let (cols, all, _) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: assert!(all.iter().all(|l| l.page == Page::General));
    // rust: let [x, y, ..] = cols.search();
    // rust: press(&mut ui, &mut s, (x + 4.0, y + 4.0));
    // rust: assert!(ui.typing());
    // rust: for c in ["c", "l", "o", "u", "d"] {
    // rust: ui.key_modifiers(&mut s, K::KeyA, Some(c), false, SIZE, FB);
}
    // rust: let (_, lines, _) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: let found: Vec<Item> = lines
    // rust: .iter()
    // rust: .filter_map(|l| l.setting.map(|r| r.item))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: found,
    // rust: [Item::Vanilla(Opt::Clouds), Item::Vanilla(Opt::CloudRange)]
    // rust: );
    // rust: assert!(lines.iter().all(|l| l.page == Page::Quality));
        // Words of a description find it too.
    // rust: ui.search.set_value("tearing");
    // rust: let (_, lines, _) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: assert!(lines.iter().any(|l| {
    // rust: l.setting
    // rust: .is_some_and(|r| r.item == Item::Vanilla(Opt::Vsync))
    // rust: }));
    // rust: ui.search.set_value("hdr");
    // rust: let [x, y, w, h] = cols.page(Page::ALL.len() - 1);
    // rust: press(&mut ui, &mut s, (x + w / 2.0, y + h / 2.0));
    // rust: assert_eq!(ui.current(&ui.lines(&s).0), Some(Page::Hdr));
    // rust: let [x, y, ..] = cols.clear();
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (x + 2.0, y + 2.0)),
    // rust: [Action::ButtonClick]
    // rust: );
        // The clear button leaves the page picked meanwhile open, alone, from the top.
    // rust: let (lines, _) = ui.lines(&s);
    // rust: assert!(lines.len() < all.len() && lines.iter().all(|l| l.page == Page::Hdr));
    // rust: assert_eq!(ui.scroll.amount, 0.0);
    // rust: assert_eq!(ui.current(&lines), Some(Page::Hdr));
}

undo_appears_after_changes_and_puts_back_what_the_screen_opened_with :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let (cols, ..) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: let undo = cols.button(1);
    // rust: let at = |[x, y, ..]: [f32; 4]| (x + 2.0, y + 2.0);
        // Nothing changed: Undo does nothing.
    // rust: assert!(press(&mut ui, &mut s, at(undo)).is_empty());
    // rust: let fog = row(&mut ui, &s, Item::Horizon(H::Fog));
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, at(fog)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: let sky = row(&mut ui, &s, Item::Horizon(H::Sky));
    // rust: press(&mut ui, &mut s, at(sky));
    // rust: assert!(!s.horizon.fog && !s.horizon.sky && ui.changed);
        // F11 and another option meanwhile: Undo leaves them as they are.
    // rust: s.fullscreen = true;
    // rust: s.chat_opacity = 0.25;
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, at(undo)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert!(s.horizon.fog && s.horizon.sky && !ui.changed);
    // rust: assert!(s.fullscreen);
    // rust: assert_eq!(s.chat_opacity, 0.25);
        // From the keyboard: Undo puts it back and goes away.
    // rust: let fog = row(&mut ui, &s, Item::Horizon(H::Fog));
    // rust: press(&mut ui, &mut s, at(fog));
    // rust: ui.focus = Some(Target::Undo);
    // rust: let (actions, _) = ui.key_modifiers(&mut s, K::Enter, None, false, SIZE, FB);
    // rust: assert_eq!(actions, [Action::ButtonClick, Action::Changed]);
    // rust: assert!(s.horizon.fog && !ui.changed);
    // rust: assert_eq!(ui.focus, Some(Target::Done));
}

a_slider_takes_a_press_on_its_track_and_its_click_plays_on_release :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: s.horizon.chunk_updates = 16;
    // rust: let r = row(&mut ui, &s, Item::Horizon(H::ChunkUpdates));
    // rust: let (tx, tw) = Columns::of(SIZE.0, SIZE.1).track();
        // On its name: focused, unchanged.
    // rust: assert!(press(&mut ui, &mut s, (r[0] + 4.0, r[1] + 4.0)).is_empty());
    // rust: assert_eq!(s.horizon.chunk_updates, 16);
    // rust: assert!(ui.can_change_value);
    // rust: assert!(!ui.release());
        // At the track's end: the most, then dragged to its start.
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (tx + tw, r[1] + 4.0)),
    // rust: [Action::SliderDrag]
    // rust: );
    // rust: assert_eq!(H::ChunkUpdates.slider(&s), Some(1.0));
    // rust: assert_eq!(
    // rust: ui.click(&mut s, (-100.0, -100.0), SIZE, FB, true, false, false),
    // rust: [Action::SliderDrag]
    // rust: );
    // rust: assert_eq!(H::ChunkUpdates.slider(&s), Some(0.0));
    // rust: assert!(ui.release());
    // rust: assert!(!ui.release());
}

smooth_gradients_wait_for_a_device_that_draws_the_16_bit_frame :: proc() {
}
    // rust: let _offer = HDR_OFFER.lock().unwrap_or_else(|e| e.into_inner());
    // rust: crate::graphics::offer_hdr(true);
    // rust: let mut s = Settings::default();
    // rust: s.horizon.hdr = true;
    // rust: let item = Item::Horizon(H::HdrSmoothGradients);
        // Where the device can't, the saved On reads Off.
    // rust: crate::graphics::offer_smooth_gradients(false);
    // rust: assert_eq!(
    // rust: item.blocked(&s),
    // rust: Some("Your GPU or graphics API doesn't support it.")
    // rust: );
    // rust: assert_eq!(item.label(&s).plain(), "Smooth Gradients: Off");
    // rust: assert_eq!(item.switch(&s), Some(false));
    // rust: assert!(s.horizon.hdr_smooth_gradients);
        // Where it can, it waits only for HDR, like the rest of the page.
    // rust: crate::graphics::offer_smooth_gradients(true);
    // rust: assert_eq!(item.blocked(&s), None);
    // rust: assert_eq!(item.label(&s).plain(), "Smooth Gradients: On");
    // rust: assert_eq!(item.switch(&s), Some(true));
    // rust: s.horizon.hdr = false;
    // rust: assert_eq!(item.blocked(&s), Some("Turn HDR on to use it."));
}

hdr_waits_for_a_display_that_offers_it_and_its_sliders_for_the_switch :: proc() {
}
    // rust: let _offer = HDR_OFFER.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let at = |[x, y, ..]: [f32; 4]| (x + 8.0, y + 4.0);
    // rust: crate::graphics::offer_hdr(false);
        // A 720p window opened at HDR shows only its greyed rows: Down still reaches the shortcut.
    // rust: let short = (427.0, 240.0);
    // rust: let mut at_hdr = GraphicsUi::default();
    // rust: at_hdr.open(Page::Hdr);
    // rust: at_hdr.key_modifiers(&mut s, K::ArrowDown, None, false, short, FB);
    // rust: assert_eq!(at_hdr.focus, Some(Target::Item(Item::Horizon(H::HdrKey))));
    // rust: let hdr = row(&mut ui, &s, Item::Horizon(H::Hdr));
    // rust: assert!(press(&mut ui, &mut s, at(hdr)).is_empty());
        // Not even with HDR saved on, from another computer: nor its sliders and calibration.
    // rust: s.horizon.hdr = true;
    // rust: for h in [H::Hdr, H::HdrCalibrate, H::HdrPeak, H::HdrPaperWhite] {
    // rust: assert!(Item::Horizon(h).blocked(&s).is_some(), "{h:?}");
}
    // rust: s.horizon.hdr = false;
    // rust: crate::graphics::offer_hdr(true);
    // rust: let (tx, _) = Columns::of(SIZE.0, SIZE.1).track();
    // rust: let peak = row(&mut ui, &s, Item::Horizon(H::HdrPeak));
    // rust: assert!(press(&mut ui, &mut s, (tx + 2.0, peak[1] + 4.0)).is_empty());
        // The switch turns it on, and the sliders below it work.
    // rust: let hdr = row(&mut ui, &s, Item::Horizon(H::Hdr));
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, at(hdr)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert!(s.horizon.hdr);
    // rust: let peak = row(&mut ui, &s, Item::Horizon(H::HdrPeak));
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (tx + 2.0, peak[1] + 4.0)),
    // rust: [Action::SliderDrag]
    // rust: );
    // rust: ui.release();
        // Calibrate starts the calibration; the shortcut row waits for a key.
    // rust: let calibrate = row(&mut ui, &s, Item::Horizon(H::HdrCalibrate));
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, at(calibrate)),
    // rust: [Action::ButtonClick, Action::Calibrate]
    // rust: );
    // rust: let key = row(&mut ui, &s, Item::Horizon(H::HdrKey));
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, at(key)),
    // rust: [
    // rust: Action::ButtonClick,
    // rust: Action::BindKey(crate::graphics::HDR_KEY)
    // rust: ]
    // rust: );
    // rust: assert!(ui.changed);
}

the_scrollbar_can_be_held_and_dragged :: proc() {
}
        // #3552: AbstractScrollArea.updateScrolling holds the scrollbar on a press over its
        // column, mouseDragged moves the list with the pointer, onRelease lets go.
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let (cols, _, content) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: let x = cols.bar_x() + 2.0;
    // rust: let drag = |ui: &mut GraphicsUi, s: &mut Settings, y, drag| {
    // rust: ui.click(s, (x, y), SIZE, FB, drag, false, false)
}
    // rust: assert!(drag(&mut ui, &mut s, cols.top + 5.0, false).is_empty());
    // rust: drag(&mut ui, &mut s, cols.top + 15.0, true);
    // rust: assert!(ui.scroll.amount > 0.0);
    // rust: drag(&mut ui, &mut s, cols.bottom + 50.0, true);
    // rust: assert_eq!(ui.scroll.amount, content - (cols.bottom - cols.top));
    // rust: drag(&mut ui, &mut s, cols.top - 50.0, true);
    // rust: assert_eq!(ui.scroll.amount, 0.0);
    // rust: assert!(!ui.release());
    // rust: drag(&mut ui, &mut s, cols.bottom + 50.0, true);
    // rust: assert_eq!(ui.scroll.amount, 0.0);
}

a_held_scroller_lets_go_when_the_window_gets_too_short_for_it :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let (cols, ..) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: let x = cols.bar_x() + 2.0;
    // rust: ui.click(&mut s, (x, cols.top + 5.0), SIZE, FB, false, false, false);
    // rust: assert!(ui.scroll.held());
        // A 130-high GUI leaves the list under the 40 px the scroller's thumb needs.
    // rust: let short = (SIZE.0, 130.0);
    // rust: assert!(!Columns::of(short.0, short.1).scrolls());
    // rust: assert!(
    // rust: ui.click(&mut s, (x, 80.0), short, FB, true, false, false)
    // rust: .is_empty()
    // rust: );
    // rust: assert!(!ui.scroll.held());
}

    // The rows only vanilla's Video Settings had work here as they do there: its preset
    // applies its distances (`Options.applyGraphicsPreset`), Max Anisotropy waits for
    // Anisotropic filtering, Exclusive Fullscreen is a tick box of `options.txt`.
vanilla_video_rows_work_on_the_graphics_screen :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let preset = Item::Vanilla(Opt::Preset);
    // rust: preset.set_slider(&mut s, 0.0);
    // rust: assert_eq!(
    // rust: (s.graphics_preset.as_str(), s.render_distance, s.cloud_range),
    // rust: ("fast", 8, 32)
    // rust: );
    // rust: preset.set_slider(&mut s, 2.0 / 3.0);
    // rust: assert_eq!(
    // rust: (s.graphics_preset.as_str(), s.render_distance, s.cloud_range),
    // rust: ("fabulous", 32, 128)
    // rust: );
    // rust: let anisotropy = Item::Vanilla(Opt::MaxAnisotropy);
    // rust: let filtering = Item::Vanilla(Opt::TextureFiltering);
    // rust: while s.file.int("textureFiltering") == 2 {
    // rust: filtering.cycle(&mut s, false, FB);
}
    // rust: assert!(anisotropy.blocked(&s).is_some());
    // rust: while s.file.int("textureFiltering") != 2 {
    // rust: filtering.cycle(&mut s, false, FB);
}
    // rust: assert!(anisotropy.blocked(&s).is_none());
    // rust: let exclusive = Item::Vanilla(Opt::ExclusiveFullscreen);
    // rust: assert_eq!(exclusive.switch(&s), Some(false));
    // rust: exclusive.cycle(&mut s, false, FB);
    // rust: assert_eq!(exclusive.switch(&s), Some(true));
    // rust: assert!(s.file.bool("exclusiveFullscreen"));
        // The graphics extras switch their own setting.
    // rust: let lights = Item::Extra(crate::extras::Item::DynamicLights);
    // rust: lights.cycle(&mut s, false, FB);
    // rust: assert!(s.extras.dynamic_lights);
    // rust: assert_eq!(lights.switch(&s), Some(true));
}

the_wheel_scrolls_and_stops_at_both_ends_without_changing_values :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: s.gamma = 0.25;
    // rust: let gamma = row(&mut ui, &s, Item::Vanilla(Opt::Gamma));
        // A slider being changed doesn't take the wheel either: a controller scrolls with it.
    // rust: press(&mut ui, &mut s, (gamma[0] + 4.0, gamma[1] + 4.0));
    // rust: assert!(ui.can_change_value);
    // rust: let before = ui.scroll.amount;
    // rust: ui.scroll(&s, SIZE, -1.0);
    // rust: assert_eq!(ui.scroll.amount, before + 18.0);
    // rust: assert_eq!(s.gamma, 0.25);
    // rust: let (cols, _, content) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: ui.scroll(&s, SIZE, -1000.0);
    // rust: assert_eq!(ui.scroll.amount, content - (cols.bottom - cols.top));
    // rust: ui.scroll(&s, SIZE, 1000.0);
    // rust: assert_eq!(ui.scroll.amount, 0.0);
}

a_hovered_value_takes_the_wheel_only_with_the_extra_on :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let item = Item::Vanilla(Opt::AttackIndicator);
    // rust: let r = row(&mut ui, &s, item);
    // rust: let before = format!("{s:?}");
    // rust: let actions = ui.wheel(&mut s, SIZE, (r[0] + 4.0, r[1] + 4.0), FB, -1.0);
    // rust: assert_eq!(format!("{s:?}"), before, "the hovered value stays put");
    // rust: assert!(actions.is_empty());

    // rust: s.extras.wheel_cycles_settings = true;
    // rust: let r = row(&mut ui, &s, item);
    // rust: let before = format!("{s:?}");
    // rust: let actions = ui.wheel(&mut s, SIZE, (r[0] + 4.0, r[1] + 4.0), FB, -1.0);
    // rust: assert_ne!(format!("{s:?}"), before, "the hovered value steps");
    // rust: assert!(!actions.is_empty());
}

the_arrows_move_between_rows_in_view_and_over_to_the_page_list :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: let in_view = |ui: &mut GraphicsUi, s: &Settings, item| {
    // rust: let (cols, lines, _) = ui.layout(s, SIZE.0, SIZE.1);
    // rust: let line = lines
    // rust: .iter()
    // rust: .find(|l| l.setting.is_some_and(|r| r.item == item))
    // rust: .unwrap();
    // rust: let y = ui.row_y(&cols, line);
    // rust: y >= cols.top && y + style::ROW <= cols.bottom
}
        // General's last row, against the bottom of the view, then Up: the row over it.
    // rust: let last = Item::Vanilla(Opt::Autosave);
    // rust: row(&mut ui, &s, last);
    // rust: ui.focus = Some(Target::Item(last));
    // rust: ui.key_modifiers(&mut s, K::ArrowUp, None, false, SIZE, FB);
    // rust: let indicator = Item::Vanilla(Opt::AttackIndicator);
    // rust: assert_eq!(ui.focus, Some(Target::Item(indicator)));
    // rust: assert!(in_view(&mut ui, &s, indicator));
        // Left leaves the plate.
    // rust: ui.key_modifiers(&mut s, K::ArrowLeft, None, false, SIZE, FB);
    // rust: assert!(!matches!(ui.focus, Some(Target::Item(_))), "{:?}", ui.focus);
        // Up from Done: the page list's last page.
    // rust: ui.focus = Some(Target::Done);
    // rust: ui.key_modifiers(&mut s, K::ArrowUp, None, false, SIZE, FB);
    // rust: assert_eq!(ui.focus, Some(Target::Page(Page::Hdr)));
        // Its row wheeled far out of view: Down takes the first row in view, as it is.
    // rust: ui.focus = Some(Target::Item(Item::Horizon(H::Preset)));
    // rust: ui.scroll(&s, SIZE, -1000.0);
    // rust: let before = ui.scroll.amount;
    // rust: assert!(before > 0.0);
    // rust: ui.key_modifiers(&mut s, K::ArrowDown, None, false, SIZE, FB);
    // rust: let Some(Target::Item(item)) = ui.focus else {
    // rust: panic!("{:?}", ui.focus)
}
    // rust: assert!(in_view(&mut ui, &s, item), "{item:?}");
    // rust: assert_eq!(ui.scroll.amount, before);
}

the_keyboard_tabs_through_settings_and_steps_sliders :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = GraphicsUi::default();
    // rust: s.horizon.chunk_updates = 10;
    // rust: let tab_to = |ui: &mut GraphicsUi, s: &mut Settings, target| {
    // rust: (0..40).any(|_| {
    // rust: ui.key_modifiers(s, K::Tab, None, false, SIZE, FB);
    // rust: ui.focus == Some(target)
    // rust: })
}
        // Tab reaches the page list; Enter opens Performance and Tab goes on into it.
    // rust: assert!(tab_to(&mut ui, &mut s, Target::Page(Page::Performance)));
    // rust: let (actions, _) = ui.key_modifiers(&mut s, K::Enter, None, false, SIZE, FB);
    // rust: assert_eq!(actions, [Action::ButtonClick]);
    // rust: let chunk_updates = Target::Item(Item::Horizon(H::ChunkUpdates));
    // rust: assert!(tab_to(&mut ui, &mut s, chunk_updates) && ui.can_change_value);
        // Tab scrolled its row into view.
    // rust: let r = {
    // rust: let (cols, lines, _) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: let line = lines
    // rust: .iter()
    // rust: .find(|l| {
    // rust: l.setting
    // rust: .is_some_and(|r| r.item == Item::Horizon(H::ChunkUpdates))
    // rust: })
    // rust: .copied()
    // rust: .unwrap();
    // rust: ui.row_y(&cols, &line)
}
    // rust: let cols = Columns::of(SIZE.0, SIZE.1);
    // rust: assert!(r >= cols.top && r + style::ROW <= cols.bottom);
    // rust: let (actions, handled) = ui.key_modifiers(&mut s, K::ArrowRight, None, false, SIZE, FB);
    // rust: assert!(handled && actions == [Action::SliderDrag]);
    // rust: assert_eq!(s.horizon.chunk_updates, 11);
    // rust: ui.key_modifiers(&mut s, K::ArrowLeft, None, false, SIZE, FB);
    // rust: assert_eq!(s.horizon.chunk_updates, 10);
        // Space lets go of the value: the arrows move the focus again.
    // rust: ui.key_modifiers(&mut s, K::Space, None, false, SIZE, FB);
    // rust: assert!(!ui.can_change_value);
    // rust: ui.key_modifiers(&mut s, K::ArrowDown, None, false, SIZE, FB);
    // rust: assert_eq!(ui.focus, Some(Target::Item(Item::Horizon(H::UploadBudget))));
        // Enter presses a switch; Escape is left to the screen, which closes.
    // rust: ui.focus = Some(Target::Item(Item::Horizon(H::Fog)));
    // rust: let (actions, _) = ui.key_modifiers(&mut s, K::Enter, None, false, SIZE, FB);
    // rust: assert_eq!(actions, [Action::ButtonClick, Action::Changed]);
    // rust: assert!(!s.horizon.fog);
    // rust: assert_eq!(
    // rust: ui.key_modifiers(&mut s, K::Escape, None, false, SIZE, FB),
    // rust: (Vec::new(), false)
    // rust: );
}

rows_split_vanilla_labels_into_name_and_value :: proc() {
}
    // rust: let s = Settings::default();
    // rust: let (name, value) = parts(Item::Horizon(H::LodDistance), &s, false);
    // rust: assert_eq!(
    // rust: (name.as_str(), value.as_deref()),
    // rust: ("LOD Distance", Some("Off"))
    // rust: );
    // rust: let (name, value) = parts(Item::Horizon(H::HdrCalibrate), &s, false);
    // rust: assert!(!name.is_empty() && value.is_none());
}

hdr_setup_follows_what_the_system_reported :: proc() {
}
    // rust: let mut g = crate::graphics::Graphics::default();
    // rust: assert_eq!(setup_of(&g, false), Setup::Unknown);
    // rust: assert_eq!(setup_of(&g, true), Setup::Automatic);
    // rust: g.hdr_paper_white = 80;
    // rust: assert_eq!(setup_of(&g, true), Setup::Changed);
    // rust: assert_eq!(setup_of(&g, false), Setup::Unknown);
}

lod_distance_slides_after_render_distance_without_changing_it :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let item = Item::Horizon(H::LodDistance);
    // rust: let near = s.render_distance;
    // rust: assert_eq!(item.label(&s).plain(), "LOD Distance: Off");
    // rust: assert_eq!(item.slider(&s), Some(0.0));
    // rust: let items: Vec<_> = items().into_iter().map(|(_, i)| i).collect();
    // rust: let render = items
    // rust: .iter()
    // rust: .position(|i| *i == Item::Vanilla(Opt::RenderDistance))
    // rust: .unwrap();
    // rust: assert_eq!(items[render + 1], item);
        // Every stop is reachable and reads back as the same position.
    // rust: for (i, &distance) in LOD_STEPS.iter().enumerate() {
    // rust: let at = i as f32 / (LOD_STEPS.len() - 1) as f32;
    // rust: item.set_slider(&mut s, at);
    // rust: assert_eq!(s.horizon.lod_distance, distance);
    // rust: assert_eq!(item.slider(&s), Some(at));
    // rust: assert_eq!(s.render_distance, near);
}
        // The ends are off and the whole world, which the far terrain plans.
    // rust: item.set_slider(&mut s, 0.0);
    // rust: assert_eq!(s.horizon.lod_distance, 0);
    // rust: item.set_slider(&mut s, 1.0);
    // rust: assert_eq!(s.horizon.lod_distance, crate::lod::MAX_CHUNKS);
    // rust: assert_eq!(
    // rust: item.label(&s).plain(),
    // rust: format!("LOD Distance: {} chunks", crate::lod::MAX_CHUNKS)
    // rust: );
    // rust: item.set_slider(&mut s, 5.0 / 17.0);
    // rust: assert_eq!(s.horizon.lod_distance, 1024);
    // rust: assert_eq!(item.label(&s).plain(), "LOD Distance: 1024 chunks");
        // A distance between stops (from the file) sits on the next one.
    // rust: s.horizon.lod_distance = 3000;
    // rust: assert_eq!(item.slider(&s), Some(7.0 / 17.0));
    // rust: assert_eq!(
    // rust: Item::Vanilla(Opt::RenderDistance).label(&s).plain(),
    // rust: format!("Full Detail Distance: {near} chunks")
    // rust: );
}

blue_map_settings_sit_with_far_terrain :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let find = Item::Horizon(H::BlueMapAutoDetect);
    // rust: let radius = Item::Horizon(H::BlueMapRadius);
    // rust: let distance: Vec<Item> = rows()
    // rust: .into_iter()
    // rust: .flat_map(|(_, groups)| groups)
    // rust: .find(|(name, _)| *name == "Distance")
    // rust: .unwrap()
    // rust: .1
    // rust: .iter()
    // rust: .map(|r| r.item)
    // rust: .collect();
    // rust: assert!(distance.contains(&find) && distance.contains(&radius));
    // rust: assert!(distance.contains(&Item::Horizon(H::FarDetail)));
    // rust: assert_eq!(find.switch(&s), Some(false), "off by default");
    // rust: assert_eq!(radius.label(&s).plain(), "BlueMap Radius: 64 chunks");
    // rust: find.cycle(&mut s, false, FB);
    // rust: assert!(s.horizon.blue_map.auto_detect);
    // rust: radius.cycle(&mut s, false, FB);
    // rust: assert_eq!(s.horizon.blue_map.radius, 128);
    // rust: radius.cycle(&mut s, true, FB);
    // rust: radius.cycle(&mut s, true, FB);
    // rust: assert_eq!(radius.label(&s).plain(), "BlueMap Radius: 32 chunks");
    // rust: assert_eq!(s.horizon.preset, Preset::Custom);
}

presets_set_vanilla_and_horizon_options :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: Item::Horizon(H::Preset).cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(s.horizon.preset, Preset::Performance);
    // rust: assert_eq!(s.render_distance, 8);
    // rust: assert_eq!(s.clouds, "false");
        // Any quality change leaves the preset.
    // rust: Item::Vanilla(Opt::Clouds).cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(s.horizon.preset, Preset::Custom);
        // Display preferences keep it.
    // rust: Item::Horizon(H::Preset).cycle(&mut s, true, [854, 480]);
    // rust: Item::Vanilla(Opt::Vsync).cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(s.horizon.preset, Preset::Ultra);
}

screenshot_quality_cycles_1_2_4_8_and_keeps_the_preset :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: Item::Horizon(H::Preset).cycle(&mut s, false, [854, 480]);
    // rust: let mut seen = Vec::new();
    // rust: for _ in 0..4 {
    // rust: Item::Horizon(H::ScreenshotQuality).cycle(&mut s, false, [854, 480]);
    // rust: seen.push(s.horizon.screenshot_quality);
}
    // rust: assert_eq!(seen, [2, 4, 8, 1]);
    // rust: Item::Horizon(H::ScreenshotQuality).cycle(&mut s, true, [854, 480]);
    // rust: assert_eq!(s.horizon.screenshot_quality, 8);
    // rust: assert_eq!(s.horizon.preset, Preset::Performance);
}

upload_budget_slider_steps :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: H::UploadBudget.set_slider(&mut s, 1.0);
    // rust: assert_eq!(s.horizon.upload_budget_kib, 16384);
    // rust: assert_eq!(H::UploadBudget.slider(&s), Some(1.0));
    // rust: H::UploadBudget.set_slider(&mut s, 0.0);
    // rust: assert_eq!(s.horizon.upload_budget_kib, 0);
}

antialiasing_cycles_off_fxaa_taa :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let item = Item::Horizon(H::Antialiasing);
    // rust: for label in ["FXAA", "TAA", "Off"] {
    // rust: item.cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(item.label(&s).plain(), format!("Anti-aliasing: {label}"));
}
    // rust: item.cycle(&mut s, true, [854, 480]);
    // rust: assert_eq!((s.horizon.fxaa, s.horizon.taa), (false, true));

        // Upscaling needs TAA: a ratio turns it on, leaving TAA goes back to Native.
    // rust: s.horizon.taa = false;
    // rust: let upscaling = Item::Horizon(H::Upscaling);
    // rust: upscaling.cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(upscaling.label(&s).plain(), "Upscaling: Quality");
    // rust: assert!(s.horizon.taa);
    // rust: item.cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(s.horizon.upscaling, Upscaling::Native);

        // The Upscaling row is only on the screen while TAA is on.
    // rust: assert!(!shown(upscaling, &s));
    // rust: s.horizon.taa = true;
    // rust: assert!(shown(upscaling, &s));
}

entity_culling_modes_are_opt_in_and_cycle_from_its_row :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let item = Item::Horizon(H::EntityCulling);
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Off);
    // rust: assert_eq!(item.label(&s).plain(), "Entity Culling: Off");
    // rust: for mode in EntityCullingMode::ALL {
    // rust: s.horizon.entity_culling = mode;
    // rust: for preset in Preset::ALL {
    // rust: crate::graphics::apply_preset(preset, &mut s);
    // rust: assert_eq!(s.horizon.entity_culling, mode);
}
}
    // rust: s.horizon.entity_culling = EntityCullingMode::Off;
    // rust: let mut ui = GraphicsUi::default();
    // rust: let r = row(&mut ui, &s, item);
    // rust: for mode in [
    // rust: EntityCullingMode::Synchronous,
    // rust: EntityCullingMode::Asynchronous,
    // rust: ] {
    // rust: s.horizon.preset = Preset::Balanced;
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (r[0] + 4.0, r[1] + 4.0)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, mode);
    // rust: assert_eq!(s.horizon.preset, Preset::Custom);
}
    // rust: assert_eq!(item.label(&s).plain(), "Entity Culling: Asynchronous");
}

particle_culling_modes_are_opt_in_and_cycle_from_its_row :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let item = Item::Horizon(H::ParticleCulling);
    // rust: assert_eq!(s.horizon.particle_culling, ParticleCullingMode::Off);
    // rust: assert_eq!(item.label(&s).plain(), "Particle Culling: Off");
    // rust: for mode in ParticleCullingMode::ALL {
    // rust: s.horizon.particle_culling = mode;
    // rust: for preset in Preset::ALL {
    // rust: crate::graphics::apply_preset(preset, &mut s);
    // rust: assert_eq!(s.horizon.particle_culling, mode);
}
    // rust: assert_eq!(
    // rust: crate::graphics::Graphics::parse(&s.horizon.serialize()).particle_culling,
    // rust: mode
    // rust: );
}
    // rust: s.horizon.particle_culling = ParticleCullingMode::Off;
    // rust: let mut ui = GraphicsUi::default();
    // rust: let r = row(&mut ui, &s, item);
    // rust: for (mode, label) in [
    // rust: (ParticleCullingMode::Synchronous, "Synchronous"),
    // rust: (ParticleCullingMode::Asynchronous, "Asynchronous"),
    // rust: (ParticleCullingMode::Off, "Off"),
    // rust: ] {
    // rust: s.horizon.preset = Preset::Balanced;
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (r[0] + 4.0, r[1] + 4.0)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.particle_culling, mode);
    // rust: assert_eq!(s.horizon.preset, Preset::Custom);
    // rust: assert_eq!(item.label(&s).plain(), format!("Particle Culling: {label}"));
}
}

graphics_cycle_button_cycles_forward_and_shift_click_cycles_backward_with_wrapping :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let item = Item::Horizon(H::EntityCulling);
    // rust: let mut ui = GraphicsUi::default();
    // rust: let r = row(&mut ui, &s, item);
    // rust: let at = (r[0] + 4.0, r[1] + 4.0);

        // 1. Feature without shift (normal click): cycles forward (+1)
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Off);
    // rust: assert_eq!(
    // rust: press_shift(&mut ui, &mut s, at, false),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Synchronous);

    // rust: assert_eq!(
    // rust: press_shift(&mut ui, &mut s, at, false),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Asynchronous);

        // 3. Wrap-around forward (at max value, normal click wraps to min / 0)
    // rust: assert_eq!(
    // rust: press_shift(&mut ui, &mut s, at, false),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Off);

        // 4. Wrap-around backward (at min / 0, shift-click wraps to max)
    // rust: assert_eq!(
    // rust: press_shift(&mut ui, &mut s, at, true),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Asynchronous);

        // 2. Feature with shift: cycles backward (-1)
    // rust: assert_eq!(
    // rust: press_shift(&mut ui, &mut s, at, true),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Synchronous);

    // rust: assert_eq!(
    // rust: press_shift(&mut ui, &mut s, at, true),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling, EntityCullingMode::Off);
}

entity_culling_precheck_slider_is_only_live_for_async :: proc() {
}
    // rust: let item = Item::Horizon(H::EntityCullingPrecheck);
    // rust: let mut s = Settings::default();
    // rust: let initial = s.horizon.entity_culling_precheck;

    // rust: for mode in [EntityCullingMode::Off, EntityCullingMode::Synchronous] {
    // rust: s.horizon.entity_culling = mode;
    // rust: assert_eq!(
    // rust: item.blocked(&s),
    // rust: Some("Only applies to asynchronous entity culling.")
    // rust: );

    // rust: let mut ui = GraphicsUi::default();
    // rust: let row_rect = row(&mut ui, &s, item);
    // rust: assert!(press(&mut ui, &mut s, (row_rect[0] + 4.0, row_rect[1] + 4.0)).is_empty());
    // rust: item.set_slider(&mut s, 1.0);
    // rust: assert_eq!(s.horizon.entity_culling_precheck, initial);

    // rust: let (cols, lines, content) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: assert!(
    // rust: !ui.focusables(&s, &cols, &lines, false)
    // rust: .iter()
    // rust: .any(|(target, _)| *target == Target::Item(item))
    // rust: );
    // rust: ui.focus_on(&s, Target::Item(item), row_rect, &cols, content);
    // rust: assert!(!ui.can_change_value);
}

    // rust: for (code, expected) in [
    // rust: ("en_us", "Only applies to asynchronous entity culling."),
    // rust: ("de_de", "Nur für asynchrones Objekt-Culling."),
    // rust: (
    // rust: "es_es",
    // rust: "Solo se aplica a la oclusión asíncrona de entidades.",
    // rust: ),
    // rust: (
    // rust: "fr_fr",
    // rust: "S'applique uniquement à l'occlusion asynchrone des entités.",
    // rust: ),
    // rust: ("pl_pl", "Dotyczy tylko asynchronicznego pomijania bytów."),
    // rust: (
    // rust: "ru_ru",
    // rust: "Применяется только при асинхронном отсечении сущностей.",
    // rust: ),
    // rust: ("tr_tr", "Yalnızca eşzamansız varlık elemesine uygulanır."),
    // rust: (
    // rust: "uk_ua",
    // rust: "Застосовується лише для асинхронного відсікання сутностей.",
    // rust: ),
    // rust: ("zh_cn", "仅适用于异步实体剔除。"),
    // rust: ] {
    // rust: let (shown, missed) = lang::scoped(lang::Language::load(&[], code), || {
    // rust: lang::get(item.blocked(&s).unwrap())
    // rust: });
    // rust: assert_eq!(shown, expected, "{code}");
    // rust: assert!(missed.is_empty(), "{code}: {missed:?}");
}

    // rust: s.horizon.entity_culling = EntityCullingMode::Asynchronous;
    // rust: assert_eq!(item.blocked(&s), None);
    // rust: let mut ui = GraphicsUi::default();
    // rust: let row_rect = row(&mut ui, &s, item);
    // rust: let (cols, _, _) = ui.layout(&s, SIZE.0, SIZE.1);
    // rust: let (track_x, track_w) = cols.track();
    // rust: assert_eq!(
    // rust: press(
    // rust: &mut ui,
    // rust: &mut s,
    // rust: (track_x + track_w - 4.0, row_rect[1] + 4.0)
    // rust: ),
    // rust: [Action::SliderDrag]
    // rust: );
    // rust: assert_eq!(s.horizon.entity_culling_precheck, 512);
}

    // Translucent Batching: a switch on the Advanced page, on by default, no part of a
    // preset, and greyed out, reading Off, where the device can't batch.
translucent_batching_is_an_advanced_switch_where_the_device_can :: proc() {
}
    // rust: let item = Item::Horizon(H::TranslucentBatching);
    // rust: let page = items()
    // rust: .into_iter()
    // rust: .find(|(_, i)| *i == item)
    // rust: .map(|(p, _)| p);
    // rust: if cfg!(target_os = "macos") {
            // Metal draws flat: never offered, so not shown.
    // rust: assert_eq!(page, None);
    // rust: return;
}
    // rust: assert_eq!(page, Some(Page::Advanced));
    // rust: let mut s = Settings::default();
    // rust: s.horizon.preset = Preset::Balanced;
    // rust: let mut ui = GraphicsUi::default();
        // Where the device can't, the saved On reads Off, and neither a click nor Enter
        // after it does anything: no sound, no change, no save.
    // rust: crate::graphics::offer_translucent_batching(false);
    // rust: assert!(item.blocked(&s).is_some());
    // rust: assert_eq!(item.label(&s).plain(), "Translucent Batching: Off");
    // rust: assert_eq!(item.switch(&s), Some(false));
    // rust: let r = row(&mut ui, &s, item);
    // rust: let point = (r[0] + 4.0, r[1] + 4.0);
    // rust: assert!(press(&mut ui, &mut s, point).is_empty());
    // rust: ui.focus = Some(Target::Item(item));
    // rust: let enter = ui.key_modifiers(&mut s, K::Enter, None, false, SIZE, FB);
    // rust: assert!(enter.0.is_empty());
    // rust: assert!(s.horizon.translucent_batching);
        // Where it can, a click switches it and keeps the preset.
    // rust: crate::graphics::offer_translucent_batching(true);
    // rust: assert_eq!(item.label(&s).plain(), "Translucent Batching: On");
    // rust: assert_eq!(item.switch(&s), Some(true));
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, point),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert!(!s.horizon.translucent_batching);
    // rust: assert_eq!(item.label(&s).plain(), "Translucent Batching: Off");
    // rust: assert_eq!(s.horizon.preset, Preset::Balanced);
        // No preset sets it.
    // rust: for on in [false, true] {
    // rust: s.horizon.translucent_batching = on;
    // rust: for preset in Preset::ALL {
    // rust: crate::graphics::apply_preset(preset, &mut s);
    // rust: assert_eq!(s.horizon.translucent_batching, on, "{preset:?}");
}
}
}

    // GPU Culling: a switch right after Cave Culling, off by default, no part of a preset,
    // and greyed out with its reason, reading Off, wherever it isn't offered.
gpu_culling_is_a_culling_switch_where_it_is_offered :: proc() {
}
//         use crate::graphics::GpuCullingOffer;
    // rust: let item = Item::Horizon(H::GpuCulling);
    // rust: let at = |item| items().into_iter().position(|(_, i)| i == item);
    // rust: if cfg!(target_os = "macos") {
            // Metal draws no count the GPU wrote: never offered, so not shown.
    // rust: assert_eq!(at(item), None);
    // rust: return;
}
    // rust: let i = at(item).unwrap();
    // rust: assert_eq!(items()[i].0, Page::Performance);
    // rust: assert_eq!(at(Item::Horizon(H::CaveCulling)), Some(i - 1));
    // rust: let mut s = Settings::default();
    // rust: assert_eq!(item.switch(&s), Some(false));
    // rust: s.horizon.preset = Preset::Balanced;
    // rust: s.horizon.gpu_culling = true;
        // Where it isn't offered, the saved On reads Off, and neither a click nor Enter after
        // it does anything.
    // rust: for offer in [
    // rust: GpuCullingOffer::Unsupported,
    // rust: GpuCullingOffer::Software,
    // rust: GpuCullingOffer::OutOfMemory,
    // rust: GpuCullingOffer::Dx12,
    // rust: GpuCullingOffer::DeviceLost,
    // rust: ] {
    // rust: crate::graphics::offer_gpu_culling(offer);
    // rust: assert!(offer.reason().is_some());
    // rust: assert_eq!(item.blocked(&s), offer.reason());
    // rust: assert_eq!(item.label(&s).plain(), "GPU Culling: Off");
            // The box, the narrator and the widget tree read the switch.
    // rust: assert_eq!(item.switch(&s), Some(false), "{offer:?}");
    // rust: let mut ui = GraphicsUi::default();
    // rust: let r = row(&mut ui, &s, item);
    // rust: assert!(press(&mut ui, &mut s, (r[0] + 4.0, r[1] + 4.0)).is_empty());
    // rust: ui.focus = Some(Target::Item(item));
    // rust: let enter = ui.key_modifiers(&mut s, K::Enter, None, false, SIZE, FB);
    // rust: assert!(enter.0.is_empty());
    // rust: assert!(s.horizon.gpu_culling, "{offer:?}");
}
        // Where it is, a click switches it and keeps the preset.
    // rust: crate::graphics::offer_gpu_culling(GpuCullingOffer::Offered);
    // rust: assert_eq!(item.blocked(&s), None);
    // rust: assert_eq!(item.label(&s).plain(), "GPU Culling: On");
    // rust: assert_eq!(item.switch(&s), Some(true));
    // rust: let mut ui = GraphicsUi::default();
    // rust: let r = row(&mut ui, &s, item);
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (r[0] + 4.0, r[1] + 4.0)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert!(!s.horizon.gpu_culling);
    // rust: assert_eq!(s.horizon.preset, Preset::Balanced);
        // No preset sets it.
    // rust: for on in [false, true] {
    // rust: s.horizon.gpu_culling = on;
    // rust: for preset in Preset::ALL {
    // rust: crate::graphics::apply_preset(preset, &mut s);
    // rust: assert_eq!(s.horizon.gpu_culling, on, "{preset:?}");
}
}
}

leaf_culling_cycles_modes_beside_the_other_culling :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let item = Item::Horizon(H::LeafCulling);
    // rust: assert_eq!(item.switch(&s), None);
    // rust: assert_eq!(item.label(&s).plain(), "Leaf Culling: Off");
    // rust: for label in ["Hidden Faces", "Solid", "Solid Aggressive", "Hollow", "Off"] {
    // rust: item.cycle(&mut s, false, FB);
    // rust: assert_eq!(item.label(&s).plain(), format!("Leaf Culling: {label}"));
    // rust: assert_eq!(
    // rust: crate::graphics::Graphics::parse(&s.horizon.serialize()).leaf_culling,
    // rust: s.horizon.leaf_culling
    // rust: );
}
    // rust: item.cycle(&mut s, true, FB);
    // rust: assert_eq!(s.horizon.leaf_culling, LeafCullingMode::Hollow);

        // The three culling settings share one group of the Performance page.
    // rust: let culling = rows()
    // rust: .into_iter()
    // rust: .flat_map(|(page, groups)| groups.into_iter().map(move |(_, b)| (page, b)))
    // rust: .find(|(_, b)| b.iter().any(|r| r.item == item))
    // rust: .unwrap();
    // rust: assert_eq!(culling.0, Page::Performance);
    // rust: let block: Vec<Item> = culling.1.iter().map(|r| r.item).collect();
    // rust: for h in [
    // rust: H::CaveCulling,
    // rust: H::EntityCulling,
    // rust: H::ParticleCulling,
    // rust: H::LeafCulling,
    // rust: ] {
    // rust: assert!(block.contains(&Item::Horizon(h)), "{h:?}");
}
        // The block-entity caches are the group after it, in this order.
    // rust: let groups: Vec<(&str, Vec<Item>)> = rows()
    // rust: .into_iter()
    // rust: .find(|(page, _)| *page == Page::Performance)
    // rust: .unwrap()
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|(name, rows)| (name, rows.iter().map(|r| r.item).collect()))
    // rust: .collect();
    // rust: let at = groups
    // rust: .iter()
    // rust: .position(|(name, _)| *name == "Culling")
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: groups[at + 1],
    // rust: (
    // rust: "Block Entities",
    // rust: [
    // rust: H::CacheShulkerBoxes,
    // rust: H::CacheSigns,
    // rust: H::CacheDecoratedPots,
    // rust: H::CacheBells,
    // rust: H::CacheChests,
    // rust: H::CacheBanners,
    // rust: H::CacheCopperGolemStatues,
    // rust: ]
    // rust: .map(Item::Horizon)
    // rust: .to_vec()
    // rust: )
    // rust: );

        // The description names what the picked mode does.
    // rust: for mode in LeafCullingMode::ALL {
    // rust: s.horizon.leaf_culling = mode;
    // rust: let text = description(item, &s, "fallback");
    // rust: assert_ne!(text, "fallback", "{mode:?}");
    // rust: assert!(text.len() < 80, "{mode:?}: {text}");
}

        // A click cycles it and leaves the preset, as the other quality settings do.
    // rust: let mut ui = GraphicsUi::default();
    // rust: s.horizon.preset = Preset::Balanced;
    // rust: s.horizon.leaf_culling = LeafCullingMode::Off;
    // rust: let r = row(&mut ui, &s, item);
    // rust: assert_eq!(
    // rust: press(&mut ui, &mut s, (r[0] + 4.0, r[1] + 4.0)),
    // rust: [Action::ButtonClick, Action::Changed]
    // rust: );
    // rust: assert_eq!(s.horizon.leaf_culling, LeafCullingMode::Hidden);
    // rust: assert_eq!(s.horizon.preset, Preset::Custom);
}

graphics_step_slider_matches_set_slider_for_all_options :: proc() {
}
        // HDR's sliders step only where the display offers HDR.
    // rust: let _offer = HDR_OFFER.lock().unwrap_or_else(|e| e.into_inner());
    // rust: crate::graphics::offer_hdr(true);
    // rust: let options = [
    // rust: H::ChunkUpdates,
    // rust: H::UploadBudget,
    // rust: H::Workers,
    // rust: H::ResolutionScale,
    // rust: H::HdrPaperWhite,
    // rust: H::HdrPeak,
    // rust: H::HdrBlackLevel,
    // rust: H::HdrUiBrightness,
    // rust: ];
    // rust: for h in options {
    // rust: let item = Item::Horizon(h);
    // rust: let steps = h.slider_steps().expect("steps defined");
    // rust: for i in 0..steps {
    // rust: let pos = i as f32 / steps as f32;
    // rust: let mut s1 = Settings::default();
    // rust: let mut s2 = Settings::default();
    // rust: s1.horizon.hdr = true;
    // rust: s2.horizon.hdr = true;
    // rust: h.set_slider(&mut s1, pos);

    // rust: item.step_slider(&mut s1, true, 200.0);
    // rust: let next_pos = (i + 1) as f32 / steps as f32;
    // rust: h.set_slider(&mut s2, next_pos);
    // rust: assert_eq!(
    // rust: item.slider(&s1),
    // rust: item.slider(&s2),
    // rust: "{h:?} step forward from {i}"
    // rust: );
}
    // rust: for i in 1..=steps {
    // rust: let pos = i as f32 / steps as f32;
    // rust: let mut s1 = Settings::default();
    // rust: let mut s2 = Settings::default();
    // rust: s1.horizon.hdr = true;
    // rust: s2.horizon.hdr = true;
    // rust: h.set_slider(&mut s1, pos);

    // rust: item.step_slider(&mut s1, false, 200.0);
    // rust: let prev_pos = (i - 1) as f32 / steps as f32;
    // rust: h.set_slider(&mut s2, prev_pos);
    // rust: assert_eq!(
    // rust: item.slider(&s1),
    // rust: item.slider(&s2),
    // rust: "{h:?} step backward from {i}"
    // rust: );
}
}
}
    // Horizon's graphics captions are English sentences that the language table keys by
    // themselves, so a caption, description or value that is not in `en_us.json` shows in
    // English in every language. Every text the screen shows, with each setting cycled
    // through its values (#1927).
every_graphics_text_is_in_the_language_table :: proc() {
}
    // rust: let (_, missed) = lang::scoped(lang::Language::load(&[], "de_de"), || {
    // rust: for hdr in [false, true] {
    // rust: let mut s = Settings::default();
    // rust: s.horizon.hdr = hdr;
    // rust: s.horizon.taa = true;
    // rust: for _ in 0..8 {
    // rust: for (page, groups) in rows() {
    // rust: lang::get(page.name());
    // rust: lang::get(page.about());
    // rust: for (group, rows) in groups {
    // rust: lang::get(group);
    // rust: for row in rows {
                                // Vanilla's captions are vanilla's keys, not loaded here.
    // rust: if let Item::Horizon(_) = row.item {
    // rust: row.item.label(&s);
}
    // rust: let text = description(row.item, &s, row.text);
    // rust: lang::get(text);
    // rust: lang::get(row.cost.label());
    // rust: if let Some(why) = row.item.blocked(&s) {
    // rust: lang::get(why);
}
    // rust: if let Item::Horizon(h) = row.item {
    // rust: h.cycle(&mut s, false);
}
}
}
}
}
}
    // rust: for text in [
    // rust: "Search options",
    // rust: "Results for \"%s\"",
    // rust: "No settings match.",
    // rust: "Undo",
    // rust: "Done",
    // rust: ] {
    // rust: lang::get(text);
}
            // Every reason GPU Culling's switch can give, whatever this device offers.
//             use crate::graphics::GpuCullingOffer as O;
    // rust: for offer in [
    // rust: O::Unsupported,
    // rust: O::Software,
    // rust: O::OutOfMemory,
    // rust: O::Dx12,
    // rust: O::DeviceLost,
    // rust: ] {
    // rust: lang::get(offer.reason().unwrap());
}
    // rust: });
        // `labelled` also looks up values that are already words in the language ("An") or
        // numbers with a unit ("12 chunks", "Auto (8)"); those are not keys, and "FSR 3.1" is
        // a name.
    // rust: let missed: Vec<_> = missed
    // rust: .into_iter()
    // rust: .filter(|m| !m.starts_with(|c: char| c.is_ascii_digit()) && !m.starts_with("Auto ("))
    // rust: .filter(|m| !["An", "Aus", "FSR 3.1", "key.keyboard.unknown"].contains(&m.as_str()))
    // rust: .collect();
    // rust: assert_eq!(missed, Vec::<String>::new());
}
    // Horizon's captions join label and value with the language's `options.generic_value` and
    // `options.percent_value`, as vanilla's beside them on the same page do (#6072). The
    // templates are 26.3's.
horizon_captions_use_the_languages_separator :: proc() {
}
Vanilla :: struct {
    // rust: impl lang::ResourceSource for Vanilla {
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (generic, percent) = match path {
    // rust: "assets/minecraft/lang/en_us.json" => ("%s: %s", "%s: %s%%"),
    // rust: "assets/minecraft/lang/fr_fr.json" => ("%s : %s", "%s : %s %%"),
    // rust: "assets/minecraft/lang/zh_cn.json" => ("%s：%s", "%s：%s%%"),
    // rust: "assets/minecraft/lang/en_ud.json" => ("%2$s :%1$s", "%s: %s%%"),
    // rust: _ => return None,
}
    // rust: serde_json::to_vec(&serde_json::json!({
    // rust: "options.generic_value": generic,
    // rust: "options.percent_value": percent,
    // rust: }))
    // rust: .ok()
}
}
    // rust: let mut s = Settings::default();
    // rust: s.horizon.leaf_culling = LeafCullingMode::Hollow;
    // rust: s.horizon.resolution_scale = 75;
    // rust: for (code, leaf, scale) in [
    // rust: ("en_us", "Leaf Culling: Hollow", "Resolution Scale: 75%"),
    // rust: (
    // rust: "fr_fr",
    // rust: "Occlusion feuillage : Creux",
    // rust: "Échelle de résolution : 75 %",
    // rust: ),
    // rust: ("zh_cn", "树叶剔除：镂空", "渲染比例：75%"),
            // Value first.
    // rust: ("en_ud", "Hollow :Leaf Culling", "Resolution Scale: 75%"),
    // rust: ] {
    // rust: let (shown, _) = lang::scoped(lang::Language::load(&[&Vanilla], code), || {
    // rust: (
    // rust: Item::Horizon(H::LeafCulling).label(&s).plain(),
    // rust: Item::Horizon(H::ResolutionScale).label(&s).plain(),
    // rust: )
    // rust: });
    // rust: assert_eq!(shown, (leaf.into(), scale.into()), "{code}");
}
}
    // Leaf Culling, Frame Generation and Shadow Cache came with English captions only (#1927).
newer_graphics_settings_are_translated :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: s.horizon.leaf_culling = LeafCullingMode::Hollow;
    // rust: s.horizon.entity_culling = EntityCullingMode::Asynchronous;
    // rust: s.horizon.particle_culling = ParticleCullingMode::Asynchronous;
    // rust: for (code, leaf, entity, leaf_text, particle, particle_text) in [
    // rust: (
    // rust: "de_de",
    // rust: "Laub-Culling: Hohl",
    // rust: "Objekt-Culling: Asynchron",
    // rust: "Lässt Flächen zwischen Blättern weg: schneller, aber Lücken sind durchsichtig.",
    // rust: "Partikel-Culling: Asynchron",
    // rust: "Überspringt Partikel außerhalb des Bildes, unterhalb eines Pixels oder hinter Terrain und entlastet den Render-Thread.",
    // rust: ),
    // rust: (
    // rust: "pl_pl",
    // rust: "Pomijanie liści: Puste",
    // rust: "Pomijanie bytów: Asynchroniczne",
    // rust: "Pomija ściany między liśćmi: szybciej, ale luki są przezroczyste.",
    // rust: "Pomijanie cząsteczek: Asynchroniczne",
    // rust: "Pomija cząsteczki poza ekranem, mniejsze niż piksel i zasłonięte przez teren, odciążając wątek renderowania.",
    // rust: ),
    // rust: (
    // rust: "uk_ua",
    // rust: "Відсікання листя: Порожнє",
    // rust: "Відсік. сутностей: Асинхронно",
    // rust: "Прибирає грані між листям: швидше, але прогалини прозорі.",
    // rust: "Відсікання частинок: Асинхронно",
    // rust: "Пропускає частинки поза екраном, менші за піксель і закриті місцевістю, зменшуючи роботу потоку рендерингу.",
    // rust: ),
    // rust: (
    // rust: "zh_cn",
    // rust: "树叶剔除: 镂空",
    // rust: "实体剔除: 异步",
    // rust: "省略树叶之间的面：更快，但缝隙会透视。",
    // rust: "粒子剔除: 异步",
    // rust: "跳过屏幕外、小于一个像素和被地形遮挡的粒子，减少渲染线程的工作量。",
    // rust: ),
    // rust: (
    // rust: "fr_fr",
    // rust: "Occlusion feuillage: Creux",
    // rust: "Occlusion des entités: Asynchrone",
    // rust: "Supprime les faces entre feuilles : plus rapide, mais on voit à travers les trous.",
    // rust: "Occlusion des particules: Asynchrone",
    // rust: "Ignore les particules hors écran, trop petites ou masquées par le terrain avec moins de travail sur le thread de rendu.",
    // rust: ),
    // rust: ] {
    // rust: let (shown, _) = lang::scoped(lang::Language::load(&[], code), || {
    // rust: let item = |h| Item::Horizon(h);
    // rust: (
    // rust: item(H::LeafCulling).label(&s).plain(),
    // rust: item(H::EntityCulling).label(&s).plain(),
    // rust: lang::get(description(item(H::LeafCulling), &s, "")),
    // rust: item(H::ParticleCulling).label(&s).plain(),
    // rust: lang::get(description(item(H::ParticleCulling), &s, "")),
    // rust: )
    // rust: });
    // rust: assert_eq!(
    // rust: shown,
    // rust: (
    // rust: leaf.into(),
    // rust: entity.into(),
    // rust: leaf_text.into(),
    // rust: particle.into(),
    // rust: particle_text.into(),
    // rust: ),
    // rust: "{code}"
    // rust: );
}
}
}
