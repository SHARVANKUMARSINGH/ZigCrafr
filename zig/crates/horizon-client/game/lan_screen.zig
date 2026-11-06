//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_screen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! WorldOptionsScreen: the in-world options with the multiplayer section
//! that opens the world to the local network (the 26.3 replacement of the
//! old "Open to LAN" screen): default and personal game mode, cheats,
//! difficulty, LAN on/off with its port, command access for guests and
//! forcing the game mode. Its difficulty lock asks first (PopupScreen), and
//! Restrictions opens RestrictionsScreen.
//! Parity reference: https://mcsrc.dev/2/26.3/net/minecraft/client/gui/screens/WorldOptionsScreen
// use super::{Game, Screen, integrated::ServerOptions, lan::LanSettings};
// use horizon_client::{
    // rust: font::Font,
    // rust: game_rules_screen::{Exit, RulesScreen},
    // rust: hud::{HudBatch, rgba},
    // rust: text::{Text, named_color},
    // rust: ui::{self, EditBox},
    // rust: widgets::{self, Narratable, join_for_narration},
}
// use horizon_protocol::packets::play::{self, Serverbound as S};
// use winit::{event::KeyEvent, keyboard::PhysicalKey};

    // rust: pub(super) struct WorldOptions {
    // rust: remote: bool,
    // rust: gamemaster: bool,
    // rust: default_mode: i32,
    // rust: personal_mode: i32,
    // rust: cheats: bool,
    // rust: difficulty: u8,
    // rust: lan: bool,
    // rust: port: EditBox,
    /// The free port suggested while the box is empty.
    // rust: hint: u16,
    // rust: guest_commands: bool,
    // rust: force: bool,
    // rust: hardcore: bool,
    /// The level's own lock (LevelData.isDifficultyLocked).
    // rust: difficulty_locked: bool,
    /// wantedDifficultyLocked: the lock icon, from the lock or hardcore.
    // rust: locked: bool,
    // rust: initial: Snapshot,
    /// ScrollableLayout's scroll amount.
    // rust: scroll: f32,
    // rust: view: View,
    /// InWorldGameRulesScreen, while it is open.
    // rust: rules: Option<RulesScreen>,
    // rust: focused_button: Option<Button>,
    // rust: popup_focus: Option<usize>,
}
/// The screen on show: the options, the lock's question over them, or the
/// RestrictionsScreen or InWorldGameRulesScreen they opened (all return to
/// the same options).
pub const View = enum {
    Options,
    LockQuestion,
    Restrictions,
    GameRules,
};
pub const Snapshot = struct {
    default_mode: i32,
    personal_mode: i32,
    cheats: bool,
    difficulty: u8,
    locked: bool,
    lan: bool,
    port: u16,
    guest_commands: bool,
    force: bool,
};

pub const MODES: [[]const u8; 4] = ["survival", "creative", "adventure", "spectator"];
pub const DIFFICULTIES: [[]const u8; 4] = ["peaceful", "easy", "normal", "hard"];

/// HeaderAndFooterLayout's header and footer heights.
pub const HEADER: f32 = 33.0;
pub const FOOTER: f32 = 33.0;
/// The scrolled content: both grids, each padded by 8 and 8 apart.
pub const CONTENT: f32 = 218.0;
/// The category headings' tops (FocusableTextWidget, padding 4).
pub const GENERAL_TOP: f32 = 8.0;
pub const MULTIPLAYER_TOP: f32 = 145.0;
/// The port box's top beside the LAN button.
pub const PORT_TOP: f32 = 166.0;
/// PopupScreen: 250 wide less its 18 pixel border each side, two buttons
/// `min((214 - 6) / 2, 150)` wide and 6 apart, rows 12 apart.
pub const POPUP_CONTENT: f32 = 214.0;
pub const POPUP_BUTTON: f32 = 104.0;
/// RestrictionsScreen's text widgets: 250 wide, padded by 4.
pub const RESTRICTION_WIDTH: f32 = 250.0;

pub const Button = enum {
    DefaultMode,
    PersonalMode,
    Cheats,
    Difficulty,
    /// DifficultyButtons.lockButton (LockIconButton).
    Lock,
    GameRules,
    Restrictions,
    Lan,
    CommandAccess,
    Force,
    Apply,
    Cancel,
};

pub fn on_off(on: bool) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::translate(if on { "options.on" } else { "options.off" }, &[])
}
pub fn labelled(key: []const u8, value: Text) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::translate("options.generic_value", &[Text::translate(key, &[]), value])
}

    // rust: impl WorldOptions {
    /// No button keeps the focus a click gave it.
    // rust: pub(super) fn clear_click_focus(&mut self) {
    // rust: self.focused_button = None;
}
    /// Vanilla 26.3 WorldOptionsScreen.generalOptions: guests see difficulty,
    /// game rules and restrictions; game modes, commands and LAN are host-only.
pub fn visible_buttons(self: *Self, w: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.remote {
    // rust: return Self::buttons(w, self.top());
}
    // rust: let x = Self::left(w);
    // rust: let top = self.top();
    // rust: vec![
    // rust: (Button::Difficulty, x, top + 29.0, 130.0),
    // rust: (Button::Lock, x + 130.0, top + 29.0, 20.0),
    // rust: (Button::GameRules, x + 158.0, top + 29.0, 150.0),
    // rust: (Button::Restrictions, x, top + 53.0, 150.0),
    // rust: ]
}
pub fn content_height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remote { 81.0 } else { CONTENT }
}
pub fn scroll_limit(self: *Self, h: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.content_height() - (h - HEADER - FOOTER)).max(0.0)
}
pub fn server_difficulty(self: *Self, difficulty: u8, locked: bool) void {
}
        // A server update is the new baseline, not a local edit. In particular,
        // the reply to Apply may arrive after the screen has already reopened.
    // rust: self.difficulty = difficulty;
    // rust: self.difficulty_locked = locked;
    // rust: self.locked = locked || self.hardcore;
    // rust: self.initial.difficulty = self.difficulty;
    // rust: self.initial.locked = self.locked;
}
pub fn parsed_port(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.port.value.is_empty() {
    // rust: return Some(self.hint);
}
    // rust: self.port.value.parse::<u16>().ok().filter(|p| *p >= 1024)
}
pub fn snapshot(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Snapshot {
    // rust: default_mode: self.default_mode,
    // rust: personal_mode: self.personal_mode,
    // rust: cheats: self.cheats,
    // rust: difficulty: self.difficulty,
    // rust: locked: self.locked,
    // rust: lan: self.lan,
    // rust: port: if self.lan {
    // rust: self.parsed_port().unwrap_or(0)
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: guest_commands: self.guest_commands && self.lan && self.cheats,
    // rust: force: self.force,
}
}
pub fn changed(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let valid = !self.lan || self.parsed_port().is_some();
    // rust: valid && self.snapshot() != self.initial
}
    /// The scrolled content's top: under the header, less the scroll.
pub fn top(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HEADER - self.scroll.trunc()
}
    /// The grids' left edge: the content (308 wide, padded by 8) centred
    /// in a ScrollableLayout reserving 10 pixels for the scrollbar each side.
pub fn left(w: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (w / 2.0).floor() - 154.0
}
    /// The scrolled widgets: each grid's rows 4 apart, columns 8 apart.
pub fn buttons(w: f32, top: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = Self::left(w);
    // rust: let right = x + 158.0;
    // rust: vec![
    // rust: (Button::DefaultMode, x, top + 29.0, 308.0),
    // rust: (Button::PersonalMode, x, top + 53.0, 308.0),
    // rust: (Button::Cheats, x, top + 77.0, 150.0),
            // DifficultyButtons: the cycle button gives the lock its 20 pixels.
    // rust: (Button::Difficulty, right, top + 77.0, 130.0),
    // rust: (Button::Lock, right + 130.0, top + 77.0, 20.0),
    // rust: (Button::GameRules, x, top + 101.0, 150.0),
    // rust: (Button::Restrictions, right, top + 101.0, 150.0),
    // rust: (Button::Lan, x, top + 166.0, 150.0),
    // rust: (Button::CommandAccess, x, top + 190.0, 150.0),
    // rust: (Button::Force, right, top + 190.0, 150.0),
    // rust: ]
}
    /// The footer's two buttons, centred in its 33 pixels (FrameLayout
    /// truncates the 6.5 pixel offset).
pub fn footer(w: f32, h: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = Self::left(w);
    // rust: [
    // rust: (Button::Apply, x, h - FOOTER + 6.0, 150.0),
    // rust: (Button::Cancel, x + 158.0, h - FOOTER + 6.0, 150.0),
    // rust: ]
}
    /// The widgets under the pointer's row: scrolled ones only inside the
    /// scroll area.
pub fn hit(self: *Self) void {
}
    // rust: let inside = y >= HEADER && y < h - FOOTER;
    // rust: self.visible_buttons(w)
    // rust: .into_iter()
    // rust: .filter(|_| inside)
    // rust: .chain(Self::footer(w, h))
    // rust: .find(|(b, bx, by, bw)| self.active(*b) && ui::hovered((x, y), *bx, *by, *bw, 20.0))
    // rust: .map(|b| b.0)
}
pub fn label(self: *Self, b: Button) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mode = |m: i32| {
    // rust: Text::translate(
    // rust: &format!("selectWorld.gameMode.{}", MODES[m as usize & 3]),
    // rust: &[],
    // rust: )
}
    // rust: match b {
    // rust: Button::DefaultMode => {
    // rust: labelled("options.worldOptions.game_mode", mode(self.default_mode))
}
    // rust: Button::PersonalMode => labelled(
    // rust: "options.worldOptions.personal_game_mode",
    // rust: mode(self.personal_mode),
    // rust: ),
    // rust: Button::Cheats => labelled("selectWorld.allowCommands", on_off(self.cheats)),
    // rust: Button::Lock => Text::translate("narrator.button.difficulty_lock", &[]),
    // rust: Button::GameRules => Text::translate("editGamerule.inGame.button", &[]),
    // rust: Button::Restrictions => Text::translate("restrictions_screen.button", &[]),
    // rust: Button::Difficulty => labelled(
    // rust: "options.difficulty",
    // rust: Text::translate(
    // rust: &format!(
    // rust: "options.difficulty.{}",
    // rust: DIFFICULTIES[usize::from(self.difficulty) & 3]
    // rust: ),
    // rust: &[],
    // rust: ),
    // rust: ),
    // rust: Button::Lan => labelled("menu.multiplayerOptions.lan", on_off(self.lan)),
    // rust: Button::CommandAccess => labelled(
    // rust: "options.worldOptions.guest.command_access",
    // rust: on_off(self.guest_commands && self.lan && self.cheats),
    // rust: ),
    // rust: Button::Force => labelled(
    // rust: "options.worldOptions.guest.force_game_mode",
    // rust: on_off(self.force || !self.lan || self.hardcore),
    // rust: ),
    // rust: Button::Apply => Text::translate("menu.multiplayerOptions.applyChanges", &[]),
    // rust: Button::Cancel => Text::translate("gui.cancel", &[]),
}
}
    /// What button `b` narrates: the switches are `CycleButton`s ("<name>:
    /// <value> button" and the value a click moves to), the lock a
    /// `LockIconButton` (its message, then whether it is locked).
pub fn narration(self: *Self, b: Button, rect: [f32; 4], tr: super::screen_info::Tr<'_>) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let active = self.active(b);
    // rust: let mode = |m: i32| {
    // rust: tr(
    // rust: &format!("selectWorld.gameMode.{}", MODES[m as usize & 3]),
    // rust: &[],
    // rust: )
}
    // rust: let on_off = |on: bool| tr(if on { "options.on" } else { "options.off" }, &[]);
    // rust: let labelled =
    // rust: |key: &str, value: String| tr("options.generic_value", &[&tr(key, &[]), &value]);
    // rust: let difficulty = |d: u8| {
    // rust: let name = DIFFICULTIES[usize::from(d) & 3];
    // rust: labelled(
    // rust: "options.difficulty",
    // rust: tr(&format!("options.difficulty.{name}"), &[]),
    // rust: )
}
    // rust: let cycle = |message: String, next: String| Narratable::cycle(message, next, rect, active);
    // rust: let shown_access = self.guest_commands && self.lan && self.cheats;
    // rust: let shown_force = self.force || !self.lan || self.hardcore;
    // rust: match b {
    // rust: Button::DefaultMode => {
    // rust: let key = "options.worldOptions.game_mode";
    // rust: cycle(
    // rust: labelled(key, mode(self.default_mode)),
    // rust: labelled(key, mode(self.default_mode + 1)),
    // rust: )
}
    // rust: Button::PersonalMode => {
    // rust: let key = "options.worldOptions.personal_game_mode";
    // rust: cycle(
    // rust: labelled(key, mode(self.personal_mode)),
    // rust: labelled(key, mode(self.personal_mode + 1)),
    // rust: )
}
    // rust: Button::Cheats => {
    // rust: let key = "selectWorld.allowCommands";
    // rust: cycle(
    // rust: labelled(key, on_off(self.cheats)),
    // rust: labelled(key, on_off(!self.cheats)),
    // rust: )
}
    // rust: Button::Difficulty => cycle(
    // rust: difficulty(self.difficulty),
    // rust: difficulty(self.difficulty.wrapping_add(1)),
    // rust: ),
    // rust: Button::Lan => {
    // rust: let key = "menu.multiplayerOptions.lan";
    // rust: cycle(
    // rust: labelled(key, on_off(self.lan)),
    // rust: labelled(key, on_off(!self.lan)),
    // rust: )
}
    // rust: Button::CommandAccess => {
    // rust: let key = "options.worldOptions.guest.command_access";
    // rust: cycle(
    // rust: labelled(key, on_off(shown_access)),
    // rust: labelled(key, on_off(!shown_access)),
    // rust: )
}
    // rust: Button::Force => {
    // rust: let key = "options.worldOptions.guest.force_game_mode";
    // rust: cycle(
    // rust: labelled(key, on_off(shown_force)),
    // rust: labelled(key, on_off(!shown_force)),
    // rust: )
}
    // rust: Button::Lock => {
    // rust: let message = tr(
    // rust: "gui.narrate.button",
    // rust: &[&tr("narrator.button.difficulty_lock", &[])],
    // rust: );
    // rust: let state = if self.locked {
    // rust: "narrator.button.difficulty_lock.locked"
    // rust: } else {
    // rust: "narrator.button.difficulty_lock.unlocked"
}
    // rust: Narratable::named(
    // rust: join_for_narration(&[&message, &tr(state, &[])]),
    // rust: rect,
    // rust: active,
    // rust: )
}
    // rust: _ => Narratable::button(self.label(b).plain(), rect, active),
}
}
    /// WorldOptionsScreen.updateButton and the update*Button methods.
pub fn active(self: *Self, b: Button) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remote {
    // rust: return match b {
    // rust: Button::Difficulty | Button::Lock => {
    // rust: self.gamemaster && !self.hardcore && !self.difficulty_locked
}
    // rust: Button::GameRules => self.gamemaster,
    // rust: Button::Restrictions | Button::Cancel => true,
    // rust: Button::Apply => self.gamemaster && self.changed(),
    // rust: _ => false,
}
}
    // rust: match b {
    // rust: Button::DefaultMode | Button::PersonalMode => self.cheats && !self.hardcore,
            // An owner's commands come with Allow Commands.
    // rust: Button::Cheats => !self.hardcore || self.initial.cheats,
            // DifficultyButtons.updateDifficultyButtonsState: the level's
            // lock or hardcore, not the wanted lock.
    // rust: Button::Difficulty | Button::Lock => !self.hardcore && !self.difficulty_locked,
            // updateButton from the player's permission: the Allow Commands
            // switch leaves it (updatePermissionDependentButtons(.., false)).
    // rust: Button::GameRules => !self.hardcore && self.initial.cheats,
    // rust: Button::Restrictions => true,
    // rust: Button::CommandAccess => self.lan && self.cheats,
    // rust: Button::Force => self.lan && !(self.guest_commands && self.cheats) && !self.hardcore,
    // rust: Button::Apply => self.changed(),
    // rust: Button::Lan | Button::Cancel => true,
}
}
}

/// MultiLineLabel: the lines of `t` wrapped to `width`.
pub fn wrap(font: *Font, t: *Text, width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: font.split_lines(t, width)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .collect()
}
pub fn widest(font: *Font, lines: *[Text]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lines.iter().map(|l| font.width_text(l)).fold(0.0, f32::max)
}
/// Centred MultiLineTextWidget lines: each centred on `mid` from `top`, 9 apart.
pub fn centred_lines(font: *Font, lines: std.ArrayList(Text), mid: f32, top: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lines
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(i, line)| {
    // rust: let x = mid - (font.width_text(&line) / 2.0).trunc();
    // rust: (line, x, top + 9.0 * i as f32)
    // rust: })
    // rust: .collect()
}

/// PopupScreen centred on the screen: its title (bold) and message lines,
/// the background sprite's rectangle and its two buttons.
pub const Popup = struct {
    lines: Vec<(Text,
    frame: (f32,
    buttons: [(f32,
};
    // rust: impl Popup {
pub fn new(font: *Font, title: *Text, message: *Text) void {
}
    // rust: let blocks = [
    // rust: wrap(font, title, POPUP_CONTENT),
    // rust: wrap(font, message, POPUP_CONTENT),
    // rust: ];
    // rust: let row = 2.0 * POPUP_BUTTON + 6.0;
    // rust: let lw = blocks.iter().map(|b| widest(font, b)).fold(row, f32::max);
    // rust: let lh = blocks
    // rust: .iter()
    // rust: .map(|b| 9.0 * b.len() as f32 + 12.0)
    // rust: .sum::<f32>()
    // rust: + 20.0;
    // rust: let (x, y) = (((w - lw) / 2.0).trunc(), ((h - lh) / 2.0).trunc());
    // rust: let mut lines = Vec::new();
    // rust: let mut top = y;
    // rust: for block in blocks {
    // rust: let bw = widest(font, &block);
    // rust: let mid = x + ((lw - bw) / 2.0).trunc() + (bw / 2.0).trunc();
    // rust: let n = block.len() as f32;
    // rust: lines.extend(centred_lines(font, block, mid, top));
    // rust: top += 9.0 * n + 12.0;
}
    // rust: let bx = x + ((lw - row) / 2.0).trunc();
    // rust: Self {
    // rust: lines,
    // rust: frame: (x - 18.0, y - 18.0, lw + 36.0, lh + 36.0),
    // rust: buttons: [(bx, top), (bx + POPUP_BUTTON + 6.0, top)],
}
}
    /// The lock's question: WorldOptionsScreen's Apply when the lock changed.
pub fn lock_question(font: *Font, difficulty: u8, size: (f32) void {
}
    // rust: let name = Text::translate(
    // rust: &format!(
    // rust: "options.difficulty.{}",
    // rust: DIFFICULTIES[usize::from(difficulty) & 3]
    // rust: ),
    // rust: &[],
    // rust: );
    // rust: Self::new(
    // rust: font,
    // rust: &Text::translate("difficulty.lock.title", &[]).bold(),
    // rust: &Text::translate("difficulty.lock.question", &[name]),
    // rust: size,
    // rust: )
}
}

/// RestrictionsScreen for the player of a single-player world, whose chat
/// abilities come from the Chat option alone (Minecraft.computeChatAbilities).
pub const Restrictions = struct {
    lines: Vec<(Text,
    /// The restriction's action, 200 wide: Chat Settings.
    action: Option<(f32,
    /// The ScrollableLayout's top and bottom.
    area: (f32,
};
    // rust: impl Restrictions {
pub fn new(font: *Font, chat_visibility: u8) void {
}
    // rust: let red = named_color("red").unwrap_or(0xFF5555);
    // rust: let green = named_color("green").unwrap_or(0x55FF55);
    // rust: let inner = RESTRICTION_WIDTH - 8.0;
        // ChatVisiblity HIDDEN takes chat and commands, SYSTEM the chat.
    // rust: let restriction = match chat_visibility {
    // rust: 2 => Some("chat_restriction.chat_and_commands_disabled_by_options"),
    // rust: 1 => Some("chat_restriction.chat_disabled_by_options"),
    // rust: _ => None,
}
    // rust: let abilities = horizon_client::chat::ChatAbilities::new(
    // rust: horizon_client::chat::ChatVisibility::from_option(chat_visibility),
    // rust: );
    // rust: let (chat, commands) = (abilities.send_messages, abilities.send_commands);
        // The body's widgets: text blocks (lines, top) and the action's top.
    // rust: let mut blocks = Vec::new();
    // rust: let mut action = None;
    // rust: let mut y = 0.0;
    // rust: if let Some(key) = restriction {
    // rust: let lines = wrap(
    // rust: font,
    // rust: &Text::translate(key, &[]).bold().with_color(red),
    // rust: inner,
    // rust: );
    // rust: let n = lines.len() as f32;
    // rust: blocks.push((lines, y));
    // rust: y += 9.0 * n + 8.0;
    // rust: action = Some(y);
            // The button, then a 10 pixel SpacerElement.
    // rust: y += 20.0 + 10.0;
}
    // rust: let permissions = [
    // rust: ("send_messages", chat),
    // rust: ("send_commands", commands),
    // rust: ("receive_system_messages", commands),
    // rust: ("receive_player_messages", chat),
    // rust: ];
    // rust: let lines: Vec<Text> = permissions
    // rust: .iter()
    // rust: .flat_map(|&(id, allowed)| {
    // rust: let state = if allowed { "allowed" } else { "denied" };
    // rust: let t =
    // rust: Text::translate(&format!("restrictions_screen.permission.{id}.{state}"), &[])
    // rust: .with_color(if allowed { green } else { red });
    // rust: wrap(font, &t, inner)
    // rust: })
    // rust: .collect();
    // rust: let n = lines.len() as f32;
    // rust: blocks.push((lines, y));
    // rust: y += 9.0 * n + 8.0;
        // HeaderAndFooterLayout: 30 under the header if it fits; the
        // ScrollableLayout keeps 10 pixels each side for its scrollbar.
    // rust: let height = y.min(h - HEADER - FOOTER);
    // rust: let top = (HEADER + 30.0).min(h - FOOTER - height);
    // rust: let x = ((w - (RESTRICTION_WIDTH + 20.0)) / 2.0).trunc() + 10.0;
    // rust: let mid = x + RESTRICTION_WIDTH / 2.0;
    // rust: Self {
    // rust: lines: blocks
    // rust: .into_iter()
    // rust: .flat_map(|(lines, by)| centred_lines(font, lines, mid, top + by + 4.0))
    // rust: .collect(),
    // rust: action: action.map(|ay| (x + 25.0, top + ay)),
    // rust: area: (top, top + height),
}
}
    /// The footer's Done, 200 wide.
pub fn done(w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((w - 200.0) / 2.0).trunc(), h - FOOTER + 6.0)
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn remote_world_options_permission(&mut self, permission: bool) {
    // rust: if let Some(o) = self.world_options.as_mut() {
    // rust: let lost = o.gamemaster && !permission;
    // rust: o.gamemaster = permission;
    // rust: if lost && o.remote {
    // rust: self.close_world_options();
}
}
}
    // rust: pub(super) fn remote_world_options_difficulty(&mut self, difficulty: u8, locked: bool) {
    // rust: if let Some(o) = self.world_options.as_mut() {
    // rust: o.server_difficulty(difficulty, locked);
}
}
    // rust: pub(super) fn remote_world_options_rules(&mut self, entries: Vec<play::GameRuleEntry>) {
    // rust: let Some(o) = self
    // rust: .world_options
    // rust: .as_mut()
    // rust: .filter(|o| o.view == View::GameRules)
    // rust: else {
    // rust: return;
}
        // The response itself lists the server's available rules; the client
        // may not own this world's level.dat (including on the server thread).
    // rust: let features = if entries.iter().any(|e| {
    // rust: horizon_client::gamerules::rule(&e.name)
    // rust: .is_some_and(|r| r.name == horizon_client::gamerules::MAX_MINECART_SPEED.name)
    // rust: }) {
    // rust: vec![horizon_client::gamerules::MINECART_IMPROVEMENTS.to_owned()]
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let mut rules = horizon_client::gamerules::GameRules::with_features(&features);
    // rust: for entry in entries {
    // rust: rules.set_string(&entry.name, &entry.value);
}
    // rust: o.rules = Some(RulesScreen::new(&rules));
}
    // rust: pub(super) fn open_world_options(&mut self) {
    // rust: let hint = horizon_client::lan::available_port();
    // rust: let mut port = EditBox::new(0.0, 0.0, 150.0, 20.0);
    // rust: port.message = super::screen_info::tr("lanServer.port", &[]);
    // rust: port.max_length = 5;
        // The world is the server thread's when there is one.
    // rust: let state = match &self.integrated {
    // rust: Some(server) => match server.call(|g| g.server_options()) {
    // rust: Some(state) => state,
    // rust: None => return,
    // rust: },
    // rust: None => self.local_server_options(),
}
    // rust: if let Some(p) = state.port {
    // rust: port.set_value(&p.to_string());
}
    // rust: let mut options = WorldOptions {
    // rust: remote: self.external_server(),
    // rust: gamemaster: self.ui.registries.permission >= 2,
    // rust: default_mode: state.default_mode,
    // rust: personal_mode: state.personal_mode,
    // rust: cheats: state.cheats,
    // rust: difficulty: state.difficulty,
    // rust: lan: state.port.is_some(),
    // rust: port,
    // rust: hint,
    // rust: guest_commands: state.guest_commands,
    // rust: force: state.force,
    // rust: hardcore: state.hardcore,
    // rust: difficulty_locked: state.difficulty_locked,
    // rust: locked: state.difficulty_locked || state.hardcore,
    // rust: scroll: 0.0,
    // rust: view: View::Options,
    // rust: rules: None,
    // rust: focused_button: None,
    // rust: popup_focus: None,
    // rust: initial: Snapshot {
    // rust: default_mode: 0,
    // rust: personal_mode: 0,
    // rust: cheats: false,
    // rust: difficulty: 0,
    // rust: locked: false,
    // rust: lan: false,
    // rust: port: 0,
    // rust: guest_commands: false,
    // rust: force: false,
    // rust: },
}
    // rust: options.initial = options.snapshot();
    // rust: self.world_options = Some(options);
    // rust: self.screen = Screen::WorldOptions;
}

    // rust: pub(super) fn close_world_options(&mut self) {
    // rust: self.world_options = None;
    // rust: self.screen = Screen::Paused;
}

    /// Escape: the question and RestrictionsScreen return to the options
    /// (their onClose), which close; the game rules ask first.
    // rust: pub(super) fn world_options_escape(&mut self) {
    // rust: match self.world_options.as_mut() {
    // rust: Some(o) if o.view == View::GameRules => {
    // rust: if o.rules.is_none() {
                    // A server may be slow to answer REQUEST_GAMERULE_VALUES.
    // rust: o.view = View::Options;
    // rust: } else if let Some(exit) = o.rules.as_mut().and_then(RulesScreen::escape) {
    // rust: self.close_game_rules(exit);
}
}
    // rust: Some(o) if o.view != View::Options => o.view = View::Options,
    // rust: _ => self.close_world_options(),
}
}

    /// InWorldGameRulesScreen's exit, back to the options. Done sends the
    /// changed rules (ServerboundSetGameRulePacket), which the server's
    /// handleSetGameRule sets for a gamemaster and tells its operators.
pub fn close_game_rules(self: *Self, exit: Exit) void {
}
    // rust: if let Some(o) = self.world_options.as_mut() {
    // rust: o.view = View::Options;
    // rust: o.rules = None;
}
    // rust: let Exit::Apply(changes) = exit else {
    // rust: return;
}
    // rust: if self.remote.is_some() {
    // rust: if self.ui.registries.permission >= 2 && !changes.is_empty() {
    // rust: self.send(S::SetGameRule(play::SetGameRule {
    // rust: entries: changes
    // rust: .into_iter()
    // rust: .map(|(name, value)| play::GameRuleEntry {
    // rust: name: format!("minecraft:{name}"),
    // rust: value: value.to_string(),
    // rust: })
    // rust: .collect(),
    // rust: }));
}
    // rust: return;
}
    // rust: if !self.allow_commands() || changes.is_empty() {
    // rust: return;
}
    // rust: for (name, value) in changes {
    // rust: self.ui.rules.set(name, value);
    // rust: self.system_message(Text::tr("commands.gamerule.set", &[&name, &value]));
}
    // rust: self.sync_rules();
}

    // rust: pub(super) fn draw_world_options(&mut self, batch: &mut HudBatch) {
    // rust: let Some(mut o) = self.world_options.take() else {
    // rust: return;
}
    // rust: match o.view {
    // rust: View::Options => self.draw_options_view(&mut o, batch, self.cursor),
    // rust: View::LockQuestion => {
                // PopupScreen: the screen behind without the pointer, then the popup.
    // rust: self.draw_options_view(&mut o, batch, (-1.0, -1.0));
    // rust: self.draw_lock_question(&o, batch);
}
    // rust: View::Restrictions => self.draw_restrictions(batch),
    // rust: View::GameRules => {
    // rust: if let Some(rules) = o.rules.as_mut() {
    // rust: rules.draw(batch, &self.gui.atlas, self.cursor);
    // rust: } else {
    // rust: ui::menu_background(
    // rust: batch,
    // rust: &self.gui.atlas,
    // rust: 0.0,
    // rust: 0.0,
    // rust: batch.width,
    // rust: batch.height,
    // rust: true,
    // rust: );
}
}
}
    // rust: self.world_options = Some(o);
}

pub fn draw_lock_question(self: *Self, o: *WorldOptions, batch: *mut HudBatch) void {
}
        // PopupScreen over WorldOptionsScreen: its title and message.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: let name = Text::translate(
    // rust: &format!(
    // rust: "options.difficulty.{}",
    // rust: DIFFICULTIES[usize::from(o.difficulty) & 3]
    // rust: ),
    // rust: &[],
    // rust: );
    // rust: super::screen_info::popup(
    // rust: "world_options/lock",
    // rust: &Text::translate("difficulty.lock.title", &[]).plain(),
    // rust: &[&Text::translate("difficulty.lock.question", &[name]).plain()],
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
        // Screen.extractTransparentBackground.
    // rust: batch.fill_gradient(
    // rust: atlas,
    // rust: (0.0, 0.0, w, h),
    // rust: rgba(0x10, 0x10, 0x10, 0xC0),
    // rust: rgba(0x10, 0x10, 0x10, 0xD0),
    // rust: );
    // rust: let p = Popup::lock_question(&atlas.font, o.difficulty, (w, h));
    // rust: let (fx, fy, fw, fh) = p.frame;
    // rust: ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/popup/background",
    // rust: fx,
    // rust: fy,
    // rust: fw,
    // rust: fh,
    // rust: u32::MAX,
    // rust: );
    // rust: for (line, x, y) in &p.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: for (i, ((bx, by), key)) in p.buttons.into_iter().zip(["gui.yes", "gui.no"]).enumerate() {
    // rust: let is_focused = o.popup_focus == Some(i);
    // rust: let hover = ui::hovered(self.cursor, bx, by, POPUP_BUTTON, 20.0) || is_focused;
    // rust: let label = Text::translate(key, &[]);
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: bx,
    // rust: by,
    // rust: POPUP_BUTTON,
    // rust: 20.0,
    // rust: &label,
    // rust: true,
    // rust: hover,
    // rust: );
}
}

pub fn draw_restrictions(self: *Self, batch: *mut HudBatch) void {
}
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "restrictions",
    // rust: super::screen_info::tr("restrictions_screen.title", &[]),
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let title = Text::translate("restrictions_screen.title", &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).floor(),
    // rust: 12.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let r = Restrictions::new(&atlas.font, self.settings.chat_visibility, (w, h));
    // rust: let first = batch.vertices.len();
    // rust: for (line, x, y) in &r.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: if let Some((ax, ay)) = r.action {
    // rust: let is_focused = self.world_options.as_ref().and_then(|o| o.popup_focus) == Some(0);
    // rust: let hover = ui::hovered(self.cursor, ax, ay, 200.0, 20.0) || is_focused;
    // rust: let label = Text::translate("chat_restriction.chat_disabled_by_options.action", &[]);
    // rust: ui::button(batch, atlas, ax, ay, 200.0, 20.0, &label, true, hover);
}
    // rust: batch.clip_since(first, 0.0, r.area.0, w, r.area.1);
    // rust: let (dx, dy) = Restrictions::done(w, h);
    // rust: let is_focused = self.world_options.as_ref().is_some_and(|o| {
    // rust: o.popup_focus == Some(1) || (o.popup_focus == Some(0) && r.action.is_none())
    // rust: });
    // rust: let hover = ui::hovered(self.cursor, dx, dy, 200.0, 20.0) || is_focused;
    // rust: let label = Text::translate("gui.done", &[]);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: horizon_client::widgets::Action::Done,
    // rust: dx,
    // rust: dy,
    // rust: 200.0,
    // rust: 20.0,
    // rust: &label,
    // rust: true,
    // rust: hover,
    // rust: );
}

pub fn draw_options_view(self: *Self, o: *mut WorldOptions, batch: *mut HudBatch, cursor: (f32) void {
}
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "world_options",
    // rust: super::screen_info::tr("options.worldOptions.title", &[]),
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: o.scroll = o.scroll.clamp(0.0, o.scroll_limit(h));
        // extractMenuBackground: the in-world background, the list
        // background under the content, then the separators over it.
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: ui::list_background(batch, atlas, HEADER, h - FOOTER, true);
    // rust: let title = Text::translate("options.worldOptions.title", &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).floor(),
    // rust: 12.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let top = o.top();
    // rust: let first = batch.vertices.len();
    // rust: let x = WorldOptions::left(w);
    // rust: for (key, y) in [
    // rust: ("options.worldOptions.general.title", GENERAL_TOP),
    // rust: ("options.worldOptions.multiplayer.title", MULTIPLAYER_TOP),
    // rust: ] {
    // rust: if o.remote && key == "options.worldOptions.multiplayer.title" {
    // rust: continue;
}
            // A FocusableTextWidget padded by 4, centred over both columns.
    // rust: let t = Text::translate(key, &[]).underlined().bold();
    // rust: let tw = atlas.font.width_text(&t);
    // rust: let tx = x + ((308.0 - (tw + 8.0)) / 2.0).trunc() + 4.0;
    // rust: batch.text_styled(atlas, &t, tx, top + y + 4.0, u32::MAX, true);
}
    // rust: let inside = cursor.1 >= HEADER && cursor.1 < h - FOOTER;
    // rust: let tr = &super::screen_info::tr;
        // The categories' FocusableTextWidgets, each before its grid.
    // rust: let header = |key: &str| {
    // rust: let t = Text::translate(key, &[]).underlined().bold();
    // rust: let tw = atlas.font.width_text(&t);
    // rust: let y = if key == "options.worldOptions.general.title" {
    // rust: GENERAL_TOP
    // rust: } else {
    // rust: MULTIPLAYER_TOP
}
    // rust: let tx = x + ((308.0 - (tw + 8.0)) / 2.0).trunc();
    // rust: let rect = [tx, top + y, tw + 8.0, 17.0];
    // rust: widgets::narratable(|| Narratable::text(t.plain(), rect));
}
    // rust: header("options.worldOptions.general.title");
    // rust: let mut port_at = None;
    // rust: for (b, bx, by, bw) in o.visible_buttons(w) {
    // rust: let active = o.active(b);
    // rust: let is_focused = o.focused_button == Some(b);
    // rust: let hover = active && ((inside && ui::hovered(cursor, bx, by, bw, 20.0)) || is_focused);
    // rust: if b == Button::Lan {
    // rust: header("options.worldOptions.multiplayer.title");
}
    // rust: if b == Button::Lock {
    // rust: widgets::narratable(|| o.narration(b, [bx, by, 20.0, 20.0], tr).hovered(hover));
                // An icon, but a button: the D-pad and Tab stop on it as on the others.
    // rust: if active {
    // rust: widgets::target([bx, by, 20.0, 20.0]);
}
    // rust: let lock = if o.locked { "locked" } else { "unlocked" };
    // rust: let state = match (active, hover) {
    // rust: (false, _) => "_disabled",
    // rust: (true, true) => "_highlighted",
    // rust: (true, false) => "",
}
    // rust: let sprite = format!("gui/sprites/widget/{lock}_button{state}");
    // rust: batch.sprite_scaled(atlas, &sprite, bx, by, 20.0, 20.0, u32::MAX);
    // rust: continue;
}
    // rust: ui::button_as(
    // rust: batch,
    // rust: atlas,
    // rust: bx,
    // rust: by,
    // rust: bw,
    // rust: 20.0,
    // rust: &o.label(b),
    // rust: active,
    // rust: hover,
    // rust: |rect| o.narration(b, rect, tr),
    // rust: );
    // rust: if b == Button::Lan {
                // The port box is added after it.
    // rust: port_at = Some(widgets::narratables_mark());
}
}
        // The port box beside the LAN button: editable only with LAN on,
        // its hint the port to use (setPortError colours the text).
    // rust: if !o.remote {
    // rust: o.port.x = x + 158.0;
    // rust: o.port.y = top + PORT_TOP;
    // rust: o.port.focused = o.lan && o.port.focused;
    // rust: o.port.text_color = if !o.lan {
    // rust: rgba(0x70, 0x70, 0x70, 255)
    // rust: } else if o.parsed_port().is_some() {
    // rust: rgba(0xE0, 0xE0, 0xE0, 255)
    // rust: } else {
    // rust: rgba(0xDF, 0x50, 0x50, 255)
}
    // rust: let mark = widgets::narratables_mark();
    // rust: o.port.draw(batch, atlas, None);
            // updatePortControlsState: the box is active with LAN only.
    // rust: let lan = o.lan;
    // rust: widgets::last_narratable(|n| {
    // rust: if let horizon_client::widgets::What::EditBox { active, .. } = &mut n.what {
    // rust: *active = lan;
}
    // rust: });
    // rust: if let Some(at) = port_at {
    // rust: widgets::move_narratables(mark, at);
}
    // rust: if o.port.value.is_empty() && !o.port.focused {
    // rust: let hint = if o.lan {
    // rust: Text::literal(o.hint.to_string())
    // rust: } else {
    // rust: Text::translate("lanServer.port", &[])
}
                // EditBox.DEFAULT_HINT_STYLE: dark gray.
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &hint,
    // rust: o.port.text_x(),
    // rust: o.port.text_y(),
    // rust: rgba(0x55, 0x55, 0x55, 255),
    // rust: true,
    // rust: );
}
}
    // rust: batch.clip_since(first, 0.0, HEADER, w, h - FOOTER);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: (w / 2.0).floor() + 166.0,
    // rust: HEADER,
    // rust: h - FOOTER,
    // rust: o.content_height(),
    // rust: o.scroll.trunc(),
    // rust: );
    // rust: ui::separators(batch, atlas, HEADER, h - FOOTER, true);
    // rust: for (b, bx, by, bw) in WorldOptions::footer(w, h) {
    // rust: let active = o.active(b);
    // rust: let is_focused = o.focused_button == Some(b);
    // rust: let hover = active && (ui::hovered(cursor, bx, by, bw, 20.0) || is_focused);
    // rust: let action = match b {
    // rust: Button::Apply => horizon_client::widgets::Action::Apply,
    // rust: _ => horizon_client::widgets::Action::Cancel,
}
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: action,
    // rust: bx,
    // rust: by,
    // rust: bw,
    // rust: 20.0,
    // rust: &o.label(b),
    // rust: active,
    // rust: hover,
    // rust: );
}
}

    /// The mouse wheel over the screen (ScrollableLayout, 10 pixels a step).
    // rust: pub(super) fn world_options_scroll(&mut self, delta: f32) {
    // rust: let (w, h) = self.gui_size();
    // rust: let stick_scroll = self.pad_stick_scroll();
    // rust: match self.world_options.as_mut() {
    // rust: Some(o) if o.view == View::Options => {
    // rust: let hit_btn = o.hit(self.cursor, (w, h)).or(o.focused_button);
    // rust: if let Some(btn) = hit_btn.filter(|_| !stick_scroll) {
    // rust: let step = if delta > 0.0 { -1 } else { 1 };
    // rust: match btn {
    // rust: Button::DefaultMode => {
    // rust: o.default_mode = (o.default_mode + step).rem_euclid(4);
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: Button::PersonalMode => {
    // rust: o.personal_mode = (o.personal_mode + step).rem_euclid(4);
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: Button::Difficulty => {
    // rust: o.difficulty = ((o.difficulty as i32 + step).rem_euclid(4)) as u8;
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: Button::Cheats => {
    // rust: o.cheats = !o.cheats;
    // rust: if !o.cheats {
    // rust: o.default_mode = o.initial.default_mode;
    // rust: o.personal_mode = o.default_mode;
}
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: Button::Lan => {
    // rust: o.lan = !o.lan;
    // rust: o.port.focused = false;
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: Button::CommandAccess => {
    // rust: o.guest_commands = !o.guest_commands;
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: Button::Force => {
    // rust: o.force = !o.force;
    // rust: self.audio.play_button_click();
    // rust: return;
}
    // rust: _ => {}
}
}
    // rust: o.scroll = (o.scroll - delta * 10.0).clamp(0.0, o.scroll_limit(h));
}
    // rust: Some(o) => {
    // rust: if let Some(rules) = o.rules.as_mut() {
    // rust: rules.wheel(delta, h);
}
}
    // rust: None => {}
}
}

    /// The pointer moved while a list's scrollbar is held: the game rules'
    /// list follows it (AbstractSelectionList.mouseDragged).
    // rust: pub(super) fn world_options_drag(&mut self) {
    // rust: let h = self.gui_size().1;
    // rust: if let Some(o) = self.world_options.as_mut()
    // rust: && o.view == View::GameRules
    // rust: && let Some(rules) = o.rules.as_mut()
    // rust: {
    // rust: rules.drag(self.cursor.1, h);
}
}

    /// The button came up: a held scrollbar lets go (onRelease).
    // rust: pub(super) fn world_options_release(&mut self) {
    // rust: if let Some(o) = self.world_options.as_mut()
    // rust: && let Some(rules) = o.rules.as_mut()
    // rust: {
    // rust: rules.release();
}
}

    // rust: pub(super) fn world_options_click(&mut self) {
    // rust: let Some(mut o) = self.world_options.take() else {
    // rust: return;
}
    // rust: let (w, h) = self.gui_size();
    // rust: match o.view {
    // rust: View::Options => {}
    // rust: View::GameRules => {
    // rust: let atlas = &self.gui.atlas;
    // rust: let exit = o.rules.as_mut().and_then(|rules| {
    // rust: if rules.clicks_button(atlas, self.cursor, (w, h)) {
    // rust: self.audio.play_button_click();
}
    // rust: rules.click(atlas, self.cursor, (w, h))
    // rust: });
    // rust: self.world_options = Some(o);
    // rust: if let Some(exit) = exit {
    // rust: self.close_game_rules(exit);
}
    // rust: return;
}
    // rust: View::LockQuestion => {
    // rust: let p = Popup::lock_question(&self.gui.atlas.font, o.difficulty, (w, h));
    // rust: let hit = p
    // rust: .buttons
    // rust: .iter()
    // rust: .position(|&(bx, by)| ui::hovered(self.cursor, bx, by, POPUP_BUTTON, 20.0));
    // rust: if hit.is_some() {
    // rust: self.audio.play_button_click();
}
    // rust: match hit {
                    // Yes: apply, then back to the pause menu; No: back to the options.
    // rust: Some(0) => return self.apply_and_close_world_options(o),
    // rust: Some(_) => o.view = View::Options,
    // rust: None => {}
}
    // rust: self.world_options = Some(o);
    // rust: return;
}
    // rust: View::Restrictions => {
    // rust: let r =
    // rust: Restrictions::new(&self.gui.atlas.font, self.settings.chat_visibility, (w, h));
    // rust: let in_body = self.cursor.1 >= r.area.0 && self.cursor.1 < r.area.1;
    // rust: let action = r.action.is_some_and(|(ax, ay)| {
    // rust: in_body && ui::hovered(self.cursor, ax, ay, 200.0, 20.0)
    // rust: });
    // rust: let (dx, dy) = Restrictions::done(w, h);
    // rust: let done = ui::hovered(self.cursor, dx, dy, 200.0, 20.0);
    // rust: if action || done {
    // rust: self.audio.play_button_click();
    // rust: o.view = View::Options;
}
    // rust: self.world_options = Some(o);
    // rust: if action {
                    // ChatRestriction.Action.GO_TO_CHAT_SETTINGS: Chat Settings,
                    // which returns to the screen behind RestrictionsScreen.
    // rust: self.open_options_at(false, horizon_client::options_ui::Page::Chat);
    // rust: self.options_to_world_options = true;
}
    // rust: return;
}
}
    // rust: let inside = self.cursor.1 >= HEADER && self.cursor.1 < h - FOOTER;
    // rust: o.port.focused = !o.remote
    // rust: && o.lan
    // rust: && inside
    // rust: && ui::hovered(
    // rust: self.cursor,
    // rust: WorldOptions::left(w) + 158.0,
    // rust: o.top() + PORT_TOP,
    // rust: 150.0,
    // rust: 20.0,
    // rust: );
    // rust: let hit = o.hit(self.cursor, (w, h));
    // rust: if let Some(b) = hit {
    // rust: o.focused_button = Some(b);
    // rust: self.audio.play_button_click();
}
    // rust: match hit {
    // rust: Some(Button::DefaultMode) => o.default_mode = (o.default_mode + 1) % 4,
    // rust: Some(Button::PersonalMode) => o.personal_mode = (o.personal_mode + 1) % 4,
    // rust: Some(Button::Cheats) => {
    // rust: o.cheats = !o.cheats;
                // updatePermissionDependentButtons: without commands both
                // game modes return to the world's default.
    // rust: if !o.cheats {
    // rust: o.default_mode = o.initial.default_mode;
    // rust: o.personal_mode = o.default_mode;
}
}
    // rust: Some(Button::Difficulty) => o.difficulty = (o.difficulty + 1) % 4,
    // rust: Some(Button::Lock) => o.locked = !o.locked,
    // rust: Some(Button::Restrictions) => o.view = View::Restrictions,
    // rust: Some(Button::GameRules) => {
    // rust: if self.remote.is_some() {
    // rust: o.rules = None;
    // rust: self.send(S::ClientCommand(play::ClientCommand { action: 2 }));
    // rust: } else {
    // rust: o.rules = Some(RulesScreen::new(&self.ui.rules));
}
    // rust: o.view = View::GameRules;
}
    // rust: Some(Button::Lan) => {
    // rust: o.lan = !o.lan;
    // rust: o.port.focused = false;
}
    // rust: Some(Button::CommandAccess) => o.guest_commands = !o.guest_commands,
    // rust: Some(Button::Force) => o.force = !o.force,
    // rust: Some(Button::Cancel) => {
    // rust: self.world_options = Some(o);
    // rust: self.close_world_options();
    // rust: return;
}
            // A new lock asks first.
    // rust: Some(Button::Apply) if o.locked != o.initial.locked => o.view = View::LockQuestion,
    // rust: Some(Button::Apply) => return self.apply_and_close_world_options(o),
    // rust: None => {}
}
    // rust: self.world_options = Some(o);
}

pub fn apply_and_close_world_options(self: *Self, o: WorldOptions) void {
}
    // rust: let wanted = o.snapshot();
    // rust: let before = o.initial;
    // rust: self.world_options = Some(o);
    // rust: self.apply_world_options(&before, &wanted);
    // rust: self.close_world_options();
}

    /// `WorldOptionsScreen.sendPublishMessage`: a client system message the
    /// narrator says.
pub fn send_publish_message(self: *Self, message: Text) void {
}
    // rust: self.say_system_queued(&message);
    // rust: self.system_message(message);
}

    // rust: pub(super) fn world_options_key(&mut self, event: &KeyEvent) {
    // rust: if event.state != winit::event::ElementState::Pressed {
    // rust: return;
}
    // rust: let PhysicalKey::Code(key) = event.physical_key else {
    // rust: return;
}
    // rust: let ctrl = self.has_control_down_with_quirk();
    // rust: let shortcut = self.edit_shortcut(event);
    // rust: let types_text = self.types_text();
    // rust: let shift = self.has_shift_down();
    // rust: let (w, h) = self.gui_size();
    // rust: let chat_vis = self.settings.chat_visibility;
    // rust: let Some(o) = self.world_options.as_mut() else {
    // rust: return;
}
    // rust: if let Some(rules) = o.rules.as_mut().filter(|r| r.typing()) {
    // rust: match shortcut {
    // rust: Some(shortcut) => rules.edit(|b| {
    // rust: b.shortcut(shortcut, &mut self.clipboard);
    // rust: }),
    // rust: None => {
    // rust: let mut handled = false;
    // rust: rules.edit(|b| handled = b.key(key, ctrl, false));
                    // Only a key with text types: a `None` text is a
                    // backspace to `world_options_text`, which is the
                    // control socket's `\b`, not a key's.
    // rust: if !handled
    // rust: && types_text
    // rust: && let Some(text) = event.text.as_deref()
    // rust: {
    // rust: self.world_options_text(Some(text));
}
}
}
    // rust: return;
}
    // rust: if o.view == View::LockQuestion {
    // rust: match key {
    // rust: winit::keyboard::KeyCode::Tab => {
    // rust: let reverse = shift;
    // rust: o.popup_focus = match o.popup_focus {
    // rust: Some(0) => Some(1),
    // rust: Some(1) => Some(0),
    // rust: _ => {
    // rust: if reverse {
    // rust: Some(1)
    // rust: } else {
    // rust: Some(0)
}
}
}
}
    // rust: winit::keyboard::KeyCode::ArrowLeft | winit::keyboard::KeyCode::ArrowUp => {
    // rust: o.popup_focus = Some(0)
}
    // rust: winit::keyboard::KeyCode::ArrowRight | winit::keyboard::KeyCode::ArrowDown => {
    // rust: o.popup_focus = Some(1)
}
    // rust: winit::keyboard::KeyCode::Enter
    // rust: | winit::keyboard::KeyCode::NumpadEnter
    // rust: | winit::keyboard::KeyCode::Space => {
    // rust: self.audio.play_button_click();
    // rust: let yes = o.popup_focus == Some(0);
    // rust: let mut o = self.world_options.take().unwrap();
    // rust: if yes {
    // rust: return self.apply_and_close_world_options(o);
    // rust: } else {
    // rust: o.view = View::Options;
    // rust: self.world_options = Some(o);
}
}
    // rust: _ => {}
}
    // rust: return;
}
    // rust: if o.view == View::Restrictions {
    // rust: let r = Restrictions::new(&self.gui.atlas.font, chat_vis, (w, h));
    // rust: match key {
    // rust: winit::keyboard::KeyCode::Tab => {
    // rust: let reverse = shift;
    // rust: if r.action.is_some() {
    // rust: o.popup_focus = match o.popup_focus {
    // rust: Some(0) => Some(1),
    // rust: Some(1) => Some(0),
    // rust: _ => {
    // rust: if reverse {
    // rust: Some(1)
    // rust: } else {
    // rust: Some(0)
}
}
}
    // rust: } else {
    // rust: o.popup_focus = Some(1);
}
}
    // rust: winit::keyboard::KeyCode::ArrowUp => {
    // rust: if r.action.is_some() {
    // rust: o.popup_focus = Some(0);
    // rust: } else {
    // rust: o.popup_focus = Some(1);
}
}
    // rust: winit::keyboard::KeyCode::ArrowDown => o.popup_focus = Some(1),
    // rust: winit::keyboard::KeyCode::Enter
    // rust: | winit::keyboard::KeyCode::NumpadEnter
    // rust: | winit::keyboard::KeyCode::Space => {
    // rust: self.audio.play_button_click();
    // rust: let action = r.action.is_some() && o.popup_focus == Some(0);
    // rust: o.view = View::Options;
    // rust: if action {
    // rust: self.open_options_at(false, horizon_client::options_ui::Page::Chat);
    // rust: self.options_to_world_options = true;
}
}
    // rust: _ => {}
}
    // rust: return;
}
    // rust: if o.view != View::Options {
    // rust: return;
}
    // rust: if o.port.focused {
    // rust: if key == winit::keyboard::KeyCode::Tab {
    // rust: o.port.focused = false;
    // rust: if shift {
    // rust: o.focused_button = Some(Button::Lan);
    // rust: } else {
    // rust: o.focused_button = Some(Button::CommandAccess);
}
    // rust: return;
}
    // rust: if let Some(shortcut) = shortcut {
    // rust: o.port.shortcut(shortcut, &mut self.clipboard);
    // rust: return;
}
            // Only a key with text types (a `None` is a backspace to
            // `world_options_text`, the control socket's `\b`).
    // rust: if !o.port.key(key, ctrl, false)
    // rust: && types_text
    // rust: && let Some(text) = event.text.as_deref()
    // rust: {
    // rust: self.world_options_text(Some(text));
}
    // rust: return;
}
    // rust: let visible = o.visible_buttons(w);
    // rust: let footer = WorldOptions::footer(w, h);
    // rust: let active_buttons: Vec<Button> = visible
    // rust: .iter()
    // rust: .filter(|b| o.active(b.0))
    // rust: .map(|b| b.0)
    // rust: .chain(footer.iter().filter(|b| o.active(b.0)).map(|b| b.0))
    // rust: .collect();
    // rust: if active_buttons.is_empty() {
    // rust: return;
}
    // rust: match key {
    // rust: winit::keyboard::KeyCode::Tab => {
    // rust: let reverse = shift;
    // rust: let next = match o.focused_button {
    // rust: Some(cur) => {
    // rust: if !o.remote && o.lan {
    // rust: if !reverse && cur == Button::Lan {
    // rust: o.port.focused = true;
    // rust: o.focused_button = None;
    // rust: return;
}
    // rust: if reverse && cur == Button::CommandAccess {
    // rust: o.port.focused = true;
    // rust: o.focused_button = None;
    // rust: return;
}
}
    // rust: if let Some(pos) = active_buttons.iter().position(|&b| b == cur) {
    // rust: if reverse {
    // rust: if pos == 0 {
    // rust: active_buttons.last().copied()
    // rust: } else {
    // rust: Some(active_buttons[pos - 1])
}
    // rust: } else if pos + 1 >= active_buttons.len() {
    // rust: active_buttons.first().copied()
    // rust: } else {
    // rust: Some(active_buttons[pos + 1])
}
    // rust: } else if reverse {
    // rust: active_buttons.last().copied()
    // rust: } else {
    // rust: active_buttons.first().copied()
}
}
    // rust: None => {
    // rust: if reverse {
    // rust: active_buttons.last().copied()
    // rust: } else {
    // rust: active_buttons.first().copied()
}
}
}
    // rust: o.focused_button = next;
}
    // rust: winit::keyboard::KeyCode::ArrowUp
    // rust: | winit::keyboard::KeyCode::ArrowDown
    // rust: | winit::keyboard::KeyCode::ArrowLeft
    // rust: | winit::keyboard::KeyCode::ArrowRight => {
    // rust: let rects: Vec<(Button, f32, f32, f32)> = visible
    // rust: .into_iter()
    // rust: .filter(|b| o.active(b.0))
    // rust: .chain(footer.into_iter().filter(|b| o.active(b.0)))
    // rust: .collect();
    // rust: let cur_b = o.focused_button.unwrap_or(active_buttons[0]);
    // rust: if let Some(cur) = rects.iter().find(|r| r.0 == cur_b) {
    // rust: let (cx, cy) = (cur.1 + cur.3 / 2.0, cur.2 + 10.0);
    // rust: let mut best: Option<(Button, f32)> = None;
    // rust: for r in &rects {
    // rust: if r.0 == cur_b {
    // rust: continue;
}
    // rust: let (rx, ry) = (r.1 + r.3 / 2.0, r.2 + 10.0);
    // rust: let (dx, dy) = (rx - cx, ry - cy);
    // rust: let valid = match key {
    // rust: winit::keyboard::KeyCode::ArrowUp => dy < -4.0,
    // rust: winit::keyboard::KeyCode::ArrowDown => dy > 4.0,
    // rust: winit::keyboard::KeyCode::ArrowLeft => dx < -4.0,
    // rust: winit::keyboard::KeyCode::ArrowRight => dx > 4.0,
    // rust: _ => false,
}
    // rust: if !valid {
    // rust: continue;
}
    // rust: let dist = match key {
    // rust: winit::keyboard::KeyCode::ArrowUp
    // rust: | winit::keyboard::KeyCode::ArrowDown => dy.abs() + dx.abs() * 2.0,
    // rust: winit::keyboard::KeyCode::ArrowLeft
    // rust: | winit::keyboard::KeyCode::ArrowRight => dx.abs() + dy.abs() * 2.0,
    // rust: _ => f32::MAX,
}
    // rust: if best.as_ref().is_none_or(|(_, d)| dist < *d) {
    // rust: best = Some((r.0, dist));
}
}
    // rust: if let Some((next_b, _)) = best {
    // rust: o.focused_button = Some(next_b);
}
    // rust: } else {
    // rust: o.focused_button = Some(active_buttons[0]);
}
}
    // rust: winit::keyboard::KeyCode::Enter
    // rust: | winit::keyboard::KeyCode::NumpadEnter
    // rust: | winit::keyboard::KeyCode::Space => {
    // rust: if let Some(btn) = o.focused_button {
    // rust: self.audio.play_button_click();
    // rust: let mut o = self.world_options.take().unwrap();
    // rust: match btn {
    // rust: Button::DefaultMode => o.default_mode = (o.default_mode + 1) % 4,
    // rust: Button::PersonalMode => o.personal_mode = (o.personal_mode + 1) % 4,
    // rust: Button::Cheats => {
    // rust: o.cheats = !o.cheats;
    // rust: if !o.cheats {
    // rust: o.default_mode = o.initial.default_mode;
    // rust: o.personal_mode = o.default_mode;
}
}
    // rust: Button::Difficulty => o.difficulty = (o.difficulty + 1) % 4,
    // rust: Button::Lock => o.locked = !o.locked,
    // rust: Button::Restrictions => o.view = View::Restrictions,
    // rust: Button::GameRules => {
    // rust: if self.remote.is_some() {
    // rust: o.rules = None;
    // rust: self.send(S::ClientCommand(play::ClientCommand { action: 2 }));
    // rust: } else {
    // rust: o.rules = Some(RulesScreen::new(&self.ui.rules));
}
    // rust: o.view = View::GameRules;
}
    // rust: Button::Lan => {
    // rust: o.lan = !o.lan;
    // rust: o.port.focused = false;
}
    // rust: Button::CommandAccess => o.guest_commands = !o.guest_commands,
    // rust: Button::Force => o.force = !o.force,
    // rust: Button::Cancel => {
    // rust: self.world_options = Some(o);
    // rust: self.close_world_options();
    // rust: return;
}
    // rust: Button::Apply if o.locked != o.initial.locked => {
    // rust: o.view = View::LockQuestion
}
    // rust: Button::Apply => return self.apply_and_close_world_options(o),
}
    // rust: self.world_options = Some(o);
}
}
    // rust: _ => {}
}
}
    /// Whether a World Options text box has focus (the port or a game rule box).
    // rust: pub(super) fn world_options_typing(&self) -> bool {
    // rust: self.world_options.as_ref().is_some_and(|o| {
    // rust: o.rules.as_ref().is_some_and(|r| r.typing())
    // rust: || (o.port.focused && o.view == View::Options)
    // rust: })
}
    /// Digits typed into the port field (the keyboard, or a controller's
    /// on-screen keyboard), and its backspace.
    // rust: pub(super) fn world_options_text(&mut self, text: Option<&str>) {
    // rust: if let Some(rules) = self
    // rust: .world_options
    // rust: .as_mut()
    // rust: .and_then(|o| o.rules.as_mut())
    // rust: .filter(|r| r.typing())
    // rust: {
    // rust: match text {
    // rust: Some(text) => {
    // rust: let typed: String = text.chars().filter(|c| !c.is_control()).collect();
    // rust: if !typed.is_empty() {
    // rust: rules.edit(|b| b.insert_text(&typed));
}
}
    // rust: None => rules.edit(|b| {
    // rust: b.key(winit::keyboard::KeyCode::Backspace, false, false);
    // rust: }),
}
    // rust: return;
}
    // rust: let Some(o) = self.world_options.as_mut().filter(|o| o.port.focused) else {
    // rust: return;
}
    // rust: match text {
    // rust: Some(text) => {
    // rust: let digits: String = text.chars().filter(char::is_ascii_digit).collect();
    // rust: if !digits.is_empty() {
    // rust: o.port.insert_text(&digits);
}
}
    // rust: None => {
    // rust: o.port
    // rust: .key(winit::keyboard::KeyCode::Backspace, false, false);
}
}
}

    /// The world options of a world run in the frame.
pub fn local_server_options(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (guest_commands, force) = self.lan.as_ref().map_or((false, true), |h| {
    // rust: (h.settings.guest_commands, h.settings.force_game_mode)
    // rust: });
    // rust: ServerOptions {
    // rust: default_mode: self.level.mode(),
    // rust: personal_mode: self.mode_id(),
    // rust: cheats: self.allow_commands(),
    // rust: difficulty: self.ui.difficulty,
    // rust: hardcore: self.level.hardcore,
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: port: self.lan_port(),
    // rust: guest_commands,
    // rust: force,
}
}

pub fn apply_world_options(self: *Self, before: *Snapshot, wanted: *Snapshot) void {
}
    // rust: if self.external_server() {
    // rust: if self.ui.registries.permission >= 2 {
    // rust: if wanted.difficulty != before.difficulty {
    // rust: self.send(S::ChangeDifficulty(play::ChangeDifficultyRequest {
    // rust: difficulty: i32::from(wanted.difficulty),
    // rust: }));
}
    // rust: if wanted.locked && !before.locked {
    // rust: self.send(S::LockDifficulty(play::LockDifficulty { locked: true }));
}
}
    // rust: return;
}
    // rust: if let Some(server) = &self.integrated {
            // The server applies them; the window tells what came of
            // Open to LAN (ShareToLanScreen's messages).
    // rust: let (b, w) = (*before, *wanted);
    // rust: server.call(move |g| g.apply_world_options(&b, &w));
    // rust: if w.lan != b.lan || (w.lan && w.port != b.port) {
    // rust: let message = match (w.lan, self.lan_port()) {
    // rust: (true, Some(port)) => Text::translate(
    // rust: "menu.multiplayerOptions.publish.started.lan",
    // rust: &[Text::literal(port.to_string())],
    // rust: ),
    // rust: (true, None) => Text::translate("commands.publish.failed", &[]),
    // rust: (false, _) => Text::translate("menu.multiplayerOptions.publish.stopped", &[]),
}
    // rust: self.send_publish_message(message);
}
    // rust: return;
}
    // rust: if wanted.difficulty != before.difficulty {
    // rust: let name = DIFFICULTIES[usize::from(wanted.difficulty) & 3];
    // rust: self.as_console(|g| g.run_command(&format!("difficulty {name}")));
}
        // ServerboundLockDifficultyPacket(true): MinecraftServer.setDifficultyLocked.
    // rust: if wanted.locked && !before.locked {
    // rust: self.level.difficulty_locked = true;
}
    // rust: if wanted.default_mode != before.default_mode {
    // rust: self.set_default_game_mode(wanted.default_mode);
}
    // rust: if wanted.personal_mode != before.personal_mode {
    // rust: if self.serving() {
    // rust: self.set_owner_mode(wanted.personal_mode);
    // rust: } else {
    // rust: self.set_mode_id(wanted.personal_mode);
}
}
    // rust: if wanted.cheats != before.cheats {
    // rust: self.set_allow_commands(wanted.cheats);
    // rust: self.owner_allow_commands(wanted.cheats);
}
    // rust: let settings_changed =
    // rust: wanted.guest_commands != before.guest_commands || wanted.force != before.force;
    // rust: if wanted.lan != before.lan || (wanted.lan && wanted.port != before.port) {
    // rust: self.lan_close(before.lan);
    // rust: if wanted.lan {
    // rust: let opened = self.lan_open(LanSettings {
    // rust: port: wanted.port,
    // rust: guest_commands: wanted.guest_commands,
    // rust: force_game_mode: wanted.force,
    // rust: });
    // rust: if opened.is_err() {
    // rust: self.send_publish_message(Text::translate("commands.publish.failed", &[]));
}
}
    // rust: } else if settings_changed {
    // rust: self.lan_apply_settings(wanted.guest_commands, wanted.force);
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn keys(key: []const u8, args: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if args.is_empty() {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("{key}({})", args.join(", "))
}
}

pub fn the_switches_narrate_as_cycle_buttons_and_the_lock_as_a_lock() void {
}
//         use horizon_client::widgets::What;
    // rust: let o = options(true, false);
    // rust: let what = |b| o.narration(b, [0.0; 4], &keys).what;
    // rust: let generic = |name: &str, value: &str| format!("options.generic_value({name}, {value})");
    // rust: assert_eq!(
    // rust: what(Button::Difficulty),
    // rust: What::Cycle {
    // rust: message: generic("options.difficulty", "options.difficulty.normal"),
    // rust: next: generic("options.difficulty", "options.difficulty.hard"),
    // rust: active: true,
}
    // rust: );
    // rust: assert_eq!(
    // rust: what(Button::DefaultMode),
    // rust: What::Cycle {
    // rust: message: generic(
    // rust: "options.worldOptions.game_mode",
    // rust: "selectWorld.gameMode.creative"
    // rust: ),
    // rust: next: generic(
    // rust: "options.worldOptions.game_mode",
    // rust: "selectWorld.gameMode.adventure"
    // rust: ),
    // rust: active: true,
}
    // rust: );
    // rust: assert_eq!(
    // rust: what(Button::Lock),
    // rust: What::Named {
    // rust: title: "gui.narrate.button(narrator.button.difficulty_lock). narrator.button.difficulty_lock.unlocked"
    // rust: .into(),
    // rust: active: true,
}
    // rust: );
    // rust: let mut locked = options(true, true);
    // rust: locked.locked = true;
    // rust: assert_eq!(
    // rust: locked.narration(Button::Lock, [0.0; 4], &keys).what,
    // rust: What::Named {
    // rust: title: "gui.narrate.button(narrator.button.difficulty_lock). narrator.button.difficulty_lock.locked"
    // rust: .into(),
    // rust: active: false,
}
    // rust: );
    // rust: assert!(matches!(what(Button::Apply), What::Button { .. }));
}

pub fn options(cheats: bool, hardcore: bool) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut o = WorldOptions {
    // rust: remote: false,
    // rust: gamemaster: cheats,
    // rust: default_mode: 1,
    // rust: personal_mode: 1,
    // rust: cheats,
    // rust: difficulty: 2,
    // rust: lan: false,
    // rust: port: EditBox::new(0.0, 0.0, 150.0, 20.0),
    // rust: hint: 25565,
    // rust: guest_commands: false,
    // rust: force: true,
    // rust: hardcore,
    // rust: difficulty_locked: false,
    // rust: locked: hardcore,
    // rust: scroll: 0.0,
    // rust: view: View::Options,
    // rust: rules: None,
    // rust: focused_button: None,
    // rust: popup_focus: None,
    // rust: initial: Snapshot {
    // rust: default_mode: 0,
    // rust: personal_mode: 0,
    // rust: cheats: false,
    // rust: difficulty: 0,
    // rust: locked: false,
    // rust: lan: false,
    // rust: port: 0,
    // rust: guest_commands: false,
    // rust: force: false,
    // rust: },
}
    // rust: o.initial = o.snapshot();
    // rust: o
}

pub fn layout_follows_the_header_footer_and_grids() void {
}
    // rust: let at = |b: Button| {
    // rust: let o = options(true, false);
    // rust: WorldOptions::buttons(427.0, o.top())
    // rust: .into_iter()
    // rust: .chain(WorldOptions::footer(427.0, 240.0))
    // rust: .find(|e| e.0 == b)
    // rust: .map(|(_, x, y, w)| (x, y, w))
    // rust: .unwrap()
}
        // Header 33, content padding 8, heading 17, rows 4 apart.
    // rust: assert_eq!(at(Button::DefaultMode), (59.0, 62.0, 308.0));
    // rust: assert_eq!(at(Button::Cheats), (59.0, 110.0, 150.0));
    // rust: assert_eq!(at(Button::Difficulty), (217.0, 110.0, 130.0));
    // rust: assert_eq!(at(Button::Lock), (347.0, 110.0, 20.0));
    // rust: assert_eq!(at(Button::Restrictions), (217.0, 134.0, 150.0));
        // The Multiplayer grid 24 below: padding, spacing, padding.
    // rust: assert_eq!(at(Button::Lan), (59.0, 199.0, 150.0));
    // rust: assert_eq!(at(Button::Force), (217.0, 223.0, 150.0));
    // rust: assert_eq!(at(Button::Apply), (59.0, 213.0, 150.0));
        // 218 pixels of content over 174 between the separators.
    // rust: assert_eq!(options(true, false).scroll_limit(240.0), 44.0);
    // rust: assert_eq!(options(true, false).scroll_limit(400.0), 0.0);
}

pub fn buttons_follow_commands_hardcore_and_lan() void {
}
    // rust: let o = options(true, false);
    // rust: assert!(o.active(Button::DefaultMode) && o.active(Button::Difficulty));
    // rust: assert!(!o.active(Button::CommandAccess) && !o.active(Button::Force));
    // rust: assert!(!o.active(Button::Apply));
    // rust: assert!(o.active(Button::GameRules));
    // rust: let mut o = options(false, false);
    // rust: assert!(!o.active(Button::DefaultMode) && !o.active(Button::PersonalMode));
        // Game Rules follows the commands the player has, not the switch.
    // rust: assert!(!o.active(Button::GameRules));
    // rust: o.cheats = true;
    // rust: assert!(!o.active(Button::GameRules));
    // rust: let o = options(true, true);
    // rust: assert!(!o.active(Button::GameRules));
    // rust: let o = options(false, true);
    // rust: assert!(!o.active(Button::Cheats) && !o.active(Button::Difficulty));
    // rust: assert!(!o.active(Button::Force));
        // Scrolled widgets only take clicks between the separators.
    // rust: let mut o = options(true, false);
    // rust: o.scroll = 44.0;
    // rust: assert_eq!(o.hit((100.0, 30.0), (427.0, 240.0)), None);
    // rust: assert_eq!(o.hit((100.0, 70.0), (427.0, 240.0)), Some(Button::Cheats));
}

pub fn the_lock_follows_the_level_and_counts_as_a_change() void {
}
    // rust: let mut o = options(true, false);
    // rust: assert!(o.active(Button::Lock) && o.active(Button::Restrictions));
    // rust: assert!(!o.locked && !o.changed());
        // The wanted lock alone enables Apply (hasSettingsChanges).
    // rust: o.locked = true;
    // rust: assert!(o.changed() && o.active(Button::Difficulty));
        // A locked level: neither the difficulty nor the lock.
    // rust: let mut o = options(true, false);
    // rust: o.difficulty_locked = true;
    // rust: assert!(!o.active(Button::Lock) && !o.active(Button::Difficulty));
        // Hardcore shows the lock closed, and inactive.
    // rust: let o = options(true, true);
    // rust: assert!(o.locked && !o.active(Button::Lock));
}

pub fn remote_options_follow_vanilla_guest_layout_and_permissions() void {
}
    // rust: let mut o = options(false, false);
    // rust: o.remote = true;
        // Vanilla omits host-only rows instead of disabling the whole screen.
    // rust: let rows = o.visible_buttons(427.0);
    // rust: assert_eq!(
    // rust: rows.iter().map(|b| b.0).collect::<Vec<_>>(),
    // rust: vec![
    // rust: Button::Difficulty,
    // rust: Button::Lock,
    // rust: Button::GameRules,
    // rust: Button::Restrictions,
    // rust: ]
    // rust: );
    // rust: assert_eq!(rows[0], (Button::Difficulty, 59.0, 62.0, 130.0));
    // rust: assert_eq!(rows[2], (Button::GameRules, 217.0, 62.0, 150.0));
    // rust: assert_eq!(rows[3], (Button::Restrictions, 59.0, 86.0, 150.0));
    // rust: assert_eq!(o.scroll_limit(240.0), 0.0);
        // A non-operator cannot activate the difficulty or rule controls.
    // rust: assert_eq!(o.hit((100.0, 70.0), (427.0, 240.0)), None);
    // rust: assert_eq!(o.hit((240.0, 70.0), (427.0, 240.0)), None);
    // rust: assert_eq!(
    // rust: o.hit((100.0, 90.0), (427.0, 240.0)),
    // rust: Some(Button::Restrictions)
    // rust: );
    // rust: o.gamemaster = true;
    // rust: assert_eq!(
    // rust: o.hit((100.0, 70.0), (427.0, 240.0)),
    // rust: Some(Button::Difficulty)
    // rust: );
    // rust: assert_eq!(
    // rust: o.hit((240.0, 70.0), (427.0, 240.0)),
    // rust: Some(Button::GameRules)
    // rust: );
    // rust: o.difficulty_locked = true;
    // rust: assert_eq!(o.hit((100.0, 70.0), (427.0, 240.0)), None);
        // Remote hardcore does not hide an operator's Game Rules screen.
    // rust: o.hardcore = true;
    // rust: assert!(o.active(Button::GameRules));
    // rust: assert!(!o.active(Button::Lock));
    // rust: for b in [
    // rust: Button::DefaultMode,
    // rust: Button::PersonalMode,
    // rust: Button::Cheats,
    // rust: Button::Lan,
    // rust: Button::CommandAccess,
    // rust: Button::Force,
    // rust: ] {
    // rust: assert!(!o.active(b));
}
}

pub fn a_delayed_server_reply_does_not_mark_reopened_options_as_edited() void {
}
    // rust: let mut o = options(false, false);
    // rust: o.remote = true;
    // rust: o.gamemaster = true;
        // Reopened while the previous Apply's reply was still in flight.
    // rust: o.server_difficulty(3, false);
    // rust: assert_eq!(o.difficulty, 3);
    // rust: assert!(!o.active(Button::Apply));
    // rust: o.difficulty = 0;
    // rust: assert!(o.active(Button::Apply));
    // rust: o.server_difficulty(3, true);
    // rust: assert!(!o.active(Button::Apply));
    // rust: assert!(o.locked);
    // rust: assert!(!o.active(Button::Difficulty));
}
}
