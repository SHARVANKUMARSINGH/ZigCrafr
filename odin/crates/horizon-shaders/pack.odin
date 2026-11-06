//! Transpiled from Horizon Rust crate
package horizon_shaders_pack

import "core:fmt"
import "core:mem"
import "core:math"

// A pack is a folder or a `.zip` whose root holds a folder named `shaders`; everything else at
// the root (licences, readmes, decoy folders) is ignored (spec 1.1). Every path a pack uses is
// relative to that `shaders` folder, written with `/`.

// use std::collections::BTreeMap;
// use std::fmt;
// use std::fs;
// use std::io::{self, Cursor, Read};
// use std::path::{Path, PathBuf};
// use std::sync::Arc;

// use zip::ZipArchive;

ROOT :: "shaders"

Pack :: struct {
    name: string,
    files: Files,
    // The values the player chose for the pack's options, applied to its sources as they are
    // read (`options::apply`).
    chosen: BTreeMap<string,
}

Files :: enum {
    // The pack's `shaders` folder.
    Folder(PathBuf),
    // The archive and its entries under `shaders/`, by their path inside that folder.
    Zip {,
    archive: ZipArchive<Cursor<Arc<[u8]>>>,
    entries: BTreeMap<String, usize>,
    // rust: },
}

PackError :: enum {
    Io(io::Error),
    Zip(String),
    // A readable folder or archive with no `shaders` folder at its root.
    NoShadersFolder,
}

    // rust: impl fmt::Display for PackError {
fmt :: proc(self: ^Self, f: ^fmt::Formatter) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Io(e) => write!(f, "{e}"),
    // rust: Self::Zip(e) => write!(f, "not a readable zip: {e}"),
    // rust: Self::NoShadersFolder => f.write_str("no shaders folder at the root of the pack"),
}
}
}

    // rust: impl std::error::Error for PackError {}

    // rust: impl From<io::Error> for PackError {
from :: proc(e: io::Error) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Io(e)
}
}

    // rust: impl Pack {
    // Opens a pack folder or a `.zip` archive.
open :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = path
    // rust: .file_name()
    // rust: .map_or_else(String::new, |n| n.to_string_lossy().into_owned());
    // rust: let files = if path.is_dir() {
    // rust: let root = path.join(ROOT);
    // rust: if !root.is_dir() {
    // rust: return Err(PackError::NoShadersFolder);
}
    // rust: Files::Folder(root)
    // rust: } else {
    // rust: Self::zip_files(fs::read(path)?)?
}
    // rust: Ok(Self {
    // rust: name,
    // rust: files,
    // rust: chosen: BTreeMap::new(),
    // rust: })
}

    // An archive held in memory; `name` is what [`Pack::name`] returns.
from_zip_bytes :: proc(name: string, bytes: [dynamic]u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let files = Self::zip_files(bytes)?;
    // rust: Ok(Self {
    // rust: name: name.to_owned(),
    // rust: files,
    // rust: chosen: BTreeMap::new(),
    // rust: })
}

zip_files :: proc(bytes: [dynamic]u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let archive = ZipArchive::new(Cursor::new(Arc::from(bytes)))
    // rust: .map_err(|e| PackError::Zip(e.to_string()))?;
    // rust: let mut entries = BTreeMap::new();
    // rust: for i in 0..archive.len() {
    // rust: let Some(name) = archive.name_for_index(i) else {
    // rust: continue;
}
    // rust: let name = name
    // rust: .map_err(|e| PackError::Zip(e.to_string()))?
    // rust: .replace('\\', "/");
    // rust: if let Some(inner) = name.strip_prefix(ROOT).and_then(|n| n.strip_prefix('/'))
    // rust: && !inner.is_empty()
    // rust: && !inner.ends_with('/')
    // rust: {
    // rust: entries.insert(inner.to_owned(), i);
}
}
    // rust: if entries.is_empty() {
    // rust: return Err(PackError::NoShadersFolder);
}
    // rust: Ok(Files::Zip { archive, entries })
}

    // The pack with options at the values in `chosen` (name to value, `true` or `false` for a
    // switch) instead of their defaults. A value the option doesn't list (a file edited by
    // hand) is left out.
with_chosen :: proc(chosen: BTreeMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let options = crate::options(&self);
    // rust: self.chosen = chosen
    // rust: .into_iter()
    // rust: .filter(|(name, value)| options.get(name).is_some_and(|o| o.values.contains(value)))
    // rust: .collect();
    // rust: self
}

    // The folder or file name the pack was opened from (`BSL.zip`).
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.name
}

    // The bytes of a file, by its path inside `shaders` (`lang/en_us.lang`). `None` when it
    // doesn't exist or the path leaves the folder.
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let path = normalize(path)?;
    // rust: match &self.files {
    // rust: Files::Folder(root) => fs::read(root.join(&path)).ok(),
    // rust: Files::Zip { archive, entries } => {
                // A clone shares the bytes and the central directory; reading needs `&mut`.
    // rust: let mut archive = archive.clone();
    // rust: let mut entry = archive.by_index(*entries.get(&path)?).ok()?;
    // rust: let mut out = Vec::with_capacity(entry.size() as usize);
    // rust: entry.read_to_end(&mut out).ok()?;
    // rust: Some(out)
}
}
}

    // A text file, decoded as UTF-8 (invalid bytes replaced) without its byte-order mark, with
    // the chosen option values in its sources.
read_text :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = self.read(path)?;
    // rust: let text = String::from_utf8_lossy(&bytes);
    // rust: let text = text.strip_prefix('\u{feff}').unwrap_or(&text);
    // rust: let source = !path.ends_with(".properties") && !path.ends_with(".lang");
    // rust: Some(if source && !self.chosen.is_empty() {
    // rust: crate::options::apply(text, &self.chosen)
    // rust: } else {
    // rust: text.to_owned()
    // rust: })
}

exists :: proc(self: ^Self, path: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(path) = normalize(path) else {
    // rust: return false;
}
    // rust: match &self.files {
    // rust: Files::Folder(root) => root.join(path).is_file(),
    // rust: Files::Zip { entries, .. } => entries.contains_key(&path),
}
}

    // The names of the files directly inside a folder of the pack (`""` for `shaders` itself),
    // sorted.
list :: proc(self: ^Self, dir: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(dir) = normalize(dir) else {
    // rust: return Vec::new();
}
    // rust: let mut names: Vec<String> = match &self.files {
    // rust: Files::Folder(root) => fs::read_dir(root.join(&dir))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter(|e| e.file_type().is_ok_and(|t| t.is_file()))
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
    // rust: .collect(),
    // rust: Files::Zip { entries, .. } => {
    // rust: let prefix = if dir.is_empty() {
    // rust: String::new()
    // rust: } else {
    // rust: format!("{dir}/")
}
    // rust: entries
    // rust: .keys()
    // rust: .filter_map(|k| k.strip_prefix(&prefix))
    // rust: .filter(|rest| !rest.contains('/'))
    // rust: .map(str::to_owned)
    // rust: .collect()
}
}
    // rust: names.sort();
    // rust: names
}

    // Every file of the pack, by its path inside `shaders`, sorted.
all_files :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut names = match &self.files {
    // rust: Files::Folder(root) => {
    // rust: let mut names = Vec::new();
    // rust: let mut dirs = vec![String::new()];
    // rust: while let Some(dir) = dirs.pop() {
    // rust: for e in fs::read_dir(root.join(&dir))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: {
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: let path = if dir.is_empty() {
    // rust: name
    // rust: } else {
    // rust: format!("{dir}/{name}")
}
    // rust: match e.file_type() {
    // rust: Ok(t) if t.is_dir() => dirs.push(path),
    // rust: Ok(t) if t.is_file() => names.push(path),
    // rust: _ => {}
}
}
}
    // rust: names
}
    // rust: Files::Zip { entries, .. } => entries.keys().cloned().collect(),
}
    // rust: names.sort();
    // rust: names
}
}

// `a/./b/../c` → `a/c`; `None` for a path that climbs out of `shaders`.
    // rust: pub(crate) fn normalize(path: &str) -> Option<String> {
    // rust: let mut parts: Vec<&str> = Vec::new();
    // rust: for part in path.split(['/', '\\']) {
    // rust: match part {
    // rust: "" | "." => {}
    // rust: ".." => {
    // rust: parts.pop()?;
}
    // rust: _ => parts.push(part),
}
}
    // rust: Some(parts.join("/"))
}

    // rust: pub(crate) mod tests {
//     use super::*;
//     use std::io::Write;

    // A zip of `(path, contents)` pairs, paths from the archive root.
    // rust: pub(crate) fn zip<C: AsRef<[u8]>>(files: &[(&str, C)]) -> Vec<u8> {
    // rust: let mut w = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let options = zip::write::SimpleFileOptions::default()
    // rust: .compression_method(zip::CompressionMethod::Deflated);
    // rust: for (path, contents) in files {
    // rust: w.start_file(*path, options).unwrap();
    // rust: w.write_all(contents.as_ref()).unwrap();
}
    // rust: w.finish().unwrap().into_inner()
}

    // A fresh empty folder under the system's temp folder.
    // rust: pub(crate) fn temp_dir(name: &str) -> PathBuf {
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-shaders-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

zip_packs_read_only_the_shaders_folder :: proc() {
}
    // rust: let bytes = zip(&[
    // rust: ("License.txt", "x"),
    // rust: ("shaderFile_A.placebo/shaders.properties", "decoy"),
    // rust: ("shaders/shaders.properties", "sun=false"),
    // rust: ("shaders/lang/en_US.lang", "a=b"),
    // rust: ("shaders/lang/fr_FR.lang", "a=c"),
    // rust: ("shaders/lib/common.glsl", ""),
    // rust: ]);
    // rust: let pack = Pack::from_zip_bytes("P.zip", bytes).unwrap();
    // rust: assert_eq!(pack.read_text("shaders.properties").unwrap(), "sun=false");
    // rust: assert!(pack.exists("lib/common.glsl"));
    // rust: assert!(pack.exists("lib/../shaders.properties"));
    // rust: assert!(!pack.exists("../License.txt"));
    // rust: assert!(!pack.exists("License.txt"));
    // rust: assert_eq!(pack.list("lang"), ["en_US.lang", "fr_FR.lang"]);
    // rust: assert_eq!(pack.list(""), ["shaders.properties"]);
}

archives_without_a_shaders_folder_are_not_packs :: proc() {
}
    // rust: let bytes = zip(&[("Pack/shaders/final.fsh", ""), ("readme.txt", "")]);
    // rust: assert!(matches!(
    // rust: Pack::from_zip_bytes("P.zip", bytes),
    // rust: Err(PackError::NoShadersFolder)
    // rust: ));
    // rust: assert!(matches!(
    // rust: Pack::from_zip_bytes("P.zip", b"not a zip".to_vec()),
    // rust: Err(PackError::Zip(_))
    // rust: ));
}

folder_packs_read_the_same_way :: proc() {
}
    // rust: let dir = temp_dir("folder");
    // rust: fs::create_dir_all(dir.join("shaders/lang")).unwrap();
    // rust: fs::write(
    // rust: dir.join("shaders/lang/en_us.lang"),
    // rust: "\u{feff}option.A=Alpha",
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(dir.join("secret.txt"), "outside").unwrap();
    // rust: let pack = Pack::open(&dir).unwrap();
    // rust: assert_eq!(pack.read_text("lang/en_us.lang").unwrap(), "option.A=Alpha");
    // rust: assert_eq!(pack.list("lang"), ["en_us.lang"]);
    // rust: assert!(pack.read("../secret.txt").is_none());
    // rust: fs::remove_dir_all(&dir).unwrap();
}
}
