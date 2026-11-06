//! Transpiled from Horizon Rust crate
package horizon_command_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{args::*, vanilla, *};

reg :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Registries {
    // rust: permission: 4,
    // rust: ..Registries::default()
}
    // rust: r.items = vec![
    // rust: "minecraft:diamond".into(),
    // rust: "minecraft:diamond_sword".into(),
    // rust: "minecraft:stone".into(),
    // rust: ];
    // rust: r.blocks.insert("minecraft:stone".into(), vec![]);
    // rust: r.blocks.insert(
    // rust: "minecraft:oak_stairs".into(),
    // rust: vec![
    // rust: ("facing".into(), vec!["north".into(), "south".into()]),
    // rust: ("half".into(), vec!["top".into(), "bottom".into()]),
    // rust: ],
    // rust: );
    // rust: r.summonable = vec!["minecraft:pig".into(), "minecraft:zombie".into()];
    // rust: r.entity_types = vec![
    // rust: "minecraft:pig".into(),
    // rust: "minecraft:player".into(),
    // rust: "minecraft:zombie".into(),
    // rust: ];
    // rust: r.players = vec!["Player".into()];
    // rust: r.dimensions = vec!["minecraft:overworld".into()];
    // rust: r.time_markers = vec!["minecraft:day".into(), "minecraft:noon".into()];
    // The registry elements the commands below name (vanilla checks them while parsing).
    // rust: let mut registry = |name: &str, ids: &[&str]| {
    // rust: r.by_registry.insert(
    // rust: name.into(),
    // rust: RegistryIds {
    // rust: ids: ids.iter().map(|s| (*s).to_owned()).collect(),
    // rust: tags: Vec::new(),
    // rust: },
    // rust: );
}
    // rust: registry(
    // rust: "minecraft:worldgen/biome",
    // rust: &["minecraft:desert", "minecraft:plains"],
    // rust: );
    // rust: registry(
    // rust: "minecraft:damage_type",
    // rust: &["minecraft:fall", "minecraft:magic"],
    // rust: );
    // rust: registry(
    // rust: "minecraft:attribute",
    // rust: &["minecraft:max_health", "minecraft:scale"],
    // rust: );
    // rust: registry("minecraft:item_modifier", &["a:b"]);
    // rust: registry("minecraft:predicate", &["a:b"]);
    // rust: registry(
    // rust: "minecraft:loot_table",
    // rust: &[
    // rust: "minecraft:chests/simple_dungeon",
    // rust: "minecraft:chests/x",
    // rust: "minecraft:gameplay/fishing",
    // rust: ],
    // rust: );
    // rust: registry(
    // rust: "minecraft:entity_type",
    // rust: &["minecraft:pig", "minecraft:player", "minecraft:zombie"],
    // rust: );
    // rust: registry(
    // rust: "minecraft:item",
    // rust: &[
    // rust: "minecraft:diamond",
    // rust: "minecraft:diamond_sword",
    // rust: "minecraft:stone",
    // rust: ],
    // rust: );
    // rust: r
}
run :: proc(input: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let reg = reg();
    // rust: let parse = vanilla::dispatcher().parse(input, &reg);
    // rust: let (ctx, id) = parse.executable()?;
    // rust: Ok((
    // rust: id.to_owned(),
    // rust: ctx.args.iter().map(|a| a.name.clone()).collect(),
    // rust: ))
}
suggestions :: proc(input: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let reg = reg();
    // rust: let d = vanilla::dispatcher();
    // rust: let parse = d.parse(input, &reg);
    // rust: d.suggestions(&parse, input.len(), &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect()
}

reader_matches_brigadier :: proc() {
}
    // rust: let mut r = Reader::new("12 -3.5 abc \"q\\\"x\" true");
    // rust: assert_eq!(r.read_int().unwrap(), 12);
    // rust: r.skip();
    // rust: assert_eq!(r.read_double().unwrap(), -3.5);
    // rust: r.skip();
    // rust: assert_eq!(r.read_unquoted_string(), "abc");
    // rust: r.skip();
    // rust: assert_eq!(r.read_string().unwrap(), "q\"x");
    // rust: r.skip();
    // rust: assert!(r.read_boolean().unwrap());
    // rust: let e = Reader::new("1.5").read_int().unwrap_err();
    // rust: assert_eq!(e.message.plain(), "parsing.int.invalid");
    // rust: assert_eq!(e.context().unwrap(), "<--[HERE]");
}
parses_vanilla_commands :: proc() {
}
    // rust: assert_eq!(run("gamemode creative").unwrap().0, "gamemode");
    // rust: assert_eq!(
    // rust: run("gamemode creative @s").unwrap().1,
    // rust: ["gamemode", "target"]
    // rust: );
    // rust: assert_eq!(
    // rust: run("give @s minecraft:diamond 64").unwrap().1,
    // rust: ["targets", "item", "count"]
    // rust: );
    // rust: assert_eq!(run("tp 1 2 3").unwrap().0, "teleport.location");
    // rust: assert_eq!(run("tp Player").unwrap().0, "teleport.destination");
    // rust: assert_eq!(run("tp @s ~ ~10 ~").unwrap().0, "teleport.targets.location");
    // rust: assert_eq!(
    // rust: run("teleport @e[type=pig,limit=2] ^ ^ ^5 90 0").unwrap().0,
    // rust: "teleport.targets.location"
    // rust: );
    // rust: assert_eq!(run("time set 1000").unwrap().0, "time.set");
    // rust: assert_eq!(run("time set 1d").unwrap().0, "time.set");
    // rust: assert_eq!(run("time set day").unwrap().0, "time.set.marker");
    // rust: assert_eq!(run("time query gametime").unwrap().0, "time.query.gametime");
    // rust: assert_eq!(run("weather rain 10s").unwrap().0, "weather");
    // rust: assert_eq!(run("xp add @s 5 levels").unwrap().0, "experience");
    // rust: assert_eq!(run("gamerule keep_inventory true").unwrap().0, "gamerule");
    // rust: assert_eq!(
    // rust: run("gamerule minecraft:random_tick_speed 10").unwrap().0,
    // rust: "gamerule"
    // rust: );
    // rust: assert_eq!(run("fill ~ ~ ~ ~1 ~1 ~1 stone hollow").unwrap().0, "fill");
    // rust: assert_eq!(
    // rust: run("fill 0 0 0 1 1 1 minecraft:oak_stairs[facing=north] replace stone")
    // rust: .unwrap()
    // rust: .0,
    // rust: "fill"
    // rust: );
    // rust: assert_eq!(
    // rust: run("clone 0 0 0 1 1 1 5 5 5 masked move").unwrap().0,
    // rust: "clone"
    // rust: );
    // rust: assert_eq!(
    // rust: run("setblock ~ ~1 ~ oak_stairs[half=top] keep").unwrap().0,
    // rust: "setblock"
    // rust: );
    // rust: assert_eq!(run("summon zombie ~ ~ ~ {NoAI:1b}").unwrap().0, "summon");
    // rust: assert_eq!(run("difficulty hard").unwrap().0, "difficulty");
    // rust: assert_eq!(run("say hello @p").unwrap().0, "say");
    // rust: let reg = reg();
    // rust: let parse =
    // rust: vanilla::dispatcher().parse("clone 0 0 0 1 1 1 5 5 5 strict filtered stone force", &reg);
    // rust: let (ctx, _) = parse.executable().unwrap();
    // rust: assert!(ctx.has("strict") && ctx.has("filtered") && ctx.has("force") && !ctx.has("move"));
}
vanilla_error_messages :: proc() {
}
    // rust: let e = run("foo").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command");
    // rust: assert_eq!(e.cursor, 0);
    // rust: let e = run("gamemode").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command");
    // rust: let e = run("gamemode creatve").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.gamemode.invalid");
    // GameModeArgument reports the error after the word.
    // rust: assert_eq!(e.cursor, 16);
    // rust: let e = run("give @s minecraft:dirt").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.item.id.invalid");
    // rust: let e = run("give @s diamond 0").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.integer.low");
    // rust: let e = run("gamemode creative @e").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.player.entities");
    // rust: let e = run("setblock 1 2").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.pos3d.incomplete");
    // rust: let e = run("setblock 1 2 3 oak_stairs[facing=up]").unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.block.property.invalid");
}
commands_need_allow_commands :: proc() {
}
    // IntegratedServer.getProfilePermissions: the owner of a world without
    // Allow Commands is at LevelBasedPermissionSet.ALL.
    // rust: let reg = Registries {
    // rust: permission: 0,
    // rust: ..reg()
}
    // rust: let d = vanilla::game_dispatcher();
    // rust: let e = d.parse("gamemode creative", &reg).executable().unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command");
    // rust: assert!(d.parse("me waves", &reg).executable().is_ok());
    // rust: let parse = d.parse("", &reg);
    // Brigadier itself lists every literal; the chat's (client tree) only
    // the ones the player may use.
    // rust: assert!(
    // rust: d.suggestions(&parse, 0, &reg)
    // rust: .1
    // rust: .iter()
    // rust: .any(|s| s.text == "gamemode")
    // rust: );
    // rust: let root: Vec<String> = d
    // rust: .client_suggestions(&parse, 0, &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect();
    // Commands.java with CommandSelection.INTEGRATED: seed and version need no
    // level (a dedicated server's tree: a_dedicated_server_keeps_seed_and_version_for_game_masters).
    // rust: assert_eq!(
    // rust: root,
    // rust: [
    // rust: "help", "list", "me", "msg", "random", "seed", "teammsg", "tell", "tm", "trigger",
    // rust: "version", "w"
    // rust: ]
    // rust: );
}
suggestions_like_vanilla :: proc() {
}
    // rust: let root = suggestions("");
    // rust: assert!(root.contains(&"gamemode".to_owned()) && root.contains(&"tp".to_owned()));
    // rust: assert_eq!(suggestions("game"), ["gamemode", "gamerule"]);
    // rust: assert_eq!(
    // rust: suggestions("gamemode "),
    // rust: ["adventure", "creative", "spectator", "survival"]
    // rust: );
    // rust: assert_eq!(suggestions("gamemode c"), ["creative"]);
    // rust: assert_eq!(
    // rust: suggestions("give @s dia"),
    // rust: ["minecraft:diamond", "minecraft:diamond_sword"]
    // rust: );
    // Underscore-separated parts match too (SharedSuggestionProvider.matchesSubStr).
    // rust: assert_eq!(suggestions("give @s sword"), ["minecraft:diamond_sword"]);
    // rust: assert_eq!(suggestions("kill @"), ["@a", "@e", "@n", "@p", "@r", "@s"]);
    // rust: assert_eq!(suggestions("kill @e"), ["["]);
    // rust: assert_eq!(suggestions("kill @e[ty"), ["type="]);
    // rust: assert!(suggestions("kill @e[type=").contains(&"minecraft:zombie".to_owned()));
    // rust: assert_eq!(suggestions("kill @e[type=pig"), [",", "]"]);
    // rust: assert_eq!(suggestions("setblock 0 0 0 oak_stairs[fa"), ["facing="]);
    // BlockStateParser suggests every value of the property, unfiltered.
    // rust: assert_eq!(
    // rust: suggestions("setblock 0 0 0 oak_stairs[facing=n"),
    // rust: ["north", "south"]
    // rust: );
    // rust: assert_eq!(
    // rust: suggestions("tp "),
    // rust: [
    // rust: "@a", "@e", "@n", "@p", "@r", "@s", "Player", "~", "~ ~", "~ ~ ~"
    // rust: ]
    // rust: );
    // rust: assert_eq!(suggestions("time set 5"), ["d", "s", "t"]);
    // rust: assert!(suggestions("time set ").contains(&"minecraft:day".to_owned()));
}
// ClientSuggestionProvider: block and column positions offer the targeted
// block (`getRelevantCoordinates`), `Vec3` and `Vec2` the exact hit point
// with two decimals (`getAbsoluteCoordinates`); with no block hit, `~`.
coordinates_suggest_the_crosshair_block_or_hit_point :: proc() {
}
    // rust: let d = vanilla::dispatcher();
    // rust: let suggest = |reg: &Registries, input: &str| -> Vec<String> {
    // rust: let parse = d.parse(input, reg);
    // rust: d.suggestions(&parse, input.len(), reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect()
}
    // rust: let mut hit = reg();
    // rust: hit.target_block = Some([-29, 73, 8]);
    // rust: hit.target_point = Some(["-28.77".into(), "73.28".into(), "8.00".into()]);
    // rust: assert_eq!(suggest(&hit, "setblock "), ["-29", "-29 73", "-29 73 8"]);
    // rust: assert_eq!(
    // rust: suggest(&hit, "summon minecraft:pig "),
    // rust: ["-28.77", "-28.77 73.28", "-28.77 73.28 8.00"]
    // rust: );
    // rust: assert_eq!(
    // rust: suggest(&hit, "summon minecraft:pig -28.77 "),
    // rust: ["-28.77 73.28", "-28.77 73.28 8.00"]
    // rust: );
    // Vec2Argument: x and z.
    // rust: assert_eq!(
    // rust: suggest(&hit, "worldborder center "),
    // rust: ["-28.77", "-28.77 8.00"]
    // rust: );
    // An entity in front of the block (or no hit): the defaults.
    // rust: let none = reg();
    // rust: assert_eq!(suggest(&none, "setblock "), ["~", "~ ~", "~ ~ ~"]);
    // rust: assert_eq!(
    // rust: suggest(&none, "summon minecraft:pig "),
    // rust: ["~", "~ ~", "~ ~ ~"]
    // rust: );
}
entity_arguments_suggest_the_selected_entity :: proc() {
}
    // EntityArgument.listSuggestions: getSelectedEntities (the crosshair
    // entity's UUID) joins the player names unless the argument takes
    // players only; GameProfileArgument and ScoreHolderArgument never ask.
    // rust: let uuid = "0b9c6a7e-3d1f-4a2b-9c8d-7e6f5a4b3c2d";
    // rust: let mut reg = reg();
    // rust: reg.selected_entities = vec![uuid.into()];
    // rust: let d = vanilla::dispatcher();
    // rust: let suggest = |input: &str| -> Vec<String> {
    // rust: let parse = d.parse(input, &reg);
    // rust: d.suggestions(&parse, input.len(), &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect()
}
    // rust: assert_eq!(
    // rust: suggest("tp "),
    // rust: [
    // rust: "0b9c6a7e-3d1f-4a2b-9c8d-7e6f5a4b3c2d",
    // rust: "@a",
    // rust: "@e",
    // rust: "@n",
    // rust: "@p",
    // rust: "@r",
    // rust: "@s",
    // rust: "Player",
    // rust: "~",
    // rust: "~ ~",
    // rust: "~ ~ ~"
    // rust: ]
    // rust: );
    // rust: assert!(suggest("kill ").contains(&uuid.to_owned()));
    // rust: assert_eq!(suggest("kill 0b9"), [uuid]);
    // rust: for players_only in ["gamemode creative ", "op ", "scoreboard players set "] {
    // rust: assert!(
    // rust: !suggest(players_only).contains(&uuid.to_owned()),
    // rust: "{players_only}"
    // rust: );
}
}
whitespace_is_what_java_character_is_whitespace_says :: proc() {
}
    // rust: let java: Vec<u32> = [
    // rust: 0x09..=0x0D,
    // rust: 0x1C..=0x20,
    // rust: 0x1680..=0x1680,
    // rust: 0x2000..=0x2006,
    // rust: 0x2008..=0x200A,
    // rust: 0x2028..=0x2029,
    // rust: 0x205F..=0x205F,
    // rust: 0x3000..=0x3000,
    // rust: ]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .collect();
    // rust: let ours: Vec<u32> = (0..=0x10FFFF)
    // rust: .filter_map(char::from_u32)
    // rust: .filter(|c| Reader::is_java_whitespace(*c))
    // rust: .map(u32::from)
    // rust: .collect();
    // rust: assert_eq!(ours, java);

    // rust: let mut r = Reader::new("\u{1F}\u{3000} x");
    // rust: r.skip_whitespace();
    // rust: assert_eq!(r.peek(), 'x');
    // rust: for nbsp in ["\u{A0}", "\u{2007}", "\u{202F}", "\u{85}"] {
    // rust: let text = format!("{nbsp}x");
    // rust: let mut r = Reader::new(&text);
    // rust: r.skip_whitespace();
    // rust: assert_eq!(r.remaining(), text, "{:?} is not whitespace", nbsp);
}

    // rust: let reg = reg();
    // rust: let parse = |text: &str| selector::parse(&mut Reader::new(text), &reg, true).is_ok();
    // rust: assert!(parse("@e[ type=minecraft:pig]"));
    // rust: assert!(parse("@e[\u{1F}type=minecraft:pig]"));
    // rust: assert!(!parse("@e[\u{A0}type=minecraft:pig]"));
}
a_uuid_selects_by_entity_uuid :: proc() {
}
    // EntitySelectorParser.parseNameOrUUID: a UUID sets entityUUID and
    // includesEntities, never playerName (which findEntities checks first).
    // rust: let reg = reg();
    // rust: let mut r = Reader::new("2de5a9ad-2740-4058-835e-cf255e0d7798");
    // rust: let s = selector::parse(&mut r, &reg, true).unwrap();
    // rust: assert_eq!(s.uuid, Some(0x2de5a9ad_2740_4058_835e_cf255e0d7798));
    // rust: assert!(s.include_entities && s.player_name.is_none());
    // rust: let mut r = Reader::new("Steve");
    // rust: let s = selector::parse(&mut r, &reg, true).unwrap();
    // rust: assert_eq!((s.uuid, s.player_name.as_deref()), (None, Some("Steve")));
}
smart_usage_matches_brigadier :: proc() {
}
    // rust: let d = vanilla::dispatcher();
    // rust: let usage = |name: &str| {
    // rust: d.smart_usage(0, 4)
    // rust: .into_iter()
    // rust: .find(|(n, _)| d.nodes[*n].name() == name)
    // rust: .unwrap()
    // rust: .1
}
    // rust: assert_eq!(usage("gamemode"), "gamemode <gamemode> [<target>]");
    // rust: assert_eq!(usage("give"), "give <targets> <item> [<count>]");
    // rust: assert_eq!(usage("kill"), "kill [<targets>]");
    // rust: assert_eq!(usage("weather"), "weather (clear|rain|thunder)");
    // rust: assert_eq!(usage("tp"), "tp -> teleport");
    // rust: assert_eq!(
    // rust: usage("difficulty"),
    // rust: "difficulty [peaceful|easy|normal|hard]"
    // rust: );
}
local_coordinates_follow_view :: proc() {
}
    // Facing south (yaw 0) moves +Z.
    // rust: let p = Coordinates::Local([0.0, 0.0, 2.0]).position([0.0, 64.0, 0.0], [0.0, 0.0]);
    // rust: assert!((p[2] - 2.0).abs() < 1e-6 && p[0].abs() < 1e-6);
    // ^1 (left) while facing south is +X.
    // rust: let p = Coordinates::Local([1.0, 0.0, 0.0]).position([0.0, 64.0, 0.0], [0.0, 0.0]);
    // rust: assert!((p[0] - 1.0).abs() < 1e-6, "{p:?}");
    // rust: let w = Coordinates::World([
    // rust: Coord {
    // rust: relative: true,
    // rust: value: 1.0,
    // rust: },
    // rust: Coord {
    // rust: relative: false,
    // rust: value: 5.0,
    // rust: },
    // rust: Coord {
    // rust: relative: true,
    // rust: value: 0.0,
    // rust: },
    // rust: ]);
    // rust: assert_eq!(w.position([10.0, 64.0, 3.0], [0.0, 0.0]), [11.0, 5.0, 3.0]);
}

data_and_tag_commands_parse :: proc() {
}
    // rust: let (id, args) = run("data get entity @s Pos 2.5").unwrap();
    // rust: assert_eq!(id, "data.get");
    // rust: assert_eq!(args, ["target", "path", "scale"]);
    // rust: assert_eq!(run("data get block ~ ~ ~ Items[0]").unwrap().0, "data.get");
    // rust: assert_eq!(
    // rust: run("item modify entity @s weapon.mainhand a:b").unwrap().0,
    // rust: "item.modify"
    // rust: );
    // rust: assert_eq!(
    // rust: run("item modify block 1 2 3 container.0 a:b").unwrap().0,
    // rust: "item.modify"
    // rust: );
    // rust: assert_eq!(run("data get storage my:store").unwrap().0, "data.get");
    // rust: assert_eq!(run("data merge storage a:b {x:1}").unwrap().0, "data.merge");
    // rust: assert_eq!(
    // rust: run("data remove entity @s foo.bar[1]").unwrap().0,
    // rust: "data.remove"
    // rust: );
    // rust: let (id, args) = run("data modify storage a:b x.y insert 2 from entity @s Pos[0]").unwrap();
    // rust: assert_eq!(id, "data.modify");
    // rust: assert_eq!(
    // rust: args,
    // rust: ["target", "targetPath", "index", "source", "sourcePath"]
    // rust: );
    // rust: assert_eq!(
    // rust: run("data modify block 1 2 3 Text1 set string storage a:b x 1 3")
    // rust: .unwrap()
    // rust: .0,
    // rust: "data.modify"
    // rust: );
    // rust: assert_eq!(
    // rust: run("data modify storage a:b l append value [1,2]")
    // rust: .unwrap()
    // rust: .0,
    // rust: "data.modify"
    // rust: );
    // rust: assert!(run("data modify storage a:b l explode value 1").is_err());
    // rust: assert!(run("data get storage a:b {broken").is_err());
    // rust: assert!(run("data merge storage a:b 5").is_err());
    // rust: assert_eq!(run("tag @e[tag=!x] add foo").unwrap().0, "tag.add");
    // rust: assert_eq!(run("tag @s list").unwrap().0, "tag.list");
    // Selector options added for scoreboards and NBT.
    // rust: assert!(run("kill @e[scores={a=1..},team=red,nbt={x:1b},tag=t]").is_ok());
    // rust: assert!(run("kill @e[scores={a=1..]").is_err());
}

smoke_commands_parse :: proc() {
}
    // rust: for line in [
    // rust: "tag @s list",
    // rust: "random value 1..6",
    // rust: "team list",
    // rust: "data get storage a:b",
    // rust: "scoreboard objectives list",
    // rust: "function test:a",
    // rust: "execute store result score #r t run function test:a",
    // rust: "schedule function test:a 20t",
    // rust: "datapack list",
    // rust: "bossbar list",
    // rust: "item replace entity @s hotbar.0 with minecraft:stone 3",
    // rust: ] {
    // rust: assert!(run(line).is_ok(), "{line}: {:?}", run(line).err());
}
}

execute_tree_covers_vanilla_forms :: proc() {
}
    // rust: for line in [
    // rust: "execute as @a at @s run say hi",
    // rust: "execute store result score @s x run data get entity @s Health",
    // rust: "execute store success bossbar minecraft:b value run say hi",
    // rust: "execute store result storage a:b out int 1.5 run time query gametime",
    // rust: "execute store result entity @s Air short 1 run say hi",
    // rust: "execute if score @s a = @s b run say hi",
    // rust: "execute unless score @s a matches ..5 run say hi",
    // rust: "execute if block ~ ~ ~ minecraft:stone",
    // rust: "execute if blocks 0 0 0 1 1 1 5 5 5 masked run say hi",
    // rust: "execute if biome ~ ~ ~ minecraft:plains",
    // rust: "execute if loaded ~ ~ ~",
    // rust: "execute if dimension minecraft:overworld",
    // rust: "execute if data entity @s Inventory[0]",
    // rust: "execute unless data storage a:b x run say hi",
    // rust: "execute if predicate a:b",
    // rust: "execute if function a:b run say hi",
    // rust: "execute if items entity @s hotbar.* minecraft:stone",
    // rust: "execute if slots block 0 0 0 container.*",
    // rust: "execute positioned over world_surface run say hi",
    // rust: "execute summon minecraft:pig run say hi",
    // rust: "execute on vehicle run say hi",
    // rust: "execute on passengers as @s run say hi",
    // rust: "execute rotated as @s facing entity @s eyes align xyz anchored feet in minecraft:overworld run say hi",
    // rust: ] {
    // rust: assert!(run(line).is_ok(), "{line}: {:?}", run(line).err());
}
    // rust: assert!(run("execute positioned over nothing run say hi").is_err());
    // rust: assert!(run("execute on nobody run say hi").is_err());
    // rust: assert!(run("execute store result score @s").is_err());
}

function_and_misc_trees :: proc() {
}
    // rust: assert_eq!(run("function a:b").unwrap().0, "function");
    // rust: assert_eq!(run("function #a:tag {x:1}").unwrap().0, "function");
    // rust: assert_eq!(
    // rust: run("function a:b with storage c:d path.x").unwrap().0,
    // rust: "function"
    // rust: );
    // rust: assert_eq!(run("return 5").unwrap().0, "return.value");
    // rust: assert_eq!(run("return fail").unwrap().0, "return.fail");
    // rust: assert_eq!(run("return run say hi").unwrap().0, "say");
    // rust: assert_eq!(
    // rust: run("schedule function a:b 5s append").unwrap().0,
    // rust: "schedule.function"
    // rust: );
    // rust: assert_eq!(run("schedule clear a:b").unwrap().0, "schedule.clear");
    // rust: assert_eq!(run("random roll 1..20").unwrap().0, "random.roll");
    // rust: assert_eq!(
    // rust: run("random reset * 5 true false").unwrap().0,
    // rust: "random.reset"
    // rust: );
    // rust: assert_eq!(run("teammsg hi there").unwrap().0, "teammsg");
    // rust: assert_eq!(run("tm hi").unwrap().0, "teammsg");
    // rust: assert_eq!(
    // rust: run("bossbar set a:b color pink").unwrap().0,
    // rust: "bossbar.set.color"
    // rust: );
    // rust: assert_eq!(
    // rust: run("bossbar set a:b players @a").unwrap().0,
    // rust: "bossbar.set.players"
    // rust: );
    // rust: assert_eq!(run("bossbar get a:b max").unwrap().0, "bossbar.get");
    // rust: assert_eq!(
    // rust: run("item fill block 1 2 3 container.* with minecraft:stone 5")
    // rust: .unwrap()
    // rust: .0,
    // rust: "item"
    // rust: );
    // rust: assert_eq!(
    // rust: run("item replace entity @s armor.head from block 0 0 0 container.3")
    // rust: .unwrap()
    // rust: .0,
    // rust: "item"
    // rust: );
    // rust: assert_eq!(run("tick rate 40").unwrap().0, "tick.rate");
    // rust: assert_eq!(run("tick step 1s").unwrap().0, "tick.step");
    // rust: assert_eq!(run("reload").unwrap().0, "reload");
    // rust: assert_eq!(
    // rust: run("datapack enable \"file/x\" after \"file/y\"")
    // rust: .unwrap()
    // rust: .0,
    // rust: "datapack.enable"
    // rust: );
    // rust: assert!(run("bossbar set a:b value -1").is_err());
    // rust: assert!(run("item replace entity @s nowhere.0 with minecraft:stone").is_err());
}

world_command_trees :: proc() {
}
    // rust: for (line, id) in [
    // rust: ("recipe give @s *", "recipe.give"),
    // rust: ("recipe take @a minecraft:stick", "recipe.take"),
    // rust: ("damage @e[limit=1] 5", "damage"),
    // rust: (
    // rust: "damage @s 3.5 minecraft:magic by @e[limit=1] from @s",
    // rust: "damage",
    // rust: ),
    // rust: ("damage @s 3 minecraft:fall at ~ ~ ~", "damage"),
    // rust: ("rotate @s 90 0", "rotate"),
    // rust: ("rotate @s facing entity @e[limit=1] eyes", "rotate"),
    // rust: ("rotate @s facing 0 64 0", "rotate"),
    // rust: ("swing", "swing"),
    // rust: ("swing @e offhand whack 10", "swing"),
    // rust: ("playsound minecraft:entity.cow.ambient", "playsound"),
    // rust: (
    // rust: "playsound minecraft:block.stone.break block @s ~ ~ ~ 1 1 0.5",
    // rust: "playsound",
    // rust: ),
    // rust: ("stopsound @s", "stopsound"),
    // rust: ("stopsound @s * minecraft:ambient.cave", "stopsound"),
    // rust: ("stopsound @s music minecraft:music.game", "stopsound"),
    // rust: ("particle minecraft:smoke", "particle"),
    // rust: (
    // rust: "particle minecraft:dust{color:[1.0,0.0,0.0],scale:2.0} ~ ~ ~ 0.1 0.1 0.1 0 10 force @a",
    // rust: "particle",
    // rust: ),
    // rust: (
    // rust: "particle minecraft:block{block_state:\"minecraft:stone\"} ~ ~ ~",
    // rust: "particle",
    // rust: ),
    // rust: ("attribute @s minecraft:max_health get 2", "attribute.get"),
    // rust: (
    // rust: "attribute @s minecraft:max_health base set 40",
    // rust: "attribute.base.set",
    // rust: ),
    // rust: (
    // rust: "attribute @s minecraft:scale modifier add a:b 1.5 add_multiplied_base",
    // rust: "attribute.modifier.add",
    // rust: ),
    // rust: (
    // rust: "attribute @s minecraft:scale modifier remove a:b",
    // rust: "attribute.modifier.remove",
    // rust: ),
    // rust: (
    // rust: "attribute @s minecraft:scale modifier value get a:b 2",
    // rust: "attribute.modifier.get",
    // rust: ),
    // rust: ("ride @s mount @e[limit=1]", "ride.mount"),
    // rust: ("ride @s dismount", "ride.dismount"),
    // rust: ("spreadplayers 0 0 5 20 false @a", "spreadplayers"),
    // rust: ("spreadplayers ~ ~ 5 20 under 100 true @e", "spreadplayers"),
    // rust: ("forceload add 0 0 100 100", "forceload.add"),
    // rust: ("forceload remove all", "forceload.remove.all"),
    // rust: ("forceload query", "forceload.query"),
    // rust: ("forceload query ~ ~", "forceload.query"),
    // rust: (
    // rust: "fillbiome 0 0 0 10 10 10 minecraft:plains replace minecraft:desert",
    // rust: "fillbiome",
    // rust: ),
    // rust: ("worldborder set 100 5s", "worldborder.set"),
    // rust: ("worldborder add -10", "worldborder.add"),
    // rust: ("worldborder center 5 5", "worldborder.center"),
    // rust: ("worldborder damage amount 1", "worldborder.damage.amount"),
    // rust: ("worldborder warning time 10s", "worldborder.warning.time"),
    // rust: ("worldborder get", "worldborder.get"),
    // rust: (
    // rust: "loot give @s loot minecraft:chests/simple_dungeon",
    // rust: "loot.loot",
    // rust: ),
    // rust: ("loot spawn ~ ~ ~ kill @e[limit=1]", "loot.kill"),
    // rust: ("loot insert 0 0 0 mine 1 2 3 mainhand", "loot.mine"),
    // rust: (
    // rust: "loot replace entity @s hotbar.0 3 fish minecraft:gameplay/fishing 0 0 0",
    // rust: "loot.fish",
    // rust: ),
    // rust: (
    // rust: "loot replace block 1 2 3 container.5 loot minecraft:chests/x",
    // rust: "loot.loot",
    // rust: ),
    // rust: ] {
    // rust: assert_eq!(
    // rust: run(line).unwrap_or_else(|e| panic!("{line}: {e:?}")).0,
    // rust: id,
    // rust: "{line}"
    // rust: );
}
    // rust: assert!(run("playsound minecraft:x invalid_source").is_err());
    // rust: assert!(run("particle minecraft:not_a_particle").is_err());
    // rust: assert!(run("damage @s -1").is_err());
    // rust: assert!(run("spreadplayers 0 0 5 0 false @a").is_err());
    // rust: assert!(run("worldborder warning distance -1").is_err());
}

place_template_tree :: proc() {
}
    // rust: for line in [
    // rust: "place template minecraft:igloo/top",
    // rust: "place template minecraft:igloo/top ~ ~ ~",
    // rust: "place template minecraft:igloo/top 1 2 3 clockwise_90 left_right 0.5 12 strict",
    // rust: ] {
    // rust: assert_eq!(
    // rust: run(line).unwrap_or_else(|e| panic!("{line}: {e:?}")).0,
    // rust: "place"
    // rust: );
}
    // rust: assert!(run("place template minecraft:x ~ ~ ~ sideways").is_err());
    // rust: assert!(run("place template minecraft:x ~ ~ ~ none none 2").is_err());
}
mod_commands_join_the_tree_for_every_player :: proc() {
}
    // rust: let reg = Registries {
    // rust: permission: 0,
    // rust: ..reg()
}
    // rust: let d = vanilla::game_dispatcher().with_mod_commands(["where"]);
    // rust: for line in ["where", "where north 12"] {
    // rust: let parse = d.parse(line, &reg);
    // rust: assert_eq!(parse.executable().unwrap().1, MOD_COMMAND, "{line}");
}
    // rust: let parse = d.parse("w", &reg);
    // rust: let names: Vec<String> = d
    // rust: .client_suggestions(&parse, 1, &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect();
    // rust: assert!(names.contains(&"where".to_owned()), "{names:?}");
    // The game's own tree is left as it was.
    // rust: assert!(vanilla::game_dispatcher().find("where").is_none());
}

horizon_commands_are_off_unless_the_server_turns_them_on :: proc() {
}
    // By default the game runs vanilla's tree: /help lists no /pregen.
    // rust: assert!(vanilla::game_dispatcher().find("pregen").is_none());
    // rust: for dev in [false, true] {
    // rust: let vanilla_tree = vanilla::game_tree(dev, false, false);
    // rust: assert!(vanilla_tree.find("pregen").is_none());
    // rust: let d = vanilla::game_tree(dev, true, false);
    // rust: let parse = d.parse("pregen start 100 circle", &reg());
    // rust: assert_eq!(parse.executable().unwrap().1, "pregen.start");
        // Vanilla's commands are the same with or without it.
    // rust: assert_eq!(
    // rust: d.nodes[0].children.len(),
    // rust: vanilla_tree.nodes[0].children.len() + 1
    // rust: );
}
}
// `run` on a dedicated server's tree.
run_dedicated :: proc(input: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let reg = reg();
    // rust: let parse = vanilla::game_tree(true, false, true).parse(input, &reg);
    // rust: let (ctx, id) = parse.executable()?;
    // rust: Ok((
    // rust: id.to_owned(),
    // rust: ctx.args.iter().map(|a| a.name.clone()).collect(),
    // rust: ))
}
profile_commands_parse_like_vanilla :: proc() {
}
    // OpCommand, DeOpCommands, BanPlayerCommands, PardonCommand and
    // WhitelistCommand: GameProfileArgument targets, admins only.
    // rust: let run = run_dedicated;
    // rust: assert_eq!(run("op Steve").unwrap().0, "op");
    // rust: assert_eq!(run("deop @a").unwrap().0, "deop");
    // rust: assert_eq!(run("pardon Steve").unwrap().0, "pardon");
    // rust: assert_eq!(run("ban Steve").unwrap().0, "ban");
    // rust: assert_eq!(
    // rust: run("ban Steve griefing the farm").unwrap().1,
    // rust: ["targets", "reason"]
    // rust: );
    // rust: for word in ["on", "off", "list", "reload"] {
    // rust: assert_eq!(
    // rust: run(&format!("whitelist {word}")).unwrap().0,
    // rust: format!("whitelist.{word}")
    // rust: );
}
    // rust: assert_eq!(run("whitelist add Steve").unwrap().0, "whitelist.add");
    // rust: assert_eq!(run("whitelist remove @p").unwrap().0, "whitelist.remove");
    // GameProfileArgument: entity selectors are refused.
    // rust: assert_eq!(
    // rust: run("op @e").unwrap_err().message.plain(),
    // rust: "argument.player.entities"
    // rust: );
    // rust: assert!(run("whitelist add").is_err());
    // rust: let reg = Registries {
    // rust: permission: 2,
    // rust: ..reg()
}
    // rust: let d = vanilla::game_tree(false, false, true);
    // rust: for line in ["op Steve", "ban Steve", "whitelist on"] {
    // rust: let e = d.parse(line, &reg).executable().unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command", "{line}");
}
}
the_dedicated_commands_complete_from_the_servers_lists :: proc() {
}
    // OpCommand, DeOpCommands, PardonCommand, PardonIpCommand and WhitelistCommand: the server answers from
    // its own lists (vanilla's `.suggests(...)`, javap on the pinned 26.3 classes), not from the registries'
    // default of the one local player.
    // rust: let reg = Registries {
    // rust: permission: 4,
    // rust: players: vec!["Alex".into(), "Steve".into(), "Zed".into()],
    // rust: ops: vec!["steve".into()],
    // rust: banned_players: vec!["Griefer".into()],
    // rust: banned_ips: vec!["203.0.113.9".into()],
    // rust: whitelisted: vec!["Alex".into(), "Old".into()],
    // rust: ..reg()
}
    // rust: let d = vanilla::game_tree(false, false, true);
    // rust: let suggest = |input: &str| -> Vec<String> {
    // rust: let parse = d.parse(input, &reg);
    // rust: d.suggestions(&parse, input.len(), &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect()
}
    // Only the online players who are not operators (the match ignores case).
    // rust: assert_eq!(suggest("op "), ["Alex", "Zed"]);
    // rust: assert_eq!(suggest("op z"), ["Zed"]);
    // rust: assert_eq!(suggest("deop "), ["steve"]);
    // rust: assert_eq!(suggest("pardon "), ["Griefer"]);
    // rust: assert_eq!(suggest("pardon-ip "), ["203.0.113.9"]);
    // Add offers the online players who are not whitelisted; remove offers the list, online or not.
    // rust: assert_eq!(suggest("whitelist add "), ["Steve", "Zed"]);
    // rust: assert_eq!(suggest("whitelist remove "), ["Alex", "Old"]);
    // Nothing else changed: ban still completes by the argument type, with the selectors.
    // rust: assert!(suggest("ban ").contains(&"@a".to_owned()));
}
only_a_dedicated_server_has_the_dedicated_commands :: proc() {
}
    // Commands.CommandSelection: an integrated server (single player, a LAN
    // world) registers no /op, /ban, /ban-ip, /banlist, /pardon, /pardon-ip,
    // /deop, /setidletimeout, /transfer, /whitelist, /save-all, /save-off, /save-on or /stop,
    // so /help and Tab don't offer them.
    // rust: let dedicated = [
    // rust: "ban",
    // rust: "ban-ip",
    // rust: "banlist",
    // rust: "deop",
    // rust: "op",
    // rust: "pardon",
    // rust: "pardon-ip",
    // rust: "save-all",
    // rust: "save-off",
    // rust: "save-on",
    // rust: "setidletimeout",
    // rust: "stop",
    // rust: "transfer",
    // rust: "whitelist",
    // rust: ];
    // rust: for dev in [false, true] {
    // rust: for horizon in [false, true] {
    // rust: let integrated = vanilla::game_tree(dev, horizon, false);
    // rust: let server = vanilla::game_tree(dev, horizon, true);
    // rust: for name in dedicated {
    // rust: assert!(integrated.find(name).is_none(), "{name}");
    // rust: assert!(server.find(name).is_some(), "{name}");
}
            // includeIntegrated: /publish and /unpublish are the integrated
            // server's alone.
    // rust: for name in ["publish", "unpublish"] {
    // rust: assert!(integrated.find(name).is_some(), "{name}");
    // rust: assert!(server.find(name).is_none(), "{name}");
}
    // rust: assert_eq!(
    // rust: server.nodes[0].children.len(),
    // rust: integrated.nodes[0].children.len() + dedicated.len() - 2
    // rust: );
}
}
    // rust: assert!(vanilla::game_dispatcher().find("ban").is_none());
    // rust: assert!(vanilla::release_dispatcher().find("ban").is_none());
}
a_dedicated_servers_admins_send_players_to_another_server :: proc() {
}
    // TransferCommand.register: LEVEL_ADMINS, `<hostname> [<port> [<players>]]`
    // with IntegerArgumentType.integer(1, 65535) for the port.
    // rust: let server = vanilla::game_tree(false, false, true);
    // rust: assert!(
    // rust: vanilla::game_tree(false, false, false)
    // rust: .find("transfer")
    // rust: .is_none()
    // rust: );
    // rust: let at = |level: u8| Registries {
    // rust: permission: level,
    // rust: ..reg()
}
    // rust: for line in [
    // rust: "transfer example.net",
    // rust: "transfer example.net 25566",
    // rust: "transfer example.net 25566 Alex",
    // rust: ] {
    // rust: assert_eq!(
    // rust: server.parse(line, &at(3)).executable().unwrap().1,
    // rust: "transfer",
    // rust: "{line}"
    // rust: );
}
    // The hostname is required.
    // rust: let e = server.parse("transfer", &at(3)).executable().unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command");
    // Below LEVEL_ADMINS the node is not there at all.
    // rust: for level in [0, 1, 2] {
    // rust: let e = server
    // rust: .parse("transfer example.net", &at(level))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(
    // rust: e.message.plain(),
    // rust: "command.unknown.command",
    // rust: "level {level}"
    // rust: );
}
    // IntegerArgumentType.integer(1, 65535): port 0 is low, 65536 big.
    // rust: let e = server
    // rust: .parse("transfer example.net 0", &at(3))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.integer.low");
    // rust: let e = server
    // rust: .parse("transfer example.net 65536", &at(3))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.integer.big");
}
// The root literals a player at `level` is offered (the chat's, client tree).
root_commands :: proc(d: ^Dispatcher, level: u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let reg = Registries {
    // rust: permission: level,
    // rust: ..reg()
}
    // rust: let parse = d.parse("", &reg);
    // rust: d.client_suggestions(&parse, 0, &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect()
}
a_dedicated_server_keeps_seed_and_version_for_game_masters :: proc() {
}
    // Commands.java: SeedCommand.register(dispatcher, selection != INTEGRATED)
    // and VersionCommand likewise; `checkPermissions` makes them require
    // LEVEL_GAMEMASTERS instead of LEVEL_ALL. A dedicated server's player
    // without op gets neither (a seed cracker's input on an SMP).
    // rust: for dev in [false, true] {
    // rust: for horizon in [false, true] {
    // rust: let integrated = vanilla::game_tree(dev, horizon, false);
    // rust: let server = vanilla::game_tree(dev, horizon, true);
    // rust: let open = root_commands(integrated, 0);
    // rust: assert!(open.contains(&"seed".to_owned()), "{open:?}");
    // rust: assert!(open.contains(&"version".to_owned()), "{open:?}");
    // rust: assert_eq!(
    // rust: root_commands(server, 0),
    // rust: [
    // rust: "help", "list", "me", "msg", "random", "teammsg", "tell", "tm", "trigger", "w"
    // rust: ]
    // rust: );
    // rust: let gm = root_commands(server, 2);
    // rust: assert!(gm.contains(&"seed".to_owned()), "{gm:?}");
    // rust: assert!(gm.contains(&"version".to_owned()), "{gm:?}");
    // rust: for line in ["seed", "version"] {
    // rust: let player = Registries {
    // rust: permission: 0,
    // rust: ..reg()
}
                // Brigadier: a node the source can't use is no node at all.
    // rust: let e = server.parse(line, &player).executable().unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command", "{line}");
    // rust: assert_eq!(e.input.as_deref(), Some(line), "{line}");
    // rust: assert!(integrated.parse(line, &player).executable().is_ok());
    // rust: let op = Registries {
    // rust: permission: 2,
    // rust: ..reg()
}
    // rust: assert_eq!(server.parse(line, &op).executable().unwrap().1, line);
}
}
}
}
a_dedicated_servers_admins_set_the_idle_timeout :: proc() {
}
    // SetPlayerIdleTimeoutCommand.register: LEVEL_ADMINS, and
    // IntegerArgumentType.integer(0) — zero turns the timeout off, and a
    // negative count of minutes is out of range.
    // rust: let server = vanilla::game_tree(false, false, true);
    // rust: let integrated = vanilla::game_tree(false, false, false);
    // rust: assert!(integrated.find("setidletimeout").is_none());
    // rust: let at = |level: u8| Registries {
    // rust: permission: level,
    // rust: ..reg()
}
    // Below LEVEL_ADMINS the node is not there at all.
    // rust: for level in [0, 1, 2] {
    // rust: let e = server
    // rust: .parse("setidletimeout 5", &at(level))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(
    // rust: e.message.plain(),
    // rust: "command.unknown.command",
    // rust: "level {level}"
    // rust: );
}
    // The minutes are required: an incomplete command.
    // rust: let e = server
    // rust: .parse("setidletimeout", &at(3))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(e.message.plain(), "command.unknown.command");
    // rust: for line in ["setidletimeout 0", "setidletimeout 5"] {
    // rust: assert_eq!(
    // rust: server.parse(line, &at(3)).executable().unwrap().1,
    // rust: "setidletimeout"
    // rust: );
}
    // IntegerArgumentType.integer(0): argument.integer.low for -1 below 0.
    // rust: let e = server
    // rust: .parse("setidletimeout -1", &at(3))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(e.message.plain(), "argument.integer.low");
    // Past i32 the number itself is unreadable.
    // rust: let e = server
    // rust: .parse("setidletimeout 2147483648", &at(3))
    // rust: .executable()
    // rust: .unwrap_err();
    // rust: assert_eq!(e.message.plain(), "parsing.int.invalid");
}

time_argument_rounds_like_math_round_float :: proc() {
}
    // rust: let ticks = |input: &str| {
    // rust: let reg = reg();
    // rust: let parse = vanilla::dispatcher().parse(input, &reg);
    // rust: let (ctx, _) = parse.executable().unwrap();
    // rust: match ctx.args.iter().find(|a| a.name == "time").unwrap().value {
    // rust: Arg::Int(t) => t,
    // rust: ref other => panic!("{other:?}"),
}
}
    // 0.49999997 + 0.5 rounds up to 1.0 in f32, but Math.round is exact.
    // rust: assert_eq!(ticks("time set 0.49999997t"), 0);
    // rust: assert_eq!(ticks("time set 0.5t"), 1);
    // rust: assert_eq!(ticks("time add -2.5t"), -2);
}

a_dedicated_servers_owners_can_stop_and_save_it :: proc() {
}
    // StopCommand, SaveAllCommand, SaveOffCommand and SaveOnCommand:
    // Commands.hasPermission(LEVEL_OWNERS), an admin (3) gets none of them.
    // rust: let server = vanilla::game_tree(false, false, true);
    // rust: let at = |permission| Registries {
    // rust: permission,
    // rust: ..reg()
}
    // rust: for (line, id) in [
    // rust: ("stop", "stop"),
    // rust: ("save-all", "save-all"),
    // rust: ("save-all flush", "save-all"),
    // rust: ("save-off", "save-off"),
    // rust: ("save-on", "save-on"),
    // rust: ] {
    // rust: assert_eq!(
    // rust: server.parse(line, &at(4)).executable().unwrap().1,
    // rust: id,
    // rust: "{line}"
    // rust: );
    // rust: assert!(server.parse(line, &at(3)).executable().is_err(), "{line}");
}
}

local_coordinate_missing_after_space_expects_a_coordinate :: proc() {
}
    // LocalCoordinates.readDouble: nothing left to read is ERROR_EXPECTED_DOUBLE,
    // with the cursor where it stopped; only a non-'^' character is "mixed".
    // rust: let reg = reg();
    // rust: let parse = |text: &str| {
    // rust: let mut r = Reader::new(text);
    // rust: let e = ArgType::Vec3 { center: true }
    // rust: .parse(&mut r, &reg)
    // rust: .map(|_| ())
    // rust: .unwrap_err();
    // rust: (e.key, e.cursor)
}
    // rust: assert_eq!(parse("^1 "), ("argument.pos.missing.double".into(), 3));
    // rust: assert_eq!(parse("^1 ^2 "), ("argument.pos.missing.double".into(), 6));
    // rust: assert_eq!(parse("^1 ~"), ("argument.pos.mixed".into(), 0));
}

// `execute … run` redirects back to the root, so a crafted deeply nested chain
// recurses `parse_nodes` once per level. It must be rejected by the depth guard,
// never overflow the parsing thread's stack (a stack overflow would abort this
// test binary rather than let it pass).
deeply_nested_execute_run_is_rejected_not_overflowed :: proc() {
}
    // rust: let mut deep = String::from("say hi");
    // rust: for _ in 0..400 {
    // rust: deep = format!("execute if entity @s run {deep}");
}
    // rust: assert!(run(&deep).is_err());
}

// The guard is high enough that real command chains still parse.
shallow_execute_run_still_parses :: proc() {
}
    // rust: assert!(run("execute if entity @s run say hi").is_ok());
    // rust: assert!(run("execute as @a at @s run tp @s 0 0 0").is_ok());
}
