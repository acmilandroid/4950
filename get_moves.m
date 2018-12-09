%% get_moves.m
% gets all moves of all pieces
% takes arguments of board matrix
% returns struct of moves for each piece type
% piece type: (1 - king, 2 - queen, 3 - rook, 4 - bishop, 5 - knight, 6 - pawn)

function moves = get_moves(board)
    
    %creates arrays for each piece of each team
    king1 = zeros(8,8);
    king2 = zeros(8,8);
    queen1 = zeros(8,8);
    queen2 = zeros(8,8);
    rook1 = zeros(8,8);
    rook2 = zeros(8,8);
    bishop1 = zeros(8,8);
    bishop2 = zeros(8,8);
    knight1 = zeros(8,8);
    knight2 = zeros(8,8);
    pawn1 = zeros(8,8);
    pawn2 = zeros(8,8);
    
    %sets counts for the number for each piece
    r1 = 1;
    r2 = 1;
    b1 = 1;
    b2 = 1;
    k1 = 1;
    k2 = 1;
    p1 = 1;
    p2 = 1;
    
    %loops through board and sets move zones
    for r = 1:8
        for c = 1:8
            if board(r,c,3) == 1 %sets king's move zone
                direction = [-1,-1; -1,0; -1,1; 0,1; 1,1; 1,0; 1,-1; 0,-1];
                for dir_index = 1:8 %checks each direction
                    r_new = direction(dir_index,1);
                    c_new = direction(dir_index,2);
                    if (r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9)
                        if board(r,c,4) == 1 %set team 1 killzone
                            king1(r,c) = 2;
                            if board(r+r_new,c+c_new,4) ~= 1
                                king1(r+r_new,c+c_new) = 1;
                            end
                        else %set team 2 killzone
                            king2(r,c) = 2;
                            if board(r+r_new,c+c_new,4) ~= 2
                                king2(r+r_new,c+c_new) = 1;
                            end
                        end
                    end
                end
            elseif board(r,c,3) == 2 %sets queen's move zone
                direction = [-1,-1; -1,0; -1,1; 0,1; 1,1; 1,0; 1,-1; 0,-1];
                for dir_index = 1:8 %checks each direction
                    r_new = direction(dir_index,1);
                    c_new = direction(dir_index,2);
                    if board(r,c,4) == 1 %set team 1 moves
                        queen1(r,c) = 2;
                        while ((r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9) && (board(r+r_new,c+c_new,4) ~= 1))
                            queen1(r+r_new,c+c_new) = 1;
                            if board(r+r_new,c+c_new,4) == 2
                                break;
                            end
                            r_new = r_new+direction(dir_index,1);
                            c_new = c_new+direction(dir_index,2);
                        end
                    else %set team 2 moves
                        queen2(r,c) = 2;
                        while ((r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9) && (board(r+r_new,c+c_new,4) ~= 2))
                            queen2(r+r_new,c+c_new) = 1;
                            if board(r+r_new,c+c_new,4) == 1
                                break;
                            end
                            r_new = r_new+direction(dir_index,1);
                            c_new = c_new+direction(dir_index,2);
                        end
                    end
                end
            elseif board(r,c,3) == 3 %sets rook's move zone 
                direction = [-1,0; 0,1; 1,0; 0,-1]; 
                if board(r,c,4) == 1 %set team 1 moves
                    rook1(r,c,r1) = 2;
                    for dir_index = 1:4
                        r_new = direction(dir_index,1);
                        c_new = direction(dir_index,2);
                        while ((r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9) && (board(r+r_new,c+c_new,4) ~= 1))
                            rook1(r+r_new,c+c_new,r1) = 1;
                            if board(r+r_new,c+c_new,4) == 2
                                break;
                            end
                            r_new = r_new+direction(dir_index,1);
                            c_new = c_new+direction(dir_index,2);
                        end
                    end
                    r1 = r1 + 1;
                else %set team 2 moves
                    rook2(r,c,r2) = 2;
                    for dir_index = 1:4
                        r_new = direction(dir_index,1);
                        c_new = direction(dir_index,2);
                        while ((r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9) && (board(r+r_new,c+c_new,4) ~= 2))
                            rook2(r+r_new,c+c_new,r2) = 1;
                            if board(r+r_new,c+c_new,4) == 1
                                break;
                            end
                            r_new = r_new+direction(dir_index,1);
                            c_new = c_new+direction(dir_index,2);
                        end
                    end
                    r2 = r2 + 1;
                end
            elseif board(r,c,3) == 4 %sets bishop's move zone
                direction = [-1,-1; -1,1; 1,1; 1,-1];
                if board(r,c,4) == 1 %set team 1 moves
                    bishop1(r,c,b1) = 2;
                    for dir_index = 1:4
                        r_new = direction(dir_index,1);
                        c_new = direction(dir_index,2);
                        while ((r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9) && (board(r+r_new,c+c_new,4) ~= 1))
                            bishop1(r+r_new,c+c_new,b1) = 1;
                            if board(r+r_new,c+c_new,4) == 2
                                break;
                            end
                            r_new = r_new+direction(dir_index,1);
                            c_new = c_new+direction(dir_index,2);
                        end
                    end
                    b1 = b1 + 1;
                else %set team 2 moves
                    bishop2(r,c,b2) = 2;
                    for dir_index = 1:4
                        r_new = direction(dir_index,1);
                        c_new = direction(dir_index,2);
                        while ((r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9) && (board(r+r_new,c+c_new,4) ~= 2))
                            bishop2(r+r_new,c+c_new,b2) = 1;
                            if board(r+r_new,c+c_new,4) == 1
                                break;
                            end
                            r_new = r_new+direction(dir_index,1);
                            c_new = c_new+direction(dir_index,2);
                        end
                    end
                    b2 = b2 + 1;
                end
            elseif board(r,c,3) == 5 %sets knight's move zone
                direction = [2,-1; 2,1; 1,2; -1,2; -2,1; -2,-1; -1,-2; 1,-2];
                if board(r,c,4) == 1 %set team 1 moves    
                    knight1(r,c,k1) = 2;
                    for dir_index = 1:8 %checks each direction
                        r_new = direction(dir_index,1);
                        c_new = direction(dir_index,2);
                        if (r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9)
                            if board(r+r_new,c+c_new,4) ~= 1
                                knight1(r+r_new,c+c_new,k1) = 1;
                            end 
                        end
                    end
                    k1 = k1 + 1;
                else %set team 2 moves
                    knight2(r,c,k2) = 2;
                    for dir_index = 1:8 %checks each direction
                        r_new = direction(dir_index,1);
                        c_new = direction(dir_index,2);
                        if (r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9)
                            if board(r+r_new,c+c_new,4) ~= 2
                                knight2(r+r_new,c+c_new,k2) = 1;
                            end 
                        end
                    end
                    k2 = k2 + 1;
                end
            elseif board(r,c,3) == 6 %sets pawn's move zone
                if board(r,c,4) == 1 %set team 1 moves
                    pawn1(r,c,p1) = 2;
                    if r+1 < 9 && board(r+1,c,4) == 0
                        pawn1(r+1,c,p1) = 1;
                    end
                    if r+1 < 9 && c+1 < 9 && board(r+1,c+1,4) == 2
                        pawn1(r+1,c+1,p1) = 1;
                    end
                    if r+1 < 9 && c-1 > 0 && board(r+1,c-1,4) == 2
                        pawn1(r+1,c-1,p1) = 1;
                    end
                    p1 = p1 + 1;
                else %set team 2 moves
                    pawn2(r,c,p2) = 2;
                    if r-1 > 0 && board(r-1,c,4) == 0
                        pawn2(r-1,c,p2) = 1;
                    end
                    if r-1 > 0 && c+1 < 9 && board(r-1,c+1,4) == 1
                        pawn2(r-1,c+1,p2) = 1;
                    end
                    if r-1 > 0 && c-1 > 0 && board(r-1,c-1,4) == 1
                        pawn2(r-1,c-1,p2) = 1;
                    end
                    p2 = p2 + 1;
                end
            end
        end
    end
    
    %puts everything in a struct
    moves.board = board;
    moves.king1 = king1;
    moves.king2 = king2;
    moves.queen1 = queen1;
    moves.queen2 = queen2;
    moves.rook1 = rook1;
    moves.rook2 = rook2;
    moves.bishop1 = bishop1;
    moves.bishop2 = bishop2;
    moves.knight1 = knight1;
    moves.knight2 = knight2;
    moves.pawn1 = pawn1;
    moves.pawn2 = pawn2;
    
end