//! Transpiled from Horizon Rust crate
package horizon_client_render_options_file

import "core:fmt"
import "core:mem"
import "core:math"

// `options.txt` exactly as `Options.load`/`Options.save` handle it in 26.3:
// the processing order, per-option codecs and validation (`OptionInstance`),
// plain fields, key mappings, sound volumes and model parts. Typed access for
// the game lives in `settings`.
// use crate::{
    // rust: java_text::{self, Json},
    // rust: key_names,
}
// use std::sync::LazyLock;

// A stored option value.
V :: enum {
    Bool(bool),
    Int(i32),
    Double(f64),
    Str(String),
    List(Vec<String>),
}

// How an `OptionInstance` decodes, validates and encodes its value.
Spec :: enum {
    // `Codec.BOOL`.
    Bool,
    // `IntRange(min, max)`: codec `intRange(min, max + 1)`, validated to `max`.
    Int(i32, i32),
    // `ClampingLazyMaxIntRange(min, ..)` while the game is not running.
    LazyInt(i32),
    // `IntRange(imin, imax).xmap(i / k, (int)(v * k))` with `doubleRange(lo, hi)`.
    Scaled(i32, i32, f64, f64, f64),
    // The frame rate limit: `IntRange(1, 26).xmap(i * 10, v / 10)`, codec 10..=260.
    FrameLimit,
    // Field of view degrees stored as `(fov - 70) / 40`.
    Fov,
    // `IntRange(-200, 100).xmap(10^(i/100), floor(log10(v) * 100))`.
    WheelSensitivity,
    // `UnitDouble`.
    Unit,
    // `UnitDouble.xmap(square, sqrt)` with an explicit `doubleRange(0, 1)` codec.
    UnitSquare,
    // `UnitDouble.xmap(square, sqrt)` using the value set's own codec.
    UnitSquareImplicit,
    // String-represented enum.
    Named(&'static [&'static str]),
    // Enum stored as its id, wrapping out-of-range ids.
    Id(i32),
    // `CloudStatus` with the boolean alternative.
    Clouds,
    // Any string (`LazyEnum` while the game is not running).
    AnyStr,
}

Kind :: enum {
    Option(Spec),
    PlainBool,
    PlainInt,
    PlainStr,
    List,
    Tutorial,
    Key,
}

Def :: struct {
    key: string,
    kind: Kind,
    default: V,
}

    // rust: const TUTORIAL_STEPS: [&str; 6] = [
    // rust: "movement",
    // rust: "find_tree",
    // rust: "punch_tree",
    // rust: "open_inventory",
    // rust: "craft_planks",
    // rust: "none",
    // rust: ];
    // rust: const MODEL_PARTS: [&str; 7] = [
    // rust: "cape",
    // rust: "jacket",
    // rust: "left_sleeve",
    // rust: "right_sleeve",
    // rust: "left_pants_leg",
    // rust: "right_pants_leg",
    // rust: "hat",
    // rust: ];
GRAPHICS_BACKEND :: &["default", "opengl", "vulkan"]
GRAPHICS_PRESET :: &["fast", "fancy", "fabulous", "custom"]
// Horizon's render distance cap (vanilla stops at 32): the server protocol's
// view distance tops out at 127 anyway.
MAX_RENDER_DISTANCE :: 128
INACTIVITY :: &["minimized", "afk"]
CLOUDS :: &["false", "fast", "true"]
MAIN_HAND :: &["left", "right"]
PRESENCE :: &["none", "limited", "all"]
MUSIC_TOAST :: &["never", "pause", "pause_and_toast"]
MUSIC_FREQUENCY :: &["DEFAULT", "FREQUENT", "CONSTANT"]

def :: proc(key: string, kind: Kind, default: V) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Def {
    // rust: key: key.to_owned(),
    // rust: kind,
    // rust: default,
}
}

// The processing order of `Options.processOptions`.
    // rust: static TABLE: LazyLock<Vec<Def>> = LazyLock::new(|| {
//     use Kind::{List, Option as O, PlainBool as PB, PlainInt as PI, PlainStr as PS, Tutorial};
//     use Spec::{
    // rust: AnyStr, Bool, Clouds, Fov, FrameLimit, Id, Int, LazyInt, Named, Scaled, Unit, UnitSquare,
    // rust: UnitSquareImplicit, WheelSensitivity,
}
    // rust: let b = |key: &str, d: bool| def(key, O(Bool), V::Bool(d));
    // rust: let i = |key: &str, lo, hi, d: i32| def(key, O(Int(lo, hi)), V::Int(d));
    // rust: let u = |key: &str, d: f64| def(key, O(Unit), V::Double(d));
    // rust: let n =
    // rust: |key: &str, names: &'static [&'static str], d: i32| def(key, O(Named(names)), V::Int(d));
    // rust: let id = |key: &str, count: i32, d: i32| def(key, O(Id(count)), V::Int(d));
    // rust: let pb = |key: &str, d: bool| def(key, PB, V::Bool(d));
    // rust: let mut t = vec![
    // rust: b("ao", true),
    // rust: i("biomeBlendRadius", 0, 7, 2),
    // rust: def(
    // rust: "chunkSectionFadeInTime",
    // rust: O(Scaled(0, 40, 20.0, 0.0, 2.0)),
    // rust: V::Double(0.75),
    // rust: ),
    // rust: b("cutoutLeaves", true),
    // rust: b("enableVsync", true),
    // rust: def(
    // rust: "entityDistanceScaling",
    // rust: O(Scaled(2, 20, 4.0, 0.5, 5.0)),
    // rust: V::Double(1.0),
    // rust: ),
    // rust: b("entityShadows", true),
    // rust: b("forceUnicodeFont", false),
    // rust: b("japaneseGlyphVariants", false),
    // rust: def("fov", O(Fov), V::Int(70)),
    // rust: def("fovEffectScale", O(UnitSquare), V::Double(1.0)),
    // rust: def("darknessEffectScale", O(UnitSquareImplicit), V::Double(1.0)),
    // rust: u("glintSpeed", 0.5),
    // rust: u("glintStrength", 0.75),
    // rust: n("preferredGraphicsBackend", GRAPHICS_BACKEND, 0),
    // rust: n("graphicsPreset", GRAPHICS_PRESET, 1),
    // rust: id("prioritizeChunkUpdates", 3, 0),
    // rust: b("fullscreen", false),
    // rust: b("exclusiveFullscreen", false),
    // rust: b("macFullscreenMenuVisibility", false),
    // rust: u("gamma", 0.5),
    // rust: def("guiScale", O(LazyInt(0)), V::Int(0)),
    // rust: def("debugGuiScale", O(LazyInt(-1)), V::Int(0)),
    // rust: i("maxAnisotropyBit", 1, 3, 2),
    // rust: id("textureFiltering", 3, 0),
    // rust: def("maxFps", O(FrameLimit), V::Int(120)),
    // rust: b("improvedTransparency", false),
    // rust: n("inactivityFpsLimit", INACTIVITY, 1),
    // rust: i("mipmapLevels", 0, 4, 4),
    // rust: id("narrator", 4, 0),
    // rust: id("particles", 3, 0),
    // rust: b("reducedDebugInfo", false),
    // rust: def("renderClouds", O(Clouds), V::Int(2)),
    // rust: i("cloudRange", 2, 128, 128),
    // rust: i("renderDistance", 2, MAX_RENDER_DISTANCE, 12),
    // rust: i("simulationDistance", 5, 32, 12),
    // rust: u("screenEffectScale", 1.0),
    // rust: def("soundDevice", O(AnyStr), V::Str(String::new())),
    // rust: b("vignette", true),
    // rust: i("weatherRadius", 3, 10, 10),
    // rust: b("autoJump", false),
    // rust: b("rotateWithMinecart", false),
    // rust: b("operatorItemsTab", false),
    // rust: b("autoSuggestions", true),
    // rust: b("chatColors", true),
    // rust: b("chatLinks", true),
    // rust: b("chatLinksPrompt", true),
    // rust: b("discrete_mouse_scroll", false),
    // rust: b("invertXMouse", false),
    // rust: b("invertYMouse", false),
    // rust: b("realmsNotifications", true),
    // rust: b("showSubtitles", false),
    // rust: b("directionalAudio", false),
    // rust: b("bobView", true),
    // rust: b("toggleCrouch", false),
    // rust: b("toggleSprint", false),
    // rust: b("toggleAttack", false),
    // rust: b("toggleUse", false),
    // rust: i("sprintWindow", 0, 10, 7),
    // rust: b("darkMojangStudiosBackground", false),
    // rust: b("hideLightningFlashes", false),
    // rust: b("hideSplashTexts", false),
    // rust: u("mouseSensitivity", 0.5),
    // rust: u("damageTiltStrength", 1.0),
    // rust: b("highContrast", false),
    // rust: b("highContrastBlockOutline", false),
    // rust: b("narratorHotkey", true),
    // rust: def("resourcePacks", List, V::List(Vec::new())),
    // rust: def("incompatibleResourcePacks", List, V::List(Vec::new())),
    // rust: def("lastServer", PS, V::Str(String::new())),
    // rust: def("lang", PS, V::Str("en_us".into())),
    // rust: id("chatVisibility", 3, 0),
    // rust: u("chatOpacity", 1.0),
    // rust: u("chatLineSpacing", 0.0),
    // rust: u("textBackgroundOpacity", 0.5),
    // rust: b("backgroundForChatOnly", true),
    // rust: pb("hideServerAddress", false),
    // rust: pb("advancedItemTooltips", false),
    // rust: pb("pauseOnLostFocus", true),
    // rust: def("overrideWidth", PI, V::Int(0)),
    // rust: def("overrideHeight", PI, V::Int(0)),
    // rust: u("chatHeightFocused", 1.0),
    // rust: def(
    // rust: "chatDelay",
    // rust: O(Scaled(0, 60, 10.0, 0.0, 6.0)),
    // rust: V::Double(0.0),
    // rust: ),
    // rust: u("chatHeightUnfocused", 0.4375),
    // rust: u("chatScale", 1.0),
    // rust: u("chatWidth", 1.0),
    // rust: def(
    // rust: "notificationDisplayTime",
    // rust: O(Scaled(5, 100, 10.0, 0.5, 10.0)),
    // rust: V::Double(1.0),
    // rust: ),
    // rust: pb("useNativeTransport", true),
    // rust: n("mainHand", MAIN_HAND, 1),
    // rust: id("attackIndicator", 3, 1),
    // rust: def("tutorialStep", Tutorial, V::Int(0)),
    // rust: def("mouseWheelSensitivity", O(WheelSensitivity), V::Double(1.0)),
    // rust: b("allowCursorChanges", true),
    // rust: b("quitShortcuts", true),
    // rust: b("ctrlClickEmulatesRightClick", false),
    // rust: def("glDebugVerbosity", PI, V::Int(1)),
    // rust: pb("skipMultiplayerWarning", false),
    // rust: b("hideMatchedNames", true),
    // rust: pb("joinedFirstServer", false),
    // rust: pb("syncChunkWrites", false),
    // rust: b("showAutosaveIndicator", true),
    // rust: b("allowServerListing", true),
    // rust: b("inGameNotification", false),
    // rust: n("sharePresence", PRESENCE, 2),
    // rust: b("onlyShowSecureChat", false),
    // rust: b("saveChatDrafts", false),
    // rust: u("panoramaScrollSpeed", 1.0),
    // rust: b("telemetryOptInExtra", false),
    // rust: pb("onboardAccessibility", true),
    // rust: i("menuBackgroundBlurriness", 0, 10, 5),
    // rust: pb("startedCleanly", true),
    // rust: n("musicToast", MUSIC_TOAST, 0),
    // rust: n("musicFrequency", MUSIC_FREQUENCY, 0),
    // rust: ];
    // rust: for (name, key, _) in crate::keybinds::MAPPINGS {
    // rust: t.push(def(
    // rust: &format!("key_{name}"),
    // rust: Kind::Key,
    // rust: V::Str((*key).to_owned()),
    // rust: ));
}
    // rust: for source in crate::settings::SOUND_SOURCES {
    // rust: t.push(u(&format!("soundCategory_{source}"), 1.0));
}
    // rust: for part in MODEL_PARTS {
    // rust: t.push(pb(&format!("modelPart_{part}"), true));
}
    // rust: t
    // rust: });

// Mth.floor for doubles.
floor_int :: proc(v: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let i = v as i32;
    // rust: if v < f64::from(i) { i - 1 } else { i }
}

number :: proc(json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match json {
    // rust: Json::Number(n) => Some(n),
    // rust: _ => None,
}
}
codec_int :: proc(json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: number(json).map(Json::int_value)
}
codec_double :: proc(json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: number(json).map(Json::double_value)
}
codec_bool :: proc(json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match json {
    // rust: Json::Bool(b) => Some(*b),
    // rust: _ => None,
}
}
codec_string :: proc(json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match json {
    // rust: Json::String(s) => Some(s),
    // rust: _ => None,
}
}
double_range :: proc(v: f64, lo: f64, hi: f64) -> O {
    // Ported from Horizon
    return {}
}
    // Double.compareTo: -0.0 sorts below 0.0 and NaN above everything.
    // rust: (v.total_cmp(&lo).is_ge() && v.total_cmp(&hi).is_le() && !v.is_nan()).then_some(v)
}
log_mouse :: proc(value: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: horizon_core::jmath::pow(10.0, f64::from(value) / 100.0)
}
unit_alt :: proc(json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: codec_double(json)
    // rust: .and_then(|v| double_range(v, 0.0, 1.0))
    // rust: .or_else(|| codec_bool(json).map(|b| if b { 1.0 } else { 0.0 }))
}

    // rust: impl Spec {
    // `codec.parse(JsonOps.INSTANCE, element)`.
decode :: proc(self: ^Self, json: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Spec::Bool => codec_bool(json).map(V::Bool),
    // rust: Spec::Int(lo, hi) => {
    // rust: let v = codec_int(json)?;
    // rust: (v >= lo && i64::from(v) <= i64::from(hi) + 1).then_some(V::Int(v))
}
    // rust: Spec::LazyInt(lo) => {
    // rust: let v = codec_int(json)?;
    // rust: (v >= lo).then_some(V::Int(v))
}
    // rust: Spec::Scaled(.., lo, hi) => double_range(codec_double(json)?, lo, hi).map(V::Double),
    // rust: Spec::FrameLimit => {
    // rust: let v = codec_int(json)?;
    // rust: (10..=260).contains(&v).then_some(V::Int(v))
}
    // rust: Spec::Fov => Some(V::Int((codec_double(json)? * 40.0 + 70.0) as i32)),
    // rust: Spec::WheelSensitivity => {
    // rust: double_range(codec_double(json)?, log_mouse(-200), log_mouse(100)).map(V::Double)
}
    // rust: Spec::Unit => unit_alt(json).map(V::Double),
    // rust: Spec::UnitSquare => double_range(codec_double(json)?, 0.0, 1.0).map(V::Double),
    // rust: Spec::UnitSquareImplicit => unit_alt(json).map(|v| V::Double(v * v)),
    // rust: Spec::Named(names) => {
    // rust: let s = codec_string(json)?;
    // rust: names.iter().position(|n| *n == s).map(|i| V::Int(i as i32))
}
    // rust: Spec::Id(count) => codec_int(json).map(|v| V::Int(v.rem_euclid(count))),
    // rust: Spec::Clouds => {
    // rust: if let Some(s) = codec_string(json) {
    // rust: return CLOUDS
    // rust: .iter()
    // rust: .position(|n| *n == s)
    // rust: .map(|i| V::Int(i as i32));
}
    // rust: codec_bool(json).map(|b| V::Int(if b { 2 } else { 0 }))
}
    // rust: Spec::AnyStr => codec_string(json).map(|s| V::Str(s.to_owned())),
}
}

    // `ValueSet.validateValue`; `None` makes `OptionInstance.set` fall back
    // to the option's initial value.
validate :: proc(self: ^Self, v: ^V) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match (self, v) {
    // rust: (Spec::Bool, V::Bool(_)) => Some(v.clone()),
    // rust: (Spec::Int(lo, hi), V::Int(x)) => (*x >= lo && *x <= hi).then(|| v.clone()),
    // rust: (Spec::LazyInt(lo), V::Int(x)) => Some(V::Int((*x).clamp(lo, 2_147_483_646))),
    // rust: (Spec::Scaled(imin, imax, k, ..), V::Double(x)) => {
    // rust: let i = (x * k) as i32;
    // rust: (i >= imin && i <= imax).then(|| V::Double(f64::from(i) / k))
}
    // rust: (Spec::FrameLimit, V::Int(x)) => {
    // rust: let i = x / 10;
    // rust: (1..=26).contains(&i).then(|| V::Int(i * 10))
}
    // rust: (Spec::Fov, V::Int(x)) => (30..=110).contains(x).then(|| v.clone()),
    // rust: (Spec::WheelSensitivity, V::Double(x)) => {
    // rust: let i = floor_int(horizon_core::jmath::log10(*x) * 100.0);
    // rust: (-200..=100).contains(&i).then(|| V::Double(log_mouse(i)))
}
    // rust: (Spec::Unit, V::Double(x)) => (*x >= 0.0 && *x <= 1.0).then(|| v.clone()),
    // rust: (Spec::UnitSquare | Spec::UnitSquareImplicit, V::Double(x)) => {
    // rust: let root = x.sqrt();
    // rust: (0.0..=1.0)
    // rust: .contains(&root)
    // rust: .then_some(V::Double(root * root))
}
    // rust: (Spec::Named(names), V::Int(x)) => {
    // rust: (*x >= 0 && (*x as usize) < names.len()).then(|| v.clone())
}
    // rust: (Spec::Id(count), V::Int(x)) => (*x >= 0 && *x < count).then(|| v.clone()),
    // rust: (Spec::Clouds, V::Int(x)) => (0..3).contains(x).then(|| v.clone()),
    // rust: (Spec::AnyStr, V::Str(_)) => Some(v.clone()),
    // rust: _ => None,
}
}

    // `codec.encodeStart(JsonOps.INSTANCE, value)` rendered by Gson.
encode :: proc(self: ^Self, v: ^V) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let double = |x: f64| java_text::double_to_string(x);
    // rust: Some(match (self, v) {
    // rust: (Spec::Bool, V::Bool(b)) => b.to_string(),
    // rust: (Spec::Int(lo, hi), V::Int(x)) => {
    // rust: if *x < lo || i64::from(*x) > i64::from(hi) + 1 {
    // rust: return None;
}
    // rust: x.to_string()
}
    // rust: (Spec::LazyInt(lo), V::Int(x)) => {
    // rust: if *x < lo {
    // rust: return None;
}
    // rust: x.to_string()
}
    // rust: (Spec::Scaled(.., lo, hi), V::Double(x)) => {
    // rust: double_range(*x, lo, hi)?;
    // rust: double(*x)
}
    // rust: (Spec::FrameLimit, V::Int(x)) => {
    // rust: if !(10..=260).contains(x) {
    // rust: return None;
}
    // rust: x.to_string()
}
    // rust: (Spec::Fov, V::Int(x)) => double((f64::from(*x) - 70.0) / 40.0),
    // rust: (Spec::WheelSensitivity, V::Double(x)) => {
    // rust: double_range(*x, log_mouse(-200), log_mouse(100))?;
    // rust: double(*x)
}
    // rust: (Spec::Unit, V::Double(x)) => {
    // rust: double_range(*x, 0.0, 1.0)?;
    // rust: double(*x)
}
    // rust: (Spec::UnitSquare, V::Double(x)) => {
    // rust: double_range(*x, 0.0, 1.0)?;
    // rust: double(*x)
}
    // rust: (Spec::UnitSquareImplicit, V::Double(x)) => {
    // rust: let root = x.sqrt();
    // rust: double_range(root, 0.0, 1.0)?;
    // rust: double(root)
}
    // rust: (Spec::Named(names), V::Int(x)) => {
    // rust: java_text::gson_string(names.get(usize::try_from(*x).ok()?)?)
}
    // rust: (Spec::Id(_), V::Int(x)) => x.to_string(),
    // rust: (Spec::Clouds, V::Int(x)) => {
    // rust: java_text::gson_string(CLOUDS.get(usize::try_from(*x).ok()?)?)
}
    // rust: (Spec::AnyStr, V::Str(s)) => java_text::gson_string(s),
    // rust: _ => return None,
    // rust: })
}
}

// `InputConstants.getKey(name)`: the canonical name of a key, or the
// unbound key when `name` is invalid.
canonical_key :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: for (_, n) in key_names::KEYBOARD.iter().chain(key_names::MOUSE) {
    // rust: if *n == name {
    // rust: return Ok(name.to_owned());
}
}
    // rust: for (prefix, table) in [
    // rust: ("key.keyboard", key_names::KEYBOARD),
    // rust: ("key.mouse", key_names::MOUSE),
    // rust: ] {
    // rust: if let Some(rest) = name.strip_prefix(prefix) {
            // substring(prefix.length() + 1): the separator is skipped blindly.
    // rust: let mut chars = rest.chars();
    // rust: if chars.next().is_none() {
                // StringIndexOutOfBoundsException is not an IllegalArgumentException.
    // rust: return Err(java_text::SyntaxError);
}
    // rust: let Some(value) = crate::options_fixes::java_parse_int(chars.as_str()) else {
    // rust: return Ok("key.keyboard.unknown".into());
}
    // rust: return Ok(table
    // rust: .iter()
    // rust: .find(|(v, _)| *v == value)
    // rust: .map_or_else(|| format!("{prefix}.{value}"), |(_, n)| (*n).to_owned()));
}
}
    // rust: Ok("key.keyboard.unknown".into())
}

read_list :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // GsonHelper.fromNullableJson with a List<String> type token.
    // rust: Ok(java_text::parse_strict_string_list(text)?.unwrap_or_default())
}

// All option values in `processOptions` order.
OptionsFile :: struct {
    values: [dynamic]V,
    // `fullscreenResolution`, kept verbatim.
    fullscreen_resolution: Maybe(string),
}

    // rust: impl Default for OptionsFile {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: values: TABLE.iter().map(|d| d.default.clone()).collect(),
    // rust: fullscreen_resolution: None,
}
}
}

    // rust: impl OptionsFile {
index :: proc(key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: TABLE.iter().position(|d| d.key == key)
}
get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::index(key).map(|i| &self.values[i])
}
bool :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.get(key), Some(V::Bool(true)))
}
int :: proc(self: ^Self, key: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self.get(key) {
    // rust: Some(V::Int(i)) => *i,
    // rust: _ => 0,
}
}
double :: proc(self: ^Self, key: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.get(key) {
    // rust: Some(V::Double(d)) => *d,
    // rust: _ => 0.0,
}
}
string :: proc(self: ^Self, key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self.get(key) {
    // rust: Some(V::Str(s)) => s.clone(),
    // rust: _ => String::new(),
}
}
list :: proc(self: ^Self, key: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match self.get(key) {
    // rust: Some(V::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
}
    // The serialized name of an enum-valued option.
name :: proc(self: ^Self, key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(i) = Self::index(key) else {
    // rust: return String::new();
}
    // rust: match (TABLE[i].kind, &self.values[i]) {
    // rust: (Kind::Option(Spec::Named(names)), V::Int(x)) => {
    // rust: names.get(*x as usize).copied().unwrap_or("").to_owned()
}
    // rust: (Kind::Option(Spec::Clouds), V::Int(x)) => {
    // rust: CLOUDS.get(*x as usize).copied().unwrap_or("").to_owned()
}
    // rust: _ => String::new(),
}
}
    // `OptionInstance.set` with a candidate value (invalid values revert to
    // the initial value).
set :: proc(self: ^Self, key: string, value: V) {
}
    // rust: let Some(i) = Self::index(key) else { return };
    // rust: let Kind::Option(spec) = TABLE[i].kind else {
    // rust: self.values[i] = value;
    // rust: return;
}
    // rust: self.values[i] = spec
    // rust: .validate(&value)
    // rust: .unwrap_or_else(|| TABLE[i].default.clone());
}
    // Select an enum option by serialized name.
set_name :: proc(self: ^Self, key: string, name: string) {
}
    // rust: let Some(i) = Self::index(key) else { return };
    // rust: let names: &[&str] = match TABLE[i].kind {
    // rust: Kind::Option(Spec::Named(names)) => names,
    // rust: Kind::Option(Spec::Clouds) => CLOUDS,
    // rust: _ => return,
}
    // rust: if let Some(p) = names.iter().position(|n| *n == name) {
    // rust: self.values[i] = V::Int(p as i32);
}
}
    // `Options.modelCustomisation`: the PlayerModelPart bits the player shows
    // (cape first, as `modelPart_*` is in `MODEL_PARTS`).
model_customisation :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MODEL_PARTS
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, part)| self.bool(&format!("modelPart_{part}")))
    // rust: .fold(0, |bits, (bit, _)| bits | 1 << bit)
}
    // Key mapping value by mapping name.
key_binding :: proc(self: ^Self, name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.string(&format!("key_{name}"))
}

    // `Options.load` on the text of an options file.
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut file = Self::default();
    // rust: let mut raw: std::collections::HashMap<String, String> = std::collections::HashMap::new();
    // rust: for line in split_lines(text) {
    // rust: if let Some((k, v)) = line.split_once(':') {
    // rust: raw.insert(k.to_owned(), v.to_owned());
}
}
    // rust: let version = raw
    // rust: .get("version")
    // rust: .and_then(|v| crate::options_fixes::java_parse_int(v))
    // rust: .unwrap_or(0);
        // A fixer failure abandons the whole file, leaving the defaults.
    // rust: if crate::options_fixes::update(&mut raw, version).is_ok() {
    // rust: file.apply(&raw);
}
    // rust: file
}

apply :: proc(self: ^Self, raw: ^std::collections::HashMap<string) {
}
        // A syntax error aborts the rest of the load, fullscreenResolution included.
    // rust: if self.try_apply(raw).is_ok()
    // rust: && let Some(r) = raw.get("fullscreenResolution")
    // rust: {
    // rust: self.fullscreen_resolution = Some(r.clone());
}
}

    // rust: fn try_apply(
    // rust: &mut self,
    // rust: raw: &std::collections::HashMap<String, String>,
    // rust: ) -> Result<(), java_text::SyntaxError> {
    // rust: for (i, d) in TABLE.iter().enumerate() {
    // rust: let Some(text) = raw.get(&d.key) else {
    // rust: continue;
}
    // rust: match d.kind {
    // rust: Kind::Option(spec) => {
    // rust: let json =
    // rust: java_text::parse_lenient(if text.is_empty() { "\"\"" } else { text })?;
    // rust: if let Some(decoded) = spec.decode(&json) {
    // rust: self.values[i] =
    // rust: spec.validate(&decoded).unwrap_or_else(|| d.default.clone());
}
}
    // rust: Kind::PlainBool => self.values[i] = V::Bool(text == "true"),
    // rust: Kind::PlainInt => {
    // rust: if let Some(v) = crate::options_fixes::java_parse_int(text) {
    // rust: self.values[i] = V::Int(v);
}
}
    // rust: Kind::PlainStr => self.values[i] = V::Str(text.clone()),
    // rust: Kind::List => self.values[i] = V::List(read_list(text)?),
    // rust: Kind::Tutorial => {
    // rust: let step = TUTORIAL_STEPS.iter().position(|n| n == text).unwrap_or(5);
    // rust: self.values[i] = V::Int(step as i32);
}
    // rust: Kind::Key => {
    // rust: let V::Str(current) = &self.values[i] else {
    // rust: continue;
}
    // rust: if current != text {
    // rust: self.values[i] = V::Str(canonical_key(text)?);
}
}
}
}
    // rust: Ok(())
}

    // `Options.save`.
serialize :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = format!("version:{}\n", horizon_world::DATA_VERSION);
    // rust: for (d, v) in TABLE.iter().zip(&self.values) {
    // rust: let rendered = match (d.kind, v) {
    // rust: (Kind::Option(spec), v) => match spec.encode(v) {
    // rust: Some(s) => s,
    // rust: None => continue,
    // rust: },
    // rust: (Kind::PlainBool, V::Bool(b)) => b.to_string(),
    // rust: (Kind::PlainInt, V::Int(x)) => x.to_string(),
    // rust: (Kind::PlainStr | Kind::Key, V::Str(s)) => s.clone(),
    // rust: (Kind::List, V::List(items)) => {
    // rust: let parts: Vec<String> =
    // rust: items.iter().map(|s| java_text::gson_string(s)).collect();
    // rust: format!("[{}]", parts.join(","))
}
    // rust: (Kind::Tutorial, V::Int(x)) => TUTORIAL_STEPS
    // rust: .get(*x as usize)
    // rust: .copied()
    // rust: .unwrap_or("none")
    // rust: .to_owned(),
    // rust: _ => continue,
}
    // rust: out.push_str(&d.key);
    // rust: out.push(':');
    // rust: out.push_str(&rendered);
    // rust: out.push('\n');
}
    // rust: if let Some(r) = &self.fullscreen_resolution {
    // rust: out.push_str("fullscreenResolution:");
    // rust: out.push_str(r);
    // rust: out.push('\n');
}
    // rust: out
}
}

// `BufferedReader.lines()`: \n, \r\n and \r terminate lines.
split_lines :: proc(text: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines = Vec::new();
    // rust: let bytes = text.as_bytes();
    // rust: let mut start = 0;
    // rust: let mut i = 0;
    // rust: while i < bytes.len() {
    // rust: match bytes[i] {
    // rust: b'\n' => {
    // rust: lines.push(&text[start..i]);
    // rust: start = i + 1;
}
    // rust: b'\r' => {
    // rust: lines.push(&text[start..i]);
    // rust: if bytes.get(i + 1) == Some(&b'\n') {
    // rust: i += 1;
}
    // rust: start = i + 1;
}
    // rust: _ => {}
}
    // rust: i += 1;
}
    // rust: if start < bytes.len() {
    // rust: lines.push(&text[start..]);
}
    // rust: lines
}

// Option names in processing order (for tests and tooling).
keys :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: TABLE.iter().map(|d| d.key.as_str()).collect()
}

// What an option accepts, for the control socket (`options-get`).
accepts :: proc(kind: Kind) -> s {
    // Ported from Horizon
    return {}
}
//     use serde_json::json;
    // rust: match kind {
    // rust: Kind::Option(Spec::Bool) | Kind::PlainBool => json!({ "type": "bool" }),
    // rust: Kind::Option(Spec::Int(lo, hi)) => json!({ "type": "int", "min": lo, "max": hi }),
    // rust: Kind::Option(Spec::LazyInt(lo)) => json!({ "type": "int", "min": lo }),
    // rust: Kind::Option(Spec::Scaled(imin, imax, k, ..)) => json!({
    // rust: "type": "double",
    // rust: "min": f64::from(imin) / k,
    // rust: "max": f64::from(imax) / k,
    // rust: "step": 1.0 / k,
    // rust: }),
    // rust: Kind::Option(Spec::FrameLimit) => {
    // rust: json!({ "type": "int", "min": 10, "max": 260, "step": 10 })
}
    // rust: Kind::Option(Spec::Fov) => json!({ "type": "int", "min": 30, "max": 110 }),
    // rust: Kind::Option(Spec::WheelSensitivity) => {
    // rust: json!({ "type": "double", "min": log_mouse(-200), "max": log_mouse(100) })
}
    // rust: Kind::Option(Spec::Unit | Spec::UnitSquare | Spec::UnitSquareImplicit) => {
    // rust: json!({ "type": "double", "min": 0.0, "max": 1.0 })
}
    // rust: Kind::Option(Spec::Named(names)) => json!({ "type": "enum", "choices": names }),
    // rust: Kind::Option(Spec::Id(count)) => json!({ "type": "int", "min": 0, "max": count - 1 }),
    // rust: Kind::Option(Spec::Clouds) => json!({ "type": "enum", "choices": CLOUDS }),
    // rust: Kind::Option(Spec::AnyStr) | Kind::PlainStr => json!({ "type": "string" }),
    // rust: Kind::PlainInt => json!({ "type": "int" }),
    // rust: Kind::List => json!({ "type": "list" }),
    // rust: Kind::Tutorial => json!({ "type": "enum", "choices": TUTORIAL_STEPS }),
    // rust: Kind::Key => json!({ "type": "key", "example": "key.keyboard.w" }),
}
}

// The names of an enum-valued option.
choices :: proc(kind: Kind) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: Kind::Option(Spec::Named(names)) => Some(names),
    // rust: Kind::Option(Spec::Clouds) => Some(CLOUDS),
    // rust: Kind::Tutorial => Some(&TUTORIAL_STEPS),
    // rust: _ => None,
}
}

    // rust: impl OptionsFile {
    // An option for the control socket: `{"value", "type", ...}` with what
    // it accepts (range, choices); enum values by name. None when unknown.
describe :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = Self::index(key)?;
    // rust: let kind = TABLE[i].kind;
    // rust: let value = match (choices(kind), &self.values[i]) {
    // rust: (Some(names), V::Int(x)) => usize::try_from(*x)
    // rust: .ok()
    // rust: .and_then(|x| names.get(x))
    // rust: .map_or(serde_json::Value::Null, |n| (*n).into()),
    // rust: (_, V::Bool(b)) => (*b).into(),
    // rust: (_, V::Int(x)) => (*x).into(),
    // rust: (_, V::Double(d)) => (*d).into(),
    // rust: (_, V::Str(s)) => s.as_str().into(),
    // rust: (_, V::List(l)) => l.clone().into(),
}
    // rust: let mut out = accepts(kind);
    // rust: out["value"] = value;
    // rust: Some(out)
}

    // Set an option from text, as the control socket's `options-set` does:
    // enums by name, key bindings by key name (`key.keyboard.w`), lists as
    // JSON. Unlike loading `options.txt`, a value the option refuses is an
    // error naming what it accepts, and the option keeps its value.
set_text :: proc(self: ^Self, key: string, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let i = Self::index(key).ok_or_else(|| format!("unknown option {key}"))?;
    // rust: let d = &TABLE[i];
    // rust: let refused = || format!("{key} refuses {text:?}; it accepts {}", accepts(d.kind));
    // rust: let candidate = if let Some(names) = choices(d.kind) {
    // rust: let x = names.iter().position(|n| *n == text).ok_or_else(refused)?;
    // rust: V::Int(x as i32)
    // rust: } else if matches!(d.kind, Kind::Key) {
    // rust: let name = canonical_key(text).map_err(|_| refused())?;
    // rust: if name == "key.keyboard.unknown" && text != name {
    // rust: return Err(refused());
}
    // rust: V::Str(name)
    // rust: } else {
    // rust: match &d.default {
    // rust: V::Bool(_) => V::Bool(text.parse().map_err(|_| refused())?),
    // rust: V::Int(_) => V::Int(text.parse().map_err(|_| refused())?),
    // rust: V::Double(_) => V::Double(text.parse().map_err(|_| refused())?),
    // rust: V::Str(_) => V::Str(text.to_owned()),
    // rust: V::List(_) => V::List(serde_json::from_str(text).map_err(|_| refused())?),
}
}
    // rust: self.values[i] = match d.kind {
    // rust: Kind::Option(spec) => spec.validate(&candidate).ok_or_else(refused)?,
    // rust: _ => candidate,
}
    // rust: Ok(())
}
}

    // rust: mod control_tests {
//     use super::*;

describes_values_with_what_they_accept :: proc() {
}
    // rust: let f = OptionsFile::default();
    // rust: let fov = f.describe("fov").unwrap();
    // rust: assert_eq!(fov["value"], 70);
    // rust: assert_eq!(
    // rust: (fov["type"].as_str(), fov["min"].as_i64()),
    // rust: (Some("int"), Some(30))
    // rust: );
    // rust: assert_eq!(f.describe("renderClouds").unwrap()["value"], "true");
    // rust: assert_eq!(
    // rust: f.describe("key_key.forward").unwrap()["value"],
    // rust: "key.keyboard.w"
    // rust: );
    // rust: assert_eq!(f.describe("resourcePacks").unwrap()["type"], "list");
    // rust: assert!(f.describe("nope").is_none());
    // rust: for key in keys() {
    // rust: assert!(f.describe(key).is_some(), "{key}");
}
}

sets_valid_values_and_refuses_others :: proc() {
}
    // rust: let mut f = OptionsFile::default();
    // rust: f.set_text("fov", "90").unwrap();
    // rust: assert_eq!(f.get("fov"), Some(&V::Int(90)));
    // rust: let e = f.set_text("fov", "200").unwrap_err();
    // rust: assert!(e.contains("\"max\":110"), "{e}");
    // rust: assert_eq!(
    // rust: f.get("fov"),
    // rust: Some(&V::Int(90)),
    // rust: "a refused value changes nothing"
    // rust: );
    // rust: f.set_text("renderClouds", "fast").unwrap();
    // rust: assert_eq!(f.name("renderClouds"), "fast");
    // rust: assert!(f.set_text("renderClouds", "fancy").is_err());
    // rust: f.set_text("maxFps", "125").unwrap();
    // rust: assert_eq!(f.get("maxFps"), Some(&V::Int(120)), "IntRange steps of 10");
    // rust: f.set_text("key_key.jump", "key.keyboard.j").unwrap();
    // rust: assert_eq!(f.key_binding("key.jump"), "key.keyboard.j");
    // rust: assert!(f.set_text("key_key.jump", "jump").is_err());
    // rust: f.set_text("resourcePacks", r#"["vanilla","file/x.zip"]"#)
    // rust: .unwrap();
    // rust: assert_eq!(f.list("resourcePacks"), ["vanilla", "file/x.zip"]);
    // rust: assert!(f.set_text("gamma", "1.5").is_err());
    // rust: assert!(
    // rust: f.set_text("nope", "1")
    // rust: .unwrap_err()
    // rust: .contains("unknown option")
    // rust: );
}
}
