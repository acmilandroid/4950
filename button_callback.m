%load in variables from handles structure
dowel = handles.dowel;
current_position = handles.current_piece;
board = handles.board;
chess_images = handles.chess_images;
name=get(hObject,'Tag'); %tag of button just pressed
handle_name = strcat('handles.',name);
move_pieces = handles.move_pieces;
moves = handles.moves;
tg=slrt;
number = str2double(erase(name,'pushbutton'));
R = floor((number-1)/8)+1;
C = number-8*(R-1);
if isempty(board)
    return
end
if(max(current_position)>0) %if a piece has already been clicked
    if(all(current_position == [R,C])) %if that piece is clicked again
        handles.current_piece = [0 0];
        unhighlight_squares(handles,board);
        guidata(hObject,handles);
        return;
    end
    %type of piece that was selected last time
    piece_type = squeeze(board(current_position(1),current_position(2),3:4))';
    for i=1:length(handles.possible_pieces) %convert type of piece to name of piece
        if(all(handles.pieces{handles.possible_pieces{i},3:4} == piece_type))
            break;
        end
    end
    x=find(squeeze(moves.(move_pieces{i})(current_position(1),current_position(2),:))==2,1); %if multiple pieces
    if(~any(moves.(move_pieces{i})(R,C,x) == 1)) %not a legal move
        msgbox('Cannot move here');
        return;
    end
    tic; %start timer
    %move piece to see if it would cause king to be in check
    temp = board(R,C,3:4); 
    board(R,C,3:4) = handles.pieces{handles.possible_pieces{i},3:4};
    board(current_position(1),current_position(2),3:4)=[0 0];
    moves=get_moves(board);
    % if robot team would be in check, revert back
%    if(test_check(moves,1))
%         msgbox('Must get out of check');
%         board(current_position(1),current_position(2),3:4)=board(R,C,3:4);
%         board(R,C,3:4) = temp;
%         moves=get_moves(board);
%         return
%    end
    % did not cause check so update graphical info and remove piece from
    % current position variable
%    move(tg,current_position,[R,C]);
    old_square = sprintf('handles.pushbutton%i',(current_position(1)-1)*length(board(1,:,1))+current_position(2));
    set(eval(old_square),'cdata',[]);
    set(eval(handle_name),'cdata',chess_images{i});
    current_position = [0 0];
    unhighlight_squares(handles,board);
    %hit load cell
    time = toc;
    msgbox(sprintf('%f seconds for move',time));
    %no piece previously selected so check to see if there is a piece there
elseif(any(board(R,C,3)))
    %if piece is on human team, attempt to kill it
    if(board(R,C,4) == 2)
        killer = kill(moves,[R,C]);
        if(max(killer) == 0)
            msgbox('Unable to kill piece');
            return;
        end
        %convert piece type to name of piece
        piece_type = squeeze(board(killer(1),killer(2),3:4))';
        for i=1:length(handles.possible_pieces) %find out which type of piece
            if(all(handles.pieces{handles.possible_pieces{i},3:4} == piece_type))
                break;
            end
        end
        %check to see if it would cause check
        temp = board(R,C,3:4);
        board(R,C,3:4) = handles.pieces{handles.possible_pieces{i},3:4};
        board(killer(1),killer(2),3:4)=[0 0];
        moves=get_moves(board);
%        if(test_check(moves,2))
%            msgbox('Must get out of check');
%            board(killer(1),killer(2),3:4)=board(R,C,3:4);
%            board(R,C,3:4) = temp;
%            moves=get_moves(board);
%            return
%        end
        %doesn't cause check, proceed
        tic
        move(tg,killer,[R,C]);
        piece_type = squeeze(board(killer(1),killer,3:4))';
        old_square = sprintf('handles.pushbutton%i',((killer(1))-1)*length(board(1,:,1))+killer(2));
        set(eval(old_square),'cdata',[]);
        set(eval(handle_name),'cdata',chess_images{i});
        current_position = [0 0];
        unhighlight_squares(handles,board);
        %hit load cell
        time = toc;
        msgbox(sprintf('%f seconds for move',time));
   %if selected piece is on robot team, make it current piece
   elseif(board(R,C,4) == 1)
        piece_type = squeeze(board(R,C,3:4))';
        current_position = [R C];
        for i=1:length(handles.possible_pieces) %find out which type of piece
            if(all(handles.pieces{handles.possible_pieces{i},3:4} == piece_type))
                break;
            end
        end
        %display(moves.(move_pieces{i}));
        highlight_squares(handles, current_position, move_pieces{i}, chess_images)
    end
end
%update handles structure
tg = slrt;
handles.board = board;
handles.moves = moves;
handles.current_piece = current_position;
handles.dowel = dowel;
guidata(hObject,handles);