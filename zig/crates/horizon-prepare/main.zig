//! Transpiled from Horizon Rust crate
//! Module: horizon-prepare_main
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-prepare`: prepares Horizon's resources from your own Minecraft Java Edition.
//! Its flags are the ones tools/prepare_native_client.py took.

// use std::io::Write;
// use std::path::{Path, PathBuf};
// use std::process::ExitCode;

/// This release's version: release.yml builds it with `HORIZON_VERSION` from the tag
/// (docs/versioning.md); a build from source says Cargo.toml's.
    // rust: const VERSION: &str = match option_env!("HORIZON_VERSION") {
    // rust: Some(version) if !version.is_empty() => version,
    // rust: _ => env!("CARGO_PKG_VERSION"),
}

    // rust: const HELP: &str = "\
    // rust: horizon-prepare: prepare Horizon's resources from your own Minecraft Java Edition

    // rust: Usage: horizon-prepare [--prepare] [--server-jar PATH] [--minecraft-dir PATH] [--root PATH] [--output PATH]
    // rust: [--version-json PATH] [--client-jar PATH] [--libraries-dir PATH] [--assets-dir PATH]
    // rust: [--java-home PATH] [--complete] [--progress json]
    // rust: horizon-prepare --check [--root PATH] [--output PATH]
    // rust: horizon-prepare --launch-api [--root PATH]
    // rust: horizon-prepare compile-exporters [--root PATH]
    // rust: horizon-prepare sounds [--minecraft-dir PATH] [--version-json PATH] [--assets-dir PATH] [--root PATH] [--output PATH]
    // rust: horizon-prepare panorama [--minecraft-dir PATH] [--version-json PATH] [--assets-dir PATH] [--root PATH] [--output PATH]
    // rust: horizon-prepare fonts [--minecraft-dir PATH] [--version-json PATH] [--assets-dir PATH] [--root PATH] [--output PATH]
    // rust: horizon-prepare packs [--minecraft-dir PATH] [--version-json PATH] [--assets-dir PATH] [--root PATH] [--output PATH]
    // rust: horizon-prepare languages [--minecraft-dir PATH] [--version-json PATH] [--assets-dir PATH] [--root PATH] [--output PATH]

    // rust: --prepare             Import the pinned game files from your own copy first
    // rust: --server-jar PATH     The pinned server jar you downloaded yourself
    // rust: (default: HORIZON_SERVER_JAR, or the copy imported before)
    // rust: --minecraft-dir PATH  The official launcher's game directory with your installed copy
    // rust: (default: HORIZON_MINECRAFT_DIR, or the launcher's own)
    // rust: --version-json PATH   The pinned version's JSON, where --minecraft-dir has none
    // rust: --client-jar PATH     The pinned client jar, where --minecraft-dir has none
    // rust: --libraries-dir PATH  The folder of the client's libraries (Maven layout)
    // rust: --assets-dir PATH     The asset store, with indexes/ and objects/
    // rust: (each of these four replaces what --minecraft-dir would give; an earlier
    // rust: import beside --root that is still verified is reused instead)
    // rust: --java-home PATH      A Java runtime of the pinned version that your launcher manages, tried
    // rust: after JAVA_HOME and the PATH, before the official launcher's runtimes
    // rust: --root PATH           The Horizon folder to prepare (default: the folder this program is
    // rust: in, else the nearest folder above the current one with research-lock.json)
    // rust: --output PATH         Where the resources go (default: <root>/.local/horizon-client/<version>);
    // rust: the exporters' scratch files stay in <root>/.local
    // rust: --check               Exit 0 when the resources are complete and current for this preparer,
    // rust: else 1: each gap on stdout with what it needs, or an error: line on
    // rust: stderr when it can't check. Runs no Java and reads no game files; it tests
    // rust: which files are there and their versions, not their contents (on doubt,
    // rust: prepare again)
    // rust: --complete            Also copy the sounds, then fail unless --check would pass: one command
    // rust: for resources the game plays with nothing missing
    // rust: --progress json       One JSON object a line on stdout: {\"message\": ...} for each log line,
    // rust: {\"fraction\": F} as the work advances (0 to 1), {\"error\": ...} on failure
    // rust: --launch-api          Print what this preparer supports as JSON (the Launch API's version, the
    // rust: pinned Minecraft and Java, the resources' layout, the options) and exit 0

    // rust: Needs Minecraft played once from the official launcher, and Java of the version
    // rust: research-lock.json pins. Releases use a runtime; development or changed exporters need a JDK.
    // rust: compile-exporters builds and validates a release bundle from the already imported pinned jars.
    // rust: The resources go to <root>/.local/horizon-client/<version>, or --output; pass that to
    // rust: horizon-client --resources. Exit codes: 0 done, 1 failed (or --check found gaps), 2 a refused
    // rust: command line (docs/api/launch.md).

    // rust: horizon-prepare panorama repairs the classic menu background in existing resources without Java.
    // rust: horizon-prepare fonts adds the GNU Unifont glyphs (characters the bitmap fonts lack) the same way.
    // rust: horizon-prepare packs adds the built-in Programmer Art and High Contrast resource packs the same way.
    // rust: horizon-prepare languages adds the bundled languages and the language list the JAR lacks the same way.
    // rust: Full preparation also imports all four after extracting the client JAR's placeholders.

    // rust: horizon-prepare sounds copies the pinned version's sounds (about 380 MB) from the official
    // rust: launcher's asset store into the same folder, checking every file. It is optional: without it the
    // rust: game is silent. Nothing is downloaded; it needs the version played once from the official launcher.
    // rust: ";

/// The folder with research-lock.json: beside the executable in a release folder, else the
/// current folder or one above it (a checkout, with the binary in target/).
pub fn default_root() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let beside = std::env::current_exe()
    // rust: .ok()
    // rust: .and_then(|exe| exe.parent().map(Path::to_path_buf));
    // rust: if let Some(dir) = beside.filter(|d| d.join("research-lock.json").is_file()) {
    // rust: return Some(dir);
}
    // rust: let cwd = std::env::current_dir().ok()?;
    // rust: cwd.ancestors()
    // rust: .find(|d| d.join("research-lock.json").is_file())
    // rust: .map(Path::to_path_buf)
}

pub fn main() E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut options = horizon_prepare::Options {
    // rust: root: PathBuf::new(),
    // rust: import: false,
    // rust: minecraft_dir: None,
    // rust: server_jar: None,
    // rust: java_home: None,
    // rust: inputs: Default::default(),
    // rust: output: None,
}
    // rust: let mut root = None;
    // rust: let mut check = false;
    // rust: let mut complete = false;
    // rust: let mut json = false;
    // rust: let mut launch_api = false;
    // rust: let mut args = std::env::args_os().skip(1).peekable();
    // rust: let assets = args.next_if(|a| {
    // rust: matches!(
    // rust: a.to_str(),
    // rust: Some("sounds" | "panorama" | "fonts" | "packs" | "languages" | "compile-exporters")
    // rust: )
    // rust: });
    // rust: while let Some(arg) = args.next() {
    // rust: let text = arg.to_string_lossy().into_owned();
    // rust: let (flag, inline) = match text.split_once('=') {
    // rust: Some((flag, value)) if flag.starts_with("--") => {
    // rust: (flag.to_string(), Some(value.to_string()))
}
    // rust: _ => (text.clone(), None),
}
    // rust: let mut value = |name: &str| -> Result<PathBuf, String> {
    // rust: match &inline {
    // rust: Some(v) => Ok(PathBuf::from(v)),
    // rust: None => args
    // rust: .next()
    // rust: .map(PathBuf::from)
    // rust: .ok_or_else(|| format!("{name} needs a path")),
}
}
    // rust: let parsed = match flag.as_str() {
    // rust: "--prepare" | "--server-jar" | "--check" if assets.is_some() => {
    // rust: Err(format!("{flag} is for preparing, not for asset copying"))
}
    // rust: "--prepare" if inline.is_none() => {
    // rust: options.import = true;
    // rust: Ok(())
}
    // rust: "--server-jar" => value("--server-jar").map(|v| options.server_jar = Some(v)),
    // rust: "--minecraft-dir" => value("--minecraft-dir").map(|v| options.minecraft_dir = Some(v)),
    // rust: "--version-json" => {
    // rust: value("--version-json").map(|v| options.inputs.version_json = Some(v))
}
    // rust: "--client-jar" => value("--client-jar").map(|v| options.inputs.client_jar = Some(v)),
    // rust: "--libraries-dir" => {
    // rust: value("--libraries-dir").map(|v| options.inputs.libraries_dir = Some(v))
}
    // rust: "--assets-dir" => value("--assets-dir").map(|v| options.inputs.assets_dir = Some(v)),
    // rust: "--java-home" => value("--java-home").map(|v| options.java_home = Some(v)),
    // rust: "--root" => value("--root").map(|v| root = Some(v)),
    // rust: "--output" => value("--output").map(|v| options.output = Some(v)),
    // rust: "--check" if inline.is_none() => {
    // rust: check = true;
    // rust: Ok(())
}
    // rust: "--complete" if inline.is_none() && assets.is_none() => {
    // rust: complete = true;
    // rust: Ok(())
}
    // rust: "--progress" => match value("--progress") {
    // rust: Ok(v) if v.as_os_str() == "json" => {
    // rust: json = true;
    // rust: Ok(())
}
    // rust: Ok(v) => Err(format!("--progress takes json, not {}", v.display())),
    // rust: Err(e) => Err(e),
    // rust: },
    // rust: "--launch-api" if inline.is_none() => {
    // rust: launch_api = true;
    // rust: Ok(())
}
    // rust: "-h" | "--help" => {
    // rust: print!("{HELP}");
    // rust: return ExitCode::SUCCESS;
}
    // rust: "-V" | "--version" => {
    // rust: println!("horizon-prepare {VERSION}");
    // rust: return ExitCode::SUCCESS;
}
    // rust: _ => Err(format!("unrecognized argument: {text}")),
}
    // rust: if let Err(e) = parsed {
    // rust: eprintln!("horizon-prepare: error: {e}\n\n{HELP}");
    // rust: return ExitCode::from(2);
}
}
    // rust: let Some(root) = root.or_else(default_root) else {
    // rust: eprintln!(
    // rust: "horizon-prepare: error: no research-lock.json beside this program or above the current folder; pass --root"
    // rust: );
    // rust: return ExitCode::from(2);
}
    // rust: options.root = root;
    // rust: if launch_api {
    // rust: return match horizon_prepare::artifacts::Lock::read(&options.root) {
    // rust: Ok(lock) => {
    // rust: println!("{}", horizon_prepare::launch_api::reply(VERSION, &lock));
    // rust: ExitCode::SUCCESS
}
    // rust: Err(e) => {
    // rust: eprintln!("error: {e}");
    // rust: ExitCode::FAILURE
}
}
}
    // rust: if check {
    // rust: if options.import || options.server_jar.is_some() {
    // rust: eprintln!("horizon-prepare: error: --check prepares nothing; leave out --prepare and --server-jar");
    // rust: return ExitCode::from(2);
}
    // rust: if json || complete {
    // rust: eprintln!("horizon-prepare: error: --progress and --complete apply to preparing; leave them out with --check");
    // rust: return ExitCode::from(2);
}
    // rust: return check_resources(&options);
}
    // rust: let print = |line: &str| {
    // rust: let mut out = std::io::stdout().lock();
    // rust: let _ = writeln!(out, "{line}");
    // rust: let _ = out.flush();
}
    // rust: let log = |line: &str| match json {
    // rust: true => print(&json_line("message", line)),
    // rust: false => print(line),
}
    // Preparing is most of a complete run; the sounds and the check are the rest.
    // rust: let scale = if complete { 0.9 } else { 1.0 };
    // rust: let progress = |fraction: f32| {
    // rust: if json {
    // rust: print(&fraction_line(fraction * scale));
}
}
    // rust: let result = match assets.as_deref().and_then(|a| a.to_str()) {
    // rust: Some("compile-exporters") => horizon_prepare::compile_exporters(&options, &log)
    // rust: .inspect(|dir| log(&dir.display().to_string())),
    // rust: Some(kind @ ("sounds" | "panorama" | "fonts" | "packs" | "languages")) => {
    // rust: horizon_prepare::add_assets(
    // rust: kind,
    // rust: &options.root,
    // rust: options.output.as_deref(),
    // rust: options.minecraft_dir.as_deref(),
    // rust: &options.inputs,
    // rust: &log,
    // rust: )
}
    // rust: _ => horizon_prepare::prepare_with_progress(&options, &log, &progress).and_then(
    // rust: |resources| match complete {
    // rust: true => complete_resources(&options, resources, &log),
    // rust: false => Ok(resources),
    // rust: },
    // rust: ),
}
    // rust: match result {
    // rust: Ok(_) => {
            // A plain preparation reported its 1 already.
    // rust: if json && (complete || assets.is_some()) {
    // rust: print(&fraction_line(1.0));
}
    // rust: ExitCode::SUCCESS
}
    // rust: Err(e) => {
    // rust: if json {
    // rust: print(&json_line("error", &e));
}
    // rust: eprintln!("error: {e}");
    // rust: ExitCode::FAILURE
}
}
}

/// `--complete` after preparing: the sounds, then nothing may be missing.
    // rust: fn complete_resources(
    // rust: options: &horizon_prepare::Options,
    // rust: resources: PathBuf,
    // rust: log: horizon_prepare::Log,
    // rust: ) -> Result<PathBuf, String> {
    // rust: horizon_prepare::add_assets(
    // rust: "sounds",
    // rust: &options.root,
    // rust: Some(&resources),
    // rust: options.minecraft_dir.as_deref(),
    // rust: &options.inputs,
    // rust: log,
    // rust: )?;
    // rust: let lacking = horizon_prepare::check(&options.root, &resources)?;
    // rust: if lacking.is_empty() {
    // rust: return Ok(resources);
}
    // rust: for line in &lacking {
    // rust: log(line);
}
    // rust: Err(format!(
    // rust: "the resources are not complete: {}",
    // rust: lacking.join("; ")
    // rust: ))
}

/// `{"key": "text"}` on one line: `--progress json`'s `message` and `error` (docs/api/launch.md).
pub fn json_line(key: []const u8, text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = format!("{{\"{key}\": ");
    // rust: horizon_prepare::pyjson::write_string(&mut out, text);
    // rust: out.push('}');
    // rust: out
}

/// `--progress json`'s `{"fraction": F}`, F from 0 to 1 with three decimals.
pub fn fraction_line(fraction: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{{\"fraction\": {:.3}}}", fraction.clamp(0.0, 1.0))
}

/// `--check`: each gap on its own line on stdout, exit 1 when there is one.
pub fn check_resources(options: *horizon_prepare::Options) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let resources = horizon_prepare::artifacts::Lock::read(&options.root).map(|lock| {
    // rust: horizon_prepare::resources_dir(&options.root, &lock.version, options.output.as_deref())
    // rust: });
    // rust: match resources.and_then(|resources| horizon_prepare::check(&options.root, &resources)) {
    // rust: Ok(lacking) if lacking.is_empty() => ExitCode::SUCCESS,
    // rust: Ok(lacking) => {
    // rust: for line in lacking {
    // rust: println!("{line}");
}
    // rust: ExitCode::FAILURE
}
    // rust: Err(e) => {
    // rust: eprintln!("error: {e}");
    // rust: ExitCode::FAILURE
}
}
}

    // rust: mod tests {
//     use super::*;

    /// `--progress json`'s three lines as docs/api/launch.md promises them: a launcher parses
    /// them, so a refactor must not change them silently.
pub fn progress_json_lines_keep_their_shape() void {
}
    // rust: assert_eq!(
    // rust: json_line("message", "Copying \"sounds\"\nnext"),
    // rust: r#"{"message": "Copying \"sounds\"\nnext"}"#
    // rust: );
    // rust: assert_eq!(
    // rust: json_line("error", "no Java 25"),
    // rust: r#"{"error": "no Java 25"}"#
    // rust: );
    // rust: assert_eq!(fraction_line(0.05), r#"{"fraction": 0.050}"#);
    // rust: assert_eq!(fraction_line(1.0), r#"{"fraction": 1.000}"#);
    // rust: for line in [json_line("message", "tab\there, é"), fraction_line(0.9)] {
    // rust: assert!(horizon_prepare::pyjson::loads(&line).is_ok(), "{line}");
}
}

    /// Every option `--launch-api` promises is one `--help` documents.
pub fn launch_api_options_are_in_the_help() void {
}
    // rust: for (name, _) in horizon_prepare::launch_api::OPTIONS {
    // rust: assert!(
    // rust: HELP.contains(&format!("  {name} ")),
    // rust: "{name} is not in --help"
    // rust: );
}
}
}
