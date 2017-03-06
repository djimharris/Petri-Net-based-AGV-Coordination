function varargout = Trial(varargin)
% TRIAL MATLAB code for Trial.fig
%      TRIAL, by itself, creates a new TRIAL or raises the existing
%      singleton*.
%
%      H = TRIAL returns the handle to a new TRIAL or the handle to
%      the existing singleton*.
%
%      TRIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRIAL.M with the given input arguments.
%
%      TRIAL('Property','Value',...) creates a new TRIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Trial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Trial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Trial

% Last Modified by GUIDE v2.5 02-Apr-2016 18:12:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Trial_OpeningFcn, ...
                   'gui_OutputFcn',  @Trial_OutputFcn, ...
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


% --- Executes just before Trial is made visible.
function Trial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Trial (see VARARGIN)

% Choose default command line output for Trial
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Trial wait for user response (see UIRESUME)
% uiwait(handles.figure1);
tic
set(handles.text1,'BackgroundColor',[0 0 0]);
set(handles.text1,'ForegroundColor',[1 1 1]);
set(handles.radiobutton1,'Value',1);
% pushbutton1_Callback(hObject, eventdata, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Trial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% while 1

while(get(handles.radiobutton1,'Value')) && toc < 5
    varargout{1} = handles.output;
    a = get(handles.radiobutton1,'Value')
    set(handles.text1,'BackgroundColor',[0 0 0]);
    set(handles.text1,'ForegroundColor',[1 1 1]);
    if toc > 3
        set(handles.text1,'BackgroundColor',[1 1 1]);
        set(handles.text1,'ForegroundColor',[0 0 0]);
    end
    guidata(hObject, handles);
end
a = get(handles.radiobutton1,'Value')

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1,'String',num2str(get(handles.radiobutton1,'Value')));
set(handles.text1,'BackgroundColor',[1 1 1]);
set(handles.text1,'ForegroundColor',[0 0 0]);
Trial_OutputFcn(hObject, eventdata, handles)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
