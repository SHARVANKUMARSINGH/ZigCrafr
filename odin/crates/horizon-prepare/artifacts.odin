//! Transpiled from Horizon Rust crate
package horizon_prepare_artifacts

import "core:fmt"
import "core:mem"
import "core:math"

// The player's own game files: the pinned version JSON, client jar and libraries from their
// official launcher or ATLauncher install, and the server jar they downloaded, each checked against
// research-lock.json before it is copied to `.local/minecraft/<version>` (tools/lab.py's
// `prepare`, which the Python preparer ran first), then checked again on every run
// (tools/test_rust_parity.py's `verify_artifacts`).

// use crate::pyjson::{self, Value};
// use crate::{digest, read_json, relative_display, write_json, Log};
// use std::collections::HashMap;
// use std::fs;
// use std::path::{Component, Path, PathBuf};

    // rust: const LAUNCHER_HINT: &str =
    // rust: "Horizon does not download the game: play {version} once in the launcher you play \
    // rust: Minecraft Java Edition with so it downloads the game's files, then rerun. Horizon reads the \
    // rust: official launcher's folder, ATLauncher's and the CurseForge app's; for Prism Launcher, MultiMC, \
    // rust: the Modrinth App or GDLauncher, prepare from the Horizon launcher, which finds their files. If your launcher keeps \
    // rust: them in another folder, pass --minecraft-dir or set HORIZON_MINECRAFT_DIR, or name the files with \
    // rust: --version-json, --client-jar, --libraries-dir and --assets-dir.";
    // rust: const SERVER_HINT: &str = "Horizon does not download the game: download the {version} server jar yourself (minecraft.net/download/server \
    // rust: while {version} is the current release, otherwise the downloads.server.url in your launcher's \
    // rust: versions/{version}/{version}.json), then pass --server-jar PATH or set HORIZON_SERVER_JAR.";

hint :: proc(text: string, version: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: text.replace("{version}", version)
}

// research-lock.json and the folder the pinned version's files go to.
Lock :: struct {
    json: Value,
    version: string,
    java_major: i64,
    directory: PathBuf,
}

    // rust: impl Lock {
read :: proc(root: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json = read_json(&root.join("research-lock.json"))?;
    // rust: let game = json
    // rust: .get("minecraft")
    // rust: .ok_or("research-lock.json has no minecraft")?;
    // rust: let version = game
    // rust: .get("version")
    // rust: .and_then(Value::as_str)
    // rust: .ok_or("research-lock.json has no minecraft version")?
    // rust: .to_string();
    // rust: if version.is_empty()
    // rust: || !version
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b"_.-".contains(&b))
    // rust: || version == "."
    // rust: || version == ".."
    // rust: {
    // rust: return Err("Unsafe version identifier in lock file".into());
}
    // rust: let java_major = game
    // rust: .get("java_major")
    // rust: .and_then(Value::as_i64)
    // rust: .ok_or("research-lock.json has no java_major")?;
    // rust: let directory = root.join(".local/minecraft").join(&version);
    // rust: Ok(Lock {
    // rust: json,
    // rust: version,
    // rust: java_major,
    // rust: directory,
    // rust: })
}

pin :: proc(self: ^Self, key: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.json
    // rust: .get("minecraft")
    // rust: .and_then(|m| m.get(key))
    // rust: .and_then(Value::as_str)
    // rust: .ok_or_else(|| format!("research-lock.json has no minecraft {key}"))
}

    // Mojang republishes a version JSON for asset-index changes; every known one is accepted.
manifest_accepted :: proc(self: ^Self, checksum: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.pin("manifest_sha1").is_ok_and(|pin| pin == checksum)
    // rust: || self.listed("accepted_manifest_sha1", checksum)
}

    // The asset indexes of those republished version JSONs: a launcher keeps one
    // `indexes/<id>.json`, the last it downloaded, whichever version JSON it reads.
    // rust: pub(crate) fn asset_index_accepted(&self, checksum: &str) -> bool {
    // rust: self.listed("accepted_asset_index_sha1", checksum)
}

listed :: proc(self: ^Self, key: string, checksum: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.json
    // rust: .get("minecraft")
    // rust: .and_then(|g| g.get(key))
    // rust: .and_then(Value::as_array)
    // rust: .is_some_and(|list| list.iter().any(|v| v.as_str() == Some(checksum)))
}
}

home :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: let var = if cfg!(windows) { "USERPROFILE" } else { "HOME" };
    // rust: std::env::var_os(var)
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| PathBuf::from("."))
}

// Python's `Path.expanduser` for the forms players type: `~` and `~/...`.
expand_user :: proc(path: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut components = path.components();
    // rust: match components.next() {
    // rust: Some(Component::Normal(first)) if first == "~" => home().join(components.as_path()),
    // rust: _ => path.to_path_buf(),
}
}

// The official launcher's game directory, which holds the player's own copy of the game.
minecraft_dir :: proc(chosen: Maybe(^Path)) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(dir) = chosen.filter(|d| !d.as_os_str().is_empty()) {
    // rust: return expand_user(dir);
}
    // rust: if let Some(dir) = std::env::var_os("HORIZON_MINECRAFT_DIR").filter(|d| !d.is_empty()) {
    // rust: return expand_user(Path::new(&dir));
}
    // rust: if cfg!(target_os = "macos") {
    // rust: home().join("Library/Application Support/minecraft")
    // rust: } else if cfg!(windows) {
    // rust: std::env::var_os("APPDATA")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(home)
    // rust: .join(".minecraft")
    // rust: } else {
    // rust: home().join(".minecraft")
}
}

// One launcher's copy of the pinned version: its version JSON (Mojang's file, checked by its
// sha1), the client jar, and the folder holding its `libraries` (at the version JSON's paths)
// and `assets`.
GameFiles :: struct {
    folder: PathBuf,
    manifest: PathBuf,
    client: PathBuf,
    // Where the client's libraries are (`folder`'s `libraries`, or `--libraries-dir`).
    libraries: PathBuf,
    // The asset store: `indexes/` and `objects/` (`folder`'s `assets`, or `--assets-dir`).
    assets: PathBuf,
    // Mojang's Java runtimes the launcher downloaded (java::minecraft_runtimes).
    runtimes: PathBuf,
    // The folders looked in, each with its launcher, when none held the version.
    searched: Vec<(^'static str,
}

// Files named one by one (`--version-json`, `--client-jar`, `--libraries-dir`, `--assets-dir`),
// for launchers whose layout is not one `game_files` knows: each replaces what it names.
Inputs :: struct {
    version_json: Maybe(PathBuf),
    client_jar: Maybe(PathBuf),
    libraries_dir: Maybe(PathBuf),
    assets_dir: Maybe(PathBuf),
}

    // rust: impl GameFiles {
    // These files with what `inputs` names instead.
with :: proc(inputs: ^Inputs) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let pick = |given: &Option<PathBuf>, found: &mut PathBuf| {
    // rust: if let Some(given) = given.as_ref().filter(|p| !p.as_os_str().is_empty()) {
    // rust: *found = expand_user(given);
}
}
    // rust: pick(&inputs.version_json, &mut self.manifest);
    // rust: pick(&inputs.client_jar, &mut self.client);
    // rust: pick(&inputs.libraries_dir, &mut self.libraries);
    // rust: pick(&inputs.assets_dir, &mut self.assets);
    // rust: self
}
    // What to do when these files are missing, with the folders looked in.
    // rust: pub(crate) fn hint(&self, version: &str) -> String {
    // rust: let mut text = hint(LAUNCHER_HINT, version);
    // rust: if !self.searched.is_empty() {
    // rust: text += &format!(" Horizon looked for {version} in:");
    // rust: for (launcher, folder) in &self.searched {
    // rust: text += &format!("\n  {} ({launcher})", folder.display());
}
}
    // rust: text
}
}

// The layouts horizon-prepare reads in `folder`: the official launcher's, then ATLauncher's,
// which saves Mojang's version JSON as is in `configs/json/minecraft` and the client jar as
// the library `net.minecraft:client:<version>`.
layouts :: proc(folder: ^Path, version: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let files = |manifest: String, client: String, runtimes: &str| GameFiles {
    // rust: folder: folder.to_path_buf(),
    // rust: manifest: folder.join(manifest),
    // rust: client: folder.join(client),
    // rust: libraries: folder.join("libraries"),
    // rust: assets: folder.join("assets"),
    // rust: runtimes: folder.join(runtimes),
    // rust: searched: Vec::new(),
}
    // rust: let v = version;
    // rust: [
    // rust: files(
    // rust: format!("versions/{v}/{v}.json"),
    // rust: format!("versions/{v}/{v}.jar"),
    // rust: "runtime",
    // rust: ),
    // rust: files(
    // rust: format!("configs/json/minecraft/{v}.json"),
    // rust: format!("libraries/net/minecraft/client/{v}/client-{v}.jar"),
    // rust: "runtimes/minecraft",
    // rust: ),
    // rust: ]
}

// The launchers whose folders are looked in when none is chosen: the official launcher's
// (`minecraft_dir`), ATLauncher's, then the CurseForge app's `Install` folder, where it runs
// the official launcher (its default modding folder, `curseforge/minecraft`, is in the home
// folder on Windows and in Documents elsewhere). ATLauncher keeps its files in its working folder:
// where its Windows installer puts it, inside the macOS app, and the folders its Linux
// packages and Flatpak start it in.
launcher_folders :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut folders = vec![("the official launcher", minecraft_dir(None))];
    // The same folders as the Horizon launcher's (launcher/src/sources.rs `known_folders`).
    // rust: let atlauncher: Vec<PathBuf> = if cfg!(target_os = "macos") {
    // rust: let app = Path::new("Applications/ATLauncher.app/Contents/Java");
    // rust: vec![
    // rust: home().join("Library/Application Support/ATLauncher"),
    // rust: Path::new("/").join(app),
    // rust: home().join(app),
    // rust: ]
    // rust: } else if cfg!(windows) {
    // rust: std::env::var_os("APPDATA")
    // rust: .map(|d| PathBuf::from(d).join("ATLauncher"))
    // rust: .into_iter()
    // rust: .collect()
    // rust: } else {
    // rust: let data = std::env::var_os("XDG_DATA_HOME")
    // rust: .filter(|d| !d.is_empty())
    // rust: .map_or_else(|| home().join(".local/share"), PathBuf::from);
    // rust: let flatpak = home().join(".var/app/com.atlauncher.ATLauncher/data");
    // rust: vec![data.join("atlauncher"), flatpak.join("atlauncher"), flatpak]
}
    // rust: folders.extend(atlauncher.into_iter().map(|dir| ("ATLauncher", dir)));
    // rust: let curseforge = if cfg!(windows) { "" } else { "Documents" };
    // rust: folders.push((
    // rust: "the CurseForge app",
    // rust: home().join(curseforge).join("curseforge/minecraft/Install"),
    // rust: ));
    // rust: folders
}

// The pinned version's files in the chosen folder (`--minecraft-dir`, HORIZON_MINECRAFT_DIR),
// or the launcher above it when an instance folder (`instances/<name>`) is chosen; with no
// folder chosen, in the first launcher folder that has them. When none does, the official
// layout of the first folder is returned, for the errors to name, with the folders looked in.
game_files :: proc(chosen: Maybe(^Path), version: string) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let chosen = chosen
    // rust: .filter(|d| !d.as_os_str().is_empty())
    // rust: .map(Path::to_path_buf)
    // rust: .or_else(|| std::env::var_os("HORIZON_MINECRAFT_DIR").map(PathBuf::from))
    // rust: .filter(|d| !d.as_os_str().is_empty())
    // rust: .map(|d| expand_user(&d));
    // rust: let folders = match chosen {
    // rust: Some(dir) => {
    // rust: let launcher = dir
    // rust: .ancestors()
    // rust: .find(|a| a.file_name().is_some_and(|n| n == "instances"))
    // rust: .and_then(Path::parent)
    // rust: .map(Path::to_path_buf);
    // rust: let mut folders = vec![("the folder chosen", dir)];
    // rust: folders.extend(launcher.map(|dir| ("the launcher above it", dir)));
    // rust: folders
}
    // rust: None => launcher_folders(),
}
    // A folder with both files first: a version JSON left without its jar is used, for the
    // error to name the jar, only when no folder has both.
    // rust: let complete = |files: &GameFiles| files.manifest.is_file() && files.client.is_file();
    // rust: let partial = |files: &GameFiles| files.manifest.is_file();
    // rust: for found in [complete, partial] {
    // rust: let mut all = folders
    // rust: .iter()
    // rust: .flat_map(|(_, folder)| layouts(folder, version));
    // rust: if let Some(files) = all.find(found) {
    // rust: return files;
}
}
    // rust: let [mut files, _] = layouts(&folders[0].1, version);
    // rust: files.searched = folders;
    // rust: files
}

// Copy one file from the player's install, checked like a download; an existing verified
// copy is kept.
    // rust: pub(crate) fn import_copy(
    // rust: source: &Path,
    // rust: destination: &Path,
    // rust: checksum: &str,
    // rust: algorithm: &str,
    // rust: hint: &str,
    // rust: ) -> Result<PathBuf, String> {
    // rust: crate::files::Import::stage(source, destination, checksum, algorithm, false)
    // rust: .map_err(|error| {
    // rust: if !source.is_file() {
    // rust: format!("Missing {}. {hint}", source.display())
    // rust: .trim()
    // rust: .to_string()
    // rust: } else {
    // rust: error
}
    // rust: })?
    // rust: .commit()
}

// The pinned version JSON from the launcher's install. The launcher's copy wins over the
// cached one so the manifest matches the asset index installed alongside it.
    // rust: pub(crate) fn import_manifest(lock: &Lock, files: &GameFiles) -> Result<Value, String> {
    // rust: let version = &lock.version;
    // rust: let destination = lock.directory.join("manifest.json");
    // rust: let source = &files.manifest;
    // rust: if source.is_file() {
    // rust: let manifest = read_json(source)?;
    // rust: let downloads = manifest.get("downloads");
    // rust: let sha1 = |side: &str| {
    // rust: downloads
    // rust: .and_then(|d| d.get(side))
    // rust: .and_then(|d| d.get("sha1"))
    // rust: .and_then(Value::as_str)
}
    // rust: if manifest.get("id").and_then(Value::as_str) != Some(version)
    // rust: || sha1("client") != Some(lock.pin("client_sha1")?)
    // rust: || sha1("server") != Some(lock.pin("server_sha1")?)
    // rust: {
    // rust: return Err(format!(
    // rust: "{} does not describe the pinned {version} release",
    // rust: source.display()
    // rust: ));
}
    // rust: let checksum = digest(source, "sha1")?;
    // rust: if !lock.manifest_accepted(&checksum) {
            // Another launcher's rewrite of Mojang's file (HMCL and PCL add their own fields to
            // the same jars, #1772), or one Mojang republished: Mojang's own copy saved as the
            // imported one is used instead.
    // rust: let pinned = lock.pin("manifest_sha1")?;
    // rust: if !(destination.exists() && lock.manifest_accepted(&digest(&destination, "sha1")?)) {
    // rust: return Err(format!(
    // rust: "{} is not a {version} version file Horizon knows (sha1 {checksum}): your \
    // rust: launcher may have rewritten it, or Mojang republished it. Prepare from the \
    // rust: Horizon launcher, which downloads Mojang's own, or save \
    // rust: https://piston-meta.mojang.com/v1/packages/{pinned}/{version}.json as {} \
    // rust: and prepare again.",
    // rust: source.display(),
    // rust: destination.display()
    // rust: ));
}
    // rust: } else if !(destination.exists() && digest(&destination, "sha1")? == checksum) {
    // rust: fs::create_dir_all(&lock.directory).map_err(|e| e.to_string())?;
    // rust: fs::copy(source, &destination).map_err(|e| e.to_string())?;
}
    // rust: } else if !(destination.exists() && lock.manifest_accepted(&digest(&destination, "sha1")?)) {
    // rust: return Err(format!(
    // rust: "Missing {}. {}",
    // rust: source.display(),
    // rust: files.hint(version)
    // rust: ));
}
    // rust: let manifest = read_json(&destination)?;
    // rust: let java = manifest
    // rust: .get("javaVersion")
    // rust: .and_then(|j| j.get("majorVersion"))
    // rust: .and_then(Value::as_i64);
    // rust: if java != Some(lock.java_major) {
    // rust: return Err("Manifest Java version does not match lock file".into());
}
    // rust: Ok(manifest)
}

import_server :: proc(lock: ^Lock, server_jar: Maybe(^Path)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let version = &lock.version;
    // rust: let destination = lock.directory.join("jars/server.jar");
    // rust: let checksum = lock.pin("server_sha1")?;
    // rust: let hint = hint(SERVER_HINT, version);
    // rust: let source = server_jar
    // rust: .map(Path::to_path_buf)
    // rust: .or_else(|| std::env::var_os("HORIZON_SERVER_JAR").map(PathBuf::from));
    // rust: let Some(source) = source else {
    // rust: if destination.exists() && digest(&destination, "sha1")? == checksum {
    // rust: return Ok(destination);
}
    // rust: return Err(format!("No {version} server jar. {hint}"));
}
    // rust: import_copy(&expand_user(&source), &destination, checksum, "sha1", &hint)
}

// The launcher's `os.name` for this machine.
rule_system :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_os = "macos") {
    // rust: "osx"
    // rust: } else if cfg!(windows) {
    // rust: "windows"
    // rust: } else {
    // rust: "linux"
}
}

// This machine's architecture and its aliases, as Python's `platform.machine()` names them.
rule_architectures :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: match std::env::consts::ARCH {
    // rust: "x86_64" => vec!["x86_64", "amd64", "x64"],
    // rust: "aarch64" => vec!["arm64", "aarch64"],
    // rust: "x86" => vec!["i686"],
    // rust: other => vec![other],
}
}

// The kernel release Python's `platform.release()` reports (only old version JSONs ask).
os_release :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: {
    // rust: if let Ok(out) = std::process::Command::new("uname").arg("-r").output() {
    // rust: return String::from_utf8_lossy(&out.stdout).trim().to_string();
}
}
    // rust: String::new()
}

// The official launcher's rules: the last matching rule decides, no rules means allowed.
library_allowed :: proc(library: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let system = rule_system();
    // rust: let architectures = rule_architectures();
    // rust: let rules = library
    // rust: .get("rules")
    // rust: .and_then(Value::as_array)
    // rust: .unwrap_or(&[]);
    // rust: let mut allowed = rules.is_empty();
    // rust: for rule in rules {
    // rust: let empty = Value::Object(Vec::new());
    // rust: let os = rule.get("os").unwrap_or(&empty);
    // rust: if os.get("name").and_then(Value::as_str).unwrap_or(system) != system {
    // rust: continue;
}
    // rust: if let Some(arch) = os.get("arch") {
    // rust: let pattern = regex::Regex::new(&format!("^(?:{})$", arch.as_str().unwrap_or("")))
    // rust: .map_err(|e| e.to_string())?;
    // rust: if !architectures.iter().any(|name| pattern.is_match(name)) {
    // rust: continue;
}
}
    // rust: if let Some(version) = os.get("version") {
    // rust: let pattern =
    // rust: regex::Regex::new(version.as_str().unwrap_or("")).map_err(|e| e.to_string())?;
    // rust: if !pattern.is_match(&os_release()) {
    // rust: continue;
}
}
    // rust: if rule.get("features").is_some_and(|f| match f {
    // rust: Value::Object(o) => !o.is_empty(),
    // rust: Value::Array(a) => !a.is_empty(),
    // rust: Value::Null | Value::Bool(false) => false,
    // rust: Value::Str(s) => !s.is_empty(),
    // rust: _ => true,
    // rust: }) {
    // rust: continue;
}
    // rust: allowed = rule.get("action").and_then(Value::as_str) == Some("allow");
}
    // rust: Ok(allowed)
}

classifier_ends_with :: proc(classifier: string, names: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: names.iter().any(|name| {
    // rust: classifier == *name
    // rust: || classifier
    // rust: .strip_suffix(name)
    // rust: .is_some_and(|rest| rest.ends_with('-'))
    // rust: })
}

// Modern manifests list x64 and ARM natives with OS-only rules; keep this machine's. A plain
// natives-<os> jar is the x64 build when the manifest also lists an ARM variant of it.
native_library_matches :: proc(library: ^Value, names: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let arm = rule_architectures().contains(&"arm64");
    // rust: let name = library.get("name").and_then(Value::as_str).unwrap_or("");
    // rust: let classifier = name.split(':').nth(3).unwrap_or("");
    // rust: if classifier_ends_with(classifier, &["arm64", "aarch64", "aarch_64"]) {
    // rust: return arm;
}
    // rust: if classifier_ends_with(classifier, &["x86_64", "x64"]) {
    // rust: return !arm;
}
    // rust: if arm && classifier.starts_with("natives-") {
    // rust: return !["arm64", "aarch64"]
    // rust: .iter()
    // rust: .any(|suffix| names.contains(&format!("{name}-{suffix}").as_str()));
}
    // rust: true
}

// The client libraries the official launcher installs on this OS and architecture: each
// library's Maven name and its download.
client_library_artifacts :: proc(manifest: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let libraries = manifest
    // rust: .get("libraries")
    // rust: .and_then(Value::as_array)
    // rust: .ok_or("The version JSON has no libraries")?;
    // rust: let names: Vec<&str> = libraries
    // rust: .iter()
    // rust: .filter_map(|l| l.get("name").and_then(Value::as_str))
    // rust: .collect();
    // rust: let mut artifacts = Vec::new();
    // rust: for library in libraries {
    // rust: let Some(artifact) = library.get("downloads").and_then(|d| d.get("artifact")) else {
    // rust: continue;
}
    // rust: if library_allowed(library)? && native_library_matches(library, &names) {
    // rust: let name = library.get("name").and_then(Value::as_str).unwrap_or("");
    // rust: artifacts.push((name, artifact));
}
}
    // rust: Ok(artifacts)
}

// Netty's native transports (`io.netty:netty-transport-native-kqueue:4.2.16.Final:osx-aarch_64`,
// the epoll ones on Linux): the game uses one when it loads and Netty NIO otherwise
// (`EventLoopGroupHolder.remote` asks `KQueue.isAvailable()`, then `Epoll.isAvailable()`), and
// Prism Launcher never downloads them (#1487). Preparing imports one when the launcher has it.
runs_without :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut parts = name.split(':');
    // rust: parts.next() == Some("io.netty")
    // rust: && parts
    // rust: .next()
    // rust: .is_some_and(|artifact| artifact.starts_with("netty-transport-native-"))
    // rust: && parts.nth(1).is_some()
}

// A relative path with only normal components and forward slashes, from a manifest or bundle.
    // rust: pub(crate) fn safe_relative(path: &str) -> Option<PathBuf> {
    // rust: if path.contains('\\') || path.starts_with('/') {
    // rust: return None;
}
    // rust: let parts: Vec<&str> = path
    // rust: .split('/')
    // rust: .filter(|p| !p.is_empty() && *p != ".")
    // rust: .collect();
    // rust: if parts.contains(&"..") || (cfg!(windows) && parts.first().is_some_and(|p| p.contains(':'))) {
    // rust: return None;
}
    // rust: Some(parts.iter().collect())
}

// A launcher's copy of the library `name`, whose path in the version JSON is `relative`, under
// its game folder `minecraft`: at that path, else where Prism Launcher keeps it (#849). Prism's
// metadata moves a native jar's classifier into its artifact name
// (`com.mojang:jtracy:1.14.38:natives-windows` is its `com.mojang:jtracy-natives-windows:1.14.38`)
// and Prism keeps libraries at their name's path, so the same jar, with the same sha1, is in
// `com/mojang/jtracy-natives-windows/1.14.38/jtracy-natives-windows-1.14.38.jar`. The path the
// version JSON gives is returned when neither exists, for the error to name.
launcher_library :: proc(minecraft: ^Path, name: string, relative: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: library_in(&minecraft.join("libraries"), name, relative)
}

// `launcher_library` in a libraries folder of its own.
library_in :: proc(libraries: ^Path, name: string, relative: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let official = libraries.join(relative);
    // rust: if official.is_file() {
    // rust: return official;
}
    // rust: if let [group, artifact, version, classifier] = name.split(':').collect::<Vec<_>>()[..] {
    // rust: let artifact = format!("{artifact}-{classifier}");
    // rust: let path = format!(
    // rust: "{}/{artifact}/{version}/{artifact}-{version}.jar",
    // rust: group.replace('.', "/")
    // rust: );
    // rust: if let Some(prism) = safe_relative(&path)
    // rust: .map(|p| libraries.join(p))
    // rust: .filter(|p| p.is_file())
    // rust: {
    // rust: return prism;
}
}
    // rust: official
}

artifact_fields :: proc(artifact: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = artifact.get("path").and_then(Value::as_str);
    // rust: let sha1 = artifact.get("sha1").and_then(Value::as_str);
    // rust: path.zip(sha1)
    // rust: .ok_or_else(|| "A library in the version JSON has no path or sha1".to_string())
}

// `(sha256, identifier, path)` lines of a server bundle's versions.list or libraries.list.
    // rust: fn bundle_entries(
    // rust: archive: &mut crate::Jar,
    // rust: name: &str,
    // rust: ) -> Result<Vec<(String, String, PathBuf, String)>, String> {
    // rust: let text = crate::zip_text(archive, name)?;
    // rust: let mut entries = Vec::new();
    // rust: for line in crate::split_lines(&text) {
    // rust: if line.trim().is_empty() {
    // rust: continue;
}
    // rust: let fields: Vec<&str> = line.split('\t').collect();
    // rust: let [checksum, identifier, relative] = fields[..] else {
    // rust: return Err(format!("Malformed line in {name}"));
}
    // rust: let path =
    // rust: safe_relative(relative).ok_or_else(|| format!("Unsafe bundled path: {relative}"))?;
        // PurePosixPath's text: empty and `.` parts dropped.
    // rust: let posix = relative
    // rust: .split('/')
    // rust: .filter(|p| !p.is_empty() && *p != ".")
    // rust: .collect::<Vec<_>>()
    // rust: .join("/");
    // rust: entries.push((checksum.to_string(), identifier.to_string(), path, posix));
}
    // rust: Ok(entries)
}

    // rust: fn extract_verified(
    // rust: archive: &mut crate::Jar,
    // rust: member: &str,
    // rust: destination: &Path,
    // rust: checksum: &str,
    // rust: ) -> Result<(), String> {
    // rust: let data = crate::zip_bytes(archive, member)?;
    // rust: if crate::sha256_hex(&data) != checksum {
    // rust: return Err(format!("Bundled artifact checksum mismatch: {member}"));
}
    // rust: fs::create_dir_all(destination.parent().unwrap()).map_err(|e| e.to_string())?;
    // rust: fs::write(destination, data).map_err(|e| format!("{}: {e}", destination.display()))
}

// Modern server downloads are launchers: the game jar and its libraries are inside.
    // rust: fn unpack_server(
    // rust: server: PathBuf,
    // rust: directory: &Path,
    // rust: version: &str,
    // rust: ) -> Result<(PathBuf, Vec<PathBuf>), String> {
    // rust: let mut archive = crate::open_zip(&server)?;
    // rust: if archive.index_for_name("META-INF/versions.list").is_none() {
    // rust: return Ok((server, Vec::new()));
}
    // rust: let versions = bundle_entries(&mut archive, "META-INF/versions.list")?;
    // rust: if versions.len() != 1 || versions[0].1 != version {
    // rust: return Err("Expected one bundled server matching the pinned version".into());
}
    // rust: let (checksum, _, _, relative) = &versions[0];
    // rust: let game = directory.join("jars/server-game.jar");
    // rust: extract_verified(
    // rust: &mut archive,
    // rust: &format!("META-INF/versions/{relative}"),
    // rust: &game,
    // rust: checksum,
    // rust: )?;
    // rust: let entries = bundle_entries(&mut archive, "META-INF/libraries.list")?;
    // rust: let libraries = crate::pool::map(&entries, |(checksum, _, path, relative)| {
    // rust: let destination = directory.join("libraries/server").join(path);
    // rust: extract_verified(
    // rust: &mut archive.clone(),
    // rust: &format!("META-INF/libraries/{relative}"),
    // rust: &destination,
    // rust: checksum.as_str(),
    // rust: )?;
    // rust: Ok(destination)
    // rust: })?;
    // rust: Ok((game, libraries))
}

// Imports the player's own pinned game files into `.local/minecraft/<version>` and writes the
// class inventories and prepared.json (tools/lab.py `prepare`). The decompiler lab.py also
// fetches is a development tool, not something preparing needs; `tools/lab.py prepare` gets it.
    // rust: pub fn import(
    // rust: root: &Path,
    // rust: lock: &Lock,
    // rust: minecraft: Option<&Path>,
    // rust: inputs: &Inputs,
    // rust: server_jar: Option<&Path>,
    // rust: log: Log,
    // rust: ) -> Result<(), String> {
    // rust: let files = game_files(minecraft, &lock.version).with(inputs);
    // rust: let manifest = import_manifest(lock, &files)?;
    // rust: let client = import_copy(
    // rust: &files.client,
    // rust: &lock.directory.join("jars/client.jar"),
    // rust: lock.pin("client_sha1")?,
    // rust: "sha1",
    // rust: &files.hint(&lock.version),
    // rust: )?;
    // rust: let downloads = manifest.get("downloads");
    // rust: if downloads.and_then(|d| d.get("client_mappings")).is_some()
    // rust: || downloads.and_then(|d| d.get("server_mappings")).is_some()
    // rust: {
    // rust: return Err(
    // rust: "This workflow targets unobfuscated releases. Older releases need a remapping stage."
    // rust: .into(),
    // rust: );
}
    // rust: let id = manifest
    // rust: .get("id")
    // rust: .and_then(Value::as_str)
    // rust: .ok_or("The version JSON has no id")?;
    // The jar read, which --client-jar may have named outside the Minecraft folder.
    // rust: log(&format!(
    // rust: "Imported client {id} from {}",
    // rust: files.client.display()
    // rust: ));
    // rust: let server = import_server(lock, server_jar)?;
    // rust: let (server, server_libraries) = unpack_server(server, &lock.directory, id)?;
    // rust: let mut imports = Vec::new();
    // rust: for (name, artifact) in client_library_artifacts(&manifest)? {
    // rust: let (path, sha1) = artifact_fields(artifact)?;
    // rust: let relative = safe_relative(path).ok_or("Unsafe library path")?;
    // rust: let source = library_in(&files.libraries, name, &relative);
    // rust: let destination = lock.directory.join("libraries/client").join(&relative);
    // rust: if runs_without(name) && !source.is_file() && !destination.exists() {
    // rust: log(&format!(
    // rust: "No {name} in {}: the game runs without it",
    // rust: files.libraries.display()
    // rust: ));
    // rust: continue;
}
    // rust: imports.push((source, destination, sha1));
}
    // rust: let hint = files.hint(&lock.version);
    // rust: let client_libraries = crate::pool::map(&imports, |(source, destination, sha1)| {
    // rust: import_copy(source, destination, sha1, "sha1", &hint)
    // rust: })?;
    // rust: write_import_metadata(
    // rust: root,
    // rust: lock,
    // rust: &client,
    // rust: &server,
    // rust: &client_libraries,
    // rust: &server_libraries,
    // rust: log,
    // rust: )
}

    // rust: fn write_import_metadata(
    // rust: root: &Path,
    // rust: lock: &Lock,
    // rust: client: &Path,
    // rust: server: &Path,
    // rust: client_libraries: &[PathBuf],
    // rust: server_libraries: &[PathBuf],
    // rust: log: Log,
    // rust: ) -> Result<(), String> {
    // rust: let sides = [("client", client), ("server", server)];
    // rust: let inventories = crate::pool::map(&sides, |(_, jar)| crate::inventory::inventory(jar))?;
    // rust: for ((side, _), data) in sides.into_iter().zip(inventories) {
    // rust: let count = |key| data.get(key).cloned().unwrap_or(Value::Null);
    // rust: write_json(
    // rust: &lock
    // rust: .directory
    // rust: .join(format!("reports/{side}-inventory.json")),
    // rust: &data,
    // rust: )?;
    // rust: log(&format!(
    // rust: "{side}: {} classes, {} methods",
    // rust: pyjson::dumps(&count("class_count"), &pyjson::DEFAULT),
    // rust: pyjson::dumps(&count("method_count"), &pyjson::DEFAULT)
    // rust: ));
}
    // rust: let paths = |list: &[PathBuf]| -> Result<Value, String> {
    // rust: Ok(Value::Array(
    // rust: list.iter()
    // rust: .map(|p| relative_display(p, root).map(Value::Str))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ))
}
    // rust: write_json(
    // rust: &lock.directory.join("prepared.json"),
    // rust: &Value::Object(vec![
    // rust: ("version".into(), Value::str(&lock.version)),
    // rust: (
    // rust: "jars".into(),
    // rust: Value::Object(vec![
    // rust: ("client".into(), Value::Str(relative_display(client, root)?)),
    // rust: ("server".into(), Value::Str(relative_display(server, root)?)),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "libraries".into(),
    // rust: Value::Object(vec![
    // rust: ("client".into(), paths(client_libraries)?),
    // rust: ("server".into(), paths(server_libraries)?),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: )?;
    // rust: log(&format!("Artifacts: {}", lock.directory.display()));
    // rust: Ok(())
}

// The checked jars (`client`, `server` = the bundle's inner game jar) and the server
// libraries, authenticated against the lock and the bundle's own checksums on every run.
Artifacts :: struct {
    manifest: Value,
    jars: HashMap<^'static str,
    libraries: [dynamic]PathBuf,
}

// Reuses checked imports from this root or another installed version beside it.
reuse_imported :: proc(root: ^Path, log: Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(reuse_verified(root, log)?.is_some())
}

// Keep this preparation's verified artifacts and client libraries for the exporters.
    // rust: pub(crate) fn reuse_verified(
    // rust: root: &Path,
    // rust: log: Log,
    // rust: ) -> Result<Option<(Artifacts, Vec<PathBuf>)>, String> {
    // rust: let root = fs::canonicalize(root).map_err(|e| format!("{}: {e}", root.display()))?;
    // rust: let lock = Lock::read(&root)?;
    // rust: let checked = |directory: PathBuf| -> Result<(Artifacts, Vec<PathBuf>), String> {
    // rust: let candidate = Lock {
    // rust: json: lock.json.clone(),
    // rust: version: lock.version.clone(),
    // rust: java_major: lock.java_major,
    // rust: directory,
}
    // rust: let found = verify(&candidate)?;
    // rust: let client = client_libraries(&candidate, &found.manifest)?;
    // rust: Ok((found, client))
}
    // rust: if let Ok((found, client_libraries)) = checked(lock.directory.clone()) {
    // rust: if [
    // rust: "prepared.json",
    // rust: "reports/client-inventory.json",
    // rust: "reports/server-inventory.json",
    // rust: ]
    // rust: .iter()
    // rust: .any(|path| !lock.directory.join(path).is_file())
    // rust: {
    // rust: write_import_metadata(
    // rust: &root,
    // rust: &lock,
    // rust: &found.jars["client"],
    // rust: &found.jars["server"],
    // rust: &client_libraries,
    // rust: &found.libraries,
    // rust: log,
    // rust: )?;
}
    // rust: log(&format!("Using imported Minecraft {}", lock.version));
    // rust: return Ok(Some((found, client_libraries)));
}
    // rust: let Some(versions) = root.parent() else {
    // rust: return Ok(None);
}
    // Sibling discovery is intended for the launcher's versions/ folder.
    // rust: let mut siblings: Vec<_> = fs::read_dir(versions)
    // rust: .map_err(|e| format!("{}: {e}", versions.display()))?
    // rust: .filter_map(Result::ok)
    // rust: .map(|entry| entry.path())
    // rust: .filter(|path| path != &root && path.is_dir())
    // rust: .collect();
    // rust: siblings.sort();
    // rust: for sibling in siblings {
    // rust: let source = sibling.join(".local/minecraft").join(&lock.version);
    // rust: let Ok((found, client)) = checked(source.clone()) else {
    // rust: continue;
}
    // rust: let mut files = vec![
    // rust: source.join("manifest.json"),
    // rust: source.join("jars/client.jar"),
    // rust: source.join("jars/server.jar"),
    // rust: found.jars["server"].clone(),
    // rust: ];
    // rust: files.extend(found.libraries);
    // rust: files.extend(client);
    // rust: for file in files {
    // rust: let relative = file.strip_prefix(&source).map_err(|e| e.to_string())?;
    // rust: import_copy(
    // rust: &file,
    // rust: &lock.directory.join(relative),
    // rust: &digest(&file, "sha256")?,
    // rust: "sha256",
    // rust: "",
    // rust: )?;
}
    // rust: let found = verify(&lock)?;
    // rust: let client_libraries = client_libraries(&lock, &found.manifest)?;
    // rust: write_import_metadata(
    // rust: &root,
    // rust: &lock,
    // rust: &found.jars["client"],
    // rust: &found.jars["server"],
    // rust: &client_libraries,
    // rust: &found.libraries,
    // rust: log,
    // rust: )?;
    // rust: log(&format!(
    // rust: "Reused imported Minecraft {} from {}",
    // rust: lock.version,
    // rust: sibling.display()
    // rust: ));
    // rust: return Ok(Some((found, client_libraries)));
}
    // rust: Ok(None)
}

verify :: proc(lock: ^Lock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let manifest_path = lock.directory.join("manifest.json");
    // rust: if !manifest_path.exists() {
    // rust: return Err(format!(
    // rust: "{} is missing: prepare with --prepare first",
    // rust: manifest_path.display()
    // rust: ));
}
    // rust: if !lock.manifest_accepted(&digest(&manifest_path, "sha1")?) {
    // rust: return Err("Manifest checksum changed; prepare again with --prepare".into());
}
    // rust: let manifest = read_json(&manifest_path)?;
    // rust: let id = manifest.get("id").and_then(Value::as_str).unwrap_or("");
    // rust: if id != lock.version {
    // rust: return Err("Manifest version differs from the lock".into());
}
    // rust: let mut jars = HashMap::new();
    // rust: let sides = ["client", "server"];
    // rust: let checked = crate::pool::map(&sides, |side| {
    // rust: let jar = lock.directory.join(format!("jars/{side}.jar"));
    // rust: let pinned = manifest
    // rust: .get("downloads")
    // rust: .and_then(|d| d.get(side))
    // rust: .and_then(|d| d.get("sha1"))
    // rust: .and_then(Value::as_str);
    // rust: let good = pinned == Some(lock.pin(&format!("{side}_sha1"))?)
    // rust: && jar.exists()
    // rust: && Some(digest(&jar, "sha1")?.as_str()) == pinned;
    // rust: Ok((good, jar))
    // rust: })?;
    // rust: for (side, (good, jar)) in sides.into_iter().zip(checked) {
    // rust: if !good {
    // rust: return Err(format!(
    // rust: "{side} artifact checksum changed; prepare again with --prepare"
    // rust: ));
}
    // rust: jars.insert(side, jar);
}
    // rust: let mut archive = crate::open_zip(&jars["server"])?;
    // rust: let versions = bundle_entries(&mut archive, "META-INF/versions.list")?;
    // rust: if versions.len() != 1 || versions[0].1 != id {
    // rust: return Err("Unexpected server bundle".into());
}
    // rust: let game = lock.directory.join("jars/server-game.jar");
    // rust: if !game.exists() || digest(&game, "sha256")? != versions[0].0 {
    // rust: return Err("Inner server artifact checksum changed".into());
}
    // rust: jars.insert("server", game);
    // rust: let entries = bundle_entries(&mut archive, "META-INF/libraries.list")?;
    // rust: let libraries = crate::pool::map(&entries, |(checksum, _, path, relative)| {
    // rust: let library = lock.directory.join("libraries/server").join(path);
    // rust: if !library.exists() || digest(&library, "sha256")? != *checksum {
    // rust: return Err(format!("Dependency checksum changed: {relative}"));
}
    // rust: Ok(library)
    // rust: })?;
    // rust: Ok(Artifacts {
    // rust: manifest,
    // rust: jars,
    // rust: libraries,
    // rust: })
}

// The client libraries, checked against the version JSON (tools/test_model_baking_parity.py's
// `client_libraries`); the client-side exporters compile against them. A native transport the
// player's launcher did not have is left out.
client_libraries :: proc(lock: ^Lock, manifest: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let artifacts = client_library_artifacts(manifest)?;
    // rust: let libraries = crate::pool::map(&artifacts, |(name, artifact)| {
    // rust: let (path, sha1) = artifact_fields(artifact)?;
    // rust: let relative = safe_relative(path).ok_or("Unsafe client library path")?;
    // rust: let library = lock.directory.join("libraries/client").join(&relative);
    // rust: if runs_without(name) && !library.exists() {
    // rust: return Ok(None);
}
    // rust: if !library.exists() || digest(&library, "sha1")? != sha1 {
    // rust: return Err(format!("Client dependency checksum changed: {path}"));
}
    // rust: Ok(Some(library))
    // rust: })?;
    // rust: Ok(libraries.into_iter().flatten().collect())
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

jar :: proc(marker: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut archive = zip::ZipWriter::new(std::io::Cursor::new(Vec::new()));
    // rust: archive
    // rust: .start_file("marker", zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: archive.write_all(marker).unwrap();
    // rust: archive.finish().unwrap().into_inner()
}

Imports :: struct {
    directory: PathBuf,
    source: PathBuf,
    target: PathBuf,
}

    // rust: impl Imports {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
NEXT :: std::sync::atomic::AtomicUsize::new(0)
    // rust: let n = NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let directory = std::env::temp_dir()
    // rust: .join(format!("horizon-import-reuse-{}-{n}", std::process::id()));
    // rust: let source = directory.join("old");
    // rust: let target = directory.join("new");
    // rust: fs::create_dir_all(&target).unwrap();
    // rust: let imported = source.join(".local/minecraft/9.9");
    // rust: let write = |path: &str, data: &[u8]| {
    // rust: let path = imported.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, data).unwrap();
}
    // rust: let client = jar(b"client");
    // rust: let game = jar(b"server game");
    // rust: write("jars/client.jar", &client);
    // rust: write("jars/server-game.jar", &game);
    // rust: write("libraries/server/server.jar", b"server library");
    // rust: write("libraries/client/client.jar", b"client library");
    // rust: write("reports/private.txt", b"not an imported artifact");
    // rust: let mut bundle =
    // rust: zip::ZipWriter::new(fs::File::create(imported.join("jars/server.jar")).unwrap());
    // rust: let entries = [
    // rust: (
    // rust: "META-INF/versions.list",
    // rust: format!("{}\t9.9\tgame.jar\n", crate::sha256_hex(&game)),
    // rust: ),
    // rust: (
    // rust: "META-INF/libraries.list",
    // rust: format!(
    // rust: "{}\tserver:library:1\tserver.jar\n",
    // rust: crate::sha256_hex(b"server library")
    // rust: ),
    // rust: ),
    // rust: ];
    // rust: for (name, text) in entries {
    // rust: bundle
    // rust: .start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: bundle.write_all(text.as_bytes()).unwrap();
}
    // rust: for (name, bytes) in [
    // rust: ("META-INF/versions/game.jar", game.as_slice()),
    // rust: (
    // rust: "META-INF/libraries/server.jar",
    // rust: b"server library".as_slice(),
    // rust: ),
    // rust: ] {
    // rust: bundle
    // rust: .start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: bundle.write_all(bytes).unwrap();
}
    // rust: bundle.finish().unwrap();
    // rust: let client_sha1 = digest(&imported.join("jars/client.jar"), "sha1").unwrap();
    // rust: let server_sha1 = digest(&imported.join("jars/server.jar"), "sha1").unwrap();
    // rust: let library_sha1 =
    // rust: digest(&imported.join("libraries/client/client.jar"), "sha1").unwrap();
    // rust: let manifest = format!(
    // rust: "{{\"id\":\"9.9\",\"downloads\":{{\"client\":{{\"sha1\":\"{client_sha1}\"}},\"server\":{{\"sha1\":\"{server_sha1}\"}}}},\"libraries\":[{{\"name\":\"client:library:1\",\"downloads\":{{\"artifact\":{{\"path\":\"client.jar\",\"sha1\":\"{library_sha1}\"}}}}}}]}}"
    // rust: );
    // rust: write("manifest.json", manifest.as_bytes());
    // rust: let manifest_sha1 = digest(&imported.join("manifest.json"), "sha1").unwrap();
    // rust: let lock = format!(
    // rust: "{{\"minecraft\":{{\"version\":\"9.9\",\"java_major\":25,\"manifest_sha1\":\"{manifest_sha1}\",\"client_sha1\":\"{client_sha1}\",\"server_sha1\":\"{server_sha1}\"}}}}"
    // rust: );
    // rust: fs::write(target.join("research-lock.json"), lock).unwrap();
    // rust: Self {
    // rust: directory,
    // rust: source,
    // rust: target,
}
}

imported :: proc(self: ^Self, root: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: root.join(".local/minecraft/9.9")
}
}

    // rust: impl Drop for Imports {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.directory);
}
}

imported_files_are_reused_without_the_official_install :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: fs::write(
    // rust: fixture.imported(&fixture.source).join("prepared.json"),
    // rust: b"stale source metadata",
    // rust: )
    // rust: .unwrap();
    // rust: assert!(reuse_imported(&fixture.target, &|_| {}).unwrap());
    // rust: let lock = Lock::read(&fixture.target).unwrap();
    // rust: let artifacts = verify(&lock).unwrap();
    // rust: assert_eq!(
    // rust: client_libraries(&lock, &artifacts.manifest).unwrap().len(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(artifacts.libraries.len(), 1);
    // rust: let prepared = read_json(&lock.directory.join("prepared.json")).unwrap();
    // rust: assert_eq!(prepared.get("version").and_then(Value::as_str), Some("9.9"));
    // rust: for side in ["client", "server"] {
    // rust: assert_eq!(
    // rust: prepared
    // rust: .get("jars")
    // rust: .unwrap()
    // rust: .get(side)
    // rust: .and_then(Value::as_str),
    // rust: Some(
    // rust: relative_display(&artifacts.jars[side], &fixture.target)
    // rust: .unwrap()
    // rust: .as_str()
    // rust: )
    // rust: );
    // rust: let inventory = read_json(
    // rust: &lock
    // rust: .directory
    // rust: .join(format!("reports/{side}-inventory.json")),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: inventory.get("jar_sha256").and_then(Value::as_str),
    // rust: Some(digest(&artifacts.jars[side], "sha256").unwrap().as_str())
    // rust: );
}
    // rust: assert!(!lock.directory.join("reports/private.txt").exists());
    // rust: for side in ["client", "server"] {
    // rust: let libraries = prepared
    // rust: .get("libraries")
    // rust: .unwrap()
    // rust: .get(side)
    // rust: .unwrap()
    // rust: .as_array()
    // rust: .unwrap();
    // rust: assert_eq!(libraries.len(), 1);
    // rust: assert_eq!(
    // rust: libraries[0].as_str(),
    // rust: Some(
    // rust: relative_display(
    // rust: &lock.directory.join(format!("libraries/{side}/{side}.jar")),
    // rust: &fixture.target
    // rust: )
    // rust: .unwrap()
    // rust: .as_str()
    // rust: )
    // rust: );
}
        // The current root's valid imports suffice even after the older copy is corrupted.
    // rust: fs::write(
    // rust: fixture.imported(&fixture.source).join("jars/client.jar"),
    // rust: b"bad",
    // rust: )
    // rust: .unwrap();
        // Repair metadata omitted by earlier reuse implementations, without a sibling.
    // rust: fs::remove_file(lock.directory.join("prepared.json")).unwrap();
    // rust: fs::remove_file(lock.directory.join("reports/client-inventory.json")).unwrap();
    // rust: assert!(reuse_imported(&fixture.target, &|_| {}).unwrap());
    // rust: assert!(read_json(&lock.directory.join("prepared.json")).is_ok());
    // rust: assert!(read_json(&lock.directory.join("reports/client-inventory.json")).is_ok());
}

reuse_rejects_corrupt_imports :: proc() {
}
    // rust: for file in [
    // rust: "manifest.json",
    // rust: "jars/client.jar",
    // rust: "jars/server.jar",
    // rust: "jars/server-game.jar",
    // rust: "libraries/client/client.jar",
    // rust: "libraries/server/server.jar",
    // rust: ] {
    // rust: let fixture = Imports::new();
    // rust: fs::write(fixture.imported(&fixture.source).join(file), b"bad").unwrap();
    // rust: assert!(!reuse_imported(&fixture.target, &|_| {}).unwrap(), "{file}");
    // rust: assert!(!fixture.imported(&fixture.target).exists());
}
}

reuse_checks_the_target_pins :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let mut lock = Lock::read(&fixture.target).unwrap();
    // rust: let client = lock.pin("client_sha1").unwrap().to_string();
    // rust: let text = fs::read_to_string(fixture.target.join("research-lock.json")).unwrap();
    // rust: fs::write(
    // rust: fixture.target.join("research-lock.json"),
    // rust: text.replace(&client, "wrong-client-pin"),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(!reuse_imported(&fixture.target, &|_| {}).unwrap());
    // rust: lock.directory = fixture.imported(&fixture.source);
    // rust: assert!(verify(&lock).is_ok());
}

reuse_skips_a_bad_sibling_and_repairs_bad_current_imports :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let bad = fixture.directory.join("a-bad");
    // rust: fs::rename(&fixture.source, &bad).unwrap();
    // rust: let valid = Imports::new();
    // rust: fs::rename(&valid.source, &fixture.source).unwrap();
    // rust: fs::write(fixture.imported(&bad).join("jars/client.jar"), b"bad").unwrap();
    // rust: let target = fixture.imported(&fixture.target);
    // rust: fs::create_dir_all(target.join("jars")).unwrap();
    // rust: fs::write(target.join("jars/client.jar"), b"bad").unwrap();
    // rust: assert!(reuse_imported(&fixture.target, &|_| {}).unwrap());
    // rust: assert_eq!(
    // rust: fs::read(target.join("jars/client.jar")).unwrap(),
    // rust: fs::read(fixture.imported(&fixture.source).join("jars/client.jar")).unwrap()
    // rust: );
}

    // A native jar is found where the official launcher keeps it, else under the name Prism
    // Launcher's metadata gives it (#849); a plain library only at the version JSON's path.
libraries_are_found_where_prism_launcher_keeps_them :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let minecraft = &fixture.directory;
    // rust: let official = Path::new("com/mojang/jtracy/1.14.38/jtracy-1.14.38-natives-windows.jar");
    // rust: let name = "com.mojang:jtracy:1.14.38:natives-windows";
    // rust: let prism = minecraft.join(
    // rust: "libraries/com/mojang/jtracy-natives-windows/1.14.38/jtracy-natives-windows-1.14.38.jar",
    // rust: );
    // rust: assert_eq!(
    // rust: launcher_library(minecraft, name, official),
    // rust: minecraft.join("libraries").join(official)
    // rust: );
    // rust: fs::create_dir_all(prism.parent().unwrap()).unwrap();
    // rust: fs::write(&prism, b"natives").unwrap();
    // rust: assert_eq!(launcher_library(minecraft, name, official), prism);
    // rust: let mojang = minecraft.join("libraries").join(official);
    // rust: fs::create_dir_all(mojang.parent().unwrap()).unwrap();
    // rust: fs::write(&mojang, b"natives").unwrap();
    // rust: assert_eq!(launcher_library(minecraft, name, official), mojang);
    // rust: let plain = Path::new("com/mojang/jtracy/1.14.38/jtracy-1.14.38.jar");
    // rust: assert_eq!(
    // rust: launcher_library(minecraft, "com.mojang:jtracy:1.14.38", plain),
    // rust: minecraft.join("libraries").join(plain)
    // rust: );
    // rust: for unsafe_name in ["a:..:1:x", "a:b\\c:1:x"] {
    // rust: let path = launcher_library(minecraft, unsafe_name, plain);
    // rust: assert_eq!(
    // rust: path,
    // rust: minecraft.join("libraries").join(plain),
    // rust: "{unsafe_name}"
    // rust: );
}
}

    // A launcher that rewrites Mojang's version file in the official layout (HMCL, PCL: the same
    // id and jars, its own fields, #1772) is refused with what to do, and Mojang's own copy saved
    // as the imported one is then used.
a_rewritten_version_file_falls_back_to_mojangs :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-rewritten-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let mojang = r#"{"id":"9.9","javaVersion":{"majorVersion":25},"downloads":{"client":{"sha1":"c"},"server":{"sha1":"s"}}}"#;
    // rust: let rewritten = r#"{"id":"9.9","javaVersion":{"majorVersion":25},"downloads":{"client":{"sha1":"c"},"server":{"sha1":"s"}},"patches":[],"root":true}"#;
    // rust: let minecraft = root.join("minecraft");
    // rust: fs::create_dir_all(minecraft.join("versions/9.9")).unwrap();
    // rust: fs::write(minecraft.join("versions/9.9/9.9.json"), rewritten).unwrap();
    // rust: fs::write(root.join("mojang.json"), mojang).unwrap();
    // rust: let pinned = digest(&root.join("mojang.json"), "sha1").unwrap();
    // rust: fs::write(
    // rust: root.join("research-lock.json"),
    // rust: format!(
    // rust: r#"{{"minecraft":{{"version":"9.9","java_major":25,"manifest_sha1":"{pinned}","client_sha1":"c","server_sha1":"s"}}}}"#
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: let lock = Lock::read(&root).unwrap();
    // rust: let destination = lock.directory.join("manifest.json");

    // rust: let error = import_manifest(&lock, &game_files(Some(&minecraft), "9.9")).unwrap_err();
    // rust: assert!(error.contains("may have rewritten it"), "{error}");
    // rust: assert!(
    // rust: error.contains(&format!("packages/{pinned}/9.9.json")),
    // rust: "{error}"
    // rust: );
    // rust: assert!(
    // rust: error.contains(&destination.display().to_string()),
    // rust: "{error}"
    // rust: );
    // rust: assert!(!destination.exists());

    // rust: fs::create_dir_all(&lock.directory).unwrap();
    // rust: fs::copy(root.join("mojang.json"), &destination).unwrap();
    // rust: let manifest = import_manifest(&lock, &game_files(Some(&minecraft), "9.9")).unwrap();
    // rust: assert!(manifest.get("patches").is_none());
    // rust: assert_eq!(digest(&destination, "sha1").unwrap(), pinned);
    // rust: fs::remove_dir_all(&root).unwrap();
}

    // scanfee's Prism Launcher 26.3 install on a Mac (#1487): Prism keeps natives under its own
    // names and never downloads Netty's native transport, which the game runs without. Preparing
    // still checks every other library, and the transport whenever the launcher has it.
a_prism_install_without_netty_natives_prepares :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let old = fixture.imported(&fixture.source);
    // rust: let prism = fixture.directory.join("PrismLauncher");
    // rust: let put = |path: &str, data: &[u8]| {
    // rust: let path = prism.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, data).unwrap();
}
    // rust: put(
    // rust: "versions/9.9/9.9.jar",
    // rust: &fs::read(old.join("jars/client.jar")).unwrap(),
    // rust: );
    // rust: put("libraries/org/lib/lib/1/lib-1.jar", b"lib");
    // rust: put(
    // rust: "libraries/com/mojang/jtracy-natives-test/1/jtracy-natives-test-1.jar",
    // rust: b"jtracy natives",
    // rust: );
    // rust: let sha1 = |data: &[u8]| {
    // rust: let file = fixture.directory.join("sha1");
    // rust: fs::write(&file, data).unwrap();
    // rust: digest(&file, "sha1").unwrap()
}
    // rust: let library = |name: &str, path: &str, sha1: &str, rules: &str| {
    // rust: format!(
    // rust: r#"{{"name":"{name}","downloads":{{"artifact":{{"path":"{path}","sha1":"{sha1}"}}}}{rules}}}"#
    // rust: )
}
    // rust: let netty = |arch: &str| {
    // rust: library(
    // rust: &format!("io.netty:netty-transport-native-kqueue:1:osx-{arch}"),
    // rust: &format!("io/netty/netty-transport-native-kqueue/1/netty-transport-native-kqueue-1-osx-{arch}.jar"),
    // rust: &sha1(b"kqueue"),
    // rust: &format!(r#","rules":[{{"action":"allow","os":{{"name":"{}"}}}}]"#, rule_system()),
    // rust: )
}
    // rust: let client_sha1 = digest(&old.join("jars/client.jar"), "sha1").unwrap();
    // rust: let server_sha1 = digest(&old.join("jars/server.jar"), "sha1").unwrap();
    // rust: let libraries = [
    // rust: library(
    // rust: "org.lib:lib:1",
    // rust: "org/lib/lib/1/lib-1.jar",
    // rust: &sha1(b"lib"),
    // rust: "",
    // rust: ),
    // rust: library(
    // rust: "com.mojang:jtracy:1:natives-test",
    // rust: "com/mojang/jtracy/1/jtracy-1-natives-test.jar",
    // rust: &sha1(b"jtracy natives"),
    // rust: "",
    // rust: ),
    // rust: netty("aarch_64"),
    // rust: netty("x86_64"),
    // rust: ];
    // rust: put(
    // rust: "versions/9.9/9.9.json",
    // rust: format!(
    // rust: r#"{{"id":"9.9","javaVersion":{{"majorVersion":25}},"downloads":{{"client":{{"sha1":"{client_sha1}"}},"server":{{"sha1":"{server_sha1}"}}}},"libraries":[{}]}}"#,
    // rust: libraries.join(",")
    // rust: )
    // rust: .as_bytes(),
    // rust: );
    // rust: let manifest_sha1 = digest(&prism.join("versions/9.9/9.9.json"), "sha1").unwrap();
    // rust: fs::write(
    // rust: fixture.target.join("research-lock.json"),
    // rust: format!(
    // rust: r#"{{"minecraft":{{"version":"9.9","java_major":25,"manifest_sha1":"{manifest_sha1}","client_sha1":"{client_sha1}","server_sha1":"{server_sha1}"}}}}"#
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: let lock = Lock::read(&fixture.target).unwrap();
    // rust: let server = old.join("jars/server.jar");
    // rust: let prepare = || {
    // rust: import(
    // rust: &fixture.target,
    // rust: &lock,
    // rust: Some(&prism),
    // rust: &Inputs::default(),
    // rust: Some(&server),
    // rust: &|_| {},
    // rust: )
}
    // rust: let imported = || {
    // rust: let manifest = verify(&lock).unwrap().manifest;
    // rust: client_libraries(&lock, &manifest).unwrap().len()
}

    // rust: prepare().unwrap();
    // rust: assert_eq!(imported(), 2);
    // rust: let prepared = read_json(&lock.directory.join("prepared.json")).unwrap();
    // rust: let listed = prepared.get("libraries").and_then(|l| l.get("client"));
    // rust: assert_eq!(
    // rust: listed.and_then(Value::as_array).map(<[Value]>::len),
    // rust: Some(2)
    // rust: );
    // rust: assert!(reuse_imported(&fixture.target, &|_| {}).unwrap());

        // The launcher's copy is used, and checked, when it has one.
    // rust: let manifest = read_json(&prism.join("versions/9.9/9.9.json")).unwrap();
    // rust: let (_, transport) = client_library_artifacts(&manifest)
    // rust: .unwrap()
    // rust: .into_iter()
    // rust: .find(|(name, _)| runs_without(name))
    // rust: .unwrap();
    // rust: let path = transport.get("path").and_then(Value::as_str).unwrap();
    // rust: put(&format!("libraries/{path}"), b"not kqueue");
    // rust: assert!(prepare().unwrap_err().contains("is not the pinned file"));
    // rust: put(&format!("libraries/{path}"), b"kqueue");
    // rust: prepare().unwrap();
    // rust: assert_eq!(imported(), 3);
        // Other libraries stay required.
    // rust: fs::remove_dir_all(lock.directory.join("libraries/client/org")).unwrap();
    // rust: fs::remove_file(prism.join("libraries/org/lib/lib/1/lib-1.jar")).unwrap();
    // rust: assert!(prepare().unwrap_err().starts_with("Missing "));
}

    // ATLauncher keeps Mojang's version JSON in `configs/json/minecraft` and the client jar as
    // a library; its folder, or one of its instances, prepares like the official launcher's,
    // with the same pins.
an_atlauncher_install_prepares :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let old = fixture.imported(&fixture.source);
    // rust: let atlauncher = fixture.directory.join("ATLauncher");
    // rust: let put = |path: &str, data: &[u8]| {
    // rust: let path = atlauncher.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, data).unwrap();
}
    // rust: let client = fs::read(old.join("jars/client.jar")).unwrap();
    // rust: put("libraries/net/minecraft/client/9.9/client-9.9.jar", &client);
    // rust: put("libraries/client.jar", b"client library");
    // rust: put("instances/Minecraft99/instance.json", b"{}");
        // A version JSON left without its jar does not hide the launcher's complete copy.
    // rust: put("instances/Minecraft99/versions/9.9/9.9.json", b"{}");
    // rust: let manifest = fs::read_to_string(old.join("manifest.json")).unwrap();
    // rust: let manifest = manifest.replacen('{', r#"{"javaVersion":{"majorVersion":25},"#, 1);
    // rust: put("configs/json/minecraft/9.9.json", manifest.as_bytes());
    // rust: let pinned = digest(&atlauncher.join("configs/json/minecraft/9.9.json"), "sha1").unwrap();
    // rust: let lock_path = fixture.target.join("research-lock.json");
    // rust: let text = fs::read_to_string(&lock_path).unwrap();
    // rust: let old_sha1 = digest(&old.join("manifest.json"), "sha1").unwrap();
    // rust: fs::write(&lock_path, text.replace(&old_sha1, &pinned)).unwrap();
    // rust: let lock = Lock::read(&fixture.target).unwrap();
    // rust: let server = old.join("jars/server.jar");
    // rust: let prepare = |dir: &Path| {
    // rust: let _ = fs::remove_dir_all(&lock.directory);
    // rust: import(
    // rust: &fixture.target,
    // rust: &lock,
    // rust: Some(dir),
    // rust: &Inputs::default(),
    // rust: Some(&server),
    // rust: &|_| {},
    // rust: )
}

    // rust: for chosen in [atlauncher.clone(), atlauncher.join("instances/Minecraft99")] {
    // rust: prepare(&chosen).unwrap();
    // rust: let artifacts = verify(&lock).unwrap();
    // rust: assert_eq!(fs::read(&artifacts.jars["client"]).unwrap(), client);
    // rust: assert_eq!(
    // rust: client_libraries(&lock, &artifacts.manifest).unwrap().len(),
    // rust: 1
    // rust: );
}
    // rust: let files = game_files(Some(&atlauncher), "9.9");
    // rust: assert_eq!(files.runtimes, atlauncher.join("runtimes/minecraft"));

        // The pins gate it as they gate the official layout.
    // rust: put(
    // rust: "libraries/net/minecraft/client/9.9/client-9.9.jar",
    // rust: b"other",
    // rust: );
    // rust: assert!(prepare(&atlauncher)
    // rust: .unwrap_err()
    // rust: .contains("is not the pinned file"));
    // rust: put("libraries/net/minecraft/client/9.9/client-9.9.jar", &client);
    // rust: put(
    // rust: "configs/json/minecraft/9.9.json",
    // rust: manifest.replace(',', ", ").as_bytes(),
    // rust: );
    // rust: assert!(prepare(&atlauncher)
    // rust: .unwrap_err()
    // rust: .contains("may have rewritten it"));
}

    // A launcher with a layout of its own names each file (`--version-json`, `--client-jar`,
    // `--libraries-dir`): they prepare with the same pins, from no Minecraft folder at all.
named_inputs_prepare_without_a_minecraft_folder :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let old = fixture.imported(&fixture.source);
    // rust: let own = fixture.directory.join("OwnLauncher");
    // rust: let put = |path: &str, data: &[u8]| {
    // rust: let path = own.join(path);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, data).unwrap();
}
    // rust: let client = fs::read(old.join("jars/client.jar")).unwrap();
    // rust: put("instance/minecraft.jar", &client);
    // rust: put("shared/libs/client.jar", b"client library");
    // rust: let manifest = fs::read_to_string(old.join("manifest.json")).unwrap();
    // rust: let manifest = manifest.replacen('{', r#"{"javaVersion":{"majorVersion":25},"#, 1);
    // rust: put("meta/9.9.json", manifest.as_bytes());
    // rust: let pinned = digest(&own.join("meta/9.9.json"), "sha1").unwrap();
    // rust: let lock_path = fixture.target.join("research-lock.json");
    // rust: let text = fs::read_to_string(&lock_path).unwrap();
    // rust: let old_sha1 = digest(&old.join("manifest.json"), "sha1").unwrap();
    // rust: fs::write(&lock_path, text.replace(&old_sha1, &pinned)).unwrap();
    // rust: let inputs = Inputs {
    // rust: version_json: Some(own.join("meta/9.9.json")),
    // rust: client_jar: Some(own.join("instance/minecraft.jar")),
    // rust: libraries_dir: Some(own.join("shared/libs")),
    // rust: assets_dir: None,
}
    // rust: let lock = Lock::read(&fixture.target).unwrap();
    // rust: let server = old.join("jars/server.jar");
    // rust: let empty = fixture.directory.join("no-minecraft");
    // rust: fs::create_dir_all(&empty).unwrap();
    // rust: let prepare = |inputs: &Inputs| {
    // rust: let _ = fs::remove_dir_all(&lock.directory);
    // rust: import(
    // rust: &fixture.target,
    // rust: &lock,
    // rust: Some(&empty),
    // rust: inputs,
    // rust: Some(&server),
    // rust: &|_| {},
    // rust: )
}

    // rust: prepare(&inputs).unwrap();
    // rust: let artifacts = verify(&lock).unwrap();
    // rust: assert_eq!(fs::read(&artifacts.jars["client"]).unwrap(), client);
    // rust: assert_eq!(
    // rust: client_libraries(&lock, &artifacts.manifest).unwrap().len(),
    // rust: 1
    // rust: );
        // Without them the empty folder has nothing; a wrong jar fails its pin.
    // rust: assert!(prepare(&Inputs::default())
    // rust: .unwrap_err()
    // rust: .starts_with("Missing "));
    // rust: put("instance/minecraft.jar", b"other");
    // rust: assert!(prepare(&inputs)
    // rust: .unwrap_err()
    // rust: .contains("is not the pinned file"));
}

    // With no launcher's files in the chosen folder, the error names where Horizon looked and
    // the launchers it reads.
the_error_names_the_folders_looked_in :: proc() {
}
    // rust: let fixture = Imports::new();
    // rust: let empty = fixture.directory.join("instances/empty");
    // rust: fs::create_dir_all(&empty).unwrap();
    // rust: let lock = Lock::read(&fixture.target).unwrap();
    // rust: let error = import(
    // rust: &fixture.target,
    // rust: &lock,
    // rust: Some(&empty),
    // rust: &Inputs::default(),
    // rust: None,
    // rust: &|_| {},
    // rust: )
    // rust: .unwrap_err();
    // rust: assert!(error.starts_with(&format!(
    // rust: "Missing {}",
    // rust: empty.join("versions/9.9/9.9.json").display()
    // rust: )));
    // rust: assert!(error.contains("Horizon looked for 9.9 in:"), "{error}");
    // rust: assert!(error.contains(&format!("\n  {} (the folder chosen)", empty.display())));
    // rust: assert!(error.contains(&format!(
    // rust: "\n  {} (the launcher above it)",
    // rust: fixture.directory.display()
    // rust: )));
    // rust: assert!(error.contains("ATLauncher"));
}

every_launcher_horizon_reads_is_looked_in :: proc() {
}
    // rust: let launchers: Vec<_> = launcher_folders()
    // rust: .into_iter()
    // rust: .map(|(name, _)| name)
    // rust: .collect();
    // rust: for name in ["the official launcher", "ATLauncher", "the CurseForge app"] {
    // rust: assert!(launchers.contains(&name), "{name}");
}
}

runs_without_only_netty_native_transports :: proc() {
}
    // rust: assert!(runs_without(
    // rust: "io.netty:netty-transport-native-kqueue:4.2.16.Final:osx-aarch_64"
    // rust: ));
    // rust: assert!(runs_without(
    // rust: "io.netty:netty-transport-native-epoll:4.2.16.Final:linux-x86_64"
    // rust: ));
    // rust: for required in [
    // rust: "io.netty:netty-transport-native-unix-common:4.2.16.Final",
    // rust: "io.netty:netty-transport-classes-kqueue:4.2.16.Final",
    // rust: "org.lwjgl:lwjgl:3.3.3:natives-macos-arm64",
    // rust: "com.mojang:jtracy:1.14.38:natives-windows",
    // rust: ] {
    // rust: assert!(!runs_without(required), "{required}");
}
}

natives_follow_the_architecture :: proc() {
}
    // rust: let names = ["a:b:1:natives-macos", "a:b:1:natives-macos-arm64"];
    // rust: let lib = |name: &str| pyjson::loads(&format!("{{\"name\":\"{name}\"}}")).unwrap();
    // rust: let arm = rule_architectures().contains(&"arm64");
    // rust: assert_eq!(
    // rust: native_library_matches(&lib("a:b:1:natives-macos-arm64"), &names),
    // rust: arm
    // rust: );
    // rust: assert_eq!(
    // rust: native_library_matches(&lib("x:y:1:linux-x86_64"), &names),
    // rust: !arm
    // rust: );
    // rust: assert_eq!(
    // rust: native_library_matches(&lib("x:y:1:linux-aarch_64"), &names),
    // rust: arm
    // rust: );
    // rust: assert_eq!(
    // rust: native_library_matches(&lib("a:b:1:natives-macos"), &names),
    // rust: !arm
    // rust: );
    // rust: assert!(native_library_matches(&lib("a:b:1"), &names));
}

unsafe_paths_are_refused :: proc() {
}
    // rust: assert!(safe_relative("a/../b").is_none());
    // rust: assert!(safe_relative("/a").is_none());
    // rust: assert!(safe_relative("a\\b").is_none());
    // rust: assert_eq!(
    // rust: safe_relative("a/b.jar").unwrap(),
    // rust: Path::new("a").join("b.jar")
    // rust: );
}
}
