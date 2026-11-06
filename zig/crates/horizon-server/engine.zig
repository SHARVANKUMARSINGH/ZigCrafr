//! Transpiled from Horizon Rust crate
//! Module: horizon-server_engine
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The engine: the game itself, run headless (`horizon-client --dedicated`, crates/horizon-client
//! game/dedicated.rs). It reads the vanilla files the supervisor writes, takes console commands on stdin and
//! logs on stdout.

// use crate::config::Config;
// use std::{
    // rust: io::{BufRead, BufReader, Write},
    // rust: net::{Ipv4Addr, TcpStream},
    // rust: path::{Path, PathBuf},
    // rust: process::{Child, Command, Stdio},
    // rust: time::Duration,
}

/// The game's program names, most specific first: the server build (the game without sound or
/// controllers, so it needs neither ALSA nor udev on Linux; `horizon-server-linux-x86_64.tar.gz` holds it),
/// else the full game.
pub const PROGRAMS: [[]const u8; 2] = ["horizon-engine", "horizon-client"];

pub fn exe(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{name}{}", std::env::consts::EXE_SUFFIX)
}

/// The game program: `engine.path`, else one installed beside `horizon-server` (in the release in use when
/// it was installed by the installers), else one on the PATH.
pub fn program(config: *Config, dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: program_in(config, dir, crate::update::Install::find().as_ref())
}

/// [`program`], for the install `install`.
    // rust: pub fn program_in(
    // rust: config: &Config,
    // rust: dir: &Path,
    // rust: install: Option<&crate::update::Install>,
    // rust: ) -> Result<PathBuf, String> {
    // rust: if !config.engine.path.is_empty() {
    // rust: let path = dir.join(&config.engine.path);
    // rust: return path
    // rust: .is_file()
    // rust: .then_some(path)
    // rust: .ok_or_else(|| format!("engine.path {} is not a file", config.engine.path));
}
    // Installed: the release `current` points at now, so a switch applies at the next start.
    // rust: let beside = install.map(crate::update::Install::programs).or_else(|| {
    // rust: std::env::current_exe()
    // rust: .ok()
    // rust: .and_then(|e| e.parent().map(Path::to_path_buf))
    // rust: });
    // rust: let path_dirs = std::env::var_os("PATH")
    // rust: .map(|p| std::env::split_paths(&p).collect::<Vec<_>>())
    // rust: .unwrap_or_default();
    // rust: PROGRAMS
    // rust: .iter()
    // rust: .flat_map(|name| {
    // rust: beside
    // rust: .iter()
    // rust: .chain(&path_dirs)
    // rust: .map(move |d| d.join(exe(name)))
    // rust: })
    // rust: .find(|p| p.is_file())
    // rust: .ok_or_else(|| {
    // rust: "the game program (horizon-client) is neither beside horizon-server nor on the PATH: \
    // rust: install it there, or set engine.path in server.toml"
    // rust: .into()
    // rust: })
}

/// Checks that the game program starts at all: `--help` loads no game files, so it fails only when the
/// system can't load the program, as on a Linux without the ALSA and udev libraries the full game links
/// (the server build doesn't). The reason, with what to install.
pub fn check_starts(program: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut command = crate::process::command(program);
    // rust: let output = command
    // rust: .arg("--help")
    // rust: .stdin(Stdio::null())
    // rust: .stdout(Stdio::null())
    // rust: .stderr(Stdio::piped())
    // rust: .output()
    // rust: .map_err(|e| format!("the game ({}) can't start: {e}", program.display()))?;
    // rust: if output.status.success() {
    // rust: return Ok(());
}
    // rust: let stderr = String::from_utf8_lossy(&output.stderr);
    // rust: Err(start_failure(program, output.status.code(), &stderr))
}

/// What to tell the owner when the game program exits at once.
pub fn start_failure(program: *Path, code: ?i32, stderr: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let reason = stderr
    // rust: .lines()
    // rust: .find(|l| !l.trim().is_empty())
    // rust: .unwrap_or("")
    // rust: .trim();
    // rust: let mut text = format!(
    // rust: "the game ({}) can't start{}{}",
    // rust: program.display(),
    // rust: code.map_or(String::new(), |c| format!(" (exit status {c})")),
    // rust: if reason.is_empty() {
    // rust: String::new()
    // rust: } else {
    // rust: format!(": {reason}")
}
    // rust: );
    // rust: if reason.contains("error while loading shared libraries")
    // rust: && (reason.contains("libasound") || reason.contains("libudev"))
    // rust: {
    // rust: text.push_str(
    // rust: "\nThe full game needs ALSA's and udev's libraries (libasound.so.2, libudev.so.1). Install the \
    // rust: server build, which needs neither (packaging/server/install.sh picks it on Linux), or the \
    // rust: libraries:\n  Debian, Ubuntu: sudo apt install libasound2 libudev1   (Ubuntu 24.04 and later: \
    // rust: libasound2t64)\n  Fedora, RHEL: sudo dnf install alsa-lib systemd-libs\n  Arch: sudo pacman -S \
    // rust: alsa-lib systemd-libs\n  NixOS: enable programs.nix-ld with alsa-lib and udev in its libraries",
    // rust: );
}
    // rust: text
}

/// The Minecraft version this server is pinned to; prepared game files must be stamped with it.
pub const GAME_VERSION: []const u8 = horizon_core::version::VERSION_ID;

/// Where the prepared game files may be, in the order they are tried.
pub fn resource_candidates(config: *Config, dir: *Path, program: ?*Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !config.engine.resources.is_empty() {
    // rust: return vec![dir.join(&config.engine.resources)];
}
    // rust: let version = GAME_VERSION;
    // rust: let mut out = vec![dir.join("resources")];
    // A release folder or a checkout: .local/horizon-client/<version> beside the program or above it.
    // rust: if let Some(program) = program {
    // rust: for ancestor in program.ancestors().skip(1).take(4) {
    // rust: out.push(ancestor.join(".local/horizon-client").join(version));
}
}
    // rust: out
}

/// The prepared game files: a folder holding the manifest every `horizon-prepare` run writes
/// (`asset-index.json` comes only with the optional sounds, which a server doesn't need).
pub fn resources(config: *Config, dir: *Path, program: ?*Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let candidates = resource_candidates(config, dir, program);
    // rust: candidates
    // rust: .iter()
    // rust: .find(|d| d.join("horizon-resources.json").is_file())
    // rust: .cloned()
    // rust: .ok_or_else(|| {
    // rust: let tried: Vec<String> = candidates
    // rust: .iter()
    // rust: .map(|d| format!("  {}", d.display()))
    // rust: .collect();
    // rust: format!(
    // rust: "no prepared game files. Horizon reads them from your own copy of Minecraft 26.3:\n\
    // rust: prepare them with `horizon-prepare --prepare --server-jar PATH` (or the launcher) and copy \
    // rust: the folder to resources/ here, or set engine.resources in server.toml. Looked in:\n{}",
    // rust: tried.join("\n")
    // rust: )
    // rust: })
}

/// The files `horizon-prepare` derives from the game and the engine reads at start (docs/hosting.md: a folder
/// prepared before `registries.json` and `commands.json` were kept stops with "registries.json not found").
    // rust: const PREPARED_FILES: [&str; 4] = [
    // rust: "facts.json",
    // rust: "block-tags.json",
    // rust: "registries.json",
    // rust: "commands.json",
    // rust: ];

/// Folders of the client's own assets the engine loads fonts and textures from at start.
pub const PREPARED_DIRS: [[]const u8; 2] = ["assets/minecraft/font", "assets/minecraft/textures"];

/// Checks a prepared folder before the engine starts on it, so a half-copied or stale folder is named
/// instead of surfacing as the engine's `os error 2` at every restart. Checks what the manifest
/// (`horizon-resources.json`, written last by `horizon-prepare`) records: the derived files are there and
/// match the hashes it holds, and the asset folders the engine loads from aren't empty.
pub fn check_prepared(resources: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let manifest = std::fs::read_to_string(resources.join("horizon-resources.json"))
    // rust: .map_err(|e| format!("horizon-resources.json: {e}"))
    // rust: .and_then(|text| {
    // rust: serde_json::from_str::<serde_json::Value>(&text)
    // rust: .map_err(|e| format!("horizon-resources.json is not valid JSON ({e})"))
    // rust: });
    // rust: let mut problems = Vec::new();
    // rust: for name in PREPARED_FILES {
    // rust: if !resources.join(name).is_file() {
    // rust: problems.push(format!("{name} is missing"));
}
}
    // rust: match &manifest {
    // rust: Ok(manifest) => {
    // rust: for (name, key) in [
    // rust: ("facts.json", "facts_sha256"),
    // rust: ("block-tags.json", "block_tags_sha256"),
    // rust: ] {
    // rust: let Some(expected) = manifest.get(key).and_then(|v| v.as_str()) else {
    // rust: continue;
}
    // rust: if let Ok(actual) = sha256_file(&resources.join(name))
    // rust: && !actual.eq_ignore_ascii_case(expected)
    // rust: {
    // rust: problems.push(format!(
    // rust: "{name} is not the file the preparation wrote (checksum differs)"
    // rust: ));
}
}
}
    // rust: Err(e) => problems.push(e.clone()),
}
    // rust: for dir in PREPARED_DIRS {
    // rust: let empty = std::fs::read_dir(resources.join(dir))
    // rust: .map_or(true, |mut entries| entries.next().is_none());
    // rust: if empty {
    // rust: problems.push(format!("{dir} is missing or empty"));
}
}
    // rust: if problems.is_empty() {
    // rust: return Ok(());
}
    // rust: Err(format!(
    // rust: "the prepared game files in {} are incomplete or damaged:\n  {}\nPrepare them again with \
    // rust: `horizon-prepare --prepare --server-jar PATH` (or the launcher), or copy the whole prepared folder to \
    // rust: the server again.",
    // rust: resources.display(),
    // rust: problems.join("\n  ")
    // rust: ))
}

pub fn sha256_file(path: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
//     use sha2::{Digest, Sha256};
    // rust: let mut file = std::fs::File::open(path)?;
    // rust: let mut hash = Sha256::new();
    // rust: std::io::copy(&mut file, &mut hash)?;
    // rust: Ok(hash.finalize().iter().map(|b| format!("{b:02x}")).collect())
}

/// Starts the engine in the server folder, with its console and log piped to the supervisor and its status
/// on the control endpoint.
    // rust: pub fn spawn(
    // rust: program: &Path,
    // rust: resources: &Path,
    // rust: dir: &Path,
    // rust: low_memory: bool,
    // rust: transfers: Option<&str>,
    // rust: ) -> std::io::Result<Child> {
    // rust: command(program, resources, dir, low_memory, transfers)?.spawn()
}

/// The command `spawn` runs.
    // rust: fn command(
    // rust: program: &Path,
    // rust: resources: &Path,
    // rust: dir: &Path,
    // rust: low_memory: bool,
    // rust: transfers: Option<&str>,
    // rust: ) -> std::io::Result<Command> {
    // The game runs in the server folder, so a folder given relative to ours (`--dir srv`) would put its
    // control endpoint in `srv/srv/.horizon`, which doesn't exist.
    // rust: let dir = std::path::absolute(dir)?;
    // rust: let resources = std::path::absolute(resources)?;
    // rust: let mut command = Command::new(program);
    // rust: command
    // rust: .arg("--resources")
    // rust: .arg(resources)
    // rust: .arg("--control-socket")
    // rust: .arg(control_path(&dir));
    // `[transfer]` on: a proxy's hand-over requests on that endpoint (docs/server.md).
    // rust: if let Some(transfers) = transfers {
    // rust: command.arg("--transfers").arg(transfers);
}
    // rust: command
    // rust: .args(["--dedicated", "--nogui"])
    // rust: .current_dir(&dir)
    // rust: .env("HORIZON_NO_AUDIO", "1")
    // rust: .stdin(Stdio::piped())
    // rust: .stdout(Stdio::piped())
    // rust: .stderr(Stdio::piped());
    // The terminal's Ctrl-C reaches the supervisor alone, which then stops the game cleanly.
    // rust: std::os::unix::process::CommandExt::process_group(&mut command, 0);
    // rust: std::os::windows::process::CommandExt::creation_flags(
    // rust: &mut command,
    // rust: windows_sys::Win32::System::Threading::CREATE_NEW_PROCESS_GROUP
    // rust: | windows_sys::Win32::System::Threading::CREATE_NO_WINDOW,
    // rust: );
    // `[engine] low_memory`: mimalloc then keeps transparent huge pages off. Mostly empty huge pages cost
    // 60 MB idle and 190 MB at 20 players, and save ~1 % of tick time (docs/hosting.md).
    // rust: if low_memory {
    // rust: command.env("MIMALLOC_ALLOW_THP", "0");
}
    // rust: Ok(command)
}

/// The game's control endpoint in a server folder (`--control-socket`): TCP on 127.0.0.1 with a token, on every OS.
pub fn control_path(dir: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: dir.join(".horizon/engine.json")
}

/// A connection to the game's control endpoint: one JSON line asked, one answered.
pub const Control = struct {
    writer: TcpStream,
    reader: BufReader<TcpStream>,
};

    // rust: impl Control {
pub fn connect(dir: *Path) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = std::fs::read_to_string(control_path(dir))?;
    // rust: let bad = || std::io::Error::new(std::io::ErrorKind::InvalidData, "not a control endpoint");
    // rust: let v: serde_json::Value = serde_json::from_str(&text).map_err(|_| bad())?;
    // rust: let port = v["port"]
    // rust: .as_u64()
    // rust: .and_then(|p| u16::try_from(p).ok())
    // rust: .ok_or_else(bad)?;
    // rust: let token = v["token"].as_str().ok_or_else(bad)?;
    // rust: let writer = TcpStream::connect((Ipv4Addr::LOCALHOST, port))?;
    // rust: writer.set_read_timeout(Some(Duration::from_secs(30)))?;
    // rust: let mut control = Self {
    // rust: reader: BufReader::new(writer.try_clone()?),
    // rust: writer,
}
    // rust: let reply = control.ask(&format!("auth {token}"))?;
    // rust: if reply["ok"] != true {
    // rust: return Err(std::io::Error::new(
    // rust: std::io::ErrorKind::PermissionDenied,
    // rust: "the game refused the token",
    // rust: ));
}
    // rust: Ok(control)
}

pub fn ask(self: *Self, line: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: writeln!(self.writer, "{line}")?;
    // rust: self.writer.flush()?;
    // rust: let mut reply = String::new();
    // rust: if self.reader.read_line(&mut reply)? == 0 {
    // rust: return Err(std::io::ErrorKind::UnexpectedEof.into());
}
    // rust: serde_json::from_str(&reply)
    // rust: .map_err(|e| std::io::Error::new(std::io::ErrorKind::InvalidData, e))
}
}

    // rust: mod tests {
//     use super::*;

pub fn low_memory_turns_huge_pages_off_for_the_game() void {
}
    // rust: let thp = |low_memory| {
    // rust: let dir = std::env::temp_dir();
    // rust: let command =
    // rust: command(Path::new("horizon-client"), &dir, &dir, low_memory, None).unwrap();
    // rust: command
    // rust: .get_envs()
    // rust: .find(|(k, _)| *k == "MIMALLOC_ALLOW_THP")
    // rust: .and_then(|(_, v)| v.map(|v| v.to_owned()))
}
    // rust: assert_eq!(thp(true).as_deref(), Some(std::ffi::OsStr::new("0")));
    // rust: assert_eq!(thp(false), None);
}

pub fn transfers_reach_the_game_only_when_they_are_on() void {
}
    // rust: let args = |transfers: Option<&str>| {
    // rust: let dir = std::env::temp_dir();
    // rust: let command =
    // rust: command(Path::new("horizon-client"), &dir, &dir, false, transfers).unwrap();
    // rust: command
    // rust: .get_args()
    // rust: .map(|a| a.to_string_lossy().into_owned())
    // rust: .collect::<Vec<_>>()
}
    // rust: assert!(!args(None).iter().any(|a| a == "--transfers"));
    // rust: let on = args(Some("expect_seconds=10"));
    // rust: let at = on.iter().position(|a| a == "--transfers").unwrap();
    // rust: assert_eq!(on[at + 1], "expect_seconds=10");
        // Before `--dedicated`: what follows it is vanilla's server arguments.
    // rust: assert!(at < on.iter().position(|a| a == "--dedicated").unwrap());
}

pub fn resources_are_searched_in_order() void {
}
    // rust: let mut config = Config::default();
    // rust: let dir = Path::new("/srv/mc");
    // rust: let program = Path::new("/opt/horizon/target/release/horizon-client");
    // rust: let found = resource_candidates(&config, dir, Some(program));
    // rust: assert_eq!(found[0], Path::new("/srv/mc/resources"));
    // rust: assert!(found.contains(&PathBuf::from("/opt/horizon/.local/horizon-client/26.3")));
    // rust: config.engine.resources = "/data/res".into();
    // rust: assert_eq!(
    // rust: resource_candidates(&config, dir, Some(program)),
    // rust: [PathBuf::from("/data/res")]
    // rust: );
}

pub fn resources_prepared_without_sounds_are_found() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-server-res-{}", std::process::id()));
    // rust: let prepared = root.join(".local/horizon-client/26.3");
    // rust: std::fs::create_dir_all(&prepared).unwrap();
    // rust: let program = root.join("horizon-client");
    // rust: let config = Config::default();
    // rust: let server = root.join("server");
    // rust: assert!(resources(&config, &server, Some(&program)).is_err());
        // What `horizon-prepare` writes on every run; no asset index without `horizon-prepare sounds`.
    // rust: std::fs::write(prepared.join("horizon-resources.json"), "{}").unwrap();
    // rust: assert_eq!(resources(&config, &server, Some(&program)), Ok(prepared));
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

    /// A folder as `horizon-prepare` leaves it, as far as `check_prepared` looks.
pub fn prepared_folder(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-server-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: for dir in PREPARED_DIRS {
    // rust: std::fs::create_dir_all(root.join(dir)).unwrap();
    // rust: std::fs::write(root.join(dir).join("file"), "x").unwrap();
}
    // rust: for file in PREPARED_FILES {
    // rust: std::fs::write(root.join(file), file).unwrap();
}
    // rust: let manifest = serde_json::json!({
    // rust: "facts_sha256": sha256_file(&root.join("facts.json")).unwrap(),
    // rust: "block_tags_sha256": sha256_file(&root.join("block-tags.json")).unwrap(),
    // rust: });
    // rust: std::fs::write(root.join("horizon-resources.json"), manifest.to_string()).unwrap();
    // rust: root
}

pub fn a_complete_prepared_folder_passes() void {
}
    // rust: let root = prepared_folder("complete");
    // rust: assert_eq!(check_prepared(&root), Ok(()));
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn missing_files_and_folders_are_named() void {
}
    // rust: let root = prepared_folder("missing");
    // rust: std::fs::remove_file(root.join("registries.json")).unwrap();
    // rust: std::fs::remove_dir_all(root.join("assets/minecraft/font")).unwrap();
    // rust: let text = check_prepared(&root).unwrap_err();
    // rust: assert!(text.contains("registries.json is missing"), "{text}");
    // rust: assert!(
    // rust: text.contains("assets/minecraft/font is missing or empty"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(!text.contains("commands.json"), "{text}");
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn an_empty_asset_folder_counts_as_missing() void {
}
    // rust: let root = prepared_folder("empty");
    // rust: std::fs::remove_file(root.join("assets/minecraft/textures/file")).unwrap();
    // rust: let text = check_prepared(&root).unwrap_err();
    // rust: assert!(
    // rust: text.contains("assets/minecraft/textures is missing or empty"),
    // rust: "{text}"
    // rust: );
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn a_changed_derived_file_is_reported() void {
}
    // rust: let root = prepared_folder("changed");
    // rust: std::fs::write(root.join("facts.json"), "damaged").unwrap();
    // rust: let text = check_prepared(&root).unwrap_err();
    // rust: assert!(
    // rust: text.contains("facts.json is not the file the preparation wrote"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(!text.contains("block-tags.json"), "{text}");
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn a_broken_manifest_is_reported() void {
}
    // rust: let root = prepared_folder("manifest");
    // rust: std::fs::write(root.join("horizon-resources.json"), "{").unwrap();
    // rust: let text = check_prepared(&root).unwrap_err();
    // rust: assert!(
    // rust: text.contains("horizon-resources.json is not valid JSON"),
    // rust: "{text}"
    // rust: );
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn a_missing_library_says_what_to_install() void {
}
    // rust: let program = Path::new("/opt/horizon/horizon-client");
    // rust: let text = start_failure(
    // rust: program,
    // rust: Some(127),
    // rust: "/opt/horizon/horizon-client: error while loading shared libraries: libasound.so.2: cannot open \
    // rust: shared object file: No such file or directory\n",
    // rust: );
    // rust: assert!(text.starts_with(
    // rust: "the game (/opt/horizon/horizon-client) can't start (exit status 127): /opt/horizon/horizon-client: \
    // rust: error while loading shared libraries: libasound.so.2"
    // rust: ));
    // rust: assert!(text.contains("sudo apt install libasound2 libudev1"));
        // Another library: no ALSA advice (the server build, horizon-engine, links neither).
    // rust: let engine = start_failure(
    // rust: Path::new("/opt/horizon/horizon-engine"),
    // rust: Some(127),
    // rust: "/opt/horizon/horizon-engine: error while loading shared libraries: libgcc_s.so.1: cannot open \
    // rust: shared object file: No such file or directory\n",
    // rust: );
    // rust: assert!(!engine.contains("libasound"), "{engine}");
    // rust: let other = start_failure(program, Some(1), "something else\n");
    // rust: assert_eq!(
    // rust: other,
    // rust: "the game (/opt/horizon/horizon-client) can't start (exit status 1): something else"
    // rust: );
}

pub fn a_relative_folder_reaches_the_game_whole() void {
}
//         use std::os::unix::fs::PermissionsExt;
        // Relative to this process's folder (the crate's, under cargo test), as `--dir srv` gives it.
    // rust: let root = PathBuf::from(format!("reldir-test-{}", std::process::id()));
    // rust: let server = root.join("srv");
    // rust: std::fs::create_dir_all(server.join(".horizon")).unwrap();
    // rust: std::fs::create_dir_all(root.join("res")).unwrap();
        // A game that checks, from its own folder, the folders it was given.
    // rust: let game = root.join("game");
    // rust: std::fs::write(
    // rust: &game,
    // rust: "#!/bin/sh\nwhile [ $# -gt 0 ]; do case \"$1\" in --resources) r=$2; shift;; \
    // rust: --control-socket) c=$2; shift;; esac; shift; done\n\
    // rust: [ -d \"$r\" ] && [ -d \"$(dirname \"$c\")\" ] && [ -f server.toml ]\n",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::set_permissions(&game, std::fs::Permissions::from_mode(0o755)).unwrap();
    // rust: std::fs::write(server.join("server.toml"), "").unwrap();
        // ETXTBSY: see `check_written`.
    // rust: let mut tries = 0;
    // rust: let status = loop {
    // rust: match spawn(
    // rust: &std::path::absolute(&game).unwrap(),
    // rust: &root.join("res"),
    // rust: &server,
    // rust: false,
    // rust: None,
    // rust: ) {
    // rust: Err(e) if e.raw_os_error() == Some(26) && tries < 50 => {
    // rust: tries += 1;
    // rust: std::thread::sleep(std::time::Duration::from_millis(20));
}
    // rust: child => break child.unwrap().wait(),
}
}
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let status = status.unwrap();
    // rust: assert!(status.success(), "{status}");
}

    /// `check_starts` on a script this test process just wrote. Another test's spawn can fork while the
    /// script's write handle is still open, and its child keeps that handle until it execs: running the
    /// script meanwhile fails with ETXTBSY (Linux), so that one error is retried.
pub fn check_written(program: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for _ in 0..50 {
    // rust: match check_starts(program) {
    // rust: Err(e) if e.contains("Text file busy") => {
    // rust: std::thread::sleep(std::time::Duration::from_millis(20))
}
    // rust: other => return other,
}
}
    // rust: check_starts(program)
}

pub fn the_check_runs_the_program() void {
}
//         use std::os::unix::fs::PermissionsExt;
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-server-check-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: let script = |name: &str, body: &str| {
    // rust: let path = root.join(name);
    // rust: std::fs::write(&path, format!("#!/bin/sh\n{body}\n")).unwrap();
    // rust: std::fs::set_permissions(&path, std::fs::Permissions::from_mode(0o755)).unwrap();
    // rust: path
}
    // rust: assert_eq!(check_written(&script("starts", "exit 0")), Ok(()));
    // rust: let fails = script("fails", "echo 'no luck' >&2; exit 3");
    // rust: assert_eq!(
    // rust: check_written(&fails),
    // rust: Err(format!(
    // rust: "the game ({}) can't start (exit status 3): no luck",
    // rust: fails.display()
    // rust: ))
    // rust: );
    // rust: std::fs::remove_dir_all(&root).unwrap();
}
}
