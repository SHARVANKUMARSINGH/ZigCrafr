//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_system
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The machine as an item describes it ([`System`]): what the OS says, read the same way on
//! every start. The game adds the GPU (its name, maker, kind, driver and backend, then
//! [`vram_mb`] for it) and the screen.
//!
//! Only what explains performance: no serial number, host name, user name or path is read into
//! an item. The slower probes (a command to run) are read once per process.
// use std::path::Path;
// use std::sync::OnceLock;

// use crate::payload::System;

/// What `program args` prints, trimmed, when it succeeds and prints something. On Windows the
/// program opens no console window: a GUI launcher or a game started without one would flash a
/// terminal for every probe.
pub fn command_output(program: []const u8, args: *[[]const u8]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut command = std::process::Command::new(program);
    // rust: command.args(args);
    // rust: {
//         use std::os::windows::process::CommandExt;
pub const CREATE_NO_WINDOW: u32 = 0x0800_0000;
    // rust: command.creation_flags(CREATE_NO_WINDOW);
}
    // rust: let out = command.output().ok()?;
    // rust: let text = String::from_utf8_lossy(&out.stdout).trim().to_owned();
    // rust: (out.status.success() && !text.is_empty()).then_some(text)
}

/// `Windows 11 (26100.2033)`: the build numbers from the registry. `cmd /C ver`
/// prints the display language's own word for "Version" in the console's OEM
/// code page, so the same build read as UTF-8 carries U+FFFD in it and differs
/// between two machines running the same build.
pub fn windows_version() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !cfg!(windows) {
    // rust: return None;
}
pub const KEY: []const u8 = r"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion";
    // rust: let value = |name: &str| command_output("reg", &["query", KEY, "/v", name]);
    // rust: windows_version_text(&value("CurrentBuild")?, value("UBR").as_deref())
}

/// The build and its update revision from the last column of two `reg query`
/// replies (`CurrentBuild    REG_SZ    26100`, `UBR    REG_DWORD    0x7f1`).
/// Build 22000 is the first Windows 11.
pub fn windows_version_text(build: []const u8, ubr: ?[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let build = number(last_column(build)?)?;
    // rust: let release = if build >= 22_000 { "11" } else { "10" };
    // rust: Some(match ubr.and_then(last_column).and_then(number) {
    // rust: Some(ubr) => format!("Windows {release} ({build}.{ubr})"),
    // rust: None => format!("Windows {release} ({build})"),
    // rust: })
}

/// The value a `reg query` reply prints in its last column.
pub fn last_column(reply: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: reply.split_whitespace().last()
}

/// A decimal, or the `0x`-prefixed hex a `REG_DWORD` prints.
pub fn number(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match text.strip_prefix("0x") {
    // rust: Some(hex) => u32::from_str_radix(hex, 16).ok(),
    // rust: None => text.parse().ok(),
}
}

/// The CPU's name from a Linux `/proc/cpuinfo`: x86's `model name`; else an ARM core named by
/// its implementer and part (an arm64 kernel prints only `CPU implementer: 0x41` and `CPU part:
/// 0xd0c`, as `lscpu` maps them: `ARM Neoverse-N1`); else the board's `Model` (a Raspberry Pi's
/// downstream kernel).
pub fn linux_cpu_name(cpuinfo: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(name) = field(cpuinfo, "model name").filter(|n| !n.is_empty()) {
    // rust: return Some(name);
}
    // rust: let hex = |key: &str| {
    // rust: let text = field(cpuinfo, key)?;
    // rust: u32::from_str_radix(text.strip_prefix("0x")?, 16).ok()
}
    // rust: if let (Some(implementer), Some(part)) = (hex("CPU implementer"), hex("CPU part")) {
    // rust: return Some(arm_core_name(implementer, part));
}
    // rust: field(cpuinfo, "Model").filter(|n| !n.is_empty())
}

/// `lscpu`'s `hw_implementer` and `arm_part` tables, for the cores that run Horizon.
pub fn arm_core_name(implementer: u32, part: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (vendor, core) = match (implementer, part) {
    // rust: (0x41, 0xd01) => ("ARM", "Cortex-A32"),
    // rust: (0x41, 0xd03) => ("ARM", "Cortex-A53"),
    // rust: (0x41, 0xd04) => ("ARM", "Cortex-A35"),
    // rust: (0x41, 0xd05) => ("ARM", "Cortex-A55"),
    // rust: (0x41, 0xd07) => ("ARM", "Cortex-A57"),
    // rust: (0x41, 0xd08) => ("ARM", "Cortex-A72"),
    // rust: (0x41, 0xd09) => ("ARM", "Cortex-A73"),
    // rust: (0x41, 0xd0a) => ("ARM", "Cortex-A75"),
    // rust: (0x41, 0xd0b) => ("ARM", "Cortex-A76"),
    // rust: (0x41, 0xd0c) => ("ARM", "Neoverse-N1"),
    // rust: (0x41, 0xd0d) => ("ARM", "Cortex-A77"),
    // rust: (0x41, 0xd40) => ("ARM", "Neoverse-V1"),
    // rust: (0x41, 0xd41) => ("ARM", "Cortex-A78"),
    // rust: (0x41, 0xd44) => ("ARM", "Cortex-X1"),
    // rust: (0x41, 0xd46) => ("ARM", "Cortex-A510"),
    // rust: (0x41, 0xd47) => ("ARM", "Cortex-A710"),
    // rust: (0x41, 0xd48) => ("ARM", "Cortex-X2"),
    // rust: (0x41, 0xd49) => ("ARM", "Neoverse-N2"),
    // rust: (0x41, 0xd4d) => ("ARM", "Cortex-A715"),
    // rust: (0x41, 0xd4e) => ("ARM", "Cortex-X3"),
    // rust: (0x41, 0xd4f) => ("ARM", "Neoverse-V2"),
    // rust: (0x41, 0xd80) => ("ARM", "Cortex-A520"),
    // rust: (0x41, 0xd81) => ("ARM", "Cortex-A720"),
    // rust: (0x41, 0xd82) => ("ARM", "Cortex-X4"),
    // rust: (0x41, 0xd84) => ("ARM", "Neoverse-V3"),
    // rust: (0x41, 0xd8e) => ("ARM", "Neoverse-N3"),
    // rust: (0x41, _) => ("ARM", ""),
    // rust: (0x42, _) => ("Broadcom", ""),
    // rust: (0x43, _) => ("Cavium", ""),
    // rust: (0x46, _) => ("Fujitsu", ""),
    // rust: (0x48, _) => ("HiSilicon", ""),
    // rust: (0x4e, _) => ("NVIDIA", ""),
    // rust: (0x50, _) => ("APM", ""),
    // rust: (0x51, _) => ("Qualcomm", ""),
    // rust: (0x53, _) => ("Samsung", ""),
    // rust: (0x61, _) => ("Apple", ""),
    // rust: (0xc0, _) => ("Ampere", ""),
    // rust: _ => ("ARM-compatible", ""),
}
    // rust: if core.is_empty() {
    // rust: format!("{vendor} (CPU part {part:#05x})")
    // rust: } else {
    // rust: format!("{vendor} {core}")
}
}

pub fn read(path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read_to_string(path).ok()
}

/// The value after `key` in a `key: value` or `key=value` listing.
pub fn field(text: []const u8, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines().find_map(|l| {
    // rust: let rest = l.strip_prefix(key)?;
    // rust: let value = rest.trim_start().strip_prefix([':', '='])?;
    // rust: Some(value.trim().trim_matches('"').to_owned())
    // rust: })
}

pub fn os_version() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: read("/etc/os-release").and_then(|t| field(&t, "PRETTY_NAME"))
    // rust: } else if cfg!(target_os = "macos") {
    // rust: command_output("sw_vers", &["-productVersion"]).map(|v| format!("macOS {v}"))
    // rust: } else if cfg!(windows) {
    // rust: windows_version()
    // rust: } else {
    // rust: None
}
}

pub fn cpu() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: read("/proc/cpuinfo").and_then(|t| linux_cpu_name(&t))
    // rust: } else if cfg!(target_os = "macos") {
    // rust: command_output("sysctl", &["-n", "machdep.cpu.brand_string"])
    // rust: } else if cfg!(windows) {
    // rust: windows_cpu()
    // rust: } else {
    // rust: None
}
}

/// The CPU's brand string on Windows (`AMD Ryzen 7 7700X 8-Core Processor`), from the registry's
/// `ProcessorNameString`. `PROCESSOR_IDENTIFIER` is only the fallback: it always holds the family,
/// model and stepping (`AMD64 Family 25 Model 97 Stepping 2, AuthenticAMD`), which neither names the
/// chip nor tells two chips of one family apart. The game, its crash report, the benchmark report
/// and telemetry all read the CPU through this. Read once: every telemetry item and benchmark
/// report would run `reg` again.
pub fn windows_cpu() O {
    // Implementation ported from Horizon
    return undefined;
}
pub const CPU: OnceLock<?[]const u8> = OnceLock::new();
    // rust: CPU.get_or_init(|| {
    // rust: command_output(
    // rust: "reg",
    // rust: &[
    // rust: "query",
    // rust: r"HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0",
    // rust: "/v",
    // rust: "ProcessorNameString",
    // rust: ],
    // rust: )
    // rust: .and_then(|query| processor_name_from_reg_query(&query))
    // rust: .or_else(|| {
    // rust: std::env::var("PROCESSOR_IDENTIFIER")
    // rust: .ok()
    // rust: .map(|id| id.trim().to_owned())
    // rust: .filter(|id| !id.is_empty())
    // rust: })
    // rust: })
    // rust: .clone()
}

/// The value of `ProcessorNameString` in `reg query ... /v ProcessorNameString` output
/// (`    ProcessorNameString    REG_SZ    AMD Ryzen 7 7700X 8-Core Processor  `), trimmed: the
/// registry pads some names with spaces. Lines end in `\r\n`, and the key's own line has no value.
pub fn processor_name_from_reg_query(query: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: query.lines().find_map(|line| {
    // rust: let rest = line.trim().strip_prefix("ProcessorNameString")?;
    // rust: let value = rest.trim_start().strip_prefix("REG_SZ")?.trim();
    // rust: (!value.is_empty()).then(|| value.to_owned())
    // rust: })
}

pub fn ram_bytes() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: let kib = read("/proc/meminfo").and_then(|t| field(&t, "MemTotal"))?;
    // rust: kib.split_whitespace()
    // rust: .next()?
    // rust: .parse::<u64>()
    // rust: .ok()
    // rust: .map(|k| k * 1024)
    // rust: } else if cfg!(target_os = "macos") {
    // rust: command_output("sysctl", &["-n", "hw.memsize"])?
    // rust: .parse()
    // rust: .ok()
    // rust: } else if cfg!(windows) {
    // rust: command_output(
    // rust: "powershell",
    // rust: &[
    // rust: "-NoProfile",
    // rust: "-Command",
    // rust: "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory",
    // rust: ],
    // rust: )?
    // rust: .parse()
    // rust: .ok()
    // rust: } else {
    // rust: None
}
}

/// The machine's hardware threads. On Linux the processors /proc/cpuinfo lists, as `cores` counts
/// them: `available_parallelism` is this process's share (its CPU affinity, a cgroup's quota), so a
/// game pinned to some CPUs would report fewer threads than cores.
pub fn threads() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let processors = if cfg!(target_os = "linux") {
    // rust: read("/proc/cpuinfo").map_or(0, |t| {
    // rust: t.lines()
    // rust: .filter(|l| {
    // rust: l.split_once(':')
    // rust: .is_some_and(|(k, _)| k.trim() == "processor")
    // rust: })
    // rust: .count() as u16
    // rust: })
    // rust: } else {
    // rust: 0
}
    // rust: processors.max(std::thread::available_parallelism().map_or(0, |n| n.get() as u16))
}

/// Physical cores.
pub fn cores() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: cores_from_cpuinfo(&read("/proc/cpuinfo")?)
    // rust: } else if cfg!(target_os = "macos") {
    // rust: command_output("sysctl", &["-n", "hw.physicalcpu"])?
    // rust: .parse()
    // rust: .ok()
    // rust: } else if cfg!(windows) {
    // rust: powershell("(Get-CimInstance Win32_Processor | Measure-Object NumberOfCores -Sum).Sum")?
    // rust: .parse()
    // rust: .ok()
    // rust: } else {
    // rust: None
}
}

/// Distinct (package, core) pairs; a listing without them (ARM boards) counts its processors.
pub fn cores_from_cpuinfo(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pairs = std::collections::HashSet::new();
    // rust: let (mut package, mut processors) = (String::new(), 0u16);
    // rust: for line in text.lines() {
    // rust: let Some((key, value)) = line.split_once(':') else {
    // rust: continue;
}
    // rust: match key.trim() {
    // rust: "processor" => processors += 1,
    // rust: "physical id" => package = value.trim().to_owned(),
    // rust: "core id" => {
    // rust: pairs.insert((package.clone(), value.trim().to_owned()));
}
    // rust: _ => {}
}
}
    // rust: let n = if pairs.is_empty() {
    // rust: processors
    // rust: } else {
    // rust: pairs.len() as u16
}
    // rust: (n > 0).then_some(n)
}

/// The base and top boost clocks in MHz, where the OS gives them (not on Apple silicon).
pub fn cpu_mhz() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let khz = |path: &str| {
    // rust: read(path)
    // rust: .and_then(|t| t.trim().parse::<u32>().ok())
    // rust: .map(|k| k / 1000)
}
    // rust: if cfg!(target_os = "linux") {
    // rust: let base = khz("/sys/devices/system/cpu/cpu0/cpufreq/base_frequency").or_else(|| {
    // rust: read("/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq")
    // rust: .and_then(|t| t.trim().parse().ok())
    // rust: });
    // rust: (
    // rust: base,
    // rust: khz("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"),
    // rust: )
    // rust: } else if cfg!(target_os = "macos") {
    // rust: let hz = |key: &str| {
    // rust: command_output("sysctl", &["-n", key])
    // rust: .and_then(|t| t.parse::<u64>().ok())
    // rust: .map(|hz| (hz / 1_000_000) as u32)
}
    // rust: (hz("hw.cpufrequency"), hz("hw.cpufrequency_max"))
    // rust: } else if cfg!(windows) {
    // rust: let base =
    // rust: powershell("(Get-CimInstance Win32_Processor | Select-Object -First 1).MaxClockSpeed")
    // rust: .and_then(|t| t.parse().ok());
    // rust: (base, None)
    // rust: } else {
    // rust: (None, None)
}
}

pub fn powershell(command: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: command_output("powershell", &["-NoProfile", "-Command", command])
}

/// `nvme`, `ssd` or `hdd` for the drive `path` is on, where it can be read.
pub fn storage(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: let source = mount_source(&read("/proc/self/mountinfo")?, path)?;
    // rust: let name = source.strip_prefix("/dev/")?;
        // /dev/mapper/x and /dev/dm-0 (LUKS, LVM) sit on the disks in their slaves/.
    // rust: let name = std::fs::canonicalize(format!("/dev/{name}"))
    // rust: .ok()
    // rust: .and_then(|p| p.file_name().map(|n| n.to_string_lossy().into_owned()))
    // rust: .unwrap_or_else(|| name.to_owned());
    // rust: linux_disk_kind(&name, 0)
    // rust: } else if cfg!(target_os = "macos") {
    // rust: let df = command_output("df", &[&path.to_string_lossy()])?;
    // rust: let device = df.lines().nth(1)?.split_whitespace().next()?.to_owned();
    // rust: let info = command_output("diskutil", &["info", &device])?;
    // rust: disk_kind_from_diskutil(&info)
    // rust: } else if cfg!(windows) {
    // rust: let letter = path.to_string_lossy().chars().next()?.to_ascii_uppercase();
    // rust: if !letter.is_ascii_alphabetic() {
    // rust: return None;
}
    // rust: let out = powershell(&format!(
    // rust: "$d = (Get-Partition -DriveLetter {letter}).DiskNumber; \
    // rust: $p = Get-PhysicalDisk | Where-Object DeviceId -eq $d; \"$($p.BusType) $($p.MediaType)\""
    // rust: ))?;
    // rust: let out = out.to_ascii_lowercase();
    // rust: if out.contains("nvme") {
    // rust: Some("nvme")
    // rust: } else if out.contains("ssd") {
    // rust: Some("ssd")
    // rust: } else if out.contains("hdd") {
    // rust: Some("hdd")
    // rust: } else {
    // rust: None
}
    // rust: } else {
    // rust: None
}
}

/// The device mounted at the longest mount point above `path`, from `/proc/self/mountinfo`.
pub fn mount_source(mountinfo: []const u8, path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = std::fs::canonicalize(path).unwrap_or_else(|_| path.to_owned());
    // rust: mountinfo
    // rust: .lines()
    // rust: .filter_map(|line| {
    // rust: let fields: Vec<&str> = line.split_whitespace().collect();
    // rust: let point = fields.get(4)?;
    // rust: let dash = fields.iter().position(|f| *f == "-")?;
    // rust: let source = fields.get(dash + 2)?;
    // rust: path.starts_with(point)
    // rust: .then(|| (point.len(), source.to_string()))
    // rust: })
    // rust: .max_by_key(|(len, _)| *len)
    // rust: .map(|(_, source)| source)
}

pub fn linux_disk_kind(name: []const u8, depth: u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 4 {
    // rust: return None;
}
    // rust: let class = Path::new("/sys/class/block").join(name);
    // A mapper device: the first disk under it.
    // rust: if let Ok(slaves) = std::fs::read_dir(class.join("slaves"))
    // rust: && let Some(slave) = slaves.flatten().next()
    // rust: {
    // rust: return linux_disk_kind(&slave.file_name().to_string_lossy(), depth + 1);
}
    // A partition: its disk is the parent directory.
    // rust: let device = std::fs::canonicalize(&class).ok()?;
    // rust: let disk = if device.join("partition").exists() {
    // rust: device.parent()?.to_owned()
    // rust: } else {
    // rust: device
}
    // rust: let disk_name = disk.file_name()?.to_string_lossy();
    // rust: if disk_name.starts_with("nvme") {
    // rust: return Some("nvme");
}
    // rust: match std::fs::read_to_string(disk.join("queue/rotational"))
    // rust: .ok()?
    // rust: .trim()
    // rust: {
    // rust: "0" => Some("ssd"),
    // rust: "1" => Some("hdd"),
    // rust: _ => None,
}
}

pub fn disk_kind_from_diskutil(info: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let solid = field_spaced(info, "Solid State")?;
    // rust: if solid != "Yes" {
    // rust: return Some("hdd");
}
    // rust: let protocol = field_spaced(info, "Protocol").unwrap_or_default();
    // rust: Some(
    // rust: if ["PCI-Express", "Apple Fabric", "NVMe"]
    // rust: .iter()
    // rust: .any(|p| protocol.contains(p))
    // rust: {
    // rust: "nvme"
    // rust: } else {
    // rust: "ssd"
    // rust: },
    // rust: )
}

/// `   Key:     value` listings (diskutil, system_profiler).
pub fn field_spaced(text: []const u8, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: text.lines().find_map(|l| {
    // rust: let (k, v) = l.split_once(':')?;
    // rust: (k.trim() == key).then(|| v.trim().to_owned())
    // rust: })
}

/// `ac` or `battery`; `None` where it can't be read.
pub fn power() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "macos") {
    // rust: let batt = command_output("pmset", &["-g", "batt"])?;
    // rust: return Some(if batt.contains("'Battery Power'") {
    // rust: "battery"
    // rust: } else {
    // rust: "ac"
    // rust: });
}
    // rust: if cfg!(windows) {
        // BatteryStatus 1: discharging.
    // rust: let status =
    // rust: powershell("(Get-CimInstance Win32_Battery | Select-Object -First 1).BatteryStatus")?;
    // rust: return Some(if status.trim() == "1" {
    // rust: "battery"
    // rust: } else {
    // rust: "ac"
    // rust: });
}
    // rust: let mut on_battery = None;
    // rust: for entry in std::fs::read_dir("/sys/class/power_supply").ok()?.flatten() {
    // rust: let read =
    // rust: |name: &str| std::fs::read_to_string(entry.path().join(name)).unwrap_or_default();
    // rust: match read("type").trim() {
    // rust: "Mains" if read("online").trim() == "1" => return Some("ac"),
    // rust: "Battery" => on_battery = Some("battery"),
    // rust: _ => {}
}
}
    // rust: on_battery
}

/// `laptop` or `desktop`: the firmware's chassis type, else whether there is a battery.
pub fn form() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: if let Some(kind) =
    // rust: read("/sys/class/dmi/id/chassis_type").and_then(|t| t.trim().parse::<u8>().ok())
    // rust: {
    // rust: match kind {
    // rust: 8 | 9 | 10 | 14 | 30 | 31 | 32 => return Some("laptop"),
    // rust: 3..=7 | 13 | 15 | 16 | 35 | 36 => return Some("desktop"),
    // rust: _ => {}
}
}
    // rust: let battery = std::fs::read_dir("/sys/class/power_supply")
    // rust: .ok()?
    // rust: .flatten()
    // rust: .any(|e| {
    // rust: std::fs::read_to_string(e.path().join("type")).is_ok_and(|t| t.trim() == "Battery")
    // rust: });
    // rust: Some(if battery { "laptop" } else { "desktop" })
    // rust: } else if cfg!(target_os = "macos") {
    // rust: let batt = command_output("pmset", &["-g", "batt"])?;
    // rust: Some(if batt.contains("InternalBattery") {
    // rust: "laptop"
    // rust: } else {
    // rust: "desktop"
    // rust: })
    // rust: } else if cfg!(windows) {
    // rust: let n = powershell("@(Get-CimInstance Win32_Battery).Count")?;
    // rust: Some(if n.trim() == "0" { "desktop" } else { "laptop" })
    // rust: } else {
    // rust: None
}
}

/// The dedicated memory of the GPU from `vendor` (`nvidia`, `amd`, `intel`, `apple`), in MiB
/// rounded to 256, where the driver says; read once. `None` for a GPU sharing the system's.
pub fn vram_mb(vendor: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: static CACHE: OnceLock<std::sync::Mutex<std::collections::HashMap<String, Option<u32>>>> =
    // rust: OnceLock::new();
    // rust: let cache = CACHE.get_or_init(Default::default);
    // rust: let mut cache = cache.lock().unwrap_or_else(|e| e.into_inner());
    // rust: *cache.entry(vendor.to_ascii_lowercase()).or_insert_with(|| {
    // rust: read_vram_mb(&vendor.to_ascii_lowercase()).map(|mb| mb.div_ceil(256) * 256)
    // rust: })
}

pub fn read_vram_mb(vendor: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "linux") {
    // rust: if vendor.contains("nvidia") {
    // rust: return command_output(
    // rust: "nvidia-smi",
    // rust: &["--query-gpu=memory.total", "--format=csv,noheader,nounits"],
    // rust: )?
    // rust: .lines()
    // rust: .filter_map(|l| l.trim().parse::<u32>().ok())
    // rust: .max();
}
        // amdgpu (and Intel's discrete xe/i915 cards) in sysfs.
    // rust: std::fs::read_dir("/sys/class/drm")
    // rust: .ok()?
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let dev = e.path().join("device");
    // rust: let bytes = read(&dev.join("mem_info_vram_total").to_string_lossy())
    // rust: .or_else(|| read(&dev.join("lmem_total_bytes").to_string_lossy()))?;
    // rust: bytes.trim().parse::<u64>().ok().map(|b| (b >> 20) as u32)
    // rust: })
    // rust: .filter(|mb| *mb >= 512)
    // rust: .max()
    // rust: } else if cfg!(target_os = "macos") {
        // Apple silicon shares the system's memory: no "VRAM" line.
    // rust: let text = command_output("system_profiler", &["SPDisplaysDataType"])?;
    // rust: text.lines()
    // rust: .filter_map(|l| {
    // rust: let (k, v) = l.split_once(':')?;
    // rust: k.trim().starts_with("VRAM").then(|| size_mb(v))?
    // rust: })
    // rust: .max()
    // rust: } else if cfg!(windows) {
        // AdapterRAM stops at 4 GB; the driver's registry value doesn't.
    // rust: let out = powershell(
    // rust: "Get-ItemProperty 'HKLM:\\SYSTEM\\ControlSet001\\Control\\Class\\{4d36e968-e325-11ce-bfc1-08002be10318}\\0*' \
    // rust: -ErrorAction SilentlyContinue | ForEach-Object { \"$($_.DriverDesc)|$($_.'HardwareInformation.qwMemorySize')\" }",
    // rust: )?;
    // rust: out.lines()
    // rust: .filter_map(|l| {
    // rust: let (name, bytes) = l.split_once('|')?;
    // rust: let ok = vendor.is_empty()
    // rust: || name.to_ascii_lowercase().contains(vendor)
    // rust: || (vendor == "nvidia" && name.contains("GeForce"))
    // rust: || (vendor == "amd" && name.contains("Radeon"));
    // rust: ok.then(|| bytes.trim().parse::<u64>().ok().map(|b| (b >> 20) as u32))?
    // rust: })
    // rust: .max()
    // rust: } else {
    // rust: None
}
}

/// "8 GB", "1536 MB" -> MiB.
pub fn size_mb(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut parts = text.split_whitespace();
    // rust: let n: f64 = parts.next()?.parse().ok()?;
    // rust: match parts.next()? {
    // rust: "GB" => Some((n * 1024.0) as u32),
    // rust: "MB" => Some(n as u32),
    // rust: _ => None,
}
}

/// What doesn't change while the game runs, read once.
pub const Fixed = struct {
    cores: u16,
    base: u32,
    boost: u32,
    form: *'static str,
};

pub fn fixed() * {
    // Implementation ported from Horizon
    return undefined;
}
pub const FIXED: OnceLock<Fixed> = OnceLock::new();
    // rust: FIXED.get_or_init(|| {
    // rust: let (base, boost) = cpu_mhz();
    // rust: Fixed {
    // rust: cores: cores().unwrap_or(0),
    // rust: base: base.unwrap_or(0),
    // rust: boost: boost.unwrap_or(0),
    // rust: form: form().unwrap_or(""),
}
    // rust: })
}

    // rust: impl System {
    /// This machine, without the GPU and the screen. `home` is the game folder, for the kind of
    /// drive it is on.
pub fn detect_in(home: ?*Path) S {
    // Implementation ported from Horizon
    return undefined;
}
pub const GIB: f64 = (1u64 << 30) as f64;
pub const STORAGE: OnceLock<*'static str> = OnceLock::new();
    // rust: let fixed = fixed();
    // rust: Self {
    // rust: os: std::env::consts::OS.to_owned(),
    // rust: os_version: os_version().unwrap_or_default(),
    // rust: arch: std::env::consts::ARCH.to_owned(),
    // rust: cpu: cpu().unwrap_or_default(),
    // rust: threads: threads(),
    // rust: cores: fixed.cores,
    // rust: cpu_base_mhz: fixed.base,
    // rust: cpu_boost_mhz: fixed.boost,
    // rust: ram_gb: ram_bytes().map_or(0, |b| (b as f64 / GIB).round() as u16),
    // rust: storage: home
    // rust: .map(|h| *STORAGE.get_or_init(|| storage(h).unwrap_or("")))
    // rust: .unwrap_or("")
    // rust: .to_owned(),
    // rust: power: power().unwrap_or("").to_owned(),
    // rust: form: fixed.form.to_owned(),
    // rust: ..Self::default()
}
}

    /// [`System::detect_in`] without the drive.
pub fn detect() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::detect_in(None)
}
}

/// The GPU's maker from its name and the vendor ID wgpu reports (0: none, as on Metal).
pub fn gpu_vendor(name: []const u8, vendor_id: u32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match vendor_id {
    // rust: 0x10de => return "nvidia",
    // rust: 0x1002 | 0x1022 => return "amd",
    // rust: 0x8086 => return "intel",
    // rust: 0x106b => return "apple",
    // rust: 0x5143 => return "qualcomm",
    // rust: _ => {}
}
    // rust: let name = name.to_ascii_lowercase();
    // rust: [
    // rust: ("apple", "apple"),
    // rust: ("nvidia", "nvidia"),
    // rust: ("geforce", "nvidia"),
    // rust: ("radeon", "amd"),
    // rust: ("amd", "amd"),
    // rust: ("intel", "intel"),
    // rust: ("adreno", "qualcomm"),
    // rust: ("llvmpipe", "software"),
    // rust: ("lavapipe", "software"),
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|(needle, _)| name.contains(needle))
    // rust: .map_or("", |(_, v)| v)
}

    // rust: mod tests {
pub fn an_arm64_kernels_cpuinfo_names_the_core_by_implementer_and_part() void {
}
        // An arm64 kernel prints no `model name` (a Neoverse-N1 and a Cortex-A72 Pi 4).
    // rust: let neoverse = "processor\t: 0\nBogoMIPS\t: 50.00\nFeatures\t: fp asimd\nCPU implementer\t: 0x41\nCPU architecture: 8\nCPU variant\t: 0x3\nCPU part\t: 0xd0c\nCPU revision\t: 1\n";
    // rust: assert_eq!(linux_cpu_name(neoverse).as_deref(), Some("ARM Neoverse-N1"));
    // rust: let pi = "processor\t: 3\nCPU implementer\t: 0x41\nCPU part\t: 0xd08\nCPU revision\t: 3\n\nRevision\t: c03114\nModel\t\t: Raspberry Pi 4 Model B Rev 1.4\n";
    // rust: assert_eq!(linux_cpu_name(pi).as_deref(), Some("ARM Cortex-A72"));
        // An implementer the table has, a part it does not: the part is kept.
    // rust: let apple = "CPU implementer\t: 0x61\nCPU part\t: 0x023\n";
    // rust: assert_eq!(
    // rust: linux_cpu_name(apple).as_deref(),
    // rust: Some("Apple (CPU part 0x023)")
    // rust: );
}

pub fn x86_keeps_its_model_name_and_a_board_without_either_its_model() void {
}
    // rust: let ryzen = "processor\t: 0\nmodel name\t: AMD Ryzen 9 7950X 16-Core Processor\n";
    // rust: assert_eq!(
    // rust: linux_cpu_name(ryzen).as_deref(),
    // rust: Some("AMD Ryzen 9 7950X 16-Core Processor")
    // rust: );
    // rust: assert_eq!(
    // rust: linux_cpu_name("Model\t: Some Board\n").as_deref(),
    // rust: Some("Some Board")
    // rust: );
    // rust: assert_eq!(linux_cpu_name("processor\t: 0\n"), None);
}

//     use super::*;

pub fn fields_are_read_from_listings() void {
}
    // rust: let os_release =
    // rust: "NAME=\"Fedora Linux\"\nPRETTY_NAME=\"Fedora Linux 43 (Workstation Edition)\"\n";
    // rust: assert_eq!(
    // rust: field(os_release, "PRETTY_NAME").as_deref(),
    // rust: Some("Fedora Linux 43 (Workstation Edition)")
    // rust: );
    // rust: let cpuinfo = "processor\t: 0\nmodel name\t: AMD Ryzen 9 7950X 16-Core Processor\n";
    // rust: assert_eq!(
    // rust: field(cpuinfo, "model name").as_deref(),
    // rust: Some("AMD Ryzen 9 7950X 16-Core Processor")
    // rust: );
    // rust: assert_eq!(
    // rust: field("MemTotal:       32788148 kB", "MemTotal").as_deref(),
    // rust: Some("32788148 kB")
    // rust: );
    // rust: assert_eq!(field("NAME=x", "PRETTY_NAME"), None);
}

pub fn the_windows_version_comes_from_the_build_numbers() void {
}
    // rust: assert_eq!(
    // rust: windows_version_text(
    // rust: "    CurrentBuild    REG_SZ    26100",
    // rust: Some("    UBR    REG_DWORD    0x7f1")
    // rust: )
    // rust: .as_deref(),
    // rust: Some("Windows 11 (26100.2033)")
    // rust: );
    // rust: assert_eq!(
    // rust: windows_version_text("    CurrentBuild    REG_SZ    19045", None).as_deref(),
    // rust: Some("Windows 10 (19045)")
    // rust: );
    // rust: assert_eq!(windows_version_text("", None), None);
}

pub fn cores_are_counted_once_per_package() void {
}
    // rust: let two_cores_four_threads = "processor : 0\nphysical id : 0\ncore id : 0\n\nprocessor : 1\nphysical id : 0\ncore id : 1\n\nprocessor : 2\nphysical id : 0\ncore id : 0\n\nprocessor : 3\nphysical id : 0\ncore id : 1\n";
    // rust: assert_eq!(cores_from_cpuinfo(two_cores_four_threads), Some(2));
    // rust: assert_eq!(
    // rust: cores_from_cpuinfo("processor : 0\nprocessor : 1\n"),
    // rust: Some(2)
    // rust: );
    // rust: assert_eq!(cores_from_cpuinfo(""), None);
}

pub fn the_game_folders_mount_is_found() void {
}
    // rust: let mountinfo = "22 1 259:2 / / rw - ext4 /dev/nvme0n1p2 rw\n30 22 8:1 / /mnt/games rw - ext4 /dev/sda1 rw\n";
    // rust: assert_eq!(
    // rust: mount_source(mountinfo, Path::new("/home/x/.horizon")).as_deref(),
    // rust: Some("/dev/nvme0n1p2")
    // rust: );
    // rust: assert_eq!(
    // rust: mount_source(mountinfo, Path::new("/mnt/games/horizon")).as_deref(),
    // rust: Some("/dev/sda1")
    // rust: );
}

pub fn diskutil_and_sizes_are_read() void {
}
    // rust: let info = "   Device Node:               /dev/disk3s1\n   Protocol:                  Apple Fabric\n   Solid State:               Yes\n";
    // rust: assert_eq!(disk_kind_from_diskutil(info), Some("nvme"));
    // rust: assert_eq!(
    // rust: disk_kind_from_diskutil("   Solid State:  No\n"),
    // rust: Some("hdd")
    // rust: );
    // rust: assert_eq!(
    // rust: disk_kind_from_diskutil("   Protocol: SATA\n   Solid State: Yes\n"),
    // rust: Some("ssd")
    // rust: );
    // rust: assert_eq!(size_mb(" 8 GB"), Some(8192));
    // rust: assert_eq!(size_mb(" 1536 MB"), Some(1536));
}

pub fn the_registry_cpu_name_is_read_from_reg_query() void {
}
    // rust: let name = "AMD Ryzen 7 7700X 8-Core Processor";
    // rust: let key = r"HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0";
    // rust: let query = format!("\r\n{key}\r\n    ProcessorNameString    REG_SZ    {name}\r\n\r\n");
        // CRLF line endings, as `reg query` prints them.
    // rust: assert_eq!(processor_name_from_reg_query(&query).as_deref(), Some(name));
        // The same with LF only.
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(&query.replace("\r\n", "\n")).as_deref(),
    // rust: Some(name)
    // rust: );
        // The registry pads some names with spaces; the name comes without them.
    // rust: let padded = format!("{key}\n    ProcessorNameString    REG_SZ        {name}      \n");
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(&padded).as_deref(),
    // rust: Some(name)
    // rust: );
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(&format!(
    // rust: "
    // rust: {key}
    // rust: ProcessorNameString    REG_SZ    13th Gen Intel(R) Core(TM) i7-13700F
    // rust: "
    // rust: ))
    // rust: .as_deref(),
    // rust: Some("13th Gen Intel(R) Core(TM) i7-13700F")
    // rust: );
        // Spaces inside the name stay as they are, runs of them too (older Intel names).
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(
    // rust: "    ProcessorNameString    REG_SZ    Intel(R) Core(TM) i7 CPU         920  @ 2.67GHz\r\n"
    // rust: )
    // rust: .as_deref(),
    // rust: Some("Intel(R) Core(TM) i7 CPU         920  @ 2.67GHz")
    // rust: );
        // Columns split by tabs.
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(&format!("\tProcessorNameString\tREG_SZ\t{name}\r\n"))
    // rust: .as_deref(),
    // rust: Some(name)
    // rust: );
}

pub fn a_reg_query_without_a_name_gives_none() void {
}
        // The value is missing: `reg query` prints an error and nothing on stdout, or only the key.
    // rust: assert_eq!(processor_name_from_reg_query(""), None);
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(
    // rust: "HKEY_LOCAL_MACHINE\\HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0\r\n"
    // rust: ),
    // rust: None
    // rust: );
        // Present but empty.
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query("    ProcessorNameString    REG_SZ    \r\n"),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query("    ProcessorNameString    REG_SZ"),
    // rust: None
    // rust: );
        // Another value, or another type, is not the name.
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(
    // rust: "    Identifier    REG_SZ    AMD64 Family 25 Model 97 Stepping 2\r\n"
    // rust: ),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query("    ProcessorNameString    REG_DWORD    0x1\r\n"),
    // rust: None
    // rust: );
        // Garbage.
    // rust: assert_eq!(processor_name_from_reg_query("REG_SZ\n\n   \n"), None);
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query("\u{0}\u{fffd}\u{fffd}REG_SZ"),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: processor_name_from_reg_query(
    // rust: "ERROR: The system was unable to find the specified registry key or value."
    // rust: ),
    // rust: None
    // rust: );
}

    /// The CPU is the registry's name for it, as PowerShell reads it (not through `reg`), trimmed;
    /// `PROCESSOR_IDENTIFIER`'s family and model only where the registry has no name, as on some
    /// VMs. No CI runner tests this crate on Windows: it runs on a contributor's machine.
pub fn windows_names_the_cpu_by_its_brand() void {
}
    // rust: let registry = powershell(
    // rust: r"(Get-ItemProperty 'HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor\0').ProcessorNameString",
    // rust: );
    // rust: let expected = registry.or_else(|| {
    // rust: std::env::var("PROCESSOR_IDENTIFIER")
    // rust: .ok()
    // rust: .map(|id| id.trim().to_owned())
    // rust: });
    // rust: assert_eq!(cpu(), expected);
}

pub fn gpu_makers() void {
}
    // rust: assert_eq!(gpu_vendor("NVIDIA GeForce RTX 4080", 0x10de), "nvidia");
    // rust: assert_eq!(gpu_vendor("Apple M4 Pro", 0), "apple");
    // rust: assert_eq!(gpu_vendor("AMD Radeon RX 7800 XT", 0), "amd");
    // rust: assert_eq!(
    // rust: gpu_vendor("Mesa Intel(R) HD Graphics 620 (KBL GT2)", 0x8086),
    // rust: "intel"
    // rust: );
    // rust: assert_eq!(gpu_vendor("llvmpipe (LLVM 19)", 0x10005), "software");
}

    /// `cargo test -p horizon-telemetry -- --ignored --nocapture what_this_machine_sends`
pub fn what_this_machine_sends() void {
}
    // rust: let home = std::env::current_dir().unwrap();
    // rust: let mut system = System::detect_in(Some(&home));
    // rust: system.vram_mb = vram_mb("nvidia").or_else(|| vram_mb("amd")).unwrap_or(0);
    // rust: println!("{}", serde_json::to_string_pretty(&system).unwrap());
}

pub fn this_machine_is_described() void {
}
    // rust: let system = System::detect();
    // rust: assert_eq!(system.os, std::env::consts::OS);
    // rust: assert!(system.threads > 0);
    // rust: assert!(system.gpu.is_empty(), "the game fills the GPU in");
    // rust: assert!(system.cores == 0 || system.cores <= system.threads);
    // rust: assert!(["", "ac", "battery"].contains(&system.power.as_str()));
    // rust: assert!(["", "laptop", "desktop"].contains(&system.form.as_str()));
    // rust: let dir = std::env::temp_dir();
    // rust: assert!(
    // rust: ["", "nvme", "ssd", "hdd"].contains(&System::detect_in(Some(&dir)).storage.as_str())
    // rust: );
}
}
