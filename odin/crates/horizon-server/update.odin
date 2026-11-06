//! Transpiled from Horizon Rust crate
package horizon_server_update

import "core:fmt"
import "core:mem"
import "core:math"

// Updates and rollbacks (docs/server.md, section 7) for a `horizon-server` installed by install.sh or
// install.ps1: each release in `<dir>/releases/<tag>`, `<dir>/current` pointing at the one in use, and
// `<dir>/previous` naming the one before it. An update downloads the current Nightly from GitHub (the only build
// Horizon ships since 2026-10-28; GitHub's latest release while there is none), checks it against the SHA-256 in
// its signed SHA256SUMS (docs/security.md), unpacks it beside the others as `nightly-<date>-<commit>` and switches
// `current`; the supervisor then restarts the game on it and switches back by itself if the new game doesn't come
// up.

// use crate::{api::Client, backup, config::Config, engine, supervisor};
// use serde_json::{Value, json};
// use std::{
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
    // rust: time::{Duration, Instant},
}

REPO :: "horizon-rust/horizon"
// The release archives for this computer, most specific first: on Linux the server build (no ALSA or
// udev), else the full game (releases before the server build).
assets_for :: proc(os: string, arch: string, musl: bool) -> ^ {
    // Ported from Horizon
    return {}
}
    // The musl archive is manually installed; glibc updates would replace this supervisor
    // with a binary that cannot even start to roll back on a musl system.
    // rust: if musl {
    // rust: return &[];
}
    // rust: match (os, arch) {
    // rust: ("linux", "x86_64") => &[
    // rust: "horizon-server-linux-x86_64.tar.gz",
    // rust: "horizon-linux-x86_64.tar.gz",
    // rust: ],
    // rust: ("macos", "aarch64") => &["horizon-macos-arm64.zip"],
    // rust: ("macos", "x86_64") => &["horizon-macos-x64.zip"],
        // A release without an ARM64 build: the x64 one, which Windows runs under emulation.
    // rust: ("windows", "aarch64") => &["horizon-windows-arm64.zip", "horizon-windows-x64.zip"],
    // rust: ("windows", "x86_64") => &["horizon-windows-x64.zip"],
    // rust: _ => &[],
}
}

    // rust: static ASSETS: std::sync::LazyLock<&'static [&'static str]> = std::sync::LazyLock::new(|| {
    // rust: assets_for(
    // rust: std::env::consts::OS,
    // rust: std::env::consts::ARCH,
    // rust: cfg!(target_env = "musl"),
    // rust: )
    // rust: });

exe :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{name}{}", std::env::consts::EXE_SUFFIX)
}

// The installer's folder: `releases/`, `current`, `previous` and `game-files/`.
Install :: struct {
    root: PathBuf,
}

    // rust: impl Install {
    // The install this program runs from, if it runs from one.
find :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::around(&std::env::current_exe().ok()?)
}

    // The install holding `program` (`<root>/releases/<tag>/horizon-server`, reached directly or through
    // `current`).
around :: proc(program: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let program = std::fs::canonicalize(program).ok()?;
    // rust: let releases = program.parent()?.parent()?;
    // rust: if releases.file_name()? != "releases" {
    // rust: return None;
}
    // rust: let root = releases.parent()?.to_path_buf();
    // rust: root.join("current").is_dir().then_some(Self { root })
}

    // The install, or why there is none to update.
required :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::find().ok_or_else(|| {
    // rust: "this horizon-server wasn't installed by install.sh or install.ps1 (no releases/ and current \
    // rust: around it): update it the way you installed it"
    // rust: .into()
    // rust: })
}

release :: proc(self: ^Self, tag: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.root.join("releases").join(tag)
}

    // Where the game programs in use are: `current`, so a switch applies at the next start.
programs :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.root.join("current")
}

    // The release in use.
current :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let target = std::fs::canonicalize(self.root.join("current")).ok()?;
    // rust: Some(target.file_name()?.to_string_lossy().into_owned())
}

    // The release used before the current one, if it is still there.
previous :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let tag = std::fs::read_to_string(self.root.join("previous")).ok()?;
    // rust: let tag = tag.trim();
    // rust: (!tag.is_empty() && self.release(tag).is_dir()).then(|| tag.to_owned())
}

    // Points `current` at the release `tag`, and remembers the one it pointed at as `previous`.
switch :: proc(self: ^Self, tag: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let target = self.release(tag);
    // rust: if !target.join(exe("horizon-server")).is_file() {
    // rust: return Err(format!("{} holds no horizon-server", target.display()));
}
    // rust: if let Some(old) = self.current().filter(|old| old != tag) {
    // rust: std::fs::write(self.root.join("previous"), format!("{old}\n"))
    // rust: .map_err(|e| format!("{}: {e}", self.root.join("previous").display()))?;
}
    // rust: point(&self.root.join("current"), &target)
    // rust: .map_err(|e| format!("switching current to {tag}: {e}"))
}

    // Undoes a [`Install::switch`]: `current` back on `from` and `previous` as it was before, so a later
    // rollback doesn't go to the release that failed.
switch_back :: proc(self: ^Self, from: string, previous: Maybe(string)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: point(&self.root.join("current"), &self.release(from))
    // rust: .map_err(|e| format!("switching current back to {from}: {e}"))?;
    // rust: let file = self.root.join("previous");
    // rust: match previous {
    // rust: Some(tag) => std::fs::write(&file, format!("{tag}\n")),
    // rust: None => std::fs::remove_file(&file).or_else(|e| {
    // rust: if e.kind() == std::io::ErrorKind::NotFound {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(e)
}
    // rust: }),
}
    // rust: .map_err(|e| format!("{}: {e}", file.display()))
}

    // Deletes old releases after a successful update: it keeps the one `current` points at, the one
    // `previous` names (where `rollback` goes), the one this program runs from, and the `keep` newest of
    // the others. Returns the releases deleted, and what couldn't be (a program still running from it on
    // Windows), which stays for the next update to try again.
prune :: proc(self: ^Self, keep: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let releases = self.root.join("releases");
    // rust: let running = std::env::current_exe()
    // rust: .ok()
    // rust: .and_then(|e| std::fs::canonicalize(e).ok());
    // rust: let Some(current) = self.current() else {
            // `current` points nowhere: nothing is known to be safe to delete.
    // rust: return (Vec::new(), Vec::new());
}
    // rust: let previous = self.previous();
    // rust: let mut others: Vec<String> = std::fs::read_dir(&releases)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter(|e| e.file_type().is_ok_and(|t| t.is_dir()))
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
            // `.<tag>.unpacking` is an update in progress.
    // rust: .filter(|tag| {
    // rust: !tag.starts_with('.') && *tag != current && previous.as_deref() != Some(tag)
    // rust: })
    // rust: .filter(|tag| {
    // rust: let dir = std::fs::canonicalize(releases.join(tag)).ok();
    // rust: !running
    // rust: .as_ref()
    // rust: .zip(dir)
    // rust: .is_some_and(|(exe, dir)| exe.starts_with(dir))
    // rust: })
    // rust: .collect();
        // Newest first; names that aren't release tags (archives installed by hand) by name.
    // rust: others.sort_by(|a, b| {
    // rust: if newer(a, b) {
    // rust: std::cmp::Ordering::Less
    // rust: } else if newer(b, a) {
    // rust: std::cmp::Ordering::Greater
    // rust: } else {
    // rust: b.cmp(a)
}
    // rust: });
    // rust: let (mut removed, mut failed) = (Vec::new(), Vec::new());
    // rust: for tag in others.into_iter().skip(keep as usize) {
    // rust: match std::fs::remove_dir_all(releases.join(&tag)) {
    // rust: Ok(()) => removed.push(tag),
    // rust: Err(e) => failed.push(format!("{tag} ({e})")),
}
}
    // rust: (removed, failed)
}
}

// What [`Install::prune`] did, for the log: empty when it deleted nothing.
pruned :: proc(removed: ^[string], failed: ^[string]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = Vec::new();
    // rust: if !removed.is_empty() {
    // rust: parts.push(format!("Deleted old releases: {}", removed.join(", ")));
}
    // rust: if !failed.is_empty() {
    // rust: parts.push(format!(
    // rust: "Couldn't delete old releases: {}",
    // rust: failed.join(", ")
    // rust: ));
}
    // rust: parts.join(". ")
}

// Makes `link` point at the folder `target`, replacing what it pointed at.
point :: proc(link: ^Path, target: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // A new link renamed over the old one: `current` always points at a whole release.
    // rust: let fresh = link.with_extension("switching");
    // rust: let _ = std::fs::remove_file(&fresh);
    // rust: std::os::unix::fs::symlink(target, &fresh)?;
    // rust: std::fs::rename(&fresh, link)
}

// Makes `link` a junction to `target` (install.ps1's links: they need no admin rights). The new
// junction is made first, beside it, so a failure leaves `current` as it was; it then takes the old
// one's place, and if that last step fails the old junction is put back.
point :: proc(link: ^Path, target: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let fresh = link.with_extension("switching");
    // rust: if fresh.symlink_metadata().is_ok() {
    // rust: std::fs::remove_dir(&fresh)?;
}
    // rust: junction(&fresh, target)?;
    // rust: let old = std::fs::read_link(link).ok();
    // rust: if link.symlink_metadata().is_ok() {
        // A junction: removing it removes the link, never the release it points at.
    // rust: if let Err(e) = std::fs::remove_dir(link) {
    // rust: let _ = std::fs::remove_dir(&fresh);
    // rust: return Err(e);
}
}
    // rust: std::fs::rename(&fresh, link).inspect_err(|_| {
    // rust: let _ = std::fs::remove_dir(&fresh);
    // rust: if let Some(old) = &old {
    // rust: let _ = junction(link, old);
}
    // rust: })
}

// `mklink /J link target` through cmd, with both paths quoted as cmd reads them: unquoted, a folder
// named with `&` or `^` (and no space, so std doesn't quote it) would split the command. `%` and `"`
// keep a meaning inside quotes, so paths holding them are refused.
junction :: proc(link: ^Path, target: ^Path) -> s {
    // Ported from Horizon
    return {}
}
//     use std::os::windows::process::CommandExt;
    // rust: let quoted = |p: &Path| -> std::io::Result<String> {
    // rust: let text = p.to_str().ok_or_else(|| {
    // rust: std::io::Error::other(format!("{}: not a path cmd can take", p.display()))
    // rust: })?;
    // rust: if text.contains(['%', '"']) {
    // rust: return Err(std::io::Error::other(format!(
    // rust: "{text}: a folder whose path holds % or \" can't be linked; move the server elsewhere"
    // rust: )));
}
    // rust: Ok(format!("\"{text}\""))
}
    // rust: let line = mklink_line(&quoted(link)?, &quoted(target)?);
    // rust: let status = crate::process::command("cmd")
    // rust: .raw_arg(line)
    // rust: .stdout(std::process::Stdio::null())
    // rust: .status()?;
    // rust: if status.success() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(std::io::Error::other(format!(
    // rust: "mklink /J failed ({status})"
    // rust: )))
}
}

// cmd's arguments for a junction, both paths already quoted: `/D` skips AutoRun, and `/S /C "..."`
// makes cmd take the outer quotes off and run the rest as written.
mklink_line :: proc(link: string, target: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("/D /S /C \"mklink /J {link} {target}\"")
}

// A release on GitHub: its name here and the archive for this computer.
Release :: struct {
    // The release's tag, or for a Nightly the version it installs as (`nightly-2026-10-28-0c02067`).
    tag: string,
    asset: string,
    url: string,
    sha256: string,
}

// GitHub's API, or a release asset: the body of `url`.
fetch :: proc(url: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut body = Vec::new();
    // rust: ureq::get(url)
    // rust: .set("Accept", "application/vnd.github+json")
    // rust: .set("User-Agent", "horizon-server")
    // rust: .call()
    // rust: .map_err(|e| match e {
    // rust: ureq::Error::Status(404, _) => "404".to_string(),
    // rust: e => format!("GitHub didn't answer: {e}"),
    // rust: })?
    // rust: .into_reader()
    // rust: .take(64 << 20)
    // rust: .read_to_end(&mut body)
    // rust: .map_err(|e| format!("GitHub's answer: {e}"))?;
    // rust: Ok(body)
}

// The current Nightly (or `tag`: a release, `nightly` or a dated `nightly-<date>`), from GitHub's
// API, with the SHA-256 its signed checksums give for this computer's archive. With no Nightly
// published, GitHub's latest release.
release :: proc(tag: Maybe(string)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let api = |tag: &str| format!("https://api.github.com/repos/{REPO}/releases/tags/{tag}");
    // rust: let text = match tag {
    // rust: Some(tag) => fetch(&api(tag)),
    // rust: None => match fetch(&api(horizon_release_sign::NIGHTLY)) {
    // rust: Err(e) if e == "404" => fetch(&format!(
    // rust: "https://api.github.com/repos/{REPO}/releases/latest"
    // rust: )),
    // rust: found => found,
    // rust: },
}
    // rust: .map_err(|e| match e.as_str() {
    // rust: "404" => format!("no release {} on GitHub", tag.unwrap_or("")),
    // rust: _ => e,
    // rust: })?;
    // rust: let json = serde_json::from_slice(&text).map_err(|e| format!("GitHub's answer: {e}"))?;
    // rust: pick(&json, fetch, &horizon_release_sign::trusted_keys())
}

// The archive for this computer in a release's JSON, with the SHA-256 the release's SHA256SUMS
// gives for it, once its signature checks with one of `keys` (docs/security.md). A release from
// before signing gets the SHA-256 pinned for it (legacy-releases.txt); any other release that
// isn't signed, or not by Horizon's key, is refused.
    // rust: fn pick(
    // rust: release: &Value,
    // rust: fetch: impl Fn(&str) -> Result<Vec<u8>, String>,
    // rust: keys: &[horizon_release_sign::PublicKey],
    // rust: ) -> Result<Release, String> {
    // rust: pick_for_assets(release, fetch, keys, &ASSETS)
}

    // rust: fn pick_for_assets(
    // rust: release: &Value,
    // rust: fetch: impl Fn(&str) -> Result<Vec<u8>, String>,
    // rust: keys: &[horizon_release_sign::PublicKey],
    // rust: candidates: &[&str],
    // rust: ) -> Result<Release, String> {
    // rust: let tag = release["tag_name"]
    // rust: .as_str()
    // rust: .ok_or("GitHub's answer has no tag")?;
    // rust: let assets = release["assets"].as_array().cloned().unwrap_or_default();
    // rust: let asset = candidates
    // rust: .iter()
    // rust: .find_map(|name| assets.iter().find(|a| a["name"] == *name))
    // rust: .ok_or_else(|| {
    // rust: format!(
    // rust: "release {tag} has no archive for this computer ({})",
    // rust: candidates.join(", ")
    // rust: )
    // rust: })?;
    // rust: let name = asset["name"].as_str().unwrap_or_default();
    // A release from before signing: only the files pinned for it at the time (a rollback).
    // rust: if let Some(hex) = horizon_release_sign::legacy_digest(tag, name) {
    // rust: return Ok(Release {
    // rust: tag: tag.to_owned(),
    // rust: asset: name.to_owned(),
    // rust: url: asset["browser_download_url"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .to_owned(),
    // rust: sha256: hex.to_owned(),
    // rust: });
}
    // rust: let attached = |file: &str| -> Result<Option<Vec<u8>>, String> {
    // rust: match assets.iter().find(|a| a["name"] == file) {
    // rust: Some(a) => fetch(a["browser_download_url"].as_str().unwrap_or_default())
    // rust: .map(Some)
    // rust: .map_err(|e| format!("{file} of {tag}: {e}")),
    // rust: None => Ok(None),
}
}
    // rust: let sums = attached(horizon_release_sign::SUMS)?;
    // rust: let text = |bytes: Vec<u8>| String::from_utf8_lossy(&bytes).into_owned();
    // A Nightly installs under its date and commit, which its title names (strictly: nothing signs
    // GitHub's publication time), and its SHA256SUMS.v2.sig must sign the checksums for exactly that
    // version, so an older Nightly can't be served as a newer one.
    // rust: let (tag, sha256) = if horizon_release_sign::is_nightly(tag) {
    // rust: let title = release["name"].as_str().unwrap_or_default();
    // rust: let version = horizon_release_sign::nightly_title_version(title).ok_or_else(|| {
    // rust: format!("the Nightly's title {title:?} doesn't name its date and commit, so it can't be checked")
    // rust: })?;
    // rust: let signature = attached(horizon_release_sign::SIGNATURE_V2)?.map(text);
    // rust: let sha256 = horizon_release_sign::nightly_digest(
    // rust: &version,
    // rust: name,
    // rust: sums.as_deref(),
    // rust: signature.as_deref(),
    // rust: keys,
    // rust: )?;
    // rust: (version, sha256)
    // rust: } else {
    // rust: let signature = attached(horizon_release_sign::SIGNATURE)?.map(text);
    // rust: let sha256 = horizon_release_sign::signed_digest(
    // rust: tag,
    // rust: name,
    // rust: sums.as_deref(),
    // rust: signature.as_deref(),
    // rust: keys,
    // rust: )?;
    // rust: (tag.to_owned(), sha256)
}
    // rust: Ok(Release {
    // rust: tag,
    // rust: asset: name.to_owned(),
    // rust: url: asset["browser_download_url"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .to_owned(),
    // rust: sha256,
    // rust: })
}

// Where a release tag stands among Horizon's releases (docs/versioning.md). Releases before 0.2 were
// tagged `vYYYY.MM.DD[.N]` (any `v` and numbers: `Dated`), compared number by number; from 0.2 they are
// `vMAJOR.MINOR.PATCH[-PRE]` (`Semver`), and every one of those is newer than every dated one, so
// v0.2.0 follows v2026.10.19.15. A pre-release (`v0.3.0-rc.1`) comes before its release, as in semver.
// Nightlies (`nightly-<date>-<commit>`, the only builds since 2026-10-28) follow every release, by date.
TagOrder :: enum {
    Dated(Vec<u64>),
    Semver([u64; 3], Prerelease),
    Nightly(String),
}

// A pre-release's place: (is a release, its identifiers). A release has none and follows every
// pre-release of its version; identifiers compare one by one, numbers before words, and a shorter
// list first when one starts the other.
    // rust: type Prerelease = (bool, Vec<Identifier>);

Identifier :: enum {
    Number(u64),
    Word(String),
}

// Semver's majors stay below this; a date tag's first number is a year.
FIRST_YEAR :: 1000

tag_order :: proc(tag: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(date) = horizon_release_sign::nightly_date(tag) {
    // rust: return Some(TagOrder::Nightly(date.to_owned()));
}
    // rust: let rest = tag.strip_prefix('v')?;
    // rust: let (core, pre) = match rest.split_once('-') {
    // rust: Some((core, pre)) => (core, Some(pre)),
    // rust: None => (rest, None),
}
    // rust: let numbers: Vec<u64> = core
    // rust: .split('.')
    // rust: .map(|n| n.parse().ok())
    // rust: .collect::<Option<_>>()?;
    // rust: match (numbers.as_slice(), pre) {
    // rust: (&[major, minor, patch], pre) if major < FIRST_YEAR => {
    // rust: let pre = match pre {
    // rust: None => (true, Vec::new()),
    // rust: Some(pre) => (
    // rust: false,
    // rust: pre.split('.')
    // rust: .map(|id| {
    // rust: if id.is_empty() {
    // rust: None
    // rust: } else {
    // rust: Some(id.parse().map_or_else(
    // rust: |_| Identifier::Word(id.to_owned()),
    // rust: Identifier::Number,
    // rust: ))
}
    // rust: })
    // rust: .collect::<Option<_>>()?,
    // rust: ),
}
    // rust: Some(TagOrder::Semver([major, minor, patch], pre))
}
    // rust: (_, None) => Some(TagOrder::Dated(numbers)),
    // rust: (_, Some(_)) => None,
}
}

// Whether the release `tag` is newer than `than` ([`TagOrder`]). A tag that isn't a release (an
// archive installed by hand) is never newer than one, and every release is newer than it.
newer :: proc(tag: string, than: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (tag_order(tag), tag_order(than)) {
    // rust: (Some(a), Some(b)) => a > b,
    // rust: (Some(_), None) => true,
    // rust: _ => false,
}
}

// Whether `tag`, the newest build on GitHub, is an update for a server running `current`: a
// different build that isn't older. Two Nightlies of one day are equal by [`newer`], so the one
// on GitHub is taken.
update_available :: proc(tag: string, current: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: tag != current && tag_order(tag).is_some() && !newer(current, tag)
}

// Downloads a release's archive into `<root>/downloads/` and checks its SHA-256; the archive's path.
download :: proc(install: ^Install, release: ^Release) -> R {
    // Ported from Horizon
    return {}
}
//     use sha2::Digest;
    // rust: let folder = install.root.join("downloads");
    // rust: std::fs::create_dir_all(&folder).map_err(|e| format!("{}: {e}", folder.display()))?;
    // rust: let path = folder.join(&release.asset);
    // rust: let part = folder.join(format!("{}.part", release.asset));
    // rust: let result = (|| {
    // rust: let mut reader = ureq::get(&release.url)
    // rust: .set("User-Agent", "horizon-server")
    // rust: .call()
    // rust: .map_err(|e| format!("downloading {}: {e}", release.asset))?
    // rust: .into_reader();
    // rust: let mut file =
    // rust: std::fs::File::create(&part).map_err(|e| format!("{}: {e}", part.display()))?;
    // rust: let mut hasher = sha2::Sha256::new();
    // rust: let mut buffer = vec![0; 1 << 16];
    // rust: loop {
    // rust: let n = reader
    // rust: .read(&mut buffer)
    // rust: .map_err(|e| format!("downloading {}: {e}", release.asset))?;
    // rust: if n == 0 {
    // rust: break;
}
    // rust: hasher.update(&buffer[..n]);
    // rust: std::io::Write::write_all(&mut file, &buffer[..n]).map_err(|e| e.to_string())?;
}
    // rust: let got: String = hasher
    // rust: .finalize()
    // rust: .iter()
    // rust: .map(|b| format!("{b:02x}"))
    // rust: .collect();
    // rust: if got != release.sha256 {
    // rust: return Err(format!(
    // rust: "{} doesn't match its SHA-256 (got {got}, expected {}): not installed",
    // rust: release.asset, release.sha256
    // rust: ));
}
    // rust: std::fs::rename(&part, &path).map_err(|e| e.to_string())
    // rust: })();
    // rust: if result.is_err() {
    // rust: let _ = std::fs::remove_file(&part);
}
    // rust: result.map(|()| path)
}

// Unpacks a release archive into `<root>/releases/<tag>`, with its `.local/horizon-client` linked to the
// install's prepared game files (which updates keep), as the installers do. It doesn't switch to it.
unpack :: proc(install: ^Install, archive: ^Path, tag: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if tag.is_empty() || tag.contains(['/', '\\']) || tag.starts_with('.') {
    // rust: return Err(format!("{tag:?} isn't a release name"));
}
    // rust: let target = install.release(tag);
    // rust: if install.current().as_deref() == Some(tag) {
    // rust: return Err(format!("{tag} is the release in use"));
}
    // rust: let scratch = install
    // rust: .root
    // rust: .join("releases")
    // rust: .join(format!(".{tag}.unpacking"));
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: std::fs::create_dir_all(&scratch).map_err(|e| format!("{}: {e}", scratch.display()))?;
    // rust: let result = (|| {
    // rust: let name = archive.to_string_lossy();
    // rust: if name.ends_with(".zip") {
    // rust: let file =
    // rust: std::fs::File::open(archive).map_err(|e| format!("{}: {e}", archive.display()))?;
    // rust: zip::ZipArchive::new(file)
    // rust: .and_then(|mut z| z.extract(&scratch))
    // rust: .map_err(|e| format!("{}: {e}", archive.display()))?;
    // rust: } else if name.ends_with(".tar.gz") || name.ends_with(".tgz") {
            // tar is on every Linux and macOS, and on Windows 10 and later. The files are the
            // user's, not the archive's owners: as root in a user namespace (an unprivileged LXC
            // or rootless container) taking those fails, and as plain root they'd be strangers'.
    // rust: let status = crate::process::command("tar")
    // rust: .arg("--no-same-owner")
    // rust: .arg("-xzf")
    // rust: .arg(archive)
    // rust: .arg("-C")
    // rust: .arg(&scratch)
    // rust: .status()
    // rust: .map_err(|e| format!("tar: {e}"))?;
    // rust: if !status.success() {
    // rust: return Err(format!(
    // rust: "tar couldn't unpack {} ({status})",
    // rust: archive.display()
    // rust: ));
}
    // rust: } else {
    // rust: return Err(format!(
    // rust: "{} is neither a .tar.gz nor a .zip",
    // rust: archive.display()
    // rust: ));
}
    // rust: let source = find_program(&scratch, &exe("horizon-server"))
    // rust: .and_then(|p| p.parent().map(Path::to_path_buf))
    // rust: .ok_or_else(|| format!("{} holds no horizon-server", archive.display()))?;
    // rust: for name in [
    // rust: "horizon-server",
    // rust: "horizon-engine",
    // rust: "horizon-client",
    // rust: "horizon-prepare",
    // rust: ] {
//             use std::os::unix::fs::PermissionsExt;
    // rust: let path = source.join(name);
    // rust: if path.is_file() {
    // rust: let _ = std::fs::set_permissions(&path, std::fs::Permissions::from_mode(0o755));
}
}
    // rust: if target.exists() {
    // rust: std::fs::remove_dir_all(&target).map_err(|e| format!("{}: {e}", target.display()))?;
}
    // rust: std::fs::rename(&source, &target).map_err(|e| format!("{}: {e}", target.display()))?;
    // rust: let game_files = install.root.join("game-files/horizon-client");
    // rust: std::fs::create_dir_all(&game_files).map_err(|e| e.to_string())?;
    // rust: let local = target.join(".local");
    // rust: std::fs::create_dir_all(&local).map_err(|e| e.to_string())?;
    // rust: let link = local.join("horizon-client");
    // rust: if link.symlink_metadata().is_err() {
    // rust: point(&link, &game_files).map_err(|e| format!("{}: {e}", link.display()))?;
}
    // rust: Ok(target.clone())
    // rust: })();
    // rust: let _ = std::fs::remove_dir_all(&scratch);
    // rust: result
}

// The first file called `name` under `dir`, breadth first.
find_program :: proc(dir: ^Path, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut queue = std::collections::VecDeque::from([dir.to_path_buf()]);
    // rust: while let Some(folder) = queue.pop_front() {
    // rust: let mut entries: Vec<_> = std::fs::read_dir(&folder).ok()?.flatten().collect();
    // rust: entries.sort_by_key(|e| e.file_name());
    // rust: for entry in entries {
    // rust: let path = entry.path();
    // rust: let kind = entry.file_type().ok()?;
    // rust: if kind.is_file() && entry.file_name() == name {
    // rust: return Some(path);
}
    // rust: if kind.is_dir() {
    // rust: queue.push_back(path);
}
}
}
    // rust: None
}

// A backup name for the world before a switch to `tag` (backup names take letters, digits, - and _).
backup_name :: proc(tag: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let clean: String = tag
    // rust: .chars()
    // rust: .map(|c| if c.is_ascii_alphanumeric() { c } else { '-' })
    // rust: .take(48)
    // rust: .collect();
    // rust: format!("before-{clean}")
}

// `update [--check] [--version TAG] [--archive FILE --version TAG] [--timeout SECONDS]`.
command :: proc(dir: ^Path, args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut check = false;
    // rust: let mut as_json = false;
    // rust: let mut version = None;
    // rust: let mut archive = None;
    // rust: let mut timeout = crate::api::UPDATE_TIMEOUT;
    // rust: let mut it = args.iter();
    // rust: while let Some(arg) = it.next() {
    // rust: let mut value = || {
    // rust: it.next()
    // rust: .cloned()
    // rust: .ok_or_else(|| format!("{arg} needs a value"))
}
    // rust: match arg.as_str() {
    // rust: "--check" => check = true,
    // rust: "--json" => as_json = true,
    // rust: "--version" => version = Some(value()?),
    // rust: "--archive" => archive = Some(PathBuf::from(value()?)),
    // rust: "--timeout" => timeout = seconds(&value()?)?,
    // rust: other => return Err(format!("update: unknown option {other}")),
}
}
    // rust: let install = Install::required()?;
    // rust: let current = install
    // rust: .current()
    // rust: .ok_or("the installer's `current` points at no release")?;
    // rust: let (tag, archive, downloaded) = match archive {
    // rust: Some(_) if check => return Err("--check looks at GitHub's releases: drop --archive".into()),
    // rust: Some(archive) => {
    // rust: let tag = version
    // rust: .ok_or("--archive needs --version NAME: the release name to install it as")?;
    // rust: (tag, archive, false)
}
    // rust: None => {
    // rust: let release = release(version.as_deref())?;
    // rust: if check && as_json {
    // rust: println!(
    // rust: "{}",
    // rust: json!({
    // rust: "installed": current,
    // rust: "newest": release.tag,
    // rust: "available": update_available(&release.tag, &current),
    // rust: "previous": install.previous(),
    // rust: })
    // rust: );
    // rust: return Ok(());
}
    // rust: if check {
    // rust: if update_available(&release.tag, &current) {
    // rust: println!(
    // rust: "Horizon {} is out; this server runs {current}. `horizon-server update` installs it.",
    // rust: release.tag
    // rust: );
    // rust: } else {
    // rust: println!(
    // rust: "Up to date: {current} (the newest release is {}).",
    // rust: release.tag
    // rust: );
}
    // rust: return Ok(());
}
    // rust: if version.is_none() && !update_available(&release.tag, &current) {
    // rust: println!("Already on the newest release ({current}).");
    // rust: return Ok(());
}
    // rust: if newer(&current, &release.tag) {
                // Asked for by --version: a rollback is allowed, never done without saying so.
    // rust: println!(
    // rust: "{} is older than {current}, which this server runs: installing it as a rollback.",
    // rust: release.tag
    // rust: );
}
    // rust: println!("Downloading Horizon {} ({})...", release.tag, release.asset);
    // rust: let archive = download(&install, &release)?;
    // rust: (release.tag, archive, true)
}
}
    // rust: if tag == current {
    // rust: println!("Already on {tag}.");
    // rust: return Ok(());
}
    // rust: let unpacked = unpack(&install, &archive, &tag);
    // rust: if downloaded {
    // rust: let _ = std::fs::remove_file(&archive);
}
    // rust: unpacked?;
    // rust: switch_to(dir, &install, &tag, timeout)
}

// `rollback [--timeout SECONDS]`: back to the release used before the current one.
rollback :: proc(dir: ^Path, args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let timeout = match args {
    // rust: [] => crate::api::UPDATE_TIMEOUT,
    // rust: [flag, value] if flag == "--timeout" => seconds(value)?,
    // rust: _ => return Err("rollback takes only --timeout SECONDS".into()),
}
    // rust: let install = Install::required()?;
    // rust: let previous = install.previous().ok_or(
    // rust: "no release to go back to: this install hasn't been updated, or the one before is gone",
    // rust: )?;
    // rust: switch_to(dir, &install, &previous, timeout)
}

seconds :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: text.parse()
    // rust: .ok()
    // rust: .filter(|&s| s > 0)
    // rust: .map(Duration::from_secs)
    // rust: .ok_or_else(|| format!("--timeout needs a number of seconds (got {text:?})"))
}

// Switches the install to the release `tag`. A running server restarts on it through its supervisor, which
// goes back by itself if the game isn't up within `timeout`; a stopped one is switched and its game checked.
// Either way the world is backed up first.
switch_to :: proc(dir: ^Path, install: ^Install, tag: string, timeout: Duration) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(client) = Client::open(dir)? else {
    // rust: return switch_stopped(dir, install, tag);
}
    // rust: let finished = |status: &Value| status["update"]["finished"].as_u64().unwrap_or(0);
    // rust: let before = finished(&client.call("GET", "/api/v1/status", None)?);
    // rust: client
    // rust: .call(
    // rust: "POST",
    // rust: "/api/v1/update",
    // rust: Some(&json!({ "tag": tag, "timeout": timeout.as_secs() })),
    // rust: )
    // rust: .map_err(|e| {
    // rust: if e == "no such endpoint" {
    // rust: "the running server is older than updates: stop it, then run `horizon-server update` again".into()
    // rust: } else {
    // rust: e
}
    // rust: })?;
    // rust: print!("Restarting the server on {tag}");
    // The backup, the stop, the start and, if it fails, the way back.
    // rust: let deadline = Instant::now() + timeout + Duration::from_secs(3600);
    // rust: loop {
    // rust: std::thread::sleep(Duration::from_millis(500));
    // rust: let status = client.call("GET", "/api/v1/status", None)?;
    // rust: if finished(&status) > before {
    // rust: let update = &status["update"];
    // rust: let last = update["last"].as_str().unwrap_or_default().to_owned();
    // rust: if update["ok"] == true {
    // rust: println!("\n{last}");
    // rust: return Ok(());
}
            // Rolled back (or stayed): say so once the game is up again on the release it went back to.
    // rust: let mut phase = status["phase"].as_str().unwrap_or_default().to_owned();
    // rust: let until = Instant::now() + crate::api::UPDATE_TIMEOUT;
    // rust: while phase != "running" && phase != "stopping" && Instant::now() < until {
    // rust: std::thread::sleep(Duration::from_millis(500));
    // rust: print!(".");
    // rust: let _ = std::io::Write::flush(&mut std::io::stdout());
    // rust: phase = client.call("GET", "/api/v1/status", None)?["phase"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .to_owned();
}
    // rust: println!();
    // rust: return Err(if phase == "running" {
    // rust: format!("{last}. The game is up again.")
    // rust: } else {
    // rust: last
    // rust: });
}
    // rust: if Instant::now() > deadline {
    // rust: println!();
    // rust: return Err(
    // rust: "no word from the server about the update; `horizon-server logs` shows where it is"
    // rust: .into(),
    // rust: );
}
    // rust: print!(".");
    // rust: let _ = std::io::Write::flush(&mut std::io::stdout());
}
}

// The switch for a stopped server (or outside any server folder): the world backed up, `current` moved,
// and the new game checked to load on this system, else switched back.
switch_stopped :: proc(dir: ^Path, install: ^Install, tag: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let from = install
    // rust: .current()
    // rust: .ok_or("the installer's `current` points at no release")?;
    // rust: let server = dir.join(crate::config::FILE).is_file();
    // rust: let _lock = if server {
    // rust: Some(supervisor::lock(dir)?)
    // rust: } else {
    // rust: None
}
    // rust: let config = if server {
    // rust: Config::load(dir)?
    // rust: } else {
    // rust: Config::default()
}
    // rust: let backed_up = if server {
    // rust: let file = backup::file_name(std::time::SystemTime::now(), Some(&backup_name(tag)))?;
    // rust: backup::create(dir, &config, &file)?;
    // rust: format!(" The world is backed up in {}/{file}.", backup::DIR)
    // rust: } else {
    // rust: String::new()
}
    // rust: let previous = install.previous();
    // rust: install.switch(tag)?;
    // rust: if let Err(e) =
    // rust: engine::program_in(&config, dir, Some(install)).and_then(|p| engine::check_starts(&p))
    // rust: {
    // rust: install.switch_back(&from, previous.as_deref())?;
    // rust: return Err(format!("stayed on {from}: {e}"));
}
    // rust: println!(
    // rust: "Switched from {from} to {tag}.{backed_up}{} `horizon-server rollback` goes back to {from}.",
    // rust: if server {
    // rust: " The server is stopped: `horizon-server start` runs the new version."
    // rust: } else {
    // rust: ""
}
    // rust: );
    // rust: let (removed, failed) = install.prune(config.updates.keep);
    // rust: let pruned = pruned(&removed, &failed);
    // rust: if !pruned.is_empty() {
    // rust: println!("{pruned}.");
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

musl_update_refuses_glibc_before_downloading :: proc() {
}
    // rust: let release = json!({"tag_name": "nightly", "assets": [
    // rust: {"name": "horizon-server-linux-x86_64.tar.gz", "browser_download_url": "server"},
    // rust: {"name": "horizon-linux-x86_64.tar.gz", "browser_download_url": "client"},
    // rust: {"name": "horizon-linux-musl-x86_64.tar.gz", "browser_download_url": "manual"}
    // rust: ]});
    // rust: let error = pick_for_assets(
    // rust: &release,
    // rust: |_| panic!("unsupported updates must not download an archive or signatures"),
    // rust: &[],
    // rust: assets_for("linux", "x86_64", true),
    // rust: )
    // rust: .unwrap_err();
    // rust: assert!(error.contains("no archive for this computer"));
}

windows_updates_choose_the_machine_architecture :: proc() {
}
    // rust: assert_eq!(
    // rust: assets_for("windows", "x86_64", false),
    // rust: &["horizon-windows-x64.zip"]
    // rust: );
    // rust: assert_eq!(
    // rust: assets_for("windows", "aarch64", false),
    // rust: &["horizon-windows-arm64.zip", "horizon-windows-x64.zip"]
    // rust: );
}

scratch :: proc(name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-update-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

    // An install as install.sh leaves it, with releases `tags`, the first in use.
installed :: proc(name: string, tags: ^[string]) -> I {
    // Ported from Horizon
    return {}
}
        // Canonical, as `around` sees it (macOS's temporary folder is behind a link).
    // rust: let root = std::fs::canonicalize(scratch(name)).unwrap();
    // rust: for tag in tags {
    // rust: let release = root.join("releases").join(tag);
    // rust: std::fs::create_dir_all(&release).unwrap();
    // rust: std::fs::write(release.join("horizon-server"), tag).unwrap();
}
    // rust: std::os::unix::fs::symlink(root.join("releases").join(tags[0]), root.join("current"))
    // rust: .unwrap();
    // rust: Install { root }
}

    // Real junctions, in a folder whose name cmd would split on unquoted (`&`, no space so std doesn't
    // quote it): `current` moves from one release to the other and nothing else changes.
junctions_switch_in_a_folder_cmd_would_split :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-server-junction-mc&co-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: for tag in ["v1", "v2", "v%3"] {
    // rust: let release = root.join("releases").join(tag);
    // rust: std::fs::create_dir_all(&release).unwrap();
    // rust: std::fs::write(release.join(exe("horizon-server")), tag).unwrap();
}
    // rust: let install = Install { root: root.clone() };
    // rust: let running = root.join("current").join(exe("horizon-server"));
    // rust: install.switch("v1").unwrap();
    // rust: assert_eq!(std::fs::read_to_string(&running).unwrap(), "v1");
    // rust: install.switch("v2").unwrap();
    // rust: assert_eq!(std::fs::read_to_string(&running).unwrap(), "v2");
    // rust: assert!(root.join("current.switching").symlink_metadata().is_err());
        // Replacing the junction never touched the release it pointed at.
    // rust: let v1 = root.join("releases").join("v1").join(exe("horizon-server"));
    // rust: assert_eq!(std::fs::read_to_string(v1).unwrap(), "v1");
        // `%` keeps a meaning inside cmd's quotes: refused, and `current` stays where it was.
    // rust: let refused = install.switch("v%3").unwrap_err();
    // rust: assert!(refused.contains('%'), "{refused}");
    // rust: assert_eq!(std::fs::read_to_string(&running).unwrap(), "v2");
    // rust: assert!(root.join("current.switching").symlink_metadata().is_err());
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

a_junctions_paths_are_quoted_for_cmd :: proc() {
}
    // rust: assert_eq!(
    // rust: mklink_line(r#""D:\mc&co\current""#, r#""D:\mc&co\releases\v0.2.95""#),
    // rust: r#"/D /S /C "mklink /J "D:\mc&co\current" "D:\mc&co\releases\v0.2.95"""#
    // rust: );
}

tags_compare_by_number :: proc() {
}
    // rust: assert!(newer("v2026.10.19", "v2026.10.18.27"));
    // rust: assert!(newer("v2026.10.18.27", "v2026.10.18.9"));
    // rust: assert!(newer("v2026.10.19.1", "v2026.10.19"));
    // rust: assert!(!newer("v2026.10.19", "v2026.10.19"));
    // rust: assert!(!newer("v2026.10.18", "v2026.10.19"));
        // An archive installed by hand: any release is newer, and it is never newer than one.
    // rust: assert!(newer("v2026.10.19", "local"));
    // rust: assert!(!newer("local", "v2026.10.19"));
}

semver_tags_follow_every_date_tag :: proc() {
}
        // 0.2 follows the last date tags, whatever their numbers.
    // rust: assert!(newer("v0.2.0", "v2026.10.19.15"));
    // rust: assert!(newer("v0.2.0", "v2026.10.21"));
    // rust: assert!(!newer("v2026.10.19.15", "v0.2.0"));
    // rust: assert!(!newer("v2099.12.31.99", "v0.2.0"));
        // Within 0.2: patch, minor, and numbers compared as numbers.
    // rust: assert!(newer("v0.2.1", "v0.2.0"));
    // rust: assert!(!newer("v0.2.0", "v0.2.1"));
    // rust: assert!(newer("v0.2.10", "v0.2.9"));
    // rust: assert!(newer("v0.3.0", "v0.2.57"));
    // rust: assert!(newer("v1.0.0", "v0.99.0"));
    // rust: assert!(!newer("v0.2.0", "v0.2.0"));
        // A semver tag is a release: an archive installed by hand is older.
    // rust: assert!(newer("v0.2.0", "local"));
    // rust: assert!(!newer("local", "v0.2.0"));
}

prereleases_come_before_their_release :: proc() {
}
    // rust: assert!(newer("v0.3.0", "v0.3.0-rc.1"));
    // rust: assert!(newer("v0.3.0-rc.1", "v0.2.9"));
    // rust: assert!(newer("v0.3.0-beta.2", "v0.3.0-beta.1"));
    // rust: assert!(newer("v0.3.0-beta.11", "v0.3.0-beta.2"));
    // rust: assert!(newer("v0.3.0-rc.1", "v0.3.0-beta.9"));
    // rust: assert!(newer("v0.3.0-beta.1", "v0.3.0-beta"));
        // Numbers come before words; any pre-release still follows every date tag.
    // rust: assert!(newer("v0.3.0-alpha", "v0.3.0-1"));
    // rust: assert!(newer("v0.2.1-beta.1", "v2026.10.21"));
    // rust: assert!(!newer("v0.2.1-beta.1", "v0.2.1"));
        // Not tags: a date tag with a suffix, an empty identifier.
    // rust: assert!(newer("v0.2.0", "v2026.10.21-x"));
    // rust: assert!(newer("v0.2.0", "v0.3.0-"));
    // rust: assert!(newer("v0.2.0", "v0.3.0-rc..1"));
}

nightlies_follow_every_release :: proc() {
}
    // rust: let today = "nightly-2026-10-28-0c02067";
    // rust: assert!(newer(today, "v0.2.95"));
    // rust: assert!(newer(today, "v2026.10.21"));
    // rust: assert!(newer(today, "nightly-2026-10-27-1a2b3c4"));
    // rust: assert!(!newer("v0.2.95", today));
    // rust: assert!(newer(today, "local"));
        // Two builds of one day: neither is newer, but the one on GitHub is the update.
    // rust: let later = "nightly-2026-10-28-9b772b2";
    // rust: assert!(!newer(later, today) && !newer(today, later));
    // rust: assert!(update_available(later, today));
    // rust: assert!(update_available(today, "v0.2.95"));
    // rust: assert!(!update_available(today, today));
    // rust: assert!(!update_available("v0.2.95", today));
    // rust: assert!(!update_available("nightly-2026-10-27-1a2b3c4", today));
    // rust: assert!(update_available("v0.2.96", "v0.2.95"));
    // rust: assert!(!update_available("v0.2.94", "v0.2.95"));
}

a_nightly_is_picked_with_its_version_signature_and_named_by_its_build :: proc() {
}
//         use horizon_release_sign::{SigningKey, sha256_hex, sums_file};
    // rust: let Some(first) = ASSETS.first() else { return };
    // rust: let asset = |name: &str| json!({ "name": name, "browser_download_url": format!("https://example.invalid/{name}") });
    // rust: let (key, _) = SigningKey::generate().unwrap();
    // rust: let sums = sums_file(&[(first.to_string(), sha256_hex(b"server"))]);
        // SHA256SUMS.sig signed for `channel`, SHA256SUMS.v2.sig for `v2`.
    // rust: let serving = |channel: &str, v2: &str| {
    // rust: let sums = sums.clone();
    // rust: let (one, two) = (
    // rust: key.sign(channel, sums.as_bytes()),
    // rust: key.sign(v2, sums.as_bytes()),
    // rust: );
    // rust: move |url: &str| -> Result<Vec<u8>, String> {
    // rust: match url.rsplit('/').next() {
    // rust: Some("SHA256SUMS") => Ok(sums.clone().into_bytes()),
    // rust: Some("SHA256SUMS.sig") => Ok(one.clone().into_bytes()),
    // rust: Some("SHA256SUMS.v2.sig") => Ok(two.clone().into_bytes()),
    // rust: _ => Err("404".into()),
}
}
}
TONIGHT :: "nightly-2026-10-28-0c02067"
    // rust: let nightly = json!({
    // rust: "tag_name": "nightly", "name": "Nightly 2026-10-28 · 0c02067",
    // rust: "published_at": "2026-10-28T20:40:00Z",
    // rust: "assets": [asset(first), asset("SHA256SUMS"), asset("SHA256SUMS.sig"), asset("SHA256SUMS.v2.sig")],
    // rust: });
    // rust: let picked = pick(&nightly, serving("nightly", TONIGHT), &[key.public()]).unwrap();
    // rust: assert_eq!(picked.tag, TONIGHT);
    // rust: assert_eq!(picked.sha256, sha256_hex(b"server"));
        // An older Nightly's files under tonight's title: refused.
    // rust: let old = serving("nightly", "nightly-2026-10-21-aaaaaaa");
    // rust: assert!(pick(&nightly, old, &[key.public()]).is_err());
        // Only the channel's signature (a Nightly from before v2): refused.
    // rust: let mut v1_only = nightly.clone();
    // rust: v1_only["assets"] = json!([asset(first), asset("SHA256SUMS"), asset("SHA256SUMS.sig")]);
    // rust: let err = pick(&v1_only, serving("nightly", TONIGHT), &[key.public()]).unwrap_err();
    // rust: assert!(err.contains("SHA256SUMS.v2.sig"), "{err}");
        // A title that doesn't name its date and commit: refused, never dated by `published_at`.
    // rust: let mut untitled = nightly.clone();
    // rust: untitled["name"] = json!("Nightly");
    // rust: let err = pick(&untitled, serving("nightly", TONIGHT), &[key.public()]).unwrap_err();
    // rust: assert!(err.contains("doesn't name"), "{err}");
        // A release's signed list served as the Nightly: refused.
    // rust: assert!(pick(&nightly, serving("v0.2.95", "v0.2.95"), &[key.public()]).is_err());
        // A Nightly's signed list served as a release: refused.
    // rust: let mut release = nightly.clone();
    // rust: release["tag_name"] = json!("v0.2.95");
    // rust: assert!(pick(&release, serving(TONIGHT, TONIGHT), &[key.public()]).is_err());
}

pruning_orders_dated_and_semver_releases :: proc() {
}
        // `prune` sorts with `newer`: semver releases first, then the dated ones.
    // rust: let mut tags = vec!["v2026.10.19.15", "v0.2.1", "v2026.10.21", "v0.2.0", "local"];
    // rust: tags.sort_by(|a, b| {
    // rust: if newer(a, b) {
    // rust: std::cmp::Ordering::Less
    // rust: } else if newer(b, a) {
    // rust: std::cmp::Ordering::Greater
    // rust: } else {
    // rust: b.cmp(a)
}
    // rust: });
    // rust: assert_eq!(
    // rust: tags,
    // rust: ["v0.2.1", "v0.2.0", "v2026.10.21", "v2026.10.19.15", "local"]
    // rust: );
}

horizon_server_ships_with_a_release_key :: proc() {
}
        // With no key in release-keys.txt every update after the pinned releases would be refused:
        // this fails until the release environment's public key is listed (docs/security.md).
    // rust: assert!(
    // rust: !horizon_release_sign::trusted_keys().is_empty(),
    // rust: "crates/horizon-release-sign/release-keys.txt lists no key"
    // rust: );
}

a_release_from_before_signing_is_picked_with_its_pinned_digest :: proc() {
}
    // rust: if let Some(first) = ASSETS.first() {
    // rust: let pinned = horizon_release_sign::legacy_digest("v2026.10.19", first)
    // rust: .expect("v2026.10.19 is from before signing and has every platform's archive");
    // rust: let old = json!({ "tag_name": "v2026.10.19", "assets": [{ "name": first, "browser_download_url": "u" }] });
    // rust: let nothing = |_: &str| -> Result<Vec<u8>, String> { Err("404".into()) };
    // rust: assert_eq!(pick(&old, nothing, &[]).unwrap().sha256, pinned);
}
}

the_archive_for_this_computer_is_picked_with_its_signed_digest :: proc() {
}
//         use horizon_release_sign::{SigningKey, sha256_hex, sums_file};
    // rust: let asset = |name: &str| json!({ "name": name, "browser_download_url": format!("https://example.invalid/{name}") });
    // rust: let (key, _) = SigningKey::generate().unwrap();
    // rust: let listed: Vec<(String, String)> = ASSETS
    // rust: .iter()
    // rust: .map(|n| (n.to_string(), sha256_hex(n.as_bytes())))
    // rust: .collect();
    // rust: let sums = sums_file(&listed);
    // rust: let signature = key.sign("v2099.01.01", sums.as_bytes());
    // rust: let files = |url: &str| -> Result<Vec<u8>, String> {
    // rust: match url.rsplit('/').next() {
    // rust: Some("SHA256SUMS") => Ok(sums.clone().into_bytes()),
    // rust: Some("SHA256SUMS.sig") => Ok(signature.clone().into_bytes()),
    // rust: _ => Err("404".into()),
}
}
    // rust: let names = ASSETS.iter().rev().copied().chain(["other.zip"]);
    // rust: let signed = json!({
    // rust: "tag_name": "v2099.01.01",
    // rust: "assets": names.chain(["SHA256SUMS", "SHA256SUMS.sig"]).map(asset).collect::<Vec<_>>(),
    // rust: });
    // rust: if let Some(first) = ASSETS.first() {
    // rust: let picked = pick(&signed, files, &[key.public()]).unwrap();
    // rust: assert_eq!(picked.tag, "v2099.01.01");
            // The most specific archive (Linux: the server build), even when listed last.
    // rust: assert_eq!(picked.asset, *first);
    // rust: assert_eq!(picked.sha256, sha256_hex(first.as_bytes()));
            // Signed by another key, or not signed at all: refused.
    // rust: let (other, _) = SigningKey::generate().unwrap();
    // rust: assert!(pick(&signed, files, &[other.public()]).is_err());
    // rust: let unsigned = json!({ "tag_name": "v1", "assets": [asset(first)] });
    // rust: assert!(
    // rust: pick(&unsigned, files, &[key.public()])
    // rust: .unwrap_err()
    // rust: .contains("not signed")
    // rust: );
            // The same signed list under another tag: refused.
    // rust: let mut replayed = signed.clone();
    // rust: replayed["tag_name"] = json!("v2099.01.02");
    // rust: assert!(pick(&replayed, files, &[key.public()]).is_err());
}
    // rust: assert!(
    // rust: pick(
    // rust: &json!({ "tag_name": "v1", "assets": [asset("other.zip")] }),
    // rust: files,
    // rust: &[]
    // rust: )
    // rust: .unwrap_err()
    // rust: .contains("no archive for this computer")
    // rust: );
}

backup_names_are_valid :: proc() {
}
    // rust: let name = backup_name("v2026.10.19");
    // rust: assert_eq!(name, "before-v2026-10-19");
    // rust: crate::backup::file_name(std::time::SystemTime::now(), Some(&name)).unwrap();
}

switching_keeps_the_previous_release :: proc() {
}
    // rust: let install = installed("switch", &["v1", "v2"]);
    // rust: let exe = install.root.join("current/horizon-server");
    // rust: assert_eq!(Install::around(&exe), Some(install.clone()));
    // rust: assert_eq!(
    // rust: Install::around(&install.release("v2").join("horizon-server")),
    // rust: Some(install.clone())
    // rust: );
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
    // rust: assert_eq!(install.previous(), None);
    // rust: install.switch("v2").unwrap();
    // rust: assert_eq!(install.current().as_deref(), Some("v2"));
    // rust: assert_eq!(install.previous().as_deref(), Some("v1"));
    // rust: assert_eq!(std::fs::read_to_string(&exe).unwrap(), "v2");
        // Undoing it leaves `previous` as it was.
    // rust: install.switch_back("v1", None).unwrap();
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
    // rust: assert_eq!(install.previous(), None);
    // rust: install.switch("v2").unwrap();
        // Rolling back is a switch to the previous release, which then becomes the one to go back to.
    // rust: install.switch("v1").unwrap();
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
    // rust: assert_eq!(install.previous().as_deref(), Some("v2"));
        // Switching to the release in use changes nothing; to a missing one is refused.
    // rust: install.switch("v1").unwrap();
    // rust: assert_eq!(install.previous().as_deref(), Some("v2"));
    // rust: assert!(
    // rust: install
    // rust: .switch("v3")
    // rust: .unwrap_err()
    // rust: .contains("no horizon-server")
    // rust: );
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
    // rust: std::fs::remove_dir_all(&install.root).unwrap();
}

pruning_keeps_current_previous_and_the_newest_others :: proc() {
}
    // rust: let tags = [
    // rust: "v2026.10.19",
    // rust: "v2026.10.1",
    // rust: "v2026.10.2",
    // rust: "v2026.10.10",
    // rust: "v2026.10.18.3",
    // rust: "local",
    // rust: ];
    // rust: let install = installed("prune", &tags);
        // After a rollback `previous` can be any release, even the oldest.
    // rust: std::fs::write(install.root.join("previous"), "v2026.10.1\n").unwrap();
    // rust: std::fs::create_dir_all(install.root.join("releases/.v2026.10.20.unpacking")).unwrap();
    // rust: std::fs::write(install.root.join("releases/notes.txt"), "").unwrap();
    // rust: let left = || {
    // rust: let mut names: Vec<String> = std::fs::read_dir(install.root.join("releases"))
    // rust: .unwrap()
    // rust: .map(|e| e.unwrap().file_name().to_string_lossy().into_owned())
    // rust: .collect();
    // rust: names.sort();
    // rust: names
}
    // rust: let (removed, failed) = install.prune(1);
    // rust: assert_eq!(removed, ["v2026.10.10", "v2026.10.2", "local"]);
    // rust: assert!(failed.is_empty());
    // rust: assert_eq!(
    // rust: left(),
    // rust: [
    // rust: ".v2026.10.20.unpacking",
    // rust: "notes.txt",
    // rust: "v2026.10.1",
    // rust: "v2026.10.18.3",
    // rust: "v2026.10.19"
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: pruned(&removed, &failed),
    // rust: "Deleted old releases: v2026.10.10, v2026.10.2, local"
    // rust: );
        // Nothing more to delete at the same count; none at all kept besides current and previous.
    // rust: assert_eq!(install.prune(1), (Vec::new(), Vec::new()));
    // rust: assert_eq!(install.prune(0).0, ["v2026.10.18.3"]);
    // rust: assert_eq!(install.current().as_deref(), Some("v2026.10.19"));
    // rust: assert_eq!(install.previous().as_deref(), Some("v2026.10.1"));
        // Without a `current` nothing is deleted.
    // rust: std::fs::remove_file(install.root.join("current")).unwrap();
    // rust: assert_eq!(install.prune(0), (Vec::new(), Vec::new()));
    // rust: assert!(install.release("v2026.10.19").is_dir());
    // rust: std::fs::remove_dir_all(&install.root).unwrap();
}

an_archive_unpacks_beside_the_others_with_the_game_files_linked :: proc() {
}
    // rust: let install = installed("unpack", &["v1"]);
    // rust: let source = scratch("unpack-source");
    // rust: let inner = source.join("horizon-v2");
    // rust: std::fs::create_dir_all(&inner).unwrap();
    // rust: std::fs::write(inner.join("horizon-server"), "v2").unwrap();
    // rust: std::fs::write(inner.join("horizon-engine"), "engine").unwrap();
    // rust: let archive = source.join("horizon-server-linux-x86_64.tar.gz");
    // rust: let status = std::process::Command::new("tar")
    // rust: .arg("-czf")
    // rust: .arg(&archive)
    // rust: .arg("-C")
    // rust: .arg(&source)
    // rust: .arg("horizon-v2")
    // rust: .status()
    // rust: .unwrap();
    // rust: assert!(status.success());
    // rust: let release = unpack(&install, &archive, "v2").unwrap();
    // rust: assert_eq!(release, install.release("v2"));
    // rust: assert_eq!(
    // rust: std::fs::read_to_string(release.join("horizon-engine")).unwrap(),
    // rust: "engine"
    // rust: );
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: let mode = std::fs::metadata(release.join("horizon-engine"))
    // rust: .unwrap()
    // rust: .permissions()
    // rust: .mode();
    // rust: assert_eq!(mode & 0o111, 0o111);
}
    // rust: assert_eq!(
    // rust: std::fs::canonicalize(release.join(".local/horizon-client")).unwrap(),
    // rust: std::fs::canonicalize(install.root.join("game-files/horizon-client")).unwrap()
    // rust: );
        // Not switched yet; nothing left behind; the release in use can't be unpacked over.
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
    // rust: assert!(!install.root.join("releases/.v2.unpacking").exists());
    // rust: assert!(
    // rust: unpack(&install, &archive, "v1")
    // rust: .unwrap_err()
    // rust: .contains("in use")
    // rust: );
    // rust: assert!(unpack(&install, &archive, "../x").is_err());
    // rust: let empty = source.join("empty.zip");
    // rust: zip::ZipWriter::new(std::fs::File::create(&empty).unwrap())
    // rust: .finish()
    // rust: .unwrap();
    // rust: assert!(
    // rust: unpack(&install, &empty, "v3")
    // rust: .unwrap_err()
    // rust: .contains("holds no horizon-server")
    // rust: );
    // rust: assert!(!install.release("v3").exists());
    // rust: std::fs::remove_dir_all(&install.root).unwrap();
    // rust: std::fs::remove_dir_all(&source).unwrap();
}
}
