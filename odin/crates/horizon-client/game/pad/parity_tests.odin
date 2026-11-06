//! Transpiled from Horizon Rust crate
package horizon_client_parity_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A controller action does what its keyboard key does, on a real `Game` without a window.
// What needs a renderer (inventory slots, screenshots) is covered by tools/pad_parity_e2e.py.

// use super::super::{Audio, Game, Options, Progress, Screen, Settings, load_resources};
// use horizon_client::actions::Action;
// use horizon_client::command::args::GameMode;
// use horizon_client::gamepad::{Button, PadState};
// use horizon_client::held::Source;
// use horizon_client::motion::PlayerMotion;
// use horizon_core::geometry::Vec3;
// use winit::event::MouseButton;
// use winit::keyboard::KeyCode;

// A game at play with no world: input reaches the mappings, as in `Screen::Playing`.
playing :: proc(test: impl FnOnce(^Game) {
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
    // rust: &mut |_, _| unreachable!("no menu handoff"),
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
    // rust: game.title = None;
    // rust: game.screen = Screen::Playing;
    // rust: test(&mut game);
}

// Hold `button` on the pad, as a poll that saw it go down would.
pad_press :: proc(game: ^Game, button: Button, action: string) {
}
    // rust: let mut state = PadState::default();
    // A trigger is held by how far it's pulled, not by a button bit.
    // rust: match button {
    // rust: Button::LeftTrigger => state.triggers[0] = 1.0,
    // rust: Button::RightTrigger => state.triggers[1] = 1.0,
    // rust: _ => state.set(button, true),
}
    // rust: game.pad.edges.update(&state, 0.4);
    // rust: game.pad_action(action, true).unwrap();
}

keyboard_handoff_keeps_what_the_pad_holds :: proc() {
}
    // rust: playing(|game| {
    // rust: game.mapped_key(KeyCode::KeyW, true, false, KeyCode::KeyW, Source::Keyboard)
    // rust: .unwrap();
    // rust: pad_press(game, Button::South, "key.jump");
    // rust: assert!(game.keys.held(Action::Jump) && game.keys.held(Action::Forward));
        // Splitscreen: keyboard and mouse move to another player.
    // rust: game.release_keyboard_mouse();
    // rust: assert!(!game.keys.held(Action::Forward), "the keyboard's walk ends");
    // rust: assert!(
    // rust: game.keys.held(Action::Jump),
    // rust: "the pad still holds jump; only the keyboard and mouse left"
    // rust: );
    // rust: });
}

pad_smooth_camera_binding_toggles_the_cinematic_camera :: proc() {
}
    // rust: playing(|game| {
    // rust: game.settings
    // rust: .controller
    // rust: .bind("key.smoothCamera", Some(Button::Select));
    // rust: assert!(!game.smooth_camera);
    // rust: pad_press(game, Button::Select, "key.smoothCamera");
    // rust: assert!(game.smooth_camera, "as its key does in play");
    // rust: });
}

// A player at the origin: the wheel's gates ask for one.
with_player :: proc(game: ^Game) {
}
    // rust: game.player = Some(PlayerMotion::new(game.motion, Vec3::ZERO).unwrap());
}

bumpers_step_the_hotbar_where_the_wheel_does :: proc() {
}
    // rust: playing(|game| {
    // rust: game.selected = 8;
    // rust: game.pad_action("pad.hotbarNext", true).unwrap();
    // rust: assert_eq!(game.selected, 8, "no player, no hotbar");
    // rust: with_player(game);
    // rust: game.pad_action("pad.hotbarNext", true).unwrap();
    // rust: assert_eq!(game.selected, 0, "wraps past the last slot");
    // rust: game.pad_action("pad.hotbarPrevious", true).unwrap();
    // rust: assert_eq!(game.selected, 8, "and back");
    // rust: game.pad_action("pad.hotbarNext", false).unwrap();
    // rust: assert_eq!(game.selected, 8, "a release does nothing");
    // rust: game.screen = Screen::Paused;
    // rust: game.pad_action("pad.hotbarNext", true).unwrap();
    // rust: assert_eq!(game.selected, 8, "a screen keeps the wheel from the hotbar");
    // rust: });
}

a_spectators_bumpers_set_the_flying_speed_as_the_wheel_does :: proc() {
}
    // rust: playing(|game| {
    // rust: with_player(game);
    // rust: game.mode = GameMode::Spectator;
    // rust: game.selected = 3;
    // rust: let speed = game.player.as_ref().unwrap().flying_speed;
    // rust: game.pad_action("pad.hotbarPrevious", true).unwrap();
        // One wheel notch up: `MouseHandler.onScroll` adds 0.005.
    // rust: let after = game.player.as_ref().unwrap().flying_speed;
    // rust: assert!((after - speed - 0.005).abs() < 1e-6, "{speed} -> {after}");
    // rust: assert_eq!(game.selected, 3, "a spectator's hotbar doesn't step");
    // rust: });
}

readers_of_the_movement_keys_see_the_stick :: proc() {
}
    // rust: playing(|game| {
    // rust: game.focused = true;
    // rust: assert!(!game.native_mapping("key.forward").unwrap().0);
        // Up and to the left, on a diagonal: two keys, as a keyboard would hold.
    // rust: game.pad.state.left = [-0.7, 0.7];
    // rust: assert!(game.native_mapping("key.forward").unwrap().0);
    // rust: assert!(game.native_mapping("key.left").unwrap().0);
    // rust: assert!(!game.native_mapping("key.back").unwrap().0);
    // rust: assert!(!game.native_mapping("key.right").unwrap().0);
    // rust: assert!(
    // rust: !game.native_mapping("key.jump").unwrap().0,
    // rust: "the stick holds only the movement keys"
    // rust: );
        // A screen takes the stick away.
    // rust: game.screen = Screen::Paused;
    // rust: assert!(!game.native_mapping("key.forward").unwrap().0);
    // rust: });
}

pad_number_actions_select_the_hotbar_as_their_keys_do :: proc() {
}
    // rust: playing(|game| {
    // rust: with_player(game);
    // rust: game.settings
    // rust: .controller
    // rust: .bind("key.hotbar.3", Some(Button::DPadUp));
    // rust: pad_press(game, Button::DPadUp, "key.hotbar.3");
    // rust: assert_eq!(game.hotbar_presses, [2]);
    // rust: });
}

a_held_pad_toolbar_action_counts_as_the_toolbar_key :: proc() {
}
    // rust: playing(|game| {
    // rust: game.settings
    // rust: .controller
    // rust: .bind("key.saveToolbarActivator", Some(Button::DPadUp));
    // rust: assert!(!game.mapped_key_down("key.saveToolbarActivator"));
    // rust: pad_press(game, Button::DPadUp, "key.saveToolbarActivator");
    // rust: assert!(game.mapped_key_down("key.saveToolbarActivator"));
    // rust: assert!(!game.mapped_key_down("key.loadToolbarActivator"));
    // rust: });
}

the_pads_attack_and_use_reach_what_the_mouse_tells_mods :: proc() {
}
    // rust: playing(|game| {
    // rust: assert_eq!(game.native_clicks(), (0, 0));
    // rust: pad_press(game, Button::RightTrigger, "key.attack");
    // rust: assert!(game.native_mapping("key.attack").unwrap().0);
    // rust: assert_eq!(game.native_clicks(), (1, 0));
    // rust: game.pad_action("key.attack", false).unwrap();
    // rust: assert!(!game.native_mapping("key.attack").unwrap().0);
    // rust: pad_press(game, Button::LeftTrigger, "key.use");
    // rust: assert!(game.native_mapping("key.use").unwrap().0);
    // rust: assert_eq!(game.native_clicks(), (1, 1));
    // rust: });
}

the_mouse_letting_go_leaves_what_the_pad_holds_and_back :: proc() {
}
    // rust: playing(|game| {
    // rust: game.mouse_mapping(MouseButton::Left, true, Source::Keyboard)
    // rust: .unwrap();
    // rust: pad_press(game, Button::RightTrigger, "key.attack");
    // rust: game.mouse_mapping(MouseButton::Left, false, Source::Keyboard)
    // rust: .unwrap();
    // rust: assert!(game.left, "the pad still holds the attack");
        // The pad let go, so its edges are no longer held either.
    // rust: game.pad.edges.update(&PadState::default(), 0.4);
    // rust: game.pad_action("key.attack", false).unwrap();
    // rust: assert!(!game.left);

        // The other way round: the mouse button is physically down.
    // rust: game.physical_buttons.insert(MouseButton::Right);
    // rust: game.mouse_mapping(MouseButton::Right, true, Source::Keyboard)
    // rust: .unwrap();
    // rust: pad_press(game, Button::LeftTrigger, "key.use");
    // rust: game.pad.edges.update(&PadState::default(), 0.4);
    // rust: game.pad_action("key.use", false).unwrap();
    // rust: assert!(game.right, "the mouse still holds the use");
    // rust: game.physical_buttons.remove(&MouseButton::Right);
    // rust: game.mouse_mapping(MouseButton::Right, false, Source::Keyboard)
    // rust: .unwrap();
    // rust: assert!(!game.right);
    // rust: });
}

a_release_from_a_screen_can_not_strand_the_pads_attack :: proc() {
}
    // rust: playing(|game| {
        // The mouse went down in play, and came up where the mappings didn't hear it.
    // rust: game.mouse_mapping(MouseButton::Left, true, Source::Keyboard)
    // rust: .unwrap();
    // rust: game.left = false;
    // rust: pad_press(game, Button::RightTrigger, "key.attack");
    // rust: assert!(game.left);
    // rust: game.pad.edges.update(&PadState::default(), 0.4);
    // rust: game.pad_action("key.attack", false).unwrap();
    // rust: assert!(!game.left, "nothing is physically held");
    // rust: });
}

keyboard_handoff_keeps_the_attack_the_pad_holds :: proc() {
}
    // rust: playing(|game| {
    // rust: pad_press(game, Button::RightTrigger, "key.attack");
    // rust: game.release_keyboard_mouse();
    // rust: assert!(game.left);
    // rust: });
}
