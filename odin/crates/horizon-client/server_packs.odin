//! Transpiled from Horizon Rust crate
package horizon_client_server_packs

import "core:fmt"
import "core:mem"
import "core:math"

// Server resource packs (`ServerPackManager`, `DownloadedPackSource`): the
// packs a server pushes, the player's answer to its prompt, their downloads,
// their activation on top of the player's own packs, and the status each one
// reports back to the server. The game drives it: it shows the prompt,
// starts the downloads [`ServerPacks::tick`] asks for and reloads the
// resources with [`ServerPacks::active`] when it asks for a reload.
    // rust: pub mod download;

// use std::path::PathBuf;

// `ServerboundResourcePackPacket.Action`, by its protocol number.
    // rust: pub mod action {
SUCCESSFULLY_LOADED :: 0
DECLINED :: 1
FAILED_DOWNLOAD :: 2
ACCEPTED :: 3
DOWNLOADED :: 4
INVALID_URL :: 5
FAILED_RELOAD :: 6
DISCARDED :: 7
}

// `ServerPackManager.PackPromptStatus`.
Prompt :: enum {
    Pending,
    Allowed,
    Declined,
}
    // rust: impl Prompt {
    // `ConnectScreen.convertPackStatus`: a server list entry's setting
    // (servers.dat `acceptTextures`; none is Prompt).
for_server :: proc(accept_textures: Maybe(bool)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match accept_textures {
    // rust: Some(true) => Self::Allowed,
    // rust: Some(false) => Self::Declined,
    // rust: None => Self::Pending,
}
}
}

// `ClientCommonPacketListenerImpl.parseResourcePackUrl`: only http and https.
valid_url :: proc(url: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: url.split_once(':').is_some_and(|(scheme, _)| {
    // rust: scheme.eq_ignore_ascii_case("http") || scheme.eq_ignore_ascii_case("https")
    // rust: })
}

// `DownloadedPackSource.tryParseSha1Hash`: 40 hex digits, else no check.
parse_sha1 :: proc(hash: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (hash.len() == 40 && hash.bytes().all(|b| b.is_ascii_hexdigit()))
    // rust: .then(|| hash.to_ascii_lowercase())
}

// One pack to download (`DownloadQueue.DownloadRequest`).
Request :: struct {
    id: u128,
    url: string,
    sha1: Maybe(string),
}

// `DownloadQueue.BatchResult`: the file each downloaded pack is in, and the
// packs that failed.
Batch :: struct {
    downloaded: Vec<(u128,
    failed: [dynamic]u128,
}

// What the game has to do after a [`ServerPacks::tick`].
Tick :: struct {
    // Download these, then hand the result to [`ServerPacks::downloaded`].
    download: [dynamic]Request,
    // Reload the resources with these packs on top, bottom first
    // (`PackReloadConfig.scheduleReload`), then call [`ServerPacks::reloaded`].
    reload: Option<Vec<(u128,
}

Download :: enum {
    Requested,
    Pending,
    Done,
}
Activation :: enum {
    Inactive,
    Pending,
    Active,
}
// `ServerPackManager.RemovalReason`, with the status it reports.
Removal :: enum {
    DownloadFailed,
    ActivationFailed,
    Declined,
    Discarded,
    ServerRemoved,
    ServerReplaced,
}
    // rust: impl Removal {
reply :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::DownloadFailed => Some(action::FAILED_DOWNLOAD),
    // rust: Self::ActivationFailed => Some(action::FAILED_RELOAD),
    // rust: Self::Declined => Some(action::DECLINED),
    // rust: Self::Discarded => Some(action::DISCARDED),
    // rust: Self::ServerRemoved | Self::ServerReplaced => None,
}
}
}

// `ServerPackManager.ServerPackData`.
Pack :: struct {
    // Which `ServerPackData` this is: a pushed id replaces its pack while the old
    // one can still be active, so a reload names its packs by this, not by `id`.
    key: u64,
    id: u128,
    url: string,
    sha1: Maybe(string),
    path: Maybe(PathBuf),
    removal: Maybe(Removal),
    download: Download,
    activation: Activation,
    accepted: bool,
}
    // rust: impl Pack {
remove :: proc(self: ^Self, reason: Removal) {
}
    // rust: self.removal.get_or_insert(reason);
}
removed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.removal.is_some()
}
}

// The reload in progress: the packs it loads and unloads (the callbacks
// `triggerReloadIfNeeded` gives `scheduleReload`).
Reload :: struct {
    load: [dynamic]u64,
    unload: [dynamic]u64,
    // It reloads what was active before a failed one (`isRecovery`).
    recovery: bool,
}

// `ServerPackManager` with the feedback `DownloadedPackSource` gives it.
ServerPacks :: struct {
    packs: [dynamic]Pack,
    prompt: Prompt,
    reload: Maybe(Reload),
    // `registerForUpdate`: something changed, [`Self::tick`] again.
    update: bool,
    // Report to the server (`configureForServerControl`); otherwise the
    // statuses are only logged, as for a local world.
    reporting: bool,
    replies: Vec<(u128,
    next_key: u64,
}
    // rust: impl Default for ServerPacks {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: packs: Vec::new(),
    // rust: prompt: Prompt::Pending,
    // rust: reload: None,
    // rust: update: false,
    // rust: reporting: false,
    // rust: replies: Vec::new(),
    // rust: next_key: 0,
}
}
}
    // rust: impl ServerPacks {
report :: proc(self: ^Self, id: u128, status: i32) {
}
    // rust: log::debug!("Horizon: server pack {id:032x} changed status to {status}");
    // rust: if self.reporting {
    // rust: self.replies.push((id, status));
}
}
    // The statuses to send the server, oldest first.
take_replies :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::mem::take(&mut self.replies)
}
    // Whether [`Self::tick`] has something to do.
wants_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.update
}

    // `DownloadedPackSource.configureForServerControl`.
connect :: proc(self: ^Self, prompt: Prompt) {
}
    // rust: self.reporting = true;
    // rust: match prompt {
    // rust: Prompt::Allowed => self.allow(),
    // rust: Prompt::Declined => self.reject(),
    // rust: Prompt::Pending => self.prompt = Prompt::Pending,
}
}
    // `DownloadedPackSource.configureForLocalWorld`: single player's own
    // server; its packs are taken, and nothing is reported.
local_world :: proc(self: ^Self) {
}
    // rust: self.reporting = false;
    // rust: self.allow();
}
    // `DownloadedPackSource.cleanupAfterDisconnect`: every pack goes, and
    // the next server starts from its own setting.
disconnect :: proc(self: ^Self) {
}
    // rust: self.pop_all();
    // rust: self.reporting = false;
    // rust: self.replies.clear();
    // rust: self.prompt = Prompt::Pending;
}

push :: proc(self: ^Self, id: u128, url: string, sha1: Maybe(string)) {
}
    // rust: if self.prompt == Prompt::Declined {
    // rust: self.report(id, action::DECLINED);
    // rust: return;
}
    // rust: for pack in self.packs.iter_mut().filter(|p| p.id == id) {
    // rust: pack.remove(Removal::ServerReplaced);
}
    // rust: self.next_key += 1;
    // rust: self.packs.push(Pack {
    // rust: key: self.next_key,
    // rust: id,
    // rust: url: url.to_owned(),
    // rust: sha1,
    // rust: path: None,
    // rust: removal: None,
    // rust: download: Download::Requested,
    // rust: activation: Activation::Inactive,
    // rust: accepted: false,
    // rust: });
    // rust: if self.prompt == Prompt::Allowed {
    // rust: self.accept(self.packs.len() - 1);
}
    // rust: self.update = true;
}
    // `ServerPackManager.pushLocalPack`: a pack already on disk, taken as
    // downloaded (a world's own `resourcepacks/resources.zip`).
push_local :: proc(self: ^Self, id: u128, path: PathBuf) {
}
    // rust: if self.prompt == Prompt::Declined {
    // rust: self.report(id, action::DECLINED);
    // rust: return;
}
    // rust: for pack in self.packs.iter_mut().filter(|p| p.id == id) {
    // rust: pack.remove(Removal::ServerReplaced);
}
    // rust: self.next_key += 1;
    // rust: self.packs.push(Pack {
    // rust: key: self.next_key,
    // rust: id,
            // Never downloaded: the file is already on disk.
    // rust: url: String::new(),
    // rust: sha1: None,
    // rust: path: Some(path),
    // rust: removal: None,
    // rust: download: Download::Done,
    // rust: activation: Activation::Inactive,
    // rust: accepted: false,
    // rust: });
    // rust: if self.prompt == Prompt::Allowed {
    // rust: self.accept(self.packs.len() - 1);
}
    // rust: self.update = true;
}
    // What the player answered for this server's packs (splitscreen: the others follow P1).
prompt :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.prompt
}
accept :: proc(self: ^Self, i: uint) {
}
    // rust: self.packs[i].accepted = true;
    // rust: let id = self.packs[i].id;
    // rust: self.report(id, action::ACCEPTED);
}
pop :: proc(self: ^Self, id: u128) {
}
    // rust: if let Some(pack) = self.packs.iter_mut().find(|p| !p.removed() && p.id == id) {
    // rust: pack.remove(Removal::ServerRemoved);
    // rust: self.update = true;
}
}
pop_all :: proc(self: ^Self) {
}
    // rust: for pack in &mut self.packs {
    // rust: pack.remove(Removal::ServerRemoved);
}
    // rust: self.update = true;
}
    // `allowServerPacks`: the prompt said yes (or the server is Enabled).
allow :: proc(self: ^Self) {
}
    // rust: self.prompt = Prompt::Allowed;
    // rust: for i in 0..self.packs.len() {
    // rust: if !self.packs[i].accepted && !self.packs[i].removed() {
    // rust: self.accept(i);
}
}
    // rust: self.update = true;
}
    // `rejectServerPacks`: the prompt said no (or the server is Disabled).
reject :: proc(self: ^Self) {
}
    // rust: self.prompt = Prompt::Declined;
    // rust: for pack in self.packs.iter_mut().filter(|p| !p.accepted) {
    // rust: pack.remove(Removal::Declined);
}
    // rust: self.update = true;
}

    // `ServerPackManager.tick`: start the downloads the accepted packs
    // need; once none is left, reload if the active packs should change;
    // then forget the packs that are gone, reporting why.
tick :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.update = false;
    // rust: let mut out = Tick::default();
    // rust: let mut downloading = false;
    // rust: for pack in self.packs.iter_mut().filter(|p| !p.removed() && p.accepted) {
    // rust: downloading |= pack.download != Download::Done;
    // rust: if pack.download == Download::Requested {
    // rust: pack.download = Download::Pending;
    // rust: out.download.push(Request {
    // rust: id: pack.id,
    // rust: url: pack.url.clone(),
    // rust: sha1: pack.sha1.clone(),
    // rust: });
}
}
    // rust: if !downloading {
    // rust: out.reload = self.reload_if_needed();
}
    // rust: let mut gone = Vec::new();
    // rust: self.packs.retain(|p| {
    // rust: let keep = p.activation != Activation::Inactive || p.removal.is_none();
    // rust: if !keep && let Some(reply) = p.removal.and_then(Removal::reply) {
    // rust: gone.push((p.id, reply));
}
    // rust: keep
    // rust: });
    // rust: for (id, reply) in gone {
    // rust: self.report(id, reply);
}
    // rust: out
}
reload_if_needed :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.reload.is_some()
    // rust: || self
    // rust: .packs
    // rust: .iter()
    // rust: .any(|p| p.activation == Activation::Pending)
    // rust: {
    // rust: return None;
}
    // rust: let mut changed = false;
    // rust: let (mut load, mut unload) = (Vec::new(), Vec::new());
    // rust: for pack in &self.packs {
    // rust: let wanted = pack.accepted && pack.download == Download::Done && !pack.removed();
    // rust: match pack.activation {
    // rust: Activation::Inactive if wanted => {
    // rust: load.push(pack.key);
    // rust: changed = true;
}
    // rust: Activation::Active if wanted => load.push(pack.key),
    // rust: Activation::Active => {
    // rust: unload.push(pack.key);
    // rust: changed = true;
}
    // rust: _ => {}
}
}
    // rust: if !changed {
    // rust: return None;
}
    // rust: for pack in &mut self.packs {
    // rust: let loading = load.contains(&pack.key) && pack.activation != Activation::Active;
    // rust: if loading || unload.contains(&pack.key) {
    // rust: pack.activation = Activation::Pending;
}
}
    // rust: let paths = self.paths(&load);
    // rust: self.reload = Some(Reload {
    // rust: load,
    // rust: unload,
    // rust: recovery: false,
    // rust: });
    // rust: Some(paths)
}
    // The packs to load (`PackReloadConfig.Callbacks.packsToLoad`), bottom first.
paths :: proc(self: ^Self, keys: ^[u64]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: keys.iter()
    // rust: .filter_map(|key| {
    // rust: let pack = self.packs.iter().find(|p| p.key == *key)?;
    // rust: Some((pack.id, pack.path.clone()?))
    // rust: })
    // rust: .collect()
}

    // `ServerPackManager.onDownload`.
downloaded :: proc(self: ^Self, batch: Batch) {
}
    // rust: if !batch.failed.is_empty() {
    // rust: for pack in self
    // rust: .packs
    // rust: .iter_mut()
    // rust: .filter(|p| p.activation != Activation::Active)
    // rust: {
    // rust: pack.remove(if batch.failed.contains(&pack.id) {
    // rust: Removal::DownloadFailed
    // rust: } else {
    // rust: Removal::Discarded
    // rust: });
}
}
    // rust: let mut done = Vec::new();
    // rust: for (id, path) in batch.downloaded {
    // rust: if let Some(pack) = self
    // rust: .packs
    // rust: .iter_mut()
    // rust: .find(|p| p.id == id && p.download == Download::Pending)
    // rust: {
    // rust: pack.download = Download::Done;
    // rust: pack.path = Some(path);
    // rust: if !pack.removed() {
    // rust: done.push(id);
}
}
}
    // rust: for id in done {
    // rust: self.report(id, action::DOWNLOADED);
}
    // rust: self.update = true;
}

    // The reload [`Tick::reload`] asked for finished (`Callbacks.onSuccess`),
    // or its packs could not be loaded (`onFailure`). After a first failure
    // the packs that were active are loaded again: the packs to reload with
    // are returned, and this is called again with that reload's outcome.
reloaded :: proc(self: ^Self, ok: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut reload = self.reload.take()?;
    // rust: self.update = true;
    // rust: if ok {
    // rust: let mut applied = Vec::new();
    // rust: for pack in &mut self.packs {
    // rust: if reload.load.contains(&pack.key) {
    // rust: pack.activation = Activation::Active;
    // rust: if pack.removal.is_none() {
    // rust: applied.push(pack.id);
}
    // rust: } else if reload.unload.contains(&pack.key) {
    // rust: pack.activation = Activation::Inactive;
}
}
    // rust: for id in applied {
    // rust: self.report(id, action::SUCCESSFULLY_LOADED);
}
    // rust: return None;
}
    // rust: if reload.recovery {
            // onFailure(true): nothing of the server's is loaded.
    // rust: for pack in &mut self.packs {
    // rust: if pack.activation == Activation::Pending {
    // rust: pack.activation = Activation::Inactive;
}
}
    // rust: return None;
}
    // rust: reload.load.clear();
    // rust: for pack in &mut self.packs {
    // rust: match pack.activation {
    // rust: Activation::Inactive => pack.remove(Removal::Discarded),
    // rust: Activation::Pending => {
    // rust: pack.activation = Activation::Inactive;
    // rust: pack.remove(Removal::ActivationFailed);
}
    // rust: Activation::Active => reload.load.push(pack.key),
}
}
    // rust: reload.recovery = true;
    // rust: let paths = self.paths(&reload.load);
    // rust: self.reload = Some(reload);
    // rust: Some(paths)
}
}

    // rust: mod tests {
//     use super::*;
//     use action::*;

ok :: proc(id: u128) -> B {
    // Ported from Horizon
    return {}
}
    // rust: Batch {
    // rust: downloaded: vec![(id, PathBuf::from(format!("/p/{id}")))],
    // rust: failed: vec![],
}
}
    // Runs the updates as `createUpdateScheduler` does, downloading and
    // reloading with `download` and `reload` as the game would.
    // rust: fn settle(
    // rust: sp: &mut ServerPacks,
    // rust: download: &mut dyn FnMut(&[Request]) -> Batch,
    // rust: reload: &mut dyn FnMut(&[(u128, PathBuf)]) -> bool,
    // rust: ) {
    // rust: let mut rounds = 0;
    // rust: while sp.wants_tick() {
    // rust: rounds += 1;
    // rust: assert!(rounds < 50);
    // rust: let t = sp.tick();
    // rust: if !t.download.is_empty() {
    // rust: let batch = download(&t.download);
    // rust: sp.downloaded(batch);
}
    // rust: if let Some(mut packs) = t.reload {
    // rust: while let Some(back) = sp.reloaded(reload(&packs)) {
    // rust: packs = back;
}
}
}
}

an_enabled_server_s_pack_is_accepted_downloaded_and_loaded :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Allowed);
    // rust: sp.push(1, "http://a/p.zip", None);
    // rust: let mut loaded = Vec::new();
    // rust: settle(&mut sp, &mut |r| ok(r[0].id), &mut |p| {
    // rust: loaded = p.to_vec();
    // rust: true
    // rust: });
    // rust: assert_eq!(
    // rust: sp.take_replies(),
    // rust: [(1, ACCEPTED), (1, DOWNLOADED), (1, SUCCESSFULLY_LOADED)]
    // rust: );
    // rust: assert_eq!(loaded, [(1, PathBuf::from("/p/1"))]);
}

the_prompt_holds_packs_until_answered :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Pending);
    // rust: sp.push(1, "http://a/p.zip", None);
    // rust: settle(&mut sp, &mut |_| unreachable!(), &mut |_| unreachable!());
    // rust: assert!(sp.take_replies().is_empty());
    // rust: sp.reject();
    // rust: settle(&mut sp, &mut |_| unreachable!(), &mut |_| unreachable!());
    // rust: assert_eq!(sp.take_replies(), [(1, DECLINED)]);
        // Declined: later pushes are declined at once.
    // rust: sp.push(2, "http://a/q.zip", None);
    // rust: assert_eq!(sp.take_replies(), [(2, DECLINED)]);
}

a_failed_download_discards_the_rest_of_the_batch :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Allowed);
    // rust: sp.push(1, "http://a/p.zip", None);
    // rust: sp.push(2, "http://a/dead.zip", None);
    // rust: settle(
    // rust: &mut sp,
    // rust: &mut |_| Batch {
    // rust: downloaded: vec![(1, PathBuf::from("/p/1"))],
    // rust: failed: vec![2],
    // rust: },
    // rust: &mut |_| unreachable!(),
    // rust: );
    // rust: assert_eq!(
    // rust: sp.take_replies(),
    // rust: [
    // rust: (1, ACCEPTED),
    // rust: (2, ACCEPTED),
    // rust: (1, DISCARDED),
    // rust: (2, FAILED_DOWNLOAD)
    // rust: ]
    // rust: );
}

a_pack_that_does_not_load_fails_its_reload :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Allowed);
    // rust: sp.push(1, "http://a/p.zip", None);
    // rust: let mut reloads = Vec::new();
    // rust: settle(&mut sp, &mut |r| ok(r[0].id), &mut |p| {
    // rust: reloads.push(p.to_vec());
    // rust: reloads.len() > 1
    // rust: });
    // rust: assert_eq!(
    // rust: sp.take_replies(),
    // rust: [(1, ACCEPTED), (1, DOWNLOADED), (1, FAILED_RELOAD)]
    // rust: );
        // The recovery reload has none of the server's packs.
    // rust: assert_eq!(reloads[1], []);
}

popping_and_disconnecting_unload_the_packs :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Allowed);
    // rust: sp.push(1, "http://a/p.zip", None);
    // rust: sp.push(2, "http://a/q.zip", None);
    // rust: let last = std::cell::RefCell::new(Vec::new());
    // rust: let mut reload = |p: &[(u128, PathBuf)]| {
    // rust: *last.borrow_mut() = p.to_vec();
    // rust: true
}
    // rust: settle(
    // rust: &mut sp,
    // rust: &mut |r| Batch {
    // rust: downloaded: r
    // rust: .iter()
    // rust: .map(|q| (q.id, PathBuf::from(format!("/p/{}", q.id))))
    // rust: .collect(),
    // rust: failed: vec![],
    // rust: },
    // rust: &mut reload,
    // rust: );
    // rust: sp.take_replies();
    // rust: sp.pop(1);
    // rust: settle(&mut sp, &mut |_| unreachable!(), &mut reload);
        // Callbacks.onSuccess reports every pack the reload loaded, again.
    // rust: assert_eq!(sp.take_replies(), [(2, SUCCESSFULLY_LOADED)]);
    // rust: assert_eq!(*last.borrow(), [(2, PathBuf::from("/p/2"))]);
    // rust: sp.disconnect();
    // rust: settle(&mut sp, &mut |_| unreachable!(), &mut reload);
    // rust: assert!(last.borrow().is_empty());
    // rust: assert!(sp.packs.is_empty());
}

a_pushed_id_replaces_its_pack :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Allowed);
    // rust: sp.push(1, "http://a/old.zip", None);
    // rust: sp.push(1, "http://a/new.zip", None);
    // rust: let mut urls = Vec::new();
    // rust: settle(
    // rust: &mut sp,
    // rust: &mut |r| {
    // rust: urls.extend(r.iter().map(|q| q.url.clone()));
    // rust: ok(1)
    // rust: },
    // rust: &mut |_| true,
    // rust: );
    // rust: assert_eq!(urls, ["http://a/new.zip"]);
}

replacing_an_active_pack_settles_after_one_reload :: proc() {
}
    // rust: let mut sp = ServerPacks::default();
    // rust: sp.connect(Prompt::Allowed);
    // rust: sp.push(1, "http://a/old.zip", None);
    // rust: settle(&mut sp, &mut |r| ok(r[0].id), &mut |_| true);
        // The server pushes the same id again while the first is active.
    // rust: sp.push(1, "http://a/new.zip", None);
    // rust: let mut reloads = Vec::new();
    // rust: settle(&mut sp, &mut |r| ok(r[0].id), &mut |p| {
    // rust: reloads.push(p.to_vec());
    // rust: true
    // rust: });
    // rust: assert_eq!(reloads, [[(1, PathBuf::from("/p/1"))]]);
}

urls_and_hashes_are_read_as_vanilla_reads_them :: proc() {
}
    // rust: assert!(valid_url("https://example.com/p.zip"));
    // rust: assert!(valid_url("HTTP://example.com/p.zip"));
    // rust: assert!(!valid_url("ftp://example.com/p.zip"));
    // rust: assert!(!valid_url("example.com/p.zip"));
    // rust: let sha1 = "0123456789ABCDEF0123456789abcdef01234567";
    // rust: assert_eq!(parse_sha1(sha1), Some(sha1.to_ascii_lowercase()));
    // rust: assert_eq!(parse_sha1("abc"), None);
}
}
