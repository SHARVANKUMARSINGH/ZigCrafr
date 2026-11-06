//! Transpiled from Horizon Rust crate
package horizon_telemetry_server_classes

import "core:fmt"
import "core:mem"
import "core:math"

// The hardware classes the public output breaks results down by. Coarse on purpose: a class
// holds many machines, and a published cell still needs `MIN_INSTALLS` different installs.
// The website's `scripts/benchmarks.mjs` (horizon-rust/horizon-site) has the same functions, tested on the same fixtures.
//
// The raw values (the exact memory, the driver, the screen) stay in the database for the
// retention period and are never published.
// use horizon_telemetry::payload::System;
// use serde_json::Value;

// The dimensions, in the order [`of_report`] and [`of_system`] return them.
DIMENSIONS :: ["ram", "vram", "storage", "os", "gpu_kind"]

    // rust: pub type Classes = [Option<&'static str>; 5];

// Installed memory in GB (a little under the size on the box: some is reserved).
ram :: proc(gb: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match gb {
    // rust: g if g.is_nan() || g <= 0.0 => return None,
    // rust: g if g <= 5.0 => "4 GB or less",
    // rust: g if g <= 10.0 => "8 GB",
    // rust: g if g <= 20.0 => "16 GB",
    // rust: g if g <= 40.0 => "32 GB",
    // rust: _ => "64 GB or more",
    // rust: })
}

// A GPU's own memory in MiB; an integrated GPU shares the system's.
vram :: proc(mb: f64, kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if gpu_kind(kind) == Some("integrated") {
    // rust: return Some("shared");
}
    // rust: Some(match mb {
    // rust: m if m.is_nan() || m <= 0.0 => return None,
    // rust: m if m <= 2560.0 => "2 GB or less",
    // rust: m if m <= 4608.0 => "4 GB",
    // rust: m if m <= 6656.0 => "6 GB",
    // rust: m if m <= 8704.0 => "8 GB",
    // rust: m if m <= 12800.0 => "12 GB",
    // rust: m if m <= 16896.0 => "16 GB",
    // rust: _ => "more than 16 GB",
    // rust: })
}

storage :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: ["nvme", "ssd", "hdd"].into_iter().find(|k| *k == s)
}

os :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: ["linux", "macos", "windows"].into_iter().find(|k| *k == s)
}

// `integrated` or `discrete`, from either wording (`IntegratedGpu`, as wgpu says it, too).
gpu_kind :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match s {
    // rust: "integrated" | "IntegratedGpu" => Some("integrated"),
    // rust: "discrete" | "DiscreteGpu" => Some("discrete"),
    // rust: _ => None,
}
}

// A benchmark report's classes (`docs/benchmark-report.md`'s `hardware`).
of_report :: proc(report: ^Value) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let hw = &report["hardware"];
    // rust: let kind = hw["gpu"]["kind"].as_str().unwrap_or("");
    // rust: [
    // rust: hw["ram_mb"].as_f64().and_then(|mb| ram(mb / 1024.0)),
    // rust: vram(hw["gpu"]["vram_mb"].as_f64().unwrap_or(0.0), kind),
    // rust: storage(hw["storage"].as_str().unwrap_or("")),
    // rust: os(hw["os"].as_str().unwrap_or("")),
    // rust: gpu_kind(kind),
    // rust: ]
}

// A telemetry item's machine's classes.
of_system :: proc(s: ^System) -> C {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: ram(f64::from(s.ram_gb)),
    // rust: vram(f64::from(s.vram_mb), &s.gpu_kind),
    // rust: storage(&s.storage),
    // rust: os(&s.os),
    // rust: gpu_kind(&s.gpu_kind),
    // rust: ]
}

    // rust: mod tests {
//     use super::*;

classes_are_coarse :: proc() {
}
    // rust: assert_eq!(ram(15.6), Some("16 GB"));
    // rust: assert_eq!(ram(31.0), Some("32 GB"));
    // rust: assert_eq!(ram(64.0), Some("64 GB or more"));
    // rust: assert_eq!(ram(0.0), None);
    // rust: assert_eq!(vram(16376.0, "discrete"), Some("16 GB"));
    // rust: assert_eq!(vram(8192.0, "DiscreteGpu"), Some("8 GB"));
    // rust: assert_eq!(vram(0.0, "integrated"), Some("shared"));
    // rust: assert_eq!(vram(0.0, ""), None);
    // rust: assert_eq!(storage("nvme"), Some("nvme"));
    // rust: assert_eq!(storage("tape"), None);
    // rust: assert_eq!(gpu_kind("virtual"), None);
}
}
