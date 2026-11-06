//! Transpiled from Horizon Rust crate
//! Module: horizon-bench_hardware
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The machine a report was measured on. CPU, RAM and OS are detected here; the GPU and the display
//! come from the program that rendered (the game knows its adapter, the launcher its window).

// use horizon_telemetry::system::command_output as output;
// use serde::{Deserialize, Serialize};

pub const Hardware = struct {
    /// `macos`, `linux`, `windows`.
    os: []const u8,
    os_version: ?[]const u8,
    arch: []const u8,
    cpu: ?[]const u8,
    cpu_threads: ?usize,
    /// Physical cores.
    cpu_cores: ?u16,
    /// Base and top boost clock, where the OS gives them.
    cpu_base_mhz: ?u32,
    cpu_boost_mhz: ?u32,
    ram_mb: ?u64,
    /// The drive under the game folder: `nvme`, `ssd` or `hdd`.
    storage: ?[]const u8,
    /// `laptop` or `desktop`.
    form: ?[]const u8,
    gpu: ?Gpu,
    display: ?Display,
};

pub const Gpu = struct {
    name: []const u8,
    vendor: []const u8,
    driver: []const u8,
    /// `metal`, `vulkan`, `dx12`, `gl`.
    backend: []const u8,
    /// `integrated`, `discrete`, `virtual`, `cpu`, `other`.
    kind: []const u8,
    /// Its own memory in MiB (rounded to 256), for a discrete GPU whose driver says.
    vram_mb: ?u32,
};

pub const Display = struct {
    /// Physical pixels.
    width: u32,
    height: u32,
    scale: f64,
    refresh_hz: ?u32,
};

    // rust: impl Hardware {
pub fn detect() H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let probes = probes();
    // rust: Hardware {
    // rust: os: std::env::consts::OS.to_owned(),
    // rust: os_version: os_version(),
    // rust: arch: std::env::consts::ARCH.to_owned(),
    // rust: cpu: cpu(),
    // rust: cpu_threads: std::thread::available_parallelism().ok().map(|n| n.get()),
    // rust: cpu_cores: probes.cores,
    // rust: cpu_base_mhz: probes.base,
    // rust: cpu_boost_mhz: probes.boost,
    // rust: ram_mb: ram_bytes().map(|b| b >> 20),
    // rust: storage: None,
    // rust: form: probes.form,
    // rust: gpu: None,
    // rust: display: None,
}
}

    /// [`Hardware::detect`] with the kind of drive `game_dir` is on.
pub fn detect_in(game_dir: *std::path::Path) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Hardware {
    // rust: storage: horizon_telemetry::system::storage(game_dir).map(str::to_owned),
    // rust: ..Hardware::detect()
}
}
}

/// What the telemetry probes read (`horizon_telemetry::system`).
pub const Probes = struct {
    cores: ?u16,
    base: ?u32,
    boost: ?u32,
    form: ?[]const u8,
};

pub fn probes() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = horizon_telemetry::payload::System::detect();
    // rust: let some = |n: u32| (n > 0).then_some(n);
    // rust: Probes {
    // rust: cores: (s.cores > 0).then_some(s.cores),
    // rust: base: some(s.cpu_base_mhz),
    // rust: boost: some(s.cpu_boost_mhz),
    // rust: form: (!s.form.is_empty()).then_some(s.form),
}
}

/// The one-minute load average: above about the number of threads the machine was busy.
pub fn load_average() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "macos") {
        // "{ 1.23 1.10 1.00 }"
    // rust: output("sysctl", &["-n", "vm.loadavg"])?
    // rust: .trim_start_matches('{')
    // rust: .split_whitespace()
    // rust: .next()?
    // rust: .parse()
    // rust: .ok()
    // rust: } else {
    // rust: std::fs::read_to_string("/proc/loadavg")
    // rust: .ok()?
    // rust: .split_whitespace()
    // rust: .next()?
    // rust: .parse()
    // rust: .ok()
}
}

/// `ac` or `battery`; `None` where it can't be read (and on machines without a battery on Linux).
pub fn power_source() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_telemetry::system::power()
}

/// Resident memory of a process, in bytes (macOS, Linux).
pub fn rss_bytes(pid: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "macos") {
    // rust: return output("ps", &["-o", "rss=", "-p", &pid.to_string()])?
    // rust: .parse::<u64>()
    // rust: .ok()
    // rust: .map(|kb| kb * 1024);
}
    // rust: let status = std::fs::read_to_string(format!("/proc/{pid}/status")).ok()?;
    // rust: let line = status.lines().find(|l| l.starts_with("VmRSS:"))?;
    // rust: line.split_whitespace()
    // rust: .nth(1)?
    // rust: .parse::<u64>()
    // rust: .ok()
    // rust: .map(|kb| kb * 1024)
}

/// CPU time a process has used, user and system, in seconds (macOS, Linux).
pub fn cpu_seconds(pid: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "macos") {
        // "[[dd-]hh:]mm:ss.cc"
    // rust: let time = output("ps", &["-o", "time=", "-p", &pid.to_string()])?;
    // rust: let (rest, days) = match time.split_once('-') {
    // rust: Some((d, rest)) => (rest.to_owned(), d.parse::<f64>().ok()?),
    // rust: None => (time, 0.0),
}
    // rust: let seconds = rest.split(':').try_fold(0.0, |acc, part| {
    // rust: part.parse::<f64>().ok().map(|v| acc * 60.0 + v)
    // rust: })?;
    // rust: return Some(days * 86_400.0 + seconds);
}
    // utime and stime, fields 14 and 15, in clock ticks (100 per second on Linux).
    // rust: let stat = std::fs::read_to_string(format!("/proc/{pid}/stat")).ok()?;
    // rust: let fields: Vec<&str> = stat.rsplit_once(')')?.1.split_whitespace().collect();
    // rust: let ticks: f64 = fields.get(11)?.parse::<f64>().ok()? + fields.get(12)?.parse::<f64>().ok()?;
    // rust: Some(ticks / 100.0)
}

pub fn os_version() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: output("sw_vers", &["-productVersion"])
}

pub fn cpu() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: output("sysctl", &["-n", "machdep.cpu.brand_string"])
}

pub fn ram_bytes() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: output("sysctl", &["-n", "hw.memsize"])?.parse().ok()
}

pub fn os_version() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let release = std::fs::read_to_string("/etc/os-release").ok()?;
    // rust: let name = key_value(&release, "PRETTY_NAME", '=')?
    // rust: .trim_matches('"')
    // rust: .to_owned();
    // rust: Some(match output("uname", &["-r"]) {
    // rust: Some(kernel) => format!("{name} (kernel {kernel})"),
    // rust: None => name,
    // rust: })
}

pub fn cpu() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info = std::fs::read_to_string("/proc/cpuinfo").ok()?;
    // x86 names the CPU per core; arm64 only gives the core's implementer and part.
    // rust: horizon_telemetry::system::linux_cpu_name(&info)
}

pub fn ram_bytes() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info = std::fs::read_to_string("/proc/meminfo").ok()?;
    // rust: let kb = key_value(&info, "MemTotal", ':')?
    // rust: .trim_end_matches("kB")
    // rust: .trim();
    // rust: kb.parse::<u64>().ok().map(|kb| kb * 1024)
}

    // rust: fn key_value<'a>(text: &'a str, key: &str, sep: char) -> Option<&'a str> {
    // rust: text.lines().find_map(|line| {
    // rust: let (k, v) = line.split_once(sep)?;
    // rust: (k.trim() == key).then(|| v.trim())
    // rust: })
}

pub fn os_version() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_telemetry::system::windows_version()
}

pub fn cpu() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_telemetry::system::windows_cpu()
}

pub fn ram_bytes() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let out = output(
    // rust: "powershell",
    // rust: &[
    // rust: "-NoProfile",
    // rust: "-Command",
    // rust: "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory",
    // rust: ],
    // rust: )?;
    // rust: out.parse().ok()
}

pub fn os_version() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}

pub fn cpu() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}

pub fn ram_bytes() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;

pub fn detects_this_machine() void {
}
    // rust: let hw = Hardware::detect();
    // rust: assert_eq!(hw.os, std::env::consts::OS);
    // rust: assert!(hw.cpu_threads.unwrap() >= 1);
    // rust: if cfg!(any(target_os = "macos", target_os = "linux")) {
    // rust: assert!(hw.cpu.is_some(), "{hw:?}");
    // rust: assert!(hw.ram_mb.unwrap() > 256, "{hw:?}");
    // rust: assert!(hw.os_version.is_some(), "{hw:?}");
    // rust: assert!(load_average().is_some());
    // rust: assert!(rss_bytes(std::process::id()).unwrap() > 1 << 20);
    // rust: assert!(cpu_seconds(std::process::id()).unwrap() >= 0.0);
}
}

    /// `hardware.cpu` is the brand name, not the family and model `PROCESSOR_IDENTIFIER` holds.
pub fn windows_reports_the_cpu_brand() void {
}
    // rust: let cpu = Hardware::detect().cpu.expect("a CPU name");
    // rust: assert!(
    // rust: !cpu.is_empty() && !cpu.contains(" Family ") && !cpu.contains("Stepping"),
    // rust: "family and model, not a name: {cpu:?}"
    // rust: );
    // rust: assert_eq!(cpu, cpu.trim());
}
}
