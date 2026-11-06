//! Transpiled from Horizon Rust crate
//! Module: horizon-client_launch_api
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The game's side of the Launch API (docs/api/launch.md): the options another launcher may pass,
//! `--launch-api`'s reply, the exit codes, and docs/api/launch-reference.md, generated from them.
//! Update it with: `HORIZON_WRITE_DOCS=1 cargo test -p horizon-client --lib launch_api`.

/// The Launch API's version (docs/api/stability.md): an addition makes the next patch.
pub const VERSION: []const u8 = "0.1.0";

/// One option of the contract: its name, its value's placeholder (none for a flag), what it does.
pub const LaunchOption = struct {
    name: *'static str,
    value: ?*'static str,
    /// For the reference only.
    what: *'static str,
};

    // rust: const fn option(
    // rust: name: &'static str,
    // rust: value: Option<&'static str>,
    // rust: what: &'static str,
    // rust: ) -> LaunchOption {
    // rust: LaunchOption { name, value, what }
}

/// What a launcher may pass. The game takes more (`--help` lists them), but only these are
/// promised: they keep their meaning within a line of this API.
    // rust: pub const OPTIONS: &[LaunchOption] = &[
    // rust: option(
    // rust: "--resources",
    // rust: Some("DIR"),
    // rust: "The prepared resources (horizon-prepare's output). Default: `resources` beside the executable, else `.local/horizon-client/26.3`.",
    // rust: ),
    // rust: option(
    // rust: "--game-dir",
    // rust: Some("DIR"),
    // rust: "The game folder: `saves/`, `options.txt`, `resourcepacks/`, `horizon-mods/`, `screenshots/`. Created when missing. Default: the working directory. `--gameDir` is the same.",
    // rust: ),
    // rust: option(
    // rust: "--home",
    // rust: Some("DIR"),
    // rust: "Logs (`logs/latest.log`) and crash reports (`crash-reports/`). Default: `HORIZON_HOME`, else `horizon` in the platform data folder.",
    // rust: ),
    // rust: option(
    // rust: "--player-dir",
    // rust: Some("DIR"),
    // rust: "One player's own files, for several games playing in one game folder at the same time: `options.txt` and the settings beside it, `logs/`, `crash-reports/`, `horizon-player.txt`, `servers.dat`, `hotbar.nbt`, `screenshots/`. Saves, packs, mods and their config, the chat's command history and Play with Friends' relay settings stay in the game folder. A relative path is taken from the folder the game starts in. Created when missing. Default: the game folder, and `--home` for logs. Crash telemetry still follows `--home`'s consent, and `horizon-ctl logs` and the launcher read `--home`'s logs.",
    // rust: ),
    // rust: option(
    // rust: "--width",
    // rust: Some("N"),
    // rust: "The window's starting width (default 1280).",
    // rust: ),
    // rust: option(
    // rust: "--height",
    // rust: Some("N"),
    // rust: "The window's starting height (default 720).",
    // rust: ),
    // rust: option(
    // rust: "--fullscreen",
    // rust: None,
    // rust: "Opens the window fullscreen, whatever `options.txt` says; `options.txt` is not changed.",
    // rust: ),
    // rust: option(
    // rust: "--session-file",
    // rust: Some("PATH"),
    // rust: "The signed-in account, as the session JSON below. Read once, then deleted.",
    // rust: ),
    // rust: option(
    // rust: "--session-stdin",
    // rust: None,
    // rust: "The same JSON on standard input, so it never touches the disk.",
    // rust: ),
    // rust: option(
    // rust: "--quickPlaySingleplayer",
    // rust: Some("WORLD"),
    // rust: "Opens this world of `saves/` at start, only if it exists (else the title screen). WORLD is one folder name: a path is refused.",
    // rust: ),
    // rust: option(
    // rust: "--quickPlayMultiplayer",
    // rust: Some("HOST[:PORT]"),
    // rust: "Joins this server at start.",
    // rust: ),
    // rust: option(
    // rust: "--launch-api",
    // rust: None,
    // rust: "Prints the reply below and exits 0, before anything else runs.",
    // rust: ),
    // rust: ];

/// How the game ends, for the launcher that started it.
    // rust: pub mod exit_code {
    /// The player quit, or `--help` and `--launch-api` printed.
pub const OK: i32 = 0;
    /// The game stopped on an error; a crash report was saved.
pub const ERROR: i32 = 1;
    /// The command line was refused (an unknown option, a missing or bad value); no crash report.
pub const USAGE: i32 = 2;
    /// A panic; a crash report was saved.
pub const PANIC: i32 = 101;
}

    // rust: const EXIT_CODES: &[(i32, &str)] = &[
    // rust: (
    // rust: exit_code::OK,
    // rust: "The player quit, or `--help` or `--launch-api` printed.",
    // rust: ),
    // rust: (
    // rust: exit_code::ERROR,
    // rust: "The game stopped on an error. A crash report was saved.",
    // rust: ),
    // rust: (
    // rust: exit_code::USAGE,
    // rust: "The command line was refused: an unknown option, a missing or bad value. No crash report.",
    // rust: ),
    // rust: (
    // rust: exit_code::PANIC,
    // rust: "The game panicked. A crash report was saved.",
    // rust: ),
    // rust: ];

/// A command line the game refuses: exit code 2, no crash report.
pub const UsageError = struct {};

    // rust: impl std::fmt::Display for UsageError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(&self.0)
}
}

    // rust: impl std::error::Error for UsageError {}

/// `--launch-api`'s reply for a build of this `horizon` version.
pub fn reply(horizon: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let options: Vec<_> = OPTIONS
    // rust: .iter()
    // rust: .map(|o| serde_json::json!({ "name": o.name, "value": o.value }))
    // rust: .collect();
    // rust: serde_json::to_string_pretty(&serde_json::json!({
    // rust: "launch_api": VERSION,
    // rust: "horizon": horizon,
    // rust: "minecraft": horizon_core::VANILLA_VERSION,
    // rust: "options": options,
    // rust: "exit_codes": EXIT_CODES.iter().map(|(code, _)| code).collect::<Vec<_>>(),
    // rust: "crash_report_line": horizon_client::crash::SAVED_LINE,
    // rust: }))
    // rust: .expect("a JSON value")
}

/// docs/api/launch-reference.md.
pub fn markdown() S {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::fmt::Write;
    // rust: let mut out = String::new();
    // rust: let w = &mut out;
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "<!-- Generated from crates/horizon-client/src/game/launch_api.rs; a test fails when this file is out of date. Update it with: HORIZON_WRITE_DOCS=1 cargo test -p horizon-client --lib launch_api -->"
    // rust: );
    // rust: let _ = writeln!(w, "# Launch API reference\n");
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "What `horizon-client` promises a launcher that starts it, Launch API {VERSION}. The guide: \
    // rust: [launch.md](launch.md); stability and versions: [stability.md](stability.md).\n"
    // rust: );
    // rust: let _ = writeln!(w, "## Options\n");
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "Any other option is refused with exit code 2, so ask `--launch-api` before passing one \
    // rust: a build may not know.\n"
    // rust: );
    // rust: let _ = writeln!(w, "| Option | What it does |\n| --- | --- |");
    // rust: for o in OPTIONS {
    // rust: let usage = match o.value {
    // rust: Some(value) => format!("`{} {value}`", o.name),
    // rust: None => format!("`{}`", o.name),
}
    // rust: let _ = writeln!(w, "| {usage} | {} |", o.what);
}
    // rust: let _ = writeln!(w, "\n## `--launch-api`\n");
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "Prints one JSON object on stdout and exits 0. `horizon` is the build's version; readers \
    // rust: ignore fields they don't know.\n"
    // rust: );
    // rust: let _ = writeln!(w, "```json\n{}\n```\n", reply("<version>"));
    // rust: let _ = writeln!(w, "## Exit codes\n\n| Code | Meaning |\n| --- | --- |");
    // rust: for (code, what) in EXIT_CODES {
    // rust: let _ = writeln!(w, "| {code} | {what} |");
}
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "\nWhen a crash report is saved, the last line on stderr is `{}` followed by the \
    // rust: report's path.",
    // rust: horizon_client::crash::SAVED_LINE.trim_end()
    // rust: );
    // rust: out
}

    // rust: mod tests {
//     use super::*;

pub fn parse(args: *[[]const u8]) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::super::Options::parse(args.iter().map(|a| a.to_string()))
}

    /// Every promised option is one the game accepts.
pub fn launch_api_options_are_accepted() void {
}
    // rust: for o in OPTIONS {
    // rust: let args: Vec<&str> = std::iter::once(o.name)
    // rust: .chain(o.value.map(|v| if v == "N" { "100" } else { "x" }))
    // rust: .collect();
    // rust: assert!(parse(&args).is_ok(), "{} is refused", o.name);
}
}

pub fn launch_api_flags_are_read() void {
}
    // rust: let o = parse(&["--fullscreen", "--game-dir", "g", "--session-stdin"])
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert!(o.fullscreen && o.session_stdin);
    // rust: assert_eq!(o.game_dir.as_deref(), Some(std::path::Path::new("g")));
    // rust: assert!(parse(&["--launch-api"]).unwrap().is_none());
    // rust: assert!(parse(&["--no-such-option"]).is_err());
}

    /// A launcher shows the error to the player, so it names the option.
pub fn launch_api_bad_value_names_its_option() void {
}
    // rust: let error = |args: &[&str]| parse(args).err().unwrap().to_string();
    // rust: assert_eq!(
    // rust: error(&["--width", "wide"]),
    // rust: "--width: invalid digit found in string"
    // rust: );
    // rust: assert_eq!(error(&["--bogus", "x"]), "--bogus: unknown option");
}

    /// Quick play opens one folder of saves/, as on vanilla: nothing outside it.
pub fn launch_api_quick_play_is_one_folder_of_saves() void {
}
    // rust: for name in ["../x", "a/b", "/abs", ".", ".."] {
    // rust: assert!(
    // rust: parse(&["--quickPlaySingleplayer", name]).is_err(),
    // rust: "{name} is accepted"
    // rust: );
}
    // rust: assert!(parse(&["--quickPlaySingleplayer", "E2E World"]).is_ok());
}

    /// docs/api/launch-reference.md is what `markdown` writes.
pub fn launch_api_reference_is_current() void {
}
    // rust: let path = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../..")
    // rust: .join("docs/api/launch-reference.md");
    // rust: let want = markdown();
    // rust: if std::env::var_os("HORIZON_WRITE_DOCS").is_some() {
    // rust: std::fs::write(&path, &want).unwrap();
}
    // rust: let have = std::fs::read_to_string(&path)
    // rust: .unwrap_or_default()
    // rust: .replace("\r\n", "\n");
    // rust: assert!(
    // rust: have == want,
    // rust: "docs/api/launch-reference.md is out of date: HORIZON_WRITE_DOCS=1 cargo test -p horizon-client --lib launch_api"
    // rust: );
}
}
