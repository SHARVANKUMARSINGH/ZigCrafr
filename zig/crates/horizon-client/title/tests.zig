//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use horizon_world::nbt::Tag;
// use std::{
    // rust: fs,
    // rust: sync::atomic::{AtomicUsize, Ordering},
}

pub const Fixture = struct {
    root: PathBuf,
    title: Title,
};
    // rust: impl Fixture {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: AtomicUsize = AtomicUsize::new(0);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-world-menu-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: fs::create_dir_all(root.join("saves")).unwrap();
    // rust: Self {
    // rust: title: Title::new(root.join("saves"), &root),
    // rust: root,
}
}
pub fn world(self: *Self, folder: []const u8, name: []const u8) void {
}
    // rust: crate::save::write_dat(
    // rust: &self.title.saves.join(folder).join("level.dat"),
    // rust: Tag::compound([
    // rust: (
    // rust: "Data",
    // rust: Tag::compound([
    // rust: ("LevelName", Tag::String(name.into())),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ("GameType", Tag::Int(1)),
    // rust: ("allowCommands", Tag::Byte(1)),
    // rust: (
    // rust: "WorldGenSettings",
    // rust: Tag::compound([("seed", Tag::Long(123456))]),
    // rust: ),
    // rust: (
    // rust: "Version",
    // rust: Tag::compound([("Name", Tag::String("26.3".into()))]),
    // rust: ),
    // rust: ("UnmodeledData", Tag::Long(987654321)),
    // rust: ]),
    // rust: ),
    // rust: ("OtherRootData", Tag::String("preserve me".into())),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
}
pub fn click(self: *Self, label: []const u8) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.click_with_sound(label).0
}
pub fn click_with_sound(self: *Self, label: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let button = self
    // rust: .title
    // rust: .buttons(480.0, 262.0)
    // rust: .into_iter()
    // rust: .find(|b| b.label == label)
    // rust: .unwrap();
    // rust: self.title
    // rust: .click(button.x + button.w / 2.0, button.y + 10.0, (480.0, 262.0))
}
pub fn select(self: *Self) void {
}
    // rust: self.title.enter_singleplayer();
    // rust: self.title.click(240.0, 60.0, (480.0, 262.0));
}
    /// Create New World, past the preparing read: the screen the pack
    /// screens hand their selection to.
pub fn enter_create_world_for_packs(self: *Self) void {
}
        // A world, so Singleplayer opens the list and its Create New World
        // goes through preparing (an empty list opens Create directly).
    // rust: self.world("World", "World");
    // rust: self.title.enter_singleplayer();
        // The Select screen's Create button reads the worldgen data first
        // (`openCreateWorldScreen` behind `createWorld.preparing`).
    // rust: assert_eq!(self.click_with_sound("Create New World").0, Action::None);
    // rust: assert!(
    // rust: self.title.preparing(),
    // rust: "Create New World goes through preparing"
    // rust: );
    // rust: self.title.finish_preparing();
    // rust: assert!(matches!(self.title.creation_packs(), Some((_, _))));
}
pub fn finish_backup(self: *Self) void {
}
    // rust: self.title.backup_shown.set(true);
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(5);
    // rust: while matches!(self.title.mode, Mode::Backup { .. }) {
    // rust: assert!(std::time::Instant::now() < deadline);
    // rust: std::thread::sleep(std::time::Duration::from_millis(10));
    // rust: self.title.poll_backup();
}
}
}
    // rust: impl Drop for Fixture {
pub fn drop(self: *Self) void {
}
    // rust: let _ = fs::remove_dir_all(&self.root);
}
}

pub fn direct_connection_remembers_the_address_on_cancel_escape_and_join() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.title.last_server = "localhost:25566".into();
    // rust: f.click("Multiplayer");
    // SafetyScreen comes first while its box was never ticked.
    // rust: assert!(matches!(f.title.mode, Mode::MultiplayerWarning { .. }));
    // rust: f.click("Proceed");
    // rust: f.click("Direct Connection");
    // rust: assert_eq!(f.title.focused_field().unwrap().1, "localhost:25566");

    // rust: *f.title.focused_field().unwrap().1 = "example.org:25567".into();
    // rust: f.click("Cancel");
    // rust: f.click("Direct Connection");
    // rust: assert_eq!(f.title.focused_field().unwrap().1, "example.org:25567");

    // rust: *f.title.focused_field().unwrap().1 = "[::1]:25568".into();
    // rust: f.title.escape();
    // rust: f.title.escape();
    // rust: f.click("Multiplayer");
    // rust: f.click("Proceed");
    // rust: f.click("Direct Connection");
    // rust: assert_eq!(f.title.focused_field().unwrap().1, "[::1]:25568");

    // rust: *f.title.focused_field().unwrap().1 = "localhost:25569".into();
    // rust: assert_eq!(
    // rust: f.click("Join Server"),
    // rust: Action::Connect {
    // rust: address: "localhost:25569".into(),
    // rust: lan: false,
}
    // rust: );
    // rust: assert_eq!(f.title.last_server, "localhost:25569");

    // rust: f.title.focused_field().unwrap().1.clear();
    // rust: f.title.escape();
    // rust: f.click("Direct Connection");
    // rust: assert!(f.title.focused_field().unwrap().1.is_empty());
}

pub fn f5_reloads_the_server_list() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.click("Multiplayer");
    // rust: f.click("Proceed");
    // rust: let file = crate::multiplayer::servers_file(&f.title.saves);
    // rust: horizon_protocol::servers::save(
    // rust: &file,
    // rust: &[horizon_protocol::servers::ServerEntry::new(
    // rust: "Local",
    // rust: "127.0.0.1:1",
    // rust: )],
    // rust: )
    // rust: .unwrap();
    // rust: let listed = |f: &Fixture| match &f.title.mode {
    // rust: Mode::Multiplayer(crate::multiplayer::Screen::List { servers, .. }) => servers.len(),
    // rust: _ => usize::MAX,
}
    // rust: assert_eq!(listed(&f), 0);
    // rust: f.title.refresh_servers();
    // rust: assert_eq!(listed(&f), 1);
    // Only the list refreshes.
    // rust: f.title.mode = Mode::Main;
    // rust: f.title.refresh_servers();
    // rust: assert!(matches!(f.title.mode, Mode::Main));
}

pub fn empty_singleplayer_opens_creation_and_cancel_returns_to_title() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.click("Singleplayer");
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));
    // rust: f.click("Cancel");
    // rust: assert!(matches!(f.title.mode, Mode::Main));
    // rust: f.click("Singleplayer");
    // rust: f.title.escape();
    // rust: assert!(matches!(f.title.mode, Mode::Main));
    // Filtering an existing list down to zero results must not create a world.
    // rust: f.world("One", "One");
    // rust: f.title.enter_singleplayer();
    // rust: f.title.type_text("no match");
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
}

pub fn selector_controls_require_selection_and_search_uses_filtered_indices() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("A", "Alpha");
    // rust: f.world("B", "Beta");
    // rust: f.title.enter_singleplayer();
    // rust: let Mode::Select { worlds, .. } = &mut f.title.mode else {
    // rust: panic!("existing worlds should open the selector");
}
    // Beta must have a different index in the full list and filtered list.
    // Filesystem timestamp precision must not decide which world comes first.
    // rust: worlds.sort_by(|a, b| a.folder.cmp(&b.folder));
    // rust: for label in ["Play Selected World", "Edit", "Delete", "Re-Create"] {
    // rust: assert!(
    // rust: !f.title
    // rust: .buttons(480.0, 262.0)
    // rust: .iter()
    // rust: .find(|b| b.label == label)
    // rust: .unwrap()
    // rust: .enabled
    // rust: );
    // rust: assert_eq!(f.click(label), Action::None);
}
    // Clicking the disabled footer controls leaves the search box unfocused.
    // rust: f.title.click(240.0, 31.0, (480.0, 262.0));
    // rust: f.title.type_text("bEtA");
    // rust: assert_eq!(f.title.search, "bEtA");
    // rust: f.title.click(240.0, 60.0, (480.0, 262.0));
    // rust: f.click("Edit");
    // rust: assert!(matches!(&f.title.mode, Mode::Edit { world, .. } if world.folder == "B"));
    // rust: f.title.escape();
    // rust: assert!(
    // rust: matches!(&f.title.mode, Mode::Select { worlds, selected: Some(i) } if worlds[*i].folder == "B")
    // rust: );
    // rust: f.title.search_focused = true;
    // rust: f.title.backspace();
    // rust: assert!(matches!(f.title.mode, Mode::Select { selected: None, .. }));
}

pub fn edit_layout_disables_missing_icon_and_opens_the_optimize_question() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "New World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: let buttons = f.title.buttons(480.0, 262.0);
    // rust: let reset = buttons.iter().find(|b| b.label == "Reset Icon").unwrap();
    // rust: assert_eq!(
    // rust: (reset.x, reset.y, reset.w, reset.enabled),
    // rust: (140.0, 78.0, 200.0, false)
    // rust: );
    // A 1920x1046 client area has a fractional height at GUI scale 4;
    // vanilla rounds up to 262 GUI pixels before positioning the layout.
    // rust: assert_eq!(f.title.buttons(480.0, 261.5)[0].y, 78.0);
    // rust: assert!(
    // rust: buttons
    // rust: .iter()
    // rust: .find(|b| b.label == "Optimize World")
    // rust: .unwrap()
    // rust: .enabled
    // rust: );
    // rust: f.click("Optimize World");
    // rust: assert!(matches!(f.title.mode, Mode::OptimizeConfirm { .. }));
    // rust: f.title.escape();
    // rust: assert!(matches!(f.title.mode, Mode::Edit { .. }));
    // rust: fs::write(f.title.saves.join("World/icon.png"), b"icon").unwrap();
    // rust: assert!(
    // rust: f.title
    // rust: .buttons(480.0, 262.0)
    // rust: .iter()
    // rust: .find(|b| b.label == "Reset Icon")
    // rust: .unwrap()
    // rust: .enabled
    // rust: );
    // rust: f.click("Reset Icon");
    // rust: assert!(!f.title.saves.join("World/icon.png").exists());
    // rust: assert!(
    // rust: !f.title
    // rust: .buttons(480.0, 262.0)
    // rust: .iter()
    // rust: .find(|b| b.label == "Reset Icon")
    // rust: .unwrap()
    // rust: .enabled
    // rust: );
    // rust: f.title.click(240.0, 60.0, (480.0, 262.0));
    // rust: for _ in 0..32 {
    // rust: f.title.backspace();
}
    // rust: assert!(
    // rust: !f.title
    // rust: .buttons(480.0, 262.0)
    // rust: .iter()
    // rust: .find(|b| b.label == "Save")
    // rust: .unwrap()
    // rust: .enabled
    // rust: );
}

pub fn rename_preserves_unknown_metadata_and_cancel_discards_edits() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "Original");
    // rust: let path = f.title.saves.join("World/level.dat");
    // rust: let original = crate::save::read_dat(&path).unwrap();
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.title.type_text(" discarded");
    // rust: f.click("Cancel");
    // rust: assert_eq!(crate::save::read_dat(&path).unwrap(), original);
    // rust: f.click("Edit");
    // rust: for _ in 0..32 {
    // rust: f.title.backspace();
}
    // rust: f.title.type_text("  Renamed 世界  ");
    // rust: f.click("Save");
    // rust: let mut expected = original;
    // rust: let Some(Tag::Compound(data)) = expected.get_mut("Data") else {
    // rust: panic!()
}
    // rust: data.insert("LevelName".into(), Tag::String("Renamed 世界".into()));
    // rust: assert_eq!(crate::save::read_dat(&path).unwrap(), expected);
    // rust: assert!(path.with_file_name("level.dat_old").is_file());
    // rust: assert!(
    // rust: matches!(&f.title.mode, Mode::Select { worlds, selected: Some(i) } if worlds[*i].name == "Renamed 世界")
    // rust: );
    // rust: f.click("Edit");
    // rust: f.title.type_text(" via Enter");
    // rust: f.title.confirm_edit();
    // rust: assert_eq!(
    // rust: Level::read(&f.title.saves.join("World")).unwrap().name,
    // rust: "Renamed 世界 via Enter"
    // rust: );
}

pub fn delete_requires_confirmation_and_both_cancel_paths_preserve_world() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Delete");
    // rust: assert!(matches!(f.title.mode, Mode::Delete { .. }));
    // rust: assert!(f.title.saves.join("World/level.dat").is_file());
    // rust: f.click("Cancel");
    // rust: f.click("Delete");
    // rust: f.title.escape();
    // rust: assert!(f.title.saves.join("World/level.dat").is_file());
    // rust: f.click("Delete");
    // rust: let delete = f
    // rust: .title
    // rust: .buttons(480.0, 262.0)
    // rust: .into_iter()
    // rust: .find(|b| b.label == "Delete")
    // rust: .unwrap();
    // rust: assert_eq!((delete.x, delete.y, delete.w), (88.0, 146.0, 150.0));
    // rust: f.click("Delete");
    // rust: assert!(!f.title.saves.join("World").exists());
    // The last world gone, vanilla opens a fresh Create New World, not an empty list.
    // rust: assert!(matches!(&f.title.mode, Mode::Create { name, .. } if name == "New World"));
    // rust: f.click("Cancel");
    // rust: assert!(matches!(f.title.mode, Mode::Main));
    // rust: f.click("Singleplayer");
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));
}

pub fn deleting_one_of_two_worlds_keeps_the_list() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("One", "One");
    // rust: f.world("Two", "Two");
    // rust: f.select();
    // rust: f.click("Delete");
    // rust: f.click("Delete");
    // rust: assert!(matches!(&f.title.mode, Mode::Select { worlds, .. } if worlds.len() == 1));
}

pub fn a_list_emptied_elsewhere_opens_create_world() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.title.enter_singleplayer();
    // rust: world_management::delete(&f.title.saves, "World").unwrap();
    // rust: f.title.worlds_changed();
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));
    // rust: f.title.escape();
    // rust: assert!(matches!(f.title.mode, Mode::Main));
}

pub fn backup_zip_preserves_nested_files_excludes_lock_and_keeps_duplicate_backups() void {
}
    // rust: let f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let world = f.title.saves.join("World");
    // rust: fs::create_dir_all(world.join("dimensions/minecraft/overworld/region")).unwrap();
    // rust: fs::write(world.join("session.lock"), b"locked").unwrap();
    // rust: fs::write(
    // rust: world.join("dimensions/minecraft/overworld/region/r.0.0.mca"),
    // rust: b"chunk bytes",
    // rust: )
    // rust: .unwrap();
    // rust: for _ in 0..2 {
    // rust: assert!(world_management::backup(&f.title.saves, "World").unwrap() > 0);
}
    // rust: let archives: Vec<_> = fs::read_dir(f.root.join("backups"))
    // rust: .unwrap()
    // rust: .map(|e| e.unwrap().path())
    // rust: .collect();
    // rust: assert_eq!(archives.len(), 2);
    // rust: for archive in archives {
    // rust: let mut zip = zip::ZipArchive::new(fs::File::open(archive).unwrap()).unwrap();
    // rust: assert!(zip.by_name("World/session.lock").is_err());
    // rust: let mut bytes = Vec::new();
    // rust: std::io::Read::read_to_end(&mut zip.by_name("World/level.dat").unwrap(), &mut bytes)
    // rust: .unwrap();
    // rust: assert_eq!(bytes, fs::read(world.join("level.dat")).unwrap());
    // rust: bytes.clear();
    // rust: std::io::Read::read_to_end(
    // rust: &mut zip
    // rust: .by_name("World/dimensions/minecraft/overworld/region/r.0.0.mca")
    // rust: .unwrap(),
    // rust: &mut bytes,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(bytes, b"chunk bytes");
}
}

pub fn backup_screen_blocks_navigation_and_returns_to_the_selected_world() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.title.type_text(" unsaved");
    // rust: f.click("Make Backup");
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // rust: assert!(f.title.buttons(480.0, 262.0).is_empty());
    // rust: f.title.escape();
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // The first frame must be shown even when the backup finishes immediately.
    // rust: f.title.poll_backup();
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // rust: f.finish_backup();
    // rust: assert!(
    // rust: matches!(&f.title.mode, Mode::Select { worlds, selected: Some(i) } if worlds[*i].folder == "World")
    // rust: );
    // rust: assert!(
    // rust: matches!(&f.title.toast, Some((_, WorldToast::Created { folder, bytes })) if folder == "World" && *bytes > 0)
    // rust: );
    // rust: assert_eq!(
    // rust: Level::read(&f.title.saves.join("World")).unwrap().name,
    // rust: "World"
    // rust: );
}

pub fn failed_backup_returns_to_the_selected_world_with_an_error_toast() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.title.type_text(" unsaved");
    // A file at the backup-directory path makes the real worker fail reliably.
    // rust: fs::write(f.root.join("backups"), b"not a directory").unwrap();
    // rust: f.click("Make Backup");
    // rust: f.finish_backup();
    // rust: assert!(
    // rust: matches!(&f.title.mode, Mode::Select { worlds, selected: Some(i) } if worlds[*i].folder == "World")
    // rust: );
    // rust: let Some((_, WorldToast::Failed(error))) = &f.title.toast else {
    // rust: panic!("backup failures should produce an error toast");
}
    // rust: assert!(!error.is_empty());
    // rust: assert_eq!(
    // rust: Level::read(&f.title.saves.join("World")).unwrap().name,
    // rust: "World"
    // rust: );
    // rust: assert_eq!(
    // rust: fs::read(f.root.join("backups")).unwrap(),
    // rust: b"not a directory"
    // rust: );
}

pub fn stopped_backup_worker_returns_to_the_list_with_an_error_toast() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let world = list_worlds(&f.title.saves).remove(0);
    // rust: let (send, receive) = mpsc::channel();
    // rust: f.title.mode = Mode::Backup { world };
    // rust: f.title.backup = Some(receive);
    // rust: f.title.backup_shown.set(true);
    // rust: drop(send);
    // rust: f.title.poll_backup();
    // rust: assert!(
    // rust: matches!(&f.title.mode, Mode::Select { worlds, selected: Some(i) } if worlds[*i].folder == "World")
    // rust: );
    // rust: assert!(
    // rust: matches!(&f.title.toast, Some((_, WorldToast::Failed(error))) if error == "Backup worker stopped")
    // rust: );
}

pub fn backup_toast_slides_in_and_out_with_its_sounds() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.click("Make Backup");
    // rust: f.title.poll_backup();
    // rust: f.finish_backup();
    // rust: assert_eq!(f.title.update_toast(1.0), Some("minecraft:ui.toast.in"));
    // rust: assert_eq!(f.title.update_toast(1.0), None);
    // rust: let age = |f: &mut Fixture, ms: u64| {
    // rust: let (slide, _) = f.title.toast.as_mut().unwrap();
    // rust: let origin = slide.origin.as_mut().unwrap();
    // rust: *origin -= std::time::Duration::from_millis(ms);
}
    // Half way in: (300 / 600)² of its width shows.
    // rust: age(&mut f, 300);
    // rust: assert_eq!(f.title.update_toast(1.0), None);
    // rust: let portion = f.title.toast.as_ref().unwrap().0.portion;
    // rust: assert!((portion - 0.25).abs() < 0.02, "{portion}");
    // Shown in full for the display time, then out.
    // rust: age(&mut f, 300);
    // rust: f.title.update_toast(1.0);
    // rust: age(&mut f, 5100);
    // rust: assert_eq!(f.title.update_toast(1.0), Some("minecraft:ui.toast.out"));
    // rust: assert!(f.title.toast.is_some());
    // rust: age(&mut f, 700);
    // rust: assert_eq!(f.title.update_toast(1.0), None);
    // rust: assert!(f.title.toast.is_none());
}

pub fn failed_operations_show_error_and_leave_world_intact() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: fs::remove_file(f.title.saves.join("World/level.dat")).unwrap();
    // rust: f.click("Save");
    // rust: assert!(matches!(f.title.mode, Mode::Error { .. }));
    // rust: f.click("Back");
    // rust: assert!(matches!(f.title.mode, Mode::Edit { .. }));
    // rust: assert!(f.title.saves.join("World").is_dir());
    // rust: for bad in ["../World", "..", ".", "/World"] {
    // rust: assert!(world_management::delete(&f.title.saves, bad).is_err());
}
}

/// `LevelStorageSource.validateAndCreateAccess`: the world folder's links are
/// looked for before an access is made, and one is enough to keep the world
/// closed - `WorldOpenFlows.createWorldAccess` shows the symlink warning in
/// place of the world (`symlink_warning.title.world`), and the session lock
/// is never taken, so the world is not held by this instance.
pub fn a_world_folder_holding_a_link_is_not_opened() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let outside = f.root.join("outside");
    // rust: fs::create_dir_all(&outside).unwrap();
    // rust: fs::write(outside.join("keep.txt"), "keep").unwrap();
    // rust: std::os::unix::fs::symlink(&outside, f.title.saves.join("World/link")).unwrap();
    // rust: assert_eq!(
    // rust: world_management::symlinks(&f.title.saves, "World")
    // rust: .unwrap()
    // rust: .len(),
    // rust: 1
    // rust: );
    // rust: f.select();
    // rust: assert_eq!(
    // rust: f.click("Play Selected World"),
    // rust: Action::None,
    // rust: "the world opened"
    // rust: );
    // rust: assert!(
    // rust: matches!(
    // rust: &f.title.mode,
    // rust: Mode::Error {
    // rust: alert: Some(Alert::Symlink),
    // rust: ..
}
    // rust: ),
    // rust: "{:?} is not the symlink warning",
    // rust: f.title.mode
    // rust: );
    // rust: assert!(
    // rust: crate::save::SessionLock::acquire(&f.title.saves.join("World")).is_ok(),
    // rust: "the refused world was left unlocked"
    // rust: );
    // A world with no links in it still opens.
    // rust: f.world("Clean", "Clean");
    // rust: f.select();
    // rust: assert_eq!(
    // rust: world_management::symlinks(&f.title.saves, "Clean").unwrap(),
    // rust: Vec::<std::path::PathBuf>::new()
    // rust: );
}

pub fn backup_rejects_symlinks_and_removes_incomplete_archive() void {
}
    // rust: let f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: std::os::unix::fs::symlink(f.root.join("outside"), f.title.saves.join("World/link")).unwrap();
    // rust: assert!(world_management::backup(&f.title.saves, "World").is_err());
    // rust: assert_eq!(fs::read_dir(f.root.join("backups")).unwrap().count(), 0);
}

pub fn recreate_uses_existing_name_seed_and_mode_and_scroll_reaches_later_rows() void {
}
    // rust: let mut f = Fixture::new();
    // rust: for i in 0..10 {
    // rust: f.world(&format!("World{i}"), &format!("World {i}"));
}
    // rust: f.select();
    // rust: f.click("Re-Create");
    // rust: assert!(
    // rust: matches!(&f.title.mode,Mode::Create { name,seed,creative:true,.. } if name.starts_with("World ") && seed == "123456")
    // rust: );
    // rust: f.click("Cancel");
    // rust: f.title
    // rust: .scroll_worlds(-100.0, (240.0, 100.0), (480.0, 262.0));
    // rust: assert!(f.title.scroll.get().amount > 0.0);
    // rust: let Mode::Select { worlds, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: let last = worlds.last().unwrap().folder.clone();
    // rust: f.title.click(240.0, 180.0, (480.0, 262.0));
    // rust: assert!(
    // rust: matches!(&f.title.mode,Mode::Select { worlds,selected:Some(i) } if worlds[*i].folder == last)
    // rust: );
}

pub fn only_the_vertical_wheel_cycles_a_create_world_button() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.enter_create_world_for_packs();
    // rust: let size = (480.0, 262.0);
    // rust: let labels = |f: &Fixture| {
    // rust: let Mode::Create {
    // rust: creative, options, ..
    // rust: } = &f.title.mode
    // rust: else {
    // rust: panic!("not on Create World");
}
    // rust: create_world::buttons(size.0, size.1, *creative, options)
}
    // rust: let button = labels(&f)
    // rust: .into_iter()
    // rust: .find(|b| b.enabled)
    // rust: .expect("an enabled button");
    // What the buttons cycle: their labels read the same without a language loaded.
    // rust: let state = |f: &Fixture| {
    // rust: let Mode::Create {
    // rust: creative, options, ..
    // rust: } = &f.title.mode
    // rust: else {
    // rust: panic!("not on Create World");
}
    // rust: (*creative, options.clone())
}
    // rust: let at = (button.x + 1.0, button.y + 1.0);
    // rust: let before = state(&f);
    // A horizontal notch arrives with no vertical part.
    // rust: f.title.scroll_worlds(0.0, at, size);
    // rust: assert_eq!(state(&f), before);
    // rust: f.title.scroll_worlds(-1.0, at, size);
    // rust: assert_ne!(state(&f), before);
}

pub fn stick_scroll_moves_the_world_list_with_the_pointer_outside_it() void {
}
    // rust: let mut f = Fixture::new();
    // rust: for i in 0..10 {
    // rust: f.world(&format!("World{i}"), &format!("World {i}"));
}
    // rust: f.select();
    // rust: let (outside, size) = ((10.0, 2.0), (480.0, 262.0));
    // rust: f.title.scroll_worlds(-1.0, outside, size);
    // rust: assert_eq!(f.title.scroll.get().amount, 0.0);
    // rust: f.title.step_scroll(-1.0, outside, size);
    // rust: assert_eq!(f.title.scroll.get().amount, 0.0);
    // The stick goes by the list the last frame drew.
    // rust: crate::widgets::scroll_area([0.0, 32.0, 400.0, 166.0], 0.0, 100.0);
    // rust: crate::widgets::end_frame(u64::MAX);
    // rust: f.title.stick_scroll(-1.0, outside, size);
    // rust: assert_eq!(f.title.scroll.get().amount, 18.0);
}

pub fn classic_navigation_buttons_sound_even_without_a_game_action() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: assert_eq!(
    // rust: f.title.click(0.0, 0.0, (480.0, 262.0)),
    // rust: (Action::None, false)
    // rust: );
    // rust: assert_eq!(f.click_with_sound("Minecraft Realms"), (Action::None, true));
    // The Realms screen's Back, as the loaded language names it.
    // rust: assert_eq!(
    // rust: f.click_with_sound(&crate::lang::get("gui.back")),
    // rust: (Action::None, true)
    // rust: );
    // rust: assert_eq!(f.click_with_sound("Singleplayer"), (Action::None, true));
    // rust: assert_eq!(
    // rust: f.click_with_sound("Play Selected World"),
    // rust: (Action::None, false)
    // rust: );
    // rust: assert_eq!(f.click_with_sound("Create New World"), (Action::None, true));
    // Create New World prepares the world generation first
    // (`CreateWorldScreen.openCreateWorldScreen`); the game opens the
    // screen once that is done.
    // rust: assert!(f.title.click(240.0, 55.0, (480.0, 262.0)).0 == Action::None);
    // rust: assert!(
    // rust: f.title.preparing(),
    // rust: "Create New World goes through preparing"
    // rust: );
    // rust: f.title.finish_preparing();
    // The Game tab's game mode cycle button.
    // rust: let mode = f
    // rust: .title
    // rust: .buttons(480.0, 262.0)
    // rust: .into_iter()
    // rust: .find(|b| b.id == 20)
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: f.title.click(mode.x + 1.0, mode.y + 1.0, (480.0, 262.0)),
    // rust: (Action::None, true)
    // rust: );
    // rust: assert_eq!(f.click_with_sound("Cancel"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Back"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Options..."), (Action::Options, true));
}

/// A feature pack the resources root ships (`PackSource.FEATURE`).
pub fn feature_pack(root: *Path) void {
}
    // rust: let pack = root.join("data/minecraft/datapacks/test_feature");
    // rust: fs::create_dir_all(&pack).unwrap();
    // rust: fs::write(pack.join("pack.mcmeta"), r#"{"pack":{"description":"t"}}"#).unwrap();
}

pub fn offer_data_packs_without_a_feature_applies_at_once() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.enter_create_world_for_packs();
    // rust: f.title
    // rust: .offer_data_packs(&f.root, vec!["vanilla".into(), "file/t.zip".into()]);
    // `tryApplyNewDataPacks`: no confirm screen, the selection applies and
    // the data is read again.
    // rust: assert!(f.title.confirm_experiments.borrow().is_none());
    // rust: assert!(f.title.preparing());
    // rust: assert_eq!(
    // rust: f.title.creation_packs().map(|(_, ids)| ids),
    // rust: Some(vec!["vanilla".to_owned(), "file/t.zip".to_owned()])
    // rust: );
}

pub fn offer_data_packs_with_a_feature_asks_and_the_confirm_screen_decides() void {
}
    // rust: let mut f = Fixture::new();
    // rust: feature_pack(&f.root);
    // rust: f.enter_create_world_for_packs();
    // rust: f.title
    // rust: .offer_data_packs(&f.root, vec!["vanilla".into(), "test_feature".into()]);
    // The confirm screen is up, the selection waits.
    // rust: assert!(f.title.confirm_experiments.borrow().is_some());
    // rust: assert!(!f.title.preparing());
    // rust: assert_eq!(
    // rust: f.title.creation_packs().map(|(_, ids)| ids),
    // rust: Some(vec!["vanilla".to_owned()])
    // rust: );
    // Back (`onAbort`): the Data Packs screen reopens with the selection
    // it had, the confirm screen is gone.
    // rust: let atlas = crate::hud::HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // confirm_experiments::footer_pair's Back, for a 480-wide screen
    // (COLUMN_SPACING is 10).
    // rust: let back_x = ((480.0_f32 - (150.0 * 2.0 + 10.0)) / 2.0).trunc() + 150.0 + 10.0 + 1.0;
    // rust: f.title
    // rust: .press_rules(&atlas, (back_x, 262.0 - 45.0 + 1.0), (480.0, 262.0));
    // rust: assert!(f.title.confirm_experiments.borrow().is_none());
    // rust: assert!(f.title.take_reopen_data_packs());
    // rust: assert_eq!(
    // rust: f.title.creation_packs().map(|(_, ids)| ids),
    // rust: Some(vec!["vanilla".to_owned()])
    // rust: );
    // The screen is offered again, and Proceed applies the selection and
    // asks for the read.
    // rust: f.title
    // rust: .offer_data_packs(&f.root, vec!["vanilla".into(), "test_feature".into()]);
    // The Proceed button, left of the pair.
    // rust: let proceed_x = ((480.0_f32 - (150.0 * 2.0 + 10.0)) / 2.0).trunc() + 1.0;
    // rust: f.title
    // rust: .press_rules(&atlas, (proceed_x, 262.0 - 45.0 + 1.0), (480.0, 262.0));
    // rust: assert!(f.title.confirm_experiments.borrow().is_none());
    // rust: assert!(f.title.preparing());
    // rust: assert_eq!(
    // rust: f.title.creation_packs().map(|(_, ids)| ids),
    // rust: Some(vec!["vanilla".to_owned(), "test_feature".to_owned()])
    // rust: );
}

pub fn preparing_takes_no_input() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.enter_create_world_for_packs();
    // rust: f.title
    // rust: .offer_data_packs(&f.root, vec!["vanilla".into(), "file/t.zip".into()]);
    // rust: assert!(f.title.preparing());
    // Escape during the read: nothing closes, the options survive
    // (GenericMessageScreen.shouldCloseOnEsc is false).
    // rust: f.title.escape();
    // rust: assert!(f.title.preparing());
    // rust: assert!(f.title.creation_packs().is_some());
    // Typed text doesn't reach the focused field either.
    // rust: let before = format!("{:?}", f.title.mode);
    // rust: f.title.type_text("typed during the read");
    // rust: assert_eq!(format!("{:?}", f.title.mode), before);
    // rust: f.title.finish_preparing();
    // rust: assert!(!f.title.preparing());
}

pub fn classic_world_selection_is_silent_until_the_entry_launches() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.title.enter_singleplayer();
    // rust: assert_eq!(
    // rust: f.title.click(240.0, 60.0, (480.0, 262.0)),
    // rust: (Action::None, false)
    // rust: );
    // rust: assert_eq!(
    // rust: f.title.click(240.0, 60.0, (480.0, 262.0)),
    // rust: (
    // rust: Action::Play {
    // rust: folder: "World".into()
    // rust: },
    // rust: true
    // rust: )
    // rust: );
}

pub fn middle_clicking_a_world_selects_it_without_joining() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.title.enter_singleplayer();
    // rust: let size = (480.0, 262.0);
    // rust: let enabled = |f: &Fixture, label: &str| {
    // rust: f.title
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .find(|b| b.label == label)
    // rust: .unwrap()
    // rust: .enabled
}
    // rust: assert!(!enabled(&f, "Edit"), "nothing is selected yet");
    // rust: assert!(f.title.select_world_at(240.0, 60.0, size));
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::Select {
    // rust: selected: Some(0),
    // rust: ..
}
    // rust: ));
    // rust: assert!(
    // rust: enabled(&f, "Edit"),
    // rust: "the selection callback reaches the footer"
    // rust: );
    // Again on the selected row: still only a selection, not a join.
    // rust: assert!(f.title.select_world_at(240.0, 60.0, size));
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
    // Outside the rows (the footer) nothing is selected.
    // rust: assert!(!f.title.select_world_at(240.0, 250.0, size));
}

pub fn a_world_open_elsewhere_stays_closed_behind_a_toast() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.title.enter_singleplayer();
    // rust: let open = crate::save::SessionLock::acquire(&f.title.saves.join("World")).unwrap();
    // rust: let (icon_x, icon_y) = (240.0 - 135.0 + 2.0, LIST_TOP + 4.0);
    // rust: assert_eq!(
    // rust: f.title
    // rust: .click(icon_x + 16.0, icon_y + 16.0, (480.0, 262.0))
    // rust: .0,
    // rust: Action::None
    // rust: );
    // rust: assert!(
    // rust: matches!(&f.title.toast, Some((_, WorldToast::AccessFailure(folder))) if folder == "World")
    // rust: );
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
    // rust: drop(open);
    // rust: assert_eq!(
    // rust: f.title
    // rust: .click(icon_x + 16.0, icon_y + 16.0, (480.0, 262.0))
    // rust: .0,
    // rust: Action::Play {
    // rust: folder: "World".into()
}
    // rust: );
}

pub fn clicking_a_world_icon_joins_it_at_once() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.title.enter_singleplayer();
    // WorldListEntry.mouseOverIcon: the row's 32x32 icon, left of its text.
    // rust: let (icon_x, icon_y) = (240.0 - 135.0 + 2.0, LIST_TOP + 4.0);
    // rust: assert_eq!(
    // rust: f.title.click(icon_x + 31.0, icon_y + 16.0, (480.0, 262.0)),
    // rust: (
    // rust: Action::Play {
    // rust: folder: "World".into()
    // rust: },
    // rust: true
    // rust: )
    // rust: );
    // Right of the icon only selects the row.
    // rust: f.title.enter_singleplayer();
    // rust: assert_eq!(
    // rust: f.title.click(icon_x + 33.0, icon_y + 16.0, (480.0, 262.0)),
    // rust: (Action::None, false)
    // rust: );
}

pub fn world_management_buttons_sound_when_enabled() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: assert_eq!(f.click_with_sound("Edit"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Reset Icon"), (Action::None, false));
    // rust: assert_eq!(f.click_with_sound("Optimize World"), (Action::None, true));
    // rust: f.title.escape();
    // rust: fs::write(f.title.saves.join("World/icon.png"), b"icon").unwrap();
    // rust: assert_eq!(f.click_with_sound("Reset Icon"), (Action::None, true));
    // rust: let Mode::Edit { name, .. } = &mut f.title.mode else {
    // rust: panic!("edit screen")
}
    // rust: name.clear();
    // rust: assert_eq!(f.click_with_sound("Save"), (Action::None, false));
    // rust: let Mode::Edit { name, .. } = &mut f.title.mode else {
    // rust: panic!("edit screen")
}
    // rust: *name = "Renamed".into();
    // rust: assert_eq!(f.click_with_sound("Save"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Edit"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Cancel"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Delete"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Cancel"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Delete"), (Action::None, true));
    // rust: assert_eq!(f.click_with_sound("Delete"), (Action::None, true));
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));
}

pub fn backup_button_sounds_and_the_progress_screen_is_silent() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: assert_eq!(f.click_with_sound("Make Backup"), (Action::None, true));
    // rust: assert_eq!(
    // rust: f.title.click(240.0, 120.0, (480.0, 262.0)),
    // rust: (Action::None, false)
    // rust: );
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // rust: f.finish_backup();
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
}

pub fn failed_world_operation_back_button_plays_the_click_sound() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: fs::remove_file(f.title.saves.join("World/level.dat")).unwrap();
    // rust: assert_eq!(f.click_with_sound("Save"), (Action::None, true));
    // rust: assert!(matches!(f.title.mode, Mode::Error { .. }));
    // rust: assert_eq!(f.click_with_sound("Back"), (Action::None, true));
    // rust: assert!(matches!(f.title.mode, Mode::Edit { .. }));
}

pub fn delete_refuses_an_open_world_then_removes_it_with_its_lock() void {
}
    // rust: let f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let open = crate::save::SessionLock::acquire(&f.title.saves.join("World")).unwrap();
    // rust: assert!(world_management::delete(&f.title.saves, "World").is_err());
    // rust: assert!(f.title.saves.join("World/level.dat").is_file());
    // rust: drop(open);
    // rust: world_management::delete(&f.title.saves, "World").unwrap();
    // rust: assert!(!f.title.saves.join("World").exists());
}

pub fn delete_removes_links_without_following_them() void {
}
    // rust: let f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let outside = f.root.join("outside");
    // rust: fs::create_dir_all(&outside).unwrap();
    // rust: fs::write(outside.join("keep.txt"), "keep").unwrap();
    // rust: std::os::unix::fs::symlink(&outside, f.title.saves.join("World/link")).unwrap();
    // rust: std::os::unix::fs::symlink(&outside, f.title.saves.join("Linked")).unwrap();
    // rust: assert!(world_management::delete(&f.title.saves, "Linked").is_err());
    // rust: world_management::delete(&f.title.saves, "World").unwrap();
    // rust: assert!(!f.title.saves.join("World").exists());
    // rust: assert!(outside.join("keep.txt").is_file());
}

pub fn hovered_buttons_ask_for_the_hand_or_not_allowed() void {
}
//     use crate::widgets::Cursor;
    // rust: let mut f = Fixture::new();
    // rust: let atlas = crate::hud::HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let cursor_over = |title: &Title, label: Option<&str>| {
    // rust: let mouse = label.map_or((0.0, 0.0), |label| {
    // rust: let buttons = title.buttons(480.0, 262.0);
    // rust: let b = buttons.iter().find(|b| b.label == label).unwrap();
    // rust: (b.x + b.w / 2.0, b.y + 10.0)
    // rust: });
    // rust: let _ = crate::widgets::take_cursor();
    // rust: title.draw(&atlas, &mut HudBatch::new([480, 262]), mouse, true);
    // rust: crate::widgets::take_cursor()
}
    // rust: assert_eq!(
    // rust: cursor_over(&f.title, Some("Singleplayer")),
    // rust: Cursor::PointingHand
    // rust: );
    // rust: assert_eq!(cursor_over(&f.title, None), Cursor::Arrow);
    // The world list's footer is inactive until a world is selected.
    // rust: f.world("A", "Alpha");
    // rust: f.title.enter_singleplayer();
    // rust: assert_eq!(cursor_over(&f.title, Some("Edit")), Cursor::NotAllowed);
}

pub fn world_search_hint_is_gray_and_only_shown_empty_and_unfocused() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: let atlas = crate::hud::HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let draw = |title: &Title| {
    // rust: let mut batch = HudBatch::new([480, 262]);
    // rust: title.draw(&atlas, &mut batch, (0.0, 0.0), true);
    // rust: batch
}
    // rust: let has_hint = |batch: &HudBatch| {
    // rust: batch
    // rust: .vertices
    // rust: .iter()
    // rust: .any(|v| v.color == rgba(170, 170, 170, 255) && (21.0..41.0).contains(&v.pos[1]))
}
    // rust: assert!(has_hint(&draw(&f.title)));

    // rust: f.title.click(240.0, 31.0, (480.0, 262.0));
    // rust: assert!(f.title.search_focused);
    // rust: assert!(!has_hint(&draw(&f.title)));
    // rust: f.title.type_text("World");
    // rust: f.title.click(240.0, 60.0, (480.0, 262.0));
    // rust: assert!(!f.title.search_focused);
    // rust: assert!(!has_hint(&draw(&f.title)));
}

pub fn scrolled_world_list_draws_inside_the_list_and_drags_its_scroller() void {
}
    // rust: let mut f = Fixture::new();
    // rust: for i in 0..10 {
    // rust: f.world(&format!("World{i}"), &format!("World {i}"));
}
    // rust: f.select();
    // rust: let size = (480.0, 262.0);
    // SelectWorldScreen's list: 49 to h - 60, scroller at the row's right + 8.
    // rust: let bar = (480.0 / 2.0 - ROW_WIDTH / 2.0 + ROW_WIDTH + 8.0 + 3.0, 60.0);
    // rust: f.title.click(bar.0, bar.1, size);
    // rust: f.title.drag((bar.0, 120.0), size);
    // rust: let moved = f.title.scroll.get().amount;
    // rust: assert!(moved > 0.0);
    // rust: f.title.release();
    // rust: f.title.drag((bar.0, 60.0), size);
    // rust: assert_eq!(f.title.scroll.get().amount, moved);
    // rust: let atlas = crate::hud::HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let mut batch = HudBatch::new([480, 262]);
    // rust: f.title.draw(&atlas, &mut batch, (0.0, 0.0), true);
    // rust: assert!(!batch.vertices.is_empty());
}

pub fn create_world_tabs_follow_vanilla_and_their_choices_reach_the_action() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.click("Singleplayer");
    // rust: let size = (480.0, 262.0);
    // rust: let labels = |f: &Fixture| -> Vec<(String, f32, f32, bool)> {
    // rust: f.title
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .map(|b| (b.label, b.x, b.y, b.enabled))
    // rust: .collect()
}
    // Game tab: the grid (210 × 117) at (0.5, 1/6) of 24..h-33, footer centred.
    // rust: let game = labels(&f);
    // rust: assert_eq!(game[0].1, 135.0);
    // rust: assert_eq!(game[0].2, 24.0 + 14.0 + 41.0);
    // rust: assert_eq!((game[3].1, game[3].2), (86.0, 235.0));
    // rust: assert_eq!((game[4].1, game[4].2), (244.0, 235.0));
    // Survival, Hardcore (Hard, no cheats, both locked), Creative (cheats on).
    // rust: f.title.click(240.0, game[0].2 + 10.0, size);
    // rust: let Mode::Create { options, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: assert!(options.hardcore && options.difficulty() == 3 && !options.commands(false));
    // rust: assert!(!labels(&f)[1].3 && !labels(&f)[2].3);
    // rust: f.title.click(240.0, game[0].2 + 10.0, size);
    // rust: let Mode::Create {
    // rust: creative, options, ..
    // rust: } = &f.title.mode
    // rust: else {
    // rust: panic!()
}
    // rust: assert!(*creative && !options.hardcore && options.commands(true));
    // The World tab (second of three 124-wide tabs from x 54): its seed box
    // takes the focus, the world type cycles and the switches toggle.
    // rust: let (action, sound) = f.title.click(54.0 + 124.0 + 10.0, 10.0, size);
    // rust: assert!(sound && action == Action::None);
    // rust: let world = labels(&f);
    // rust: assert_eq!((world[0].1, world[0].2), (85.0, 38.0));
    // rust: assert_eq!((world[2].1, world[2].2), (85.0 + 266.0, 38.0 + 73.0));
    // The world-type button cycles through vanilla's world presets.
    // rust: let world_type = |f: &Fixture| -> crate::save::WorldPreset {
    // rust: let Mode::Create { options, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: options.world_type
}
    // rust: assert_eq!(world_type(&f), crate::save::WorldPreset::Normal);
    // rust: for expected in [
    // rust: crate::save::WorldPreset::Flat,
    // rust: crate::save::WorldPreset::LargeBiomes,
    // rust: crate::save::WorldPreset::Amplified,
    // rust: crate::save::WorldPreset::SingleBiomeSurface,
    // rust: crate::save::WorldPreset::Normal,
    // rust: ] {
    // rust: f.title.click(world[0].1 + 10.0, world[0].2 + 10.0, size);
    // rust: assert_eq!(world_type(&f), expected);
}
    // The amplified preset is the third one.
    // rust: for _ in 0..3 {
    // rust: f.title.click(world[0].1 + 10.0, world[0].2 + 10.0, size);
}
    // rust: f.title.click(world[3].1 + 10.0, world[3].2 + 10.0, size);
    // rust: f.title.click(100.0, 38.0 + 41.0 + 10.0, size);
    // rust: let Mode::Create { focus, options, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: assert_eq!(*focus, 1);
    // rust: assert_eq!(options.world_type, crate::save::WorldPreset::Amplified);
    // rust: assert!(options.bonus_chest());
    // rust: let Action::Create { options, .. } = f.title.create_action() else {
    // rust: panic!()
}
    // rust: assert_eq!(
    // rust: options.world_gen(),
    // rust: crate::save::WorldGen {
    // rust: preset: crate::save::WorldPreset::Amplified,
    // rust: structures: true,
    // rust: bonus_chest: true
}
    // rust: );
    // The More tab: Game Rules, Experiments and Data Packs all open; Data
    // Packs opens on a new pack folder, and its selection reaches the action.
    // rust: f.title.click(54.0 + 248.0 + 10.0, 10.0, size);
    // rust: let more = labels(&f);
    // rust: assert_eq!(
    // rust: more[..3].iter().map(|b| b.3).collect::<Vec<_>>(),
    // rust: [true, true, true]
    // rust: );
    // rust: let (action, sound) = f.title.click(more[2].1 + 10.0, more[2].2 + 10.0, size);
    // rust: let Action::DataPacks { dir, selected } = action else {
    // rust: panic!("{action:?}")
}
    // rust: assert!(sound && dir.is_dir() && selected == ["vanilla"]);
    // rust: f.title
    // rust: .set_data_packs(vec!["vanilla".into(), "file/ttm.zip".into()]);
    // rust: let Action::Create { options, .. } = f.title.create_action() else {
    // rust: panic!()
}
    // rust: assert_eq!(options.data_packs, ["vanilla", "file/ttm.zip"]);
    // rust: assert_eq!(options.pack_dir.as_ref(), Some(&dir));
    // Cancel removes the folder (removeTempDataPackDir).
    // rust: f.title.escape();
    // rust: assert!(!dir.exists());
}

pub fn ctrl_digits_and_ctrl_tab_switch_the_create_world_tabs() void {
}
//     use winit::keyboard::KeyCode;
    // rust: let mut f = Fixture::new();
    // rust: f.click("Singleplayer");
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));
    // rust: let shown = |f: &Fixture| -> (usize, u8) {
    // rust: let Mode::Create { focus, options, .. } = &f.title.mode else {
    // rust: panic!("the Create World screen")
}
    // rust: (options.tab, *focus)
}
    // The screen opens on the Game tab with the name box focused.
    // rust: assert_eq!(shown(&f), (0, 0));
    // `TabNavigationBar.getNextTabIndex`: a digit is floorMod(key - 1, 10), so
    // Ctrl+2 is the World tab, Ctrl+3 the More tab. The tab's fields are new
    // widgets, so the name box that had the keys gives them up.
    // rust: assert_eq!(
    // rust: f.title.tab_bar_key(KeyCode::Digit2, true, false),
    // rust: Some(true)
    // rust: );
    // rust: assert_eq!(shown(&f), (1, 2));
    // rust: assert_eq!(
    // rust: f.title.tab_bar_key(KeyCode::Numpad3, true, false),
    // rust: Some(true)
    // rust: );
    // rust: assert_eq!(shown(&f), (2, 2));
    // The same tab again changes nothing and plays no click sound.
    // rust: assert_eq!(
    // rust: f.title.tab_bar_key(KeyCode::Digit3, true, false),
    // rust: Some(false)
    // rust: );
    // Ctrl+4..9 and Ctrl+0 ask for tabs past the third: Mth.clamp keeps the
    // last tab, and none of them moves or sounds.
    // rust: for key in [KeyCode::Digit4, KeyCode::Digit9, KeyCode::Digit0] {
    // rust: assert_eq!(f.title.tab_bar_key(key, true, false), Some(false));
    // rust: assert_eq!(shown(&f).0, 2);
}
    // Ctrl+Tab steps one tab forward and Ctrl+Shift+Tab one back, wrapping.
    // rust: assert_eq!(
    // rust: f.title.tab_bar_key(KeyCode::Digit1, true, false),
    // rust: Some(true)
    // rust: );
    // rust: assert_eq!(shown(&f).0, 0);
    // rust: assert_eq!(f.title.tab_bar_key(KeyCode::Tab, true, false), Some(true));
    // rust: assert_eq!(shown(&f).0, 1);
    // rust: assert_eq!(f.title.tab_bar_key(KeyCode::Tab, true, true), Some(true));
    // rust: assert_eq!(shown(&f).0, 0);
    // rust: assert_eq!(f.title.tab_bar_key(KeyCode::Tab, true, true), Some(true));
    // rust: assert_eq!(shown(&f).0, 2);
    // Without Ctrl the bar leaves the key alone, so the digit still types.
    // rust: assert_eq!(f.title.tab_bar_key(KeyCode::Digit2, false, false), None);
    // rust: assert_eq!(shown(&f).0, 2);
    // Only the Create World screen has a tab bar under these keys.
    // rust: f.click("Cancel");
    // rust: assert!(matches!(f.title.mode, Mode::Main));
    // rust: assert_eq!(f.title.tab_bar_key(KeyCode::Digit2, true, false), None);
}

pub fn new_world_generation_settings_round_trip() void {
}
    // rust: let f = Fixture::new();
    // rust: let dir = f.root.join("flat");
    // rust: let options = crate::save::WorldGen {
    // rust: preset: crate::save::WorldPreset::Flat,
    // rust: structures: false,
    // rust: bonus_chest: true,
}
    // rust: crate::save::write_world_gen_settings(&dir, 42, options).unwrap();
    // rust: assert_eq!(crate::save::WorldGen::read(&dir), Some(options));
    // rust: let settings = crate::save::world_gen_settings(&dir).unwrap();
    // rust: let generator = settings
    // rust: .get("dimensions")
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: .and_then(|o| o.get("generator"));
    // rust: assert_eq!(
    // rust: crate::save::text(generator.and_then(|g| g.get("type"))).as_deref(),
    // rust: Some("minecraft:flat")
    // rust: );
}

pub fn each_world_preset_writes_its_own_generator() void {
}
    // rust: let f = Fixture::new();
    // rust: let generator = |preset: crate::save::WorldPreset| {
        // A folder per preset; Windows refuses the `:` of the id in a name.
    // rust: let dir = f.root.join(preset.id().replace(':', "_"));
    // rust: let options = crate::save::WorldGen {
    // rust: preset,
    // rust: structures: true,
    // rust: bonus_chest: false,
}
    // rust: crate::save::write_world_gen_settings(&dir, 42, options).unwrap();
    // rust: assert_eq!(crate::save::WorldGen::read(&dir), Some(options));
    // rust: let settings = crate::save::world_gen_settings(&dir).unwrap();
    // rust: let generator = settings
    // rust: .get("dimensions")
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: .and_then(|o| o.get("generator"))
    // rust: .cloned()
    // rust: .unwrap();
    // rust: (
    // rust: crate::save::text(generator.get("type")),
    // rust: crate::save::text(generator.get("settings")),
    // rust: crate::save::text(generator.get("biome_source").and_then(|s| s.get("type"))),
    // rust: )
}
    // rust: assert_eq!(
    // rust: generator(crate::save::WorldPreset::Normal),
    // rust: (
    // rust: Some("minecraft:noise".to_owned()),
    // rust: Some("minecraft:overworld".to_owned()),
    // rust: Some("minecraft:multi_noise".to_owned()),
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: generator(crate::save::WorldPreset::Amplified),
    // rust: (
    // rust: Some("minecraft:noise".to_owned()),
    // rust: Some("minecraft:amplified".to_owned()),
    // rust: Some("minecraft:multi_noise".to_owned()),
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: generator(crate::save::WorldPreset::LargeBiomes),
    // rust: (
    // rust: Some("minecraft:noise".to_owned()),
    // rust: Some("minecraft:large_biomes".to_owned()),
    // rust: Some("minecraft:multi_noise".to_owned()),
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: generator(crate::save::WorldPreset::SingleBiomeSurface),
    // rust: (
    // rust: Some("minecraft:noise".to_owned()),
    // rust: Some("minecraft:overworld".to_owned()),
    // rust: Some("minecraft:fixed".to_owned()),
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: generator(crate::save::WorldPreset::Flat).0,
    // rust: Some("minecraft:flat".to_owned())
    // rust: );
}

pub fn world_fields_edit_at_their_cursor() void {
}
//     use winit::keyboard::KeyCode;
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.title.enter_singleplayer();
    // The search box takes the focus.
    // rust: f.title.click(240.0, 30.0, (480.0, 262.0));
    // rust: f.title.type_text("hello world");
    // rust: for _ in 0..5 {
    // rust: assert!(f.title.field_key(KeyCode::ArrowLeft, false, false));
}
    // rust: f.title.type_text("X");
    // rust: assert_eq!(f.title.search, "hello Xworld");
    // Shift+Home selects back to the start; typing replaces the selection.
    // rust: f.title.field_key(KeyCode::Home, false, true);
    // rust: f.title.type_text("Y");
    // rust: assert_eq!(f.title.search, "Yworld");
    // Ctrl+Left jumps a word; Backspace deletes before the cursor.
    // rust: f.title.field_key(KeyCode::ArrowLeft, true, false);
    // rust: f.title.field_key(KeyCode::ArrowRight, false, false);
    // rust: f.title.field_key(KeyCode::Backspace, false, false);
    // rust: assert_eq!(f.title.search, "world");
}

/// `ManageServerScreen`'s focus order: the name, the address, the Server
/// Resource Packs button, Done, Cancel, then the name again.
pub fn tab_walks_the_edit_server_screen_through_its_buttons() void {
}
//     use crate::multiplayer::Screen;
    // rust: let size = (854.0, 480.0);
    // rust: let mut f = Fixture::new();
    // rust: f.title.mode = Mode::Multiplayer(Screen::Edit {
    // rust: index: None,
    // rust: name: "Minecraft Server".into(),
    // rust: address: "localhost".into(),
    // rust: focus: 0,
    // rust: packs: None,
    // rust: });
    // rust: let focus = |f: &Fixture| match &f.title.mode {
    // rust: Mode::Multiplayer(Screen::Edit { focus, .. }) => (*focus, f.title.focused_button),
    // rust: _ => panic!("edit"),
}
    // rust: let mut seen = Vec::new();
    // rust: for _ in 0..5 {
    // rust: f.title.tab_dir(false, size);
    // rust: seen.push(focus(&f));
}
    // Address, then packs (60), Done (50), Cancel (51), and round to the name.
    // rust: assert_eq!(
    // rust: seen,
    // rust: [
    // rust: (1, None),
    // rust: (2, Some(60)),
    // rust: (2, Some(50)),
    // rust: (2, Some(51)),
    // rust: (0, None)
    // rust: ]
    // rust: );
    // A button has the focus: typing goes nowhere.
    // rust: f.title.tab_dir(true, size);
    // rust: assert_eq!(focus(&f), (2, Some(51)));
    // rust: f.title.type_text("x");
    // rust: let Mode::Multiplayer(Screen::Edit { name, address, .. }) = &f.title.mode else {
    // rust: panic!("edit");
}
    // rust: assert_eq!(
    // rust: (name.as_str(), address.as_str()),
    // rust: ("Minecraft Server", "localhost")
    // rust: );
}

pub fn server_fields_edit_at_their_cursor() void {
}
//     use winit::keyboard::KeyCode;
    // rust: let mut f = Fixture::new();
    // rust: f.title.mode = Mode::Multiplayer(crate::multiplayer::Screen::Edit {
    // rust: index: None,
    // rust: name: "Minecraft Server".into(),
    // rust: address: String::new(),
    // rust: focus: 1,
    // rust: packs: None,
    // rust: });
    // rust: f.title.type_text("localhost");
    // rust: for _ in 0..4 {
    // rust: assert!(f.title.field_key(KeyCode::ArrowLeft, false, false));
}
    // rust: f.title.type_text("X");
    // rust: let Mode::Multiplayer(crate::multiplayer::Screen::Edit { address, .. }) = &f.title.mode else {
    // rust: panic!("add server");
}
    // rust: assert_eq!(address, "localXhost");
    // Shift+Home selects back to the start; typing replaces the selection.
    // rust: f.title.field_key(KeyCode::Home, false, true);
    // rust: f.title.type_text("Y");
    // rust: let Mode::Multiplayer(crate::multiplayer::Screen::Edit { address, .. }) = &f.title.mode else {
    // rust: panic!("add server");
}
    // rust: assert_eq!(address, "Yhost");
    // Shift+Tab moves back to the name, which edits at its own cursor.
    // rust: f.title.tab_dir(true, (854.0, 480.0));
    // rust: f.title.field_key(KeyCode::ArrowLeft, false, false);
    // rust: f.title.type_text("X");
    // rust: let Mode::Multiplayer(crate::multiplayer::Screen::Edit { name, .. }) = &f.title.mode else {
    // rust: panic!("add server");
}
    // rust: assert_eq!(name, "Minecraft ServeXr");
    // rust: f.title.mode = Mode::Multiplayer(crate::multiplayer::Screen::Direct {
    // rust: address: String::new(),
    // rust: });
    // rust: f.title.type_text("one two");
    // Ctrl+Backspace deletes the word before the caret.
    // rust: f.title.field_key(KeyCode::Backspace, true, false);
    // rust: let Mode::Multiplayer(crate::multiplayer::Screen::Direct { address }) = &f.title.mode else {
    // rust: panic!("direct");
}
    // rust: assert_eq!(address, "one ");
}
pub fn world_list_names_every_game_mode_and_hardcore_in_red() void {
}
    // rust: let f = Fixture::new();
    // rust: f.world("Creative", "Creative");
    // rust: let level = |folder: &str, game_type: i32, hardcore: bool| {
    // rust: crate::save::write_dat(
    // rust: &f.title.saves.join(folder).join("level.dat"),
    // rust: Tag::compound([(
    // rust: "Data",
    // rust: Tag::compound([
    // rust: ("LevelName", Tag::String(folder.into())),
    // rust: ("GameType", Tag::Int(game_type)),
    // rust: (
    // rust: "difficulty_settings",
    // rust: Tag::compound([
    // rust: ("difficulty", Tag::String("hard".into())),
    // rust: ("hardcore", Tag::Byte(i8::from(hardcore))),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "Version",
    // rust: Tag::compound([("Name", Tag::String("26.3".into()))]),
    // rust: ),
    // rust: ]),
    // rust: )]),
    // rust: )
    // rust: .unwrap();
}
    // rust: level("Hardcore", 0, true);
    // rust: level("Adventure", 2, false);
    // rust: level("Spectator", 3, false);
    // rust: let worlds = list_worlds(&f.title.saves);
    // rust: let info = |folder: &str| world_info(worlds.iter().find(|w| w.folder == folder).unwrap());

    // rust: let hardcore = info("Hardcore");
    // rust: assert_eq!(hardcore.plain(), "Hardcore Mode, Version: 26.3");
    // rust: assert_eq!(hardcore.spans[0].text, "Hardcore Mode");
    // rust: assert_eq!(hardcore.spans[0].style.color, Some(0xFF0000));
    // rust: assert!(hardcore.spans[1..].iter().all(|s| s.style.color.is_none()));
    // rust: assert_eq!(info("Adventure").plain(), "Adventure Mode, Version: 26.3");
    // rust: assert_eq!(info("Spectator").plain(), "Spectator Mode, Version: 26.3");
    // rust: let creative = info("Creative");
    // rust: assert_eq!(creative.plain(), "Creative Mode, Commands, Version: 26.3");
    // rust: assert!(creative.spans.iter().all(|s| s.style.color.is_none()));
}

pub fn world_with_unreadable_level_dat_stays_in_the_world_list() void {
}
    // rust: let f = Fixture::new();
    // rust: f.world("Broken", "My World");
    // rust: f.world("Broken", "My World");
    // rust: fs::write(f.title.saves.join("Broken/level.dat"), b"truncated").unwrap();
    // A folder with only level.dat_old is a world too (findLevelCandidates).
    // rust: f.world("Old only", "Old only");
    // rust: f.world("Old only", "Old only");
    // rust: fs::remove_file(f.title.saves.join("Old only/level.dat")).unwrap();
    // rust: let mut listed: Vec<String> = list_worlds(&f.title.saves)
    // rust: .into_iter()
    // rust: .map(|w| w.folder)
    // rust: .collect();
    // rust: listed.sort();
    // rust: assert_eq!(listed, ["Broken", "Old only"]);
}

pub fn world_with_unreadable_level_dat_is_listed_and_recovers_from_level_dat_old() void {
}
    // rust: let mut f = Fixture::new();
    // A second save keeps the first level.dat as level.dat_old; then level.dat
    // is cut short, as a crash in the middle of a save leaves it.
    // rust: f.world("Broken", "My World");
    // rust: f.world("Broken", "My World");
    // rust: let dir = f.title.saves.join("Broken");
    // rust: fs::write(dir.join("level.dat"), b"truncated").unwrap();

    // LevelStorageSource.readLevelSummary: a CorruptedLevelSummary, still listed.
    // rust: let worlds = list_worlds(&f.title.saves);
    // rust: let broken = worlds
    // rust: .iter()
    // rust: .find(|w| w.folder == "Broken")
    // rust: .expect("a world whose level.dat does not read stays in the list");
    // rust: assert!(broken.corrupted);
    // rust: assert_eq!(broken.name, "Broken");
    // rust: let info = world_info(broken);
    // rust: assert_eq!(info.plain(), "Failed to load world summary");
    // rust: assert_eq!(info.spans[0].style.color, Some(0xFF0000));

    // rust: f.select();
    // rust: let buttons = f.title.buttons(480.0, 262.0);
    // rust: let enabled = |label: &str| buttons.iter().find(|b| b.label == label).unwrap().enabled;
    // rust: assert!(enabled("Attempt to Recover"));
    // rust: assert!(!enabled("Edit") && !enabled("Re-Create") && enabled("Delete"));

    // Its primary action opens RecoverWorldDataScreen, not the world.
    // rust: assert_eq!(f.click("Attempt to Recover"), Action::None);
    // rust: let Mode::Recover { issues, .. } = &f.title.mode else {
    // rust: panic!("expected the recovery screen, got {:?}", f.title.mode);
}
    // rust: assert!(matches!(
    // rust: issues[0],
    // rust: Some(crate::save::DatIssue::Unreadable(_))
    // rust: ));
    // rust: assert_eq!(issues[1], None);
    // rust: assert_eq!(fs::read(dir.join("level.dat")).unwrap(), b"truncated");

    // attemptRestore backs the world up first, then restoreLevelDataFromOld: level.dat_old
    // back in place, the broken file kept aside.
    // rust: f.click("Attempt to Restore");
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // rust: f.finish_backup();
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::Recovered { success: true, .. }
    // rust: ));
    // rust: assert_eq!(Level::read_summary(&dir).unwrap().name, "My World");
    // rust: assert!(!dir.join("level.dat_old").exists());
    // rust: let kept: Vec<_> = fs::read_dir(&dir)
    // rust: .unwrap()
    // rust: .flatten()
    // rust: .filter(|e| {
    // rust: e.file_name()
    // rust: .to_string_lossy()
    // rust: .starts_with("level.dat_corrupted_")
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(kept.len(), 1);
    // rust: assert_eq!(fs::read(kept[0].path()).unwrap(), b"truncated");
    // rust: assert_eq!(
    // rust: f.click("Continue"),
    // rust: Action::Play {
    // rust: folder: "Broken".into()
}
    // rust: );
    // rust: assert!(!list_worlds(&f.title.saves)[0].corrupted);
}

pub fn world_with_nothing_to_recover_from_is_listed_but_never_opened() void {
}
    // rust: let mut f = Fixture::new();
    // rust: let dir = f.title.saves.join("Lost");
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: fs::write(dir.join("level.dat"), b"garbage").unwrap();
    // A folder without level.dat or level.dat_old is no world (findLevelCandidates).
    // rust: fs::create_dir_all(f.title.saves.join("Not a world")).unwrap();
    // rust: let worlds = list_worlds(&f.title.saves);
    // rust: assert_eq!(worlds.len(), 1);
    // rust: assert!(worlds[0].corrupted);

    // rust: f.select();
    // rust: f.click("Attempt to Recover");
    // rust: let Mode::Recover { issues, .. } = &f.title.mode else {
    // rust: panic!("expected the recovery screen, got {:?}", f.title.mode);
}
    // rust: assert_eq!(issues[1], Some(crate::save::DatIssue::Missing));
    // rust: let restore = f
    // rust: .title
    // rust: .buttons(480.0, 262.0)
    // rust: .into_iter()
    // rust: .find(|b| b.label == "Attempt to Restore")
    // rust: .unwrap();
    // rust: assert!(!restore.enabled);
    // Pressed anyway, attemptRestore fails without touching the files.
    // rust: f.title.attempt_restore(worlds[0].clone());
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::Recovered { success: false, .. }
    // rust: ));
    // rust: assert_eq!(fs::read(dir.join("level.dat")).unwrap(), b"garbage");
    // rust: f.click("Back");
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
}

pub fn title_screen_keyboard_navigation_and_activation() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("w1", "World 1");
    // rust: let size = (480.0, 262.0);
    // rust: assert_eq!(f.title.focused_button, None);

    // Tab forwards focuses the first button (Singleplayer, id 1)
    // rust: f.title.tab_dir(false, size);
    // rust: assert_eq!(f.title.focused_button, Some(1));

    // Tab again focuses Multiplayer (id 4)
    // rust: f.title.tab_dir(false, size);
    // rust: assert_eq!(f.title.focused_button, Some(4));

    // Shift+Tab reverses focus to Singleplayer
    // rust: f.title.tab_dir(true, size);
    // rust: assert_eq!(f.title.focused_button, Some(1));

    // Enter confirms focused button (Singleplayer opens world select) and triggers sound
    // rust: let (action, sound) = f.title.confirm_key_size(size);
    // rust: assert_eq!(action, Action::None);
    // rust: assert!(sound);
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
    // rust: assert_eq!(f.title.focused_button, None);

    // Navigate to Create New World button (id 11) on the select screen: the
    // "Preparing for world creation" screen comes first, then the create screen.
    // rust: f.title.focused_button = Some(11);
    // rust: let (action, sound) = f.title.confirm_key_size(size);
    // rust: assert_eq!(action, Action::None);
    // rust: assert!(sound);
    // rust: assert!(f.title.preparing());
    // rust: f.title.finish_preparing();
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));

    // Focus and toggle Game Mode cycle button (id 20) from Survival to Hardcore
    // rust: f.title.focused_button = Some(20);
    // rust: let (action, sound) = f.title.confirm_key_size(size);
    // rust: assert_eq!(action, Action::None);
    // rust: assert!(sound);

    // In Hardcore, Difficulty button (id 23) is disabled, so confirming it does not sound
    // rust: f.title.focused_button = Some(23);
    // rust: let (action, sound) = f.title.confirm_key_size(size);
    // rust: assert_eq!(action, Action::None);
    // rust: assert!(!sound);

    // Toggle Game Mode cycle button again (Hardcore to Creative)
    // rust: f.title.focused_button = Some(20);
    // rust: let (action, sound) = f.title.confirm_key_size(size);
    // rust: assert_eq!(action, Action::None);
    // rust: assert!(sound);

    // Now Difficulty button (id 23) is enabled in Creative, so confirming it sounds
    // rust: f.title.focused_button = Some(23);
    // rust: let (action, sound) = f.title.confirm_key_size(size);
    // rust: assert_eq!(action, Action::None);
    // rust: assert!(sound);
}

pub fn mouse_opening_singleplayer_does_not_steal_select_world_enter() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("w1", "World 1");

    // rust: assert_eq!(f.click("Singleplayer"), Action::None);
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
    // rust: assert_eq!(f.title.focused_button, None);

    // Select the row, then press Enter as a keyboard user would.
    // rust: f.title.click(240.0, 60.0, (480.0, 262.0));
    // rust: let (action, sound) = f.title.confirm_key_size((480.0, 262.0));
    // rust: assert_eq!(
    // rust: action,
    // rust: Action::Play {
    // rust: folder: "w1".to_owned()
}
    // rust: );
    // rust: assert!(sound);
}

/// Rewrites a test world's `WorldGenSettings` (in level.dat, where `world_gen_settings` falls back).
pub fn set_world_gen(f: *Fixture, folder: []const u8, change: impl FnOnce(*mut Tag) void {
}
    // rust: let path = f.title.saves.join(folder).join("level.dat");
    // rust: let mut root = crate::save::read_dat(&path).unwrap();
    // rust: change(
    // rust: root.get_mut("Data")
    // rust: .unwrap()
    // rust: .get_mut("WorldGenSettings")
    // rust: .unwrap(),
    // rust: );
    // rust: crate::save::write_dat(&path, root).unwrap();
}

pub fn only_world(f: *Fixture) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let worlds = list_worlds(&f.title.saves);
    // rust: assert_eq!(worlds.len(), 1);
    // rust: worlds[0].clone()
}

pub fn a_stable_world_opens_at_once() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("Plain", "Plain");
    // rust: let world = only_world(&f);
    // rust: assert_eq!(
    // rust: f.title.play(world),
    // rust: Action::Play {
    // rust: folder: "Plain".into()
}
    // rust: );
}

pub fn a_customized_world_asks_for_a_backup_before_it_opens() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("Custom", "Custom");
    // rust: set_world_gen(&f, "Custom", |settings| {
    // rust: if let Tag::Compound(map) = settings {
    // rust: map.insert(
    // rust: "legacy_custom_options".into(),
    // rust: Tag::String("{\"seaLevel\":63}".into()),
    // rust: );
}
    // rust: });
    // rust: let world = only_world(&f);
    // rust: assert_eq!(f.title.play(world), Action::None);
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::BackupBeforeUpgrade {
    // rust: downgrade: None,
    // rust: stem: Some(StemIssue::Customized),
    // rust: ..
}
    // rust: ));
    // BackupConfirmScreen: Create Backup and Load, I Know What I'm Doing!, Cancel.
    // rust: assert_eq!(
    // rust: f.click("I Know What I'm Doing!"),
    // rust: Action::Play {
    // rust: folder: "Custom".into()
}
    // rust: );
}

pub fn an_experimental_world_is_backed_up_then_opened_without_asking_again() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("Exp", "Exp");
    // rust: set_world_gen(&f, "Exp", |settings| {
    // rust: let nether = Tag::compound([
    // rust: ("type", Tag::String("minecraft:the_nether".into())),
    // rust: (
    // rust: "generator",
    // rust: Tag::compound([
    // rust: ("type", Tag::String("minecraft:noise".into())),
    // rust: ("settings", Tag::String("minecraft:nether".into())),
    // rust: (
    // rust: "biome_source",
    // rust: Tag::compound([("type", Tag::String("minecraft:fixed".into()))]),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let overworld = Tag::compound([("type", Tag::String("minecraft:overworld".into()))]);
    // rust: let end = Tag::compound([
    // rust: ("type", Tag::String("minecraft:the_end".into())),
    // rust: (
    // rust: "generator",
    // rust: Tag::compound([
    // rust: ("type", Tag::String("minecraft:noise".into())),
    // rust: ("settings", Tag::String("minecraft:end".into())),
    // rust: (
    // rust: "biome_source",
    // rust: Tag::compound([("type", Tag::String("minecraft:the_end".into()))]),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: if let Tag::Compound(map) = settings {
    // rust: map.insert(
    // rust: "dimensions".into(),
    // rust: Tag::compound([
    // rust: ("minecraft:overworld", overworld),
    // rust: ("minecraft:the_nether", nether),
    // rust: ("minecraft:the_end", end),
    // rust: ]),
    // rust: );
}
    // rust: });
    // rust: let world = only_world(&f);
    // rust: assert_eq!(f.title.play(world), Action::None);
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::BackupBeforeUpgrade {
    // rust: stem: Some(StemIssue::Experimental),
    // rust: ..
}
    // rust: ));
    // rust: f.click("Create Backup and Load");
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // rust: f.finish_backup();
    // The backup was the question's answer: the world opens next.
    // rust: assert_eq!(f.title.take_open_request().as_deref(), Some("Exp"));
    // rust: assert_eq!(fs::read_dir(f.root.join("backups")).unwrap().count(), 1);
}

pub fn low_disk_space_asks_to_continue_or_go_back() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("Tight", "Tight");
    // rust: let world = only_world(&f);
    // rust: f.title.mode = Mode::LowDiskSpace {
    // rust: world: world.clone(),
}
    // rust: let labels: Vec<String> = f
    // rust: .title
    // rust: .buttons(480.0, 262.0)
    // rust: .into_iter()
    // rust: .map(|b| b.label)
    // rust: .collect();
    // rust: assert_eq!(labels, ["Continue", "Back"]);
    // rust: assert_eq!(f.click("Back"), Action::None);
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
    // rust: f.title.mode = Mode::LowDiskSpace { world };
    // rust: assert_eq!(
    // rust: f.click("Continue"),
    // rust: Action::Play {
    // rust: folder: "Tight".into()
}
    // rust: );
}

pub fn a_world_opened_by_name_with_unreadable_level_data_shows_the_recovery_screen() void {
}
    // rust: let mut f = Fixture::new();
    // No such world yet: it opens (and is made) as usual.
    // rust: assert!(!f.title.open_recover("Fresh"));
    // rust: f.world("Fine", "Fine");
    // rust: assert!(!f.title.open_recover("Fine"));
    // rust: assert!(matches!(f.title.mode, Mode::Main));
    // rust: f.world("Broken", "Broken");
    // rust: f.world("Broken", "Broken");
    // rust: fs::write(f.title.saves.join("Broken/level.dat"), b"truncated").unwrap();
    // rust: assert!(f.title.open_recover("Broken"));
    // rust: let Mode::Recover { world, issues } = &f.title.mode else {
    // rust: panic!("expected the recovery screen, got {:?}", f.title.mode);
}
    // rust: assert_eq!(world.folder, "Broken");
    // rust: assert!(matches!(
    // rust: issues[0],
    // rust: Some(crate::save::DatIssue::Unreadable(_))
    // rust: ));
    // rust: assert_eq!(issues[1], None);
}

pub fn old_entity_chunk(f: *Fixture, folder: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_world::{
    // rust: compression::Compression,
    // rust: nbt::{Limits, NamedTag},
    // rust: region::{ChunkRecord, RegionFile},
}
    // rust: let file = f
    // rust: .title
    // rust: .saves
    // rust: .join(folder)
    // rust: .join("dimensions/minecraft/overworld/entities/r.0.0.mca");
    // rust: fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: let tag = Tag::compound([
    // rust: ("DataVersion", Tag::Int(4000)),
    // rust: ("Position", Tag::IntArray(vec![0, 0])),
    // rust: ("Entities", Tag::List(vec![])),
    // rust: ]);
    // rust: let record = ChunkRecord::from_nbt(
    // rust: &NamedTag {
    // rust: name: "".into(),
    // rust: tag,
    // rust: },
    // rust: Compression::Zlib,
    // rust: 1,
    // rust: Limits::default(),
    // rust: )
    // rust: .unwrap();
    // rust: RegionFile::open_writable(&file, true)
    // rust: .unwrap()
    // rust: .write(horizon_core::position::ChunkPos::new(0, 0), &record)
    // rust: .unwrap();
    // rust: file
}

pub fn chunk_version(file: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_world::{nbt::Limits, region::RegionFile};
    // rust: let record = RegionFile::open(file)
    // rust: .unwrap()
    // rust: .read(horizon_core::position::ChunkPos::new(0, 0))
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: let root = record.nbt(Limits::default()).unwrap();
    // rust: match root.tag.get("DataVersion") {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => -1,
}
}

pub fn wait_while_optimizing(f: *mut Fixture) void {
}
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(10);
    // rust: while matches!(f.title.mode, Mode::Optimize { .. }) {
    // rust: assert!(std::time::Instant::now() < deadline);
    // rust: std::thread::sleep(std::time::Duration::from_millis(10));
    // rust: f.title.poll_backup();
}
}

pub fn optimize_question_cancel_returns_to_the_edit_screen_with_its_name() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: let Mode::Edit { name, .. } = &mut f.title.mode else {
    // rust: panic!("edit screen")
}
    // rust: *name = "Typed".into();
    // rust: f.click("Optimize World");
    // rust: let buttons = f.title.buttons(480.0, 262.0);
    // rust: assert_eq!(
    // rust: buttons.iter().map(|b| b.label.as_str()).collect::<Vec<_>>(),
    // rust: [
    // rust: "Create Backup and Optimize",
    // rust: "I Know What I'm Doing!",
    // rust: "Cancel"
    // rust: ]
    // rust: );
    // rust: f.title.message_lines.set(3);
    // BackupConfirmScreen.init: 100 + (3 + 1) * 9 under the text.
    // rust: assert_eq!(f.title.buttons(480.0, 262.0)[0].y, 136.0);
    // rust: f.click("Cancel");
    // rust: let Mode::Edit { name, .. } = &f.title.mode else {
    // rust: panic!("edit screen")
}
    // rust: assert_eq!(name, "Typed");
}

pub fn optimizing_without_a_backup_upgrades_chunks_and_returns_to_the_list() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let file = old_entity_chunk(&f, "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.click("Optimize World");
    // rust: f.title.erase_check.set([100.0, 50.0, 100.0, 17.0]);
    // rust: assert_eq!(
    // rust: f.title.click(110.0, 55.0, (480.0, 262.0)),
    // rust: (Action::None, true)
    // rust: );
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::OptimizeConfirm {
    // rust: erase_cache: true,
    // rust: ..
}
    // rust: ));
    // rust: f.click("I Know What I'm Doing!");
    // rust: assert!(matches!(f.title.mode, Mode::Optimize { .. }));
    // Nothing but a press stops it: no pad button either.
    // rust: assert!(
    // rust: f.title
    // rust: .buttons(427.0, 240.0)
    // rust: .iter()
    // rust: .all(|b| b.action.is_none())
    // rust: );
    // OptimizeWorldScreen ignores Escape.
    // rust: f.title.escape();
    // rust: wait_while_optimizing(&mut f);
    // rust: assert!(matches!(
    // rust: f.title.mode,
    // rust: Mode::Select {
    // rust: selected: Some(0),
    // rust: ..
}
    // rust: ));
    // rust: assert!(f.title.optimize.is_none());
    // rust: assert_eq!(chunk_version(&file), horizon_world::DATA_VERSION);
}

pub fn optimizing_after_a_backup_starts_when_the_backup_is_done() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let file = old_entity_chunk(&f, "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.click("Optimize World");
    // rust: f.click("Create Backup and Optimize");
    // rust: assert!(matches!(f.title.mode, Mode::Backup { .. }));
    // rust: f.finish_backup();
    // rust: assert!(matches!(f.title.mode, Mode::Optimize { .. }));
    // rust: assert!(f.title.toast.is_some());
    // rust: wait_while_optimizing(&mut f);
    // rust: assert_eq!(chunk_version(&file), horizon_world::DATA_VERSION);
}

pub fn cancel_stops_the_optimization() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.click("Optimize World");
    // rust: f.click("I Know What I'm Doing!");
    // rust: assert!(matches!(f.title.mode, Mode::Optimize { .. }));
    // rust: assert_eq!(f.title.buttons(480.0, 262.0)[0].y, 65.0 + 150.0);
    // rust: f.click("Cancel");
    // rust: assert!(matches!(f.title.mode, Mode::Select { .. }));
    // rust: assert!(f.title.optimize.is_none());
}

pub fn a_world_that_needs_file_fixing_cannot_be_optimized() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let path = f.title.saves.join("World/level.dat");
    // rust: f.select();
    // rust: f.click("Edit");
    // SelectWorldScreen only enables Edit for a world that needs no file
    // fixing (`LevelSummary.canEdit`), so the data goes stale while the
    // edit screen is open.
    // rust: let mut root = crate::save::read_dat(&path).unwrap();
    // rust: if let Some(Tag::Compound(data)) = root.get_mut("Data") {
    // rust: data.insert("DataVersion".into(), Tag::Int(3000));
}
    // rust: crate::save::write_dat(&path, root).unwrap();
    // rust: f.click("Optimize World");
    // rust: f.click("I Know What I'm Doing!");
    // `OptimizeWorldScreen.create` returns null: `setScreen(null)`.
    // rust: assert!(matches!(f.title.mode, Mode::Main));
    // rust: assert!(f.title.optimize.is_none());
}

pub fn a_finished_optimization_stamps_the_level_data() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.world("World", "World");
    // rust: let path = f.title.saves.join("World/level.dat");
    // rust: let mut root = crate::save::read_dat(&path).unwrap();
    // rust: if let Some(Tag::Compound(data)) = root.get_mut("Data") {
    // rust: data.insert("DataVersion".into(), Tag::Int(4950));
}
    // rust: crate::save::write_dat(&path, root).unwrap();
    // rust: f.select();
    // rust: f.click("Edit");
    // rust: f.click("Optimize World");
    // rust: f.click("I Know What I'm Doing!");
    // rust: wait_while_optimizing(&mut f);
    // rust: let root = crate::save::read_dat(&path).unwrap();
    // rust: let version = root.get("Data").and_then(|d| d.get("DataVersion"));
    // rust: assert!(matches!(version, Some(Tag::Int(v)) if *v == horizon_world::DATA_VERSION));
}

/// `AbstractButton.extractDefaultLabel`: a label too wide for its button is
/// slid inside it, not drawn centred over the buttons beside it (`so_so`'s
/// 590 px World Type label on Create World, `hi_in`'s Join Server).
pub fn a_button_label_wider_than_its_button_stays_inside_it() void {
}
    // rust: let atlas = HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let mut b = Button {
    // rust: x: 100.0,
    // rust: y: 40.0,
    // rust: w: 100.0,
    // rust: label: "Create Backup and Load the World Anyway".into(),
    // rust: enabled: true,
    // rust: id: 40,
    // rust: icon: None,
    // rust: trailing: None,
    // rust: action: None,
}
    // rust: assert!(HudBatch::text_width(&atlas, &b.label) > b.w - 4.0);
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: b.draw_label(&mut batch, &atlas, u32::MAX);
    // rust: assert!(!batch.vertices.is_empty());
    // rust: for v in &batch.vertices {
    // rust: assert!(
    // rust: (b.x + 2.0..=b.x + b.w - 2.0).contains(&v.pos[0])
    // rust: && (b.y..=b.y + 20.0).contains(&v.pos[1]),
    // rust: "label vertex {:?} outside the button",
    // rust: v.pos
    // rust: );
}
    // A label that fits is centred in the button, as `centered_left` does.
    // rust: b.label = "Done".into();
    // rust: let width = HudBatch::text_width(&atlas, &b.label);
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: b.draw_label(&mut batch, &atlas, u32::MAX);
    // rust: let lo = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[0])
    // rust: .fold(f32::INFINITY, f32::min);
    // rust: assert!(
    // rust: (lo - (b.x + 2.0 + (b.w - 4.0) / 2.0 - (width / 2.0).floor())).abs() < 0.001,
    // rust: "a fitting label starts at {lo}"
    // rust: );
}

pub fn the_single_biome_preset_is_customized_into_the_generator() void {
}
    // rust: let mut f = Fixture::new();
    // rust: fs::create_dir_all(f.root.join("worldgen")).unwrap();
    // rust: fs::write(
    // rust: f.root.join("worldgen/biomes.json"),
    // rust: r#"{"minecraft:jungle":{},"minecraft:plains":{},"minecraft:badlands":{}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: f.click("Singleplayer");
    // rust: let size = (480.0, 262.0);
    // rust: let labels = |f: &Fixture| -> Vec<(String, f32, f32, bool)> {
    // rust: f.title
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .map(|b| (b.label, b.x, b.y, b.enabled))
    // rust: .collect()
}
    // The World tab: World Type and Customize (PresetEditor.EDITORS has a
    // screen for the flat and the single-biome presets only).
    // rust: f.title.click(54.0 + 124.0 + 10.0, 10.0, size);
    // rust: let world = labels(&f);
    // rust: let customize = world[1].clone();
    // rust: assert!(!customize.3);
    // rust: let cycle = (world[0].1 + 10.0, world[0].2 + 10.0);
    // rust: f.title.click(cycle.0, cycle.1, size);
    // rust: assert!(labels(&f)[1].3, "flat worlds have CreateFlatWorldScreen");
    // rust: for _ in 0..3 {
    // rust: f.title.click(cycle.0, cycle.1, size);
}
    // rust: let Mode::Create { options, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: assert_eq!(
    // rust: options.world_type,
    // rust: crate::save::WorldPreset::SingleBiomeSurface
    // rust: );
    // rust: assert!(labels(&f)[1].3, "single biome has CreateBuffetWorldScreen");
    // Customize opens the biome screen over the worlds' registry data.
    // rust: let (action, sound) = f.title.click(customize.1 + 10.0, customize.2 + 10.0, size);
    // rust: assert!(sound && action == Action::None);
    // rust: let Mode::CreateBuffet { buffet, .. } = &f.title.mode else {
    // rust: panic!("{:?}", f.title.mode)
}
    // Badlands, Jungle and Plains, by name; the preset's own biome is picked.
    // rust: assert_eq!(buffet.rows().len(), 3);
    // rust: assert_eq!(buffet.selected(), Some(2));
    // A press on the list's second row (rows are 20 high from y 40).
    // rust: f.title.click(240.0, 70.0, size);
    // rust: let Mode::CreateBuffet { buffet, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: assert_eq!(buffet.biome, "minecraft:jungle");
    // Done hands it back to Create New World, which writes it as the
    // overworld's fixed biome source.
    // rust: let done = f
    // rust: .title
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .find(|b| b.id == 80)
    // rust: .unwrap();
    // rust: assert!(done.enabled);
    // rust: f.title.click(done.x + 10.0, done.y + 10.0, size);
    // rust: let Mode::Create { options, .. } = &f.title.mode else {
    // rust: panic!("{:?}", f.title.mode)
}
    // rust: assert_eq!(options.single_biome, "minecraft:jungle");
    // rust: let Action::Create { options, .. } = f.title.create_action() else {
    // rust: panic!()
}
    // rust: let dir = f.root.join("single_biome");
    // rust: crate::save::write_world_gen_settings_with(
    // rust: &dir,
    // rust: 1,
    // rust: options.world_gen(),
    // rust: None,
    // rust: options.single_biome(),
    // rust: )
    // rust: .unwrap();
    // rust: let settings = crate::save::world_gen_settings(&dir).unwrap();
    // rust: let generator = settings
    // rust: .get("dimensions")
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: .and_then(|o| o.get("generator"))
    // rust: .cloned()
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: crate::save::text(generator.get("biome_source").and_then(|s| s.get("biome"))),
    // rust: Some("minecraft:jungle".to_owned())
    // rust: );
    // rust: assert_eq!(
    // rust: crate::save::WorldGen::read(&dir).map(|g| g.preset),
    // rust: Some(crate::save::WorldPreset::SingleBiomeSurface)
    // rust: );
    // Re-Create starts the screen on the world's own biome.
    // rust: let options = WorldOptions::of_world(
    // rust: &crate::save::Level::read(&dir).unwrap_or_default(),
    // rust: false,
    // rust: &dir,
    // rust: );
    // rust: assert_eq!(options.single_biome, "minecraft:jungle");
}

pub fn the_single_biome_screen_cancels_and_filters_without_choosing() void {
}
    // rust: let mut f = Fixture::new();
    // rust: fs::create_dir_all(f.root.join("worldgen")).unwrap();
    // rust: fs::write(
    // rust: f.root.join("worldgen/biomes.json"),
    // rust: r#"{"minecraft:jungle":{},"minecraft:plains":{},"minecraft:badlands":{}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: f.click("Singleplayer");
    // rust: let size = (480.0, 262.0);
    // rust: f.title.click(54.0 + 124.0 + 10.0, 10.0, size);
    // rust: let cycle = (labels_at(&f).0, labels_at(&f).1 + 10.0);
    // rust: for _ in 0..4 {
    // rust: f.title.click(cycle.0, cycle.1, size);
}
    // rust: let customize = labels_at(&f).2;
    // rust: f.title.click(customize.0, customize.1, size);
    // The search box narrows the rows, and a query that hides the chosen
    // biome leaves Done disabled until a row is picked.
    // rust: f.title.click(240.0, 32.0, size);
    // rust: f.title.type_text("jung");
    // rust: let Mode::CreateBuffet { buffet, .. } = &f.title.mode else {
    // rust: panic!()
}
    // rust: assert_eq!(buffet.rows().len(), 1);
    // rust: assert_eq!(buffet.selected(), None);
    // rust: let done = f
    // rust: .title
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .find(|b| b.id == 80)
    // rust: .unwrap();
    // rust: assert!(!done.enabled);
    // Cancel keeps the preset's own biome (plains).
    // rust: let cancel = f
    // rust: .title
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .find(|b| b.id == 81)
    // rust: .unwrap();
    // rust: f.title.click(cancel.x + 10.0, cancel.y + 10.0, size);
    // rust: let Mode::Create { options, .. } = &f.title.mode else {
    // rust: panic!("{:?}", f.title.mode)
}
    // rust: assert_eq!(options.single_biome, "minecraft:plains");
}

/// The World tab's (World Type x, y; Customize centre) for a Create screen.
pub fn labels_at(f: *Fixture) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let buttons = f.title.buttons(480.0, 262.0);
    // rust: let customize = &buttons[1];
    // rust: (
    // rust: buttons[0].x + 10.0,
    // rust: buttons[0].y,
    // rust: (customize.x + 10.0, customize.y + 10.0),
    // rust: )
}

/// A button with an icon at its right end (`SpriteIconButton.TextAndIcon`, the
/// Music & Sounds button of the Accessibility screen): `extractContents` gives
/// the label `left = x + 2` and `right = x + width - spriteWidth - 4`.
    // rust: mod text_and_icon {
//     use super::*;

pub fn atlas() H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}
pub fn button(label: []const u8, icon: Option<(*'static str) void {
}
    // rust: Button {
    // rust: x: 30.0,
    // rust: y: 40.0,
    // rust: w: 150.0,
    // rust: label: label.into(),
    // rust: enabled: true,
    // rust: id: 0,
    // rust: icon: None,
    // rust: trailing: icon,
    // rust: action: None,
}
}
    /// The x of every vertex of the label's text.
pub fn xs(batch: *HudBatch) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: batch
    // rust: .vertices
    // rust: .iter()
    // rust: .filter(|v| v.text == 1)
    // rust: .map(|v| v.pos[0])
    // rust: .collect()
}
    /// The first `n` letters of a text with no repeating pattern.
pub fn label(n: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "Bezpostrzydnie połōnczynie Direct Connection Join Server"
    // rust: .chars()
    // rust: .take(n)
    // rust: .collect()
}
pub fn width(atlas: *HudAtlas, label: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HudBatch::text_width(atlas, label).ceil() as i32
}

    /// A label that fits beside the icon but, centred on the button, would end
    /// under it (`Settings sa Aksesibilidad...` in `fil_ph`, and about 40 other
    /// languages) is moved left until it ends where the icon's room begins:
    /// `Mth.clamp(centerX, left + lineWidth / 2, right - lineWidth / 2)` in
    /// `defaultScrollingHelper`. It does not scroll. The same label in a plain
    /// button stays centred.
pub fn a_label_that_fits_beside_the_icon_is_moved_clear_of_it() void {
}
    // rust: let atlas = atlas();
        // A 16 px icon: `left = x + 2`, `right = x + 130`, `centerX = x + 75`.
    // rust: let (left, right, center) = (32, 30 + 130, 30 + 75);
        // The widest label that fits; `right - width / 2 < centerX` by most.
    // rust: let text = (1..60)
    // rust: .map(label)
    // rust: .rfind(|t| width(&atlas, t) <= right - left)
    // rust: .expect("a label that fits");
    // rust: let half = width(&atlas, &text) / 2;
    // rust: assert!(right - half < center, "{text}: {}", width(&atlas, &text));
    // rust: let drawn_from = |from: i32| {
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: batch.text(&atlas, &text, from as f32, 46.0, u32::MAX, true);
    // rust: xs(&batch)
}
    // rust: let draw = |b: &Button, now_ms: i64| {
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: b.draw_label_at(&mut batch, &atlas, u32::MAX, now_ms);
    // rust: xs(&batch)
}
    // rust: let b = button(&text, Some(("icon/music_notes", 16.0)));
        // Vanilla: `textX = right - width / 2`, drawn from `textX - width / 2`.
    // rust: assert!(draw(&b, 0) == drawn_from(right - half - half), "{text}");
    // rust: for now_ms in [700, 1500, 31_337] {
    // rust: assert!(draw(&b, now_ms) == draw(&b, 0), "it scrolls at {now_ms}");
}
    // rust: let plain = button(&text, None);
    // rust: assert!(draw(&plain, 0) == drawn_from(center - half), "plain {text}");
}

    /// A label wider than the room beside the icon scrolls inside
    /// `x + 2 ..= x + width - spriteWidth - 4`, never under the icon.
pub fn a_label_wider_than_the_room_beside_the_icon_scrolls_clear_of_it() void {
}
    // rust: let atlas = atlas();
    // rust: let text = label(40);
    // rust: let b = button(&text, Some(("icon/music_notes", 16.0)));
    // rust: assert!(width(&atlas, &text) > 130 - 2);
    // rust: let mut seen = std::collections::BTreeSet::new();
    // rust: for now_ms in (0..40_000).step_by(250) {
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: b.draw_label_at(&mut batch, &atlas, u32::MAX, now_ms);
    // rust: let xs = xs(&batch);
    // rust: assert!(!xs.is_empty());
    // rust: for x in &xs {
    // rust: assert!(
    // rust: (32.0..=30.0 + 150.0 - 16.0 - 4.0).contains(x),
    // rust: "{x} at {now_ms} ms"
    // rust: );
}
    // rust: seen.insert(xs.iter().map(|x| x.to_bits()).collect::<Vec<_>>());
}
    // rust: assert!(seen.len() > 3, "the label hardly moves");
}
}

/// `MenuTabBar.MenuTabButton.renderLabel`: a tab's label slides inside the
/// tab's box with a 1 px margin when it is wider than the tab (here a window
/// too narrow for the English labels), instead of running into the next tab.
pub fn a_create_world_tab_label_wider_than_its_tab_stays_inside_it() void {
}
    // rust: let mut f = Fixture::new();
    // rust: f.click("Singleplayer");
    // rust: let atlas = HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // 90 px wide: three 20 px tabs from x = 14, too narrow for "Game".
    // rust: let mut batch = HudBatch::new([90, 262]);
    // rust: f.title.draw(&atlas, &mut batch, (0.0, 100.0), true);
    // rust: let labels: Vec<f32> = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .filter(|v| v.text == 1 && v.pos[1] < 24.0)
    // rust: .map(|v| v.pos[0])
    // rust: .collect();
    // rust: assert!(!labels.is_empty());
    // rust: let boxes: Vec<(f32, f32)> = (0..3)
    // rust: .map(|tab| {
    // rust: (
    // rust: 14.0 + 20.0 * tab as f32 + 1.0,
    // rust: 14.0 + 20.0 * (tab + 1) as f32 - 1.0,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for x in &labels {
    // rust: assert!(
    // rust: boxes.iter().any(|(lo, hi)| (*lo..=*hi).contains(x)),
    // rust: "label vertex at {x} is outside every tab's box"
    // rust: );
}
    // rust: for (tab, (lo, hi)) in boxes.iter().enumerate() {
    // rust: assert!(
    // rust: labels.iter().any(|x| (*lo..=*hi).contains(x)),
    // rust: "tab {tab} draws no label"
    // rust: );
}
}

/// The ids native mods see for the title's screens (`Mode::id`, the screen
/// hooks' `NativeScreenView.id`): one per screen, stable across releases.
pub fn the_title_screens_have_their_own_ids() void {
}
    // rust: let mut f = Fixture::new();
    // rust: assert_eq!(f.title.mode.id(), "title");
    // An empty list opens Create New World (an empty list is why vanilla
    // starts one), a world in it opens the list.
    // rust: f.title.enter_singleplayer();
    // rust: assert!(matches!(f.title.mode, Mode::Create { .. }));
    // rust: assert_eq!(f.title.mode.id(), "world_create");
    // rust: f.title.escape();
    // rust: assert_eq!(f.title.mode.id(), "title");
    // rust: f.world("World", "World");
    // rust: f.select();
    // rust: assert_eq!(f.title.mode.id(), "world_select");
    // rust: f.click("Edit");
    // rust: assert_eq!(f.title.mode.id(), "world_edit");
}

/// The multiplayer screens' ids, the ones the title's `Multiplayer` mode
/// passes through.
pub fn the_multiplayer_screens_have_their_own_ids() void {
}
//     use crate::multiplayer::Screen as M;
    // rust: assert_eq!(
    // rust: M::Direct {
    // rust: address: String::new()
}
    // rust: .id(),
    // rust: "direct_connect"
    // rust: );
    // rust: assert_eq!(
    // rust: M::Edit {
    // rust: index: None,
    // rust: name: String::new(),
    // rust: address: String::new(),
    // rust: focus: 0,
    // rust: packs: None,
}
    // rust: .id(),
    // rust: "add_server"
    // rust: );
    // rust: assert_eq!(
    // rust: M::Edit {
    // rust: index: Some(0),
    // rust: name: String::new(),
    // rust: address: String::new(),
    // rust: focus: 0,
    // rust: packs: None,
}
    // rust: .id(),
    // rust: "edit_server"
    // rust: );
    // rust: assert_eq!(
    // rust: M::Friend {
    // rust: code: String::new(),
    // rust: relay: String::new(),
    // rust: focus: 0,
}
    // rust: .id(),
    // rust: "friends_join"
    // rust: );
    // rust: assert_eq!(
    // rust: M::Disconnected {
    // rust: reason: String::new(),
    // rust: retry: None,
    // rust: lines: std::cell::Cell::new(1),
}
    // rust: .id(),
    // rust: "disconnected"
    // rust: );
}
