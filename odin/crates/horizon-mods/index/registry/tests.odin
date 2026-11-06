//! Transpiled from Horizon Rust crate
package horizon_mods_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A registry checkout holding the sample index's mod, modpack and shader pack
// builds the sample index (`tests/index/index-v1.json`) exactly.
// use super::*;

HMOD :: "e1135345692f6dd8fd4c51920151944b82333e17049c9bb7d756f27b8deefc53"
HPACK :: "241ac840f9c5ea3f6252d849da10c90d36cb1da4d6cd8d1d268c2760a353cd65"
HSHADER :: "331cfe29a666a0de804e9a9ff3d19d246eebcfbfa70b4f49bba8482d30ad9f02"

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

hud_entry :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let p = sample();
    // rust: let sig = p.project("coords_hud").unwrap().versions[0]
    // rust: .file
    // rust: .signature
    // rust: .clone()
    // rust: .unwrap();
    // rust: format!(
    // rust: r#"id = "coords_hud"
    // rust: kind = "mod"
    // rust: name = "Coordinates HUD"
    // rust: summary = "Your coordinates, facing and the time of day in a corner of the screen."
    // rust: description = "`/where` puts them in chat, `/coords` hides or shows the panel."
    // rust: authors = ["Horizon"]
    // rust: owners = ["ludovic111"]
    // rust: license = "MIT"
    // rust: source = "https://github.com/horizon-rust/horizon/tree/main/crates/horizon-mod-sdk/examples/coords-hud"
    // rust: icon = "icons/coords_hud.png"
    // rust: categories = ["utility"]
    // rust: key = "RWTVtuGb/GRXcBf3Re5hzM07EzoStr2sLTJjghJia0xX15ULoZRFFZDb"

    // rust: [[versions]]
    // rust: version = "0.1.0"
    // rust: published = "2026-10-24"
    // rust: game = "26.3"
    // rust: file = "coords_hud-0.1.0.hmod"
    // rust: sha256 = "{HMOD}"
    // rust: signature = """{sig}"""
    // rust: "#
    // rust: )
}

    // rust: const COZY: &str = r#"id = "cozy"
    // rust: kind = "modpack"
    // rust: name = "Cozy"
    // rust: summary = "Coordinates and a calm render distance."
    // rust: description = "Coordinates HUD with a calm render distance, played together as one profile."
    // rust: categories = ["lightweight"]
    // rust: icon = "icons/cozy.png"
    // rust: authors = ["Horizon"]
    // rust: owners = ["ludovic111"]
    // rust: license = "MIT"
    // rust: source = "https://github.com/horizon-rust/horizon-mods"

    // rust: [[versions]]
    // rust: version = "1.0.0"
    // rust: published = "2026-10-24"
    // rust: game = "26.3"
    // rust: file = "cozy-1.0.0.hpack"
    // rust: sha256 = "241ac840f9c5ea3f6252d849da10c90d36cb1da4d6cd8d1d268c2760a353cd65"
    // rust: "#;

    // rust: const GLOW: &str = r#"id = "glow"
    // rust: kind = "shader"
    // rust: name = "Soft Glow"
    // rust: summary = "A post-processing pass over the world."
    // rust: description = "A soft bloom drawn over the world after it renders, in Horizon's own shader format."
    // rust: categories = ["bloom"]
    // rust: icon = "icons/glow.png"
    // rust: authors = ["Horizon"]
    // rust: owners = ["ludovic111"]
    // rust: license = "MIT"
    // rust: source = "https://github.com/horizon-rust/horizon-mods"

    // rust: [[versions]]
    // rust: version = "1.0.0"
    // rust: published = "2026-10-26"
    // rust: game = "26.3"
    // rust: file = "glow-1.0.0.hshader"
    // rust: sha256 = "331cfe29a666a0de804e9a9ff3d19d246eebcfbfa70b4f49bba8482d30ad9f02"
    // rust: "#;

    // rust: const REVOKED_TOML: &str = r#"[[revoked]]
    // rust: id = "bad_mod"
    // rust: sha256 = "1111111111111111111111111111111111111111111111111111111111111111"
    // rust: reason = "Sent chat messages it didn't declare."
    // rust: date = "2026-10-24"
    // rust: "#;

// The header of a PNG of `w`×`h` pixels: what the registry reads of an image.
png :: proc(w: u32, h: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = b"\x89PNG\r\n\x1a\n\0\0\0\rIHDR".to_vec();
    // rust: b.extend(w.to_be_bytes());
    // rust: b.extend(h.to_be_bytes());
    // rust: b.extend([8, 6, 0, 0, 0]);
    // rust: b
}

// A registry checkout and its downloaded files, in a scratch folder.
Scratch :: struct {

    // rust: impl Scratch {
new :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let dir =
    std: :env::temp_dir().join(format!("horizon-registry-{name}-{}",
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: for sub in ["repo/mods", "repo/icons", "files"] {
    std: :fs::create_dir_all(dir.join(sub)).unwrap(),
}
    // rust: let s = Scratch(dir);
    // rust: s.write("mods/coords_hud.toml", &hud_entry());
    // rust: s.write("mods/cozy.toml", COZY);
    // rust: s.write("mods/glow.toml", GLOW);
    // rust: s.write("revoked.toml", REVOKED_TOML);
    // rust: for icon in ["coords_hud", "cozy", "glow"] {
    // rust: s.write_bytes(&format!("icons/{icon}.png"), &png(128, 128));
}
    // rust: for (name, hash) in [
    // rust: ("coords_hud-0.1.0.hmod", HMOD),
    // rust: ("cozy-1.0.0.hpack", HPACK),
    // rust: ("glow-1.0.0.hshader", HSHADER),
    // rust: ] {
    // rust: std::fs::copy(fixtures().join(name), s.0.join("files").join(hash)).unwrap();
}
    // rust: s
}

write :: proc(self: ^Self, path: string, text: string) {
}
    // rust: std::fs::write(self.0.join("repo").join(path), text).unwrap();
}

write_bytes :: proc(self: ^Self, path: string, bytes: []u8) {
}
    // rust: let path = self.0.join("repo").join(path);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, bytes).unwrap();
}

build :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (repo, files) = (self.0.join("repo"), self.0.join("files"));
    // rust: build(&Sources {
    // rust: registry: &repo,
    // rust: files: &files,
    // rust: release: super::super::FILE_HOST,
    // rust: site: "https://horizon-rust.github.io/horizon-mods/",
    // rust: generated: "2026-10-24T18:00:00Z".into(),
    // rust: })
}
}

    // rust: impl Drop for Scratch {
drop :: proc(self: ^Self) {
}
    // rust: let _ = std::fs::remove_dir_all(&self.0);
}
}

builds_the_sample_index :: proc() {
}
    // rust: let s = Scratch::new("sample");
    // rust: let built = s.build().unwrap();
    // rust: let sample = sample();
    // rust: assert_eq!(built.projects, sample.projects[..3]);
    // rust: assert_eq!(built.revoked, sample.revoked);
    // rust: assert_eq!(built.generated, sample.generated);
    // What it writes reads back.
    // rust: Index::parse(&serde_json::to_string_pretty(&built).unwrap()).unwrap();
}

lists_every_problem_of_a_registry :: proc() {
}
    // rust: let s = Scratch::new("bad");
    // A file that isn't the one its hash names, an unsigned version of a
    // signed project, a shader pack, and a mod whose file is another mod.
    // rust: std::fs::write(s.0.join("files").join(HPACK), b"other bytes").unwrap();
    // rust: s.write(
    // rust: "mods/coords_hud.toml",
    // rust: &hud_entry().replace("signature = \"\"\"", "changelog = \"\"\""),
    // rust: );
    // rust: s.write(
    // rust: "mods/glow.toml",
    // rust: &COZY
    // rust: .replace("\"cozy\"", "\"glow\"")
    // rust: .replace("modpack", "shader"),
    // rust: );
    // rust: s.write(
    // rust: "mods/other.toml",
    // rust: &hud_entry()
    // rust: .replace("\"coords_hud\"", "\"other\"")
    // rust: .replace("key = ", "# key = ")
    // rust: .replace("signature = \"\"\"", "changelog = \"\"\""),
    // rust: );
    // rust: let errors = s.build().unwrap_err();
    // rust: let has = |part: &str| errors.iter().any(|e| e.contains(part));
    // rust: assert!(
    // rust: has("cozy 1.0.0: the file isn't the one its sha256 names"),
    // rust: "{errors:?}"
    // rust: );
    // rust: assert!(has("coords_hud 0.1.0: the project has a key"), "{errors:?}");
    // A shader entry is taken now, and checked like the others.
    // rust: assert!(
    // rust: has("glow 1.0.0: the file isn't the one its sha256 names"),
    // rust: "{errors:?}"
    // rust: );
    // rust: assert!(
    // rust: has("other 0.1.0: the file's id is \"coords_hud\""),
    // rust: "{errors:?}"
    // rust: );
    // The modpack's category, on what is now a shader.
    // rust: assert!(
    // rust: has("\"lightweight\" is not a category of a shader"),
    // rust: "{errors:?}"
    // rust: );
    // rust: assert!(has("glow: its icon \"icons/cozy.png\""), "{errors:?}");
    // rust: assert!(
    // rust: has("other: its icon \"icons/coords_hud.png\""),
    // rust: "{errors:?}"
    // rust: );
    // rust: assert_eq!(errors.len(), 7, "{errors:?}");
}

an_entry_is_named_by_its_id_and_has_only_known_fields :: proc() {
}
    // rust: let s = Scratch::new("names");
    // rust: s.write("mods/hud.toml", &hud_entry());
    // rust: s.write("mods/notes.txt", "");
    // rust: s.write("mods/cozy.toml", &format!("{COZY}homepage = \"x\"\n"));
    // rust: let errors = load(&s.0.join("repo")).unwrap_err();
    // rust: assert_eq!(errors.len(), 3, "{errors:?}");
    // rust: assert!(errors[0].contains("cozy.toml") && errors[0].contains("homepage"));
    // rust: assert!(errors[1].contains("must be mods/coords_hud.toml"));
    // rust: assert!(errors[2].contains("only <id>.toml"));
}

an_entry_written_reads_back :: proc() {
}
    // rust: let entry: Entry = toml::from_str(&hud_entry()).unwrap();
    // rust: let text = entry.to_toml().unwrap();
    // rust: assert_eq!(toml::from_str::<Entry>(&text).unwrap(), entry);
    // rust: assert!(text.contains("[[versions]]"), "{text}");
}

owners_and_owner_ids_must_name_the_same_accounts :: proc() {
}
    // rust: let entry = |extra: &str| -> Entry {
    // rust: toml::from_str(&hud_entry().replacen("owners = [\"ludovic111\"]", extra, 1)).unwrap()
}
    // rust: let mismatch = |e: &Entry| e.check_fields().iter().any(|m| m.contains("owner_ids"));
    // No IDs yet (older entries), or one ID per login: fine.
    // rust: assert!(!mismatch(&entry(r#"owners = ["ludovic111"]"#)));
    // rust: assert!(!mismatch(&entry(
    // rust: "owner_ids = [136255825, 583231]\nowners = [\"ludovic111\", \"someone\"]"
    // rust: )));
    // A co-owner added to `owners` alone would silently not be an owner: refused when it's made.
    // rust: assert!(mismatch(&entry(
    // rust: "owner_ids = [136255825]\nowners = [\"ludovic111\", \"someone\"]"
    // rust: )));
    // rust: assert!(mismatch(&entry(
    // rust: "owner_ids = [136255825, 583231]\nowners = [\"ludovic111\"]"
    // rust: )));
}

owner_ids_are_optional_and_kept :: proc() {
}
    // Entries from before IDs were recorded still read, and write no `owner_ids`.
    // rust: let old: Entry = toml::from_str(&hud_entry()).unwrap();
    // rust: assert!(old.owner_ids.is_empty());
    // rust: assert!(!old.to_toml().unwrap().contains("owner_ids"));
    // rust: let text = hud_entry().replacen("owners = ", "owner_ids = [583231]\nowners = ", 1);
    // rust: let new: Entry = toml::from_str(&text).unwrap();
    // rust: assert_eq!(new.owner_ids, [583231]);
    // rust: assert_eq!(
    // rust: toml::from_str::<Entry>(&new.to_toml().unwrap()).unwrap(),
    // rust: new
    // rust: );
    // A change of IDs is pointed out to reviewers.
    // rust: let r = review(
    // rust: std::slice::from_ref(&old),
    // rust: std::slice::from_ref(&new),
    // rust: "ludovic111",
    // rust: );
    // rust: assert!(
    // rust: r.notes
    // rust: .iter()
    // rust: .any(|n| n.contains("owner IDs (none) -> 583231")),
    // rust: "{r:?}"
    // rust: );
}

a_review_protects_published_files :: proc() {
}
    // rust: let base: Entry = toml::from_str(&hud_entry()).unwrap();
    // rust: let cozy: Entry = toml::from_str(COZY).unwrap();
    // rust: let one = std::slice::from_ref(&base);
    // rust: let same = review(one, one, "someone");
    // rust: assert_eq!(same, Review::default());

    // rust: let mut update = base.clone();
    // rust: let mut next = update.versions[0].clone();
    // rust: next.version = "0.2.0".into();
    // rust: update.versions.insert(0, next);
    // rust: let r = review(one, std::slice::from_ref(&update), "ludovic111");
    // rust: assert!(r.errors.is_empty(), "{r:?}");
    // rust: assert_eq!(r.notes, ["coords_hud: 1 new version(s)"]);
    // rust: let r = review(one, &[update], "stranger");
    // rust: assert!(r.notes[0].contains("isn't one of its owners"), "{r:?}");

    // rust: let mut swapped = base.clone();
    // rust: swapped.versions[0].sha256 = HPACK.into();
    // rust: swapped.kind = Kind::ResourcePack;
    // rust: swapped.key = None;
    // rust: let r = review(&[base.clone(), cozy.clone()], &[swapped], "ludovic111");
    // rust: assert_eq!(r.errors.len(), 3, "{r:?}");
    // rust: assert!(r.errors.iter().any(|e| e.contains("cozy: removed")));
    // rust: assert!(r.errors.iter().any(|e| e.contains("never changes")));
    // rust: assert!(r.errors.iter().any(|e| e.contains("kind can't change")));
    // rust: assert!(r.notes.iter().any(|n| n.contains("signing key")));

    // rust: let r = review(&[], &[cozy], "newcomer");
    // rust: assert_eq!(r.notes, ["cozy: a new modpack by ludovic111"]);
}

a_review_refuses_following_a_repository :: proc() {
}
    // rust: let pinned: Entry = toml::from_str(COZY).unwrap();
    // rust: let follows: Entry = toml::from_str(COZY_REPO).unwrap();
    // A new entry that follows a repository, and a pinned entry turned into one.
    // rust: for base in [vec![], vec![pinned.clone()]] {
    // rust: let r = review(&base, std::slice::from_ref(&follows), "acme");
    // rust: assert!(
    // rust: r.errors
    // rust: .iter()
    // rust: .any(|e| e.contains("doesn't follow repositories")),
    // rust: "{r:?}"
    // rust: );
}
    // An entry from before keeps its repository until it is pinned, and may drop it.
    // rust: let r = review(
    // rust: std::slice::from_ref(&follows),
    // rust: std::slice::from_ref(&follows),
    // rust: "acme",
    // rust: );
    // rust: assert!(r.errors.is_empty(), "{r:?}");
    // rust: let r = review(&[follows], &[pinned], "acme");
    // rust: assert!(
    // rust: !r.errors.iter().any(|e| e.contains("repositories")),
    // rust: "{r:?}"
    // rust: );
}

a_mod_may_turn_native_once :: proc() {
}
    // rust: let base: Entry = toml::from_str(&hud_entry()).unwrap();
    // rust: let mut native = base.clone();
    // rust: native.kind = Kind::NativeMod;
    // rust: let mut next = native.versions[0].clone();
    // rust: next.version = "2.0.0".into();
    // rust: next.file = "coords_hud-2.0.0.hnmod".into();
    // rust: native.versions.insert(0, next);
    // rust: let r = review(
    // rust: std::slice::from_ref(&base),
    // rust: std::slice::from_ref(&native),
    // rust: "ludovic111",
    // rust: );
    // rust: assert!(r.errors.is_empty(), "{r:?}");
    // rust: assert!(r.notes.iter().any(|n| n.contains("turns native")), "{r:?}");
    // Its content-only .hmod versions are from before; the new ones native, and a .hmod
    // holding native code is native too.
    // rust: let none = Path::new("no-such-file");
    // rust: assert_eq!(file_kind(&native, &native.versions[1], none), Kind::Mod);
    // rust: assert_eq!(
    // rust: file_kind(&native, &native.versions[0], none),
    // rust: Kind::NativeMod
    // rust: );
    // rust: let unified = std::env::temp_dir().join(format!("unified-{}.hmod", std::process::id()));
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(&unified).unwrap());
    // rust: zip.start_file(
    // rust: super::super::native::MANIFEST,
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.finish().unwrap();
    // rust: assert_eq!(
    // rust: file_kind(&native, &native.versions[1], &unified),
    // rust: Kind::NativeMod
    // rust: );
    // rust: std::fs::remove_file(unified).unwrap();
    // And never back.
    // rust: let r = review(&[native], &[base], "ludovic111");
    // rust: assert!(
    // rust: r.errors.iter().any(|e| e.contains("kind can't change")),
    // rust: "{r:?}"
    // rust: );
}

page_fields_and_screenshots_reach_the_index :: proc() {
}
    // rust: let s = Scratch::new("page");
    // rust: let page = "tags = [\"hud\", \"coordinates\"]\n\
    // rust: screenshots = [\"screenshots/coords_hud/1.png\"]\n";
    // rust: s.write("mods/coords_hud.toml", &format!("{page}{}", hud_entry()));
    // rust: s.write_bytes("screenshots/coords_hud/1.png", &png(1280, 720));
    // rust: let built = s.build().unwrap();
    // rust: let p = built.project("coords_hud").unwrap();
    // rust: assert_eq!(p.categories, ["utility"]);
    // rust: assert_eq!(p.tags, ["hud", "coordinates"]);
    // rust: assert_eq!(
    // rust: p.screenshots,
    // rust: ["https://horizon-rust.github.io/horizon-mods/screenshots/coords_hud/1.png"]
    // rust: );
    // rust: Index::parse(&serde_json::to_string(&built).unwrap()).unwrap();

    // A category of another kind, a screenshot too small, one in another project's folder, one on
    // another host, and an icon that isn't square.
    // rust: let bad = "screenshots = [\"screenshots/coords_hud/1.png\", \"screenshots/other/2.png\", \
    // rust: \"https://x.test/3.jpg\"]\n";
    // rust: let entry = hud_entry().replace("[\"utility\"]", "[\"bloom\"]");
    // rust: s.write("mods/coords_hud.toml", &format!("{bad}{entry}"));
    // rust: s.write_bytes("screenshots/coords_hud/1.png", &png(100, 100));
    // rust: s.write_bytes("icons/coords_hud.png", &png(128, 64));
    // rust: let errors = s.build().unwrap_err();
    // rust: let has = |part: &str| errors.iter().any(|e| e.contains(part));
    // rust: assert!(has("\"bloom\" is not a category of a mod"), "{errors:?}");
    // rust: assert!(has("1.png: 100×100 pixels"), "{errors:?}");
    // rust: assert!(
    // rust: has("\"screenshots/other/2.png\" is neither screenshots/coords_hud/"),
    // rust: "{errors:?}"
    // rust: );
    // rust: assert!(has("the icon is 128×64"), "{errors:?}");
    // rust: assert!(
    // rust: has("\"https://x.test/3.jpg\" must be kept in the registry"),
    // rust: "{errors:?}"
    // rust: );
    // rust: assert_eq!(errors.len(), 5, "{errors:?}");
}

only_open_kinds_are_taken :: proc() {
}
    // rust: assert!(open(&Kind::Mod).is_ok() && open(&Kind::ResourcePack).is_ok());
    // rust: assert!(open(&Kind::Shader).is_ok() && open(&Kind::ShaderPack).is_ok());
    // rust: assert!(open(&Kind::DataPack).is_ok());
    // rust: assert!(open(&Kind::Other("world".into())).is_err());
    // rust: let mut submit: Entry = toml::from_str(COZY).unwrap();
    // rust: submit.id = "submit".into();
    // rust: let dir = std::env::temp_dir();
    // rust: let src = Sources {
    // rust: registry: &dir,
    // rust: files: &dir,
    // rust: release: super::super::FILE_HOST,
    // rust: site: "https://x.test/",
    // rust: generated: String::new(),
}
    // rust: assert!(project(&submit, &src).unwrap_err()[0].contains("reserved"));
    // rust: assert!(plain_version("1.0.0-beta.2") && !plain_version("../1") && !plain_version("1 0"));
    // rust: assert!(plain_date("2026-10-24") && !plain_date("24/10/2026"));
}

    // rust: const COZY_REPO: &str = r#"id = "cozy"
    // rust: kind = "modpack"
    // rust: repo = "acme/cozy-pack"
    // rust: owners = ["acme"]
    // rust: description = "Coordinates HUD with a calm render distance, played together as one profile."
    // rust: categories = ["lightweight"]
    // rust: icon = "icons/cozy.png"
    // rust: "#;

a_project_listed_by_its_repository_takes_its_versions_from_releases :: proc() {
}
    // rust: let s = Scratch::new("repo");
    // rust: s.write("mods/coords_hud.toml", &hud_entry());
    // rust: s.write("mods/cozy.toml", COZY_REPO);
    // rust: let hpack = fixtures().join("cozy-1.0.0.hpack");
    // rust: let entry: Entry = toml::from_str(COZY_REPO).unwrap();
    // Listed, nothing released yet: not in the index, and not an error.
    // rust: let built = s.build().unwrap();
    // rust: assert!(built.project("cozy").is_none());
    // The page file fills what the entry leaves out; the entry's own words win.
    // rust: let page = page(
    // rust: &entry,
    // rust: "name = \"Cozy\"\nsummary = \"Calm.\"\nlicense = \"MIT\"\nauthors = [\"Acme\"]\n",
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: self::page(&entry, "name = \"Cozy\"")
    // rust: .unwrap_err()
    // rust: .contains("summary")
    // rust: );
    // rust: assert!(self::page(&entry, "owners = [\"me\"]").is_err());
    // rust: let release = |tag, asset, notes| Release {
    // rust: tag,
    // rust: published: "2026-10-30",
    // rust: notes,
    // rust: asset,
    // rust: game: "26.3",
    // rust: signature: None,
}
    // rust: let v = release_version(
    // rust: &entry,
    // rust: &release("v1.0.0", "cozy-1.0.0.hpack", "Notes."),
    // rust: &hpack,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(v.version, "1.0.0");
    // rust: assert_eq!(v.file.sha256, HPACK);
    // rust: assert_eq!(
    // rust: v.file.url,
    // rust: "https://github.com/acme/cozy-pack/releases/download/v1.0.0/cozy-1.0.0.hpack"
    // rust: );
    // rust: assert_eq!(v.changelog, "Notes.");
    // A name the launcher can't download, a wrong extension, a project with a key but no signature.
    // rust: assert!(release_version(&entry, &release("v1/x", "cozy-1.0.0.hpack", ""), &hpack).is_err());
    // rust: assert!(release_version(&entry, &release("v1", "cozy.zip", ""), &hpack).is_err());
    // rust: let mut keyed = entry.clone();
    // rust: keyed.key = Some("RWTVtuGb/GRXcBf3Re5hzM07EzoStr2sLTJjghJia0xX15ULoZRFFZDb".into());
    // rust: assert!(
    // rust: release_version(&keyed, &release("v1", "cozy-1.0.0.hpack", ""), &hpack)
    // rust: .unwrap_err()
    // rust: .contains("sign")
    // rust: );
    // rust: let cache = Cache {
    // rust: page,
    // rust: versions: vec![v.clone()],
}
    // rust: std::fs::create_dir_all(s.0.join("repo").join(CACHE)).unwrap();
    // rust: s.write(
    // rust: "versions/cozy.json",
    // rust: &serde_json::to_string(&cache).unwrap(),
    // rust: );
    // rust: let built = s.build().unwrap();
    // rust: let p = built.project("cozy").unwrap();
    // rust: assert_eq!(
    // rust: (p.name.as_str(), p.authors.clone()),
    // rust: ("Cozy", vec!["Acme".to_string()])
    // rust: );
    // rust: assert_eq!(p.source, "https://github.com/acme/cozy-pack");
    // rust: assert_eq!(p.versions, vec![v]);
    // The registry's own words win over the repository's.
    // rust: s.write(
    // rust: "mods/cozy.toml",
    // rust: &format!("{COZY_REPO}name = \"Cozy Pack\"\n"),
    // rust: );
    // rust: assert_eq!(
    // rust: s.build().unwrap().project("cozy").unwrap().name,
    // rust: "Cozy Pack"
    // rust: );
    // A repository that is not owner/name is refused.
    // rust: s.write(
    // rust: "mods/cozy.toml",
    // rust: &COZY_REPO.replace("acme/cozy-pack", "acme"),
    // rust: );
    // rust: assert!(
    // rust: s.build()
    // rust: .unwrap_err()
    // rust: .iter()
    // rust: .any(|e| e.contains("owner/name"))
    // rust: );
}
