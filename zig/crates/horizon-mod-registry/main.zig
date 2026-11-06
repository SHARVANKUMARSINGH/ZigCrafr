//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-registry_main
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-mod-registry`: serves on `PORT` (default 8080). Configured by the
//! environment (see `Config::from_env`); keeps the ratings in `REGISTRY_DB`.
// use std::net::SocketAddr;

// use horizon_mod_registry::{App, Config, router};

pub fn main() void {
}
    // rust: let port: u16 = std::env::var("PORT")
    // rust: .ok()
    // rust: .and_then(|p| p.parse().ok())
    // rust: .unwrap_or(8080);
    // rust: let config = Config::from_env().unwrap_or_else(|e| panic!("horizon-mod-registry: {e}"));
    // rust: let repo = config.github.repo.clone();
    // rust: let listener = tokio::net::TcpListener::bind(SocketAddr::from(([0, 0, 0, 0], port)))
    // rust: .await
    // rust: .unwrap_or_else(|e| panic!("port {port}: {e}"));
    // rust: eprintln!("horizon-mod-registry: listening on {port}, submitting to {repo}");
    // rust: let app = App::new(config).unwrap_or_else(|e| panic!("horizon-mod-registry: {e}"));
    // rust: axum::serve(listener, router(app))
    // rust: .with_graceful_shutdown(async {
    // rust: let _ = tokio::signal::ctrl_c().await;
    // rust: })
    // rust: .await
    // rust: .unwrap_or_else(|e| panic!("{e}"));
}
