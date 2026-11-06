//! Transpiled from Horizon Rust crate
//! Module: horizon-server_reference
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! docs/api/server-reference.md: `horizon-server`'s commands, every `server.toml` key and the control API's
//! endpoints, generated from the source, and the tests that fail when it is out of date. Update it with:
//! `HORIZON_WRITE_DOCS=1 cargo test -p horizon-server reference`.

// use crate::{api::ROUTES, config};
// use std::fmt::Write;

pub const DOC: []const u8 = "docs/api/server-reference.md";

/// One `key = value  # what it means` line of the template, under its `[section]`.
pub const Key = struct {
    section: []const u8,
    name: []const u8,
    default: []const u8,
    what: []const u8,
};

/// The template's sections, each with the comment lines above it, and its keys, in order.
pub fn template() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut sections, mut keys, mut notes) = (Vec::new(), Vec::new(), Vec::<&str>::new());
    // rust: for line in config::TEMPLATE.lines().map(str::trim) {
    // rust: if let Some(note) = line.strip_prefix('#') {
    // rust: notes.push(note.trim());
    // rust: } else if let Some(section) = line.strip_prefix('[').and_then(|l| l.strip_suffix(']')) {
    // rust: sections.push((section.to_owned(), notes.join(" ")));
    // rust: notes.clear();
    // rust: } else if let Some((name, rest)) = line.split_once(" = ") {
    // rust: let (default, what) = rest.split_once(" # ").unwrap_or((rest, ""));
    // rust: keys.push(Key {
    // rust: section: sections.last().map(|(s, _)| s.clone()).unwrap_or_default(),
    // rust: name: name.trim().to_owned(),
    // rust: default: default.trim().to_owned(),
    // rust: what: what.trim().to_owned(),
    // rust: });
}
}
    // rust: (sections, keys)
}

pub fn markdown() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::new();
    // rust: let w = &mut out;
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "<!-- Generated from crates/horizon-server/src (the help text, config::TEMPLATE, api::ROUTES) by reference.rs; a test fails when this file is out of date. Update it with: HORIZON_WRITE_DOCS=1 cargo test -p horizon-server reference -->"
    // rust: );
    // rust: let _ = writeln!(w, "# Server reference\n");
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "Everything `horizon-server` offers a host or a tool: its commands, every `server.toml` key and the \
    // rust: control API. How to host: [hosting.md](../hosting.md); the design: [server.md](../server.md); \
    // rust: stability and versions: [stability.md](stability.md).\n"
    // rust: );

    // rust: let _ = writeln!(w, "## Commands\n\n`horizon-server help` prints:\n");
    // rust: let _ = writeln!(w, "```text\n{}```\n", crate::HELP);

    // rust: let _ = writeln!(w, "## `server.toml`\n");
    // rust: let (sections, keys) = template();
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "{} Unknown keys are refused. `horizon-server init` writes this file with these defaults; \
    // rust: `horizon-server config set SECTION.KEY=VALUE` changes it.\n",
    // rust: sections[0].1
    // rust: );
    // rust: for (i, (section, note)) in sections.iter().enumerate() {
    // rust: let _ = writeln!(w, "### `[{section}]`\n");
    // rust: if i > 0 && !note.is_empty() {
    // rust: let _ = writeln!(w, "{note}\n");
}
    // rust: let rows: Vec<&Key> = keys.iter().filter(|k| &k.section == section).collect();
    // rust: if rows.is_empty() {
    // rust: continue;
}
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "| Key | Default | In `server.properties` | What it does |\n| --- | --- | --- | --- |"
    // rust: );
    // rust: for k in rows {
    // rust: let vanilla = config::TYPED
    // rust: .iter()
    // rust: .find(|(s, n, _)| s == section && *n == k.name)
    // rust: .map_or(String::new(), |(_, _, v)| format!("`{v}`"));
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "| `{}` | `{}` | {vanilla} | {} |",
    // rust: k.name, k.default, k.what
    // rust: );
}
    // rust: let _ = writeln!(w);
}

    // rust: let _ = writeln!(w, "## Control API (`/api/v1`)\n");
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "HTTP and JSON on 127.0.0.1. A running server writes its address and a random token to \
    // rust: `.horizon/api.json`, readable only by its own user; every request sends \
    // rust: `Authorization: Bearer <token>` and a `Host` that is that address. Errors answer \
    // rust: `{{\"error\": \"...\"}}` with 400, 401, 403, 404, 405 or 409. The web panel uses the same \
    // rust: routes with its session.\n"
    // rust: );
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "| Method | Path | Takes | Answers | What it does |\n| --- | --- | --- | --- | --- |"
    // rust: );
    // rust: for r in &ROUTES {
    // rust: let takes = if r.takes.is_empty() {
    // rust: "nothing"
    // rust: } else {
    // rust: r.takes
}
    // rust: let _ = writeln!(
    // rust: w,
    // rust: "| `{}` | `{}` | {takes} | {} | {} |",
    // rust: r.method, r.path, r.answers, r.what
    // rust: );
}
    // rust: out
}

pub fn the_server_reference_is_up_to_date() void {
}
    // rust: let path = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../..")
    // rust: .join(DOC);
    // rust: let want = markdown();
    // rust: if std::env::var_os("HORIZON_WRITE_DOCS").is_some() {
    // rust: std::fs::write(&path, &want).unwrap();
}
    // rust: let have = std::fs::read_to_string(&path)
    // rust: .unwrap_or_default()
    // rust: .replace("\r\n", "\n");
    // rust: assert!(
    // rust: have == want,
    // rust: "{DOC} is out of date: HORIZON_WRITE_DOCS=1 cargo test -p horizon-server reference"
    // rust: );
}

/// The template, which the reference lists, holds every key `Config` reads and no other.
pub fn the_reference_lists_every_setting() void {
}
    // rust: let config = toml::Value::try_from(config::Config::default()).unwrap();
    // rust: let mut listed: Vec<String> = template()
    // rust: .1
    // rust: .iter()
    // rust: .map(|k| format!("{}.{}", k.section, k.name))
    // rust: .collect();
    // rust: let mut read: Vec<String> = config
    // rust: .as_table()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .filter_map(|(section, keys)| Some((section, keys.as_table()?)))
    // rust: .flat_map(|(section, keys)| keys.keys().map(move |k| format!("{section}.{k}")))
    // rust: .collect();
    // rust: listed.sort();
    // rust: read.sort();
    // rust: assert_eq!(listed, read);
    // rust: for key in template().1 {
    // rust: assert!(
    // rust: !key.what.is_empty(),
    // rust: "{}.{} needs a `# what it does` comment in config::TEMPLATE",
    // rust: key.section,
    // rust: key.name
    // rust: );
}
}

/// `ROUTES` holds exactly the endpoints the API's code answers.
pub fn the_routes_table_matches_the_code() void {
}
    // rust: let source = include_str!("api.rs");
    // rust: let mut answered: Vec<(String, String)> = Vec::new();
    // rust: for method in ["GET", "POST", "PATCH", "DELETE"] {
    // rust: let open = format!("(\"{method}\", \"/api/v1/");
    // rust: for (at, _) in source.match_indices(&open) {
    // rust: let rest = &source[at + open.len()..];
    // rust: let path = &rest[..rest.find('"').unwrap()];
    // rust: if rest[path.len()..].starts_with("\")") {
    // rust: answered.push((method.into(), format!("/api/v1/{path}")));
}
}
}
    // rust: let mut listed: Vec<(String, String)> = ROUTES
    // rust: .iter()
    // rust: .map(|r| (r.method.into(), r.path.into()))
    // rust: .collect();
    // rust: answered.sort();
    // rust: listed.sort();
    // rust: assert_eq!(answered, listed);
}
