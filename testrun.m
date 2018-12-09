%% overall test run
% team 1 is robot's team

topleft = [93,37];
bottomright = [522,465];
cam = webcam('USB Video Device');

dowel = shape_detection(topleft, bottomright, cam);

% dowel = set_piece(dowel,1,1,1,1);
% dowel = set_piece(dowel,1,2,2,1);
 dowel = set_piece(dowel,1,3,2,2); %red triangle
% dowel = set_piece(dowel,2,1,1,2); %green square
 dowel = set_piece(dowel,2,2,2,1); %green circle
% dowel = set_piece(dowel,2,3,6,1); %green triangle
% 
% %set team 2
% dowel = set_piece(dowel,3,1,1,2);
% dowel = set_piece(dowel,3,2,2,2); 
% dowel = set_piece(dowel,3,3,2,1); %blue triangle
% dowel = set_piece(dowel,4,1,3,1); %yellow square
% dowel = set_piece(dowel,4,2,5,2);
% dowel = set_piece(dowel,4,3,4,1); %yellow triangle


board = make_board(topleft, bottomright, dowel);

moves = get_moves(board);
killer = kill(moves,[5,1]);
%defend = defend(moves);
%[piece,position] = get_check(moves);

move(tg, killer, [5,1]);


