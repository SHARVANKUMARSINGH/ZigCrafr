//! Transpiled from Horizon Rust crate
package horizon_client_render_cache

import "core:fmt"
import "core:mem"
import "core:math"

// Overlay reuse validated by source topology and filesystem stamps.
// Published output is an owned cache artifact; hits do not traverse its tree.
// use super::{Pack, Source, build_overlay_uncached};
// use crate::zip::Zip;
// use serde::{Deserialize, Serialize};
// use sha2::{Digest, Sha256};
// use std::io::Read;
// use std::{collections::BTreeSet, fs, io, path::Path, path::PathBuf};

// Bump when overlay/merge semantics change. Markers are disposable cache data.
// Version 4 mirrored every untouched directory file by file on Windows.
// Version 3 could omit untouched vanilla directories on Windows (#1649, #1688).
// Version 5 read every vanilla file to stamp it on Windows.
// Version 6 stamps vanilla's files by their metadata on Windows too.
// Version 7 stacks blockstate files (every pack's definition, bottom first).
VERSION :: 8

    // rust: pub(super) struct Dependencies {
    // rust: entries: Vec<(PathBuf, bool, String)>,
    // rust: failed: bool,
    // rust: tracking: bool,
    // The vanilla root (absolute): its files are stamped without reading them.
    // rust: vanilla: PathBuf,
}
    // rust: impl Dependencies {
record :: proc(self: ^Self, path: ^Path, directory: bool) {
}
    // rust: if !self.tracking {
    // rust: return;
}
    // rust: match dependency_signature(path, directory, &self.vanilla) {
    // rust: Ok(signature) => self.entries.push((path.into(), directory, signature)),
    // rust: Err(_) => self.failed = true,
}
}
    // rust: pub(super) fn file(&mut self, path: &Path) {
    // rust: self.record(path, false);
}
    // rust: pub(super) fn directory(&mut self, path: &Path) {
    // rust: self.record(path, true);
}
valid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.failed
    // rust: && self.entries.iter().all(|(path, directory, signature)| {
    // rust: dependency_signature(path, *directory, &self.vanilla).is_ok_and(|s| s == *signature)
    // rust: })
}
}

Marker :: struct {
    version: u32,
    vanilla: PathBuf,
    packs: string,
    dependencies: Dependencies,
}

finish :: proc(hash: Sha256) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{:x}", hash.finalize())
}
// Length framing keeps distinct paths/configurations unambiguous.
field :: proc(hash: ^Sha256, bytes: []u8) {
}
    // rust: hash.update((bytes.len() as u64).to_le_bytes());
    // rust: hash.update(bytes);
}
content :: proc(hash: ^Sha256, path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut file = fs::File::open(path)?;
    // rust: hash.update(file.metadata()?.len().to_le_bytes());
    // rust: let mut buffer = [0; 64 * 1024];
    // rust: loop {
    // rust: let n = file.read(&mut buffer)?;
    // rust: if n == 0 {
    // rust: break;
}
    // rust: hash.update(&buffer[..n]);
}
    // rust: Ok(())
}
// The largest zip hashed by its bytes: vanilla's limit on a server pack.
WHOLE_ZIP :: 250 << 20
// A zip up to `whole` by its bytes, which also catches an edit its checksums
// don't show (a pack may leave them empty, nothing reads them). A larger one
// would take minutes on every check, so by its stamp and its directory: what a
// local pack changes when it is replaced, and the directory reads in a moment.
zip_content :: proc(hash: ^Sha256, path: ^Path, whole: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let meta = fs::metadata(path)?;
    // rust: match Zip::open(path) {
    // rust: Ok(zip) if meta.len() > whole => {
    // rust: hash.update(meta.len().to_le_bytes());
    // rust: field(hash, format!("{:?}", meta.modified()?).as_bytes());
    // rust: hash.update(zip.directory());
    // rust: Ok(())
}
    // rust: _ => content(hash, path),
}
}
// `path`'s stamp; `read` lets platforms without a change timestamp hash a file's bytes.
stamp :: proc(hash: ^Sha256, path: ^Path, read: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let meta = fs::metadata(path)?;
    // rust: hash.update(meta.len().to_le_bytes());
    // rust: field(hash, format!("{:?}", meta.modified()?).as_bytes());
    // rust: {
//         use std::os::unix::fs::MetadataExt;
        // The change time stands in for the bytes here.
    // rust: let _ = read;
    // rust: hash.update(meta.dev().to_le_bytes());
    // rust: hash.update(meta.ino().to_le_bytes());
    // rust: hash.update(meta.ctime().to_le_bytes());
    // rust: hash.update(meta.ctime_nsec().to_le_bytes());
}
    // rust: {
        // Portable metadata lacks a change timestamp. Preserve content-based
        // validation for the packs' materialized files on those platforms;
        // vanilla's (the launcher's, tens of thousands) keep to the size and
        // the write and creation times: reading each costs minutes on Windows,
        // where every open is scanned by the antivirus.
    // rust: if read && meta.is_file() {
    // rust: return content(hash, path);
}
    // rust: if let Ok(created) = meta.created() {
    // rust: field(hash, format!("{created:?}").as_bytes());
}
}
    // rust: Ok(())
}
entries :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = fs::read_dir(path)?
    // rust: .map(|e| e.map(|e| e.path()))
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: entries.sort();
    // rust: Ok(entries)
}
dependency_signature :: proc(path: ^Path, directory: bool, vanilla: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hash = Sha256::new();
    // rust: let read = !(path.starts_with(vanilla) || absolute(path).is_ok_and(|p| p.starts_with(vanilla)));
    // rust: match fs::metadata(path) {
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => field(&mut hash, b"missing"),
    // rust: Err(e) => return Err(e),
    // rust: Ok(meta) if directory && meta.is_dir() => {
    // rust: field(&mut hash, b"directory");
    // rust: stamp(&mut hash, path, read)?;
}
    // rust: Ok(_) if directory => field(&mut hash, b"not-directory"),
    // rust: Ok(_) => stamp(&mut hash, path, read)?,
}
    // rust: Ok(finish(hash))
}
tree :: proc(hash: ^Sha256, path: ^Path, pack: Maybe(^Pack)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: tree_inner(hash, path, pack, &mut BTreeSet::new())
}

needs_content :: proc(path: ^Path, pack: Maybe(^Pack)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(pack) = pack.filter(|_| cfg!(unix)) else {
    // rust: return true;
}
    // rust: let Source::Dir(root) = &pack.source else {
    // rust: return true;
}
    // rust: let relative = path
    // rust: .strip_prefix(root)
    // rust: .unwrap()
    // rust: .to_string_lossy()
    // rust: .replace('\\', "/");
    // Ordinary folder resources are live Unix file symlinks. Rewrites and
    // replacements at that path are visible without rebuilding. Merged JSON
    // and configuration bytes are materialized and need stamp validation.
    // rust: relative == "pack.mcmeta"
    // rust: || super::merge_kind(&relative).is_some()
    // rust: || pack.overlays.iter().any(|overlay| {
    // rust: path.strip_prefix(root.join(overlay.trim_end_matches('/')))
    // rust: .ok()
    // rust: .is_some_and(|name| {
    // rust: super::merge_kind(&name.to_string_lossy().replace('\\', "/")).is_some()
    // rust: })
    // rust: })
}
    // rust: fn tree_inner(
    // rust: hash: &mut Sha256,
    // rust: path: &Path,
    // rust: pack: Option<&Pack>,
    // rust: active: &mut BTreeSet<PathBuf>,
    // rust: ) -> io::Result<()> {
    // rust: let meta = fs::symlink_metadata(path)?;
    // rust: if meta.is_symlink() {
    // rust: field(hash, b"link");
    // rust: field(hash, fs::read_link(path)?.as_os_str().as_encoded_bytes());
    // rust: if pack.is_none() {
    // rust: return Ok(());
}
}
    // rust: if path.is_dir() {
    // rust: let canonical = if pack.is_some() {
    // rust: let canonical = fs::canonicalize(path)?;
    // rust: if !active.insert(canonical.clone()) {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "pack symlink cycle",
    // rust: ));
}
    // rust: Some(canonical)
    // rust: } else {
    // rust: None
}
    // rust: field(hash, b"directory");
    // rust: for entry in entries(path)? {
    // rust: field(hash, entry.file_name().unwrap().as_encoded_bytes());
    // rust: tree_inner(hash, &entry, pack, active)?;
}
    // rust: field(hash, b"end-directory");
    // rust: if let Some(canonical) = canonical {
    // rust: active.remove(&canonical);
}
    // rust: } else {
    // rust: field(hash, b"file");
    // rust: if needs_content(path, pack) {
    // rust: if pack.is_none() {
    // rust: return content(hash, path);
}
    // rust: stamp(hash, path, true)?;
}
}
    // rust: Ok(())
}
output_signature :: proc(out: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hash = Sha256::new();
    // rust: tree(&mut hash, out, None)?;
    // rust: Ok(finish(hash))
}
pack_signature :: proc(packs: ^[Pack]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hash = Sha256::new();
    // rust: field(&mut hash, &[u8::from(cfg!(unix))]);
    // rust: for pack in packs {
    // rust: if matches!(pack.source, Source::Dir(_))
    // rust: && pack.overlays.iter().any(|overlay| {
    // rust: Path::new(overlay).components().any(|component| {
    // rust: matches!(
    // rust: component,
    // rust: std::path::Component::ParentDir
    // rust: | std::path::Component::RootDir
    // rust: | std::path::Component::Prefix(_)
    // rust: )
    // rust: })
    // rust: })
    // rust: {
            // The builder historically accepts external overlay roots. Preserve
            // that behavior, but don't cache dependencies outside this pack tree.
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidInput,
    // rust: "external pack overlay",
    // rust: ));
}
    // rust: field(&mut hash, pack.id.as_bytes());
        // Includes source kind/path, overlay order and compiled filter settings.
    // rust: field(&mut hash, format!("{:?}", pack.source).as_bytes());
    // rust: field(&mut hash, format!("{:?}", pack.overlays).as_bytes());
    // rust: field(&mut hash, format!("{:?}", pack.filter).as_bytes());
    // rust: match &pack.source {
    // rust: Source::Dir(path) => {
    // rust: field(&mut hash, absolute(path)?.as_os_str().as_encoded_bytes());
    // rust: tree(&mut hash, path, Some(pack))?;
}
    // rust: Source::Zip(path) => {
    // rust: field(&mut hash, absolute(path)?.as_os_str().as_encoded_bytes());
                // By its bytes, not its stamp: a server pack found in the download cache is
                // marked used on every join (`HttpUtil.updateModificationTime`), and a new
                // time rebuilt the whole overlay each time.
    // rust: zip_content(&mut hash, path, WHOLE_ZIP)?;
}
}
}
    // rust: Ok(finish(hash))
}

    // rust: pub(super) fn marker_path(out: &Path) -> PathBuf {
    // Outside the resource tree: no resource-name collisions or mirror changes.
    // rust: let mut name = out.as_os_str().to_os_string();
    // rust: name.push(".overlay-cache.json");
    // rust: PathBuf::from(name)
}

absolute :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if path.is_absolute() {
    // rust: Ok(path.into())
    // rust: } else {
    // rust: std::env::current_dir().map(|cwd| cwd.join(path))
}
}

lock_path :: proc(out: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: marker_path(out).with_extension("lock")
}

    // rust: pub(super) fn build(vanilla: &Path, packs: &[Pack], out: &Path) -> io::Result<()> {
    // rust: if let Some(parent) = out.parent().filter(|p| !p.as_os_str().is_empty()) {
    // rust: fs::create_dir_all(parent)?;
}
    // Keep this inode persistent: deleting it would let waiters and new callers
    // acquire different locks. Closing the file releases the advisory OS lock.
    // rust: let lock = fs::OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .open(lock_path(out))?;
    // rust: lock.lock()?;
    // rust: let vanilla_key = absolute(vanilla)?;
    // rust: let marker_path = marker_path(out);
    // rust: let signature = pack_signature(packs);
    // rust: if let Ok(signature) = &signature
    // rust: && let Ok(bytes) = fs::read(&marker_path)
    // rust: && let Ok(mut marker) = serde_json::from_slice::<Marker>(&bytes)
    // rust: && marker.version == VERSION
    // rust: && marker.vanilla == vanilla_key
    // rust: && marker.packs == *signature
    // rust: && {
    // rust: marker.dependencies.vanilla = vanilla_key.clone();
    // rust: marker.dependencies.valid()
}
    // rust: && out.is_dir()
    // rust: {
    // rust: return Ok(());
}
    // An interrupted/failed rebuild must never leave a reusable marker.
    // rust: match fs::remove_file(&marker_path) {
    // rust: Ok(()) => {}
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => {}
    // rust: Err(e) => return Err(e),
}
    // rust: let mut dependencies = Dependencies {
    // rust: tracking: signature.is_ok(),
    // rust: vanilla: vanilla_key.clone(),
    // rust: ..Dependencies::default()
}
    // rust: build_overlay_uncached(vanilla, packs, out, &mut dependencies)?;
    // rust: if let Ok(signature) = signature
    // rust: && dependencies.valid()
    // rust: && pack_signature(packs).is_ok_and(|s| s == signature)
    // rust: {
    // rust: let marker = Marker {
    // rust: version: VERSION,
    // rust: vanilla: vanilla_key,
    // rust: packs: signature,
    // rust: dependencies,
}
        // PathBuf serialization requires UTF-8; unusual resource root names
        // can still build normally without a reusable marker.
    // rust: let Ok(bytes) = serde_json::to_vec(&marker) else {
    // rust: return Ok(());
}
        // Publish only a complete marker, after all output writes succeeded.
    // rust: let temporary = marker_path.with_extension("tmp");
    // rust: fs::write(&temporary, bytes)?;
    // rust: fs::rename(&temporary, &marker_path)?;
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use crate::{packs, text::Text};
//     use std::sync::atomic::{AtomicUsize, Ordering};

Fixture :: struct {
    // rust: impl Fixture {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
NEXT :: AtomicUsize::new(0)
    // rust: let path = std::env::temp_dir().join(format!(
    // rust: "horizon-overlay-cache-{}-{}",
    std: :process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&path);
    fs: :create_dir_all(^path).unwrap(),
    // rust: Self(path)
}
write :: proc(self: ^Self, name: string, bytes: []u8) {
}
    // rust: let path = self.0.join(name);
    // rust: fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: fs::write(path, bytes).unwrap();
}
        // Waits for the filesystem's clock to move on, as it does between a build and a
        // person's next edit. On Unix the cache compares stamps (length, mtime, ctime, inode),
        // and Linux takes them from a coarse clock (a few milliseconds a tick): an edit in the
        // tick of the build before kept them all, and the tests failed at random.
next_tick :: proc(self: ^Self) {
}
    // rust: let probe = self.0.with_extension("tick");
            // New bytes each time: NTFS keeps the time of a write that changes nothing.
    // rust: let stamp = |n: u32| {
    // rust: fs::write(&probe, n.to_le_bytes()).unwrap();
    // rust: fs::metadata(&probe).unwrap().modified().unwrap()
}
    // rust: let start = stamp(0);
            // A second at most: no clock is that coarse, and a test never hangs on one.
    // rust: for n in 1..1000 {
    // rust: std::thread::sleep(std::time::Duration::from_millis(1));
    // rust: if stamp(n) != start {
    // rust: break;
}
}
    // rust: let _ = fs::remove_file(&probe);
}
dir_pack :: proc(self: ^Self, name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.write(
    // rust: &format!("{name}/pack.mcmeta"),
    // rust: br#"{"pack":{"description":"test","pack_format":97}}"#,
    // rust: );
    // rust: packs::pack(name.into(), Text::empty(), Source::Dir(self.0.join(name))).unwrap()
}
rebuild_matches :: proc(self: ^Self, selected: ^[Pack]) {
}
    // rust: let vanilla = self.0.join("vanilla");
    // rust: let cached = self.0.join("cached");
    // rust: packs::build_overlay(&vanilla, selected, &cached).unwrap();
    // rust: build_overlay_uncached(
    // rust: &vanilla,
    // rust: selected,
    // rust: &self.0.join("reference"),
    // rust: &mut Dependencies::default(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: output_signature(&cached).unwrap(),
    // rust: output_signature(&self.0.join("reference")).unwrap()
    // rust: );
    // rust: self.next_tick();
}
}
    // rust: impl Drop for Fixture {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

    // Stored/deflated ZIP fixture using the production reader, no zip dependency.
archive :: proc(files: ^[(string) {
}
    // rust: let mut out = Vec::new();
    // rust: let mut central = Vec::new();
    // rust: for (name, body) in files {
    // rust: let data = if deflate {
    // rust: miniz_oxide::deflate::compress_to_vec(body, 6)
    // rust: } else {
    // rust: body.clone()
}
    // rust: let offset = out.len() as u32;
    // rust: out.extend(0x0403_4b50u32.to_le_bytes());
    // rust: out.extend([20, 0, 0, 0]);
    // rust: out.extend((if deflate { 8u16 } else { 0 }).to_le_bytes());
    // rust: out.extend([0; 8]);
    // rust: out.extend((data.len() as u32).to_le_bytes());
    // rust: out.extend((body.len() as u32).to_le_bytes());
    // rust: out.extend((name.len() as u16).to_le_bytes());
    // rust: out.extend(0u16.to_le_bytes());
    // rust: out.extend(name.as_bytes());
    // rust: out.extend(&data);
    // rust: central.extend(0x0201_4b50u32.to_le_bytes());
    // rust: central.extend([20, 0, 20, 0, 0, 0]);
    // rust: central.extend((if deflate { 8u16 } else { 0 }).to_le_bytes());
    // rust: central.extend([0; 8]);
    // rust: central.extend((data.len() as u32).to_le_bytes());
    // rust: central.extend((body.len() as u32).to_le_bytes());
    // rust: central.extend((name.len() as u16).to_le_bytes());
    // rust: central.extend([0; 12]);
    // rust: central.extend(offset.to_le_bytes());
    // rust: central.extend(name.as_bytes());
}
    // rust: let start = out.len() as u32;
    // rust: out.extend(&central);
    // rust: out.extend(0x0605_4b50u32.to_le_bytes());
    // rust: out.extend([0; 4]);
    // rust: out.extend((files.len() as u16).to_le_bytes());
    // rust: out.extend((files.len() as u16).to_le_bytes());
    // rust: out.extend((central.len() as u32).to_le_bytes());
    // rust: out.extend(start.to_le_bytes());
    // rust: out.extend([0; 2]);
    // rust: out
}

texture_only_packs_rebuild_incomplete_windows_v3_overlays :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: let blockstate = "assets/minecraft/blockstates/oak_stairs.json";
    // rust: let model = "assets/minecraft/models/block/oak_stairs.json";
    // rust: let texture = "assets/minecraft/textures/block/stone.png";
    // rust: let font = "assets/minecraft/textures/font/ascii.png";
    // rust: f.write(&format!("vanilla/{blockstate}"), br#"{"variants":{}}"#);
    // rust: f.write(&format!("vanilla/{model}"), br#"{"elements":[]}"#);
    // rust: f.write(&format!("vanilla/{texture}"), b"vanilla texture");
    // rust: f.write(&format!("vanilla/{font}"), b"vanilla font");
    // rust: let folder = f.dir_pack("textures");
    // rust: f.write(&format!("textures/{texture}"), b"pack texture");
    // rust: f.write(
    // rust: "textures.zip",
    // rust: &archive(
    // rust: &[
    // rust: (
    // rust: "pack.mcmeta",
    // rust: br#"{"pack":{"description":"test","pack_format":97}}"#.to_vec(),
    // rust: ),
    // rust: (texture, b"pack texture".to_vec()),
    // rust: ],
    // rust: true,
    // rust: ),
    // rust: );
    // rust: let zip = packs::pack(
    // rust: "zip".into(),
    // rust: Text::empty(),
    // rust: Source::Zip(f.0.join("textures.zip")),
    // rust: )
    // rust: .unwrap();
    // rust: let vanilla = f.0.join("vanilla");
    // rust: for pack in [folder, zip] {
    // rust: let out = f.0.join(format!("cached-{}", pack.id));
    // rust: let selected = std::slice::from_ref(&pack);
    // rust: packs::build_overlay(&vanilla, selected, &out).unwrap();
    // rust: let check = || {
    // rust: for name in [blockstate, model, font] {
    // rust: assert_eq!(
    // rust: fs::read(out.join(name)).unwrap(),
    // rust: fs::read(vanilla.join(name)).unwrap()
    // rust: );
}
    // rust: assert_eq!(fs::read(out.join(texture)).unwrap(), b"pack texture");
}
    // rust: check();
            // Before #1688, Windows silently omitted untouched directories.
            // A v3 marker still validates because it checks only source files.
    // rust: let marker_path = marker_path(&out);
    // rust: let mut marker: Marker =
    // rust: serde_json::from_slice(&fs::read(&marker_path).unwrap()).unwrap();
    // rust: marker.version = 3;
    // rust: for dir in ["blockstates", "models", "textures/font"] {
    // rust: fs::remove_dir_all(out.join("assets/minecraft").join(dir)).unwrap();
}
    // rust: fs::write(&marker_path, serde_json::to_vec(&marker).unwrap()).unwrap();
    // rust: assert!(marker.dependencies.valid());
    // rust: packs::build_overlay(&vanilla, selected, &out).unwrap();
    // rust: check();
            // The repaired overlay also remains complete on a cache hit.
    // rust: packs::build_overlay(&vanilla, selected, &out).unwrap();
    // rust: check();
}
}

directory_inputs_config_and_owned_output_recovery :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: let resource = "assets/minecraft/lang/en_us.json";
    // rust: f.write(&format!("vanilla/{resource}"), br#"{"v":"a"}"#);
    // rust: f.write("vanilla/assets/minecraft/textures/untouched/a", b"live");
    // rust: let mut low = f.dir_pack("low");
    // rust: let high = f.dir_pack("high");
    // rust: f.write(&format!("low/{resource}"), br#"{"p":"a"}"#);
    // rust: f.write(&format!("high/{resource}"), br#"{"p":"b"}"#);
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: let out = f.0.join("cached");
    // rust: let marker = marker_path(&out);
        // A hit keeps the actual merged file (and marker) in place.
    // rust: let time = fs::metadata(out.join(resource))
    // rust: .unwrap()
    // rust: .modified()
    // rust: .unwrap();
    // rust: let marker_time = fs::metadata(&marker).unwrap().modified().unwrap();
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: assert_eq!(
    // rust: fs::metadata(out.join(resource))
    // rust: .unwrap()
    // rust: .modified()
    // rust: .unwrap(),
    // rust: time
    // rust: );
    // rust: assert_eq!(
    // rust: fs::metadata(&marker).unwrap().modified().unwrap(),
    // rust: marker_time
    // rust: );
        // Same-length rewrites cannot hide behind file size or preserved mtime.
    // rust: let path = f.0.join(format!("high/{resource}"));
    // rust: let original_time = fs::metadata(&path).unwrap().modified().unwrap();
    // rust: fs::write(&path, br#"{"p":"c"}"#).unwrap();
        // Windows requires a writable handle to restore the timestamp.
    // rust: fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .open(path)
    // rust: .unwrap()
    // rust: .set_times(fs::FileTimes::new().set_modified(original_time))
    // rust: .unwrap();
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: f.write(&format!("vanilla/{resource}"), br#"{"v":"b"}"#);
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: f.write("vanilla/assets/minecraft/lang/new.json", b"new");
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: fs::remove_file(f.0.join("vanilla/assets/minecraft/lang/new.json")).unwrap();
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: f.write("high/assets/minecraft/lang/added.json", br#"{"a":1}"#);
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: fs::remove_file(f.0.join("high/assets/minecraft/lang/added.json")).unwrap();
    // rust: f.rebuild_matches(&[low.clone(), high.clone()]);
    // rust: f.rebuild_matches(&[high.clone(), low.clone()]);
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: low.overlays.push("extra".into());
    // rust: f.write(&format!("low/extra/{resource}"), br#"{"p":"overlay"}"#);
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: low.filter = packs::filter_of(&serde_json::json!({"filter":{"block":[{"path":"lang"}]}}));
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: fs::write(out.join(resource), b"corrupt").unwrap();
        // Published output is trusted; clearing the marker explicitly repairs
        // a cache tree changed outside the builder.
    // rust: packs::build_overlay(&f.0.join("vanilla"), std::slice::from_ref(&low), &out).unwrap();
    // rust: assert_eq!(fs::read(out.join(resource)).unwrap(), b"corrupt");
    // rust: let mut old: Marker = serde_json::from_slice(&fs::read(&marker).unwrap()).unwrap();
    // rust: old.version = VERSION - 1;
    // rust: fs::write(&marker, serde_json::to_vec(&old).unwrap()).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: fs::remove_file(out.join(resource)).unwrap();
    // rust: fs::remove_file(&marker).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: fs::write(&marker, b"corrupt").unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: fs::remove_file(&marker).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: fs::remove_dir_all(&out).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: {
    // rust: low.filter.clear();
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
            // Unrelated vanilla content remains live through the directory symlink.
    // rust: let before = fs::read(&marker).unwrap();
    // rust: f.write("vanilla/assets/minecraft/textures/untouched/a", b"new live");
    // rust: f.write(
    // rust: "vanilla/assets/minecraft/textures/untouched/b",
    // rust: b"added live",
    // rust: );
    // rust: f.rebuild_matches(std::slice::from_ref(&low));
    // rust: assert_eq!(fs::read(&marker).unwrap(), before);
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/untouched/b")).unwrap(),
    // rust: b"added live"
    // rust: );
}
        // Missing selected source disables reuse; the original directory builder
        // still tolerates it, and does not publish a marker for an incomplete input.
    // rust: fs::remove_dir_all(f.0.join("low")).unwrap();
    // rust: f.rebuild_matches(&[low]);
    // rust: assert!(!marker.exists());
}

a_large_zip_is_stamped_by_its_directory_and_time :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: let path = f.0.join("large.zip");
    // rust: let at = std::time::SystemTime::UNIX_EPOCH + std::time::Duration::from_secs(1 << 30);
    // rust: let write = |name: &str, first: u8, modified| {
    // rust: let mut body = vec![0u8; 1 << 18];
    // rust: body[0] = first;
    // rust: fs::write(&path, archive(&[(name, body)], false)).unwrap();
    // rust: let file = fs::File::options().write(true).open(&path).unwrap();
    // rust: file.set_modified(modified).unwrap();
}
    // rust: let signature = |whole| {
    // rust: let mut hash = Sha256::new();
    // rust: zip_content(&mut hash, &path, whole).unwrap();
    // rust: finish(hash)
}
    // rust: write("a", 0, at);
    // rust: let (bytes, directory) = (signature(u64::MAX), signature(0));
        // Above the limit the entries' bytes go unread; at or under it they count.
    // rust: write("a", 1, at);
    // rust: assert_eq!(signature(0), directory);
    // rust: assert_ne!(signature(u64::MAX), bytes);
    // rust: write("b", 0, at);
    // rust: assert_ne!(signature(0), directory);
    // rust: write("a", 0, at + std::time::Duration::from_secs(60));
    // rust: assert_ne!(signature(0), directory);
    // rust: assert_eq!(signature(u64::MAX), bytes);
}

zip_content_and_failed_build_invalidate :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: f.write("vanilla/facts.json", b"[]");
    // rust: let name = "assets/minecraft/textures/a";
    // rust: let files = |data: &[u8]| {
    // rust: vec![
    // rust: (
    // rust: "pack.mcmeta",
    // rust: br#"{"pack":{"description":"test","pack_format":97}}"#.to_vec(),
    // rust: ),
    // rust: (name, data.to_vec()),
    // rust: ]
}
    // rust: f.write("pack.zip", &archive(&files(b"aaa"), false));
    // rust: let pack = packs::pack(
    // rust: "zip".into(),
    // rust: Text::empty(),
    // rust: Source::Zip(f.0.join("pack.zip")),
    // rust: )
    // rust: .unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: f.write("pack.zip", &archive(&files(b"bbb"), false));
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(fs::read(f.0.join("cached").join(name)).unwrap(), b"bbb");
        // A central directory whose second name runs past the archive fails
        // the build (an unreadable entry alone only costs that file). No
        // reusable marker survives.
    // rust: let mut broken = archive(&files(b"ccc"), false);
    // rust: let central = broken
    // rust: .windows(4)
    // rust: .position(|s| s == [0x50, 0x4b, 0x01, 0x02])
    // rust: .unwrap();
    // rust: let second = central + 46 + "pack.mcmeta".len();
    // rust: broken[second + 28..second + 30].copy_from_slice(&u16::MAX.to_le_bytes());
    // rust: f.write("pack.zip", &broken);
    // rust: let out = f.0.join("cached");
    // rust: assert!(
    // rust: packs::build_overlay(&f.0.join("vanilla"), std::slice::from_ref(&pack), &out).is_err()
    // rust: );
    // rust: assert!(!marker_path(&out).exists());
    // rust: f.write("pack.zip", &archive(&files(b"ddd"), true));
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: fs::remove_file(f.0.join("pack.zip")).unwrap();
    // rust: assert!(
    // rust: packs::build_overlay(&f.0.join("vanilla"), std::slice::from_ref(&pack), &out).is_err()
    // rust: );
    // rust: assert!(!marker_path(&out).exists());
    // rust: assert!(
    // rust: packs::resource_root(&f.0.join("vanilla"), &[pack], &f.0.join("selection-cache"))
    // rust: .is_err()
    // rust: );
}

    // A ZIP whose bytes are the same keeps its overlay when only its time changes: a server
    // pack found in the download cache is marked used on every join
    // (`HttpUtil.updateModificationTime`), and rebuilding the overlay took most of a minute.
a_zip_touched_but_unchanged_keeps_its_overlay :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: f.write("vanilla/assets/minecraft/textures/b", b"vanilla");
    // rust: let files = vec![
    // rust: (
    // rust: "pack.mcmeta",
    // rust: br#"{"pack":{"description":"test","pack_format":97}}"#.to_vec(),
    // rust: ),
    // rust: ("assets/minecraft/textures/a", b"aaa".to_vec()),
    // rust: ];
    // rust: f.write("pack.zip", &archive(&files, false));
    // rust: let zip = f.0.join("pack.zip");
    // rust: let pack = packs::pack("zip".into(), Text::empty(), Source::Zip(zip.clone())).unwrap();
    // rust: let (vanilla, out) = (f.0.join("vanilla"), f.0.join("cached"));
    // rust: packs::build_overlay(&vanilla, std::slice::from_ref(&pack), &out).unwrap();
        // A rebuild empties the output first: this file survives a cache hit only.
    // rust: fs::write(out.join("kept"), b"").unwrap();
    // rust: let later = std::time::SystemTime::now() + std::time::Duration::from_secs(60);
    // rust: fs::OpenOptions::new()
    // rust: .append(true)
    // rust: .open(&zip)
    // rust: .unwrap()
    // rust: .set_modified(later)
    // rust: .unwrap();
    // rust: packs::build_overlay(&vanilla, std::slice::from_ref(&pack), &out).unwrap();
    // rust: assert!(out.join("kept").exists(), "the overlay was rebuilt");
}

unrelated_directory_pack_symlink_cycle_disables_reuse :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: f.write("vanilla/facts.json", b"[]");
    // rust: let pack = f.dir_pack("pack");
    // rust: f.write("pack/assets/minecraft/textures/a", b"pack");
    // rust: fs::create_dir_all(f.0.join("pack/docs")).unwrap();
    // rust: std::os::unix::fs::symlink(f.0.join("pack"), f.0.join("pack/docs/back")).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert!(!marker_path(&f.0.join("cached")).exists());
}

linked_pack_bytes_stay_live_and_topology_invalidates :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: f.write("vanilla/facts.json", b"[]");
    // rust: let pack = f.dir_pack("pack");
    // rust: let name = "assets/minecraft/textures/a";
    // rust: f.write(&format!("pack/{name}"), b"aaa");
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: let out = f.0.join("cached");
    // rust: let marker = marker_path(&out);
    // rust: let before = fs::metadata(&marker).unwrap().modified().unwrap();
    // rust: let path = f.0.join("pack").join(name);
    // rust: let original_time = fs::metadata(&path).unwrap().modified().unwrap();
    // rust: fs::write(&path, b"bbb").unwrap();
    // rust: fs::File::open(&path)
    // rust: .unwrap()
    // rust: .set_times(fs::FileTimes::new().set_modified(original_time))
    // rust: .unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(fs::read(out.join(name)).unwrap(), b"bbb");
    // rust: assert_eq!(fs::metadata(&marker).unwrap().modified().unwrap(), before);
        // Replacing a regular file at the same linked path is also already live.
    // rust: f.write("replacement", b"ccc");
    // rust: fs::rename(f.0.join("replacement"), &path).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(fs::read(out.join(name)).unwrap(), b"ccc");
    // rust: assert_eq!(fs::metadata(&marker).unwrap().modified().unwrap(), before);
        // A changed source symlink identity is fingerprinted. Output is trusted
        // until its marker is cleared explicitly.
    // rust: fs::remove_file(&path).unwrap();
    // rust: f.write("other", b"ddd");
    // rust: std::os::unix::fs::symlink(f.0.join("other"), &path).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(fs::read(out.join(name)).unwrap(), b"ddd");
    // rust: fs::remove_file(out.join(name)).unwrap();
    // rust: std::os::unix::fs::symlink(f.0.join("other"), out.join(name)).unwrap();
    // rust: fs::remove_file(&marker).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(fs::read_link(out.join(name)).unwrap(), path);
    // rust: fs::remove_file(&path).unwrap();
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert!(fs::symlink_metadata(out.join(name)).is_err());
}

normalized_and_external_overlay_roots_keep_merged_bytes_current :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: let name = "assets/minecraft/lang/en_us.json";
    // rust: f.write(&format!("vanilla/{name}"), br#"{"v":1}"#);
    // rust: let mut pack = f.dir_pack("pack");
    // rust: f.write(&format!("pack/extra/{name}"), br#"{"p":1}"#);
    // rust: for overlay in ["extra/", "./extra", "extra/./", "extra//"] {
    // rust: pack.overlays = vec![overlay.into()];
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: let marker = marker_path(&f.0.join("cached"));
    // rust: assert!(marker.exists());
    // rust: f.write(&format!("pack/extra/{name}"), br#"{"p":2}"#);
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(
    // rust: fs::read(f.0.join("cached").join(name)).unwrap(),
    // rust: br#"{"p":2,"v":1}"#
    // rust: );
    // rust: f.write(&format!("pack/extra/{name}"), br#"{"p":1}"#);
}
    // rust: f.write(&format!("outside/{name}"), br#"{"p":3}"#);
    // rust: for overlay in [
    // rust: "../outside".into(),
    // rust: f.0.join("outside").to_string_lossy().into_owned(),
    // rust: ] {
    // rust: pack.overlays = vec![overlay];
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert!(!marker_path(&f.0.join("cached")).exists());
    // rust: f.write(&format!("outside/{name}"), br#"{"p":4}"#);
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(
    // rust: fs::read(f.0.join("cached").join(name)).unwrap(),
    // rust: br#"{"p":4,"v":1}"#
    // rust: );
    // rust: f.write(&format!("outside/{name}"), br#"{"p":3}"#);
}
}

root_symlink_aliases_stay_live_and_retargeted_merges_invalidate :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: let name = "assets/minecraft/lang/en_us.json";
    // rust: f.write("vanilla-a/facts.json", b"a");
    // rust: f.write("vanilla-b/facts.json", b"b");
    // rust: f.write(&format!("vanilla-a/{name}"), br#"{"v":"a"}"#);
    // rust: f.write(&format!("vanilla-b/{name}"), br#"{"v":"b"}"#);
    // rust: let mut pack = f.dir_pack("pack-a");
    // rust: f.dir_pack("pack-b");
    // rust: f.write("pack-a/assets/minecraft/textures/a", b"a");
    // rust: f.write("pack-b/assets/minecraft/textures/a", b"b");
    // rust: f.write(&format!("pack-a/{name}"), br#"{"p":"a"}"#);
    // rust: f.write(&format!("pack-b/{name}"), br#"{"p":"b"}"#);
    // rust: let vanilla = f.0.join("vanilla");
    // rust: let source = f.0.join("pack");
    // rust: std::os::unix::fs::symlink(f.0.join("vanilla-a"), &vanilla).unwrap();
    // rust: std::os::unix::fs::symlink(f.0.join("pack-a"), &source).unwrap();
    // rust: pack.source = Source::Dir(source.clone());
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: fs::remove_file(&vanilla).unwrap();
    // rust: fs::remove_file(&source).unwrap();
    // rust: std::os::unix::fs::symlink(f.0.join("vanilla-b"), &vanilla).unwrap();
    // rust: std::os::unix::fs::symlink(f.0.join("pack-b"), &source).unwrap();
    // rust: let out = f.0.join("cached");
    // rust: assert_eq!(fs::read(out.join("facts.json")).unwrap(), b"b");
    // rust: assert_eq!(
    // rust: fs::read(out.join("assets/minecraft/textures/a")).unwrap(),
    // rust: b"b"
    // rust: );
    // rust: f.rebuild_matches(std::slice::from_ref(&pack));
    // rust: assert_eq!(fs::read(out.join(name)).unwrap(), br#"{"p":"b","v":"b"}"#);
}

concurrent_selections_wait_and_never_publish_mismatched_markers :: proc() {
}
//         use std::{sync::mpsc, time::Duration};
    // rust: let f = Fixture::new();
    // rust: let name = "assets/minecraft/lang/en_us.json";
    // rust: f.write(&format!("vanilla/{name}"), br#"{"v":1}"#);
    // rust: let a = f.dir_pack("a");
    // rust: let b = f.dir_pack("b");
    // rust: f.write(&format!("a/{name}"), br#"{"p":"a"}"#);
    // rust: f.write(&format!("b/{name}"), br#"{"p":"b"}"#);
    // rust: let out = f.0.join("cached");
    // rust: let held = fs::OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .open(lock_path(&out))
    // rust: .unwrap();
    // rust: held.lock().unwrap();
    // rust: let (started, starts) = mpsc::channel();
    // rust: let (done, finishes) = mpsc::channel();
    // rust: std::thread::scope(|scope| {
    // rust: for pack in [&a, &b] {
    // rust: let started = started.clone();
    // rust: let done = done.clone();
    // rust: let vanilla = f.0.join("vanilla");
    // rust: let out = &out;
    // rust: scope.spawn(move || {
    // rust: started.send(()).unwrap();
    // rust: for _ in 0..20 {
    // rust: packs::build_overlay(&vanilla, std::slice::from_ref(pack), out).unwrap();
}
    // rust: done.send(()).unwrap();
    // rust: });
}
    // rust: starts.recv().unwrap();
    // rust: starts.recv().unwrap();
    // rust: assert!(matches!(
    // rust: finishes.recv_timeout(Duration::from_millis(50)),
    // rust: Err(mpsc::RecvTimeoutError::Timeout)
    // rust: ));
    // rust: drop(held);
    // rust: });
    // rust: finishes.recv().unwrap();
    // rust: finishes.recv().unwrap();
    // rust: for pack in [&a, &b, &a, &b] {
    // rust: f.rebuild_matches(std::slice::from_ref(pack));
    // rust: let expected = if pack.id == "a" {
    // rust: br#"{"p":"a","v":1}"#
    // rust: } else {
    // rust: br#"{"p":"b","v":1}"#
}
    // rust: assert_eq!(fs::read(out.join(name)).unwrap(), expected);
}
    // rust: assert!(lock_path(&out).exists());
}

relative_sources_are_readable_through_cached_and_uncached_overlays :: proc() {
}
    // rust: let f = Fixture::new();
    // rust: f.write("vanilla/facts.json", b"[]");
    // rust: let mut pack = f.dir_pack("pack");
    // rust: let name = "assets/minecraft/textures/a";
    // rust: f.write(&format!("pack/{name}"), b"pack");
    // rust: let cwd = std::env::current_dir().unwrap();
    // rust: let mut relative = PathBuf::new();
    // rust: for component in cwd.components() {
    // rust: if matches!(component, std::path::Component::Normal(_)) {
    // rust: relative.push("..");
}
}
    // rust: relative.push(f.0.strip_prefix("/").unwrap());
    // rust: pack.source = Source::Dir(relative.join("pack"));
    // rust: let vanilla = relative.join("vanilla");
    // rust: let out = f.0.join("cached");
    // rust: let reference = f.0.join("reference");
    // rust: packs::build_overlay(&vanilla, std::slice::from_ref(&pack), &out).unwrap();
    // rust: build_overlay_uncached(
    // rust: &vanilla,
    // rust: std::slice::from_ref(&pack),
    // rust: &reference,
    // rust: &mut Dependencies::default(),
    // rust: )
    // rust: .unwrap();
    // rust: for root in [&out, &reference] {
    // rust: assert!(fs::read_link(root.join(name)).unwrap().is_absolute());
    // rust: assert_eq!(fs::read(root.join(name)).unwrap(), b"pack");
    // rust: assert_eq!(fs::read(root.join("facts.json")).unwrap(), b"[]");
}
    // rust: packs::build_overlay(&vanilla, &[pack], &out).unwrap();
    // rust: assert_eq!(fs::read(out.join(name)).unwrap(), b"pack");
    // rust: assert_eq!(fs::read(out.join("facts.json")).unwrap(), b"[]");
}

benchmark_real_resource_root :: proc() {
}
//         use std::{hint::black_box, time::Instant};
    // rust: let vanilla = PathBuf::from(std::env::var("HORIZON_OVERLAY_BENCH_VANILLA").unwrap());
    // rust: assert!(vanilla.join("horizon-resources.json").is_file());
    // rust: let paths: Vec<PathBuf> =
    // rust: serde_json::from_str(&std::env::var("HORIZON_OVERLAY_BENCH_PACKS").unwrap()).unwrap();
        // The original resource_root selection/cache-key path, with its original builder.
original :: proc(vanilla: ^Path, packs: ^[Pack], cache: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let key = packs
    // rust: .iter()
    // rust: .map(|p| p.id.as_str())
    // rust: .collect::<Vec<_>>()
    // rust: .join("|");
    // rust: let hash = key.bytes().fold(0xcbf2_9ce4_8422_2325u64, |h, b| {
    // rust: (h ^ u64::from(b)).wrapping_mul(0x100_0000_01b3)
    // rust: });
    // rust: let out = cache.join(format!("{hash:016x}"));
    // rust: build_overlay_uncached(vanilla, packs, &out, &mut Dependencies::default()).unwrap();
    // rust: out
}
    // rust: let median = |mut times: Vec<f64>| {
    // rust: times.sort_by(f64::total_cmp);
    // rust: times[times.len() / 2]
}
    // rust: for path in paths {
    // rust: let f = Fixture::new();
    // rust: let pack = packs::pack(
    // rust: path.to_string_lossy().into_owned(),
    // rust: Text::empty(),
    // rust: Source::Zip(path.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: let selected = std::slice::from_ref(&pack);
    // rust: let reference_cache = f.0.join("reference");
    // rust: let cached_cache = f.0.join("cached");
    // rust: fs::create_dir_all(&reference_cache).unwrap();
    // rust: let reference = original(&vanilla, selected, &reference_cache);
    // rust: let out = packs::resource_root(&vanilla, selected, &cached_cache).unwrap();
    // rust: assert_ne!(out, vanilla, "resource_root must not fall back to vanilla");
    // rust: assert!(marker_path(&out).exists());
    // rust: let expected = output_signature(&reference).unwrap();
    // rust: assert_eq!(output_signature(&out).unwrap(), expected);
    // rust: for _ in 0..2 {
    // rust: original(&vanilla, selected, &reference_cache);
    // rust: assert_eq!(
    // rust: packs::resource_root(&vanilla, selected, &cached_cache).unwrap(),
    // rust: out
    // rust: );
}
    // rust: let mut baseline = Vec::new();
    // rust: let mut cold = Vec::new();
    // rust: let mut hit = Vec::new();
    // rust: for iteration in 0..11 {
    // rust: for operation in if iteration % 2 == 0 {
    // rust: [0, 1, 2]
    // rust: } else {
    // rust: [1, 2, 0]
    // rust: } {
    // rust: if operation == 1 {
    // rust: fs::remove_file(marker_path(&out)).unwrap();
}
    // rust: let started = Instant::now();
    // rust: let result = if operation == 0 {
    // rust: original(
    // rust: black_box(&vanilla),
    // rust: black_box(selected),
    // rust: black_box(&reference_cache),
    // rust: )
    // rust: } else {
    // rust: packs::resource_root(
    // rust: black_box(&vanilla),
    // rust: black_box(selected),
    // rust: black_box(&cached_cache),
    // rust: )
    // rust: .unwrap()
}
    // rust: black_box(&result);
    // rust: let ms = started.elapsed().as_secs_f64() * 1000.0;
    // rust: match operation {
    // rust: 0 => baseline.push(ms),
    // rust: 1 => cold.push(ms),
    // rust: _ => hit.push(ms),
}
    // rust: if operation != 0 {
    // rust: assert_eq!(result, out);
}
}
                // Verify full materialized bytes and symlink identities outside timing.
    // rust: assert_eq!(output_signature(&out).unwrap(), expected);
    // rust: assert_eq!(output_signature(&reference).unwrap(), expected);
}
    // rust: let baseline = median(baseline);
    // rust: let cold = median(cold);
    // rust: let hit = median(hit);
    // rust: println!(
    // rust: "real pack={} ZIP={} bytes: original={baseline:.3} ms cold={cold:.3} ms hit={hit:.3} ms speedup={:.2}x saved={:.3} ms cold_overhead={:.2}% (11 medians, 2 warmups)",
    // rust: path.display(),
    // rust: fs::metadata(&path).unwrap().len(),
    // rust: baseline / hit,
    // rust: baseline - hit,
    // rust: (cold / baseline - 1.0) * 100.0
    // rust: );
}
}
}
