//! Transpiled from Horizon Rust crate
//! Module: horizon-client_late_pair_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use horizon_protocol::buf::Reader;

pub fn trident() E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: EntityState {
    // rust: id: 37,
    // rust: uuid: 37,
    // rust: kind: "minecraft:trident".into(),
    // rust: position: [0.5, 65.5, 0.5],
    // rust: velocity: [0.25, 0.0, 0.0],
    // rust: ..EntityState::default()
}
}

pub fn decode(bytes: []const u8) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(bytes);
    // rust: let id = r.varint().unwrap();
    // rust: play::Clientbound::decode(id, r.rest()).unwrap()
}

pub fn late_pairing_does_not_duplicate_or_spend_the_next_arrow_update() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut tracker = Tracker::default();
    // rust: let mut out = Vec::new();
    // rust: let chunks = [(0, 0)].into_iter().collect();
    // rust: let mut viewers = [Viewer {
    // rust: entity_id: 1,
    // rust: spectator: false,
    // rust: permission: 0,
    // rust: moved: false,
    // rust: position: [0.5, 64.0, 0.5],
    // rust: view_distance: 10,
    // rust: chunks: &chunks,
    // rust: tracker: &mut tracker,
    // rust: out: &mut out,
    // rust: gone: None,
    // rust: }];
    // rust: let riding = Riding::default();
    // rust: level.tick(&[], &riding, &mut viewers, |_| Some(0));
    // rust: assert_eq!(level.tick, 1);
    // rust: let mut e = trident();
    // rust: level.pair_after_tick(std::slice::from_ref(&e), &riding, &mut viewers, |_| Some(0));
    // rust: assert_eq!(level.tick, 1);
    // rust: assert_eq!(level.states[&37].tick, 0);
    // rust: assert!(viewers[0].tracker.is_tracking(37));
    // rust: assert_eq!(
    // rust: viewers[0]
    // rust: .out
    // rust: .iter()
    // rust: .filter(|b| matches!(decode(b), play::Clientbound::AddEntity(_)))
    // rust: .count(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(viewers[0].tracker.take_events().len(), 1);
    // rust: viewers[0].out.clear();
    // rust: level.pair_after_tick(std::slice::from_ref(&e), &riding, &mut viewers, |_| Some(0));
    // rust: assert!(viewers[0].out.is_empty());
    // rust: assert!(viewers[0].tracker.take_events().is_empty());
    // rust: assert_eq!(level.states[&37].tick, 0);
    // It hits a block between its introduction and the next tracking pass.
    // rust: e.position[0] += 0.25;
    // rust: e.velocity = [0.0; 3];
    // rust: e.meta.push((10, serializer::BOOLEAN, Value::Bool(true)));
    // rust: level.tick(&[&e], &riding, &mut viewers, |_| Some(0));
    // rust: assert_eq!(level.tick, 2);
    // rust: assert_eq!(level.states[&37].tick, 1);
    // rust: assert!(
    // rust: !viewers[0]
    // rust: .out
    // rust: .iter()
    // rust: .any(|b| matches!(decode(b), play::Clientbound::AddEntity(_)))
    // rust: );
    // rust: assert!(
    // rust: viewers[0]
    // rust: .out
    // rust: .iter()
    // rust: .any(|b| matches!(decode(b), play::Clientbound::SetEntityData(p)
    // rust: if p.id == 37 && p.values.contains(&(10, serializer::BOOLEAN, Value::Bool(true)))))
    // rust: );
}

pub fn late_pairing_keeps_chunk_range_and_own_entity_filters() void {
}
    // rust: for (x, held, own, scale, expected) in [
    // rust: (0.5, true, 1, 100, true),
    // rust: (64.5, true, 1, 100, true),
    // rust: (64.5001, true, 1, 100, false),
    // rust: (40.5, true, 1, 50, false),
    // rust: (0.5, false, 1, 100, false),
    // rust: (0.5, true, 37, 100, false),
    // rust: ] {
    // rust: let mut level = Entities {
    // rust: range_percent: Some(scale),
    // rust: ..Default::default()
}
    // rust: let mut tracker = Tracker::default();
    // rust: let mut out = Vec::new();
    // rust: let chunks = if held {
    // rust: [(0, 0)].into_iter().collect()
    // rust: } else {
    // rust: Default::default()
}
    // rust: let mut viewers = [Viewer {
    // rust: entity_id: own,
    // rust: spectator: false,
    // rust: permission: 0,
    // rust: moved: false,
    // rust: position: [x, 64.0, 0.5],
    // rust: view_distance: 10,
    // rust: chunks: &chunks,
    // rust: tracker: &mut tracker,
    // rust: out: &mut out,
    // rust: gone: None,
    // rust: }];
    // rust: level.tick(&[], &Riding::default(), &mut viewers, |_| Some(0));
    // rust: level.pair_after_tick(&[trident()], &Riding::default(), &mut viewers, |_| Some(0));
    // rust: assert_eq!(
    // rust: viewers[0].tracker.is_tracking(37),
    // rust: expected,
    // rust: "x={x} chunk={held} own={own} scale={scale}"
    // rust: );
    // rust: assert_eq!(
    // rust: viewers[0]
    // rust: .out
    // rust: .iter()
    // rust: .any(|b| matches!(decode(b), play::Clientbound::AddEntity(_))),
    // rust: expected
    // rust: );
}
}

pub fn a_vehicle_uses_a_later_passengers_range_in_the_same_late_batch() void {
}
    // rust: let mut boat = trident();
    // rust: boat.kind = "minecraft:oak_boat".into();
    // rust: let ghast = EntityState {
    // rust: id: 38,
    // rust: uuid: 38,
    // rust: kind: "minecraft:ghast".into(),
    // rust: ..boat.clone()
}
    // rust: for entities in [[boat.clone(), ghast.clone()], [ghast.clone(), boat.clone()]] {
    // rust: let mut level = Entities::default();
    // rust: let mut tracker = Tracker::default();
    // rust: let mut out = Vec::new();
    // rust: let chunks = [(0, 0)].into_iter().collect();
    // rust: let mut viewers = [Viewer {
    // rust: entity_id: 1,
    // rust: spectator: false,
    // rust: permission: 0,
    // rust: moved: false,
    // rust: position: [144.5, 64.0, 0.5],
    // rust: view_distance: 10,
    // rust: chunks: &chunks,
    // rust: tracker: &mut tracker,
    // rust: out: &mut out,
    // rust: gone: None,
    // rust: }];
    // rust: let mut riding = Riding::default();
    // rust: riding.add(37, 38);
    // rust: level.tick(&[], &riding, &mut viewers, |_| Some(0));
    // rust: level.pair_after_tick(&entities, &riding, &mut viewers, |_| Some(0));
        // Outside the boat's 128 blocks, inside its ghast passenger's 160.
    // rust: assert!(viewers[0].tracker.is_tracking(37));
    // rust: assert!(viewers[0].tracker.is_tracking(38));
}
}
