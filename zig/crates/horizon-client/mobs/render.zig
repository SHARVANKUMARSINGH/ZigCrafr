//! Transpiled from Horizon Rust crate
//! Module: horizon-client_render
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mob rendering (`LivingEntityRenderer.submit` and the render layers):
//! variant/baby model and texture selection, setupRotations, per-species
//! scale, and extra layers (sheep wool, spider eyes, drowned/stray outer
//! layers, villager overlays, collars...).
// use super::{
    // rust: Mob, MobData, ModelNormals, Part, Species,
    // rust: anim::{self, Poses},
    // rust: living::wrap,
}
// use crate::mesher::Vertex;
// use horizon_core::geometry::trig::Mth;
// use std::borrow::Cow;
// use std::f32::consts::PI;

/// A texture lookup into the shared atlas (name without namespace -> uv rect).
    // rust: pub type Atlas<'a> = &'a dyn Fn(&str) -> Option<[f32; 4]>;

/// The overlay code of an enchanted armour layer's glint, past the ones
/// `gfx/entity_batch.rs` gives materials (13 is the boat water mask, which
/// draws depth only: armour with 13 vanished; 35 is text pulled toward the
/// camera). It marks the `ARMOR_ENTITY_GLINT_TEXTURING` sample: entity.wgsl
/// transforms the model UV and reads `enchanted_glint_armor`.
pub const ARMOR_GLINT: u32 = 36;

/// `RenderTypes.breezeWind`: the texture of the breeze's wind layer scrolls
/// by 0.02 of the texture per tick.
pub const BREEZE_WIND_SCROLL: f32 = 0.02;
/// `WindChargeRenderer.xOffset`: the wind charge's texture scrolls by 0.03 of
/// the texture per tick.
pub const WIND_CHARGE_SCROLL: f32 = 0.03;
/// The offset of a scrolling texture: `RenderTypes.breezeWind` takes the
/// texture's age times the speed, modulo one.
pub fn scroll_offset(age: f32, speed: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (age * speed) % 1.0
}
/// The vertex's U with the scroll: the texture matrix of
/// `RenderTypes.breezeWind` moves the texture under the model, so the U
/// moves by the offset and wraps around the texture.
pub fn scroll_u(u: f32, scroll: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if scroll == 0.0 { u } else { (u + scroll) % 1.0 }
}
/// Full sky and block light in a vertex's `light`.
pub const FULL_BRIGHT: u32 = 240 | 240 << 8;
/// How brightly the eyes render type's layers (spiders', endermen's and
/// phantoms' eyes, the breeze's, the creaking's, the copper golem's) shine in
/// HDR output, as `mesher::hdr_tier`.
pub const EYES_TIER: u8 = crate::mesher::BRIGHT;

/// Tags quads as drawn by a render type vanilla gives an `OitPipelineSet`
/// (`gfx::OIT_ENTITY`): improved transparency draws them in its stages.
pub fn mark_oit(quads: *mut [Vertex]) void {
}
    // rust: for vertex in quads {
    // rust: vertex.layer |= crate::gfx::OIT_ENTITY;
}
}
/// Whether the species' model is built with `RenderTypes::entityTranslucent`
/// (`Model.renderType`, which `LivingEntityRenderer.getRenderType` uses for the
/// body): the allay, the piglins, the breeze, the vex, the player model and the
/// sulfur cube.
pub fn translucent_body(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: m.species(),
    // rust: Species::Allay
    // rust: | Species::Piglin
    // rust: | Species::PiglinBrute
    // rust: | Species::ZombifiedPiglin
    // rust: | Species::Breeze
    // rust: | Species::Vex
    // rust: | Species::SulfurCube
    // rust: ) || avatar(m)
}
/// Whether a layer's render type has an `OitPipelineSet`: `RenderTypes.eyes` and
/// `entityTranslucentEmissive` (the full bright layers), `breezeWind`, and
/// `entityTranslucent` (the slime's outer cube, the sulfur cube's inner cube
/// and the horse's markings).
pub fn translucent_layer(m: *Mob, layer: *Layer) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: layer.full_bright
    // rust: || layer.model == "breeze#wind"
    // rust: || layer.model == "slime#outer"
    // rust: || matches!(m.species(), Species::SulfurCube)
    // rust: || layer.texture.starts_with("entity/horse/horse_markings")
}

/// Whether a layer is the eyes render type's (`RenderTypes.eyes`: full bright, no
/// normal, at `EYES_TIER`) on a mob whose other draws are plain: spiders',
/// endermen's, phantoms', the creaking's and the copper golem's. The GPU path
/// poses them as [`super::skin::Skin`] `FLAT` draws when improved transparency
/// is off ([`super::skin::SkinModels::tagged`]).
pub fn eyes_layer(m: *Mob, layer: *Layer) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: layer.full_bright
    // rust: && layer.scroll == 0.0
    // rust: && matches!(
    // rust: m.species(),
    // rust: Species::Spider
    // rust: | Species::CaveSpider
    // rust: | Species::Enderman
    // rust: | Species::Phantom
    // rust: | Species::Creaking
    // rust: | Species::CopperGolem
    // rust: )
}

/// One draw of a model with a texture.
pub const Layer = struct {
    model: Cow<'static,
    texture: Cow<'static,
    color: u32,
    full_bright: bool,
    /// `RenderTypes.breezeWind`: the texture scrolls with the entity's age.
    scroll: f32,
};
/// DyeColor.getTextureDiffuseColor (RGB).
    // rust: pub const DYE: [u32; 16] = [
    // rust: 0xF9FFFE, 0xF9801D, 0xC74EBD, 0x3AB3DA, 0xFED83D, 0x80C71F, 0xF38BAA, 0x474F52, 0x9D9D97,
    // rust: 0x169C9C, 0x8932B8, 0x3C44AA, 0x835432, 0x5E7C16, 0xB02E26, 0x1D1D21,
    // rust: ];
    // rust: pub const DYE_NAMES: [&str; 16] = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];
/// ABGR vertex colour from an RGB value.
pub fn abgr(rgb: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (r, g, b) = ((rgb >> 16) & 255, (rgb >> 8) & 255, rgb & 255);
    // rust: 0xFF00_0000 | b << 16 | g << 8 | r
}

/// `EquipmentLayerRenderer.getColorForLayer`: a dyeable layer takes the
/// stack's dye colour (`minecraft:dyed_color`), the colour it has when
/// undyed otherwise; a layer that is not dyeable is not tinted.
pub fn armor_tint(undyed: ?u32, stack: ?*crate::items::ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(undyed) = undyed else {
    // rust: return 0xFFFF_FFFF;
}
    // rust: let dyed = stack
    // rust: .and_then(|s| s.extra.as_ref())
    // rust: .and_then(|e| e.dyed_color)
    // rust: .map(|d| d as u32)
    // rust: .unwrap_or(undyed);
    // rust: abgr(dyed)
}
/// ColorLerper.Type.SHEEP colour: white is 0xE6E6E6, others 75% of the dye.
pub fn sheep_wool_rgb(color: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if color == 0 {
    // rust: return 0xE6E6E6;
}
    // rust: let src = DYE[color as usize & 15];
    // rust: let f = |c: u32| ((c as f32 * 0.75).floor() as u32).min(255);
    // rust: f(src >> 16 & 255) << 16 | f(src >> 8 & 255) << 8 | f(src & 255)
}
/// `ColorLerper.getLerpedColor(ColorLerper.Type.SHEEP, ageInTicks)`: the 16
/// wool colours in DyeColor order, one per 25 ticks, lerped in between. The
/// colour a `jeb_` sheep's wool takes.
pub fn jeb_wool_rgb(age: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // ageInTicks is the tick count plus the partial tick: never negative.
    // rust: let i = age.floor();
    // rust: let ticks = i as u64;
    // rust: let j = ticks / 25;
    // rust: let f = ((ticks % 25) as f32 + (age - i)) / 25.0;
    // rust: let lo = sheep_wool_rgb((j % 16) as u8);
    // rust: let hi = sheep_wool_rgb(((j + 1) % 16) as u8);
    // rust: let mix = |shift: u32| {
    // rust: let (lo, hi) = ((lo >> shift & 255) as f32, (hi >> shift & 255) as f32);
    // rust: ((lo + (hi - lo) * f) as u32) << shift
}
    // rust: mix(16) | mix(8) | mix(0)
}
    // rust: pub const VILLAGER_TYPES: [&str; 7] = [
    // rust: "plains", "desert", "jungle", "savanna", "snow", "swamp", "taiga",
    // rust: ];
    // rust: pub const PROFESSIONS: [&str; 15] = [
    // rust: "none",
    // rust: "armorer",
    // rust: "butcher",
    // rust: "cartographer",
    // rust: "cleric",
    // rust: "farmer",
    // rust: "fisherman",
    // rust: "fletcher",
    // rust: "leatherworker",
    // rust: "librarian",
    // rust: "mason",
    // rust: "nitwit",
    // rust: "shepherd",
    // rust: "toolsmith",
    // rust: "weaponsmith",
    // rust: ];
    // rust: fn baby_or<'a>(
    // rust: m: &Mob,
    // rust: adult: impl Into<Cow<'a, str>>,
    // rust: baby: impl Into<Cow<'a, str>>,
    // rust: ) -> Cow<'a, str> {
    // rust: let baby = baby.into();
    // rust: if m.is_baby() && m.kind.layer(&baby).is_some() {
    // rust: baby
    // rust: } else {
    // rust: adult.into()
}
}
/// A name built from parts (`entity/villager/profession/farmer`), kept for the
/// process so that drawing a mob allocates no names each frame: they come from
/// a few tables (types, professions, levels, materials, variants). Past 4096
/// names on a thread (an unknown item's material from a server) a new one comes
/// back owned.
pub fn interned(args: std::fmt::Arguments) C {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::fmt::Write;
    // rust: thread_local! {
    // rust: static NAMES: std::cell::RefCell<(String, crate::fast_hash::FxHashSet<&'static str>)> =
    // rust: std::cell::RefCell::default();
}
    // rust: NAMES.with(|names| {
    // rust: let (buffer, set) = &mut *names.borrow_mut();
    // rust: buffer.clear();
    // rust: let _ = buffer.write_fmt(args);
    // rust: if let Some(name) = set.get(buffer.as_str()) {
    // rust: return Cow::Borrowed(*name);
}
    // rust: if set.len() >= 4096 {
    // rust: return Cow::Owned(buffer.clone());
}
    // rust: let name: &'static str = Box::leak(buffer.as_str().into());
    // rust: set.insert(name);
    // rust: Cow::Borrowed(name)
    // rust: })
}
pub fn climate(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.extra.variant {
    // rust: 1 => "warm",
    // rust: 2 => "cold",
    // rust: _ => "temperate",
}
}
/// `AvatarRenderer` entities: a mannequin draws exactly like a player —
/// the player model, its resolved skin and the same scale.
pub fn avatar(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(&*m.kind.id, "minecraft:player" | "minecraft:mannequin")
}
/// `AvatarRenderer.shouldRenderLayers`: a spectating player or mannequin
/// draws no layers at all (armour, held items, head item, cape, wings,
/// parrots, ears, stuck arrows), only its translucent head.
pub fn layers_shown(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !(avatar(m) && m.extra.spectator)
}
/// The model layer key and texture for the mob's body.
pub fn body(m: *Mob) ( {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: let baby = m.is_baby();
    // rust: let b = |s: &str| -> Cow<'static, str> {
    // rust: if baby {
    // rust: interned(format_args!("{s}_baby"))
    // rust: } else {
    // rust: interned(format_args!("{s}"))
}
}
    // rust: if avatar(m) {
        // AvatarRenderer: PlayerModel's slim layer for a slim skin.
    // rust: return (
    // rust: if m.slim { "player_slim#main" } else { "main" }.into(),
    // rust: m.skin.as_deref().unwrap_or(&m.kind.texture).into(),
    // rust: );
}
    // rust: match m.species() {
    // rust: S::Llama | S::TraderLlama => {
    // rust: let name = if m.species() == S::Llama {
    // rust: "llama"
    // rust: } else {
    // rust: "trader_llama"
}
    // rust: (
    // rust: baby_or(
    // rust: m,
    // rust: interned(format_args!("{name}#main")),
    // rust: interned(format_args!("{name}_baby#main")),
    // rust: ),
    // rust: super::llama::texture(m).into(),
    // rust: )
}
    // rust: s if super::equine::is_equine(s) => {
    // rust: let name = super::equine::model_name(s);
    // rust: (
    // rust: baby_or(
    // rust: m,
    // rust: interned(format_args!("{name}#main")),
    // rust: interned(format_args!("{name}_baby#main")),
    // rust: ),
    // rust: super::equine::texture(m).into(),
    // rust: )
}
    // rust: S::Wolf => (
    // rust: baby_or(m, "wolf#main", "wolf_baby#main"),
    // rust: super::tame::texture(m).into(),
    // rust: ),
    // rust: S::Panda => (
    // rust: baby_or(m, "panda#main", "panda_baby#main"),
    // rust: super::panda::texture(m).into(),
    // rust: ),
    // rust: S::HappyGhast => (
    // rust: baby_or(m, "happy_ghast#main", "happy_ghast_baby#main"),
    // rust: if baby {
    // rust: "entity/ghast/happy_ghast_baby".into()
    // rust: } else {
    // rust: "entity/ghast/happy_ghast".into()
    // rust: },
    // rust: ),
    // rust: S::Nautilus | S::ZombieNautilus => (
    // rust: super::nautilus::model(m).into(),
    // rust: super::nautilus::texture(m).into(),
    // rust: ),
    // rust: S::SulfurCube => {
    // rust: let (model, texture) = super::sulfur_cube::body(m);
    // rust: (model.into(), texture.into())
}
    // rust: S::Sniffer => (
    // rust: baby_or(m, "sniffer#main", "sniffer_baby#main"),
    // rust: if baby {
    // rust: "entity/sniffer/snifflet".into()
    // rust: } else {
    // rust: "entity/sniffer/sniffer".into()
    // rust: },
    // rust: ),
    // rust: S::Shulker => ("shulker#main".into(), super::shulker::texture(m).into()),
    // rust: S::Vex => ("vex#main".into(), super::vex::texture(m).into()),
    // rust: S::Wither => ("wither#main".into(), super::wither::texture(m).into()),
    // rust: S::Ghast => (
    // rust: "ghast#main".into(),
    // rust: if m.extra.flag {
    // rust: "entity/ghast/ghast_shooting".into()
    // rust: } else {
    // rust: "entity/ghast/ghast".into()
    // rust: },
    // rust: ),
    // rust: S::Cat => (
    // rust: baby_or(m, "cat#main", "cat_baby#main"),
    // rust: super::tame::cat_texture(m).into(),
    // rust: ),
    // rust: S::Frog => (
    // rust: "frog#main".into(),
    // rust: interned(format_args!("entity/frog/frog_{}", climate(m))),
    // rust: ),
        // RabbitRenderer.getTextureLocation: the Toast name tag, else the
        // variant (the killer bunny's id is 99).
    // rust: S::Rabbit => {
    // rust: let name = if m.custom_name.as_deref() == Some("Toast") {
    // rust: "toast"
    // rust: } else {
    // rust: match m.extra.variant {
    // rust: 1 => "white",
    // rust: 2 => "black",
    // rust: 3 => "white_splotched",
    // rust: 4 => "gold",
    // rust: 5 => "salt",
    // rust: 99 => "caerbannog",
    // rust: _ => "brown",
}
}
    // rust: (
    // rust: baby_or(m, "rabbit#main", "rabbit_baby#main"),
    // rust: b(&interned(format_args!("entity/rabbit/rabbit_{name}"))),
    // rust: )
}
        // ParrotRenderer.getVariantTexture.
    // rust: S::Parrot => {
    // rust: let name = ["red_blue", "blue", "green", "yellow_blue", "grey"]
    // rust: [usize::from(m.extra.variant).min(4)];
    // rust: (
    // rust: m.kind.model_name().into(),
    // rust: interned(format_args!("entity/parrot/parrot_{name}")),
    // rust: )
}
        // AxolotlRenderer.getTextureLocation.
    // rust: S::Axolotl => {
    // rust: let name =
    // rust: ["lucy", "wild", "gold", "cyan", "blue"][usize::from(m.extra.variant).min(4)];
    // rust: (
    // rust: baby_or(m, "axolotl#main", "axolotl_baby#main"),
    // rust: b(&interned(format_args!("entity/axolotl/axolotl_{name}"))),
    // rust: )
}
        // SalmonRenderer.submit: the model of the salmon's size.
    // rust: S::Salmon => {
    // rust: let model = match m.extra.variant {
    // rust: 0 => "salmon_small#main",
    // rust: 2 => "salmon_large#main",
    // rust: _ => "salmon#main",
}
    // rust: (model.into(), "entity/fish/salmon".into())
}
        // The baby models and textures of AgeableMobRenderer's other
        // subclasses.
    // rust: S::Goat => (
    // rust: baby_or(m, "goat#main", "goat_baby#main"),
    // rust: b(&m.kind.texture),
    // rust: ),
    // rust: S::PolarBear => (
    // rust: baby_or(m, "polar_bear#main", "polar_bear_baby#main"),
    // rust: b(&m.kind.texture),
    // rust: ),
    // rust: S::Ocelot => (
    // rust: baby_or(m, "ocelot#main", "ocelot_baby#main"),
    // rust: b(&m.kind.texture),
    // rust: ),
    // rust: S::Turtle => (
    // rust: baby_or(m, "turtle#main", "turtle_baby#main"),
    // rust: b(&m.kind.texture),
    // rust: ),
    // rust: S::Armadillo => (
    // rust: baby_or(m, "armadillo#main", "armadillo_baby#main"),
    // rust: b(&m.kind.texture),
    // rust: ),
        // FoxRenderer.getTextureLocation: snow variant, sleeping, baby.
    // rust: S::Fox => (
    // rust: baby_or(m, "fox#main", "fox_baby#main"),
    // rust: interned(format_args!(
    // rust: "entity/fox/fox{}{}{}",
    // rust: if m.extra.variant == 0 { "" } else { "_snow" },
    // rust: if super::fox::flag(m, super::fox::SLEEPING) {
    // rust: "_sleep"
    // rust: } else {
    // rust: ""
    // rust: },
    // rust: if baby { "_baby" } else { "" },
    // rust: )),
    // rust: ),
    // rust: S::Pig => {
    // rust: let model = if baby {
    // rust: "pig_baby#main".into()
    // rust: } else if m.extra.variant == 2 {
    // rust: "cold_pig#main".into()
    // rust: } else {
    // rust: "pig#main".into()
}
    // rust: (
    // rust: model,
    // rust: b(&interned(format_args!("entity/pig/pig_{}", climate(m)))),
    // rust: )
}
    // rust: S::Cow => {
    // rust: let model = match (m.extra.variant, baby) {
    // rust: (1, false) => "warm_cow#main",
    // rust: (1, true) => "warm_cow_baby#main",
    // rust: (2, false) => "cold_cow#main",
    // rust: (2, true) => "cold_cow_baby#main",
    // rust: (_, true) => "cow_baby#main",
    // rust: _ => "cow#main",
}
    // rust: (
    // rust: model.into(),
    // rust: b(&interned(format_args!("entity/cow/cow_{}", climate(m)))),
    // rust: )
}
    // rust: S::Mooshroom => (
    // rust: baby_or(m, "mooshroom#main", "mooshroom_baby#main"),
    // rust: b(if m.extra.variant == 1 {
    // rust: "entity/cow/mooshroom_brown"
    // rust: } else {
    // rust: "entity/cow/mooshroom_red"
    // rust: }),
    // rust: ),
    // rust: S::Chicken => {
    // rust: let model = if baby {
    // rust: "chicken_baby#main"
    // rust: } else if m.extra.variant == 2 {
    // rust: "cold_chicken#main"
    // rust: } else {
    // rust: "chicken#main"
}
    // rust: (
    // rust: model.into(),
    // rust: b(&interned(format_args!(
    // rust: "entity/chicken/chicken_{}",
    // rust: climate(m)
    // rust: ))),
    // rust: )
}
    // rust: S::Sheep => (
    // rust: baby_or(m, "sheep#main", "sheep_baby#main"),
    // rust: b("entity/sheep/sheep"),
    // rust: ),
    // rust: S::Zombie => (
    // rust: baby_or(m, "zombie#main", "zombie_baby#main"),
    // rust: b("entity/zombie/zombie"),
    // rust: ),
    // rust: S::Husk => (
    // rust: baby_or(m, "husk#main", "husk_baby#main"),
    // rust: b("entity/zombie/husk"),
    // rust: ),
    // rust: S::Drowned => (
    // rust: baby_or(m, "drowned#main", "drowned_baby#main"),
    // rust: b("entity/zombie/drowned"),
    // rust: ),
    // rust: S::ZombieVillager => (
    // rust: baby_or(m, "zombie_villager#main", "zombie_villager_baby#main"),
    // rust: b("entity/zombie_villager/zombie_villager"),
    // rust: ),
    // rust: S::Villager => (
    // rust: baby_or(m, "villager#main", "villager_baby#main"),
    // rust: b("entity/villager/villager"),
    // rust: ),
    // rust: S::Piglin => (
    // rust: baby_or(m, "piglin#main", "piglin_baby#main"),
    // rust: b("entity/piglin/piglin"),
    // rust: ),
    // rust: S::ZombifiedPiglin => (
    // rust: baby_or(m, "zombified_piglin#main", "zombified_piglin_baby#main"),
    // rust: b("entity/piglin/zombified_piglin"),
    // rust: ),
    // rust: S::Hoglin => (
    // rust: baby_or(m, "hoglin#main", "hoglin_baby#main"),
    // rust: b("entity/hoglin/hoglin"),
    // rust: ),
    // rust: S::Zoglin => (
    // rust: baby_or(m, "zoglin#main", "zoglin_baby#main"),
    // rust: b("entity/hoglin/zoglin"),
    // rust: ),
    // rust: S::Strider => (
    // rust: baby_or(m, "strider#main", "strider_baby#main"),
    // rust: b(if m.extra.flag {
    // rust: "entity/strider/strider_cold"
    // rust: } else {
    // rust: "entity/strider/strider"
    // rust: }),
    // rust: ),
        // BeeRenderer.getTextureLocation: angry, carrying nectar, or both.
    // rust: S::Bee => {
    // rust: let angry = super::bee::get(m).is_some_and(|b| b.anger_end > 0);
    // rust: let nectar = super::bee::has_nectar(m);
    // rust: let texture = match (angry, nectar) {
    // rust: (true, true) => "entity/bee/bee_angry_nectar",
    // rust: (true, false) => "entity/bee/bee_angry",
    // rust: (false, true) => "entity/bee/bee_nectar",
    // rust: (false, false) => "entity/bee/bee",
}
    // rust: let layer = baby_or(m, "bee#main", "bee_baby#main");
    // rust: let texture = if layer.starts_with("bee_baby") {
    // rust: b(texture)
    // rust: } else {
    // rust: texture.into()
}
    // rust: (layer, texture)
}
    // rust: S::Squid => (
    // rust: baby_or(m, "squid#main", "squid_baby#main"),
    // rust: b("entity/squid/squid"),
    // rust: ),
    // rust: S::GlowSquid => (
    // rust: baby_or(m, "glow_squid#main", "glow_squid_baby#main"),
    // rust: b("entity/squid/glow_squid"),
    // rust: ),
    // rust: S::Dolphin => (
    // rust: baby_or(m, "dolphin#main", "dolphin_baby#main"),
    // rust: b("entity/dolphin/dolphin"),
    // rust: ),
    // rust: S::Pufferfish => {
    // rust: let model = match m.extra.size {
    // rust: 0 => "pufferfish_small#main",
    // rust: 1 => "pufferfish_medium#main",
    // rust: _ => "pufferfish_big#main",
}
    // rust: (model.into(), "entity/fish/pufferfish".into())
}
    // rust: S::TropicalFish => {
    // rust: if m.extra.variant < 6 {
    // rust: (
    // rust: "tropical_fish_small#main".into(),
    // rust: "entity/fish/tropical_a".into(),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: "tropical_fish_large#main".into(),
    // rust: "entity/fish/tropical_b".into(),
    // rust: )
}
}
        // CopperGolemOxidationLevels: the texture of the weathering.
    // rust: S::CopperGolem => (
    // rust: m.kind.model_name().into(),
    // rust: super::copper_golem::texture(m).into(),
    // rust: ),
    // rust: _ => (m.kind.model_name().into(), m.kind.texture.as_str().into()),
}
}
/// LivingEntityRenderer.getModelTint (tropical fish base colour).
pub fn body_color(m: *Mob, alpha: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Wolf => super::tame::tint(m, alpha),
    // rust: Species::TropicalFish => abgr(DYE[m.extra.variant2 as usize & 15]),
        // LivingEntityRenderer.submit: a spectator is invisible
        // (Player.updateInvisibilityStatus) but not to another spectator or
        // itself, so its body is forced translucent (654311423, alpha 38).
    // rust: _ if avatar(m) && m.extra.spectator => 0x26FF_FFFF,
    // rust: _ => 0xFFFF_FFFF,
}
}
/// Extra render layers drawn over the body with the same pose. `age` is the
/// render state's `ageInTicks` (`Mob.age` plus the partial tick).
pub fn layers(m: *Mob, age: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: let mut v = Vec::new();
    // rust: if avatar(m) {
    // rust: return v;
}
    // rust: let white = 0xFFFF_FFFF;
    // rust: fn push(
    // rust: v: &mut Vec<Layer>,
    // rust: model: impl Into<Cow<'static, str>>,
    // rust: texture: impl Into<Cow<'static, str>>,
    // rust: color: u32,
    // rust: full_bright: bool,
    // rust: ) {
    // rust: v.push(Layer {
    // rust: model: model.into(),
    // rust: texture: texture.into(),
    // rust: color,
    // rust: full_bright,
    // rust: scroll: 0.0,
    // rust: })
}
    // rust: match m.species() {
        // WolfArmorLayer, then WolfCollarLayer.
    // rust: S::Wolf if m.extra.tame => {
    // rust: let (model, texture) = if m.is_baby() {
    // rust: ("wolf_baby#main", "entity/wolf/wolf_collar_baby")
    // rust: } else {
    // rust: ("wolf#main", "entity/wolf/wolf_collar")
}
            // The armor, then the cracks of its damage (`Crackiness.WOLF_ARMOR`).
    // rust: if !m.is_baby() && m.extra.body.as_deref() == Some("minecraft:wolf_armor") {
    // rust: let left = (super::WOLF_ARMOR_DURABILITY - m.extra.body_damage) as f32
    // rust: / super::WOLF_ARMOR_DURABILITY as f32;
    // rust: push(
    // rust: &mut v,
    // rust: "wolf_armor#main",
    // rust: "entity/equipment/wolf_body/armadillo_scute",
    // rust: white,
    // rust: false,
    // rust: );
    // rust: let crack = [(0.32, "high"), (0.69, "medium"), (0.95, "low")]
    // rust: .iter()
    // rust: .find(|(t, _)| left < *t);
    // rust: if let Some((_, level)) = crack {
    // rust: push(
    // rust: &mut v,
    // rust: "wolf_armor#main",
    // rust: interned(format_args!("entity/wolf/wolf_armor_crackiness_{level}")),
    // rust: white,
    // rust: false,
    // rust: );
}
}
    // rust: push(
    // rust: &mut v,
    // rust: model,
    // rust: texture,
    // rust: abgr(DYE[m.extra.color as usize & 15]),
    // rust: false,
    // rust: );
}
        // SimpleEquipmentLayer: the harness over the body.
    // rust: S::HappyGhast => {
    // rust: let harness = m
    // rust: .extra
    // rust: .body
    // rust: .as_deref()
    // rust: .and_then(super::happy_ghast::harness_texture);
    // rust: if !m.is_baby()
    // rust: && let Some(texture) = &harness
    // rust: {
    // rust: push(
    // rust: &mut v,
    // rust: "happy_ghast_harness#main",
    // rust: texture.clone(),
    // rust: white,
    // rust: false,
    // rust: );
}
            // RopesLayer: the ropes over a harnessed body while the ghast
            // holds a quad lead (`isLeashHolder`), the baby's model for a baby.
    // rust: if harness.is_some() && super::happy_ghast::is_leash_holder(m) {
    // rust: let model = if m.is_baby() {
    // rust: "happy_ghast_baby_ropes#main"
    // rust: } else {
    // rust: "happy_ghast_ropes#main"
}
    // rust: push(
    // rust: &mut v,
    // rust: model,
    // rust: "entity/ghast/happy_ghast_ropes",
    // rust: white,
    // rust: false,
    // rust: );
}
}
        // BreezeWindLayer and BreezeEyesLayer. The wind layer's texture
        // scrolls (`RenderTypes.breezeWind`): the offset is taken inside the
        // sprite, so the atlas does not have to wrap.
    // rust: S::Breeze => {
    // rust: v.push(Layer {
    // rust: model: "breeze#wind".into(),
    // rust: texture: "entity/breeze/breeze_wind".into(),
    // rust: color: white,
    // rust: full_bright: false,
    // rust: scroll: scroll_offset(age, BREEZE_WIND_SCROLL),
    // rust: });
    // rust: push(
    // rust: &mut v,
    // rust: "breeze#eyes",
    // rust: "entity/breeze/breeze_eyes",
    // rust: white,
    // rust: true,
    // rust: );
}
        // LlamaDecorLayer: the carpet, or the trader's blanket.
    // rust: S::Llama | S::TraderLlama => {
    // rust: if let Some((model, texture)) = super::llama::decor(m) {
    // rust: push(&mut v, model, texture, white, false);
}
}
        // HorseMarkingLayer, the saddle and the horse armour.
    // rust: s if super::equine::is_equine(s) => {
    // rust: let name = super::equine::model_name(s);
    // rust: let body = if m.is_baby() {
    // rust: interned(format_args!("{name}_baby#main"))
    // rust: } else {
    // rust: interned(format_args!("{name}#main"))
}
    // rust: if let Some(tex) = super::equine::markings(m) {
    // rust: push(&mut v, body, tex, white, false);
}
    // rust: if m.extra.saddled && !m.is_baby() {
    // rust: push(
    // rust: &mut v,
    // rust: interned(format_args!("{name}#saddle")),
    // rust: super::equine::saddle_texture(s),
    // rust: white,
    // rust: false,
    // rust: );
}
    // rust: if let Some(armor) = m.extra.body.as_deref()
    // rust: && let Some(material) = armor
    // rust: .strip_prefix("minecraft:")
    // rust: .and_then(|a| a.strip_suffix("_horse_armor"))
    // rust: {
    // rust: let tex = interned(format_args!("entity/equipment/horse_body/{material}"));
    // rust: let color = if material == "leather" {
    // rust: abgr(0xA06540)
    // rust: } else {
    // rust: white
}
                // UndeadHorseRenderer bakes its own armour layer.
    // rust: let layer = if matches!(s, S::ZombieHorse | S::SkeletonHorse) {
    // rust: "undead_horse_armor#main"
    // rust: } else {
    // rust: "horse_armor#main"
}
    // rust: push(&mut v, layer, tex, color, false);
}
}
        // SimpleEquipmentLayer: pig and strider saddles.
    // rust: S::Pig if m.extra.saddled && !m.is_baby() => push(
    // rust: &mut v,
    // rust: "pig#saddle",
    // rust: "entity/equipment/pig_saddle/saddle",
    // rust: white,
    // rust: false,
    // rust: ),
    // rust: S::Strider if m.extra.saddled && !m.is_baby() => push(
    // rust: &mut v,
    // rust: "strider#saddle",
    // rust: "entity/equipment/strider_saddle/saddle",
    // rust: white,
    // rust: false,
    // rust: ),
        // CatCollarLayer.
    // rust: S::Cat if m.extra.tame => {
    // rust: let (model, texture) = if m.is_baby() {
    // rust: ("cat_baby#collar", "entity/cat/cat_collar_baby")
    // rust: } else {
    // rust: ("cat#collar", "entity/cat/cat_collar")
}
    // rust: push(
    // rust: &mut v,
    // rust: model,
    // rust: texture,
    // rust: abgr(DYE[m.extra.color as usize & 15]),
    // rust: false,
    // rust: );
}
        // IronGolemCrackinessLayer.
    // rust: S::IronGolem => {
    // rust: if let Some(texture) = super::golem::crackiness(m) {
    // rust: push(&mut v, "iron_golem#main", texture, white, false);
}
}
        // NautilusRenderer: the armour and saddle SimpleEquipmentLayers.
    // rust: S::Nautilus | S::ZombieNautilus if !m.is_baby() => {
    // rust: if let Some(texture) = m
    // rust: .extra
    // rust: .body
    // rust: .as_deref()
    // rust: .and_then(super::nautilus::armor_texture)
    // rust: {
    // rust: push(&mut v, "nautilus_armor#main", texture, white, false);
}
    // rust: if m.extra.saddled {
    // rust: push(
    // rust: &mut v,
    // rust: "nautilus#saddle",
    // rust: "entity/equipment/nautilus_saddle/saddle",
    // rust: white,
    // rust: false,
    // rust: );
}
}
        // SulfurCubeInnerLayer.
    // rust: S::SulfurCube => {
    // rust: if let Some((model, texture)) = super::sulfur_cube::inner(m) {
    // rust: push(&mut v, model, texture, white, false);
}
}
        // SlimeOuterLayer: the translucent outer cube.
    // rust: S::Slime => push(&mut v, "slime#outer", "entity/slime/slime", white, false),
        // SheepWoolUndercoatLayer has no isSheared guard: a sheared dyed sheep
        // keeps it, while only SheepWoolLayer stops.
    // rust: S::Sheep => {
            // MobRenderer.checkMagicName(entity, "jeb_"): an exact custom name.
    // rust: let jeb = m.custom_name.as_deref() == Some("jeb_");
    // rust: let color = abgr(if jeb {
    // rust: jeb_wool_rgb(age)
    // rust: } else {
    // rust: sheep_wool_rgb(m.extra.color)
    // rust: });
    // rust: if !m.is_baby() && (jeb || m.extra.color != 0) {
    // rust: push(
    // rust: &mut v,
    // rust: "sheep#wool_undercoat",
    // rust: "entity/sheep/sheep_wool_undercoat",
    // rust: color,
    // rust: false,
    // rust: );
}
            // SheepWoolLayer: none once sheared.
    // rust: if !m.extra.sheared {
    // rust: let (model, texture) = if m.is_baby() {
    // rust: ("sheep_baby#wool", "entity/sheep/sheep_wool_baby")
    // rust: } else {
    // rust: ("sheep#wool", "entity/sheep/sheep_wool")
}
    // rust: push(&mut v, model, texture, color, false);
}
}
    // rust: S::Creaking if super::creaking::eyes_glowing(m) => push(
    // rust: &mut v,
    // rust: "creaking#eyes",
    // rust: "entity/creaking/creaking_eyes",
    // rust: white,
    // rust: true,
    // rust: ),
        // The copper golem's eyes glow: CopperGolemRenderer's
        // LivingEntityEmissiveLayer (eyes render type) draws on a model baked
        // from ModelLayers.COPPER_GOLEM, the body's, not COPPER_GOLEM_EYES.
    // rust: S::CopperGolem => {
    // rust: let eyes = super::copper_golem::eye_texture(m);
    // rust: push(&mut v, m.kind.model_name(), eyes, white, true);
}
    // rust: S::Spider | S::CaveSpider => push(
    // rust: &mut v,
    // rust: m.kind.model_name(),
    // rust: "entity/spider/spider_eyes",
    // rust: white,
    // rust: true,
    // rust: ),
    // rust: S::Enderman => push(
    // rust: &mut v,
    // rust: "enderman#main",
    // rust: "entity/enderman/enderman_eyes",
    // rust: white,
    // rust: true,
    // rust: ),
    // rust: S::Phantom => push(
    // rust: &mut v,
    // rust: "phantom#main",
    // rust: "entity/phantom/phantom_eyes",
    // rust: white,
    // rust: true,
    // rust: ),
    // rust: S::Drowned => {
    // rust: if m.is_baby() {
    // rust: push(
    // rust: &mut v,
    // rust: "drowned_baby#outer",
    // rust: "entity/zombie/drowned_outer_layer_baby",
    // rust: white,
    // rust: false,
    // rust: );
    // rust: } else {
    // rust: push(
    // rust: &mut v,
    // rust: "drowned#outer",
    // rust: "entity/zombie/drowned_outer_layer",
    // rust: white,
    // rust: false,
    // rust: );
}
}
    // rust: S::Stray => push(
    // rust: &mut v,
    // rust: "stray#outer",
    // rust: "entity/skeleton/stray_overlay",
    // rust: white,
    // rust: false,
    // rust: ),
    // rust: S::Bogged if !m.extra.sheared => push(
    // rust: &mut v,
    // rust: "bogged#outer",
    // rust: "entity/skeleton/bogged_overlay",
    // rust: white,
    // rust: false,
    // rust: ),
    // rust: S::TropicalFish => {
            // TropicalFishPatternLayer: the pattern tinted with the pattern colour.
    // rust: let (model, letter, n) = if m.extra.variant < 6 {
    // rust: ("tropical_fish_small#pattern", "a", m.extra.variant + 1)
    // rust: } else {
    // rust: ("tropical_fish_large#pattern", "b", m.extra.variant - 5)
}
    // rust: push(
    // rust: &mut v,
    // rust: model,
    // rust: interned(format_args!("entity/fish/tropical_{letter}_pattern_{n}")),
    // rust: abgr(DYE[m.extra.variant3 as usize & 15]),
    // rust: false,
    // rust: );
}
    // rust: S::Villager | S::ZombieVillager => {
    // rust: let base = if m.species() == S::Villager {
    // rust: "villager"
    // rust: } else {
    // rust: "zombie_villager"
}
    // rust: let model = if m.is_baby() {
    // rust: interned(format_args!("{base}_baby#main"))
    // rust: } else {
    // rust: interned(format_args!("{base}#main"))
}
    // rust: let t = VILLAGER_TYPES[m.extra.variant as usize % VILLAGER_TYPES.len()];
    // rust: let folder = if m.species() == S::Villager {
    // rust: "entity/villager"
    // rust: } else {
    // rust: "entity/zombie_villager"
}
            // VillagerProfessionLayer: a baby's type texture is in `baby/`.
    // rust: let group = if m.is_baby() { "baby" } else { "type" };
    // rust: push(
    // rust: &mut v,
    // rust: model.clone(),
    // rust: interned(format_args!("{folder}/{group}/{t}")),
    // rust: white,
    // rust: false,
    // rust: );
    // rust: let prof = PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()];
    // rust: if !m.is_baby() && prof != "none" {
    // rust: push(
    // rust: &mut v,
    // rust: model.clone(),
    // rust: interned(format_args!("{folder}/profession/{prof}")),
    // rust: white,
    // rust: false,
    // rust: );
    // rust: if prof != "nitwit" {
                    // `LEVEL_LOCATIONS` clamps the level to 1..=5.
    // rust: let level = ["stone", "iron", "gold", "emerald", "diamond"]
    // rust: [(m.extra.variant3.max(1) as usize - 1).min(4)];
    // rust: push(
    // rust: &mut v,
    // rust: model,
    // rust: interned(format_args!("{folder}/profession_level/{level}")),
    // rust: white,
    // rust: false,
    // rust: );
}
}
}
    // rust: _ => {}
}
    // rust: humanoid_armor(m, &mut v);
    // rust: v
}
/// `HumanoidArmorLayer.renderArmorPiece`: a baby wears the `humanoid_baby`
/// layer type for every slot (leggings included), an adult the leggings layer
/// for its legs and the `humanoid` one otherwise.
pub fn humanoid_layer_folder(baby: bool, layer: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if baby {
    // rust: "humanoid_baby"
    // rust: } else if layer == "leggings" {
    // rust: "humanoid_leggings"
    // rust: } else {
    // rust: "humanoid"
}
}
/// `HumanoidArmorLayer`: the armour models of the mob's main model with the
/// equipment textures (leather tinted, with its overlay).
pub fn humanoid_armor(m: *Mob, v: *mut std.ArrayList(Layer)) void {
}
    // A player's or mannequin's armour is drawn by the game's armour layers.
    // rust: if super::equine::is_equine(m.species()) || avatar(m) {
    // rust: return;
}
    // rust: let e = &m.extra;
    // rust: if e.head.is_none() && e.chest.is_none() && e.legs.is_none() && e.feet.is_none() {
    // rust: return;
}
    // rust: let (model, _) = body(m);
    // rust: let Some(base) = model.strip_suffix("#main") else {
    // rust: return;
}
    // rust: let slots = [
    // rust: (&m.extra.head, &m.extra.armor[0], "helmet"),
    // rust: (&m.extra.chest, &m.extra.armor[1], "chestplate"),
    // rust: (&m.extra.legs, &m.extra.armor[2], "leggings"),
    // rust: (&m.extra.feet, &m.extra.armor[3], "boots"),
    // rust: ];
    // rust: for (item, stack, layer) in slots {
    // rust: let Some(name) = item.as_deref().and_then(|i| i.strip_prefix("minecraft:")) else {
    // rust: continue;
}
    // rust: let Some(material) = name.strip_suffix(layer).and_then(|n| n.strip_suffix('_')) else {
    // rust: continue;
}
    // rust: let asset = match material {
    // rust: "golden" => "gold",
    // rust: "turtle" => "turtle_scute",
    // rust: other => other,
}
    // rust: let folder = humanoid_layer_folder(m.is_baby(), layer);
    // rust: let model = interned(format_args!("{base}#{layer}"));
        // EquipmentLayerRenderer.getColorForLayer: the leather layer takes
        // the stack's dye colour, the colour it has when undyed otherwise.
    // rust: let tint = if asset == "leather" {
    // rust: armor_tint(Some(0xA06540), stack.as_ref())
    // rust: } else {
    // rust: 0xFFFF_FFFF
}
    // rust: v.push(Layer {
    // rust: model: model.clone(),
    // rust: texture: interned(format_args!("entity/equipment/{folder}/{asset}")),
    // rust: color: tint,
    // rust: full_bright: false,
    // rust: scroll: 0.0,
    // rust: });
    // rust: if asset == "leather" {
    // rust: v.push(Layer {
    // rust: model,
    // rust: texture: interned(format_args!("entity/equipment/{folder}/leather_overlay")),
    // rust: color: 0xFFFF_FFFF,
    // rust: full_bright: false,
    // rust: scroll: 0.0,
    // rust: });
}
}
}
    // rust: impl super::MobType {
    /// The main model layer key without the namespace.
pub fn model_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.model_name().to_owned()
}
    /// `model_key` without the copy.
pub fn model_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::species::def(self.species).model
}
}
/// The mob's root transform (LivingEntityRenderer.submit + setupRotations).
pub fn base_transform(m: *Mob, alpha: f32, camera: glam::DVec3) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let a = f64::from(alpha);
    // rust: let p = glam::DVec3::new(
    // rust: m.previous.x + (m.position.x - m.previous.x) * a,
    // rust: m.previous.y + (m.position.y - m.previous.y) * a,
    // rust: m.previous.z + (m.position.z - m.previous.z) * a,
    // rust: ) - camera
    // rust: + enderman_render_offset(m, alpha)
    // rust: + super::shulker::render_offset(m, alpha);
    // rust: base_transform_at(m, alpha, glam::Mat4::from_translation(p.as_vec3()))
}
/// `EndermanRenderer.getRenderOffset`: a creepy (angry) enderman is moved by
/// a gaussian 0.02 blocks sideways in x and z every frame. Vanilla draws from
/// the renderer's own random; this one is seeded by the mob and the frame's
/// age, so the body, its carried block and its eyes agree within a frame.
pub fn enderman_render_offset(m: *Mob, alpha: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_core::random::{LegacyRandom, RandomSource};
    // rust: if m.species() != Species::Enderman || !m.extra.flag {
    // rust: return glam::DVec3::ZERO;
}
    // rust: let frame = (m.age as f32 + alpha).to_bits();
    // rust: let mut random = LegacyRandom::new((i64::from(m.id) << 32) ^ i64::from(frame));
    // `0.02 * state.scale`.
    // rust: let d = 0.02 * f64::from(m.model_scale());
    // rust: let x = random.next_gaussian() * d;
    // rust: let z = random.next_gaussian() * d;
    // rust: glam::DVec3::new(x, 0.0, z)
}
/// `base_transform` from a pose of the entity's origin (`EntityRenderDispatcher.submit`
/// under a pose stack, as `SpawnerRenderer` draws the mob inside a spawner).
pub fn base_transform_at(m: *Mob, alpha: f32, origin: glam::Mat4) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut body = m.previous_body_yaw + wrap(m.body_yaw - m.previous_body_yaw) * alpha;
    // rust: if shaking(m) {
        // LivingEntityRenderer.setupRotations: a rapid wobble.
    // rust: let ticks = (m.age as f32 + alpha).floor();
    // rust: body += (f64::from(ticks * 3.25).cos() * std::f64::consts::PI * 0.4) as f32;
}
    // A sleeping villager, or another player lying in their bed.
    // rust: let sleep = (m.species() == Species::Villager || avatar(m))
    // rust: .then(|| super::villager::sleep_pose(m))
    // rust: .flatten();
    // `LivingEntityRenderer.submit` moves a sleeper toward the pillow before
    // it scales the model, so the bed offset is not scaled and the pose after
    // it is. Keep the two apart.
    // rust: let (sleep_offset, rotation) = match sleep {
    // rust: Some((angle, step)) => {
            // The eye height of the standing pose (LivingEntityRenderer
            // extracts `getEyeHeight(Pose.STANDING)` for a bed).
    // rust: let eye = if avatar(m) {
                // `getEyeHeight(Pose.STANDING)` on an avatar is the standing
                // box's eye height, `minecraft:scale` included.
    // rust: m.kind.eye_height as f32 * m.model_scale()
    // rust: } else {
    // rust: m.awake_dims().2 as f32
}
    // rust: let head = eye - 0.1;
    // rust: (
    // rust: glam::Mat4::from_translation(glam::Vec3::new(
    // rust: -step[0] * head,
    // rust: 0.0,
    // rust: -step[1] * head,
    // rust: )),
                // setupRotations for Pose.SLEEPING.
    // rust: glam::Mat4::from_rotation_y(angle.to_radians())
    // rust: * glam::Mat4::from_rotation_z(90.0_f32.to_radians())
    // rust: * glam::Mat4::from_rotation_y(270.0_f32.to_radians()),
    // rust: )
}
    // rust: None => (
    // rust: glam::Mat4::IDENTITY,
    // rust: super::aquatic::rotations(m, alpha, body)
    // rust: .unwrap_or_else(|| glam::Mat4::from_rotation_y((180.0 - body).to_radians())),
    // rust: ),
}
    // `LivingEntityRenderer.submit`: `poseStack.scale(state.scale, ...)` for
    // every living entity, after the sleeping offset and before
    // setupRotations, so a pose translation scales with the model but the bed
    // it lies in does not.
    // rust: let mut base = origin
    // rust: * sleep_offset
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(m.model_scale()))
    // rust: * pufferfish_bob(m, alpha)
    // rust: * rotation;
    // rust: if m.death_time > 0 && !super::creaking::tearing_down(m) {
    // rust: let f = ((m.death_time as f32 + alpha - 1.0) / 20.0 * 1.6)
    // rust: .sqrt()
    // rust: .min(1.0);
    // rust: base *= glam::Mat4::from_rotation_z(f * flip_degrees(m).to_radians());
    // rust: } else if m.extra.auto_spin_attack {
        // Riptide: lying along the look direction, spinning 75 degrees a tick.
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: base *= glam::Mat4::from_rotation_x((-90.0 - pitch).to_radians())
    // rust: * glam::Mat4::from_rotation_y(((m.age as f32 + alpha) * -75.0).to_radians());
    // rust: } else if matches!(m.custom_name.as_deref(), Some("Dinnerbone" | "Grumm")) {
        // isEntityUpsideDown
    // rust: base *= glam::Mat4::from_translation(glam::Vec3::new(0.0, m.height() + 0.1, 0.0))
    // rust: * glam::Mat4::from_rotation_z(PI);
}
    // IronGolemRenderer.setupRotations, after LivingEntityRenderer's: the body
    // tilts side to side while it walks.
    // rust: if m.species() == Species::IronGolem {
    // rust: let s = anim::state(m, alpha);
    // rust: if s.speed >= 0.01 {
    // rust: let wp = s.pos + 6.0;
    // rust: let triangle_wave = ((wp % 13.0 - 6.5).abs() - 3.25) / 3.25;
    // rust: base *= glam::Mat4::from_rotation_z((6.5 * triangle_wave).to_radians());
}
}
    // AvatarRenderer.setupRotations, after LivingEntityRenderer's.
    // rust: if m.extra.fall_flying {
    // rust: let ticks = m.extra.fall_fly_ticks as f32 + alpha;
    // rust: let scale = (ticks * ticks / 100.0).min(1.0);
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: if !m.extra.auto_spin_attack {
    // rust: base *= glam::Mat4::from_rotation_x((scale * (-90.0 - pitch)).to_radians());
}
    // rust: let yaw = m.previous_head_yaw + wrap(m.head_yaw - m.previous_head_yaw) * alpha;
    // rust: let (look_x, look_z) = (-(yaw.to_radians()).msin(), (yaw.to_radians()).mcos());
    // rust: let v = m.extra.previous_velocity.lerp(m.velocity, f64::from(alpha));
    // rust: let view_scale = (pitch.to_radians()).mcos();
    // rust: let (look_x, look_z) = (look_x * view_scale, look_z * view_scale);
    // rust: let view_length = f64::from(look_x * look_x + look_z * look_z);
    // rust: let speed = v.x * v.x + v.z * v.z;
    // rust: if speed > f64::from(1.0e-5f32) && view_length > f64::from(1.0e-5f32) {
    // rust: let dot =
    // rust: (v.x * f64::from(look_x) + v.z * f64::from(look_z)) / (speed * view_length).sqrt();
    // rust: let sign = (v.x * f64::from(look_z) - v.z * f64::from(look_x)).signum();
    // rust: base *= glam::Mat4::from_rotation_y(
    // rust: (sign * horizon_core::jmath::acos(dot.abs().min(1.0))) as f32,
    // rust: );
}
    // rust: } else if m.species() == Species::Drowned {
        // DrownedRenderer.setupRotations: tip toward the look pitch about
        // the middle of the box while swimming.
    // rust: let amount = m.extra.swim.amount(alpha);
    // rust: if amount > 0.0 {
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: let middle = glam::Vec3::new(0.0, m.height() / 2.0, 0.0);
    // rust: base *= glam::Mat4::from_translation(middle)
    // rust: * glam::Mat4::from_rotation_x((amount * (-10.0 - pitch)).to_radians())
    // rust: * glam::Mat4::from_translation(-middle);
}
    // rust: } else if m.extra.swim.amount(alpha) > 0.0 {
        // AvatarRenderer.setupRotations: tip forward with the swim amount,
        // following the pitch in water, then lie along the swimming box.
    // rust: let amount = m.extra.swim.amount(alpha);
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: let target = if m.extra.swim.in_water {
    // rust: -90.0 - pitch
    // rust: } else {
    // rust: -90.0
}
    // rust: base *= glam::Mat4::from_rotation_x((amount * target).to_radians());
    // rust: if m.extra.swim.visually {
    // rust: base *= glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.0, 0.3));
}
}
    // rust: base *= species_rotations(m, alpha);
    // rust: base *= glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0));
    // rust: base *= species_scale(m, alpha);
    // rust: base * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.501, 0.0))
}
/// `PufferfishRenderer.setupRotations`: `translate(0, cos(ageInTicks * 0.05) * 0.08, 0)`
/// before the usual rotations, so a pufferfish bobs up and down.
pub fn pufferfish_bob(m: *Mob, alpha: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.species() != Species::Pufferfish {
    // rust: return glam::Mat4::IDENTITY;
}
    // rust: glam::Mat4::from_translation(glam::Vec3::new(
    // rust: 0.0,
    // rust: pufferfish_bob_y(m.age as f32 + alpha),
    // rust: 0.0,
    // rust: ))
}
pub fn pufferfish_bob_y(age_in_ticks: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (age_in_ticks * 0.05).mcos() * 0.08
}
/// `LivingEntityRenderer.isShaking`: a fully frozen mob (the skeleton's own
/// `isShaking` is its stray conversion only), converting zombies, piglins
/// and hoglins, a zombie villager being cured and a cold strider.
pub fn shaking(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.is_fully_frozen() && m.species() != Species::Skeleton {
    // rust: return true;
}
    // rust: match m.species() {
    // rust: Species::Strider => super::strider::suffocating(m),
    // rust: Species::ZombieVillager => super::zombie_villager::is_converting(m),
    // rust: Species::Zombie | Species::Husk | Species::Skeleton => m.extra.counter2 > 0,
    // rust: Species::Piglin | Species::PiglinBrute | Species::Hoglin => {
    // rust: !m.extra.flag2 && m.extra.counter2 > 0
}
    // rust: _ => false,
}
}
pub fn flip_degrees(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Spider | Species::CaveSpider | Species::Silverfish | Species::Endermite => 180.0,
    // rust: _ => 90.0,
}
}
pub fn species_rotations(m: *Mob, alpha: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Cat => super::tame::cat_rotations(m, alpha),
    // rust: Species::Panda => super::panda::rotations(m, alpha),
    // rust: Species::Shulker => super::shulker::rotations(m),
        // FoxRenderer.setupRotations: the body follows a pounce's pitch.
    // rust: Species::Fox if super::fox::flag(m, super::fox::POUNCING | super::fox::FACEPLANTED) => {
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: glam::Mat4::from_rotation_x((-pitch).to_radians())
}
        // PhantomRenderer.setupRotations: the body follows its pitch.
    // rust: Species::Phantom => {
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: glam::Mat4::from_rotation_x(pitch.to_radians())
}
    // rust: _ => glam::Mat4::IDENTITY,
}
}
/// Creeper.getSwelling: the fuse's progress, past 1 in its last two ticks.
pub fn creeper_swelling(m: *Mob, alpha: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (m.previous_swell as f32 + alpha * (m.swell - m.previous_swell) as f32)
    // rust: / (m.max_swell - 2) as f32
}
/// LivingEntityRenderer.getOverlayCoords for the body: the hurt red, or a
/// swelling creeper's white flash. Layers take the red only (progress 0).
pub fn body_overlay(m: *Mob, alpha: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let white = if m.species() == Species::Creeper {
    // rust: crate::overlay::creeper_progress(creeper_swelling(m, alpha))
    // rust: } else {
    // rust: 0.0
}
    // rust: crate::overlay::living(white, red_overlay(m))
}
/// LivingEntityRenderState.hasRedOverlay: hurt or dying (not a creaking
/// tearing down).
pub fn red_overlay(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.hurt_time > 0 || (m.death_time > 0 && !super::creaking::tearing_down(m))
}
pub fn species_scale(m: *Mob, alpha: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if avatar(m) {
        // AvatarRenderer.scale, shared by the inventory and world renderer.
        // The entity's own `scale` is `LivingEntityRenderer.submit`'s, applied
        // by `base_transform_at` before setupRotations.
    // rust: return glam::Mat4::from_scale(glam::Vec3::splat(0.9375));
}
    // rust: match m.species() {
    // rust: Species::Wither => {
    // rust: glam::Mat4::from_scale(glam::Vec3::splat(super::wither::scale(m, alpha)))
}
    // rust: Species::Creeper => {
            // CreeperRenderer.scale: swelling with a wobble.
    // rust: let g = creeper_swelling(m, alpha);
    // rust: let wobble = 1.0 + (g * 100.0).msin() * g * 0.01;
    // rust: let s = g.clamp(0.0, 1.0);
    // rust: let s4 = s * s * s * s;
    // rust: let xz = (1.0 + s4 * 0.4) * wobble;
    // rust: let y = (1.0 + s4 * 0.1) / wobble;
    // rust: glam::Mat4::from_scale(glam::Vec3::new(xz, y, xz))
}
    // rust: Species::Slime | Species::MagmaCube => super::cube::scale(m, alpha),
    // rust: Species::SulfurCube => super::sulfur_cube::scale(m, alpha),
    // rust: Species::Phantom => {
            // PhantomRenderer.scale: 15% bigger per size, and the model moved
            // down to the box (it is modelled 1.3125 blocks above the feet).
    // rust: let s = 1.0 + 0.15 * m.extra.size as f32;
    // rust: glam::Mat4::from_scale(glam::Vec3::splat(s))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 1.3125, 0.1875))
}
    // rust: _ => glam::Mat4::IDENTITY,
}
}
/// Draw a part tree with a pose map, texture rect, colour and light.
    // rust: pub fn draw(
    // rust: part: &Part,
    // rust: base: glam::Mat4,
    // rust: poses: &Poses,
    // rust: uv: [f32; 4],
    // rust: color: u32,
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: draw_scrolled(part, base, poses, uv, 0.0, color, light, overlay, out);
}
/// `draw` for a texture that scrolls: the vertex's U is moved by the offset
/// and wraps inside the texture, as the texture matrix of
/// `RenderTypes.breezeWind` does.
    // rust: pub fn draw_scrolled(
    // rust: part: &Part,
    // rust: base: glam::Mat4,
    // rust: poses: &Poses,
    // rust: uv: [f32; 4],
    // rust: scroll: f32,
    // rust: color: u32,
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: draw_normals(
    // rust: part,
    // rust: base,
    // rust: ModelNormals::new(base),
    // rust: poses,
    // rust: uv,
    // rust: scroll,
    // rust: color,
    // rust: light,
    // rust: overlay,
    // rust: out,
    // rust: );
}
    // rust: fn draw_normals(
    // rust: part: &Part,
    // rust: base: glam::Mat4,
    // rust: normals: ModelNormals,
    // rust: poses: &Poses,
    // rust: uv: [f32; 4],
    // rust: scroll: f32,
    // rust: color: u32,
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let p = poses.pose(part);
    // rust: let m = posed(base, p);
    // rust: if poses.is_hidden(part) || p[6] == 0.0 && p[7] == 0.0 && p[8] == 0.0 {
    // rust: return;
}
    // rust: let normals = normals.part(p);
    // `skips` is a name lookup: ask once per part, not once per polygon. A part
    // hidden this way still draws its children, so only the polygons are gated.
    // rust: if !poses.skips(part) {
    // rust: for poly in &part.polygons {
    // rust: let normal = poly.vertex_normal(normals);
    // rust: for v in poly.vertices {
    // rust: let pos = m.transform_point3(glam::Vec3::new(v[0], v[1], v[2]) / 16.0);
                // The armour glint scrolls the layer's model UV in the shader;
                // the item path already passed its transformed UV.
    // rust: let glint_uv = if overlay == ARMOR_GLINT {
    // rust: [v[3], v[4]]
    // rust: } else {
    // rust: [0.0, 0.0]
}
    // rust: out.push(Vertex {
    // rust: normal,
    // rust: pos: pos.to_array(),
    // rust: uv: [
    // rust: uv[0] + (uv[2] - uv[0]) * scroll_u(v[3], scroll),
    // rust: uv[1] + (uv[3] - uv[1]) * v[4],
    // rust: ],
    // rust: layer: overlay,
    // rust: color,
    // rust: light,
    // rust: glint_uv,
    // rust: });
}
}
}
    // rust: for c in &part.children {
    // rust: draw_normals(c, m, normals, poses, uv, scroll, color, light, overlay, out);
}
}
/// A part's matrix under `base` for its pose (`ModelPart.translateAndRotate`
/// and its scale), as `draw` and the GPU path (`super::skin`) both use it.
    // rust: pub(super) fn posed(base: glam::Mat4, p: [f32; 9]) -> glam::Mat4 {
    // rust: base * glam::Mat4::from_translation(glam::Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * glam::Mat4::from_quat(glam::Quat::from_euler(
    // rust: glam::EulerRot::ZYX,
    // rust: p[5],
    // rust: p[4],
    // rust: p[3],
    // rust: ))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(p[6], p[7], p[8]))
}
/// `draw_scrolled` through the GPU path when the mob takes it (`skin`), on
/// the CPU otherwise.
    // rust: pub fn put(
    // rust: skin: &mut Option<&mut super::skin::Skin>,
    // rust: part: &std::sync::Arc<Part>,
    // rust: base: glam::Mat4,
    // rust: poses: &Poses,
    // rust: uv: [f32; 4],
    // rust: scroll: f32,
    // rust: color: u32,
    // rust: light: u32,
    // rust: overlay: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let paint = super::skin::Paint {
    // rust: uv,
    // rust: scroll,
    // rust: color,
    // rust: light,
    // rust: overlay,
}
    // rust: if let Some(skin) = skin
    // rust: && skin.draw(part, base, poses, paint)
    // rust: {
    // rust: return;
}
    // rust: draw_scrolled(part, base, poses, uv, scroll, color, light, overlay, out);
}
/// Render a mob with its variant model, texture and layers.
    // rust: pub fn render(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: render_with(m, alpha, camera, atlas, light, data, &[], out);
}
/// `render` plus extra layers posed like the body (`HumanoidArmorLayer`:
/// the armour model's parts copy the body's): (model, texture rect, colour,
/// overlay: 0 or `ARMOR_GLINT`, as `EquipmentLayerRenderer` never tints them).
    // rust: pub fn render_with(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: extra: &[(&Part, [f32; 4], u32, u32, bool)],
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // The invisibility effect hides the model (a drinking wandering trader);
    // an illusioner shows its four mirror images instead.
    // rust: if super::trader::is_invisible(m) {
    // rust: if m.species() == Species::Illusioner {
    // rust: let age = m.age as f32 + alpha;
    // rust: for (i, off) in super::illusioner::offsets(m, alpha).iter().enumerate() {
    // rust: let w = super::illusioner::wobble(i, age);
    // rust: let shifted =
    // rust: camera - glam::DVec3::new(off[0] + w[0], off[1] + w[1], off[2] + w[2]);
    // rust: let base = base_transform(m, alpha, shifted);
    // rust: render_visible(m, alpha, base, atlas, light, data, extra, true, out, None);
}
}
    // rust: return;
}
    // rust: render_visible(
    // rust: m,
    // rust: alpha,
    // rust: base_transform(m, alpha, camera),
    // rust: atlas,
    // rust: light,
    // rust: data,
    // rust: extra,
    // rust: true,
    // rust: out,
    // rust: None,
    // rust: );
}
/// `render` with the model's ordinary draws posed on the GPU when the mob
/// allows it (`super::skin`): the same picture, no vertices on the CPU.
    // rust: pub fn render_skinned(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: out: &mut Vec<Vertex>,
    // rust: skin: &mut super::skin::Skin,
    // rust: ) {
    // rust: if super::trader::is_invisible(m) {
    // rust: render_with(m, alpha, camera, atlas, light, data, &[], out);
    // rust: return;
}
    // rust: render_visible(
    // rust: m,
    // rust: alpha,
    // rust: base_transform(m, alpha, camera),
    // rust: atlas,
    // rust: light,
    // rust: data,
    // rust: &[],
    // rust: true,
    // rust: out,
    // rust: Some(skin),
    // rust: );
}
/// `CapeLayer.submit` with `PlayerCapeModel`: the player model's body posed
/// as the player's, its cape turned by `ModelPart.rotateBy` with the cape's
/// flap and leans. `base` is the player's root transform (moved out over a
/// chestplate); `uv` the cape texture.
    // rust: pub fn cape(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: base: glam::Mat4,
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(model) = m.kind.layer("player#cape") else {
    // rust: return;
}
    // rust: let s = anim::state(m, alpha);
    // rust: let mut poses = Poses::new(model);
    // rust: anim::setup(m, &s, &mut poses, &data.animations);
    // rust: let a = f64::from(alpha);
    // rust: let at = [
    // rust: m.previous.x + (m.position.x - m.previous.x) * a,
    // rust: m.previous.y + (m.position.y - m.previous.y) * a,
    // rust: m.previous.z + (m.position.z - m.previous.z) * a,
    // rust: ];
    // rust: let body = m.previous_body_yaw + wrap(m.body_yaw - m.previous_body_yaw) * alpha;
    // LivingEntityRenderState.fallFlyingScale.
    // rust: let ticks = m.extra.fall_fly_ticks as f32 + alpha;
    // rust: let gliding = (ticks * ticks / 100.0).clamp(0.0, 1.0);
    // rust: let [flap, lean, lean2] = m.extra.avatar.cape(alpha, at, body, gliding);
    // rust: let pose = poses.get("cape");
    // rust: let by = glam::Quat::from_rotation_y(-PI)
    // rust: * glam::Quat::from_rotation_x((6.0 + lean / 2.0 + flap).to_radians())
    // rust: * glam::Quat::from_rotation_z((lean2 / 2.0).to_radians())
    // rust: * glam::Quat::from_rotation_y((180.0 - lean2 / 2.0).to_radians());
    // rust: let now = glam::Quat::from_euler(glam::EulerRot::ZYX, pose[5], pose[4], pose[3]);
    // rust: let (z, y, x) = (now * by).to_euler(glam::EulerRot::ZYX);
    // rust: (pose[3], pose[4], pose[5]) = (x, y, z);
    // RenderTypes.entitySolid with OverlayTexture.NO_OVERLAY.
    // rust: draw(model, base, &poses, uv, 0xFFFF_FFFF, light, 0, out);
}
/// `Deadmau5EarsLayer.submit` with `PlayerEarsModel`: the player model's
/// head carrying two 6x6x1 ears (the model's other cubes are cleared),
/// drawn with the player's skin as `RenderTypes.entitySolid`. The caller has
/// checked `showExtraEars`; an invisible avatar draws no ears.
    // rust: pub fn ears(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: base: glam::Mat4,
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if super::trader::is_invisible(m) {
    // rust: return;
}
    // rust: let Some(model) = m.kind.layer("player#ears") else {
    // rust: return;
}
    // rust: let s = anim::state(m, alpha);
    // rust: let mut poses = Poses::new(model);
    // rust: anim::setup(m, &s, &mut poses, &data.animations);
    // LivingEntityRenderer.getOverlayCoords(state, 0.0F).
    // rust: draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: light,
    // rust: body_overlay(m, alpha),
    // rust: out,
    // rust: );
}
/// `PlayerModel.bodyParts`: what `getRandomBodyPart` picks from.
    // rust: const BODY_PARTS: [&str; 6] = [
    // rust: "head",
    // rust: "body",
    // rust: "left_arm",
    // rust: "right_arm",
    // rust: "left_leg",
    // rust: "right_leg",
    // rust: ];

/// The cubes of a part as `ModelPart.cubes` has them: min and max corners in
/// model units. The part keeps six faces per cube, in cube order.
pub fn cube_bounds(part: *Part) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = if part.polygons.len().is_multiple_of(6) {
    // rust: 6
    // rust: } else {
    // rust: part.polygons.len().max(1)
}
    // rust: part.polygons
    // rust: .chunks(size)
    // rust: .map(|faces| {
    // rust: let mut b = [f32::MAX, f32::MAX, f32::MAX, f32::MIN, f32::MIN, f32::MIN];
    // rust: for v in faces.iter().flat_map(|f| f.vertices) {
    // rust: for k in 0..3 {
    // rust: b[k] = b[k].min(v[k]);
    // rust: b[3 + k] = b[3 + k].max(v[k]);
}
}
    // rust: b
    // rust: })
    // rust: .collect()
}

/// `StuckInBodyLayer.snapToFace`.
pub fn snap_to_face(value: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value > 0.5 { 1.0 } else { 0.5 }
}

/// `StuckInBodyLayer.submit` (with `submitStuckItem`) for a player: `count`
/// copies of `item` (`ArrowLayer`'s arrow model, `BeeStingerLayer`'s stinger)
/// stuck in random cubes of the posed body, placed from a random source
/// seeded by the entity id `id`. `on_surface` is `PlacementStyle.ON_SURFACE`.
    // rust: pub fn stuck_in_body(
    // rust: m: &Mob,
    // rust: id: i32,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: data: &MobData,
    // rust: count: i32,
    // rust: on_surface: bool,
    // rust: item: &Part,
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
//     use horizon_core::random::{LegacyRandom, RandomSource};
    // rust: if count <= 0 {
    // rust: return;
}
    // rust: let base = base_transform(m, alpha, camera);
    // rust: let s = anim::state(m, alpha);
    // rust: let (model_key, _) = body(m);
    // rust: let model = m
    // rust: .kind
    // rust: .layer(&model_key)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| m.kind.model.clone());
    // rust: let mut poses = Poses::new(&model);
    // rust: anim::setup(m, &s, &mut poses, &data.animations);
    // rust: let mut random = LegacyRandom::new(i64::from(id));
    // rust: for _ in 0..count {
    // rust: let name = BODY_PARTS[random.next_int_bound(BODY_PARTS.len() as i32).unwrap_or(0) as usize];
    // rust: let Some(part) = find_part(&model, name) else {
    // rust: return;
}
    // rust: let cubes = cube_bounds(part);
    // rust: let Ok(index) = random.next_int_bound(cubes.len() as i32) else {
    // rust: return;
}
    // rust: let cube = cubes[index as usize];
    // rust: let Some(mut t) = part_matrix(&model, base, &poses, name, 0.0) else {
    // rust: return;
}
    // rust: let mut mid = [
    // rust: random.next_float(),
    // rust: random.next_float(),
    // rust: random.next_float(),
    // rust: ];
    // rust: if on_surface {
    // rust: let plane = random.next_int_bound(3).unwrap_or(0) as usize;
    // rust: if plane < 3 {
    // rust: mid[plane] = snap_to_face(mid[plane]);
}
}
    // rust: let lerp = |k: usize| cube[k] + mid[k] * (cube[3 + k] - cube[k]);
    // rust: t *= glam::Mat4::from_translation(glam::Vec3::new(lerp(0), lerp(1), lerp(2)) / 16.0);
    // rust: let (dx, dy, dz) = (
    // rust: -(mid[0] * 2.0 - 1.0),
    // rust: -(mid[1] * 2.0 - 1.0),
    // rust: -(mid[2] * 2.0 - 1.0),
    // rust: );
    // rust: let dxz = f64::from(dx * dx + dz * dz).sqrt() as f32;
    // rust: let degrees = |y: f32, x: f32| {
    // rust: (horizon_core::jmath::atan2(f64::from(y), f64::from(x)) * 180.0
    // rust: / f64::from(std::f32::consts::PI)) as f32
}
    // rust: let y_rot = degrees(dx, dz);
    // rust: let x_rot = degrees(dy, dxz);
    // rust: t *= glam::Mat4::from_rotation_y((y_rot - 90.0).to_radians())
    // rust: * glam::Mat4::from_rotation_z(x_rot.to_radians());
    // rust: super::render_model(item, t, &|p| p.pose, uv, light, 0, out);
}
}
/// `ParrotOnShoulderLayer.submitOnShoulder`: a parrot of `variant` on the
/// avatar's left or right shoulder, in `ParrotModel.Pose.ON_SHOULDER` with
/// the avatar's walk animation, age and head turn. `base` is the avatar's
/// root transform; `parrot` the parrot's entity type (its model).
    // rust: pub fn shoulder_parrot(
    // rust: avatar: &Mob,
    // rust: parrot: &super::MobType,
    // rust: variant: i32,
    // rust: left: bool,
    // rust: alpha: f32,
    // rust: base: glam::Mat4,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(uv) = atlas(&shoulder_parrot_texture(variant)) else {
    // rust: return;
}
    // rust: let model = parrot.layer(&parrot.model_key()).unwrap_or(&parrot.model);
    // rust: let s = anim::State {
    // rust: baby: false,
    // rust: ..anim::state(avatar, alpha)
}
    // rust: let mut poses = Poses::new(model);
    // ParrotRenderState.flapAngle stays 0.
    // rust: super::body_anim::parrot(
    // rust: &mut poses,
    // rust: &s,
    // rust: super::body_anim::ParrotPose::OnShoulder,
    // rust: 0.0,
    // rust: );
    // rust: let y = if avatar.extra.crouching { -1.3 } else { -1.5 };
    // rust: let x = if left { 0.4 } else { -0.4 };
    // rust: let base = base * glam::Mat4::from_translation(glam::Vec3::new(x, y, 0.0));
    // ParrotModel's cutout render type with OverlayTexture.NO_OVERLAY.
    // rust: draw(model, base, &poses, uv, 0xFFFF_FFFF, light, 0, out);
}
/// `ParrotRenderer.getVariantTexture` for `Parrot.Variant.byId` (an id out
/// of range is clamped).
pub fn shoulder_parrot_texture(variant: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
pub const NAMES: [[]const u8; 5] = ["red_blue", "blue", "green", "yellow_blue", "grey"];
    // rust: let name = usize::try_from(variant)
    // rust: .ok()
    // rust: .and_then(|i| NAMES.get(i))
    // rust: .unwrap_or(if variant < 0 { &NAMES[0] } else { &NAMES[4] });
    // rust: format!("entity/parrot/parrot_{name}")
}
/// `render_with` without the body, for an avatar the viewer can't see:
/// `LivingEntityRenderer.submit` gets no render type for an invisible body
/// (`isBodyVisible`, `isInvisibleTo`), but its layers still draw
/// (`HumanoidArmorLayer`: the armour in `extra`).
    // rust: pub fn render_layers(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: extra: &[(&Part, [f32; 4], u32, u32, bool)],
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let base = base_transform(m, alpha, camera);
    // rust: render_visible(m, alpha, base, atlas, light, data, extra, false, out, None);
}
/// A mob drawn under `origin` instead of at its position (the spinning mob
/// of `SpawnerRenderer.submitEntityInSpawner`).
    // rust: pub fn render_posed(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: origin: glam::Mat4,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let base = base_transform_at(m, alpha, origin);
    // rust: render_visible(m, alpha, base, atlas, light, data, &[], true, out, None);
}
/// The custom model's key of a body model: `main` is the wide player model, `kind.model`.
pub fn cem_key(model_key: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if model_key == "main" {
    // rust: "player#main"
    // rust: } else {
    // rust: model_key
}
}
/// Every texture [`render_visible`] may look up for `m` now (keep the two in step: a texture
/// drawn but not listed here never gets a random pick): the body's and each layer's, a
/// custom model's own texture beside them (`cem_texture` falls back to the vanilla one when
/// the atlas lacks it, and only the layer a `.jem` was made for takes it, `paints_with_jem`),
/// and the warden's glowing layers (whether they glow this frame or not). Random textures
/// choose a variant for each.
pub fn drawn_textures(m: *Mob, data: *MobData) V {
    // Implementation ported from Horizon
    return undefined;
}
pub fn push(names: *mut std.ArrayList([]const u8), custom: ?*super::cem::CemLayer, vanilla: []const u8) void {
}
    // rust: if let Some(texture) = custom.and_then(|c| c.texture.clone()) {
    // rust: names.push(texture);
}
    // rust: names.push(vanilla);
}
    // rust: let cem = data
    // rust: .cem
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let (model_key, texture) = body(m);
    // rust: let cem_key = cem_key(&model_key);
    // rust: let mut names = Vec::new();
    // rust: push(&mut names, cem.layer(cem_key), texture.into_owned());
    // rust: let mut all_layers = layers(m, m.age as f32);
    // rust: if m.species() == Species::Warden {
    // rust: for (model, texture, _) in super::warden::emissive_layers(m, 0.0) {
    // rust: all_layers.push(Layer {
    // rust: model: model.into(),
    // rust: texture: texture.into(),
    // rust: color: 0,
    // rust: full_bright: true,
    // rust: scroll: 0.0,
    // rust: });
}
}
    // rust: let body_keys = [&*model_key, cem_key];
    // rust: for (i, layer) in all_layers.iter().enumerate() {
    // rust: let custom = cem
    // rust: .layer(&layer.model)
    // rust: .filter(|_| paints_with_jem(&all_layers, i, body_keys));
    // rust: push(&mut names, custom, layer.texture.to_string());
}
    // rust: names
}
/// The texture a model drawn as `custom` takes: the `.jem`'s when the atlas has it, else
/// `vanilla` (a texture the atlas lacks would hide the model).
    // rust: fn cem_texture<'a>(
    // rust: custom: Option<&'a super::cem::CemLayer>,
    // rust: vanilla: &'a str,
    // rust: atlas: Atlas<'_>,
    // rust: ) -> &'a str {
    // rust: custom
    // rust: .and_then(|c| c.texture.as_deref())
    // rust: .filter(|t| atlas(t).is_some())
    // rust: .unwrap_or(vanilla)
}
/// Whether `layers[i]` is the layer its model's `.jem` was made for, so the `.jem`'s texture
/// paints it: the first drawn with that model (`sheep#wool`, a wolf's armour). Later layers
/// on the same model are overlays (the armour's cracks), like those on the body's model
/// (`body`: eyes, collars, a villager's type and profession), and keep their own textures
/// over the new geometry.
pub fn paints_with_jem(layers: *[Layer], i: usize, body: [[]const u8; 2]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = &*layers[i].model;
    // rust: !body.contains(&key) && layers[..i].iter().all(|l| l.model != key)
}
/// The model a mob's body draws with — the packs' custom one when it has one — posed the way
/// the body draws it (the vanilla animation, then the pack's own), with the `attachments`
/// anchors its bones declare. Everything that anchors to a mob — an item in its hand, a
/// block on its head — walks the same tree the player saw.
    // rust: fn posed_body(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: data: &MobData,
    // rust: ) -> (std::sync::Arc<Part>, Poses, Vec<(String, String, [f32; 3])>) {
    // rust: let s = anim::state(m, alpha);
    // rust: let (model_key, _) = body(m);
    // rust: let cem = data
    // rust: .cem
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let custom = cem.layer(cem_key(&model_key));
    // rust: let model = match custom {
    // rust: Some(c) => c.model.clone(),
    // rust: None => m
    // rust: .kind
    // rust: .layer(&model_key)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| m.kind.model.clone()),
}
    // rust: let mut poses = Poses::new(&model);
    // rust: anim::setup(m, &s, &mut poses, &data.animations);
    // rust: if let Some(c) = custom
    // rust: && let Some(animation) = &c.animation
    // rust: {
    // rust: animation.run(m, &s, &mut poses);
}
    // rust: let anchors = custom.map_or(Vec::new(), |c| c.anchors.clone());
    // rust: (model, poses, anchors)
}
    // rust: fn render_visible(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: base: glam::Mat4,
    // rust: atlas: Atlas,
    // rust: light: u32,
    // rust: data: &MobData,
    // rust: extra: &[(&Part, [f32; 4], u32, u32, bool)],
    // rust: body_visible: bool,
    // rust: out: &mut Vec<Vertex>,
    // rust: skin: Option<&mut super::skin::Skin>,
    // rust: ) {
    // The armour is a layer: none for a spectator.
    // rust: let extra = if layers_shown(m) { extra } else { &[] };
    // rust: let overlay = u32::from(red_overlay(m));
    // rust: let s = anim::state(m, alpha);
    // rust: let (model_key, texture) = body(m);
    // The packs' custom entity models replace a layer's parts and maybe its texture. The read
    // guard, not a clone of the Arc: one uncontended lock per mob, nothing else without a pack.
    // rust: let cem = data
    // rust: .cem
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let cem_key = cem_key(&model_key);
    // rust: let custom_body = cem.layer(cem_key);
    // rust: let body_animation = custom_body.and_then(|c| c.animation.as_ref());
    // rust: let model = match custom_body {
    // rust: Some(custom) => custom.model.clone(),
        // 3D skin layers: the player's own outer layer, one slab per painted
        // texel (`mobs::skin_layers`), in place of the flat inflated box.
    // rust: None => m
    // rust: .skin_3d
    // rust: .clone()
    // rust: .or_else(|| m.kind.layer(&model_key).cloned())
    // rust: .unwrap_or_else(|| m.kind.model.clone()),
}
    // rust: let texture = cem_texture(custom_body, &texture, atlas);
    // OptiFine random textures and ETF blinking: the sprite a texture draws with instead, when
    // the atlas has it: the variant the mob wears, then its blink frame while it blinks (or
    // sleeps). The texture keeps its name for everything else.
    // rust: let random = data
    // rust: .random_textures
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let blinks = data
    // rust: .blinks
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let sprite = |texture: &str| {
    // rust: let variant = (!random.is_empty())
    // rust: .then(|| super::random_textures::texture(m, &random, texture))
    // rust: .flatten()
    // rust: .filter(|v| atlas(v).is_some());
    // rust: let frame = (!blinks.is_empty())
    // rust: .then(|| blinks.get(variant.unwrap_or(texture)))
    // rust: .flatten()
    // rust: .and_then(|b| {
    // rust: if super::villager::sleeping(m) {
    // rust: Some(b.shut.as_str())
    // rust: } else {
    // rust: b.frame(s.age as u32, m.id.wrapping_mul(0x9E37_79B1))
}
    // rust: })
    // rust: .filter(|f| atlas(f).is_some());
    // rust: let name = frame.or(variant)?;
    // rust: Some((name, atlas(name)?))
}
    // OptiFine emissive overlays: the drawn sprite's `_e`, at full brightness with the model's
    // shading, as OptiFine draws them.
    // rust: let emissive = data
    // rust: .emissive
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let emissive_uv = |drawn: &str| {
    // rust: if emissive.is_empty() {
    // rust: return None;
}
    // rust: atlas(emissive.overlay(drawn)?)
}
    // rust: let mut poses = Poses::pooled();
    // rust: poses.reset(&model);
    // rust: anim::setup(m, &s, &mut poses, &data.animations);
    // rust: if let Some(animation) = body_animation {
    // rust: animation.run(m, &s, &mut poses);
}
    // rust: let mut all_layers = layers(m, s.age);
    // WardenRenderer: the translucent emissive layers fade with the animations.
    // rust: if m.species() == Species::Warden {
    // rust: for (model, texture, a) in super::warden::emissive_layers(m, alpha) {
    // rust: if a > 0.0 {
    // rust: all_layers.push(Layer {
    // rust: model: model.into(),
    // rust: texture: texture.into(),
    // rust: color: ((a.clamp(0.0, 1.0) * 255.0) as u32) << 24 | 0x00FF_FFFF,
    // rust: full_bright: true,
    // rust: scroll: 0.0,
    // rust: });
}
}
}
    // The GPU path takes the whole mob or none of it, so its draws keep their
    // order: only plain draws of models it can pose (no custom models,
    // translucent body or energy swirl, which the CPU path changes after
    // drawing), and with improved transparency off the tagged layers too.
    // rust: let mut skin = skin;
    // rust: let posable = match skin.as_deref_mut() {
    // rust: Some(skin) => {
    // rust: custom_body.is_none()
    // rust: && extra.is_empty()
    // rust: && m.species() != Species::SulfurCube
    // rust: && !translucent_body(m)
    // rust: && energy_swirl(m, s.age).is_none()
    // rust: && skin.supports(&model)
    // rust: && all_layers.iter().all(|layer| {
                    // With improved transparency off, a translucent layer's tag
                    // is the only difference from a plain draw.
    // rust: (skin.models.tagged && (eyes_layer(m, layer) || !layer.full_bright)
    // rust: || !layer.full_bright && !translucent_layer(m, layer))
    // rust: && cem.layer(&layer.model).is_none()
    // rust: && m.kind
    // rust: .layer(&layer.model)
    // rust: .is_none_or(|part| skin.supports(part))
    // rust: })
}
    // rust: None => false,
}
    // rust: if !posable {
    // rust: skin = None;
}
    // rust: let draw_body = |out: &mut Vec<Vertex>, skin: &mut Option<&mut super::skin::Skin>| {
        // A player or mannequin whose skin has no atlas sprite (an evicted or
        // never stored download) draws with its default skin, not invisibly.
    // rust: let drawn = sprite(texture).or_else(|| Some((texture, atlas(texture)?)));
    // rust: let uv = drawn.map(|(_, uv)| uv).or_else(|| {
    // rust: if avatar(m) {
    // rust: atlas(&m.kind.texture)
    // rust: } else {
    // rust: None
}
    // rust: });
    // rust: if body_visible && let Some(uv) = uv {
    // rust: let start = out.len();
    // rust: put(
    // rust: skin,
    // rust: &model,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0.0,
    // rust: body_color(m, alpha),
    // rust: light,
    // rust: body_overlay(m, alpha),
    // rust: out,
    // rust: );
    // rust: if let Some(glow) = drawn.and_then(|(name, _)| emissive_uv(name)) {
    // rust: put(
    // rust: skin,
    // rust: &model,
    // rust: base,
    // rust: &poses,
    // rust: glow,
    // rust: 0.0,
    // rust: body_color(m, alpha),
    // rust: FULL_BRIGHT,
    // rust: 0,
    // rust: out,
    // rust: );
}
    // rust: if translucent_body(m) {
    // rust: mark_oit(&mut out[start..]);
}
}
}
    // The translucent shell writes depth: draw the opaque core before it.
    // rust: let shell_last = m.species() == Species::SulfurCube;
    // rust: if !shell_last {
    // rust: draw_body(out, &mut skin);
}
    // The worn armour's layers (and their emissive overlays, full bright).
    // rust: for (part, uv, color, layer_overlay, glows) in extra {
    // rust: let light = if *glows { FULL_BRIGHT } else { light };
    // rust: draw(part, base, &poses, *uv, *color, light, *layer_overlay, out);
}
    // One Poses refilled for every layer (armour draws up to seven): it keeps
    // its maps' capacity.
    // rust: let mut layer_poses = Poses::pooled();
    // rust: let body_keys = [&*model_key, cem_key];
    // rust: for (i, layer) in all_layers.iter().enumerate() {
    // rust: let custom = cem.layer(&layer.model);
        // `layer.texture` stays the vanilla name (the villager hats below look for its
        // `/type/` folder).
    // rust: let texture = cem_texture(
    // rust: custom.filter(|_| paints_with_jem(&all_layers, i, body_keys)),
    // rust: &layer.texture,
    // rust: atlas,
    // rust: );
    // rust: let part = match custom {
    // rust: Some(custom) => custom.model.clone(),
    // rust: None => match m.kind.layer(&layer.model) {
    // rust: Some(part) => part.clone(),
    // rust: None => continue,
    // rust: },
}
    // rust: let Some((drawn, uv)) = sprite(texture).or_else(|| Some((texture, atlas(texture)?))) else {
    // rust: continue;
}
    // rust: if custom.is_none() && custom_body.is_none() && std::sync::Arc::ptr_eq(&part, &model) {
            // A layer over the body's own model (a villager's type, profession
            // and level, a spider's eyes): `setupAnim` gives the body's poses.
    // rust: layer_poses.copy_from(&poses);
    // rust: } else {
    // rust: layer_poses.reset(&part);
    // rust: anim::setup(m, &s, &mut layer_poses, &data.animations);
    // rust: if let Some(animation) = custom.and_then(|c| c.animation.as_ref()) {
    // rust: animation.run(m, &s, &mut layer_poses);
}
}
    // rust: if matches!(m.species(), Species::Villager | Species::ZombieVillager)
    // rust: && let Some((folder, variant)) = layer
    // rust: .texture
    // rust: .split_once("/type/")
    // rust: .or_else(|| layer.texture.split_once("/baby/"))
    // rust: {
    // rust: let profession = PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()];
    // rust: data.villager_hats
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .apply(folder, variant, profession, &mut layer_poses);
}
    // rust: let light = if layer.full_bright {
    // rust: FULL_BRIGHT
    // rust: } else {
    // rust: light
}
        // EquipmentLayerRenderer draws armour with OverlayTexture.NO_OVERLAY: never
        // the hurt tint, the armour glint (`ARMOR_GLINT`) when enchanted.
    // rust: let overlay = match armor_slot(&layer.model) {
    // rust: Some(slot) if super::gear::enchanted(m, slot) => ARMOR_GLINT,
    // rust: Some(_) => 0,
    // rust: None => overlay,
}
    // rust: let start = out.len();
    // rust: let first_job = skin.as_deref().map(|skin| skin.frame.jobs.len());
    // rust: put(
    // rust: &mut skin,
    // rust: &part,
    // rust: base,
    // rust: &layer_poses,
    // rust: uv,
    // rust: layer.scroll,
    // rust: layer.color,
    // rust: light,
    // rust: overlay,
    // rust: out,
    // rust: );
    // rust: if let Some(glow) = emissive_uv(drawn) {
    // rust: put(
    // rust: &mut skin,
    // rust: &part,
    // rust: base,
    // rust: &layer_poses,
    // rust: glow,
    // rust: layer.scroll,
    // rust: layer.color,
    // rust: FULL_BRIGHT,
    // rust: 0,
    // rust: out,
    // rust: );
}
    // rust: if translucent_layer(m, layer) {
    // rust: mark_oit(&mut out[start..]);
}
        // The same marks on what the GPU path posed of the layer (only eyes
        // layers get there among the marked ones): the tags in the overlay word,
        // no normal.
    // rust: if let (Some(skin), Some(first)) = (skin.as_deref_mut(), first_job) {
    // rust: let tagged = translucent_layer(m, layer);
    // rust: let eyes = layer.full_bright && m.species() != Species::Warden;
    // rust: for job in &mut skin.frame.jobs[first..] {
    // rust: if tagged {
    // rust: job.overlay |= crate::gfx::OIT_ENTITY;
}
    // rust: if eyes {
    // rust: job.overlay |= u32::from(EYES_TIER) << 16;
    // rust: job.mode = crate::gfx::entity_skin::SkinJob::FLAT;
}
}
}
        // The eyes render type's glowing eyes also shine in HDR output, at
        // `EYES_TIER` in the overlay's high bits (entity.wgsl fs_hdr_mark).
    // rust: if layer.full_bright && m.species() != Species::Warden {
    // rust: for vertex in &mut out[start..] {
    // rust: vertex.normal = [0; 4];
    // rust: vertex.layer |= u32::from(EYES_TIER) << 16;
}
}
        // The warden's heart and spots shine too, by how far their layers have faded in.
    // rust: if layer.full_bright && m.species() == Species::Warden {
    // rust: for vertex in &mut out[start..] {
    // rust: vertex.layer |= u32::from(EYES_TIER) << 16;
}
}
}
    // EnergySwirlLayer: the armour model, additive, scrolling over the sprite.
    // rust: if let Some((model, texture, x_offset)) = energy_swirl(m, s.age)
    // rust: && let Some(part) = m.kind.layer(model)
    // rust: && let Some([u0, v0, u1, v1]) = atlas(texture)
    // rust: {
    // rust: layer_poses.reset(part);
    // rust: anim::setup(m, &s, &mut layer_poses, &data.animations);
        // `RenderTypes.energySwirl`'s texture offset, as the sprite-local UV.
    // rust: let (du, dv) = (x_offset % 1.0, s.age * 0.01 % 1.0);
    // rust: let start = out.len();
    // rust: draw(
    // rust: part,
    // rust: base,
    // rust: &layer_poses,
    // rust: [du, dv, 1.0 + du, 1.0 + dv],
    // rust: crate::breaking::stage_light([u1 - u0, v1 - v0]),
    // rust: crate::breaking::stage_light([u0, v0]),
    // rust: crate::gfx::ENERGY_SWIRL_OVERLAY,
    // rust: out,
    // rust: );
        // No lighting: the colour bytes carry the sprite's size (fs_energy_swirl).
    // rust: for vertex in &mut out[start..] {
    // rust: vertex.normal = [0; 4];
}
}
    // rust: if shell_last {
    // rust: draw_body(out, &mut skin);
}
}
/// `EnergySwirlLayer`'s model, texture and `xOffset(t)` for a charged creeper
/// (`CreeperPowerLayer`) or a powered wither (`WitherArmorLayer`); `t` is `ageInTicks`.
pub fn energy_swirl(m: *Mob, t: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.species() {
    // rust: Species::Creeper if m.extra.charged => {
    // rust: Some(("creeper#armor", "entity/creeper/creeper_armor", t * 0.01))
}
    // rust: Species::Wither if super::wither::powered(m) => Some((
    // rust: "wither#armor",
    // rust: "entity/wither/wither_armor",
    // rust: (t * 0.02).mcos() * 3.0,
    // rust: )),
    // rust: _ => None,
}
}
/// The equipment slot of a `HumanoidArmorLayer` model (`zombie#helmet`).
pub fn armor_slot(model: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match model.rsplit('#').next()? {
    // rust: "helmet" => super::gear::HEAD,
    // rust: "chestplate" => super::gear::CHEST,
    // rust: "leggings" => super::gear::LEGS,
    // rust: "boots" => super::gear::FEET,
    // rust: _ => return None,
    // rust: })
}
/// Render with a fixed texture rect (the earlier API).
    // rust: pub fn render_single(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let base = base_transform(m, alpha, camera);
    // rust: let overlay = body_overlay(m, alpha);
    // rust: let s = anim::state(m, alpha);
    // rust: let model = m.kind.model.clone();
    // rust: let mut poses = Poses::new(&model);
    // rust: anim::setup(m, &s, &mut poses, &std::collections::HashMap::new());
    // rust: draw(&model, base, &poses, uv, 0xFFFF_FFFF, light, overlay, out);
}

/// The transform of a named part (ModelPart.translateAndRotate down the tree).
    // rust: pub fn part_matrix(
    // rust: part: &Part,
    // rust: parent: glam::Mat4,
    // rust: poses: &Poses,
    // rust: name: &str,
    // rust: x_offset: f32,
    // rust: ) -> Option<glam::Mat4> {
    // rust: let mut p = poses.pose(part);
    // rust: if part.name == name {
    // rust: p[0] += x_offset;
}
    // rust: let m = parent
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * glam::Mat4::from_quat(glam::Quat::from_euler(
    // rust: glam::EulerRot::ZYX,
    // rust: p[5],
    // rust: p[4],
    // rust: p[3],
    // rust: ))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(p[6], p[7], p[8]));
    // rust: if part.name == name {
    // rust: return Some(m);
}
    // rust: part.children
    // rust: .iter()
    // rust: .find_map(|c| part_matrix(c, m, poses, name, x_offset))
}
/// The first part named `name`, depth first.
    // rust: pub(super) fn find_part<'a>(part: &'a Part, name: &str) -> Option<&'a Part> {
    // rust: if part.name == name {
    // rust: return Some(part);
}
    // rust: part.children.iter().find_map(|c| find_part(c, name))
}
/// The matrix up to a part that declares an item anchor (`attachments` in the pack's file,
/// EMF's `EMFAttachment`): the walk the positioner takes — every part on the way applies its
/// pose, like `part_matrix` — then the anchor's own offset, in model pixels.
    // rust: fn attachment_matrix(
    // rust: part: &Part,
    // rust: parent: glam::Mat4,
    // rust: poses: &Poses,
    // rust: anchors: &[(String, String, [f32; 3])],
    // rust: key: &str,
    // rust: ) -> Option<glam::Mat4> {
    // rust: let p = poses.pose(part);
    // rust: let m = parent
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * glam::Mat4::from_quat(glam::Quat::from_euler(
    // rust: glam::EulerRot::ZYX,
    // rust: p[5],
    // rust: p[4],
    // rust: p[3],
    // rust: ))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(p[6], p[7], p[8]));
    // rust: if let Some((_, _, [x, y, z])) = anchors
    // rust: .iter()
    // rust: .find(|(bone, kind, _)| *kind == key && part.name == *bone)
    // rust: {
    // rust: return Some(m * glam::Mat4::from_translation(glam::Vec3::new(*x, *y, *z) / 16.0));
}
    // rust: part.children
    // rust: .iter()
    // rust: .find_map(|c| attachment_matrix(c, m, poses, anchors, key))
}
/// `AllayModel.translateToHand`: the root and body, then the right arm's
/// pitch, a 0.7 scale and a shift. Both hands use the right arm's pitch.
pub fn allay_hand(model: *Part, base: glam::Mat4, poses: *Poses) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body = part_matrix(model, base, poses, "body", 0.0)?;
    // rust: let x_rot = poses.pose(find_part(model, "right_arm")?)[3];
    // rust: Some(
    // rust: body * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.0625, 0.1875))
    // rust: * glam::Mat4::from_rotation_x(x_rot)
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(0.7))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0625, 0.0, 0.0)),
    // rust: )
}
/// The hand of a mob in model space, up to the item's own transform
/// (`ItemInHandLayer.submitArmWithItem`).
    // rust: fn hand_base(
    // rust: m: &Mob,
    // rust: model: &Part,
    // rust: base: glam::Mat4,
    // rust: poses: &Poses,
    // rust: anchors: &[(String, String, [f32; 3])],
    // rust: left: bool,
    // rust: ) -> Option<glam::Mat4> {
    // A pack's `attachments` anchor (`right_handheld_item`...) replaces the whole hand
    // anchor: the walk to the part that declares it and its offset, none of the vanilla
    // hand's own transforms — EMF's one-off override during `translateToHand`. Without one
    // the vanilla anchor stays.
    // rust: if let Some(t) = attachment_matrix(
    // rust: model,
    // rust: base,
    // rust: poses,
    // rust: anchors,
    // rust: if left {
    // rust: "left_handheld_item"
    // rust: } else {
    // rust: "right_handheld_item"
    // rust: },
    // rust: ) {
    // rust: return Some(t);
}
    // rust: let skeleton = matches!(
    // rust: m.species(),
    // rust: Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::WitherSkeleton
    // rust: );
    // rust: let arm = if left { "left_arm" } else { "right_arm" };
    // `SkeletonModel.translateToHand` shifts the arm by 1, `PlayerModel.translateToHand`
    // by 0.5 for slim arms: the hand is the middle of the arm.
    // rust: let offset = if skeleton {
    // rust: if left { -1.0 } else { 1.0 }
    // rust: } else if avatar(m) && m.slim {
    // rust: if left { -0.5 } else { 0.5 }
    // rust: } else {
    // rust: 0.0
}
    // rust: let mut t = if m.species() == Species::Allay {
    // rust: allay_hand(model, base, poses)?
    // rust: } else {
    // rust: part_matrix(model, base, poses, arm, offset)?
}
    // rust: if m.species() == Species::Vex {
        // `VexModel.translateToHand`: the held item is drawn at 0.55 scale.
    // rust: t *= glam::Mat4::from_scale(glam::Vec3::splat(0.55));
    // rust: t *= glam::Mat4::from_translation(glam::Vec3::new(
    // rust: if left { -0.046_875 } else { 0.046_875 },
    // rust: -0.156_25,
    // rust: 0.078_125,
    // rust: ));
}
    // rust: if m.species() == Species::CopperGolem {
        // `CopperGolemModel.translateToHand`: a still golem holds the item
        // across the arm, a working one scaled down in front of it.
    // rust: if m.extra.variant3 == super::copper_golem::IDLE {
    // rust: t *= glam::Mat4::from_rotation_y((if left { 90.0f32 } else { -90.0 }).to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.0, 0.125));
    // rust: } else {
    // rust: t *= glam::Mat4::from_scale(glam::Vec3::splat(0.55))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(-0.125, 0.3125, -0.1875));
}
}
    // rust: let (ox, oy, oz) = if m.is_baby() {
    // rust: (0.0, 1.0, -4.5)
    // rust: } else {
    // rust: (1.0, 2.0, -10.0)
}
    // rust: t *= glam::Mat4::from_rotation_x((-90.0f32).to_radians()) * glam::Mat4::from_rotation_y(PI);
    // rust: t *= glam::Mat4::from_translation(glam::Vec3::new(
    // rust: if left { -ox } else { ox } / 16.0,
    // rust: oy / 16.0,
    // rust: oz / 16.0,
    // rust: ));
    // rust: Some(t)
}
/// The transform of one of a mob's model parts, in camera space
/// (`ModelPart.translateAndRotate` down the tree).
    // rust: pub fn part_transform(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: data: &MobData,
    // rust: part: &str,
    // rust: ) -> Option<glam::Mat4> {
    // rust: let base = base_transform(m, alpha, camera);
    // rust: let (model, poses, _) = posed_body(m, alpha, data);
    // rust: part_matrix(&model, base, &poses, part, 0.0)
}
/// `PlayerItemInHandLayer.renderItemHeldToEye` up to the item: the root and
/// the head with its pitch clamped to -30 to 90 degrees, `translateToHead`
/// (`CustomHeadLayer.translateToHead`), then the hand's side of the eye.
    // rust: pub fn held_to_eye_matrix(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: data: &MobData,
    // rust: left: bool,
    // rust: ) -> Option<glam::Mat4> {
//     use glam::{Mat4, Vec3};
    // rust: let base = base_transform(m, alpha, camera);
    // rust: let (model, mut poses, _) = posed_body(m, alpha, data);
    // rust: let pitch =
    // rust: poses.get("head")[3].clamp(-std::f32::consts::FRAC_PI_6, std::f32::consts::FRAC_PI_2);
    // rust: poses.xrot("head", pitch);
    // rust: let head = part_matrix(&model, base, &poses, "head", 0.0)?;
    // rust: let side = if left { -2.5 / 16.0 } else { 2.5 / 16.0 };
    // rust: Some(
    // rust: head * Mat4::from_translation(Vec3::new(0.0, -0.25, 0.0))
    // rust: * Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * Mat4::from_scale(Vec3::new(0.625, -0.625, -0.625))
    // rust: * Mat4::from_translation(Vec3::new(side, -0.0625, 0.0)),
    // rust: )
}
/// `FoxHeldItemLayer`: the item sits at the head's position under the render
/// state's head roll, yaw and pitch (not the posed head's, which differ while
/// it sleeps), pushed out to the mouth.
pub fn fox_item_transform(m: *Mob, alpha: f32, camera: glam::DVec3, data: *MobData) g {
    // Implementation ported from Horizon
    return undefined;
}
//     use glam::{Mat4, Vec3};
    // rust: let s = anim::state(m, alpha);
    // rust: let (model, mut poses, anchors) = posed_body(m, alpha, data);
    // rust: let head = *poses.get("head");
    // rust: let fox = super::fox::pose(m, alpha);
    // rust: let baby = m.is_baby();
    // rust: let mut t = base_transform(m, alpha, camera)
    // rust: * Mat4::from_translation(Vec3::new(head[0], head[1], head[2]) / 16.0);
    // rust: if baby {
    // rust: t *= Mat4::from_scale(Vec3::splat(0.75));
}
    // rust: t *= Mat4::from_rotation_z(fox.head_roll_angle)
    // rust: * Mat4::from_rotation_y(s.y_rot.to_radians())
    // rust: * Mat4::from_rotation_x(s.x_rot.to_radians());
    // A pack's `fox_item` anchor (Fresh Animations' fox declares one under its rebuilt
    // head) replaces the mouth offset: the walk to the part that declares it and its
    // offset, as EMF's fox offset injects the positioner in place of the layer's first
    // translate. The layer's own rotations (the item's upright) keep applying after
    // either way.
    // rust: if let Some(anchor) = attachment_matrix(&model, t, &poses, &anchors, "fox_item") {
    // rust: t = anchor;
    // rust: } else {
    // rust: let (x, y, z) = match (baby, fox.sleeping) {
    // rust: (true, true) => (0.4, 0.26, 0.15),
    // rust: (true, false) => (0.06, 0.26, -0.5),
    // rust: (false, true) => (0.46, 0.26, 0.22),
    // rust: (false, false) => (0.06, 0.27, -0.5),
}
    // rust: t *= Mat4::from_translation(Vec3::new(x, y, z));
}
    // rust: t *= Mat4::from_rotation_x(90.0f32.to_radians());
    // rust: if fox.sleeping {
    // rust: t *= Mat4::from_rotation_z(90.0f32.to_radians());
}
    // rust: t
}
/// `CrossedArmsItemLayer.applyTranslation`: `translateToArms`, then the item's
/// placement over the folded arms.
pub fn crossed_arms_matrix(model: *Part, base: glam::Mat4, poses: *Poses) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let arms = part_matrix(model, base, poses, "arms", 0.0)?;
    // rust: Some(
    // rust: arms * glam::Mat4::from_rotation_x(0.75)
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(1.07))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.13, -0.34))
    // rust: * glam::Mat4::from_rotation_x(std::f32::consts::PI),
    // rust: )
}
/// The pose a mob's held item is submitted under (`ItemInHandLayer`:
/// `translateToHand`, then the hand offset; the item model adds its own
/// display transform), or `None` when the mob shows no held items.
    // rust: pub fn held_item_transform(
    // rust: m: &Mob,
    // rust: alpha: f32,
    // rust: camera: glam::DVec3,
    // rust: data: &MobData,
    // rust: left: bool,
    // rust: ) -> Option<glam::Mat4> {
    // PandaHoldsItemLayer: the main hand's item in its mouth.
    // rust: if m.species() == Species::Panda {
    // rust: return super::panda::item_offset(m, alpha)
    // rust: .filter(|_| !left)
    // rust: .map(|offset| base_transform(m, alpha, camera) * offset);
}
    // FoxHeldItemLayer: the main hand's item in its mouth.
    // rust: if m.species() == Species::Fox {
    // rust: return (!left).then(|| fox_item_transform(m, alpha, camera, data));
}
    // DolphinCarryingItemLayer: the main hand's item at the snout, lifted and
    // pulled in as the dolphin pitches (up or down) toward 60 degrees.
    // rust: if m.species() == Species::Dolphin {
    // rust: return (!left).then(|| {
    // rust: let pitch = anim::state(m, alpha).x_rot;
    // rust: let percent = pitch.abs() / 60.0;
    // rust: let offset = if pitch < 0.0 {
    // rust: glam::Vec3::new(0.0, 1.0 - percent * 0.5, -1.0 + percent * 0.5)
    // rust: } else {
    // rust: glam::Vec3::new(0.0, 1.0 + percent * 0.8, -1.0 + percent * 0.2)
}
    // rust: base_transform(m, alpha, camera) * glam::Mat4::from_translation(offset)
    // rust: });
}
    // rust: if !super::illager::shows_item(m) {
    // rust: return None;
}
    // rust: let base = base_transform(m, alpha, camera);
    // rust: let s = anim::state(m, alpha);
    // rust: let (model, poses, anchors) = posed_body(m, alpha, data);
    // WitchItemLayer.applyTranslation: a potion is held at the nose, any other
    // item as CrossedArmsItemLayer holds it; only the main hand's item is drawn.
    // rust: if m.species() == Species::Witch {
    // rust: let item = m.extra.main_hand.as_deref()?;
    // rust: if left != m.main_arm_left() {
    // rust: return None;
}
    // rust: if super::witch::holds_potion(item) {
    // rust: let nose = part_matrix(&model, base, &poses, "nose", 0.0)?;
    // rust: return Some(
    // rust: nose * glam::Mat4::from_translation(glam::Vec3::new(0.0625, 0.25, 0.0))
    // rust: * glam::Mat4::from_rotation_z(180.0f32.to_radians())
    // rust: * glam::Mat4::from_rotation_x(140.0f32.to_radians())
    // rust: * glam::Mat4::from_rotation_z(10.0f32.to_radians())
    // rust: * glam::Mat4::from_rotation_x(180.0f32.to_radians()),
    // rust: );
}
    // rust: return crossed_arms_matrix(&model, base, &poses);
}
    // CrossedArmsItemLayer (villagers and wandering traders): the main hand's
    // item over the folded arms.
    // rust: if matches!(m.species(), Species::Villager | Species::WanderingTrader) {
    // rust: m.extra.main_hand.as_deref()?;
    // rust: if left != m.main_arm_left() {
    // rust: return None;
}
    // rust: return crossed_arms_matrix(&model, base, &poses);
}
    // rust: let mut t = hand_base(m, &model, base, &poses, &anchors, left)?;
    // ItemInHandLayer: a STAB swing of this arm thrusts its item out
    // (SpearAnimations.thirdPersonAttackItem, the main hand's forward
    // movement), and a spear in use moves with it (ArmPose.SPEAR's
    // animateUseItem).
    // rust: let swing_left = m.extra.swing_right_arm.map_or(m.main_arm_left(), |r| !r);
    // rust: if m.extra.swing_stab && swing_left == left {
    // rust: let forward = m
    // rust: .extra
    // rust: .main_hand
    // rust: .as_deref()
    // rust: .and_then(crate::spear::Kinetic::of)
    // rust: .map_or(0.0, |k| k.forward_movement);
    // rust: t *= crate::spear::third_person_attack_item(s.swing, forward);
}
    // rust: let off_hand = left != m.main_arm_left();
    // rust: if super::spear_use::is_using_item(m)
    // rust: && m.extra.using_off_hand == off_hand
    // rust: && let Some(kinetic) = (if off_hand {
    // rust: &m.extra.off_hand
    // rust: } else {
    // rust: &m.extra.main_hand
    // rust: })
    // rust: .as_deref()
    // rust: .and_then(crate::spear::Kinetic::of)
    // rust: {
    // rust: let time_held = m.extra.using_item as f32 + s.partial;
    // rust: t *= crate::spear::third_person_use_item(&kinetic, time_held, s.swing, 0.0, !left);
}
    // rust: Some(t)
}

/// `ArmedEntityRenderState.extractArmedEntityRenderState`: each arm's item
/// model reads the stack held by that arm. Only the main hand currently
/// retains a full stack; the off hand must not inherit its item or components.
pub fn held_item_stack(extra: *super::Extra, off_hand: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let item = if off_hand {
    // rust: extra.off_hand.as_ref()?
    // rust: } else {
    // rust: if let Some(stack) = extra.main_hand_stack() {
    // rust: return Some(stack.clone());
}
    // rust: extra.main_hand.as_ref()?
}
    // rust: Some(crate::items::ItemStack::new(item, 1))
}

    // rust: mod tests {
//     use super::*;

    /// A baby zombie's armour reads the `humanoid_baby` textures for every
    /// slot, not the adult `humanoid`/`humanoid_leggings` ones (#7302).
pub fn a_baby_zombies_armour_uses_the_humanoid_baby_textures() void {
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = Species::Zombie;
    // rust: let model = kind.model.clone();
    // rust: kind.layers.insert("zombie_baby#main".into(), model);
    // rust: let mut mob = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(kind),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: mob.extra.age = -24000;
    // rust: mob.extra.head = Some("minecraft:iron_helmet".into());
    // rust: mob.extra.legs = Some("minecraft:iron_leggings".into());
    // rust: mob.extra.feet = Some("minecraft:leather_boots".into());
    // rust: let mut layers = Vec::new();
    // rust: humanoid_armor(&mob, &mut layers);
    // rust: let textures: Vec<&str> = layers.iter().map(|l| &*l.texture).collect();
    // rust: assert_eq!(
    // rust: textures,
    // rust: [
    // rust: "entity/equipment/humanoid_baby/iron",
    // rust: "entity/equipment/humanoid_baby/iron",
    // rust: "entity/equipment/humanoid_baby/leather",
    // rust: "entity/equipment/humanoid_baby/leather_overlay",
    // rust: ]
    // rust: );
    // rust: mob.extra.age = 0;
    // rust: let mut adult = Vec::new();
    // rust: humanoid_armor(&mob, &mut adult);
    // rust: assert_eq!(
    // rust: &*adult[1].texture,
    // rust: "entity/equipment/humanoid_leggings/iron"
    // rust: );
}

pub fn creeper_swelling_uses_local_fuse_and_keeps_java_zero_division() void {
}
    // rust: let mut mob = Mob::new(
    // rust: 1,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: );
    // rust: mob.previous_swell = 19;
    // rust: mob.swell = 20;
    // rust: assert_eq!(creeper_swelling(&mob, 0.5), 19.5 / 28.0);
    // rust: mob.max_swell = 40;
    // rust: assert_eq!(creeper_swelling(&mob, 0.5), 19.5 / 38.0);
    // rust: mob.max_swell = 2;
    // rust: assert!(creeper_swelling(&mob, 0.5).is_infinite());
    // rust: mob.previous_swell = 0;
    // rust: mob.swell = 0;
    // rust: assert!(creeper_swelling(&mob, 0.5).is_nan());
}

pub fn offhand_does_not_inherit_mainhand_components() void {
}
//         use crate::items::ItemStack;
    // rust: let mut extra = super::super::Extra::default();
    // rust: let mut main = ItemStack::new("minecraft:crossbow", 1);
    // rust: main.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("Main hand".into()));
    // rust: extra.set_main_hand_stack(Some(main));
    // rust: extra.off_hand = Some("minecraft:crossbow".into());
    // rust: assert_eq!(
    // rust: held_item_stack(&extra, false)
    // rust: .unwrap()
    // rust: .custom_name()
    // rust: .as_deref(),
    // rust: Some("Main hand")
    // rust: );
    // rust: assert!(
    // rust: held_item_stack(&extra, true)
    // rust: .unwrap()
    // rust: .custom_name()
    // rust: .is_none()
    // rust: );
        // An admiring piglin holds gold beside its crossbow. Both the item
        // id and the model components must come from the appropriate hand.
    // rust: extra.off_hand = Some("minecraft:gold_ingot".into());
    // rust: assert_eq!(
    // rust: &*held_item_stack(&extra, true).unwrap().item,
    // rust: "minecraft:gold_ingot"
    // rust: );
    // rust: assert_eq!(
    // rust: &*held_item_stack(&extra, false).unwrap().item,
    // rust: "minecraft:crossbow"
    // rust: );
    // rust: extra.off_hand = None;
    // rust: assert!(held_item_stack(&extra, true).is_none());
}

    /// The elytra's flight yaw (`AvatarRenderer.extractFlightData`) lerps
    /// the velocity of the previous tick towards this tick's, so the model
    /// does not step once per tick while the view turns (#4104).
pub fn the_elytra_flight_yaw_lerps_the_velocity_between_ticks() void {
}
//         use crate::mobs::{Anim, Brain, Flags, MobType, Part};
//         use horizon_core::geometry::Vec3;
//         use serde_json::json;
//         use std::sync::Arc;

    // rust: let model = Arc::new(Part::parse("root", &json!({"children": {"head": {}}})));
    // rust: let kind = Arc::new(MobType {
    // rust: id: "minecraft:player".into(),
    // rust: species: Species::Zombie,
    // rust: width: 0.6,
    // rust: height: 1.8,
    // rust: eye_height: 1.62,
    // rust: category: "misc".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.1,
    // rust: flying_speed: 0.02,
    // rust: attack_damage: 1.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 0.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Arc::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 80,
    // rust: flags: Flags::default(),
    // rust: model,
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Camel,
    // rust: sounds: [""; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
    // rust: });
    // rust: let gliding = |previous: Vec3, current: Vec3| {
    // rust: let mut m = Mob::new(1, kind.clone(), Vec3::ZERO, 0.0);
    // rust: m.extra.fall_flying = true;
    // rust: m.extra.fall_fly_ticks = 20;
    // rust: m.extra.previous_velocity = previous;
    // rust: m.velocity = current;
    // rust: m
}
    // rust: let from = Vec3::new(0.4, 0.0, 0.4);
    // rust: let to = Vec3::new(0.0, 0.0, 0.5);
    // rust: let at = |m: &Mob, alpha: f32| base_transform_at(m, alpha, glam::Mat4::IDENTITY);
    // rust: let differs = |a: glam::Mat4, b: glam::Mat4| {
    // rust: a.to_cols_array()
    // rust: .iter()
    // rust: .zip(b.to_cols_array())
    // rust: .any(|(x, y)| (x - y).abs() > 1.0e-4)
}
    // rust: let m = gliding(from, to);
        // The ends are the two ticks' velocities.
    // rust: assert!(!differs(at(&m, 0.0), at(&gliding(from, from), 0.0)));
    // rust: assert!(!differs(at(&m, 1.0), at(&gliding(to, to), 1.0)));
        // Between them the yaw is that of the lerped velocity, which is
        // neither end: the current tick's alone made it snap.
    // rust: let mid = Vec3::new(0.2, 0.0, 0.45);
    // rust: let half = at(&m, 0.5);
    // rust: assert!(!differs(half, at(&gliding(mid, mid), 0.5)));
    // rust: assert!(differs(half, at(&gliding(to, to), 0.5)));
    // rust: assert!(differs(half, at(&gliding(from, from), 0.5)));
}

    /// Six faces whose corners span `min` to `max`.
pub fn cube(min: [f32; 3], max: [f32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let corner = |p: [f32; 3]| [p[0], p[1], p[2], 0.0, 0.0];
    // rust: (0..6)
    // rust: .map(|_| super::super::Polygon {
    // rust: normal: [0.0; 3],
    // rust: vertices: [corner(min), corner(max), corner(min), corner(max)],
    // rust: cull_back: false,
    // rust: })
    // rust: .collect()
}

    /// `ModelPart.cubes`: the corners of each cube of a part, six faces apiece.
pub fn cube_bounds_follow_the_faces_of_each_cube() void {
}
    // rust: let mut polygons = cube([-4.0, -8.0, -2.0], [4.0, 0.0, 2.0]);
    // rust: polygons.extend(cube([0.0, 0.0, 0.0], [1.0, 2.0, 3.0]));
    // rust: let part = Part {
    // rust: name: "body".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons,
    // rust: children: Vec::new(),
}
    // rust: assert_eq!(
    // rust: cube_bounds(&part),
    // rust: vec![
    // rust: [-4.0, -8.0, -2.0, 4.0, 0.0, 2.0],
    // rust: [0.0, 0.0, 0.0, 1.0, 2.0, 3.0]
    // rust: ]
    // rust: );
}

    /// `StuckInBodyLayer.snapToFace`.
pub fn a_stuck_item_snaps_to_the_far_or_the_middle_face() void {
}
    // rust: assert_eq!(snap_to_face(0.75), 1.0);
    // rust: assert_eq!(snap_to_face(0.5), 0.5);
    // rust: assert_eq!(snap_to_face(0.1), 0.5);
}

pub fn shoulder_parrot_textures_follow_the_variant() void {
}
    // rust: assert_eq!(shoulder_parrot_texture(0), "entity/parrot/parrot_red_blue");
    // rust: assert_eq!(shoulder_parrot_texture(4), "entity/parrot/parrot_grey");
        // Parrot.Variant.byId clamps an id out of range.
    // rust: assert_eq!(shoulder_parrot_texture(5), "entity/parrot/parrot_grey");
    // rust: assert_eq!(shoulder_parrot_texture(-1), "entity/parrot/parrot_red_blue");
}

    /// VillagerProfessionLayer's textures (type, or baby for a baby;
    /// profession; level) of every villager and zombie villager are in the
    /// prepared resources: a missing one draws nothing.
pub fn villager_layers_name_textures_that_exist() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: for kind in ["minecraft:villager", "minecraft:zombie_villager"] {
    // rust: let kind = std::sync::Arc::new(types.types[kind].clone());
    // rust: for baby in [false, true] {
    // rust: for t in 0..VILLAGER_TYPES.len() {
    // rust: for p in 0..PROFESSIONS.len() {
    // rust: let mut m =
    // rust: Mob::new(1, kind.clone(), horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: m.extra.age = if baby { -24000 } else { 0 };
    // rust: (m.extra.variant, m.extra.variant2, m.extra.variant3) =
    // rust: (t as u8, p as u8, 5);
    // rust: let layers = layers(&m, m.age as f32);
    // rust: let group = if baby { "/baby/" } else { "/type/" };
    // rust: assert!(
    // rust: layers.iter().any(|l| l.texture.contains(group)),
    // rust: "{kind:?} baby={baby}: no {group} layer"
    // rust: );
    // rust: for layer in layers {
    // rust: let png = root
    // rust: .join(format!("assets/minecraft/textures/{}.png", layer.texture));
    // rust: assert!(png.is_file(), "missing {}", png.display());
}
}
}
}
}
}

pub fn sulfur_cube_opaque_core_is_submitted_before_its_translucent_shell() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let mut types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types.remove("minecraft:sulfur_cube").unwrap());
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: let atlas = |name: &str| {
    // rust: Some(if name.contains("_inner") {
    // rust: [0.0, 0.0, 0.25, 0.25]
    // rust: } else {
    // rust: [0.5, 0.5, 0.75, 0.75]
    // rust: })
}
    // rust: for baby in [false, true] {
    // rust: let mut mob = Mob::new(1, kind.clone(), horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: mob.extra.age = if baby { -24000 } else { 0 };
    // rust: super::super::sulfur_cube::finalize(&mut mob);
    // rust: assert_eq!(mob.is_baby(), baby);
    // rust: for posed in [false, true] {
    // rust: let mut vertices = Vec::new();
    // rust: if posed {
    // rust: render_posed(
    // rust: &mob,
    // rust: 0.5,
    // rust: glam::Mat4::IDENTITY,
    // rust: &atlas,
    // rust: 0xf0f0,
    // rust: &data,
    // rust: &mut vertices,
    // rust: );
    // rust: } else {
    // rust: render(
    // rust: &mob,
    // rust: 0.5,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xf0f0,
    // rust: &data,
    // rust: &mut vertices,
    // rust: );
}
    // rust: assert_eq!(
    // rust: vertices.len(),
    // rust: 48,
    // rust: "both real six-face models must be drawn"
    // rust: );
    // rust: assert!(
    // rust: vertices[..24].iter().all(|v| v.uv[0] <= 0.25),
    // rust: "opaque core must precede shell"
    // rust: );
    // rust: assert!(vertices[24..].iter().all(|v| v.uv[0] >= 0.5));
}
    // rust: mob.extra.body = Some("minecraft:stone".into());
    // rust: let mut vertices = Vec::new();
    // rust: render(
    // rust: &mob,
    // rust: 0.5,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xf0f0,
    // rust: &data,
    // rust: &mut vertices,
    // rust: );
    // rust: assert_eq!(
    // rust: vertices.len(),
    // rust: 24,
    // rust: "a swallowed block still hides the default core"
    // rust: );
    // rust: assert!(vertices.iter().all(|v| v.uv[0] >= 0.5));
}
}
    /// CopperGolemRenderer: the emissive eye layer draws the eye texture on
    /// the body's model, every polygon of it, at each oxidation level. The
    /// prepared `copper_golem#eyes` model has no polygons, so the eyes
    /// showed the body texture's black sockets.
pub fn copper_golem_eyes_are_drawn_on_the_body_model() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:copper_golem"].clone());
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: let atlas = |name: &str| {
    // rust: Some(if name.contains("copper_golem_eyes") {
    // rust: [0.5, 0.5, 0.75, 0.75]
    // rust: } else {
    // rust: [0.0, 0.0, 0.25, 0.25]
    // rust: })
}
    // rust: for variant in 0..4 {
    // rust: let mut mob = Mob::new(1, kind.clone(), horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: mob.extra.variant = variant;
    // rust: let mut vertices = Vec::new();
    // rust: render(
    // rust: &mob,
    // rust: 0.5,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xf0f0,
    // rust: &data,
    // rust: &mut vertices,
    // rust: );
    // rust: let body = vertices.iter().filter(|v| v.uv[0] <= 0.25).count();
    // rust: let eyes = vertices.iter().filter(|v| v.uv[0] >= 0.5).count();
    // rust: assert!(body > 0, "variant {variant}: no body drawn");
    // rust: assert_eq!(
    // rust: eyes, body,
    // rust: "variant {variant}: the eye layer covers the body"
    // rust: );
}
}
    /// `VexModel.translateToHand`: the held item is drawn at 0.55 scale and
    /// moved by the vex's own offset, so the vex's sword is the tiny one
    /// vanilla shows. It was drawn at the full size, like a zombie's.
pub fn the_vex_holds_its_item_at_the_small_scale() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:vex"].clone());
    // rust: let mob = Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: for left in [false, true] {
    // rust: let t = held_item_transform(&mob, 0.5, glam::DVec3::ZERO, &data, left).unwrap();
            // The model's own part scale is 1, so the item's scale is the
            // renderer's: `poseStack.scale(0.55F, 0.55F, 0.55F)`.
    // rust: for axis in [t.x_axis, t.y_axis, t.z_axis] {
    // rust: let scale = axis.truncate().length();
    // rust: assert!(
    // rust: (scale - 0.55).abs() < 1.0e-5,
    // rust: "the vex's item is drawn at 0.55 scale, got {scale}"
    // rust: );
}
}
}

    /// `CrossedArmsItemLayer`: a villager and a wandering trader show their
    /// main hand's item over the folded arms, and nothing in the off hand.
pub fn villagers_and_traders_hold_items_in_crossed_arms() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let facts = crate::blocks::BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let data = MobData::load(&root, &facts);
    // rust: for id in ["minecraft:villager", "minecraft:wandering_trader"] {
    // rust: let kind = std::sync::Arc::new(types.types[id].clone());
    // rust: let mut mob = Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: let main = mob.main_arm_left();
    // rust: assert!(held_item_transform(&mob, 1.0, glam::DVec3::ZERO, &data, main).is_none());
    // rust: mob.extra.set_main_hand(Some("minecraft:emerald".into()));
    // rust: assert!(held_item_transform(&mob, 1.0, glam::DVec3::ZERO, &data, main).is_some());
    // rust: assert!(held_item_transform(&mob, 1.0, glam::DVec3::ZERO, &data, !main).is_none());
}
}
    /// PhantomRenderer.scale moves the model down into its 0.5-high box:
    /// the model's origin ends 1.501 - 1.3125 blocks above the feet (times
    /// the size's scale), not 1.501 like other mobs (#3008).
pub fn the_phantom_model_sits_in_its_box() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:phantom"].clone());
    // rust: let mut mob = Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: for (size, scale) in [(0, 1.0f32), (5, 1.75)] {
    // rust: mob.extra.size = size;
    // rust: let origin =
    // rust: base_transform(&mob, 1.0, glam::DVec3::ZERO).transform_point3(glam::Vec3::ZERO);
    // rust: let y = (1.501 - 1.3125) * scale;
    // rust: assert!(
    // rust: (origin.y - y).abs() < 1.0e-4,
    // rust: "size {size}: origin {origin}"
    // rust: );
    // rust: assert!(
    // rust: (origin.z.abs() - 0.1875 * scale).abs() < 1.0e-4,
    // rust: "size {size}: origin {origin}"
    // rust: );
}
}
    /// `EquipmentLayerRenderer.renderLayers`: the extra armour layers (a
    /// player's) take their own overlay, `NO_OVERLAY` or the armour glint,
    /// never the hurt tint of the body, and the glint samples the model UV.
pub fn extra_armour_layers_carry_their_glint_not_the_hurt_tint() void {
}
        // The batch gives these overlays their own materials (13, the water
        // mask, draws depth only): the glint must not be one of them.
//         use crate::gfx::{
    // rust: ENERGY_SWIRL_OVERLAY, SHADOW_OVERLAY, TEXT_POLYGON_OFFSET_OVERLAY,
    // rust: TRANSLUCENT_GLINT_ITEM_OVERLAY, TRANSLUCENT_ITEM_OVERLAY, TRANSLUCENT_PARTICLE_OVERLAY,
    // rust: WATER_MASK_OVERLAY,
}
    // rust: assert!(
    // rust: ![
    // rust: WATER_MASK_OVERLAY,
    // rust: SHADOW_OVERLAY,
    // rust: TRANSLUCENT_PARTICLE_OVERLAY,
    // rust: TRANSLUCENT_ITEM_OVERLAY,
    // rust: TRANSLUCENT_GLINT_ITEM_OVERLAY,
    // rust: ENERGY_SWIRL_OVERLAY,
    // rust: TEXT_POLYGON_OFFSET_OVERLAY,
    // rust: ]
    // rust: .contains(&ARMOR_GLINT)
    // rust: );
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:zombie"].clone());
    // rust: let mut mob = Mob::new(1, kind.clone(), horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: mob.hurt_time = 5;
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: let atlas = |_: &str| Some([0.0, 0.0, 0.25, 0.25]);
    // rust: let part = &kind.model;
    // rust: for overlay in [ARMOR_GLINT, 0] {
    // rust: let mut vertices = Vec::new();
    // rust: render_with(
    // rust: &mob,
    // rust: 0.5,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 0xf0f0,
    // rust: &data,
    // rust: &[(part, [0.5, 0.5, 0.75, 0.75], 0xFFFF_FFFF, overlay, false)],
    // rust: &mut vertices,
    // rust: );
    // rust: let (armour, body): (Vec<&Vertex>, Vec<&Vertex>) =
    // rust: vertices.iter().partition(|v| v.uv[0] >= 0.5);
    // rust: assert!(!armour.is_empty() && !body.is_empty());
            // The hurt body keeps its red overlay.
    // rust: let hurt = body_overlay(&mob, 0.5);
    // rust: assert_ne!(hurt, 0);
    // rust: assert!(body.iter().all(|v| v.layer == hurt));
    // rust: assert!(armour.iter().all(|v| v.layer == overlay));
            // The glint scrolls the layer's model UV (0..1 over the texture).
    // rust: for v in &armour {
    // rust: if overlay == ARMOR_GLINT {
    // rust: assert!((v.glint_uv[0] - (v.uv[0] - 0.5) * 4.0).abs() < 1e-4);
    // rust: assert!((v.glint_uv[1] - (v.uv[1] - 0.5) * 4.0).abs() < 1e-4);
    // rust: } else {
    // rust: assert_eq!(v.glint_uv, [0.0, 0.0]);
}
}
}
}
pub fn a_dyed_leather_armour_keeps_its_colour() void {
}
        // EquipmentLayerRenderer.getColorForLayer: a dyeable layer takes
        // the stack's dye colour, the colour it has when undyed otherwise.
    // rust: let mut stack = crate::items::ItemStack {
    // rust: item: "minecraft:leather_helmet".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
        // Undyed leather: the colour the leather layer has when undyed.
    // rust: assert_eq!(armor_tint(Some(0xA06540), Some(&stack)), abgr(0xA06540));
        // Dyed: the stack's own colour.
    // rust: stack.extra = Some(Box::new(crate::item_data::StackData {
    // rust: dyed_color: Some(0x0000FF),
    // rust: ..Default::default()
    // rust: }));
    // rust: assert_eq!(armor_tint(Some(0xA06540), Some(&stack)), abgr(0x0000FF));
        // A layer that is not dyeable is not tinted.
    // rust: assert_eq!(armor_tint(None, Some(&stack)), 0xFFFF_FFFF);
}

    /// `ColorLerper.getLerpedColor(Type.SHEEP, ageInTicks)`: the points the
    /// 26.3 jar gave — 0, half a step, one whole step, a step boundary, the
    /// last step back into white, and the 400-tick (16-step) wrap.
pub fn jeb_wool_lerps_through_the_sixteen_dye_colours() void {
}
    // rust: assert_eq!(jeb_wool_rgb(0.0), 0xE6E6E6);
    // rust: assert_eq!(jeb_wool_rgb(12.5), 0xD0A37D);
    // rust: assert_eq!(jeb_wool_rgb(25.0), 0xBA6015);
    // rust: assert_eq!(jeb_wool_rgb(25.0), sheep_wool_rgb(1));
    // rust: assert_eq!(jeb_wool_rgb(50.0), 0x953A8D);
    // rust: assert_eq!(jeb_wool_rgb(399.0), 0xDDDDDD);
    // rust: assert_eq!(jeb_wool_rgb(400.0), 0xE6E6E6);
}

pub fn sheep_layer(m: *Mob, model: []const u8, age: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: layers(m, age).into_iter().find(|l| l.model == model)
}

    /// SheepRenderer.extractRenderState's `jeb_` magic name: the wool layer
    /// takes the lerped colour and cycles with the age, a white `jeb_` sheep
    /// keeps its undercoat (SheepWoolUndercoatLayer draws for it too), and
    /// the dye colour, the baby model and the shears still win.
pub fn a_jeb_sheep_cycles_its_wool_colour_and_keeps_the_undercoat() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:sheep"].clone());
    // rust: let mut mob = Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: mob.custom_name = Some("jeb_".into());
    // rust: let young = sheep_layer(&mob, "sheep#wool", 0.0)
    // rust: .expect("an unsheared sheep draws its wool")
    // rust: .color;
    // rust: assert_eq!(young, abgr(0xE6E6E6));
    // rust: let older = sheep_layer(&mob, "sheep#wool", 100.0)
    // rust: .expect("an unsheared sheep draws its wool")
    // rust: .color;
    // rust: assert_ne!(young, older, "the colour cycles with the age");
    // rust: let undercoat = sheep_layer(&mob, "sheep#wool_undercoat", 0.0)
    // rust: .expect("a jeb_ sheep keeps its undercoat");
    // rust: assert_eq!(undercoat.color, abgr(0xE6E6E6));
        // A name that is not exactly "jeb_" leaves a dyed sheep's colour, and
        // a non-white sheep has its undercoat too.
    // rust: mob.custom_name = Some("jeb".into());
    // rust: mob.extra.color = 14;
    // rust: let dyed = abgr(sheep_wool_rgb(14));
    // rust: assert_eq!(
    // rust: sheep_layer(&mob, "sheep#wool", 0.0)
    // rust: .expect("an unsheared sheep draws its wool")
    // rust: .color,
    // rust: dyed
    // rust: );
    // rust: assert_eq!(
    // rust: sheep_layer(&mob, "sheep#wool_undercoat", 0.0)
    // rust: .expect("a dyed sheep keeps its undercoat")
    // rust: .color,
    // rust: dyed
    // rust: );
        // A baby `jeb_` sheep gets the lerped colour on the baby wool and
        // never an undercoat.
    // rust: mob.custom_name = Some("jeb_".into());
    // rust: mob.extra.color = 0;
    // rust: mob.extra.age = -24000;
    // rust: assert!(mob.is_baby());
    // rust: assert_eq!(
    // rust: sheep_layer(&mob, "sheep_baby#wool", 50.0)
    // rust: .expect("a baby sheep draws its wool")
    // rust: .color,
    // rust: abgr(0x953A8D)
    // rust: );
    // rust: assert!(sheep_layer(&mob, "sheep#wool_undercoat", 50.0).is_none());
        // Sheared: no wool layer at all.
    // rust: mob.extra.age = 0;
    // rust: mob.extra.sheared = true;
    // rust: assert!(sheep_layer(&mob, "sheep#wool", 0.0).is_none());
}
}

    // rust: mod scroll_tests {
pub fn a_pufferfish_bobs_by_eight_hundredths() void {
}
        // PufferfishRenderer.setupRotations: cos(ageInTicks * 0.05) * 0.08.
    // rust: assert!((super::pufferfish_bob_y(0.0) - 0.08).abs() < 1e-6);
    // rust: let quarter = std::f32::consts::FRAC_PI_2 / 0.05;
    // rust: assert!(super::pufferfish_bob_y(quarter).abs() < 1e-3);
    // rust: assert!(super::pufferfish_bob_y(2.0 * quarter) < -0.0799);
}

//     use super::*;

pub fn the_scrolling_texture_wraps_around() void {
}
        // RenderTypes.breezeWind: the breeze's wind layer's texture scrolls
        // by 0.02 of the texture per tick, the wind charge's by 0.03.
    // rust: assert_eq!(scroll_offset(0.0, BREEZE_WIND_SCROLL), 0.0);
    // rust: assert!((scroll_offset(25.0, BREEZE_WIND_SCROLL) - 0.5).abs() < 1e-6);
    // rust: assert!((scroll_offset(50.0, BREEZE_WIND_SCROLL) - 0.0).abs() < 1e-6);
    // rust: assert!((scroll_offset(50.0, WIND_CHARGE_SCROLL) - 0.5).abs() < 1e-6);
    // rust: assert!((scroll_offset(100.0, WIND_CHARGE_SCROLL) - 0.0).abs() < 1e-6);
}

pub fn the_scrolled_u_wraps_inside_the_texture() void {
}
        // Without a scroll the U is the vertex's own.
    // rust: assert_eq!(scroll_u(0.25, 0.0), 0.25);
    // rust: assert_eq!(scroll_u(1.0, 0.0), 1.0);
        // With one, it moves and wraps around the texture.
    // rust: assert!((scroll_u(0.25, 0.5) - 0.75).abs() < 1e-6);
    // rust: assert!((scroll_u(0.75, 0.5) - 0.25).abs() < 1e-6);
    // rust: assert!((scroll_u(1.0, 0.5) - 0.5).abs() < 1e-6);
}

    /// `SheepWoolLayer.submit` returns early on a sheared sheep, but
    /// `SheepWoolUndercoatLayer.submit` has no isSheared guard: a sheared
    /// dyed sheep keeps its undercoat and loses only its wool.
pub fn a_sheared_dyed_sheep_keeps_its_wool_undercoat() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:sheep"].clone());
    // rust: let sheep = |color: u8, sheared: bool, baby: bool| {
    // rust: let mut m = Mob::new(1, kind.clone(), horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: m.extra.color = color;
    // rust: m.extra.sheared = sheared;
    // rust: m.extra.age = if baby { -24000 } else { 0 };
    // rust: m
}
        // The sheep's wool layers, model, texture and colour, in submission order.
    // rust: let wool = |m: &Mob| -> Vec<(String, String, u32)> {
    // rust: layers(m, 0.0)
    // rust: .into_iter()
    // rust: .filter(|l| l.model.contains("#wool"))
    // rust: .map(|l| (l.model.into_owned(), l.texture.into_owned(), l.color))
    // rust: .collect()
}
    // rust: let dyed = abgr(sheep_wool_rgb(1));
    // rust: let layer = |model: &str, texture: &str| (model.to_owned(), texture.to_owned(), dyed);

        // The regression: the pre-fix single `!sheared` guard skipped both
        // layers, so a sheared dyed sheep drew nothing. It must keep the
        // undercoat alone, in its own colour and texture.
    // rust: assert_eq!(
    // rust: wool(&sheep(1, true, false)),
    // rust: [layer(
    // rust: "sheep#wool_undercoat",
    // rust: "entity/sheep/sheep_wool_undercoat"
    // rust: )]
    // rust: );
        // Guards, already green before the fix: a sheared white sheep has no
        // undercoat to keep, a baby has no undercoat at all, and an unsheared
        // dyed sheep draws both layers as before.
    // rust: assert!(wool(&sheep(0, true, false)).is_empty());
    // rust: assert_eq!(
    // rust: wool(&sheep(1, false, true)),
    // rust: [layer("sheep_baby#wool", "entity/sheep/sheep_wool_baby")]
    // rust: );
    // rust: assert!(wool(&sheep(1, true, true)).is_empty());
    // rust: assert_eq!(
    // rust: wool(&sheep(1, false, false)),
    // rust: [
    // rust: layer("sheep#wool_undercoat", "entity/sheep/sheep_wool_undercoat"),
    // rust: layer("sheep#wool", "entity/sheep/sheep_wool")
    // rust: ]
    // rust: );
}

    /// `anim::Poses` keys parts by a hash of their name: within any vanilla model, two
    /// different names never share one (they would share a pose).
pub fn no_two_part_names_share_a_key() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: fn names<'a>(p: &'a Part, out: &mut Vec<&'a str>) {
    // rust: out.push(&p.name);
    // rust: for c in &p.children {
    // rust: names(c, out);
}
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let mut models = 0;
    // rust: for kind in types.types.values() {
    // rust: for model in std::iter::once(&kind.model).chain(kind.layers.values()) {
    // rust: let mut all = Vec::new();
    // rust: names(model, &mut all);
    // rust: let mut keys = std::collections::HashMap::new();
    // rust: for name in all {
    // rust: let other = *keys.entry(super::super::anim::key(name)).or_insert(name);
    // rust: assert_eq!(other, name, "{} shares a key", kind.id);
}
    // rust: models += 1;
}
}
    // rust: assert!(models > 100);
}

    /// The CPU cost of posing a mob farm (tools/stress_scenes.py `stress_mobs`): 1000 mobs of
    /// 8 kinds through `render_with`, as `mob_geometry` draws them each frame. Prints the median
    /// thread CPU time per frame (busy machines stretch wall time), the vertices and a hash of them (the same hash before and after a speed-up
    /// means the same picture). `cargo test --profile fast -p horizon-client --lib
    /// benchmark_mob_farm_geometry -- --ignored --nocapture`.
pub fn benchmark_mob_farm_geometry() void {
}
//         use std::{hash::Hasher, hint::black_box, time::Instant};
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let types = super::super::MobTypes::load(&root).unwrap();
    // rust: let kinds = [
    // rust: "husk", "creeper", "cow", "pig", "sheep", "chicken", "villager", "spider",
    // rust: ]
    // rust: .map(|k| std::sync::Arc::new(types.types[&format!("minecraft:{k}")].clone()));
    // rust: let mobs: Vec<Mob> = (0..1000u32)
    // rust: .map(|i| {
    // rust: let (layer, row, col) = (i / 200, i / 20 % 10, i % 20);
    // rust: let at = horizon_core::geometry::Vec3::new(
    // rust: -14.25 + 1.5 * f64::from(col),
    // rust: 1.0 + 2.5 * f64::from(layer),
    // rust: 8.0 + 2.0 * f64::from(row),
    // rust: );
    // rust: let mut m = Mob::new(i + 1, kinds[i as usize % 8].clone(), at, 180.0);
    // rust: m.previous = at;
    // rust: m.age = i;
    // rust: m
    // rust: })
    // rust: .collect();
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
    // rust: let atlas = |name: &str| {
    // rust: let h = name.len() as f32 / 64.0;
    // rust: Some([h, h, h + 0.25, h + 0.25])
}
    // rust: let camera = glam::DVec3::new(0.5, 9.6, 0.5);
    // rust: let mut out = Vec::new();
    // rust: let frame = |out: &mut Vec<Vertex>| {
    // rust: out.clear();
    // rust: for m in &mobs {
    // rust: render_with(m, 0.5, camera, &atlas, 0xf0f0, &data, &[], out);
}
}
    // rust: frame(&mut out);
    // rust: let mut hash = std::collections::hash_map::DefaultHasher::new();
    // rust: hash.write(bytemuck::cast_slice(&out));
        // The thread's own CPU time where the platform gives it, else wall time.
    // rust: let timed = |f: &mut dyn FnMut()| {
    // rust: let (wall, cpu) = (Instant::now(), horizon_client_render::spans::thread_cpu());
    // rust: f();
    // rust: match (horizon_client_render::spans::thread_cpu(), cpu) {
    // rust: (Some(end), Some(start)) => (end - start).as_secs_f64() * 1000.0,
    // rust: _ => wall.elapsed().as_secs_f64() * 1000.0,
}
}
    // rust: let mut times = Vec::new();
    // rust: for _ in 0..30 {
    // rust: times.push(timed(&mut || frame(black_box(&mut out))));
}
    // rust: times.sort_by(f64::total_cmp);
    // rust: println!(
    // rust: "mob farm: 1000 mobs, {} vertices, {:.3} ms/frame (median of 30, min {:.3}), hash {:016x}",
    // rust: out.len(),
    // rust: times[15],
    // rust: times[0],
    // rust: hash.finish()
    // rust: );
        // Where it goes: the body's poses alone (state, pose map, setupAnim), then the
        // body's vertices alone from those poses.
    // rust: let median = |mut f: Box<dyn FnMut() + '_>| {
    // rust: let mut t: Vec<f64> = (0..30).map(|_| timed(&mut f)).collect();
    // rust: t.sort_by(f64::total_cmp);
    // rust: t[15]
}
    // rust: let posed: Vec<(std::sync::Arc<Part>, Poses)> = mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: let model = m.kind.model.clone();
    // rust: let mut poses = Poses::new(&model);
    // rust: anim::setup(m, &anim::state(m, 0.5), &mut poses, &data.animations);
    // rust: (model, poses)
    // rust: })
    // rust: .collect();
    // rust: let poses_ms = median(Box::new(|| {
    // rust: for m in &mobs {
    // rust: let model = m.kind.model.clone();
    // rust: let mut poses = Poses::new(&model);
    // rust: anim::setup(m, &anim::state(m, 0.5), &mut poses, &data.animations);
    // rust: black_box(&poses);
}
    // rust: }));
    // rust: let mut body = Vec::new();
    // rust: let draw_ms = median(Box::new(|| {
    // rust: body.clear();
    // rust: for (m, (model, poses)) in mobs.iter().zip(&posed) {
    // rust: let base = base_transform(m, 0.5, camera);
    // rust: draw(
    // rust: model,
    // rust: base,
    // rust: poses,
    // rust: [0.0, 0.0, 0.25, 0.25],
    // rust: u32::MAX,
    // rust: 0xf0f0,
    // rust: 0,
    // rust: &mut body,
    // rust: );
}
    // rust: black_box(&body);
    // rust: }));
    // rust: println!(
    // rust: "  body poses only {poses_ms:.3} ms; body vertices only {draw_ms:.3} ms ({} vertices)",
    // rust: body.len()
    // rust: );
}
}

    // rust: mod emissive_tests {
//     use super::*;
//     use crate::mobs::{Polygon, Species};
//     use horizon_optifine::{blink::Blinks, emissive::Emissive, random_textures::RandomTextures};
//     use std::sync::{Arc, RwLock};

    /// A silverfish (drawn with its type's texture) whose model is one quad.
pub fn silverfish() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.species = Species::Silverfish;
    // rust: k.texture = "entity/silverfish".into();
    // rust: k.model = Arc::new(Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![Polygon {
    // rust: normal: [0.0, 0.0, -1.0],
    // rust: cull_back: false,
    // rust: vertices: [
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0],
    // rust: [1.0, 0.0, 0.0, 1.0, 0.0],
    // rust: [1.0, 1.0, 0.0, 1.0, 1.0],
    // rust: [0.0, 1.0, 0.0, 0.0, 1.0],
    // rust: ],
    // rust: }],
    // rust: children: Vec::new(),
    // rust: });
    // rust: Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0)
}

pub fn data(files: *[[]const u8]) M {
    // Implementation ported from Horizon
    return undefined;
}
pub const N: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-render-emissive-{}-{}",
    // rust: std::process::id(),
    // rust: N.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: for file in files {
    // rust: let path = root.join(file);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
            // Rules files pick variant 2; images are only their names.
    // rust: let text = if file.ends_with(".properties") {
    // rust: "textures.1=2"
    // rust: } else {
    // rust: ""
}
    // rust: std::fs::write(path, text).unwrap();
}
    // rust: let random = RandomTextures::scan(&root);
    // rust: let blinks = Blinks::scan(&root, &random);
    // rust: let mut emissive = Emissive::scan(&root, &random);
    // rust: emissive.pair_beside(&root, blinks.files());
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: RwLock::new(random),
    // rust: emissive: RwLock::new(Arc::new(emissive)),
    // rust: blinks: RwLock::new(blinks),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
}

    /// Every sprite the test atlas has, each at its own rect.
pub fn atlas(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "entity/silverfish" => Some([0.0, 0.0, 0.5, 0.5]),
    // rust: "entity/silverfish_e" => Some([0.5, 0.5, 1.0, 1.0]),
    // rust: "entity/silverfish_blink" => Some([0.0, 0.5, 0.5, 1.0]),
    // rust: _ => None,
}
}

pub fn an_emissive_overlay_draws_the_body_again_at_full_brightness() void {
}
    // rust: let lit = (3 * 16) | ((5 * 16) << 8);
    // rust: let m = silverfish();
    // rust: let draw = |data: &MobData| {
    // rust: let mut out = Vec::new();
    // rust: render_with(&m, 0.0, glam::DVec3::ZERO, &atlas, lit, data, &[], &mut out);
    // rust: out
}
        // No `_e` file: one quad, as vanilla.
    // rust: let plain = draw(&data(&["assets/minecraft/textures/entity/silverfish.png"]));
    // rust: assert_eq!(plain.len(), 4);
    // rust: assert!(plain.iter().all(|v| v.light == lit));
    // rust: let glowing = draw(&data(&[
    // rust: "assets/minecraft/textures/entity/silverfish.png",
    // rust: "assets/minecraft/textures/entity/silverfish_e.png",
    // rust: ]));
    // rust: assert_eq!(glowing.len(), 8);
    // rust: let (body, glow) = glowing.split_at(4);
    // rust: assert!(body.iter().all(|v| v.light == lit));
    // rust: assert!(glow.iter().all(|v| v.light == FULL_BRIGHT));
        // The overlay samples its own sprite, and keeps the body's shading normals.
    // rust: assert!(glow.iter().all(|v| v.uv[0] >= 0.5 && v.uv[1] >= 0.5));
    // rust: assert!(body.iter().all(|v| v.uv[0] <= 0.5 && v.uv[1] <= 0.5));
    // rust: assert_eq!(
    // rust: glow.iter().map(|v| v.normal).collect::<Vec<_>>(),
    // rust: body.iter().map(|v| v.normal).collect::<Vec<_>>()
    // rust: );
}

pub fn a_blink_frame_replaces_the_texture_for_a_few_ticks() void {
}
    // rust: let data = data(&[
    // rust: "assets/minecraft/textures/entity/silverfish.png",
    // rust: "assets/minecraft/textures/entity/silverfish_blink.png",
    // rust: ]);
    // rust: let uvs = |age: u32| {
    // rust: let mut m = silverfish();
    // rust: m.age = age;
    // rust: let mut out = Vec::new();
    // rust: render_with(&m, 0.0, glam::DVec3::ZERO, &atlas, 0, &data, &[], &mut out);
    // rust: out.iter().map(|v| v.uv).collect::<Vec<_>>()
}
        // Entity 1's phase is 0x9E3779B1 % 150 = 61: of every 150 ticks, it blinks for the
        // default 5 from age 89 (89 + 61 = 150).
    // rust: let shut = |uv: &Vec<[f32; 2]>| uv.iter().all(|uv| uv[0] <= 0.5 && uv[1] >= 0.5);
    // rust: let open = |uv: &Vec<[f32; 2]>| uv.iter().all(|uv| uv[0] <= 0.5 && uv[1] <= 0.5);
    // rust: assert!(open(&uvs(88)));
    // rust: assert!(shut(&uvs(89)));
    // rust: assert!(shut(&uvs(93)));
    // rust: assert!(open(&uvs(94)));
    // rust: assert!(shut(&uvs(89 + 150)));
}

pub fn a_blink_shows_its_own_glow_or_none() void {
}
    // rust: let atlas = |name: &str| {
    // rust: let u = match name {
    // rust: "entity/silverfish" => 0.0,
    // rust: "entity/silverfish_e" => 0.25,
    // rust: "entity/silverfish_blink" => 0.5,
    // rust: "entity/silverfish_blink_e" => 0.75,
    // rust: _ => return None,
}
    // rust: Some([u, 0.0, u + 0.25, 1.0])
}
    // rust: let base = [
    // rust: "assets/minecraft/textures/entity/silverfish.png",
    // rust: "assets/minecraft/textures/entity/silverfish_e.png",
    // rust: "assets/minecraft/textures/entity/silverfish_blink.png",
    // rust: ];
    // rust: let at = |data: &MobData, age: u32| {
    // rust: let mut m = silverfish();
    // rust: m.age = age;
    // rust: drawn(&m, data, &atlas)
}
        // Age 89 is shut (see above), 0 open.
    // rust: let plain = data(&base);
    // rust: let open = at(&plain, 0);
    // rust: assert_eq!(open.len(), 8);
    // rust: assert!(inside(&open[4..], 0.25), "the texture's glow");
    // rust: let shut = at(&plain, 89);
    // rust: assert_eq!(shut.len(), 4, "no glowing open eyes over the shut ones");
    // rust: assert!(inside(&shut, 0.5));
    // rust: let mut own = base.to_vec();
    // rust: own.push("assets/minecraft/textures/entity/silverfish_blink_e.png");
    // rust: let shut = at(&data(&own), 89);
    // rust: assert_eq!(shut.len(), 8);
    // rust: assert!(inside(&shut[4..], 0.75), "the frame's own glow");
}

    /// Draws `m` and returns each vertex's (uv, light).
pub fn drawn(m: *Mob, data: *MobData, atlas: Atlas) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: render_with(m, 0.0, glam::DVec3::ZERO, atlas, 7, data, &[], &mut out);
    // rust: out.iter().map(|v| (v.uv, v.light)).collect()
}

    /// Whether every vertex samples inside the rect starting at `at` (each rect is 0.25 wide).
pub fn inside(vertices: *[([f32; 2]) void {
}
    // rust: vertices
    // rust: .iter()
    // rust: .all(|(uv, _)| (at..=at + 0.25).contains(&uv[0]))
}

pub fn a_layer_glows_with_its_own_overlay() void {
}
    // rust: let mut m = silverfish();
    // rust: let k = Arc::make_mut(&mut m.kind);
    // rust: k.species = Species::Sheep;
    // rust: k.layers.insert("sheep#wool".into(), k.model.clone());
    // rust: let data = data(&[
    // rust: "assets/minecraft/textures/entity/sheep/sheep.png",
    // rust: "assets/minecraft/textures/entity/sheep/sheep_wool.png",
    // rust: "assets/minecraft/textures/entity/sheep/sheep_wool_e.png",
    // rust: ]);
    // rust: let atlas = |name: &str| {
    // rust: let u = match name {
    // rust: "entity/sheep/sheep" => 0.0,
    // rust: "entity/sheep/sheep_wool" => 0.25,
    // rust: "entity/sheep/sheep_wool_e" => 0.5,
    // rust: _ => return None,
}
    // rust: Some([u, 0.0, u + 0.25, 1.0])
}
    // rust: let v = drawn(&m, &data, &atlas);
    // rust: assert_eq!(v.len(), 12, "body, wool, wool's glow");
    // rust: assert!(inside(&v[..4], 0.0) && inside(&v[4..8], 0.25) && inside(&v[8..], 0.5));
    // rust: assert!(v[..8].iter().all(|(_, light)| *light == 7));
    // rust: assert!(v[8..].iter().all(|(_, light)| *light == FULL_BRIGHT));
}

pub fn a_random_variant_glows_with_its_own_overlay_only() void {
}
pub const RANDOM: []const u8 = "assets/minecraft/optifine/random/entity";
    // rust: let atlas = |name: &str| {
    // rust: let u = match name {
    // rust: "entity/silverfish" => 0.0,
    // rust: "entity/silverfish_e" => 0.25,
    // rust: "minecraft:optifine/random/entity/silverfish2" => 0.5,
    // rust: "minecraft:optifine/random/entity/silverfish2_e" => 0.75,
    // rust: _ => return None,
}
    // rust: Some([u, 0.0, u + 0.25, 1.0])
}
    // rust: let seen = || crate::mobs::random_textures::Seen {
    // rust: biome: None,
    // rust: y: 64,
    // rust: blocks: Vec::new(),
    // rust: moon_phase: 0,
    // rust: day_time: 0,
    // rust: weather: horizon_optifine::random::Weather::Clear,
}
    // rust: let props = format!("{RANDOM}/silverfish.properties");
    // rust: let variant = format!("{RANDOM}/silverfish2.png");
    // rust: let variant_e = format!("{RANDOM}/silverfish2_e.png");
    // rust: let base = [
    // rust: "assets/minecraft/textures/entity/silverfish.png",
    // rust: "assets/minecraft/textures/entity/silverfish_e.png",
    // rust: ];
    // rust: for own_overlay in [true, false] {
    // rust: let mut files = vec![base[0], base[1], props.as_str(), variant.as_str()];
    // rust: if own_overlay {
    // rust: files.push(variant_e.as_str());
}
    // rust: let data = data(&files);
    // rust: let mut m = silverfish();
    // rust: {
    // rust: let textures = data.random_textures.read().unwrap();
    // rust: crate::mobs::random_textures::choose(&mut m, &textures, &data, Some(seen()), 0);
}
    // rust: let v = drawn(&m, &data, &atlas);
    // rust: assert!(inside(&v[..4], 0.5), "the variant");
    // rust: if own_overlay {
    // rust: assert_eq!(v.len(), 8);
    // rust: assert!(inside(&v[4..], 0.75), "its own overlay, not silverfish_e");
    // rust: } else {
    // rust: assert_eq!(v.len(), 4, "silverfish_e doesn't glow over silverfish2");
}
}
}

pub fn worn_armour_glows_when_its_extra_layer_says_so() void {
}
    // rust: let m = silverfish();
    // rust: let data = data(&[]);
    // rust: let atlas = |_: &str| Some([0.0, 0.0, 0.5, 0.5]);
    // rust: let part = m.kind.model.clone();
    // rust: let extra = [
    // rust: (part.as_ref(), [0.5, 0.0, 1.0, 0.5], 0xFFFF_FFFF, 0, false),
    // rust: (part.as_ref(), [0.5, 0.5, 1.0, 1.0], 0xFFFF_FFFF, 0, true),
    // rust: ];
    // rust: let mut out = Vec::new();
    // rust: render_with(
    // rust: &m,
    // rust: 0.0,
    // rust: glam::DVec3::ZERO,
    // rust: &atlas,
    // rust: 7,
    // rust: &data,
    // rust: &extra,
    // rust: &mut out,
    // rust: );
    // rust: assert_eq!(out.len(), 12, "body, armour, armour's glow");
    // rust: assert!(out[..8].iter().all(|v| v.light == 7));
    // rust: assert!(out[8..].iter().all(|v| v.light == FULL_BRIGHT));
}
}

    // rust: mod random_texture_tests {
//     use super::*;
//     use crate::mobs::{Polygon, Species};
//     use horizon_optifine::random_textures::RandomTextures;
//     use std::sync::{Arc, RwLock};

    /// A silverfish (drawn with its type's texture) whose model is one quad.
pub fn silverfish() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.species = Species::Silverfish;
    // rust: k.texture = "entity/silverfish".into();
    // rust: k.model = Arc::new(Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![Polygon {
    // rust: normal: [0.0, 0.0, -1.0],
    // rust: cull_back: false,
    // rust: vertices: [
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0],
    // rust: [1.0, 0.0, 0.0, 1.0, 0.0],
    // rust: [1.0, 1.0, 0.0, 1.0, 1.0],
    // rust: [0.0, 1.0, 0.0, 0.0, 1.0],
    // rust: ],
    // rust: }],
    // rust: children: Vec::new(),
    // rust: });
    // rust: Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0)
}

    /// A pack whose silverfish has a second variant, every silverfish wearing it.
pub fn data() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-render-random-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let dir = root.join("assets/minecraft/optifine/random/entity");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join("silverfish.properties"), "textures.1=2").unwrap();
    // rust: std::fs::write(dir.join("silverfish2.png"), "").unwrap();
    // rust: let random = RandomTextures::scan(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: RwLock::new(random),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
}

pub fn uvs(m: *Mob, data: *MobData, atlas: Atlas) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: render_with(m, 0.0, glam::DVec3::ZERO, atlas, 0, data, &[], &mut out);
    // rust: out.iter().map(|v| v.uv).collect()
}

pub fn a_mob_draws_its_variant_and_the_texture_when_the_atlas_lacks_it() void {
}
    // rust: let data = data();
    // rust: let mut m = silverfish();
    // rust: {
    // rust: let textures = data.random_textures.read().unwrap();
    // rust: let seen = crate::mobs::random_textures::Seen {
    // rust: biome: None,
    // rust: y: 64,
    // rust: blocks: Vec::new(),
    // rust: moon_phase: 0,
    // rust: day_time: 0,
    // rust: weather: horizon_optifine::random::Weather::Clear,
}
    // rust: crate::mobs::random_textures::choose(&mut m, &textures, &data, Some(seen), 0);
}
    // rust: let both = |name: &str| match name {
    // rust: "entity/silverfish" => Some([0.0, 0.0, 0.5, 0.5]),
    // rust: "minecraft:optifine/random/entity/silverfish2" => Some([0.5, 0.5, 1.0, 1.0]),
    // rust: _ => None,
}
    // rust: let drawn = uvs(&m, &data, &both);
    // rust: assert_eq!(drawn.len(), 4);
    // rust: assert!(drawn.iter().all(|uv| uv[0] >= 0.5 && uv[1] >= 0.5));
    // rust: let vanilla_only =
    // rust: |name: &str| (name == "entity/silverfish").then_some([0.0, 0.0, 0.5, 0.5]);
    // rust: let drawn = uvs(&m, &data, &vanilla_only);
    // rust: assert_eq!(drawn.len(), 4, "still drawn");
    // rust: assert!(drawn.iter().all(|uv| uv[0] <= 0.5 && uv[1] <= 0.5));
}

    /// `EndermanRenderer.getRenderOffset` moves a creepy enderman by
    /// `0.02 * state.scale` blocks sideways: at `minecraft:scale` 2 the same
    /// gaussian offset doubles, and at the default it is the old 0.02.
pub fn a_scaled_creepy_endermans_render_offset_scales() void {
}
//         use horizon_core::geometry::Vec3;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:enderman".into();
    // rust: kind.species = Species::Enderman;
    // rust: let mut m = Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
        // Enderman.isCreepy: the angry flag that adds the offset.
    // rust: m.extra.flag = true;
    // rust: m.extra.model_scale = 1.0;
    // rust: let one = enderman_render_offset(&m, 0.5);
    // rust: assert!(one.length() > 0.0, "the offset is the renderer's gaussian");
    // rust: m.extra.model_scale = 2.0;
    // rust: let two = enderman_render_offset(&m, 0.5);
    // rust: assert!((two.x - 2.0 * one.x).abs() < 1.0e-12, "{two:?} vs {one:?}");
    // rust: assert!((two.z - 2.0 * one.z).abs() < 1.0e-12, "{two:?} vs {one:?}");
    // rust: assert_eq!(two.y, 0.0);
}

    /// `LivingEntityRenderer.submit` translates a sleeper toward its pillow
    /// before `poseStack.scale(state.scale)`: the bed offset is not scaled and
    /// the pose after it is. The uniform scale after `setupRotations` instead
    /// would leave the pose's own translations unscaled; the one before the
    /// sleeping translation would scale the bed.
pub fn a_scaled_sleepers_bed_offset_is_not_scaled() void {
}
//         use crate::mobs::Species;
//         use horizon_core::geometry::Vec3;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:villager".into();
    // rust: kind.species = Species::Villager;
    // rust: (kind.width, kind.height, kind.eye_height) = (0.6, 1.95, 1.62);
    // rust: let mut m = Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
        // Villager.sleeping: the bed faces north, so the head goes to +z.
    // rust: m.extra.ints[1] = 1;
        // The eye height of the standing pose, as `submit` extracts it.
    // rust: let bed = |m: &Mob| {
    // rust: let eye = m.awake_dims().2 as f32;
    // rust: glam::Vec3::new(0.0, 0.0, eye - 0.1)
}
    // rust: let unscaled = base_transform_at(&m, 0.5, glam::Mat4::IDENTITY);
    // rust: let unscaled_pose = glam::Mat4::from_translation(-bed(&m)) * unscaled;
    // rust: m.extra.model_scale = 2.0;
    // rust: let scaled = base_transform_at(&m, 0.5, glam::Mat4::IDENTITY);
    // rust: let scaled_pose = glam::Mat4::from_translation(-bed(&m)) * scaled;
    // rust: let expected = glam::Mat4::from_scale(glam::Vec3::splat(2.0)) * unscaled_pose;
    // rust: let got = scaled_pose.to_cols_array();
    // rust: let want = expected.to_cols_array();
    // rust: for i in 0..16 {
    // rust: assert!(
    // rust: (got[i] - want[i]).abs() < 1.0e-4,
    // rust: "element {i}: {} != {}\nscaled: {got:?}\nunscaled x2: {want:?}",
    // rust: got[i],
    // rust: want[i]
    // rust: );
}
}

    /// A sleeping avatar's bed offset is `getEyeHeight(Pose.STANDING) - 0.1`,
    /// and the standing eye height carries `minecraft:scale`: at scale 2 the
    /// bed offset is 3.14, not the type's 1.52, and the pose after it doubles.
pub fn a_scaled_sleeping_avatar_uses_its_scaled_eye_height() void {
}
//         use horizon_core::geometry::Vec3;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:player".into();
    // rust: (kind.width, kind.height, kind.eye_height) = (0.6, 1.8, 1.62);
    // rust: let mut m = Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.ints[1] = 1;
    // rust: let bed = |m: &Mob| {
    // rust: let eye = m.kind.eye_height as f32 * m.model_scale();
    // rust: glam::Vec3::new(0.0, 0.0, eye - 0.1)
}
    // rust: let unscaled = base_transform_at(&m, 0.5, glam::Mat4::IDENTITY);
    // rust: let unscaled_pose = glam::Mat4::from_translation(-bed(&m)) * unscaled;
    // rust: m.extra.model_scale = 2.0;
    // rust: let scaled = base_transform_at(&m, 0.5, glam::Mat4::IDENTITY);
    // rust: let scaled_pose = glam::Mat4::from_translation(-bed(&m)) * scaled;
    // rust: let expected = glam::Mat4::from_scale(glam::Vec3::splat(2.0)) * unscaled_pose;
    // rust: let got = scaled_pose.to_cols_array();
    // rust: let want = expected.to_cols_array();
    // rust: for i in 0..16 {
    // rust: assert!(
    // rust: (got[i] - want[i]).abs() < 1.0e-4,
    // rust: "element {i}: {} != {}\nscaled: {got:?}\nunscaled x2: {want:?}",
    // rust: got[i],
    // rust: want[i]
    // rust: );
}
}

    /// The avatar's 0.9375 `AvatarRenderer.scale` and the entity's own
    /// `minecraft:scale` are two factors: at scale 2 the model is 1.875 times
    /// the model's, not 3.75, so the submitted scale is not applied twice.
pub fn an_avatar_at_scale_two_scales_its_model_once() void {
}
//         use horizon_core::geometry::Vec3;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:player".into();
    // rust: let mut m = Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.model_scale = 2.0;
    // rust: let transform = base_transform_at(&m, 0.5, glam::Mat4::IDENTITY);
    // rust: for axis in [glam::Vec3::X, glam::Vec3::Y, glam::Vec3::Z] {
    // rust: let length = transform.transform_vector3(axis).length();
    // rust: assert!(
    // rust: (length - 1.875).abs() < 1.0e-5,
    // rust: "{axis:?} scales by {length}, not 2 * 0.9375"
    // rust: );
}
}
}
