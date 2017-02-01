function varargout = WaveEqnApp(varargin)
% WAVEEQNAPP MATLAB code for WaveEqnApp.fig
%      WAVEEQNAPP, by itself, creates a new WAVEEQNAPP or raises the existing
%      singleton*.
%
%      H = WAVEEQNAPP returns the handle to a new WAVEEQNAPP or the handle to
%      the existing singleton*.
%
%      WAVEEQNAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVEEQNAPP.M with the given input arguments.
%
%      WAVEEQNAPP('Property','Value',...) creates a new WAVEEQNAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the UI before WaveEqnApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WaveEqnApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2015 The MathWorks, Inc.

% Edit the above text to modify the response to help WaveEqnApp

% Last Modified 26-Aug-2013

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @WaveEqnApp_OpeningFcn, ...
    'gui_OutputFcn',  @WaveEqnApp_OutputFcn, ...
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


% --- Executes just before WaveEqnApp is made visible.
function WaveEqnApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WaveEqnApp (see VARARGIN)

% Choose default command line output for WaveEqnApp
handles.output = hObject;

handles.maxIterValue = str2double(get(handles.maxIterEdit, 'String'));
handles.gridSizeValue = str2double(get(handles.gridSizeEdit, 'String'));

% Update handles structure
guidata(hObject, handles);

movegui(hObject, 'center');

% Show or Not show the running elapsed time
set(handles.elapsedTime, 'Visible', 'on');
	try
		gpuDevice;
	catch 
		set(handles.gpuTime, 'String', 'GPU is not available');
		set(handles.GPURadioBtn, 'Enable', 'off');
	end

% UIWAIT makes WaveEqnApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WaveEqnApp_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
colormap(handles.figure1,parula)
varargout{1} = handles.output;


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

button_state = get(hObject,'Value');

if get(handles.CPURadioBtn,'Value') == 1
    elapseTimeEditBox = handles.cpuTime;
    fh = @WaveCPU;
else
    elapseTimeEditBox = handles.gpuTime;
    try
        if gpuDeviceCount == 0
            errordlg({['Supported GPU hardware not found. ', ...
                'Check the documentation to see what''s supported.']}, ...
                'Error', 'modal');
            set(hObject,'Value',get(hObject,'Min'));
            return;
        end
    catch ME
        errordlg({['Supported GPU hardware not found. ', ...
            'Check the documentation to see what''s supported.'], '', ...
            ME.message}, 'Error', 'modal');
        set(hObject,'Value',get(hObject,'Min'));
        return;
    end
    
    fh = @WaveGPU;
end

if button_state == get(hObject,'Max')
    set(hObject,'String', 'Stop')
    set(elapseTimeEditBox, 'String', '');
    set(handles.elapsedTime, 'String', 'Elapsed Time: 0.0 s');
    t = tic;
    fh(handles.gridSizeValue,handles.maxIterValue,handles.TopAxes,handles.BottomAxes,hObject,handles.Iteration,handles.elapsedTime,10,t);
    et = toc(t);
    set(elapseTimeEditBox, 'String', sprintf('%0.1f sec', et));
    set(hObject,'Value', get(hObject,'Min'), 'String', 'Start')
    
else
    set(hObject,'String', 'Start')
end



function gridSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to gridSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gridSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of gridSizeEdit as a double

val = str2double(get(hObject,'String'));
if isnan(val)
    set(hObject, 'String', handles.gridSizeValue)
else
    handles.gridSizeValue = val;
    guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function gridSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gridSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxIterEdit_Callback(hObject, eventdata, handles)
% hObject    handle to maxIterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIterEdit as text
%        str2double(get(hObject,'String')) returns contents of maxIterEdit as a double

val = str2double(get(hObject,'String'));
if isnan(val)
    set(hObject, 'String', handles.maxIterValue)
else
    handles.maxIterValue = val;
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function maxIterEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
visdiff('WaveCPU.m', 'WaveGPU.m')
