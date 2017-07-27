function varargout = guitarFig(varargin)
% GUITARFIG MATLAB code for guitarFig.fig
%      GUITARFIG, by itself, creates a new GUITARFIG or raises the existing
%      singleton*.
%
%      H = GUITARFIG returns the handle to a new GUITARFIG or the handle to
%      the existing singleton*.
%
%      GUITARFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITARFIG.M with the given input arguments.
%
%      GUITARFIG('Property','Value',...) creates a new GUITARFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guitarFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guitarFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guitarFig

% Last Modified by GUIDE v2.5 28-Apr-2017 00:27:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guitarFig_OpeningFcn, ...
                   'gui_OutputFcn',  @guitarFig_OutputFcn, ...
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


% --- Executes just before guitarFig is made visible.
function guitarFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guitarFig (see VARARGIN)

% Choose default command line output for guitarFig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guitarFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% input
data = guidata(handles.figure1);
[data.x, data.fs] = audioread('guitar.wav');
data.Ts = 1/data.fs;
data.t = 0:data.Ts:(length(data.x)-1)*data.Ts;
guidata(handles.figure1,data);
% plot results
axes(handles.axes1);
plot(data.t,data.x,'b')
title('Original');
%sound(x,fs);

% --- Outputs from this function are returned to the command line.
function varargout = guitarFig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in overdriveButton.
function overdriveButton_Callback(hObject, eventdata, handles)
% hObject    handle to overdriveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% apply overdrive
data = guidata(handles.figure1);
y=overdrive(data.x);
axes(handles.axes2);
plot(data.t,y,'r');
title('Overdrive');
sound(y,data.fs);

% --- Executes on button press in distButton.
function distButton_Callback(hObject, eventdata, handles)
% hObject    handle to distButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(handles.figure1);
y = distortion(data.x,handles.distEdit.Value);
axes(handles.axes2);
plot(data.t,y,'r');
title('Distortion');
sound(y,data.fs);

% --- Executes on button press in reverbButton.
function reverbButton_Callback(hObject, eventdata, handles)
% hObject    handle to reverbButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(handles.figure1);
y = reverb(data.x,handles.revEdit.Value,.5,.3,floor(.05*rand([1,handles.revEdit.Value])*data.fs));
axes(handles.axes2);
plot(data.t,y,'r');
title('Reverb');
sound(y,data.fs);

% --- Executes on button press in tremoloButton.
function tremoloButton_Callback(hObject, eventdata, handles)
% hObject    handle to tremoloButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(handles.figure1);
y = tremolo(data.x,data.fs);
axes(handles.axes2);
plot(data.t,y,'r');
title('Tremolo');
sound(y,data.fs);

% --- Executes on button press in wahButton.
function wahButton_Callback(hObject, eventdata, handles)
% hObject    handle to wahButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(handles.figure1);
y = wah(data.x,data.fs);
axes(handles.axes2);
plot(data.t,y,'r');
title('Wah');
sound(y,data.fs);

% --- Executes on button press in flangerButton.
function flangerButton_Callback(hObject, eventdata, handles)
% hObject    handle to flangerButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(handles.figure1);
y = flanger(data.x,data.fs);
axes(handles.axes2);
plot(data.t,y,'r');
title('Flanger');
sound(y,data.fs);


% --- Executes on button press in original.
function original_Callback(hObject, eventdata, handles)
% hObject    handle to original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(handles.figure1);
sound(data.x,data.fs);



function distEdit_Callback(hObject, eventdata, handles)
% hObject    handle to distEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distEdit as text
%        str2double(get(hObject,'String')) returns contents of distEdit as a double
handles.distEdit.Value = str2double(handles.distEdit.String);

% --- Executes during object creation, after setting all properties.
function distEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to flaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flaEdit as text
%        str2double(get(hObject,'String')) returns contents of flaEdit as a double


% --- Executes during object creation, after setting all properties.
function flaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function revEdit_Callback(hObject, eventdata, handles)
% hObject    handle to revEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of revEdit as text
%        str2double(get(hObject,'String')) returns contents of revEdit as a double
handles.revEdit.Value = str2num(handles.revEdit.String);

% --- Executes during object creation, after setting all properties.
function revEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to revEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tremoloEdit_Callback(hObject, eventdata, handles)
% hObject    handle to tremoloEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tremoloEdit as text
%        str2double(get(hObject,'String')) returns contents of tremoloEdit as a double


% --- Executes during object creation, after setting all properties.
function tremoloEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tremoloEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
