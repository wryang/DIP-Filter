function varargout = mainWin(varargin)
% MAINWIN MATLAB code for mainWin.fig
%      MAINWIN, by itself, creates a new MAINWIN or raises the existing
%      singleton*.
%
%      H = MAINWIN returns the handle to a new MAINWIN or the handle to
%      the existing singleton*.
%
%      MAINWIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINWIN.M with the given input arguments.
%
%      MAINWIN('Property','Value',...) creates a new MAINWIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainWin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainWin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainWin

% Last Modified by GUIDE v2.5 01-Jun-2012 13:26:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainWin_OpeningFcn, ...
                   'gui_OutputFcn',  @mainWin_OutputFcn, ...
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


% --- Executes just before mainWin is made visible.
function mainWin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainWin (see VARARGIN)

% Choose default command line output for mainWin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainWin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainWin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectImgBtn.
function selectImgBtn_Callback(hObject, eventdata, handles)
% hObject    handle to selectImgBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentPath = cd;
[FileName,PathName,FilterIndex] = uigetfile('*.*','请选择一张图片',currentPath);
global path;
global imgBit;

if FileName == 0;
    warndlg(get(handles.selectFile, 'String'));
else
    path = strcat(PathName,FileName)
    set(handles.selectFile, 'String', FileName);
    info = imfinfo(FileName);
    imgBit = info.BitDepth;
end



% --- Executes on button press in submitBtn.
function submitBtn_Callback(hObject, eventdata, handles)
% hObject    handle to submitBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
D0 = get(handles.struElement1, 'String');
W0 = get(handles.struElement2, 'String');
methodIndex = get(handles.method, 'value');
method = '';
processMethod = '';
if methodIndex == 1
    method = 'ILPF';
    processMethod = 'Filter';
elseif methodIndex == 2
    method = 'IHPF';
    processMethod = 'Filter';
elseif methodIndex == 3
    method = 'BLPF';
    processMethod = 'Filter';
elseif methodIndex == 4
    method = 'BHPF';
    processMethod = 'Filter';
elseif methodIndex == 5
    method = 'ELPF';
    processMethod = 'Filter';
elseif methodIndex == 6
    method = 'EHPF';
    processMethod = 'Filter';
elseif methodIndex == 7
    method = 'IBPF';
    processMethod = 'Filter';
elseif methodIndex == 8
    method = 'IBSF';
    processMethod = 'Filter';
elseif methodIndex == 9
    method = 'BBPF';
    processMethod = 'Filter';
elseif methodIndex == 10
    method = 'BBSF';
    processMethod = 'Filter';
elseif methodIndex == 11
    method = 'BLPF';
    processMethod = 'FColorConv';
elseif methodIndex == 12
    method = 'BHPF';
    processMethod = 'FColorConv';
end

global path;
global imgBit;
if isempty(path)
    warndlg('请选择图像，谢谢合作~O(∩_∩)O~');
elseif imgBit ~= 8 
    warndlg('请选择8bitw位图，特别是实验图像~O(∩_∩)O~');
else
    process(path, method, D0, W0, processMethod);
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method
methodIndex = get(handles.method, 'value');
if (methodIndex >= 1 && methodIndex <=6) || (methodIndex >= 11 && methodIndex <=12)
    set(handles.struElement1, 'Enable', 'on');
    set(handles.struElement2, 'Enable', 'off');
elseif methodIndex >= 7 && methodIndex <=10
    set(handles.struElement1, 'Enable', 'on');
    set(handles.struElement2, 'Enable', 'on');
end

% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over method.
function method_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function struElement1_Callback(hObject, eventdata, handles)
% hObject    handle to struElement1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of struElement1 as text
%        str2double(get(hObject,'String')) returns contents of struElement1 as a double


% --- Executes during object creation, after setting all properties.
function struElement1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to struElement1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function struElement2_Callback(hObject, eventdata, handles)
% hObject    handle to struElement2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of struElement2 as text
%        str2double(get(hObject,'String')) returns contents of struElement2 as a double


% --- Executes during object creation, after setting all properties.
function struElement2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to struElement2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
