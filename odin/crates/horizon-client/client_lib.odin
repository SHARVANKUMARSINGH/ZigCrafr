//! Transpiled from Horizon Rust crate
package horizon_client_client_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon native client: resources, world streaming, rendering and the
// bindings between the validated simulation pieces and the game loop.
    // rust: extern crate self as horizon_client;
    // rust: pub mod advancements;
    // rust: pub mod ambience;
    // rust: pub mod animate_tick;
    // rust: pub mod arrows;
    // rust: pub mod block_contact;
    // rust: pub mod powder_snow;
    // rust: pub use horizon_client_render::{
    // rust: assets, atlas_sources, audio, auth, ban_notice, bidi, biome, block_edit, block_entities,
    // rust: block_entity_anim, block_entity_render, block_sprites, bluemap, bluemap_detect, border_render,
    // rust: breaking, brewing, camera, chat, chunk, chunk_map, cit, cit_armor, cit_assets, cit_glint,
    // rust: clouds, collisions, command_block, containers, controller_ui, crash, datapack, dynamic_light,
    // rust: effects, environment, extras, fast_hash, fog, font, gfx, graphics, graphics_style, graphics_ui,
    // rust: hdr_calibration, hud, hud_layout, hud_overlays, inventory_effects, java_text, jigsaw_block,
    // rust: json_folder, level_loading, light, lod, logging, menu_blur, mesher, minimap, mipmap,
    // rust: mod_browser, mod_list, model_library, models, multiline_edit, native_emissive, options_file,
    // rust: options_fixes, options_ui, overlay, pack_browser, pack_screen, packs, pad_cursor, pad_glyph,
    // rust: par, particles, poi_sections, post_chain, potent_sulfur, preedit, providers, pvp, pvp_hud,
    // rust: screen_draw, screen_effects, sculk, section_mask, server_terrain, settings, shader_options,
    // rust: shader_pack_list, signs, skins, sound_engine, sound_events, sound_preview, spans, split_layout,
    // rust: split_map, split_profiles, sprites, streaming, structure_block, tab_list, telemetry,
    // rust: test_block, test_instance_block, testgen, title_edition, trims, ui, vault, weather, widgets,
    // rust: world, worldborder, zip,
}
    // rust: pub mod attack_strength;
    // rust: pub mod attribute_updates;
    // rust: pub mod auto_jump;
    // rust: pub mod banner;
    // rust: pub mod beehive;
    // rust: pub mod benchmark;
    // rust: pub mod block_entity_item;
    // rust: pub mod block_pattern;
    // rust: pub mod block_transform;
    // rust: pub mod boss_overlay;
    // rust: pub mod breathing;
    // rust: pub mod cauldron;
    // rust: pub mod chunk_io;
    // rust: pub mod clock;
    // rust: pub mod command_storage;
    // rust: pub mod confirm_screen;
    // rust: pub mod container_screen;
    // rust: pub mod content_identity;
    // rust: pub mod control;
    // rust: pub mod crafting;
    // rust: pub mod creative;
    // rust: pub mod cushion;
    // rust: pub mod data_cmd;
    // rust: pub mod debug_chart;
    // rust: pub mod debug_entries;
    // rust: pub mod debug_keys;
    // rust: pub mod debug_overlay;
    // rust: pub mod debugworld;
    // rust: pub mod dialog;
    // rust: pub mod dialog_screen;
    // rust: pub mod discord_presence;
    // rust: pub mod end_crystal;
    // rust: pub mod end_gateway;
    // rust: pub mod entities;
    // rust: pub mod entity_nbt;
    // rust: pub mod entity_rules;
    // rust: pub mod extras_hud;
    // rust: pub mod falling_block;
    // rust: pub mod fire_render;
    // rust: pub mod first_person;
    // rust: pub mod flatgen;
    // rust: pub mod friends_screen;
    // rust: pub mod furnace;
    // rust: pub mod game_mode_switcher;
    // rust: pub mod game_rules_screen;
    // rust: pub mod gizmos;
    // rust: pub mod gossip;
    // rust: pub mod health;
    // rust: pub mod heartbeat;
    // rust: pub mod hotbar;
    // rust: pub mod hunger;
    // rust: pub mod inv_sort;
    // rust: pub mod item_activation;
    // rust: pub mod item_render;
    // rust: pub mod item_sync;
    // rust: pub mod item_tooltip;
    // rust: pub mod join_seq;
    // rust: pub mod lan;
    // rust: pub mod landing;
    // rust: pub mod legacy_combat;
    // rust: pub mod locator_bar;
    // rust: pub mod lod_net;
    // rust: pub mod menu;
    // rust: pub mod merchant;
    // rust: pub mod mobs;
    // rust: pub mod mod_content;
    // rust: pub mod mod_registry;
    // rust: pub mod motion;
    // rust: pub mod multiplayer;
    // rust: pub mod music;
    // rust: pub mod native_client_hooks;
    // rust: pub mod native_data;
    // rust: pub mod net;
    // rust: pub mod nether_portal;
    // rust: pub mod no_resources;
    // rust: pub mod offline_name;
    // rust: pub mod old_world;
    // rust: pub mod osk;
    // rust: pub mod patrol;
    // rust: pub mod perf_overlay;
    // rust: pub mod pick_item;
    // rust: pub mod player_sync;
    // rust: pub mod portal_sections;
    // rust: pub mod pose;
    // rust: pub mod pregen;
    // rust: pub mod projectiles;
    // rust: pub mod raid;
    // rust: pub mod random_tick_sections;
    // rust: pub mod realms;
    // rust: pub mod recipe_book;
    // rust: pub mod recipe_book_screen;
    // rust: pub mod reconnect;
    // rust: pub mod save;
    // rust: pub mod scoreboard_cmd;
    // rust: pub mod screen_layout;
    // rust: pub mod screen_narrator;
    // rust: pub mod social_screen;
    // rust: pub use horizon_server_files as server;
    // rust: pub mod controller_notice;
    // rust: pub mod server_packs;
    // rust: pub mod shadows;
    // rust: pub mod spear;
    // rust: pub mod spectator_menu;
    // rust: pub mod sprint;
    // rust: pub mod stand_up;
    // rust: pub mod stations;
    // rust: pub mod stopwatches;
    // rust: pub mod structure_blocks;
    // rust: pub mod studio;
    // rust: pub mod text_display;
    // rust: pub mod tick_chunk_membership;
    // rust: pub mod ticket_levels;
    // rust: pub mod title;
    // rust: pub mod toasts;
    // rust: pub mod ui_theme;
    // rust: pub mod vanillagen;
    // rust: pub mod voxel_occlusion;
// Keep the old path for native callers while giving the implementation a name
// that does not collide with the gameplay adapter in `game/entity_culling.rs`.
    // rust: pub use voxel_occlusion as entity_culling;
    // rust: pub mod win_screen;
    // rust: pub mod world_primitives;
    // rust: pub mod world_spawn;
    // rust: pub use horizon_client_core::Result;
    // rust: pub use horizon_client_core::block_entity_nbt;
    // rust: pub use horizon_client_core::bossbar;
    // rust: pub use horizon_client_core::component;
    // rust: pub use horizon_client_core::fastutil_order;
    // rust: pub use horizon_client_core::gamerules;
    // rust: pub use horizon_client_core::lang;
    // rust: pub use horizon_client_core::nbt_path;
    // rust: pub use horizon_client_core::scoreboard;
    // rust: pub use horizon_client_core::snbt;
    // rust: pub use horizon_client_core::text;
    // rust: pub use horizon_client_input::actions;
    // rust: pub use horizon_client_input::clipboard;
    // rust: pub use horizon_client_input::gamepad;
    // rust: pub use horizon_client_input::held;
    // rust: pub use horizon_client_input::input;
    // rust: pub use horizon_client_input::interaction_input;
    // rust: pub use horizon_client_input::key_names;
    // rust: pub use horizon_client_input::keybinds;
    // rust: pub use horizon_client_input::keymapping;
    // rust: pub use horizon_client_input::mouse;
    // rust: pub use horizon_client_input::window;
    // rust: pub use horizon_command as command;
    // rust: pub use horizon_items::blocks;
    // rust: pub use horizon_items::bundle;
    // rust: pub use horizon_items::cooldowns;
    // rust: pub use horizon_items::enchant;
    // rust: pub use horizon_items::flowers;
    // rust: pub use horizon_items::item_data;
    // rust: pub use horizon_items::items;
    // rust: pub use horizon_items::random_sequences;
