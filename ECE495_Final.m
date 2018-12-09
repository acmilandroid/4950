function varargout = ECE495_Final(varargin)
% ECE495_FINAL MATLAB code for ECE495_Final.fig
%      ECE495_FINAL, by itself, creates a new ECE495_FINAL or raises the existing
%      singleton*.
%
%      H = ECE495_FINAL returns the handle to a new ECE495_FINAL or the handle to
%      the existing singleton*.
%
%      ECE495_FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECE495_FINAL.M with the given input arguments.
%
%      ECE495_FINAL('Property','Value',...) creates a new ECE495_FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECE495_Final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECE495_Final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECE495_Final

% Last Modified by GUIDE v2.5 28-Nov-2018 11:43:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECE495_Final_OpeningFcn, ...
                   'gui_OutputFcn',  @ECE495_Final_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ECE495_Final is made visible.
function ECE495_Final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECE495_Final (see VARARGIN)

% Choose default command line output for ECE495_Final

tg = slrt;
rtwbuild('Senior_Design_G4');
tg.load('Senior_Design_G4');
tg.start;

handles.output = hObject;

handles.topleft = [93,37];
handles.bottomright = [522,465];
handles.cam = webcam('USB Video Device');

% Add other variables to handles
handles.dowel = shape_detection(handles.topleft,handles.bottomright,handles.cam);

%basic info
piece_sides = {'White','Black'};
piece_types = {'King','Queen','Rook','Bishop','Knight','Pawn'};
handles.possible_shapes = {'square', 'circle','triangle'};
handles.possible_colors = {'red', 'green', 'blue', 'yellow'};

dowel_combos = make_num_combos(handles.possible_shapes,handles.possible_colors);
dowel_combos(:) = 0;
set(handles.radiobutton1,'Value',0);
set(handles.radiobutton4,'Value',0);

piece_combos = make_num_combos(piece_sides,piece_types);
possible_pieces = cell(1,length(piece_sides)*length(piece_types));

% make sure that robot is always team 1 (piece_combos(:,1) is team int)
if(~get(handles.white_button,'Value'))
    piece_combos(:,1)= mod(piece_combos(:,1),2)+1;
end

%create possible piece color combos such as White King
for i=1:length(piece_sides)
    for j=1:length(piece_types)
        possible_pieces{(i-1)*length(piece_types)+j} = strcat([piece_sides{i},' ',piece_types{j}]);
    end
end
handles.possible_pieces = possible_pieces;
%create another possible piece combo, this time for move struct and robot
%is always team 1
move_pieces = cell(length(possible_pieces),1);
for i=1:length(possible_pieces)
    if strcmp((extractBefore(possible_pieces{i},' ')),get(handles.white_button,'String')) == get(handles.white_button,'Value')
        a= '1';
    else
        a= '2';
    end
    if strcmp((extractAfter(possible_pieces{i},' ')),'King')
        b='king';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Queen')
        b='queen';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Bishop')
        b='bishop';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Knight')
        b='knight';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Rook')
        b='rook';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Pawn')
        b='pawn';
    end
    move_pieces{i} = strcat(b,a);
end
handles.move_pieces = move_pieces;

%save images of each chess picture into handles structure
chess_images=cell(length(possible_pieces),1);
for i=1:length(possible_pieces)
    name = sprintf('images/%s.png',possible_pieces{i});
    rgb_image = imread(name);
    rgb_image=imresize(rgb_image,[45 45]);
    chess_images{i}=rgb_image;
end
handles.chess_images = chess_images;

%save everything in table since tables are convenient for access
%handles.pieces = table
handles.pieces = table(dowel_combos(:,2),dowel_combos(:,1),...
    piece_combos(:,2),piece_combos(:,1),'RowNames',possible_pieces,...
    'VariableNames',{'Color','Shape','Type','Side'});

handles.current_piece=[0 0]; %location of piece that was just pressed
handles.moves = [];
handles.board = [];

Reset_All_Callback(hObject, eventdata, handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECE495_Final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECE495_Final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(hObject,'String'));
selected_piece = contents{get(hObject,'Value')}; %chosen string from box

pieces = handles.pieces;
color_shape = pieces{selected_piece,[1,2]}; %show color/shape combo on radio buttons
shape = zeros(1,length(handles.possible_shapes)); %shape radio button set
if color_shape(2)
    shape(color_shape(2)) = 1;
end
color = zeros(1,length(handles.possible_colors)); %color radio button set
if color_shape(1)
    color(color_shape(1)) = 1;
end
set(handles.radiobutton1, 'Value',shape(1));
set(handles.radiobutton2, 'Value',shape(2));
set(handles.radiobutton3, 'Value',shape(3));

set(handles.radiobutton4, 'Value',color(1));
set(handles.radiobutton5, 'Value',color(2));
set(handles.radiobutton6, 'Value',color(3));
set(handles.radiobutton7, 'Value',color(4));


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in Shape_Choice.
function Shape_Choice_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Shape_Choice 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = get(handles.listbox1,'String');
selected_piece = contents{get(handles.listbox1,'Value')};

shape = [get(handles.radiobutton1, 'Value'),get(handles.radiobutton2, ...
    'Value'), get(handles.radiobutton3, 'Value')];

temp = find(shape,1);
if isempty(temp)
    temp = 0;
end
handles.pieces{selected_piece,2} = temp; %only 1 button can be chosen

color = [get(handles.radiobutton4, 'Value'), get(handles.radiobutton5, ...
    'Value'), get(handles.radiobutton6, 'Value'),get(handles.radiobutton7, 'Value')];

 %if multiple pieces have the same color shape combo / multiple kings
 for i=1:length(contents)
     if(min(handles.pieces{i,1:2}) > 0 && temp~=0 && ~isempty(find(color,1)))
        if(all([find(color,1),find(shape,1)] == handles.pieces{i,1:2})) 
            if strcmp(selected_piece,handles.pieces.Properties.RowNames{i})
                continue;
            end
            msgbox(sprintf('%s and %s now have the same color/shape combo',selected_piece, handles.pieces.Properties.RowNames{i}));
        end
     end
 end
guidata(hObject,handles);

% --- Executes when selected object is changed in Color_Choice.
function Color_Choice_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Color_Choice 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = get(handles.listbox1,'String');
selected_piece = contents{get(handles.listbox1,'Value')};

color = [get(handles.radiobutton4, 'Value'),get(handles.radiobutton5, ...
    'Value'),get(handles.radiobutton6, 'Value'),get(handles.radiobutton7, 'Value')];

temp = find(color,1);
if isempty(temp)
    temp = 0;
end
handles.pieces{selected_piece,1} = temp;

shape = [get(handles.radiobutton1, 'Value'),get(handles.radiobutton2, ...
    'Value'), get(handles.radiobutton3, 'Value')];
%if multiple pieces have the same color shape combo
 for i=1:length(contents)
    if(min(handles.pieces{i,1:2}) > 0 && temp~=0 && ~isempty(find(shape,1)))
        if(all([find(color,1),find(shape,1)] == handles.pieces{i,1:2})) 
            if strcmp(selected_piece,handles.pieces.Properties.RowNames{i})
                continue;
            end
            msgbox(sprintf('%s and %s now have the same color/shape combo',selected_piece, handles.pieces.Properties.RowNames{i}));
        end
    end
 end

guidata(hObject,handles);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;

% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;
% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_callback;


% --- Executes on button press in Play_Chess.
function Play_Chess_Callback(hObject, eventdata, handles)
% hObject    handle to Play_Chess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pieces = handles.pieces;
possible_pieces = handles.possible_pieces;
%dowel = handles.dowel;
topleft = handles.topleft;
bottomright = handles.bottomright;
dowel = shape_detection(topleft,bottomright,handles.cam);
chess_images = handles.chess_images;

for j=1:length(dowel(:,1))
    for i=1:length(possible_pieces)
        if(all(pieces{possible_pieces(i),{'Color','Shape'}} == dowel(j,3:4)))
            %insert type of piece and side into dowel matrix
            dowel(j,5:6) = pieces{possible_pieces(i),{'Type','Side'}};
        end
        if(i == length(possible_pieces) && ~all(dowel(j,5:6)))
            msgbox({'Not all dowels are accounted for';'Must have a chess piece associated with every dowel'});
            return;
        end
    end
end

board = make_board(topleft,bottomright,dowel);
unhighlight_squares(handles,board);
%resets each square to put up new pieces later
for i = 1:length(board(:,1,1))
    for j=1:length(board(1,:,1))
        old_square = sprintf('handles.pushbutton%i',(i-1)*length(board(1,:,1))+j);
        set(eval(old_square),'cdata',[]);
    end
end

for i=1:length(board(:,1,1))
    for j=1:length(board(1,:,1))
        if(board(i,j,1) ~= 0)
            for k=1:length(possible_pieces) % put piece images onto board
                if(all(pieces{possible_pieces(k),{'Type','Side'}} == squeeze(board(i,j,3:4))'))
                    new_square=sprintf('handles.pushbutton%i',(i-1)*length(board(1,:,1))+j);
                    set(eval(new_square),'cdata',chess_images{k});
                end
            end
        end
    end
end

moves = get_moves(board);
%1-Square, 2-Circle, 3-Triangle
%1-Red, 2-Blue, 3-Green, 4-Yellow
handles.moves = moves;
handles.board = board;
handles.dowel = dowel;
guidata(hObject,handles);

%create numerical combinations based on size of lists
function combos = make_num_combos(list1,list2)
combos = zeros(length(list1)*length(list2),2);
j=ones(1,2);
for i = 1:length(list1)*length(list2)
    combos(i,:)=j;
    j(end) = j(end)+1;
    if(j(end) > length(list2))
        j(end) = 1;
        j(end-1) = j(end-1)+1;
    end
end


% --- Executes on button press in Ask_Robot.
function Ask_Robot_Callback(hObject, eventdata, handles)
% hObject    handle to Ask_Robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tg=slrt;
moves = handles.moves;
board = handles.board;
dowel = handles.dowel;
chess_pieces = handles.pieces;
possible_pieces = handles.possible_pieces;
chess_images = handles.chess_images;
current_position = handles.current_piece;

to_do = 0;
while to_do == 0
    to_do = menu('Choose whether to avoid check or find check',{'Avoid Check','Get Check','Kill Piece','Move Piece'});
end

if(to_do == 1)
    check = test_check(moves,1);
    if(check ~=1)
        msgbox('King is not in check');
        return;
    end
    %king is in check
    tic; %start timer
    piece2move = defend(moves);
    if(max(piece2move)==-1)
        msgbox('Checkmate');
        return;
    end
    [R, C] = find(moves.king1 == 2);
    %convert where king is to name of king for image purposes
    for i = 1:length(possible_pieces)
        if(all(chess_pieces{possible_pieces{i},3:4} == board(R,C,3:4)))
            break;
        end
    end
    move(tg, [R,C], piece2move);
    board(piece2move(1),piece2move(2),3:4) = board(R,C,3:4);
    board(R,C,3:4) = [0, 0];
    new_square = sprintf('handles.pushbutton%i',(piece2move(1)-1)*length(board(1,:,1))+piece2move(2));
    old_square = sprintf('handles.pushbutton%i',(R-1)*length(board(1,:,1))+C);
    set(eval(old_square),'cdata',[]);
    set(eval(new_square),'cdata',chess_images{i});
    unhighlight_squares(handles,board);
    % hit load cell
    time = toc;
    msgbox(sprintf('%f seconds for move',time));
elseif(to_do==2)
    [piece, position] = get_check(moves);
    if(all(piece == [0 0]))
        msgbox('King is already in check or can''t be checked');
        return;
    end
    tic; %start timer
     for i = 1:length(possible_pieces)
        if(all(chess_pieces{possible_pieces{i},3:4} == squeeze(board(piece(1),piece(2),3:4))'))
            break;
        end
     end
     
    move(tg, piece, position); %physically move piece
    board(position(1),position(2),3:4) = board(piece(1),piece(2),3:4);
    board(piece(1),piece(2),3:4) = [0, 0];
    new_square = sprintf('handles.pushbutton%i',(position(1)-1)*length(board(1,:,1))+position(2));
    old_square = sprintf('handles.pushbutton%i',(piece(1)-1)*length(board(1,:,1))+piece(2));
    set(eval(old_square),'cdata',[]);
    set(eval(new_square),'cdata',chess_images{i});
    %hit load cell
    time = toc;
    msgbox(sprintf('%f seconds for move',time));
elseif(to_do==3)
    msgbox({'Select piece not on robot''s team';'(may need to switch which color team the robot is on)'});
    return;
else
    msgbox('Select piece on robot''s team to move and where to place it');
    return;
end

moves = get_moves(board);

tg=slrt;
handles.current_piece = current_position;
handles.dowel = dowel;
handles.board = board;
handles.moves = moves;
guidata(hObject,handles);

% --- Executes when selected object is changed in robot_color.
function robot_color_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in robot_color 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pieces = handles.pieces;
dowel = handles.dowel;
board = handles.board;
possible_pieces = handles.possible_pieces;
move_pieces = handles.move_pieces;
is_white = get(handles.white_button, 'Value');
if(is_white)
    handles.turn = 1;
else
    handles.turn = 0;
end

for i=1:length(possible_pieces)
    if strcmp((extractBefore(possible_pieces{i},' ')),get(handles.white_button,'String')) == get(handles.white_button,'Value')
        a= '1';
    else
        a= '2';
    end
    if strcmp((extractAfter(possible_pieces{i},' ')),'King')
        b='king';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Queen')
        b='queen';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Bishop')
        b='bishop';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Knight')
        b='knight';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Rook')
        b='rook';
    elseif strcmp((extractAfter(possible_pieces{i},' ')),'Pawn')
        b='pawn';
    end
    move_pieces{i} = strcat(b,a);
end
pieces{:,4}= mod(pieces{:,4},2)+1;

dowel(:,6) =mod(dowel(:,6),2)+1;
board(:,:,4) = mod(board(:,:,4)*5,3);
moves = get_moves(board);
handles.moves = moves;
handles.dowel = dowel;
handles.pieces = pieces;
handles.board = board;
handles.move_pieces = move_pieces;
guidata(hObject,handles);


% --- Executes on button press in Reset_All.
function Reset_All_Callback(hObject, eventdata, handles)
% hObject    handle to Reset_All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dowel = [];
handles.moves = [];
handles.pieces.Color(:) = 0;
handles.pieces.Shape(:) = 0;
board = handles.board;
set(handles.radiobutton1,'Value',0);
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton6,'Value',0);
set(handles.radiobutton7,'Value',0);

if isempty(board)
    return;
end

for i=1:length(board(:,1,1))
    for j = 1:length(board(1,:,1))
        square = eval(sprintf('handles.pushbutton%i',(i-1)*length(board(1,:,1))+j));
        set(square,'BackgroundColor',[.94 .94 .94]);
        if ~isempty(get(square,'cdata'))
            set(square,'cdata',[]);    
        end
    end
end
handles.board = [];
guidata(hObject,handles);
