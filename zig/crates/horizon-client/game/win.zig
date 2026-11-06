//! Transpiled from Horizon Rust crate
//! Module: horizon-client_win
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `WinScreen` in the game: the poem and credits after leaving the End for
//! the first time (`EndPortalBlock.entityInside` -> `ServerPlayer.showEndCredits`,
//! or a server's `WIN_GAME` event), and the credits from Credits &
//! Attribution.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: Result,
    // rust: hud::{EndPortalFill, HudBatch},
    // rust: win_screen::{Key, WinScreen},
}
// use std::time::Instant;
// use winit::{
    // rust: event::{ElementState, KeyEvent},
    // rust: keyboard::{KeyCode, PhysicalKey},
}

/// What closing the screen does (`WinScreen.onFinished`).
    // rust: pub(super) enum Finish {
    /// `PERFORM_RESPAWN` sent to the server.
    // rust: RemoteRespawn,
    /// Back to Credits & Attribution.
    // rust: Options,
    /// Back to the game (`horizon-ctl credits`).
    // rust: Closed,
}
    // rust: pub(super) struct Win {
    // rust: screen: WinScreen,
    // rust: finish: Finish,
    /// The last drawn frame, for the scroll's game-time delta.
    // rust: frame: Instant,
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn open_win_screen(&mut self, poem: bool, finish: Finish) {
    // rust: let screen = WinScreen::new(
    // rust: poem,
    // rust: &self.options.resources,
    // rust: &self.options.player_name(),
    // rust: &self.gui.atlas.font,
    // rust: );
    // rust: self.win = Some(Win {
    // rust: screen,
    // rust: finish,
    // rust: frame: Instant::now(),
    // rust: });
    // rust: self.keys.clear();
    // rust: self.screen = Screen::Win;
    // rust: self.capture(false);
}
    /// Stop the scroll `scroll` pixels in (`horizon-ctl credits ... SCROLL`).
    // rust: pub(super) fn hold_win_screen(&mut self, scroll: f32) {
    // rust: if let Some(win) = self.win.as_mut() {
    // rust: win.screen.hold(scroll);
}
}
    /// `WinScreen.isPauseScreen`: only the credits without the poem pause.
    // rust: pub(super) fn win_screen_pauses(&self) -> bool {
    // rust: self.win.as_ref().is_some_and(|w| !w.screen.poem)
}
    // rust: pub(super) fn draw_win_screen(&mut self, batch: &mut HudBatch) {
    // rust: let Some(win) = self.win.as_mut() else {
    // rust: return;
}
    // rust: horizon_client::widgets::begin_screen(|| win.screen.screen_info());
    // rust: let now = Instant::now();
        // DeltaTracker.getGameTimeDeltaTicks: the frame's length in ticks.
    // rust: let delta_ticks =
    // rust: now.duration_since(win.frame).as_secs_f32() / self.clock.tick_duration().as_secs_f32();
    // rust: win.frame = now;
    // rust: let sprite = |n: &str| {
    // rust: self.gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(n)
    // rust: .map_or([0.0; 4], |r| [r.u0, r.v0, r.u1 - r.u0, r.v1 - r.v0])
}
    // rust: let fill = EndPortalFill {
    // rust: sprites: [
    // rust: sprite("environment/end_sky"),
    // rust: sprite("entity/end_portal/end_portal"),
    // rust: ],
    // rust: game_time: (self.world.game_time % 24000) as f32 / 24000.0,
}
    // rust: win.screen.draw(batch, &self.gui.atlas, delta_ticks, fill);
}
    /// `WinScreen.keyPressed` / `keyReleased`; Escape closes it (`onClose`).
    // rust: pub(super) fn win_key(&mut self, event: &KeyEvent) -> Result<()> {
    // rust: let PhysicalKey::Code(code) = event.physical_key else {
    // rust: return Ok(());
}
    // rust: let pressed = event.state == ElementState::Pressed;
    // rust: if code == KeyCode::Escape && pressed {
    // rust: return self.close_win_screen();
}
    // rust: let Some(key) = Key::from_code(code) else {
    // rust: return Ok(());
}
    // rust: if let Some(win) = self.win.as_mut() {
    // rust: win.screen.key(key, pressed);
}
    // rust: Ok(())
}
    /// `WinScreen.tick`: done once everything has rolled past the top.
    // rust: pub(super) fn tick_win_screen(&mut self) -> Result<()> {
    // rust: let height = self.gui_size().1;
    // rust: if self.win.as_ref().is_some_and(|w| w.screen.finished(height)) {
    // rust: self.close_win_screen()?;
}
    // rust: Ok(())
}
    /// `WinScreen.respawn` (`onFinished`) and `removed`: the credits music stops.
    // rust: pub(super) fn close_win_screen(&mut self) -> Result<()> {
    // rust: let Some(win) = self.win.take() else {
    // rust: return Ok(());
}
    // rust: let credits = horizon_client::music::Music::credits();
    // rust: self.music
    // rust: .stop_playing_music(&credits, None, &mut self.audio);
    // rust: match win.finish {
    // rust: Finish::Options => self.screen = Screen::Options,
    // rust: Finish::Closed if self.title.is_some() => self.screen = Screen::Playing,
    // rust: Finish::RemoteRespawn | Finish::Closed => {
    // rust: if win.finish == Finish::RemoteRespawn {
    // rust: self.remote_respawn();
}
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    // rust: Ok(())
}
}
