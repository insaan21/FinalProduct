<CsoundSynthesizer>


<CsInstruments>
sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

giwavetable ftgen 0, 0, 1024, -7, 0, 512, 0.5, 512, 0.5

;rms by hand
instr 1
	ain inch 1
	ain *= ain
	ain butterlp ain, 5
	ain = sqrt(ain)
	out ain, ain
endin

;rms
instr 2
	ain inch 1
	krms rms ain
	arms interp krms
	out arms, arms
endin 


//handmade compressor
instr 3
	ain inch 1
	alouderin = ain * 8
	krms rms alouderin
	kgoal tablei krms*1024, giwavetable
	ain *= (kgoal/krms) * 2
	;printks "in %.3f out %.3f \n" , 0, krms, kgoal
	out ain, ain
endin

instr 4 
endin

</CsInstruments>

<CsScore>
i3 0 10
</CsScore>

</CsoundSynthesizer>