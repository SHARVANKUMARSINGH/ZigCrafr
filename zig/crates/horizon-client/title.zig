//! Transpiled from Horizon Rust crate
//! Module: horizon-client_title
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Title, world selection and world creation screens (TitleScreen,
//! SelectWorldScreen, CreateWorldScreen layouts), drawn as HUD quads.
// use crate::{
    // rust: dialog_screen::BOX,
    // rust: game_rules_screen::{Exit, RulesScreen},
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: lang,
    // rust: save::Level,
    // rust: text::{Text, format_translation},
}
// use horizon_world::datafix::world_upgrader::{self, WorldUpgrader};
// use std::path::{Path, PathBuf};
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: sync::mpsc,
}

    // rust: mod buffet;
    // rust: mod confirm_experiments;
    // rust: mod create_world;
    // rust: mod experiments;
    // rust: mod flat;
    // rust: mod onboarding;
    // rust: mod tests;
    // rust: pub mod world_management;
    // rust: pub use buffet::State as BuffetEditor;
    // rust: pub use create_world::{DIFFICULTIES, WorldOptions};
    // rust: pub use flat::{FlatLayer, FlatSettings, State as FlatEditor};
    // rust: pub use onboarding::Onboarding;

/// SelectWorldScreen's `HeaderAndFooterLayout(8 + 9 + 8 + 20 + 4, 60)`.
pub const LIST_TOP: f32 = 49.0;
pub const LIST_BOTTOM: f32 = 60.0;
pub const ROW_HEIGHT: f32 = 36.0;
pub const ROW_WIDTH: f32 = 270.0;

pub fn edit_top(h: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((h.ceil() - 234.0) / 2.0).floor()
}
    // rust: pub(crate) fn confirm_top(h: f32, lines: usize) -> f32 {
    // rust: ((h.ceil() - 61.0 - lines as f32 * 9.0) / 2.0).floor()
}
/// RecoverWorldDataScreen's column (title, message, issues, the restore row
/// and Back, 8 apart, centred on the screen) with `lines` lines of message
/// and issues: where the restore row starts.
pub fn recover_buttons_top(h: f32, lines: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = lines as f32 * 9.0;
    // rust: let top = ((h.ceil() - (9.0 + 8.0 + text + 8.0 + 8.0 + 20.0 + 8.0 + 20.0)) / 2.0).trunc();
    // rust: top + 9.0 + 8.0 + text + 8.0 + 8.0
}
/// `RecoverWorldDataScreen.buildInfo`: "State from <date>: " and the file's
/// issue; nothing for a level.dat_old that is just missing.
pub fn recover_info(dir: *Path, old: bool, issue: ?*crate::save::DatIssue) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::save::DatIssue;
    // rust: if old && issue == Some(&DatIssue::Missing) {
    // rust: return None;
}
    // rust: let file = dir.join(if old { "level.dat_old" } else { "level.dat" });
    // rust: let date = match std::fs::metadata(file).and_then(|m| m.modified()) {
    // rust: Ok(time) => {
    // rust: let date: chrono::DateTime<chrono::Local> = time.into();
    // rust: date.format("%d/%m/%Y, %H:%M").to_string()
}
    // rust: Err(_) => lang::get_or("recover_world.state_entry.unknown", "unknown"),
}
    // rust: let state = format_translation(
    // rust: &lang::get_or("recover_world.state_entry", "State from %s: "),
    // rust: &[Text::colored(date, GRAY)],
    // rust: );
    // rust: let issue = match issue {
    // rust: None => Text::colored(lang::get_or("recover_world.issue.none", "No issues"), GREEN),
    // rust: Some(DatIssue::Missing) => Text::colored(
    // rust: lang::get_or("recover_world.issue.missing_file", "Missing file"),
    // rust: RED,
    // rust: ),
    // rust: Some(DatIssue::Unreadable(why)) => Text::colored(why.clone(), RED),
}
    // rust: Some(Text::empty().append(state).append(issue))
}
/// ChatFormatting GRAY, GREEN and RED.
pub const GRAY: u32 = 0xAAAAAA;
pub const GREEN: u32 = 0x55FF55;
pub const RED: u32 = 0xFF5555;
/// `RecoverWorldDataScreen.collectIssue` for level.dat and level.dat_old.
pub fn recover_issues(dir: *Path) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: crate::save::level_dat_issue(dir, false),
    // rust: crate::save::level_dat_issue(dir, true),
    // rust: ]
}
/// The SafetyScreen's column (WarningScreen: title, 12 px around the message
/// box of its lines and 4 px padding, the checkbox, then the buttons, 8 px
/// apart): the title's top.
/// `LogoRenderer.extractRenderState`: the logo's top 44 of 64 rows, then the
/// edition banner's top 14 of 16 rows overlapping its bottom by 7.
pub fn draw_logo(atlas: *HudAtlas, batch: *mut HudBatch, w: f32) void {
}
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: "gui/title/minecraft",
    // rust: [(w / 2.0).floor() - 128.0, 30.0, 256.0, 44.0],
    // rust: 256.0,
    // rust: 64.0,
    // rust: );
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: crate::title_edition::SPRITE,
    // rust: [(w / 2.0).floor() - 64.0, 30.0 + 44.0 - 7.0, 128.0, 14.0],
    // rust: 128.0,
    // rust: 16.0,
    // rust: );
}

/// `OptimizeWorldScreen.DIMENSION_COLORS`.
pub fn dimension_color(level: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match level {
    // rust: world_upgrader::OVERWORLD => rgba(0x33, 0x66, 0x22, 255),
    // rust: world_upgrader::NETHER => rgba(0x66, 0x44, 0x33, 255),
    // rust: world_upgrader::END => rgba(0x77, 0x88, 0x55, 255),
    // rust: _ => rgba(0xdd, 0xdd, 0xdd, 255),
}
}

/// English text of the status keys `UpgradeStatusTranslator` returns.
pub fn status_fallback(key: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match key {
    // rust: "optimizeWorld.stage.failed" => "Failed! :(",
    // rust: "optimizeWorld.stage.upgrading.chunks" => "Upgrading all chunks...",
    // rust: "optimizeWorld.stage.upgrading.entities" => "Upgrading all entities...",
    // rust: "optimizeWorld.stage.upgrading.poi" => "Upgrading all points of interest...",
    // rust: "optimizeWorld.stage.finished.chunks" => "Finishing up upgrading chunks...",
    // rust: "optimizeWorld.stage.finished.entities" => "Finishing up upgrading entities...",
    // rust: "optimizeWorld.stage.finished.poi" => "Finishing up upgrading points of interest...",
    // rust: _ => "Counting chunks...",
}
}

pub fn warning_top(h: f32, lines: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((h.ceil() - 102.0 - lines as f32 * 9.0) / 2.0).floor()
}

pub fn translate(key: []const u8, fallback: []const u8, args: *[*dyn std::fmt::Display]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let args: Vec<Text> = args
    // rust: .iter()
    // rust: .map(|arg| Text::literal(arg.to_string()))
    // rust: .collect();
    // rust: format_translation(&lang::get_or(key, fallback), &args).plain()
}

pub const WorldToast = enum {
    Created {,
    folder: String,
    bytes: u64,
    // rust: },
    Failed(String),
    /// `SystemToast.onWorldAccessFailure`: the folder of a world that couldn't be locked.
    AccessFailure(String),
};
    // rust: impl WorldToast {
pub fn text(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Created { folder, bytes } => (
    // rust: translate("selectWorld.edit.backupCreated", "Backed up: %s", &[folder]),
    // rust: translate(
    // rust: "selectWorld.edit.backupSize",
    // rust: "Size: %s MB",
    // rust: &[&((*bytes as f64 / 1_048_576.0).ceil() as u64)],
    // rust: ),
    // rust: ),
    // rust: Self::Failed(error) => (
    // rust: lang::get_or("selectWorld.edit.backupFailed", "Backup failed"),
    // rust: error.clone(),
    // rust: ),
    // rust: Self::AccessFailure(folder) => (
    // rust: lang::get_or("selectWorld.access_failure", "Failed to access world"),
    // rust: folder.clone(),
    // rust: ),
}
}
}

/// Why `WorldOpenFlows.askForBackup` asks before a world opens.
pub const StemIssue = enum {
    /// `WorldOptions.isOldCustomizedWorld`.
    Customized,
    /// A `worldGenSettingsLifecycle` that is not stable.
    Experimental,
};

pub const WorldEntry = struct {
    folder: []const u8,
    name: []const u8,
    /// `GameType`: 0 survival, 1 creative, 2 adventure, 3 spectator.
    game_mode: i32,
    hardcore: bool,
    modified: std::time::SystemTime,
    commands: bool,
    version: []const u8,
    /// `LevelSummary.isLocked`: another running copy has the world open.
    locked: bool,
    /// `LevelSummary.CorruptedLevelSummary`: level.dat did not read, so the row
    /// only knows its folder and offers recovery instead of play.
    corrupted: bool,
    /// `LevelSummary.isCompatible` false: the saved game version's name, for a world
    /// from another series.
    incompatible: ?[]const u8,
    /// `LevelSummary.requiresFileFixing`: opening the world upgrades its files first.
    file_fixing: bool,
    /// `BackupStatus.DOWNGRADE`: a newer version saved the world.
    downgrade: bool,
};
    // rust: impl WorldEntry {
    /// `LevelSummary.isCompatible`: the saved series is this build's.
pub fn compatible(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.incompatible.is_none()
}
    /// `LevelSummary.isDisabled`.
pub fn disabled(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.locked || !self.compatible()
}
    /// `LevelSummary.primaryActionActive`: a corrupted world offers recovery.
pub fn can_play(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.corrupted || !self.disabled()
}
    /// `LevelSummary.canEdit` and `canRecreate`.
pub fn can_edit(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.corrupted && !self.disabled() && !self.file_fixing
}
    /// `BackupStatus.shouldBackup`: the world needs its files fixed or comes from
    /// a newer version.
pub fn should_backup(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.file_fixing || self.downgrade
}
    /// `CorruptedLevelSummary`: named after its folder, nothing else known.
pub fn corrupted(folder: []const u8, modified: std::time::SystemTime) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: name: folder.clone(),
    // rust: folder,
    // rust: game_mode: 0,
    // rust: hardcore: false,
    // rust: modified,
    // rust: commands: false,
    // rust: version: String::new(),
    // rust: locked: false,
    // rust: corrupted: true,
    // rust: incompatible: None,
    // rust: file_fixing: false,
    // rust: downgrade: false,
}
}
}
/// The AlertScreen an `Error` shows in place of the access failure.
pub const Alert = enum {
    /// The red `selectWorld.incompatible.title`.
    Incompatible,
    /// `selectWorld.recreate.error.title`.
    Recreate,
    /// `symlink_warning.title.world`
    /// (`NoticeWithLinkScreen.createWorldSymlinkWarningScreen`).
    Symlink,
};
pub const Mode = enum {
    Main,
    Select {,
    worlds: Vec<WorldEntry>,
    selected: Option<usize>,
    // rust: },
    Create {,
    name: String,
    seed: String,
    creative: bool,
    focus: u8,
    options: WorldOptions,
    // rust: },
    Edit {,
    world: WorldEntry,
    name: String,
    focused: bool,
    // rust: },
    Backup {,
    world: WorldEntry,
    // rust: },
    /// BackupConfirmScreen over a world whose file fixes are due, or, with `downgrade`
    /// (the saved version's name), over a world saved by a newer version.
    BackupBeforeUpgrade {,
    world: WorldEntry,
    downgrade: Option<String>,
        /// With neither of the above: `WorldOpenFlows.askForBackup` over a customized or
        /// experimental world (`openWorldCheckWorldStemCompatibility`).
    stem: Option<StemIssue>,
    // rust: },
    /// EditWorldScreen's Optimize World: BackupConfirmScreen with the Erase Cached Data box.
    OptimizeConfirm {,
    world: WorldEntry,
        /// The Edit World screen's name field, restored by Cancel.
    name: String,
    erase_cache: bool,
    // rust: },
    /// `OptimizeWorldScreen`: the progress of `Title.optimize`.
    Optimize {,
    world: WorldEntry,
    // rust: },
    /// `openWorldCheckDiskSpace`'s ConfirmScreen: little space is left on the device.
    LowDiskSpace {,
    world: WorldEntry,
    // rust: },
    Delete {,
    world: WorldEntry,
    // rust: },
    /// RecoverWorldDataScreen: opening a world whose level.dat does not read
    /// (WorldOpenFlows.openWorldLoadLevelData) lists what is wrong with
    /// level.dat and level.dat_old and offers to go back to the old one.
    Recover {,
    world: WorldEntry,
        /// `collectIssue` for level.dat, then level.dat_old.
    issues: [Option<crate::save::DatIssue>; 2],
    // rust: },
    /// Where `attemptRestore` ends: the "Recovery done" ConfirmScreen
    /// (Continue opens the world), or its AlertScreen when it failed.
    Recovered {,
    world: WorldEntry,
    success: bool,
    // rust: },
    Error {,
    message: String,
    return_to: Box<Mode>,
        /// An AlertScreen, not the access failure.
    alert: Option<Alert>,
    // rust: },
    Multiplayer(crate::multiplayer::Screen),
    Realms(crate::realms::Screen),
    /// SafetyScreen: the warning before the first Multiplayer click, with its
    /// "Do not show this screen again" box.
    MultiplayerWarning {,
    check: bool,
    // rust: },
    /// CreateFlatWorldScreen over Create New World: the fields that screen
    /// keeps and the superflat editor on top of them.
    CreateFlat {,
    name: String,
    seed: String,
    creative: bool,
    focus: u8,
    options: WorldOptions,
    flat: flat::State,
    // rust: },
    /// CreateBuffetWorldScreen over Create New World: the single-biome
    /// preset's biome list, over the fields that screen keeps.
    CreateBuffet {,
    name: String,
    seed: String,
    creative: bool,
    focus: u8,
    options: WorldOptions,
    buffet: buffet::State,
    // rust: },
    /// AccessibilityOnboardingScreen: the first screen of a first launch.
    Onboarding(Onboarding),
    /// `BanNoticeScreens`: a ConfirmLinkScreen `Gui.addInitialScreens` queued.
    BanNotice(crate::ban_notice::Notice),
};
pub const Action = enum {
    None,
    Quit,
    Options,
    Accessibility,
    Language,
    /// AccessibilityOnboardingScreen's Music & Sounds button.
    Sounds,
    /// The title's bottom text (`PlainTextButton`): `CreditsAndAttributionScreen`.
    Credits,
    /// `Blaze3D.openUri`: a ConfirmLinkScreen's Open in Browser.
    OpenUri(String),
    /// `ConfirmLinkScreen.copyToClipboard`.
    CopyText(String),
    Play {,
    folder: String,
    // rust: },
    Create {,
    folder: String,
    name: String,
    seed: Option<i64>,
    creative: bool,
    options: WorldOptions,
    // rust: },
    Connect {,
    address: String,
    lan: bool,
    // rust: },
    /// Create World's Data Packs screen on the new world's pack folder.
    DataPacks {,
    dir: PathBuf,
    selected: Vec<String>,
    // rust: },
};
pub const Title = struct {
    mode: Mode,
    /// Direct Connection's address, synchronized with `options.txt`'s `lastServer`.
    last_server: []const u8,
    /// `skipMultiplayerWarning`, synchronized with `options.txt` the same way.
    skip_multiplayer_warning: bool,
    saves: PathBuf,
    /// The prepared resource root: the flat preset list and block registry.
    resources: PathBuf,
    started: std::time::Instant,
    search: []const u8,
    search_focused: bool,
    /// The focused text field's cursor, selection and scroll.
    caret: RefCell<crate::ui::Caret>,
    scroll: Cell<crate::ui::Scroll>,
    create_return_to_main: bool,
    message_lines: Cell<usize>,
    /// The SafetyScreen's checkbox as last drawn: x, y, width, height.
    warning_check: Cell<[f32,
    /// The bottom notice's `PlainTextButton` as last drawn: x, y, width, height.
    credits_button: Cell<[f32,
    /// `Minecraft.allowsMultiplayer()` once the account's attributes are known.
    allows_multiplayer: bool,
    /// The ban screens `Gui.addInitialScreens` queued, shown once the title is up.
    ban_queue: std::collections::VecDeque<crate::ban_notice::Notice>,
    /// A ban notice's three buttons as last drawn (`ConfirmLinkScreen`'s row).
    ban_buttons: Cell<[(f32,
    backup: Option<mpsc::Receiver<Result<u64,
    backup_shown: Cell<bool>,
    /// The backup a `BackupBeforeUpgrade` asked for opens its world when done; whether it
    /// was the question about customized or experimental settings, the last one asked.
    backup_then_open: ?bool,
    /// The backup `OptimizeConfirm` asked for starts the optimization when done (with the
    /// Erase Cached Data choice).
    optimize_after_backup: ?bool,
    /// The backup `RecoverWorldDataScreen.attemptRestore` makes first; the restore runs when it
    /// is done, whether the backup worked or not.
    restore_after_backup: bool,
    /// The running `WorldUpgrader` of `Mode::Optimize`.
    optimize: ?WorldUpgrader,
    /// The Erase Cached Data box as last drawn: x, y, width, height.
    erase_check: Cell<[f32,
    /// The folder to open next, once that backup has finished.
    open_request: ?[]const u8,
    /// A Realm's checked address, once the Realms screen's join came back.
    connect_request: ?[]const u8,
    /// EditWorldScreen's and WorldOpenFlows' `SystemToast` and its slide.
    toast: Option<(crate::toasts::Slide,
    icons: RefCell<std::collections::HashMap<PathBuf,
    splash: ?[]const u8,
    /// `SplashManager.getSplash` rolled the player's own name instead of a list entry.
    splash_you: bool,
    /// The saves listed for Home, re-read every couple of seconds.
    recent: std::cell::RefCell<Option<(std::time::Instant,
    /// WorldCreationGameRulesScreen, over Create New World while it is open.
    rules: RefCell<?RulesScreen>,
    /// The onboarding screen has run out: the owner saves `onboardAccessibility` as false.
    onboarding_finished: bool,
    /// Focused button id, for keyboard navigation.
    focused_button: ?u8,
    /// CreateWorldScreen's Experiments screen, over Create New World.
    experiments: RefCell<?experiments::ExperimentsScreen>,
    /// ConfirmExperimentalFeaturesScreen, over Create New World.
    confirm_experiments: RefCell<?confirm_experiments::ConfirmExperimentsScreen>,
    /// The world creation data is being read: the screen says
    /// `createWorld.preparing` until it is done.
    preparing: bool,
    /// The confirm screen's Back: the Data Packs screen reopens.
    reopen_data_packs: bool,
};
    // rust: pub(crate) struct Button {
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: label: String,
    // rust: enabled: bool,
    // rust: id: u8,
    // rust: icon: Option<(&'static str, f32)>,
    /// `SpriteIconButton.TextAndIcon`: the icon at the right end, the text
    /// centred in the room left of it.
    // rust: trailing: Option<(&'static str, f32)>,
    /// Its job on the screen, for the controller (`widgets::Action`).
    // rust: action: Option<crate::widgets::Action>,
}
    // rust: impl Button {
pub fn does(action: crate::widgets::Action) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.action = Some(action);
    // rust: self
}
    /// `AbstractButton.extractDefaultLabel`: the label centred with a 2 px
    /// margin, and slid inside the button when it does not fit
    /// (`AbstractWidget.extractScrollingStringOverContents`), instead of being
    /// drawn past it over the buttons beside it (so_so's 590 px World Type
    /// label on Create World, hi_in's Join Server in the Multiplayer footer).
    /// A button with a `trailing` icon is `SpriteIconButton.TextAndIcon`, whose
    /// label keeps clear of the icon: see [`Button::draw_label_at`].
pub fn draw_label(self: *Self, batch: *mut HudBatch, atlas: *HudAtlas, color: u32) void {
}
    // rust: self.draw_label_at(batch, atlas, color, crate::hud_overlays::now_ms());
}

    /// [`Button::draw_label`] at `now_ms`. `SpriteIconButton.TextAndIcon`
    /// (`extractContents`) hands the label to `acceptScrolling` with `left`
    /// at the button's x plus 2, `right` at its x plus width minus the
    /// sprite's width minus 4, and `centerX` at its x plus half its width: the
    /// label slides inside that box when wider, and one that fits is moved
    /// left until it ends where the icon's room begins. A button without an
    /// icon has `right` 2 short of its edge, where `centerX` is the middle of
    /// the box and nothing moves.
pub fn draw_label_at(self: *Self, batch: *mut HudBatch, atlas: *HudAtlas, color: u32, now_ms: i64) void {
}
    // rust: let right = match self.trailing {
    // rust: Some((_, size)) => self.x + self.w - size - 4.0,
    // rust: None => self.x + self.w - 2.0,
}
    // rust: let room = if self.action.is_some() && self.enabled {
    // rust: crate::widgets::action_glyph_room()
    // rust: } else {
    // rust: 0.0
}
    // rust: crate::ui::scrolling_text_around_at(
    // rust: batch,
    // rust: atlas,
    // rust: &Text::literal(&self.label),
    // rust: self.x + (self.w / 2.0).floor(),
    // rust: self.x + 2.0 + room,
    // rust: right,
    // rust: self.y,
    // rust: self.y + 20.0,
    // rust: self.y + 6.0,
    // rust: now_ms,
    // rust: color,
    // rust: );
}
}

/// Java String.hashCode for text seeds (WorldOptions.parseSeed).
pub fn parse_seed(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = text.trim();
    // rust: if t.is_empty() {
    // rust: return None;
}
    // rust: Some(t.parse::<i64>().unwrap_or_else(|_| {
    // rust: i64::from(
    // rust: t.encode_utf16()
    // rust: .fold(0i32, |h, c| h.wrapping_mul(31).wrapping_add(i32::from(c))),
    // rust: )
    // rust: }))
}
pub fn list_worlds(saves: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut worlds: Vec<WorldEntry> = std::fs::read_dir(saves)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let path = e.path();
            // findLevelCandidates: a folder with a level.dat or a level.dat_old.
    // rust: let file = |name: &str| std::fs::metadata(path.join(name)).ok().filter(|m| m.is_file());
            // getFileModificationTime: level.dat's, else level.dat_old's.
    // rust: let file = file("level.dat").or_else(|| file("level.dat_old"))?;
    // rust: let modified = file.modified().unwrap_or(std::time::UNIX_EPOCH);
    // rust: let folder = e.file_name().to_string_lossy().into_owned();
            // readLevelSummary reads level.dat alone; when it fails the world is
            // still listed, as a CorruptedLevelSummary named after its folder.
    // rust: let level = Level::read_summary(&path);
    // rust: let root = crate::save::read_dat(&path.join("level.dat"));
    // rust: let (Some(level), Some(root)) = (level, root) else {
    // rust: return Some(WorldEntry::corrupted(folder, modified));
}
    // rust: let data = root.get("Data")?;
    // rust: let modified = match data.get("LastPlayed") {
    // rust: Some(horizon_world::nbt::Tag::Long(millis)) if *millis >= 0 => std::time::UNIX_EPOCH + std::time::Duration::from_millis(*millis as u64),
    // rust: _ => modified,
}
    // rust: Some(WorldEntry {
    // rust: folder,
    // rust: name: level.name,
    // rust: game_mode: level.game_mode,
    // rust: hardcore: level.hardcore,
    // rust: modified,
    // rust: commands: matches!(data.get("allowCommands"), Some(horizon_world::nbt::Tag::Byte(v)) if *v != 0),
    // rust: version: data.get("Version").and_then(|v| v.get("Name"))
    // rust: .and_then(|v| match v { horizon_world::nbt::Tag::String(s) => Some(s.to_string_lossy()), _ => None })
    // rust: .unwrap_or_else(|| lang::get_or("selectWorld.versionUnknown", "Unknown")),
    // rust: locked: crate::save::SessionLock::is_locked(&path),
    // rust: corrupted: false,
    // rust: incompatible: crate::save::incompatible_version(&path),
    // rust: file_fixing: crate::save::needs_file_fixes(&path),
    // rust: downgrade: crate::save::downgraded_from(&path).is_some(),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: worlds.sort_by_key(|w| std::cmp::Reverse(w.modified));
    // rust: worlds
}
/// LevelSummary.createInfo: a hardcore world's mode in red (CommonColors.RED),
/// else `gameMode.` + its GameType name, then commands and the version.
pub fn world_info(world: *WorldEntry) c {
    // Implementation ported from Horizon
    return undefined;
}
    // LevelSummary.createInfo: a locked world says so in red (ChatFormatting.RED).
    // rust: if world.locked {
    // rust: return crate::text::Text::colored(
    // rust: lang::get_or(
    // rust: "selectWorld.locked",
    // rust: "Locked by another running instance of Minecraft.",
    // rust: ),
    // rust: 0xFF5555,
    // rust: );
}
    // LevelSummary.createInfo: a world from another series says so in red.
    // rust: if let Some(version) = &world.incompatible {
    // rust: let version = if version.is_empty() {
    // rust: lang::get_or("selectWorld.versionUnknown", "unknown")
    // rust: } else {
    // rust: version.clone()
}
    // rust: return crate::text::Text::colored(
    // rust: translate(
    // rust: "selectWorld.incompatible.info",
    // rust: "Incompatible version: %s",
    // rust: &[&version],
    // rust: ),
    // rust: crate::text::RED,
    // rust: );
}
    // CorruptedLevelSummary.INFO: recover_world.warning in red (-65536).
    // rust: if world.corrupted {
    // rust: return crate::text::Text::colored(
    // rust: lang::get_or("recover_world.warning", "Failed to load world summary"),
    // rust: 0xFF0000,
    // rust: );
}
    // rust: let mode = if world.hardcore {
    // rust: crate::text::Text::colored(lang::get_or("gameMode.hardcore", "Hardcore Mode"), 0xFF0000)
    // rust: } else {
    // rust: let (key, fallback) = match world.game_mode {
    // rust: 1 => ("gameMode.creative", "Creative Mode"),
    // rust: 2 => ("gameMode.adventure", "Adventure Mode"),
    // rust: 3 => ("gameMode.spectator", "Spectator Mode"),
    // rust: _ => ("gameMode.survival", "Survival Mode"),
}
    // rust: crate::text::Text::literal(lang::get_or(key, fallback))
}
    // rust: let commands = if world.commands {
    // rust: format!(", {}", lang::get_or("selectWorld.commands", "Commands"))
    // rust: } else {
    // rust: String::new()
}
    // A world that asks for a backup shows its version in italics, red when downgrading.
    // rust: let version = crate::text::Text::literal(world.version.clone());
    // rust: let version = if !world.should_backup() {
    // rust: version
    // rust: } else if world.downgrade {
    // rust: version.with_color(crate::text::RED)
    // rust: } else {
    // rust: version.italic()
}
    // rust: mode.append(crate::text::Text::literal(format!(
    // rust: "{commands}, {} ",
    // rust: lang::get_or("selectWorld.version", "Version:"),
    // rust: )))
    // rust: .append(version)
}
/// A translation for the narrator (`Component.translatable(key, args)`).
    // rust: pub(crate) fn narration_text(key: &str, args: &[&str]) -> String {
    // rust: crate::screen_narrator::translate(key, args)
}
/// `WorldListEntry.getNarration`: "Selected: Selected <name>, last played:
/// <date>, <info>" (the date as `Date.toString` writes it).
pub fn world_narration(world: *WorldEntry) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let date: chrono::DateTime<chrono::Local> = world.modified.into();
    // rust: let date = date.format("%a %b %d %H:%M:%S %Z %Y").to_string();
    // rust: let info = world_info(world).plain();
    // rust: let entry = narration_text("narrator.select.world_info", &[&world.name, &date, &info]);
    // A locked world's info already says so (LevelSummary.createInfo), and
    // getNarration adds it again.
    // rust: let entry = if world.locked {
    // rust: crate::widgets::join_for_narration(&[&entry, &narration_text("selectWorld.locked", &[])])
    // rust: } else {
    // rust: entry
}
    // rust: narration_text("narrator.select", &[&entry])
}
pub fn choose_splash(text: []const u8, index: usize, date: (u32) void {
}
    // SplashManager checks SpecialDates before the resource list (local date).
    // rust: let special = match date {
    // rust: (12, 24) => Some("Merry X-mas!"),
    // rust: (1, 1) => Some("Happy new year!"),
    // rust: (10, 31) => Some("OOoooOOOoooo! Spooky!"),
    // rust: _ => None,
}
    // rust: if let Some(special) = special {
    // rust: return Some(special.to_owned());
}
    // rust: let splashes: Vec<_> = text
    // rust: .lines()
    // rust: .map(str::trim)
        // SplashManager.prepare keeps blank lines: only the hidden splash is dropped.
    // rust: .filter(|s| horizon_core::random::java_string_hash(s.encode_utf16()) != 125780783)
    // rust: .collect();
    // rust: splashes
    // rust: .get(index.checked_rem(splashes.len())?)
    // rust: .map(|s| (*s).to_owned())
}

/// `SplashManager.getSplash`: outside the special dates, a one in `size` roll
/// (`nextInt(size) == 42`) shows the logged-in player's name instead of a splash.
pub fn rolls_user_splash(text: []const u8, seed: u64, date: (u32) void {
}
//     use horizon_core::random::{LegacyRandom, RandomSource};
    // rust: if matches!(date, (12, 24) | (1, 1) | (10, 31)) {
    // rust: return false;
}
    // rust: let size = text
    // rust: .lines()
    // rust: .map(str::trim)
    // rust: .filter(|s| horizon_core::random::java_string_hash(s.encode_utf16()) != 125780783)
    // rust: .count();
    // rust: i32::try_from(size)
    // rust: .is_ok_and(|size| size > 0 && LegacyRandom::new(seed as i64).next_int_bound(size) == Ok(42))
}

    // rust: impl Mode {
    /// The id native mods see for this screen (`NativeScreenView.id`, the
    /// screen hooks): one per variant, a hook's contract, so it stays the
    /// same from release to release. A new variant must add one.
pub fn id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Main => "title",
    // rust: Self::Realms(_) => "realms",
    // rust: Self::Select { .. } => "world_select",
    // rust: Self::Create { .. } => "world_create",
    // rust: Self::CreateFlat { .. } => "world_create_flat",
    // rust: Self::CreateBuffet { .. } => "world_create_buffet",
    // rust: Self::Edit { .. } => "world_edit",
    // rust: Self::Backup { .. } => "world_backup",
    // rust: Self::BackupBeforeUpgrade { .. } => "world_backup_confirm",
    // rust: Self::OptimizeConfirm { .. } => "world_optimize_confirm",
    // rust: Self::Optimize { .. } => "world_optimize",
    // rust: Self::LowDiskSpace { .. } => "low_disk_space",
    // rust: Self::Delete { .. } => "world_delete",
    // rust: Self::Recover { .. } => "world_recover",
    // rust: Self::Recovered { .. } => "world_recovered",
    // rust: Self::Error { .. } => "error",
    // rust: Self::Multiplayer(screen) => screen.id(),
    // rust: Self::MultiplayerWarning { .. } => "multiplayer_warning",
    // rust: Self::Onboarding(_) => "onboarding",
    // rust: Self::BanNotice(_) => "ban_notice",
}
}
}

    // rust: impl Title {
    /// Names the player for the `<NAME> IS YOU` splash; `name` is only asked for when that splash was rolled.
pub fn with_user(name: impl FnOnce() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.splash_you {
    // rust: self.splash = Some(format!("{} IS YOU", name().to_uppercase()));
}
    // rust: self
}
pub fn new(saves: PathBuf, resources: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
//         use chrono::Datelike;
    // rust: let today = chrono::Local::now();
    // rust: let splashes =
    // rust: std::fs::read_to_string(resources.join("assets/minecraft/texts/splashes.txt"))
    // rust: .unwrap_or_default();
    // rust: let seed = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap_or_default()
    // rust: .subsec_nanos() as usize;
    // rust: let splash_you = rolls_user_splash(
    // rust: &splashes,
    // rust: (seed as u64).wrapping_mul(0x9E37_79B9_7F4A_7C15) ^ ((seed as u64) >> 7),
    // rust: (today.month(), today.day()),
    // rust: );
    // rust: let mode = Mode::Main;
    // rust: let now = std::time::Instant::now();
    // rust: Self {
    // rust: mode,
    // rust: last_server: String::new(),
    // rust: skip_multiplayer_warning: false,
    // rust: saves,
    // rust: resources: resources.to_owned(),
    // rust: started: now,
    // rust: search: String::new(),
    // rust: search_focused: false,
    // rust: caret: RefCell::default(),
    // rust: scroll: Cell::default(),
    // rust: create_return_to_main: false,
    // rust: message_lines: Cell::new(1),
    // rust: warning_check: Cell::new([0.0; 4]),
    // rust: credits_button: Cell::new([0.0; 4]),
    // rust: allows_multiplayer: true,
    // rust: ban_queue: Default::default(),
    // rust: ban_buttons: Cell::new([(0.0, 0.0); 3]),
    // rust: backup: None,
    // rust: backup_shown: Cell::new(false),
    // rust: backup_then_open: None,
    // rust: optimize_after_backup: None,
    // rust: restore_after_backup: false,
    // rust: optimize: None,
    // rust: erase_check: Cell::new([0.0; 4]),
    // rust: open_request: None,
    // rust: connect_request: None,
    // rust: toast: None,
    // rust: icons: RefCell::new(std::collections::HashMap::new()),
    // rust: splash: choose_splash(&splashes, seed, (today.month(), today.day())),
    // rust: splash_you,
    // rust: recent: std::cell::RefCell::new(None),
    // rust: rules: RefCell::new(None),
    // rust: onboarding_finished: false,
    // rust: focused_button: None,
    // rust: experiments: RefCell::new(None),
    // rust: confirm_experiments: RefCell::new(None),
    // rust: preparing: false,
    // rust: reopen_data_packs: false,
}
}
    /// Vanilla bypasses the selector when there are no saves.
pub fn enter_singleplayer(self: *Self) void {
}
    // rust: self.search.clear();
    // rust: self.search_focused = true;
    // rust: self.scroll.set(crate::ui::Scroll::default());
    // rust: let worlds = list_worlds(&self.saves);
    // rust: self.create_return_to_main = worlds.is_empty();
    // rust: self.mode = if worlds.is_empty() {
    // rust: Self::new_world()
    // rust: } else {
    // rust: Mode::Select {
    // rust: worlds,
    // rust: selected: None,
}
}
}
    // rust: pub(crate) fn new_world() -> Mode {
    // rust: Mode::Create {
    // rust: name: lang::get_or("selectWorld.newWorld", "New World"),
    // rust: seed: String::new(),
    // rust: creative: false,
    // rust: focus: 0,
    // rust: options: WorldOptions::default(),
}
}
    /// WorldSelectionList.handleNewLevels: a singleplayer list that comes
    /// back empty (the last world deleted, say) opens a fresh Create New
    /// World, whose Cancel goes to the title screen.
pub fn return_to_list(self: *Self, folder: ?[]const u8) void {
}
    // rust: let worlds = list_worlds(&self.saves);
    // rust: *self.recent.borrow_mut() = None;
    // rust: if worlds.is_empty() {
    // rust: self.create_return_to_main = true;
    // rust: self.mode = Self::new_world();
    // rust: return;
}
    // rust: let selected = folder.and_then(|folder| {
    // rust: worlds
    // rust: .iter()
    // rust: .position(|w| w.folder == folder && self.matches_search(w))
    // rust: });
    // rust: self.mode = Mode::Select { worlds, selected };
}
    /// Deletes the world `Mode::Delete` asks about and goes back to the
    /// refreshed list; a failure (the world is open elsewhere, say) shows the
    /// error instead and leaves the world. Returns the deleted world's row in
    /// the list before it went, for a layout that moves the selection there.
    // rust: pub(crate) fn confirm_delete(&mut self) -> Option<usize> {
    // rust: let Mode::Delete { world } = &self.mode else {
    // rust: return None;
}
    // rust: let folder = world.folder.clone();
    // rust: let row = list_worlds(&self.saves)
    // rust: .iter()
    // rust: .position(|w| w.folder == folder);
    // rust: if let Err(error) = world_management::delete(&self.saves, &folder) {
    // rust: self.failed(error);
    // rust: return None;
}
    // rust: self.return_to_list(None);
    // rust: self.icons.borrow_mut().clear();
    // rust: row
}
pub fn cancel_create(self: *Self) void {
}
        // removeTempDataPackDir.
    // rust: if let Mode::Create { options, .. } = &self.mode
    // rust: && let Some(dir) = &options.pack_dir
    // rust: {
    // rust: let _ = std::fs::remove_dir_all(dir);
}
    // rust: if self.create_return_to_main {
    // rust: self.mode = Mode::Main;
    // rust: } else {
    // rust: self.return_to_list(None);
}
}
    /// A press on the superflat screens: their list, share box or buttons.
pub fn flat_click(self: *Self, x: f32, y: f32, size: (f32) void {
}
    // rust: match hit {
    // rust: Some(70) => {
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat.remove_selected();
}
}
    // rust: Some(71) => {
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat.open_presets();
}
}
    // rust: Some(72) => self.close_flat(true),
    // rust: Some(73) => self.close_flat(false),
    // rust: Some(74) => {
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat.apply_share();
}
}
    // rust: Some(75) => {
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat.back_to_layers();
}
}
    // rust: None => {
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat::click(flat, (x, y), size);
}
}
    // rust: _ => {}
}
}
    /// A press on the single-biome screen: its search box, list or buttons.
pub fn buffet_click(self: *Self, x: f32, y: f32, size: (f32) void {
}
    // rust: match hit {
    // rust: Some(80) => self.close_buffet(true),
    // rust: Some(81) => self.close_buffet(false),
    // rust: None => {
    // rust: if let Mode::CreateBuffet { buffet, .. } = &mut self.mode {
    // rust: buffet::click(buffet, (x, y), size);
}
}
    // rust: _ => {}
}
}
    /// Return to Create New World, keeping (`apply`) the chosen biome
    /// (`CreateBuffetWorldScreen`'s Done and Cancel).
pub fn close_buffet(self: *Self, apply: bool) void {
}
    // rust: let mode = std::mem::replace(&mut self.mode, Mode::Main);
    // rust: if let Mode::CreateBuffet {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: mut options,
    // rust: buffet,
    // rust: } = mode
    // rust: {
    // rust: if apply {
    // rust: options.world_type = crate::save::WorldPreset::SingleBiomeSurface;
    // rust: options.single_biome = buffet.biome.clone();
}
    // rust: self.mode = Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: options,
}
}
}
    /// Return to Create New World, keeping (`apply`) or dropping the layers.
pub fn close_flat(self: *Self, apply: bool) void {
}
    // rust: let mode = std::mem::replace(&mut self.mode, Mode::Main);
    // rust: if let Mode::CreateFlat {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: mut options,
    // rust: flat,
    // rust: } = mode
    // rust: {
    // rust: if apply {
    // rust: options.world_type = crate::save::WorldPreset::Flat;
    // rust: options.flat_settings = Some(flat.settings);
}
    // rust: self.mode = Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: options,
}
}
}
    /// `createWorld.preparing` is up: the world creation data is being read.
pub fn preparing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.preparing
}
    /// The Create screen's chosen packs: the temp folder and the selected
    /// ids, for the worldgen data the preparing read loads.
pub fn creation_packs(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.mode {
    // rust: Mode::Create { options, .. } => {
    // rust: Some((options.pack_dir.clone(), options.data_packs.clone()))
}
    // rust: _ => None,
}
}
    /// The read finished: the flag goes, and the create screen opens — a
    /// fresh one entering from the world list, the one the player already
    /// filled in after the data packs changed (`openCreateWorldScreen`).
pub fn finish_preparing(self: *Self) void {
}
    // rust: self.preparing = false;
    // rust: if !matches!(self.mode, Mode::Create { .. }) {
    // rust: self.mode = Self::new_world();
}
}
    /// `PackSelectionScreen.onFilesDrop`: a pack dropped on the window joins
    /// the Create New World screen's data packs (the screen's watcher lists
    /// it within a second).
pub fn drop_file(self: *Self, path: std::path::PathBuf) void {
}
    // rust: let Mode::Create { options, .. } = &mut self.mode else {
    // rust: return;
}
    // rust: if options.pack_dir.is_none() {
    // rust: options.pack_dir = crate::datapack::temp_folder().ok();
}
    // rust: let Some(dir) = options.pack_dir.clone() else {
    // rust: return;
}
    // rust: if !crate::datapack::copy_pack(&path, &dir) {
    // rust: log::warn!(
    // rust: "Horizon: {} is not a data pack that could be copied",
    // rust: path.display()
    // rust: );
}
}
    /// The world's data pack selection, for the game to reoffer.
pub fn data_packs(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.mode {
    // rust: Mode::Create { options, .. } => options.data_packs.clone(),
    // rust: _ => Vec::new(),
}
}
    /// The new world's pack folder, for the Data Packs screen to reopen.
pub fn pack_dir(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.mode {
    // rust: Mode::Create { options, .. } => options.pack_dir.clone(),
    // rust: _ => None,
}
}
    /// The Data Packs screen's Done (`tryApplyNewDataPacks`): a selection
    /// with feature packs asks for experimental features, so the confirm
    /// screen comes up first; anything else applies at once and the data
    /// is read again.
pub fn offer_data_packs(self: *Self, resources: *std::path::Path, ids: std.ArrayList([]const u8)) void {
}
    // rust: let experimental = crate::datapack::feature_packs(resources)
    // rust: .into_iter()
    // rust: .any(|p| ids.contains(&p.id));
    // rust: if experimental {
    // rust: *self.confirm_experiments.get_mut() = Some(
    // rust: confirm_experiments::ConfirmExperimentsScreen::new(resources, &ids),
    // rust: );
    // rust: } else {
    // rust: self.set_data_packs(ids);
    // rust: self.preparing = true;
}
}
    /// Whether the confirm screen declined: the Data Packs screen reopens.
pub fn take_reopen_data_packs(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.reopen_data_packs)
}
    /// `onAbort`: the Data Packs screen reopens with the selection and the
    /// folder it had (`take_reopen_data_packs` said it wants to).
pub fn reopen_data_packs_action(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.take_reopen_data_packs() {
    // rust: return None;
}
    // rust: let (dir, selected) = match &self.mode {
    // rust: Mode::Create { options, .. } => (
    // rust: options.pack_dir.clone().unwrap_or_default(),
    // rust: options.data_packs.clone(),
    // rust: ),
    // rust: _ => (Default::default(), Vec::new()),
}
    // rust: Some(Action::DataPacks { dir, selected })
}
pub fn set_data_packs(self: *Self, ids: std.ArrayList([]const u8)) void {
}
    // rust: if let Mode::Create { options, .. } = &mut self.mode {
    // rust: options.data_packs = ids;
}
}
pub fn matches_search(self: *Self, world: *WorldEntry) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let filter = self.search.to_lowercase();
    // rust: world.name.to_lowercase().contains(&filter) || world.folder.to_lowercase().contains(&filter)
}
    // rust: fn visible_worlds<'a>(
    // rust: &self,
    // rust: worlds: &'a [WorldEntry],
    // rust: ) -> impl Iterator<Item = (usize, &'a WorldEntry)> {
    // rust: worlds
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, w)| self.matches_search(w))
    // rust: .collect::<Vec<_>>()
    // rust: .into_iter()
}
    /// The world list's top, bottom, rows' left edge and content height.
pub fn world_list(self: *Self, worlds: *[WorldEntry]) void {
}
    // rust: let (w, h) = (w.ceil(), h.ceil());
    // rust: let content = self.visible_worlds(worlds).count() as f32 * ROW_HEIGHT + 4.0;
    // rust: let left = (w / 2.0).floor() - ROW_WIDTH / 2.0;
    // rust: (LIST_TOP, h - LIST_BOTTOM, left, content)
}
    /// The visible row under the pointer and the pointer relative to its
    /// content (`AbstractSelectionList.getEntryAtPosition`).
    // rust: fn world_row_at(
    // rust: &self,
    // rust: worlds: &[WorldEntry],
    // rust: (x, y): (f32, f32),
    // rust: size: (f32, f32),
    // rust: ) -> Option<(usize, (f32, f32))> {
    // rust: let (top, bottom, left, _) = self.world_list(worlds, size);
    // rust: if y < top || y >= bottom || x < left || x >= left + ROW_WIDTH {
    // rust: return None;
}
    // rust: let offset = self.scroll.get().amount.trunc();
    // rust: let row = ((y - top - 2.0 + offset) / ROW_HEIGHT).floor();
    // rust: if row < 0.0 || row as usize >= self.visible_worlds(worlds).count() {
    // rust: return None;
}
    // rust: let content_y = top + 4.0 + row * ROW_HEIGHT - offset;
    // rust: Some((row as usize, (x - left - 2.0, y - content_y)))
}
    /// The pointer moved with the button held (`mouseDragged`).
pub fn drag(self: *Self, cursor: (f32) void {
}
    // rust: if let Some(rules) = self.rules.get_mut() {
    // rust: return rules.drag(cursor.1, size.1.ceil());
}
    // rust: if let Mode::Multiplayer(screen) = &mut self.mode {
    // rust: return screen.drag(cursor.1, size);
}
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat::drag(flat, cursor, size);
    // rust: return;
}
    // rust: if let Mode::CreateBuffet { buffet, .. } = &mut self.mode {
    // rust: buffet::drag(buffet, cursor, size);
    // rust: return;
}
    // rust: if let Mode::Select { worlds, .. } = &self.mode {
    // rust: let (top, bottom, _, content) = self.world_list(worlds, size);
    // rust: let mut scroll = self.scroll.get();
    // rust: scroll.drag(cursor.1, top, bottom, content);
    // rust: self.scroll.set(scroll);
}
}
    /// The button was released (`onRelease`).
pub fn release(self: *Self) void {
}
    // rust: if let Some(rules) = self.rules.get_mut() {
    // rust: rules.release();
}
    // rust: if let Mode::Multiplayer(screen) = &mut self.mode {
    // rust: screen.release();
}
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat::release(flat);
}
    // rust: if let Mode::CreateBuffet { buffet, .. } = &mut self.mode {
    // rust: buffet::release(buffet);
}
    // rust: self.scroll.get_mut().release();
}
    /// Mouse wheel over the classic world and server lists, or cycle buttons. Returns true if a button was cycled.
pub fn scroll_worlds(self: *Self, delta: f32, cursor: (f32) void {
}
    // rust: if let Some(rules) = self.rules.get_mut() {
    // rust: rules.wheel(delta, size.1.ceil());
    // rust: return false;
}
    // rust: if let Mode::Multiplayer(screen) = &mut self.mode {
    // rust: screen.wheel(delta, cursor, size);
    // rust: return false;
}
    // rust: if let Mode::Realms(screen) = &mut self.mode {
    // rust: screen.wheel(delta, cursor, size);
    // rust: return false;
}
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat::wheel(flat, delta, cursor, size);
    // rust: return false;
}
    // rust: if let Mode::CreateBuffet { buffet, .. } = &mut self.mode {
    // rust: buffet::wheel(buffet, delta, cursor, size);
    // rust: return false;
}
        // CycleButton.mouseScrolled reads only the vertical wheel.
    // rust: if let Mode::Create {
    // rust: creative, options, ..
    // rust: } = &mut self.mode
    // rust: && delta != 0.0
    // rust: {
    // rust: let (w, h) = size;
    // rust: let buttons = create_world::buttons(w, h, *creative, options);
    // rust: if let Some(b) = buttons.iter().find(|b| {
    // rust: b.enabled
    // rust: && cursor.0 >= b.x
    // rust: && cursor.0 < b.x + b.w
    // rust: && cursor.1 >= b.y
    // rust: && cursor.1 < b.y + 20.0
    // rust: }) {
    // rust: let step = if delta > 0.0 { -1 } else { 1 };
    // rust: options.cycle(b.id, creative, step);
    // rust: return true;
}
}
    // rust: let Mode::Select { worlds, .. } = &self.mode else {
    // rust: return false;
}
    // rust: let (top, bottom, _, content) = self.world_list(worlds, size);
    // rust: if cursor.1 < top || cursor.1 >= bottom {
    // rust: return false;
}
    // rust: let mut scroll = self.scroll.get();
    // rust: scroll.wheel(delta, ROW_HEIGHT / 2.0, top, bottom, content);
    // rust: self.scroll.set(scroll);
    // rust: false
}
    /// The right stick's scroll: the open list moves wherever the hidden pointer
    /// is, and Create World's buttons don't take the step.
pub fn stick_scroll(self: *Self, delta: f32, cursor: (f32) void {
}
    // rust: self.step_scroll(delta, crate::widgets::over_scroll_area(cursor), size);
}
    /// A focus step past a list's edge: what the pointer is over scrolls, and
    /// Create World's buttons don't take the step.
pub fn step_scroll(self: *Self, delta: f32, cursor: (f32) void {
}
    // rust: let open_rules = self.rules.get_mut().is_some();
    // rust: if matches!(self.mode, Mode::Create { .. }) && !open_rules {
    // rust: return;
}
    // rust: self.scroll_worlds(delta, cursor, size);
}
pub fn failed(self: *Self, error: impl std::fmt::Display) void {
}
    // rust: let return_to = Box::new(self.mode.clone());
    // rust: self.mode = Mode::Error {
    // rust: message: error.to_string(),
    // rust: return_to,
    // rust: alert: None,
}
}
    /// Polling is done once per rendered frame so filesystem work never blocks drawing.
pub fn poll_backup(self: *Self) void {
}
    // rust: self.poll_realms();
    // rust: self.poll_onboarding(std::time::Instant::now());
    // rust: self.poll_account();
    // rust: self.poll_optimize();
    // rust: if !self.backup_shown.get() {
    // rust: return;
}
    // rust: let Some(receiver) = &self.backup else {
    // rust: return;
}
    // rust: let result = match receiver.try_recv() {
    // rust: Ok(result) => result,
    // rust: Err(mpsc::TryRecvError::Empty) => return,
    // rust: Err(mpsc::TryRecvError::Disconnected) => Err("Backup worker stopped".into()),
}
    // rust: self.backup = None;
    // rust: if let Mode::Backup { world } = &self.mode {
    // rust: let world = world.clone();
    // rust: let folder = world.folder.clone();
    // rust: if std::mem::take(&mut self.restore_after_backup) {
                // `makeBackupAndShowToast(..).thenAcceptAsync(..)` in attemptRestore: the restore
                // runs, backup failed or not.
    // rust: self.attempt_restore(world.clone());
    // rust: } else if let Some(erase_cache) = self.optimize_after_backup.take() {
                // `conditionallyMakeBackupAndShowToast(..).thenAcceptAsync(..)`: the toast shows
                // and OptimizeWorldScreen opens, backup failed or not.
    // rust: self.begin_optimize(world.clone(), erase_cache);
    // rust: } else {
    // rust: self.return_to_list(Some(&folder));
}
            // EditWorldScreen opens the world after the backup, failed or not: through the
            // checks WorldOpenFlows still has to make.
    // rust: if let Some(stem_asked) = self.backup_then_open.take()
    // rust: && let Action::Play { folder } = self.after_prompt(world.clone(), stem_asked)
    // rust: {
    // rust: self.open_request = Some(folder);
}
    // rust: let toast = match result {
    // rust: Ok(bytes) => WorldToast::Created { folder, bytes },
    // rust: Err(error) => WorldToast::Failed(error),
}
    // rust: self.toast = Some((crate::toasts::Slide::default(), toast));
}
}
    /// `ToastManager.update` for the system toast: slides it in, keeps it
    /// for 5 s times the notification display time, slides it out. The
    /// sound of a new visibility (`Toast.Visibility`), if any.
pub fn update_toast(self: *Self, multiplier: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (slide, _) = self.toast.as_mut()?;
        // SystemToast.update: shown until displayTime (5000 ms) has passed.
    // rust: let time = 5000.0 * f64::from(multiplier);
    // rust: let (sound, finished) = slide.update_now(|fully| (fully as f64) < time);
    // rust: if finished {
    // rust: self.toast = None;
}
    // rust: sound.map(|show| {
    // rust: if show {
    // rust: "minecraft:ui.toast.in"
    // rust: } else {
    // rust: "minecraft:ui.toast.out"
}
    // rust: })
}
    /// The server list's narration of LAN worlds found since the last call
    /// (`JoinMultiplayerScreen.tick`'s `updateNetworkServers`).
pub fn lan_found_narrations(self: *Self, size: (f32) void {
}
    // rust: match &self.mode {
    // rust: Mode::Multiplayer(screen) => screen.lan_found_narrations(size),
    // rust: _ => Vec::new(),
}
}
    /// Whether the system toast holds the `ToastManager`'s first slot.
pub fn has_toast(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.toast.is_some()
}
    /// The world a finished backup made before its upgrade opens next.
    /// The Realms screen's workers: a join that came back connects (`GetServerDetailsTask`
    /// handing over to `ConnectScreen`).
pub fn poll_realms(self: *Self) void {
}
    // rust: if let Mode::Realms(screen) = &mut self.mode
    // rust: && let crate::realms::Outcome::Connect(address) = screen.poll()
    // rust: {
    // rust: self.connect_request = Some(address);
}
}
    /// The server the Realms screen joins once its address came back.
pub fn take_connect_request(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let address = self.connect_request.take()?;
    // rust: Some(Action::Connect {
    // rust: address,
    // rust: lan: false,
    // rust: })
}
pub fn take_open_request(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.open_request.take()
}
    /// `WorldOpenFlows.openWorldLoadLevelData` for a world opened without the list (the control
    /// socket): level data that does not read shows RecoverWorldDataScreen. False when the world
    /// reads and opens as usual.
pub fn open_recover(self: *Self, folder: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = self.saves.join(folder);
    // rust: let Some(issue) = crate::save::level_data_needs_recovery(&dir) else {
    // rust: return false;
}
    // rust: let world = list_worlds(&self.saves)
    // rust: .into_iter()
    // rust: .find(|w| w.folder == folder)
    // rust: .unwrap_or_else(|| {
    // rust: WorldEntry::corrupted(folder.to_owned(), std::time::SystemTime::now())
    // rust: });
    // rust: let issues = [Some(issue), crate::save::level_dat_issue(&dir, true)];
    // rust: self.mode = Mode::Recover { world, issues };
    // rust: true
}
    /// `WorldOpenFlows.openWorld`: a world that can't be locked, as one another
    /// instance has open, stays closed behind `onWorldAccessFailure`
    /// (`createWorldAccess`); then `openWorldCheckVersionCompatibility`: a world from
    /// another series is an alert, one whose file fixes are due or that a newer version
    /// saved asks for a backup first; any other opens at once.
pub fn play(self: *Self, world: WorldEntry) A {
    // Implementation ported from Horizon
    return undefined;
}
        // LevelSummary.primaryActionActive: a world another copy has open cannot be joined.
    // rust: if world.locked {
    // rust: return Action::None;
}
        // `LevelStorageSource.validateAndCreateAccess`: a world folder holding
        // a symbolic link is refused before an access is made over it, and
        // `WorldOpenFlows.createWorldAccess` puts the symlink warning where
        // the world would have gone.
    // rust: if world_management::symlinks(&self.saves, &world.folder)
    // rust: .is_ok_and(|links| !links.is_empty())
    // rust: {
    // rust: self.mode = Mode::Error {
    // rust: message: lang::get_or(
    // rust: "symlink_warning.message.world",
    // rust: "You are trying to open a world whose folder holds links to other files. That can be a risk to the rest of your files, so the world stays closed.",
    // rust: ),
    // rust: return_to: Box::new(self.mode.clone()),
    // rust: alert: Some(Alert::Symlink),
}
    // rust: return Action::None;
}
    // rust: if crate::save::SessionLock::acquire(&self.saves.join(&world.folder)).is_err() {
    // rust: self.toast = Some((
    // rust: crate::toasts::Slide::default(),
    // rust: WorldToast::AccessFailure(world.folder),
    // rust: ));
    // rust: return Action::None;
}
        // openWorldLoadLevelData: a level.dat that does not read opens
        // RecoverWorldDataScreen instead of the world.
    // rust: let issues = recover_issues(&self.saves.join(&world.folder));
    // rust: if issues[0].is_some() {
    // rust: self.mode = Mode::Recover { world, issues };
    // rust: return Action::None;
}
        // openWorldCheckVersionCompatibility: a world from another series is an AlertScreen.
    // rust: if let Some(version) = crate::save::incompatible_version(&self.saves.join(&world.folder)) {
    // rust: let version = if version.is_empty() {
    // rust: lang::get_or("selectWorld.versionUnknown", "unknown")
    // rust: } else {
    // rust: version
}
    // rust: self.mode = Mode::Error {
    // rust: message: translate(
    // rust: "selectWorld.incompatible.description",
    // rust: "This world cannot be opened in this version.\nIt was last played in version %s.",
    // rust: &[&version],
    // rust: ),
    // rust: return_to: Box::new(self.mode.clone()),
    // rust: alert: Some(Alert::Incompatible),
}
    // rust: return Action::None;
}
    // rust: if crate::save::needs_file_fixes(&self.saves.join(&world.folder)) {
    // rust: self.mode = Mode::BackupBeforeUpgrade {
    // rust: world,
    // rust: downgrade: None,
    // rust: stem: None,
}
    // rust: return Action::None;
}
        // BackupStatus.DOWNGRADE: a world from a newer version asks for a backup too.
    // rust: if let Some(version) = crate::save::downgraded_from(&self.saves.join(&world.folder)) {
    // rust: let version = if version.is_empty() {
    // rust: lang::get_or("selectWorld.versionUnknown", "unknown")
    // rust: } else {
    // rust: version
}
    // rust: self.mode = Mode::BackupBeforeUpgrade {
    // rust: world,
    // rust: downgrade: Some(version),
    // rust: stem: None,
}
    // rust: return Action::None;
}
    // rust: self.after_prompt(world, false)
}
    /// What `WorldOpenFlows` does once a world's version questions are answered:
    /// `openWorldCheckWorldStemCompatibility` (unless `stem_asked`: its backup question was
    /// the one just answered), then `openWorldCheckDiskSpace`, then the load.
pub fn after_prompt(self: *Self, world: WorldEntry, stem_asked: bool) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = self.saves.join(&world.folder);
        // The generator settings of a world that still needs its file fixes are read as the
        // fixes will leave them (`world_gen_settings`), so its question comes with this open.
    // rust: if !stem_asked {
    // rust: let issue = if crate::save::is_old_customized_world(&dir) {
    // rust: Some(StemIssue::Customized)
    // rust: } else if crate::save::world_gen_unstable(&dir) {
    // rust: Some(StemIssue::Experimental)
    // rust: } else {
    // rust: None
}
    // rust: if let Some(stem) = issue {
    // rust: self.mode = Mode::BackupBeforeUpgrade {
    // rust: world,
    // rust: downgrade: None,
    // rust: stem: Some(stem),
}
    // rust: return Action::None;
}
}
    // rust: if crate::save::low_disk_space(&dir) {
    // rust: self.mode = Mode::LowDiskSpace { world };
    // rust: return Action::None;
}
    // rust: Action::Play {
    // rust: folder: world.folder,
}
}
    /// `RecoverWorldDataScreen.attemptRestore`: with level.dat still broken and
    /// level.dat_old readable, level.dat_old takes level.dat's place
    /// (`restoreLevelDataFromOld`); anything else is a failure.
pub fn attempt_restore(self: *Self, world: WorldEntry) void {
}
    // rust: let dir = self.saves.join(&world.folder);
    // rust: let issues = recover_issues(&dir);
    // rust: let success = issues[0].is_some()
    // rust: && issues[1].is_none()
    // rust: && crate::save::restore_level_data_from_old(&dir);
    // rust: if !success {
    // rust: log::error!(
    // rust: "Failed to recover world, files not as expected. level.dat: {:?}, level.dat_old: {:?}",
    // rust: issues[0],
    // rust: issues[1]
    // rust: );
}
    // rust: *self.recent.borrow_mut() = None;
    // rust: self.mode = Mode::Recovered { world, success };
}
    /// `OptimizeWorldScreen.create`: a world that still needs its file fixes or whose level data
    /// does not read can't be optimized (vanilla logs and `setScreen(null)`, the main menu here).
    /// Horizon stamps level.dat when the run finishes, not before: opening a world with an
    /// older DataVersion is what converts it whole.
pub fn begin_optimize(self: *Self, world: WorldEntry, erase_cache: bool) void {
}
    // rust: let dir = self.saves.join(&world.folder);
        // `getUnfixedDataTagWithFallback`: level.dat_old stands in for a level.dat that does not read.
    // rust: crate::save::fall_back_to_level_dat_old(&dir);
    // rust: if crate::save::needs_file_fixes(&dir)
    // rust: || crate::save::level_data_needs_recovery(&dir).is_some()
    // rust: {
    // rust: eprintln!("Failed to load datapacks, can't optimize world");
    // rust: self.mode = Mode::Main;
    // rust: return;
}
    // rust: let levels = world_upgrader::world_dimensions(&dir);
    // rust: self.optimize = Some(WorldUpgrader::new(&dir, levels, erase_cache, false));
    // rust: self.mode = Mode::Optimize { world };
}
    /// `OptimizeWorldScreen.tick`: a finished upgrader ends the screen with `true`.
pub fn poll_optimize(self: *Self) void {
}
    // rust: if matches!(self.mode, Mode::Optimize { .. })
    // rust: && self
    // rust: .optimize
    // rust: .as_ref()
    // rust: .is_some_and(WorldUpgrader::is_finished)
    // rust: {
    // rust: self.end_optimize(true);
}
}
    /// The callback of `OptimizeWorldScreen`, then `removed()` (cancel and close the upgrader):
    /// back to the refreshed world list.
pub fn end_optimize(self: *Self, success: bool) void {
}
    // rust: let Mode::Optimize { world } = &self.mode else {
    // rust: return;
}
    // rust: let folder = world.folder.clone();
    // rust: if let Some(mut upgrader) = self.optimize.take() {
    // rust: upgrader.cancel();
    // rust: if success && upgrader.status_key() != "optimizeWorld.stage.failed" {
                // The level data at the current version, which vanilla saved in `create`.
    // rust: if let Err(e) =
    // rust: horizon_world::datafix::files::fix_world_files(&self.saves.join(&folder))
    // rust: {
    // rust: eprintln!("level.dat: {e}");
}
}
}
    // rust: self.return_to_list(Some(&folder));
}
    /// `OptimizeWorldScreen.extractRenderState`.
pub fn draw_optimize(self: *Self, atlas: *HudAtlas, batch: *mut HudBatch, w: f32, h: f32, name: []const u8) void {
}
    // rust: let Some(upgrader) = &self.optimize else {
    // rust: return;
}
    // rust: let grey = rgba(160, 160, 160, 255);
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &translate("optimizeWorld.title", "Optimizing World '%s'", &[&name]),
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let (x0, x1) = ((w / 2.0).floor() - 150.0, (w / 2.0).floor() + 150.0);
    // rust: let y0 = (h.ceil() / 4.0).floor() + 100.0;
    // rust: let y1 = y0 + 10.0;
    // rust: let key = upgrader.status_key();
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or(&key, status_fallback(&key)),
    // rust: y0 - 9.0 - 2.0,
    // rust: grey,
    // rust: );
    // rust: if upgrader.total_chunks() <= 0 {
    // rust: return;
}
    // rust: batch.fill(
    // rust: atlas,
    // rust: x0 - 1.0,
    // rust: y0 - 1.0,
    // rust: x1 - x0 + 2.0,
    // rust: y1 - y0 + 2.0,
    // rust: rgba(0, 0, 0, 255),
    // rust: );
    // rust: for (i, (key, fallback, value)) in [
    // rust: (
    // rust: "optimizeWorld.info.converted",
    // rust: "Upgraded chunks: %s",
    // rust: upgrader.converted(),
    // rust: ),
    // rust: (
    // rust: "optimizeWorld.info.skipped",
    // rust: "Skipped chunks: %s",
    // rust: upgrader.skipped(),
    // rust: ),
    // rust: (
    // rust: "optimizeWorld.info.total",
    // rust: "Total chunks: %s",
    // rust: upgrader.total_chunks(),
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: batch.text(
    // rust: atlas,
    // rust: &translate(key, fallback, &[&value]),
    // rust: x0,
    // rust: 40.0 + 12.0 * i as f32,
    // rust: grey,
    // rust: true,
    // rust: );
}
    // rust: let mut progress = 0.0;
    // rust: for level in upgrader.levels() {
    // rust: let length = (upgrader.dimension_progress(level) * (x1 - x0)).floor();
    // rust: batch.fill(
    // rust: atlas,
    // rust: x0 + progress,
    // rust: y0,
    // rust: length,
    // rust: y1 - y0,
    // rust: dimension_color(level),
    // rust: );
    // rust: progress += length;
}
    // rust: let done = upgrader.converted() + upgrader.skipped();
    // rust: let counter = translate(
    // rust: "optimizeWorld.progress.counter",
    // rust: "%s / %s",
    // rust: &[&done, &upgrader.total_chunks()],
    // rust: );
    // rust: let percent = translate(
    // rust: "optimizeWorld.progress.percentage",
    // rust: "%s%%",
    // rust: &[&((upgrader.total_progress() * 100.0).floor() as i32)],
    // rust: );
    // rust: centered(atlas, batch, &counter, y0 + 2.0 * 9.0 + 2.0, grey);
    // rust: centered(atlas, batch, &percent, y0 + 1.0, grey);
}
pub fn start_backup(self: *Self, world: WorldEntry) void {
}
    // rust: let (send, receive) = mpsc::channel();
    // rust: let saves = self.saves.clone();
    // rust: let folder = world.folder.clone();
    // rust: std::thread::spawn(move || {
    // rust: let _ = send.send(world_management::backup(&saves, &folder).map_err(|e| e.to_string()));
    // rust: });
    // rust: self.backup_shown.set(false);
    // rust: self.backup = Some(receive);
    // rust: self.mode = Mode::Backup { world };
}
    // rust: fn icon(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: world: &WorldEntry,
    // rust: slot: usize,
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) {
    // rust: let path = self.saves.join(&world.folder).join("icon.png");
    // rust: let mut icons = self.icons.borrow_mut();
    // rust: let pixels = if let Ok(modified) = std::fs::metadata(&path).and_then(|m| m.modified()) {
    // rust: let cached = icons
    // rust: .entry(path.clone())
    // rust: .or_insert_with(|| (std::time::UNIX_EPOCH, None));
    // rust: if cached.0 != modified {
    // rust: *cached = (
    // rust: modified,
    // rust: crate::hud::decode(&path)
    // rust: .ok()
    // rust: .filter(|(w, h, _)| *w == 64 && *h == 64)
    // rust: .map(|(_, _, p)| p),
    // rust: );
}
    // rust: cached.1.as_ref()
    // rust: } else {
    // rust: None
}
    // rust: let sprite = format!("horizon/world-icon{slot}");
    // rust: if let Some(pixels) = pixels
    // rust: && let Some(rect) = atlas.sprites.get(&sprite)
    // rust: {
    // rust: batch.patches.push(crate::font::Patch {
    // rust: x: (rect.u0 * atlas.width as f32).round() as u32,
    // rust: y: (rect.v0 * atlas.height as f32).round() as u32,
    // rust: width: 64,
    // rust: height: 64,
    // rust: rgba: pixels.clone(),
    // rust: });
    // rust: batch.sprite_scaled(atlas, &sprite, x, y, 32.0, 32.0, u32::MAX);
    // rust: } else {
    // rust: batch.sprite_scaled(atlas, "misc/unknown_server", x, y, 32.0, 32.0, u32::MAX);
}
}
    /// The worlds, newest first, cached for two seconds (drawn every frame).
    /// Saves changed behind the screens' back (agent control renamed or deleted a world): the
    /// list shows them again.
pub fn worlds_changed(self: *Self) void {
}
    // rust: if matches!(self.mode, Mode::Select { .. }) {
    // rust: self.return_to_list(None);
}
    // rust: *self.recent.borrow_mut() = None;
}
pub fn recent_worlds(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut recent = self.recent.borrow_mut();
    // rust: match &*recent {
    // rust: Some((at, worlds)) if at.elapsed().as_secs() < 2 => worlds.clone(),
    // rust: _ => {
    // rust: let worlds = list_worlds(&self.saves);
    // rust: *recent = Some((std::time::Instant::now(), worlds.clone()));
    // rust: worlds
}
}
}
    /// Create New World: the folder name and options (FileUtil.findAvailableName).
pub fn create_action(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: options,
    // rust: ..
    // rust: } = &self.mode
    // rust: else {
    // rust: return Action::None;
}
    // rust: Action::Create {
    // rust: folder: self.target_folder(name),
    // rust: name: name.clone(),
    // rust: seed: parse_seed(seed),
    // rust: creative: *creative,
    // rust: options: options.clone(),
}
}
    /// The folder a new world named `name` gets (`findResultFolder`).
pub fn target_folder(self: *Self, name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let base: String = name
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_alphanumeric() || c == ' ' || c == '-' || c == '_' {
    // rust: c
    // rust: } else {
    // rust: '_'
}
    // rust: })
    // rust: .collect();
    // rust: let base = if base.trim().is_empty() {
    // rust: "World".to_owned()
    // rust: } else {
    // rust: base.trim().to_owned()
}
        // FileUtil.findAvailableName: append (n) until unused.
    // rust: let mut folder = base.clone();
    // rust: let mut n = 1;
    // rust: while self.saves.join(&folder).exists() {
    // rust: folder = format!("{base} ({n})");
    // rust: n += 1;
}
    // rust: folder
}
pub fn buttons(self: *Self, w: f32, h: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
        // The game rules draw and press their own.
    // rust: if self.rules.borrow().is_some() {
    // rust: return Vec::new();
}
    // rust: let (w, h) = (w.ceil(), h.ceil());
    // rust: let b = |x: f32, y: f32, w: f32, label: &str, enabled: bool, id: u8| Button {
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: label: label.into(),
    // rust: enabled,
    // rust: id,
    // rust: icon: None,
    // rust: trailing: None,
    // rust: action: None,
}
    // rust: match &self.mode {
    // rust: Mode::Main => {
    // rust: let cx = (w / 2.0).floor();
    // rust: let y = (h / 4.0).floor() + 48.0;
    // rust: let mut buttons = vec![
    // rust: b(
    // rust: cx - 100.0,
    // rust: y,
    // rust: 200.0,
    // rust: &lang::get_or("menu.singleplayer", "Singleplayer"),
    // rust: true,
    // rust: 1,
    // rust: ),
    // rust: b(
    // rust: cx - 100.0,
    // rust: y + 24.0,
    // rust: 200.0,
    // rust: &lang::get_or("menu.multiplayer", "Multiplayer"),
    // rust: self.allows_multiplayer,
    // rust: 4,
    // rust: ),
    // rust: b(
    // rust: cx - 100.0,
    // rust: y + 48.0,
    // rust: 200.0,
    // rust: &lang::get_or("menu.online", "Minecraft Realms"),
                        // TitleScreen.createNormalMenuOptions: Realms is off when
                        // multiplayer is.
    // rust: self.allows_multiplayer,
    // rust: 8,
    // rust: ),
    // rust: b(
    // rust: cx - 100.0,
    // rust: y + 96.0,
    // rust: 98.0,
    // rust: &lang::get_or("menu.options", "Options..."),
    // rust: true,
    // rust: 3,
    // rust: )
    // rust: .does(crate::widgets::Action::Options),
    // rust: b(
    // rust: cx + 2.0,
    // rust: y + 96.0,
    // rust: 98.0,
    // rust: &lang::get_or("menu.quit", "Quit Game"),
    // rust: true,
    // rust: 2,
    // rust: )
    // rust: .does(crate::widgets::Action::Exit),
    // rust: ];
                // CommonButtons' icon buttons; Horizon's Join a Friend (an
                // invite code) sits behind vanilla's Friends button.
    // rust: for (i, (key, plain, id, icon)) in [
    // rust: ("gui.friends.open", "Friends", 5, "friends/friends"),
    // rust: ("options.language", "Language...", 6, "icon/language"),
    // rust: (
    // rust: "options.accessibility",
    // rust: "Accessibility Settings...",
    // rust: 7,
    // rust: "icon/accessibility",
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let mut button = b(
    // rust: cx - 34.0 + i as f32 * 24.0,
    // rust: y + 72.0,
    // rust: 20.0,
    // rust: &lang::get_or(key, plain),
    // rust: true,
    // rust: id,
    // rust: );
    // rust: button.icon = Some((icon, 15.0));
    // rust: buttons.push(button);
}
    // rust: buttons
}
    // rust: Mode::Select { worlds, selected } => {
    // rust: let world = selected.and_then(|i| worlds.get(i));
                // SelectWorldScreen.updateButtonStatus: primaryActionMessage, canEdit, canRecreate.
    // rust: let corrupted = world.is_some_and(|w| w.corrupted);
    // rust: let editable = world.is_some_and(WorldEntry::can_edit);
    // rust: let play = if corrupted {
    // rust: lang::get_or("recover_world.button", "Attempt to Recover")
    // rust: } else if world.is_some_and(|w| w.file_fixing) {
    // rust: lang::get_or("selectWorld.upgrade_and_play", "Upgrade and Play")
    // rust: } else {
    // rust: lang::get_or("selectWorld.select", "Play Selected World")
}
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 154.0,
    // rust: h - 52.0,
    // rust: 150.0,
    // rust: &play,
    // rust: world.is_some_and(WorldEntry::can_play),
    // rust: 10,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 4.0,
    // rust: h - 52.0,
    // rust: 150.0,
    // rust: &lang::get_or("selectWorld.create", "Create New World"),
    // rust: true,
    // rust: 11,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() - 154.0,
    // rust: h - 28.0,
    // rust: 71.0,
    // rust: &lang::get_or("selectWorld.edit", "Edit"),
    // rust: editable,
    // rust: 13,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() - 75.0,
    // rust: h - 28.0,
    // rust: 71.0,
    // rust: &lang::get_or("selectWorld.delete", "Delete"),
    // rust: selected.is_some(),
    // rust: 14,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 4.0,
    // rust: h - 28.0,
    // rust: 71.0,
    // rust: &lang::get_or("selectWorld.recreate", "Re-Create"),
    // rust: editable,
    // rust: 15,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 83.0,
    // rust: h - 28.0,
    // rust: 71.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 12,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::Create {
    // rust: creative, options, ..
    // rust: } => create_world::buttons(w, h, *creative, options),
    // rust: Mode::CreateFlat { flat, .. } => flat::buttons(w, h, flat),
    // rust: Mode::CreateBuffet { buffet, .. } => buffet::buttons(w, h, buffet),
    // rust: Mode::Edit { world, name, .. } => {
    // rust: let x = (w / 2.0).floor() - 100.0;
    // rust: let top = edit_top(h);
    // rust: vec![
    // rust: b(
    // rust: x,
    // rust: top + 64.0,
    // rust: 200.0,
    // rust: &lang::get_or("selectWorld.edit.resetIcon", "Reset Icon"),
    // rust: self.saves.join(&world.folder).join("icon.png").is_file(),
    // rust: 30,
    // rust: ),
    // rust: b(
    // rust: x,
    // rust: top + 89.0,
    // rust: 200.0,
    // rust: &lang::get_or("selectWorld.edit.openFolder", "Open World Folder"),
    // rust: true,
    // rust: 31,
    // rust: ),
    // rust: b(
    // rust: x,
    // rust: top + 114.0,
    // rust: 200.0,
    // rust: &lang::get_or("selectWorld.edit.backup", "Make Backup"),
    // rust: true,
    // rust: 32,
    // rust: ),
    // rust: b(
    // rust: x,
    // rust: top + 139.0,
    // rust: 200.0,
    // rust: &lang::get_or("selectWorld.edit.backupFolder", "Open Backups Folder"),
    // rust: true,
    // rust: 33,
    // rust: ),
    // rust: b(
    // rust: x,
    // rust: top + 164.0,
    // rust: 200.0,
    // rust: &lang::get_or("selectWorld.edit.optimize", "Optimize World"),
    // rust: true,
    // rust: 34,
    // rust: ),
    // rust: b(
    // rust: x,
    // rust: top + 214.0,
    // rust: 98.0,
    // rust: &lang::get_or("selectWorld.edit.save", "Save"),
    // rust: !name.trim().is_empty(),
    // rust: 35,
    // rust: ),
    // rust: b(
    // rust: x + 102.0,
    // rust: top + 214.0,
    // rust: 98.0,
    // rust: &lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 36,
    // rust: )
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: ]
}
    // rust: Mode::Delete { .. } => {
    // rust: let y = confirm_top(h, self.message_lines.get())
    // rust: + 41.0
    // rust: + self.message_lines.get() as f32 * 9.0;
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 152.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("selectWorld.deleteButton", "Delete"),
    // rust: true,
    // rust: 37,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 2.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 38,
    // rust: )
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: ]
}
    // rust: Mode::LowDiskSpace { .. } => {
    // rust: let y = confirm_top(h, self.message_lines.get())
    // rust: + 41.0
    // rust: + self.message_lines.get() as f32 * 9.0;
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 152.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.continue", "Continue"),
    // rust: true,
    // rust: 94,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 2.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 95,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::Recover { issues, .. } => {
    // rust: let y = recover_buttons_top(h, self.message_lines.get());
                // The restore button is active only when level.dat is the broken one
                // and level.dat_old reads.
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 60.0,
    // rust: y,
    // rust: 120.0,
    // rust: &lang::get_or("recover_world.restore", "Attempt to Restore"),
    // rust: issues[0].is_some() && issues[1].is_none(),
    // rust: 90,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() - 60.0,
    // rust: y + 28.0,
    // rust: 120.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 91,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::Recovered { success: true, .. } => {
    // rust: let y = confirm_top(h, self.message_lines.get())
    // rust: + 41.0
    // rust: + self.message_lines.get() as f32 * 9.0;
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 152.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.continue", "Continue"),
    // rust: true,
    // rust: 92,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 2.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 93,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::Recovered { success: false, .. } => {
                // AlertScreen.init: the button follows the text, kept inside the screen.
    // rust: let y = (90.0 + self.message_lines.get() as f32 * 9.0 + 12.0)
    // rust: .max(h / 6.0 + 96.0)
    // rust: .min(h - 24.0);
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 75.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 93,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::Error { alert, .. } => {
    // rust: let lines = self.message_lines.get();
    // rust: let y = if alert.is_some() {
                    // AlertScreen.init: the button follows the text, kept inside the screen.
    // rust: (90.0 + lines as f32 * 9.0 + 12.0)
    // rust: .max(h / 6.0 + 96.0)
    // rust: .min(h - 24.0)
    // rust: } else {
    // rust: confirm_top(h, lines) + 41.0 + lines as f32 * 9.0
}
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 75.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 39,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::BackupBeforeUpgrade { .. } => {
                // BackupConfirmScreen.init: the buttons sit under the text at fixed offsets.
    // rust: let y = 109.0 + self.message_lines.get() as f32 * 9.0;
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 155.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or(
    // rust: "selectWorld.backupJoinConfirmButton",
    // rust: "Create Backup and Load",
    // rust: ),
    // rust: true,
    // rust: 40,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 5.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("selectWorld.backupJoinSkipButton", "I Know What I'm Doing!"),
    // rust: true,
    // rust: 41,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() - 75.0,
    // rust: y + 24.0,
    // rust: 150.0,
    // rust: &lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 42,
    // rust: )
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: ]
}
    // rust: Mode::OptimizeConfirm { .. } => {
                // BackupConfirmScreen.init with the Erase Cached Data box: the buttons sit
                // under the text at fixed offsets.
    // rust: let y = 100.0 + (self.message_lines.get() as f32 + 1.0) * 9.0;
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 155.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or(
    // rust: "optimizeWorld.confirm.proceed",
    // rust: "Create Backup and Optimize",
    // rust: ),
    // rust: true,
    // rust: 43,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 5.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("selectWorld.backupJoinSkipButton", "I Know What I'm Doing!"),
    // rust: true,
    // rust: 44,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() - 75.0,
    // rust: y + 24.0,
    // rust: 150.0,
    // rust: &lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 45,
    // rust: )
    // rust: .does(crate::widgets::Action::Cancel),
    // rust: ]
}
            // No `does`: Escape is inert here on purpose, so B is too. A on the button stops it.
    // rust: Mode::Optimize { .. } => vec![b(
    // rust: (w / 2.0).floor() - 100.0,
    // rust: (h / 4.0).floor() + 150.0,
    // rust: 200.0,
    // rust: &lang::get_or("gui.cancel", "Cancel"),
    // rust: true,
    // rust: 46,
    // rust: )],
    // rust: Mode::MultiplayerWarning { .. } => {
    // rust: let lines = self.message_lines.get();
    // rust: let y = warning_top(h, lines) + 82.0 + lines as f32 * 9.0;
    // rust: vec![
    // rust: b(
    // rust: (w / 2.0).floor() - 154.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.proceed", "Proceed"),
    // rust: true,
    // rust: 70,
    // rust: ),
    // rust: b(
    // rust: (w / 2.0).floor() + 4.0,
    // rust: y,
    // rust: 150.0,
    // rust: &lang::get_or("gui.back", "Back"),
    // rust: true,
    // rust: 71,
    // rust: )
    // rust: .does(crate::widgets::Action::Back),
    // rust: ]
}
    // rust: Mode::Onboarding(_) => self.onboarding_buttons(w, h),
    // rust: Mode::BanNotice(_) => {
                // ConfirmLinkScreen.addButtons: Open in Browser, Copy to Clipboard, then the
                // notice's Acknowledge, 100 wide each.
    // rust: let labels = [
    // rust: lang::get_or("chat.link.open", "Open in Browser"),
    // rust: lang::get_or("chat.copy", "Copy to Clipboard"),
    // rust: lang::get_or("gui.acknowledge", "Acknowledge"),
    // rust: ];
    // rust: let positions = self.ban_buttons.get();
    // rust: (0..3)
    // rust: .map(|i| {
    // rust: b(
    // rust: positions[i].0,
    // rust: positions[i].1,
    // rust: 100.0,
    // rust: &labels[i],
    // rust: true,
    // rust: 120 + i as u8,
    // rust: )
    // rust: })
    // rust: .collect()
}
    // rust: Mode::Backup { .. } => Vec::new(),
    // rust: Mode::Multiplayer(screen) => screen
    // rust: .buttons(w, h)
    // rust: .into_iter()
    // rust: .map(|(x, y, bw, label, enabled, id)| {
    // rust: let mut button = b(x, y, bw, &label, enabled, id);
    // rust: button.action = crate::multiplayer::button_action(id);
    // rust: button
    // rust: })
    // rust: .collect(),
    // rust: Mode::Realms(screen) => screen
    // rust: .buttons(w, h)
    // rust: .into_iter()
    // rust: .map(|(x, y, bw, label, enabled, id, icon)| {
    // rust: let mut btn = b(x, y, bw, &label, enabled, id);
    // rust: btn.icon = icon;
    // rust: btn
    // rust: })
    // rust: .collect(),
}
}
    /// The screen this mode is, as the narrator reads it: its id and
    /// `getNarrationMessage` (the title, or `joinForNarration(title, message)`
    /// for the confirm and alert screens). `None` for the screens that
    /// narrate themselves.
pub fn narration(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::widgets::{ScreenInfo, join_for_narration as join};
    // rust: let get = |key: &str, fallback: &str| lang::get_or(key, fallback);
    // rust: let info = match &self.mode {
            // TitleScreen: `narrator.screen.title`, not its (empty) title.
    // rust: Mode::Main => ScreenInfo::new("title", get("narrator.screen.title", "Title Screen")),
    // rust: Mode::Select { .. } => {
    // rust: ScreenInfo::new("select_world", get("selectWorld.title", "Select World"))
}
    // rust: Mode::Create { .. } => ScreenInfo::new(
    // rust: "create_world",
    // rust: get("selectWorld.create", "Create New World"),
    // rust: ),
            // PresetFlatWorldScreen over CreateFlatWorldScreen.
    // rust: Mode::CreateFlat { flat, .. } if flat.page == flat::Page::Presets => ScreenInfo::new(
    // rust: "create_world/flat/presets",
    // rust: get("createWorld.customize.presets.title", "Select a Preset"),
    // rust: ),
    // rust: Mode::CreateFlat { .. } => ScreenInfo::new(
    // rust: "create_world/flat",
    // rust: get(
    // rust: "createWorld.customize.flat.title",
    // rust: "Superflat Customization",
    // rust: ),
    // rust: ),
    // rust: Mode::CreateBuffet { .. } => ScreenInfo::new(
    // rust: "create_world/buffet",
    // rust: get(
    // rust: "createWorld.customize.buffet.title",
    // rust: "Single Biome Customization",
    // rust: ),
    // rust: ),
    // rust: Mode::Edit { .. } => {
    // rust: ScreenInfo::new("edit_world", get("selectWorld.edit.title", "Edit World"))
}
            // EditWorldScreen.makeBackupAndShowToast: a GenericWaitingScreen.
    // rust: Mode::Backup { .. } => ScreenInfo::new(
    // rust: "backup",
    // rust: join(&[
    // rust: &get("selectWorld.waitingForBackup.title", "Creating Backup"),
    // rust: &get(
    // rust: "selectWorld.waitingForBackup.message",
    // rust: "Depending on the size of your world, this may take a while. Please do not close the game or shut off your device.",
    // rust: ),
    // rust: ]),
    // rust: ),
            // BackupConfirmScreen narrates its title, the question.
    // rust: Mode::BackupBeforeUpgrade { downgrade, .. } => {
    // rust: let question = match downgrade {
    // rust: Some(_) => get(
    // rust: "selectWorld.backupQuestion.downgrade",
    // rust: "Downgrading a world is not supported",
    // rust: ),
    // rust: None => get(
    // rust: "selectWorld.backupQuestion.file_fixing_required",
    // rust: "Create a backup before upgrading this world?",
    // rust: ),
}
    // rust: ScreenInfo::new("backup_confirm", question)
}
            // EditWorldScreen's Optimize World: a BackupConfirmScreen, which
            // narrates its title.
    // rust: Mode::OptimizeConfirm { .. } => ScreenInfo::new(
    // rust: "optimize_confirm",
    // rust: get("optimizeWorld.confirm.title", "Optimize World"),
    // rust: ),
    // rust: Mode::Optimize { world } => ScreenInfo::new(
    // rust: "optimize_world",
    // rust: translate(
    // rust: "optimizeWorld.title",
    // rust: "Optimizing World '%s'",
    // rust: &[&world.name],
    // rust: ),
    // rust: ),
            // openWorldCheckDiskSpace's ConfirmScreen.
    // rust: Mode::LowDiskSpace { .. } => ScreenInfo::new(
    // rust: "low_disk_space",
    // rust: join(&[
    // rust: &get(
    // rust: "selectWorld.warning.lowDiskSpace.title",
    // rust: "Warning! Low disk space!",
    // rust: ),
    // rust: &get(
    // rust: "selectWorld.warning.lowDiskSpace.description",
    // rust: "There is not much space left on your device.
    // rust: Running out of disk space while in game can lead to your world being damaged.",
    // rust: ),
    // rust: ]),
    // rust: ),
            // AccessibilityOnboardingScreen narrates its title.
    // rust: Mode::Onboarding(_) => ScreenInfo::new(
    // rust: "accessibility_onboarding",
    // rust: get(
    // rust: "accessibility.onboarding.screen.title",
    // rust: "Welcome to Minecraft!

    // rust: Would you like to enable the Narrator or visit the Accessibility Settings?",
    // rust: ),
    // rust: ),
            // BanNoticeScreens: a ConfirmLinkScreen, its title and message.
    // rust: Mode::BanNotice(notice) => {
    // rust: let now = chrono::Utc::now().timestamp_millis();
    // rust: ScreenInfo::new(
    // rust: "ban_notice",
    // rust: join(&[&notice.title().plain(), &notice.message(now).plain()]),
    // rust: )
}
    // rust: Mode::Delete { world } => ScreenInfo::new(
    // rust: "delete_world",
    // rust: join(&[
    // rust: &get(
    // rust: "selectWorld.deleteQuestion",
    // rust: "Are you sure you want to delete this world?",
    // rust: ),
    // rust: &translate(
    // rust: "selectWorld.deleteWarning",
    // rust: "'%s' will be lost forever! (A long time!)",
    // rust: &[&world.name],
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: Mode::Recover { world, .. } => {
    // rust: let message = format_translation(
    // rust: &get(
    // rust: "recover_world.message",
    // rust: "The following issues occurred while trying to read world folder \"%s\".\nIt might be possible to restore the world from an older state or you can report this issue on the bug tracker.",
    // rust: ),
    // rust: &[Text::literal(world.folder.clone())],
    // rust: );
    // rust: ScreenInfo::new(
    // rust: "recover_world",
    // rust: join(&[
    // rust: &get("recover_world.title", "Failed to load world"),
    // rust: &message.plain(),
    // rust: ]),
    // rust: )
}
    // rust: Mode::Recovered { success, .. } => {
    // rust: let message = if *success {
    // rust: get("recover_world.done.success", "Recovery was successful!")
    // rust: } else {
    // rust: get(
    // rust: "recover_world.done.failed",
    // rust: "Failed to recover from previous state.",
    // rust: )
}
    // rust: ScreenInfo::new(
    // rust: "recover_world/done",
    // rust: join(&[&get("recover_world.done.title", "Recovery done"), &message]),
    // rust: )
}
    // rust: Mode::Error { message, alert, .. } => {
    // rust: let title = match alert {
    // rust: Some(Alert::Incompatible) => {
    // rust: get("selectWorld.incompatible.title", "Incompatible version")
}
    // rust: Some(Alert::Recreate) => {
    // rust: get("selectWorld.recreate.error.title", "An error occurred!")
}
    // rust: Some(Alert::Symlink) => get(
    // rust: "symlink_warning.title.world",
    // rust: "The world folder contains links",
    // rust: ),
    // rust: None => get("selectWorld.access_failure", "Failed to access world"),
}
    // rust: ScreenInfo::new("world_error", join(&[&title, message]))
}
            // SafetyScreen: WarningScreen's narration, the header and the
            // message on the next line.
    // rust: Mode::MultiplayerWarning { .. } => ScreenInfo::new(
    // rust: "multiplayer_warning",
    // rust: format!(
    // rust: "{}\n{}",
    // rust: get(
    // rust: "multiplayerWarning.header",
    // rust: "Caution: Third-Party Online Play"
    // rust: ),
    // rust: get(
    // rust: "multiplayerWarning.message",
    // rust: "Caution: Online play is offered by third-party servers that are not owned, operated, or supervised by Mojang Studios or Microsoft. During online play, you may be exposed to unmoderated chat messages or other types of user-generated content that may not be suitable for everyone.",
    // rust: ),
    // rust: ),
    // rust: ),
    // rust: Mode::Realms(_) => ScreenInfo::new("realms", lang::get("menu.online")),
    // rust: Mode::Multiplayer(_) => return None,
}
    // rust: Some(info)
}

    /// A button's narration: `gui.narrate.button` of its label, or the icon
    /// buttons' own message and tooltip, in the order the screen adds them.
pub fn button_narration(self: *Self, b: *Button) c {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::widgets::Narratable;
    // rust: let rect = [b.x, b.y, b.w, 20.0];
    // rust: match &self.mode {
    // rust: Mode::Main => {}
    // rust: Mode::Create {
    // rust: creative, options, ..
    // rust: } => return create_world::button_narration(b, *creative, options),
    // rust: Mode::Multiplayer(screen) => {
    // rust: return screen.button_narration(b.id, rect, &b.label, b.enabled);
}
    // rust: _ => return Narratable::button(b.label.clone(), rect, b.enabled),
}
        // CommonButtons and FriendsButton narrate their `.narration`, and
        // read their tooltip as a hint.
    // rust: let icon = |narration: &str, tooltip: &str| {
    // rust: Narratable::named(narration_text(narration, &[]), rect, b.enabled)
    // rust: .hint(narration_text(tooltip, &[]))
}
    // rust: let narratable = match b.id {
    // rust: 5 => icon("gui.friends.open.narration", "gui.friends.open.tooltip"),
    // rust: 6 => icon("options.language.narration", "options.language.tooltip"),
    // rust: 7 => icon(
    // rust: "accessibility.onboarding.accessibility.button.narration",
    // rust: "options.accessibility.tooltip",
    // rust: ),
    // rust: _ => Narratable::button(b.label.clone(), rect, b.enabled),
}
        // TitleScreen.init adds the icon row after Minecraft Realms and before
        // Options... and Quit Game, which Horizon draws first.
    // rust: narratable.order(match b.id {
    // rust: 5..=7 => 1,
    // rust: 2 | 3 => 2,
    // rust: _ => 0,
    // rust: })
}

    // rust: pub fn draw(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: hide_splash: bool,
    // rust: ) {
    // rust: self.draw_with_items(atlas, None, batch, cursor, hide_splash, false);
}
    /// [`Title::draw`] with the item models, which draw the item icons of the
    /// Superflat screens the way `GuiGraphics.renderItem` does.
    // rust: pub fn draw_with_items(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: items: Option<&crate::item_render::ItemRenderer>,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: hide_splash: bool,
    // rust: hide_server_address: bool,
    // rust: ) {
    // rust: let (w, h) = (batch.width.ceil(), batch.height.ceil());
    // rust: if let Some(rules) = self.rules.borrow_mut().as_mut() {
    // rust: return rules.draw(batch, atlas, cursor);
}
    // rust: if self.preparing {
            // `CreateWorldScreen.openCreateWorldScreen`'s queued
            // `GenericMessageScreen`: the menu background and the message
            // alone, centred, no progress.
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let text =
    // rust: crate::lang::get_or("createWorld.preparing", "Preparing for world creation...");
    // rust: let tw = atlas.font.width_text(&Text::literal(text.clone()));
    // rust: let (tx, ty) = (w / 2.0 - tw / 2.0, h / 2.0 - 4.5);
            // `FocusableTextWidget.builder(title, font, 12)`: 12 pixels of
            // padding around the text, on a black box with a 1-pixel border.
    // rust: let (bx, by) = (tx - 12.0, ty - 12.0);
    // rust: let (bw, bh) = (tw + 24.0, 9.0 + 24.0);
    // rust: batch.fill(atlas, bx - 1.0, by - 1.0, bw + 2.0, bh + 2.0, 0xFFD0D0D0);
    // rust: batch.fill(atlas, bx, by, bw, bh, 0xFF000000);
    // rust: batch.text(atlas, &text, tx, ty, u32::MAX, false);
    // rust: return;
}
    // rust: if let Some(screen) = self.confirm_experiments.borrow().as_ref() {
    // rust: return screen.draw(batch, atlas, cursor);
}
    // rust: if let Some(screen) = self.experiments.borrow().as_ref() {
    // rust: return screen.draw(batch, atlas, cursor);
}
    // rust: let mut fade_from = None;
    // rust: if crate::widgets::narrating()
    // rust: && let Some(info) = self.narration()
    // rust: {
    // rust: crate::widgets::begin_screen(|| info);
}
    // rust: match &self.mode {
    // rust: Mode::Main => {
    // rust: draw_logo(atlas, batch, w);
    // rust: if !hide_splash && let Some(splash) = self.splash.as_deref() {
    // rust: let tw = HudBatch::text_width(atlas, splash);
    // rust: let start = batch.vertices.len();
    // rust: batch.text(
    // rust: atlas,
    // rust: splash,
    // rust: -(tw / 2.0).floor(),
    // rust: -8.0,
    // rust: rgba(255, 255, 0, 255),
    // rust: true,
    // rust: );
    // rust: let scale = (1.8
    // rust: - (self.started.elapsed().as_secs_f32() * std::f32::consts::TAU)
    // rust: .sin()
    // rust: .abs()
    // rust: * 0.1)
    // rust: * 100.0
    // rust: / (tw + 32.0);
    // rust: let (sin, cos) = (-20.0f32).to_radians().sin_cos();
    // rust: for v in &mut batch.vertices[start..] {
    // rust: let [x, y] = v.pos;
    // rust: v.pos = [
    // rust: w / 2.0 + 123.0 + scale * (x * cos - y * sin),
    // rust: 69.0 + scale * (x * sin + y * cos),
    // rust: ];
}
}
    // rust: let version = format!("Horizon {} (Rust)", horizon_core::VANILLA_VERSION);
    // rust: batch.text(atlas, &version, 2.0, h - 10.0, u32::MAX, true);
                // A nightly names its build in the top-left corner, the one spot no button reaches at any GUI
                // scale, so screenshots and reports say which build they come from.
    // rust: if let Some(nightly) = horizon_core::release::nightly_label() {
    // rust: batch.text(atlas, &nightly, 2.0, 2.0, u32::MAX, true);
}
    // rust: let notice = &lang::get_or(
    // rust: "horizon.title.not_affiliated",
    // rust: "Not affiliated with Mojang or Microsoft",
    // rust: );
                // TitleScreen.init's `PlainTextButton`: the text's width wide, 10
                // high at `height - 10`; `extractContents` underlines it while
                // hovered or focused, and its press opens the credits.
    // rust: let tw = HudBatch::text_width(atlas, notice).ceil();
    // rust: let rect = [w - tw - 2.0, h - 10.0, tw, 10.0];
    // rust: self.credits_button.set(rect);
    // rust: crate::widgets::record(notice, rect, true);
    // rust: let inside = cursor.0 >= rect[0]
    // rust: && cursor.0 < rect[0] + rect[2]
    // rust: && cursor.1 >= rect[1]
    // rust: && cursor.1 < rect[1] + rect[3];
    // rust: crate::widgets::widget_cursor(inside, true);
    // rust: let mut text = Text::literal(notice);
    // rust: if inside {
    // rust: text = text.underlined();
}
    // rust: batch.text_styled(atlas, &text, rect[0], rect[1], u32::MAX, true);
}
    // rust: Mode::Select { worlds, selected } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or("selectWorld.title", "Select World"),
    // rust: 8.0,
    // rust: u32::MAX,
    // rust: );
    // rust: self.caret.borrow_mut().draw(
    // rust: batch,
    // rust: atlas,
    // rust: (SEARCH, &self.search, 50),
    // rust: [(w / 2.0).floor() - 100.0, 21.0, 200.0, 20.0],
    // rust: self.search_focused,
    // rust: self.started,
    // rust: );
    // rust: crate::widgets::name_last_edit_box(|| narration_text("selectWorld.search", &[]));
    // rust: if self.search.is_empty() && !self.search_focused {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &Text::literal(lang::get_or("gui.selectWorld.search", "Search..."))
    // rust: .italic()
    // rust: .with_color(crate::text::GRAY),
    // rust: (w / 2.0).floor() - 96.0,
    // rust: 27.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: let (top, bottom, left, content) = self.world_list(worlds, (w, h));
    // rust: let mut scroll = self.scroll.get();
    // rust: scroll.clamp(top, bottom, content);
    // rust: self.scroll.set(scroll);
    // rust: let offset = scroll.amount.trunc();
                // AbstractSelectionList: background, rows clipped to the
                // list, separators, scrollbar.
    // rust: crate::ui::list_background(batch, atlas, top, bottom, false);
    // rust: let first = batch.vertices.len();
                // Entry content sits 2 pixels inside its row.
    // rust: let x = left + 2.0;
    // rust: let mut slot = 0;
    // rust: let hovered = self.world_row_at(worlds, cursor, (w, h));
                // WorldSelectionList: the row under the mouse, else the
                // selected one.
    // rust: crate::widgets::narratable(|| {
//                     use crate::widgets::{ListKind, Narratable, Row};
    // rust: let rows: Vec<&WorldEntry> =
    // rust: self.visible_worlds(worlds).map(|(_, w)| w).collect();
    // rust: let row = |r: usize| Row::new(r, world_narration(rows[r]));
    // rust: let selected = self
    // rust: .visible_worlds(worlds)
    // rust: .position(|(i, _)| Some(i) == *selected);
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: rows.len(),
    // rust: hovered.map(|(r, _)| row(r)),
    // rust: selected.map(row),
    // rust: [0.0, top, w, bottom - top],
    // rust: )
    // rust: .key(crate::widgets::key_of(&"select_world/worlds"))
    // rust: });
    // rust: for (row, (i, world)) in self.visible_worlds(worlds).enumerate() {
    // rust: let y = top + 4.0 + row as f32 * ROW_HEIGHT - offset;
    // rust: if y + 32.0 <= top || y >= bottom {
    // rust: continue;
}
    // rust: let mid = y - 2.0 + ROW_HEIGHT / 2.0;
    // rust: if mid > top && mid < bottom {
    // rust: let rect = [x - 2.0, y - 2.0, ROW_WIDTH, ROW_HEIGHT];
                        // The control socket's widget tree names the row.
    // rust: crate::widgets::record_as(
    // rust: &world.name,
    // rust: rect,
    // rust: true,
    // rust: crate::widgets::Kind::Row,
    // rust: );
    // rust: crate::widgets::target_as(rect, crate::widgets::Kind::Row);
}
                    // extractSelection: white once the list has focus.
    // rust: if *selected == Some(i) {
    // rust: batch.fill(atlas, x - 2.0, y - 2.0, ROW_WIDTH, ROW_HEIGHT, u32::MAX);
    // rust: batch.fill(
    // rust: atlas,
    // rust: x - 1.0,
    // rust: y - 1.0,
    // rust: ROW_WIDTH - 2.0,
    // rust: ROW_HEIGHT - 2.0,
    // rust: rgba(0, 0, 0, 255),
    // rust: );
}
    // rust: batch.text(atlas, &world.name, x + 35.0, y + 1.0, u32::MAX, true);
    // rust: let date: chrono::DateTime<chrono::Local> = world.modified.into();
    // rust: let line = format!("{} ({})", world.folder, date.format("%d/%m/%Y, %H:%M"));
    // rust: batch.text(
    // rust: atlas,
    // rust: &line,
    // rust: x + 35.0,
    // rust: y + 12.0,
    // rust: rgba(128, 128, 128, 255),
    // rust: true,
    // rust: );
    // rust: let details = world_info(world);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &details,
    // rust: x + 35.0,
    // rust: y + 21.0,
    // rust: rgba(128, 128, 128, 255),
    // rust: true,
    // rust: );
    // rust: self.icon(atlas, batch, world, slot, x, y);
    // rust: slot = (slot + 1) % crate::hud::WORLD_ICON_SLOTS;
                    // WorldListEntry.extractContent: a hovered row dims its
                    // icon under the join arrow, lit under the pointer.
    // rust: if let Some((_, (rx, ry))) = hovered.filter(|(r, _)| *r == row) {
    // rust: batch.fill(atlas, x, y, 32.0, 32.0, 0xA0909090);
    // rust: let on_icon = (0.0..32.0).contains(&rx) && (0.0..32.0).contains(&ry);
                        // The icon says what a click does.
    // rust: let names: &[&str] = if world.corrupted {
    // rust: &["error", "marked_join"]
    // rust: } else if world.disabled() {
    // rust: &["error"]
    // rust: } else if world.downgrade {
    // rust: &["marked_join", "error"]
    // rust: } else if world.should_backup() {
    // rust: &["marked_join"]
    // rust: } else {
    // rust: &["join"]
}
    // rust: let lit = if on_icon { "_highlighted" } else { "" };
    // rust: for name in names {
    // rust: let sprite = format!("gui/sprites/world_list/{name}{lit}");
    // rust: batch.sprite_scaled(atlas, &sprite, x, y, 32.0, 32.0, u32::MAX);
}
}
}
                // Clip list quads, including their UVs, to the content area.
    // rust: for quad in batch.vertices[first..].as_chunks_mut::<6>().0 {
    // rust: let low = quad.iter().map(|v| v.pos[1]).fold(f32::INFINITY, f32::min);
    // rust: let high = quad
    // rust: .iter()
    // rust: .map(|v| v.pos[1])
    // rust: .fold(f32::NEG_INFINITY, f32::max);
    // rust: let uv_top = quad.iter().map(|v| v.uv[1]).fold(f32::INFINITY, f32::min);
    // rust: let uv_bot = quad
    // rust: .iter()
    // rust: .map(|v| v.uv[1])
    // rust: .fold(f32::NEG_INFINITY, f32::max);
    // rust: for v in quad {
    // rust: v.pos[1] = v.pos[1].clamp(top, bottom);
    // rust: if high > low {
    // rust: v.uv[1] = uv_top + (uv_bot - uv_top) * (v.pos[1] - low) / (high - low);
}
}
}
    // rust: crate::ui::separators(batch, atlas, top, bottom, false);
    // rust: crate::ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: left + ROW_WIDTH + 8.0,
    // rust: top,
    // rust: bottom,
    // rust: content,
    // rust: scroll.amount,
    // rust: );
}
    // rust: Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: focus,
    // rust: options,
    // rust: ..
    // rust: } => self.draw_create(atlas, batch, cursor, name, seed, *focus, options),
    // rust: Mode::CreateFlat { flat, .. } => flat::draw(self, atlas, items, batch, cursor, flat),
    // rust: Mode::CreateBuffet { buffet, .. } => buffet::draw(self, atlas, batch, cursor, buffet),
    // rust: Mode::Edit { name, focused, .. } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or("selectWorld.edit.title", "Edit World"),
    // rust: 15.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let top = edit_top(h);
    // rust: batch.text(
    // rust: atlas,
    // rust: &lang::get_or("selectWorld.enterName", "World Name"),
    // rust: (w / 2.0).floor() - 100.0,
    // rust: top + 25.0,
    // rust: rgba(160, 160, 160, 255),
    // rust: true,
    // rust: );
    // rust: self.caret.borrow_mut().draw(
    // rust: batch,
    // rust: atlas,
    // rust: (EDIT_NAME, name, 32),
    // rust: [(w / 2.0).floor() - 100.0, top + 39.0, 200.0, 20.0],
    // rust: *focused,
    // rust: self.started,
    // rust: );
    // rust: crate::widgets::name_last_edit_box(|| narration_text("selectWorld.enterName", &[]));
}
    // rust: Mode::Delete { world } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let message = translate(
    // rust: "selectWorld.deleteWarning",
    // rust: "'%s' will be lost forever! (A long time!)",
    // rust: &[&world.name],
    // rust: );
    // rust: let lines = wrapped(atlas, &message, w - 50.0);
    // rust: self.message_lines.set(lines.len());
    // rust: let top = confirm_top(h, lines.len());
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or(
    // rust: "selectWorld.deleteQuestion",
    // rust: "Are you sure you want to delete this world?",
    // rust: ),
    // rust: top,
    // rust: u32::MAX,
    // rust: );
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(atlas, batch, line, top + 17.0 + i as f32 * 9.0, u32::MAX);
}
}
    // rust: Mode::Recover { world, issues } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let dir = self.saves.join(&world.folder);
    // rust: let title =
    // rust: Text::literal(lang::get_or("recover_world.title", "Failed to load world"))
    // rust: .bold();
    // rust: let message = format_translation(
    // rust: &lang::get_or(
    // rust: "recover_world.message",
    // rust: "The following issues occurred while trying to read world folder \"%s\".\nIt might be possible to restore the world from an older state or you can report this issue on the bug tracker.",
    // rust: ),
    // rust: &[Text::colored(world.folder.clone(), GRAY)],
    // rust: );
    // rust: let message: Vec<Text> = atlas
    // rust: .font
    // rust: .split_lines(&message, w - 50.0)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .collect();
    // rust: let issues: Vec<Text> = [false, true]
    // rust: .into_iter()
    // rust: .zip(issues)
    // rust: .filter_map(|(old, issue)| recover_info(&dir, old, issue.as_ref()))
    // rust: .flat_map(|info| atlas.font.split_lines(&info, w - 50.0))
    // rust: .map(|(line, _)| line)
    // rust: .collect();
    // rust: self.message_lines.set(message.len() + issues.len());
    // rust: let row = recover_buttons_top(h, message.len() + issues.len());
    // rust: let top = row - 8.0 - 8.0 - (message.len() + issues.len()) as f32 * 9.0 - 8.0 - 9.0;
    // rust: let center =
    // rust: |text: &Text| (w / 2.0).floor() - (atlas.font.width_text(text) / 2.0).floor();
    // rust: batch.text_styled(atlas, &title, center(&title), top, u32::MAX, true);
    // rust: let mut y = top + 17.0;
    // rust: for line in &message {
    // rust: batch.text_styled(atlas, line, center(line), y, u32::MAX, true);
    // rust: y += 9.0;
}
                // The issues widget is left aligned, the widget centred.
    // rust: let width = issues
    // rust: .iter()
    // rust: .map(|l| atlas.font.width_text(l))
    // rust: .fold(0.0, f32::max);
    // rust: let x = (w / 2.0).floor() - (width / 2.0).floor();
    // rust: for line in &issues {
    // rust: batch.text_styled(atlas, line, x, y + 8.0, u32::MAX, true);
    // rust: y += 9.0;
}
}
    // rust: Mode::Recovered { success, .. } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let title = lang::get_or("recover_world.done.title", "Recovery done");
    // rust: let message = if *success {
    // rust: lang::get_or("recover_world.done.success", "Recovery was successful!")
    // rust: } else {
    // rust: lang::get_or(
    // rust: "recover_world.done.failed",
    // rust: "Failed to recover from previous state.",
    // rust: )
}
    // rust: let lines = wrapped(atlas, &message, w - 50.0);
    // rust: self.message_lines.set(lines.len());
                // ConfirmScreen centres its column; AlertScreen puts the title at 70, the text at 90.
    // rust: let (top, text_top) = if *success {
    // rust: let top = confirm_top(h, lines.len());
    // rust: (top, top + 17.0)
    // rust: } else {
    // rust: (70.0, 90.0)
}
    // rust: centered(atlas, batch, &title, top, u32::MAX);
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(atlas, batch, line, text_top + i as f32 * 9.0, u32::MAX);
}
}
    // rust: Mode::BackupBeforeUpgrade {
    // rust: downgrade, stem, ..
    // rust: } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
                // BackupStatus.DOWNGRADE is severe: its question is red (-2142128).
    // rust: let (question, warning, color) = match (downgrade, stem) {
    // rust: (None, Some(StemIssue::Customized)) => (
    // rust: lang::get_or(
    // rust: "selectWorld.backupQuestion.customized",
    // rust: "Customized worlds are no longer supported",
    // rust: ),
    // rust: lang::get_or(
    // rust: "selectWorld.backupWarning.customized",
    // rust: "Unfortunately, we do not support customized worlds in this version of Minecraft. We can still load this world and keep everything the way it was, but any newly generated terrain will no longer be customized. We're sorry for the inconvenience!",
    // rust: ),
    // rust: u32::MAX,
    // rust: ),
    // rust: (None, Some(StemIssue::Experimental)) => (
    // rust: lang::get_or(
    // rust: "selectWorld.backupQuestion.experimental",
    // rust: "Worlds using Experimental Settings are not supported",
    // rust: ),
    // rust: lang::get_or(
    // rust: "selectWorld.backupWarning.experimental",
    // rust: "This world uses experimental settings that could stop working at any time. We cannot guarantee it will load or work. Here be dragons!",
    // rust: ),
    // rust: u32::MAX,
    // rust: ),
    // rust: (Some(version), _) => (
    // rust: lang::get_or(
    // rust: "selectWorld.backupQuestion.downgrade",
    // rust: "Downgrading a world is not supported",
    // rust: ),
    // rust: translate(
    // rust: "selectWorld.backupWarning.downgrade",
    // rust: "This world was last played in version %s; you are on version %s. Downgrading a world could cause corruption - we cannot guarantee that it will load or work. If you still want to continue, please make a backup.",
    // rust: &[version, &crate::save::VERSION_NAME],
    // rust: ),
    // rust: rgba(223, 80, 80, 255),
    // rust: ),
    // rust: (None, None) => (
    // rust: lang::get_or(
    // rust: "selectWorld.backupQuestion.file_fixing_required",
    // rust: "Create a backup before upgrading this world?",
    // rust: ),
    // rust: lang::get_or(
    // rust: "selectWorld.backupWarning.file_fixing_required",
    // rust: "This world needs to be upgraded before you can play it. We strongly suggest creating a backup before continuing in case you experience world corruption.",
    // rust: ),
    // rust: u32::MAX,
    // rust: ),
}
    // rust: let lines = wrapped(atlas, &warning, w - 50.0);
    // rust: self.message_lines.set(lines.len());
                // BackupConfirmScreen.extractRenderState: the title at 50, the text from 70.
    // rust: centered(atlas, batch, &question, 50.0, color);
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(atlas, batch, line, 70.0 + i as f32 * 9.0, u32::MAX);
}
}
    // rust: Mode::OptimizeConfirm { erase_cache, .. } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let description = lang::get_or(
    // rust: "optimizeWorld.confirm.description",
    // rust: "This will attempt to optimize your world by making sure all data is stored in the most recent game format. This can take a very long time, depending on your world. Once done, your world may play faster but will no longer be compatible with older versions of the game. Are you sure you wish to proceed?",
    // rust: );
    // rust: let lines = wrapped(atlas, &description, w - 50.0);
    // rust: self.message_lines.set(lines.len());
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or("optimizeWorld.confirm.title", "Optimize World"),
    // rust: 50.0,
    // rust: u32::MAX,
    // rust: );
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(atlas, batch, line, 70.0 + i as f32 * 9.0, u32::MAX);
}
                // The Checkbox: at `width / 2 - 155 + 80`, `76 + textSize`.
    // rust: let label = lang::get_or("selectWorld.backupEraseCache", "Erase Cached Data");
    // rust: let width = BOX + 4.0 + HudBatch::text_width(atlas, &label).ceil();
    // rust: let x = (w / 2.0).floor() - 155.0 + 80.0;
    // rust: let y = 76.0 + (lines.len() as f32 + 1.0) * 9.0;
    // rust: self.erase_check.set([x, y, width, BOX]);
    // rust: crate::widgets::target([x, y, width, BOX]);
    // rust: let hover = (x..x + width).contains(&cursor.0) && (y..y + BOX).contains(&cursor.1);
    // rust: let sprite = match (*erase_cache, hover) {
    // rust: (true, true) => "gui/sprites/widget/checkbox_selected_highlighted",
    // rust: (true, false) => "gui/sprites/widget/checkbox_selected",
    // rust: (false, true) => "gui/sprites/widget/checkbox_highlighted",
    // rust: (false, false) => "gui/sprites/widget/checkbox",
}
    // rust: batch.sprite_scaled(atlas, sprite, x, y, BOX, BOX, u32::MAX);
    // rust: batch.text(
    // rust: atlas,
    // rust: &label,
    // rust: x + BOX + 4.0,
    // rust: y + 4.0,
    // rust: rgba(224, 224, 224, 255),
    // rust: true,
    // rust: );
}
    // rust: Mode::Optimize { world } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: self.draw_optimize(atlas, batch, w, h, &world.name);
}
    // rust: Mode::LowDiskSpace { .. } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let message = lang::get_or(
    // rust: "selectWorld.warning.lowDiskSpace.description",
    // rust: "There is not much space left on your device.\nRunning out of disk space while in game can lead to your world being damaged.",
    // rust: );
    // rust: let lines = wrapped(atlas, &message, w - 50.0);
    // rust: self.message_lines.set(lines.len());
    // rust: let top = confirm_top(h, lines.len());
                // ChatFormatting.RED.
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or(
    // rust: "selectWorld.warning.lowDiskSpace.title",
    // rust: "Warning! Low disk space!",
    // rust: ),
    // rust: top,
    // rust: rgba(255, 85, 85, 255),
    // rust: );
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(atlas, batch, line, top + 17.0 + i as f32 * 9.0, u32::MAX);
}
}
    // rust: Mode::Backup { .. } => {
    // rust: self.backup_shown.set(true);
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: &lang::get_or("selectWorld.waitingForBackup.title", "Creating Backup"),
    // rust: 80.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let dots = ["O o o", "o O o", "o o O", "o O o"]
    // rust: [(self.started.elapsed().as_millis() / 300 % 4) as usize];
    // rust: centered(atlas, batch, dots, 120.0, rgba(128, 128, 128, 255));
    // rust: let message = lang::get_or(
    // rust: "selectWorld.waitingForBackup.message",
    // rust: "Depending on the size of your world, this may take a while. Please do not close the game or shut off your device.",
    // rust: );
    // rust: for (i, line) in wrapped(atlas, &message, 360.0).iter().enumerate() {
    // rust: centered(
    // rust: atlas,
    // rust: batch,
    // rust: line,
    // rust: 132.0 + i as f32 * 9.0,
    // rust: rgba(170, 170, 170, 255),
    // rust: );
}
}
    // rust: Mode::Error { message, alert, .. } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let lines: Vec<String> = message
    // rust: .split('\n')
    // rust: .flat_map(|line| wrapped(atlas, line, w - 50.0))
    // rust: .collect();
    // rust: self.message_lines.set(lines.len());
                // AlertScreen: the title at 70, the text at 90.
    // rust: let (top, text_top, key, fallback, color) = if let Some(alert) = alert {
    // rust: let (key, fallback, color) = match alert {
    // rust: Alert::Incompatible => (
    // rust: "selectWorld.incompatible.title",
    // rust: "Incompatible version",
    // rust: rgba(255, 0, 0, 255),
    // rust: ),
    // rust: Alert::Recreate => (
    // rust: "selectWorld.recreate.error.title",
    // rust: "An error occurred!",
    // rust: u32::MAX,
    // rust: ),
    // rust: Alert::Symlink => (
    // rust: "symlink_warning.title.world",
    // rust: "The world folder contains links",
    // rust: u32::MAX,
    // rust: ),
}
    // rust: (70.0, 90.0, key, fallback, color)
    // rust: } else {
    // rust: let top = confirm_top(h, lines.len());
    // rust: (
    // rust: top,
    // rust: top + 17.0,
    // rust: "selectWorld.access_failure",
    // rust: "Failed to access world",
    // rust: u32::MAX,
    // rust: )
}
    // rust: centered(atlas, batch, &lang::get_or(key, fallback), top, color);
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: centered(atlas, batch, line, text_top + i as f32 * 9.0, u32::MAX);
}
}
    // rust: Mode::MultiplayerWarning { check } => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let message = lang::get_or(
    // rust: "multiplayerWarning.message",
    // rust: "Caution: Online play is offered by third-party servers that are not owned, operated, or supervised by Mojang Studios or Microsoft. During online play, you may be exposed to unmoderated chat messages or other types of user-generated content that may not be suitable for everyone.",
    // rust: );
                // The message sits in a text box `width - 100` wide with 4 px
                // inside, left aligned (FittingMultiLineTextWidget).
    // rust: let box_w = w - 100.0;
    // rust: let lines = wrapped(atlas, &message, box_w - 8.0);
    // rust: self.message_lines.set(lines.len());
    // rust: let top = warning_top(h, lines.len());
    // rust: let header = Text::translate("multiplayerWarning.header", &[]).bold();
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &header,
    // rust: (w / 2.0).floor() - (atlas.font.width_text(&header) / 2.0).floor(),
    // rust: top,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let box_x = ((w - box_w) / 2.0).floor();
    // rust: let box_y = top + 29.0;
    // rust: let box_h = lines.len() as f32 * 9.0 + 8.0;
                // WarningScreen's FittingMultiLineTextWidget narrates the
                // message; the title's StringWidget isn't active.
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::text(message.clone(), [box_x, box_y, box_w, box_h])
    // rust: });
    // rust: crate::ui::nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/widget/text_field",
    // rust: box_x,
    // rust: box_y,
    // rust: box_w,
    // rust: box_h,
    // rust: u32::MAX,
    // rust: );
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: batch.text(
    // rust: atlas,
    // rust: line,
    // rust: box_x + 4.0,
    // rust: box_y + 4.0 + i as f32 * 9.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
                // Checkbox: the box, its label right of it (as the dialogs draw theirs).
    // rust: let label =
    // rust: lang::get_or("multiplayerWarning.check", "Do not show this screen again");
    // rust: let width = BOX + 4.0 + HudBatch::text_width(atlas, &label).ceil();
    // rust: let x = (w / 2.0).floor() - (width / 2.0).floor();
    // rust: let y = top + 57.0 + lines.len() as f32 * 9.0;
    // rust: self.warning_check.set([x, y, width, BOX]);
    // rust: crate::widgets::target([x, y, width, BOX]);
    // rust: let hover = (x..x + width).contains(&cursor.0) && (y..y + BOX).contains(&cursor.1);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::checkbox(
    // rust: label.clone(),
    // rust: *check,
    // rust: [x, y, width, BOX],
    // rust: true,
    // rust: )
    // rust: .hovered(hover)
    // rust: });
    // rust: let sprite = match (*check, hover) {
    // rust: (true, true) => "gui/sprites/widget/checkbox_selected_highlighted",
    // rust: (true, false) => "gui/sprites/widget/checkbox_selected",
    // rust: (false, true) => "gui/sprites/widget/checkbox_highlighted",
    // rust: (false, false) => "gui/sprites/widget/checkbox",
}
    // rust: batch.sprite_scaled(atlas, sprite, x, y, BOX, BOX, u32::MAX);
    // rust: batch.text(
    // rust: atlas,
    // rust: &label,
    // rust: x + BOX + 4.0,
    // rust: y + 4.0,
    // rust: rgba(224, 224, 224, 255),
    // rust: true,
    // rust: );
}
    // rust: Mode::Onboarding(_) => fade_from = Some(self.draw_onboarding(atlas, batch, w, h)),
    // rust: Mode::BanNotice(notice) => {
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let now = chrono::Utc::now().timestamp_millis();
    // rust: let layout = crate::confirm_screen::Choice::new(
    // rust: &atlas.font,
    // rust: (w, h),
    // rust: &notice.title(),
    // rust: &notice.message(now),
    // rust: 3,
    // rust: 100.0,
    // rust: );
    // rust: for (line, x, y) in &layout.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: self.ban_buttons
    // rust: .set([layout.buttons[0], layout.buttons[1], layout.buttons[2]]);
}
    // rust: Mode::Multiplayer(screen) => screen.draw(
    // rust: atlas,
    // rust: batch,
    // rust: &mut self.caret.borrow_mut(),
    // rust: self.started,
    // rust: cursor,
    // rust: hide_server_address,
    // rust: ),
    // rust: Mode::Realms(screen) => screen.draw(
    // rust: batch,
    // rust: atlas,
    // rust: &mut self.caret.borrow_mut(),
    // rust: self.started,
    // rust: cursor,
    // rust: w,
    // rust: h,
    // rust: ),
}
    // rust: for b in self.buttons(w, h) {
    // rust: crate::widgets::record(&b.label, [b.x, b.y, b.w, 20.0], b.enabled);
            // Realms' icon buttons have no label to record.
    // rust: if b.enabled && b.label.trim().is_empty() {
    // rust: crate::widgets::target([b.x, b.y, b.w, 20.0]);
}
    // rust: if let Some(action) = b.action.filter(|_| !self.preparing) {
    // rust: crate::widgets::declare_action(action, [b.x, b.y, b.w, 20.0], b.enabled);
}
    // rust: let inside =
    // rust: cursor.0 >= b.x && cursor.0 < b.x + b.w && cursor.1 >= b.y && cursor.1 < b.y + 20.0;
    // rust: crate::widgets::narratable(|| self.button_narration(&b).hovered(inside));
    // rust: crate::widgets::widget_cursor(inside, b.enabled);
    // rust: let is_focused = self.focused_button == Some(b.id);
    // rust: let hover = b.enabled && (inside || is_focused);
    // rust: let sprite = if !b.enabled {
    // rust: "gui/sprites/widget/button_disabled"
    // rust: } else if hover {
    // rust: "gui/sprites/widget/button_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/button"
}
            // Nine-slice approximation: left and right halves of the 200-wide sprite.
    // rust: if let Some(r) = atlas.sprites.get(sprite).copied() {
    // rust: let half = b.w / 2.0;
    // rust: let mut left = r;
    // rust: left.u1 = r.u0 + (r.u1 - r.u0) * (half / r.w as f32);
    // rust: batch.rect_uv(b.x, b.y, half, 20.0, left, u32::MAX);
    // rust: let mut right = r;
    // rust: right.u0 = r.u1 - (r.u1 - r.u0) * (half / r.w as f32);
    // rust: batch.rect_uv(b.x + half, b.y, half, 20.0, right, u32::MAX);
}
    // rust: let color = if b.enabled {
    // rust: u32::MAX
    // rust: } else {
    // rust: rgba(160, 160, 160, 255)
}
    // rust: if let Some((icon, size)) = b.icon {
                // CenteredIcon divides the button and sprite sizes separately:
                // a 15px icon in a 20px button starts at 10 - 7 = 3, not 2.
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/{icon}"),
    // rust: b.x + (b.w / 2.0).floor() - (size / 2.0).floor(),
    // rust: b.y + 10.0 - (size / 2.0).floor(),
    // rust: size,
    // rust: size,
    // rust: u32::MAX,
    // rust: );
    // rust: continue;
}
    // rust: b.draw_label(batch, atlas, color);
    // rust: if let Some((icon, size)) = b.trailing {
                // TextAndIcon: `x + width - spriteWidth - 2`, centred in the height.
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: &format!("gui/sprites/{icon}"),
    // rust: b.x + b.w - size - 2.0,
    // rust: b.y + 10.0 - (size / 2.0).floor(),
    // rust: size,
    // rust: size,
    // rust: u32::MAX,
    // rust: );
}
}
    // rust: if let Some(from) = fade_from {
    // rust: self.draw_onboarding_logo(atlas, batch, w, from);
}
    // rust: if let Mode::Create {
    // rust: name,
    // rust: creative,
    // rust: options,
    // rust: ..
    // rust: } = &self.mode
    // rust: {
    // rust: self.create_tooltip(atlas, batch, cursor, name, *creative, options);
}
    // rust: if let Mode::Select { worlds, selected } = &self.mode {
    // rust: self.select_tooltip(atlas, batch, cursor, (w, h), worlds, *selected);
}
    // rust: if let Mode::Multiplayer(screen) = &self.mode {
    // rust: screen.draw_tooltip(atlas, batch, cursor);
}
    // rust: if let Some((slide, toast)) = &self.toast {
    // rust: let (title, message) = toast.text();
    // rust: let width = HudBatch::text_width(atlas, &title)
    // rust: .max(HudBatch::text_width(atlas, &message))
    // rust: .ceil()
    // rust: .max(160.0)
    // rust: + 30.0;
            // Toast.xPos: in from the right edge by the visible portion.
    // rust: let x = w - width * slide.portion;
    // rust: crate::toasts::background(atlas, batch, x, 0.0, width);
    // rust: batch.text(atlas, &title, x + 18.0, 7.0, rgba(255, 255, 0, 255), false);
    // rust: batch.text(atlas, &message, x + 18.0, 19.0, u32::MAX, false);
}
}
    /// The tooltip of a world's icon (drawn with the row, as vanilla does) or, for a
    /// world that needs its files upgraded first, of the Play, Edit and Re-Create
    /// buttons (`SelectWorldScreen.updateButtonStatus`).
    // rust: fn select_tooltip(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: cursor: (f32, f32),
    // rust: size: (f32, f32),
    // rust: worlds: &[WorldEntry],
    // rust: selected: Option<usize>,
    // rust: ) {
    // rust: let red = |key: &str| Text::translate(key, &[]).with_color(crate::text::RED);
    // rust: if let Some((row, (rx, ry))) = self.world_row_at(worlds, cursor, size)
    // rust: && (0.0..32.0).contains(&rx)
    // rust: && (0.0..32.0).contains(&ry)
    // rust: && let Some((_, world)) = self.visible_worlds(worlds).nth(row)
    // rust: {
    // rust: let lines = if world.corrupted {
    // rust: Vec::new()
    // rust: } else if world.locked {
    // rust: atlas.font.split(&red("selectWorld.locked"), 175.0)
    // rust: } else if world.incompatible.is_some() {
    // rust: atlas
    // rust: .font
    // rust: .split(&red("selectWorld.incompatible.tooltip"), 175.0)
    // rust: } else if world.downgrade {
    // rust: vec![
    // rust: red("selectWorld.tooltip.fromNewerVersion1"),
    // rust: red("selectWorld.tooltip.fromNewerVersion2"),
    // rust: ]
    // rust: } else {
    // rust: Vec::new()
}
    // rust: crate::ui::tooltip(batch, atlas, &lines, cursor);
    // rust: return;
}
    // rust: if !selected
    // rust: .and_then(|i| worlds.get(i))
    // rust: .is_some_and(|w| w.file_fixing)
    // rust: {
    // rust: return;
}
    // rust: let (x, y) = cursor;
    // rust: let hovered = self
    // rust: .buttons(size.0, size.1)
    // rust: .into_iter()
    // rust: .find(|b| x >= b.x && x < b.x + b.w && y >= b.y && y < b.y + 20.0);
    // rust: let key = match hovered.map(|b| b.id) {
    // rust: Some(10) => "selectWorld.requiresFileFixingTooltip.play",
    // rust: Some(13) => "selectWorld.requiresFileFixingTooltip.edit",
    // rust: Some(15) => "selectWorld.requiresFileFixingTooltip.recreate",
    // rust: _ => return,
}
    // rust: let lines = atlas.font.split(&Text::translate(key, &[]), 170.0);
    // rust: crate::ui::tooltip(batch, atlas, &lines, cursor);
}
    /// `TabManager.setCurrentTab`: the screen shows `tab`, whose own fields
    /// take no focus, and whether the open tab changed (the click sound).
pub fn select_create_tab(self: *Self, tab: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Mode::Create { focus, options, .. } = &mut self.mode else {
    // rust: return false;
}
    // rust: let changed = options.tab != tab;
    // rust: if changed {
    // rust: options.tab = tab;
    // rust: *focus = 2;
}
    // rust: changed
}
    /// `TabNavigationBar.keyPressed`: with Ctrl held, a digit picks a tab and
    /// Tab steps to the next one, or to the previous with Shift. `None` for a
    /// key the bar leaves alone, so a digit still reaches the field; otherwise
    /// whether to play the click sound, as a tab that changed does.
    // rust: pub fn tab_bar_key(
    // rust: &mut self,
    // rust: key: winit::keyboard::KeyCode,
    // rust: ctrl: bool,
    // rust: shift: bool,
    // rust: ) -> Option<bool> {
        // The rules and the experiments take the keys, and so does the read
        // that prepares the world.
    // rust: if !ctrl
    // rust: || self.preparing
    // rust: || self.rules.get_mut().is_some()
    // rust: || self.experiments.get_mut().is_some()
    // rust: || self.confirm_experiments.get_mut().is_some()
    // rust: {
    // rust: return None;
}
    // rust: let Mode::Create { options, .. } = &self.mode else {
    // rust: return None;
}
    // rust: let next = create_world::next_tab_index(options.tab, key, shift)?;
    // rust: Some(self.select_create_tab(next.min(create_world::tab_count() - 1)))
}
    /// `AbstractSelectionList.mouseClicked`: the row under the pointer takes
    /// a click of any button (`ObjectSelectionList.Entry.mouseClicked` accepts
    /// them all), so a middle click selects a world and its Play, Edit and
    /// Delete buttons hear of it (`WorldSelectionList.setSelected`), without
    /// opening it. Only the left button joins, through [`Self::click`].
pub fn select_world_at(self: *Self, x: f32, y: f32, size: (f32) void {
}
    // rust: let index = {
    // rust: let Mode::Select { worlds, .. } = &self.mode else {
    // rust: return false;
}
    // rust: let Some((row, _)) = self.world_row_at(worlds, (x, y), size) else {
    // rust: return false;
}
    // rust: let Some((index, _)) = self.visible_worlds(worlds).nth(row) else {
    // rust: return false;
}
    // rust: index
}
    // rust: if let Mode::Select { selected, .. } = &mut self.mode {
    // rust: *selected = Some(index);
}
    // rust: true
}

    /// The action and whether to play `AbstractWidget.playButtonClickSound`.
    /// Navigation buttons can return `Action::None` while still sounding.
pub fn click(self: *Self, x: f32, y: f32, size: (f32) void {
}
    // rust: self.remember_direct_address();
        // The game rules take the press in `press_rules`, which has the atlas.
    // rust: if self.rules.get_mut().is_some()
    // rust: || self.experiments.get_mut().is_some()
    // rust: || self.confirm_experiments.get_mut().is_some()
    // rust: || self.preparing
    // rust: {
    // rust: return (Action::None, false);
}
    // rust: let (w, h) = (size.0.ceil(), size.1.ceil());
        // MenuTabBar: a new tab clears the focus and clicks.
    // rust: if let Some(tab) = create_world::tab_at(w, (x, y))
    // rust: && matches!(self.mode, Mode::Create { .. })
    // rust: {
    // rust: return (Action::None, self.select_create_tab(tab));
}
        // The SafetyScreen's box toggles where it was last drawn.
    // rust: if let Mode::MultiplayerWarning { check } = &mut self.mode {
    // rust: let [bx, by, bw, bh] = self.warning_check.get();
    // rust: if (bx..bx + bw).contains(&x) && (by..by + bh).contains(&y) {
    // rust: *check = !*check;
    // rust: return (Action::None, true);
}
}
    // rust: if let Mode::OptimizeConfirm { erase_cache, .. } = &mut self.mode {
    // rust: let [bx, by, bw, bh] = self.erase_check.get();
    // rust: if (bx..bx + bw).contains(&x) && (by..by + bh).contains(&y) {
    // rust: *erase_cache = !*erase_cache;
    // rust: return (Action::None, true);
}
}
    // rust: if matches!(self.mode, Mode::Main) {
    // rust: let [bx, by, bw, bh] = self.credits_button.get();
    // rust: if (bx..bx + bw).contains(&x) && (by..by + bh).contains(&y) {
    // rust: return (Action::Credits, true);
}
}
    // rust: let hit = self
    // rust: .buttons(w, h)
    // rust: .into_iter()
    // rust: .find(|b| b.enabled && x >= b.x && x < b.x + b.w && y >= b.y && y < b.y + 20.0)
    // rust: .map(|b| b.id);
    // rust: if hit.is_some() {
    // rust: self.focused_button = hit;
    // rust: } else if matches!(
    // rust: self.mode,
    // rust: Mode::Multiplayer(
    // rust: crate::multiplayer::Screen::Edit { .. } | crate::multiplayer::Screen::Friend { .. }
    // rust: )
    // rust: ) {
            // A press on a text field takes the focus from the button.
    // rust: self.focused_button = None;
}
    // rust: if matches!(self.mode, Mode::CreateBuffet { .. }) {
    // rust: self.buffet_click(x, y, (w, h), hit);
    // rust: self.drop_button_focus_for_field(hit);
    // rust: return (Action::None, hit.is_some());
}
    // rust: if matches!(self.mode, Mode::CreateFlat { .. }) {
    // rust: self.flat_click(x, y, (w, h), hit);
    // rust: self.drop_button_focus_for_field(hit);
    // rust: return (Action::None, hit.is_some());
}
    // rust: let action = self.click_action(x, y, (w, h), hit);
    // rust: self.drop_button_focus_for_field(hit);
        // World list selection is silent; launching its selected entry sounds.
    // rust: let sound = hit.is_some() || matches!(action, Action::Play { .. });
    // rust: (action, sound)
}
    /// A click that misses every button and leaves an edit box focused moves the focus
    /// to that box (`Screen.setFocused`): a focused button must not keep reacting to
    /// Space, which the box now types.
pub fn drop_button_focus_for_field(self: *Self, hit: ?u8) void {
}
    // rust: if hit.is_none() && self.has_caret_field() {
    // rust: self.focused_button = None;
}
}
pub fn click_action(self: *Self, x: f32, y: f32) void {
}
    // rust: match (&mut self.mode, hit) {
    // rust: (Mode::Main, Some(1)) => {
                // The title button is no longer part of the world-select screen.
                // Clear it so Enter can activate the selected world after a
                // mouse click opened Select World.
    // rust: self.focused_button = None;
    // rust: self.enter_singleplayer();
    // rust: Action::None
}
    // rust: (Mode::Main, Some(2)) => Action::Quit,
    // rust: (Mode::BanNotice(_), Some(id @ 120..=122)) => {
                // BanNoticeScreens' callback: Open in Browser opens the link, Copy copies it
                // and answers no; all of them run `next`.
    // rust: self.next_ban_notice();
    // rust: match id {
    // rust: 120 => Action::OpenUri(crate::ban_notice::SUSPENSION_HELP.to_owned()),
    // rust: 121 => Action::CopyText(crate::ban_notice::SUSPENSION_HELP.to_owned()),
    // rust: _ => Action::None,
}
}
    // rust: (Mode::Main, Some(4)) => {
                // TitleScreen.init: SafetyScreen first, unless it was turned off.
    // rust: self.mode = if self.skip_multiplayer_warning {
    // rust: Mode::Multiplayer(crate::multiplayer::Screen::list(&self.saves))
    // rust: } else {
    // rust: Mode::MultiplayerWarning { check: false }
}
    // rust: Action::None
}
    // rust: (Mode::MultiplayerWarning { check }, Some(70)) => {
                // SafetyScreen Proceed: the box saves the choice.
    // rust: if *check {
    // rust: self.skip_multiplayer_warning = true;
}
    // rust: self.mode = Mode::Multiplayer(crate::multiplayer::Screen::list(&self.saves));
    // rust: Action::None
}
    // rust: (Mode::Main, Some(8)) => {
    // rust: self.mode = Mode::Realms(crate::realms::Screen::new());
    // rust: Action::None
}
    // rust: (Mode::Realms(screen), hit) => match screen.click(hit, x, y, (w, h)) {
    // rust: crate::realms::Outcome::Back => {
    // rust: self.mode = Mode::Main;
    // rust: Action::None
}
    // rust: crate::realms::Outcome::Connect(address) => Action::Connect {
    // rust: address,
    // rust: lan: false,
    // rust: },
    // rust: crate::realms::Outcome::OpenUri(uri) => Action::OpenUri(uri),
    // rust: crate::realms::Outcome::None => Action::None,
    // rust: },
    // rust: (Mode::MultiplayerWarning { .. }, Some(71)) => {
    // rust: self.mode = Mode::Main;
    // rust: Action::None
}
    // rust: (Mode::Multiplayer(_), hit) => match self.multiplayer_click(hit, x, y, (w, h)) {
    // rust: crate::multiplayer::Outcome::Back => {
    // rust: self.mode = Mode::Main;
    // rust: Action::None
}
    // rust: crate::multiplayer::Outcome::Connect { address, lan } => {
    // rust: Action::Connect { address, lan }
}
    // rust: crate::multiplayer::Outcome::None => Action::None,
    // rust: },
    // rust: (Mode::Main, Some(5)) => {
    // rust: self.mode = Mode::Multiplayer(crate::multiplayer::Screen::friend());
    // rust: Action::None
}
    // rust: (Mode::Onboarding(_), Some(onboarding::SOUNDS)) => Action::Sounds,
    // rust: (Mode::Onboarding(_), Some(onboarding::ACCESSIBILITY)) => Action::Accessibility,
    // rust: (Mode::Onboarding(_), Some(onboarding::LANGUAGE)) => Action::Language,
    // rust: (Mode::Onboarding(_), Some(onboarding::CONTINUE)) => {
    // rust: self.onboarding_close();
    // rust: Action::None
}
    // rust: (Mode::Main, Some(3)) => Action::Options,
    // rust: (Mode::Main, Some(7)) => Action::Accessibility,
    // rust: (Mode::Main, Some(6)) => Action::Language,
    // rust: (Mode::Select { worlds, selected }, Some(10)) => {
    // rust: match selected.and_then(|i| worlds.get(i)).cloned() {
    // rust: Some(world) => self.play(world),
    // rust: None => Action::None,
}
}
    // rust: (Mode::BackupBeforeUpgrade { world, stem, .. }, Some(40)) => {
    // rust: let world = world.clone();
    // rust: self.backup_then_open = Some(stem.is_some());
    // rust: self.start_backup(world);
    // rust: Action::None
}
    // rust: (Mode::BackupBeforeUpgrade { world, stem, .. }, Some(41)) => {
    // rust: let (world, stem_asked) = (world.clone(), stem.is_some());
    // rust: self.after_prompt(world, stem_asked)
}
            // ConfirmScreen: Continue loads the world, Back (or Escape) leaves it closed.
    // rust: (Mode::LowDiskSpace { world }, Some(94)) => Action::Play {
    // rust: folder: world.folder.clone(),
    // rust: },
    // rust: (Mode::LowDiskSpace { .. }, Some(95)) => {
    // rust: self.escape();
    // rust: Action::None
}
    // rust: (
    // rust: Mode::OptimizeConfirm {
    // rust: world, erase_cache, ..
    // rust: },
    // rust: Some(43),
    // rust: ) => {
    // rust: let (world, erase_cache) = (world.clone(), *erase_cache);
    // rust: self.optimize_after_backup = Some(erase_cache);
    // rust: self.start_backup(world);
    // rust: Action::None
}
    // rust: (
    // rust: Mode::OptimizeConfirm {
    // rust: world, erase_cache, ..
    // rust: },
    // rust: Some(44),
    // rust: ) => {
    // rust: let (world, erase_cache) = (world.clone(), *erase_cache);
    // rust: self.begin_optimize(world, erase_cache);
    // rust: Action::None
}
    // rust: (Mode::OptimizeConfirm { .. }, Some(45)) => {
    // rust: self.escape();
    // rust: Action::None
}
    // rust: (Mode::Optimize { .. }, Some(46)) => {
                // Cancel: `upgrader.cancel()`, then the callback with false.
    // rust: if let Some(upgrader) = self.optimize.as_mut() {
    // rust: upgrader.cancel();
}
    // rust: self.end_optimize(false);
    // rust: Action::None
}
    // rust: (Mode::BackupBeforeUpgrade { world, .. }, Some(42)) => {
    // rust: let folder = world.folder.clone();
    // rust: self.return_to_list(Some(&folder));
    // rust: Action::None
}
    // rust: (Mode::Select { .. }, Some(11)) => {
    // rust: self.create_return_to_main = false;
                // `CreateWorldScreen.openCreateWorldScreen`: the world
                // generation data is read first, behind a loading screen;
                // the game opens the create screen after (`preparing`).
    // rust: self.preparing = true;
    // rust: Action::None
}
    // rust: (Mode::Select { worlds, selected }, Some(id @ 13..=15)) => {
    // rust: let Some(world) = selected.and_then(|i| worlds.get(i)).cloned() else {
    // rust: return Action::None;
}
    // rust: match id {
    // rust: 13 => {
    // rust: self.mode = Mode::Edit {
    // rust: name: world.name.clone(),
    // rust: world,
    // rust: focused: true,
}
}
    // rust: 14 => self.mode = Mode::Delete { world },
    // rust: _ => {
    // rust: let level = Level::read(&self.saves.join(&world.folder));
                        // WorldListEntry.recreateWorld: a world that will not read is an
                        // AlertScreen over the list.
    // rust: let Some(level) = level else {
    // rust: self.mode = Mode::Error {
    // rust: message: lang::get_or(
    // rust: "selectWorld.recreate.error.text",
    // rust: "Something went wrong while trying to recreate a world.",
    // rust: ),
    // rust: return_to: Box::new(self.mode.clone()),
    // rust: alert: Some(Alert::Recreate),
}
    // rust: return Action::None;
}
    // rust: self.create_return_to_main = false;
    // rust: let mut options = WorldOptions::of_world(
    // rust: &level,
    // rust: world.commands,
    // rust: &self.saves.join(&world.folder),
    // rust: );
    // rust: options.restore_feature_packs(&self.resources, &level);
    // rust: self.mode = Mode::Create {
    // rust: name: level.name,
    // rust: seed: level.seed.to_string(),
    // rust: creative: level.creative,
    // rust: focus: 0,
    // rust: options,
}
}
}
    // rust: Action::None
}
    // rust: (Mode::Select { .. }, Some(12)) => {
    // rust: self.mode = Mode::Main;
    // rust: Action::None
}
    // rust: (Mode::Select { .. }, None) => {
    // rust: self.search_focused =
    // rust: (21.0..41.0).contains(&y) && (x - (w / 2.0).floor()).abs() < 100.0;
    // rust: let Mode::Select { worlds, .. } = &self.mode else {
    // rust: unreachable!()
}
    // rust: let (top, bottom, left, content) = self.world_list(worlds, (w, h));
    // rust: if self
    // rust: .scroll
    // rust: .get_mut()
    // rust: .press((x, y), left + ROW_WIDTH + 8.0, top, bottom, content)
    // rust: {
    // rust: return Action::None;
}
    // rust: let Mode::Select { worlds, selected } = &self.mode else {
    // rust: unreachable!()
}
    // rust: let chosen = self
    // rust: .world_row_at(worlds, (x, y), (w, h))
    // rust: .and_then(|(row, rel)| {
    // rust: let (index, world) = self.visible_worlds(worlds).nth(row)?;
    // rust: Some((index, world.clone(), rel))
    // rust: });
    // rust: if let Some((index, world, (rx, ry))) = chosen {
                    // WorldListEntry.mouseClicked: the icon joins at once.
    // rust: let on_icon = (0.0..32.0).contains(&rx) && (0.0..32.0).contains(&ry);
                    // WorldListEntry.canInteract: only a world that can be played joins.
    // rust: if (on_icon || *selected == Some(index)) && world.can_play() {
    // rust: return self.play(world);
}
    // rust: if let Mode::Select { selected, .. } = &mut self.mode {
    // rust: *selected = Some(index);
}
}
    // rust: Action::None
}
    // rust: (Mode::Edit { world, name, .. }, Some(id @ (30..=36))) => {
    // rust: let world = world.clone();
    // rust: let name = name.clone();
    // rust: let result = match id {
    // rust: 30 => world_management::reset_icon(&self.saves, &world.folder),
    // rust: 31 => world_management::open_folder(&self.saves.join(&world.folder)),
    // rust: 32 => {
    // rust: self.start_backup(world);
    // rust: return Action::None;
}
    // rust: 33 => {
    // rust: world_management::open_folder(&world_management::backups_path(&self.saves))
}
    // rust: 34 => {
    // rust: self.mode = Mode::OptimizeConfirm {
    // rust: world,
    // rust: name,
    // rust: erase_cache: false,
}
    // rust: return Action::None;
}
    // rust: 35 => world_management::rename(&self.saves, &world.folder, &name),
    // rust: 36 => {
    // rust: self.return_to_list(Some(&world.folder));
    // rust: return Action::None;
}
    // rust: _ => return Action::None,
}
    // rust: if let Err(error) = result {
    // rust: self.failed(error);
    // rust: } else if id == 35 {
    // rust: self.return_to_list(Some(&world.folder));
    // rust: } else if id == 30 {
    // rust: self.icons.borrow_mut().clear();
}
    // rust: Action::None
}
    // rust: (Mode::Edit { focused, .. }, None) => {
    // rust: *focused = y >= edit_top(h) + 39.0
    // rust: && y < edit_top(h) + 59.0
    // rust: && (x - (w / 2.0).floor()).abs() < 100.0;
    // rust: Action::None
}
    // rust: (Mode::Delete { .. }, Some(37)) => {
    // rust: self.confirm_delete();
    // rust: Action::None
}
    // rust: (Mode::Delete { .. }, Some(38)) => {
    // rust: self.escape();
    // rust: Action::None
}
    // rust: (Mode::Recover { world, .. }, Some(90)) => {
                // attemptRestore: the world is backed up first (`makeBackupAndShowToast`), and the
                // restore runs once that is done.
    // rust: let world = world.clone();
    // rust: self.restore_after_backup = true;
    // rust: self.start_backup(world);
    // rust: Action::None
}
    // rust: (Mode::Recovered { world, .. }, Some(92)) => {
    // rust: let world = world.clone();
    // rust: self.play(world)
}
    // rust: (Mode::Recover { .. } | Mode::Recovered { .. }, Some(91 | 93)) => {
    // rust: self.escape();
    // rust: Action::None
}
    // rust: (Mode::Error { return_to, .. }, Some(39)) => {
    // rust: self.mode = *return_to.clone();
    // rust: Action::None
}
            // CreateWorldScreen.openGameRulesScreen over a copy of the rules.
    // rust: (Mode::Create { options, .. }, Some(29)) => {
    // rust: let rules = options
    // rust: .rules
    // rust: .copy_with_features(&options.enabled_features(&self.resources));
    // rust: *self.rules.get_mut() = Some(RulesScreen::for_creation(&rules));
    // rust: Action::None
}
            // CreateBuffetWorldScreen for the single-biome preset.
    // rust: (
    // rust: Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: options,
    // rust: },
    // rust: Some(26),
    // rust: ) if options.world_type == crate::save::WorldPreset::SingleBiomeSurface => {
    // rust: let buffet = buffet::State::new(&self.resources, &options.single_biome);
    // rust: self.mode = Mode::CreateBuffet {
    // rust: name: name.clone(),
    // rust: seed: seed.clone(),
    // rust: creative: *creative,
    // rust: focus: *focus,
    // rust: options: options.clone(),
    // rust: buffet,
}
    // rust: Action::None
}
            // CreateFlatWorldScreen for the flat preset.
    // rust: (
    // rust: Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: options,
    // rust: },
    // rust: Some(26),
    // rust: ) => {
    // rust: let flat = flat::State::new(&self.resources, options.flat_settings.clone());
    // rust: self.mode = Mode::CreateFlat {
    // rust: name: name.clone(),
    // rust: seed: seed.clone(),
    // rust: creative: *creative,
    // rust: focus: *focus,
    // rust: options: options.clone(),
    // rust: flat,
}
    // rust: Action::None
}
    // rust: (
    // rust: Mode::Create {
    // rust: creative, options, ..
    // rust: },
    // rust: Some(id),
    // rust: ) if !matches!(id, 21 | 22 | 30 | 31) => {
    // rust: options.press(id, creative);
    // rust: Action::None
}
            // CreateWorldScreen.openExperimentsScreen: the feature packs the
            // jar ships, switched on or off.
    // rust: (Mode::Create { options, .. }, Some(30)) => {
    // rust: let flags = experiments::repository_flags(&self.resources, &options.data_packs);
    // rust: *self.experiments.get_mut() = Some(experiments::ExperimentsScreen::new(flags));
    // rust: Action::None
}
    // rust: (Mode::Create { .. }, Some(21)) => self.create_action(),
    // rust: (Mode::Create { options, .. }, Some(31)) => {
    // rust: if options.pack_dir.is_none() {
    // rust: match crate::datapack::temp_folder() {
    // rust: Ok(dir) => options.pack_dir = Some(dir),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: no folder for data packs: {e}");
    // rust: return Action::None;
}
}
}
    // rust: Action::DataPacks {
    // rust: dir: options.pack_dir.clone().unwrap_or_default(),
    // rust: selected: options.data_packs.clone(),
}
}
    // rust: (Mode::Create { .. }, Some(22)) => {
    // rust: self.cancel_create();
    // rust: Action::None
}
    // rust: (Mode::Create { focus, options, .. }, None) => {
    // rust: *focus = create_world::field_at(w, h, options.tab, (x, y)).unwrap_or(2);
    // rust: Action::None
}
    // rust: _ => Action::None,
}
}
    /// The focused text field, its id and maximum length (copy and paste).
pub fn focused_field(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.rules.get_mut().is_some() {
    // rust: return None;
}
    // rust: match &mut self.mode {
    // rust: Mode::Multiplayer(screen) => screen.focused_text(),
    // rust: Mode::Realms(screen) => screen.focused_text(),
    // rust: mode => caret_field(mode, self.search_focused, &mut self.search),
}
}
    /// Whether the focused field edits at its cursor.
pub fn has_caret_field(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
        // The game rules' boxes edit themselves (`edit_field`).
    // rust: if let Some(rules) = self.rules.get_mut() {
    // rust: return rules.typing();
}
    // rust: caret_field(&mut self.mode, self.search_focused, &mut self.search).is_some()
}
    /// Edit the focused field through its `EditBox`; false when there is none.
pub fn edit_field(self: *Self, f: impl FnOnce(*mut crate::ui::EditBox) void {
}
    // rust: if let Some(rules) = self.rules.get_mut() {
    // rust: rules.edit(f);
    // rust: return rules.typing();
}
    // rust: let Some((id, value, max)) =
    // rust: caret_field(&mut self.mode, self.search_focused, &mut self.search)
    // rust: else {
    // rust: return false;
}
    // rust: let before = value.clone();
    // rust: self.caret.get_mut().edit(id, value, max, f);
    // rust: if *value != before {
    // rust: self.search_changed();
}
    // rust: true
}
    /// EditBox.charTyped / insertText at the cursor.
pub fn type_text(self: *Self, text: []const u8) void {
}
        // `GenericMessageScreen`: no field takes input during the read.
    // rust: if self.preparing {
    // rust: return;
}
    // rust: self.edit_field(|edit| edit.insert_text(text));
}
pub fn backspace(self: *Self) void {
}
    // rust: self.field_key(winit::keyboard::KeyCode::Backspace, false, false);
}
    /// EditBox.keyPressed: moving and deleting in the focused field.
pub fn field_key(self: *Self, key: winit::keyboard::KeyCode, ctrl: bool, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.preparing {
    // rust: return false;
}
    // rust: let mut handled = false;
    // rust: self.edit_field(|edit| handled = edit.key(key, ctrl, shift));
    // rust: handled
}
    /// Ctrl+A/C/V/X in the focused field.
    // rust: pub fn field_shortcut(
    // rust: &mut self,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: board: &mut dyn crate::clipboard::Clipboard,
    // rust: ) {
    // rust: self.edit_field(|edit| {
    // rust: edit.shortcut(shortcut, board);
    // rust: });
}
    /// The focused field's box on screen.
pub fn focused_rect(self: *Self) void {
}
    // rust: let x = (w / 2.0).floor() - 100.0;
    // rust: match &self.mode {
    // rust: Mode::Select { .. } if self.search_focused => Some([x, 21.0, 200.0, 20.0]),
    // rust: Mode::Edit { focused: true, .. } => Some([x, edit_top(h) + 39.0, 200.0, 20.0]),
    // rust: Mode::Create { focus, options, .. } => create_world::field_rect(w, h, options.tab)
    // rust: .filter(|(id, _)| id == focus)
    // rust: .map(|(_, rect)| rect),
    // rust: Mode::Multiplayer(screen) => screen.focused_box((w, h)),
    // rust: Mode::Realms(screen) => screen.focused_box((w, h)),
    // rust: Mode::CreateBuffet { buffet, .. } if buffet.query_focused => {
    // rust: Some(buffet::search_box(w))
}
    // rust: _ => None,
}
}
    /// A left press after `click` focused a field: the cursor goes under the
    /// pointer (`EditBox.onClick`).
    // rust: pub fn press_field(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: (x, y): (f32, f32),
    // rust: size: (f32, f32),
    // rust: shift: bool,
    // rust: ) {
    // rust: let (w, h) = (size.0.ceil(), size.1.ceil());
    // rust: if self.rules.get_mut().is_some() {
    // rust: return;
}
    // rust: let Some(rect @ [fx, fy, fw, fh]) = self.focused_rect((w, h)) else {
    // rust: return;
}
    // rust: if !crate::ui::hovered((x, y), fx, fy, fw, fh) {
    // rust: return;
}
    // rust: if let Some(field) = caret_field(&mut self.mode, self.search_focused, &mut self.search) {
    // rust: self.caret.get_mut().press(atlas, field, rect, x, shift);
}
}
    /// The pointer moved with the button held (`EditBox.onDrag`).
pub fn drag_field(self: *Self, atlas: *HudAtlas, x: f32) void {
}
    // rust: if self.rules.get_mut().is_some() {
    // rust: return;
}
    // rust: if let Some(field) = caret_field(&mut self.mode, self.search_focused, &mut self.search) {
    // rust: self.caret.get_mut().drag(atlas, field, x);
}
}
    /// The button was released: drags stop selecting.
pub fn release_field(self: *Self) void {
}
    // rust: self.caret.get_mut().release();
}
    /// Clipboard replacements also invalidate a selection in the filtered list.
pub fn search_changed(self: *Self) void {
}
    // rust: if self.search_focused
    // rust: && let Mode::Select { selected, .. } = &mut self.mode
    // rust: {
    // rust: *selected = None;
    // rust: self.scroll.set(crate::ui::Scroll::default());
            // WorldSelectionList.notifyListUpdated: the filtered list is
            // narrated at once.
    // rust: crate::widgets::narrate_now();
}
}
pub fn confirm_edit(self: *Self) void {
}
    // rust: let Mode::Edit {
    // rust: world,
    // rust: name,
    // rust: focused: true,
    // rust: } = &self.mode
    // rust: else {
    // rust: return;
}
    // rust: if name.trim().is_empty() {
    // rust: return;
}
    // rust: let folder = world.folder.clone();
    // rust: match world_management::rename(&self.saves, &folder, name) {
    // rust: Ok(()) => self.return_to_list(Some(&folder)),
    // rust: Err(error) => self.failed(error),
}
}
    /// `CreateWorldScreen.keyPressed`, `DirectJoinServerScreen.keyPressed` and
    /// `WorldListEntry.keyPressed` on Enter (Space too on the list): Create New
    /// World creates, a rename saves, Direct Connection joins, the selected
    /// world joins.
pub fn confirm_key(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.confirm_key_size((854.0, 480.0)).0
}
    /// `confirm_key` with actual viewport size for button geometry lookup.
    /// Returns the triggered action and whether a UI button click sound should play.
pub fn confirm_key_size(self: *Self, size: (f32) void {
}
    // rust: self.remember_direct_address();
    // rust: if self.rules.get_mut().is_some() {
    // rust: return (Action::None, false);
}
    // rust: if matches!(self.mode, Mode::Edit { .. }) && self.focused_button.is_none() {
    // rust: self.confirm_edit();
    // rust: return (Action::None, true);
}
    // rust: if self.list_focused() && self.focused_button.is_none() {
    // rust: let action = self.join_selected();
    // rust: let sound = matches!(action, Action::Play { .. });
    // rust: return (action, sound);
}
    // rust: if let Some(id) = self.focused_button {
    // rust: let (w, h) = size;
    // rust: let buttons = self.buttons(w, h);
    // rust: if let Some(b) = buttons.into_iter().find(|b| b.id == id && b.enabled) {
    // rust: let action = self.click_action(b.x, b.y, (w, h), Some(id));
    // rust: return (action, true);
}
    // rust: return (Action::None, false);
}
    // rust: match &self.mode {
    // rust: Mode::Create { .. } => {
    // rust: let action = self.create_action();
    // rust: let sound = matches!(action, Action::Create { .. });
    // rust: (action, sound)
}
    // rust: Mode::Multiplayer(screen) => match screen.confirm() {
    // rust: crate::multiplayer::Outcome::Connect { address, lan } => {
    // rust: (Action::Connect { address, lan }, true)
}
    // rust: _ => (Action::None, false),
    // rust: },
    // rust: _ => (Action::None, false),
}
}
    /// The world list has the keyboard: no search box focus.
pub fn list_focused(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.mode, Mode::Select { .. }) && !self.search_focused
}
    /// `WorldListEntry.keyPressed`: the selected world joins, as its click does.
pub fn join_selected(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Mode::Select { worlds, selected } = &self.mode else {
    // rust: return Action::None;
}
    // rust: let Some(world) = selected.and_then(|i| worlds.get(i)).cloned() else {
    // rust: return Action::None;
}
    // rust: if !world.can_play() {
    // rust: return Action::None;
}
    // rust: self.play(world)
}
pub fn tab(self: *Self) void {
}
    // rust: self.tab_dir(false, (854.0, 480.0));
}
    /// Tab navigation through widgets and fields in either forward or reverse order.
pub fn tab_dir(self: *Self, reverse: bool, size: (f32) void {
}
    // rust: if let Mode::Realms(screen) = &mut self.mode {
    // rust: screen.tab();
    // rust: return;
}
    // rust: if self.rules.get_mut().is_some() {
    // rust: return;
}
    // rust: if matches!(self.mode, Mode::Multiplayer(_)) {
    // rust: let (w, h) = size;
    // rust: let enabled: Vec<u8> = self
    // rust: .buttons(w, h)
    // rust: .iter()
    // rust: .filter(|b| b.enabled)
    // rust: .map(|b| b.id)
    // rust: .collect();
    // rust: if let Mode::Multiplayer(screen) = &mut self.mode {
    // rust: screen.tab_dir(reverse, &enabled, &mut self.focused_button);
}
    // rust: return;
}
    // rust: let (w, h) = size;
    // rust: let buttons = self.buttons(w, h);
    // rust: let enabled: Vec<u8> = buttons.iter().filter(|b| b.enabled).map(|b| b.id).collect();

    // rust: match &mut self.mode {
    // rust: Mode::Select { .. } => {
    // rust: if self.search_focused {
                    // Tab leaves the search box for the world list, where the
                    // arrow keys pick a row and Enter or Space joins it.
    // rust: self.search_focused = false;
    // rust: self.focused_button = None;
    // rust: } else if let Some(cur) = self.focused_button {
    // rust: if let Some(pos) = enabled.iter().position(|&id| id == cur) {
    // rust: if !reverse && pos + 1 < enabled.len() {
    // rust: self.focused_button = Some(enabled[pos + 1]);
    // rust: } else if reverse && pos > 0 {
    // rust: self.focused_button = Some(enabled[pos - 1]);
    // rust: } else {
    // rust: self.focused_button = None;
    // rust: self.search_focused = true;
}
    // rust: } else {
    // rust: self.focused_button = None;
    // rust: self.search_focused = true;
}
    // rust: } else if let Some(first) = if reverse {
    // rust: enabled.last().copied()
    // rust: } else {
    // rust: enabled.first().copied()
    // rust: } {
                    // The list had focus: Tab moves on to the buttons.
    // rust: self.focused_button = Some(first);
    // rust: } else {
    // rust: self.search_focused = true;
}
}
    // rust: Mode::Create { focus, options, .. } => {
    // rust: let field_id = if options.tab == 1 { 1 } else { 0 };
    // rust: if *focus != 2 {
    // rust: *focus = 2;
    // rust: self.focused_button = if reverse {
    // rust: enabled.last().copied()
    // rust: } else {
    // rust: enabled.first().copied()
}
    // rust: } else if let Some(cur) = self.focused_button {
    // rust: if let Some(pos) = enabled.iter().position(|&id| id == cur) {
    // rust: if !reverse && pos + 1 < enabled.len() {
    // rust: self.focused_button = Some(enabled[pos + 1]);
    // rust: } else if reverse && pos > 0 {
    // rust: self.focused_button = Some(enabled[pos - 1]);
    // rust: } else {
    // rust: self.focused_button = None;
    // rust: *focus = field_id;
}
    // rust: } else {
    // rust: self.focused_button = None;
    // rust: *focus = field_id;
}
    // rust: } else {
    // rust: *focus = field_id;
}
}
    // rust: Mode::Edit { focused, .. } => {
    // rust: if *focused {
    // rust: *focused = false;
    // rust: self.focused_button = if reverse {
    // rust: enabled.last().copied()
    // rust: } else {
    // rust: enabled.first().copied()
}
    // rust: } else if let Some(cur) = self.focused_button {
    // rust: if let Some(pos) = enabled.iter().position(|&id| id == cur) {
    // rust: if !reverse && pos + 1 < enabled.len() {
    // rust: self.focused_button = Some(enabled[pos + 1]);
    // rust: } else if reverse && pos > 0 {
    // rust: self.focused_button = Some(enabled[pos - 1]);
    // rust: } else {
    // rust: self.focused_button = None;
    // rust: *focused = true;
}
    // rust: } else {
    // rust: self.focused_button = None;
    // rust: *focused = true;
}
    // rust: } else {
    // rust: *focused = true;
}
}
    // rust: _ => {
    // rust: if enabled.is_empty() {
    // rust: return;
}
    // rust: let next = match self.focused_button {
    // rust: Some(cur) => {
    // rust: if let Some(pos) = enabled.iter().position(|&id| id == cur) {
    // rust: if reverse {
    // rust: if pos == 0 {
    // rust: enabled.last().copied()
    // rust: } else {
    // rust: Some(enabled[pos - 1])
}
    // rust: } else {
    // rust: if pos + 1 >= enabled.len() {
    // rust: enabled.first().copied()
    // rust: } else {
    // rust: Some(enabled[pos + 1])
}
}
    // rust: } else {
    // rust: if reverse {
    // rust: enabled.last().copied()
    // rust: } else {
    // rust: enabled.first().copied()
}
}
}
    // rust: None => {
    // rust: if reverse {
    // rust: enabled.last().copied()
    // rust: } else {
    // rust: enabled.first().copied()
}
}
}
    // rust: self.focused_button = next;
}
}
}
    /// 2D spatial arrow key navigation across enabled buttons.
pub fn arrow_key(self: *Self, key: winit::keyboard::KeyCode, size: (f32) void {
}
//         use winit::keyboard::KeyCode;
    // rust: if self.rules.get_mut().is_some() {
    // rust: return;
}
    // rust: if self.has_caret_field() {
    // rust: return;
}
    // rust: if self.focused_button.is_none()
    // rust: && let Mode::Multiplayer(screen) = &mut self.mode
    // rust: && matches!(key, KeyCode::ArrowUp | KeyCode::ArrowDown)
    // rust: && screen.arrow(key == KeyCode::ArrowUp, shift, size, &self.saves)
    // rust: {
    // rust: return;
}
    // rust: if self.list_focused()
    // rust: && self.focused_button.is_none()
    // rust: && let Mode::Select { worlds, selected } = &mut self.mode
    // rust: {
    // rust: let len = worlds.len();
    // rust: if len > 0 {
    // rust: match key {
    // rust: KeyCode::ArrowUp => {
    // rust: *selected = Some(selected.map_or(0, |i| i.saturating_sub(1)));
    // rust: return;
}
    // rust: KeyCode::ArrowDown => {
    // rust: *selected = Some(selected.map_or(0, |i| (i + 1).min(len - 1)));
    // rust: return;
}
    // rust: _ => {}
}
}
}
    // rust: let (w, h) = size;
    // rust: let buttons = self.buttons(w, h);
    // rust: let enabled: Vec<&Button> = buttons.iter().filter(|b| b.enabled).collect();
    // rust: if enabled.is_empty() {
    // rust: return;
}
    // rust: let Some(cur_id) = self.focused_button else {
    // rust: self.focused_button = Some(enabled[0].id);
    // rust: return;
}
    // rust: let Some(cur_b) = enabled.iter().find(|b| b.id == cur_id) else {
    // rust: self.focused_button = Some(enabled[0].id);
    // rust: return;
}
    // rust: let (cx, cy) = (cur_b.x + cur_b.w / 2.0, cur_b.y + 10.0);
    // rust: let mut best: Option<(u8, f32)> = None;
    // rust: for b in &enabled {
    // rust: if b.id == cur_id {
    // rust: continue;
}
    // rust: let (bx, by) = (b.x + b.w / 2.0, b.y + 10.0);
    // rust: let (dx, dy) = (bx - cx, by - cy);
    // rust: let valid = match key {
    // rust: KeyCode::ArrowUp => dy < -4.0,
    // rust: KeyCode::ArrowDown => dy > 4.0,
    // rust: KeyCode::ArrowLeft => dx < -4.0,
    // rust: KeyCode::ArrowRight => dx > 4.0,
    // rust: _ => false,
}
    // rust: if !valid {
    // rust: continue;
}
    // rust: let dist = match key {
    // rust: KeyCode::ArrowUp | KeyCode::ArrowDown => dy.abs() + dx.abs() * 2.0,
    // rust: KeyCode::ArrowLeft | KeyCode::ArrowRight => dx.abs() + dy.abs() * 2.0,
    // rust: _ => f32::MAX,
}
    // rust: if best.as_ref().is_none_or(|(_, d)| dist < *d) {
    // rust: best = Some((b.id, dist));
}
}
    // rust: if let Some((next_id, _)) = best {
    // rust: self.focused_button = Some(next_id);
}
}
    /// The focus moves the selection on this list, the controller's as well as the keyboard's:
    /// the superflat and single-biome ones, where a selected row only sits there. On the world
    /// list the controller leaves it to A.
pub fn focus_selects_row(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.mode,
    // rust: Mode::CreateFlat { .. } | Mode::CreateBuffet { .. }
    // rust: )
}
    /// The focus landed on the list row at `point`
    /// (`AbstractSelectionList.setFocused`): it is selected, never joined,
    /// and the search box no longer has the keys. Whether a row was there.
pub fn focus_world_row(self: *Self, point: (f32) void {
}
    // rust: if self.rules.get_mut().is_some() {
    // rust: return false;
}
    // rust: match &mut self.mode {
    // rust: Mode::CreateFlat { flat, .. } => return flat::focus_row(flat, point, size),
    // rust: Mode::CreateBuffet { buffet, .. } => return buffet::focus_row(buffet, point, size),
    // rust: _ => {}
}
    // rust: let Mode::Select { worlds, .. } = &self.mode else {
    // rust: return false;
}
    // rust: let size = (size.0.ceil(), size.1.ceil());
    // rust: let Some(index) = self
    // rust: .world_row_at(worlds, point, size)
    // rust: .and_then(|(row, _)| self.visible_worlds(worlds).nth(row).map(|(i, _)| i))
    // rust: else {
    // rust: return false;
}
    // rust: self.search_focused = false;
    // rust: if let Mode::Select { selected, .. } = &mut self.mode {
    // rust: *selected = Some(index);
}
    // rust: true
}
    /// Which screen the title shows (a new one starts the keyboard's focus
    /// again, `Screen.setInitialFocus`).
pub fn screen_key(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::hash::{Hash, Hasher};
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: std::mem::discriminant(&self.mode).hash(&mut hasher);
    // rust: if let Mode::Multiplayer(screen) = &self.mode {
    // rust: std::mem::discriminant(screen).hash(&mut hasher);
}
    // rust: self.rules.borrow().is_some().hash(&mut hasher);
    // rust: hasher.finish()
}
    /// The keyboard's focus left a text field for another widget: the field
    /// loses the keys (`EditBox.setFocused(false)`).
pub fn blur_field(self: *Self) void {
}
    // rust: match &mut self.mode {
    // rust: Mode::Select { .. } => self.search_focused = false,
    // rust: Mode::Edit { focused, .. } => *focused = false,
    // rust: Mode::Create { focus, .. } => *focus = 2,
    // rust: _ => {}
}
}
    /// The server auto-reconnect retries now, once its countdown is over.
pub fn due_retry(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &mut self.mode {
    // rust: Mode::Multiplayer(screen) => screen.due_retry(),
    // rust: _ => None,
}
}
    // rust: pub(crate) fn remember_direct_address(&mut self) {
    // rust: if let Mode::Multiplayer(crate::multiplayer::Screen::Direct { address }) = &self.mode {
    // rust: self.last_server.clone_from(address);
}
}
    // rust: pub(crate) fn multiplayer_click(
    // rust: &mut self,
    // rust: hit: Option<u8>,
    // rust: x: f32,
    // rust: y: f32,
    // rust: size: (f32, f32),
    // rust: ) -> crate::multiplayer::Outcome {
    // rust: let Mode::Multiplayer(screen) = &mut self.mode else {
    // rust: return crate::multiplayer::Outcome::None;
}
    // rust: let outcome = screen.click(hit, x, y, size, &self.saves);
    // rust: if hit == Some(41)
    // rust: && let crate::multiplayer::Screen::Direct { address } = screen
    // rust: {
    // rust: address.clone_from(&self.last_server);
}
    // rust: outcome
}
    /// A left press on the game rules (they need the atlas for text): whether
    /// it lands on a button, for its sound.
pub fn press_rules(self: *Self, atlas: *HudAtlas, cursor: (f32) void {
}
    // rust: let size = (size.0.ceil(), size.1.ceil());
    // rust: if self.confirm_experiments.borrow().is_some() {
    // rust: let click = self
    // rust: .confirm_experiments
    // rust: .borrow()
    // rust: .as_ref()
    // rust: .and_then(|s| s.click(atlas, cursor, size));
    // rust: match click {
    // rust: Some(confirm_experiments::Click::Details) => {
    // rust: self.confirm_experiments
    // rust: .borrow_mut()
    // rust: .as_mut()
    // rust: .unwrap()
    // rust: .details = true;
    // rust: return true;
}
    // rust: Some(confirm_experiments::Click::Proceed) => {
    // rust: let pending = self
    // rust: .confirm_experiments
    // rust: .borrow_mut()
    // rust: .take()
    // rust: .map(|s| s.pending);
                    // `tryApplyNewDataPacks` accepted: the packs apply, and
                    // their data is read again (`applyNewPackConfig`'s load
                    // screen).
    // rust: if let Some(pending) = pending {
    // rust: self.set_data_packs(pending);
    // rust: self.preparing = true;
}
    // rust: return true;
}
    // rust: Some(confirm_experiments::Click::Back) => {
    // rust: let screen = self.confirm_experiments.borrow();
    // rust: let in_details = screen.as_ref().is_some_and(|s| s.details);
    // rust: drop(screen);
    // rust: if in_details {
    // rust: self.confirm_experiments
    // rust: .borrow_mut()
    // rust: .as_mut()
    // rust: .unwrap()
    // rust: .details = false;
    // rust: } else {
                        // `onAbort`: the confirm declines, the Data Packs
                        // screen reopens (the game side holds the folder).
    // rust: self.confirm_experiments.borrow_mut().take();
    // rust: self.reopen_data_packs = true;
}
    // rust: return true;
}
    // rust: None => return false,
}
}
    // rust: if self.experiments.borrow().is_some() {
    // rust: let click = self
    // rust: .experiments
    // rust: .borrow()
    // rust: .as_ref()
    // rust: .and_then(|s| s.click(atlas, cursor, size));
    // rust: match click {
                // ExperimentsScreen: a switch only flips the screen's own
                // list; the selection is written back when Done is pressed.
    // rust: Some(experiments::Click::Switch(i)) => {
    // rust: if let Some(f) = self
    // rust: .experiments
    // rust: .borrow_mut()
    // rust: .as_mut()
    // rust: .and_then(|s| s.flags.get_mut(i))
    // rust: {
    // rust: f.enabled = !f.enabled;
}
    // rust: return true;
}
    // rust: Some(experiments::Click::Outcome(outcome)) => {
                    // ExperimentsScreen.onDone: the other packs keep their
                    // order, the selected features are appended in reverse
                    // screen order. Cancel drops the switches.
    // rust: if outcome == experiments::Outcome::Done
    // rust: && let Mode::Create { options, .. } = &mut self.mode
    // rust: && let Some(flags) = self.experiments.borrow().as_ref().map(|s| {
    // rust: s.flags
    // rust: .iter()
    // rust: .map(|f| (f.id.clone(), f.enabled))
    // rust: .collect::<Vec<_>>()
    // rust: })
    // rust: {
    // rust: for (id, _) in &flags {
    // rust: options.data_packs.retain(|p| p != id);
}
    // rust: for (id, _) in flags.iter().rev().filter(|(_, e)| *e) {
    // rust: options.data_packs.push(id.clone());
}
}
    // rust: *self.experiments.get_mut() = None;
                    // `applyNewPackConfig`'s load screen: the data is read
                    // again for the packs the screen picked (Done only).
    // rust: if outcome == experiments::Outcome::Done {
    // rust: self.preparing = true;
}
    // rust: return true;
}
    // rust: None => return false,
}
}
    // rust: let Some(rules) = self.rules.get_mut() else {
    // rust: return false;
}
    // rust: let sound = rules.clicks_button(atlas, cursor, size);
    // rust: let exit = rules.click(atlas, cursor, size);
    // rust: if let Some(exit) = exit {
    // rust: self.close_rules(exit);
}
    // rust: sound
}
    /// WorldCreationGameRulesScreen's exit callback: Done keeps the edited
    /// rules (`setGameRules`), Cancel drops them.
pub fn close_rules(self: *Self, exit: Exit) void {
}
    // rust: *self.rules.get_mut() = None;
    // rust: if let (Exit::Apply(changes), Mode::Create { options, .. }) = (exit, &mut self.mode) {
    // rust: options.rules = options
    // rust: .rules
    // rust: .copy_with_features(&options.enabled_features(&self.resources));
    // rust: for (name, value) in changes {
    // rust: options.rules.set(name, value);
}
}
}
    /// `Gui.buildInitialScreens`' chain: the next queued ban notice, else the title.
pub fn next_ban_notice(self: *Self) void {
}
    // rust: self.mode = match self.ban_queue.pop_front() {
    // rust: Some(notice) => Mode::BanNotice(notice),
    // rust: None => Mode::Main,
}
}
    /// The account fetches vanilla starts in `Minecraft`'s constructor
    /// (`userPropertiesFuture`, `profileFuture`), run once per launch on a thread, only
    /// for a real online session (offline and demo have none). Their result decides
    /// `allowsMultiplayer` and queues `Gui.addInitialScreens`' ban notices, which open
    /// as soon as the title is showing.
pub fn poll_account(self: *Self) void {
}
//         use crate::ban_notice::{AccountStatus, initial_notices};
//         use std::sync::{
    // rust: OnceLock,
    // rust: atomic::{AtomicBool, Ordering},
}
pub const STATUS: OnceLock<AccountStatus> = OnceLock::new();
pub const STARTED: AtomicBool = AtomicBool::new(false);
pub const QUEUED: AtomicBool = AtomicBool::new(false);
    // rust: let Some(session) = crate::auth::current() else {
    // rust: return;
}
    // rust: if !STARTED.swap(true, Ordering::Relaxed) {
    // rust: let session = session.clone();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Account status".into())
    // rust: .spawn(move || {
    // rust: let _ = STATUS.set(crate::auth::fetch_account_status(&session));
    // rust: });
    // rust: if spawned.is_err() {
    // rust: log::warn!("Horizon: could not start the account status fetch");
}
}
    // rust: let Some(status) = STATUS.get() else {
    // rust: return;
}
    // rust: self.allows_multiplayer = status.allows_multiplayer();
    // rust: if !QUEUED.swap(true, Ordering::Relaxed) {
    // rust: self.ban_queue
    // rust: .extend(initial_notices(status, &session.name));
}
    // rust: if matches!(self.mode, Mode::Main) {
    // rust: self.next_ban_notice();
}
}
pub fn escape(self: *Self) void {
}
        // GenericMessageScreen.shouldCloseOnEsc is false: the preparing
        // read takes no input, the player's options survive it.
    // rust: if self.preparing {
    // rust: return;
}
    // rust: if self.confirm_experiments.get_mut().take().is_some() {
    // rust: self.reopen_data_packs = true;
    // rust: return;
}
    // rust: if self.experiments.get_mut().take().is_some() {
    // rust: return;
}
    // rust: if let Some(rules) = self.rules.get_mut() {
    // rust: if let Some(exit) = rules.escape() {
    // rust: self.close_rules(exit);
}
    // rust: return;
}
    // rust: self.remember_direct_address();
    // rust: if let Mode::Multiplayer(screen) = &mut self.mode
    // rust: && !screen.escape(&self.saves)
    // rust: {
    // rust: return;
}
    // rust: if let Mode::Realms(screen) = &mut self.mode
    // rust: && !screen.escape()
    // rust: {
    // rust: return;
}
    // rust: match &self.mode {
            // OptimizeWorldScreen: `shouldCloseOnEsc` is false; the Backup wait takes no input.
    // rust: Mode::Backup { .. } | Mode::Optimize { .. } => {}
            // BackupConfirmScreen.keyPressed: Escape runs `onCancel`, the Edit World screen again.
    // rust: Mode::OptimizeConfirm { world, name, .. } => {
    // rust: self.mode = Mode::Edit {
    // rust: world: world.clone(),
    // rust: name: name.clone(),
    // rust: focused: true,
}
}
    // rust: Mode::Edit { world, .. }
    // rust: | Mode::Delete { world }
    // rust: | Mode::Recover { world, .. }
    // rust: | Mode::Recovered { world, .. }
    // rust: | Mode::LowDiskSpace { world }
    // rust: | Mode::BackupBeforeUpgrade { world, .. } => {
    // rust: let folder = world.folder.clone();
    // rust: self.return_to_list(Some(&folder));
}
    // rust: Mode::Error { return_to, .. } => self.mode = *return_to.clone(),
    // rust: Mode::CreateFlat { .. } => {
    // rust: if matches!(&self.mode, Mode::CreateFlat { flat, .. } if flat.page == flat::Page::Presets)
    // rust: {
    // rust: if let Mode::CreateFlat { flat, .. } = &mut self.mode {
    // rust: flat.back_to_layers();
}
    // rust: } else {
    // rust: self.close_flat(false);
}
}
    // rust: Mode::CreateBuffet { .. } => self.close_buffet(false),
    // rust: Mode::Create { .. } => self.cancel_create(),
            // Screen.keyPressed: Escape closes the screen, which fades out.
    // rust: Mode::Onboarding(_) => self.onboarding_close(),
            // ConfirmScreen.keyPressed: Escape answers no, which runs `next`.
    // rust: Mode::BanNotice(_) => self.next_ban_notice(),
    // rust: _ => self.mode = Mode::Main,
}
}
    /// `JoinMultiplayerScreen.keyPressed`: F5 refreshes the server list as
    /// Refresh does (`refreshServerList`).
pub fn refresh_servers(self: *Self) void {
}
    // rust: if let Mode::Multiplayer(screen @ crate::multiplayer::Screen::List { .. }) = &mut self.mode
    // rust: {
    // rust: *screen = crate::multiplayer::Screen::list(&self.saves);
}
}
}
pub fn centered(atlas: *HudAtlas, batch: *mut HudBatch, text: []const u8, y: f32, color: u32) void {
}
    // rust: batch.text(
    // rust: atlas,
    // rust: text,
    // rust: (batch.width.ceil() / 2.0).floor()
    // rust: - (HudBatch::text_width(atlas, text).ceil() / 2.0).floor(),
    // rust: y,
    // rust: color,
    // rust: true,
    // rust: );
}
pub fn wrapped(atlas: *HudAtlas, text: []const u8, width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: atlas
    // rust: .font
    // rust: .split(&crate::text::Text::literal(text), width.max(1.0))
    // rust: .iter()
    // rust: .map(|t| t.plain())
    // rust: .collect()
}
pub const SEARCH: crate::clipboard::FieldId = ("world.search", 0);
pub const EDIT_NAME: crate::clipboard::FieldId = ("world.edit-name", 0);
pub const WORLD_NAME: crate::clipboard::FieldId = ("world.name", 0);
pub const WORLD_SEED: crate::clipboard::FieldId = ("world.seed", 0);
pub const FLAT_SHARE: crate::clipboard::FieldId = ("world.flat-share", 0);
/// The focused field of the world screens and the server screens: the list's
/// search, a world name or seed, or Add Server, Direct Connection and Join a
/// Friend.
    // rust: fn caret_field<'a>(
    // rust: mode: &'a mut Mode,
    // rust: search_focused: bool,
    // rust: search: &'a mut String,
    // rust: ) -> Option<(crate::clipboard::FieldId, &'a mut String, usize)> {
    // rust: match mode {
    // rust: Mode::Select { .. } if search_focused => Some((SEARCH, search, 50)),
    // rust: Mode::Edit {
    // rust: name,
    // rust: focused: true,
    // rust: ..
    // rust: } => Some((EDIT_NAME, name, 32)),
    // rust: Mode::Create {
    // rust: name, seed, focus, ..
    // rust: } => match focus {
    // rust: 0 => Some((WORLD_NAME, name, 32)),
    // rust: 1 => Some((WORLD_SEED, seed, 32)),
    // rust: _ => None,
    // rust: },
    // rust: Mode::Multiplayer(screen) => screen.focused_text(),
    // rust: Mode::Realms(screen) => screen.focused_text(),
    // rust: Mode::CreateFlat { flat, .. } if flat.page == flat::Page::Presets && flat.share_focused => {
    // rust: Some((FLAT_SHARE, &mut flat.share, 1230))
}
        // CreateBuffetWorldScreen's search box.
    // rust: Mode::CreateBuffet { buffet, .. } if buffet.query_focused => {
    // rust: Some((buffet::SEARCH, &mut buffet.query, 50))
}
    // rust: _ => None,
}
}

    // rust: mod classic_tests {
//     use super::*;

    /// Tab is how a keyboard player reaches the world list: from the search
    /// box it hands focus to the list (where the arrow keys pick a row and
    /// Enter joins it), and from the list it moves on to the buttons.
pub fn tab_walks_from_the_search_box_to_the_world_list() void {
}
    // rust: let mut title = Title::new(
    // rust: PathBuf::new(),
    // rust: Path::new("/nonexistent/horizon-test-resources"),
    // rust: );
    // rust: title.mode = Mode::Select {
    // rust: worlds: Vec::new(),
    // rust: selected: None,
}
    // rust: title.search_focused = true;
    // rust: title.focused_button = None;
    // rust: title.tab_dir(false, (854.0, 480.0));
    // rust: assert!(!title.search_focused, "the search box lets go");
    // rust: assert!(
    // rust: title.focused_button.is_none() && title.list_focused(),
    // rust: "the world list has focus"
    // rust: );
    // rust: title.tab_dir(false, (854.0, 480.0));
    // rust: assert!(
    // rust: title.focused_button.is_some(),
    // rust: "the next Tab reaches the buttons"
    // rust: );
}

    /// Vanilla: clicking an EditBox focuses it, so a button focused earlier stops
    /// reacting to Space (which the box types).
pub fn clicking_a_text_field_drops_the_focused_button() void {
}
    // rust: let mut title = Title::new(
    // rust: PathBuf::new(),
    // rust: Path::new("/nonexistent/horizon-test-resources"),
    // rust: );
    // rust: title.mode = Mode::Create {
    // rust: name: String::new(),
    // rust: seed: String::new(),
    // rust: creative: false,
    // rust: focus: 0,
    // rust: options: WorldOptions::default(),
}
    // rust: title.focused_button = Some(1);
        // A click inside the name field hits no button and focuses the field.
    // rust: let (_, [fx, fy, fw, fh]) = create_world::field_rect(854.0, 480.0, 0).unwrap();
    // rust: let (action, _) = title.click(fx + fw / 2.0, fy + fh / 2.0, (854.0, 480.0));
    // rust: assert!(matches!(action, Action::None));
    // rust: assert!(title.focused_button.is_none());
    // rust: assert!(title.has_caret_field());
    // rust: title.type_text(" ");
    // rust: match &title.mode {
    // rust: Mode::Create { name, .. } => assert_eq!(name, " "),
    // rust: _ => unreachable!(),
}
}

pub fn ban_notices_chain_into_the_title_and_gate_multiplayer() void {
}
//         use crate::ban_notice::{BanDetails, Notice};
    // rust: let mut title = Title::new(
    // rust: PathBuf::new(),
    // rust: Path::new("/nonexistent/horizon-test-resources"),
    // rust: );
    // rust: let multiplayer = |title: &Title| {
    // rust: title
    // rust: .buttons(427.0, 240.0)
    // rust: .into_iter()
    // rust: .find(|b| b.id == 4)
    // rust: .unwrap()
    // rust: .enabled
}
    // rust: assert!(multiplayer(&title));
    // rust: title.allows_multiplayer = false;
    // rust: assert!(!multiplayer(&title));
        // Gui.buildInitialScreens: each notice runs `next`, the last one opens the title.
    // rust: let ban = BanDetails {
    // rust: expires_ms: None,
    // rust: reason: None,
    // rust: reason_message: None,
}
    // rust: title.ban_queue = [Notice::Name("Steve".into()), Notice::Skin].into();
    // rust: title.mode = Mode::BanNotice(Notice::Multiplayer(ban));
    // rust: assert_eq!(title.buttons(427.0, 240.0).len(), 3);
    // rust: title.escape();
    // rust: assert!(matches!(&title.mode, Mode::BanNotice(Notice::Name(n)) if n == "Steve"));
    // rust: title.escape();
    // rust: assert!(matches!(title.mode, Mode::BanNotice(Notice::Skin)));
    // rust: title.next_ban_notice();
    // rust: assert!(matches!(title.mode, Mode::Main));
}

pub fn the_bottom_text_button_opens_the_credits() void {
}
        // TitleScreen.init's PlainTextButton: a press inside its drawn rect.
    // rust: let mut title = Title::new(
    // rust: PathBuf::new(),
    // rust: Path::new("/nonexistent/horizon-test-resources"),
    // rust: );
    // rust: title.credits_button.set([300.0, 230.0, 120.0, 10.0]);
    // rust: assert_eq!(
    // rust: title.click(310.0, 235.0, (427.0, 240.0)),
    // rust: (Action::Credits, true)
    // rust: );
    // rust: assert_eq!(
    // rust: title.click(310.0, 225.0, (427.0, 240.0)),
    // rust: (Action::None, false)
    // rust: );
}

pub fn classic_main_menu_icons_route_language_and_accessibility() void {
}
    // rust: let mut title = Title::new(
    // rust: PathBuf::new(),
    // rust: Path::new("/nonexistent/horizon-test-resources"),
    // rust: );
    // rust: for (w, h) in [(960.0, 523.0), (480.0, 320.0), (427.0, 240.0)] {
    // rust: let buttons = title.buttons(w, h);
    // rust: let cx = (w / 2.0).floor();
    // rust: let y = (h / 4.0).floor() + 48.0;
    // rust: for (id, x, enabled, icon) in [
    // rust: (5, cx - 34.0, true, "friends/friends"),
    // rust: (6, cx - 10.0, true, "icon/language"),
    // rust: (7, cx + 14.0, true, "icon/accessibility"),
    // rust: ] {
    // rust: let b = buttons.iter().find(|b| b.id == id).unwrap();
    // rust: assert_eq!(
    // rust: (b.x, b.y, b.w, b.enabled, b.icon),
    // rust: (x, y + 72.0, 20.0, enabled, Some((icon, 15.0)))
    // rust: );
    // rust: assert_eq!(
    // rust: title.click(x + 10.0, y + 82.0, (w, h)),
    // rust: match id {
    // rust: 6 => (Action::Language, true),
    // rust: 7 => (Action::Accessibility, true),
    // rust: _ => (Action::None, true),
}
    // rust: );
    // rust: if id == 5 {
    // rust: assert!(matches!(
    // rust: title.mode,
    // rust: Mode::Multiplayer(crate::multiplayer::Screen::Friend { .. })
    // rust: ));
    // rust: title.mode = Mode::Main;
}
}
    // rust: for id in [2, 3] {
    // rust: assert_eq!(buttons.iter().find(|b| b.id == id).unwrap().y, y + 96.0);
}
            // The four-pixel gaps around icons must not activate a button.
    // rust: assert_eq!(
    // rust: title.click(cx + 12.0, y + 82.0, (w, h)),
    // rust: (Action::None, false)
    // rust: );
    // rust: assert_eq!(
    // rust: title.click(cx + 24.0, y + 92.0, (w, h)),
    // rust: (Action::None, false)
    // rust: );
}
}

pub fn splash_selection_filters_the_forbidden_hash_and_has_no_fallback() void {
}
    // rust: let hidden = "This message will never appear on the splash screen, isn't that weird?";
    // rust: assert_eq!(
    // rust: horizon_core::random::java_string_hash(hidden.encode_utf16()),
    // rust: 125780783
    // rust: );
    // rust: let text = format!("\n First! \r\n{hidden}\nSecond!\n");
    // rust: for index in 0..6 {
    // rust: assert_eq!(
    // rust: choose_splash(&text, index, (10, 15)).as_deref(),
    // rust: Some(["", "First!", "Second!"][index % 3])
    // rust: );
}
    // rust: assert_eq!(choose_splash(" \r\n", 42, (10, 15)).as_deref(), Some(""));
    // rust: for text in ["", hidden] {
    // rust: assert_eq!(choose_splash(text, 42, (10, 15)), None);
}
}

pub fn special_date_splashes_override_resources_even_when_the_list_is_empty() void {
}
    // rust: for (date, expected) in [
    // rust: ((12, 24), "Merry X-mas!"),
    // rust: ((1, 1), "Happy new year!"),
    // rust: ((10, 31), "OOoooOOOoooo! Spooky!"),
    // rust: ] {
    // rust: for text in ["", "Ordinary splash!"] {
    // rust: assert_eq!(choose_splash(text, 0, date).as_deref(), Some(expected));
}
}
}

pub fn classic_logo_and_icon_geometry_matches_minecraft() void {
}
    // rust: let root = Path::new("/nonexistent/horizon-test-resources");
    // rust: let mut atlas = HudAtlas::build(root).unwrap();
    // rust: let r = crate::hud::Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1024,
    // rust: h: 256,
}
    // rust: atlas.sprites.insert("gui/title/minecraft".into(), r);
    // rust: atlas.sprites.insert(
    // rust: "gui/title/edition".into(),
    // rust: crate::hud::Rect { w: 128, h: 16, ..r },
    // rust: );
    // rust: for (i, icon) in ["friends/friends", "icon/language", "icon/accessibility"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: atlas.sprites.insert(
    // rust: format!("gui/sprites/{icon}"),
    // rust: crate::hud::Rect {
    // rust: u0: 0.25 + i as f32 * 0.125,
    // rust: w: 15,
    // rust: h: 15,
    // rust: ..r
    // rust: },
    // rust: );
}
    // rust: let mut title = Title::new(PathBuf::new(), root);
    // rust: title.splash = Some("Visible splash!".into());
    // rust: let mut batch = HudBatch::new([1920, 1080]);
    // rust: title.draw(&atlas, &mut batch, (0.0, 0.0), false);
    // rust: let cx = (batch.width / 2.0).floor();
    // rust: assert_eq!(batch.vertices[0].pos, [cx - 128.0, 30.0]);
    // rust: assert_eq!(batch.vertices[2].pos, [cx + 128.0, 74.0]);
    // rust: assert_eq!(batch.vertices[2].uv, [1.0, 44.0 / 64.0]);
    // rust: assert_eq!(batch.vertices[6].pos, [cx - 64.0, 67.0]);
    // rust: assert_eq!(batch.vertices[8].pos, [cx + 64.0, 81.0]);
    // rust: assert_eq!(batch.vertices[8].uv, [1.0, 14.0 / 16.0]);
    // rust: for i in 0..3 {
    // rust: let quad = batch
    // rust: .vertices
    // rust: .as_chunks::<6>()
    // rust: .0
    // rust: .iter()
    // rust: .find(|quad| quad[0].uv == [0.25 + i as f32 * 0.125, 0.0])
    // rust: .unwrap();
    // rust: let x = cx - 34.0 + i as f32 * 24.0 + 3.0;
    // rust: let y = (batch.height / 4.0).floor() + 48.0 + 72.0 + 3.0;
    // rust: assert_eq!(quad[0].pos, [x, y]);
    // rust: assert_eq!(quad[2].pos, [x + 15.0, y + 15.0]);
    // rust: assert!(quad.iter().all(|v| v.color == u32::MAX));
}
    // rust: assert!(
    // rust: batch.vertices[12..]
    // rust: .iter()
    // rust: .any(|v| v.color == rgba(255, 255, 0, 255))
    // rust: );
    // rust: let settings = crate::settings::Settings::parse("hideSplashTexts:true\n");
    // rust: for (hide_splash, splash) in [
    // rust: (
    // rust: settings.file.bool("hideSplashTexts"),
    // rust: Some("Hidden splash!".into()),
    // rust: ),
    // rust: (false, None),
    // rust: ] {
    // rust: title.splash = splash;
    // rust: let mut hidden = HudBatch::new([1920, 1080]);
    // rust: title.draw(&atlas, &mut hidden, (0.0, 0.0), hide_splash);
    // rust: assert!(
    // rust: !hidden
    // rust: .vertices
    // rust: .iter()
    // rust: .any(|v| v.color == rgba(255, 255, 0, 255))
    // rust: );
}
}
}
