//! Transpiled from Horizon Rust crate
package horizon_world_removal

import "core:fmt"
import "core:mem"
import "core:math"

// What vanilla's `BlockEntity.preRemoveSideEffects` does when a block with a
// block entity is replaced by another block (`LevelChunk.setBlockState`
// without `UPDATE_SKIP_BLOCK_ENTITY_SIDEEFFECTS`), and the item spill of
// `Containers.dropItemStack` those side effects use.
// use horizon_core::{position::BlockPos, random::RandomSource};

// `preRemoveSideEffects` of the block entity of a block.
PreRemove :: enum {
    // No side effect (signs, banners, beacons, skulls, ...).
    Nothing,
    // `Containers.dropContents(level, pos, container)`: every slot, empty or
    // not, through `Containers.dropItemStack` (chests, barrels, hoppers,
    // dispensers, droppers, brewing stands, crafters, chiseled bookshelves,
    // shelves, decorated pots). Furnaces also award their recipes' experience.
    Contents { slots: usize, furnace: bool },
    // `CampfireBlockEntity`: `Containers.dropContents(level, pos, items)`.
    Campfire,
    // `ShulkerBoxBlockEntity`: keeps its contents for the dropped box.
    ShulkerBox,
    // `JukeboxBlockEntity.popOutTheItem`.
    Jukebox,
    // `LecternBlockEntity`: the book, when the state has one.
    Lectern,
    // `SculkShriekerBlockEntity.tryRespond` while shrieking.
    SculkShrieker,
    // `CreakingHeartBlockEntity.removeProtector`.
    CreakingHeart,
    // No side effect, but `BeaconBlockEntity.setRemoved` plays the
    // deactivation sound whenever it goes.
    Beacon,
}

// The side effect of removing the block entity of block `name` (a
// `minecraft:` identifier).
pre_remove :: proc(name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let n = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let contents = |slots| PreRemove::Contents {
    // rust: slots,
    // rust: furnace: false,
}
    // rust: match n {
    // rust: "chest" | "trapped_chest" | "barrel" => contents(27),
    // rust: _ if n.ends_with("copper_chest") => contents(27),
    // rust: _ if n.ends_with("shulker_box") => PreRemove::ShulkerBox,
    // rust: "hopper" => contents(5),
    // rust: "dispenser" | "dropper" | "crafter" => contents(9),
    // rust: "brewing_stand" => contents(5),
    // rust: "chiseled_bookshelf" => contents(6),
    // rust: _ if n.ends_with("_shelf") => contents(3),
    // rust: "decorated_pot" => contents(1),
    // rust: "furnace" | "blast_furnace" | "smoker" => PreRemove::Contents {
    // rust: slots: 3,
    // rust: furnace: true,
    // rust: },
    // rust: "campfire" | "soul_campfire" => PreRemove::Campfire,
    // rust: "jukebox" => PreRemove::Jukebox,
    // rust: "lectern" => PreRemove::Lectern,
    // rust: "sculk_shrieker" => PreRemove::SculkShrieker,
    // rust: "creaking_heart" => PreRemove::CreakingHeart,
    // rust: "beacon" => PreRemove::Beacon,
    // rust: _ => PreRemove::Nothing,
}
}

// One item entity of a spill: position, stack size and motion.
Spilled :: struct {
    pos: [f64,
    count: u32,
    motion: [f64,
}

// `Containers.dropItemStack(level, pos.x, pos.y, pos.z, stack)` for a stack
// of `count` items: the spot inside the block, then pieces of 10 to 30 items
// with triangular motions, all from the level random. An empty stack still
// draws the spot.
    // rust: pub fn drop_item_stack<R: RandomSource>(random: &mut R, pos: BlockPos, count: u32) -> Vec<Spilled> {
    // EntityTypes.ITEM is 0.25 wide.
    // rust: let size = f64::from(0.25f32);
    // rust: let center_range = 1.0 - size;
    // rust: let half = size / 2.0;
    // rust: let x = f64::from(pos.x) + random.next_double() * center_range + half;
    // rust: let y = f64::from(pos.y) + random.next_double() * center_range;
    // rust: let z = f64::from(pos.z) + random.next_double() * center_range + half;
    // rust: let mut left = count;
    // rust: let mut out = Vec::new();
    // rust: while left > 0 {
    // rust: let piece = (random.next_int_bound(21).unwrap_or(0) + 10) as u32;
    // rust: let piece = piece.min(left);
    // rust: left -= piece;
    // rust: let deviation = 0.114_850_001_711_398_36;
    // rust: let motion = [
    // rust: random.triangle(0.0, deviation),
    // rust: random.triangle(0.2, deviation),
    // rust: random.triangle(0.0, deviation),
    // rust: ];
    // rust: out.push(Spilled {
    // rust: pos: [x, y, z],
    // rust: count: piece,
    // rust: motion,
    // rust: });
}
    // rust: out
}

// `JukeboxBlockEntity.popOutTheItem`: `Vec3.atLowerCornerWithOffset(pos, 0.5,
// 1.01, 0.5).offsetRandomXZ(level.random, 0.7)`.
    // rust: pub fn jukebox_pop_position<R: RandomSource>(random: &mut R, pos: BlockPos) -> [f64; 3] {
    // rust: let dx = f64::from((random.next_float() - 0.5) * 0.7);
    // rust: let dz = f64::from((random.next_float() - 0.5) * 0.7);
    // rust: [
    // rust: f64::from(pos.x) + 0.5 + dx,
    // rust: f64::from(pos.y) + 1.01,
    // rust: f64::from(pos.z) + 0.5 + dz,
    // rust: ]
}

// `LecternBlockEntity.preRemoveSideEffects`: the book a quarter block
// towards the lectern's facing, one block up (`step` is the facing's x and z).
lectern_book_position :: proc(pos: BlockPos, step: [i32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let xo = 0.25f32 * step[0] as f32;
    // rust: let zo = 0.25f32 * step[1] as f32;
    // rust: [
    // rust: f64::from(pos.x) + 0.5 + f64::from(xo),
    // rust: f64::from(pos.y + 1),
    // rust: f64::from(pos.z) + 0.5 + f64::from(zo),
    // rust: ]
}

// `BlockBehaviour.spawnAfterBreak`'s experience for block `name` broken with
// an unenchanted tool: `DropExperienceBlock` ranges (a `UniformInt` draws
// `nextInt(max - min + 1) + min`, a `ConstantInt` draws nothing), redstone
// ores, the sculk family and spawners. None when the block gives none.
    // rust: pub fn break_experience<R: RandomSource>(random: &mut R, name: &str) -> Option<u32> {
    // rust: let n = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let mut uniform = |min: i32, max: i32| random.next_int_bound(max - min + 1).unwrap_or(0) + min;
    // rust: let xp = match n {
    // rust: "coal_ore" | "deepslate_coal_ore" => uniform(0, 2),
    // rust: "nether_gold_ore" => uniform(0, 1),
    // rust: "lapis_ore" | "deepslate_lapis_ore" | "nether_quartz_ore" => uniform(2, 5),
    // rust: "diamond_ore" | "deepslate_diamond_ore" | "emerald_ore" | "deepslate_emerald_ore" => {
    // rust: uniform(3, 7)
}
    // rust: "redstone_ore" | "deepslate_redstone_ore" => uniform(1, 5),
    // rust: "sculk" => 1,
    // rust: "sculk_catalyst" | "sculk_sensor" | "calibrated_sculk_sensor" | "sculk_shrieker" => 5,
    // rust: "spawner" => {
    // rust: let a = random.next_int_bound(15).unwrap_or(0);
    // rust: 15 + a + random.next_int_bound(15).unwrap_or(0)
}
    // rust: _ => return None,
}
    // rust: (xp > 0).then_some(xp as u32)
}

// `ExperienceOrb.getExperienceValue`: the largest orb size not above `value`.
orb_value :: proc(value: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: [2477, 1237, 617, 307, 149, 73, 37, 17, 7, 3, 1]
    // rust: .into_iter()
    // rust: .find(|&v| value >= v)
    // rust: .unwrap_or(1)
}
