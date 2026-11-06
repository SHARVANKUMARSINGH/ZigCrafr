//! Transpiled from Horizon Rust crate
package horizon_port_pack_modrinth

import "core:fmt"
import "core:mem"
import "core:math"

// Modrinth metadata for the pack's files: the version of each file by
// SHA-1, and its project (categories, licence, sides). Only metadata (the
// jars are `fetch`'s). Answers are cached in `<work>/modrinth.json`, so a
// rerun works offline.
// use serde::{Deserialize, Serialize};
// use serde_json::Value;
// use std::{collections::BTreeMap, path::Path};

API :: "https://api.modrinth.com/v2"
    // rust: pub(crate) const AGENT: &str = "horizon-rust/horizon horizon-port-pack/0.1 (docs/modpacks.md)";

Cache :: struct {
    // Version objects by file SHA-1.
    versions: BTreeMap<string,
    // Project objects by project id.
    projects: BTreeMap<string,
}

    // rust: impl Cache {
load :: proc(path: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: std::fs::read_to_string(path)
    // rust: .ok()
    // rust: .and_then(|t| serde_json::from_str(&t).ok())
    // rust: .unwrap_or_default()
}

    // Ask Modrinth about the hashes and projects not cached yet.
fetch :: proc(self: ^Self, hashes: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let missing: Vec<&String> = hashes
    // rust: .iter()
    // rust: .filter(|h| !self.versions.contains_key(*h))
    // rust: .collect();
    // rust: for chunk in missing.chunks(500) {
    // rust: let body = serde_json::json!({"hashes": chunk, "algorithm": "sha1"});
    // rust: let found = post(&format!("{API}/version_files"), &body)?;
    // rust: for (hash, version) in found.as_object().into_iter().flatten() {
    // rust: self.versions.insert(hash.clone(), version.clone());
}
}
    // rust: let mut ids: Vec<String> = self
    // rust: .versions
    // rust: .values()
    // rust: .filter_map(|v| v["project_id"].as_str().map(str::to_owned))
    // rust: .filter(|id| !self.projects.contains_key(id))
    // rust: .collect();
    // rust: ids.sort();
    // rust: ids.dedup();
    // rust: for chunk in ids.chunks(100) {
    // rust: let list = serde_json::to_string(chunk).unwrap_or_default();
    // rust: let found = get(&format!("{API}/projects?ids={}", encode(&list)))?;
    // rust: for project in found.as_array().into_iter().flatten() {
    // rust: if let Some(id) = project["id"].as_str() {
    // rust: self.projects.insert(id.to_owned(), project.clone());
}
}
}
    // rust: Ok(())
}

project_of :: proc(self: ^Self, sha1: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.versions.get(sha1)?["project_id"].as_str()?;
    // rust: self.projects.get(id)
}

    // Required dependencies of a file's version, as project ids.
required :: proc(self: ^Self, sha1: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(v) = self.versions.get(sha1) else {
    // rust: return Vec::new();
}
    // rust: v["dependencies"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|d| d["dependency_type"] == "required")
    // rust: .filter_map(|d| d["project_id"].as_str().map(str::to_owned))
    // rust: .collect()
}
}

post :: proc(url: string, body: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let response = crate::net::agent(url)
    // rust: .post(url)
    // rust: .set("User-Agent", AGENT)
    // rust: .set("Content-Type", "application/json")
    // rust: .send_string(&body.to_string())
    // rust: .map_err(|e| format!("{url}: {e}"))?;
    // rust: read(url, response)
}

get :: proc(url: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let response = crate::net::agent(url)
    // rust: .get(url)
    // rust: .set("User-Agent", AGENT)
    // rust: .call()
    // rust: .map_err(|e| format!("{url}: {e}"))?;
    // rust: read(url, response)
}

read :: proc(url: string, response: ureq::Response) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = response.into_string().map_err(|e| format!("{url}: {e}"))?;
    // rust: serde_json::from_str(&text).map_err(|e| format!("{url}: {e}"))
}

// Percent-encoding for a query value.
encode :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: s.bytes()
    // rust: .map(|b| match b {
    // rust: b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'_' | b'.' | b'~' => {
    // rust: (b as char).to_string()
}
    // rust: _ => format!("%{b:02X}"),
    // rust: })
    // rust: .collect()
}
