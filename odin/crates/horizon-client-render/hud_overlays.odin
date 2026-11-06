//! Transpiled from Horizon Rust crate
package horizon_client_render_hud_overlays

import "core:fmt"
import "core:mem"
import "core:math"

// The `Hud` overlays laid out as [`GuiDraw`] calls like
// [`crate::hud_layout`]: status effect icons (`extractEffects`), titles and
// the action bar (`extractTitle`, `extractOverlayMessage` and the title
// timers of `Hud.tick`), the selected item name (`extractSelectedItemName`
// and its `toolHighlightTimer`), boss bars (`BossHealthOverlay`), the jump
// bar (`JumpableVehicleBar`), the scoreboard sidebar, item decorations
// (`GuiGraphicsExtractor.itemDecorations`), the camera overlays, the
// sleep overlay and the subtitles (`SubtitleOverlay`).
// use crate::{
    // rust: font::Font,
    // rust: hud_layout::{
    // rust: Blend, GuiDraw, PoseOp, color_from_float, fill, hsv_to_argb, multiply, white, width,
    // rust: },
    // rust: text::{Style, Text},
}
// use std::{borrow::Cow, cmp::Ordering};

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

// `graphics.textWithBackdrop`; `background` is `Options.getBackgroundColor(0.0F)`.
    // rust: pub fn text_with_backdrop(
    // rust: out: &mut Vec<GuiDraw>,
    // rust: t: Text,
    // rust: x: i32,
    // rust: y: i32,
    // rust: w: i32,
    // rust: color: u32,
    // rust: background: u32,
    // rust: ) {
    // rust: if background != 0 {
    // rust: out.push(fill(
    // rust: x - 2,
    // rust: y - 2,
    // rust: x + w + 2,
    // rust: y + 9 + 2,
    // rust: multiply(background, color),
    // rust: ));
}
    // rust: text(out, t, x, y, color, true);
}

// `Arrays.sort(T[], Comparator)` for the short arrays the HUD sorts: Java's
// TimSort below `MIN_MERGE` (a natural run, then binary insertion), which
// matters when the comparator is not a total order. Longer arrays fall back
// to a stable sort.
    // rust: pub fn java_sort<T>(a: &mut [T], cmp: impl Fn(&T, &T) -> Ordering) {
    // rust: let n = a.len();
    // rust: if n < 2 {
    // rust: return;
}
    // rust: if n >= 32 {
    // rust: a.sort_by(cmp);
    // rust: return;
}
    // countRunAndMakeAscending.
    // rust: let mut run = 2;
    // rust: if cmp(&a[1], &a[0]) == Ordering::Less {
    // rust: while run < n && cmp(&a[run], &a[run - 1]) == Ordering::Less {
    // rust: run += 1;
}
    // rust: a[..run].reverse();
    // rust: } else {
    // rust: while run < n && cmp(&a[run], &a[run - 1]) != Ordering::Less {
    // rust: run += 1;
}
}
    // binarySort.
    // rust: for start in run..n {
    // rust: let (mut left, mut right) = (0, start);
    // rust: while left < right {
    // rust: let mid = (left + right) / 2;
    // rust: if cmp(&a[start], &a[mid]) == Ordering::Less {
    // rust: right = mid;
    // rust: } else {
    // rust: left = mid + 1;
}
}
    // rust: a[left..=start].rotate_right(1);
}
}

// A `MobEffectInstance` as `extractEffects` sees it.
EffectIcon :: struct {
    // The effect id: vanilla's without namespace (`speed`), a mod's `<ns>:<path>`.
    id: string,
    // `MobEffect.isBeneficial`.
    beneficial: bool,
    // `MobEffect.getColor`.
    color: i32,
    ambient: bool,
    // Remaining ticks, -1 for infinite.
    duration: i32,
    show_icon: bool,
}

    // rust: impl From<&crate::effects::EffectInstance> for EffectIcon {
from :: proc(effect: ^crate::effects::EffectInstance) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let def = horizon_client_core::potions::effect(effect.id);
    // rust: Self {
    // rust: id: effect.id.to_owned(),
    // rust: beneficial: def
    // rust: .is_some_and(|d| d.category == horizon_client_core::potions::Category::Beneficial),
    // rust: color: def.map_or(0, |d| d.color as i32),
    // rust: ambient: effect.ambient,
    // rust: duration: effect.duration,
            // Horizon keeps no showIcon flag: every effect shows its icon.
    // rust: show_icon: true,
}
}
}

// `MobEffectInstance.compareTo`.
    // rust: pub(crate) fn compare_effects(a: &EffectIcon, o: &EffectIcon) -> Ordering {
    // rust: if (a.duration <= 32147 || o.duration <= 32147) && !(a.ambient && o.ambient) {
    // rust: a.ambient
    // rust: .cmp(&o.ambient)
    // rust: .then((a.duration == -1).cmp(&(o.duration == -1)))
    // rust: .then(a.duration.cmp(&o.duration))
    // rust: .then(a.color.cmp(&o.color))
    // rust: } else {
    // rust: a.ambient.cmp(&o.ambient).then(a.color.cmp(&o.color))
}
}

// `Hud.extractEffects`: `effects` in `getActiveEffects` order; `demo` moves
// the icons below the demo timer.
effects :: proc(w: i32, demo: bool, effects: ^[EffectIcon]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut sorted: Vec<&EffectIcon> = effects.iter().collect();
    // Ordering.natural().reverse().sortedCopy.
    // rust: java_sort(&mut sorted, |a, b| compare_effects(b, a));
    // rust: let (mut beneficial, mut harmful) = (0, 0);
    // rust: for e in sorted.into_iter().filter(|e| e.show_icon) {
    // rust: let mut x = w;
    // rust: let mut y = 1 + if demo { 15 } else { 0 };
    // rust: if e.beneficial {
    // rust: beneficial += 1;
    // rust: x -= 25 * beneficial;
    // rust: } else {
    // rust: harmful += 1;
    // rust: x -= 25 * harmful;
    // rust: y += 26;
}
    // rust: let mut alpha = 1.0f32;
    // rust: let background = if e.ambient {
    // rust: "hud/effect_background_ambient"
    // rust: } else {
    // rust: if e.duration != -1 && e.duration <= 200 {
    // rust: let remaining = e.duration;
    // rust: let used = 10 - remaining / 20;
    // rust: alpha = (remaining as f32 / 10.0 / 5.0 * 0.5).clamp(0.0, 0.5)
    // rust: + horizon_core::geometry::trig::cos(f64::from(
    // rust: remaining as f32 * std::f32::consts::PI / 5.0,
    // rust: )) * (used as f32 / 10.0 * 0.25).clamp(0.0, 0.25);
    // rust: alpha = alpha.clamp(0.0, 1.0);
}
    // rust: "hud/effect_background"
}
    // rust: out.push(GuiDraw::Sprite {
    // rust: sprite: Cow::Borrowed(background),
    // rust: x,
    // rust: y,
    // rust: w: 24,
    // rust: h: 24,
    // rust: region: None,
    // rust: color: crate::hud_layout::WHITE,
    // rust: blend: crate::hud_layout::Blend::Textured,
    // rust: });
    // rust: out.push(GuiDraw::Sprite {
    // rust: sprite: Cow::Owned(horizon_client_core::potions::sprite(&e.id)),
    // rust: x: x + 3,
    // rust: y: y + 3,
    // rust: w: 18,
    // rust: h: 18,
    // rust: region: None,
    // rust: color: white(alpha),
    // rust: blend: crate::hud_layout::Blend::Textured,
    // rust: });
}
    // rust: out
}

// The saving indicator: `Hud.tickAutosaveIndicator` fades a value towards 1
// while the server is saving and `extractSavingIndicator` draws the text.
SavingIndicator :: struct {
    last: f32,
    value: f32,
}
    // rust: impl SavingIndicator {
    // `Hud.tickAutosaveIndicator`: `Mth.lerp(0.2F, value, saving ? 1 : 0)`.
tick :: proc(self: ^Self, saving: bool) {
}
    // rust: self.last = self.value;
    // rust: self.value += (if saving { 1.0 } else { 0.0 } - self.value) * 0.2;
}
    // `Hud.extractSavingIndicator` without the option check: the text in the
    // bottom right corner.
    // rust: pub fn draw(
    // rust: &self,
    // rust: w: i32,
    // rust: h: i32,
    // rust: partial: f32,
    // rust: font: &Font,
    // rust: label: Text,
    // rust: background: u32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: if self.value <= 0.0 && self.last <= 0.0 {
    // rust: return out;
}
    // rust: let fade = (self.last + (self.value - self.last) * partial).clamp(0.0, 1.0);
    // rust: let alpha = (255.0 * fade).floor() as u32;
    // rust: if alpha > 0 {
    // rust: let label_width = width(font, &label);
    // rust: let color = crate::hud_layout::argb(alpha, 255, 255, 255);
    // rust: text_with_backdrop(
    // rust: &mut out,
    // rust: label,
    // rust: w - label_width - 5,
    // rust: h - 9 - 5,
    // rust: label_width,
    // rust: color,
    // rust: background,
    // rust: );
}
    // rust: out
}
}

// Titles and the action bar: `Hud.title`, `subtitle`, `titleTime`, the
// fade times and `overlayMessageString` / `overlayMessageTime`.
Titles :: struct {
    title: Maybe(Text),
    subtitle: Maybe(Text),
    time: i32,
    fade_in: i32,
    stay: i32,
    fade_out: i32,
    overlay: Maybe(Text),
    overlay_time: i32,
    // `animateOverlayMessageColor`: the "Now Playing" rainbow.
    overlay_animated: bool,
}
    // rust: impl Default for Titles {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: title: None,
    // rust: subtitle: None,
    // rust: time: 0,
    // rust: fade_in: 10,
    // rust: stay: 70,
    // rust: fade_out: 20,
    // rust: overlay: None,
    // rust: overlay_time: 0,
    // rust: overlay_animated: false,
}
}
}
    // rust: impl Titles {
    // `setTitle`.
set_title :: proc(self: ^Self, title: Text) {
}
    // rust: self.title = Some(title);
    // rust: self.time = self.fade_in + self.stay + self.fade_out;
}
    // `setSubtitle`.
set_subtitle :: proc(self: ^Self, subtitle: Text) {
}
    // rust: self.subtitle = Some(subtitle);
}
    // `setTimes`: negative values keep the current time.
set_times :: proc(self: ^Self, fade_in: i32, stay: i32, fade_out: i32) {
}
    // rust: if fade_in >= 0 {
    // rust: self.fade_in = fade_in;
}
    // rust: if stay >= 0 {
    // rust: self.stay = stay;
}
    // rust: if fade_out >= 0 {
    // rust: self.fade_out = fade_out;
}
    // rust: if self.time > 0 {
    // rust: self.time = self.fade_in + self.stay + self.fade_out;
}
}
    // `clearTitles`.
clear :: proc(self: ^Self) {
}
    // rust: self.title = None;
    // rust: self.subtitle = None;
    // rust: self.time = 0;
}
    // `resetTitleTimes`.
reset_times :: proc(self: ^Self) {
}
    // rust: (self.fade_in, self.stay, self.fade_out) = (10, 70, 20);
}
    // `setOverlayMessage`.
set_overlay :: proc(self: ^Self, text: Text, animate: bool) {
}
    // rust: self.overlay = Some(text);
    // rust: self.overlay_time = 60;
    // rust: self.overlay_animated = animate;
}
    // The title and action bar part of `Hud.tick`.
tick :: proc(self: ^Self) {
}
    // rust: if self.overlay_time > 0 {
    // rust: self.overlay_time -= 1;
}
    // rust: if self.time > 0 {
    // rust: self.time -= 1;
    // rust: if self.time <= 0 {
    // rust: self.title = None;
    // rust: self.subtitle = None;
}
}
}
    // `Hud.extractOverlayMessage`; `bar_height` is
    // `max(leftHeight, rightHeight)`.
    // rust: pub fn overlay_message(
    // rust: &self,
    // rust: w: i32,
    // rust: h: i32,
    // rust: bar_height: i32,
    // rust: partial: f32,
    // rust: font: &Font,
    // rust: background: u32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: let Some(message) = &self.overlay else {
    // rust: return out;
}
    // rust: if self.overlay_time <= 0 {
    // rust: return out;
}
    // rust: let t = self.overlay_time as f32 - partial;
    // rust: let alpha = ((t * 255.0 / 20.0) as i32).min(255);
    // rust: if alpha > 0 {
    // rust: let message = message.resolve_legacy();
            // The bars' height plus the gap between the item name (59) and the
            // overlay (68), at least the default level.
    // rust: let y_shift = bar_height + (68 - 59);
    // rust: out.push(GuiDraw::Push(vec![PoseOp::Translate(
    // rust: (w / 2) as f32,
    // rust: (h - y_shift.max(68)) as f32,
    // rust: )]));
    // rust: let color = if self.overlay_animated {
    // rust: hsv_to_argb(t / 50.0, 0.7, 0.6, alpha as u32)
    // rust: } else {
    // rust: crate::hud_layout::argb(alpha as u32, 255, 255, 255)
}
    // rust: let width = width(font, &message);
    // rust: text_with_backdrop(&mut out, message, -width / 2, -4, width, color, background);
    // rust: out.push(GuiDraw::Pop);
}
    // rust: out
}
    // `Hud.extractTitle`.
    // rust: pub fn title(
    // rust: &self,
    // rust: w: i32,
    // rust: h: i32,
    // rust: partial: f32,
    // rust: font: &Font,
    // rust: background: u32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: let Some(title) = &self.title else {
    // rust: return out;
}
    // rust: if self.time <= 0 {
    // rust: return out;
}
    // rust: let t = self.time as f32 - partial;
    // rust: let mut alpha = 255;
    // rust: if self.time > self.fade_out + self.stay {
    // rust: let time = (self.fade_in + self.stay + self.fade_out) as f32 - t;
    // rust: alpha = (time * 255.0 / self.fade_in as f32) as i32;
}
    // rust: if self.time <= self.fade_out {
    // rust: alpha = (t * 255.0 / self.fade_out as f32) as i32;
}
    // rust: let alpha = alpha.clamp(0, 255);
    // rust: if alpha > 0 {
    // rust: let title = title.resolve_legacy();
    // rust: out.push(GuiDraw::Push(vec![PoseOp::Translate(
    // rust: (w / 2) as f32,
    // rust: (h / 2) as f32,
    // rust: )]));
    // rust: out.push(GuiDraw::Push(vec![PoseOp::Scale(4.0, 4.0)]));
    // rust: let title_width = width(font, &title);
    // rust: let color = crate::hud_layout::argb(alpha as u32, 255, 255, 255);
    // rust: text_with_backdrop(
    // rust: &mut out,
    // rust: title,
    // rust: -title_width / 2,
    // rust: -10,
    // rust: title_width,
    // rust: color,
    // rust: background,
    // rust: );
    // rust: out.push(GuiDraw::Pop);
    // rust: if let Some(subtitle) = &self.subtitle {
    // rust: let subtitle = subtitle.resolve_legacy();
    // rust: out.push(GuiDraw::Push(vec![PoseOp::Scale(2.0, 2.0)]));
    // rust: let subtitle_width = width(font, &subtitle);
    // rust: text_with_backdrop(
    // rust: &mut out,
    // rust: subtitle,
    // rust: -subtitle_width / 2,
    // rust: 5,
    // rust: subtitle_width,
    // rust: color,
    // rust: background,
    // rust: );
    // rust: out.push(GuiDraw::Pop);
}
    // rust: out.push(GuiDraw::Pop);
}
    // rust: out
}
}

// The selected item as `Hud.tick` compares it: its item id and hover name.
HeldName :: struct {
    item: string,
    // `ItemStack.getHoverName`.
    hover_name: Text,
    // `getRarity().color()`.
    rarity_color: u32,
    // The stack has `CUSTOM_NAME`.
    custom_name: bool,
}

// `Hud.toolHighlightTimer` and `lastToolHighlight`.
ToolHighlight :: struct {
    timer: i32,
    last: Maybe(HeldName),
}
    // rust: impl ToolHighlight {
    // The selected-item part of `Hud.tick`; `display_time` is the
    // `notificationDisplayTime` option.
tick :: proc(self: ^Self, selected: Maybe(HeldName), display_time: f64) {
}
    // rust: match &selected {
    // rust: None => self.timer = 0,
    // rust: Some(s) => {
    // rust: let changed = self
    // rust: .last
    // rust: .as_ref()
    // rust: .is_none_or(|l| l.item != s.item || l.hover_name != s.hover_name);
    // rust: if changed {
    // rust: self.timer = (40.0 * display_time) as i32;
    // rust: } else if self.timer > 0 {
    // rust: self.timer -= 1;
}
}
}
    // rust: self.last = selected;
}
    // `Hud.extractSelectedItemName`; `can_hurt` is
    // `gameMode.canHurtPlayer()` (survival and adventure) and `bar_height`
    // is `max(leftHeight, rightHeight)`.
    // rust: pub fn draw(
    // rust: &self,
    // rust: w: i32,
    // rust: h: i32,
    // rust: bar_height: i32,
    // rust: can_hurt: bool,
    // rust: font: &Font,
    // rust: background: u32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: let Some(last) = &self.last else {
    // rust: return out;
}
    // rust: if self.timer <= 0 {
    // rust: return out;
}
    // rust: let mut name = last.hover_name.clone().with_color(last.rarity_color);
    // rust: if last.custom_name {
    // rust: name = name.with_style(&Style {
    // rust: italic: Some(true),
    // rust: ..Style::default()
    // rust: });
}
    // rust: let str_width = width(font, &name);
    // rust: let x = (w - str_width) / 2;
    // rust: let mut y = h - bar_height.max(59);
    // rust: if !can_hurt {
    // rust: y += 14;
}
    // rust: let alpha = ((self.timer as f32 * 256.0 / 10.0) as i32).min(255);
    // rust: if alpha > 0 {
    // rust: let color = crate::hud_layout::argb(alpha as u32, 255, 255, 255);
    // rust: text_with_backdrop(&mut out, name, x, y, str_width, color, background);
}
    // rust: out
}
}

// One `LerpingBossEvent` as `BossHealthOverlay` draws it.
BossBar :: struct {
    name: Text,
    // `getProgress()` (the lerped value).
    progress: f32,
    // `BossBarColor` ordinal: pink, blue, red, green, yellow, purple, white.
    color: uint,
    // `BossBarOverlay` ordinal: progress, notched_6, _10, _12, _20.
    overlay: uint,
}
BOSS_COLORS :: ["pink", "blue", "red", "green", "yellow", "purple", "white"]
    // rust: const BOSS_OVERLAYS: [&str; 5] = [
    // rust: "progress",
    // rust: "notched_6",
    // rust: "notched_10",
    // rust: "notched_12",
    // rust: "notched_20",
    // rust: ];

// `BossHealthOverlay.extractRenderState`: the bars in event order, 19 pixels
// apart from y = 12 until a third of the screen height.
boss_overlay :: proc(w: i32, h: i32, bars: ^[BossBar], font: ^Font) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut y_offset = 12;
    // rust: for bar in bars {
    // rust: let x_left = w / 2 - 91;
    // rust: let part = |out: &mut Vec<GuiDraw>, width: i32, kind: &str| {
    // rust: let sprite = |name: String| GuiDraw::Sprite {
    // rust: sprite: Cow::Owned(format!("boss_bar/{name}_{kind}")),
    // rust: x: x_left,
    // rust: y: y_offset,
    // rust: w: width,
    // rust: h: 5,
    // rust: region: Some([182, 5, 0, 0]),
    // rust: color: crate::hud_layout::WHITE,
    // rust: blend: crate::hud_layout::Blend::Textured,
}
    // rust: out.push(sprite(BOSS_COLORS[bar.color].to_owned()));
    // rust: if bar.overlay != 0 {
    // rust: out.push(sprite(BOSS_OVERLAYS[bar.overlay].to_owned()));
}
}
    // rust: part(&mut out, 182, "background");
    // rust: let progress = crate::hud_layout::lerp_discrete(bar.progress, 0, 182);
    // rust: if progress > 0 {
    // rust: part(&mut out, progress, "progress");
}
    // rust: let name = bar.name.resolve_legacy();
    // rust: let width = width(font, &name);
    // rust: text(
    // rust: &mut out,
    // rust: name,
    // rust: w / 2 - width / 2,
    // rust: y_offset - 9,
    // rust: crate::hud_layout::WHITE,
    // rust: true,
    // rust: );
    // rust: y_offset += 10 + 9;
    // rust: if y_offset >= h / 3 {
    // rust: break;
}
}
    // rust: out
}

// `JumpableVehicleBar.extractBackground`: `cooldown` is the mount's jump
// cooldown and `scale` the player's `getJumpRidingScale()`.
jump_bar :: proc(w: i32, h: i32, cooldown: i32, scale: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (left, top) = ((w - 182) / 2, h - 24 - 5);
    // rust: let sprite = |name: &'static str, width: i32, region: Option<[i32; 4]>| GuiDraw::Sprite {
    // rust: sprite: Cow::Borrowed(name),
    // rust: x: left,
    // rust: y: top,
    // rust: w: width,
    // rust: h: 5,
    // rust: region,
    // rust: color: crate::hud_layout::WHITE,
    // rust: blend: crate::hud_layout::Blend::Textured,
}
    // rust: let mut out = vec![sprite("hud/jump_bar_background", 182, None)];
    // rust: if cooldown > 0 {
    // rust: out.push(sprite("hud/jump_bar_cooldown", 182, None));
    // rust: } else {
    // rust: let progress = crate::hud_layout::lerp_discrete(scale, 0, 182);
    // rust: if progress > 0 {
    // rust: out.push(sprite(
    // rust: "hud/jump_bar_progress",
    // rust: progress,
    // rust: Some([182, 5, 0, 0]),
    // rust: ));
}
}
    // rust: out
}

// `String.CASE_INSENSITIVE_ORDER` over UTF-16 code units.
compare_ignore_case :: proc(a: string, b: string) -> O {
    // Ported from Horizon
    return {}
}
single :: proc(mut it: impl Iterator<Item = char>, c: char) -> c {
    // Ported from Horizon
    return {}
}
    // rust: match (it.next(), it.next()) {
    // rust: (Some(m), None) => m,
    // rust: _ => c,
}
}
    // rust: let unit = |u: u16| char::from_u32(u32::from(u));
    // rust: let (x, y): (Vec<u16>, Vec<u16>) = (a.encode_utf16().collect(), b.encode_utf16().collect());
    // rust: for (&p, &q) in x.iter().zip(&y) {
    // rust: if p == q {
    // rust: continue;
}
    // rust: let (Some(c1), Some(c2)) = (unit(p), unit(q)) else {
    // rust: return p.cmp(&q);
}
    // rust: let (u1, u2) = (single(c1.to_uppercase(), c1), single(c2.to_uppercase(), c2));
    // rust: if u1 != u2 {
    // rust: let (l1, l2) = (single(u1.to_lowercase(), u1), single(u2.to_lowercase(), u2));
    // rust: if l1 != l2 {
    // rust: return (l1 as u32).cmp(&(l2 as u32));
}
}
}
    // rust: x.len().cmp(&y.len())
}

// `Hud.displayScoreboardSidebar` for `objective`; `background` and
// `header` are `Options.getBackgroundColor(0.3F)` and `(0.4F)`.
    // rust: pub fn sidebar(
    // rust: w: i32,
    // rust: h: i32,
    // rust: board: &crate::scoreboard::Scoreboard,
    // rust: objective: &crate::scoreboard::Objective,
    // rust: font: &Font,
    // rust: background: u32,
    // rust: header: u32,
    // rust: ) -> Vec<GuiDraw> {
//     use crate::scoreboard::NumberFormat;
    // rust: let format = objective.format_or_default(NumberFormat::sidebar_default());
    // rust: let mut entries: Vec<_> = board
    // rust: .list_scores(&objective.name)
    // rust: .into_iter()
    // rust: .filter(|e| !e.is_hidden())
    // rust: .collect();
    // SCORE_DISPLAY_ORDER: highest value first, then owners case-insensitively.
    // rust: java_sort(&mut entries, |a, b| {
    // rust: b.value
    // rust: .cmp(&a.value)
    // rust: .then_with(|| compare_ignore_case(&a.owner, &b.owner))
    // rust: });
    // rust: entries.truncate(15);
    // Font draws each literal through StringDecomposer.iterateFormatted:
    // legacy `§` codes style what follows and are not drawn.
    // rust: let rows: Vec<(Text, Text, i32)> = entries
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let name = match board.players_team(&e.owner) {
    // rust: Some(team) => team.formatted_name(e.owner_name()),
    // rust: None => e.owner_name(),
}
    // rust: .resolve_legacy();
    // rust: let score = e.format_value(&format).resolve_legacy();
    // rust: let score_width = width(font, &score);
    // rust: (name, score, score_width)
    // rust: })
    // rust: .collect();
    // rust: let title = objective.display_text().resolve_legacy();
    // rust: let title_width = width(font, &title);
    // rust: let spacer = font.width(": ") as i32;
    // rust: let mut biggest = title_width;
    // rust: for (name, _, score_width) in &rows {
    // rust: let extra = if *score_width > 0 {
    // rust: spacer + score_width
    // rust: } else {
    // rust: 0
}
    // rust: biggest = biggest.max(width(font, name) + extra);
}
    // rust: let count = rows.len() as i32;
    // rust: let height = count * 9;
    // rust: let bottom = h / 2 + height / 3;
    // rust: let left = w - biggest - 3;
    // rust: let right = w - 3 + 2;
    // rust: let header_y = bottom - count * 9;
    // rust: let mut out = vec![
    // rust: fill(left - 2, header_y - 9 - 1, right, header_y - 1, header),
    // rust: fill(left - 2, header_y - 1, right, bottom, background),
    // rust: ];
    // rust: let white = crate::hud_layout::WHITE;
    // rust: text(
    // rust: &mut out,
    // rust: title,
    // rust: left + biggest / 2 - title_width / 2,
    // rust: header_y - 9,
    // rust: white,
    // rust: false,
    // rust: );
    // rust: for (i, (name, score, score_width)) in rows.into_iter().enumerate() {
    // rust: let y = bottom - (count - i as i32) * 9;
    // rust: text(&mut out, name, left, y, white, false);
    // rust: text(&mut out, score, right - score_width, y, white, false);
}
    // rust: out
}

// What `GuiGraphicsExtractor.itemDecorations` draws over a stack.
ItemDecorations :: struct {
    count: u32,
    // The text shown instead of the count, if any.
    count_text: Maybe(string),
    // `isBarVisible`: `getBarWidth` and `getBarColor` (RGB).
    bar: Option<(i32,
    // `ItemCooldowns.getCooldownPercent` of the stack.
    cooldown: f32,
}

// `Item.getBarWidth` and `getBarColor` for a damaged stack (`isDamaged`).
damage_bar :: proc(damage: i32, max_damage: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if max_damage <= 0 || damage <= 0 {
    // rust: return None;
}
    // rust: let width = (13.0 - damage as f32 * 13.0 / max_damage as f32)
    // rust: .round()
    // rust: .clamp(0.0, 13.0) as i32;
    // rust: let health = ((max_damage as f32 - damage as f32) / max_damage as f32).max(0.0);
    // rust: Some((width, hsv_to_argb(health / 3.0, 1.0, 1.0, 0)))
}

// `GuiGraphicsExtractor.itemDecorations` for a non-empty stack at (x, y):
// the durability bar, the cooldown shade and the count.
item_decorations :: proc(x: i32, y: i32, d: ^ItemDecorations, font: ^Font) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![GuiDraw::Push(Vec::new())];
    // rust: if let Some((width, color)) = d.bar {
    // rust: let (left, top) = (x + 2, y + 13);
    // rust: out.push(fill(left, top, left + 13, top + 2, 0xFF00_0000));
    // rust: out.push(fill(left, top, left + width, top + 1, color | 0xFF00_0000));
}
    // rust: if d.cooldown > 0.0 {
    // rust: let top = y + crate::hud_layout::floor(16.0 * (1.0 - d.cooldown));
    // rust: let bottom = top + crate::hud_layout::ceil(16.0 * d.cooldown);
    // rust: out.push(fill(x, top, x + 16, bottom, 0x7FFF_FFFF));
}
    // rust: if d.count != 1 || d.count_text.is_some() {
    // rust: let amount = d.count_text.clone().unwrap_or_else(|| d.count.to_string());
    // rust: let w = font.width(&amount) as i32;
    // rust: text(
    // rust: &mut out,
    // rust: Text::literal(amount),
    // rust: x + 19 - 2 - w,
    // rust: y + 6 + 3,
    // rust: crate::hud_layout::WHITE,
    // rust: true,
    // rust: );
}
    // rust: out.push(GuiDraw::Pop);
    // rust: out
}

// A full-screen `graphics.blit` of `textures/<texture>.png`.
    // rust: fn screen_blit(
    // rust: w: i32,
    // rust: h: i32,
    // rust: texture: impl Into<Cow<'static, str>>,
    // rust: blend: Blend,
    // rust: color: u32,
    // rust: ) -> GuiDraw {
    // rust: GuiDraw::Blit {
    // rust: texture: texture.into(),
    // rust: blend,
    // rust: x: 0,
    // rust: y: 0,
    // rust: w,
    // rust: h,
    // rust: uv: [0.0, 0.0],
    // rust: src: [w, h],
    // rust: tex: [w, h],
    // rust: color,
}
}

// `Hud.extractVignette`: `brightness` is `vignetteBrightness` and
// `border_warning` the world border warning strength (0 when far).
vignette :: proc(w: i32, h: i32, brightness: f32, border_warning: f32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let brightness = brightness.clamp(0.0, 1.0);
    // rust: let color = if border_warning > 0.0 {
    // rust: let warning = border_warning.clamp(0.0, 1.0);
    // rust: let red = brightness * (1.0 - warning);
    // rust: let green_blue = brightness + (1.0 - brightness) * warning;
    // rust: color_from_float(1.0, red, green_blue, green_blue)
    // rust: } else {
    // rust: color_from_float(1.0, brightness, brightness, brightness)
}
    // rust: screen_blit(w, h, "misc/vignette", Blend::Vignette, color)
}

// The border warning strength of `extractVignette` for a camera
// `distance` from a border with `warning_blocks`, `warning_time`, its
// `lerp_speed` and how far its size still has to move.
    // rust: pub fn border_warning(
    // rust: distance: f32,
    // rust: warning_blocks: i32,
    // rust: warning_time: i32,
    // rust: lerp_speed: f64,
    // rust: size_left: f64,
    // rust: ) -> f32 {
    // rust: let moving = (lerp_speed * f64::from(warning_time)).min(size_left.abs());
    // rust: let warning_distance = f64::from(warning_blocks).max(moving);
    // rust: if f64::from(distance) < warning_distance {
    // rust: 1.0 - (f64::from(distance) / warning_distance) as f32
    // rust: } else {
    // rust: 0.0
}
}

// `Hud.extractSpyglassOverlay`.
spyglass :: proc(w: i32, h: i32, scale: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let src = w.min(h) as f32;
    // rust: let ratio = (w as f32 / src).min(h as f32 / src) * scale;
    // rust: let width = crate::hud_layout::floor(src * ratio);
    // rust: let height = crate::hud_layout::floor(src * ratio);
    // rust: let left = (w - width) / 2;
    // rust: let top = (h - height) / 2;
    // rust: let (right, bottom) = (left + width, top + height);
    // rust: vec![
    // rust: GuiDraw::Blit {
    // rust: texture: Cow::Borrowed("misc/spyglass_scope"),
    // rust: blend: Blend::Textured,
    // rust: x: left,
    // rust: y: top,
    // rust: w: width,
    // rust: h: height,
    // rust: uv: [0.0, 0.0],
    // rust: src: [width, height],
    // rust: tex: [width, height],
    // rust: color: crate::hud_layout::WHITE,
    // rust: },
    // rust: fill(0, bottom, w, h, 0xFF00_0000),
    // rust: fill(0, 0, w, top, 0xFF00_0000),
    // rust: fill(0, top, left, bottom, 0xFF00_0000),
    // rust: fill(right, top, w, bottom, 0xFF00_0000),
    // rust: ]
}

// `Hud.extractPortalOverlay`: the nether portal block sprite over the screen.
portal_overlay :: proc(w: i32, h: i32, mut alpha: f32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: if alpha < 1.0 {
    // rust: alpha *= alpha;
    // rust: alpha *= alpha;
    // rust: alpha = alpha * 0.8 + 0.2;
}
    // rust: GuiDraw::AtlasSprite {
    // rust: sprite: Cow::Borrowed("block/nether_portal"),
    // rust: x: 0,
    // rust: y: 0,
    // rust: w,
    // rust: h,
    // rust: color: white(alpha),
}
}

// `Hud.extractConfusionOverlay`: the nausea swirl scaled about the centre.
confusion_overlay :: proc(w: i32, h: i32, strength: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let size = 2.0 + strength * (1.0 - 2.0);
    // rust: let (cx, cy) = (w as f32 / 2.0, h as f32 / 2.0);
    // rust: vec![
    // rust: GuiDraw::Push(vec![
    // rust: PoseOp::Translate(cx, cy),
    // rust: PoseOp::Scale(size, size),
    // rust: PoseOp::Translate(-cx, -cy),
    // rust: ]),
    // rust: screen_blit(
    // rust: w,
    // rust: h,
    // rust: "misc/nausea",
    // rust: Blend::Nausea,
    // rust: color_from_float(1.0, 0.2 * strength, 0.4 * strength, 0.2 * strength),
    // rust: ),
    // rust: GuiDraw::Pop,
    // rust: ]
}

// What `Hud.extractCameraOverlays` reads.
CameraOverlays :: struct {
    // `Options.vignette`: `vignetteBrightness` and the border warning strength.
    vignette: Option<(f32,
    first_person: bool,
    // `LocalPlayer.isScoping`.
    scoping: bool,
    // `DeltaTracker.getGameTimeDeltaTicks`.
    game_time_delta: f32,
    // `Equippable.cameraOverlay` textures (`misc/pumpkinblur`) of the worn
    // items in `EquipmentSlot` order.
    equipment: [dynamic]string,
    // `getTicksFrozen` and `getPercentFrozen`.
    ticks_frozen: i32,
    percent_frozen: f32,
    // The partial tick and `oPortalEffectIntensity` / `portalEffectIntensity`.
    partial: f32,
    portal: [f32,
    // `getEffectBlendFactor(NAUSEA, partial)` and `Options.screenEffectScale`.
    nausea: f32,
    screen_effect_scale: f32,
}

// `Hud.extractCameraOverlays`, easing `scope_scale` (`Hud.scopeScale`).
camera_overlays :: proc(w: i32, h: i32, i: ^CameraOverlays, scope_scale: ^f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: if let Some((brightness, warning)) = i.vignette {
    // rust: out.push(vignette(w, h, brightness, warning));
}
    // rust: *scope_scale += 0.5 * i.game_time_delta * (1.125 - *scope_scale);
    // rust: if i.first_person {
    // rust: if i.scoping {
    // rust: out.extend(spyglass(w, h, *scope_scale));
    // rust: } else {
    // rust: *scope_scale = 0.5;
    // rust: for texture in &i.equipment {
    // rust: out.push(screen_blit(
    // rust: w,
    // rust: h,
    // rust: texture.clone(),
    // rust: Blend::Textured,
    // rust: crate::hud_layout::WHITE,
    // rust: ));
}
}
}
    // rust: if i.ticks_frozen > 0 {
    // rust: out.push(screen_blit(
    // rust: w,
    // rust: h,
    // rust: "misc/powder_snow_outline",
    // rust: Blend::Textured,
    // rust: white(i.percent_frozen),
    // rust: ));
}
    // rust: let portal = i.portal[0] + i.partial * (i.portal[1] - i.portal[0]);
    // rust: if portal > 0.0 {
    // rust: out.push(portal_overlay(w, h, portal));
    // rust: } else if i.nausea > 0.0 && i.screen_effect_scale < 1.0 {
    // rust: out.extend(confusion_overlay(
    // rust: w,
    // rust: h,
    // rust: i.nausea * (1.0 - i.screen_effect_scale),
    // rust: ));
}
    // rust: out
}

// `Hud.extractSleepOverlay`.
sleep_overlay :: proc(w: i32, h: i32, sleep_timer: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if sleep_timer <= 0 {
    // rust: return Vec::new();
}
    // rust: let timer = sleep_timer as f32;
    // rust: let mut amount = timer / 100.0;
    // rust: if amount > 1.0 {
    // rust: amount = 1.0 - (timer - 100.0) / 10.0;
}
    // rust: let color = (((220.0 * amount) as i32) << 24) as u32 | 0x10_1020;
    // rust: vec![fill(0, 0, w, h, color)]
}

// ---- subtitles (`SubtitleOverlay`) ------------------------------------------
//
// Closed captions for the sounds the player could hear, with direction arrows
// and a fade over the notification display time. Like vanilla, the overlay
// listens to the sound engine only from the frame that renders it with the
// "Show Subtitles" option on until a frame renders with it off; turning it
// off keeps the captions it has (they show again if the option comes back
// before they expire).

// `SubtitleOverlay.DISPLAY_TIME` (milliseconds).
DISPLAY_TIME :: 3000
// `LOOPING_DISPLAY_FULL_BRIGHTNESS_TIME`: looping sounds stay at full brightness this long.
LOOPING_FULL_BRIGHTNESS :: 500

PlayedAt :: struct {
    location: [f64,
    time: i64,
}
Subtitle :: struct {
    // The translation key of the sound event's subtitle (`Component.translatable`).
    key: string,
    range: f32,
    played: [dynamic]PlayedAt,
    looping: bool,
}
distance_sqr :: proc(a: [f64; 3], b: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (dx, dy, dz) = (a[0] - b[0], a[1] - b[1], a[2] - b[2]);
    // rust: dx * dx + dy * dy + dz * dz
}
// `Vec3.closerThan(pos, distance)`.
closer_than :: proc(a: [f64; 3], b: [f64; 3], range: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let r = f64::from(range);
    // rust: distance_sqr(a, b) < r * r
}
// `Vec3.equals`: `Double.compare` on each axis.
same_location :: proc(a: [f64; 3], b: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bits = |v: f64| {
    // rust: if v.is_nan() {
    // rust: f64::NAN.to_bits()
    // rust: } else {
    // rust: v.to_bits()
}
}
    // rust: (0..3).all(|i| bits(a[i]) == bits(b[i]))
}
    // rust: impl Subtitle {
    // `getBestSubtitleCandidate`: the only play, else the latest in range
    // (the farthest of equally recent ones; the first among full ties).
best_candidate :: proc(self: ^Self, position: [f64; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.played.as_slice() {
    // rust: [] => None,
    // rust: [only] => Some(*only),
    // rust: many => many
    // rust: .iter()
    // rust: .filter(|p| closer_than(p.location, position, self.range))
    // rust: .fold(None, |best: Option<PlayedAt>, p| match best {
    // rust: Some(b)
    // rust: if b.time > p.time
    // rust: || b.time == p.time
    // rust: && distance_sqr(b.location, position).sqrt()
    // rust: >= distance_sqr(p.location, position).sqrt() =>
    // rust: {
    // rust: Some(b)
}
    // rust: _ => Some(*p),
    // rust: }),
}
}
refresh :: proc(self: ^Self, location: [f64; 3], now: i64) {
}
    // rust: self.played.retain(|p| !same_location(location, p.location));
    // rust: self.played.push(PlayedAt {
    // rust: location,
    // rust: time: now,
    // rust: });
}
audible_from :: proc(self: ^Self, camera: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.range.is_infinite() {
    // rust: return true;
}
    // rust: self.best_candidate(camera)
    // rust: .is_some_and(|p| closer_than(camera, p.location, self.range))
}
purge_old_instances :: proc(self: ^Self, max_age: f64, now: i64) {
}
    // rust: self.played.retain(|p| ((now - p.time) as f64) <= max_age);
}
    // `getBrightness`: fades from 255 to 75 over the display time.
brightness :: proc(self: ^Self, at: PlayedAt, multiplier: f64, now: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let full = if self.looping {
    // rust: LOOPING_FULL_BRIGHTNESS
    // rust: } else {
    // rust: 0
}
    // rust: let age = (now - at.time - full).max(0) as f32;
    // rust: let t = age / (((DISPLAY_TIME - full) as f64) * multiplier) as f32;
    // rust: let v = if t < 0.0 {
    // rust: 255.0
    // rust: } else if t > 1.0 {
    // rust: 75.0
    // rust: } else {
    // rust: 255.0 + t * (75.0 - 255.0_f32)
}
    // rust: v.floor() as i32
}
}

// What a frame needs to render the overlay: the sound listener, the
// accessibility options and the GUI size.
SubtitleFrame :: struct {
    // `options.showSubtitles`.
    show: bool,
    // `SoundManager.getListenerTransform`: position, forward and up.
    position: [f64,
    forward: [f64,
    up: [f64,
    // `options.notificationDisplayTime`.
    multiplier: f64,
    // `options.getBackgroundColor(0.8F)` (ARGB, `Settings::text_background`).
    background: u32,
    width: i32,
    height: i32,
}
// Milliseconds on a monotonic clock (`Util.getMillis`).
now_ms :: proc() -> i {
    // Ported from Horizon
    return {}
}
START :: std::sync::OnceLock::new()
    // rust: START
    // rust: .get_or_init(std::time::Instant::now)
    // rust: .elapsed()
    // rust: .as_millis() as i64
}
SubtitleOverlay :: struct {
    subtitles: [dynamic]Subtitle,
    listening: bool,
}
    // rust: impl SubtitleOverlay {
    // Whether the overlay is one of the sound engine's listeners.
listening :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.listening
}
    // `onPlaySound` for a sound the engine played while the overlay listens:
    // a subtitle already listed (by its text) refreshes its location.
    // rust: pub fn on_play(
    // rust: &mut self,
    // rust: subtitle: Option<&str>,
    // rust: location: [f64; 3],
    // rust: range: f32,
    // rust: looping: bool,
    // rust: now: i64,
    // rust: ) {
    // rust: let Some(key) = subtitle else {
    // rust: return;
}
    // rust: if let Some(s) = self.subtitles.iter_mut().find(|s| s.key == key) {
    // rust: s.refresh(location, now);
    // rust: return;
}
    // rust: self.subtitles.push(Subtitle {
    // rust: key: key.to_owned(),
    // rust: range,
    // rust: played: vec![PlayedAt {
    // rust: location,
    // rust: time: now,
    // rust: }],
    // rust: looping,
    // rust: });
}
    // `extractRenderState`: starts or stops listening as the option says,
    // forgets old plays and lays out the boxes at the bottom right.
extract :: proc(self: ^Self, frame: ^SubtitleFrame, font: ^Font, now: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: if self.listening != frame.show {
    // rust: self.listening = frame.show;
}
    // rust: if !self.listening {
    // rust: return out;
}
    // rust: let position = frame.position;
    // rust: let (f, u) = (frame.forward, frame.up);
        // ListenerTransform.right: forward x up.
    // rust: let right = [
    // rust: f[1] * u[2] - f[2] * u[1],
    // rust: f[2] * u[0] - f[0] * u[2],
    // rust: f[0] * u[1] - f[1] * u[0],
    // rust: ];
    // rust: let width_of = |t: &Text| width(font, t);
    // rust: let mut audible = Vec::new();
    // rust: let mut width = 0;
    // rust: for (i, s) in self.subtitles.iter_mut().enumerate() {
    // rust: if !s.played.is_empty() {
    // rust: s.purge_old_instances(3000.0 * frame.multiplier, now);
}
    // rust: if s.audible_from(position) && !s.played.is_empty() {
    // rust: let text_width = width_of(&Text::translate(&s.key, &[]));
    // rust: width = width.max(text_width);
    // rust: audible.push((i, text_width));
}
}
    // rust: if audible.is_empty() {
    // rust: return out;
}
    // rust: let w = |s: &str| font.width(s) as i32;
    // rust: width += w("<") + w(" ") + w(">") + w(" ");
    // rust: let mut row = 0;
    // rust: for (i, text_width) in audible {
    // rust: let s = &self.subtitles[i];
    // rust: let text_value = Text::translate(&s.key, &[]);
    // rust: let Some(closest) = s.best_candidate(position) else {
    // rust: continue;
}
    // rust: let mut delta = [
    // rust: closest.location[0] - position[0],
    // rust: closest.location[1] - position[1],
    // rust: closest.location[2] - position[2],
    // rust: ];
            // Vec3.normalize.
    // rust: let length = distance_sqr(delta, [0.0; 3]).sqrt();
    // rust: delta = if length < f64::from(1.0e-5_f32) {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: delta.map(|v| v / length)
}
    // rust: let dot = |a: [f64; 3]| a[0] * delta[0] + a[1] * delta[1] + a[2] * delta[2];
    // rust: let (rightness, forwardness) = (dot(right), dot(f));
    // rust: let in_view = forwardness > 0.5;
    // rust: let half_width = width / 2;
    // rust: let height = 9;
    // rust: let half_height = height / 2;
    // rust: let brightness = s.brightness(closest, frame.multiplier, now);
    // rust: out.push(GuiDraw::Push(vec![
    // rust: PoseOp::Translate(
    // rust: frame.width as f32 - half_width as f32 * 1.0 - 2.0,
    // rust: (frame.height - 35) as f32 - (row * (height + 1)) as f32 * 1.0,
    // rust: ),
    // rust: PoseOp::Scale(1.0, 1.0),
    // rust: ]));
    // rust: out.push(fill(
    // rust: -half_width - 1,
    // rust: -half_height - 1,
    // rust: half_width + 1,
    // rust: half_height + 1,
    // rust: frame.background,
    // rust: ));
    // rust: let b = brightness as u32 & 0xFF;
    // rust: let color = 0xFF00_0000 | b << 16 | b << 8 | b;
    // rust: if !in_view {
    // rust: if rightness > 0.0 {
    // rust: text(
    // rust: &mut out,
    // rust: Text::literal(">"),
    // rust: half_width - w(">"),
    // rust: -half_height,
    // rust: color,
    // rust: true,
    // rust: );
    // rust: } else if rightness < 0.0 {
    // rust: text(
    // rust: &mut out,
    // rust: Text::literal("<"),
    // rust: -half_width,
    // rust: -half_height,
    // rust: color,
    // rust: true,
    // rust: );
}
}
    // rust: text(
    // rust: &mut out,
    // rust: text_value,
    // rust: -text_width / 2,
    // rust: -half_height,
    // rust: color,
    // rust: true,
    // rust: );
    // rust: out.push(GuiDraw::Pop);
    // rust: row += 1;
}
    // rust: out
}
}

    // rust: mod subtitle_tests {
//     use super::*;

candidates_and_brightness :: proc() {
}
    // rust: let mut s = Subtitle {
    // rust: key: "a".into(),
    // rust: range: 16.0,
    // rust: played: vec![PlayedAt {
    // rust: location: [0.0, 0.0, 3.0],
    // rust: time: 1000,
    // rust: }],
    // rust: looping: false,
}
    // rust: assert_eq!(s.brightness(s.played[0], 1.0, 1000), 255);
    // rust: assert_eq!(s.brightness(s.played[0], 1.0, 2500), 165);
    // rust: assert_eq!(s.brightness(s.played[0], 2.0, 2500), 210);
    // rust: assert_eq!(s.brightness(s.played[0], 1.0, 9000), 75);
        // Equally recent plays: the farthest in range wins.
    // rust: s.refresh([0.0, 0.0, 5.0], 1000);
    // rust: s.refresh([0.0, 0.0, 40.0], 1000);
    // rust: let best = s.best_candidate([0.0; 3]).unwrap();
    // rust: assert_eq!(best.location, [0.0, 0.0, 5.0]);
    // rust: s.purge_old_instances(3000.0, 4001);
    // rust: assert!(s.played.is_empty());
    // rust: assert!(!s.audible_from([0.0; 3]));
}

listening_follows_the_option :: proc() {
}
    // rust: let mut o = SubtitleOverlay::default();
    // rust: o.on_play(Some("a"), [0.0; 3], 16.0, false, 0);
    // rust: assert_eq!(o.subtitles.len(), 1);
    // rust: o.on_play(None, [0.0; 3], 16.0, false, 0);
    // rust: o.on_play(Some("a"), [1.0; 3], 16.0, false, 5);
    // rust: assert_eq!(o.subtitles.len(), 1);
    // rust: assert_eq!(o.subtitles[0].played.len(), 2);
    // rust: assert!(!o.listening());
}
}
