//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_hooks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Hook points for native mods (docs/native-mods.md, "Mods on the hook points"): empty
//! functions the game calls at fixed places, for horizon-mixins bundles to
//! hook with HEAD. Hooks that answer take an out parameter (`claimed`,
//! `zoom`…) so several mods can hook the same point. A native mod keeps its
//! own state in a module of its bundle; the helpers below read and draw what
//! Horizon's own HUD extras do, and keep a mod's settings where the
//! WebAssembly mod of the same id kept them.
//!
//! API 411 adds client Host services, GUI painting, model-head snapshots and client lifecycle notifications.
//!
//! API 410 adds a final foreground GUI overlay (`native_gui_render_post`) and the current frame's camera during GUI rendering.
//!
//! API 409 adds a client mod's play packet to the server, as it is (`native_send_packet`).
//!
//! API 408 adds reading the server's play packets on the client (`native_client_packet`).
//!
//! API 407 adds the player's IP address on `NativeServerPlayer` (`address`).
//!
//! API 406 adds a trade's live offer, for the mods to change (`native_merchant_offer_traded`).
//!
//! API 405 adds a dying player's inventory to `native_loot_drops` (`entity` the player, `minecraft:player`).
//!
//! API 404 adds a client mod's chat line or command to the server (`native_send_chat`).
//!
//! API 403 adds a chat line from the server about to show, replaceable or cancellable (`native_client_chat_received`).
//!
//! API 402 adds a camera a mod draws the world from (`native_camera_pose`).
//!
//! API 401 adds a mod menu type's extra data (`native_menu_extra_data`), and the client helpers `native_screen_pos`,
//! `native_screen_extra_data`.
//!
//! API 400 adds a mod's own data folders, read on each data load of a server (`native_add_server_reload_listeners`,
//! `native_server_reload_listener_apply`; `native_reload_listeners.rs`).
//!
//! API 399 adds a player's chat message before it is sent (`native_player_chat`).
//!
//! API 398 adds the player's network entity id on `NativeServerPlayer` (`entity_id`).
//!
//! API 397 adds mod config files, loaded and reloaded (`native_register_configs`, `native_config_loading`,
//! `native_config_reloading`, `native_config_unloading`; `native_configs.rs`).
//!
//! API 396 adds a slime or magma cube splitting on death, cancellable (`native_mob_split`).
//!
//! API 395 adds two animals breeding and a baby about to spawn, cancellable (`native_baby_entity_spawn`).
//!
//! API 394 adds experience points a server player is about to gain, changeable or cancelled (`native_player_xp_change`).
//!
//! API 393 adds the problem that stops a player sleeping in a bed, changeable (`native_can_player_sleep`).
//!
//! API 392 adds a living entity about to die, cancellable (`native_living_death`).
//!
//! API 391 adds a mob about to convert into another, cancellable (`native_living_conversion_pre`).
//!
//! API 390 adds a mob converted into another (`native_living_conversion_post`).
//!
//! API 389 adds A village siege found a spawn position, cancellable (`native_village_siege`).
//!
//! API 388 adds Possible natural spawn entries, mutable and cancellable (`native_potential_spawns`).
//!
//! API 387 adds A player tunes a note block (`native_note_block_change`).
//!
//! API 386 adds an entity's data (read and merge, as `/data` does), tags and name through an `EntityRef`.
//!
//! API 385 adds per-stack conditional item model properties (`native_item_model_property`).
//!
//! API 384 adds a host-aware player-weapon damage hook (`native_living_incoming_damage_v2`), leaving v1 compatible.
//!
//! API 383 adds living_knockback_v2: raw knockback with the attacker's entity id and held items, including armor-stand sweeps.
//!
//! API 382 adds living entity handles (`LivingRef`, `native_living`) and a living entity's equipment and hand items, read and set.
//!
//! API 381 adds a level's blocks and time through a `LevelRef`: block state, block, property, whether a chunk is loaded, height, game time and day time.
//!
//! API 380 adds block textures for client mods: `native_block_sprites` and `native_texture_sprites` say where blocks' and textures' sprites are in the block sprite arrays, and `WorldDrawn::block_sprites` hands a mod the arrays.
//!
//! API 379 adds an entity's velocity (and setting it), ground, box, eye height and position, view vector and distance through an `EntityRef`.
//!
//! API 378 adds validated category declarations for custom recipe types (`native_recipe_book_categories`, `native_recipe_book_category`); display and unlock integration follows separately.
//!
//! API 377 adds a mod's own ingredient kind matching a concrete stack
//! (`native_ingredient_test`, which the ingredient's test calls with the kind,
//! its JSON, the stack and the verdict — the load-time list already named
//! the item).
//!
//! API 376 adds The ammunition a bow or crossbow shooter finds (`native_living_get_projectile`).
//!
//! API 375 adds A player is about to nock a bow (`native_arrow_nock`).
//!
//! API 374 adds Explosion velocity replacement (`native_explosion_knockback`).
//!
//! API 373 adds entity and level handles (`EntityRef`, `LevelRef`, `native_entity`, `native_level`) and an entity's position, block position, rotation, type, UUID and level.
//!
//! API 372 adds a name tag hook (native_render_name_tag).
//!
//! API 371 adds `WorldDrawn::motion`: which mob, player or dropped item each run of the frame's entity quads is.
//!
//! API 370 adds a mod item holding items (`native_item_container`), and the item container helpers in
//! `native_item_container.rs`: `native_item_container_slots`, `native_item_container_insert`, `native_item_container_extract`.
//!
//! API 369 adds an additive first-person hand and item pose (`native_render_hand_pose`).
//!
//! API 368 adds tooltip box colours (`native_tooltip_color`).
//!
//! API 367 adds the screen_opening screen lifecycle observation (`native_screen_opening`) at most once per frame.
//!
//! API 366 adds the screen_init_post screen lifecycle observation (`native_screen_init_post`) at most once per frame.
//!
//! API 365 adds the screen_closing screen lifecycle observation (`native_screen_closing`) at most once per frame.
//!
//! API 364 adds the render hook point `native_hand_drawn(hand)`: the first-person hand is drawn (`HandDrawn`).
//!
//! API 363 adds reading the world camera and block collision boxes (`native_camera`, `native_block_collision`).
//!
//! API 362 adds a per-tick player FOV modifier hook (`native_compute_fov_modifier`).
//!
//! API 361 adds a cancellable item frame item render hook (`native_render_item_in_frame`).
//!
//! API 360 adds Local player movement input before application (`native_movement_input`).
//!
//! API 359 adds a living entity jumping (`native_living_jump`).
//!
//! API 358 adds a living entity healing, with a changeable amount and cancellation (`native_living_heal`).
//!
//! API 357 adds a living entity's fall, with changeable distance and multiplier and cancellation (`native_living_fall`).
//!
//! API 356 adds a living entity drowning, with changeable drowning and damage and a read-only bubble count (`native_living_drown`).
//!
//! API 355 adds a mod's own picture in the HUD atlas (`native_mod_image`).
//!
//! API 354 adds A timed world border size change finished (`native_world_border_bounds_change_finish`).
//!
//! API 353 adds A vault ejects a loot item (`native_vault_loot`).
//!
//! API 352 adds A hopper begins an item transfer attempt (`native_prepare_hopper_transfer`).
//!
//! API 351 adds A guest player changed sneaking (`native_player_toggle_sneak`).
//!
//! API 350 adds A server player released the use-item key (`native_player_stop_using_item`).
//!
//! API 349 adds A server player's recipe book settings changed (`native_player_recipe_book_settings_change`).
//!
//! API 348 adds The server player's selected bow projectile (`native_player_ready_arrow`).
//!
//! API 347 adds A server player's experience level changed (`native_player_level_change`).
//!
//! API 346 adds A server player launched a projectile item (`native_player_launch_projectile`).
//!
//! API 345 adds A guest was disconnected by a server kick (`native_player_kicked`).
//!
//! API 344 adds A guest jumped from the ground (`native_player_jump`).
//!
//! API 343 adds A guest sent player input flags (`native_player_input`).
//!
//! API 342 adds A server player's client finished loading the world (`native_player_client_loaded_world`).
//!
//! API 341 adds A server player selected an item in a bundle (`native_player_bundle_item_select`).
//!
//! API 340 adds A guest's server handled arm swing (`native_player_arm_swing`).
//!
//! API 339 adds A server player earned an advancement criterion (`native_player_advancement_criterion_grant`).
//!
//! API 338 adds a boat or minecart about to be destroyed (`native_vehicle_destroy`).
//!
//! API 337 adds a vehicle taking damage (`native_vehicle_damage`).
//!
//! API 336 adds a boat or minecart created (`native_vehicle_create`).
//!
//! API 335 adds A dropped item entity reached its lifetime and is about to despawn (`native_item_despawn`).
//!
//! API 334 adds A hopper moves an item between containers (`native_inventory_move_item`).
//!
//! API 333 adds A hopper selects a container while searching for items (`native_hopper_inventory_search`).
//!
//! API 332 adds A server explosion is about to begin (`native_explosion_prime`).
//!
//! API 331 adds A mob's leash was removed (`native_entity_unleash`).
//!
//! API 330 adds A mob is about to drop an item (`native_entity_drop_item`).
//!
//! API 329 adds A server player stopped digging before the block broke (`native_block_damage_abort`).
//!
//! API 328 adds A player took an anvil's result (`native_anvil_craft_pre`).
//!
//! API 327 adds A player finished taking an anvil's result (`native_anvil_craft_post`).
//!
//! API 326 adds the title's own screens to the screen hooks, and the instance folder helper (`native_instance_dir`).
//!
//! API 325 adds a dropped item reaching its lifetime (`native_item_expire`).
//!
//! API 324 adds a player saved to the world's store (`native_player_save_to_file`).
//!
//! API 323 adds a player loaded from the world's save (`native_player_load_from_file`).
//!
//! API 322 adds a player's data copied to their new player (`native_player_clone`).
//!
//! API 321 adds A statistic about to be awarded to a server player, cancellable (`native_player_stat_award`).
//!
//! API 320 adds A criterion of a server player's advancement was granted or revoked (`native_player_advancement_progress`).
//!
//! API 319 adds an item frame or painting about to break, cancellable (`native_hanging_break`).
//!
//! API 318 adds A player releases a bow with adjustable charge or cancellation (`native_arrow_loose`).
//!
//! API 317 adds attachment reads that never insert the default (`AttachmentType::has`, `AttachmentType::get_existing`).
//!
//! API 316 adds A player's melee hit on a living target decides whether it is critical (`native_critical_hit`).
//!
//! API 315 adds a player's item breaking (`native_player_destroy_item`).
//!
//! API 314 adds hiding a player from the players below a permission level (`native_hide_player`).
//!
//! API 313 adds drawing a component-bearing item stack and its decorations on a screen (`native_item_stack`).
//!
//! API 312 adds a server player's ender pearl is about to teleport them (`native_ender_pearl_teleport`).
//!
//! API 311 adds a server player who ate chorus fruit is about to try a random spot (`native_chorus_fruit_teleport`).
//!
//! API 310 adds a server player's trade with a villager or wandering trader, with its offer (`native_trade_with_villager`).
//!
//! API 309 adds a shift-click in a mod container's menu, routed by the mod (`native_menu_quick_move`).
//!
//! API 308 adds the time players wake at after sleeping through the night, changeable (`native_sleep_finished_time`).
//!
//! API 307 adds a mod item holding energy (`native_item_energy_buffer`), and the item energy helpers in
//! `native_item_energy.rs`: `native_item_energy`, `native_item_energy_insert`, `native_item_energy_extract`.
//!
//! API 306 adds A world save cycle completed (`native_world_saved`).
//!
//! API 305 adds The dedicated server whitelist was enabled or disabled (`native_whitelist_state_update`).
//!
//! API 304 adds Server weather parameters changing, cancellable (`native_weather_change`).
//!
//! API 303 adds A vault block changes state (`native_vault_change_state`).
//!
//! API 302 adds Player selected a villager trade (`native_trade_select`).
//!
//! API 301 adds The server clock is about to jump, cancellable (`native_time_skip`).
//!
//! API 300 adds Server thunder state changing, cancellable (`native_thunder_change`).
//!
//! API 299 adds A projectile hits a target block (`native_target_hit`).
//!
//! API 298 adds A guest asked the server to complete a command (`native_tab_complete`).
//!
//! API 297 adds A sponge absorbs water (`native_sponge_absorb`).
//!
//! API 296 adds A sculk catalyst begins blooming (`native_sculk_bloom`).
//!
//! API 295 adds A raid is triggered or reaches a terminal state (`native_raid_state_change`).
//!
//! API 294 adds A raid wave that has spawned (`native_raid_spawn_wave`).
//!
//! API 293 adds A projectile was added to the server level (`native_projectile_launch`).
//!
//! API 292 adds Smithing result prepared (`native_prepare_smithing`).
//!
//! API 291 adds Enchanting offers calculated (`native_prepare_item_enchant`).
//!
//! API 290 adds Crafting-grid result prepared (`native_prepare_item_craft`).
//!
//! API 289 adds Grindstone result prepared (`native_prepare_grindstone`).
//!
//! API 288 adds Anvil result prepared (`native_prepare_anvil`).
//!
//! API 287 adds A thrown potion applied its hit effects (`native_potion_splash`).
//!
//! API 286 adds A Nether portal or End arrival platform is created (`native_portal_create`).
//!
//! API 285 adds The server synced changed velocity to a player (`native_player_velocity`).
//!
//! API 284 adds A server player's action removed an entity's leash (`native_player_unleash_entity`).
//!
//! API 283 adds A server player completed a merchant trade (`native_player_trade`).
//!
//! API 282 adds A server player toggled an entity's age lock (`native_player_toggle_entity_age_lock`).
//!
//! API 281 adds Player about to travel through an End gateway, cancellable (`native_player_teleport_end_gateway`).
//!
//! API 280 adds A server player swapped with an equipment slot (`native_player_swap_with_equipment_slot`).
//!
//! API 279 adds A spectator stopped watching an entity (`native_player_stop_spectating_entity`).
//!
//! API 278 adds A server player selected a stonecutter recipe (`native_player_stonecutter_recipe_select`).
//!
//! API 277 adds A server player's respawn point about to change, cancellable (`native_player_spawn_point_set`).
//!
//! API 276 adds A player's shield was disabled by a blocked hit (`native_player_shield_disable`).
//!
//! API 275 adds A player about to shear a mob, cancellable (`native_player_shear_entity`).
//!
//! API 274 adds A player launches with a riptide trident (`native_player_riptide`).
//!
//! API 273 adds A recipe about to be discovered by a server player, cancellable (`native_player_recipe_discovered`).
//!
//! API 272 adds Server player requests recipe book auto-fill (`native_player_recipe_book_click`).
//!
//! API 271 adds A server player about to travel through a portal, cancellable (`native_player_portal`).
//!
//! API 270 adds A server player picked up an arrow (`native_player_pickup_arrow`).
//!
//! API 269 adds A server player's middle-click pick, cancellable (`native_player_pick_item`).
//!
//! API 268 adds A server player opened a sign editor (`native_player_open_sign`).
//!
//! API 267 adds A server player named a mob (`native_player_name_entity`).
//!
//! API 266 adds A server player filled an empty map (`native_player_map_filled`).
//!
//! API 265 adds A server player selected a loom pattern (`native_player_loom_pattern_select`).
//!
//! API 264 adds Server player changed client language (`native_player_locale_change`).
//!
//! API 263 adds A server player's selected hotbar slot, cancellable (`native_player_item_held`).
//!
//! API 262 adds An item cooldown about to start for a server player, cancellable (`native_player_item_cooldown`).
//!
//! API 261 adds XP orb pickup cooldown changed for a server player (`native_player_exp_cooldown_change`).
//!
//! API 260 adds A server player's orb-pickup experience points before they are added (`native_player_exp_change`).
//!
//! API 259 adds A server player used a firework rocket to boost while gliding (`native_player_elytra_boost`).
//!
//! API 258 adds A server player threw an egg (`native_player_egg_throw`).
//!
//! API 257 adds A player book edit or signing packet, cancellable (`native_player_edit_book`).
//!
//! API 256 adds A server player reaches deep sleep (`native_player_deep_sleep`).
//!
//! API 255 adds A server player's client option for their dominant hand changed (`native_player_change_main_hand`).
//!
//! API 254 adds A server player changed a beacon's selected effects (`native_player_change_beacon_effect`).
//!
//! API 253 adds A server player caught a mob in a bucket (`native_player_bucket_entity`).
//!
//! API 252 adds A player left a bed, after their sleeping state changed (`native_player_bed_leave`).
//!
//! API 251 adds A player about to enter a bed, cancellable (`native_player_bed_enter`).
//!
//! API 250 adds A server player's attack strength was reset by a punch (`native_player_attack_cooldown_reset`).
//!
//! API 249 adds A player completed an advancement (`native_player_advancement_done`).
//!
//! API 248 adds Note block about to sound (`native_note_play`).
//!
//! API 247 adds A server game rule changes (`native_world_game_rule_change`).
//!
//! API 246 adds World border center change (`native_world_border_center_changed`).
//!
//! API 245 adds World border bounds change (`native_world_border_bounds_changed`).
//!
//! API 244 adds The world spawn point changes (`native_spawn_change`).
//!
//! API 243 adds A server player took a book from a lectern (`native_player_take_lectern_book`).
//!
//! API 242 adds A server player changed a lectern page (`native_player_lectern_page_change`).
//!
//! API 241 adds An orb repaired a server player's item through Mending (`native_player_item_mend`).
//!
//! API 240 adds A server player changed an item frame (`native_player_item_frame_change`).
//!
//! API 239 adds A server player inserted a book into a lectern (`native_player_insert_lectern_book`).
//!
//! API 238 adds A server player put a plant in a flower pot (`native_player_flower_pot_manipulate`).
//!
//! API 237 adds Farmland moisture changing (`native_moisture_change`).
//!
//! API 236 adds A server lightning bolt is about to be created, cancellable (`native_lightning_strike`).
//!
//! API 235 adds A leaf block decaying (`native_leaves_decay`).
//!
//! API 234 adds A dropped item entity entered the level (`native_item_spawn`).
//!
//! API 233 adds A guest is about to open a block inventory (`native_inventory_block_start`).
//!
//! API 232 adds A hopper is about to pick up a dropped item (`native_hopper_pickup_item`).
//!
//! API 231 adds A vanilla world game event fired (`native_game_event`).
//!
//! API 230 adds A furnace begins cooking an item (`native_furnace_start_smelt`).
//!
//! API 229 adds A furnace finishes smelting an item (`native_furnace_smelt`).
//!
//! API 228 adds A player takes a furnace output (`native_furnace_extract`).
//!
//! API 227 adds A furnace consumes fuel and begins burning (`native_furnace_burn`).
//!
//! API 226 adds A flowing fluid changing level (`native_fluid_level_change`).
//!
//! API 225 adds A firework rocket completed explosion effects (`native_firework_explode`).
//!
//! API 224 adds An experience bottle broke and awarded experience (`native_exp_bottle`).
//!
//! API 223 adds A mob conversion completed (`native_entity_transform`).
//!
//! API 222 adds A guest player's fall flying state changed (`native_entity_toggle_glide`).
//!
//! API 221 adds A server entity completed a same-level teleport command (`native_entity_teleport`).
//!
//! API 220 adds A mob became tamed (`native_entity_tame`).
//!
//! API 219 adds A player fired an arrow from a bow or crossbow (`native_entity_shoot_bow`).
//!
//! API 218 adds A guest player's synchronized pose changed (`native_entity_pose_change`).
//!
//! API 217 adds A server entity begins a portal transfer (`native_entity_portal`).
//!
//! API 216 adds A mob entered love mode (`native_entity_enter_love_mode`).
//!
//! API 215 adds A bee entered a beehive (`native_entity_enter_block`).
//!
//! API 214 adds A mob changed a block (`native_entity_change_block`).
//!
//! API 213 adds Two mobs completed a breeding action (`native_entity_breed`).
//!
//! API 212 adds A mob broke a door (`native_entity_break_door`).
//!
//! API 211 adds Entities left the active world as a chunk unloaded (`native_entities_unload`).
//!
//! API 210 adds Saved entity records finished loading into a chunk (`native_entities_load`).
//!
//! API 209 adds Player applied an enchantment (`native_enchant_item`).
//!
//! API 208 adds The Ender Dragon fight placing its first egg (`native_dragon_egg_form`).
//!
//! API 207 adds Lightning charged a creeper (`native_creeper_power`).
//!
//! API 206 adds A player ignited a creeper (`native_creeper_ignite`).
//!
//! API 205 adds A crafter completes a recipe (`native_crafter_craft`).
//!
//! API 204 adds A player composts an item (`native_compost_item`).
//!
//! API 203 adds Cauldron fill level about to change (`native_cauldron_level_changed`).
//!
//! API 202 adds An item starts cooking on a campfire (`native_campfire_start`).
//!
//! API 201 adds A server system broadcast line, rewritable or cancellable (`native_broadcast_message`).
//!
//! API 200 adds A brewing stand starts a brew (`native_brewing_start`).
//!
//! API 199 adds Brewing stand consumed fuel (`native_brewing_fuel`).
//!
//! API 198 adds Brewing stand finished brewing (`native_brewing_complete`).
//!
//! API 197 adds A dispenser shears an entity (`native_block_shear_entity`).
//!
//! API 196 adds A sculk listener receives a game event (`native_block_receive_game`).
//!
//! API 195 adds A guest checks a block container lock (`native_block_lock_check`).
//!
//! API 194 adds Fire about to be placed (`native_block_ignite`).
//!
//! API 193 adds Precipitation forms ice or snow (`native_block_form`).
//!
//! API 192 adds A dispenser fails to dispense an item (`native_block_failed_dispense`).
//!
//! API 191 adds A block fades (`native_block_fade`).
//!
//! API 190 adds A block is about to drop experience (`native_block_exp`).
//!
//! API 189 adds A dispenser equips armor or equipment (`native_block_dispense_armor`).
//!
//! API 188 adds A block finishes cooking an item (`native_block_cook`).
//!
//! API 187 adds Fire about to burn a block away (`native_block_burn`).
//!
//! API 186 adds A guest's block-breaking progress changes (`native_block_break_progress_update`).
//!
//! API 185 adds Bell about to ring (`native_bell_ring`).
//!
//! API 184 adds A beacon activates or deactivates (`native_beacon_state_change`).
//!
//! API 183 adds An anvil takes damage (`native_anvil_damaged`).
//!
//! API 182 adds a totem of undying saving a player (`native_player_totem`).
//!
//! API 181 adds TNT about to be lit, cancellable (`native_tnt_primed`).
//!
//! API 180 adds a server player placing an item frame, painting or leash knot, cancellable (`native_hanging_place`).
//!
//! API 179 adds a server player emptying a bucket, cancellable (`native_bucket_empty`).
//!
//! API 178 adds a boat or minecart a server player rides having moved (`native_vehicle_moved`).
//!
//! API 177 adds a creative player setting a slot from the creative screen, cancellable (`native_creative_slot`).
//!
//! API 176 adds a player opening one of the game's menus, cancellable (`native_container_opened`).
//!
//! API 175 adds a player taking an item from or putting one on an armor stand, cancellable (`native_armor_stand_manipulate`).
//!
//! API 174 adds a server player's answer to a resource pack (`native_resource_pack_status`).
//!
//! API 173 adds a server player's sprint starting or stopping (`native_player_sprint`).
//!
//! API 172 adds a joining player the mods may refuse (`native_player_login`).
//!
//! API 171 adds the root commands a player's command tree holds (`native_player_commands_sent`).
//!
//! API 170 adds a server player teleported by a command (`native_player_teleported`).
//!
//! API 169 adds a player's food level changing, changeable and cancellable (`native_food_level_changed`).
//!
//! API 168 adds a player swapping their hands, cancellable (`native_player_swap_hands`).
//!
//! API 167 adds lowering the frame rate limit, as Dynamic FPS does (`native_framerate_limit`).
//!
//! API 166 adds a recipe ingredient of a mod's own kind
//! (`native_ingredient`, which the unknown ingredient type in a namespace of
//! own reaches with the kind, its JSON and the item list to fill).
//!
//! API 165 adds the window's physical pixel size (`native_physical_window_size`).
//!
//! API 164 adds a helper that names the block a state belongs to (`native_state_block`).
//!
//! API 163 adds a server mod's line for the event stream and the Discord bridge (`native_server_event`).
//!
//! API 162 adds a player's item losing durability, changeable and cancellable (`native_item_damaged`).
//!
//! API 161 adds a player taking a crafting grid's result (`native_item_crafted`).
//!
//! API 160 adds a player's fishing rod: cast, bite, catch, reel-in, cancellable (`native_player_fish`).
//!
//! API 159 adds the server's difficulty changing (`native_difficulty_changed`).
//!
//! API 158 adds a server player's game mode about to change, cancellable (`native_player_game_mode_changed`).
//!
//! API 157 adds how fire burns a mod block (`native_fire_odds`, `FireBlock.setFlammable`), and a mod block under
//! a campfire that makes it a signal fire (`native_smoke_source`, `CampfireBlock.isSmokeSource`).
//!
//! API 156 adds where a loot roll happens, for a mod's own loot kinds
//! (`NativeLootContext.place`: the origin, the block entity and the level).
//!
//! API 155 adds a server player taking an experience orb (`native_experience_orb_pickup`, asked for through
//! `native_experience_orb_pickup_listened`: cancel it, or change the orb's value and count) and the Mending repair
//! proposed for the item it picked (`native_mending_repair`).
//!
//! API 154 adds a player changing dimension (`native_player_changed_dimension`).
//!
//! API 153 adds a player starting or stopping flight, cancellable (`native_player_toggle_flight`).
//!
//! API 152 adds a player opening and closing a menu (`native_player_container_open`, `native_player_container_close`).
//!
//! API 151 adds models no blockstate names, baked for drawing (`native_standalone_models`,
//! `native_draw_model`).
//!
//! API 150 adds a player finishing a sign, rewritable or cancellable (`native_sign_changed`).
//!
//! API 149 adds a player drawn with a mod's own model, and layers added to mobs and players (`native_player_submit`, `native_mob_layer`, told while a mod sets `native_player_render_listened`).
//!
//! API 148 adds a mob's or an armor stand's equipment slot taking another stack (`native_living_equipment_change`), and whether a mod listens to the mobs' (`native_living_equipment_listened`).
//!
//! API 147 adds a mod item as a fluid container (`native_item_fluid_tank`), and the item fluid helpers in `native_item_fluids.rs`: `native_item_fluid`, `native_item_fluid_fill`, `native_item_fluid_drain`.
//!
//! API 146 adds entities ticking, which a mod can stop (`native_entity_tick_pre`, `native_entity_tick_post`, told while a mod sets `native_entity_tick_listened`).
//!
//! API 145 adds blocks and items declared in code (`native_blocks`, `native_items`).
//!
//! API 144 adds a player's or mob's breathing each tick (`native_living_breathe`, a free function in `horizon_client::breathing`).
//!
//! API 143 adds data map types a native mod registers (`native_data_map_types`), merged from the data packs' and mods' files each time the server's tables are built, read with `native_data_map` and `native_data_map_entries` (`native_data_maps.rs`).
//!
//! API 142 adds an energy buffer on a mod block's block entity (`native_block_entity_energy`), and the energy helpers in `machines/native_energy.rs`: `native_energy`, `native_energy_insert`, `native_energy_extract`, `native_move_energy`.
//!
//! API 141 adds a player starting and stopping tracking an entity (`native_player_start_tracking`, `native_player_stop_tracking`).
//!
//! API 140 adds a mod's own icons on filled maps (`native_map_decorations`).
//!
//! API 139 adds HUD layers around vanilla's own (`native_gui_layer_pre`, `native_gui_layer_post`).
//!
//! API 138 adds a cancellable attack, use and pick-block key hook (`native_interaction_key`).
//!
//! API 137 adds an entity getting on or off a vehicle, which a mod can cancel (`native_entity_mount`).
//!
//! API 136 adds a projectile's impact a mod can cancel (`native_projectile_impact`, heard once a mod sets `native_hears_projectile_impacts`).
//!
//! API 135 adds the client's level made and dropped (`native_client_level_load`, `native_client_level_unload`).
//!
//! API 134 adds a server's levels opening and closing (`native_level_load`, `native_level_unload`).
//!
//! API 133 adds a loot table's function and condition of a mod's
//! own kind (`native_loot_function` and `native_loot_condition`, which the
//! unknown `type` in a namespace of its own reaches with the kind, its JSON,
//! the loot context and the stack or the holds).
//!
//! API 132 adds other players' inventories for server mods, online or from their file (`native_inventory`, `native_move_stack`), and maps a mod draws (`native_send_map`).
//!
//! API 131 adds an item's use tick and release (`native_living_entity_use_item_tick`,
//! `native_on_use_tick`, `native_living_entity_use_item_stop`, `native_release_using`).
//!
//! API 130 adds a content mod menu type's slot rules decided in code (`native_menu_slot_rules`, in
//! `menu.rs`: whether a slot takes a stack, `Slot.mayPlace`, and how many it holds,
//! `Slot.getMaxStackSize`), with mod menu types' clicks on the vanilla menu engine.
//!
//! API 129 adds mod block entities on any template (`native_block_entity`).
//!
//! API 128 adds experience orb merging a mod decides (`native_experience_orb_can_merge`, `native_experience_orb_merge`) and writes (`native_set_experience_orb`).
//!
//! API 127 adds column reads for server mods (`native_surface_heights`, `native_read_columns`).
//!
//! API 126 adds bulk block edits for server mods (`native_edit_blocks`).
//!
//! API 125 adds knockback a mod can change or cancel (`native_living_knockback`).
//!
//! API 124 adds the players with a mod container open (`native_mod_container_viewers`).
//!
//! API 123 adds a screen drag hook (`native_screen_mouse_dragged_pre`).
//!
//! API 122 adds a two-axis gameplay scroll hook (`native_mouse_scrolling`).
//!
//! API 121 adds a complete window keyboard event (`native_input_key`).
//!
//! API 120 adds a server's recipes sent to its Horizon clients: the server's mods name the recipe types
//! (`native_datapack_sync`, `OnDatapackSyncEvent.sendRecipes`) and the client hears they arrived
//! (`native_recipes_received`, `RecipesReceivedEvent`).
//!
//! API 119 adds music for client mods: the track and its volume (`native_music`) and looping layers over it (`native_music_layers`).
//!
//! API 118 adds a screen key release hook (`native_screen_key_released_pre`).
//!
//! API 117 adds a final world fog hook (`native_render_fog`).
//!
//! API 116 adds a client mod's view and its own items (`native_raycast`, `native_view_hit`,
//! `native_claim_items`, `native_poll`).
//!
//! API 115 adds a player respawning (`native_player_respawned`).
//!
//! API 114 adds raw mouse button pre/post hooks (`native_mouse_button_pre`, `native_mouse_button_post`).
//!
//! API 113 adds a computed fog color hook (`native_compute_fog_color`).
//!
//! API 112 adds a detached-camera distance hook (`native_camera_distance`).
//!
//! API 111 adds a native mod's own screen (`native_mod_screen_open`, `native_mod_screen_close`,
//! `native_mod_screen`) and two drawing helpers for the screen hooks (`native_quad`,
//! `native_item_model`).
//!
//! API 110 adds mobs drawn by client mods (`native_mob_submit`, with `NativeMobRender`).
//!
//! API 109 adds a world field-of-view hook (`native_compute_fov`).
//!
//! API 108 adds the server's data tables are built (`native_server_data_loaded`, `TagsUpdatedEvent` with
//! `SERVER_DATA_LOAD`): a world's first open and every `/reload`, told apart by `reload`.
//!
//! API 107 adds biome colours for client mods (`native_biome_colors`, `native_refresh_biome_colors`).
//!
//! API 106 adds data pack files for the tables a native mod contributes (`native_data_pack_files`), on a world's first open and on every `/reload`.
//!
//! API 105 adds a push for the local player and a player's flying speed (`native_push_player`,
//! `native_set_flying_speed`).
//!
//! API 104 adds the open screen hears of a key press (`native_screen_key_pressed_pre`, the
//! `ScreenEvent.KeyPressed.Pre` point, with the screen, vanilla's key name, whether it is an
//! auto-repeat and the modifiers) and of each character it types (`native_screen_char_typed_pre`,
//! `ScreenEvent.CharacterTyped.Pre`, fired after the key has acted, on the screen open then), so a
//! cancelled press goes no further and a cancelled character never reaches a text box. The helpers
//! both paths share (`screen_key_pressed`, `screen_text_typed`, `screen_chars_typed`,
//! `screen_text_hooked`) sit beside them.
//!
//! API 103 adds a mod's own particle types for `native_send_particles`
//! (`ParticleOptions::named`).
//!
//! API 102 adds lead drops to `native_loot_drops`: untying a lead or cutting it with shears, and the lead a mob a player
//! killed while leashed drops on its next tick, with the player named.
//!
//! API 101 adds experience for server mods: reading orbs (`native_experience_orbs`), giving points as an orb does (`native_give_experience`) and giving or taking levels (`native_give_levels`).
//!
//! API 100 adds player-use drops to `native_loot_drops` (`NativeLootDrops::used`): shearing, brushing, carving a
//! pumpkin, picking berries and breaking an item frame, with the player named.
//!
//! API 99 adds a mod's command typed on the dedicated server's console (`native_perform_console_command`).
//!
//! API 98 adds giving a whole stack to any player from a server hook (`native_give_stack`).
//!
//! API 97 adds reading the world's light, weather, time of day, height and item stack sizes from a native mod (`native_light`, `native_weather`, `native_day_time`, `native_world_height`, `native_max_stack_size`).
//!
//! API 96 adds reading redstone from a server mod's block (`native_neighbor_signal`).
//!
//! API 95 adds any command a player types, cancellable (`native_player_command`).
//!
//! API 94 adds keeping a mod block entity's geometry while it doesn't change
//! (`BlockEntityDraw::keep`).
//!
//! API 93 adds the open screen hears of the wheel before it scrolls (`native_screen_mouse_scrolled_pre`,
//! the `ScreenEvent.MouseScrolled.Pre` point, with the screen, the scroll in x and y as the game's
//! scroll handler scales it, and the modifiers), so a cancelled turn scrolls nothing.
//!
//! API 92 adds the world's clock on a client (`native_clock`).
//!
//! API 91 adds items and block state properties for drawing mod block entities
//! (`native_draw_item`, `native_block_state_property`).
//!
//! API 90 adds using an item over time: its duration and hand pose (`native_use_duration`,
//! `native_use_animation`), `native_can_eat`, and its start and finish
//! (`native_living_entity_use_item_start`, `native_living_entity_use_item_finish`).
//!
//! API 89 adds custom item icon decorations (`native_item_decorations`).
//!
//! API 88 adds a client resource-pack reload completion notification (`native_client_resources_reloaded`).
//!
//! API 87 adds a cancellable first-person hand render hook (`native_render_hand`).
//!
//! API 86 adds a cancellable targeted-block highlight hook (`native_block_highlight`).
//!
//! API 85 adds menus of content mods' own menu types for mod containers (the `menu` of a
//! `ModContainer` may name one).
//!
//! API 84 adds values for a mod's own shader pack (`native_shader_params`).
//!
//! API 83 adds client sounds that wait (`native_play_local_sound`).
//!
//! API 82 adds camera shake for client mods (`native_camera_shake`).
//!
//! API 81 adds falling blocks for server mods (`native_spawn_falling_block`,
//! in `native_falling.rs`).
//!
//! API 80 adds the open screen hears of a mouse button going down or up before it acts
//! (`native_screen_mouse_button_pressed_pre`, `native_screen_mouse_button_released_pre`, the
//! `ScreenEvent.MouseButtonPressed.Pre` and `.MouseButtonReleased.Pre` points, with the screen, the
//! GLFW button and the modifiers), and the helpers the input hooks share (`screen_view_now`,
//! `screen_hooks_open`).
//!
//! API 79 adds items' default components (`native_modify_default_components`, in `horizon-world`'s
//! `item_defaults.rs`): set or remove a component of any item, vanilla's included, as the game reads its defaults.
//!
//! API 78 adds `native_screen_render_post` (`ScreenEvent.Render.Post`: draw over the open
//! screen, given its id, menu type, title, container panel, slot count, mouse
//! and partial tick).
//!
//! API 77 adds a `minecraft:post_attack` enchantment effect of a mod's own kind
//! (`native_enchant_effect`, told the enchantment, the kind, the JSON, the level and
//! the mob hit).
//!
//! API 76 adds a mod block's placement state (`native_state_for_placement`) and the state it is built from
//! (`native_state_with_property`): what a block that faces the player, sits on the clicked face or comes waterlogged needs.
//!
//! API 75 adds changing vanilla's loot tables and drops: `native_loot_table_load` (in
//! `horizon-world`'s `loot.rs`: each table's JSON as it loads) and `native_loot_drops` (a broken
//! block's or a dead mob's items, with what dropped them).
//!
//! API 74 adds a consumable's effect of a mod's own kind
//! (`native_consume_effect`, which the unknown `on_consume_effects` type reaches with
//! the kind and the JSON the file wrote).
//!
//! API 73 adds mod-block entity contacts (`native_block_step_on`, `native_block_entity_inside`, `native_block_fall_on`), including mutable landing damage.
//!
//! API 72 adds bone meal on a mod block (`native_is_valid_bonemeal_target`, `native_is_bonemeal_success`,
//! `native_perform_bonemeal`), and the level's random a world hook draws from (`native_level_random`).
//!
//! API 71 adds drawing mod block entities on the client (`native_block_entity_submit`,
//! vanilla's `BlockEntityRenderer.submit`, culled by `native_block_entity_render_bounding_box`,
//! NeoForge's `getRenderBoundingBox`), with a pose stack (`BlockEntityDraw`) and the
//! helpers `native_draw_quad`, `native_draw_cube` and `native_draw_block`.
//!
//! API 70 adds a mod block's own `canSurvive` (`native_can_survive`), and the blocks a mod plant
//! can stand on (`native_may_place_on`, `VegetationBlock.mayPlaceOn`).
//!
//! API 69 adds a mod's own advancement criteria triggers (`native_trigger_criterion`,
//! in `native_criteria.rs`).
//!
//! API 68 adds stack-dependent image tooltip components, measured with `native_tooltip_component` and rendered with `native_tooltip_component_draw`.
//!
//! API 67 adds dispenser item behaviours (`native_dispense_item`) and `native_dispense_default` for a plain drop.
//!
//! API 66 adds explosions for server mods (`native_explode`, in
//! `native_explosions.rs`).
//!
//! API 65 adds native item component type registration (`native_component_types`) and opaque NBT component helpers.
//!
//! API 64 adds comparator output from a mod's block (`native_has_analog_output`,
//! `native_analog_output`, and the helper `native_update_output_neighbors`).
//!
//! API 63 adds context-free tag lookups for server hooks (`native_server_block_in_tag`, `native_server_item_in_tag`).
//!
//! API 62 adds nicknames for server mods: `native_set_nickname` shows a name in place of a player's in chat and
//! the Tab list (the real one on hover), and `native_text_allowed` asks the server's chat filter, in
//! `native_server.rs`.
//!
//! API 61 adds mods' own sound events in `native_play_sound`: another
//! namespace's event is sent by name, as vanilla sends an unregistered sound.
//!
//! API 60 adds the small bar under an item (`native_item_bar`): `GuiGraphicsExtractor.itemDecorations`
//! hands it vanilla's choice (the damage bar, or a bundle's fullness already applied), to replace or hide.
//!
//! API 59 adds entities for server mods (`native_summon`, `native_move_entity`,
//! `native_set_display`, `native_remove_entity`, in `native_entities.rs`).
//!
//! API 58 adds the renderer's hook points, in `horizon-client-render`'s
//! `gfx/native_render.rs`: `native_world_drawn` (draw with the world's colour,
//! depth, matrices and entity geometry before the hand and the HUD) and
//! `native_render_needs` (entity runs and the world's depth without a pack).
//!
//! API 57 adds chunks and players coming and going (`native_chunk_load`,
//! `native_chunk_unload`, `native_player_logged_in`, `native_player_logged_out`).
//!
//! API 56 adds what a content mod's mob effects do: their effect tick
//! (`native_should_apply_effect_tick_this_tick`, `native_apply_effect_tick`)
//! and their being given (`native_on_effect_added`,
//! `native_mob_effect_added`).
//!
//! API 55 adds moving a block's fluids to another block (`native_move_fluids`, in
//! `machines/native_fluids.rs`: what the target refuses goes back into the
//! source, whole thirds kept).
//!
//! API 54 adds fluid tanks on a mod block's block entity
//! (`native_block_entity_fluids`), and the fluid helpers in
//! `machines/native_fluids.rs`: `native_fluid_tanks`,
//! `native_fluid_insert`, `native_fluid_extract`, which also read and
//! change a cauldron.
//!
//! API 53 adds entities leaving a level (`native_entity_leave_level`), for
//! every kind the join hook tells (see API 47).
//!
//! API 52 adds `native_block_entity_sync`: a mod block entity's block and update tag
//! sent to clients again (`Level.sendBlockUpdated`).
//!
//! API 51 adds `native_menu_button_v2`: a mod container's menu button with the clicking player's cursor stack (`clickMenuButton(Player, int)`).
//!
//! API 50 adds damage a mod can change or cancel (`native_living_incoming_damage`).
//!
//! API 49 adds, in `native_server.rs`, a sidebar and Tab list lines for one
//! player (`native_sidebar`, `native_tab_list`), the server's tick times
//! (`native_tick_stats`), players left out of the sleep count
//! (`native_sleep_ignored`), and where players look (`yaw`, `pitch`).
//!
//! API 48 adds a block's items for server mods (`native_container_slots`,
//! `native_extract_item`, `native_move_items`, and `native_dimension` for a
//! machine's tick, in `machines/native_items.rs`).
//!
//! API 47 adds entities joining a level (`native_entity_join_level`); it tells
//! every kind the game keeps in its entity lists (items, orbs, mobs, boats,
//! minecarts, armor stands, TNT, falling blocks, projectiles, rockets,
//! tridents, end crystals, the dragon, cushions, paintings, item frames).
//!
//! API 46 adds bounded world-space rim and colored-light requests
//! (`native_visuals`) and opt-in texture-matched emissive material
//! requests (`native_emissive`).
//!
//! API 45 sends mod block entities to clients (`native_block_entity_update_tag`).
//!
//! API 44 adds the server starting and stopping (`native_server_about_to_start`,
//! `native_server_stopping`).
//!
//! API 43 adds the server level's random (`native_level_random`).
//!
//! API 42 adds the item entities near a block (`native_item_entities`,
//! `native_set_item_entity`).
//!
//! API 41 adds bundles' data files: `horizon_client::native_data!` compiles a file of a
//! bundle's `data/` folder in, and `native_built_data` is the folder its post-build step wrote.
//!
//! API 40 adds mod messages between a mod's server and client halves
//! (`native_net_from_client`, `native_net_from_server`, and
//! `native_net_send_to_player`, `native_net_send_to_server` in
//! `native_net.rs`), and hearing players and mobs: `native_player_died`,
//! `native_mob_spawned`, `native_mob_killed`, `native_item_dropped`,
//! `native_item_picked_up`.
//!
//! API 39 adds item behaviour: a held item's hit on a mob
//! (`native_hurt_enemy`), a carried stack's tick (`native_inventory_tick`) and
//! an equipment slot taking a different item (`native_on_equip`).
//!
//! API 38 adds redstone from a mod's block (`native_block_signal`,
//! `native_is_signal_source`, and the helper `native_update_signal_neighbors`).
//!
//! API 37 adds mobs for server mods (`native_spawn_mob`, `native_mob`,
//! `native_mobs`, `native_teleport_mob`, `native_push_mob`,
//! `native_set_mob_health`, `native_kill_mob`, `native_remove_mob`... in
//! `native_mobs.rs`).
//!
//! API 36 adds recipes of a mod's own types (`native_recipes_of_type`,
//! `native_recipe_ingredient`, `native_recipe_result`).
//!
//! API 35 adds the commands a mod owns on the client (`native_commands`), so
//! that the chat box colours, completes and lists them like the game's own.
//!
//! API 34 adds scheduled block ticks a mod can handle (`native_tick_block`).
//!
//! API 33 adds random ticks a mod can handle (`native_random_tick`), and
//! `native_set_block_property` on the level, which takes `Level.setBlock`'s
//! `flags` as `Game::native_set_block_property_with` does.
//!
//! API 32 adds shape updates a mod can answer (`native_update_shape`), and
//! `native_schedule_block_tick` and `native_schedule_fluid_tick` on the
//! level for the ticks a block's shape update schedules.
//!
//! API 31 adds a player's server tick (`native_player_tick`).
//!
//! API 30 adds left-clicking a block (`native_left_click_block`).
//!
//! API 29 adds right-clicking an entity (`native_interact_entity`).
//!
//! API 28 adds block and item tag reads for server tick hooks (`native_block_in_tag`,
//! `native_item_in_tag`).
//!
//! API 27 adds the player-health HUD rows (`native_health_hud`).
//!
//! API 26 adds the game's shared config folder (`native_config_dir`).
//!
//! API 25 adds server sound playback (`native_play_sound`).
//!
//! API 24 adds a server block setter (`native_set_block`).
//!
//! API 23 adds per-level server tick hooks (`native_level_tick_pre`,
//! `native_level_tick_post`).
//!
//! API 22 adds what a mod needs to keep the world from changing blocks
//! it guards: fluid and fire spreading (`native_block_spread`), pistons
//! (`native_piston_move`), explosions (`native_explosion_detonate`),
//! buckets (`native_fill_bucket`) and a player's attack on an entity
//! (`native_attack_entity`).
//!
//! API 21 adds right clicking a block (`native_right_click_block`), and in
//! `native_server.rs` the acting player (`native_acting_player`), a player's
//! health, the action bar (`native_action_bar`) and commands run as the
//! server (`native_run_command`).
//!
//! API 20 adds buttons, tooltips and item icons on mod screens
//! (`native_screen_click`, `native_screen_tooltip`, `native_menu_button`,
//! and `native_item`, `native_screen_title`, `native_data`, `native_block`,
//! `native_block_property`, `native_insert_item`, `native_cursor`).
//!
//! API 19 adds mod-drawn screens for mod blocks (`native_screen`,
//! `native_screen_draw`, and the `native_sprite` helpers), with the mod's own
//! GUI textures.
//!
//! API 18 adds what a machine's tick reaches: a neighbouring mod block entity
//! (`native_with_mod_block_entity`) and its own block's state
//! (`native_set_block_property`).
//!
//! API 17 adds menus for mod containers (the `menu` of a `ModContainer`: vanilla
//! slot grids and furnaces) and has `native_block_entity_tick` take the whole
//! `ModBlockEntity`, with the menu's data slots.
//!
//! API 16 adds item slots for those block entities
//! (`native_block_entity_container`), which hoppers, comparators and
//! breaking the block use as they use vanilla's containers.
//!
//! API 15 adds block entities for a mod's blocks (`native_block_entity`,
//! `native_block_entity_ticks`, `native_block_entity_tick`): made when the
//! block is placed, ticked on the server and saved with the chunk.
//!
//! API 14 adds breaking and placing a block (`native_destroy_block`,
//! `native_place_block`).
//!
//! API 13 adds using an item (`native_use_item_on`, `native_use_item`).
//!
//! API 12 adds item tooltips (`native_tooltip`).
//!
//! API 11 adds server particle emission (`native_send_particles`).
//!
//! API 10 adds server menus (`native_menu_clicked`, `native_menu_closed`,
//! and `native_open_menu`, `native_exchange_items`... in `native_server.rs`).
//!
//! API 9 adds the acting player's plain items (`native_held`,
//! `native_count_items`, `native_take_items`, `native_give_items`... in
//! `native_server.rs`).
//!
//! API 8 adds server commands and players (`native_register_commands`,
//! `native_perform_command`, and the helpers in `native_server.rs`).
//!
//! API 7 adds block-change observations (`native_block_changed`).
//!
//! API 6 adds neighbour-change observations (`native_neighbor_changed`).
//!
//! API 5 adds read-only server block queries (`native_server_block`).
//!
//! API 4 adds authoritative server tick hooks (`native_server_tick`).
//!
//! API 3 adds the world lifecycle hook (`native_world_lifecycle`).
//!
//! API 2 adds the item panel beside container screens and its recipe pages
//! (`native_panel_items`, `native_panel_recipes`, `native_panel_event`),
//! and the game's items and recipes (`native_recipes`,
//! `native_known_recipes`, `native_place_recipe`, `native_give`): what a
//! recipe viewer needs.
//!
//! Names, parameters and call sites are kept from release to release, and
//! hook points are only ever added: each addition raises [`NATIVE_HOOKS_API`].
//! A bundle that hooks only these names the API it needs (`hooks`), and the
//! launcher builds it on any Horizon whose API is at least that one. A change
//! that would break such a bundle is not made.
//! Bodies have no `cfg` and no macros: horizon-mixins refuses a target with
//! either (`tests::hook_points_stay_hookable`).
// use super::native_data_maps::NativeDataMapType;
// use super::native_item_energy::ItemEnergyBuffer;
// use super::{
    // rust: Game, GameLevel, LevelDimension, Screen,
    // rust: execution_role::ExecutionRole,
    // rust: maps::{NativeMapDecoration, NativeMapInfo},
    // rust: native_block_entity_draw::BlockEntityDraw,
    // rust: native_configs::{NativeConfig, NativeConfigFile},
    // rust: native_mob_draw::{NativeMobRender, NativePlayerRender},
    // rust: native_panel_recipes::RecipePage,
    // rust: native_reload_listeners::NativeReloadListener,
    // rust: native_world_draw::NativeWorldDraw,
}
// use horizon_assets::item_model::StackView;
// use horizon_client::mod_api::{
    // rust: self, NativeCamera, NativeCommand, NativeDispensed, NativeLifecycleContext,
    // rust: NativeNoteBlockChange, NativeServerPlayer, RecipeBookCategory, ServerTickPhase, WorldPhase,
}
// use horizon_client::mod_api::{AttachmentResult, Attachments, Holder, LayerDefinition, Suggestion};
    // rust: pub(crate) use horizon_client::mod_api::{
    // rust: ClientboundPlayPacket, NativeBlockRim, NativeColoredLight, NativeLootDrops, NativeMinimap,
    // rust: NativeMod, NativePanelEvent, NativeScreen, NativeScreenView, NativeStack, NativeZoom,
}
// use horizon_client::{
    // rust: atlas_sources::qualified,
    // rust: biome::{BiomeColors, SpawnEntry},
    // rust: block_entities::Pos,
    // rust: chat::ChatSource,
    // rust: containers::{
    // rust: BlockEntity, MOD_MENUS, ModBlockEntity, ModBlockEntityFields, ModContainer,
    // rust: ModEnergyBuffer, ModFluidTanks,
    // rust: },
    // rust: crafting::{CustomRecipe, Ingredient, recipe_result},
    // rust: extras::Corner,
    // rust: extras_hud::Corners,
    // rust: fast_hash::FxHashMap,
    // rust: first_person::Hand,
    // rust: health::{HurtSource, Hurting, Knock},
    // rust: hud::{HudBatch, rgba},
    // rust: hud_layout::HealthHud,
    // rust: items::ItemStack,
    // rust: keybinds,
    // rust: lan::menu::Slots,
    // rust: merchant::MerchantOffer,
    // rust: mobs::{Damage, Who},
    // rust: mod_list::{self, Installed, NativePage},
    // rust: music::{Music, MusicLayer},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: text::Text,
    // rust: world_primitives::WorldPrimitives,
}
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::BlockPos,
    // rust: random::LegacyRandom,
    // rust: ticks::{ScheduleResult, TickPriority},
}
// use horizon_world::{
    // rust: consumable::UseAnimation,
    // rust: fluid::{FluidKind, FluidState},
    // rust: level::{BlockId, LevelAccess, PlacementContext, Ticks},
    // rust: nbt::Compound,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use std::{
    // rust: collections::HashMap,
    // rust: fs,
    // rust: path::{Path, PathBuf},
    // rust: sync::Arc,
    // rust: time::Duration,
}
// use winit::{event::MouseButton, keyboard::KeyCode};

    // rust: pub(super) struct ObservedScreen {
    // rust: id: &'static str,
    // rust: menu: Option<String>,
    // rust: title: Option<Text>,
    // rust: rect: [f32; 4],
    // rust: slots: usize,
    // rust: mouse: [f32; 2],
    // rust: partial_tick: f32,
}

    // rust: impl ObservedScreen {
pub fn view(self: *Self) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NativeScreenView {
    // rust: id: self.id,
    // rust: menu: self.menu.as_deref(),
    // rust: title: self.title.as_ref(),
    // rust: rect: self.rect,
    // rust: slots: self.slots,
    // rust: mouse: self.mouse,
    // rust: partial_tick: self.partial_tick,
}
}
}

pub fn observed_overlay_id(overlays: *[(bool) void {
}
    // rust: overlays.iter().find_map(|(open, id)| open.then_some(*id))
}

    // rust: impl Game<'_> {
pub fn observed_screen_view(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let book = match &self.book {
    // rust: Some(super::books::BookScreen::Edit { signing: true, .. }) => Some("book_sign"),
    // rust: Some(super::books::BookScreen::Edit { .. }) => Some("book_edit"),
    // rust: Some(super::books::BookScreen::View {
    // rust: lectern: Some(_), ..
    // rust: }) => Some("lectern"),
    // rust: Some(super::books::BookScreen::View { .. }) => Some("book_view"),
    // rust: None => None,
}
    // rust: let overlay = observed_overlay_id(&[
    // rust: (self.command_prompt.is_some(), "command_prompt"),
    // rust: (self.link_prompt.is_some(), "link_prompt"),
    // rust: (self.code_of_conduct.is_some(), "code_of_conduct"),
    // rust: (self.server_packs.prompt.is_some(), "server_pack_prompt"),
    // rust: (self.dialog_open(), "dialog"),
    // rust: (book.is_some(), book.unwrap_or("book_view")),
    // rust: (self.sign_edit.is_some(), "sign_editor"),
    // rust: ]);
    // rust: let Some(id) = overlay else {
    // rust: return self.screen_view_now();
}
    // rust: let renderer = self.renderer.as_ref()?;
    // rust: let batch = HudBatch::new([renderer.config.width, renderer.config.height]);
    // rust: Some(NativeScreenView {
    // rust: id,
    // rust: menu: None,
    // rust: title: None,
    // rust: rect: [0.0, 0.0, batch.width, batch.height],
    // rust: slots: 0,
    // rust: mouse: self.native_cursor(),
    // rust: partial_tick: self.clock.fraction() as f32,
    // rust: })
}

    // rust: pub(super) fn observe_screen(&mut self) {
        // Free with no native mod: the snapshot clones the title and menu.
    // rust: if mod_api::mods().is_empty() {
    // rust: return;
}
    // rust: let current = self.observed_screen_view().map(|view| ObservedScreen {
    // rust: id: view.id,
    // rust: menu: view.menu.map(str::to_owned),
    // rust: title: view.title.cloned(),
    // rust: rect: view.rect,
    // rust: slots: view.slots,
    // rust: mouse: view.mouse,
    // rust: partial_tick: view.partial_tick,
    // rust: });
    // rust: let changed = match (&self.observed_screen, &current) {
    // rust: (Some(old), Some(new)) => old.id != new.id || old.menu != new.menu,
    // rust: (None, None) => false,
    // rust: _ => true,
}
    // rust: if changed {
    // rust: if let Some(old) = &self.observed_screen {
    // rust: self.native_screen_closing(&old.view());
}
    // rust: if let Some(new) = &current {
    // rust: self.native_screen_opening(&new.view());
    // rust: self.native_screen_init_post(&new.view());
}
    // rust: } else if let (Some(old), Some(new)) = (&self.observed_screen, &current)
    // rust: && old.rect != new.rect
    // rust: {
    // rust: self.native_screen_init_post(&new.view());
}
    // rust: self.observed_screen = current;
}
}

/// `Level.setBlock`'s flags, for the `native_set_block_property` helpers:
/// `flags::UPDATE_CLIENTS` as a vanilla crop grows, `flags::UPDATE_ALL` as a
/// furnace sets its `lit`. Horizon sends every write to players, so
/// `UPDATE_CLIENTS`, `UPDATE_INVISIBLE` and `UPDATE_IMMEDIATE` change nothing
/// yet.
    // rust: pub(super) use horizon_world::level::flags;

/// The hook points' API version. The launcher reads this line from the
/// source it builds; keep its form.
    // rust: pub(crate) const NATIVE_HOOKS_API: u32 = 411;

    // rust: impl GameLevel<'_> {
    /// A hopper at `pos` is about to pick up `count` of `item`. Set `cancel` to leave the dropped stack in the world. Server-side. 232.
    // rust: pub(super) fn native_hopper_pickup_item(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: item: &str,
    // rust: count: u32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_hopper_pickup_item(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: item,
    // rust: count,
    // rust: cancel,
    // rust: );
}
    /// A broken block is about to drop `experience` points at `pos`. The
    /// vanilla block drop rule has been checked; change the amount before its
    /// orbs are awarded. Server-side. 190.
    // rust: pub(super) fn native_block_exp(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: block: &str,
    // rust: experience: &mut u32,
    // rust: ) {
    // rust: mod_api::dispatch_block_exp(self, mod_api::mods(), dimension, pos, block, experience);
}

    /// An authoritative server committed a changed state through `Level.setBlock`.
    /// The world contains `new`; block side effects and neighbour updates follow.
    // rust: pub(super) fn native_block_changed(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: old: BlockStateId,
    // rust: new: BlockStateId,
    // rust: ) {
    // rust: mod_api::dispatch_block_changed(self, mod_api::mods(), dimension, pos, old, new);
}

    /// A flowing fluid at `pos` is about to change level. `fluid` is `water`
    /// or `lava`; the levels are 0 through 8. Set `cancel` to keep the old
    /// level. Server-side. 226.
    // rust: pub(super) fn native_fluid_level_change(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: fluid: &str,
    // rust: from: i32,
    // rust: to: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_fluid_level_change(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: fluid,
    // rust: from,
    // rust: to,
    // rust: cancel,
    // rust: );
}

    /// A non-persistent leaf block at distance 7 is about to decay at `pos`.
    /// Set `cancel` to keep it. Server-side. 235.
    // rust: pub(super) fn native_leaves_decay(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_leaves_decay(self, mod_api::mods(), dimension, pos, cancel);
}

    /// Farmland at `pos` is about to change moisture from `from` to `to`.
    /// Set `cancel` to keep its old moisture. Server-side.
    /// 237.
    // rust: pub(super) fn native_moisture_change(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: from: i32,
    // rust: to: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_moisture_change(self, mod_api::mods(), dimension, pos, from, to, cancel);
}

    /// A sponge at `pos` absorbed water and became wet. Server-side.
    /// 297.
    // rust: pub(super) fn native_sponge_absorb(&self, dimension: LevelDimension, pos: BlockPos) {
    // rust: mod_api::dispatch_sponge_absorb(self, mod_api::mods(), dimension, pos);
}

    /// A block at `pos` is about to fade from `from` to `to` because of
    /// melting or coral death. Set `cancel` to keep it. Server-side.
    /// 191.
    // rust: pub(super) fn native_block_fade(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: from: BlockStateId,
    // rust: to: BlockStateId,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_fade(self, mod_api::mods(), dimension, pos, from, to, cancel);
}

    /// Precipitation is about to form or add to a block at `pos`. `from` and
    /// `to` are block state IDs. Set `cancel` to keep the old state. Server-side.
    /// 193.
    // rust: pub(super) fn native_block_form(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: from: BlockStateId,
    // rust: to: BlockStateId,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_form(self, mod_api::mods(), dimension, pos, from, to, cancel);
}

    /// The Ender Dragon fight is about to place its first dragon egg at `pos`.
    /// Set `cancel` to leave the block unchanged. Server-side. 208.
    // rust: pub(super) fn native_dragon_egg_form(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_dragon_egg_form(self, mod_api::mods(), dimension, pos, cancel);
}

    /// An authoritative server is about to deliver `neighborChanged`.
    /// State and block IDs are valid in this level's registries for this call.
    // rust: pub(super) fn native_neighbor_changed(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: changed: BlockId,
    // rust: moved: bool,
    // rust: ) {
    // rust: mod_api::dispatch_neighbor_changed(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: changed,
    // rust: moved,
    // rust: );
}

    /// On an authoritative server, a fluid flows or fire spreads from `from`
    /// into `to` (`kind` is `fluid` or `fire`): `FlowingFluid.spreadTo`, and
    /// `FireBlock.tick` setting fire to `to` or burning it (`checkBurnOut`).
    /// Set `canceled` to leave the block at `to` as it is. Fluids ask on
    /// every flow: answer fast. API 22.
    // rust: pub(super) fn native_block_spread(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: kind: &str,
    // rust: from: BlockPos,
    // rust: to: BlockPos,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_spread(self, mod_api::mods(), dimension, kind, from, to, canceled);
}

    /// On an authoritative server, fire is about to be placed at `pos` by
    /// flint and steel, a fire charge, lava, lightning or fire spread. Set
    /// `player` is the acting server player when there is one. Set `cancel` to
    /// leave the position unchanged. 194.
    // rust: pub(super) fn native_block_ignite(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: player: Option<u128>,
    // rust: pos: BlockPos,
    // rust: cause: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_ignite(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: player,
    // rust: pos,
    // rust: cause,
    // rust: cancel,
    // rust: );
}

    /// On an authoritative server, fire is about to burn the block at `pos`
    /// away. Set `cancel` to keep that block. 187.
    // rust: pub(super) fn native_block_burn(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_burn(self, mod_api::mods(), dimension, pos, cancel);
}

    /// A player is tuning a note block on the authoritative server, not in
    /// client prediction. `context` gives its dimension, position, instrument
    /// and old note; `new_note` starts as vanilla's cycled note. Set it to 0
    /// through 24; an out-of-range value keeps vanilla's. Cancel to leave the
    /// note unchanged and prevent playback. API 387.
    // rust: pub(super) fn native_note_block_change(
    // rust: &self,
    // rust: context: &NativeNoteBlockChange<'_>,
    // rust: new_note: &mut i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_note_block_change(self, mod_api::mods(), context, new_note, cancel);
}

    /// On an authoritative server, a note block at `pos` is about to sound.
    /// `player` is the acting server player when there is one. Set `cancel` to silence it.
    /// 248.
    // rust: pub(super) fn native_note_play(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: player: Option<u128>,
    // rust: pos: BlockPos,
    // rust: instrument: &str,
    // rust: note: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_note_play(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: player,
    // rust: pos,
    // rust: instrument,
    // rust: note,
    // rust: cancel,
    // rust: );
}

    /// On an authoritative server, a bell at `pos` is about to ring. Set
    /// `cancel` to stop the ring and its raider reveal. 185.
    // rust: pub(super) fn native_bell_ring(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: player: Option<u128>,
    // rust: pos: BlockPos,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_bell_ring(self, mod_api::mods(), dimension, player, pos, cancel);
}

    /// On an authoritative server, a cauldron at `pos` is about to change
    /// fill level from `from_level` to `to_level` for `reason`. Set `cancel`
    /// to leave it unchanged. 203.
    // rust: pub(super) fn native_cauldron_level_changed(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: player: Option<u128>,
    // rust: pos: BlockPos,
    // rust: from_level: i32,
    // rust: to_level: i32,
    // rust: reason: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_cauldron_level_changed(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: player,
    // rust: pos,
    // rust: from_level,
    // rust: to_level,
    // rust: reason,
    // rust: cancel,
    // rust: );
}

    /// On an authoritative server, the piston at `piston` is about to push
    /// the blocks at `push` one step `direction` (`[0, 1, 0]` is up; pulling
    /// when it retracts) and destroy those at `destroy`:
    /// `PistonBaseBlock.moveBlocks`, once its structure resolved. Set
    /// `canceled` and nothing moves, as when the structure can't; a sticky
    /// piston then retracts without its block, and clients are sent the
    /// blocks rather than the retraction to replay. API 22.
    // rust: pub(super) fn native_piston_move(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: piston: BlockPos,
    // rust: direction: [i32; 3],
    // rust: push: &[BlockPos],
    // rust: destroy: &[BlockPos],
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_piston_move(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: piston,
    // rust: direction,
    // rust: push,
    // rust: destroy,
    // rust: canceled,
    // rust: );
}
    /// The redstone signal the block `state` at `pos` gives on its `face`, the
    /// side that touches the block reading it: `BlockState.getDirectSignal`
    /// when `direct` (what passes through a block it touches, as a lever's
    /// does), else `getSignal`. `signal` holds vanilla's answer: change it when
    /// the block is yours (0 to 15; anything else is clamped). Asked very often,
    /// from inside the level's update, so answer from your own state: check the
    /// block first, and don't read or change the world here. When the answer
    /// changes, and once the block is placed, call
    /// `native_update_signal_neighbors`. Authoritative servers only. API 38.
    // rust: pub(super) fn native_block_signal(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: face: Direction,
    // rust: direct: bool,
    // rust: signal: &mut i32,
    // rust: ) {
    // rust: mod_api::dispatch_block_signal(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: face,
    // rust: direct,
    // rust: signal,
    // rust: );
}

    /// `BlockState.isSignalSource`: set `source` for a block of yours that
    /// gives a signal, so redstone wire beside it connects to it. Authoritative
    /// servers only. API 38.
    // rust: pub(super) fn native_is_signal_source(&self, state: BlockStateId, source: &mut bool) {
    // rust: mod_api::dispatch_is_signal_source(self, mod_api::mods(), state, source);
}

    /// `BlockState.hasAnalogOutputSignal`: set `output` for a block of yours
    /// that comparators read (how full or far along it is, as a composter's
    /// level), so they ask `native_analog_output`. Asked from inside the
    /// level's update: answer from `state` alone. Authoritative servers only.
    /// API 64.
    // rust: pub(super) fn native_has_analog_output(&self, state: BlockStateId, output: &mut bool) {
    // rust: mod_api::dispatch_has_analog_output(self, mod_api::mods(), state, output);
}

    /// `BlockState.getAnalogOutputSignal`: the signal a comparator reads from
    /// the block `state` at `pos`, `face` the side that touches the comparator
    /// (or the conductor in front of it). `output` holds vanilla's answer:
    /// change it when the block is yours (0 to 15; anything else is clamped).
    /// Asked only for blocks `native_has_analog_output` answered for, from
    /// inside the level's update: don't change the world here. When the
    /// answer changes without the block's state changing, call
    /// `native_update_output_neighbors`; a change of state through
    /// `native_set_block` or `native_set_block_property` (neighbour updates
    /// on) tells the comparators itself, as vanilla's `Level.setBlock` does.
    /// Authoritative servers only. API 64.
    // rust: pub(super) fn native_analog_output(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: face: Direction,
    // rust: output: &mut i32,
    // rust: ) {
    // rust: mod_api::dispatch_analog_output(self, mod_api::mods(), dimension, pos, state, face, output);
}

    /// An authoritative server's `ServerLevel.tickChunk` is about to
    /// random-tick the block `state` at `pos` (`BlockState.randomTick`):
    /// only blocks that tick randomly, a mod's as its vanilla template block
    /// does. Bone meal's random ticks (`StemBlock.performBonemeal`) don't
    /// fire it. Change the block with `native_set_block_property` and set
    /// `handled` to skip the block's own random tick (a mod crop growing its
    /// own way); a block changed without `handled` takes its own random tick
    /// as it is now, if it still ticks randomly. Lava's fluid random tick
    /// runs either way.
    // rust: pub(super) fn native_random_tick(
    // rust: &mut self,
    // rust: ticks: &mut Ticks,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: handled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_random_tick(
    // rust: &mut super::mod_api_host::LevelTicks { level: self, ticks },
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: handled,
    // rust: );
}

    /// An authoritative server is about to compute the state the block
    /// `state` at `pos` takes now that its neighbour in `direction` is
    /// `neighbour` (`BlockBehaviour.updateShape`). `state` may not be in the
    /// world yet (a piston landing it): decide from `state`, not from the
    /// block at `pos`. Answer only for your own blocks: put the new state in
    /// `new` (`state` keeps the block as it is; air breaks it, with its drops,
    /// on a neighbour update) and the block's own `updateShape` doesn't run,
    /// nor the ticks it would schedule. The level is read-only, as vanilla's
    /// `LevelReader`; ticks go through `native_schedule_block_tick` and
    /// `native_schedule_fluid_tick` with `ticks` (`ScheduledTickAccess`). It
    /// runs often, at least six times per `setBlock` that updates shapes
    /// (more for redstone wire's diagonals and knock-on updates): keep it
    /// short.
    // rust: pub(super) fn native_update_shape(
    // rust: &self,
    // rust: ticks: &mut Ticks,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: direction: Direction,
    // rust: neighbour_pos: BlockPos,
    // rust: neighbour: BlockStateId,
    // rust: new: &mut Option<BlockStateId>,
    // rust: ) {
    // rust: mod_api::dispatch_update_shape(
    // rust: &mut super::mod_api_host::LevelTicks { level: self, ticks },
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: direction,
    // rust: neighbour_pos,
    // rust: neighbour,
    // rust: new,
    // rust: );
}

    /// On an authoritative server, `BlockState.canSurvive` for `state` at
    /// `pos` (`BlockBehaviour.canSurvive`), before the block answers it: as
    /// it is placed (`BlockItem.canPlace`), from a shape update of a block
    /// whose template checks it (a plant, a torch, a sign: false breaks the
    /// block with its drops), and wherever else vanilla asks. `state` may not
    /// be in the world yet, so decide from `state`. Answer only for your own
    /// blocks: `Some(false)` refuses the spot, `Some(true)` allows it, and
    /// the block's own rule doesn't run. The level is read-only. Asked on
    /// every shape update of such a block: keep it short. API 70.
    // rust: pub(super) fn native_can_survive(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: survives: &mut Option<bool>,
    // rust: ) {
    // rust: mod_api::dispatch_can_survive(self, mod_api::mods(), dimension, pos, state, survives);
}

    /// On an authoritative server, `VegetationBlock.mayPlaceOn` for the
    /// plant `state` on `ground` at `ground_pos`, before the plant answers
    /// it: the blocks a mod plant (one whose template is a vanilla plant,
    /// such as a crop) can stand on. Its template's `canSurvive` asks it, so
    /// the plant is refused there and pops off when its ground changes to
    /// one it can't stand on. Answer only for your own blocks. The level is
    /// read-only. API 70.
    // rust: pub(super) fn native_may_place_on(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: state: BlockStateId,
    // rust: ground: BlockStateId,
    // rust: ground_pos: BlockPos,
    // rust: may: &mut Option<bool>,
    // rust: ) {
    // rust: mod_api::dispatch_may_place_on(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: state,
    // rust: ground,
    // rust: ground_pos,
    // rust: may,
    // rust: );
}

    /// An authoritative server's `ServerLevel.tickBlock` is about to run a
    /// due scheduled tick of the block `state` at `pos` (`BlockState.tick`):
    /// the block is still the one the tick was scheduled for. Change the
    /// block with `native_set_block_property` and set `handled` to skip the
    /// block's own tick; a block changed without `handled` takes its own
    /// tick as it is now, if it is still the tick's block.
    // rust: pub(super) fn native_tick_block(
    // rust: &mut self,
    // rust: ticks: &mut Ticks,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: handled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_tick_block(
    // rust: &mut super::mod_api_host::LevelTicks { level: self, ticks },
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: handled,
    // rust: );
}

    /// A block is about to take the state it is placed in
    /// (`Block.getStateForPlacement(BlockPlaceContext)`), `state` the block's
    /// own default state. Answer only for your blocks: put the state you want
    /// in `answer` as `Some(Some(state))` — a state of that block, as vanilla
    /// sets properties on its own `defaultBlockState` (another block's is
    /// ignored) — or refuse the placement with `Some(None)`: the block goes
    /// nowhere and the stack is kept, as vanilla's `null`. Left empty, the
    /// block's own placement runs. `context` is
    /// vanilla's `BlockPlaceContext` (the clicked face, the placer's rotation,
    /// the clicked position, whether the clicked block is being replaced, the
    /// item in hand) and `fluid` the fluid in the position the block would go
    /// in, which a waterlogged block reads. Build the state from `state` with
    /// `native_state_with_property`, and know whether `state` is yours with
    /// `native_state_block`. It is asked for every placer that goes
    /// through vanilla's placement (a player's `BlockItem.place`, a
    /// dispenser's `DirectionalPlaceContext`), and the answer still takes its
    /// survival and entity obstruction checks. A trait mod returns
    /// `Some(Some(state))` to choose a state, `Some(None)` to refuse, or
    /// `None` to leave the answer to the next mod or vanilla.
    /// Authoritative servers only. 76.
    // rust: pub(super) fn native_state_for_placement(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: state: BlockStateId,
    // rust: context: &PlacementContext,
    // rust: fluid: FluidState,
    // rust: answer: &mut Option<Option<BlockStateId>>,
    // rust: ) {
    // rust: mod_api::dispatch_state_for_placement(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: state,
    // rust: context,
    // rust: fluid,
    // rust: answer,
    // rust: );
}

    /// A block nothing in Horizon knows a `BonemealableBlock` for is about to
    /// take bone meal: vanilla's `BonemealableBlock.isValidBonemealTarget`,
    /// `state` the block's own state at `pos`. Answer `valid` for your own
    /// blocks: the meal is used up on one as vanilla uses it up (the growth
    /// particles and the sound follow, whether or not the roll below grows
    /// it), from a player's `BoneMealItem.useOn`, from a dispenser and, on a
    /// crop (a villager bonemeals only a `CropBlock`), from a villager. Asked
    /// on both sides, as vanilla asks it on both, so a client predicts the
    /// use with your answer: say no where you can only grow on a server
    /// (`is_client_side`). `Some(false)` refuses the meal, even on a block
    /// whose template takes it (vanilla's `growCrop` then keeps the meal);
    /// left `None`, the block keeps the `BonemealableBlock` its template gives
    /// it, or takes no bone meal.
    /// 72.
    // rust: pub(super) fn native_is_valid_bonemeal_target(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: valid: &mut Option<bool>,
    // rust: ) {
    // rust: mod_api::dispatch_is_valid_bonemeal_target(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: valid,
    // rust: );
}

    /// `BonemealableBlock.isBonemealSuccess` for a block that answered
    /// `native_is_valid_bonemeal_target`, after it did: set `success` to grow
    /// it this time. Vanilla draws the level's random here
    /// (`isBonemealSuccess(Level, RandomSource, BlockPos, BlockState)`), so
    /// draw from `native_level_random` to keep vanilla's order.
    /// Authoritative servers only. 72.
    // rust: pub(super) fn native_is_bonemeal_success(
    // rust: &mut self,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: success: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_is_bonemeal_success(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: success,
    // rust: );
}

    /// `BonemealableBlock.performBonemeal` for a block that answered
    /// `native_is_valid_bonemeal_target` and whose `native_is_bonemeal_success`
    /// said yes: grow it here, `state` its state at `pos`. The meal is used up
    /// either way. Change the block with the level's
    /// `native_set_block_property`, and schedule with `native_schedule_block_tick`
    /// (`ticks` is the hook's). Authoritative servers only. 72.
    // rust: pub(super) fn native_perform_bonemeal(
    // rust: &mut self,
    // rust: ticks: &mut Ticks,
    // rust: dimension: LevelDimension,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: mod_api::dispatch_perform_bonemeal(
    // rust: &mut super::mod_api_host::LevelTicks { level: self, ticks },
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: state,
    // rust: );
}

    /// On an authoritative server, how fire treats the block `state`
    /// (`FireBlock.setFlammable(block, igniteOdds, burnOdds)`): put
    /// `(ignite, burn)` in `odds` for your own blocks, and vanilla's table
    /// isn't read. Ignite odds above zero let fire stand beside the block and
    /// spread into the air around it (planks 5, wool 30, leaves 30); burn odds
    /// are how fast fire destroys it (planks 20, wool 60, leaves 60). `(0, 0)`
    /// never burns; keep both within vanilla's 0 to 100. A waterlogged state
    /// never burns and isn't asked. Answer only for your own blocks and leave
    /// `odds` empty otherwise; the level is read-only. Asked hundreds of times
    /// per fire tick: keep it short. API 157.
    // rust: pub(super) fn native_fire_odds(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: state: BlockStateId,
    // rust: odds: &mut Option<(i32, i32)>,
    // rust: ) {
    // rust: mod_api::dispatch_fire_odds(self, mod_api::mods(), dimension, state, odds);
}

    /// On an authoritative server, `CampfireBlock.isSmokeSource` for the
    /// block `state` under a campfire, as the campfire is placed or the block
    /// under it changes: `Some(true)` for your own blocks makes the campfire a
    /// signal fire whose smoke rises higher, as over a hay bale. The level is
    /// read-only. API 157.
    // rust: pub(super) fn native_smoke_source(
    // rust: &self,
    // rust: dimension: LevelDimension,
    // rust: state: BlockStateId,
    // rust: smoke: &mut Option<bool>,
    // rust: ) {
    // rust: mod_api::dispatch_smoke_source(self, mod_api::mods(), dimension, state, smoke);
}
}

/// The camera shake native mods ask for (`native_camera_shake`): turns in
/// degrees, and an offset in blocks along the camera's right, up and back.
pub const NativeShake = struct {
    pitch: f32,
    yaw: f32,
    roll: f32,
    offset: [f32,
};

/// A mod's camera (`native_camera_pose`): each value that isn't finite keeps vanilla's from `view`.
    // rust: fn posed_camera(
    // rust: view: (glam::DVec3, f32, f32),
    // rust: position: [f64; 3],
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: ) -> (glam::DVec3, f32, f32) {
    // rust: let position = std::array::from_fn(|i| {
    // rust: if position[i].is_finite() {
    // rust: position[i]
    // rust: } else {
    // rust: view.0[i]
}
    // rust: });
    // rust: (
    // rust: glam::DVec3::from_array(position),
    // rust: if yaw.is_finite() { yaw } else { view.1 },
    // rust: if pitch.is_finite() { pitch } else { view.2 },
    // rust: )
}

/// The largest turn a shake gives, in degrees, on each axis.
pub const SHAKE_MAX_DEGREES: f32 = 10.0;
/// The largest offset a shake gives, in blocks, along each axis.
pub const SHAKE_MAX_OFFSET: f32 = 0.5;

/// The pose a native mod asks for the first-person hand, each out-of-range
/// or non-finite component replaced by its identity.
    // rust: pub(super) fn hand_pose_matrix(values: [f32; 7]) -> glam::Mat4 {
    // rust: let valid = |value: f32, min: f32, max: f32, default: f32| {
    // rust: if value.is_finite() && (min..=max).contains(&value) {
    // rust: value
    // rust: } else {
    // rust: default
}
}
    // rust: let [x, y, z, pitch, yaw, roll, scale] = values;
    // rust: glam::Mat4::from_translation(glam::Vec3::new(
    // rust: valid(x, -16.0, 16.0, 0.0),
    // rust: valid(y, -16.0, 16.0, 0.0),
    // rust: valid(z, -16.0, 16.0, 0.0),
    // rust: )) * glam::Mat4::from_rotation_x(valid(pitch, -3600.0, 3600.0, 0.0).to_radians())
    // rust: * glam::Mat4::from_rotation_y(valid(yaw, -3600.0, 3600.0, 0.0).to_radians())
    // rust: * glam::Mat4::from_rotation_z(valid(roll, -3600.0, 3600.0, 0.0).to_radians())
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(valid(scale, 0.01, 100.0, 1.0)))
}

/// `shake` scaled by `scale` (Distortion Effects) and bounded on each axis;
/// a value that isn't finite counts as none.
pub fn bounded_shake(shake: NativeShake, scale: f32) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let scale = if scale.is_finite() {
    // rust: scale.clamp(0.0, 1.0)
    // rust: } else {
    // rust: 1.0
}
    // rust: let turn = |v: f32| {
    // rust: if v.is_finite() {
    // rust: (v * scale).clamp(-SHAKE_MAX_DEGREES, SHAKE_MAX_DEGREES)
    // rust: } else {
    // rust: 0.0
}
}
    // rust: let shift = |v: f32| {
    // rust: if v.is_finite() {
    // rust: (v * scale).clamp(-SHAKE_MAX_OFFSET, SHAKE_MAX_OFFSET)
    // rust: } else {
    // rust: 0.0
}
}
    // rust: NativeShake {
    // rust: pitch: turn(shake.pitch),
    // rust: yaw: turn(shake.yaw),
    // rust: roll: turn(shake.roll),
    // rust: offset: shake.offset.map(shift),
}
}

/// The pose a bounded shake multiplies into the projection, after the view
/// bobbing: the offset, then roll, pitch and yaw.
pub fn shake_pose(shake: NativeShake) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = shake.offset;
    // rust: glam::Mat4::from_translation(glam::Vec3::new(-x, -y, -z))
    // rust: * glam::Mat4::from_rotation_z(shake.roll.to_radians())
    // rust: * glam::Mat4::from_rotation_x(shake.pitch.to_radians())
    // rust: * glam::Mat4::from_rotation_y(shake.yaw.to_radians())
}

/// The mod screen open on this client: the block it is for, the key its
/// slots are under, the window id of its menu, the menu's data slots as
/// the server sent them, and what the server sent before the menu opened
/// (`horizon:menu_extra`), when it did.
    // rust: pub(super) struct OpenNativeScreen {
    // rust: key: Pos,
    // rust: window: i32,
    // rust: block: String,
    // rust: screen: NativeScreen,
    // rust: data: Vec<i32>,
    // rust: extra: Option<horizon_protocol::menu_extra::Message>,
}

    // rust: impl OpenNativeScreen {
    /// The block the menu is of: where the server said, else the clicked
    /// block its slots are under (a server without `horizon:menu_extra`).
pub fn pos(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.extra {
    // rust: Some(extra) => Some(extra.pos),
    // rust: None if self.key.0 != i32::MIN => Some([self.key.0, self.key.1, self.key.2]),
    // rust: None => None,
}
}
    /// Data slot `id` of window `window`'s menu: false for another window's
    /// (an old or replaced one), which this screen leaves alone.
pub fn set_data(self: *Self, window: i32, id: i16, value: i16) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if window != self.window {
    // rust: return false;
}
        // A menu's data slot ids are small; a bad one is dropped.
    // rust: if let Ok(i @ 0..256) = usize::try_from(id) {
    // rust: if self.data.len() <= i {
    // rust: self.data.resize(i + 1, 0);
}
    // rust: self.data[i] = i32::from(value);
}
    // rust: true
}
}

/// The player as a native mod reads it.
pub const NativePlayer = struct {
    x: f64,
    y: f64,
    z: f64,
    /// Degrees; 0 faces south, 90 west (`Direction.fromYRot`).
    yaw: f32,
    pitch: f32,
    /// `minecraft:overworld`, `minecraft:the_nether`, `minecraft:the_end`.
    dimension: *'static str,
};

/// The world's clock as a client mod reads it (`native_clock`).
pub const NativeClock = struct {
    /// Ticks since the world was created (`Level.getGameTime`).
    game_time: i64,
    /// The time of day in ticks (`Level.getOverworldClockTime`): 0 at sunrise, 24000 a
    /// day. It keeps counting past 24000 (`/time add`, days going by), so take
    /// it modulo 24000 for the hour; `/time set` can make it negative.
    day_time: i64,
};

/// How the panel lays out a recipe of `native_panel_recipes`.
    // rust: pub(crate) enum NativeRecipeLayout {
    /// A crafting grid of `width` x `height` slots, an arrow and the result.
    // rust: Grid,
    /// One input over a flame, an arrow and the result (furnaces, smokers,
    /// campfires).
    // rust: Cooking,
    /// One input, an arrow and the result (the stonecutter).
    // rust: Single,
    /// Template, base and addition, an arrow and the result.
    // rust: Smithing,
    /// A potion and an ingredient, an arrow and the result.
    // rust: Brewing,
}

/// A recipe the panel shows (`native_panel_recipes`). Each slot, and the
/// result, cycles through its stacks, one a second; an empty slot shows
/// nothing.
    // rust: pub(crate) struct NativeRecipeView {
    // rust: pub(crate) layout: NativeRecipeLayout,
    /// The grid's size (`Grid` only), at most 3 x 3.
    // rust: pub(crate) width: u32,
    // rust: pub(crate) height: u32,
    // rust: pub(crate) slots: Vec<Vec<NativeStack>>,
    // rust: pub(crate) results: Vec<NativeStack>,
    /// A short line under the recipe (a cooking time), or "".
    // rust: pub(crate) note: String,
    /// The action button beside it: none, enabled, or shown greyed.
    // rust: pub(crate) action: Option<bool>,
}

/// An item of [`NativeRecipes::items`], by its index there, with a count
/// and the components it has beyond the item's own, in vanilla's item
/// syntax (`[minecraft:potion_contents={potion:"minecraft:swiftness"}]`),
/// or "".
    // rust: pub(crate) struct NativeRecipeStack {
    // rust: pub(crate) item: u32,
    // rust: pub(crate) count: u32,
    // rust: pub(crate) components: String,
}

/// The station a recipe is made at.
    // rust: pub(crate) enum NativeRecipeKind {
    // rust: CraftingShaped,
    // rust: CraftingShapeless,
    // rust: Smelting,
    // rust: Blasting,
    // rust: Smoking,
    // rust: Campfire,
    // rust: Stonecutting,
    // rust: Smithing,
    // rust: Brewing,
}

/// A recipe of [`NativeRecipes`].
    // rust: pub(crate) struct NativeRecipe {
    /// `minecraft:oak_planks`.
    // rust: pub(crate) id: String,
    // rust: pub(crate) kind: NativeRecipeKind,
    /// The recipe book's tab (`crafting_building_blocks`, `furnace_food`),
    /// or "".
    // rust: pub(crate) category: String,
    /// Recipes the book shows on one button share a group, or "".
    // rust: pub(crate) group: String,
    /// A shaped recipe's grid: `slots` holds its cells row by row. 0 for
    /// the other kinds.
    // rust: pub(crate) width: u32,
    // rust: pub(crate) height: u32,
    /// Each slot's stacks, any one of which fits; an empty list is an empty
    /// cell. Cooking and stonecutting: the input. Smithing: the template,
    /// the base, the addition. Brewing: the bottle, the reagent.
    // rust: pub(crate) slots: Vec<Vec<NativeRecipeStack>>,
    /// What it makes; several when that varies (a trim on any armour).
    // rust: pub(crate) results: Vec<NativeRecipeStack>,
    /// Cooking: game ticks and experience; 0 for the other kinds.
    // rust: pub(crate) cooking_time: u32,
    // rust: pub(crate) experience: f32,
    /// The recipe book's id for it (one per way the book shows it), as
    /// `native_known_recipes` lists them; -1 for the kinds the book doesn't
    /// show (campfire, stonecutting, smithing, brewing).
    // rust: pub(crate) book_id: i32,
}

/// An item of [`NativeRecipes::items`].
    // rust: pub(crate) struct NativeItem {
    /// `minecraft:diamond`, `<mod>:<path>`.
    // rust: pub(crate) id: String,
    /// In the player's language.
    // rust: pub(crate) name: String,
    /// Its item tags, without the `#`.
    // rust: pub(crate) tags: Vec<String>,
}

/// Every item and recipe the game knows (`native_recipes`): `items` in the
/// registry's order, which each [`NativeRecipeStack::item`] indexes; the
/// recipes are the book's in its order, then campfire, stonecutting,
/// smithing and brewing.
    // rust: pub(crate) struct NativeRecipes {
    // rust: pub(crate) items: Vec<NativeItem>,
    // rust: pub(crate) recipes: Vec<NativeRecipe>,
}

/// The mappings `native_mapping` answers for, with the key their default
/// binding is (none: a mouse button, attack or use).
    // rust: const MAPPINGS: [(&str, Option<KeyCode>); 9] = [
    // rust: ("key.forward", Some(KeyCode::KeyW)),
    // rust: ("key.left", Some(KeyCode::KeyA)),
    // rust: ("key.back", Some(KeyCode::KeyS)),
    // rust: ("key.right", Some(KeyCode::KeyD)),
    // rust: ("key.jump", Some(KeyCode::Space)),
    // rust: ("key.sneak", Some(KeyCode::ShiftLeft)),
    // rust: ("key.sprint", Some(KeyCode::ControlLeft)),
    // rust: ("key.attack", None),
    // rust: ("key.use", None),
    // rust: ];

/// What a `ScreenEvent.CharacterTyped.Pre` leaves of `text`, given `canceled`
/// (whether a hook cancelled character `c`): the cancelled printable
/// characters are gone and every other character stays, control characters
/// included — a text box reads Backspace, Delete or Escape as keys and vanilla
/// fires no `charTyped` for them, so they are never offered to the hook.
/// `None` when nothing is left to type.
pub fn screen_text_hooked(text: []const u8, mut canceled: impl FnMut(char) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut left = String::with_capacity(text.len());
    // rust: for c in text.chars() {
    // rust: if !c.is_control() && canceled(c) {
    // rust: continue;
}
    // rust: left.push(c);
}
    // rust: if left.is_empty() && !text.is_empty() {
    // rust: return None;
}
    // rust: Some(left)
}

/// What a key press's characters leave for a text box after the
/// `ScreenEvent.CharacterTyped.Pre` hook: the characters no mod cancelled,
/// control ones gone (the key's own handling takes those, and vanilla fires
/// no `charTyped` for them). `None` when nothing is left to type.
pub fn chars_to_type(text: []const u8, canceled: impl FnMut(char) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let left = screen_text_hooked(text, canceled)?;
    // rust: let text: String = left.chars().filter(|c| !c.is_control()).collect();
    // rust: (!text.is_empty()).then_some(text)
}

/// The hook points. Each does nothing in Horizon.
    // rust: impl Game<'_> {
    /// Client initialization, before any outgoing connection; a window need not exist yet.
    // rust: pub(super) fn native_client_start(&mut self) {
    // rust: mod_api::dispatch_client_start(self, mod_api::mods());
}
    /// Before an actual connection is discarded, not on a dimension change.
    // rust: pub(super) fn native_client_disconnecting(&self) {
    // rust: mod_api::dispatch_client_disconnecting(self, mod_api::mods());
}
    /// Once before this client's final save/exit. A mod can flush and join its worker here.
    // rust: pub(super) fn native_client_stopping(&self) {
    // rust: mod_api::dispatch_client_stopping(self, mod_api::mods());
}
    /// The normal menu blur request, before finite/range validation. None disables it.
    // rust: pub(super) fn native_menu_background(&self, radius: &mut Option<f32>) {
    // rust: mod_api::dispatch_menu_background(self, mod_api::mods(), radius);
}
    /// Declare categories for custom recipe types, with registered item icons.
    /// Asked lazily once per recipe table by `native_recipe_book_category`.
    /// Invalid declarations are logged and skipped; the first valid category
    /// owns its id and type. This does not yet add tabs or book displays.
    // rust: pub(super) fn native_recipe_book_categories(&self, categories: &mut Vec<RecipeBookCategory>) {
    // rust: mod_api::dispatch_recipe_book_categories(self, mod_api::mods(), categories);
}
    /// Once a frame, in a world or not, after Horizon's extras.
    // rust: pub(super) fn native_frame(&mut self, elapsed: Duration) {
    // rust: mod_api::dispatch_frame(self, mod_api::mods(), elapsed);
}
    /// Client-side evaluation of a mod's namespaced conditional item model property.
    /// Set value only for a property your mod owns; unhandled properties stay false.
    /// The borrowed stack is the one being resolved, including nested bundle items.
    // rust: pub(super) fn native_item_model_property(
    // rust: &self,
    // rust: property: &str,
    // rust: stack: &StackView,
    // rust: value: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_item_model_property(self, mod_api::mods(), property, stack, value);
}
    /// The frame rate this window is about to be held to: Max Framerate after the
    /// inactivity throttle and Battery Mode (260 is unlimited). `focused` is whether the
    /// window has focus, `minimized` whether it is minimised and `in_world` whether a world
    /// is open. A mod may lower `limit`, as Dynamic FPS does for a window in the background:
    /// Horizon keeps the lower of its own limit and the mod's, and ignores values below 1.
    /// API 167.
    // rust: pub(super) fn native_framerate_limit(
    // rust: &self,
    // rust: focused: bool,
    // rust: minimized: bool,
    // rust: in_world: bool,
    // rust: limit: &mut i32,
    // rust: ) {
    // rust: mod_api::dispatch_framerate_limit(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: focused,
    // rust: minimized,
    // rust: in_world,
    // rust: limit,
    // rust: );
}
    /// Render-thread notification after a resource-pack reload has applied successfully.
    /// Atlas, models, renderer and client caches already refer to the new resources.
    /// Selection/F3+T and server-pack reloads share this point; initial startup does not.
    // rust: pub(super) fn native_client_resources_reloaded(&mut self) {
    // rust: mod_api::dispatch_client_resources_reloaded(self, mod_api::mods());
}
    /// The client made a new level for `dimension` (NeoForge's
    /// `LevelEvent.Load` from the `ClientLevel` constructor): on joining a
    /// server, single player's own included, and on changing dimension.
    /// Its chunks come after. When the dimension changes, the old level's
    /// `native_client_level_unload` follows this, as `Minecraft.setLevel`
    /// tells it after the new level is made. Client-side, on the window; the
    /// server's levels have `native_level_load`. API 135.
    // rust: pub(super) fn native_client_level_load(&mut self, dimension: &str) {
    // rust: mod_api::dispatch_client_level_load(self, mod_api::mods(), dimension);
}
    /// The client dropped its level for `dimension` (`LevelEvent.Unload`
    /// from `Minecraft.setLevel` and `disconnect`): replaced by another
    /// dimension's, or on leaving the server. Once for each
    /// `native_client_level_load`. Not told when the game itself quits.
    /// Client-side. API 135.
    // rust: pub(super) fn native_client_level_unload(&mut self, dimension: &str) {
    // rust: mod_api::dispatch_client_level_unload(self, mod_api::mods(), dimension);
}
    /// Once a tick, in every `Game`: the window's (in single player, on LAN
    /// and on servers), and the server's own (`native_window` is false
    /// there: the single player server thread, a dedicated server).
    // rust: pub(super) fn native_tick(&mut self) {
    // rust: mod_api::dispatch_tick(self, mod_api::mods());
}
    /// Before an eligible targeted block's selection outline is built.
    /// Cancel skips only the default block highlight, after normal HUD and game-mode gates.
    // rust: pub(super) fn native_block_highlight(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: partial: f32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_highlight(self, mod_api::mods(), pos, state, partial, canceled);
}
    /// The world frame's local visual sources. Push requests; Horizon validates
    /// and limits them before rendering, each mod within its own budget (256
    /// rims and 4096 rim edges, 8 lights). Called only while a world is visible.
    // rust: pub(super) fn native_visuals(
    // rust: &self,
    // rust: rims: &mut Vec<NativeBlockRim>,
    // rust: lights: &mut Vec<NativeColoredLight>,
    // rust: ) {
        // Each trait mod fills lists of its own, bounded on their own; what is already
        // here, from bundles' injections, shares one budget.
    // rust: let (mut own_rims, mut own_lights) = (std::mem::take(rims), std::mem::take(lights));
    // rust: self.budget_visuals(&mut own_rims, &mut own_lights, rims, lights);
    // rust: let mods = mod_api::mods();
    // rust: for index in 0..mods.len() {
    // rust: let one = &mods[index..=index];
    // rust: mod_api::dispatch_visuals(self, one, &mut own_rims, &mut own_lights);
    // rust: self.budget_visuals(&mut own_rims, &mut own_lights, rims, lights);
}
}
    /// At most 32 pairs of already-loaded base and transparent overlay sprites.
    /// Per-pixel alpha in the overlay marks full-bright material, without
    /// illuminating the surrounding block or changing gameplay light.
    // rust: pub(super) fn native_emissive(&self, layers: &mut Vec<(&'static str, &'static str)>) {
    // rust: mod_api::dispatch_emissive(self, mod_api::mods(), layers);
}
    /// The world's phases, read-only; `error_text` carries the engine's
    /// own open-failure text, empty otherwise. Server-side. A server loop or final
    /// save failure fires `WorldCloseFailed` with the error text.
    // rust: pub(super) fn native_world_lifecycle(
    // rust: &mut self,
    // rust: context: &NativeLifecycleContext,
    // rust: phase: WorldPhase,
    // rust: error_text: &str,
    // rust: ) {
    // rust: mod_api::dispatch_world_lifecycle(self, mod_api::mods(), context, phase, error_text);
}
    /// The server is about to send its data to the players (NeoForge's
    /// `OnDatapackSyncEvent`, its `sendRecipes`): push the recipe types
    /// (`minecraft:smelting`, `mymod:crusher`) whose recipes your client half
    /// needs. Horizon sends their final recipes — the world's data packs
    /// merged, load conditions held — to every Horizon client when it joins
    /// and again after each `/reload`; a vanilla client is sent nothing new.
    /// Asked once per load, when the server's data tables are built, and the
    /// same types go to every player: unlike NeoForge, which asks again for
    /// each joining player, it can't differ between players. Push nothing and
    /// nothing is sent; push nothing after a load that pushed some and the
    /// clients go back to their own recipes. Server-side (the single
    /// player's integrated server included). API 120.
    // rust: pub(super) fn native_datapack_sync(&mut self, recipe_types: &mut Vec<String>) {
    // rust: mod_api::dispatch_datapack_sync(self, mod_api::mods(), recipe_types);
}
    /// The server's recipes of `recipe_types` arrived (NeoForge's
    /// `RecipesReceivedEvent`): from now on the recipe helpers
    /// (`native_recipes`, `native_recipes_of_type`) give the server's recipes
    /// of those types in place of the window's own, so rebuild what you made
    /// of them. It comes after a join, once the window has its player, and
    /// after every `/reload`, on a server whose mods asked for them
    /// (`native_datapack_sync`), single player included; with no types when
    /// the server stopped sending them and the window is back on its own
    /// recipes. A recipe the
    /// window's own recipe book doesn't know has `book_id` -1. Client-side.
    /// API 120.
    // rust: pub(super) fn native_recipes_received(&mut self, recipe_types: &[String]) {
    // rust: mod_api::dispatch_recipes_received(self, mod_api::mods(), recipe_types);
}
    /// The server's data tables are built (NeoForge's `TagsUpdatedEvent`
    /// with `SERVER_DATA_LOAD`): the recipes, tags, loot and advancements of
    /// the world's data packs, and the files mods added through
    /// `native_data_pack_files`, are what the helpers read from now on.
    /// `reload` is false on a world's first open, before its chunks and
    /// players are loaded, and true after `/reload` rebuilt them, once the
    /// players were sent the new data. The place to
    /// drop caches derived from the data and to rebind what depends on it.
    /// Server-side (the single player's integrated server included); a client
    /// connected to a server never fires it. API 108.
    // rust: pub(super) fn native_server_data_loaded(&mut self, reload: bool) {
    // rust: mod_api::dispatch_server_data_loaded(self, mod_api::mods(), reload);
}
    /// The folders of JSON files native mods read from the data
    /// (`AddServerReloadListenersEvent`): push yours, each a listener id and a
    /// folder under `data/<namespace>/`. Asked at the start of every data load
    /// of a server: a world opening, `/reload`. A folder that leaves
    /// `data/<namespace>/` is skipped. API 400.
    // rust: pub(super) fn native_add_server_reload_listeners(
    // rust: &mut self,
    // rust: listeners: &mut Vec<NativeReloadListener>,
    // rust: ) {
    // rust: mod_api::dispatch_add_server_reload_listeners(self, mod_api::mods(), listeners);
}
    /// A listener's files were read (`SimpleJsonResourceReloadListener`'s
    /// `apply`): `files` holds `<namespace>:<path>` (the file's path under
    /// the folder, without `.json`) and its JSON, sorted by id, from the
    /// resource root (vanilla's and content mods' data) and the world's enabled
    /// data packs; for each id the top pack's file, and a file that isn't JSON
    /// is logged and left out. Every mod hears every listener, so check
    /// `listener.id`. Fired on each data load before `native_server_data_loaded`.
    /// Server-side. API 400.
    // rust: pub(super) fn native_server_reload_listener_apply(
    // rust: &mut self,
    // rust: listener: &NativeReloadListener,
    // rust: files: &[(String, serde_json::Value)],
    // rust: ) {
    // rust: mod_api::dispatch_server_reload_listener_apply(self, mod_api::mods(), listener, files);
}
    /// The server is assembling its data tables from the world's data packs
    /// (`ReloadableServerResources`): a world is opening, or `/reload` was
    /// run, and the recipes, tags, loot and advancements are built after
    /// this. Push `(path, bytes)` pack files and they join this load. `path`
    /// is the overlay's key, `<kind>/<namespace>:<path>` without `.json`, over
    /// the kinds the tables read: `recipe/mymod:thing`,
    /// `tags/mymod:block/thing`, `loot_table/…`, `advancement/…`,
    /// `trade_set/…`, `villager_trade/…`, `dialog/…`. A file that isn't JSON
    /// is skipped with a warning. Asked once per load on both paths, so this
    /// is where a mod recomputes them.
    /// Contributed files sit below the world's own data packs: a pack's file
    /// for the same path still overrides a mod's. Server-side (the single
    /// player's integrated server included). API 106.
    // rust: pub(super) fn native_data_pack_files(&self, files: &mut Vec<(String, Vec<u8>)>) {
    // rust: mod_api::dispatch_data_pack_files(self, mod_api::mods(), files);
}
    /// The server is assembling its data tables, as for
    /// `native_data_pack_files` (a world's first open and every `/reload`):
    /// push the data map types your mod registers (NeoForge's
    /// `RegisterDataMapTypesEvent`). A type is an `id` (`mod_id:name`, not in
    /// `minecraft`) for a `registry`, `minecraft:item` or `minecraft:block`
    /// so far. Its values come from the world's data packs'
    /// `data/<mod_id>/data_maps/<registry path>/<name>.json`, and from files
    /// you push through `native_data_pack_files` under the key
    /// `data_maps/<mod_id>:<registry path>/<name>`: `replace`, `values`
    /// (entry ids and `#tags` to JSON values) and `remove`, a newer value
    /// overriding an older. Read them with `native_data_map` and
    /// `native_data_map_entries`, in `native_data_maps.rs`. Server-side, not
    /// synced to clients. API 143.
    // rust: pub(super) fn native_data_map_types(&self, types: &mut Vec<NativeDataMapType>) {
    // rust: mod_api::dispatch_data_map_types(self, mod_api::mods(), types);
}
    /// The server is about to open its worlds: nothing of the world is
    /// loaded yet (NeoForge's `ServerAboutToStartEvent`, "called before the
    /// server begins loading anything"). Vanilla's `MinecraftServer.loadLevel`
    /// start. Server-side: the single player server thread once Play is
    /// pressed, a dedicated server once its settings are read. Each is
    /// followed by `native_world_lifecycle`'s `WorldOpenReady` or
    /// `WorldOpenFailed`. `dedicated` tells a dedicated server from the single
    /// player one. API 44.
    // rust: pub(super) fn native_server_about_to_start(&mut self, dedicated: bool) {
    // rust: mod_api::dispatch_server_about_to_start(self, mod_api::mods(), dedicated);
}
    /// The server begins an orderly stop (NeoForge's `ServerStoppingEvent`):
    /// the start of vanilla's `MinecraftServer.stopServer`, with the worlds
    /// still loaded and the players still connected and not yet saved, so a
    /// mod can save its own data or tell them. `native_world_lifecycle`'s
    /// `WorldCloseFinal` follows once the worlds are saved. A server whose loop
    /// fails stops without this (`WorldCloseFailed` reports it). API 44.
    // rust: pub(super) fn native_server_stopping(&mut self, dedicated: bool) {
    // rust: mod_api::dispatch_server_stopping(self, mod_api::mods(), dedicated);
}
    /// The config files native mods keep (NeoForge's `registerConfig`):
    /// push yours, each of a kind, with the text written to `config/` when
    /// the file is missing. Asked by the window when the game starts (its
    /// `Client` and `Common` configs), by a dedicated server when it starts
    /// (`Common` and `Server`) and by a server before each world it opens
    /// (`Server`); a game reads only its own kinds, so push them all every
    /// time. A file outside `config/`, or one already registered, is skipped.
    /// API 397.
    // rust: pub(super) fn native_register_configs(&mut self, configs: &mut Vec<NativeConfig>) {
    // rust: mod_api::dispatch_register_configs(self, mod_api::mods(), configs);
}
    /// A registered config was read (`ModConfigEvent.Loading`): `config`
    /// says whose, which file and its text, which the mod parses (TOML by
    /// convention). Every mod hears every config, so check `mod_id`. Fired
    /// where the config's kind loads (`native_register_configs`), a `Server`
    /// one before `native_server_about_to_start`. API 397.
    // rust: pub(super) fn native_config_loading(&mut self, config: &NativeConfigFile) {
    // rust: mod_api::dispatch_config_loading(self, mod_api::mods(), config);
}
    /// A loaded config's file changed on disk (`ModConfigEvent.Reloading`):
    /// its new text. The game looks at the files' modification times once a
    /// second, on the window and on the server's tick; a file saved with the
    /// same text, removed or unreadable fires nothing and keeps its last
    /// text. API 397.
    // rust: pub(super) fn native_config_reloading(&mut self, config: &NativeConfigFile) {
    // rust: mod_api::dispatch_config_reloading(self, mod_api::mods(), config);
}
    /// A `Server` config is dropped as its server stops
    /// (`ModConfigEvent.Unloading`), after `native_server_stopping`; the next
    /// world reads it again. `Client` and `Common` configs stay until the
    /// game quits. API 397.
    // rust: pub(super) fn native_config_unloading(&mut self, config: &NativeConfigFile) {
    // rust: mod_api::dispatch_config_unloading(self, mod_api::mods(), config);
}
    /// The authoritative server tick's phases: `ServerTickStart` before any
    /// level is ticked (NeoForge's `ServerTickEvent.Pre`), `ServerTickEnd`
    /// after the last (`.Post`). Read blocks with `native_server_block`, by
    /// dimension: which level `self.world` holds here is not defined. A paused
    /// pass fires nothing; a frozen world carries `world_running` false except
    /// during a requested step.
    // rust: pub(super) fn native_server_tick(
    // rust: &mut self,
    // rust: context: &NativeLifecycleContext,
    // rust: phase: ServerTickPhase,
    // rust: ) {
    // rust: mod_api::dispatch_server_tick(self, mod_api::mods(), context, phase);
}
    /// Before an authoritative server level's tick pass. `dimension` is its ID.
    // rust: pub(super) fn native_level_tick_pre(&mut self, dimension: &str) {
    // rust: mod_api::dispatch_level_tick_pre(self, mod_api::mods(), dimension);
}
    /// After a successful authoritative server level tick pass.
    // rust: pub(super) fn native_level_tick_post(&mut self, dimension: &str) {
    // rust: mod_api::dispatch_level_tick_post(self, mod_api::mods(), dimension);
}
    /// The HUD (not drawn under F1), after the minimap: place a box with
    /// `corners.place` (boxes stack away from their edge) and draw it with
    /// `native_fill` and `native_text`. Skip a corner `native_corner_shown`
    /// says is taken.
    // rust: pub(super) fn native_hud(&mut self, batch: &mut HudBatch, corners: &mut Corners) {
    // rust: mod_api::dispatch_hud(self, mod_api::mods(), batch, corners);
}
    /// After the complete normal GUI batch, including screens, prompts, toasts,
    /// debug overlays, the pad cursor and IME. Fires even with F1 or a menu open;
    /// file/world loading and resource-reload overlays do not fire it. The batch
    /// is in GUI pixels. `native_camera` is this frame's world camera (None on
    /// the panorama). `gui_hidden` is the F1 setting; `focused` is window focus.
    /// A mod decides whether its foreground indicator respects those flags.
    /// Client only; the host is read-only. API 410.
    // rust: pub(super) fn native_gui_render_post(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: gui_hidden: bool,
    // rust: focused: bool,
    // rust: ) {
    // rust: mod_api::dispatch_gui_render_post(self, mod_api::mods(), batch, gui_hidden, focused);
}
    /// Before one of vanilla's HUD layers is drawn (`RenderGuiLayerEvent.Pre`):
    /// draw here to put something below the layer, or set `canceled` to hide
    /// it. `layer` is the layer's id, in the order Horizon draws them:
    /// `minecraft:crosshair`, `hotbar`, `effects`, `boss_overlay`,
    /// `vehicle_health` (only riding a mount), `contextual_info_bar` (the
    /// mount's jump bar, the locator bar or the experience bar, with the level
    /// number), `player_health` (the health, armor, food and air rows, drawn in
    /// one pass), `selected_item_name`, `sleep_overlay`, `overlay_message`
    /// (the action bar), `title`, `scoreboard_sidebar`, `subtitle_overlay`,
    /// `chat` and `tab_list`. A layer F1 hides fires nothing, and the chat
    /// screen draws the focused chat itself, so `chat` is only the unfocused
    /// lines. The camera overlays and the debug screen are not layers here:
    /// they are not drawn in this pass. Draw with `native_fill`, `native_text`
    /// and the sprite helpers; `batch.width` and `batch.height` are the GUI
    /// size. Together with `native_gui_layer_post` this is NeoForge's
    /// `RegisterGuiLayersEvent`: a mod keeps its own list of what it draws
    /// above or below which layer. API 139.
    // rust: pub(super) fn native_gui_layer_pre(
    // rust: &mut self,
    // rust: layer: &str,
    // rust: batch: &mut HudBatch,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_gui_layer_pre(self, mod_api::mods(), layer, batch, canceled);
}
    /// After one of vanilla's HUD layers (or after the layer a mod hid), with
    /// the ids of `native_gui_layer_pre`: draw here to put something above
    /// the layer (`RenderGuiLayerEvent.Post`). API 139.
    // rust: pub(super) fn native_gui_layer_post(&mut self, layer: &str, batch: &mut HudBatch) {
    // rust: mod_api::dispatch_gui_layer_post(self, mod_api::mods(), layer, batch);
}
    /// A player right-clicks the entity `entity` (`Entity.getId`) of type
    /// `kind` (`minecraft:cow`) with `self.hand`, holding `stack` (none in an
    /// empty hand): where `Player.interactOn` starts, before the entity's own
    /// `interact` and the item's `interactLivingEntity`. Set `claimed` to take
    /// the click: the hand swings and neither runs. Asked once per hand, as
    /// vanilla tries the main hand then the off hand. Server-side, for every
    /// player of the world (the helpers read the acting one). API 29.
    // rust: pub(super) fn native_interact_entity(
    // rust: &mut self,
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: stack: Option<&ItemStack>,
    // rust: claimed: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_interact_entity(self, mod_api::mods(), entity, kind, stack, claimed);
}
    /// A player left-clicks the block `state` at `pos`, `face` the face hit
    /// (`[0, 1, 0]` is the top): where `ServerPlayerGameMode.handleBlockBreakAction`
    /// takes a dig's start, after its reach, spawn protection and world border
    /// checks, before `Block.attack` (a note block plays) or a creative break.
    /// Set `canceled` to ignore the click: the block isn't attacked, dug or
    /// broken on the server, and the player's client gets it back (its own
    /// predicted crack still shows to the clicking player). Server-side, for
    /// every player of the world (the helpers read the acting one). API 30.
    // rust: pub(super) fn native_left_click_block(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: state: BlockStateId,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_left_click_block(self, mod_api::mods(), pos, face, state, canceled);
}
    /// A living player's server tick ends (`ServerPlayer.tick`): once a tick
    /// for every player in the world, after their digging, item use,
    /// cooldowns, statistics and advancements. The helpers read that player.
    /// Players still tick under `/tick freeze`; a dead player doesn't, nor
    /// does one killed earlier in the same tick. API 31.
    // rust: pub(super) fn native_player_tick(&mut self) {
    // rust: mod_api::dispatch_player_tick(self, mod_api::mods());
}
    /// The player-health HUD rows, once a frame the HUD draws them
    /// (`HealthHud::layout`, not under F1): `inputs` carries the health,
    /// food, air and vehicle state the layout reads, `wi`/`hi` the screen's
    /// GUI size. A mod that sets `draws` replaces every row — armour,
    /// hearts, food, air and the heights (`left_height`/`right_height`)
    /// above the hotbar are the answer's to give; `bubble_pop_sound` too.
    /// Nothing set draws Horizon's own.
    // rust: pub(super) fn native_health_hud(
    // rust: &mut self,
    // rust: inputs: &horizon_client::hud_layout::HealthInputs,
    // rust: wi: i32,
    // rust: hi: i32,
    // rust: draws: &mut Option<Vec<horizon_client::hud_layout::GuiDraw>>,
    // rust: ) {
    // rust: mod_api::dispatch_health_hud(self, mod_api::mods(), inputs, wi, hi, draws);
}
    /// A key or mouse button went down or up, by its vanilla name
    /// (`key.keyboard.z`, `key.mouse.left`): keys on any screen (check
    /// `native_playing`), mouse buttons while playing. Repeats are left out.
    // rust: pub(super) fn native_key(&mut self, key: &str, pressed: bool) {
    // rust: mod_api::dispatch_key(self, mod_api::mods(), key, pressed);
}
    /// A real window key event after handling, including repeats and consumed shortcuts.
    /// Receives the original physical/logical key, text, location, state and repeat flag.
    /// Modifier bits use the screen hooks' GLFW encoding. Not cancellable.
    // rust: pub(super) fn native_input_key(&mut self, event: &winit::event::KeyEvent, modifiers: u32) {
    // rust: mod_api::dispatch_input_key(self, mod_api::mods(), event, modifiers);
}
    /// Raw mouse button input on any screen, before dispatch; cancel skips dispatch and Post.
    /// Button/modifiers use the same GLFW encoding as screen hooks. Synthetic clicks skip it.
    // rust: pub(super) fn native_mouse_button_pre(
    // rust: &mut self,
    // rust: button: i32,
    // rust: pressed: bool,
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_mouse_button_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: button,
    // rust: pressed,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// An accepted raw button event finished dispatch, including a screen handler's early return.
    // rust: pub(super) fn native_mouse_button_post(&mut self, button: i32, pressed: bool, modifiers: u32) {
    // rust: mod_api::dispatch_mouse_button_post(self, mod_api::mods(), button, pressed, modifiers);
}
    /// Wheel steps while playing: set `claimed` to keep them from the hotbar.
    // rust: pub(super) fn native_wheel(&mut self, steps: f32, claimed: &mut bool) {
    // rust: mod_api::dispatch_wheel(self, mod_api::mods(), steps, claimed);
}
    /// Gameplay scrolling after whole steps accumulate, before hotbar/spectator handling.
    /// `scroll` is scaled x/y, `accumulated` whole x/y steps, `buttons` left/middle/right,
    /// and `cursor` the GUI position. Cancel skips gameplay scrolling; synthetic input skips it.
    // rust: pub(super) fn native_mouse_scrolling(
    // rust: &mut self,
    // rust: scroll: [f64; 2],
    // rust: accumulated: [i32; 2],
    // rust: buttons: [bool; 3],
    // rust: cursor: [f32; 2],
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_mouse_scrolling(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: scroll,
    // rust: accumulated,
    // rust: buttons,
    // rust: cursor,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// An interaction key acts on what the crosshair points at
    /// (`InputEvent.InteractionKeyMappingTriggered`), while playing: `button` 0 is
    /// the attack key (`key_mapping` `key.attack`), 1 the use key (`key.use`, once
    /// for each hand it tries, the main hand first), 2 pick block (`key.pickItem`,
    /// only with something aimed at). The attack fires when an attack is allowed
    /// and again each tick a held attack key keeps digging a block. Set `canceled`
    /// to skip the action: a cancelled use also skips the other hand. A cancelled
    /// attack or use still swings `hand` unless the mod clears `swing_hand` (it
    /// starts true). A server's player and a single player's window only; a mod
    /// that claims an item's use (`mod_use_start`) sees the event first. API
    /// 138.
    // rust: pub(super) fn native_interaction_key(
    // rust: &mut self,
    // rust: button: i32,
    // rust: key_mapping: &str,
    // rust: hand: horizon_client::first_person::Hand,
    // rust: swing_hand: &mut bool,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_interaction_key(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: button,
    // rust: key_mapping,
    // rust: hand,
    // rust: swing_hand,
    // rust: canceled,
    // rust: );
}
    /// A command typed or clicked in chat, without its slash, before the
    /// server and Horizon's commands see it: set `ran` when the mod ran it.
    // rust: pub(super) fn native_command(&mut self, command: &str, ran: &mut bool) {
    // rust: mod_api::dispatch_command(self, mod_api::mods(), command, ran);
}
    /// The commands `native_command` runs, by name and without their slash:
    /// push the ones that are yours. Asked when a connection starts and
    /// again when the server sends its own tree, so the chat box colours,
    /// completes and lists them as the game's own; a name the game already
    /// has keeps that command's behaviour. API 35.
    // rust: pub(super) fn native_commands(&mut self, commands: &mut Vec<&'static str>) {
    // rust: mod_api::dispatch_commands(self, mod_api::mods(), commands);
}
    /// Player FOV scale, after vanilla effects and before zoom and easing.
    /// Invalid values or values outside 0.01..=10 revert to base. API 362.
    // rust: pub(super) fn native_compute_fov_modifier(
    // rust: &self,
    // rust: player: &horizon_client::camera::FovPlayer,
    // rust: base: f32,
    // rust: modifier: &mut f32,
    // rust: ) {
    // rust: mod_api::dispatch_compute_fov_modifier(self, mod_api::mods(), player, base, modifier);
}
    /// Local player movement input, after reading it and before applying it.
    // rust: pub(super) fn native_movement_input(
    // rust: &self,
    // rust: forward: &mut f32,
    // rust: strafe: &mut f32,
    // rust: jump: &mut bool,
    // rust: sneak: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_movement_input(self, mod_api::mods(), forward, strafe, jump, sneak);
}
    /// World field of view, after normal calculation and zoom and before projection/Nausea.
    /// Called for world rendering and near-plane overlays; hand/HUD FOV uses its own path.
    /// Only finite values in 1..=179 degrees replace the computed FOV.
    // rust: pub(super) fn native_compute_fov(&self, partial: f32, camera: [f64; 3], degrees: &mut f32) {
    // rust: mod_api::dispatch_compute_fov(self, mod_api::mods(), partial, camera, degrees);
}
    /// The zoom a native mod asks for, applied while playing (the spyglass's
    /// own view wins): set `zoom` when it is none yet.
    // rust: pub(super) fn native_zoom(&self, zoom: &mut Option<NativeZoom>) {
    // rust: mod_api::dispatch_zoom(self, mod_api::mods(), zoom);
}
    /// Computed world fog RGB, after ordinary effects and before upload. Title panoramas skip it.
    /// Only finite RGB components in 0..=1 are accepted; alpha and distances stay unchanged.
    // rust: pub(super) fn native_compute_fog_color(
    // rust: &self,
    // rust: partial: f32,
    // rust: camera: [f64; 3],
    // rust: fog_type: horizon_client::fog::FogType,
    // rust: rgb: &mut [f32; 3],
    // rust: ) {
    // rust: mod_api::dispatch_compute_fog_color(self, mod_api::mods(), partial, camera, fog_type, rgb);
}
    /// Final world fog, after the computed color hook, ordinary calculations and Horizon's fog
    /// option, before upload. Title panoramas skip it. Invalid color or distance values retain the
    /// original whole fog.
    // rust: pub(super) fn native_render_fog(
    // rust: &self,
    // rust: partial: f32,
    // rust: camera: [f64; 3],
    // rust: fog_type: horizon_client::fog::FogType,
    // rust: fog: &mut horizon_client::fog::FogData,
    // rust: ) {
    // rust: mod_api::dispatch_render_fog(self, mod_api::mods(), partial, camera, fog_type, fog);
}
    /// The camera shake native mods ask for in this frame, `partial` ticks
    /// past the last tick (0 to 1): add your pitch, yaw and roll in degrees
    /// and your offset in blocks, along the camera's right, up and back, to
    /// `shake`, so several mods' shakes add up. Read while playing only;
    /// Horizon scales the sum by Distortion Effects and bounds it
    /// (`native_shake_matrix`). API 82.
    // rust: pub(super) fn native_camera_shake(&self, partial: f32, shake: &mut NativeShake) {
    // rust: mod_api::dispatch_camera_shake(self, mod_api::mods(), partial, shake);
}
    /// Once a frame while the world is drawn, `partial` ticks past the last tick (0 to 1), the
    /// camera at `camera`: add lines, box outlines, filled boxes, beacon-style beams and text
    /// facing the camera, in world coordinates, to `primitives`, each depth tested or seen
    /// through walls (`horizon_client::world_primitives`). Horizon draws them with its own
    /// pipelines after the entities and before the first-person hand, at the world's
    /// resolution, depth and TAA. Not on the title screen. API @API:world_primitives@.
    // rust: pub(super) fn native_world_primitives(
    // rust: &self,
    // rust: partial: f32,
    // rust: camera: [f64; 3],
    // rust: primitives: &mut WorldPrimitives,
    // rust: ) {
    // rust: mod_api::dispatch_world_primitives(self, mod_api::mods(), partial, camera, primitives);
}
    /// Name tag visibility and optional replacement text. API 372.
    // rust: pub(super) fn native_render_name_tag(
    // rust: &self,
    // rust: entity_id: u32,
    // rust: kind: &str,
    // rust: vanilla_visible: bool,
    // rust: visible: &mut bool,
    // rust: text: &mut Option<String>,
    // rust: ) {
    // rust: mod_api::dispatch_render_name_tag(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity_id,
    // rust: kind,
    // rust: vanilla_visible,
    // rust: visible,
    // rust: text,
    // rust: );
}
    /// Whether an entity the client draws has the glowing outline, and in which
    /// colour (`Entity.isCurrentlyGlowing` and `getTeamColor`, what Fabric's and
    /// NeoForge's glowing and team colour overrides change). `outline` comes
    /// in as vanilla's answer: `Some(0xRRGGBB)`, the team's colour or white,
    /// when the entity glows, None when it doesn't. Set `Some` to make any
    /// entity glow in that colour, None to take its outline away. It changes
    /// only what this client draws: the entity's `Glowing` flag, what the
    /// server and other players see, stays. Asked each frame for every mob,
    /// player (yourself in third person), dropped item and projectile drawn.
    /// API @API:entity_outline@.
    // rust: pub(super) fn native_entity_outline(
    // rust: &self,
    // rust: entity_id: u32,
    // rust: kind: &str,
    // rust: outline: &mut Option<u32>,
    // rust: ) {
    // rust: mod_api::dispatch_entity_outline(self, mod_api::mods(), entity_id, kind, outline);
}
    /// Before one first-person hand and its displayed stack are drawn (RenderHandEvent).
    /// Equip progress is the inverse arm height, including the item's swap animation scale.
    /// Cancel skips that hand's default geometry, including its map and arm geometry.
    /// It only hides: the hook has no way to draw a replacement.
    // rust: pub(super) fn native_render_hand(
    // rust: &self,
    // rust: hand: horizon_client::first_person::Hand,
    // rust: stack: Option<&ItemStack>,
    // rust: partial: f32,
    // rust: swing: f32,
    // rust: equip: f32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_render_hand(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: hand,
    // rust: stack,
    // rust: partial,
    // rust: swing,
    // rust: equip,
    // rust: canceled,
    // rust: );
}

    /// Additional first-person hand and item pose, including empty arms and maps.
    /// Add offsets in blocks and pitch, yaw and roll in degrees; multiply scale.
    /// API 369.
    // rust: pub(super) fn native_render_hand_pose(
    // rust: &self,
    // rust: hand: horizon_client::first_person::Hand,
    // rust: stack: Option<&ItemStack>,
    // rust: partial: f32,
    // rust: swing: f32,
    // rust: equip: f32,
    // rust: x: &mut f32,
    // rust: y: &mut f32,
    // rust: z: &mut f32,
    // rust: pitch: &mut f32,
    // rust: yaw: &mut f32,
    // rust: roll: &mut f32,
    // rust: scale: &mut f32,
    // rust: ) {
    // rust: mod_api::dispatch_render_hand_pose(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: hand,
    // rust: stack,
    // rust: partial,
    // rust: swing,
    // rust: equip,
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: pitch,
    // rust: yaw,
    // rust: roll,
    // rust: scale,
    // rust: );
}

    /// Before a visible item frame's item or map is drawn. Cancel hides the item, not the frame.
    // rust: pub(super) fn native_render_item_in_frame(
    // rust: &self,
    // rust: entity_id: u32,
    // rust: pos: [i32; 3],
    // rust: stack: &ItemStack,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_render_item_in_frame(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity_id,
    // rust: pos,
    // rust: stack,
    // rust: canceled,
    // rust: );
}

    /// The camera this frame is drawn from, `partial` ticks past the last tick, after vanilla
    /// placed it (`Camera.setup`): its position, and its yaw and pitch in degrees. Set them to
    /// draw the world from anywhere: a cinematic or replay camera. Only the picture, the sound's
    /// listener and the billboards facing the camera follow it; the player, where they aim, the
    /// first-person hand and which chunks load stay the player's. Values that aren't finite keep
    /// vanilla's. Not called on the title screen's panorama. API 402.
    // rust: pub(super) fn native_camera_pose(
    // rust: &self,
    // rust: partial: f32,
    // rust: position: &mut [f64; 3],
    // rust: yaw: &mut f32,
    // rust: pitch: &mut f32,
    // rust: ) {
    // rust: mod_api::dispatch_camera_pose(self, mod_api::mods(), partial, position, yaw, pitch);
}
    /// Final scaled third-person camera distance, before visual-shape collision clipping.
    /// `entity` includes its living scale/distance and optional mount scale/distance.
    /// Only finite requests in 0..=1024 blocks replace the vanilla distance.
    // rust: pub(super) fn native_camera_distance(
    // rust: &self,
    // rust: partial: f32,
    // rust: mirrored: bool,
    // rust: entity: &horizon_client::camera::CameraEntity,
    // rust: distance: &mut f32,
    // rust: ) {
    // rust: mod_api::dispatch_camera_distance(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: partial,
    // rust: mirrored,
    // rust: entity,
    // rust: distance,
    // rust: );
}
    /// Change the colours of `biome` (`minecraft:plains`) on this client: the
    /// grass, foliage (leaves, vines), dry foliage (leaf litter) and water
    /// tints, 0xRRGGBB, as its biome file and the colormaps set them. Asked
    /// for every biome when a mod calls `native_refresh_biome_colors`, which
    /// rebuilds the terrain with them; a season mod answers from its season
    /// and calls that when the season turns. The dark forest's modifier
    /// still applies to the grass set here; the swamp's noise colours
    /// replace it. API 107.
    // rust: pub(super) fn native_biome_colors(&self, biome: &str, colors: &mut BiomeColors) {
    // rust: mod_api::dispatch_biome_colors(self, mod_api::mods(), biome, colors);
}
    /// Choose this client's music, once a client tick: `music` and `volume`
    /// hold what vanilla chose (`Minecraft.getSituationalMusic` and
    /// `getMusicVolume`: the biome's track, the creative or underwater one, a
    /// boss's, the menu's; None for silence). Set `music` to a track of your
    /// own, a sound event of your content mod's `sounds.json` such as
    /// `Music::new("mymod:music.spring", 1200, 6000, false)` (the delays in
    /// ticks between songs, and whether it cuts off a different song playing),
    /// None to keep vanilla's quiet, or change `volume` (0 to 1) to fade it. API
    /// 119.
    // rust: pub(super) fn native_music(&self, music: &mut Option<Music>, volume: &mut f32) {
    // rust: mod_api::dispatch_music(self, mod_api::mods(), music, volume);
}
    /// The tracks to play over (or instead of) the music on this client,
    /// asked once a client tick: push a `MusicLayer` (a sound event, looped,
    /// and its volume, 0 to 1) for each. A layer eases to a new volume over up
    /// to two seconds, and one left out fades out and stops; layers that
    /// first appear in the same tick start together, so list every stem of a
    /// piece from the start, the silent ones at volume 0, and raise them (a
    /// fuller arrangement as a village grows). Their sound events should be
    /// `stream: true` in `sounds.json`. API 119.
    // rust: pub(super) fn native_music_layers(&self, layers: &mut Vec<MusicLayer>) {
    // rust: mod_api::dispatch_music_layers(self, mod_api::mods(), layers);
}
    /// The values native mods hand their shader packs in this frame,
    /// `partial` ticks past the last tick (0 to 1): a pack's WGSL reads
    /// them as `frame.mods` (eight `vec4<f32>`). Write the slots your own
    /// pack reads; a mod that bundles its pack as `native-<mod id>` is the
    /// one that pack is for. Asked once a frame while a pack is on; a value
    /// that isn't finite reads as 0 (`native_shader_params_now`). API
    /// 84.
    // rust: pub(super) fn native_shader_params(&self, partial: f32, params: &mut [[f32; 4]; 8]) {
    // rust: mod_api::dispatch_shader_params(self, mod_api::mods(), partial, params);
}
    /// The minimap a native mod shows: set `minimap` when it is none yet.
    // rust: pub(super) fn native_minimap(&self, minimap: &mut Option<NativeMinimap>) {
    // rust: mod_api::dispatch_minimap(self, mod_api::mods(), minimap);
}
    /// Register namespaced NBT component types before content loads.
    // rust: pub(super) fn native_component_types(types: &mut Vec<String>) {
    // rust: mod_api::dispatch_component_types(mod_api::mods(), types);
}
    /// Blocks this mod adds, declared in code rather than one file each
    /// (NeoForge's `DeferredRegister.Blocks` drained by `RegisterEvent`):
    /// push a `horizon_mods::content::Block` per block, the same declaration
    /// a content mod's `data/<id>/horizon/block/<path>.json` holds (a
    /// vanilla `template`, `properties`, `state_properties`, `shapes`...),
    /// with its id in your mod's namespace. `item: true` gives it a block
    /// item, as a file does unless told not to (`..Default::default()`
    /// leaves it false). They join the content mods' blocks: the one whose
    /// id is that namespace when it is on (your models, textures, loot and
    /// recipes are its files), else one of their own, with the template's
    /// look. Ids, saves and the check that a joining client has the same
    /// blocks are the files' (docs/mods.md). Asked once at start, on every
    /// side, before any resource loads: push the same ones every time, from
    /// nothing but your code. Declarations that don't pass the files' checks
    /// are logged and that namespace's are left out. API
    /// 145.
    // rust: pub(super) fn native_blocks(blocks: &mut Vec<horizon_mods::content::Block>) {
    // rust: mod_api::dispatch_blocks(mod_api::mods(), blocks);
}
    /// Items this mod adds, declared in code (NeoForge's
    /// `DeferredRegister.Items`), as `native_blocks` declares blocks: a
    /// `horizon_mods::content::Item` per item, a content mod's
    /// `data/<id>/horizon/item/<path>.json` (a vanilla `template`,
    /// `max_stack_size`, `rarity`, `components`, `crafting_remainder`). A
    /// block's item comes with its block (`item: true`), not from here.
    /// Asked once at start, on every side. API 145.
    // rust: pub(super) fn native_items(items: &mut Vec<horizon_mods::content::Item>) {
    // rust: mod_api::dispatch_items(mod_api::mods(), items);
}
    /// Models no blockstate names that this client bakes beside the block
    /// models (NeoForge's `ModelEvent.RegisterStandalone`): push their ids
    /// (`mymod:block/shaft_half`, the model at
    /// `assets/mymod/models/block/shaft_half.json`). Parts a block entity or
    /// a mob draws, with `native_draw_model`, so that no block is registered
    /// only to bake its model. Asked once at start, before the resources
    /// load; every resource load, a pack reload included, bakes them again
    /// from that pack's files. A model that doesn't read is logged and left
    /// out; an id without a namespace is dropped. Every side asks it, but
    /// only a window bakes models. API 151.
    // rust: pub(super) fn native_standalone_models(models: &mut Vec<String>) {
    // rust: mod_api::dispatch_standalone_models(mod_api::mods(), models);
}
    /// Entity model layers built in code (NeoForge's
    /// `EntityRenderersEvent.RegisterLayerDefinitions`): push each one's id,
    /// `<mod id>:<model>#<layer>` as a `ModelLayerLocation` names it
    /// (`mymod:golem#main`), and its `LayerDefinition`, as the mod's
    /// `createBodyLayer()` builds it. `native_bake_layer` bakes one into the
    /// `ModelPart` tree `native_draw_model_part` draws. Asked once at start,
    /// on every side. An id in vanilla's namespace, not of that form, or
    /// registered already is logged and left out. API @API:model_layers@.
    // rust: pub(super) fn native_layer_definitions(layers: &mut Vec<(String, LayerDefinition)>) {
    // rust: mod_api::dispatch_layer_definitions(mod_api::mods(), layers);
}
    /// Options > Mods lists the native mods: push yours.
    // rust: pub(super) fn native_mods(&mut self, mods: &mut Vec<NativeMod>) {
    // rust: mod_api::dispatch_mods(self, mod_api::mods(), mods);
}
    /// The buttons of mod `mod_id`'s settings page, under its keys: push
    /// their labels when it is yours. Asked again each time the page opens
    /// and after each click.
    // rust: pub(super) fn native_settings(&mut self, mod_id: &str, buttons: &mut Vec<String>) {
    // rust: mod_api::dispatch_settings(self, mod_api::mods(), mod_id, buttons);
}
    /// Button `button` of mod `mod_id`'s settings page was clicked.
    // rust: pub(super) fn native_settings_click(&mut self, mod_id: &str, button: usize) {
    // rust: mod_api::dispatch_settings_click(self, mod_api::mods(), mod_id, button);
}
    /// The player did `event` on mod `mod_id`'s panel (`native_panel_items`):
    /// act on it when it is yours. API 2.
    // rust: pub(super) fn native_panel_event(&mut self, mod_id: &str, event: &NativePanelEvent) {
    // rust: mod_api::dispatch_panel_event(self, mod_api::mods(), mod_id, event);
}
    /// Block `block` (`mymod:machine`) gets a block entity
    /// (`EntityBlock.newBlockEntity`): set `entity` to its id and saved
    /// compound when the block is yours and `entity` is none yet. It works on
    /// any template: the engine removes the block entity when its block is
    /// broken or replaced, no piston moves it, and a mod that draws it
    /// (`native_block_entity_submit`) is asked for it. API 15; before
    /// 129 the block's template had to have a
    /// block entity of its own (a chest, a furnace...), or the block got none.
    // rust: pub(super) fn native_block_entity(
    // rust: &mut self,
    // rust: block: &str,
    // rust: entity: &mut Option<(String, Compound)>,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity(self, mod_api::mods(), block, entity);
}
    /// Whether block `block`'s block entity ticks (`EntityBlock.getTicker`):
    /// set `ticks` when it is yours. Asked for each of the block's states
    /// when a world opens. API 15.
    /// Set `ticks` to true to make it tick, and never clear a value an earlier mod or mixin set.
    // rust: pub(super) fn native_block_entity_ticks(&self, block: &str, ticks: &mut bool) {
    // rust: mod_api::dispatch_block_entity_ticks(self, mod_api::mods(), block, ticks);
}
    /// A `minecraft:post_attack` effect of a mod's own kind, on a mob a
    /// player's weapon hit: the entry says `enchanted` attacker and `affected`
    /// victim, its `requirements` passed, and its `effect` names a `type` in a
    /// namespace outside `minecraft:`. Told the enchantment id, the kind, the
    /// `effect` JSON, the level and the mob's id (it may have just died). The
    /// acting player is the one whose weapon carries the enchantment. Each
    /// such entry is told once a hit, and once for each mob a sweep lands on.
    /// A hit on a player, and an entry inside `minecraft:all_of`, aren't told
    /// yet. An unclaimed kind does nothing. API 77.
    // rust: pub(super) fn native_enchant_effect(
    // rust: &mut self,
    // rust: enchantment: &str,
    // rust: kind: &str,
    // rust: data: &serde_json::Value,
    // rust: level: u32,
    // rust: victim: u32,
    // rust: ) {
    // rust: mod_api::dispatch_enchant_effect(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: enchantment,
    // rust: kind,
    // rust: data,
    // rust: level,
    // rust: victim,
    // rust: );
}
    /// Block `block`'s block entity has item slots (a `WorldlyContainer`):
    /// set `container` when the block is yours. Asked once for each mod
    /// block when the ticking table is built; at most 256 slots, and slot
    /// numbers past the count are left out. Its `menu`, one of
    /// `containers::MOD_MENUS` or a content mod's menu type
    /// (`data/<id>/horizon/menu/`, API 85) with as many
    /// slots, opens when the block is used (its template must open a menu, as
    /// a chest or a furnace does); another is left out. A mod menu type shows
    /// on Horizon clients through the mod's `native_screen` only. API 17.
    // rust: pub(super) fn native_block_entity_container(
    // rust: &self,
    // rust: block: &str,
    // rust: container: &mut Option<ModContainer>,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_container(self, mod_api::mods(), block, container);
}
    /// Block `block`'s block entity has fluid tanks: set `fluids` when the
    /// block is yours, in the container's shape — each tank's capacity in
    /// millibuckets, the tanks each face reaches, and the tanks a fill may
    /// reach and a drain may take. Asked once for each mod block when the
    /// ticking table is built; at most 16 tanks, capacities clamped to
    /// 1..=1 000 000, and tank numbers past the count are left out. The tanks'
    /// contents are kept in the entity's saved compound, under `fluids`, and
    /// the fluid helpers below read and write them. API 54.
    // rust: pub(super) fn native_block_entity_fluids(
    // rust: &self,
    // rust: block: &str,
    // rust: fluids: &mut Option<ModFluidTanks>,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_fluids(self, mod_api::mods(), block, fluids);
}
    /// Does tank `tank` of the mod block `block` take `fluid`
    /// (`minecraft:water`, `minecraft:lava`, or a mod's own,
    /// `create:chocolate`)? NeoForge's `IFluidHandler.isFluidValid`: a water
    /// tank refuses a mod's fluid, so a removed mod leaves no id it cannot
    /// use behind. Asked on the server before `native_fluid_insert` fills a
    /// tank that the block's `ModFluidTanks` lets be filled through that
    /// face, in both passes (same fluid first, then empty), and before
    /// `native_move_fluids` counts that tank's room. Set `cancel` to refuse
    /// the fluid there; the fill tries the next tank. Every tank accepts
    /// every fluid unless a mod says otherwise; a cauldron, which holds only
    /// water and lava, and a drain never ask it. Bundles need "hooks":
    /// @API:block_entity_accepts_fluid@.
    // rust: pub(super) fn native_block_entity_accepts_fluid(
    // rust: &self,
    // rust: block: &str,
    // rust: tank: usize,
    // rust: fluid: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_accepts_fluid(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: block,
    // rust: tank,
    // rust: fluid,
    // rust: cancel,
    // rust: );
}
    /// Block `block`'s block entity has an energy buffer
    /// (`Capabilities.Energy.BLOCK`): set `energy` when the block is yours,
    /// as `SimpleEnergyHandler` is built: its capacity, the most one insert
    /// and one extract moves, and the faces a fill may come through and a
    /// drain may leave by. Asked once for each mod block when the ticking
    /// table is built; a capacity under 1 leaves the buffer out, and the
    /// limits are clamped to 0..=capacity. The amount is kept in the entity's
    /// saved compound, as the int `energy`, and the energy helpers below read
    /// and write it. API 142.
    // rust: pub(super) fn native_block_entity_energy(
    // rust: &self,
    // rust: block: &str,
    // rust: energy: &mut Option<ModEnergyBuffer>,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_energy(self, mod_api::mods(), block, energy);
}
    /// Item `item` (`mod_id:name`) is a fluid container
    /// (`Capabilities.FluidHandler.ITEM`): set `capacity`, in millibuckets,
    /// when the item is yours (clamped to 1..=1 000 000; vanilla's buckets
    /// are built in and cannot be changed). Asked at each call of the item
    /// fluid helpers (`native_item_fluid`, `native_item_fluid_fill`,
    /// `native_item_fluid_drain`, in `native_item_fluids.rs`). What the
    /// container holds is kept in the stack's `minecraft:custom_data`, under
    /// `horizon_fluid`. API 147.
    // rust: pub(super) fn native_item_fluid_tank(&self, item: &str, capacity: &mut Option<i32>) {
    // rust: mod_api::dispatch_item_fluid_tank(self, mod_api::mods(), item, capacity);
}
    /// Item `item` (`mod_id:name`) holds energy (`Capabilities.Energy.ITEM`):
    /// set `buffer` when the item is yours, as `SimpleEnergyHandler` is built:
    /// its capacity and the most one insert and one extract move. A capacity
    /// under 1 leaves the buffer out, and the limits are clamped to
    /// 0..=capacity; vanilla's items have none. Asked at each call of the item
    /// energy helpers (`native_item_energy`, `native_item_energy_insert`,
    /// `native_item_energy_extract`, in `native_item_energy.rs`). The amount
    /// is kept in the stack's `minecraft:custom_data`, as the int
    /// `horizon_energy`. API 307.
    // rust: pub(super) fn native_item_energy_buffer(
    // rust: &self,
    // rust: item: &str,
    // rust: buffer: &mut Option<ItemEnergyBuffer>,
    // rust: ) {
    // rust: mod_api::dispatch_item_energy_buffer(self, mod_api::mods(), item, buffer);
}
    /// Item `item` (`mod_id:name`) holds items (`Capabilities.Item.ITEM`): set
    /// `slots` when the item is yours, for a backpack, a storage cell or a
    /// toolbox. Clamped to 1..=256, `ItemContainerContents`' limit; 0 leaves
    /// the item without slots, and vanilla's items have none. Asked at each
    /// call of the item container helpers (`native_item_container_slots`,
    /// `native_item_container_insert`, `native_item_container_extract`, in
    /// `native_item_container.rs`). The contents are kept in the stack's
    /// `minecraft:container`, as a shulker box item keeps them.
    /// API 370.
    // rust: pub(super) fn native_item_container(&self, item: &str, slots: &mut Option<u32>) {
    // rust: mod_api::dispatch_item_container(self, mod_api::mods(), item, slots);
}
    /// A server tick of the block entity at `pos`, in vanilla's order among
    /// the others (`Level.tickBlockEntities`), when its `id` is yours: read
    /// and change its saved compound `nbt`, its item slots `items` (keep
    /// their count: as many as its container has, none without one) and the
    /// data slots its menu shows (`data`). It is out of the world during the
    /// call (the block entity at `pos` reads as a `Mod` with an empty id, and
    /// a save leaves it out); if the call removes or replaces it, `entity` is
    /// dropped. Clients, the window's own in single player included, get
    /// what `native_block_entity_update_tag` gives when its chunk is sent or
    /// its block changes. API 17.
    // rust: pub(super) fn native_block_entity_tick(&mut self, pos: [i32; 3], entity: &mut ModBlockEntity) {
    // rust: mod_api::dispatch_block_entity_tick(self, mod_api::mods(), pos, entity);
}
    /// A consumable's effect of a mod's own kind: the item's `on_consume_effects`
    /// entry is of a type in a namespace of its own, and the loader kept it
    /// for this call. The kind and the JSON the file wrote are here; the acting
    /// player is the one consuming, and the game's own effects,
    /// sounds, teleports and drops are open. An unclaimed kind does
    /// nothing. API 74.
    // rust: pub(super) fn native_consume_effect(&mut self, kind: &str, data: &serde_json::Value) {
    // rust: mod_api::dispatch_consume_effect(self, mod_api::mods(), kind, data);
}
    /// What clients get of the block entity at `pos` when its `id` is
    /// yours (`BlockEntity.getUpdateTag`): set `tag` to it, read from
    /// `entity` alone. Asked on the server whenever a chunk holding it is
    /// sent and whenever its block changes, on the server thread or, for a
    /// saved chunk sent past the view distance (`lan::far`), another one; a client's copy of the block
    /// entity (made by `native_block_entity` there) merges it into its `nbt`.
    /// Leave it unset to send nothing. API 45.
    // rust: pub(super) fn native_block_entity_update_tag(
    // rust: pos: [i32; 3],
    // rust: entity: &ModBlockEntity,
    // rust: tag: &mut Option<Compound>,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_update_tag(mod_api::mods(), pos, entity, tag);
}
    /// May `stack` go into slot `slot` of the mod block entity at `pos`
    /// (`entity`, read only), put in through `face` (none when no face is
    /// asked)? NeoForge's `IItemHandler.isItemValid`, vanilla's
    /// `Container.canPlaceItem`: a millstone takes only what it has a recipe
    /// for, so a wrong item can't block it. Asked on the server for every
    /// item a hopper, a dropper or `native_insert_item` would put in, once
    /// the block's `ModContainer` lets that slot be filled through that face
    /// (its `inputs` and `faces`). Set `cancel` to refuse the item there; the
    /// mover tries the next slot. Not asked for a player's clicks in a menu
    /// (`native_menu_slot_rules`). Bundles need "hooks": @API:container_accepts@.
    // rust: pub(super) fn native_container_accepts(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: entity: &ModBlockEntity,
    // rust: slot: usize,
    // rust: stack: &ItemStack,
    // rust: face: Option<Direction>,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_container_accepts(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: pos,
    // rust: entity,
    // rust: slot,
    // rust: stack,
    // rust: face,
    // rust: cancel,
    // rust: );
}
    /// Draw the mod block entity at `pos`, of block `block`
    /// (`mymod:machine`), on this client: once a frame while it is in view
    /// (vanilla's `BlockEntityRenderer.submit`: within 64 blocks, its chunk
    /// faded in, and its bounds, `native_block_entity_render_bounding_box`,
    /// in the frustum), when its `id` is yours. `state` is the block's state
    /// (`blockEntity.getBlockState()`: read its `facing` with
    /// `native_block_state_property`), `entity` holds what the server sent
    /// (`native_block_entity_update_tag`). Add geometry with
    /// `native_draw_quad`, `native_draw_cube`, `native_draw_block` and
    /// `native_draw_item` under `draw`'s pose stack, which starts at the
    /// block's lower north-west corner, in blocks; `draw` also has the partial
    /// tick, the game time and the block's light. API 71.
    // rust: pub(super) fn native_block_entity_submit(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: block: &str,
    // rust: state: BlockStateId,
    // rust: entity: &ModBlockEntity,
    // rust: draw: &mut BlockEntityDraw,
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_submit(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: pos,
    // rust: block,
    // rust: state,
    // rust: entity,
    // rust: draw,
    // rust: );
}
    /// Where the mod block entity at `pos` draws, for culling
    /// (NeoForge's `getRenderBoundingBox`): `bounds` is min x, y, z then max
    /// x, y, z, in blocks from the block's lower north-west corner. It starts
    /// as the block with a block of margin around it; widen it when your
    /// `native_block_entity_submit` draws further (a tall shaft, a beam), or
    /// set an infinite value for one never culled. Asked once a frame for each
    /// within 64 blocks whose chunk is drawn. API 71.
    // rust: pub(super) fn native_block_entity_render_bounding_box(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: block: &str,
    // rust: state: BlockStateId,
    // rust: entity: &ModBlockEntity,
    // rust: bounds: &mut [f32; 6],
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_render_bounding_box(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: pos,
    // rust: block,
    // rust: state,
    // rust: entity,
    // rust: bounds,
    // rust: );
}
    /// Submit depth-tested world text and textured quads, after particles and
    /// before the hand/HUD. The pose starts camera-relative; use
    /// `draw.translate_world` for a world position. Called independently of
    /// block entities and chunks, so transient overlays may outlive their
    /// source block. API @API:world_canvas@.
    // rust: pub(super) fn native_world_submit(&self, draw: &mut NativeWorldDraw) {
    // rust: mod_api::dispatch_world_submit(self, mod_api::mods(), draw);
}
    /// Draw the mob `mob` (its id, kind, custom name and the frame's body
    /// and head turns and walk cycle, `LivingEntityRenderState`) on this
    /// client with a model of your own, once a frame while it is in view
    /// (vanilla's `EntityRenderer.submit`), and set `drawn` to leave out its
    /// vanilla model, armour and held items (NeoForge's `RenderLivingEvent.Pre`,
    /// cancelled). Add geometry with `native_draw_cube`, `native_draw_quad`,
    /// `native_draw_block` and `native_draw_item` under `draw`'s pose stack,
    /// which starts at the mob's feet turned with its body: +z is the way it
    /// faces, +x its left, +y up, in blocks. `draw` also has the partial tick,
    /// the game time and the mob's light. Its name tag, shadow, flames and
    /// glowing outline draw as for any mob. Asked for every mob in view but
    /// players; a mob your server half spawned (`native_spawn_mob`) is told
    /// apart by its id, sent with mod messages, or by its custom name.
    /// A mob is drawn afresh each frame: `draw.keep()` does nothing here.
    /// API 110.
    // rust: pub(super) fn native_mob_submit(
    // rust: &self,
    // rust: mob: &NativeMobRender<'_>,
    // rust: draw: &mut BlockEntityDraw,
    // rust: drawn: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_mob_submit(self, mod_api::mods(), mob, draw, drawn);
}
    /// Whether a mod listens to `native_player_submit` or `native_mob_layer`: a
    /// mod that hooks either hooks this one too and sets `listened` (HEAD,
    /// `*listened = true`). Without it the game poses no player or mob for
    /// them, each frame. Client-side. API 149.
    // rust: pub(super) fn native_player_render_listened(&self, listened: &mut bool) {
    // rust: mod_api::dispatch_player_render_listened(self, mod_api::mods(), listened);
}
    /// Draw the player `player` (`who`: its profile name, and whether it is
    /// this window's own player) with a model of your own, once a frame while
    /// it is in view (`RenderPlayerEvent.Pre`), and set `drawn` to leave out its
    /// vanilla model, armour, held items, cape and the other layers. This
    /// window's player is drawn only in third person (and F5 front view); an
    /// invisible player is not asked. `draw` is the frame of `native_mob_submit`:
    /// at the player's feet, turned with the body. The name tag, shadow,
    /// flames and glowing outline draw as before. API 149.
    // rust: pub(super) fn native_player_submit(
    // rust: &self,
    // rust: player: &NativeMobRender<'_>,
    // rust: who: &NativePlayerRender<'_>,
    // rust: draw: &mut BlockEntityDraw,
    // rust: drawn: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_submit(self, mod_api::mods(), player, who, draw, drawn);
}
    /// A layer on every mob and player in view, once a frame after its
    /// vanilla model and layers (`EntityRenderersEvent.AddLayers`, with
    /// `RenderLivingEvent.Post` and `RenderPlayerEvent.Post`): add geometry
    /// in the entity's frame, which starts at its feet turned with the body
    /// (`mob.head_yaw`, `mob.pitch` and the walk cycle place a part, the eyes
    /// being at the entity type's eye height). `who` is set for a player.
    /// Not asked for what a mod drew itself (`native_mob_submit`,
    /// `native_player_submit`) nor for a mob that isn't drawn at all.
    /// API 149.
    // rust: pub(super) fn native_mob_layer(
    // rust: &self,
    // rust: mob: &NativeMobRender<'_>,
    // rust: who: Option<&NativePlayerRender<'_>>,
    // rust: draw: &mut BlockEntityDraw,
    // rust: ) {
    // rust: mod_api::dispatch_mob_layer(self, mod_api::mods(), mob, who, draw);
}
    /// Icons a mod puts on map `map` each time it is drawn: held, in an
    /// item frame or on the cartography table's screen (a map's pixels are
    /// its own; nothing is saved in the map). Push `NativeMapDecoration`s
    /// (an atlas sprite, a position in half map pixels, a rotation, and
    /// whether it shows in a frame and on the screen like vanilla's markers
    /// do); they are drawn after the vanilla ones with the same pose, and a
    /// sprite the atlas lacks is left out. `map.center`, `map.scale` and
    /// `map.dimension` say which blocks the map shows, and
    /// `NativeMapDecoration::x` has the formula. Vanilla's decorations are
    /// not passed in. Asked every frame a map is drawn, so keep it cheap.
    /// The client half of `MapDecorationType` and `addDecoration`: a type
    /// registered on the server and saved in the map's data is not here.
    /// API 140.
    // rust: pub(super) fn native_map_decorations(
    // rust: &self,
    // rust: map: &NativeMapInfo<'_>,
    // rust: decorations: &mut Vec<NativeMapDecoration>,
    // rust: ) {
    // rust: mod_api::dispatch_map_decorations(self, mod_api::mods(), map, decorations);
}
    /// A menu opens on this client for block `block`, a mod's: set `screen`
    /// when the block is yours, to lay its screen out (`native_screen_draw`
    /// draws it). The server asks it too: a slot it hides is not in the menu
    /// there either, so shift-clicks never fill it. API 19.
    // rust: pub(super) fn native_screen(&self, block: &str, screen: &mut Option<NativeScreen>) {
    // rust: mod_api::dispatch_screen(self, mod_api::mods(), block, screen);
}
    /// Draw block `block`'s screen at `origin` (its top left, GUI pixels),
    /// over a plain panel with its slots' frames and under the items and
    /// labels, from the menu's data slots `data` (the block entity's `data`
    /// on the server): data slots are 16-bit on the wire as in vanilla (a
    /// bigger value wraps), and `data` is empty until the server's first
    /// values arrive, so read it with `get`. Draw with `native_sprite`, `native_fill` and
    /// `native_text`. API 19.
    // rust: pub(super) fn native_screen_draw(
    // rust: &self,
    // rust: block: &str,
    // rust: data: &[i32],
    // rust: batch: &mut HudBatch,
    // rust: origin: [f32; 2],
    // rust: ) {
    // rust: mod_api::dispatch_screen_draw(self, mod_api::mods(), block, data, batch, origin);
}
    /// A screen was observed opening, at most once per frame.
    // rust: pub(super) fn native_screen_opening(&self, screen: &NativeScreenView<'_>) {
    // rust: mod_api::dispatch_screen_opening(self, mod_api::mods(), screen);
}

    /// A screen was observed opening or changing rectangle, at most once per frame.
    // rust: pub(super) fn native_screen_init_post(&self, screen: &NativeScreenView<'_>) {
    // rust: mod_api::dispatch_screen_init_post(self, mod_api::mods(), screen);
}

    /// A screen was observed closing, at most once per frame.
    // rust: pub(super) fn native_screen_closing(&self, screen: &NativeScreenView<'_>) {
    // rust: mod_api::dispatch_screen_closing(self, mod_api::mods(), screen);
}
    /// The open screen has drawn itself and its tooltips (`Screen.render`,
    /// the point of `ScreenEvent.Render.Post`): draw over it with
    /// `native_fill`, `native_sprite` and `native_text`, `screen.rect` being
    /// its container panel (or the whole window) and `screen.id` the screen
    /// it is. Once a frame on the window, never while playing with no screen;
    /// `&self`, so it reads and draws only. The Win and Options screens call
    /// it on their own path, after their drawing.
    ///
    /// It does not fire for the screens drawn over gameplay after it (a
    /// server dialog, the server pack, link and code-of-conduct prompts, a
    /// book, a sign editor): those keep `Screen::Playing`, which it skips (the
    /// server pack prompt hides an open screen too, and that screen does not
    /// fire under it), and draw over what it drew, while vanilla's
    /// `ScreenEvent.Render.Post` fires for them. The title's own screens
    /// (`title`, `world_select`, `world_create`, `multiplayer`…) fire it too,
    /// their `screen.id` from the title state machine and the whole window
    /// their `rect` (API 326), and no dialog or prompt over them.
    /// API 78.
    // rust: pub(super) fn native_screen_render_post(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: screen: &NativeScreenView<'_>,
    // rust: ) {
    // rust: mod_api::dispatch_screen_render_post(self, mod_api::mods(), batch, screen);
}
    /// A mouse button went down over the open screen
    /// (`ScreenEvent.MouseButtonPressed.Pre`, vanilla's
    /// `Screen.mouseClicked`): `screen` is the screen it is, `screen.mouse`
    /// where the pointer is (so there is no position of its own), `button` the
    /// button's GLFW index (0 left, 1 right, 2 middle, 3 back, 4 forward; a
    /// button past those is the platform's own number, which differs between
    /// systems) and `modifiers` GLFW's bits (shift 1, control 2,
    /// alt 4, super 8). Set `canceled` and the press goes no further: no slot,
    /// no screen button, no drag, no hotbar key, no sort or header button.
    ///
    /// It fires before anything the screen does with the press, on the window
    /// only, and while a screen of the game's or the title's is open (Options
    /// and the pack list opened from the title screen count, with no player
    /// and no `menu`; the title's own screens since API 326, their
    /// `screen.id` from the title state machine). It does not fire on the
    /// connect and loading screens, nor for a server
    /// dialog, the server pack, link and code-of-conduct prompts, a book or a
    /// sign editor drawn over gameplay, nor while a world loads or saves: the
    /// click there stays the game's own. A gamepad click or a click the
    /// keyboard's focus sends is not the mouse and fires nothing.
    /// API 80.
    // rust: pub(super) fn native_screen_mouse_button_pressed_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: button: i32,
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_mouse_button_pressed_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: button,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// A mouse button went up over the open screen
    /// (`ScreenEvent.MouseButtonReleased.Pre`, vanilla's
    /// `Screen.mouseReleased`), with the same `screen`, `button` and
    /// `modifiers` as `native_screen_mouse_button_pressed_pre` and fired at
    /// the same point. Set `canceled` and the release goes no further: a
    /// pressed slot keeps what it took and no drag, slider or scrollbar lets
    /// go.
    ///
    /// Cancel a release only when the press it ends was cancelled too: a
    /// release the screen took ends the drag or the scroll it began, as it
    /// does in vanilla, and no guard here un-cancels it. Same screens as the
    /// press; a press that opened another screen ends on that one.
    /// API 80.
    // rust: pub(super) fn native_screen_mouse_button_released_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: button: i32,
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_mouse_button_released_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: button,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// Before a real held-button movement reaches screen drag handlers.
    /// `screen.mouse` is the current GUI position; `delta` is its GUI-space movement.
    /// Cancel keeps the new cursor position but skips all screen drag handlers.
    // rust: pub(super) fn native_screen_mouse_dragged_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: button: i32,
    // rust: delta: [f32; 2],
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_mouse_dragged_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: button,
    // rust: delta,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// The wheel turned over the open screen (`ScreenEvent.MouseScrolled.Pre`,
    /// vanilla's `Screen.mouseScrolled`): `screen` is the screen it is,
    /// `screen.mouse` where the pointer is (so there is no position of its
    /// own), `scroll` the wheel's movement in x and y as the game's own scroll
    /// handler scales it (a line times the wheel sensitivity: with Discrete
    /// Scrolling on, a notch is ±1, its sign only; a touchpad's pixels are
    /// divided by 30), and
    /// `modifiers` GLFW's bits (shift 1, control 2, alt 4, super 8). Set
    /// `canceled` and nothing the screen would scroll moves: not the bundle
    /// under the pointer, nor a list, slider, scrollbar or map. Nothing else
    /// reads the wheel while a screen of the game's is open, so no hotbar slot
    /// changes either.
    ///
    /// It fires before the screen scrolls anything, for the window's wheel
    /// (horizon-ctl's `scroll-at` sends it through the window too), and
    /// while a screen of the game's or the title's is open (Options and the
    /// pack list opened from the title screen count, with no player and no
    /// `menu`; the title's own since API 326). It
    /// does not fire on the connect and loading
    /// screens, nor for a server dialog, the server pack, link and
    /// code-of-conduct prompts, a book or a sign editor drawn over gameplay,
    /// nor while a world loads or saves: the scroll there stays the game's
    /// own. A wheel a gamepad or the keyboard's focus sends is not the mouse
    /// and fires nothing.
    /// API 93.
    // rust: pub(super) fn native_screen_mouse_scrolled_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: scroll: [f64; 2],
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_mouse_scrolled_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: scroll,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// A key went down over the open screen (`ScreenEvent.KeyPressed.Pre`,
    /// vanilla's `Screen.keyPressed`): `screen` is the screen it is, `key`
    /// vanilla's name for the key (`key.keyboard.e`, the name `native_key`
    /// hands over) — a key with no name fires nothing — `repeat` whether it is
    /// the keyboard's auto-repeat of a held press (Horizon's extra; NeoForge
    /// folds repeats into the event), and `modifiers` GLFW's bits (shift 1,
    /// control 2, alt 4, super 8). Set `canceled` and the press goes no
    /// further: no focus move, no Escape-close, no inventory or hotbar key, no
    /// typing by the key itself, no `native_key`.
    ///
    /// It fires for the window's presses and their repeats, and for the
    /// control socket's `key` (a release fires nothing), after the window's
    /// own shortcuts have run — the fullscreen and screenshot keys, the debug
    /// keys and the narrator — and while a screen of the game's or the title's
    /// is open (Options and the pack list opened from the title screen count,
    /// with no player and no `menu`; the title's own since API 326). It does
    /// not fire on the connect and loading screens, nor for a server dialog, the server pack,
    /// link and code-of-conduct prompts, a book or a sign editor drawn over
    /// gameplay, nor while a world loads or saves: the key there stays the
    /// game's own. A cancelled press's release still runs, so a `native_key`
    /// listener sees that release without its press, and its characters are
    /// GLFW's separate char callback and still come; see
    /// `native_screen_char_typed_pre`.
    /// API 104.
    // rust: pub(super) fn native_screen_key_pressed_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: key: &str,
    // rust: repeat: bool,
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_key_pressed_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: key,
    // rust: repeat,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// Before an open screen handles a named key's release (same screen gate as key presses).
    /// Cancel bypasses screen handling; physical keys and mapped keyboard hold/toggle state release.
    // rust: pub(super) fn native_screen_key_released_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: key: &str,
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_key_released_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: key,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// A character was typed at the open screen
    /// (`ScreenEvent.CharacterTyped.Pre`, vanilla's `Screen.charTyped`):
    /// `screen` is the screen it is, `c` the character, and `modifiers` GLFW's
    /// bits (shift 1, control 2, alt 4, super 8). Set `canceled` and that one
    /// character never reaches a text box.
    ///
    /// It fires once per printable character of a key press's text and once
    /// per character of the input method's committed text, never for a control
    /// character (Enter, Backspace, Tab, Delete, Escape, a Control letter):
    /// those are keys, and the game reads them as keys, not as text. A key's
    /// characters fire after the key has acted, as GLFW's char callback comes
    /// after its key callback (`KeyboardHandler.charTyped`): `screen` is the
    /// screen open then, so a key that closes the screen (the inventory key)
    /// leaves none to hear its character, where vanilla's closed screen hears
    /// nothing, and one that moves the focus types into the box it moved to.
    /// They fire even when `native_screen_key_pressed_pre` cancelled the press
    /// that carried the text, as NeoForge delivers `CharacterTyped.Pre` for a
    /// cancelled `KeyPressed.Pre`: the characters left reach the text box
    /// without the key's own effects. Cancelling one character drops only that
    /// one. The control socket's `type` fires it too, but not for its `\b`
    /// backspace. Same screens as the key press, and it fires with no text box
    /// focused (there is nothing to take the character then).
    /// API 104.
    // rust: pub(super) fn native_screen_char_typed_pre(
    // rust: &self,
    // rust: screen: &NativeScreenView<'_>,
    // rust: c: char,
    // rust: modifiers: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_screen_char_typed_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: screen,
    // rust: c,
    // rust: modifiers,
    // rust: canceled,
    // rust: );
}
    /// The open screen as a native mod sees it (`NativeScreenView`): its id,
    /// the open menu's type and title, its slot count, and its panel's
    /// rectangle, with the mouse and the partial tick. `screen` is the screen
    /// drawn this frame, which `NativeScreenView.id` comes from. Borrowed:
    /// nothing is copied per frame.
    // rust: pub(super) fn screen_view(&self, batch: &HudBatch, screen: Screen) -> NativeScreenView<'_> {
    // rust: NativeScreenView {
    // rust: id: screen.id(),
    // rust: menu: self.remote_menu_type().filter(|m| !m.is_empty()),
    // rust: title: self.remote.as_ref().and_then(|r| r.menu_title.as_ref()),
    // rust: rect: self.screen_rect(batch, screen),
    // rust: slots: self.slot_count(),
    // rust: mouse: self.native_cursor(),
    // rust: partial_tick: self.clock.fraction() as f32,
}
}
    /// The title's own screen as a native mod sees it (`NativeScreenView`):
    /// its id from the title state machine (`title`, `world_select`,
    /// `world_create`, `multiplayer`, `add_server`…), no menu and no menu
    /// title, the whole window as its rectangle and no slots (no menu is
    /// open). None while no title screen is up. API 326.
    // rust: pub(super) fn title_screen_view(&self, batch: &HudBatch) -> Option<NativeScreenView<'_>> {
    // rust: let title = self.title.as_ref()?;
    // rust: Some(NativeScreenView {
    // rust: id: title.mode.id(),
    // rust: menu: None,
    // rust: title: None,
    // rust: rect: [0.0, 0.0, batch.width, batch.height],
    // rust: slots: 0,
    // rust: mouse: self.native_cursor(),
    // rust: partial_tick: self.clock.fraction() as f32,
    // rust: })
}
    /// The open screen's container panel in GUI pixels (`screen`'s, the one
    /// this frame draws), or the whole window for a screen with none
    /// (`NativeScreenView.rect`).
    // rust: pub(super) fn screen_rect(&self, batch: &HudBatch, screen: Screen) -> [f32; 4] {
    // rust: if screen != Screen::Inventory && screen != Screen::Creative {
    // rust: return [0.0, 0.0, batch.width, batch.height];
}
        // The window the game itself draws (`container_image`): the merchant
        // and the beacon are wider and shifted, creative is its own size.
    // rust: let image = self.container_image(batch);
    // rust: [
    // rust: image.left as f32,
    // rust: image.top as f32,
    // rust: image.width as f32,
    // rust: image.height as f32,
    // rust: ]
}
    // rust: pub(super) fn track_drag_button(&mut self, button: MouseButton, pressed: bool) {
        // Any release ends the drag, as vanilla's `MouseHandler.onButton` clears `activeButton`:
        // left down, right down, left up sends no drag while right is still held.
    // rust: self.drag_button = pressed.then_some(button);
}
    // rust: pub(super) fn screen_mouse_dragged(&self, previous: (f32, f32)) -> bool {
    // rust: if self.pad_synthetic_input() || self.cursor == previous {
    // rust: return false;
}
    // rust: let Some(button) = self
    // rust: .drag_button
    // rust: .filter(|b| self.physical_buttons.contains(b))
    // rust: else {
    // rust: return false;
}
    // rust: let Some(screen) = self.screen_view_now() else {
    // rust: return false;
}
    // rust: let mut canceled = false;
    // rust: self.native_screen_mouse_dragged_pre(
    // rust: &screen,
    // rust: super::glfw_button(button),
    // rust: [self.cursor.0 - previous.0, self.cursor.1 - previous.1],
    // rust: super::glfw_modifiers(self.modifiers),
    // rust: &mut canceled,
    // rust: );
    // rust: canceled
}
    /// A screen the native mods' input hooks are for is open: the window has a
    /// renderer, either the title's own (`title`, `world_select`,
    /// `world_create`, `multiplayer`…) or a screen over the world
    /// (`Screen::Playing` behind it, so not a book, a sign editor, a server
    /// dialog or a prompt drawn over gameplay), and no connect or world load
    /// is in progress. The one gate they all ask before they fire.
    // rust: pub(super) fn screen_hooks_open(&self) -> bool {
    // rust: self.renderer.is_some()
    // rust: && !self.screen_over_playing()
    // rust: && !self.remote_loading()
    // rust: && (self.screen != Screen::Playing || self.title.is_some())
}
    /// The open screen as an input hook sees it (`NativeScreenView`), or None
    /// when `screen_hooks_open` says no screen is. `screen.mouse` is the
    /// pointer the hook's event is at, so a hook takes no position, and
    /// `partial_tick` is the clock's fraction at this event, not a frame's.
    /// The `HudBatch` built here is only what `screen.rect` needs: the
    /// window's GUI scale, no allocation.
    // rust: pub(super) fn screen_view_now(&self) -> Option<NativeScreenView<'_>> {
    // rust: if !self.screen_hooks_open() {
    // rust: return None;
}
    // rust: let renderer = self.renderer.as_ref()?;
    // rust: let batch = HudBatch::new([renderer.config.width, renderer.config.height]);
    // rust: if self.screen != Screen::Playing {
    // rust: return Some(self.screen_view(&batch, self.screen));
}
    // rust: self.title_screen_view(&batch)
}
    /// Whether the key press `key` over the open screen went no further
    /// (`native_screen_key_pressed_pre`): what `handle_window_event` and the
    /// control socket's `key` command both ask before a screen acts on a key.
    /// False when no screen of the hooks' is open, and for a key with no
    /// vanilla name.
    // rust: pub(super) fn screen_key_pressed(&self, key: KeyCode, repeat: bool) -> bool {
    // rust: let Some(name) = keybinds::key_name(key) else {
    // rust: return false;
}
    // rust: let Some(screen) = self.screen_view_now() else {
    // rust: return false;
}
    // rust: let mut canceled = false;
    // rust: self.native_screen_key_pressed_pre(
    // rust: &screen,
    // rust: name,
    // rust: repeat,
    // rust: super::glfw_modifiers(self.modifiers),
    // rust: &mut canceled,
    // rust: );
    // rust: canceled
}
    // rust: pub(super) fn screen_key_released(&self, key: KeyCode) -> bool {
    // rust: let Some(name) = keybinds::key_name(key) else {
    // rust: return false;
}
    // rust: let Some(screen) = self.screen_view_now() else {
    // rust: return false;
}
    // rust: let mut canceled = false;
    // rust: self.native_screen_key_released_pre(
    // rust: &screen,
    // rust: name,
    // rust: super::glfw_modifiers(self.modifiers),
    // rust: &mut canceled,
    // rust: );
    // rust: canceled
}
    /// Text on its way to a text box after the open screen's character hooks
    /// (`native_screen_char_typed_pre` per printable character): the cancelled
    /// characters are gone and every other one stays, control characters
    /// included (a text box reads Backspace, Delete and the like as keys).
    /// `None` when none of them is left to type.
    // rust: pub(super) fn screen_text_typed(&self, text: &str) -> Option<String> {
    // rust: let Some(screen) = self.screen_view_now() else {
    // rust: return Some(text.to_owned());
}
    // rust: let modifiers = super::glfw_modifiers(self.modifiers);
    // rust: screen_text_hooked(text, |c| {
    // rust: let mut canceled = false;
    // rust: self.native_screen_char_typed_pre(&screen, c, modifiers, &mut canceled);
    // rust: canceled
    // rust: })
}
    /// A key press's characters (`ScreenEvent.CharacterTyped.Pre`, vanilla's
    /// `KeyboardHandler.charTyped`), dispatched once the screen has acted on
    /// the key: GLFW's char callback comes after its key callback, so the
    /// characters go to the screen that is open now — a key that closed the
    /// screen leaves none to hear them, as vanilla's closed screen hears
    /// nothing, and one that moved the focus types into the box it moved to.
    /// Each printable one is offered to `native_screen_char_typed_pre`; the
    /// survivors go to the focused text box, control characters (keys) gone.
    // rust: pub(super) fn screen_chars_typed(&mut self, text: Option<&str>) {
    // rust: let Some(text) = text else {
    // rust: return;
}
    // rust: let Some(screen) = self.screen_view_now() else {
    // rust: return;
}
    // rust: let modifiers = super::glfw_modifiers(self.modifiers);
    // rust: let Some(text) = chars_to_type(text, |c| {
    // rust: let mut canceled = false;
    // rust: self.native_screen_char_typed_pre(&screen, c, modifiers, &mut canceled);
    // rust: canceled
    // rust: }) else {
    // rust: return;
}
        // A held edit modifier makes a shortcut of the key, not text.
    // rust: if !self.types_text() {
    // rust: return;
}
        // `Err` only says no text box of the screen takes the characters.
    // rust: let _ = self.type_chars_into_screen(&text);
}
    /// A left or right (`right`) press at `at` (GUI pixels from the screen's
    /// top left, so outside it too) on block `block`'s screen, a mod's, over
    /// no slot: set `button` to a menu button id when it is on one of yours.
    /// Horizon sends it to the server (`ContainerButtonClick`,
    /// `native_menu_button` there) and the press goes no further. API 20.
    // rust: pub(super) fn native_screen_click(
    // rust: &self,
    // rust: block: &str,
    // rust: data: &[i32],
    // rust: at: [f32; 2],
    // rust: right: bool,
    // rust: button: &mut Option<i32>,
    // rust: ) {
    // rust: mod_api::dispatch_screen_click(self, mod_api::mods(), block, data, at, right, button);
}
    /// The tooltip at `at` (as in `native_screen_click`) on block `block`'s
    /// screen, a mod's, over no item: push its lines when it is over
    /// something of yours. Legacy colour codes (§) work. API 20.
    // rust: pub(super) fn native_screen_tooltip(
    // rust: &self,
    // rust: block: &str,
    // rust: data: &[i32],
    // rust: at: [f32; 2],
    // rust: lines: &mut Vec<String>,
    // rust: ) {
    // rust: mod_api::dispatch_screen_tooltip(self, mod_api::mods(), block, data, at, lines);
}
    /// A player pressed menu button `id` on the menu of the mod block entity
    /// at `pos` (`AbstractContainerMenu.clickMenuButton`), on the server:
    /// change `entity` when its id is yours. It is out of the world during
    /// the call, as in `native_block_entity_tick`. API 20.
    // rust: pub(super) fn native_menu_button(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: entity: &mut ModBlockEntity,
    // rust: id: i32,
    // rust: ) {
    // rust: mod_api::dispatch_menu_button(self, mod_api::mods(), pos, entity, id);
}
    /// `AbstractContainerMenu.clickMenuButton(Player, int)`'s other half:
    /// the acting player's cursor stack, `getCarried()`/`setCarried()`,
    /// which `native_menu_button` cannot reach. Fires right after it, same
    /// moment, same `pos`/`entity`/`id`; change `carried` when its id is
    /// yours. On the server. API 51.
    // rust: pub(super) fn native_menu_button_v2(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: entity: &mut ModBlockEntity,
    // rust: id: i32,
    // rust: carried: &mut Option<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_menu_button_v2(self, mod_api::mods(), pos, entity, id, carried);
}
    /// A player shift-clicked slot `slot` of the menu of the mod block
    /// entity at `pos` (`AbstractContainerMenu.quickMoveStack`, the method a
    /// Java menu overrides), on the server, before the game's own routing:
    /// move the stack where your block wants it. `slot` is the menu's index:
    /// below `container_slots` it is the block's own slot (`entity.items`),
    /// from there on the player's inventory (27 main slots, then the hotbar).
    /// `stack` is a copy of what the slot holds; take what you move out of
    /// it (put it in `entity.items`, or in another block with
    /// `native_insert_item`) and set `handled`: the slot then holds what is
    /// left of `stack` (whatever you wrote to that slot of `entity.items`),
    /// the game's routing is skipped, and the player's client gets the menu
    /// again. Left unhandled, `entity.items` goes back to what it held and
    /// the game moves the stack as for any container; a later mod sees what
    /// an earlier one did to `stack`.
    ///
    /// For a mod container on a vanilla menu type and on a mod menu type,
    /// the left or right button, a slot that holds something and that the
    /// mod's screen shows; not for a spectator or a dead player, a menu no
    /// longer valid, nor during a drag.
    /// Asked once per click, where vanilla asks `quickMoveStack` again while
    /// it keeps moving the same item. The player's state is swapped in, so
    /// `native_acting_player` names them; `entity` is out of the world
    /// during the call, as in `native_menu_button`.
    /// API 309.
    // rust: pub(super) fn native_menu_quick_move(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: entity: &mut ModBlockEntity,
    // rust: container_slots: usize,
    // rust: slot: usize,
    // rust: stack: &mut ItemStack,
    // rust: handled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_menu_quick_move(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: pos,
    // rust: entity,
    // rust: container_slots,
    // rust: slot,
    // rust: stack,
    // rust: handled,
    // rust: );
}
    /// The commands native mods add to the server's command tree: push
    /// yours. Asked once when a world opens to players (a dedicated
    /// server, a LAN host, single player's server thread); every player's
    /// chat box then completes them as vanilla's, within their level. A
    /// name vanilla has is left out. API 8.
    // rust: pub(super) fn native_register_commands(&mut self, commands: &mut Vec<NativeCommand>) {
    // rust: mod_api::dispatch_register_commands(self, mod_api::mods(), commands);
}
    /// A player's command on the server (`Commands.performCommand`),
    /// without its slash, for a command a mod registered and the player's
    /// level allows: set `ran` when it is yours. The player's state is
    /// swapped in for the call, so `native_player` and the other helpers
    /// read that player; `native_feedback` answers them. A single player's
    /// owner console (`horizon-ctl command`) reaches it too, as the owner at
    /// level 4. API 8.
    // rust: pub(super) fn native_perform_command(
    // rust: &mut self,
    // rust: player: &NativeServerPlayer,
    // rust: command: &str,
    // rust: ran: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_perform_command(self, mod_api::mods(), player, command, ran);
}
    /// A player takes an item from an armor stand or puts one on it
    /// (`ArmorStand.interactAt`, after the stand's disabled-slot checks and
    /// `swapItem`'s take/put locks, before anything moves): `stand_id` is the
    /// stand's `Entity.getId` and `slot` the one the click reached
    /// (`mainhand`, `offhand`, `feet`, `legs`, `chest` or `head`). Set
    /// `cancel` and nothing changes: neither the stand nor the player's hand,
    /// and the click is spent. The player's state is swapped in for the call;
    /// `player` is the UUID the helpers take. Not told of a click that changes
    /// nothing (an empty hand on an empty slot). Not covered, other ways a
    /// stand's equipment moves: breaking or blasting the stand (its items
    /// drop), a dispenser putting armour on one, a mod's own changes.
    /// Server-side, for every player of the world.
    /// 175.
    // rust: pub(super) fn native_armor_stand_manipulate(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: stand_id: i32,
    // rust: slot: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_armor_stand_manipulate(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: stand_id,
    // rust: slot,
    // rust: cancel,
    // rust: );
}
    /// A boat or minecart (`kind`, `minecraft:oak_boat`) moved since the last
    /// tick (`VehicleMoveEvent`): `from` and `to` are its positions, heard
    /// after the tick moved it. Once a tick for each vehicle that carries a
    /// server player, whose state is then swapped in (as for
    /// `native_perform_command`: `native_acting_player`, `native_tell` and
    /// the item helpers reach them; `player` is their UUID), and for one a
    /// server player rode and left, until it has stood still for ten
    /// seconds (`player` is none, nobody is swapped in). It only hears.
    /// Cheap when nothing moves: one position compare a tick for each watched
    /// vehicle. Not heard: a vehicle moved before anyone rode it, a mount
    /// (horse, pig...) or a vehicle carrying only a mob. Server-side, in the
    /// level the vehicle is in. 178.
    // rust: pub(super) fn native_vehicle_moved(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: kind: &str,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: ) {
    // rust: mod_api::dispatch_vehicle_moved(self, mod_api::mods(), player, kind, from, to);
}
    /// A player opens one of the game's own menus (`ServerPlayer.openMenu`; the
    /// job of NeoForge's `PlayerContainerEvent.Open`, which comes after the
    /// menu is open and cannot stop it): `kind` is the menu type
    /// (`minecraft:generic_9x3`, `minecraft:furnace`, `minecraft:crafting`,
    /// `minecraft:merchant`, `minecraft:anvil`, `minecraft:lectern`...; a
    /// horse's inventory is `minecraft:horse_inventory`) and `pos` the block
    /// it belongs to, none for a villager, a mount or a vehicle's chest.
    /// Heard after the checks that refuse the menu (a locked container, a
    /// spectator) and before the menu that was open closes. Set `cancel` and
    /// nothing opens: the open menu stays as it was and the click is spent.
    /// The player's state is swapped in for the call, as for
    /// `native_perform_command`, so `native_acting_player`, `native_tell` and
    /// the item helpers reach them. Not heard: a menu a mod opens
    /// (`native_open_menu`), the inventory screen, and the editors (sign,
    /// book, command block). Server-side, for every player of the world.
    /// 176.
    // rust: pub(super) fn native_container_opened(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: kind: &str,
    // rust: pos: Option<[i32; 3]>,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_container_opened(self, mod_api::mods(), player, name, kind, pos, cancel);
}
    /// A creative-mode player sets a slot of their inventory from the
    /// creative screen (`ServerGamePacketListenerImpl.handleSetCreativeModeSlot`):
    /// `slot` is the inventory menu's slot (5 to 8 armour, 9 to 35 the
    /// inventory, 36 to 44 the hotbar, 45 the off hand; below 0 is a stack
    /// thrown out of the screen, which is dropped) and `item` (`minecraft:air`
    /// for an emptied slot) and `count` what is put there. Heard once the
    /// packet passed vanilla's checks (a creative player, a real slot, a valid
    /// stack) and before the slot changes or the stack drops. Set `cancel`
    /// and the packet is ignored. The player's state is swapped in for the
    /// call, as for `native_perform_command`, so `native_acting_player`,
    /// `native_tell` and the item helpers reach them. Not heard: stacks a
    /// creative player gets other ways (middle-click pick block, `/give`).
    /// Server-side, for every player of the world.
    /// 177.
    // rust: pub(super) fn native_creative_slot(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: slot: i32,
    // rust: item: &str,
    // rust: count: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_creative_slot(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: slot,
    // rust: item,
    // rust: count,
    // rust: cancel,
    // rust: );
}
    /// A server player's game mode is about to change (NeoForge's
    /// `PlayerChangeGameModeEvent`): from `from` to `to` (0 survival, 1
    /// creative, 2 adventure, 3 spectator, as `NativeServerPlayer`'s
    /// `game_mode`), `player` being the UUID and `name` the name. Heard for
    /// the `/gamemode` command, the F3+F4 switcher's packet and a hardcore
    /// world's respawn into spectator, once for each change to a different
    /// mode; not for the world's default mode a player joins with. Set
    /// `cancel` and the player keeps their mode (nothing is sent, the
    /// command counts it as no change). For a change the game makes inside
    /// a player's turn their state is swapped in; for the hardcore respawn
    /// it is not. 158.
    // rust: pub(super) fn native_player_game_mode_changed(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: i32,
    // rust: to: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_game_mode_changed(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: from,
    // rust: to,
    // rust: cancel,
    // rust: );
}
    /// `player` (`name`) changed dimension (NeoForge's
    /// `PlayerChangedDimensionEvent`): `from` and `to` are dimension ids
    /// (`minecraft:overworld`, `minecraft:the_nether`, `minecraft:the_end`).
    /// Heard once per move, when it has ended: the portal's exit is found
    /// and the player stands there (after the destination has loaded), a
    /// command's teleport has landed, or a respawn in another level than the
    /// death's is placed for good (a bed or anchor, or the world spawn's
    /// free column, after the fallback when a respawn block was gone). The
    /// level of `to` is the one in place, and the player's state is swapped
    /// in, as for `native_perform_command`: `native_acting_player`,
    /// `native_tell`, the item helpers and the rest reach them. Heard for:
    /// Nether and End portals (also riding a vehicle, and leaving the End as
    /// its winner), `/execute in ... run tp` and any other command that
    /// teleports a player into another level, and the death respawn. Not
    /// heard: a move within a level (`/tp`, an End gateway), a player who
    /// leaves before the move ends, a move that ends where it started (a
    /// respawn in the dimension of the death), and anything outside a
    /// dedicated server. 154.
    // rust: pub(super) fn native_player_changed_dimension(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: &str,
    // rust: to: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_changed_dimension(self, mod_api::mods(), player, name, from, to);
}
    /// A player's client started (`flying`) or stopped flying (vanilla's
    /// `handlePlayerAbilities`, which honours it only for a player who may
    /// fly: creative or spectator), heard once for each change, on a server,
    /// with the player's state swapped in, so `native_tell` and the other
    /// helpers reach them. The player is already flying or not as asked, as
    /// vanilla leaves them; set `cancel` to refuse it: they keep the state
    /// they had and the server sends their abilities back, as vanilla does
    /// for what it refuses, so the client lands or flies again. Only what a
    /// client asks for is heard: not the flight a game-mode change starts or
    /// ends (`/gamemode`), and not a LAN host's own player.
    /// 153.
    // rust: pub(super) fn native_player_toggle_flight(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: flying: bool,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_toggle_flight(self, mod_api::mods(), player, name, flying, cancel);
}
    /// A guest's client changed sneaking in its player input packet, after the hub applied the new state.
    /// The guest's state is swapped in. Server-side. 351.
    // rust: pub(super) fn native_player_toggle_sneak(&mut self, player: u128, name: &str, sneaking: bool) {
    // rust: mod_api::dispatch_player_toggle_sneak(self, mod_api::mods(), player, name, sneaking);
}
    /// A player finished editing a sign: `ServerGamePacketListenerImpl.updateSignText`
    /// has taken their update packet and every check has passed (they were
    /// editing that sign, within reach, the sign is not waxed, the chat filter
    /// let the text through), right before the lines go on the sign. `pos` in
    /// `dimension`, the `front` or back side, and the four `lines` as written,
    /// plain text with the formatting codes still in (vanilla strips them
    /// afterwards). Rewrite `lines` (made four lines again) and that is what
    /// the sign gets, without a second look from the chat filter, or set
    /// `cancel` and the sign keeps its old text. With the player's state
    /// swapped in, so `native_tell` and the helpers that act on the player
    /// reach them. Once for each update a player sends on a server. Not told:
    /// the host's own editing of a sign on a LAN or single-player world
    /// (the editor writes into their world directly), and the sign changes
    /// that are no edit of the text (dyeing, glow ink, waxing, `/data`,
    /// `/setblock`, mods' `native_with_mod_block_entity`).
    /// 150.
    // rust: pub(super) fn native_sign_changed(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: front: bool,
    // rust: lines: &mut Vec<String>,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_sign_changed(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: dimension,
    // rust: pos,
    // rust: front,
    // rust: lines,
    // rust: cancel,
    // rust: );
}
    /// A command a player typed (NeoForge's `CommandEvent`, before
    /// `Commands.performCommand` runs it), without its slash: any command,
    /// vanilla's and the mods' own, also one the player may not run. Set
    /// `canceled` to stop it: nothing runs and nothing is answered but the
    /// lines pushed to `replies`, which go to the player as system chat.
    /// No player's state is swapped in and the server's player list is busy
    /// with this one, so `native_tell` and the other helpers that take a UUID
    /// reach nobody here: answer through `replies`. Once for each command a
    /// player sends, on a server, and for each line of a quiet command batch
    /// (`horizon:quiet_commands`, whose replies are dropped). A command the
    /// server refuses before reading it (unsigned chat arguments, the chat
    /// rate limit) never reaches it. 95.
    // rust: pub(super) fn native_player_command(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: command: &str,
    // rust: canceled: &mut bool,
    // rust: replies: &mut Vec<Text>,
    // rust: ) {
    // rust: mod_api::dispatch_player_command(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: command,
    // rust: replies,
    // rust: canceled,
    // rust: );
}
    /// A command a mod registered, typed on the dedicated server's console
    /// or sent through `horizon-server console`
    /// (`DedicatedServer.handleConsoleInputs`), without its slash: set `ran`
    /// when it is yours. There is no player: the source is the console, at
    /// permission level 4, so `native_acting_player` is None and the
    /// player-only helpers give nothing; `native_feedback` answers on the
    /// console. A name no mod registered goes to vanilla's dispatcher as
    /// before. 99.
    // rust: pub(super) fn native_perform_console_command(&mut self, command: &str, ran: &mut bool) {
    // rust: mod_api::dispatch_perform_console_command(self, mod_api::mods(), command, ran);
}
    /// A server player's ender pearl landed and is about to teleport them
    /// (NeoForge's `EntityTeleportEvent.EnderPearl`, vanilla's
    /// `ThrownEnderpearl.onHit` for a player owner): `pearl` is the pearl's
    /// entity id, `from` their feet now, `target` where the pearl started
    /// its last tick and `damage` the fall damage they then take (5). A mod
    /// may move `target` (a value that is not a number is ignored) or change
    /// `damage` (0 or less: none). Canceling
    /// keeps the player where they are: no endermite roll, no teleport, no
    /// damage and no sound; the pearl is used up either way. The player's
    /// state is swapped in (`native_acting_player`). The hit itself is
    /// heard by `native_projectile_impact`. 312.
    // rust: pub(super) fn native_ender_pearl_teleport(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pearl: u32,
    // rust: from: [f64; 3],
    // rust: target: &mut [f64; 3],
    // rust: damage: &mut f32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_ender_pearl_teleport(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pearl,
    // rust: from,
    // rust: target,
    // rust: damage,
    // rust: cancel,
    // rust: );
}
    /// A server player who ate chorus fruit (or another item with the
    /// `teleport_randomly` consume effect) is about to try a random spot
    /// (NeoForge's `EntityTeleportEvent.ChorusFruit`, vanilla's
    /// `TeleportRandomlyConsumeEffect.apply`): once per attempt (up to 16),
    /// after they stopped riding. `from` is their feet, `target` the spot
    /// drawn; a mod may move it (its y kept inside the level's height, a
    /// value that is not a number ignored), and the game still looks down
    /// from it for ground it may land on. Canceling ends the effect: no teleport and no
    /// more attempts. The player's state is swapped in
    /// (`native_acting_player`). Foxes are not heard. 311.
    // rust: pub(super) fn native_chorus_fruit_teleport(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: [f64; 3],
    // rust: target: &mut [f64; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_chorus_fruit_teleport(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: from,
    // rust: target,
    // rust: cancel,
    // rust: );
}
    /// A server player a command teleported (NeoForge's
    /// `EntityTeleportEvent`, for a player): `/tp` and `/teleport`, inside
    /// their level or into another one. `from` and `to` are their feet before
    /// and after, `dimension` the level they are in now. Heard after the move
    /// has reached the player's state and their client (an inter-level
    /// teleport: when the new level is entered, before it has loaded around
    /// them), so it cannot stop it. The player's state is swapped in, so the
    /// helpers that read the acting player and `native_tell` work. Once for
    /// each teleported player, on a server. Ender pearls and chorus fruit
    /// have their own hooks; a spectator's teleport menu is not heard yet;
    /// portals and respawns are not teleports here. 170.
    // rust: pub(super) fn native_player_teleported(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: dimension: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_teleported(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: from,
    // rust: to,
    // rust: dimension,
    // rust: );
}
    /// A player whose login the server has accepted (NeoForge's
    /// `PlayerNegotiationEvent` stage): the name, whitelist, ban and
    /// server-full checks have passed and the player holds a place, but their
    /// saved state is not loaded and they are not placed in a level yet. Set
    /// `cancel` to refuse them: they are disconnected with `reason` (a plain
    /// "Disconnected" if it is left unset) and nothing else of the join (the
    /// join message, `native_player_logged_in`) happens. Once for each player
    /// who joins, on a server. The player is not placed yet and their client
    /// has no world to show a message in, so no player's state is swapped in
    /// and `native_tell` reaches nobody: the refusal `reason` is the answer.
    /// The checks that need no mod (name, whitelist, bans, a full server,
    /// the proxy's forwarding) refuse earlier, on the connection, and this
    /// hook does not hear those players. 172.
    // rust: pub(super) fn native_player_login(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: cancel: &mut bool,
    // rust: reason: &mut Option<Text>,
    // rust: ) {
    // rust: mod_api::dispatch_player_login(self, mod_api::mods(), player, name, reason, cancel);
}
    /// The command tree a server sends a player (NeoForge's and Paper's
    /// "commands sent to a player" stage): when they join and when their
    /// level changes (`/op`, `/deop`, the LAN settings). `names` are the
    /// root commands their client would get, vanilla's they may use and the
    /// mods'; take a name out and that client gets the tree without it
    /// (and without what it leads to), so it neither completes nor
    /// highlights it. This hides the command from the client only: the
    /// server still runs a typed one, `native_player_command` stops it.
    /// For a player who is already on, their state is swapped in and the
    /// helpers (`native_tell`...) work; for one who is joining it is not, and
    /// their client has no world to tell yet. The tree the hub sends again by
    /// itself (after a respawn or a change of level) keeps the last answer
    /// and does not ask again; the integrated server's owner is not asked
    /// when the world's cheats are switched. 171.
    // rust: pub(super) fn native_player_commands_sent(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: names: &mut Vec<String>,
    // rust: ) {
    // rust: mod_api::dispatch_player_commands_sent(self, mod_api::mods(), player, name, names);
}
    /// A server player's sprint started or stopped: their client sent
    /// `START_SPRINTING` or `STOP_SPRINTING` (the sprint key, a double tap
    /// forward, or letting go) and the server's player is now `sprinting`
    /// (vanilla's `setSprinting` in `handlePlayerCommand`). Heard only when it
    /// changes. It cannot be stopped, and it hears what the client asks, not
    /// what the server does: a sprint that ends by itself (a hit's knockback,
    /// hunger, a wall) is not reported. The player's state is swapped in, so
    /// the helpers and `native_tell` work. Once for each change, on a server.
    /// 173.
    // rust: pub(super) fn native_player_sprint(&mut self, player: u128, name: &str, sprinting: bool) {
    // rust: mod_api::dispatch_player_sprint(self, mod_api::mods(), player, name, sprinting);
}
    /// A server player's client answered a resource pack in play (vanilla's
    /// `ServerboundResourcePackPacket`): `status` is `Action`'s number, 0
    /// successfully loaded, 1 declined, 2 failed download, 3 accepted, 4
    /// downloaded, 5 invalid URL, 6 failed reload, 7 discarded. Heard when the
    /// packet arrives, after the server has handled it; it cannot be stopped.
    /// The player's state is swapped in, so the helpers and `native_tell`
    /// work. The pack a dedicated server offers in the configuration
    /// (`resource-pack` in `server.properties`) is answered before the
    /// player has joined, and those answers are not heard. Once for each
    /// answer, on a server. 174.
    // rust: pub(super) fn native_resource_pack_status(&mut self, player: u128, name: &str, status: i32) {
    // rust: mod_api::dispatch_resource_pack_status(self, mod_api::mods(), player, name, status);
}
    /// A server player places a hanging entity: an item frame
    /// (`minecraft:item_frame`, `minecraft:glow_item_frame`), a painting
    /// (`minecraft:painting`) or a leash knot (`minecraft:leash_knot`, when a
    /// lead is tied to a fence that has none yet), `kind` its entity type and
    /// `pos` the block it takes (the fence's for a knot). Where
    /// `HangingEntityItem.useOn` and `LeadItem.useOn` create it, once it is
    /// known to fit and before anything is placed or used up. Set `cancel`
    /// and nothing is placed: the item stays in the player's hand. The
    /// player's state is swapped in, so `native_tell` answers them. Only for
    /// guests of a server; `/summon`, a dispenser and the game's own player
    /// are not heard, nor is a lead tied to a mob or a boat.
    /// 180.
    // rust: pub(super) fn native_hanging_place(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: kind: &str,
    // rust: pos: [i32; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_hanging_place(self, mod_api::mods(), player, name, kind, pos, cancel);
}
    /// An item frame (`minecraft:item_frame`, `minecraft:glow_item_frame`) or
    /// a painting (`minecraft:painting`), `kind` its entity type and `pos` the
    /// block it hangs in, is about to break: a server player's hit
    /// (`player`, their state swapped in, so `native_tell` answers them), a
    /// blast, or the wall it hangs on gone (`player` None for both). Where
    /// `BlockAttachedEntity.hurtServer` and its survival check would kill
    /// it, before anything drops or sounds. Set `cancel` and it stays, as it
    /// was. A hit that only takes the item out of a frame does not break the
    /// frame and is not asked. The game's own player's hit is not asked, nor
    /// is `/kill`. 319.
    // rust: pub(super) fn native_hanging_break(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: kind: &str,
    // rust: pos: [i32; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_hanging_break(self, mod_api::mods(), player, kind, pos, cancel);
}
    /// A server player empties a bucket at `pos` (`fluid`: `minecraft:water`,
    /// `minecraft:lava`, `minecraft:powder_snow`; a fish or axolotl bucket
    /// empties `minecraft:water`): where `BucketItem.use` has found the block
    /// the fluid goes into and the player may build there, right before it is
    /// placed. Set `cancel` and nothing is poured and the bucket stays full.
    /// The player's state is swapped in, so `native_tell` answers them. Only
    /// for guests of a server. `native_fill_bucket` hears this click too (and
    /// the filling one) without the player and the fluid. Not heard: a
    /// dispenser, a cauldron, and a fluid a block places itself.
    /// 179.
    // rust: pub(super) fn native_bucket_empty(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: fluid: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_bucket_empty(self, mod_api::mods(), player, name, pos, fluid, cancel);
}
    /// TNT at `pos` is about to be lit (primed): a flint and steel or a fire
    /// charge on it, fire burning it, a redstone signal, an arrow, or a
    /// dispenser's flint and steel or TNT item. `player` is the server player
    /// whose click lit it, with their state swapped in (so `native_tell`
    /// answers them), None when no player is behind it (fire, redstone, an
    /// arrow, a dispenser). Set `cancel` and it is not primed: a TNT block
    /// stays where it is (one that fire or a signal had already taken out is
    /// put back, without a block update), a dispenser's TNT item stays in it.
    /// Not asked: TNT set off by a blast (`native_explosion_detonate` spares
    /// blocks), a TNT minecart and a sulfur cube. Server-side and in single
    /// player. 181.
    // rust: pub(super) fn native_tnt_primed(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: pos: [i32; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_tnt_primed(self, mod_api::mods(), player, pos, cancel);
}
    /// A server player selected a new hotbar slot. The player's state is not
    /// swapped in, and helpers that look them up through `self.lan` may find
    /// nothing while a guest packet is being handled. Set `cancel` to keep
    /// the old slot; the client is sent that slot again. 263.
    // rust: pub(super) fn native_player_item_held(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from_slot: i32,
    // rust: to_slot: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_item_held(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: from_slot,
    // rust: to_slot,
    // rust: cancel,
    // rust: );
}
    /// A server player picked an item from a block or entity, before it enters
    /// the hotbar. `pos` is zero for an entity; `entity_id` is zero for a
    /// block. The player's state is swapped in, though helpers that look them
    /// up through `self.lan` may find nothing while a guest packet is handled.
    /// Set `cancel` to leave the inventory and client unchanged. 269.
    // rust: pub(super) fn native_player_pick_item(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from_entity: bool,
    // rust: pos: [i32; 3],
    // rust: entity_id: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_pick_item(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: from_entity,
    // rust: pos,
    // rust: entity_id,
    // rust: cancel,
    // rust: );
}
    /// A server player tries to sleep in the bed whose head is at `pos`
    /// (NeoForge's `CanPlayerSleepEvent`, vanilla's `ServerPlayer.startSleepInBed`).
    /// `problem` is what vanilla found, first problem only: `too_far_away`,
    /// `obstructed`, `not_possible_now` (not night or thunder, the bed rule),
    /// `not_safe` (monsters near), or `None`. A mod may set `None` to let the
    /// player sleep anyway, or one of those names (`other_problem` refuses
    /// without a message) to refuse. The spawn point is set before it fires,
    /// as in vanilla, only when vanilla found no problem. After it,
    /// `native_player_bed_enter` still fires and may cancel. Server-side.
    /// API 393.
    // rust: pub(super) fn native_can_player_sleep(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: problem: &mut Option<String>,
    // rust: ) {
    // rust: mod_api::dispatch_can_player_sleep(self, mod_api::mods(), player, name, pos, problem);
}
    /// A server player is about to enter a bed after the sleep checks pass.
    /// Set `cancel` to keep them out. The player's state is swapped in, but
    /// helpers that look them up through `self.lan` may find nothing during a
    /// guest packet. 251.
    // rust: pub(super) fn native_player_bed_enter(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_bed_enter(self, mod_api::mods(), player, name, pos, cancel);
}
    /// while a guest packet is handled. 252.
    // rust: pub(super) fn native_player_bed_leave(&mut self, player: u128, name: &str, pos: [i32; 3]) {
    // rust: mod_api::dispatch_player_bed_leave(self, mod_api::mods(), player, name, pos);
}
    /// A server player's book edit or signing packet is about to be applied.
    /// `pages` is its page count; `signing` means the packet has a title. Set
    /// `cancel` to drop the edit. Helpers looking up the guest through
    /// `self.lan` may find nothing during the packet. 257.
    // rust: pub(super) fn native_player_edit_book(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pages: i32,
    // rust: signing: bool,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_edit_book(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pages,
    // rust: signing,
    // rust: cancel,
    // rust: );
}
    /// A player shearing a mob is about to do so. Set `cancel` to leave the
    /// mob and shears unchanged. The guest's state is swapped in, though
    /// helpers looking them up through `self.lan` may find nothing during a
    /// guest packet. 275.
    // rust: pub(super) fn native_player_shear_entity(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: i32,
    // rust: off_hand: bool,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_shear_entity(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity_id,
    // rust: off_hand,
    // rust: cancel,
    // rust: );
}
    /// A server player completed an advancement, after progress was recorded.
    /// Helpers looking up the guest through `self.lan` may find nothing during
    /// its packet. 249.
    // rust: pub(super) fn native_player_advancement_done(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: advancement: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_advancement_done(self, mod_api::mods(), player, name, advancement);
}
    /// A criterion of a server player's advancement was granted or revoked,
    /// after its progress changed and before any completion rewards, except
    /// the `minecraft:tick` criteria granted on a network player's first tick
    /// or a reload, which are heard after that tick's rewards and packets. A
    /// grant or revoke that changes nothing is not heard. `granted` is false for a
    /// revoke. Helpers looking up the guest through `self.lan` may find
    /// nothing during its packet. 320.
    // rust: pub(super) fn native_player_advancement_progress(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: advancement: &str,
    // rust: criterion: &str,
    // rust: granted: bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_advancement_progress(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: advancement,
    // rust: criterion,
    // rust: granted,
    // rust: );
}
    /// A statistic is about to be awarded to a server player, before its count
    /// and scoreboard criteria change. `stat_type` and `stat` are ids such as
    /// `minecraft:mined` and `minecraft:stone`, and `value` the amount. Set
    /// `cancel` to award nothing. Helpers looking up the guest through
    /// `self.lan` may find nothing during its packet. Server-side.
    /// 321.
    // rust: pub(super) fn native_player_stat_award(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: stat_type: &str,
    // rust: stat: &str,
    // rust: value: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_stat_award(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: stat_type,
    // rust: stat,
    // rust: value,
    // rust: cancel,
    // rust: );
}
    /// A server player's experience points are about to increase from an orb pickup,
    /// after mending has taken its share. Change `amount` to change the points
    /// added. The player's state is not swapped in, so helpers that look them up
    /// through `self.lan` may find nothing while a guest packet is handled.
    /// Server-side. 260.
    // rust: pub(super) fn native_player_exp_change(&mut self, player: u128, name: &str, amount: &mut i32) {
    // rust: mod_api::dispatch_player_exp_change(self, mod_api::mods(), player, name, amount);
}
    /// A server player's experience points are about to change through
    /// `Player.giveExperiencePoints` (NeoForge's `PlayerXpEvent.XpChange`): an
    /// orb pickup after mending, an advancement reward, or `/xp add ... points`.
    /// Change `amount` (in points) or set `cancel` to give nothing. An orb or
    /// an advancement reward gives nothing for a negative amount. Experience
    /// bottles and furnaces make orbs, so they come through the orb path.
    /// `native_player_exp_change` is separate and still fires first for an orb
    /// pickup. Server-side. API 394.
    // rust: pub(super) fn native_player_xp_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: amount: &mut i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_xp_change(self, mod_api::mods(), player, name, amount, cancel);
}
    /// An item cooldown is about to start for a server player. `item` is the
    /// item id and `ticks` its duration. The player's state is not swapped in,
    /// so helpers that look them up through `self.lan` may find nothing while a
    /// guest packet is handled. Set `cancel` to skip starting the cooldown.
    /// Server-side. 262.
    // rust: pub(super) fn native_player_item_cooldown(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: item: &str,
    // rust: ticks: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_item_cooldown(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: item,
    // rust: ticks,
    // rust: cancel,
    // rust: );
}
    /// A recipe is about to be unlocked for a server player. Set `cancel` to
    /// keep it locked. The player's state is not swapped in, so helpers that
    /// look them up through `self.lan` may find nothing while a guest packet
    /// is handled. Server-side. 273.
    // rust: pub(super) fn native_player_recipe_discovered(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: recipe: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_recipe_discovered(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: recipe,
    // rust: cancel,
    // rust: );
}
    /// A server player's respawn point is about to change. `cause` is `bed`,
    /// `respawn_anchor`, `command` or `death_reset`; `pos` is its block
    /// position. The player's state is not swapped in, so helpers that look
    /// them up through `self.lan` may find nothing while a guest packet is
    /// handled. Set `cancel` to keep the old point. Server-side.
    /// 277.
    // rust: pub(super) fn native_player_spawn_point_set(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: cause: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_spawn_point_set(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: dimension,
    // rust: pos,
    // rust: cause,
    // rust: cancel,
    // rust: );
}
    /// A server player is about to travel through a Nether portal, End portal
    /// or End gateway. `cause` is `nether_portal`, `end_portal` or `end_gateway`.
    /// The player's state is not swapped in, so helpers that look them up
    /// through `self.lan` may find nothing while a guest packet is handled.
    /// Set `cancel` to keep them in their current place. Server-side.
    /// 271.
    // rust: pub(super) fn native_player_portal(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from_dimension: &str,
    // rust: to_dimension: &str,
    // rust: cause: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_portal(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: from_dimension,
    // rust: to_dimension,
    // rust: cause,
    // rust: cancel,
    // rust: );
}
    /// A server player launched with a riptide trident, after the velocity,
    /// spin attack and grounded lift have been applied. The player's state is
    /// swapped in; during a guest packet, helpers that look them up through
    /// `self.lan` may find nothing. No reply is needed. 274.
    // rust: pub(super) fn native_player_riptide(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_riptide(self, mod_api::mods(), player, name);
}
    /// A server player's fishing rod, with `state`: 0 the cast
    /// (`FishingRodItem.use` throwing the bobber), 1 a fish biting
    /// (`FishingHook.catchingFish`), 2 the reel-in of a bite, which gives the
    /// catch, 3 the reel-in with nothing on the line, 4 the reel-in of a
    /// bobber hooked to an entity or item (like Bukkit's `PlayerFishEvent`;
    /// NeoForge's `ItemFishedEvent` is later, in `FishingHook.retrieve`). Set `cancel` on the cast and nothing
    /// is thrown; on a bite the fish gets away and the wait starts over; on
    /// a reel-in (2 to 4) nothing happens, the bobber stays out and the rod
    /// takes no wear. The bobber ending by itself (too far, the rod put
    /// away, the owner dying), nor the host of a LAN world's rod. The
    /// player's state is swapped in, so `native_acting_player`, `native_tell`
    /// and the item helpers reach them. Once for each cast, bite and reel-in,
    /// on a server. 160.
    // rust: pub(super) fn native_player_fish(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: state: i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_fish(self, mod_api::mods(), player, name, state, cancel);
}
    /// A sculk sensor or shrieker received a vibration for `event` at `pos`.
    /// Set `cancel` to suppress its response. Server-side.
    /// 196.
    // rust: pub(super) fn native_block_receive_game(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: block: &str,
    // rust: event: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_receive_game(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: block,
    // rust: event,
    // rust: cancel,
    // rust: );
}
    /// A dispenser sheared `entity` of kind `kind` at the block in front of
    /// its own block at `pos`, after the shearing effects. Server-side.
    /// 197.
    // rust: pub(super) fn native_block_shear_entity(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: ) {
    // rust: mod_api::dispatch_block_shear_entity(self, mod_api::mods(), dimension, pos, entity, kind);
}
    /// A dispenser equipped `item` on the first eligible `target` in front
    /// of its block at `pos`. `target` is `player`, `mob` or `armor_stand`.
    /// The equip, item consumption, sound and game event have completed.
    /// Server-side. 189.
    // rust: pub(super) fn native_block_dispense_armor(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: item: &str,
    // rust: target: &str,
    // rust: ) {
    // rust: mod_api::dispatch_block_dispense_armor(self, mod_api::mods(), dimension, pos, item, target);
}
    /// A brewing stand at `pos` began brewing `ingredient`, after fuel and the timer were set. Server-side. 200.
    // rust: pub(super) fn native_brewing_start(&self, pos: [i32; 3], ingredient: &str) {
    // rust: mod_api::dispatch_brewing_start(self, mod_api::mods(), pos, ingredient);
}
    /// A brewing stand at `pos` consumed `fuel` and gained brewing fuel. Server-side. 199.
    // rust: pub(super) fn native_brewing_fuel(&self, pos: [i32; 3], fuel: &str) {
    // rust: mod_api::dispatch_brewing_fuel(self, mod_api::mods(), pos, fuel);
}
    /// A brewing stand finished brewing at `pos`, after its bottle contents
    /// were changed. Server-side. 198.
    // rust: pub(super) fn native_brewing_complete(&self, pos: [i32; 3]) {
    // rust: mod_api::dispatch_brewing_complete(self, mod_api::mods(), pos);
}
    /// An item was placed on a campfire at `pos` and began cooking. 202.
    // rust: pub(super) fn native_campfire_start(&self, pos: [i32; 3], item: &str) {
    // rust: mod_api::dispatch_campfire_start(self, mod_api::mods(), pos, item);
}
    /// A block finished cooking `item` into `result` at `pos`. 188.
    // rust: pub(super) fn native_block_cook(&self, pos: [i32; 3], item: &str, result: &str) {
    // rust: mod_api::dispatch_block_cook(self, mod_api::mods(), pos, item, result);
}
    /// A compostable item was added to the composter at `pos`. 204.
    // rust: pub(super) fn native_compost_item(&self, pos: [i32; 3], item: &str) {
    // rust: mod_api::dispatch_compost_item(self, mod_api::mods(), pos, item);
}
    /// A crafter at `pos` completed recipe `recipe`. 205.
    // rust: pub(super) fn native_crafter_craft(&self, pos: [i32; 3], recipe: &str) {
    // rust: mod_api::dispatch_crafter_craft(self, mod_api::mods(), pos, recipe);
}
    /// A server player is about to open an inventory supplied by a block at
    /// `pos`. Set `cancel` to leave the inventory closed. The player's state
    /// is not swapped in. 233.
    // rust: pub(super) fn native_inventory_block_start(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_inventory_block_start(self, mod_api::mods(), player, name, pos, cancel);
}
    /// Block `block` at `pos` opens its mod menu type `menu` for server
    /// player `player`: set `data` to hand the menu's screen bytes of your
    /// own (a machine's tier, mode or recipes), up to 32 KiB, which the
    /// client reads with `native_screen_extra_data` while the screen is open
    /// (NeoForge's `openMenu` with an extra-data writer). The first mod to
    /// set it wins, so answer only for your blocks. The player's state is not
    /// swapped in. 401.
    // rust: pub(super) fn native_menu_extra_data(
    // rust: &mut self,
    // rust: player: u128,
    // rust: menu: &str,
    // rust: block: &str,
    // rust: pos: [i32; 3],
    // rust: data: &mut Option<Vec<u8>>,
    // rust: ) {
    // rust: mod_api::dispatch_menu_extra_data(self, mod_api::mods(), player, menu, block, pos, data);
}

    /// A sculk catalyst at `pos` has begun blooming after taking experience.
    /// The catalyst block state has changed. Server-side.
    /// 296.
    // rust: pub(super) fn native_sculk_bloom(&mut self, dimension: &str, pos: [i32; 3]) {
    // rust: mod_api::dispatch_sculk_bloom(self, mod_api::mods(), dimension, pos);
}

    /// A projectile hit the target block at `pos`, which now has `strength`
    /// output power. Server-side. 299.
    // rust: pub(super) fn native_target_hit(&mut self, dimension: &str, pos: [i32; 3], strength: i32) {
    // rust: mod_api::dispatch_target_hit(self, mod_api::mods(), dimension, pos, strength);
}

    /// A vault at `pos` changed to `state`. Its block state is updated.
    /// Server-side. 303.
    // rust: pub(super) fn native_vault_change_state(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: state: &str,
    // rust: ) {
    // rust: mod_api::dispatch_vault_change_state(self, mod_api::mods(), dimension, pos, state);
}

    /// A dispenser at `pos` failed to dispense `item`. Server-side.
    /// 192.
    // rust: pub(super) fn native_block_failed_dispense(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: item: &str,
    // rust: ) {
    // rust: mod_api::dispatch_block_failed_dispense(self, mod_api::mods(), dimension, pos, item);
}

    /// A beacon at `pos` activated or deactivated after its beam was checked.
    /// `active` says whether it now has a complete pyramid. Server-side.
    /// 184.
    // rust: pub(super) fn native_beacon_state_change(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: active: bool,
    // rust: ) {
    // rust: mod_api::dispatch_beacon_state_change(self, mod_api::mods(), dimension, pos, active);
}

    /// An anvil at `pos` took damage, changing its block from `from` to `to`.
    /// `to` is air when the anvil broke. Server-side.
    /// 183.
    // rust: pub(super) fn native_anvil_damaged(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: from: &str,
    // rust: to: &str,
    // rust: ) {
    // rust: mod_api::dispatch_anvil_damaged(self, mod_api::mods(), dimension, pos, from, to);
}

    /// A server guest's block-breaking animation changed to `progress` at
    /// `pos` (0 through 9). 186.
    // rust: pub(super) fn native_block_break_progress_update(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: progress: i32,
    // rust: ) {
    // rust: mod_api::dispatch_block_break_progress_update(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pos,
    // rust: progress,
    // rust: );
}

    /// A guest's block inventory lock check at `pos`. `locked` is the
    /// vanilla result and may be changed. The guest's state is not swapped in.
    /// 195.
    // rust: pub(super) fn native_block_lock_check(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: locked: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_block_lock_check(self, mod_api::mods(), player, name, pos, locked);
}

    /// A server player reset their attack strength by swinging (`handlePunch`).
    /// The swing and reset have already happened. The player's state is not
    /// swapped in, and helpers looking them up through `self.lan` may find
    /// nothing during a guest packet. Server-side. 250.
    // rust: pub(super) fn native_player_attack_cooldown_reset(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_attack_cooldown_reset(self, mod_api::mods(), player, name);
}
    /// A server player caught a mob in a bucket, after it was removed and the
    /// filled bucket was given. Helpers looking up the guest through
    /// `self.lan` may find nothing during its packet. Server-side.
    /// 253.
    // rust: pub(super) fn native_player_bucket_entity(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: i32,
    // rust: entity: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_bucket_entity(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity_id,
    // rust: entity,
    // rust: );
}
    /// A server player changed a beacon's selected effects, after they were
    /// stored. Empty effect ids mean no effect. Helpers looking up the guest
    /// through `self.lan` may find nothing during its packet. Server-side.
    /// 254.
    // rust: pub(super) fn native_player_change_beacon_effect(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: primary: &str,
    // rust: secondary: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_change_beacon_effect(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pos,
    // rust: primary,
    // rust: secondary,
    // rust: );
}
    /// A server player has slept for 100 ticks in a bed and now counts as
    /// deeply asleep for the night-skip check. Helpers looking the guest up
    /// through `self.lan` may find nothing during its tick. 256.
    // rust: pub(super) fn native_player_deep_sleep(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_deep_sleep(self, mod_api::mods(), player, name);
}
    /// A server player changed their client option for the dominant hand. `left` is true for
    /// left-handed. Their state is not swapped in, and helpers looking them up through `self.lan`
    /// may find nothing during guest packet handling. Server-side.
    /// 255.
    // rust: pub(super) fn native_player_change_main_hand(&mut self, player: u128, name: &str, left: bool) {
    // rust: mod_api::dispatch_player_change_main_hand(self, mod_api::mods(), player, name, left);
}
    /// A server player threw an egg, after its projectile was launched and
    /// the use was applied. Helpers looking up the guest through `self.lan`
    /// may find nothing during its packet. Server-side. 258.
    // rust: pub(super) fn native_player_egg_throw(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_egg_throw(self, mod_api::mods(), player, name);
}
    /// A server player used a firework rocket to boost while gliding, after
    /// the rocket was launched and consumed. Helpers looking up the guest
    /// through `self.lan` may find nothing during its packet. Server-side.
    /// 259.
    // rust: pub(super) fn native_player_elytra_boost(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_elytra_boost(self, mod_api::mods(), player, name);
}
    /// A server player put a plant into a flower pot, after the potted block
    /// state was stored and the item consumed. `plant` is the item id and
    /// `pos` the pot position. Helpers looking up the guest through `self.lan`
    /// may find nothing during packet handling. Server-side. 238.
    // rust: pub(super) fn native_player_flower_pot_manipulate(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: plant: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_flower_pot_manipulate(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pos,
    // rust: plant,
    // rust: );
}
    /// A server player inserted a book into a lectern, after the block entity
    /// and inventory changed. `book` is the item id. Helpers looking up a
    /// guest through `self.lan` may find nothing during packet handling.
    /// Server-side. 239.
    // rust: pub(super) fn native_player_insert_lectern_book(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: book: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_insert_lectern_book(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pos,
    // rust: book,
    // rust: );
}
    /// A server player took the book from a lectern, after the menu and block
    /// entity changed. `book` is the removed item id. Helpers looking up a
    /// guest through `self.lan` may find nothing during packet handling.
    /// Server-side. 243.
    // rust: pub(super) fn native_player_take_lectern_book(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: book: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_take_lectern_book(self, mod_api::mods(), player, name, pos, book);
}
    /// A server player changed the page of a lectern, after its page and
    /// redstone pulse changed. `page` is the zero-based new page. Helpers
    /// looking up a guest through `self.lan` may find nothing during packet
    /// handling. Server-side. 242.
    // rust: pub(super) fn native_player_lectern_page_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: page: i32,
    // rust: ) {
    // rust: mod_api::dispatch_player_lectern_page_change(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: pos,
    // rust: page,
    // rust: );
}
    /// A server player changed an item frame after its contents or rotation
    /// changed. `action` is `put`, `rotate`, `remove_item` or `break`; `item`
    /// is empty when no item remains, and `rotation` is the resulting step.
    /// Helpers looking up the guest through `self.lan` may find nothing during
    /// packet handling. Server-side. 240.
    // rust: pub(super) fn native_player_item_frame_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: u32,
    // rust: action: &str,
    // rust: item: &str,
    // rust: rotation: u8,
    // rust: ) {
    // rust: mod_api::dispatch_player_item_frame_change(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity_id,
    // rust: action,
    // rust: item,
    // rust: rotation,
    // rust: );
}
    /// Mending repaired a server player's item with experience from an orb.
    /// `repair` is durability restored and `experience` is the orb's value.
    /// Helpers looking up the guest through `self.lan` may find nothing during
    /// packet handling. Server-side. 241.
    // rust: pub(super) fn native_player_item_mend(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: item: &str,
    // rust: repair: u32,
    // rust: experience: u32,
    // rust: ) {
    // rust: mod_api::dispatch_player_item_mend(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: item,
    // rust: repair,
    // rust: experience,
    // rust: );
}
    /// A server player completed a villager or wandering trader trade.
    /// `entity_id` is the merchant network id. Helpers looking up the guest
    /// through `self.lan` may find nothing during packet handling. Server-side.
    /// 283.
    // rust: pub(super) fn native_player_trade(&mut self, player: u128, name: &str, entity_id: u32) {
    // rust: mod_api::dispatch_player_trade(self, mod_api::mods(), player, name, entity_id);
}
    /// A server player traded with a villager or a wandering trader
    /// (NeoForge's `TradeWithVillagerEvent`, at vanilla's
    /// `MerchantResultSlot.onTake` once the offer is taken): `merchant` is
    /// the trader's entity id and `kind` its type (`minecraft:villager`,
    /// `minecraft:wandering_trader`), `offer` the trade as it is after this
    /// one (its `uses` counted, `result` what the player got). Once per
    /// trade, so a shift-click that trades several times is heard for each,
    /// after the trade's statistic and `villager_trade` trigger. Listen
    /// only: the trade is made. The player's state is swapped in
    /// (`native_acting_player`). API 310.
    // rust: pub(super) fn native_trade_with_villager(
    // rust: &mut self,
    // rust: merchant: u32,
    // rust: kind: &str,
    // rust: offer: &MerchantOffer,
    // rust: ) {
    // rust: mod_api::dispatch_trade_with_villager(self, mod_api::mods(), merchant, kind, offer);
}
    /// A trade of a villager or a wandering trader was made and its `offer`
    /// (the live one in the trading session, not a copy) is in the state the
    /// trade left it in: `uses` counted. A mod may change it (Bukkit's
    /// `PlayerTradeEvent#getTrade` is mutable): `uses`, `max_uses`, `demand`,
    /// `special_price_diff`, `price_multiplier`, `xp`. The change stands: the
    /// next click and the offers sent to the player see it. Once per trade (a
    /// shift-click that trades several times asks for each trade only after
    /// the click, so the stock it ran down in that click is not given back
    /// before the click ends), before the trade's statistic and
    /// `trade_with_villager`, which hear the offer as the trade left it.
    /// `merchant` is the trader's entity id, `kind` its type. Not asked for a
    /// trade window without a trader. Server-side. API
    /// 406.
    // rust: pub(super) fn native_merchant_offer_traded(
    // rust: &mut self,
    // rust: merchant: u32,
    // rust: kind: &str,
    // rust: offer: &mut MerchantOffer,
    // rust: ) {
    // rust: mod_api::dispatch_merchant_offer_traded(self, mod_api::mods(), merchant, kind, offer);
}
    /// A server player's shield was disabled by a blocked melee hit. The
    /// shield cooldown is set immediately after this call. Helpers looking up
    /// the guest through `self.lan` may find nothing during packet handling.
    /// Server-side. 276.
    // rust: pub(super) fn native_player_shield_disable(&mut self, player: u128, name: &str, ticks: u32) {
    // rust: mod_api::dispatch_player_shield_disable(self, mod_api::mods(), player, name, ticks);
}
    /// A server player selected a loom pattern, after the loom menu accepted
    /// the button. `pattern` is the zero-based button index. Helpers looking
    /// up the guest through `self.lan` may find nothing during packet handling.
    /// Server-side. 265.
    // rust: pub(super) fn native_player_loom_pattern_select(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pattern: i32,
    // rust: ) {
    // rust: mod_api::dispatch_player_loom_pattern_select(self, mod_api::mods(), player, name, pattern);
}
    /// A server player named a mob with a name tag, after its name and
    /// persistence changed and the tag was consumed. Helpers looking up the
    /// guest through `self.lan` may find nothing during packet handling.
    /// Server-side. 267.
    // rust: pub(super) fn native_player_name_entity(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: u32,
    // rust: entity_name: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_name_entity(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity_id,
    // rust: entity_name,
    // rust: );
}
    /// A server player opened a sign for editing, after the editor state was
    /// made. `front` selects the front or back side. Guest lookup helpers may
    /// find nothing during packet handling. Server-side.
    /// 268.
    // rust: pub(super) fn native_player_open_sign(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: front: bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_open_sign(self, mod_api::mods(), player, name, pos, front);
}
    /// A server player picked up an arrow after it was removed and its pickup
    /// was applied. `item` is the arrow's pickup item id. Guest lookup helpers
    /// may find nothing during packet handling. Server-side.
    /// 270.
    // rust: pub(super) fn native_player_pickup_arrow(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: u32,
    // rust: item: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_pickup_arrow(self, mod_api::mods(), player, name, entity_id, item);
}
    /// A server player selected a stonecutter recipe, after the menu accepted
    /// its button. `recipe` is the zero-based button index. Guest lookup
    /// helpers may find nothing during packet handling. Server-side.
    /// 278.
    // rust: pub(super) fn native_player_stonecutter_recipe_select(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: recipe: i32,
    // rust: ) {
    // rust: mod_api::dispatch_player_stonecutter_recipe_select(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: recipe,
    // rust: );
}
    /// A server player stopped spectating `entity_id`, after their camera
    /// returned to the player. Guest lookup helpers may find nothing.
    /// 279.
    // rust: pub(super) fn native_player_stop_spectating_entity(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: i32,
    // rust: ) {
    // rust: mod_api::dispatch_player_stop_spectating_entity(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity_id,
    // rust: );
}
    /// A server applied `velocity` to a player, when syncing changed motion to
    /// that player's client. Guest lookup helpers may find nothing.
    /// 285.
    // rust: pub(super) fn native_player_velocity(&mut self, player: u128, name: &str, velocity: [f64; 3]) {
    // rust: mod_api::dispatch_player_velocity(self, mod_api::mods(), player, name, velocity);
}
    /// A server player removed an entity's leash, after it was cleared.
    /// Guest lookup helpers may find nothing during packet handling.
    /// 284.
    // rust: pub(super) fn native_player_unleash_entity(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: u32,
    // rust: ) {
    // rust: mod_api::dispatch_player_unleash_entity(self, mod_api::mods(), player, name, entity_id);
}
    /// A server player toggled an ageable mob's age lock with a golden
    /// dandelion, after the lock and item use changed. 282.
    // rust: pub(super) fn native_player_toggle_entity_age_lock(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity_id: u32,
    // rust: locked: bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_toggle_entity_age_lock(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity_id,
    // rust: locked,
    // rust: );
}
    /// A server player swapped their main and off hands, after both inventory
    /// slots changed. Guest lookup helpers may find nothing during packet
    /// handling. Server-side. 280.
    // rust: pub(super) fn native_player_swap_with_equipment_slot(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: slot: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_swap_with_equipment_slot(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: slot,
    // rust: );
}
    /// A server player filled an empty map, after the filled map and its saved
    /// data were created. Guest lookup helpers may find nothing during packet
    /// handling. Server-side. 266.
    // rust: pub(super) fn native_player_map_filled(&mut self, player: u128, name: &str, map_id: i32) {
    // rust: mod_api::dispatch_player_map_filled(self, mod_api::mods(), player, name, map_id);
}
    /// A server player is about to travel through an End gateway at `gateway`.
    /// Set `cancel` to leave them at the entrance; the gateway is not consumed
    /// and its cooldown does not start. Helpers may find no guest through
    /// `self.lan` during its packet. Server-side. 281.
    // rust: pub(super) fn native_player_teleport_end_gateway(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: gateway: [i32; 3],
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_teleport_end_gateway(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: gateway,
    // rust: cancel,
    // rust: );
}
    /// A server player's recipe book requested a known recipe be placed in
    /// their crafting grid. `recipe` is the recipe id; `all` is the shift
    /// click form. The player's state may not be available through `self.lan`
    /// while a guest packet is handled. Server-side. 272.
    // rust: pub(super) fn native_player_recipe_book_click(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: recipe: &str,
    // rust: all: bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_recipe_book_click(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: recipe,
    // rust: all,
    // rust: );
}
    /// A server player's XP orb pickup cooldown changed to `ticks`. It is
    /// reported after the value changes; the player's state may not be found
    /// through `self.lan` while a guest packet is handled. Server-side.
    /// 261.
    // rust: pub(super) fn native_player_exp_cooldown_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: ticks: u32,
    // rust: ) {
    // rust: mod_api::dispatch_player_exp_cooldown_change(self, mod_api::mods(), player, name, ticks);
}
    /// A server player changed their client language option to `locale`.
    /// The player's state may not be found through `self.lan` during a guest
    /// packet. Server-side. 264.
    // rust: pub(super) fn native_player_locale_change(&mut self, player: u128, name: &str, locale: &str) {
    // rust: mod_api::dispatch_player_locale_change(self, mod_api::mods(), player, name, locale);
}
    /// A server entity was moved by a same-level teleport command, after its
    /// position changed. `entity` is its network id; `from` and `to` are
    /// coordinates in `dimension`. This hook reports command teleports that
    /// use Horizon's same-level target path; it does not change vanilla's
    /// movement. 221.
    // rust: pub(super) fn native_entity_teleport(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: entity: u32,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: ) {
    // rust: mod_api::dispatch_entity_teleport(self, mod_api::mods(), dimension, entity, from, to);
}

    /// A server entity finished its portal wait and is beginning to leave
    /// `dimension` through `pos`. The destination follows the portal rules.
    /// 217.
    // rust: pub(super) fn native_entity_portal(&mut self, dimension: &str, entity: u32, pos: [i32; 3]) {
    // rust: mod_api::dispatch_entity_portal(self, mod_api::mods(), dimension, entity, pos);
}

    /// A server projectile was added to the level. `player` is set only for
    /// a player launch; other sources have an empty `name`. 293.
    // rust: pub(super) fn native_projectile_launch(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: name: &str,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: ) {
    // rust: mod_api::dispatch_projectile_launch(self, mod_api::mods(), player, name, entity, kind);
}

    /// A player bow or crossbow launched an arrow with `force`, after the
    /// projectile entered the level. 219.
    // rust: pub(super) fn native_entity_shoot_bow(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: projectile: u32,
    // rust: force: f32,
    // rust: ) {
    // rust: mod_api::dispatch_entity_shoot_bow(self, mod_api::mods(), player, name, projectile, force);
}

    /// A player is about to nock `bow` with `hand` (`BowItem.use`, NeoForge's
    /// `ArrowNockEvent`): `has_ammo` is whether `getProjectile` found ammunition
    /// or the player is in creative. Set `cancel` to fail the use.
    /// 375.
    // rust: pub(super) fn native_arrow_nock(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: bow: &ItemStack,
    // rust: hand: Hand,
    // rust: has_ammo: bool,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_arrow_nock(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: bow,
    // rust: hand,
    // rust: has_ammo,
    // rust: cancel,
    // rust: );
}

    /// `LivingEntity.getProjectile(weapon)` (NeoForge's
    /// `LivingGetProjectileEvent`) for a player (`player` and `name`) or a
    /// mob (`entity`, `kind`): a skeleton or illusioner's shot, or the crossbow
    /// load of a pillager or piglin. `projectile` is the vanilla
    /// ammunition; replace it to choose another. A replaced stack is not taken
    /// from the inventory. 376.
    // rust: pub(super) fn native_living_get_projectile(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: name: &str,
    // rust: entity: Option<u32>,
    // rust: kind: &str,
    // rust: weapon: &ItemStack,
    // rust: projectile: &mut Option<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_living_get_projectile(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity,
    // rust: kind,
    // rust: weapon,
    // rust: projectile,
    // rust: );
}

    /// A guest's fall flying state changed on the server. The change has
    /// already been applied. 222.
    // rust: pub(super) fn native_entity_toggle_glide(&mut self, player: u128, name: &str, gliding: bool) {
    // rust: mod_api::dispatch_entity_toggle_glide(self, mod_api::mods(), player, name, gliding);
}

    /// A guest player's synchronized pose changed from `from` to `to`.
    /// 218.
    // rust: pub(super) fn native_entity_pose_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: &str,
    // rust: to: &str,
    // rust: ) {
    // rust: mod_api::dispatch_entity_pose_change(self, mod_api::mods(), player, name, from, to);
}

    /// A dropped item entity was successfully added to the server level.
    /// 234.
    // rust: pub(super) fn native_item_spawn(&mut self, entity: u32, item: &str, count: i32, pos: [f64; 3]) {
    // rust: mod_api::dispatch_item_spawn(self, mod_api::mods(), entity, item, count, pos);
}

    /// A mob became tamed after its owner and persistent state were set.
    /// 220.
    // rust: pub(super) fn native_entity_tame(&mut self, entity: u32, kind: &str, owner: Option<u128>) {
    // rust: mod_api::dispatch_entity_tame(self, mod_api::mods(), entity, kind, owner);
}

    /// Two mobs completed a breeding action. `child` is absent when vanilla
    /// lays an egg instead of creating a baby. 213.
    // rust: pub(super) fn native_entity_breed(&mut self, parent: u32, partner: u32, child: Option<u32>) {
    // rust: mod_api::dispatch_entity_breed(self, mod_api::mods(), parent, partner, child);
}

    /// A furnace at `pos` began cooking `item` (its cooking timer advanced
    /// from zero). Server-side.
    /// 230.
    // rust: pub(super) fn native_furnace_start_smelt(&self, pos: [i32; 3], item: &str) {
    // rust: mod_api::dispatch_furnace_start_smelt(self, mod_api::mods(), pos, item);
}
    /// A furnace at `pos` consumed fuel and began or resumed burning it.
    /// `fuel` is the item consumed from its fuel slot. Server-side.
    /// 227.
    // rust: pub(super) fn native_furnace_burn(&self, pos: [i32; 3], fuel: &str) {
    // rust: mod_api::dispatch_furnace_burn(self, mod_api::mods(), pos, fuel);
}
    /// A furnace finished smelting `item` into `result` at `pos`. Server-side.
    /// 229.
    // rust: pub(super) fn native_furnace_smelt(&self, pos: [i32; 3], item: &str, result: &str) {
    // rust: mod_api::dispatch_furnace_smelt(self, mod_api::mods(), pos, item, result);
}
    /// A server player took an output from a furnace at `pos`; `item` is the
    /// output item id and `count` is how many were taken. The player's state is
    /// not swapped in, so helpers that look them up through `self.lan` may find
    /// nothing during guest packet handling. 228.
    // rust: pub(super) fn native_furnace_extract(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: item: &str,
    // rust: count: u32,
    // rust: ) {
    // rust: mod_api::dispatch_furnace_extract(self, mod_api::mods(), player, name, pos, item, count);
}
    /// A server player applied an enchantment at `pos`; `item` is the finished item and `levels` the levels charged. The player's state is not swapped in. 209.
    // rust: pub(super) fn native_enchant_item(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: item: &ItemStack,
    // rust: levels: i32,
    // rust: ) {
    // rust: mod_api::dispatch_enchant_item(self, mod_api::mods(), player, name, pos, item, levels);
}
    /// Enchanting offers were calculated for a server player at `pos`. Change `costs` before they are sent to the menu. 291.
    // rust: pub(super) fn native_prepare_item_enchant(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: costs: &mut [i32; 3],
    // rust: ) {
    // rust: mod_api::dispatch_prepare_item_enchant(self, mod_api::mods(), player, name, pos, costs);
}
    /// An anvil result was prepared for a server player at `pos`. Change `result` or its level `cost` before it is sent. 288.
    // rust: pub(super) fn native_prepare_anvil(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: result: &mut Option<ItemStack>,
    // rust: cost: &mut i32,
    // rust: ) {
    // rust: mod_api::dispatch_prepare_anvil(self, mod_api::mods(), player, name, pos, cost, result);
}
    /// A player took an anvil's result at `pos` (`AnvilCraftEvent.Pre`), before the levels are charged, the inputs used up and the anvil worn. `craft` holds the inputs and the result as they were before. Set `cancel` to refuse the take: the result stays in its slot and the inputs, levels, inventory and cursor are as before the click. 328.
    // rust: pub(super) fn native_anvil_craft_pre(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: craft: &horizon_client::menu::AnvilCraft,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_anvil_craft_pre(self, mod_api::mods(), player, name, pos, craft, cancel);
}
    /// A player took an anvil's result at `pos` and the levels, inputs and anvil wear are done (`AnvilCraftEvent.Post`); a broken anvil is already air. `craft` holds the inputs and the result as they were before. Not called when `native_anvil_craft_pre` cancelled. 327.
    // rust: pub(super) fn native_anvil_craft_post(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: craft: &horizon_client::menu::AnvilCraft,
    // rust: ) {
    // rust: mod_api::dispatch_anvil_craft_post(self, mod_api::mods(), player, name, pos, craft);
}
    /// A grindstone result was prepared for a server player at `pos`. Change it before it is sent. 289.
    // rust: pub(super) fn native_prepare_grindstone(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: result: &mut Option<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_prepare_grindstone(self, mod_api::mods(), player, name, pos, result);
}
    /// A smithing result was prepared for a server player at `pos`. Change it before it is sent. 292.
    // rust: pub(super) fn native_prepare_smithing(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: [i32; 3],
    // rust: result: &mut Option<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_prepare_smithing(self, mod_api::mods(), player, name, pos, result);
}
    /// A crafting-grid result was prepared for a server player; `pos` is the crafting table, or None for the inventory grid. Change `result` before it is sent. 290.
    // rust: pub(super) fn native_prepare_item_craft(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: pos: Option<[i32; 3]>,
    // rust: result: &mut Option<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_prepare_item_craft(self, mod_api::mods(), player, name, pos, result);
}
    /// A server player selected trade `index` from `villager` in the trading menu. 302.
    // rust: pub(super) fn native_trade_select(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: villager: Option<u32>,
    // rust: index: usize,
    // rust: ) {
    // rust: mod_api::dispatch_trade_select(self, mod_api::mods(), player, name, villager, index);
}
    /// The server changed its weather parameters. `raining` and `thundering`
    /// are the requested final states. Set `cancel` to keep the previous
    /// weather parameters. Server-side. 304.
    // rust: pub(super) fn native_weather_change(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: raining: bool,
    // rust: thundering: bool,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_weather_change(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: raining,
    // rust: thundering,
    // rust: cancel,
    // rust: );
}

    /// The server changed its thunder state through `/weather`. Set `cancel`
    /// to keep the previous thunder state and timer. Server-side.
    /// 300.
    // rust: pub(super) fn native_thunder_change(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: thundering: bool,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_thunder_change(self, mod_api::mods(), dimension, thundering, cancel);
}

    /// A server lightning bolt is about to be created. `cause` is `weather`,
    /// `trident` or `command`; `player` is the responsible player when known.
    /// Set `cancel` to prevent the bolt and its effects. 236.
    // rust: pub(super) fn native_lightning_strike(
    // rust: &mut self,
    // rust: player: Option<u128>,
    // rust: pos: [i32; 3],
    // rust: cause: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_lightning_strike(self, mod_api::mods(), player, pos, cause, cancel);
}

    /// Enough players have slept through the night in level `dimension`
    /// and the clock is about to move to the morning (NeoForge's
    /// `SleepFinishedTimeEvent`, vanilla's `ServerLevel.tick` when it moves
    /// the clock to `wake_up_from_sleep`): `new_time` comes in as the next
    /// morning's day time and may be changed to wake everyone at another
    /// time. A time before `current` (the day time now) is refused, as
    /// `setTimeAddition` refuses one, and the morning stays. Unlike
    /// NeoForge, which refuses a bad value as it is set, the check runs once
    /// after every mod, so a later mod sees the value an earlier one left.
    /// On the server, only when the `advance_time` rule is on;
    /// `native_time_skip` then hears the jump to the time chosen here and
    /// may still cancel it. The players wake and the weather resets as
    /// usual either way.
    /// API 308.
    // rust: pub(super) fn native_sleep_finished_time(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: current: i64,
    // rust: new_time: &mut i64,
    // rust: ) {
    // rust: mod_api::dispatch_sleep_finished_time(self, mod_api::mods(), dimension, current, new_time);
}

    /// A slime or magma cube is dying and about to split into smaller ones
    /// (NeoForge's `MobSplitEvent`, vanilla's `Slime.remove`): `parent` is
    /// its entity id, `kind` its type, `size` its size, `child_size` the
    /// size of the children (half of it) and `count` how many vanilla drew
    /// (2 to 4). A mod may change `count` (0 spawns none, at most 64) or set
    /// `cancel` to spawn no children. Only for a parent above size 1; the
    /// split's random draw is made first. On the server. API 396.
    // rust: pub(super) fn native_mob_split(
    // rust: &mut self,
    // rust: parent: u32,
    // rust: kind: &str,
    // rust: size: i32,
    // rust: child_size: i32,
    // rust: count: &mut u32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_mob_split(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: parent,
    // rust: kind,
    // rust: size,
    // rust: child_size,
    // rust: count,
    // rust: cancel,
    // rust: );
}

    /// Two animals bred and a baby is about to be made (NeoForge's
    /// `BabyEntitySpawnEvent`, vanilla's `Animal.spawnChildFromBreeding`):
    /// `parent` and `partner` are entity ids, `player` the UUID of the
    /// player who fed them into love (0 when none), `kind` the baby's type
    /// (a horse and a donkey have a mule). Set `cancel` for no baby: the
    /// parents still rest and lose their love (their ages were already set
    /// to 6000), but there is no baby, no experience, no `animals_bred`
    /// statistic, no advancement and no heart particles, as NeoForge
    /// returns before `finalizeSpawnChildFromBreeding`. Not fired for
    /// turtles, frogs and sniffers (an egg, no baby), villagers or
    /// armadillos' own paths. On the server. API 395.
    // rust: pub(super) fn native_baby_entity_spawn(
    // rust: &mut self,
    // rust: parent: u32,
    // rust: partner: u32,
    // rust: player: u128,
    // rust: kind: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_baby_entity_spawn(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: parent,
    // rust: partner,
    // rust: player,
    // rust: kind,
    // rust: cancel,
    // rust: );
}

    /// The overworld clock is about to jump, from sleep or `/time`. Set
    /// `cancel` to keep `from`. 301.
    // rust: pub(super) fn native_time_skip(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: from: i64,
    // rust: to: i64,
    // rust: cause: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_time_skip(self, mod_api::mods(), dimension, from, to, cause, cancel);
}

    /// Possible natural spawns at a server position (NeoForge's
    /// `LevelEvent.PotentialSpawns`, `NaturalSpawner.mobsAt`). Mods may add or
    /// remove entries, or cancel to make the list empty.
    /// 388.
    // rust: pub(super) fn native_potential_spawns(
    // rust: &self,
    // rust: dimension: &str,
    // rust: category: &str,
    // rust: pos: [i32; 3],
    // rust: entries: &mut Vec<SpawnEntry>,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_potential_spawns(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: category,
    // rust: pos,
    // rust: entries,
    // rust: canceled,
    // rust: );
}

    /// The world's spawn point changed to `pos` and `angle`. 244.
    // rust: pub(super) fn native_spawn_change(&mut self, pos: [i32; 3], angle: [f32; 2]) {
    // rust: mod_api::dispatch_spawn_change(self, mod_api::mods(), pos, angle);
}

    /// A server game rule changed to its final `value`. 247.
    // rust: pub(super) fn native_world_game_rule_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: rule: &str,
    // rust: value: &str,
    // rust: ) {
    // rust: mod_api::dispatch_world_game_rule_change(self, mod_api::mods(), player, name, rule, value);
}

    /// The server world's border bounds changed, either immediately or when
    /// its timed size change was requested. 245.
    // rust: pub(super) fn native_world_border_bounds_changed(&mut self) {
    // rust: mod_api::dispatch_world_border_bounds_changed(self, mod_api::mods());
}

    /// The server world's border center changed. 246.
    // rust: pub(super) fn native_world_border_center_changed(&mut self) {
    // rust: mod_api::dispatch_world_border_center_changed(self, mod_api::mods());
}

    /// A Nether portal was built for a dimension travel, or an End platform
    /// was made for an arrival. `pos` is the lower corner of the Nether
    /// portal rectangle or the End platform origin. The completed blocks are
    /// already in the world. 286.
    // rust: pub(super) fn native_portal_create(&mut self, dimension: &str, pos: [i32; 3]) {
    // rust: mod_api::dispatch_portal_create(self, mod_api::mods(), dimension, pos);
}

    /// A village siege found a spawn position on the server. Set `canceled`
    /// to stop the siege. There is one siege per dimension.
    /// 389.
    // rust: pub(super) fn native_village_siege(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: player: u128,
    // rust: attempted_pos: [f64; 3],
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_village_siege(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: player,
    // rust: attempted_pos,
    // rust: canceled,
    // rust: );
}

    /// A raid wave has been spawned at `pos`; `wave` is its one-based wave
    /// number and `raiders` counts the raiders, not the mobs they ride. 294.
    // rust: pub(super) fn native_raid_spawn_wave(
    // rust: &mut self,
    // rust: raid: i32,
    // rust: pos: [i32; 3],
    // rust: wave: i32,
    // rust: raiders: usize,
    // rust: ) {
    // rust: mod_api::dispatch_raid_spawn_wave(self, mod_api::mods(), raid, pos, wave, raiders);
}

    /// A raid at `pos` changed to `state` (`triggered`, `victory`, `loss` or
    /// `stopped`). 295.
    // rust: pub(super) fn native_raid_state_change(&mut self, raid: i32, pos: [i32; 3], state: &str) {
    // rust: mod_api::dispatch_raid_state_change(self, mod_api::mods(), raid, pos, state);
}

    /// The server completed a world save cycle. `wait` says chunk writes were
    /// flushed before returning. 306.
    // rust: pub(super) fn native_world_saved(&mut self, wait: bool) {
    // rust: mod_api::dispatch_world_saved(self, mod_api::mods(), wait);
}

    /// Entities from `chunk` finished loading into the server world. `count`
    /// is the number of saved entity records read. 210.
    // rust: pub(super) fn native_entities_load(&mut self, dimension: &str, chunk: [i32; 2], count: usize) {
    // rust: mod_api::dispatch_entities_load(self, mod_api::mods(), dimension, chunk, count);
}

    /// Entities in `chunk` left the active server world and were queued for
    /// saving. `count` is the number of entity records. 211.
    // rust: pub(super) fn native_entities_unload(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: chunk: [i32; 2],
    // rust: count: usize,
    // rust: ) {
    // rust: mod_api::dispatch_entities_unload(self, mod_api::mods(), dimension, chunk, count);
}

    /// A generic world game event was fired at `pos`. 231.
    // rust: pub(super) fn native_game_event(&mut self, event: &str, pos: [f64; 3]) {
    // rust: mod_api::dispatch_game_event(self, mod_api::mods(), event, pos);
}

    /// A guest asked to complete `command`; `suggestions` may be added to or
    /// filtered. `range` is the replaced byte range. 298.
    // rust: pub(super) fn native_tab_complete(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: command: &str,
    // rust: range: [usize; 2],
    // rust: suggestions: &mut Vec<Suggestion>,
    // rust: ) {
    // rust: mod_api::dispatch_tab_complete(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: command,
    // rust: range,
    // rust: suggestions,
    // rust: );
}

    /// A server broadcast line is about to be logged and sent. Change `line`
    /// or set `cancel` to drop it. 201.
    // rust: pub(super) fn native_broadcast_message(&self, line: &mut Text, cancel: &mut bool) {
    // rust: mod_api::dispatch_broadcast_message(self, mod_api::mods(), line, cancel);
}

    /// NeoForge's `ClientChatReceivedEvent`: a chat line from the server is
    /// about to show, once Chat Delay lets it through. `system` is a system
    /// message (`ClientChatReceivedEvent.System`), shown in the action bar
    /// when `overlay` is set; otherwise a player or disguised message in its
    /// chat type `chat_type` (`getBoundChatType`, its registry name; `None`
    /// for a system message or an inline chat type). `sender` is the player's
    /// UUID, 0 (`Util.NIL_UUID`) for system and disguised messages. `message`
    /// starts as the decorated line; replace it and the chat shows the new
    /// one, while the narrator still says the original. Set `cancel` and it
    /// doesn't show: a delayed message lets the next one through. Lines the
    /// client adds itself and validation errors are not told. Client-side.
    /// API 403.
    // rust: pub(super) fn native_client_chat_received(
    // rust: &mut self,
    // rust: system: bool,
    // rust: overlay: bool,
    // rust: sender: u128,
    // rust: chat_type: Option<&str>,
    // rust: message: &mut Text,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_client_chat_received(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: system,
    // rust: overlay,
    // rust: sender,
    // rust: chat_type,
    // rust: message,
    // rust: cancel,
    // rust: );
}

    /// NeoForge's `ToastAddEvent`: a new toast is about to be queued. `kind`
    /// is `advancement`, `recipe`, `tutorial`, `system` or `now_playing`;
    /// `id` is the advancement id, the first recipe id, the tutorial hint
    /// (`move`, `look`, `find_tree`, `punch_tree`, `open_inventory`,
    /// `craft_planks`, `socialInteractions`), the system toast's id (`narrator_toggle`,
    /// `pack_load_failure`, `pack_download`, `low_disk_space`,
    /// `chunk_load_failure`, `chunk_save_failure`), or empty for
    /// `now_playing`. An update to a toast already queued or shown is not an
    /// add. Set `cancel` and it isn't queued, shown or sounded. Title-screen
    /// toasts are not told. Client-side. API @API:toast_add@.
    // rust: pub(super) fn native_toast_add(&mut self, kind: &str, id: &str, cancel: &mut bool) {
    // rust: mod_api::dispatch_toast_add(self, mod_api::mods(), kind, id, cancel);
}

    /// The dedicated server's whitelist changed to `enabled`. 305.
    // rust: pub(super) fn native_whitelist_state_update(&mut self, enabled: bool) {
    // rust: mod_api::dispatch_whitelist_state_update(self, mod_api::mods(), enabled);
}

    /// A mob entered love mode after player interaction. `player` is the
    /// feeder when known. 216.
    // rust: pub(super) fn native_entity_enter_love_mode(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: player: Option<u128>,
    // rust: ) {
    // rust: mod_api::dispatch_entity_enter_love_mode(self, mod_api::mods(), entity, kind, player);
}

    /// A mob conversion completed; both ids and entity types are reported.
    /// 223.
    // rust: pub(super) fn native_entity_transform(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: transformed: u32,
    // rust: transformed_kind: &str,
    // rust: ) {
    // rust: mod_api::dispatch_entity_transform(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: transformed,
    // rust: transformed_kind,
    // rust: );
}

    /// A mob or server player is about to die (NeoForge's `LivingDeathEvent`,
    /// vanilla's `LivingEntity.die`): its health has run out, and the loot,
    /// experience and death message have not run. `entity` is its id and
    /// `kind` its type (`minecraft:zombie`, `minecraft:player`); `damage_type`
    /// names the last blow (`minecraft:player_attack`) and `attacker` is the
    /// mob that dealt it, 0 for none or a player. Set `cancel` to keep it alive:
    /// Horizon decides death by health, so it stays at 1 health. The hook
    /// fires once per death attempt. Armor stands, boats and other non-mob
    /// entities are not told. API 392.
    // rust: pub(super) fn native_living_death(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: damage_type: &str,
    // rust: attacker: u32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_death(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: damage_type,
    // rust: attacker,
    // rust: cancel,
    // rust: );
}

    /// A mob is about to convert into another type (NeoForge's
    /// `LivingConversionEvent.Pre`, vanilla's `Mob.convertTo`): a zombie
    /// drowning, a piglin or hoglin in the Overworld, a tadpole growing, a
    /// mooshroom sheared by a dispenser, a pig or villager struck by
    /// lightning. `outcome` is the new type. Set `cancel` to keep the mob as
    /// it is; a drowning zombie starts its timers again. Not told: a
    /// mooshroom a player shears, a zombie villager's cure, a villager turned
    /// by a zombie. API 391.
    // rust: pub(super) fn native_living_conversion_pre(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: outcome: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_conversion_pre(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: outcome,
    // rust: cancel,
    // rust: );
}

    /// A mob converted into another type (NeoForge's
    /// `LivingConversionEvent.Post`): `entity` is gone, `converted` took its
    /// place. Fires with `native_entity_transform`, after the new mob joined
    /// the level, for the conversions `native_living_conversion_pre` tells.
    /// API 390.
    // rust: pub(super) fn native_living_conversion_post(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: converted: u32,
    // rust: converted_kind: &str,
    // rust: ) {
    // rust: mod_api::dispatch_living_conversion_post(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: converted,
    // rust: converted_kind,
    // rust: );
}

    /// A thrown splash or lingering potion applied its hit effects.
    /// 287.
    // rust: pub(super) fn native_potion_splash(&mut self, item: &str, pos: [f64; 3]) {
    // rust: mod_api::dispatch_potion_splash(self, mod_api::mods(), item, pos);
}

    /// A firework rocket completed its explosion effects. 225.
    // rust: pub(super) fn native_firework_explode(&mut self, entity: u32, pos: [f64; 3], bursts: usize) {
    // rust: mod_api::dispatch_firework_explode(self, mod_api::mods(), entity, pos, bursts);
}

    /// An experience bottle broke and its experience was awarded.
    /// 224.
    // rust: pub(super) fn native_exp_bottle(&mut self, pos: [f64; 3], experience: u32) {
    // rust: mod_api::dispatch_exp_bottle(self, mod_api::mods(), pos, experience);
}

    /// A player ignited a creeper with an item. 206.
    // rust: pub(super) fn native_creeper_ignite(&mut self, entity: u32, player: u128, item: &str) {
    // rust: mod_api::dispatch_creeper_ignite(self, mod_api::mods(), entity, player, item);
}

    /// Lightning charged a creeper. 207.
    // rust: pub(super) fn native_creeper_power(&mut self, entity: u32, lightning: [f64; 3]) {
    // rust: mod_api::dispatch_creeper_power(self, mod_api::mods(), entity, lightning);
}

    /// A mob broke the door at `pos`. 212.
    // rust: pub(super) fn native_entity_break_door(&mut self, entity: u32, kind: &str, pos: [i32; 3]) {
    // rust: mod_api::dispatch_entity_break_door(self, mod_api::mods(), entity, kind, pos);
}

    /// A mob changed a block at `pos`, after the new state was applied.
    /// 214.
    // rust: pub(super) fn native_entity_change_block(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: pos: [i32; 3],
    // rust: from: &str,
    // rust: to: &str,
    // rust: ) {
    // rust: mod_api::dispatch_entity_change_block(self, mod_api::mods(), entity, kind, pos, from, to);
}

    /// A bee entered the hive at `pos` and was stored there.
    /// 215.
    // rust: pub(super) fn native_entity_enter_block(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: pos: [i32; 3],
    // rust: block: &str,
    // rust: ) {
    // rust: mod_api::dispatch_entity_enter_block(self, mod_api::mods(), entity, kind, pos, block);
}

    /// A server player finished loading the world around them after joining,
    /// respawning or changing dimension. The guest's state is not swapped in,
    /// so helpers that look them up through `self.lan` may find nothing while
    /// a guest packet is handled. Server-side. 342.
    // rust: pub(super) fn native_player_client_loaded_world(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_client_loaded_world(self, mod_api::mods(), player, name);
}
    /// A server player released the use-item key before the item finished
    /// being used. The guest's state is not swapped in, so helpers that look
    /// them up through `self.lan` may find nothing during packet handling.
    /// 350.
    // rust: pub(super) fn native_player_stop_using_item(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_stop_using_item(self, mod_api::mods(), player, name);
}
    /// A server player's recipe book open or filter setting changed. `book`
    /// is the book type's protocol id. The guest's state is not swapped in.
    /// 349.
    // rust: pub(super) fn native_player_recipe_book_settings_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: book: i32,
    // rust: open: bool,
    // rust: filtering: bool,
    // rust: ) {
    // rust: mod_api::dispatch_player_recipe_book_settings_change(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: book,
    // rust: open,
    // rust: filtering,
    // rust: );
}
    /// A server player earned one criterion of an advancement, after the
    /// progress was recorded. 339.
    // rust: pub(super) fn native_player_advancement_criterion_grant(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: advancement: &str,
    // rust: criterion: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_advancement_criterion_grant(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: advancement,
    // rust: criterion,
    // rust: );
}
    /// A server player released a drawn bow with `arrow` selected. The guest's
    /// state is not swapped in during packet handling. 348.
    // rust: pub(super) fn native_player_ready_arrow(&mut self, player: u128, name: &str, arrow: &str) {
    // rust: mod_api::dispatch_player_ready_arrow(self, mod_api::mods(), player, name, arrow);
}
    /// A server player selected a bundle item in `slot` at `index`. The guest's
    /// state is not swapped in during packet handling. 341.
    // rust: pub(super) fn native_player_bundle_item_select(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: slot: i32,
    // rust: index: i32,
    // rust: ) {
    // rust: mod_api::dispatch_player_bundle_item_select(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: slot,
    // rust: index,
    // rust: );
}
    /// A server player stopped digging `pos` before the block broke, after
    /// the server cleared the dig and sent the block back to the client.
    /// The player's state is not swapped in. 329.
    // rust: pub(super) fn native_block_damage_abort(&mut self, player: u128, name: &str, pos: [i32; 3]) {
    // rust: mod_api::dispatch_block_damage_abort(self, mod_api::mods(), player, name, pos);
}
    /// A hopper at `pos` began an item transfer attempt. This runs after its
    /// cooldown and enabled checks, before pushing or pulling any items.
    /// Server-side, including the single-player server. 352.
    // rust: pub(super) fn native_prepare_hopper_transfer(&self, pos: [i32; 3]) {
    // rust: mod_api::dispatch_prepare_hopper_transfer(self, mod_api::mods(), pos);
}
    /// A hopper is about to move one item between containers, a composter's
    /// bone meal included. Set `cancel` to leave it in its source slot. A chest
    /// boat or minecart is reported at the block it is in. 334.
    // rust: pub(super) fn native_inventory_move_item(
    // rust: &self,
    // rust: source: [i32; 3],
    // rust: destination: [i32; 3],
    // rust: item: &str,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_inventory_move_item(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: source,
    // rust: destination,
    // rust: item,
    // rust: cancel,
    // rust: );
}
    /// A hopper selected a container while searching for items to push or
    /// pull. Exactly one of `container` and `entity` identifies the target.
    /// 333.
    // rust: pub(super) fn native_hopper_inventory_search(
    // rust: &self,
    // rust: hopper: [i32; 3],
    // rust: container: Option<[i32; 3]>,
    // rust: entity: Option<u32>,
    // rust: ) {
    // rust: mod_api::dispatch_hopper_inventory_search(self, mod_api::mods(), hopper, container, entity);
}
    /// A vault at `pos` is about to eject a loot item. 353.
    // rust: pub(super) fn native_vault_loot(&self, pos: [i32; 3], item: &str) {
    // rust: mod_api::dispatch_vault_loot(self, mod_api::mods(), pos, item);
}
    /// A timed world-border size change finished on the server, after its
    /// final size was applied. Server-side, including the single-player
    /// server. 354.
    // rust: pub(super) fn native_world_border_bounds_change_finish(&mut self) {
    // rust: mod_api::dispatch_world_border_bounds_change_finish(self, mod_api::mods());
}

    /// A server player launched a projectile item, after it was created.
    /// `item` is the projectile's held item. 346.
    // rust: pub(super) fn native_player_launch_projectile(&mut self, player: u128, name: &str, item: &str) {
    // rust: mod_api::dispatch_player_launch_projectile(self, mod_api::mods(), player, name, item);
}
    /// A server explosion is about to begin at `center`, with `radius` (Bukkit's
    /// `ExplosionPrimeEvent`). This is listen-only: the explosion proceeds as
    /// usual. Server-side, including the single-player server. 332.
    // rust: pub(super) fn native_explosion_prime(&mut self, center: [f64; 3], radius: f32) {
    // rust: mod_api::dispatch_explosion_prime(self, mod_api::mods(), center, radius);
}
    /// A dropped item entity reached its 6000-tick lifetime and is about to be
    /// removed (Bukkit's `ItemDespawnEvent`). 335.
    // rust: pub(super) fn native_item_despawn(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: item: &str,
    // rust: count: i32,
    // rust: pos: [f64; 3],
    // rust: ) {
    // rust: mod_api::dispatch_item_despawn(self, mod_api::mods(), entity, item, count, pos);
}
    /// A mob is about to drop `count` of `item` at `pos` (Bukkit's
    /// `EntityDropItemEvent`). 330.
    // rust: pub(super) fn native_entity_drop_item(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: item: &str,
    // rust: count: i32,
    // rust: pos: [f64; 3],
    // rust: ) {
    // rust: mod_api::dispatch_entity_drop_item(self, mod_api::mods(), entity, item, count, pos);
}
    /// A leashed mob's leash was removed, before any lead drop is handled
    /// (Bukkit's `EntityUnleashEvent`). 331.
    // rust: pub(super) fn native_entity_unleash(&mut self, entity: u32, kind: &str) {
    // rust: mod_api::dispatch_entity_unleash(self, mod_api::mods(), entity, kind);
}
    /// A vehicle is about to take damage from a player's attack. `kind` is
    /// `boat` or the minecart type; mods may change `damage` or set `cancel`
    /// to leave its damage and wobble unchanged. The attack itself still
    /// completes. Server-side. 337.
    // rust: pub(super) fn native_vehicle_damage(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: damage: &mut f32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_vehicle_damage(self, mod_api::mods(), kind, damage, cancel);
}
    /// A boat or minecart was created at `pos`, after it joined the level.
    /// `kind` is the vehicle type. Server-side. 336.
    // rust: pub(super) fn native_vehicle_create(&mut self, kind: &str, pos: [f64; 3]) {
    // rust: mod_api::dispatch_vehicle_create(self, mod_api::mods(), kind, pos);
}
    /// A boat or minecart is about to be destroyed at `pos`. TNT minecarts
    /// that prime instead of breaking are not heard. Server-side.
    /// 338.
    // rust: pub(super) fn native_vehicle_destroy(&mut self, kind: &str, pos: [f64; 3]) {
    // rust: mod_api::dispatch_vehicle_destroy(self, mod_api::mods(), kind, pos);
}
    /// A guest sent the server's current `PlayerInput` flags, after they were applied to the hub. The guest's state is swapped in. Server-side. 343.
    // rust: pub(super) fn native_player_input(&mut self, player: u128, name: &str, flags: i32) {
    // rust: mod_api::dispatch_player_input(self, mod_api::mods(), player, name, flags);
}
    /// A guest's arm swing was handled by the server. `hand` is `mainhand`. Server-side. 340.
    // rust: pub(super) fn native_player_arm_swing(&mut self, player: u128, name: &str, hand: &str) {
    // rust: mod_api::dispatch_player_arm_swing(self, mod_api::mods(), player, name, hand);
}
    /// A guest's accepted movement made the server jump them from the ground. Server-side. 344.
    // rust: pub(super) fn native_player_jump(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_jump(self, mod_api::mods(), player, name);
}
    /// A guest was disconnected by a server kick, after the hub recorded the rendered `reason`. The guest's state is
    /// swapped in unless they were already removed in the same poll. 345.
    // rust: pub(super) fn native_player_kicked(&mut self, player: u128, name: &str, reason: &str) {
    // rust: mod_api::dispatch_player_kicked(self, mod_api::mods(), player, name, reason);
}
    /// A server player's experience level changed, after the new level was applied. 347.
    // rust: pub(super) fn native_player_level_change(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: i32,
    // rust: to: i32,
    // rust: ) {
    // rust: mod_api::dispatch_player_level_change(self, mod_api::mods(), player, name, from, to);
}
    /// A click in a menu a mod opened (`native_open_menu`), which moved
    /// nothing: the menu's `slot` (its own first, then the player's
    /// inventory, `native_menu_inventory_slot`; -999 outside), the `button`
    /// and the click's `mode` (`ClickType`'s id) of the player `uuid`.
    /// No player's state is swapped in: the menu helpers take the player's
    /// UUID. API 10.
    // rust: pub(super) fn native_menu_clicked(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: window: i32,
    // rust: slot: i32,
    // rust: button: i32,
    // rust: mode: i32,
    // rust: ) {
    // rust: mod_api::dispatch_menu_clicked(self, mod_api::mods(), uuid, window, slot, button, mode);
}
    /// A menu a mod opened closed: the player closed it, the server or a mod
    /// opened another, or the player left. API 10.
    // rust: pub(super) fn native_menu_closed(&mut self, uuid: u128, window: i32) {
    // rust: mod_api::dispatch_menu_closed(self, mod_api::mods(), uuid, window);
}
    /// An item's tooltip, wherever the game shows one (slots, the creative
    /// tabs, the recipe book, chat's hover): the stack, with its components
    /// (`stack.data()`: a shulker box's contents...), and its lines, the name
    /// first, each with a colour as `rgba` packs it (`u32::MAX` keeps the
    /// text's own). Add, change or take out lines; `Text::legacy` reads `§`
    /// codes. Asked each frame the tooltip shows, never for one the stack
    /// hides. API 12.
    // rust: pub(super) fn native_tooltip(&self, stack: &ItemStack, lines: &mut Vec<(Text, u32)>) {
    // rust: mod_api::dispatch_tooltip(self, mod_api::mods(), stack, lines);
}
    /// Change a tooltip box's background and border gradient colors, as ARGB.
    /// Stack is None for tooltips not associated with an item.
    // rust: pub(super) fn native_tooltip_color(
    // rust: &self,
    // rust: stack: Option<&ItemStack>,
    // rust: background: &mut u32,
    // rust: border_top: &mut u32,
    // rust: border_bottom: &mut u32,
    // rust: ) {
    // rust: mod_api::dispatch_tooltip_color(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: stack,
    // rust: background,
    // rust: border_top,
    // rust: border_bottom,
    // rust: );
}
    /// Client-side image component for this stack's tooltip. Answer its width/height
    /// in GUI pixels; finite positive dimensions reserve space after text and any
    /// vanilla bundle component. None keeps the vanilla tooltip unchanged.
    // rust: pub(super) fn native_tooltip_component(&self, stack: &ItemStack, size: &mut Option<[f32; 2]>) {
    // rust: mod_api::dispatch_tooltip_component(self, mod_api::mods(), stack, size);
}
    /// Render the measured component at origin, inside the tooltip background.
    /// Stack is the component's data. Use native_sprite/native_fill/native_text;
    /// size is the measurement returned by native_tooltip_component this frame.
    // rust: pub(super) fn native_tooltip_component_draw(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: batch: &mut HudBatch,
    // rust: origin: [f32; 2],
    // rust: size: [f32; 2],
    // rust: ) {
    // rust: mod_api::dispatch_tooltip_component_draw(self, mod_api::mods(), stack, batch, origin, size);
}

    /// The small bar `GuiGraphicsExtractor.itemDecorations` draws under an
    /// item, wherever the game shows one: `bar` arrives holding vanilla's value
    /// (the damage bar, or a bundle's fullness already applied) and may be
    /// replaced (width `0..=13`, colour `rgb`) or set to `None` to hide it.
    /// Asked each frame a stack is drawn. Client-side. 60.
    // rust: pub(super) fn native_item_bar(&self, stack: &ItemStack, bar: &mut Option<(i32, u32)>) {
    // rust: mod_api::dispatch_item_bar(self, mod_api::mods(), stack, bar);
}
    /// Append an item's custom decorations after its default bar, cooldown and count.
    /// Coordinates are the icon's top-left in GUI units, as the batch takes them;
    /// no item translation is active.
    /// Runs wherever the shared item-decoration path is used (hotbar, menus, tooltips,
    /// and the other screens that draw item icons: advancements, beacon, stats, trading).
    // rust: pub(super) fn native_item_decorations(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: x: f32,
    // rust: y: f32,
    // rust: batch: &mut HudBatch,
    // rust: ) {
    // rust: mod_api::dispatch_item_decorations(self, mod_api::mods(), stack, x, y, batch);
}
    /// A player uses `stack` (right click) with `self.hand` on the block at
    /// `pos`, `face` the face clicked (`[0, 1, 0]` is the top), once the
    /// block itself let the click through (a chest still opens): where
    /// `ItemStack.useOn` starts. Set `claimed` to take the use: the hand
    /// swings and neither the item's `useOn` nor its `use` runs.
    /// Server-side, for every player of the world (the helpers read the
    /// acting one); an item on cooldown is never used. API 13.
    // rust: pub(super) fn native_use_item_on(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: claimed: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_use_item_on(self, mod_api::mods(), stack, pos, face, claimed);
}
    /// `DispenserBlock.getDispenseMethod`: choose a behaviour for any item,
    /// including vanilla items, on the authoritative server (not droppers).
    /// Leave answer None for vanilla. Otherwise answer `(remainder, event)`:
    /// a remainder of None empties the slot, `Some(stack)` replaces it (the hook
    /// owns consumption: no extra item is removed afterwards). `event` is the
    /// level event the dispenser plays with its smoke: 1000 the click, 1001 the
    /// fail sound (`OptionalDispenseItemBehavior` without success), or 0 for
    /// nothing at all (`DispenseItemBehavior.NOOP`). To drop one normally,
    /// answer `(native_dispense_default(..), 1000)`. API 67.
    // rust: pub(super) fn native_dispense_item(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: facing: Direction,
    // rust: stack: &ItemStack,
    // rust: answer: &mut Option<NativeDispensed>,
    // rust: ) {
    // rust: mod_api::dispatch_dispense_item(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: facing,
    // rust: stack,
    // rust: answer,
    // rust: );
}
    /// A player uses `stack` (right click) with `self.hand`: in the air, or
    /// on a block once `native_use_item_on` let it through, where `Item.use`
    /// starts. Each click reaches it once. Set `claimed` to take the use: the
    /// hand swings and the item's own use doesn't run. Server-side, for every
    /// player of the world; an item on cooldown is never used. API 13.
    // rust: pub(super) fn native_use_item(&mut self, stack: &ItemStack, claimed: &mut bool) {
    // rust: mod_api::dispatch_use_item(self, mod_api::mods(), stack, claimed);
}
    /// `Item.getUseDuration` of `stack`, in ticks: `duration` arrives with
    /// vanilla's (a consumable's time, 72000 for a shield, a spear, a bow,
    /// 0 for an item with no use over time). A mod's own item (outside
    /// `minecraft:`) with no `consumable`, `blocks_attacks` or kinetic
    /// weapon that answers above 0 is used over time on a right click, as an
    /// `Item.use` that calls `startUsingItem`, until it is let go or the time
    /// runs out (`native_living_entity_use_item_finish`). A consumable's time
    /// changes too, potions and the other vanilla items keep their own.
    /// Asked when a use starts, each tick a mod's item is in use, and each
    /// frame the hand draws one in use, on both sides. It has no user, as
    /// it is asked so often: answer from the stack alone. API 90.
    // rust: pub(super) fn native_use_duration(&self, stack: &ItemStack, duration: &mut i32) {
    // rust: mod_api::dispatch_use_duration(self, mod_api::mods(), stack, duration);
}
    /// `Item.getUseAnimation` of `stack` in use, for the first person hand:
    /// `animation` arrives with its consumable's (`eat`, `drink`), else
    /// `None`. `Eat` and `Drink` bring the food to the mouth, `Bow` draws,
    /// `Trident` raises, `Brush` sweeps; the rest hold the item still.
    /// Asked each frame the hand draws an item in use, for an item with no
    /// pose of its own (bows, crossbows, tridents, brushes and spears keep
    /// theirs). Client-side. API 90.
    // rust: pub(super) fn native_use_animation(&self, stack: &ItemStack, animation: &mut UseAnimation) {
    // rust: mod_api::dispatch_use_animation(self, mod_api::mods(), stack, animation);
}
    /// `Player.canEat` for the food `stack`, from `Consumable.canConsume`
    /// when eating starts: `can_eat` arrives with vanilla's (creative,
    /// `can_always_eat`, or hungry). Clear it to refuse the food, set it to
    /// let a full player eat. Both sides (the client starts eating as the
    /// server does), so answer from the stack and the player alone. API 90.
    // rust: pub(super) fn native_can_eat(&self, stack: &ItemStack, can_eat: &mut bool) {
    // rust: mod_api::dispatch_can_eat(self, mod_api::mods(), stack, can_eat);
}
    /// NeoForge's `LivingEntityUseItemEvent.Start`: `entity` starts using
    /// `stack` in `hand` (`LivingEntity.startUsingItem`), for `duration`
    /// ticks (`native_use_duration`'s answer). `entity` is a mob's
    /// `Entity.getId`, None for a player (`native_acting_player` says who);
    /// only players fire it so far. Change `duration` (consumables, potions,
    /// spyglasses and mods' items count to it; below 0 refuses the use, and
    /// 0 runs it out on its first tick, as `native_living_entity_use_item_tick`
    /// running it out, unless the item's own is 0 already), or set
    /// `canceled` and the use doesn't start. Both sides, as
    /// vanilla's: on the server for every player of the world, and on a
    /// server's client for the uses it predicts. Answer the same on both,
    /// and change the world only on the server (`native_window` is false
    /// there), not on a server's client. API 90.
    // rust: pub(super) fn native_living_entity_use_item_start(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: entity: Option<i32>,
    // rust: hand: Hand,
    // rust: duration: &mut i32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_entity_use_item_start(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: stack,
    // rust: entity,
    // rust: hand,
    // rust: duration,
    // rust: canceled,
    // rust: );
}
    /// NeoForge's `LivingEntityUseItemEvent.Finish`: `entity`'s use of
    /// `stack` in `hand` ran its time (`LivingEntity.completeUsingItem`),
    /// `duration` the ticks left, always 0. `entity` is as in
    /// `native_living_entity_use_item_start`. `result` arrives with what
    /// `finishUsingItem` left in the hand (the bowl of a stew, none for the
    /// last apple; a mod's own item is kept) and may be replaced. Fired for
    /// consumables, potions, spyglasses and mods' items. Server-side, for every player
    /// of the world (the helpers read the acting one). API 90.
    // rust: pub(super) fn native_living_entity_use_item_finish(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: entity: Option<i32>,
    // rust: hand: Hand,
    // rust: duration: i32,
    // rust: result: &mut Option<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_living_entity_use_item_finish(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: stack,
    // rust: entity,
    // rust: hand,
    // rust: duration,
    // rust: result,
    // rust: );
}
    /// NeoForge's `LivingEntityUseItemEvent.Tick`: each tick `entity` uses
    /// `stack` in `hand`, where `LivingEntity.updatingUsingItem` starts,
    /// `duration` the ticks left. `entity` is as in
    /// `native_living_entity_use_item_start`. Change `duration` to move the
    /// end (consumables, potions, spyglasses and mods' items count to it,
    /// and so do a client's eating crumbs and first person pose, as the
    /// started duration of `native_living_entity_use_item_start` does). A
    /// cancel sets it to -1. Once a mod set it, the use goes on
    /// only while it is above 0: at 0 or less, by a cancel or set, the
    /// item's tick is skipped and the server finishes the use
    /// (`completeUsingItem`: `finishUsingItem`, the food eaten,
    /// `native_living_entity_use_item_finish`), while an item used on
    /// release (a crossbow) stays frozen until let go. NeoForge's javadoc
    /// says a cancel stops the use, but its code finishes it; this follows
    /// the code. On a server's client a run-out use stays in use, frozen,
    /// so letting go still tells the server. Both sides, as vanilla's
    /// `updatingUsingItem`: answer the same on both, and change the world
    /// only on the server (`native_window` is false there), not on a
    /// server's client. Runs every tick of every use:
    /// check the item first. API 131.
    // rust: pub(super) fn native_living_entity_use_item_tick(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: entity: Option<i32>,
    // rust: hand: Hand,
    // rust: duration: &mut i32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_entity_use_item_tick(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: stack,
    // rust: entity,
    // rust: hand,
    // rust: duration,
    // rust: canceled,
    // rust: );
}
    /// `Item.onUseTick` of `stack`, used by `entity` with `remaining` ticks
    /// left, always above 0: what a mod's own item does each tick it is used
    /// (cook, charge, drain). It comes where `ItemStack.onUseTick` calls the
    /// item, once `native_living_entity_use_item_tick` let the use go on:
    /// after a consumable's crumbs, for consumables, shields and mods' items
    /// (vanilla's other items do their own, and a kinetic weapon has none on
    /// the server). Both sides, as `native_living_entity_use_item_tick`:
    /// change the world only where this `Game` runs the world, not on a
    /// server's client. Runs every tick of every use: check the item first.
    /// API 131.
    // rust: pub(super) fn native_on_use_tick(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: entity: Option<i32>,
    // rust: remaining: i32,
    // rust: ) {
    // rust: mod_api::dispatch_on_use_tick(self, mod_api::mods(), stack, entity, remaining);
}
    /// NeoForge's `LivingEntityUseItemEvent.Stop`: `entity` lets go of
    /// `stack` in `hand` before its use ran its time
    /// (`LivingEntity.releaseUsingItem`: the use button let go, a screen
    /// opened), `duration` the ticks left. Set `canceled` to skip the item's
    /// release (a bow doesn't shoot, a spyglass makes no sound,
    /// `native_release_using` isn't called); the use stops anyway. Not when
    /// the hand changed item, which stops the use without a release. Both
    /// sides, as `native_living_entity_use_item_tick`. API 131.
    // rust: pub(super) fn native_living_entity_use_item_stop(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: entity: Option<i32>,
    // rust: hand: Hand,
    // rust: duration: i32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_entity_use_item_stop(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: stack,
    // rust: entity,
    // rust: hand,
    // rust: duration,
    // rust: canceled,
    // rust: );
}
    /// NeoForge's `ArrowLooseEvent`: the player releases a bow `stack` with
    /// `has_ammo` and `charge` ticks held. Change `charge` or set `canceled`
    /// to prevent the shot; negative charge also prevents it. Unlike
    /// `native_living_entity_use_item_stop`, this does not skip the whole item
    /// release; `native_entity_shoot_bow` reports a spawned arrow afterward
    /// with read-only force. Fires on the Game running the bow release, including
    /// LAN guests; a remote client's own release path is not covered. Crossbows
    /// are not covered; `native_arrow_nock` is the bow's start. 318.
    // rust: pub(super) fn native_arrow_loose(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: has_ammo: bool,
    // rust: charge: &mut i32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_arrow_loose(self, mod_api::mods(), stack, has_ammo, charge, canceled);
}
    /// NeoForge's `CriticalHitEvent`: a player's melee hit on a living
    /// `target_kind` (`minecraft:zombie`, `minecraft:armor_stand`) that deals
    /// damage, where `Player.attack` decides whether it is critical.
    /// `vanilla_critical` is vanilla's answer; `critical` starts as it and may
    /// be forced or denied (as in vanilla a critical hit prevents the sweep, so
    /// a forced crit loses it; a denied crit loses the crit sound and
    /// particles); `damage_multiplier` starts at 1.5 for vanilla's critical and
    /// 1.0 otherwise, and scales the damage only while `critical` ends true. Not fired for a
    /// target that is no living entity (a dragon part) or when the hit does
    /// no damage. Fires on the Game that runs the attack. 316.
    // rust: pub(super) fn native_critical_hit(
    // rust: &mut self,
    // rust: target_kind: &str,
    // rust: vanilla_critical: bool,
    // rust: critical: &mut bool,
    // rust: damage_multiplier: &mut f32,
    // rust: ) {
    // rust: mod_api::dispatch_critical_hit(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: target_kind,
    // rust: vanilla_critical,
    // rust: critical,
    // rust: damage_multiplier,
    // rust: );
}
    /// `Item.releaseUsing` of `stack`: `entity` let it go with `time_left`
    /// ticks of its `native_use_duration` left, so it was held for
    /// `duration - time_left` (a bow-like item shoots by that charge). Set
    /// `used` as vanilla's return, and the stack's use cooldown starts
    /// (`ItemStack.releaseUsing`). After the vanilla item's own release, once
    /// `native_living_entity_use_item_stop` let it through. Both sides, as
    /// vanilla's: change the world only where this `Game` runs the world,
    /// not on a server's client. API 131.
    // rust: pub(super) fn native_release_using(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: entity: Option<i32>,
    // rust: time_left: i32,
    // rust: used: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_release_using(self, mod_api::mods(), stack, entity, time_left, used);
}
    /// A player breaks the block `state` at `pos`, once the game allowed it
    /// (the held item can break blocks, the debug stick didn't take the
    /// click): where `ServerPlayerGameMode.destroyBlock` starts. Set
    /// `canceled` to keep the block: nothing is destroyed or dropped, and a
    /// guest sees it back. Server-side, for every player of the world (the
    /// helpers read the acting one). API 14.
    // rust: pub(super) fn native_destroy_block(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_destroy_block(self, mod_api::mods(), pos, state, canceled);
}
    /// A player placed `stack` as the block `state` at `pos`: where
    /// `BlockItem.place` set it, before the stack shrinks. It only hears; a
    /// mod stops a placement by claiming `native_use_item_on`, which runs
    /// before it. Server-side, for every player of the world. API 14.
    // rust: pub(super) fn native_place_block(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: mod_api::dispatch_place_block(self, mod_api::mods(), stack, pos, state);
}
    /// A player right clicks the block at `pos` with `self.hand`, `face` the
    /// face clicked: where `ServerPlayerGameMode.useItemOn` starts, before
    /// the block's own use (a chest, a door, a lever) and before
    /// `native_use_item_on`. Set `canceled` to stop the click: neither the
    /// block nor the item acts, the hand doesn't swing, and a guest sees the
    /// block as it is. Server-side, for every player of the world
    /// (`native_acting_player` says who), once per hand. API 21.
    // rust: pub(super) fn native_right_click_block(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_right_click_block(self, mod_api::mods(), pos, face, canceled);
}
    /// An explosion at `center` in `dimension` (`minecraft:overworld`) is
    /// about to break `blocks`: `ServerExplosion.explode` with its `toBlow`,
    /// before any block is hit. Take out the positions to spare; they keep
    /// their block and get no fire. Entities are hurt as before. Server-side.
    /// API 22.
    // rust: pub(super) fn native_explosion_detonate(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: center: [f64; 3],
    // rust: blocks: &mut Vec<[i32; 3]>,
    // rust: ) {
    // rust: mod_api::dispatch_explosion_detonate(self, mod_api::mods(), dimension, center, blocks);
}
    /// An explosion at `center` in `dimension`, about to break `blocks`, pushes
    /// `entity` (None for a player, whom `native_acting_player` names):
    /// `ServerExplosion.hurtEntities`, after the knockback is calculated. Change `knockback_velocity` to change
    /// what is added to the entity's velocity; a player's client is sent the
    /// same. Wind bursts too, except dragons and end crystals. End crystals
    /// are also omitted from ordinary blasts: Horizon removes them without a
    /// velocity to change. Server-side. 374.
    // rust: pub(super) fn native_explosion_knockback(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: center: [f64; 3],
    // rust: blocks: &[[i32; 3]],
    // rust: entity: Option<u32>,
    // rust: knockback_velocity: &mut [f64; 3],
    // rust: ) {
    // rust: mod_api::dispatch_explosion_knockback(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: center,
    // rust: blocks,
    // rust: entity,
    // rust: knockback_velocity,
    // rust: );
}
    /// A player fills (`stack` an empty bucket) or empties a bucket at `pos`:
    /// `BucketItem.use`, where it asks `Level.mayInteract`. Set `canceled`
    /// and the bucket does nothing. Server-side, for every player of the
    /// world (`native_acting_player` says who). API 22.
    // rust: pub(super) fn native_fill_bucket(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: pos: [i32; 3],
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_fill_bucket(self, mod_api::mods(), stack, pos, canceled);
}
    /// A player attacks the entity `entity` (`Entity.getId`) of type `kind`
    /// (`minecraft:item_frame`, `minecraft:cow`, `minecraft:player`) standing
    /// at `pos`: `ServerGamePacketListenerImpl.handleInteract`'s attack, once
    /// in reach, where `Player.attack` starts. Set `canceled` and the blow
    /// does nothing (no damage, no knockback, the frame keeps its item).
    /// Server-side, for every player of the world (`native_acting_player`
    /// says who). API 22.
    // rust: pub(super) fn native_attack_entity(
    // rust: &mut self,
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: pos: [f64; 3],
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_attack_entity(self, mod_api::mods(), entity, kind, pos, canceled);
}
    /// A message from `player`'s client on `channel` (`mod_id:name`), within
    /// the caps (`native_net.rs`): check `channel`, and treat `data` as the
    /// player's own bytes, checked by nothing. Runs in the tick after it
    /// arrives, with no player's state swapped in. Server-side. API 40.
    // rust: pub(super) fn native_net_from_client(&mut self, player: u128, channel: &str, data: &[u8]) {
    // rust: mod_api::dispatch_net_from_client(self, mod_api::mods(), player, channel, data);
}
    /// A message from the server on `channel` (`mod_id:name`), whose `data`
    /// is the sender's own bytes. The window's game only. API 40.
    // rust: pub(super) fn native_net_from_server(&mut self, channel: &str, data: &[u8]) {
    // rust: mod_api::dispatch_net_from_server(self, mod_api::mods(), channel, data);
}
    /// A play packet from the server reached the window's game, decoded,
    /// just before the game handles it (`Connection.genericsFtw` handing it
    /// to `ClientPacketListener`): every packet of the play phase, custom
    /// payloads included, in the order the server sent them. Packets the
    /// network thread handles itself are not heard: keep-alives, bundle
    /// delimiters, resource pack pushes and pops, cookies, server links,
    /// transfers, disconnects, the configuration switch, `minecraft:brand`
    /// and far terrain tiles; neither is the configuration phase.
    /// Read-only: the game handles the packet as it would without the mod.
    /// Client-side, on any server, single player's own included.
    /// API 408.
    // rust: pub(super) fn native_client_packet(&mut self, packet: &ClientboundPlayPacket) {
    // rust: mod_api::dispatch_client_packet(self, mod_api::mods(), packet);
}
    /// `dimension`'s level opened on the server (NeoForge's `LevelEvent.Load`,
    /// posted in `MinecraftServer.createLevels`): before any of its chunks
    /// (`native_chunk_load`), so a mod sets up what it keeps for the level
    /// here. The level the world opens in comes before `WorldOpenReady`; the
    /// others open when someone first goes there (a player, a portal, an
    /// `execute in` command), with the level in place. Once for each open:
    /// `native_level_unload` follows. Server-side. API 134.
    // rust: pub(super) fn native_level_load(&mut self, dimension: &str) {
    // rust: mod_api::dispatch_level_load(self, mod_api::mods(), dimension);
}
    /// `dimension`'s level closed (NeoForge's `LevelEvent.Unload`, posted after
    /// `level.close()` in `MinecraftServer.stopServer`), after its last save:
    /// drop what the mod kept for it. A level other than the Overworld closes
    /// once nobody has been in it for 300 ticks, after its chunks' unloads;
    /// every level still open closes when the server stops, before
    /// `WorldCloseFinal`, and when its open or its loop fails, before
    /// `WorldOpenFailed` or `WorldCloseFailed`. Once for each
    /// `native_level_load`. Don't read its blocks. Server-side. API
    /// 134.
    // rust: pub(super) fn native_level_unload(&mut self, dimension: &str) {
    // rust: mod_api::dispatch_level_unload(self, mod_api::mods(), dimension);
}
    /// The server's difficulty changed, from `from` to `to` (`peaceful`,
    /// `easy`, `normal`, `hard`; NeoForge's `DifficultyChangeEvent`). It is
    /// vanilla's `MinecraftServer.setDifficulty`, which `/difficulty`, a
    /// dedicated server's management and a test environment's difficulty all
    /// go through, and it is told only when the difficulty is another one. It
    /// only hears: the change has already happened. Server-side. API
    /// 159.
    // rust: pub(super) fn native_difficulty_changed(&mut self, from: &str, to: &str) {
    // rust: mod_api::dispatch_difficulty_changed(self, mod_api::mods(), from, to);
}
    /// Chunk `chunk` (`[x, z]`, in chunks) of `dimension` came into the world
    /// (NeoForge's `ChunkEvent.Load`): `new` when it was just generated, false
    /// when read from the save. A flat world's chunk that leaves before it's
    /// first lit isn't saved, so it's generated, and new, again; one generated
    /// as the players left is new when it next comes, unless the server
    /// restarts first, or the level closes for being empty, which drops its
    /// memory of what never saved. Its blocks and block entities are there,
    /// but its saved entities join afterwards and its light may not be ready:
    /// change the world from a later tick. The chunks around the spawn come
    /// before `WorldOpenReady`. Not told of a chunk a client receives.
    /// Server-side. API 57.
    // rust: pub(super) fn native_chunk_load(&mut self, dimension: &str, chunk: [i32; 2], new: bool) {
    // rust: mod_api::dispatch_chunk_load(self, mod_api::mods(), dimension, chunk, new);
}
    /// Chunk `chunk` of `dimension` left the world (NeoForge's
    /// `ChunkEvent.Unload`), with a level that closes for being empty too. Don't
    /// read its blocks. Its block entities are still there for this call, so
    /// `native_with_mod_block_entity` can change one and it's saved with the
    /// chunk. Not told when the world closes, which `native_world_lifecycle`
    /// tells. Server-side. API 57.
    // rust: pub(super) fn native_chunk_unload(&mut self, dimension: &str, chunk: [i32; 2]) {
    // rust: mod_api::dispatch_chunk_unload(self, mod_api::mods(), dimension, chunk);
}
    /// `player` (`name`) joined the game (NeoForge's
    /// `PlayerLoggedInEvent`): placed in the world and listed in
    /// `native_server_players`, so `native_net_send_to_player` reaches them.
    /// Once a join, with no player's state swapped in. Server-side. API 57.
    // rust: pub(super) fn native_player_logged_in(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_logged_in(self, mod_api::mods(), player, name);
}
    /// `player` (`name`) left the game (NeoForge's `PlayerLoggedOutEvent`), by
    /// any path: a lost connection, a kick, the server stopping or failing.
    /// Once for each player `native_player_logged_in` told of. They've already
    /// left `native_server_players`, except when the server stops, which tells
    /// before it saves, with them still listed and able to get a last message.
    /// Server-side. API 57.
    // rust: pub(super) fn native_player_logged_out(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_logged_out(self, mod_api::mods(), player, name);
}
    /// `player` (`name`) respawned (NeoForge's `PlayerRespawnEvent`): at the
    /// end of `PlayerList.respawn`, once they are placed and their health,
    /// food and experience reset, with their state swapped in. Once for each
    /// death that ends in a respawn, on a server; not for the End-exit one.
    /// 115.
    // rust: pub(super) fn native_player_respawned(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_respawned(self, mod_api::mods(), player, name);
}
    /// A player was saved to the world's store (NeoForge's
    /// `PlayerEvent.SaveToFile`, `PlayerList.save`): when they leave or the
    /// world closes, when a dedicated or integrated server saves its guests,
    /// and for an integrated server's owner when the world saves them.
    /// Once for each save. `directory`
    /// is the world's player directory (`players/data`): write your own file
    /// there, named `<uuid>.<suffix>`, never the player's `.dat`. The player
    /// may be leaving, so no player's state is swapped in. Not cancellable.
    /// Autosave snapshots are written asynchronously: this notification runs
    /// on a later server tick after a successful write, possibly after WorldSaved.
    /// Live state may have advanced beyond the saved snapshot; a process exit
    /// before completions are drained can prevent notification delivery.
    // rust: pub(super) fn native_player_save_to_file(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: directory: &std::path::Path,
    // rust: ) {
    // rust: mod_api::dispatch_player_save_to_file(self, mod_api::mods(), player, name, directory);
}
    /// A player was loaded from the world's save (NeoForge's
    /// `PlayerEvent.LoadFromFile`, `PlayerList.loadPlayerData`): their `.dat`
    /// has been read and applied, and they are not placed in a level yet.
    /// `directory` is the world's player directory (`players/data`): a mod
    /// reads its own file there, named `<uuid>.<suffix>` as
    /// `getPlayerFile(suffix)` names it. Heard once for each join, for the
    /// owner of an integrated server as for anyone else, on a server, with no
    /// player's state swapped in. Not cancellable.
    // rust: pub(super) fn native_player_load_from_file(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: directory: &std::path::Path,
    // rust: ) {
    // rust: mod_api::dispatch_player_load_from_file(self, mod_api::mods(), player, name, directory);
}
    /// A player's data was copied to their new player (NeoForge's
    /// `PlayerEvent.Clone`, from `ServerPlayer.restoreFrom`): `was_death` is
    /// true after a death, false when they left the End after the credits
    /// (`respawn` with `keepAllPlayerData`). The uuid stays the same, so the
    /// old and the new player share `player`. Heard before the new player is
    /// placed, on a server, with no player's state swapped in. Not
    /// cancellable.
    // rust: pub(super) fn native_player_clone(&mut self, player: u128, name: &str, was_death: bool) {
    // rust: mod_api::dispatch_player_clone(self, mod_api::mods(), player, name, was_death);
}
    /// The number of players with the mod container at `pos` of `dimension`
    /// open went from `previous` to `viewers` (vanilla's
    /// `ContainerOpenersCounter`, as a barrel keeps it): 0 to more than 0 is
    /// `onOpen`, back to 0 is `onClose`, any change `openerCountChanged`, so a
    /// block can show itself open while `viewers` is not 0. Counted every
    /// tick from the players' open menus, so a player who leaves without
    /// closing (a lost connection, death, another dimension, out of reach, the
    /// block gone) is heard too (`recheckOpeners`). Once for each change, with
    /// no player's state swapped in. Server-side.
    /// 124.
    // rust: pub(super) fn native_mod_container_viewers(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: viewers: u32,
    // rust: previous: u32,
    // rust: ) {
    // rust: mod_api::dispatch_mod_container_viewers(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: pos,
    // rust: viewers,
    // rust: previous,
    // rust: );
}
    /// `player` (`name`) pressed the swap-hands key: heard before the main and
    /// off hand items swap (the `SWAP_ITEM_WITH_OFFHAND` player action that
    /// `ServerGamePacketListenerImpl.handlePlayerAction` answers; Bukkit's
    /// `PlayerSwapHandItemsEvent`), not for a spectator. Set `cancel` to keep
    /// the items where they are: the player's client, which swapped them at
    /// once, gets its slots back. The player's state is swapped in, so
    /// `native_acting_player`, `native_tell` and the item helpers reach them.
    /// Once for each press, on a server. Not heard: the same swap made in an
    /// open inventory (hovering a slot and pressing the key, a menu click) and
    /// the host of a LAN world. 168.
    // rust: pub(super) fn native_player_swap_hands(&mut self, player: u128, name: &str, cancel: &mut bool) {
    // rust: mod_api::dispatch_player_swap_hands(self, mod_api::mods(), player, name, cancel);
}
    /// `player` (`name`) opened a menu (NeoForge's `PlayerContainerEvent.Open`,
    /// posted when `ServerPlayer.openMenu` sets the new `containerMenu`): any
    /// menu, vanilla or a mod's. `menu` is the menu type's name
    /// (`minecraft:generic_9x3`, `minecraft:furnace`, `minecraft:merchant`,
    /// `minecraft:crafting`, `minecraft:lectern`, a mod's own), `pos` the
    /// block it is of in `dimension` (none for a trade, a vehicle's, a mod's
    /// native menu or a mount's inventory, which has no menu type in vanilla
    /// and is told as `horizon:mount_inventory`). The player's own inventory
    /// is not one. Heard once a tick, so a menu opened and closed again
    /// inside one tick is not; one that replaces another comes after that
    /// one's close. The player's state is swapped in. `native_player_container_close`
    /// follows. Server-side. API 152.
    // rust: pub(super) fn native_player_container_open(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: dimension: &str,
    // rust: menu: &str,
    // rust: pos: Option<[i32; 3]>,
    // rust: ) {
    // rust: mod_api::dispatch_player_container_open(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: dimension,
    // rust: menu,
    // rust: pos,
    // rust: );
}
    /// `player` (`name`) closed the menu `native_player_container_open` told
    /// of (NeoForge's `PlayerContainerEvent.Close`, posted in
    /// `ServerPlayer.doCloseContainer` after the menu's `removed`): they
    /// closed it, walked out of reach, died, changed level, or another menu
    /// opened. A player who leaves closes it before `native_player_logged_out`
    /// (vanilla posts nothing for a disconnect; Horizon does, so each open has
    /// its close). Once for each open; not told when the server stops. The
    /// menu's items are where it left them: the block's, and the cursor stack
    /// back in the inventory. State swapped in, when the player has a body.
    /// Server-side. API 152.
    // rust: pub(super) fn native_player_container_close(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: dimension: &str,
    // rust: menu: &str,
    // rust: pos: Option<[i32; 3]>,
    // rust: ) {
    // rust: mod_api::dispatch_player_container_close(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: dimension,
    // rust: menu,
    // rust: pos,
    // rust: );
}
    /// A client started tracking an entity (NeoForge's
    /// `PlayerEvent.StartTracking`, posted at the end of
    /// `ServerEntity.addPairing`): `player` (`name`) is now sent `entity`
    /// (its ID, `uuid` its UUID, `kind` its type, `minecraft:zombie`) and its
    /// changes. It comes into range, its client's chunks reach it, or it is
    /// put in the level; another player is an entity too, and a player never
    /// tracks their own. A mod sends the player what they need to show it
    /// (`native_net_send_to_player`). The entity is as it was last tick: it
    /// may be gone by now. Heard after the tick's players and entities have
    /// moved, in order, with no player's state swapped in. Server-side.
    /// API 141.
    // rust: pub(super) fn native_player_start_tracking(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity: u32,
    // rust: uuid: u128,
    // rust: kind: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_start_tracking(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity,
    // rust: uuid,
    // rust: kind,
    // rust: );
}
    /// A client stopped tracking an entity (NeoForge's
    /// `PlayerEvent.StopTracking`, posted at the end of
    /// `ServerEntity.removePairing`): it went out of range, left the level or
    /// died, or `player` (`name`) left, changed level or respawned, which
    /// stops everything they tracked. `entity`, `uuid` and `kind` are as
    /// `native_player_start_tracking` told. Once for each start, a leaving
    /// player's after `native_player_logged_out`. The entity is not
    /// necessarily still there, and a player who left is gone: no player's
    /// state is swapped in. Server-side. API 141.
    // rust: pub(super) fn native_player_stop_tracking(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: entity: u32,
    // rust: uuid: u128,
    // rust: kind: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_stop_tracking(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: name,
    // rust: entity,
    // rust: uuid,
    // rust: kind,
    // rust: );
}
    /// Whether a mod listens to the mobs' `native_living_equipment_change`: a
    /// mod that hooks it hooks this one too and sets `listened` (HEAD,
    /// `*listened = true`). Without it the game does not read every mob's
    /// equipment each tick, and mobs are not told (armor stands still are). A
    /// mob that ticks once it is set counts from empty. Asked once a tick, after
    /// the mobs' tick. Server-side. API 148.
    // rust: pub(super) fn native_living_equipment_listened(&mut self, listened: &mut bool) {
    // rust: mod_api::dispatch_living_equipment_listened(self, mod_api::mods(), listened);
}
    /// A mob's or an armor stand's equipment slot took a different stack
    /// (NeoForge's `LivingEquipmentChangeEvent`, posted in
    /// `LivingEntity.collectEquipmentChanges`): `entity` is its ID and `kind`
    /// its type (`minecraft:zombie`), `slot` the `EquipmentSlot` (`mainhand`,
    /// `offhand`, `feet`, `legs`, `chest`, `head`, `body`, `saddle`), `from`
    /// what the slot held when this was last heard (none for empty) and `to`
    /// what it holds now. Once for each slot that changed, in that order,
    /// after the mobs' tick, so a mob that joins the level wearing something
    /// counts from empty on its first tick. It only hears: change the mob with
    /// its own helpers. Players are heard by `native_on_equip`. Server-side.
    /// API 148.
    // rust: pub(super) fn native_living_equipment_change(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: slot: &str,
    // rust: from: Option<&ItemStack>,
    // rust: to: Option<&ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_living_equipment_change(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: slot,
    // rust: from,
    // rust: to,
    // rust: );
}
    /// `player` died: where `ServerPlayer.die` starts, with the death
    /// message's key when the game knows it (`death.attack.lava`; none for a
    /// message it builds from the combat). It only hears. Server-side, for
    /// every player of the world, whether death messages are shown or not.
    /// API 40.
    // rust: pub(super) fn native_player_died(&mut self, player: u128, cause: Option<&str>) {
    // rust: mod_api::dispatch_player_died(self, mod_api::mods(), player, cause);
}
    /// A new mob of `kind` joined `dimension` at `pos`: `natural` when the
    /// world's spawning made it, false when something else did (a breed, a
    /// raid, a spawner, a conversion, `/summon`, and the second mob of a
    /// jockey the world spawned). One call a mob: a `/summon` with passengers
    /// tells each. Not told of a mob loaded with its chunk, leaving a hive or
    /// changing level. It only hears; the mob is already among the game's
    /// mobs. Server-side. API 40.
    // rust: pub(super) fn native_mob_spawned(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: kind: &str,
    // rust: pos: [f64; 3],
    // rust: natural: bool,
    // rust: ) {
    // rust: mod_api::dispatch_mob_spawned(self, mod_api::mods(), dimension, kind, pos, natural);
}
    /// An entity leaves the server level `dimension` (NeoForge's
    /// `EntityLeaveLevelEvent`): vanilla's `onTrackingEnd`, when it is removed
    /// for any reason (picked up, merged, despawned, burnt, blown up, killed,
    /// taken by a hopper or a mob, gone through a portal) or its chunk unloads,
    /// a level closing with nobody in it included. Not for the entities still
    /// loaded when the server stops, as in vanilla. `entity` is its ID and
    /// `kind` its type (`minecraft:item`); it is no longer in the level's lists.
    /// It only hears. 53 told item entities, experience orbs and mobs; it now
    /// tells every kind `native_entity_join_level` does (`kind` is the type), each
    /// once, when the game next notices it gone (the tick or action that removed
    /// it). Check `kind`. Server-side.
    // rust: pub(super) fn native_entity_leave_level(&mut self, dimension: &str, entity: u32, kind: &str) {
    // rust: mod_api::dispatch_entity_leave_level(self, mod_api::mods(), dimension, entity, kind);
}
    /// An entity joins the server level `dimension` (NeoForge's
    /// `EntityJoinLevelEvent`): vanilla's `PersistentEntitySectionManager.addEntity`.
    /// `loaded_from_disk` is true for an entity coming back with its chunk,
    /// false for one added fresh (`addFreshEntity`: a drop, an orb, `/summon`,
    /// an arrival through a portal). `entity` is its ID and `kind` its type
    /// (`minecraft:item`). It is already in the level's lists, so helpers that
    /// take an entity ID find it. Set `canceled` to keep it out: it is taken
    /// back out as if never added, and a `/summon` of it fails. Tells every
    /// kind in the game's entity lists (items, orbs, mobs, boats, minecarts,
    /// armor stands, primed TNT, falling blocks, projectiles, rockets,
    /// tridents, end crystals, the dragon, cushions, paintings, item frames),
    /// once each, in the order they were created; check `kind`. A drop, an
    /// orb, a mob, a `/summon` and a chunk's entities are told at once, any
    /// other spawn between the tick's phases (it is checked after the blocks,
    /// the vehicles, the projectiles, the items and the mobs, and at the
    /// tick's end). A mod that cancels one of the others sees it removed
    /// before it ticks again. Not told: the entities Horizon keeps without
    /// simulating (displays, markers, interactions). Server-side.
    // rust: pub(super) fn native_entity_join_level(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: pos: [f64; 3],
    // rust: loaded_from_disk: bool,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_entity_join_level(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: entity,
    // rust: kind,
    // rust: pos,
    // rust: loaded_from_disk,
    // rust: canceled,
    // rust: );
}
    /// An entity mounts or dismounts a vehicle (NeoForge's `EntityMountEvent`, posted from
    /// `Entity.startRiding` and `removeVehicle`): `entity` of type `kind` (`minecraft:player`,
    /// `minecraft:zombie`) in the server level `dimension`, getting on (`mounting`) or off the
    /// `vehicle` of type `vehicle_kind` (`minecraft:oak_boat`, `minecraft:minecart`,
    /// `minecraft:horse`, `minecraft:cushion`). Set `canceled` and it does not: a player stays
    /// where they were, a mob does not board, a `/ride` fails, and a rider whose dismount is
    /// canceled keeps riding. Told for a player boarding a boat, minecart, cushion or a mount (pig,
    /// strider, horse and its kin, llama, nautilus, happy ghast) and getting off one by their
    /// own input, `/ride`, a stab, a buck, a teleport or spectator mode; and for the mobs
    /// Horizon seats on a vehicle (jockeys, raiders on a ravager, `/ride`) and lets off one
    /// (`/ride`, a stab). It is not told for a rider whose vehicle was removed from the
    /// level (a boat or minecart destroyed, a broken cushion), nor for riders loaded with a
    /// save. The acting player is the one whose action runs, a guest on a server. Server-side.
    /// API 137.
    // rust: pub(super) fn native_entity_mount(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: vehicle: u32,
    // rust: vehicle_kind: &str,
    // rust: mounting: bool,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_entity_mount(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: entity,
    // rust: kind,
    // rust: vehicle,
    // rust: vehicle_kind,
    // rust: mounting,
    // rust: canceled,
    // rust: );
}
    /// Whether a mod listens to `native_entity_tick_pre` and `native_entity_tick_post`: a mod
    /// that hooks them hooks this one too and sets `listened` (HEAD, `*listened = true`).
    /// Without it the game tells no entity's tick, and keeps no list of them. Asked once for
    /// each family (mobs, items, minecarts, boats) each tick. Server-side. API 146.
    // rust: pub(super) fn native_entity_tick_listened(&mut self, listened: &mut bool) {
    // rust: mod_api::dispatch_entity_tick_listened(self, mod_api::mods(), listened);
}
    /// An entity of type `kind` (`minecraft:zombie`, `minecraft:item`) with ID `entity` is
    /// about to tick in the server level `dimension` (NeoForge's `EntityTickEvent.Pre`, posted
    /// around `Entity.commonTick` and `tick` in `ServerLevel.tickNonPassenger`). Set `canceled`
    /// and it does not tick this tick: a mob has no AI, physics or effects, an item no movement,
    /// ageing or merging, a minecart or boat no motion, and `native_entity_tick_post` is not told.
    /// Horizon ticks a family of entities together, so mobs and items hear every Pre before the
    /// first of them ticks; minecarts and boats hear theirs one by one. Told for the mobs, item
    /// entities, minecarts and boats that tick: those in an entity-ticking chunk, not a player's
    /// boat or cart (it ticks with the player). Later APIs add other kinds, so check `kind`. It
    /// runs for every ticking entity each tick, so keep it cheap. Server-side. API
    /// 146.
    // rust: pub(super) fn native_entity_tick_pre(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: entity: u32,
    // rust: kind: &str,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_entity_tick_pre(self, mod_api::mods(), dimension, entity, kind, canceled);
}
    /// The entity `entity` of type `kind` ticked in the server level `dimension` (NeoForge's
    /// `EntityTickEvent.Post`): for each entity `native_entity_tick_pre` let through, after it
    /// ticked, also one that died or was removed in its tick. Mobs and items hear their Posts
    /// once the whole family has ticked; minecarts and boats right after their own tick. Server-side.
    /// API 146.
    // rust: pub(super) fn native_entity_tick_post(&mut self, dimension: &str, entity: u32, kind: &str) {
    // rust: mod_api::dispatch_entity_tick_post(self, mod_api::mods(), dimension, entity, kind);
}
    /// Whether the experience orb `into` takes the orb `from` in (vanilla's
    /// `ExperienceOrb.canMerge`): the same value, and ids a multiple of 40 apart. Asked
    /// for each pair whose boxes meet, when an orb spawns (`tryMergeToExisting`: `from` is
    /// 0, the new orb isn't an entity yet, and only `from_value` is known) and every 20
    /// ticks as an orb scans for neighbours (`scanForMerges`). `can_merge` holds vanilla's
    /// answer; change it either way. A merged orb counts as `count` orbs of `into`'s
    /// value, so forcing orbs of different values together drops points unless the mod
    /// raises `into`'s value with `native_set_experience_orb` in `native_experience_orb_merge`.
    /// Server-side. API 128.
    // rust: pub(super) fn native_experience_orb_can_merge(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: into: u32,
    // rust: from: u32,
    // rust: into_value: u32,
    // rust: from_value: u32,
    // rust: can_merge: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_experience_orb_can_merge(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: into,
    // rust: from,
    // rust: into_value,
    // rust: from_value,
    // rust: can_merge,
    // rust: );
}
    /// The experience orb `into` is about to take `from` in, after
    /// `native_experience_orb_can_merge` said yes (`from` is 0 and `from_value` the
    /// points of a new orb that is spawning). Set `canceled` to stop it: both orbs stay, and
    /// a spawning orb tries the next orb in reach, then spawns on its own. Server-side.
    /// API 128.
    // rust: pub(super) fn native_experience_orb_merge(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: into: u32,
    // rust: from: u32,
    // rust: from_value: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_experience_orb_merge(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: into,
    // rust: from,
    // rust: from_value,
    // rust: canceled,
    // rust: );
}
    /// A totem of undying saved the server player `player` (`name`): their
    /// hurt would have killed them and the totem held in either hand fired
    /// (`LivingEntity.checkTotemDeathProtection`; Bukkit's
    /// `EntityResurrectEvent`), heard just before it is used up and its
    /// effects apply. Listen only: whether the totem saves is decided inside
    /// the health state machine, before a mod is asked, so a mod cannot veto
    /// it from here. The player's state is swapped in, so
    /// `native_acting_player`, `native_tell` and the item helpers reach them.
    /// Once for each totem, on a server; the host of a LAN world's totem is
    /// not heard. 182.
    // rust: pub(super) fn native_player_totem(&mut self, player: u128, name: &str) {
    // rust: mod_api::dispatch_player_totem(self, mod_api::mods(), player, name);
}
    /// The item `item` of the server player `player` (`name`) broke in `slot`
    /// (`mainhand`, `offhand`, `head`, `chest`, `legs`, `feet`, `body` or
    /// `saddle`): `LivingEntity.onEquippedItemBroken`, Bukkit's
    /// `PlayerItemBreakEvent`. Listen only; armour has a slot, not a hand.
    /// The player's state is swapped in. Once for each break, on a server; a
    /// creative player and the host of a LAN world are not heard.
    /// 315.
    // rust: pub(super) fn native_player_destroy_item(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: item: &str,
    // rust: slot: &str,
    // rust: ) {
    // rust: mod_api::dispatch_player_destroy_item(self, mod_api::mods(), player, name, item, slot);
}
    /// `player`'s melee blow killed the mob `entity` of `kind` (other deaths
    /// aren't told yet). It only hears, after the blow landed. Server-side.
    /// API 40.
    // rust: pub(super) fn native_mob_killed(&mut self, player: u128, entity: u32, kind: &str) {
    // rust: mod_api::dispatch_mob_killed(self, mod_api::mods(), player, entity, kind);
}
    /// A block broke or a mob died, and `drops` are the items about to drop, in
    /// the order they drop: what the loot tables rolled (after
    /// `native_loot_table_load`'s changes), and for a mob what it wore, held or
    /// carried (a fox's mouth item, an allay's, piglin's or horse's inventory),
    /// but not an enderman's carried block or a copper golem's preserved
    /// equipment, which drop after. A charged creeper's head and a fox's mouth
    /// item come before the mob's own table. A block's stacks get its block
    /// entity's data (a shulker box's items) after this. Add, change or take out
    /// stacks; empty ones don't drop (NeoForge's global loot modifiers, Fabric's
    /// `LootTableEvents.MODIFY_DROPS`); `context` says what dropped them and
    /// how, and it is called even when `drops` is empty. A player's use drops
    /// through it too (`NativeLootDrops::used`: shears, a brush, an item
    /// frame), with that player named. It hears blocks that a
    /// player, an explosion or a mob breaks, not other breaks (leaves decaying,
    /// a torch losing its wall, a piston, `/setblock ... destroy`), nor a
    /// creative break or a tool that can't harvest the block, nor experience.
    /// Server-side, for every player. API
    /// 75.
    // rust: pub(super) fn native_loot_drops(
    // rust: &mut self,
    // rust: context: &NativeLootDrops<'_>,
    // rust: drops: &mut Vec<ItemStack>,
    // rust: ) {
    // rust: mod_api::dispatch_loot_drops(self, mod_api::mods(), context, drops);
}
    /// The item `item` of a server player is about to lose `amount` points of
    /// durability (`ItemStack.hurtAndBreak`; Bukkit's `PlayerItemDamageEvent`):
    /// the tool that mines or hits, the armour that takes a hit, a shield, a
    /// rod, an elytra. `amount` is what is left after Unbreaking; change it
    /// (0 or less leaves the item whole) or set `cancel` for no wear at all. It
    /// is not heard for a creative player's tools (they take no wear) nor when
    /// Unbreaking already saved the item, nor for the wear of a mob's armour or
    /// of a tool a dispenser uses, nor the host of a LAN world. The player's
    /// state is swapped in, so `native_acting_player`, `native_tell` and the
    /// item helpers reach them. Once for each wear, on a server.
    /// 162.
    // rust: pub(super) fn native_item_damaged(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: item: &str,
    // rust: amount: &mut i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_item_damaged(self, mod_api::mods(), player, name, item, amount, cancel);
}
    /// `player` threw `count` of `item` (`Player.drop`: the drop key, a
    /// menu's throw...), not what scatters when they die. It only hears.
    /// Server-side. API 40.
    // rust: pub(super) fn native_item_dropped(&mut self, player: u128, item: &str, count: u32) {
    // rust: mod_api::dispatch_item_dropped(self, mod_api::mods(), player, item, count);
}
    /// `player` is about to take `count` of `item` from the ground
    /// (`ItemEntity.playerTouch`). Set `canceled` to leave it there: the
    /// stack isn't offered again for 10 ticks. Server-side. API 40.
    // rust: pub(super) fn native_item_picked_up(
    // rust: &mut self,
    // rust: player: u128,
    // rust: item: &str,
    // rust: count: u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_item_picked_up(self, mod_api::mods(), player, item, count, canceled);
}
    /// A dropped item reaches its lifetime on the server (`ItemEntity.tick`,
    /// NeoForge's `ItemExpireEvent`). Every mod may set or add to `extra_life`,
    /// in ticks, which starts at zero; a positive total keeps the item that much
    /// longer, zero or less lets it expire. Extensions are capped at 32766
    /// ticks. 325.
    // rust: pub(super) fn native_item_expire(
    // rust: &mut self,
    // rust: entity: u32,
    // rust: stack: &ItemStack,
    // rust: extra_life: &mut i32,
    // rust: ) {
    // rust: mod_api::dispatch_item_expire(self, mod_api::mods(), entity, stack, extra_life);
}
    /// A player took a crafting grid's result (`ResultSlot.onTake`, NeoForge's
    /// `PlayerEvent.ItemCraftedEvent`): `player` is the player's uuid, `recipe`
    /// the recipe the grid matched (`minecraft:oak_planks`) and `stack` the
    /// result it took, with its components. It only hears: the take has
    /// already happened. It fires for the crafting grid of an inventory or a
    /// crafting table, on the integrated server and a dedicated server, guests
    /// included, and not for a stonecutter's, a smithing table's or a
    /// furnace's result. Server-side. API 161.
    // rust: pub(super) fn native_item_crafted(&mut self, player: u128, recipe: &str, stack: &ItemStack) {
    // rust: mod_api::dispatch_item_crafted(self, mod_api::mods(), player, recipe, stack);
}
    /// The food level of the server player `player` (`name`) is about to change
    /// from `from` to `to` (Bukkit's `FoodLevelChangeEvent`):
    /// eating, hunger and saturation effects, the exhaustion that costs a
    /// point, starving. Change `to` (kept between 0 and 20; saturation never
    /// exceeds it) or set `cancel` to leave the level at `from`, saturation
    /// included. Heard once for the change a player's turn made as a whole, so
    /// two changes in one tick arrive as one. Not heard: the full food bar a
    /// respawn gives, the food a player joins with and the host of a LAN
    /// world. The player's state is swapped in, so `native_acting_player`,
    /// `native_tell` and the item helpers reach them. On a server.
    /// 169.
    // rust: pub(super) fn native_food_level_changed(
    // rust: &mut self,
    // rust: player: u128,
    // rust: name: &str,
    // rust: from: i32,
    // rust: to: &mut i32,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_food_level_changed(self, mod_api::mods(), player, name, from, to, cancel);
}
    /// Whether a mod hears `native_experience_orb_pickup`: set `listened`
    /// (a HEAD injection), or the server skips swapping the player in for it,
    /// and with this empty the pickup costs nothing more without mods.
    /// Server-side. 155.
    // rust: pub(super) fn native_experience_orb_pickup_listened(&self, listened: &mut bool) {
    // rust: mod_api::dispatch_experience_orb_pickup_listened(self, mod_api::mods(), listened);
}
    /// Before `player` picks up orb `orb` in `dimension`. Mutations to `value`
    /// and `count` take effect only when not canceled; value is clamped to
    /// 1..=i32::MAX and count to at least one.
    /// Canceling leaves the orb and pickup delay unchanged. Server-side.
    /// 155.
    // rust: pub(super) fn native_experience_orb_pickup(
    // rust: &mut self,
    // rust: player: u128,
    // rust: dimension: &str,
    // rust: orb: u32,
    // rust: value: &mut u32,
    // rust: count: &mut u32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_experience_orb_pickup(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: player,
    // rust: dimension,
    // rust: orb,
    // rust: value,
    // rust: count,
    // rust: canceled,
    // rust: );
}
    /// The selected damaged Mending `stack` and the proposed durability repair
    /// for `experience` points. The amount is clamped to the stack's current damage. Zero leaves the
    /// experience unspent when it overrides a positive proposal. If the selected
    /// stack changes, the repair is skipped.
    /// Server-side, including `native_give_experience`.
    /// 155.
    // rust: pub(super) fn native_mending_repair(
    // rust: &mut self,
    // rust: player: u128,
    // rust: stack: &ItemStack,
    // rust: experience: u32,
    // rust: repair: &mut u32,
    // rust: ) {
    // rust: mod_api::dispatch_mending_repair(self, mod_api::mods(), player, stack, experience, repair);
}
    /// A player's hit landed on the mob `entity` of type `kind`
    /// (`minecraft:zombie`), holding `stack`: where `Item.hurtEnemy` is called,
    /// before the post-attack enchantments and the weapon's wear. It only
    /// hears. Another player as the target isn't told yet. Server-side, for
    /// every player of the world (the helpers read the acting one). API 39.
    // rust: pub(super) fn native_hurt_enemy(&mut self, stack: &ItemStack, entity: u32, kind: &str) {
    // rust: mod_api::dispatch_hurt_enemy(self, mod_api::mods(), stack, entity, kind);
}
    /// A server tick of the stack a player carries in `slot`: where
    /// `Inventory.tick` calls `Item.inventoryTick`, for every stack, each tick,
    /// `/tick freeze` included (it stops the world, not the player). `slot` is
    /// as `Inventory` saves it (0 to 35; the armour 100 feet to 103 head; -106
    /// the off hand), and `selected` says it is the held slot.
    /// `native_carried_stack` reads and changes the stack, which stays in its
    /// slot, so the item helpers see it: a count of 0 empties the slot, and the
    /// player's client gets the change. This runs often, so check the item
    /// first. Server-side, for every living player of the world (the helpers
    /// read the acting one). API 39.
    // rust: pub(super) fn native_inventory_tick(&mut self, slot: i32, selected: bool) {
    // rust: mod_api::dispatch_inventory_tick(self, mod_api::mods(), slot, selected);
}
    /// A player's equipment slot `slot` (`head`, `chest`, `legs`, `feet`,
    /// `offhand`, and `mainhand` on a swap of the hands or `/item`) took a different
    /// item, `new` (none when it was emptied): `LivingEntity.onEquipItem`,
    /// before the equip sound. It only hears. Never for a spectator.
    /// Server-side, for every player of the world (the helpers read the
    /// acting one). API 39.
    // rust: pub(super) fn native_on_equip(&mut self, slot: &str, new: Option<&ItemStack>) {
    // rust: mod_api::dispatch_on_equip(self, mod_api::mods(), slot, new);
}
    /// `MobEffect.shouldApplyEffectTickThisTick` for a content mod's effect
    /// `effect` (`ruby:bleeding`), each tick a player or a mob has it, in
    /// `MobEffectInstance.tickServer` before it counts down: `tick_count` is
    /// the ticks left (the entity's tick count when infinite). Set `apply`
    /// and `native_apply_effect_tick` follows. Server-side. API 56.
    // rust: pub(super) fn native_should_apply_effect_tick_this_tick(
    // rust: &self,
    // rust: effect: &str,
    // rust: tick_count: i32,
    // rust: amplifier: i32,
    // rust: apply: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_should_apply_effect_tick_this_tick(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: effect,
    // rust: tick_count,
    // rust: amplifier,
    // rust: apply,
    // rust: );
}
    /// `MobEffect.applyEffectTick`: the content mod's effect `effect` acts on
    /// `entity` in `dimension` (`minecraft:overworld`). Clear `keep` and the
    /// effect ends now, before it counts down. `entity` is a mob's
    /// `Entity.getId`, None for a player (`native_acting_player` says who).
    /// It runs inside the entity's tick: a mob's world borrows the game
    /// there, so the game is read-only, and it does not hold the ticking
    /// mobs, nor the player's effects. Server-side. API 56.
    // rust: pub(super) fn native_apply_effect_tick(
    // rust: &self,
    // rust: effect: &str,
    // rust: dimension: &str,
    // rust: entity: Option<i32>,
    // rust: amplifier: i32,
    // rust: keep: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_apply_effect_tick(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: effect,
    // rust: dimension,
    // rust: entity,
    // rust: amplifier,
    // rust: keep,
    // rust: );
}
    /// `MobEffect.onEffectAdded`: `LivingEntity.addEffect` gave `entity`
    /// (as in `native_apply_effect_tick`) the content mod's effect `effect`,
    /// which it didn't have. Server-side. API 56.
    // rust: pub(super) fn native_on_effect_added(
    // rust: &mut self,
    // rust: effect: &str,
    // rust: entity: Option<i32>,
    // rust: amplifier: i32,
    // rust: ) {
    // rust: mod_api::dispatch_on_effect_added(self, mod_api::mods(), effect, entity, amplifier);
}
    /// NeoForge's `MobEffectEvent.Added`, vanilla's `MobEffect.onEffectStarted`:
    /// every `LivingEntity.addEffect` of the content mod's effect `effect`,
    /// new or not, changed or not, after `native_on_effect_added`.
    /// Server-side. API 56.
    // rust: pub(super) fn native_mob_effect_added(
    // rust: &mut self,
    // rust: effect: &str,
    // rust: entity: Option<i32>,
    // rust: amplifier: i32,
    // rust: ) {
    // rust: mod_api::dispatch_mob_effect_added(self, mod_api::mods(), effect, entity, amplifier);
}
    /// `LivingEntity.hurtServer`, past its guards (invulnerable, dead, fire
    /// with fire resistance), is about to hurt entity `entity` of type `kind`
    /// (`minecraft:zombie`, `minecraft:player`) by `amount` of `damage_type`
    /// (`minecraft:fall`), from the source's `causing` entity
    /// (`DamageSource.getEntity`: the shooter of an arrow) and `direct` one
    /// (`getDirectEntity`: the arrow), 0 for none or not known yet
    /// (docs/native-mods.md, API 50). Change `amount`, or set `canceled`,
    /// and nothing of `hurtServer` itself happens (no damage, hurt sound,
    /// knockback, invulnerable time, statistics or criteria); the caller acts
    /// as on a refused hit, except that a canceled hit on the ender dragon
    /// still counts as landed (`EnderDragon.hurt` returns true whatever
    /// `reallyHurt` did: the arrow is spent, the melee effects run). It runs
    /// on the thread that ticks the world (the server thread): state shared with render thread hooks needs synchronising.
    /// No `self`: the game is in the middle of the hit. API 50.
    // rust: pub(super) fn native_living_incoming_damage(
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: damage_type: &str,
    // rust: causing: i32,
    // rust: direct: i32,
    // rust: amount: &mut f32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_incoming_damage(
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: damage_type,
    // rust: causing,
    // rust: direct,
    // rust: amount,
    // rust: canceled,
    // rust: );
}
    /// A player's weapon hit on a mob, before `Mob::damage_with` borrows the
    /// victim: melee, sweep and spear hits, including LAN guests. Unlike v1,
    /// this has a host and snapshots of the weapon, victim position/view and
    /// DamageSource position. The acting player's network id is `causing`
    /// (also the direct entity). Weapon enchantments include their levels.
    /// Runs after the victim's invulnerability check (an invulnerable or dead victim fires nothing) and before v1; cancellation refuses
    /// delivery. Other damage routes still only fire v1. API 384.
    // rust: pub(super) fn native_living_incoming_damage_v2(
    // rust: &mut self,
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: damage_type: &str,
    // rust: causing: i32,
    // rust: source_position: Option<[f64; 3]>,
    // rust: victim_position: [f64; 3],
    // rust: victim_view: [f64; 3],
    // rust: weapon: Option<&ItemStack>,
    // rust: amount: &mut f32,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_incoming_damage_v2(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: damage_type,
    // rust: causing,
    // rust: source_position,
    // rust: victim_position,
    // rust: victim_view,
    // rust: weapon,
    // rust: amount,
    // rust: canceled,
    // rust: );
}
    /// `LivingEntity.knockback` is about to push entity `entity` of type `kind`
    /// (`minecraft:zombie`, `minecraft:player`) `strength` away from the direction (`x`, `z`),
    /// on the raw strength, before the entity's knockback resistance takes its share and its motion
    /// changes
    /// (docs/native-mods.md, API 125). Vanilla's direction points at the
    /// source of a hit (the attacker's side), and the entity is pushed the other way. Change
    /// `strength`, `x` or `z`, or set `canceled`, and the push follows them: canceled, the
    /// entity's motion is left alone. A `strength` of 0 or less after the hook is no push, and a
    /// direction too short to tell draws a random one after it, as in vanilla. A value a mod
    /// leaves that is not a finite number is put back as it was. `damage_type`
    /// (`minecraft:player_attack`), `causing` (`DamageSource.getEntity`) and `direct`
    /// (`getDirectEntity`) are the push's `DamageSource`, named as `native_living_incoming_damage`
    /// names a hit's, with the same entity ids left at 0. It fires for the players and mobs the
    /// game knocks back: a hit's own push, a sprinting or Knockback hit, a sweep, a spear, a
    /// shield's push on its holder and a goat's ram. It does not fire for a sulfur cube with a
    /// block that a hit with a causing entity knocks back (`SulfurCube.knockback` does not call
    /// `super` there), for the pushes vanilla doesn't make with `LivingEntity.knockback` (the
    /// ender dragon's wings, Punch arrows, explosions, wind charges, a mace smash's area, a
    /// hoglin's throw), nor yet for the ones Horizon makes another way: a mob's melee push from
    /// its attack knockback or a Knockback weapon, an armor stand's, the ender dragon's. It runs
    /// on the thread that ticks the world (the server thread): state
    /// shared with render thread hooks needs synchronising. No `self`: the game is in the middle
    /// of the hit. API 125.
    // rust: pub(super) fn native_living_knockback(
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: damage_type: &str,
    // rust: causing: i32,
    // rust: direct: i32,
    // rust: strength: &mut f64,
    // rust: x: &mut f64,
    // rust: z: &mut f64,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_knockback(
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: damage_type,
    // rust: causing,
    // rust: direct,
    // rust: strength,
    // rust: x,
    // rust: z,
    // rust: canceled,
    // rust: );
}
    /// LivingEntity.knockback before resistance and motion, after the unchanged v1 hook.
    /// Cancellation from either hook wins. Attacker is the attacking entity's network id,
    /// falling back to the victim's last hurt-by mob, or 0 when unknown; `attacker_main` and
    /// `attacker_off` are what it holds (a player's selected and off-hand stacks, a mob's main hand), none when unknown. Player attackers
    /// include the guest whose action runs. Includes mob melee and armor-stand sweeps, not
    /// direct velocity pushes (explosions, Punch arrows, hoglin throws). Non-finite changes
    /// are restored before resistance. Server-side, without self: damage borrows the victim.
    /// API 383.
    // rust: pub(super) fn native_living_knockback_v2(
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: attacker: i32,
    // rust: attacker_main: Option<&ItemStack>,
    // rust: attacker_off: Option<&ItemStack>,
    // rust: strength: &mut f64,
    // rust: x: &mut f64,
    // rust: z: &mut f64,
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_living_knockback_v2(
    // rust: mod_api::mods(),
    // rust: entity,
    // rust: kind,
    // rust: attacker,
    // rust: attacker_main,
    // rust: attacker_off,
    // rust: strength,
    // rust: x,
    // rust: z,
    // rust: canceled,
    // rust: );
}
    /// Whether a mod hears projectiles' impacts (`native_projectile_impact`):
    /// set `hears`. Asked once a server tick before the projectiles fly; only
    /// then does the tick keep the copy of each flying projectile that a
    /// canceled impact flies on from, so a game without such a mod pays
    /// nothing. Server-side. API 136.
    // rust: pub(super) fn native_hears_projectile_impacts(&self, hears: &mut bool) {
    // rust: mod_api::dispatch_hears_projectile_impacts(self, mod_api::mods(), hears);
}
    /// A projectile hit something (NeoForge's `ProjectileImpactEvent`, posted
    /// where vanilla's projectile has found what it meets, before the hit
    /// acts): `projectile` (its entity id) of type `kind` (`minecraft:arrow`),
    /// shot by `owner` (a mob's or a player's entity id, 0 for none) in the level
    /// `dimension`. It hit the entity `entity` of type `entity_kind` (a player is
    /// `minecraft:player`; a dragon's part is `minecraft:ender_dragon`), or, with
    /// `entity` None, the block at `block` on its `face` (the face's normal,
    /// `[0, 1, 0]` for the top), at the point `at`. Set `canceled` and the impact
    /// does not happen: no damage, no knockback, no sound, no block reaction, the
    /// arrow does not stick, a pearl does not teleport, a potion or a fireball
    /// does not burst. The projectile flies on and is not discarded, so a mod
    /// that cancels also decides what becomes of it. It continues through its
    /// whole motion and may hit something on a later tick. Covers what
    /// `tick_projectiles` flies: arrows, tridents, snowballs,
    /// eggs, pearls, potions, fireballs, wither skulls, wind charges, llama spit and
    /// shulker bullets, from players, mobs and dispensers. It does not fire for
    /// a breeze's deflection, for a hit on a wind charge, for fireworks or for
    /// fishing bobbers. A dragon part or End crystal is told by the id of the
    /// dragon or crystal. Heard only when a mod also sets
    /// `native_hears_projectile_impacts`. Server-side. API 136.
    // rust: pub(super) fn native_projectile_impact(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: projectile: u32,
    // rust: kind: &str,
    // rust: owner: u32,
    // rust: entity: Option<u32>,
    // rust: entity_kind: &str,
    // rust: block: [i32; 3],
    // rust: face: [i32; 3],
    // rust: at: [f64; 3],
    // rust: canceled: &mut bool,
    // rust: ) {
    // rust: mod_api::dispatch_projectile_impact(
    // rust: self,
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: projectile,
    // rust: kind,
    // rust: owner,
    // rust: entity,
    // rust: entity_kind,
    // rust: block,
    // rust: face,
    // rust: at,
    // rust: canceled,
    // rust: );
}

    /// `Block.stepOn` for a mod block, on its authoritative server level.
    /// No self: the simulation owns the entity during this callback.
    // rust: pub(super) fn native_block_step_on(
    // rust: dimension: &str,
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) {
    // rust: mod_api::dispatch_block_step_on(mod_api::mods(), dimension, entity, kind, state, position);
}
    /// `Block.entityInside` for each mod block touched along the entity's movement.
    /// Repeated sweep hits in one contact pass are suppressed; idle overlap still fires.
    // rust: pub(super) fn native_block_entity_inside(
    // rust: dimension: &str,
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) {
    // rust: mod_api::dispatch_block_entity_inside(
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: entity,
    // rust: kind,
    // rust: state,
    // rust: position,
    // rust: );
}
    /// `Block.fallOn` for a mod block. Change calculated damage before generic fall sounds
    /// and hurt handling; zero prevents both. Creative and fall-immune entities
    /// notify with zero damage and retain their immunity. Server-side only.
    // rust: pub(super) fn native_block_fall_on(
    // rust: dimension: &str,
    // rust: entity: i32,
    // rust: kind: &str,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: distance: f64,
    // rust: damage: &mut f32,
    // rust: ) {
    // rust: mod_api::dispatch_block_fall_on(
    // rust: mod_api::mods(),
    // rust: dimension,
    // rust: entity,
    // rust: kind,
    // rust: state,
    // rust: position,
    // rust: distance,
    // rust: damage,
    // rust: );
}
}

    // rust: impl Game<'_> {
    /// `health::knockback_from` that, while a native mod listens, also records what the attacker
    /// holds (the player's selected and off-hand stacks, a mob's main hand) for
    /// `living_knockback_v2`. A nested scope for the same attacker keeps what the outer recorded.
    // rust: pub(super) fn knockback_scope(&self, attacker: i32) -> impl Drop + use<> {
//         use horizon_client::health::{knockback_attacker, knockback_from_holding, knockback_held};
    // rust: if mod_api::mods().is_empty() {
    // rust: return knockback_from_holding(attacker, [None, None]);
}
    // rust: let held = if attacker != 0 && attacker == knockback_attacker() {
    // rust: knockback_held()
    // rust: } else if self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.entity_id == attacker)
    // rust: {
    // rust: [self.stack_in(self.selected).cloned(), self.offhand.clone()]
    // rust: } else if let Some(mob) = self.mobs.iter().find(|m| m.id as i32 == attacker) {
    // rust: [mob.extra.main_hand_stack().cloned(), None]
    // rust: } else {
    // rust: [None, None]
}
    // rust: knockback_from_holding(attacker, held)
}
    /// [`Self::knockback_scope`] for the attacker a damage source names: the player, a mob, or
    /// (none) whoever the enclosing scope already names.
    // rust: pub(super) fn knockback_scope_for(&self, attacker: Option<Who>) -> impl Drop + use<> {
    // rust: self.knockback_scope(match attacker {
    // rust: Some(Who::Player) => self.player.as_ref().map_or(0, |p| p.entity_id),
    // rust: Some(Who::Mob(id)) => id as i32,
    // rust: None => horizon_client::health::knockback_attacker(),
    // rust: })
}
}

/// `native_living_knockback` for the knockback code (`health::KNOCKBACK`): whether it
/// canceled the push. Its one caller. The pushed entity and the source are named as the
/// damage hook names them.
    // rust: pub(super) fn knockback(pushed: Hurting<'_>, knock: &mut Knock) -> bool {
    // rust: if mod_api::mods().is_empty() {
    // rust: return false;
}
    // rust: let attacker = match &pushed {
    // rust: Hurting::Mob(mob, damage) => match damage.attacker.or(mob.ai.last_hurt_by) {
    // rust: Some(Who::Mob(id)) => id as i32,
    // rust: _ => horizon_client::health::knockback_attacker(),
    // rust: },
    // rust: Hurting::Player(_, source)
    // rust: | Hurting::Dragon(_, source)
    // rust: | Hurting::ArmorStand(_, source) => {
    // rust: if source.causing != 0 {
    // rust: source.causing
    // rust: } else {
    // rust: horizon_client::health::knockback_attacker()
}
}
}
    // No `matches!`: horizon-mixins refuses macros in a hook point's body.
    // rust: let stand = if let Hurting::ArmorStand(..) = &pushed {
    // rust: true
    // rust: } else {
    // rust: false
}
    // rust: let (entity, kind, source) = hurt_server_args(pushed);
    // rust: let HurtSource {
    // rust: damage_type,
    // rust: causing,
    // rust: direct,
    // rust: } = source;
    // rust: let mut canceled = false;
    // rust: if !stand {
    // rust: Game::native_living_knockback(
    // rust: entity,
    // rust: kind,
    // rust: damage_type,
    // rust: causing,
    // rust: direct,
    // rust: &mut knock.strength,
    // rust: &mut knock.x,
    // rust: &mut knock.z,
    // rust: &mut canceled,
    // rust: );
}
    // rust: let mut canceled_v2 = false;
    // rust: let held = horizon_client::health::knockback_held();
    // rust: Game::native_living_knockback_v2(
    // rust: entity,
    // rust: kind,
    // rust: attacker,
    // rust: held[0].as_ref(),
    // rust: held[1].as_ref(),
    // rust: &mut knock.strength,
    // rust: &mut knock.x,
    // rust: &mut knock.z,
    // rust: &mut canceled_v2,
    // rust: );
    // rust: canceled || canceled_v2
}

    // rust: pub(super) fn block_contact(
    // rust: dimension: &str,
    // rust: event: horizon_client::block_contact::Event<'_>,
    // rust: damage: &mut f32,
    // rust: ) {
//     use horizon_client::block_contact::Event;
    // rust: match event {
    // rust: Event::StepOn(c) => Game::native_block_step_on(
    // rust: dimension,
    // rust: c.entity,
    // rust: c.kind,
    // rust: c.state,
    // rust: [c.position.x, c.position.y, c.position.z],
    // rust: ),
    // rust: Event::Inside(c) => Game::native_block_entity_inside(
    // rust: dimension,
    // rust: c.entity,
    // rust: c.kind,
    // rust: c.state,
    // rust: [c.position.x, c.position.y, c.position.z],
    // rust: ),
    // rust: Event::FallOn(c, distance) => Game::native_block_fall_on(
    // rust: dimension,
    // rust: c.entity,
    // rust: c.kind,
    // rust: c.state,
    // rust: [c.position.x, c.position.y, c.position.z],
    // rust: distance,
    // rust: damage,
    // rust: ),
}
}

/// `native_living_incoming_damage` for the damage code (`health::HURT_SERVER`): whether
/// it canceled the hit. Its one caller.
    // rust: pub(super) fn hurt_server(hurting: Hurting<'_>, amount: &mut f32) -> bool {
    // rust: let (entity, kind, source) = hurt_server_args(hurting);
    // rust: let HurtSource {
    // rust: damage_type,
    // rust: causing,
    // rust: direct,
    // rust: } = source;
    // rust: let mut canceled = false;
    // rust: Game::native_living_incoming_damage(
    // rust: entity,
    // rust: kind,
    // rust: damage_type,
    // rust: causing,
    // rust: direct,
    // rust: amount,
    // rust: &mut canceled,
    // rust: );
    // rust: canceled
}
/// `native_living_incoming_damage`'s entity, entity type and source for a hit.
pub fn hurt_server_args(hurting: Hurting<'_>) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match hurting {
    // rust: Hurting::Player(entity, source) => (entity, "minecraft:player", source),
    // rust: Hurting::Mob(mob, damage) => (mob.id as i32, mob.kind.id.as_str(), mob_source(damage)),
    // rust: Hurting::Dragon(entity, source) => (entity, "minecraft:ender_dragon", source),
    // rust: Hurting::ArmorStand(entity, source) => (entity, "minecraft:armor_stand", source),
}
}
/// A mob's damage as its `DamageSource`: the causing entity is known when it
/// is a mob, and is the direct one too when it deals the damage itself.
pub fn mob_source(damage: *Damage) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let causing = match damage.attacker {
    // rust: Some(Who::Mob(id)) => id as i32,
    // rust: _ => 0,
}
    // rust: let melee = super::creatures::melee(damage.kind);
    // rust: HurtSource {
    // rust: damage_type: super::creatures::source_damage_type(*damage),
    // rust: causing,
    // rust: direct: if melee { causing } else { 0 },
}
}

/// Whether `id` is a sound event's id, `namespace:path` as `Identifier`
/// allows: the namespace of `[a-z0-9_.-]`, the path also with `/`.
pub fn sound_id(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((namespace, path)) = id.split_once(':') else {
    // rust: return false;
}
    // rust: let allowed = |c: char, slash: bool| {
    // rust: c.is_ascii_lowercase() || c.is_ascii_digit() || "_.-".contains(c) || (slash && c == '/')
}
    // rust: !namespace.is_empty()
    // rust: && !path.is_empty()
    // rust: && namespace.chars().all(|c| allowed(c, false))
    // rust: && path.chars().all(|c| allowed(c, true))
}

/// Sets the viewer counts `known` holds for `dim` to `now` and returns the
/// changes as `(pos, previous, viewers)`, in position order. A container that
/// is no longer counted goes to 0 and leaves `known`.
    // rust: pub(super) fn viewer_changes(
    // rust: known: &mut HashMap<(&'static str, (i32, i32, i32)), u32>,
    // rust: dim: &'static str,
    // rust: mut now: HashMap<(i32, i32, i32), u32>,
    // rust: ) -> Vec<((i32, i32, i32), u32, u32)> {
    // rust: let mut changes = Vec::new();
    // rust: known.retain(|&(d, pos), previous| {
    // rust: if d != dim {
    // rust: return true;
}
    // rust: let viewers = now.remove(&pos).unwrap_or(0);
    // rust: if viewers != *previous {
    // rust: changes.push((pos, *previous, viewers));
    // rust: *previous = viewers;
}
    // rust: viewers > 0
    // rust: });
    // rust: for (pos, viewers) in now {
    // rust: known.insert((dim, pos), viewers);
    // rust: changes.push((pos, 0, viewers));
}
    // rust: changes.sort_unstable();
    // rust: changes
}

pub fn dimension_id(dimension: LevelDimension) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match dimension {
    // rust: LevelDimension::Overworld => "minecraft:overworld",
    // rust: LevelDimension::Nether => "minecraft:the_nether",
    // rust: LevelDimension::End => "minecraft:the_end",
}
}

/// Server-level helpers for native mods.
    // rust: impl GameLevel<'_> {
    /// Play a sound event for nearby players in this server level. The return
    /// value means queued, not heard. A `minecraft:` event must be registered:
    /// an unknown one is dropped at dispatch. Another namespace's event (a
    /// mod's, `mymod:machine_hum`) is sent by name, as vanilla sends a sound
    /// that isn't in its registry (`Holder.direct`, a variable range): players
    /// hear it if their resources define it (`assets/mymod/sounds.json`, a
    /// content mod's). API 61.
    // rust: pub(super) fn native_play_sound(
    // rust: &mut self,
    // rust: sound: &str,
    // rust: at: [f64; 3],
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> bool {
    // rust: if !self.native_authoritative || !sound_id(sound) {
    // rust: return false;
}
    // rust: if source >= horizon_client::settings::SOUND_SOURCES.len() {
    // rust: return false;
}
    // rust: let position_ok = at
    // rust: .into_iter()
    // rust: .all(|v| v.is_finite() && v.abs() <= f64::from(i32::MAX) / 8.0);
    // rust: let gain_ok = volume.is_finite() && volume >= 0.0 && pitch.is_finite() && pitch >= 0.0;
    // rust: if !position_ok || !gain_ok {
    // rust: return false;
}
    // rust: self.native_sounds.push(super::creatures::NativeSound {
    // rust: dimension: dimension_id(self.dimension),
    // rust: sound: sound.to_owned(),
    // rust: at,
    // rust: source: source as i32,
    // rust: volume,
    // rust: pitch,
    // rust: });
    // rust: true
}

    /// Queue particles in this authoritative level. A zero count sends one
    /// directional particle. The return value means accepted, not delivered.
    /// Block particle types require their block state; item, trail and
    /// vibration particles are not supported by the current network dispatch.
    /// `ParticleOptions::named("mymod:spark")` sends a mod's own type
    /// (API 103): Horizon clients draw it from the sprite
    /// set in the mod's `assets/<namespace>/particles/<path>.json`, a client
    /// without that file draws nothing, and vanilla clients aren't sent it.
    // rust: pub(super) fn native_send_particles(
    // rust: &mut self,
    // rust: options: &ParticleOptions,
    // rust: state: Option<BlockStateId>,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: i32,
    // rust: ) -> bool {
//         use ParticleType as T;
        // A native mod's own type: the name has to be namespaced, and a client
        // draws it only when its pack has the sprite set.
    // rust: if let Some(name) = &options.mod_particle {
    // rust: let namespaced = name
    // rust: .split_once(':')
    // rust: .is_some_and(|(ns, path)| !ns.is_empty() && !path.is_empty());
    // rust: if !self.native_authoritative || !namespaced {
    // rust: return false;
}
}
    // rust: let supported = match options.ty {
    // rust: T::Block | T::BlockMarker | T::FallingDust | T::DustPillar | T::BlockCrumble => {
    // rust: state.is_some_and(|id| self.registry.state(id).is_some())
}
    // rust: T::Item | T::Trail | T::Vibration => false,
    // rust: T::Geyser | T::GeyserPlume | T::GeyserBase | T::GeyserPoof => options
    // rust: .geyser
    // rust: .is_some_and(|(_, impulse)| impulse.is_finite()),
    // rust: _ => true,
}
    // rust: if !self.native_authoritative
    // rust: || !supported
    // rust: || !at.into_iter().all(f64::is_finite)
    // rust: || !spread
    // rust: .into_iter()
    // rust: .all(|v| v.is_finite() && v.abs() <= f32::MAX as f64)
    // rust: || !speed.is_finite()
    // rust: || speed.abs() > f32::MAX as f64
    // rust: || !options.color.into_iter().all(f32::is_finite)
    // rust: || !options.to_color.into_iter().all(f32::is_finite)
    // rust: || !options.scale.is_finite()
    // rust: {
    // rust: return false;
}
    // rust: self.native_particles
    // rust: .push(super::lan_particles::QueuedParticle {
    // rust: dimension: dimension_id(self.dimension),
    // rust: options: options.clone(),
    // rust: state,
    // rust: at,
    // rust: spread,
    // rust: speed: [speed; 3],
    // rust: count,
    // rust: randomization: 0,
    // rust: });
    // rust: true
}
    /// Sets property `key` of the block at `pos` to `value` with
    /// `Level.setBlock(pos, state, flags)`, from a hook that gets the level's
    /// `ticks` (`native_random_tick`, `native_tick_block`). A crop's random
    /// tick grows it with `flags::UPDATE_CLIENTS`: neighbours' shapes update,
    /// but no neighbour gets `neighborChanged` and comparators aren't told;
    /// `flags::UPDATE_ALL` does both. Horizon sends every write to players
    /// whatever the flags: `UPDATE_CLIENTS`, `UPDATE_INVISIBLE` and
    /// `UPDATE_IMMEDIATE` change nothing yet. Any loaded position, not only
    /// the hook's; true when the block changed, false off an authoritative
    /// server, when the block has no such property or value, `pos` is not
    /// loaded, or the property already has `value` (no write, as
    /// `Level.setBlock` returns false for an unchanged state). Elsewhere,
    /// `Game::native_set_block_property_with` does the same. API 33.
    // rust: pub(super) fn native_set_block_property(
    // rust: &mut self,
    // rust: ticks: &mut Ticks,
    // rust: pos: [i32; 3],
    // rust: key: &str,
    // rust: value: &str,
    // rust: flags: i32,
    // rust: ) -> bool {
    // rust: if !self.native_authoritative {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let state = self.block_state(at);
    // rust: let Some(id) = property_change(self.registry, state, key, value) else {
    // rust: return false;
}
    // rust: let b = self.behaviours;
    // rust: b.set_block(self, ticks, at, id, flags)
}
    /// Schedules a tick of `block` (a block name) at `pos` in `delay` game
    /// ticks, as a falling block's shape update schedules its fall
    /// (`ScheduledTickAccess.scheduleTick(pos, block, delay)`, normal
    /// priority); false for an unknown block or a position that isn't
    /// loaded. A tick of that block already queued there is kept and counts
    /// as scheduled. `ticks` is the hook's. API 32.
    // rust: pub(super) fn native_schedule_block_tick(
    // rust: &self,
    // rust: ticks: &mut Ticks,
    // rust: pos: [i32; 3],
    // rust: block: &str,
    // rust: delay: i32,
    // rust: ) -> bool {
    // rust: let Some(state) = self.registry.default_state(block) else {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let block = self.behaviours.block(state);
    // rust: let time = self.game_time();
    // rust: ticks.schedule_block(time, at, block, delay, TickPriority::Normal)
    // rust: != ScheduleResult::MissingChunk
}
    /// Schedules a tick of `fluid` (`minecraft:water`, `minecraft:lava`,
    /// `minecraft:flowing_water`...) at `pos` in `delay` game ticks, as a
    /// waterlogged block's shape update schedules its water in 5
    /// (`ScheduledTickAccess.scheduleTick(pos, fluid, delay)`); false for
    /// an unknown fluid or a position that isn't loaded. A tick of that
    /// fluid already queued there is kept and counts as scheduled. `ticks` is
    /// the hook's. API 32.
    // rust: pub(super) fn native_schedule_fluid_tick(
    // rust: &self,
    // rust: ticks: &mut Ticks,
    // rust: pos: [i32; 3],
    // rust: fluid: &str,
    // rust: delay: i32,
    // rust: ) -> bool {
    // rust: let Some(kind) = FluidKind::from_name(fluid) else {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let time = self.game_time();
    // rust: ticks.schedule_fluid(time, at, kind, delay) != ScheduleResult::MissingChunk
}
    /// The state `state` with its property `key` set to `value`, as a mod block
    /// builds the state it is placed in: `native_state_with_property(cable,
    /// "facing", "east")` (`BlockState.setValue`). A block's own declared
    /// properties (`state_properties` in its block file) are set the same way.
    /// `state` itself when the property already has that value; None when the
    /// block has no such property, or the property no such value. API
    /// 76.
    // rust: pub(super) fn native_state_with_property(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId> {
    // rust: with_property(self.registry, state, key, value)
}
    /// The block `state` is a state of (`BlockState.getBlock()`): its name,
    /// `mymod:cable`. `native_state_for_placement` is asked for every block
    /// placed and given the block's default state: compare this with your
    /// block to answer only for it. None for an unknown state. API
    /// 164.
    // rust: pub(super) fn native_state_block(&self, state: BlockStateId) -> Option<&str> {
    // rust: self.registry.state(state).map(|s| &*s.name)
}
    /// This level's own random (vanilla's `Level.random`): the stream
    /// `native_level_random(dimension)` hands a server hook, for a world hook
    /// that draws as a vanilla block does (`isBonemealSuccess`), so the mod's
    /// draws shift vanilla's as a Java mod's would. `None` where this level
    /// isn't the server's copy. API 72.
    // rust: pub(super) fn native_level_random(
    // rust: &mut self,
    // rust: ) -> Option<&mut horizon_core::random::LegacyRandom> {
    // rust: self.native_authoritative.then_some(&mut self.world.random)
}
}

/// Helpers for native mods, kept as stable as the hook points.
// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Access a server-owned holder's attachment map. On a client it is the
    /// copy of what the server synced: `set` and `remove` change only the copy.
    // rust: pub(super) fn native_attachments(
    // rust: &mut self,
    // rust: holder: Holder,
    // rust: ) -> AttachmentResult<&mut Attachments> {
    // rust: self.attachment_map(holder)
}
    /// Read a loaded, light-emitting block. No implicit chunk loading.
    // rust: pub(super) fn native_lit_block_name(&self, pos: [i32; 3]) -> Option<&str> {
    // rust: self.world
    // rust: .chunks
    // rust: .contains_key(&(pos[0].div_euclid(16), pos[2].div_euclid(16)))
    // rust: .then(|| {
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: })
    // rust: .filter(|f| f.emission > 0)
    // rust: .map(|f| f.name.as_ref())
}
    /// A small local vanilla particle; caller should rate-limit emission.
    // rust: pub(super) fn native_flame_particle(&mut self, at: [f64; 3], soul: bool) {
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: if !self.native_window() || at.iter().any(|v| !v.is_finite()) {
    // rust: return;
}
    // rust: let Some(p) = self.native_player() else {
    // rust: return;
}
    // rust: if (at[0] - p.x).powi(2) + (at[1] - p.y).powi(2) + (at[2] - p.z).powi(2) > 1024.0 {
    // rust: return;
}
    // rust: let kind = if soul {
    // rust: ParticleType::SoulFireFlame
    // rust: } else {
    // rust: ParticleType::Flame
}
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(kind), at, [0.0, 0.01, 0.0]);
}
    /// The stack the acting player carries in `slot`, by
    /// `native_inventory_tick`'s numbers: none for an empty slot or another
    /// number. Change it as you like: a count of 0 empties the slot at the end
    /// of `native_inventory_tick`, and the player's client gets the change.
    /// API 39.
    // rust: pub(super) fn native_carried_stack(&mut self, slot: i32) -> Option<&mut ItemStack> {
    // rust: self.native_carried_slot(slot)?.as_mut()
}
    /// Whether the player left mod `mod_id` on in Options > Mods. A mod
    /// turned off does nothing (check this first in each hook) until the
    /// launcher's next build leaves it out.
    // rust: pub(super) fn native_on(&self, mod_id: &str) -> bool {
    // rust: !self.settings.mods.disabled.contains(mod_id)
}
    /// Sets a block in the current authoritative level through `Level.setBlock`.
    /// Returns false for another dimension, an invalid state, or no change.
    /// `flags` selects vanilla's neighbour and shape updates; Horizon sends
    /// every write to players whatever the flags. A block entity block gets
    /// its block entity. API 24.
    // rust: pub(super) fn native_set_block(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: || self.pack.assets.registry.state(state).is_none()
    // rust: {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let previous = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let changed =
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, state, flags));
    // rust: let new = self.res.facts().get(state).name.clone();
    // rust: let landed = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if changed
    // rust: && self.res.facts().get(previous).name != new
    // rust: && self.res.facts().get(landed).name == new
    // rust: && let Some(entity) = self.new_block_entity(&new)
    // rust: {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert((pos[0], pos[1], pos[2]), entity);
}
    // rust: let _ = self.process_level_events();
    // rust: changed
}
    /// The strongest redstone signal reaching the block at `pos` from its six
    /// neighbours, 0 to 15 (`SignalGetter.getBestNeighborSignal`, what a
    /// dispenser or a piston reads), in the level in place, `dimension`. 0 on
    /// a client's copy of the world and for another dimension. A mod's
    /// explosive, launcher or machine reads it in its block entity's tick to
    /// go off or switch on. API 96.
    // rust: pub(super) fn native_neighbor_signal(&mut self, dimension: &str, pos: [i32; 3]) -> i32 {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: {
    // rust: return 0;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.best_neighbor_signal(level, ticks, at))
}
    /// The light at `pos` in the world in place, as `(block, sky)`, each 0 to
    /// 15 (`Level.getBrightness` for `LightLayer.BLOCK` and `LightLayer.SKY`).
    /// A solar panel checks for full sky light above it, a lamp or a mob farm
    /// for darkness. `(0, 0)` in a chunk that isn't loaded. Like the other
    /// reads here it reads the world this game holds: the level in place on
    /// a server, the server's copy on a client. API 97.
    // rust: pub(super) fn native_light(&self, pos: [i32; 3]) -> (u8, u8) {
    // rust: if !self.world.loaded(pos[0], pos[2]) {
    // rust: return (0, 0);
}
    // rust: let light = self.world.light(pos[0], pos[1], pos[2]);
    // rust: (light & 15, light >> 4)
}
    /// The rain and thunder levels of the world in place, each 0.0 to 1.0
    /// (`Level.getRainLevel` and `Level.getThunderLevel`): what a solar panel
    /// or a wind turbine reads. Both 0 in the Nether and the End, which have
    /// no weather (`Level.canHaveWeather`). API 97.
    // rust: pub(super) fn native_weather(&self) -> (f32, f32) {
    // rust: self.weather_levels(1.0)
}
    /// The world's time of day in ticks (`Level.getOverworldClockTime`), the
    /// same as `native_clock`'s `day_time`; it keeps counting past 24000, so
    /// take it modulo 24000 for the hour. API 97.
    // rust: pub(super) fn native_day_time(&self) -> i64 {
    // rust: self.world.day_time
}
    /// The lowest block y and the height of the world in place
    /// (`LevelHeightAccessor.getMinY` and `getHeight`): how deep a quarry or a
    /// miner may dig. API 97.
    // rust: pub(super) fn native_world_height(&self) -> (i32, i32) {
    // rust: (self.world.shape.min_y, self.world.shape.height)
}
    /// The most of the item `item` one slot holds (`Item.getDefaultMaxStackSize`),
    /// or `None` for an unknown item: for a mod's container that fills or
    /// merges stacks itself. API 97.
    // rust: pub(super) fn native_max_stack_size(&self, item: &str) -> Option<u32> {
    // rust: self.res.items().get(item).map(|i| i.max_stack)
}
    /// The random of the server level `dimension`: vanilla's `Level.random`
    /// (`level.getRandom()`), the one its explosions, block drops and other
    /// level draws use, so a mod's draws move vanilla's later ones as a Java
    /// mod's do. Draw with `horizon_core::random::RandomSource` (`next_int_bound`,
    /// `next_float`...). `None` on a client of a server, and for a level not
    /// open: the Nether and the End open when someone first goes there and
    /// close after 300 ticks with nobody in them (`close_idle_levels`). API 43.
    // rust: pub(super) fn native_level_random(&mut self, dimension: &str) -> Option<&mut LegacyRandom> {
    // rust: if self.serving.is_none() && self.options.dedicated.is_none() {
    // rust: return None;
}
    // rust: let dim = match dimension {
    // rust: "minecraft:overworld" => super::Dim::Overworld,
    // rust: "minecraft:the_nether" => super::Dim::Nether,
    // rust: "minecraft:the_end" => super::Dim::End,
    // rust: _ => return None,
}
    // rust: if dim == self.dim {
    // rust: Some(&mut self.world.random)
    // rust: } else {
    // rust: self.levels
    // rust: .parked_world_mut(dim)
    // rust: .map(|world| &mut world.random)
}
}
    /// The item entities of the server level `dimension` whose box meets
    /// the box `min`..`max`, in the level's order: vanilla's
    /// `Level.getEntitiesOfClass(ItemEntity.class, box, ENTITY_STILL_ALIVE)`, as a
    /// hopper's `getItemsAtAndAbove` asks for its block and the one above
    /// (`[x, y, z]`..`[x + 1, y + 2, z + 1]`). Empty for a level not in place
    /// (as `native_set_block`) and on a client of a server. API 42.
    // rust: pub(super) fn native_item_entities(
    // rust: &self,
    // rust: dimension: &str,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: ) -> Vec<NativeItemEntity> {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: {
    // rust: return Vec::new();
}
    // rust: self.dropped
    // rust: .iter()
    // rust: .filter(|e| e.stack.count > 0 && box_meets(&e.bounds(), min, max))
    // rust: .map(|e| NativeItemEntity {
    // rust: id: e.id,
    // rust: position: [e.position.x, e.position.y, e.position.z],
    // rust: stack: e.stack.clone(),
                // API 42 exposes an unsigned delay; keep its existing projection.
    // rust: pickup_delay: e.pickup_delay.clamp(0, i64::from(u32::MAX)) as u32,
    // rust: })
    // rust: .collect()
}
    /// Sets the stack of item entity `id` in the server level `dimension`, as
    /// a hopper's `addItem` leaves what it couldn't take (`ItemEntity.setItem`);
    /// an empty stack (count 0) removes the entity (`setItem(EMPTY)`, then
    /// `discard`). Players see it on their next tracker update. False when the
    /// level in place has no such item entity, or on a client. API 42.
    // rust: pub(super) fn native_set_item_entity(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: id: u32,
    // rust: stack: ItemStack,
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: {
    // rust: return false;
}
    // rust: let Some(i) = self.dropped.iter().position(|e| e.id == id) else {
    // rust: return false;
}
    // rust: if stack.count == 0 {
    // rust: self.remove_dropped(i);
    // rust: } else {
    // rust: self.dropped[i].stack = stack;
}
    // rust: true
}
    /// Sets property `key` of the block at `pos` to `value`, as a furnace's
    /// tick sets its `lit` (`Level.setBlock` with `UPDATE_ALL`: neighbours
    /// and clients are told); true when the block changed, false when the
    /// block has no such property or value, or the property already has
    /// `value` (as `Level.setBlock` for an unchanged state). The block
    /// entity stays. API 18.
    // rust: pub(super) fn native_set_block_property(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> bool {
    // rust: self.native_set_block_property_with(pos, key, value, flags::UPDATE_ALL)
}
    /// `native_set_block_property` with `Level.setBlock`'s `flags`, as a
    /// brewing stand's tick sets its bottles with `flags::UPDATE_CLIENTS`.
    /// Players get the write whatever the flags (`flags`); false when this
    /// window isn't a server, and in each case `native_set_block_property`
    /// returns false. API 33.
    // rust: pub(super) fn native_set_block_property_with(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: key: &str,
    // rust: value: &str,
    // rust: flags: i32,
    // rust: ) -> bool {
        // As `native_set_block`: a window that isn't a server holds a copy.
    // rust: if self.serving.is_none() && self.options.dedicated.is_none() {
    // rust: return false;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let Some(id) = property_change(self.pack.assets.registry, state, key, value) else {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.set_block(level, ticks, at, id, flags))
}
    /// The block at `pos` changed its comparator output
    /// (`native_analog_output`) without changing its state: the comparators
    /// beside it, or behind a conductor there, read it again
    /// (`Level.updateNeighbourForOutputSignal`). Acts on the level in place:
    /// false (and nothing happens) when `dimension` is another, or this
    /// window isn't a server. API 64.
    // rust: pub(super) fn native_update_output_neighbors(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.update_neighbour_for_output_signal(level, ticks, at));
    // rust: true
}
    /// The block at `pos` changed the signal it gives: its neighbours, and
    /// theirs (a block it powers passes the signal on), read it again, as
    /// around a lever (`Level.updateNeighborsAt`). Call it when the answer
    /// changes and once the block is placed. Acts on the level in place:
    /// false (and nothing happens) when `dimension` is another, or this
    /// window isn't a server. API 38.
    // rust: pub(super) fn native_update_signal_neighbors(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: ) -> bool {
    // rust: if (self.serving.is_none() && self.options.dedicated.is_none())
    // rust: || dimension != self.dim.id()
    // rust: {
    // rust: return false;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: let block = b.block(state);
    // rust: b.update_neighbors_at(level, ticks, at, block);
    // rust: for [x, y, z] in [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ] {
    // rust: b.update_neighbors_at(level, ticks, at.offset(x, y, z), block);
}
    // rust: });
    // rust: true
}
    /// Runs `change` on the mod block entity at `pos` (a generator charging
    /// the machine beside it) and returns what it returns; none for any
    /// other block entity, and for the one ticking now, which is out of the
    /// world. Afterwards, as its `setChanged` would, its chunk is saved next
    /// time and, when its items changed, comparators read it again. API 18.
    // rust: pub(super) fn native_with_mod_block_entity<R>(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: change: impl FnOnce(&mut ModBlockEntity) -> R,
    // rust: ) -> Option<R> {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&key) else {
    // rust: return None;
}
    // rust: if m.id.is_empty() {
    // rust: return None;
}
    // rust: let items = m.items.clone();
    // rust: let out = change(m);
    // rust: let moved = m.items != items;
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
    // rust: if moved {
    // rust: self.container_changed(key);
}
    // rust: Some(out)
}
    /// Sends clients the block at `pos` and its block entity's update tag
    /// (`native_block_entity_update_tag`) again, as `Level.sendBlockUpdated`
    /// does: with the level's other block changes, to the players who see its
    /// chunk, once however often it is called before then. Changes made in a
    /// block entity's tick go out at the start of the next tick, as vanilla's
    /// do (`ServerLevel.tick` broadcasts chunks before it ticks block
    /// entities). Call it when what clients show changed (a machine started),
    /// not for every tick's progress: a menu's data slots carry that. Nothing
    /// happens for an unloaded block. API 52.
    // rust: pub(super) fn native_block_entity_sync(&mut self, pos: [i32; 3]) {
    // rust: if !self.world.loaded(pos[0], pos[2]) {
    // rust: return;
}
    // rust: if let Some(log) = self.world.block_log.as_mut() {
    // rust: log.push((pos[0], pos[1], pos[2]));
}
}
    /// Playing, with nothing over the world: keys and zoom apply.
    // rust: pub(super) fn native_playing(&self) -> bool {
    // rust: self.screen == Screen::Playing
    // rust: && self.title.is_none()
    // rust: && self.sign_edit.is_none()
    // rust: && self.book.is_none()
}
    /// This `Game` is the window's, not a server's.
    // rust: pub(super) fn native_window(&self) -> bool {
    // rust: self.options.execution_role == ExecutionRole::Client
}
    /// Plays sound event `sound` (`minecraft:entity.generic.explode`, or a
    /// mod's own from its `assets/<id>/sounds.json`) at `at` for this
    /// player only, `delay` ticks from now (0 to 1200, a minute): a client
    /// mod's sound that waits, as thunder heard after the flash or a blast
    /// heard when its shock wave arrives. `volume` past 1 carries farther,
    /// as vanilla's attenuation does (16 blocks times the volume). False, with
    /// nothing played, on a server or for a value out of range; an event the
    /// resources don't have plays nothing, as vanilla's. API
    /// 83.
    // rust: pub(super) fn native_play_local_sound(
    // rust: &mut self,
    // rust: sound: &str,
    // rust: at: [f64; 3],
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: delay: i32,
    // rust: ) -> bool {
    // rust: if !self.native_window() || !local_sound_ok(sound, at, volume, pitch, delay) {
    // rust: return false;
}
    // rust: self.audio.play_after(sound, at, volume, pitch, delay);
    // rust: true
}
    /// Draws one vanilla HUD layer between the mods' hooks: `native_gui_layer_pre`
    /// (which may hide it), the layer, then `native_gui_layer_post`. `None` when
    /// a mod hid the layer.
    // rust: pub(super) fn gui_layer<R>(
    // rust: &mut self,
    // rust: layer: &str,
    // rust: batch: &mut HudBatch,
    // rust: draw: impl FnOnce(&mut Self, &mut HudBatch) -> R,
    // rust: ) -> Option<R> {
    // rust: let mut canceled = false;
    // rust: self.native_gui_layer_pre(layer, batch, &mut canceled);
    // rust: let drawn = (!canceled).then(|| draw(self, batch));
    // rust: self.native_gui_layer_post(layer, batch);
    // rust: drawn
}
    /// Whether a box in `corner` shows: F3's debug screen takes both top
    /// corners (its left and right columns), and a bottom corner while one
    /// of its charts is drawn there.
    // rust: pub(super) fn native_corner_shown(&self, corner: Corner) -> bool {
    // rust: let charts = self.debug_charts.corners(!self.has_singleplayer_server());
    // rust: !debug_takes(corner, self.debug, charts)
}
    /// The width of `text` in GUI pixels.
    // rust: pub(super) fn native_text_width(&self, text: &str) -> f32 {
    // rust: HudBatch::text_width(&self.gui.atlas, text)
}
    /// A rectangle in GUI pixels, `argb` (0x78000000 is the extras' box).
    // rust: pub(super) fn native_fill(&self, batch: &mut HudBatch, rect: [f32; 4], argb: u32) {
    // rust: let [x, y, w, h] = rect;
    // rust: let [a, r, g, b] = argb.to_be_bytes();
    // rust: batch.fill(&self.gui.atlas, x, y, w, h, rgba(r, g, b, a));
}
    /// A mod's own RGBA image, uploaded into the HUD atlas slot
    /// [`MOD_IMAGE_SPRITE`](crate::hud::MOD_IMAGE_SPRITE) and drawn with
    /// `native_sprite`: its own source rectangle crops and stretches it. `rgba`
    /// is `width * height` pixels of four bytes, each side at most
    /// [`MOD_IMAGE_SIZE`](crate::hud::MOD_IMAGE_SIZE); false when it is not that
    /// size. The upload costs a texture patch of the image, so send one when the
    /// image changed, not every frame. API 355.
    // rust: pub(super) fn native_mod_image(&mut self, width: u32, height: u32, rgba: &[u8]) -> bool {
    // rust: let Some(rect) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(crate::hud::MOD_IMAGE_SPRITE)
    // rust: .copied()
    // rust: else {
    // rust: return false;
}
    // rust: if !mod_image_fits(width, height, rgba.len(), rect.w, rect.h) {
    // rust: return false;
}
    // rust: let (w, h) = (self.gui.atlas.width as f32, self.gui.atlas.height as f32);
    // rust: self.map_patches.push(horizon_client::font::Patch {
    // rust: x: (rect.u0 * w).round() as u32,
    // rust: y: (rect.v0 * h).round() as u32,
    // rust: width,
    // rust: height,
    // rust: rgba: rgba.to_vec(),
    // rust: });
    // rust: true
}
    /// Part `src` (`[x, y, w, h]` in the sprite's own pixels) of sprite
    /// `name` (vanilla's `gui/...`, or a content mod's GUI texture
    /// `mymod:gui/...`), drawn stretched into `dst` (`[x, y, w, h]` in GUI
    /// pixels). False when there is no such sprite. API 19.
    // rust: pub(super) fn native_sprite(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: name: &str,
    // rust: src: [f32; 4],
    // rust: dst: [f32; 4],
    // rust: ) -> bool {
    // rust: let Some(mut r) = self.gui.atlas.sprites.get(name).copied() else {
    // rust: return false;
}
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: r.u0 += src[0] * du;
    // rust: r.v0 += src[1] * dv;
    // rust: r.u1 = r.u0 + src[2] * du;
    // rust: r.v1 = r.v0 + src[3] * dv;
    // rust: batch.rect_uv(dst[0], dst[1], dst[2], dst[3], r, u32::MAX);
    // rust: true
}
    /// Item `item`'s icon (`mymod:machine`) with its top left at `at`,
    /// `size` GUI pixels square (16 in a slot); false for an unknown item.
    /// API 20.
    // rust: pub(super) fn native_item(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: item: &str,
    // rust: at: [f32; 2],
    // rust: size: f32,
    // rust: ) -> bool {
    // rust: if self.res.items().get(item).is_none() {
    // rust: return false;
}
    // rust: let start = batch.vertices.len();
    // rust: self.draw_item_model(batch, &ItemStack::new(item, 1), at[0], at[1]);
    // rust: batch.scale_since(start, at[0], at[1], size / 16.0, size / 16.0);
    // rust: true
}
    /// Draw a stack and its slot decorations, except the count, at `at`,
    /// `size` GUI pixels square. False when nothing was drawn: an unknown item
    /// or an empty stack (air, or a count of 0, as `ItemStack.isEmpty`).
    /// API 313.
    // rust: pub(super) fn native_item_stack(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: stack: &ItemStack,
    // rust: at: [f32; 2],
    // rust: size: f32,
    // rust: ) -> bool {
        // GuiGraphicsExtractor.item and itemDecorations draw nothing for an
        // empty stack.
    // rust: if &*stack.item == "minecraft:air" || stack.count == 0 {
    // rust: return false;
}
    // rust: if self.res.items().get(&stack.item).is_none() {
    // rust: return false;
}
    // rust: let start = batch.vertices.len();
    // rust: self.draw_item_model(batch, stack, at[0], at[1]);
    // rust: self.draw_item_decorations(batch, stack, at[0], at[1], Some(String::new()));
    // rust: batch.scale_since(start, at[0], at[1], size / 16.0, size / 16.0);
    // rust: true
}
    /// Item `item`'s icon drawn with model `model` (`minecraft:paper` as
    /// `mymod:wheel_icon`, an `item_model` of a content mod's), as `native_item`
    /// draws one; false for an unknown item. API 111.
    // rust: pub(super) fn native_item_model(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: item: &str,
    // rust: model: &str,
    // rust: at: [f32; 2],
    // rust: size: f32,
    // rust: ) -> bool {
    // rust: if self.res.items().get(item).is_none() {
    // rust: return false;
}
    // rust: let mut stack = ItemStack::new(item, 1);
    // rust: let mut data = horizon_client::item_data::StackData::default();
    // rust: data.set_other(
    // rust: "minecraft:item_model",
    // rust: Some(horizon_world::nbt::Tag::String(model.into())),
    // rust: );
    // rust: stack.extra = Some(Box::new(data));
    // rust: let start = batch.vertices.len();
    // rust: self.draw_item_model(batch, &stack, at[0], at[1]);
    // rust: batch.scale_since(start, at[0], at[1], size / 16.0, size / 16.0);
    // rust: true
}
    /// A quad of corners `points` (in order round it) in GUI pixels, `argb`:
    /// a wedge, a slanted bar, what `native_fill`'s rectangles can't draw.
    /// API 111.
    // rust: pub(super) fn native_quad(&self, batch: &mut HudBatch, points: [[f32; 2]; 4], argb: u32) {
    // rust: let [a, r, g, b] = argb.to_be_bytes();
    // rust: batch.fill_quad(&self.gui.atlas, points, rgba(r, g, b, a));
}
    /// Opens a screen of mod `mod_id`'s own over the world: the screen hooks
    /// fire over it as over any other, so the mod draws it in
    /// `native_screen_render_post` and takes its clicks, scroll, keys and
    /// typing there; the mouse is freed, and Escape closes it. Every mod's own
    /// screen has the `NativeScreenView.id` `mod`, so a mod's screen hooks
    /// check `native_mod_screen()` is its own before drawing. It doesn't pause
    /// a single-player game (as the inventory doesn't). True when it is open:
    /// false while another screen is (or another mod's), over the title
    /// screen, a book, a sign editor, a dialog or a prompt, while the world
    /// loads, and anywhere but the window's own client (the server thread, a
    /// dedicated server). A gamepad can close it (B, Start) but not click on
    /// it: its clicks don't reach the mouse hooks. API 111.
    // rust: pub(super) fn native_mod_screen_open(&mut self, mod_id: &str) -> bool {
        // What `screen_hooks_open` would refuse over the world: the mod's
        // screen would be up with no hook to draw or click it.
    // rust: let blocked = self.title.is_some()
    // rust: || self.renderer.is_none()
    // rust: || self.lan_acting.is_some()
    // rust: || self.player.is_none()
    // rust: || self.screen_over_playing()
    // rust: || self.remote_loading();
    // rust: let owner = self.native_mod_screen();
    // rust: if let Some(open) = mod_screen_opens(self.screen, blocked, owner, mod_id) {
    // rust: return open;
}
    // rust: self.native_mod_screen = Some(mod_id.to_owned());
    // rust: self.screen = Screen::Mod;
    // rust: self.keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.mining = None;
    // rust: self.capture(false);
    // rust: true
}
    /// Closes mod `mod_id`'s own screen, if it is open. API 111.
    // rust: pub(super) fn native_mod_screen_close(&mut self, mod_id: &str) {
    // rust: if self.native_mod_screen().is_some_and(|id| id == mod_id) {
    // rust: self.close_mod_screen();
}
}
    /// The mod whose own screen is open, if one is (Escape, or another screen
    /// replacing it, closes it). API 111.
    // rust: pub(super) fn native_mod_screen(&self) -> Option<&str> {
    // rust: self.native_mod_screen
    // rust: .as_deref()
    // rust: .filter(|_| self.screen == Screen::Mod)
}
    /// A mod's own screen closes (Escape, or `native_mod_screen_close`).
    // rust: pub(super) fn close_mod_screen(&mut self) {
    // rust: self.native_mod_screen = None;
    // rust: if self.screen == Screen::Mod {
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    /// The open menu's title (the block's name, or the one it was given),
    /// as plain text. API 20.
    // rust: pub(super) fn native_screen_title(&self) -> Option<String> {
    // rust: self.remote_menu_title().map(|t| t.plain())
}
    /// The block of the mod screen that is open (`native_screen`), as the
    /// server named it when the block opened its menu type; None when no mod
    /// screen is open. 401.
    // rust: pub(super) fn native_screen_pos(&self) -> Option<[i32; 3]> {
    // rust: self.shown_native_screen()?.pos()
}
    /// What the block's mod wrote for the mod screen that is open
    /// (`native_menu_extra_data` on the server), empty when it wrote nothing;
    /// None when no mod screen is open. 401.
    // rust: pub(super) fn native_screen_extra_data(&self) -> Option<&[u8]> {
    // rust: let screen = self.shown_native_screen()?;
    // rust: Some(screen.extra.as_ref().map_or(&[], |e| e.data.as_slice()))
}
    /// Horizon's own health HUD state, for a mod answering
    /// `native_health_hud`. `left_height`/`right_height` as they stand when
    /// the hook returns place the selected item's name and the action bar
    /// (vanilla's `Hud.leftHeight`/`rightHeight`): set them when you draw
    /// more or fewer rows. `layout` draws Horizon's rows and advances their
    /// frame state (the hearts' blink, the bubble pop sound), so call it at
    /// most once a frame, and only when you keep some of its rows.
    /// API @API:health_hud_state@.
    // rust: pub(super) fn native_health_hud_state(&mut self) -> &mut HealthHud {
    // rust: &mut self.health_hud
}
    /// The current value, base plus modifiers, of this client's player's
    /// attribute `name` (`minecraft:armor_toughness`), as vanilla's
    /// `LivingEntity.getAttributeValue`. None with no player, or for an id
    /// the player has no attribute for. API @API:health_hud_state@.
    // rust: pub(super) fn native_local_attribute(&mut self, name: &str) -> Option<f64> {
    // rust: self.player.as_mut()?.attribute(name).ok()
}
    /// A data file of the game's resources, content mods' included
    /// (`data/mymod/machines.json`), when there is one: what a mod's content
    /// says, read at runtime. Only relative paths of plain names. API 20.
    // rust: pub(super) fn native_data(&self, path: &str) -> Option<Vec<u8>> {
    // rust: let plain = |p: &str| !p.is_empty() && p != "." && p != ".." && !p.contains('\\');
    // rust: if !path.starts_with("data/") || !path.split('/').all(plain) {
    // rust: return None;
}
    // rust: fs::read(self.options.resources.join(path)).ok()
}
    /// The block at `pos` (`mymod:cable`; air where nothing is loaded).
    /// API 20.
    // rust: pub(super) fn native_block(&self, pos: [i32; 3]) -> String {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.res.facts().get(state).name.to_string()
}
    /// The most recently extracted world frame's camera, if one exists.
    /// During GUI rendering this is the current frame, including bob/spin and FOV.
    // rust: pub(super) fn native_camera(&self) -> Option<NativeCamera> {
    // rust: self.native_camera_frame.clone()
}
    /// Collision boxes in block-local coordinates with an empty collision context.
    // rust: pub(super) fn native_block_collision(&self, pos: [i32; 3]) -> Vec<[f64; 6]> {
    // rust: self.block_collision_shape(pos)
    // rust: .boxes()
    // rust: .iter()
    // rust: .map(|bounds| {
    // rust: let min = bounds.min_position();
    // rust: let max = bounds.max_position();
    // rust: [min.x, min.y, min.z, max.x, max.y, max.z]
    // rust: })
    // rust: .collect()
}
    /// Property `key` of the block at `pos` (a machine's `facing`), if it
    /// has one. API 20.
    // rust: pub(super) fn native_block_property(&self, pos: [i32; 3], key: &str) -> Option<String> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get(key)
    // rust: .cloned()
}
    /// Puts `stack` into the container at `pos` (a chest, a furnace, a mod
    /// container) through its side `face`, as a hopper would, one by one, and
    /// returns what did not fit: a machine's auto-output. A composter takes
    /// one a call, and a client's copy of the world none. API 20.
    // rust: pub(super) fn native_insert_item(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: Direction,
    // rust: stack: ItemStack,
    // rust: ) -> Option<ItemStack> {
    // rust: self.insert_stack_through(pos, face, stack)
}
    /// The window's width and height in physical pixels, independent of GUI
    /// scale; none on a server or when no window exists. API 165.
    // rust: pub(super) fn native_physical_window_size(&self) -> Option<[u32; 2]> {
    // rust: let size = self.window.as_ref()?.inner_size();
    // rust: Some([size.width, size.height])
}
    /// Where the mouse is, in GUI pixels. API 20.
    // rust: pub(super) fn native_cursor(&self) -> [f32; 2] {
    // rust: [self.cursor.0, self.cursor.1]
}
    /// The size of sprite `name` in its own pixels, if there is one. API 19.
    // rust: pub(super) fn native_sprite_size(&self, name: &str) -> Option<[f32; 2]> {
    // rust: let r = self.gui.atlas.sprites.get(name)?;
    // rust: Some([r.w as f32, r.h as f32])
}
    /// A line of text at `(x, y)` in GUI pixels, opaque `rgb`.
    // rust: pub(super) fn native_text(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: text: &str,
    // rust: at: [f32; 2],
    // rust: rgb: u32,
    // rust: shadow: bool,
    // rust: ) {
    // rust: let [x, y] = at;
    // rust: let [_, r, g, b] = rgb.to_be_bytes();
    // rust: let color = rgba(r, g, b, 0xFF);
    // rust: batch.text_styled(&self.gui.atlas, &Text::literal(text), x, y, color, shadow);
}
    /// The player, in a world.
    // rust: pub(super) fn native_player(&self) -> Option<NativePlayer> {
    // rust: let p = self.player.as_ref()?;
    // rust: Some(NativePlayer {
    // rust: x: p.position.x,
    // rust: y: p.position.y,
    // rust: z: p.position.z,
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: dimension: self.dim.id(),
    // rust: })
}
    /// The clock of the world this window shows, for client mods: its game
    /// time and time of day as the server last sent them
    /// (`ClientboundSetTimePacket`), advanced each tick between packets; none
    /// on the title screen. API 92.
    // rust: pub(super) fn native_clock(&self) -> Option<NativeClock> {
    // rust: self.player.is_some().then_some(NativeClock {
    // rust: game_time: self.world.game_time,
    // rust: day_time: self.world.day_time,
    // rust: })
}
    /// The frame counter: frames in the last second, the slowest frame and
    /// the 1% low of the last 5 seconds, in frames per second.
    // rust: pub(super) fn native_frame_rate(&self) -> (u32, u32, u32) {
    // rust: self.frame_reading()
}
    /// Attack and use clicks in the last second.
    // rust: pub(super) fn native_clicks(&mut self) -> (u32, u32) {
    // rust: self.mouse_reading().0
}
    /// A vanilla mapping (`key.forward`, `key.jump`, `key.attack`…): whether
    /// it is held, and its key's label as Controls shows it.
    // rust: pub(super) fn native_mapping(&mut self, name: &str) -> Option<(bool, String)> {
    // rust: let &(_, key) = MAPPINGS.iter().find(|m| m.0 == name)?;
    // rust: let label = keybinds::display_name(self.settings.keys.get(name)).plain();
    // rust: let down = match key {
    // rust: Some(k) => self.movement_key_held(k),
    // rust: None => self.mouse_reading().1[usize::from(name == "key.use")],
}
    // rust: Some((down, label))
}
    /// The key the player chose for a mod's key `name`, else `default`
    /// (`key.keyboard.z`), as the WebAssembly mods' keys were kept
    /// (`key.<mod id>.<name>` in `horizon-mods.txt`).
    // rust: pub(super) fn native_mod_key(&self, mod_id: &str, name: &str, default: &str) -> String {
    // rust: let chosen = self
    // rust: .settings
    // rust: .mods
    // rust: .keys
    // rust: .get(mod_id)
    // rust: .and_then(|k| k.get(name));
    // rust: chosen.map_or(default, String::as_str).to_owned()
}
    /// A line in chat from the client.
    // rust: pub(super) fn native_chat(&mut self, text: &str) {
    // rust: let focused = self.screen == Screen::Chat;
    // rust: let line = Text::literal(text);
    // rust: let ticks = self.visual_ticks();
    // rust: let atlas = &self.gui.atlas;
    // rust: self.ui
    // rust: .chat
    // rust: .add(atlas, line, None, ChatSource::Client, ticks, focused);
}
    /// The instance (game) folder, which its players share: `saves/`,
    /// `resourcepacks/`, `shaderpacks/` and `horizon-mods/` are in it, and the
    /// title's screens create worlds and read packs there. A world's own
    /// `datapacks/` is in that world's folder (`saves/<world>/datapacks`).
    /// The folder the game runs in (`--player-dir` moves a player's options
    /// and servers only, not the instance). Nothing is created. API 326.
    // rust: pub(super) fn native_instance_dir(&self) -> PathBuf {
    // rust: Self::game_dir()
}
    /// A native mod's own folder: `horizon-mods/.horizon-mod-data/<id>/`,
    /// where the WebAssembly mod of the same id kept its storage, so a
    /// player's settings carry over. Not created here.
    // rust: pub(super) fn native_data_dir(&self, mod_id: &str) -> PathBuf {
    // rust: let mods = Self::game_dir().join(mod_list::DIR);
    // rust: mods.join(".horizon-mod-data").join(mod_id)
}
    /// The folder mod `mod_id`'s post-build step wrote into when the launcher built the game
    /// (`native-data/<id>/` in the build's version folder); None when the game's own path is
    /// unknown. API 41.
    // rust: pub(super) fn native_built_data(&self, mod_id: &str) -> Option<PathBuf> {
    // rust: horizon_client::native_data::built(mod_id)
}
    /// A mod's setting `key` (one file per key in `native_data_dir`).
    // rust: pub(super) fn native_setting(&self, mod_id: &str, key: &str) -> Option<String> {
    // rust: let path = self.native_data_dir(mod_id).join(key);
    // rust: fs::read_to_string(path).ok().map(|v| v.trim().to_owned())
}
    /// Keeps a mod's setting `key`.
    // rust: pub(super) fn native_set_setting(&self, mod_id: &str, key: &str, value: &str) {
    // rust: let dir = self.native_data_dir(mod_id);
    // rust: let _ = fs::create_dir_all(&dir).and_then(|()| fs::write(dir.join(key), value));
}
    /// The game's `config/` folder beside `options.txt`, shared by every mod
    /// as on Fabric and NeoForge: a mod names its own files in it
    /// (`config/<id>.json`, or a folder of its own). The same folder on the
    /// window, its server thread and a LAN host; a dedicated server's is in
    /// its own folder, beside `server.properties`. Made when missing. No
    /// `self`, so a mixin helper calls `Game::native_config_dir()` and a trait
    /// mod `Host::config_dir`. API 26.
    // rust: pub(super) fn native_config_dir() -> Result<PathBuf, String> {
    // rust: config_dir(&Self::game_dir())
}
    /// Shows the panel beside container screens with these items (at most
    /// 8192), as the game's own slots in pages, with a search box; the
    /// player's clicks, searches and keys over items come back as
    /// `native_panel_event`. The panel is the last mod's to show one; empty
    /// items and no recipe page take yours away.
    // rust: pub(super) fn native_panel_items(&mut self, mod_id: &str, items: Vec<NativeStack>) {
    // rust: self.panel.show_items(mod_id, items);
}
    /// Shows these recipes in the panel instead of its items, as many as
    /// fit a page, under `title` and a back button, with a row of `tabs`
    /// (each an icon; `tab` is the selected one) between them. At most 256
    /// recipes and 16 tabs; no recipes shows the items again. The same title
    /// and tab again keep the page the player turned to.
    // rust: pub(super) fn native_panel_recipes(
    // rust: &mut self,
    // rust: mod_id: &str,
    // rust: title: &str,
    // rust: tabs: Vec<NativeStack>,
    // rust: tab: u32,
    // rust: views: Vec<NativeRecipeView>,
    // rust: ) {
    // rust: let page = RecipePage::new(title, tabs, tab, views);
    // rust: self.panel.show_recipes(mod_id, page);
}
    /// The recipes of type `kind` (`mymod:crusher`), a type outside `minecraft`,
    /// from `data/<namespace>/recipe/*.json` of the content mods (`.hmod`) and
    /// the world's data packs, in file order: each one's id and its file as
    /// JSON, for the mod to read as it likes. A data pack changes them on
    /// `/reload`, so look them up again when you need them. Empty for a type
    /// nobody uses and outside a world. These are the server's table on the
    /// server thread, a dedicated server or a LAN host; a client, the
    /// single-player window included, sees only the content mods' recipes, not
    /// the world's data packs', unless a mod had the server send it the type
    /// (`native_datapack_sync`). API 36.
    // rust: pub(super) fn native_recipes_of_type(&self, kind: &str) -> &[CustomRecipe] {
    // rust: if self.outside_world() {
    // rust: return &[];
}
    // rust: self.recipes().custom.get(kind).map_or(&[], Vec::as_slice)
}
    /// The validated category and icon of a custom recipe type, or None for
    /// an undeclared/invalid type, before resources load, or outside a world.
    /// Rebuilt when the recipe table changes. Does not unlock any recipes.
    // rust: pub(super) fn native_recipe_book_category(&mut self, kind: &str) -> Option<RecipeBookCategory> {
    // rust: if self.outside_world() || self.res.rest.get().is_none() {
    // rust: return None;
}
    // rust: self.registered_recipe_book_category(kind)
}
    /// An ingredient as a recipe's JSON names it: an item, a `#tag`, or a list
    /// of them, a bare id as `minecraft:` (as vanilla reads it); `test` says
    /// whether a stack fits. Items the game doesn't know are left out; None
    /// when nothing is left (an unknown or empty tag, for one) and outside a
    /// world. API 36.
    // rust: pub(super) fn native_recipe_ingredient(&self, json: &serde_json::Value) -> Option<Ingredient> {
    // rust: if self.outside_world() {
    // rust: return None;
}
    // rust: let qualify = |s: &str| match s.strip_prefix('#') {
    // rust: Some(tag) => String::from("#") + &qualified(tag),
    // rust: None => qualified(s),
}
    // rust: let json = match json {
    // rust: serde_json::Value::String(s) => serde_json::Value::String(qualify(s)),
    // rust: serde_json::Value::Array(a) => serde_json::Value::Array(
    // rust: a.iter()
    // rust: .filter_map(serde_json::Value::as_str)
    // rust: .map(|s| serde_json::Value::String(qualify(s)))
    // rust: .collect(),
    // rust: ),
    // rust: _ => return None,
}
    // rust: let items = self.items();
    // rust: let known: Vec<String> = Ingredient::parse(&json, items)?
    // rust: .order
    // rust: .into_iter()
    // rust: .filter(|item| items.get(item).is_some())
    // rust: .collect();
    // rust: (!known.is_empty()).then(|| Ingredient::of(known))
}
    /// A stack as a recipe's `result` names it: `id` (a bare one as
    /// `minecraft:`), `count` (1 by default, up to 99) and `components`. None
    /// without an `id`, for an item the game doesn't know or a count outside
    /// that, and outside a world. API 36.
    // rust: pub(super) fn native_recipe_result(&self, json: &serde_json::Value) -> Option<ItemStack> {
    // rust: if self.outside_world() {
    // rust: return None;
}
    // rust: let mut json = json.clone();
    // rust: if let Some(id) = json["id"].as_str() {
    // rust: json["id"] = qualified(id).into();
}
    // rust: recipe_result(&json).filter(|s| self.items().get(&s.item).is_some())
}
    /// No world is open: a client without a player (the title screen). A
    /// server's `Game` (the server thread, a dedicated server, a LAN host)
    /// has no player of its own, and is always in its world.
pub fn outside_world(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.is_none() && self.options.execution_role.is_client()
}
    /// Every item and recipe the game knows, made once (the same for every
    /// call); none outside a world. They are the window's own (the content
    /// mods' and vanilla's), with the server's recipes of the types a mod had
    /// it send (`native_datapack_sync`) in their place; made again when those
    /// arrive (`native_recipes_received`).
    // rust: pub(super) fn native_recipes(&mut self) -> Option<Arc<NativeRecipes>> {
    // rust: self.player.as_ref()?;
    // rust: self.made_recipes()
}
    /// The `book_id`s of the recipes the player's recipe book holds now
    /// (the server's book on a server); empty outside a world.
    // rust: pub(super) fn native_known_recipes(&mut self) -> Arc<[i32]> {
    // rust: if self.player.is_none() {
    // rust: return Arc::from([]);
}
    // rust: self.known_displays()
}
    /// Places a recipe in the open screen's grid as a click in the recipe
    /// book does (`ServerboundPlaceRecipePacket`): the inventory's grid or a
    /// crafting table's. `all` places as many as the items allow, as with
    /// Shift. Refused while no such screen is open and for a recipe the
    /// player's book doesn't hold; one missing items shows as a ghost.
    // rust: pub(super) fn native_place_recipe(&mut self, book_id: i32, all: bool) -> Result<(), String> {
    // rust: self.recipe_place(book_id, all)
}
    /// Creative mode only: gives the player `count` of `item`
    /// (`minecraft:diamond`) as taking it from the creative inventory does
    /// (`ServerboundSetCreativeModeSlot`): the selected slot first, then the
    /// hotbar, then the inventory. The count is cut to one stack.
    // rust: pub(super) fn native_give(&mut self, item: &str, count: u32) -> Result<(), String> {
    // rust: self.recipe_give(item, count)
}
}

/// A mob's kind as the hook points name it (`minecraft:zombie`).
    // rust: pub(super) fn mob_kind(mob: &horizon_client::mobs::Mob) -> String {
    // rust: ["minecraft:", mob.kind.id.trim_start_matches("minecraft:")].concat()
}

/// Where the game calls the hook points.
    // rust: impl Game<'_> {
    /// The acting player as the hook points name one: the guest whose turn
    /// it is, else the host.
    // rust: pub(super) fn native_acting_id(&mut self) -> u128 {
    // rust: horizon_client::lan::playerdata::ints_uuid(self.acting_player_uuid())
}
    /// The mods' say on a broken block's drops (`native_loot_drops`).
    // rust: pub(super) fn native_block_drops(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: state: BlockStateId,
    // rust: player: Option<u128>,
    // rust: tool: Option<&ItemStack>,
    // rust: explosion: Option<f32>,
    // rust: drops: &mut Vec<ItemStack>,
    // rust: ) {
    // rust: let items = match &self.world_tables {
    // rust: Some(tables) => &tables.items,
    // rust: None => self.res.items(),
}
    // rust: let table = items.block_loot_table(self.pack.assets.registry, state);
    // rust: let context = NativeLootDrops {
    // rust: table: table.as_deref().unwrap_or_default(),
    // rust: dimension: self.dim.id(),
    // rust: origin: pos.map(|c| f64::from(c) + 0.5),
    // rust: block: Some((pos, state)),
    // rust: entity: None,
    // rust: player,
    // rust: tool,
    // rust: explosion,
    // rust: used: false,
}
    // rust: self.native_loot_drops(&context, drops);
    // rust: drops.retain(|stack| stack.count > 0 && &*stack.item != "minecraft:air");
}
    /// The mods' say on what the acting player's use drops
    /// (`NativeLootDrops::used`): `table` is the loot table rolled, if any.
    // rust: pub(super) fn native_use_drops(
    // rust: &mut self,
    // rust: table: &str,
    // rust: origin: [f64; 3],
    // rust: block: Option<([i32; 3], BlockStateId)>,
    // rust: entity: Option<(u32, &str)>,
    // rust: tool: Option<&ItemStack>,
    // rust: drops: &mut Vec<ItemStack>,
    // rust: ) {
    // rust: let player = Some(self.native_acting_id());
    // rust: let context = NativeLootDrops {
    // rust: table,
    // rust: dimension: self.dim.id(),
    // rust: origin,
    // rust: block,
    // rust: entity,
    // rust: player,
    // rust: tool,
    // rust: explosion: None,
    // rust: used: true,
}
    // rust: self.native_loot_drops(&context, drops);
    // rust: drops.retain(|stack| stack.count > 0 && &*stack.item != "minecraft:air");
}
    /// Whether a native mod keeps the acting player from taking `stack`.
    // rust: pub(super) fn native_pickup_refused(&mut self, stack: &ItemStack) -> bool {
    // rust: let player = self.native_acting_id();
    // rust: let mut canceled = false;
    // rust: self.native_item_picked_up(player, &stack.item, stack.count, &mut canceled);
    // rust: canceled
}
    /// Tells the mods of the chunks that came and went in this level.
    // rust: pub(super) fn native_chunks_changed(
    // rust: &mut self,
    // rust: unloaded: &[std::sync::Arc<horizon_client::chunk::Chunk>],
    // rust: ) {
    // rust: let loaded = std::mem::take(&mut self.world.loaded_chunks);
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let dimension = self.dim.id();
    // rust: for (x, z, new) in loaded {
    // rust: self.native_chunk_load(dimension, [x, z], new);
}
    // rust: for chunk in unloaded {
    // rust: self.native_chunk_unload(dimension, [chunk.x, chunk.z]);
}
}
    /// The players still here leave with the server (`PlayerList.removeAll`):
    /// the mods hear it once, whichever path closes it.
    // rust: pub(super) fn native_players_leaving(&mut self) {
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: if std::mem::replace(&mut host.players_told_left, true) {
    // rust: return;
}
    // rust: let players: Vec<(u128, String)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| (g.uuid, g.name.clone()))
    // rust: .collect();
    // rust: for (player, name) in players {
    // rust: self.native_player_logged_out(player, &name);
}
        // No tick follows to send what they said.
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: self.flush_native_net(&mut host);
    // rust: self.lan = Some(host);
}
}
    /// The mobs from index `from` on are new in the world.
    // rust: pub(super) fn native_mobs_joined(&mut self, from: usize, natural: bool) {
        // A mod can keep a mob out; it is then taken out and not told of.
    // rust: self.native_joins_flush(false, 0);
    // rust: for i in from..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: let (kind, pos) = (mob_kind(m), [m.position.x, m.position.y, m.position.z]);
    // rust: self.native_mob_spawned(self.dim.id(), &kind, pos, natural);
}
}
    /// The acting player's blow killed mob `index`.
    // rust: pub(super) fn native_kill_event(&mut self, index: usize) {
    // rust: let (entity, kind) = (self.mobs[index].id, mob_kind(&self.mobs[index]));
    // rust: let player = self.native_acting_id();
    // rust: self.native_mob_killed(player, entity, &kind);
}
    /// The acting player's hit landed on mob `index`, holding `stack`.
    // rust: pub(super) fn native_hurt_enemy_event(&mut self, stack: &ItemStack, index: usize) {
    // rust: let mob = &self.mobs[index];
    // rust: let kind = ["minecraft:", mob.kind.id.trim_start_matches("minecraft:")].concat();
    // rust: self.native_hurt_enemy(stack, mob.id, &kind);
}
    /// `Inventory.tick` for the acting player: each carried stack goes through
    /// `native_inventory_tick`.
    // rust: pub(super) fn native_inventory_ticks(&mut self) {
    // rust: if self.player.is_none() {
    // rust: return;
}
    // rust: for i in 0..self.inventory.len() {
    // rust: self.native_slot_tick(i as i32, i == self.selected);
}
        // Head first here; `Inventory` saves feet as 100 and head as 103.
    // rust: for i in 0..self.armor.len() {
    // rust: self.native_slot_tick(103 - i as i32, false);
}
    // rust: self.native_slot_tick(-106, false);
}
pub fn native_slot_tick(self: *Self, slot: i32, selected: bool) void {
}
    // rust: if self.native_carried_slot(slot).is_none_or(|s| s.is_none()) {
    // rust: return;
}
    // rust: self.native_inventory_tick(slot, selected);
    // rust: if let Some(stack) = self.native_carried_slot(slot)
    // rust: && stack.as_ref().is_some_and(|s| s.count == 0)
    // rust: {
    // rust: *stack = None;
}
}
    /// The slot a player's carried stack is in, by `native_inventory_tick`'s
    /// numbers: none for another number.
pub fn native_carried_slot(self: *Self, slot: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match slot {
    // rust: 0.. if (slot as usize) < self.inventory.len() => self.inventory.get_mut(slot as usize),
    // rust: 100..=103 => self.armor.get_mut(103 - slot as usize),
    // rust: -106 => Some(&mut self.offhand),
    // rust: _ => None,
}
}
    /// `EntityBlock.newBlockEntity` of block `name`: Horizon's own, else a
    /// native mod's.
    // rust: pub(super) fn new_block_entity(&mut self, name: &str) -> Option<BlockEntity> {
        // `SignBlock.newBlockEntity`: a mod's sign is one by its template's class.
    // rust: if !name.starts_with("minecraft:")
    // rust: && let Some(state) = self.pack.assets.registry.default_state(name)
    // rust: && let Some(form) = self.res.facts().get(state).sign_form()
    // rust: {
    // rust: return Some(BlockEntity::Sign(horizon_client::signs::SignData {
    // rust: hanging: form.hanging,
    // rust: ..Default::default()
    // rust: }));
}
    // rust: if let Some(entity) = BlockEntity::for_block(name) {
    // rust: return Some(entity);
}
    // rust: let mut entity = None;
    // rust: self.native_block_entity(name, &mut entity);
    // rust: let (id, nbt) = entity?;
    // rust: Some(BlockEntity::Mod(Box::new(
    // rust: ModBlockEntityFields {
    // rust: id,
    // rust: nbt,
    // rust: ..Default::default()
}
    // rust: .into(),
    // rust: )))
}
    /// The containers of the mod blocks' block entities, by block state
    /// (`native_block_entity_container`), checked.
    // rust: pub(super) fn native_containers(&self) -> FxHashMap<u32, Arc<ModContainer>> {
    // rust: let registry = self.pack.assets.registry;
    // rust: let mut by_block: FxHashMap<String, Option<Arc<ModContainer>>> = FxHashMap::default();
    // rust: let mut out = FxHashMap::default();
    // rust: for i in 0..registry.len() as u32 {
    // rust: let Some(state) = registry.state(horizon_world::registry::BlockStateId(i)) else {
    // rust: continue;
}
    // rust: if state.name.starts_with("minecraft:") {
    // rust: continue;
}
    // rust: let container = by_block.entry(state.name.clone()).or_insert_with(|| {
    // rust: let mut container = None;
    // rust: self.native_block_entity_container(&state.name, &mut container);
    // rust: container.map(|mut c| {
    // rust: c.slots = c.slots.min(256);
    // rust: let n = c.slots;
    // rust: for list in c.faces.iter_mut().chain([&mut c.inputs, &mut c.outputs]) {
    // rust: list.retain(|&s| s < n);
}
    // rust: c.menu = c
    // rust: .menu
    // rust: .filter(|m| mod_menu(m).is_some_and(|(_, size)| size == n));
    // rust: Arc::new(c)
    // rust: })
    // rust: });
    // rust: if let Some(c) = container {
    // rust: out.insert(i, Arc::clone(c));
}
}
    // rust: out
}
    /// The fluid tanks of the mod blocks' block entities, by block state
    /// (`native_block_entity_fluids`), checked as the containers are.
    // rust: pub(super) fn native_fluid_tables(&self) -> FxHashMap<u32, Arc<ModFluidTanks>> {
    // rust: let registry = self.pack.assets.registry;
    // rust: let mut by_block: FxHashMap<String, Option<Arc<ModFluidTanks>>> = FxHashMap::default();
    // rust: let mut out = FxHashMap::default();
    // rust: for i in 0..registry.len() as u32 {
    // rust: let Some(state) = registry.state(horizon_world::registry::BlockStateId(i)) else {
    // rust: continue;
}
    // rust: if state.name.starts_with("minecraft:") {
    // rust: continue;
}
    // rust: let tanks = by_block.entry(state.name.clone()).or_insert_with(|| {
    // rust: let mut fluids = None;
    // rust: self.native_block_entity_fluids(&state.name, &mut fluids);
    // rust: fluids.map(|mut f| {
    // rust: f.tanks.truncate(16);
                    // Clamped, not dropped: the face and fill lists name
                    // tanks by number, which must not shift.
    // rust: for c in &mut f.tanks {
    // rust: *c = (*c).clamp(1, 1_000_000);
}
    // rust: let n = f.tanks.len();
    // rust: for list in f.faces.iter_mut().chain([&mut f.inputs, &mut f.outputs]) {
    // rust: list.retain(|&t| t < n);
}
    // rust: Arc::new(f)
    // rust: })
    // rust: });
    // rust: if let Some(t) = tanks {
    // rust: out.insert(i, Arc::clone(t));
}
}
    // rust: out
}
    /// The energy buffers of the mod blocks' block entities, by block state
    /// (`native_block_entity_energy`), checked as the containers are.
    // rust: pub(super) fn native_energy_tables(&self) -> FxHashMap<u32, Arc<ModEnergyBuffer>> {
    // rust: let registry = self.pack.assets.registry;
    // rust: let mut by_block: FxHashMap<String, Option<Arc<ModEnergyBuffer>>> = FxHashMap::default();
    // rust: let mut out = FxHashMap::default();
    // rust: for i in 0..registry.len() as u32 {
    // rust: let Some(state) = registry.state(horizon_world::registry::BlockStateId(i)) else {
    // rust: continue;
}
    // rust: if state.name.starts_with("minecraft:") {
    // rust: continue;
}
    // rust: let buffer = by_block.entry(state.name.clone()).or_insert_with(|| {
    // rust: let mut energy = None;
    // rust: self.native_block_entity_energy(&state.name, &mut energy);
    // rust: energy.filter(|e| e.capacity >= 1).map(|mut e| {
    // rust: e.max_insert = e.max_insert.clamp(0, e.capacity);
    // rust: e.max_extract = e.max_extract.clamp(0, e.capacity);
    // rust: Arc::new(e)
    // rust: })
    // rust: });
    // rust: if let Some(b) = buffer {
    // rust: out.insert(i, Arc::clone(b));
}
}
    // rust: out
}
    /// Whether a native mod's block `name` has a ticking block entity.
    // rust: pub(super) fn native_ticks(&self, name: &str) -> bool {
    // rust: let mut ticks = false;
    // rust: self.native_block_entity_ticks(name, &mut ticks);
    // rust: ticks
}
    /// A mod block's container at `key` opens its menu: its slots grown to
    /// the menu's. False for any other block.
    // rust: pub(super) fn open_mod_menu(&mut self, key: Pos) -> bool {
    // rust: let state = self.world.block(key.0, key.1, key.2).0;
    // rust: let Some(c) = self.world.block_entities.mod_container(state) else {
    // rust: return false;
}
    // rust: let slots = c.slots;
    // rust: if c.menu.is_none() {
    // rust: return false;
}
    // rust: let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&key) else {
    // rust: return false;
}
    // rust: if m.items.len() < slots {
    // rust: m.items.resize(slots, None);
}
    // rust: true
}
    /// `ContainerOpenersCounter` for the mod containers of the level in place:
    /// everyone with one open, recounted every tick, so a change is heard
    /// whichever way an opener left (`native_mod_container_viewers`). The
    /// openers are the guests (but not a spectator, `BarrelBlockEntity.startOpen`),
    /// the host's own player, and the copper golems that opened it
    /// (`chest_openers`).
    // rust: pub(super) fn tick_mod_container_viewers(&mut self) {
    // rust: let mut now: HashMap<(i32, i32, i32), u32> = HashMap::new();
    // rust: let mut open = |game: &Self, pos: (i32, i32, i32), n: u32| {
    // rust: if n > 0 && game.mod_menu_at(pos).is_some() {
    // rust: *now.entry(pos).or_default() += n;
}
}
    // rust: if let Some(host) = &self.lan {
    // rust: for g in host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && !g.spectator())
    // rust: {
    // rust: if let Some(m) = &g.menu
    // rust: && let Slots::Block(pos) = m.slots
    // rust: {
    // rust: open(self, pos, 1);
}
}
}
    // rust: if let Some(pos) = self.container.filter(|_| !self.spectator()) {
    // rust: open(self, pos, 1);
}
    // rust: for (&pos, &(golems, _)) in &self.world.chest_openers {
    // rust: open(self, pos, golems.max(0) as u32);
}
    // rust: let dim = self.dim.id();
    // rust: for (pos, previous, viewers) in viewer_changes(&mut self.mod_container_viewers, dim, now) {
    // rust: self.native_mod_container_viewers(dim, [pos.0, pos.1, pos.2], viewers, previous);
}
}
    /// The menu type of the mod container at `key`, if it has one.
    // rust: pub(super) fn mod_menu_at(&self, key: Pos) -> Option<&'static str> {
    // rust: let state = self.world.block(key.0, key.1, key.2).0;
    // rust: let c = self.world.block_entities.mod_container(state)?;
    // rust: mod_menu(c.menu.as_deref()?).map(|(menu, _)| menu)
}
    /// The container slots (of `size`) that the mod's screen for the block at
    /// `pos` does not show: the server's menu does not have them either, so a
    /// shift-click never moves an item where the player cannot see it.
    // rust: pub(super) fn native_hidden_slots(&self, pos: Pos, size: usize) -> Vec<usize> {
    // rust: if self.mod_menu_at(pos).is_none() {
    // rust: return Vec::new();
}
    // rust: let block = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos.0, pos.1, pos.2))
    // rust: .name
    // rust: .to_string();
    // rust: let mut screen = None;
    // rust: self.native_screen(&block, &mut screen);
    // rust: let Some(screen) = screen else {
    // rust: return Vec::new();
}
    // rust: (0..size)
    // rust: .filter(|&i| screen.slots.get(i).is_none_or(Option::is_none))
    // rust: .collect()
}
    /// A menu opened on this client with its slots under `key`, on block
    /// `target`: a mod block's is laid out by its mod (`native_screen`).
    /// `extra` is what the server sent for this window first.
    // rust: pub(super) fn open_native_screen(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: target: Option<Pos>,
    // rust: window: i32,
    // rust: menu: &str,
    // rust: extra: Option<horizon_protocol::menu_extra::Message>,
    // rust: ) {
    // rust: self.mod_screen = None;
    // rust: let Some(t) = target else {
    // rust: return;
}
    // rust: let block = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(t.0, t.1, t.2))
    // rust: .name
    // rust: .to_string();
    // rust: if block.starts_with("minecraft:") {
    // rust: return;
}
        // Only when this is the menu the clicked block opens: `target` outlives the
        // use that set it, so another menu opened later (a command's, another
        // mod's) would otherwise get the last clicked machine's screen. Asked
        // here, as the window's world has no mod containers.
    // rust: let mut container = None;
    // rust: self.native_block_entity_container(&block, &mut container);
    // rust: let opens = container.and_then(|c| mod_menu(c.menu.as_deref()?).map(|(m, _)| m));
    // rust: if opens != Some(menu) {
    // rust: return;
}
    // rust: let mut screen = None;
    // rust: self.native_screen(&block, &mut screen);
    // rust: if let Some(screen) = screen {
    // rust: self.mod_screen = Some(OpenNativeScreen {
    // rust: key,
    // rust: window,
    // rust: block,
    // rust: screen,
    // rust: data: Vec::new(),
    // rust: extra,
    // rust: });
}
}
    /// The mod screen showing now, if any.
pub fn shown_native_screen(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mod_screen
    // rust: .as_ref()
    // rust: .filter(|s| self.screen == Screen::Inventory && self.container == Some(s.key))
}
    /// A data slot of window `window`'s menu (`ContainerSetData`); false
    /// when no mod screen is showing for that window.
    // rust: pub(super) fn native_screen_data(&mut self, window: i32, id: i16, value: i16) -> bool {
    // rust: if self.shown_native_screen().is_none() {
    // rust: return false;
}
    // rust: self.mod_screen
    // rust: .as_mut()
    // rust: .is_some_and(|s| s.set_data(window, id, value))
}
    /// Whether a mod's screen is open for the current menu: it places its own
    /// container slots and the player's inventory, so the stock layout of the
    /// vanilla menu underneath stands back (`slot_position`).
    // rust: pub(super) fn native_screen_shown(&self) -> bool {
    // rust: self.shown_native_screen().is_some()
}
    /// The open mod screen's height.
    // rust: pub(super) fn native_screen_height(&self) -> Option<f32> {
    // rust: self.shown_native_screen().map(|s| s.screen.height)
}
    /// Where the open mod screen puts container slot `slot`.
    // rust: pub(super) fn native_screen_slot(&self, slot: usize) -> Option<(f32, f32)> {
    // rust: let s = self.shown_native_screen()?;
    // rust: s.screen
    // rust: .slots
    // rust: .get(slot)
    // rust: .copied()
    // rust: .flatten()
    // rust: .map(|p| (p[0], p[1]))
}
    /// The container slots the open mod screen shows (300.. ids).
    // rust: pub(super) fn native_screen_slots(&self) -> Option<Vec<usize>> {
    // rust: let s = self.shown_native_screen()?;
    // rust: let shown = s.screen.slots.iter().enumerate();
    // rust: Some(
    // rust: shown
    // rust: .filter(|(_, p)| p.is_some())
    // rust: .map(|(i, _)| 300 + i)
    // rust: .collect(),
    // rust: )
}
    /// How many of those slots `native_screen_slots` lists, without building
    /// it (`Game::slot_count` asks every frame).
    // rust: pub(super) fn native_screen_slot_count(&self) -> Option<usize> {
    // rust: let s = self.shown_native_screen()?;
    // rust: Some(s.screen.slots.iter().filter(|p| p.is_some()).count())
}
    /// The first row of the player's inventory on the open mod screen.
    // rust: pub(super) fn native_screen_inventory_y(&self) -> Option<f32> {
    // rust: self.shown_native_screen().map(|s| s.screen.inventory_y)
}
    /// The open mod screen's inventory's left column.
    // rust: pub(super) fn native_screen_inventory_x(&self) -> Option<f32> {
    // rust: self.shown_native_screen().map(|s| s.screen.inventory_x)
}
    /// The open mod screen's width.
    // rust: pub(super) fn native_screen_width(&self) -> Option<f32> {
    // rust: self.shown_native_screen().map(|s| s.screen.width)
}
    /// The open mod screen: a plain panel with its slots' frames, the mod's
    /// drawing over it, then the title and the inventory's label. False when
    /// none is showing.
    // rust: pub(super) fn draw_native_screen(&self, batch: &mut HudBatch, ox: f32, oy: f32) -> bool {
    // rust: let Some(s) = self.shown_native_screen() else {
    // rust: return false;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: if !s.screen.own_background {
    // rust: let (w, h) = (s.screen.width, s.screen.height);
    // rust: batch.fill(atlas, ox, oy, w, h, rgba(0, 0, 0, 255));
    // rust: batch.fill(
    // rust: atlas,
    // rust: ox + 1.0,
    // rust: oy + 1.0,
    // rust: w - 2.0,
    // rust: h - 2.0,
    // rust: rgba(198, 198, 198, 255),
    // rust: );
    // rust: let container = self.native_screen_slots().unwrap_or_default();
    // rust: for i in (0..36).chain(container) {
    // rust: let (x, y) = self.slot_position(i);
    // rust: let (x, y) = (ox + x - 1.0, oy + y - 1.0);
    // rust: batch.fill(atlas, x, y, 18.0, 18.0, rgba(55, 55, 55, 255));
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: 17.0,
    // rust: 17.0,
    // rust: rgba(255, 255, 255, 255),
    // rust: );
    // rust: batch.fill(
    // rust: atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: 16.0,
    // rust: 16.0,
    // rust: rgba(139, 139, 139, 255),
    // rust: );
}
}
    // rust: self.native_screen_draw(&s.block, &s.data, batch, [ox, oy]);
    // rust: if s.screen.own_labels {
    // rust: return true;
}
    // rust: let grey = rgba(64, 64, 64, 255);
    // rust: if let Some(title) = self.remote_menu_title() {
    // rust: batch.text_styled(atlas, &title, ox + 8.0, oy + 6.0, grey, false);
}
    // rust: let inventory = self.translate("container.inventory", "Inventory");
    // rust: let label_y = oy + s.screen.inventory_y - 11.0;
    // rust: batch.text(atlas, &inventory, ox + 8.0, label_y, grey, false);
    // rust: true
}
    /// The tick of the mod block entity at `pos`.
    // rust: pub(super) fn tick_mod_block_entity(&mut self, pos: Pos) {
    // rust: let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return;
}
        // An empty id marks its place while the mod has it.
    // rust: let mut taken = std::mem::take(&mut **m);
    // rust: let items = taken.items.clone();
    // rust: let state = self.world.block(pos.0, pos.1, pos.2).0;
    // rust: let slots = self
    // rust: .world
    // rust: .block_entities
    // rust: .mod_container(state)
    // rust: .map_or(0, |c| c.slots);
        // Grown only: items a container no longer has room for stay saved.
    // rust: if taken.items.len() < slots {
    // rust: taken.items.resize(slots, None);
}
        // Without a container, an `Items` item list is the mod's own field.
    // rust: if slots == 0 && !taken.items.is_empty() {
    // rust: let items = horizon_client::save::encode_items(&std::mem::take(&mut taken.items));
    // rust: taken.nbt.insert("Items".into(), items);
}
    // rust: self.native_block_entity_tick([pos.0, pos.1, pos.2], &mut taken);
    // rust: self.put_back_mod_block_entity(pos, taken, &items);
}
    /// Puts back a mod block entity taken out for a call, unless the call
    /// removed or replaced it, with what its `setChanged` does.
    // rust: pub(super) fn put_back_mod_block_entity(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: mut taken: ModBlockEntity,
    // rust: items: &[Option<ItemStack>],
    // rust: ) {
    // rust: if let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&pos)
    // rust: && m.id.is_empty()
    // rust: {
    // rust: let moved = taken.items != items;
    // rust: **m = taken;
            // BlockEntity.setChanged: the next save writes its chunk, and
            // comparators read a container whose items changed.
    // rust: self.world.modified.insert((pos.0 >> 4, pos.2 >> 4));
    // rust: if moved {
    // rust: self.container_changed(pos);
}
    // rust: } else if taken.items.iter().any(Option::is_some) {
            // The mod removed or replaced its own block during the call. Vanilla
            // ticks it in the world and drops a container's contents on removal.
    // rust: let lost = std::mem::take(&mut taken.items);
    // rust: let at = BlockPos {
    // rust: x: pos.0,
    // rust: y: pos.1,
    // rust: z: pos.2,
}
    // rust: self.with_level(|_, level, _| level.drop_lost_contents(at, lost));
    // rust: self.world.modified.insert((pos.0 >> 4, pos.2 >> 4));
}
}
    /// Menu button `id` on the mod container at `pos` (`clickMenuButton`),
    /// with the acting player's cursor stack (`carried`, read and written).
    // rust: pub(super) fn mod_menu_button(&mut self, pos: Pos, id: i32, carried: &mut Option<ItemStack>) {
    // rust: if self.mod_menu_at(pos).is_none() {
    // rust: return;
}
    // rust: let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return;
}
    // rust: if m.id.is_empty() {
    // rust: return;
}
    // rust: let mut taken = std::mem::take(&mut **m);
    // rust: let items = taken.items.clone();
    // rust: self.native_menu_button([pos.0, pos.1, pos.2], &mut taken, id);
    // rust: self.native_menu_button_v2([pos.0, pos.1, pos.2], &mut taken, id, carried);
    // rust: self.put_back_mod_block_entity(pos, taken, &items);
}
    /// The cursor from the open mod screen's top left, with its block and
    /// data, for its press and tooltip hooks.
pub fn native_screen_at(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = self.shown_native_screen()?;
    // rust: let r = self.renderer.as_ref()?;
    // rust: let batch = HudBatch::new([r.config.width, r.config.height]);
    // rust: let (ox, oy) = self.inventory_origin(&batch);
    // rust: let at = [self.cursor.0 - ox, self.cursor.1 - oy];
    // rust: Some((s.block.clone(), s.data.clone(), at))
}
    /// A press on the open mod screen's own button (`native_screen_click`)
    /// goes to the server as a menu button click (true).
    // rust: pub(super) fn native_screen_press(&mut self, right: bool) -> bool {
    // rust: if self.inventory_target().0.is_some() {
    // rust: return false;
}
    // rust: let Some((block, data, at)) = self.native_screen_at() else {
    // rust: return false;
}
    // rust: let mut button = None;
    // rust: self.native_screen_click(&block, &data, at, right, &mut button);
    // rust: let Some(button) = button else {
    // rust: return false;
}
    // rust: let window = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.menu.as_ref())
    // rust: .map(|(w, _)| *w);
    // rust: if let Some(container) = window {
    // rust: self.send(
    // rust: horizon_protocol::packets::play::Serverbound::ContainerButtonClick(
    // rust: horizon_protocol::packets::play::ContainerButtonClick { container, button },
    // rust: ),
    // rust: );
}
    // rust: self.audio.play_button_click();
    // rust: true
}
    /// The open mod screen's tooltip under the cursor (`native_screen_tooltip`).
    // rust: pub(super) fn draw_native_screen_tooltip(&mut self, batch: &mut HudBatch) {
        // Over no item: an empty slot still gets the mod's hint (which fuel it takes).
    // rust: let slot = self.slot_at(batch, self.cursor.0, self.cursor.1);
    // rust: if self.carried.is_some() || slot.is_some_and(|i| self.slot_view(i).is_some()) {
    // rust: return;
}
    // rust: let Some((block, data, at)) = self.native_screen_at() else {
    // rust: return;
}
    // rust: let mut lines = Vec::new();
    // rust: self.native_screen_tooltip(&block, &data, at, &mut lines);
    // rust: let lines: Vec<(horizon_client::text::Text, u32)> = lines
    // rust: .into_iter()
    // rust: .map(|l| (horizon_client::text::Text::literal(l), u32::MAX))
    // rust: .collect();
    // rust: self.draw_tooltip_lines(batch, &lines, self.cursor.0, self.cursor.1);
}
    /// Options > Mods' rows for the native mods, after the others.
    // rust: pub(super) fn list_native_mods(&mut self) {
    // rust: let mut mods = Vec::new();
    // rust: self.native_mods(&mut mods);
        // A WebAssembly mod of the same id: the native row stands for it,
        // and alone toggles its `mod.<id>` line.
    // rust: self.settings
    // rust: .mods
    // rust: .installed
    // rust: .retain(|row| row.native.is_none() && !mods.iter().any(|m| m.id == row.id));
    // rust: for m in mods {
    // rust: let mut buttons = Vec::new();
    // rust: self.native_settings(&m.id, &mut buttons);
    // rust: let page = NativePage {
    // rust: keys: m.keys,
    // rust: buttons,
}
    // rust: self.settings.mods.installed.push(Installed {
    // rust: id: m.id,
    // rust: title: m.title,
    // rust: description: m.description,
    // rust: problem: None,
    // rust: dev: false,
    // rust: native: Some(page),
    // rust: });
}
}
    /// A click on button `button` of native mod `i`'s page (its index in
    /// Options > Mods), and the page's labels after it.
    // rust: pub(super) fn native_settings_event(&mut self, i: usize, button: usize) {
    // rust: let Some(id) = self.settings.mods.installed.get(i).map(|m| m.id.clone()) else {
    // rust: return;
}
    // rust: self.native_settings_click(&id, button);
    // rust: self.native_settings_refresh(i);
}
    /// Native mod `i`'s page opened: its labels asked again, so that they
    /// follow the language (and the mod's state) since the list was made.
    // rust: pub(super) fn native_settings_refresh(&mut self, i: usize) {
    // rust: let Some(id) = self.settings.mods.installed.get(i).map(|m| m.id.clone()) else {
    // rust: return;
}
    // rust: let mut buttons = Vec::new();
    // rust: self.native_settings(&id, &mut buttons);
    // rust: let row = self.settings.mods.installed.get_mut(i);
    // rust: if let Some(page) = row.and_then(|m| m.native.as_mut()) {
    // rust: page.buttons = buttons;
}
}
    /// A key event for `native_key`.
    // rust: pub(super) fn native_key_event(&mut self, key: KeyCode, pressed: bool, repeat: bool) {
    // rust: if repeat {
    // rust: return;
}
    // rust: if let Some(name) = keybinds::key_name(key) {
    // rust: if pressed {
    // rust: self.native_panel_key(name);
}
    // rust: self.native_key(name, pressed);
}
}
    /// `ClientHooks.onClickInput`: tells `native_interaction_key` that `button`
    /// (0 attack, 1 use, 2 pick) is about to act with `hand`. `None` when the
    /// action goes on; when a mod cancelled it, `Some` of whether the hand swings.
    // rust: pub(super) fn native_interaction(
    // rust: &mut self,
    // rust: button: i32,
    // rust: hand: horizon_client::first_person::Hand,
    // rust: ) -> Option<bool> {
    // rust: let key_mapping = match button {
    // rust: 0 => "key.attack",
    // rust: 1 => "key.use",
    // rust: _ => "key.pickItem",
}
    // rust: let (mut swing_hand, mut canceled) = (true, false);
    // rust: self.native_interaction_key(button, key_mapping, hand, &mut swing_hand, &mut canceled);
    // rust: canceled.then_some(swing_hand)
}
    /// A mouse button while playing, for `native_key`.
    // rust: pub(super) fn native_mouse_event(&mut self, button: MouseButton, pressed: bool) {
    // rust: let name = keybinds::mouse_name(button);
    // rust: self.native_key(&name, pressed);
}
    /// Wheel steps while playing: whether a native mod took them.
    // rust: pub(super) fn native_wheel_event(&mut self, steps: f32) -> bool {
    // rust: let mut claimed = false;
    // rust: self.native_wheel(steps, &mut claimed);
    // rust: claimed
}
    /// A native mod's command.
    // rust: pub(super) fn client_mod_command(&mut self, command: &str) -> bool {
    // rust: let mut ran = false;
    // rust: self.native_command(command, &mut ran);
    // rust: ran
}
    /// The zoom in effect while playing (a native mod's); the spyglass's own
    /// view wins.
    // rust: pub(super) fn native_zoom_now(&self) -> Option<NativeZoom> {
    // rust: if !self.native_playing() || self.scoping() {
    // rust: return None;
}
    // rust: let mut zoom = None;
    // rust: self.native_zoom(&mut zoom);
        // As the WebAssembly runtime clamped a mod's zoom.
    // rust: let z = zoom?;
    // rust: let factor = finite(z.factor, 1.0, 10.0);
    // rust: (factor > 1.0).then_some(NativeZoom {
    // rust: factor,
    // rust: smooth: z.smooth,
    // rust: turn: if z.turn.is_finite() {
    // rust: z.turn.clamp(0.05, 1.0)
    // rust: } else {
    // rust: 1.0
    // rust: },
    // rust: })
}
    /// The pose of native mods' camera shake in this frame (`native_camera_shake`),
    /// none while not playing.
    // rust: pub(super) fn native_shake_matrix(&self, partial: f32) -> glam::Mat4 {
    // rust: if !self.native_playing() {
    // rust: return glam::Mat4::IDENTITY;
}
    // rust: let mut shake = NativeShake::default();
    // rust: self.native_camera_shake(partial, &mut shake);
    // rust: if shake == NativeShake::default() {
    // rust: return glam::Mat4::IDENTITY;
}
    // rust: shake_pose(bounded_shake(shake, self.screen_effect_scale()))
}

    /// The camera native mods draw this frame from (`native_camera_pose`), starting from
    /// `view`, vanilla's position, yaw and pitch.
    // rust: pub(super) fn native_camera_pose_now(
    // rust: &self,
    // rust: partial: f32,
    // rust: view: (glam::DVec3, f32, f32),
    // rust: ) -> (glam::DVec3, f32, f32) {
    // rust: let (mut position, mut yaw, mut pitch) = (view.0.to_array(), view.1, view.2);
    // rust: self.native_camera_pose(partial, &mut position, &mut yaw, &mut pitch);
    // rust: posed_camera(view, position, yaw, pitch)
}

    /// What native mods hand shader packs in this frame (`native_shader_params`),
    /// with values that aren't finite as 0.
    // rust: pub(super) fn native_shader_params_now(&self, partial: f32) -> [[f32; 4]; 8] {
    // rust: let mut params = [[0.0; 4]; 8];
    // rust: self.native_shader_params(partial, &mut params);
    // rust: finite_params(params)
}
    /// The minimap a native mod shows.
    // rust: pub(super) fn native_minimap_now(&self) -> Option<NativeMinimap> {
    // rust: let mut minimap = None;
    // rust: self.native_minimap(&mut minimap);
    // rust: minimap.map(|m| NativeMinimap {
    // rust: size: finite(m.size, 16.0, 256.0),
    // rust: blocks_per_pixel: finite(m.blocks_per_pixel, 0.5, 4.0),
    // rust: ..m
    // rust: })
}
}

/// Whether `rgba` is a whole `width` x `height` image that fits a
/// `slot_width` x `slot_height` atlas slot (a native mod's `mod_image`).
pub fn mod_image_fits(width: u32, height: u32, rgba: usize, slot_width: u32, slot_height: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: width > 0
    // rust: && height > 0
    // rust: && width <= slot_width
    // rust: && height <= slot_height
    // rust: && rgba == width as usize * height as usize * 4
}

/// Whether F3's debug screen, open when `debug`, covers `corner`
/// (`DebugScreenOverlay.extractRenderState`): its left and right columns
/// the top corners, and its charts the bottom corners `charts` (bottom left,
/// bottom right) says they are drawn in.
pub fn debug_takes(corner: Corner, debug: bool, charts: [bool; 2]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: debug
    // rust: && match corner {
    // rust: Corner::TopLeft | Corner::TopRight => true,
    // rust: Corner::BottomLeft => charts[0],
    // rust: Corner::BottomRight => charts[1],
}
}

/// A menu of `MOD_MENUS` or a content mod's menu type, by its name.
pub fn mod_menu(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOD_MENUS
    // rust: .into_iter()
    // rust: .find(|(menu, _)| *menu == name)
    // rust: .or_else(|| horizon_client::containers::mod_menu_type(name).map(|m| (m.id, m.slots)))
}

/// `state` with its property `key` set to `value`; none when the block has
/// no such property or value.
    // rust: fn with_property(
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId> {
    // rust: let mut s = registry.state(state)?.clone();
    // rust: match s.properties.get(key) {
    // rust: Some(v) if v == value => return Some(state),
    // rust: Some(_) => {}
    // rust: None => return None,
}
    // rust: s.properties.insert(key.into(), value.into());
    // rust: registry.resolve(&s).ok()
}

/// The state a mod's property write changes `state` to; none when the block
/// has no such property or value, or already has it: `LevelChunk.setBlockState`
/// returns null for the same state, so `Level.setBlock` returns false.
    // rust: fn property_change(
    // rust: registry: &BlockRegistry,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId> {
    // rust: with_property(registry, state, key, value).filter(|&id| id != state)
}

/// `config/` beside `options`, made when missing.
/// `config/` in the game folder, shared by its players.
pub fn config_dir(game_dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = game_dir.join("config");
    // rust: fs::create_dir_all(&dir).map_err(|e| dir.display().to_string() + ": " + &e.to_string())?;
    // rust: Ok(dir)
}

/// `params` with each value that isn't finite as 0, so a mod's mistake can't
/// put a NaN in every pixel of a pack's picture.
pub fn finite_params(params: [[f32; 4]; 8]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: params.map(|v| v.map(|x| if x.is_finite() { x } else { 0.0 }))
}

/// Whether `native_play_local_sound` takes these values: a sound event's id
/// (`sound_id`, as `native_play_sound` takes), a finite position, a volume
/// and pitch at or above 0, and a delay of a minute at most.
pub fn local_sound_ok(sound: []const u8, at: [f64; 3], volume: f32, pitch: f32, delay: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sound_id(sound)
    // rust: && at.iter().all(|v| v.is_finite() && v.abs() <= 30_000_000.0)
    // rust: && volume.is_finite()
    // rust: && volume >= 0.0
    // rust: && pitch.is_finite()
    // rust: && pitch >= 0.0
    // rust: && (0..=1200).contains(&delay)
}

/// `v` within `lo..=hi`; `lo` when it is not a number.
pub fn finite(v: f32, lo: f32, hi: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v.is_finite() { v.clamp(lo, hi) } else { lo }
}

/// An item entity as `native_item_entities` lists it. API 42.
/// Read by mods only.
pub const NativeItemEntity = struct {
    /// The entity's ID, for `native_set_item_entity`.
    id: u32,
    position: [f64,
    stack: ItemStack,
    /// Ticks before a player may pick it up (`ItemEntity.pickupDelay`);
    /// hoppers take it whatever this is.
    pickup_delay: u32,
};

/// `AABB.intersects`: the boxes overlap, touching faces excluded.
pub fn box_meets(b: *horizon_core::geometry::Aabb, min: [f64; 3], max: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: lo.x < max[0]
    // rust: && hi.x > min[0]
    // rust: && lo.y < max[1]
    // rust: && hi.y > min[1]
    // rust: && lo.z < max[2]
    // rust: && hi.z > min[2]
}

/// What `native_mod_screen_open(mod_id)` does over `screen` (`blocked`: an
/// overlay, the title screen, no window or no player; `owner`'s own screen
/// open): `None` opens it, `Some` answers without changing anything (true:
/// `mod_id`'s is already open).
    // rust: fn mod_screen_opens(
    // rust: screen: Screen,
    // rust: blocked: bool,
    // rust: owner: Option<&str>,
    // rust: mod_id: &str,
    // rust: ) -> Option<bool> {
    // rust: if screen == Screen::Mod {
    // rust: return Some(owner == Some(mod_id));
}
    // rust: if screen != Screen::Playing || blocked {
    // rust: return Some(false);
}
    // rust: None
}

    // rust: mod tests {
pub fn hand_pose_rejects_invalid_components() void {
}
    // rust: let identity = super::hand_pose_matrix([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]);
    // rust: assert_eq!(identity, glam::Mat4::IDENTITY);
    // rust: assert_eq!(
    // rust: super::hand_pose_matrix([
    // rust: f32::NAN,
    // rust: 17.0,
    // rust: f32::INFINITY,
    // rust: 3601.0,
    // rust: -3601.0,
    // rust: f32::NAN,
    // rust: 0.0
    // rust: ]),
    // rust: identity
    // rust: );
    // rust: let point = super::hand_pose_matrix([1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 2.0])
    // rust: .transform_point3(glam::Vec3::X);
    // rust: assert_eq!(point, glam::Vec3::new(3.0, 2.0, 3.0));
}
pub fn observed_overlay_prefers_first_open_screen() void {
}
    // rust: assert_eq!(
    // rust: super::observed_overlay_id(&[(false, "sign"), (false, "book")]),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: super::observed_overlay_id(&[(false, "sign"), (true, "book")]),
    // rust: Some("book")
    // rust: );
    // rust: assert_eq!(
    // rust: super::observed_overlay_id(&[(true, "sign"), (true, "book")]),
    // rust: Some("sign")
    // rust: );
}

    /// Exercise the gameplay constructor, where name-based entities compete
    /// with a mod block's sign template.
pub fn mod_sign_constructor_prioritizes_templates_over_suffixes() void {
}
//         use super::super::{Audio, Game, Options, Progress, Settings, load_resources};
//         use horizon_client::mod_content::{ContentMod, build};
//         use horizon_mods::content::{Block, Content};

    // rust: let base = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .expect("set HORIZON_TEST_RESOURCES to prepared resources"),
    // rust: );
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-sign-constructor-{}-{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos()
    // rust: ));
    // rust: let cases = [
    // rust: ("ruby:notice_banner", "minecraft:oak_sign", false),
    // rust: ("ruby:board_shelf", "minecraft:oak_wall_sign", false),
    // rust: ("ruby:lantern_head", "minecraft:oak_hanging_sign", true),
    // rust: (
    // rust: "ruby:bracket_skull",
    // rust: "minecraft:oak_wall_hanging_sign",
    // rust: true,
    // rust: ),
    // rust: ];
    // rust: let mut content = Content::declared("ruby");
    // rust: let blocks: Vec<_> = cases
    // rust: .iter()
    // rust: .map(|&(id, template, _)| (id, template))
    // rust: .chain([("ruby:road_sign", "minecraft:stone")])
    // rust: .map(|(id, template)| Block {
    // rust: id: id.into(),
    // rust: template: template.into(),
    // rust: item: false,
    // rust: ..Default::default()
    // rust: })
    // rust: .collect();
    // rust: content.declare(&blocks, &[]).unwrap();
    // rust: build(
    // rust: &base,
    // rust: &[ContentMod {
    // rust: id: "ruby".into(),
    // rust: content,
    // rust: }],
    // rust: &root,
    // rust: )
    // rust: .unwrap();
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
    // rust: options.execution_role = super::ExecutionRole::IntegratedServer;
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

    // rust: for (name, hanging) in cases
    // rust: .map(|(name, _, hanging)| (name, hanging))
    // rust: .into_iter()
    // rust: .chain([
    // rust: ("minecraft:oak_sign", false),
    // rust: ("minecraft:oak_hanging_sign", true),
    // rust: ])
    // rust: {
    // rust: match game.new_block_entity(name) {
    // rust: Some(super::BlockEntity::Sign(sign)) => {
    // rust: assert_eq!(sign.hanging, hanging, "{name}")
}
    // rust: entity => panic!("{name}: expected a sign, got {entity:?}"),
}
}
    // rust: assert!(game.new_block_entity("ruby:road_sign").is_none());
    // rust: assert!(matches!(
    // rust: game.new_block_entity("minecraft:white_banner"),
    // rust: Some(super::BlockEntity::Banner(_))
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    /// A mod's own screen opens only over the world, never over another
    /// screen, an overlay (the title screen, a book, loading, no window) or
    /// another mod's; opening it again is a no-op.
pub fn a_mod_screen_opens_only_over_the_world() void {
}
//         use super::{Screen, mod_screen_opens};
    // rust: assert_eq!(mod_screen_opens(Screen::Playing, false, None, "a"), None);
    // rust: assert_eq!(
    // rust: mod_screen_opens(Screen::Playing, true, None, "a"),
    // rust: Some(false)
    // rust: );
    // rust: for other in [
    // rust: Screen::Paused,
    // rust: Screen::Inventory,
    // rust: Screen::Chat,
    // rust: Screen::Options,
    // rust: ] {
    // rust: assert_eq!(mod_screen_opens(other, false, None, "a"), Some(false));
}
    // rust: assert_eq!(
    // rust: mod_screen_opens(Screen::Mod, false, Some("a"), "a"),
    // rust: Some(true)
    // rust: );
    // rust: assert_eq!(
    // rust: mod_screen_opens(Screen::Mod, false, Some("b"), "a"),
    // rust: Some(false)
    // rust: );
}

    /// The characters a `ScreenEvent.CharacterTyped.Pre` sees are the
    /// printable ones of a text: a cancelled one leaves that text and a
    /// control character (a key, not text) is never offered a hook.
pub fn typed_text_keeps_control_characters_and_drops_cancelled_ones() void {
}
    // rust: let mut offered = Vec::new();
    // rust: let left = super::screen_text_hooked("a\u{7f}b\u{1b}c", |c| {
    // rust: offered.push(c);
    // rust: c == 'b'
    // rust: });
    // rust: assert_eq!(offered, ['a', 'b', 'c']);
    // rust: assert_eq!(left.as_deref(), Some("a\u{7f}\u{1b}c"));
        // Every printable character cancelled: no text is left to type.
    // rust: assert_eq!(super::screen_text_hooked("ab", |_| true), None);
        // Nothing to offer: an empty text stays empty and keys alone stay whole.
    // rust: assert_eq!(super::screen_text_hooked("", |_| true).as_deref(), Some(""));
    // rust: assert_eq!(
    // rust: super::screen_text_hooked("\u{7f}\t", |_| true).as_deref(),
    // rust: Some("\u{7f}\t")
    // rust: );
        // What no hook cancels is handed back as it came in.
    // rust: assert_eq!(
    // rust: super::screen_text_hooked("hello", |_| false).as_deref(),
    // rust: Some("hello")
    // rust: );
}

    /// The window's key path: a key whose press a mod cancelled still types
    /// the characters no mod cancelled (vanilla's separate `charTyped`), while
    /// the key characters never reach the text box.
pub fn a_cancelled_key_still_types_the_characters_left() void {
}
        // `axb` with 'x' cancelled: the key went no further, `ab` still types.
    // rust: assert_eq!(
    // rust: super::chars_to_type("axb", |c| c == 'x').as_deref(),
    // rust: Some("ab")
    // rust: );
        // Backspace, Escape and the like are keys, not text.
    // rust: assert_eq!(
    // rust: super::chars_to_type("a\u{7f}\u{1b}b", |_| false).as_deref(),
    // rust: Some("ab")
    // rust: );
        // Every character cancelled: the box takes none of them.
    // rust: assert_eq!(super::chars_to_type("ab", |_| true), None);
        // Nothing typed: nothing to hand over.
    // rust: assert_eq!(super::chars_to_type("", |_| false), None);
}

    /// A mod's camera replaces vanilla's value by value; one that isn't finite keeps vanilla's.
pub fn a_mod_camera_replaces_each_finite_value() void {
}
//         use super::posed_camera;
    // rust: let vanilla = (glam::DVec3::new(1.0, 2.0, 3.0), 10.0, 20.0);
    // rust: assert_eq!(
    // rust: posed_camera(vanilla, [-40.5, 90.0, 1e7], 270.0, -35.0),
    // rust: (glam::DVec3::new(-40.5, 90.0, 1e7), 270.0, -35.0)
    // rust: );
    // rust: assert_eq!(
    // rust: posed_camera(
    // rust: vanilla,
    // rust: [f64::NAN, 5.0, f64::INFINITY],
    // rust: f32::NAN,
    // rust: f32::NEG_INFINITY
    // rust: ),
    // rust: (glam::DVec3::new(1.0, 5.0, 3.0), 10.0, 20.0)
    // rust: );
}

    /// A shake is scaled by Distortion Effects, bounded on each axis, and a
    /// value that isn't finite is none.
pub fn a_shake_is_scaled_and_bounded() void {
}
//         use super::{NativeShake, bounded_shake, shake_pose};
    // rust: let shake = NativeShake {
    // rust: pitch: 4.0,
    // rust: yaw: -30.0,
    // rust: roll: f32::NAN,
    // rust: offset: [0.2, 2.0, f32::INFINITY],
}
    // rust: assert_eq!(
    // rust: bounded_shake(shake, 1.0),
    // rust: NativeShake {
    // rust: pitch: 4.0,
    // rust: yaw: -10.0,
    // rust: roll: 0.0,
    // rust: offset: [0.2, 0.5, 0.0],
}
    // rust: );
    // rust: assert_eq!(bounded_shake(shake, 0.5).pitch, 2.0);
    // rust: assert_eq!(bounded_shake(shake, 0.0), NativeShake::default());
    // rust: assert_eq!(shake_pose(NativeShake::default()), glam::Mat4::IDENTITY);
}

    /// A mod's shader values that aren't finite read as 0.
pub fn shader_params_that_arent_finite_read_as_zero() void {
}
    // rust: let mut params = [[1.0; 4]; 8];
    // rust: params[0] = [f32::NAN, 2.0, f32::INFINITY, -3.0];
    // rust: let out = super::finite_params(params);
    // rust: assert_eq!(out[0], [0.0, 2.0, 0.0, -3.0]);
    // rust: assert_eq!(out[7], [1.0; 4]);
}

    /// A client mod's sound needs a namespaced event, finite values and a
    /// delay of a minute at most.
pub fn a_local_sound_is_checked() void {
}
//         use super::local_sound_ok;
    // rust: let at = [0.5, 64.0, 0.5];
    // rust: assert!(local_sound_ok("ironfall:boom_far", at, 8.0, 1.0, 140));
    // rust: assert!(local_sound_ok(
    // rust: "minecraft:entity.generic.explode",
    // rust: at,
    // rust: 1.0,
    // rust: 1.0,
    // rust: 0
    // rust: ));
    // rust: assert!(!local_sound_ok("boom", at, 1.0, 1.0, 0));
    // rust: assert!(!local_sound_ok("ironfall:", at, 1.0, 1.0, 0));
    // rust: assert!(!local_sound_ok("Ironfall:Boom", at, 1.0, 1.0, 0));
    // rust: assert!(!local_sound_ok(
    // rust: "ironfall:boom",
    // rust: [f64::NAN, 0.0, 0.0],
    // rust: 1.0,
    // rust: 1.0,
    // rust: 0
    // rust: ));
    // rust: assert!(!local_sound_ok("ironfall:boom", at, -1.0, 1.0, 0));
    // rust: assert!(!local_sound_ok("ironfall:boom", at, 1.0, 1.0, 1201));
    // rust: assert!(!local_sound_ok("ironfall:boom", at, 1.0, 1.0, -1));
}

    /// `native_play_sound` takes vanilla's and mods' sound ids, nothing else.
pub fn sound_ids_are_identifiers() void {
}
    // rust: for id in [
    // rust: "minecraft:block.note_block.harp",
    // rust: "mymod:machine/hum",
    // rust: "my_mod.x-1:a",
    // rust: ] {
    // rust: assert!(super::sound_id(id), "{id}");
}
    // rust: for id in [
    // rust: "",
    // rust: "hum",
    // rust: ":hum",
    // rust: "mymod:",
    // rust: "MyMod:hum",
    // rust: "mymod:Hum",
    // rust: "my/mod:hum",
    // rust: "a:b c",
    // rust: ] {
    // rust: assert!(!super::sound_id(id), "{id}");
}
}

    /// A mod's property write: none for a key or value the block lacks, the
    /// state itself when it already has the value, else the new state.
pub fn with_property_finds_the_state() void {
}
    // rust: let facts = br#"{"defaults":{"minecraft:air":0,"test:crop":1},"states":[
    // rust: ["air",true,false,"","minecraft:air"],
    // rust: ["crop0",false,false,"",{"id":"test:crop","properties":{"age":"0"}}],
    // rust: ["crop1",false,false,"",{"id":"test:crop","properties":{"age":"1"}}]
    // rust: ]}"#;
    // rust: let registry = horizon_world::registry::BlockRegistry::from_facts_json(&facts[..]).unwrap();
//         use horizon_world::registry::BlockStateId;
    // rust: let (age0, age1) = (BlockStateId(1), BlockStateId(2));
    // rust: assert_eq!(
    // rust: super::with_property(&registry, age0, "age", "0"),
    // rust: Some(age0)
    // rust: );
    // rust: assert_eq!(
    // rust: super::with_property(&registry, age0, "age", "1"),
    // rust: Some(age1)
    // rust: );
    // rust: assert_eq!(super::with_property(&registry, age0, "age", "9"), None);
    // rust: assert_eq!(super::with_property(&registry, age0, "lit", "true"), None);
        // What both property setters write: nothing (false) when the
        // property already has the value, as `Level.setBlock`.
    // rust: assert_eq!(super::property_change(&registry, age0, "age", "0"), None);
    // rust: assert_eq!(
    // rust: super::property_change(&registry, age0, "age", "1"),
    // rust: Some(age1)
    // rust: );
    // rust: assert_eq!(super::property_change(&registry, age0, "age", "9"), None);
    // rust: assert_eq!(super::property_change(&registry, age0, "lit", "true"), None);
}

    /// The state a mod block is placed in is built from its own default state
    /// and one of its properties, its declared ones (`state_properties` in its
    /// block file) included, and keeps the properties it already had.
pub fn a_placement_state_is_built_from_a_blocks_own_properties() void {
}
    // rust: let facts = br#"{"defaults":{"minecraft:air":0,"test:pipe":1},"states":[
    // rust: ["air",true,false,"","minecraft:air"],
    // rust: ["north_gas",false,false,"",{"id":"test:pipe","properties":{"carries":"gas","facing":"north"}}],
    // rust: ["east_gas",false,false,"",{"id":"test:pipe","properties":{"carries":"gas","facing":"east"}}],
    // rust: ["north_items",false,false,"",{"id":"test:pipe","properties":{"carries":"items","facing":"north"}}],
    // rust: ["east_items",false,false,"",{"id":"test:pipe","properties":{"carries":"items","facing":"east"}}]
    // rust: ]}"#;
    // rust: let registry = horizon_world::registry::BlockRegistry::from_facts_json(&facts[..]).unwrap();
//         use horizon_world::registry::BlockStateId;
    // rust: let (north_gas, east_gas, east_items) = (BlockStateId(1), BlockStateId(2), BlockStateId(4));
        // The declared property changes, and `carries` stays as it was.
    // rust: assert_eq!(
    // rust: super::with_property(&registry, north_gas, "facing", "east"),
    // rust: Some(east_gas)
    // rust: );
    // rust: assert_eq!(
    // rust: super::with_property(&registry, east_gas, "carries", "items"),
    // rust: Some(east_items)
    // rust: );
        // A value the property does not have builds nothing.
    // rust: assert_eq!(
    // rust: super::with_property(&registry, east_gas, "facing", "up"),
    // rust: None
    // rust: );
}
    /// Both property setters return false for a write that changes nothing:
    /// each goes through `property_change`, none returns true on its own.
pub fn property_setters_refuse_no_change() void {
}
        // A Windows checkout has CRLF line ends: the searches below look for "\n".
    // rust: let source = include_str!("native_hooks.rs").replace("\r\n", "\n");
    // rust: let code = source.split("#[cfg(test)]").next().unwrap_or_default();
    // rust: for head in [
    // rust: "    pub(super) fn native_set_block_property(\n        &mut self,\n        ticks:",
    // rust: "    pub(super) fn native_set_block_property_with(",
    // rust: ] {
    // rust: let body = code.split(head).nth(1).expect(head);
    // rust: let body = &body[..body.find("\n    }\n").expect(head)];
    // rust: assert!(body.contains("property_change("), "{head}");
    // rust: assert!(!body.contains("return true"), "{head}");
}
}
    /// horizon-mixins refuses targets whose body has a `cfg` or a macro:
    /// the hook points and helpers must stay free of both. The launcher
    /// reads the API line as it is.
    /// A data packet for an old window leaves the open mod screen alone.
pub fn mod_screen_data_is_its_windows_only() void {
}
    // rust: let mut s = super::OpenNativeScreen {
    // rust: key: (0, 0, 0),
    // rust: window: 4,
    // rust: block: "gtmod:machine".into(),
    // rust: screen: super::NativeScreen::default(),
    // rust: data: Vec::new(),
    // rust: extra: None,
}
    // rust: assert!(s.set_data(4, 1, 7));
    // rust: assert!(!s.set_data(3, 1, 99));
    // rust: assert_eq!(s.data, [0, 7]);
}

pub fn hook_points_stay_hookable() void {
}
    // rust: let source = include_str!("native_hooks.rs");
    // rust: let code = source.split("#[cfg(test)]").next().unwrap_or_default();
    // rust: assert!(code.contains("\npub(crate) const NATIVE_HOOKS_API: u32 = "));
    // rust: let lines = code.lines().filter(|l| !l.trim_start().starts_with("//"));
    // rust: for line in lines {
    // rust: assert!(!line.contains("cfg"), "a cfg in the hook points: {line}");
    // rust: for mac in ["!(", "![", "! {", "!{"] {
    // rust: assert!(!line.contains(mac), "a macro in the hook points: {line}");
}
}
}

pub fn native_breathing_stays_hookable() void {
}
    // rust: let source = include_str!("../breathing.rs").replace("\r\n", "\n");
    // rust: let hook = source.find("pub fn native_living_breathe(").unwrap();
        // From its doc comment's first line, so an attribute above it counts.
    // rust: let start = source[..hook].find("/// An entity's breathing").unwrap();
    // rust: let body = &source[start..hook + source[hook..].find("\n}\n").unwrap()];
    // rust: assert!(body.contains("#[inline(never)]"));
    // rust: for line in body.lines() {
    // rust: assert!(!line.contains("cfg"), "a cfg in the breathing hook: {line}");
    // rust: for mac in ["!(", "![", "! {", "!{"] {
    // rust: assert!(!line.contains(mac), "a macro in the breathing hook: {line}");
}
}
}

pub fn native_loot_kinds_stay_hookable() void {
}
    // rust: let source = include_str!("../../../horizon-world/src/loot.rs").replace("\r\n", "\n");
    // rust: for hook in [
    // rust: "pub fn native_loot_function(",
    // rust: "pub fn native_loot_condition(",
    // rust: ] {
    // rust: let at = source
    // rust: .find(hook)
    // rust: .unwrap_or_else(|| panic!("{hook} not found"));
    // rust: let start = source[..at].rfind("///").unwrap();
    // rust: let body = &source[start..start + source[start..].find("\n}\n").unwrap()];
    // rust: for line in body.lines() {
    // rust: assert!(!line.contains("cfg"), "a cfg in a loot hook point: {line}");
    // rust: for mac in ["!(", "![", "! {", "!{"] {
    // rust: assert!(!line.contains(mac), "a macro in a loot hook point: {line}");
}
}
}
}

pub fn native_ingredient_stays_hookable() void {
}
    // rust: let source = include_str!("../crafting.rs").replace("\r\n", "\n");
    // rust: let at = source.find("pub fn native_ingredient(").unwrap();
    // rust: let start = source[..at].rfind("///").unwrap();
    // rust: let body = &source[start..start + source[start..].find("\n}\n").unwrap()];
    // rust: for line in body.lines() {
    // rust: assert!(
    // rust: !line.contains("cfg"),
    // rust: "a cfg in the ingredient hook: {line}"
    // rust: );
    // rust: for mac in ["!(", "![", "! {", "!{"] {
    // rust: assert!(!line.contains(mac), "a macro: {line}");
}
}
}

pub fn loot_table_load_stays_hookable() void {
}
    // rust: let source = include_str!("../../../horizon-world/src/loot.rs").replace("\r\n", "\n");
        // From its doc comment's last line, so an attribute above it counts.
    // rust: let hook = source.find("pub fn native_loot_table_load(").unwrap();
    // rust: let start = source[..hook].rfind("///").unwrap();
    // rust: let end = source[start..]
    // rust: .find("\n}\n")
    // rust: .or_else(|| source[start..].find("\r\n}\r\n"))
    // rust: .unwrap();
    // rust: let body = &source[start..start + end];
    // rust: for line in body.lines() {
    // rust: assert!(
    // rust: !line.contains("cfg"),
    // rust: "a cfg in the loot hook point: {line}"
    // rust: );
    // rust: for mac in ["!(", "![", "! {", "!{"] {
    // rust: assert!(
    // rust: !line.contains(mac),
    // rust: "a macro in the loot hook point: {line}"
    // rust: );
}
}
}

pub fn lifecycle_source_stays_hookable() void {
}
    // rust: let source = include_str!("native_lifecycle.rs");
    // rust: let code = source.split("#[cfg(test)]").next().unwrap_or_default();
    // rust: for line in code.lines().filter(|l| !l.trim_start().starts_with("//")) {
    // rust: assert!(!line.contains("cfg"), "a cfg in lifecycle source: {line}");
    // rust: for mac in ["!(", "![", "! {", "!{"] {
    // rust: assert!(!line.contains(mac), "a macro in lifecycle source: {line}");
}
}
}

pub fn catalog_matches_hook_points() void {
}
//         use std::collections::BTreeSet;

    // rust: let catalog: serde_json::Value =
    // rust: serde_json::from_str(include_str!("../../../../native-hooks.json")).unwrap();
    // rust: let mut hooks = catalog["hooks"].as_array().unwrap().clone();
    // rust: let fragments = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../tools/native-hook-fragments");
    // rust: for entry in std::fs::read_dir(fragments).unwrap() {
    // rust: let path = entry.unwrap().path();
    // rust: if path.extension().is_some_and(|ext| ext == "json") {
    // rust: let fragment: serde_json::Value =
    // rust: serde_json::from_slice(&std::fs::read(path).unwrap()).unwrap();
    // rust: hooks.extend(fragment["hooks"].as_array().unwrap().iter().cloned().map(
    // rust: |mut hook| {
    // rust: hook["version"] = 1.into();
    // rust: hook
    // rust: },
    // rust: ));
}
}
    // rust: let source = include_str!("native_hooks.rs");
    // rust: let section = source
    // rust: .split("/// The hook points. Each does nothing in Horizon.")
    // rust: .nth(1)
    // rust: .unwrap()
    // rust: .split("/// Server-level helpers for native mods.")
    // rust: .next()
    // rust: .unwrap();
    // rust: let level_section = source
    // rust: .split("impl GameLevel<'_> {")
    // rust: .nth(1)
    // rust: .unwrap()
    // rust: .split("\n}")
    // rust: .next()
    // rust: .unwrap();
    // rust: let level_hooks: BTreeSet<_> = level_section
    // rust: .lines()
    // rust: .filter_map(|line| {
    // rust: line.trim()
    // rust: .strip_prefix("pub(super) fn native_")?
    // rust: .split('(')
    // rust: .next()
    // rust: })
    // rust: .collect();
        // Hook points that are free functions in other crates.
    // rust: let free_hooks = |source: &'static str| -> BTreeSet<&'static str> {
    // rust: source
    // rust: .lines()
    // rust: .filter_map(|line| line.strip_prefix("pub fn native_")?.split('(').next())
    // rust: .collect()
}
        // The renderer's (`horizon_client_render::gfx::native_render`).
    // rust: let render_hooks = free_hooks(include_str!(
    // rust: "../../../horizon-client-render/src/gfx/native_render.rs"
    // rust: ));
        // Items' default components (`horizon_world::item_defaults`).
    // rust: let item_hooks = free_hooks(include_str!("../../../horizon-world/src/item_defaults.rs"));
        // The loot tables' hook point (`horizon_world::loot`).
    // rust: let loot_hooks = free_hooks(include_str!("../../../horizon-world/src/loot.rs"));
        // The menu engine's (`horizon_client::menu`).
    // rust: let menu_hooks = free_hooks(include_str!("../menu.rs"));
        // The air supply's (`horizon_client::breathing`).
    // rust: let breath_hooks = free_hooks(include_str!("../breathing.rs"));
        // The crafting loaders' (`horizon_client_lib::crafting`).
    // rust: let crafting_hooks = free_hooks(include_str!("../crafting.rs"));
    // rust: let hunger_hooks = free_hooks(include_str!("../hunger.rs"));
    // rust: let landing_hooks = free_hooks(include_str!("../landing.rs"));
    // rust: let motion_hooks = free_hooks(include_str!("../motion.rs"));
        // The chat relay's (`horizon_client_lib::lan::hub::chat`).
    // rust: let chat_hooks = free_hooks(include_str!("../lan/hub/chat.rs"));
        // The mob AI's (`horizon_client_lib::mobs::ai`).
    // rust: let mob_hooks = free_hooks(include_str!("../mobs/ai.rs"));
    // rust: let declared: BTreeSet<_> = section
    // rust: .lines()
    // rust: .chain(level_section.lines())
    // rust: .filter_map(|line| {
    // rust: line.trim()
    // rust: .strip_prefix("pub(super) fn native_")?
    // rust: .split('(')
    // rust: .next()
    // rust: })
    // rust: .chain(render_hooks.iter().copied())
    // rust: .chain(item_hooks.iter().copied())
    // rust: .chain(loot_hooks.iter().copied())
    // rust: .chain(menu_hooks.iter().copied())
    // rust: .chain(breath_hooks.iter().copied())
    // rust: .chain(crafting_hooks.iter().copied())
    // rust: .chain(hunger_hooks.iter().copied())
    // rust: .chain(landing_hooks.iter().copied())
    // rust: .chain(motion_hooks.iter().copied())
    // rust: .chain(chat_hooks.iter().copied())
    // rust: .chain(mob_hooks.iter().copied())
    // rust: .collect();
    // rust: let mut names = BTreeSet::new();
    // rust: let mut contracts = BTreeSet::new();
    // rust: for hook in &hooks {
    // rust: let name = hook["name"].as_str().unwrap();
    // rust: let version = hook["version"].as_u64().unwrap();
    // rust: assert!(
    // rust: version > 0 && contracts.insert((name, version)),
    // rust: "invalid or duplicate hook: {name} v{version}"
    // rust: );
    // rust: names.insert(name);
    // rust: let target = if render_hooks.contains(name) {
    // rust: format!("horizon_client_render::gfx::native_render::native_{name}")
    // rust: } else if item_hooks.contains(name) {
    // rust: format!("horizon_world::item_defaults::native_{name}")
    // rust: } else if loot_hooks.contains(name) {
    // rust: format!("horizon_world::loot::native_{name}")
    // rust: } else if crafting_hooks.contains(name) {
                // crafting.rs compiles into horizon-client-lib (#5446's
                // split): horizon-mixins resolves the crate by its package.
    // rust: format!("horizon_client_lib::crafting::native_{name}")
    // rust: } else if hunger_hooks.contains(name) {
    // rust: format!("horizon_client_lib::hunger::native_{name}")
    // rust: } else if landing_hooks.contains(name) {
    // rust: format!("horizon_client_lib::landing::native_{name}")
    // rust: } else if motion_hooks.contains(name) {
    // rust: format!("horizon_client_lib::motion::native_{name}")
    // rust: } else if chat_hooks.contains(name) {
    // rust: format!("horizon_client_lib::lan::hub::chat::native_{name}")
    // rust: } else if menu_hooks.contains(name) {
                // menu.rs compiles into horizon-client-lib (#5446's
                // split): horizon-mixins resolves the crate by its package.
    // rust: format!("horizon_client_lib::menu::native_{name}")
    // rust: } else if breath_hooks.contains(name) {
                // breathing.rs compiles into horizon-client-lib too.
    // rust: format!("horizon_client_lib::breathing::native_{name}")
    // rust: } else if mob_hooks.contains(name) {
    // rust: format!("horizon_client_lib::mobs::ai::native_{name}")
    // rust: } else if level_hooks.contains(name) {
    // rust: format!("horizon_client::game::native_hooks::GameLevel<'_>::native_{name}")
    // rust: } else {
    // rust: format!("horizon_client::game::native_hooks::Game<'_>::native_{name}")
}
    // rust: assert_eq!(hook["target"].as_str().unwrap(), target);
}
    // rust: assert_eq!(names, declared);
        // Every target's crate really compiles its module: #5446 moved
        // files between horizon-client and horizon-client-lib, and a
        // target left on the old crate applies to no bundle — the string
        // comparison above shares its expectation with the catalog, so it
        // alone cannot catch a move. The first path segment after the
        // crate must be a module of that crate's lib root.
    // rust: let client_root = include_str!("../lib.rs");
    // rust: let lib_root = include_str!("../client_lib.rs");
    // rust: for hook in &hooks {
    // rust: let target = hook["target"].as_str().unwrap();
    // rust: let (root, crate_name, rest) =
    // rust: if let Some(rest) = target.strip_prefix("horizon_client::") {
    // rust: (client_root, "horizon_client", rest)
    // rust: } else if let Some(rest) = target.strip_prefix("horizon_client_lib::") {
    // rust: (lib_root, "horizon_client_lib", rest)
    // rust: } else {
                    // The other crates (render, world) are their own packages,
                    // never split.
    // rust: continue;
}
    // rust: let module = rest.split("::").next().unwrap_or(rest);
    // rust: assert!(
    // rust: root.contains(&format!("mod {module};")),
    // rust: "{crate_name} does not compile module `{module}` (target {target})"
    // rust: );
}
}

    /// The damage hook gets a mob's source from its damage: the causing mob,
    /// the direct one when it deals the damage itself.
pub fn the_damage_hook_names_the_source() void {
}
//         use super::{HurtSource, Hurting, hurt_server_args, mob_source};
//         use horizon_client::mobs::{Damage, DamageKind as K, Who};
    // rust: let source = |kind, attacker| {
    // rust: let s = mob_source(&Damage {
    // rust: kind,
    // rust: attacker,
    // rust: from: None,
    // rust: attacker_species: None,
    // rust: });
    // rust: (s.damage_type, s.causing, s.direct)
}
    // rust: let zombie = Some(Who::Mob(3));
    // rust: assert_eq!(source(K::MobAttack, zombie), ("minecraft:mob_attack", 3, 3));
    // rust: assert_eq!(source(K::Thorns, zombie), ("minecraft:thorns", 3, 3));
    // rust: assert_eq!(source(K::Arrow, zombie), ("minecraft:arrow", 3, 0));
    // rust: let blast = source(K::Explosion, zombie);
    // rust: assert_eq!(blast, ("minecraft:player_explosion", 3, 0));
        // A player behind a mob's hit isn't known yet, nor is a fall's source.
    // rust: let hit = source(K::PlayerAttack, Some(Who::Player));
    // rust: assert_eq!(hit, ("minecraft:player_attack", 0, 0));
    // rust: assert_eq!(source(K::Fall, None), ("minecraft:fall", 0, 0));
    // rust: let arrow = HurtSource {
    // rust: damage_type: "minecraft:arrow",
    // rust: causing: 4,
    // rust: direct: 0,
}
    // rust: let player = (2, "minecraft:player", arrow);
    // rust: assert_eq!(hurt_server_args(Hurting::Player(2, arrow)), player);
    // rust: let dragon = (5, "minecraft:ender_dragon", arrow);
    // rust: assert_eq!(hurt_server_args(Hurting::Dragon(5, arrow)), dragon);
}

    /// A mod container opens a slot grid or a furnace's menu, by its slot
    /// count; no menu with rules of its own (a brewing stand's, a crafter's).
pub fn mod_menus_are_slot_grids_and_furnaces() void {
}
//         use super::mod_menu;
    // rust: assert_eq!(mod_menu("minecraft:hopper"), Some(("minecraft:hopper", 5)));
    // rust: assert_eq!(mod_menu("minecraft:generic_9x3").map(|m| m.1), Some(27));
    // rust: assert_eq!(mod_menu("minecraft:furnace").map(|m| m.1), Some(3));
    // rust: assert_eq!(mod_menu("minecraft:brewing_stand"), None);
    // rust: assert_eq!(mod_menu("hopper"), None);
}

    /// The config folder is `config/` beside `options.txt`, made when
    /// missing.
pub fn config_dir_is_config_in_the_game_folder() void {
}
        // Callable without a game, from any hook.
    // rust: let _: fn() -> Result<std::path::PathBuf, String> = super::Game::native_config_dir;
//         use super::config_dir;
    // rust: let root = std::env::temp_dir().join(format!("horizon-config-dir-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: assert!(!root.join("config").exists());
    // rust: let dir = config_dir(&root).unwrap();
    // rust: assert_eq!(dir, root.join("config"));
    // rust: assert!(dir.is_dir());
    // rust: assert_eq!(config_dir(&root).unwrap(), dir);
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    /// Vanilla's F3 draws a column in each top corner (`extractLines`, left
    /// and right aligned), and its charts along the bottom.
pub fn the_debug_screen_takes_both_top_corners_and_its_charts_corners() void {
}
//         use super::{Corner, debug_takes};
    // rust: for corner in Corner::ALL {
    // rust: assert!(!debug_takes(corner, false, [true, true]), "{corner:?}");
}
    // rust: assert!(debug_takes(Corner::TopLeft, true, [false, false]));
    // rust: assert!(debug_takes(Corner::TopRight, true, [false, false]));
    // rust: assert!(!debug_takes(Corner::BottomLeft, true, [false, false]));
    // rust: assert!(!debug_takes(Corner::BottomRight, true, [false, false]));
    // rust: assert!(debug_takes(Corner::BottomLeft, true, [true, false]));
    // rust: assert!(!debug_takes(Corner::BottomRight, true, [true, false]));
    // rust: assert!(debug_takes(Corner::BottomRight, true, [false, true]));
}

    /// An image is taken whole, and only when it fits its slot.
pub fn a_mod_image_is_taken_whole_and_only_when_it_fits() void {
}
//         use super::mod_image_fits;
    // rust: assert!(mod_image_fits(4, 2, 32, 1024, 1024));
    // rust: assert!(mod_image_fits(1024, 1024, 1024 * 1024 * 4, 1024, 1024));
    // rust: assert!(!mod_image_fits(0, 2, 0, 1024, 1024));
    // rust: assert!(!mod_image_fits(4, 2, 31, 1024, 1024));
    // rust: assert!(!mod_image_fits(4, 2, 33, 1024, 1024));
    // rust: assert!(!mod_image_fits(2048, 1, 2048 * 4, 1024, 1024));
}
}
