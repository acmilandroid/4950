%% test_check.m
% tests king for check
% takes argument of moves struct and which king to check
% returns 1 if check, 0 if not

function check = test_check(moves,team)
    
    %test for team 1 check (robot's team)
    if team == 1
        %get position of king
        [r,c] = find(moves.king1 == 2);
        check = 0;
        if (moves.king2(r,c) == 1) || (moves.queen2(r,c) == 1) %check by king/queen
            check = 1;
        else
            for i = 1:size(moves.rook2,3) %check by rook
                if moves.rook2(r,c,i) == 1
                    check = 1;
                end
            end
            for i = 1:size(moves.bishop2,3) %check by bishop
                if moves.bishop2(r,c,i) == 1
                    check = 1;
                end
            end
            for i = 1:size(moves.knight2,3) %check by knight
                if moves.knight2(r,c,i) == 1
                    check = 1;
                end
            end
            for i = 1:size(moves.pawn2,3) %check by pawn
                if moves.pawn2(r,c,i) == 1
                    check = 1;
                end
            end
        end
    elseif team == 2
        %get position of king
        [r,c] = find(moves.king2 == 2);
        check = 0;
        if (moves.king1(r,c) == 1) || (moves.queen1(r,c) == 1) %check by king/queen
            check = 1;
        else
            for i = 1:size(moves.rook1,3) %check by rook
                if moves.rook1(r,c,i) == 1
                    check = 1;
                end
            end
            for i = 1:size(moves.bishop1,3) %check by bishop
                if moves.bishop1(r,c,i) == 1
                    check = 1;
                end
            end
            for i = 1:size(moves.knight1,3) %check by knight
                if moves.knight1(r,c,i) == 1
                    check = 1;
                end
            end
            for i = 1:size(moves.pawn1,3) %check by pawn
                if moves.pawn1(r,c,i) == 1
                    check = 1;
                end
            end
        end
    end
    
end
    