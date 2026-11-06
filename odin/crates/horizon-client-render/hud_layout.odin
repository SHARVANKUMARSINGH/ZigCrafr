//! Transpiled from Horizon Rust crate
package horizon_client_render_hud_layout

import "core:fmt"
import "core:mem"
import "core:math"

// Layout of vanilla's `Hud` as draw calls (`GuiGraphicsExtractor` blits,
// fills and text): the hotbar with its selection, off-hand slot, items and
// attack indicator, the crosshair, armour, hearts, food, air bubbles, mount
// hearts and the experience bar, plus the draw-call types and colour
// helpers the other layouts share (`hud_overlays`, `chat`). Computed without
// drawing so the parity fixture can compare them with the vanilla client.
// use crate::{font::Font, text::Text};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::borrow::Cow;

// A `Matrix3x2fStack` operation applied to a copy of the current pose.
PoseOp :: enum {
    Translate(f32, f32),
    Scale(f32, f32),
}

// A JOML `Matrix3x2f` as `[m00, m01, m10, m11, m20, m21]`.
    // rust: pub type Pose = [f32; 6];
IDENTITY :: [1.0, 0.0, 0.0, 1.0, 0.0, 0.0]

// Applies `op` like JOML's `translate` / `scale` (same float order).
pose_apply :: proc(m: ^Pose, op: PoseOp) {
}
    // rust: match op {
    // rust: PoseOp::Translate(x, y) => {
    // rust: m[4] += m[0] * x + m[2] * y;
    // rust: m[5] += m[1] * x + m[3] * y;
}
    // rust: PoseOp::Scale(x, y) => {
    // rust: m[0] *= x;
    // rust: m[1] *= x;
    // rust: m[2] *= y;
    // rust: m[3] *= y;
}
}
}

// The render pipeline of a texture blit.
Blend :: enum {
    // `GUI_TEXTURED`.
    Textured,
    // `VIGNETTE`: `dst * (1 - src)`.
    Vignette,
    // `GUI_NAUSEA_OVERLAY`: additive.
    Nausea,
    // `CROSSHAIR`: `BlendFunction.INVERT`, the colour under it inverted.
    Crosshair,
}
    // rust: impl Blend {
pipeline :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Blend::Textured => "pipeline/gui_textured",
    // rust: Blend::Vignette => "pipeline/vignette",
    // rust: Blend::Nausea => "pipeline/gui_nausea_overlay",
    // rust: Blend::Crosshair => "pipeline/crosshair",
}
}
}

// One `GuiGraphicsExtractor` call.
GuiDraw :: enum {
    // `blitSprite(pipeline, sprite, x, y, w, h, color)`; `region` =
    // (spriteW, spriteH, u, v) for the partial overload.
    Sprite {,
    sprite: Cow<'static, str>,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    region: Option<[i32; 4]>,
    color: u32,
    blend: Blend,
    // rust: },
    // `blitSprite(pipeline, TextureAtlasSprite, ...)` with a block atlas
    // sprite (the nether portal overlay).
    AtlasSprite {,
    sprite: Cow<'static, str>,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    color: u32,
    // rust: },
    // `blit(pipeline, texture, x, y, u, v, w, h, srcW, srcH, texW, texH,
    // color)`; `texture` is the path under `textures/` without `.png`.
    Blit {,
    texture: Cow<'static, str>,
    blend: Blend,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    uv: [f32; 2],
    src: [i32; 2],
    tex: [i32; 2],
    color: u32,
    // rust: },
    // `fill(x0, y0, x1, y1, color)` with the corners sorted.
    Fill {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    color: u32,
    // rust: },
    // `text(font, text, x, y, argb, dropShadow)`.
    Text {,
    text: Text,
    x: i32,
    y: i32,
    color: u32,
    shadow: bool,
    // rust: },
    // `item(owner, stack, x, y, seed)` for a hotbar slot (0-8, 40 = off hand)
    // under the pose's x/y scale about (cx, cy) (the pop squeeze).
    Item {,
    slot: u32,
    x: i32,
    y: i32,
    seed: i32,
    scale: [f32; 2],
    pivot: [f32; 2],
    // rust: },
    // `pose().pushMatrix()` followed by `ops`.
    Push(Vec<PoseOp>),
    // `pose().popMatrix()`.
    Pop,
}

WHITE :: 0xFFFF_FFFF

sprite :: proc(sprite: ^'static str, x: i32, y: i32, w: i32, h: i32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GuiDraw::Sprite {
    // rust: sprite: Cow::Borrowed(sprite),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: region: None,
    // rust: color: WHITE,
    // rust: blend: Blend::Textured,
}
}
    // rust: fn region(
    // rust: sprite: &'static str,
    // rust: size: [i32; 2],
    // rust: uv: [i32; 2],
    // rust: at: [i32; 2],
    // rust: w: i32,
    // rust: h: i32,
    // rust: ) -> GuiDraw {
    // rust: GuiDraw::Sprite {
    // rust: sprite: Cow::Borrowed(sprite),
    // rust: x: at[0],
    // rust: y: at[1],
    // rust: w,
    // rust: h,
    // rust: region: Some([size[0], size[1], uv[0], uv[1]]),
    // rust: color: WHITE,
    // rust: blend: Blend::Textured,
}
}
// A draw through `RenderPipelines.CROSSHAIR`.
crosshair_blend :: proc(mut d: GuiDraw) -> G {
    // Ported from Horizon
    return {}
}
    // rust: if let GuiDraw::Sprite { blend, .. } = &mut d {
    // rust: *blend = Blend::Crosshair;
}
    // rust: d
}
// `graphics.fill`: the corners are sorted.
fill :: proc(x0: i32, y0: i32, x1: i32, y1: i32, color: u32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GuiDraw::Fill {
    // rust: x0: x0.min(x1),
    // rust: y0: y0.min(y1),
    // rust: x1: x0.max(x1),
    // rust: y1: y0.max(y1),
    // rust: color,
}
}
// `graphics.text`: dropped when fully transparent.
text :: proc(out: ^[dynamic]GuiDraw, text: Text, x: i32, y: i32, color: u32, shadow: bool) {
}
    // rust: if color >> 24 != 0 {
    // rust: out.push(GuiDraw::Text {
    // rust: text,
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: });
}
}
// `Options.getBackgroundColor(float)`: `chat_only` = `backgroundForChatOnly`.
background_color :: proc(chat_only: bool, opacity: f64, default: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let a = if chat_only { default } else { opacity as f32 };
    // rust: color_from_float(a, 0.0, 0.0, 0.0)
}

// `Mth.floor`.
floor :: proc(x: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let i = x as i32;
    // rust: if x < i as f32 { i - 1 } else { i }
}
// `Mth.ceil`.
ceil :: proc(x: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let i = x as i32;
    // rust: if x > i as f32 { i + 1 } else { i }
}
// `ARGB.as8BitChannel`.
as8 :: proc(v: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: floor(v * 255.0) as u32
}
// `ARGB.white(float)`.
white :: proc(alpha: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (as8(alpha) << 24) | 0xFF_FFFF
}
// `ARGB.colorFromFloat`.
color_from_float :: proc(a: f32, r: f32, g: f32, b: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: argb(as8(a), as8(r), as8(g), as8(b))
}
// `ARGB.color(a, r, g, b)`.
argb :: proc(a: u32, r: u32, g: u32, b: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (a & 255) << 24 | (r & 255) << 16 | (g & 255) << 8 | (b & 255)
}
// `ARGB.multiply`.
multiply :: proc(l: u32, r: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if l == WHITE {
    // rust: return r;
}
    // rust: if r == WHITE {
    // rust: return l;
}
    // rust: let c = |s: u32| ((l >> s) & 255) * ((r >> s) & 255) / 255;
    // rust: argb(c(24), c(16), c(8), c(0))
}
// `Mth.lerpDiscrete`.
lerp_discrete :: proc(alpha: f32, p0: i32, p1: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: p0 + floor(alpha * (p1 - p0 - 1) as f32) + i32::from(alpha > 0.0)
}
// `Mth.hsvToArgb`.
hsv_to_argb :: proc(hue: f32, saturation: f32, value: f32, alpha: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let h = (hue * 6.0) as i32 % 6;
    // rust: let f = hue * 6.0 - h as f32;
    // rust: let p = value * (1.0 - saturation);
    // rust: let q = value * (1.0 - f * saturation);
    // rust: let t = value * (1.0 - (1.0 - f) * saturation);
    // rust: let (r, g, b) = match h {
    // rust: 0 => (value, t, p),
    // rust: 1 => (q, value, p),
    // rust: 2 => (p, value, t),
    // rust: 3 => (p, q, value),
    // rust: 4 => (t, p, value),
    // rust: _ => (value, p, q),
}
    // rust: let c = |v: f32| ((v * 255.0) as i32).clamp(0, 255) as u32;
    // rust: argb(alpha, c(r), c(g), c(b))
}
// `Font.width` of styled text.
width :: proc(font: ^Font, t: ^Text) -> i {
    // Ported from Horizon
    return {}
}
    // rust: font.width_text(t) as i32
}

// `Hud.extractItemHotbar` inputs.
HotbarInputs :: struct {
    selected: i32,
    // The main arm is the right one (the off hand sits left of the hotbar).
    right_handed: bool,
    offhand: bool,
    // Pop time minus partial tick (`ItemStack.getPopTime`) per hotbar slot
    // that holds an item, then the off hand.
    slots: [Maybe(f32),
    offhand_pop: f32,
    // `getAttackStrengthScale(0)` when the attack indicator is in HOTBAR mode.
    attack: Maybe(f32),
}

// `Hud.extractItemHotbar`.
hotbar :: proc(w: i32, h: i32, i: ^HotbarInputs) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let center = w / 2;
    // rust: out.push(sprite("hud/hotbar", center - 91, h - 22, 182, 22));
    // rust: out.push(sprite(
    // rust: "hud/hotbar_selection",
    // rust: center - 91 - 1 + i.selected * 20,
    // rust: h - 22 - 1,
    // rust: 24,
    // rust: 23,
    // rust: ));
    // The off hand is opposite the main arm.
    // rust: let offhand_left = i.right_handed;
    // rust: if i.offhand {
    // rust: if offhand_left {
    // rust: out.push(sprite(
    // rust: "hud/hotbar_offhand_left",
    // rust: center - 91 - 29,
    // rust: h - 23,
    // rust: 29,
    // rust: 24,
    // rust: ));
    // rust: } else {
    // rust: out.push(sprite(
    // rust: "hud/hotbar_offhand_right",
    // rust: center + 91,
    // rust: h - 23,
    // rust: 29,
    // rust: 24,
    // rust: ));
}
}
    // rust: let slot = |slot: u32, x: i32, y: i32, seed: i32, pop: f32, out: &mut Vec<GuiDraw>| {
    // rust: let (scale, pivot) = if pop > 0.0 {
    // rust: let squeeze = 1.0 + pop / 5.0;
    // rust: (
    // rust: [1.0 / squeeze, (squeeze + 1.0) / 2.0],
    // rust: [(x + 8) as f32, (y + 12) as f32],
    // rust: )
    // rust: } else {
    // rust: ([1.0, 1.0], [0.0, 0.0])
}
    // rust: out.push(GuiDraw::Item {
    // rust: slot,
    // rust: x,
    // rust: y,
    // rust: seed,
    // rust: scale,
    // rust: pivot,
    // rust: });
}
    // rust: let mut seed = 1;
    // rust: for (n, pop) in i.slots.iter().enumerate() {
    // rust: if let Some(pop) = pop {
    // rust: slot(
    // rust: n as u32,
    // rust: center - 90 + n as i32 * 20 + 2,
    // rust: h - 16 - 3,
    // rust: seed,
    // rust: *pop,
    // rust: &mut out,
    // rust: );
}
    // rust: seed += 1;
}
    // rust: if i.offhand {
    // rust: let x = if offhand_left {
    // rust: center - 91 - 26
    // rust: } else {
    // rust: center + 91 + 10
}
    // rust: slot(40, x, h - 16 - 3, seed, i.offhand_pop, &mut out);
}
    // rust: if let Some(scale) = i.attack
    // rust: && scale < 1.0
    // rust: {
    // rust: let y = h - 20;
    // rust: let x = if offhand_left {
    // rust: center + 91 + 6
    // rust: } else {
    // rust: center - 91 - 22
}
    // rust: let progress = (scale * 19.0) as i32;
    // rust: out.push(sprite(
    // rust: "hud/hotbar_attack_indicator_background",
    // rust: x,
    // rust: y,
    // rust: 18,
    // rust: 18,
    // rust: ));
    // rust: out.push(region(
    // rust: "hud/hotbar_attack_indicator_progress",
    // rust: [18, 18],
    // rust: [0, 18 - progress],
    // rust: [x, y + 18 - progress],
    // rust: 18,
    // rust: progress,
    // rust: ));
}
    // rust: out
}

// `Hud.extractCrosshair`'s full attack indicator: at full strength on a
// living, alive `crosshairPickEntity` (`target`) with a weapon slower than
// `MIN_CROSSHAIR_ATTACK_SPEED` (`delay` is
// `getCurrentItemAttackStrengthDelay`).
full_attack_indicator :: proc(scale: f32, delay: f32, target: Maybe(bool)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: scale >= 1.0 && delay > 5.0 && target == Some(true)
}

// `Hud.extractCrosshair` (first person, not hidden for spectators), every
// sprite through the inverting `CROSSHAIR` pipeline: `attack` is
// `getAttackStrengthScale(0)` in CROSSHAIR indicator mode and `full`
// whether the full indicator shows ([`full_attack_indicator`]).
crosshair :: proc(w: i32, h: i32, attack: Maybe(f32), full: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: crosshair_draws(w, h, attack, full)
    // rust: .into_iter()
    // rust: .map(crosshair_blend)
    // rust: .collect()
}
crosshair_draws :: proc(w: i32, h: i32, attack: Maybe(f32), full: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![sprite("hud/crosshair", (w - 15) / 2, (h - 15) / 2, 15, 15)];
    // rust: if let Some(scale) = attack {
    // rust: let (x, y) = (w / 2 - 8, h / 2 - 7 + 16);
    // rust: if full {
    // rust: out.push(sprite("hud/crosshair_attack_indicator_full", x, y, 16, 16));
    // rust: } else if scale < 1.0 {
    // rust: let progress = (scale * 17.0) as i32;
    // rust: out.push(sprite(
    // rust: "hud/crosshair_attack_indicator_background",
    // rust: x,
    // rust: y,
    // rust: 16,
    // rust: 4,
    // rust: ));
    // rust: out.push(region(
    // rust: "hud/crosshair_attack_indicator_progress",
    // rust: [16, 4],
    // rust: [0, 0],
    // rust: [x, y],
    // rust: progress,
    // rust: 4,
    // rust: ));
}
}
    // rust: out
}

// `ExperienceBar.extractBackground` and `ContextualBar.extractExperienceLevel`;
// `width` measures text with the font.
    // rust: pub fn experience(
    // rust: w: i32,
    // rust: h: i32,
    // rust: progress: f32,
    // rust: level: i32,
    // rust: bar: bool,
    // rust: width: &dyn Fn(&str) -> i32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: if bar {
    // rust: let (left, top) = (w / 2 - 91, h - 32 + 3);
    // rust: let filled = (progress * 183.0) as i32;
    // rust: out.push(sprite("hud/experience_bar_background", left, top, 182, 5));
    // rust: if filled > 0 {
    // rust: out.push(region(
    // rust: "hud/experience_bar_progress",
    // rust: [182, 5],
    // rust: [0, 0],
    // rust: [left, top],
    // rust: filled,
    // rust: 5,
    // rust: ));
}
}
    // rust: if level > 0 {
    // rust: let text = level.to_string();
    // rust: let x = (w - width(&text)) / 2;
    // rust: let y = h - 24 - 9 - 2;
    // rust: for (dx, dy) in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
    // rust: self::text(
    // rust: &mut out,
    // rust: Text::literal(&text),
    // rust: x + dx,
    // rust: y + dy,
    // rust: 0xFF00_0000,
    // rust: false,
    // rust: );
}
    // rust: self::text(&mut out, Text::literal(text), x, y, 0xFF80_FF20, false);
}
    // rust: out
}

HeartKind :: enum {
    Normal,
    Poisoned,
    Withered,
    Frozen,
}

// State kept between frames (`Hud.lastHealth`, `displayHealth`, ...).
HealthHud :: struct {
    last_health: i32,
    display_health: i32,
    // `Util.getMillis()` of the last health change.
    last_health_time: i64,
    health_blink_time: i64,
    // `Hud.leftHeight` and `rightHeight` once the health, armor, food, mount
    // and air layers have run; the selected item name and the action bar sit
    // above them.
    left_height: i32,
    right_height: i32,
    // `Hud.lastBubblePopSoundPlayed`.
    last_bubble_pop_sound: i32,
    // The `ui.hud.bubble_pop` volume and pitch `playAirBubblePoppedSound`
    // asked for this frame; the caller plays it and clears it.
    bubble_pop_sound: Option<(f32,
}

HealthInputs :: struct {
    // `Hud.tickCount`.
    tick: i32,
    // `Util.getMillis()` now.
    millis: i64,
    health: f32,
    max_health: f32,
    absorption: f32,
    armor: i32,
    food: i32,
    saturation: f32,
    kind: HeartKind,
    regeneration: bool,
    hunger: bool,
    hardcore: bool,
    // `damageCooldownTime > 0`.
    damage_cooldown: bool,
    // `getAirSupply`, `getMaxAirSupply`, `isEyeInFluid(WATER)`.
    air: i32,
    max_air: i32,
    under_water: bool,
    // `getVehicleMaxHearts` of the ridden living vehicle (0 = none).
    vehicle_hearts: i32,
}

// `Hud.getVehicleMaxHearts` for a vehicle that shows its health.
vehicle_max_hearts :: proc(max_health: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (((max_health + 0.5) as i32) / 2).min(30)
}

// `Hud.extractVehicleHealth`.
vehicle_health :: proc(w: i32, h: i32, hearts: i32, health: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let current = f64::from(health).ceil() as i32;
    // rust: let x_right = w / 2 + 91;
    // rust: let mut yo = h - 39;
    // rust: let mut hearts = hearts;
    // rust: let mut base = 0;
    // rust: while hearts > 0 {
    // rust: let row = hearts.min(10);
    // rust: hearts -= row;
    // rust: for i in 0..row {
    // rust: let xo = x_right - i * 8 - 9;
    // rust: out.push(sprite("hud/heart/vehicle_container", xo, yo, 9, 9));
    // rust: if i * 2 + 1 + base < current {
    // rust: out.push(sprite("hud/heart/vehicle_full", xo, yo, 9, 9));
}
    // rust: if i * 2 + 1 + base == current {
    // rust: out.push(sprite("hud/heart/vehicle_half", xo, yo, 9, 9));
}
}
    // rust: yo -= 10;
    // rust: base += 20;
}
    // rust: out
}

    // rust: fn heart(
    // rust: kind: Option<HeartKind>,
    // rust: absorbing: bool,
    // rust: hardcore: bool,
    // rust: half: bool,
    // rust: blink: bool,
    // rust: ) -> &'static str {
    // Hud.HeartType sprites: [full, full_blinking, half, half_blinking] x [normal, hardcore].
    // rust: let table: [&'static str; 8] = match (kind, absorbing) {
    // rust: (None, _) => [
    // rust: "hud/heart/container",
    // rust: "hud/heart/container_blinking",
    // rust: "hud/heart/container",
    // rust: "hud/heart/container_blinking",
    // rust: "hud/heart/container_hardcore",
    // rust: "hud/heart/container_hardcore_blinking",
    // rust: "hud/heart/container_hardcore",
    // rust: "hud/heart/container_hardcore_blinking",
    // rust: ],
    // rust: (_, true) => [
    // rust: "hud/heart/absorbing_full",
    // rust: "hud/heart/absorbing_full_blinking",
    // rust: "hud/heart/absorbing_half",
    // rust: "hud/heart/absorbing_half_blinking",
    // rust: "hud/heart/absorbing_hardcore_full",
    // rust: "hud/heart/absorbing_hardcore_full_blinking",
    // rust: "hud/heart/absorbing_hardcore_half",
    // rust: "hud/heart/absorbing_hardcore_half_blinking",
    // rust: ],
    // rust: (Some(HeartKind::Normal), _) => [
    // rust: "hud/heart/full",
    // rust: "hud/heart/full_blinking",
    // rust: "hud/heart/half",
    // rust: "hud/heart/half_blinking",
    // rust: "hud/heart/hardcore_full",
    // rust: "hud/heart/hardcore_full_blinking",
    // rust: "hud/heart/hardcore_half",
    // rust: "hud/heart/hardcore_half_blinking",
    // rust: ],
    // rust: (Some(HeartKind::Poisoned), _) => [
    // rust: "hud/heart/poisoned_full",
    // rust: "hud/heart/poisoned_full_blinking",
    // rust: "hud/heart/poisoned_half",
    // rust: "hud/heart/poisoned_half_blinking",
    // rust: "hud/heart/poisoned_hardcore_full",
    // rust: "hud/heart/poisoned_hardcore_full_blinking",
    // rust: "hud/heart/poisoned_hardcore_half",
    // rust: "hud/heart/poisoned_hardcore_half_blinking",
    // rust: ],
    // rust: (Some(HeartKind::Withered), _) => [
    // rust: "hud/heart/withered_full",
    // rust: "hud/heart/withered_full_blinking",
    // rust: "hud/heart/withered_half",
    // rust: "hud/heart/withered_half_blinking",
    // rust: "hud/heart/withered_hardcore_full",
    // rust: "hud/heart/withered_hardcore_full_blinking",
    // rust: "hud/heart/withered_hardcore_half",
    // rust: "hud/heart/withered_hardcore_half_blinking",
    // rust: ],
    // rust: (Some(HeartKind::Frozen), _) => [
    // rust: "hud/heart/frozen_full",
    // rust: "hud/heart/frozen_full_blinking",
    // rust: "hud/heart/frozen_half",
    // rust: "hud/heart/frozen_half_blinking",
    // rust: "hud/heart/frozen_hardcore_full",
    // rust: "hud/heart/frozen_hardcore_full_blinking",
    // rust: "hud/heart/frozen_hardcore_half",
    // rust: "hud/heart/frozen_hardcore_half_blinking",
    // rust: ],
}
    // rust: table[usize::from(hardcore) * 4 + usize::from(half) * 2 + usize::from(blink)]
}

    // rust: impl HealthHud {
    // `Hud.extractPlayerHealth` for a screen of `w` x `h` GUI pixels.
layout :: proc(self: ^Self, i: ^HealthInputs, w: i32, h: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let tick = i64::from(i.tick);
    // rust: let current = ceil(i.health);
    // rust: let blink = self.health_blink_time > tick && (self.health_blink_time - tick) / 3 % 2 == 1;
    // rust: if current < self.last_health && i.damage_cooldown {
    // rust: self.last_health_time = i.millis;
    // rust: self.health_blink_time = tick + 20;
    // rust: } else if current > self.last_health && i.damage_cooldown {
    // rust: self.last_health_time = i.millis;
    // rust: self.health_blink_time = tick + 10;
}
    // rust: if i.millis - self.last_health_time > 1000 {
    // rust: self.display_health = current;
    // rust: self.last_health_time = i.millis;
}
    // rust: self.last_health = current;
    // rust: let old = self.display_health;
    // rust: let mut random = LegacyRandom::new(i64::from(i.tick.wrapping_mul(312_871)));
    // rust: let mut next = |bound: i32| random.next_int_bound(bound).unwrap_or(0);
    // rust: let (x_left, x_right, y_base) = (w / 2 - 91, w / 2 + 91, h - 39);
    // rust: let max_health = i.max_health.max(old.max(current) as f32);
    // rust: let absorption = ceil(i.absorption);
    // rust: let rows = ceil((max_health + absorption as f32) / 2.0 / 10.0);
    // rust: let row_height = (10 - (rows - 2)).max(3);
    // rust: let mut y_air = y_base - 10;
    // rust: self.left_height = 39 + (rows - 1) * row_height + 10 + if i.armor > 0 { 10 } else { 0 };
        // The mount's heart rows (`extractVehicleHealth`); food adds its row below.
    // rust: self.right_height = 39 + 10 * ((i.vehicle_hearts + 9) / 10);
    // rust: let offset_index = if i.regeneration {
    // rust: i.tick % ceil(max_health + 5.0)
    // rust: } else {
    // rust: -1
}
    // rust: if i.armor > 0 {
    // rust: let y = y_base - (rows - 1) * row_height - 10;
    // rust: for n in 0..10 {
    // rust: let x = x_left + n * 8;
    // rust: if n * 2 + 1 < i.armor {
    // rust: out.push(sprite("hud/armor_full", x, y, 9, 9));
}
    // rust: if n * 2 + 1 == i.armor {
    // rust: out.push(sprite("hud/armor_half", x, y, 9, 9));
}
    // rust: if n * 2 + 1 > i.armor {
    // rust: out.push(sprite("hud/armor_empty", x, y, 9, 9));
}
}
}
    // rust: let containers = f64::from(max_health / 2.0).ceil() as i32;
    // rust: let absorb_containers = (f64::from(absorption) / 2.0).ceil() as i32;
    // rust: for c in (0..containers + absorb_containers).rev() {
    // rust: let (row, column) = (c / 10, c % 10);
    // rust: let x = x_left + column * 8;
    // rust: let mut y = y_base - row * row_height;
    // rust: if current + absorption <= 4 {
    // rust: y += next(2);
}
    // rust: if c < containers && c == offset_index {
    // rust: y -= 2;
}
    // rust: out.push(sprite(
    // rust: heart(None, false, i.hardcore, false, blink),
    // rust: x,
    // rust: y,
    // rust: 9,
    // rust: 9,
    // rust: ));
    // rust: let halves = c * 2;
    // rust: if c >= containers {
    // rust: let ah = halves - containers * 2;
    // rust: if ah < absorption {
    // rust: let withered = i.kind == HeartKind::Withered;
    // rust: let name = heart(
    // rust: Some(i.kind),
    // rust: !withered,
    // rust: i.hardcore,
    // rust: ah + 1 == absorption,
    // rust: false,
    // rust: );
    // rust: out.push(sprite(name, x, y, 9, 9));
}
}
    // rust: if blink && halves < old {
    // rust: let name = heart(Some(i.kind), false, i.hardcore, halves + 1 == old, true);
    // rust: out.push(sprite(name, x, y, 9, 9));
}
    // rust: if halves < current {
    // rust: let name = heart(
    // rust: Some(i.kind),
    // rust: false,
    // rust: i.hardcore,
    // rust: halves + 1 == current,
    // rust: false,
    // rust: );
    // rust: out.push(sprite(name, x, y, 9, 9));
}
}
    // rust: if i.vehicle_hearts == 0 {
    // rust: let (empty, half, full) = if i.hunger {
    // rust: (
    // rust: "hud/food_empty_hunger",
    // rust: "hud/food_half_hunger",
    // rust: "hud/food_full_hunger",
    // rust: )
    // rust: } else {
    // rust: ("hud/food_empty", "hud/food_half", "hud/food_full")
}
    // rust: for n in 0..10 {
    // rust: let mut y = y_base;
    // rust: if i.saturation <= 0.0 && i.tick % (i.food * 3 + 1) == 0 {
    // rust: y += next(3) - 1;
}
    // rust: let x = x_right - n * 8 - 9;
    // rust: out.push(sprite(empty, x, y, 9, 9));
    // rust: if n * 2 + 1 < i.food {
    // rust: out.push(sprite(full, x, y, 9, 9));
}
    // rust: if n * 2 + 1 == i.food {
    // rust: out.push(sprite(half, x, y, 9, 9));
}
}
    // rust: y_air -= 10;
    // rust: self.right_height += 10;
}
        // Hud.extractAirBubbles.
    // rust: let max_air = i.max_air.max(1);
    // rust: let air = i.air.clamp(0, max_air);
    // rust: if i.under_water || air < max_air {
    // rust: self.right_height += 10;
    // rust: let rows = (f64::from(i.vehicle_hearts) / 10.0).ceil() as i32;
    // rust: let y = y_air - (rows - 1) * 10;
    // rust: let bubble = |offset: i32| ceil(((air + offset) * 10) as f32 / max_air as f32);
    // rust: let full = bubble(-2);
    // rust: let popping = bubble(0);
    // rust: let delay = i32::from(air != 0 && i.under_water);
    // rust: let empty = 10 - bubble(delay);
    // rust: if !i.under_water {
    // rust: self.last_bubble_pop_sound = 0;
}
    // rust: for b in 1..=10 {
    // rust: let x = x_right - (b - 1) * 8 - 9;
    // rust: if b <= full {
    // rust: out.push(sprite("hud/air", x, y, 9, 9));
    // rust: } else if full != popping && b == popping && i.under_water {
    // rust: out.push(sprite("hud/air_bursting", x, y, 9, 9));
                    // Hud.playAirBubblePoppedSound.
    // rust: if self.last_bubble_pop_sound != b {
    // rust: let volume = 0.5 + 0.1 * (empty - 3 + 1).max(0) as f32;
    // rust: let pitch = 1.0 + 0.1 * (empty - 5 + 1).max(0) as f32;
    // rust: self.bubble_pop_sound = Some((volume, pitch));
    // rust: self.last_bubble_pop_sound = b;
}
    // rust: } else if b > 10 - empty {
    // rust: let wobble = if empty == 10 && i.tick % 2 == 0 {
    // rust: next(2)
    // rust: } else {
    // rust: 0
}
    // rust: out.push(sprite("hud/air_empty", x, y + wobble, 9, 9));
}
}
}
    // rust: out
}
}

// Draws the calls with the HUD batch under their poses; items are left to
// the caller (they need the item renderer) and so are the vignette and
// nausea blits (their blending needs the screen-effect pipeline).
paint :: proc(batch: ^crate::hud::HudBatch, atlas: ^crate::hud::HudAtlas, draws: ^[GuiDraw]) {
}
    // rust: let mut stack = vec![IDENTITY];
    // One buffer for the sprite keys, instead of a string per drawn sprite.
    // rust: let mut name = String::new();
    // rust: for d in draws {
    // rust: let start = batch.vertices.len();
    // rust: let pose = *stack.last().unwrap_or(&IDENTITY);
    // rust: match d {
    // rust: GuiDraw::Sprite {
    // rust: sprite,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: region,
    // rust: color,
    // rust: blend,
    // rust: } => {
                // Effect sprites belong to the mob_effect atlas directory (a
                // content mod's under its namespace); the other blitSprite
                // ids refer to GUI sprites.
    // rust: name.clear();
    // rust: let effect = sprite.starts_with("mob_effect/")
    // rust: || sprite
    // rust: .split_once(':')
    // rust: .is_some_and(|(_, path)| path.starts_with("mob_effect/"));
    // rust: if !effect {
    // rust: name.push_str("gui/sprites/");
}
    // rust: name.push_str(sprite);
    // rust: let found = match effect {
    // rust: true => atlas.sprite_or_missing(&name),
    // rust: false => atlas.sprites.get(name.as_str()).copied(),
}
    // rust: let Some(mut r) = found else {
    // rust: continue;
}
    // rust: if let Some([sw, sh, u, v]) = *region {
    // rust: let (du, dv) = (r.u1 - r.u0, r.v1 - r.v0);
    // rust: let u0 = r.u0 + du * u as f32 / sw as f32;
    // rust: let v0 = r.v0 + dv * v as f32 / sh as f32;
    // rust: r.u1 = u0 + du * *w as f32 / sw as f32;
    // rust: r.v1 = v0 + dv * *h as f32 / sh as f32;
    // rust: r.u0 = u0;
    // rust: r.v0 = v0;
}
    // rust: batch.rect_uv(*x as f32, *y as f32, *w as f32, *h as f32, r, abgr(*color));
    // rust: if *blend == Blend::Crosshair {
    // rust: batch.invert_since(start);
}
}
    // rust: GuiDraw::AtlasSprite {
    // rust: sprite,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: color,
    // rust: } => {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: sprite,
    // rust: *x as f32,
    // rust: *y as f32,
    // rust: *w as f32,
    // rust: *h as f32,
    // rust: abgr(*color),
    // rust: );
}
    // rust: GuiDraw::Blit {
    // rust: texture,
    // rust: blend: Blend::Textured,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: uv,
    // rust: src,
    // rust: tex,
    // rust: color,
    // rust: } => {
    // rust: let Some(mut r) = atlas.sprites.get(texture.as_ref()).copied() else {
    // rust: continue;
}
    // rust: let (du, dv) = (r.u1 - r.u0, r.v1 - r.v0);
    // rust: let u0 = r.u0 + du * uv[0] / tex[0] as f32;
    // rust: let v0 = r.v0 + dv * uv[1] / tex[1] as f32;
    // rust: r.u1 = r.u0 + du * (uv[0] + src[0] as f32) / tex[0] as f32;
    // rust: r.v1 = r.v0 + dv * (uv[1] + src[1] as f32) / tex[1] as f32;
    // rust: r.u0 = u0;
    // rust: r.v0 = v0;
    // rust: batch.rect_uv(*x as f32, *y as f32, *w as f32, *h as f32, r, abgr(*color));
}
    // rust: GuiDraw::Blit { .. } | GuiDraw::Item { .. } => {}
    // rust: GuiDraw::Fill {
    // rust: x0,
    // rust: y0,
    // rust: x1,
    // rust: y1,
    // rust: color,
    // rust: } => {
    // rust: batch.fill(
    // rust: atlas,
    // rust: *x0 as f32,
    // rust: *y0 as f32,
    // rust: (x1 - x0) as f32,
    // rust: (y1 - y0) as f32,
    // rust: abgr(*color),
    // rust: );
}
    // rust: GuiDraw::Text {
    // rust: text,
    // rust: x,
    // rust: y,
    // rust: color,
    // rust: shadow,
    // rust: } => {
    // rust: batch.text_styled(atlas, text, *x as f32, *y as f32, abgr(*color), *shadow);
}
    // rust: GuiDraw::Push(ops) => {
    // rust: let mut m = pose;
    // rust: for op in ops {
    // rust: pose_apply(&mut m, *op);
}
    // rust: stack.push(m);
}
    // rust: GuiDraw::Pop => {
    // rust: if stack.len() > 1 {
    // rust: stack.pop();
}
}
}
    // rust: if pose != IDENTITY {
    // rust: for v in &mut batch.vertices[start..] {
    // rust: let [x, y] = v.pos;
    // rust: v.pos = [
    // rust: pose[0] * x + pose[2] * y + pose[4],
    // rust: pose[1] * x + pose[3] * y + pose[5],
    // rust: ];
}
}
}
}

// An ARGB colour as the HUD batch's packed RGBA.
abgr :: proc(color: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let [a, r, g, b] = color.to_be_bytes();
    // rust: crate::hud::rgba(r, g, b, a)
}
