//! Transpiled from Horizon Rust crate
package horizon_port_pack_classes

import "core:fmt"
import "core:mem"
import "core:math"

// What a mod's Java code does, read from its class files without running
// or decompiling them: each class's superclass, interfaces, declared
// methods and the classes and annotations its constant pool names. The
// mod's own classes are followed up to the first game class they extend,
// and that class says what the code is: a block entity, a menu, an entity,
// a block or item with behaviour of its own, a worldgen feature...
//
// Since 26.1 the game ships unobfuscated, and NeoForge has run on Mojang's
// names since 1.20.5, so game classes and methods are read by name. Fabric
// jars before 26.1 name them in intermediary (`net/minecraft/class_2248`)
// and Forge's methods are SRG (`m_60503_`): a class extending such a game
// class is counted as code of its own, whatever it overrides.
// use serde::{Deserialize, Serialize};
// use std::collections::{BTreeMap, BTreeSet, HashMap};

// One class file, as much as this module reads.
Class :: struct {
    name: string,
    superclass: string,
    interfaces: [dynamic]string,
    // Declared methods, by name (constructors and lambdas left out).
    methods: [dynamic]string,
    // Every class the constant pool names (`net/minecraft/...`).
    refs: BTreeSet<string>,
    // Annotation and descriptor strings (`Lorg/spongepowered/asm/mixin/Mixin;`).
    mixin: bool,
}

// Reads a class file's header, constant pool and declared methods.
parse :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader { bytes, at: 0 };
    // rust: if r.u4()? != 0xCAFE_BABE {
    // rust: return None;
}
    // rust: r.skip(4)?; // minor, major
    // rust: let count = r.u2()? as usize;
    // rust: let mut utf8: HashMap<usize, String> = HashMap::new();
    // rust: let mut class_of: HashMap<usize, usize> = HashMap::new();
    // rust: let mut i = 1;
    // rust: while i < count {
    // rust: let tag = r.u1()?;
    // rust: match tag {
    // rust: 1 => {
    // rust: let len = r.u2()? as usize;
    // rust: let s = r.take(len)?;
    // rust: utf8.insert(i, String::from_utf8_lossy(s).into_owned());
}
    // rust: 7 => {
    // rust: class_of.insert(i, r.u2()? as usize);
}
    // rust: 8 | 16 | 19 | 20 => r.skip(2)?,
    // rust: 3 | 4 | 9..=12 | 17 | 18 => r.skip(4)?,
    // rust: 15 => r.skip(3)?,
    // rust: 5 | 6 => {
    // rust: r.skip(8)?;
    // rust: i += 1;
}
    // rust: _ => return None,
}
    // rust: i += 1;
}
    // rust: let class_name = |idx: usize| -> String {
    // rust: class_of
    // rust: .get(&idx)
    // rust: .and_then(|u| utf8.get(u))
    // rust: .cloned()
    // rust: .unwrap_or_default()
}
    // rust: r.skip(2)?; // access flags
    // rust: let name = class_name(r.u2()? as usize);
    // rust: let superclass = class_name(r.u2()? as usize);
    // rust: let n = r.u2()? as usize;
    // rust: let mut interfaces = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: interfaces.push(class_name(r.u2()? as usize));
}
    // Fields, then methods: flags, name, descriptor, attributes.
    // rust: let mut methods = Vec::new();
    // rust: for member in 0..2 {
    // rust: let n = r.u2()?;
    // rust: for _ in 0..n {
    // rust: r.skip(2)?;
    // rust: let name = r.u2()? as usize;
    // rust: r.skip(2)?;
    // rust: let attributes = r.u2()?;
    // rust: for _ in 0..attributes {
    // rust: r.skip(2)?;
    // rust: let len = r.u4()? as usize;
    // rust: r.skip(len)?;
}
    // rust: if member == 1
    // rust: && let Some(m) = utf8.get(&name)
    // rust: && !m.starts_with('<')
    // rust: && !m.starts_with("lambda$")
    // rust: {
    // rust: methods.push(m.clone());
}
}
}
    // rust: let refs = class_of
    // rust: .values()
    // rust: .filter_map(|u| utf8.get(u))
    // rust: .filter(|s| !s.starts_with('['))
    // rust: .cloned()
    // rust: .collect();
    // rust: let mixin = utf8
    // rust: .values()
    // rust: .any(|s| s == "Lorg/spongepowered/asm/mixin/Mixin;");
    // rust: Some(Class {
    // rust: name,
    // rust: superclass,
    // rust: interfaces,
    // rust: methods,
    // rust: refs,
    // rust: mixin,
    // rust: })
}

Reader :: struct {
    bytes: ^'a [u8],
    at: uint,
}

    // rust: impl<'a> Reader<'a> {
take :: proc(self: ^Self, n: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = self.bytes.get(self.at..self.at.checked_add(n)?)?;
    // rust: self.at += n;
    // rust: Some(s)
}
skip :: proc(self: ^Self, n: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.take(n).map(drop)
}
u1 :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.take(1)?[0])
}
u2 :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.take(2)?;
    // rust: Some(u16::from_be_bytes([b[0], b[1]]))
}
u4 :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.take(4)?;
    // rust: Some(u32::from_be_bytes([b[0], b[1], b[2], b[3]]))
}
}

// What a class does, as the port sees it.
Feature :: enum {
    // A block with behaviour of its own (use, ticks, collisions...).
    BlockBehaviour,
    // A block with a shape of its own: it ports with its template's.
    BlockShape,
    // An item with behaviour of its own (use, on hit...).
    ItemBehaviour,
    BlockEntity,
    Menu,
    Entity,
    Screen,
    Renderer,
    // A worldgen feature, placement or structure type written in Java.
    Worldgen,
    // A recipe type (its recipes don't craft) or ingredient type.
    Recipe,
    Effect,
    Enchantment,
    Particle,
    Command,
    Network,
    // Reacts to game events (NeoForge's bus, Fabric's callbacks).
    Events,
    // A Mixin: a patch to the game's own code.
    Mixin,
    // Extends a game class under obfuscated names (Fabric before 26.1,
    // Forge's methods): what it does can't be read.
    Unread,
}

    // rust: impl Feature {
    // How the coverage line names `n` of them.
describe :: proc(self: ^Self, n: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (one, many) = match self {
    // rust: Feature::BlockBehaviour => (
    // rust: "block with behaviour of its own (use, ticks, collisions)",
    // rust: "blocks with behaviour of their own (use, ticks, collisions)",
    // rust: ),
    // rust: Feature::BlockShape => (
    // rust: "block with a shape of its own: it ports with its template's",
    // rust: "blocks with shapes of their own: they port with their templates'",
    // rust: ),
    // rust: Feature::ItemBehaviour => (
    // rust: "item with behaviour of its own (use, on hit)",
    // rust: "items with behaviour of their own (use, on hit)",
    // rust: ),
    // rust: Feature::BlockEntity => (
    // rust: "block entity (machine, container or animated block)",
    // rust: "block entities (machines, containers, animated blocks)",
    // rust: ),
    // rust: Feature::Menu => ("menu (a container screen)", "menus (container screens)"),
    // rust: Feature::Entity => ("mob or entity", "mobs or entities"),
    // rust: Feature::Screen => ("screen of its own", "screens of its own"),
    // rust: Feature::Renderer => ("renderer or model in code", "renderers or models in code"),
    // rust: Feature::Worldgen => (
    // rust: "worldgen feature or structure type in code",
    // rust: "worldgen features or structure types in code",
    // rust: ),
    // rust: Feature::Recipe => (
    // rust: "recipe type of its own (its recipes don't craft)",
    // rust: "recipe types of its own (their recipes don't craft)",
    // rust: ),
    // rust: Feature::Effect => ("status effect", "status effects"),
    // rust: Feature::Enchantment => ("enchantment effect in code", "enchantment effects in code"),
    // rust: Feature::Particle => ("particle type", "particle types"),
    // rust: Feature::Command => ("command", "commands"),
    // rust: Feature::Network => ("network message", "network messages"),
    // rust: Feature::Events => ("game event it reacts to", "game events it reacts to"),
    // rust: Feature::Mixin => (
    // rust: "Mixin (a patch to the game's code)",
    // rust: "Mixins (patches to the game's code)",
    // rust: ),
    // rust: Feature::Unread => (
    // rust: "class extending the game under obfuscated names",
    // rust: "classes extending the game under obfuscated names",
    // rust: ),
}
    // rust: format!("{n} {}", if n == 1 { one } else { many })
}
}

// Block methods that only say how it looks or is placed: the template's
// do the same for the states a blockstate file lists.
    // rust: const BLOCK_LOOKS: [&str; 18] = [
    // rust: "codec",
    // rust: "createBlockStateDefinition",
    // rust: "getStateForPlacement",
    // rust: "rotate",
    // rust: "mirror",
    // rust: "getRenderShape",
    // rust: "skipRendering",
    // rust: "getShadeBrightness",
    // rust: "propagatesSkylightDown",
    // rust: "getCloneItemStack",
    // rust: "isPathfindable",
    // rust: "getFluidState",
    // rust: "updateShape",
    // rust: "canBeReplaced",
    // rust: "getLightBlock",
    // rust: "useShapeForLightOcclusion",
    // rust: "getDescriptionId",
    // rust: "animateTick",
    // rust: ];
// Block methods that only change its outline or collision.
    // rust: const BLOCK_SHAPES: [&str; 6] = [
    // rust: "getShape",
    // rust: "getCollisionShape",
    // rust: "getVisualShape",
    // rust: "getOcclusionShape",
    // rust: "getInteractionShape",
    // rust: "getBlockSupportShape",
    // rust: ];
// Item methods that only say how it looks or is named.
    // rust: const ITEM_LOOKS: [&str; 6] = [
    // rust: "appendHoverText",
    // rust: "getName",
    // rust: "isFoil",
    // rust: "getDescriptionId",
    // rust: "getBarColor",
    // rust: "getBarWidth",
    // rust: ];

// The game's own, loader and library classes: the first of these a mod's
// class chain reaches is what it extends.
external :: proc(name: string, own: ^BTreeMap<string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !own.contains_key(name)
}

obfuscated_method :: proc(m: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let digits = |s: &str| !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit());
    // rust: m.strip_prefix("method_").is_some_and(digits)
    // rust: || m.strip_prefix("m_")
    // rust: .and_then(|s| s.strip_suffix('_'))
    // rust: .is_some_and(digits)
}

// What a game class (Mojang's names) is, by its package and name.
kind_of_game_class :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rest = name.strip_prefix("net/minecraft/")?;
    // rust: if rest.starts_with("class_") {
    // rust: return Some(Feature::Unread);
}
    // rust: let (package, simple) = rest.rsplit_once('/').unwrap_or(("", rest));
    // rust: Some(match package {
    // rust: "world/level/block/entity" => Feature::BlockEntity,
    // rust: p if p.starts_with("world/level/block") => Feature::BlockBehaviour,
    // rust: "world/inventory" if simple.ends_with("Menu") => Feature::Menu,
    // rust: p if p.starts_with("world/entity") => Feature::Entity,
    // rust: p if p.starts_with("world/item/crafting") => Feature::Recipe,
    // rust: p if p.starts_with("world/item/enchantment") => Feature::Enchantment,
    // rust: p if p.starts_with("world/item") => Feature::ItemBehaviour,
    // rust: p if p.starts_with("world/level/levelgen") => Feature::Worldgen,
    // rust: "world/effect" => Feature::Effect,
    // rust: p if p.starts_with("client/gui/screens") || p.starts_with("client/gui/components") => {
    // rust: Feature::Screen
}
    // rust: p if p.starts_with("client/renderer") || p.starts_with("client/model") => Feature::Renderer,
    // rust: p if p.starts_with("client/particle") || p.starts_with("core/particles") => {
    // rust: Feature::Particle
}
    // rust: _ => return None,
    // rust: })
}

// Events a content mod uses to register what it has: not behaviour.
registration_event :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: "BuildCreativeModeTabContentsEvent",
    // rust: "RegisterEvent",
    // rust: "Register",
    // rust: "Lifecycle",
    // rust: "ModConfigEvent",
    // rust: "AddPackFindersEvent",
    // rust: "ItemGroupEvents",
    // rust: "ClientLifecycleEvents",
    // rust: "ServerLifecycleEvents",
    // rust: ]
    // rust: .iter()
    // rust: .any(|k| name.rsplit('/').next().unwrap_or(name).contains(k))
    // rust: || name.contains("/lifecycle/")
    // rust: || name.contains("/registries/")
    // rust: || name.contains("/registry/")
}

// The code census: how many of each feature, and examples.
Code :: struct {
    classes: uint,
    features: BTreeMap<Feature,
    // The game events it subscribes to, by simple name.
    events: BTreeSet<string>,
    // Blocks and items with behaviour, and the methods they override.
    examples: BTreeMap<string,
}

    // rust: impl Code {
    // Whether it does anything beyond registering blocks and items.
behaviour :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.features
    // rust: .keys()
    // rust: .any(|f| *f != Feature::BlockShape && *f != Feature::Particle)
}
}

// Reads every class of a jar. `classes` are the class files' bytes.
    // rust: pub fn census<'a>(classes: impl IntoIterator<Item = &'a [u8]>) -> Code {
    // rust: let own: BTreeMap<String, Class> = classes
    // rust: .into_iter()
    // rust: .filter_map(parse)
    // rust: .map(|c| (c.name.clone(), c))
    // rust: .collect();
    // rust: let mut code = Code {
    // rust: classes: own.len(),
    // rust: ..Code::default()
}
    // rust: let mut count = |f: Feature| *code.features.entry(f).or_default() += 1;
    // rust: for c in own.values() {
    // rust: if c.mixin {
    // rust: count(Feature::Mixin);
    // rust: continue;
}
        // The first class outside the jar the chain reaches, and the
        // methods declared along the way.
    // rust: let mut methods: BTreeSet<&str> = c.methods.iter().map(String::as_str).collect();
    // rust: let mut at = c;
    // rust: let mut seen = 0;
    // rust: while !external(&at.superclass, &own) && seen < 64 {
    // rust: at = &own[&at.superclass];
    // rust: methods.extend(at.methods.iter().map(String::as_str));
    // rust: seen += 1;
}
    // rust: let base = at.superclass.as_str();
    // rust: let kind = kind_of_game_class(base).or_else(|| {
    // rust: c.interfaces.iter().find_map(|i| match i.as_str() {
    // rust: "net/minecraft/network/protocol/common/custom/CustomPacketPayload" => {
    // rust: Some(Feature::Network)
}
    // rust: "net/minecraft/world/MenuProvider" => Some(Feature::Menu),
    // rust: _ => None,
    // rust: })
    // rust: });
    // rust: let Some(kind) = kind else {
    // rust: continue;
}
    // rust: let feature = match kind {
    // rust: Feature::BlockBehaviour => {
    // rust: let behaviour: Vec<&str> = methods
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|m| !BLOCK_LOOKS.contains(m) && !BLOCK_SHAPES.contains(m))
    // rust: .collect();
    // rust: if !behaviour.is_empty() {
    // rust: code.examples.insert(
    // rust: c.name.rsplit('/').next().unwrap_or("").to_owned(),
    // rust: behaviour.iter().map(|m| m.to_string()).collect(),
    // rust: );
    // rust: if behaviour.iter().any(|m| obfuscated_method(m)) {
    // rust: Some(Feature::Unread)
    // rust: } else {
    // rust: Some(Feature::BlockBehaviour)
}
    // rust: } else if methods.iter().any(|m| BLOCK_SHAPES.contains(m)) {
    // rust: Some(Feature::BlockShape)
    // rust: } else {
    // rust: None
}
}
    // rust: Feature::ItemBehaviour => {
    // rust: let behaviour: Vec<&str> = methods
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|m| !ITEM_LOOKS.contains(m))
    // rust: .collect();
    // rust: if behaviour.is_empty() {
    // rust: None
    // rust: } else {
    // rust: code.examples.insert(
    // rust: c.name.rsplit('/').next().unwrap_or("").to_owned(),
    // rust: behaviour.iter().map(|m| m.to_string()).collect(),
    // rust: );
    // rust: Some(Feature::ItemBehaviour)
}
}
            // A class extending an obfuscated game class without declaring
            // anything adds nothing to read.
    // rust: Feature::Unread if methods.is_empty() => None,
    // rust: k => Some(k),
}
    // rust: if let Some(f) = feature {
    // rust: count(f);
}
}
    // rust: for c in own.values() {
    // rust: for r in &c.refs {
    // rust: let event = (r.starts_with("net/neoforged/neoforge/event/")
    // rust: || r.starts_with("net/minecraftforge/event/")
    // rust: || r.starts_with("net/fabricmc/fabric/api/event/")
    // rust: || r.starts_with("net/fabricmc/fabric/api/entity/event/"))
    // rust: && !registration_event(r);
    // rust: if event {
    // rust: let simple = r.rsplit('/').next().unwrap_or(r);
    // rust: code.events
    // rust: .insert(simple.split('$').next().unwrap_or(simple).to_owned());
}
    // rust: if r.starts_with("com/mojang/brigadier/")
    // rust: && !code.features.contains_key(&Feature::Command)
    // rust: {
    // rust: code.features.insert(Feature::Command, 1);
}
}
}
    // rust: if !code.events.is_empty() {
    // rust: code.features.insert(Feature::Events, code.events.len());
}
    // rust: code
}

    // rust: pub(crate) mod tests_support {
    // A class file with `name` extending `superclass`, declaring `methods`
    // and naming `refs` in its constant pool.
    // rust: pub fn class_with(
    // rust: name: &str,
    // rust: superclass: &str,
    // rust: methods: &[&str],
    // rust: refs: &[&str],
    // rust: mixin: bool,
    // rust: ) -> Vec<u8> {
    // rust: let mut pool: Vec<Vec<u8>> = Vec::new();
    // rust: let utf = |pool: &mut Vec<Vec<u8>>, s: &str| -> u16 {
    // rust: let mut e = vec![1];
    // rust: e.extend((s.len() as u16).to_be_bytes());
    // rust: e.extend(s.as_bytes());
    // rust: pool.push(e);
    // rust: pool.len() as u16
}
    // rust: let class = |pool: &mut Vec<Vec<u8>>, s: &str| -> u16 {
    // rust: let u = utf(pool, s);
    // rust: let mut e = vec![7];
    // rust: e.extend(u.to_be_bytes());
    // rust: pool.push(e);
    // rust: pool.len() as u16
}
    // rust: let this = class(&mut pool, name);
    // rust: let sup = class(&mut pool, superclass);
    // rust: for r in refs {
    // rust: class(&mut pool, r);
}
        // A long takes two slots.
    // rust: pool.push(vec![5, 0, 0, 0, 0, 0, 0, 0, 1]);
    // rust: pool.push(Vec::new());
    // rust: if mixin {
    // rust: utf(&mut pool, "Lorg/spongepowered/asm/mixin/Mixin;");
}
    // rust: let desc = utf(&mut pool, "()V");
    // rust: let names: Vec<u16> = methods.iter().map(|m| utf(&mut pool, m)).collect();
    // rust: let mut out = vec![0xCA, 0xFE, 0xBA, 0xBE, 0, 0, 0, 65];
    // rust: out.extend(((pool.len() + 1) as u16).to_be_bytes());
    // rust: for e in &pool {
    // rust: out.extend(e);
}
    // rust: out.extend([0, 0x21]);
    // rust: out.extend(this.to_be_bytes());
    // rust: out.extend(sup.to_be_bytes());
    // rust: out.extend([0, 0]); // interfaces
    // rust: out.extend([0, 0]); // fields
    // rust: out.extend((names.len() as u16).to_be_bytes());
    // rust: for n in names {
    // rust: out.extend([0, 1]);
    // rust: out.extend(n.to_be_bytes());
    // rust: out.extend(desc.to_be_bytes());
            // One attribute, to be skipped.
    // rust: out.extend([0, 1, 0, 1, 0, 0, 0, 2, 0, 0]);
}
    // rust: out.extend([0, 0]); // class attributes
    // rust: out
}

    // A class extending `superclass` and declaring nothing.
class_file :: proc(name: string, superclass: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: class_with(name, superclass, &[], &[], false)
}
}

    // rust: mod tests {
//     use super::tests_support::class_with as class_file;
//     use super::*;

reads_the_header_methods_and_pool :: proc() {
}
    // rust: let bytes = class_file(
    // rust: "a/Lamp",
    // rust: "net/minecraft/world/level/block/Block",
    // rust: &["<init>", "useWithoutItem", "lambda$x$0"],
    // rust: &["net/minecraft/world/item/Item"],
    // rust: false,
    // rust: );
    // rust: let c = parse(&bytes).unwrap();
    // rust: assert_eq!(c.name, "a/Lamp");
    // rust: assert_eq!(c.superclass, "net/minecraft/world/level/block/Block");
    // rust: assert_eq!(c.methods, ["useWithoutItem"]);
    // rust: assert!(c.refs.contains("net/minecraft/world/item/Item"));
    // rust: assert!(!c.mixin);
    // rust: assert!(parse(&bytes[..bytes.len() - 3]).is_none());
    // rust: assert!(parse(b"not a class").is_none());
}

follows_own_classes_to_the_game :: proc() {
}
    // rust: let block = "net/minecraft/world/level/block/Block";
    // rust: let files = [
            // Looks only: a template covers it.
    // rust: class_file("m/Plain", block, &["getStateForPlacement"], &[], false),
    // rust: class_file("m/Round", block, &["getShape"], &[], false),
            // Behaviour two levels down.
    // rust: class_file("m/Base", block, &["randomTick"], &[], false),
    // rust: class_file("m/Lamp", "m/Base", &[], &[], false),
    // rust: class_file(
    // rust: "m/Tile",
    // rust: "net/minecraft/world/level/block/entity/BlockEntity",
    // rust: &[],
    // rust: &[],
    // rust: false,
    // rust: ),
    // rust: class_file("m/Mix", "java/lang/Object", &[], &[], true),
    // rust: class_file(
    // rust: "m/Old",
    // rust: "net/minecraft/class_2248",
    // rust: &["method_9534"],
    // rust: &[],
    // rust: false,
    // rust: ),
    // rust: class_file(
    // rust: "m/Events",
    // rust: "java/lang/Object",
    // rust: &[],
    // rust: &[
    // rust: "net/neoforged/neoforge/event/entity/player/PlayerInteractEvent$RightClickBlock",
    // rust: "net/neoforged/neoforge/event/BuildCreativeModeTabContentsEvent",
    // rust: "net/neoforged/neoforge/registries/DeferredRegister",
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: class_file(
    // rust: "m/Gem",
    // rust: "net/minecraft/world/item/Item",
    // rust: &["appendHoverText"],
    // rust: &[],
    // rust: false,
    // rust: ),
    // rust: ];
    // rust: let code = census(files.iter().map(Vec::as_slice));
    // rust: assert_eq!(code.classes, 9);
    // rust: let n = |f| code.features.get(&f).copied().unwrap_or(0);
    // rust: assert_eq!(n(Feature::BlockBehaviour), 2, "{code:?}");
    // rust: assert_eq!(n(Feature::BlockShape), 1);
    // rust: assert_eq!(n(Feature::BlockEntity), 1);
    // rust: assert_eq!(n(Feature::Mixin), 1);
    // rust: assert_eq!(n(Feature::Unread), 1);
    // rust: assert_eq!(n(Feature::ItemBehaviour), 0);
    // rust: assert_eq!(
    // rust: code.events.iter().collect::<Vec<_>>(),
    // rust: ["PlayerInteractEvent"]
    // rust: );
    // rust: assert!(code.behaviour());
}

registration_only_is_not_behaviour :: proc() {
}
    // rust: let files = [
    // rust: class_file(
    // rust: "m/Mod",
    // rust: "java/lang/Object",
    // rust: &["register"],
    // rust: &[
    // rust: "net/neoforged/neoforge/registries/DeferredRegister",
    // rust: "net/minecraft/world/level/block/Block",
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: class_file(
    // rust: "m/Pillar",
    // rust: "net/minecraft/world/level/block/RotatedPillarBlock",
    // rust: &[],
    // rust: &[],
    // rust: false,
    // rust: ),
    // rust: ];
    // rust: let code = census(files.iter().map(Vec::as_slice));
    // rust: assert!(!code.behaviour(), "{code:?}");
}
}
