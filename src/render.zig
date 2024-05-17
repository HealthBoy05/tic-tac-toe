const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
    @cInclude("SDL2/SDL2_gfxPrimitives.h");
});
const red = g.Color{ .r = 255, .g = 0, .b = 0, .a = 255 };
const g = @import("./game.zig");
const l = @import("./logic.zig");
const N = 3;

pub fn render(ren: *c.SDL_Renderer) void {
    _ = c.SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);
    drawBoard(ren, g.PLAYING_COLOR);
    drawX(ren, 5, g.PLAYER_X_COLOR);
    drawO(ren, 6, g.PLAYER_Y_COLOR);
    // empty board
    // on click, we check if the game state is running
    // if running we draw the correct symbol in the position
    // tie we color the board grey
    // if win we color the board red <- after
}
fn drawBoard(ren: *c.SDL_Renderer, color: g.Color) void {
    _ = c.SDL_SetRenderDrawColor(ren, color.r, color.g, color.b, color.a);
    for (1..4) |i| {
        const x: i32 = @intCast((g.CELL_SIZE_X * i));
        const y: i32 = @intCast((g.CELL_SIZE_Y * i));

        _ = c.SDL_RenderDrawLine(ren, x, 0, x, g.SCREEN_HEIGHT);
        _ = c.SDL_RenderDrawLine(ren, 0, y, g.SCREEN_WIDTH, y);
    }
}

fn drawX(ren: *c.SDL_Renderer, position: c_int, color: g.Color) void {
    const squareX: c_int = @mod((position - 1), g.N);
    const squareY: c_int = @divFloor((position - 1), g.N);
    const paddingX: i16 = @intFromFloat(@as(f32, g.CELL_SIZE_X) * 0.25);
    const paddingY: i16 = @intFromFloat(@as(f32, g.CELL_SIZE_Y) * 0.25);

    const leftOfCell: i16 = @intCast((g.CELL_SIZE_X * squareX) + paddingX);
    const rightOfCell: i16 = @intCast((g.CELL_SIZE_X * (squareX + 1)) - paddingX);
    const topOfCell: i16 = @intCast((g.CELL_SIZE_Y * squareY) + paddingY);
    const bottomOfCell: i16 = @intCast((g.CELL_SIZE_Y * (squareY + 1)) - paddingY);
    _ = c.thickLineRGBA(ren, leftOfCell, topOfCell, rightOfCell, bottomOfCell, 10, color.r, color.g, color.b, color.a);
    _ = c.thickLineRGBA(ren, leftOfCell, bottomOfCell, rightOfCell, topOfCell, 10, color.r, color.g, color.b, color.a);
}

fn drawO(ren: *c.SDL_Renderer, position: c_int, color: g.Color) void {
    const squareX: c_int = @mod((position - 1), g.N);
    const squareY: c_int = @divFloor((position - 1), g.N);

    const leftOfCell: i16 = @intCast(g.CELL_SIZE_X * squareX);
    const topOfCell: i16 = @intCast(g.CELL_SIZE_Y * squareY);
    const midCellX: i16 = @intCast((g.CELL_SIZE_X / 2) + leftOfCell);
    const midCellY: i16 = @intCast((g.CELL_SIZE_Y / 2) + topOfCell);

    _ = c.filledCircleRGBA(ren, midCellX, midCellY, 50, color.r, color.g, color.b, color.a);
    _ = c.filledCircleRGBA(ren, midCellX, midCellY, 40, 255, 255, 255, 255);
}
