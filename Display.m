function varargout = Display(varargin)
% DISPLAY MATLAB code for Display.fig
%      DISPLAY, by itself, creates a new DISPLAY or raises the existing
%      singleton*.
%
%      H = DISPLAY returns the handle to a new DISPLAY or the handle to
%      the existing singleton*.
%
%      DISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAY.M with the given input arguments.
%
%      DISPLAY('Property','Value',...) creates a new DISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Display_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Display_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Display

% Last Modified by GUIDE v2.5 08-Apr-2016 12:47:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Display_OpeningFcn, ...
                   'gui_OutputFcn',  @Display_OutputFcn, ...
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


% --- Executes just before Display is made visible.
function Display_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Display (see VARARGIN)

% Choose default command line output for Display
handles.output = hObject;
handles.graph = graph_generate();
tic
set(handles.start,'Value',1);

set(handles.r11,'Value',0);
set(handles.r12,'Value',0);
set(handles.r13,'Value',0);

set(handles.r21,'Value',0);
set(handles.r22,'Value',0);
set(handles.r23,'Value',0);

set(handles.r31,'Value',0);
set(handles.r32,'Value',0);
set(handles.r33,'Value',0);

map = displayMap();

handles.agv(1).curr=[3 1];
handles.agv(1).prev=[4 1];
handles.agv(1).status = 0;
handles.agv(1).path = [];
handles.agv(1).rem = 0;
handles.agv(1).worker = 0;
handles.agv(1).resource = 0;
handles.agv(1).home = 0;

pos = get(handles.a1,'Position');
pos(1) = [map(handles.agv(1).curr(1),handles.agv(1).curr(2),1)];
pos(2) = [map(handles.agv(1).curr(1),handles.agv(1).curr(2),2)];
set(handles.a1,'Position',pos);

handles.agv(2).curr=[3 2];
handles.agv(2).prev=[4 2];
handles.agv(2).status = 0;
handles.agv(2).path = [];
handles.agv(2).rem = 0;
handles.agv(2).worker = 0;
handles.agv(2).resource = 0;
handles.agv(2).home = 0;

pos = get(handles.a1,'Position');
pos(1) = [map(handles.agv(2).curr(1),handles.agv(2).curr(2),1)];
pos(2) = [map(handles.agv(2).curr(1),handles.agv(2).curr(2),2)];
set(handles.a2,'Position',pos);

handles.agv(3).curr = [3 3];
handles.agv(3).prev = [4 3];
handles.agv(3).status = 0;
handles.agv(3).path = [];
handles.agv(3).rem = 0;
handles.agv(3).worker = 0;
handles.agv(3).resource = 0;
handles.agv(3).home = 0;

pos = get(handles.a1,'Position');
pos(1) = [map(handles.agv(3).curr(1),handles.agv(3).curr(2),1)];
pos(2) = [map(handles.agv(3).curr(1),handles.agv(3).curr(2),2)];
set(handles.a3,'Position',pos);

handles.taskArray = zeros(3);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Display wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Display_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
while(get(handles.start,'Value'))

    handles.taskArray(1,1)=get(handles.r11,'Value');
    handles.taskArray(1,2)=get(handles.r12,'Value');
    handles.taskArray(1,3)=get(handles.r13,'Value');

    handles.taskArray(2,1)=get(handles.r21,'Value');
    handles.taskArray(2,2)=get(handles.r22,'Value');
    handles.taskArray(2,3)=get(handles.r23,'Value');

    handles.taskArray(3,1)=get(handles.r31,'Value');
    handles.taskArray(3,2)=get(handles.r32,'Value');
    handles.taskArray(3,3)=get(handles.r33,'Value');
    
    
    for i = 1:3
      for j = 1:3
        if handles.taskArray(i,j) == 1
          for k = 1:3
            if handles.agv(k).status == 0 && handles.agv(k).worker == 0 && handles.agv(k).home == 0
                handles.agv(k).allPaths = paths(handles.graph, handles.agv(k).curr(1), handles.agv(k).curr(2),1,j);
                [handles.agv(k).pathArray handles.agv(k).pathSize] = allWhat(handles.agv(k).allPaths);
                [handles.agv(k).pathArray handles.agv(k).pathTime handles.agv(k).pathSize] = pathArrange(handles.agv(k).pathArray, handles.agv(k).pathSize, handles.agv(k).prev);
                handles.agv(k).moves = movements(handles.agv(k).pathArray, handles.agv(k).pathSize, handles.agv(k).prev);
            end
          end
          
          [pathArray_2 pathSize_2 pathTime_2 pathIndex] = consolidatePaths(handles.agv);
          index = 0;
          for i2 = 1:size(pathArray_2,1)
              if conflict(pathArray_2(i2,:,:),pathSize_2(i2),handles.agv,pathIndex(i2)) == 0
                  index = i2;
                  break
              end
          end
          
          
          if index ~= 0
              disp('*');
                num = pathIndex(index);
                handles.agv(num).status = 1;
                handles.agv(num).rem = pathSize_2(index);
                handles.agv(num).startTime = toc;
                handles.agv(num).worker = i;
                handles.agv(num).resource = 1;
                handles.agv(num).home = 1;
                
                for i3 = 1:pathSize_2(index)
                    handles.agv(num).path(1,i3,1) = pathArray_2(index,i3,1);
                    handles.agv(num).path(1,i3,2) = pathArray_2(index,i3,2);
                end
                
                handles.taskArray(i,j) = 0;
                
                if i == 1
                    if j== 1
                        set(handles.r11,'Value',0);
                    end
                    if j== 2
                        set(handles.r12,'Value',0);
                    end
                    if j== 3
                        set(handles.r13,'Value',0);
                    end
                end
                if i == 2
                    if j== 1
                        set(handles.r21,'Value',0);
                    end
                    if j== 2
                        set(handles.r22,'Value',0);
                    end
                    if j== 3
                        set(handles.r23,'Value',0);
                    end
                end
                if i == 3
                    if j== 1
                        set(handles.r31,'Value',0);
                    end
                    if j== 2
                        set(handles.r32,'Value',0);
                    end
                    if j== 3
                        set(handles.r33,'Value',0);
                    end
                end
          end
          
        end
      end
    end
           
    
    for i4 = 1:3
        if handles.agv(i4).status == 0 && handles.agv(i4).worker ~= 0
            handles.agv(i4).allPaths = paths(handles.graph, handles.agv(i4).curr(1), handles.agv(i4).curr(2),5,handles.agv(i4).worker);
            [handles.agv(i4).pathArray handles.agv(i4).pathSize] = allWhat(handles.agv(i4).allPaths);
            [handles.agv(i4).pathArray handles.agv(i4).pathTime handles.agv(i4).pathSize] = pathArrange(handles.agv(i4).pathArray, handles.agv(i4).pathSize, handles.agv(i4).prev);
            
            index2 = 0;
              for i5 = 1:size(handles.agv(i4).pathArray,1)
                  if conflict(handles.agv(i4).pathArray(i5,:,:),handles.agv(i4).pathSize(i5),handles.agv,i4) == 0
                      index2 = i5;
                    break
                  end
              end
              
              if index2 ~= 0
                num = i4;
                handles.agv(num).status = 1;
                handles.agv(num).rem = handles.agv(i4).pathSize(index2);
                handles.agv(num).startTime = toc;
                handles.agv(num).worker = 0;
                handles.agv(num).resource = 0;
                handles.agv(num).home = 1;
                
                for i6 = 1:handles.agv(i4).pathSize(index2)
                    handles.agv(num).path(1,i6,1) = handles.agv(i4).pathArray(index2,i6,1);
                    handles.agv(num).path(1,i6,2) = handles.agv(i4).pathArray(index2,i6,2);
                end
                
              end
        end
          
    end
    
    for i4 = 1:3
        if handles.agv(i4).status == 0 && handles.agv(i4).worker == 0 && handles.agv(i4).home == 1
            handles.agv(i4).allPaths = paths(handles.graph, handles.agv(i4).curr(1), handles.agv(i4).curr(2),3,i4);
            [handles.agv(i4).pathArray handles.agv(i4).pathSize] = allWhat(handles.agv(i4).allPaths);
            [handles.agv(i4).pathArray handles.agv(i4).pathTime handles.agv(i4).pathSize] = pathArrange(handles.agv(i4).pathArray, handles.agv(i4).pathSize, handles.agv(i4).prev);
            
            index2 = 0;
              for i5 = 1:size(handles.agv(i4).pathArray,1)
                  if conflict(handles.agv(i4).pathArray(i5,:,:),handles.agv(i4).pathSize(i5),handles.agv,i4) == 0
                      index2 = i5;
                    break
                  end
              end
              
              if index2 ~= 0
                num = i4;
                handles.agv(num).status = 1;
                handles.agv(num).rem = handles.agv(i4).pathSize(index2);
                handles.agv(num).startTime = toc;
                handles.agv(num).worker = 0;
                handles.agv(num).resource = 0;
                handles.agv(num).home = 0;
                
                for i6 = 1:handles.agv(i4).pathSize(index2)
                    handles.agv(num).path(1,i6,1) = handles.agv(i4).pathArray(index2,i6,1);
                    handles.agv(num).path(1,i6,2) = handles.agv(i4).pathArray(index2,i6,2);
                end
                
              end
        end
          
    end
    
    
    if handles.agv(1).status == 1
        handles = updateAgv1(hObject,handles);
    end
    if handles.agv(2).status == 1
        handles = updateAgv2(hObject,handles);
    end
    if handles.agv(3).status == 1
        handles = updateAgv3(hObject,handles);
    end
    
    
    for i10 = 1:3
        handles.agv(i10).pathArray = [];
        handles.agv(i10).pathSize = [];
        handles.agv(i10).pathTime = [];
    end
        
%     handles.agv(1).status
%     handles.agv(1).path
%     handles.agv(1).curr
%     handles.agv(1).prev
    
    guidata(hObject, handles);
    pause(0.1);
end

guidata(hObject, handles);
varargout{1} = handles.output;


% --- Executes on button press in b11.
function b11_Callback(hObject, eventdata, handles)
% hObject    handle to b11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(1,1)=1;
guidata(hObject, handles);

% --- Executes on button press in b12.
function b12_Callback(hObject, eventdata, handles)
% hObject    handle to b12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(1,2)=1;
guidata(hObject, handles);


% --- Executes on button press in b13.
function b13_Callback(hObject, eventdata, handles)
% hObject    handle to b13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(1,3)=1;
guidata(hObject, handles);


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start


% --- Executes on button press in b21.
function b21_Callback(hObject, eventdata, handles)
% hObject    handle to b21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(2,1)=1;
guidata(hObject, handles);


% --- Executes on button press in b22.
function b22_Callback(hObject, eventdata, handles)
% hObject    handle to b22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(2,2)=1;
guidata(hObject, handles);


% --- Executes on button press in b23.
function b23_Callback(hObject, eventdata, handles)
% hObject    handle to b23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(2,3)=1;
guidata(hObject, handles);


% --- Executes on button press in b31.
function b31_Callback(hObject, eventdata, handles)
% hObject    handle to b31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(3,1)=1;
guidata(hObject, handles);


% --- Executes on button press in b32.
function b32_Callback(hObject, eventdata, handles)
% hObject    handle to b32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(3,2)=1;
guidata(hObject, handles);


% --- Executes on button press in b33.
function b33_Callback(hObject, eventdata, handles)
% hObject    handle to b33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.taskArray(3,3)=1;
guidata(hObject, handles);


% --- Executes on button press in r11.
function r11_Callback(hObject, eventdata, handles)
% hObject    handle to r11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r11
handles.taskArray(1,1)=2;


% --- Executes on button press in r12.
function r12_Callback(hObject, eventdata, handles)
% hObject    handle to r12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r12


% --- Executes on button press in r13.
function r13_Callback(hObject, eventdata, handles)
% hObject    handle to r13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r13


% --- Executes on button press in r21.
function r21_Callback(hObject, eventdata, handles)
% hObject    handle to r21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r21


% --- Executes on button press in r22.
function r22_Callback(hObject, eventdata, handles)
% hObject    handle to r22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r22


% --- Executes on button press in r23.
function r23_Callback(hObject, eventdata, handles)
% hObject    handle to r23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r23


% --- Executes on button press in r31.
function r31_Callback(hObject, eventdata, handles)
% hObject    handle to r31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r31


% --- Executes on button press in r32.
function r32_Callback(hObject, eventdata, handles)
% hObject    handle to r32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r32


% --- Executes on button press in r33.
function r33_Callback(hObject, eventdata, handles)
% hObject    handle to r33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r33

function handles = updateAgv1(hObject,handles)
next = [handles.agv(1).path(1,2,1) handles.agv(1).path(1,2,2)];
ang = turnAngle(handles.agv(1).prev,handles.agv(1).curr,next);
curr = handles.agv(1).curr;




if ang == 90 || ang == -90
    if toc > (handles.agv(1).startTime + 1.25)
        handles.agv(1).prev = [(2*curr(1) - next(1)) (2*curr(2) - next(2))]
        handles.agv(1).startTime = toc;
    end
end

if ang == 180 || ang == -180
    if toc > (handles.agv(1).startTime + 2.5)
        handles.agv(1).prev = [(2*curr(1) - next(1)) (2*curr(2) - next(2))]
        handles.agv(1).startTime = toc;
    end
end

if ang == 0
    if toc > (handles.agv(1).startTime + 2.5)
        handles.agv(1).curr = next;
        handles.agv(1).prev = [handles.agv(1).path(1,1,1) handles.agv(1).path(1,1,2)];
        
         map = displayMap();
         pos = get(handles.a1,'Position');
         pos(1) = map(next(1),next(2),1);
         pos(2) = map(next(1),next(2),2);
         
        set(handles.a1,'Position',pos);
        
        handles.agv(1).startTime = toc;
    
        for i = 1:handles.agv(1).rem-1
            handles.agv(1).path(1,i,1) = handles.agv(1).path(1,i+1,1);
            handles.agv(1).path(1,i,2) = handles.agv(1).path(1,i+1,2);
        end
    
         handles.agv(1).rem = handles.agv(1).rem-1;
    
         if handles.agv(1).rem == 1
            handles.agv(1).resource = 0; 
            handles.agv(1).rem = 0;
            handles.agv(1).status = 0;
            handles.agv(1).path = [];
         end
    end
end
guidata(hObject, handles);

function handles = updateAgv2(hObject,handles)
next = [handles.agv(2).path(1,2,1) handles.agv(2).path(1,2,2)];
ang = turnAngle(handles.agv(2).prev,handles.agv(2).curr,next);
curr = handles.agv(2).curr;

if ang == 90 || ang == -90
    if toc > (handles.agv(2).startTime + 1.25)
        handles.agv(2).prev = [(2*curr(1) - next(1)) (2*curr(2) - next(2))];
        handles.agv(2).startTime = toc;
    end
end

if ang == 180 || ang == -180
    if toc > (handles.agv(2).startTime + 2.5)
        handles.agv(2).prev = [(2*curr(1) - next(1)) (2*curr(2) - next(2))];
        handles.agv(2).startTime = toc;
    end
end

if ang == 0
    if toc > (handles.agv(2).startTime + 2.5)
        handles.agv(2).curr = next;
        handles.agv(2).prev = [handles.agv(2).path(1,1,1) handles.agv(2).path(1,1,2)];
        
         map = displayMap();
         pos = get(handles.a2,'Position');
         pos(1) = map(next(1),next(2),1);
           pos(2) = map(next(1),next(2),2);
         
        set(handles.a2,'Position',pos);
        
        handles.agv(2).startTime = toc;
    
        for i = 1:handles.agv(2).rem-1
            handles.agv(2).path(1,i,1) = handles.agv(2).path(1,i+1,1);
            handles.agv(2).path(1,i,2) = handles.agv(2).path(1,i+1,2);
        end
    
         handles.agv(2).rem = handles.agv(2).rem-1;
    
         if handles.agv(2).rem == 1
            handles.agv(2).resource = 0; 
            handles.agv(2).rem = 0;
            handles.agv(2).status = 0;
            handles.agv(2).path = [];
         end
    end
end
guidata(hObject, handles);

function handles = updateAgv3(hObject,handles)
next = [handles.agv(3).path(1,2,1) handles.agv(3).path(1,2,2)];
ang = turnAngle(handles.agv(3).prev,handles.agv(3).curr,next);
curr = handles.agv(3).curr;

if ang == 90 || ang == -90
    if toc > (handles.agv(3).startTime + 1.25)
        handles.agv(3).prev = [(2*curr(1) - next(1)) (2*curr(2) - next(2))];
        handles.agv(3).startTime = toc;
    end
end

if ang == 180 || ang == -180
    if toc > (handles.agv(3).startTime + 2.5)
        handles.agv(3).prev = [(2*curr(1) - next(1)) (2*curr(2) - next(2))];
        handles.agv(3).startTime = toc;
    end
end

if ang == 0
    if toc > (handles.agv(3).startTime + 2.5)
        handles.agv(3).curr = next;
        handles.agv(3).prev = [handles.agv(3).path(1,1,1) handles.agv(3).path(1,1,2)];
        
         map = displayMap();
         pos = get(handles.a3,'Position');
         pos(1) = map(next(1),next(2),1);
         pos(2) = map(next(1),next(2),2);
         
        set(handles.a3,'Position',pos);
        
        handles.agv(3).startTime = toc;
    
        for i = 1:handles.agv(3).rem-1
            handles.agv(3).path(1,i,1) = handles.agv(3).path(1,i+1,1);
            handles.agv(3).path(1,i,2) = handles.agv(3).path(1,i+1,2);
        end
    
         handles.agv(3).rem = handles.agv(3).rem-1;
    
         if handles.agv(3).rem == 1
            handles.agv(3).resource = 0; 
            handles.agv(3).rem = 0;
            handles.agv(3).status = 0;
            handles.agv(3).path = [];
         end
    end
end
guidata(hObject, handles);
