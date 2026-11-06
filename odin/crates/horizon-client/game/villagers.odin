//! Transpiled from Horizon Rust crate
package horizon_client_villagers

import "core:fmt"
import "core:mem"
import "core:math"

// What villagers do with each other and with the player: gossip and
// reputation, sharing food and wares, picking up dropped items, making
// babies, calling iron golems and the prices they ask.
// use super::Game;
// use horizon_client::{
    // rust: gossip::{self, GossipType},
    // rust: items::ItemStack,
    // rust: mobs::{Mob, Species, spawning, villager, villager_brain},
}
// use horizon_core::geometry::Vec3;

block_of :: proc(p: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}
    // rust: impl Game<'_> {
villager_index :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .position(|m| m.id == id && m.species() == Species::Villager)
}
item_max_stack :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.items().get(item).map_or(64, |i| i.max_stack)
}
    // `WorkAtComposter.useWorkstation`: at a composter the farmer makes
    // bread, then composts seeds.
    // rust: pub(super) fn villager_work_at_composter(&mut self, id: u32, pos: [i32; 3]) {
    // rust: let Some(i) = self.villager_index(id) else {
    // rust: return;
}
    // rust: if self.composter_level(pos).is_none() {
    // rust: return;
}
    // rust: self.villager_make_bread(i);
    // rust: self.villager_compost_items(i, pos);
}
    // `WorkAtComposter.makeBread`: up to three loaves from nine wheat while
    // the villager holds at most 36 bread; what does not fit drops.
villager_make_bread :: proc(self: ^Self, i: uint) {
}
    // rust: let max_stack = self.item_max_stack("minecraft:bread");
    // rust: let e = villager::ext_mut(&mut self.mobs[i]);
    // rust: if e.count_item("minecraft:bread") > 36 {
    // rust: return;
}
    // rust: let loaves = (e.count_item("minecraft:wheat") / 3).min(3);
    // rust: if loaves == 0 {
    // rust: return;
}
    // rust: e.remove_item("minecraft:wheat", loaves * 3);
    // rust: let left = e.add_item(ItemStack::new("minecraft:bread", loaves), max_stack);
    // rust: if let Some(rest) = left {
            // spawnAtLocation(level, stack, 0.5F)
    // rust: let p = self.mobs[i].position;
    // rust: self.spawn_item(rest, [p.x, p.y + 0.5, p.z], [0.0, 0.2, 0.0], 10);
}
}
    // `BehaviorUtils.throwItem`: toss a stack from a villager's hand toward
    // a point.
villager_throw :: proc(self: ^Self, from: Vec3, eye: f64, to: Vec3, stack: ItemStack) {
}
    // rust: let at = [from.x, eye - 0.3, from.z];
    // rust: let d = Vec3::new(to.x - from.x, to.y - from.y, to.z - from.z).normalize();
    // rust: self.spawn_item(stack, at, [d.x * 0.3, d.y * 0.3, d.z * 0.3], 10);
}

    // `TradeWithVillager.tick` for one pair: gossip (at most once in 1200
    // ticks for both), then surplus food and wanted wares tossed over.
    // rust: pub(super) fn villager_meet(&mut self, a: u32, b: u32) {
    // rust: let (Some(ia), Some(ib)) = (self.villager_index(a), self.villager_index(b)) else {
    // rust: return;
}
    // rust: let now = self.world.game_time;
    // rust: let items = world_items!(self);
    // rust: let meeting = villager::meet(&mut self.mobs, ia, ib, now, |item| {
    // rust: items.get(item).map_or(64, |i| i.max_stack)
    // rust: });
    // rust: for stack in meeting.thrown {
    // rust: self.villager_throw(meeting.from, meeting.eye, meeting.to, stack);
}
    // rust: if meeting.gossiped {
    // rust: self.villager_golem_check(a, 5);
}
}

    // `Villager.spawnGolemIfNeeded`: when enough villagers nearby that
    // slept recently and saw no golem agree, an iron golem appears.
    // rust: pub(super) fn villager_golem_check(&mut self, id: u32, needed: usize) {
    // rust: let Some(i) = self.villager_index(id) else {
    // rust: return;
}
    // rust: let now = self.world.game_time;
    // rust: let Some(near) = villager::golem_summoners(&self.mobs, i, now, needed) else {
    // rust: return;
}
    // rust: if self.try_spawn_iron_golem(block_of(self.mobs[i].position)) {
    // rust: for j in near {
    // rust: villager_brain::golem_detected(&mut self.mobs[j], now);
}
}
}
    // `SpawnUtil.trySpawnMob(IRON_GOLEM, ...)`: a golem near `start`, with
    // the ambient sound `trySpawnMob` plays.
try_spawn_iron_golem :: proc(self: ^Self, start: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(kind) = self.res.mob_types().get("minecraft:iron_golem").cloned() else {
    // rust: return false;
}
    // rust: let id = self.next_entity + 1;
    // rust: let mut random = self.world.random.clone();
    // rust: let golem = villager::summon_golem(
    // rust: &self.mob_world_base(&[]),
    // rust: start,
    // rust: &mut random,
    // rust: |random, at, yaw| {
    // rust: let mut m = Mob::new(id, kind.clone(), at, yaw);
    // rust: villager::finalize_summoned_golem(&mut m, random);
    // rust: m
    // rust: },
    // rust: );
    // rust: self.world.random = random;
    // rust: let Some(golem) = golem else {
    // rust: return false;
}
    // rust: self.next_entity = id;
    // rust: let sound = golem.kind.sounds[0];
    // rust: if !sound.is_empty() {
    // rust: let at = golem.center();
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), 1.0, 1.0);
}
    // rust: self.mobs.push(golem);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: true
}

    // `VillagerMakeLove.tryToGiveBirth`: both eat, a free bed within 48
    // blocks is taken for the child, who is a baby villager of one of
    // three villager types.
    // rust: pub(super) fn villager_birth(
    // rust: &mut self,
    // rust: parent: u32,
    // rust: partner: u32,
    // rust: child: Option<([i32; 3], Option<u8>)>,
    // rust: ) {
    // rust: let (Some(ia), Some(ib)) = (self.villager_index(parent), self.villager_index(partner))
    // rust: else {
    // rust: return;
}
    // rust: villager::ext_mut(&mut self.mobs[ib]).eat_and_digest();
    // rust: let from = self.mobs[ia].position;
    // rust: let Some((bed, variant)) = child else {
            // VillagerMakeLove: entity event 13 for the partner, then the parent.
    // rust: for i in [ib, ia] {
    // rust: let id = self.mobs[i].id;
    // rust: self.mob_event_particles(id, 13);
}
    // rust: return;
}
    // rust: let variant = variant.unwrap_or_else(|| {
    // rust: let facts = self.biome_facts(
    // rust: from.x.floor() as i32,
    // rust: from.y.floor() as i32,
    // rust: from.z.floor() as i32,
    // rust: );
    // rust: spawning::villager_type(&facts)
    // rust: });
    // rust: self.mobs[ib].extra.age = 6000;
    // rust: let Some(id) =
    // rust: self.spawn_mob_for("minecraft:villager", [from.x, from.y, from.z], true, true)
    // rust: else {
    // rust: return;
}
    // rust: if let Some(child) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: child.extra.variant = variant;
    // rust: child.extra.variant2 = villager::NONE;
    // rust: child.extra.age = -24000;
    // rust: child.extra.bed = Some(bed);
}
        // VillagerMakeLove.giveBirth: entity event 12 for the child.
    // rust: self.mob_event_particles(id, 12);
}
    // `Level.broadcastEntityEvent` of an event whose `handleEntityEvent`
    // draws particles about the mob (villager 12, 13 and 14, taming 6 and 7,
    // love 18): the guests get the byte, and this game draws it as its own
    // client would.
    // rust: pub(super) fn mob_event_particles(&mut self, id: u32, event: i8) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: self.lan_entity_event(id as i32, event, at);
    // rust: self.entity_event_particles(id, event);
}
    // `handleEntityEvent(event)`'s particles about mob `id`
    // (`Villager`, `TamableAnimal`, `AbstractHorse`, `Animal`, `Allay`).
    // rust: pub(super) fn entity_event_particles(&mut self, id: u32, event: i8) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: if let Some((kind, burst)) =
    // rust: horizon_client::particles::entity_event_burst(&m.kind.id, event as u8)
    // rust: {
    // rust: self.particles_around_mob(id, kind, burst);
}
}
    // `particles::around_self` about mob `id`.
    // rust: pub(super) fn particles_around_mob(
    // rust: &mut self,
    // rust: id: u32,
    // rust: kind: &'static str,
    // rust: burst: horizon_client::particles::Burst,
    // rust: ) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let feet = [m.position.x, m.position.y, m.position.z];
    // rust: let size = [f64::from(m.width()), f64::from(m.height())];
    // rust: self.particles_around(kind, feet, size, burst);
}
    // `particles::around_self` on the client: the particle engine's random
    // stands in for the client entity's, so no server draw moves.
    // rust: pub(super) fn particles_around(
    // rust: &mut self,
    // rust: kind: &'static str,
    // rust: feet: [f64; 3],
    // rust: size: [f64; 2],
    // rust: burst: horizon_client::particles::Burst,
    // rust: ) {
    // rust: let Some(ty) = horizon_client::particles::ParticleType::from_name(kind) else {
    // rust: return;
}
    // rust: let options = horizon_client::particles::ParticleOptions::simple(ty);
    // rust: let mut spawned = Vec::new();
    // rust: horizon_client::particles::around_self(
    // rust: self.particles.random(),
    // rust: feet,
    // rust: size[0],
    // rust: size[1],
    // rust: burst,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}

    // `NearestItemSensor.doTick` for the villagers whose sensor is due: the
    // nearest dropped item within 32 blocks that `Villager.wantsToPickUp`
    // accepts and the villager sees, or none.
    // rust: pub(super) fn villager_item_sense(&mut self) {
    // rust: if self.dropped.is_empty() {
    // rust: for m in &mut self.mobs {
    // rust: if m.species() == Species::Villager
    // rust: && self.creatures.ticked.contains(&m.id)
    // rust: && villager_brain::take_item_scan(m)
    // rust: {
    // rust: villager_brain::set_wanted_item(m, None);
}
}
    // rust: return;
}
    // rust: let picks_up = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:villager_picks_up")
    // rust: .cloned();
    // rust: let mut due = Vec::new();
    // rust: for (i, m) in self.mobs.iter_mut().enumerate() {
    // rust: if m.species() == Species::Villager
    // rust: && self.creatures.ticked.contains(&m.id)
    // rust: && villager_brain::take_item_scan(m)
    // rust: {
    // rust: due.push(i);
}
}
    // rust: if due.is_empty() {
    // rust: return;
}
    // rust: let w = self.mob_world_base(&[]);
    // rust: let mut found = Vec::new();
    // rust: for i in due {
    // rust: let m = &self.mobs[i];
    // rust: let area = m.bounds().inflate(Vec3::new(32.0, 16.0, 32.0));
    // rust: let requested = villager::requested_items(m);
    // rust: let eye = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let mut best: Option<(f64, Vec3)> = None;
    // rust: for e in &self.dropped {
    // rust: let d = e.position.distance_squared(m.position);
    // rust: if best.is_some_and(|(b, _)| d >= b)
    // rust: || !e.bounds().intersects(area)
    // rust: || d >= 32.0 * 32.0
    // rust: {
    // rust: continue;
}
    // rust: let item = &e.stack.item;
    // rust: let wants = villager::food_points(item) > 0
    // rust: || picks_up.as_ref().is_some_and(|t| t.contains(&**item))
    // rust: || requested.contains(&&**item);
    // rust: let fits =
    // rust: villager::ext(m).is_none_or(|x| x.can_add(&e.stack, self.item_max_stack(item)));
                // ItemEntity's eye height is 0.2125.
    // rust: let at = Vec3::new(e.position.x, e.position.y + 0.2125, e.position.z);
    // rust: if wants && fits && w.line_of_sight(eye, at) {
    // rust: best = Some((d, e.position));
}
}
    // rust: found.push((i, best.map(|(_, p)| [p.x, p.y, p.z])));
}
    // rust: for (i, at) in found {
    // rust: villager_brain::set_wanted_item(&mut self.mobs[i], at);
}
}
    // `Mob.aiStep` item pickup for villagers (`InventoryCarrier`): food,
    // seeds and what their profession wants, from within a block.
    // rust: pub(super) fn villager_pickups(&mut self) {
    // rust: if self.dropped.is_empty() || !self.ui.rules.bool("mob_griefing") {
    // rust: return;
}
    // rust: let picks_up = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:villager_picks_up")
    // rust: .cloned();
        // A villager with no item near skips its scan; one near an item scans
        // the items of the cells it meets as before, testing the cheap reach
        // first: a server's villagers and dropped items each run into the
        // hundreds or thousands.
    // rust: let mut near_items = super::item_areas::ItemAreas::default();
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Villager
    // rust: || !m.alive()
    // rust: || !self.creatures.ticked.contains(&m.id)
    // rust: {
    // rust: continue;
}
    // rust: let (pos, half) = (m.position, f64::from(m.width()) / 2.0 + 1.0);
    // rust: let top = f64::from(m.height());
    // rust: let reach = horizon_core::geometry::Aabb::new(
    // rust: Vec3::new(pos.x - half, pos.y - 0.25, pos.z - half),
    // rust: Vec3::new(pos.x + half, pos.y + top, pos.z + half),
    // rust: );
    // rust: let mut scan = near_items.scan(&self.dropped, self.next_entity, reach);
    // rust: if scan.is_empty() {
    // rust: continue;
}
    // rust: let requested = villager::requested_items(m);
    // rust: let mut j = 0;
    // rust: loop {
    // rust: j = scan.next_from(j, self.dropped.len());
    // rust: let Some(e) = self.dropped.get(j) else {
    // rust: break;
}
    // rust: let near = (e.position.x - pos.x).abs() <= half
    // rust: && (e.position.z - pos.z).abs() <= half
    // rust: && e.position.y >= pos.y - 0.25
    // rust: && e.position.y <= pos.y + top;
    // rust: if !near || e.pickup_delay > 0 {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let item = e.stack.item.clone();
    // rust: let wants = villager::food_points(&item) > 0
    // rust: || picks_up.as_ref().is_some_and(|t| t.contains(&*item))
    // rust: || requested.contains(&&*item);
    // rust: if !wants {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let max = self.item_max_stack(&item);
    // rust: let stack = self.dropped[j].stack.clone();
    // rust: if !villager::ext_mut(&mut self.mobs[i]).can_add(&stack, max) {
    // rust: j += 1;
    // rust: continue;
}
    // rust: let before = self.dropped[j].clone();
    // rust: let rest = villager::ext_mut(&mut self.mobs[i]).add_item(stack, max);
    // rust: if rest.as_ref().is_none_or(|r| r.count < before.stack.count) {
    // rust: let id = self.mobs[i].id;
    // rust: self.add_pickup(
    // rust: super::pickups::Taken::Item(Box::new(before)),
    // rust: super::pickups::Collector::Mob(id),
    // rust: );
}
    // rust: match rest {
    // rust: None => {
    // rust: self.remove_dropped(j);
    // rust: scan.removed(j);
}
    // rust: Some(rest) => {
    // rust: self.dropped[j].stack.count = rest.count;
    // rust: j += 1;
}
}
}
}
}

    // The UUID of the player who last hurt a mob (`last_hurt_by_player`:
    // None for the host, else the guest's connection): the reputation a
    // villager keeps is that player's, the one trading looks up.
    // rust: pub(super) fn player_uuid_of(&self, who: Option<u32>) -> Option<[i32; 4]> {
    // rust: let uuid = match who {
    // rust: None => return self.level.player_uuid,
            // While that guest acts its own UUID is swapped in.
    // rust: Some(conn) if self.lan_acting == Some(conn) => self.lan_acting_uuid?,
    // rust: Some(conn) => self.lan.as_ref()?.hub.guest(conn)?.uuid,
}
    // rust: Some(horizon_client::lan::playerdata::uuid_ints(uuid))
}
    // `Villager.setLastHurtByMob` and `ServerLevel.onReputationEvent`: a hit
    // from a player counts against that player with the villager that was hit.
    // rust: pub(super) fn villager_reputation_tick(&mut self) {
    // rust: let mut angry = Vec::new();
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Villager
    // rust: || m.ai.last_hurt_by != Some(horizon_client::mobs::Who::Player)
    // rust: {
    // rust: continue;
}
    // rust: let time = m.ai.last_hurt_by_time;
    // rust: let alive = m.alive();
    // rust: let at = m.id;
    // rust: if villager::ext(m).is_some_and(|e| e.hurt_seen == time) {
    // rust: continue;
}
    // rust: let hurt_by = self.last_hurt_by_player.get(&at).copied().flatten();
    // rust: let Some(uuid) = self.player_uuid_of(hurt_by) else {
    // rust: continue;
}
    // rust: let e = villager::ext_mut(&mut self.mobs[i]);
    // rust: e.hurt_seen = time;
    // rust: e.gossips.add(
    // rust: uuid,
    // rust: GossipType::MinorNegative,
    // rust: gossip::REPUTATION_CHANGE_PER_EVENT,
    // rust: );
    // rust: if alive {
    // rust: angry.push(at);
}
}
        // Villager.setLastHurtByMob: entity event 13.
    // rust: for id in angry {
    // rust: self.mob_event_particles(id, 13);
}
}
    // `Villager.tellWitnessesThatIWasMurdered`: the villagers that saw a
    // player kill one remember it as a major wrong.
    // `killer` is the guest connection that last hurt it (None: the host).
    // rust: pub(super) fn villager_murdered(&mut self, victim: &Mob, by_player: bool, killer: Option<u32>) {
    // rust: if victim.species() != Species::Villager || !by_player {
    // rust: return;
}
    // rust: let Some(uuid) = self.player_uuid_of(killer) else {
    // rust: return;
}
    // rust: let eye = Vec3::new(victim.position.x, victim.eye_y(), victim.position.z);
    // rust: let witnesses: Vec<usize> = {
    // rust: let w = self.mob_world_base(&[]);
    // rust: self.mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| {
    // rust: m.id != victim.id
    // rust: && m.species() == Species::Villager
    // rust: && m.alive()
    // rust: && (m.position.x - victim.position.x).abs() <= 16.0
    // rust: && (m.position.y - victim.position.y).abs() <= 16.0
    // rust: && (m.position.z - victim.position.z).abs() <= 16.0
    // rust: && w.line_of_sight(eye, Vec3::new(m.position.x, m.eye_y(), m.position.z))
    // rust: })
    // rust: .map(|(i, _)| i)
    // rust: .collect()
}
    // rust: for i in witnesses {
    // rust: villager::ext_mut(&mut self.mobs[i]).gossips.add(
    // rust: uuid,
    // rust: GossipType::MajorNegative,
    // rust: gossip::REPUTATION_CHANGE_PER_EVENT,
    // rust: );
}
}
    // `ReputationEventType.TRADE`: each trade earns a little trust.
    // rust: pub(super) fn villager_traded(&mut self, id: u32) {
    // rust: if let Some(uuid) = self.level.player_uuid {
    // rust: self.villager_traded_by(id, uuid);
}
}
    // The TRADE reputation event from the player `uuid` (a guest's too).
    // rust: pub(super) fn villager_traded_by(&mut self, id: u32, uuid: [i32; 4]) {
    // rust: let Some(i) = self.villager_index(id) else {
    // rust: return;
}
    // rust: villager::ext_mut(&mut self.mobs[i]).gossips.add(
    // rust: uuid,
    // rust: GossipType::Trading,
    // rust: gossip::REPUTATION_CHANGE_PER_TRADE,
    // rust: );
        // Villager.customServerAiStep after a trade: entity event 14.
    // rust: self.mob_event_particles(id, 14);
}
    // `Villager.getPlayerReputation` of the local player.
    // rust: pub(super) fn villager_reputation(&self, id: u32) -> i32 {
    // rust: let Some(uuid) = self.level.player_uuid else {
    // rust: return 0;
}
    // rust: self.villager_reputation_of(id, uuid)
}
    // `Villager.getPlayerReputation` of the player `uuid`.
    // rust: pub(super) fn villager_reputation_of(&self, id: u32, uuid: [i32; 4]) -> i32 {
    // rust: self.villager_index(id)
    // rust: .and_then(|i| villager::ext(&self.mobs[i]))
    // rust: .map_or(0, |e| e.gossips.reputation(uuid))
}
    // The Hero of the Village amplifier of the player, if any.
    // rust: pub(super) fn hero_amplifier(&self) -> Option<i32> {
    // rust: self.potions.effects.amplifier("hero_of_the_village")
}
    // `AbstractBedBlock.kickVillagerOutOfBed`: the first sleeping villager
    // whose box touches the bed's head block wakes up
    // (`Villager.stopSleeping`). Whether one did.
    // rust: pub(super) fn kick_villager_out_of_bed(&mut self, head: [i32; 3]) -> bool {
    // rust: let min = Vec3::new(f64::from(head[0]), f64::from(head[1]), f64::from(head[2]));
    // rust: let max = Vec3::new(min.x + 1.0, min.y + 1.0, min.z + 1.0);
    // rust: let Some(i) = self.mobs.iter().position(|m| {
    // rust: m.species() == Species::Villager
    // rust: && villager::sleeping(m)
    // rust: && m.bounds().intersects_corners(min, max)
    // rust: }) else {
    // rust: return false;
}
    // rust: let id = self.mobs[i].id;
    // rust: self.wake_villager(id);
    // rust: true
}
    // `LivingEntity.stopSleeping` for the villager `id`, outside its own
    // tick: it stands up and its bed is no longer occupied.
    // rust: pub(super) fn wake_villager(&mut self, id: u32) {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: return;
}
    // rust: let mut mobs = std::mem::take(&mut self.mobs);
    // rust: let mut events = Vec::new();
    // rust: villager::stop_sleeping(&mut mobs[i], &self.mob_world_base(&[]), &mut events);
    // rust: villager_brain::woken(&mut mobs[i], self.world.game_time);
    // rust: self.mobs = mobs;
    // rust: if let Err(e) = self.handle_mob_events(events) {
    // rust: log::warn!("waking villager {id}: {e}");
}
}
}

    // rust: mod entity_event_particle_tests {
    // The raid sweat (42) and the dolphin's treasure hearts (38) are in the
    // table that now decides which entity events draw particles.
the_table_draws_the_raid_sweat_and_the_dolphin_event :: proc() {
}
    // rust: let kind = |entity, event| {
    // rust: horizon_client::particles::entity_event_burst(entity, event).map(|(k, _)| k)
}
    // rust: assert_eq!(kind("villager", 42), Some("splash"));
    // rust: assert_eq!(kind("dolphin", 38), Some("happy_villager"));
    // rust: assert_eq!(kind("villager", 2), None);
}
}
