//! Transpiled from Horizon Rust crate
//! Module: cargo-horizon-mod_registry
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `cargo horizon-mod registry build|review|check|list`: the registry repository's CI
//! (`horizon-rust/horizon-mods`, docs/api/mod-index.md). Network-free: the
//! workflow downloads the files and publishes what this writes.
// use horizon_mods::index::{
    // rust: FILE_HOST,
    // rust: registry::{self, Sources},
}
// use std::path::Path;

/// Where the registry's site is published (its icons).
pub const SITE: []const u8 = "https://horizon-rust.github.io/horizon-mods/";

    // rust: const USAGE: &str = "usage: cargo horizon-mod registry build <checkout> --files <dir> --out <index.json> [--release <url>] [--site <url>] [--generated <time>]
    // rust: cargo horizon-mod registry review <base checkout> <head checkout> --author <login> [--json]
    // rust: cargo horizon-mod registry check <base checkout> <head checkout> --files <dir>
    // rust: cargo horizon-mod registry list <checkout>
    // rust: cargo horizon-mod registry release <checkout> <id> <file> --tag <tag> --published <YYYY-MM-DD> [--notes <file>] [--signature <file>] [--game <version>]
    // rust: cargo horizon-mod registry page <checkout> <id> <horizon-registry.toml>";

    // rust: fn flag<'a>(args: &'a [String], name: &str) -> Option<&'a str> {
    // rust: super::flag(args, name)
}

pub fn positional(args: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut skip = false;
    // rust: for a in args {
    // rust: if skip {
    // rust: skip = false;
    // rust: } else if a == "--json" {
    // rust: } else if a.starts_with("--") {
    // rust: skip = true;
    // rust: } else {
    // rust: out.push(a.as_str());
}
}
    // rust: out
}

pub fn lines(errors: std.ArrayList([]const u8)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{} problem(s):\n  {}", errors.len(), errors.join("\n  "))
}

pub fn main(args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = args.get(1..).unwrap_or_default();
    // rust: let pos = positional(rest);
    // rust: match args.first().map(String::as_str) {
    // rust: Some("build") => {
    // rust: let [checkout] = pos[..] else {
    // rust: return Err(USAGE.into());
}
    // rust: let (files, out) = (flag(rest, "--files"), flag(rest, "--out"));
    // rust: let (Some(files), Some(out)) = (files, out) else {
    // rust: return Err(USAGE.into());
}
    // rust: let generated = flag(rest, "--generated")
    // rust: .map(str::to_owned)
    // rust: .or_else(|| std::env::var("REGISTRY_GENERATED").ok())
    // rust: .unwrap_or_default();
    // rust: let index = registry::build(&Sources {
    // rust: registry: Path::new(checkout),
    // rust: files: Path::new(files),
    // rust: release: flag(rest, "--release").unwrap_or(FILE_HOST),
    // rust: site: flag(rest, "--site").unwrap_or(SITE),
    // rust: generated,
    // rust: })
    // rust: .map_err(lines)?;
    // rust: let text = serde_json::to_string_pretty(&index).map_err(|e| e.to_string())?;
    // rust: std::fs::write(out, text + "\n").map_err(|e| format!("{out}: {e}"))?;
    // rust: println!(
    // rust: "Wrote {out}: {} project(s), {} taken down",
    // rust: index.projects.len(),
    // rust: index.revoked.len()
    // rust: );
    // rust: Ok(())
}
    // rust: Some("review") => {
    // rust: let [base, head] = pos[..] else {
    // rust: return Err(USAGE.into());
}
    // rust: let author = flag(rest, "--author").ok_or(USAGE)?;
    // rust: let (base, _) = registry::load(Path::new(base)).map_err(lines)?;
    // rust: let (head, _) = registry::load(Path::new(head)).map_err(lines)?;
    // rust: let review = registry::review(&base, &head, author);
    // rust: if rest.iter().any(|a| a == "--json") {
    // rust: let json = serde_json::json!({"errors": review.errors, "notes": review.notes});
    // rust: println!("{json}");
    // rust: } else {
    // rust: for n in &review.notes {
    // rust: println!("note: {n}");
}
    // rust: for e in &review.errors {
    // rust: println!("error: {e}");
}
}
    // rust: if review.errors.is_empty() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!(
    // rust: "{} change(s) the registry refuses",
    // rust: review.errors.len()
    // rust: ))
}
}
        // `check` (and its trial run) on each file `head` lists and `base`
        // doesn't: a pull request's new files.
    // rust: Some("check") => {
    // rust: let [base, head] = pos[..] else {
    // rust: return Err(USAGE.into());
}
    // rust: let files = Path::new(flag(rest, "--files").ok_or(USAGE)?);
    // rust: let old: Vec<String> = match registry::load(Path::new(base)) {
    // rust: Ok((entries, _)) => entries
    // rust: .iter()
    // rust: .flat_map(|e| e.versions.iter().map(|v| v.sha256.clone()))
    // rust: .collect(),
                // The first pull request has no entries to compare with.
    // rust: Err(_) => Vec::new(),
}
    // rust: let (entries, _) = registry::load(Path::new(head)).map_err(lines)?;
    // rust: let mut failed = 0;
    // rust: for e in &entries {
    // rust: for v in e.versions.iter().filter(|v| !old.contains(&v.sha256)) {
    // rust: println!("{} {} ({}):", e.id, v.version, v.file);
    // rust: let report = crate::check::check(
    // rust: &files.join(&v.sha256),
    // rust: e.kind.clone(),
    // rust: e.key.as_deref(),
    // rust: v.signature.as_deref(),
    // rust: );
    // rust: match report {
    // rust: Ok(r) => print!("{}", r.text()),
    // rust: Err(err) => {
    // rust: failed += 1;
    // rust: println!("  error: {err}");
}
}
}
}
    // rust: if failed == 0 {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("{failed} file(s) failed their check"))
}
}
        // The files CI must download for `build`: `<sha256> <id> <version> <file>`.
    // rust: Some("list") => {
    // rust: let [checkout] = pos[..] else {
    // rust: return Err(USAGE.into());
}
    // rust: let (entries, _) = registry::load(Path::new(checkout)).map_err(lines)?;
    // rust: for e in &entries {
    // rust: for v in &e.versions {
    // rust: println!("{} {} {} {}", v.sha256, e.id, v.version, v.file);
}
}
    // rust: Ok(())
}
        // A release of a project's repository, downloaded: the checks of a submission, then the
        // version as the index lists it (JSON on stdout), for the registry's release sync.
    // rust: Some("release") => {
    // rust: let [checkout, id, file] = pos[..] else {
    // rust: return Err(USAGE.into());
}
    // rust: let (tag, published) = (
    // rust: flag(rest, "--tag").ok_or(USAGE)?,
    // rust: flag(rest, "--published").ok_or(USAGE)?,
    // rust: );
    // rust: let read = |name: &str| {
    // rust: flag(rest, name)
    // rust: .map(|p| std::fs::read_to_string(p).map_err(|e| format!("{p}: {e}")))
    // rust: .transpose()
}
    // rust: let (notes, signature) = (read("--notes")?, read("--signature")?);
    // rust: let entry = entry_of(checkout, id)?;
    // rust: let path = Path::new(file);
    // rust: let cache = registry::Cache::read(Path::new(checkout), id)?;
    // rust: let entry = entry.resolved(&cache.page);
    // rust: let name = path.file_name().and_then(|n| n.to_str()).unwrap_or("");
    // rust: crate::check::check(
    // rust: path,
    // rust: entry.kind.clone(),
    // rust: entry.key.as_deref(),
    // rust: signature.as_deref(),
    // rust: )?;
    // rust: let version = registry::release_version(
    // rust: &entry,
    // rust: &registry::Release {
    // rust: tag,
    // rust: published,
    // rust: notes: notes.as_deref().unwrap_or(""),
    // rust: asset: flag(rest, "--name").unwrap_or(name),
    // rust: game: flag(rest, "--game").unwrap_or("26.3"),
    // rust: signature: signature.as_deref(),
    // rust: },
    // rust: path,
    // rust: )?;
    // rust: println!(
    // rust: "{}",
    // rust: serde_json::to_string(&version).map_err(|e| e.to_string())?
    // rust: );
    // rust: Ok(())
}
        // The page file of a project's repository, checked against its entry: the page as JSON.
    // rust: Some("page") => {
    // rust: let [checkout, id, file] = pos[..] else {
    // rust: return Err(USAGE.into());
}
    // rust: let entry = entry_of(checkout, id)?;
    // rust: let text = std::fs::read_to_string(file).map_err(|e| format!("{file}: {e}"))?;
    // rust: let page = registry::page(&entry, &text)?;
    // rust: println!(
    // rust: "{}",
    // rust: serde_json::to_string(&page).map_err(|e| e.to_string())?
    // rust: );
    // rust: Ok(())
}
    // rust: _ => Err(USAGE.into()),
}
}

/// `mods/<id>.toml` of the checkout, which must name a repository.
pub fn entry_of(checkout: []const u8, id: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (entries, _) = registry::load(Path::new(checkout)).map_err(lines)?;
    // rust: entries
    // rust: .into_iter()
    // rust: .find(|e| e.id == id && e.repo.is_some())
    // rust: .ok_or_else(|| format!("{id}: no entry with a repo"))
}
