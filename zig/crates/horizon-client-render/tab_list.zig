//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_tab_list
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The player list shown while the player-list key is held
//! (`PlayerTabOverlay`, `Hud.extractTabList`): listed players sorted by list
//! order, spectators last, team and name; columns of at most 20 rows; heads,
//! names (team prefix and colour, italic spectators), ping bars and the
//! `list` objective (integer scores in their number format, or hearts that
//! blink when they change); the header and footer. Laid out as draw calls so
//! the parity fixture can compare them with the vanilla client.
// use crate::{
    // rust: font::Font,
    // rust: hud_layout::{Blend, GuiDraw, WHITE},
    // rust: java_text::float_to_string,
    // rust: scoreboard::{Comp, NumberFormat, Objective, RenderType, Scoreboard, comp_text},
    // rust: text::Text,
}
// use std::{borrow::Cow, cmp::Ordering, collections::HashMap};

/// `GameType.SPECTATOR` id.
pub const SPECTATOR: i32 = 3;
/// `PlayerTabOverlay.MAX_ROWS_PER_COL`.
pub const MAX_ROWS_PER_COL: i32 = 20;

/// One `PlayerInfo` the list can show.
pub const TabPlayer = struct {
    uuid: u128,
    /// `GameProfile.name`: the score holder and team member name.
    name: []const u8,
    /// `GameType` id (0 survival, 1 creative, 2 adventure, 3 spectator).
    game_mode: i32,
    /// Milliseconds; negative when unknown.
    latency: i32,
    /// `tabListDisplayName` as a component (its root style matters: a
    /// spectator's name is made italic at the root).
    display_name: ?Comp,
    list_order: i32,
    show_hat: bool,
    /// Skin texture path, e.g. `entity/player/wide/steve`.
    skin: []const u8,
};
    // rust: impl TabPlayer {
    /// A player with the default skin for their UUID.
pub fn new(uuid: u128, name: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: uuid,
    // rust: name: name.into(),
    // rust: game_mode: 0,
    // rust: latency: 0,
    // rust: display_name: None,
    // rust: list_order: 0,
    // rust: show_hat: true,
    // rust: skin: default_skin(uuid).to_owned(),
}
}
}

/// `DefaultPlayerSkin.get(UUID)`: the default skin by `UUID.hashCode`.
pub fn default_skin(uuid: u128) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const SKINS: [&str; 18] = [
    // rust: "entity/player/slim/alex",
    // rust: "entity/player/slim/ari",
    // rust: "entity/player/slim/efe",
    // rust: "entity/player/slim/kai",
    // rust: "entity/player/slim/makena",
    // rust: "entity/player/slim/noor",
    // rust: "entity/player/slim/steve",
    // rust: "entity/player/slim/sunny",
    // rust: "entity/player/slim/zuri",
    // rust: "entity/player/wide/alex",
    // rust: "entity/player/wide/ari",
    // rust: "entity/player/wide/efe",
    // rust: "entity/player/wide/kai",
    // rust: "entity/player/wide/makena",
    // rust: "entity/player/wide/noor",
    // rust: "entity/player/wide/steve",
    // rust: "entity/player/wide/sunny",
    // rust: "entity/player/wide/zuri",
    // rust: ];
    // rust: let hilo = ((uuid >> 64) as u64) ^ (uuid as u64);
    // rust: let hash = ((hilo >> 32) as i32) ^ (hilo as i32);
    // rust: SKINS[hash.rem_euclid(SKINS.len() as i32) as usize]
}

/// `blitSprite(sprite, x, y, w, h)`.
pub fn sprite(name: *'static str, x: i32, y: i32, w: i32, h: i32) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: GuiDraw::Sprite {
    // rust: sprite: Cow::Borrowed(name),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: region: None,
    // rust: color: WHITE,
    // rust: blend: crate::hud_layout::Blend::Textured,
}
}

/// `PlayerFaceExtractor.extractRenderState`: the skin's face, then its hat
/// layer, upside down for Dinnerbone and Grumm.
    // rust: pub fn face(
    // rust: out: &mut Vec<GuiDraw>,
    // rust: skin: &str,
    // rust: x: i32,
    // rust: y: i32,
    // rust: size: i32,
    // rust: hat: bool,
    // rust: flip: bool,
    // rust: color: u32,
    // rust: ) {
    // rust: let (v, height) = if flip { (16.0, -8) } else { (8.0, 8) };
    // rust: for u in [8.0, 40.0].into_iter().take(if hat { 2 } else { 1 }) {
    // rust: out.push(GuiDraw::Blit {
    // rust: texture: Cow::Owned(skin.to_owned()),
    // rust: blend: Blend::Textured,
    // rust: x,
    // rust: y,
    // rust: w: size,
    // rust: h: size,
    // rust: uv: [u, v],
    // rust: src: [8, height],
    // rust: tex: [64, 64],
    // rust: color,
    // rust: });
}
}

/// `Hud.extractTabList`: whether the list shows. A single-player world
/// shows it only with another listed player or a `list` objective.
pub fn visible(key_down: bool, local_server: bool, listed: usize, objective: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: key_down && !(local_server && listed <= 1 && !objective)
}

/// `Options.getBackgroundColor(553648127)`: the row background.
pub fn row_background(background_for_chat_only: bool, text_background_opacity: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if background_for_chat_only {
    // rust: 0x20FF_FFFF
    // rust: } else {
    // rust: ((text_background_opacity as f32 * 255.0).floor() as i32 as u32 & 0xFF) << 24
}
}

/// `String.compareTo`: UTF-16 code unit order.
pub fn compare_utf16(a: []const u8, b: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.encode_utf16().cmp(b.encode_utf16())
}
/// `String.compareToIgnoreCase` (per code point: upper then lower case).
pub fn compare_ignore_case(a: []const u8, b: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
pub fn simple(c: char, upper: bool) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut it: Box<dyn Iterator<Item = char>> = if upper {
    // rust: Box::new(c.to_uppercase())
    // rust: } else {
    // rust: Box::new(c.to_lowercase())
}
    // rust: match (it.next(), it.next()) {
    // rust: (Some(m), None) => m,
    // rust: _ => c,
}
}
    // rust: let (mut x, mut y) = (a.chars(), b.chars());
    // rust: loop {
    // rust: match (x.next(), y.next()) {
    // rust: (Some(c1), Some(c2)) => {
    // rust: if c1 != c2 {
    // rust: let (u1, u2) = (simple(c1, true), simple(c2, true));
    // rust: if u1 != u2 {
    // rust: let (l1, l2) = (simple(u1, false), simple(u2, false));
    // rust: if l1 != l2 {
    // rust: return l1.cmp(&l2);
}
}
}
}
    // rust: (None, None) => return Ordering::Equal,
    // rust: (None, Some(_)) => return Ordering::Less,
    // rust: (Some(_), None) => return Ordering::Greater,
}
}
}

/// `PlayerTabOverlay.getPlayerInfos`: `PLAYER_COMPARATOR` order (higher
/// list order first, spectators last, team name, profile name ignoring
/// case), at most 80 players.
    // rust: pub fn sorted_players<'a>(players: &'a [TabPlayer], board: &Scoreboard) -> Vec<&'a TabPlayer> {
    // rust: let team = |p: &TabPlayer| {
    // rust: board
    // rust: .players_team(&p.name)
    // rust: .map_or("", |t| t.name.as_str())
    // rust: .to_owned()
}
    // rust: let mut out: Vec<&TabPlayer> = players.iter().collect();
    // rust: out.sort_by(|a, b| {
    // rust: a.list_order
    // rust: .wrapping_neg()
    // rust: .cmp(&b.list_order.wrapping_neg())
    // rust: .then_with(|| (a.game_mode == SPECTATOR).cmp(&(b.game_mode == SPECTATOR)))
    // rust: .then_with(|| compare_utf16(&team(a), &team(b)))
    // rust: .then_with(|| compare_ignore_case(&a.name, &b.name))
    // rust: });
    // rust: out.truncate(80);
    // rust: out
}

/// What `setVisible(true)` has the narrator say:
/// `multiplayer.player.list.narration` with the listed players' names
/// (`ComponentUtils.formatList` with ", ").
pub fn narration(players: *[TabPlayer], board: *Scoreboard) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::translate(
    // rust: "multiplayer.player.list.narration",
    // rust: &[listed_names(players, board)],
    // rust: )
}

/// The names the list shows, in its order, ", " between them.
pub fn listed_names(players: *[TabPlayer], board: *Scoreboard) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sorted_players(players, board)
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .fold(Text::empty(), |names, (i, p)| {
    // rust: let names = if i == 0 {
    // rust: names
    // rust: } else {
    // rust: names.append(Text::literal(", "))
}
    // rust: names.append(name_for_display(p, board))
    // rust: })
}

/// `MutableComponent.withStyle(ITALIC)` on a component's root.
pub fn italic_root(c: *Comp) C {
    // Implementation ported from Horizon
    return undefined;
}
//     use serde_json::Value;
    // rust: match c {
    // rust: Value::Object(o) => {
    // rust: let mut o = o.clone();
    // rust: o.insert("italic".into(), Value::Bool(true));
    // rust: Value::Object(o)
}
        // A list is its first element with the rest as its siblings.
    // rust: Value::Array(list) if !list.is_empty() => {
    // rust: let mut list = list.clone();
    // rust: list[0] = italic_root(&list[0]);
    // rust: Value::Array(list)
}
    // rust: Value::Array(_) => serde_json::json!({"text": "", "italic": true}),
    // rust: other => {
    // rust: let text = match other {
    // rust: Value::String(s) => s.clone(),
    // rust: Value::Null => String::new(),
    // rust: v => v.to_string(),
}
    // rust: serde_json::json!({"text": text, "italic": true})
}
}
}

/// `PlayerTabOverlay.getNameForDisplay`.
pub fn name_for_display(p: *TabPlayer, board: *Scoreboard) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let spectator = p.game_mode == SPECTATOR;
    // rust: let name = match &p.display_name {
    // rust: Some(d) if spectator => return comp_text(&italic_root(d)),
    // rust: Some(d) => return comp_text(d),
    // rust: None => match board.players_team(&p.name) {
    // rust: Some(team) => team.formatted_name(Text::literal(p.name.clone())),
    // rust: None => Text::literal(p.name.clone()),
    // rust: },
}
    // rust: if spectator { name.italic() } else { name }
}

/// `PlayerTabOverlay.extractPingIcon`'s sprite.
pub fn ping_sprite(latency: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match latency {
    // rust: i32::MIN..=-1 => "icon/ping_unknown",
    // rust: 0..150 => "icon/ping_5",
    // rust: 150..300 => "icon/ping_4",
    // rust: 300..600 => "icon/ping_3",
    // rust: 600..1000 => "icon/ping_2",
    // rust: _ => "icon/ping_1",
}
}

/// `PlayerTabOverlay.HealthState`: the hearts of one player.
pub const HealthState = struct {
    last_value: i32,
    displayed_value: i32,
    last_update_tick: i64,
    blink_until_tick: i64,
};
    // rust: impl HealthState {
pub fn new(value: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: last_value: value,
    // rust: displayed_value: value,
    // rust: last_update_tick: 0,
    // rust: blink_until_tick: 0,
}
}
pub fn update(self: *Self, value: i32, tick: i64) void {
}
    // rust: if value != self.last_value {
    // rust: let duration = if value < self.last_value { 20 } else { 10 };
    // rust: self.blink_until_tick = tick + duration;
    // rust: self.last_value = value;
    // rust: self.last_update_tick = tick;
}
    // rust: if tick - self.last_update_tick > 20 {
    // rust: self.displayed_value = value;
}
}
pub fn is_blinking(self: *Self, tick: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blink_until_tick > tick && (self.blink_until_tick - tick) % 6 >= 3
}
}

/// What the list is drawn from this frame.
pub const TabInputs = struct {
    /// The listed players (`getListedOnlinePlayers`), in any order.
    players: *'a [TabPlayer],
    board: *'a Scoreboard,
    /// The objective in the `list` display slot.
    objective: ?*'a Objective,
    screen_width: i32,
    /// `ClientPacketListener.onlineMode`: heads are shown.
    online_mode: bool,
    /// `Hud.getGuiTicks`.
    gui_ticks: i64,
    /// [`row_background`].
    background: u32,
    /// The player is in the level with an upside-down name
    /// (`AvatarRenderer.isPlayerUpsideDown`).
    upside_down: *'a dyn Fn(u128) -> bool,
    /// The player plays Horizon: Horizon's mark after their head (`horizon_cosmetics::mark`).
    horizon: *'a dyn Fn(u128) -> bool,
};

/// `PlayerTabOverlay`: the header, footer, visibility and heart states.
pub const TabList = struct {
    header: ?Text,
    footer: ?Text,
    visible: bool,
    health: HashMap<u128,
};
pub const Entry = struct {
    name: Text,
    score: i32,
    formatted: ?Text,
    score_width: i32,
};
    // rust: impl TabList {
    /// `setVisible`: showing or hiding forgets the heart states.
    /// `setVisible`: true when the list has just come up, which vanilla
    /// narrates ([`narration`]).
pub fn set_visible(self: *Self, visible: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.visible != visible {
    // rust: self.health.clear();
    // rust: self.visible = visible;
    // rust: return visible;
}
    // rust: false
}
    /// `reset`.
pub fn reset(self: *Self) void {
}
    // rust: self.header = None;
    // rust: self.footer = None;
}
    /// `extractRenderState`.
pub fn layout(self: *Self, i: *TabInputs, font: *Font) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let width = |t: &Text| font.width_text(t) as i32;
    // rust: let players = sorted_players(i.players, i.board);
    // rust: let spacer = font.width(" ") as i32;
    // rust: let mut max_name = 0;
    // rust: let mut max_score = 0;
    // rust: let mut entries = Vec::with_capacity(players.len());
    // rust: for p in &players {
    // rust: let name = name_for_display(p, i.board).resolve_legacy();
    // rust: max_name = max_name.max(width(&name));
    // rust: let mut entry = Entry {
    // rust: name,
    // rust: score: 0,
    // rust: formatted: None,
    // rust: score_width: 0,
}
    // rust: if let Some(objective) = i.objective {
    // rust: let info = i.board.score(&p.name, &objective.name);
    // rust: if let Some(s) = info {
    // rust: entry.score = s.value;
}
    // rust: if objective.render_type != RenderType::Hearts {
    // rust: if let Some(s) = info {
    // rust: let default =
    // rust: objective.format_or_default(NumberFormat::player_list_default());
    // rust: let text = s
    // rust: .number_format
    // rust: .as_ref()
    // rust: .unwrap_or(&default)
    // rust: .format(s.value)
    // rust: .resolve_legacy();
    // rust: entry.score_width = width(&text);
    // rust: entry.formatted = Some(text);
}
    // rust: let w = if entry.score_width > 0 {
    // rust: spacer + entry.score_width
    // rust: } else {
    // rust: 0
}
    // rust: max_score = max_score.max(w);
}
}
    // rust: entries.push(entry);
}
    // rust: if !self.health.is_empty() {
    // rust: self.health
    // rust: .retain(|id, _| players.iter().any(|p| p.uuid == *id));
}
    // rust: let slots = players.len() as i32;
    // rust: let mut rows = slots;
    // rust: let mut cols = 1;
    // rust: while rows > MAX_ROWS_PER_COL {
    // rust: cols += 1;
    // rust: rows = (slots + cols - 1) / cols;
}
    // rust: let show_head = i.online_mode;
    // rust: let width_for_score = match i.objective {
    // rust: Some(o) if o.render_type == RenderType::Hearts => 90,
    // rust: Some(_) => max_score,
    // rust: None => 0,
}
    // rust: let sw = i.screen_width;
    // rust: let head = if show_head { 9 } else { 0 };
        // Horizon: a column for the mark once anyone listed has it, so the names stay aligned.
    // rust: let marked: Vec<bool> = players.iter().map(|p| (i.horizon)(p.uuid)).collect();
    // rust: let mark = if marked.contains(&true) { 9 } else { 0 };
    // rust: let head = head + mark;
    // rust: let slot_width = (cols * (head + max_name + width_for_score + 13)).min(sw - 50) / cols;
    // rust: let xxo = sw / 2 - (slot_width * cols + (cols - 1) * 5) / 2;
    // rust: let mut yyo = 10;
    // rust: let mut max_line = slot_width * cols + (cols - 1) * 5;
    // rust: let split = |t: &Option<Text>| {
    // rust: t.as_ref().map(|t| {
    // rust: font.split_lines(&t.resolve_legacy(), (sw - 50) as f32)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .collect::<Vec<_>>()
    // rust: })
}
    // rust: let header = split(&self.header);
    // rust: let footer = split(&self.footer);
    // rust: for line in header.iter().chain(footer.iter()).flatten() {
    // rust: max_line = max_line.max(width(line));
}
    // rust: let mut out = Vec::new();
    // rust: let band = |y0: i32, y1: i32| GuiDraw::Fill {
    // rust: x0: sw / 2 - max_line / 2 - 1,
    // rust: y0,
    // rust: x1: sw / 2 + max_line / 2 + 1,
    // rust: y1,
    // rust: color: 0x8000_0000,
}
    // rust: if let Some(lines) = &header {
    // rust: out.push(band(yyo - 1, yyo + lines.len() as i32 * 9));
    // rust: for line in lines {
    // rust: let w = width(line);
    // rust: out.push(GuiDraw::Text {
    // rust: text: line.clone(),
    // rust: x: sw / 2 - w / 2,
    // rust: y: yyo,
    // rust: color: 0xFFFF_FFFF,
    // rust: shadow: true,
    // rust: });
    // rust: yyo += 9;
}
    // rust: yyo += 1;
}
    // rust: out.push(band(yyo - 1, yyo + rows * 9));
    // rust: for (n, (p, entry)) in players.iter().zip(&entries).enumerate() {
    // rust: let n = n as i32;
    // rust: let (col, row) = (n / rows, n % rows);
    // rust: let mut xo = xxo + col * slot_width + col * 5;
    // rust: let yo = yyo + row * 9;
    // rust: out.push(GuiDraw::Fill {
    // rust: x0: xo,
    // rust: y0: yo,
    // rust: x1: xo + slot_width,
    // rust: y1: yo + 8,
    // rust: color: i.background,
    // rust: });
    // rust: if show_head {
    // rust: face(
    // rust: &mut out,
    // rust: &p.skin,
    // rust: xo,
    // rust: yo,
    // rust: 8,
    // rust: p.show_hat,
    // rust: (i.upside_down)(p.uuid),
    // rust: WHITE,
    // rust: );
    // rust: xo += 9;
}
    // rust: if marked[n as usize] {
    // rust: for (mx, my, w, h, color) in horizon_cosmetics::mark::MARK {
    // rust: let (x, y) = (xo + i32::from(mx), yo + i32::from(my));
    // rust: let (x1, y1) = (x + i32::from(w), y + i32::from(h));
    // rust: out.push(GuiDraw::Fill {
    // rust: x0: x,
    // rust: y0: y,
    // rust: x1,
    // rust: y1,
    // rust: color,
    // rust: });
}
}
    // rust: xo += mark;
    // rust: let spectator = p.game_mode == SPECTATOR;
    // rust: out.push(GuiDraw::Text {
    // rust: text: entry.name.clone(),
    // rust: x: xo,
    // rust: y: yo,
    // rust: color: if spectator { 0x90FF_FFFF } else { 0xFFFF_FFFF },
    // rust: shadow: true,
    // rust: });
    // rust: if let Some(objective) = i.objective.filter(|_| !spectator) {
    // rust: let left = xo + max_name + 1;
    // rust: let right = left + width_for_score;
    // rust: if right - left > 5 {
    // rust: if objective.render_type == RenderType::Hearts {
    // rust: self.hearts(
    // rust: yo,
    // rust: left,
    // rust: right,
    // rust: p.uuid,
    // rust: entry.score,
    // rust: i.gui_ticks,
    // rust: font,
    // rust: &mut out,
    // rust: );
    // rust: } else if let Some(text) = &entry.formatted {
    // rust: out.push(GuiDraw::Text {
    // rust: text: text.clone(),
    // rust: x: right - entry.score_width,
    // rust: y: yo,
    // rust: color: 0xFFFF_FFFF,
    // rust: shadow: true,
    // rust: });
}
}
}
    // rust: out.push(sprite(
    // rust: ping_sprite(p.latency),
    // rust: xo - head + slot_width - 11,
    // rust: yo,
    // rust: 10,
    // rust: 8,
    // rust: ));
}
    // rust: if let Some(lines) = &footer {
    // rust: yyo += rows * 9 + 1;
    // rust: out.push(band(yyo - 1, yyo + lines.len() as i32 * 9));
    // rust: for line in lines {
    // rust: let w = width(line);
    // rust: out.push(GuiDraw::Text {
    // rust: text: line.clone(),
    // rust: x: sw / 2 - w / 2,
    // rust: y: yyo,
    // rust: color: 0xFFFF_FFFF,
    // rust: shadow: true,
    // rust: });
    // rust: yyo += 9;
}
}
    // rust: out
}
    /// `extractTablistHearts`.
    // rust: fn hearts(
    // rust: &mut self,
    // rust: yo: i32,
    // rust: left: i32,
    // rust: right: i32,
    // rust: id: u128,
    // rust: score: i32,
    // rust: tick: i64,
    // rust: font: &Font,
    // rust: out: &mut Vec<GuiDraw>,
    // rust: ) {
    // rust: let health = self
    // rust: .health
    // rust: .entry(id)
    // rust: .or_insert_with(|| HealthState::new(score));
    // rust: health.update(score, tick);
    // rust: let displayed = health.displayed_value;
    // rust: let blink = health.is_blinking(tick);
        // Mth.positiveCeilDiv.
    // rust: let full_hearts = -((-score.max(displayed)).div_euclid(2));
    // rust: let to_render = score.max(displayed.max(20)) / 2;
    // rust: if full_hearts <= 0 {
    // rust: return;
}
    // rust: let per_heart = ((right - left - 4) as f32 / to_render as f32)
    // rust: .min(9.0)
    // rust: .floor() as i32;
    // rust: if per_heart <= 3 {
    // rust: let pct = (score as f32 / 20.0).clamp(0.0, 1.0);
    // rust: let color = (((1.0 - pct) * 255.0) as i32) << 16 | ((pct * 255.0) as i32) << 8;
    // rust: let hearts = score as f32 / 2.0;
    // rust: let hp = Text::translate(
    // rust: "multiplayer.player.list.hp",
    // rust: &[Text::literal(float_to_string(hearts))],
    // rust: );
    // rust: let text = if right - font.width_text(&hp) as i32 >= left {
    // rust: hp
    // rust: } else {
    // rust: Text::literal(float_to_string(hearts))
}
    // rust: let w = font.width_text(&text) as i32;
    // rust: out.push(GuiDraw::Text {
    // rust: text,
    // rust: x: (right + left - w) / 2,
    // rust: y: yo,
    // rust: color: color as u32 | 0xFF00_0000,
    // rust: shadow: true,
    // rust: });
    // rust: return;
}
    // rust: let container = if blink {
    // rust: "hud/heart/container_blinking"
    // rust: } else {
    // rust: "hud/heart/container"
}
    // rust: let heart = |name: &'static str, n: i32| sprite(name, left + n * per_heart, yo, 9, 9);
    // rust: for n in full_hearts..to_render {
    // rust: out.push(heart(container, n));
}
    // rust: for n in 0..full_hearts {
    // rust: out.push(heart(container, n));
    // rust: if blink {
    // rust: if n * 2 + 1 < displayed {
    // rust: out.push(heart("hud/heart/full_blinking", n));
}
    // rust: if n * 2 + 1 == displayed {
    // rust: out.push(heart("hud/heart/half_blinking", n));
}
}
    // rust: if n * 2 + 1 < score {
    // rust: out.push(heart(
    // rust: if n >= 10 {
    // rust: "hud/heart/absorbing_full_blinking"
    // rust: } else {
    // rust: "hud/heart/full"
    // rust: },
    // rust: n,
    // rust: ));
}
    // rust: if n * 2 + 1 == score {
    // rust: out.push(heart(
    // rust: if n >= 10 {
    // rust: "hud/heart/absorbing_half_blinking"
    // rust: } else {
    // rust: "hud/heart/half"
    // rust: },
    // rust: n,
    // rust: ));
}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn the_list_is_narrated_once_as_it_comes_up_with_its_names_in_order() void {
}
    // rust: let board = Scoreboard::default();
    // rust: let mut alice = TabPlayer::new(2, "Alice");
    // rust: alice.list_order = -1;
    // rust: let players = [TabPlayer::new(1, "bob"), alice];
    // rust: assert_eq!(listed_names(&players, &board).plain(), "bob, Alice");
    // rust: let mut list = TabList::default();
    // rust: assert!(list.set_visible(true));
    // rust: assert!(!list.set_visible(true), "only as it comes up");
    // rust: assert!(!list.set_visible(false));
    // rust: assert!(list.set_visible(true));
}

pub fn order_ping_and_skins() void {
}
    // rust: let board = Scoreboard::default();
    // rust: let mut a = TabPlayer::new(1, "bob");
    // rust: let mut b = TabPlayer::new(2, "Alice");
    // rust: let c = TabPlayer::new(3, "carl");
    // rust: a.game_mode = SPECTATOR;
    // rust: b.list_order = -1;
    // rust: let players = [a, b, c];
    // rust: let names: Vec<_> = sorted_players(&players, &board)
    // rust: .iter()
    // rust: .map(|p| p.name.as_str())
    // rust: .collect();
    // rust: assert_eq!(names, ["carl", "bob", "Alice"]);
    // rust: assert_eq!(ping_sprite(-1), "icon/ping_unknown");
    // rust: assert_eq!(ping_sprite(149), "icon/ping_5");
    // rust: assert_eq!(ping_sprite(1000), "icon/ping_1");
        // UUID.hashCode of 0 is 0: the first default skin.
    // rust: assert_eq!(default_skin(0), "entity/player/slim/alex");
    // rust: assert!(!visible(true, true, 1, false));
    // rust: assert!(visible(true, true, 1, true));
    // rust: assert!(visible(true, false, 1, false));
}
}
