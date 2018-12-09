function highlight_squares(handles, position, piece, images)
moves = handles.moves;
board = moves.board;
image_data = handles.chess_images;
possible_pieces = handles.possible_pieces;
table  = handles.pieces;
x=find(squeeze(moves.(piece)(position(1),position(2),:))==2,1); %if multiple pieces
%did not find specified piece in that position
if isempty(x)
    return;
end

[R,C] =find(moves.(piece)(:,:,x) == 1);
for k = 1:length(R)
    i=R(k);
    j=C(k);
    piece_type = squeeze(board(i,j,3:4))';
    square = eval(sprintf('handles.pushbutton%i',(i-1)*length(moves.board(1,:,1))+j));
    if isempty(get(square,'cdata'))
        set(square,'BackgroundColor',[1 1 210/255]);
    else
        for j=1:length(images)
            if(all(table{possible_pieces{j},3:4} == piece_type))
                highlight = image_data{j};
                highlight(highlight(:,:,3)>210) = 210;
                set(square,'cdata',highlight);
                break;
            end
        end
    end
end