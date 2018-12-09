function unhighlight_squares(handles,board)
images = handles.chess_images;
pieces = handles.pieces;
possible_pieces = handles.possible_pieces;
for i=1:length(board(:,1,1))
    for j = 1:length(board(1,:,1))
        piece_type = squeeze(board(i,j,3:4))';
        square = eval(sprintf('handles.pushbutton%i',(i-1)*length(board(1,:,1))+j));
        set(square,'BackgroundColor',[.94 .94 .94]);
        if ~isempty(get(square,'cdata'))
            for k=1:length(images)
                if(all(pieces{possible_pieces{k},3:4} == piece_type))
                    set(square,'cdata',images{k});
                end
            end     
        end
    end
end
