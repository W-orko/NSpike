How to use the Spike Detection program:



Download the script, SPIKEGUI4.m


Download the desired neural recording.


In the command window, run the script, typing in: 

SpikeGUI4('filename').


You may use any neural wave recording. An example is: 
SpikeGUI4('recording1.wav')

.

A figure should appear showing the GUI. Clicking "Plot Average Waveform" will make the large axes display the average waveform.



You may adjust the sliders to your preference, input your desired channel # and waveform #
.

-'Threshold' will adjust the minimum amplitude that the program uses to detect spikes. A lower amplitude will detect far more spikes than
 a higher amplitude.

-'L1' will adjust the distance behind the detected spike.
-'L2' will adjust the distance in front of the detected spike
.
-'Waveform #' will specify a certain waveform that was detected
.
-'Plot Specific Waveform' will plot the waveform specified in
.
-'Waveform #'. This will appear on the axes in the upper right hand corner
.
-'Channel #' will specify the specific channel/data the program looks 
at.
-'Number of Spikes' will display the number of spikes detected
.
-'Plot Average Waveform' will plot a waveform after specific inputs are entered. This will appear in the bigger axes.
