%% defend.m
% determines where to move king to avoid check
% check to see if king will move into check
% takes argument of moves struct and moves.board matrix
% returns [0,0] if no check
% returns [-1,-1] if checkmate

function position = defend(moves)

    %get position of king
    [r,c] = find(moves.king1 == 2);

    flag = test_check(moves,1); %test for check
    
    %sets position to move king to
    if flag == 0 %if no check
        position = [0,0]; %return [0,0] if no check
    else
        flag = 0; %reset flag
        direction = [-1,-1; -1,0; -1,1; 0,1; 1,1; 1,0; 1,-1; 0,-1];
        for dir_index = 1:8 %checks each direction
             r_new = direction(dir_index,1);
             c_new = direction(dir_index,2);
             if (r+r_new > 0 && r+r_new < 9 && c+c_new > 0 && c+c_new < 9)
                 %move piece and check for checkmate
                 moves.board(r,c,3) = 0;
                 moves.board(r+r_new,c+c_new,3) = 1;
                 moves.board(r,c,4) = 0;
                 moves.board(r+r_new,c+c_new,4) = 1;
                 moves = get_moves(moves.board);

                 flag = test_check(moves,1);
                 %reset board back
                 moves.board(r,c,3) = 1;
                 moves.board(r+r_new,c+c_new,3) = 0;
                 moves.board(r,c,4) = 1;
                 moves.board(r+r_new,c+c_new,4) = 0;
                 moves = get_moves(moves.board);
                 if flag == 0
                     position = [r+r_new,c+c_new];
                     break;
                 end
             end
        end
        if flag == 1 %if still in check after all moves
            position = [-1,-1]; %return [-1,-1] on checkmate
        end
    end
    
end