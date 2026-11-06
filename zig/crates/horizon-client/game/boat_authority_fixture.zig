//! Transpiled from Horizon Rust crate
//! Module: horizon-client_boat_authority_fixture
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The native parity harness runs the client boat ticker and authoritative
//! boat attacks without a renderer, on an empty world.
// use super::{Game, boats::Boat};
// use horizon_client::Result;
// use horizon_core::geometry::Vec3;
// use serde::Deserialize;
// use serde_json::json;
// use std::path::Path;

pub const Case = struct {
    name: []const u8,
    velocity: [f64,
    spin: f32,
    owned: std.ArrayList(bool),
    paddles: ?PaddleCase,
    attack: ?Attack,
};

pub const Attack = struct {
    yaw: f32,
    sprint: bool,
    ticks: u32,
    player_velocity: [f64,
    knockback: u8,
    creative: bool,
};

pub const PaddleCase = struct {
    initial: [f32,
    steps: std.ArrayList(PaddleStep),
};
pub const PaddleStep = struct {
    occupied: bool,
    owned: bool,
    first_player: bool,
    flags: [bool,
};

pub fn is_player() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn run_boat_authority_fixture(&mut self, directory: &Path) -> Result<()> {
    // rust: let cases: Vec<Case> =
    // rust: serde_json::from_str(&std::fs::read_to_string(directory.join("inputs.json"))?)?;
    // rust: let mut output = Vec::new();
    // rust: for case in cases {
    // rust: self.boats.clear();
    // rust: let mut boat = Boat::new(1, "oak".into(), Vec3::new(0.0, 100.0, 0.0), 0.0);
    // rust: let [x, y, z] = case.velocity;
    // rust: boat.velocity = Vec3::new(x, y, z);
    // rust: boat.delta_rotation = case.spin;
    // rust: self.boats.push(boat);
    // rust: if let Some(attack) = case.attack {
    // rust: let mut player =
    // rust: horizon_client::motion::PlayerMotion::new(self.motion, Vec3::ZERO)?;
    // rust: player.velocity = Vec3::new(
    // rust: attack.player_velocity[0],
    // rust: attack.player_velocity[1],
    // rust: attack.player_velocity[2],
    // rust: );
    // rust: player.set_sprinting(attack.sprint)?;
    // rust: self.player = Some(player);
    // rust: self.inventory.fill(None);
    // rust: self.selected = 0;
    // rust: if attack.knockback > 0 {
    // rust: self.inventory[0] = horizon_client::item_data::parse_stack(&format!(
    // rust: r#"{{id:"minecraft:stick",count:1,components:{{"minecraft:enchantments":{{"minecraft:knockback":{}}}}}}}"#,
    // rust: attack.knockback
    // rust: ))?;
}
    // rust: self.yaw = attack.yaw;
    // rust: self.attack_ticks = attack.ticks;
    // rust: self.creative = attack.creative;
    // rust: self.strike_boat(0);
    // rust: let player = self.player.as_ref().unwrap();
    // rust: output.push(json!({
    // rust: "name": case.name,
    // rust: "velocity": self.boats.first().map(|boat| boat.velocity.components().map(|v| format!("{:016x}", v.to_bits()))),
    // rust: "destroyed": self.boats.is_empty(),
    // rust: "player_velocity": player.velocity.components().map(|v| format!("{:016x}", v.to_bits())),
    // rust: "sprint": player.sprinting,
    // rust: }));
    // rust: continue;
}
    // rust: let mut steps = Vec::new();
    // rust: if let Some(paddles) = case.paddles {
    // rust: self.riding = None;
    // rust: self.boats[0].paddles = paddles.initial;
    // rust: for step in paddles.steps {
    // rust: self.boats[0].paddling = step.flags;
    // rust: self.boats[0].paddle_controller = step.occupied && step.first_player;
    // rust: self.riding = step.owned.then_some(1);
    // rust: if step.owned {
    // rust: self.boats[0].input = [
    // rust: step.flags[1] && !step.flags[0],
    // rust: step.flags[0] && !step.flags[1],
    // rust: step.flags[0] && step.flags[1],
    // rust: false,
    // rust: ];
    // rust: let boat = self.tick_boat(self.boats[0].clone(), true);
    // rust: self.boats[0] = boat;
}
    // rust: self.tick_remote_boat_bubbles();
    // rust: let boat = &self.boats[0];
    // rust: let rowing = [0.0, 0.25, 0.5, 1.0].map(|a| {
    // rust: [0, 1].map(|side| format!("{:08x}", boat.rowing_time(side, a).to_bits()))
    // rust: });
    // rust: steps.push(json!({
    // rust: "phase": boat.paddles.map(|p| format!("{:08x}", p.to_bits())),
    // rust: "rowing": rowing,
    // rust: }));
}
    // rust: output.push(json!({"name": case.name, "steps": steps}));
    // rust: continue;
}
    // rust: for owned in case.owned {
    // rust: self.riding = owned.then_some(1);
    // rust: if owned {
    // rust: let boat = self.boats.remove(0);
    // rust: let boat = self.tick_boat(boat, true);
    // rust: self.boats.push(boat);
}
    // rust: self.tick_remote_boat_bubbles();
    // rust: let boat = &self.boats[0];
    // rust: steps.push(json!({
    // rust: "owned": owned,
    // rust: "spin": format!("{:08x}", boat.delta_rotation.to_bits()),
    // rust: "velocity": boat.velocity.components().map(|v| format!("{:016x}", v.to_bits())),
    // rust: }));
}
    // rust: output.push(json!({"name": case.name, "steps": steps}));
}
    // rust: std::fs::write(directory.join("rust.json"), serde_json::to_vec(&output)?)?;
    // rust: Ok(())
}
}
