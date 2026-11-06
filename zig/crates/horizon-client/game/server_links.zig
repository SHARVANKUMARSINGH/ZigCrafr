//! Transpiled from Horizon Rust crate
//! Module: horizon-client_server_links
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `ServerLinksDialogScreen`: the pause menu's "Server Links..." button opens
//! the `minecraft:server_links` dialog (the `pause_screen_additions` tag's
//! fallback when a server sent ClientboundServerLinksPacket): a scrollable
//! list of the server's links, each opened through `ConfirmLinkScreen`
//! (Screen.clickUrlAction), and the `dialog/warning_button`'s
//! DialogScreen.WarningScreen ("Note about custom screens").
//! https://mcsrc.dev/2/26.3/net/minecraft/client/gui/screens/dialog/ServerLinksDialogScreen
// use super::{Game, Screen, packs::open_uri};
// use horizon_client::{Result, clipboard::Clipboard, hud::HudBatch, text::Text, ui};
// use horizon_protocol::packets::configuration::{ServerLink, ServerLinkKind};

/// HeaderAndFooterLayout's header and footer heights; the content wants to
/// start 30 pixels under the header (its `CONTENTS_MARGIN_TOP`).
pub const HEADER: f32 = 33.0;
pub const FOOTER: f32 = 33.0;
pub const CONTENT_TOP: f32 = HEADER + 30.0;
/// `server_links.json`: `columns` 1, `button_width` 310, `exit_action`'s 200.
pub const LINK_WIDTH: f32 = 310.0;
/// packControlsIntoColumns: rowSpacing 2 under the 20-pixel buttons.
pub const ROW: f32 = 22.0;
/// ScrollableLayout's BOTH reserve (scrollbarSpacing 4 + SCROLLBAR_WIDTH 6).
pub const SCROLL_RESERVE: f32 = 10.0;
/// DialogScreen's `dialog/warning_button` ImageButton.
pub const WARNING_BUTTON: f32 = 20.0;

/// The ServerLinks screen's state: ScrollableLayout's scroll and the link
/// ConfirmLinkScreen is asking about (`Screen::ConfirmLink`).
    // rust: pub(super) struct LinksUi {
    // rust: pub scroll: f32,
    // rust: pub confirm: Option<String>,
    /// `ConfirmLinkScreen.trusted`: the pause menu's buttons ask with the
    /// trusted text and no warning; a server's link is untrusted.
    // rust: pub trusted: bool,
    /// The screen the confirmation returns to (its parent); Server Links when unset.
    // rust: pub back: Option<Screen>,
}

/// `Util.parseAndValidateUntrustedUri`: an absolute `http`/`https` URI
/// (java.net.URI's scheme then the allowlist; whitespace-free).
    // rust: pub(super) fn valid_untrusted_uri(uri: &str) -> bool {
    // rust: let Some(colon) = uri.find(':') else {
    // rust: return false;
}
    // rust: let scheme = &uri[..colon];
    // rust: let mut chars = scheme.chars();
    // rust: if !chars.next().is_some_and(|c| c.is_ascii_alphabetic())
    // rust: || !chars.all(|c| c.is_ascii_alphanumeric() || matches!(c, '+' | '-' | '.'))
    // rust: {
    // rust: return false;
}
    // rust: if !matches!(scheme.to_ascii_lowercase().as_str(), "http" | "https") {
    // rust: return false;
}
    // rust: !uri.chars().any(|c| c.is_control() || c == ' ')
}
/// `ClientCommonPacketListenerImpl.handleServerLinks`: keep only the links
/// that validate, warning about the dropped ones.
    // rust: pub(super) fn trusted(links: Vec<ServerLink>) -> Vec<ServerLink> {
    // rust: links
    // rust: .into_iter()
    // rust: .filter(|l| {
    // rust: let ok = valid_untrusted_uri(&l.link);
    // rust: if !ok {
    // rust: log::warn!("Horizon: server sent an invalid link: {}", l.link);
}
    // rust: ok
    // rust: })
    // rust: .collect()
}
/// `ServerLinks.Entry.displayName`: `known_server_link.<name>` for a known
/// type (ByIdMap.ZERO reads unknown ids as `report_bug`), the component else.
pub fn link_label(link: *ServerLink) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: const KNOWN: [&str; 10] = [
    // rust: "report_bug",
    // rust: "community_guidelines",
    // rust: "support",
    // rust: "status",
    // rust: "feedback",
    // rust: "community",
    // rust: "website",
    // rust: "forums",
    // rust: "news",
    // rust: "announcements",
    // rust: ];
    // rust: match &link.kind {
    // rust: ServerLinkKind::Known(id) => Text::translate(
    // rust: &format!(
    // rust: "known_server_link.{}",
    // rust: KNOWN.get(*id as usize).copied().unwrap_or(KNOWN[0])
    // rust: ),
    // rust: &[],
    // rust: ),
    // rust: ServerLinkKind::Custom(tag) => {
    // rust: horizon_client::scoreboard::comp_text(&horizon_client::scoreboard::tag_to_json(tag))
}
}
}

/// The scrolled column of link buttons: content height and, for a list that
/// fits, the `HeaderAndFooterLayout` contents frame's top.
pub fn list_height(n: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: n as f32 * ROW - 2.0
}
pub fn list_top(h: f32, n: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CONTENT_TOP.min(h - FOOTER - list_height(n).min(h - HEADER - FOOTER))
}
pub fn scroll_limit(h: f32, n: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (list_height(n) - (h - HEADER - FOOTER)).max(0.0)
}

/// `ServerLinksScreen`'s buttons as (x, y) over the scrolled content, and the
/// footer `Back` button's corner. `top` includes the scroll.
pub fn link_buttons(w: f32, top: f32, n: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = ((w - LINK_WIDTH - 2.0 * SCROLL_RESERVE) / 2.0 + SCROLL_RESERVE).floor();
    // rust: (0..n).map(|i| (x, top + i as f32 * ROW)).collect()
}
/// The warning button beside the title (DialogScreen's title row: 10 pixels
/// apart), clamped onto the screen (makeSureWarningButtonIsInBounds).
pub fn warning_button(w: f32, h: f32, title_width: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = ((w - title_width - 30.0) / 2.0).floor() + title_width + 10.0;
    // rust: let y = ((HEADER - WARNING_BUTTON) / 2.0).floor();
    // rust: if x < 0.0 || y < 0.0 || x > w - WARNING_BUTTON || y > h - WARNING_BUTTON {
    // rust: (0.0f32.max(w - 40.0), 5.0f32.min(h))
    // rust: } else {
    // rust: (x, y)
}
}
pub fn back_button(w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: ((w - 200.0) / 2.0).floor(),
    // rust: h - FOOTER + ((FOOTER - 20.0) / 2.0).floor(),
    // rust: )
}

    // rust: impl Game<'_> {
    /// `connection.serverLinks()`: the links the open server sent (empty for
    /// a world without a connection or one that sent none).
    // rust: pub(super) fn server_links(&self) -> &[ServerLink] {
    // rust: self.remote
    // rust: .as_ref()
    // rust: .map_or(&[], |r| r.server_links.as_slice())
}
    /// DialogScreen over the pause menu: `menu.server_links.title`, the
    /// scrollable link buttons and `gui.back` in the footer.
    // rust: pub(super) fn draw_server_links(&mut self, batch: &mut HudBatch) {
        // ServerLinksDialogScreen: the dialog's title.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "server_links",
    // rust: super::screen_info::tr("menu.server_links.title", &[]),
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let links = self.server_links().to_vec();
    // rust: self.links_ui.scroll = self
    // rust: .links_ui
    // rust: .scroll
    // rust: .clamp(0.0, scroll_limit(h, links.len()));
    // rust: let top = list_top(h, links.len()) - self.links_ui.scroll.trunc();
        // The title row: the title, then 10 pixels on the warning button.
    // rust: let title = Text::translate("menu.server_links.title", &[]);
    // rust: let tw = atlas.font.width_text(&title);
    // rust: let tx = ((w - tw - 30.0) / 2.0).floor();
    // rust: batch.text_styled(atlas, &title, tx, 12.0, u32::MAX, true);
    // rust: let (wx, wy) = warning_button(w, h, tw);
    // rust: let wh = ui::hovered(self.cursor, wx, wy, WARNING_BUTTON, WARNING_BUTTON);
        // DialogScreen.createWarningButton: an ImageButton with its own
        // message and its tooltip.
    // rust: horizon_client::widgets::narratable(|| {
    // rust: horizon_client::widgets::Narratable::button(
    // rust: super::screen_info::tr("menu.custom_screen_info.button_narration", &[]),
    // rust: [wx, wy, WARNING_BUTTON, WARNING_BUTTON],
    // rust: true,
    // rust: )
    // rust: .hovered(wh)
    // rust: .hint(super::screen_info::tr(
    // rust: "menu.custom_screen_info.tooltip",
    // rust: &[],
    // rust: ))
    // rust: });
    // rust: horizon_client::widgets::record(
    // rust: "menu.custom_screen_info.tooltip",
    // rust: [wx, wy, WARNING_BUTTON, WARNING_BUTTON],
    // rust: true,
    // rust: );
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: if wh {
    // rust: "gui/sprites/dialog/warning_button_highlighted"
    // rust: } else {
    // rust: "gui/sprites/dialog/warning_button"
    // rust: },
    // rust: wx,
    // rust: wy,
    // rust: WARNING_BUTTON,
    // rust: WARNING_BUTTON,
    // rust: u32::MAX,
    // rust: );
    // rust: let first = batch.vertices.len();
    // rust: let inside = self.cursor.1 >= HEADER && self.cursor.1 < h - FOOTER;
    // rust: for (link, (x, y)) in links.iter().zip(link_buttons(w, top, links.len())) {
    // rust: let hover = inside && ui::hovered(self.cursor, x, y, LINK_WIDTH, 20.0);
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: LINK_WIDTH,
    // rust: 20.0,
    // rust: &link_label(link),
    // rust: true,
    // rust: hover,
    // rust: );
}
    // rust: batch.clip_since(first, 0.0, HEADER, w, h - FOOTER);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: (w / 2.0).floor() + 155.0 + 4.0,
    // rust: HEADER,
    // rust: h - FOOTER,
    // rust: list_height(links.len()),
    // rust: self.links_ui.scroll.trunc(),
    // rust: );
    // rust: let (bx, by) = back_button(w, h);
    // rust: let hover = ui::hovered(self.cursor, bx, by, 200.0, 20.0);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: horizon_client::widgets::Action::Back,
    // rust: bx,
    // rust: by,
    // rust: 200.0,
    // rust: 20.0,
    // rust: &Text::translate("gui.back", &[]),
    // rust: true,
    // rust: hover,
    // rust: );
    // rust: if wh {
    // rust: ui::tooltip(
    // rust: batch,
    // rust: atlas,
    // rust: &[Text::translate("menu.custom_screen_info.tooltip", &[])],
    // rust: self.cursor,
    // rust: );
}
}
    /// A click on `Screen::ServerLinks`: a link, the warning button or Back.
    // rust: pub(super) fn server_links_click(&mut self) -> Result<()> {
    // rust: let (w, h) = self.gui_size();
    // rust: let links = self.server_links().to_vec();
    // rust: let top = list_top(h, links.len()) - self.links_ui.scroll.trunc();
    // rust: let inside = self.cursor.1 >= HEADER && self.cursor.1 < h - FOOTER;
    // rust: if inside
    // rust: && let Some(i) = link_buttons(w, top, links.len())
    // rust: .iter()
    // rust: .position(|(x, y)| ui::hovered(self.cursor, *x, *y, LINK_WIDTH, 20.0))
    // rust: {
    // rust: self.audio.play_button_click();
    // rust: self.click_link(&links[i].link);
    // rust: return Ok(());
}
    // rust: let title = Text::translate("menu.server_links.title", &[]);
    // rust: let tw = self.gui.atlas.font.width_text(&title);
    // rust: let (wx, wy) = warning_button(w, h, tw);
    // rust: if ui::hovered(self.cursor, wx, wy, WARNING_BUTTON, WARNING_BUTTON) {
    // rust: self.audio.play_button_click();
    // rust: self.screen = Screen::DialogWarning;
    // rust: return Ok(());
}
    // rust: let (bx, by) = back_button(w, h);
    // rust: if ui::hovered(self.cursor, bx, by, 200.0, 20.0) {
    // rust: self.audio.play_button_click();
    // rust: self.screen = Screen::Paused;
}
    // rust: Ok(())
}
    /// `Screen.clickUrlAction`: "Web Links" off ignores the click; "Prompt on
    /// Links" asks with ConfirmLinkScreen, else the browser opens directly.
pub fn click_link(self: *Self, url: []const u8) void {
}
    // rust: if !self.settings.chat_links {
    // rust: return;
}
    // rust: if self.settings.chat_links_prompt {
    // rust: self.links_ui.confirm = Some(url.to_owned());
    // rust: self.links_ui.trusted = false;
    // rust: self.links_ui.back = None;
    // rust: self.screen = Screen::ConfirmLink;
    // rust: } else {
    // rust: open_uri(url);
}
}
    /// `ConfirmLinkScreen.confirmLinkNow(parent, uri, true)`: ask about a link
    /// Mojang's own button names, whatever the "Web Links" options say.
    // rust: pub(super) fn confirm_trusted_link(&mut self, url: &str, parent: Screen) {
    // rust: self.links_ui.confirm = Some(url.to_owned());
    // rust: self.links_ui.trusted = true;
    // rust: self.links_ui.back = Some(parent);
    // rust: self.screen = Screen::ConfirmLink;
}
    /// The screen `ConfirmLinkScreen`'s callback returns to (`setScreen(parent)`).
    // rust: pub(super) fn confirm_link_back(&self) -> Screen {
    // rust: self.links_ui.back.unwrap_or(Screen::ServerLinks)
}
    /// `ScrollableLayout`'s mouse wheel over the links.
    // rust: pub(super) fn server_links_scroll(&mut self, delta: f32) {
    // rust: let (_, h) = self.gui_size();
    // rust: self.links_ui.scroll = (self.links_ui.scroll - delta * 10.0)
    // rust: .clamp(0.0, scroll_limit(h, self.server_links().len()));
}
    /// `ConfirmLinkScreen` (untrusted): "Are you sure you want to open the
    /// following website?", the link, the red warning, and Yes / Copy Link to
    /// Clipboard / No.
    // rust: pub(super) fn draw_confirm_link(&mut self, batch: &mut HudBatch) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let url = self.links_ui.confirm.clone().unwrap_or_default();
    // rust: let trusted = self.links_ui.trusted;
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: let title = if trusted {
    // rust: "chat.link.confirmTrusted"
    // rust: } else {
    // rust: "chat.link.confirm"
}
    // rust: super::screen_info::confirm(
    // rust: "server_links/confirm_link",
    // rust: &super::screen_info::tr(title, &[]),
    // rust: &url,
    // rust: )
    // rust: });
    // rust: let layout = confirm_link_layout(atlas, (w, h), &url, trusted);
    // rust: for (line, x, y) in &layout.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: let labels = confirm_link_labels(self.links_ui.trusted);
        // Its third button answers no, as Escape does.
    // rust: if let Some(&(x, y)) = layout.buttons.get(2) {
    // rust: horizon_client::widgets::declare_action(
    // rust: horizon_client::widgets::Action::Cancel,
    // rust: [x, y, 100.0, 20.0],
    // rust: true,
    // rust: );
}
    // rust: for ((x, y), key) in layout.buttons.iter().zip(labels) {
    // rust: let hover = ui::hovered(self.cursor, *x, *y, 100.0, 20.0);
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: *x,
    // rust: *y,
    // rust: 100.0,
    // rust: 20.0,
    // rust: &Text::translate(key, &[]),
    // rust: true,
    // rust: hover,
    // rust: );
}
}
    /// ConfirmLinkScreen's answer: yes opens the browser, the middle button
    /// copies the link, no closes; all return to Server Links.
    // rust: pub(super) fn confirm_link_click(&mut self) {
    // rust: let (w, h) = self.gui_size();
    // rust: let url = self.links_ui.confirm.clone().unwrap_or_default();
    // rust: let layout = confirm_link_layout(&self.gui.atlas, (w, h), &url, self.links_ui.trusted);
    // rust: for (i, (x, y)) in layout.buttons.iter().enumerate() {
    // rust: if !ui::hovered(self.cursor, *x, *y, 100.0, 20.0) {
    // rust: continue;
}
    // rust: self.audio.play_button_click();
    // rust: match i {
    // rust: 0 => open_uri(&url),
    // rust: 1 => {
    // rust: self.clipboard.set(&url);
}
    // rust: _ => {}
}
    // rust: self.screen = self.confirm_link_back();
    // rust: return;
}
}
    /// `DialogScreen.WarningScreen`: the custom-screens note, a disconnect
    /// button ("Custom screen rejected" is the shown reason) and Back.
    // rust: pub(super) fn draw_dialog_warning(&mut self, batch: &mut HudBatch) {
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: super::screen_info::confirm(
    // rust: "dialog_warning",
    // rust: &super::screen_info::tr("menu.custom_screen_info.title", &[]),
    // rust: &super::screen_info::tr("menu.custom_screen_info.contents", &[]),
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let layout = dialog_warning_layout(atlas, (w, h));
    // rust: for (line, x, y) in &layout.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: let quit = if self.external_server() {
    // rust: "menu.disconnect"
    // rust: } else {
    // rust: "menu.returnToMenu"
}
    // rust: for ((x, y), key) in layout.buttons.into_iter().zip([quit, "gui.back"]) {
    // rust: let hover = ui::hovered(self.cursor, x, y, 150.0, 20.0);
    // rust: if key == "gui.back" {
    // rust: horizon_client::widgets::declare_action(
    // rust: horizon_client::widgets::Action::Back,
    // rust: [x, y, 150.0, 20.0],
    // rust: true,
    // rust: );
}
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: 150.0,
    // rust: 20.0,
    // rust: &Text::translate(key, &[]),
    // rust: true,
    // rust: hover,
    // rust: );
}
}
    /// WarningScreen's answer: disconnect, or back to Server Links.
    // rust: pub(super) fn dialog_warning_click(&mut self) -> Result<()> {
    // rust: let (w, h) = self.gui_size();
    // rust: let layout = dialog_warning_layout(&self.gui.atlas, (w, h));
    // rust: for (i, (x, y)) in layout.buttons.iter().enumerate() {
    // rust: if !ui::hovered(self.cursor, *x, *y, 150.0, 20.0) {
    // rust: continue;
}
    // rust: self.audio.play_button_click();
    // rust: if i == 0 {
                // DialogConnectionAccess.disconnect: leave with the custom
                // screens' reason.
    // rust: let reason = self.translate(
    // rust: "menu.custom_screen_info.disconnect",
    // rust: "Custom screen rejected",
    // rust: );
    // rust: self.leave_server(Some(reason))?;
    // rust: } else {
    // rust: self.screen = Screen::ServerLinks;
}
    // rust: return Ok(());
}
    // rust: Ok(())
}
}

/// A confirm screen's laid-out text (title, message, extra warning lines) and
/// button corners; the whole column centred (ConfirmScreen.init).
pub const ConfirmLayout = struct {
    lines: Vec<(Text,
    buttons: Vec<(f32,
};
/// `ConfirmScreen.init`: title, message wrapped to `width - 50` (15 rows at
/// most), the extra lines, then a button row `spacing` 4 with `paddingTop` 16.
    // rust: fn confirm_layout(
    // rust: font: &horizon_client::font::Font,
    // rust: (w, h): (f32, f32),
    // rust: title: &Text,
    // rust: message: &Text,
    // rust: extra: &[Text],
    // rust: button_widths: &[f32],
    // rust: ) -> ConfirmLayout {
    // rust: let message: Vec<Text> = font
    // rust: .split_lines(message, w - 50.0)
    // rust: .into_iter()
    // rust: .take(15)
    // rust: .map(|(line, _)| line)
    // rust: .collect();
    // LinearLayout vertical spacing 8; the button row's children pad 16 on top.
    // rust: let extra_h = 17.0 * extra.len() as f32;
    // rust: let mh = 9.0 * message.len() as f32;
    // rust: let total = 9.0 + 8.0 + mh + extra_h + 8.0 + 16.0 + 20.0;
    // rust: let mut y = ((h - total) / 2.0).trunc();
    // rust: let mut lines = Vec::new();
    // rust: let mut push = |line: &Text, at: f32| {
    // rust: let lw = font.width_text(line);
    // rust: lines.push((line.clone(), ((w - lw) / 2.0).trunc(), at));
}
    // rust: push(title, y);
    // rust: y += 17.0;
    // rust: for line in &message {
    // rust: push(line, y);
    // rust: y += 9.0;
}
    // rust: for line in extra {
    // rust: y += 8.0;
    // rust: push(line, y);
    // rust: y += 9.0;
}
    // rust: let row_w: f32 = button_widths.iter().sum::<f32>() + 4.0 * (button_widths.len() - 1) as f32;
    // rust: let by = y + 8.0 + 16.0;
    // rust: let mut bx = ((w - row_w) / 2.0).trunc();
    // rust: let buttons = button_widths
    // rust: .iter()
    // rust: .map(|bw| {
    // rust: let p = (bx, by);
    // rust: bx += bw + 4.0;
    // rust: p
    // rust: })
    // rust: .collect();
    // rust: ConfirmLayout { lines, buttons }
}
    // rust: fn confirm_link_layout(
    // rust: atlas: &horizon_client::hud::HudAtlas,
    // rust: size: (f32, f32),
    // rust: url: &str,
    // rust: trusted: bool,
    // rust: ) -> ConfirmLayout {
    // ConfirmLinkScreen: `chat.link.confirm` (`confirmTrusted` when trusted),
    // the link as the message, and for an untrusted link `chat.link.warning`
    // in its red (0xFFCCCC).
    // rust: let warning = [Text::translate("chat.link.warning", &[]).with_color(0xFFCCCC)];
    // rust: confirm_layout(
    // rust: &atlas.font,
    // rust: size,
    // rust: &Text::translate(
    // rust: if trusted {
    // rust: "chat.link.confirmTrusted"
    // rust: } else {
    // rust: "chat.link.confirm"
    // rust: },
    // rust: &[],
    // rust: ),
    // rust: &Text::literal(url.to_owned()),
    // rust: if trusted { &[] } else { &warning },
    // rust: &[100.0; 3],
    // rust: )
}
/// `ConfirmLinkScreen`'s yes, copy and no labels: Open in Browser and Cancel
/// when trusted.
pub fn confirm_link_labels(trusted: bool) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if trusted {
    // rust: ["chat.link.open", "gui.copy_link_to_clipboard", "gui.cancel"]
    // rust: } else {
    // rust: ["gui.yes", "gui.copy_link_to_clipboard", "gui.no"]
}
}
pub fn dialog_warning_layout(atlas: *horizon_client::hud::HudAtlas, size: (f32) void {
}
    // rust: confirm_layout(
    // rust: &atlas.font,
    // rust: size,
    // rust: &Text::translate("menu.custom_screen_info.title", &[]),
    // rust: &Text::translate("menu.custom_screen_info.contents", &[]),
    // rust: &[],
    // rust: &[150.0; 2],
    // rust: )
}

    // rust: mod tests {
//     use super::*;

pub fn a_trusted_link_asks_with_open_in_browser_and_cancel() void {
}
        // ConfirmLinkScreen: trusted swaps yes/no for chat.link.open / gui.cancel.
    // rust: assert_eq!(
    // rust: confirm_link_labels(true),
    // rust: ["chat.link.open", "gui.copy_link_to_clipboard", "gui.cancel"]
    // rust: );
    // rust: assert_eq!(
    // rust: confirm_link_labels(false),
    // rust: ["gui.yes", "gui.copy_link_to_clipboard", "gui.no"]
    // rust: );
}

pub fn untrusted_uris_are_http_or_https_with_a_scheme() void {
}
    // rust: for ok in [
    // rust: "https://example.net/x",
    // rust: "http://example.net",
    // rust: "HTTPS://EXAMPLE.NET",
    // rust: ] {
    // rust: assert!(valid_untrusted_uri(ok), "{ok}");
}
    // rust: for bad in [
    // rust: "example.net/no-scheme",
    // rust: "ftp://example.net",
    // rust: "file:///etc/passwd",
    // rust: "javascript:alert(1)",
    // rust: "https://exa mple.net",
    // rust: "://example.net",
    // rust: "",
    // rust: ] {
    // rust: assert!(!valid_untrusted_uri(bad), "{bad}");
}
}
}
