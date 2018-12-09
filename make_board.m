%% make board
% makes gameboard from dowels array

function board = make_board(topleft, bottomright, dowel)
    
    total_pieces = size(dowel(:,1));
    total_pieces = total_pieces(1);
    
    board = zeros(8,8,4);
    %   game board columns:
    %   1: row
    %   2: column
    %   3: piece type 
    %       (1 - king, 2 - queen, 3 - rook, 4 - bishop, 5 - knight, 6 - pawn)
    %   4: team

    %calculates row and column size of game board
    rowsize = (bottomright(1) - topleft(1)) / 8;
    colsize = (bottomright(2) - topleft(2)) / 8;

    %finds board position of dowels and copies information to gameboard
    for i = 1:total_pieces
        row = floor(dowel(i,1) / rowsize) + 1;
        col = floor(dowel(i,2) / colsize) + 1;
        board(row,col,1) = dowel(i,1);
        board(row,col,2) = dowel(i,2);
        board(row,col,3) = dowel(i,5);
        board(row,col,4) = dowel(i,6);
    end
    
end


