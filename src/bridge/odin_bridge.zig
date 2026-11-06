//! Zigcraft Odin Bridge
//! Exposes Odin's worldgen, procedural terrain, physics, and gameplay systems to Zig.

pub extern fn odin_init() void;
pub extern fn odin_generate_chunk(cx: i32, cz: i32, out_blocks: [*]u16) void;
pub extern fn odin_tick_physics(
    pos: *[3]f32,
    vel: *[3]f32,
    on_ground: *bool,
    dt: f32,
    move_forward: f32,
    move_strafe: f32,
    yaw_rad: f32,
    jump: bool,
) void;
pub extern fn odin_get_world_time() u64;
pub extern fn odin_tick_world_time() void;
pub extern fn odin_get_player_health() f32;
pub extern fn odin_select_slot(slot: i32) void;
pub extern fn odin_get_selected_item() u16;
