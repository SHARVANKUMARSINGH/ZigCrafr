//! Transpiled from Horizon Rust crate
//! Module: cargo-horizon-mod_check
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `cargo horizon-mod check <file>`: what the registry checks of a submission,
//! run anywhere: its kind's own checks (docs/api/mod-index.md), its signature
//! when given a key, and for a `.hmod` that it is content only.
// use horizon_mods::{
    // rust: Package,
    // rust: index::{self, Facts, Kind},
}
// use serde_json::{Value, json};
// use std::path::Path;

pub const Report = struct {
    kind: Kind,
    facts: Facts,
    sha256: []const u8,
    size: u64,
    signed: bool,
};

    // rust: impl Report {
pub fn json(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let requires: Vec<Value> = self
    // rust: .facts
    // rust: .requires
    // rust: .iter()
    // rust: .map(|r| json!({"id": r.id, "version": r.version, "sha256": r.sha256}))
    // rust: .collect();
    // rust: json!({
    // rust: "kind": self.kind.name(),
    // rust: "id": self.facts.id,
    // rust: "version": self.facts.version,
    // rust: "api": self.facts.api,
    // rust: "side": self.facts.side,
    // rust: "capabilities": self.facts.capabilities,
    // rust: "api_level": self.facts.api_level,
    // rust: "game": self.facts.game,
    // rust: "requires": requires,
    // rust: "sha256": self.sha256,
    // rust: "size": self.size,
    // rust: "signed": self.signed,
    // rust: })
}

pub fn text(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = &self.facts;
    // rust: let mut out = format!(
    // rust: "{} {} ({}",
    // rust: f.id.as_deref().unwrap_or("resource pack"),
    // rust: f.version.as_deref().unwrap_or(""),
    // rust: self.kind.name()
    // rust: );
    // rust: if let Some(side) = f.side {
    // rust: let side = serde_json::to_value(side).unwrap_or_default();
    // rust: out += &format!(", API {}, {}", f.api, side.as_str().unwrap_or("?"));
    // rust: } else if self.kind == Kind::Shader {
    // rust: out += &format!(", shader API {}", f.api);
    // rust: } else if !f.api.is_empty() {
    // rust: out += &format!(", format {}", f.api);
}
    // rust: if let Some(game) = &f.game {
    // rust: out += &format!(", for {game}");
}
    // rust: let signed = if self.signed {
    // rust: "signature verified"
    // rust: } else {
    // rust: "unsigned"
}
    // rust: out += &format!(
    // rust: ")\n  {} bytes, SHA-256 {}, {signed}\n",
    // rust: self.size, self.sha256
    // rust: );
    // rust: if let Some(level) = f.api_level {
    // rust: out += &format!("  needs mod API level {level} or newer\n");
}
    // rust: for c in &f.capabilities {
    // rust: out += &format!("  may {}\n", c.describe());
}
    // rust: for r in &f.requires {
    // rust: out += &format!("  needs {} {} ({})\n", r.id, r.version, &r.sha256[..12]);
}
    // rust: if self.kind == Kind::NativeMod {
    // rust: out += "  native source: unsandboxed; not executed by the registry check. Compile and test against the exact pinned Horizon and Mixins revisions before review.\n";
}
    // rust: if self.kind == Kind::Mod {
    // rust: out += "  no code: content only, nothing to run\n";
}
    // rust: out
}
}

/// The kind a file's extension says.
pub fn kind_of(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match path.extension()?.to_str()? {
    // rust: "hmod" => Some(Kind::Mod),
    // rust: "hnmod" => Some(Kind::NativeMod),
    // rust: "hpack" => Some(Kind::Modpack),
    // rust: "zip" => Some(horizon_mods::index::zip_kind(path)),
    // rust: "hshader" => Some(Kind::Shader),
    // rust: _ => None,
}
}

/// Checks the file at `path` as `kind`; `key` and `signature` (the
/// `.minisig` text) check its signature.
    // rust: pub fn check(
    // rust: path: &Path,
    // rust: kind: Kind,
    // rust: key: Option<&str>,
    // rust: signature: Option<&str>,
    // rust: ) -> Result<Report, String> {
    // rust: let size = std::fs::metadata(path)
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?
    // rust: .len();
    // rust: if size > index::MAX_FILE {
    // rust: return Err(format!("over {} MiB", index::MAX_FILE >> 20));
}
    // rust: index::open(&kind)?;
    // rust: let facts = index::inspect(&kind, path)?;
    // rust: let signed = match (key, signature) {
    // rust: (Some(key), Some(sig)) => {
    // rust: index::verify_signature(key, sig, path)?;
    // rust: true
}
    // rust: (None, None) => false,
    // rust: _ => return Err("--key and --signature go together".into()),
}
    // rust: if kind == Kind::Mod {
    // rust: content_only(path)?;
}
    // rust: Ok(Report {
    // rust: kind,
    // rust: facts,
    // rust: sha256: index::sha256_file(path)?,
    // rust: size,
    // rust: signed,
    // rust: })
}

/// A mod is content only: WebAssembly code mods don't run any more, code mods are native
/// (`.hnmod`, docs/native-mods.md). `inspect` already read its content as the game does.
pub fn content_only(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match Package::read(path)?.wasm {
    // rust: Some(_) => Err(
    // rust: "it has WebAssembly code, which Horizon doesn't run any more: make it a native mod (docs/native-mods.md)"
    // rust: .into(),
    // rust: ),
    // rust: None => Ok(()),
}
}

    // rust: mod tests {
//     use super::*;

pub fn fixture(name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../horizon-mods/tests/index")
    // rust: .join(name)
}

pub fn checks_each_kind_its_own_way() void {
}
    // rust: let pack = fixture("cozy-1.0.0.hpack");
    // rust: let report = check(&pack, kind_of(&pack).unwrap(), None, None).unwrap();
    // rust: assert_eq!(report.facts.requires[0].id, "coords_hud");
    // rust: assert!(
    // rust: report
    // rust: .text()
    // rust: .contains("cozy 1.0.0 (modpack, format 1, for 26.3)")
    // rust: );
        // A mod with WebAssembly code is refused: code mods are native.
    // rust: let hmod = fixture("coords_hud-0.1.0.hmod");
    // rust: let key = std::fs::read_to_string(fixture("test.pub")).unwrap();
    // rust: let sig = std::fs::read_to_string(fixture("coords_hud-0.1.0.hmod.minisig")).unwrap();
    // rust: let key = key.lines().last().unwrap();
    // rust: let e = check(&hmod, Kind::Mod, Some(key), Some(&sig))
    // rust: .err()
    // rust: .unwrap();
    // rust: assert!(e.contains("native mod"), "{e}");
    // rust: let e = check(
    // rust: &hmod,
    // rust: Kind::Mod,
    // rust: Some(key),
    // rust: Some("untrusted comment: x\nRUQ=\n"),
    // rust: )
    // rust: .err()
    // rust: .unwrap();
    // rust: assert!(e.contains("signature"), "{e}");
    // rust: let e = check(&pack, Kind::Shader, None, None).err().unwrap();
    // rust: assert!(e.contains("horizon-shaders.toml"), "{e}");
    // rust: assert!(check(&pack, Kind::Mod, None, None).is_err());
}
}
