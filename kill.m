%% kill.m
% kills an opponent piece
% takes arguments of move struct and coordinates in array
% returns coordinates of piece to move
% return [0,0] if no pieces can kill the given location

function killer = kill(moves,location)
    r = location(1);
    c = location(2);
    
    killers = zeros(6);
    
    %check if king can kill
    [row,col] = find(moves.king1 == 2);
    if isempty([row,col]) == 0
        if moves.king1(r,c) == 1
            killers(1,1) = pdist([row,col;location]);
        end
    else
        killers(1) = 0;
    end
    if killers(1,1) ~= 0 %if king can kill, check if its in check
        moves.board(row,col,3) = 0;
        moves.board(r,c,3) = 1;
        moves.board(row,col,4) = 0;
        moves.board(r,c,4) = 1;
        moves = get_moves(moves.board);
        flag = test_check(moves,1);
        if flag == 1
            killers(1) = 0; %king cannot kill if it moves into check
        end
        %reset game board
        moves.board(row,col,3) = 1;
        moves.board(r,c,3) = 0;
        moves.board(row,col,4) = 1;
        moves.board(r,c,4) = 0;
        moves = get_moves(moves.board);
    end
    
    %check if queen can kill
    [row,col] = find(moves.queen1 == 2);
    if isempty([row,col]) == 0
        if moves.queen1(r,c) == 1
            killers(2) = pdist([row,col;location]);
        end
    else
        killers(2) = 0;
    end
    
    %check if rooks can kill
    for i = 1:size(moves.rook1,3)
        [row,col] = find(moves.rook1(:,:,i) == 2);
        if isempty([row,col]) == 0
            if moves.rook1(r,c,i) == 1
                killers(3,i) = pdist([row,col;location]);
            else
                killers(3,i) = 0;
            end
        end
    end
    
    %chek if bishops can kill
    for i = 1:size(moves.bishop1,3)
        [row,col] = find(moves.bishop1(:,:,i) == 2);
        if isempty([row,col]) == 0
            if moves.bishop1(r,c,i) == 1
                killers(4,i) = pdist([row,col;location]);
            else
                killers(4,i) = 0;
            end
        end
    end
    
    %check if knights can kill
    for i = 1:size(moves.knight1,3)
        [row,col] = find(moves.knight1(:,:,i) == 2);
        if isempty([row,col]) == 0
            if moves.knight1(r,c,i) == 1
                killers(5,i) = pdist([row,col;location]);
            else
                killers(5,i) = 0;
            end
        end
    end
    
    %check if pawns can kill
    for i = 1:size(moves.pawn1,3)
        [row,col] = find(moves.pawn1(:,:,i) == 2);
        if isempty([row,col]) == 0
            if moves.pawn1(r,c,i) == 1
                killers(6,i) = pdist([row,col;location]);
            else
                killers(6,i) = 0;
            end
        end
    end
    
    %set zeros to infinity to find minimum
    killers(killers == 0) = inf;
    
    %find minimum distance
    minimum = min(min(killers));
    
    %return position of piece to mvoe
    if minimum == inf
        killer = [0,0];
    else
        [row,col] = find(killers == minimum,1,'first');
        if row == 1
            [final_r,final_c] = find(moves.king1 == 2);
            killer = [final_r,final_c];
        elseif row == 2
            [final_r,final_c] = find(moves.queen1 == 2);
            killer = [final_r,final_c];
        elseif row == 3
            [final_r,final_c] = find(moves.rook1(:,:,col) == 2);
            killer = [final_r,final_c];
        elseif row == 4
            [final_r,final_c] = find(moves.bishop1(:,:,col) == 2);
            killer = [final_r,final_c];
        elseif row == 5
            [final_r,final_c] = find(moves.knight1(:,:,col) == 2);
            killer = [final_r,final_c];
        elseif row == 6
            [final_r,final_c] = find(moves.pawn1(:,:,col) == 2);
            killer = [final_r,final_c];
        end
    end
    
    
end