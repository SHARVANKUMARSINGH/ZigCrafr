//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_viewer
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Wardrobe's live view, without the drawing: where the camera is, the clock items animate
//! by, an emote playing, and when the picture has to be drawn again. The launcher draws with
//! `preview::render` only when `Stage::frame` says so: never while nothing moves, and nothing
//! moves while the window is in the background.
//!
//! - **Animations** run on the game's clock (20 ticks a second), paused while the window is in
//!   the background or nothing animates, so they go on where they stopped.
//! - **At most 20 pictures a second** while something animates (`ANIMATION_FRAME`: one a game
//!   tick, the unit animations are written in), 60 while the player drags or scrolls
//!   (`MOVE_FRAME`); a change sooner than that waits for its turn.
//! - **Emotes** (`BodyMotion`): poses of the player model played once on the same clock; the
//!   items follow their bones as posed (`preview::Draw::item_posed`).

// use crate::Pose;
// use crate::preview::Camera;
// use std::sync::Arc;
// use std::time::{Duration, Instant};

/// The game's ticks, which item animations count in.
pub const TICKS_PER_SECOND: f32 = 20.0;
/// The shortest gap between two pictures while something animates: 20 a second, one a tick.
pub const ANIMATION_FRAME: Duration = Duration::from_millis(50);
/// The shortest gap between two pictures for a drag or a scroll: 60 a second.
pub const MOVE_FRAME: Duration = Duration::from_millis(16);

/// A body animation played once on the player model (an emote): the poses of its parts
/// (`head`, `body`, `right_arm`…, as `preview::player_model` names them) `ticks` after it
/// started. Parts it leaves out stay at rest.
    // rust: pub trait BodyMotion: Send + Sync {
    /// How long it plays, in ticks.
pub fn length(self: *Self) f;
    /// The parts' poses at `ticks` (0 to `length`).
pub fn pose(self: *Self, ticks: f32, set: *mut dyn FnMut([]const u8) void;
}

/// What to draw: the items' animation clock and, during an emote, the player model's poses.
pub const Shot = struct {
    camera: Camera,
    ticks: f32,
    body: Vec<([]const u8,
};

/// What `Stage::frame` asks of the view: draw `shot` now, and look again in `wake`.
pub const Frame = struct {
    shot: ?Shot,
    wake: ?Duration,
};

/// Everything the picture depends on; a picture is drawn again only when it changed.
pub const Key = struct {
    camera: Camera,
    outfit: u64,
    scale: f32,
    ticks: f32,
    emote: ?usize,
};

/// A clock that runs only while told to, keeping what it ran before.
pub const Clock = struct {
    banked: Duration,
    since: ?Instant,
};

    // rust: impl Clock {
pub fn at(self: *Self, now: Instant) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.banked
    // rust: + self
    // rust: .since
    // rust: .map_or(Duration::ZERO, |s| now.saturating_duration_since(s))
}

pub fn run(self: *Self, on: bool, now: Instant) void {
}
    // rust: match (on, self.since) {
    // rust: (true, None) => self.since = Some(now),
    // rust: (false, Some(_)) => {
    // rust: self.banked = self.at(now);
    // rust: self.since = None;
}
    // rust: _ => {}
}
}

pub fn ticks(self: *Self, now: Instant) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.at(now).as_secs_f32() * TICKS_PER_SECOND
}
}

/// The live view's state between pictures.
pub const Stage = struct {
    camera: ?Camera,
    /// Bumped by every new outfit.
    outfit: u64,
    /// Whether anything worn animates (and animations are wanted).
    animates: bool,
    clock: Clock,
    /// The emote playing, and the clock's ticks when it started.
    emote: ?(Arc<dyn BodyMotion,
    drawn: Option<(Key,
};

    // rust: impl Stage {
pub fn camera(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.camera.unwrap_or(Camera::HOME)
}

    /// Whether the camera is away from `Camera::HOME` (the reset button does something).
pub fn moved(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.camera() != Camera::HOME
}

pub fn set_camera(self: *Self, camera: Camera) void {
}
    // rust: self.camera = Some(camera);
}

    /// A new outfit to show; `animates` says whether any of it moves (false under reduced
    /// motion).
pub fn dress(self: *Self, animates: bool) void {
}
    // rust: self.outfit += 1;
    // rust: self.animates = animates;
}

    /// Plays `motion` once, from now.
pub fn play(self: *Self, motion: *dyn BodyMotion, now: Instant) void {
}
    // rust: self.emote = Some((motion, self.clock.ticks(now)));
}

    /// Whether an emote is playing.
pub fn playing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.emote.is_some()
}

    /// Called each time the view is drawn, at `now`, `scale` device pixels a point; `active` is
    /// whether the window is in front. Says whether to draw the picture again, and when to look
    /// again (never, while nothing moves).
pub fn frame(self: *Self, now: Instant, scale: f32, active: bool) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ticks = self.clock.ticks(now);
    // rust: if self
    // rust: .emote
    // rust: .as_ref()
    // rust: .is_some_and(|(m, from)| ticks - from >= m.length())
    // rust: {
    // rust: self.emote = None;
}
    // rust: let moving = active && (self.animates || self.emote.is_some());
    // rust: self.clock.run(moving, now);
    // rust: let key = Key {
    // rust: camera: self.camera(),
    // rust: outfit: self.outfit,
    // rust: scale,
    // rust: ticks,
    // rust: emote: self
    // rust: .emote
    // rust: .as_ref()
    // rust: .map(|(m, _)| Arc::as_ptr(m) as *const () as usize),
}
    // rust: let gap = if moving { ANIMATION_FRAME } else { MOVE_FRAME };
    // rust: match self.drawn {
    // rust: Some((drawn, _)) if drawn == key => Frame {
    // rust: shot: None,
    // rust: wake: moving.then_some(ANIMATION_FRAME),
    // rust: },
    // rust: Some((_, at)) if now.saturating_duration_since(at) < gap => Frame {
    // rust: shot: None,
    // rust: wake: Some(gap - now.saturating_duration_since(at)),
    // rust: },
    // rust: _ => {
    // rust: self.drawn = Some((key, now));
    // rust: let mut body = Vec::new();
    // rust: if let Some((m, from)) = &self.emote {
    // rust: m.pose((ticks - from).clamp(0.0, m.length()), &mut |name, pose| {
    // rust: body.push((name.to_owned(), pose))
    // rust: });
}
    // rust: Frame {
    // rust: shot: Some(Shot {
    // rust: camera: key.camera,
    // rust: ticks,
    // rust: body,
    // rust: }),
    // rust: wake: moving.then_some(ANIMATION_FRAME),
}
}
}
}
}

    // rust: mod tests {
//     use super::*;

pub const MS: Duration = Duration::from_millis(1);

    /// Calls `frame` every `every` for `span` from `start`; the pictures drawn.
    // rust: fn run(
    // rust: stage: &mut Stage,
    // rust: start: Instant,
    // rust: span: Duration,
    // rust: every: Duration,
    // rust: active: bool,
    // rust: ) -> usize {
    // rust: let mut drawn = 0;
    // rust: let mut t = Duration::ZERO;
    // rust: while t < span {
    // rust: drawn += usize::from(stage.frame(start + t, 2.0, active).shot.is_some());
    // rust: t += every;
}
    // rust: drawn
}

pub fn nothing_is_drawn_again_while_nothing_moves() void {
}
    // rust: let t0 = Instant::now();
    // rust: let mut stage = Stage::default();
    // rust: stage.dress(false);
    // rust: let first = stage.frame(t0, 2.0, true);
    // rust: assert!(first.shot.is_some());
    // rust: assert_eq!(first.wake, None);
        // A minute of frames (the page redrawn for other reasons, hovers…), focused or not:
        // nothing drawn, nothing asked for.
    // rust: for active in [true, false] {
    // rust: for k in 1..600 {
    // rust: let f = stage.frame(t0 + k * 100 * MS, 2.0, active);
    // rust: assert_eq!(f, Frame::default());
}
}
}

pub fn a_drag_draws_at_most_60_pictures_a_second() void {
}
    // rust: let t0 = Instant::now();
    // rust: let mut stage = Stage::default();
    // rust: stage.dress(false);
    // rust: stage.frame(t0, 2.0, true);
        // The pointer moves every 4 ms for a second, the view asked each time.
    // rust: let mut drawn = 0;
    // rust: let mut waits = Vec::new();
    // rust: for k in 1..=250 {
    // rust: let now = t0 + k * 4 * MS;
    // rust: stage.set_camera(stage.camera().dragged(1.0, 0.0));
    // rust: let f = stage.frame(now, 2.0, true);
    // rust: drawn += usize::from(f.shot.is_some());
    // rust: waits.extend(f.wake);
}
    // rust: assert!((55..=63).contains(&drawn), "{drawn}");
        // A change that waits says when its turn comes, never later than a frame.
    // rust: assert!(waits.iter().all(|w| *w <= MOVE_FRAME), "{waits:?}");
        // The drag's end is drawn when the wait is over, then nothing more.
    // rust: let end = t0 + 1000 * MS + MOVE_FRAME;
    // rust: assert!(stage.frame(end, 2.0, true).shot.is_some());
    // rust: assert_eq!(stage.frame(end + 500 * MS, 2.0, true), Frame::default());
}

pub fn animations_play_at_20_pictures_a_second_only_in_front() void {
}
    // rust: let t0 = Instant::now();
    // rust: let mut stage = Stage::default();
    // rust: stage.dress(true);
    // rust: let first = stage.frame(t0, 2.0, true);
    // rust: assert_eq!(first.wake, Some(ANIMATION_FRAME));
        // Asked as often as it wants for a second: about 20 pictures.
    // rust: let drawn = 1 + run(&mut stage, t0 + MS, Duration::from_secs(1), MS, true);
    // rust: assert!((19..=21).contains(&drawn), "{drawn}");
        // In the background: the frozen frame drawn at most once more, then nothing and no
        // timer, however long.
    // rust: let t1 = t0 + Duration::from_secs(1);
    // rust: let last = run(&mut stage, t1, 100 * MS, 10 * MS, false);
    // rust: assert!(last <= 1, "{last}");
    // rust: assert_eq!(stage.frame(t1 + 100 * MS, 2.0, false), Frame::default());
    // rust: assert_eq!(
    // rust: run(&mut stage, t1, Duration::from_secs(60), 100 * MS, false),
    // rust: 0
    // rust: );
        // Back in front an hour later, the animations go on where they stopped: the clock ran
        // one second (20 ticks), not an hour.
    // rust: let back = t1 + Duration::from_secs(3600);
    // rust: assert_eq!(stage.frame(back, 2.0, true).wake, Some(ANIMATION_FRAME));
    // rust: let shot = stage
    // rust: .frame(back + 60 * MS, 2.0, true)
    // rust: .shot
    // rust: .expect("drawn again in front");
    // rust: assert!((shot.ticks - 21.2).abs() < 0.1, "{}", shot.ticks);
    // rust: let later = stage.frame(back + 1060 * MS, 2.0, true).shot.unwrap();
    // rust: assert!(
    // rust: (later.ticks - shot.ticks - 20.0).abs() < 1e-3,
    // rust: "{}",
    // rust: later.ticks
    // rust: );
}

pub fn a_new_outfit_or_scale_is_drawn_once() void {
}
    // rust: let t0 = Instant::now();
    // rust: let mut stage = Stage::default();
    // rust: stage.dress(false);
    // rust: stage.frame(t0, 2.0, true);
    // rust: stage.dress(false);
    // rust: assert!(stage.frame(t0 + 100 * MS, 2.0, true).shot.is_some());
    // rust: assert!(stage.frame(t0 + 200 * MS, 1.0, true).shot.is_some());
    // rust: assert_eq!(stage.frame(t0 + 300 * MS, 1.0, true), Frame::default());
}

    /// Raises the right arm over 20 ticks.
pub const Wave = struct {};
    // rust: impl BodyMotion for Wave {
pub fn length(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 20.0
}
pub fn pose(self: *Self, ticks: f32, set: *mut dyn FnMut([]const u8) void {
}
    // rust: let x = -std::f32::consts::PI * ticks / 20.0;
    // rust: set("right_arm", [-5.0, 2.0, 0.0, x, 0.0, 0.0, 1.0, 1.0, 1.0]);
}
}

pub fn an_emote_plays_once_then_the_view_rests() void {
}
    // rust: let t0 = Instant::now();
    // rust: let mut stage = Stage::default();
    // rust: stage.dress(false);
    // rust: stage.frame(t0, 2.0, true);
    // rust: stage.play(Arc::new(Wave), t0);
    // rust: let start = stage.frame(t0 + 50 * MS, 2.0, true);
    // rust: let shot = start.shot.expect("drawn when it starts");
    // rust: assert_eq!(shot.body.len(), 1);
    // rust: assert_eq!(start.wake, Some(ANIMATION_FRAME));
        // Half a second in (10 ticks), the arm is half way up.
    // rust: let mid = stage.frame(t0 + 550 * MS, 2.0, true).shot.unwrap();
    // rust: let x = mid.body[0].1[3];
    // rust: assert!((x + std::f32::consts::FRAC_PI_2).abs() < 0.1, "{x}");
        // Over after a second: drawn once more at rest, then nothing.
    // rust: let end = stage.frame(t0 + 1100 * MS, 2.0, true);
    // rust: assert!(end.shot.as_ref().is_some_and(|s| s.body.is_empty()));
    // rust: assert_eq!(end.wake, None);
    // rust: assert!(!stage.playing());
    // rust: assert_eq!(stage.frame(t0 + 2000 * MS, 2.0, true), Frame::default());
}

pub fn an_emote_waits_while_the_window_is_in_the_background() void {
}
    // rust: let t0 = Instant::now();
    // rust: let mut stage = Stage::default();
    // rust: stage.dress(false);
    // rust: stage.play(Arc::new(Wave), t0);
    // rust: stage.frame(t0, 2.0, true);
    // rust: stage.frame(t0 + 250 * MS, 2.0, false);
    // rust: assert_eq!(stage.frame(t0 + 10_000 * MS, 2.0, false), Frame::default());
    // rust: assert!(stage.playing());
        // Back in front, it goes on from five ticks in.
    // rust: stage.frame(t0 + 20_000 * MS, 2.0, true);
    // rust: let back = stage.frame(t0 + 20_060 * MS, 2.0, true).shot.unwrap();
    // rust: assert!((back.ticks - 6.2).abs() < 0.1, "{}", back.ticks);
}

pub fn the_camera_starts_home_and_says_when_it_moved() void {
}
    // rust: let mut stage = Stage::default();
    // rust: assert_eq!(stage.camera(), Camera::HOME);
    // rust: assert!(!stage.moved());
    // rust: stage.set_camera(stage.camera().zoomed(1.0));
    // rust: assert!(stage.moved());
    // rust: stage.set_camera(Camera::HOME);
    // rust: assert!(!stage.moved());
}
}
