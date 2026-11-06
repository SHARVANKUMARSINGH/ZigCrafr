//! Transpiled from Horizon Rust crate
package horizon_client_client

import "core:fmt"
import "core:mem"
import "core:math"

// The Realms service client: vanilla's `com.mojang.realmsclient.client.RealmsClient` and its
// `Request`, for the signed-in player's own Microsoft account only. Every request carries
// what `RealmsClient.execute` adds and nothing more: the `sid`, `user` and `version` cookies
// and the three version headers. The access token goes only into the `sid` cookie (and the
// `x-mojangauth` header vanilla adds for the invite-code service); it is never logged, never
// put in an error and never sent anywhere else.
// use horizon_core::version;
// use serde::{Deserialize, Deserializer, Serialize};
// use std::time::Duration;

// `RealmsClient.Environment.PRODUCTION`'s base URL.
DEFAULT_REALMS_HOST :: "https://pc.realms.minecraft.net"
// `RealmsClient.Environment.PRODUCTION`'s `frontendV2Url` (invite codes).
DEFAULT_FRONTEND_V2_HOST :: "https://java.frontend.realms.minecraft-services.net"

// `Request.DEFAULT_CONNECT_TIMEOUT`.
CONNECT_TIMEOUT :: Duration::from_secs(5)
// `Request.DEFAULT_READ_TIMEOUT`.
READ_TIMEOUT :: Duration::from_secs(60)
// `RealmsClient.join`: `Request.get(url, 5000, 30000)`.
JOIN_READ_TIMEOUT :: Duration::from_secs(30)

// Vanilla sets no user agent: `HttpURLConnection` sends the JVM's own, `Java/<version>`.
user_agent :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("Java/{}", version::JAVA_VERSION)
}

// Gson leaves a field at its default when the JSON has `null`; serde would fail.
    // rust: fn nullable<'de, D: Deserializer<'de>, T: Default + Deserialize<'de>>(d: D) -> Result<T, D::Error> {
    // rust: Ok(Option::<T>::deserialize(d)?.unwrap_or_default())
}

// `RealmsServer`: the fields the screens read.
RealmServer :: struct {
    id: i64,
    remote_subscription_id: Maybe(string),
    name: string,
    motd: string,
    state: string,
    owner: Maybe(string),
    owner_uuid: Maybe(string),
    expired: bool,
    expired_trial: bool,
    days_left: i32,
    world_type: string,
    active_slot: i32,
    minigame_name: Maybe(string),
    minigame_id: Maybe(i32),
    minigame_image: Maybe(string),
    // The invited players: only in the detail answer (`RealmsClient.getOwnRealm`).
    players: [dynamic]PlayerInfo,
    // The world slots by id: only in the detail answer too (`RealmsServer.slots`).
    slots: std::collections::HashMap<i32,
    // The settings tab's region preference (`RealmsServer.regionSelectionPreference`).
    region_selection_preference: Maybe(RegionSelectionPreferenceDto),
}

// `PlayerInfo`: a Realm's invited player.
PlayerInfo :: struct {
    name: string,
    uuid: Maybe(string),
    operator: bool,
    accepted: bool,
    online: bool,
}

// `Ops`: the Realm's operators, by name (`RealmsClient.op`/`deop`).
Ops :: struct {
    ops: [dynamic]string,
}

// `RealmsSetting`: a slot's named setting (the hardcore marker).
RealmSetting :: struct {
    name: string,
    value: string,
}

// `RealmsSlot`: one of the Realm's world slots.
RealmSlot :: struct {
    slot_id: i32,
    options: RealmWorldOptions,
    settings: [dynamic]RealmSetting,
}

// `RealmsServer.finalizeSlots`: the JSON's `slots` list (`slotList`) by slot id, each slot's
// options a JSON string of their own (`RealmsSlot.RealmsWorldOptionsJsonAdapter`), and the
// world slots 1 to 3 it lacks empty (`RealmsSlot.defaults`).
    // rust: fn slots<'de, D: Deserializer<'de>>(
    // rust: d: D,
    // rust: ) -> Result<std::collections::HashMap<i32, RealmSlot>, D::Error> {
Raw :: struct {
    slot_id: i32,
    options: Maybe(string),
    settings: [dynamic]RealmSetting,
}
    // rust: let list: Vec<Raw> = nullable(d)?;
    // rust: let mut slots = empty_slots();
    // rust: for raw in list {
        // `RealmsWorldOptions.parse`: the defaults when the string is missing or not JSON.
    // rust: let options = raw
    // rust: .options
    // rust: .and_then(|o| serde_json::from_str(&o).ok())
    // rust: .unwrap_or_default();
    // rust: slots.insert(
    // rust: raw.slot_id,
    // rust: RealmSlot {
    // rust: slot_id: raw.slot_id,
    // rust: options,
    // rust: settings: raw.settings,
    // rust: },
    // rust: );
}
    // rust: Ok(slots)
}

// `RealmsSlot.defaults` for world slots 1 to 3: empty, not hardcore.
empty_slots :: proc() -> s {
    // Ported from Horizon
    return {}
}
    // rust: (1..=3)
    // rust: .map(|slot_id| {
    // rust: let slot = RealmSlot {
    // rust: slot_id,
    // rust: options: RealmWorldOptions {
    // rust: empty: true,
    // rust: ..Default::default()
    // rust: },
    // rust: settings: Vec::new(),
}
    // rust: (slot_id, slot)
    // rust: })
    // rust: .collect()
}

    // rust: impl RealmSlot {
    // `RealmsSlot.isHardcore`: `RealmsSetting.isHardcore` of the settings.
is_hardcore :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.settings
    // rust: .iter()
    // rust: .any(|s| s.name == "hardcore" && s.value == "true")
}
}

// `RegionSelectionPreference`'s ids, as `RegionSelectionPreferenceJsonAdapter` writes them.
AUTOMATIC_PLAYER :: 0
AUTOMATIC_OWNER :: 1
MANUAL :: 2

// `RegionSelectionPreferenceDto`: how the Realm picks its region. The preference travels
// as its id ([`AUTOMATIC_PLAYER`], [`AUTOMATIC_OWNER`], [`MANUAL`]) and the region as its
// `RealmsRegion.nameId` (`EastUs2`).
RegionSelectionPreferenceDto :: struct {
    // `RegionSelectionPreferenceDto.DEFAULT`'s when the service sends none.
    region_selection_preference: i32,
    preferred_region: Maybe(string),
}

automatic_owner :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: AUTOMATIC_OWNER
}

// `RegionSelectionPreferenceJsonAdapter.read`: an id it does not know (or null) is
// `DEFAULT_SELECTION`, automatic by player.
    // rust: fn preference_id<'de, D: Deserializer<'de>>(d: D) -> Result<i32, D::Error> {
    // rust: Ok(Option::<i32>::deserialize(d)?
    // rust: .filter(|id| (AUTOMATIC_PLAYER..=MANUAL).contains(id))
    // rust: .unwrap_or(AUTOMATIC_PLAYER))
}

// `RegionDataDto`: one region's service quality, from `preferredRegions`.
RegionDataDto :: struct {
    // `RealmsRegion.nameId`.
    region: string,
    // `ServiceQuality.value`: 1 great to 4 poor, 5 unknown.
    service_quality: i32,
}

// `PreferredRegionsDto`.
PreferredRegionsResponse :: struct {
    region_data: [dynamic]RegionDataDto,
}

// `RealmTierConfigurationDto`: the Realm tier's two distance ranges.
RealmTierConfiguration :: struct {
    render_distance: Maybe(RealmTierRange),
    sim_distance: Maybe(RealmTierRange),
}

// `RealmTierConfigurationDto.RealmTierRangeDto`: the values a slot's distance may take.
RealmTierRange :: struct {
    min: i32,
    max: i32,
    default_value: i32,
    current: Maybe(i32),
}

    // rust: impl RealmTierRange {
    // `RealmsSettingsTab.currentOrDefault`.
current_or_default :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.current.unwrap_or(self.default_value)
}

    // `OptionInstance.IntRange`: a slider position to a value in the range.
from_slider :: proc(self: ^Self, value: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min + (value * (self.max - self.min) as f32).round() as i32
}
}

// `RealmsRegion`: each region's `nameId` and its translation key.
region_translation_key :: proc(name_id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: const REGIONS: [(&str, &str); 27] = [
    // rust: (
    // rust: "AustraliaEast",
    // rust: "realms.configuration.region.australia_east",
    // rust: ),
    // rust: (
    // rust: "AustraliaSoutheast",
    // rust: "realms.configuration.region.australia_southeast",
    // rust: ),
    // rust: ("BrazilSouth", "realms.configuration.region.brazil_south"),
    // rust: (
    // rust: "CanadaCentral",
    // rust: "realms.configuration.region.canada_central",
    // rust: ),
    // rust: ("CentralIndia", "realms.configuration.region.central_india"),
    // rust: ("CentralUs", "realms.configuration.region.central_us"),
    // rust: ("EastAsia", "realms.configuration.region.east_asia"),
    // rust: ("EastUs", "realms.configuration.region.east_us"),
    // rust: ("EastUs2", "realms.configuration.region.east_us_2"),
    // rust: (
    // rust: "FranceCentral",
    // rust: "realms.configuration.region.france_central",
    // rust: ),
    // rust: ("JapanEast", "realms.configuration.region.japan_east"),
    // rust: ("JapanWest", "realms.configuration.region.japan_west"),
    // rust: ("KoreaCentral", "realms.configuration.region.korea_central"),
    // rust: (
    // rust: "MexicoCentral",
    // rust: "realms.configuration.region.mexico_central",
    // rust: ),
    // rust: (
    // rust: "NorthCentralUs",
    // rust: "realms.configuration.region.north_central_us",
    // rust: ),
    // rust: ("NorthEurope", "realms.configuration.region.north_europe"),
    // rust: (
    // rust: "SouthCentralUs",
    // rust: "realms.configuration.region.south_central_us",
    // rust: ),
    // rust: (
    // rust: "SoutheastAsia",
    // rust: "realms.configuration.region.southeast_asia",
    // rust: ),
    // rust: (
    // rust: "SouthAfricaNorth",
    // rust: "realms.configuration.region.south_africa_north",
    // rust: ),
    // rust: (
    // rust: "SwedenCentral",
    // rust: "realms.configuration.region.sweden_central",
    // rust: ),
    // rust: ("UAENorth", "realms.configuration.region.uae_north"),
    // rust: ("UKSouth", "realms.configuration.region.uk_south"),
    // rust: (
    // rust: "WestCentralUs",
    // rust: "realms.configuration.region.west_central_us",
    // rust: ),
    // rust: ("WestEurope", "realms.configuration.region.west_europe"),
    // rust: ("WestUs", "realms.configuration.region.west_us"),
    // rust: ("WestUs2", "realms.configuration.region.west_us_2"),
    // rust: ("WestUs3", "realms.configuration.region.west_us_3"),
    // rust: ];
    // rust: REGIONS
    // rust: .iter()
    // rust: .find(|(id, _)| *id == name_id)
    // rust: .map(|(_, key)| *key)
}

// `RealmsSlotUpdateDto`'s JSON for `slot`.
slot_update :: proc(slot: ^RealmSlot) -> s {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::json!({
    // rust: "slotId": slot.slot_id,
    // rust: "spawnProtection": slot.options.spawn_protection,
    // rust: "forceGameMode": slot.options.force_game_mode,
    // rust: "difficulty": slot.options.difficulty,
    // rust: "gameMode": slot.options.game_mode,
    // rust: "slotName": slot.options.slot_name,
    // rust: "version": slot.options.version,
    // rust: "compatibility": slot.options.compatibility,
    // rust: "worldTemplateId": slot.options.template_id,
    // rust: "worldTemplateImage": slot.options.template_image,
    // rust: "hardcore": slot.is_hardcore(),
    // rust: })
}

// `RealmsConfigurationDto`'s JSON.
    // rust: fn configuration_body(
    // rust: name: &str,
    // rust: description: &str,
    // rust: preference: &RegionSelectionPreferenceDto,
    // rust: slot: &RealmSlot,
    // rust: ) -> serde_json::Value {
    // rust: serde_json::json!({
    // rust: "options": slot_update(slot),
    // rust: "settings": slot.settings,
    // rust: "regionSelectionPreference": {
    // rust: "regionSelectionPreference": preference.region_selection_preference,
    // rust: "preferredRegion": preference.preferred_region,
    // rust: },
    // rust: "description": { "name": name, "description": description },
    // rust: })
}

// `RealmsWorldOptions`: a slot's options. Fields the JSON lacks keep the values of its
// constructor (`Default`); `empty` is never in the JSON (`RealmsSlot.defaults` sets it).
RealmWorldOptions :: struct {
    spawn_protection: i32,
    force_game_mode: bool,
    difficulty: i32,
    game_mode: i32,
    slot_name: string,
    version: string,
    compatibility: string,
    template_id: i64,
    template_image: Maybe(string),
    empty: bool,
}

    // rust: impl Default for RealmWorldOptions {
    // `new RealmsWorldOptions()`: normal difficulty, no template.
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: spawn_protection: 0,
    // rust: force_game_mode: false,
    // rust: difficulty: 2,
    // rust: game_mode: 0,
    // rust: slot_name: String::new(),
    // rust: version: String::new(),
    // rust: compatibility: "UNVERIFIABLE".into(),
    // rust: template_id: -1,
    // rust: template_image: None,
    // rust: empty: false,
}
}
}

    // rust: impl RealmServer {
    // `RealmsServer.State.OPEN` and not expired: the Play button's condition.
is_open :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.state.eq_ignore_ascii_case("OPEN") && !self.expired
}
    // `Minecraft.isLocalPlayer(server.ownerUUID)`.
owned_by :: proc(self: ^Self, uuid: u128) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.owner_uuid
    // rust: .as_deref()
    // rust: .and_then(horizon_client_render::auth::parse_uuid)
    // rust: == Some(uuid)
}
}

RealmServerList :: struct {
    servers: [dynamic]RealmServer,
}

// `RealmsJoinInformation`: where to connect, and the world's resource pack.
RealmAddress :: struct {
    address: Maybe(string),
    resource_pack_url: Maybe(string),
    resource_pack_hash: Maybe(string),
}

// `PendingInvite`.
PendingInviteDto :: struct {
    invitation_id: string,
    world_name: string,
    world_owner_name: string,
    world_owner_uuid: Maybe(string),
    date: i64,
}

PendingInvitesResponse :: struct {
    invites: [dynamic]PendingInviteDto,
}

// `Subscription`: the realm's own, as `RealmsClient.subscriptionFor` reads it.
Subscription :: struct {
    // `Subscription.startDate`: epoch milliseconds.
    start_date: i64,
    days_left: i32,
    // `Subscription.SubscriptionType`: `NORMAL` or `RECURRING`.
    kind: string,
}

// Why a Realms call failed (`RealmsServiceException` and its `RealmsError`). None of them
// holds a request header: the text a screen shows can't contain the token.
RealmsError :: enum {
    // `CustomError.connectivityError`: no answer (the transport error, which names the URL).
    Connectivity(String),
    // `AuthenticationError`: a 401, with its `WWW-Authenticate` header.
    Authentication(String),
    // `RetryCallException`: 503 or 277, with the `Retry-After` seconds (5 when missing).
    Retry(u64),
    // `RealmsError.parse`: any other answer, with the body's `errorCode`, `reason` and
    // `errorMsg` (or the raw body).
    Service {,
    status: u16,
    code: Option<i32>,
    reason: Option<String>,
    message: Option<String>,
    // rust: },
    // An answer whose JSON doesn't read.
    Parse,
    // `GetServerDetailsTask`'s `TimeoutException`: still busy after 40 tries.
    Timeout,
}

    // rust: impl RealmsError {
    // `RealmsError.errorCode`.
code :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Connectivity(_) => 500,
    // rust: Self::Authentication(_) => 401,
    // rust: Self::Retry(_) => 503,
    // rust: Self::Service { status, code, .. } => code.unwrap_or(i32::from(*status)),
    // rust: Self::Parse | Self::Timeout => 500,
}
}
    // `RealmsError.errorMessage`, as `RealmsGenericErrorScreen` shows it after the
    // `mco.errorMessage.realmsService.realmsError` line.
text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let no_details = || crate::lang::get("mco.errorMessage.noDetails");
    // rust: let detail = match self {
    // rust: Self::Connectivity(e) => crate::lang::tr(
    // rust: "mco.errorMessage.realmsService.connectivity",
    // rust: &[e as &dyn std::fmt::Display],
    // rust: ),
    // rust: Self::Authentication(header) if !header.is_empty() => header.clone(),
    // rust: Self::Authentication(_) => no_details(),
    // rust: Self::Retry(_) => crate::lang::get("mco.errorMessage.retry"),
    // rust: Self::Service { status: 429, .. } => crate::lang::get("mco.errorMessage.serviceBusy"),
    // rust: Self::Service {
    // rust: code,
    // rust: reason,
    // rust: message,
    // rust: ..
    // rust: } => {
    // rust: let code_key = code.map(|c| format!("mco.errorMessage.{c}"));
    // rust: let reason_key = reason.as_ref().map(|r| format!("mco.errorReason.{r}"));
    // rust: match (code_key, reason_key) {
    // rust: (Some(k), _) if crate::lang::has(&k) => crate::lang::get(&k),
    // rust: (_, Some(k)) if crate::lang::has(&k) => crate::lang::get(&k),
    // rust: _ => message.clone().unwrap_or_else(no_details),
}
}
    // rust: Self::Parse | Self::Timeout => crate::lang::get("mco.errorMessage.connectionFailure"),
}
    // rust: let code = self.code();
    // rust: format!(
    // rust: "{} {detail}",
    // rust: crate::lang::tr(
    // rust: "mco.errorMessage.realmsService.realmsError",
    // rust: &[&code as &dyn std::fmt::Display]
    // rust: )
    // rust: )
}
    // `RealmsError.parse` of a non-2xx answer.
from_answer :: proc(status: u16, body: string, html: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let body = body.trim();
    // rust: let service = |code, reason, message| Self::Service {
    // rust: status,
    // rust: code,
    // rust: reason,
    // rust: message,
}
    // rust: if status == 429 || body.is_empty() {
    // rust: return service(None, None, None);
}
    // rust: if html {
            // CustomError.htmlPayload: the text between <body> and </body>.
    // rust: let inner = body
    // rust: .find("<body>")
    // rust: .zip(body.find("</body>"))
    // rust: .filter(|(a, b)| b > a)
    // rust: .map(|(a, b)| body[a + 6..b].trim().to_owned());
    // rust: return service(None, None, inner);
}
    // rust: if let Ok(serde_json::Value::Object(o)) = serde_json::from_str::<serde_json::Value>(body) {
    // rust: let text = |k: &str| o.get(k).and_then(|v| v.as_str()).map(str::to_owned);
    // rust: let code = o
    // rust: .get("errorCode")
    // rust: .and_then(serde_json::Value::as_i64)
    // rust: .and_then(|c| i32::try_from(c).ok());
    // rust: let (reason, message) = (text("reason"), text("errorMsg"));
    // rust: if code.is_some() || reason.is_some() || message.is_some() {
    // rust: return service(code, reason, message);
}
}
        // ErrorWithRawPayload.
    // rust: service(None, None, Some(body.chars().take(256).collect()))
}
}

// The client for one signed-in account.
RealmsClient :: struct {
    base_url: string,
    frontend_url: string,
    player_name: string,
    player_uuid: u128,
    access_token: string,
}

    // rust: impl std::fmt::Debug for RealmsClient {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("RealmsClient")
    // rust: .field("base_url", &self.base_url)
    // rust: .field("player_name", &self.player_name)
    // rust: .field("access_token", &"<hidden>")
    // rust: .finish()
}
}

    // rust: impl RealmsClient {
    // rust: pub fn new(
    // rust: base_url: &str,
    // rust: frontend_url: &str,
    // rust: session: &horizon_client_render::auth::AuthSession,
    // rust: ) -> Self {
    // rust: Self {
    // rust: base_url: base_url.trim_end_matches('/').to_owned(),
    // rust: frontend_url: frontend_url.trim_end_matches('/').to_owned(),
    // rust: player_name: session.name.clone(),
    // rust: player_uuid: session.uuid,
    // rust: access_token: session.access_token().to_owned(),
}
}
    // The production service.
production :: proc(session: ^horizon_client_render::auth::AuthSession) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(DEFAULT_REALMS_HOST, DEFAULT_FRONTEND_V2_HOST, session)
}

    // `RealmsClient.execute`'s cookies (`User.getSessionId`, `getName`,
    // `WorldVersion.name()`) and `Request.addVersionHeaders`, in that order.
headers :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec![
    // rust: (
    // rust: "Cookie",
    // rust: format!(
    // rust: "sid=token:{}:{:032x};user={};version={}",
    // rust: self.access_token,
    // rust: self.player_uuid,
    // rust: self.player_name,
    // rust: version::VANILLA_VERSION
    // rust: ),
    // rust: ),
    // rust: ("Client-Ref", version::VERSION_ID.to_owned()),
    // rust: (
    // rust: "X-NetworkProtocolVersion",
    // rust: version::PROTOCOL_VERSION.to_string(),
    // rust: ),
    // rust: ("Is-Prerelease", (!version::STABLE).to_string()),
    // rust: ]
}

request :: proc(self: ^Self, method: string, url: string, read_timeout: Duration) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let agent = ureq::AgentBuilder::new()
    // rust: .timeout_connect(CONNECT_TIMEOUT)
    // rust: .timeout_read(read_timeout)
    // rust: .user_agent(&user_agent())
            // A redirect must not carry the session cookie to another host.
    // rust: .redirects(0)
    // rust: .build();
    // rust: self.headers()
    // rust: .into_iter()
    // rust: .fold(agent.request(method, url), |r, (k, v)| r.set(k, &v))
}

    // `RealmsClient.execute`: the body of a 2xx answer, else the error.
execute :: proc(request: ureq::Request, body: Maybe(string)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let result = match body {
    // rust: Some(body) => request.send_string(body),
    // rust: None => request.call(),
}
    // rust: let response = match result {
    // rust: Ok(response) => response,
    // rust: Err(ureq::Error::Status(_, response)) => response,
            // The transport error names the URL and the cause, never a header.
    // rust: Err(ureq::Error::Transport(e)) => return Err(RealmsError::Connectivity(e.to_string())),
}
    // rust: let status = response.status();
    // rust: if status == 503 || status == 277 {
    // rust: let pause = response
    // rust: .header("Retry-After")
    // rust: .and_then(|s| s.trim().parse().ok())
    // rust: .unwrap_or(5);
    // rust: return Err(RealmsError::Retry(pause));
}
    // rust: let auth =
    // rust: (status == 401).then(|| response.header("WWW-Authenticate").unwrap_or("").to_owned());
    // rust: let html = response.content_type().starts_with("text/html");
    // rust: let text = response
    // rust: .into_string()
    // rust: .map_err(|e| RealmsError::Connectivity(e.to_string()))?;
    // rust: if (200..300).contains(&status) {
    // rust: return Ok(text);
}
    // rust: if let Some(header) = auth {
    // rust: return Err(RealmsError::Authentication(header));
}
    // rust: Err(RealmsError::from_answer(status, &text, html))
}

url :: proc(self: ^Self, path: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{}/{path}", self.base_url)
}

    // `RealmsClient.listRealms` (a release client: no `listUserWorldsOfType`).
list_worlds :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json = Self::execute(self.request("GET", &self.url("worlds"), READ_TIMEOUT), None)?;
    // rust: serde_json::from_str::<RealmServerList>(&json)
    // rust: .map(|l| l.servers)
    // rust: .map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.join`: `worlds/v1/<id>/join/pc`.
join_world :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/v1/{realm_id}/join/pc"));
    // rust: let json = Self::execute(self.request("GET", &url, JOIN_READ_TIMEOUT), None)?;
    // rust: serde_json::from_str(&json).map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.pendingInvites`.
pending_invites :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json = Self::execute(
    // rust: self.request("GET", &self.url("invites/pending"), READ_TIMEOUT),
    // rust: None,
    // rust: )?;
    // rust: serde_json::from_str::<PendingInvitesResponse>(&json)
    // rust: .map(|r| r.invites)
    // rust: .map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.acceptInvitation`.
accept_invite :: proc(self: ^Self, invitation_id: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("invites/accept/{}", path_segment(invitation_id)?));
    // rust: Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some("")).map(drop)
}

    // `RealmsClient.rejectInvitation`.
reject_invite :: proc(self: ^Self, invitation_id: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("invites/reject/{}", path_segment(invitation_id)?));
    // rust: Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some("")).map(drop)
}

    // `RealmsClient.uninviteMyselfFrom`: leaves someone else's Realm.
uninvite_myself :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("invites/{realm_id}"));
    // rust: Self::execute(self.request("DELETE", &url, READ_TIMEOUT), None).map(drop)
}

    // `RealmsClient.open`.
open_realm :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/open"));
    // rust: Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some("")).map(drop)
}

    // `RealmsClient.close`.
close_realm :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/close"));
    // rust: Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some("")).map(drop)
}

    // `RealmsClient.subscriptionFor`: the configuration screen's subscription tab.
subscription_for :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/subscription"));
    // rust: let json = Self::execute(self.request("GET", &url, READ_TIMEOUT), None)?;
    // rust: serde_json::from_str(&json).map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.deleteRealm` (`Request.delete`).
delete_realm :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}"));
    // rust: Self::execute(self.request("DELETE", &url, READ_TIMEOUT), None).map(drop)
}

    // `RealmsClient.getOwnRealm`: the detail answer with the slots and the players.
get_own_realm :: proc(self: ^Self, realm_id: i64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}"));
    // rust: let json = Self::execute(self.request("GET", &url, READ_TIMEOUT), None)?;
    // rust: serde_json::from_str(&json).map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.op`: `POST worlds/{id}/{uuid}` with an empty body, then the ops.
op_player :: proc(self: ^Self, realm_id: i64, uuid: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/{}", undashed(uuid)?));
    // rust: let json = Self::execute(self.request("POST", &url, READ_TIMEOUT), Some(""))?;
    // rust: serde_json::from_str(&json).map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.deop`: `DELETE worlds/{id}/{uuid}`, then the ops.
deop_player :: proc(self: ^Self, realm_id: i64, uuid: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/{}", undashed(uuid)?));
    // rust: let json = Self::execute(self.request("DELETE", &url, READ_TIMEOUT), None)?;
    // rust: serde_json::from_str(&json).map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.invite`: `POST worlds/{id}` with the player's name, then the players.
invite_player :: proc(self: ^Self, realm_id: i64, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let body = serde_json::json!({"name": name}).to_string();
    // rust: let url = self.url(&format!("worlds/{realm_id}"));
    // rust: let json = Self::execute(self.request("POST", &url, READ_TIMEOUT), Some(&body))?;
    // rust: serde_json::from_str::<Vec<PlayerInfo>>(&json).map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.uninvite`: `DELETE worlds/{id}/invite/{uuid}`.
uninvite_player :: proc(self: ^Self, realm_id: i64, uuid: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/invite/{}", undashed(uuid)?));
    // rust: Self::execute(self.request("DELETE", &url, READ_TIMEOUT), None).map(drop)
}

    // `RealmsClient.updateSlot`: `POST worlds/{id}/slot/{slotId}` with
    // `RealmsSlotUpdateDto`'s JSON.
update_slot :: proc(self: ^Self, realm_id: i64, slot: ^RealmSlot) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let body = slot_update(slot).to_string();
    // rust: let url = self.url(&format!("worlds/{realm_id}/slot/{}", slot.slot_id));
    // rust: Self::execute(self.request("POST", &url, READ_TIMEOUT), Some(&body)).map(drop)
}

    // `RealmsClient.switchSlot`: `PUT worlds/{id}/slot/{slotId}`, the service's yes or no.
switch_slot :: proc(self: ^Self, realm_id: i64, slot_id: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let url = self.url(&format!("worlds/{realm_id}/slot/{slot_id}"));
    // rust: let json = Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some(""))?;
    // rust: json.trim().parse::<bool>().map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.getPreferredRegionSelections`: every region and its quality.
preferred_regions :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json = Self::execute(
    // rust: self.request("GET", &self.url("regions/preferredRegions"), READ_TIMEOUT),
    // rust: None,
    // rust: )?;
    // rust: serde_json::from_str::<PreferredRegionsResponse>(&json)
    // rust: .map(|r| r.region_data)
    // rust: .map_err(|_| RealmsError::Parse)
}

    // `RealmsClient.updateConfiguration`: `POST worlds/{id}/configuration` with
    // `RealmsConfigurationDto`'s JSON: the active slot's `RealmsSlotUpdateDto` as `options`,
    // its settings, the region preference (its id and the region's `nameId`) and the
    // name and description.
    // rust: pub fn update_configuration(
    // rust: &self,
    // rust: realm_id: i64,
    // rust: name: &str,
    // rust: description: &str,
    // rust: preference: &RegionSelectionPreferenceDto,
    // rust: slot: &RealmSlot,
    // rust: ) -> Result<(), RealmsError> {
    // rust: let body = configuration_body(name, description, preference, slot).to_string();
    // rust: let url = self.url(&format!("worlds/{realm_id}/configuration"));
    // rust: Self::execute(self.request("POST", &url, READ_TIMEOUT), Some(&body)).map(drop)
}

    // `RealmsClient.getRealmTierConfiguration`: `GET worlds/{id}/configuration/tier`. A range
    // the answer lacks is a configuration error, as `getRealmTierConfiguration`'s parse makes it.
    // rust: pub fn get_tier_configuration(
    // rust: &self,
    // rust: realm_id: i64,
    // rust: ) -> Result<RealmTierConfiguration, RealmsError> {
    // rust: let url = self.url(&format!("worlds/{realm_id}/configuration/tier"));
    // rust: let json = Self::execute(self.request("GET", &url, READ_TIMEOUT), None)?;
    // rust: let tier: RealmTierConfiguration =
    // rust: serde_json::from_str(&json).map_err(|_| RealmsError::Parse)?;
    // rust: if tier.render_distance.is_some() && tier.sim_distance.is_some() {
    // rust: Ok(tier)
    // rust: } else {
    // rust: Err(RealmsError::Parse)
}
}

    // `RealmsClient.updateRenderDistance`: `PUT worlds/{id}/configuration/renderDistance/{n}`.
    // rust: pub fn update_render_distance(
    // rust: &self,
    // rust: realm_id: i64,
    // rust: render_distance: i32,
    // rust: ) -> Result<(), RealmsError> {
    // rust: let url = self.url(&format!(
    // rust: "worlds/{realm_id}/configuration/renderDistance/{render_distance}"
    // rust: ));
    // rust: Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some("")).map(drop)
}

    // `RealmsClient.updateSimulationDistance`: `PUT worlds/{id}/configuration/simDistance/{n}`.
    // rust: pub fn update_simulation_distance(
    // rust: &self,
    // rust: realm_id: i64,
    // rust: simulation_distance: i32,
    // rust: ) -> Result<(), RealmsError> {
    // rust: let url = self.url(&format!(
    // rust: "worlds/{realm_id}/configuration/simDistance/{simulation_distance}"
    // rust: ));
    // rust: Self::execute(self.request("PUT", &url, READ_TIMEOUT), Some("")).map(drop)
}

    // `RealmsClient.redeemInviteCode`: the invite-code service, with the token in
    // `x-mojangauth` as `frontendV2Request` sets it.
redeem_invite_code :: proc(self: ^Self, code: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let code = path_segment(code.trim())?;
    // rust: let url = format!("{}/api/v1.0/invite/codes/use/{code}", self.frontend_url);
    // rust: let request = self
    // rust: .request("POST", &url, READ_TIMEOUT)
    // rust: .set("x-mojangauth", &self.access_token)
    // rust: .set("Accept", "application/json");
    // rust: Self::execute(request, Some("")).map(drop)
}
}

// An id or code that goes into a URL path: vanilla builds those URLs from the server's own
// ids; anything else (a typed code with `/` or `?`) would reach another path.
path_segment :: proc(s: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !s.is_empty()
    // rust: && s.bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b == b'-' || b == b'_')
    // rust: {
    // rust: Ok(s)
    // rust: } else {
    // rust: Err(RealmsError::Service {
    // rust: status: 400,
    // rust: code: None,
    // rust: reason: None,
    // rust: message: Some(crate::lang::get("mco.selectServer.joinCode.invalid")),
    // rust: })
}
}

// `UndashedUuid.toString`: a player's UUID as 32 hex digits, the op/deop/uninvite path
// segment. Anything else (a name with a `/`, a shortened id) would reach another path.
undashed :: proc(uuid: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let hex: String = uuid.chars().filter(|c| *c != '-').collect();
    // rust: if hex.len() == 32 && hex.chars().all(|c| c.is_ascii_hexdigit()) {
    // rust: Ok(hex)
    // rust: } else {
    // rust: Err(RealmsError::Parse)
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client_render::auth::AuthSession;
//     use std::io::{Read, Write};

TOKEN :: "eyJsecret.token.value"
UUID :: 0x0123_4567_89ab_cdef_0123_4567_89ab_cdef

    // One HTTP exchange on a local port: the request as the server read it.
serve_once :: proc(answer: ^'static str) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let base = format!("http://{}", listener.local_addr().unwrap());
    // rust: let handle = std::thread::spawn(move || {
    // rust: let (mut stream, _) = listener.accept().unwrap();
    // rust: let mut seen = Vec::new();
    // rust: let mut buf = [0u8; 4096];
    // rust: while !seen.windows(4).any(|w| w == b"\r\n\r\n") {
    // rust: let n = stream.read(&mut buf).unwrap();
    // rust: if n == 0 {
    // rust: break;
}
    // rust: seen.extend_from_slice(&buf[..n]);
}
            // The body the headers announce, which may come in a later read.
    // rust: let head = seen
    // rust: .windows(4)
    // rust: .position(|w| w == b"\r\n\r\n")
    // rust: .map_or(seen.len(), |i| i + 4);
    // rust: let length = String::from_utf8_lossy(&seen[..head])
    // rust: .lines()
    // rust: .find_map(|l| {
    // rust: let (k, v) = l.split_once(':')?;
    // rust: k.eq_ignore_ascii_case("content-length")
    // rust: .then(|| v.trim().parse().ok())?
    // rust: })
    // rust: .unwrap_or(0usize);
    // rust: while seen.len() < head + length {
    // rust: let n = stream.read(&mut buf).unwrap();
    // rust: if n == 0 {
    // rust: break;
}
    // rust: seen.extend_from_slice(&buf[..n]);
}
    // rust: stream.write_all(answer.as_bytes()).unwrap();
    // rust: String::from_utf8_lossy(&seen).into_owned()
    // rust: });
    // rust: (base, handle)
}

client :: proc(base: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: RealmsClient::new(base, base, &AuthSession::new("Steve", UUID, TOKEN))
}

    // rust: fn header<'a>(request: &'a str, name: &str) -> Option<&'a str> {
    // rust: request.lines().find_map(|l| {
    // rust: let (k, v) = l.split_once(':')?;
    // rust: k.eq_ignore_ascii_case(name).then(|| v.trim())
    // rust: })
}

requests_send_the_session_cookie_only_and_errors_never_hold_the_token :: proc() {
}
    // rust: let (base, server) = serve_once(
    // rust: "HTTP/1.1 401 Unauthorized\r\nWWW-Authenticate: Bearer realm=\"Realms\"\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    // rust: );
    // rust: let error = client(&base).list_worlds().unwrap_err();
    // rust: let request = server.join().unwrap();
    // rust: assert!(request.starts_with("GET /worlds HTTP/1.1"), "{request}");
        // RealmsClient.execute: sid = User.getSessionId (token:<token>:<undashed uuid>), user, version.
    // rust: assert_eq!(
    // rust: header(&request, "Cookie"),
    // rust: Some(
    // rust: "sid=token:eyJsecret.token.value:0123456789abcdef0123456789abcdef;user=Steve;version=26.3"
    // rust: )
    // rust: );
    // rust: assert_eq!(header(&request, "Authorization"), None, "{request}");
    // rust: assert_eq!(header(&request, "Client-Ref"), Some("26.3"));
    // rust: assert_eq!(header(&request, "X-NetworkProtocolVersion"), Some("777"));
    // rust: assert_eq!(header(&request, "Is-Prerelease"), Some("false"));
    // rust: assert_eq!(header(&request, "User-Agent"), Some("Java/25"));
        // The token appears once in the whole request: in the cookie.
    // rust: assert_eq!(request.matches(TOKEN).count(), 1);
    // rust: assert_eq!(
    // rust: error,
    // rust: RealmsError::Authentication("Bearer realm=\"Realms\"".into())
    // rust: );
    // rust: assert!(!error.text().contains(TOKEN));
    // rust: assert!(!format!("{error:?}").contains(TOKEN));
    // rust: assert!(!format!("{:?}", client(&base)).contains(TOKEN));
}

a_refused_connection_names_no_header :: proc() {
}
        // A port nothing listens on: the transport error.
    // rust: let port = std::net::TcpListener::bind("127.0.0.1:0")
    // rust: .unwrap()
    // rust: .local_addr()
    // rust: .unwrap()
    // rust: .port();
    // rust: let error = client(&format!("http://127.0.0.1:{port}"))
    // rust: .join_world(7)
    // rust: .unwrap_err();
    // rust: assert!(matches!(error, RealmsError::Connectivity(_)), "{error:?}");
    // rust: assert!(!error.text().contains(TOKEN));
}

busy_answers_ask_for_a_retry_after_their_delay :: proc() {
}
    // rust: let (base, server) = serve_once(
    // rust: "HTTP/1.1 503 Service Unavailable\r\nRetry-After: 3\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
    // rust: );
    // rust: assert_eq!(client(&base).join_world(7), Err(RealmsError::Retry(3)));
    // rust: assert!(
    // rust: server
    // rust: .join()
    // rust: .unwrap()
    // rust: .starts_with("GET /worlds/v1/7/join/pc ")
    // rust: );
}

the_join_answer_reads_vanillas_field_names :: proc() {
}
    // rust: let (base, server) = serve_once(
    // rust: "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nConnection: close\r\n\r\n{\"address\":\"1.2.3.4:25565\",\"resourcePackUrl\":\"https://x.test/p.zip\",\"resourcePackHash\":\"abc\",\"sessionRegionData\":null}",
    // rust: );
    // rust: let address = client(&base).join_world(42).unwrap();
    // rust: server.join().unwrap();
    // rust: assert_eq!(
    // rust: address,
    // rust: RealmAddress {
    // rust: address: Some("1.2.3.4:25565".into()),
    // rust: resource_pack_url: Some("https://x.test/p.zip".into()),
    // rust: resource_pack_hash: Some("abc".into()),
}
    // rust: );
}

an_invite_code_with_a_path_in_it_is_refused_before_any_request :: proc() {
}
        // Nothing listens: a request would fail as Connectivity, not as the invalid code.
    // rust: let error = client("http://127.0.0.1:9")
    // rust: .redeem_invite_code("abc/../worlds")
    // rust: .unwrap_err();
    // rust: assert!(
    // rust: matches!(error, RealmsError::Service { status: 400, .. }),
    // rust: "{error:?}"
    // rust: );
}

server_list_reads_camel_case_and_nulls :: proc() {
}
    // rust: let raw = r#"{"servers":[{"id":12345,"remoteSubscriptionId":"sub","name":"Test Realm",
    // rust: "motd":null,"state":"OPEN","owner":"Alex","ownerUUID":"0123456789abcdef0123456789abcdef",
    // rust: "daysLeft":25,"expired":false,"expiredTrial":false,"worldType":"NORMAL","activeSlot":2,
    // rust: "minigameName":null}]}"#;
    // rust: let list: RealmServerList = serde_json::from_str(raw).unwrap();
    // rust: let server = &list.servers[0];
    // rust: assert_eq!(
    // rust: (server.id, server.days_left, server.active_slot),
    // rust: (12345, 25, 2)
    // rust: );
    // rust: assert_eq!(server.motd, "");
    // rust: assert!(server.is_open());
    // rust: assert!(server.owned_by(UUID));
    // rust: assert!(!server.owned_by(UUID + 1));
}

    // `RealmsServer.slots` as the detail answer carries them (`slotList`): a list whose
    // options are a JSON string each, read as `RealmsWorldOptions.parse` reads them, and the
    // world slots it lacks empty (`finalizeSlots`).
the_detail_answer_s_slot_list_reads_its_options_strings :: proc() {
}
    // rust: let raw = r#"{"id":7,"name":"Base","activeSlot":1,"slots":[
    // rust: {"slotId":1,"options":"{\"slotName\":\"Spawn\",\"difficulty\":3,\"gameMode\":1,\"spawnProtection\":4,\"worldTemplateId\":42,\"worldTemplateImage\":null}",
    // rust: "settings":[{"name":"hardcore","value":"true"}]},
    // rust: {"slotId":2,"options":"{}","settings":[]}]}"#;
    // rust: let server: RealmServer = serde_json::from_str(raw).unwrap();
    // rust: let one = &server.slots[&1];
    // rust: assert_eq!(
    // rust: (
    // rust: one.options.slot_name.as_str(),
    // rust: one.options.difficulty,
    // rust: one.options.game_mode,
    // rust: one.options.spawn_protection,
    // rust: one.options.template_id,
    // rust: ),
    // rust: ("Spawn", 3, 1, 4, 42)
    // rust: );
    // rust: assert!(one.is_hardcore() && !one.options.empty);
        // `new RealmsWorldOptions()` for what the string leaves out.
    // rust: let two = &server.slots[&2].options;
    // rust: assert_eq!((two.difficulty, two.template_id, two.empty), (2, -1, false));
    // rust: assert!(server.slots[&3].options.empty);
    // rust: assert_eq!(server.slots.len(), 3);
        // The list answer has no slots: the empty world slots still.
    // rust: let listed: RealmServer = serde_json::from_str(r#"{"id":7,"slots":null}"#).unwrap();
    // rust: assert!(listed.slots.values().all(|s| s.options.empty));
}

error_bodies_read_as_vanilla_parses_them :: proc() {
}
    // rust: assert_eq!(
    // rust: RealmsError::from_answer(403, r#"{"errorCode":6002,"errorMsg":"tos"}"#, false),
    // rust: RealmsError::Service {
    // rust: status: 403,
    // rust: code: Some(6002),
    // rust: reason: None,
    // rust: message: Some("tos".into())
}
    // rust: );
    // rust: assert_eq!(
    // rust: RealmsError::from_answer(500, r#"{"errorCode":6006}"#, false).code(),
    // rust: 6006
    // rust: );
    // rust: assert_eq!(
    // rust: RealmsError::from_answer(502, "<html><body> Bad gateway </body></html>", true),
    // rust: RealmsError::Service {
    // rust: status: 502,
    // rust: code: None,
    // rust: reason: None,
    // rust: message: Some("Bad gateway".into())
}
    // rust: );
    // rust: assert_eq!(RealmsError::from_answer(404, "", false).code(), 404);
}

    // `RealmsClient.updateConfiguration`'s request as gson writes `RealmsConfigurationDto`:
    // the slot under `options`, the preference as its id and the region as its `nameId`.
a_configuration_update_posts_the_vanilla_dto :: proc() {
}
    // rust: let (base, server) =
    // rust: serve_once("HTTP/1.1 204 No Content\r\nContent-Length: 0\r\nConnection: close\r\n\r\n");
    // rust: let detail: RealmServer = serde_json::from_str(
    // rust: r#"{"id":7,"activeSlot":1,"slots":[{"slotId":1,
    // rust: "options":"{\"slotName\":\"Spawn\",\"worldTemplateId\":42}",
    // rust: "settings":[{"name":"hardcore","value":"false"}]}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let preference = RegionSelectionPreferenceDto {
    // rust: region_selection_preference: MANUAL,
    // rust: preferred_region: Some("UKSouth".into()),
}
    // rust: client(&base)
    // rust: .update_configuration(7, "Base", "Hi", &preference, &detail.slots[&1])
    // rust: .unwrap();
    // rust: let request = server.join().unwrap();
    // rust: assert!(
    // rust: request.starts_with("POST /worlds/7/configuration HTTP/1.1"),
    // rust: "{request}"
    // rust: );
    // rust: let body: serde_json::Value =
    // rust: serde_json::from_str(request.split("\r\n\r\n").nth(1).unwrap()).unwrap();
    // rust: assert_eq!(body["options"]["slotId"], 1);
    // rust: assert_eq!(body["options"]["slotName"], "Spawn");
    // rust: assert_eq!(body["options"]["worldTemplateId"], 42);
    // rust: assert_eq!(
    // rust: body["settings"],
    // rust: serde_json::json!([{"name": "hardcore", "value": "false"}])
    // rust: );
    // rust: assert_eq!(
    // rust: body["regionSelectionPreference"],
    // rust: serde_json::json!({"regionSelectionPreference": 2, "preferredRegion": "UKSouth"})
    // rust: );
    // rust: assert_eq!(
    // rust: body["description"],
    // rust: serde_json::json!({"name": "Base", "description": "Hi"})
    // rust: );
}

    // `PreferredRegionsDto`: `regionDataList`, each region by `regionName` with its
    // `ServiceQuality` value; and a Realm's preference as its id.
preferred_regions_and_the_realm_s_preference_read_as_vanilla_writes_them :: proc() {
}
    // rust: let regions: PreferredRegionsResponse = serde_json::from_str(
    // rust: r#"{"regionDataList":[{"regionName":"EastUs2","serviceQuality":1},
    // rust: {"regionName":"WestEurope","serviceQuality":4}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: regions.region_data,
    // rust: vec![
    // rust: RegionDataDto {
    // rust: region: "EastUs2".into(),
    // rust: service_quality: 1
    // rust: },
    // rust: RegionDataDto {
    // rust: region: "WestEurope".into(),
    // rust: service_quality: 4
    // rust: },
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: region_translation_key("EastUs2"),
    // rust: Some("realms.configuration.region.east_us_2")
    // rust: );
    // rust: let server: RealmServer = serde_json::from_str(
    // rust: r#"{"id":7,"regionSelectionPreference":{"regionSelectionPreference":1,"preferredRegion":null}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: server.region_selection_preference,
    // rust: Some(RegionSelectionPreferenceDto {
    // rust: region_selection_preference: AUTOMATIC_OWNER,
    // rust: preferred_region: None,
    // rust: })
    // rust: );
}
the_tier_configuration_names_both_ranges_and_their_default :: proc() {
}
    // rust: let body = r#"{"renderDistance":{"min":2,"max":16,"defaultValue":8,"current":12},"simDistance":{"min":3,"max":12,"defaultValue":6,"current":null}}"#;
    // rust: let answer: &'static str = Box::leak(
    // rust: format!(
    // rust: "HTTP/1.1 200 OK\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
    // rust: body.len()
    // rust: )
    // rust: .into_boxed_str(),
    // rust: );
    // rust: let (base, server) = serve_once(answer);
    // rust: let tier = client(&base).get_tier_configuration(7).unwrap();
    // rust: let request = server.join().unwrap();
    // rust: assert!(
    // rust: request.starts_with("GET /worlds/7/configuration/tier HTTP/1.1"),
    // rust: "{request}"
    // rust: );
        // `currentOrDefault`: the current value, else the default.
    // rust: assert_eq!(tier.render_distance.unwrap().current_or_default(), 12);
    // rust: let sim = tier.sim_distance.unwrap();
    // rust: assert_eq!(sim.current_or_default(), 6);
    // rust: assert_eq!((sim.min, sim.max), (3, 12));
        // `getRealmTierConfiguration`: a range it cannot read is a parse error.
    // rust: let short: &'static str = Box::leak(
    // rust: format!(
    // rust: "HTTP/1.1 200 OK\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{{\"renderDistance\":{{\"min\":2,\"max\":16}}}}",
    // rust: "{\"renderDistance\":{\"min\":2,\"max\":16}}".len()
    // rust: )
    // rust: .into_boxed_str(),
    // rust: );
    // rust: let (base, server) = serve_once(short);
    // rust: assert!(client(&base).get_tier_configuration(7).is_err());
    // rust: server.join().unwrap();
}

a_distance_update_puts_its_value_into_the_path :: proc() {
}
    // rust: for (realm, distance, path) in [
    // rust: (
    // rust: 7,
    // rust: 8,
    // rust: "PUT /worlds/7/configuration/renderDistance/8 HTTP/1.1",
    // rust: ),
    // rust: (12, 3, "PUT /worlds/12/configuration/simDistance/3 HTTP/1.1"),
    // rust: ] {
    // rust: let (base, server) =
    // rust: serve_once("HTTP/1.1 200 OK\r\nContent-Length: 0\r\nConnection: close\r\n\r\n");
    // rust: if path.contains("renderDistance") {
    // rust: client(&base)
    // rust: .update_render_distance(realm, distance)
    // rust: .unwrap();
    // rust: } else {
    // rust: client(&base)
    // rust: .update_simulation_distance(realm, distance)
    // rust: .unwrap();
}
    // rust: let request = server.join().unwrap();
    // rust: assert!(request.starts_with(path), "{request}");
}
}

a_slider_position_maps_into_the_range :: proc() {
}
        // `OptionInstance.IntRange` with min 2, max 16: the ends and the middle snap.
    // rust: let range = RealmTierRange {
    // rust: min: 2,
    // rust: max: 16,
    // rust: default_value: 8,
    // rust: current: None,
}
    // rust: assert_eq!(range.from_slider(0.0), 2);
    // rust: assert_eq!(range.from_slider(1.0), 16);
    // rust: assert_eq!(range.from_slider(0.5), 9);
    // rust: assert_eq!(range.current_or_default(), 8);
}
}
