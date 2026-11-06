//! Transpiled from Horizon Rust crate
package horizon_mod_registry_ratings

import "core:fmt"
import "core:mem"
import "core:math"

// Players' ratings of published projects, 1 to 5 stars: one per GitHub
// account and project, which its rater can change. Stored in one SQLite
// file (a Railway volume). Only totals leave it: never who rated what,
// except a signed-in account's own rating, to that account.
// use rusqlite::{Connection, OptionalExtension, params};
// use std::{collections::BTreeMap, path::Path};

    // rust: const SCHEMA: &str = "
    // rust: PRAGMA journal_mode = WAL;
    // rust: PRAGMA synchronous = NORMAL;
    // rust: CREATE TABLE IF NOT EXISTS ratings (
    // rust: project TEXT NOT NULL,
    // rust: account INTEGER NOT NULL,
    // rust: stars INTEGER NOT NULL CHECK (stars BETWEEN 1 AND 5),
    // rust: updated INTEGER NOT NULL,
    // rust: PRIMARY KEY (project, account)
    // rust: ) WITHOUT ROWID;
    // rust: ";

// A project's ratings: their mean, and how many.
Summary :: struct {
    average: f64,
    count: u64,
}

Ratings :: struct {
    db: Connection,
}

    // rust: impl Ratings {
    // Opens (or creates) the file at `path`; `:memory:` for a test.
open :: proc(path: ^Path) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let db = Connection::open(path)?;
    // rust: db.execute_batch(SCHEMA)?;
    // rust: Ok(Ratings { db })
}

    // Sets `account`'s rating of `project`, replacing an earlier one.
rate :: proc(self: ^Self, project: string, account: u64, stars: u8, now: u64) -> r {
    // Ported from Horizon
    return {}
}
    // rust: self.db.execute(
    // rust: "INSERT INTO ratings (project, account, stars, updated) VALUES (?1, ?2, ?3, ?4)
    // rust: ON CONFLICT (project, account) DO UPDATE SET stars = excluded.stars, updated = excluded.updated",
    // rust: params![project, account as i64, stars, now as i64],
    // rust: )?;
    // rust: Ok(())
}

    // `account`'s own rating of `project`.
mine :: proc(self: ^Self, project: string, account: u64) -> r {
    // Ported from Horizon
    return {}
}
    // rust: self.db
    // rust: .query_row(
    // rust: "SELECT stars FROM ratings WHERE project = ?1 AND account = ?2",
    // rust: params![project, account as i64],
    // rust: |r| r.get(0),
    // rust: )
    // rust: .optional()
}

    // `project`'s summary; None when nobody rated it.
summary :: proc(self: ^Self, project: string) -> r {
    // Ported from Horizon
    return {}
}
    // rust: self.db
    // rust: .query_row(
    // rust: "SELECT avg(stars), count(*) FROM ratings WHERE project = ?1 HAVING count(*) > 0",
    // rust: [project],
    // rust: |r| {
    // rust: Ok(Summary {
    // rust: average: r.get(0)?,
    // rust: count: r.get::<_, i64>(1)? as u64,
    // rust: })
    // rust: },
    // rust: )
    // rust: .optional()
}

    // Every rated project's summary.
summaries :: proc(self: ^Self) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let mut statement = self
    // rust: .db
    // rust: .prepare("SELECT project, avg(stars), count(*) FROM ratings GROUP BY project")?;
    // rust: let rows = statement.query_map([], |r| {
    // rust: Ok((
    // rust: r.get::<_, String>(0)?,
    // rust: Summary {
    // rust: average: r.get(1)?,
    // rust: count: r.get::<_, i64>(2)? as u64,
    // rust: },
    // rust: ))
    // rust: })?;
    // rust: rows.collect()
}
}

    // rust: mod tests {
//     use super::*;

one_rating_per_account_and_project :: proc() {
}
    // rust: let r = Ratings::open(Path::new(":memory:")).unwrap();
    // rust: r.rate("zoom", 1, 5, 10).unwrap();
    // rust: r.rate("zoom", 2, 2, 10).unwrap();
    // rust: r.rate("zoom", 1, 4, 11).unwrap();
    // rust: r.rate("minimap", 1, 3, 11).unwrap();
    // rust: assert_eq!(r.mine("zoom", 1).unwrap(), Some(4));
    // rust: assert_eq!(r.mine("zoom", 3).unwrap(), None);
    // rust: let all = r.summaries().unwrap();
    // rust: assert_eq!(
    // rust: all["zoom"],
    // rust: Summary {
    // rust: average: 3.0,
    // rust: count: 2
}
    // rust: );
    // rust: assert_eq!(
    // rust: all["minimap"],
    // rust: Summary {
    // rust: average: 3.0,
    // rust: count: 1
}
    // rust: );
    // rust: assert_eq!(r.summary("zoom").unwrap(), Some(all["zoom"]));
    // rust: assert_eq!(r.summary("nothing").unwrap(), None);
    // rust: assert!(
    // rust: r.rate("zoom", 1, 6, 12).is_err(),
    // rust: "the table checks the range too"
    // rust: );
}
}
