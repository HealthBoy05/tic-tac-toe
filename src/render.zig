const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
    @cInclude("SDL2/SDL2_gfxPrimitives.h");
});
const red = g.Color{ .r = 255, .g = 0, .b = 0, .a = 255 };
const g = @import("./game.zig");
const l = @import("./logic.zig");
const N = 3;

pub fn render(ren: *c.SDL_Renderer, game: g.Game) void {
    _ = c.SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);

    switch (game.state) {
        .Running => {
            drawBoard(ren, g.PLAYING_COLOR);
            drawXAndO(ren, game.board);
        },
        .Tie => {
            drawBoard(ren, g.PLAYING_COLOR);
            drawXAndO(ren, game.board);
        },
        .Over => {
            const winningColor: g.Color = switch (game.turn) {
                .Player1 => g.PLAYER_X_COLOR,
                .Player2 => g.PLAYER_Y_COLOR,
            };
            drawBoard(ren, winningColor);
            drawXAndO(ren, game.board);
        },
        .Quit => {},
    }
}

fn drawXAndO(ren: *c.SDL_Renderer, board: [3][3]g.symbol) void {
    for (0..3) |i| {
        for (0..3) |j| {
            const symbol = board[i][j];
            switch (symbol) {
                .Player1 => {
                    drawX(ren, j, i, g.PLAYER_X_COLOR);
                },
                .Player2 => {
                    drawO(ren, j, i, g.PLAYER_Y_COLOR);
                },
                .None => {},
            }
        }
    }
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

fn drawX(ren: *c.SDL_Renderer, x: usize, y: usize, color: g.Color) void {
    const squareX: c_int = @intCast(x);
    const squareY: c_int = @intCast(y);
    const paddingX: i16 = @intFromFloat(@as(f32, g.CELL_SIZE_X) * 0.25);
    const paddingY: i16 = @intFromFloat(@as(f32, g.CELL_SIZE_Y) * 0.25);

    const leftOfCell: i16 = @intCast((g.CELL_SIZE_X * squareX) + paddingX);
    const rightOfCell: i16 = @intCast((g.CELL_SIZE_X * (squareX + 1)) - paddingX);
    const topOfCell: i16 = @intCast((g.CELL_SIZE_Y * squareY) + paddingY);
    const bottomOfCell: i16 = @intCast((g.CELL_SIZE_Y * (squareY + 1)) - paddingY);

    _ = c.thickLineRGBA(ren, leftOfCell, topOfCell, rightOfCell, bottomOfCell, 10, color.r, color.g, color.b, color.a);
    _ = c.thickLineRGBA(ren, leftOfCell, bottomOfCell, rightOfCell, topOfCell, 10, color.r, color.g, color.b, color.a);
}

fn drawO(ren: *c.SDL_Renderer, x: usize, y: usize, color: g.Color) void {
    const squareX: c_int = @intCast(x);
    const squareY: c_int = @intCast(y);

    const leftOfCell: i16 = @intCast(g.CELL_SIZE_X * squareX);
    const topOfCell: i16 = @intCast(g.CELL_SIZE_Y * squareY);
    const midCellX: i16 = @intCast((g.CELL_SIZE_X / 2) + leftOfCell);
    const midCellY: i16 = @intCast((g.CELL_SIZE_Y / 2) + topOfCell);

    _ = c.filledCircleRGBA(ren, midCellX, midCellY, 50, color.r, color.g, color.b, color.a);
    _ = c.filledCircleRGBA(ren, midCellX, midCellY, 40, 255, 255, 255, 255);
}
