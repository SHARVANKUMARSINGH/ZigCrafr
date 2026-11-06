//! Transpiled from Horizon Rust crate
//! Module: horizon-client_friends_screen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Play with Friends: Horizon's own sharing of the open world behind an
//! invite code (`game/friends.rs`). The pause menu's Friends button, the icon
//! vanilla's PauseScreen already has, opens it. It is drawn the way a mod adds
//! a screen to vanilla: the menu background, a centred title and text,
//! vanilla's buttons and Done in the footer.
// use crate::{
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: multiplayer::wrap,
    // rust: text::Text,
    // rust: ui,
}

/// The English title: the fallback of [`title`], and what the screen's widgets are named by.
pub const TITLE: []const u8 = "Play with Friends";
/// A string of this screen: the language table's, or the English text.
pub fn tr(key: []const u8, english: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::lang::get_or(key, english)
}
/// The title in the current language.
pub fn title() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tr("horizon.friends.title", TITLE)
}
/// What the screen shows (game/friends.rs fills it).
pub const FriendsView = struct {
    /// A singleplayer world (not a server): sharing is offered.
    shown: bool,
    sharing: bool,
    code: ?[]const u8,
    /// Who can join and what to do when friends on the internet can't (or,
    /// before the code, what the game is doing).
    status: []const u8,
    /// Friends on the internet can reach the host.
    reachable: bool,
    /// Where the troubleshooting is, when they can't.
    help: ?[]const u8,
    /// The players in the world besides the host.
    guests: std.ArrayList([]const u8),
    notice: ?[]const u8,
    /// The code was just copied.
    copied: bool,
};

/// A button's action.
pub const Action = enum {
    Share,
    Copy,
    Stop,
    /// Open the troubleshooting page.
    Help,
    Done,
};

pub fn grey() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rgba(160, 160, 160, 255)
}
pub const WHITE: u32 = u32::MAX;
pub fn hint() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tr(
    // rust: "horizon.friends.hint",
    // rust: "Friends paste the code after the title screen's Friends button, in Direct Connection, or on the launcher's Play page.",
    // rust: )
}

pub const Button = struct {
    x: f32,
    y: f32,
    w: f32,
    label: []const u8,
    action: Action,
    active: bool,
};

/// The centred lines (text, colour, y) and the buttons.
    // rust: fn layout(
    // rust: atlas: &HudAtlas,
    // rust: (w, h): (f32, f32),
    // rust: view: &FriendsView,
    // rust: ) -> (Vec<(String, u32, f32)>, Vec<Button>) {
    // rust: let width = (w - 40.0).min(310.0);
    // rust: let cx = (w / 2.0).floor();
    // rust: let mut lines = Vec::new();
    // rust: let mut y = 40.0;
    // rust: let add = |lines: &mut Vec<(String, u32, f32)>, text: &str, color: u32, y: &mut f32| {
    // rust: for line in wrap(text, width, atlas) {
    // rust: lines.push((line, color, *y));
    // rust: *y += 10.0;
}
}
    // rust: let mut buttons = Vec::new();
    // rust: if view.sharing {
    // rust: lines.push((
    // rust: tr("horizon.multiplayer.invite_code", "Invite Code"),
    // rust: grey(),
    // rust: y,
    // rust: ));
    // rust: y += 12.0;
    // rust: match &view.code {
    // rust: Some(code) => {
    // rust: for line in code_lines(atlas, code, width) {
    // rust: lines.push((line, WHITE, y));
    // rust: y += 10.0;
}
}
    // rust: None => add(&mut lines, &view.status, WHITE, &mut y),
}
    // rust: y += 6.0;
    // rust: buttons.push(Button {
    // rust: x: cx - 154.0,
    // rust: y,
    // rust: w: 150.0,
    // rust: label: if view.copied {
    // rust: tr("horizon.friends.copied", "Copied")
    // rust: } else {
    // rust: tr("horizon.friends.copy_code", "Copy Code")
    // rust: },
    // rust: action: Action::Copy,
    // rust: active: view.code.is_some(),
    // rust: });
    // rust: buttons.push(Button {
    // rust: x: cx + 4.0,
    // rust: y,
    // rust: w: 150.0,
    // rust: label: tr("horizon.friends.stop_sharing", "Stop Sharing"),
    // rust: action: Action::Stop,
    // rust: active: true,
    // rust: });
    // rust: y += 30.0;
    // rust: if view.code.is_some() {
            // Who can join: grey when friends anywhere can, white (it asks
            // for something) when only the LAN and VPNs can.
    // rust: let tint = if view.reachable { grey() } else { WHITE };
    // rust: add(&mut lines, &view.status, tint, &mut y);
    // rust: y += 4.0;
}
    // rust: let here = if view.guests.is_empty() {
    // rust: tr("horizon.friends.none_yet", "No friends here yet.")
    // rust: } else {
    // rust: tr("horizon.friends.here_now", "Here now: %s").replacen(
    // rust: "%s",
    // rust: &view.guests.join(", "),
    // rust: 1,
    // rust: )
}
    // rust: add(&mut lines, &here, grey(), &mut y);
    // rust: if let Some(notice) = &view.notice {
    // rust: add(&mut lines, notice, WHITE, &mut y);
}
        // Where friends paste the code, while it fits above the footer.
    // rust: let hint = hint();
    // rust: if y + 10.0 * wrap(&hint, width, atlas).len() as f32 <= h - 33.0 {
    // rust: add(&mut lines, &hint, grey(), &mut y);
}
    // rust: } else {
    // rust: add(
    // rust: &mut lines,
    // rust: &tr(
    // rust: "horizon.friends.share_intro",
    // rust: "Share this world behind an invite code: it opens to LAN, and friends on the internet join with the code. No server of ours is involved.",
    // rust: ),
    // rust: WHITE,
    // rust: &mut y,
    // rust: );
    // rust: y += 4.0;
    // rust: add(&mut lines, &hint(), grey(), &mut y);
    // rust: buttons.push(Button {
    // rust: x: cx - 100.0,
    // rust: y: y + 8.0,
    // rust: w: 200.0,
    // rust: label: tr("horizon.friends.start_sharing", "Start Sharing"),
    // rust: action: Action::Share,
    // rust: active: view.shown,
    // rust: });
}
    // HeaderAndFooterLayout's footer: Done, beside Troubleshooting when
    // friends on the internet can't reach the host.
    // rust: if view.sharing && view.help.is_some() {
    // rust: buttons.push(Button {
    // rust: x: cx - 154.0,
    // rust: y: h - 27.0,
    // rust: w: 150.0,
    // rust: label: tr("horizon.friends.troubleshooting", "Troubleshooting..."),
    // rust: action: Action::Help,
    // rust: active: true,
    // rust: });
    // rust: buttons.push(Button {
    // rust: x: cx + 4.0,
    // rust: y: h - 27.0,
    // rust: w: 150.0,
    // rust: label: "gui.done".to_owned(),
    // rust: action: Action::Done,
    // rust: active: true,
    // rust: });
    // rust: } else {
    // rust: buttons.push(Button {
    // rust: x: cx - 100.0,
    // rust: y: h - 27.0,
    // rust: w: 200.0,
    // rust: label: "gui.done".to_owned(),
    // rust: action: Action::Done,
    // rust: active: true,
    // rust: });
}
    // rust: (lines, buttons)
}
/// The code's groups packed into lines of at most `width`.
pub fn code_lines(atlas: *HudAtlas, code: []const u8, width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lines: Vec<String> = Vec::new();
    // rust: for group in code.split('-') {
    // rust: match lines.last_mut() {
    // rust: Some(l) if HudBatch::text_width(atlas, &format!("{l}-{group}")) <= width => {
    // rust: l.push('-');
    // rust: l.push_str(group);
}
    // rust: _ => lines.push(group.to_owned()),
}
}
    // rust: lines
}
pub fn label(key: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if key.starts_with("gui.") {
    // rust: Text::translate(key, &[])
    // rust: } else {
    // rust: Text::literal(key)
}
}
    // rust: pub fn draw(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: view: &FriendsView,
    // rust: in_world: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);
    // rust: let title = Text::literal(title());
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(atlas, &title, ((w - tw) / 2.0).floor(), 15.0, WHITE, true);
    // rust: let (lines, buttons) = layout(atlas, (w, h), view);
    // rust: for (line, color, y) in lines {
    // rust: let lw = HudBatch::text_width(atlas, &line);
    // rust: batch.text(atlas, &line, ((w - lw) / 2.0).floor(), y, color, true);
}
    // rust: for b in buttons {
    // rust: let hover = b.active && ui::hovered(cursor, b.x, b.y, b.w, 20.0);
    // rust: if matches!(b.action, Action::Done) {
    // rust: crate::widgets::declare_action(
    // rust: crate::widgets::Action::Done,
    // rust: [b.x, b.y, b.w, 20.0],
    // rust: b.active,
    // rust: );
}
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: b.x,
    // rust: b.y,
    // rust: b.w,
    // rust: 20.0,
    // rust: &label(&b.label),
    // rust: b.active,
    // rust: hover,
    // rust: );
}
}
/// The button under a click, if it is active.
    // rust: pub fn click(
    // rust: atlas: &HudAtlas,
    // rust: size: (f32, f32),
    // rust: cursor: (f32, f32),
    // rust: view: &FriendsView,
    // rust: ) -> Option<Action> {
    // rust: layout(atlas, size, view)
    // rust: .1
    // rust: .into_iter()
    // rust: .find(|b| b.active && ui::hovered(cursor, b.x, b.y, b.w, 20.0))
    // rust: .map(|b| b.action)
}

    // rust: mod tests {
//     use super::*;

pub fn atlas() H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}

pub fn share_then_copy_and_stop() void {
}
    // rust: let atlas = atlas();
    // rust: let size = (427.0, 240.0);
    // rust: let idle = FriendsView {
    // rust: shown: true,
    // rust: ..FriendsView::default()
}
    // rust: let (_, buttons) = layout(&atlas, size, &idle);
    // rust: let share = buttons.iter().find(|b| b.action == Action::Share).unwrap();
    // rust: assert_eq!(
    // rust: click(&atlas, size, (share.x + 1.0, share.y + 1.0), &idle),
    // rust: Some(Action::Share)
    // rust: );
    // rust: let sharing = FriendsView {
    // rust: shown: true,
    // rust: sharing: true,
    // rust: status: "Finding how friends can reach you…".into(),
    // rust: ..FriendsView::default()
}
    // rust: let (_, buttons) = layout(&atlas, size, &sharing);
    // rust: let copy = buttons.iter().find(|b| b.action == Action::Copy).unwrap();
    // rust: assert!(!copy.active, "nothing to copy before the code");
    // rust: let with_code = FriendsView {
    // rust: code: Some("0B33K-Q405Q-1Z5CV-X6NHY-R12N0-VK8T1-60N00-RA134-952PE-1HA08-910P0-K5M01-ST1NB-JDTB6-K4W1P-0".into()),
    // rust: status: "Friends on your network or VPN can join. For friends on the internet: turn on UPnP on your router, or forward TCP port 25580 to 10.0.0.2, or use a relay, or a VPN such as Tailscale or ZeroTier (the code already holds your VPN address).".into(),
    // rust: help: Some("https://example.invalid/help".into()),
    // rust: ..sharing
}
    // rust: let (lines, buttons) = layout(&atlas, size, &with_code);
    // rust: assert!(
    // rust: lines.iter().all(|(_, _, y)| y + 9.0 <= size.1 - 27.0),
    // rust: "the text stays above the footer"
    // rust: );
    // rust: for action in [Action::Copy, Action::Stop, Action::Help, Action::Done] {
    // rust: let b = buttons.iter().find(|b| b.action == action).unwrap();
    // rust: assert_eq!(
    // rust: click(&atlas, size, (b.x + 1.0, b.y + 1.0), &with_code),
    // rust: Some(action)
    // rust: );
}
}

pub fn a_server_offers_no_sharing() void {
}
    // rust: let atlas = atlas();
    // rust: let view = FriendsView::default();
    // rust: let (_, buttons) = layout(&atlas, (427.0, 240.0), &view);
    // rust: let share = buttons.iter().find(|b| b.action == Action::Share).unwrap();
    // rust: assert!(!share.active);
}
}
