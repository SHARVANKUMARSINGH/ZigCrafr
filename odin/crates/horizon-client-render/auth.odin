//! Transpiled from Horizon Rust crate
package horizon_client_render_auth

import "core:fmt"
import "core:mem"
import "core:math"

// The Microsoft account the launcher signed in, handed over in a session
// file (docs/microsoft-account.md), and the Minecraft services call
// online-mode servers need: authlib's MinecraftServicesSessionService.joinServer
// through the services discovery document. The access token stays in this
// process's memory: it is never logged, printed or written anywhere.
// use std::{
    // rust: path::Path,
    // rust: sync::{Arc, Mutex, OnceLock},
    // rust: time::{Duration, SystemTime},
}

// MinecraftServicesEnvironment.PROD.
DEFAULT_DISCOVERY :: "https://discovery.minecraftservices.com/minecraft/client"
// A session file older than this is refused: it can't be replayed later.
MAX_SESSION_FILE_AGE :: Duration::from_secs(120)

// A signed-in account (vanilla's User with type msa).
AuthSession :: struct {
    name: string,
    uuid: u128,
    xuid: Maybe(string),
    access_token: string,
}
    // rust: impl std::fmt::Debug for AuthSession {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("AuthSession")
    // rust: .field("name", &self.name)
    // rust: .field("uuid", &horizon_protocol::crypto::uuid_string(self.uuid))
    // rust: .field("access_token", &"<hidden>")
    // rust: .finish()
}
}

// A UUID with or without dashes.
parse_uuid :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let hex: String = text.chars().filter(|c| *c != '-').collect();
    // rust: (hex.len() == 32)
    // rust: .then(|| u128::from_str_radix(&hex, 16).ok())
    // rust: .flatten()
}

    // rust: impl AuthSession {
    // For tests and harnesses.
new :: proc(name: string, uuid: u128, access_token: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: uuid,
    // rust: xuid: None,
    // rust: access_token: access_token.to_owned(),
}
}

access_token :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.access_token
}
    // The session file's JSON: {"name", "uuid", "access_token", "user_type": "msa", "xuid"}.
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v: serde_json::Value =
    // rust: serde_json::from_str(text).map_err(|_| "the session is not valid JSON")?;
    // rust: let field = |k: &str| v.get(k).and_then(|s| s.as_str());
    // rust: let name = field("name").ok_or("the session has no name")?;
    // rust: if name.is_empty() || name.chars().count() > 16 {
    // rust: return Err("the session's name is not a valid player name".into());
}
    // rust: let uuid = field("uuid")
    // rust: .and_then(parse_uuid)
    // rust: .ok_or("the session has no valid uuid")?;
    // rust: let access_token = field("access_token")
    // rust: .filter(|t| !t.is_empty())
    // rust: .ok_or("the session has no access token")?;
    // rust: if field("user_type").is_some_and(|t| t != "msa") {
    // rust: return Err("the session is not a Microsoft account session".into());
}
    // rust: Ok(Self {
    // rust: name: name.to_owned(),
    // rust: uuid,
    // rust: xuid: field("xuid").map(str::to_owned),
    // rust: access_token: access_token.to_owned(),
    // rust: })
}
    // Read the session file the launcher wrote and delete it at once. It
    // must be fresh and, on Unix, readable by its owner only.
load :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let meta = std::fs::metadata(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let refuse = |why: &str| {
    // rust: let _ = std::fs::remove_file(path);
    // rust: Err(format!("{}: {why}", path.display()))
}
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: if meta.permissions().mode() & 0o077 != 0 {
    // rust: return refuse("other users can read it");
}
}
    // rust: let age = meta
    // rust: .modified()
    // rust: .ok()
    // rust: .and_then(|m| SystemTime::now().duration_since(m).ok())
    // rust: .unwrap_or_default();
    // rust: if age > MAX_SESSION_FILE_AGE {
    // rust: return refuse("it is too old (start the game from the launcher)");
}
    // rust: let text = std::fs::read_to_string(path);
    // rust: let _ = std::fs::remove_file(path);
    // rust: Self::parse(&text.map_err(|e| format!("{}: {e}", path.display()))?)
}
    // The access token's expiry (its JWT `exp`) has passed, or is a minute away: the session
    // service would refuse it. A token that doesn't read as a JWT counts as good: the server
    // says.
expired :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let exp = self
    // rust: .access_token
    // rust: .split('.')
    // rust: .nth(1)
    // rust: .and_then(|p| crate::skins::base64_decode(&p.replace('-', "+").replace('_', "/")))
    // rust: .and_then(|json| serde_json::from_slice::<serde_json::Value>(&json).ok())
    // rust: .and_then(|v| v.get("exp")?.as_u64());
    // rust: let now = SystemTime::now()
    // rust: .duration_since(SystemTime::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs());
    // rust: exp.is_some_and(|exp| exp <= now + 60)
}
}

CURRENT :: OnceLock::new()

// The account this game was started with (set once at start).
set_current :: proc(session: AuthSession) {
}
    // rust: let _ = CURRENT.set(Arc::new(session));
}
current :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: CURRENT.get().cloned()
}

// Why joining a server through the session service failed, like the
// AuthenticationException subclasses authlib throws.
JoinError :: enum {
    // No answer, or a 5xx (AuthenticationUnavailableException).
    Unavailable,
    // 401 or ForbiddenOperationException (InvalidCredentialsException).
    InvalidSession,
    // InsufficientPrivilegesException: multiplayer is off for the account.
    InsufficientPrivileges,
    // multiplayer.access.banned or FORCED_USERNAME_CHANGE.
    Banned,
    // Anything else, with the service's message.
    Other(String),
}
    // rust: impl JoinError {
    // MinecraftClientHttpException.toAuthenticationException.
from_response :: proc(status: u16, body: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let v: serde_json::Value = serde_json::from_str(body).unwrap_or_default();
    // rust: let error = v.get("error").and_then(|e| e.as_str()).unwrap_or("");
    // rust: match error {
    // rust: "ForbiddenOperationException" => return Self::InvalidSession,
    // rust: "multiplayer.access.banned" | "FORCED_USERNAME_CHANGE" => return Self::Banned,
    // rust: "InsufficientPrivilegesException" => return Self::InsufficientPrivileges,
    // rust: _ => {}
}
    // rust: match status {
    // rust: 401 => Self::InvalidSession,
    // rust: 500.. => Self::Unavailable,
    // rust: _ => Self::Other(
    // rust: v.get("errorMessage")
    // rust: .and_then(|m| m.as_str())
    // rust: .map_or_else(|| format!("Status: {status}"), str::to_owned),
    // rust: ),
}
}
    // ClientHandshakePacketListenerImpl.authenticateServer's message: the
    // key of the reason inside "disconnect.loginFailedInfo", or its text.
reason :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Unavailable => Ok("disconnect.loginFailedInfo.serversUnavailable"),
    // rust: Self::InvalidSession => Ok("disconnect.loginFailedInfo.invalidSession"),
    // rust: Self::InsufficientPrivileges => Ok("disconnect.loginFailedInfo.insufficientPrivileges"),
    // rust: Self::Banned => Ok("disconnect.loginFailedInfo.userBanned"),
    // rust: Self::Other(message) => Err(message),
}
}
}

// The services discovery document URL: `HORIZON_API_DISCOVERY` overrides
// it like authlib's `-Dminecraft.api.discovery.host`.
discovery_url :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: std::env::var("HORIZON_API_DISCOVERY")
    // rust: .ok()
    // rust: .filter(|u| !u.is_empty())
    // rust: .unwrap_or_else(|| DEFAULT_DISCOVERY.to_owned())
}

agent :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(15))
    // rust: .user_agent(&format!("Horizon/{}", horizon_core::release::VERSION))
    // rust: .build()
}

// The discovery document, fetched once per game (a failure is retried next time).
    // rust: pub(crate) fn discovery() -> Result<Arc<serde_json::Value>, JoinError> {
CACHE :: Mutex::new(None)
    // rust: if let Some(d) = CACHE.lock().unwrap().clone() {
    // rust: return Ok(d);
}
    // rust: let doc: serde_json::Value = agent()
    // rust: .get(&discovery_url())
    // rust: .call()
    // rust: .inspect_err(|e| log::warn!("The services discovery document: {e}"))
    // rust: .ok()
    // rust: .and_then(|r| r.into_string().ok())
    // rust: .and_then(|t| serde_json::from_str(&t).ok())
    // rust: .ok_or(JoinError::Unavailable)?;
    // rust: let doc = Arc::new(doc);
    // rust: *CACHE.lock().unwrap() = Some(doc.clone());
    // rust: Ok(doc)
}

// MinecraftServicesDiscoveryService.getUrl(service, endpoint).
endpoint :: proc(doc: ^serde_json::Value, service: string, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: doc.pointer(&format!("/discovery/{service}/endpoints/{name}/uri"))
    // rust: .and_then(|u| u.as_str())
    // rust: .map(str::to_owned)
}

// `Minecraft`'s constructor futures for the title screen: `UserApiService.fetchProperties`
// (the `player` service's `getAttributes`, with the bearer token) and
// `SessionService.fetchProfile(uuid, true)` (`getProfileById`). A failed
// attributes call falls back to the offline properties, a failed profile call
// to no actions, as vanilla does. Blocks: call it off the main thread.
fetch_account_status :: proc(session: ^AuthSession) -> c {
    // Ported from Horizon
    return {}
}
//     use crate::ban_notice::{AccountStatus, parse_profile_actions, parse_properties};
    // rust: let Ok(doc) = discovery() else {
    // rust: return AccountStatus::default();
}
    // rust: let properties = endpoint(&doc, "player", "getAttributes")
    // rust: .and_then(|url| {
    // rust: agent()
    // rust: .get(&url)
    // rust: .set("Authorization", &format!("Bearer {}", session.access_token))
    // rust: .call()
    // rust: .ok()?
    // rust: .into_string()
    // rust: .ok()
    // rust: })
    // rust: .and_then(|body| parse_properties(&body))
    // rust: .unwrap_or_default();
    // rust: let actions = endpoint(&doc, "session", "getProfileById")
    // rust: .and_then(|url| {
    // rust: let url = url.replace("{profileId}", &format!("{:032x}", session.uuid));
    // rust: agent()
    // rust: .get(&format!("{url}?unsigned=true"))
    // rust: .call()
    // rust: .ok()?
    // rust: .into_string()
    // rust: .ok()
    // rust: })
    // rust: .map(|body| parse_profile_actions(&body))
    // rust: .unwrap_or_default();
    // rust: AccountStatus {
    // rust: properties,
    // rust: actions,
}
}

// The JoinMinecraftServerRequest body; `selectedProfile` is the undashed UUID.
join_request :: proc(session: ^AuthSession, server_hash: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::json!({
    // rust: "accessToken": session.access_token,
    // rust: "selectedProfile": format!("{:032x}", session.uuid),
    // rust: "serverId": server_hash,
    // rust: })
    // rust: .to_string()
}

// A join that got no answer is worth one more try, as leaving and joining
// again would be: `join` is safe to repeat, it only records the server's
// hash. Any other answer is the service's own and stands.
    // rust: fn with_one_retry(
    // rust: mut join: impl FnMut() -> Result<(), JoinError>,
    // rust: pause: Duration,
    // rust: ) -> Result<(), JoinError> {
    // rust: match join() {
    // rust: Err(JoinError::Unavailable) => {
    // rust: std::thread::sleep(pause);
    // rust: join()
}
    // rust: result => result,
}
}

// MinecraftServicesSessionService.joinServer: tell the session service this
// account is joining the server whose hash is `server_hash`. Horizon tries
// twice when the service doesn't answer; vanilla asks the player to.
join_server :: proc(session: ^AuthSession, server_hash: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: with_one_retry(
    // rust: || join_server_once(session, server_hash),
    // rust: Duration::from_millis(500),
    // rust: )
}

join_server_once :: proc(session: ^AuthSession, server_hash: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let doc = discovery()?;
    // rust: let url = endpoint(&doc, "session", "join").ok_or(JoinError::Unavailable)?;
    // rust: match agent()
    // rust: .post(&url)
    // rust: .set("Content-Type", "application/json; charset=utf-8")
    // rust: .send_string(&join_request(session, server_hash))
    // rust: {
    // rust: Ok(_) => Ok(()),
    // rust: Err(ureq::Error::Status(status, response)) => {
    // rust: if status >= 500 {
    // rust: log::warn!("The session service's join answered {status}");
}
    // rust: Err(JoinError::from_response(
    // rust: status,
    // rust: &response.into_string().unwrap_or_default(),
    // rust: ))
}
    // rust: Err(ureq::Error::Transport(e)) => {
    // rust: log::warn!("The session service's join: {e}");
    // rust: Err(JoinError::Unavailable)
}
}
}

// The account's chat key pair (ProfileKeyPair): the private key that signs
// its chat, the public key with the services' signature over it, and when
// to fetch a new one (refreshedAfter, epoch milliseconds). Like the access
// token it stays in memory: vanilla's profilekeys file is never written.
ChatKeyPair :: struct {
    private: horizon_protocol::rsa::RsaPrivateKey,
    public: horizon_protocol::secure_chat::ProfileKey,
    refreshed_after: i64,
}
    // rust: impl std::fmt::Debug for ChatKeyPair {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("ChatKeyPair")
    // rust: .field("expires_at", &self.public.expires_at)
    // rust: .field("refreshed_after", &self.refreshed_after)
    // rust: .finish_non_exhaustive()
}
}
    // rust: impl ChatKeyPair {
    // ProfileKeyPair.dueRefresh.
due_refresh :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.refreshed_after < now
}
}

// Epoch milliseconds now.
now_millis :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: SystemTime::now()
    // rust: .duration_since(SystemTime::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64)
}

// Instant.parse for the services' UTC times
// (`2022-07-30T23:05:24.548227Z`): epoch milliseconds.
parse_instant :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = text.strip_suffix('Z')?;
    // rust: let (date, time) = text.split_once('T')?;
    // rust: let mut date = date.splitn(3, '-').map(|p| p.parse::<i64>().ok());
    // rust: let (y, m, d) = (date.next()??, date.next()??, date.next()??);
    // rust: let (hms, fraction) = time.split_once('.').unwrap_or((time, ""));
    // rust: let mut hms = hms.splitn(3, ':').map(|p| p.parse::<i64>().ok());
    // rust: let (h, min, s) = (hms.next()??, hms.next()??, hms.next()??);
    // rust: if !(1..=12).contains(&m) || !(1..=31).contains(&d) || h > 23 || min > 59 || s > 60 {
    // rust: return None;
}
    // rust: if !fraction.bytes().all(|b| b.is_ascii_digit()) {
    // rust: return None;
}
    // rust: let millis = format!("{fraction:0<3}")[..3].parse::<i64>().ok()?;
    // Days from 1970-01-01 (Howard Hinnant's days_from_civil).
    // rust: let y = if m <= 2 { y - 1 } else { y };
    // rust: let era = y.div_euclid(400);
    // rust: let yoe = y - era * 400;
    // rust: let doy = (153 * (m + if m > 2 { -3 } else { 9 }) + 2) / 5 + d - 1;
    // rust: let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
    // rust: let days = era * 146_097 + doe - 719_468;
    // rust: Some(((days * 24 + h) * 60 + min) * 60_000 + s * 1000 + millis)
}

// Crypt.stringToPemRsaPrivateKey / stringToRsaPublicKey: the base64
// between a PEM block's armour lines.
pem_der :: proc(pem: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let body: String = pem
    // rust: .lines()
    // rust: .filter(|l| !l.starts_with("-----"))
    // rust: .flat_map(|l| l.chars().filter(|c| !c.is_whitespace()))
    // rust: .collect();
    // rust: crate::skins::base64_decode(&body)
}

// KeyPairResponse from the certificates endpoint, as
// AccountProfileKeyPairManager.fetchProfileKeyPair reads it: the PEM key
// pair, publicKeySignatureV2 (the signature over the profile id too),
// expiresAt and refreshedAfter. None for anything malformed, or a private
// key that isn't the public key's other half.
parse_certificates :: proc(body: string) -> O {
    // Ported from Horizon
    return {}
}
//     use horizon_protocol::rsa::{RsaPrivateKey, RsaPublicKey};
    // rust: let v: serde_json::Value = serde_json::from_str(body).ok()?;
    // rust: let field = |path: &str| v.pointer(path).and_then(|s| s.as_str());
    // rust: let private = RsaPrivateKey::from_der(&pem_der(field("/keyPair/privateKey")?)?).ok()?;
    // rust: let key = pem_der(field("/keyPair/publicKey")?)?;
    // rust: if RsaPublicKey::from_der(&key).ok()? != private.public {
    // rust: return None;
}
    // rust: let signature = crate::skins::base64_decode(field("/publicKeySignatureV2")?)?;
    // rust: Some(ChatKeyPair {
    // rust: private,
    // rust: public: horizon_protocol::secure_chat::ProfileKey {
    // rust: expires_at: parse_instant(field("/expiresAt")?)?,
    // rust: key,
    // rust: signature,
    // rust: },
    // rust: refreshed_after: parse_instant(field("/refreshedAfter")?)?,
    // rust: })
}

// UserApiService.getKeyPair: the certificates endpoint, POSTed with the
// access token.
fetch_chat_keys :: proc(session: ^AuthSession) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let doc = discovery()?;
    // rust: let url = endpoint(&doc, "player", "getCertificates").ok_or(JoinError::Unavailable)?;
    // rust: let body = match agent()
    // rust: .post(&url)
    // rust: .set("Authorization", &format!("Bearer {}", session.access_token))
    // rust: .set("Content-Type", "application/json; charset=utf-8")
    // rust: .send_string("")
    // rust: {
    // rust: Ok(response) => response.into_string().unwrap_or_default(),
    // rust: Err(ureq::Error::Status(status, response)) => {
    // rust: return Err(JoinError::from_response(
    // rust: status,
    // rust: &response.into_string().unwrap_or_default(),
    // rust: ));
}
    // rust: Err(ureq::Error::Transport(_)) => return Err(JoinError::Unavailable),
}
    // rust: parse_certificates(&body)
    // rust: .ok_or_else(|| JoinError::Other("Malformed profile key pair response".to_owned()))
}

// AccountProfileKeyPairManager.MINIMUM_PROFILE_KEY_REFRESH_INTERVAL.
KEY_RETRY :: Duration::from_secs(60 * 60)

// The chat key pair as AccountProfileKeyPairManager keeps it: fetched on a
// background thread, kept until it is due a refresh, and on a failure kept
// as it was (the next try waits an hour, or the next join).
ChatKeys :: struct {
    current: Maybe(^ChatKeyPair),
    fetching: bool,
    next_try: Maybe(std::time::Instant),
}
    // rust: static CHAT_KEYS: std::sync::LazyLock<Mutex<std::collections::HashMap<u128, ChatKeys>>> =
    // rust: std::sync::LazyLock::new(|| Mutex::new(std::collections::HashMap::new()));

// prepareKeyPair (`now`: on a join) or, from a tick, shouldRefreshKeyPair
// then prepareKeyPair: start fetching when there is no key pair or it is
// due a refresh. Nothing without a signed-in account.
prepare_chat_keys :: proc(now: bool) {
}
    // rust: let Some(session) = current() else {
    // rust: return;
}
    // rust: prepare_chat_keys_for(session, now);
}

// Prepare keys for this player, independently of the other local accounts.
prepare_chat_keys_for :: proc(session: ^AuthSession, now: bool) {
}
    // rust: let uuid = session.uuid;
    // rust: let mut accounts = CHAT_KEYS.lock().unwrap();
    // rust: let keys = accounts.entry(uuid).or_default();
    // rust: let instant = std::time::Instant::now();
    // rust: if keys.fetching || !now && keys.next_try.is_some_and(|t| instant < t) {
    // rust: return;
}
    // rust: keys.next_try = Some(instant + KEY_RETRY);
    // rust: if keys
    // rust: .current
    // rust: .as_ref()
    // rust: .is_some_and(|k| !k.due_refresh(now_millis()))
    // rust: {
    // rust: return;
}
    // rust: keys.fetching = true;
    // rust: drop(accounts);
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Profile key fetch".into())
    // rust: .spawn(move || {
    // rust: let result = fetch_chat_keys(&session);
    // rust: let mut accounts = CHAT_KEYS.lock().unwrap();
    // rust: let keys = accounts.entry(uuid).or_default();
    // rust: keys.fetching = false;
    // rust: match result {
    // rust: Ok(pair) => keys.current = Some(Arc::new(pair)),
    // rust: Err(e) => log::error!("Failed to retrieve profile key pair: {e:?}"),
}
    // rust: });
    // rust: if spawned.is_err() {
    // rust: CHAT_KEYS.lock().unwrap().entry(uuid).or_default().fetching = false;
}
}

// The chat key pair fetched so far, unless it has expired.
chat_keys :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: chat_keys_for(current()?.uuid)
}

// This account's key pair; another local player's keys can never be returned.
chat_keys_for :: proc(uuid: u128) -> O {
    // Ported from Horizon
    return {}
}
    // rust: CHAT_KEYS
    // rust: .lock()
    // rust: .unwrap()
    // rust: .get(&uuid)?
    // rust: .current
    // rust: .clone()
    // rust: .filter(|k| !k.public.has_expired(now_millis()))
}

MINECRAFT_PROFILE :: "https://api.minecraftservices.com/minecraft/profile"

// The signed-in account's active skin and cape from `GET /minecraft/profile`.
// Single-player and integrated servers often send no `textures` property, or
// one without the equipped cape; the client asks the profile endpoint once.
own_textures :: proc(session: ^AuthSession) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let response = agent()
    // rust: .get(MINECRAFT_PROFILE)
    // rust: .set("Authorization", &format!("Bearer {}", session.access_token))
    // rust: .call()
    // rust: .ok()?;
    // rust: if response.status() != 200 {
    // rust: return None;
}
    // rust: let body = response.into_string().ok()?;
    // rust: let profile: serde_json::Value = serde_json::from_str(&body).ok()?;
    // rust: Some(crate::skins::services_profile_textures(&profile))
}

// What the session service says about a player joining this server
// (MinecraftServicesSessionService.hasJoinedServer).
JoinedProfile :: struct {
    uuid: u128,
    properties: [dynamic]horizon_protocol::packets::login::Property,
}

// HttpDiscoveryService.buildQuery: `URLEncoder.encode(value, UTF-8)`.
url_encode :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: for b in text.bytes() {
    // rust: match b {
    // rust: b'a'..=b'z' | b'A'..=b'Z' | b'0'..=b'9' | b'.' | b'-' | b'*' | b'_' => {
    // rust: out.push(char::from(b));
}
    // rust: b' ' => out.push('+'),
    // rust: _ => out.push_str(&format!("%{b:02X}")),
}
}
    // rust: out
}

// The session service's verify endpoint, asked by an online-mode server
// whether `name` joined with `server_hash` (and from `ip`, when the server
// prevents proxy connections). `Ok(None)`: it didn't, or the service said
// no; `Err(Unavailable)`: no answer.
    // rust: pub fn has_joined(
    // rust: name: &str,
    // rust: server_hash: &str,
    // rust: ip: Option<std::net::IpAddr>,
    // rust: ) -> Result<Option<JoinedProfile>, JoinError> {
    // rust: let doc = discovery()?;
    // rust: let url = endpoint(&doc, "session", "verify").ok_or(JoinError::Unavailable)?;
    // rust: let mut query = format!(
    // rust: "username={}&serverId={}",
    // rust: url_encode(name),
    // rust: url_encode(server_hash)
    // rust: );
    // rust: if let Some(ip) = ip {
    // rust: query.push_str(&format!("&ip={}", url_encode(&ip.to_string())));
}
    // rust: let separator = if url.contains('?') { '&' } else { '?' };
    // rust: let body = match agent().get(&format!("{url}{separator}{query}")).call() {
    // rust: Ok(response) => response.into_string().unwrap_or_default(),
    // rust: Err(ureq::Error::Status(status, response)) => {
    // rust: let error =
    // rust: JoinError::from_response(status, &response.into_string().unwrap_or_default());
    // rust: return match error {
    // rust: JoinError::Unavailable => Err(error),
    // rust: _ => Ok(None),
}
}
    // rust: Err(ureq::Error::Transport(_)) => return Err(JoinError::Unavailable),
}
    // rust: Ok(parse_joined(&body))
}

// HasJoinedMinecraftServerResponse: `id` and `properties`; no id is no profile.
parse_joined :: proc(body: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let v: serde_json::Value = serde_json::from_str(body).ok()?;
    // rust: let uuid = parse_uuid(v.get("id")?.as_str()?)?;
    // rust: let properties = v
    // rust: .get("properties")
    // rust: .and_then(|p| p.as_array())
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|p| {
    // rust: Some(horizon_protocol::packets::login::Property {
    // rust: name: p.get("name")?.as_str()?.to_owned(),
    // rust: value: p.get("value")?.as_str()?.to_owned(),
    // rust: signature: p
    // rust: .get("signature")
    // rust: .and_then(|s| s.as_str())
    // rust: .map(str::to_owned),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Some(JoinedProfile { uuid, properties })
}

    // rust: mod tests {
//     use super::*;

UUID :: 0x069a79f444e94726a5befca90e38aaf5

    // Runs `with_one_retry` over these answers, in order: the result and how
    // many it asked for.
joined :: proc(answers: ^[Result<() {
}
    // rust: let mut asked = 0;
    // rust: let result = with_one_retry(
    // rust: || {
    // rust: asked += 1;
    // rust: answers[asked - 1].clone()
    // rust: },
    // rust: Duration::ZERO,
    // rust: );
    // rust: (result, asked)
}

a_join_with_no_answer_is_tried_once_more :: proc() {
}
    // rust: let none = Err(JoinError::Unavailable);
    // rust: assert_eq!(joined(&[none.clone(), Ok(())]), (Ok(()), 2));
        // Twice without an answer: the message the player knows.
    // rust: assert_eq!(joined(&[none.clone(), none.clone()]), (none, 2));
}

a_join_the_service_answered_is_not_tried_again :: proc() {
}
    // rust: assert_eq!(joined(&[Ok(())]), (Ok(()), 1));
    // rust: for refused in [
    // rust: JoinError::InvalidSession,
    // rust: JoinError::Banned,
    // rust: JoinError::InsufficientPrivileges,
    // rust: JoinError::Other("Status: 429".into()),
    // rust: ] {
    // rust: assert_eq!(joined(&[Err(refused.clone())]), (Err(refused), 1));
}
}

    // base64url without padding, as a JWT's parts are.
base64url :: proc(bytes: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: const ALPHABET: &[u8; 64] =
    // rust: b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
    // rust: let mut out = String::new();
    // rust: for chunk in bytes.chunks(3) {
    // rust: let n =
    // rust: chunk.iter().fold(0u32, |n, &b| n << 8 | u32::from(b)) << (8 * (3 - chunk.len()));
    // rust: for k in 0..=chunk.len() {
    // rust: out.push(char::from(ALPHABET[(n >> (18 - 6 * k) & 63) as usize]));
}
}
    // rust: out
}

a_token_past_its_exp_is_expired :: proc() {
}
        // header.payload.signature, the payload base64url without padding.
    // rust: let token = |exp: u64| {
    // rust: let json = format!(r#"{{"exp":{exp}}}"#);
    // rust: let payload = base64url(json.as_bytes());
    // rust: AuthSession::new("Ann", UUID, &format!("e30.{payload}.sig"))
}
    // rust: let now = SystemTime::now()
    // rust: .duration_since(SystemTime::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_secs();
    // rust: assert!(token(now - 10).expired());
    // rust: assert!(
    // rust: token(now + 30).expired(),
    // rust: "a minute from its end: as good as gone"
    // rust: );
    // rust: assert!(!token(now + 3600).expired());
    // rust: assert!(!AuthSession::new("Ann", UUID, "not-a-jwt").expired());
}

write :: proc(dir: ^Path, text: string, mode: u32) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let path = dir.join("session.json");
    // rust: std::fs::write(&path, text).unwrap();
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: std::fs::set_permissions(&path, std::fs::Permissions::from_mode(mode)).unwrap();
}
    // rust: let _ = mode;
    // rust: path
}

verify_answers :: proc() {
}
    // rust: assert_eq!(url_encode("Tester_1"), "Tester_1");
    // rust: assert_eq!(url_encode("-5a f"), "-5a+f");
    // rust: assert_eq!(url_encode("::1"), "%3A%3A1");
    // rust: let body = r#"{"id":"069a79f444e94726a5befca90e38aaf5","name":"Notch","properties":[{"name":"textures","value":"e30=","signature":"c2ln"}]}"#;
    // rust: let p = parse_joined(body).unwrap();
    // rust: assert_eq!(p.uuid, UUID);
    // rust: assert_eq!(p.properties.len(), 1);
    // rust: assert_eq!(p.properties[0].signature.as_deref(), Some("c2ln"));
    // rust: assert_eq!(parse_joined(""), None);
    // rust: assert_eq!(parse_joined(r#"{"name":"Notch"}"#), None);
}

session_files_are_read_once_and_must_be_private :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-auth-test-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let text = r#"{"name":"Notch","uuid":"069a79f4-44e9-4726-a5be-fca90e38aaf5","access_token":"mock-token","user_type":"msa"}"#;
    // rust: let path = write(&dir, text, 0o600);
    // rust: let s = AuthSession::load(&path).unwrap();
    // rust: assert_eq!((s.name.as_str(), s.uuid), ("Notch", UUID));
    // rust: assert!(!path.exists(), "deleted after reading");
    // rust: assert!(!format!("{s:?}").contains("mock-token"));
    // rust: {
    // rust: let path = write(&dir, text, 0o644);
    // rust: assert!(
    // rust: AuthSession::load(&path)
    // rust: .unwrap_err()
    // rust: .contains("other users")
    // rust: );
    // rust: assert!(!path.exists());
}
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

session_file_fields :: proc() {
}
    // rust: assert!(
    // rust: AuthSession::parse(r#"{"name":"Notch","uuid":"069a79f444e94726a5befca90e38aaf5"}"#)
    // rust: .is_err()
    // rust: );
    // rust: assert!(
    // rust: AuthSession::parse(
    // rust: r#"{"name":"","uuid":"069a79f444e94726a5befca90e38aaf5","access_token":"t"}"#
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(AuthSession::parse(r#"{"name":"A","uuid":"nope","access_token":"t"}"#).is_err());
    // rust: assert!(AuthSession::parse(r#"{"name":"A","uuid":"069a79f444e94726a5befca90e38aaf5","access_token":"t","user_type":"legacy"}"#).is_err());
    // rust: let s = AuthSession::parse(r#"{"name":"A","uuid":"069a79f444e94726a5befca90e38aaf5","access_token":"t","xuid":"25"}"#).unwrap();
    // rust: assert_eq!(s.xuid.as_deref(), Some("25"));
}

join_request_like_authlib :: proc() {
}
    // rust: let s = AuthSession::new("Notch", UUID, "tok");
    // rust: let v: serde_json::Value = serde_json::from_str(&join_request(&s, "-7c9d")).unwrap();
    // rust: assert_eq!(
    // rust: v,
    // rust: serde_json::json!({"accessToken": "tok", "selectedProfile": "069a79f444e94726a5befca90e38aaf5", "serverId": "-7c9d"})
    // rust: );
}

errors_map_like_authlib :: proc() {
}
    // rust: let e = |status, body| JoinError::from_response(status, body);
    // rust: assert_eq!(
    // rust: e(
    // rust: 403,
    // rust: r#"{"error":"ForbiddenOperationException","errorMessage":"Invalid token"}"#
    // rust: ),
    // rust: JoinError::InvalidSession
    // rust: );
    // rust: assert_eq!(e(401, ""), JoinError::InvalidSession);
    // rust: assert_eq!(
    // rust: e(403, r#"{"error":"InsufficientPrivilegesException"}"#),
    // rust: JoinError::InsufficientPrivileges
    // rust: );
    // rust: assert_eq!(
    // rust: e(403, r#"{"error":"multiplayer.access.banned"}"#),
    // rust: JoinError::Banned
    // rust: );
    // rust: assert_eq!(e(503, "down"), JoinError::Unavailable);
    // rust: assert_eq!(
    // rust: e(429, r#"{"errorMessage":"Too many"}"#),
    // rust: JoinError::Other("Too many".into())
    // rust: );
    // rust: assert_eq!(
    // rust: JoinError::InvalidSession.reason(),
    // rust: Ok("disconnect.loginFailedInfo.invalidSession")
    // rust: );
}

instants_like_java :: proc() {
}
    // rust: assert_eq!(parse_instant("1970-01-01T00:00:00Z"), Some(0));
    // rust: assert_eq!(parse_instant("1970-01-01T00:00:01.5Z"), Some(1500));
        // Instant.parse("2022-07-30T23:05:24.548227Z").toEpochMilli().
    // rust: assert_eq!(
    // rust: parse_instant("2022-07-30T23:05:24.548227Z"),
    // rust: Some(1_659_222_324_548)
    // rust: );
    // rust: assert_eq!(
    // rust: parse_instant("2024-02-29T12:00:00Z"),
    // rust: Some(1_709_208_000_000)
    // rust: );
    // rust: assert_eq!(parse_instant("1969-12-31T23:59:59Z"), Some(-1000));
    // rust: for bad in [
    // rust: "2022-07-30T23:05:24",
    // rust: "2022-13-01T00:00:00Z",
    // rust: "2022-07-30 23:05:24Z",
    // rust: "2022-07-30T23:05:24.5x1Z",
    // rust: "",
    // rust: ] {
    // rust: assert_eq!(parse_instant(bad), None, "{bad}");
}
}

    // A throwaway 1024-bit key (`openssl genrsa`, PKCS#8 as the services
    // send it under "RSA PRIVATE KEY") and its public half.
PRIVATE_B64 :: "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKSDqaLOF2Ltt4tzWblkFeNYhdss67BhXTbOMUYjpcPdtf4dzNtgZsTf4WEluvc8pItGWChdpq3xzPC9GL4PZ+Oh1o6VR/wSm20/50QT7V+YcSP1VrVKjDpDSg/UoC1Fmdc/vb9AO8Ip7TxuRYd/uyog/ThQ8aGcWtvvtwPqx4XrAgMBAAECgYA+ZGy2gQDflRZSPeoeZHXkphMF/7BXUWW/vk1zs1tPwEsgV/70iEgRjHL2nA+fapFg/Mm8bWAkghrehmjW1BLq5w8sGdGJCHfE/kauu78jJK0/ME38e9bsSEvv5HMMxyx0mlV8DQu2pzCT71ceT8VD/1pewUbpeZypj5pxtsCIMQJBANXgca/mnAQXTuowI8FqMiald6OuAcAWbOaNrCB5HHWuxH7hFatSqGrgp4YLqHv7bzeodU1y/uxwc+/01khd0rMCQQDE6mPfIdZxHhWkMUAKhMEnrLanfCL0dfyAe+lBpqgPwO3UurCfCaFX5RdYB3fCyvgy5foHN1/I8/Eobp+enrvpAkBgkZnjeXWiZz/Lf/b1AtUoG/g8IHpL2BRNuVQpyWVvQX0ZaNoW5BiFQXCClsr5SBr8f4SPdsfhzBidFOiX/jz/AkBDuk6Bd3T3UR6ma54YQBLjX38vWf330QD4/CV9RCH30Sa8DT4kZT6OKah+yYrCf+cgMoNtqfkS9/xRKMNT3krJAkAaFrAT6HF5Y9b5OLASbbFe7MZ4zNCzuEl6plKNUi+JCHESaU/VCCuYOLoWLeSDFYkZUoSmqiRxH8fVTsBz393x"
PUBLIC_B64 :: "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkg6mizhdi7beLc1m5ZBXjWIXbLOuwYV02zjFGI6XD3bX+HczbYGbE3+FhJbr3PKSLRlgoXaat8czwvRi+D2fjodaOlUf8EpttP+dEE+1fmHEj9Va1Sow6Q0oP1KAtRZnXP72/QDvCKe08bkWHf7sqIP04UPGhnFrb77cD6seF6wIDAQAB"

pem :: proc(label: string, b64: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lines: Vec<&str> = b64
    // rust: .as_bytes()
    // rust: .chunks(76)
    // rust: .map(|c| std::str::from_utf8(c).unwrap())
    // rust: .collect();
    // rust: format!(
    // rust: "-----BEGIN {label}-----\n{}\n-----END {label}-----\n",
    // rust: lines.join("\n")
    // rust: )
}

certificates :: proc(private: string, public: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::json!({
    // rust: "keyPair": {
    // rust: "privateKey": pem("RSA PRIVATE KEY", private),
    // rust: "publicKey": pem("RSA PUBLIC KEY", public),
    // rust: },
    // rust: "publicKeySignature": "djE=",
    // rust: "publicKeySignatureV2": "c2ln",
    // rust: "expiresAt": "2022-07-30T23:05:24.548227Z",
    // rust: "refreshedAfter": "2022-07-30T15:05:24.548227Z",
    // rust: })
    // rust: .to_string()
}

local_accounts_use_their_own_chat_keys :: proc() {
}
    // rust: let pair = |signature: &[u8]| {
    // rust: let mut keys = parse_certificates(&certificates(PRIVATE_B64, PUBLIC_B64)).unwrap();
    // rust: keys.public.expires_at = i64::MAX;
    // rust: keys.refreshed_after = i64::MAX;
    // rust: keys.public.signature = signature.to_vec();
    // rust: Arc::new(keys)
}
    // rust: let ann = pair(b"ann");
    // rust: let bea = pair(b"bea");
    // rust: {
    // rust: let mut accounts = CHAT_KEYS.lock().unwrap();
    // rust: for (uuid, keys) in [(101, ann.clone()), (102, bea.clone())] {
    // rust: accounts.insert(
    // rust: uuid,
    // rust: ChatKeys {
    // rust: current: Some(keys),
    // rust: ..Default::default()
    // rust: },
    // rust: );
}
}
    // rust: prepare_chat_keys_for(Arc::new(AuthSession::new("Ann", 101, "unused")), true);
    // rust: assert!(Arc::ptr_eq(&chat_keys_for(101).unwrap(), &ann));
    // rust: assert!(Arc::ptr_eq(&chat_keys_for(102).unwrap(), &bea));
    // rust: assert!(chat_keys_for(103).is_none());
    // rust: CHAT_KEYS.lock().unwrap().remove(&101);
    // rust: CHAT_KEYS.lock().unwrap().remove(&102);
}

certificates_response :: proc() {
}
    // rust: let pair = parse_certificates(&certificates(PRIVATE_B64, PUBLIC_B64)).unwrap();
    // rust: assert_eq!(
    // rust: pair.public.key,
    // rust: crate::skins::base64_decode(PUBLIC_B64).unwrap()
    // rust: );
    // rust: assert_eq!(pair.public.signature, b"sig", "publicKeySignatureV2");
    // rust: assert_eq!(pair.public.expires_at, 1_659_222_324_548);
    // rust: assert_eq!(pair.refreshed_after, 1_659_193_524_548);
    // rust: assert_eq!(pair.private.public_der(), pair.public.key);
    // rust: assert!(pair.due_refresh(1_659_193_524_549));
    // rust: assert!(!pair.due_refresh(1_659_193_524_548));
    // rust: assert!(!format!("{pair:?}").contains("MII"));
        // A public key that isn't the private key's, and broken fields.
    // rust: let other = horizon_protocol::rsa::RsaPrivateKey::generate(1024).unwrap();
    // rust: let other = base64(&other.public_der());
    // rust: assert!(parse_certificates(&certificates(PRIVATE_B64, &other)).is_none());
    // rust: assert!(parse_certificates(&certificates("bm9wZQ==", PUBLIC_B64)).is_none());
    // rust: assert!(parse_certificates("{}").is_none());
    // rust: assert!(parse_certificates("").is_none());
}

base64 :: proc(bytes: []u8) -> S {
    // Ported from Horizon
    return {}
}
A :: b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    // rust: let mut out = String::new();
    // rust: for c in bytes.chunks(3) {
    // rust: let n = c
    // rust: .iter()
    // rust: .enumerate()
    // rust: .fold(0u32, |n, (i, &b)| n | u32::from(b) << (16 - 8 * i));
    // rust: for i in 0..4 {
    // rust: out.push(if i <= c.len() {
    // rust: char::from(A[(n >> (18 - 6 * i) & 63) as usize])
    // rust: } else {
    // rust: '='
    // rust: });
}
}
    // rust: out
}

discovery_endpoints :: proc() {
}
    // rust: let doc = serde_json::json!({"discovery": {"session": {"endpoints": {"join": {"uri": "https://s/join"}}}}});
    // rust: assert_eq!(
    // rust: endpoint(&doc, "session", "join").as_deref(),
    // rust: Some("https://s/join")
    // rust: );
    // rust: assert_eq!(endpoint(&doc, "session", "verify"), None);
}
}
