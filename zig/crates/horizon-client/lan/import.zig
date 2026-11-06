//! Transpiled from Horizon Rust crate
//! Module: horizon-client_import
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `player-import`: a player's record, as `player-export` made it on another
//! server (or the same one), applied to the held player that has just logged in.
//!
//! The record can be applied whole or in parts. A part left out keeps what the
//! held player has: the state this server loaded for it when it logged in (its own
//! file, or a new player's defaults). The parts are named as the operator of a proxy
//! names them, and each is a set of the guest's fields:
//!
//! | part | what it sets |
//! | --- | --- |
//! | `inventory` | the inventory, armour, off hand and the selected slot |
//! | `ender_chest` | the ender chest |
//! | `experience` | the level, the progress, the total and the seed |
//! | `health` | health and absorption, food, saturation, exhaustion and its timer, and the body's air, fire and freezing |
//! | `effects` | the active effects |
//! | `game_mode` | the game mode, the flight and its speed |
//! | `position` | where it stands, how it looks, whether it is on the ground, its fall and motion, the vehicle it rode |
//! | `spawn_point` | the respawn point |
//! | `recipe_book` | the recipe book |
//! | `advancements` | the advancements and the statistics (the caller applies them: they need the game's tree and counters) |
//!
//! What the record holds that no part names (the compound's keys Horizon does not
//! model) is taken when every part is.
// use super::{
    // rust: guest::{Guest, SavedBody},
    // rust: hub::Hub,
    // rust: playerdata,
}
// use crate::save::Level;
// use horizon_world::nbt::{Limits, Tag, read_named};
// use serde_json::Value;

/// The parts of a record, in the order the replies list them.
    // rust: pub const PARTS: [&str; 10] = [
    // rust: "inventory",
    // rust: "ender_chest",
    // rust: "experience",
    // rust: "health",
    // rust: "effects",
    // rust: "game_mode",
    // rust: "position",
    // rust: "spawn_point",
    // rust: "recipe_book",
    // rust: "advancements",
    // rust: ];

/// What an import did, for the caller to finish.
pub const Imported = struct {
    /// The parts that were applied, in [`PARTS`] order.
    parts: std.ArrayList(*'static str),
    /// The advancements and the statistics to give the player, when the advancements part was
    /// asked for: they need the game's tree and its counters.
    advancements: ?Value,
    stats: ?Value,
    /// Whether the mods' attachments came (a whole import): the game's own copy of them is then
    /// the record's.
    attachments: bool,
    /// Whether the other players are told the player has arrived (when it is placed).
    announce: bool,
    /// Whether the request asks the player to be let into the world now. The import never places
    /// it itself: the game writes the player's file first and places it then, as for
    /// `player-confirm`. Until then it stays held, and `player-drop` removes it.
    place: bool,
    /// The record's hand-over.
    handover: u128,
    /// Whether the import moved the player to another chunk than the one its view was built
    /// around. The chunk centre was sent at once, but the chunks around the new place come with
    /// the next ticks: whoever reads the player's world must wait for them.
    recentered: bool,
};

/// What a request of `player-import` asks: the record, the parts (all by default)
/// and whether the world is told (yes by default).
pub const Request = struct {
    record: *'a Value,
    parts: std.ArrayList(*'static str),
    announce: bool,
    place: bool,
    arrival: Arrival,
};

/// Where the player stands when it arrives, when the request says so instead of the record:
/// what a proxy knows of its client, which the frozen source may not have seen yet.
pub const Arrival = struct {
    position: Option<[f64,
    /// Yaw and pitch, in degrees.
    rotation: Option<[f32,
    on_ground: ?bool,
    /// Blocks a tick, as the body keeps it.
    velocity: Option<[f64,
};

    // rust: impl Arrival {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self == Arrival::default()
}
}

/// A position the server will put a player at: finite and inside the world's limit. Nothing
/// is asked of the border, the blocks or the chunks, as a vanilla server asks nothing of the
/// place a player's file names.
/// The same bounds as the record's own position ([`check_values`]).
pub fn check_position(p: [f64; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if p.iter().all(|c| c.is_finite())
    // rust: && p[0].abs() <= MAX_XZ
    // rust: && p[2].abs() <= MAX_XZ
    // rust: && p[1].abs() <= MAX_Y
    // rust: {
    // rust: Ok(p)
    // rust: } else {
    // rust: Err(format!(
    // rust: "{p:?} is not a position: x and z must be numbers within {MAX_XZ}, y within {MAX_Y}"
    // rust: ))
}
}

/// For the tests of the hub: whether a position is one the server will take.
pub fn check_position_for_tests(p: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: check_position(p).is_ok()
}

/// `N` numbers out of a JSON list.
    // rust: fn numbers<const N: usize>(value: &Value, what: &str) -> Result<[f64; N], String> {
    // rust: let list = value
    // rust: .as_array()
    // rust: .filter(|l| l.len() == N)
    // rust: .ok_or_else(|| format!("{what} is a list of {N} numbers"))?;
    // rust: let mut out = [0.0; N];
    // rust: for (slot, v) in out.iter_mut().zip(list) {
    // rust: *slot = v
    // rust: .as_f64()
    // rust: .filter(|n| n.is_finite())
    // rust: .ok_or_else(|| format!("{what} holds only finite numbers"))?;
}
    // rust: Ok(out)
}

pub fn read_arrival(request: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let given = |key: &str| request.get(key).filter(|v| !v.is_null());
    // rust: let position = match given("position") {
    // rust: Some(v) => Some(check_position(numbers::<3>(v, "position")?)?),
    // rust: None => None,
}
    // rust: let rotation = match given("rotation") {
    // rust: Some(v) => {
    // rust: let [yaw, pitch] = numbers::<2>(v, "rotation")?;
            // Entity.setXRot: the pitch is taken modulo a turn (`frem`, the sign of the
            // dividend, as Rust's `%`), then cut to a quarter turn each way; setYRot keeps the
            // yaw as it is.
    // rust: let (yaw, pitch) = (yaw as f32, pitch as f32);
            // Finite as an f64 is not enough: past f32::MAX the cast gives an infinity (and
            // the pitch's modulo a NaN), which Entity.load would refuse.
    // rust: if !yaw.is_finite() || !pitch.is_finite() {
    // rust: return Err("rotation holds only numbers a float can hold".into());
}
    // rust: let pitch = (pitch % 360.0).clamp(-90.0, 90.0);
    // rust: Some([yaw, pitch])
}
    // rust: None => None,
}
    // Entity.load: a component over 10 blocks a tick reads as 0.
    // rust: let velocity = match given("velocity") {
    // rust: Some(v) => Some(numbers::<3>(v, "velocity")?.map(|c| if c.abs() > 10.0 { 0.0 } else { c })),
    // rust: None => None,
}
    // rust: let on_ground = match given("on_ground") {
    // rust: None => None,
    // rust: Some(Value::Bool(b)) => Some(*b),
    // rust: Some(_) => return Err("on_ground is true or false".into()),
}
    // rust: Ok(Arrival {
    // rust: position,
    // rust: rotation,
    // rust: on_ground,
    // rust: velocity,
    // rust: })
}

pub fn read_request(request: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let record = request
    // rust: .get("record")
    // rust: .filter(|r| r.is_object())
    // rust: .ok_or("the request needs a record")?;
    // rust: let parts = match request.get("parts") {
    // rust: None | Some(Value::Null) => PARTS.to_vec(),
    // rust: Some(Value::Array(names)) => {
    // rust: let mut parts = Vec::new();
    // rust: for name in names {
    // rust: let name = name.as_str().ok_or("a part is a name")?;
    // rust: let part = PARTS
    // rust: .iter()
    // rust: .find(|p| **p == name)
    // rust: .ok_or_else(|| format!("{name:?} is not a part of a record"))?;
    // rust: if !parts.contains(part) {
    // rust: parts.push(*part);
}
}
            // Always in the order of PARTS, whatever order they were asked in.
    // rust: PARTS.into_iter().filter(|p| parts.contains(p)).collect()
}
    // rust: Some(_) => return Err("parts is a list of names".into()),
}
    // rust: let announce = match request.get("announce") {
    // rust: None | Some(Value::Null) => true,
    // rust: Some(Value::Bool(b)) => *b,
    // rust: Some(_) => return Err("announce is true or false".into()),
}
    // rust: let place = match request.get("place") {
    // rust: None | Some(Value::Null) => true,
    // rust: Some(Value::Bool(b)) => *b,
    // rust: Some(_) => return Err("place is true or false".into()),
}
    // rust: let arrival = read_arrival(request)?;
    // rust: if !arrival.is_empty() && !parts.contains(&"position") {
    // rust: return Err(
    // rust: "position, rotation, on_ground and velocity belong to the position part, which is not imported"
    // rust: .into(),
    // rust: );
}
    // rust: Ok(Request {
    // rust: record,
    // rust: parts,
    // rust: announce,
    // rust: place,
    // rust: arrival,
    // rust: })
}

/// Reads the player compound and the hand-over id out of a record, after checking the record
/// is one this server can take for `uuid`.
pub fn read_compound(record: *Value, uuid: u128) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match record.get("version").and_then(Value::as_i64) {
    // rust: Some(super::arrivals::RECORD_VERSION) => {}
    // rust: Some(other) => return Err(format!("record version {other} is not understood")),
    // rust: None => return Err("the record has no version".into()),
}
    // rust: let theirs = record.get("data_version").and_then(Value::as_i64);
    // rust: if theirs != Some(i64::from(horizon_world::DATA_VERSION)) {
    // rust: return Err(format!(
    // rust: "the record is of data version {theirs:?}, this server's is {}",
    // rust: horizon_world::DATA_VERSION
    // rust: ));
}
    // rust: let named = record.get("uuid").and_then(Value::as_str);
    // rust: if named.and_then(super::arrivals::parse_uuid) != Some(uuid) {
    // rust: return Err("the record is another player's".into());
}
    // rust: let Some(handover) = record
    // rust: .get("handover")
    // rust: .and_then(Value::as_str)
    // rust: .and_then(super::arrivals::parse_handover)
    // rust: else {
    // rust: return Err("the record has no hand-over id: export it with freeze".into());
}
    // rust: let text = record
    // rust: .get("player")
    // rust: .and_then(Value::as_str)
    // rust: .ok_or("the record has no player compound")?;
    // rust: let bytes = crate::skins::base64_decode(text).ok_or("the player compound is not base64")?;
    // rust: let (named, _) = read_named(&bytes, Limits::saved())
    // rust: .map_err(|e| format!("the player compound is not NBT: {e}"))?;
    // rust: match named.tag {
    // rust: tag @ Tag::Compound(_) => Ok((tag, handover)),
    // rust: _ => Err("the player compound is not a compound".into()),
}
}

/// The farthest a position may be from the origin on x and z, and on y: what vanilla's
/// `Entity.load` clamps a saved position to (`Mth.clamp(x, -3.0000512E7, 3.0000512E7)`, y
/// to +-2.0E7).
pub const MAX_XZ: f64 = 3.000_051_2e7;
pub const MAX_Y: f64 = 2.0e7;

/// Refuses a compound whose values no player can have. `Entity.load` throws on a position or
/// rotation that is not finite; a record comes from another machine, so it is checked rather
/// than clamped, and a health of zero or less (a dead player) is refused too.
pub fn check_values(level: *Level) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let finite = |what: &str, values: &[f64]| {
    // rust: if values.iter().all(|v| v.is_finite()) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("the record's {what} is not a number"))
}
}
    // rust: if let Some(p) = level.position {
    // rust: finite("position", &p)?;
    // rust: if p[0].abs() > MAX_XZ || p[2].abs() > MAX_XZ || p[1].abs() > MAX_Y {
    // rust: return Err("the record's position is out of the world".into());
}
}
    // rust: finite(
    // rust: "rotation",
    // rust: &[f64::from(level.rotation[0]), f64::from(level.rotation[1])],
    // rust: )?;
    // rust: finite("motion", &level.motion)?;
    // rust: finite(
    // rust: "health",
    // rust: &[
    // rust: f64::from(level.health),
    // rust: f64::from(level.absorption),
    // rust: f64::from(level.saturation),
    // rust: f64::from(level.xp_progress),
    // rust: level.fall_distance,
    // rust: ],
    // rust: )?;
    // rust: if level.health <= 0.0 {
    // rust: return Err("the record's player is dead".into());
}
    // The bounds vanilla's own data keeps (26.3's bytecode): `max_health` is at most 1024
    // (`Attributes.MAX_HEALTH`) and absorption at most 2048 (`MAX_ABSORPTION`), an effect's
    // amplifier is 0 to 255 (`MobEffectInstance` clamps it), and food exhaustion is at most 40
    // (`FoodData.addExhaustion`). A stack's count needs nothing here: `item_from_nbt` takes one out of
    // `ItemStack`'s `intRange(1, 99)` as 1.
    // rust: if level.health > 1024.0 || !(0.0..=2048.0).contains(&level.absorption) {
    // rust: return Err("the record's health is past what a player can have".into());
}
    // rust: if !(0.0..=40.0).contains(&level.food_exhaustion) {
    // rust: return Err("the record's food exhaustion is past what a player can have".into());
}
    // rust: if level
    // rust: .active_effects
    // rust: .iter()
    // rust: .any(|(_, _, amplifier, _, _)| !(0..=255).contains(amplifier))
    // rust: {
    // rust: return Err("the record holds an effect no player can have".into());
}
    // rust: Ok(())
}

/// What the held player has now, for the parts that are not imported.
pub const Kept = struct {
    inventory: Option<(,
    // rust: Vec<Option<crate::items::ItemStack>>,
    // rust: [Option<crate::items::ItemStack>; 4],
    // rust: Option<crate::items::ItemStack>,
    // rust: usize,
    // rust: )>,
    ender: ?std.ArrayList(Option<crate::items::ItemStack)>,
    experience: Option<(i32,
    health: Option<(f32,
    effects: ?crate::effects::PlayerEffects,
    game_mode: Option<(i32,
    position: Option<([f64,
    spawn: Option<(Option<[f64,
    recipes: ?crate::recipe_book::Settings,
    /// The body's values: its fall goes with the position, its air and fire with the
    /// health.
    body: ?SavedBody,
    other: Option<(,
    // rust: Option<Tag>,
    // rust: Option<(String, [i32; 3])>,
    // rust: bool,
    // rust: Vec<String>,
    horizon_world: :attachments::Attachments,
    // rust: )>,
    dimension: []const u8,
};

    // rust: impl Kept {
pub fn of(g: *Guest, parts: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let has = |p: &str| parts.contains(&p);
    // rust: let all = parts.len() == PARTS.len();
    // rust: Kept {
    // rust: inventory: (!has("inventory")).then(|| {
    // rust: (
    // rust: g.inventory.clone(),
    // rust: g.armor.clone(),
    // rust: g.offhand.clone(),
    // rust: g.selected,
    // rust: )
    // rust: }),
    // rust: ender: (!has("ender_chest")).then(|| g.ender_items.clone()),
    // rust: experience: (!has("experience")).then_some((
    // rust: g.xp_level,
    // rust: g.xp_progress,
    // rust: g.xp_total,
    // rust: g.xp_seed,
    // rust: )),
    // rust: health: (!has("health")).then_some((
    // rust: g.health,
    // rust: g.saved_absorption,
    // rust: g.food,
    // rust: g.saturation,
    // rust: )),
    // rust: effects: (!has("effects")).then(|| g.effects.clone()),
    // rust: game_mode: (!has("game_mode")).then_some((g.game_mode, g.flying, g.flying_speed)),
    // rust: position: (!has("position")).then_some((
    // rust: g.position,
    // rust: g.previous_position,
    // rust: g.yaw,
    // rust: g.pitch,
    // rust: g.head_yaw,
    // rust: g.on_ground,
    // rust: g.saved_vehicle,
    // rust: )),
    // rust: spawn: (!has("spawn_point")).then(|| (g.spawn, g.respawn_elsewhere.clone())),
    // rust: recipes: (!has("recipe_book")).then(|| g.recipe_book.clone()),
    // rust: body: g.loaded_body,
    // rust: other: (!all).then(|| {
    // rust: (
    // rust: g.saved.clone(),
    // rust: g.last_death.clone(),
    // rust: g.seen_credits,
    // rust: g.post_effects.clone(),
    // rust: g.attachments.clone(),
    // rust: )
    // rust: }),
    // rust: dimension: g.dimension.clone(),
}
}

    /// Puts back what the import must not have changed.
pub fn restore(self: *Self, g: *mut Guest, parts: *[[]const u8]) void {
}
    // rust: let has = |p: &str| parts.contains(&p);
    // rust: if let Some((inventory, armor, offhand, selected)) = self.inventory {
    // rust: (g.inventory, g.armor, g.offhand, g.selected) = (inventory, armor, offhand, selected);
}
    // rust: if let Some(ender) = self.ender {
    // rust: g.ender_items = ender;
}
    // rust: if let Some((level, progress, total, seed)) = self.experience {
    // rust: (g.xp_level, g.xp_progress, g.xp_total, g.xp_seed) = (level, progress, total, seed);
}
    // rust: if let Some((health, absorption, food, saturation)) = self.health {
    // rust: (g.health, g.saved_absorption, g.food, g.saturation) =
    // rust: (health, absorption, food, saturation);
}
    // rust: if let Some(effects) = self.effects {
    // rust: g.effects = effects;
}
    // rust: if let Some((mode, flying, speed)) = self.game_mode {
    // rust: (g.game_mode, g.flying, g.flying_speed) = (mode, flying, speed);
}
    // rust: if let Some((position, previous, yaw, pitch, head, ground, vehicle)) = self.position {
    // rust: (g.position, g.previous_position) = (position, previous);
    // rust: (g.yaw, g.pitch, g.head_yaw, g.on_ground) = (yaw, pitch, head, ground);
            // The vehicle the player rode goes with where it stands.
    // rust: g.saved_vehicle = vehicle;
}
    // rust: if let Some((spawn, elsewhere)) = self.spawn {
    // rust: (g.spawn, g.respawn_elsewhere) = (spawn, elsewhere);
}
    // rust: if let Some(recipes) = self.recipes {
    // rust: g.recipe_book = recipes;
}
        // The body mixes the two: its fall and motion go with the position, its air, fire,
        // freezing and food exhaustion and timer with the health. What a part does not take
        // is put back value by value.
    // rust: match (self.body, g.loaded_body.as_mut()) {
    // rust: (Some(mine), Some(imported)) => {
    // rust: if !has("position") {
    // rust: imported.fall_distance = mine.fall_distance;
    // rust: imported.velocity = mine.velocity;
}
    // rust: if !has("health") {
    // rust: imported.fire_ticks = mine.fire_ticks;
    // rust: imported.air = mine.air;
    // rust: imported.ticks_frozen = mine.ticks_frozen;
    // rust: imported.food_exhaustion = mine.food_exhaustion;
    // rust: imported.food_tick_timer = mine.food_tick_timer;
}
}
    // rust: (Some(mine), None) => g.loaded_body = Some(mine),
    // rust: (None, _) => {}
}
    // rust: if let Some((saved, death, credits, post, attachments)) = self.other {
    // rust: (
    // rust: g.saved,
    // rust: g.last_death,
    // rust: g.seen_credits,
    // rust: g.post_effects,
    // rust: g.attachments,
    // rust: ) = (saved, death, credits, post, attachments);
}
        // The client is in one dimension, and only a login can change it.
    // rust: g.dimension = self.dimension;
}
}

/// Applies the request to the held player `uuid` and tells its client, leaving it held
/// (`Hub::confirm_arrival` places it). The caller gives the player its advancements and
/// statistics (`Imported::advancements`, `Imported::stats`) and its attachments.
///
/// Nothing changes when it refuses: the record is read and checked first, and the
/// guest is touched only once everything is known to be well.
pub fn import_player(hub: *mut Hub, uuid: u128, request: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let request = read_request(request)?;
    // rust: let (tag, handover) = read_compound(request.record, uuid)?;
    // rust: let Some(i) = hub
    // rust: .guests
    // rust: .iter()
    // rust: .position(|g| g.uuid == uuid && g.held && !g.placed)
    // rust: else {
    // rust: return Err("no player with that unique id is held".into());
}
    // rust: if !hub.guests[i].left_reason.is_empty() {
    // rust: return Err("that player is leaving".into());
}
    // rust: if hub.guests[i]
    // rust: .arrival_handover
    // rust: .is_some_and(|theirs| theirs != handover)
    // rust: {
    // rust: return Err("that player's record of another hand-over was imported".into());
}
    // rust: let mut level = Level::default();
    // rust: level.read_player(&tag);
    // rust: check_values(&level)?;
    // A record with a vehicle still to restore (`RootVehicle`) puts the player back on it, at
    // the vehicle's own saved place: a position named by the request would be undone as soon
    // as the vehicle is restored, so the two cannot be taken together.
    // rust: if request.arrival.position.is_some()
    // rust: && (level.root_vehicle.is_some() || tag.get("RootVehicle").is_some())
    // rust: {
    // rust: return Err(
    // rust: "the record has a vehicle to restore (RootVehicle): a position cannot be named with it"
    // rust: .into(),
    // rust: );
}
    // What `playerdata::load` gives `apply` too: the whole compound, for the keys Horizon
    // does not model, the mods' attachments and the body's values.
    // rust: level.player_extra = Some(tag);
    // A position in another dimension than the client's cannot be taken: the client
    // would have to change its world, and only a login does that.
    // rust: if request.parts.contains(&"position") {
    // rust: let theirs = playerdata_dimension(&level);
    // rust: if theirs != hub.guests[i].dimension {
    // rust: return Err(format!(
    // rust: "the record is in {theirs}, the held player in {}: the position cannot be taken",
    // rust: hub.guests[i].dimension
    // rust: ));
}
}
    // rust: let kept = Kept::of(&hub.guests[i], &request.parts);
    // `apply` fills the slots a record holds and leaves the others as they are, which is right
    // for a player loaded into an empty guest and wrong here: the held player holds what its
    // own file gave it on this server, and an imported inventory REPLACES that, a slot the
    // record leaves empty being empty afterwards.
    // rust: {
    // rust: let g = &mut hub.guests[i];
    // rust: if request.parts.contains(&"inventory") {
    // rust: g.inventory.iter_mut().for_each(|slot| *slot = None);
    // rust: g.armor = Default::default();
    // rust: g.offhand = None;
}
    // rust: if request.parts.contains(&"ender_chest") {
    // rust: g.ender_items.iter_mut().for_each(|slot| *slot = None);
}
}
    // rust: playerdata::apply(&mut hub.guests[i], &level);
    // rust: kept.restore(&mut hub.guests[i], &request.parts);
    // What the request says of where the player stands wins over the record.
    // rust: {
    // rust: let g = &mut hub.guests[i];
    // rust: let a = &request.arrival;
    // rust: if let Some(p) = a.position {
    // rust: g.position = p;
    // rust: g.previous_position = p;
}
    // rust: if let Some([yaw, pitch]) = a.rotation {
    // rust: g.yaw = yaw;
    // rust: g.pitch = pitch;
    // rust: g.head_yaw = yaw;
}
    // rust: if let Some(ground) = a.on_ground {
    // rust: g.on_ground = ground;
}
    // rust: if let Some(velocity) = a.velocity
    // rust: && let Some(body) = g.loaded_body.as_mut()
    // rust: {
    // rust: body.velocity = velocity;
}
}
    // Everything the import changed reaches the client now, so that a proxy sees the
    // player as it will be; the player stays held until it is placed or dropped.
    // rust: let recentered = hub.send_arrival_state(i);
    // rust: let g = &mut hub.guests[i];
    // A retry of this hand-over's import finds the view already moved: it still answers that
    // the chunks around the new place are on their way, as the first reply did.
    // rust: let recentered = recentered || (g.arrival_handover == Some(handover) && g.arrival_recentered);
    // rust: g.arrival_recentered = recentered;
    // rust: g.imported = true;
    // rust: g.arrival_announce = request.announce;
    // rust: g.arrival_handover = Some(handover);
    // rust: let records = |key: &str| {
    // rust: request
    // rust: .parts
    // rust: .contains(&"advancements")
    // rust: .then(|| request.record.get(key).cloned())
    // rust: .flatten()
    // rust: .filter(|a| !a.is_null())
}
    // rust: Ok(Imported {
    // rust: advancements: records("advancements"),
    // rust: stats: records("stats"),
    // rust: attachments: request.parts.len() == PARTS.len(),
    // rust: parts: request.parts,
    // rust: announce: request.announce,
    // rust: place: request.place,
    // rust: handover,
    // rust: recentered,
    // rust: })
}

/// The dimension a record names, the way `playerdata::apply` places it.
pub fn playerdata_dimension(level: *Level) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match level.dimension.as_str() {
    // rust: d @ ("minecraft:the_nether" | "minecraft:the_end") => d.to_owned(),
    // rust: _ => "minecraft:overworld".to_owned(),
}
}
