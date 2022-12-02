
function varargout = DSP_Lab(varargin)

% DSP_LAB M-file for DSP_Lab.fig
%      DSP_LAB, by itself, creates a new DSP_LAB or raises the existing
%      singleton*.
%
%      H = DSP_LAB returns the handle to a new DSP_LAB or the handle to
%      the existing singleton*.
%
%      DSP_LAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSP_LAB.M with the given input arguments.
%
%      DSP_LAB('Property','Value',...) creates a new DSP_LAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DSP_Lab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DSP_Lab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DSP_Lab

% Last Modified by GUIDE v2.5 11-Oct-2014 17:31:41

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DSP_Lab_OpeningFcn, ...
                   'gui_OutputFcn',  @DSP_Lab_OutputFcn, ...
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


% --- Executes just before DSP_Lab is made visible.
function DSP_Lab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DSP_Lab (see VARARGIN)

% Choose default command line output for DSP_Lab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DSP_Lab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DSP_Lab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plot_spect.
function plot_spect_Callback(hObject, eventdata, handles)
x_spec_half=[8:-1:0 0.2*randn(1,33-9)];
x_spec=[x_spec_half(32:-1:2)];
x=ifft(x_spec);
fs = 12000;
op=(get(handles.op,'value')) ;
rate=2^(get(handles.r,'value')); 
AAF=get(handles.AAF,'value') ;
RCF=get(handles.RCF,'value') ;
holdon=get(handles.holdon,'value') ;
if op==1
    y=x;            
    fs_plot=fs ;
    N=1024 ;
elseif op==2
   fs_plot=fs/rate ;
   N=1024/rate ;
    if AAF==0
    y=x(1:rate:end) ;
   else
       [b a]=butter(4,1/rate,'low');
       x_filtered=filter(b,a,x);
       y=x_filtered(1:rate:end) ;
   end

else    
    fs_plot=fs*rate ;
   N=1024*rate ;
    if RCF==0
    y=upsample(x,rate)*rate;
   else
       [b a]=butter(4,1/rate,'low');
       x_unfiltered= upsample(x,rate)*rate; 
       y=filter(b,a,x_unfiltered);
   end
end
f_plot=([0:N-1]*fs_plot/N)-fs_plot/2 ;

if holdon==0
figure
plt=fftshift(abs(fft(y,N)*1/fs_plot)) ;
plot(f_plot,plt)
title('Frequency domain signal');
xlabel('Frequency(Hz)');
ylabel('Magnitude') ;
if op==1
    [sr,sy,sn,sf]=legend ;
    st=[ sf' ; 'The same rate' ] ;
    legend(st)
elseif op==2
    if AAF==1
        [sr,sy,sn,sf]=legend ;
        st=['Decimation by factor '  num2str(rate)  ', AAF on' ];
        st=[sf' ; st];
        legend(st)
        
    else
        [sr,sy,sn,sf]=legend ;
        st=['Decimation by factor '  num2str(rate)  ', AAF off' ];
        st=[sf' ; st];
        legend(st)
    end
else
    if RCF==1
     [sr,sy,sn,sf]=legend ;
        st=['Interpolation by factor '  num2str(rate)  ', RCF on' ];
        st=[sf' ; st];
        legend(st)
    else
        [sr,sy,sn,sf]=legend ;
        st=['Interpolation by factor '  num2str(rate)  ', RCF off' ];
        st=[sf' ; st];
        legend(st)
    end
end
else
hold all
plt=fftshift(abs(fft(y,N)*1/fs_plot)) ;
plot(f_plot,plt)
title('Frequency domain signal');
xlabel('Frequency(Hz)');
ylabel('Magnitude') ;
if op==1
    [sr,sy,sn,sf]=legend ;
    st=[ sf' ; 'The same rate' ] ;
    legend(st)
elseif op==2
    if AAF==1
        [sr,sy,sn,sf]=legend ;
        st=['Decimation by factor '  num2str(rate)  ', AAF on' ];
        st=[sf' ; st];
        legend(st)
        
    else
        [sr,sy,sn,sf]=legend ;
        st=['Decimation by factor '  num2str(rate)  ', AAF off' ];
        st=[sf' ; st];
        legend(st)
    end
else
    if RCF==1
     [sr,sy,sn,sf]=legend ;
        st=['Interpolation by factor '  num2str(rate)  ', RCF on' ];
        st=[sf' ; st];
        legend(st)
    else
        [sr,sy,sn,sf]=legend ;
        st=['Interpolation by factor '  num2str(rate)  ', RCF off' ];
        st=[sf' ; st];
        legend(st)
    end
end
end

% hObject    handle to plot_spect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
[x,fs]=audioread('mchocola.wma');op=(get(handles.op,'value')) ;
rate=2^(get(handles.r,'value')); 
AAF=get(handles.AAF,'value') ;
RCF=get(handles.RCF,'value') ;
if op==1
    y=x;            
elseif op==2
   if AAF==0
    y=x(1:rate:end) ; 
   else
       [b a]=butter(4,1/rate,'low');
       x_filtered=filter(b,a,x);
       y=x_filtered(1:rate:end); 
        
   end

else    
    if RCF==0
    y=upsample(x,rate);
   else
       [b a]=butter(4,1/rate,'low');
       x_unfiltered= upsample(x,rate); 
       y=filter(b,a,x_unfiltered);
   end
end
fin=str2num(get(handles.fin,'string'));
sound(y,fin)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AAF.
function AAF_Callback(hObject, eventdata, handles)
% hObject    handle to AAF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AAF


% --- Executes on button press in RCF.
function RCF_Callback(hObject, eventdata, handles)
% hObject    handle to RCF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RCF


% --- Executes on selection change in op.
function op_Callback(hObject, eventdata, handles)
op=get(hObject,'Value');
rate=2^(get(handles.r,'value')); 
if op==1
    f_out=11 ;            
elseif op==2
    f_out=11/rate ;
else
    f_out=11*rate ;
end
set(handles.fout,'string',strcat(num2str(f_out),' KHz'));
% hObject    handle to op (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns op contents as cell array
%        contents{get(hObject,'Value')} returns selected item from op


% --- Executes during object creation, after setting all properties.
function op_CreateFcn(hObject, eventdata, handles)
% hObject    handle to op (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in r.
function r_Callback(hObject, eventdata, handles)
op=(get(handles.op,'value')) ;
rate=2^(get(handles.r,'value')); 
if op==1
    f_out=11 ;            
elseif op==2
    f_out=11/rate ;
else
    f_out=11*rate ;
end
set(handles.fout,'string',strcat(num2str(f_out),' KHz'));
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns r contents as cell array
%        contents{get(hObject,'Value')} returns selected item from r


% --- Executes during object creation, after setting all properties.
function r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fin_Callback(hObject, eventdata, handles)
% hObject    handle to fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fin as text
%        str2double(get(hObject,'String')) returns contents of fin as a double


% --- Executes during object creation, after setting all properties.
function fin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[x,fs]=audioread('mchocola.wma');
op=(get(handles.op,'value')) ;
rate=2^(get(handles.r,'value')); 
AAF=get(handles.AAF,'value') ;
RCF=get(handles.RCF,'value') ;
if op==1
    y=x;            
elseif op==2
   if AAF==0
    y=x(1:rate:end) ; 
   else
       [b a]=butter(4,1/rate,'low');
       x_filtered=filter(b,a,x);
       y=x_filtered(1:rate:end); 
        
   end

else    
    if RCF==0
    y=upsample(x,rate);
   else
       [b a]=butter(4,1/rate,'low');
       x_unfiltered= upsample(x,rate); 
       y=filter(b,a,x_unfiltered);
   end
end
figure
t=(1:length(y))*1/(fs)*length(x)/length(y); 
plot(t,y)
title('Time domain signal');
xlabel('Time(sec)');
ylabel('Magnitude') ;
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clsall.
function clsall_Callback(hObject, eventdata, handles)
close all
DSP_Lab
% hObject    handle to clsall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
close all
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in holdon.
function holdon_Callback(hObject, eventdata, handles)
% hObject    handle to holdon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of holdon


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


