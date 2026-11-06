//! Transpiled from Horizon Rust crate
//! Module: horizon-client_commands
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The command tree players receive (Commands.sendCommands and
//! ClientboundCommandsPacket): vanilla's tree from the data generator's
//! commands report, cut down to the nodes the player's permission level may
//! use and the commands of the server kind (dedicated servers have `op`,
//! `ban`, `stop` ...; an integrated server `publish`), numbered breadth first
//! as vanilla does, with the argument parsers' network properties and the
//! custom suggestion providers (`command_suggestions`). The report sorts each
//! node's children; the tree keeps vanilla's registration order
//! (`command_order`).
// use super::{command_order::ORDER, command_suggestions::SUGGESTIONS};
// use horizon_protocol::{
    // rust: buf::Writer,
    // rust: packets::play::{CommandNode, Commands},
    // rust: registry::Builtin,
}
// use serde_json::Value;
// use std::{
    // rust: collections::{HashMap, VecDeque},
    // rust: path::Path,
    // rust: sync::OnceLock,
}

/// Commands.CommandSelection: registered only on dedicated servers.
    // rust: const DEDICATED_ONLY: &[&str] = &[
    // rust: "ban",
    // rust: "ban-ip",
    // rust: "banlist",
    // rust: "deop",
    // rust: "op",
    // rust: "pardon",
    // rust: "pardon-ip",
    // rust: "perf",
    // rust: "save-all",
    // rust: "save-off",
    // rust: "save-on",
    // rust: "setidletimeout",
    // rust: "stop",
    // rust: "transfer",
    // rust: "whitelist",
    // rust: ];
/// Registered only on integrated servers.
pub const INTEGRATED_ONLY: *[[]const u8] = &["publish", "unpublish"];
/// Commands that check permissions only on dedicated servers
/// (`checkPermissions` in SeedCommand and VersionCommand).
pub const OPEN_WHEN_INTEGRATED: *[[]const u8] = &["seed", "version"];
/// Game rules of experimental features (minecart improvements), which the
/// report lists but a vanilla-features world does not register.
pub const EXPERIMENTAL_RULES: *[[]const u8] = &["max_minecart_speed", "minecraft:max_minecart_speed"];

pub const CommandTree = struct {
    root: Value,
};

/// A node of the filtered tree.
pub const Node = struct {
    name: []const u8,
    kind: u8,
    executable: bool,
    restricted: bool,
    children: std.ArrayList(usize),
    redirect: ?std.ArrayList([]const u8),
    parser: Option<([]const u8,
    suggestions: ?*'static str,
};

/// PermissionLevel names in the report's requirements.
pub fn required_level(node: *Value) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match node["permissions"]["permission"]["level"].as_str() {
    // rust: Some("moderators") => 1,
    // rust: Some("gamemasters") => 2,
    // rust: Some("admins") => 3,
    // rust: Some("owners") => 4,
    // rust: _ => 0,
}
}

    // rust: impl CommandTree {
    /// commands.json next to registries.json (the data generator's reports).
pub fn load(resources: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = Builtin::find(resources)?.parent()?.to_path_buf();
    // rust: let text = std::fs::read_to_string(dir.join("commands.json")).ok()?;
    // rust: Some(Self {
    // rust: root: serde_json::from_str(&text).ok()?,
    // rust: })
}

    /// Whether vanilla has a command of this name.
pub fn has(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.root["children"].get(name).is_some()
}

    /// The ClientboundCommandsPacket for a player with `level` permissions.
pub fn packet(self: *Self, level: u8, dedicated: bool, builtin: *Builtin) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.packet_with(level, dedicated, builtin, &Value::Null)
}

    /// [`CommandTree::packet`] with more commands after vanilla's: `extra`
    /// is a root in the report's format (server mods' commands).
    // rust: pub fn packet_with(
    // rust: &self,
    // rust: level: u8,
    // rust: dedicated: bool,
    // rust: builtin: &Builtin,
    // rust: extra: &Value,
    // rust: ) -> Commands {
    // rust: self.packet_with_features(level, dedicated, builtin, extra, &[])
}

    // rust: pub fn packet_with_features(
    // rust: &self,
    // rust: level: u8,
    // rust: dedicated: bool,
    // rust: builtin: &Builtin,
    // rust: extra: &Value,
    // rust: features: &[String],
    // rust: ) -> Commands {
    // rust: let minecart_improvements = features
    // rust: .iter()
    // rust: .any(|f| f == crate::gamerules::MINECART_IMPROVEMENTS);
    // rust: let mut nodes = vec![Node {
    // rust: name: String::new(),
    // rust: kind: 0,
    // rust: executable: false,
    // rust: restricted: false,
    // rust: children: Vec::new(),
    // rust: redirect: None,
    // rust: parser: None,
    // rust: suggestions: None,
    // rust: }];
    // rust: let suggestions: HashMap<&str, &'static str> = SUGGESTIONS.iter().copied().collect();
    // rust: let mut paths: HashMap<Vec<String>, usize> = HashMap::new();
    // rust: paths.insert(Vec::new(), 0);
    // rust: let horizon = if crate::command::vanilla::game_dispatcher()
    // rust: .find("pregen")
    // rust: .is_some()
    // rust: {
    // rust: crate::pregen::command_tree()
    // rust: } else {
    // rust: Value::Null
}
    // rust: for root in [&self.root, extra, &horizon] {
    // rust: fill(
    // rust: root,
    // rust: 0,
    // rust: &mut Vec::new(),
    // rust: level,
    // rust: dedicated,
    // rust: minecart_improvements,
    // rust: &suggestions,
    // rust: &mut nodes,
    // rust: &mut paths,
    // rust: );
}
        // enumerateNodes: breadth first from the root, each node's children
        // (in registration order) then its redirect target.
    // rust: let mut ids = vec![None; nodes.len()];
    // rust: let mut order = Vec::new();
    // rust: let mut queue = VecDeque::from([0usize]);
    // rust: while let Some(n) = queue.pop_front() {
    // rust: if ids[n].is_some() {
    // rust: continue;
}
    // rust: ids[n] = Some(order.len() as i32);
    // rust: order.push(n);
    // rust: queue.extend(nodes[n].children.iter().copied());
    // rust: if let Some(target) = nodes[n].redirect.as_ref().and_then(|p| paths.get(p)) {
    // rust: queue.push_back(*target);
}
}
    // rust: let argument_types = builtin.get("minecraft:command_argument_type");
    // rust: let out = order
    // rust: .iter()
    // rust: .map(|&n| {
    // rust: let node = &nodes[n];
    // rust: CommandNode {
    // rust: kind: node.kind,
    // rust: executable: node.executable,
    // rust: restricted: node.restricted,
    // rust: children: node.children.iter().filter_map(|c| ids[*c]).collect(),
    // rust: redirect: node
    // rust: .redirect
    // rust: .as_ref()
    // rust: .and_then(|p| paths.get(p))
    // rust: .and_then(|t| ids[*t]),
    // rust: name: node.name.clone(),
    // rust: parser: node.parser.as_ref().map(|(parser, props)| {
    // rust: let id = argument_types.and_then(|t| t.id(parser)).unwrap_or(0);
    // rust: (id, properties(parser, props))
    // rust: }),
    // rust: suggestions: node.suggestions.map(str::to_owned),
}
    // rust: })
    // rust: .collect();
    // rust: Commands {
    // rust: nodes: out,
    // rust: root: 0,
}
}
}

/// Commands.fillUsableCommands over the report: the children the source may use.
    // rust: fn fill(
    // rust: source: &Value,
    // rust: target: usize,
    // rust: path: &mut Vec<String>,
    // rust: level: u8,
    // rust: dedicated: bool,
    // rust: minecart_improvements: bool,
    // rust: suggestions: &HashMap<&str, &'static str>,
    // rust: nodes: &mut Vec<Node>,
    // rust: paths: &mut HashMap<Vec<String>, usize>,
    // rust: ) {
    // rust: let Some(children) = source["children"].as_object() else {
    // rust: return;
}
    // rust: let mut names: Vec<&String> = children.keys().collect();
    // rust: names.sort();
    // Vanilla's registration order; names it doesn't list (the game rules,
    // registered in an identity-hashed order) keep the report's.
pub const ORDERS: OnceLock<std.AutoHashMap([]const u8, std.ArrayList([]const u8))> = OnceLock::new();
    // rust: let orders = ORDERS.get_or_init(|| {
    // rust: ORDER
    // rust: .iter()
    // rust: .map(|(path, names)| (*path, names.split(' ').collect()))
    // rust: .collect()
    // rust: });
    // rust: if let Some(order) = orders.get(path.join(" ").as_str()) {
    // rust: names.sort_by_key(|n| order.iter().position(|o| o == n).unwrap_or(order.len()));
}
    // rust: for name in names {
    // rust: let child = &children[name];
    // rust: let required =
    // rust: if path.is_empty() && !dedicated && OPEN_WHEN_INTEGRATED.contains(&name.as_str()) {
    // rust: 0
    // rust: } else {
    // rust: required_level(child)
}
    // rust: if required > level
    // rust: || path.len() == 1
    // rust: && path[0] == "gamerule"
    // rust: && !minecart_improvements
    // rust: && EXPERIMENTAL_RULES.contains(&name.as_str())
    // rust: {
    // rust: continue;
}
    // rust: if path.is_empty()
    // rust: && (dedicated && INTEGRATED_ONLY.contains(&name.as_str())
    // rust: || !dedicated && DEDICATED_ONLY.contains(&name.as_str()))
    // rust: {
    // rust: continue;
}
    // rust: path.push(name.clone());
    // rust: let argument = child["type"] == "argument";
    // rust: let index = nodes.len();
    // rust: nodes.push(Node {
    // rust: name: name.clone(),
    // rust: kind: if argument { 2 } else { 1 },
    // rust: executable: child["executable"].as_bool().unwrap_or(false),
    // rust: restricted: required > 0,
    // rust: children: Vec::new(),
    // rust: redirect: redirect(child),
    // rust: parser: argument.then(|| {
    // rust: (
    // rust: child["parser"].as_str().unwrap_or_default().to_owned(),
    // rust: child["properties"].clone(),
    // rust: )
    // rust: }),
    // rust: suggestions: if argument {
    // rust: suggestions.get(path.join(" ").as_str()).copied()
    // rust: } else {
    // rust: None
    // rust: },
    // rust: });
    // rust: nodes[target].children.push(index);
    // rust: paths.insert(path.clone(), index);
    // rust: fill(
    // rust: child,
    // rust: index,
    // rust: path,
    // rust: level,
    // rust: dedicated,
    // rust: minecart_improvements,
    // rust: suggestions,
    // rust: nodes,
    // rust: paths,
    // rust: );
    // rust: path.pop();
}
}

/// The redirect target's path. The report leaves out redirects to the root
/// (`execute ... run`, `return run`): a node that neither runs nor leads
/// anywhere forks to the root.
pub fn redirect(node: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(path) = node["redirect"].as_array() {
    // rust: return Some(
    // rust: path.iter()
    // rust: .filter_map(|s| s.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: );
}
    // rust: let dead_end = node["children"].as_object().is_none_or(|c| c.is_empty())
    // rust: && !node["executable"].as_bool().unwrap_or(false);
    // rust: dead_end.then(Vec::new)
}

/// ArgumentTypeInfo.serializeToNetwork for the report's properties.
pub fn properties(parser: []const u8, p: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: let flags = |w: &mut Writer| {
    // rust: w.u8(u8::from(p.get("min").is_some()) | u8::from(p.get("max").is_some()) << 1);
}
    // rust: match parser {
    // rust: "brigadier:integer" => {
    // rust: flags(&mut w);
    // rust: for key in ["min", "max"] {
    // rust: if let Some(v) = p[key].as_i64() {
    // rust: w.i32(v as i32);
}
}
}
    // rust: "brigadier:long" => {
    // rust: flags(&mut w);
    // rust: for key in ["min", "max"] {
    // rust: if let Some(v) = p[key].as_i64() {
    // rust: w.i64(v);
}
}
}
    // rust: "brigadier:float" => {
    // rust: flags(&mut w);
    // rust: for key in ["min", "max"] {
    // rust: if let Some(v) = p[key].as_f64() {
    // rust: w.f32(v as f32);
}
}
}
    // rust: "brigadier:double" => {
    // rust: flags(&mut w);
    // rust: for key in ["min", "max"] {
    // rust: if let Some(v) = p[key].as_f64() {
    // rust: w.f64(v);
}
}
}
    // rust: "brigadier:string" => w.varint(match p["type"].as_str() {
    // rust: Some("phrase") => 1,
    // rust: Some("greedy") => 2,
    // rust: _ => 0,
    // rust: }),
    // rust: "minecraft:entity" => {
    // rust: let single = u8::from(p["amount"] == "single");
    // rust: let players = u8::from(p["type"] == "players");
    // rust: w.u8(single | players << 1);
}
    // rust: "minecraft:score_holder" => w.u8(u8::from(p["amount"] == "multiple")),
    // rust: "minecraft:time" => w.i32(p["min"].as_i64().unwrap_or(0) as i32),
    // rust: "minecraft:resource"
    // rust: | "minecraft:resource_key"
    // rust: | "minecraft:resource_or_tag"
    // rust: | "minecraft:resource_or_tag_key"
    // rust: | "minecraft:resource_selector" => w.string(p["registry"].as_str().unwrap_or_default()),
    // rust: _ => {}
}
    // rust: w.data
}

    // rust: mod tests {
//     use super::*;

pub fn pregen_completion_keeps_permissions_and_radius_bounds() void {
}
    // rust: let tree = CommandTree {
    // rust: root: crate::pregen::command_tree(),
}
    // rust: let builtin = Builtin::default();
    // rust: assert_eq!(tree.packet(0, false, &builtin).nodes.len(), 1);
    // rust: let packet = tree.packet(2, false, &builtin);
    // rust: let root = packet.nodes.iter().find(|n| n.name == "pregen").unwrap();
    // rust: assert!(root.restricted && !root.executable);
    // rust: let radius = packet.nodes.iter().find(|n| n.name == "radius").unwrap();
    // rust: assert!(radius.executable);
    // rust: assert_eq!(
    // rust: radius.parser.as_ref().unwrap().1,
    // rust: vec![3, 0, 0, 0, 0, 1, 201, 195, 128]
    // rust: );
    // rust: let shapes: Vec<_> = radius
    // rust: .children
    // rust: .iter()
    // rust: .map(|&i| packet.nodes[i as usize].name.as_str())
    // rust: .collect();
    // rust: assert_eq!(shapes, ["circle", "square"]);
    // rust: assert_eq!(
    // rust: packet
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|n| n.name == "center" && n.executable)
    // rust: .count(),
    // rust: 2
    // rust: );
}

pub fn integer_bounds_and_entity_flags() void {
}
    // rust: let p: Value = serde_json::from_str(r#"{"min": 1, "max": 1000}"#).unwrap();
    // rust: assert_eq!(
    // rust: properties("brigadier:integer", &p),
    // rust: vec![3, 0, 0, 0, 1, 0, 0, 3, 0xE8]
    // rust: );
    // rust: let p: Value = serde_json::from_str(r#"{"amount": "single", "type": "players"}"#).unwrap();
    // rust: assert_eq!(properties("minecraft:entity", &p), vec![3]);
    // rust: let p: Value = serde_json::from_str(r#"{"type": "greedy"}"#).unwrap();
    // rust: assert_eq!(properties("brigadier:string", &p), vec![2]);
}

pub fn levels_filter_and_redirects_resolve() void {
}
    // rust: let report: Value = serde_json::from_str(
    // rust: r#"{"type":"root","children":{
    // rust: "say":{"type":"literal","children":{"message":{"type":"argument","parser":"minecraft:message","executable":true}},
    // rust: "permissions":{"type":"minecraft:require","permission":{"type":"minecraft:command_level","level":"gamemasters"}}},
    // rust: "me":{"type":"literal","children":{"action":{"type":"argument","parser":"minecraft:message","executable":true}}},
    // rust: "stop":{"type":"literal","executable":true},
    // rust: "tell":{"type":"literal","redirect":["me"]}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let tree = CommandTree { root: report };
    // rust: let builtin = Builtin::default();
    // rust: let guest = tree.packet(0, false, &builtin);
    // rust: let names: Vec<_> = guest.nodes.iter().map(|n| n.name.as_str()).collect();
    // rust: assert_eq!(names, ["", "me", "tell", "action"]);
        // `tell` redirects to `me` (node 1).
    // rust: assert_eq!(guest.nodes[2].redirect, Some(1));
    // rust: let op = tree.packet(2, true, &builtin);
    // rust: let names: Vec<_> = op.nodes.iter().map(|n| n.name.as_str()).collect();
        // The root's children in vanilla's registration order.
    // rust: assert_eq!(
    // rust: names,
    // rust: ["", "me", "tell", "say", "stop", "action", "message"]
    // rust: );
    // rust: assert!(op.nodes[3].restricted);
}

pub fn server_mods_commands_follow_vanillas() void {
}
    // rust: let report: Value = serde_json::from_str(
    // rust: r#"{"type":"root","children":{"me":{"type":"literal","children":{"action":{"type":"argument","parser":"minecraft:message","executable":true}}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mods: Value = serde_json::from_str(
    // rust: r#"{"type":"root","children":{"beacon":{"type":"literal","executable":true,"children":{
    // rust: "height":{"type":"argument","parser":"brigadier:integer","properties":{"min":1,"max":64},"executable":true}}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let tree = CommandTree { root: report };
    // rust: let packet = tree.packet_with(0, true, &Builtin::default(), &mods);
    // rust: let names: Vec<_> = packet.nodes.iter().map(|n| n.name.as_str()).collect();
    // rust: assert_eq!(names, ["", "me", "beacon", "action", "height"]);
    // rust: let beacon = &packet.nodes[2];
    // rust: assert!(beacon.executable && !beacon.restricted);
    // rust: assert_eq!(beacon.children, [4]);
    // rust: let height = packet.nodes[4].parser.as_ref().unwrap();
    // rust: assert_eq!(height.1, vec![3, 0, 0, 0, 1, 0, 0, 0, 64]);
        // No mods: vanilla's tree as it is.
    // rust: assert_eq!(
    // rust: tree.packet_with(0, true, &Builtin::default(), &Value::Null)
    // rust: .nodes
    // rust: .len(),
    // rust: 3
    // rust: );
}
}
