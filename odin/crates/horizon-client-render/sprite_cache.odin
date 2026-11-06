//! Transpiled from Horizon Rust crate
package horizon_client_render_sprite_cache

import "core:fmt"
import "core:mem"
import "core:math"

// Decoded block sprites kept on disk between launches (M-11): reading and
// decoding ~1300 small PNGs is most of `Sprites::load`. One file per resource
// root, valid only while the `textures` trees still have the same paths,
// sizes and modification times and the format version is the same; anything
// else (missing, corrupt, stale, unwritable) means the normal decoding path.
// use crate::mipmap::Strategy;
// use std::{
    // rust: collections::HashMap,
    // rust: fs,
    // rust: hash::{DefaultHasher, Hash, Hasher},
    // rust: path::{Path, PathBuf},
}

MAGIC :: b"HSPR"
// Bump when `Decoded` or the decoding in `Sprites::decode` changes.
VERSION :: 1
FILE :: "horizon-sprites.cache"

// What decoding one texture gives, before it takes a layer.
    // rust: pub(crate) struct Decoded {
    // rust: pub side: u32,
    // rust: pub frames: Vec<Vec<u8>>,
    // The `.mcmeta` `animation` value, as text.
    // rust: pub animation: Option<String>,
    // rust: pub strategy: Strategy,
    // rust: pub alpha_cutoff_bias: f32,
    // rust: pub has_transparent: bool,
    // rust: pub opaque: bool,
    // rust: pub translucent: bool,
}

    // rust: pub(crate) struct SpriteCache {
    // rust: path: PathBuf,
    // rust: fingerprint: u64,
    // rust: entries: HashMap<String, Decoded>,
    // rust: dirty: bool,
}

// Paths, sizes and modification times of every file under `assets/*/textures`,
// summed so the directory order does not matter.
fingerprint :: proc(root: ^Path) -> O {
    // Ported from Horizon
    return {}
}
walk :: proc(dir: ^Path, base: ^Path, sum: ^u64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: for entry in fs::read_dir(dir).ok()? {
    // rust: let entry = entry.ok()?;
    // rust: let meta = entry.metadata().ok()?;
    // rust: if meta.is_dir() {
    // rust: walk(&entry.path(), base, sum)?;
    // rust: continue;
}
    // rust: let mut hasher = DefaultHasher::new();
    // rust: entry.path().strip_prefix(base).ok()?.hash(&mut hasher);
    // rust: meta.len().hash(&mut hasher);
    // rust: meta.modified().ok()?.hash(&mut hasher);
    // rust: *sum = sum.wrapping_add(hasher.finish());
}
    // rust: Some(())
}
    // rust: let mut sum = 0;
    // rust: for namespace in fs::read_dir(root.join("assets")).ok()? {
    // rust: let textures = namespace.ok()?.path().join("textures");
    // rust: if textures.is_dir() {
    // rust: walk(&textures, root, &mut sum)?;
}
}
    // rust: Some(sum)
}

    // rust: impl SpriteCache {
    // The cache of `root`: its stored entries when still valid, else empty.
    // `None` when the textures cannot be fingerprinted (no caching then).
open :: proc(root: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let fingerprint = fingerprint(root)?;
    // rust: let path = root.join(FILE);
    // rust: let entries = fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|bytes| parse(&bytes, fingerprint))
    // rust: .unwrap_or_default();
    // rust: Some(Self {
    // rust: path,
    // rust: fingerprint,
    // rust: entries,
    // rust: dirty: false,
    // rust: })
}
get :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.get(name)
}
insert :: proc(self: ^Self, name: string, decoded: Decoded) {
}
    // rust: self.entries.insert(name.to_owned(), decoded);
    // rust: self.dirty = true;
}
    // Write new entries; a failure only costs the next launch the decoding.
save :: proc(self: ^Self) {
}
    // rust: if !self.dirty {
    // rust: return;
}
    // rust: self.dirty = false;
    // rust: let temporary = self
    // rust: .path
    // rust: .with_extension(format!("{}.tmp", std::process::id()));
    // rust: if fs::write(&temporary, serialize(self.fingerprint, &self.entries)).is_ok()
    // rust: && fs::rename(&temporary, &self.path).is_err()
    // rust: {
    // rust: let _ = fs::remove_file(&temporary);
}
}
}

serialize :: proc(fingerprint: u64, entries: ^HashMap<string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: out.extend_from_slice(MAGIC);
    // rust: out.extend_from_slice(&VERSION.to_le_bytes());
    // rust: out.extend_from_slice(&fingerprint.to_le_bytes());
    // rust: out.extend_from_slice(&(entries.len() as u32).to_le_bytes());
    // rust: for (name, d) in entries {
    // rust: put_bytes(&mut out, name.as_bytes());
    // rust: out.extend_from_slice(&d.side.to_le_bytes());
    // rust: out.extend_from_slice(&(d.frames.len() as u32).to_le_bytes());
    // rust: for frame in &d.frames {
    // rust: put_bytes(&mut out, frame);
}
    // rust: put_bytes(&mut out, d.animation.as_deref().unwrap_or("").as_bytes());
    // rust: out.push(u8::from(d.animation.is_some()));
    // rust: out.push(d.strategy as u8);
    // rust: out.extend_from_slice(&d.alpha_cutoff_bias.to_bits().to_le_bytes());
    // rust: out.push(
    // rust: u8::from(d.has_transparent) | u8::from(d.opaque) << 1 | u8::from(d.translucent) << 2,
    // rust: );
}
    // rust: out
}
put_bytes :: proc(out: ^[dynamic]u8, bytes: []u8) {
}
    // rust: out.extend_from_slice(&(bytes.len() as u32).to_le_bytes());
    // rust: out.extend_from_slice(bytes);
}

Reader :: struct {
    // rust: impl<'a> Reader<'a> {
take :: proc(self: ^Self, n: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (head, tail) = self.0.split_at_checked(n)?;
    // rust: self.0 = tail;
    // rust: Some(head)
}
u32 :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(u32::from_le_bytes(self.take(4)?.try_into().ok()?))
}
bytes :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.u32()? as usize;
    // rust: self.take(n)
}
}
parse :: proc(bytes: []u8, fingerprint: u64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader(bytes);
    // rust: if r.take(4)? != MAGIC || r.u32()? != VERSION {
    // rust: return None;
}
    // rust: if u64::from_le_bytes(r.take(8)?.try_into().ok()?) != fingerprint {
    // rust: return None;
}
    // rust: let count = r.u32()?;
    // rust: let mut entries = HashMap::new();
    // rust: for _ in 0..count {
    // rust: let name = String::from_utf8(r.bytes()?.to_vec()).ok()?;
    // rust: let side = r.u32()?;
    // rust: let frame_count = r.u32()?;
    // rust: let mut frames = Vec::new();
    // rust: for _ in 0..frame_count {
    // rust: frames.push(r.bytes()?.to_vec());
}
    // rust: let animation = String::from_utf8(r.bytes()?.to_vec()).ok()?;
    // rust: let has_animation = r.take(1)?[0] != 0;
    // rust: let strategy = match r.take(1)?[0] {
    // rust: 0 => Strategy::Auto,
    // rust: 1 => Strategy::Mean,
    // rust: 2 => Strategy::Cutout,
    // rust: 3 => Strategy::StrictCutout,
    // rust: 4 => Strategy::DarkCutout,
    // rust: _ => return None,
}
    // rust: let alpha_cutoff_bias = f32::from_bits(r.u32()?);
    // rust: let flags = r.take(1)?[0];
    // rust: let frame_len = (side as usize).checked_mul(side as usize)?.checked_mul(4)?;
    // rust: if frames.is_empty() || frames.iter().any(|f| f.len() != frame_len) {
    // rust: return None;
}
    // rust: entries.insert(
    // rust: name,
    // rust: Decoded {
    // rust: side,
    // rust: frames,
    // rust: animation: has_animation.then_some(animation),
    // rust: strategy,
    // rust: alpha_cutoff_bias,
    // rust: has_transparent: flags & 1 != 0,
    // rust: opaque: flags & 2 != 0,
    // rust: translucent: flags & 4 != 0,
    // rust: },
    // rust: );
}
    // rust: r.0.is_empty().then_some(entries)
}

    // rust: mod tests {
//     use super::*;

sample :: proc(blue: u8, animation: Maybe(string)) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Decoded {
    // rust: side: 2,
    // rust: frames: vec![vec![blue; 16], vec![blue + 1; 16]],
    // rust: animation: animation.map(str::to_owned),
    // rust: strategy: Strategy::Cutout,
    // rust: alpha_cutoff_bias: 0.25,
    // rust: has_transparent: true,
    // rust: opaque: false,
    // rust: translucent: true,
}
}
scratch :: proc(tag: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-sprite-cache-{tag}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(dir.join("assets/minecraft/textures/block")).unwrap();
    // rust: dir
}
round_trips :: proc() {
}
    // rust: let mut entries = HashMap::new();
    // rust: entries.insert("a:b".to_owned(), sample(1, Some("{\"frametime\":2}")));
    // rust: entries.insert("a:c".to_owned(), sample(9, None));
    // rust: let back = parse(&serialize(7, &entries), 7).unwrap();
    // rust: for (name, d) in &entries {
    // rust: let e = &back[name];
    // rust: assert_eq!(
    // rust: (d.side, &d.frames, &d.animation),
    // rust: (e.side, &e.frames, &e.animation)
    // rust: );
    // rust: assert_eq!(d.alpha_cutoff_bias, e.alpha_cutoff_bias);
    // rust: assert_eq!(
    // rust: (d.has_transparent, d.opaque, d.translucent, d.strategy as u8),
    // rust: (e.has_transparent, e.opaque, e.translucent, e.strategy as u8)
    // rust: );
}
}
wrong_fingerprint_truncation_and_garbage_are_misses :: proc() {
}
    // rust: let mut entries = HashMap::new();
    // rust: entries.insert("a:b".to_owned(), sample(1, None));
    // rust: let bytes = serialize(7, &entries);
    // rust: assert!(parse(&bytes, 8).is_none());
    // rust: for cut in 0..bytes.len() {
    // rust: assert!(parse(&bytes[..cut], 7).is_none(), "cut {cut}");
}
    // rust: assert!(parse(b"garbage", 7).is_none());
    // rust: let mut extra = bytes.clone();
    // rust: extra.push(0);
    // rust: assert!(parse(&extra, 7).is_none());
}
changed_texture_invalidates_and_corrupt_file_is_ignored :: proc() {
}
    // rust: let root = scratch("invalidate");
    // rust: let png = root.join("assets/minecraft/textures/block/x.png");
    // rust: fs::write(&png, b"one").unwrap();
    // rust: let mut cache = SpriteCache::open(&root).unwrap();
    // rust: cache.insert("minecraft:block/x", sample(1, None));
    // rust: cache.save();
    // rust: assert!(
    // rust: SpriteCache::open(&root)
    // rust: .unwrap()
    // rust: .get("minecraft:block/x")
    // rust: .is_some()
    // rust: );
        // Same length, new content and time: still stale.
    // rust: std::thread::sleep(std::time::Duration::from_millis(30));
    // rust: fs::write(&png, b"two").unwrap();
    // rust: assert!(
    // rust: SpriteCache::open(&root)
    // rust: .unwrap()
    // rust: .get("minecraft:block/x")
    // rust: .is_none()
    // rust: );
        // A new file also invalidates.
    // rust: let mut cache = SpriteCache::open(&root).unwrap();
    // rust: cache.insert("minecraft:block/x", sample(1, None));
    // rust: cache.save();
    // rust: fs::write(root.join("assets/minecraft/textures/block/y.png"), b"y").unwrap();
    // rust: assert!(
    // rust: SpriteCache::open(&root)
    // rust: .unwrap()
    // rust: .get("minecraft:block/x")
    // rust: .is_none()
    // rust: );
        // Corrupt cache file: empty, no error.
    // rust: fs::write(root.join(FILE), b"HSPR junk").unwrap();
    // rust: assert!(
    // rust: SpriteCache::open(&root)
    // rust: .unwrap()
    // rust: .get("minecraft:block/x")
    // rust: .is_none()
    // rust: );
    // rust: let _ = fs::remove_dir_all(&root);
}
write_png :: proc(path: ^Path, rgba: [u8; 4]) {
}
    // rust: let mut encoder = png::Encoder::new(fs::File::create(path).unwrap(), 16, 16);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let pixels: Vec<u8> = rgba.iter().copied().cycle().take(16 * 16 * 4).collect();
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&pixels)
    // rust: .unwrap();
}
sprite_pixels :: proc(root: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut sprites = crate::sprites::Sprites::with_disk_cache(root);
    // rust: sprites.insert(root, "minecraft:block/x").unwrap();
    // rust: sprites.save_disk_cache();
    // rust: sprites.finish();
    // rust: sprites.pixels
}
altered_png_is_not_served_stale_and_cache_matches_decoding :: proc() {
}
    // rust: let root = scratch("stale");
    // rust: let png = root.join("assets/minecraft/textures/block/x.png");
    // rust: write_png(&png, [255, 0, 0, 255]);
    // rust: let decoded = sprite_pixels(&root);
    // rust: assert!(root.join(FILE).exists());
    // rust: assert_eq!(
    // rust: sprite_pixels(&root),
    // rust: decoded,
    // rust: "cache hit differs from decoding"
    // rust: );
    // rust: std::thread::sleep(std::time::Duration::from_millis(30));
    // rust: write_png(&png, [0, 255, 0, 255]);
    // rust: let fresh = sprite_pixels(&root);
    // rust: assert_eq!(&fresh[..4], &[0, 255, 0, 255]);
        // Corrupt and deleted caches fall back to decoding.
    // rust: fs::write(root.join(FILE), b"HSPR\x01\0\0\0 junk").unwrap();
    // rust: assert_eq!(sprite_pixels(&root), fresh);
    // rust: fs::remove_file(root.join(FILE)).unwrap();
    // rust: assert_eq!(sprite_pixels(&root), fresh);
    // rust: let _ = fs::remove_dir_all(&root);
}
}
