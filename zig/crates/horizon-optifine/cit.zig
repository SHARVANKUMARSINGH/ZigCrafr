//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_cit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Custom Item Textures: the rules of `optifine/cit/**/*.properties` and the pack's global
//! `cit.properties`, parsed into what they test on a stack and what they change. Matching stacks
//! against them is the client's (`horizon_client::cit`): it knows the items and their components.
//!
//! Written from OptiFine's `cit.properties` and `cit_single.properties` docs, CIT Resewn's wiki
//! (citresewn.shcm.io) and CIT Resewn Continuation's MIT-licensed source (its conditions, read
//! for the 1.21 component rules). Where OptiFine and CIT Resewn differ, CIT Resewn is followed,
//! but for keys neither reads: those are ignored, as OptiFine does, whereas CIT Resewn would
//! never match the rule.

// use crate::matchers::{IdList, Name, RangeList, namespaced};
// use crate::paths::{resolve, valid};
// use crate::properties::Properties;

/// What a rule changes (`type`).
pub const Kind = enum {
    Item,
    Armor,
    Elytra,
    Enchantment,
};

/// `hand`: the hand the item is drawn in; GUI items count as the main hand.
pub const Hand = enum {
    Any,
    Main,
    Off,
};

/// `damage` (with `%` against the item's max damage) and `damageMask`.
pub const Damage = struct {
    ranges: RangeList,
    percent: bool,
    mask: ?i32,
};

    // rust: impl Damage {
pub fn matches(self: *Self, damage: u32, max_damage: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = damage as i32;
    // rust: if let Some(mask) = self.mask {
    // rust: value &= mask;
}
    // rust: if !self.percent {
    // rust: return self.ranges.contains(value);
}
    // rust: if max_damage == 0 {
    // rust: return false;
}
    // rust: let percent = 100.0 * f64::from(value) / f64::from(max_damage);
    // rust: self.ranges
    // rust: .0
    // rust: .iter()
    // rust: .any(|&(lo, hi)| f64::from(lo) <= percent && percent <= f64::from(hi))
}
}

/// An OpenGL blend factor (`GL_ONE`, `GL_SRC_ALPHA`...), as `glBlendFuncSeparate` takes them.
pub const Factor = enum {
    Zero,
    One,
    SrcColor,
    OneMinusSrcColor,
    SrcAlpha,
    OneMinusSrcAlpha,
    DstAlpha,
    OneMinusDstAlpha,
    DstColor,
    OneMinusDstColor,
    SrcAlphaSaturate,
};

    // rust: impl Factor {
    /// A GL constant's name (`GL_DST_COLOR`) or its value, decimal or `0x` hex.
pub fn parse(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let code = match s.strip_prefix("0x") {
    // rust: Some(hex) => u32::from_str_radix(hex, 16).ok(),
    // rust: None => s.parse().ok(),
}
    // rust: let code = code.or_else(|| {
    // rust: let names = [
    // rust: "GL_ZERO",
    // rust: "GL_ONE",
    // rust: "GL_SRC_COLOR",
    // rust: "GL_ONE_MINUS_SRC_COLOR",
    // rust: "GL_SRC_ALPHA",
    // rust: "GL_ONE_MINUS_SRC_ALPHA",
    // rust: "GL_DST_ALPHA",
    // rust: "GL_ONE_MINUS_DST_ALPHA",
    // rust: "GL_DST_COLOR",
    // rust: "GL_ONE_MINUS_DST_COLOR",
    // rust: "GL_SRC_ALPHA_SATURATE",
    // rust: ];
    // rust: let i = names.iter().position(|n| *n == s)? as u32;
    // rust: Some(if i < 2 { i } else { 0x300 + i - 2 })
    // rust: })?;
//         use Factor::*;
    // rust: Some(match code {
    // rust: 0 => Zero,
    // rust: 1 => One,
    // rust: 0x300 => SrcColor,
    // rust: 0x301 => OneMinusSrcColor,
    // rust: 0x302 => SrcAlpha,
    // rust: 0x303 => OneMinusSrcAlpha,
    // rust: 0x304 => DstAlpha,
    // rust: 0x305 => OneMinusDstAlpha,
    // rust: 0x306 => DstColor,
    // rust: 0x307 => OneMinusDstColor,
    // rust: 0x308 => SrcAlphaSaturate,
    // rust: _ => return None,
    // rust: })
}
}

/// `blend`: the factors for colour and alpha; `None` (`replace`) draws without blending.
pub const Blend = struct {
    src: Factor,
    dst: Factor,
    src_alpha: Factor,
    dst_alpha: Factor,
};

/// `blend=` as CIT Resewn reads it: a named method, or 2 or 4 GL factors (alpha defaulting to
/// `GL_ZERO GL_ONE`). `Some(None)` is `replace`.
pub fn parse_blend(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use Factor::*;
    // rust: let pair = |src, dst| {
    // rust: Some(Some(Blend {
    // rust: src,
    // rust: dst,
    // rust: src_alpha: Zero,
    // rust: dst_alpha: One,
    // rust: }))
}
    // rust: match value.trim().to_ascii_lowercase().as_str() {
    // rust: "replace" => return Some(None),
    // rust: "glint" => return pair(SrcColor, One),
    // rust: "alpha" => return pair(SrcAlpha, OneMinusSrcAlpha),
    // rust: "add" => return pair(SrcAlpha, One),
    // rust: "subtract" => return pair(OneMinusDstColor, Zero),
    // rust: "multiply" => return pair(DstColor, OneMinusSrcAlpha),
    // rust: "dodge" => return pair(One, One),
    // rust: "burn" => return pair(Zero, OneMinusSrcColor),
    // rust: "screen" => return pair(One, OneMinusSrcColor),
    // rust: "overlay" => return pair(DstColor, SrcColor),
    // rust: _ => {}
}
    // rust: let factors: Option<Vec<Factor>> = value.split_whitespace().map(Factor::parse).collect();
    // rust: match factors?[..] {
    // rust: [src, dst] => pair(src, dst),
    // rust: [src, dst, src_alpha, dst_alpha] => Some(Some(Blend {
    // rust: src,
    // rust: dst,
    // rust: src_alpha,
    // rust: dst_alpha,
    // rust: })),
    // rust: _ => None,
}
}

/// A `type=enchantment` rule's glint layer.
pub const Glint = struct {
    layer: i32,
    blend: ?Blend,
    /// Scroll speed: the texture runs through vanilla's glint periods at `speed` times the
    /// clock in milliseconds (vanilla's own glint at 4 by default).
    speed: f32,
    /// Degrees the texture turns by (as in CIT Resewn, its scroll keeps vanilla's direction).
    rotation: f32,
    /// Seconds on this layer when `method=cycle` (1 by default, as OptiFine's doc has it).
    duration: f32,
    /// `r`, `g`, `b`, `a`: multipliers of the texture's colour, never negative.
    rgba: [f32,
    /// Whether the default glint still draws under this layer.
    use_glint: bool,
    /// Linear filtering, else nearest.
    blur: bool,
};

/// OptiFine's defaults (`blur`, which it does not document, is CIT Resewn's): still, unturned,
/// a second per cycle, added on top.
    // rust: impl Default for Glint {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: layer: 0,
    // rust: blend: parse_blend("add").flatten(),
    // rust: speed: 0.0,
    // rust: rotation: 0.0,
    // rust: duration: 1.0,
    // rust: rgba: [1.0; 4],
    // rust: use_glint: false,
    // rust: blur: true,
}
}
}

    // rust: impl Glint {
    /// A `type=enchantment` rule's glint keys; `None` (dropping the rule) when one is
    /// malformed. CIT Resewn clamps `duration` and the colour at 0.
pub fn parse(props: *Properties) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = Self::default();
    // rust: let float =
    // rust: |key: &str, default: f32| optional(props, &[key], finite).map(|v| v.unwrap_or(default));
    // rust: let flag = |key: &str, default: bool| {
    // rust: props
    // rust: .get(key)
    // rust: .map_or(default, |v| v.trim().eq_ignore_ascii_case("true"))
}
    // rust: let blend = match props.get("blend") {
    // rust: Some(v) => parse_blend(v)?,
    // rust: None => d.blend,
}
    // rust: Some(Self {
    // rust: layer: optional(props, &["layer"], |v| v.parse::<i32>().ok())?.unwrap_or(d.layer),
    // rust: blend,
    // rust: speed: float("speed", d.speed)?,
    // rust: rotation: float("rotation", d.rotation)?,
    // rust: duration: float("duration", d.duration)?.max(0.0),
    // rust: rgba: [
    // rust: float("r", 1.0)?.max(0.0),
    // rust: float("g", 1.0)?.max(0.0),
    // rust: float("b", 1.0)?.max(0.0),
    // rust: float("a", 1.0)?.max(0.0),
    // rust: ],
    // rust: use_glint: flag("useGlint", d.use_glint),
    // rust: blur: flag("blur", d.blur),
    // rust: })
}
}

/// A number, where NaN and the infinities (`nan`, `inf`, `Infinity` in any case) are malformed.
pub fn finite(v: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.trim().parse::<f32>().ok().filter(|f| f.is_finite())
}

/// Where a component test reads its value.
pub const Source = enum {
    /// A data component by id (`minecraft:custom_name`), then a path inside its NBT.
    Component(String),
    /// Pre-1.20.5 `Enchantments` / `StoredEnchantments`: a list of `{id, lvl}` compounds, which
    /// the client builds from the stack's enchantments.
    LegacyEnchantments { stored: bool },
};

/// One `components.<id>.<path>=<value>` or `nbt.<path>=<value>` test.
pub const ComponentTest = struct {
    source: Source,
    /// Compound keys and list indexes; `*` is any key or element, `count` a list's length. The
    /// tag walked decides which a segment is: `0` is an index in a list, a key in a compound.
    path: std.ArrayList([]const u8),
    value: ValueTest,
    /// A leading `!`: the test passes when the value does not match.
    negate: bool,
};

/// The right-hand side of a component test.
pub const ValueTest = enum {
    /// `exists:true` / `exists:false`.
    Exists(bool),
    /// `range:1 5 7-9`: an integer value.
    Range(RangeList),
    /// `raw:<name>`: the value written as SNBT.
    Raw(Name),
    /// `pattern:`, `regex:` (and their `i` forms) against a string, a text component's plain
    /// text, or a number's decimal form.
    Text(Name),
    /// A bare value: the same string, the same number (`#rrggbb` and `0x` hex are integers), or
    /// for a compound or list, SNBT that the value contains.
    Literal(Literal),
};

pub const Literal = struct {
    text: []const u8,
    int: ?i64,
    float: ?f64,
};

    // rust: impl Literal {
pub fn parse(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hex = text
    // rust: .strip_prefix('#')
    // rust: .or_else(|| text.strip_prefix("0x"))
    // rust: .and_then(|h| i64::from_str_radix(h, 16).ok());
    // rust: Self {
    // rust: text: text.to_owned(),
    // rust: int: hex.or_else(|| text.parse().ok()),
    // rust: float: text.parse().ok(),
}
}
}

    // rust: impl ValueTest {
pub fn parse(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (negate, value) = match value.strip_prefix('!') {
    // rust: Some(rest) => (true, rest),
    // rust: None => (false, value),
}
    // rust: let test = if let Some(v) = value.strip_prefix("exists:") {
    // rust: ValueTest::Exists(v.trim().parse().ok()?)
    // rust: } else if let Some(v) = value.strip_prefix("range:") {
    // rust: ValueTest::Range(RangeList::parse(v)?)
    // rust: } else if let Some(v) = value.strip_prefix("raw:") {
    // rust: ValueTest::Raw(Name::parse(v)?)
    // rust: } else if ["pattern:", "ipattern:", "regex:", "iregex:"]
    // rust: .iter()
    // rust: .any(|p| value.starts_with(p))
    // rust: {
    // rust: ValueTest::Text(Name::parse(value)?)
    // rust: } else {
    // rust: ValueTest::Literal(Literal::parse(value))
}
    // rust: Some((test, negate))
}
}

    // rust: impl ComponentTest {
    /// `key` is the part after `nbt.` or `components.`.
pub fn parse(legacy: bool, key: []const u8, value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
        // `~` is the minecraft namespace where it starts a segment (`levels.~thorns`).
    // rust: let mut segments: Vec<String> = key
    // rust: .split('.')
    // rust: .map(|s| match s.strip_prefix('~') {
    // rust: Some(rest) => format!("minecraft:{rest}"),
    // rust: None => s.to_owned(),
    // rust: })
    // rust: .collect();
    // rust: if segments.iter().any(String::is_empty) {
    // rust: return None;
}
    // rust: let (source, mut path) = if legacy {
    // rust: legacy_source(segments)?
    // rust: } else {
    // rust: let id = namespaced(&segments.remove(0));
    // rust: (Source::Component(id), segments)
}
        // Enchantments were `{levels: {id: level}}` until 1.21.5 and are the bare map since, as
        // OptiFine's doc still writes them (`components.enchantments.levels.~thorns`).
    // rust: if let Source::Component(id) = &source {
    // rust: if matches!(
    // rust: &**id,
    // rust: "minecraft:enchantments" | "minecraft:stored_enchantments"
    // rust: ) && path.first().is_some_and(|s| s == "levels")
    // rust: {
    // rust: path.remove(0);
}
}
    // rust: let (value, negate) = ValueTest::parse(value)?;
    // rust: Some(Self {
    // rust: source,
    // rust: path,
    // rust: value,
    // rust: negate,
    // rust: })
}
}

/// Where a pre-1.20.5 `nbt.` path lives since items moved to data components. Tags that became
/// no component of their own were moved into `minecraft:custom_data` by the game's data fixer,
/// so paths outside the tags 1.20.5 knew are read there. `None` for a tag that became a component
/// whose shape no longer matches the old one (`AttributeModifiers`, `pages`...): such a test
/// would never pass, or always pass when negated.
pub fn legacy_source(path: std.ArrayList([]const u8)) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let component = |id: &str, prefix: &[&str], rest: &[String]| {
    // rust: let path = prefix.iter().map(|s| (*s).to_owned());
    // rust: Some((
    // rust: Source::Component(format!("minecraft:{id}")),
    // rust: path.chain(rest.iter().cloned()).collect(),
    // rust: ))
}
    // rust: let strs: Vec<&str> = path.iter().map(String::as_str).collect();
    // rust: match strs[..] {
    // rust: ["display", "Name", ..] => component("custom_name", &[], &path[2..]),
    // rust: ["display", "Lore", ..] => component("lore", &[], &path[2..]),
    // rust: ["display", "color", ..] => component("dyed_color", &[], &path[2..]),
        // `map_color` is gone in 26.x; `LocName` became a translated `item_name`.
    // rust: ["display", "MapColor" | "LocName", ..] => None,
    // rust: ["CustomModelData", ..] => component("custom_model_data", &["floats", "0"], &path[1..]),
    // rust: ["Potion", ..] => component("potion_contents", &["potion"], &path[1..]),
    // rust: ["CustomPotionColor", ..] => component("potion_contents", &["custom_color"], &path[1..]),
    // rust: ["Damage", ..] => component("damage", &[], &path[1..]),
    // rust: ["RepairCost", ..] => component("repair_cost", &[], &path[1..]),
    // rust: ["Trim", ..] => component("trim", &[], &path[1..]),
    // rust: ["title", ..] => component("written_book_content", &["title", "raw"], &path[1..]),
    // rust: ["author", ..] => component("written_book_content", &["author"], &path[1..]),
        // `generation` and `flight_duration` are left out when 0: the matcher reads that default.
    // rust: ["generation", ..] => component("written_book_content", &["generation"], &path[1..]),
    // rust: ["SkullOwner"] | ["SkullOwner", "Name", ..] => {
    // rust: component("profile", &["name"], path.get(2..).unwrap_or_default())
}
    // rust: ["SkullOwner", "Id", ..] => component("profile", &["id"], &path[2..]),
        // `Properties.textures` became `profile.properties`, a list of `{name, value}`.
    // rust: ["SkullOwner", ..] => None,
    // rust: ["Fireworks", "Flight", ..] => component("fireworks", &["flight_duration"], &path[2..]),
    // rust: ["map", ..] => component("map_id", &[], &path[1..]),
    // rust: ["EntityTag", "variant", ..] => component("painting/variant", &[], &path[2..]),
    // rust: ["EntityTag", ..] => component("entity_data", &[], &path[1..]),
        // The 1.20.2 name of `CustomPotionEffects`, whose fields kept their names.
    // rust: ["custom_potion_effects", ..] => {
    // rust: component("potion_contents", &["custom_effects"], &path[1..])
}
        // The data fixer took these out of `BlockEntityTag` into components of their own shape.
    // rust: [
    // rust: "BlockEntityTag",
    // rust: "Base" | "Patterns" | "Items" | "Lock" | "LootTable" | "LootTableSeed" | "sherds"
    // rust: | "item" | "Bees" | "bees" | "note_block_sound",
    // rust: ..,
    // rust: ] => None,
    // rust: ["BlockEntityTag", ..] => component("block_entity_data", &[], &path[1..]),
    // rust: ["instrument", ..] => component("instrument", &[], &path[1..]),
    // rust: ["Recipes", ..] => component("recipes", &[], &path[1..]),
    // rust: ["DebugProperty", ..] => component("debug_stick_state", &[], &path[1..]),
    // rust: ["BlockStateTag", ..] => component("block_state", &[], &path[1..]),
    // rust: ["Enchantments", ..] => Some((
    // rust: Source::LegacyEnchantments { stored: false },
    // rust: path[1..].to_vec(),
    // rust: )),
    // rust: ["StoredEnchantments", ..] => Some((
    // rust: Source::LegacyEnchantments { stored: true },
    // rust: path[1..].to_vec(),
    // rust: )),
    // rust: [
    // rust: "Unbreakable"
    // rust: | "CanDestroy"
    // rust: | "CanPlaceOn"
    // rust: | "HideFlags"
    // rust: | "AttributeModifiers"
    // rust: | "CustomPotionEffects"
    // rust: | "effects"
    // rust: | "Decorations"
    // rust: | "LodestoneDimension"
    // rust: | "LodestonePos"
    // rust: | "LodestoneTracked"
    // rust: | "pages"
    // rust: | "filtered_pages"
    // rust: | "filtered_title"
    // rust: | "resolved"
    // rust: | "Fireworks"
    // rust: | "Explosion"
    // rust: | "BucketVariantTag"
    // rust: | "Items"
    // rust: | "ChargedProjectiles"
    // rust: | "Charged"
    // rust: | "CustomCreativeLock"
            // Bucket mobs': into `bucket_entity_data`, and `Variant` became a name.
    // rust: | "Variant"
    // rust: | "NoAI"
    // rust: | "Silent"
    // rust: | "NoGravity"
    // rust: | "Glowing"
    // rust: | "Invulnerable"
    // rust: | "Health"
    // rust: | "Age"
    // rust: | "HuntingCooldown",
    // rust: ..,
    // rust: ] => None,
    // rust: _ => component("custom_data", &[], &path),
}
}

/// One `.properties` file under `optifine/cit/`.
pub const Rule = struct {
    /// The file's resource path: the tie-breaker between rules of equal weight.
    path: []const u8,
    kind: Kind,
    weight: i32,
    /// Namespaced item ids; empty (enchantment rules only) is any item.
    items: std.ArrayList([]const u8),
    stack_size: ?RangeList,
    damage: ?Damage,
    hand: Hand,
    /// Namespaced enchantment ids, any of which the stack must have.
    enchantments: std.ArrayList([]const u8),
    /// Levels one of the stack's enchantments (of `enchantments`, when given) must have.
    enchantment_levels: ?RangeList,
    components: std.ArrayList(ComponentTest),
    /// `texture`, as a resource path to a `.png`.
    texture: ?[]const u8,
    /// `texture.<name>`: (name, resource path).
    textures: Vec<([]const u8,
    /// `model`, as a resource path to a `.json`.
    model: ?[]const u8,
    /// `model.<name>`.
    models: Vec<([]const u8,
    /// What an Enchantment rule draws; the defaults for other kinds.
    glint: Glint,
};

    // rust: impl Rule {
    /// The rule `props` (at resource path `path`, read with `Properties::parse_equals_first` as
    /// CIT Resewn reads them) describes. `exists` answers whether a resource path names a file,
    /// to find textures and models the way OptiFine and CIT Resewn look for them. `None` for an
    /// unknown type, a malformed condition, or a rule that changes nothing.
pub fn parse(path: []const u8, props: *Properties, exists: impl Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = match props.get("type").unwrap_or("item") {
    // rust: "item" => Kind::Item,
    // rust: "armor" => Kind::Armor,
    // rust: "elytra" => Kind::Elytra,
    // rust: "enchantment" => Kind::Enchantment,
    // rust: _ => return None,
}
    // rust: let stem = path
    // rust: .rsplit('/')
    // rust: .next()?
    // rust: .strip_suffix(".properties")
    // rust: .unwrap_or_default();
    // rust: let mut items: Vec<String> = props
    // rust: .get("items")
    // rust: .or_else(|| props.get("matchItems"))
    // rust: .map(|v| IdList::parse(v).include)
    // rust: .unwrap_or_default();
    // rust: if kind == Kind::Elytra {
    // rust: items = vec!["minecraft:elytra".to_owned()];
    // rust: } else if items.is_empty() && kind != Kind::Enchantment {
            // CIT Resewn: a rule named after an item is for that item (a bare id, so a
            // `minecraft:` one whatever the rule's namespace).
    // rust: items.push(namespaced(stem));
}
    // rust: let int = |v: &str| v.parse::<i32>().ok();
    // rust: let damage = match props.get("damage") {
    // rust: Some(v) => Some(Damage {
    // rust: ranges: RangeList::parse(&v.replace('%', ""))?,
    // rust: percent: v.contains('%'),
    // rust: mask: optional(props, &["damageMask", "damage_mask"], int)?,
    // rust: }),
    // rust: None => None,
}
    // rust: let enchantments = props
    // rust: .get("enchantments")
    // rust: .or_else(|| props.get("enchantmentIDs"))
    // rust: .map(|v| v.split_whitespace().map(enchantment_id).collect())
    // rust: .unwrap_or_default();
    // rust: let mut components = Vec::new();
        // `component.` is CIT Resewn's alias of `components.`.
    // rust: for (legacy, prefix) in [
    // rust: (true, "nbt."),
    // rust: (false, "components."),
    // rust: (false, "component."),
    // rust: ] {
    // rust: for (key, value) in props.with_prefix(prefix) {
    // rust: components.push(ComponentTest::parse(legacy, key, value)?);
}
}
    // rust: let tex = |v: &str| asset(path, v, "png", "textures", &exists);
    // rust: let model_at = |v: &str| asset(path, v, "json", "models", &exists);
        // A named asset that is not there drops the rule, as in CIT Resewn: half a bow's textures
        // would draw a vanilla frame among custom ones.
    // rust: let mut texture = optional(props, &["texture"], tex)?;
    // rust: let mut model = optional(props, &["model"], model_at)?;
    // rust: let textures = props
    // rust: .with_prefix("texture.")
    // rust: .map(|(name, v)| Some((name.to_owned(), tex(v)?)))
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: let models = props
    // rust: .with_prefix("model.")
    // rust: .map(|(name, v)| Some((name.to_owned(), model_at(v)?)))
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: if texture.is_none() && model.is_none() && textures.is_empty() && models.is_empty() {
            // Neither named: a model, then a texture, named after the file beside it.
    // rust: let dir = path.rsplit_once('/').map_or("", |(d, _)| d);
    // rust: let beside = |ext: &str| {
    // rust: let p = format!("{dir}/{stem}.{ext}");
    // rust: exists(&p).then_some(p)
}
    // rust: if kind == Kind::Item {
    // rust: model = beside("json");
}
    // rust: if model.is_none() {
    // rust: texture = beside("png");
}
}
    // rust: if texture.is_none() && model.is_none() && textures.is_empty() && models.is_empty() {
    // rust: return None;
}
        // A glint is a texture: CIT Resewn drops an enchantment rule without one ("No texture
        // specified"), whatever models it names.
    // rust: if kind == Kind::Enchantment && texture.is_none() {
    // rust: return None;
}
        // Only an enchantment rule reads the glint keys: an item rule's `blend=` is no reason to
        // drop it.
    // rust: let glint = if kind == Kind::Enchantment {
    // rust: Glint::parse(props)?
    // rust: } else {
    // rust: Glint::default()
}
    // rust: Some(Self {
    // rust: path: path.to_owned(),
    // rust: kind,
    // rust: weight: optional(props, &["weight", "cit_weight", "citWeight"], int)?.unwrap_or(0),
    // rust: items,
    // rust: stack_size: optional(
    // rust: props,
    // rust: &["stackSize", "stack_size", "amount"],
    // rust: RangeList::parse,
    // rust: )?,
    // rust: damage,
    // rust: hand: match props.get("hand").map(str::to_ascii_lowercase).as_deref() {
                // CIT Resewn's spellings too.
    // rust: None | Some("any" | "either" | "*") => Hand::Any,
    // rust: Some("main" | "mainhand" | "main_hand") => Hand::Main,
    // rust: Some("off" | "offhand" | "off_hand") => Hand::Off,
    // rust: Some(_) => return None,
    // rust: },
    // rust: enchantments,
    // rust: enchantment_levels: optional(
    // rust: props,
    // rust: &["enchantmentLevels", "enchantment_levels"],
    // rust: RangeList::parse,
    // rust: )?,
    // rust: components,
    // rust: texture,
    // rust: textures,
    // rust: model,
    // rust: models,
    // rust: glint,
    // rust: })
}

    /// Which of two matching rules is chosen: `Less` for the one that wins, the higher weight,
    /// then the path that sorts first.
pub fn priority(self: *Self, other: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (other.weight, &self.path).cmp(&(self.weight, &other.path))
}
}

/// `method` of `cit.properties`: how several enchantment layers on one item share it.
pub const Method = enum {
    /// Every layer at full strength, together (CIT Resewn's `none`).
    None,
    /// Each layer's intensity is its enchantment's level over the sum of levels.
    Average,
    /// Over the highest level.
    Layered,
    /// One layer at a time, each for its `duration`.
    Cycle,
};

/// The pack's `cit.properties`.
pub const Global = struct {
    method: Method,
    /// At most this many enchantment layers per item (the topmost win).
    cap: ?u32,
    /// Seconds a cycle takes to fade from one layer to the next.
    fade: f32,
    /// Whether the default glint draws on items no enchantment rule matches.
    use_glint: bool,
};

    // rust: impl Default for Global {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: method: Method::Average,
    // rust: cap: None,
    // rust: fade: 0.5,
    // rust: use_glint: true,
}
}
}

    // rust: impl Global {
    /// Where the global file may be, the first that exists winning, as both docs say (CIT
    /// Resewn's code merges the files' keys instead): CIT Resewn's and the OptiFine doc's folders.
    // rust: pub const PATHS: [&str; 4] = [
    // rust: "assets/minecraft/citresewn/cit.properties",
    // rust: "assets/minecraft/optifine/cit.properties",
    // rust: "assets/minecraft/optifine/cit/cit.properties",
    // rust: "assets/minecraft/mcpatcher/cit.properties",
    // rust: ];

    /// Unknown or malformed values keep their defaults.
pub fn parse(props: *Properties) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Self::default();
    // rust: let lower = |key| props.get(key).map(|v| v.trim().to_ascii_lowercase());
    // rust: match lower("method").as_deref() {
    // rust: Some("layered") => out.method = Method::Layered,
    // rust: Some("cycle") => out.method = Method::Cycle,
    // rust: Some("none") => out.method = Method::None,
    // rust: _ => {}
}
    // rust: out.cap = props.get("cap").and_then(|v| v.trim().parse().ok());
    // rust: if let Some(fade) = props.get("fade").and_then(finite) {
    // rust: out.fade = fade.max(0.0);
}
    // rust: out.use_glint = lower("useGlint").as_deref() != Some("false");
    // rust: out
}
}

/// An optional key, under any of its names (CIT Resewn's aliases): `Some(None)` when absent,
/// `None` (dropping the rule) when malformed.
    // rust: fn optional<T>(
    // rust: props: &Properties,
    // rust: keys: &[&str],
    // rust: parse: impl Fn(&str) -> Option<T>,
    // rust: ) -> Option<Option<T>> {
    // rust: match keys.iter().find_map(|k| props.get(k)) {
    // rust: Some(v) => parse(v).map(Some),
    // rust: None => Some(None),
}
}

/// A `texture`/`model` value as a resource path to an existing `.ext` file, trying what CIT
/// Resewn tries in its order: as written (OptiFine's paths, see `paths::resolve`, or a full
/// `assets/...` path), in the namespace's typed folder (`item/x` → `textures/item/x.png`), then
/// beside the rule (`sub/x`, and `./../x` up from its folder).
    // rust: fn asset(
    // rust: props: &str,
    // rust: value: &str,
    // rust: ext: &str,
    // rust: typed: &str,
    // rust: exists: &impl Fn(&str) -> bool,
    // rust: ) -> Option<String> {
    // rust: let last = value.rsplit('/').next().unwrap_or(value);
    // rust: let value = if last.ends_with(&format!(".{ext}")) {
    // rust: value.to_owned()
    // rust: } else {
    // rust: format!("{value}.{ext}")
}
    // rust: let dir = props.rsplit_once('/').map_or("", |(d, _)| d);
    // rust: let mut candidates = Vec::new();
    // rust: if value.split('/').any(|s| s == "..") {
        // Only up from the rule's folder: `~/` and `ns:` paths name their folder outright.
    // rust: if !value.starts_with("~/") && !value.contains(':') {
    // rust: candidates.extend(up_from(dir, &value));
}
    // rust: } else if value.starts_with("assets/") {
    // rust: candidates.extend(valid(&value).then(|| value.clone()));
    // rust: } else if let Some(resolved) = resolve(props, &value) {
    // rust: let plain = !value.starts_with("~/") && !value.starts_with("./");
    // rust: if plain && value.contains(['/', ':']) {
    // rust: if let Some((ns, rest)) = resolved
    // rust: .strip_prefix("assets/")
    // rust: .and_then(|p| p.split_once('/'))
    // rust: {
    // rust: if !rest.starts_with(&format!("{typed}/")) {
    // rust: candidates.push(format!("assets/{ns}/{typed}/{rest}"));
}
}
    // rust: if !value.contains(':') {
    // rust: candidates.push(format!("{dir}/{value}"));
}
}
    // rust: candidates.insert(0, resolved);
}
    // rust: candidates.into_iter().find(|p| exists(p))
}

/// `value` (`./../x`, `../x`) in the folder `dir`, each `..` taking a folder off; `None` when it
/// would climb out of `assets/<namespace>/`.
pub fn up_from(dir: []const u8, value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<&str> = dir.split('/').collect();
    // rust: for segment in value.strip_prefix("./").unwrap_or(value).split('/') {
    // rust: match segment {
    // rust: ".." if out.len() > 2 => {
    // rust: out.pop();
}
    // rust: ".." => return None,
    // rust: s => out.push(s),
}
}
    // rust: let path = out.join("/");
    // rust: (out.len() > 2 && out[0] == "assets" && valid(&path)).then_some(path)
}

/// An `enchantments` entry: an id (`flame`, `minecraft:flame`) or a pre-1.13 numeric id. An
/// unknown number stays an id no enchantment has, as in CIT Resewn, so its rule never matches.
pub fn enchantment_id(token: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if token.eq_ignore_ascii_case("sweeping") || token.eq_ignore_ascii_case("minecraft:sweeping") {
    // rust: return "minecraft:sweeping_edge".to_owned();
}
    // rust: let Ok(n) = token.parse::<u32>() else {
    // rust: return namespaced(token);
}
    // rust: let name = match n {
    // rust: 0 => "protection",
    // rust: 1 => "fire_protection",
    // rust: 2 => "feather_falling",
    // rust: 3 => "blast_protection",
    // rust: 4 => "projectile_protection",
    // rust: 5 => "respiration",
    // rust: 6 => "aqua_affinity",
    // rust: 7 => "thorns",
    // rust: 8 => "depth_strider",
    // rust: 9 => "frost_walker",
    // rust: 10 => "binding_curse",
    // rust: 16 => "sharpness",
    // rust: 17 => "smite",
    // rust: 18 => "bane_of_arthropods",
    // rust: 19 => "knockback",
    // rust: 20 => "fire_aspect",
    // rust: 21 => "looting",
    // rust: 22 => "sweeping_edge",
    // rust: 32 => "efficiency",
    // rust: 33 => "silk_touch",
    // rust: 34 => "unbreaking",
    // rust: 35 => "fortune",
    // rust: 48 => "power",
    // rust: 49 => "punch",
    // rust: 50 => "flame",
    // rust: 51 => "infinity",
    // rust: 61 => "luck_of_the_sea",
    // rust: 62 => "lure",
    // rust: 70 => "mending",
    // rust: 71 => "vanishing_curse",
    // rust: _ => return namespaced(token),
}
    // rust: format!("minecraft:{name}")
}

    // rust: mod tests {
//     use super::*;

pub fn rule(path: []const u8, text: []const u8, files: *[[]const u8]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rule::parse(path, &Properties::parse_equals_first(text), |p| {
    // rust: files.contains(&p)
    // rust: })
}

pub const SWORD: []const u8 = "assets/minecraft/optifine/cit/swords/flame.properties";

pub fn an_item_rule_with_every_condition() void {
}
    // rust: let r = rule(
    // rust: SWORD,
    // rust: "items=diamond_sword minecraft:iron_sword\ntexture=flame_sword\nweight=5\n\
    // rust: stackSize=1\ndamage=0-50%\nhand=off\nenchantmentIDs=20 sharpness\n\
    // rust: enchantmentLevels=3-\nnbt.display.Name=ipattern:*flame*\n",
    // rust: &["assets/minecraft/optifine/cit/swords/flame_sword.png"],
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(r.kind, Kind::Item);
    // rust: assert_eq!(r.items, ["minecraft:diamond_sword", "minecraft:iron_sword"]);
    // rust: assert_eq!(
    // rust: r.texture.as_deref(),
    // rust: Some("assets/minecraft/optifine/cit/swords/flame_sword.png")
    // rust: );
    // rust: assert_eq!(r.weight, 5);
    // rust: assert_eq!(r.hand, Hand::Off);
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: for (v, hand) in [
    // rust: ("Offhand", Hand::Off),
    // rust: ("main_hand", Hand::Main),
    // rust: ("*", Hand::Any),
    // rust: ] {
    // rust: let spelled = rule(SWORD, &format!("items=stick\nhand={v}"), &files).unwrap();
    // rust: assert_eq!(spelled.hand, hand, "{v}");
}
    // rust: let stack = r.stack_size.as_ref().unwrap();
    // rust: assert!(stack.contains(1) && !stack.contains(2));
    // rust: assert_eq!(
    // rust: r.enchantments,
    // rust: ["minecraft:fire_aspect", "minecraft:sharpness"]
    // rust: );
    // rust: assert!(r.enchantment_levels.as_ref().unwrap().contains(7));
    // rust: assert!(!r.enchantment_levels.as_ref().unwrap().contains(2));
        // A diamond sword lasts 1561: half of it is 780.5 used.
    // rust: let damage = r.damage.as_ref().unwrap();
    // rust: assert!(damage.matches(780, 1561));
    // rust: assert!(!damage.matches(781, 1561));
    // rust: assert!(!damage.matches(0, 0), "no max damage, no percentage");
    // rust: let [name] = &r.components[..] else { panic!() };
    // rust: assert_eq!(
    // rust: name.source,
    // rust: Source::Component("minecraft:custom_name".into())
    // rust: );
    // rust: assert!(name.path.is_empty());
    // rust: let ValueTest::Text(n) = &name.value else {
    // rust: panic!()
}
    // rust: assert!(n.matches("The FLAME Blade"));
}

pub fn damage_masks_apply_before_the_ranges() void {
}
    // rust: let r = rule(
    // rust: SWORD,
    // rust: "items=potion\ndamage=3\ndamageMask=15\n",
    // rust: &["assets/minecraft/optifine/cit/swords/flame.png"],
    // rust: )
    // rust: .unwrap();
    // rust: let d = r.damage.unwrap();
    // rust: assert!(
    // rust: d.matches(16_387, 0),
    // rust: "splash fire resistance: 16387 & 15 = 3"
    // rust: );
    // rust: assert!(!d.matches(16_388, 0));
}

pub fn default_items_and_assets_come_from_the_file_name() void {
}
    // rust: let dir = "assets/minecraft/optifine/cit/sticks";
    // rust: let path = format!("{dir}/stick.properties");
        // No texture or model named: the model beside it wins over the texture.
    // rust: let both = [&*format!("{dir}/stick.json"), &*format!("{dir}/stick.png")];
    // rust: let r = rule(&path, "nbt.CustomModelData=1\n", &both).unwrap();
    // rust: assert_eq!(r.items, ["minecraft:stick"]);
    // rust: assert_eq!(r.model.as_deref(), Some(&*format!("{dir}/stick.json")));
    // rust: assert_eq!(r.texture, None);
    // rust: let r = rule(&path, "", &both[1..]).unwrap();
    // rust: assert_eq!(r.texture.as_deref(), Some(&*format!("{dir}/stick.png")));
        // The file name is a bare id: a minecraft one even in another namespace's folder.
    // rust: let other = rule(
    // rust: "assets/mymod/optifine/cit/stick.properties",
    // rust: "",
    // rust: &["assets/mymod/optifine/cit/stick.png"],
    // rust: );
    // rust: assert_eq!(other.unwrap().items, ["minecraft:stick"]);
        // Nothing to draw: no rule.
    // rust: assert!(rule(&path, "", &[]).is_none());
}

pub fn asset_paths_try_the_typed_folders() void {
}
    // rust: let files = [
    // rust: "assets/minecraft/textures/item/excalibur.png",
    // rust: "assets/minecraft/models/item/excalibur.json",
    // rust: "assets/minecraft/optifine/cit/shared/glow.png",
    // rust: "assets/minecraft/optifine/cit/swords/sub/x.png",
    // rust: ];
    // rust: let tex = |v| rule(SWORD, &format!("items=stick\ntexture={v}"), &files)?.texture;
    // rust: let at = |s: &str| Some(s.to_owned());
    // rust: assert_eq!(tex("item/excalibur"), at(files[0]));
    // rust: assert_eq!(tex("minecraft:item/excalibur.png"), at(files[0]));
    // rust: assert_eq!(tex("textures/item/excalibur"), at(files[0]));
    // rust: assert_eq!(
    // rust: tex("assets/minecraft/textures/item/excalibur.png"),
    // rust: at(files[0])
    // rust: );
    // rust: assert_eq!(tex("~/cit/shared/glow"), at(files[2]));
    // rust: assert_eq!(tex("./sub/x"), at(files[3]));
    // rust: assert_eq!(tex("./../swords/sub/x"), at(files[3]));
    // rust: assert_eq!(tex("sub/x"), at(files[3]), "beside the rule, last");
        // `..` climbs only from the rule's folder: `~/` and `ns:` name theirs outright.
    // rust: let beside = ["assets/minecraft/optifine/cit/swords/x.png"];
    // rust: let up = |v| rule(SWORD, &format!("items=stick\ntexture={v}"), &beside);
    // rust: assert!(up("./a/../x").is_some());
    // rust: assert!(up("~/../x").is_none());
    // rust: assert!(up("minecraft:a/../x").is_none());
    // rust: let model = rule(SWORD, "items=stick\nmodel=item/excalibur", &files).unwrap();
    // rust: assert_eq!(model.model.as_deref(), Some(files[1]));
}

pub fn climbing_stops_at_the_namespace() void {
}
        // Files at every folder a climb could reach: only the namespace's own are found.
    // rust: let files = ["assets/x.png", "x.png", "assets/minecraft/x.png"];
    // rust: let tex = |v: &str| rule(SWORD, &format!("items=stick\ntexture={v}"), &files)?.texture;
    // rust: assert_eq!(tex("../../../x").as_deref(), Some("assets/minecraft/x.png"));
    // rust: assert_eq!(tex("../../../../x"), None);
    // rust: assert_eq!(tex("../../../../../x"), None);
        // A Windows `\` is refused by `paths::valid`, whose tests cover it.
}

pub fn a_named_asset_that_is_missing_drops_the_rule() void {
}
        // flame.png sits beside flame.properties, but the rule names another texture.
    // rust: let beside = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: assert!(rule(SWORD, "items=stick\ntexture=typo", &beside).is_none());
    // rust: assert!(rule(SWORD, "items=stick", &beside).is_some());
}

pub fn sub_textures_and_armor_layers() void {
}
    // rust: let dir = "assets/minecraft/optifine/cit/bow";
    // rust: let files: Vec<String> = ["a0", "a1", "diamond1", "diamond2"]
    // rust: .iter()
    // rust: .map(|n| format!("{dir}/{n}.png"))
    // rust: .collect();
    // rust: let refs: Vec<&str> = files.iter().map(String::as_str).collect();
    // rust: let r = rule(
    // rust: &format!("{dir}/bow.properties"),
    // rust: "items=bow\ntexture.bow_pulling_0=a0\ntexture.bow_pulling_1=a1\n",
    // rust: &refs,
    // rust: )
    // rust: .unwrap();
    // rust: let names: Vec<_> = r.textures.iter().map(|(n, _)| n.as_str()).collect();
    // rust: assert_eq!(names, ["bow_pulling_0", "bow_pulling_1"]);
        // One frame missing: no rule, rather than a bow that is half vanilla.
    // rust: let missing = "items=bow\ntexture.bow_pulling_0=a0\ntexture.bow_pulling_2=missing\n";
    // rust: assert!(rule(&format!("{dir}/bow.properties"), missing, &refs).is_none());
    // rust: let armor = rule(
    // rust: &format!("{dir}/armor.properties"),
    // rust: "type=armor\nitems=diamond_chestplate\ntexture.diamond_layer_1=diamond1\ntexture.diamond_layer_2=diamond2\n",
    // rust: &refs,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(armor.kind, Kind::Armor);
    // rust: assert_eq!(
    // rust: armor.textures[1],
    // rust: ("diamond_layer_2".into(), files[3].clone())
    // rust: );
    // rust: let glint = rule(
    // rust: &format!("{dir}/glint.properties"),
    // rust: "type=enchantment\ntexture=a0",
    // rust: &refs,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: glint.items.is_empty(),
    // rust: "an enchantment rule without items is for every item"
    // rust: );
        // Elytra rules are always for the elytra.
    // rust: let elytra = rule(
    // rust: &format!("{dir}/x.properties"),
    // rust: "type=elytra\nitems=stick\ntexture=a0",
    // rust: &refs,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(elytra.items, ["minecraft:elytra"]);
}

pub fn an_enchantment_rule_needs_a_texture() void {
}
    // rust: let dir = "assets/minecraft/optifine/cit/glint";
    // rust: let files = [
    // rust: format!("{dir}/shine.json"),
    // rust: format!("{dir}/shine.png"),
    // rust: format!("{dir}/other.png"),
    // rust: ];
    // rust: let refs: Vec<&str> = files.iter().map(String::as_str).collect();
    // rust: let path = format!("{dir}/shine.properties");
        // The model is there: an item rule takes it.
    // rust: assert!(rule(&path, "items=stick\nmodel=shine", &refs).is_some());
    // rust: assert!(rule(&path, "type=enchantment\nmodel=shine", &refs).is_none());
    // rust: assert!(rule(&path, "type=enchantment\ntexture.a=other", &refs).is_none());
        // The texture beside the file still counts.
    // rust: let beside = rule(&path, "type=enchantment", &refs).unwrap();
    // rust: assert_eq!(beside.texture.as_deref(), Some(&*files[1]));
}

pub fn legacy_nbt_paths_land_on_components() void {
}
    // rust: let source = |key: &str| {
    // rust: let t = ComponentTest::parse(true, key, "x").unwrap();
    // rust: let Source::Component(id) = t.source else {
    // rust: return (format!("{:?}", t.source), t.path);
}
    // rust: (id, t.path)
}
    // rust: let s = |v: &[&str]| v.iter().map(|s| (*s).to_owned()).collect::<Vec<_>>();
    // rust: assert_eq!(
    // rust: source("display.Lore.*"),
    // rust: ("minecraft:lore".into(), s(&["*"]))
    // rust: );
    // rust: assert_eq!(
    // rust: source("CustomModelData"),
    // rust: ("minecraft:custom_model_data".into(), s(&["floats", "0"]))
    // rust: );
    // rust: assert_eq!(
    // rust: source("Potion"),
    // rust: ("minecraft:potion_contents".into(), s(&["potion"]))
    // rust: );
    // rust: assert_eq!(
    // rust: source("ExtraAttributes.id"),
    // rust: (
    // rust: "minecraft:custom_data".into(),
    // rust: s(&["ExtraAttributes", "id"])
    // rust: )
    // rust: );
    // rust: let ench = ComponentTest::parse(true, "StoredEnchantments.0.id", "x").unwrap();
    // rust: assert_eq!(ench.source, Source::LegacyEnchantments { stored: true });
    // rust: assert_eq!(ench.path, s(&["0", "id"]));
        // `~` is the minecraft namespace; a bare component id is in it too.
        // Since 1.21.5 the enchantments component has no `levels` level.
    // rust: let c = ComponentTest::parse(false, "enchantments.levels.~thorns", "3").unwrap();
    // rust: assert_eq!(c.source, Source::Component("minecraft:enchantments".into()));
    // rust: assert_eq!(c.path, s(&["minecraft:thorns"]));
    // rust: let c = ComponentTest::parse(false, "custom_data.my~key.~x", "3").unwrap();
    // rust: assert_eq!(
    // rust: c.path,
    // rust: s(&["my~key", "minecraft:x"]),
    // rust: "~ only opens a segment"
    // rust: );
    // rust: let c = ComponentTest::parse(false, "custom_data.levels", "3").unwrap();
    // rust: assert_eq!(c.path, s(&["levels"]));
    // rust: assert!(ComponentTest::parse(false, "lore..0", "x").is_none());
}

pub fn component_values() void {
}
    // rust: let v = |s: &str| ValueTest::parse(s).unwrap();
    // rust: let (ValueTest::Literal(l), false) = v("#ff99cc") else {
    // rust: panic!()
}
    // rust: assert_eq!(l.int, Some(0xff99cc));
    // rust: let (ValueTest::Literal(l), false) = v("0x1F") else {
    // rust: panic!()
}
    // rust: assert_eq!(l.int, Some(31));
    // rust: let (ValueTest::Literal(l), false) = v("1.5") else {
    // rust: panic!()
}
    // rust: assert_eq!((l.int, l.float), (None, Some(1.5)));
    // rust: let (ValueTest::Literal(l), false) = v("53") else {
    // rust: panic!()
}
    // rust: assert_eq!((l.int, l.float), (Some(53), Some(53.0)));
    // rust: let (ValueTest::Literal(l), true) = v("!Bob") else {
    // rust: panic!()
}
    // rust: assert_eq!((l.text.as_str(), l.int), ("Bob", None));
    // rust: let (ValueTest::Range(r), false) = v("range:(-25) (-10)-10 15") else {
    // rust: panic!()
}
    // rust: assert!(r.contains(-25) && r.contains(0) && !r.contains(11));
    // rust: assert!(matches!(
    // rust: v("exists:false"),
    // rust: (ValueTest::Exists(false), false)
    // rust: ));
    // rust: let (ValueTest::Raw(n), false) = v("raw:pattern:*Chopper*") else {
    // rust: panic!()
}
    // rust: assert!(n.matches("{text:\"Chopper\"}"));
    // rust: assert!(ValueTest::parse("regex:(").is_none());
    // rust: assert!(ValueTest::parse("exists:maybe").is_none());
}

pub fn unknown_enchantment_ids_never_match_instead_of_matching_all() void {
}
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: let r = rule(SWORD, "items=stick\nenchantmentIDs=99 sweeping", &files).unwrap();
    // rust: assert_eq!(r.enchantments, ["minecraft:99", "minecraft:sweeping_edge"]);
}

pub fn resewn_key_spellings() void {
}
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: let text = "items=arrow\namount=64\ncitWeight=5\ndamage=3\ndamage_mask=15\n\
    // rust: enchantment_levels=2\ncomponents.minecraft:custom_name=Quiver\n";
    // rust: let r = rule(SWORD, text, &files).unwrap();
    // rust: assert!(r.stack_size.unwrap().contains(64));
    // rust: assert_eq!(r.weight, 5);
    // rust: assert_eq!(r.damage.unwrap().mask, Some(15));
    // rust: assert!(r.enchantment_levels.unwrap().contains(2));
    // rust: let [name] = &r.components[..] else { panic!() };
    // rust: assert_eq!(
    // rust: name.source,
    // rust: Source::Component("minecraft:custom_name".into())
    // rust: );
}

pub fn tags_that_became_components_are_read_there_or_drop_the_rule() void {
}
    // rust: let at = |key: &str| {
    // rust: let t = ComponentTest::parse(true, key, "x")?;
    // rust: let Source::Component(id) = t.source else {
    // rust: return None;
}
    // rust: Some((id, t.path.join(".")))
}
    // rust: let is = |id: &str, path: &str| Some((format!("minecraft:{id}"), path.to_owned()));
    // rust: assert_eq!(at("SkullOwner"), is("profile", "name"));
    // rust: assert_eq!(at("SkullOwner.Name"), is("profile", "name"));
    // rust: assert_eq!(at("generation"), is("written_book_content", "generation"));
    // rust: assert_eq!(at("EntityTag.CustomName"), is("entity_data", "CustomName"));
    // rust: assert_eq!(at("Fireworks.Flight"), is("fireworks", "flight_duration"));
        // Moved to a component of another shape: no test, and so no rule.
    // rust: assert_eq!(at("AttributeModifiers.0.Amount"), None);
    // rust: assert_eq!(at("HideFlags"), None);
    // rust: assert_eq!(at("SkullOwner.Properties.textures.0.Value"), None);
    // rust: assert_eq!(at("BlockEntityTag.Patterns.0.Pattern"), None);
    // rust: assert_eq!(at("display.MapColor"), None);
    // rust: assert_eq!(
    // rust: at("BlockEntityTag.CustomName"),
    // rust: is("block_entity_data", "CustomName")
    // rust: );
    // rust: assert_eq!(at("instrument"), is("instrument", ""));
    // rust: assert_eq!(
    // rust: at("DebugProperty.minecraft:stone"),
    // rust: is("debug_stick_state", "minecraft:stone")
    // rust: );
    // rust: assert_eq!(at("EntityTag.variant"), is("painting/variant", ""));
    // rust: assert_eq!(at("display.LocName"), None);
        // Bucket mobs' tags went into `bucket_entity_data`, and `Variant` became a name.
    // rust: assert_eq!(at("Variant"), None);
        // What the fixer left in `display` stayed in custom data.
    // rust: assert_eq!(at("display.Foo"), is("custom_data", "display.Foo"));
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: assert!(rule(SWORD, "items=stick\nnbt.Unbreakable=!1", &files).is_none());
}

pub fn malformed_conditions_drop_the_rule() void {
}
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: for bad in [
    // rust: "damage=lots",
    // rust: "damage=3\ndamageMask=abc",
    // rust: "stackSize=1-x",
    // rust: "hand=left",
    // rust: "texture=flame\nmodel=typo",
    // rust: "weight=heavy",
    // rust: "type=hat",
    // rust: "nbt.display.Name=regex:(",
    // rust: ] {
    // rust: assert!(
    // rust: rule(SWORD, &format!("items=stick\n{bad}\n"), &files).is_none(),
    // rust: "{bad}"
    // rust: );
}
}

pub fn heavier_rules_then_earlier_paths_win() void {
}
    // rust: let files = ["assets/minecraft/optifine/cit/a.png"];
    // rust: let at = |path: &str, weight: i32| {
    // rust: rule(
    // rust: path,
    // rust: &format!("items=stick\ntexture=~/cit/a\nweight={weight}"),
    // rust: &files,
    // rust: )
    // rust: .unwrap()
}
    // rust: let a = at("assets/minecraft/optifine/cit/a.properties", 0);
    // rust: let b = at("assets/minecraft/optifine/cit/b.properties", 0);
    // rust: let heavy = at("assets/minecraft/optifine/cit/c.properties", 3);
    // rust: let mut rules = [b, heavy, a];
    // rust: rules.sort_by(Rule::priority);
    // rust: let order: Vec<_> = rules
    // rust: .iter()
    // rust: .map(|r| r.path.rsplit('/').next().unwrap())
    // rust: .collect();
    // rust: assert_eq!(order, ["c.properties", "a.properties", "b.properties"]);
}

pub fn enchantment_layers() void {
}
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: let r = rule(
    // rust: SWORD,
    // rust: "type=enchantment\ntexture=flame\nlayer=2\nblend=GL_DST_COLOR GL_ONE_MINUS_SRC_ALPHA\n\
    // rust: speed=0.5\nrotation=45\nduration=2\nr=0.5\ng=-1\n",
    // rust: &files,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(r.glint.layer, 2);
    // rust: assert_eq!(r.glint.blend, parse_blend("multiply").unwrap());
    // rust: assert_eq!(
    // rust: (r.glint.speed, r.glint.rotation, r.glint.duration),
    // rust: (0.5, 45.0, 2.0)
    // rust: );
    // rust: assert_eq!(
    // rust: r.glint.rgba,
    // rust: [0.5, 0.0, 1.0, 1.0],
    // rust: "colours never go below 0"
    // rust: );
    // rust: assert_eq!(parse_blend("replace"), Some(None));
    // rust: let custom = parse_blend("0x306 771 0 1").unwrap().unwrap();
    // rust: assert_eq!(Some(Some(custom)), parse_blend("multiply"));
    // rust: assert_eq!(parse_blend("GL_NOPE GL_ONE"), None);
        // OptiFine's defaults: still, unturned, a second per cycle, added on top.
    // rust: let plain = rule(SWORD, "type=enchantment\ntexture=flame", &files).unwrap();
    // rust: assert_eq!(
    // rust: (plain.glint.layer, plain.glint.speed, plain.glint.rotation),
    // rust: (0, 0.0, 0.0)
    // rust: );
    // rust: assert_eq!(plain.glint.duration, 1.0);
    // rust: assert_eq!(
    // rust: plain.glint.blend,
    // rust: parse_blend("GL_SRC_ALPHA GL_ONE").unwrap()
    // rust: );
    // rust: assert!(!plain.glint.use_glint && plain.glint.blur);
    // rust: assert!(rule(SWORD, "type=enchantment\ntexture=flame\nspeed=fast", &files).is_none());
    // rust: assert!(rule(SWORD, "type=enchantment\ntexture=flame\nblend=mix", &files).is_none());
        // NaN and the infinities are malformed too.
    // rust: for bad in ["speed=NaN", "r=inf", "duration=-Infinity", "a=nan"] {
    // rust: let text = format!("type=enchantment\ntexture=flame\n{bad}");
    // rust: assert!(rule(SWORD, &text, &files).is_none(), "{bad}");
}
}

pub fn glint_keys_are_only_an_enchantment_rules() void {
}
    // rust: let files = ["assets/minecraft/optifine/cit/swords/flame.png"];
    // rust: let r = rule(
    // rust: SWORD,
    // rust: "items=diamond_sword\ntexture=flame\nblend=nonsense\nspeed=fast\nr=nan",
    // rust: &files,
    // rust: )
    // rust: .expect("an item rule ignores the glint keys");
    // rust: assert_eq!(r.glint, Glint::default());
}

pub fn named_blends() void {
}
//         use Factor::*;
    // rust: let pair = |src, dst| Blend {
    // rust: src,
    // rust: dst,
    // rust: src_alpha: Zero,
    // rust: dst_alpha: One,
}
        // CIT Resewn's doc's table.
    // rust: let table = [
    // rust: ("glint", pair(SrcColor, One)),
    // rust: ("alpha", pair(SrcAlpha, OneMinusSrcAlpha)),
    // rust: ("add", pair(SrcAlpha, One)),
    // rust: ("subtract", pair(OneMinusDstColor, Zero)),
    // rust: ("multiply", pair(DstColor, OneMinusSrcAlpha)),
    // rust: ("dodge", pair(One, One)),
    // rust: ("burn", pair(Zero, OneMinusSrcColor)),
    // rust: ("screen", pair(One, OneMinusSrcColor)),
    // rust: ("overlay", pair(DstColor, SrcColor)),
    // rust: ];
    // rust: for (name, blend) in table {
    // rust: assert_eq!(parse_blend(name), Some(Some(blend)), "{name}");
}
    // rust: assert_eq!(parse_blend("replace"), Some(None));
        // Names are case-blind (CIT Resewn upper-cases them); GL constants are not (it looks
        // them up as GL11's field names).
    // rust: assert_eq!(parse_blend("Multiply"), parse_blend("multiply"));
    // rust: assert_eq!(parse_blend("gl_one GL_ONE"), None);
}

pub fn global_properties() void {
}
    // rust: let g = Global::parse(&Properties::parse(
    // rust: "method=cycle\ncap=2\nfade=1.5\nuseGlint=false",
    // rust: ));
    // rust: assert_eq!(
    // rust: g,
    // rust: Global {
    // rust: method: Method::Cycle,
    // rust: cap: Some(2),
    // rust: fade: 1.5,
    // rust: use_glint: false
}
    // rust: );
    // rust: assert_eq!(
    // rust: Global::parse(&Properties::parse("method=odd\ncap=x\nfade=-1")),
    // rust: Global {
    // rust: fade: 0.0,
    // rust: ..Global::default()
}
    // rust: );
    // rust: assert_eq!(
    // rust: Global::parse(&Properties::parse("method=Layered\nuseGlint=FALSE")).method,
    // rust: Method::Layered
    // rust: );
    // rust: assert!(!Global::parse(&Properties::parse("useGlint=FALSE")).use_glint);
    // rust: assert_eq!(
    // rust: Global::parse(&Properties::parse("method=NONE")).method,
    // rust: Method::None
    // rust: );
    // rust: for fade in ["nan", "INF", "-infinity"] {
    // rust: let g = Global::parse(&Properties::parse(&format!("fade={fade}")));
    // rust: assert_eq!(g.fade, 0.5, "{fade}");
}
}
}
