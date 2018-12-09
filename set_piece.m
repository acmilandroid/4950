%% set pieces of dowel
% takes argument integer for color, shape, and piece
% see dowel columns comment for arguments
% call this function after shape_detection

%   Dowel Column Definitions:
%   1: row
%   2: column
%   3: color
%       (1 - red, 2 - green, 3 - blue, 4 - yellow)
%   4: shape
%       (1 - square, 2 - circle, 3 - triangle)
%   5: piece type 
%       (1 - king, 2 - queen, 3 - rook, 4 - bishop, 5 - knight, 6 - pawn)
%   6: team (1 or 2)
function dowel = set_piece(dowel, color, shape, piece, team)
    total_pieces = size(dowel(:,1));
    total_pieces = total_pieces(1);
    for i = 1:total_pieces
        if (dowel(i,3) == color && dowel(i,4) == shape)
            dowel(i,5) = piece;
            dowel(i,6) = team;
        end
    end
end