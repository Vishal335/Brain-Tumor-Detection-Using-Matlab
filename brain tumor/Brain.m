function varargout = Brain(varargin)
% BRAIN MATLAB code for Brain.fig
%      BRAIN, by itself, creates a new BRAIN or raises the existing
%      singleton*.
%
%      H = BRAIN returns the handle to a new BRAIN or the handle to
%      the existing singleton*.
%
%      BRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAIN.M with the given input arguments.
%
%      BRAIN('Property','Value',...) creates a new BRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Brain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Brain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Brain

% Last Modified by GUIDE v2.5 25-Apr-2021 15:58:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Brain_OpeningFcn, ...
                   'gui_OutputFcn',  @Brain_OutputFcn, ...
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


% --- Executes just before Brain is made visible.
function Brain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Brain (see VARARGIN)

% Choose default command line output for Brain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Brain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Brain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Image.
function Image_Callback(hObject, eventdata, handles)
% hObject    handle to Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2;
[path,user_cancel]=imgetfile();
if user_cancel
     msgbox(sprintf('Invalid Selection'),'Error','Warn');
     return
end
im=imread(path);
im=im2double(im);
im2=im;
axes(handles.axes1);
imshow(im)
title('\fontsize{18}\color{rgb} {0.635 0.078 0.184} Patient s''Brain');

% --- Executes on button press in Detection.
function Detection_Callback(hObject, eventdata, handles)
% hObject    handle to Detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
axes(handles.axes2);
bw=im2bw(im,0.7);
label=bwlabel(bw)'
stats=regionprops(label,'solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);
se=strel('square',5);
tumor=imdilate(tumor,se);
figure(2);
subplot(1,3,1);
imshow(im,[]);
title('Brain');
subplot(1,3,2);
imshow(tumor,[]);
title('Tumor Alonr');
[B,L]=bwboundaries(tumor,'noholes');
subplot(1,3,3);
imshow(img,[]);
hold on
for i=1:length(B)
     plot(B{i}(:,2),B{i}(:,1),'linewidth',1.45);
end
title('detected tumor');
hold off;


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------


% --------------------------------------------------------------------
function aurthor_Callback(hObject, eventdata, handles)
% hObject    handle to aurthor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(sprintf('Vishal Chaudhary : Email - vc5708280@gmail.com'),'Author','Help');
