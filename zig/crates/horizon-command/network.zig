//! Transpiled from Horizon Rust crate
//! Module: horizon-command_network
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The command tree a server sends (ClientboundCommandsPacket) as a
//! dispatcher the chat parses, colours and completes with
//! (ClientPacketListener.handleCommands).
//!
//! The packet holds each argument's parser and its network properties. A
//! node the client's own vanilla tree has at the same path takes that node's
//! argument type and suggestion provider (the parsers' suggestion lists and
//! the custom providers are the same code on both sides); any other node
//! (another server's or a mod's) gets the type its parser and properties
//! describe.
// use super::{ArgType, Dispatcher, Node, NodeKind, Suggests};
// use horizon_protocol::packets::play::{ARGUMENT_TYPES, ArgumentProperties, Commands};
// use std::{
    // rust: collections::{HashSet, VecDeque},
    // rust: sync::{Mutex, OnceLock},
}

/// The command id of every executable node of a server's tree: the chat
/// sends the command, the server runs it.
pub const SERVER_COMMAND: []const u8 = "server";

/// The dispatcher for a server's tree. `local` is the client's own tree
/// (vanilla's), whose matching nodes lend their types and providers.
pub fn from_packet(packet: *Commands, local: *Dispatcher) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = packet.nodes.len();
    // rust: let root = usize::try_from(packet.root)
    // rust: .ok()
    // rust: .filter(|&r| r < count)
    // rust: .unwrap_or(0);
    // The packet's root becomes node 0, the others follow in packet order.
    // rust: let index = |i: usize| -> usize {
    // rust: if i == root {
    // rust: 0
    // rust: } else if i < root {
    // rust: i + 1
    // rust: } else {
    // rust: i
}
}
    // rust: let valid = |c: &i32| usize::try_from(*c).ok().filter(|&c| c < count);
    // The local node at the same path, found breadth first from the roots
    // along children (redirects are not paths of their own).
    // rust: let mut matched: Vec<Option<usize>> = vec![None; count];
    // rust: matched[root] = Some(0);
    // rust: let mut queue = VecDeque::from([root]);
    // rust: let mut seen = HashSet::from([root]);
    // rust: while let Some(n) = queue.pop_front() {
    // rust: for c in packet.nodes[n].children.iter().filter_map(valid) {
    // rust: if !seen.insert(c) {
    // rust: continue;
}
    // rust: let node = &packet.nodes[c];
    // rust: matched[c] = matched[n].and_then(|l| {
    // rust: local.nodes[l].children.iter().copied().find(|&lc| {
    // rust: let ln = &local.nodes[lc];
    // rust: ln.name() == node.name
    // rust: && matches!(
    // rust: (&ln.kind, node.kind),
    // rust: (NodeKind::Literal(_), 1) | (NodeKind::Argument { .. }, 2)
    // rust: )
    // rust: })
    // rust: });
    // rust: queue.push_back(c);
}
}
    // rust: let mut nodes = vec![None; count];
    // rust: for (i, node) in packet.nodes.iter().enumerate() {
    // rust: let local_node = matched[i].map(|l| &local.nodes[l]);
    // rust: let kind = match node.kind {
    // rust: 1 => NodeKind::Literal(node.name.clone()),
    // rust: 2 => {
    // rust: let ty = match local_node.map(|l| &l.kind) {
    // rust: Some(NodeKind::Argument { ty, .. }) => ty.clone(),
    // rust: _ => node
    // rust: .parser
    // rust: .as_ref()
    // rust: .map_or(ArgType::Word, |(id, props)| argument_type(*id, props)),
}
    // rust: NodeKind::Argument {
    // rust: name: node.name.clone(),
    // rust: ty,
}
}
    // rust: _ => NodeKind::Root,
}
        // The server's providers, as the client knows them
        // (ArgumentNodeStub.build): its own custom ones arrive as `ask_server`.
    // rust: let suggests = node.suggestions.as_deref().and_then(provider);
    // rust: nodes[index(i)] = Some(Node {
    // rust: kind: if i == root { NodeKind::Root } else { kind },
    // rust: children: node.children.iter().filter_map(valid).map(index).collect(),
    // rust: command: node.executable.then_some(SERVER_COMMAND),
    // rust: redirect: node.redirect.as_ref().and_then(valid).map(index),
            // The server sent only what the player may use.
    // rust: permission: 0,
    // rust: suggests,
    // rust: restricted: node.restricted,
    // rust: });
}
    // rust: let mut d = Dispatcher::new();
    // rust: if count > 0 {
    // rust: d.nodes = nodes.into_iter().flatten().collect();
}
    // rust: d
}

/// SuggestionProviders by id (`SuggestionProviders.getProvider`).
pub fn provider(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:ask_server" => Some(Suggests::AskServer),
    // rust: "minecraft:summonable_entities" => Some(Suggests::SummonableEntities),
    // rust: _ => None,
}
}

/// A registry name kept for the life of the game (argument types hold
/// `&'static str`): each distinct name is stored once.
pub fn intern(name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
pub const NAMES: OnceLock<Mutex<std.AutoHashMap(*'static str, void)>> = OnceLock::new();
    // rust: let mut names = NAMES
    // rust: .get_or_init(Default::default)
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(&n) = names.get(name) {
    // rust: return n;
}
    // rust: let n: &'static str = Box::leak(name.to_owned().into_boxed_str());
    // rust: names.insert(n);
    // rust: n
}

/// The argument type a parser and its properties describe
/// (ArgumentTypeInfo.Template.instantiate).
pub fn argument_type(id: i32, props: []const u8) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(name) = usize::try_from(id).ok().and_then(|i| ARGUMENT_TYPES.get(i)) else {
    // rust: return ArgType::Word;
}
    // rust: let p = ArgumentProperties::decode(id, props).unwrap_or(ArgumentProperties::None);
    // rust: let registry = || match &p {
    // rust: ArgumentProperties::Registry(r) => intern(r),
    // rust: _ => "",
}
    // rust: match *name {
    // rust: "brigadier:bool" => ArgType::Bool,
    // rust: "brigadier:integer" => match p {
    // rust: ArgumentProperties::Integer { min, max } => ArgType::Integer {
    // rust: min: min.unwrap_or(i32::MIN),
    // rust: max: max.unwrap_or(i32::MAX),
    // rust: },
    // rust: _ => ArgType::Integer {
    // rust: min: i32::MIN,
    // rust: max: i32::MAX,
    // rust: },
    // rust: },
        // No long type of its own: a double over the same bounds reads
        // the same digits.
    // rust: "brigadier:long" => match p {
    // rust: ArgumentProperties::Long { min, max } => ArgType::Double {
    // rust: min: min.map_or(f64::MIN, |v| v as f64),
    // rust: max: max.map_or(f64::MAX, |v| v as f64),
    // rust: },
    // rust: _ => ArgType::Double {
    // rust: min: f64::MIN,
    // rust: max: f64::MAX,
    // rust: },
    // rust: },
    // rust: "brigadier:float" => match p {
    // rust: ArgumentProperties::Float { min, max } => ArgType::Float {
    // rust: min: min.unwrap_or(f32::MIN),
    // rust: max: max.unwrap_or(f32::MAX),
    // rust: },
    // rust: _ => ArgType::Float {
    // rust: min: f32::MIN,
    // rust: max: f32::MAX,
    // rust: },
    // rust: },
    // rust: "brigadier:double" => match p {
    // rust: ArgumentProperties::Double { min, max } => ArgType::Double {
    // rust: min: min.unwrap_or(f64::MIN),
    // rust: max: max.unwrap_or(f64::MAX),
    // rust: },
    // rust: _ => ArgType::Double {
    // rust: min: f64::MIN,
    // rust: max: f64::MAX,
    // rust: },
    // rust: },
    // rust: "brigadier:string" => match p {
    // rust: ArgumentProperties::String(1) => ArgType::Str,
    // rust: ArgumentProperties::String(2) => ArgType::Greedy,
    // rust: _ => ArgType::Word,
    // rust: },
    // rust: "minecraft:entity" => match p {
    // rust: ArgumentProperties::Entity {
    // rust: single,
    // rust: players_only,
    // rust: } => ArgType::Entity {
    // rust: single,
    // rust: players: players_only,
    // rust: },
    // rust: _ => ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
    // rust: },
    // rust: },
    // rust: "minecraft:game_profile" => ArgType::GameProfile,
    // rust: "minecraft:block_pos" => ArgType::BlockPos,
    // rust: "minecraft:column_pos" => ArgType::ColumnPos,
    // rust: "minecraft:vec3" => ArgType::Vec3 { center: true },
    // rust: "minecraft:vec2" => ArgType::Vec2,
    // rust: "minecraft:block_state" => ArgType::BlockState,
    // rust: "minecraft:block_predicate" => ArgType::BlockPredicate,
    // rust: "minecraft:item_stack" => ArgType::Item,
    // rust: "minecraft:item_predicate" => ArgType::ItemPredicate,
    // rust: "minecraft:team_color" => ArgType::TeamColor,
    // rust: "minecraft:hex_color" => ArgType::HexColor,
    // rust: "minecraft:component" => ArgType::Component,
    // rust: "minecraft:style" => ArgType::Style,
    // rust: "minecraft:message" => ArgType::Message,
    // rust: "minecraft:nbt_compound_tag" => ArgType::Nbt,
    // rust: "minecraft:nbt_tag" => ArgType::NbtTag,
    // rust: "minecraft:nbt_path" => ArgType::NbtPath,
    // rust: "minecraft:objective" => ArgType::Objective,
    // rust: "minecraft:objective_criteria" => ArgType::Criteria,
    // rust: "minecraft:operation" => ArgType::Operation,
    // rust: "minecraft:particle" => ArgType::Particle,
    // rust: "minecraft:angle" => ArgType::Angle,
    // rust: "minecraft:rotation" => ArgType::Rotation,
    // rust: "minecraft:scoreboard_slot" => ArgType::ScoreboardSlot,
    // rust: "minecraft:score_holder" => ArgType::ScoreHolder {
    // rust: multiple: matches!(p, ArgumentProperties::ScoreHolder { multiple: true }),
    // rust: },
    // rust: "minecraft:swizzle" => ArgType::Swizzle,
    // rust: "minecraft:team" => ArgType::Team,
    // rust: "minecraft:item_slot" => ArgType::Slot,
    // rust: "minecraft:item_slots" => ArgType::Slots,
    // rust: "minecraft:resource_location" => ArgType::Id("none"),
    // rust: "minecraft:function" => ArgType::Function,
    // rust: "minecraft:entity_anchor" => ArgType::Anchor,
    // rust: "minecraft:int_range" => ArgType::IntRange,
    // rust: "minecraft:float_range" => ArgType::FloatRange,
    // rust: "minecraft:dimension" => ArgType::Dimension,
    // rust: "minecraft:gamemode" => ArgType::GameMode,
    // rust: "minecraft:time" => ArgType::Time {
    // rust: min: match p {
    // rust: ArgumentProperties::Time { min } => min,
    // rust: _ => 0,
    // rust: },
    // rust: },
    // rust: "minecraft:resource_or_tag" => ArgType::ResOrTag(registry()),
    // rust: "minecraft:resource_or_tag_key" => ArgType::ResOrTagKey(registry()),
    // rust: "minecraft:resource" => ArgType::Res(registry()),
    // rust: "minecraft:resource_key" => ArgType::ResKey(registry()),
    // rust: "minecraft:resource_selector" => ArgType::ResourceSelector(registry()),
    // rust: "minecraft:template_mirror" => ArgType::Enum(&["none", "front_back", "left_right"]),
    // rust: "minecraft:template_rotation" => {
    // rust: ArgType::Enum(&["none", "clockwise_90", "180", "counterclockwise_90"])
}
    // rust: "minecraft:heightmap" => ArgType::Enum(&[
    // rust: "world_surface",
    // rust: "motion_blocking",
    // rust: "motion_blocking_no_leaves",
    // rust: "ocean_floor",
    // rust: ]),
    // rust: "minecraft:swing_animation" => ArgType::Enum(&["none", "whack", "stab"]),
    // rust: "minecraft:loot_table" => ArgType::ResourceOrId("minecraft:loot_table"),
    // rust: "minecraft:loot_predicate" => ArgType::ResourceOrId("minecraft:predicate"),
    // rust: "minecraft:loot_modifier" => ArgType::ResourceOrId("minecraft:item_modifier"),
    // rust: "minecraft:context_float_provider" => {
    // rust: ArgType::ResourceOrId("minecraft:context_float_provider")
}
    // rust: "minecraft:context_int_provider" => ArgType::ResourceOrId("minecraft:context_int_provider"),
    // rust: "minecraft:slot_source" => ArgType::SlotSource,
    // rust: "minecraft:dialog" => ArgType::ResourceOrId("minecraft:dialog"),
    // rust: "minecraft:feature" => ArgType::ResourceOrId("minecraft:worldgen/feature"),
    // rust: "minecraft:uuid" => ArgType::Uuid,
    // rust: _ => ArgType::Word,
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::{
    // rust: buf::{Codec, Reader, Writer},
    // rust: packets::play::CommandNode,
}

pub fn literal(name: []const u8, children: std.ArrayList(i32), executable: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CommandNode {
    // rust: kind: 1,
    // rust: executable,
    // rust: restricted: false,
    // rust: children,
    // rust: redirect: None,
    // rust: name: name.into(),
    // rust: parser: None,
    // rust: suggestions: None,
}
}

pub fn argument(name: []const u8, parser: []const u8, props: std.ArrayList(u8), executable: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = ARGUMENT_TYPES.iter().position(|p| *p == parser).unwrap() as i32;
    // rust: CommandNode {
    // rust: kind: 2,
    // rust: executable,
    // rust: restricted: false,
    // rust: children: Vec::new(),
    // rust: redirect: None,
    // rust: name: name.into(),
    // rust: parser: Some((id, props)),
    // rust: suggestions: Some("minecraft:ask_server".into()),
}
}

    /// A tree with the root last (as vanilla's numbering need not put it
    /// first), a vanilla command and one the client does not know.
pub fn packet() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut range = Writer::new();
    // rust: range.u8(3);
    // rust: range.i32(1);
    // rust: range.i32(64);
    // rust: Commands {
    // rust: nodes: vec![
    // rust: literal("give", vec![2], false),
    // rust: literal("warp", vec![3], false),
    // rust: argument("targets", "minecraft:entity", vec![2], false),
    // rust: argument("count", "brigadier:integer", range.data, true),
    // rust: CommandNode {
    // rust: kind: 0,
    // rust: executable: false,
    // rust: restricted: false,
    // rust: children: vec![0, 1],
    // rust: redirect: None,
    // rust: name: String::new(),
    // rust: parser: None,
    // rust: suggestions: None,
    // rust: },
    // rust: ],
    // rust: root: 4,
}
}

    /// `stop` runs but is restricted, `say <message>` signs, `list` is plain.
pub fn tree_for_checks() D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stop = literal("stop", Vec::new(), true);
    // rust: stop.restricted = true;
    // rust: let tree = Commands {
    // rust: nodes: vec![
    // rust: stop,
    // rust: literal("say", vec![2], false),
    // rust: argument("message", "minecraft:message", Vec::new(), true),
    // rust: literal("list", Vec::new(), true),
    // rust: CommandNode {
    // rust: kind: 0,
    // rust: executable: false,
    // rust: restricted: false,
    // rust: children: vec![0, 1, 3],
    // rust: redirect: None,
    // rust: name: String::new(),
    // rust: parser: None,
    // rust: suggestions: None,
    // rust: },
    // rust: ],
    // rust: root: 4,
}
    // rust: from_packet(&tree, &Dispatcher::new())
}

pub fn is_valid_needs_a_whole_command_that_runs() void {
}
    // rust: let tree = tree_for_checks();
    // rust: let reg = crate::Registries::default();
    // rust: assert!(tree.parse("list", &reg).is_valid());
    // rust: assert!(tree.parse("say hello", &reg).is_valid());
        // Unknown, stopping short of a command, and with something left over.
    // rust: assert!(!tree.parse("nosuchcommand", &reg).is_valid());
    // rust: assert!(!tree.parse("say", &reg).is_valid());
    // rust: assert!(!tree.parse("list extra", &reg).is_valid());
}

pub fn without_restricted_drops_only_restricted_nodes() void {
}
    // rust: let tree = tree_for_checks();
    // rust: let reg = crate::Registries::default();
    // rust: assert!(tree.parse("stop", &reg).is_valid());
    // rust: let restricted = tree.without_restricted();
    // rust: assert!(!restricted.parse("stop", &reg).is_valid());
    // rust: assert!(restricted.parse("list", &reg).is_valid());
    // rust: assert!(restricted.parse("say hello", &reg).is_valid());
}

pub fn argument_nodes_round_trip() void {
}
    // rust: let p = packet();
    // rust: let mut w = Writer::new();
    // rust: Commands::write(&p, &mut w);
    // rust: let back = Commands::read(&mut Reader::new(&w.data)).unwrap();
    // rust: assert_eq!(back, p);
}

    /// What a client signs (SignableCommand.of over the server's tree): the
    /// message arguments of vanilla's /msg and of a command the client does
    /// not know, and nothing for a command without one.
pub fn signable_arguments_of_a_server_tree() void {
}
    // rust: let mut shout = argument("text", "minecraft:message", vec![], true);
    // rust: shout.suggestions = None;
    // rust: let mut targets = argument("targets", "minecraft:entity", vec![0], false);
    // rust: targets.children = vec![2];
    // rust: let packet = Commands {
    // rust: nodes: vec![
    // rust: literal("msg", vec![1], false),
    // rust: targets,
    // rust: argument("message", "minecraft:message", vec![], true),
    // rust: literal("shout", vec![4], false),
    // rust: shout,
    // rust: literal("spawn", vec![], true),
    // rust: CommandNode {
    // rust: kind: 0,
    // rust: executable: false,
    // rust: restricted: false,
    // rust: children: vec![0, 3, 5],
    // rust: redirect: None,
    // rust: name: String::new(),
    // rust: parser: None,
    // rust: suggestions: None,
    // rust: },
    // rust: ],
    // rust: root: 6,
}
    // rust: let d = from_packet(&packet, super::super::vanilla::dispatcher());
    // rust: let reg = crate::Registries::default();
    // rust: let signable = |command: &str| d.parse(command, &reg).signable_arguments(&d);
    // rust: assert_eq!(
    // rust: signable("msg Steve hi there @a"),
    // rust: vec![("message".to_owned(), "hi there @a".to_owned())]
    // rust: );
    // rust: assert_eq!(
    // rust: signable("shout hello"),
    // rust: vec![("text".to_owned(), "hello".to_owned())]
    // rust: );
    // rust: assert!(signable("spawn").is_empty());
    // rust: assert!(signable("unknown words").is_empty());
}

pub fn server_tree_becomes_a_dispatcher() void {
}
    // rust: let local = super::super::vanilla::dispatcher();
    // rust: let d = from_packet(&packet(), local);
    // rust: assert!(matches!(d.nodes[0].kind, NodeKind::Root));
    // rust: let warp = d.find("warp").expect("warp");
    // rust: let count = d.nodes[warp].children[0];
    // rust: match &d.nodes[count].kind {
    // rust: NodeKind::Argument {
    // rust: ty: ArgType::Integer { min, max },
    // rust: ..
    // rust: } => assert_eq!((*min, *max), (1, 64)),
    // rust: other => panic!("count is {other:?}"),
}
    // rust: assert_eq!(d.nodes[count].command, Some(SERVER_COMMAND));
        // `give <targets>` is vanilla's: it keeps the client's type.
    // rust: let give = d.find("give").expect("give");
    // rust: let targets = d.nodes[give].children[0];
    // rust: assert!(matches!(
    // rust: d.nodes[targets].kind,
    // rust: NodeKind::Argument {
    // rust: ty: ArgType::Entity {
    // rust: single: false,
    // rust: players: true
    // rust: },
    // rust: ..
}
    // rust: ));
}

pub fn every_argument_type_decodes() void {
}
    // rust: for (id, name) in ARGUMENT_TYPES.iter().enumerate() {
    // rust: let mut w = Writer::new();
    // rust: match *name {
    // rust: "brigadier:integer" | "brigadier:long" | "brigadier:float" | "brigadier:double" => {
    // rust: w.u8(0)
}
    // rust: "brigadier:string" => w.varint(2),
    // rust: "minecraft:entity" | "minecraft:score_holder" => w.u8(1),
    // rust: "minecraft:time" => w.i32(0),
    // rust: n if n.starts_with("minecraft:resource") && n != "minecraft:resource_location" => {
    // rust: w.string("minecraft:item")
}
    // rust: _ => {}
}
    // rust: let mut r = Reader::new(&w.data);
    // rust: ArgumentProperties::read(&mut r, id as i32).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "{name}");
    // rust: let _ = argument_type(id as i32, &w.data);
}
}
}
