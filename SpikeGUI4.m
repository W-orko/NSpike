function SpikeGUI4(wavfile)
% This function creates a GUI that reads neural recording data from
% a file selected by the user in the same directory as the .m file. The three
% parameters in this function are Threshold (a waveform that does not cross
% this value is regarded as noise), L1 and L2 (which define the length of a
% specific waveform segment, with a higher L1 meaning more values to the
% left are taken, and a higher L2 meaning more values to the right are
% taken). GUIDE was used to make the GUI. The program also extracts the
% waveform for a specified spike on a smaller set of axes.
% Authors: Warish Orko, Samuel Kuhnel, Yicong Chen, Majd Ismail


% Load up the data
NR = audioread(wavfile);

% Reads how many channels are in the data
sizeNR = size(NR);
channelsnum = sizeNR(2);
list_channels = linspace(1,channelsnum,channelsnum);

%% GUI elements
% Use standard UI fonts for each platform.
if ispc
	font = struct('FontName','Segoe UI','FontSize',9);
elseif ismac
	font = struct('FontName','Lucida Grande','FontSize',13);
end

% Create a figure and set default uicontrol font.
% figure (id:001)
fig = figure('Units','pixels',...
	'Position',[790 195 900 600],...
	'DefaultUIControlFontName',font.FontName,...
	'DefaultUIControlFontSize',font.FontSize);

% Moves the figure to the center of the screen.
movegui(fig,'center')

% text (id:026) Label for Minimum L2
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[674 163 35 20],...
	'String','1',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:020) Label for Minimum Threshold
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[170 160 25 20],...
	'String','0.01',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:024) Label for Maximum L1
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[675 135 35 20],...
	'String','60',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:021)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[184 137 10 20],...
	'String','1',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:023)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[184 111 10 20],...
	'String','1',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% popupmenu (id:019)
Channel = uicontrol('Style','popupmenu',...
	'Units','pixels',...
	'Position',[620.367 220 80 30],...
	'String',{list_channels},...
	'Value',1,...
	'Callback','');

% text (id:025)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[675 110 35 20],...
	'String','110',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% slider (id:003)
% This slider controls the Threshold value
T = uicontrol('Style','slider',...
	'Units','pixels',...
	'Position',[195 150 476.25 23.0952],...
	'Min',0.01,...
	'Max',1,...
	'SliderStep',[0.01 0.1],...
	'Value',0.3029,...
	'Callback','');

% text (id:006)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[90 145 90.7143 34.6429],...
	'String','Threshold',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% slider (id:005)
% This slider controls L2 value
S2 = uicontrol('Style','slider',...
	'Units','pixels',...
	'Position',[195 100 476.25 23.0952],...
	'Min',1,...
	'Max',100,...
	'SliderStep',[0.01 0.1],...
	'Value',15,...
	'Callback','');

% text (id:007)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[90 122 90.7143 34.6429],...
	'String','L1',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% slider (id:004)
% This slider controls L1 value
S1 = uicontrol('Style','slider',...
	'Units','pixels',...
	'Position',[195 125 476.25 23.0952],...
	'Min',1,...
	'Max',60,...
	'SliderStep',[0.01 0.1],...
	'Value',20,...
	'Callback','');

% text (id:014)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[521.885 259.321475 90.7143 46.1905],...
	'String','Number of spikes',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:013)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[664.777 538.655 136.071 34.6429],...
	'String','Specific Waveform',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:008)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[90 95 90.7143 34.6429],...
	'String','L2',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:015)
N_Spikes = uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[605 260 90.7143 34.6429],...
	'String','[ ] ',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:011)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[521.885 304.25 90.714 34.643],...
	'String','Waveform #',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% edit (id:010)
WavNum = uicontrol('Style','edit',...
	'Units','pixels',...
	'Position',[620.534 324.4 80 15],...
	'String','Wave Number',...
	'HorizontalAlignment','center',...
	'BackgroundColor','w',...
	'Callback','');

% text (id:012)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[235.938 550.202 198.438 17.3214],...
	'String','Average Waveform',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:028)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[6863.75 -4594.26 90.7143 46.1905],...
	'String','Number of spikes',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);


% text (id:030)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[6863.75 -4594.26 90.7143 46.1905],...
	'String','Number of spikes',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:031)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[6863.75 -4594.26 90.7143 46.1905],...
	'String','Number of spikes',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% text (id:032)
uicontrol('Style','text',...
	'Units','pixels',...
	'Position',[527.24215 219 80 30],...
	'String','Channel #',...
	'HorizontalAlignment','center',...
	'BackgroundColor',fig.Color);

% pushbutton (id:033)
uicontrol('Style','pushbutton',...
	'Units','pixels',...
	'Position',[710.4 316.2 140 31.2],...
	'String','Plot Specific Waveform',...
	'Callback',@plotpeak);

% pushbutton to plot the average waveform
uicontrol('Style','pushbutton',...
    'String','Plot Average Waveform',...
    'Position',[710.2 268.2 140 31],...
    'Callback',@peakfind2);

%Listeners that replot the graphs if a value is changed

addlistener( T , 'ContinuousValueChange', @peakfind2);
addlistener( S1 , 'ContinuousValueChange', @peakfind2);
addlistener( S2 , 'ContinuousValueChange', @peakfind2);
addlistener( WavNum , 'ContinuousValueChange', @plotpeak);

% axes (id:002)
mainax = axes('Units','pixels',...
	'Position',[145.2093 226.817 362.743 300.114],...
	'Box','on');

% axes (id:009)
smallax = axes('Units','pixels',...
	'Position',[641.959 399.96 181.371 138.514],...
	'Box','on');

%%
% Callback functions


    function plotpeak(~,~)
        %This function plots a specific waveform on the small axes.
        
        %thr = 0.3029;
        
        %Reads the parameters from the GUI
        input = NR(:,Channel.Value);
        thr = T.Value;
        L1 = S1.Value;
        L2 = S2.Value;
        
        %Constructs a temporary x-vector for the recording data
        xvec = linspace(1,length(input),length(input));
        
        %Finds the peaks and locations
        [peaks, loc] = findpeaks(input,xvec);

        %Removes peaks below threshold

        loc(find(peaks<thr)) = []; %#ok<*FNDSB>
        peaks(peaks<thr) = [];

        %Gets waveforms using L values, storing them in 'output'

        for i=1:length(peaks)
            output{i} = input( (loc(i) - ceil(L1)) : (loc(i) + ceil(L2)) ); 
        end
        
        %Constructs final time vector
        t = (0:(ceil(L1)+ceil(L2)))/48000;
        
        %Plots graph and labels axes
        plot(smallax,t,output{str2num(WavNum.String)})
        xlabel(smallax,'Time (seconds) ')
        ylabel(smallax,'Waveform Amplitude (microvolts)')
        
    end

    function peakfind2(~,~)
    
    %This function plots the average spike on the main axes.
        
    %thr = 0.3029;
    
    %Reads parameters from the GUI
    input = NR(:,Channel.Value);
    thr = T.Value;
    L1 = S1.Value;
    L2 = S2.Value;
    
    
    % Constructs temporary x-vector for the data
    xvec = linspace(1,length(input),length(input));
    
    % Find the peaks and locations
    [peaks, loc] = findpeaks(input,xvec);

    % Removes peaks below threshold

    loc(find(peaks<thr)) = [];
    peaks(peaks<thr) = [];

    % Gets waveforms using L values

    for i=1:length(peaks)
        output{i} = input( (loc(i) - ceil(L1)) : (loc(i) + ceil(L2)) ); %#ok<*AGROW>
    end

    % Averages the waveforms

    total = 0;
    for i = 1:length(output)
        total = total + output{i};
        outputavg = total./length(output);
    end

    % Return the number of spikes found

    N_Spikes.String = num2str(length(peaks));

    
    % Construct final time vector
    t = (0:(ceil(L1)+ceil(L2)))/48000;

    % Plot the average waveform and label axes
    plot(mainax,t,outputavg)
    xlabel(mainax,'Time (seconds) ')
    ylabel(mainax,'Waveform Amplitude (microvolts)')
        end



end
