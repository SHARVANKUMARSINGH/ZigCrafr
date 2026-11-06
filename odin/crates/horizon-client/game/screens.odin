//! Transpiled from Horizon Rust crate
package horizon_client_screens

import "core:fmt"
import "core:mem"
import "core:math"

// The pause menu (PauseScreen) and death screen (DeathScreen) layouts.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: Result,
    // rust: confirm_screen::Confirm,
    // rust: dialog::Dialog,
    // rust: hud::{HudBatch, rgba},
    // rust: text::{self, Text},
    // rust: ui,
    // rust: widgets::{self, ScreenInfo},
}
// use horizon_world::nbt::Tag;
// use winit::keyboard::KeyCode;

    // rust: impl Screen {
    // Screen.extractBackground for non-isInGameUi screens, and
    // PauseScreen.extractBackground only when showPauseMenu is true.
    // rust: pub(super) fn blurs_background(self, pause_menu: bool) -> bool {
    // rust: match self {
    // rust: Self::Paused => pause_menu,
    // rust: Self::Options
    // rust: | Self::Stats
    // rust: | Self::Advancements
    // rust: | Self::WorldOptions
    // rust: | Self::Friends
    // rust: | Self::Social
    // rust: | Self::ServerLinks
    // rust: | Self::ConfirmLink
    // rust: | Self::DialogWarning
    // rust: | Self::DebugOptions => true,
    // rust: Self::Playing
    // rust: | Self::GameModeSwitcher
    // rust: | Self::EmoteWheel
    // rust: | Self::Chat
    // rust: | Self::Creative
    // rust: | Self::Inventory
    // rust: | Self::Dead
    // rust: | Self::CommandBlock
    // rust: | Self::BlockEditor
    // rust: | Self::Mod
            // The HUD editor shows the HUD it moves.
    // rust: | Self::HudEditor => false,
            // WinScreen.extractBackground: the poem fills the screen with the End portal, the
            // credits alone blur. Game::menu_blur knows which one rolls.
    // rust: Self::Win => false,
}
}
}

// The pause menu grid's origin: GridLayout of two 98px columns (padding 4),
// aligned at (0.5, 0.25). Extra rows hold a server dialog or links
// (`PauseScreen.getCustomAdditions`), followed by the guest profile settings.
pause_grid :: proc(w: f32, h: f32, extra_rows: u8) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (grid_w, grid_h) = (212.0, 166.0 + 24.0 * f32::from(extra_rows));
    // rust: (((w - grid_w) * 0.5).floor(), ((h - grid_h) * 0.25).floor())
}

// PauseScreen buttons: (x, y, width, label key, action id, active).
// `links`: the `minecraft:server_links` dialog's button, which
// `PauseScreen.getCustomAdditions` falls back to when `pause_screen_additions`
// is empty and the server sent links — a full-width row that pushes the last
// two rows down.
// `additions`: the `pause_screen_additions` button instead of the links one
// (vanilla shows one or the other, never both); its label is the dialog's
// external title, so the caller draws it (id 14).
// https://mcsrc.dev/2/26.3/net/minecraft/client/gui/screens/PauseScreen
    // rust: fn pause_buttons(
    // rust: w: f32,
    // rust: h: f32,
    // rust: remote: bool,
    // rust: links: bool,
    // rust: additions: bool,
    // rust: split: bool,
    // rust: ) -> Vec<(f32, f32, f32, &'static str, u8, bool)> {
    // rust: let row3 = links || additions;
    // rust: let (x0, y0) = pause_grid(w, h, u8::from(row3) + u8::from(split));
    // rust: let down = 24.0 * f32::from(u8::from(row3) + u8::from(split));
    // rust: let mut v = vec![
    // rust: (x0 + 4.0, y0 + 50.0, 204.0, "menu.returnToGame", 0, true),
    // rust: (x0 + 4.0, y0 + 74.0, 98.0, "gui.advancements", 4, true),
    // rust: (x0 + 110.0, y0 + 74.0, 98.0, "gui.stats", 3, true),
    // rust: ];
    // rust: if additions {
        // addCustomDialogButtons: one full-width button, labelled with the
        // dialog's CommonDialogData.computeExternalTitle.
    // rust: v.push((x0 + 4.0, y0 + 122.0, 204.0, "", 14, true));
    // rust: } else if links {
        // CommonDialogData.computeExternalTitle of Dialogs.SERVER_LINKS.
    // rust: v.push((x0 + 4.0, y0 + 122.0, 204.0, "menu.server_links", 11, true));
}
    // rust: if split {
    // rust: let y = y0 + 122.0 + if row3 { 24.0 } else { 0.0 };
    // rust: v.push((x0 + 4.0, y, 204.0, SPLIT_SETTINGS, 30, true));
}
    // rust: v.extend([
    // rust: (x0 + 4.0, y0 + 122.0 + down, 98.0, "menu.options", 1, true),
    // rust: (
    // rust: x0 + 110.0,
    // rust: y0 + 122.0 + down,
    // rust: 98.0,
    // rust: "options.worldOptions.button",
    // rust: 9,
    // rust: true,
    // rust: ),
    // rust: (
    // rust: x0 + 4.0,
    // rust: y0 + 146.0 + down,
    // rust: 204.0,
    // rust: if remote {
    // rust: "menu.disconnect"
    // rust: } else {
    // rust: "menu.returnToMenu"
    // rust: },
    // rust: 2,
    // rust: true,
    // rust: ),
    // rust: ]);
    // rust: v
}

// The icon row: report bugs, feedback, friends, player reporting.
// `FRIENDS_ICON` (vanilla's `CommonButtons.friends`) opens Horizon's
// Play with Friends; the first two open their link through
// `ConfirmLinkScreen`; player reporting opens `SocialInteractionsScreen`.
FRIENDS_ICON :: 2
// `CommonLinks.SNAPSHOT_BUGS_FEEDBACK`, behind `PauseScreen.REPORT_BUGS`.
BUGS_LINK :: "https://aka.ms/snapshotbugs?ref=game"
// `CommonLinks.RELEASE_FEEDBACK` / `SNAPSHOT_FEEDBACK`, by `WorldVersion.stable()`.
feedback_link :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if horizon_core::version::STABLE {
    // rust: "https://aka.ms/javafeedback?ref=game"
    // rust: } else {
    // rust: "https://aka.ms/snapshotfeedback?ref=game"
}
}
// `PauseScreen.createPauseMenu`'s icon tooltips (`SpriteIconButton.withTootip`).
    // rust: const ICON_LABELS: [&str; 4] = [
    // rust: "menu.reportBugs",
    // rust: "menu.sendFeedback",
    // rust: "gui.friends.open",
    // rust: "menu.playerReporting",
    // rust: ];
// Whether an icon button is active: `reportBugsButton.active =
// !dataVersion().isSideSeries()` (26.3 is the `main` series), the feedback
// button always, friends when the friends list is shown.
icon_active :: proc(icon: uint, friends: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match icon {
    // rust: 0 | 1 | 3 => true,
    // rust: FRIENDS_ICON => friends,
    // rust: _ => false,
}
}
pause_icon_focus_ids :: proc(friends: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..4)
    // rust: .filter(|&i| icon_active(i, friends))
    // rust: .map(|i| if i == FRIENDS_ICON { 10 } else { 12 + i as u8 })
    // rust: .collect()
}
SPLIT_SETTINGS :: "horizon.pages.split_settings"
    // rust: fn pause_icons(
    // rust: w: f32,
    // rust: h: f32,
    // rust: links: bool,
    // rust: additions: bool,
    // rust: split: bool,
    // rust: ) -> [(f32, f32, &'static str); 4] {
    // rust: let (x0, y0) = pause_grid(w, h, u8::from(links || additions) + u8::from(split));
    // rust: let (x0, y) = (x0 + 60.0, y0 + 98.0);
    // rust: [
    // rust: (x0, y, "gui/sprites/pause_menu/bug"),
    // rust: (x0 + 24.0, y, "gui/sprites/pause_menu/social_interactions"),
    // rust: (x0 + 48.0, y, "gui/sprites/friends/friends"),
    // rust: (x0 + 72.0, y, "gui/sprites/pause_menu/player_reporting"),
    // rust: ]
}
// DeathScreen.init: a hardcore player can only spectate.
// `DeathScreen.TitleConfirmScreen`: its title and the yes and no labels.
death_confirm_texts :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let t = |key: &str| Text::translate(key, &[]);
    // rust: (
    // rust: t("deathScreen.quit.confirm"),
    // rust: [t("deathScreen.titleScreen"), t("deathScreen.respawn")],
    // rust: )
}
death_buttons :: proc(w: f32, h: f32, hardcore: bool) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let respawn = if hardcore {
    // rust: "deathScreen.spectate"
    // rust: } else {
    // rust: "deathScreen.respawn"
}
    // DeathScreen.init: `width / 2 - 100`, `height / 4 + 72` and `+ 96`, in
    // int GUI pixels.
    // rust: let (x, y) = ((w.ceil() / 2.0).floor() - 100.0, (h.ceil() / 4.0).floor());
    // rust: [
    // rust: (x, y + 72.0, respawn, 0),
    // rust: (x, y + 96.0, "deathScreen.titleScreen", 1),
    // rust: ]
}
    // rust: impl Game<'_> {
    // `PauseScreen.getCustomAdditions`'s additions: the
    // `minecraft:pause_screen_additions` tag's one dialog, or the
    // `minecraft:custom_options` `dialog_list` when it names several. `None`
    // when the tag is empty: the caller falls back to the server links
    // button, as vanilla does.
pause_screen_additions :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let registries = &self.remote.as_ref()?.registries;
    // rust: let dialogs = registries.registries.get("minecraft:dialog")?;
    // rust: let tag = registries
    // rust: .dialog_tags
    // rust: .get("minecraft:pause_screen_additions")?;
        // addCustomDialogButtons' label: computeExternalTitle falls back to the title.
    // rust: let button = |dialog_tag: Tag| -> Option<(Text, Tag)> {
    // rust: let dialog = Dialog::parse(&dialog_tag)?;
    // rust: let label = dialog.external_title.unwrap_or(dialog.title);
    // rust: Some((label, dialog_tag))
}
    // rust: match tag.len() {
    // rust: 0 => None,
    // rust: 1 => {
    // rust: let i = usize::try_from(tag[0]).ok()?;
    // rust: button(dialogs.get(i)?.1.clone()?)
}
            // `Dialogs.CUSTOM_OPTIONS`: the dialog list over the same tag.
    // rust: _ => button(
    // rust: dialogs
    // rust: .iter()
    // rust: .find(|(name, _)| name == "minecraft:custom_options")?
    // rust: .1
    // rust: .clone()?,
    // rust: ),
}
}

    // Singleplayer also has a connection, backed by the integrated server.
    // rust: pub(super) fn external_server(&self) -> bool {
    // rust: self.remote.is_some() && self.integrated.is_none()
}
    // rust: pub(super) fn draw_pause_menu(&mut self, batch: &mut HudBatch) {
    // rust: let friends = self.friends_view().shown;
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let title = Text::translate("menu.game", &[]);
    // rust: widgets::begin_screen(|| ScreenInfo::new("pause", title.plain()));
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).floor(),
    // rust: 40.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let links = !self.server_links().is_empty();
    // rust: let additions = self.pause_screen_additions();
    // rust: let mut tooltip = None;
    // rust: for (x, y, bw, key, id, active) in pause_buttons(
    // rust: w,
    // rust: h,
    // rust: self.external_server(),
    // rust: links,
    // rust: additions.is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: ) {
    // rust: let is_focused = self.pause_focus == Some(id);
    // rust: let hover = active && (ui::hovered(self.cursor, x, y, bw, 20.0) || is_focused);
    // rust: let label = match (id, &additions) {
    // rust: (14, Some((label, _))) => label.clone(),
    // rust: _ if self.options.split_guest && key == "menu.disconnect" => {
    // rust: Text::translate("horizon.split.leave", &[])
}
    // rust: _ => Text::translate(key, &[]),
}
    // rust: let action = match id {
    // rust: 0 => Some(horizon_client::widgets::Action::Back),
    // rust: 1 => Some(horizon_client::widgets::Action::Options),
    // rust: 2 => Some(horizon_client::widgets::Action::Exit),
    // rust: _ => None,
}
    // rust: if let Some(action) = action {
    // rust: ui::action_button(batch, atlas, action, x, y, bw, 20.0, &label, active, hover);
    // rust: } else {
    // rust: ui::button(batch, atlas, x, y, bw, 20.0, &label, active, hover);
}
            // PauseScreen's customAdditions button: CUSTOM_OPTIONS_TOOLTIP.
    // rust: if (id == 11 || id == 14) && hover {
    // rust: tooltip = Some(Text::translate("menu.custom_options.tooltip", &[]));
}
}
    // rust: for (i, (x, y, sprite)) in pause_icons(
    // rust: w,
    // rust: h,
    // rust: links,
    // rust: additions.is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: )
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let active = icon_active(i, friends);
    // rust: let is_focused = (self.pause_focus == Some(10) && i == FRIENDS_ICON)
    // rust: || (self.pause_focus == Some(12 + i as u8));
    // rust: let hover = active && (ui::hovered(self.cursor, x, y, 20.0, 20.0) || is_focused);
            // The icon has no label: name it for controller focus and the
            // control socket's widget tree.
    // rust: if i == FRIENDS_ICON {
    // rust: horizon_client::widgets::record(
    // rust: horizon_client::friends_screen::TITLE,
    // rust: [x, y, 20.0, 20.0],
    // rust: active,
    // rust: );
}
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: 20.0,
    // rust: 20.0,
    // rust: &Text::empty(),
    // rust: active,
    // rust: hover,
    // rust: );
            // PauseScreen adds the icon row after Statistics: the icons'
            // messages (their tooltips too), the friends button's own.
    // rust: widgets::last_narratable_at(3 + i, |n| {
    // rust: let t = |key: &str| Text::translate(key, &[]).plain();
    // rust: let key = [
    // rust: "menu.reportBugs",
    // rust: "menu.sendFeedback",
    // rust: "",
    // rust: "menu.playerReporting",
    // rust: ][i];
    // rust: *n = if i == FRIENDS_ICON {
    // rust: widgets::Narratable::named(t("gui.friends.open.narration"), n.rect, active)
    // rust: .hint(t("gui.friends.open.tooltip"))
    // rust: } else {
    // rust: widgets::Narratable::button(t(key), n.rect, active).hint(t(key))
}
    // rust: .hovered(hover);
    // rust: });
            // SpriteIconButton.CenteredIcon: the 15x15 sprite at
            // x + width / 2 - 15 / 2 in integer pixels, untinted even
            // when the button is inactive.
    // rust: batch.sprite_scaled(atlas, sprite, x + 3.0, y + 3.0, 15.0, 15.0, u32::MAX);
    // rust: if hover {
    // rust: tooltip = Some(if i == FRIENDS_ICON {
    // rust: Text::literal(horizon_client::friends_screen::title())
    // rust: } else {
    // rust: Text::translate(ICON_LABELS[i], &[])
    // rust: });
}
}
        // SpriteIconButton.withTootip: the label as a tooltip.
    // rust: if let Some(tip) = tooltip {
    // rust: let lines: Vec<Text> = atlas
    // rust: .font
    // rust: .split_lines(&tip, batch.width)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .collect();
    // rust: ui::tooltip(batch, atlas, &lines, self.cursor);
}
}
    // rust: pub(super) fn execute_pause_action(&mut self, hit: u8) -> Result<()> {
    // rust: match hit {
    // rust: 0 => {
    // rust: self.pause_focus = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
    // rust: 1 => self.open_options(false),
    // rust: 3 => self.open_stats(),
    // rust: 4 => self.open_advancements(true),
    // rust: 9 => self.open_world_options(),
    // rust: 10 => self.screen = Screen::Friends,
            // DialogConnectionAccess.openDialog(Dialogs.SERVER_LINKS).
    // rust: 11 => {
    // rust: self.links_ui.scroll = 0.0;
    // rust: self.screen = Screen::ServerLinks;
}
            // ConfirmLinkScreen.confirmLink(this, CommonLinks...) on the pause screen.
    // rust: 12 => self.confirm_trusted_link(BUGS_LINK, Screen::Paused),
    // rust: 13 => self.confirm_trusted_link(feedback_link(), Screen::Paused),
            // PauseScreen: `new SocialInteractionsScreen(this)`.
    // rust: 15 => self.open_social(true),
    // rust: 30 => self.open_split_settings(),
            // addCustomDialogButtons: DialogConnectionAccess.openDialog of the
            // additions dialog, from the pause menu.
    // rust: 14 => {
    // rust: if let Some((_, dialog)) = self.pause_screen_additions() {
    // rust: self.pause_focus = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
    // rust: self.show_dialog(&dialog);
}
}
    // rust: 2 => self.close_world()?,
    // rust: _ => {}
}
    // rust: Ok(())
}
    // rust: pub(super) fn pause_click(&mut self) -> Result<()> {
    // rust: let (w, h) = {
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: (b.width, b.height)
}
    // rust: let links = !self.server_links().is_empty();
    // rust: let additions = self.pause_screen_additions();
    // rust: let icons = pause_icons(
    // rust: w,
    // rust: h,
    // rust: links,
    // rust: additions.is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: );
    // rust: let friends = icons[FRIENDS_ICON];
    // rust: let hit = pause_buttons(
    // rust: w,
    // rust: h,
    // rust: self.external_server(),
    // rust: links,
    // rust: additions.is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: )
    // rust: .into_iter()
    // rust: .find(|b| b.5 && ui::hovered(self.cursor, b.0, b.1, b.2, 20.0))
    // rust: .map(|b| b.4)
    // rust: .or_else(|| {
            // The report bugs, feedback and player reporting icons (ids 12, 13 and 15).
    // rust: [0, 1, 3]
    // rust: .into_iter()
    // rust: .find(|&i| ui::hovered(self.cursor, icons[i].0, icons[i].1, 20.0, 20.0))
    // rust: .map(|i| 12 + i as u8)
    // rust: })
    // rust: .or_else(|| {
    // rust: (self.friends_view().shown
    // rust: && ui::hovered(self.cursor, friends.0, friends.1, 20.0, 20.0))
    // rust: .then_some(10)
    // rust: });
    // rust: if let Some(id) = hit {
    // rust: self.pause_focus = Some(id);
    // rust: self.audio.play_button_click();
    // rust: self.execute_pause_action(id)?;
}
    // rust: Ok(())
}
    // rust: pub(super) fn pause_key(&mut self, key: KeyCode) -> Result<()> {
    // rust: let (w, h) = {
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: (b.width, b.height)
}
    // rust: let links = !self.server_links().is_empty();
    // rust: let buttons = pause_buttons(
    // rust: w,
    // rust: h,
    // rust: self.external_server(),
    // rust: links,
    // rust: self.pause_screen_additions().is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: );
    // rust: let mut active_ids: Vec<u8> = buttons.into_iter().filter(|b| b.5).map(|b| b.4).collect();
    // rust: let friends = self.friends_view().shown;
    // rust: active_ids.extend(pause_icon_focus_ids(friends));
    // rust: if active_ids.is_empty() {
    // rust: return Ok(());
}
    // rust: match key {
    // rust: KeyCode::Tab => {
    // rust: let reverse = self.has_shift_down();
    // rust: let next = match self.pause_focus {
    // rust: Some(cur) => {
    // rust: if let Some(pos) = active_ids.iter().position(|&id| id == cur) {
    // rust: if reverse {
    // rust: if pos == 0 {
    // rust: active_ids.last().copied()
    // rust: } else {
    // rust: Some(active_ids[pos - 1])
}
    // rust: } else if pos + 1 >= active_ids.len() {
    // rust: active_ids.first().copied()
    // rust: } else {
    // rust: Some(active_ids[pos + 1])
}
    // rust: } else if reverse {
    // rust: active_ids.last().copied()
    // rust: } else {
    // rust: active_ids.first().copied()
}
}
    // rust: None => {
    // rust: if reverse {
    // rust: active_ids.last().copied()
    // rust: } else {
    // rust: active_ids.first().copied()
}
}
}
    // rust: self.pause_focus = next;
}
    // rust: KeyCode::ArrowUp | KeyCode::ArrowDown | KeyCode::ArrowLeft | KeyCode::ArrowRight => {
    // rust: let buttons = pause_buttons(
    // rust: w,
    // rust: h,
    // rust: self.external_server(),
    // rust: links,
    // rust: self.pause_screen_additions().is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: );
    // rust: let mut rects: Vec<(u8, f32, f32, f32)> = buttons
    // rust: .into_iter()
    // rust: .filter(|b| b.5)
    // rust: .map(|b| (b.4, b.0, b.1, b.2))
    // rust: .collect();
    // rust: let friends = self.friends_view().shown;
    // rust: for (i, (x, y, _)) in pause_icons(
    // rust: w,
    // rust: h,
    // rust: links,
    // rust: self.pause_screen_additions().is_some(),
    // rust: self.options.split_guest || self.split_hud.menu,
    // rust: )
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if icon_active(i, friends) {
    // rust: let id = if i == FRIENDS_ICON { 10 } else { 12 + i as u8 };
    // rust: rects.push((id, x, y, 20.0));
}
}
    // rust: let cur_id = self.pause_focus.unwrap_or(0);
    // rust: if let Some(cur) = rects.iter().find(|r| r.0 == cur_id) {
    // rust: let (cx, cy) = (cur.1 + cur.3 / 2.0, cur.2 + 10.0);
    // rust: let mut best: Option<(u8, f32)> = None;
    // rust: for r in &rects {
    // rust: if r.0 == cur_id {
    // rust: continue;
}
    // rust: let (rx, ry) = (r.1 + r.3 / 2.0, r.2 + 10.0);
    // rust: let (dx, dy) = (rx - cx, ry - cy);
    // rust: let valid = match key {
    // rust: KeyCode::ArrowUp => dy < -4.0,
    // rust: KeyCode::ArrowDown => dy > 4.0,
    // rust: KeyCode::ArrowLeft => dx < -4.0,
    // rust: KeyCode::ArrowRight => dx > 4.0,
    // rust: _ => false,
}
    // rust: if !valid {
    // rust: continue;
}
    // rust: let dist = match key {
    // rust: KeyCode::ArrowUp | KeyCode::ArrowDown => dy.abs() + dx.abs() * 2.0,
    // rust: KeyCode::ArrowLeft | KeyCode::ArrowRight => dx.abs() + dy.abs() * 2.0,
    // rust: _ => f32::MAX,
}
    // rust: if best.as_ref().is_none_or(|(_, d)| dist < *d) {
    // rust: best = Some((r.0, dist));
}
}
    // rust: if let Some((next_id, _)) = best {
    // rust: self.pause_focus = Some(next_id);
}
    // rust: } else {
    // rust: self.pause_focus = Some(active_ids[0]);
}
}
    // rust: KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space => {
    // rust: if let Some(hit) = self.pause_focus {
    // rust: self.audio.play_button_click();
    // rust: self.execute_pause_action(hit)?;
}
}
    // rust: _ => {}
}
    // rust: Ok(())
}
    // DeathScreen: gradient, the title at double size, the cause and score.
    // rust: pub(super) fn draw_death_screen(&mut self, batch: &mut HudBatch) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
        // fillGradient(0x60500000 -> 0xA0803030).
    // rust: let rows = h.ceil() as i32;
    // rust: for y in 0..rows {
    // rust: let t = y as f32 / h.max(1.0);
    // rust: let lerp = |a: f32, b: f32| (a + (b - a) * t) as u8;
    // rust: batch.fill(
    // rust: atlas,
    // rust: 0.0,
    // rust: y as f32,
    // rust: w,
    // rust: 1.0,
    // rust: rgba(
    // rust: lerp(80.0, 128.0),
    // rust: lerp(0.0, 48.0),
    // rust: lerp(0.0, 48.0),
    // rust: lerp(96.0, 160.0),
    // rust: ),
    // rust: );
}
        // DeathScreen.handleExitToTitleScreen: the TitleConfirmScreen takes the
        // screen over, on the same background.
    // rust: if let Some(opened) = self.ui.death_confirm {
    // rust: let (title, labels) = death_confirm_texts();
            // ConfirmScreen.getNarrationMessage: its title and its (empty)
            // message.
    // rust: widgets::begin_screen(|| {
    // rust: ScreenInfo::new(
    // rust: "death/confirm",
    // rust: widgets::join_for_narration(&[&title.plain(), ""]),
    // rust: )
    // rust: });
    // rust: let size = self.gui_size();
    // rust: let mut confirm = Confirm::new(&atlas.font, size, &title, &Text::literal(""));
    // rust: confirm.focus = self.death_focus.map(|f| f as usize);
    // rust: confirm.draw_active(
    // rust: batch,
    // rust: atlas,
    // rust: self.cursor,
    // rust: [&labels[0], &labels[1]],
    // rust: opened.elapsed().as_millis() >= 1000,
    // rust: );
    // rust: return;
}
    // rust: let title = if self.level.hardcore {
    // rust: "deathScreen.title.hardcore"
    // rust: } else {
    // rust: "deathScreen.title"
}
    // rust: let title = Text::translate(title, &[]);
    // rust: widgets::begin_screen(|| ScreenInfo::new("death", title.plain()));
    // rust: let tw = atlas.font.width_text(&title);
    // rust: ui::text_scaled(
    // rust: batch,
    // rust: atlas,
    // rust: &title,
    // rust: (w / 2.0 - tw).floor(),
    // rust: 60.0,
    // rust: 2.0,
    // rust: u32::MAX,
    // rust: );
    // rust: if let Some(cause) = &self.ui.death_text {
    // rust: let cw = atlas.font.width_text(cause);
    // rust: batch.text_styled(atlas, cause, ((w - cw) / 2.0).floor(), 85.0, u32::MAX, true);
}
    // rust: let score = Text::translate(
    // rust: "deathScreen.score.value",
    // rust: &[Text::colored(
    // rust: self.experience.total.to_string(),
    // rust: text::YELLOW,
    // rust: )],
    // rust: );
    // rust: let sw = atlas.font.width_text(&score);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &score,
    // rust: ((w - sw) / 2.0).floor(),
    // rust: 100.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let active = self
    // rust: .ui
    // rust: .died_at
    // rust: .is_none_or(|t| t.elapsed().as_millis() >= 1000);
    // rust: for (x, y, key, id) in death_buttons(w, h, self.level.hardcore) {
    // rust: let is_focused = self.death_focus == Some(id);
    // rust: let hover = active && (ui::hovered(self.cursor, x, y, 200.0, 20.0) || is_focused);
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: 200.0,
    // rust: 20.0,
    // rust: &Text::translate(key, &[]),
    // rust: active,
    // rust: hover,
    // rust: );
}
}
    // LocalPlayer.respawn: the player comes back (the death screen's
    // button, or at once with `immediate_respawn`).
    // rust: pub(super) fn respawn_player(&mut self) -> Result<()> {
    // rust: self.death_focus = None;
    // rust: self.ui.death_text = None;
        // LocalPlayer.respawn: KeyMapping.resetToggleKeys.
    // rust: self.toggles.respawn();
    // rust: self.remote_respawn();
    // rust: Ok(())
}
    // rust: pub(super) fn death_click(&mut self) -> Result<()> {
    // rust: if self
    // rust: .ui
    // rust: .died_at
    // rust: .is_some_and(|t| t.elapsed().as_millis() < 1000)
    // rust: {
    // rust: return Ok(());
}
    // rust: if let Some(opened) = self.ui.death_confirm {
            // ConfirmScreen.setDelay: both buttons wait 20 ticks.
    // rust: if opened.elapsed().as_millis() < 1000 {
    // rust: return Ok(());
}
    // rust: let (title, _) = death_confirm_texts();
    // rust: let confirm = Confirm::new(
    // rust: &self.gui.atlas.font,
    // rust: self.gui_size(),
    // rust: &title,
    // rust: &Text::literal(""),
    // rust: );
    // rust: if let Some(yes) = confirm.answer_at(self.cursor) {
    // rust: self.death_focus = Some(if yes { 0 } else { 1 });
    // rust: self.death_confirm_answer(yes)?;
}
    // rust: return Ok(());
}
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: let hit = death_buttons(b.width, b.height, self.level.hardcore)
    // rust: .into_iter()
    // rust: .find(|d| ui::hovered(self.cursor, d.0, d.1, 200.0, 20.0))
    // rust: .map(|d| d.3);
    // rust: if let Some(id) = hit {
    // rust: self.death_focus = Some(id);
}
        // handleExitToTitleScreen: outside hardcore, Title Screen asks first.
    // rust: if hit == Some(1) && !self.level.hardcore {
    // rust: self.ui.death_confirm = Some(std::time::Instant::now());
    // rust: self.audio.play_button_click();
    // rust: return Ok(());
}
    // rust: self.death_action(hit)
}
    // rust: pub(super) fn death_key(&mut self, key: KeyCode) -> Result<()> {
    // rust: if self
    // rust: .ui
    // rust: .died_at
    // rust: .is_some_and(|t| t.elapsed().as_millis() < 1000)
    // rust: {
    // rust: return Ok(());
}
    // rust: if let Some(opened) = self.ui.death_confirm {
    // rust: if opened.elapsed().as_millis() < 1000 {
    // rust: return Ok(());
}
    // rust: match key {
    // rust: KeyCode::Escape => {
    // rust: self.audio.play_button_click();
    // rust: self.death_confirm_answer(false)?;
}
    // rust: KeyCode::Tab => {
    // rust: let reverse = self.has_shift_down();
    // rust: self.death_focus = match self.death_focus {
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
    // rust: KeyCode::ArrowLeft => self.death_focus = Some(0),
    // rust: KeyCode::ArrowRight => self.death_focus = Some(1),
    // rust: KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space => {
    // rust: let yes = self.death_focus != Some(1);
    // rust: self.audio.play_button_click();
    // rust: self.death_confirm_answer(yes)?;
}
    // rust: _ => {}
}
    // rust: return Ok(());
}
    // rust: match key {
    // rust: KeyCode::Tab => {
    // rust: let reverse = self.has_shift_down();
    // rust: self.death_focus = match self.death_focus {
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
    // rust: KeyCode::ArrowUp => self.death_focus = Some(0),
    // rust: KeyCode::ArrowDown => self.death_focus = Some(1),
    // rust: KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space => {
    // rust: let Some(hit) = self.death_focus else {
    // rust: return Ok(());
}
    // rust: self.audio.play_button_click();
    // rust: if hit == 1 && !self.level.hardcore {
    // rust: self.ui.death_confirm = Some(std::time::Instant::now());
    // rust: self.death_focus = Some(0);
    // rust: return Ok(());
}
    // rust: self.death_action(Some(hit))?;
}
    // rust: _ => {}
}
    // rust: Ok(())
}
    // The confirm screen's answer: yes leaves the world, no respawns
    // (`DeathScreen.handleExitToTitleScreen`'s callback).
    // rust: pub(super) fn death_confirm_answer(&mut self, yes: bool) -> Result<()> {
    // rust: self.ui.death_confirm = None;
    // rust: if yes {
    // rust: self.audio.play_button_click();
    // rust: self.close_world()
    // rust: } else {
    // rust: self.death_action(Some(0))
}
}
    // A death screen button: 0 respawns (or spectates in hardcore), 1 leaves.
death_action :: proc(self: ^Self, hit: Maybe(u8)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match hit {
    // rust: Some(0) => self.respawn_player()?,
    // rust: Some(1) => self.close_world()?,
    // rust: _ => {}
}
    // rust: if hit.is_some() {
    // rust: self.audio.play_button_click();
}
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::{Screen, death_buttons, pause_buttons, pause_icon_focus_ids, pause_icons};

death_buttons_sit_on_whole_gui_pixels :: proc() {
}
        // DeathScreen.init in ints: a 427x253 GUI (1709x1009 at scale 4) puts
        // Respawn at (113, 63 + 72), not (113.5, 63.25 + 72).
    // rust: let at = |w, h| death_buttons(w, h, false).map(|b| (b.0, b.1));
    // rust: assert_eq!(at(427.0, 253.0), [(113.0, 135.0), (113.0, 159.0)]);
    // rust: assert_eq!(at(320.0, 334.0), [(60.0, 155.0), (60.0, 179.0)]);
}

menu_blur_matches_vanilla_screen_backgrounds :: proc() {
}
    // rust: for screen in [
    // rust: Screen::Options,
    // rust: Screen::Stats,
    // rust: Screen::Advancements,
    // rust: Screen::WorldOptions,
    // rust: ] {
    // rust: assert!(screen.blurs_background(false));
    // rust: assert!(screen.blurs_background(true));
}
    // rust: assert!(Screen::Paused.blurs_background(true));
    // rust: assert!(!Screen::Paused.blurs_background(false));
    // rust: for screen in [
    // rust: Screen::Playing,
    // rust: Screen::GameModeSwitcher,
    // rust: Screen::Chat,
    // rust: Screen::Creative,
    // rust: Screen::Inventory,
    // rust: Screen::Dead,
    // rust: Screen::CommandBlock,
    // rust: Screen::BlockEditor,
    // rust: Screen::Win,
    // rust: ] {
    // rust: assert!(!screen.blurs_background(true));
    // rust: assert!(!screen.blurs_background(false));
}
}

pause_menu_uses_disconnect_for_servers_and_keeps_world_options :: proc() {
}
    // rust: for (remote, label) in [(false, "menu.returnToMenu"), (true, "menu.disconnect")] {
    // rust: let buttons = pause_buttons(427.0, 240.0, remote, false, false, false);
    // rust: let quit = buttons.iter().find(|b| b.4 == 2).unwrap();
    // rust: assert_eq!(quit.3, label);
    // rust: assert!(quit.5);
    // rust: assert!(buttons.iter().any(|b| b.4 == 9 && b.5));
}
}

pause_icons_report_bugs_and_feedback_are_active_like_vanilla :: proc() {
}
//         use super::{FRIENDS_ICON, icon_active};
        // PauseScreen.createPauseMenu: the bug and feedback buttons are live,
        // friends follows its list, player reporting opens the social screen.
    // rust: assert!(icon_active(0, false) && icon_active(1, false) && icon_active(3, false));
    // rust: assert!(icon_active(FRIENDS_ICON, true) && !icon_active(FRIENDS_ICON, false));
}

pause_keyboard_focus_includes_the_active_icon_buttons :: proc() {
}
    // rust: assert_eq!(pause_icon_focus_ids(false), [12, 13, 15]);
    // rust: assert_eq!(pause_icon_focus_ids(true), [12, 13, 10, 15]);
}

server_links_adds_a_full_width_row_above_options :: proc() {
}
    // rust: let with = pause_buttons(427.0, 240.0, true, true, false, false);
    // rust: let without = pause_buttons(427.0, 240.0, true, false, false, false);
    // rust: let links = with.iter().find(|b| b.4 == 11).unwrap();
    // rust: assert_eq!(links.2, 204.0);
    // rust: assert_eq!(links.3, "menu.server_links");
    // rust: assert!(links.5);
        // The icon row sits above it; Options and Disconnect move down 24.
    // rust: let icons = pause_icons(427.0, 240.0, true, false, false);
    // rust: let y0_icons = ((240.0f32 - 190.0) * 0.25).floor() + 98.0;
    // rust: assert_eq!(icons[0].1, y0_icons);
    // rust: assert!(links.1 > icons[0].1);
    // rust: for b in &with {
    // rust: if b.4 == 1 || b.4 == 9 || b.4 == 2 {
    // rust: let same = without.iter().find(|o| o.4 == b.4).unwrap();
    // rust: assert_eq!(b.1, same.1 + 24.0 - 6.0, "{}", b.3);
}
}
}

pause_screen_additions_takes_the_server_links_row :: proc() {
}
        // getCustomAdditions: one additions button in row 3, never next to the
        // links button, so the grid keeps one extra row either way.
    // rust: let with = pause_buttons(427.0, 240.0, true, true, true, false);
    // rust: let links = pause_buttons(427.0, 240.0, true, true, false, false);
    // rust: assert!(with.iter().all(|b| b.4 != 11));
    // rust: let button = with.iter().find(|b| b.4 == 14).unwrap();
    // rust: assert_eq!(
    // rust: (button.0, button.1, button.2, button.5),
    // rust: (links[3].0, links[3].1, 204.0, true)
    // rust: );
    // rust: for id in [1, 9, 2] {
    // rust: let add = with.iter().find(|b| b.4 == id).unwrap();
    // rust: let link = links.iter().find(|b| b.4 == id).unwrap();
    // rust: assert_eq!(add.1, link.1);
}
    // rust: assert_eq!(
    // rust: pause_icons(427.0, 240.0, true, true, false)[0].1,
    // rust: pause_icons(427.0, 240.0, true, false, false)[0].1
    // rust: );
}
split_settings_preserves_dialog_rows_and_icon_actions :: proc() {
}
    // rust: for (links, additions) in [(false, false), (true, false), (false, true), (true, true)] {
    // rust: let buttons = pause_buttons(427.0, 300.0, true, links, additions, true);
    // rust: let split = buttons.iter().find(|b| b.4 == 30).unwrap();
    // rust: let options = buttons.iter().find(|b| b.4 == 1).unwrap();
    // rust: assert_eq!(options.1, split.1 + 24.0);
    // rust: if links || additions {
    // rust: let custom = buttons
    // rust: .iter()
    // rust: .find(|b| b.4 == if additions { 14 } else { 11 })
    // rust: .unwrap();
    // rust: assert_eq!(split.1, custom.1 + 24.0);
}
    // rust: assert!(buttons.iter().all(|b| b.4 != 12 && b.4 != 13));
    // rust: assert!(
    // rust: !pause_buttons(427.0, 300.0, true, links, additions, false)
    // rust: .iter()
    // rust: .any(|b| b.4 == 30)
    // rust: );
}
}
}
