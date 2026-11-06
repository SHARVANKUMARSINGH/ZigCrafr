//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sound_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sound delivery, seed order and emitter lifetime through the real hub.
// use super::*;
// use horizon_core::random::RandomSource;

pub fn next_sent_packet(rx: *std::sync::mpsc::Receiver<crate::lan::Out>) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let crate::lan::Out::Packet(bytes) = rx.try_recv().expect("a sound packet") else {
    // rust: panic!("expected a packet");
}
    // rust: let mut reader = horizon_protocol::buf::Reader::new(&bytes);
    // rust: let id = reader.varint().unwrap();
    // rust: C::decode(id, reader.rest()).unwrap()
}

pub fn a_trident_joining_after_tracking_is_paired_before_its_throw_sound() void {
}
    // rust: let mut sync = SyncData::empty();
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:entity_type".into(),
    // rust: horizon_protocol::registry::Ids::from_names(vec!["minecraft:trident".into()]),
    // rust: );
    // rust: let (mut hub, rx) = hub_with_sync(sync);
    // rust: hub.sync_attachments = true;
    // rust: hub.guests[0].sent_chunks.insert((0, 0));
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next_entity = 38;
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut world,
    // rust: entities: &[],
    // rust: next_entity: &mut next_entity,
    // rust: spawn: [0.5, 64.0, 0.5],
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: hub.track_entities(&mut ctx);
    // rust: while rx.try_recv().is_ok() {}
    // rust: let trident = EntityState {
    // rust: id: 37,
    // rust: uuid: 37,
    // rust: kind: "minecraft:trident".into(),
    // rust: position: [0.5, 65.5, 0.5],
    // rust: velocity: [0.25, 0.0, 0.0],
    // rust: ..EntityState::default()
}
    // rust: hub.note_joined(std::slice::from_ref(&trident));
    // rust: hub.captured_sound(
    // rust: &crate::audio::CapturedSound {
    // rust: event: "minecraft:item.trident.throw".into(),
    // rust: position: trident.position,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: source: 7,
    // rust: entity: Some(37),
    // rust: except_entity: None,
    // rust: },
    // rust: None,
    // rust: );
    // rust: assert!(
    // rust: matches!(next_sent_packet(&rx), C::AddEntity(p) if p.id == 37),
    // rust: "ChunkMap.addEntity pairs a late spawn before the throw sound"
    // rust: );
    // rust: let mut heard = false;
    // rust: while let Ok(out) = rx.try_recv() {
    // rust: let crate::lan::Out::Packet(bytes) = out else {
    // rust: panic!("unexpected batch")
}
    // rust: let mut reader = horizon_protocol::buf::Reader::new(&bytes);
    // rust: let id = reader.varint().unwrap();
    // rust: if matches!(C::decode(id, reader.rest()).unwrap(), C::SoundEntity(p) if p.id == 37) {
    // rust: heard = true;
}
}
    // rust: assert!(heard);
    // rust: hub.collect_tracking();
    // rust: assert_eq!(hub.native_tracking.len(), 1);
    // rust: assert_eq!(hub.native_tracking[0].events.len(), 1);
    // rust: assert!(hub.native_tracking[0].events[0].start);
    // rust: assert_eq!(hub.native_tracking[0].events[0].entity, 37);
    // rust: assert!(
    // rust: hub.attachment_snapshots
    // rust: .iter()
    // rust: .any(|s| s.player == hub.guests[0].uuid && s.holder == Holder::Entity(37))
    // rust: );
    // rust: hub.native_tracking.clear();
    // rust: hub.attachment_snapshots.clear();
    // rust: hub.note_joined(std::slice::from_ref(&trident));
    // rust: hub.collect_tracking();
    // rust: assert!(hub.native_tracking.is_empty());
    // rust: assert!(hub.attachment_snapshots.is_empty());
    // rust: assert!(rx.try_recv().is_err());
}

pub fn a_captured_sound_reaches_the_client_before_its_emitter_is_removed() void {
}
    // rust: let mut sync = SyncData::empty();
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:entity_type".into(),
    // rust: horizon_protocol::registry::Ids::from_names(vec!["minecraft:mooshroom".into()]),
    // rust: );
    // rust: let (mut hub, rx) = hub_with_sync(sync);
    // rust: hub.guests[0].sent_chunks.insert((0, 0));
    // rust: let mooshroom = EntityState {
    // rust: id: 37,
    // rust: uuid: 37,
    // rust: kind: "minecraft:mooshroom".into(),
    // rust: position: [0.5, 64.0, 0.5],
    // rust: ..EntityState::default()
}
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next_entity = 38;
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut world,
    // rust: entities: std::slice::from_ref(&mooshroom),
    // rust: next_entity: &mut next_entity,
    // rust: spawn: mooshroom.position,
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: hub.track_entities(&mut ctx);
    // rust: assert!(hub.guests[0].tracker.is_tracking(37));
    // rust: while rx.try_recv().is_ok() {}
    // This is the current game's end-of-tick order: tracking sees the
    // discarded mooshroom, then lan_flush_effects drains the level sounds.
    // rust: ctx.entities = &[];
    // rust: let sound = crate::audio::CapturedSound {
    // rust: event: "minecraft:entity.mooshroom.shear".into(),
    // rust: position: mooshroom.position,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: source: 7,
    // rust: entity: Some(37),
    // rust: except_entity: None,
}
    // rust: let mut sounds = vec![sound];
    // rust: hub.prepare_captured_sounds(&mut sounds, ctx.entities);
    // rust: hub.track_entities(&mut ctx);
    // rust: for sound in sounds {
    // rust: hub.captured_sound(&sound, None);
}
    // rust: hub.finish_captured_sounds();
    // rust: let mut order = Vec::new();
    // rust: while let Ok(crate::lan::Out::Packet(bytes)) = rx.try_recv() {
    // rust: let mut reader = horizon_protocol::buf::Reader::new(&bytes);
    // rust: let id = reader.varint().unwrap();
    // rust: match C::decode(id, reader.rest()).unwrap() {
    // rust: C::SoundEntity(p) if p.id == 37 => order.push("sound"),
    // rust: C::RemoveEntities(p) if p.ids.contains(&37) => order.push("remove"),
    // rust: _ => {}
}
}
    // rust: assert_eq!(
    // rust: order,
    // rust: ["sound", "remove"],
    // rust: "the native shear sound precedes discard"
    // rust: );
}

pub fn a_new_pair_does_not_reorder_sounds_or_remove_an_old_emitter_early() void {
}
    // rust: for new_first in [false, true] {
    // rust: for batching in [false, true] {
    // rust: let mut sync = SyncData::empty();
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:entity_type".into(),
    // rust: horizon_protocol::registry::Ids::from_names(vec![
    // rust: "minecraft:mooshroom".into(),
    // rust: "minecraft:happy_ghast".into(),
    // rust: ]),
    // rust: );
    // rust: let (mut hub, rx) = hub_with_sync(sync);
    // rust: hub.guests[0].sent_chunks.insert((0, 0));
    // rust: let old = EntityState {
    // rust: id: 37,
    // rust: uuid: 37,
    // rust: kind: "minecraft:mooshroom".into(),
    // rust: position: [0.5, 64.0, 0.5],
    // rust: ..EntityState::default()
}
    // rust: let other = EntityState {
    // rust: id: 39,
    // rust: uuid: 39,
    // rust: ..old.clone()
}
    // rust: let fresh = EntityState {
    // rust: id: 38,
    // rust: uuid: 38,
    // rust: kind: "minecraft:happy_ghast".into(),
    // rust: ..old.clone()
}
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut next_entity = 40;
    // rust: let previous = [old.clone(), other];
    // rust: let current = [fresh];
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut world,
    // rust: entities: &previous,
    // rust: next_entity: &mut next_entity,
    // rust: spawn: old.position,
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: hub.track_entities(&mut ctx);
    // rust: assert!(hub.guests[0].tracker.is_tracking(37));
    // rust: assert!(hub.guests[0].tracker.is_tracking(39));
    // rust: while rx.try_recv().is_ok() {}
    // rust: *hub.sound_seeds.lock().unwrap() = LegacyRandom::new(0);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let old_sound = crate::audio::CapturedSound {
    // rust: event: "minecraft:entity.mooshroom.shear".into(),
    // rust: position: old.position,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: source: 7,
    // rust: entity: Some(37),
    // rust: except_entity: None,
}
    // rust: let fresh_sound = crate::audio::CapturedSound {
    // rust: event: "minecraft:entity.ghastling.spawn".into(),
    // rust: source: 4,
    // rust: entity: Some(38),
    // rust: ..old_sound.clone()
}
    // rust: let mut sounds = if new_first {
    // rust: vec![fresh_sound, old_sound]
    // rust: } else {
    // rust: vec![old_sound, fresh_sound]
}
    // rust: let holding = batching.then(crate::lan::Holding::start);
    // rust: ctx.entities = &current;
    // rust: hub.prepare_captured_sounds(&mut sounds, ctx.entities);
    // rust: assert_eq!(sounds.len(), if new_first { 2 } else { 1 });
    // rust: hub.track_entities(&mut ctx);
    // rust: for sound in sounds {
    // rust: hub.captured_sound(&sound, None);
}
    // rust: hub.finish_captured_sounds();
    // rust: drop(holding);
    // rust: hub.guests[0].sender.flush();
    // rust: let mut packets = Vec::new();
    // rust: while let Ok(message) = rx.try_recv() {
    // rust: match message {
    // rust: crate::lan::Out::Packet(body) => packets.push(body),
    // rust: crate::lan::Out::Packets(batch) => packets.extend(batch),
    // rust: _ => panic!("unexpected disconnect"),
}
}
    // rust: let mut pair = None;
    // rust: let mut old_remove = None;
    // rust: let mut other_remove = None;
    // rust: let mut heard = Vec::new();
    // rust: for (index, body) in packets.iter().enumerate() {
    // rust: let mut reader = horizon_protocol::buf::Reader::new(body);
    // rust: let id = reader.varint().unwrap();
    // rust: match C::decode(id, reader.rest()).unwrap() {
    // rust: C::AddEntity(p) if p.id == 38 => {
    // rust: assert!(pair.replace(index).is_none(), "one pairing")
}
    // rust: C::SoundEntity(p) => heard.push((p.id, p.seed, index)),
    // rust: C::RemoveEntities(p) => {
    // rust: if p.ids.contains(&37) {
    // rust: assert!(
    // rust: old_remove.replace(index).is_none(),
    // rust: "one removal of the emitter"
    // rust: );
}
    // rust: if p.ids.contains(&39) {
    // rust: assert!(
    // rust: other_remove.replace(index).is_none(),
    // rust: "one unrelated removal"
    // rust: );
}
}
    // rust: _ => {}
}
}
    // rust: assert_eq!(
    // rust: heard.iter().map(|h| h.0).collect::<Vec<_>>(),
    // rust: if new_first {
    // rust: vec![38, 37]
    // rust: } else {
    // rust: vec![37, 38]
}
    // rust: );
    // rust: assert_eq!(
    // rust: heard.iter().map(|h| h.1).collect::<Vec<_>>(),
    // rust: vec![random.next_long(), random.next_long()]
    // rust: );
    // rust: assert_eq!(hub.next_sound_seed(), random.next_long());
    // rust: let old_sound = heard.iter().find(|h| h.0 == 37).unwrap().2;
    // rust: let new_sound = heard.iter().find(|h| h.0 == 38).unwrap().2;
    // rust: assert!(
    // rust: pair.unwrap() < new_sound,
    // rust: "the new emitter must be paired first"
    // rust: );
    // rust: assert!(
    // rust: old_sound < old_remove.unwrap(),
    // rust: "the old emitter must survive its sound"
    // rust: );
    // rust: assert!(
    // rust: other_remove.unwrap() < pair.unwrap(),
    // rust: "unrelated removals keep their normal place"
    // rust: );
    // rust: if !new_first {
    // rust: assert!(old_sound < other_remove.unwrap());
}
}
}
}

pub fn direct_removals_split_the_sound_emitters_and_do_not_leak_into_the_next_batch() void {
}
    // rust: for targeted in [false, true] {
    // rust: let (hub, rx) = hub_with_a_guest();
    // rust: let sound = crate::audio::CapturedSound {
    // rust: event: "fixture:bound".into(),
    // rust: position: [0.5, 64.0, 0.5],
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: source: 6,
    // rust: entity: Some(38),
    // rust: except_entity: None,
}
    // rust: let mut sounds = vec![
    // rust: sound.clone(),
    // rust: crate::audio::CapturedSound {
    // rust: entity: Some(37),
    // rust: ..sound
    // rust: },
    // rust: ];
    // rust: let fresh = EntityState {
    // rust: id: 38,
    // rust: ..EntityState::default()
}
    // rust: hub.prepare_captured_sounds(&mut sounds, std::slice::from_ref(&fresh));
    // rust: let removal = C::RemoveEntities(play::RemoveEntities { ids: vec![37, 99] });
    // rust: if targeted {
    // rust: hub.send_to(1, &removal);
    // rust: } else {
    // rust: hub.broadcast(&removal);
}
    // rust: let C::RemoveEntities(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected unrelated removal")
}
    // rust: assert_eq!(packet.ids, vec![99]);
    // rust: assert!(rx.try_recv().is_err(), "the sound emitter is held");
    // rust: for sound in sounds {
    // rust: hub.captured_sound(&sound, None);
}
    // rust: assert!(matches!(next_sent_packet(&rx),C::SoundEntity(p) if p.id==38));
    // rust: assert!(matches!(next_sent_packet(&rx),C::SoundEntity(p) if p.id==37));
    // rust: hub.finish_captured_sounds();
    // rust: let C::RemoveEntities(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected held removal")
}
    // rust: assert_eq!(packet.ids, vec![37]);
    // rust: hub.finish_captured_sounds();
    // rust: assert!(rx.try_recv().is_err(), "the held removal is not sent twice");
    // rust: hub.broadcast(&C::RemoveEntities(play::RemoveEntities { ids: vec![37] }));
    // rust: let C::RemoveEntities(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected immediate removal after the batch")
}
    // rust: assert_eq!(packet.ids, vec![37]);
}
}

pub fn captured_entity_sound_routes_by_player_dimension_range_and_exclusion() void {
}
    // rust: let (mut hub, rx) = hub_with_a_guest();
    // rust: *hub.sound_seeds.lock().unwrap() = LegacyRandom::new(0);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut sound = crate::audio::CapturedSound {
    // rust: event: "fixture:bound".into(),
    // rust: position: [0.0; 3],
    // rust: volume: 1.0,
    // rust: pitch: 1.2,
    // rust: source: 6,
    // rust: entity: Some(37),
    // rust: except_entity: None,
}
    // rust: hub.guests[0].position = [0.0; 3];
    // The server broadcasts by distance even if this player does not track
    // the emitter; the receiving client decides whether it knows that id.
    // rust: hub.captured_sound(&sound, None);
    // rust: let C::SoundEntity(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected entity sound")
}
    // rust: assert_eq!(
    // rust: (packet.id, packet.source, packet.volume, packet.pitch),
    // rust: (37, 6, 1.0, 1.2)
    // rust: );
    // rust: assert_eq!(packet.seed, random.next_long());
    // rust: assert_eq!(packet.sound, (-1, Some(("fixture:bound".into(), None))));

    // rust: sound.except_entity = Some(hub.guests[0].entity_id as u32);
    // rust: hub.captured_sound(&sound, None);
    // rust: random.next_long();
    // rust: assert!(rx.try_recv().is_err());
    // rust: sound.except_entity = None;
    // rust: hub.captured_sound(&sound, Some(hub.guests[0].conn));
    // rust: random.next_long();
    // rust: assert!(rx.try_recv().is_err());

    // rust: hub.guests[0].position = [16.0, 0.0, 0.0];
    // rust: hub.captured_sound(&sound, None);
    // rust: random.next_long();
    // rust: assert!(rx.try_recv().is_err(), "the radius itself is excluded");
    // rust: hub.guests[0].position = [15.99, 0.0, 0.0];
    // rust: hub.captured_sound(&sound, None);
    // rust: let C::SoundEntity(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected entity sound")
}
    // rust: assert_eq!(
    // rust: packet.seed,
    // rust: random.next_long(),
    // rust: "rejected broadcasts still draw their seeds"
    // rust: );

    // rust: hub.guests[0].dimension = "minecraft:the_nether".into();
    // rust: hub.captured_sound(&sound, None);
    // rust: random.next_long();
    // rust: assert!(rx.try_recv().is_err());
    // rust: hub.guests[0].dimension = "minecraft:overworld".into();
    // rust: hub.guests[0].placed = false;
    // rust: hub.captured_sound(&sound, None);
    // rust: random.next_long();
    // rust: assert!(rx.try_recv().is_err());
    // rust: assert_eq!(hub.next_sound_seed(), random.next_long());
}

pub fn captured_and_direct_sounds_share_the_server_seed_stream_and_synced_registry() void {
}
    // rust: let mut sync = SyncData::empty();
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:sound_event".into(),
    // rust: horizon_protocol::registry::Ids::from_names(vec!["fixture:bound".into()]),
    // rust: );
    // rust: let (hub, rx) = hub_with_sync(sync);
    // rust: *hub.sound_seeds.lock().unwrap() = LegacyRandom::new(0);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let sound = crate::audio::CapturedSound {
    // rust: event: "fixture:bound".into(),
    // rust: position: [0.5, 64.0, 0.5],
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: source: 6,
    // rust: entity: Some(37),
    // rust: except_entity: None,
}
    // rust: hub.sound("fixture:bound", sound.position, 1.0, 1.0, 6, None);
    // rust: let C::Sound(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected positional sound")
}
    // rust: assert_eq!(packet.seed, random.next_long());
    // rust: hub.captured_sound(&sound, None);
    // rust: let C::SoundEntity(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected entity sound")
}
    // rust: assert_eq!(packet.sound, (0, None));
    // rust: assert_eq!(packet.seed, random.next_long());
    // rust: hub.sound("fixture:bound", sound.position, 1.0, 1.0, 6, None);
    // rust: let C::Sound(packet) = next_sent_packet(&rx) else {
    // rust: panic!("expected positional sound")
}
    // rust: assert_eq!(packet.seed, random.next_long());
}
