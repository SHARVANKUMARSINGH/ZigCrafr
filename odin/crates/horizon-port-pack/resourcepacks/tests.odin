//! Transpiled from Horizon Rust crate
package horizon_port_pack_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use std::sync::atomic::{AtomicUsize, Ordering};

Temp :: struct {
    // rust: impl Temp {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
N :: AtomicUsize::new(0)
    // rust: let path = std::env::temp_dir().join(format!(
    // rust: "horizon-resourcepacks-{}-{}",
    std: :process::id(),
    // rust: N.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    fs: :create_dir(^path).unwrap(),
    // rust: Self(path)
}
work :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.0.join("work")
}
}
    // rust: impl Drop for Temp {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}
put :: proc(path: ^Path, bytes: []u8) {
}
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, bytes).unwrap();
}
archive :: proc(path: ^Path, entries: ^[(string) {
}
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(path).unwrap());
    // rust: for (name, bytes) in entries {
    // rust: zip.start_file(*name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(bytes).unwrap();
}
    // rust: zip.finish().unwrap();
}
imported :: proc(source: ^Path, work: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: pipeline::import(source, work, &|_| {})?;
    // rust: Ok(Report::load(work))
}

mrpack_client_override_wins_and_server_and_unrelated_overrides_stay_out :: proc() {
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("pack.mrpack");
    // rust: archive(
    // rust: &src,
    // rust: &[
    // rust: (
    // rust: "modrinth.index.json",
    // rust: br#"{"name":"Small","files":[{"path":"shaderpacks/later.zip"}]}"#,
    // rust: ),
    // rust: ("overrides/resourcepacks/look.zip", b"common"),
    // rust: ("client-overrides/resourcepacks/look.zip", b"client"),
    // rust: ("server-overrides/resourcepacks/server.zip", b"server"),
    // rust: ("overrides/options.txt", b"do not copy"),
    // rust: ("overrides/resourcepacks/README.txt", b"not a pack"),
    // rust: ],
    // rust: );
    // rust: let report = imported(&src, &t.work()).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(t.work().join("resourcepacks/look.zip")).unwrap(),
    // rust: b"client"
    // rust: );
    // rust: assert!(!t.work().join("resourcepacks/server.zip").exists());
    // rust: assert!(!t.work().join("options.txt").exists());
    // rust: assert!(!t.work().join("resourcepacks/README.txt").exists());
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/look.zip"].state,
    // rust: State::Available
    // rust: );
    // rust: assert_eq!(
    // rust: report.files["shaderpacks/later.zip"].state,
    // rust: State::Unsupported
    // rust: );
}

curseforge_custom_root_and_directory_pack :: proc() {
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("pack.zip");
    // rust: archive(
    // rust: &src,
    // rust: &[
    // rust: (
    // rust: "manifest.json",
    // rust: br#"{"name":"Custom","overrides":"custom/root","files":[]}"#,
    // rust: ),
    // rust: ("custom/root/resourcepacks/Pretty/pack.mcmeta", b"{}"),
    // rust: (
    // rust: "custom/root/resourcepacks/Pretty/assets/test/a.txt",
    // rust: b"texture",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: imported(&src, &t.work()).unwrap();
    // rust: assert_eq!(
    // rust: fs::read(t.work().join("resourcepacks/Pretty/assets/test/a.txt")).unwrap(),
    // rust: b"texture"
    // rust: );
    // rust: assert_eq!(available(&t.work()).len(), 1);
}

resource_only_instance_and_repeated_import_keep_edits :: proc() {
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("instance");
    // rust: put(&src.join("mmc-pack.json"), b"{}");
    // rust: put(
    // rust: &src.join(".minecraft/resourcepacks/Look/pack.mcmeta"),
    // rust: b"{}",
    // rust: );
    // rust: put(&src.join(".minecraft/resourcepacks/look.zip"), b"zip");
    // rust: imported(&src, &t.work()).unwrap();
    // rust: put(&t.work().join("resourcepacks/look.zip"), b"local edit");
    // rust: let report = imported(&src, &t.work()).unwrap();
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/look.zip"].state,
    // rust: State::Conflict
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(t.work().join("resourcepacks/look.zip")).unwrap(),
    // rust: b"local edit"
    // rust: );
    // rust: assert_eq!(available(&t.work()).len(), 2);
}

hostile_archive_paths_and_cross_layer_collisions_are_rejected_before_staging :: proc() {
}
    // rust: for name in [
    // rust: "../escape.zip",
    // rust: "/absolute.zip",
    // rust: "C:drive.zip",
    // rust: "a\\..\\escape.zip",
    // rust: "CON.zip",
    // rust: "space.zip ",
    // rust: ] {
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("bad.mrpack");
    // rust: archive(
    // rust: &src,
    // rust: &[
    // rust: ("modrinth.index.json", b"{}"),
    // rust: (&format!("overrides/resourcepacks/{name}"), b"bad"),
    // rust: ],
    // rust: );
        // A bad entry leaves the packs out; it no longer fails the import.
    // rust: assert!(imported(&src, &t.work()).is_ok(), "{name}");
    // rust: assert!(available(&t.work()).is_empty());
    // rust: assert!(!t.work().join("escape.zip").exists());
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("bad.mrpack");
    // rust: archive(
    // rust: &src,
    // rust: &[
    // rust: ("modrinth.index.json", b"{}"),
    // rust: ("overrides/resourcepacks/a.zip", b"first"),
    // rust: (
    // rust: "client-overrides/resourcepacks/a.zip/pack.mcmeta",
    // rust: b"second",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: assert!(imported(&src, &t.work()).is_ok());
    // rust: assert!(available(&t.work()).is_empty());
}

duplicate_names_case_aliases_and_byte_limits :: proc() {
}
    // rust: let mut files = Files::new();
    // rust: add(&mut files, "A.zip", &b"one"[..], &mut 0).unwrap();
    // rust: assert!(add(&mut files, "A.zip", &b"two"[..], &mut 0).is_err());
    // rust: add(&mut files, "a.zip", &b"two"[..], &mut 0).unwrap();
    // rust: assert!(validate(&files).is_err());
    // rust: assert!(read_limited(&b"12345"[..], 4).is_err());
    // rust: assert_eq!(read_limited(&b"1234"[..], 4).unwrap(), b"1234");
}

profile_copy_is_idempotent_and_preserves_whole_directory_edits :: proc() {
}
    // rust: let t = Temp::new();
    // rust: put(&t.work().join("resourcepacks/Look/pack.mcmeta"), b"{}");
    // rust: put(&t.work().join("resourcepacks/Look/assets/a"), b"original");
    // rust: put(&t.work().join("resourcepacks/look.zip"), b"zip");
    // rust: let home = t.0.join("home");
    // rust: let first = install(&t.work(), &home).unwrap();
    // rust: assert_eq!(first.files.len(), 2);
    // rust: put(&home.join("resourcepacks/Look/assets/a"), b"edit");
    // rust: let second = install(&t.work(), &home).unwrap();
    // rust: assert_eq!(second.files["resourcepacks/Look"].state, State::Conflict);
    // rust: assert_eq!(
    // rust: second.files["resourcepacks/look.zip"].state,
    // rust: State::Available
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(home.join("resourcepacks/Look/assets/a")).unwrap(),
    // rust: b"edit"
    // rust: );
    // rust: assert!(!home.join("options.txt").exists());
}

symlinks_at_source_and_destination_are_rejected :: proc() {
}
//     use std::os::unix::fs::symlink;
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("instance");
    // rust: put(&src.join("resourcepacks/good.zip"), b"good");
    // rust: put(&t.0.join("outside.zip"), b"outside");
    // rust: symlink(t.0.join("outside.zip"), src.join("resourcepacks/link.zip")).unwrap();
    // A bad entry leaves the packs out; it no longer fails the import.
    // rust: assert!(imported(&src, &t.work()).is_ok());
    // rust: fs::remove_file(src.join("resourcepacks/link.zip")).unwrap();
    // rust: imported(&src, &t.work()).unwrap();
    // rust: let home = t.0.join("home");
    // rust: fs::create_dir(&home).unwrap();
    // rust: symlink(&src, home.join("resourcepacks")).unwrap();
    // rust: assert!(install(&t.work(), &home).is_err());
    // rust: assert_eq!(
    // rust: fs::read(src.join("resourcepacks/good.zip")).unwrap(),
    // rust: b"good"
    // rust: );
}

a_home_behind_a_link_takes_its_packs :: proc() {
}
//     use std::os::unix::fs::symlink;
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("instance");
    // rust: put(&src.join("resourcepacks/good.zip"), b"good");
    // Silverblue's /home -> /var/home: the link is above the work folder and the home.
    // rust: fs::create_dir(t.0.join("var-home")).unwrap();
    // rust: symlink(t.0.join("var-home"), t.0.join("home")).unwrap();
    // rust: let work = t.0.join("home/work");
    // rust: imported(&src, &work).unwrap();
    // rust: let home = t.0.join("home/profile");
    // rust: let report = install(&work, &home).unwrap();
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/good.zip"].state,
    // rust: State::Available
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(t.0.join("var-home/profile/resourcepacks/good.zip")).unwrap(),
    // rust: b"good"
    // rust: );
}

a_link_below_the_base_is_refused :: proc() {
}
//     use std::os::unix::fs::symlink;
    // rust: let t = Temp::new();
    // rust: let base = t.0.join("home");
    // rust: fs::create_dir(&base).unwrap();
    // rust: fs::create_dir(t.0.join("outside")).unwrap();
    // rust: symlink(t.0.join("outside"), base.join("resourcepacks")).unwrap();
    // rust: assert!(directory(&base, &base.join("resourcepacks/Look")).is_err());
    // rust: assert!(!t.0.join("outside/Look").exists());
    // The same layout one level up is the player's own: accepted.
    // rust: assert!(
    // rust: directory(
    // rust: &base.join("resourcepacks"),
    // rust: &base.join("resourcepacks/Look")
    // rust: )
    // rust: .is_ok()
    // rust: );
    // rust: assert!(t.0.join("outside/Look").is_dir());
}

indexed_downloads_are_hash_checked_and_failures_do_not_discard_other_packs :: proc() {
}
//     use import::PackFile;
    // rust: let t = Temp::new();
    // rust: fs::create_dir(t.work()).unwrap();
    // rust: let file = |name: &str| PackFile {
    // rust: path: format!("resourcepacks/{name}.zip"),
    // rust: sha1: Some(import::sha1_hex(b"pack")),
    // rust: downloads: vec![format!("https://cdn.modrinth.com/{name}.zip")],
    // rust: ..PackFile::default()
}
    // rust: let mut excluded = file("server");
    // rust: excluded.client = "unsupported".into();
    // rust: let mut missing = file("missing");
    // rust: missing.downloads = vec!["https://untrusted.example/pack.zip".into()];
    // rust: let mut no_hash = file("nohash");
    // rust: no_hash.sha1 = None;
    // rust: let pack = import::Pack {
    // rust: files: vec![file("good"), file("bad"), excluded, missing, no_hash],
    // rust: ..import::Pack::default()
}
    // rust: pipeline::write_json(&t.work().join("pack.json"), &pack).unwrap();
    // rust: let report = fetch_with(&t.work(), &|_| {}, &|url, hash, dest| {
    // rust: let bytes: &[u8] = if url.ends_with("bad.zip") {
    // rust: b"corrupt"
    // rust: } else {
    // rust: b"pack"
}
    // rust: crate::fetch::store_download(bytes, Some(hash), dest, false)
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/good.zip"].state,
    // rust: State::Available
    // rust: );
    // rust: assert_eq!(report.files["resourcepacks/bad.zip"].state, State::Failed);
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/server.zip"].state,
    // rust: State::Unsupported
    // rust: );
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/missing.zip"].state,
    // rust: State::Missing
    // rust: );
    // rust: assert_eq!(
    // rust: report.files["resourcepacks/nohash.zip"].state,
    // rust: State::Failed
    // rust: );
    // rust: assert!(!t.work().join("resourcepacks/bad.zip").exists());
    // rust: let again = fetch_with(&t.work(), &|_| {}, &|_, _, _| Err("offline".into())).unwrap();
    // rust: assert_eq!(
    // rust: again.files["resourcepacks/good.zip"].state,
    // rust: State::Available
    // rust: );
    // rust: put(&t.work().join("resourcepacks/good.zip"), b"user edit");
    // rust: let again = fetch_with(&t.work(), &|_| {}, &|url, _, _| {
    // rust: assert!(
    // rust: !url.ends_with("good.zip"),
    // rust: "must not download over an existing file"
    // rust: );
    // rust: Err("offline".into())
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(again.files["resourcepacks/good.zip"].state, State::Conflict);
    // rust: assert_eq!(
    // rust: fs::read(t.work().join("resourcepacks/good.zip")).unwrap(),
    // rust: b"user edit"
    // rust: );
}

interrupted_downloads_publish_nothing_and_keep_existing_files :: proc() {
}
Interrupted :: struct {
    // rust: impl Read for Interrupted {
read :: proc(self: ^Self, out: []u8) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if !self.0 {
    // rust: self.0 = true;
    // rust: out[0] = b'x';
    // rust: return Ok(1);
}
    // rust: Err(std::io::Error::new(
    // rust: std::io::ErrorKind::UnexpectedEof,
    // rust: "interrupted",
    // rust: ))
}
}
    // rust: let t = Temp::new();
    // rust: let dest = t.0.join("pack.zip");
    // rust: assert!(crate::fetch::store_download(Interrupted(false), None, &dest, false).is_err());
    // rust: assert!(!dest.exists());
    // rust: put(&dest, b"existing");
    // rust: assert!(
    // rust: crate::fetch::store_download(&b"bad"[..], Some(&import::sha1_hex(b"good")), &dest, false)
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!(fs::read(&dest).unwrap(), b"existing");
    // rust: assert!(
    // rust: crate::fetch::store_download(&b"new"[..], Some(&import::sha1_hex(b"new")), &dest, false)
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!(fs::read(&dest).unwrap(), b"existing");
    // rust: assert_eq!(fs::read_dir(&t.0).unwrap().count(), 1);
}

reports_include_embedded_packs_and_never_count_shaders_as_working :: proc() {
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("report.mrpack");
    // rust: archive(&src, &[
    // rust: ("modrinth.index.json", br#"{"files":[{"path":"resourcepacks/missing.zip"},{"path":"shaderpacks/later.zip"}]}"#),
    // rust: ("overrides/resourcepacks/look.zip", b"original"),
    // rust: ]);
    // rust: imported(&src, &t.work()).unwrap();
    // rust: pipeline::inventory(&t.work(), true, &|_| {}).unwrap();
    // rust: let rows = pipeline::report(&t.work(), &|_| {}).unwrap();
    // rust: assert_eq!(rows.len(), 3);
    // rust: let row = |path: &str| rows.iter().find(|r| r.key == path).unwrap();
    // rust: assert_eq!(
    // rust: row("resourcepacks/look.zip").status,
    // rust: crate::report::Status::Partial
    // rust: );
    // rust: assert!(
    // rust: row("resourcepacks/look.zip")
    // rust: .reason
    // rust: .contains("rendering not checked")
    // rust: );
    // rust: assert_eq!(
    // rust: row("shaderpacks/later.zip").status,
    // rust: crate::report::Status::NotYet
    // rust: );
    // rust: assert_eq!(
    // rust: row("resourcepacks/missing.zip").status,
    // rust: crate::report::Status::NotYet
    // rust: );
    // An old work directory without resourcepacks.json remains readable.
    // rust: fs::remove_file(t.work().join("resourcepacks.json")).unwrap();
    // rust: assert!(pipeline::report(&t.work(), &|_| {}).is_ok());
}

duplicate_archive_entries_are_rejected :: proc() {
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("duplicate.mrpack");
    // rust: archive(
    // rust: &src,
    // rust: &[
    // rust: ("modrinth.index.json", b"{}"),
    // rust: ("overrides/resourcepacks/a.zip", b"first"),
    // rust: ("overrides/resourcepacks/b.zip", b"second"),
    // rust: ],
    // rust: );
    // Rename both the local and central ZIP records; ZipWriter otherwise refuses duplicates.
    // rust: let mut bytes = fs::read(&src).unwrap();
    // rust: for i in 0..bytes.len().saturating_sub(4) {
    // rust: if &bytes[i..i + 5] == b"b.zip" {
    // rust: bytes[i] = b'a';
}
}
    // rust: fs::write(&src, bytes).unwrap();
    // A bad entry leaves the packs out; it no longer fails the import.
    // rust: assert!(imported(&src, &t.work()).is_ok());
    // rust: assert!(available(&t.work()).is_empty());
}

archive_symlinks_are_refused_and_file_counts_are_bounded :: proc() {
}
    // rust: let t = Temp::new();
    // rust: let src = t.0.join("link.mrpack");
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&src).unwrap());
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file("modrinth.index.json", options).unwrap();
    // rust: zip.write_all(b"{}").unwrap();
    // rust: zip.add_symlink(
    // rust: "overrides/resourcepacks/link.zip",
    // rust: "../../outside.zip",
    // rust: options,
    // rust: )
    // rust: .unwrap();
    // rust: zip.finish().unwrap();
    // A bad entry leaves the packs out; it no longer fails the import.
    // rust: assert!(imported(&src, &t.work()).is_ok());
    // rust: assert!(available(&t.work()).is_empty());
    // rust: let mut files: Files = (0..MAX_FILES)
    // rust: .map(|n| (format!("pack/{n}"), Vec::new()))
    // rust: .collect();
    // rust: assert!(add(&mut files, "pack/one-more", &b""[..], &mut 0).is_err());
}
