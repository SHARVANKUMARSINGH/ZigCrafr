//! Transpiled from Horizon Rust crate
package horizon_prepare_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Prepares Horizon's resources from the player's own Minecraft Java Edition: imports the pinned
// client jar, libraries and version JSON from their official launcher install and the server
// jar they downloaded (each checked against research-lock.json), copies the game's assets and
// data, and runs the vanilla exporters (mods/horizon/src/test/java/dev/horizonlab/parity), which
// call Mojang's own code and so stay Java. The result, `.local/horizon-client/<version>` with its
// `horizon-resources.json` manifest, is what the game's `--resources` and the launcher read.
//
// This is the Rust port of the Python preparer (tools/prepare_native_client.py and the helpers
// it imported); its files are byte for byte the ones the script wrote (tools/compare_prepare.py
// checks it), so the manifest's `schema` is unchanged. Unchanged steps are skipped on the next
// run, keyed by the sha256 of their inputs and outputs recorded in the manifest, as before.

    // rust: pub mod artifacts;
    // rust: mod check;
    // rust: pub mod exporters;
    // rust: mod files;
    // rust: mod inventory;
    // rust: pub mod java;
    // rust: pub mod launch_api;
    // rust: mod pool;
    // rust: pub mod pyjson;
    // rust: mod sounds;
    // rust: mod survival;
    // rust: mod worker;

    // rust: pub use check::{check, missing_extras, STAMP};
    // rust: pub use files::clone_or_copy;
    // rust: pub use sounds::{add_assets, fonts, languages, packs, panorama, sounds, BUILT_IN_PACKS};

// use pyjson::Value;
// use sha2::Digest;
// use std::fs;
// use std::io::Read;
// use std::path::{Path, PathBuf};
// use std::sync::Mutex;
// use std::time::Instant;

// Where progress lines go: the terminal for the binary, the log pane for the launcher.
    // rust: pub type Log<'a> = &'a dyn Fn(&str);

// Where the fraction done goes (`--progress json`), from 0 to 1.
    // rust: pub type Progress<'a> = &'a dyn Fn(f32);

// The stages of `steps`, each opened by `Run::stage`: what the fraction counts.
STAGES :: 18

// The manifest's `schema`: the prepared files' layout, which the launcher compares.
SCHEMA :: 7

// What this preparer makes. The launcher copies a prepared version's resources to a newly installed
// version whose preparer has the same number (and the same pinned jars), so a release that changes
// this crate without changing its output asks nobody to prepare again. Bump it, and append the new
// digest to output-versions.txt, when the prepared files change: CI prepares with every change to
// the preparer and fails when the output is not the one output-versions.txt gives this number
// (`python3 tools/prepare_output.py check`). The launcher reads this line from the version
// folder's sources: keep it on one line, as it is.
OUTPUT_VERSION :: 3

// Digest of this crate's sources (build.rs): the launcher prepares a version in-process when
// that version ships these same sources, and runs the version's own binary otherwise.
SOURCES_SHA256 :: env!("HORIZON_PREPARE_SOURCES_SHA256")

// `SOURCES_SHA256` of the sources in `crate_dir` (a version folder's crates/horizon-prepare),
// computed as build.rs computes it; None when the folder has none.
sources_sha256 :: proc(crate_dir: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut files = Vec::new();
    // rust: for name in ["Cargo.toml", "build.rs"] {
    // rust: files.push((name.to_string(), fs::read(crate_dir.join(name)).ok()?));
}
    // rust: let mut sources: Vec<String> = fs::read_dir(crate_dir.join("src"))
    // rust: .ok()?
    // rust: .filter_map(Result::ok)
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
    // rust: .filter(|n| n.ends_with(".rs"))
    // rust: .collect();
    // rust: sources.sort();
    // rust: for name in sources {
    // rust: let data = fs::read(crate_dir.join("src").join(&name)).ok()?;
    // rust: files.push((format!("src/{name}"), data));
}
    // rust: let mut hash = sha2::Sha256::new();
    // rust: for (name, data) in files {
        // Line endings as checked out: a Windows checkout's CRLF is the same source.
    // rust: let data: Vec<u8> = data.into_iter().filter(|b| *b != b'\r').collect();
    // rust: hash.update(format!("{name}\0{}\0", data.len()));
    // rust: hash.update(&data);
}
    // rust: Some(hex(&hash.finalize()))
}

Options :: struct {
    // The version folder (a release folder, or a checkout): research-lock.json, the exporters'
    // Java sources, optional precompiled `exporters/`, and `.local/` where everything is written.
    root: PathBuf,
    // Import the pinned game files from the player's own copy first (`--prepare`).
    import: bool,
    // The official launcher's game directory (`--minecraft-dir`, else HORIZON_MINECRAFT_DIR,
    // else the launcher's own).
    minecraft_dir: Maybe(PathBuf),
    // The pinned server jar the player downloaded (`--server-jar`, else HORIZON_SERVER_JAR).
    server_jar: Maybe(PathBuf),
    // The Java runtime to try after JAVA_HOME and the PATH (the launcher's pick, e.g. Minecraft's
    // own Java it downloaded from Mojang).
    java_home: Maybe(PathBuf),
    // Files named one by one instead of found in `minecraft_dir` (`--version-json`,
    // `--client-jar`, `--libraries-dir`, `--assets-dir`).
    inputs: artifacts::Inputs,
    // Where the resources go (`--output`); None for `root`'s `.local/horizon-client/<version>`.
    // The exporters' scratch files stay in `root`'s `.local/` either way.
    output: Maybe(PathBuf),
}

// The prepared resources' folder: `output`, else `root`'s `.local/horizon-client/<version>`.
resources_dir :: proc(root: ^Path, version: string, output: Maybe(^Path)) -> P {
    // Ported from Horizon
    return {}
}
    // rust: match output {
    // rust: Some(output) => output.to_path_buf(),
    // rust: None => root.join(".local/horizon-client").join(version),
}
}

    // rust: pub(crate) fn hex(bytes: &[u8]) -> String {
    // rust: bytes.iter().map(|b| format!("{b:02x}")).collect()
}

    // rust: pub(crate) fn sha256_hex(data: &[u8]) -> String {
    // rust: hex(&sha2::Sha256::digest(data))
}

    // rust: pub(crate) fn digest(path: &Path, algorithm: &str) -> Result<String, String> {
    // rust: fn stream<D: Digest>(mut file: fs::File) -> std::io::Result<String> {
    // rust: let mut hash = D::new();
    // rust: let mut buffer = vec![0; 1 << 20];
    // rust: loop {
    // rust: let n = file.read(&mut buffer)?;
    // rust: if n == 0 {
    // rust: return Ok(hex(&hash.finalize()));
}
    // rust: hash.update(&buffer[..n]);
}
}
    // rust: let file = fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: match algorithm {
    // rust: "sha1" => stream::<sha1::Sha1>(file),
    // rust: _ => stream::<sha2::Sha256>(file),
}
    // rust: .map_err(|e| format!("{}: {e}", path.display()))
}

read :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fs::read(path).map_err(|e| format!("{}: {e}", path.display()))
}

write :: proc(path: ^Path, data: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fs::write(path, data).map_err(|e| format!("{}: {e}", path.display()))
}

mkdir :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fs::create_dir_all(path).map_err(|e| format!("{}: {e}", path.display()))
}

// The lock file each preparation holds in the folders it writes (`LOCK`).
LOCK :: ".horizon-prepare.lock"

// One preparation at a time per folder: two launchers or instances preparing into one `--output`,
// or sharing `root`'s `.local`, would interleave their writes. A second one waits, saying so;
// the lock goes with the returned file, so with the process too.
    // rust: pub(crate) fn hold_lock(dir: &Path, log: Log) -> Result<fs::File, String> {
    // rust: mkdir(dir)?;
    // rust: let path = dir.join(LOCK);
    // rust: let error = |e: std::io::Error| format!("{}: {e}", path.display());
    // rust: let file = fs::OpenOptions::new()
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .write(true)
    // rust: .open(&path)
    // rust: .map_err(error)?;
    // rust: match file.try_lock() {
    // rust: Ok(()) => {}
    // rust: Err(fs::TryLockError::WouldBlock) => {
    // rust: log(&format!(
    // rust: "Waiting for another horizon-prepare to finish with {}",
    // rust: dir.display()
    // rust: ));
    // rust: file.lock().map_err(error)?;
}
    // rust: Err(fs::TryLockError::Error(e)) => return Err(error(e)),
}
    // rust: Ok(file)
}

// Whether two folders are one, through `..`, links and case; a missing folder is created first.
same_dir :: proc(a: ^Path, b: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let real = |dir: &Path| {
    // rust: mkdir(dir)?;
    // rust: fs::canonicalize(dir).map_err(|e| format!("{}: {e}", dir.display()))
}
    // rust: Ok(real(a)? == real(b)?)
}

    // rust: pub(crate) fn read_json(path: &Path) -> Result<Value, String> {
    // rust: let text = String::from_utf8(read(path)?).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: pyjson::loads(&text).map_err(|e| format!("{}: {e}", path.display()))
}

// Whether an exporter's earlier output is still one: a killed JVM can leave
// an empty or half-written file, which an `exists` check alone would trust.
reusable_export :: proc(path: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: path.exists() && read_json(path).is_ok()
}

// Python's `Path.write_text`: text mode, so `\n` is the platform's line ending.
write_text :: proc(path: ^Path, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(windows) {
    // rust: write(path, text.replace('\n', "\r\n").as_bytes())
    // rust: } else {
    // rust: write(path, text.as_bytes())
}
}

// tools/lab.py's `write_json`: indented by two, with a final newline.
    // rust: pub(crate) fn write_json(path: &Path, value: &Value) -> Result<(), String> {
    // rust: mkdir(path.parent().unwrap())?;
    // rust: write_text(path, &(pyjson::dumps(value, &pyjson::INDENT2) + "\n"))
}

// Writes `data` unless the file already holds it, so unchanged files keep their times.
write_if_changed :: proc(target: ^Path, data: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !(target.exists() && read(target)? == data) {
    // rust: mkdir(target.parent().unwrap())?;
    // rust: write(target, data)?;
}
    // rust: Ok(())
}

copy :: proc(from: ^Path, to: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: write(to, &read(from)?)
}

// `" in 12.3 s"`: how long a step took, for the progress lines.
    // rust: pub(crate) fn took(started: Instant) -> String {
    // rust: format!(" in {:.1} s", started.elapsed().as_secs_f64())
}

// `path` relative to `root`, with the platform's separators, as Python's
// `str(path.relative_to(ROOT))` prints it.
    // rust: pub(crate) fn relative_display(path: &Path, root: &Path) -> Result<String, String> {
    // rust: let relative = path
    // rust: .strip_prefix(root)
    // rust: .map_err(|_| format!("{} is outside {}", path.display(), root.display()))?;
    // rust: Ok(relative
    // rust: .components()
    // rust: .map(|c| c.as_os_str().to_string_lossy().into_owned())
    // rust: .collect::<Vec<_>>()
    // rust: .join(std::path::MAIN_SEPARATOR_STR))
}

// Python's `str.splitlines`.
    // rust: pub(crate) fn split_lines(text: &str) -> Vec<&str> {
    // rust: let mut lines = Vec::new();
    // rust: let mut start = 0;
    // rust: let mut chars = text.char_indices().peekable();
    // rust: while let Some((i, c)) = chars.next() {
    // rust: if matches!(
    // rust: c,
    // rust: '\n' | '\r'
    // rust: | '\u{b}'
    // rust: | '\u{c}'
    // rust: | '\u{1c}'
    // rust: | '\u{1d}'
    // rust: | '\u{1e}'
    // rust: | '\u{85}'
    // rust: | '\u{2028}'
    // rust: | '\u{2029}'
    // rust: ) {
    // rust: lines.push(&text[start..i]);
    // rust: let mut end = i + c.len_utf8();
    // rust: if c == '\r' && chars.peek().is_some_and(|(_, n)| *n == '\n') {
    // rust: chars.next();
    // rust: end += 1;
}
    // rust: start = end;
}
}
    // rust: if start < text.len() {
    // rust: lines.push(&text[start..]);
}
    // rust: lines
}

// An open jar. Its clones share the parsed member list (the client jar's is ~10 MB) and read
// at their own offsets, so the threads reading one jar each take a clone, not a new parse.
    // rust: pub(crate) type Jar = zip::ZipArchive<JarFile>;

    // rust: pub(crate) fn open_zip(path: &Path) -> Result<Jar, String> {
    // rust: let file = fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let len = file
    // rust: .metadata()
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?
    // rust: .len();
    // rust: let file = JarFile {
    // rust: file: std::sync::Arc::new(file),
    // rust: position: 0,
    // rust: len,
}
    // rust: zip::ZipArchive::new(file).map_err(|e| format!("{}: {e}", path.display()))
}

// A file read with positioned reads: clones share the handle but not the position.
    // rust: pub(crate) struct JarFile {
    // rust: file: std::sync::Arc<fs::File>,
    // rust: position: u64,
    // rust: len: u64,
}

    // rust: impl Read for JarFile {
read :: proc(self: ^Self, buf: []u8) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let n = std::os::unix::fs::FileExt::read_at(&*self.file, buf, self.position)?;
    // rust: let n = std::os::windows::fs::FileExt::seek_read(&*self.file, buf, self.position)?;
    // rust: self.position += n as u64;
    // rust: Ok(n)
}
}

    // rust: impl std::io::Seek for JarFile {
seek :: proc(self: ^Self, to: std::io::SeekFrom) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let (base, offset) = match to {
    // rust: std::io::SeekFrom::Start(n) => (n, 0),
    // rust: std::io::SeekFrom::End(n) => (self.len, n),
    // rust: std::io::SeekFrom::Current(n) => (self.position, n),
}
    // rust: self.position = base.checked_add_signed(offset).ok_or_else(|| {
    // rust: std::io::Error::new(std::io::ErrorKind::InvalidInput, "seek before the start")
    // rust: })?;
    // rust: Ok(self.position)
}
}

    // rust: pub(crate) fn zip_bytes(archive: &mut Jar, name: &str) -> Result<Vec<u8>, String> {
    // rust: let mut entry = archive.by_name(name).map_err(|e| format!("{name}: {e}"))?;
    // rust: let mut data = Vec::with_capacity(entry.size() as usize);
    // rust: entry
    // rust: .read_to_end(&mut data)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: Ok(data)
}

    // rust: pub(crate) fn zip_text(archive: &mut Jar, name: &str) -> Result<String, String> {
    // rust: String::from_utf8(zip_bytes(archive, name)?).map_err(|e| format!("{name}: {e}"))
}

// The archive's member names in its own order (Python's `namelist`).
zip_names :: proc(archive: ^Jar) -> R {
    // Ported from Horizon
    return {}
}
    // rust: archive
    // rust: .file_names()
    // rust: .map(|name| name.map(|name| name.into_owned()))
    // rust: .collect::<Result<_, _>>()
    // rust: .map_err(|e| e.to_string())
}

// `{"minecraft:<path>": text}` for every `<prefix><path>.json`, sorted by member name
// (the comprehension the Python preparer used for tags, worldgen and damage resources).
json_resources :: proc(archive: ^Jar, prefix: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut names: Vec<String> = zip_names(archive)?
    // rust: .into_iter()
    // rust: .filter(|n| n.starts_with(prefix) && n.ends_with(".json"))
    // rust: .collect();
    // rust: names.sort();
    // rust: let mut resources = Value::Object(Vec::new());
    // rust: for name in names {
    // rust: let text = zip_text(archive, &name)?;
    // rust: let key = format!("minecraft:{}", &name[prefix.len()..name.len() - 5]);
    // rust: resources.insert(&key, Value::Str(text));
}
    // rust: Ok(resources)
}

// A relative member path with no `..` and not absolute (Python's `Path(name)` checks).
member_path :: proc(name: string, what: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = Path::new(name);
    // rust: if path.is_absolute()
    // rust: || name.starts_with('/')
    // rust: || path.components().any(|c| {
    // rust: !matches!(
    // rust: c,
    // rust: std::path::Component::Normal(_) | std::path::Component::CurDir
    // rust: )
    // rust: })
    // rust: {
    // rust: return Err(what.to_string());
}
    // rust: Ok(path.to_path_buf())
}

// `{relative path: sha256}` of exporter sources, in the order given
// (tools/test_rust_parity.py's `source_hashes`).
source_hashes :: proc(root: ^Path, sources: ^[^Path]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut hashes = Value::Object(Vec::new());
    // rust: for source in sources {
    // rust: hashes.insert(
    // rust: &relative_display(source, root)?,
    // rust: Value::Str(digest(source, "sha256")?),
    // rust: );
}
    // rust: Ok(hashes)
}

// A classpath entry list with the platform's separator.
classpath_join :: proc(head: ^Path, rest: ^[PathBuf]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: java::classpath(std::iter::once(head).chain(rest.iter().map(PathBuf::as_path)))
}

Run :: struct {
    root: PathBuf,
    local: PathBuf,
    resources: PathBuf,
    jdk: java::Jdk,
    java_major: i64,
    server: PathBuf,
    client: PathBuf,
    // The server jar and its libraries: the classpath of the server-side exporters.
    server_classpath: string,
    // The client jar and its libraries: the classpath of the client-side exporters.
    client_classpath: string,
    // The compiled exporter classes, or why they didn't compile: one attempt for all lanes.
    bundles: Mutex<Option<Result<PathBuf,
    // The exporter JVMs, which run at the same time: the server's, the client's, and on a
    // machine with cores to spare a second server one for the generator's block behaviour.
    workers: [Mutex<Maybe(worker::Worker)>,
    previous: Value,
    origin: Value,
    // Progress lines from every lane; the caller's thread prints them.
    log: ^'a (dyn Fn(string) + Sync),
    // Tells the caller's thread that a lane opened a stage of `steps`: it counts them.
    stage: ^'a (dyn Fn() + Sync),
    inputs: artifacts::Inputs,
}

PARITY :: "mods/horizon/src/test/java/dev/horizonlab/parity"

    // rust: impl Run<'_> {
    // Opens the next stage of `steps`.
stage :: proc(self: ^Self) {
}
    // rust: (self.stage)();
}

    // The exporter classes, compiled once: a lane that needs them while another compiles waits,
    // and a failed compile fails every lane without compiling again.
bundle :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.bundles
    // rust: .lock()
    // rust: .unwrap()
    // rust: .get_or_insert_with(|| exporters::classes(self))
    // rust: .clone()
}

    // Stops an exporter JVM once its lane needs it no more, to free its memory.
close_worker :: proc(self: ^Self, worker: uint) {
}
    // rust: drop(self.workers[worker].lock().unwrap().take());
}

    // The worker of a classpath's side: 0 for the server's, 1 for the client's.
side :: proc(self: ^Self, classpath: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: usize::from(classpath == self.client_classpath)
}

oracle :: proc(self: ^Self, name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.root.join(PARITY).join(name)
}

previous :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.previous.get(key)
}

same :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.previous(key) == self.origin.get(key)
}

file_hash :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Value::Str(digest(&self.resources.join(name), "sha256")?))
}

    // Every file exists and has the hash the previous manifest recorded under `key`.
files_unchanged :: proc(self: ^Self, key: string, names: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: for name in names {
    // rust: if !self.resources.join(name).exists()
    // rust: || self.previous(key).and_then(|h| h.get(name)) != Some(&self.file_hash(name)?)
    // rust: {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}

log_file :: proc(self: ^Self, path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fs::File::create(path).map_err(|e| format!("{}: {e}", path.display()))
}

    // `java -Xmx<heap> -cp <classes>:<classpath> dev.horizonlab.parity.<main> <args>`, or the
    // same task on exporter JVM `worker`.
    // rust: fn run(
    // rust: &self,
    // rust: worker: usize,
    // rust: heap: &str,
    // rust: classpath: &str,
    // rust: main: &str,
    // rust: args: &[String],
    // rust: log: &fs::File,
    // rust: log_path: &Path,
    // rust: ) -> Result<(), String> {
    // rust: let side = self.side(classpath);
    // rust: let classes = self
    // rust: .bundle()?
    // rust: .join(if side == 1 { "client" } else { "server" });
    // rust: if !matches!(
    // rust: main,
    // rust: "VanillaCommandParseOracle" | "VanillaCreativeTabsExporter"
    // rust: ) && std::env::var_os("HORIZON_PREPARE_ISOLATED").is_none()
    // rust: {
    // rust: let name = ["server", "client", "server-blocks"][worker];
    // rust: let mut worker = self.workers[worker].lock().unwrap();
    // rust: if worker.is_none() {
    // rust: *worker = Some(worker::Worker::new(self, name, &classes, classpath)?);
}
    // rust: return worker.as_mut().unwrap().run(main, args, log_path);
}
    // rust: let separator = if cfg!(windows) { ";" } else { ":" };
    // rust: let mut all = vec![
    // rust: format!("-Xmx{heap}"),
    // rust: "-cp".into(),
    // rust: format!("{}{separator}{classpath}", classes.display()),
    // rust: format!("dev.horizonlab.parity.{main}"),
    // rust: ];
    // rust: all.extend_from_slice(args);
        // Vanilla's code in the exporters logs relative to the working directory (logs/): keep
        // that in the scratch, not where the preparer was started.
    // rust: self.jdk.java(&all, Some(&self.local), log)
}

    // Runs each exporter from the verified shared bundle, with output in
    // the log at `log`: the shape of every exporter step.
    // rust: fn export(
    // rust: &self,
    // rust: what: &str,
    // rust: classpath: &str,
    // rust: classes: &Path,
    // rust: mains: &[&str],
    // rust: heap: &str,
    // rust: args: &[String],
    // rust: log: &Path,
    // rust: ) -> Result<(), String> {
    // rust: let worker = self.side(classpath);
    // rust: self.export_on(worker, what, classpath, classes, mains, heap, args, log)
}

    // `export`, on exporter JVM `worker`.
    // rust: fn export_on(
    // rust: &self,
    // rust: worker: usize,
    // rust: what: &str,
    // rust: classpath: &str,
    // rust: classes: &Path,
    // rust: mains: &[&str],
    // rust: heap: &str,
    // rust: args: &[String],
    // rust: log: &Path,
    // rust: ) -> Result<(), String> {
    // rust: (self.log)(&format!("Exporting {what} ({})", mains.join(", ")));
    // rust: let fail = |e: String| format!("{e} while exporting {what}; see {}", log.display());
        // Compiled first, so the time is this step's (the JVM's start included).
    // rust: self.bundle().map_err(fail)?;
    // rust: let started = Instant::now();
    // rust: mkdir(classes)?;
    // rust: let file = self.log_file(log)?;
    // rust: for main in mains {
    // rust: self.run(worker, heap, classpath, main, args, &file, log)
    // rust: .map_err(fail)?;
}
    // rust: (self.log)(&format!("Exported {what}{}", took(started)));
    // rust: Ok(())
}
}

// Prepares the resources; returns their folder (`resources_dir`).
prepare :: proc(options: ^Options, log: Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: prepare_impl(options, log, &|_| {}, false)
}

// `prepare`, telling `progress` the fraction done as each stage begins, and 1 at the end.
    // rust: pub fn prepare_with_progress(
    // rust: options: &Options,
    // rust: log: Log,
    // rust: progress: Progress,
    // rust: ) -> Result<PathBuf, String> {
    // rust: prepare_impl(options, log, progress, false)
}

// Release build tool: compile and link-check only Horizon's original exporter classes.
compile_exporters :: proc(options: ^Options, log: Log) -> R {
    // Ported from Horizon
    return {}
}
    // rust: prepare_impl(options, log, &|_| {}, true)
}

    // rust: fn prepare_impl(
    // rust: options: &Options,
    // rust: log: Log,
    // rust: progress: Progress,
    // rust: compile_only: bool,
    // rust: ) -> Result<PathBuf, String> {
    // rust: let started = Instant::now();
    // rust: let root = &std::path::absolute(&options.root)
    // rust: .map_err(|e| format!("{}: {e}", options.root.display()))?;
    // rust: let lock = artifacts::Lock::read(root)?;
    // Java first: nothing below can finish without it, and the player should hear it at once.
    // rust: let mut homes: Vec<PathBuf> = options.java_home.iter().cloned().collect();
    // rust: homes.extend(java::minecraft_runtimes(
    // rust: &artifacts::game_files(options.minecraft_dir.as_deref(), &lock.version).runtimes,
    // rust: ));
    // rust: let jdk = java::find_runtime(lock.java_major, &homes)?;
    // The import and the exporters' scratch files.
    // rust: let _local_lock = hold_lock(&root.join(".local"), log)?;
    // rust: let reused = if options.import {
    // rust: artifacts::reuse_verified(root, log)?
    // rust: } else {
    // rust: None
}
    // rust: let (found, client_libraries) = match reused {
    // rust: Some(checked) => checked,
    // rust: None => {
    // rust: if options.import {
    // rust: artifacts::import(
    // rust: root,
    // rust: &lock,
    // rust: options.minecraft_dir.as_deref(),
    // rust: &options.inputs,
    // rust: options.server_jar.as_deref(),
    // rust: log,
    // rust: )?;
}
    // rust: let found = artifacts::verify(&lock)?;
    // rust: let libraries = artifacts::client_libraries(&lock, &found.manifest)?;
    // rust: (found, libraries)
}
}
    // rust: let local = root.join(".local");
    // rust: let resources = match &options.output {
    // rust: Some(output) => {
    // rust: std::path::absolute(output).map_err(|e| format!("{}: {e}", output.display()))?
}
    // rust: None => resources_dir(root, &lock.version, None),
}
    // `--output` may name the `.local` folder itself, whose lock is held already: a second
    // handle on the same lock file would wait for this process forever.
    // rust: let _resources_lock = if same_dir(&resources, &local)? {
    // rust: None
    // rust: } else {
    // rust: Some(hold_lock(&resources, log)?)
}
    // rust: let manifest_path = resources.join("horizon-resources.json");
    // rust: let oracle = root.join(PARITY).join("VanillaHeightmapOracle.java");
    // rust: let jar_hashes = pool::map(&[&found.jars["client"], &found.jars["server"]], |jar| {
    // rust: digest(jar, "sha256")
    // rust: })?;
    // rust: let origin = Value::Object(vec![
    // rust: ("minecraft".into(), Value::Str(lock.version.clone())),
    // rust: ("client_sha256".into(), Value::Str(jar_hashes[0].clone())),
    // rust: ("server_sha256".into(), Value::Str(jar_hashes[1].clone())),
    // rust: (
    // rust: "exporter_sha256".into(),
    // rust: Value::Str(digest(&oracle, "sha256")?),
    // rust: ),
    // rust: ]);
    // rust: let previous = if manifest_path.exists() {
    // rust: read_json(&manifest_path)?
    // rust: } else {
    // rust: Value::Object(Vec::new())
}
    // rust: log(&format!("Checked the game files{}", took(started)));
    // The steps run on lanes of their own; their progress lines and stages come back here,
    // to `log` and `progress`.
    // rust: let (send, lines) = std::sync::mpsc::channel::<Option<String>>();
    // rust: let minecraft = options.minecraft_dir.as_deref();
    // rust: let result = std::thread::scope(|scope| {
    // rust: let work = scope.spawn(move || {
    // rust: let staged = send.clone();
    // rust: let say = move |line: &str| {
    // rust: let _ = send.send(Some(line.to_string()));
}
    // rust: let stage = move || {
    // rust: let _ = staged.send(None);
}
    // rust: let run = Run {
    // rust: root: root.clone(),
    // rust: local,
    // rust: resources: resources.clone(),
    // rust: jdk,
    // rust: java_major: lock.java_major,
    // rust: server: found.jars["server"].clone(),
    // rust: client: found.jars["client"].clone(),
    // rust: server_classpath: classpath_join(&found.jars["server"], &found.libraries),
    // rust: client_classpath: classpath_join(&found.jars["client"], &client_libraries),
    // rust: bundles: Mutex::new(None),
    // rust: workers: [Mutex::new(None), Mutex::new(None), Mutex::new(None)],
    // rust: previous,
    // rust: origin,
    // rust: log: &say,
    // rust: stage: &stage,
    // rust: inputs: options.inputs.clone(),
}
    // rust: if compile_only {
    // rust: return run.bundle();
}
            // Not current until this preparation finishes: --check says so meanwhile, and
            // after a failure.
    // rust: check::remove_stamp(&resources)?;
    // rust: steps(&run, &lock, &oracle, minecraft)?;
    // rust: check::write_stamp(&resources)?;
    // rust: Ok(resources)
    // rust: });
    // rust: relay(lines, log, progress);
    // rust: work.join()
    // rust: .unwrap_or_else(|_| Err("The preparation stopped unexpectedly".into()))
    // rust: })?;
    // rust: if !compile_only {
    // rust: progress(1.0);
    // rust: log(&format!(
    // rust: "Prepared Horizon native-client resources: {}",
    // rust: result.display()
    // rust: ));
}
    // rust: log(&format!("Done{}", took(started)));
    // rust: Ok(result)
}

// Hands the lanes' messages to the caller's `log` and `progress`: a line, or None for a stage
// opened. The fraction done is the stages opened before the one opening.
relay :: proc(messages: std::sync::mpsc::Receiver<Maybe(string)>, log: Log, progress: Progress) {
}
    // rust: let mut stages = 0;
    // rust: for message in messages {
    // rust: match message {
    // rust: Some(line) => log(&line),
    // rust: None => {
    // rust: progress(stages.min(STAGES) as f32 / STAGES as f32);
    // rust: stages += 1;
}
}
}
}

arg :: proc(path: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: path.display().to_string()
}

// The manifest entries a lane works out, by key.
    // rust: type Entries = Vec<(&'static str, Value)>;

// The exporters, the data generator and the asset copy, on four lanes (five with the split
// below) that run at once unless `pool::jobs` is 1:
// the server exporter JVM's steps in a fixed order (they share its state), the client
// exporter JVM's then the command registries' JVM, the data generator's then the creative
// inventory's, and the copying, which needs no Java. At most three JVMs run at a time, four
// with the split below.
// From this many processors (`pool::jobs`) the generator's block behaviour gets its own
// server JVM.
// It pays a second Bootstrap and ~400 MB, which only pays off when the other lanes leave cores
// idle: a 6-core laptop finished its other JVMs 20 s before the server lane.
SPLIT_BLOCKS_JOBS :: 6

    // rust: fn steps(
    // rust: run: &Run,
    // rust: lock: &artifacts::Lock,
    // rust: oracle: &Path,
    // rust: minecraft: Option<&Path>,
    // rust: ) -> Result<(), String> {
    // rust: let root = &run.resources;
    // rust: let repo = &run.root;
    // rust: let server_cp = run.server_classpath.as_str();
    // rust: let client_cp = run.client_classpath.as_str();

    // rust: run.stage();
    // rust: let block_tags = "data/minecraft/tags/block/";
    // rust: let tags = json_resources(&mut open_zip(&run.server)?, block_tags)?;
    // rust: if tags != json_resources(&mut open_zip(&run.client)?, block_tags)? {
    // rust: return Err("Reference block tags disagree".into());
}
    // rust: write_json(&root.join("block-tags.json"), &tags)?;
    // rust: let tags = &tags;

    // rust: let binding = run.oracle("VanillaBlockStateBindingOracle.java");
    // rust: let helper = run.oracle("VanillaCuboidModelOracle.java");
    // rust: let binding_sources = source_hashes(repo, &[&binding, &helper])?;
    // rust: let visibility = run.oracle("VanillaFaceVisibilityOracle.java");
    // rust: let collision = run.oracle("VanillaCollisionOracle.java");
    // rust: let collision_sources = source_hashes(repo, &[&collision])?;
    // rust: let movement = run.oracle("VanillaMovementRegistryOracle.java");
    // rust: let attributes = run.oracle("VanillaEntityAttributeOracle.java");
    // rust: let landing = run.oracle("VanillaBlockLandingOracle.java");
    // rust: let motion_sources = source_hashes(
    // rust: repo,
    // rust: &[&movement, &attributes, oracle, &landing, &collision],
    // rust: )?;
    // rust: let motion_files = [
    // rust: "movement-properties.nbt",
    // rust: "attributes.json",
    // rust: "landing-definitions.json",
    // rust: ];
    // rust: let damage = run.oracle("VanillaDamageSourceOracle.java");
    // rust: let health = run.oracle("VanillaPlayerHealthOracle.java");
    // rust: let health_sources = source_hashes(repo, &[&damage, &health, &attributes])?;
    // rust: let health_files = [
    // rust: "damage-types.json",
    // rust: "damage-tags.json",
    // rust: "damage-catalog.json",
    // rust: "player-float-ids.json",
    // rust: ];
    // rust: let render_sources = source_hashes(repo, &[&visibility, &collision, oracle])?;
    // rust: let render_files = ["render-definitions.json", "occlusion.nbt"];
    // rust: let command_oracle = run.oracle("VanillaCommandParseOracle.java");
    // rust: let command_sources = source_hashes(repo, &[&command_oracle])?;

    // rust: let split_blocks = pool::jobs() >= SPLIT_BLOCKS_JOBS;

    // One file each, exported again when the exporter or the jar it reads changed.
    // rust: let single = |what: &str,
    // rust: file: &str,
    // rust: oracles: &[&str],
    // rust: key: &str,
    // rust: jar: &str,
    // rust: classes: &str,
    // rust: heap: &str,
    // rust: extra: &[String],
    // rust: log: &str|
    // rust: -> Result<Value, String> {
    // rust: let target = root.join(file);
    // rust: let sources: Vec<PathBuf> = oracles.iter().map(|o| run.oracle(o)).collect();
    // rust: let sources: Vec<&Path> = sources.iter().map(PathBuf::as_path).collect();
    // rust: let hashes = source_hashes(repo, &sources)?;
    // rust: if !(run.previous(key) == Some(&hashes) && reusable_export(&target) && run.same(jar)) {
    // rust: let main = oracles[0].strip_suffix(".java").unwrap();
    // rust: let mut args = vec![arg(&target)];
    // rust: args.extend_from_slice(extra);
    // rust: run.export(
    // rust: what,
    // rust: if jar == "client_sha256" {
    // rust: client_cp
    // rust: } else {
    // rust: server_cp
    // rust: },
    // rust: &run.local.join(classes),
    // rust: &[main],
    // rust: heap,
    // rust: &args,
    // rust: &root.join(log),
    // rust: )?;
}
    // rust: Ok(hashes)
}
    // rust: let single = &single;

    // The server exporter JVM, in the order these steps always ran.
    // rust: let server: pool::Lane<Entries> = Box::new(|| {
        // Every block state and its facts.
    // rust: let facts = root.join("facts.json");
    // rust: let origin_same = run
    // rust: .origin
    // rust: .as_object()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .all(|(k, v)| run.previous(k) == Some(v));
    // rust: run.stage();
    // rust: if !(origin_same
    // rust: && facts.exists()
    // rust: && run.previous("facts_sha256") == Some(&run.file_hash("facts.json")?))
    // rust: {
    // rust: run.export(
    // rust: "block states",
    // rust: server_cp,
    // rust: &root.join("classes"),
    // rust: &["VanillaHeightmapOracle"],
    // rust: "512M",
    // rust: &["export".into(), arg(&facts)],
    // rust: &root.join("export.log"),
    // rust: )?;
}

    // rust: run.stage();
    // rust: if !(run.previous("motion_exporters_sha256") == Some(&motion_sources)
    // rust: && run.same("server_sha256")
    // rust: && run.previous("block_tags_sha256") == Some(&run.file_hash("block-tags.json")?)
    // rust: && run.files_unchanged("motion_files_sha256", &motion_files)?)
    // rust: {
    // rust: let export = run.local.join("horizon-client-motion");
    // rust: mkdir(&export)?;
    // rust: write_json(&export.join("tags.json"), tags)?;
    // rust: run.export(
    // rust: "movement and attributes",
    // rust: server_cp,
    // rust: &export.join("classes"),
    // rust: &["VanillaBlockLandingOracle", "VanillaEntityAttributeOracle"],
    // rust: "768M",
    // rust: &["export".into(), arg(&export)],
    // rust: &export.join("export.log"),
    // rust: )?;
    // rust: copy(
    // rust: &export.join("movement-properties.nbt"),
    // rust: &root.join("movement-properties.nbt"),
    // rust: )?;
    // rust: copy(&export.join("catalog.json"), &root.join("attributes.json"))?;
    // rust: copy(
    // rust: &export.join("landing-definitions.json"),
    // rust: &root.join("landing-definitions.json"),
    // rust: )?;
}

    // rust: run.stage();
    // rust: if !(run.previous("health_exporters_sha256") == Some(&health_sources)
    // rust: && run.same("server_sha256")
    // rust: && run.files_unchanged("health_files_sha256", &health_files)?)
    // rust: {
    // rust: let export = run.local.join("horizon-client-health");
    // rust: mkdir(&export)?;
    // rust: let mut server = open_zip(&run.server)?;
    // rust: let mut client = open_zip(&run.client)?;
    // rust: for (file, prefix) in [
    // rust: ("types.json", "data/minecraft/damage_type/"),
    // rust: ("tags.json", "data/minecraft/tags/damage_type/"),
    // rust: ] {
    // rust: let resources = json_resources(&mut server, prefix)?;
    // rust: if resources != json_resources(&mut client, prefix)? {
    // rust: return Err("Reference damage resources disagree".into());
}
    // rust: write_json(&export.join(file), &resources)?;
}
    // rust: run.export(
    // rust: "damage and health",
    // rust: server_cp,
    // rust: &export.join("classes"),
    // rust: &["VanillaPlayerHealthOracle", "VanillaDamageSourceOracle"],
    // rust: "768M",
    // rust: &["export".into(), arg(&export)],
    // rust: &export.join("export.log"),
    // rust: )?;
    // rust: for (source, target) in [
    // rust: ("types.json", "damage-types.json"),
    // rust: ("tags.json", "damage-tags.json"),
    // rust: ("catalog.json", "damage-catalog.json"),
    // rust: ("ids.json", "player-float-ids.json"),
    // rust: ] {
    // rust: copy(&export.join(source), &root.join(target))?;
}
}

    // rust: let collision_file = root.join("cached-collision.nbt");
    // rust: run.stage();
    // rust: if !(run.previous("collision_exporters_sha256") == Some(&collision_sources)
    // rust: && run.same("server_sha256")
    // rust: && collision_file.exists()
    // rust: && run.previous("collision_sha256") == Some(&run.file_hash("cached-collision.nbt")?))
    // rust: {
    // rust: let export = run.local.join("horizon-client-collision");
    // rust: mkdir(&export)?;
    // rust: run.export(
    // rust: "collision shapes",
    // rust: server_cp,
    // rust: &export.join("classes"),
    // rust: &["VanillaCollisionOracle"],
    // rust: "768M",
    // rust: &["generate".into(), arg(&export)],
    // rust: &export.join("export.log"),
    // rust: )?;
    // rust: copy(&export.join("cached-collision.nbt"), &collision_file)?;
}

    // rust: run.stage();
    // rust: if !(run.previous("render_exporters_sha256") == Some(&render_sources)
    // rust: && run.same("server_sha256")
    // rust: && run.previous("block_tags_sha256") == Some(&run.file_hash("block-tags.json")?)
    // rust: && run.files_unchanged("render_files_sha256", &render_files)?)
    // rust: {
    // rust: let export = run.local.join("horizon-client-render");
    // rust: mkdir(&export)?;
    // rust: write_json(&export.join("tags.json"), tags)?;
    // rust: run.export(
    // rust: "face visibility",
    // rust: server_cp,
    // rust: &export.join("classes"),
    // rust: &["VanillaFaceVisibilityOracle"],
    // rust: "768M",
    // rust: &["export".into(), arg(&export)],
    // rust: &export.join("export.log"),
    // rust: )?;
    // rust: copy(
    // rust: &export.join("definitions.json"),
    // rust: &root.join("render-definitions.json"),
    // rust: )?;
    // rust: copy(&export.join("occlusion.nbt"), &root.join("occlusion.nbt"))?;
}

    // rust: run.stage();
    // rust: let gameplay = single(
    // rust: "gameplay facts",
    // rust: "gameplay-facts.json",
    // rust: &["VanillaGameplayFactsExporter.java"],
    // rust: "gameplay_exporters_sha256",
    // rust: "server_sha256",
    // rust: "gameplay-facts/classes",
    // rust: "1G",
    // rust: &[],
    // rust: "gameplay-export.log",
    // rust: )?;
        // Entity dimensions, categories and default attributes for the client's mobs.
    // rust: run.stage();
    // rust: let entity_types = single(
    // rust: "entity types",
    // rust: "entity-types.json",
    // rust: &["VanillaEntityTypesExporter.java"],
    // rust: "entity_types_exporters_sha256",
    // rust: "server_sha256",
    // rust: "entity-types/classes",
    // rust: "1G",
    // rust: &[],
    // rust: "entity-types-export.log",
    // rust: )?;
        // Block classes, instance configuration and per-state support/signal/fluid
        // facts for horizon-world's level behaviour (level::Behaviours::load).
    // rust: run.stage();
    // rust: let behaviour = single(
    // rust: "block behaviours",
    // rust: "block-behaviours.json",
    // rust: &["VanillaBlockBehaviourExporter.java"],
    // rust: "behaviour_exporters_sha256",
    // rust: "server_sha256",
    // rust: "block-behaviours/classes",
    // rust: "1G",
    // rust: &[],
    // rust: "behaviour-export.log",
    // rust: )?;
    // rust: if !split_blocks {
    // rust: worldgen_blocks(run, 0)?;
}
    // rust: run.close_worker(0);
    // rust: Ok(vec![
    // rust: ("gameplay_exporters_sha256", gameplay),
    // rust: ("entity_types_exporters_sha256", entity_types),
    // rust: ("behaviour_exporters_sha256", behaviour),
    // rust: ])
    // rust: });

    // The client exporter JVM, then the command registries' own.
    // rust: let client: pool::Lane<Entries> = Box::new(|| {
        // Block state to model bindings, from the client.
    // rust: let model_states = root.join("model-states.json");
    // rust: run.stage();
    // rust: if !(run.previous("model_state_exporters_sha256") == Some(&binding_sources)
    // rust: && run.same("client_sha256")
    // rust: && model_states.exists()
    // rust: && run.previous("model_states_sha256") == Some(&run.file_hash("model-states.json")?))
    // rust: {
    // rust: run.export(
    // rust: "model bindings",
    // rust: client_cp,
    // rust: &root.join("client-classes"),
    // rust: &["VanillaBlockStateBindingOracle"],
    // rust: "512M",
    // rust: &["export".into(), arg(&model_states)],
    // rust: &root.join("model-state-export.log"),
    // rust: )?;
}
    // rust: run.stage();
    // rust: let entity_models = single(
    // rust: "entity models",
    // rust: "entity-models.json",
    // rust: &["VanillaEntityModelExporter.java"],
    // rust: "entity_model_exporters_sha256",
    // rust: "client_sha256",
    // rust: "entity-models/classes",
    // rust: "1G",
    // rust: &[],
    // rust: "entity-model-export.log",
    // rust: )?;
        // Mob AI and animation facts: per-state path types, spawn placements and the
        // client's keyframe animation definitions (needs the client jar).
    // rust: run.stage();
    // rust: let mob_data = single(
    // rust: "mob data",
    // rust: "mob-data.json",
    // rust: &["VanillaMobDataExporter.java"],
    // rust: "mob_data_exporters_sha256",
    // rust: "client_sha256",
    // rust: "mob-data/classes",
    // rust: "1G",
    // rust: &[arg(&run.client)],
    // rust: "mob-data-export.log",
    // rust: )?;
    // rust: run.close_worker(1);

        // Vanilla's built-in registries for in-game command parsing (mob effects,
        // data component types, dialogs, block entity and tag members).
    // rust: let command_registries = root.join("command-registries.json");
    // rust: run.stage();
    // rust: if !(run.previous("command_registries_exporters_sha256") == Some(&command_sources)
    // rust: && reusable_export(&command_registries)
    // rust: && run.same("server_sha256"))
    // rust: {
    // rust: let export = run.local.join("command-registries");
    // rust: run.export(
    // rust: "command registries",
    // rust: server_cp,
    // rust: &export.join("classes"),
    // rust: &["VanillaCommandParseOracle"],
    // rust: "1G",
    // rust: &["registries".into(), arg(&export)],
    // rust: &root.join("command-registries-export.log"),
    // rust: )?;
    // rust: copy(&export.join("registries.json"), &command_registries)?;
}
    // rust: Ok(vec![
    // rust: ("entity_model_exporters_sha256", entity_models),
    // rust: ("mob_data_exporters_sha256", mob_data),
    // rust: ])
    // rust: });

    // The data generator's JVM, then the creative inventory's.
    // rust: let reports: pool::Lane<Entries> = Box::new(|| {
    // rust: run.stage();
    // rust: if datagen_reports_missing(root) || !run.same("server_sha256") {
            // Vanilla's own data generator reports every item's default components.
    // rust: (run.log)("Running vanilla's data generator reports");
    // rust: let started = Instant::now();
    // rust: let datagen = run.local.join("datagen");
    // rust: mkdir(&datagen)?;
    // rust: let log_path = datagen.join("datagen.log");
    // rust: let log = run.log_file(&log_path)?;
    // rust: run.jdk
    // rust: .java(
    // rust: &[
    // rust: "-DbundlerMainClass=net.minecraft.data.Main".into(),
    // rust: "-jar".into(),
    // rust: arg(&lock.directory.join("jars").join("server.jar")),
    // rust: "--reports".into(),
    // rust: "--output".into(),
    // rust: "out".into(),
    // rust: ],
    // rust: Some(&datagen),
    // rust: &log,
    // rust: )
    // rust: .map_err(|e| format!("{e} in the data generator; see {}", log_path.display()))?;
    // rust: let reports = datagen.join("out").join("reports");
    // rust: install_datagen_reports(root, &reports)?;
    // rust: (run.log)(&format!("Ran the data generator{}", took(started)));
}

        // The registry and command reports, which the game reads next to these
        // files when it serves players (a dedicated server, a LAN world): kept
        // here too, so this folder works when it is copied or mounted alone.
    // rust: let reports = run.local.join("datagen").join("out").join("reports");
    // rust: for name in ["registries.json", "commands.json"] {
    // rust: let (from, to) = (reports.join(name), root.join(name));
    // rust: if from.is_file() && (!to.exists() || !run.same("server_sha256")) {
    // rust: copy(&from, &to)?;
}
}

        // The creative inventory (creative-inventory.json): every tab built by vanilla's
        // CreativeModeTabs over the vanilla data pack's registries, with the search
        // tab's tooltip lines and tags.
    // rust: run.stage();
    // rust: let creative = single(
    // rust: "the creative inventory",
    // rust: "creative-inventory.json",
    // rust: &["VanillaCreativeTabsExporter.java", "ParityData.java"],
    // rust: "creative_exporters_sha256",
    // rust: "server_sha256",
    // rust: "creative-inventory/classes",
    // rust: "2G",
    // rust: &[],
    // rust: "creative-export.log",
    // rust: )?;
    // rust: Ok(vec![("creative_exporters_sha256", creative)])
    // rust: });

    // The playable client needs every client asset (textures, models, fonts, GUI)
    // and every data-pack resource (worldgen, recipes, loot tables, tags), and
    // the vanilla pack's icon (`pack.png`) for the pack screen.
    // rust: let files: pool::Lane<Entries> = Box::new(|| {
    // rust: run.stage();
    // rust: (run.log)("Copying the client's assets and data");
    // rust: let started = Instant::now();
    // rust: let mut indexed = sounds::Assets::load(repo, Some(root), minecraft, &run.inputs, run.log);
    // rust: let (version, count) = extract_client_resources(&run.client, root, indexed.as_mut().ok())?;
    // rust: sounds::optional_imports(indexed.as_mut().map_err(|e| e.as_str()), run.log);
    // rust: (run.log)(&format!(
    // rust: "Copied the client's assets and data{}",
    // rust: took(started)
    // rust: ));
    // rust: worldgen_bundles(run)?;
    // rust: Ok(vec![
    // rust: (
    // rust: "data_version",
    // rust: version
    // rust: .get("world_version")
    // rust: .cloned()
    // rust: .ok_or("version.json has no world_version")?,
    // rust: ),
    // rust: ("resource_files", Value::Int(count.to_string())),
    // rust: ])
    // rust: });

    // rust: let mut lanes = vec![server, client, reports, files];
    // rust: if split_blocks {
        // With cores to spare, the generator's block behaviour (a quarter of the server lane's
        // time) runs on a second server JVM beside the first; it pays its own Bootstrap.
    // rust: lanes.push(Box::new(|| {
    // rust: worldgen_blocks(run, 2)?;
    // rust: run.close_worker(2);
    // rust: Ok(Vec::new())
    // rust: }));
}
    // rust: let entries: Entries = pool::lanes(lanes)?.into_iter().flatten().collect();
    // Biome parameter tables come from the data generator reports above.
    // rust: run.stage();
    // rust: worldgen_tables(run)?;

    // rust: let entry = |key: &str| entries.iter().find(|(k, _)| *k == key).unwrap().1.clone();
    // rust: let file_hashes = |names: &[&str]| -> Result<Value, String> {
    // rust: Ok(Value::Object(
    // rust: names
    // rust: .iter()
    // rust: .map(|n| Ok((n.to_string(), run.file_hash(n)?)))
    // rust: .collect::<Result<_, String>>()?,
    // rust: ))
}
    // rust: run.stage();
    // rust: let mut manifest = vec![("schema".to_string(), Value::Int(SCHEMA.to_string()))];
    // rust: manifest.extend(run.origin.as_object().unwrap().iter().cloned());
    // rust: manifest.extend([
    // rust: ("health_exporters_sha256".into(), health_sources),
    // rust: ("health_files_sha256".into(), file_hashes(&health_files)?),
    // rust: ("motion_exporters_sha256".into(), motion_sources),
    // rust: ("motion_files_sha256".into(), file_hashes(&motion_files)?),
    // rust: ("collision_exporters_sha256".into(), collision_sources),
    // rust: (
    // rust: "collision_sha256".into(),
    // rust: run.file_hash("cached-collision.nbt")?,
    // rust: ),
    // rust: ("render_exporters_sha256".into(), render_sources),
    // rust: ("render_files_sha256".into(), file_hashes(&render_files)?),
    // rust: ("model_state_exporters_sha256".into(), binding_sources),
    // rust: (
    // rust: "gameplay_exporters_sha256".into(),
    // rust: entry("gameplay_exporters_sha256"),
    // rust: ),
    // rust: (
    // rust: "entity_model_exporters_sha256".into(),
    // rust: entry("entity_model_exporters_sha256"),
    // rust: ),
    // rust: (
    // rust: "creative_exporters_sha256".into(),
    // rust: entry("creative_exporters_sha256"),
    // rust: ),
    // rust: (
    // rust: "mob_data_exporters_sha256".into(),
    // rust: entry("mob_data_exporters_sha256"),
    // rust: ),
    // rust: (
    // rust: "entity_types_exporters_sha256".into(),
    // rust: entry("entity_types_exporters_sha256"),
    // rust: ),
    // rust: (
    // rust: "behaviour_exporters_sha256".into(),
    // rust: entry("behaviour_exporters_sha256"),
    // rust: ),
    // rust: (
    // rust: "command_registries_exporters_sha256".into(),
    // rust: command_sources,
    // rust: ),
    // rust: (
    // rust: "model_states_sha256".into(),
    // rust: run.file_hash("model-states.json")?,
    // rust: ),
    // rust: ("data_version".into(), entry("data_version")),
    // rust: ("facts_sha256".into(), run.file_hash("facts.json")?),
    // rust: (
    // rust: "block_tags_sha256".into(),
    // rust: run.file_hash("block-tags.json")?,
    // rust: ),
    // rust: ("resource_files".into(), entry("resource_files")),
    // rust: ]);
    // rust: write_json(
    // rust: &root.join("horizon-resources.json"),
    // rust: &Value::Object(manifest),
    // rust: )
}

// Check existing JAR assets by their ZIP size/CRC without inflating every member again.
// Indexed panorama/font/language replacements have stronger SHA-1 checks and take precedence.
// The members are checked and written on several threads, each with the jar open.
    // rust: fn extract_client_resources(
    // rust: jar: &Path,
    // rust: root: &Path,
    // rust: mut indexed: Option<&mut sounds::Assets>,
    // rust: ) -> Result<(Value, usize), String> {
    // rust: let mut client = open_zip(jar)?;
    // rust: let version = pyjson::loads(&zip_text(&mut client, "version.json")?)?;
    // rust: let mut count = 0;
    // Members whose files could be one on a case-insensitive file system, in the jar's order:
    // one thread writes them all, so the last one wins as it did.
    // rust: let mut groups: Vec<Vec<(String, PathBuf)>> = Vec::new();
    // rust: let mut group_of = std::collections::HashMap::new();
    // rust: for name in zip_names(&client)? {
    // rust: if !(name.starts_with("assets/") || name.starts_with("data/") || name == "pack.png")
    // rust: || name.ends_with('/')
    // rust: {
    // rust: continue;
}
    // rust: let relative = member_path(&name, "Invalid resource path")?;
    // rust: count += 1;
    // rust: if let Some(assets) = &mut indexed {
    // rust: if assets.imported(&name)? {
    // rust: continue;
}
}
    // rust: let target = root.join(relative);
    // rust: let group = *group_of.entry(name.to_lowercase()).or_insert_with(|| {
    // rust: groups.push(Vec::new());
    // rust: groups.len() - 1
    // rust: });
    // rust: groups[group].push((name, target));
}
    // rust: pool::map(&groups, |group| {
        // A clone shares the jar's parsed member list and reads at its own offset.
    // rust: let mut client = client.clone();
    // rust: for (name, target) in group {
    // rust: extract_member(&mut client, name, target)?;
}
    // rust: Ok(())
    // rust: })?;
    // rust: Ok((version, count))
}

// Writes one member unless its file already has the member's size and CRC.
extract_member :: proc(client: ^Jar, name: string, target: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let member = client.by_name(name).map_err(|e| e.to_string())?;
    // rust: let (size, crc) = (member.size(), member.crc32());
    // rust: drop(member);
    // rust: if target.is_file() && fs::metadata(target).map_err(|e| e.to_string())?.len() == size {
    // rust: let mut file = fs::File::open(target).map_err(|e| e.to_string())?;
    // rust: let mut hash = crc32fast::Hasher::new();
    // rust: let mut buffer = [0; 16 * 1024];
    // rust: loop {
    // rust: let n = file.read(&mut buffer).map_err(|e| e.to_string())?;
    // rust: if n == 0 {
    // rust: break;
}
    // rust: hash.update(&buffer[..n]);
}
    // rust: if hash.finalize() == crc {
    // rust: return Ok(());
}
}
    // rust: mkdir(target.parent().unwrap())?;
    // rust: write(target, &zip_bytes(client, name)?)
}

datagen_reports_missing :: proc(root: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ["items.json", "registries.json", "commands.json"]
    // rust: .iter()
    // rust: .any(|name| !root.join(name).is_file())
}

install_datagen_reports :: proc(root: ^Path, reports: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: for name in ["registries.json", "commands.json"] {
    // rust: copy(&reports.join(name), &root.join(name))?;
}
    // rust: let mut components = Value::Object(Vec::new());
    // rust: for file in json_files(&reports.join("minecraft/components/item"))? {
    // rust: let stem = file.file_stem().unwrap().to_string_lossy().into_owned();
    // rust: let report = read_json(&file)?;
    // rust: let component = report
    // rust: .get("components")
    // rust: .ok_or_else(|| format!("{} has no components", file.display()))?;
    // rust: components.insert(&format!("minecraft:{stem}"), component.clone());
}
    // rust: write_text(
    // rust: &root.join("items.json"),
    // rust: &pyjson::dumps(&components, &pyjson::DEFAULT),
    // rust: )?;
    // rust: let biome_parameters = root.join("biome-parameters");
    // rust: mkdir(&biome_parameters)?;
    // rust: for file in json_files(&reports.join("biome_parameters/minecraft"))? {
    // rust: copy(&file, &biome_parameters.join(file.file_name().unwrap()))?;
}
    // rust: Ok(())
}

// `sorted(directory.glob('*.json'))`: glob skips names starting with a dot.
json_files :: proc(directory: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut files: Vec<PathBuf> = fs::read_dir(directory)
    // rust: .map_err(|e| format!("{}: {e}", directory.display()))?
    // rust: .filter_map(Result::ok)
    // rust: .filter(|e| {
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: name.ends_with(".json") && !name.starts_with('.')
    // rust: })
    // rust: .map(|e| e.path())
    // rust: .collect();
    // rust: files.sort();
    // rust: Ok(files)
}

    // rust: const WORLDGEN_BUNDLES: [(&str, &str); 19] = [
    // rust: ("noises", "worldgen/noise"),
    // rust: ("densities", "worldgen/density_function"),
    // rust: ("rules", "worldgen/material_rule"),
    // rust: ("conditions", "worldgen/material_condition"),
    // rust: ("settings", "worldgen/noise_settings"),
    // rust: ("carvers", "worldgen/carver"),
    // rust: ("biomes", "worldgen/biome"),
    // rust: ("world_presets", "worldgen/world_preset"),
    // rust: ("features", "worldgen/feature"),
    // rust: ("placed_features", "worldgen/placed_feature"),
    // rust: ("state_providers", "worldgen/block_state_provider"),
    // rust: ("biome_tags", "tags/worldgen/biome"),
    // rust: ("feature_tags", "tags/worldgen/feature"),
    // rust: ("block_tags", "tags/block"),
    // rust: ("fluid_tags", "tags/fluid"),
    // rust: ("processor_lists", "worldgen/processor_list"),
    // rust: ("template_pools", "worldgen/template_pool"),
    // rust: ("structures", "worldgen/structure"),
    // rust: ("structure_sets", "worldgen/structure_set"),
    // rust: ];

    // rust: const BLOCK_BEHAVIOR_FILES: [&str; 6] = [
    // rust: "block-properties.nbt",
    // rust: "cached-collision.nbt",
    // rust: "cached-support.nbt",
    // rust: "survival-rules.json",
    // rust: "survival-extra-definitions.json",
    // rust: "placement-definitions.json",
    // rust: ];

// The chunk generator's resource bundle in `<resources>/worldgen` (see GeneratorData::load), from
// the jars: structure templates and the worldgen registries.
worldgen_bundles :: proc(run: ^Run) -> R {
    // Ported from Horizon
    return {}
}
    // rust: (run.log)("Writing the world generator's bundle");
    // rust: let started = Instant::now();
    // rust: let out = run.resources.join("worldgen");
    // rust: mkdir(&out)?;
    // Structure templates: gzip NBT files under structure/<namespace>/<path>.nbt.
    // rust: let prefix = "data/minecraft/structure/";
    // rust: let (server, client) = (open_zip(&run.server)?, open_zip(&run.client)?);
    // zip_names gives each name once.
    // rust: let templates: Vec<String> = zip_names(&server)?
    // rust: .into_iter()
    // rust: .filter(|name| name.starts_with(prefix) && name.ends_with(".nbt"))
    // rust: .collect();
    // rust: pool::map(&templates, |name| {
    // rust: let relative = member_path(&name[prefix.len()..], "Invalid structure path")?;
    // rust: let data = zip_bytes(&mut server.clone(), name)?;
    // rust: write_if_changed(&out.join("structure/minecraft").join(relative), &data)
    // rust: })?;
    // rust: pool::map(&WORLDGEN_BUNDLES, |(name, path)| {
    // rust: let prefix = format!("data/minecraft/{path}/");
    // rust: let resources = json_resources(&mut server.clone(), &prefix)?;
    // rust: if resources.as_object().is_none_or(<[_]>::is_empty)
    // rust: || resources != json_resources(&mut client.clone(), &prefix)?
    // rust: {
    // rust: return Err(format!("Reference worldgen resources disagree: {path}"));
}
    // rust: write_text(
    // rust: &out.join(format!("{name}.json")),
    // rust: &pyjson::dumps(&resources, &pyjson::COMPACT),
    // rust: )
    // rust: })?;
    // rust: (run.log)(&format!(
    // rust: "Wrote the world generator's bundle{}",
    // rust: took(started)
    // rust: ));
    // rust: Ok(())
}

// The generator's block behaviour and structure block files, from the server exporter JVM.
worldgen_blocks :: proc(run: ^Run, worker: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let local = &run.local;
    // rust: let blocks = run.resources.join("worldgen").join("blocks");
    // Block behavior used by feature placement checks (survival, support, collision).
    // These come from the Java exporters of the simple-block parity run, or a direct export.
    // rust: let all_present = |dir: &Path| BLOCK_BEHAVIOR_FILES.iter().all(|n| dir.join(n).exists());
    // rust: let inputs = stamp_inputs(run)?;
    // rust: let mut behavior = local.join("rust-simple-block-parity");
    // rust: if !all_present(&behavior) {
    // rust: behavior = local.join("horizon-client-block-behavior");
    // rust: let outputs: Vec<PathBuf> = BLOCK_BEHAVIOR_FILES
    // rust: .iter()
    // rust: .map(|n| behavior.join(n))
    // rust: .collect();
    // rust: let stamp = behavior.join("stamp.json");
    // rust: if !stamp_matches(&stamp, &inputs, &outputs) {
    // rust: export_block_behavior(run, worker, &behavior)?;
    // rust: write_stamp(&stamp, &inputs, &outputs)?;
}
}
    // rust: mkdir(&blocks)?;
    // rust: for name in BLOCK_BEHAVIOR_FILES {
    // rust: copy(&behavior.join(name), &blocks.join(name))?;
}
    // rust: let structures = local.join("horizon-client-structures");
    // rust: let output = blocks.join("structure-blocks.json");
    // rust: let stamp = structures.join("stamp.json");
    // rust: if !stamp_matches(&stamp, &inputs, std::slice::from_ref(&output)) {
    // rust: run.export_on(
    // rust: worker,
    // rust: "structure blocks",
    // rust: &run.server_classpath,
    // rust: &structures.join("classes"),
    // rust: &["VanillaStructureBlockExporter"],
    // rust: "1G",
    // rust: &[arg(&output)],
    // rust: &structures.join("export.log"),
    // rust: )?;
    // rust: write_stamp(&stamp, &inputs, std::slice::from_ref(&output))?;
}
    // rust: Ok(())
}

// What an exporter's output kept beside its stamp depends on: every exporter source and pin
// (the exporter bundle's key), the server jar, and this preparer.
stamp_inputs :: proc(run: ^Run) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Value::Object(vec![
    // rust: ("exporters".into(), Value::Str(exporters::key(&run.root)?)),
    // rust: (
    // rust: "server_sha256".into(),
    // rust: run.origin
    // rust: .get("server_sha256")
    // rust: .cloned()
    // rust: .unwrap_or(Value::Null),
    // rust: ),
    // rust: ("preparer".into(), Value::str(SOURCES_SHA256)),
    // rust: ]))
}

// The stamp a run that exported `outputs` from `inputs` left: the outputs are still those files.
// It lives in `.local` beside the exporter's working files, not in the prepared resources.
stamp_matches :: proc(stamp: ^Path, inputs: ^Value, outputs: ^[PathBuf]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(recorded) = read_json(stamp) else {
    // rust: return false;
}
    // rust: recorded.get("inputs") == Some(inputs)
    // rust: && stamp_outputs(outputs).is_ok_and(|outputs| recorded.get("outputs") == Some(&outputs))
}

stamp_outputs :: proc(outputs: ^[PathBuf]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let hashes = pool::map(outputs, |path| digest(path, "sha256"))?;
    // rust: Ok(Value::Object(
    // rust: outputs
    // rust: .iter()
    // rust: .zip(hashes)
    // rust: .map(|(path, hash)| (arg(path), Value::Str(hash)))
    // rust: .collect(),
    // rust: ))
}

write_stamp :: proc(stamp: ^Path, inputs: ^Value, outputs: ^[PathBuf]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: write_json(
    // rust: stamp,
    // rust: &Value::Object(vec![
    // rust: ("inputs".into(), inputs.clone()),
    // rust: ("outputs".into(), stamp_outputs(outputs)?),
    // rust: ]),
    // rust: )
}

// The generator's tables from the block facts and the data generator's reports.
worldgen_tables :: proc(run: ^Run) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let root = &run.resources;
    // rust: let local = &run.local;
    // rust: let out = root.join("worldgen");
    // rust: let facts = read_json(&root.join("facts.json"))?;
    // rust: let short = || "A block state in facts.json is short".to_string();
    // rust: let flags = facts
    // rust: .get("states")
    // rust: .and_then(Value::as_array)
    // rust: .ok_or("facts.json has no states")?
    // rust: .iter()
    // rust: .map(|s| {
    // rust: Ok(Value::Array(vec![
    // rust: s.index(1).cloned().ok_or_else(short)?,
    // rust: s.index(2).cloned().ok_or_else(short)?,
    // rust: ]))
    // rust: })
    // rust: .collect::<Result<Vec<_>, String>>()?;
    // rust: write_text(
    // rust: &out.join("block_flags.json"),
    // rust: &pyjson::dumps(&Value::Array(flags), &pyjson::COMPACT),
    // rust: )?;
    // rust: let reports = out.join("biome_parameters");
    // rust: mkdir(&reports)?;
    // rust: let mut presets = false;
    // rust: for source in [
    // rust: root.join("biome-parameters"),
    // rust: local.join("datagen/out/reports/biome_parameters/minecraft"),
    // rust: ] {
    // rust: if source.join("overworld.json").exists() {
    // rust: for report in json_files(&source)? {
    // rust: copy(&report, &reports.join(report.file_name().unwrap()))?;
}
    // rust: presets = true;
    // rust: break;
}
}
    // rust: if !presets {
        // Fall back to the Java-exported quantized tables from the material-stage parity run.
    // rust: let tables = local.join("rust-material-stage-parity/presets.json");
    // rust: if !tables.exists() {
    // rust: return Err(
    // rust: "No multi-noise biome parameter tables; run the data generator reports".into(),
    // rust: );
}
    // rust: copy(&tables, &out.join("presets.json"))?;
}
    // rust: Ok(())
}

// The vanilla exporters of block properties, support, collision and survival definitions.
// Feature placement needs them: without these files the generator skips every placed feature
// whose blocks are checked for survival or support (trees, flowers, grass, kelp, ...).
export_block_behavior :: proc(run: ^Run, worker: uint, export: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: run.export_on(
    // rust: worker,
    // rust: "block behavior",
    // rust: &run.server_classpath,
    // rust: &export.join("classes"),
    // rust: &["VanillaSimpleBlockOracle"],
    // rust: "1G",
    // rust: &["export".into(), arg(export)],
    // rust: &export.join("export.log"),
    // rust: )?;
    // rust: let rules = survival::bind_definitions(
    // rust: &read_json(&export.join("survival-classes.json"))?,
    // rust: &read_json(&export.join("survival-placement-classes.json"))?,
    // rust: &read_json(&export.join("survival-support-tags.json"))?,
    // rust: )?;
    // rust: write_text(
    // rust: &export.join("survival-rules.json"),
    // rust: &pyjson::dumps(&rules, &pyjson::COMPACT),
    // rust: )
}

    // rust: mod tests {
//     use super::*;

an_output_in_the_scratch_folder_is_one_folder_however_it_is_named :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-prepare-same-{}", std::process::id()));
    // rust: let local = dir.join(".local");
    // rust: assert!(same_dir(&local, &dir.join("x").join("..").join(".local")).unwrap());
    // rust: assert!(!same_dir(&local, &local.join("horizon-client")).unwrap());
        // The lock it would have taken twice: once, then the output skips it.
    // rust: let _held = hold_lock(&local, &|_| {}).unwrap();
    // rust: let _ = fs::remove_dir_all(&dir);
}

an_empty_or_half_written_export_is_written_again :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-prepare-export-{}", std::process::id()));
    // rust: mkdir(&dir).unwrap();
        // What a killed exporter leaves: the path exists but holds no document.
        // A prepare that only checked `exists` kept it, so "prepare again" left
        // the game crashing on it.
    // rust: assert!(!reusable_export(&dir.join("missing.json")));
    // rust: write(&dir.join("empty.json"), b"").unwrap();
    // rust: assert!(!reusable_export(&dir.join("empty.json")));
    // rust: write(&dir.join("cut.json"), br#"{"states": [}"#).unwrap();
    // rust: assert!(!reusable_export(&dir.join("cut.json")));
    // rust: write(&dir.join("whole.json"), br#"{"states": []}"#).unwrap();
    // rust: assert!(reusable_export(&dir.join("whole.json")));
    // rust: fs::remove_dir_all(dir).unwrap();
}

datagen_reports_are_installed_beside_resources_and_missing_reports_need_repair :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-prepare-reports-{}", std::process::id()));
    // rust: let root = dir.join("resources");
    // rust: let reports = dir.join("reports");
    // rust: mkdir(&root).unwrap();
    // rust: mkdir(&reports.join("minecraft/components/item")).unwrap();
    // rust: mkdir(&reports.join("biome_parameters/minecraft")).unwrap();
    // rust: write_text(&root.join("items.json"), "{}").unwrap();
    // rust: assert!(datagen_reports_missing(&root));
    // rust: write_text(
    // rust: &reports.join("registries.json"),
    // rust: "{\"minecraft:item\":{\"entries\":{}}}",
    // rust: )
    // rust: .unwrap();
    // rust: write_text(&reports.join("commands.json"), "{\"type\":\"root\"}").unwrap();
    // rust: write_text(
    // rust: &reports.join("minecraft/components/item/stone.json"),
    // rust: "{\"components\":{\"minecraft:max_stack_size\":64}}",
    // rust: )
    // rust: .unwrap();
    // rust: write_text(
    // rust: &reports.join("biome_parameters/minecraft/overworld.json"),
    // rust: "{}",
    // rust: )
    // rust: .unwrap();
    // rust: install_datagen_reports(&root, &reports).unwrap();
    // rust: assert!(!datagen_reports_missing(&root));
    // rust: for name in ["registries.json", "commands.json"] {
    // rust: assert_eq!(
    // rust: read(&root.join(name)).unwrap(),
    // rust: read(&reports.join(name)).unwrap()
    // rust: );
}
    // rust: assert!(read_json(&root.join("items.json"))
    // rust: .unwrap()
    // rust: .get("minecraft:stone")
    // rust: .is_some());
    // rust: assert!(root.join("biome-parameters/overworld.json").is_file());
    // rust: for name in ["registries.json", "commands.json", "items.json"] {
    // rust: fs::remove_file(root.join(name)).unwrap();
    // rust: assert!(datagen_reports_missing(&root), "{name}");
    // rust: install_datagen_reports(&root, &reports).unwrap();
}
    // rust: fs::remove_dir_all(dir).unwrap();
}

lanes_messages_reach_the_log_and_the_fraction_only_grows :: proc() {
}
    // rust: let (send, messages) = std::sync::mpsc::channel();
    // rust: for stage in 0..STAGES {
    // rust: send.send(Some(format!("line {stage}"))).unwrap();
    // rust: send.send(None).unwrap();
}
    // rust: drop(send);
    // rust: let lines = std::cell::RefCell::new(Vec::new());
    // rust: let fractions = std::cell::RefCell::new(Vec::new());
    // rust: relay(
    // rust: messages,
    // rust: &|line| lines.borrow_mut().push(line.to_string()),
    // rust: &|done| fractions.borrow_mut().push(done),
    // rust: );
    // rust: let lines = lines.into_inner();
    // rust: assert_eq!(lines.len() as u32, STAGES);
    // rust: assert_eq!(lines[3], "line 3");
        // Each stage reports the ones before it: the last stops short of 1, which only the end
        // of `prepare` reports.
    // rust: let fractions = fractions.into_inner();
    // rust: let expected: Vec<f32> = (0..STAGES).map(|n| n as f32 / STAGES as f32).collect();
    // rust: assert_eq!(fractions, expected);
}

    // `--progress json` reaches 1 only at the end: `STAGES` counts the stages `steps` opens.
steps_open_every_stage :: proc() {
}
        // A Windows checkout may have CRLF line ends.
    // rust: let source = include_str!("lib.rs").replace("\r\n", "\n");
    // rust: let body = &source[source.find("\nfn steps(").unwrap()..];
    // rust: let body = &body[..body.find("\n}\n").unwrap()];
    // rust: assert_eq!(body.matches("run.stage();").count() as u32, STAGES);
}

output_versions_end_at_the_output_version :: proc() {
}
    // rust: let text = include_str!("../output-versions.txt");
    // rust: let versions: Vec<(u32, &str)> = text
    // rust: .lines()
    // rust: .filter(|l| !l.trim().is_empty() && !l.starts_with('#'))
    // rust: .map(|l| {
    // rust: let (n, digest) = l.split_once(' ').unwrap();
    // rust: (n.parse().unwrap(), digest.trim())
    // rust: })
    // rust: .collect();
    // rust: let numbers: Vec<u32> = versions.iter().map(|v| v.0).collect();
    // rust: assert_eq!(numbers, (1..=OUTPUT_VERSION).collect::<Vec<_>>());
    // rust: for (i, (_, digest)) in versions.iter().enumerate() {
    // rust: assert_eq!(digest.len(), 64);
    // rust: assert!(!versions[..i].iter().any(|(_, d)| d == digest));
}
        // The launcher finds the number with this line in a version folder's sources.
    // rust: let lib = include_str!("lib.rs");
    // rust: let line = format!("pub const OUTPUT_VERSION: u32 = {OUTPUT_VERSION};");
    // rust: assert!(lib.lines().any(|l| l == line));
}

the_source_digest_is_the_one_build_rs_computed :: proc() {
}
    // rust: assert_eq!(
    // rust: sources_sha256(Path::new(env!("CARGO_MANIFEST_DIR"))).as_deref(),
    // rust: Some(SOURCES_SHA256)
    // rust: );
    // rust: assert_eq!(sources_sha256(Path::new("/nonexistent")), None);
}

lines_split_as_python_splits_them :: proc() {
}
    // rust: assert_eq!(split_lines("a\r\nb\rc\n\nd"), ["a", "b", "c", "", "d"]);
    // rust: assert_eq!(split_lines("a\n"), ["a"]);
}

stamps_skip_an_export_only_while_its_inputs_and_outputs_are_unchanged :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-prepare-stamp-{}", std::process::id()));
    // rust: let outputs = [dir.join("out/a.json"), dir.join("out/b.nbt")];
    // rust: mkdir(&dir.join("out")).unwrap();
    // rust: for output in &outputs {
    // rust: write(output, b"exported").unwrap();
}
    // rust: let stamp = dir.join("work/stamp.json");
    // rust: let inputs = Value::Object(vec![("exporters".into(), Value::str("key"))]);
    // rust: assert!(!stamp_matches(&stamp, &inputs, &outputs), "never exported");
    // rust: write_stamp(&stamp, &inputs, &outputs).unwrap();
    // rust: assert!(stamp_matches(&stamp, &inputs, &outputs));
    // rust: let changed = Value::Object(vec![("exporters".into(), Value::str("new key"))]);
    // rust: assert!(
    // rust: !stamp_matches(&stamp, &changed, &outputs),
    // rust: "new exporters or jar"
    // rust: );
    // rust: write(&outputs[1], b"damaged").unwrap();
    // rust: assert!(!stamp_matches(&stamp, &inputs, &outputs), "output changed");
    // rust: write(&outputs[1], b"exported").unwrap();
    // rust: assert!(stamp_matches(&stamp, &inputs, &outputs));
    // rust: fs::remove_file(&outputs[0]).unwrap();
    // rust: assert!(!stamp_matches(&stamp, &inputs, &outputs), "output missing");
    // rust: write(&stamp, b"{not json").unwrap();
    // rust: assert!(!stamp_matches(&stamp, &inputs, &outputs));
        // A stamp that records no outputs never vouches for a missing one.
    // rust: write_json(
    // rust: &stamp,
    // rust: &Value::Object(vec![("inputs".into(), inputs.clone())]),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(!stamp_matches(&stamp, &inputs, &outputs), "no outputs");
    // rust: fs::remove_dir_all(dir).unwrap();
}

client_resources_are_extracted_once_and_repaired_when_damaged :: proc() {
}
//         use std::io::Write;
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-prepare-extract-{}", std::process::id()));
    // rust: mkdir(&dir).unwrap();
    // rust: let jar = dir.join("client.jar");
    // rust: let mut archive = zip::ZipWriter::new(fs::File::create(&jar).unwrap());
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: let mut members = vec![(
    // rust: "version.json".to_string(),
    // rust: b"{\"world_version\": 1}".to_vec(),
    // rust: )];
    // rust: for i in 0..400 {
    // rust: members.push((
    // rust: format!("assets/minecraft/textures/{i}.png"),
    // rust: vec![i as u8; i],
    // rust: ));
}
    // rust: members.push(("data/minecraft/Tag.json".into(), b"upper".to_vec()));
    // rust: members.push(("data/minecraft/tag.json".into(), b"lower".to_vec()));
    // rust: members.push(("pack.png".into(), b"icon".to_vec()));
    // rust: members.push(("META-INF/MANIFEST.MF".into(), b"not a resource".to_vec()));
    // rust: for (name, data) in &members {
    // rust: archive.start_file(name.as_str(), options).unwrap();
    // rust: archive.write_all(data).unwrap();
}
    // rust: archive.finish().unwrap();
    // rust: let root = dir.join("resources");
    // rust: let (version, count) = extract_client_resources(&jar, &root, None).unwrap();
    // rust: assert_eq!(version.get("world_version"), Some(&Value::Int("1".into())));
    // rust: assert_eq!(count, 403);
    // rust: let resources = &members[1..members.len() - 1];
        // On a case-insensitive file system (macOS, Windows) the two names are one file, and
        // the later member of the pair wins. (`Path`s compare case-sensitively, so ask the disk.)
    // rust: let folded = root.join("DATA/minecraft/tag.json").exists();
    // rust: let check = || {
    // rust: for (name, data) in resources {
    // rust: let file = root.join(name);
    // rust: if !(folded && name.ends_with("Tag.json")) {
    // rust: assert_eq!(&read(&file).unwrap(), data, "{name}");
}
}
}
    // rust: check();
    // rust: assert!(!root.join("META-INF").exists());
    // rust: let damaged = root.join("assets/minecraft/textures/9.png");
    // rust: write(&damaged, &[0; 9]).unwrap();
    // rust: fs::remove_file(root.join("assets/minecraft/textures/399.png")).unwrap();
    // rust: let kept = root.join("assets/minecraft/textures/5.png");
    // rust: let before = fs::metadata(&kept).unwrap().modified().unwrap();
    // rust: assert_eq!(
    // rust: extract_client_resources(&jar, &root, None).unwrap().1,
    // rust: count
    // rust: );
    // rust: check();
    // rust: assert_eq!(fs::metadata(&kept).unwrap().modified().unwrap(), before);
    // rust: fs::remove_dir_all(dir).unwrap();
}

clones_of_a_jar_read_on_their_own :: proc() {
}
//         use std::io::Write;
    // rust: let dir = std::env::temp_dir().join(format!("horizon-prepare-jar-{}", std::process::id()));
    // rust: mkdir(&dir).unwrap();
    // rust: let path = dir.join("a.jar");
    // rust: let mut archive = zip::ZipWriter::new(fs::File::create(&path).unwrap());
    // rust: let members: Vec<(String, Vec<u8>)> = (0..3u8)
    // rust: .map(|i| {
    // rust: (
    // rust: format!("{i}.bin"),
    // rust: (0..200_000u32).map(|n| (n % 251) as u8 ^ i).collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (name, data) in &members {
    // rust: archive
    // rust: .start_file(name.as_str(), zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: archive.write_all(data).unwrap();
}
    // rust: archive.finish().unwrap();
    // rust: let mut first = open_zip(&path).unwrap();
    // rust: let mut second = first.clone();
        // Halfway through one member, the other clone reads a whole one.
    // rust: let mut entry = first.by_name("0.bin").unwrap();
    // rust: let mut start = vec![0; 1000];
    // rust: entry.read_exact(&mut start).unwrap();
    // rust: assert_eq!(zip_bytes(&mut second, "2.bin").unwrap(), members[2].1);
    // rust: let mut rest = Vec::new();
    // rust: entry.read_to_end(&mut rest).unwrap();
    // rust: start.extend(rest);
    // rust: assert_eq!(start, members[0].1);
    // rust: drop(entry);
    // rust: assert_eq!(zip_bytes(&mut first, "1.bin").unwrap(), members[1].1);
    // rust: assert_eq!(zip_names(&second).unwrap(), ["0.bin", "1.bin", "2.bin"]);
    // rust: fs::remove_dir_all(dir).unwrap();
}

member_paths_stay_inside :: proc() {
}
    // rust: assert!(member_path("assets/a.png", "bad").is_ok());
    // rust: assert!(member_path("../a", "bad").is_err());
    // rust: assert!(member_path("/a", "bad").is_err());
}
}
