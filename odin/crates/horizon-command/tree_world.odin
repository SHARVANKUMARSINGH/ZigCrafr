//! Transpiled from Horizon Rust crate
package horizon_command_tree_world

import "core:fmt"
import "core:mem"
import "core:math"

// Command trees that act on entities and the world: `/recipe`, `/damage`,
// `/rotate`, `/swing`, `/playsound`, `/stopsound`, `/particle`,
// `/attribute`, `/ride`, `/spreadplayers`, `/loot`, `/forceload`,
// `/fillbiome`, `/worldborder`.
// use super::{
    // rust: Dispatcher,
    // rust: args::{ArgType, integer},
    // rust: vanilla::{ENTITIES, ENTITY, GAMEMASTERS, PLAYERS},
}
// use horizon_client_core::sound_source::SOUND_SOURCES;

float :: proc(min: f32) -> A {
    // Ported from Horizon
    return {}
}
    // rust: ArgType::Float { min, max: f32::MAX }
}
double :: proc() -> A {
    // Ported from Horizon
    return {}
}
    // rust: ArgType::Double {
    // rust: min: f64::MIN,
    // rust: max: f64::MAX,
}
}

register :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: recipe(d, root);
    // rust: damage(d, root);
    // rust: rotate_swing(d, root);
    // rust: sounds(d, root);
    // rust: particle(d, root);
    // rust: attribute(d, root);

    // ride <target> (mount <vehicle> | dismount)
    // rust: let ride = d.literal(root, "ride");
    // rust: d.requires(ride, GAMEMASTERS);
    // rust: let target = d.argument(ride, "target", ENTITY);
    // rust: let mount = d.literal(target, "mount");
    // rust: let vehicle = d.argument(mount, "vehicle", ENTITY);
    // rust: d.executes(vehicle, "ride.mount");
    // rust: let dismount = d.literal(target, "dismount");
    // rust: d.executes(dismount, "ride.dismount");

    // spreadplayers <center> <spreadDistance> <maxRange> [under <maxHeight>] <respectTeams> <targets>
    // rust: let spread = d.literal(root, "spreadplayers");
    // rust: d.requires(spread, GAMEMASTERS);
    // rust: let center = d.argument(spread, "center", ArgType::Vec2);
    // rust: let dist = d.argument(center, "spreadDistance", float(0.0));
    // rust: let range = d.argument(dist, "maxRange", float(1.0));
    // rust: let respect = d.argument(range, "respectTeams", ArgType::Bool);
    // rust: let targets = d.argument(respect, "targets", ENTITIES);
    // rust: d.executes(targets, "spreadplayers");
    // rust: let under = d.literal(range, "under");
    // rust: let height = d.argument(under, "maxHeight", integer(i32::MIN));
    // rust: let respect = d.argument(height, "respectTeams", ArgType::Bool);
    // rust: let targets = d.argument(respect, "targets", ENTITIES);
    // rust: d.executes(targets, "spreadplayers");

    // place template <template> [<pos> [<rotation> [<mirror> [<integrity> [<seed> [strict]]]]]]
    // rust: let place = d.literal(root, "place");
    // rust: d.requires(place, GAMEMASTERS);
    // rust: let feature = d.literal(place, "feature");
    // rust: let f = d.argument(
    // rust: feature,
    // rust: "feature",
    // rust: ArgType::ResourceOrId("minecraft:worldgen/feature"),
    // rust: );
    // rust: d.executes(f, "place.feature");
    // rust: let pos = d.argument(f, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "place.feature");
    // rust: let jigsaw = d.literal(place, "jigsaw");
    // rust: let pool = d.argument(
    // rust: jigsaw,
    // rust: "pool",
    // rust: ArgType::ResKey("minecraft:worldgen/template_pool"),
    // rust: );
    // rust: let target = d.argument(pool, "target", ArgType::Id("none"));
    // rust: let depth = d.argument(target, "max_depth", ArgType::Integer { min: 1, max: 20 });
    // rust: d.executes(depth, "place.jigsaw");
    // rust: let position = d.argument(depth, "position", ArgType::BlockPos);
    // rust: d.executes(position, "place.jigsaw");
    // rust: let structure = d.literal(place, "structure");
    // rust: let st = d.argument(
    // rust: structure,
    // rust: "structure",
    // rust: ArgType::ResKey("minecraft:worldgen/structure"),
    // rust: );
    // rust: d.executes(st, "place.structure");
    // rust: let pos = d.argument(st, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "place.structure");
    // rust: let template = d.literal(place, "template");
    // rust: let id = d.argument(template, "template", ArgType::Id("templates"));
    // rust: d.executes(id, "place");
    // rust: let pos = d.argument(id, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "place");
    // rust: let rotation = d.argument(
    // rust: pos,
    // rust: "rotation",
    // rust: ArgType::StrEnum(
    // rust: &["none", "clockwise_90", "180", "counterclockwise_90"],
    // rust: "argument.enum.invalid",
    // rust: ),
    // rust: );
    // rust: d.executes(rotation, "place");
    // rust: let mirror = d.argument(
    // rust: rotation,
    // rust: "mirror",
    // rust: ArgType::StrEnum(
    // rust: &["none", "left_right", "front_back"],
    // rust: "argument.enum.invalid",
    // rust: ),
    // rust: );
    // rust: d.executes(mirror, "place");
    // rust: let integrity = d.argument(mirror, "integrity", ArgType::Float { min: 0.0, max: 1.0 });
    // rust: d.executes(integrity, "place");
    // rust: let seed = d.argument(integrity, "seed", integer(i32::MIN));
    // rust: d.executes(seed, "place");
    // rust: let strict = d.literal(seed, "strict");
    // rust: d.executes(strict, "place");

    // rust: forceload(d, root);
    // rust: fillbiome(d, root);
    // rust: worldborder(d, root);
    // rust: loot(d, root);
}

recipe :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let recipe = d.literal(root, "recipe");
    // rust: d.requires(recipe, GAMEMASTERS);
    // rust: for (word, id) in [("give", "recipe.give"), ("take", "recipe.take")] {
    // rust: let w = d.literal(recipe, word);
    // rust: let t = d.argument(w, "targets", PLAYERS);
    // rust: let r = d.argument(t, "recipe", ArgType::ResKey("minecraft:recipe"));
    // rust: d.executes(r, id);
    // rust: let all = d.literal(t, "*");
    // rust: d.executes(all, id);
}
}

damage :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let damage = d.literal(root, "damage");
    // rust: d.requires(damage, GAMEMASTERS);
    // rust: let target = d.argument(damage, "target", ENTITY);
    // rust: let amount = d.argument(target, "amount", float(0.0));
    // rust: d.executes(amount, "damage");
    // rust: let ty = d.argument(amount, "damageType", ArgType::Res("minecraft:damage_type"));
    // rust: d.executes(ty, "damage");
    // rust: let at = d.literal(ty, "at");
    // rust: let loc = d.argument(at, "location", ArgType::Vec3 { center: true });
    // rust: d.executes(loc, "damage");
    // rust: let by = d.literal(ty, "by");
    // rust: let entity = d.argument(by, "entity", ENTITY);
    // rust: d.executes(entity, "damage");
    // rust: let from = d.literal(entity, "from");
    // rust: let cause = d.argument(from, "cause", ENTITY);
    // rust: d.executes(cause, "damage");
}

rotate_swing :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let rotate = d.literal(root, "rotate");
    // rust: d.requires(rotate, GAMEMASTERS);
    // rust: let target = d.argument(rotate, "target", ENTITY);
    // rust: let rot = d.argument(target, "rotation", ArgType::Rotation);
    // rust: d.executes(rot, "rotate");
    // rust: let facing = d.literal(target, "facing");
    // rust: let entity = d.literal(facing, "entity");
    // rust: let fe = d.argument(entity, "facingEntity", ENTITY);
    // rust: d.executes(fe, "rotate");
    // rust: let anchor = d.argument(fe, "facingAnchor", ArgType::Anchor);
    // rust: d.executes(anchor, "rotate");
    // rust: let loc = d.argument(facing, "facingLocation", ArgType::Vec3 { center: true });
    // rust: d.executes(loc, "rotate");

    // rust: let swing = d.literal(root, "swing");
    // rust: d.requires(swing, GAMEMASTERS);
    // rust: d.executes(swing, "swing");
    // rust: let targets = d.argument(swing, "targets", ENTITIES);
    // rust: d.executes(targets, "swing");
    // rust: for hand in ["mainhand", "offhand"] {
    // rust: let h = d.literal(targets, hand);
    // rust: d.executes(h, "swing");
    // rust: let animation = d.argument(
    // rust: h,
    // rust: "animation",
    // rust: ArgType::StrEnum(
    // rust: &["none", "whack", "stab"],
    // rust: "argument.swing_animation.invalid",
    // rust: ),
    // rust: );
    // rust: d.executes(animation, "swing");
    // rust: let duration = d.argument(animation, "duration", ArgType::Time { min: 1 });
    // rust: d.executes(duration, "swing");
}
}

sounds :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let play = d.literal(root, "playsound");
    // rust: d.requires(play, GAMEMASTERS);
    // rust: let sound = d.argument(play, "sound", ArgType::Id("sounds"));
    // rust: d.executes(sound, "playsound");
    // rust: let stop = d.literal(root, "stopsound");
    // rust: d.requires(stop, GAMEMASTERS);
    // rust: let stop_targets = d.argument(stop, "targets", PLAYERS);
    // rust: d.executes(stop_targets, "stopsound");
    // rust: let any = d.literal(stop_targets, "*");
    // rust: let any_sound = d.argument(any, "sound", ArgType::Id("sounds"));
    // rust: d.executes(any_sound, "stopsound");
    // rust: for source in SOUND_SOURCES {
    // rust: let s = d.literal(sound, source);
    // rust: d.executes(s, "playsound");
    // rust: let targets = d.argument(s, "targets", PLAYERS);
    // rust: d.executes(targets, "playsound");
    // rust: let pos = d.argument(targets, "pos", ArgType::Vec3 { center: true });
    // rust: d.executes(pos, "playsound");
    // rust: let volume = d.argument(pos, "volume", float(0.0));
    // rust: d.executes(volume, "playsound");
    // rust: let pitch = d.argument(volume, "pitch", ArgType::Float { min: 0.0, max: 2.0 });
    // rust: d.executes(pitch, "playsound");
    // rust: let min = d.argument(pitch, "minVolume", ArgType::Float { min: 0.0, max: 1.0 });
    // rust: d.executes(min, "playsound");

    // rust: let ls = d.literal(stop_targets, source);
    // rust: d.executes(ls, "stopsound");
    // rust: let lsound = d.argument(ls, "sound", ArgType::Id("sounds"));
    // rust: d.executes(lsound, "stopsound");
}
}

particle :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let particle = d.literal(root, "particle");
    // rust: d.requires(particle, GAMEMASTERS);
    // rust: let name = d.argument(particle, "name", ArgType::Particle);
    // rust: d.executes(name, "particle");
    // rust: let pos = d.argument(name, "pos", ArgType::Vec3 { center: true });
    // rust: d.executes(pos, "particle");
    // rust: let delta = d.argument(pos, "delta", ArgType::Vec3 { center: false });
    // rust: let speed = d.argument(delta, "speed", float(0.0));
    // rust: let count = d.argument(speed, "count", integer(0));
    // rust: d.executes(count, "particle");
    // rust: for mode in ["force", "normal"] {
    // rust: let m = d.literal(count, mode);
    // rust: d.executes(m, "particle");
    // rust: let viewers = d.argument(m, "viewers", PLAYERS);
    // rust: d.executes(viewers, "particle");
}
}

attribute :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let attribute = d.literal(root, "attribute");
    // rust: d.requires(attribute, GAMEMASTERS);
    // rust: let target = d.argument(attribute, "target", ENTITY);
    // rust: let attr = d.argument(target, "attribute", ArgType::Res("minecraft:attribute"));
    // rust: let get = d.literal(attr, "get");
    // rust: d.executes(get, "attribute.get");
    // rust: let scale = d.argument(get, "scale", double());
    // rust: d.executes(scale, "attribute.get");
    // rust: let base = d.literal(attr, "base");
    // rust: let set = d.literal(base, "set");
    // rust: let value = d.argument(set, "value", double());
    // rust: d.executes(value, "attribute.base.set");
    // rust: let bget = d.literal(base, "get");
    // rust: d.executes(bget, "attribute.base.get");
    // rust: let bscale = d.argument(bget, "scale", double());
    // rust: d.executes(bscale, "attribute.base.get");
    // rust: let reset = d.literal(base, "reset");
    // rust: d.executes(reset, "attribute.base.reset");
    // rust: let modifier = d.literal(attr, "modifier");
    // rust: let add = d.literal(modifier, "add");
    // rust: let id = d.argument(add, "id", ArgType::Id("attribute_modifiers"));
    // rust: let value = d.argument(id, "value", double());
    // rust: for op in ["add_value", "add_multiplied_base", "add_multiplied_total"] {
    // rust: let o = d.literal(value, op);
    // rust: d.executes(o, "attribute.modifier.add");
}
    // rust: let remove = d.literal(modifier, "remove");
    // rust: let rid = d.argument(remove, "id", ArgType::Id("attribute_modifiers"));
    // rust: d.executes(rid, "attribute.modifier.remove");
    // rust: let value_l = d.literal(modifier, "value");
    // rust: let vget = d.literal(value_l, "get");
    // rust: let vid = d.argument(vget, "id", ArgType::Id("attribute_modifiers"));
    // rust: d.executes(vid, "attribute.modifier.get");
    // rust: let vscale = d.argument(vid, "scale", double());
    // rust: d.executes(vscale, "attribute.modifier.get");
}

forceload :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let f = d.literal(root, "forceload");
    // rust: d.requires(f, GAMEMASTERS);
    // rust: for (word, id) in [("add", "forceload.add"), ("remove", "forceload.remove")] {
    // rust: let w = d.literal(f, word);
    // rust: let from = d.argument(w, "from", ArgType::ColumnPos);
    // rust: d.executes(from, id);
    // rust: let to = d.argument(from, "to", ArgType::ColumnPos);
    // rust: d.executes(to, id);
    // rust: if word == "remove" {
    // rust: let all = d.literal(w, "all");
    // rust: d.executes(all, "forceload.remove.all");
}
}
    // rust: let query = d.literal(f, "query");
    // rust: d.executes(query, "forceload.query");
    // rust: let pos = d.argument(query, "pos", ArgType::ColumnPos);
    // rust: d.executes(pos, "forceload.query");
}

fillbiome :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let f = d.literal(root, "fillbiome");
    // rust: d.requires(f, GAMEMASTERS);
    // rust: let from = d.argument(f, "from", ArgType::BlockPos);
    // rust: let to = d.argument(from, "to", ArgType::BlockPos);
    // rust: let biome = d.argument(to, "biome", ArgType::Res("minecraft:worldgen/biome"));
    // rust: d.executes(biome, "fillbiome");
    // rust: let replace = d.literal(biome, "replace");
    // rust: let filter = d.argument(
    // rust: replace,
    // rust: "filter",
    // rust: ArgType::ResOrTag("minecraft:worldgen/biome"),
    // rust: );
    // rust: d.executes(filter, "fillbiome");
}

worldborder :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let w = d.literal(root, "worldborder");
    // rust: d.requires(w, GAMEMASTERS);
    // rust: let dist = || ArgType::Double {
    // rust: min: -5.999_996_8e7,
    // rust: max: 5.999_996_8e7,
}
    // rust: for word in ["add", "set"] {
    // rust: let l = d.literal(w, word);
    // rust: let distance = d.argument(l, "distance", dist());
    // rust: let id = if word == "add" {
    // rust: "worldborder.add"
    // rust: } else {
    // rust: "worldborder.set"
}
    // rust: d.executes(distance, id);
    // rust: let time = d.argument(distance, "time", ArgType::Time { min: 0 });
    // rust: d.executes(time, id);
}
    // rust: let center = d.literal(w, "center");
    // rust: let pos = d.argument(center, "pos", ArgType::Vec2);
    // rust: d.executes(pos, "worldborder.center");
    // rust: let damage = d.literal(w, "damage");
    // rust: let amount = d.literal(damage, "amount");
    // rust: let per = d.argument(amount, "damagePerBlock", float(0.0));
    // rust: d.executes(per, "worldborder.damage.amount");
    // rust: let buffer = d.literal(damage, "buffer");
    // rust: let b = d.argument(buffer, "distance", float(0.0));
    // rust: d.executes(b, "worldborder.damage.buffer");
    // rust: let get = d.literal(w, "get");
    // rust: d.executes(get, "worldborder.get");
    // rust: let warning = d.literal(w, "warning");
    // rust: let wd = d.literal(warning, "distance");
    // rust: let v = d.argument(wd, "distance", integer(0));
    // rust: d.executes(v, "worldborder.warning.distance");
    // rust: let wt = d.literal(warning, "time");
    // rust: let v = d.argument(wt, "time", ArgType::Time { min: 0 });
    // rust: d.executes(v, "worldborder.warning.time");
}

// `loot (replace|insert|give|spawn) ... (fish|loot|kill|mine)`.
loot :: proc(d: ^Dispatcher, root: uint) {
}
    // rust: let loot = d.literal(root, "loot");
    // rust: d.requires(loot, GAMEMASTERS);
    // Targets.
    // rust: let mut targets = Vec::new();
    // rust: let replace = d.literal(loot, "replace");
    // rust: for provider in ["entity", "block"] {
    // rust: let p = d.literal(replace, provider);
    // rust: let a = if provider == "entity" {
    // rust: d.argument(p, "entities", ENTITIES)
    // rust: } else {
    // rust: d.argument(p, "targetPos", ArgType::BlockPos)
}
    // rust: let slot = d.argument(a, "slot", ArgType::Slot);
    // rust: targets.push(slot);
    // rust: let count = d.argument(slot, "count", integer(0));
    // rust: targets.push(count);
}
    // rust: let insert = d.literal(loot, "insert");
    // rust: targets.push(d.argument(insert, "targetPos", ArgType::BlockPos));
    // rust: let give = d.literal(loot, "give");
    // rust: targets.push(d.argument(give, "players", PLAYERS));
    // rust: let spawn = d.literal(loot, "spawn");
    // rust: targets.push(d.argument(spawn, "targetPos", ArgType::Vec3 { center: true }));
    // Sources.
    // rust: for t in targets {
    // rust: let fish = d.literal(t, "fish");
    // rust: let table = d.argument(
    // rust: fish,
    // rust: "loot_table",
    // rust: ArgType::ResourceOrId("minecraft:loot_table"),
    // rust: );
    // rust: let pos = d.argument(table, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "loot.fish");
    // rust: for hand in ["mainhand", "offhand"] {
    // rust: let h = d.literal(pos, hand);
    // rust: d.executes(h, "loot.fish");
}
    // rust: let tool = d.argument(pos, "tool", ArgType::Item);
    // rust: d.executes(tool, "loot.fish");
    // rust: let l = d.literal(t, "loot");
    // rust: let lt = d.argument(
    // rust: l,
    // rust: "loot_table",
    // rust: ArgType::ResourceOrId("minecraft:loot_table"),
    // rust: );
    // rust: d.executes(lt, "loot.loot");
    // rust: let kill = d.literal(t, "kill");
    // rust: let target = d.argument(kill, "target", ENTITY);
    // rust: d.executes(target, "loot.kill");
    // rust: let mine = d.literal(t, "mine");
    // rust: let pos = d.argument(mine, "pos", ArgType::BlockPos);
    // rust: d.executes(pos, "loot.mine");
    // rust: for hand in ["mainhand", "offhand"] {
    // rust: let h = d.literal(pos, hand);
    // rust: d.executes(h, "loot.mine");
}
    // rust: let tool = d.argument(pos, "tool", ArgType::Item);
    // rust: d.executes(tool, "loot.mine");
}
}
