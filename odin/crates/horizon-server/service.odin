//! Transpiled from Horizon Rust crate
package horizon_server_service

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-server service install|uninstall|print`: run the server at boot or login under the system's own
// service manager (docs/server.md, section 3): a systemd unit on Linux, a launchd agent on macOS, a task at
// logon on Windows. The service runs `horizon-server run`, which restarts the game if it crashes; the
// service manager restarts the supervisor itself.

// use std::{
    // rust: path::{Path, PathBuf},
    // rust: process::Command,
}

// The service's name for a server folder: `horizon-server-<folder>`, in letters, digits and dashes.
name :: proc(dir: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let folder = dir
    // rust: .file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_default();
    // rust: let mut clean: String = folder
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_alphanumeric() {
    // rust: c.to_ascii_lowercase()
    // rust: } else {
    // rust: '-'
}
    // rust: })
    // rust: .collect();
    // rust: clean = clean.trim_matches('-').to_owned();
    // rust: if clean.is_empty() {
    // rust: clean = "server".into();
}
    // rust: format!("horizon-server-{clean}")
}

// The program the service runs: the `horizon-server` on the PATH (the installer's launcher, which keeps
// running the current version after an update), else this program, through the installer's `current`
// link when it runs from an installed release.
program :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let on_path = std::env::var_os("PATH")
    // rust: .map(|p| std::env::split_paths(&p).collect::<Vec<_>>())
    // rust: .unwrap_or_default()
    // rust: .into_iter()
    // rust: .map(|d| d.join(format!("horizon-server{}", std::env::consts::EXE_SUFFIX)))
    // rust: .find(|p| p.is_file());
    // rust: match on_path {
    // rust: Some(path) => Ok(path),
    // rust: None => std::env::current_exe()
    // rust: .map(|exe| through_current(&exe))
    // rust: .map_err(|e| e.to_string()),
}
}

// `<dir>/releases/<tag>/horizon-server` as `<dir>/current/horizon-server` while `current` points at that
// release (install.sh and install.ps1's layout), so an update applies at the next restart. Linux reports
// the running program with links resolved, so the release's own path is what this program sees there.
through_current :: proc(exe: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let current = (|| {
    // rust: let release = exe.parent()?;
    // rust: let releases = release.parent()?;
    // rust: if releases.file_name()? != "releases" {
    // rust: return None;
}
    // rust: let current = releases.parent()?.join("current");
    // rust: let name = exe.file_name()?;
    // rust: let same = std::fs::canonicalize(&current).ok()? == std::fs::canonicalize(release).ok()?;
    // rust: same.then(|| current.join(name))
    // rust: })();
    // rust: current.unwrap_or_else(|| exe.to_path_buf())
}

// A systemd unit: a user unit, or with `user` a system unit running as that user.
systemd_unit :: proc(program: ^Path, dir: ^Path, user: Maybe(string)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (run_as, wanted_by) = match user {
    // rust: Some(user) => (format!("User={user}\n"), "multi-user.target"),
    // rust: None => (String::new(), "default.target"),
}
    // rust: format!(
    // rust: "[Unit]
    // rust: Description=Horizon server in {dir}
    // rust: Documentation=https://github.com/horizon-rust/horizon/blob/main/docs/server.md
    // rust: Wants=network-online.target
    // rust: After=network-online.target

    // rust: [Service]
    // rust: Type=simple
    // rust: {run_as}WorkingDirectory={dir}
    // rust: ExecStart=\"{program}\" --dir \"{dir}\" run
    // rust: # SIGTERM makes the supervisor stop the game cleanly; saving a big world takes a moment.
    // rust: TimeoutStopSec=180
    // rust: Restart=on-failure
    // rust: RestartSec=10

    // rust: [Install]
    // rust: WantedBy={wanted_by}
    // rust: ",
    // rust: dir = dir.display(),
    // rust: program = program.display(),
    // rust: )
}

xml :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: text.replace('&', "&amp;")
    // rust: .replace('<', "&lt;")
    // rust: .replace('>', "&gt;")
}

// A launchd agent: started at login, and again if the supervisor exits with an error.
launchd_plist :: proc(label: string, program: ^Path, dir: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let log = dir.join("logs/supervisor.log");
    // rust: format!(
    // rust: r#"<?xml version="1.0" encoding="UTF-8"?>
    // rust: <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    // rust: <plist version="1.0">
    // rust: <dict>
    // rust: <key>Label</key>
    // rust: <string>{label}</string>
    // rust: <key>ProgramArguments</key>
    // rust: <array>
    // rust: <string>{program}</string>
    // rust: <string>--dir</string>
    // rust: <string>{dir}</string>
    // rust: <string>run</string>
    // rust: </array>
    // rust: <key>WorkingDirectory</key>
    // rust: <string>{dir}</string>
    // rust: <key>RunAtLoad</key>
    // rust: <true/>
    // rust: <key>KeepAlive</key>
    // rust: <dict>
    // rust: <key>SuccessfulExit</key>
    // rust: <false/>
    // rust: </dict>
    // rust: <key>ExitTimeOut</key>
    // rust: <integer>180</integer>
    // rust: <key>StandardOutPath</key>
    // rust: <string>{log}</string>
    // rust: <key>StandardErrorPath</key>
    // rust: <string>{log}</string>
    // rust: </dict>
    // rust: </plist>
    // rust: "#,
    // rust: program = xml(&program.display().to_string()),
    // rust: dir = xml(&dir.display().to_string()),
    // rust: log = xml(&log.display().to_string()),
    // rust: )
}

// The account the Windows task runs as and starts with: `DOMAIN\user`.
windows_user :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let user = std::env::var("USERNAME").map_err(|_| "USERNAME is not set".to_string())?;
    // rust: Ok(match std::env::var("USERDOMAIN") {
    // rust: Ok(domain) if !domain.is_empty() => format!("{domain}\\{user}"),
    // rust: _ => user,
    // rust: })
}

// A Task Scheduler task that starts the supervisor when `user` logs on, as that user and without
// elevation, and again a minute after it exits with an error. Unlike `schtasks /Create`'s defaults it
// has no 72-hour time limit and also starts on battery power.
windows_task_xml :: proc(user: string, program: ^Path, dir: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: r#"<?xml version="1.0" encoding="UTF-16"?>
    // rust: <Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
    // rust: <RegistrationInfo>
    // rust: <Description>Horizon server in {dir}</Description>
    // rust: </RegistrationInfo>
    // rust: <Triggers>
    // rust: <LogonTrigger>
    // rust: <Enabled>true</Enabled>
    // rust: <UserId>{user}</UserId>
    // rust: </LogonTrigger>
    // rust: </Triggers>
    // rust: <Principals>
    // rust: <Principal id="Author">
    // rust: <UserId>{user}</UserId>
    // rust: <LogonType>InteractiveToken</LogonType>
    // rust: <RunLevel>LeastPrivilege</RunLevel>
    // rust: </Principal>
    // rust: </Principals>
    // rust: <Settings>
    // rust: <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    // rust: <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    // rust: <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    // rust: <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
    // rust: <RestartOnFailure>
    // rust: <Interval>PT1M</Interval>
    // rust: <Count>999</Count>
    // rust: </RestartOnFailure>
    // rust: <Enabled>true</Enabled>
    // rust: </Settings>
    // rust: <Actions Context="Author">
    // rust: <Exec>
    // rust: <Command>{program}</Command>
    // rust: <Arguments>--dir "{dir}" run</Arguments>
    // rust: </Exec>
    // rust: </Actions>
    // rust: </Task>
    // rust: "#,
    // rust: user = xml(user),
    // rust: program = xml(&program.display().to_string()),
    // rust: dir = xml(&dir.display().to_string()),
    // rust: )
}

// `schtasks /XML` reads only UTF-16 files: little-endian, after a byte order mark.
utf16_with_bom :: proc(text: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::iter::once(0xfeff)
    // rust: .chain(text.encode_utf16())
    // rust: .flat_map(u16::to_le_bytes)
    // rust: .collect()
}

home :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: std::env::var_os("HOME")
    // rust: .map(PathBuf::from)
    // rust: .ok_or_else(|| "HOME is not set".into())
}

launchd_path :: proc(label: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(home()?
    // rust: .join("Library/LaunchAgents")
    // rust: .join(format!("{label}.plist")))
}

launchd_label :: proc(dir: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "dev.horizon.server.{}",
    // rust: name(dir).trim_start_matches("horizon-server-")
    // rust: )
}

systemd_path :: proc(service: string, system: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(if system {
    // rust: PathBuf::from("/etc/systemd/system")
    // rust: } else {
    // rust: std::env::var_os("XDG_CONFIG_HOME")
    // rust: .map_or_else(
    // rust: || home().map(|h| h.join(".config")),
    // rust: |c| Ok(PathBuf::from(c)),
    // rust: )?
    // rust: .join("systemd/user")
}
    // rust: .join(format!("{service}.service")))
}

run :: proc(program: string, args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let status = crate::process::command(program)
    // rust: .args(args)
    // rust: .status()
    // rust: .map_err(|e| format!("{program}: {e}"))?;
    // rust: if status.success() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("`{program} {}` failed ({status})", args.join(" ")))
}
}

// A step that may fail harmlessly (stopping what isn't running): its output would only alarm.
quiet :: proc(program: string, args: ^[string]) {
}
    // rust: let _ = crate::process::command(program)
    // rust: .args(args)
    // rust: .stdout(std::process::Stdio::null())
    // rust: .stderr(std::process::Stdio::null())
    // rust: .status();
}

// What `service print` shows and `service install` writes, and where.
definition :: proc(dir: ^Path, system: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let program = program()?;
    // rust: if cfg!(target_os = "macos") {
    // rust: if system {
    // rust: return Err("on macOS the server runs as a login agent: drop --system".into());
}
    // rust: let label = launchd_label(dir);
    // rust: Ok((launchd_path(&label)?, launchd_plist(&label, &program, dir)))
    // rust: } else if cfg!(windows) {
    // rust: Err(
    // rust: "on Windows, `service install` creates a task at logon; there is no file to print"
    // rust: .into(),
    // rust: )
    // rust: } else {
    // rust: let user = system.then(|| std::env::var("USER").unwrap_or_else(|_| "root".into()));
    // rust: Ok((
    // rust: systemd_path(&name(dir), system)?,
    // rust: systemd_unit(&program, dir, user.as_deref()),
    // rust: ))
}
}

command :: proc(dir: ^Path, args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let dir = dir
    // rust: .canonicalize()
    // rust: .map_err(|e| format!("{}: {e}", dir.display()))?;
    // rust: crate::config::Config::load(&dir)?;
    // rust: let system = args.iter().any(|a| a == "--system");
    // rust: let service = name(&dir);
    // rust: match args.first().map(String::as_str) {
    // rust: Some("print") => {
    // rust: let (path, text) = definition(&dir, system)?;
    // rust: println!("# {}\n{text}", path.display());
    // rust: Ok(())
}
    // rust: Some("install") => install(&dir, &service, system),
    // rust: Some("uninstall") => uninstall(&dir, &service, system),
    // rust: _ => Err("use: service install|uninstall|print [--system]".into()),
}
}

install :: proc(dir: ^Path, service: string, system: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(windows) {
        // `/SC ONLOGON` makes a trigger for every user's logon, which only an administrator may
        // create ("Access is denied" otherwise). A task defined in XML can name the user instead.
    // rust: let task = windows_task_xml(&windows_user()?, &program()?, dir);
    // rust: let file = std::env::temp_dir().join(format!("{service}.xml"));
    // rust: std::fs::write(&file, utf16_with_bom(&task))
    // rust: .map_err(|e| format!("{}: {e}", file.display()))?;
    // rust: let created = run(
    // rust: "schtasks",
    // rust: &[
    // rust: "/Create",
    // rust: "/TN",
    // rust: service,
    // rust: "/XML",
    // rust: &file.display().to_string(),
    // rust: "/F",
    // rust: ],
    // rust: );
    // rust: let _ = std::fs::remove_file(&file);
    // rust: created?;
    // rust: run("schtasks", &["/Run", "/TN", service])?;
    // rust: println!("Installed the task {service}: the server starts when you log in, and now.");
    // rust: return Ok(());
}
    // rust: let (path, text) = definition(dir, system)?;
    // rust: if let Some(parent) = path.parent() {
    // rust: std::fs::create_dir_all(parent).map_err(|e| format!("{}: {e}", parent.display()))?;
}
    // rust: std::fs::create_dir_all(dir.join("logs")).map_err(|e| e.to_string())?;
    // rust: std::fs::write(&path, text).map_err(|e| {
    // rust: format!(
    // rust: "{}: {e}{}",
    // rust: path.display(),
    // rust: if system { " (--system needs sudo)" } else { "" }
    // rust: )
    // rust: })?;
    // rust: if cfg!(target_os = "macos") {
    // rust: let uid = String::from_utf8_lossy(
    // rust: &Command::new("id")
    // rust: .arg("-u")
    // rust: .output()
    // rust: .map_err(|e| e.to_string())?
    // rust: .stdout,
    // rust: )
    // rust: .trim()
    // rust: .to_owned();
    // rust: quiet(
    // rust: "launchctl",
    // rust: &[
    // rust: "bootout",
    // rust: &format!("gui/{uid}"),
    // rust: &path.display().to_string(),
    // rust: ],
    // rust: );
    // rust: run(
    // rust: "launchctl",
    // rust: &[
    // rust: "bootstrap",
    // rust: &format!("gui/{uid}"),
    // rust: &path.display().to_string(),
    // rust: ],
    // rust: )?;
    // rust: println!(
    // rust: "Installed {}: the server starts at login, and now. Its output: logs/supervisor.log",
    // rust: path.display()
    // rust: );
    // rust: } else {
    // rust: let scope: &[&str] = if system { &[] } else { &["--user"] };
    // rust: run("systemctl", &[scope, &["daemon-reload"]].concat())?;
    // rust: run(
    // rust: "systemctl",
    // rust: &[scope, &["enable", "--now", service]].concat(),
    // rust: )?;
    // rust: println!(
    // rust: "Installed {}: the server starts at boot, and now.",
    // rust: path.display()
    // rust: );
    // rust: if !system {
    // rust: println!(
    // rust: "To keep it running while you are logged out: loginctl enable-linger $USER. \
    // rust: Its log: journalctl --user -u {service}"
    // rust: );
}
}
    // rust: Ok(())
}

uninstall :: proc(dir: ^Path, service: string, system: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(windows) {
    // rust: quiet("schtasks", &["/End", "/TN", service]);
    // rust: run("schtasks", &["/Delete", "/TN", service, "/F"])?;
    // rust: println!("Removed the task {service}.");
    // rust: return Ok(());
}
    // rust: let (path, _) = definition(dir, system)?;
    // rust: if cfg!(target_os = "macos") {
    // rust: let uid = String::from_utf8_lossy(
    // rust: &Command::new("id")
    // rust: .arg("-u")
    // rust: .output()
    // rust: .map_err(|e| e.to_string())?
    // rust: .stdout,
    // rust: )
    // rust: .trim()
    // rust: .to_owned();
    // rust: quiet(
    // rust: "launchctl",
    // rust: &[
    // rust: "bootout",
    // rust: &format!("gui/{uid}"),
    // rust: &path.display().to_string(),
    // rust: ],
    // rust: );
    // rust: } else {
    // rust: let scope: &[&str] = if system { &[] } else { &["--user"] };
    // rust: quiet(
    // rust: "systemctl",
    // rust: &[scope, &["disable", "--now", service]].concat(),
    // rust: );
}
    // rust: std::fs::remove_file(&path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: if !cfg!(target_os = "macos") {
    // rust: let scope: &[&str] = if system { &[] } else { &["--user"] };
    // rust: quiet("systemctl", &[scope, &["daemon-reload"]].concat());
}
    // rust: println!(
    // rust: "Removed {}; the server's folder is untouched.",
    // rust: path.display()
    // rust: );
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

names_follow_the_folder :: proc() {
}
    // rust: assert_eq!(
    // rust: name(Path::new("/srv/My Server!")),
    // rust: "horizon-server-my-server"
    // rust: );
    // rust: assert_eq!(name(Path::new("/")), "horizon-server-server");
}

units_run_the_supervisor :: proc() {
}
    // rust: let unit = systemd_unit(
    // rust: Path::new("/home/a/.local/bin/horizon-server"),
    // rust: Path::new("/srv/mc"),
    // rust: Some("mc"),
    // rust: );
    // rust: assert!(
    // rust: unit.contains("ExecStart=\"/home/a/.local/bin/horizon-server\" --dir \"/srv/mc\" run")
    // rust: );
    // rust: assert!(unit.contains("User=mc\n"));
    // rust: assert!(unit.contains("WantedBy=multi-user.target"));
    // rust: let dir = Path::new("/srv/R&D");
    // rust: let plist = launchd_plist(
    // rust: "dev.horizon.server.mc",
    // rust: Path::new("/opt/h/horizon-server"),
    // rust: dir,
    // rust: );
    // rust: assert!(plist.contains("<string>/srv/R&amp;D</string>"));
        // The log is `dir.join("logs/supervisor.log")`, which a `Path` prints with the host's own
        // separator where it adds one (a `\` on Windows), and the `&` of the folder's name is escaped.
    // rust: let log = dir
    // rust: .join("logs/supervisor.log")
    // rust: .display()
    // rust: .to_string()
    // rust: .replace('&', "&amp;");
    // rust: assert!(plist.contains(&format!("<string>{log}</string>")));
        // Where the separator is `/`, the path is the one a launchd agent has on macOS.
    // rust: assert!(plist.contains("<string>/srv/R&amp;D/logs/supervisor.log</string>"));
}

windows_tasks_start_at_the_users_own_logon :: proc() {
}
    // rust: let task = windows_task_xml(
    // rust: r"PC\ann",
    // rust: Path::new(r"C:\Users\ann\horizon-server.exe"),
    // rust: Path::new(r"C:\Servers\R&D"),
    // rust: );
        // A logon trigger without a user is every user's, which needs an administrator.
    // rust: assert!(task.contains(
    // rust: "<LogonTrigger>\n      <Enabled>true</Enabled>\n      <UserId>PC\\ann</UserId>"
    // rust: ));
    // rust: assert!(task.contains("<UserId>PC\\ann</UserId>\n      <LogonType>InteractiveToken"));
    // rust: assert!(task.contains("<RunLevel>LeastPrivilege</RunLevel>"));
    // rust: assert!(task.contains(r"<Command>C:\Users\ann\horizon-server.exe</Command>"));
    // rust: assert!(task.contains(r#"<Arguments>--dir "C:\Servers\R&amp;D" run</Arguments>"#));
    // rust: assert!(task.contains("<ExecutionTimeLimit>PT0S</ExecutionTimeLimit>"));
    // rust: assert_eq!(
    // rust: utf16_with_bom("<a>"),
    // rust: [0xff, 0xfe, b'<', 0, b'a', 0, b'>', 0]
    // rust: );
}

    // Creates and deletes a real task as this user, unelevated, as the launcher's toggle does.
    // By hand on Windows: `cargo test -p horizon-server -- --ignored windows_task`.
windows_task_installs_without_elevation :: proc() {
}
    // rust: let name = format!("horizon-server-test-{}", std::process::id());
    // rust: let task = windows_task_xml(
    // rust: &windows_user().unwrap(),
    // rust: Path::new(r"C:\Windows\System32\cmd.exe"),
    // rust: &std::env::temp_dir(),
    // rust: );
    // rust: let file = std::env::temp_dir().join(format!("{name}.xml"));
    // rust: std::fs::write(&file, utf16_with_bom(&task)).unwrap();
    // rust: let created = run(
    // rust: "schtasks",
    // rust: &[
    // rust: "/Create",
    // rust: "/TN",
    // rust: &name,
    // rust: "/XML",
    // rust: &file.display().to_string(),
    // rust: "/F",
    // rust: ],
    // rust: );
    // rust: std::fs::remove_file(&file).unwrap();
    // rust: created.unwrap();
    // rust: run("schtasks", &["/Delete", "/TN", &name, "/F"]).unwrap();
}

an_installed_release_runs_through_current :: proc() {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-service-current-{}", std::process::id()));
    // rust: let release = root.join("releases/v1");
    // rust: std::fs::create_dir_all(&release).unwrap();
    // rust: let exe = release.join("horizon-server");
    // rust: std::fs::write(&exe, "").unwrap();
        // Not the release in use (or no installer layout): this program as it is.
    // rust: assert_eq!(through_current(&exe), exe);
    // rust: std::os::unix::fs::symlink(&release, root.join("current")).unwrap();
    // rust: assert_eq!(through_current(&exe), root.join("current/horizon-server"));
    // rust: let other = root.join("bin/horizon-server");
    // rust: assert_eq!(through_current(&other), other);
    // rust: std::fs::remove_dir_all(&root).unwrap();
}
}
