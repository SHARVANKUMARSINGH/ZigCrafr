//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-registry_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-mod-registry`: the submission form's service at
//! `playhorizon.dev/api/mods/*` (docs/api/mod-index.md). A creator signs in
//! with GitHub, sends a file and its page; the service runs the file's own
//! checks, uploads it to the registry's `staging` release and opens a pull
//! request with the entry. Reviewers decide; merging publishes. Signed-in
//! players also rate published projects (`ratings`, its only data: sessions
//! are signed cookies, and GitHub holds everything else).
    // rust: mod archive;
    // rust: pub mod github;
    // rust: pub mod page;
    // rust: pub mod ratings;

// use axum::{
    // rust: Json, Router,
    // rust: body::Body,
    // rust: extract::{
    // rust: DefaultBodyLimit, FromRequest, Multipart, Path as UrlPath, Query, Request, State,
    // rust: multipart::MultipartError,
    // rust: },
    // rust: http::{HeaderMap, StatusCode, header},
    // rust: response::{IntoResponse, Redirect, Response},
    // rust: routing::{get, post},
}
// use base64::{Engine, engine::general_purpose::URL_SAFE_NO_PAD};
// use github::GitHub;
// use hmac::{Hmac, Mac};
// use horizon_mods::index::{
    // rust: self, Kind,
    // rust: registry::{self, Entry, EntryVersion, Sources},
}
// use ratings::Ratings;
// use serde::Deserialize;
// use serde_json::json;
// use sha2::Sha256;
// use std::{
    // rust: collections::{HashMap, VecDeque},
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
    // rust: time::{Duration, Instant, SystemTime, UNIX_EPOCH},
}

/// How long a sign-in lasts.
pub const SESSION: u64 = 12 * 3600;
/// Submissions per account per hour, and from everyone.
pub const PER_ACCOUNT: usize = 6;
pub const PER_HOUR: usize = 60;
/// The page's JSON.
pub const MAX_FORM: usize = 64 << 10;
/// A submission's whole body: the file, the page, its images and the form's framing.
pub const MAX_BODY: usize = index::MAX_FILE  + page::MAX_IMAGES + MAX_FORM * 2;
/// Ratings set per account per hour, and by everyone.
pub const RATINGS_PER_ACCOUNT: usize = 30;
pub const RATINGS_PER_HOUR: usize = 600;
/// How long the ratings' totals are served from memory (and cached by
/// browsers and the launcher).
pub const TOTALS_FOR: Duration = Duration::from_secs(60);

pub const Config = struct {
    /// `https://playhorizon.dev`: where the form is, and the only origin it
    /// takes submissions from.
    public_url: []const u8,
    /// At least 32 bytes: signs sessions.
    session_key: std.ArrayList(u8),
    github: GitHub,
    /// `REGISTRY_UPDATE_KEY`: signs an owner update's trailer; None turns the
    /// feature off (every update waits for a reviewer).
    update_key: ?std.ArrayList(u8),
    /// Where files wait during a submission.
    scratch: PathBuf,
    /// The ratings' SQLite file (a volume): `:memory:` keeps them in memory.
    database: PathBuf,
};

    // rust: impl Config {
    /// `REGISTRY_PUBLIC_URL`, `REGISTRY_SESSION_KEY`, `REGISTRY_REPO`,
    /// `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET`, `GITHUB_BOT_TOKEN`,
    /// `REGISTRY_UPDATE_KEY` (optional), `REGISTRY_DB` (default
    /// `/data/registry.sqlite3`).
pub fn from_env() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let var = |name: &str| std::env::var(name).map_err(|_| format!("{name} is not set"));
    // rust: let key = var("REGISTRY_SESSION_KEY")?;
    // rust: if key.len() < 32 {
    // rust: return Err("REGISTRY_SESSION_KEY needs at least 32 characters".into());
}
    // rust: Ok(Config {
    // rust: public_url: var("REGISTRY_PUBLIC_URL")?
    // rust: .trim()
    // rust: .trim_end_matches('/')
    // rust: .to_owned(),
    // rust: session_key: key.into_bytes(),
    // rust: github: GitHub::new(
    // rust: github::Endpoints::default(),
    // rust: std::env::var("REGISTRY_REPO")
    // rust: .unwrap_or_else(|_| "horizon-rust/horizon-mods".into()),
    // rust: var("GITHUB_CLIENT_ID")?,
    // rust: var("GITHUB_CLIENT_SECRET")?,
    // rust: var("GITHUB_BOT_TOKEN")?,
    // rust: ),
    // rust: update_key: std::env::var("REGISTRY_UPDATE_KEY")
    // rust: .ok()
    // rust: .filter(|k| !k.is_empty())
    // rust: .map(String::into_bytes),
    // rust: scratch: std::env::temp_dir().join("horizon-mod-registry"),
    // rust: database: std::env::var_os("REGISTRY_DB")
    // rust: .map_or_else(|| PathBuf::from("/data/registry.sqlite3"), PathBuf::from),
    // rust: })
}

pub fn callback(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{}/api/mods/auth/callback", self.public_url)
}
}

pub const App = struct {};

    // rust: type Windows = Mutex<HashMap<String, VecDeque<Instant>>>;

pub const Inner = struct {
    config: Config,
    /// Submissions in the last hour, by account ("" for everyone's).
    recent: Windows,
    /// Ratings set in the last hour, the same way.
    rated: Windows,
    ratings: Mutex<Ratings>,
    /// `GET /api/mods/ratings`' body, and when it was made.
    totals: Mutex<Option<(Instant,
};

    // rust: impl App {
    /// Fails when the ratings' file can't be opened.
pub fn new(config: Config) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ratings = Ratings::open(&config.database)
    // rust: .map_err(|e| format!("{}: {e}", config.database.display()))?;
    // rust: Ok(App(Arc::new(Inner {
    // rust: config,
    // rust: recent: Mutex::default(),
    // rust: rated: Mutex::default(),
    // rust: ratings: Mutex::new(ratings),
    // rust: totals: Mutex::default(),
    // rust: })))
}
}

pub fn router(app: App) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Router::new()
    // rust: .route("/healthz", get(|| async { "ok" }))
    // rust: .route("/api/mods/auth/login", get(login))
    // rust: .route("/api/mods/auth/callback", get(callback))
    // rust: .route("/api/mods/auth/logout", post(logout))
    // rust: .route("/api/mods/me", get(me))
    // rust: .route("/api/mods/ratings", get(totals))
    // rust: .route("/api/mods/{id}/rating", get(my_rating).post(rate))
    // rust: .route(
    // rust: "/api/mods/submit",
    // rust: post(submit).layer(DefaultBodyLimit::max(MAX_BODY)),
    // rust: )
    // rust: .with_state(app)
}

/// An error players read in the form.
pub const Refusal = struct {};

    // rust: impl Refusal {
pub fn new(status: StatusCode, message: impl Into<[]const u8>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Refusal(status, message.into())
}
}

    // rust: impl IntoResponse for Refusal {
pub fn into_response(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.0, Json(json!({"error": self.1}))).into_response()
}
}

pub fn bad(message: impl Into<[]const u8>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Refusal::new(StatusCode::BAD_REQUEST, message)
}

pub fn github_down(e: github::Failure) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: eprintln!("horizon-mod-registry: GitHub {}: {}", e.status, e.message);
    // rust: if e.timed_out {
    // rust: return Refusal::new(
    // rust: StatusCode::GATEWAY_TIMEOUT,
    // rust: "GitHub is slow right now: try again in a few minutes",
    // rust: );
}
    // rust: Refusal::new(
    // rust: StatusCode::BAD_GATEWAY,
    // rust: "GitHub didn't answer as expected: try again in a minute",
    // rust: )
}

// Signed values: `<payload>.<HMAC-SHA256>`, both base64url.

pub fn sign(key: []const u8, payload: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mac = Hmac::<Sha256>::new_from_slice(key).expect("any key length");
    // rust: mac.update(payload.as_bytes());
    // rust: format!(
    // rust: "{}.{}",
    // rust: URL_SAFE_NO_PAD.encode(payload),
    // rust: URL_SAFE_NO_PAD.encode(mac.finalize().into_bytes())
    // rust: )
}

pub fn unsign(key: []const u8, value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (payload, tag) = value.split_once('.')?;
    // rust: let payload = String::from_utf8(URL_SAFE_NO_PAD.decode(payload).ok()?).ok()?;
    // rust: let mut mac = Hmac::<Sha256>::new_from_slice(key).ok()?;
    // rust: mac.update(payload.as_bytes());
    // rust: mac.verify_slice(&URL_SAFE_NO_PAD.decode(tag).ok()?).ok()?;
    // rust: Some(payload)
}

pub fn now() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SystemTime::now()
    // rust: .duration_since(UNIX_EPOCH)
    // rust: .unwrap_or_default()
    // rust: .as_secs()
}

pub fn random_hex() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bytes = [0u8; 16];
    // rust: getrandom::fill(&mut bytes).expect("the system's random numbers");
    // rust: bytes.iter().map(|b| format!("{b:02x}")).collect()
}

pub fn cookie(headers: *HeaderMap, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: headers
    // rust: .get_all(header::COOKIE)
    // rust: .iter()
    // rust: .filter_map(|v| v.to_str().ok())
    // rust: .flat_map(|v| v.split(';'))
    // rust: .filter_map(|c| c.trim().split_once('='))
    // rust: .find(|(k, _)| *k == name)
    // rust: .map(|(_, v)| v.to_owned())
}

pub fn set_cookie(name: []const u8, value: []const u8, max_age: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{name}={value}; Path=/api/mods; HttpOnly; Secure; SameSite=Lax; Max-Age={max_age}")
}

/// The signed-in account: (login, id).
pub fn session(app: *Inner, headers: *HeaderMap) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let payload = unsign(&app.config.session_key, &cookie(headers, "hm_session")?)?;
    // rust: let mut parts = payload.split('\n');
    // rust: let (login, id, until) = (parts.next()?, parts.next()?, parts.next()?);
    // rust: (until.parse::<u64>().ok()? > now()).then(|| (login.to_owned(), id.parse().unwrap_or(0)))
}

/// The form sends this with each submission: a page on another site can't
/// read it, so it can't submit in a signed-in creator's name.
pub fn csrf(app: *Inner, headers: *HeaderMap) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let session = cookie(headers, "hm_session")?;
    // rust: let signed = sign(&app.config.session_key, &format!("csrf\n{session}"));
    // rust: Some(signed.rsplit('.').next()?.chars().take(32).collect())
}

pub const Login = struct {
    /// The site's page to come back to: `/mods`, `/mods/submit` (the
    /// default) or `/mods/<id>`.
    back: ?[]const u8,
};

/// Whether `path` is a registry page a sign-in may come back to.
pub fn registry_page(path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match path.strip_prefix("/mods") {
    // rust: Some("") => true,
    // rust: Some(rest) => rest.strip_prefix('/').is_some_and(index::valid_id) || rest == "/submit",
    // rust: None => false,
}
}

pub fn login() void {
}
    // rust: let state = random_hex();
    // rust: let back = q
    // rust: .back
    // rust: .filter(|b| registry_page(b))
    // rust: .unwrap_or_else(|| "/mods/submit".into());
    // rust: let signed = sign(&app.0.config.session_key, &format!("{state}\n{back}"));
    // rust: let url = app
    // rust: .0
    // rust: .config
    // rust: .github
    // rust: .authorize_url(&app.0.config.callback(), &state);
    // rust: (
    // rust: [(header::SET_COOKIE, set_cookie("hm_state", &signed, 600))],
    // rust: Redirect::to(&url),
    // rust: )
    // rust: .into_response()
}

pub const Callback = struct {
    code: []const u8,
    state: []const u8,
};

    // rust: async fn callback(
    // rust: State(app): State<App>,
    // rust: headers: HeaderMap,
    // rust: Query(q): Query<Callback>,
    // rust: ) -> Result<Response, Refusal> {
    // rust: let started = cookie(&headers, "hm_state").and_then(|v| unsign(&app.0.config.session_key, &v));
    // rust: let Some((_, back)) = started
    // rust: .as_deref()
    // rust: .and_then(|s| s.split_once('\n'))
    // rust: .filter(|(state, _)| *state == q.state)
    // rust: else {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::FORBIDDEN,
    // rust: "the sign-in expired or didn't start here: try again",
    // rust: ));
}
    // rust: let inner = app.0.clone();
    // rust: let (login, id) = tokio::task::spawn_blocking(move || {
    // rust: inner
    // rust: .config
    // rust: .github
    // rust: .sign_in(&q.code, &inner.config.callback())
    // rust: })
    // rust: .await
    // rust: .map_err(|_| Refusal::new(StatusCode::INTERNAL_SERVER_ERROR, "sign-in failed"))?
    // rust: .map_err(github_down)?;
    // rust: let value = sign(
    // rust: &app.0.config.session_key,
    // rust: &format!("{login}\n{id}\n{}", now() + SESSION),
    // rust: );
    // rust: let back = format!("{}{back}", app.0.config.public_url);
    // rust: let mut response = Redirect::to(&back).into_response();
    // rust: let headers = response.headers_mut();
    // rust: headers.append(
    // rust: header::SET_COOKIE,
    // rust: set_cookie("hm_session", &value, SESSION).parse().unwrap(),
    // rust: );
    // rust: headers.append(
    // rust: header::SET_COOKIE,
    // rust: set_cookie("hm_state", "", 0).parse().unwrap(),
    // rust: );
    // rust: Ok(response)
}

pub fn logout() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: [(header::SET_COOKIE, set_cookie("hm_session", "", 0))],
    // rust: StatusCode::NO_CONTENT,
    // rust: )
    // rust: .into_response()
}

    // rust: async fn me(
    // rust: State(app): State<App>,
    // rust: headers: HeaderMap,
    // rust: ) -> Result<Json<serde_json::Value>, Refusal> {
    // rust: let (login, _) = session(&app.0, &headers)
    // rust: .ok_or_else(|| Refusal::new(StatusCode::UNAUTHORIZED, "not signed in"))?;
    // rust: Ok(Json(
    // rust: json!({"login": login, "csrf": csrf(&app.0, &headers)}),
    // rust: ))
}

pub fn database(e: rusqlite::Error) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: eprintln!("horizon-mod-registry: ratings: {e}");
    // rust: Refusal::new(
    // rust: StatusCode::INTERNAL_SERVER_ERROR,
    // rust: "the ratings can't be read right now",
    // rust: )
}

/// A mean as the pages show it: two decimals.
pub fn rounded(average: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (average * 100.0).round() / 100.0
}

/// `GET /api/mods/ratings`: `{"projects": {"<id>": {"average", "count"}}}` for
/// every rated project. Totals only: never who rated.
pub fn totals() void {
}
    // rust: let mut cached = app.0.totals.lock().unwrap();
    // rust: let body = match cached.as_ref().filter(|(at, _)| at.elapsed() < TOTALS_FOR) {
    // rust: Some((_, body)) => body.clone(),
    // rust: None => {
    // rust: let all = app
    // rust: .0
    // rust: .ratings
    // rust: .lock()
    // rust: .unwrap()
    // rust: .summaries()
    // rust: .map_err(database)?;
    // rust: let projects: serde_json::Map<String, serde_json::Value> = all
    // rust: .into_iter()
    // rust: .map(|(id, s)| (id, json!({"average": rounded(s.average), "count": s.count})))
    // rust: .collect();
    // rust: let body = json!({ "projects": projects }).to_string();
    // rust: *cached = Some((Instant::now(), body.clone()));
    // rust: body
}
}
    // rust: Ok((
    // rust: [
    // rust: (header::CONTENT_TYPE, "application/json"),
    // rust: (header::CACHE_CONTROL, "public, max-age=60"),
    // rust: ],
    // rust: body,
    // rust: )
    // rust: .into_response())
}

/// `GET /api/mods/{id}/rating`: the signed-in account's own rating,
/// `{"stars": 1..5}` or `{"stars": null}`.
    // rust: async fn my_rating(
    // rust: State(app): State<App>,
    // rust: headers: HeaderMap,
    // rust: UrlPath(id): UrlPath<String>,
    // rust: ) -> Result<Json<serde_json::Value>, Refusal> {
    // rust: let (_, account) = session(&app.0, &headers)
    // rust: .ok_or_else(|| Refusal::new(StatusCode::UNAUTHORIZED, "not signed in"))?;
    // rust: let stars = app
    // rust: .0
    // rust: .ratings
    // rust: .lock()
    // rust: .unwrap()
    // rust: .mine(&id, account)
    // rust: .map_err(database)?;
    // rust: Ok(Json(json!({ "stars": stars })))
}

pub const Rating = struct {
    stars: u8,
};

/// `POST /api/mods/{id}/rating` with `{"stars": 1..5}`: sets or changes the
/// signed-in account's rating of a published project, not its own. Answers
/// the project's new totals and `stars`.
    // rust: async fn rate(
    // rust: State(app): State<App>,
    // rust: headers: HeaderMap,
    // rust: UrlPath(id): UrlPath<String>,
    // rust: Json(rating): Json<Rating>,
    // rust: ) -> Result<Json<serde_json::Value>, Refusal> {
    // rust: let inner = app.0.clone();
    // rust: let (login, account) = signed_in_here(&inner, &headers)?;
    // rust: if !(1..=5).contains(&rating.stars) {
    // rust: return Err(bad("a rating is 1 to 5 stars"));
}
    // rust: if !index::valid_id(&id) {
    // rust: return Err(Refusal::new(StatusCode::NOT_FOUND, "no such project"));
}
    // rust: if !allow(&inner.rated, &login, RATINGS_PER_ACCOUNT, RATINGS_PER_HOUR) {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::TOO_MANY_REQUESTS,
    // rust: "too many ratings this hour: try again later",
    // rust: ));
}
    // rust: let lookup = inner.clone();
    // rust: let wanted = id.clone();
    // rust: let entry = tokio::task::spawn_blocking(move || lookup.config.github.entry(&wanted))
    // rust: .await
    // rust: .map_err(|_| Refusal::new(StatusCode::INTERNAL_SERVER_ERROR, "the check crashed"))?
    // rust: .map_err(github_down)?;
    // rust: let Some((entry, _)) = entry else {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::NOT_FOUND,
    // rust: format!("{id} isn't published in the registry"),
    // rust: ));
}
    // rust: if ownership(&entry, &login, account) != Ownership::None {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::FORBIDDEN,
    // rust: "you publish this project: its players rate it",
    // rust: ));
}
    // rust: let summary = {
    // rust: let ratings = inner.ratings.lock().unwrap();
    // rust: ratings
    // rust: .rate(&id, account, rating.stars, now())
    // rust: .map_err(database)?;
    // rust: ratings.summary(&id).map_err(database)?
}
    // rust: *inner.totals.lock().unwrap() = None;
    // rust: let (average, count) = summary.map_or((0.0, 0), |s| (rounded(s.average), s.count));
    // rust: Ok(Json(
    // rust: json!({"stars": rating.stars, "average": average, "count": count}),
    // rust: ))
}

/// The page a submission fills in: a project's fields, and the version's.
pub const Form = struct {
    id: []const u8,
    kind: []const u8,
    name: []const u8,
    summary: []const u8,
    description: []const u8,
    authors: std.ArrayList([]const u8),
    license: []const u8,
    /// The code's address.
    source: []const u8,
    /// Refused: the registry no longer follows repositories (every version is a submission).
    /// Kept so an old form's listing gets a clear answer.
    repo: ?[]const u8,
    /// Refused: icons are uploaded (the `icon` part) and kept in the registry.
    icon: ?[]const u8,
    /// 1 to 3 of the kind's categories.
    categories: std.ArrayList([]const u8),
    tags: std.ArrayList([]const u8),
    /// The project's screenshots to keep, in order (`screenshots/<id>/<name>` of its entry);
    /// uploaded ones come after them. Absent: all of them.
    screenshots: ?std.ArrayList([]const u8),
    /// A `shaderpack`'s submitter says they made it and its licence lets the registry hand it out.
    own_work: bool,
    /// Changes the page only, with no file ("Edit project").
    edit: bool,
    /// A new project's minisign public key.
    key: ?[]const u8,
    /// The `.minisig` text.
    signature: ?[]const u8,
    version: []const u8,
    game: []const u8,
    changelog: []const u8,
};

pub fn take(window: *mut VecDeque<Instant>, max: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while window
    // rust: .front()
    // rust: .is_some_and(|t| t.elapsed() > Duration::from_secs(3600))
    // rust: {
    // rust: window.pop_front();
}
    // rust: window.len() < max
}

/// The origin a URL names: `scheme://host[:port]`, without a path. An
/// `Origin` is a page's origin and never carries a path, while
/// `REGISTRY_PUBLIC_URL` may: the form's pages are below the site's root.
pub fn url_origin(url: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let host = url.find("://").map_or(0, |scheme| scheme + 3);
    // rust: url[host..]
    // rust: .find('/')
    // rust: .map_or(url, |path| &url[..host + path])
}

/// Whether a change comes from the site's own pages: its `Origin` is the
/// origin of `REGISTRY_PUBLIC_URL`, which is what its pages are. A page on
/// another site can't send its origin, so this is a whole origin's match,
/// case folded the way a host name is.
pub fn from_the_site(public_url: []const u8, origin: ?[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: origin.is_some_and(|origin| origin.eq_ignore_ascii_case(url_origin(public_url)))
}

/// A change sent by the site's own pages: from its origin, signed in, with
/// the session's CSRF token. The account: (login, id).
pub fn signed_in_here(app: *Inner, headers: *HeaderMap) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let origin = headers.get(header::ORIGIN).and_then(|v| v.to_str().ok());
    // rust: if !from_the_site(&app.config.public_url, origin) {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::FORBIDDEN,
    // rust: "send it from the registry's pages",
    // rust: ));
}
    // rust: let account = session(app, headers)
    // rust: .ok_or_else(|| Refusal::new(StatusCode::UNAUTHORIZED, "sign in with GitHub first"))?;
    // rust: let sent = headers.get("x-csrf-token").and_then(|v| v.to_str().ok());
    // rust: if sent.is_none() || sent.map(str::to_owned) != csrf(app, headers) {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::FORBIDDEN,
    // rust: "reload the page and try again",
    // rust: ));
}
    // rust: Ok(account)
}

/// Counts one more for `login` and for everyone, unless either is at its
/// hourly limit.
pub fn allow(windows: *Windows, login: []const u8, per_account: usize, per_hour: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut windows = windows.lock().unwrap();
    // rust: let account = login.to_lowercase();
    // rust: let ok = take(windows.entry(String::new()).or_default(), per_hour)
    // rust: && take(windows.entry(account.clone()).or_default(), per_account);
    // rust: if ok {
    // rust: let at = Instant::now();
    // rust: windows.entry(String::new()).or_default().push_back(at);
    // rust: windows.entry(account).or_default().push_back(at);
}
    // rust: ok
}

/// The answer to a file that is too big.
pub fn too_big() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Refusal::new(
    // rust: StatusCode::PAYLOAD_TOO_LARGE,
    // rust: format!("the file is over {} MiB", index::MAX_FILE >> 20),
    // rust: )
}

/// A form that broke off: over the body's limit, or not a form.
pub fn torn(e: MultipartError) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if e.status() == StatusCode::PAYLOAD_TOO_LARGE {
    // rust: too_big()
    // rust: } else {
    // rust: bad(e.body_text())
}
}

/// Reads and drops the rest of a refused submission, up to its limit. A
/// browser still sending the file when the answer comes reports a network
/// error instead of the answer, so the answer waits for the upload's end.
pub fn drain(body: Body) void {
}
//     use http_body_util::BodyExt;
    // rust: let mut body = http_body_util::Limited::new(body, MAX_BODY);
    // rust: while let Some(Ok(_)) = body.frame().await {}
}

/// The rest of a form, past a part that was refused.
pub fn drain_form(multipart: *mut Multipart) void {
}
    // rust: while let Ok(Some(mut field)) = multipart.next_field().await {
    // rust: while let Ok(Some(_)) = field.chunk().await {}
}
}

    // rust: async fn submit(
    // rust: State(app): State<App>,
    // rust: request: Request,
    // rust: ) -> Result<Json<serde_json::Value>, Refusal> {
    // rust: let inner = app.0.clone();
    // rust: let (parts, body) = request.into_parts();
    // rust: let checked = signed_in_here(&inner, &parts.headers).and_then(|account| {
    // rust: let length = parts.headers.get(header::CONTENT_LENGTH);
    // rust: if length.and_then(|l| l.to_str().ok()?.parse::<usize>().ok()) > Some(MAX_BODY) {
    // rust: return Err(too_big());
}
    // rust: if !allow(&inner.recent, &account.0, PER_ACCOUNT, PER_HOUR) {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::TOO_MANY_REQUESTS,
    // rust: "too many submissions this hour: try again later",
    // rust: ));
}
    // rust: Ok(account)
    // rust: });
    // rust: let (login, user_id) = match checked {
    // rust: Ok(account) => account,
    // rust: Err(refusal) => {
            // Too big: what's past the limit would be cut anyway.
    // rust: if refusal.0 != StatusCode::PAYLOAD_TOO_LARGE {
    // rust: drain(body).await;
}
    // rust: return Err(refusal);
}
}
    // rust: let mut multipart = Multipart::from_request(Request::from_parts(parts, body), &())
    // rust: .await
    // rust: .map_err(|e| bad(e.body_text()))?;
    // rust: let dir = inner.config.scratch.join(random_hex());
    // rust: if let Err(e) = std::fs::create_dir_all(&dir) {
    // rust: drain_form(&mut multipart).await;
    // rust: return Err(Refusal::new(
    // rust: StatusCode::INTERNAL_SERVER_ERROR,
    // rust: e.to_string(),
    // rust: ));
}
    // rust: let result = receive(&mut multipart, &dir).await;
    // rust: if result.is_err() {
    // rust: drain_form(&mut multipart).await;
}
    // rust: let result = match result {
    // rust: Ok((form, file, images)) => {
    // rust: let inner = inner.clone();
    // rust: tokio::task::spawn_blocking(move || match &file {
    // rust: Some(file) => publish(&inner.config, &login, user_id, &form, file, &images),
    // rust: None => page::edit(&inner.config, &login, user_id, &form, &images),
    // rust: })
    // rust: .await
    // rust: .unwrap_or_else(|_| {
    // rust: Err(Refusal::new(
    // rust: StatusCode::INTERNAL_SERVER_ERROR,
    // rust: "the check crashed",
    // rust: ))
    // rust: })
}
    // rust: Err(e) => Err(e),
}
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: result.map(|url| Json(json!({"pull_request": url})))
}

/// Reads the form's parts: `entry` (JSON), `file`, streamed to `dir`, and the images, `icon`
/// and up to 8 `screenshot`s.
    // rust: async fn receive(
    // rust: multipart: &mut Multipart,
    // rust: dir: &Path,
    // rust: ) -> Result<(Form, Option<PathBuf>, page::Uploads), Refusal> {
//     use tokio::io::AsyncWriteExt;
    // rust: let (mut form, mut file) = (None, None);
    // rust: let mut images = page::Uploads::default();
    // rust: while let Some(mut field) = multipart.next_field().await.map_err(torn)? {
    // rust: match field.name() {
    // rust: Some(part @ ("icon" | "screenshot")) => {
    // rust: let part = part.to_owned();
    // rust: let name = field.file_name().unwrap_or("").to_owned();
    // rust: let mut bytes = Vec::new();
    // rust: while let Some(chunk) = field.chunk().await.map_err(torn)? {
    // rust: bytes.extend_from_slice(&chunk);
    // rust: if bytes.len() > page::MAX_IMAGE {
    // rust: return Err(bad(format!("{part} {name:?} is too big")));
}
}
    // rust: images.add(&part, &name, bytes).map_err(bad)?;
}
    // rust: Some("entry") => {
    // rust: let text = field.text().await.map_err(torn)?;
    // rust: if text.len() > MAX_FORM {
    // rust: return Err(bad("the page's text is too long"));
}
    // rust: form = Some(serde_json::from_str::<Form>(&text).map_err(|e| bad(e.to_string()))?);
}
    // rust: Some("file") => {
    // rust: let path = dir.join("upload");
    // rust: let mut out = tokio::fs::File::create(&path)
    // rust: .await
    // rust: .map_err(|e| Refusal::new(StatusCode::INTERNAL_SERVER_ERROR, e.to_string()))?;
    // rust: let mut size = 0u64;
    // rust: while let Some(chunk) = field.chunk().await.map_err(torn)? {
    // rust: size += chunk.len() as u64;
    // rust: if size > index::MAX_FILE {
    // rust: return Err(too_big());
}
    // rust: out.write_all(&chunk).await.map_err(|e| {
    // rust: Refusal::new(StatusCode::INTERNAL_SERVER_ERROR, e.to_string())
    // rust: })?;
}
    // rust: out.flush().await.ok();
    // rust: file = Some(path);
}
    // rust: _ => {}
}
}
    // rust: match (form, file) {
    // rust: (Some(form), _) if form.repo.is_some() => Err(bad(
    // rust: "the registry doesn't follow repositories: submit each version's file here, so it is checked and reviewed",
    // rust: )),
    // rust: (Some(form), None) if form.edit => Ok((form, None, images)),
    // rust: (Some(form), Some(file)) if !form.edit => Ok((form, Some(file), images)),
    // rust: _ => Err(bad("send the page and the file")),
}
}

/// `YYYY-MM-DD` of a Unix time (UTC).
pub fn date(secs: u64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // Howard Hinnant's days-to-civil.
    // rust: let z = (secs / 86400) as i64 + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z - era * 146_097;
    // rust: let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146_096) / 365;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let d = doy - (153 * mp + 2) / 5 + 1;
    // rust: let m = if mp < 10 { mp + 3 } else { mp - 9 };
    // rust: let y = yoe + era * 400 + i64::from(m <= 2);
    // rust: format!("{y:04}-{m:02}-{d:02}")
}

/// A key for submission tags, separate from the signed-cookie format. Keeping
/// the domains distinct means a public tag can never be repackaged as a
/// session cookie.
pub fn submission_key(config: *Config) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mac = Hmac::<Sha256>::new_from_slice(&config.session_key).expect("any key length");
    // rust: mac.update(b"submission-tag-v1");
    // rust: mac.finalize().into_bytes().into()
}

/// What a submission branch's commit carries to say the form wrote it for
/// `login`: signed with the service's submission key, so a retry by the same
/// account may start that branch again.
pub fn submission_tag(config: *Config, branch: []const u8, login: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mac = Hmac::<Sha256>::new_from_slice(&submission_key(config)).expect("32 bytes");
    // rust: mac.update(format!("submission\n{branch}\n{}", login.to_lowercase()).as_bytes());
    // rust: URL_SAFE_NO_PAD.encode(mac.finalize().into_bytes())
}

pub fn submission_tag_valid(config: *Config, branch: []const u8, login: []const u8, tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(tag) = URL_SAFE_NO_PAD.decode(tag) else {
    // rust: return false;
}
    // rust: let mut mac = Hmac::<Sha256>::new_from_slice(&submission_key(config)).expect("32 bytes");
    // rust: mac.update(format!("submission\n{branch}\n{}", login.to_lowercase()).as_bytes());
    // rust: mac.verify_slice(&tag).is_ok()
}

/// How a signed-in account relates to a project's owners.
pub const Ownership = enum {
    /// Its numeric ID is one of `owner_ids`: the account that listed it (or was added), whatever
    /// its login is now.
    ById,
    /// The entry records no IDs (from before they were recorded) and its login is listed: an owner
    /// as far as anyone can tell, but its updates always wait for a reviewer.
    ByLoginOnly,
    None,
};

/// Who `login` (GitHub account `user_id`) is to `entry`. When the entry has IDs, only they count: a
/// login listed in `owners` but held by another account is someone who claimed it after a rename.
pub fn ownership(entry: *Entry, login: []const u8, user_id: u64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !entry.owner_ids.is_empty() {
    // rust: return if entry.owner_ids.contains(&user_id) {
    // rust: Ownership::ById
    // rust: } else {
    // rust: Ownership::None
}
}
    // rust: if entry.owners.iter().any(|o| o.eq_ignore_ascii_case(login)) {
    // rust: Ownership::ByLoginOnly
    // rust: } else {
    // rust: Ownership::None
}
}

/// The trailer of an owner update's pull request: a comment holding what the
/// update is and an HMAC-SHA256 (hex, with `key`) over it, which the registry
/// repository's `owner-update` workflow verifies with the same secret
/// (`scripts/owner_update.py` there builds the same message). v2 adds the
/// submitter's numeric GitHub ID, which the workflow checks against the
/// entry's `owner_ids` on main.
    // rust: pub fn update_trailer(
    // rust: key: &[u8],
    // rust: id: &str,
    // rust: version: &str,
    // rust: sha256: &str,
    // rust: file: &str,
    // rust: submitter: &str,
    // rust: submitter_id: u64,
    // rust: ) -> String {
    // rust: let message =
    // rust: format!("owner-update-v2\n{id}\n{version}\n{sha256}\n{file}\n{submitter}\n{submitter_id}");
    // rust: let mut mac = Hmac::<Sha256>::new_from_slice(key).expect("HMAC takes any key length");
    // rust: mac.update(message.as_bytes());
    // rust: let hmac: String = mac
    // rust: .finalize()
    // rust: .into_bytes()
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect();
    // rust: format!(
    // rust: "<!-- owner-update\nformat: v2\nid: {id}\nversion: {version}\nsha256: {sha256}\nfile: {file}\nsubmitter: {submitter}\nsubmitter_id: {submitter_id}\nhmac: {hmac}\n-->"
    // rust: )
}

/// The submission, past its checks: the entry written on a new branch and a
/// pull request opened. Returns the pull request's address.
    // rust: pub fn publish(
    // rust: config: &Config,
    // rust: login: &str,
    // rust: user_id: u64,
    // rust: form: &Form,
    // rust: file: &Path,
    // rust: images: &page::Uploads,
    // rust: ) -> Result<String, Refusal> {
    // rust: let gh = &config.github;
    // rust: let kind = Kind::from(form.kind.clone());
    // rust: registry::open(&kind).map_err(bad)?;
    // rust: if !index::valid_id(&form.id) {
    // rust: return Err(bad("an id is 1 to 64 of a-z, 0-9 and _"));
}
    // rust: page::check_form(form, &kind).map_err(bad)?;
    // rust: if !form.source.trim().starts_with("https://") {
    // rust: return Err(bad("the source must be an https:// address of the code"));
}
    // rust: if form.name.trim().is_empty() || form.license.trim().is_empty() {
    // rust: return Err(bad("a project needs a name and a licence"));
}
    // The file's own checks first: a wrong file never reaches GitHub.
    // rust: archive::check(file).map_err(bad)?;
    // rust: let facts = index::inspect(&kind, file).map_err(bad)?;
    // rust: if let Some(id) = facts.id.as_ref().filter(|id| **id != form.id) {
    // rust: return Err(bad(format!("the file's id is {id:?}, not {:?}", form.id)));
}
    // rust: if let Some(v) = facts
    // rust: .version
    // rust: .as_ref()
    // rust: .filter(|v| **v != form.version.trim())
    // rust: {
    // rust: return Err(bad(format!(
    // rust: "the file says version {v:?}, not {:?}",
    // rust: form.version.trim()
    // rust: )));
}
    // rust: let sha256 = index::sha256_file(file).map_err(bad)?;
    // rust: let extension = kind.extension().unwrap_or("zip");
    // rust: let version = EntryVersion {
    // rust: version: form.version.trim().to_owned(),
    // rust: published: date(now()),
    // rust: game: form.game.trim().to_owned(),
    // rust: file: format!("{}-{}.{extension}", form.id, form.version.trim()),
    // rust: sha256: sha256.clone(),
    // rust: signature: form.signature.clone().filter(|s| !s.trim().is_empty()),
    // rust: changelog: form.changelog.clone(),
}
    // rust: let existing = gh.entry(&form.id).map_err(github_down)?;
    // rust: let is_new = existing.is_none();
    // rust: if is_new {
    // rust: page::check_new(form, images).map_err(bad)?;
}
    // rust: let turns_native =
    // rust: kind == Kind::NativeMod && existing.as_ref().is_some_and(|(e, _)| e.kind == Kind::Mod);
    // An owner update: an owner's new version and nothing else of the entry
    // changes (key and owners included).
    // rust: let mut owner_update = false;
    // rust: let mut matched = Ownership::ById;
    // rust: let (entry, blob) = match existing {
    // rust: None => (
    // rust: Entry {
    // rust: id: form.id.clone(),
    // rust: repo: None,
    // rust: kind: kind.clone(),
    // rust: name: form.name.trim().to_owned(),
    // rust: summary: form.summary.trim().to_owned(),
    // rust: description: form.description.clone(),
    // rust: authors: form.authors.clone(),
    // rust: owners: vec![login.to_owned()],
    // rust: owner_ids: vec![user_id],
    // rust: license: form.license.trim().to_owned(),
    // rust: source: form.source.trim().to_owned(),
    // rust: icon: None,
    // rust: categories: form.categories.clone(),
    // rust: tags: form.tags.clone(),
    // rust: screenshots: Vec::new(),
    // rust: key: form.key.clone().filter(|k| !k.trim().is_empty()),
    // rust: versions: vec![version.clone()],
    // rust: },
    // rust: None,
    // rust: ),
    // rust: Some((mut entry, blob)) => {
    // rust: matched = ownership(&entry, login, user_id);
    // rust: if matched == Ownership::None {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::FORBIDDEN,
    // rust: format!(
    // rust: "{} is {}'s: only its owners publish its updates",
    // rust: form.id,
    // rust: entry.owners.join(", ")
    // rust: ),
    // rust: ));
}
    // rust: if let Some(repo) = &entry.repo {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::CONFLICT,
    // rust: format!(
    // rust: "{} is listed by its repository: publish a GitHub release in https://github.com/{repo} and it shows up within the hour",
    // rust: form.id
    // rust: ),
    // rust: ));
}
            // A mod may turn native once, never back (`registry::review`,
            // docs/native-mods.md): its `.hmod` versions stay published.
    // rust: if entry.kind != kind {
    // rust: if (&entry.kind, &kind) != (&Kind::Mod, &Kind::NativeMod) {
    // rust: return Err(bad(format!(
    // rust: "{} is a {}, not a {}: a project's kind never changes (only a mod may turn native-mod, once)",
    // rust: form.id,
    // rust: entry.kind.name(),
    // rust: kind.name()
    // rust: )));
}
    // rust: entry.kind = kind.clone();
}
    // rust: if entry.versions.iter().any(|v| v.version == version.version) {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::CONFLICT,
    // rust: format!(
    // rust: "{} {} is already published: give this file a new version",
    // rust: form.id, version.version
    // rust: ),
    // rust: ));
}
    // rust: let key = form.key.clone().filter(|k| !k.trim().is_empty());
    // rust: if key.is_some() && key != entry.key {
    // rust: return Err(bad(
    // rust: "changing a project's key is a pull request by hand, reviewed on its own",
    // rust: ));
}
    // rust: let before = entry.clone();
    // rust: entry.name = form.name.trim().to_owned();
    // rust: entry.summary = form.summary.trim().to_owned();
    // rust: entry.description = form.description.clone();
    // rust: entry.authors = form.authors.clone();
    // rust: entry.license = form.license.trim().to_owned();
    // rust: entry.source = form.source.trim().to_owned();
    // rust: entry.categories = form.categories.clone();
    // rust: entry.tags = form.tags.clone();
    // rust: entry.versions.insert(0, version.clone());
    // rust: let (mut a, mut b) = (entry.clone(), before);
    // rust: a.versions.clear();
    // rust: b.versions.clear();
            // A mod turning native is reviewed by hand, never an owner update.
            // Only an owner known by ID publishes on their own: a login match alone
            // could be someone who claimed the login after a rename.
    // rust: owner_update = matched == Ownership::ById
    // rust: && a == b
    // rust: && images.is_empty()
    // rust: && !turns_native
    // rust: && (entry.key.is_none() || version.signature.is_some())
    // rust: && version
    // rust: .version
    // rust: .bytes()
    // rust: .all(|c| c.is_ascii_alphanumeric() || b".-+_".contains(&c));
    // rust: (entry, Some(blob))
}
}
    // rust: let mut entry = entry;
    // rust: let writes = page::place(&mut entry, form, images).map_err(bad)?;
    // Every check CI runs but the trial run: the file as its kind, its id and
    // version, its signature, the entry's fields. CI runs it all again.
    // rust: let files = file.parent().unwrap_or(Path::new("."));
    // rust: std::fs::copy(file, files.join(&sha256)).map_err(|e| bad(e.to_string()))?;
    // rust: let mut checked = entry.clone();
    // rust: checked.versions.truncate(1);
    // The images were checked by `page`; the registry's own files aren't in this scratch folder.
    // rust: checked.icon = None;
    // rust: checked.screenshots.clear();
    // rust: let project = registry::project(
    // rust: &checked,
    // rust: &Sources {
    // rust: registry: files,
    // rust: files,
    // rust: release: index::FILE_HOST,
    // rust: site: "https://example.invalid/",
    // rust: generated: String::new(),
    // rust: },
    // rust: )
    // rust: .map_err(|errors| bad(errors.join("; ")))?;
    // rust: let text = entry.to_toml().map_err(bad)?;
    // rust: gh.stage(&format!("{sha256}.{extension}"), file)
    // rust: .map_err(github_down)?;
    // rust: let branch = format!("submit/{}-{}", form.id, version.version);
    // Its commit's record of whose it is: only this service can write it,
    // where a commit's text or author can be anyone's who writes to the repository.
    // rust: let submission = submission_tag(config, &branch, login);
    // rust: if !gh.branch(&branch).map_err(github_down)? {
        // The branch is there: a pull request, someone else's submission, or
        // this submitter's own that GitHub broke off (a timeout past the
        // branch's creation). Only the last is taken up again, from main: the
        // branch holds no commit yet, or only those this form wrote for them.
    // rust: if let Some(url) = gh.open_pull(&branch).map_err(github_down)? {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::CONFLICT,
    // rust: format!(
    // rust: "{} {} was already submitted: its pull request is open ({url})",
    // rust: form.id, version.version
    // rust: ),
    // rust: ));
}
    // rust: let commits = gh.commits(&branch).map_err(github_down)?;
        // Every commit the form wrote (the entry, then its images) carries the tag; one without
        // it is someone else's.
    // rust: let theirs = commits.iter().all(|m| {
    // rust: m.lines().any(|line| {
    // rust: line.trim()
    // rust: .strip_prefix("Submission:")
    // rust: .is_some_and(|tag| submission_tag_valid(config, &branch, login, tag.trim()))
    // rust: })
    // rust: });
    // rust: if !theirs {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::CONFLICT,
    // rust: format!(
    // rust: "{} {} was already submitted by someone else: give this file a new version",
    // rust: form.id, version.version
    // rust: ),
    // rust: ));
}
    // rust: gh.reset(&branch).map_err(github_down)?;
}
    // rust: let what = if is_new { "Add" } else { "Update" };
    // rust: let message = format!(
    // rust: "{what} {} {}\n\nSubmitted by @{login} through the form.\n\nSubmission: {submission}\nCo-authored-by: {login} <{user_id}+{login}@users.noreply.github.com>",
    // rust: form.id, version.version
    // rust: );
    // rust: gh.put(
    // rust: &format!("mods/{}.toml", form.id),
    // rust: &text,
    // rust: &branch,
    // rust: blob.as_deref(),
    // rust: &message,
    // rust: )
    // rust: .map_err(github_down)?;
    // rust: page::write(gh, &writes, &branch, &message)?;
    // rust: let v = &project.versions[0];
    // rust: let capabilities: Vec<String> = v
    // rust: .capabilities
    // rust: .iter()
    // rust: .map(|c| format!("- may {}", c.describe()))
    // rust: .collect();
    // rust: let requires: Vec<String> = v
    // rust: .requires
    // rust: .iter()
    // rust: .map(|r| format!("- needs {} {}", r.id, r.version))
    // rust: .collect();
    // rust: let body = format!(
    // rust: "<!-- submitted-by: {login} -->\n🤖 Submitted through [{site}]({public}/mods/submit) by @{login}. The form opens the pull request with \
    // rust: the registry's token: neither Ludovic nor a reviewer wrote it.\n\n\
    // rust: | | |\n|---|---|\n| Project | `{id}` ({kind}, {new}) |\n| Version | {version} for {game} |\n| File | `{file}`, {size} bytes, SHA-256 `{sha256}` |\n| Signed | {signed} |\n| Source | {source} |\n\n{lists}\n\n\
    // rust: The checks below run the file's own checks again and, for a mod, a trial run in the sandbox. \
    // rust: Reviewers: read the source and the checks' report before you approve.",
    // rust: public = config.public_url,
    // rust: site = config
    // rust: .public_url
    // rust: .split_once("://")
    // rust: .map_or(config.public_url.as_str(), |(_, host)| host),
    // rust: id = form.id,
    // rust: kind = kind.name(),
    // rust: new = if is_new {
    // rust: "new"
    // rust: } else if turns_native {
    // rust: "update: turns native, its `.hmod` versions stay published"
    // rust: } else {
    // rust: "update"
    // rust: },
    // rust: version = v.version,
    // rust: game = v.game,
    // rust: file = v.file.name,
    // rust: size = v.file.size,
    // rust: signed = if entry.key.is_some() {
    // rust: "yes, with the project's key"
    // rust: } else {
    // rust: "no"
    // rust: },
    // rust: source = entry.source,
    // rust: lists = [capabilities, requires].concat().join("\n"),
    // rust: );
    // rust: let body = if matched == Ownership::ByLoginOnly {
    // rust: format!(
    // rust: "{body}\n\n⚠️ This entry records no owner IDs, so @{login} (GitHub ID {user_id}) was matched by login only. \
    // rust: Check it is the same account that listed the project (a renamed owner's login can be claimed by anyone), \
    // rust: then add `owner_ids = [{user_id}]` to the entry."
    // rust: )
    // rust: } else {
    // rust: body
}
    // rust: let trailer = config
    // rust: .update_key
    // rust: .as_deref()
    // rust: .filter(|_| owner_update)
    // rust: .map(|key| {
    // rust: update_trailer(
    // rust: key,
    // rust: &form.id,
    // rust: &version.version,
    // rust: &sha256,
    // rust: &v.file.name,
    // rust: login,
    // rust: user_id,
    // rust: )
    // rust: });
    // rust: let body = match &trailer {
    // rust: Some(t) => format!("{body}\n\n{t}"),
    // rust: None => body,
}
    // rust: let (url, number) = gh
    // rust: .pull(
    // rust: &format!("{what} {} {}", form.id, version.version),
    // rust: &branch,
    // rust: &body,
    // rust: )
    // rust: .map_err(github_down)?;
    // rust: if trailer.is_some() {
        // The pull request is open: a label that fails only leaves it to a reviewer.
    // rust: if let Err(e) = gh.label(number, "owner-update") {
    // rust: eprintln!("labelling {url}: {} {}", e.status, e.message);
}
}
    // rust: Ok(url)
}

    // rust: mod tests {
//     use super::*;

pub fn dates_and_signatures() void {
}
    // rust: assert_eq!(date(0), "1970-01-01");
    // rust: assert_eq!(date(1_792_800_000), "2026-10-24");
    // rust: let key = b"0123456789abcdef0123456789abcdef";
    // rust: let signed = sign(key, "alice\n7\n99");
    // rust: assert_eq!(unsign(key, &signed).as_deref(), Some("alice\n7\n99"));
    // rust: assert_eq!(unsign(b"another key, another key, another", &signed), None);
    // rust: let forged = format!(
    // rust: "{}.{}",
    // rust: URL_SAFE_NO_PAD.encode("mallory\n8\n99"),
    // rust: signed.split_once('.').unwrap().1
    // rust: );
    // rust: assert_eq!(unsign(key, &forged), None);
}

pub fn submission_tags_are_not_session_cookies() void {
}
    // rust: let key = b"0123456789abcdef0123456789abcdef";
    // rust: let config = Config {
    // rust: public_url: "https://example.invalid".into(),
    // rust: session_key: key.to_vec(),
    // rust: github: GitHub::new(
    // rust: github::Endpoints::default(),
    // rust: "owner/repo".into(),
    // rust: "client".into(),
    // rust: "secret".into(),
    // rust: "token".into(),
    // rust: ),
    // rust: update_key: None,
    // rust: scratch: PathBuf::from("/tmp/horizon-mod-registry-test"),
    // rust: database: PathBuf::from(":memory:"),
}
    // rust: let branch = "submit/example-1.0.0";
    // rust: let login = "12345678901";
    // rust: let tag = submission_tag(&config, branch, login);
    // rust: assert!(submission_tag_valid(&config, branch, login, &tag));

    // rust: let payload = format!("submission\n{branch}\n{login}");
    // rust: let cookie = format!("{}.{}", URL_SAFE_NO_PAD.encode(payload), tag);
    // rust: assert_eq!(unsign(&config.session_key, &cookie), None);
}

pub fn a_page_is_known_by_its_origin() void {
}
        // An `Origin` has no path, though REGISTRY_PUBLIC_URL may: the site's
        // pages are below its root (#6159).
    // rust: assert_eq!(
    // rust: url_origin("https://playhorizon.dev/mods"),
    // rust: "https://playhorizon.dev"
    // rust: );
    // rust: assert_eq!(
    // rust: url_origin("https://playhorizon.dev/mods/submit/"),
    // rust: "https://playhorizon.dev"
    // rust: );
    // rust: assert_eq!(
    // rust: url_origin("https://playhorizon.dev"),
    // rust: "https://playhorizon.dev"
    // rust: );
    // rust: assert_eq!(
    // rust: url_origin("http://localhost:8080/mods"),
    // rust: "http://localhost:8080"
    // rust: );
        // The configured site's origin, path or no path, and a host name's
        // case folded as a browser folds it.
    // rust: assert!(from_the_site(
    // rust: "https://playhorizon.dev/mods",
    // rust: Some("https://playhorizon.dev")
    // rust: ));
    // rust: assert!(from_the_site(
    // rust: "https://playhorizon.dev/hub/",
    // rust: Some("https://PlayHorizon.dev")
    // rust: ));
        // The scheme, the host and the port are all the origin's.
    // rust: assert!(!from_the_site(
    // rust: "https://playhorizon.dev",
    // rust: Some("http://playhorizon.dev")
    // rust: ));
    // rust: assert!(!from_the_site(
    // rust: "https://playhorizon.dev",
    // rust: Some("https://playhorizon.dev:8443")
    // rust: ));
        // Another site's page, a page with no origin to give, and a name
        // that only starts like the host.
    // rust: assert!(!from_the_site(
    // rust: "https://playhorizon.dev",
    // rust: Some("https://evil.test")
    // rust: ));
    // rust: assert!(!from_the_site("https://playhorizon.dev", None));
    // rust: assert!(!from_the_site(
    // rust: "https://playhorizon.dev",
    // rust: Some("https://playhorizon.dev.evil.test")
    // rust: ));
    // rust: assert!(!from_the_site("::", Some("null")));
}
}
