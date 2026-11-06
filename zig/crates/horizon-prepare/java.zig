//! Transpiled from Horizon Rust crate
//! Module: horizon-prepare_java
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Java discovery and execution for the vanilla exporters. They call Mojang's own code, so they
//! stay Java; everything around them is here.

// use std::ffi::OsStr;
// use std::fs;
// use std::path::{Path, PathBuf};
// use std::process::{Command, Stdio};
// use std::time::{Duration, Instant};

pub const Jdk = struct {
    javac: PathBuf,
    java: PathBuf,
};

pub const TIMEOUT: Duration = Duration::from_secs(3600);

/// Options for every JVM preparing starts (the exporters, the data generator, javac with `-J`).
/// They are short batch jobs that run side by side: the C2 compiler's background work costs
/// more CPU than it wins back, and the serial collector keeps their heaps small. Measured on the
/// pinned jars, a fresh preparation took 105 s with the defaults and 63-66 s with these, same
/// output; the serial collector was as fast as the parallel one and its JVMs together took
/// 1.25 GB instead of 2 GB.
    // rust: pub(crate) const BATCH_OPTIONS: [&str; 2] = ["-XX:TieredStopAtLevel=1", "-XX:+UseSerialGC"];

/// The variables a JVM reads extra options from. A collector chosen there, such as a player's
/// global `-XX:+UseZGC`, stops a JVM started with [`BATCH_OPTIONS`]: "Multiple garbage collectors
/// selected" (#10067).
pub const JVM_OPTION_VARS: [[]const u8; 3] = ["JAVA_TOOL_OPTIONS", "_JAVA_OPTIONS", "JDK_JAVA_OPTIONS"];

/// Exporters and JDK probes write to pipes or log files: on Windows they open no terminal. They
/// run with [`BATCH_OPTIONS`] alone, whatever options the player's environment sets for Java.
    // rust: pub(crate) fn command(program: impl AsRef<OsStr>) -> Command {
    // rust: let mut command = Command::new(program);
    // rust: for var in JVM_OPTION_VARS {
    // rust: command.env_remove(var);
}
    // rust: let command = {
//         use std::os::windows::process::CommandExt;
pub const CREATE_NO_WINDOW: u32 = 0x0800_0000;
    // rust: let mut command = command;
    // rust: command.creation_flags(CREATE_NO_WINDOW);
    // rust: command
}
    // rust: command
}

pub fn executable(dir: *Path, name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: dir.join(if cfg!(windows) {
    // rust: format!("{name}.exe")
    // rust: } else {
    // rust: name.to_string()
    // rust: })
}

/// `fs::canonicalize`, without the `\\?\` prefix it gives a Windows drive path: the
/// home goes into `JAVA_HOME` and the PATH of preparers, whose lookups don't take it.
pub fn real_path(path: PathBuf) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let real = fs::canonicalize(&path).unwrap_or(path);
    // rust: if cfg!(windows) {
    // rust: without_verbatim(real)
    // rust: } else {
    // rust: real
}
}

pub fn without_verbatim(path: PathBuf) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match path.to_str().and_then(|s| s.strip_prefix(r"\\?\")) {
    // rust: Some(rest) if rest.as_bytes().get(1) == Some(&b':') => PathBuf::from(rest),
    // rust: _ => path,
}
}

/// Resolve compiler symlinks before picking its sibling runtime. The first `java` on the
/// PATH may be an older, runtime-only install; it must not be paired with a newer `javac`.
pub fn path_homes(path: *OsStr, tool: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::split_paths(path)
    // rust: .map(|dir| executable(&dir, tool))
    // rust: .filter(|javac| javac.is_file())
    // rust: .map(real_path)
    // rust: .filter_map(|javac| {
    // rust: let bin = javac.parent()?;
            // macOS's system tools are dispatchers, not a JDK home: JAVA_HOME=/usr
            // makes them call themselves. /usr/libexec/java_home finds the actual JDK.
    // rust: if bin.file_name()? != "bin"
    // rust: || (cfg!(target_os = "macos") && bin == Path::new("/usr/bin"))
    // rust: {
    // rust: return None;
}
    // rust: Some(bin.parent()?.to_path_buf())
    // rust: })
    // rust: .collect()
}

/// The major version `javac -version` or `java -version` reports, including Java 8's `1.8`.
pub fn tool_major(program: *Path, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let output = command(program)
    // rust: .arg("-version")
    // rust: .stdin(Stdio::null())
    // rust: .output()
    // rust: .map_err(|e| format!("{}: {e}", program.display()))?;
    // rust: let text = String::from_utf8_lossy(&output.stdout).into_owned()
    // rust: + &String::from_utf8_lossy(&output.stderr);
    // macOS ships /usr/bin/java and /usr/bin/javac as placeholders.
    // rust: if text.contains("Unable to locate a Java Runtime") {
    // rust: return Err(format!(
    // rust: "{} is macOS's placeholder (no Java installed)",
    // rust: program.display()
    // rust: ));
}
    // rust: if !output.status.success() {
    // rust: return Err(format!(
    // rust: "{} -version failed ({}): {}",
    // rust: program.display(),
    // rust: output.status,
    // rust: text.trim()
    // rust: ));
}
    // rust: let marker = if name == "javac" { "javac" } else { "version" };
    // rust: let version = text
    // rust: .split_whitespace()
    // rust: .skip_while(|w| *w != marker)
    // rust: .nth(1)
    // rust: .ok_or_else(|| {
    // rust: format!(
    // rust: "{} -version printed no version: {}",
    // rust: program.display(),
    // rust: text.trim()
    // rust: )
    // rust: })?;
    // rust: let mut parts = version.trim_matches('"').split(['.', '-', '+', '_']);
    // rust: let first: u32 = parts.next().and_then(|p| p.parse().ok()).unwrap_or(0);
    // rust: Ok(if first == 1 {
    // rust: parts.next().and_then(|p| p.parse().ok()).unwrap_or(0)
    // rust: } else {
    // rust: first
    // rust: })
}

/// The folders JDK installers and tools put JDKs in, each JDK one folder below (#666: a
/// player installed Java 25 but JAVA_HOME and the PATH still named an older one).
pub fn jdk_parents() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let var = |name: &str| {
    // rust: std::env::var_os(name)
    // rust: .filter(|v| !v.is_empty())
    // rust: .map(PathBuf::from)
}
    // rust: let home = var(if cfg!(windows) { "USERPROFILE" } else { "HOME" });
    // rust: let mut parents = Vec::new();
    // rust: if cfg!(windows) {
    // rust: let vendors = [
    // rust: "Eclipse Adoptium",
    // rust: "Java",
    // rust: "Microsoft",
    // rust: "Zulu",
    // rust: "BellSoft",
    // rust: "Amazon Corretto",
    // rust: "Semeru",
    // rust: "OpenJDK",
    // rust: ];
    // rust: for base in ["ProgramFiles", "ProgramW6432"].into_iter().filter_map(var) {
    // rust: parents.extend(vendors.iter().map(|v| base.join(v)));
}
    // rust: } else if cfg!(target_os = "macos") {
    // rust: parents.push(PathBuf::from("/Library/Java/JavaVirtualMachines"));
    // rust: parents.extend(
    // rust: home.iter()
    // rust: .map(|h| h.join("Library/Java/JavaVirtualMachines")),
    // rust: );
    // rust: } else {
    // rust: parents.extend(["/usr/lib/jvm", "/usr/java", "/usr/local/lib/jvm"].map(PathBuf::from));
}
    // rust: parents.extend(
    // rust: home.iter()
    // rust: .flat_map(|h| [h.join(".jdks"), h.join(".sdkman/candidates/java")]),
    // rust: );
    // rust: parents
}

/// The JDKs (folders with `bin/javac`) one level below `parents`; a macOS bundle's home is
/// its `Contents/Home`. Those named for `major` come first, then the others newest name first.
pub fn installed_jdks(parents: *[PathBuf], major: i64, tool: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut homes: Vec<PathBuf> = parents
    // rust: .iter()
    // rust: .filter_map(|parent| fs::read_dir(parent).ok())
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|entry| {
    // rust: let bundle = entry.path().join("Contents/Home");
    // rust: if bundle.is_dir() {
    // rust: bundle
    // rust: } else {
    // rust: entry.path()
}
    // rust: })
    // rust: .filter(|home| executable(&home.join("bin"), tool).is_file())
    // rust: .collect();
    // rust: let named = |home: &Path| {
    // rust: home.iter().any(|part| {
    // rust: part.to_string_lossy()
    // rust: .split(|c: char| !c.is_ascii_digit())
    // rust: .any(|n| n == major.to_string())
    // rust: })
}
    // rust: homes.sort_by(|a, b| named(b).cmp(&named(a)).then_with(|| b.cmp(a)));
    // rust: homes.dedup();
    // rust: homes
}

/// The Java runtimes the official launcher downloaded into `runtime` (a game directory's
/// `runtime` folder: `<component>/<platform>/<component>/`, a macOS one in `jre.bundle`).
pub fn minecraft_runtimes(runtime: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let children = |dir: &Path| -> Vec<PathBuf> {
    // rust: let mut paths: Vec<PathBuf> = fs::read_dir(dir)
    // rust: .map(|entries| entries.flatten().map(|e| e.path()).collect())
    // rust: .unwrap_or_default();
    // rust: paths.sort();
    // rust: paths
}
    // rust: let mut homes = Vec::new();
    // rust: for component in children(runtime) {
    // rust: for platform in children(&component) {
    // rust: let home = platform.join(component.file_name().unwrap_or_default());
    // rust: for home in [home.join("jre.bundle/Contents/Home"), home] {
    // rust: if executable(&home.join("bin"), "java").is_file() {
    // rust: homes.push(home);
    // rust: break;
}
}
}
}
    // rust: homes
}

/// Finds a JDK whose compiler and runtime are both at least `major`, the version
/// research-lock.json pins: `JAVA_HOME`, else JDKs on the PATH, else, on macOS, the JDK
/// `/usr/libexec/java_home -v <major>` reports, else the homes in `more` (the launcher's pick,
/// Minecraft's own runtimes), else the folders installers use (`jdk_parents`).
pub fn find(major: i64, more: *[PathBuf]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: find_tools(major, more, true)
}

/// Finds a compatible runtime; precompiled exporters do not need javac.
pub fn find_runtime(major: i64, more: *[PathBuf]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: find_tools(major, more, false)
}

pub fn find_tools(major: i64, more: *[PathBuf], compiler: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tool = if compiler { "javac" } else { "java" };
    // rust: let need = format!(
    // rust: "Java {major} is needed ({tool}, e.g. Eclipse Temurin {major}). \
    // rust: Install it, or set JAVA_HOME to it, and try again."
    // rust: );
    // rust: let mut candidates = Vec::new();
    // rust: if let Some(home) = std::env::var_os("JAVA_HOME").filter(|h| !h.is_empty()) {
    // rust: let bin = Path::new(&home).join("bin");
    // rust: candidates.push((
    // rust: executable(&bin, "javac"),
    // rust: executable(&bin, "java"),
    // rust: "JAVA_HOME",
    // rust: ));
}
    // rust: if let Some(path) = std::env::var_os("PATH") {
    // rust: for home in path_homes(&path, tool) {
    // rust: let bin = home.join("bin");
    // rust: candidates.push((executable(&bin, "javac"), executable(&bin, "java"), "PATH"));
}
}
    // rust: if cfg!(target_os = "macos") {
    // rust: if let Ok(out) = command("/usr/libexec/java_home")
    // rust: .args(["-v", &major.to_string()])
    // rust: .stderr(Stdio::null())
    // rust: .output()
    // rust: {
    // rust: let home = String::from_utf8_lossy(&out.stdout).trim().to_string();
    // rust: if out.status.success() && !home.is_empty() {
    // rust: let bin = Path::new(&home).join("bin");
    // rust: candidates.push((
    // rust: executable(&bin, "javac"),
    // rust: executable(&bin, "java"),
    // rust: "/usr/libexec/java_home",
    // rust: ));
}
}
}
    // rust: for home in more {
    // rust: let bin = home.join("bin");
    // rust: candidates.push((
    // rust: executable(&bin, "javac"),
    // rust: executable(&bin, "java"),
    // rust: "Minecraft's Java",
    // rust: ));
}
    // rust: for home in installed_jdks(&jdk_parents(), major, tool) {
    // rust: let bin = home.join("bin");
    // rust: candidates.push((
    // rust: executable(&bin, "javac"),
    // rust: executable(&bin, "java"),
    // rust: "an installed JDK",
    // rust: ));
}
    // rust: let mut problems = Vec::new();
    // rust: for (javac, java, from) in candidates {
    // rust: if (compiler && !javac.is_file()) || !java.is_file() {
    // rust: problems.push(format!(
    // rust: "{from} ({}) has no compatible Java tools",
    // rust: javac.parent().unwrap().display()
    // rust: ));
    // rust: continue;
}
    // rust: let checked = [(&javac, "javac"), (&java, "java")]
    // rust: .into_iter()
    // rust: .filter(|(_, name)| compiler || *name == "java")
    // rust: .try_for_each(|(program, name)| {
    // rust: let found = tool_major(program, name)?;
    // rust: if i64::from(found) >= major {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("{name} {found} ({})", program.display()))
}
    // rust: });
    // rust: match checked {
            // Absolute: the exporters run in another working directory, where a relative
            // `JAVA_HOME`, `--java-home` or `PATH` entry would name nothing.
    // rust: Ok(()) => {
    // rust: return Ok(Jdk {
    // rust: javac: std::path::absolute(&javac).unwrap_or(javac),
    // rust: java: std::path::absolute(&java).unwrap_or(java),
    // rust: });
}
    // rust: Err(e) => problems.push(format!("{from}: {e}")),
}
}
    // rust: if problems.is_empty() {
    // rust: Err(format!("{need} No {tool} was found."))
    // rust: } else {
    // rust: Err(format!("{need} Found: {}.", problems.join("; ")))
}
}

/// A classpath with the platform's separator.
    // rust: pub fn classpath<'a>(paths: impl IntoIterator<Item = &'a Path>) -> String {
    // rust: let separator = if cfg!(windows) { ";" } else { ":" };
    // rust: paths
    // rust: .into_iter()
    // rust: .map(|p| p.to_string_lossy().into_owned())
    // rust: .collect::<Vec<_>>()
    // rust: .join(separator)
}

    // rust: impl Jdk {
    /// The JDK's home, the folder above `bin` (what `JAVA_HOME` names).
pub fn home(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.java
    // rust: .parent()
    // rust: .and_then(Path::parent)
    // rust: .map(Path::to_path_buf)
    // rust: .unwrap_or_default()
}

    /// `javac --release <major> -proc:none` with Python's `subprocess.run(..., check=True,
    /// stdout=log, stderr=STDOUT, timeout=3600)`.
pub fn javac(self: *Self, major: i64, args: *[[]const u8], log: *fs::File) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut command = command(&self.javac);
    // rust: command
    // rust: .args(BATCH_OPTIONS.map(|option| format!("-J{option}")))
    // rust: .args(["--release", &major.to_string(), "-proc:none"])
    // rust: .args(args);
    // rust: run(command, log)
}

pub fn java(self: *Self, args: *[[]const u8], cwd: ?*Path, log: *fs::File) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut command = command(&self.java);
    // rust: command.args(BATCH_OPTIONS).args(args);
    // rust: if let Some(dir) = cwd {
    // rust: command.current_dir(dir);
}
    // rust: run(command, log)
}
}

pub fn run(mut command: Command, log: *fs::File) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let out = log.try_clone().map_err(|e| e.to_string())?;
    // rust: let err = log.try_clone().map_err(|e| e.to_string())?;
    // rust: let program = Path::new(command.get_program())
    // rust: .file_name()
    // rust: .unwrap_or_default()
    // rust: .to_string_lossy()
    // rust: .into_owned();
    // rust: let mut child = command
    // rust: .stdin(Stdio::null())
    // rust: .stdout(out)
    // rust: .stderr(err)
    // rust: .spawn()
    // rust: .map_err(|e| format!("Cannot start {program}: {e}"))?;
    // rust: let start = Instant::now();
    // rust: loop {
    // rust: if let Some(status) = child.try_wait().map_err(|e| e.to_string())? {
    // rust: return if status.success() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("{program} failed ({status})"))
}
}
    // rust: if start.elapsed() > TIMEOUT {
    // rust: let _ = child.kill();
    // rust: let _ = child.wait();
    // rust: return Err(format!("{program} took over an hour and was stopped"));
}
    // rust: std::thread::sleep(Duration::from_millis(50));
}
}

    // rust: mod tests {
//     use super::*;

pub fn jvms_ignore_the_players_global_options() void {
}
    // rust: let command = command("java");
    // rust: for var in JVM_OPTION_VARS {
    // rust: assert!(
    // rust: command
    // rust: .get_envs()
    // rust: .any(|(name, value)| name == var && value.is_none()),
    // rust: "{var} reaches the JVM"
    // rust: );
}
}

pub fn verbatim_drive_paths_lose_their_prefix() void {
}
    // rust: let jdk = r"C:\Program Files\Eclipse Adoptium\jdk-25\bin\javac.exe";
    // rust: assert_eq!(
    // rust: without_verbatim(PathBuf::from(format!(r"\\?\{jdk}"))),
    // rust: PathBuf::from(jdk)
    // rust: );
        // A UNC share keeps its verbatim form: stripping it would leave no valid path.
    // rust: let unc = r"\\?\UNC\server\jdk\bin\javac.exe";
    // rust: assert_eq!(without_verbatim(PathBuf::from(unc)), PathBuf::from(unc));
    // rust: assert_eq!(
    // rust: without_verbatim(PathBuf::from("/usr/lib/jvm/bin/javac")),
    // rust: PathBuf::from("/usr/lib/jvm/bin/javac")
    // rust: );
}

pub fn installed_jdks_prefer_the_pinned_major() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-prepare-jdks-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: let parent = dir.join("Eclipse Adoptium");
    // rust: for jdk in [
    // rust: "jdk-21.0.5.11-hotspot",
    // rust: "jdk-25.0.1.8-hotspot",
    // rust: "jdk-26.0.0-hotspot",
    // rust: "jre-25.0.1",
    // rust: ] {
    // rust: let bin = parent.join(jdk).join("bin");
    // rust: fs::create_dir_all(&bin).unwrap();
    // rust: if jdk.starts_with("jdk") {
    // rust: fs::write(executable(&bin, "javac"), b"").unwrap();
}
}
        // A macOS bundle keeps its home in Contents/Home.
    // rust: let bundle = dir.join("JavaVirtualMachines/temurin-25.jdk/Contents/Home");
    // rust: fs::create_dir_all(bundle.join("bin")).unwrap();
    // rust: fs::write(executable(&bundle.join("bin"), "javac"), b"").unwrap();
    // rust: let found = installed_jdks(
    // rust: &[
    // rust: parent.clone(),
    // rust: dir.join("JavaVirtualMachines"),
    // rust: dir.join("missing"),
    // rust: ],
    // rust: 25,
    // rust: "javac",
    // rust: );
    // rust: assert_eq!(
    // rust: found,
    // rust: [
    // rust: bundle,
    // rust: parent.join("jdk-25.0.1.8-hotspot"),
    // rust: parent.join("jdk-26.0.0-hotspot"),
    // rust: parent.join("jdk-21.0.5.11-hotspot"),
    // rust: ]
    // rust: );
    // rust: fs::remove_dir_all(&dir).unwrap();
}

pub fn minecraft_runtimes_are_found_in_the_launchers_layout() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-prepare-runtimes-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: let make = |home: PathBuf, javac: bool| {
    // rust: fs::create_dir_all(home.join("bin")).unwrap();
    // rust: if javac {
    // rust: fs::write(executable(&home.join("bin"), "java"), b"").unwrap();
}
    // rust: home
}
    // rust: let gamma = make(
    // rust: dir.join("java-runtime-gamma/linux/java-runtime-gamma"),
    // rust: true,
    // rust: );
    // rust: let epsilon = make(
    // rust: dir.join(
    // rust: "java-runtime-epsilon/mac-os-arm64/java-runtime-epsilon/jre.bundle/Contents/Home",
    // rust: ),
    // rust: true,
    // rust: );
    // rust: make(dir.join("jre-legacy/linux/jre-legacy"), false);
    // rust: assert_eq!(minecraft_runtimes(&dir), [epsilon, gamma]);
    // rust: assert!(minecraft_runtimes(&dir.join("missing")).is_empty());
    // rust: fs::remove_dir_all(&dir).unwrap();
}
}
