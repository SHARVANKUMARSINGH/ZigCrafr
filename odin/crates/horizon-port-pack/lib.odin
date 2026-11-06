//! Transpiled from Horizon Rust crate
package horizon_port_pack_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Port a Java modpack to Horizon (`docs/modpacks.md`): the steps behind the
// `horizon-port-pack` command, and the launcher's "Import modpack".
//
// Every step reads and writes files in a work folder (`pipeline`), so it can
// be rerun, resumed and inspected. The work folder belongs to the user: the
// jars they downloaded and what is carried over from them stay there and
// are never uploaded or committed.
    // rust: pub mod carry;
    // rust: pub mod check;
    // rust: pub mod classes;
    // rust: pub mod classify;
    // rust: pub mod fetch;
    // rust: pub mod import;
    // rust: pub mod inventory;
    // rust: pub mod jar;
    // rust: pub(crate) mod legacy_structure_mods;
    // rust: mod lithostitched;
    // rust: pub mod modrinth;
    // rust: pub mod net;
    // rust: pub mod oracle;
    // rust: pub mod pipeline;
    // rust: pub mod processors;
    // rust: pub mod report;
    // rust: pub mod resourcepacks;
    // rust: pub mod upgrade;
    // rust: pub mod worldgen;
    // rust: mod yung;
