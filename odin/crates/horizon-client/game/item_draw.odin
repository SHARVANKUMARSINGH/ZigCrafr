//! Transpiled from Horizon Rust crate
package horizon_client_item_draw

import "core:fmt"
import "core:mem"
import "core:math"

// Items drawn through the resolved item model pipeline
// (`horizon_client::item_render`): GUI icons (`GuiGraphics.renderItem`),
// dropped items (`ItemEntityRenderer`) and items posed in the world (hands,
// frames, armour stands). This binds the resolver's host services
// (`ItemEnv`) and the special renderers' registries to the game.
// use super::{Dim, Game};
// use horizon_assets::item_model::{
    // rust: Components, DisplayContext, GlobalPos, ItemEnv, LevelState, OwnerState, StackView,
}
// use horizon_client::{
    // rust: block_entity_render::{diffuse_lights, vertex_light},
    // rust: cit::{Hand as CitHand, Kind as CitKind},
    // rust: hud::{HudBatch, Rect},
    // rust: item_render::{self, ItemRenderState, SpecialHost, WorldSink},
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
}
// use horizon_core::geometry::{Aabb, Vec3};
// use serde_json::Value;
// use std::{cell::RefCell, collections::HashMap};

// The game's answers to what the resolver cannot read from the stack.
    // rust: pub(super) struct Env<'a, 'g> {
    // rust: game: &'a Game<'g>,
}
    // rust: impl ItemEnv for Env<'_, '_> {
item_model_property :: proc(self: ^Self, property: string, stack: ^StackView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return false;
}
    // rust: let mut value = false;
    // rust: self.game
    // rust: .native_item_model_property(property, stack, &mut value);
    // rust: value
}
enchantment_in_tag :: proc(self: ^Self, enchantment: string, tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.stations().enchantments.in_tag(tag, enchantment)
}
potion_effect_color :: proc(self: ^Self, contents: ^Value) -> O {
    // Ported from Horizon
    return {}
}
        // `PotionContents.getColorOr`: the effect mix when any effect is visible.
    // rust: let id = contents["potion"].as_str();
    // rust: let effects = id
    // rust: .and_then(horizon_client::brewing::potion)
    // rust: .is_some_and(|p| !p.effects.is_empty());
    // rust: effects.then(|| (0xFF00_0000 | horizon_client::brewing::potion_color(id)) as i32)
}
grass_color :: proc(self: ^Self, temperature: f64, downfall: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.game
    // rust: .pack
    // rust: .item_renderer
    // rust: .grass_color(temperature, downfall)
}
bundle_fullness :: proc(self: ^Self, _stack: ^StackView, components: ^Components) -> f {
    // Ported from Horizon
    return {}
}
        // `BundleContents.weight`: count / max stack size, summed.
    // rust: let Some(items) = components
    // rust: .get("minecraft:bundle_contents")
    // rust: .and_then(Value::as_array)
    // rust: else {
    // rust: return 0.0;
}
    // rust: let prototypes = &self.game.pack.item_renderer.models.prototypes;
    // rust: let mut total = 0.0f64;
    // rust: for item in items {
    // rust: let id = item["id"].as_str().unwrap_or("");
    // rust: let count = item["count"].as_i64().unwrap_or(1) as f64;
    // rust: let max = prototypes
    // rust: .get(id)
    // rust: .and_then(|c| c.get("minecraft:max_stack_size"))
    // rust: .and_then(Value::as_i64)
    // rust: .unwrap_or(1) as f64;
    // rust: total += count / max;
}
    // rust: total as f32
}
has_shift_down :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.has_shift_down()
}
local_time :: proc(self: ^Self, pattern: string, _locale: string, _time_zone: Maybe(string)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: local_time(pattern)
}
random_float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.game.clock.still() {
            // The same draw for a frame of the same world tick.
    // rust: let mixed =
    // rust: (self.game.visual_ticks() ^ 0x9e37_79b9).wrapping_mul(0x9e37_79b9_7f4a_7c15);
    // rust: return (mixed >> 40) as f32 / (1u64 << 24) as f32;
}
    // rust: let nanos = self.game.started.elapsed().subsec_nanos();
    // rust: (nanos % 1_000_000) as f32 / 1_000_000.0
}
}
// The days since 1970-01-01 as a civil (year, month, day) date.
civil :: proc(days: i64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let z = days + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z.rem_euclid(146_097);
    // rust: let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let d = (doy - (153 * mp + 2) / 5 + 1) as u32;
    // rust: let m = if mp < 10 { mp + 3 } else { mp - 9 } as u32;
    // rust: (yoe + era * 400 + i64::from(m <= 2), m, d)
}
// `DateTimeFormatter.ofPattern(pattern).format(now)` for the month, day,
// year and time letters item models use, in the system time zone
// (`LocalTime` without a `time_zone`).
    // rust: pub(super) fn local_time(pattern: &str) -> String {
    // rust: let now = chrono::Local::now();
    // rust: let secs = now.timestamp() + i64::from(now.offset().local_minus_utc());
    // rust: let (y, mo, d) = civil(secs.div_euclid(86_400));
    // rust: let s = secs.rem_euclid(86_400);
    // rust: let (h, mi, se) = (s / 3600, s / 60 % 60, s % 60);
    // rust: let mut out = String::new();
    // rust: let chars: Vec<char> = pattern.chars().collect();
    // rust: let mut i = 0;
    // rust: while i < chars.len() {
    // rust: let c = chars[i];
    // rust: let mut n = 1;
    // rust: while i + n < chars.len() && chars[i + n] == c {
    // rust: n += 1;
}
    // rust: let num = |v: i64| format!("{v:0n$}");
    // rust: match c {
    // rust: 'M' => out += &num(i64::from(mo)),
    // rust: 'd' => out += &num(i64::from(d)),
    // rust: 'y' | 'u' => out += &if n == 2 { num(y % 100) } else { num(y) },
    // rust: 'H' => out += &num(h),
    // rust: 'm' => out += &num(mi),
    // rust: 's' => out += &num(se),
    // rust: '\'' => {
                // Quoted literal text.
    // rust: let end = chars[i + 1..].iter().position(|&x| x == '\'');
    // rust: if let Some(e) = end {
    // rust: out.extend(&chars[i + 1..i + 1 + e]);
    // rust: i += e + 2;
    // rust: continue;
}
    // rust: n = 1;
}
    // rust: other => out.extend(std::iter::repeat_n(other, n)),
}
    // rust: i += n;
}
    // rust: out
}

// Banner and shield pattern textures from the banner pattern registry.
    // rust: pub(super) struct Host<'a> {
    // rust: banners: &'a horizon_client::banner::Banners,
    // rust: sprites: &'a HashMap<String, Rect>,
    // rust: skins: &'a RefCell<horizon_client::skins::Downloader>,
    // rust: profiles: &'a RefCell<horizon_client::skins::Resolver>,
}
    // rust: impl SpecialHost for Host<'_> {
banner_texture :: proc(self: ^Self, pattern: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.banners
    // rust: .pattern(pattern)
    // rust: .map(|_| self.banners.banner_texture(pattern))
}
shield_texture :: proc(self: ^Self, pattern: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.banners
    // rust: .pattern(pattern)
    // rust: .map(|_| self.banners.shield_texture(pattern))
}
player_skin :: proc(self: ^Self, profile: ^Value) -> O {
    // Ported from Horizon
    return {}
}
        // SkullBlockRenderer.getPlayerSkin: SkinManager.getInsecureSkinInformation
        // accepts a texture property without a signature, unlike the tab list.
        // A `Dynamic` profile (a name or id only) resolves through the
        // services (`PlayerSkinRenderCache.getOrDefault`).
    // rust: Some(horizon_client::skins::head_skin(
    // rust: profile,
    // rust: &mut self.profiles.borrow_mut(),
    // rust: &mut self.skins.borrow_mut(),
    // rust: |location| self.sprites.contains_key(location),
    // rust: ))
}
}

// `ItemOwner` of an entity holding or showing an item.
    // rust: pub(super) fn owner_at(position: [f64; 3], yaw: f32, entity_type: &str) -> OwnerState {
    // rust: OwnerState {
    // rust: position,
    // rust: visual_rotation_y_degrees: yaw,
    // rust: entity_type: entity_type.to_owned(),
    // rust: ..Default::default()
}
}
// `UseDuration` of a stack (`Item.getUseDuration`): 72000 for drawn items
// and for `blocks_attacks` items (shields), the consume time for food.
use_duration :: proc(components: ^Components) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(c) = components.get("minecraft:consumable") {
    // rust: let seconds = c["consume_seconds"].as_f64().unwrap_or(1.6);
    // rust: return (seconds * 20.0) as i32;
}
    // rust: if components.get("minecraft:blocks_attacks").is_some()
    // rust: || components.get("minecraft:kinetic_weapon").is_some()
    // rust: {
    // rust: return 72_000;
}
    // rust: let item_model = components
    // rust: .get("minecraft:item_model")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("");
    // rust: match item_model {
    // rust: "minecraft:bow"
    // rust: | "minecraft:crossbow"
    // rust: | "minecraft:trident"
    // rust: | "minecraft:spyglass"
    // rust: | "minecraft:goat_horn" => 72_000,
        // BrushItem.USE_DURATION.
    // rust: "minecraft:brush" => 200,
    // rust: _ => 0,
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn item_env(&self) -> Env<'_, '_> {
    // rust: Env { game: self }
}
    // rust: pub(super) fn item_host(&self) -> Host<'_> {
    // rust: Host {
    // rust: banners: &self.stations().banners,
    // rust: sprites: &self.gui.atlas.sprites,
    // rust: skins: &self.skin_downloads,
    // rust: profiles: &self.skin_profiles,
}
}
    // The client level as item models read it: worked out once a frame (a
    // screen of items read the same level, its sky sampled once).
    // rust: pub(super) fn item_level(&self) -> LevelState {
    // rust: let dimension = match self.dim {
    // rust: Dim::Overworld => "minecraft:overworld",
    // rust: Dim::Nether => "minecraft:the_nether",
    // rust: Dim::End => "minecraft:the_end",
}
    // rust: let key = (
    // rust: self.frames,
    // rust: self.world.game_time,
    // rust: self.world.day_time,
    // rust: dimension,
    // rust: );
    // rust: let mut cached = self.item_level_cache.borrow_mut();
    // rust: if let Some((at, level)) = cached.as_ref()
    // rust: && *at == key
    // rust: {
    // rust: return level.clone();
}
    // rust: let level = self.level_state_now(dimension);
    // rust: *cached = Some((key, level.clone()));
    // rust: level
}
level_state_now :: proc(self: ^Self, dimension: ^'static str) -> L {
    // Ported from Horizon
    return {}
}
    // rust: let sky = self
    // rust: .dim_environment()
    // rust: .sample(self.world.day_time, None, None);
    // rust: LevelState {
    // rust: dimension: dimension.to_owned(),
    // rust: game_time: self.world.game_time,
    // rust: sun_angle: sky.sun_angle,
    // rust: moon_phase: (self.world.day_time.div_euclid(24_000)).rem_euclid(8) as i32,
    // rust: respawn: self.spawn.map(|s| GlobalPos {
    // rust: dimension: "minecraft:overworld".to_owned(),
    // rust: pos: [s.x.floor() as i32, s.y.floor() as i32, s.z.floor() as i32],
    // rust: }),
    // rust: runs_normally: true,
}
}
    // The local player as `ItemOwner`; `stack` is the stack drawn, to tell
    // whether it is the one in use.
    // rust: pub(super) fn player_owner(&self, stack: Option<&ItemStack>) -> OwnerState {
    // rust: let position = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or([0.0; 3], |p| [p.position.x, p.position.y, p.position.z]);
    // rust: let mut owner = owner_at(position, self.yaw, "minecraft:player");
    // rust: owner.main_arm_left = self.settings.main_hand_left;
    // rust: owner.is_local_player = true;
    // rust: owner.is_view_entity = true;
    // rust: owner.last_death_location = self
    // rust: .level
    // rust: .last_death
    // rust: .clone()
    // rust: .map(|(dimension, pos)| GlobalPos { dimension, pos });
    // rust: if let (Some((slot, ticks)), Some(stack)) = (self.using, stack)
    // rust: && self.stack_in(slot) == Some(stack)
    // rust: {
    // rust: let view = item_render::stack_view(stack);
    // rust: let mut duration = use_duration(&self.pack.item_renderer.models.components(&view));
    // rust: self.native_use_duration(stack, &mut duration);
    // rust: owner.using_this_item = true;
    // rust: owner.use_duration = duration;
            // getUseItemRemainingTicks: the duration the use started with,
            // as LivingEntityUseItemEvent.Start and .Tick left it (`game/item_use.rs`).
    // rust: owner.use_item_remaining_ticks = self.use_duration - ticks as i32;
    // rust: owner.crossbow_charge_duration = Self::charge_ticks(stack).max(1) as i32;
}
    // rust: owner.fishing_cast_with_this_item = stack
    // rust: .zip(self.cast_rod())
    // rust: .is_some_and(|(s, rod)| std::ptr::eq(s, rod));
    // rust: owner.is_selected =
    // rust: stack.is_some() && self.inventory.get(self.selected).and_then(Option::as_ref) == stack;
    // rust: owner.is_carried = owner.is_selected;
    // rust: owner
}
    // `ItemModelResolver.updateForTopItem`.
    // rust: pub(super) fn resolve_item(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: display: DisplayContext,
    // rust: owner: Option<&OwnerState>,
    // rust: seed: i32,
    // rust: ) -> ItemRenderState {
    // rust: self.resolve_item_in_hand(stack, display, owner, seed, CitHand::Main)
}
    // `ItemStack.hasFoil`, with the item's default glint.
has_foil :: proc(self: ^Self, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let item_glint = self
    // rust: .res
    // rust: .items()
    // rust: .enchantments
    // rust: .props
    // rust: .get(&*stack.item)
    // rust: .is_some_and(|p| p.glint);
    // rust: stack.has_foil(item_glint)
}
    // [`Self::resolve_item`] of a stack held in `hand`, which OptiFine CIT rules can test
    // (GUI items count as the main hand).
    // rust: pub(super) fn resolve_item_in_hand(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: display: DisplayContext,
    // rust: owner: Option<&OwnerState>,
    // rust: seed: i32,
    // rust: hand: CitHand,
    // rust: ) -> ItemRenderState {
    // rust: let level = self.item_level();
    // rust: let renderer = &self.pack.item_renderer;
    // rust: let (rule, glint) = renderer.cit.as_ref().map_or((None, None), |cit| {
    // rust: let item_max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage);
    // rust: let max_damage = item_render::cit::stack_max_damage(stack, item_max);
    // rust: (
    // rust: cit.rules.select(CitKind::Item, stack, hand, max_damage),
    // rust: cit.rules
    // rust: .glint(stack, hand, max_damage, self.has_foil(stack)),
    // rust: )
    // rust: });
    // rust: let mut state = renderer.resolve_with_rule(
    // rust: &item_render::stack_view(stack),
    // rust: display,
    // rust: owner,
    // rust: Some(&level),
    // rust: seed,
    // rust: &self.item_env(),
    // rust: rule,
    // rust: );
    // rust: if let Some(glint) = glint {
            // The pack's enchantment rules replace vanilla's glint unless one keeps it, so far
            // only in the GUI, where their own layers draw: held, dropped and framed items keep
            // vanilla's until theirs do. The pack's `useGlint=false` removes it everywhere.
    // rust: let gui = display == DisplayContext::Gui;
    // rust: let pack_keeps = renderer
    // rust: .cit
    // rust: .as_ref()
    // rust: .is_none_or(|c| c.rules.global.use_glint);
    // rust: if !glint.vanilla && (gui || !pack_keeps) {
    // rust: for layer in &mut state.layers {
    // rust: layer.foil = horizon_assets::item_model::FoilType::None;
}
}
    // rust: if gui && !glint.is_empty() {
    // rust: state.cit_glint = Some(glint);
}
}
    // rust: state.hdr_tier = self.luminance().hdr_tier(&stack.item);
    // rust: if state.hdr_tier > 0 && self.renderer.as_ref().is_some_and(|r| r.hdr_on()) {
    // rust: state.hdr_light = self.luminance().of(&stack.item);
}
    // rust: state
}
    // `GuiGraphics.renderItem(player, level, stack, x, y, 0)`.
    // rust: pub(super) fn draw_item_model(&self, batch: &mut HudBatch, stack: &ItemStack, x: f32, y: f32) {
    // rust: let owner = self.player_owner(Some(stack));
    // rust: let state = self.resolve_item(stack, DisplayContext::Gui, Some(&owner), 0);
    // rust: item_render::gui::draw(
    // rust: &state,
    // rust: &self.pack.item_renderer,
    // rust: &self.gui.atlas.sprites,
    // rust: &self.item_host(),
    // rust: batch,
    // rust: x,
    // rust: y,
    // rust: self.glint_frame.millis / 1000.0,
    // rust: self.glint_frame.speed,
    // rust: self.glint_frame.alpha,
    // rust: );
}
    // The glint clock, options and sprite for this frame: read once per
    // frame, not per item (`GameRenderer.extractOptions`).
    // rust: pub(super) fn capture_glint_frame(&self) -> item_render::GlintFrame {
    // rust: item_render::GlintFrame {
    // rust: millis: if self.clock.still() {
    // rust: self.visual_millis() as f32
    // rust: } else {
    // rust: self.started.elapsed().as_secs_f32() * 1000.0
    // rust: },
    // rust: speed: self.settings.file.double("glintSpeed") as f32,
    // rust: alpha: self.settings.file.double("glintStrength") as f32,
    // rust: sprite: self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .contains_key("misc/enchanted_glint_item"),
}
}
    // The `ENTITY_GLINT_TEXTURING` inputs of this frame.
    // rust: pub(super) fn glint(&self) -> Option<item_render::Glint> {
    // rust: self.glint_frame.glint(0.5)
}
    // Submit a resolved item under `pose` (camera-relative) at `light`
    // (packed lightmap coordinates).
    // rust: pub(super) fn submit_item_world(
    // rust: &self,
    // rust: state: &ItemRenderState,
    // rust: pose: glam::Mat4,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let lights = diffuse_lights(self.dim == Dim::Nether);
    // rust: self.submit_item_lit(state, pose, light, lights, out);
}
    // [`Self::submit_item_world`] shaded by other diffuse lights (a
    // `Lighting.Entry` other than the level's), in the pose's output space.
    // rust: pub(super) fn submit_item_lit(
    // rust: &self,
    // rust: state: &ItemRenderState,
    // rust: pose: glam::Mat4,
    // rust: light: u32,
    // rust: lights: (glam::Vec3, glam::Vec3),
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let mut sink = WorldSink {
    // rust: out,
    // rust: light: item_hdr_light(state, light),
    // rust: lights: (state.hdr_light == 0).then_some(lights),
    // rust: glint: self.glint(),
    // rust: tier: state.hdr_tier,
}
    // rust: state.submit(
    // rust: &self.pack.item_renderer,
    // rust: &self.gui.atlas.sprites,
    // rust: &self.item_host(),
    // rust: pose,
    // rust: &mut sink,
    // rust: );
}
    // [`Self::submit_item_world`] without the level's diffuse shading.
    // rust: pub(super) fn submit_item_unlit(
    // rust: &self,
    // rust: state: &ItemRenderState,
    // rust: pose: glam::Mat4,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let mut sink = WorldSink {
    // rust: out,
    // rust: light: item_hdr_light(state, light),
    // rust: lights: None,
    // rust: glint: self.glint(),
    // rust: tier: state.hdr_tier,
}
    // rust: state.submit(
    // rust: &self.pack.item_renderer,
    // rust: &self.gui.atlas.sprites,
    // rust: &self.item_host(),
    // rust: pose,
    // rust: &mut sink,
    // rust: );
}
    // [`Self::submit_item_lit`] of `state` under each of `poses` on the GPU path: the mark
    // before its draws and their bounds, or `None` (nothing drawn) when the state cannot
    // take it.
    // rust: pub(super) fn submit_item_skinned(
    // rust: &self,
    // rust: state: &ItemRenderState,
    // rust: poses: &[glam::Mat4],
    // rust: light: u32,
    // rust: lights: (glam::Vec3, glam::Vec3),
    // rust: ) -> Option<((usize, usize, u32), Option<(glam::Vec3, glam::Vec3)>)> {
    // rust: let mut models = self.skin_models.borrow_mut();
    // rust: let mut frame = self.skin_frame.borrow_mut();
    // rust: let mark = frame.mark();
    // rust: let mut skin = horizon_client::mobs::skin::Skin::new(&mut models, &mut frame);
    // rust: for &pose in poses {
    // rust: if !self.skin_item(state, pose, light, lights, &mut skin) {
                // Decided before any draw, the same for every pose.
    // rust: return None;
}
}
    // rust: Some((mark, skin.bounds))
}
    // One pose of [`Self::submit_item_skinned`] into an entity's open
    // `skin` (its bounds grow by the item's): false, with nothing drawn,
    // when the item cannot take the GPU path.
    // rust: pub(super) fn skin_item(
    // rust: &self,
    // rust: state: &ItemRenderState,
    // rust: pose: glam::Mat4,
    // rust: light: u32,
    // rust: lights: (glam::Vec3, glam::Vec3),
    // rust: skin: &mut horizon_client::mobs::skin::Skin,
    // rust: ) -> bool {
    // rust: let sink = (
    // rust: item_hdr_light(state, light),
    // rust: (state.hdr_light == 0).then_some(lights),
    // rust: state.hdr_tier,
    // rust: );
    // rust: let renderer = &self.pack.item_renderer;
    // rust: state.submit_skinned(renderer, &self.gui.atlas.sprites, pose, sink, skin)
}
    // [`Self::submit_item_world`] of `state` under `pose` on the GPU path, its draws counted
    // with an entity's (`skinned`: its mark and bounds, `cull_skinned`'s); false, with
    // nothing drawn, when the state cannot take it.
    // rust: pub(super) fn skin_item_into(
    // rust: &self,
    // rust: state: &ItemRenderState,
    // rust: pose: glam::Mat4,
    // rust: light: u32,
    // rust: skinned: &mut super::creatures::Skinned,
    // rust: ) -> bool {
    // rust: let lights = diffuse_lights(self.dim == Dim::Nether);
    // rust: let Some((mark, bounds)) = self.submit_item_skinned(state, &[pose], light, lights) else {
    // rust: return false;
}
    // rust: *skinned = Some(match skinned.take() {
    // rust: Some((first, before)) => (
    // rust: first,
    // rust: match (before, bounds) {
    // rust: (Some((a, b)), Some((c, d))) => Some((a.min(c), b.max(d))),
    // rust: (one, other) => one.or(other),
    // rust: },
    // rust: ),
    // rust: None => (mark, bounds),
    // rust: });
    // rust: true
}
    // `ItemEntityRenderer.submit` for every dropped item.
    // rust: pub(super) fn dropped_item_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let live = self.dropped.iter().map(|item| {
    // rust: let (p, q) = (item.previous, item.position);
    // rust: let at = [
    // rust: p.x + (q.x - p.x) * alpha,
    // rust: p.y + (q.y - p.y) * alpha,
    // rust: p.z + (q.z - p.z) * alpha,
    // rust: ];
    // rust: (item, at, alpha as f32, true)
    // rust: });
        // ItemPickupParticle: the render state extracted at partial tick 1.
    // rust: let taken = self.pickups.live.iter().filter_map(|p| match &p.taken {
    // rust: super::pickups::Taken::Item(item) => {
    // rust: Some((&**item, super::pickups::position(p, alpha), 1.0, false))
}
    // rust: _ => None,
    // rust: });
        // Entity.shouldRenderAtSqrDistance for the item's 0.25 box: 16 blocks
        // times the view scale (32 at render distance 16), from its current
        // position. A pickup particle is not an entity and keeps 64 blocks.
    // rust: let range =
    // rust: super::entity_culling::default_range(glam::DVec3::splat(0.25), self.view_scale());
    // rust: let skinning = self.skinning();
    // rust: let lights = diffuse_lights(self.dim == Dim::Nether);
    // rust: for (item, at, partial, entity) in live.chain(taken) {
    // rust: let entity_start = out.len();
    // rust: self.mark_motion(entity_start, (2 << 32) | u64::from(item.id));
    // rust: let q = item.position;
    // rust: let pos = glam::DVec3::from_array(at) - camera;
    // rust: let far = if entity {
    // rust: (glam::DVec3::new(q.x, q.y, q.z) - camera).length_squared() >= range * range
    // rust: } else {
    // rust: pos.length_squared() > 64.0 * 64.0
}
    // rust: if far {
    // rust: continue;
}
            // EntityRenderer.shouldRender: the item's 0.25 box, grown by 0.5,
            // in the view frustum. Checked before its model is resolved.
    // rust: if entity && let Some(view) = &self.view_frustum {
    // rust: let feet = (glam::DVec3::new(q.x, q.y, q.z) - camera).as_vec3();
    // rust: let half = glam::Vec3::new(0.125 + 0.5, 0.5, 0.125 + 0.5);
    // rust: let lo = feet - half;
    // rust: let hi = feet + glam::Vec3::new(half.x, 0.25 + 0.5, half.z);
    // rust: if !view.intersects(lo, hi) {
    // rust: continue;
}
}
            // `extractItemGroupRenderState`: GROUND, seeded by the entity id.
    // rust: let owner = owner_at([q.x, q.y, q.z], 0.0, "minecraft:item");
    // rust: let state = self.resolve_item(
    // rust: &item.stack,
    // rust: DisplayContext::Ground,
    // rust: Some(&owner),
    // rust: item.id as i32,
    // rust: );
    // rust: if state.is_empty() {
    // rust: continue;
}
    // rust: let age = item.age as f32 + partial;
    // rust: let (lo, _) = state.bounding_box();
    // rust: let min_offset_y = -lo.y + 0.0625;
    // rust: let bob = (age / 10.0 + item.bob_offset).sin() * 0.1 + 0.1;
    // rust: let spin = item_render::item_spin(age, item.bob_offset);
    // rust: let pose = glam::Mat4::from_translation(pos.as_vec3())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, bob + min_offset_y, 0.0))
    // rust: * glam::Mat4::from_rotation_y(spin);
    // rust: let packed = self.world.light(
    // rust: q.x.floor() as i32,
    // rust: (q.y + 0.1).floor() as i32,
    // rust: q.z.floor() as i32,
    // rust: );
    // rust: let seed = i64::from(self.pack.item_renderer.item_id(&item.stack.item))
    // rust: + i64::from(item.stack.damage);
    // rust: let copies = item_render::cluster_poses(
    // rust: &state,
    // rust: pose,
    // rust: item_render::rendered_amount(item.stack.count),
    // rust: seed,
    // rust: );
            // Use the same animated, spun, clustered transforms as the draw.
            // ItemEntity's collision box is only 0.25 blocks and cannot prove
            // that this larger rendered model stays behind an occluder.
    // rust: let culling = entity.then(|| {
    // rust: state
    // rust: .posed_bounds(&copies)
    // rust: .map(|(lo, hi)| {
    // rust: self.entity_cull_decision_in_bounds(
    // rust: item,
    // rust: Aabb::new(
    // rust: Vec3::new(
    // rust: camera.x + f64::from(lo.x),
    // rust: camera.y + f64::from(lo.y),
    // rust: camera.z + f64::from(lo.z),
    // rust: ),
    // rust: Vec3::new(
    // rust: camera.x + f64::from(hi.x),
    // rust: camera.y + f64::from(hi.y),
    // rust: camera.z + f64::from(hi.z),
    // rust: ),
    // rust: ),
    // rust: )
    // rust: })
    // rust: .unwrap_or_else(|| self.entity_cull_decision(item, f64::from(partial)))
    // rust: });
    // rust: if culling.is_some_and(|decision| decision.hides_entity()) {
    // rust: continue;
}
    // rust: let outline = self.thing_outline(item.id, "minecraft:item");
            // Posed on the GPU when every layer can be, its silhouette too when it glows.
    // rust: let skinned = skinning
    // rust: .then(|| self.submit_item_skinned(&state, &copies, vertex_light(packed), lights))
    // rust: .flatten();
    // rust: if skinned.is_none() {
    // rust: for &copy in &copies {
    // rust: self.submit_item_world(&state, copy, vertex_light(packed), out);
}
}
    // rust: if let Some(rgb) = outline {
    // rust: self.mark_outline(&out[entity_start..], rgb);
    // rust: if let Some(((first, _, _), _)) = skinned {
    // rust: let color = horizon_client::mobs::render::abgr(rgb);
    // rust: self.skin_frame.borrow_mut().outline_since(first, color);
}
    // rust: } else if let Some(culling) = culling {
    // rust: self.finish_entity_occlusion(culling, item, out, entity_start);
    // rust: } else {
    // rust: self.cull_skinned(out, entity_start, skinned);
}
}
}
}

// The packed light of an item (sky low, block above it: `vertex_light`, entity.wgsl), its block
// light raised to what it glows with in HDR output.
item_hdr_light :: proc(state: ^ItemRenderState, light: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let block = ((light >> 8) & 0xff).max(u32::from(state.hdr_light) * 16);
    // rust: (light & !0xff00) | block << 8
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

civil_dates_follow_the_gregorian_calendar :: proc() {
}
    // rust: assert_eq!(civil(0), (1970, 1, 1));
    // rust: assert_eq!(civil(19_716), (2023, 12, 25));
    // rust: assert_eq!(civil(11_016), (2000, 2, 29));
}

a_shield_is_used_for_the_vanilla_s_time :: proc() {
}
        // Item.getUseDuration: an item with `blocks_attacks` (a shield) is
        // used for 72000 ticks, so its use animation (the arm held up)
        // runs instead of ending at once (#2289).
    // rust: let mut shield = Components::new();
    // rust: shield.insert("minecraft:blocks_attacks".into(), json!({}));
    // rust: assert_eq!(use_duration(&shield), 72_000);
        // Food is used for as long as it takes to eat it.
    // rust: let mut food = Components::new();
    // rust: food.insert(
    // rust: "minecraft:consumable".into(),
    // rust: json!({"consume_seconds": 1.6}),
    // rust: );
    // rust: assert_eq!(use_duration(&food), 32);
        // The bow keeps its own use time.
    // rust: let mut bow = Components::new();
    // rust: bow.insert("minecraft:item_model".into(), json!("minecraft:bow"));
    // rust: assert_eq!(use_duration(&bow), 72_000);
        // Anything else is not used at all.
    // rust: assert_eq!(use_duration(&Components::new()), 0);
}
}
