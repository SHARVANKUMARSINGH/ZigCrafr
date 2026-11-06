//! Transpiled from Horizon Rust crate
package horizon_client_advancements

import "core:fmt"
import "core:mem"
import "core:math"

// Advancements: the tree loaded from `data/*/advancement`, the player's
// progress (`PlayerAdvancements`) and the predicates criteria test
// (`EntityPredicate`, `ItemPredicate`, `LocationPredicate`, the loot
// conditions advancements use).
// use horizon_world::lazy_json::LazyJson;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex, Weak},
}

Frame :: enum {
    Task,
    Goal,
    Challenge,
}
Display :: struct {
    icon: string,
    title: Value,
    description: Value,
    frame: Frame,
    background: Maybe(string),
    show_toast: bool,
    announce: bool,
    hidden: bool,
}
Criterion :: struct {
    name: string,
    trigger: string,
    // Read on first test: ~1,300 recipe advancements' criteria, most never
    // tested in a game, took ~4 MB as `Value`s.
    conditions: LazyJson,
}
Rewards :: struct {
    recipes: [dynamic]string,
    experience: i32,
    loot: [dynamic]string,
    function: Maybe(string),
}
Advancement :: struct {
    id: string,
    parent: Maybe(string),
    display: Maybe(Display),
    criteria: [dynamic]Criterion,
    requirements: [dynamic]Vec<string>,
    rewards: Rewards,
}
// Every advancement, indexed by id and by trigger.
Tree :: struct {
    list: [dynamic]Advancement,
    by_id: HashMap<string,
    // trigger id -> (advancement index, criterion index).
    by_trigger: HashMap<string,
    // `recipe_unlocked` criteria by the recipe they name (`index_recipes`);
    // those naming none in `recipes_any`.
    by_recipe: HashMap<string,
    recipes_any: Vec<(uint,
    // The triggers with a criterion that may test what the player looks at
    // (`index_looking_at`).
    looking_at_triggers: BTreeSet<string>,
    // The triggers with a criterion that may test an entity's `nbt`
    // (`index_nbt`).
    nbt_triggers: BTreeSet<string>,
    // What the criteria of each trigger may ask of the player's level,
    // statistics, advancements and recipes (`index_player_facts`).
    player_fact_triggers: HashMap<string,
}
// Which of `PlayerPredicate`'s level, `stats`, `advancements` and `recipes`
// a trigger's criteria may test: only those are filled in its player view.
FactsAsked :: struct {
    level: bool,
    stats: bool,
    advancements: bool,
    recipes: bool,
}
    // rust: impl FactsAsked {
    // rust: pub const ALL: Self = Self {
    // rust: level: true,
    // rust: stats: true,
    // rust: advancements: true,
    // rust: recipes: true,
}
    // Asked by either.
or :: proc(self: ^Self, other: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: level: self.level || other.level,
    // rust: stats: self.stats || other.stats,
    // rust: advancements: self.advancements || other.advancements,
    // rust: recipes: self.recipes || other.recipes,
}
}
}
// What `v` (a predicate, a list of conditions or an item modifier) may ask
// of the player's level, statistics, advancements and recipes: the fields
// of its player predicates, and all four for a `minecraft:reference` to a
// predicate file. Walked without reading anything else, for the commands
// that test a predicate on the player.
facts_asked_in :: proc(v: ^Value) -> F {
    // Ported from Horizon
    return {}
}
    // rust: let mut asked = FactsAsked::default();
    // rust: let mut todo = vec![v];
    // rust: while let Some(v) = todo.pop() {
    // rust: match v {
    // rust: Value::Array(list) => todo.extend(list),
    // rust: Value::Object(o) => {
                // A predicate file, or (`function`) an item modifier file.
    // rust: let kind =
    // rust: (o.get("condition").or_else(|| o.get("type"))).or_else(|| o.get("function"));
    // rust: if kind
    // rust: .and_then(Value::as_str)
    // rust: .is_some_and(|k| full(k) == "minecraft:reference")
    // rust: {
    // rust: return FactsAsked::ALL;
}
    // rust: for (key, value) in o {
    // rust: if full(key) == "minecraft:type_specific/player"
    // rust: && let Some(p) = value.as_object()
    // rust: {
    // rust: asked = asked.or(FactsAsked {
    // rust: level: p.contains_key("level"),
    // rust: stats: p.contains_key("stats"),
    // rust: advancements: p.contains_key("advancements"),
    // rust: recipes: p.contains_key("recipes"),
    // rust: });
}
    // rust: todo.push(value);
}
}
    // rust: _ => {}
}
}
    // rust: asked
}
frame :: proc(v: ^Value) -> F {
    // Ported from Horizon
    return {}
}
    // rust: match v.as_str() {
    // rust: Some("goal") => Frame::Goal,
    // rust: Some("challenge") => Frame::Challenge,
    // rust: _ => Frame::Task,
}
}
    // rust: impl Tree {
    // [`Tree::load`], shared while anyone holds it: a server's advancement
    // packets (`ServerAdvancements`) and its game's criteria read the same
    // files, and each kept its own copy (7 MB). A world whose data packs bring
    // advancements gets its own tree ([`Tree::load_with`]).
shared :: proc(data: ^Path, overlay: ^horizon_world::loot::PackOverlay) -> A {
    // Ported from Horizon
    return {}
}
    // rust: if overlay.kind("advancement").next().is_some() {
    // rust: return Arc::new(Tree::load_with(data, overlay));
}
TREES :: Mutex::new(Vec::new())
        // Held while loading: a second reader waits for the first one's tree.
    // rust: let mut trees = TREES.lock().unwrap_or_else(|e| e.into_inner());
    // rust: trees.retain(|(_, tree)| tree.strong_count() > 0);
    // rust: if let Some(tree) = trees
    // rust: .iter()
    // rust: .find(|(path, _)| path == data)
    // rust: .and_then(|(_, tree)| tree.upgrade())
    // rust: {
    // rust: return tree;
}
    // rust: let tree = Arc::new(Tree::load(data));
    // rust: trees.push((data.to_path_buf(), Arc::downgrade(&tree)));
    // rust: tree
}
    // Loads `<data>/<namespace>/advancement/**/*.json`.
load :: proc(data: ^Path) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Self::load_with(data, &horizon_world::loot::PackOverlay::NONE)
}
    // The tree with a world's data packs' advancement files over the game's
    // own: the top pack's file for each id replaces it.
load_with :: proc(data: ^Path, overlay: ^horizon_world::loot::PackOverlay) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tree = Tree::default();
    // rust: let Ok(namespaces) = std::fs::read_dir(data) else {
    // rust: return tree;
}
        // One JSON per id, the packs' over the game's own. Through `json_folder`: from
        // the prepared data file, and read once while a load holds the folder.
    // rust: let mut json: BTreeMap<String, Value> = BTreeMap::new();
    // rust: for ns in namespaces.flatten() {
    // rust: let Ok(folder) = horizon_world::json_folder::read(&ns.path().join("advancement"))
    // rust: else {
    // rust: continue;
}
    // rust: let ns = ns.file_name().to_string_lossy().into_owned();
    // rust: for file in &folder.files {
    // rust: if let Ok(v) = serde_json::from_slice::<Value>(file.bytes().unwrap_or_default()) {
    // rust: json.insert(format!("{ns}:{}", file.name), v);
}
}
}
    // rust: for (id, files) in overlay.kind("advancement") {
    // rust: match serde_json::from_slice::<Value>(horizon_world::loot::PackOverlay::top(files)) {
    // rust: Ok(v) => {
    // rust: json.insert(id.to_owned(), v);
}
    // rust: Err(e) => log::warn!("Horizon: pack advancement {id} not loaded: {e}"),
}
}
    // rust: for (id, v) in json {
    // rust: if let Some(a) = parse(&id, &v) {
    // rust: let index = tree.list.len();
    // rust: for (ci, c) in a.criteria.iter().enumerate() {
    // rust: tree.by_trigger
    // rust: .entry(c.trigger.clone())
    // rust: .or_default()
    // rust: .push((index, ci));
}
    // rust: tree.by_id.insert(id, index);
    // rust: tree.list.push(a);
}
}
    // rust: tree.index_recipes();
    // rust: tree.index_looking_at();
    // rust: tree.index_nbt();
    // rust: tree.index_player_facts();
    // rust: tree
}
    // Index the `recipe_unlocked` criteria by recipe: a grant that unlocks
    // twenty recipes tested every one of the ~1,300 recipe advancements'
    // criteria for each (several ms in one tick).
index_recipes :: proc(self: ^Self) {
}
    // rust: self.by_recipe.clear();
    // rust: self.recipes_any.clear();
    // rust: for &(ai, ci) in self
    // rust: .by_trigger
    // rust: .get("minecraft:recipe_unlocked")
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
            // `read`: the index alone keeps none of the criteria read.
    // rust: match self.list[ai].criteria[ci].conditions.read()["recipes"].as_str() {
    // rust: Some(r) => self
    // rust: .by_recipe
    // rust: .entry(full(r).into_owned())
    // rust: .or_default()
    // rust: .push((ai, ci)),
    // rust: None => self.recipes_any.push((ai, ci)),
}
}
}
    // Index the triggers whose criteria name `looking_at`, or a
    // `minecraft:reference` to a predicate file that might: the text is
    // searched, nothing is read.
index_looking_at :: proc(self: ^Self) {
}
    // rust: let reference = ["\"minecraft:reference\"", "\"reference\""];
    // rust: self.looking_at_triggers = (self.list.iter().flat_map(|a| &a.criteria))
    // rust: .filter(|c| {
    // rust: let json = c.conditions.json();
    // rust: json.contains("\"looking_at\"") || reference.iter().any(|r| json.contains(r))
    // rust: })
    // rust: .map(|c| c.trigger.clone())
    // rust: .collect();
}
    // Whether a criterion of `trigger` may test what the player looks at.
may_look :: proc(self: ^Self, trigger: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.looking_at_triggers.contains(trigger)
}
    // Index the triggers whose criteria name `nbt`, or a
    // `minecraft:reference` to a predicate file that might: the text is
    // searched, nothing is read.
index_nbt :: proc(self: ^Self) {
}
    // rust: let keys = [
    // rust: "\"nbt\"",
    // rust: "\"minecraft:nbt\"",
    // rust: "\"minecraft:reference\"",
    // rust: "\"reference\"",
    // rust: ];
    // rust: self.nbt_triggers = (self.list.iter().flat_map(|a| &a.criteria))
    // rust: .filter(|c| {
    // rust: let json = c.conditions.json();
    // rust: keys.iter().any(|k| json.contains(k))
    // rust: })
    // rust: .map(|c| c.trigger.clone())
    // rust: .collect();
}
    // Whether a criterion of `trigger` may test an entity's `nbt`.
may_test_nbt :: proc(self: ^Self, trigger: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.nbt_triggers.contains(trigger)
}
    // Whether any criterion may test an entity's `nbt`.
tests_nbt :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.nbt_triggers.is_empty()
}
    // Index what each trigger's criteria may ask of the player's level,
    // statistics, advancements and recipes: a player predicate naming the
    // field, or a `minecraft:reference` to a predicate file that might (all
    // four). The text is searched, nothing is read.
index_player_facts :: proc(self: ^Self) {
}
    // rust: let reference = ["\"minecraft:reference\"", "\"reference\""];
    // rust: let mut out: HashMap<String, FactsAsked> = HashMap::new();
    // rust: for c in self.list.iter().flat_map(|a| &a.criteria) {
    // rust: let json = c.conditions.json();
    // rust: let asked = if reference.iter().any(|r| json.contains(r)) {
    // rust: FactsAsked::ALL
    // rust: } else if json.contains("type_specific/player") {
    // rust: FactsAsked {
    // rust: level: json.contains("\"level\""),
    // rust: stats: json.contains("\"stats\""),
    // rust: advancements: json.contains("\"advancements\""),
    // rust: recipes: json.contains("\"recipes\""),
}
    // rust: } else {
    // rust: continue;
}
    // rust: if asked == FactsAsked::default() {
    // rust: continue;
}
    // rust: let e = out.entry(c.trigger.clone()).or_default();
    // rust: *e = e.or(asked);
}
    // rust: self.player_fact_triggers = out;
}
    // What a criterion of `trigger` may ask of the player's level,
    // statistics, advancements and recipes.
player_facts_asked :: proc(self: ^Self, trigger: string) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.player_fact_triggers
    // rust: .get(trigger)
    // rust: .copied()
    // rust: .unwrap_or_default()
}
    // The `recipe_unlocked` criteria that could pass for `recipe`, in tree
    // order (the others name another recipe).
recipe_criteria :: proc(self: ^Self, recipe: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = self.recipes_any.clone();
    // rust: out.extend(self.by_recipe.get(recipe).into_iter().flatten());
    // rust: out.sort_unstable();
    // rust: out
}
get :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.by_id.get(id).map(|&i| &self.list[i])
}
}

// The `inventory_changed` criteria by the items they need. A criterion whose
// item predicates include one limited to some items (an id, a `#tag`, a
// list) can only pass with one of those in the inventory, so an inventory
// change tests only the criteria of the items it holds, plus those that
// need no particular item. The same answers as testing them all: the ~1,300
// recipe advancements each have one, and testing every one of them cost a
// player 1–4 ms on every tick its inventory changed.
InventoryIndex :: struct {
    by_item: HashMap<string,
    any: Vec<(uint,
}
    // rust: impl InventoryIndex {
    // `tag` gives a `#tag`'s item ids (none for a tag that doesn't exist,
    // which matches nothing).
    // rust: pub fn build<'t>(tree: &Tree, tag: impl Fn(&str) -> Vec<&'t str>) -> Self {
    // rust: fn ids<'t>(v: &Value, tag: &impl Fn(&str) -> Vec<&'t str>, out: &mut Vec<String>) {
    // rust: match v {
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(t) => out.extend(tag(&full(t)).into_iter().map(str::to_owned)),
    // rust: None => out.push(full(s).into_owned()),
    // rust: },
    // rust: Value::Array(a) => a.iter().for_each(|x| ids(x, tag, out)),
    // rust: _ => {}
}
}
    // rust: let mut index = Self::default();
    // rust: let Some(list) = tree.by_trigger.get("minecraft:inventory_changed") else {
    // rust: return index;
}
    // rust: for &(ai, ci) in list {
    // rust: let conditions = tree.list[ai].criteria[ci].conditions.read();
    // rust: let items = &conditions["items"];
            // `id_matches`: only a string or a list limits the items.
    // rust: let limited = items.as_array().and_then(|a| {
    // rust: a.iter()
    // rust: .map(|p| &p["items"])
    // rust: .find(|v| v.is_string() || v.is_array())
    // rust: });
    // rust: match limited {
    // rust: Some(v) => {
    // rust: let mut out = Vec::new();
    // rust: ids(v, &tag, &mut out);
    // rust: out.sort();
    // rust: out.dedup();
    // rust: for id in out {
    // rust: index.by_item.entry(id).or_default().push((ai, ci));
}
}
    // rust: None => index.any.push((ai, ci)),
}
}
    // rust: index
}
    // The criteria an inventory holding these item ids could pass, in
    // tree order.
    // rust: pub fn candidates<'a>(&self, held: impl IntoIterator<Item = &'a str>) -> Vec<(usize, usize)> {
    // rust: let mut out = self.any.clone();
    // rust: for id in held {
    // rust: if let Some(list) = self.by_item.get(id) {
    // rust: out.extend_from_slice(list);
}
}
    // rust: out.sort_unstable();
    // rust: out.dedup();
    // rust: out
}
}
parse :: proc(id: string, v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let criteria: Vec<Criterion> = v["criteria"]
    // rust: .as_object()?
    // rust: .iter()
    // rust: .map(|(name, c)| Criterion {
    // rust: name: name.clone(),
    // rust: trigger: c["trigger"]
    // rust: .as_str()
    // rust: .map_or(String::new(), |t| full(t).into_owned()),
    // rust: conditions: LazyJson::new(&c["conditions"]),
    // rust: })
    // rust: .collect();
    // rust: let requirements = match v["requirements"].as_array() {
    // rust: Some(r) => r
    // rust: .iter()
    // rust: .map(|group| {
    // rust: group
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|s| s.as_str().map(str::to_owned))
    // rust: .collect()
    // rust: })
    // rust: .collect(),
        // AdvancementRequirements.allOf: every criterion.
    // rust: None => criteria.iter().map(|c| vec![c.name.clone()]).collect(),
}
    // rust: let d = &v["display"];
    // rust: let display = d.is_object().then(|| Display {
    // rust: icon: d["icon"]["id"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:air")
    // rust: .to_owned(),
    // rust: title: d["title"].clone(),
    // rust: description: d["description"].clone(),
    // rust: frame: frame(&d["frame"]),
    // rust: background: d["background"].as_str().map(str::to_owned),
    // rust: show_toast: d["show_toast"].as_bool().unwrap_or(true),
    // rust: announce: d["announce_to_chat"].as_bool().unwrap_or(true),
    // rust: hidden: d["hidden"].as_bool().unwrap_or(false),
    // rust: });
    // rust: let r = &v["rewards"];
    // rust: let strings = |v: &Value| -> Vec<String> {
    // rust: v.as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|s| s.as_str().map(str::to_owned))
    // rust: .collect()
}
    // rust: Some(Advancement {
    // rust: id: id.to_owned(),
    // rust: parent: v["parent"].as_str().map(str::to_owned),
    // rust: display,
    // rust: criteria,
    // rust: requirements,
    // rust: rewards: Rewards {
    // rust: recipes: strings(&r["recipes"]),
    // rust: experience: r["experience"].as_i64().unwrap_or(0) as i32,
    // rust: loot: strings(&r["loot"]),
    // rust: function: r["function"].as_str().map(|id| full(id).into_owned()),
    // rust: },
    // rust: })
}

// `CriterionProgress`'s date as saved, "yyyy-MM-dd HH:mm:ss Z", in UTC.
date_text :: proc(unix_secs: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let days = unix_secs.div_euclid(86400);
    // rust: let rem = unix_secs.rem_euclid(86400);
    // Civil from days (Howard Hinnant's algorithm).
    // rust: let z = days + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z - era * 146_097;
    // rust: let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146_096) / 365;
    // rust: let y = yoe + era * 400;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let d = doy - (153 * mp + 2) / 5 + 1;
    // rust: let m = if mp < 10 { mp + 3 } else { mp - 9 };
    // rust: let y = if m <= 2 { y + 1 } else { y };
    // rust: format!(
    // rust: "{y:04}-{m:02}-{d:02} {:02}:{:02}:{:02} +0000",
    // rust: rem / 3600,
    // rust: rem % 3600 / 60,
    // rust: rem % 60
    // rust: )
}

// A saved date back to milliseconds since the epoch (the network form of
// `CriterionProgress`), the zone offset applied.
date_millis :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (date, rest) = text.trim().split_once(' ')?;
    // rust: let (time, zone) = rest.split_once(' ').unwrap_or((rest, "+0000"));
    // rust: let mut d = date.split('-').map(|v| v.parse::<i64>().ok());
    // rust: let (y, m, day) = (d.next()??, d.next()??, d.next()??);
    // rust: let mut t = time.split(':').map(|v| v.parse::<i64>().ok());
    // rust: let (h, min, sec) = (t.next()??, t.next()??, t.next()??);
    // rust: let sign = if zone.starts_with('-') { -1 } else { 1 };
    // rust: let zone = zone.trim_start_matches(['+', '-']);
    // rust: let offset =
    // rust: zone.get(0..2)?.parse::<i64>().ok()? * 3600 + zone.get(2..4)?.parse::<i64>().ok()? * 60;
    // Days from civil (Howard Hinnant's algorithm).
    // rust: let y = if m <= 2 { y - 1 } else { y };
    // rust: let era = y.div_euclid(400);
    // rust: let yoe = y - era * 400;
    // rust: let mp = (m + 9) % 12;
    // rust: let doy = (153 * mp + 2) / 5 + day - 1;
    // rust: let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
    // rust: let days = era * 146_097 + doe - 719_468;
    // rust: Some((days * 86400 + h * 3600 + min * 60 + sec - sign * offset) * 1000)
}

// The player's progress: advancement -> criterion -> obtained date.
Progress :: struct {
    criteria: BTreeMap<string,
}
    // rust: impl Progress {
has :: proc(self: ^Self, adv: string, criterion: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.criteria
    // rust: .get(adv)
    // rust: .is_some_and(|m| m.contains_key(criterion))
}
    // `AdvancementProgress.isDone`.
done :: proc(self: ^Self, a: ^Advancement) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !a.requirements.is_empty()
    // rust: && a.requirements
    // rust: .iter()
    // rust: .all(|group| group.iter().any(|c| self.has(&a.id, c)))
}
    // Completed requirement groups and their count (the screen's tooltip).
counts :: proc(self: ^Self, a: ^Advancement) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let done = a
    // rust: .requirements
    // rust: .iter()
    // rust: .filter(|g| g.iter().any(|c| self.has(&a.id, c)))
    // rust: .count();
    // rust: (done, a.requirements.len())
}
grant :: proc(self: ^Self, adv: string, criterion: string, date: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let m = self.criteria.entry(adv.to_owned()).or_default();
    // rust: if m.contains_key(criterion) {
    // rust: return false;
}
    // rust: m.insert(criterion.to_owned(), date.to_owned());
    // rust: true
}
revoke :: proc(self: ^Self, adv: string, criterion: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.criteria
    // rust: .get_mut(adv)
    // rust: .is_some_and(|m| m.remove(criterion).is_some())
}
from_json :: proc(v: ^Value) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut p = Progress::default();
    // rust: if let Some(o) = v.as_object() {
    // rust: for (adv, entry) in o {
    // rust: if adv == "DataVersion" {
    // rust: continue;
}
    // rust: if let Some(c) = entry["criteria"].as_object() {
    // rust: let m = p.criteria.entry(adv.clone()).or_default();
    // rust: for (k, d) in c {
    // rust: m.insert(k.clone(), d.as_str().unwrap_or("").to_owned());
}
}
}
}
    // rust: p
}
to_json :: proc(self: ^Self, tree: ^Tree, data_version: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut o = serde_json::Map::new();
    // rust: for (adv, m) in &self.criteria {
    // rust: if m.is_empty() {
    // rust: continue;
}
    // rust: let done = tree.get(adv).is_some_and(|a| self.done(a));
    // rust: o.insert(
    // rust: adv.clone(),
    // rust: serde_json::json!({ "criteria": m, "done": done }),
    // rust: );
}
    // rust: o.insert("DataVersion".into(), data_version.into());
    // rust: Value::Object(o)
}
}

// What predicates may ask about the world.
    // rust: pub trait World {
dimension :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // Effective rain/thunder booleans, including the level's dimension rules.
weather :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
biome :: proc(self: ^Self, pos: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
structures :: proc(self: ^Self, pos: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // Block name and properties.
block :: proc(self: ^Self, pos: [i32; 3]) -> ( {
    // Ported from Horizon
    return {}
}
fluid :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
can_see_sky :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
light :: proc(self: ^Self, pos: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
smokey :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
in_tag :: proc(self: ^Self, registry: string, tag: string, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // The block entity's `saveWithFullMetadata` at `pos`, `None` without one.
block_entity_nbt :: proc(self: ^Self, _pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
}
// An item stack as predicates see it.
ItemView :: struct {
    id: string,
    count: u32,
    damage: u32,
    enchantments: Vec<(string,
    potion: Maybe(string),
    custom_name: bool,
}
// An entity as predicates see it.
EntityView :: struct {
    kind: string,
    position: [f64,
    on_fire: bool,
    sneaking: bool,
    sprinting: bool,
    swimming: bool,
    flying: bool,
    baby: bool,
    on_ground: bool,
    // mainhand, offhand, head, chest, legs, feet, body.
    equipment: [Maybe(ItemView),
    vehicle: Maybe(^EntityView),
    // `Entity.getPassengers`, for `PassengerPredicate`.
    passengers: [dynamic]EntityView,
    // Player: what it looks at within 100 blocks (`PlayerPredicate.lookingAt`).
    looking_at: Maybe(^EntityView),
    effects: Vec<(string,
    // Player: game mode name.
    gamemode: Maybe(string),
    // Player: the sneak input is held (`Input.shift`, what `input.sneak`
    // asks; not the sneaking pose).
    input_sneak: bool,
    // Player: its level, statistics, advancements and recipes, as far as
    // they were filled.
    player_facts: PlayerFacts,
    // Lightning: entities it struck.
    struck: [dynamic]EntityView,
    // Lightning: blocks it set on fire (`LightningBolt.blocksSetOnFire`).
    blocks_set_on_fire: i32,
    fishing_open_water: Maybe(bool),
    variant: Maybe(string),
    // The data components the entity reports (`Entity.get`): id and value.
    components: Vec<(string,
    // The entity as saved (`NbtPredicate.getEntityTagToCompare`), for
    // `minecraft:nbt`; built only when a criterion may ask (`Tree::tests_nbt`).
    nbt: Maybe(horizon_world::nbt::Tag),
    // `Entity.getTeam().getName()` (a tamed pet answers its owner's team);
    // `None` without a team or where the identity is not bound.
    team: Maybe(string),
}
// What `PlayerPredicate` reads of a player beyond its entity. Each part is
// filled only when a criterion may ask for it (`Tree::player_facts_asked`);
// a predicate that asks for a part left `None` fails.
PlayerFacts :: struct {
    // `Player.experienceLevel`.
    level: Maybe(i32),
    // `ServerStatsCounter`: stat type -> stat id -> value, both namespaced.
    stats: Option<BTreeMap<string,
    // `PlayerAdvancements`: the loaded advancements and the player's
    // progress in them.
    advancements: Maybe((Arc<Tree),
    // `ServerRecipeBook`: the known recipe ids.
    recipes: Maybe(BTreeSet<string)>,
}
    // rust: impl std::fmt::Debug for PlayerFacts {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("PlayerFacts")
    // rust: .field("level", &self.level)
    // rust: .field("stats", &self.stats)
    // rust: .field(
    // rust: "advancements",
    // rust: &self.advancements.as_ref().map(|(_, p)| p.criteria.len()),
    // rust: )
    // rust: .field("recipes", &self.recipes.as_ref().map(BTreeSet::len))
    // rust: .finish()
}
}
range_f :: proc(v: ^Value, x: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Null => true,
    // rust: Value::Number(n) => n.as_f64().is_some_and(|n| (n - x).abs() < 1e-9),
    // rust: Value::Object(o) => {
    // rust: o.get("min").and_then(Value::as_f64).is_none_or(|m| x >= m)
    // rust: && o.get("max").and_then(Value::as_f64).is_none_or(|m| x <= m)
}
    // rust: _ => false,
}
}
range_i :: proc(v: ^Value, x: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: range_f(v, x as f64)
}
// `Identifier.parse`: an id written without a namespace is a `minecraft:` one.
full :: proc(id: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.into()
    // rust: } else {
    // rust: format!("minecraft:{id}").into()
}
}
// The entry of a map keyed by registry ids (`Identifier.parse` on the key),
// such as an item predicate's `components` or `predicates`.
    // rust: fn keyed<'a>(map: &'a Value, id: &str) -> Option<&'a Value> {
    // rust: map.as_object()?
    // rust: .iter()
    // rust: .find(|(k, _)| full(k) == id)
    // rust: .map(|(_, v)| v)
}
// A registry id, `#tag`, or list matched against one id.
id_matches :: proc(v: ^Value, registry: string, id: string, w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Null => true,
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => w.in_tag(registry, &full(tag), id),
    // rust: None => full(s) == id,
    // rust: },
    // rust: Value::Array(a) => a.iter().any(|x| id_matches(x, registry, id, w)),
    // rust: _ => false,
}
}
// `PotionsPredicate`: the potion in a `HolderSet`, plus a `CollectionPredicate`
// over the potion's effects (`contains`, `count`, `size`).
potions :: proc(v: ^Value, potion: Maybe(string), w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_null() {
    // rust: return true;
}
    // rust: if !v["potions"].is_null() && !potion.is_some_and(|p| id_matches(&v["potions"], "potion", p, w))
    // rust: {
    // rust: return false;
}
    // rust: let c = &v["effects"];
    // rust: if c.is_null() {
    // rust: return true;
}
    // rust: let effects: Vec<(String, i32, i32)> = potion
    // rust: .and_then(crate::brewing::potion)
    // rust: .map(|d| {
    // rust: d.effects
    // rust: .iter()
    // rust: .map(|(id, dur, amp)| (format!("minecraft:{id}"), *amp, *dur))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // `MobEffectsPredicate.test`: the one listed effect, amplifier and duration.
    // rust: let test = |pred: &Value, e: &(String, i32, i32)| {
    // rust: pred.as_object().is_some_and(|m| {
    // rust: m.iter()
    // rust: .find(|(k, _)| full(k) == e.0)
    // rust: .is_some_and(|(_, want)| {
    // rust: range_i(&want["amplifier"], i64::from(e.1))
    // rust: && range_i(&want["duration"], i64::from(e.2))
    // rust: && want["ambient"].as_bool().is_none_or(|b| !b)
    // rust: && want["visible"].as_bool().is_none_or(|b| b)
    // rust: })
    // rust: })
}
    // rust: c["contains"]
    // rust: .as_array()
    // rust: .is_none_or(|l| l.iter().all(|p| effects.iter().any(|e| test(p, e))))
    // rust: && c["count"].as_array().is_none_or(|l| {
    // rust: l.iter().all(|entry| {
    // rust: let n = effects.iter().filter(|e| test(&entry["test"], e)).count();
    // rust: range_i(&entry["count"], n as i64)
    // rust: })
    // rust: })
    // rust: && range_i(&c["size"], effects.len() as i64)
}
// `ItemPredicate`.
item :: proc(v: ^Value, it: ^ItemView, w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_null() {
    // rust: return true;
}
    // rust: if !id_matches(&v["items"], "item", &it.id, w) {
    // rust: return false;
}
    // rust: if !range_i(&v["count"], i64::from(it.count)) {
    // rust: return false;
}
    // Data components: exact matches on the few the data uses.
    // rust: let comps = &v["components"];
    // rust: if let Some(p) = keyed(comps, "minecraft:potion_contents").and_then(Value::as_str)
    // rust: && !it.potion.as_deref().is_some_and(|h| full(h) == full(p))
    // rust: {
    // rust: return false;
}
    // rust: if let Some(d) = keyed(comps, "minecraft:damage").and_then(Value::as_u64)
    // rust: && u64::from(it.damage) != d
    // rust: {
    // rust: return false;
}
    // rust: let preds = &v["predicates"];
    // rust: if let Some(list) = keyed(preds, "minecraft:enchantments").and_then(Value::as_array) {
    // rust: for e in list {
    // rust: let ok = it.enchantments.iter().any(|(id, lvl)| {
    // rust: id_matches(&e["enchantments"], "enchantment", id, w)
    // rust: && range_i(&e["levels"], i64::from(*lvl))
    // rust: });
    // rust: if !ok {
    // rust: return false;
}
}
}
    // rust: if let Some(d) = keyed(preds, "minecraft:damage").and_then(Value::as_object) {
    // rust: let damage = Value::Object(d.clone());
    // rust: if !range_i(&damage["damage"], i64::from(it.damage)) {
    // rust: return false;
}
}
    // rust: true
}
// `LockCode.canUnlock`: a spectator opens any container; otherwise the
// player's main hand must match the lock's `ItemPredicate`. An empty hand
// holds nothing to match (`getMainHandItem` is `ItemStack.EMPTY`), while
// `LockCode.NO_LOCK`'s empty predicate takes any stack.
    // rust: pub fn can_unlock(
    // rust: lock: &Value,
    // rust: spectator: bool,
    // rust: main_hand: Option<&ItemView>,
    // rust: w: &dyn World,
    // rust: ) -> bool {
    // rust: let empty = ItemView::default();
    // rust: spectator || item(lock, main_hand.unwrap_or(&empty), w)
}
// `BlockPredicate`.
block :: proc(v: ^Value, pos: [i32; 3], w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_null() {
    // rust: return true;
}
    // rust: let (name, props) = w.block(pos);
    // rust: if !id_matches(&v["blocks"], "block", &name, w) {
    // rust: return false;
}
    // rust: if let Some(state) = v["state"].as_object() {
    // rust: for (k, want) in state {
    // rust: let have = props.get(k).cloned().unwrap_or_default();
    // rust: let ok = match want {
    // rust: Value::String(s) => have == *s,
    // rust: Value::Bool(b) => have == b.to_string(),
    // rust: Value::Number(n) => have == n.to_string(),
    // rust: Value::Object(_) => have.parse::<f64>().is_ok_and(|h| range_f(want, h)),
    // rust: _ => false,
}
    // rust: if !ok {
    // rust: return false;
}
}
}
    // `matchesBlockEntity`: the block entity's data holds the pattern
    // (`NbtPredicate.matches`, `NbtUtils.compareNbt`); no block entity fails.
    // rust: if let Some(nbt) = v["nbt"].as_str() {
    // rust: let Ok((pattern, _)) = horizon_world::nbt::parse_snbt(nbt) else {
    // rust: return false;
}
    // rust: if !crate::nbt_path::compare_nbt(&pattern, w.block_entity_nbt(pos).as_ref()) {
    // rust: return false;
}
}
    // rust: true
}
// `LocationPredicate`.
location :: proc(v: ^Value, p: [f64; 3], w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_null() {
    // rust: return true;
}
    // rust: let pos = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: let posv = &v["position"];
    // rust: if !range_f(&posv["x"], p[0]) || !range_f(&posv["y"], p[1]) || !range_f(&posv["z"], p[2]) {
    // rust: return false;
}
    // rust: if let Some(d) = v["dimension"].as_str()
    // rust: && full(d) != w.dimension()
    // rust: {
    // rust: return false;
}
    // rust: if !v["biomes"].is_null() && !id_matches(&v["biomes"], "worldgen/biome", &w.biome(pos), w) {
    // rust: return false;
}
    // rust: if !v["structures"].is_null() {
    // rust: let here = w.structures(pos);
    // rust: if !here
    // rust: .iter()
    // rust: .any(|s| id_matches(&v["structures"], "worldgen/structure", s, w))
    // rust: {
    // rust: return false;
}
}
    // rust: if let Some(b) = v["can_see_sky"].as_bool()
    // rust: && b != w.can_see_sky(pos)
    // rust: {
    // rust: return false;
}
    // rust: if let Some(b) = v["smokey"].as_bool()
    // rust: && b != w.smokey(pos)
    // rust: {
    // rust: return false;
}
    // rust: if !v["light"].is_null() && !range_i(&v["light"]["light"], i64::from(w.light(pos))) {
    // rust: return false;
}
    // rust: if !v["block"].is_null() && !block(&v["block"], pos, w) {
    // rust: return false;
}
    // rust: if !v["fluid"].is_null() {
    // rust: let Some(f) = w.fluid(pos) else {
    // rust: return false;
}
    // rust: if !id_matches(&v["fluid"]["fluids"], "fluid", &f, w) {
    // rust: return false;
}
}
    // rust: true
}
// `DataComponentExactPredicate.test` on an entity: every expected
// component equals what the entity reports (absent ones never match).
components :: proc(expected: ^Value, have: ^[(string) {
}
    // rust: expected.as_object().is_some_and(|o| {
    // rust: o.iter().all(|(id, want)| {
    // rust: let id = full(id);
    // rust: want.as_str().is_some_and(|want| {
    // rust: have.iter()
    // rust: .any(|(k, v)| full(k) == id && full(v) == full(want))
    // rust: })
    // rust: })
    // rust: })
}
// `DistancePredicate.matches` between two points.
distance :: proc(v: ^Value, a: [f64; 3], b: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let d = [a[0] - b[0], a[1] - b[1], a[2] - b[2]];
    // rust: range_f(&v["x"], d[0].abs())
    // rust: && range_f(&v["y"], d[1].abs())
    // rust: && range_f(&v["z"], d[2].abs())
    // rust: && range_f(&v["horizontal"], (d[0] * d[0] + d[2] * d[2]).sqrt())
    // rust: && range_f(
    // rust: &v["absolute"],
    // rust: (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt(),
    // rust: )
}
// `EntityPredicate` (26.x keyed sub-predicates).
entity :: proc(v: ^Value, e: ^EntityView, w: ^dyn World, origin: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_null() {
    // rust: return true;
}
    // rust: let Some(o) = v.as_object() else {
    // rust: return false;
}
    // rust: for (key, p) in o {
        // `EntityPredicate.CODEC`: the keys are sub-predicate type ids.
    // rust: let ok = match &*full(key) {
    // rust: "minecraft:entity_type" => id_matches(p, "entity_type", &e.kind, w),
    // rust: "minecraft:location" => location(p, e.position, w),
    // rust: "minecraft:stepping_on" => {
    // rust: location(p, [e.position[0], e.position[1] - 0.5, e.position[2]], w)
}
    // rust: "minecraft:distance" => distance(p, e.position, origin),
    // rust: "minecraft:flags" => {
    // rust: let f = |k: &str, have: bool| p[k].as_bool().is_none_or(|want| want == have);
    // rust: f("is_on_fire", e.on_fire)
    // rust: && f("is_sneaking", e.sneaking)
    // rust: && f("is_sprinting", e.sprinting)
    // rust: && f("is_swimming", e.swimming)
    // rust: && f("is_flying", e.flying)
    // rust: && f("is_baby", e.baby)
    // rust: && f("is_on_ground", e.on_ground)
}
    // rust: "minecraft:equipment" => {
    // rust: let slots = [
    // rust: "mainhand", "offhand", "head", "chest", "legs", "feet", "body",
    // rust: ];
    // rust: slots.iter().enumerate().all(|(i, s)| {
    // rust: p[*s].is_null()
    // rust: || e.equipment[i]
    // rust: .as_ref()
    // rust: .is_some_and(|it| item(&p[*s], it, w))
    // rust: })
}
    // rust: "minecraft:vehicle" => e
    // rust: .vehicle
    // rust: .as_ref()
    // rust: .is_some_and(|veh| entity(p, veh, w, origin)),
            // PassengerPredicate.matches: any passenger matches the nested predicate.
    // rust: "minecraft:passenger" => e
    // rust: .passengers
    // rust: .iter()
    // rust: .any(|passenger| entity(p, passenger, w, origin)),
    // rust: "minecraft:effects" => p.as_object().is_some_and(|m| {
    // rust: m.iter().all(|(id, want)| {
    // rust: e.effects.iter().any(|(eid, amp, dur)| {
    // rust: *eid == full(id)
    // rust: && range_i(&want["amplifier"], i64::from(*amp))
    // rust: && range_i(&want["duration"], i64::from(*dur))
    // rust: })
    // rust: })
    // rust: }),
            // `EntityNbtPredicate.matches`: the entity's compound holds the
            // pattern (`NbtUtils.compareNbt`); no compound known fails.
    // rust: "minecraft:nbt" => p.as_str().is_some_and(|s| {
    // rust: horizon_world::nbt::parse_snbt(s).is_ok_and(|(pattern, _)| {
    // rust: crate::nbt_path::compare_nbt(&pattern, e.nbt.as_ref())
    // rust: })
    // rust: }),
    // rust: "minecraft:type_specific/player" => {
                // `PlayerPredicate.matches`: `instanceof ServerPlayer` first,
                // then the game mode, what it looks at and its `input`.
    // rust: e.kind == "minecraft:player"
    // rust: && p["gamemode"].as_array().is_none_or(|modes| {
    // rust: e.gamemode
    // rust: .as_deref()
    // rust: .is_some_and(|g| modes.iter().any(|m| m.as_str() == Some(g)))
    // rust: })
    // rust: && (p["looking_at"].is_null()
    // rust: || e.looking_at
    // rust: .as_ref()
    // rust: .is_some_and(|t| entity(&p["looking_at"], t, w, origin)))
    // rust: && (p["input"].is_null() || input(&p["input"], e))
    // rust: && player_facts(p, &e.player_facts)
}
    // rust: "minecraft:type_specific/lightning" => {
    // rust: range_i(&p["blocks_set_on_fire"], i64::from(e.blocks_set_on_fire))
    // rust: && (p["entity_struck"].is_null()
    // rust: || e.struck
    // rust: .iter()
    // rust: .any(|s| entity(&p["entity_struck"], s, w, origin)))
}
    // rust: "minecraft:type_specific/fishing_hook" => p["in_open_water"]
    // rust: .as_bool()
    // rust: .is_none_or(|want| e.fishing_open_water == Some(want)),
    // rust: "minecraft:components" => components(p, &e.components),
            // `TeamPredicate.matches`: a non-null effective team whose name
            // equals the string exactly.
    // rust: "minecraft:team" => {
    // rust: matches!((p.as_str(), &e.team), (Some(want), Some(have)) if want == have)
}
    // rust: "minecraft:predicates" => true,
    // rust: _ => false,
}
    // rust: if !ok {
    // rust: return false;
}
}
    // rust: true
}
// The rest of `PlayerPredicate.matches` (expected from it): the experience
// level in the `level` bounds; each `stats` entry's value (0 when never
// counted) in its bounds; each listed recipe known or not as asked; each
// listed advancement loaded, and done or not, or each named criterion of it
// granted or not. A field asked of facts that weren't filled fails.
player_facts :: proc(p: ^Value, f: ^PlayerFacts) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let level = &p["level"];
    // rust: if !level.is_null() && !f.level.is_some_and(|l| range_i(level, i64::from(l))) {
    // rust: return false;
}
    // rust: let stats = &p["stats"];
    // rust: if !stats.is_null() {
    // rust: let Some(list) = stats.as_array() else {
    // rust: return false;
}
        // `StatMatcher.matches`: the counter's value for the type's stat.
    // rust: let ok = list.is_empty()
    // rust: || f.stats.as_ref().is_some_and(|counts| {
    // rust: list.iter().all(|m| {
    // rust: let (Some(ty), Some(stat)) = (m["type"].as_str(), m["stat"].as_str()) else {
    // rust: return false;
}
    // rust: let value = counts
    // rust: .get(&*full(ty))
    // rust: .and_then(|of| of.get(&*full(stat)))
    // rust: .copied()
    // rust: .unwrap_or(0);
    // rust: range_i(&m["value"], i64::from(value))
    // rust: })
    // rust: });
    // rust: if !ok {
    // rust: return false;
}
}
    // rust: let recipes = &p["recipes"];
    // rust: if !recipes.is_null() {
    // rust: let Some(map) = recipes.as_object() else {
    // rust: return false;
}
    // rust: let ok = map.is_empty()
    // rust: || f.recipes.as_ref().is_some_and(|known| {
    // rust: map.iter().all(|(id, want)| {
    // rust: want.as_bool()
    // rust: .is_some_and(|want| known.contains(&*full(id)) == want)
    // rust: })
    // rust: });
    // rust: if !ok {
    // rust: return false;
}
}
    // rust: let advancements = &p["advancements"];
    // rust: if !advancements.is_null() {
    // rust: let Some(map) = advancements.as_object() else {
    // rust: return false;
}
    // rust: let ok = map.is_empty()
    // rust: || f.advancements.as_ref().is_some_and(|(tree, progress)| {
    // rust: map.iter().all(|(id, want)| {
                    // An advancement that isn't loaded matches nothing.
    // rust: let Some(a) = tree.get(&full(id)) else {
    // rust: return false;
}
    // rust: match want {
                        // `AdvancementDonePredicate`.
    // rust: Value::Bool(want) => progress.done(a) == *want,
                        // `AdvancementCriterionsPredicate`: a criterion the
                        // advancement doesn't have matches nothing.
    // rust: Value::Object(criteria) => criteria.iter().all(|(name, want)| {
    // rust: want.as_bool().is_some_and(|want| {
    // rust: a.criteria.iter().any(|c| c.name == *name)
    // rust: && progress.has(&a.id, name) == want
    // rust: })
    // rust: }),
    // rust: _ => false,
}
    // rust: })
    // rust: });
    // rust: if !ok {
    // rust: return false;
}
}
    // rust: true
}
// `InputPredicate.matches`: the player's held inputs. The sneak input is
// what the game holds; the other inputs have no source here yet and count
// as unconstrained.
input :: proc(p: ^Value, e: ^EntityView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: p["sneak"]
    // rust: .as_bool()
    // rust: .is_none_or(|want| want == e.input_sneak)
}
// `KilledByArrowTrigger.TriggerInstance.matches`: the weapon, each listed
// victim condition matched by a distinct victim, and the count of entity types.
    // rust: pub fn killed_by_arrow(
    // rust: c: &Value,
    // rust: me: &EntityView,
    // rust: victims: &[EntityView],
    // rust: weapon: Option<&ItemView>,
    // rust: w: &dyn World,
    // rust: ) -> bool {
    // rust: fn ctx<'a>(e: &'a EntityView, me: &EntityView) -> Entities<'a> {
    // rust: Entities {
    // rust: this: Some(e),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
}
    // rust: if !conditions(&c["player"], &ctx(me, me), w) {
    // rust: return false;
}
    // rust: if !c["fired_from_weapon"].is_null()
    // rust: && !weapon.is_some_and(|it| item(&c["fired_from_weapon"], it, w))
    // rust: {
    // rust: return false;
}
    // rust: let mut left: Vec<&EntityView> = victims.iter().collect();
    // rust: for want in c["victims"].as_array().into_iter().flatten() {
    // rust: let Some(i) = left.iter().position(|e| conditions(want, &ctx(e, me), w)) else {
    // rust: return false;
}
    // rust: left.remove(i);
}
    // rust: let kinds: BTreeSet<&str> = victims.iter().map(|e| e.kind.as_str()).collect();
    // rust: range_i(&c["unique_entity_types"], kinds.len() as i64)
}
// `KilledTrigger.TriggerInstance.matches`: the player, the other entity
// (the one killed, or the killer for `entity_killed_player`) and the
// killing blow (none: any `killing_blow` fails).
    // rust: pub fn killed(
    // rust: c: &Value,
    // rust: me: &EntityView,
    // rust: target: &EntityView,
    // rust: blow: Option<&DamageView>,
    // rust: w: &dyn World,
    // rust: ) -> bool {
    // rust: let pctx = Entities {
    // rust: this: Some(me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let ectx = Entities {
    // rust: this: Some(target),
    // rust: ..pctx
}
    // rust: let blow_ok = c["killing_blow"].is_null()
    // rust: || blow.is_some_and(|d| damage_source(&c["killing_blow"], d, w, me.position));
    // rust: conditions(&c["player"], &pctx, w) && conditions(&c["entity"], &ectx, w) && blow_ok
}
// A blow recorded by its damage type and causing entity, as `killing_blow`
// sees it: the projectile those types name is the direct entity, at `at`;
// otherwise the causing entity dealt it itself (`DamageSource.isDirect`).
recorded_blow :: proc(kind: string, source: Maybe(EntityView), at: [f64; 3]) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let projectile = match kind.as_str() {
    // rust: "minecraft:arrow" => Some("minecraft:arrow"),
    // rust: "minecraft:fireball" | "minecraft:small_fireball" => Some("minecraft:fireball"),
    // rust: "minecraft:wither_skull" => Some("minecraft:wither_skull"),
    // rust: "minecraft:fireworks" => Some("minecraft:firework_rocket"),
    // rust: _ => None,
}
    // rust: DamageView {
    // rust: kind,
    // rust: is_direct: projectile.is_none(),
    // rust: direct: match projectile {
    // rust: Some(kind) => Some(EntityView {
    // rust: kind: kind.into(),
    // rust: position: at,
    // rust: ..Default::default()
    // rust: }),
    // rust: None => source.clone(),
    // rust: },
    // rust: source,
    // rust: ..Default::default()
}
}
// A damage event as `DamagePredicate` sees it.
DamageView :: struct {
    // The damage type id (`minecraft:arrow`).
    kind: string,
    // `DamageSource.getDirectEntity` and `getEntity`.
    direct: Maybe(EntityView),
    source: Maybe(EntityView),
    // `DamageSource.isDirect`: the direct entity is the causing one.
    is_direct: bool,
    // The damage before and after the shield took its share.
    original: f32,
    actual: f32,
    blocked: bool,
}
// `DamagePredicate`, with its `DamageSourcePredicate` as `type`.
damage :: proc(v: ^Value, d: ^DamageView, w: ^dyn World, origin: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_null() {
    // rust: return true;
}
    // rust: let by = |key: &str, e: &Option<EntityView>| {
    // rust: v[key].is_null() || e.as_ref().is_some_and(|e| entity(&v[key], e, w, origin))
}
    // rust: if !range_f(&v["dealt"], f64::from(d.original))
    // rust: || !range_f(&v["taken"], f64::from(d.actual))
    // rust: || !by("source_entity", &d.source)
    // rust: || v["blocked"].as_bool().is_some_and(|b| b != d.blocked)
    // rust: {
    // rust: return false;
}
    // rust: damage_source(&v["type"], d, w, origin)
}
// `DamageSourcePredicate`: the damage type's tags and the entities behind it.
damage_source :: proc(ty: ^Value, d: ^DamageView, w: ^dyn World, origin: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if ty.is_null() {
    // rust: return true;
}
    // rust: let tags_ok = ty["tags"].as_array().into_iter().flatten().all(|t| {
        // `TagPredicate`: a `HolderSet`, like `id_matches`.
    // rust: id_matches(&t["id"], "damage_type", &d.kind, w) == t["expected"].as_bool().unwrap_or(true)
    // rust: });
    // rust: let direct_ok = ty["direct_entity"].is_null()
    // rust: || d.direct
    // rust: .as_ref()
    // rust: .is_some_and(|e| entity(&ty["direct_entity"], e, w, origin));
    // rust: let source_ok = ty["source_entity"].is_null()
    // rust: || d.source
    // rust: .as_ref()
    // rust: .is_some_and(|e| entity(&ty["source_entity"], e, w, origin));
    // rust: tags_ok && direct_ok && source_ok && ty["is_direct"].as_bool().is_none_or(|b| b == d.is_direct)
}
// The entities a loot-style condition list may refer to.
Entities :: struct {
    this: Maybe(^'a EntityView),
    origin: [f64,
    tool: Maybe(^'a ItemView),
    block_pos: Option<[i32,
}
// Conditions shared by item/entity interactions and thrown-item pickups.
    // rust: pub fn item_entity(
    // rust: v: &Value,
    // rust: player: &EntityView,
    // rust: target: &EntityView,
    // rust: stack: &ItemView,
    // rust: w: &dyn World,
    // rust: ) -> bool {
    // rust: let pctx = Entities {
    // rust: this: Some(player),
    // rust: origin: player.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let ectx = Entities {
    // rust: this: Some(target),
    // rust: ..pctx
}
    // rust: conditions(&v["player"], &pctx, w)
    // rust: && conditions(&v["entity"], &ectx, w)
    // rust: && item(&v["item"], stack, w)
}

// `RecipeCraftedTrigger.TriggerInstance.matches`: each ingredient predicate
// takes a different one of the stacks used, in order.
recipe_ingredients :: proc(v: ^Value, used: ^[ItemView], w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(preds) = v.as_array() else {
    // rust: return true;
}
    // rust: let mut remaining: Vec<&ItemView> = used.iter().collect();
    // rust: preds.iter().all(|p| {
    // rust: let Some(i) = remaining.iter().position(|it| item(p, it, w)) else {
    // rust: return false;
}
    // rust: remaining.remove(i);
    // rust: true
    // rust: })
}

// A `ContextAwarePredicate`: a list of loot conditions (or one condition).
conditions :: proc(v: ^Value, ctx: ^Entities, w: ^dyn World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Null => true,
    // rust: Value::Array(list) => list.iter().all(|c| conditions(c, ctx, w)),
    // rust: Value::Object(o) if o.contains_key("condition") || o.contains_key("type") => {
    // rust: let ty = o
    // rust: .get("condition")
    // rust: .or_else(|| o.get("type"))
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("");
    // rust: match &*full(ty) {
    // rust: "minecraft:entity_properties" => ctx
    // rust: .this
    // rust: .is_some_and(|e| entity(&v["predicate"], e, w, ctx.origin)),
    // rust: "minecraft:location_check" => {
    // rust: let base = ctx.block_pos.map_or(ctx.origin, |b| {
    // rust: [
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1]) + 0.5,
    // rust: f64::from(b[2]) + 0.5,
    // rust: ]
    // rust: });
    // rust: let off = [
    // rust: v["offsetX"].as_f64().unwrap_or(0.0),
    // rust: v["offsetY"].as_f64().unwrap_or(0.0),
    // rust: v["offsetZ"].as_f64().unwrap_or(0.0),
    // rust: ];
    // rust: location(
    // rust: &v["predicate"],
    // rust: [base[0] + off[0], base[1] + off[1], base[2] + off[2]],
    // rust: w,
    // rust: )
}
    // rust: "minecraft:match_block" => ctx.block_pos.is_some_and(|b| block(v, b, w)),
    // rust: "minecraft:block_state_property" => ctx.block_pos.is_some_and(|b| {
    // rust: let mut pred = serde_json::Map::new();
    // rust: pred.insert("blocks".into(), v["block"].clone());
    // rust: if !v["properties"].is_null() {
    // rust: pred.insert("state".into(), v["properties"].clone());
}
    // rust: block(&Value::Object(pred), b, w)
    // rust: }),
    // rust: "minecraft:match_tool" => ctx.tool.is_some_and(|t| item(&v["predicate"], t, w)),
    // rust: "minecraft:weather_check" => {
                    // WeatherCheck.test: absent fields impose no constraint.
    // rust: let (rain, thunder) = w.weather();
    // rust: v["raining"].as_bool().is_none_or(|r| r == rain)
    // rust: && v["thundering"].as_bool().is_none_or(|t| t == thunder)
}
    // rust: "minecraft:inverted" => !conditions(&v["term"], ctx, w),
    // rust: "minecraft:all_of" => v["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|t| conditions(t, ctx, w)),
    // rust: "minecraft:any_of" => v["terms"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|t| conditions(t, ctx, w)),
    // rust: _ => false,
}
}
        // An inline entity predicate (old-style).
    // rust: Value::Object(_) => ctx.this.is_some_and(|e| entity(v, e, w, ctx.origin)),
    // rust: _ => false,
}
}

// One node of `TreeNodePosition`, the Walker layout of a display tree.
Place :: struct {
    adv: uint,
    parent: Maybe(uint),
    previous: Maybe(uint),
    child_index: i32,
    children: [dynamic]uint,
    ancestor: uint,
    thread: Maybe(uint),
    x: i32,
    y: f32,
    modifier: f32,
    change: f32,
    shift: f32,
}
Layout :: struct {
    tree: ^'a Tree,
    kids: ^'a [[dynamic]uint],
    nodes: [dynamic]Place,
}
    // rust: impl Layout<'_> {
    // rust: fn build(
    // rust: &mut self,
    // rust: adv: usize,
    // rust: parent: Option<usize>,
    // rust: previous: Option<usize>,
    // rust: child_index: i32,
    // rust: depth: i32,
    // rust: ) -> usize {
    // rust: let me = self.nodes.len();
    // rust: self.nodes.push(Place {
    // rust: adv,
    // rust: parent,
    // rust: previous,
    // rust: child_index,
    // rust: children: Vec::new(),
    // rust: ancestor: me,
    // rust: thread: None,
    // rust: x: depth,
    // rust: y: -1.0,
    // rust: modifier: 0.0,
    // rust: change: 0.0,
    // rust: shift: 0.0,
    // rust: });
    // rust: let mut prev = None;
    // rust: for &c in &self.kids[adv] {
    // rust: prev = self.add_child(me, c, prev);
}
    // rust: me
}
add_child :: proc(self: ^Self, me: uint, adv: uint, mut prev: Maybe(uint)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.tree.list[adv].display.is_some() {
    // rust: let index = self.nodes[me].children.len() as i32 + 1;
    // rust: let depth = self.nodes[me].x + 1;
    // rust: let c = self.build(adv, Some(me), prev, index, depth);
    // rust: self.nodes[me].children.push(c);
    // rust: Some(c)
    // rust: } else {
    // rust: for &g in &self.kids[adv] {
    // rust: prev = self.add_child(me, g, prev);
}
    // rust: prev
}
}
first_walk :: proc(self: ^Self, v: uint) {
}
    // rust: let children = self.nodes[v].children.clone();
    // rust: let previous = self.nodes[v].previous;
    // rust: if children.is_empty() {
    // rust: self.nodes[v].y = previous.map_or(0.0, |p| self.nodes[p].y + 1.0);
    // rust: return;
}
    // rust: let mut default_ancestor: Option<usize> = None;
    // rust: for &c in &children {
    // rust: self.first_walk(c);
    // rust: default_ancestor = Some(self.apportion(c, default_ancestor.unwrap_or(c)));
}
    // rust: self.execute_shifts(v);
    // rust: let mid = (self.nodes[children[0]].y + self.nodes[children[children.len() - 1]].y) / 2.0;
    // rust: if let Some(p) = previous {
    // rust: self.nodes[v].y = self.nodes[p].y + 1.0;
    // rust: self.nodes[v].modifier = self.nodes[v].y - mid;
    // rust: } else {
    // rust: self.nodes[v].y = mid;
}
}
second_walk :: proc(self: ^Self, v: uint, mod_sum: f32, depth: i32, mut min: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[v].y += mod_sum;
    // rust: self.nodes[v].x = depth;
    // rust: min = min.min(self.nodes[v].y);
    // rust: let m = self.nodes[v].modifier;
    // rust: for c in self.nodes[v].children.clone() {
    // rust: min = self.second_walk(c, mod_sum + m, depth + 1, min);
}
    // rust: min
}
third_walk :: proc(self: ^Self, v: uint, offset: f32) {
}
    // rust: self.nodes[v].y += offset;
    // rust: for c in self.nodes[v].children.clone() {
    // rust: self.third_walk(c, offset);
}
}
execute_shifts :: proc(self: ^Self, v: uint) {
}
    // rust: let (mut shift, mut change) = (0.0, 0.0);
    // rust: for c in self.nodes[v].children.clone().into_iter().rev() {
    // rust: let n = &mut self.nodes[c];
    // rust: n.y += shift;
    // rust: n.modifier += shift;
    // rust: change += n.change;
    // rust: shift += n.shift + change;
}
}
previous_or_thread :: proc(self: ^Self, v: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[v]
    // rust: .thread
    // rust: .or_else(|| self.nodes[v].children.first().copied())
}
next_or_thread :: proc(self: ^Self, v: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[v]
    // rust: .thread
    // rust: .or_else(|| self.nodes[v].children.last().copied())
}
apportion :: proc(self: ^Self, v: uint, mut default_ancestor: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let Some(previous) = self.nodes[v].previous else {
    // rust: return default_ancestor;
}
    // rust: let parent = self.nodes[v].parent.unwrap_or(v);
    // rust: let (mut vir, mut vor, mut vil) = (v, v, previous);
    // rust: let mut vol = self.nodes[parent].children[0];
    // rust: let mut sir = self.nodes[v].modifier;
    // rust: let mut sor = sir;
    // rust: let mut sil = self.nodes[vil].modifier;
    // rust: let mut sol = self.nodes[vol].modifier;
    // rust: while let (Some(l), Some(r)) = (self.next_or_thread(vil), self.previous_or_thread(vir)) {
    // rust: vil = l;
    // rust: vir = r;
    // rust: vol = self.previous_or_thread(vol).unwrap_or(vol);
    // rust: vor = self.next_or_thread(vor).unwrap_or(vor);
    // rust: self.nodes[vor].ancestor = v;
    // rust: let shift = self.nodes[vil].y + sil - (self.nodes[vir].y + sir) + 1.0;
    // rust: if shift > 0.0 {
    // rust: let a = self.ancestor_of(vil, v, default_ancestor);
    // rust: self.move_subtree(a, v, shift);
    // rust: sir += shift;
    // rust: sor += shift;
}
    // rust: sil += self.nodes[vil].modifier;
    // rust: sir += self.nodes[vir].modifier;
    // rust: sol += self.nodes[vol].modifier;
    // rust: sor += self.nodes[vor].modifier;
}
    // rust: if let Some(l) = self.next_or_thread(vil)
    // rust: && self.next_or_thread(vor).is_none()
    // rust: {
    // rust: self.nodes[vor].thread = Some(l);
    // rust: self.nodes[vor].modifier += sil - sor;
    // rust: } else {
    // rust: if let Some(r) = self.previous_or_thread(vir)
    // rust: && self.previous_or_thread(vol).is_none()
    // rust: {
    // rust: self.nodes[vol].thread = Some(r);
    // rust: self.nodes[vol].modifier += sir - sol;
}
    // rust: default_ancestor = v;
}
    // rust: default_ancestor
}
move_subtree :: proc(self: ^Self, me: uint, right: uint, shift: f32) {
}
    // rust: let subtrees = (self.nodes[right].child_index - self.nodes[me].child_index) as f32;
    // rust: if subtrees != 0.0 {
    // rust: self.nodes[right].change -= shift / subtrees;
    // rust: self.nodes[me].change += shift / subtrees;
}
    // rust: let r = &mut self.nodes[right];
    // rust: r.shift += shift;
    // rust: r.y += shift;
    // rust: r.modifier += shift;
}
ancestor_of :: proc(self: ^Self, me: uint, other: uint, default_ancestor: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let a = self.nodes[me].ancestor;
    // rust: let siblings = self.nodes[other]
    // rust: .parent
    // rust: .map(|p| &self.nodes[p].children[..])
    // rust: .unwrap_or(&[]);
    // rust: if siblings.contains(&a) {
    // rust: a
    // rust: } else {
    // rust: default_ancestor
}
}
}
    // rust: impl Tree {
    // Each advancement's children in `AdvancementTree.addAll` order: the
    // sorted list, a parent listed after its child inserting it a pass later.
children :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut kids = vec![Vec::new(); self.list.len()];
    // rust: let mut inserted = vec![false; self.list.len()];
    // rust: let mut pending: Vec<usize> = (0..self.list.len()).collect();
    // rust: while !pending.is_empty() {
    // rust: let before = pending.len();
    // rust: pending.retain(|&i| {
    // rust: let parent = match &self.list[i].parent {
    // rust: None => None,
    // rust: Some(p) => match self.by_id.get(p) {
    // rust: Some(&p) if inserted[p] => Some(p),
    // rust: _ => return true,
    // rust: },
}
    // rust: if let Some(p) = parent {
    // rust: kids[p].push(i);
}
    // rust: inserted[i] = true;
    // rust: false
    // rust: });
    // rust: if pending.len() == before {
    // rust: break;
}
}
    // rust: kids
}
    // `AdvancementVisibilityEvaluator`: done advancements, their
    // ancestors, and unhidden ones within two levels of a done one.
visible :: proc(self: ^Self, kids: ^[[dynamic]uint], done: impl Fn(uint) -> b {
    // Ported from Horizon
    return {}
}
Rule :: enum {
    Show,
    Hide,
    Same,
}
    // rust: fn walk(
    // rust: tree: &Tree,
    // rust: kids: &[Vec<usize>],
    // rust: done: &dyn Fn(usize) -> bool,
    // rust: i: usize,
    // rust: stack: &mut Vec<Rule>,
    // rust: out: &mut [bool],
    // rust: ) -> bool {
    // rust: let me = done(i);
    // rust: let rule = match &tree.list[i].display {
    // rust: None => Rule::Hide,
    // rust: Some(_) if me => Rule::Show,
    // rust: Some(d) if d.hidden => Rule::Hide,
    // rust: Some(_) => Rule::Same,
}
    // rust: let mut any = me;
    // rust: stack.push(rule);
    // rust: for &c in &kids[i] {
    // rust: any |= walk(tree, kids, done, c, stack, out);
}
    // rust: let near = stack
    // rust: .iter()
    // rust: .rev()
    // rust: .take(3)
    // rust: .find(|r| **r != Rule::Same)
    // rust: .is_some_and(|r| *r == Rule::Show);
    // rust: stack.pop();
    // rust: out[i] = any || near;
    // rust: any
}
    // rust: let mut out = vec![false; self.list.len()];
    // rust: for (i, a) in self.list.iter().enumerate() {
    // rust: if a.parent.is_none() {
    // rust: let mut stack = vec![Rule::Same; 3];
    // rust: walk(self, kids, &done, i, &mut stack, &mut out);
}
}
    // rust: out
}
    // `AdvancementTree.repositionNodes`: (column, row) of every displayed
    // advancement under a displayed root.
layout :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let kids = self.children();
    // rust: let mut out = vec![None; self.list.len()];
    // rust: for (i, a) in self.list.iter().enumerate() {
    // rust: if a.parent.is_some() || a.display.is_none() {
    // rust: continue;
}
    // rust: let mut l = Layout {
    // rust: tree: self,
    // rust: kids: &kids,
    // rust: nodes: Vec::new(),
}
    // rust: let root = l.build(i, None, None, 1, 0);
    // rust: l.first_walk(root);
    // rust: let y = l.nodes[root].y;
    // rust: let min = l.second_walk(root, 0.0, 0, y);
    // rust: if min < 0.0 {
    // rust: l.third_walk(root, -min);
}
    // rust: for n in &l.nodes {
    // rust: out[n.adv] = Some((n.x, n.y));
}
}
    // rust: out
}
}
    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

advancement_reward_function_is_optional_and_namespaced :: proc() {
}
    // rust: for (raw, expected) in [
    // rust: ("parity:reward", "parity:reward"),
    // rust: ("reward", "minecraft:reward"),
    // rust: ] {
    // rust: let input = serde_json::json!({
    // rust: "criteria": {"never": {"trigger": "minecraft:impossible"}},
    // rust: "rewards": {"function": raw, "experience": 7, "recipes": ["minecraft:bread"]}
    // rust: });
    // rust: let advancement = parse("parity:test", &input).unwrap();
    // rust: assert_eq!(advancement.rewards.function.as_deref(), Some(expected));
    // rust: assert_eq!(advancement.rewards.experience, 7);
    // rust: assert_eq!(advancement.rewards.recipes, ["minecraft:bread"]);
}
    // rust: let without = parse(
    // rust: "parity:empty",
    // rust: &serde_json::json!({
    // rust: "criteria": {"never": {"trigger": "minecraft:impossible"}}
    // rust: }),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(without.rewards.function.is_none());
}

    // The criteria an inventory change and a recipe unlock test, on vanilla's tree:
    // `cargo test -p horizon-client --lib -- --ignored --nocapture index_on_vanilla_tree`
    // with HORIZON_RESOURCES set to the prepared resources.
index_on_vanilla_tree :: proc() {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_RESOURCES").map(std::path::PathBuf::from) else {
    // rust: return;
}
    // rust: let data = root.join("data");
    // rust: let t = std::time::Instant::now();
    // rust: let tree = Tree::load(&data);
    // rust: let load = t.elapsed();
    // rust: let tags = data.join("minecraft/tags/item");
    // rust: let tag_items: HashMap<String, Vec<String>> = std::fs::read_dir(&tags)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let v: Value =
    // rust: serde_json::from_str(&std::fs::read_to_string(e.path()).ok()?).ok()?;
    // rust: let name = format!("minecraft:{}", e.path().file_stem()?.to_string_lossy());
    // rust: let values = v["values"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .filter_map(|x| x.as_str().map(str::to_owned));
    // rust: Some((name, values.collect()))
    // rust: })
    // rust: .collect();
    // rust: let t = std::time::Instant::now();
    // rust: let index = InventoryIndex::build(&tree, |tag| {
    // rust: tag_items
    // rust: .get(tag)
    // rust: .map(|v| v.iter().map(String::as_str).collect())
    // rust: .unwrap_or_default()
    // rust: });
    // rust: let build = t.elapsed();
    // rust: let all = tree
    // rust: .by_trigger
    // rust: .get("minecraft:inventory_changed")
    // rust: .map_or(0, Vec::len);
    // rust: let held = [
    // rust: "minecraft:iron_ingot",
    // rust: "minecraft:oak_log",
    // rust: "minecraft:cobblestone",
    // rust: "minecraft:diamond_pickaxe",
    // rust: "minecraft:bread",
    // rust: "minecraft:torch",
    // rust: "minecraft:oak_planks",
    // rust: "minecraft:stick",
    // rust: "minecraft:coal",
    // rust: ];
    // rust: let t = std::time::Instant::now();
    // rust: let mut candidates = 0;
    // rust: for _ in 0..1000 {
    // rust: candidates = index.candidates(held).len();
}
    // rust: let per_change = t.elapsed() / 1000;
    // rust: let recipes = tree
    // rust: .by_trigger
    // rust: .get("minecraft:recipe_unlocked")
    // rust: .map_or(0, Vec::len);
    // rust: let per_recipe = tree.recipe_criteria("minecraft:iron_pickaxe").len();
    // rust: eprintln!(
    // rust: "tree {load:?}; inventory_changed: {all} criteria, index built in {build:?}, \
    // rust: a 9-stack inventory tests {candidates} (looked up in {per_change:?}); \
    // rust: recipe_unlocked: {recipes} criteria, iron_pickaxe tests {per_recipe}"
    // rust: );
    // rust: assert!(candidates < all / 10);
}
Flat :: struct {
    // rust: impl World for Flat {
dimension :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:overworld"
}
weather :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (false, false)
}
biome :: proc(self: ^Self, _: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:plains".into()
}
structures :: proc(self: ^Self, _: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec!["minecraft:village_plains".into()]
}
block :: proc(self: ^Self, _: [i32; 3]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: ("minecraft:stone".into(), BTreeMap::new())
}
fluid :: proc(self: ^Self, _: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
can_see_sky :: proc(self: ^Self, _: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
light :: proc(self: ^Self, _: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 15
}
smokey :: proc(self: ^Self, _: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
in_tag :: proc(self: ^Self, _: string, tag: string, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (tag == "minecraft:stone_tool_materials" && id == "minecraft:cobblestone")
    // rust: || (tag == "minecraft:sulfur_cube_archetype/explosive" && id == "minecraft:tnt")
    // rust: || (tag == "minecraft:is_projectile"
    // rust: && matches!(id, "minecraft:fireball" | "minecraft:arrow"))
}
}
    // `BlockPredicate.matchesBlockEntity`: an `nbt` test needs a block
    // entity whose `saveWithFullMetadata` contains the pattern
    // (`NbtPredicate.matches`), so it never matches a plain block.
a_block_predicates_nbt_needs_the_block_entitys_data :: proc() {
}
    // rust: let w = Flat;
    // rust: let stone = serde_json::json!({"blocks": "minecraft:stone", "nbt": "{}"});
    // rust: assert!(!block(&stone, [0, 0, 0], &w), "stone has no block entity");
    // rust: assert!(block(
    // rust: &serde_json::json!({"blocks": "minecraft:stone"}),
    // rust: [0, 0, 0],
    // rust: &w
    // rust: ));
        // An unpowered beacon: its saved data has `Levels:0`.
Beacon :: struct {
    // rust: impl World for Beacon {
dimension :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: Flat.dimension()
}
weather :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: Flat.weather()
}
biome :: proc(self: ^Self, p: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Flat.biome(p)
}
structures :: proc(self: ^Self, p: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Flat.structures(p)
}
block :: proc(self: ^Self, _: [i32; 3]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: ("minecraft:beacon".into(), BTreeMap::new())
}
fluid :: proc(self: ^Self, _: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
can_see_sky :: proc(self: ^Self, _: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
light :: proc(self: ^Self, _: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 15
}
smokey :: proc(self: ^Self, _: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
in_tag :: proc(self: ^Self, _: string, _: string, _: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
block_entity_nbt :: proc(self: ^Self, _: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: horizon_world::nbt::parse_snbt(r#"{id:"minecraft:beacon",x:0,y:0,z:0,Levels:0}"#)
    // rust: .ok()
    // rust: .map(|(t, _)| t)
}
}
    // rust: let beacon = |nbt: &str| serde_json::json!({"blocks": "minecraft:beacon", "nbt": nbt});
    // rust: assert!(block(&beacon("{Levels:0}"), [0, 0, 0], &Beacon));
    // rust: assert!(block(&beacon("{}"), [0, 0, 0], &Beacon));
    // rust: assert!(!block(&beacon("{Levels:4}"), [0, 0, 0], &Beacon));
    // rust: assert!(
    // rust: !block(&beacon("{Levels:0b}"), [0, 0, 0], &Beacon),
    // rust: "an int, not a byte"
    // rust: );
}
weather_conditions_leave_absent_fields_unconstrained_and_compose :: proc() {
}
    // rust: let ctx = Entities {
    // rust: this: None,
    // rust: origin: [0.0; 3],
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: for (mut predicate, expected) in [
    // rust: (serde_json::json!({}), true),
    // rust: (serde_json::json!({"raining": false}), true),
    // rust: (serde_json::json!({"raining": true}), false),
    // rust: (serde_json::json!({"thundering": false}), true),
    // rust: (serde_json::json!({"thundering": true}), false),
    // rust: (
    // rust: serde_json::json!({"raining": false, "thundering": false}),
    // rust: true,
    // rust: ),
    // rust: (
    // rust: serde_json::json!({"raining": false, "thundering": true}),
    // rust: false,
    // rust: ),
    // rust: ] {
    // rust: predicate["type"] = "minecraft:weather_check".into();
    // rust: assert_eq!(conditions(&predicate, &ctx, &Flat), expected, "{predicate}");
}
    // rust: let dry = serde_json::json!({"type": "minecraft:weather_check", "raining": false});
    // rust: let wet = serde_json::json!({"type": "minecraft:inverted", "term": dry});
    // rust: assert!(!conditions(&wet, &ctx, &Flat));
    // rust: assert!(conditions(
    // rust: &serde_json::json!({"type": "minecraft:all_of", "terms": [dry]}),
    // rust: &ctx,
    // rust: &Flat
    // rust: ));
    // rust: assert!(!conditions(
    // rust: &serde_json::json!({"type": "minecraft:any_of", "terms": [wet]}),
    // rust: &ctx,
    // rust: &Flat
    // rust: ));
}

    // A `recipe_crafted` criterion names `minecraft:x`; the craft hands
    // the recipe book and the trigger the same whole id (`award_crafted`
    // qualifies). The bare name the crafting copy uses never matched —
    // the second half of #7186.
a_recipe_crafted_criterion_matches_the_whole_id_only :: proc() {
}
    // rust: let w = Flat;
    // rust: let criterion = serde_json::json!({"recipes": "minecraft:folder_recipe"});
    // rust: assert!(
    // rust: !id_matches(&criterion["recipes"], "recipe", "folder_recipe", &w),
    // rust: "the crafting copy's bare name never matched the criterion"
    // rust: );
    // rust: assert!(
    // rust: id_matches(
    // rust: &criterion["recipes"],
    // rust: "recipe",
    // rust: &crate::crafting::qualified("folder_recipe"),
    // rust: &w
    // rust: ),
    // rust: "the whole id award_crafted passes matches"
    // rust: );
}

    // `LockCode.canUnlock` for a chest with
    // `lock:{items:"minecraft:gold_ingot"}`: a gold ingot opens it, an empty
    // hand or another item does not, and a spectator always does.
a_lock_takes_its_item_and_any_spectator :: proc() {
}
    // rust: let lock = serde_json::json!({"items": "minecraft:gold_ingot"});
    // rust: let gold = ItemView {
    // rust: id: "minecraft:gold_ingot".into(),
    // rust: count: 1,
    // rust: ..Default::default()
}
    // rust: let stick = ItemView {
    // rust: id: "minecraft:stick".into(),
    // rust: count: 1,
    // rust: ..Default::default()
}
    // rust: assert!(can_unlock(&lock, false, Some(&gold), &Flat));
    // rust: assert!(!can_unlock(&lock, false, Some(&stick), &Flat));
    // rust: assert!(!can_unlock(&lock, false, None, &Flat));
    // rust: assert!(can_unlock(&lock, true, None, &Flat));
    // rust: assert!(can_unlock(&lock, true, Some(&stick), &Flat));
        // `LockCode.NO_LOCK` is the empty predicate: it takes any stack, and
        // `unlocksWith(EMPTY)` too.
    // rust: let none = serde_json::json!({});
    // rust: assert!(can_unlock(&none, false, None, &Flat));
}
    // `ItemPredicate`'s `components` and `predicates` are keyed by registry
    // ids, so a key without a namespace is a `minecraft:` one. An unread key
    // used to be skipped, which let every stack pass.
item_predicate_reads_bare_component_keys :: proc() {
}
    // rust: let potion = ItemView {
    // rust: id: "minecraft:potion".into(),
    // rust: count: 1,
    // rust: potion: Some("minecraft:swiftness".into()),
    // rust: ..Default::default()
}
    // rust: let sword = ItemView {
    // rust: id: "minecraft:iron_sword".into(),
    // rust: count: 1,
    // rust: damage: 3,
    // rust: enchantments: vec![("minecraft:sharpness".into(), 2)],
    // rust: ..Default::default()
}
    // rust: let cases = [
    // rust: (
    // rust: serde_json::json!({"components": {"potion_contents": "minecraft:swiftness"}}),
    // rust: serde_json::json!({"components": {"potion_contents": "minecraft:healing"}}),
    // rust: &potion,
    // rust: ),
    // rust: (
    // rust: serde_json::json!({"components": {"damage": 3}}),
    // rust: serde_json::json!({"components": {"damage": 4}}),
    // rust: &sword,
    // rust: ),
    // rust: (
    // rust: serde_json::json!({"predicates": {"enchantments": [
    // rust: {"enchantments": "sharpness", "levels": 2}
    // rust: ]}}),
    // rust: serde_json::json!({"predicates": {"enchantments": [
    // rust: {"enchantments": "sharpness", "levels": {"min": 3}}
    // rust: ]}}),
    // rust: &sword,
    // rust: ),
    // rust: (
    // rust: serde_json::json!({"predicates": {"damage": {"damage": {"max": 3}}}}),
    // rust: serde_json::json!({"predicates": {"damage": {"damage": {"min": 4}}}}),
    // rust: &sword,
    // rust: ),
    // rust: ];
    // rust: for (yes, no, stack) in cases {
    // rust: assert!(item(&yes, stack, &Flat), "{yes} should match");
    // rust: assert!(!item(&no, stack, &Flat), "{no} should not match");
}
        // The potion is a registry id too.
    // rust: let bare = serde_json::json!({"components": {"minecraft:potion_contents": "swiftness"}});
    // rust: assert!(item(&bare, &potion, &Flat));
}
    // `PassengerPredicate.matches`: ride_a_boat_with_a_goat's vehicle holds a goat.
passenger_predicate_needs_a_matching_passenger :: proc() {
}
    // rust: let want = serde_json::json!({
    // rust: "minecraft:entity_type": "minecraft:oak_boat",
    // rust: "minecraft:passenger": {"minecraft:entity_type": "minecraft:goat"}
    // rust: });
    // rust: let entity = |kind: &str| EntityView {
    // rust: kind: kind.into(),
    // rust: ..Default::default()
}
    // rust: let mut boat = entity("minecraft:oak_boat");
    // rust: assert!(!super::entity(&want, &boat, &Flat, [0.0; 3]));
    // rust: boat.passengers = vec![entity("minecraft:player")];
    // rust: assert!(!super::entity(&want, &boat, &Flat, [0.0; 3]));
    // rust: boat.passengers.push(entity("minecraft:goat"));
    // rust: assert!(super::entity(&want, &boat, &Flat, [0.0; 3]));
}
    // `EntityNbtPredicate.matches`: the entity's saved compound holds the
    // pattern (`NbtUtils.compareNbt(…, true)`); without one it fails.
an_entity_predicates_nbt_tests_the_saved_compound :: proc() {
}
    // rust: let snbt = |s: &str| horizon_world::nbt::parse_snbt(s).unwrap().0;
    // rust: let view = |kind: &str, nbt: &str| EntityView {
    // rust: kind: kind.into(),
    // rust: nbt: Some(snbt(nbt)),
    // rust: ..Default::default()
}
    // rust: let check = |v: serde_json::Value, e: &EntityView| super::entity(&v, e, &Flat, [0.0; 3]);
    // rust: let nbt = |s: &str| serde_json::json!({"minecraft:nbt": s});
    // rust: let axolotl = view("minecraft:axolotl", "{Variant:1,FromBucket:1b}");
    // rust: assert!(check(nbt("{Variant:1}"), &axolotl));
    // rust: assert!(check(nbt("{}"), &axolotl));
    // rust: assert!(!check(nbt("{Variant:0}"), &axolotl));
    // rust: assert!(
    // rust: !check(nbt("{FromBucket:1}"), &axolotl),
    // rust: "a byte, not an int"
    // rust: );
    // rust: let pig = serde_json::json!({"minecraft:entity_type": "minecraft:pig",
    // rust: "minecraft:nbt": "{Variant:1}"});
    // rust: assert!(
    // rust: !check(pig, &axolotl),
    // rust: "the other sub-predicates still apply"
    // rust: );
    // rust: let villager = view(
    // rust: "minecraft:villager",
    // rust: r#"{VillagerData:{level:2,profession:"minecraft:farmer",type:"minecraft:taiga"}}"#,
    // rust: );
    // rust: assert!(check(
    // rust: nbt(r#"{VillagerData:{profession:"minecraft:farmer"}}"#),
    // rust: &villager
    // rust: ));
    // rust: assert!(!check(
    // rust: nbt(r#"{VillagerData:{profession:"minecraft:librarian"}}"#),
    // rust: &villager
    // rust: ));
    // rust: let player = view(
    // rust: "minecraft:player",
    // rust: r#"{Inventory:[{Slot:0b,id:"minecraft:spyglass",count:1},{Slot:3b,id:"minecraft:stick",count:2}],SelectedItem:{id:"minecraft:spyglass",count:1}}"#,
    // rust: );
    // rust: assert!(check(
    // rust: nbt(r#"{Inventory:[{id:"minecraft:stick"}]}"#),
    // rust: &player
    // rust: ));
    // rust: assert!(!check(
    // rust: nbt(r#"{Inventory:[{id:"minecraft:stick",count:3}]}"#),
    // rust: &player
    // rust: ));
    // rust: assert!(
    // rust: !check(nbt("{Inventory:[]}"), &player),
    // rust: "an empty list wants an empty one"
    // rust: );
    // rust: assert!(check(
    // rust: nbt(r#"{SelectedItem:{id:"minecraft:spyglass"}}"#),
    // rust: &player
    // rust: ));
    // rust: let bare = EntityView {
    // rust: kind: "minecraft:axolotl".into(),
    // rust: ..Default::default()
}
    // rust: assert!(!check(nbt("{}"), &bare), "no compound known");
    // rust: assert!(!check(nbt("{Variant:"), &axolotl), "unparsable");
    // rust: assert!(!check(serde_json::json!({"minecraft:nbt": 3}), &axolotl));
}
    // Return to Sender's `killing_blow`: only the ghast's own fireball, as a
    // projectile, kills it for the advancement; a sword or an arrow does not.
killing_blow_needs_the_fireball :: proc() {
}
    // rust: let blow = serde_json::json!({
    // rust: "direct_entity": {"minecraft:entity_type": "minecraft:fireball"},
    // rust: "tags": [{"expected": true, "id": "#minecraft:is_projectile"}]
    // rust: });
    // rust: let entity = |kind: &str| EntityView {
    // rust: kind: kind.into(),
    // rust: ..Default::default()
}
    // rust: let player = entity("minecraft:player");
    // rust: let fireball = DamageView {
    // rust: kind: "minecraft:fireball".into(),
    // rust: direct: Some(entity("minecraft:fireball")),
    // rust: source: Some(player.clone()),
    // rust: ..Default::default()
}
    // rust: assert!(damage_source(&blow, &fireball, &Flat, [0.0; 3]));
    // rust: let sword = DamageView {
    // rust: kind: "minecraft:player_attack".into(),
    // rust: direct: Some(player.clone()),
    // rust: source: Some(player.clone()),
    // rust: is_direct: true,
    // rust: ..Default::default()
}
    // rust: assert!(!damage_source(&blow, &sword, &Flat, [0.0; 3]));
    // rust: let arrow = DamageView {
    // rust: kind: "minecraft:arrow".into(),
    // rust: direct: Some(entity("minecraft:arrow")),
    // rust: source: Some(player),
    // rust: ..Default::default()
}
    // rust: assert!(!damage_source(&blow, &arrow, &Flat, [0.0; 3]));
    // rust: assert!(damage_source(&Value::Null, &sword, &Flat, [0.0; 3]));
}
mob :: proc(kind: string) -> E {
    // Ported from Horizon
    return {}
}
    // rust: EntityView {
    // rust: kind: kind.into(),
    // rust: ..Default::default()
}
}
    // `TeamPredicate.matches`: the effective team's name, exactly.
team_predicate_needs_the_exact_team_name :: proc() {
}
    // rust: let team = |v: &str| serde_json::json!({ v: "audit_team" });
    // rust: let member = EntityView {
    // rust: team: Some("audit_team".into()),
    // rust: ..mob("minecraft:zombie")
}
    // rust: for key in ["team", "minecraft:team"] {
    // rust: assert!(entity(&team(key), &member, &Flat, [0.0; 3]));
}
    // rust: let other = EntityView {
    // rust: team: Some("Audit_Team".into()),
    // rust: ..mob("minecraft:zombie")
}
    // rust: assert!(!entity(&team("team"), &other, &Flat, [0.0; 3]));
    // rust: assert!(!entity(
    // rust: &team("team"),
    // rust: &mob("minecraft:zombie"),
    // rust: &Flat,
    // rust: [0.0; 3]
    // rust: ));
}
    // `entity_killed_player` by a mob's melee hit: the mob is the killer and
    // the blow's causing and direct entity.
entity_killed_player_by_a_mob_names_the_mob :: proc() {
}
    // rust: let c = serde_json::json!({
    // rust: "entity": {"minecraft:entity_type": "minecraft:polar_bear"},
    // rust: "killing_blow": {"source_entity": {"minecraft:entity_type": "minecraft:polar_bear"}}
    // rust: });
    // rust: let me = mob("minecraft:player");
    // rust: let bear = mob("minecraft:polar_bear");
    // rust: let blow = recorded_blow("minecraft:mob_attack".into(), Some(bear.clone()), [0.0; 3]);
    // rust: assert!(blow.is_direct);
    // rust: assert_eq!(
    // rust: blow.direct.as_ref().map(|e| e.kind.as_str()),
    // rust: Some("minecraft:polar_bear")
    // rust: );
    // rust: assert!(killed(&c, &me, &bear, Some(&blow), &Flat));
    // rust: let panda = mob("minecraft:panda");
    // rust: let blow = recorded_blow("minecraft:mob_attack".into(), Some(panda.clone()), [0.0; 3]);
    // rust: assert!(!killed(&c, &me, &panda, Some(&blow), &Flat));
}
    // `entity_killed_player` by a skeleton's arrow: the shooter is the
    // killer and the blow's causing entity, the arrow its direct one.
entity_killed_player_by_an_arrow_names_the_shooter :: proc() {
}
    // rust: let c = serde_json::json!({
    // rust: "entity": {"minecraft:entity_type": "minecraft:skeleton"},
    // rust: "killing_blow": {
    // rust: "direct_entity": {"minecraft:entity_type": "minecraft:arrow"},
    // rust: "source_entity": {"minecraft:entity_type": "minecraft:skeleton"},
    // rust: "is_direct": false
}
    // rust: });
    // rust: let me = mob("minecraft:player");
    // rust: let skeleton = mob("minecraft:skeleton");
    // rust: let blow = recorded_blow(
    // rust: "minecraft:arrow".into(),
    // rust: Some(skeleton.clone()),
    // rust: [1.0, 2.0, 3.0],
    // rust: );
    // rust: assert!(!blow.is_direct);
    // rust: assert_eq!(
    // rust: blow.direct.as_ref().map(|e| e.position),
    // rust: Some([1.0, 2.0, 3.0])
    // rust: );
    // rust: assert!(killed(&c, &me, &skeleton, Some(&blow), &Flat));
        // Shot point-blank, not with an arrow: the direct entity is the skeleton.
    // rust: let melee = recorded_blow(
    // rust: "minecraft:mob_attack".into(),
    // rust: Some(skeleton.clone()),
    // rust: [0.0; 3],
    // rust: );
    // rust: assert!(!killed(&c, &me, &skeleton, Some(&melee), &Flat));
}
    // A blow with no causing entity fails a `source_entity` test, and with
    // no blow at all any `killing_blow` fails.
a_blow_with_no_killer_fails_its_entity_tests :: proc() {
}
    // rust: let c = serde_json::json!({
    // rust: "killing_blow": {"source_entity": {"minecraft:entity_type": "minecraft:zombie"}}
    // rust: });
    // rust: let me = mob("minecraft:player");
    // rust: let zombie = mob("minecraft:zombie");
    // rust: let fall = recorded_blow("minecraft:fall".into(), None, [0.0; 3]);
    // rust: assert!(fall.direct.is_none() && fall.source.is_none());
    // rust: assert!(!killed(&c, &me, &zombie, Some(&fall), &Flat));
    // rust: assert!(!killed(&c, &me, &zombie, None, &Flat));
    // rust: assert!(killed(&serde_json::json!({}), &me, &zombie, None, &Flat));
}
uh_oh_accepts_either_tnt_event_only_for_adult_sulfur_cubes :: proc() {
}
    // rust: let path = Path::new(env!("CARGO_MANIFEST_DIR")).join(
    // rust: "../../.local/horizon-client/26.3/data/minecraft/advancement/husbandry/uh_oh.json",
    // rust: );
    // rust: if !path.exists() {
    // rust: return;
}
    // rust: let json = serde_json::from_slice(&std::fs::read(path).unwrap()).unwrap();
    // rust: let advancement = parse("minecraft:husbandry/uh_oh", &json).unwrap();
    // rust: assert_eq!(advancement.criteria.len(), 2);
    // rust: let player = EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: ..Default::default()
}
    // rust: let mut target = EntityView {
    // rust: kind: "minecraft:sulfur_cube".into(),
    // rust: ..Default::default()
}
    // rust: let mut stack = ItemView {
    // rust: id: "minecraft:tnt".into(),
    // rust: count: 1,
    // rust: ..Default::default()
}
    // rust: for criterion in &advancement.criteria {
    // rust: assert!(item_entity(
    // rust: &criterion.conditions,
    // rust: &player,
    // rust: &target,
    // rust: &stack,
    // rust: &Flat
    // rust: ));
    // rust: let mut progress = Progress::default();
    // rust: progress.grant(&advancement.id, &criterion.name, "test");
    // rust: assert!(
    // rust: progress.done(&advancement),
    // rust: "either criterion must award Uh Oh"
    // rust: );
    // rust: target.baby = true;
    // rust: assert!(!item_entity(
    // rust: &criterion.conditions,
    // rust: &player,
    // rust: &target,
    // rust: &stack,
    // rust: &Flat
    // rust: ));
    // rust: target.baby = false;
    // rust: target.kind = "minecraft:pig".into();
    // rust: assert!(!item_entity(
    // rust: &criterion.conditions,
    // rust: &player,
    // rust: &target,
    // rust: &stack,
    // rust: &Flat
    // rust: ));
    // rust: target.kind = "minecraft:sulfur_cube".into();
    // rust: stack.id = "minecraft:stone".into();
    // rust: assert!(!item_entity(
    // rust: &criterion.conditions,
    // rust: &player,
    // rust: &target,
    // rust: &stack,
    // rust: &Flat
    // rust: ));
    // rust: stack.id = "minecraft:tnt".into();
}
}
    // Only the criteria the held items could pass are tested; those that
    // need no particular item always are.
inventory_index_keeps_the_criteria_the_items_could_pass :: proc() {
}
    // rust: let criteria = [
    // rust: serde_json::json!({"items": [{"items": "minecraft:diamond"}]}),
    // rust: serde_json::json!({"items": [{"items": "#minecraft:planks"}]}),
    // rust: serde_json::json!({"items": [{"count": {"min": 2}}]}),
    // rust: serde_json::json!({"items": [{"count": 1}, {"items": ["minecraft:stick", "minecraft:apple"]}]}),
    // rust: serde_json::json!({"slots": {"empty": 0}}),
    // rust: serde_json::json!({"items": [{"items": "#minecraft:no_such_tag"}]}),
    // rust: ];
    // rust: let mut tree = Tree::default();
    // rust: for (i, conditions) in criteria.into_iter().enumerate() {
    // rust: tree.list.push(Advancement {
    // rust: id: format!("test:{i}"),
    // rust: parent: None,
    // rust: display: None,
    // rust: criteria: vec![Criterion {
    // rust: name: "c".into(),
    // rust: trigger: "minecraft:inventory_changed".into(),
    // rust: conditions: LazyJson::new(&conditions),
    // rust: }],
    // rust: requirements: vec![vec!["c".into()]],
    // rust: rewards: Rewards::default(),
    // rust: });
    // rust: tree.by_trigger
    // rust: .entry("minecraft:inventory_changed".into())
    // rust: .or_default()
    // rust: .push((i, 0));
}
    // rust: let index = InventoryIndex::build(&tree, |tag| match tag {
    // rust: "minecraft:planks" => vec!["minecraft:oak_planks", "minecraft:birch_planks"],
    // rust: _ => Vec::new(),
    // rust: });
    // rust: let found = |held: &[&str]| -> Vec<usize> {
    // rust: index
    // rust: .candidates(held.iter().copied())
    // rust: .into_iter()
    // rust: .map(|(ai, _)| ai)
    // rust: .collect()
}
    // rust: assert_eq!(found(&[]), [2, 4]);
    // rust: assert_eq!(found(&["minecraft:dirt"]), [2, 4]);
    // rust: assert_eq!(
    // rust: found(&["minecraft:oak_planks", "minecraft:diamond"]),
    // rust: [0, 1, 2, 4]
    // rust: );
    // rust: assert_eq!(found(&["minecraft:apple", "minecraft:apple"]), [2, 3, 4]);
}
    // A recipe unlocked tests only the criteria that name it.
recipe_index_keeps_the_criteria_of_the_recipe :: proc() {
}
    // rust: let mut tree = Tree::default();
    // rust: for (i, conditions) in [
    // rust: serde_json::json!({"recipes": "minecraft:oak_planks"}),
    // rust: serde_json::json!({"recipes": "minecraft:stick"}),
    // rust: serde_json::json!({}),
    // rust: serde_json::json!({"recipes": "minecraft:oak_planks"}),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: tree.list.push(Advancement {
    // rust: id: format!("test:{i}"),
    // rust: parent: None,
    // rust: display: None,
    // rust: criteria: vec![Criterion {
    // rust: name: "c".into(),
    // rust: trigger: "minecraft:recipe_unlocked".into(),
    // rust: conditions: LazyJson::new(&conditions),
    // rust: }],
    // rust: requirements: vec![vec!["c".into()]],
    // rust: rewards: Rewards::default(),
    // rust: });
    // rust: tree.by_trigger
    // rust: .entry("minecraft:recipe_unlocked".into())
    // rust: .or_default()
    // rust: .push((i, 0));
}
    // rust: tree.index_recipes();
    // rust: assert_eq!(
    // rust: tree.recipe_criteria("minecraft:oak_planks"),
    // rust: [(0, 0), (2, 0), (3, 0)]
    // rust: );
    // rust: assert_eq!(tree.recipe_criteria("minecraft:stick"), [(1, 0), (2, 0)]);
    // rust: assert_eq!(tree.recipe_criteria("minecraft:torch"), [(2, 0)]);
}
bucket_axolotl_block_advancements_require_the_placed_block :: proc() {
}
    // rust: let ctx = Entities {
    // rust: this: None,
    // rust: origin: [0.0; 3],
    // rust: tool: None,
    // rust: block_pos: Some([0; 3]),
}
    // rust: let stone = serde_json::json!({"type":"minecraft:match_block","blocks":"minecraft:stone"});
    // rust: let wheat = serde_json::json!({"type":"minecraft:match_block","blocks":"minecraft:wheat"});
    // rust: assert!(conditions(&stone, &ctx, &Flat));
    // rust: assert!(!conditions(&wheat, &ctx, &Flat));
    // rust: let absent = Entities {
    // rust: block_pos: None,
    // rust: ..ctx
}
    // rust: assert!(!conditions(&stone, &absent, &Flat));
}
    // Data pack ids, tags and registry keys written without a namespace are
    // `minecraft:` ones (`Identifier.parse`), wherever a predicate reads one.
bare_ids_and_tags_mean_minecraft :: proc() {
}
    // rust: let w = Flat;
    // rust: let player = EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: position: [0.5, 64.0, 0.5],
    // rust: effects: vec![("minecraft:speed".into(), 0, 100)],
    // rust: ..Default::default()
}
    // rust: let stone = ItemView {
    // rust: id: "minecraft:cobblestone".into(),
    // rust: count: 1,
    // rust: ..Default::default()
}
    // rust: let ctx = Entities {
    // rust: this: Some(&player),
    // rust: origin: player.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let arrow = DamageView {
    // rust: kind: "minecraft:arrow".into(),
    // rust: ..Default::default()
}
    // rust: let o = [0.0; 3];
    // rust: let j = |s: &str| serde_json::from_str::<Value>(s).unwrap();
    // rust: let cases = [
    // rust: (
    // rust: "item id",
    // rust: id_matches(&j(r#""cobblestone""#), "item", &stone.id, &w),
    // rust: ),
    // rust: (
    // rust: "item tag",
    // rust: id_matches(&j(r##""#stone_tool_materials""##), "item", &stone.id, &w),
    // rust: ),
    // rust: (
    // rust: "item list",
    // rust: id_matches(&j(r#"["dirt", "cobblestone"]"#), "item", &stone.id, &w),
    // rust: ),
    // rust: (
    // rust: "item predicate",
    // rust: item(&j(r#"{"items": "cobblestone"}"#), &stone, &w),
    // rust: ),
    // rust: (
    // rust: "dimension",
    // rust: location(&j(r#"{"dimension": "overworld"}"#), player.position, &w),
    // rust: ),
    // rust: (
    // rust: "biome",
    // rust: location(&j(r#"{"biomes": "plains"}"#), player.position, &w),
    // rust: ),
    // rust: (
    // rust: "entity type",
    // rust: entity(&j(r#"{"minecraft:entity_type": "player"}"#), &player, &w, o),
    // rust: ),
    // rust: (
    // rust: "sub-predicate key",
    // rust: entity(&j(r#"{"entity_type": "minecraft:player"}"#), &player, &w, o),
    // rust: ),
    // rust: (
    // rust: "effect key",
    // rust: entity(
    // rust: &j(r#"{"minecraft:effects": {"speed": {}}}"#),
    // rust: &player,
    // rust: &w,
    // rust: o,
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "damage tag",
    // rust: damage_source(
    // rust: &j(r##"{"tags": [{"id": "#is_projectile", "expected": true}]}"##),
    // rust: &arrow,
    // rust: &w,
    // rust: o,
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "condition type",
    // rust: conditions(
    // rust: &j(r#"{"type": "entity_properties", "entity": "this",
    // rust: "predicate": {"minecraft:entity_type": "minecraft:player"}}"#),
    // rust: &ctx,
    // rust: &w,
    // rust: ),
    // rust: ),
            // `TagPredicate.id` is a holder set: one damage type is that type.
    // rust: (
    // rust: "damage type",
    // rust: damage_source(&j(r#"{"tags": [{"id": "arrow"}]}"#), &arrow, &w, o),
    // rust: ),
            // Near misses stay misses.
    // rust: (
    // rust: "other item",
    // rust: !id_matches(&j(r#"["dirt", "stone"]"#), "item", &stone.id, &w),
    // rust: ),
    // rust: (
    // rust: "other dimension",
    // rust: !location(&j(r#"{"dimension": "the_nether"}"#), player.position, &w),
    // rust: ),
    // rust: (
    // rust: "other effect",
    // rust: !entity(&j(r#"{"effects": {"slowness": {}}}"#), &player, &w, o),
    // rust: ),
    // rust: (
    // rust: "other damage type",
    // rust: !damage_source(&j(r#"{"tags": [{"id": "fireball"}]}"#), &arrow, &w, o),
    // rust: ),
    // rust: (
    // rust: "the type key is no sub-predicate",
    // rust: !entity(&j(r#"{"type": "player"}"#), &player, &w, o),
    // rust: ),
    // rust: ];
    // rust: let failed: Vec<&str> = cases.iter().filter(|c| !c.1).map(|c| c.0).collect();
    // rust: assert!(
    // rust: failed.is_empty(),
    // rust: "bare ids not read as minecraft: {failed:?}"
    // rust: );
}
    // A bare trigger, item or recipe id reaches the indexes as `minecraft:`.
bare_ids_reach_the_trigger_and_item_indexes :: proc() {
}
    // rust: let a = parse(
    // rust: "test:a",
    // rust: &serde_json::json!({"criteria": {
    // rust: "items": {"trigger": "inventory_changed",
    // rust: "conditions": {"items": [{"items": ["cobblestone", "#planks"]}]}},
    // rust: "recipe": {"trigger": "recipe_unlocked", "conditions": {"recipes": "stick"}}
    // rust: }}),
    // rust: )
    // rust: .unwrap();
    // rust: let mut tree = Tree::default();
    // rust: for (ci, c) in a.criteria.iter().enumerate() {
    // rust: tree.by_trigger
    // rust: .entry(c.trigger.clone())
    // rust: .or_default()
    // rust: .push((0, ci));
}
    // rust: tree.list.push(a);
    // rust: tree.index_recipes();
    // rust: let index = InventoryIndex::build(&tree, |tag| match tag {
    // rust: "minecraft:planks" => vec!["minecraft:oak_planks"],
    // rust: _ => Vec::new(),
    // rust: });
    // rust: let mut failed = Vec::new();
    // rust: if !tree.by_trigger.contains_key("minecraft:inventory_changed") {
    // rust: failed.push("trigger");
}
    // rust: if index.candidates(["minecraft:cobblestone"]).is_empty() {
    // rust: failed.push("item index id");
}
    // rust: if index.candidates(["minecraft:oak_planks"]).is_empty() {
    // rust: failed.push("item index tag");
}
    // rust: if tree.recipe_criteria("minecraft:stick").is_empty() {
    // rust: failed.push("recipe index");
}
    // rust: assert!(
    // rust: failed.is_empty(),
    // rust: "bare ids not read as minecraft: {failed:?}"
    // rust: );
}
predicates_match_tags_ranges_and_locations :: proc() {
}
    // rust: let w = Flat;
    // rust: let stone = ItemView {
    // rust: id: "minecraft:cobblestone".into(),
    // rust: count: 3,
    // rust: ..Default::default()
}
    // rust: assert!(item(
    // rust: &serde_json::json!({"items": "#minecraft:stone_tool_materials"}),
    // rust: &stone,
    // rust: &w
    // rust: ));
    // rust: assert!(!item(
    // rust: &serde_json::json!({"items": "minecraft:dirt"}),
    // rust: &stone,
    // rust: &w
    // rust: ));
    // rust: assert!(item(&serde_json::json!({"count": {"min": 2}}), &stone, &w));
    // rust: let player = EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: position: [0.5, 64.0, 0.5],
    // rust: ..Default::default()
}
    // rust: let cond = serde_json::json!({
    // rust: "type": "minecraft:entity_properties",
    // rust: "entity": "this",
    // rust: "predicate": {"minecraft:location": {"structures": "minecraft:village_plains"}}
    // rust: });
    // rust: let ctx = Entities {
    // rust: this: Some(&player),
    // rust: origin: player.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: assert!(conditions(&cond, &ctx, &w));
    // rust: let mut p = Progress::default();
    // rust: let a = parse(
    // rust: "minecraft:t",
    // rust: &serde_json::json!({"criteria": {"a": {"trigger": "minecraft:tick"}, "b": {"trigger": "minecraft:tick"}},
    // rust: "requirements": [["a", "b"]]}),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(!p.done(&a));
    // rust: p.grant("minecraft:t", "b", "now");
    // rust: assert!(p.done(&a));
}
layout_spreads_children_like_tree_node_position :: proc() {
}
    // rust: let mut tree = Tree::default();
    // rust: let shown = Display {
    // rust: icon: String::new(),
    // rust: title: Value::Null,
    // rust: description: Value::Null,
    // rust: frame: Frame::Task,
    // rust: background: None,
    // rust: show_toast: true,
    // rust: announce: true,
    // rust: hidden: false,
}
        // Sorted ids; "b" names a parent that sorts after it.
    // rust: for (id, parent) in [
    // rust: ("a", Some("r")),
    // rust: ("b", Some("e")),
    // rust: ("c", Some("a")),
    // rust: ("d", Some("a")),
    // rust: ("e", Some("r")),
    // rust: ("r", None),
    // rust: ] {
    // rust: tree.by_id.insert(id.into(), tree.list.len());
    // rust: tree.list.push(Advancement {
    // rust: id: id.into(),
    // rust: parent: parent.map(Into::into),
    // rust: display: Some(shown.clone()),
    // rust: criteria: Vec::new(),
    // rust: requirements: Vec::new(),
    // rust: rewards: Rewards::default(),
    // rust: });
}
    // rust: let kids = tree.children();
    // rust: assert_eq!(kids[5], vec![0, 4]);
    // rust: let l = tree.layout();
    // rust: assert_eq!(l[5], Some((0, 1.25)));
    // rust: assert_eq!(l[0], Some((1, 0.5)));
    // rust: assert_eq!(l[2], Some((2, 0.0)));
    // rust: assert_eq!(l[3], Some((2, 1.0)));
    // rust: assert_eq!(l[4], Some((1, 2.0)));
    // rust: assert_eq!(l[1], Some((2, 2.0)));
}
    // A tree of the given advancements, indexed as `load_with` does.
tree_of :: proc(list: ^[(string) {
}
    // rust: let mut tree = Tree::default();
    // rust: for (id, v) in list {
    // rust: let a = parse(id, v).expect("an advancement");
    // rust: for (ci, c) in a.criteria.iter().enumerate() {
    // rust: (tree.by_trigger.entry(c.trigger.clone()).or_default()).push((tree.list.len(), ci));
}
    // rust: tree.by_id.insert((*id).into(), tree.list.len());
    // rust: tree.list.push(a);
}
    // rust: tree.index_player_facts();
    // rust: tree
}
    // Whether the player `facts` match `{"type_specific/player": p}`.
player_matches :: proc(p: Value, facts: ^PlayerFacts) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let me = EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: player_facts: facts.clone(),
    // rust: ..EntityView::default()
}
    // rust: entity(&json!({"type_specific/player": p}), &me, &Flat, [0.0; 3])
}
player_level_is_tested_in_its_bounds :: proc() {
}
    // rust: let five = PlayerFacts {
    // rust: level: Some(5),
    // rust: ..PlayerFacts::default()
}
    // rust: for (level, expected) in [
    // rust: (json!({"min": 5}), true),
    // rust: (json!({"min": 6}), false),
    // rust: (json!({"max": 4}), false),
    // rust: (json!({"min": 1, "max": 5}), true),
    // rust: (json!(5), true),
    // rust: (json!(6), false),
    // rust: ] {
    // rust: assert_eq!(
    // rust: player_matches(json!({"level": level}), &five),
    // rust: expected,
    // rust: "{level}"
    // rust: );
}
        // Not filled: a level asked fails, none asked passes.
    // rust: assert!(!player_matches(
    // rust: json!({"level": {"min": 0}}),
    // rust: &PlayerFacts::default()
    // rust: ));
    // rust: assert!(player_matches(json!({}), &PlayerFacts::default()));
}
player_stats_match_each_counter_by_type_and_id :: proc() {
}
    // rust: let mut counts: BTreeMap<String, BTreeMap<String, i32>> = BTreeMap::new();
    // rust: (counts.entry("minecraft:custom".into()).or_default())
    // rust: .insert("minecraft:walk_one_cm".into(), 1000);
    // rust: (counts.entry("minecraft:mined".into()).or_default()).insert("minecraft:stone".into(), 3);
    // rust: let facts = PlayerFacts {
    // rust: stats: Some(counts),
    // rust: ..PlayerFacts::default()
}
    // rust: let stat =
    // rust: |ty: &str, id: &str, value: Value| json!({"type": ty, "stat": id, "value": value});
    // rust: for (stats, expected) in [
    // rust: (
    // rust: vec![stat(
    // rust: "minecraft:custom",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"min": 1000}),
    // rust: )],
    // rust: true,
    // rust: ),
    // rust: (
    // rust: vec![stat(
    // rust: "minecraft:custom",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"min": 1001}),
    // rust: )],
    // rust: false,
    // rust: ),
    // rust: (
    // rust: vec![stat(
    // rust: "minecraft:custom",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"max": 999}),
    // rust: )],
    // rust: false,
    // rust: ),
            // Bare ids are `minecraft:` ones.
    // rust: (
    // rust: vec![stat("custom", "walk_one_cm", json!({"min": 1000}))],
    // rust: true,
    // rust: ),
            // The same id under another type is another counter: never counted, 0.
    // rust: (
    // rust: vec![stat(
    // rust: "minecraft:mined",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"min": 1}),
    // rust: )],
    // rust: false,
    // rust: ),
    // rust: (
    // rust: vec![stat(
    // rust: "minecraft:mined",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"max": 0}),
    // rust: )],
    // rust: true,
    // rust: ),
    // rust: (
    // rust: vec![stat("minecraft:killed", "minecraft:zombie", json!(0))],
    // rust: true,
    // rust: ),
            // Every entry must match.
    // rust: (
    // rust: vec![
    // rust: stat("minecraft:mined", "minecraft:stone", json!({"min": 3})),
    // rust: stat(
    // rust: "minecraft:custom",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"min": 5000}),
    // rust: ),
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: (
    // rust: vec![
    // rust: stat("minecraft:mined", "minecraft:stone", json!({"min": 3})),
    // rust: stat(
    // rust: "minecraft:custom",
    // rust: "minecraft:walk_one_cm",
    // rust: json!({"min": 500}),
    // rust: ),
    // rust: ],
    // rust: true,
    // rust: ),
    // rust: ] {
    // rust: let p = json!({"stats": stats});
    // rust: assert_eq!(player_matches(p.clone(), &facts), expected, "{p}");
}
    // rust: let walked = json!({"stats": [stat("custom", "walk_one_cm", json!({"min": 0}))]});
    // rust: assert!(!player_matches(walked, &PlayerFacts::default()));
}
player_recipes_are_known_or_not_as_asked :: proc() {
}
    // rust: let facts = PlayerFacts {
    // rust: recipes: Some(["minecraft:iron_pickaxe".to_owned()].into()),
    // rust: ..PlayerFacts::default()
}
    // rust: for (recipes, expected) in [
    // rust: (json!({"minecraft:iron_pickaxe": true}), true),
    // rust: (json!({"iron_pickaxe": true}), true),
    // rust: (json!({"minecraft:iron_pickaxe": false}), false),
    // rust: (json!({"minecraft:diamond_pickaxe": false}), true),
    // rust: (json!({"minecraft:diamond_pickaxe": true}), false),
    // rust: (
    // rust: json!({"minecraft:iron_pickaxe": true, "minecraft:diamond_pickaxe": true}),
    // rust: false,
    // rust: ),
    // rust: ] {
    // rust: assert_eq!(
    // rust: player_matches(json!({"recipes": recipes}), &facts),
    // rust: expected,
    // rust: "{recipes}"
    // rust: );
}
    // rust: let unknown = json!({"recipes": {"minecraft:diamond_pickaxe": false}});
    // rust: assert!(!player_matches(unknown, &PlayerFacts::default()));
}
player_advancements_are_done_or_have_their_criteria_as_asked :: proc() {
}
    // rust: let tick = json!({"trigger": "minecraft:tick"});
    // rust: let tree = Arc::new(tree_of(&[(
    // rust: "pack:a",
    // rust: json!({"criteria": {"x": tick, "y": tick}}),
    // rust: )]));
    // rust: let mut progress = Progress::default();
    // rust: progress.grant("pack:a", "x", "2026-11-04 12:00:00 +0000");
    // rust: let half = PlayerFacts {
    // rust: advancements: Some((tree.clone(), progress.clone())),
    // rust: ..PlayerFacts::default()
}
    // rust: for (advancements, expected) in [
    // rust: (json!({"pack:a": true}), false),
    // rust: (json!({"pack:a": false}), true),
    // rust: (json!({"pack:a": {"x": true}}), true),
    // rust: (json!({"pack:a": {"x": false}}), false),
    // rust: (json!({"pack:a": {"y": true}}), false),
    // rust: (json!({"pack:a": {"y": false}}), true),
    // rust: (json!({"pack:a": {"x": true, "y": true}}), false),
            // A criterion the advancement doesn't have, or an advancement
            // that isn't loaded, matches nothing.
    // rust: (json!({"pack:a": {"z": false}}), false),
    // rust: (json!({"pack:missing": false}), false),
    // rust: ] {
    // rust: assert_eq!(
    // rust: player_matches(json!({"advancements": advancements}), &half),
    // rust: expected,
    // rust: "{advancements}"
    // rust: );
}
    // rust: progress.grant("pack:a", "y", "2026-11-04 12:00:01 +0000");
    // rust: let done = PlayerFacts {
    // rust: advancements: Some((tree, progress)),
    // rust: ..PlayerFacts::default()
}
    // rust: assert!(player_matches(
    // rust: json!({"advancements": {"pack:a": true}}),
    // rust: &done
    // rust: ));
    // rust: assert!(!player_matches(
    // rust: json!({"advancements": {"pack:a": false}}),
    // rust: &done
    // rust: ));
    // rust: let asked = json!({"advancements": {"pack:a": false}});
    // rust: assert!(!player_matches(asked, &PlayerFacts::default()));
}
player_facts_are_asked_by_the_triggers_that_name_them :: proc() {
}
    // rust: let player = |p: Value| {
    // rust: json!({"player": [{"condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"minecraft:type_specific/player": p}}]})
}
    // rust: let tree = tree_of(&[
    // rust: (
    // rust: "pack:walk",
    // rust: json!({"criteria": {"c": {"trigger": "minecraft:tick",
    // rust: "conditions": player(json!({"stats": [{"type": "minecraft:custom",
    // rust: "stat": "minecraft:walk_one_cm", "value": {"min": 1}}]}))}}}),
    // rust: ),
    // rust: (
    // rust: "pack:milestone",
    // rust: json!({"criteria": {"c": {"trigger": "minecraft:location",
    // rust: "conditions": player(json!({"advancements": {"pack:walk": true},
    // rust: "level": {"min": 30}}))}}}),
    // rust: ),
    // rust: (
    // rust: "pack:ref",
    // rust: json!({"criteria": {"c": {"trigger": "minecraft:inventory_changed",
    // rust: "conditions": {"player": [{"condition": "minecraft:reference",
    // rust: "name": "pack:p"}]}}}}),
    // rust: ),
    // rust: (
    // rust: "pack:recipe",
    // rust: json!({"criteria": {"c": {"trigger": "minecraft:recipe_unlocked",
    // rust: "conditions": {"recipe": "minecraft:iron_pickaxe"}},
    // rust: "d": {"trigger": "minecraft:using_item",
    // rust: "conditions": player(json!({"gamemode": ["survival"]}))}}}),
    // rust: ),
    // rust: ]);
    // rust: let none = FactsAsked::default();
    // rust: assert_eq!(
    // rust: tree.player_facts_asked("minecraft:tick"),
    // rust: FactsAsked {
    // rust: stats: true,
    // rust: ..none
}
    // rust: );
    // rust: assert_eq!(
    // rust: tree.player_facts_asked("minecraft:location"),
    // rust: FactsAsked {
    // rust: advancements: true,
    // rust: level: true,
    // rust: ..none
}
    // rust: );
    // rust: assert_eq!(
    // rust: tree.player_facts_asked("minecraft:inventory_changed"),
    // rust: FactsAsked::ALL
    // rust: );
    // rust: assert_eq!(tree.player_facts_asked("minecraft:recipe_unlocked"), none);
    // rust: assert_eq!(tree.player_facts_asked("minecraft:using_item"), none);
}
a_command_predicate_asks_only_the_player_facts_it_names :: proc() {
}
    // rust: let player = |p: Value| {
    // rust: json!({"condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"type_specific/player": p}})
}
    // rust: let none = FactsAsked::default();
    // rust: for (v, expected) in [
            // Nothing of the player's records: nothing copied.
    // rust: (
    // rust: json!({"condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"flags": {"is_sneaking": true}}}),
    // rust: none,
    // rust: ),
    // rust: (player(json!({"gamemode": ["survival"]})), none),
    // rust: (
    // rust: json!({"condition": "minecraft:random_chance", "chance": 0.5}),
    // rust: none,
    // rust: ),
            // A field named elsewhere than in a player predicate.
    // rust: (
    // rust: json!({"function": "minecraft:enchant_with_levels", "levels": 30,
    // rust: "conditions": [{"condition": "minecraft:inverted",
    // rust: "term": {"condition": "minecraft:entity_properties", "entity": "this",
    // rust: "predicate": {"minecraft:effects": {"minecraft:speed": {}}}}}]}),
    // rust: none,
    // rust: ),
    // rust: (
    // rust: player(json!({"level": {"min": 3}})),
    // rust: FactsAsked {
    // rust: level: true,
    // rust: ..none
    // rust: },
    // rust: ),
            // Nested in a list, under `inverted`, in an item modifier.
    // rust: (
    // rust: json!([{"function": "minecraft:set_count", "count": 2, "conditions": [
    // rust: {"condition": "minecraft:inverted", "term": player(json!({
    // rust: "stats": [], "recipes": {"minecraft:bread": true}}))}]}]),
    // rust: FactsAsked {
    // rust: stats: true,
    // rust: recipes: true,
    // rust: ..none
    // rust: },
    // rust: ),
    // rust: (
    // rust: json!({"condition": "minecraft:all_of", "terms": [player(json!(
    // rust: {"advancements": {"minecraft:story/root": true}}))]}),
    // rust: FactsAsked {
    // rust: advancements: true,
    // rust: ..none
    // rust: },
    // rust: ),
            // A predicate file could ask anything.
    // rust: (
    // rust: json!({"condition": "reference", "name": "pack:p"}),
    // rust: FactsAsked::ALL,
    // rust: ),
    // rust: (
    // rust: json!([{"function": "minecraft:reference", "name": "pack:m"}]),
    // rust: FactsAsked::ALL,
    // rust: ),
    // rust: ] {
    // rust: assert_eq!(facts_asked_in(&v), expected, "{v}");
}
}
saved_dates_read_back_to_their_instant :: proc() {
}
    // rust: for secs in [0, 951_782_400, 1_792_216_800, 4_107_542_399] {
    // rust: assert_eq!(date_millis(&date_text(secs)), Some(secs * 1000));
}
    // rust: assert_eq!(
    // rust: date_millis("2026-10-17 07:30:00 +0200"),
    // rust: date_millis("2026-10-17 05:30:00 +0000")
    // rust: );
    // rust: assert_eq!(date_millis("not a date"), None);
}
}
