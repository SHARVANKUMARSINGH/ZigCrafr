//! Transpiled from Horizon Rust crate
package horizon_client_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Installing from a local test registry: a real content `.hmod`, an index
// naming it, and the game folder the launcher shares.
// use super::*;

scratch :: proc(name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-mod-registry-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

// A content mod `ruby` at `version`: a manifest and one lang file.
ruby :: proc(version: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let manifest = format!(
    // rust: "id = \"ruby\"\nname = \"Ruby\"\nversion = \"{version}\"\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n"
    // rust: );
    // rust: horizon_mods::Package::write_files(
    // rust: &manifest,
    // rust: None,
    // rust: &[(
    // rust: "assets/ruby/lang/en_us.json",
    // rust: br#"{"item.ruby.ruby": "Ruby"}"#,
    // rust: )],
    // rust: )
    // rust: .unwrap()
}

// A registry listing `ruby` at `version` with these bytes (the file at
// `url`), and a native mod and a mod for another Minecraft version that the
// game doesn't offer.
registry :: proc(version: string, bytes: []u8, url: string) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let file = |name: &str, size: usize, sha: String| serde_json::json!({ "name": name, "url": url, "size": size, "sha256": sha });
    // rust: let ruby = serde_json::json!({
    // rust: "id": "ruby", "kind": "mod", "name": "Ruby", "summary": "Rubies",
    // rust: "description": "# Ruby\nGems.", "authors": ["someone"], "license": "MIT",
    // rust: "source": "https://github.com/someone/ruby", "categories": ["decoration"],
    // rust: "tags": ["gems"], "downloads": 5,
    // rust: "versions": [{ "version": version, "published": "2026-11-05", "api": "0.2",
    // rust: "side": "both", "capabilities": ["registries"], "game": crate::mod_registry::GAME,
    // rust: "file": file(&format!("ruby-{version}.hmod"), bytes.len(), index::sha256(bytes)) }]
    // rust: });
    // rust: let old = serde_json::json!({
    // rust: "id": "old", "kind": "mod", "name": "Old", "summary": "For 1.21",
    // rust: "license": "MIT", "source": "https://github.com/someone/old",
    // rust: "versions": [{ "version": "1", "api": "0.2", "game": "1.21.1",
    // rust: "capabilities": ["registries"],
    // rust: "file": file("old-1.hmod", 1, "a".repeat(64)) }]
    // rust: });
    // rust: let native = serde_json::json!({
    // rust: "id": "zoom", "kind": "native-mod", "name": "Zoom", "summary": "Zoom",
    // rust: "license": "MIT", "source": "https://github.com/someone/zoom", "downloads": 99,
    // rust: "versions": [{ "version": "1", "api": "0.2", "game": crate::mod_registry::GAME,
    // rust: "file": file("zoom-1.hnmod", 1, "b".repeat(64)) }]
    // rust: });
    // rust: let text = serde_json::json!({ "schema": 1, "projects": [ruby, old, native] }).to_string();
    // rust: Index::parse_local(&text).unwrap()
}

serve :: proc(bytes: [dynamic]u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: move |_, max| match bytes.len() as u64 <= max {
    // rust: true => Ok(bytes.clone()),
    // rust: false => Err("too large".into()),
}
}

the_browser_lists_only_content_mods_for_this_game :: proc() {
}
    // rust: let bytes = ruby("1.0");
    // rust: let index = registry("1.0", &bytes, "file:///ruby.hmod");
    // rust: let home = scratch("list");
    // rust: let listed = listings(&index, &home);
    // rust: let ids: Vec<&str> = listed.iter().map(|l| l.id.as_str()).collect();
    // rust: assert_eq!(ids, ["ruby"], "no native mod, no mod for another version");
    // rust: assert_eq!(listed[0].version, "1.0");
    // rust: assert_eq!(listed[0].page, "https://playhorizon.dev/mods/ruby");
    // rust: assert_eq!(listed[0].installed, None);
    // rust: fs::remove_dir_all(&home).unwrap();
}

an_install_is_checked_then_recorded_as_the_launchers_own :: proc() {
}
    // rust: let bytes = ruby("1.0");
    // rust: let index = registry("1.0", &bytes, "file:///ruby.hmod");
    // rust: let home = scratch("install");
    // An entry of the launcher's this game doesn't model stays as it was.
    // rust: let theirs = serde_json::json!({ "entries": [{ "source": "modrinth", "project": "abc",
    // rust: "slug": "faithful", "title": "Faithful", "kind": "resource-pack", "version": "1",
    // rust: "number": "1", "file": "resourcepacks/faithful.zip", "checksum": "SHA-512:00",
    // rust: "page": "https://modrinth.com/resourcepack/faithful" }] });
    // rust: fs::write(home.join(MANIFEST), theirs.to_string()).unwrap();

    // rust: let done = install(&index, &home, "ruby", &serve(bytes.clone())).unwrap();
    // rust: assert_eq!(done.version, "1.0");
    // rust: assert!(!done.verified, "the sample isn't signed");
    // rust: let path = home.join("horizon-mods/ruby.hmod");
    // rust: assert_eq!(fs::read(&path).unwrap(), bytes);
    // rust: assert_eq!(
    // rust: horizon_mods::Package::read(&path).unwrap().manifest.id,
    // rust: "ruby"
    // rust: );
    // rust: let record: serde_json::Value =
    // rust: serde_json::from_str(&fs::read_to_string(home.join(MANIFEST)).unwrap()).unwrap();
    // rust: let entries = record["entries"].as_array().unwrap();
    // rust: assert_eq!(entries.len(), 2);
    // rust: assert_eq!(entries[0]["slug"], "faithful");
    // rust: assert_eq!(entries[1]["source"], "horizon");
    // rust: assert_eq!(entries[1]["file"], "horizon-mods/ruby.hmod");
    // rust: assert_eq!(entries[1]["verdict"], "Unsigned");
    // rust: assert_eq!(listings(&index, &home)[0].installed.as_deref(), Some("1.0"));

    // An update replaces the file and the entry.
    // rust: let newer = ruby("1.1");
    // rust: let index = registry("1.1", &newer, "file:///ruby.hmod");
    // rust: assert!(listings(&index, &home)[0].has_update());
    // rust: install(&index, &home, "ruby", &serve(newer.clone())).unwrap();
    // rust: assert_eq!(fs::read(&path).unwrap(), newer);
    // rust: let record: serde_json::Value =
    // rust: serde_json::from_str(&fs::read_to_string(home.join(MANIFEST)).unwrap()).unwrap();
    // rust: assert_eq!(record["entries"].as_array().unwrap().len(), 2);
    // rust: assert_eq!(record["entries"][1]["version"], "1.1");
    // rust: fs::remove_dir_all(&home).unwrap();
}

bytes_other_than_the_index_lists_never_reach_the_mods_folder :: proc() {
}
    // rust: let bytes = ruby("1.0");
    // rust: let index = registry("1.0", &bytes, "file:///ruby.hmod");
    // rust: let home = scratch("tampered");
    // rust: let mut tampered = bytes.clone();
    // rust: *tampered.last_mut().unwrap() ^= 1;
    // rust: let error = install(&index, &home, "ruby", &serve(tampered)).unwrap_err();
    // rust: assert!(error.contains("SHA-256"), "{error}");
    // rust: assert!(!home.join("horizon-mods/ruby.hmod").exists());
    // rust: assert!(!home.join("mod-browser/downloads/ruby.hmod.part").exists());
    // rust: assert!(!home.join(MANIFEST).exists());
    // A taken-down file is refused before anything is downloaded.
    // rust: let mut index = index;
    // rust: index.revoked.push(index::Revoked {
    // rust: id: "ruby".into(),
    // rust: sha256: Some(index::sha256(&bytes)),
    // rust: reason: "bad".into(),
    // rust: date: "2026-11-05".into(),
    // rust: });
    // rust: assert!(install(&index, &home, "ruby", &serve(bytes)).is_err());
    // rust: assert!(!home.join("horizon-mods/ruby.hmod").exists());
    // rust: fs::remove_dir_all(&home).unwrap();
}

a_mod_the_player_put_there_is_never_replaced :: proc() {
}
    // rust: let bytes = ruby("1.0");
    // rust: let index = registry("1.0", &bytes, "file:///ruby.hmod");
    // rust: let home = scratch("theirs");
    // rust: fs::create_dir_all(home.join("horizon-mods")).unwrap();
    // rust: fs::write(home.join("horizon-mods/ruby.hmod"), b"their own").unwrap();
    // rust: let error = install(&index, &home, "ruby", &serve(bytes)).unwrap_err();
    // rust: assert!(error.contains("already in horizon-mods"), "{error}");
    // rust: assert_eq!(
    // rust: fs::read(home.join("horizon-mods/ruby.hmod")).unwrap(),
    // rust: b"their own"
    // rust: );
    // rust: fs::remove_dir_all(&home).unwrap();
}
