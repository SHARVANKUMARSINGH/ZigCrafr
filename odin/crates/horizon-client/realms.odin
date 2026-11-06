//! Transpiled from Horizon Rust crate
package horizon_client_realms

import "core:fmt"
import "core:mem"
import "core:math"

// Minecraft Realms screens: `RealmsMainScreen` with its `RealmsHeader`, the join-code and
// pending-invite screens, the owner's open/close, `RealmsPopups.infoPopupScreen` for the
// questions, and `GetServerDetailsTask` under `RealmsLongRunningMcoTaskScreen` for Play.
// Layout from the vanilla screens' behaviour and the game's own sprites.
//
// Realms is used only with the signed-in player's own Microsoft account: the session the
// launcher hands over after its owner check (`auth::current`). Without one (offline play, an
// expired token) the screen says so and makes no request. Every request runs on a worker
// thread; the title polls the results once a frame (`poll`).
    // rust: pub mod client;

// use crate::hud::{HudAtlas, HudBatch, rgba};
// use crate::text::Text;
// use client::{
    // rust: PendingInviteDto, PlayerInfo, RealmAddress, RealmServer, RealmSlot, RealmTierConfiguration,
    // rust: RealmTierRange, RealmWorldOptions, RealmsClient, RealmsError, RegionDataDto,
    // rust: RegionSelectionPreferenceDto, Subscription,
}
// use horizon_client_render::auth::{self, AuthSession};
// use std::sync::atomic::{AtomicBool, Ordering};
// use std::sync::{Arc, Mutex};
// use std::thread;
// use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

HEADER_HEIGHT :: 44.0
CONTENT_WIDTH :: 308.0
// `RealmsPdpScreen`'s list: the row width and the text's width beside the picture.
PDP_ROW_WIDTH :: 290.0
PDP_TEXT_WIDTH :: 182.0

ROW_WIDTH :: 300.0
ROW_HEIGHT :: 36.0
// `RealmsConfigureWorldScreen`'s `MenuTabBar` height (`gui/tab_header_background`).
TAB_HEIGHT :: 24.0
// `hud::rgba` packing (ABGR): 160 grey, vanilla's red and `RealmsPopups.COLOR_INFO`.
GREY :: 0xFFA0_A0A0
RED :: 0xFF55_55FF
INFO :: 0xFFBE_887D

REALMS_INVITE_CODE :: ("realms.invite_code", 0)
REALMS_PLAYER_NAME :: ("realms.player_name", 0)
REALMS_SLOT_NAME :: ("realms.slot_name", 0)
REALMS_SETTINGS_NAME :: ("realms.settings_name", 0)
REALMS_SETTINGS_DESC :: ("realms.settings_desc", 0)

// `RealmsSlotOptionsScreen.DIFFICULTIES` and `GAME_MODES`, in menu order (the index
// is what the service stores).
    // rust: const DIFFICULTIES: [&str; 4] = [
    // rust: "options.difficulty.peaceful",
    // rust: "options.difficulty.easy",
    // rust: "options.difficulty.normal",
    // rust: "options.difficulty.hard",
    // rust: ];
    // rust: const GAME_MODES: [&str; 3] = [
    // rust: "selectWorld.gameMode.survival",
    // rust: "selectWorld.gameMode.creative",
    // rust: "selectWorld.gameMode.adventure",
    // rust: ];
DIFFICULTY_DEFAULT :: 2
GAME_MODE_DEFAULT :: 0

// `CommonLinks.BUY_REALMS`.
BUY_REALMS :: "https://aka.ms/BuyJavaRealms"
// `CommonLinks.EXTEND_REALMS_LINK`.
EXTEND_REALMS :: "https://aka.ms/ExtendJavaRealms"

// What a worker thread hands back.
    // rust: type Job<T> = Arc<Mutex<Option<T>>>;

    // rust: fn spawn<T: Send + 'static>(work: impl FnOnce() -> T + Send + 'static) -> Job<T> {
    // rust: let job = Arc::new(Mutex::new(None));
    // rust: let out = Arc::clone(&job);
    // rust: let started = thread::Builder::new().name("Realms".into()).spawn(move || {
    // rust: let result = work();
    // rust: if let Ok(mut slot) = out.lock() {
    // rust: *slot = Some(result);
}
    // rust: });
    // rust: if let Err(e) = started {
    // rust: log::warn!("Horizon: could not start a Realms worker: {e}");
}
    // rust: job
}

    // rust: fn take<T>(job: &Job<T>) -> Option<T> {
    // rust: job.lock().ok()?.take()
}

// The account Realms may use: the launcher's Microsoft session (it hands one over only for
// an account that owns the game) while its token is good.
session :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: auth::current().filter(|s| !s.expired())
}

client :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: session().map(|s| RealmsClient::production(&s))
}

// The address `/join/pc` gave, checked before it becomes `Action::Connect`: a host name,
// IPv4 or `[IPv6]` host, then `:` and a port number. A scheme, a path, credentials or a
// missing port are refused.
connect_address :: proc(address: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let address = address.trim();
    // rust: let (host, port, host_ok): (&str, &str, fn(u8) -> bool) =
    // rust: if let Some(rest) = address.strip_prefix('[') {
    // rust: let (host, port) = rest.split_once("]:")?;
    // rust: (host, port, |b| {
    // rust: b.is_ascii_hexdigit() || b == b':' || b == b'.'
    // rust: })
    // rust: } else {
    // rust: let (host, port) = address.rsplit_once(':')?;
    // rust: (host, port, |b| {
    // rust: b.is_ascii_alphanumeric() || b == b'-' || b == b'.' || b == b'_'
    // rust: })
}
    // rust: if host.is_empty() || !host.bytes().all(host_ok) {
    // rust: return None;
}
    // rust: if port.is_empty() || !port.bytes().all(|b| b.is_ascii_digit()) {
    // rust: return None;
}
    // rust: let port: u16 = port.parse().ok()?;
    // rust: (port != 0).then(|| address.to_owned())
}

// The world's resource pack the player agreed to download before joining
// (`GetServerDetailsTask.scheduleResourcePackDownload`): the next connection to `address`
// takes it as an allowed server pack.
RealmsPack :: struct {
    address: string,
    id: u128,
    url: string,
    hash: string,
}

PENDING_PACK :: Mutex::new(None)

// The pack for the connection to `address`, if the Realms screen asked for one.
take_pending_pack :: proc(address: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pack = PENDING_PACK.lock().ok()?.take()?;
    // rust: (pack.address == address).then_some(pack)
}

// `UUID.nameUUIDFromBytes`.
name_uuid :: proc(bytes: []u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = horizon_protocol::crypto::md5(bytes);
    // rust: h[6] = (h[6] & 0x0f) | 0x30;
    // rust: h[8] = (h[8] & 0x3f) | 0x80;
    // rust: u128::from_be_bytes(h)
}

// `GetServerDetailsTask.generatePackId`.
pack_id :: proc(server: ^RealmServer) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match &server.minigame_name {
    // rust: Some(minigame) => name_uuid(format!("minigame:{minigame}").as_bytes()),
    // rust: None => name_uuid(format!("realms:{}:{}", server.name, server.active_slot).as_bytes()),
}
}

// `CommonLinks.extendRealms`.
extend_link :: proc(server: ^RealmServer, profile: u128) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match &server.remote_subscription_id {
    // rust: None => EXTEND_REALMS.to_owned(),
    // rust: Some(sub) => {
    // rust: let reference = if server.expired_trial {
    // rust: "expiredTrial"
    // rust: } else {
    // rust: "expiredRealm"
}
    // rust: format!("{EXTEND_REALMS}?subscriptionId={sub}&profileId={profile:032x}&ref={reference}")
}
}
}

// `RealmsSettingsTab`'s fields: the name, the description and the region preference,
// as the player is editing them.
SettingsDraft :: struct {
    name: string,
    description: string,
    // `RegionSelectionPreference`'s id: [`client::AUTOMATIC_PLAYER`],
    // [`client::AUTOMATIC_OWNER`] or [`client::MANUAL`].
    preference: i32,
    // The `RealmsRegion`'s `nameId`, while `preference` is `MANUAL`.
    region: Maybe(string),
    // The field with the caret: the name (false) or the description (true).
    on_description: bool,
    // The picked distances, once the tier configuration arrived
    // (`RealmsSettingsTab`'s two `OptionInstance`s; none while it hasn't).
    render_distance: Maybe(i32),
    simulation_distance: Maybe(i32),
}

    // rust: impl SettingsDraft {
    // The draft the tab opens with (`RealmsSettingsTab.updateData`): a Realm without a
    // preference has `RegionSelectionPreferenceDto.DEFAULT`, automatic by owner.
of :: proc(server: ^RealmServer) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (preference, region) = server.region_selection_preference.as_ref().map_or(
    // rust: (client::AUTOMATIC_OWNER, None),
    // rust: |p| {
    // rust: (
    // rust: p.region_selection_preference,
    // rust: p.preferred_region.clone().filter(|r| !r.is_empty()),
    // rust: )
    // rust: },
    // rust: );
    // rust: Self {
    // rust: name: server.name.clone(),
    // rust: description: server.motd.clone(),
    // rust: preference,
    // rust: region,
    // rust: on_description: false,
    // rust: render_distance: None,
    // rust: simulation_distance: None,
}
}
    // The preference as `RegionSelectionPreferenceDto`: the region only for `MANUAL`.
preference_dto :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: RegionSelectionPreferenceDto {
    // rust: region_selection_preference: self.preference,
    // rust: preferred_region: self
    // rust: .region
    // rust: .clone()
    // rust: .filter(|_| self.preference == client::MANUAL),
}
}
}

// `RealmsSettingsTab.save`'s `updatedRenderDistance`/`updatedSimulationDistance`: a distance
// is sent only when the player changed it and the tier answer lets the service configure it.
changed_distance :: proc(picked: Maybe(i32), range: Maybe(^RealmTierRange)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: picked.filter(|picked| range.is_some_and(|range| *picked != range.current_or_default()))
}

// `RealmsSettingsTab.getTranslatableFromPreference`: a manual choice shows its region,
// the automatic ones their own name.
preference_label :: proc(preference: i32, region: Maybe(string)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let t = crate::lang::get;
    // rust: match (preference, region) {
    // rust: (client::MANUAL, Some(region)) => {
    // rust: client::region_translation_key(region).map_or_else(|| region.to_owned(), t)
}
    // rust: (client::AUTOMATIC_PLAYER, _) => {
    // rust: t("realms.configuration.region_preference.automatic_player")
}
    // rust: _ => t("realms.configuration.region_preference.automatic_owner"),
}
}

// `RealmsPreferredRegionSelectionScreen.RegionSelectionList`'s rows: automatic by player,
// automatic by owner, then every region as a manual choice.
region_rows :: proc(regions: ^[RegionDataDto]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: (client::AUTOMATIC_PLAYER, None),
    // rust: (client::AUTOMATIC_OWNER, None),
    // rust: ]
    // rust: .into_iter()
    // rust: .chain(
    // rust: regions
    // rust: .iter()
    // rust: .map(|r| (client::MANUAL, Some(r.region.clone()))),
    // rust: )
    // rust: .collect()
}

// `RealmsConfigureWorldScreen`'s tabs, in `MenuTabBar` order.
ConfigureTab :: enum {
    Worlds,
    Players,
    Subscription,
    Settings,
}

    // rust: impl ConfigureTab {
    // The tabs in `MenuTabBar` order, which is also their index.
    // rust: const ALL: [Self; 4] = [
    // rust: Self::Worlds,
    // rust: Self::Players,
    // rust: Self::Subscription,
    // rust: Self::Settings,
    // rust: ];
    // `RealmsWorldsTab.TITLE` and the other tabs' own titles.
title :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Worlds => "mco.configure.worlds.title",
    // rust: Self::Players => "mco.configure.world.players.title",
    // rust: Self::Subscription => "mco.configure.world.subscription.tab",
    // rust: Self::Settings => "mco.configure.world.settings.title",
}
}
    // `RealmsConfigureWorldScreen.init`'s `setTabActiveState(3, !serverData.expired)`: an
    // expired Realm's settings tab is off (with the expired tooltip).
enabled :: proc(self: ^Self, expired: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self != Self::Settings || !expired
}
}

// The tab bar's geometry over `MenuTabBar.builder(this, width)`: the bar is at most 400
// wide, centred, and each of the four tabs is an eighth of its inner width rounded up to an
// even number (`Java`'s integer division before the rounding).
tab_geometry :: proc(w: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let width = w.min(400.0) - 28.0;
    // rust: let x = (((w - width) / 2.0).floor() / 2.0).ceil() * 2.0;
    // rust: let tab = ((width / 4.0).floor() / 2.0).ceil() * 2.0;
    // rust: (x, tab)
}

// `RealmsWorldsTab`'s four slot buttons: the active slot is 80 square, the others 50,
// spaced 16 and centred (`GridLayout.spacing(16)`).
slot_boxes :: proc(w: f32, active_slot: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let sizes: [f32; 4] = std::array::from_fn(|i| {
    // rust: if i as i32 + 1 == active_slot {
    // rust: 80.0
    // rust: } else {
    // rust: 50.0
}
    // rust: });
    // rust: let total: f32 = sizes.iter().sum::<f32>() + 16.0 * 3.0;
    // rust: let mut x = ((w - total) / 2.0).floor();
    // rust: std::array::from_fn(|i| {
    // rust: let at = (x, sizes[i], i as i32 + 1);
    // rust: x += sizes[i] + 16.0;
    // rust: at
    // rust: })
}

// `RealmsWorldOptions.getSlotName`: the player's own name, else the empty marker, else
// "World N" by the slot's number.
slot_name :: proc(options: ^RealmWorldOptions, slot: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if !options.slot_name.trim().is_empty() {
    // rust: return options.slot_name.clone();
}
    // rust: if options.empty {
    // rust: return crate::lang::get("mco.configure.world.slot.empty");
}
    // rust: crate::lang::tr("mco.configure.world.slot", &[&slot])
}

// `RealmsSubscriptionTab.daysLeftPresentation`: what the days-left line says, in the
// caller's language; empty when nothing is left to say.
days_left_text :: proc(days_left: i32, expired: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let t = crate::lang::get;
    // rust: if days_left < 0 && expired {
    // rust: return t("mco.configure.world.subscription.expired");
}
    // rust: if days_left <= 1 {
    // rust: return t("mco.configure.world.subscription.less_than_a_day");
}
    // rust: let (months, days) = (days_left / 30, days_left % 30);
    // rust: match (months > 0, days > 0) {
    // rust: (true, true) => crate::lang::tr(
    // rust: "mco.configure.world.subscription.remaining.months.days",
    // rust: &[&months, &days],
    // rust: ),
    // rust: (true, false) => crate::lang::tr(
    // rust: "mco.configure.world.subscription.remaining.months",
    // rust: &[&months],
    // rust: ),
    // rust: (false, true) => {
    // rust: crate::lang::tr("mco.configure.world.subscription.remaining.days", &[&days])
}
    // rust: (false, false) => String::new(),
}
}

// `RealmsSubscriptionTab.localPresentation`: the start date in the player's own local
// time. The process has no locale to format with, so the shape is fixed (`%Y-%m-%d`)
// where vanilla asks for the locale's medium date.
start_date_text :: proc(epoch_millis: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(time) = chrono::DateTime::from_timestamp_millis(epoch_millis) else {
    // rust: return String::new();
}
    // rust: time.with_timezone(&chrono::Local)
    // rust: .format("%Y-%m-%d")
    // rust: .to_string()
}

LayoutState :: enum {
    Loading,
    NoRealms,
    List,
}

FetchState :: enum {
    // No Microsoft session: nothing is asked of the service.
    Unauthenticated,
    Loading(Job<Result<Vec<RealmServer>, RealmsError>>),
    Loaded(Vec<RealmServer>),
    Error(RealmsError),
}

// A `RealmsPopups.infoPopupScreen`: Continue or Cancel.
Popup :: enum {
    // `RealmsMainScreen.leaveClicked`.
    Leave(RealmServer),
    // `GetServerDetailsTask.resourcePackDownloadConfirmationScreen`.
    ResourcePack { pack: RealmsPack },
    // `RealmsSubscriptionTab`'s delete question (only offered once the Realm has expired).
    Delete(RealmServer),
    // `RealmsPlayersTab.PlayerEntry.uninvite`'s confirm (`RealmsConfirmScreen`).
    Uninvite {,
    server: RealmServer,
    player: PlayerInfo,
    // rust: },
    // `RealmsWorldsTab.switchToFullSlot`'s question, then `RealmsClient.switchSlot`.
    SwitchSlot { server: RealmServer, slot: i32 },
}

SubScreen :: enum {
    Main,
    JoinCode {,
    code: String,
    error: Option<String>,
    job: Option<Job<Result<(), RealmsError>>>,
    // rust: },
    PendingInvites {,
    invites: Option<Result<Vec<PendingInviteDto>, RealmsError>>,
    job: Option<Job<Result<Vec<PendingInviteDto>, RealmsError>>>,
    // rust: },
    Configure {,
    server: RealmServer,
    tab: ConfigureTab,
        // `RealmsClient.subscriptionFor` on a worker, then its answer (the subscription tab).
    subscription: Option<Result<Subscription, RealmsError>>,
    subscription_job: Option<Job<Result<Subscription, RealmsError>>>,
        // `RealmsClient.getOwnRealm` on a worker, then its answer (the slots and players).
    detail: Option<Result<RealmServer, RealmsError>>,
    detail_job: Option<Job<Result<RealmServer, RealmsError>>>,
        // `RealmsClient.deleteRealm` on a worker, from the subscription tab's question.
    deleting: Option<Job<Result<(), RealmsError>>>,
        // `RealmsClient.op`/`deop`/`uninvite` on a worker, from the players tab.
    member_job: Option<Job<Result<(), RealmsError>>>,
        // The settings tab's editable fields, once the tab has been opened.
    settings: Option<SettingsDraft>,
        // `RealmsClient.getRealmTierConfiguration`, then its answer: the settings tab's
        // distance sliders (`tierConfigurationFetched` keeps it to one fetch).
    tier: Option<Result<RealmTierConfiguration, RealmsError>>,
    tier_job: Option<Job<Result<RealmTierConfiguration, RealmsError>>>,
        // `RealmsClient.preferredRegions` for the region preference screen.
    regions: Option<Result<Vec<RegionDataDto>, RealmsError>>,
    regions_job: Option<Job<Result<Vec<RegionDataDto>, RealmsError>>>,
        // `RealmsClient.updateConfiguration` on a worker.
    saving: Option<Job<Result<(), RealmsError>>>,
    error: Option<String>,
        // `RealmsClient.open`/`close` on a worker.
    job: Option<Job<Result<(), RealmsError>>>,
    // rust: },
    // `RealmsSlotOptionsScreen`: the active slot's name and world options.
    SlotOptions {,
    server: RealmServer,
    slot: RealmSlot,
    name: String,
    difficulty: usize,
    game_mode: usize,
    force_game_mode: bool,
    spawn_protection: i32,
        // `RealmsClient.updateSlot` on a worker.
    job: Option<Job<Result<(), RealmsError>>>,
    error: Option<String>,
    // rust: },
    // `RealmsPreferredRegionSelectionScreen`: the region preference list.
    RegionPreference {,
    server: RealmServer,
        // The settings tab's draft, which Done writes the choice back to.
    settings: SettingsDraft,
    regions: Vec<RegionDataDto>,
        // The highlighted row: `(preference, region)`.
    selected: Option<(i32, Option<String>)>,
    // rust: },
    // `RealmsInviteScreen`: a name to invite to the Realm.
    Invite {,
    server: RealmServer,
        // The invited players as the tab had them (the duplicate check).
    players: Vec<PlayerInfo>,
    name: String,
        // `RealmsClient.invite` on a worker, then the players.
    job: Option<Job<Result<Vec<PlayerInfo>, RealmsError>>>,
    error: Option<String>,
    // rust: },
    // `RealmsPdpScreen`: the product page behind Add Realm, its picture rows and scroll.
    AddRealm {,
    scroll: crate::ui::Scroll,
        // The list's drawn height, measured in [`Screen::draw`] and read by the wheel.
    content: std::cell::Cell<f32>,
    // rust: },
    Popup(Popup),
    // `RealmsLongRunningMcoTaskScreen` running `GetServerDetailsTask`: the join request is on
    // a worker (`joining`); an error stays on screen with a Back button.
    Connecting {,
    server: RealmServer,
    error: Option<String>,
    // rust: },
}

// The join request on its worker, and its abort flag (`LongRunningTask.aborted`).
    // rust: type Joining = (Job<Result<RealmAddress, RealmsError>>, Arc<AtomicBool>);

Screen :: struct {
    state: FetchState,
    subscreen: SubScreen,
    selected: Maybe(uint),
    joining: Maybe(Joining),
    // Leaving a Realm (`RealmsMainScreen.leaveServer`): the list reloads when it's done.
    leaving: Option<Job<Result<(),
    last_click: Option<(uint,
}

Outcome :: enum {
    None,
    Back,
    Connect(String),
    OpenUri(String),
}

    // rust: impl Default for Screen {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}

// `GetServerDetailsTask.fetchServerAddress`: up to 40 tries, waiting `Retry-After` between
// them; an abort stops it.
    // rust: fn fetch_address(
    // rust: client: &RealmsClient,
    // rust: realm_id: i64,
    // rust: aborted: &AtomicBool,
    // rust: ) -> Result<RealmAddress, RealmsError> {
    // rust: for _ in 0..40 {
    // rust: if aborted.load(Ordering::Relaxed) {
    // rust: return Err(RealmsError::Timeout);
}
    // rust: match client.join_world(realm_id) {
    // rust: Err(RealmsError::Retry(seconds)) => {
    // rust: let until = Instant::now() + Duration::from_secs(seconds.min(60));
    // rust: while Instant::now() < until && !aborted.load(Ordering::Relaxed) {
    // rust: thread::sleep(Duration::from_millis(100));
}
}
    // rust: other => return other,
}
}
    // rust: Err(RealmsError::Timeout)
}

// `RealmsPdpScreen`'s list: the trial header (no picture) and the three features, each
// with its 80x45 picture and the text beside it. The header has no subtitle: Horizon does
// not ask `trialAvailabilityTask`, and vanilla shows the trial description only when a
// trial is available (its footer then offers the trial instead of Buy).
pdp_entries :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: ("", "mco.pdp.trial.title", &[]),
    // rust: (
    // rust: "gui/realms/friends",
    // rust: "mco.pdp.friends.title",
    // rust: &["mco.pdp.friends.description"],
    // rust: ),
    // rust: (
    // rust: "gui/realms/minigames",
    // rust: "mco.pdp.minigames.title",
    // rust: &["mco.pdp.minigames.description"],
    // rust: ),
    // rust: (
    // rust: "gui/realms/private_server",
    // rust: "mco.pdp.private.title",
    // rust: &[
    // rust: "mco.pdp.private.backups",
    // rust: "mco.pdp.private.easyToManage",
    // rust: "mco.pdp.private.worldSlots",
    // rust: "mco.pdp.private.secure",
    // rust: ],
    // rust: ),
    // rust: ]
}

wrap_lines :: proc(text: string, atlas: ^HudAtlas, width: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: crate::multiplayer::wrap(text, width, atlas)
}

centered :: proc(batch: ^HudBatch, atlas: ^HudAtlas, text: string, cx: f32, y: f32, color: u32) {
}
    // rust: let w = HudBatch::text_width(atlas, text);
    // rust: batch.text(atlas, text, cx - (w / 2.0).floor(), y, color, true);
}

    // rust: impl Screen {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut screen = Self {
    // rust: state: FetchState::Unauthenticated,
    // rust: subscreen: SubScreen::Main,
    // rust: selected: None,
    // rust: joining: None,
    // rust: leaving: None,
    // rust: last_click: None,
}
    // rust: screen.refresh();
    // rust: screen
}

layout_state :: proc(self: ^Self) -> L {
    // Ported from Horizon
    return {}
}
    // rust: match &self.state {
    // rust: FetchState::Loading(_) => LayoutState::Loading,
    // rust: FetchState::Loaded(servers) if !servers.is_empty() => LayoutState::List,
    // rust: _ => LayoutState::NoRealms,
}
}

servers :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match &self.state {
    // rust: FetchState::Loaded(servers) => servers,
    // rust: _ => &[],
}
}

selected_server :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.servers().get(self.selected?)
}

    // `RealmsMainScreen.refreshServerList`.
refresh :: proc(self: ^Self) {
}
    // rust: self.selected = None;
    // rust: self.state = match client() {
    // rust: Some(client) => FetchState::Loading(spawn(move || client.list_worlds())),
    // rust: None => FetchState::Unauthenticated,
}
}

    // Picks up what the workers finished; called once a frame.
poll :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let FetchState::Loading(job) = &self.state
    // rust: && let Some(result) = take(job)
    // rust: {
    // rust: self.state = match result {
    // rust: Ok(servers) => FetchState::Loaded(servers),
    // rust: Err(e) => FetchState::Error(e),
}
}
    // rust: if let Some(job) = &self.leaving
    // rust: && let Some(result) = take(job)
    // rust: {
    // rust: self.leaving = None;
    // rust: match result {
    // rust: Ok(()) => self.refresh(),
    // rust: Err(e) => self.state = FetchState::Error(e),
}
}
    // rust: let mut refresh = false;
    // rust: let mut refetch_detail = false;
    // rust: let mut slot_options_saved = false;
    // rust: let mut open_region_screen = false;
    // rust: match &mut self.subscreen {
    // rust: SubScreen::JoinCode { error, job, .. } => {
    // rust: if let Some(result) = job.as_ref().and_then(take) {
    // rust: *job = None;
    // rust: match result {
    // rust: Ok(()) => {
    // rust: self.subscreen = SubScreen::Main;
    // rust: refresh = true;
}
    // rust: Err(_) => {
    // rust: *error = Some(crate::lang::get("mco.selectServer.joinCode.invalid"));
}
}
}
}
    // rust: SubScreen::PendingInvites { invites, job } => {
    // rust: if let Some(result) = job.as_ref().and_then(take) {
    // rust: *job = None;
    // rust: *invites = Some(result);
}
}
    // rust: SubScreen::Configure {
    // rust: server,
    // rust: subscription,
    // rust: subscription_job,
    // rust: detail,
    // rust: detail_job,
    // rust: deleting,
    // rust: member_job,
    // rust: settings,
    // rust: tier,
    // rust: tier_job,
    // rust: regions,
    // rust: regions_job,
    // rust: saving,
    // rust: error,
    // rust: job,
    // rust: ..
    // rust: } => {
    // rust: if let Some(result) = job.as_ref().and_then(take) {
    // rust: *job = None;
    // rust: match result {
    // rust: Ok(()) => {
    // rust: let open = server.is_open();
    // rust: server.state = if open { "CLOSED" } else { "OPEN" }.to_owned();
    // rust: refresh = true;
}
    // rust: Err(e) => *error = Some(e.text()),
}
}
    // rust: if let Some(result) = subscription_job.as_ref().and_then(take) {
    // rust: *subscription_job = None;
    // rust: *subscription = Some(result);
}
    // rust: if let Some(result) = detail_job.as_ref().and_then(take) {
    // rust: *detail_job = None;
    // rust: *detail = Some(result);
}
    // rust: if let Some(result) = tier_job.as_ref().and_then(take) {
    // rust: *tier_job = None;
                    // The tab's sliders take the ranges as they arrived; a draft opened
                    // before the answer gets its initial values now.
    // rust: if let Ok(config) = result.as_ref()
    // rust: && let Some(draft) = settings.as_mut()
    // rust: && draft.render_distance.is_none()
    // rust: && draft.simulation_distance.is_none()
    // rust: {
    // rust: draft.render_distance = config
    // rust: .render_distance
    // rust: .as_ref()
    // rust: .map(RealmTierRange::current_or_default);
    // rust: draft.simulation_distance = config
    // rust: .sim_distance
    // rust: .as_ref()
    // rust: .map(RealmTierRange::current_or_default);
}
    // rust: *tier = Some(result);
}
    // rust: if let Some(result) = member_job.as_ref().and_then(take) {
    // rust: *member_job = None;
    // rust: match result {
                        // `updateOps`: the list reads again with the new operators.
    // rust: Ok(()) => refetch_detail = true,
    // rust: Err(e) => *error = Some(e.text()),
}
}
    // rust: if let Some(result) = regions_job.as_ref().and_then(take) {
    // rust: *regions_job = None;
    // rust: match result {
    // rust: Ok(list) => {
    // rust: *regions = Some(Ok(list));
    // rust: open_region_screen = true;
}
    // rust: Err(e) => *error = Some(e.text()),
}
}
    // rust: if let Some(result) = saving.as_ref().and_then(take) {
    // rust: *saving = None;
    // rust: match result {
                        // `saveSettings` updates the screen's own copy and reads again; the
                        // saved distances are the tier's new current ones.
    // rust: Ok(()) => {
    // rust: if let Some(draft) = settings.as_ref() {
    // rust: server.name = draft.name.trim().to_owned();
    // rust: server.motd = draft.description.clone();
    // rust: server.region_selection_preference = Some(draft.preference_dto());
    // rust: if let Some(Ok(config)) = tier.as_mut() {
    // rust: let update = |range: &mut Option<RealmTierRange>,
    // rust: picked: Option<i32>| {
    // rust: if let (Some(range), Some(picked)) =
    // rust: (range.as_mut(), picked)
    // rust: {
    // rust: range.current = Some(picked);
}
}
    // rust: update(&mut config.render_distance, draft.render_distance);
    // rust: update(&mut config.sim_distance, draft.simulation_distance);
}
}
    // rust: refetch_detail = true;
}
    // rust: Err(e) => *error = Some(e.text()),
}
}
    // rust: if let Some(result) = deleting.as_ref().and_then(take) {
    // rust: *deleting = None;
    // rust: match result {
                        // The Realm is gone: the list reloads without it.
    // rust: Ok(()) => {
    // rust: self.subscreen = SubScreen::Main;
    // rust: self.selected = None;
    // rust: refresh = true;
}
    // rust: Err(e) => *error = Some(e.text()),
}
}
}
    // rust: SubScreen::SlotOptions { job, error, .. } => {
    // rust: if let Some(result) = job.as_ref().and_then(take) {
    // rust: *job = None;
    // rust: match result {
                        // `saveSlotSettings`'s `setScreen(this)`.
    // rust: Ok(()) => slot_options_saved = true,
    // rust: Err(e) => *error = Some(e.text()),
}
}
}
    // rust: SubScreen::Invite {
    // rust: server, job, error, ..
    // rust: } => {
    // rust: if let Some(result) = job.as_ref().and_then(take) {
    // rust: *job = None;
    // rust: match result {
    // rust: Ok(_players) => {
                            // `invitePlayer` succeeded: back to the players tab, which
                            // reads the list again.
    // rust: let server = server.clone();
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Players,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: None,
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
}
    // rust: Err(e) => *error = Some(e.text()),
}
}
}
    // rust: SubScreen::Connecting { .. } => return self.poll_join(),
    // rust: _ => {}
}
    // rust: if open_region_screen {
    // rust: self.open_region_preference();
}
    // rust: if slot_options_saved {
    // rust: self.back_to_worlds();
}
    // rust: if refetch_detail {
    // rust: self.start_configure_detail();
}
    // rust: if refresh {
    // rust: self.refresh();
}
    // rust: Outcome::None
}

    // `GetServerDetailsTask.run` once the address came back.
poll_join :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Some((job, _)) = &self.joining else {
    // rust: return Outcome::None;
}
    // rust: let Some(result) = take(job) else {
    // rust: return Outcome::None;
}
    // rust: self.joining = None;
    // rust: let SubScreen::Connecting { server, error } = &mut self.subscreen else {
    // rust: return Outcome::None;
}
    // rust: let address = match result {
    // rust: Ok(address) => address,
    // rust: Err(e) => {
                // 6006: the world is out of date; only its owner can reset it.
    // rust: let owner = session().is_some_and(|s| server.owned_by(s.uuid));
    // rust: *error = Some(if e.code() == 6006 && !owner {
    // rust: format!(
    // rust: "{} {}",
    // rust: crate::lang::get("mco.brokenworld.nonowner.title"),
    // rust: crate::lang::get("mco.brokenworld.nonowner.error")
    // rust: )
    // rust: } else {
    // rust: e.text()
    // rust: });
    // rust: return Outcome::None;
}
}
    // rust: let Some(target) = address.address.as_deref().and_then(connect_address) else {
    // rust: log::warn!("Horizon: Realms gave no usable address to join");
    // rust: *error = Some(crate::lang::get("mco.errorMessage.connectionFailure"));
    // rust: return Outcome::None;
}
    // rust: match (address.resource_pack_url, address.resource_pack_hash) {
            // `new URL(..)` fails in scheduleResourcePackDownload: the pack can't download.
    // rust: (Some(url), Some(_)) if !crate::server_packs::valid_url(&url) => {
    // rust: *error = Some(crate::lang::get("mco.download.resourcePack.fail"));
    // rust: Outcome::None
}
    // rust: (Some(url), Some(hash)) => {
    // rust: let pack = RealmsPack {
    // rust: address: target,
    // rust: id: pack_id(server),
    // rust: url,
    // rust: hash,
}
    // rust: self.subscreen = SubScreen::Popup(Popup::ResourcePack { pack });
    // rust: Outcome::None
}
    // rust: _ => {
    // rust: self.subscreen = SubScreen::Main;
    // rust: Outcome::Connect(target)
}
}
}

focused_box :: proc(self: ^Self) {
}
    // rust: match &self.subscreen {
    // rust: SubScreen::JoinCode { .. } => Some([(w / 2.0).floor() - 100.0, 64.0, 200.0, 20.0]),
    // rust: SubScreen::Invite { .. } => Some([(w / 2.0).floor() - 100.0, 62.0, 200.0, 20.0]),
    // rust: SubScreen::SlotOptions { .. } => Some([(w / 2.0).floor() - 154.0, 62.0, 152.0, 20.0]),
    // rust: SubScreen::Configure {
    // rust: tab: ConfigureTab::Settings,
    // rust: settings: Some(draft),
    // rust: ..
    // rust: } => {
    // rust: let left = (w / 2.0).floor() - 106.0;
    // rust: Some(if draft.on_description {
    // rust: [left, 86.0, 212.0, 20.0]
    // rust: } else {
    // rust: [left, 46.0, 212.0, 20.0]
    // rust: })
}
    // rust: _ => None,
}
}

focused_text :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match &mut self.subscreen {
    // rust: SubScreen::JoinCode { code, .. } => Some((REALMS_INVITE_CODE, code, 128)),
    // rust: SubScreen::Invite { name, .. } => Some((REALMS_PLAYER_NAME, name, 16)),
    // rust: SubScreen::SlotOptions { name, .. } => Some((REALMS_SLOT_NAME, name, 16)),
    // rust: SubScreen::Configure {
    // rust: tab: ConfigureTab::Settings,
    // rust: settings: Some(draft),
    // rust: ..
    // rust: } => Some(if draft.on_description {
    // rust: (REALMS_SETTINGS_DESC, &mut draft.description, 32)
    // rust: } else {
    // rust: (REALMS_SETTINGS_NAME, &mut draft.name, 32)
    // rust: }),
    // rust: _ => None,
}
}

tab :: proc(self: ^Self) {
}

    // Escape: a sub-screen goes back to the list (cancelling a join); the list goes back to
    // the title (true).
escape :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(self.subscreen, SubScreen::Main) {
    // rust: return true;
}
    // rust: self.back_to_list();
    // rust: false
}

back_to_list :: proc(self: ^Self) {
}
    // rust: self.save_settings_tab();
    // rust: if let Some((_, aborted)) = self.joining.take() {
    // rust: aborted.store(true, Ordering::Relaxed);
}
    // rust: let reload = matches!(self.subscreen, SubScreen::PendingInvites { .. });
    // rust: self.subscreen = SubScreen::Main;
    // rust: if reload {
    // rust: self.refresh();
}
}

    // Play: `RealmsMainScreen.play` → `GetServerDetailsTask` on a worker. The screen
    // shows "Connecting to the Realm..." and stays responsive.
play_selected :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.selected_server() {
    // rust: Some(server) => self.start_join(server.clone()),
    // rust: None => Outcome::None,
}
}

    // `RealmsMainScreen.play` for `server`, the list's or the configuration screen's.
start_join :: proc(self: ^Self, server: RealmServer) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !server.is_open() {
    // rust: return Outcome::None;
}
    // rust: let Some(client) = client() else {
    // rust: return Outcome::None;
}
    // rust: let aborted = Arc::new(AtomicBool::new(false));
    // rust: let flag = Arc::clone(&aborted);
    // rust: let id = server.id;
    // rust: let job = spawn(move || fetch_address(&client, id, &flag));
    // rust: self.joining = Some((job, aborted));
    // rust: self.subscreen = SubScreen::Connecting {
    // rust: server,
    // rust: error: None,
}
    // rust: Outcome::None
}

    // `RealmsConfigureWorldScreen.init`'s `fetchSubscription`: the subscription tab's
    // data, on a worker.
start_configure_subscription :: proc(self: ^Self) {
}
    // rust: let SubScreen::Configure {
    // rust: server,
    // rust: subscription_job,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: else {
    // rust: return;
}
    // rust: if subscription_job.is_some() {
    // rust: return;
}
    // rust: if let Some(client) = client() {
    // rust: let id = server.id;
    // rust: *subscription_job = Some(spawn(move || client.subscription_for(id)));
}
}

    // `RealmsConfigureWorldScreen.init`'s `fetchServerData`: the slots and players, on a
    // worker.
start_configure_detail :: proc(self: ^Self) {
}
    // rust: let SubScreen::Configure {
    // rust: server, detail_job, ..
    // rust: } = &mut self.subscreen
    // rust: else {
    // rust: return;
}
    // rust: if detail_job.is_some() {
    // rust: return;
}
    // rust: if let Some(client) = client() {
    // rust: let id = server.id;
    // rust: *detail_job = Some(spawn(move || client.get_own_realm(id)));
}
    // rust: self.start_configure_tier();
}

    // `RealmsConfigureWorldScreen.init`'s `fetchTierConfiguration`: asked again on every
    // entry until it answered (`tierConfigurationFetched`).
start_configure_tier :: proc(self: ^Self) {
}
    // rust: let SubScreen::Configure {
    // rust: server,
    // rust: tier,
    // rust: tier_job,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: else {
    // rust: return;
}
    // rust: if tier.is_some() || tier_job.is_some() {
    // rust: return;
}
    // rust: if let Some(client) = client() {
    // rust: let id = server.id;
    // rust: *tier_job = Some(spawn(move || client.get_tier_configuration(id)));
}
}

    // `RealmsInviteScreen.onInvite`: a blank name or one already invited is refused
    // before any request; the rest goes to `RealmsClient.invite` on a worker.
invite_clicked :: proc(self: ^Self) {
}
    // rust: let (name, id, already) = match &self.subscreen {
    // rust: SubScreen::Invite {
    // rust: server,
    // rust: players,
    // rust: name,
    // rust: job,
    // rust: ..
    // rust: } if job.is_none() => (
    // rust: name.trim().to_owned(),
    // rust: server.id,
    // rust: players
    // rust: .iter()
    // rust: .any(|p| p.name.eq_ignore_ascii_case(name.trim())),
    // rust: ),
    // rust: _ => return,
}
    // rust: let refusal = if name.is_empty() {
    // rust: Some("mco.configure.world.players.error")
    // rust: } else if already {
    // rust: Some("mco.configure.world.players.invite.duplicate")
    // rust: } else {
    // rust: None
}
    // rust: if let SubScreen::Invite { job, error, .. } = &mut self.subscreen {
    // rust: if let Some(key) = refusal {
    // rust: *error = Some(crate::lang::get(key));
    // rust: return;
}
    // rust: if let Some(client) = client() {
    // rust: *error = None;
    // rust: *job = Some(spawn(move || client.invite_player(id, &name)));
}
}
}

    // A chosen region preference: back to the settings tab with it.
back_to_settings :: proc(self: ^Self, server: RealmServer, settings: SettingsDraft) {
}
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Settings,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: settings: Some(settings),
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
}

    // `RealmsSettingsTab.onDeselected` → `RealmsConfigureWorldScreen.saveSettings`: the name,
    // description and region preference through `RealmsClient.updateConfiguration`, and a
    // changed distance through its own PUT — each only when it differs from what the service
    // has.
save_settings_tab :: proc(self: ^Self) {
}
    // rust: let SubScreen::Configure {
    // rust: tab: ConfigureTab::Settings,
    // rust: server,
    // rust: detail,
    // rust: settings: Some(draft),
    // rust: tier,
    // rust: saving,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: else {
    // rust: return;
}
    // rust: if saving.is_some() {
    // rust: return;
}
    // rust: let wanted = draft.preference_dto();
    // rust: let region_changed = server.region_selection_preference.as_ref().map_or(
    // rust: wanted.region_selection_preference != client::AUTOMATIC_OWNER,
    // rust: |p| *p != wanted,
    // rust: );
    // rust: let configuration_changed =
    // rust: draft.name.trim() != server.name || draft.description != server.motd || region_changed;
    // rust: let (render_distance, sim_distance) = match tier.as_ref() {
    // rust: Some(Ok(config)) => (
    // rust: changed_distance(draft.render_distance, config.render_distance.as_ref()),
    // rust: changed_distance(draft.simulation_distance, config.sim_distance.as_ref()),
    // rust: ),
    // rust: _ => (None, None),
}
    // rust: if !configuration_changed && render_distance.is_none() && sim_distance.is_none() {
    // rust: return;
}
    // rust: let Some(Ok(detail)) = detail else {
    // rust: return;
}
    // rust: let Some(slot) = detail.slots.get(&detail.active_slot).cloned() else {
    // rust: return;
}
    // rust: if let Some(client) = client() {
    // rust: let (id, name, description) = (
    // rust: server.id,
    // rust: draft.name.trim().to_owned(),
    // rust: draft.description.clone(),
    // rust: );
    // rust: *saving = Some(spawn(move || {
    // rust: if configuration_changed {
    // rust: client.update_configuration(id, &name, &description, &wanted, &slot)?;
}
    // rust: if let Some(render_distance) = render_distance {
    // rust: client.update_render_distance(id, render_distance)?;
}
    // rust: if let Some(simulation_distance) = sim_distance {
    // rust: client.update_simulation_distance(id, simulation_distance)?;
}
    // rust: Ok(())
    // rust: }));
}
}

    // `RealmsSettingsTab.openPreferenceSelector`, once the region list is there.
open_region_preference :: proc(self: ^Self) {
}
    // rust: let SubScreen::Configure {
    // rust: server,
    // rust: settings: Some(draft),
    // rust: regions: Some(Ok(list)),
    // rust: ..
    // rust: } = &self.subscreen
    // rust: else {
    // rust: return;
}
    // rust: let (server, settings, regions) = (server.clone(), draft.clone(), list.clone());
    // rust: let selected = Some((settings.preference, settings.region.clone()));
    // rust: self.subscreen = SubScreen::RegionPreference {
    // rust: server,
    // rust: settings,
    // rust: regions,
    // rust: selected,
}
}

    // `RealmsSlotOptionsScreen.onClose`: back to the worlds tab.
back_to_worlds :: proc(self: ^Self) {
}
    // rust: let SubScreen::SlotOptions { server, .. } = &self.subscreen else {
    // rust: return;
}
    // rust: let server = server.clone();
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Worlds,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: None,
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
}

    // `RealmsSlotOptionsScreen.saveSettings`: the edited slot, saved on a worker. A world
    // that is not NORMAL keeps its stored spawn protection and force-game-mode, as
    // vanilla does.
save_slot_options :: proc(self: ^Self) {
}
    // rust: let SubScreen::SlotOptions {
    // rust: server,
    // rust: slot,
    // rust: name,
    // rust: difficulty,
    // rust: game_mode,
    // rust: force_game_mode,
    // rust: spawn_protection,
    // rust: job,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: else {
    // rust: return;
}
    // rust: if job.is_some() {
    // rust: return;
}
    // rust: let normal = server.world_type == "NORMAL";
        // `setWorldName`: the default name is stored as empty.
    // rust: let default_name = crate::lang::tr(
    // rust: "mco.configure.world.slot",
    // rust: &[&slot.slot_id as &dyn std::fmt::Display],
    // rust: );
    // rust: let trimmed = name.trim();
    // rust: let slot_name = if trimmed == default_name {
    // rust: String::new()
    // rust: } else {
    // rust: trimmed.to_owned()
}
    // rust: let updated = RealmSlot {
    // rust: slot_id: slot.slot_id,
    // rust: options: RealmWorldOptions {
    // rust: spawn_protection: if normal {
    // rust: *spawn_protection
    // rust: } else {
    // rust: slot.options.spawn_protection
    // rust: },
    // rust: force_game_mode: if normal {
    // rust: *force_game_mode
    // rust: } else {
    // rust: slot.options.force_game_mode
    // rust: },
    // rust: difficulty: *difficulty as i32,
    // rust: game_mode: *game_mode as i32,
    // rust: slot_name,
    // rust: version: slot.options.version.clone(),
    // rust: compatibility: slot.options.compatibility.clone(),
    // rust: template_id: slot.options.template_id,
    // rust: template_image: slot.options.template_image.clone(),
    // rust: empty: slot.options.empty,
    // rust: },
    // rust: settings: slot.settings.clone(),
}
    // rust: if let Some(client) = client() {
    // rust: let id = server.id;
    // rust: *job = Some(spawn(move || client.update_slot(id, &updated)));
}
}

    // `RealmsInviteScreen.onClose`: back to the players tab.
back_to_players :: proc(self: ^Self) {
}
    // rust: let SubScreen::Invite { server, .. } = &self.subscreen else {
    // rust: return;
}
    // rust: let server = server.clone();
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Players,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: None,
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
}

click :: proc(self: ^Self, hit: Maybe(u8), x: f32, y: f32) {
}
    // rust: match hit {
    // rust: Some(1) => self.play_selected(),
    // rust: Some(2) => Outcome::Back,
    // rust: Some(10) => {
    // rust: if let Some(server) = self.selected_server().cloned() {
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Worlds,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: None,
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
}
    // rust: Outcome::None
}
    // rust: Some(11) => match (self.selected_server(), session()) {
                // RealmsMainScreen.onRenew.
    // rust: (Some(server), Some(s)) => Outcome::OpenUri(extend_link(server, s.uuid)),
    // rust: _ => Outcome::None,
    // rust: },
    // rust: Some(12) => {
    // rust: self.leave_clicked(session().map(|s| s.uuid));
    // rust: Outcome::None
}
    // rust: Some(13) => {
    // rust: self.subscreen = SubScreen::AddRealm {
    // rust: scroll: crate::ui::Scroll::default(),
    // rust: content: std::cell::Cell::new(0.0),
}
    // rust: Outcome::None
}
    // rust: Some(14) => {
    // rust: self.subscreen = SubScreen::JoinCode {
    // rust: code: String::new(),
    // rust: error: None,
    // rust: job: None,
}
    // rust: Outcome::None
}
    // rust: Some(15) => {
    // rust: let job = client().map(|c| spawn(move || c.pending_invites()));
    // rust: self.subscreen = SubScreen::PendingInvites { invites: None, job };
    // rust: Outcome::None
}
    // rust: Some(17) => {
    // rust: self.refresh();
    // rust: Outcome::None
}
    // rust: Some(20) => {
    // rust: if let SubScreen::JoinCode { code, error, job } = &mut self.subscreen
    // rust: && job.is_none()
    // rust: && !code.trim().is_empty()
    // rust: {
    // rust: match client() {
    // rust: Some(client) => {
    // rust: let code = code.trim().to_owned();
    // rust: *error = None;
    // rust: *job = Some(spawn(move || client.redeem_invite_code(&code)));
}
    // rust: None => *error = Some(crate::lang::get("horizon.realms.not_signed_in")),
}
}
    // rust: Outcome::None
}
    // rust: Some(21) | Some(22) | Some(32) | Some(41) | Some(51) | Some(52) => {
    // rust: self.back_to_list();
    // rust: Outcome::None
}
    // rust: Some(30) => {
    // rust: if let SubScreen::Configure {
    // rust: server, error, job, ..
    // rust: } = &mut self.subscreen
    // rust: && job.is_none()
    // rust: && let Some(client) = client()
    // rust: {
    // rust: let (id, open) = (server.id, server.is_open());
    // rust: *error = None;
    // rust: *job = Some(spawn(move || {
    // rust: if open {
    // rust: client.close_realm(id)
    // rust: } else {
    // rust: client.open_realm(id)
}
    // rust: }));
}
    // rust: Outcome::None
}
            // The configuration screen's tabs (60..=63) and its footer: Play (64).
    // rust: Some(sel @ 60..=63) => {
    // rust: if let SubScreen::Configure { server, tab, .. } = &mut self.subscreen
    // rust: && let Some(wanted) = ConfigureTab::ALL.get(usize::from(sel - 60))
    // rust: && wanted.enabled(server.expired)
    // rust: {
    // rust: *tab = *wanted;
}
    // rust: Outcome::None
}
    // rust: Some(64) => match &self.subscreen {
    // rust: SubScreen::Configure { server, .. } => self.start_join(server.clone()),
    // rust: _ => Outcome::None,
    // rust: },
            // The subscription tab's own buttons: Delete (expired only, after its question)
            // and Extend.
    // rust: Some(65) => {
    // rust: if let SubScreen::Configure {
    // rust: server, deleting, ..
    // rust: } = &self.subscreen
    // rust: && server.expired
    // rust: && deleting.is_none()
    // rust: {
    // rust: let server = server.clone();
    // rust: self.subscreen = SubScreen::Popup(Popup::Delete(server));
}
    // rust: Outcome::None
}
    // rust: Some(67) => {
    // rust: if let SubScreen::Configure { server, tab, .. } = &self.subscreen
    // rust: && *tab == ConfigureTab::Players
    // rust: {
    // rust: let players = match &self.subscreen {
    // rust: SubScreen::Configure {
    // rust: detail: Some(Ok(detail)),
    // rust: ..
    // rust: } => detail.players.clone(),
    // rust: _ => Vec::new(),
}
    // rust: self.subscreen = SubScreen::Invite {
    // rust: server: server.clone(),
    // rust: players,
    // rust: name: String::new(),
    // rust: job: None,
    // rust: error: None,
}
}
    // rust: Outcome::None
}
            // RealmsSlotOptionsScreen: the active slot's options.
    // rust: Some(94) => {
    // rust: if let SubScreen::Configure {
    // rust: server,
    // rust: detail: Some(Ok(detail)),
    // rust: ..
    // rust: } = &self.subscreen
    // rust: && let Some(slot) = detail.slots.get(&detail.active_slot)
    // rust: {
    // rust: let normal = server.world_type == "NORMAL";
    // rust: self.subscreen = SubScreen::SlotOptions {
    // rust: server: server.clone(),
    // rust: slot: slot.clone(),
    // rust: name: slot.options.slot_name.clone(),
    // rust: difficulty: usize::try_from(slot.options.difficulty)
    // rust: .ok()
    // rust: .filter(|d| *d < DIFFICULTIES.len())
    // rust: .unwrap_or(DIFFICULTY_DEFAULT),
    // rust: game_mode: usize::try_from(slot.options.game_mode)
    // rust: .ok()
    // rust: .filter(|m| *m < GAME_MODES.len())
    // rust: .unwrap_or(GAME_MODE_DEFAULT),
    // rust: force_game_mode: normal && slot.options.force_game_mode,
    // rust: spawn_protection: if normal {
    // rust: slot.options.spawn_protection
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: job: None,
    // rust: error: None,
}
}
    // rust: Outcome::None
}
            // RealmsPreferredRegionSelectionScreen.onDone / onClose.
    // rust: Some(87) => {
    // rust: if let SubScreen::RegionPreference {
    // rust: server,
    // rust: settings,
    // rust: selected,
    // rust: ..
    // rust: } = &self.subscreen
    // rust: && let Some((preference, region)) = selected
    // rust: {
    // rust: let server = server.clone();
    // rust: let mut settings = settings.clone();
    // rust: settings.preference = *preference;
    // rust: settings.region = region.clone();
    // rust: self.back_to_settings(server, settings);
}
    // rust: Outcome::None
}
    // rust: Some(86) => {
    // rust: if let SubScreen::RegionPreference {
    // rust: server, settings, ..
    // rust: } = &self.subscreen
    // rust: {
    // rust: let server = server.clone();
    // rust: let settings = settings.clone();
    // rust: self.back_to_settings(server, settings);
}
    // rust: Outcome::None
}
            // RealmsSettingsTab.openPreferenceSelector: the region list, then the screen.
    // rust: Some(89) => {
    // rust: if let SubScreen::Configure {
    // rust: server,
    // rust: settings: Some(draft),
    // rust: regions,
    // rust: ..
    // rust: } = &self.subscreen
    // rust: {
    // rust: let draft = draft.clone();
    // rust: let server = server.clone();
    // rust: let loaded = matches!(regions, Some(Ok(_)));
    // rust: if loaded {
    // rust: if let SubScreen::Configure {
    // rust: regions: Some(Ok(regions)),
    // rust: ..
    // rust: } = &self.subscreen
    // rust: {
    // rust: let regions = regions.clone();
    // rust: let selected = Some((draft.preference, draft.region.clone()));
    // rust: self.subscreen = SubScreen::RegionPreference {
    // rust: server,
    // rust: settings: draft,
    // rust: regions,
    // rust: selected,
}
}
    // rust: } else if let SubScreen::Configure { regions_job, .. } = &mut self.subscreen
    // rust: && regions_job.is_none()
    // rust: && let Some(client) = client()
    // rust: {
    // rust: *regions_job = Some(spawn(move || client.preferred_regions()));
}
}
    // rust: Outcome::None
}
            // RealmsSlotOptionsScreen: cycle, toggle, Done and Cancel.
    // rust: Some(95) => {
    // rust: if let SubScreen::SlotOptions {
    // rust: slot, difficulty, ..
    // rust: } = &mut self.subscreen
    // rust: && !slot.is_hardcore()
    // rust: {
    // rust: *difficulty = (*difficulty + 1) % DIFFICULTIES.len();
}
    // rust: Outcome::None
}
    // rust: Some(96) => {
    // rust: if let SubScreen::SlotOptions {
    // rust: slot, game_mode, ..
    // rust: } = &mut self.subscreen
    // rust: && !slot.is_hardcore()
    // rust: {
    // rust: *game_mode = (*game_mode + 1) % GAME_MODES.len();
}
    // rust: Outcome::None
}
    // rust: Some(97) => {
    // rust: if let SubScreen::SlotOptions {
    // rust: server,
    // rust: slot,
    // rust: force_game_mode,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: && server.world_type == "NORMAL"
    // rust: && !slot.is_hardcore()
    // rust: {
    // rust: *force_game_mode = !*force_game_mode;
}
    // rust: Outcome::None
}
    // rust: Some(98) => {
    // rust: self.save_slot_options();
    // rust: Outcome::None
}
    // rust: Some(99) => {
    // rust: self.back_to_worlds();
    // rust: Outcome::None
}
            // RealmsInviteScreen: Invite (80) and Back (81).
    // rust: Some(80) => {
    // rust: self.invite_clicked();
    // rust: Outcome::None
}
    // rust: Some(81) => {
    // rust: self.back_to_players();
    // rust: Outcome::None
}
    // rust: Some(66) => match (&self.subscreen, session()) {
    // rust: (SubScreen::Configure { server, .. }, Some(s)) => {
    // rust: Outcome::OpenUri(extend_link(server, s.uuid))
}
    // rust: _ => Outcome::None,
    // rust: },
    // rust: Some(40) => Outcome::OpenUri(BUY_REALMS.to_owned()),
    // rust: Some(50) => self.popup_continue(),
    // rust: Some(btn @ 100..=200) => {
                // The button's meaning: a pending invite's answer, or a player row's
                // Op/Deop/Remove (`RealmsPlayersTab.PlayerEntry`).
Row :: enum {
    Nothing,
    Pending(bool, String),
    Member(bool, i64, String),
    Uninvite(RealmServer, PlayerInfo),
}
    // rust: let row = match &self.subscreen {
    // rust: SubScreen::PendingInvites { invites, job } if job.is_none() => {
    // rust: match invites.as_ref().and_then(|i| i.as_ref().ok()) {
    // rust: Some(list) => match list.get(usize::from((btn - 100) / 2)) {
    // rust: Some(invite) => {
    // rust: Row::Pending((btn - 100) % 2 == 0, invite.invitation_id.clone())
}
    // rust: None => Row::Nothing,
    // rust: },
    // rust: None => Row::Nothing,
}
}
    // rust: SubScreen::Configure {
    // rust: server,
    // rust: tab,
    // rust: detail,
    // rust: member_job,
    // rust: ..
    // rust: } if *tab == ConfigureTab::Players && member_job.is_none() => {
    // rust: let index = usize::from((btn - 100) / 3);
    // rust: let which = (btn - 100) % 3;
    // rust: let player = match detail {
    // rust: Some(Ok(detail)) => detail.players.get(index).cloned(),
    // rust: _ => None,
}
    // rust: match player {
    // rust: Some(player) if which < 2 => match &player.uuid {
    // rust: Some(uuid) if !uuid.is_empty() => {
    // rust: Row::Member(which == 0, server.id, uuid.clone())
}
    // rust: _ => Row::Nothing,
    // rust: },
    // rust: Some(player) => Row::Uninvite(server.clone(), player),
    // rust: None => Row::Nothing,
}
}
    // rust: _ => Row::Nothing,
}
    // rust: match row {
    // rust: Row::Nothing => {}
    // rust: Row::Pending(accept, id) => {
    // rust: if let SubScreen::PendingInvites { job, .. } = &mut self.subscreen
    // rust: && job.is_none()
    // rust: && let Some(client) = client()
    // rust: {
    // rust: *job = Some(spawn(move || {
    // rust: let done = if accept {
    // rust: client.accept_invite(&id)
    // rust: } else {
    // rust: client.reject_invite(&id)
}
    // rust: done.and_then(|()| client.pending_invites())
    // rust: }));
}
}
    // rust: Row::Member(op, realm_id, uuid) => {
    // rust: if let SubScreen::Configure { member_job, .. } = &mut self.subscreen
    // rust: && member_job.is_none()
    // rust: && let Some(client) = client()
    // rust: {
    // rust: *member_job = Some(spawn(move || {
    // rust: if op {
    // rust: client.op_player(realm_id, &uuid).map(drop)
    // rust: } else {
    // rust: client.deop_player(realm_id, &uuid).map(drop)
}
    // rust: }));
}
}
    // rust: Row::Uninvite(server, player) => {
    // rust: self.subscreen = SubScreen::Popup(Popup::Uninvite { server, player });
}
}
    // rust: Outcome::None
}
            // The tab bar draws its own tabs (`MenuTabBar`), so a click there carries no
            // button id: the tab bar's geometry decides.
    // rust: None if matches!(self.subscreen, SubScreen::Configure { .. }) => {
    // rust: let (bar_x, tab_w) = tab_geometry(w);
    // rust: if y < TAB_HEIGHT && x >= bar_x {
    // rust: let index = ((x - bar_x) / tab_w).floor() as usize;
    // rust: let current = match &self.subscreen {
    // rust: SubScreen::Configure { tab, .. } => Some(*tab),
    // rust: _ => None,
}
    // rust: if let (Some(current), Some(wanted)) = (current, ConfigureTab::ALL.get(index))
    // rust: && *wanted != current
    // rust: && current == ConfigureTab::Settings
    // rust: {
    // rust: self.save_settings_tab();
}
    // rust: if let SubScreen::Configure {
    // rust: server,
    // rust: tab,
    // rust: settings,
    // rust: tier,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: && let Some(wanted) = ConfigureTab::ALL.get(index)
    // rust: && wanted.enabled(server.expired)
    // rust: {
    // rust: if *wanted == ConfigureTab::Settings && settings.is_none() {
                            // `RealmsSettingsTab.updateData`: the sliders start at the tier's
                            // current values when its answer is already here.
    // rust: let mut draft = SettingsDraft::of(server);
    // rust: if let Some(Ok(config)) = tier.as_ref() {
    // rust: draft.render_distance = config
    // rust: .render_distance
    // rust: .as_ref()
    // rust: .map(RealmTierRange::current_or_default);
    // rust: draft.simulation_distance = config
    // rust: .sim_distance
    // rust: .as_ref()
    // rust: .map(RealmTierRange::current_or_default);
}
    // rust: *settings = Some(draft);
}
    // rust: *tab = *wanted;
}
    // rust: return Outcome::None;
}
                // RealmsSettingsTab's two fields: the click moves the caret between them.
                // The two distance sliders: a click on the track sets the value, as the
                // spawn-protection slider does (no drag event on this screen yet).
    // rust: if let SubScreen::Configure {
    // rust: tab: ConfigureTab::Settings,
    // rust: settings: Some(draft),
    // rust: tier,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: {
    // rust: let left = (w / 2.0).floor() - 106.0;
    // rust: if (left..left + 212.0).contains(&x) {
    // rust: if (46.0..66.0).contains(&y) {
    // rust: draft.on_description = false;
    // rust: return Outcome::None;
}
    // rust: if (86.0..106.0).contains(&y) {
    // rust: draft.on_description = true;
    // rust: return Outcome::None;
}
}
    // rust: if let Some(Ok(config)) = tier.as_ref() {
                        // `OptionInstance`'s slider: the value snaps into the range.
    // rust: let bands = [
    // rust: (
    // rust: config.render_distance.as_ref(),
    // rust: 126.0,
    // rust: &mut draft.render_distance,
    // rust: ),
    // rust: (
    // rust: config.sim_distance.as_ref(),
    // rust: 166.0,
    // rust: &mut draft.simulation_distance,
    // rust: ),
    // rust: ];
    // rust: for (range, slider_y, picked) in bands {
    // rust: let (Some(range), Some(picked)) = (range, picked) else {
    // rust: continue;
}
    // rust: if (slider_y..slider_y + 20.0).contains(&y)
    // rust: && (left..left + 212.0).contains(&x)
    // rust: {
    // rust: *picked =
    // rust: range.from_slider(crate::ui::slider_value(left, 212.0, x));
    // rust: return Outcome::None;
}
}
}
}
                // RealmsPreferredRegionSelectionScreen: a row is the preference (the region
                // rows are MANUAL + that region).
    // rust: if let SubScreen::RegionPreference {
    // rust: regions, selected, ..
    // rust: } = &mut self.subscreen
    // rust: {
    // rust: let rows = region_rows(regions);
    // rust: let top = 40.0;
    // rust: let row = ((y - top) / 16.0).floor() as usize;
    // rust: if y >= top
    // rust: && let Some(pick) = rows.get(row)
    // rust: {
    // rust: *selected = Some(pick.clone());
}
    // rust: return Outcome::None;
}
                // RealmsSlotOptionsScreen's spawn-protection slider: a click on the track
                // sets the value (there is no drag event on this screen yet).
    // rust: if let SubScreen::SlotOptions {
    // rust: server,
    // rust: slot,
    // rust: spawn_protection,
    // rust: ..
    // rust: } = &mut self.subscreen
    // rust: && server.world_type == "NORMAL"
    // rust: && !slot.is_hardcore()
    // rust: {
    // rust: let (sx, sw) = (((w / 2.0).floor()) + 2.0, 152.0);
    // rust: if (118.0..138.0).contains(&y) && (sx..sx + sw).contains(&x) {
    // rust: let value = crate::ui::slider_value(sx, sw, x);
    // rust: *spawn_protection = (value * 16.0).round() as i32;
    // rust: return Outcome::None;
}
}
                // RealmsWorldsTab's slot buttons: a different slot asks before switching.
    // rust: let switch = match &self.subscreen {
    // rust: SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Worlds,
    // rust: detail: Some(Ok(detail)),
    // rust: ..
    // rust: } => slot_boxes(w, detail.active_slot)
    // rust: .into_iter()
    // rust: .find(|(bx, size, slot)| {
    // rust: x >= *bx
    // rust: && x < bx + size
    // rust: && y >= 44.0
    // rust: && y < 44.0 + size
    // rust: && *slot != detail.active_slot
    // rust: && detail
    // rust: .slots
    // rust: .get(slot)
    // rust: .is_some_and(|entry| !entry.options.empty)
    // rust: })
    // rust: .map(|(_, _, slot)| (server.clone(), slot)),
    // rust: _ => None,
}
    // rust: if let Some((server, slot)) = switch {
    // rust: self.subscreen = SubScreen::Popup(Popup::SwitchSlot { server, slot });
}
    // rust: Outcome::None
}
    // rust: _ => self.click_list(x, y, (w, h)),
}
}

    // `RealmsMainScreen.leaveClicked`: someone else's Realm only, and only the question:
    // nothing is sent until Continue.
leave_clicked :: proc(self: ^Self, me: Maybe(u128)) {
}
    // rust: if let Some(server) = self.selected_server().cloned()
    // rust: && let Some(me) = me
    // rust: && !server.owned_by(me)
    // rust: {
    // rust: self.subscreen = SubScreen::Popup(Popup::Leave(server));
}
}

    // Continue in a popup.
popup_continue :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let SubScreen::Popup(popup) = &self.subscreen else {
    // rust: return Outcome::None;
}
    // rust: let popup = popup.clone();
    // rust: self.subscreen = SubScreen::Main;
    // rust: match popup {
    // rust: Popup::Leave(server) => {
                // leaveServer: on a thread, then the list reloads.
    // rust: if let Some(client) = client() {
    // rust: let id = server.id;
    // rust: self.leaving = Some(spawn(move || client.uninvite_myself(id)));
    // rust: self.selected = None;
}
    // rust: Outcome::None
}
    // rust: Popup::ResourcePack { pack } => {
    // rust: let address = pack.address.clone();
    // rust: if let Ok(mut slot) = PENDING_PACK.lock() {
    // rust: *slot = Some(pack);
}
    // rust: Outcome::Connect(address)
}
            // RealmsWorldsTab.switchToFullSlot, answered: `RealmsClient.switchSlot` on a
            // worker, then the detail reads again.
    // rust: Popup::SwitchSlot { server, slot } => {
    // rust: let Some(client) = client() else {
    // rust: return Outcome::None;
}
    // rust: let id = server.id;
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Worlds,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: Some(spawn(move || client.switch_slot(id, slot).map(drop))),
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
    // rust: Outcome::None
}
            // RealmsPlayersTab.PlayerEntry.uninvite, answered: the player goes and the
            // list reads again.
    // rust: Popup::Uninvite { server, player } => {
    // rust: let Some(client) = client() else {
    // rust: return Outcome::None;
}
    // rust: let (id, uuid) = (server.id, player.uuid.clone().unwrap_or_default());
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Players,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: None,
    // rust: member_job: Some(spawn(move || client.uninvite_player(id, &uuid))),
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
    // rust: Outcome::None
}
            // RealmsSubscriptionTab.deleteRealm: the question was asked over the
            // configuration screen, so it answers there; the list returns once the
            // Realm is gone.
    // rust: Popup::Delete(server) => {
    // rust: let Some(client) = client() else {
    // rust: return Outcome::None;
}
    // rust: let id = server.id;
    // rust: self.subscreen = SubScreen::Configure {
    // rust: server,
    // rust: tab: ConfigureTab::Subscription,
    // rust: subscription: None,
    // rust: subscription_job: None,
    // rust: detail: None,
    // rust: detail_job: None,
    // rust: deleting: Some(spawn(move || client.delete_realm(id))),
    // rust: member_job: None,
    // rust: settings: None,
    // rust: tier: None,
    // rust: tier_job: None,
    // rust: regions: None,
    // rust: regions_job: None,
    // rust: saving: None,
    // rust: error: None,
    // rust: job: None,
}
                // A failed delete stays here and the tab reads again.
    // rust: self.start_configure_subscription();
    // rust: self.start_configure_detail();
    // rust: Outcome::None
}
}
}

click_list :: proc(self: ^Self, x: f32, y: f32) {
}
    // rust: if !matches!(self.subscreen, SubScreen::Main) {
    // rust: return Outcome::None;
}
    // rust: let footer_h = if self.layout_state() == LayoutState::List {
    // rust: 60.0
    // rust: } else {
    // rust: 48.0
}
    // rust: let (top, bottom) = (HEADER_HEIGHT, h - footer_h);
    // rust: let rx = ((w - ROW_WIDTH) / 2.0).floor();
    // rust: if y < top || y > bottom || x < rx || x > rx + ROW_WIDTH {
    // rust: return Outcome::None;
}
    // rust: let row = ((y - top - 2.0) / ROW_HEIGHT).floor() as usize;
    // rust: let Some(can_play) = self.servers().get(row).map(RealmServer::is_open) else {
    // rust: return Outcome::None;
}
    // rust: let now = SystemTime::now();
    // rust: let double = matches!(self.last_click, Some((last, at)) if last == row
    // rust: && now.duration_since(at).is_ok_and(|d| d.as_millis() < 350));
    // rust: self.selected = Some(row);
    // rust: self.last_click = Some((row, now));
    // rust: if double && can_play {
    // rust: return self.play_selected();
}
    // rust: Outcome::None
}

    // `AbstractScrollArea.mouseScrolled` over the product page's list.
wheel :: proc(self: ^Self, delta: f32, cursor: (f32) {
}
    // rust: let SubScreen::AddRealm { scroll, content } = &mut self.subscreen else {
    // rust: return;
}
    // rust: let (top, bottom) = (44.0, h - 40.0);
    // rust: if cursor.1 < top || cursor.1 >= bottom {
    // rust: return;
}
    // rust: scroll.wheel(delta, 10.0, top, bottom, content.get());
}

    // rust: pub fn buttons(
    // rust: &self,
    // rust: w: f32,
    // rust: h: f32,
    // rust: ) -> Vec<(f32, f32, f32, String, bool, u8, Option<(&'static str, f32)>)> {
    // rust: let cx = (w / 2.0).floor();
    // rust: let left = cx - (CONTENT_WIDTH / 2.0).floor();
    // rust: let mid = (h / 2.0).floor();
    // rust: let t = crate::lang::get;
    // rust: let mut buttons = Vec::new();

    // rust: match &self.subscreen {
    // rust: SubScreen::JoinCode { code, job, .. } => {
    // rust: buttons.push((
    // rust: cx - 100.0,
    // rust: mid + 10.0,
    // rust: 200.0,
    // rust: t("mco.selectServer.joinCode.select"),
    // rust: !code.trim().is_empty() && job.is_none(),
    // rust: 20,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx - 100.0,
    // rust: mid + 34.0,
    // rust: 200.0,
    // rust: t("gui.cancel"),
    // rust: true,
    // rust: 21,
    // rust: None,
    // rust: ));
}
    // rust: SubScreen::PendingInvites { invites, job } => {
    // rust: buttons.push((cx - 100.0, h - 36.0, 200.0, t("gui.done"), true, 22, None));
    // rust: if let Some(Ok(list)) = invites {
    // rust: let rx = ((w - ROW_WIDTH) / 2.0).floor();
    // rust: for (i, _) in list.iter().enumerate().take(40) {
    // rust: let row_y = 36.0 + 2.0 + i as f32 * ROW_HEIGHT;
    // rust: if row_y + ROW_HEIGHT > h - 48.0 {
    // rust: break;
}
    // rust: let id = 100 + i as u8 * 2;
    // rust: buttons.push((
    // rust: rx + ROW_WIDTH - 46.0,
    // rust: row_y + 8.0,
    // rust: 20.0,
    // rust: String::new(),
    // rust: job.is_none(),
    // rust: id,
    // rust: Some(("pending_invite/accept", 14.0)),
    // rust: ));
    // rust: buttons.push((
    // rust: rx + ROW_WIDTH - 22.0,
    // rust: row_y + 8.0,
    // rust: 20.0,
    // rust: String::new(),
    // rust: job.is_none(),
    // rust: id + 1,
    // rust: Some(("pending_invite/reject", 14.0)),
    // rust: ));
}
}
}
    // rust: SubScreen::Configure {
    // rust: server,
    // rust: tab,
    // rust: subscription,
    // rust: detail,
    // rust: tier,
    // rust: deleting,
    // rust: member_job,
    // rust: job,
    // rust: ..
    // rust: } => {
                // The footer: Play, the open/close toggle (vanilla keeps it on the settings
                // tab; it stays here until that tab lands) and Back.
    // rust: buttons.push((
    // rust: cx - 102.0,
    // rust: h - 26.0,
    // rust: 100.0,
    // rust: t("mco.selectServer.play"),
    // rust: server.is_open(),
    // rust: 64,
    // rust: None,
    // rust: ));
    // rust: buttons.push((cx + 2.0, h - 26.0, 100.0, t("gui.back"), true, 32, None));
                // RealmsSettingsTab: the region preference and the open/close toggle
                // (vanilla keeps the toggle on this tab). The two distance sliders push
                // them down once the tier answer arrived.
    // rust: if *tab == ConfigureTab::Settings {
    // rust: let shift = if matches!(tier, Some(Ok(_))) {
    // rust: 80.0
    // rust: } else {
    // rust: 0.0
}
    // rust: buttons.push((
    // rust: cx - 106.0,
    // rust: 146.0 + shift,
    // rust: 212.0,
    // rust: t("mco.configure.world.buttons.region_preference"),
    // rust: true,
    // rust: 89,
    // rust: None,
    // rust: ));
    // rust: let toggle = if server.is_open() {
    // rust: t("mco.configure.world.buttons.close")
    // rust: } else {
    // rust: t("mco.configure.world.buttons.open")
}
    // rust: buttons.push((
    // rust: cx - 106.0,
    // rust: 174.0 + shift,
    // rust: 212.0,
    // rust: toggle,
    // rust: job.is_none(),
    // rust: 30,
    // rust: None,
    // rust: ));
}
                // RealmsSubscriptionTab's own two buttons.
    // rust: if *tab == ConfigureTab::Subscription && matches!(subscription, Some(Ok(_))) {
    // rust: buttons.push((
    // rust: cx - 100.0,
    // rust: 92.0,
    // rust: 200.0,
    // rust: t("mco.configure.world.subscription.extend"),
    // rust: true,
    // rust: 66,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx - 100.0,
    // rust: 118.0,
    // rust: 200.0,
    // rust: t("mco.configure.world.delete.button"),
    // rust: server.expired && deleting.is_none(),
    // rust: 65,
    // rust: None,
    // rust: ));
}
                // RealmsWorldsTab: World Options (Backup and Reset follow in their PRs).
    // rust: if *tab == ConfigureTab::Worlds
    // rust: && let Some(Ok(detail)) = detail
    // rust: && let Some(slot) = detail.slots.get(&detail.active_slot)
    // rust: && !slot.options.empty
    // rust: {
    // rust: buttons.push((
    // rust: cx - 76.0,
    // rust: h - 96.0,
    // rust: 152.0,
    // rust: t("mco.configure.world.buttons.options"),
    // rust: !server.expired,
    // rust: 94,
    // rust: None,
    // rust: ));
}
                // RealmsPlayersTab: a row's Op/Deop/Remove, then Invite Player.
    // rust: if *tab == ConfigureTab::Players
    // rust: && let Some(Ok(detail)) = detail
    // rust: {
    // rust: let rx = ((w - ROW_WIDTH) / 2.0).floor();
    // rust: for (i, player) in detail.players.iter().enumerate() {
    // rust: let row_y = 36.0 + 22.0 + 2.0 + i as f32 * ROW_HEIGHT;
    // rust: if row_y + ROW_HEIGHT > h - 48.0 {
    // rust: break;
}
    // rust: let id = 100 + i as u8 * 3;
    // rust: let width = (ROW_WIDTH - 140.0).max(40.0) / 3.0;
                        // The vanilla buttons carry the sprite; these say what they do in
                        // the same three translations (`invites.*.tooltip`).
    // rust: for (n, key) in [
    // rust: (0u8, "mco.configure.world.invites.ops.tooltip"),
    // rust: (1, "mco.configure.world.invites.normal.tooltip"),
    // rust: (2, "mco.configure.world.invites.remove.tooltip"),
    // rust: ] {
    // rust: buttons.push((
    // rust: rx + ROW_WIDTH - 132.0 + n as f32 * width,
    // rust: row_y + 8.0,
    // rust: width - 2.0,
    // rust: t(key),
    // rust: player.uuid.is_some() && member_job.is_none(),
    // rust: id + n,
    // rust: None,
    // rust: ));
}
}
    // rust: buttons.push((
    // rust: cx - 100.0,
    // rust: h - 60.0,
    // rust: 200.0,
    // rust: t("mco.configure.world.buttons.invite"),
    // rust: true,
    // rust: 67,
    // rust: None,
    // rust: ));
}
}
    // rust: SubScreen::RegionPreference { .. } => {
    // rust: buttons.push((cx - 102.0, h - 36.0, 100.0, t("gui.done"), true, 87, None));
    // rust: buttons.push((cx + 2.0, h - 36.0, 100.0, t("gui.cancel"), true, 86, None));
}
    // rust: SubScreen::SlotOptions {
    // rust: server,
    // rust: slot,
    // rust: difficulty,
    // rust: game_mode,
    // rust: force_game_mode,
    // rust: job,
    // rust: ..
    // rust: } => {
                // `RealmsSlotOptionsScreen`: the two cycle buttons, the on/off and the
                // footer (the name field and the spawn-protection slider are drawn).
    // rust: let normal = server.world_type == "NORMAL";
    // rust: let hardcore = slot.is_hardcore();
    // rust: let on_off = |on: bool| {
    // rust: if on {
    // rust: t("options.on")
    // rust: } else {
    // rust: t("options.off")
}
}
    // rust: buttons.push((
    // rust: cx - 154.0,
    // rust: 90.0,
    // rust: 152.0,
    // rust: crate::lang::tr(
    // rust: "options.generic_value",
    // rust: &[&t("options.difficulty"), &t(DIFFICULTIES[*difficulty])],
    // rust: ),
    // rust: !hardcore,
    // rust: 95,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx + 2.0,
    // rust: 90.0,
    // rust: 152.0,
    // rust: crate::lang::tr(
    // rust: "options.generic_value",
    // rust: &[&t("selectWorld.gameMode"), &t(GAME_MODES[*game_mode])],
    // rust: ),
    // rust: !hardcore,
    // rust: 96,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx - 154.0,
    // rust: 118.0,
    // rust: 152.0,
    // rust: crate::lang::tr(
    // rust: "options.generic_value",
    // rust: &[
    // rust: &t("mco.configure.world.forceGameMode"),
    // rust: &on_off(*force_game_mode),
    // rust: ],
    // rust: ),
    // rust: normal && !hardcore,
    // rust: 97,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx - 102.0,
    // rust: h - 36.0,
    // rust: 100.0,
    // rust: t("gui.done"),
    // rust: job.is_none(),
    // rust: 98,
    // rust: None,
    // rust: ));
    // rust: buttons.push((cx + 2.0, h - 36.0, 100.0, t("gui.cancel"), true, 99, None));
}
    // rust: SubScreen::Invite { job, .. } => {
    // rust: buttons.push((
    // rust: cx - 100.0,
    // rust: mid + 10.0,
    // rust: 200.0,
    // rust: t("mco.configure.world.buttons.invite"),
    // rust: job.is_none(),
    // rust: 80,
    // rust: None,
    // rust: ));
    // rust: buttons.push((cx - 100.0, h - 36.0, 200.0, t("gui.back"), true, 81, None));
}
    // rust: SubScreen::AddRealm { .. } => {
                // `RealmsPdpScreen`'s footer: the buy button carries the PDP's own title.
    // rust: buttons.push((
    // rust: cx - 102.0,
    // rust: h - 26.0,
    // rust: 100.0,
    // rust: t("mco.selectServer.purchase"),
    // rust: true,
    // rust: 40,
    // rust: None,
    // rust: ));
    // rust: buttons.push((cx + 2.0, h - 26.0, 100.0, t("gui.back"), true, 41, None));
}
    // rust: SubScreen::Popup(_) => {
    // rust: buttons.push((
    // rust: cx - 102.0,
    // rust: mid + 30.0,
    // rust: 100.0,
    // rust: t("gui.continue"),
    // rust: true,
    // rust: 50,
    // rust: None,
    // rust: ));
    // rust: buttons.push((cx + 2.0, mid + 30.0, 100.0, t("gui.cancel"), true, 51, None));
}
    // rust: SubScreen::Connecting { error, .. } => {
    // rust: let label = if error.is_some() {
    // rust: t("gui.back")
    // rust: } else {
    // rust: t("gui.cancel")
}
    // rust: buttons.push((cx - 100.0, mid + 40.0, 200.0, label, true, 52, None));
}
    // rust: SubScreen::Main => {
    // rust: let signed_in = session().is_some();
    // rust: buttons.push((
    // rust: cx - 68.0 - 112.0,
    // rust: 12.0,
    // rust: 112.0,
    // rust: t("mco.selectServer.joinRealm"),
    // rust: signed_in,
    // rust: 14,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: left + CONTENT_WIDTH - 44.0,
    // rust: 12.0,
    // rust: 20.0,
    // rust: String::new(),
    // rust: signed_in,
    // rust: 15,
    // rust: Some(("icon/invite", 14.0)),
    // rust: ));
                // RealmsHeader's news button opens the news link the service sent; Horizon
                // doesn't fetch the news, so it has none (vanilla's newsLink == null).
    // rust: buttons.push((
    // rust: left + CONTENT_WIDTH - 20.0,
    // rust: 12.0,
    // rust: 20.0,
    // rust: String::new(),
    // rust: false,
    // rust: 16,
    // rust: Some(("icon/news", 14.0)),
    // rust: ));

    // rust: match self.layout_state() {
    // rust: LayoutState::List => {
    // rust: let server = self.selected_server();
    // rust: let uuid = session().map(|s| s.uuid);
    // rust: let owned = server.zip(uuid).is_some_and(|(s, u)| s.owned_by(u));
    // rust: let can_join = server.is_some_and(RealmServer::is_open);
    // rust: let expired = server.is_some_and(|s| s.expired);
    // rust: let row1 = h - 52.0;
    // rust: let row2 = h - 28.0;
    // rust: buttons.push((
    // rust: left,
    // rust: row1,
    // rust: 100.0,
    // rust: t("mco.selectServer.play"),
    // rust: can_join,
    // rust: 1,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: left + 104.0,
    // rust: row1,
    // rust: 100.0,
    // rust: t("mco.selectServer.configure"),
    // rust: owned,
    // rust: 10,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: left + 208.0,
    // rust: row1,
    // rust: 100.0,
    // rust: t("mco.selectServer.expiredRenew"),
    // rust: owned && expired,
    // rust: 11,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: left,
    // rust: row2,
    // rust: 100.0,
    // rust: t("mco.selectServer.leave"),
    // rust: server.is_some() && uuid.is_some() && !owned && self.leaving.is_none(),
    // rust: 12,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: left + 104.0,
    // rust: row2,
    // rust: 100.0,
    // rust: t("mco.selectServer.purchase"),
    // rust: true,
    // rust: 13,
    // rust: None,
    // rust: ));
    // rust: buttons.push((left + 208.0, row2, 100.0, t("gui.back"), true, 2, None));
}
    // rust: LayoutState::NoRealms | LayoutState::Loading => {
    // rust: if matches!(self.state, FetchState::Error(_)) {
    // rust: buttons.push((
    // rust: cx - 154.0,
    // rust: h - 36.0,
    // rust: 100.0,
    // rust: t("mco.errorMessage.retry"),
    // rust: true,
    // rust: 17,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx - 50.0,
    // rust: h - 36.0,
    // rust: 100.0,
    // rust: t("mco.selectServer.purchase"),
    // rust: true,
    // rust: 13,
    // rust: None,
    // rust: ));
    // rust: buttons.push((
    // rust: cx + 54.0,
    // rust: h - 36.0,
    // rust: 100.0,
    // rust: t("gui.back"),
    // rust: true,
    // rust: 2,
    // rust: None,
    // rust: ));
    // rust: } else {
    // rust: buttons.push((
    // rust: cx - 102.0,
    // rust: h - 36.0,
    // rust: 100.0,
    // rust: t("mco.selectServer.purchase"),
    // rust: true,
    // rust: 13,
    // rust: None,
    // rust: ));
    // rust: buttons.push((cx + 2.0, h - 36.0, 100.0, t("gui.back"), true, 2, None));
}
}
}
}
}
    // rust: buttons
}

    // rust: pub fn draw(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: caret: &mut crate::ui::Caret,
    // rust: focused_at: Instant,
    // rust: cursor: (f32, f32),
    // rust: w: f32,
    // rust: h: f32,
    // rust: ) {
    // rust: let (w, h) = (w.ceil(), h.ceil());
    // rust: let cx = (w / 2.0).floor();
    // rust: let mid = (h / 2.0).floor();
    // rust: let t = crate::lang::get;
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);

    // rust: match &self.subscreen {
    // rust: SubScreen::JoinCode { code, error, job } => {
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.selectServer.joinCode.title"),
    // rust: cx,
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.selectServer.joinCode"),
    // rust: cx - 100.0,
    // rust: 50.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: caret.draw(
    // rust: batch,
    // rust: atlas,
    // rust: (REALMS_INVITE_CODE, code, 128),
    // rust: [cx - 100.0, 64.0, 200.0, 20.0],
    // rust: true,
    // rust: focused_at,
    // rust: );
    // rust: if job.is_some() {
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.selectServer.joinCode.validating"),
    // rust: cx,
    // rust: 88.0,
    // rust: u32::MAX,
    // rust: );
    // rust: } else if let Some(err) = error {
    // rust: centered(batch, atlas, err, cx, 88.0, RED);
}
}
    // rust: SubScreen::PendingInvites { invites, .. } => {
    // rust: centered(batch, atlas, &t("mco.invites.title"), cx, 14.0, u32::MAX);
    // rust: let (top, bottom) = (36.0, h - 48.0);
    // rust: crate::ui::list_background(batch, atlas, top, bottom, false);
    // rust: match invites {
    // rust: None => {}
    // rust: Some(Err(e)) => {
    // rust: for (i, line) in wrap_lines(&e.text(), atlas, w - 40.0).iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, mid + i as f32 * 10.0, RED);
}
}
    // rust: Some(Ok(list)) if list.is_empty() => {
    // rust: centered(batch, atlas, &t("mco.invites.nopending"), cx, mid, GREY);
}
    // rust: Some(Ok(list)) => {
    // rust: let rx = ((w - ROW_WIDTH) / 2.0).floor();
    // rust: for (i, invite) in list.iter().enumerate() {
    // rust: let y = top + 2.0 + i as f32 * ROW_HEIGHT;
    // rust: if y + ROW_HEIGHT > bottom {
    // rust: break;
}
    // rust: batch.text(
    // rust: atlas,
    // rust: &invite.world_name,
    // rust: rx + 10.0,
    // rust: y + 4.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &invite.world_owner_name,
    // rust: rx + 10.0,
    // rust: y + 16.0,
    // rust: GREY,
    // rust: true,
    // rust: );
}
}
}
}
    // rust: SubScreen::Configure {
    // rust: server,
    // rust: tab,
    // rust: subscription,
    // rust: detail,
    // rust: settings,
    // rust: tier,
    // rust: regions,
    // rust: saving,
    // rust: deleting,
    // rust: error,
    // rust: job,
    // rust: ..
    // rust: } => {
                // `RealmsConfigureWorldScreen`: the tab bar over `gui/tab_header_background`,
                // the header separators either side of it, and the footer's separator.
    // rust: crate::ui::tiled(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/tab_header_background",
    // rust: 0.0,
    // rust: 0.0,
    // rust: w,
    // rust: TAB_HEIGHT,
    // rust: 16.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let (bar_x, tab_w) = tab_geometry(w);
    // rust: let now = crate::hud_overlays::now_ms();
    // rust: for (i, which) in ConfigureTab::ALL.iter().enumerate() {
    // rust: let x = bar_x + i as f32 * tab_w;
    // rust: let selected = which == tab;
    // rust: let hover = crate::ui::hovered(cursor, x, 0.0, tab_w, TAB_HEIGHT);
    // rust: let sprite = match (selected, hover) {
    // rust: (true, true) => "gui/sprites/widget/tab_selected_highlighted",
    // rust: (true, false) => "gui/sprites/widget/tab_selected",
    // rust: (false, true) => "gui/sprites/widget/tab_highlighted",
    // rust: (false, false) => "gui/sprites/widget/tab",
}
    // rust: crate::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: x,
    // rust: 0.0,
    // rust: tab_w,
    // rust: TAB_HEIGHT,
    // rust: u32::MAX,
    // rust: );
    // rust: if selected {
    // rust: crate::ui::menu_background(
    // rust: batch,
    // rust: atlas,
    // rust: x + 2.0,
    // rust: 2.0,
    // rust: tab_w - 4.0,
    // rust: 22.0,
    // rust: false,
    // rust: );
    // rust: batch.fill(atlas, x + 2.0, 22.0, tab_w - 4.0, 1.0, u32::MAX);
}
    // rust: crate::ui::menu_tab_label(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::translate(which.title(), &[]),
    // rust: (x, 0.0, tab_w, TAB_HEIGHT),
    // rust: selected,
    // rust: which.enabled(server.expired),
    // rust: now,
    // rust: );
}
    // rust: for (left, width) in [(0.0, bar_x), (bar_x + 4.0 * tab_w, w - bar_x - 4.0 * tab_w)]
    // rust: {
    // rust: crate::ui::tiled_sized(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/header_separator",
    // rust: left,
    // rust: TAB_HEIGHT - 2.0,
    // rust: width,
    // rust: 2.0,
    // rust: [32.0, 2.0],
    // rust: u32::MAX,
    // rust: );
}
    // rust: crate::ui::tiled_sized(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/footer_separator",
    // rust: 0.0,
    // rust: h - 35.0,
    // rust: w,
    // rust: 2.0,
    // rust: [32.0, 2.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let left = cx - 100.0;
    // rust: match tab {
    // rust: ConfigureTab::Subscription => match subscription {
    // rust: Some(Ok(sub)) => {
    // rust: let mut label = |y: f32, text: &str, color: u32| {
    // rust: batch.text(atlas, text, left, y, color, true);
}
    // rust: label(26.0, &t("mco.configure.world.subscription.start"), u32::MAX);
    // rust: label(41.0, &start_date_text(sub.start_date), GREY);
    // rust: let days_label = if sub.kind == "RECURRING" {
    // rust: t("mco.configure.world.subscription.recurring.daysleft")
    // rust: } else {
    // rust: t("mco.configure.world.subscription.timeleft")
}
    // rust: label(56.0, &days_label, u32::MAX);
    // rust: label(71.0, &days_left_text(sub.days_left, server.expired), GREY);
    // rust: for (i, line) in wrap_lines(
    // rust: &t("mco.configure.world.subscription.recurring.info"),
    // rust: atlas,
    // rust: 200.0,
    // rust: )
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: label(146.0 + i as f32 * 10.0, line, GREY);
}
}
    // rust: Some(Err(e)) => {
    // rust: for (i, line) in
    // rust: wrap_lines(&e.text(), atlas, w - 40.0).iter().enumerate()
    // rust: {
    // rust: centered(batch, atlas, line, cx, 60.0 + i as f32 * 10.0, RED);
}
}
    // rust: None => centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.loading"),
    // rust: cx,
    // rust: 60.0,
    // rust: u32::MAX,
    // rust: ),
    // rust: },
    // rust: ConfigureTab::Worlds => match detail {
    // rust: Some(Ok(detail)) => {
    // rust: let boxes = slot_boxes(w, detail.active_slot);
    // rust: let top = 44.0;
    // rust: for (bx, size, slot) in boxes {
    // rust: let active = slot == detail.active_slot;
    // rust: let color = if active { 0xFFB0_B0B0 } else { 0xFF70_7070 };
    // rust: batch.fill(atlas, bx, top, size, size, color);
    // rust: if let Some(entry) = detail.slots.get(&slot) {
    // rust: let name = slot_name(&entry.options, slot);
    // rust: let tw = HudBatch::text_width(atlas, &name);
    // rust: batch.text(
    // rust: atlas,
    // rust: &name,
    // rust: bx + ((size - tw) / 2.0).floor(),
    // rust: top + size - 12.0,
    // rust: if active { u32::MAX } else { GREY },
    // rust: true,
    // rust: );
}
}
}
    // rust: Some(Err(e)) => {
    // rust: for (i, line) in
    // rust: wrap_lines(&e.text(), atlas, w - 40.0).iter().enumerate()
    // rust: {
    // rust: centered(batch, atlas, line, cx, 60.0 + i as f32 * 10.0, RED);
}
}
    // rust: None => centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.loading"),
    // rust: cx,
    // rust: 60.0,
    // rust: u32::MAX,
    // rust: ),
    // rust: },
    // rust: ConfigureTab::Players => match detail {
    // rust: Some(Ok(detail)) => {
    // rust: let invited = crate::lang::tr(
    // rust: "mco.configure.world.invited.number",
    // rust: &[&detail.players.len() as &dyn std::fmt::Display],
    // rust: );
    // rust: centered(batch, atlas, &invited, cx, 26.0, u32::MAX);
    // rust: let rx = ((w - ROW_WIDTH) / 2.0).floor();
    // rust: for (i, player) in detail.players.iter().enumerate() {
    // rust: let row_y = 36.0 + 22.0 + 2.0 + i as f32 * ROW_HEIGHT;
    // rust: if row_y + ROW_HEIGHT > h - 48.0 {
    // rust: break;
}
    // rust: let name = if player.operator {
    // rust: format!(
    // rust: "{} [{}]",
    // rust: player.name,
    // rust: t("mco.configure.world.invites.ops.tooltip")
    // rust: )
    // rust: } else {
    // rust: player.name.clone()
}
    // rust: batch.text(atlas, &name, rx + 4.0, row_y + 14.0, u32::MAX, true);
}
}
    // rust: Some(Err(e)) => {
    // rust: for (i, line) in
    // rust: wrap_lines(&e.text(), atlas, w - 40.0).iter().enumerate()
    // rust: {
    // rust: centered(batch, atlas, line, cx, 60.0 + i as f32 * 10.0, RED);
}
}
    // rust: None => centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.loading"),
    // rust: cx,
    // rust: 60.0,
    // rust: u32::MAX,
    // rust: ),
    // rust: },
    // rust: ConfigureTab::Settings => match settings {
    // rust: Some(draft) => {
                            // `RealmsSettingsTab`: the name and description fields, the two
                            // distance sliders once the tier answer arrived, the region
                            // preference line and the open/close button.
    // rust: let left = cx - 106.0;
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.name"),
    // rust: left,
    // rust: 34.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: caret.draw(
    // rust: batch,
    // rust: atlas,
    // rust: (REALMS_SETTINGS_NAME, &draft.name, 32),
    // rust: [left, 46.0, 212.0, 20.0],
    // rust: !draft.on_description,
    // rust: focused_at,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.description"),
    // rust: left,
    // rust: 74.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: caret.draw(
    // rust: batch,
    // rust: atlas,
    // rust: (REALMS_SETTINGS_DESC, &draft.description, 32),
    // rust: [left, 86.0, 212.0, 20.0],
    // rust: draft.on_description,
    // rust: focused_at,
    // rust: );
    // rust: let mut shift = 0.0;
    // rust: if let Some(Ok(config)) = tier.as_ref() {
                                // `createDistanceOption`: a slider over the range, its value
                                // as `options.chunks`.
    // rust: for (range, picked, tooltip, y) in [
    // rust: (
    // rust: config.render_distance.as_ref(),
    // rust: draft.render_distance,
    // rust: "mco.configure.world.renderDistance.tooltip",
    // rust: 126.0,
    // rust: ),
    // rust: (
    // rust: config.sim_distance.as_ref(),
    // rust: draft.simulation_distance,
    // rust: "mco.configure.world.simulationDistance.tooltip",
    // rust: 166.0,
    // rust: ),
    // rust: ] {
    // rust: let Some((range, picked)) = range.zip(picked) else {
    // rust: continue;
}
    // rust: let value = (picked - range.min) as f32
    // rust: / (range.max - range.min) as f32;
                                    // `CommonLayouts.labeledElement`: the caption above, the
                                    // button showing the value alone (`options.chunks`).
    // rust: let text = crate::lang::tr(
    // rust: "options.chunks",
    // rust: &[&picked as &dyn std::fmt::Display],
    // rust: );
                                    // `createDistanceOption`: the button's
                                    // `cachedConstantTooltip`.
    // rust: let hover = crate::ui::hovered(cursor, left, y, 212.0, 20.0);
    // rust: crate::ui::slider(
    // rust: batch,
    // rust: atlas,
    // rust: left,
    // rust: y,
    // rust: 212.0,
    // rust: &Text::literal(&text),
    // rust: value.clamp(0.0, 1.0),
    // rust: hover,
    // rust: saving.is_none(),
    // rust: false,
    // rust: );
    // rust: if hover {
    // rust: crate::ui::tooltip(
    // rust: batch,
    // rust: atlas,
    // rust: &[Text::translate(tooltip, &[])],
    // rust: cursor,
    // rust: );
}
}
    // rust: shift = 80.0;
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.renderDistance"),
    // rust: left,
    // rust: 114.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.simulationDistance"),
    // rust: left,
    // rust: 154.0,
    // rust: GREY,
    // rust: true,
    // rust: );
}
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.region_preference"),
    // rust: left,
    // rust: 114.0 + shift,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: let current =
    // rust: preference_label(draft.preference, draft.region.as_deref());
    // rust: batch.text(atlas, &current, left, 126.0 + shift, GREY, true);
    // rust: if saving.is_some() {
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.loading"),
    // rust: cx,
    // rust: 200.0 + shift,
    // rust: u32::MAX,
    // rust: );
}
    // rust: if regions.is_none() {
                                // The region list is loading: the button says so when clicked.
}
}
    // rust: None => centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.loading"),
    // rust: cx,
    // rust: 60.0,
    // rust: u32::MAX,
    // rust: ),
    // rust: },
}
    // rust: let status = if job.is_some() {
    // rust: Some((
    // rust: t(if server.is_open() {
    // rust: "mco.configure.world.closing"
    // rust: } else {
    // rust: "mco.configure.world.opening"
    // rust: }),
    // rust: u32::MAX,
    // rust: ))
    // rust: } else if deleting.is_some() {
    // rust: Some((t("mco.configure.world.buttons.delete"), u32::MAX))
    // rust: } else {
    // rust: error.clone().map(|e| (e, RED))
}
    // rust: if let Some((text, color)) = status {
    // rust: for (i, line) in wrap_lines(&text, atlas, w - 40.0).iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, h - 60.0 + i as f32 * 10.0, color);
}
}
}
    // rust: SubScreen::RegionPreference {
    // rust: regions, selected, ..
    // rust: } => {
                // `RealmsPreferredRegionSelectionScreen`: the preference rows, then the
                // MANUAL rows per region.
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.region_preference.title"),
    // rust: cx,
    // rust: 14.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let top = 40.0;
    // rust: let rows = region_rows(regions);
    // rust: let left = ((w - 300.0) / 2.0).floor();
    // rust: for (i, (preference, region)) in rows.iter().enumerate() {
    // rust: let y = top + i as f32 * 16.0;
    // rust: let picked = selected
    // rust: .as_ref()
    // rust: .is_some_and(|(p, r)| p == preference && *r == *region);
    // rust: let label = preference_label(*preference, region.as_deref());
    // rust: if picked {
    // rust: batch.fill(atlas, left, y, 300.0, 14.0, 0xFF30_3030);
}
    // rust: batch.text(atlas, &label, left + 5.0, y + 2.0, u32::MAX, true);
}
}
    // rust: SubScreen::SlotOptions {
    // rust: server,
    // rust: slot,
    // rust: name,
    // rust: spawn_protection,
    // rust: error,
    // rust: ..
    // rust: } => {
                // `RealmsSlotOptionsScreen`: the title, the name field (labelled) and
                // the spawn-protection slider; the cycle buttons are widgets.
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.buttons.options"),
    // rust: cx,
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.edit.slot.name"),
    // rust: cx - 154.0,
    // rust: 50.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: caret.draw(
    // rust: batch,
    // rust: atlas,
    // rust: (REALMS_SLOT_NAME, name, 16),
    // rust: [cx - 154.0, 62.0, 152.0, 20.0],
    // rust: true,
    // rust: focused_at,
    // rust: );
    // rust: let normal = server.world_type == "NORMAL";
    // rust: let off = *spawn_protection == 0;
    // rust: let label = crate::lang::tr(
    // rust: "options.generic_value",
    // rust: &[
    // rust: &t("mco.configure.world.spawnProtection"),
    // rust: &if off {
    // rust: t("options.off")
    // rust: } else {
    // rust: spawn_protection.to_string()
    // rust: },
    // rust: ],
    // rust: );
    // rust: let value = *spawn_protection as f32 / 16.0;
    // rust: crate::ui::slider(
    // rust: batch,
    // rust: atlas,
    // rust: cx + 2.0,
    // rust: 118.0,
    // rust: 152.0,
    // rust: &Text::literal(&label),
    // rust: value,
    // rust: crate::ui::hovered(cursor, cx + 2.0, 118.0, 152.0, 20.0),
    // rust: normal && !slot.is_hardcore(),
    // rust: false,
    // rust: );
    // rust: if let Some(e) = error {
    // rust: for (i, line) in wrap_lines(e, atlas, w - 40.0).iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, h - 56.0 + i as f32 * 10.0, RED);
}
}
}
    // rust: SubScreen::Invite {
    // rust: name, job, error, ..
    // rust: } => {
                // `RealmsInviteScreen`: the title, the name field and the message below
                // the Invite button.
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.configure.world.buttons.invite"),
    // rust: cx,
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &t("mco.configure.world.invite.profile.name"),
    // rust: cx - 100.0,
    // rust: 50.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: caret.draw(
    // rust: batch,
    // rust: atlas,
    // rust: (REALMS_PLAYER_NAME, name, 16),
    // rust: [cx - 100.0, 62.0, 200.0, 20.0],
    // rust: true,
    // rust: focused_at,
    // rust: );
    // rust: let status = if job.is_some() {
    // rust: Some((t("mco.configure.world.players.inviting"), u32::MAX))
    // rust: } else {
    // rust: error.clone().map(|e| (e, RED))
}
    // rust: if let Some((text, color)) = status {
    // rust: for (i, line) in wrap_lines(&text, atlas, 200.0).iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, 88.0 + i as f32 * 10.0, color);
}
}
}
    // rust: SubScreen::AddRealm { scroll, content } => {
                // `RealmsPdpScreen`: the Realms header's logo, then the trial header and
                // the three feature rows (an 80x45 picture and 182-wide text), scrolling
                // between the header and the footer.
    // rust: if atlas.sprites.contains_key("gui/title/realms") {
                    // The header's logo, as `draw_main` draws it.
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/title/realms",
    // rust: [cx - 64.0, 5.0, 128.0, 34.0],
    // rust: 128.0,
    // rust: 64.0,
    // rust: );
    // rust: } else {
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.selectServer.purchase"),
    // rust: cx,
    // rust: 14.0,
    // rust: u32::MAX,
    // rust: );
}
    // rust: let (top, bottom) = (44.0, h - 40.0);
    // rust: let rx = ((w - PDP_ROW_WIDTH) / 2.0).floor();
                // `PdpFeatureEntry.entryHeight`: the picture's 45 or the text, plus 16.
    // rust: let mut rows: Vec<(Option<&'static str>, Vec<String>, bool, f32)> = Vec::new();
    // rust: for (image, title, descriptions) in pdp_entries() {
    // rust: let mut lines = wrap_lines(&t(title), atlas, PDP_TEXT_WIDTH);
    // rust: let mut height = lines.len() as f32 * 10.0 + 4.0;
    // rust: for description in descriptions {
    // rust: lines.push(String::new());
    // rust: height += 2.0;
    // rust: let wrapped = wrap_lines(&t(description), atlas, PDP_TEXT_WIDTH);
    // rust: height += wrapped.len() as f32 * 10.0;
    // rust: lines.extend(wrapped);
}
    // rust: let header = image.is_empty();
    // rust: let row = if header {
    // rust: height + 16.0
    // rust: } else {
    // rust: height.max(45.0) + 16.0
}
    // rust: let image = (!image.is_empty()).then_some(image);
    // rust: rows.push((image, lines, header, row));
}
    // rust: let total: f32 = rows.iter().map(|row| row.3).sum();
    // rust: content.set(total);
    // rust: crate::ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: rx + PDP_ROW_WIDTH + 2.0,
    // rust: top,
    // rust: bottom,
    // rust: total,
    // rust: scroll.amount,
    // rust: );
    // rust: let mut y = top - scroll.amount;
    // rust: for (image, lines, header, height) in &rows {
    // rust: if y + height >= top && y <= bottom {
    // rust: if let Some(image) = image {
    // rust: crate::ui::blit_sprite(
    // rust: batch,
    // rust: atlas,
    // rust: image,
    // rust: rx + 4.0,
    // rust: y + 4.0,
    // rust: 80.0,
    // rust: 45.0,
    // rust: u32::MAX,
    // rust: );
}
    // rust: let mut text_y = y + 4.0;
    // rust: for line in lines {
    // rust: if line.is_empty() {
    // rust: text_y += 2.0;
    // rust: continue;
}
    // rust: let x = if *header {
    // rust: cx - (HudBatch::text_width(atlas, line) / 2.0).floor()
    // rust: } else {
    // rust: rx + 100.0
}
    // rust: batch.text(atlas, line, x, text_y, u32::MAX, true);
    // rust: text_y += 10.0;
}
}
    // rust: y += height;
}
}
    // rust: SubScreen::Popup(popup) => {
    // rust: let message = match popup {
    // rust: Popup::Leave(_) => t("mco.configure.world.leave.question.line1"),
    // rust: Popup::ResourcePack { .. } => t("mco.configure.world.resourcepack.question"),
    // rust: Popup::Delete(_) => t("mco.configure.world.delete.question.line1"),
    // rust: Popup::SwitchSlot { .. } => t("mco.configure.world.slot.switch.question.line1"),
    // rust: Popup::Uninvite { player, .. } => crate::lang::tr(
    // rust: "mco.configure.world.uninvite.player",
    // rust: &[&player.name as &dyn std::fmt::Display],
    // rust: ),
}
    // rust: let lines = wrap_lines(&message, atlas, CONTENT_WIDTH);
    // rust: let top = mid - 10.0 - 10.0 * lines.len() as f32;
    // rust: let header = match popup {
    // rust: Popup::Uninvite { .. } => t("mco.question"),
    // rust: _ => t("mco.info"),
}
    // rust: centered(batch, atlas, &header, cx, top - 16.0, INFO);
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, top + i as f32 * 10.0, u32::MAX);
}
}
    // rust: SubScreen::Connecting { error, .. } => {
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.connect.connecting"),
    // rust: cx,
    // rust: mid - 30.0,
    // rust: u32::MAX,
    // rust: );
    // rust: match error {
    // rust: Some(e) => {
    // rust: for (i, line) in wrap_lines(e, atlas, w - 40.0).iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, mid - 10.0 + i as f32 * 10.0, RED);
}
}
    // rust: None => centered(batch, atlas, loading_dots(), cx, mid - 10.0, GREY),
}
}
    // rust: SubScreen::Main => self.draw_main(batch, atlas, w, h),
}
}

draw_main :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, w: f32, h: f32) {
}
    // rust: let cx = (w / 2.0).floor();
    // rust: let mid = (h / 2.0).floor();
    // rust: let t = crate::lang::get;
        // RealmsHeader: the Realms logo.
    // rust: if atlas.sprites.contains_key("gui/title/realms") {
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/title/realms",
    // rust: [cx - 64.0, 5.0, 128.0, 34.0],
    // rust: 128.0,
    // rust: 64.0,
    // rust: );
    // rust: } else {
    // rust: centered(batch, atlas, &t("mco.title"), cx, 12.0, u32::MAX);
}
    // rust: let footer_h = if self.layout_state() == LayoutState::List {
    // rust: 60.0
    // rust: } else {
    // rust: 48.0
}
    // rust: let (top, bottom) = (HEADER_HEIGHT, h - footer_h);
    // rust: crate::ui::list_background(batch, atlas, top, bottom, false);
    // rust: let rx = ((w - ROW_WIDTH) / 2.0).floor();
    // rust: let paragraph = |batch: &mut HudBatch, text: &str, color: u32| {
    // rust: for (i, line) in wrap_lines(text, atlas, CONTENT_WIDTH).iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, mid - 10.0 + i as f32 * 10.0, color);
}
}

    // rust: match &self.state {
    // rust: FetchState::Unauthenticated => {
    // rust: paragraph(batch, &t("horizon.realms.not_signed_in"), GREY)
}
    // rust: FetchState::Loading(_) => {
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: &t("mco.selectServer.loading"),
    // rust: cx,
    // rust: mid - 12.0,
    // rust: u32::MAX,
    // rust: );
    // rust: centered(
    // rust: batch,
    // rust: atlas,
    // rust: loading_dots(),
    // rust: cx,
    // rust: mid + 4.0,
    // rust: rgba(128, 128, 128, 255),
    // rust: );
}
    // rust: FetchState::Error(e) => paragraph(batch, &e.text(), RED),
    // rust: FetchState::Loaded(servers) if servers.is_empty() => {
    // rust: let img_y = mid - 54.0;
    // rust: if atlas.sprites.contains_key("gui/realms/no_realms") {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "gui/realms/no_realms",
    // rust: cx - 65.0,
    // rust: img_y,
    // rust: 130.0,
    // rust: 64.0,
    // rust: u32::MAX,
    // rust: );
}
    // rust: let lines = wrap_lines(&t("mco.selectServer.noRealms"), atlas, CONTENT_WIDTH);
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(batch, atlas, line, cx, img_y + 72.0 + i as f32 * 12.0, GREY);
}
}
    // rust: FetchState::Loaded(servers) => {
    // rust: for (i, server) in servers.iter().enumerate() {
    // rust: let y = top + 2.0 + i as f32 * ROW_HEIGHT;
    // rust: if y + ROW_HEIGHT > bottom {
    // rust: break;
}
    // rust: if self.selected == Some(i) {
    // rust: batch.fill(atlas, rx - 2.0, y - 2.0, ROW_WIDTH, ROW_HEIGHT, u32::MAX);
    // rust: batch.fill(
    // rust: atlas,
    // rust: rx - 1.0,
    // rust: y - 1.0,
    // rust: ROW_WIDTH - 2.0,
    // rust: ROW_HEIGHT - 2.0,
    // rust: rgba(0, 0, 0, 255),
    // rust: );
}
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: "misc/unknown_server",
    // rust: rx + 2.0,
    // rust: y + 2.0,
    // rust: 32.0,
    // rust: 32.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let name_color = if server.is_open() { u32::MAX } else { GREY };
    // rust: batch.text(atlas, &server.name, rx + 38.0, y + 1.0, name_color, true);
    // rust: let second = if server.expired {
    // rust: (t("mco.selectServer.expiredList"), RED)
    // rust: } else {
    // rust: (server.motd.clone(), rgba(128, 128, 128, 255))
}
    // rust: batch.text(atlas, &second.0, rx + 38.0, y + 12.0, second.1, true);
    // rust: batch.text(
    // rust: atlas,
    // rust: server.owner.as_deref().unwrap_or(""),
    // rust: rx + 38.0,
    // rust: y + 23.0,
    // rust: GREY,
    // rust: true,
    // rust: );
    // rust: let light = if server.expired {
    // rust: "gui/sprites/realm_status/expired"
    // rust: } else if server.is_open() {
    // rust: "gui/sprites/realm_status/open"
    // rust: } else {
    // rust: "gui/sprites/realm_status/closed"
}
    // rust: if atlas.sprites.contains_key(light) {
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: light,
    // rust: rx + ROW_WIDTH - 17.0,
    // rust: y + 2.0,
    // rust: 10.0,
    // rust: 28.0,
    // rust: u32::MAX,
    // rust: );
}
}
}
}
}
}

loading_dots :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let millis = SystemTime::now()
    // rust: .duration_since(UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis());
    // rust: ["O o o", "o O o", "o o O", "o O o"][(millis / 300 % 4) as usize]
}

    // rust: mod tests {
//     use super::*;

server :: proc(id: i64, owner_uuid: Maybe(string)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: RealmServer {
    // rust: id,
    // rust: name: "Friends".into(),
    // rust: state: "OPEN".into(),
    // rust: owner_uuid: owner_uuid.map(str::to_owned),
    // rust: active_slot: 1,
    // rust: ..Default::default()
}
}

listed :: proc(servers: [dynamic]RealmServer) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Screen {
    // rust: state: FetchState::Loaded(servers),
    // rust: subscreen: SubScreen::Main,
    // rust: selected: Some(0),
    // rust: joining: None,
    // rust: leaving: None,
    // rust: last_click: None,
}
}

join_addresses_need_a_host_and_a_numeric_port :: proc() {
}
    // rust: for good in [
    // rust: "1.2.3.4:25565",
    // rust: "eu-west.realms.example:30001",
    // rust: "[2001:db8::1]:25565",
    // rust: " a.b:1 ",
    // rust: ] {
    // rust: assert_eq!(
    // rust: connect_address(good).as_deref(),
    // rust: Some(good.trim()),
    // rust: "{good}"
    // rust: );
}
    // rust: for bad in [
    // rust: "",
    // rust: ":25565",
    // rust: "1.2.3.4",
    // rust: "1.2.3.4:",
    // rust: "1.2.3.4:http",
    // rust: "1.2.3.4:65536",
    // rust: "1.2.3.4:0",
    // rust: "1.2.3.4:-1",
    // rust: "https://1.2.3.4:25565",
    // rust: "tcp://host:25565",
    // rust: "user@host:25565",
    // rust: "host/path:25565",
    // rust: "2001:db8::1:25565",
    // rust: "[]:25565",
    // rust: "host name:25565",
    // rust: ] {
    // rust: assert_eq!(connect_address(bad), None, "{bad:?}");
}
}

leave_asks_first_and_cancel_leaves_nothing :: proc() {
}
ME :: 0x0123_4567_89ab_cdef_0123_4567_89ab_cdef
    // rust: let theirs = server(7, Some("fedcba9876543210fedcba9876543210"));
        // Our own Realm: no question, nothing to leave.
    // rust: let mut screen = listed(vec![server(7, Some("0123456789abcdef0123456789abcdef"))]);
    // rust: screen.leave_clicked(Some(ME));
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));

        // Someone else's: the first click only asks.
    // rust: let mut screen = listed(vec![theirs.clone()]);
    // rust: screen.leave_clicked(Some(ME));
    // rust: assert!(matches!(&screen.subscreen, SubScreen::Popup(Popup::Leave(s)) if *s == theirs));
    // rust: assert!(screen.leaving.is_none());
    // rust: let ids: Vec<u8> = screen.buttons(800.0, 600.0).iter().map(|b| b.5).collect();
    // rust: assert_eq!(ids, [50, 51]);

        // Cancel goes back with nothing sent and the Realm still selected.
    // rust: let _ = screen.click(Some(51), 0.0, 0.0, (800.0, 600.0));
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));
    // rust: assert!(screen.leaving.is_none());
    // rust: assert_eq!(screen.selected, Some(0));

        // Escape closes the question too.
    // rust: screen.leave_clicked(Some(ME));
    // rust: assert!(!screen.escape());
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));
    // rust: assert!(screen.leaving.is_none());

        // Signed out: no question at all.
    // rust: screen.leave_clicked(None);
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));
}

the_pack_question_connects_only_after_continue_with_the_pack_queued :: proc() {
}
    // rust: let pack = RealmsPack {
    // rust: address: "9.8.7.6:25565".into(),
    // rust: id: 5,
    // rust: url: "https://packs.test/p.zip".into(),
    // rust: hash: "0".repeat(40),
}
    // rust: let mut screen = listed(vec![]);
    // rust: screen.subscreen = SubScreen::Popup(Popup::ResourcePack { pack: pack.clone() });
    // rust: let _ = screen.click(Some(51), 0.0, 0.0, (800.0, 600.0));
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));

    // rust: screen.subscreen = SubScreen::Popup(Popup::ResourcePack { pack: pack.clone() });
    // rust: let outcome = screen.click(Some(50), 0.0, 0.0, (800.0, 600.0));
    // rust: assert!(matches!(outcome, Outcome::Connect(ref a) if a == "9.8.7.6:25565"));
    // rust: assert_eq!(take_pending_pack("other:1"), None);
        // A taken pack is gone, whatever the address.
    // rust: assert_eq!(take_pending_pack("9.8.7.6:25565"), None);

    // rust: screen.subscreen = SubScreen::Popup(Popup::ResourcePack { pack: pack.clone() });
    // rust: let _ = screen.click(Some(50), 0.0, 0.0, (800.0, 600.0));
    // rust: assert_eq!(take_pending_pack("9.8.7.6:25565"), Some(pack));
}

a_join_answer_becomes_a_checked_connect_or_the_pack_question :: proc() {
}
    // rust: let mut screen = listed(vec![server(7, None)]);
    // rust: let answer = |address: &str, pack: bool| RealmAddress {
    // rust: address: Some(address.into()),
    // rust: resource_pack_url: pack.then(|| "https://packs.test/p.zip".into()),
    // rust: resource_pack_hash: pack.then(|| "ab".repeat(20)),
}
    // rust: let start = |screen: &mut Screen, result: Result<RealmAddress, RealmsError>| {
    // rust: let job = Arc::new(Mutex::new(Some(result)));
    // rust: screen.joining = Some((job, Arc::new(AtomicBool::new(false))));
    // rust: screen.subscreen = SubScreen::Connecting {
    // rust: server: server(7, None),
    // rust: error: None,
}
    // rust: screen.poll()
}
    // rust: assert!(
    // rust: matches!(start(&mut screen, Ok(answer("1.2.3.4:25565", false))), Outcome::Connect(a) if a == "1.2.3.4:25565")
    // rust: );
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));

    // rust: assert!(matches!(
    // rust: start(&mut screen, Ok(answer("http://evil:25565", false))),
    // rust: Outcome::None
    // rust: ));
    // rust: assert!(matches!(
    // rust: screen.subscreen,
    // rust: SubScreen::Connecting { error: Some(_), .. }
    // rust: ));

    // rust: assert!(matches!(
    // rust: start(&mut screen, Ok(answer("1.2.3.4:25565", true))),
    // rust: Outcome::None
    // rust: ));
    // rust: match &screen.subscreen {
    // rust: SubScreen::Popup(Popup::ResourcePack { pack }) => {
    // rust: assert_eq!(pack.address, "1.2.3.4:25565");
    // rust: assert_eq!(pack.id, pack_id(&server(7, None)));
}
    // rust: other => panic!("{other:?}"),
}

    // rust: assert!(matches!(
    // rust: start(&mut screen, Err(RealmsError::Timeout)),
    // rust: Outcome::None
    // rust: ));
    // rust: assert!(matches!(
    // rust: screen.subscreen,
    // rust: SubScreen::Connecting { error: Some(_), .. }
    // rust: ));
}

cancelling_a_join_aborts_its_worker :: proc() {
}
    // rust: let mut screen = listed(vec![server(7, None)]);
    // rust: let aborted = Arc::new(AtomicBool::new(false));
    // rust: screen.joining = Some((Arc::new(Mutex::new(None)), Arc::clone(&aborted)));
    // rust: screen.subscreen = SubScreen::Connecting {
    // rust: server: server(7, None),
    // rust: error: None,
}
    // rust: let _ = screen.click(Some(52), 0.0, 0.0, (800.0, 600.0));
    // rust: assert!(aborted.load(Ordering::Relaxed));
    // rust: assert!(screen.joining.is_none());
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));
}

pack_ids_are_javas_name_uuids :: proc() {
}
        // UUID.nameUUIDFromBytes("realms:Friends:1"): MD5 with the version-3 bits,
        // computed outside Rust.
    // rust: assert_eq!(
    // rust: horizon_protocol::crypto::uuid_string(pack_id(&server(7, None))),
    // rust: "9b833ced-6630-3283-b4a6-778948c32b5f"
    // rust: );
}

without_a_session_nothing_is_requested :: proc() {
}
    // rust: let screen = Screen::new();
    // rust: assert!(matches!(screen.state, FetchState::Unauthenticated));
    // rust: let buttons = screen.buttons(800.0, 600.0);
    // rust: let enabled = |id| buttons.iter().find(|b| b.5 == id).map(|b| b.4);
    // rust: assert_eq!(enabled(14), Some(false), "Join Realm");
    // rust: assert_eq!(enabled(15), Some(false), "invites");
}

    // `RealmsSettingsTab.updateData`: the draft starts from the Realm's own name,
    // description and region preference; a Realm without one is automatic by owner
    // (`RegionSelectionPreferenceDto.DEFAULT`), and only a manual choice sends its region.
the_settings_draft_starts_from_the_realm :: proc() {
}
    // rust: let server: RealmServer = serde_json::from_str(
    // rust: r#"{"id":7,"name":"Mine","motd":"Hello",
    // rust: "regionSelectionPreference":{"regionSelectionPreference":2,"preferredRegion":"EastUs2"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut draft = SettingsDraft::of(&server);
    // rust: assert_eq!(
    // rust: (draft.name.as_str(), draft.description.as_str()),
    // rust: ("Mine", "Hello")
    // rust: );
    // rust: assert_eq!(
    // rust: (draft.preference, draft.region.as_deref()),
    // rust: (2, Some("EastUs2"))
    // rust: );
    // rust: draft.preference = client::AUTOMATIC_PLAYER;
    // rust: assert_eq!(draft.preference_dto().preferred_region, None);
    // rust: let bare = SettingsDraft::of(&RealmServer::default());
    // rust: assert_eq!((bare.preference, bare.region), (1, None));
}

    // `RealmsWorldOptions.getSlotName`: the player's name, else the empty marker, else
    // "World N" by the slot.
a_slot_without_a_name_says_world_n_or_empty :: proc() {
}
    // rust: let options = RealmWorldOptions::default();
    // rust: assert_eq!(
    // rust: slot_name(&options, 3),
    // rust: crate::lang::tr("mco.configure.world.slot", &[&3])
    // rust: );
    // rust: let empty = RealmWorldOptions {
    // rust: empty: true,
    // rust: ..Default::default()
}
    // rust: assert_eq!(
    // rust: slot_name(&empty, 2),
    // rust: crate::lang::get("mco.configure.world.slot.empty")
    // rust: );
    // rust: let named = RealmWorldOptions {
    // rust: slot_name: "Base".into(),
    // rust: ..Default::default()
}
    // rust: assert_eq!(slot_name(&named, 1), "Base");
}

    // `RealmsWorldsTab`: the active slot is 80 square, the others 50, 16 apart, centred.
the_slot_buttons_give_the_active_slot_eighty_pixels :: proc() {
}
    // rust: let boxes = slot_boxes(427.0, 2);
        // 80 + 50*3 + 16*3 = 278 wide, centred on 427 starts at 74.
    // rust: assert_eq!(boxes[0], (74.0, 50.0, 1));
    // rust: assert_eq!(boxes[1].0, 140.0);
    // rust: assert_eq!(boxes[1].1, 80.0);
    // rust: assert_eq!(boxes[1].2, 2);
    // rust: assert_eq!(boxes[3].1, 50.0);
}

    // `RealmsInviteScreen.onInvite`: a blank name and one already invited are refused
    // before any request.
inviting_an_empty_or_duplicate_name_asks_nothing :: proc() {
}
    // rust: let mut screen = Screen {
    // rust: state: FetchState::Loaded(vec![server(7, None)]),
    // rust: subscreen: SubScreen::Invite {
    // rust: server: server(7, None),
    // rust: players: vec![PlayerInfo {
    // rust: name: "Alex".into(),
    // rust: uuid: Some("01234567-89ab-cdef-0123-456789abcdef".into()),
    // rust: ..Default::default()
    // rust: }],
    // rust: name: "  ".into(),
    // rust: job: None,
    // rust: error: None,
    // rust: },
    // rust: selected: Some(0),
    // rust: joining: None,
    // rust: leaving: None,
    // rust: last_click: None,
}
    // rust: screen.invite_clicked();
    // rust: let SubScreen::Invite { error, job, .. } = &screen.subscreen else {
    // rust: panic!("still the invite screen");
}
    // rust: assert!(job.is_none(), "a blank name asks the service nothing");
    // rust: assert_eq!(
    // rust: error.as_deref(),
    // rust: Some(crate::lang::get("mco.configure.world.players.error").as_str())
    // rust: );

    // rust: if let SubScreen::Invite { name, error, .. } = &mut screen.subscreen {
    // rust: *name = "ALEX".into();
    // rust: *error = None;
}
    // rust: screen.invite_clicked();
    // rust: let SubScreen::Invite { error, job, .. } = &screen.subscreen else {
    // rust: panic!("still the invite screen");
}
    // rust: assert!(job.is_none(), "a duplicate name asks the service nothing");
    // rust: assert_eq!(
    // rust: error.as_deref(),
    // rust: Some(crate::lang::get("mco.configure.world.players.invite.duplicate").as_str())
    // rust: );
}

join_realm_button_navigates_to_join_code_screen :: proc() {
}
    // rust: let mut screen = listed(vec![]);
    // rust: let _ = screen.click(Some(14), 0.0, 0.0, (800.0, 600.0));
    // rust: assert!(matches!(screen.subscreen, SubScreen::JoinCode { .. }));
    // rust: let btns = screen.buttons(800.0, 600.0);
    // rust: let join_btn = btns.iter().find(|b| b.5 == 20).expect("Join button exists");
    // rust: assert!(!join_btn.4, "Join is off while the code is empty");
    // rust: assert!(!screen.escape());
    // rust: assert!(matches!(screen.subscreen, SubScreen::Main));
}

    // `RealmsConfigureWorldScreen`'s `MenuTabBar`: Worlds, Players, Subscription,
    // Settings, and an expired Realm's settings tab is off.
configure_tabs_follow_the_vanilla_order_and_expiry :: proc() {
}
    // rust: assert_eq!(
    // rust: ConfigureTab::ALL,
    // rust: [
    // rust: ConfigureTab::Worlds,
    // rust: ConfigureTab::Players,
    // rust: ConfigureTab::Subscription,
    // rust: ConfigureTab::Settings,
    // rust: ]
    // rust: );
    // rust: for tab in ConfigureTab::ALL {
    // rust: assert!(tab.enabled(false), "{}", tab.title());
}
    // rust: assert!(!ConfigureTab::Settings.enabled(true));
    // rust: for tab in [
    // rust: ConfigureTab::Worlds,
    // rust: ConfigureTab::Players,
    // rust: ConfigureTab::Subscription,
    // rust: ] {
    // rust: assert!(tab.enabled(true), "{}", tab.title());
}
}

    // `MenuTabBar.builder(this, width)`: at most 400 wide, centred, four even tabs.
the_tab_bar_is_centred_and_four_tabs_wide :: proc() {
}
        // 854x480 at GUI scale 2 is 427x240: 372 inner width, 28 from the left, 94 a tab.
    // rust: assert_eq!(tab_geometry(427.0), (28.0, 94.0));
        // A window narrower than 400 keeps its own width less the bar's margins:
        // 272 inner width over four tabs, 14 from the left.
    // rust: assert_eq!(tab_geometry(300.0), (14.0, 68.0));
}

    // `RealmsWorldsTab`'s four slot buttons: the active slot is 80 square, the others 50,
    // spaced 16 and centred (`GridLayout.spacing(16)`).
slot_boxes :: proc(w: f32, active_slot: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let sizes: [f32; 4] = std::array::from_fn(|i| {
    // rust: if i as i32 + 1 == active_slot {
    // rust: 80.0
    // rust: } else {
    // rust: 50.0
}
    // rust: });
    // rust: let total: f32 = sizes.iter().sum::<f32>() + 16.0 * 3.0;
    // rust: let mut x = ((w - total) / 2.0).floor();
    // rust: std::array::from_fn(|i| {
    // rust: let at = (x, sizes[i], i as i32 + 1);
    // rust: x += sizes[i] + 16.0;
    // rust: at
    // rust: })
}

    // `RealmsWorldOptions.getSlotName`: the player's own name, else the empty marker, else
    // "World N" by the slot's number.
slot_name :: proc(options: ^RealmWorldOptions, slot: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if !options.slot_name.trim().is_empty() {
    // rust: return options.slot_name.clone();
}
    // rust: if options.empty {
    // rust: return crate::lang::get("mco.configure.world.slot.empty");
}
    // rust: crate::lang::tr("mco.configure.world.slot", &[&slot])
}

    // `RealmsSubscriptionTab.daysLeftPresentation`, compared with the same translations
    // so the check reads in any language.
days_left_says_what_vanilla_says :: proc() {
}
    // rust: let t = crate::lang::get;
    // rust: assert_eq!(
    // rust: days_left_text(-1, true),
    // rust: t("mco.configure.world.subscription.expired")
    // rust: );
    // rust: let less = t("mco.configure.world.subscription.less_than_a_day");
    // rust: assert_eq!(days_left_text(0, false), less);
    // rust: assert_eq!(days_left_text(1, false), less);
    // rust: assert_eq!(
    // rust: days_left_text(45, false),
    // rust: crate::lang::tr(
    // rust: "mco.configure.world.subscription.remaining.months.days",
    // rust: &[&1, &15]
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: days_left_text(60, false),
    // rust: crate::lang::tr("mco.configure.world.subscription.remaining.months", &[&2])
    // rust: );
    // rust: assert_eq!(
    // rust: days_left_text(5, false),
    // rust: crate::lang::tr("mco.configure.world.subscription.remaining.days", &[&5])
    // rust: );
        // An expired Realm still shows its remaining time while it has some.
    // rust: assert_eq!(
    // rust: days_left_text(60, true),
    // rust: crate::lang::tr("mco.configure.world.subscription.remaining.months", &[&2])
    // rust: );
}

    // An unreadable start date says nothing rather than a wrong date.
an_unreadable_start_date_is_empty :: proc() {
}
    // rust: assert_eq!(start_date_text(i64::MAX), "");
}
    // `RealmsSettingsTab.save`: only a distance the player changed, and only when the tier
    // answer names the range, is sent.
a_distance_is_saved_only_when_it_differs_from_the_service :: proc() {
}
    // rust: let range = RealmTierRange {
    // rust: min: 2,
    // rust: max: 16,
    // rust: default_value: 8,
    // rust: current: Some(10),
}
    // rust: assert_eq!(changed_distance(Some(10), Some(&range)), None);
    // rust: assert_eq!(changed_distance(Some(12), Some(&range)), Some(12));
        // No tier answer: the slider was never usable, so nothing goes out.
    // rust: assert_eq!(changed_distance(Some(12), None), None);
    // rust: assert_eq!(changed_distance(None, Some(&range)), None);
        // A range without `current` compares against its default (`currentOrDefault`).
    // rust: let default = RealmTierRange {
    // rust: current: None,
    // rust: ..range
}
    // rust: assert_eq!(changed_distance(Some(8), Some(&default)), None);
    // rust: assert_eq!(changed_distance(Some(9), Some(&default)), Some(9));
}
}
