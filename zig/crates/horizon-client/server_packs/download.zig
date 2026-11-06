//! Transpiled from Horizon Rust crate
//! Module: horizon-client_download
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Server pack downloads into the game directory's `downloads/` cache, as
//! vanilla keeps it (`DownloadQueue`, `HttpUtil.downloadFile`,
//! `DownloadCacheCleaner`): `downloads/<pack id>/<SHA-1 of the file>`, one
//! batch at a time on a thread of its own, every download logged in
//! `downloads/log.json`, and the cache cut to its 20 newest files on start.
// use super::{Batch, Request};
// use sha1::{Digest, Sha1};
// use std::{
    // rust: fs,
    // rust: io::{self, Read, Write},
    // rust: path::{Path, PathBuf},
    // rust: sync::mpsc::{Receiver, Sender, channel},
    // rust: time::SystemTime,
}

/// `DownloadedPackSource`'s MAX_PACK_SIZE_BYTES (250 MiB).
pub const MAX_SIZE: u64 = 262_144_000;
/// `DownloadQueue.MAX_KEPT_PACKS`.
pub const MAX_KEPT: usize = 20;
/// Longest wait for a connection, and for any one read from the server. The
/// queue runs batches on one thread, so a server that accepts the connection
/// and then goes silent would otherwise hold the pack screen forever.
pub const NET_TIMEOUT: std::time::Duration = std::time::Duration::from_secs(30);

/// `createDownloadHeaders`: who is downloading, with which game.
pub fn headers(name: []const u8, uuid: u128) V {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_core::version::{RESOURCE_PACK_FORMAT, VANILLA_VERSION, VERSION_ID};
    // rust: vec![
    // rust: ("X-Minecraft-Username", name.to_owned()),
    // rust: ("X-Minecraft-UUID", format!("{uuid:032x}")),
    // rust: ("X-Minecraft-Version", VANILLA_VERSION.to_owned()),
    // rust: ("X-Minecraft-Version-ID", VERSION_ID.to_owned()),
    // rust: (
    // rust: "X-Minecraft-Pack-Format",
    // rust: format!("{}.{}", RESOURCE_PACK_FORMAT.0, RESOURCE_PACK_FORMAT.1),
    // rust: ),
    // rust: ("User-Agent", format!("Minecraft Java/{VANILLA_VERSION}")),
    // rust: ]
}

/// `HttpUtil.DownloadProgressListener`, on the channel a batch was given.
pub const Progress = enum {
    /// `requestStart`: the batch's next request begins.
    RequestStart,
    /// `downloadStart`: the response came, with its Content-Length if it
    /// said one.
    DownloadStart(Option<u64>),
    /// `downloadedBytes`: what this request has written so far.
    Bytes(u64),
    /// `requestFinished`: whether it succeeded.
    RequestFinished(bool),
};

    // rust: type Job = (Vec<Request>, Vec<(&'static str, String)>, Sender<Progress>);

/// `DownloadQueue`: batches download in order, on one thread.
pub const Queue = struct {
    jobs: Sender<Job>,
    done: Receiver<Batch>,
};
    // rust: impl Queue {
pub fn open(dir: PathBuf) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::create_dir_all(&dir)?;
    // rust: vacuum(&dir, MAX_KEPT);
    // rust: let (jobs, todo) = channel::<Job>();
    // rust: let (finished, done) = channel();
    // rust: std::thread::Builder::new()
    // rust: .name("download-queue".into())
    // rust: .spawn(move || {
    // rust: for (requests, headers, progress) in todo {
    // rust: if finished
    // rust: .send(run(&dir, &requests, &headers, &progress))
    // rust: .is_err()
    // rust: {
    // rust: break;
}
}
    // rust: })?;
    // rust: Ok(Self { jobs, done })
}
    // rust: pub fn download(
    // rust: &self,
    // rust: requests: Vec<Request>,
    // rust: headers: Vec<(&'static str, String)>,
    // rust: progress: Sender<Progress>,
    // rust: ) {
    // rust: let _ = self.jobs.send((requests, headers, progress));
}
    /// The batches finished since the last call.
pub fn finished(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.done.try_iter().collect()
}
}

/// `DownloadQueue.runDownload`: each pack into `<dir>/<id>/`, logged.
    // rust: fn run(
    // rust: dir: &Path,
    // rust: requests: &[Request],
    // rust: headers: &[(&'static str, String)],
    // rust: progress: &Sender<Progress>,
    // rust: ) -> Batch {
    // rust: let mut batch = Batch::default();
    // rust: for request in requests {
    // rust: let id = horizon_protocol::crypto::uuid_string(request.id);
    // rust: let _ = progress.send(Progress::RequestStart);
    // rust: let result = download_file(&dir.join(&id), request, headers, MAX_SIZE, progress);
    // rust: let _ = progress.send(Progress::RequestFinished(result.is_ok()));
        // DownloadQueue.LogEntry, its fields in the codec's order.
    // rust: let mut entry = vec![
    // rust: ("id", serde_json::Value::from(id)),
    // rust: ("url", request.url.as_str().into()),
    // rust: (
    // rust: "time",
    // rust: chrono::Utc::now()
    // rust: .to_rfc3339_opts(chrono::SecondsFormat::AutoSi, true)
    // rust: .into(),
    // rust: ),
    // rust: ];
    // rust: if let Some(sha1) = &request.sha1 {
    // rust: entry.push(("hash", sha1.as_str().into()));
}
    // rust: entry.push(match &result {
    // rust: Ok(path) => match fs::metadata(path) {
    // rust: Ok(meta) => {
    // rust: let name = path.strip_prefix(dir).unwrap_or(path);
    // rust: let name = name.to_string_lossy().replace('\\', "/");
    // rust: (
    // rust: "file",
    // rust: serde_json::json!({"name": name, "size": meta.len()}),
    // rust: )
}
    // rust: Err(_) => ("error", "no_access".into()),
    // rust: },
    // rust: Err(e) => {
    // rust: log::error!("Horizon: failed to download {}: {e}", request.url);
    // rust: ("error", "download_failed".into())
}
    // rust: });
    // rust: if let Err(e) = append_log(&dir.join("log.json"), &entry) {
    // rust: log::error!("Horizon: failed to log download of {}: {e}", request.url);
}
    // rust: match result {
    // rust: Ok(path) => batch.downloaded.push((request.id, path)),
    // rust: Err(_) => batch.failed.push(request.id),
}
}
    // rust: batch
}

/// `JsonEventLog.write`: one JSON object a line, as Gson writes it (with
/// its HTML escaping).
pub fn append_log(path: *Path, entry: *[([]const u8, serde_json: :Value) void {
}
    // rust: let fields: Vec<String> = entry
    // rust: .iter()
    // rust: .map(|(k, v)| format!("{}:{v}", serde_json::Value::from(*k)))
    // rust: .collect();
    // rust: let mut line = String::new();
    // rust: for c in format!("{{{}}}", fields.join(",")).chars() {
    // rust: match c {
    // rust: '<' | '>' | '&' | '=' | '\'' => line.push_str(&format!("\\u{:04x}", c as u32)),
    // rust: c => line.push(c),
}
}
    // rust: line.push('\n');
    // rust: fs::OpenOptions::new()
    // rust: .create(true)
    // rust: .append(true)
    // rust: .open(path)?
    // rust: .write_all(line.as_bytes())
}

pub fn sha1_of(path: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut hasher = Sha1::new();
    // rust: io::copy(&mut fs::File::open(path)?, &mut hasher)?;
    // rust: Ok(hex(&hasher.finalize()))
}
pub fn hex(bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bytes.iter().map(|b| format!("{b:02x}")).collect()
}
/// `checkExistingFile`: the file is there with that hash.
pub fn matches(path: *Path, sha1: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: path.exists() && sha1_of(path).is_ok_and(|actual| actual == sha1)
}
/// `updateModificationTime`: used now, so the cleaner keeps it longest.
pub fn touch(path: *Path) void {
}
    // rust: let _ = fs::File::options()
    // rust: .append(true)
    // rust: .open(path)
    // rust: .and_then(|f| f.set_modified(SystemTime::now()));
}

/// `HttpUtil.downloadFile`: into `<dir>/<SHA-1>`. With a hash the cached file
/// is used when it matches, and a download that does not is an error;
/// without one the file is named after the hash of what came.
    // rust: pub fn download_file(
    // rust: dir: &Path,
    // rust: request: &Request,
    // rust: headers: &[(&'static str, String)],
    // rust: max_size: u64,
    // rust: progress: &Sender<Progress>,
    // rust: ) -> Result<PathBuf, String> {
    // rust: download_file_within(dir, request, headers, max_size, progress, NET_TIMEOUT)
}
/// `download_file` with the connect and read timeout given.
    // rust: fn download_file_within(
    // rust: dir: &Path,
    // rust: request: &Request,
    // rust: headers: &[(&'static str, String)],
    // rust: max_size: u64,
    // rust: progress: &Sender<Progress>,
    // rust: timeout: std::time::Duration,
    // rust: ) -> Result<PathBuf, String> {
    // rust: let target = request.sha1.as_ref().map(|sha1| dir.join(sha1));
    // rust: if let (Some(target), Some(sha1)) = (&target, &request.sha1) {
    // rust: if matches(target, sha1) {
    // rust: log::info!("Horizon: returning cached file since actual hash matches requested");
    // rust: touch(target);
    // rust: return Ok(target.clone());
}
    // rust: if target.exists() {
    // rust: log::warn!(
    // rust: "Horizon: existing file {} not found or had mismatched hash",
    // rust: target.display()
    // rust: );
}
    // rust: fs::remove_file(target)
    // rust: .or_else(|e| {
    // rust: if e.kind() == io::ErrorKind::NotFound {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(e)
}
    // rust: })
    // rust: .map_err(|e| format!("Failed to remove existing file {}: {e}", target.display()))?;
}
    // rust: let mut call = ureq::AgentBuilder::new()
    // rust: .timeout_connect(timeout)
    // rust: .timeout_read(timeout)
    // rust: .build()
    // rust: .get(&request.url);
    // rust: for (name, value) in headers {
    // rust: call = call.set(name, value);
}
    // rust: let response = call.call().map_err(|e| e.to_string())?;
    // rust: let size = response
    // rust: .header("Content-Length")
    // rust: .and_then(|v| v.trim().parse::<u64>().ok());
    // rust: fs::create_dir_all(dir).map_err(|e| e.to_string())?;
    // rust: let _ = progress.send(Progress::DownloadStart(size));
    // rust: if let Some(size) = size
    // rust: && size > max_size
    // rust: {
    // rust: return Err(format!(
    // rust: "Filesize is bigger than maximum allowed (file is {size}, limit is {max_size})"
    // rust: ));
}
    // rust: let mut input = response.into_reader();
    // rust: let mut report = |written: u64| {
    // rust: let _ = progress.send(Progress::Bytes(written));
}
    // rust: match (&target, &request.sha1) {
    // rust: (Some(target), Some(sha1)) => {
    // rust: let actual = save_hashed(&mut input, target, max_size, &mut report)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if &actual != sha1 {
    // rust: return Err(format!(
    // rust: "Hash of downloaded file ({actual}) did not match requested ({sha1})"
    // rust: ));
}
    // rust: Ok(target.clone())
}
    // rust: _ => {
    // rust: let tmp = dir.join(format!("download{:016x}.tmp", rand_suffix()));
    // rust: let result = save_hashed(&mut input, &tmp, max_size, &mut report).and_then(|actual| {
    // rust: let path = dir.join(&actual);
    // rust: if matches(&path, &actual) {
    // rust: touch(&path);
    // rust: } else {
    // rust: fs::rename(&tmp, &path)?;
}
    // rust: Ok(path)
    // rust: });
    // rust: let _ = fs::remove_file(&tmp);
    // rust: result.map_err(|e| e.to_string())
}
}
}
pub fn rand_suffix() u {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::hash::{BuildHasher, RandomState};
    // rust: RandomState::new().hash_one(std::time::Instant::now())
}
/// `downloadAndHash`: write what comes, at most `max_size` bytes.
    // rust: fn save_hashed(
    // rust: input: &mut dyn Read,
    // rust: path: &Path,
    // rust: max_size: u64,
    // rust: progress: &mut dyn FnMut(u64),
    // rust: ) -> io::Result<String> {
    // rust: let mut out = fs::File::create(path)?;
    // rust: let mut hasher = Sha1::new();
    // rust: let mut buffer = [0u8; 8196];
    // rust: let mut read_so_far = 0u64;
    // rust: loop {
    // rust: let n = input.read(&mut buffer)?;
    // rust: if n == 0 {
    // rust: break;
}
    // rust: read_so_far += n as u64;
    // rust: progress(read_so_far);
    // rust: if read_so_far > max_size {
    // rust: return Err(io::Error::other(format!(
    // rust: "Filesize was bigger than maximum allowed (got >= {read_so_far}, limit was {max_size})"
    // rust: )));
}
    // rust: out.write_all(&buffer[..n])?;
    // rust: hasher.update(&buffer[..n]);
}
    // rust: Ok(hex(&hasher.finalize()))
}

/// `DownloadCacheCleaner.vacuumCacheDir`: keep the `max_files` files most
/// worth keeping (in the pack folders: the newest, and one per pack before a
/// second of any), then drop the folders left empty.
pub fn vacuum(dir: *Path, max_files: usize) void {
}
    // rust: let mut files = Vec::new();
    // rust: let mut stack = vec![dir.to_path_buf()];
    // rust: while let Some(d) = stack.pop() {
    // rust: let Ok(entries) = fs::read_dir(&d) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
    // rust: let Ok(meta) = e.metadata() else { continue };
    // rust: if meta.is_dir() {
    // rust: stack.push(path);
    // rust: } else if meta.is_file() && path.parent() != Some(dir) {
    // rust: let time = meta.modified().unwrap_or(SystemTime::UNIX_EPOCH);
    // rust: files.push((path, time));
}
}
}
    // rust: let Some(remove) = files.len().checked_sub(max_files).filter(|n| *n > 0) else {
    // rust: return;
}
    // Newest first, then each file's rank in its folder (0 for a folder's
    // newest), reversed, and stably sorted by rank, highest first.
    // rust: files.sort_by_key(|f| std::cmp::Reverse(f.1));
    // rust: let mut counts = std::collections::HashMap::<PathBuf, usize>::new();
    // rust: let mut ranked: Vec<(PathBuf, usize)> = files
    // rust: .into_iter()
    // rust: .map(|(path, _)| {
    // rust: let count = counts
    // rust: .entry(path.parent().unwrap_or(dir).to_path_buf())
    // rust: .or_default();
    // rust: let rank = *count;
    // rust: *count += 1;
    // rust: (path, rank)
    // rust: })
    // rust: .collect();
    // rust: ranked.reverse();
    // rust: ranked.sort_by_key(|f| std::cmp::Reverse(f.1));
    // rust: let mut emptied = std::collections::HashSet::new();
    // rust: for (path, rank) in ranked.into_iter().take(remove) {
    // rust: match fs::remove_file(&path) {
    // rust: Ok(()) if rank == 0 => {
    // rust: emptied.insert(path.parent().unwrap_or(dir).to_path_buf());
}
    // rust: Ok(()) => {}
    // rust: Err(e) => log::warn!(
    // rust: "Horizon: failed to delete cache file {}: {e}",
    // rust: path.display()
    // rust: ),
}
}
    // rust: emptied.remove(dir);
    // rust: for d in emptied {
    // rust: let _ = fs::remove_dir(d);
}
}

    // rust: mod tests {
//     use super::*;
//     use std::net::TcpListener;

    /// A one-shot HTTP server answering `status` with `body`; the request it got.
pub fn serve(status: []const u8, body: std.ArrayList(u8)) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let url = format!("http://{}/pack.zip", listener.local_addr().unwrap());
    // rust: let status = status.to_owned();
    // rust: let handle = std::thread::spawn(move || {
    // rust: let (mut stream, _) = listener.accept().unwrap();
    // rust: let mut request = Vec::new();
    // rust: let mut buf = [0u8; 1024];
    // rust: while !request.ends_with(b"\r\n\r\n") {
    // rust: let n = stream.read(&mut buf).unwrap();
    // rust: request.extend_from_slice(&buf[..n]);
}
    // rust: let head = format!(
    // rust: "HTTP/1.1 {status}\r\nContent-Length: {}\r\nConnection: close\r\n\r\n",
    // rust: body.len()
    // rust: );
    // rust: stream.write_all(head.as_bytes()).unwrap();
    // rust: stream.write_all(&body).unwrap();
    // rust: String::from_utf8_lossy(&request).into_owned()
    // rust: });
    // rust: (url, handle)
}
pub fn sha1(bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: hex(&Sha1::digest(bytes))
}
pub fn scratch() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-packs-{:016x}", rand_suffix()));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

pub fn a_pack_lands_under_its_hash_and_is_reused_from_the_cache() void {
}
    // rust: let dir = scratch();
    // rust: let body = b"PK pack".to_vec();
    // rust: let (url, server) = serve("200 OK", body.clone());
    // rust: let request = Request {
    // rust: id: 7,
    // rust: url,
    // rust: sha1: Some(sha1(&body)),
}
    // rust: let path = download_file(
    // rust: &dir,
    // rust: &request,
    // rust: &headers("Alex", 0xab),
    // rust: MAX_SIZE,
    // rust: &channel().0,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(path, dir.join(sha1(&body)));
    // rust: assert_eq!(fs::read(&path).unwrap(), body);
    // rust: let sent = server.join().unwrap();
    // rust: assert!(sent.contains("X-Minecraft-Username: Alex"), "{sent}");
    // rust: assert!(sent.contains("X-Minecraft-Pack-Format: 97.1"), "{sent}");
        // Cached: no server this time.
    // rust: let cached = Request {
    // rust: url: "http://127.0.0.1:9/gone.zip".into(),
    // rust: ..request
}
    // rust: assert_eq!(
    // rust: download_file(&dir, &cached, &[], MAX_SIZE, &channel().0).unwrap(),
    // rust: path
    // rust: );
    // rust: fs::remove_dir_all(dir).unwrap();
}

pub fn a_wrong_hash_a_dead_url_and_a_large_pack_fail() void {
}
    // rust: let dir = scratch();
    // rust: let (url, server) = serve("200 OK", b"other bytes".to_vec());
    // rust: let wrong = Request {
    // rust: id: 1,
    // rust: url,
    // rust: sha1: Some("0".repeat(40)),
}
    // rust: let err = download_file(&dir, &wrong, &[], MAX_SIZE, &channel().0).unwrap_err();
    // rust: assert!(err.contains("did not match requested"), "{err}");
    // rust: server.join().unwrap();
    // rust: let dead = Request {
    // rust: id: 2,
    // rust: url: "http://127.0.0.1:9/pack.zip".into(),
    // rust: sha1: None,
}
    // rust: assert!(download_file(&dir.join("dead"), &dead, &[], MAX_SIZE, &channel().0).is_err());
    // rust: assert!(!dir.join("dead").exists());
    // rust: let (url, server) = serve("200 OK", vec![0; 100]);
    // rust: let large = Request {
    // rust: id: 3,
    // rust: url,
    // rust: sha1: None,
}
    // rust: let err = download_file(&dir, &large, &[], 10, &channel().0).unwrap_err();
    // rust: assert!(err.contains("bigger than maximum"), "{err}");
    // rust: let _ = server.join();
    // rust: let (url, server) = serve("404 Not Found", Vec::new());
    // rust: let missing = Request {
    // rust: id: 4,
    // rust: url,
    // rust: sha1: None,
}
    // rust: assert!(download_file(&dir, &missing, &[], MAX_SIZE, &channel().0).is_err());
    // rust: server.join().unwrap();
    // rust: fs::remove_dir_all(dir).unwrap();
}

pub fn a_server_that_goes_silent_fails_the_download() void {
}
    // rust: let dir = scratch();
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let url = format!("http://{}/pack.zip", listener.local_addr().unwrap());
    // rust: let (release, hold) = channel::<()>();
    // rust: let server = std::thread::spawn(move || {
            // Accept, then answer nothing until the test is done.
    // rust: let (_stream, _) = listener.accept().unwrap();
    // rust: let _ = hold.recv();
    // rust: });
    // rust: let request = Request {
    // rust: id: 9,
    // rust: url,
    // rust: sha1: None,
}
    // rust: let started = std::time::Instant::now();
    // rust: let result = download_file_within(
    // rust: &dir,
    // rust: &request,
    // rust: &[],
    // rust: MAX_SIZE,
    // rust: &channel().0,
    // rust: std::time::Duration::from_millis(300),
    // rust: );
    // rust: assert!(result.is_err());
    // rust: assert!(started.elapsed() < std::time::Duration::from_secs(10));
    // rust: drop(release);
    // rust: server.join().unwrap();
    // rust: fs::remove_dir_all(dir).unwrap();
}

pub fn the_queue_logs_each_download() void {
}
    // rust: let dir = scratch();
    // rust: let (url, server) = serve("200 OK", b"zip".to_vec());
    // rust: let queue = Queue::open(dir.clone()).unwrap();
    // rust: let (progress, events) = channel();
    // rust: let id = 0x5b2c_7a4e_1f3d_4c8b_9a6e_2d4f_8b1c_3e5a;
    // rust: queue.download(
    // rust: vec![Request {
    // rust: id,
    // rust: url,
    // rust: sha1: None,
    // rust: }],
    // rust: Vec::new(),
    // rust: progress,
    // rust: );
    // rust: let batch = loop {
    // rust: if let Some(b) = queue.finished().pop() {
    // rust: break b;
}
    // rust: std::thread::sleep(std::time::Duration::from_millis(10));
}
    // rust: server.join().unwrap();
    // rust: let file = dir
    // rust: .join("5b2c7a4e-1f3d-4c8b-9a6e-2d4f8b1c3e5a")
    // rust: .join(sha1(b"zip"));
    // rust: assert_eq!(batch.downloaded, [(id, file)]);
        // HttpUtil.downloadFile's listener calls, in order.
    // rust: assert_eq!(
    // rust: events.iter().collect::<Vec<_>>(),
    // rust: [
    // rust: Progress::RequestStart,
    // rust: Progress::DownloadStart(Some(3)),
    // rust: Progress::Bytes(3),
    // rust: Progress::RequestFinished(true),
    // rust: ]
    // rust: );
    // rust: let log = fs::read_to_string(dir.join("log.json")).unwrap();
    // rust: let entry: serde_json::Value = serde_json::from_str(log.trim()).unwrap();
    // rust: assert_eq!(entry["id"], "5b2c7a4e-1f3d-4c8b-9a6e-2d4f8b1c3e5a");
    // rust: assert_eq!(entry["file"]["size"], 3);
    // rust: fs::remove_dir_all(dir).unwrap();
}

pub fn the_cleaner_keeps_the_newest_file_of_each_pack_longest() void {
}
    // rust: let dir = scratch();
    // rust: let at = |secs| SystemTime::UNIX_EPOCH + std::time::Duration::from_secs(secs);
    // rust: for (pack, file, time) in [
    // rust: ("a", "1", 10),
    // rust: ("a", "2", 20),
    // rust: ("a", "3", 30),
    // rust: ("b", "1", 5),
    // rust: ] {
    // rust: fs::create_dir_all(dir.join(pack)).unwrap();
    // rust: let path = dir.join(pack).join(file);
    // rust: fs::write(&path, b"x").unwrap();
    // rust: fs::File::options()
    // rust: .append(true)
    // rust: .open(&path)
    // rust: .unwrap()
    // rust: .set_modified(at(time))
    // rust: .unwrap();
}
    // rust: fs::write(dir.join("log.json"), b"").unwrap();
    // rust: vacuum(&dir, 2);
    // rust: assert!(dir.join("a/3").exists() && dir.join("b/1").exists());
    // rust: assert!(!dir.join("a/1").exists() && !dir.join("a/2").exists());
    // rust: assert!(dir.join("log.json").exists());
    // rust: fs::remove_dir_all(dir).unwrap();
}
}
