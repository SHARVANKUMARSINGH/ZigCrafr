//! Transpiled from Horizon Rust crate
package horizon_mods_tests

import "core:fmt"
import "core:mem"
import "core:math"

// The sample index (`tests/index/index-v1.json`, the one docs/api/mod-index.md
// shows) and its files: `coords_hud-0.1.0.hmod`, signed with the throwaway
// key `test.pub` by minisign 0.12 (its secret key was deleted),
// `cozy-1.0.0.hpack`, unsigned, and `glow-1.0.0.hshader`, unsigned
// (`horizon-shader new --template post`, then `horizon-shader pack`).
// use super::*;
// use std::path::PathBuf;

OTHER_KEY :: "RWSe8ZD+cTOAqNd/jnXTmDtoKp0c0HxkGMrBBWcWQeEkPmcHB+XkaE9S"

fixtures :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/index")
}

sample :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: Index::parse(&std::fs::read_to_string(fixtures().join("index-v1.json")).unwrap()).unwrap()
}

check :: proc(index: ^Index, id: string, file: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let p = index.project(id).unwrap();
    // rust: check_file(index, p, &p.versions[0], file)
}

reads_the_sample_and_keeps_unknown_kinds :: proc() {
}
    // rust: let index = sample();
    // rust: assert_eq!(index.schema, SCHEMA);
    // rust: let kinds: Vec<&str> = index.projects.iter().map(|p| p.kind.name()).collect();
    // rust: assert_eq!(kinds, ["mod", "modpack", "shader", "world"]);
    // rust: assert_eq!(index.projects[3].kind, Kind::Other("world".into()));
    // rust: let hud = index.project("coords_hud").unwrap();
    // rust: assert_eq!(
    // rust: hud.versions[0].capabilities,
    // rust: [Capability::GameRead, Capability::Hud, Capability::Chat]
    // rust: );
    // What CI writes reads back the same.
    // rust: let text = serde_json::to_string(&index).unwrap();
    // rust: let again = Index::parse(&text).unwrap();
    // rust: assert_eq!(again, index);
    // Download counts: the publish job adds them; none is left out.
    // rust: assert_eq!(hud.downloads, 0);
    // rust: assert!(!text.contains("downloads"));
    // rust: let counted = text.replacen("\"versions\"", "\"downloads\":12345,\"versions\"", 1);
    // rust: assert_eq!(Index::parse(&counted).unwrap().projects[0].downloads, 12345);
    // GitHub stars: the same, the source repository's.
    // rust: assert_eq!(hud.stars, 0);
    // rust: assert!(!text.contains("\"stars\""));
    // rust: let starred = text.replacen("\"versions\"", "\"stars\":42,\"versions\"", 1);
    // rust: assert_eq!(Index::parse(&starred).unwrap().projects[0].stars, 42);
}

files_pass_against_their_entries :: proc() {
}
    // rust: let index = sample();
    // rust: let hmod = fixtures().join("coords_hud-0.1.0.hmod");
    // rust: assert_eq!(check(&index, "coords_hud", &hmod), Ok(Trust::Verified));
    // rust: let hpack = fixtures().join("cozy-1.0.0.hpack");
    // rust: assert_eq!(check(&index, "cozy", &hpack), Ok(Trust::Unsigned));
    // rust: let hshader = fixtures().join("glow-1.0.0.hshader");
    // rust: assert_eq!(check(&index, "glow", &hshader), Ok(Trust::Unsigned));
    // rust: let world = index.project("skyblock_start").unwrap();
    // rust: let e = check_file(&index, world, &world.versions[0], &hpack).unwrap_err();
    // rust: assert!(e.contains("bytes"), "{e}");
}

a_changed_file_key_or_manifest_is_refused :: proc() {
}
    // rust: let index = sample();
    // rust: let dir = std::env::temp_dir().join(format!("horizon-index-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let hmod = fixtures().join("coords_hud-0.1.0.hmod");
    // rust: let mut bytes = std::fs::read(&hmod).unwrap();
    // rust: let last = bytes.len() - 1;
    // rust: bytes[last] ^= 1;
    // rust: let tampered = dir.join("coords_hud-0.1.0.hmod");
    // rust: std::fs::write(&tampered, &bytes).unwrap();
    // rust: let e = check(&index, "coords_hud", &tampered).unwrap_err();
    // rust: assert!(e.contains("SHA-256"), "{e}");

    // rust: let mut other_key = index.clone();
    // rust: other_key.projects[0].key = Some(OTHER_KEY.into());
    // rust: let e = check(&other_key, "coords_hud", &hmod).unwrap_err();
    // rust: assert!(e.contains("key"), "{e}");

    // rust: let mut more_caps = index.clone();
    // rust: more_caps.projects[0].versions[0].capabilities.pop();
    // rust: let e = check(&more_caps, "coords_hud", &hmod).unwrap_err();
    // rust: assert!(e.contains("isn't what the index lists"), "{e}");

    // rust: let mut other_level = index.clone();
    // rust: other_level.projects[0].versions[0].api_level = Some(1);
    // rust: let e = check(&other_level, "coords_hud", &hmod).unwrap_err();
    // rust: assert!(e.contains("isn't what the index lists"), "{e}");
    // An index built before levels lists none: the file still passes.
    // rust: let mut no_level = index.clone();
    // rust: no_level.projects[0].versions[0].api_level = None;
    // rust: assert_eq!(check(&no_level, "coords_hud", &hmod), Ok(Trust::Verified));
    // A native mod's hook points version is listed too: a file naming another is refused.
    // rust: let mut other_hooks = index.clone();
    // rust: other_hooks.projects[0].versions[0].hooks = Some(3);
    // rust: let e = check(&other_hooks, "coords_hud", &hmod).unwrap_err();
    // rust: assert!(e.contains("isn't what the index lists"), "{e}");

    // rust: let mut revoked = index.clone();
    // rust: revoked.revoked.push(Revoked {
    // rust: id: "coords_hud".into(),
    // rust: sha256: None,
    // rust: reason: "Test.".into(),
    // rust: date: String::new(),
    // rust: });
    // rust: let e = check(&revoked, "coords_hud", &hmod).unwrap_err();
    // rust: assert!(e.contains("taken down: Test."), "{e}");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

revocations_match_by_hash_or_by_id :: proc() {
}
    // rust: let index = sample();
    // rust: let ones = "1".repeat(64);
    // rust: assert!(index.revoked("bad_mod", &ones).is_some());
    // rust: assert!(index.revoked("bad_mod", &"2".repeat(64)).is_none());
    // rust: assert!(index.revoked("coords_hud", &ones).is_none());
}

refuses_broken_indexes :: proc() {
}
    // rust: let text = std::fs::read_to_string(fixtures().join("index-v1.json")).unwrap();
    // rust: let newer = text.replacen("\"schema\": 1", "\"schema\": 2", 1);
    // rust: assert!(Index::parse(&newer).unwrap_err().contains("schema 2"));
    // rust: let broken = |edit: &dyn Fn(&mut Index)| {
    // rust: let mut index = sample();
    // rust: edit(&mut index);
    // rust: index.check().unwrap_err()
}
    // rust: let e = broken(&|i| {
    // rust: let twin = i.projects[0].clone();
    // rust: i.projects.push(twin)
    // rust: });
    // rust: assert!(e.contains("listed twice"), "{e}");
    // rust: let e = broken(&|i| i.projects[0].versions[0].file.url = "http://example.org/x.hmod".into());
    // rust: assert!(e.contains("https"), "{e}");
    // A local test registry may list files on disk; the published one may not.
    // rust: let local = text.replace(
    // rust: "https://github.com/horizon-rust/horizon-mods/releases/download/coords_hud-0.1.0/",
    // rust: "file:///tmp/",
    // rust: );
    // rust: assert!(Index::parse(&local).unwrap_err().contains("https"));
    // rust: assert!(Index::parse_local(&local).is_ok());
    // rust: let e = broken(&|i| i.projects[0].versions[0].file.name = "../coords_hud.hmod".into());
    // rust: assert!(e.contains("plain file name"), "{e}");
    // rust: let e = broken(&|i| i.projects[0].versions[0].file.name = "coords_hud.zip".into());
    // rust: assert!(e.contains("plain file name"), "{e}");
    // rust: let e = broken(&|i| i.projects[0].versions[0].file.signature = None);
    // rust: assert!(e.contains("unsigned"), "{e}");
    // rust: let e = broken(&|i| i.projects[0].key = Some("not a key".into()));
    // rust: assert!(e.contains("key"), "{e}");
    // rust: let e = broken(&|i| i.projects[1].versions[0].requires[0].version = "9.9".into());
    // rust: assert!(e.contains("not in the index"), "{e}");
    // rust: let e = broken(&|i| i.projects[1].versions[0].requires[0].sha256 = "2".repeat(64));
    // rust: assert!(e.contains("another file"), "{e}");
    // rust: let e = broken(&|i| i.projects[0].id = "Coords".into());
    // rust: assert!(e.contains("is not"), "{e}");
}

resource_packs_need_a_pack_mcmeta :: proc() {
}
//     use std::io::Write;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-index-rp-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let pack = |files: &[(&str, &str)]| {
    // rust: let path = dir.join("look.zip");
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(&path).unwrap());
    // rust: for (name, text) in files {
    // rust: zip.start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: path
}
    // rust: let meta = r#"{"pack": {"description": "Look", "min_format": 75, "max_format": 75}}"#;
    // rust: assert_eq!(
    // rust: check_resource_pack(&pack(&[("pack.mcmeta", meta)])),
    // rust: Ok("75".into())
    // rust: );
    // rust: let e = check_resource_pack(&pack(&[("assets/x.png", "")])).unwrap_err();
    // rust: assert!(e.contains("missing"), "{e}");
    // rust: let e = check_resource_pack(&pack(&[("pack.mcmeta", "{}")])).unwrap_err();
    // rust: assert!(e.contains("\"pack\""), "{e}");
    // rust: let e = check_resource_pack(&pack(&[("pack.mcmeta", meta), ("../x", "")])).unwrap_err();
    // rust: assert!(e.contains("plain path"), "{e}");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

data_packs_and_shader_folder_packs_are_read_by_their_content :: proc() {
}
//     use std::io::Write;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-index-dp-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let mut n = 0;
    // rust: let mut pack = |files: &[&str]| {
    // rust: n += 1;
    // rust: let path = dir.join(format!("{n}.zip"));
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(&path).unwrap());
    // rust: for name in files {
    // rust: zip.start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: let text = if *name == "pack.mcmeta" {
    // rust: r#"{"pack": {"description": "D", "pack_format": 94}}"#
    // rust: } else {
    // rust: ""
}
    // rust: zip.write_all(text.as_bytes()).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: path
}
    // rust: let data = pack(&["pack.mcmeta", "data/x/function/a.mcfunction"]);
    // rust: assert_eq!(inspect(&Kind::DataPack, &data).unwrap().api, "94");
    // rust: assert_eq!(zip_kind(&data), Kind::DataPack);
    // rust: let looks = pack(&["pack.mcmeta", "assets/x/textures/a.png"]);
    // rust: let e = inspect(&Kind::DataPack, &looks).unwrap_err();
    // rust: assert!(e.contains("data/"), "{e}");
    // rust: assert_eq!(zip_kind(&looks), Kind::ResourcePack);
    // rust: let no_meta = pack(&["data/x/function/a.mcfunction"]);
    // rust: assert!(
    // rust: inspect(&Kind::DataPack, &no_meta)
    // rust: .unwrap_err()
    // rust: .contains("missing")
    // rust: );
    // rust: let shaders = pack(&["shaders/composite.fsh", "shaders/lang/en_us.lang"]);
    // rust: assert_eq!(inspect(&Kind::ShaderPack, &shaders).unwrap().api, "");
    // rust: assert_eq!(zip_kind(&shaders), Kind::ShaderPack);
    // rust: let e = inspect(&Kind::ShaderPack, &looks).unwrap_err();
    // rust: assert!(e.contains("shaders/"), "{e}");
    // rust: let sneaky = pack(&["shaders/a.fsh", "../../x"]);
    // rust: assert!(
    // rust: inspect(&Kind::ShaderPack, &sneaky)
    // rust: .unwrap_err()
    // rust: .contains("plain path")
    // rust: );
    // Both are zips, and a reader from before them keeps them as unknown kinds.
    // rust: for kind in [Kind::DataPack, Kind::ShaderPack] {
    // rust: assert_eq!(kind.extension(), Some("zip"));
    // rust: assert!(open(&kind).is_ok());
    // rust: assert_eq!(Kind::from(kind.name().to_owned()), kind);
}
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

the_newest_version_this_horizon_runs_is_installed :: proc() {
}
    // rust: let mut index = sample();
    // rust: let mut newer = index.projects[0].versions[0].clone();
    // rust: newer.version = "0.2.0".into();
    // rust: newer.file.sha256 = "2".repeat(64);
    // rust: newer.api_level = Some(crate::api_level::LEVEL + 1);
    // rust: index.projects[0].versions.insert(0, newer);
    // rust: let p = index.project("coords_hud").unwrap();
    // rust: let pick = |level| {
    // rust: index
    // rust: .installable(p, "26.3", level)
    // rust: .map(|v| v.version.as_str())
}
    // rust: assert_eq!(pick(crate::api_level::LEVEL), Some("0.1.0"));
    // rust: assert_eq!(pick(crate::api_level::LEVEL + 1), Some("0.2.0"));
    // rust: assert_eq!(index.installable(p, "26.4", crate::api_level::LEVEL), None);
    // No level listed: runnable as far as the index knows.
    // rust: index.projects[0].versions[0].api_level = None;
    // rust: let p = index.project("coords_hud").unwrap();
    // rust: let v = index.installable(p, "26.3", 0).unwrap();
    // rust: assert_eq!(v.version, "0.2.0");
}

shader_packs_pass_the_game_s_own_check :: proc() {
}
    // rust: let manifest = "schema = 1\nid = \"glow\"\nname = \"Glow\"\nversion = \"1.0.0\"\napi = \"0.1\"\n\
    // rust: [[post]]\nfile = \"post.wgsl\"\n";
    // rust: let pack = |post: &str| {
    // rust: let files = [
    // rust: (horizon_shader_api::MANIFEST, manifest),
    // rust: ("post.wgsl", post),
    // rust: ]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: horizon_shader_api::Pack::from_files(files)
    // rust: .unwrap()
    // rust: .package()
    // rust: .unwrap()
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mods-shader-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let good = dir.join("glow-1.0.0.hshader");
    // rust: std::fs::write(
    // rust: &good,
    // rust: pack("fn post(input: PostInput) -> vec4<f32> { return input.color; }\n"),
    // rust: )
    // rust: .unwrap();
    // rust: let bad = dir.join("bad.hshader");
    // rust: std::fs::write(
    // rust: &bad,
    // rust: pack("fn post(input: PostInput) -> vec4<f32> { return input.color }\n"),
    // rust: )
    // rust: .unwrap();
    // rust: let experimental = dir.join("glow-0.2.hshader");
    // rust: let files = [
    // rust: (
    // rust: horizon_shader_api::MANIFEST,
    // rust: manifest.replace("api = \"0.1\"", "api = \"0.2\""),
    // rust: ),
    // rust: (
    // rust: "post.wgsl",
    // rust: "fn post(input: PostInput) -> vec4<f32> { return input.color; }\n".into(),
    // rust: ),
    // rust: ]
    // rust: .map(|(n, t)| (n.to_owned(), t.into_bytes()))
    // rust: .into();
    // rust: let bytes = horizon_shader_api::Pack::from_files(files)
    // rust: .unwrap()
    // rust: .package()
    // rust: .unwrap();
    // rust: std::fs::write(&experimental, bytes).unwrap();
    // rust: let experimental = inspect(&Kind::Shader, &experimental).unwrap_err();
    // rust: let facts = inspect(&Kind::Shader, &good);
    // rust: let refused = inspect(&Kind::Shader, &bad).unwrap_err();
    // rust: let not_a_pack = inspect(&Kind::Shader, &fixtures().join("cozy-1.0.0.hpack")).unwrap_err();
    // rust: std::fs::remove_dir_all(&dir).unwrap();
    // rust: let facts = facts.unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: facts.id.as_deref(),
    // rust: facts.version.as_deref(),
    // rust: facts.api.as_str()
    // rust: ),
    // rust: (Some("glow"), Some("1.0.0"), "0.1")
    // rust: );
    // rust: assert!(refused.contains("post.wgsl:1:"), "{refused}");
    // rust: assert!(
    // rust: experimental.contains("shader API 0.2, which is experimental"),
    // rust: "{experimental}"
    // rust: );
    // rust: assert!(
    // rust: not_a_pack.contains(horizon_shader_api::MANIFEST),
    // rust: "{not_a_pack}"
    // rust: );
    // rust: assert_eq!(Kind::Shader.extension(), Some("hshader"));
    // rust: assert!(open(&Kind::Shader).is_ok());
}
