//! Transpiled from Horizon Rust crate
package horizon_optifine_paths

import "core:fmt"
import "core:mem"
import "core:math"

// Paths in OptiFine `.properties` files, and the folders that hold those files. Paths here are
// resource paths inside the overlay resource root (`assets/<namespace>/...`, `/`-separated),
// the tree `horizon_client::packs::resource_root` builds from the enabled packs.

// use std::collections::HashSet;
// use std::fs;
// use std::path::{Path, PathBuf};

// The resource path a value of the properties file at `props` names:
// - `~/x`: `assets/minecraft/optifine/x`;
// - `namespace:x`: `assets/namespace/x`;
// - `./x`, or a bare name without `/`: beside the properties file;
// - any other `a/b`: `assets/<the file's namespace>/a/b`.
//
// The extension is the caller's: OptiFine adds `.png` to textures that have none.
//
// `None` when the path would leave the resource root or is malformed: a `..` or `.` segment, an
// empty one (`a//b`, a leading `/`), as vanilla's resource paths refuse them, or a `\` (see
// [`valid`]). Callers join the result onto the overlay root, so a pack must never name a file
// outside it.
resolve :: proc(props: string, value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: in_root(resolve_unchecked(props, value))
}

// Whether a resource path stays in the root: no `.`, `..` or empty segment, and no `\` (a
// separator on Windows, where `..\..` would climb).
valid :: proc(path: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: path.split('/')
    // rust: .all(|segment| !matches!(segment, "" | "." | "..") && !segment.contains('\\'))
}

// `path` when it stays inside the resource root ([`valid`]).
    // rust: pub(crate) fn in_root(path: String) -> Option<String> {
    // rust: valid(&path).then_some(path)
}

resolve_unchecked :: proc(props: string, value: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let value = value.trim();
    // rust: let dir = props.rsplit_once('/').map_or("", |(dir, _)| dir);
    // rust: if let Some(rest) = value.strip_prefix("~/") {
    // rust: return format!("assets/minecraft/optifine/{rest}");
}
    // rust: if let Some(rest) = value.strip_prefix("./") {
    // rust: return format!("{dir}/{rest}");
}
    // rust: if let Some((ns, rest)) = value.split_once(':') {
    // rust: return format!("assets/{ns}/{rest}");
}
    // rust: if !value.contains('/') {
    // rust: return format!("{dir}/{value}");
}
    // rust: let namespace = props
    // rust: .strip_prefix("assets/")
    // rust: .and_then(|p| p.split('/').next())
    // rust: .unwrap_or("minecraft");
    // rust: format!("assets/{namespace}/{value}")
}

// Every `.properties` file under `assets/*/optifine/<feature>/` and the legacy
// `assets/*/mcpatcher/<feature>/` of `root`, as sorted resource paths. `feature` is a folder
// (`ctm`, `cit`, `random/entity`, `sky/world0`).
properties_files :: proc(root: ^Path, feature: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: properties_files_in(root, &["optifine", "mcpatcher"], feature)
}

// `properties_files` under other top folders too, for a feature a mod reads from its own
// (CIT Resewn's `citresewn/cit/`).
properties_files_in :: proc(root: ^Path, tops: ^[string], feature: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut seen = HashSet::new();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let ns = ns.file_name().to_string_lossy().into_owned();
    // rust: for top in tops {
    // rust: let base = format!("assets/{ns}/{top}/{feature}");
    // rust: walk(
    // rust: &root.join(&base),
    // rust: &base,
    // rust: &[".properties"],
    // rust: 0,
    // rust: &mut seen,
    // rust: &mut out,
    // rust: );
}
}
    // rust: out.sort();
    // rust: out
}

// The files under `root/<dir>` (`assets/minecraft/optifine/random`) whose names end in one of
// `endings`, as paths from `root`, sorted. Links are followed as [`properties_files`] does.
files_under :: proc(root: ^Path, dir: string, endings: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: walk(
    // rust: &root.join(dir),
    // rust: dir,
    // rust: endings,
    // rust: 0,
    // rust: &mut HashSet::new(),
    // rust: &mut out,
    // rust: );
    // rust: out.sort();
    // rust: out
}

// How deep a feature folder's tree is read: far past any real pack, short of a link loop's
// `PATH_MAX`.
MAX_DEPTH :: 16

    // rust: fn walk(
    // rust: dir: &Path,
    // rust: rel: &str,
    // rust: endings: &[&str],
    // rust: depth: usize,
    // rust: seen: &mut HashSet<PathBuf>,
    // rust: out: &mut Vec<String>,
    // rust: ) {
    // A prepared root's folder: from its data file, without listing the disk.
    // rust: if depth == 0
    // rust: && let Some(files) = horizon_core::prepared_files::files_under(dir)
    // rust: {
    // rust: out.extend(
    // rust: files
    // rust: .into_iter()
    // rust: .filter(|file| endings.iter().any(|end| file.ends_with(end)))
    // rust: .map(|file| format!("{rel}/{file}")),
    // rust: );
    // rust: return;
}
    // Links are followed (overlay folders are links into the packs and vanilla), so a link back
    // to a parent would loop: each real folder is read once, and never deeper than MAX_DEPTH.
    // rust: if depth > MAX_DEPTH || !fs::canonicalize(dir).is_ok_and(|real| seen.insert(real)) {
    // rust: return;
}
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}
    // rust: for e in entries.flatten() {
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: let rel = format!("{rel}/{name}");
        // `metadata` follows links: overlay folders are links into the packs and vanilla.
    // rust: match fs::metadata(e.path()) {
    // rust: Ok(m) if m.is_dir() => walk(&e.path(), &rel, endings, depth + 1, seen, out),
    // rust: Ok(_) if endings.iter().any(|end| name.ends_with(end)) => out.push(rel),
    // rust: _ => {}
}
}
}

    // rust: mod tests {
//     use super::*;

resolving :: proc() {
}
    // rust: let props = "assets/minecraft/optifine/cit/swords/flame.properties";
    // rust: let r = |v| resolve(props, v).unwrap();
    // rust: assert_eq!(r("flame"), "assets/minecraft/optifine/cit/swords/flame");
    // rust: assert_eq!(
    // rust: r("./sub/flame.png"),
    // rust: "assets/minecraft/optifine/cit/swords/sub/flame.png"
    // rust: );
    // rust: assert_eq!(
    // rust: r("~/cit/shared/glow.png"),
    // rust: "assets/minecraft/optifine/cit/shared/glow.png"
    // rust: );
    // rust: assert_eq!(
    // rust: r("textures/item/stick.png"),
    // rust: "assets/minecraft/textures/item/stick.png"
    // rust: );
    // rust: assert_eq!(r("mymod:textures/x.png"), "assets/mymod/textures/x.png");
    // rust: assert_eq!(
    // rust: resolve(
    // rust: "assets/mymod/optifine/ctm/a.properties",
    // rust: "textures/block/b.png"
    // rust: )
    // rust: .as_deref(),
    // rust: Some("assets/mymod/textures/block/b.png")
    // rust: );
        // Nothing outside the resource root.
    // rust: for bad in [
    // rust: "~/../../../../x",
    // rust: "..:x",
    // rust: "../x.png",
    // rust: "./../x",
    // rust: "a//b",
    // rust: "/etc/passwd",
    // rust: "a/./b",
    // rust: "..\\..\\x.jpm",
    // rust: "~/..\\..\\x",
    // rust: "..\\..\\x.png",
    // rust: ] {
    // rust: assert_eq!(resolve(props, bad), None, "{bad}");
}
}

finds_both_folders_in_every_namespace :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-optifine-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: for f in [
    // rust: "assets/minecraft/optifine/ctm/glass/glass.properties",
    // rust: "assets/minecraft/optifine/ctm/glass/0.png",
    // rust: "assets/minecraft/mcpatcher/ctm/old.properties",
    // rust: "assets/mymod/optifine/ctm/x/y.properties",
    // rust: "assets/minecraft/optifine/cit/sword.properties",
    // rust: ] {
    // rust: let path = root.join(f);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, "").unwrap();
}
    // rust: assert_eq!(
    // rust: properties_files(&root, "ctm"),
    // rust: [
    // rust: "assets/minecraft/mcpatcher/ctm/old.properties",
    // rust: "assets/minecraft/optifine/ctm/glass/glass.properties",
    // rust: "assets/mymod/optifine/ctm/x/y.properties",
    // rust: ]
    // rust: );
    // rust: fs::remove_dir_all(&root).unwrap();
}

a_link_loop_is_read_once :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-optifine-loop-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let ctm = root.join("assets/minecraft/optifine/ctm");
    // rust: fs::create_dir_all(&ctm).unwrap();
    // rust: fs::write(ctm.join("a.properties"), "").unwrap();
    // rust: std::os::unix::fs::symlink(&ctm, ctm.join("again")).unwrap();
    // rust: assert_eq!(
    // rust: properties_files(&root, "ctm"),
    // rust: ["assets/minecraft/optifine/ctm/a.properties"]
    // rust: );
    // rust: fs::remove_dir_all(&root).unwrap();
}
}
