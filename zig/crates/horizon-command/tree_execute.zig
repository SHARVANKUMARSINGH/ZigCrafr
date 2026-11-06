//! Transpiled from Horizon Rust crate
//! Module: horizon-command_tree_execute
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The `/execute` tree (ExecuteCommand): modifiers redirect back to
//! `execute`, `run` to the root; conditions both execute (as a test) and
//! continue the chain; `store` redirects with a result callback.
// use super::{
    // rust: Dispatcher,
    // rust: args::{ArgType, Resource},
    // rust: vanilla::{ENTITIES, GAMEMASTERS},
}

/// HeightmapTypeArgument: the types kept after world generation.
    // rust: pub const HEIGHTMAPS: &[&str] = &[
    // rust: "world_surface",
    // rust: "ocean_floor",
    // rust: "motion_blocking",
    // rust: "motion_blocking_no_leaves",
    // rust: ];
    // rust: pub const RELATIONS: [&str; 8] = [
    // rust: "owner",
    // rust: "leasher",
    // rust: "target",
    // rust: "attacker",
    // rust: "vehicle",
    // rust: "controller",
    // rust: "origin",
    // rust: "passengers",
    // rust: ];

/// A conditional's end: it runs as a test and continues the chain.
pub fn conditional(d: *mut Dispatcher, node: usize, ex: usize) void {
}
    // rust: d.executes(node, "execute");
    // rust: d.redirect(node, ex);
}

pub fn register(d: *mut Dispatcher, root: usize) void {
}
    // rust: let ex = d.literal(root, "execute");
    // rust: d.requires(ex, GAMEMASTERS);
    // rust: let run = d.literal(ex, "run");
    // rust: d.redirect(run, root);
    // rust: for name in ["as", "at"] {
    // rust: let l = d.literal(ex, name);
    // rust: let t = d.argument(l, "targets", ENTITIES);
    // rust: d.redirect(t, ex);
}
    // rust: let positioned = d.literal(ex, "positioned");
    // rust: let pos = d.argument(positioned, "pos", ArgType::Vec3 { center: true });
    // rust: d.redirect(pos, ex);
    // rust: let as_ = d.literal(positioned, "as");
    // rust: let t = d.argument(as_, "targets", ENTITIES);
    // rust: d.redirect(t, ex);
    // rust: let over = d.literal(positioned, "over");
    // rust: let hm = d.argument(
    // rust: over,
    // rust: "heightmap",
    // rust: ArgType::StrEnum(HEIGHTMAPS, "argument.enum.invalid"),
    // rust: );
    // rust: d.redirect(hm, ex);
    // rust: let rotated = d.literal(ex, "rotated");
    // rust: let rot = d.argument(rotated, "rot", ArgType::Rotation);
    // rust: d.redirect(rot, ex);
    // rust: let as_ = d.literal(rotated, "as");
    // rust: let t = d.argument(as_, "targets", ENTITIES);
    // rust: d.redirect(t, ex);
    // rust: let facing = d.literal(ex, "facing");
    // rust: let pos = d.argument(facing, "pos", ArgType::Vec3 { center: true });
    // rust: d.redirect(pos, ex);
    // rust: let entity = d.literal(facing, "entity");
    // rust: let t = d.argument(entity, "targets", ENTITIES);
    // rust: let anchor = d.argument(t, "anchor", ArgType::Anchor);
    // rust: d.redirect(anchor, ex);
    // rust: let align = d.literal(ex, "align");
    // rust: let axes = d.argument(align, "axes", ArgType::Swizzle);
    // rust: d.redirect(axes, ex);
    // rust: let anchored = d.literal(ex, "anchored");
    // rust: let anchor = d.argument(anchored, "anchor", ArgType::Anchor);
    // rust: d.redirect(anchor, ex);
    // rust: let in_ = d.literal(ex, "in");
    // rust: let dim = d.argument(in_, "dimension", ArgType::Dimension);
    // rust: d.redirect(dim, ex);
    // rust: let summon = d.literal(ex, "summon");
    // rust: let e = d.argument(summon, "entity", ArgType::Resource(Resource::EntityType));
    // rust: d.suggests(e, super::Suggests::SummonableEntities);
    // rust: d.redirect(e, ex);
    // rust: let on = d.literal(ex, "on");
    // rust: for r in RELATIONS {
    // rust: let l = d.literal(on, r);
    // rust: d.redirect(l, ex);
}
    // rust: store(d, ex);
    // rust: for mode in ["if", "unless"] {
    // rust: let m = d.literal(ex, mode);
    // rust: conditionals(d, m, ex);
}
}

pub fn store(d: *mut Dispatcher, ex: usize) void {
}
    // rust: let store = d.literal(ex, "store");
    // rust: for kind in ["result", "success"] {
    // rust: let k = d.literal(store, kind);
    // rust: let score = d.literal(k, "score");
    // rust: let targets = d.argument(score, "targets", ArgType::ScoreHolder { multiple: true });
    // rust: let objective = d.argument(targets, "objective", ArgType::Objective);
    // rust: d.redirect(objective, ex);
    // rust: let bossbar = d.literal(k, "bossbar");
    // rust: let id = d.argument(bossbar, "id", ArgType::Id("bossbars"));
    // rust: for what in ["value", "max"] {
    // rust: let w = d.literal(id, what);
    // rust: d.redirect(w, ex);
}
    // rust: for provider in ["entity", "block", "storage"] {
    // rust: let p = d.literal(k, provider);
    // rust: let a = match provider {
    // rust: "entity" => d.argument(
    // rust: p,
    // rust: "target",
    // rust: ArgType::Entity {
    // rust: single: true,
    // rust: players: false,
    // rust: },
    // rust: ),
    // rust: "block" => d.argument(p, "targetPos", ArgType::BlockPos),
    // rust: _ => d.argument(p, "target", ArgType::Id("storages")),
}
    // rust: let path = d.argument(a, "path", ArgType::NbtPath);
    // rust: for ty in ["int", "float", "short", "long", "double", "byte"] {
    // rust: let t = d.literal(path, ty);
    // rust: let scale = d.argument(
    // rust: t,
    // rust: "scale",
    // rust: ArgType::Double {
    // rust: min: f64::MIN,
    // rust: max: f64::MAX,
    // rust: },
    // rust: );
    // rust: d.redirect(scale, ex);
}
}
}
}

pub fn conditionals(d: *mut Dispatcher, m: usize, ex: usize) void {
}
    // rust: let block = d.literal(m, "block");
    // rust: let pos = d.argument(block, "pos", ArgType::BlockPos);
    // rust: let predicate = d.argument(pos, "block", ArgType::BlockPredicate);
    // rust: conditional(d, predicate, ex);

    // rust: let biome = d.literal(m, "biome");
    // rust: let pos = d.argument(biome, "pos", ArgType::BlockPos);
    // rust: let b = d.argument(pos, "biome", ArgType::ResOrTag("minecraft:worldgen/biome"));
    // rust: conditional(d, b, ex);

    // rust: let loaded = d.literal(m, "loaded");
    // rust: let pos = d.argument(loaded, "pos", ArgType::BlockPos);
    // rust: conditional(d, pos, ex);

    // rust: let dimension = d.literal(m, "dimension");
    // rust: let dim = d.argument(dimension, "dimension", ArgType::Dimension);
    // rust: conditional(d, dim, ex);

    // rust: let score = d.literal(m, "score");
    // rust: let target = d.argument(score, "target", ArgType::ScoreHolder { multiple: false });
    // rust: let objective = d.argument(target, "targetObjective", ArgType::Objective);
    // rust: for op in ["=", "<", "<=", ">", ">="] {
    // rust: let o = d.literal(objective, op);
    // rust: let source = d.argument(o, "source", ArgType::ScoreHolder { multiple: false });
    // rust: let so = d.argument(source, "sourceObjective", ArgType::Objective);
    // rust: conditional(d, so, ex);
}
    // rust: let matches = d.literal(objective, "matches");
    // rust: let range = d.argument(matches, "range", ArgType::IntRange);
    // rust: conditional(d, range, ex);

    // rust: let blocks = d.literal(m, "blocks");
    // rust: let start = d.argument(blocks, "start", ArgType::BlockPos);
    // rust: let end = d.argument(start, "end", ArgType::BlockPos);
    // rust: let dest = d.argument(end, "destination", ArgType::BlockPos);
    // rust: for mode in ["all", "masked"] {
    // rust: let l = d.literal(dest, mode);
    // rust: conditional(d, l, ex);
}

    // rust: let entity = d.literal(m, "entity");
    // rust: let targets = d.argument(entity, "entities", ENTITIES);
    // rust: conditional(d, targets, ex);

    // rust: let predicate = d.literal(m, "predicate");
    // rust: let p = d.argument(
    // rust: predicate,
    // rust: "predicate",
    // rust: ArgType::ResourceOrId("minecraft:predicate"),
    // rust: );
    // rust: conditional(d, p, ex);

    // rust: let stopwatch = d.literal(m, "stopwatch");
    // rust: let id = d.argument(stopwatch, "id", ArgType::Id("stopwatches"));
    // rust: let range = d.argument(id, "range", ArgType::FloatRange);
    // rust: conditional(d, range, ex);

    // rust: let function = d.literal(m, "function");
    // rust: let name = d.argument(function, "name", ArgType::Function);
    // rust: d.suggests(name, super::Suggests::Functions);
    // ExecuteIfFunctionCustomModifier: a fork only (not a test command).
    // rust: d.redirect(name, ex);

    // rust: let data = d.literal(m, "data");
    // rust: for provider in ["entity", "block", "storage"] {
    // rust: let p = d.literal(data, provider);
    // rust: let a = match provider {
    // rust: "entity" => d.argument(
    // rust: p,
    // rust: "source",
    // rust: ArgType::Entity {
    // rust: single: true,
    // rust: players: false,
    // rust: },
    // rust: ),
    // rust: "block" => d.argument(p, "sourcePos", ArgType::BlockPos),
    // rust: _ => d.argument(p, "source", ArgType::Id("storages")),
}
    // rust: let path = d.argument(a, "path", ArgType::NbtPath);
    // rust: conditional(d, path, ex);
}

    // items / slots (entity|block) <slots> [<predicate>]
    // rust: for kind in ["items", "slots"] {
    // rust: let k = d.literal(m, kind);
    // rust: for provider in ["entity", "block"] {
    // rust: let p = d.literal(k, provider);
    // rust: let a = if provider == "entity" {
    // rust: d.argument(
    // rust: p,
    // rust: "source",
    // rust: ArgType::Entity {
    // rust: single: false,
    // rust: players: false,
    // rust: },
    // rust: )
    // rust: } else {
    // rust: d.argument(p, "sourcePos", ArgType::BlockPos)
}
    // rust: let slots = d.argument(a, "slots", ArgType::SlotSource);
    // rust: if kind == "items" {
    // rust: let item = d.argument(slots, "item_predicate", ArgType::ItemPredicate);
    // rust: conditional(d, item, ex);
    // rust: } else {
    // rust: conditional(d, slots, ex);
}
}
}
}
