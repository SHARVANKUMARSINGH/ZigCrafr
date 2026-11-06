//! Transpiled from Horizon Rust crate
//! Module: horizon-shader-api_horizon-shader
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-shader`: make Horizon shader packs (docs/shaders.md).
//!
//! - `new <dir> [--template post|sky|material] [--name "Name"]`: a pack from a template.
//! - `check <pack>... [--json]`: the check the game, the launcher and the registry run.
//! - `pack <dir> [--out <file.hshader>]`: check, then write the reproducible `.hshader`.
// use horizon_shader_api::{EXTENSION, MANIFEST, Pack, Problem, check, package::sha256_hex};
// use serde::Serialize;
// use std::{path::Path, process::ExitCode};

pub const USAGE: []const u8 = "usage: horizon-shader new <dir> [--template post|sky|material] [--name \"Name\"] | check <pack>... [--json] | pack <dir> [--out <file.hshader>]";

/// (template, its files as (name, text)).
    // rust: const TEMPLATES: [(&str, [(&str, &str); 2]); 3] = [
    // rust: (
    // rust: "post",
    // rust: [
    // rust: (
    // rust: MANIFEST,
    // rust: include_str!("../../templates/post/horizon-shaders.toml"),
    // rust: ),
    // rust: ("post.wgsl", include_str!("../../templates/post/post.wgsl")),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "sky",
    // rust: [
    // rust: (
    // rust: MANIFEST,
    // rust: include_str!("../../templates/sky/horizon-shaders.toml"),
    // rust: ),
    // rust: ("sky.wgsl", include_str!("../../templates/sky/sky.wgsl")),
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "material",
    // rust: [
    // rust: (
    // rust: MANIFEST,
    // rust: include_str!("../../templates/material/horizon-shaders.toml"),
    // rust: ),
    // rust: (
    // rust: "material.wgsl",
    // rust: include_str!("../../templates/material/material.wgsl"),
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: ];

pub fn main() E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let args: Vec<String> = std::env::args().skip(1).collect();
    // rust: let result = match args.first().map(String::as_str) {
    // rust: Some("new") => new(&args[1..]),
    // rust: Some("check") => check_command(&args[1..]),
    // rust: Some("pack") => pack(&args[1..]),
    // rust: _ => Err(USAGE.into()),
}
    // rust: match result {
    // rust: Ok(()) => ExitCode::SUCCESS,
    // rust: Err(e) => {
    // rust: eprintln!("error: {e}");
    // rust: ExitCode::FAILURE
}
}
}

/// The value after `flag` in `args`.
    // rust: fn flag<'a>(args: &'a [String], flag: &str) -> Option<&'a str> {
    // rust: let i = args.iter().position(|a| a == flag)?;
    // rust: args.get(i + 1).map(String::as_str)
}

/// The arguments that are neither flags nor their values.
pub fn positional(args: *[[]const u8], flags: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut it = args.iter();
    // rust: while let Some(a) = it.next() {
    // rust: if flags.contains(&a.as_str()) {
    // rust: it.next();
    // rust: } else if !a.starts_with("--") {
    // rust: out.push(a.clone());
}
}
    // rust: out
}

pub fn new(args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [dir] = positional(args, &["--template", "--name"])
    // rust: .try_into()
    // rust: .map_err(|_| USAGE.to_string())?;
    // rust: let dir = Path::new(&dir);
    // rust: if dir.exists() {
    // rust: return Err(format!("{} already exists", dir.display()));
}
    // rust: let template = flag(args, "--template").unwrap_or("post");
    // rust: let (_, files) = TEMPLATES
    // rust: .iter()
    // rust: .find(|(name, _)| *name == template)
    // rust: .ok_or_else(|| format!("no template {template:?}: post, sky or material"))?;
    // rust: let base = dir
    // rust: .file_name()
    // rust: .and_then(|n| n.to_str())
    // rust: .ok_or("the path needs a folder name")?;
    // rust: let mut id: String = base
    // rust: .chars()
    // rust: .map(|c| match c {
    // rust: 'a'..='z' | '0'..='9' => c,
    // rust: 'A'..='Z' => c.to_ascii_lowercase(),
    // rust: _ => '_',
    // rust: })
    // rust: .collect();
    // rust: id.truncate(64);
    // rust: let name = flag(args, "--name").map_or_else(|| base.replace(['-', '_'], " "), str::to_owned);
    // rust: std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
    // rust: for (file, text) in files {
    // rust: let text = text
    // rust: .replace("{{id}}", &id)
    // rust: .replace("{{name}}", &name.replace('"', "'"));
    // rust: let path = dir.join(file);
    // rust: std::fs::write(&path, text).map_err(|e| format!("{}: {e}", path.display()))?;
}
    // rust: println!(
    // rust: "Made {} from the {template} template. Edit it, then: horizon-shader check {}",
    // rust: dir.display(),
    // rust: dir.display()
    // rust: );
    // rust: Ok(())
}

pub const StageJson = struct {
    stage: *'static str,
    file: []const u8,
    label: []const u8,
    expressions: usize,
    texture_reads: usize,
};

pub const ProblemJson = struct {
    file: []const u8,
    line: usize,
    column: usize,
    message: []const u8,
};

pub const CheckJson = struct {
    path: []const u8,
    ok: bool,
    id: ?[]const u8,
    version: ?[]const u8,
    api: ?[]const u8,
    /// The file's own SHA-256 (a `.hshader`), else the reproducible package's.
    sha256: ?[]const u8,
    stages: std.ArrayList(StageJson),
    problems: std.ArrayList(ProblemJson),
};

/// Reads and checks the pack at `path`.
pub fn check_one(path: *Path) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = CheckJson {
    // rust: path: path.display().to_string(),
    // rust: ok: false,
    // rust: id: None,
    // rust: version: None,
    // rust: api: None,
    // rust: sha256: None,
    // rust: stages: Vec::new(),
    // rust: problems: Vec::new(),
}
    // rust: let problem = |message: String| ProblemJson {
    // rust: file: path.display().to_string(),
    // rust: line: 0,
    // rust: column: 0,
    // rust: message,
}
    // rust: let pack = match Pack::read(path) {
    // rust: Ok(p) => p,
    // rust: Err(e) => {
    // rust: out.problems.push(problem(e));
    // rust: return out;
}
}
    // rust: out.id = Some(pack.manifest.id.clone());
    // rust: out.version = Some(pack.manifest.version.clone());
    // rust: out.api = Some(pack.manifest.api.to_string());
    // rust: out.sha256 = if path.is_dir() {
    // rust: pack.sha256().ok()
    // rust: } else {
    // rust: std::fs::read(path).ok().map(|b| sha256_hex(&b))
}
    // rust: match check(&pack) {
    // rust: Ok(report) => {
    // rust: out.ok = true;
    // rust: out.stages = report
    // rust: .stages
    // rust: .into_iter()
    // rust: .map(|s| StageJson {
    // rust: stage: s.kind.name(),
    // rust: file: s.file,
    // rust: label: s.label,
    // rust: expressions: s.expressions,
    // rust: texture_reads: s.texture_reads,
    // rust: })
    // rust: .collect();
}
    // rust: Err(problems) => {
    // rust: out.problems = problems
    // rust: .into_iter()
    // rust: .map(
    // rust: |Problem {
    // rust: file,
    // rust: line,
    // rust: column,
    // rust: message,
    // rust: }| ProblemJson {
    // rust: file,
    // rust: line,
    // rust: column,
    // rust: message,
    // rust: },
    // rust: )
    // rust: .collect();
}
}
    // rust: out
}

pub fn check_command(args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let paths = positional(args, &[]);
    // rust: if paths.is_empty() {
    // rust: return Err(USAGE.into());
}
    // rust: let results: Vec<CheckJson> = paths.iter().map(|p| check_one(Path::new(p))).collect();
    // rust: let failed = results.iter().filter(|r| !r.ok).count();
    // rust: if args.iter().any(|a| a == "--json") {
    // rust: let json = serde_json::to_string_pretty(&results).map_err(|e| e.to_string())?;
    // rust: println!("{json}");
    // rust: } else {
    // rust: for r in &results {
    // rust: print_result(r);
}
}
    // rust: match failed {
    // rust: 0 => Ok(()),
    // rust: n => Err(format!("{n} of {} packs failed the check", results.len())),
}
}

pub fn print_result(r: *CheckJson) void {
}
    // rust: let what = match (&r.id, &r.version, &r.api) {
    // rust: (Some(id), Some(v), Some(api)) => format!("{id} {v} (shader API {api})"),
    // rust: _ => r.path.clone(),
}
    // rust: if !r.ok {
    // rust: println!("{what}: FAILED");
    // rust: for p in &r.problems {
    // rust: if p.line == 0 {
    // rust: println!("  {}: {}", p.file, p.message);
    // rust: } else {
    // rust: println!("  {}:{}:{}: {}", p.file, p.line, p.column, p.message);
}
}
    // rust: return;
}
    // rust: println!("{what}: ok");
    // rust: for s in &r.stages {
    // rust: println!(
    // rust: "  {:<9} {:<28} {:>6} expressions, {} texture reads",
    // rust: s.stage, s.label, s.expressions, s.texture_reads
    // rust: );
}
    // rust: if let Some(sha) = &r.sha256 {
    // rust: println!("  sha256 {sha}");
}
}

pub fn pack(args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [dir] = positional(args, &["--out"])
    // rust: .try_into()
    // rust: .map_err(|_| USAGE.to_string())?;
    // rust: let dir = Path::new(&dir)
    // rust: .canonicalize()
    // rust: .map_err(|e| format!("{dir}: {e}"))?;
    // rust: if !dir.is_dir() {
    // rust: return Err(format!("{} is not a pack folder", dir.display()));
}
    // rust: let dir = dir.as_path();
    // rust: let pack = Pack::read(dir)?;
    // rust: if let Err(problems) = check(&pack) {
    // rust: for p in &problems {
    // rust: eprintln!("{p}");
}
    // rust: return Err(format!("{} failed the check", dir.display()));
}
    // rust: let bytes = pack.package()?;
    // rust: let out = flag(args, "--out").map_or_else(
    // rust: || {
    // rust: let m = &pack.manifest;
    // rust: dir.with_file_name(format!("{}-{}.{EXTENSION}", m.id, m.version))
    // rust: },
    // rust: Into::into,
    // rust: );
    // rust: std::fs::write(&out, &bytes).map_err(|e| format!("{}: {e}", out.display()))?;
    // rust: println!("Wrote {} (sha256 {})", out.display(), sha256_hex(&bytes));
    // rust: Ok(())
}
