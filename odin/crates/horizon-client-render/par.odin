//! Transpiled from Horizon Rust crate
package horizon_client_render_par

import "core:fmt"
import "core:mem"
import "core:math"

// Loading many small files at once: startup reads tens of thousands of
// textures and models with a content pack, and one at a time it waits on
// each open and read in turn.
// use std::sync::atomic::{AtomicUsize, Ordering};

// `f` over `items` on the machine's threads, results in `items`' order.
// Threads take the next item as they finish one, so a run of slow items
// doesn't hold back the others.
    // rust: pub fn par_map<T: Sync, R: Send>(items: &[T], f: impl Fn(&T) -> R + Sync) -> Vec<R> {
    // rust: let threads = horizon_threads::worker_count().min(items.len());
    // rust: if threads <= 1 {
    // rust: return items.iter().map(f).collect();
}
    // rust: let next = AtomicUsize::new(0);
    // rust: let mut out: Vec<(usize, R)> = std::thread::scope(|scope| {
    // rust: let workers: Vec<_> = (0..threads)
    // rust: .map(|_| {
    // rust: scope.spawn(|| {
    // rust: let mut done = Vec::new();
    // rust: loop {
    // rust: let i = next.fetch_add(1, Ordering::Relaxed);
    // rust: let Some(item) = items.get(i) else {
    // rust: return done;
}
    // rust: done.push((i, f(item)));
}
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: workers
    // rust: .into_iter()
    // rust: .flat_map(|w| w.join().unwrap_or_else(|e| std::panic::resume_unwind(e)))
    // rust: .collect()
    // rust: });
    // rust: out.sort_unstable_by_key(|(i, _)| *i);
    // rust: out.into_iter().map(|(_, r)| r).collect()
}

    // rust: mod tests {
//     use super::par_map;

results_keep_the_items_order :: proc() {
}
    // rust: let items: Vec<u32> = (0..1000).collect();
    // rust: assert_eq!(
    // rust: par_map(&items, |x| x * 2),
    // rust: items.iter().map(|x| x * 2).collect::<Vec<_>>()
    // rust: );
    // rust: assert!(par_map(&[] as &[u32], |x| *x).is_empty());
}
}
