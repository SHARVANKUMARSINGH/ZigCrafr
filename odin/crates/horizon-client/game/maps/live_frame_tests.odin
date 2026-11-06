//! Transpiled from Horizon Rust crate
package horizon_client_live_frame_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::game::{Audio, Game, Options, Progress, Settings, commands::Target, load_resources};

live_frame_item_adoption_detaches_only_a_changed_old_stack :: proc() {
}
    // rust: frame_adoption(false);
}

live_glow_frame_adoption_keeps_type_without_saved_id :: proc() {
}
    // rust: frame_adoption(true);
}

frame_adoption :: proc(glow_first: bool) {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: game.player = Some(
    // rust: horizon_client::motion::PlayerMotion::new(
    // rust: game.motion,
    // rust: horizon_core::geometry::Vec3::new(4.5, 100.0, 4.5),
    // rust: )
    // rust: .unwrap(),
    // rust: );
    // rust: game.creative = false;
    // rust: let empty = ItemStack::new("minecraft:map", 1);
    // rust: *game.held_mut() = Some(empty.clone());
    // rust: assert!(game.use_empty_map(&empty));
    // rust: let stack = game.held().unwrap().clone();
    // rust: assert_eq!(map_id(&stack), Some(0));
    // rust: for (n, kind) in [
    // rust: (1, "minecraft:item_frame"),
    // rust: (2, "minecraft:glow_item_frame"),
    // rust: ] {
    // rust: let tag = Tag::compound([
    // rust: ("id", Tag::String(kind.into())),
    // rust: ("UUID", Tag::IntArray(vec![317, 1, 0, n])),
    // rust: ("block_pos", Tag::IntArray(vec![10 + n, 101, 5])),
    // rust: ("Facing", Tag::Byte(5)),
    // rust: ("ItemRotation", Tag::Byte(3)),
    // rust: ("Item", horizon_client::save::item_to_nbt(&stack)),
    // rust: ]);
    // rust: game.load_item_frame(tag, Some([317, 1, 0, n]));
}
    // rust: let mut ids: Vec<_> = game.item_frames.iter().map(|f| f.id).collect();
    // rust: if glow_first {
    // rust: ids.reverse();
}
    // rust: for &id in &ids {
    // rust: let frame = game
    // rust: .item_frames
    // rust: .iter()
    // rust: .find(|f| f.id == id)
    // rust: .unwrap()
    // rust: .clone();
    // rust: game.map(0).unwrap().tick_framed(
    // rust: 1,
    // rust: 0,
    // rust: false,
    // rust: false,
    // rust: Framed {
    // rust: pos: frame.pos,
    // rust: facing: frame.facing,
    // rust: id: id as i32,
    // rust: },
    // rust: );
}
    // rust: assert_eq!(game.map(0).unwrap().frames.len(), 2);
    // rust: for &id in &ids {
    // rust: for change in ["rotation", "unchanged", "components", "count", "empty"] {
    // rust: let frame = game
    // rust: .item_frames
    // rust: .iter()
    // rust: .find(|f| f.id == id)
    // rust: .unwrap()
    // rust: .clone();
    // rust: let mut tag = horizon_client::entity_nbt::item_frame_to_nbt(
    // rust: &frame,
    // rust: *game.persist.uuids.get(&id).unwrap(),
    // rust: None,
    // rust: );
    // rust: let Tag::Compound(fields) = &mut tag else {
    // rust: unreachable!()
}
            // Live command data omits the entity id before adoption.
    // rust: fields.remove(&"id".into());
    // rust: match change {
    // rust: "rotation" => {
    // rust: fields.insert("ItemRotation".into(), Tag::Byte(4));
}
    // rust: "components" | "count" => {
    // rust: let mut next = stack.clone();
    // rust: if change == "count" {
    // rust: next.count = 2;
    // rust: } else {
    // rust: next.damage = 1;
}
    // rust: fields.insert("Item".into(), horizon_client::save::item_to_nbt(&next));
}
    // rust: "empty" => {
    // rust: fields.remove(&"Item".into());
}
    // rust: _ => {}
}
    // rust: game.apply_entity_nbt(Target::Frame(id), tag).unwrap();
    // rust: assert_eq!(
    // rust: game.item_frames.iter().find(|f| f.id == id).unwrap().kind(),
    // rust: frame.kind(),
    // rust: "{change}: immutable frame type"
    // rust: );
    // rust: let retained = matches!(change, "unchanged" | "rotation");
    // rust: let map = game.map(0).unwrap();
    // rust: assert_eq!(
    // rust: map.frames.iter().any(|f| f.entity_id == id as i32),
    // rust: retained,
    // rust: "{change}: old saved frame association"
    // rust: );
    // rust: assert_eq!(
    // rust: map.decorations
    // rust: .iter()
    // rust: .any(|d| d.key == Key::Frame(id as i32)),
    // rust: retained,
    // rust: "{change}: old frame decoration"
    // rust: );
    // rust: let other = ids.iter().copied().find(|&other| other != id).unwrap();
    // rust: assert!(map.frames.iter().any(|f| f.entity_id == other as i32));
            // Re-establish the actual production map association for the next independent write.
    // rust: let frame = game.item_frames.iter_mut().find(|f| f.id == id).unwrap();
    // rust: frame.item = Some(stack.clone());
    // rust: let f = Framed {
    // rust: pos: frame.pos,
    // rust: facing: frame.facing,
    // rust: id: id as i32,
}
    // rust: game.map(0).unwrap().tick_framed(1, 0, false, false, f);
}
}
}
