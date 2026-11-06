//! Transpiled from Horizon Rust crate
package horizon_client_commands

import "core:fmt"
import "core:mem"
import "core:math"

// Every command horizon-ctl knows: its usage, help, examples and arguments.
// The same table prints `help`, checks `COMMAND --help` and describes the
// MCP tools, so the CLI and the MCP server always offer the same commands.
// use serde_json::{Map, Value, json};

Ty :: enum {
    Int,
    Num,
    Str,
    Bool,
    // One of these words.
    Enum(&'static [&'static str]),
    // The rest of the line, spaces included.
    Rest,
}

Param :: struct {
    name: ^'static str,
    ty: Ty,
    required: bool,
    // Sent as `--name value` (`--name` alone for booleans), not by position.
    flag: bool,
    help: ^'static str,
}

Group :: enum {
    Session,
    Observe,
    Move,
    Act,
    Screens,
    Multiplayer,
    World,
    Scripting,
}
    // rust: impl Group {
    // rust: pub const ALL: [Group; 8] = [
    // rust: Group::Session,
    // rust: Group::Observe,
    // rust: Group::Move,
    // rust: Group::Act,
    // rust: Group::Screens,
    // rust: Group::Multiplayer,
    // rust: Group::World,
    // rust: Group::Scripting,
    // rust: ];
title :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Group::Session => "Session",
    // rust: Group::Observe => "Observe (JSON state)",
    // rust: Group::Move => "Move and look",
    // rust: Group::Act => "Act on the world",
    // rust: Group::Screens => "Screens, menus and chat",
    // rust: Group::Multiplayer => "Multiplayer, LAN and friends",
    // rust: Group::World => "World and cheats",
    // rust: Group::Scripting => "Scripting and benchmarks",
}
}
}

// One field of a command's JSON reply. `ty` is a JSON type (`string`, `integer`, `number`,
// `boolean`, `array`, `object`); `a|null` marks a field that is `null` when it does not apply.
Field :: struct {
    name: ^'static str,
    ty: ^'static str,
    help: ^'static str,
}

    // rust: const fn f(name: &'static str, ty: &'static str, help: &'static str) -> Field {
    // rust: Field { name, ty, help }
}

// `hello`: always these three fields.
    // rust: const HELLO_REPLY: &[Field] = &[
    // rust: f(
    // rust: "protocol",
    // rust: "string",
    // rust: "the control protocol, MAJOR.MINOR.PATCH (docs/api/stability.md)",
    // rust: ),
    // rust: f(
    // rust: "release",
    // rust: "string",
    // rust: "the game's version (MCP serverInfo carries the same string)",
    // rust: ),
    // rust: f(
    // rust: "features",
    // rust: "array",
    // rust: "the command groups the game answers, each a string",
    // rust: ),
    // rust: ];

// `status`: the top-level fields the reply always carries. It holds more (sounds,
// projectiles, maps and the like), so a reader must ignore the keys it does not know.
    // rust: const STATUS_REPLY: &[Field] = &[
    // rust: f(
    // rust: "screen",
    // rust: "string",
    // rust: "the open screen (playing, inventory, paused...)",
    // rust: ),
    // rust: f(
    // rust: "debug",
    // rust: "object",
    // rust: "the F3 overlay flags: overlay, hitboxes, chunk_borders, pause_menu, advanced_tooltips, pause_on_lost_focus, clipboard",
    // rust: ),
    // rust: f("dimension", "string", "the dimension the player is in"),
    // rust: f("creative", "boolean", "creative mode"),
    // rust: f(
    // rust: "player",
    // rust: "object|null",
    // rust: "position, velocity (blocks), on_ground, health, max_health, food; null without a player",
    // rust: ),
    // rust: f("yaw", "number", "view yaw, degrees"),
    // rust: f("pitch", "number", "view pitch, degrees"),
    // rust: f(
    // rust: "target",
    // rust: "object|null",
    // rust: "the block under the crosshair as pos and block; null when none",
    // rust: ),
    // rust: f("selected", "integer", "the selected hotbar slot, 1 to 9"),
    // rust: f(
    // rust: "held",
    // rust: "object|null",
    // rust: "the held stack as item and count; null when empty",
    // rust: ),
    // rust: f(
    // rust: "offhand",
    // rust: "object|null",
    // rust: "the offhand stack as item, count and damage; null when empty",
    // rust: ),
    // rust: f(
    // rust: "keys",
    // rust: "array",
    // rust: "the keys the game holds down, each a string",
    // rust: ),
    // rust: f("fps", "number", "frames per second"),
    // rust: f("frames", "integer", "frames drawn so far"),
    // rust: f("ticks", "integer", "game ticks so far"),
    // rust: f("day_time", "integer", "the world's time of day, ticks"),
    // rust: f("uptime_seconds", "number", "seconds since the game started"),
    // rust: f("render_distance", "integer", "chunks"),
    // rust: f("chunks", "integer", "chunks loaded"),
    // rust: f("mobs", "integer", "mobs this side knows"),
    // rust: f("block_entities", "integer", "block entities loaded"),
    // rust: f(
    // rust: "pending_chunks",
    // rust: "integer",
    // rust: "chunks still being generated, meshed, uploaded or received",
    // rust: ),
    // rust: f(
    // rust: "streaming",
    // rust: "object",
    // rust: "chunk streaming stages and their counts",
    // rust: ),
    // rust: f(
    // rust: "lod",
    // rust: "object",
    // rust: "far terrain: distances, tiles, quads and sampling progress",
    // rust: ),
    // rust: f(
    // rust: "renderer",
    // rust: "object|null",
    // rust: "GPU, driver, backend, size, draw counts and GPU memory; null without a renderer",
    // rust: ),
    // rust: f(
    // rust: "display",
    // rust: "object|null",
    // rust: "the monitor: width, height, scale, refresh_hz; null without a window",
    // rust: ),
    // rust: f(
    // rust: "server",
    // rust: "object|null",
    // rust: "the connected server's address, name and state; null when not connected",
    // rust: ),
    // rust: ];

Cmd :: struct {
    name: ^'static str,
    // What the game receives instead of `name` (aliases such as look-at-block).
    wire: Maybe(^'static str),
    group: Group,
    usage: ^'static str,
    summary: ^'static str,
    details: ^'static str,
    examples: ^'static [^'static str],
    params: ^'static [Param],
    // Offered as an MCP tool.
    mcp: bool,
    // Runs in horizon-ctl itself, not in the game.
    local: bool,
    // The reply's fields; empty until the command's reply is described (`REPLY_GROUP`).
    reply: ^'static [Field],
}

    // rust: const fn p(name: &'static str, ty: Ty, help: &'static str) -> Param {
    // rust: Param {
    // rust: name,
    // rust: ty,
    // rust: required: true,
    // rust: flag: false,
    // rust: help,
}
}
    // rust: const fn opt(name: &'static str, ty: Ty, help: &'static str) -> Param {
    // rust: Param {
    // rust: name,
    // rust: ty,
    // rust: required: false,
    // rust: flag: false,
    // rust: help,
}
}
    // rust: const fn flag(name: &'static str, ty: Ty, help: &'static str) -> Param {
    // rust: Param {
    // rust: name,
    // rust: ty,
    // rust: required: false,
    // rust: flag: true,
    // rust: help,
}
}
    // rust: const XYZ: [Param; 3] = [
    // rust: p("x", Ty::Num, "X coordinate"),
    // rust: p("y", Ty::Num, "Y coordinate"),
    // rust: p("z", Ty::Num, "Z coordinate"),
    // rust: ];
    // rust: const BLOCK_XYZ: [Param; 3] = [
    // rust: p("x", Ty::Int, "block X"),
    // rust: p("y", Ty::Int, "block Y"),
    // rust: p("z", Ty::Int, "block Z"),
    // rust: ];
    // rust: const OVER: Param = flag(
    // rust: "over",
    // rust: Ty::Num,
    // rust: "turn with mouse motion spread over this many seconds (eased), as a player would",
    // rust: );
FACE :: Ty::Enum(&["down", "up", "north", "south", "west", "east"])
    // rust: const BOX: [Param; 6] = [
    // rust: p("x1", Ty::Int, "corner X"),
    // rust: p("y1", Ty::Int, "corner Y"),
    // rust: p("z1", Ty::Int, "corner Z"),
    // rust: p("x2", Ty::Int, "opposite X"),
    // rust: p("y2", Ty::Int, "opposite Y"),
    // rust: p("z2", Ty::Int, "opposite Z"),
    // rust: ];
    // rust: const PAGES: Ty = Ty::Enum(&[
    // rust: "main",
    // rust: "video",
    // rust: "sound",
    // rust: "controls",
    // rust: "keybinds",
    // rust: "controller",
    // rust: "controller-binds",
    // rust: "mouse",
    // rust: "chat",
    // rust: "accessibility",
    // rust: "language",
    // rust: "font",
    // rust: "packs",
    // rust: "mods",
    // rust: "shader-packs",
    // rust: "graphics",
    // rust: "graphics-advanced",
    // rust: "graphics-hdr",
    // rust: "extras",
    // rust: "horizon",
    // rust: "agent",
    // rust: "video-vanilla",
    // rust: ]);

// `--confirm`, required by destructive commands: the player agreed.
    // rust: const CONFIRM: Param = Param {
    // rust: name: "confirm",
    // rust: ty: Ty::Bool,
    // rust: required: true,
    // rust: flag: true,
    // rust: help: "true once the player agreed: it cannot be undone",
}

// MCP tools that delete or overwrite the player's things (`destructiveHint`).
DESTRUCTIVE :: &["world-delete", "fill", "setblock"]
// MCP tools that reach other players or the network (`openWorldHint`): only when the player asks.
OPEN_WORLD :: &["connect", "lan", "friends", "chat", "command"]

    // rust: macro_rules! cmd {
    // rust: ($name:expr, $group:ident, $usage:expr, $summary:expr, $details:expr, [$($ex:expr),* $(,)?], $params:expr, mcp: $mcp:expr, local: $local:expr, reply: $reply:expr) => {
    // rust: Cmd {
    // rust: reply: $reply,
    // rust: ..cmd!($name, $group, $usage, $summary, $details, [$($ex),*], $params, mcp: $mcp, local: $local)
}
}
    // rust: ($name:expr, $group:ident, $usage:expr, $summary:expr, $details:expr, [$($ex:expr),* $(,)?], $params:expr, mcp: $mcp:expr, local: $local:expr $(, wire: $wire:expr)?) => {
    // rust: Cmd {
    // rust: name: $name,
    // rust: wire: cmd!(@wire $($wire)?),
    // rust: group: Group::$group,
    // rust: usage: $usage,
    // rust: summary: $summary,
    // rust: details: $details,
    // rust: examples: &[$($ex),*],
    // rust: params: $params,
    // rust: mcp: $mcp,
    // rust: local: $local,
    // rust: reply: &[],
}
}
    // rust: (@wire) => { None };
    // rust: (@wire $w:expr) => { Some($w) };
}

    // rust: pub const COMMANDS: &[Cmd] = &[
    // Session
    // rust: cmd!("launch", Session, "launch [--world NAME] [--seed N] [--creative] [--version TAG] [--game PATH] [--wait] [GAME ARGS...]",
    // rust: "start Horizon with the control socket and wait until it answers",
    // rust: "Finds the game in this order: --game PATH; a horizon-client next to horizon-ctl (a build folder, a release folder or a launcher install); the newest version installed by the Horizon launcher (--version TAG picks one). Launcher installs run with their prepared resources and keep saves in the game home ($HORIZON_HOME, else ~/.local/share/horizon). --wait also waits until the player has spawned and chunks are loaded. Other arguments go to the game (horizon-client --help lists them). The game's output goes to a .log file beside the socket.",
    // rust: ["horizon-ctl launch --world Survival --seed 42 --wait", "horizon-ctl launch --world Flat --creative --render-distance 8"],
    // rust: &[flag("world", Ty::Str, "world folder to open or create"), flag("seed", Ty::Str, "seed for a new world"), flag("creative", Ty::Bool, "creative mode for a new world"),
    // rust: flag("version", Ty::Str, "an installed launcher version tag such as v2026.10.13"), flag("game", Ty::Str, "path to a horizon-client binary"),
    // rust: flag("wait", Ty::Bool, "also wait until the world is ready (default in MCP)"),
    // rust: flag("offscreen", Ty::Bool, "render without showing a window (screenshots still work): locked or headless sessions"),
    // rust: flag("headless", Ty::Bool, "no display, window or GPU: a player that plays through these commands only (no screenshots)")],
    // rust: mcp: true, local: true),
    // rust: cmd!("wait-for", Session, "wait-for screen NAME|widget ID|loaded|chat TEXT|event KIND [--timeout S] [--since SEQ]", "wait until the game reaches a state, then reply",
    // rust: "screen takes the names state shows (playing, inventory, paused, dead, title...); widget an id from ui; loaded means a world is open, the player is in it and no chunk is pending; chat a new line containing TEXT; event a kind from events (death, respawn, item, screen...). chat and event count from --since SEQ (take last from events before acting), else from now. A timeout (default 30 s) is an error with kind timeout.",
    // rust: ["horizon-ctl wait-for screen inventory", "horizon-ctl wait-for loaded --timeout 120", "horizon-ctl wait-for chat joined the game", "horizon-ctl wait-for event death --timeout 600"],
    // rust: &[flag("timeout", Ty::Num, "seconds (default 30)"), flag("since", Ty::Int, "chat and event: count from this event seq"), p("condition", Ty::Enum(&["screen", "widget", "loaded", "chat", "event"]), "what to wait for"), opt("value", Ty::Rest, "the screen name, widget id, chat text or event kind")], mcp: true, local: false),
    // rust: cmd!("events", Observe, "events [--since SEQ]", "what happened since SEQ, oldest first: screens, chat, deaths, respawns, items gained or lost, dimensions, worlds",
    // rust: "Every event has seq and tick; pass the reply's last as --since next time. The game keeps the newest 256.",
    // rust: ["horizon-ctl events", "horizon-ctl events --since 42"], &[flag("since", Ty::Int, "only events after this seq")], mcp: true, local: false),
    // rust: cmd!("input-log", Observe, "input-log [--since SEQ] [--limit N] [--origin user|agent|game]", "recent input and who caused it: a person, an agent or the game",
    // rust: "Every event has seq, tick and origin. `user` is the window's own keyboard, mouse or pad; `agent` is the control socket (this tool); `game` is input the game made up. A `user-input` event in `events` means a person stepped in while an agent was driving. The game keeps the newest 512.",
    // rust: ["horizon-ctl input-log", "horizon-ctl input-log --origin user --limit 20", "horizon-ctl input-log --since 120"], &[flag("since", Ty::Int, "only events after this seq"), flag("limit", Ty::Int, "newest N events"), flag("origin", Ty::Enum(&["user", "agent", "game"]), "user, agent or game")], mcp: true, local: false),
    // rust: cmd!("wait-ready", Session, "wait-ready [SECONDS]", "wait until the player has spawned and no chunks are pending",
    // rust: "Polls status every 250 ms; replies with the status, or an error after SECONDS (default 120).",
    // rust: ["horizon-ctl wait-ready 300"], &[opt("seconds", Ty::Num, "how long to wait (default 120)")], mcp: true, local: true),
    // rust: cmd!("logs", Session, "logs [--lines N] [--crash]", "the end of the game's log, or its newest crash report",
    // rust: "Reads the game home ($HORIZON_HOME, else ~/.local/share/horizon): logs/latest.log (the last N lines, default 100) or, with --crash, the newest file in crash-reports. Read-only; works whether the game runs or not.",
    // rust: ["horizon-ctl logs", "horizon-ctl logs --lines 300", "horizon-ctl logs --crash"],
    // rust: &[flag("lines", Ty::Int, "how many lines of latest.log (default 100)"), flag("crash", Ty::Bool, "the newest crash report instead")],
    // rust: mcp: true, local: true),
    // rust: cmd!("status", Session, "status", "game, renderer and streaming state (the scripting socket's original summary)",
    // rust: "Also what F3 shows: the overlay flags, the renderer, chunk streaming and memory.", ["horizon-ctl status"], &[], mcp: true, local: false, reply: STATUS_REPLY),
    // rust: cmd!("hello", Session, "hello", "the control protocol's version, the game's release and the command groups it serves",
    // rust: "Replies protocol (MAJOR.MINOR.PATCH of the control protocol, docs/api/stability.md), release (the game's version, the string MCP serverInfo carries too) and features (the command groups the game answers, so a script can test for one before calling it).",
    // rust: ["horizon-ctl hello"], &[], mcp: true, local: false, reply: HELLO_REPLY),
    // rust: cmd!("memory", Session, "memory", "what holds the game's memory: resident set, allocator, client and server columns by part, renderer, GPU memory by resource",
    // rust: "Columns count blocks, biomes, light, heightmaps and records, each shared section once; server_columns are the single-player server thread's own levels. GPU memory by label needs Vulkan or DirectX 12. What the census doesn't reach is the resident set less its parts. A build with the alloc-census feature adds heap_by_tag_mb: the live heap by startup step, timed span, chunk job and thread.", ["horizon-ctl memory"], &[], mcp: true, local: false),
    // rust: cmd!("worlds", Session, "worlds", "the saved worlds, newest first: folder, name, mode, last played, version",
    // rust: "folder is what open, world-rename, world-backup and world-delete take.", ["horizon-ctl worlds"], &[], mcp: true, local: false),
    // rust: cmd!("world-rename", Session, "world-rename FOLDER NAME", "rename a world, as Edit World does (its folder stays)",
    // rust: "Needs the title screen (no world open).", ["horizon-ctl world-rename Test \"My Base\""],
    // rust: &[p("folder", Ty::Str, "world folder from worlds"), p("name", Ty::Rest, "the new name")], mcp: true, local: false),
    // rust: cmd!("world-backup", Session, "world-backup FOLDER", "zip a world into backups/, as Edit World's Make Backup does",
    // rust: "Needs the title screen. Replies once the zip is written, with its size.", ["horizon-ctl world-backup Test"],
    // rust: &[p("folder", Ty::Str, "world folder from worlds")], mcp: true, local: false),
    // rust: cmd!("world-delete", Session, "world-delete FOLDER --confirm", "delete a world for good, as Select World's Delete does",
    // rust: "Needs the title screen and --confirm: ask the player first, it cannot be undone (world-backup keeps a copy).",
    // rust: ["horizon-ctl world-delete Test --confirm"],
    // rust: &[p("folder", Ty::Str, "world folder from worlds"), CONFIRM], mcp: true, local: false),
    // rust: cmd!("open", Session, "open WORLD [SEED] [creative]", "open or create a world from the title screen",
    // rust: "Opens saves/WORLD, creating it with SEED (and creative mode) when it doesn't exist.",
    // rust: ["horizon-ctl open Test 12345", "horizon-ctl open Build 0 creative"],
    // rust: &[p("world", Ty::Str, "world folder"), opt("seed", Ty::Int, "seed for a new world"), opt("mode", Ty::Enum(&["creative"]), "creative for a creative world")], mcp: true, local: false),
    // rust: cmd!("save", Session, "save", "save the world", "", ["horizon-ctl save"], &[], mcp: true, local: false),
    // rust: cmd!("quit", Session, "quit", "save and exit the game", "", ["horizon-ctl quit"], &[], mcp: true, local: false),
    // rust: cmd!("screenshot", Session, "screenshot PATH", "write the next rendered frame as a PNG",
    // rust: "Relative paths are taken from horizon-ctl's directory. Over MCP the image is returned directly.",
    // rust: ["horizon-ctl screenshot view.png"], &[], mcp: true, local: false),
    // Observe
    // rust: cmd!("state", Observe, "state", "player, world, screen and crosshair target in one reply",
    // rust: "position, block_pos, eye, yaw, pitch, velocity, on_ground, health, food, saturation, xp, effects, gamemode, dimension, time, weather, the screen or title menu, the held item, what the crosshair points at and whether an action is running.",
    // rust: ["horizon-ctl state"], &[], mcp: true, local: false),
    // rust: cmd!("looking-at", Observe, "looking-at", "the block or entity under the crosshair",
    // rust: "kind is block, entity or none; a block has pos, state, face, point and distance; an entity has id, type, health and distance.",
    // rust: ["horizon-ctl looking-at"], &[], mcp: true, local: false),
    // rust: cmd!("entities", Observe, "entities [RADIUS] [TYPE]", "mobs, dropped items and experience orbs near the player, nearest first",
    // rust: "RADIUS defaults to 32. TYPE filters by entity type (pig, minecraft:item, ...). Mobs have an id for look-at entity and attack.",
    // rust: ["horizon-ctl entities", "horizon-ctl entities 16 cow", "horizon-ctl entities 8 item"],
    // rust: &[opt("radius", Ty::Num, "search radius in blocks (default 32)"), opt("type", Ty::Str, "entity type filter")], mcp: true, local: false),
    // rust: cmd!("block", Observe, "block X Y Z", "the block state at a position", "",
    // rust: ["horizon-ctl block 10 64 -3"], &BLOCK_XYZ, mcp: true, local: false),
    // rust: cmd!("light", Observe, "light X1 Y1 Z1 X2 Y2 Z2", "the stored sky and block light of a box",
    // rust: "At most 32768 blocks per request. One hex digit per block in `sky` and `block`, x fastest, then z, then y; `.` where no chunk is loaded.",
    // rust: ["horizon-ctl light 0 64 0 15 70 15"],
    // rust: &BOX, mcp: true, local: false),
    // rust: cmd!("blocks", Observe, "blocks X1 Y1 Z1 X2 Y2 Z2", "the non-air blocks of a box, with counts per block",
    // rust: "At most 32768 blocks per request.", ["horizon-ctl blocks 0 60 0 15 70 15"],
    // rust: &BOX, mcp: true, local: false),
    // rust: cmd!("find-block", Observe, "find-block BLOCK [RADIUS]", "the nearest loaded blocks of a kind",
    // rust: "Searches a cube of RADIUS (default 32, at most 64) around the player; returns the count and the 16 nearest.",
    // rust: ["horizon-ctl find-block oak_log", "horizon-ctl find-block diamond_ore 48"],
    // rust: &[p("block", Ty::Str, "block id such as oak_log"), opt("radius", Ty::Int, "search radius (default 32)")], mcp: true, local: false),
    // rust: cmd!("inventory", Observe, "inventory", "hotbar, main inventory, armor, offhand, carried stack and item counts",
    // rust: "Slots carry the ids click-slot takes: 0-8 hotbar, 9-35 inventory, 500-503 armor (head to feet), 504 offhand. Stacks with components list them as SNBT.",
    // rust: ["horizon-ctl inventory"], &[], mcp: true, local: false),
    // rust: cmd!("screen", Observe, "screen", "the open screen or title menu, its buttons and its slots",
    // rust: "buttons are what click-button takes; slots are what click-slot takes (crafting grid 100-103 in the inventory, 100-108 at a crafting table, result 200, containers from 300, stations from 600). On the title screen, menu has the mode, worlds and the create-world fields.",
    // rust: ["horizon-ctl screen"], &[], mcp: true, local: false),
    // rust: cmd!("messages", Observe, "messages [N]", "recent chat and system messages, the title and the action bar",
    // rust: "N defaults to 20; chat is newest first.", ["horizon-ctl messages 5"], &[opt("n", Ty::Int, "how many chat lines (default 20)")], mcp: true, local: false),
    // rust: cmd!("menu", Observe, "menu", "the open menu's slots and carried stack, with station details", "",
    // rust: ["horizon-ctl menu"], &[], mcp: false, local: false),
    // rust: cmd!("narration", Observe, "narration", "what the narrator was last asked to say, oldest first, and its status",
    // rust: "recent holds the last 32 messages the narrator's status let through, said aloud or not; status is the Narrator option (off, all, chat or system) and active whether text-to-speech is there (with HORIZON_NO_AUDIO it is, silently).",
    // rust: ["horizon-ctl narration"], &[], mcp: true, local: false),
    // Move
    // rust: cmd!("move", Move, "move forward|back|left|right SECONDS [--sprint] [--sneak] [--jump]", "walk in a direction relative to the view for a time",
    // rust: "Replies when done with the start and end positions.",
    // rust: ["horizon-ctl move forward 2", "horizon-ctl move forward 1.5 --sprint --jump"],
    // rust: &[p("direction", Ty::Enum(&["forward", "back", "left", "right"]), "direction relative to the view"), p("seconds", Ty::Num, "how long to walk"),
    // rust: flag("sprint", Ty::Bool, "sprint"), flag("sneak", Ty::Bool, "sneak"), flag("jump", Ty::Bool, "keep jumping")], mcp: true, local: false),
    // rust: cmd!("goto", Move, "goto X Y Z [--near R] [--sprint] [--direct] [--timeout S]", "walk to a position, finding a path through loaded terrain",
    // rust: "A* over standable blocks (steps up one block, drops up to three, avoids lava, swims when it must), then steering with jumps when stuck. Without a path it fails at once (--direct walks straight at the target anyway, falls included). --near R stops within R blocks (use 1.5-3 to reach a block you then break). Replies with arrived, position and distance, or an error when stuck or out of time (default 60 s).",
    // rust: ["horizon-ctl goto 120 70 -40", "horizon-ctl goto 8 64 3 --near 2 --sprint"],
    // rust: &[XYZ[0], XYZ[1], XYZ[2], flag("near", Ty::Num, "arrive within this many blocks (default 0.6)"), flag("sprint", Ty::Bool, "sprint"), flag("direct", Ty::Bool, "walk straight when no path is found"), flag("timeout", Ty::Num, "give up after this many seconds (default 60)")], mcp: true, local: false),
    // rust: cmd!("jump", Move, "jump", "jump once and reply when landed", "", ["horizon-ctl jump"], &[], mcp: true, local: false),
    // rust: cmd!("look", Move, "look YAW PITCH", "set the view direction in degrees",
    // rust: "Yaw 0 faces south (+Z), 90 west (-X), 180 north, -90 east; pitch 90 looks straight down.",
    // rust: ["horizon-ctl look 90 10"], &[p("yaw", Ty::Num, "yaw in degrees"), p("pitch", Ty::Num, "pitch in degrees (-90 up .. 90 down)")], mcp: true, local: false),
    // rust: cmd!("turn", Move, "turn DYAW DPITCH [--over S]", "rotate the view by an amount",
    // rust: "Without --over the view jumps. With --over S the turn is mouse motion fed over S seconds with ease-in-out, through the same path as a real mouse (sensitivity, inverted axes, cinematic camera), and the reply comes once it is done.",
    // rust: ["horizon-ctl turn 45 0", "horizon-ctl turn -90 10 --over 0.5"],
    // rust: &[p("dyaw", Ty::Num, "yaw change in degrees"), p("dpitch", Ty::Num, "pitch change in degrees"), OVER], mcp: true, local: false),
    // rust: cmd!("mouse-move", Move, "mouse-move DX DY", "move the mouse: relative motion that turns the view like a player's mouse",
    // rust: "DX and DY are mouse units (pixels of relative motion) added to the frame's accumulated movement and turned by MouseHandler.turnPlayer: degrees = units x 0.15 x (sensitivity x 0.6 + 0.2)^3 x 8 (without the 8 while scoping), inverted axes and the cinematic camera included. Positive DX turns right, positive DY looks down. Works in the world with no screen open; replies with yaw and pitch after the frame that turned.",
    // rust: ["horizon-ctl mouse-move 100 0", "horizon-ctl mouse-move -25 40"],
    // rust: &[p("dx", Ty::Num, "horizontal motion (positive turns right)"), p("dy", Ty::Num, "vertical motion (positive looks down)")], mcp: true, local: false),
    // rust: cmd!("look-at", Move, "look-at X Y Z | look-at block X Y Z [FACE] | look-at entity ID  [--over S]", "turn to face a point, a block (a visible face of it) or an entity",
    // rust: "look-at block aims at a face the crosshair can reach and fails when none is visible. --over S turns there with mouse motion over S seconds (the shorter way round) instead of jumping.",
    // rust: ["horizon-ctl look-at 10.5 65 3.5", "horizon-ctl look-at block 10 64 3 up", "horizon-ctl look-at entity 42 --over 0.4"],
    // rust: &[XYZ[0], XYZ[1], XYZ[2], OVER], mcp: true, local: false),
    // rust: cmd!("look-at-block", Move, "look-at-block X Y Z [FACE] [--over S]", "aim the crosshair at a block (same as look-at block)", "",
    // rust: ["horizon-ctl look-at-block 10 64 3", "horizon-ctl look-at-block 10 64 3 up --over 0.3"], &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], opt("face", FACE, "which face to aim at"), OVER], mcp: true, local: false, wire: "look-at block"),
    // rust: cmd!("look-at-entity", Move, "look-at-entity ID [--over S]", "face an entity (same as look-at entity)", "",
    // rust: ["horizon-ctl look-at-entity 42"], &[p("id", Ty::Int, "entity id from entities"), OVER], mcp: true, local: false, wire: "look-at entity"),
    // rust: cmd!("tp", Move, "tp X Y Z", "teleport the player", "", ["horizon-ctl tp 0 80 0"], &XYZ, mcp: true, local: false),
    // rust: cmd!("emote", Act, "emote [ID|stop]", "play one of the player's emotes, stop it, or list them",
    // rust: "Without an argument: the emotes the player owns (the wheel's) and the one playing. With an ID it plays that emote as the emote wheel does (the player must stand still: moving, attacking or using an item cancels it); stop fades it out. Visual only: nothing is sent to the game server (docs/cosmetics.md).",
    // rust: ["horizon-ctl emote", "horizon-ctl emote wave_hello", "horizon-ctl emote stop"],
    // rust: &[opt("id", Ty::Str, "an owned emote's id, or stop")], mcp: true, local: false),
    // Act
    // rust: cmd!("break", Act, "break X Y Z [--timeout S]", "mine a block, holding the attack button until it breaks",
    // rust: "Aims at a visible face (the block must be within reach: use goto --near 2 first), mines with the held item, then waits up to a second for the drops. Replies with block_before, block, ticks, drops and picked_up (inventory change).",
    // rust: ["horizon-ctl break 10 64 3"], &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], flag("timeout", Ty::Num, "give up after this many seconds (default 30)")], mcp: true, local: false),
    // rust: cmd!("place", Act, "place X Y Z [--item ITEM]", "place the held item (or ITEM from the hotbar) at an empty position",
    // rust: "Clicks the face of a solid neighbour touching X Y Z. Replies with the block placed and the inventory change.",
    // rust: ["horizon-ctl place 10 64 4 --item oak_planks"], &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], flag("item", Ty::Str, "hotbar item to select first")], mcp: true, local: false),
    // rust: cmd!("interact", Act, "interact X Y Z [FACE]", "right-click a block: open a chest or crafting table, press a button, open a door",
    // rust: "Replies with the screen afterwards and whether the block changed.", ["horizon-ctl interact 5 64 2"],
    // rust: &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], opt("face", FACE, "which face to click")], mcp: true, local: false),
    // rust: cmd!("use-item", Act, "use-item [--hold SECONDS]", "right-click with the held item: eat, drink, throw, draw a bow",
    // rust: "Hold for 1.7 s to eat.", ["horizon-ctl use-item --hold 1.7"], &[flag("hold", Ty::Num, "hold the button this long")], mcp: true, local: false),
    // rust: cmd!("attack", Act, "attack [ID]", "swing at what the crosshair targets (after facing entity ID)",
    // rust: "Replies with the target's health before and after.", ["horizon-ctl attack", "horizon-ctl attack 42"],
    // rust: &[opt("id", Ty::Int, "entity id to face first")], mcp: true, local: false),
    // rust: cmd!("select", Act, "select SLOT|ITEM", "select a hotbar slot 1-9, or the hotbar slot holding ITEM", "",
    // rust: ["horizon-ctl select 3", "horizon-ctl select oak_planks"], &[p("slot", Ty::Str, "1-9 or an item id")], mcp: true, local: false),
    // rust: cmd!("drop", Act, "drop [all]", "drop one of the held item, or the whole stack", "", ["horizon-ctl drop", "horizon-ctl drop all"],
    // rust: &[opt("all", Ty::Bool, "drop the whole stack")], mcp: true, local: false),
    // rust: cmd!("hold", Act, "hold KEY SECONDS", "press a key, wait, release it", "Keys as for key.", ["horizon-ctl hold w 2"],
    // rust: &[p("key", Ty::Str, "key name"), p("seconds", Ty::Num, "how long")], mcp: false, local: true),
    // rust: cmd!("key", Act, "key KEY down|up|tap|repeat", "press, release or auto-repeat a key (w a s d space shift ctrl e q esc f3 1-9 arrows ...)",
    // rust: "down holds the key until key ... up, release or stop; wait does not release it. move, goto, jump, break and the other actions release the movement keys when they end.",
    // rust: ["horizon-ctl key space tap"], &[p("key", Ty::Str, "key name"), p("action", Ty::Enum(&["down", "up", "tap", "repeat"]), "what to do")], mcp: true, local: false),
    // rust: cmd!("mouse", Act, "mouse left|right|middle down|up|click", "press or release a mouse button in the world", "",
    // rust: ["horizon-ctl mouse right click"], &[p("button", Ty::Enum(&["left", "right", "middle"]), "button"), p("action", Ty::Enum(&["down", "up", "click"]), "what to do")], mcp: true, local: false),
    // rust: cmd!("interact-entity", Act, "interact-entity ID", "right-click an entity: trade with a villager, mount a horse, ride a boat, shear a sheep",
    // rust: "Faces the entity (from entities), right-clicks it with the held item, waits two ticks and replies with the screen.",
    // rust: ["horizon-ctl interact-entity 42"], &[p("id", Ty::Int, "entity id from entities")], mcp: true, local: true),
    // rust: cmd!("pad", Act, "pad BUTTON down|up|tap | pad stick left|right X Y | pad trigger left|right V | pad release | pad status | pad connection connected|disconnected", "a virtual controller: buttons, sticks and triggers as a real pad would send them",
    // rust: "Buttons by position: south east west north lb rb lt rt select start ls rs up down left right (south is Xbox A / PlayStation cross). Sticks run -1..1 with up positive and stay tilted until centred; triggers 0..1. Merged with any real controller; status lists the connected ones and what is held.",
    // rust: ["horizon-ctl pad south tap", "horizon-ctl pad stick left 0 1", "horizon-ctl pad trigger right 1", "horizon-ctl pad status"],
    // rust: &[p("what", Ty::Str, "a button name, stick, trigger, release, status or connection"), opt("a", Ty::Str, "down|up|tap, left|right, or connected|disconnected"), opt("b", Ty::Num, "stick X or trigger value"), opt("c", Ty::Num, "stick Y")], mcp: true, local: false),
    // rust: cmd!("release", Act, "release", "release every key and mouse button", "", ["horizon-ctl release"], &[], mcp: true, local: false),
    // rust: cmd!("stop", Act, "stop", "cancel the running action (goto, break...) and release every key", "", ["horizon-ctl stop"], &[], mcp: true, local: false),
    // Screens
    // rust: cmd!("open-inventory", Screens, "open-inventory", "open the inventory screen (crafting grid 100-103, result 200)", "",
    // rust: ["horizon-ctl open-inventory"], &[], mcp: true, local: false),
    // rust: cmd!("click-slot", Screens, "click-slot SLOT [right] [shift]", "click a slot of the open inventory or menu",
    // rust: "SLOT ids as listed by screen: 0-8 hotbar, 9-35 inventory, 100+ crafting grid, 200 result, 300+ container, 500-503 armor, 504 offhand, 600+ station. A left click picks up or puts down the carried stack; right puts down one item; shift moves the stack across.",
    // rust: ["horizon-ctl click-slot 36", "horizon-ctl click-slot 100 right", "horizon-ctl click-slot 200 shift"],
    // rust: &[p("slot", Ty::Int, "slot id"), opt("right", Ty::Bool, "right-click"), opt("shift", Ty::Bool, "shift-click")], mcp: true, local: false),
    // rust: cmd!("close", Screens, "close", "close the open menu and return to the game", "", ["horizon-ctl close"], &[], mcp: true, local: false),
    // rust: cmd!("ui", Screens, "ui", "every widget of the open screen: id, kind, label, bounds, value",
    // rust: "Kinds: button, slider (value 0..1), field, row (worlds, servers, packs, languages), tab (selected), slot (slot-ID, with its stack). Ids come from labels (\"FOV: 70\" is fov, a repeat gets -2) or kind-N without one, and stay put when a value changes. Reflects the last drawn frame (frame counts them).",
    // rust: ["horizon-ctl ui"], &[], mcp: true, local: false),
    // rust: cmd!("click", Screens, "click ID [right|middle] [shift]", "click a widget of ui by its id, as the mouse would",
    // rust: "A field takes focus (then type); slot-ID clicks a slot like click-slot. middle presses the middle button (pick block: a creative player clones the stack).",
    // rust: ["horizon-ctl click done", "horizon-ctl click video-settings", "horizon-ctl click row-0", "horizon-ctl click slot-0 shift"],
    // rust: &[p("id", Ty::Str, "widget id from ui"), opt("right", Ty::Bool, "right-click"), opt("middle", Ty::Bool, "middle-click"), opt("shift", Ty::Bool, "shift-click (slots)")], mcp: true, local: false),
    // rust: cmd!("set", Screens, "set ID VALUE", "move a slider of ui to VALUE (0..1), as a click on its track",
    // rust: "The option behind it rounds to its own steps; read the new label with ui.",
    // rust: ["horizon-ctl set fov 0.5", "horizon-ctl set render-distance 0"],
    // rust: &[p("id", Ty::Str, "slider id from ui"), p("value", Ty::Num, "0..1 along the track")], mcp: true, local: false),
    // rust: cmd!("options-get", Screens, "options-get [KEY...]", "the game's options (options.txt) by key, with their type and range or choices",
    // rust: "Keys are vanilla's: fov, renderDistance, guiScale, gamma, maxFps, lang, resourcePacks, soundCategory_music, key_key.jump... Enums are given and set by name, key bindings by key name (key.keyboard.w).",
    // rust: ["horizon-ctl options-get", "horizon-ctl options-get fov renderDistance"], &[opt("keys", Ty::Rest, "option keys (default: all)")], mcp: true, local: false),
    // rust: cmd!("options-set", Screens, "options-set KEY VALUE", "set one option, apply it at once and save options.txt, as the options screen does",
    // rust: "A value the option refuses is an error saying what it accepts. Lists are JSON: options-set resourcePacks [\"vanilla\"].",
    // rust: ["horizon-ctl options-set fov 90", "horizon-ctl options-set renderClouds fast", "horizon-ctl options-set key_key.jump key.keyboard.j"],
    // rust: &[p("key", Ty::Str, "option key from options-get"), p("value", Ty::Rest, "the new value")], mcp: true, local: false),
    // rust: cmd!("click-button", Screens, "click-button LABEL", "click a button of the open screen or title menu by its label",
    // rust: "Case-insensitive; a unique part of the label is enough. screen lists the buttons.",
    // rust: ["horizon-ctl click-button Singleplayer", "horizon-ctl click-button \"Create New World\"", "horizon-ctl click-button respawn"],
    // rust: &[p("label", Ty::Rest, "button label")], mcp: true, local: false),
    // rust: cmd!("click-at", Screens, "click-at X Y [right]", "click at GUI pixel X Y of the window (screen gives button rectangles)", "",
    // rust: ["horizon-ctl click-at 200 120"], &[p("x", Ty::Num, "GUI x"), p("y", Ty::Num, "GUI y"), opt("right", Ty::Bool, "right-click")], mcp: true, local: false),
    // rust: cmd!("drag-at", Screens, "drag-at [right] X Y X Y...", "press at the first GUI point, move through the others, release at the last", "",
    // rust: ["horizon-ctl drag-at 130 100 148 100 166 100", "horizon-ctl drag-at right 130 100 148 100"], &[p("points", Ty::Rest, "right, then GUI x y pairs")], mcp: true, local: false),
    // rust: cmd!("scroll-at", Screens, "scroll-at X Y STEPS", "turn the mouse wheel at GUI pixel X Y (positive scrolls up)", "",
    // rust: ["horizon-ctl scroll-at 130 100 -1"], &[p("x", Ty::Num, "GUI x"), p("y", Ty::Num, "GUI y"), p("steps", Ty::Num, "wheel steps")], mcp: true, local: false),
    // rust: cmd!("type", Screens, "type [--field name|seed] [--replace] TEXT", "type into the focused text field (chat box, world name, anvil, sign...)",
    // rust: "On the title's create-world screen, --field name|seed picks the field and --replace clears it first; type \\b deletes one character.",
    // rust: ["horizon-ctl type hello everyone", "horizon-ctl type --field name --replace Agent World", "horizon-ctl type --field seed 12345"], &[flag("field", Ty::Enum(&["name", "seed"]), "create-world field to type into"), flag("replace", Ty::Bool, "clear the field first"), p("text", Ty::Rest, "text to type")], mcp: true, local: false),
    // rust: cmd!("chat", Screens, "chat TEXT", "send a chat line (or a /command) as if typed", "", ["horizon-ctl chat hello"],
    // rust: &[p("text", Ty::Rest, "message")], mcp: true, local: false),
    // rust: cmd!("command", Screens, "command TEXT", "run a command (the leading / is optional)", "",
    // rust: ["horizon-ctl command time set day", "horizon-ctl command /give @s oak_log 4"], &[p("command", Ty::Rest, "command line")], mcp: true, local: false),
    // rust: cmd!("respawn", Screens, "respawn", "respawn from the death screen", "", ["horizon-ctl respawn"], &[], mcp: true, local: false),
    // rust: cmd!("pause", Screens, "pause", "open the pause menu", "", ["horizon-ctl pause"], &[], mcp: true, local: false),
    // rust: cmd!("resume", Screens, "resume", "leave the pause menu", "", ["horizon-ctl resume"], &[], mcp: true, local: false),
    // rust: cmd!("options", Screens, "options [PAGE]", "open the options screen, or one of its pages (Horizon's too)",
    // rust: "Then ui lists its widgets and click, set and type change them, as with the mouse. options-set changes an options.txt value without the screen.",
    // rust: ["horizon-ctl options video", "horizon-ctl options horizon"], &[opt("page", PAGES, "the page (default: the main options)")], mcp: true, local: false),
    // rust: cmd!("book", Screens, "book [next|back|take|done]", "the open book or lectern: its page text, or press one of its buttons",
    // rust: "", ["horizon-ctl book", "horizon-ctl book next"], &[opt("action", Ty::Enum(&["next", "back", "take", "done"]), "a button to press")], mcp: true, local: false),
    // rust: cmd!("signedit", Screens, "signedit X Y Z [front|back]", "open the sign editor of the sign at X Y Z (then type and close)",
    // rust: "", ["horizon-ctl signedit 3 64 1"], &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], opt("side", Ty::Enum(&["front", "back"]), "which side")], mcp: true, local: false),
    // rust: cmd!("mount-menu", Screens, "mount-menu", "open the inventory of the horse, donkey, mule or llama being ridden",
    // rust: "As the inventory key does while riding; also opens the nearest one's.", ["horizon-ctl mount-menu"], &[], mcp: true, local: false),
    // rust: cmd!("chat-log", Screens, "chat-log [N]", "the newest N chat messages", "", ["horizon-ctl chat-log 5"], &[], mcp: false, local: false),
    // Multiplayer
    // rust: cmd!("connect", Multiplayer, "connect ADDRESS [NAME]", "join a multiplayer server, or a friend's world by its invite code, from the title screen",
    // rust: "ADDRESS is HOST[:PORT], or friend:CODE for an invite code. Only when the player asks: it reaches the network.",
    // rust: ["horizon-ctl connect play.example.net", "horizon-ctl connect localhost:25565", "horizon-ctl connect friend:0B33K-Q405Q-..."],
    // rust: &[p("address", Ty::Str, "HOST[:PORT] or friend:CODE"), opt("name", Ty::Str, "player name when offline")], mcp: true, local: false),
    // rust: cmd!("disconnect", Multiplayer, "disconnect", "leave the server, back to the server list", "", ["horizon-ctl disconnect"], &[], mcp: true, local: false),
    // rust: cmd!("servers", Multiplayer, "servers", "the Multiplayer screen's server list: name and address",
    // rust: "Add, edit and remove them on the Multiplayer screen (click-button Multiplayer, then ui).", ["horizon-ctl servers"], &[], mcp: true, local: false),
    // rust: cmd!("lan", Multiplayer, "lan open [PORT] [commands] [force] | lan close | lan status", "open the world to LAN (Open to LAN), stop, or see the guests",
    // rust: "PORT 0 or none picks one; commands lets guests use cheats; force forces the game mode. Only when the player asks.",
    // rust: ["horizon-ctl lan open", "horizon-ctl lan status", "horizon-ctl lan close"],
    // rust: &[p("action", Ty::Enum(&["open", "close", "status"]), "what to do"), opt("port", Ty::Int, "port for open"), opt("commands", Ty::Bool, "allow cheats"), opt("force", Ty::Bool, "force the game mode")], mcp: true, local: false),
    // rust: cmd!("friends", Multiplayer, "friends host|stop|status", "Play with Friends: share the open world behind an invite code, stop, or see who joined",
    // rust: "status gives the code: share it only when the player asks. Friends join with connect friend:CODE.",
    // rust: ["horizon-ctl friends host", "horizon-ctl friends status"], &[p("action", Ty::Enum(&["host", "stop", "status"]), "what to do")], mcp: true, local: false),
    // World
    // rust: cmd!("give", World, "give ITEM [COUNT]", "add items to the inventory", "", ["horizon-ctl give oak_log 16"],
    // rust: &[p("item", Ty::Str, "item id"), opt("count", Ty::Int, "how many (default 1)")], mcp: true, local: false),
    // rust: cmd!("time", World, "time TICKS", "set the time of day (0 sunrise, 6000 noon, 13000 night)", "", ["horizon-ctl time 6000"],
    // rust: &[p("ticks", Ty::Int, "day time")], mcp: true, local: false),
    // rust: cmd!("setblock", World, "setblock X Y Z BLOCK[props]", "set a block (with neighbour updates)", "", ["horizon-ctl setblock 0 64 0 stone"],
    // rust: &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], p("block", Ty::Str, "block state such as oak_stairs[facing=east]")], mcp: true, local: false),
    // rust: cmd!("summon", World, "summon KIND [X Y Z] [baby]", "spawn a mob (in front of the player without a position)", "Replies with its id.", ["horizon-ctl summon cow", "horizon-ctl summon pig 10 64 3 baby"],
    // rust: &[p("kind", Ty::Str, "mob type"), opt("x", Ty::Num, "X"), opt("y", Ty::Num, "Y"), opt("z", Ty::Num, "Z"), opt("baby", Ty::Bool, "a baby")], mcp: true, local: false),
    // rust: cmd!("effect", World, "effect ID SECONDS [AMPLIFIER] | effect clear", "give a status effect, or clear them all", "", ["horizon-ctl effect speed 30 1", "horizon-ctl effect clear"],
    // rust: &[p("id", Ty::Str, "effect id such as speed, or clear"), opt("seconds", Ty::Num, "duration"), opt("amplifier", Ty::Int, "level - 1 (default 0)")], mcp: true, local: false),
    // rust: cmd!("effects", World, "effects", "the player's active status effects", "", ["horizon-ctl effects"], &[], mcp: true, local: false),
    // rust: cmd!("xp", World, "xp LEVELS", "add experience levels (negative removes)", "", ["horizon-ctl xp 30"], &[p("levels", Ty::Int, "levels to add")], mcp: true, local: false),
    // rust: cmd!("enchant", World, "enchant ID LEVEL", "enchant the held item (a book stores it)", "", ["horizon-ctl enchant sharpness 5"],
    // rust: &[p("id", Ty::Str, "enchantment id"), p("level", Ty::Int, "level")], mcp: true, local: false),
    // rust: cmd!("potion", World, "potion ITEM POTION", "give a potion item", "", ["horizon-ctl potion splash_potion healing"],
    // rust: &[p("item", Ty::Enum(&["potion", "splash_potion", "lingering_potion", "tipped_arrow"]), "which item"), p("potion", Ty::Str, "potion id")], mcp: true, local: false),
    // rust: cmd!("fill", World, "fill X1 Y1 Z1 X2 Y2 Z2 BLOCK", "set a box of loaded blocks", "", ["horizon-ctl fill 0 64 0 4 64 4 glass"],
    // rust: &[BOX[0], BOX[1], BOX[2], BOX[3], BOX[4], BOX[5], p("block", Ty::Str, "block state")], mcp: true, local: false),
    // rust: cmd!("container", World, "container X Y Z [ITEM COUNT]", "list a container's items, or add items to it", "", ["horizon-ctl container 3 64 1", "horizon-ctl container 3 64 1 diamond 3"],
    // rust: &[BLOCK_XYZ[0], BLOCK_XYZ[1], BLOCK_XYZ[2], opt("item", Ty::Str, "item to add"), opt("count", Ty::Int, "how many")], mcp: true, local: false),
    // rust: cmd!("render-distance", World, "render-distance N", "chunks, 2..128", "", ["horizon-ctl render-distance 8"], &[p("chunks", Ty::Int, "render distance")], mcp: false, local: false),
    // rust: cmd!("wait", World, "wait TICKS", "wait until TICKS game ticks have passed (20 per second)",
    // rust: "Keys and mouse buttons held with key ... down or mouse ... down stay held while it waits. Release them with key ... up, release or stop.",
    // rust: ["horizon-ctl wait 40", "horizon-ctl key w down && horizon-ctl wait 40 && horizon-ctl key w up"],
    // rust: &[p("ticks", Ty::Int, "game ticks")], mcp: true, local: false),
    // Scripting
    // rust: cmd!("script", Scripting, "script [FILE] [--keep-going]", "run commands from FILE (or stdin), one per line",
    // rust: "Lines are split like a shell (quotes keep spaces); # starts a comment; sleep SECONDS waits. Stops at the first error unless --keep-going. horizon-ctl - is the older form: read stdin and keep going.",
    // rust: ["horizon-ctl script play.txt", "printf 'state\\ngoto 0 64 0\\n' | horizon-ctl script"], &[], mcp: false, local: true),
    // rust: cmd!("sleep", Scripting, "sleep SECONDS", "wait (in scripts)", "", ["sleep 0.5"], &[], mcp: false, local: true),
    // rust: cmd!("mcp", Scripting, "mcp", "serve the Model Context Protocol on stdin/stdout, one tool per command",
    // rust: "Add it to an MCP client as a stdio server: command horizon-ctl, args [\"mcp\"] (with --socket PATH first if needed). The screenshot tool returns the image.",
    // rust: ["horizon-ctl mcp"], &[], mcp: false, local: true),
    // rust: cmd!("bench", Scripting, "bench SECONDS", "reset frame stats, wait, reply with the summary", "", ["horizon-ctl bench 10"], &[p("seconds", Ty::Num, "how long to measure")], mcp: true, local: false),
    // rust: cmd!("stats", Scripting, "stats [reset] [raw]", "frame-time summary since the last reset", "", ["horizon-ctl stats"], &[opt("reset", Ty::Bool, "start counting again"), opt("raw", Ty::Bool, "every frame time too (frame_ms, cpu_ms, gpu_ms)")], mcp: true, local: false),
    // rust: cmd!("gpu-passes", Scripting, "gpu-passes [on|off]", "time Horizon's own render passes on the GPU, shown in F3 and in stats and bench", "", ["horizon-ctl gpu-passes on"], &[opt("mode", Ty::Enum(&["on", "off"]), "on or off; without it, only reports")], mcp: false, local: false),
    // rust: cmd!("trace", Scripting, "trace [FILE [SECONDS] | stop]", "write every thread's timed spans to FILE as a timeline that ui.perfetto.dev opens, for SECONDS or until stop",
    // rust: "Each span (ticks by system, streaming, uploads, far terrain, lighting, the renderer) shows on the thread that ran it, nested by time. Without arguments, only reports whether a trace is being written. HORIZON_TRACE=FILE writes one from the start; horizon-trace on a dedicated server's console writes one to reports/. See docs/graphics.md.",
    // rust: ["horizon-ctl trace /tmp/frame.json 10", "horizon-ctl trace stop"], &[], mcp: false, local: false),
    // rust: cmd!("render-capture", Scripting, "render-capture on|off|DIR", "keep CPU copies of the meshes the renderer draws (on), or write the next frame's scene to DIR for the scene_replay example",
    // rust: "on meshes every section and far tile again so the copies are complete (HORIZON_RENDER_CAPTURE=1 keeps them from the start). DIR gets the camera, frame inputs, settings and every resident near section and far tile mesh; entities, particles, weather, the hand and the HUD are left out. See docs/graphics.md.",
    // rust: ["horizon-ctl render-capture on", "horizon-ctl render-capture /tmp/scene"], &[], mcp: false, local: false),
    // rust: cmd!("fly", Scripting, "fly X1 Y1 Z1 X2 Y2 Z2 SECONDS [PITCH [raw]]", "fly the camera along a line, then reply with the frame summary",
    // rust: "The reply's tick_ms and tick_ms_max are the world's smoothed tick time over the flight (the server thread's when single player runs on one). With raw, the reply also lists every frame time in milliseconds (frame_ms).",
    // rust: ["horizon-ctl fly 0 100 0 500 100 0 20"], &[], mcp: false, local: false),
    // Repro recordings
    // rust: cmd!("record-start", Scripting, "record-start [NAME] [--no-world]", "record input, state and the world for a bug repro",
    // rust: "Writes recordings/<stamp>-NAME/: inputs.jsonl (who caused each input: user, agent or game), state.jsonl (the player and world every second), events.jsonl and, in single player, a copy of the world. The recording starts from a fresh save. Replies once the world copy is done.",
    // rust: ["horizon-ctl record-start repro-bug", "horizon-ctl record-start --no-world"], &[opt("name", Ty::Str, "folder name after the timestamp (default session)"), flag("no-world", Ty::Bool, "do not copy the world (a server session)")], mcp: true, local: false),
    // rust: cmd!("record-stop", Scripting, "record-stop [--export]", "stop the recording (and write the repro zip)",
    // rust: "Without --export only the recording folder is closed; repro-export zips it later. With --export the reply carries the zip path.",
    // rust: ["horizon-ctl record-stop", "horizon-ctl record-stop --export"], &[flag("export", Ty::Bool, "write the repro bundle too")], mcp: true, local: false),
    // rust: cmd!("record-status", Scripting, "record-status", "the running recording and replay, if any", "",
    // rust: ["horizon-ctl record-status"], &[], mcp: true, local: false),
    // rust: cmd!("record-list", Scripting, "record-list", "the recordings and repro bundles on disk", "", ["horizon-ctl record-list"], &[], mcp: true, local: false),
    // rust: cmd!("record-replay", Scripting, "record-replay NAME [--stop] [--in-place] [--keep-world] [--timeout S]", "replay a recording, best effort",
    // rust: "Loads the recording's world copy into saves/, opens it and feeds the recorded input back at its ticks. Only input and movement commands replay (never world, network or account ones). --in-place feeds the input into the world already open (a server recording needs it); --keep-world leaves the copied world behind when it ends. --stop ends a running replay. Same build and machine only; state.jsonl is the oracle, not a promise.",
    // rust: ["horizon-ctl record-replay repro-bug", "horizon-ctl record-replay repro-bug --stop", "horizon-ctl record-replay server-fight --in-place"],
    // rust: &[opt("name", Ty::Str, "recording from record-list"), flag("stop", Ty::Bool, "stop the running replay"), flag("in-place", Ty::Bool, "feed the open world instead of opening the copy"), flag("keep-world", Ty::Bool, "leave the copied world in saves/"), flag("timeout", Ty::Int, "give up after this many seconds (default 300)")], mcp: true, local: false),
    // rust: cmd!("repro-export", Scripting, "repro-export [NAME] [PATH] [--no-world]", "zip a recording with the logs, crash report and status",
    // rust: "Writes repro/<stamp>-NAME.zip: the recording, logs/latest.log, the newest crash report, a status.json and a README. The player attaches it to the bug report; nothing is uploaded. Stops a running recording first.",
    // rust: ["horizon-ctl repro-export", "horizon-ctl repro-export repro-bug out.zip"], &[opt("name", Ty::Str, "recording from record-list (default the newest)"), opt("path", Ty::Str, "where to write the zip"), flag("no-world", Ty::Bool, "leave the world out")], mcp: true, local: false),
    // rust: ];

find :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: COMMANDS.iter().find(|c| c.name == name)
}

// `horizon-ctl help`.
overview :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::from(
    // rust: "horizon-ctl: play and script a running Horizon from the command line.\n\n\
    // rust: usage: horizon-ctl [--socket PATH] [--timeout SECONDS] [--api LINE] [--pretty] COMMAND [ARGS...]\n\
    // rust: \x20      horizon-ctl COMMAND --help      (or: horizon-ctl help COMMAND)\n",
    // rust: );
    // rust: for group in Group::ALL {
    // rust: out.push_str(&format!("\n{}:\n", group.title()));
    // rust: for c in COMMANDS.iter().filter(|c| c.group == group) {
    // rust: out.push_str(&format!("  {:<16} {}\n", c.name, c.summary));
}
}
    // rust: out.push_str(
    // rust: "\nEvery reply is one JSON line. Errors are {\"error\": \"...\"}; the exit status is 0 on\n\
    // rust: success, 1 when the game replied with an error, 2 for a usage error, 3 when the\n\
    // rust: game cannot be reached or started, 4 while No AI is on (the launcher's settings) and 5 when\n\
    // rust: --api LINE (such as --api 0.1) names a protocol line the game's hello does not report.\n\
    // rust: Actions (goto, break, place...) block until done.\n\
    // rust: horizon-ctl help --game lists the running game's own commands, test hooks included.\n\
    // rust: The socket is $HORIZON_CONTROL, else $XDG_RUNTIME_DIR/horizon-control.sock (on Windows\n\
    // rust: %TEMP%\\horizon-control.json, a localhost TCP port with a token; any path ending in .json\n\
    // rust: uses that transport).\n\n\
    // rust: First steps:\n\
    // rust: \x20 horizon-ctl launch --world Test --seed 1 --wait\n\
    // rust: \x20 horizon-ctl state\n\
    // rust: \x20 horizon-ctl find-block oak_log\n\
    // rust: \x20 horizon-ctl goto X Y Z --near 2 && horizon-ctl break X Y Z\n\
    // rust: \x20 horizon-ctl inventory\n",
    // rust: );
    // rust: out
}

// `horizon-ctl COMMAND --help`.
detail :: proc(c: ^Cmd) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = format!(
    // rust: "usage: horizon-ctl {}\n\n{}.\n",
    // rust: c.usage,
    // rust: capitalize(c.summary)
    // rust: );
    // rust: if !c.details.is_empty() {
    // rust: out.push('\n');
    // rust: out.push_str(&wrap(c.details, 78));
}
    // rust: if !c.examples.is_empty() {
    // rust: out.push_str("\nExamples:\n");
    // rust: for e in c.examples {
    // rust: out.push_str(&format!("  {e}\n"));
}
}
    // rust: out
}

// The commands whose replies are described so far, one group at a time: the test
// requires each to name its fields.
REPLY_GROUP :: &["hello", "status"]

// The JSON schema of a command's reply, or none while its reply is undescribed.
reply_schema :: proc(c: ^Cmd) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if c.reply.is_empty() {
    // rust: return None;
}
    // rust: let mut props = Map::new();
    // rust: let mut required = Vec::new();
    // rust: for fld in c.reply {
    // rust: let types: Vec<&str> = fld.ty.split('|').collect();
    // rust: let ty = if types.len() == 1 {
    // rust: json!(types[0])
    // rust: } else {
    // rust: json!(types)
}
    // rust: props.insert(
    // rust: fld.name.to_owned(),
    // rust: json!({ "type": ty, "description": fld.help }),
    // rust: );
    // rust: required.push(fld.name);
}
    // rust: Some(json!({ "type": "object", "properties": props, "required": required }))
}

// The generated reference, docs/horizon-ctl-commands.md (`horizon-ctl help --markdown`).
markdown :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let cell = |s: &str| s.replace('|', "\\|");
    // rust: let mut out = String::from(
    // rust: "<!-- Generated by `horizon-ctl help --markdown` from the command table in \
    // rust: crates/horizon-client/src/bin/horizon-ctl/commands.rs: edit the table, then regenerate. -->\n\
    // rust: # horizon-ctl commands\n\n\
    // rust: Every command `horizon-ctl` takes, its MCP tool in `horizon-ctl mcp` (the launcher's \
    // rust: `horizon-launcher mcp` offers the same tools as `game_<tool>`, all but `launch`) and its \
    // rust: arguments. Positional arguments come first, in order; `--flags` after them. \
    // rust: `horizon-ctl help --game` lists the game's own commands, test hooks included. \
    // rust: Design rules and the full inventory: [agent-control.md](agent-control.md).\n",
    // rust: );
    // rust: for group in Group::ALL {
    // rust: out.push_str(&format!(
    // rust: "\n## {}\n\n| Command | MCP tool | What it does | Arguments |\n| --- | --- | --- | --- |\n",
    // rust: group.title()
    // rust: ));
    // rust: for c in COMMANDS.iter().filter(|c| c.group == group) {
    // rust: let tool = if c.mcp {
    // rust: let mut t = format!("`{}`", tool_name(c));
    // rust: if DESTRUCTIVE.contains(&c.name) {
    // rust: t.push_str(" (destructive)");
    // rust: } else if OPEN_WORLD.contains(&c.name) {
    // rust: t.push_str(" (network)");
}
    // rust: t
    // rust: } else {
    // rust: "CLI only".to_owned()
}
    // rust: let args: Vec<String> = c
    // rust: .params
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let ty = match p.ty {
    // rust: Ty::Int => "integer".to_owned(),
    // rust: Ty::Num => "number".to_owned(),
    // rust: Ty::Str => "string".to_owned(),
    // rust: Ty::Rest => "text".to_owned(),
    // rust: Ty::Bool => "boolean".to_owned(),
    // rust: Ty::Enum(v) => v.join(", "),
}
    // rust: let name = if p.flag {
    // rust: format!("--{}", p.name)
    // rust: } else {
    // rust: p.name.to_owned()
}
    // rust: let need = if p.required { ", required" } else { "" };
    // rust: format!("`{name}` ({ty}{need}): {}", cell(p.help))
    // rust: })
    // rust: .collect();
    // rust: out.push_str(&format!(
    // rust: "| `{}` | {} | {} | {} |\n",
    // rust: cell(c.usage),
    // rust: tool,
    // rust: cell(&capitalize(c.summary)),
    // rust: if args.is_empty() {
    // rust: "none".to_owned()
    // rust: } else {
    // rust: args.join("<br>")
}
    // rust: ));
}
}
    // rust: out.push_str(
    // rust: "\n## Replies\n\nThe reply fields of the commands described so far (more follow, a group at a \
    // rust: time). Each reply is one JSON object; a type ending in `null` may be `null` when the field \
    // rust: does not apply. A reader ignores keys it does not know: replies may gain fields within a \
    // rust: protocol line. The MCP tool list declares the same fields as `outputSchema`.\n",
    // rust: );
    // rust: for c in COMMANDS.iter().filter(|c| !c.reply.is_empty()) {
    // rust: out.push_str(&format!(
    // rust: "\n### `{}`\n\n| Field | Type | Meaning |\n| --- | --- | --- |\n",
    // rust: c.name
    // rust: ));
    // rust: for fld in c.reply {
    // rust: out.push_str(&format!(
    // rust: "| `{}` | {} | {} |\n",
    // rust: fld.name,
    // rust: fld.ty.replace('|', ", "),
    // rust: cell(fld.help)
    // rust: ));
}
}
    // rust: out
}

capitalize :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut chars = s.chars();
    // rust: chars
    // rust: .next()
    // rust: .map(|c| c.to_uppercase().chain(chars).collect())
    // rust: .unwrap_or_default()
}

wrap :: proc(text: string, width: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: let mut line = String::new();
    // rust: for word in text.split_whitespace() {
    // rust: if !line.is_empty() && line.len() + 1 + word.len() > width {
    // rust: out.push_str(&line);
    // rust: out.push('\n');
    // rust: line.clear();
}
    // rust: if !line.is_empty() {
    // rust: line.push(' ');
}
    // rust: line.push_str(word);
}
    // rust: if !line.is_empty() {
    // rust: out.push_str(&line);
    // rust: out.push('\n');
}
    // rust: out
}

// The MCP tool name of a command (`look-at-block` gives `look_at_block`).
tool_name :: proc(c: ^Cmd) -> S {
    // Ported from Horizon
    return {}
}
    // rust: c.name.replace('-', "_")
}

// The JSON schema of a command's arguments.
schema :: proc(c: ^Cmd) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut props = Map::new();
    // rust: let mut required = Vec::new();
    // rust: for p in c.params {
    // rust: let mut s = match p.ty {
    // rust: Ty::Int => json!({ "type": "integer" }),
    // rust: Ty::Num => json!({ "type": "number" }),
    // rust: Ty::Str | Ty::Rest => json!({ "type": "string" }),
    // rust: Ty::Bool => json!({ "type": "boolean" }),
    // rust: Ty::Enum(values) => json!({ "type": "string", "enum": values }),
}
    // rust: s["description"] = json!(p.help);
    // rust: props.insert(p.name.to_owned(), s);
    // rust: if p.required {
    // rust: required.push(p.name);
}
}
    // rust: json!({ "type": "object", "properties": props, "required": required })
}

// The command line for an MCP call's arguments: positional values in order,
// then `--flag value` options.
line_for :: proc(c: ^Cmd, args: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut words: Vec<String> = c
    // rust: .wire
    // rust: .unwrap_or(c.name)
    // rust: .split(' ')
    // rust: .map(str::to_owned)
    // rust: .collect();
    // rust: let mut flags = Vec::new();
    // rust: let mut gap: Option<&str> = None;
    // rust: let mut rest: Option<String> = None;
    // rust: for p in c.params {
    // rust: let value = args.get(p.name).filter(|v| !v.is_null());
    // rust: let text = match value {
    // rust: None => {
    // rust: if p.required {
    // rust: return Err(format!("{} is required", p.name));
}
    // rust: if !p.flag {
    // rust: gap.get_or_insert(p.name);
}
    // rust: continue;
}
    // rust: Some(Value::Bool(b)) => {
    // rust: if p.ty != Ty::Bool {
    // rust: return Err(format!("{} must be a {}", p.name, ty_name(p.ty)));
}
    // rust: if *b {
    // rust: if p.flag {
    // rust: flags.push(format!("--{}", p.name));
    // rust: } else {
    // rust: words.push(p.name.to_owned());
}
}
    // rust: continue;
}
    // rust: Some(Value::String(s)) => s.clone(),
    // rust: Some(Value::Number(n)) => n.to_string(),
    // rust: Some(other) => {
    // rust: return Err(format!(
    // rust: "{} must be a {}, not {other}",
    // rust: p.name,
    // rust: ty_name(p.ty)
    // rust: ));
}
}
    // rust: match p.ty {
    // rust: Ty::Int if text.parse::<i64>().is_err() => {
    // rust: return Err(format!("{} must be an integer, not {text}", p.name));
}
    // rust: Ty::Num if text.parse::<f64>().is_err() => {
    // rust: return Err(format!("{} must be a number, not {text}", p.name));
}
    // rust: Ty::Enum(values) if !values.contains(&text.as_str()) => {
    // rust: return Err(format!("{} must be one of {values:?}, not {text}", p.name));
}
    // rust: _ => {}
}
    // rust: if p.flag {
    // rust: flags.push(format!("--{}", p.name));
    // rust: flags.push(text);
    // rust: } else {
    // rust: if let Some(missing) = gap {
    // rust: return Err(format!("{} needs {missing} to be given too", p.name));
}
    // rust: if p.ty == Ty::Rest {
    // rust: rest = Some(text);
    // rust: } else if text.contains(char::is_whitespace) || text.is_empty() {
    // rust: return Err(format!("{} must be a single word", p.name));
    // rust: } else {
    // rust: words.push(text);
}
}
}
    // Options go before free text, which runs to the end of the line.
    // rust: words.extend(flags);
    // rust: words.extend(rest);
    // rust: Ok(words)
}

ty_name :: proc(ty: Ty) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match ty {
    // rust: Ty::Int => "integer",
    // rust: Ty::Num => "number",
    // rust: Ty::Bool => "boolean",
    // rust: _ => "string",
}
}

    // rust: mod tests {
//     use super::*;

names_are_unique_and_documented :: proc() {
}
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for c in COMMANDS {
    // rust: assert!(seen.insert(c.name), "duplicate command {}", c.name);
    // rust: assert!(
    // rust: c.usage.starts_with(c.name.split('-').next().unwrap()),
    // rust: "{}",
    // rust: c.name
    // rust: );
    // rust: assert!(
    // rust: !c.summary.is_empty() && !c.examples.is_empty(),
    // rust: "{}",
    // rust: c.name
    // rust: );
}
}

mcp_arguments_become_command_lines :: proc() {
}
    // rust: let goto = find("goto").unwrap();
    // rust: let words = line_for(
    // rust: goto,
    // rust: &json!({ "x": 1.5, "y": 64, "z": -3, "near": 2, "sprint": true }),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: words,
    // rust: ["goto", "1.5", "64", "-3", "--near", "2", "--sprint"]
    // rust: );
    // rust: assert!(
    // rust: line_for(goto, &json!({ "x": 1, "y": 2 }))
    // rust: .unwrap_err()
    // rust: .contains("z is required")
    // rust: );
    // rust: assert!(line_for(goto, &json!({ "x": "a", "y": 2, "z": 3 })).is_err());
    // rust: let block = find("look-at-block").unwrap();
    // rust: assert_eq!(
    // rust: line_for(block, &json!({ "x": 1, "y": 2, "z": 3, "face": "up" })).unwrap(),
    // rust: ["look-at", "block", "1", "2", "3", "up"]
    // rust: );
    // rust: assert!(
    // rust: line_for(
    // rust: block,
    // rust: &json!({ "x": 1, "y": 2, "z": 3, "face": "sideways" })
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: let turn = find("turn").unwrap();
    // rust: assert_eq!(
    // rust: line_for(turn, &json!({ "dyaw": -90, "dpitch": 10.5, "over": 0.5 })).unwrap(),
    // rust: ["turn", "-90", "10.5", "--over", "0.5"]
    // rust: );
    // rust: let mouse = find("mouse-move").unwrap();
    // rust: assert_eq!(tool_name(mouse), "mouse_move");
    // rust: assert_eq!(
    // rust: line_for(mouse, &json!({ "dx": -25, "dy": 40 })).unwrap(),
    // rust: ["mouse-move", "-25", "40"]
    // rust: );
    // rust: assert_eq!(
    // rust: line_for(block, &json!({ "x": 1, "y": 2, "z": 3, "over": 0.3 })).unwrap(),
    // rust: ["look-at", "block", "1", "2", "3", "--over", "0.3"]
    // rust: );
    // rust: let button = find("click-button").unwrap();
    // rust: assert_eq!(
    // rust: line_for(button, &json!({ "label": "Create New World" })).unwrap(),
    // rust: ["click-button", "Create New World"]
    // rust: );
    // rust: let slot = find("click-slot").unwrap();
    // rust: assert_eq!(
    // rust: line_for(slot, &json!({ "slot": 200, "shift": true })).unwrap(),
    // rust: ["click-slot", "200", "shift"]
    // rust: );
    // rust: let open = find("open").unwrap();
    // rust: assert!(
    // rust: line_for(open, &json!({ "world": "A", "mode": "creative" }))
    // rust: .unwrap_err()
    // rust: .contains("seed")
    // rust: );
}

schemas_list_required_parameters :: proc() {
}
    // rust: let s = schema(find("break").unwrap());
    // rust: assert_eq!(s["required"], json!(["x", "y", "z"]));
    // rust: assert_eq!(s["properties"]["timeout"]["type"], "number");
    // rust: assert_eq!(tool_name(find("look-at-entity").unwrap()), "look_at_entity");
}

every_command_in_the_reply_group_names_its_reply_fields :: proc() {
}
    // rust: for name in REPLY_GROUP {
    // rust: let c = find(name).unwrap_or_else(|| panic!("{name} is not a command"));
    // rust: assert!(!c.reply.is_empty(), "{name} names no reply fields");
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for fld in c.reply {
    // rust: assert!(seen.insert(fld.name), "{name}: {} twice", fld.name);
    // rust: assert!(!fld.help.is_empty(), "{name}.{} has no meaning", fld.name);
    // rust: for t in fld.ty.split('|') {
    // rust: assert!(
    // rust: [
    // rust: "string", "integer", "number", "boolean", "array", "object", "null"
    // rust: ]
    // rust: .contains(&t),
    // rust: "{name}.{}: unknown type {t}",
    // rust: fld.name
    // rust: );
}
}
    // rust: assert_eq!(
    // rust: reply_schema(c).unwrap()["required"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .len(),
    // rust: c.reply.len()
    // rust: );
}
        // Nothing outside the group claims a reply the group list does not cover.
    // rust: for c in COMMANDS.iter().filter(|c| !c.reply.is_empty()) {
    // rust: assert!(
    // rust: REPLY_GROUP.contains(&c.name),
    // rust: "{} has fields but is not in REPLY_GROUP",
    // rust: c.name
    // rust: );
}
    // rust: assert_eq!(
    // rust: reply_schema(find("hello").unwrap()).unwrap()["properties"]["features"]["type"],
    // rust: "array"
    // rust: );
    // rust: assert_eq!(
    // rust: reply_schema(find("status").unwrap()).unwrap()["properties"]["player"]["type"],
    // rust: json!(["object", "null"])
    // rust: );
}

the_generated_reference_is_up_to_date :: proc() {
}
    // rust: let path = concat!(
    // rust: env!("CARGO_MANIFEST_DIR"),
    // rust: "/../../docs/horizon-ctl-commands.md"
    // rust: );
    // rust: let on_disk = std::fs::read_to_string(path).unwrap_or_default();
    // rust: assert!(
    // rust: on_disk == markdown(),
    // rust: "docs/horizon-ctl-commands.md is out of date: run `horizon-ctl help --markdown > docs/horizon-ctl-commands.md`"
    // rust: );
    // rust: for c in COMMANDS {
    // rust: assert!(
    // rust: on_disk.contains(&format!("`{}", c.usage.replace('|', "\\|"))),
    // rust: "{} undocumented",
    // rust: c.name
    // rust: );
}
}

destructive_and_network_tools_exist :: proc() {
}
    // rust: for name in DESTRUCTIVE.iter().chain(OPEN_WORLD) {
    // rust: assert!(find(name).is_some_and(|c| c.mcp), "{name}");
}
    // rust: let delete = find("world-delete").unwrap();
    // rust: assert_eq!(
    // rust: line_for(delete, &json!({ "folder": "A", "confirm": true })).unwrap(),
    // rust: ["world-delete", "A", "--confirm"]
    // rust: );
    // rust: let lan = find("lan").unwrap();
    // rust: assert_eq!(
    // rust: line_for(lan, &json!({ "action": "open", "commands": true })).unwrap(),
    // rust: ["lan", "open", "commands"]
    // rust: );
}

help_mentions_every_command :: proc() {
}
    // rust: let text = overview();
    // rust: for c in COMMANDS {
    // rust: assert!(text.contains(c.name));
    // rust: assert!(detail(c).contains("usage: horizon-ctl"));
}
}
}
