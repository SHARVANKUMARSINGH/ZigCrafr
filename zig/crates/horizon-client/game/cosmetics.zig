//! Transpiled from Horizon Rust crate
//! Module: horizon-client_cosmetics
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Cosmetics on players ([docs/cosmetics.md](../../../../docs/cosmetics.md)): only Horizon
//! clients draw them, off unless `horizon_cosmetics::enabled()`. What another player wears comes
//! from the cosmetics service by UUID (`horizon_cosmetics::Cosmetics`, its own thread); this file
//! puts the items on the avatar's bones, on the GPU skin path when the renderer takes it.
//!
//! Other players' cosmetics show by default only to an account that owns one (asked of the
//! service once a run, `OwnerCheck`): anyone else sees a vanilla game and the game asks nothing
//! about other players, until the player chooses otherwise in the settings.

    // rust: mod fx;

// use super::Game;
// use horizon_client::fast_hash::FxHashMap;
// use horizon_client::mesher::Vertex;
// use horizon_client::mobs::anim::Poses;
// use horizon_client::mobs::{Mob, Part, Polygon};
// use horizon_cosmetics::follow::Follow;
// use horizon_cosmetics::prefs::{self, Others};
// use horizon_cosmetics::trail::{Budget, Emitter};
// use horizon_cosmetics::{Item, Slot};
// use std::cell::{Cell, RefCell};
// use std::sync::Arc;
// use std::sync::mpsc::{Receiver, channel};
// use std::time::{Duration, Instant};

/// An item as the renderer takes it.
pub const Baked = struct {
    item: *Item,
    /// A model per bone it rides (a shirt's sleeves are on the arms).
    models: Vec<(horizon_cosmetics::Bone,
    /// Its texture's sprite (a 64×64 skin slot of the atlas).
    location: []const u8,
    /// The frame it was last marked drawn in (its slot is kept).
    marked: Cell<u32>,
};

    // rust: impl Baked {
pub fn new(item: **Item, frame: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: item: item.clone(),
    // rust: models: item
    // rust: .roots()
    // rust: .map(|(bone, root)| (bone, Arc::new(part(root))))
    // rust: .collect(),
    // rust: location: format!("cosmetics/{:x}", Arc::as_ptr(item) as usize),
    // rust: marked: Cell::new(frame.wrapping_sub(1)),
}
}
}

    // rust: pub(super) struct Cosmetics {
    // rust: client: Option<horizon_cosmetics::Cosmetics>,
    /// By the item's address; each entry holds its item, so the address isn't reused.
    // rust: baked: RefCell<FxHashMap<usize, Baked>>,
    /// Items drawn whose texture isn't in the atlas yet.
    // rust: uploads: RefCell<Vec<Arc<Item>>>,
    // rust: frame: Cell<u32>,
    /// Kept between players so a frame of avatars allocates none: the wearer's body, an item.
    // rust: poses: RefCell<(Poses, Poses)>,
    /// Item files from a folder (`HORIZON_COSMETICS_LOCAL`): mannequins wear them too.
    // rust: local: bool,
    /// Show my cosmetics on its way to the service.
    // rust: mine: AccountSync,
    /// Show me as a Horizon player: sent at start, on each change and every hour while on.
    // rust: listed: AccountSync,
    /// Whether the signed-in account owns a cosmetic.
    // rust: owner: OwnerCheck,
    /// Which other players play an emote (`horizon_cosmetics::Feed`), started with the client.
    // rust: feed: Option<horizon_cosmetics::Feed>,
    /// My emote on its way to the service.
    // rust: emote_out: EmoteOut,
    /// Companions, trails and auras.
    // rust: fx: RefCell<Fx>,
}

/// The emote the player plays, told to the service: the last wish sent (`Some(None)`: stopped),
/// the wish waiting, the request on its way, and the session kept for it.
pub const EmoteOut = struct {
    sent: ?Option<[]const u8>,
    /// When a looping emote is said again (`/v1/emote` keeps one a minute).
    again: ?Instant,
    sending: Option<Receiver<Result<(),
    retry: Option<(Instant,
    kept: *std::sync::Mutex<horizon_cosmetics::account::Kept>,
};

/// Tells the service the player plays `emote` (`None`: stopped).
    // rust: fn send_emote(
    // rust: kept: &std::sync::Mutex<horizon_cosmetics::account::Kept>,
    // rust: emote: Option<&str>,
    // rust: ) -> Result<(), String> {
    // rust: let Some(session) = horizon_client::auth::current() else {
    // rust: return Ok(());
}
    // rust: let mut kept = kept
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: horizon_cosmetics::account::play_emote(
    // rust: &mut kept,
    // rust: &http(),
    // rust: &session.name,
    // rust: |id| horizon_client::auth::join_server(&session, id).map_err(|e| format!("{e:?}")),
    // rust: emote,
    // rust: )
}

/// The emotes the signed-in account owns, for the wheel (none signed in: none).
    // rust: fn load_owned_emotes(
    // rust: kept: &std::sync::Mutex<horizon_cosmetics::account::Kept>,
    // rust: ) -> Result<Vec<horizon_cosmetics::account::OwnedEmote>, String> {
    // rust: let Some(session) = horizon_client::auth::current() else {
    // rust: return Ok(Vec::new());
}
    // rust: let service = http();
    // rust: let mut kept = kept
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: horizon_cosmetics::account::owned_emotes(
    // rust: &mut kept,
    // rust: &service,
    // rust: &session.name,
    // rust: |id| horizon_client::auth::join_server(&session, id).map_err(|e| format!("{e:?}")),
    // rust: |path| horizon_cosmetics::Transport::get(&service, path),
    // rust: )
}

/// The key of the player's own model in `Fx`'s maps (others go by entity id).
pub const OWN: u32 = u32::MAX;
/// Full light, for what glows.
pub const FULL_LIGHT: u32 = 240 | 240 << 8;

/// What companions and trails keep between frames, per wearer (marked with the frame they were
/// last drawn in; the others are dropped), and the frame's trails and auras, drawn after the
/// players (`cosmetics_fx_geometry`).
pub const Fx = struct {
    companions: FxHashMap<u32,
    trails: FxHashMap<u32,
    budget: Budget,
    clock: Option<(Instant,
    /// Ticks since the first frame, and the last frame's length in seconds.
    now: f64,
    dt: f32,
    /// Trails and auras: see-through.
    clear: std.ArrayList(Vertex),
};

    // rust: impl Fx {
    /// A new frame: the clock moves on and what no frame drew since the last one goes.
pub fn frame(self: *Self, frame: u32) void {
}
    // rust: let now = Instant::now();
    // rust: let (start, last) = self.clock.get_or_insert((now, now));
    // rust: self.dt = now.duration_since(*last).as_secs_f32().min(0.25);
    // rust: self.now = now.duration_since(*start).as_secs_f64() * 20.0;
    // rust: *last = now;
    // rust: let seen = |mark: u32| frame.wrapping_sub(mark) <= 1;
    // rust: self.companions.retain(|_, (_, mark)| seen(*mark));
    // rust: let budget = &mut self.budget;
    // rust: self.trails.retain(|_, (e, mark)| {
    // rust: let keep = seen(*mark);
    // rust: if !keep {
    // rust: e.clear(budget);
}
    // rust: keep
    // rust: });
    // rust: self.clear.clear();
}
}

/// Whether the signed-in account owns a cosmetic: the answer kept from the last run first
/// (`prefs::owned`), then the service's, asked once a run and retried after a failure like Show my
/// cosmetics. Not known yet, or no session: not owning.
pub const OwnerCheck = struct {
    started: bool,
    owns: bool,
    /// The service answered this run.
    known: bool,
    asking: Option<Receiver<Result<bool,
    retry: Option<(Instant,
};

/// The wait after another failure: 15 s, doubling to 10 minutes.
pub fn backoff(last: Option<(Instant) void {
}
    // rust: let wait = last.map_or(Duration::from_secs(15), |(_, w)| {
    // rust: (w * 2).min(Duration::from_secs(600))
    // rust: });
    // rust: Some((Instant::now() + wait, wait))
}

/// The signed-in account's UUID as the service writes it, and the game folder.
pub fn account() O;
    // rust: Arc<horizon_client::auth::AuthSession>,
    // rust: String,
    // rust: std::path::PathBuf,
    // rust: )> {
    // rust: let session = horizon_client::auth::current()?;
    // rust: let uuid = format!("{:032x}", session.uuid);
    // rust: Some((session, uuid, std::env::current_dir().ok()?))
}

/// Asks the service whether the signed-in account owns a cosmetic and keeps the answer in the
/// game folder. An offline account owns none and asks nothing.
pub fn check_owner() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((session, uuid, home)) = account() else {
    // rust: return Ok(false);
}
    // rust: let owns = horizon_cosmetics::account::owns(&http(), &session.name, |id| {
    // rust: horizon_client::auth::join_server(&session, id).map_err(|e| format!("{e:?}"))
    // rust: })?;
    // rust: if let Err(e) = prefs::set_owned(&home, &uuid, owns) {
    // rust: log::warn!("Cosmetics: the ownership answer is not saved: {e}");
}
    // rust: Ok(owns)
}

pub fn http() h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let api =
    // rust: std::env::var("HORIZON_COSMETICS_API").unwrap_or_else(|_| horizon_cosmetics::API.into());
    // rust: horizon_cosmetics::Http::new(&api, &format!("Horizon/{}", env!("CARGO_PKG_VERSION")))
}

/// Sending one of the account's switches: the wish it last looked at, the request on its way,
/// when to try again after a failure (15 s, doubling to 10 minutes), and when to say an unchanged
/// wish again.
pub const AccountSync = struct {
    wish: ?bool,
    sending: Option<Receiver<Result<(),
    retry: Option<(Instant,
    again: ?Instant,
};

    // rust: impl AccountSync {
    /// Takes the answer of the request on its way, if it came; `every`: how long a sent `true`
    /// stands before it is sent again.
pub fn settle(self: *Self, every: ?Duration) void {
}
    // rust: let Some(done) = self.sending.as_ref().and_then(|rx| rx.try_recv().ok()) else {
    // rust: return;
}
    // rust: self.sending = None;
    // rust: match done {
    // rust: Ok(()) => {
    // rust: self.retry = None;
    // rust: self.again = every
    // rust: .filter(|_| self.wish == Some(true))
    // rust: .map(|e| Instant::now() + e);
}
    // rust: Err(_) => self.retry = backoff(self.retry),
}
}

    /// Whether `wish` is to be sent now: it changed, a failure's wait is over, or `again` is due.
pub fn due(self: *Self, wish: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let timer = self.retry.map(|(at, _)| at).or(self.again);
    // rust: self.sending.is_none()
    // rust: && (self.wish != Some(wish) || timer.is_some_and(|at| Instant::now() >= at))
}

    /// Sends `wish` on a thread.
pub fn start(self: *Self, wish: bool, send: fn(bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.wish = Some(wish);
    // rust: self.again = None;
    // rust: let (tx, rx) = channel();
    // rust: self.sending = Some(rx);
    // rust: std::thread::Builder::new()
    // rust: .name("Cosmetics account".into())
    // rust: .spawn(move || {
    // rust: let _ = tx.send(send(wish));
    // rust: })
    // rust: .ok();
}
}

/// Tells the service whether the signed-in account may be shown as a Horizon player (listed: it
/// plays now). An offline account has nothing to send.
pub fn send_listed(listed: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(session) = horizon_client::auth::current() else {
    // rust: return Ok(());
}
    // rust: horizon_cosmetics::account::set_listed(
    // rust: &http(),
    // rust: &session.name,
    // rust: |id| horizon_client::auth::join_server(&session, id).map_err(|e| format!("{e:?}")),
    // rust: listed,
    // rust: )
    // rust: .map(|_| ())
}

/// Makes the service keep `wish` for the signed-in account, unless it already confirmed it
/// (`prefs::confirmed`, in the game folder). An offline account has nothing to send.
pub fn send_mine(wish: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((session, uuid, home)) = account() else {
    // rust: return Ok(());
}
    // rust: if prefs::confirmed(&home, &uuid).unwrap_or(true) == wish {
    // rust: return Ok(());
}
    // rust: let kept = horizon_cosmetics::account::set_visible(
    // rust: &http(),
    // rust: &session.name,
    // rust: |id| horizon_client::auth::join_server(&session, id).map_err(|e| format!("{e:?}")),
    // rust: wish,
    // rust: )?;
    // rust: prefs::set_confirmed(&home, &uuid, kept).map_err(|e| e.to_string())
}

    // rust: impl Cosmetics {
pub fn client() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(dir) = std::env::var_os("HORIZON_COSMETICS_LOCAL") {
    // rust: let local = horizon_cosmetics::Local::new(dir.into());
    // rust: return (horizon_cosmetics::Cosmetics::new(local, None), true);
}
    // rust: let api = std::env::var("HORIZON_COSMETICS_API")
    // rust: .unwrap_or_else(|_| horizon_cosmetics::API.to_owned());
    // rust: let agent = format!("Horizon/{}", env!("CARGO_PKG_VERSION"));
        // Beside the downloaded skins (`assets/skins` in the game folder).
    // rust: let cache = std::env::current_dir()
    // rust: .unwrap_or_default()
    // rust: .join("assets/cosmetics");
    // rust: let http = horizon_cosmetics::Http::new(&api, &agent);
    // rust: (horizon_cosmetics::Cosmetics::new(http, Some(cache)), false)
}
}

/// What the player whose UUID `uuid` gives wears, if the game shows it: the player's own model
/// (`own`) while Show my cosmetics is on, another player unless others' cosmetics are hidden (by
/// choice, or by owning none). Hidden, the service is never asked about them.
    // rust: fn worn_of(
    // rust: client: &horizon_cosmetics::Cosmetics,
    // rust: extras: &horizon_client::extras::Extras,
    // rust: own: bool,
    // rust: uuid: impl FnOnce() -> Option<u128>,
    // rust: ) -> Option<horizon_cosmetics::Worn> {
    // rust: let shown = if own {
    // rust: extras.cosmetics_mine
    // rust: } else {
    // rust: extras.effective_others() != Others::Hidden
}
    // rust: if !shown {
    // rust: return None;
}
    // rust: client.frame().worn(uuid()?)
}

/// The UUID the service knows the player's own model by. On a server, the profile it gave
/// (`profile`). In single player the window's own server (`solo`) names the player by their
/// offline profile, which the service doesn't know: the signed-in account's (`account`) then, only
/// with *Cosmetics in single player* on (`shown`); off, nothing is asked or drawn.
    // rust: fn own_uuid(
    // rust: profile: Option<u128>,
    // rust: solo: bool,
    // rust: shown: bool,
    // rust: account: impl FnOnce() -> Option<u128>,
    // rust: ) -> Option<u128> {
    // rust: match solo {
    // rust: false => profile,
    // rust: true if shown && profile.is_some() => account(),
    // rust: true => None,
}
}

/// How often a looping emote is said again (the service keeps one a minute).
pub const LOOP_AGAIN: Duration = Duration::from_secs(30);

/// The game's model of an item's part.
pub fn part(p: *horizon_cosmetics::Part) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Part {
    // rust: name: p.name.clone(),
    // rust: pose: p.pose,
    // rust: polygons: p
    // rust: .faces
    // rust: .iter()
    // rust: .map(|f| Polygon {
    // rust: normal: f.normal,
    // rust: vertices: f.vertices,
    // rust: cull_back: false,
    // rust: })
    // rust: .collect(),
    // rust: children: p.children.iter().map(part).collect(),
}
}

/// The texture in the top-left corner of a skin slot's 64×64 RGBA.
pub fn slot_image(item: *Item) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = &item.texture;
    // rust: let mut rgba = vec![0; 64 * 64 * 4];
    // rust: for y in 0..t.height as usize {
    // rust: let row = &t.rgba[y * t.width as usize * 4..(y + 1) * t.width as usize * 4];
    // rust: rgba[y * 64 * 4..y * 64 * 4 + row.len()].copy_from_slice(row);
}
    // rust: rgba
}

/// Which slots an avatar's gear covers: a helmet or head item hides a hat, an elytra or a cape
/// what is worn on the back. A name tag style is never drawn on the body.
pub fn covered(m: *Mob, slot: Slot) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match slot {
    // rust: Slot::Head => m.extra.head.is_some(),
    // rust: Slot::Back => m.cape.is_some() || m.extra.chest.as_deref() == Some("minecraft:elytra"),
    // rust: Slot::Shoulder => false,
        // A chestplate, not an elytra.
    // rust: Slot::Torso => m
    // rust: .extra
    // rust: .chest
    // rust: .as_deref()
    // rust: .is_some_and(|c| c != "minecraft:elytra"),
    // rust: Slot::NameTag | Slot::Emote => true,
        // On no bone: drawn by a pass of their own, never on the body.
    // rust: Slot::Companion | Slot::Trail | Slot::Aura => true,
}
}

/// How high the tallest item drawn on a body gets above the neck (pixels, `Item::top`): what
/// lifts the wearer's name tag. None when nothing is drawn on it: the wearer's own cosmetics hidden
/// (`worn` is None), another player's at "name tags only" or hidden, or every item `covered` (a
/// helmet over a hat). One max over at most five items, read when the item was parsed.
    // rust: fn body_top(
    // rust: extras: &horizon_client::extras::Extras,
    // rust: own: bool,
    // rust: worn: Option<&horizon_cosmetics::Worn>,
    // rust: covered: impl Fn(Slot) -> bool,
    // rust: ) -> Option<f32> {
    // rust: if !own && extras.effective_others() != Others::Shown {
    // rust: return None;
}
    // rust: worn?
    // rust: .iter()
    // rust: .filter(|i| !covered(i.slot))
    // rust: .map(|i| i.top)
    // rust: .reduce(f32::max)
}

    // rust: impl Game<'_> {
    /// Once a frame, before drawing: starts the service's client on first use and puts the
    /// textures the last frame wanted into the atlas.
    // rust: pub(super) fn cosmetics_frame(&mut self) {
    // rust: if !horizon_cosmetics::enabled() {
    // rust: return;
}
    // rust: let c = &mut self.cosmetics;
    // rust: if c.client.is_none() {
    // rust: let (client, local) = Cosmetics::client();
    // rust: c.client = Some(client);
    // rust: c.local = local;
            // Others' emotes come from the service only (a local folder has no one playing).
    // rust: if !local {
    // rust: c.feed = Some(horizon_cosmetics::Feed::new(http()));
}
}
    // rust: c.frame.set(c.frame.get().wrapping_add(1));
    // rust: c.fx.get_mut().frame(c.frame.get());
        // Item files from a folder (the art, the bench): shown as to an owner, nothing asked.
    // rust: if c.local {
    // rust: c.owner.owns = true;
    // rust: } else {
            // Whether the account owns a cosmetic: what the last run learnt, then the service.
    // rust: let o = &mut c.owner;
    // rust: if !o.started {
    // rust: o.started = true;
    // rust: o.owns = account()
    // rust: .is_some_and(|(_, uuid, home)| prefs::owned(&home, &uuid).unwrap_or(false));
}
    // rust: if let Some(done) = o.asking.as_ref().and_then(|rx| rx.try_recv().ok()) {
    // rust: o.asking = None;
    // rust: match done {
    // rust: Ok(owns) => (o.owns, o.known, o.retry) = (owns, true, None),
    // rust: Err(_) => o.retry = backoff(o.retry),
}
}
            // One sign-in at a time: Mojang keeps one joined server id per account.
    // rust: let due = !o.known && o.retry.is_none_or(|(at, _)| Instant::now() >= at);
    // rust: if due && o.asking.is_none() && c.mine.sending.is_none() && c.listed.sending.is_none() {
    // rust: let (tx, rx) = channel();
    // rust: o.asking = Some(rx);
    // rust: std::thread::Builder::new()
    // rust: .name("Cosmetics account".into())
    // rust: .spawn(move || {
    // rust: let _ = tx.send(check_owner());
    // rust: })
    // rust: .ok();
}
}
        // Read every frame: the settings button shows it, and it is never saved.
    // rust: self.settings.extras.cosmetics_owner = c.owner.owns;
        // Show my cosmetics: sent once per change of the wish, then retried until confirmed.
        // Show me as a Horizon player: also said again every hour while on.
    // rust: if !c.local {
    // rust: let every = horizon_cosmetics::account::PRESENCE_EVERY;
    // rust: c.mine.settle(None);
    // rust: c.listed.settle(Some(every));
            // One sign-in at a time, as for the ownership check above.
    // rust: let busy =
    // rust: c.owner.asking.is_some() || c.mine.sending.is_some() || c.listed.sending.is_some();
    // rust: let extras = &self.settings.extras;
    // rust: if let Some(done) = c
    // rust: .emote_out
    // rust: .sending
    // rust: .as_ref()
    // rust: .and_then(|rx| rx.try_recv().ok())
    // rust: {
    // rust: c.emote_out.sending = None;
    // rust: match done {
    // rust: Ok(()) => c.emote_out.retry = None,
    // rust: Err(_) => {
    // rust: c.emote_out.retry = backoff(c.emote_out.retry);
    // rust: c.emote_out.sent = None;
}
}
}
            // My emote: only while I show myself as a Horizon player (playing one says so).
    // rust: let playing = self.emotes.sending();
    // rust: let looping = playing.as_ref().is_some_and(|(_, looping)| *looping);
    // rust: let wish = playing.map(|(id, _)| id).filter(|_| extras.horizon_listed);
    // rust: let o = &mut c.emote_out;
    // rust: let changed = o.sent.as_ref() != Some(&wish);
    // rust: let again = looping && o.again.is_some_and(|at| Instant::now() >= at);
    // rust: let waited = o.retry.is_none_or(|(at, _)| Instant::now() >= at);
            // Nothing sent yet and nothing playing: nothing to say (a failed send forgets what
            // was sent: the service ends a one-shot by itself, a loop within a minute).
    // rust: let quiet = wish.is_none() && o.sent.is_none();
    // rust: let emote_due = !quiet && waited && (changed || again);
            // One sign-in at a time, the emote's included.
    // rust: if busy || o.sending.is_some() {
    // rust: } else if emote_due {
    // rust: o.sent = Some(wish.clone());
    // rust: o.again = looping.then(|| Instant::now() + LOOP_AGAIN);
    // rust: let (tx, rx) = channel();
    // rust: o.sending = Some(rx);
    // rust: let kept = o.kept.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("Cosmetics emote".into())
    // rust: .spawn(move || {
    // rust: let _ = tx.send(send_emote(&kept, wish.as_deref()));
    // rust: })
    // rust: .ok();
    // rust: } else if c.mine.due(extras.cosmetics_mine) {
    // rust: c.mine.start(extras.cosmetics_mine, send_mine);
    // rust: } else if c.listed.due(extras.horizon_listed) {
    // rust: c.listed.start(extras.horizon_listed, send_listed);
}
}
    // rust: let uploads = std::mem::take(&mut *c.uploads.borrow_mut());
    // rust: for item in uploads {
    // rust: let location = format!("cosmetics/{:x}", Arc::as_ptr(&item) as usize);
    // rust: if !self.gui.atlas.sprites.contains_key(&location) {
    // rust: self.store_skin(location, slot_image(&item));
}
}
        // Items no player wears any more.
    // rust: self.cosmetics
    // rust: .baked
    // rust: .borrow_mut()
    // rust: .retain(|_, b| Arc::strong_count(&b.item) > 1);
}

    /// Once a tick: names the Horizon players in view to the emote feed and plays what it says
    /// they play on their models; one that moved ends theirs here at once. Others' emotes show
    /// with "Other players' cosmetics" on Shown only; otherwise nothing is asked.
    // rust: pub(super) fn tick_others_emotes(&mut self) {
    // rust: let shown = self.settings.extras.effective_others() == Others::Shown;
        // Items from a folder (the art, the bench): every mannequin plays its first emote, again
        // and again.
    // rust: if self.cosmetics.local && shown {
    // rust: let Some(first) = self.owned_emotes().first().cloned() else {
    // rust: return;
}
    // rust: for m in self.mobs.iter_mut() {
    // rust: let age = m.age as f32;
    // rust: if &*m.kind.id == "minecraft:mannequin"
    // rust: && m.emote.as_ref().is_none_or(|p| p.at(age).is_none())
    // rust: {
    // rust: m.emote = Some(horizon_cosmetics::Playing {
    // rust: item: first.clone(),
                        // Out of step, so a crowd doesn't move as one.
    // rust: start: age - (m.id % 40) as f32,
    // rust: stop: None,
    // rust: });
}
}
    // rust: return;
}
    // rust: let (Some(feed), Some(client)) = (&self.cosmetics.feed, &self.cosmetics.client) else {
    // rust: return;
}
    // rust: if !shown {
    // rust: feed.ask([]);
    // rust: for m in self.mobs.iter_mut() {
    // rust: m.emote = None;
}
    // rust: return;
}
    // rust: let mut frame = client.frame();
    // rust: let mut horizon = Vec::new();
    // rust: for m in self.mobs.iter() {
    // rust: if &*m.kind.id == "minecraft:player"
    // rust: && let Some(uuid) = self.remote_player_uuid(m.id)
    // rust: && frame.horizon(uuid)
    // rust: {
    // rust: horizon.push((m.id, uuid));
}
}
    // rust: drop(frame);
    // rust: feed.ask(horizon.iter().map(|(_, u)| *u));
    // rust: let now = Instant::now();
    // rust: for (id, uuid) in horizon {
    // rust: let seen = feed.playing(uuid);
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: continue;
}
    // rust: let age = m.age as f32;
    // rust: let moved = {
    // rust: let (dx, dz) = (m.position.x - m.previous.x, m.position.z - m.previous.z);
    // rust: dx * dx + dz * dz > 1e-4
}
    // rust: match (seen, &mut m.emote) {
    // rust: (Some(seen), Some(p)) if Arc::ptr_eq(&p.item, &seen.item) => {
    // rust: if moved && p.stop.is_none() {
    // rust: p.stop = Some(age);
}
}
    // rust: (Some(seen), slot) if !moved => {
    // rust: let ticks = now.duration_since(seen.started).as_secs_f32() * 20.0;
    // rust: *slot = Some(horizon_cosmetics::Playing {
    // rust: item: seen.item,
    // rust: start: age - ticks,
    // rust: stop: None,
    // rust: });
}
    // rust: (_, Some(p)) if p.stop.is_none() => p.stop = Some(age),
    // rust: _ => {}
}
    // rust: if m.emote.as_ref().is_some_and(|p| p.at(age).is_none()) {
    // rust: m.emote = None;
}
}
}

    /// Asks the service which emotes the account owns, for the wheel: when it opens, at most
    /// every 10 minutes (a folder's emotes need no asking; an offline account has none).
    // rust: pub(super) fn refresh_owned_emotes(&mut self) {
pub const AGAIN: Duration = Duration::from_secs(600);
    // rust: let e = &mut self.emotes;
    // rust: if self.cosmetics.local
    // rust: || !horizon_cosmetics::enabled()
    // rust: || horizon_client::auth::current().is_none()
    // rust: || e.loading.is_some()
    // rust: || e.loaded.is_some_and(|at| at.elapsed() < AGAIN)
    // rust: {
    // rust: return;
}
    // rust: let (tx, rx) = channel();
    // rust: e.loading = Some(rx);
    // rust: let kept = self.cosmetics.emote_out.kept.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("Cosmetics emotes owned".into())
    // rust: .spawn(move || {
    // rust: let _ = tx.send(load_owned_emotes(&kept));
    // rust: })
    // rust: .ok();
}

    /// Items from a folder (`HORIZON_COSMETICS_LOCAL`): mannequins are dressed and marked too.
    // rust: pub(super) fn cosmetics_local(&self) -> bool {
    // rust: self.cosmetics.local
}

    /// What goes by `m`'s name: Horizon's mark if they play Horizon (and the mark is on), the
    /// name tag style they wear if cosmetics are shown for them (name tags only counts), and how
    /// high what is drawn on their body gets (`body_top`). One look in the cache for all three.
    // rust: pub(super) fn cosmetics_marks(&self, m: &Mob, own: bool) -> super::names::Marks {
    // rust: let mut marks = super::names::Marks::default();
    // rust: let extras = &self.settings.extras;
    // rust: let styles = if own {
    // rust: extras.cosmetics_mine
    // rust: } else {
    // rust: extras.effective_others() != Others::Hidden
}
    // rust: if !(styles || extras.horizon_marks) {
    // rust: return marks;
}
    // rust: let (Some(client), Some(uuid)) = (&self.cosmetics.client, self.cosmetics_uuid(m, own))
    // rust: else {
    // rust: return marks;
}
    // rust: let mut frame = client.frame();
    // rust: marks.horizon = extras.horizon_marks && frame.horizon(uuid);
    // rust: let worn = if styles { frame.worn(uuid) } else { None };
    // rust: drop(frame);
    // rust: if !horizon_client::mobs::trader::is_invisible(m) {
    // rust: marks.top = body_top(extras, own, worn.as_ref(), |slot| covered(m, slot));
}
    // rust: marks.style = worn.and_then(|w| self.cosmetics_tag(&w));
    // rust: marks
}

    /// Those of `uuids` who play Horizon, with the mark on (the player list): one look each.
    // rust: pub(super) fn horizon_players(
    // rust: &self,
    // rust: uuids: impl Iterator<Item = u128>,
    // rust: ) -> std::collections::HashSet<u128> {
    // rust: match &self.cosmetics.client {
    // rust: Some(c) if self.settings.extras.horizon_marks => {
    // rust: let mut frame = c.frame();
    // rust: uuids.filter(|u| frame.horizon(*u)).collect()
}
    // rust: _ => Default::default(),
}
}

    /// The name tag style in `worn`: its badge's place in the atlas and its line's colour. None
    /// until the badge is in the atlas.
pub fn cosmetics_tag(self: *Self, worn: *horizon_cosmetics::Worn) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let item = worn.iter().find(|i| i.slot == Slot::NameTag)?;
    // rust: let [r, g, b] = item.tag?.line;
    // rust: let frame = self.cosmetics.frame.get();
    // rust: let mut baked = self.cosmetics.baked.borrow_mut();
    // rust: let entry = baked
    // rust: .entry(Arc::as_ptr(item) as usize)
    // rust: .or_insert_with(|| Baked::new(item, frame));
    // rust: let Some(slot) = self.gui.atlas.sprites.get(&entry.location) else {
    // rust: self.cosmetics.uploads.borrow_mut().push(item.clone());
    // rust: return None;
}
    // rust: if entry.marked.replace(frame) != frame {
    // rust: self.skin_downloads.borrow_mut().drawn(&entry.location);
}
        // The mark sits in the slot's top left corner.
    // rust: let mut mark = *slot;
    // rust: mark.u1 = mark.u0 + (slot.u1 - slot.u0) * item.texture.width as f32 / 64.0;
    // rust: mark.v1 = mark.v0 + (slot.v1 - slot.v0) * item.texture.height as f32 / 64.0;
    // rust: Some(super::names::TagStyle {
    // rust: mark,
    // rust: line: u32::from_be_bytes([0, r, g, b]),
    // rust: })
}

    /// What `m` wears, if cosmetics are shown for it: `own` for the player's own model.
pub fn worn(self: *Self, m: *Mob, own: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let client = self.cosmetics.client.as_ref()?;
    // rust: worn_of(client, &self.settings.extras, own, || {
    // rust: self.cosmetics_uuid(m, own)
    // rust: })
}

    /// The UUID the service knows `m` by: a player's, or a mannequin's id with local items.
pub fn cosmetics_uuid(self: *Self, m: *Mob, own: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if own {
    // rust: own_uuid(
    // rust: self.remote.as_ref().map(|r| r.profile()),
    // rust: self.integrated.is_some(),
    // rust: self.settings.extras.cosmetics_solo,
    // rust: || horizon_client::auth::current().map(|s| s.uuid),
    // rust: )
    // rust: } else if &*m.kind.id == "minecraft:player" {
    // rust: self.remote_player_uuid(m.id)
    // rust: } else if self.cosmetics.local && &*m.kind.id == "minecraft:mannequin" {
    // rust: Some(u128::from(m.id))
    // rust: } else {
    // rust: None
}
}

    /// The cosmetics `m` wears, on its bones. `gpu`: posed on the GPU (the mob pass's skin
    /// frame, begun); the bounds of what went there come back, for culling. Else the vertices
    /// go to `out`. `camera`: where the world view's camera is; None in a picture of the player
    /// (the inventory), which shows no companion, trail or aura.
    // rust: pub(super) fn cosmetics_geometry(
    // rust: &self,
    // rust: m: &Mob,
    // rust: own: bool,
    // rust: base: glam::Mat4,
    // rust: camera: Option<glam::DVec3>,
    // rust: alpha: f32,
    // rust: light: u32,
    // rust: gpu: bool,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) -> Option<(glam::Vec3, glam::Vec3)> {
//         use horizon_client::mobs::{anim, render};
    // rust: let worn = self.worn(m, own);
        // An emote's props: its time and weight while it plays.
    // rust: let ticks = m.age as f32 + alpha;
    // rust: let emote = m.emote.as_ref().and_then(|p| {
    // rust: let (t, w) = p.at(ticks)?;
    // rust: (p.item.vertices > 0).then_some((&p.item, t, w))
    // rust: });
    // rust: if worn.is_none() && emote.is_none() || horizon_client::mobs::trader::is_invisible(m) {
    // rust: return None;
}
        // The avatar's body, posed as it is drawn.
    // rust: let (key, _) = render::body(m);
    // rust: let body = m.kind.layer(&key).unwrap_or(&m.kind.model);
    // rust: let mut scratch = self.cosmetics.poses.borrow_mut();
    // rust: let (body_poses, poses) = &mut *scratch;
    // rust: body_poses.reset(body);
    // rust: let data = self.res.mob_data();
    // rust: anim::setup(m, &anim::state(m, alpha), body_poses, &data.animations);
    // rust: let mut bounds = None;
        // Items on one bone (a back item, a shoulder pet and a shirt ride the body) share its
        // matrix: the head, the body and the two arms at most.
    // rust: let mut bones: [Option<(horizon_cosmetics::Bone, glam::Mat4)>; 4] = [None; 4];
        // "Name tags only": other players' styles beside their names, nothing on their bodies.
    // rust: let bodies = own || self.settings.extras.effective_others() == Others::Shown;
    // rust: let worn_items = worn.iter().flat_map(|w| w.iter()).map(|i| (i, None));
    // rust: let emote_items = emote.map(|(i, t, w)| (i, Some((t, w))));
    // rust: for (item, emoting) in worn_items.chain(emote_items) {
    // rust: if emoting.is_none() && !bodies {
    // rust: continue;
}
    // rust: if let (Some(camera), Slot::Companion | Slot::Trail | Slot::Aura) = (camera, item.slot)
    // rust: {
                // The player's own in first person: only its companion, drawn after the drain
                // of the first-person model (`cosmetics_fx_geometry`).
    // rust: if !(own && !self.own_body_in_view()) {
    // rust: let at = fx::Wearer {
    // rust: m,
    // rust: own,
    // rust: key: if own { OWN } else { m.id },
    // rust: base,
    // rust: camera,
    // rust: alpha,
    // rust: light,
}
    // rust: bounds = self.cosmetics_fx(&at, item, gpu, bounds, poses, out);
}
    // rust: continue;
}
    // rust: if emoting.is_none() && covered(m, item.slot) {
    // rust: continue;
}
    // rust: let Some((models, uv)) = self.cosmetics_baked(item) else {
    // rust: continue;
}
    // rust: for (bone_of, model) in &models {
    // rust: let known = bones.iter().flatten().find(|(b, _)| b == bone_of);
    // rust: let bone = match known {
    // rust: Some(&(_, matrix)) => matrix,
    // rust: None => {
    // rust: let Some(matrix) =
    // rust: render::part_matrix(body, base, body_poses, bone_of.part(), 0.0)
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(free) = bones.iter_mut().find(|b| b.is_none()) {
    // rust: *free = Some((*bone_of, matrix));
}
    // rust: matrix
}
}
    // rust: poses.reset(model);
    // rust: item.animate(ticks, |name, pose| *poses.get(name) = pose);
    // rust: if let (Some((t, w)), Some(e)) = (emoting, &item.emote) {
    // rust: e.pose_props(t, |n| item.rest(n), |n, pose| *poses.get(n) = pose);
                    // Props grow in and shrink out with the emote's blend.
    // rust: let root = poses.get(&model.name);
    // rust: for s in &mut root[6..9] {
    // rust: *s *= w;
}
}
    // rust: bounds = self.cosmetics_model(model, bone, poses, uv, light, gpu, bounds, out);
}
}
    // rust: bounds
}

    /// An item's models and its texture's corners in the atlas, once its texture is there (it is
    /// asked for meanwhile).
    // rust: fn cosmetics_baked(
    // rust: &self,
    // rust: item: &Arc<Item>,
    // rust: ) -> Option<(Vec<(horizon_cosmetics::Bone, Arc<Part>)>, [f32; 4])> {
    // rust: let frame = self.cosmetics.frame.get();
    // rust: let mut baked = self.cosmetics.baked.borrow_mut();
    // rust: let b = baked
    // rust: .entry(Arc::as_ptr(item) as usize)
    // rust: .or_insert_with(|| Baked::new(item, frame));
    // rust: let Some(rect) = self.gui.atlas.sprites.get(&b.location) else {
    // rust: self.cosmetics.uploads.borrow_mut().push(item.clone());
    // rust: return None;
}
    // rust: if b.marked.replace(frame) != frame {
    // rust: self.skin_downloads.borrow_mut().drawn(&b.location);
}
        // The texture fills the top-left of its 64×64 slot.
    // rust: let (w, h) = (
    // rust: item.texture.width as f32 / 64.0,
    // rust: item.texture.height as f32 / 64.0,
    // rust: );
    // rust: let uv = [
    // rust: rect.u0,
    // rust: rect.v0,
    // rust: rect.u0 + (rect.u1 - rect.u0) * w,
    // rust: rect.v0 + (rect.v1 - rect.v0) * h,
    // rust: ];
    // rust: Some((b.models.clone(), uv))
}

    /// One model at `matrix`, posed by `poses`: on the GPU's skin path when `gpu` (the bounds
    /// grow to hold it), else its vertices go to `out`.
    // rust: fn cosmetics_model(
    // rust: &self,
    // rust: model: &Arc<Part>,
    // rust: matrix: glam::Mat4,
    // rust: poses: &horizon_client::mobs::anim::Poses,
    // rust: uv: [f32; 4],
    // rust: light: u32,
    // rust: gpu: bool,
    // rust: bounds: Option<(glam::Vec3, glam::Vec3)>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) -> Option<(glam::Vec3, glam::Vec3)> {
    // rust: if gpu {
    // rust: let mut models = self.skin_models.borrow_mut();
    // rust: let mut frame = self.skin_frame.borrow_mut();
    // rust: let mut skin = horizon_client::mobs::skin::Skin::new(&mut models, &mut frame);
    // rust: skin.bounds = bounds;
    // rust: let paint = horizon_client::mobs::skin::Paint {
    // rust: uv,
    // rust: scroll: 0.0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,
    // rust: overlay: 0,
}
    // rust: if skin.draw(model, matrix, poses, paint) {
    // rust: return skin.bounds;
}
}
    // rust: horizon_client::mobs::render_model(
    // rust: model,
    // rust: matrix,
    // rust: &|p: &Part| poses.pose(p),
    // rust: uv,
    // rust: light,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: bounds
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::extras::Extras;
//     use std::sync::Mutex;

    /// A name tag style with a 1×1 mark.
    // rust: const TAG: &str = r##"{"format": 1, "id": "tag", "slot": "name_tag", "parts": [],
    // rust: "texture": {"png": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="},
    // rust: "tag": {"line": "#a98fff"}}"##;

    /// A crown whose star tops out 20 pixels above the neck: a 2-pixel box on a head item
    /// attached 18 pixels up (a 16×16 texture).
    // rust: const CROWN: &str = r##"{"format": 1, "id": "crown", "slot": "head", "bone": "head",
    // rust: "attach": {"offset": [0, -18, 0]},
    // rust: "texture": {"png": "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGklEQVR4nGM4scXmPyWYYdSAUQNGDRguBgAA+D23H0jXFFsAAAAASUVORK5CYII="},
    // rust: "parts": [{"name": "star", "cubes": [{"origin": [-1, -2, -1], "size": [2, 2, 2], "uv": [0, 0]}]}]}"##;

    /// The service: every player asked about wears its items (`TAG` by default); each request is
    /// logged.
pub const Service = struct {
    // rust: Arc<Mutex<Vec<String>>>,
    // rust: &'static [(&'static str, &'static str)],
    // rust: );

    // rust: impl Default for Service {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Service(Arc::default(), &[("tag", TAG)])
};
}

    // rust: impl horizon_cosmetics::Transport for Service {
pub fn post(self: *Self, path: []const u8, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body: serde_json::Value = serde_json::from_slice(body).unwrap();
    // rust: self.0.lock().unwrap().push(format!("POST {path} {body}"));
    // rust: let players: serde_json::Map<_, _> = body["players"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let p = p.as_str().unwrap().to_owned();
    // rust: let items: Vec<_> = (self.1.iter())
    // rust: .map(|(id, _)| serde_json::json!({"id": id, "hash": "h"}))
    // rust: .collect();
    // rust: (p, serde_json::Value::from(items))
    // rust: })
    // rust: .collect();
    // rust: Ok(serde_json::json!({"ttl": 60, "players": players})
    // rust: .to_string()
    // rust: .into_bytes())
}

pub fn get(self: *Self, path: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.lock().unwrap().push(format!("GET {path}"));
    // rust: let (_, file) = (self.1.iter())
    // rust: .find(|(id, _)| path.starts_with(&format!("/v1/items/{id}?")))
    // rust: .ok_or_else(|| format!("no item at {path}"))?;
    // rust: Ok(file.as_bytes().to_vec())
}
}

pub const OTHER: u128 = 0x1234;

    /// What another player wears as `extras` shows it, drawn frame after frame for up to
    /// `patience` (the service answers on its own thread), and what was asked of the service.
    // rust: fn other_player(
    // rust: extras: &Extras,
    // rust: patience: Duration,
    // rust: ) -> (Option<horizon_cosmetics::Worn>, Vec<String>) {
    // rust: other_player_from(Service::default(), extras, patience)
}

    // rust: fn other_player_from(
    // rust: service: Service,
    // rust: extras: &Extras,
    // rust: patience: Duration,
    // rust: ) -> (Option<horizon_cosmetics::Worn>, Vec<String>) {
    // rust: let client = horizon_cosmetics::Cosmetics::new(service.clone(), None);
    // rust: let deadline = Instant::now() + patience;
    // rust: let worn = loop {
    // rust: let worn = worn_of(&client, extras, false, || Some(OTHER));
    // rust: if worn.is_some() || Instant::now() >= deadline {
    // rust: break worn;
}
    // rust: std::thread::sleep(Duration::from_millis(20));
}
    // rust: let asked = service.0.lock().unwrap().clone();
    // rust: (worn, asked)
}

pub fn a_player_who_owns_none_sees_and_asks_nothing_until_they_choose() void {
}
//         use horizon_cosmetics::prefs::Others;
        // No line, owns nothing: a vanilla game, and no request about the other player.
    // rust: let (short, long) = (Duration::from_millis(300), Duration::from_secs(10));
    // rust: let (worn, asked) = other_player(&Extras::default(), short);
    // rust: assert!(worn.is_none());
    // rust: assert_eq!(asked, Vec::<String>::new());
        // The service says this account owns a cosmetic: the other player's style shows.
    // rust: let owner = Extras {
    // rust: cosmetics_owner: true,
    // rust: ..Extras::default()
}
    // rust: let (worn, asked) = other_player(&owner, long);
    // rust: assert_eq!(
    // rust: worn.map(|w| w.iter().map(|i| i.id.clone()).collect::<Vec<_>>()),
    // rust: Some(vec!["tag".to_owned()])
    // rust: );
    // rust: assert_eq!(
    // rust: asked[0],
    // rust: format!("POST /v1/worn {{\"players\":[\"{OTHER:032x}\"]}}")
    // rust: );
        // A choice wins over ownership both ways.
    // rust: let chose = Extras {
    // rust: cosmetics_others: Some(Others::Shown),
    // rust: ..Extras::default()
}
    // rust: assert!(other_player(&chose, long).0.is_some());
    // rust: let hid = Extras {
    // rust: cosmetics_others: Some(Others::Hidden),
    // rust: ..owner
}
    // rust: let (worn, asked) = other_player(&hid, short);
    // rust: assert!(worn.is_none() && asked.is_empty());
}

pub fn single_player_shows_my_cosmetics_only_with_its_setting_and_asks_by_my_account() void {
}
        // The window's own server names the player by their offline profile.
pub const OFFLINE: u128 = 0x0ff1;
pub const ACCOUNT: u128 = 0xacc0;
    // rust: let mine = |solo: bool, shown: bool, patience: Duration| {
    // rust: let service = Service::default();
    // rust: let client = horizon_cosmetics::Cosmetics::new(service.clone(), None);
    // rust: let extras = Extras {
    // rust: cosmetics_solo: shown,
    // rust: ..Extras::default()
}
    // rust: let uuid = || own_uuid(Some(OFFLINE), solo, extras.cosmetics_solo, || Some(ACCOUNT));
    // rust: let deadline = Instant::now() + patience;
    // rust: let worn = loop {
    // rust: let worn = worn_of(&client, &extras, true, uuid);
    // rust: if worn.is_some() || Instant::now() >= deadline {
    // rust: break worn;
}
    // rust: std::thread::sleep(Duration::from_millis(20));
}
    // rust: let asked = service.0.lock().unwrap().clone();
    // rust: (worn.is_some(), asked)
}
    // rust: let (short, long) = (Duration::from_millis(300), Duration::from_secs(10));
        // Off by default: nothing drawn, nothing asked.
    // rust: assert_eq!(mine(true, false, short), (false, vec![]));
        // On: asked by the signed-in account, never by the offline profile.
    // rust: let (shown, asked) = mine(true, true, long);
    // rust: assert!(shown);
    // rust: assert_eq!(
    // rust: asked[0],
    // rust: format!("POST /v1/worn {{\"players\":[\"{ACCOUNT:032x}\"]}}")
    // rust: );
        // On a server the setting changes nothing: the server's profile.
    // rust: let (shown, asked) = mine(false, false, long);
    // rust: assert!(shown);
    // rust: assert_eq!(
    // rust: asked[0],
    // rust: format!("POST /v1/worn {{\"players\":[\"{OFFLINE:032x}\"]}}")
    // rust: );
        // An offline account in single player: nothing to ask about.
    // rust: assert_eq!(own_uuid(Some(OFFLINE), true, true, || None), None);
}

pub fn a_tall_cosmetic_lifts_the_name_tag_only_while_it_is_drawn() void {
}
//         use super::super::names::{NAME_TAG_UNIT, cosmetic_lift};
//         use horizon_cosmetics::prefs::Others;
        // Vanilla: EntityAttachment.NAME_TAG of a standing player, 1.8 + 0.5 above the feet;
        // the tag's lowest pixel 10 text pixels under it.
pub const VANILLA: f64 = 2.3;
    // rust: let unit = f64::from(NAME_TAG_UNIT);
    // rust: let tag = |top: Option<f32>| VANILLA + top.map_or(0.0, |t| cosmetic_lift(t, 1.0));
        // The star's top: 20 pixels above the neck, which is 1.501 blocks up the model, scaled
        // by the avatar's 0.9375.
    // rust: let star = 0.9375 * (1.501 + 20.0 / 16.0);
    // rust: let both: &'static [(&str, &str)] = &[("tag", TAG), ("crown", CROWN)];
    // rust: let shown = Extras {
    // rust: cosmetics_others: Some(Others::Shown),
    // rust: ..Extras::default()
}
    // rust: let (short, long) = (Duration::from_millis(300), Duration::from_secs(10));
    // rust: let top_of = |extras: &Extras, patience| {
    // rust: let (worn, _) = other_player_from(Service(Arc::default(), both), extras, patience);
    // rust: body_top(extras, false, worn.as_ref(), |_| false)
}
        // No cosmetics drawn on the body (a name tag style only): vanilla's height exactly.
    // rust: let (worn, _) = other_player(&shown, long);
    // rust: assert!(worn.is_some());
    // rust: assert_eq!(
    // rust: tag(body_top(&shown, false, worn.as_ref(), |_| false)),
    // rust: VANILLA
    // rust: );
        // A small hat under the tag: vanilla's height too.
    // rust: assert_eq!(cosmetic_lift(10.0, 1.0), 0.0);
        // The crown: the whole tag just over the star.
    // rust: let crowned = tag(top_of(&shown, long));
    // rust: let bottom = crowned - 10.0 * unit;
    // rust: assert!(
    // rust: bottom > star && bottom < star + 2.0 * unit,
    // rust: "{bottom} over {star}"
    // rust: );
        // A helmet over it: vanilla's height.
    // rust: let (worn, _) = other_player_from(Service(Arc::default(), both), &shown, long);
    // rust: let helmet = body_top(&shown, false, worn.as_ref(), |slot| slot == Slot::Head);
    // rust: assert_eq!(tag(helmet), VANILLA);
        // Others' cosmetics on name tags only, or hidden: nothing on the body, vanilla's height.
    // rust: for others in [Others::NameTags, Others::Hidden] {
    // rust: let extras = Extras {
    // rust: cosmetics_others: Some(others),
    // rust: ..Extras::default()
}
    // rust: let patience = if others == Others::Hidden {
    // rust: short
    // rust: } else {
    // rust: long
}
    // rust: assert_eq!(tag(top_of(&extras, patience)), VANILLA, "{others:?}");
}
}
}
