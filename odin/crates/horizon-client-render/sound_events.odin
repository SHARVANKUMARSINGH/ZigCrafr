//! Transpiled from Horizon Rust crate
package horizon_client_render_sound_events

import "core:fmt"
import "core:mem"
import "core:math"

// `sounds.json` sound events as vanilla's `SoundManager.Preparations` builds
// them: `WeighedSoundEvents` holding files and references to other events
// (whose weight is the referenced event's total weight, resolved lazily), the
// `replace` and `subtitle` fields, files that do not exist being dropped, and
// `WeighedSoundEvents.getSound` drawing `nextInt(totalWeight)` from the sound
// instance's random.
// use horizon_core::random::RandomSource;
// use serde_json::Value;
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: fs,
    // rust: path::Path,
}

// `SoundManager.EMPTY_SOUND_LOCATION`.
EMPTY :: "minecraft:empty"
// `SoundManager.INTENTIONALLY_EMPTY_SOUND_LOCATION`.
INTENTIONALLY_EMPTY :: "minecraft:intentionally_empty"

// `SampledFloat` as sounds use it: constants and `MultipliedFloats`.
Sampled :: enum {
    Constant(f32),
    Product(Vec<Sampled>),
}
    // rust: impl Sampled {
    // `SampledFloat.sample`: constants draw nothing (sounds.json only has
    // constants, but the random stays part of the call as in vanilla).
sample :: proc(self: ^Self, random: ^impl RandomSource) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Constant(v) => *v,
    // rust: Self::Product(values) => {
    // rust: let mut result = 1.0f32;
    // rust: for v in values {
    // rust: result *= v.sample(random);
}
    // rust: result
}
}
}
}
// `Sound`.
Sound :: struct {
    // The file identifier (`namespace:path`, under `sounds/` with `.ogg`).
    location: string,
    volume: Sampled,
    pitch: Sampled,
    weight: i32,
    // `Sound.Type.SOUND_EVENT` (a reference to another event).
    event: bool,
    stream: bool,
    preload: bool,
    attenuation_distance: i32,
    // The `EMPTY_SOUND` / `INTENTIONALLY_EMPTY_SOUND` singletons (vanilla
    // compares them by identity).
    sentinel: Sentinel,
}
Sentinel :: enum {
    None,
    Empty,
    IntentionallyEmpty,
}
    // rust: impl Sound {
file :: proc(location: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: location: location.to_owned(),
    // rust: volume: Sampled::Constant(1.0),
    // rust: pitch: Sampled::Constant(1.0),
    // rust: weight: 1,
    // rust: event: false,
    // rust: stream: false,
    // rust: preload: false,
    // rust: attenuation_distance: 16,
    // rust: sentinel: Sentinel::None,
}
}
    // `SoundManager.EMPTY_SOUND`.
empty :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: sentinel: Sentinel::Empty,
    // rust: ..Self::file(EMPTY)
}
}
    // `SoundManager.INTENTIONALLY_EMPTY_SOUND`.
intentionally_empty :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: sentinel: Sentinel::IntentionallyEmpty,
    // rust: ..Self::file(INTENTIONALLY_EMPTY)
}
}
    // `Sound.getAttenuationDistance(volume)`.
attenuation_distance :: proc(self: ^Self, volume: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: volume.max(1.0) * self.attenuation_distance as f32
}
    // `Sound.getPath`: the resource path (`namespace`, `sounds/<path>.ogg`).
path :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = split(&self.location);
    // rust: (namespace, format!("sounds/{path}.ogg"))
}
}
// `WeighedSoundEvents`.
WeighedSoundEvents :: struct {
    // Files, or references to events (`Sound.event`).
    sounds: [dynamic]Sound,
    // The subtitle translation key.
    subtitle: Maybe(string),
}
// A `sounds.json` entry: event, `replace`, subtitle and sounds.
    // rust: type Registration = (String, bool, Option<String>, Vec<Sound>);
// Parse a `sounds.json`; `None` when Gson would reject the whole file (a
// malformed entry anywhere in it).
parse_file :: proc(namespace: string, text: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(Value::Object(map)) = serde_json::from_slice::<Value>(text) else {
    // rust: return None;
}
    // rust: let mut parsed = Vec::new();
    // rust: for (name, def) in &map {
    // rust: let Value::Object(object) = def else {
    // rust: return None;
}
    // rust: let replace = json_bool(object.get("replace").unwrap_or(&Value::Null), false);
    // rust: let subtitle = match object.get("subtitle") {
    // rust: None | Some(Value::Null) => None,
    // rust: Some(Value::String(s)) => Some(s.clone()),
    // rust: Some(_) => return None,
}
    // rust: let mut sounds = Vec::new();
    // rust: if let Some(list) = object.get("sounds") {
    // rust: let Value::Array(list) = list else {
    // rust: return None;
}
    // rust: for s in list {
    // rust: sounds.push(parse_sound(s)?);
}
}
    // rust: parsed.push((format!("{namespace}:{name}"), replace, subtitle, sounds));
}
    // rust: Some(parsed)
}
// Whether vanilla's `SoundManager` reads this `sounds.json` at all.
is_valid_file :: proc(text: []u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: parse_file("minecraft", text).is_some()
}
// The sound event registry (`SoundManager.registry`).
SoundRegistry :: struct {
    events: HashMap<string,
}
// `Identifier.parse` with the default namespace.
split :: proc(id: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match id.split_once(':') {
    // rust: Some((namespace, path)) => (
    // rust: if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
    // rust: },
    // rust: path,
    // rust: ),
    // rust: None => ("minecraft", id),
}
}
normalize :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = split(id);
    // rust: format!("{namespace}:{path}")
}
// `GsonHelper.getAsFloat`: Gson parses the number's text as a float.
json_float :: proc(v: ^Value, fallback: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Number(n) => n.to_string().parse().unwrap_or(fallback),
    // rust: Value::String(s) => s.parse().unwrap_or(fallback),
    // rust: _ => fallback,
}
}
json_int :: proc(v: ^Value, fallback: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Number(n) => n
    // rust: .as_i64()
    // rust: .map(|i| i as i32)
    // rust: .or_else(|| n.as_f64().map(|f| f as i32))
    // rust: .unwrap_or(fallback),
    // rust: Value::String(s) => s.parse().unwrap_or(fallback),
    // rust: _ => fallback,
}
}
    // rust: pub(crate) fn json_bool(v: &Value, fallback: bool) -> bool {
    // rust: match v {
    // rust: Value::Bool(b) => *b,
    // rust: Value::String(s) => s == "true",
    // rust: _ => fallback,
}
}
// `SoundEventRegistrationSerializer.getSound`; None for an invalid entry
// (vanilla rejects the whole file).
parse_sound :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Value::String(name) = v {
    // rust: return Some(Sound::file(&normalize(name)));
}
    // rust: let name = v.get("name")?.as_str()?;
    // rust: let event = match v.get("type") {
    // rust: None => false,
    // rust: Some(t) => match t.as_str()? {
    // rust: "file" => false,
    // rust: "event" => true,
    // rust: _ => return None,
    // rust: },
}
    // rust: let volume = json_float(v.get("volume").unwrap_or(&Value::Null), 1.0);
    // rust: let pitch = json_float(v.get("pitch").unwrap_or(&Value::Null), 1.0);
    // rust: let weight = json_int(v.get("weight").unwrap_or(&Value::Null), 1);
    // rust: if !(volume > 0.0 && pitch > 0.0 && weight > 0) {
    // rust: return None;
}
    // rust: Some(Sound {
    // rust: location: normalize(name),
    // rust: volume: Sampled::Constant(volume),
    // rust: pitch: Sampled::Constant(pitch),
    // rust: weight,
    // rust: event,
    // rust: stream: json_bool(v.get("stream").unwrap_or(&Value::Null), false),
    // rust: preload: json_bool(v.get("preload").unwrap_or(&Value::Null), false),
    // rust: attenuation_distance: json_int(v.get("attenuation_distance").unwrap_or(&Value::Null), 16),
    // rust: sentinel: Sentinel::None,
    // rust: })
}
// The files under a namespace's `sounds/`, as `sounds/<path>` with `/`.
sound_files :: proc(namespace: ^Path) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = HashSet::new();
    // rust: let mut stack = vec![namespace.join("sounds")];
    // rust: while let Some(dir) = stack.pop() {
    // rust: let Ok(entries) = fs::read_dir(&dir) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
            // The listing's own type; a link is followed, as `is_file` does.
    // rust: let Ok(kind) = e.file_type() else {
    // rust: continue;
}
    // rust: let (dir, file) = if kind.is_symlink() {
    // rust: (path.is_dir(), path.is_file())
    // rust: } else {
    // rust: (kind.is_dir(), kind.is_file())
}
    // rust: if dir {
    // rust: stack.push(path);
    // rust: } else if file && let Ok(rel) = path.strip_prefix(namespace) {
    // rust: files.insert(rel.to_string_lossy().replace('\\', "/"));
}
}
}
    // rust: files
}
    // rust: impl SoundRegistry {
    // Every `assets/<namespace>/sounds.json` under a resource root, files
    // validated against `assets/<namespace>/sounds/`.
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let assets = root.join("assets");
    // rust: let mut namespaces: Vec<String> = fs::read_dir(&assets)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| e.file_name().to_str().map(str::to_owned))
    // rust: .collect();
    // rust: namespaces.sort();
        // Each namespace's sound files are listed once, as the resource manager
        // lists a pack, instead of one file lookup per sound (thousands).
    // rust: let files: HashMap<&str, HashSet<String>> = namespaces
    // rust: .iter()
    // rust: .map(|ns| (ns.as_str(), sound_files(&assets.join(ns))))
    // rust: .collect();
    // rust: let exists = |ns: &str, path: &str| files.get(ns).is_some_and(|f| f.contains(path));
    // rust: let mut registry = Self::default();
    // rust: for namespace in &namespaces {
    // rust: let Ok(text) = fs::read(assets.join(namespace).join("sounds.json")) else {
    // rust: continue;
}
    // rust: registry.add_file(namespace, &text, &exists);
}
    // rust: registry
}
    // No sound event at all: the resources hold no `sounds.json` (sounds not
    // imported from the player's launcher when the game was prepared).
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.events.is_empty()
}
    // One `sounds.json` (`Preparations.handleRegistration` for each entry).
    // `exists(namespace, path)` says whether a sound file is present.
add_file :: proc(self: ^Self, namespace: string, text: []u8, exists: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(parsed) = parse_file(namespace, text) else {
    // rust: return;
}
    // rust: for (location, replace, subtitle, sounds) in parsed {
    // rust: let entry = match self.events.get_mut(&location) {
    // rust: Some(entry) if !replace => entry,
    // rust: _ => {
    // rust: self.events.insert(
    // rust: location.clone(),
    // rust: WeighedSoundEvents {
    // rust: sounds: Vec::new(),
    // rust: subtitle,
    // rust: },
    // rust: );
    // rust: self.events.get_mut(&location).expect("inserted")
}
}
    // rust: for sound in sounds {
    // rust: if !sound.event {
    // rust: let (ns, path) = sound.path();
    // rust: if !exists(ns, &path) {
    // rust: continue;
}
}
    // rust: entry.sounds.push(sound);
}
}
}
get :: proc(self: ^Self, event: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.events.get(event)
}
contains :: proc(self: ^Self, event: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.events.contains_key(event)
}
    // Every registered event id.
names :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.events.keys()
}
    // `Weighted.getWeight` of one entry, with the sounds `refused` names left
    // out of every pool (the Music page's off tracks).
entry_weight :: proc(self: ^Self, sound: ^Sound, depth: u32, refused: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !sound.event {
    // rust: return if refused(&sound.location) {
    // rust: 0
    // rust: } else {
    // rust: sound.weight
}
}
    // rust: if depth > 64 {
    // rust: return 0;
}
    // rust: self.events
    // rust: .get(&sound.location)
    // rust: .map_or(0, |e| self.total(e, depth + 1, refused))
}
total :: proc(self: ^Self, event: ^WeighedSoundEvents, depth: u32, refused: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: event.sounds.iter().fold(0i32, |sum, s| {
    // rust: sum.wrapping_add(self.entry_weight(s, depth, refused))
    // rust: })
}
    // `WeighedSoundEvents.getWeight`.
weight :: proc(self: ^Self, event: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.events
    // rust: .get(event)
    // rust: .map_or(0, |e| self.total(e, 0, &|_| false))
}
    // `WeighedSoundEvents.getSound`: None when the event is not registered.
sound :: proc(self: ^Self, event: string, random: ^impl RandomSource) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.sound_except(event, random, &|_| false)
}
    // `WeighedSoundEvents.getSound` with the sounds `refused` names left out
    // of every pool: `Sound::empty()` when the event has nothing left to
    // play (all of its tracks are off).
    // rust: pub fn sound_except(
    // rust: &self,
    // rust: event: &str,
    // rust: random: &mut impl RandomSource,
    // rust: refused: &dyn Fn(&str) -> bool,
    // rust: ) -> Option<Sound> {
    // rust: let e = self.events.get(event)?;
    // rust: Some(self.pick(e, random, 0, refused))
}
    // The sound files an event names itself, in `sounds.json` order: the
    // rows of the Music page. A `"type": "event"` reference is not followed
    // here: the event it names lists its own tracks.
tracks :: proc(self: ^Self, event: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(e) = self.events.get(event) else {
    // rust: return Vec::new();
}
    // rust: let mut tracks: Vec<String> = Vec::new();
    // rust: for sound in &e.sounds {
    // rust: if !sound.event && !tracks.contains(&sound.location) {
    // rust: tracks.push(sound.location.clone());
}
}
    // rust: tracks
}
    // rust: fn pick(
    // rust: &self,
    // rust: event: &WeighedSoundEvents,
    // rust: random: &mut impl RandomSource,
    // rust: depth: u32,
    // rust: refused: &dyn Fn(&str) -> bool,
    // rust: ) -> Sound {
    // rust: let weight = self.total(event, depth, refused);
    // rust: if event.sounds.is_empty() || weight == 0 {
    // rust: return Sound::empty();
}
    // rust: let Ok(mut index) = random.next_int_bound(weight) else {
    // rust: return Sound::empty();
}
    // rust: for sound in &event.sounds {
    // rust: index -= self.entry_weight(sound, depth, refused);
    // rust: if index < 0 {
    // rust: if !sound.event {
    // rust: return sound.clone();
}
                // The anonymous reference Weighted: the referenced event's
                // sound with this entry's volume, pitch and stream folded in.
    // rust: let Some(inner) = self.events.get(&sound.location) else {
    // rust: return Sound::empty();
}
    // rust: if depth > 64 {
    // rust: return Sound::empty();
}
    // rust: let wrapped = self.pick(inner, random, depth + 1, refused);
    // rust: return Sound {
    // rust: location: wrapped.location,
    // rust: volume: Sampled::Product(vec![wrapped.volume, sound.volume.clone()]),
    // rust: pitch: Sampled::Product(vec![wrapped.pitch, sound.pitch.clone()]),
    // rust: weight: sound.weight,
    // rust: event: false,
    // rust: stream: wrapped.stream || sound.stream,
    // rust: preload: wrapped.preload,
    // rust: attenuation_distance: wrapped.attenuation_distance,
    // rust: sentinel: Sentinel::None,
}
}
}
    // rust: Sound::empty()
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

load_keeps_the_sound_files_a_root_holds :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-sounds-{}", std::process::id()));
    // rust: let ns = root.join("assets/minecraft");
    // rust: fs::create_dir_all(ns.join("sounds/block/note")).unwrap();
    // rust: fs::write(ns.join("sounds/block/note/harp.ogg"), b"").unwrap();
    // rust: fs::write(
    // rust: ns.join("sounds.json"),
    // rust: br#"{"note": {"sounds": ["block/note/harp", "block/note/gone"]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let r = SoundRegistry::load(&root);
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: let sounds = &r.get("minecraft:note").unwrap().sounds;
    // rust: let kept: Vec<&str> = sounds.iter().map(|s| s.location.as_str()).collect();
    // rust: assert_eq!(kept, ["minecraft:block/note/harp"]);
}

references_weigh_as_much_as_their_event :: proc() {
}
    // rust: let mut r = SoundRegistry::default();
    // rust: let json = br#"{
    // rust: "a": {"sounds": ["x", "y", "z"]},
    // rust: "b": {"sounds": [{"name": "a", "type": "event", "weight": 9, "volume": 0.5}, "w"], "subtitle": "s.b"}
    // rust: }"#;
    // rust: r.add_file("minecraft", json, &|_, _| true);
    // rust: assert_eq!(r.weight("minecraft:b"), 4);
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for _ in 0..64 {
    // rust: let s = r.sound("minecraft:b", &mut random).unwrap();
    // rust: if s.location != "minecraft:w" {
    // rust: assert_eq!(s.volume.sample(&mut random), 0.5);
}
    // rust: seen.insert(s.location);
}
    // rust: assert_eq!(seen.len(), 4);
    // rust: assert_eq!(
    // rust: r.get("minecraft:b").unwrap().subtitle.as_deref(),
    // rust: Some("s.b")
    // rust: );
}

missing_files_are_dropped_and_empty_events_give_the_empty_sound :: proc() {
}
    // rust: let mut r = SoundRegistry::default();
    // rust: r.add_file("minecraft", br#"{"a": {"sounds": ["gone"]}}"#, &|_, _| {
    // rust: false
    // rust: });
    // rust: assert_eq!(r.weight("minecraft:a"), 0);
    // rust: let mut random = LegacyRandom::new(1);
    // rust: assert_eq!(r.sound("minecraft:a", &mut random).unwrap(), Sound::empty());
    // rust: assert!(r.sound("minecraft:b", &mut random).is_none());
}

tracks_are_the_files_an_event_names_and_no_references :: proc() {
}
    // rust: let mut r = SoundRegistry::default();
    // rust: r.add_file(
    // rust: "minecraft",
    // rust: br#"{
    // rust: "music.game": {"sounds": ["music/a", "music/b", "music/a"]},
    // rust: "music.creative": {"sounds": [{"name": "music.game", "type": "event"}, "music/c"]}
    // rust: }"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: assert_eq!(
    // rust: r.tracks("minecraft:music.game"),
    // rust: ["minecraft:music/a", "minecraft:music/b"]
    // rust: );
        // The referenced event lists its own tracks; this one only "music/c".
    // rust: assert_eq!(r.tracks("minecraft:music.creative"), ["minecraft:music/c"]);
    // rust: assert!(r.tracks("minecraft:music.absent").is_empty());
}

a_refused_sound_leaves_every_pool_it_is_in :: proc() {
}
    // rust: let mut r = SoundRegistry::default();
    // rust: r.add_file(
    // rust: "minecraft",
    // rust: br#"{
    // rust: "inner": {"sounds": ["x", "y"]},
    // rust: "outer": {"sounds": [{"name": "inner", "type": "event"}, "z"]}
    // rust: }"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: let refused = |id: &str| id == "minecraft:x";
    // rust: assert_eq!(r.weight("minecraft:outer"), 3);
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for _ in 0..256 {
    // rust: let s = r
    // rust: .sound_except("minecraft:outer", &mut random, &refused)
    // rust: .unwrap();
    // rust: assert_ne!(s.location, "minecraft:x");
    // rust: seen.insert(s.location);
}
        // The nested event still contributes its remaining track.
    // rust: assert_eq!(
    // rust: seen,
    // rust: ["minecraft:y".to_owned(), "minecraft:z".to_owned()].into()
    // rust: );
        // Nothing left to play: the empty sound, not a missing one.
    // rust: let none = |_: &str| true;
    // rust: assert_eq!(
    // rust: r.sound_except("minecraft:outer", &mut random, &none)
    // rust: .unwrap(),
    // rust: Sound::empty()
    // rust: );
}
}
