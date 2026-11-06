//! Transpiled from Horizon Rust crate
package horizon_command_tree_data

import "core:fmt"
import "core:mem"
import "core:math"

// The `/data` and `/tag` command trees (DataCommands, TagCommand).
// use super::{
    // rust: Dispatcher,
    // rust: args::ArgType,
    // rust: vanilla::{ENTITIES, GAMEMASTERS},
}

    // rust: const ENTITY: ArgType = ArgType::Entity {
    // rust: single: true,
    // rust: players: false,
}

// `ArgProvider.wrap` for each of entity, block and storage: calls `then`
// with the node holding the provider's argument.
    // rust: fn providers(
    // rust: d: &mut Dispatcher,
    // rust: parent: usize,
    // rust: role: &str,
    // rust: mut then: impl FnMut(&mut Dispatcher, usize),
    // rust: ) {
    // rust: let e = d.literal(parent, "entity");
    // rust: let a = d.argument(e, role, ENTITY);
    // rust: then(d, a);
    // rust: let b = d.literal(parent, "block");
    // rust: let a = d.argument(b, &format!("{role}Pos"), ArgType::BlockPos);
    // rust: then(d, a);
    // rust: let s = d.literal(parent, "storage");
    // rust: let a = d.argument(s, role, ArgType::Id("storages"));
    // rust: then(d, a);
}

// LootContextSources.addContextSources: `default`, `block <computePos>`
// and `entity <computeTarget>`, each completed by `then`.
    // rust: pub fn context_sources(
    // rust: d: &mut Dispatcher,
    // rust: node: usize,
    // rust: then: &mut dyn FnMut(&mut Dispatcher, usize),
    // rust: ) {
    // rust: let default = d.literal(node, "default");
    // rust: then(d, default);
    // rust: let block = d.literal(node, "block");
    // rust: let pos = d.argument(block, "computePos", ArgType::BlockPos);
    // rust: then(d, pos);
    // rust: let entity = d.literal(node, "entity");
    // rust: let target = d.argument(entity, "computeTarget", ENTITY);
    // rust: then(d, target);
}

register :: proc(d: ^Dispatcher, root: uint) {
}
    // compute (default | block <pos> | entity <target>) (float <provider> [<scale>] | integer <provider>)
    // rust: let compute = d.literal(root, "compute");
    // rust: d.requires(compute, GAMEMASTERS);
    // rust: context_sources(d, compute, &mut |d, node| {
    // rust: let f = d.literal(node, "float");
    // rust: let p = d.argument(
    // rust: f,
    // rust: "provider",
    // rust: ArgType::ResourceOrId("minecraft:context_float_provider"),
    // rust: );
    // rust: d.executes(p, "compute");
    // rust: let scale = d.argument(
    // rust: p,
    // rust: "scale",
    // rust: ArgType::Float {
    // rust: min: f32::MIN,
    // rust: max: f32::MAX,
    // rust: },
    // rust: );
    // rust: d.executes(scale, "compute");
    // rust: let i = d.literal(node, "integer");
    // rust: let p = d.argument(
    // rust: i,
    // rust: "provider",
    // rust: ArgType::ResourceOrId("minecraft:context_int_provider"),
    // rust: );
    // rust: d.executes(p, "compute");
    // rust: });

    // rust: let data = d.literal(root, "data");
    // rust: d.requires(data, GAMEMASTERS);

    // rust: let merge = d.literal(data, "merge");
    // rust: providers(d, merge, "target", |d, a| {
    // rust: let nbt = d.argument(a, "nbt", ArgType::Nbt);
    // rust: d.executes(nbt, "data.merge");
    // rust: });
    // rust: let get = d.literal(data, "get");
    // rust: providers(d, get, "target", |d, a| {
    // rust: d.executes(a, "data.get");
    // rust: let path = d.argument(a, "path", ArgType::NbtPath);
    // rust: d.executes(path, "data.get");
    // rust: let scale = d.argument(
    // rust: path,
    // rust: "scale",
    // rust: ArgType::Double {
    // rust: min: f64::MIN,
    // rust: max: f64::MAX,
    // rust: },
    // rust: );
    // rust: d.executes(scale, "data.get");
    // rust: });
    // rust: let remove = d.literal(data, "remove");
    // rust: providers(d, remove, "target", |d, a| {
    // rust: let path = d.argument(a, "path", ArgType::NbtPath);
    // rust: d.executes(path, "data.remove");
    // rust: });
    // rust: let modify = d.literal(data, "modify");
    // rust: providers(d, modify, "target", |d, a| {
    // rust: let target_path = d.argument(a, "targetPath", ArgType::NbtPath);
        // insert <index> | prepend | append | set | merge, then the source.
    // rust: let mut ops = Vec::new();
    // rust: let insert = d.literal(target_path, "insert");
    // rust: let index = d.argument(
    // rust: insert,
    // rust: "index",
    // rust: ArgType::Integer {
    // rust: min: i32::MIN,
    // rust: max: i32::MAX,
    // rust: },
    // rust: );
    // rust: ops.push(index);
    // rust: for op in ["prepend", "append", "set", "merge"] {
    // rust: ops.push(d.literal(target_path, op));
}
    // rust: for op in ops {
    // rust: let from = d.literal(op, "from");
    // rust: providers(d, from, "source", |d, s| {
    // rust: d.executes(s, "data.modify");
    // rust: let sp = d.argument(s, "sourcePath", ArgType::NbtPath);
    // rust: d.executes(sp, "data.modify");
    // rust: });
    // rust: let string = d.literal(op, "string");
    // rust: providers(d, string, "source", |d, s| {
    // rust: d.executes(s, "data.modify");
    // rust: let sp = d.argument(s, "sourcePath", ArgType::NbtPath);
    // rust: d.executes(sp, "data.modify");
    // rust: let int = || ArgType::Integer {
    // rust: min: i32::MIN,
    // rust: max: i32::MAX,
}
    // rust: let start = d.argument(sp, "start", int());
    // rust: d.executes(start, "data.modify");
    // rust: let end = d.argument(start, "end", int());
    // rust: d.executes(end, "data.modify");
    // rust: });
    // rust: let compute = d.literal(op, "compute");
    // rust: context_sources(d, compute, &mut |d, node| {
    // rust: for (kind, registry) in [
    // rust: ("float", "minecraft:context_float_provider"),
    // rust: ("integer", "minecraft:context_int_provider"),
    // rust: ] {
    // rust: let k = d.literal(node, kind);
    // rust: let p = d.argument(k, "provider", ArgType::ResourceOrId(registry));
    // rust: d.executes(p, "data.modify");
}
    // rust: });
    // rust: let value = d.literal(op, "value");
    // rust: let v = d.argument(value, "value", ArgType::NbtTag);
    // rust: d.executes(v, "data.modify");
}
    // rust: });

    // tag <targets> add|remove <name> | list
    // rust: let tag = d.literal(root, "tag");
    // rust: d.requires(tag, GAMEMASTERS);
    // rust: let targets = d.argument(tag, "targets", ENTITIES);
    // rust: for word in ["add", "remove"] {
    // rust: let w = d.literal(targets, word);
    // rust: let name = d.argument(w, "name", ArgType::Word);
    // rust: d.executes(
    // rust: name,
    // rust: if word == "add" {
    // rust: "tag.add"
    // rust: } else {
    // rust: "tag.remove"
    // rust: },
    // rust: );
}
    // rust: let list = d.literal(targets, "list");
    // rust: d.executes(list, "tag.list");
}
