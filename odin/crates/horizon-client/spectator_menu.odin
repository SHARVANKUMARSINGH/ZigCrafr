//! Transpiled from Horizon Rust crate
package horizon_client_spectator_menu

import "core:fmt"
import "core:mem"
import "core:math"

// The spectator menu: `SpectatorGui` (the faded hotbar and the prompt under
// it) over `SpectatorMenu` with its root page, Teleport to Player and
// Teleport to Team Member, laid out as [`GuiDraw`] calls.
// use crate::{
    // rust: font::Font,
    // rust: hud_layout::{Blend, GuiDraw, argb, color_from_float, fill, white, width},
    // rust: hud_overlays::text_with_backdrop,
    // rust: text::Text,
}
// use std::borrow::Cow;

// `SpectatorGui.FADE_OUT_DELAY` and `FADE_OUT_TIME`, in milliseconds.
FADE_OUT_DELAY :: 5000
FADE_OUT_TIME :: 2000.0

// A player of the menu (`PlayerMenuItem`).
Member :: struct {
    uuid: u128,
    name: string,
    // Skin texture path, as the tab list draws it.
    skin: string,
    // `PlayerInfo.getGameMode() != GameType.SPECTATOR`.
    enabled: bool,
}

// A team with players to go to (`TeamSelectionItem`).
Team :: struct {
    name: Text,
    // The team colour's RGB.
    color: Maybe(u32),
    players: [dynamic]Member,
    // The skin of the face drawn on the icon.
    icon: string,
}

// A `SpectatorMenuItem`.
Item :: enum {
    Empty,
    Close,
    Scroll { left: bool, enabled: bool },
    TeleportToPlayer { enabled: bool },
    TeleportToTeam { enabled: bool },
    Player(Member),
    Team(Team),
}
    // rust: impl Item {
enabled :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Item::Empty => false,
    // rust: Item::Close | Item::Team(_) => true,
    // rust: Item::Scroll { enabled, .. }
    // rust: | Item::TeleportToPlayer { enabled }
    // rust: | Item::TeleportToTeam { enabled } => *enabled,
    // rust: Item::Player(m) => m.enabled,
}
}
    // `SpectatorMenuItem.getName`.
name :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Item::Empty => Text::literal(""),
    // rust: Item::Close => Text::translate("spectatorMenu.close", &[]),
    // rust: Item::Scroll { left: true, .. } => Text::translate("spectatorMenu.previous_page", &[]),
    // rust: Item::Scroll { .. } => Text::translate("spectatorMenu.next_page", &[]),
    // rust: Item::TeleportToPlayer { .. } => Text::translate("spectatorMenu.teleport", &[]),
    // rust: Item::TeleportToTeam { .. } => Text::translate("spectatorMenu.team_teleport", &[]),
    // rust: Item::Player(m) => Text::literal(m.name.clone()),
    // rust: Item::Team(t) => t.name.clone(),
}
}
}

// What a selected item asks the game to do.
Outcome :: enum {
    None,
    // `SpectatorMenu.exit`.
    Exit,
    // `ServerboundTeleportToEntityPacket` for this player.
    Teleport(u128),
}

Category :: enum {
    Root,
    Players,
    Teams,
    TeamPlayers(Vec<Member>),
}

// `TeleportToPlayerMenuCategory`: players that are not spectators, ordered
// by `UUID.compareTo` (signed halves).
players_page :: proc(mut players: [dynamic]Member) -> V {
    // Ported from Horizon
    return {}
}
    // rust: players.retain(|m| m.enabled);
    // rust: players.sort_by_key(|m| ((m.uuid >> 64) as i64, m.uuid as i64));
    // rust: players
}

// `SpectatorMenu`: the page, the selected slot and the page of its items.
SpectatorMenu :: struct {
    players: [dynamic]Member,
    teams: [dynamic]Team,
    category: Category,
    selected: i32,
    page: i32,
}
    // rust: impl SpectatorMenu {
    // `new SpectatorMenu`: the root page, whose categories take the players
    // and teams as they are now.
new :: proc(players: [dynamic]Member, teams: [dynamic]Team) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: players: players_page(players),
    // rust: teams,
    // rust: category: Category::Root,
    // rust: selected: -1,
    // rust: page: 0,
}
}
    // `SpectatorMenuCategory.getItems`.
category_items :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match &self.category {
    // rust: Category::Root => vec![
    // rust: Item::TeleportToPlayer {
    // rust: enabled: !self.players.is_empty(),
    // rust: },
    // rust: Item::TeleportToTeam {
    // rust: enabled: !self.teams.is_empty(),
    // rust: },
    // rust: ],
    // rust: Category::Players => self.players.iter().cloned().map(Item::Player).collect(),
    // rust: Category::Teams => self.teams.iter().cloned().map(Item::Team).collect(),
    // rust: Category::TeamPlayers(list) => list.iter().cloned().map(Item::Player).collect(),
}
}
    // `SpectatorMenuCategory.getPrompt`.
prompt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(
    // rust: match self.category {
    // rust: Category::Root => "spectatorMenu.root.prompt",
    // rust: Category::Teams => "spectatorMenu.team_teleport.prompt",
    // rust: _ => "spectatorMenu.teleport.prompt",
    // rust: },
    // rust: &[],
    // rust: )
}
    // `SpectatorMenu.getItem`: six items a page between the scroll arrows.
item :: proc(self: ^Self, slot: i32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let items = self.category_items();
    // rust: let index = slot + self.page * 6;
    // rust: if self.page > 0 && slot == 0 {
    // rust: Item::Scroll {
    // rust: left: true,
    // rust: enabled: true,
}
    // rust: } else if slot == 7 {
    // rust: Item::Scroll {
    // rust: left: false,
    // rust: enabled: index >= 0 && (index as usize) < items.len(),
}
    // rust: } else if slot == 8 {
    // rust: Item::Close
    // rust: } else if index >= 0 && (index as usize) < items.len() {
    // rust: items[index as usize].clone()
    // rust: } else {
    // rust: Item::Empty
}
}
selected_slot :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.selected
}
    // `SpectatorMenu.selectSlot`: a first press selects, a second uses it.
select_slot :: proc(self: ^Self, slot: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let item = self.item(slot);
    // rust: if item == Item::Empty {
    // rust: return Outcome::None;
}
    // rust: if self.selected != slot || !item.enabled() {
    // rust: self.selected = slot;
    // rust: return Outcome::None;
}
    // rust: match item {
    // rust: Item::Close => return Outcome::Exit,
    // rust: Item::Scroll { left, .. } => self.page += if left { -1 } else { 1 },
    // rust: Item::TeleportToPlayer { .. } => self.select_category(Category::Players),
    // rust: Item::TeleportToTeam { .. } => self.select_category(Category::Teams),
    // rust: Item::Team(t) => self.select_category(Category::TeamPlayers(players_page(t.players))),
    // rust: Item::Player(m) => return Outcome::Teleport(m.uuid),
    // rust: Item::Empty => {}
}
    // rust: Outcome::None
}
    // `SpectatorMenu.selectCategory`.
select_category :: proc(self: ^Self, category: Category) {
}
    // rust: self.category = category;
    // rust: self.selected = -1;
    // rust: self.page = 0;
}
}

// `SpectatorGui`: the menu while it is up and when it was last used.
SpectatorGui :: struct {
    menu: Maybe(SpectatorMenu),
    last_selection: i64,
}
    // rust: impl SpectatorGui {
is_menu_active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.menu.is_some()
}
apply :: proc(self: ^Self, outcome: Outcome) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if outcome == Outcome::Exit {
            // onSpectatorMenuClosed.
    // rust: self.menu = None;
    // rust: self.last_selection = 0;
}
    // rust: outcome
}
    // `SpectatorGui.onHotbarSelected`: a number key.
    // `fresh` is the menu to open when none is up.
    // rust: pub fn on_hotbar_selected(
    // rust: &mut self,
    // rust: slot: i32,
    // rust: now: i64,
    // rust: fresh: Option<SpectatorMenu>,
    // rust: ) -> Outcome {
    // rust: self.last_selection = now;
    // rust: match &mut self.menu {
    // rust: Some(menu) => {
    // rust: let outcome = menu.select_slot(slot);
    // rust: self.apply(outcome)
}
    // rust: None => {
    // rust: self.menu = fresh;
    // rust: Outcome::None
}
}
}
    // `SpectatorGui.onHotbarActionKeyPressed`: the key that opens the menu
    // and uses the selected item.
on_action_key :: proc(self: ^Self, now: i64, fresh: Maybe(SpectatorMenu)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.last_selection = now;
    // rust: match &mut self.menu {
    // rust: Some(menu) => {
    // rust: let slot = menu.selected_slot();
    // rust: if slot == -1 {
    // rust: return Outcome::None;
}
    // rust: let outcome = menu.select_slot(slot);
    // rust: self.apply(outcome)
}
    // rust: None => {
    // rust: self.menu = fresh;
    // rust: Outcome::None
}
}
}
    // `SpectatorGui.onMouseScrolled`: the next usable slot that way.
on_mouse_scrolled :: proc(self: ^Self, wheel: i32, now: i64) {
}
    // rust: let Some(menu) = &mut self.menu else {
    // rust: return;
}
    // rust: let usable = |menu: &SpectatorMenu, slot: i32| {
    // rust: let item = menu.item(slot);
    // rust: item != Item::Empty && item.enabled()
}
    // rust: let mut slot = menu.selected_slot() + wheel;
    // rust: while (0..=8).contains(&slot) && !usable(menu, slot) {
    // rust: slot += wheel;
}
    // rust: if (0..=8).contains(&slot) {
    // rust: menu.select_slot(slot);
    // rust: self.last_selection = now;
}
}
    // `SpectatorGui.getHotbarAlpha`.
alpha :: proc(self: ^Self, now: i64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let delta = self.last_selection - now + FADE_OUT_DELAY;
    // rust: (delta as f32 / FADE_OUT_TIME).clamp(0.0, 1.0)
}
    // `SpectatorGui.extractHotbar`: the page's nine slots; a menu that has
    // faded out exits instead. `key_label` is the hotbar key of a slot.
    // rust: pub fn hotbar(
    // rust: &mut self,
    // rust: w: i32,
    // rust: h: i32,
    // rust: now: i64,
    // rust: key_label: &dyn Fn(usize) -> Text,
    // rust: font: &Font,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let mut out = Vec::new();
    // rust: let alpha = self.alpha(now);
    // rust: if self.menu.is_some() && alpha <= 0.0 {
    // rust: self.apply(Outcome::Exit);
}
    // rust: let Some(menu) = &self.menu else {
    // rust: return out;
}
    // rust: let center = w / 2;
    // rust: let y = (h as f32 - 22.0 * alpha).floor() as i32;
    // rust: let color = white(alpha);
    // rust: out.push(sprite("hud/hotbar", center - 91, y, 182, 22, color));
    // rust: if menu.selected_slot() >= 0 {
    // rust: out.push(sprite(
    // rust: "hud/hotbar_selection",
    // rust: center - 91 - 1 + menu.selected_slot() * 20,
    // rust: y - 1,
    // rust: 24,
    // rust: 23,
    // rust: color,
    // rust: ));
}
    // rust: for slot in 0..9 {
    // rust: let item = menu.item(slot);
    // rust: if item == Item::Empty {
    // rust: continue;
}
    // rust: let x = center - 90 + slot * 20 + 2;
    // rust: let brightness = if item.enabled() { 1.0 } else { 0.25 };
    // rust: icon(&mut out, &item, x, y + 3, brightness, alpha);
    // rust: if item.enabled() {
    // rust: let label = key_label(slot as usize);
    // rust: let lw = width(font, &label);
    // rust: out.push(GuiDraw::Text {
    // rust: text: label,
    // rust: x: x + 19 - 2 - lw,
    // rust: y: y + 3 + 6 + 3,
    // rust: color,
    // rust: shadow: true,
    // rust: });
}
}
    // rust: out
}
    // `SpectatorGui.extractAction`: the selected item's name, or the
    // page's prompt, over the hotbar.
action :: proc(self: ^Self, w: i32, h: i32, now: i64, font: ^Font, background: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let alpha = self.alpha(now);
    // rust: let Some(menu) = &self.menu else {
    // rust: return out;
}
    // rust: if alpha <= 0.0 {
    // rust: return out;
}
    // rust: let item = menu.item(menu.selected_slot());
    // rust: let action = if item == Item::Empty {
    // rust: menu.prompt()
    // rust: } else {
    // rust: item.name()
}
    // rust: let str_width = width(font, &action);
    // rust: text_with_backdrop(
    // rust: &mut out,
    // rust: action,
    // rust: (w - str_width) / 2,
    // rust: h - 35,
    // rust: str_width,
    // rust: white(alpha),
    // rust: background,
    // rust: );
    // rust: out
}
}

sprite :: proc(name: ^'static str, x: i32, y: i32, w: i32, h: i32, color: u32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GuiDraw::Sprite {
    // rust: sprite: Cow::Borrowed(name),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: region: None,
    // rust: color,
    // rust: blend: Blend::Textured,
}
}

// `SpectatorMenuItem.extractIcon` at the slot's corner.
icon :: proc(out: ^[dynamic]GuiDraw, item: ^Item, x: i32, y: i32, brightness: f32, alpha: f32) {
}
    // rust: let tint = color_from_float(alpha, brightness, brightness, brightness);
    // rust: match item {
    // rust: Item::Empty => {}
    // rust: Item::Close => out.push(sprite("spectator/close", x, y, 16, 16, tint)),
    // rust: Item::Scroll { left, .. } => out.push(sprite(
    // rust: if *left {
    // rust: "spectator/scroll_left"
    // rust: } else {
    // rust: "spectator/scroll_right"
    // rust: },
    // rust: x,
    // rust: y,
    // rust: 16,
    // rust: 16,
    // rust: tint,
    // rust: )),
    // rust: Item::TeleportToPlayer { .. } => {
    // rust: out.push(sprite("spectator/teleport_to_player", x, y, 16, 16, tint));
}
    // rust: Item::TeleportToTeam { .. } => {
    // rust: out.push(sprite("spectator/teleport_to_team", x, y, 16, 16, tint));
}
    // rust: Item::Player(m) => crate::tab_list::face(out, &m.skin, x + 2, y + 2, 12, true, false, tint),
    // rust: Item::Team(t) => {
    // rust: if let Some(rgb) = t.color {
                // ARGB.scaleRGB.
    // rust: let c = |s: u32| (((rgb >> s) & 255) as f32 * brightness) as u32;
    // rust: out.push(fill(
    // rust: x + 1,
    // rust: y + 1,
    // rust: x + 15,
    // rust: y + 15,
    // rust: argb(255, c(16), c(8), c(0)),
    // rust: ));
}
    // rust: crate::tab_list::face(out, &t.icon, x + 2, y + 2, 12, true, false, tint);
}
}
}
