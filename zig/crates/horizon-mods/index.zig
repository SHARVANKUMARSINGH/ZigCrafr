//! Transpiled from Horizon Rust crate
//! Module: horizon-mods_index
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The mod registry's index, `index.json` (docs/api/mod-index.md): every
//! reviewed mod and modpack, its versions, the file of each with its size,
//! SHA-256 and minisign signature, and the files taken down. The launcher
//! reads it to browse and install, the website to show it, and the
//! registry's CI writes it.
//!
//! [`check_file`] is what a file must pass before it is installed: its size
//! and hash are the ones the index lists, its signature verifies against the
//! project's pinned key, and what its own manifest says matches the entry.
// use crate::{
    // rust: Capability, Package, Side,
    // rust: modpack::{self, Modpack},
}
// use serde::{Deserialize, Serialize};
// use sha2::{Digest, Sha256};
// use std::{io::Read, path::Path};

/// The index format this build reads and writes. A reader refuses a newer
/// one rather than misread it.
pub const SCHEMA: u32 = 1;
/// The biggest file the registry takes (a `.hmod` with content, a `.hpack`).
pub const MAX_FILE: u64 = 64 << 20;
/// Where files may be downloaded from: the registry's release assets.
pub const FILE_HOST: []const u8 = "https://github.com/horizon-rust/horizon-mods/releases/download/";

pub const Index = struct {
    schema: u32,
    /// When CI built it, RFC 3339.
    generated: []const u8,
    projects: std.ArrayList(Project),
    revoked: std.ArrayList(Revoked),
};

/// What a project is. New kinds (data packs, worlds, themes) can be added
/// without a new schema: a reader keeps a kind it doesn't know as
/// [`Kind::Other`] and doesn't offer it.
pub const Kind = enum {
    /// A `.hmod` of content only.
    Mod,
    /// A source-only native mixin bundle, compiled into an isolated game build. Published as an
    /// `.hnmod` until launchers and the game read native `.hmod`s (#5865, docs/api/mod-files.md).
    NativeMod,
    /// A `.hpack`: registry mods played together as a profile.
    Modpack,
    /// A resource pack (`.zip` with `pack.mcmeta`) made or tested for Horizon.
    ResourcePack,
    /// A Horizon shader pack (`.hshader`, the native WGSL format of
    /// docs/shaders.md).
    Shader,
    /// A `shaders/`-folder shader pack (`.zip`, the format `horizon-shaders` loads), listed by
    /// its author under a licence that allows it.
    ShaderPack,
    /// A data pack (`.zip` with `pack.mcmeta` and `data/`), installed into a world.
    DataPack,
    Other(String),
};

    // rust: impl Kind {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Kind::Mod => "mod",
    // rust: Kind::NativeMod => "native-mod",
    // rust: Kind::Modpack => "modpack",
    // rust: Kind::ResourcePack => "resourcepack",
    // rust: Kind::Shader => "shader",
    // rust: Kind::ShaderPack => "shaderpack",
    // rust: Kind::DataPack => "datapack",
    // rust: Kind::Other(name) => name,
}
}

    /// The extension of its files; None for a kind this build doesn't know.
pub fn extension(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Kind::Mod => Some("hmod"),
    // rust: Kind::NativeMod => Some("hnmod"),
    // rust: Kind::Modpack => Some("hpack"),
    // rust: Kind::ResourcePack => Some("zip"),
    // rust: Kind::Shader => Some(horizon_shader_api::EXTENSION),
    // rust: Kind::ShaderPack | Kind::DataPack => Some("zip"),
    // rust: Kind::Other(_) => None,
}
}
}

    // rust: impl From<String> for Kind {
pub fn from(name: []const u8) K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name.as_str() {
    // rust: "mod" => Kind::Mod,
    // rust: "native-mod" => Kind::NativeMod,
    // rust: "modpack" => Kind::Modpack,
    // rust: "resourcepack" => Kind::ResourcePack,
    // rust: "shader" => Kind::Shader,
    // rust: "shaderpack" => Kind::ShaderPack,
    // rust: "datapack" => Kind::DataPack,
    // rust: _ => Kind::Other(name),
}
}
}

    // rust: impl From<Kind> for String {
pub fn from(kind: Kind) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: kind.name().to_owned()
}
}

pub const Project = struct {
    /// The manifest's id, `[a-z0-9_]{1,64}`: unique across the index.
    id: []const u8,
    kind: Kind,
    name: []const u8,
    /// One line for lists.
    summary: []const u8,
    /// Markdown, for the project's page.
    description: []const u8,
    authors: std.ArrayList([]const u8),
    /// The GitHub logins allowed to publish its updates.
    owners: std.ArrayList([]const u8),
    /// An SPDX expression.
    license: []const u8,
    /// Where its source code is, `https://`.
    source: []const u8,
    icon: ?[]const u8,
    /// From the kind's list ([`page::categories`]), at most 3.
    categories: std.ArrayList([]const u8),
    /// Free-form, lowercase, at most 10.
    tags: std.ArrayList([]const u8),
    /// `https://` addresses of PNG or JPEG images, in order, at most 8.
    screenshots: std.ArrayList([]const u8),
    /// The author's minisign public key: every version must be signed with
    /// it. None: unsigned (the SHA-256 still pins the reviewed file).
    key: ?[]const u8,
    /// Newest first.
    versions: std.ArrayList(Version),
    /// Its files' downloads from their releases, all versions together:
    /// GitHub's counts, added by the registry's publish job (hourly).
    downloads: u64,
    /// The GitHub stars of its `source` repository, added by the registry's
    /// publish job (hourly); 0 when it has none or isn't on GitHub.
    stars: u64,
};

pub fn is_zero(n: *u64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *n == 0
}

pub const Version = struct {
    version: []const u8,
    /// The day it was published, `YYYY-MM-DD`.
    published: []const u8,
    changelog: []const u8,
    /// A mod's API line (`0.1`), from its manifest; a modpack's format (`1`).
    api: []const u8,
    side: ?Side,
    capabilities: std.ArrayList(Capability),
    /// The mod API level a mod's code needs ([`crate::api_level`]), read
    /// from its file; none for content and other kinds, and in indexes
    /// built before levels.
    api_level: ?u32,
    /// A native mod's hook points version (`horizon-native.json`'s `hooks`): it builds on any
    /// Horizon whose `NATIVE_HOOKS_API` is this or later. None for a native mod that pins its
    /// commit, other kinds, and indexes built before it was listed.
    hooks: ?u32,
    /// The Minecraft version it is for.
    game: []const u8,
    /// The Horizon commits a native mod's version doesn't apply on, as the registry's daily check
    /// on the newest Nightly found (horizon-mods' native-compat.yml): the launcher warns before
    /// an install, and a build there leaves it out. Never in an entry: the publish job adds it.
    broken_on: std.ArrayList(BrokenOn),
    /// A modpack's mods, as its manifest lists them.
    requires: std.ArrayList(Requirement),
    file: File,
};

/// A Horizon commit a native mod's version doesn't apply on, and horizon-mixins' diagnostic code
/// (`E_TARGET_NOT_FOUND`, `E_MODULE_CONFLICT`...).
pub const BrokenOn = struct {
    horizon: []const u8,
    code: []const u8,
};

pub const Requirement = struct {
    id: []const u8,
    version: []const u8,
    sha256: []const u8,
};

pub const File = struct {
    name: []const u8,
    url: []const u8,
    size: u64,
    /// Lowercase hex.
    sha256: []const u8,
    /// The `.minisig` file's text.
    signature: ?[]const u8,
};

/// A file taken down: by hash, or every version of `id` when `sha256` is
/// None. The launcher refuses to install it and turns installed copies off.
pub const Revoked = struct {
    id: []const u8,
    sha256: ?[]const u8,
    reason: []const u8,
    date: []const u8,
};

/// How far a checked file is trusted.
pub const Trust = enum {
    /// Signed with the project's pinned key.
    Verified,
    /// The project has no key: only the hash pins it.
    Unsigned,
};

    // rust: impl Index {
    /// Parses and checks an index (see [`Index::check`]).
pub fn parse(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::parse_with(text, false)
}

    /// [`Index::parse`] for a local test registry, whose files may be
    /// `file://` paths (trying a registry out before it is published).
pub fn parse_local(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::parse_with(text, true)
}

pub fn parse_with(text: []const u8, local_files: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
pub const Head = struct {
    schema: u32,
};
    // rust: let head: Head = serde_json::from_str(text).map_err(|e| format!("not a mod index: {e}"))?;
    // rust: if head.schema > SCHEMA {
    // rust: return Err(format!(
    // rust: "the mod index is schema {}; this build reads {SCHEMA}: update Horizon",
    // rust: head.schema
    // rust: ));
}
    // rust: let index: Index = serde_json::from_str(text).map_err(|e| format!("mod index: {e}"))?;
    // rust: index.check_with(local_files)?;
    // rust: Ok(index)
}

    /// Every rule a reader relies on: unique valid ids, at least one
    /// version each, plain file names with the kind's extension, `https`
    /// URLs, hex hashes, keys and signatures that decode, and each
    /// modpack's mods present in the index with the same hash.
pub fn check(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.check_with(false)
}

pub fn check_with(self: *Self, local_files: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for (i, p) in self.projects.iter().enumerate() {
    // rust: let at = |e: String| format!("{}: {e}", p.id);
    // rust: if !valid_id(&p.id) {
    // rust: return Err(format!("project id {:?} is not [a-z0-9_]{{1,64}}", p.id));
}
    // rust: if self.projects[..i].iter().any(|q| q.id == p.id) {
    // rust: return Err(at("listed twice".into()));
}
    // rust: if p.name.trim().is_empty() || p.license.trim().is_empty() {
    // rust: return Err(at("needs a name and a licence".into()));
}
    // rust: https(&p.source).map_err(at)?;
    // rust: if let Some(icon) = &p.icon {
    // rust: https(icon).map_err(at)?;
}
    // rust: if p.screenshots.len() > page::MAX_SCREENSHOTS {
    // rust: return Err(at(format!(
    // rust: "{} screenshots, at most {}",
    // rust: p.screenshots.len(),
    // rust: page::MAX_SCREENSHOTS
    // rust: )));
}
    // rust: for s in &p.screenshots {
    // rust: https(s).map_err(at)?;
}
    // rust: if let Some(key) = &p.key {
    // rust: minisign_verify::PublicKey::from_base64(key.trim())
    // rust: .map_err(|e| at(format!("key: {e}")))?;
}
    // rust: if p.versions.is_empty() {
    // rust: return Err(at("has no version".into()));
}
    // rust: for (j, v) in p.versions.iter().enumerate() {
    // rust: let at = |e: String| format!("{} {}: {e}", p.id, v.version);
    // rust: if v.version.trim().is_empty()
    // rust: || p.versions[..j].iter().any(|w| w.version == v.version)
    // rust: {
    // rust: return Err(at("empty or repeated version".into()));
}
    // rust: let f = &v.file;
    // rust: let extension_ok = p
    // rust: .kind
    // rust: .extension()
    // rust: .is_none_or(|e| f.name.ends_with(&format!(".{e}")));
    // rust: if !plain_name(&f.name) || !extension_ok {
    // rust: return Err(at(format!(
    // rust: "{:?} is not a plain file name for a {}",
    // rust: f.name,
    // rust: p.kind.name()
    // rust: )));
}
    // rust: if !(local_files && f.url.starts_with("file:///")) {
    // rust: https(&f.url).map_err(at)?;
}
    // rust: hex64(&f.sha256).map_err(at)?;
    // rust: if f.size == 0 || f.size > MAX_FILE {
    // rust: return Err(at(format!(
    // rust: "size {} is not 1 byte to {} MiB",
    // rust: f.size,
    // rust: MAX_FILE >> 20
    // rust: )));
}
    // rust: match (&p.key, &f.signature) {
    // rust: (Some(_), None) => {
    // rust: return Err(at("unsigned, but the project has a key".into()));
}
    // rust: (None, Some(_)) => return Err(at("signed, but the project has no key".into())),
    // rust: (Some(_), Some(sig)) => {
    // rust: minisign_verify::Signature::decode(sig)
    // rust: .map_err(|e| at(format!("signature: {e}")))?;
}
    // rust: (None, None) => {}
}
    // rust: for r in &v.requires {
    // rust: let found = self
    // rust: .project(&r.id)
    // rust: .and_then(|q| q.versions.iter().find(|w| w.version == r.version));
    // rust: match found {
    // rust: Some(w) if w.file.sha256 == r.sha256 => {}
    // rust: Some(_) => {
    // rust: return Err(at(format!(
    // rust: "{} {}: another file than the index's",
    // rust: r.id, r.version
    // rust: )));
}
    // rust: None => {
    // rust: return Err(at(format!(
    // rust: "needs {} {}, which is not in the index",
    // rust: r.id, r.version
    // rust: )));
}
}
}
}
}
    // rust: for r in &self.revoked {
    // rust: if let Some(h) = &r.sha256 {
    // rust: hex64(h).map_err(|e| format!("revoked {}: {e}", r.id))?;
}
}
    // rust: Ok(())
}

    /// A project's newest version for Minecraft `game` that wasn't taken
    /// down and that a Horizon serving mod API `level` can run (an unknown
    /// level counts as runnable: the game still checks when it starts it).
    // rust: pub fn installable<'a>(
    // rust: &self,
    // rust: project: &'a Project,
    // rust: game: &str,
    // rust: level: u32,
    // rust: ) -> Option<&'a Version> {
    // rust: project.versions.iter().find(|v| {
    // rust: v.game == game
    // rust: && v.api_level.is_none_or(|l| l <= level)
    // rust: && self.revoked(&project.id, &v.file.sha256).is_none()
    // rust: })
}
pub fn project(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.projects.iter().find(|p| p.id == id)
}

    /// Why the file of `id` with this hash was taken down, if it was.
pub fn revoked(self: *Self, id: []const u8, sha256: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.revoked.iter().find(|r| {
    // rust: r.id == id
    // rust: && r.sha256
    // rust: .as_ref()
    // rust: .is_none_or(|h| h.eq_ignore_ascii_case(sha256))
    // rust: })
}
}

/// `[a-z0-9_]{1,64}`, the manifests' id rule.
pub fn valid_id(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (1..=64).contains(&id.len())
    // rust: && id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')
}

pub fn https(url: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match url.strip_prefix("https://") {
    // rust: Some(rest) if !rest.is_empty() && !url.chars().any(char::is_whitespace) => Ok(()),
    // rust: _ => Err(format!("{url:?} is not an https:// address")),
}
}

pub fn hex64(h: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if h.len() == 64
    // rust: && h.bytes()
    // rust: .all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b))
    // rust: {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("{h:?} is not a lowercase hex SHA-256"))
}
}

/// One plain file name: no folder, no hidden file, nothing a file system
/// reads as something else.
pub fn plain_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !name.is_empty()
    // rust: && name.len() <= 128
    // rust: && !name.starts_with('.')
    // rust: && name
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_alphanumeric() || b"._-+".contains(&b))
}

/// The SHA-256 of a file, lowercase hex.
pub fn sha256_file(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut hasher = Sha256::new();
    // rust: let mut buf = vec![0u8; 1 << 16];
    // rust: loop {
    // rust: let n = file.read(&mut buf).map_err(|e| e.to_string())?;
    // rust: if n == 0 {
    // rust: break;
}
    // rust: hasher.update(&buf[..n]);
}
    // rust: Ok(hex(&hasher.finalize()))
}

pub fn sha256(bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: hex(&Sha256::digest(bytes))
}

pub fn hex(bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bytes.iter().map(|b| format!("{b:02x}")).collect()
}

/// Checks a minisign signature (`.minisig` text) of `path` against `key`.
pub fn verify_signature(key: []const u8, signature: []const u8, path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key =
    // rust: minisign_verify::PublicKey::from_base64(key.trim()).map_err(|e| format!("key: {e}"))?;
    // rust: let sig =
    // rust: minisign_verify::Signature::decode(signature).map_err(|e| format!("signature: {e}"))?;
    // rust: let file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut verifier = key
    // rust: .verify_stream(&sig)
    // rust: .map_err(|e| format!("signature: {e}"))?;
    // rust: let mut reader = std::io::BufReader::new(file);
    // rust: let mut buf = vec![0u8; 1 << 16];
    // rust: loop {
    // rust: let n = reader.read(&mut buf).map_err(|e| e.to_string())?;
    // rust: if n == 0 {
    // rust: break;
}
    // rust: verifier.update(&buf[..n]);
}
    // rust: verifier
    // rust: .finalize()
    // rust: .map_err(|_| "the signature doesn't match the project's key".to_string())
}

/// Checks the file at `path` against its entry before it is installed:
/// size, SHA-256, revocation, signature, and that its manifest says what the
/// index says (id, version, API, side, capabilities; a modpack's mods).
    // rust: pub fn check_file(
    // rust: index: &Index,
    // rust: project: &Project,
    // rust: version: &Version,
    // rust: path: &Path,
    // rust: ) -> Result<Trust, String> {
    // rust: let size = std::fs::metadata(path)
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?
    // rust: .len();
    // rust: if size != version.file.size {
    // rust: return Err(format!(
    // rust: "{} bytes, the index lists {}",
    // rust: size, version.file.size
    // rust: ));
}
    // rust: let hash = sha256_file(path)?;
    // rust: if hash != version.file.sha256 {
    // rust: return Err("its SHA-256 isn't the one the index lists: nothing was installed".into());
}
    // rust: if let Some(r) = index.revoked(&project.id, &hash) {
    // rust: return Err(format!("{} was taken down: {}", project.name, r.reason));
}
    // rust: let trust = match (&project.key, &version.file.signature) {
    // rust: (Some(key), Some(sig)) => {
    // rust: verify_signature(key, sig, path)?;
    // rust: Trust::Verified
}
    // rust: (None, None) => Trust::Unsigned,
    // rust: _ => return Err("its signature and the project's key don't go together".into()),
}
    // rust: if matches!(project.kind, Kind::Other(_)) {
    // rust: return Err(format!(
    // rust: "this Horizon can't install a {} yet",
    // rust: project.kind.name()
    // rust: ));
}
    // rust: inspect(&project.kind, path)?.matches(project, version)?;
    // rust: Ok(trust)
}

/// What a file says about itself, read by its kind's own check
/// ([`inspect`]). The registry's CI writes these into the index; the
/// launcher compares them with the index before it installs.
pub const Facts = struct {
    /// A mod's or a modpack's manifest id; None for a resource pack.
    id: ?[]const u8,
    version: ?[]const u8,
    /// A mod's API line, a modpack's format, a resource pack's pack format.
    api: []const u8,
    side: ?Side,
    /// In the manifest's order.
    capabilities: std.ArrayList(Capability),
    /// The mod API level a mod's code needs, from the functions it imports.
    api_level: ?u32,
    /// A native mod's hook points version.
    hooks: ?u32,
    /// The Minecraft version, when the file names one (a modpack does).
    game: ?[]const u8,
    requires: std.ArrayList(Requirement),
};

    // rust: impl Facts {
    /// Whether the file is the one `version` of `project` describes.
pub fn matches(self: *Self, project: *Project, version: *Version) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut caps, mut listed) = (self.capabilities.clone(), version.capabilities.clone());
    // rust: caps.sort();
    // rust: listed.sort();
    // rust: let differs = self.id.as_ref().is_some_and(|id| *id != project.id)
    // rust: || self.version.as_ref().is_some_and(|v| *v != version.version)
    // rust: || self.api != version.api
    // rust: || self.side != version.side
    // rust: || caps != listed
    // rust: || version.api_level.is_some() && self.api_level != version.api_level
    // rust: || version.hooks.is_some() && self.hooks != version.hooks
    // rust: || self.game.as_ref().is_some_and(|g| *g != version.game)
    // rust: || self.requires != version.requires;
    // rust: if !differs {
    // rust: return Ok(());
}
    // rust: Err(match project.kind {
    // rust: Kind::Mod => format!(
    // rust: "its horizon-mod.toml ({} {}, API {}, {:?}, {}) isn't what the index lists",
    // rust: self.id.as_deref().unwrap_or("?"),
    // rust: self.version.as_deref().unwrap_or("?"),
    // rust: self.api,
    // rust: self.side,
    // rust: names(&self.capabilities)
    // rust: ),
    // rust: Kind::Modpack => format!("its {} isn't what the index lists", modpack::MANIFEST),
    // rust: Kind::Shader => format!(
    // rust: "its {} ({} {}, shader API {}) isn't what the index lists",
    // rust: horizon_shader_api::MANIFEST,
    // rust: self.id.as_deref().unwrap_or("?"),
    // rust: self.version.as_deref().unwrap_or("?"),
    // rust: self.api
    // rust: ),
    // rust: _ => format!("its pack format {} isn't what the index lists", self.api),
    // rust: })
}
}

/// Reads and checks a file as its kind: a mod's manifest and content, a
/// modpack's manifest and overrides, a resource pack's `pack.mcmeta` and
/// paths, a shader pack's `horizon_shader_api::check` (the game's own). Kinds
/// this build doesn't know are refused: their checks come with their formats.
pub fn inspect(kind: *Kind, path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: Kind::NativeMod => {
    // rust: let facts = native::Bundle::read(path)?.manifest.facts();
            // A `.hmod` with content too: checked as the game reads it.
    // rust: if Package::has_manifest(path) {
    // rust: let m = Package::read(path)?.manifest;
    // rust: crate::Content::read(path, &m)?;
}
    // rust: Ok(facts)
}
    // rust: Kind::Mod => {
    // rust: if native::holds(path) {
    // rust: return Err(format!(
    // rust: "it has native code ({}): it is a native-mod",
    // rust: native::MANIFEST
    // rust: ));
}
    // rust: let Package { manifest: m, wasm } = Package::read(path)?;
    // rust: crate::Content::read(path, &m)?;
    // rust: let api_level = match wasm {
    // rust: Some(wasm) => {
    // rust: let functions = crate::api_level::imports(&wasm)?;
    // rust: Some(crate::api_level::needed(functions.iter().map(String::as_str)).0)
}
    // rust: None => None,
}
    // rust: Ok(Facts {
    // rust: api_level,
    // rust: capabilities: m.capabilities,
    // rust: id: Some(m.id),
    // rust: version: Some(m.version),
    // rust: api: m.api,
    // rust: side: Some(m.side),
    // rust: ..Facts::default()
    // rust: })
}
    // rust: Kind::Modpack => {
    // rust: let m = Modpack::read(path)?.manifest;
    // rust: Ok(Facts {
    // rust: requires: m.mods.iter().map(modpack::PackMod::requirement).collect(),
    // rust: id: Some(m.id),
    // rust: version: Some(m.version),
    // rust: api: m.format.to_string(),
    // rust: game: Some(m.game),
    // rust: ..Facts::default()
    // rust: })
}
    // rust: Kind::ResourcePack => Ok(Facts {
    // rust: api: check_resource_pack(path)?,
    // rust: ..Facts::default()
    // rust: }),
    // rust: Kind::Shader => {
    // rust: let pack = horizon_shader_api::Pack::read(path)?;
    // rust: if let Err(problems) = horizon_shader_api::check(&pack) {
    // rust: let lines: Vec<String> = problems.iter().map(ToString::to_string).collect();
    // rust: return Err(format!(
    // rust: "the shader pack fails its check:\n{}",
    // rust: lines.join("\n")
    // rust: ));
}
    // rust: let m = pack.manifest;
            // Players get only what the game draws without a switch, and a line that may
            // still change in any release would break the packs listed for it.
    // rust: if m.api != horizon_shader_api::Api::V0_1 {
    // rust: return Err(format!(
    // rust: "it is written for shader API {}, which is experimental: the registry takes \
    // rust: such packs once the game draws them without a switch",
    // rust: m.api
    // rust: ));
}
    // rust: Ok(Facts {
    // rust: id: Some(m.id),
    // rust: version: Some(m.version),
    // rust: api: m.api.to_string(),
    // rust: ..Facts::default()
    // rust: })
}
    // rust: Kind::ShaderPack => Ok(Facts {
    // rust: api: check_shader_folder_pack(path)?,
    // rust: ..Facts::default()
    // rust: }),
    // rust: Kind::DataPack => Ok(Facts {
    // rust: api: check_data_pack(path)?,
    // rust: ..Facts::default()
    // rust: }),
    // rust: Kind::Other(name) => Err(format!("this Horizon can't read a {name} yet")),
}
}

/// A resource pack: a zip with `pack.mcmeta` at its root holding a `pack`
/// object, and only plain paths. Returns its pack format (`pack_format`, or
/// `min_format` in newer packs), empty when it names none.
pub fn check_resource_pack(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut zip, _) = plain_zip(path)?;
    // rust: pack_format(&mut zip)
}

/// A zip whose paths are all plain, and those paths.
pub fn plain_zip(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| e.to_string())?;
    // rust: let mut names = Vec::with_capacity(zip.len());
    // rust: for i in 0..zip.len() {
    // rust: let name = zip
    // rust: .by_index_raw(i)
    // rust: .map_err(|e| e.to_string())?
    // rust: .name()
    // rust: .map_err(|e| e.to_string())?
    // rust: .into_owned();
    // rust: if name.starts_with('/') || name.split('/').any(|part| part == "..") || name.contains('\\')
    // rust: {
    // rust: return Err(format!("{name:?} is not a plain path"));
}
    // rust: names.push(name);
}
    // rust: Ok((zip, names))
}

/// A data pack: a resource pack's rules, and a `data/` folder at the root.
pub fn check_data_pack(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut zip, names) = plain_zip(path)?;
    // rust: if !names.iter().any(|n| n.starts_with("data/")) {
    // rust: return Err("no data/ folder at the zip's root: not a data pack".into());
}
    // rust: pack_format(&mut zip)
}

/// A `shaders/`-folder shader pack: plain paths and a `shaders/` folder at the root. Its format
/// has no version of its own: the facts' `api` is empty.
pub fn check_shader_folder_pack(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (_, names) = plain_zip(path)?;
    // rust: if !names.iter().any(|n| n.starts_with("shaders/")) {
    // rust: return Err("no shaders/ folder at the zip's root: not a shader pack".into());
}
    // rust: Ok(String::new())
}

/// What a zip's file is, by its content: a `shaders/` folder makes a shader pack, a `data/` folder
/// without `assets/` a data pack, anything else a resource pack (checked as one).
pub fn zip_kind(path: *Path) K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok((_, names)) = plain_zip(path) else {
    // rust: return Kind::ResourcePack;
}
    // rust: let root = |dir: &str| names.iter().any(|n| n.starts_with(dir));
    // rust: if root("shaders/") {
    // rust: Kind::ShaderPack
    // rust: } else if root("data/") && !root("assets/") {
    // rust: Kind::DataPack
    // rust: } else {
    // rust: Kind::ResourcePack
}
}

/// `pack.mcmeta`'s pack format (`pack_format`, or `min_format` in newer packs), empty when it
/// names none; refused when it has no `pack` object.
pub fn pack_format(zip: *mut zip::ZipArchive<std::fs::File>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut meta = String::new();
    // rust: zip.by_name("pack.mcmeta")
    // rust: .map_err(|_| "pack.mcmeta: missing".to_string())?
    // rust: .take(1 << 20)
    // rust: .read_to_string(&mut meta)
    // rust: .map_err(|e| format!("pack.mcmeta: {e}"))?;
    // rust: let json: serde_json::Value =
    // rust: serde_json::from_str(&meta).map_err(|e| format!("pack.mcmeta: {e}"))?;
    // rust: let pack = &json["pack"];
    // rust: if !pack.is_object() {
    // rust: return Err("pack.mcmeta: no \"pack\" object".into());
}
    // rust: let format = [&pack["pack_format"], &pack["min_format"]]
    // rust: .into_iter()
    // rust: .find(|f| !f.is_null())
    // rust: .map(|f| match f {
    // rust: serde_json::Value::Array(parts) => parts
    // rust: .iter()
    // rust: .map(ToString::to_string)
    // rust: .collect::<Vec<_>>()
    // rust: .join("."),
    // rust: other => other.to_string(),
    // rust: })
    // rust: .unwrap_or_default();
    // rust: Ok(format)
}

/// The kinds the registry takes submissions for; other kinds wait for their
/// formats.
pub fn open(kind: *Kind) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: Kind::Mod
    // rust: | Kind::NativeMod
    // rust: | Kind::Modpack
    // rust: | Kind::ResourcePack
    // rust: | Kind::Shader
    // rust: | Kind::ShaderPack
    // rust: | Kind::DataPack => Ok(()),
    // rust: Kind::Other(name) => Err(format!("the registry doesn't take {name} yet")),
}
}

pub fn names(caps: *[Capability]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names: Vec<String> = caps.iter().map(ToString::to_string).collect();
    // rust: format!("[{}]", names.join(", "))
}

    // rust: pub mod native;
    // rust: pub mod page;
    // rust: pub mod registry;
    // rust: mod tests;
