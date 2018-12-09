%% get_check.m
% find piece and position to move to check player 2's king
% takes argument of moves struct
% returns piece to move and position to move to
% returns [0,0] for both if already in check

function [piece,position] = get_check(moves)

    check = test_check(moves,2);
    piece = [0,0];
    position = [0,0];

    %test queen
    [r,c] = find(moves.queen1 == 2);
    if isempty([r,c]) == 0 && check == 0 %if queen exists
        [x,y] = find(moves.queen1 == 1);
        for index = 1:size(x,1) %checks each move
            r_new = x(index);
            c_new = y(index);
            %set new queen position
            moves.board(r,c,3) = 0;
            moves.board(r_new,c_new,3) = 2;
            moves.board(r,c,4) = 0;
            moves.board(r_new,c_new,4) = 1;
            moves = get_moves(moves.board);
            check = test_check(moves,2);
            %resets board
            moves.board(r,c,3) = 2;
            moves.board(r_new,c_new,3) = 0;
            moves.board(r,c,4) = 1;
            moves.board(r_new,c_new,4) = 0;
            if check == 1
                piece = [r,c];
                position = [r_new,c_new];
                break;
            end
        end
    end
    
    %test rook
    [r,c] = find(moves.rook1(:,:,1) == 2);
    if isempty([r,c]) == 0 && check == 0 %if rook exists
        for i = 1:size(moves.rook1,3)
            [r,c] = find(moves.rook1(:,:,i) == 2);
            [x,y] = find(moves.rook1(:,:,i) == 1);
            for index = 1:size(x,1) %checks each move
                r_new = x(index);
                c_new = y(index);
                %set new rook position
                moves.board(r,c,3) = 0;
                moves.board(r_new,c_new,3) = 3;
                moves.board(r,c,4) = 0;
                moves.board(r_new,c_new,4) = 1;
                moves = get_moves(moves.board);
                check = test_check(moves,2);
                %resets board
                moves.board(r,c,3) = 3;
                moves.board(r_new,c_new,3) = 0;
                moves.board(r,c,4) = 1;
                moves.board(r_new,c_new,4) = 0;
                if check == 1
                    piece = [r,c];
                    position = [r_new,c_new];
                    break;
                end
            end
        end
    end
    
    %test bishop
    [r,c] = find(moves.bishop1(:,:,1) == 2);
    if isempty([r,c]) == 0 && check == 0 %if bishop exists
        for i = 1:size(moves.bishop1,3)
            if check == 1
                break;
            end
            [r,c] = find(moves.bishop1(:,:,i) == 2);
            [x,y] = find(moves.bishop1(:,:,i) == 1);
            for index = 1:size(x,1) %checks each move
                r_new = x(index);
                c_new = y(index);
                %set new bishop position
                moves.board(r,c,3) = 0;
                moves.board(r_new,c_new,3) = 4;
                moves.board(r,c,4) = 0;
                moves.board(r_new,c_new,4) = 1;
                moves = get_moves(moves.board);
                check = test_check(moves,2);
                %resets board
                moves.board(r,c,3) = 4;
                moves.board(r_new,c_new,3) = 0;
                moves.board(r,c,4) = 1;
                moves.board(r_new,c_new,4) = 0;
                if check == 1
                    piece = [r,c];
                    position = [r_new,c_new];
                    break;
                end
            end
        end
    end
    
    %test knight
    [r,c] = find(moves.knight1(:,:,1) == 2);
    if isempty([r,c]) == 0 && check == 0 %if knight exists
        for i = 1:size(moves.knight1,3)
            if check == 1
                break;
            end
            [r,c] = find(moves.knight1(:,:,i) == 2);
            [x,y] = find(moves.knight1(:,:,i) == 1);
            for index = 1:size(x,1) %checks each move
                r_new = x(index);
                c_new = y(index);
                %set new knight position
                moves.board(r,c,3) = 0;
                moves.board(r_new,c_new,3) = 5;
                moves.board(r,c,4) = 0;
                moves.board(r_new,c_new,4) = 1;
                moves = get_moves(moves.board);
                check = test_check(moves,2);
                %resets board
                moves.board(r,c,3) = 5;
                moves.board(r_new,c_new,3) = 0;
                moves.board(r,c,4) = 1;
                moves.board(r_new,c_new,4) = 0;
                if check == 1
                    piece = [r,c];
                    position = [r_new,c_new];
                    break;
                end
            end
        end
    end
    
    [r,c] = find(moves.pawn1(:,:,1) == 2);
    if isempty([r,c]) == 0 && check == 0 %if pawn exists
        for i = 1:size(moves.pawn1,3)
            if check == 1
                break;
            end
            [r,c] = find(moves.pawn1(:,:,i) == 2);
            [x,y] = find(moves.pawn1(:,:,i) == 1);
            for index = 1:size(x,1) %checks each move
                r_new = x(index);
                c_new = y(index);
                %set new pawn position
                moves.board(r,c,3) = 0;
                moves.board(r_new,c_new,3) = 6;
                moves.board(r,c,4) = 0;
                moves.board(r_new,c_new,4) = 1;
                moves = get_moves(moves.board);
                check = test_check(moves,2);
                %resets board
                moves.board(r,c,3) = 6;
                moves.board(r_new,c_new,3) = 0;
                moves.board(r,c,4) = 1;
                moves.board(r_new,c_new,4) = 0;
                if check == 1
                    piece = [r,c];
                    position = [r_new,c_new];
                    break;
                end
            end
        end
    end
        
end