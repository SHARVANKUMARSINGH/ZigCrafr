//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spectator
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The spectator menu (`SpectatorGui`): its players and teams from the
//! server's player list and teams, and the teleport request.
// use super::Game;
// use horizon_client::{
    // rust: hud::HudBatch,
    // rust: hud_layout, keybinds,
    // rust: scoreboard::{comp_text, team_color_rgb},
    // rust: spectator_menu::{Member, Outcome, SpectatorMenu, Team},
    // rust: tab_list::{SPECTATOR, TabPlayer},
    // rust: text::Text,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};

    // rust: impl Game<'_> {
    /// `Util.getMillis` for the menu's fade.
pub fn spectator_now(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.started.elapsed().as_millis() as i64
}
    /// `new SpectatorMenu`: the listed players, and the teams with a player
    /// to go to (`TeleportToTeamMenuCategory.createTeamEntries`).
pub fn new_spectator_menu(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tab: Vec<TabPlayer> = self
    // rust: .remote_tab_players()
    // rust: .map_or_else(Vec::new, |(players, _, _)| players);
    // rust: for p in &mut tab {
    // rust: p.skin = self.face_skin(p.uuid, &p.skin);
}
    // rust: let member = |p: &TabPlayer| Member {
    // rust: uuid: p.uuid,
    // rust: name: p.name.clone(),
    // rust: skin: p.skin.clone(),
    // rust: enabled: p.game_mode != SPECTATOR,
}
    // rust: let players: Vec<Member> = tab.iter().map(member).collect();
    // rust: let teams = self
    // rust: .score
    // rust: .board
    // rust: .teams
    // rust: .iter()
    // rust: .filter_map(|team| {
    // rust: let members: Vec<Member> = team
    // rust: .players
    // rust: .iter()
    // rust: .filter_map(|name| tab.iter().find(|p| &p.name == name))
    // rust: .filter(|p| p.game_mode != SPECTATOR)
    // rust: .map(member)
    // rust: .collect();
    // rust: if members.is_empty() {
    // rust: return None;
}
                // A random member's face is the team's icon.
    // rust: let pick = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.subsec_nanos() as usize)
    // rust: % members.len();
    // rust: Some(Team {
    // rust: name: comp_text(&team.display_name),
    // rust: color: team.color.as_deref().and_then(team_color_rgb),
    // rust: icon: members[pick].skin.clone(),
    // rust: players: members,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: SpectatorMenu::new(players, teams)
}
pub fn spectator_outcome(self: *Self, outcome: Outcome) void {
}
    // rust: if let Outcome::Teleport(uuid) = outcome {
            // PlayerMenuItem.selectItem.
    // rust: self.send(S::TeleportToEntity(play::TeleportToEntity { uuid }));
}
}
    /// A hotbar key as a spectator (`SpectatorGui.onHotbarSelected`).
    // rust: pub(super) fn spectator_hotbar_key(&mut self, slot: i32) {
    // rust: let now = self.spectator_now();
    // rust: let menu = self.spectator_menu_if_needed();
    // rust: let outcome = self.spectator_gui.on_hotbar_selected(slot, now, menu);
    // rust: self.spectator_outcome(outcome);
}
    /// `key.spectatorHotbar`: opens the menu, or uses the selected item.
    // rust: pub(super) fn spectator_action_key(&mut self) {
    // rust: let now = self.spectator_now();
    // rust: let menu = self.spectator_menu_if_needed();
    // rust: let outcome = self.spectator_gui.on_action_key(now, menu);
    // rust: self.spectator_outcome(outcome);
}
    /// The menu a press would open, built only when none is up.
pub fn spectator_menu_if_needed(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (!self.spectator_gui.is_menu_active()).then(|| self.new_spectator_menu())
}
    /// `MouseHandler.onScroll` in spectator mode with the menu up.
    // rust: pub(super) fn spectator_scroll(&mut self, wheel: i32) {
    // rust: let now = self.spectator_now();
    // rust: self.spectator_gui.on_mouse_scrolled(wheel, now);
}
    /// `Hud.extractHotbar` for a spectator, and `extractAction`'s prompt.
    // rust: pub(super) fn draw_spectator_hotbar(&mut self, batch: &mut HudBatch) {
    // rust: let (w, h) = (batch.width as i32, batch.height as i32);
    // rust: let now = self.spectator_now();
    // rust: let labels: Vec<Text> = (1..=9)
    // rust: .map(|n| keybinds::display_name(self.settings.keys.get(&format!("key.hotbar.{n}"))))
    // rust: .collect();
    // rust: let font = &self.gui.atlas.font;
    // rust: let mut draws = self
    // rust: .spectator_gui
    // rust: .hotbar(w, h, now, &|slot| labels[slot].clone(), font);
    // rust: draws.extend(self.spectator_gui.action(
    // rust: w,
    // rust: h,
    // rust: now,
    // rust: font,
    // rust: self.settings.text_background(0.0),
    // rust: ));
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
}
