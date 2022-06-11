OFFSET = 4
BOARD_X_START = 0
BOARD_X_END = 9
BOARD_Y_START = 0
BOARD_Y_END = 9
CELL_SIZE = 12

board ={}

function init_board()
    for i=BOARD_Y_START,BOARD_Y_END do
        board[i] = {}
        for j=BOARD_X_START,BOARD_X_END do
            local e = {
                x=j*CELL_SIZE+OFFSET,
                y=i*CELL_SIZE+OFFSET,
                w=CELL_SIZE,
                h=CELL_SIZE,
                c=1,
            }
            board[i][j] = e
        end
    end
end

function draw_board()
    for i=BOARD_Y_START,BOARD_Y_END do
        for j=BOARD_X_START,BOARD_X_END do
            local e = board[i][j]
            rect(e.x,e.y,e.x+e.w,e.y+e.h,e.c)
        end
    end
end
