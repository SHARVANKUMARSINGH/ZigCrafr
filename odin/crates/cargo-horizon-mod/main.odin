//! Transpiled from Horizon Rust crate
package cargo_horizon_mod_main

import "core:fmt"
import "core:mem"
import "core:math"

// `cargo horizon-mod`: make Horizon content mods (`docs/modpacks.md`): blocks,
// items, data and assets, no code. Code mods are native (docs/native-mods.md).
//
// - `new <path> [--name "Name"]`: a content mod from the template; with
//   `--template native [--horizon <commit>]`, a native trait mod's bundle.
// - `build`: the `.hmod` in `target/horizon-mod/`, with the mod's `assets/`
//   and `data/`.
// - `run [--game <horizon-client>] [-- <game args>]`: build, then play with
//   the mod.
// - `check <file> [--json]`: what the registry checks of a submission
//   (`.hmod`, `.hnmod`, `.hpack`, resource pack `.zip`, `.hshader`).
// - `registry build|review|check|list`: the registry repository's CI.
// use horizon_mods::{Capability, Content, Manifest, Package, manifest::MANIFEST};
    // rust: mod check;
    // rust: mod registry;

// use std::{
    // rust: path::{Path, PathBuf},
    // rust: process::{Command, ExitCode},
}

main :: proc() -> E {
    // Ported from Horizon
    return {}
}
    // Cargo runs `cargo-horizon-mod horizon-mod <args>`.
    // rust: let mut args: Vec<String> = std::env::args().skip(1).collect();
    // rust: if args.first().is_some_and(|a| a == "horizon-mod") {
    // rust: args.remove(0);
}
    // rust: let result = match args.first().map(String::as_str) {
    // rust: Some("new") => new(&args[1..]),
    // rust: Some("build") => build().map(|p| {
    // rust: println!("Built {}", p.display());
    // rust: }),
    // rust: Some("run") => run(&args[1..]),
    // rust: Some("check") => check(&args[1..]),
    // rust: Some("registry") => registry::main(&args[1..]),
    // rust: _ => Err("usage: cargo horizon-mod new <path> [--name \"Name\"] [--template content|native [--horizon <commit>]] | build | run [--game <horizon-client>] [-- <game args>] | check <file> [--kind <kind>] [--key <public key> --signature <file.minisig>] [--json] | registry build|review|check|list".into()),
}
    // rust: match result {
    // rust: Ok(()) => ExitCode::SUCCESS,
    // rust: Err(e) => {
    // rust: eprintln!("error: {e}");
    // rust: ExitCode::FAILURE
}
}
}

// The value after `flag` in `args`.
    // rust: fn flag<'a>(args: &'a [String], flag: &str) -> Option<&'a str> {
    // rust: let i = args.iter().position(|a| a == flag)?;
    // rust: args.get(i + 1).map(String::as_str)
}

new :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = args
    // rust: .first()
    // rust: .filter(|a| !a.starts_with("--"))
    // rust: .ok_or("cargo horizon-mod new <path>")?;
    // rust: let dir = Path::new(path);
    // rust: if dir.exists() {
    // rust: return Err(format!("{} already exists", dir.display()));
}
    // rust: let base = dir
    // rust: .file_name()
    // rust: .and_then(|n| n.to_str())
    // rust: .ok_or("the path needs a folder name")?;
    // rust: let id: String = base
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_alphanumeric() {
    // rust: c.to_ascii_lowercase()
    // rust: } else {
    // rust: '_'
}
    // rust: })
    // rust: .collect();
    // rust: let name = flag(args, "--name").map_or_else(|| base.replace(['-', '_'], " "), str::to_string);
    // rust: let fill = |t: &str| t.replace("{id}", &id).replace("{name}", &name);
    // rust: match flag(args, "--template") {
    // rust: None | Some("content") => {}
    // rust: Some("native") => return new_native(dir, &id, flag(args, "--horizon"), fill),
    // rust: Some(_) => return Err("--template is content or native".into()),
}
    // A block copying a vanilla one, with its model, name, loot, recipe and tag.
    // rust: let files = [
    // rust: (
    // rust: MANIFEST,
    // rust: include_str!("../template/content/horizon-mod.toml"),
    // rust: ),
    // rust: (
    // rust: "data/{id}/horizon/block/glowing_amethyst.json",
    // rust: include_str!("../template/content/block.json"),
    // rust: ),
    // rust: (
    // rust: "assets/{id}/blockstates/glowing_amethyst.json",
    // rust: include_str!("../template/content/blockstate.json"),
    // rust: ),
    // rust: (
    // rust: "assets/{id}/models/block/glowing_amethyst.json",
    // rust: include_str!("../template/content/model.json"),
    // rust: ),
    // rust: (
    // rust: "assets/{id}/items/glowing_amethyst.json",
    // rust: include_str!("../template/content/item.json"),
    // rust: ),
    // rust: (
    // rust: "assets/{id}/lang/en_us.json",
    // rust: include_str!("../template/content/lang.json"),
    // rust: ),
    // rust: (
    // rust: "data/{id}/loot_table/blocks/glowing_amethyst.json",
    // rust: include_str!("../template/content/loot.json"),
    // rust: ),
    // rust: (
    // rust: "data/{id}/recipe/glowing_amethyst.json",
    // rust: include_str!("../template/content/recipe.json"),
    // rust: ),
    // rust: (
    // rust: "data/minecraft/tags/block/mineable/pickaxe.json",
    // rust: include_str!("../template/content/pickaxe.json"),
    // rust: ),
    // rust: (".gitignore", include_str!("../template/gitignore")),
    // rust: ];
    // rust: for (file, text) in files {
    // rust: let file = fill(file);
    // rust: let file = file.as_str();
    // rust: let to = dir.join(file);
    // rust: std::fs::create_dir_all(to.parent().expect("a file in the mod"))
    // rust: .map_err(|e| e.to_string())?;
    // rust: std::fs::write(&to, fill(text)).map_err(|e| format!("{}: {e}", to.display()))?;
}
    // rust: let manifest =
    // rust: Manifest::parse(&std::fs::read_to_string(dir.join(MANIFEST)).map_err(|e| e.to_string())?)?;
    // rust: Content::read(dir, &manifest)?;
    // rust: println!(
    // rust: "Created {} (mod id {id}). Next: cd {path} && cargo horizon-mod run",
    // rust: dir.display()
    // rust: );
    // rust: Ok(())
}

// A native trait mod's bundle in `dir` (docs/native-mods.md, "Trait mods"): its
// `horizon-mixin.toml` and an `[api]` crate with one hook. It is what the launcher
// builds (`native-build <dir>`) and packs as `mixins/<id>/` of a `.hnmod`
// (docs/api/mod-files.md). `horizon` pins the Horizon commit it is made for.
    // rust: fn new_native(
    // rust: dir: &Path,
    // rust: id: &str,
    // rust: horizon: Option<&str>,
    // rust: fill: impl Fn(&str) -> String,
    // rust: ) -> Result<(), String> {
    // `[mod] id`, as `horizon-native.json` needs it: the template keeps to its characters.
    // rust: if id.len() > 64 {
    // rust: return Err(format!("mod id {id}: 64 characters at most"));
}
    // rust: let (compatibility, rev) = match horizon {
    // rust: Some(commit) if horizon_mods::index::native::revision(commit) => (
    // rust: format!("[compatibility]\nhorizon_revision = \"{commit}\"\n"),
    // rust: format!(", rev = \"{commit}\""),
    // rust: ),
    // rust: Some(commit) => {
    // rust: return Err(format!(
    // rust: "--horizon {commit}: a Horizon commit is 40 lowercase hex digits"
    // rust: ));
}
        // Unpinned, it builds on the instance's own Horizon.
    // rust: None => (
    // rust: "# The Horizon commit it is made for; unpinned, it builds on the instance's own.\n\
    // rust: # [compatibility]\n# horizon_revision = \"<40 hex digits>\"\n"
    // rust: .to_owned(),
    // rust: String::new(),
    // rust: ),
}
    // rust: let files = [
    // rust: (
    // rust: "horizon-mixin.toml",
    // rust: include_str!("../template/native/horizon-mixin.toml"),
    // rust: ),
    // rust: (
    // rust: "api/Cargo.toml",
    // rust: include_str!("../template/native/api.toml"),
    // rust: ),
    // rust: ("api/src/lib.rs", include_str!("../template/native/lib.rs")),
    // rust: (".gitignore", include_str!("../template/gitignore")),
    // rust: ];
    // rust: for (file, text) in files {
    // rust: let to = dir.join(file);
    // rust: std::fs::create_dir_all(to.parent().expect("a file in the mod"))
    // rust: .map_err(|e| e.to_string())?;
    // rust: let text = fill(text)
    // rust: .replace("{compatibility}", &compatibility)
    // rust: .replace("{rev}", &rev);
    // rust: std::fs::write(&to, text).map_err(|e| format!("{}: {e}", to.display()))?;
}
    // rust: println!(
    // rust: "Created {} (native mod id {id}). Next: horizon-launcher native-build {} --instance <instance> --trust-native-code",
    // rust: dir.display(),
    // rust: dir.display()
    // rust: );
    // rust: Ok(())
}

// Packs the content mod in the current folder into `target/horizon-mod/<id>.hmod`: the
// manifest and the files in `assets/` and `data/`.
build :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: build_in(Path::new("."))
}

build_in :: proc(root: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let manifest_text = std::fs::read_to_string(root.join(MANIFEST))
    // rust: .map_err(|e| format!("{MANIFEST}: {e} (run this in a mod's folder)"))?;
    // rust: let manifest = Manifest::parse(&manifest_text)?;
    // rust: if root.join("Cargo.toml").exists() {
    // rust: return Err("a Cargo.toml: code mods are native now (docs/native-mods.md)".into());
}
    // rust: if !manifest.capabilities.contains(&Capability::Registries) {
    // rust: return Err(format!(
    // rust: "a content mod has capability registries in {MANIFEST}"
    // rust: ));
}
    // The same checks as the game's, and the files in the order it lists them.
    // rust: let content = Content::read(root, &manifest)?;
    // rust: let mut reader = content.reader()?;
    // rust: let mut files = Vec::with_capacity(content.files.len());
    // rust: for name in &content.files {
    // rust: files.push((name.as_str(), reader.read(name)?));
}
    // rust: let files: Vec<(&str, &[u8])> = files.iter().map(|(n, b)| (*n, b.as_slice())).collect();
    // rust: let dir = root.join("target/horizon-mod");
    // rust: std::fs::create_dir_all(&dir).map_err(|e| e.to_string())?;
    // rust: let path = dir.join(format!("{}.hmod", manifest.id));
    // Write then rename, so a running game never reads half a file.
    // rust: let partial = path.with_extension("hmod.partial");
    // rust: let bytes = Package::write_files(&manifest_text, None, &files)?;
    // rust: std::fs::write(&partial, bytes).map_err(|e| e.to_string())?;
    // rust: std::fs::rename(&partial, &path).map_err(|e| e.to_string())?;
    // rust: Ok(path)
}

// `check <file>`: the registry's checks of a submission, printed; fails
// when one does.
check :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let file = args
    // rust: .first()
    // rust: .filter(|a| !a.starts_with("--"))
    // rust: .ok_or("cargo horizon-mod check <file>")?;
    // rust: let path = Path::new(file);
    // rust: let kind = match flag(args, "--kind") {
    // rust: Some(k) => horizon_mods::index::Kind::from(k.to_string()),
    // rust: None => check::kind_of(path)
    // rust: .ok_or("pass --kind mod|modpack|resourcepack: the extension doesn't say")?,
}
    // rust: let signature = flag(args, "--signature")
    // rust: .map(|p| std::fs::read_to_string(p).map_err(|e| format!("{p}: {e}")))
    // rust: .transpose()?;
    // rust: let report = check::check(path, kind, flag(args, "--key"), signature.as_deref());
    // rust: if args.iter().any(|a| a == "--json") {
    // rust: let json = match &report {
    // rust: Ok(r) => serde_json::json!({"ok": true, "report": r.json()}),
    // rust: Err(e) => serde_json::json!({"ok": false, "error": e}),
}
    // rust: println!("{json}");
}
    // rust: let report = report?;
    // rust: if !args.iter().any(|a| a == "--json") {
    // rust: print!("{}", report.text());
}
    // rust: Ok(())
}

run :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = build()?;
    // rust: let game = flag(args, "--game")
    // rust: .map(str::to_string)
    // rust: .or_else(|| std::env::var("HORIZON_CLIENT").ok())
    // rust: .unwrap_or_else(|| "horizon-client".into());
    // rust: let extra = args.iter().skip_while(|a| *a != "--").skip(1);
    // rust: println!("Starting {game} with {}", path.display());
    // rust: let status = Command::new(&game)
    // rust: .arg("--dev-mod")
    // rust: .arg(&path)
    // rust: .args(extra)
    // rust: .status()
    // rust: .map_err(|e| {
    // rust: format!("{game}: {e} (pass --game <path to horizon-client> or set HORIZON_CLIENT)")
    // rust: })?;
    // rust: status
    // rust: .success()
    // rust: .then_some(())
    // rust: .ok_or_else(|| format!("the game exited with {status}"))
}

    // rust: mod tests {
//     use super::*;

the_content_template_builds_and_checks_with_no_code :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mod-content-{}", std::process::id()));
    // rust: let path = dir.join("gems");
    // rust: let new_args = [
    // rust: path.display().to_string(),
    // rust: "--template".into(),
    // rust: "content".into(),
    // rust: ];
    // rust: new(&new_args).unwrap();
    // rust: assert!(!path.join("Cargo.toml").exists());
    // rust: let hmod = build_in(&path).unwrap();
    // rust: assert_eq!(hmod, path.join("target/horizon-mod/gems.hmod"));
    // rust: let package = Package::read(&hmod).unwrap();
    // rust: assert!(package.wasm.is_none());
    // rust: let content = Content::read(&hmod, &package.manifest).unwrap();
    // rust: assert!(
    // rust: content
    // rust: .files
    // rust: .contains(&"data/gems/horizon/block/glowing_amethyst.json".into())
    // rust: );
    // rust: assert_eq!(content.files.len(), 8, "{:?}", content.files);
    // rust: let report = check::check(&hmod, check::kind_of(&hmod).unwrap(), None, None).unwrap();
    // rust: assert!(
    // rust: report.text().contains("no code: content only"),
    // rust: "{}",
    // rust: report.text()
    // rust: );
        // Code is native now.
    // rust: std::fs::write(path.join("Cargo.toml"), "").unwrap();
    // rust: assert!(build_in(&path).unwrap_err().contains("native"));
    // rust: assert!(
    // rust: new(&[
    // rust: dir.join("x").display().to_string(),
    // rust: "--template".into(),
    // rust: "lua".into()
    // rust: ])
    // rust: .is_err()
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

the_native_template_packs_into_an_hnmod_the_registry_accepts :: proc() {
}
//         use std::io::Write;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-mod-native-{}", std::process::id()));
    // rust: let path = dir.join("machine-mod");
    // rust: let commit = "0123456789abcdef0123456789abcdef01234567";
    // rust: let args = [
    // rust: path.display().to_string(),
    // rust: "--template".into(),
    // rust: "native".into(),
    // rust: "--horizon".into(),
    // rust: commit.into(),
    // rust: ];
    // rust: new(&args).unwrap();
    // rust: let api = std::fs::read_to_string(path.join("api/Cargo.toml")).unwrap();
    // rust: assert!(api.contains(&format!("rev = \"{commit}\"")), "{api}");
        // Packed as the launcher packs a mod folder: the manifest, then the bundle under
        // `mixins/<id>/` (docs/api/mod-files.md).
    // rust: let manifest = serde_json::json!({
    // rust: "schema": 1, "id": "machine_mod", "version": "0.1.0", "game": "26.3",
    // rust: "horizon": commit, "mixins": "b".repeat(40),
    // rust: });
    // rust: let hnmod = dir.join("machine_mod.hnmod");
    // rust: let mut zip = zip::ZipWriter::new(std::fs::File::create(&hnmod).unwrap());
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file("horizon-native.json", options).unwrap();
    // rust: zip.write_all(manifest.to_string().as_bytes()).unwrap();
    // rust: for file in [
    // rust: "horizon-mixin.toml",
    // rust: "api/Cargo.toml",
    // rust: "api/src/lib.rs",
    // rust: ".gitignore",
    // rust: ] {
    // rust: assert!(horizon_mods::index::native::allowed(file), "{file}");
    // rust: zip.start_file(format!("mixins/machine_mod/{file}"), options)
    // rust: .unwrap();
    // rust: zip.write_all(&std::fs::read(path.join(file)).unwrap())
    // rust: .unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let report = check::check(&hnmod, check::kind_of(&hnmod).unwrap(), None, None).unwrap();
    // rust: assert!(report.text().contains("machine_mod"), "{}", report.text());
        // A pin that is not a commit is refused; with none, the folder builds on the
        // instance's Horizon.
    // rust: let bad = [
    // rust: dir.join("bad").display().to_string(),
    // rust: "--template".into(),
    // rust: "native".into(),
    // rust: "--horizon".into(),
    // rust: "main".into(),
    // rust: ];
    // rust: assert!(new(&bad).unwrap_err().contains("40 lowercase hex"));
    // rust: let free = dir.join("free");
    // rust: new(&[
    // rust: free.display().to_string(),
    // rust: "--template".into(),
    // rust: "native".into(),
    // rust: ])
    // rust: .unwrap();
    // rust: let mixin = std::fs::read_to_string(free.join("horizon-mixin.toml")).unwrap();
    // rust: assert!(!mixin.contains("\nhorizon_revision"), "{mixin}");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
