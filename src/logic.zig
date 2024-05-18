const g = @import("game.zig");

pub fn playRound(game: *g.Game, x: c_int, y: c_int) void {
    const xSquare: u8 = @intCast(@divFloor(x, g.CELL_SIZE_X));
    const ySquare: u8 = @intCast(@divFloor(y, g.CELL_SIZE_Y));
    const position: c_int = xSquare + ySquare;
    _ = position;
    if (game.turn == g.turn.Player1) {
        game.board[xSquare][ySquare] = g.turn.Player1;
    } else {
        game.board[xSquare][ySquare] = g.turn.Player2;
    }
}
