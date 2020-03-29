<CsoundSynthesizer>

<CsInstruments>
sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

giwav ftgen 0,0, 1024, 7, -1, 128, -0.9, 128, -0.5, 512, 0.5, 128, 1, 128, 0.8 ;almost tanh

instr 1
	ain inch 1
	ain *= ampdbfs(-6)
	out ain, ain
endin

instr 2
	ain inch 1
	ain *= ampdbfs(0) 
	ain = tanh(ain)
	ain *= ampdbfs(0)
	out ain, ain
endin

instr 3
	ain inch 1
	alin line 0, 1, 1
	ain *= ampdbfs(alin) 
	ain = tanh(ain)
	ain *= ampdbfs(-3)
	out ain, ain
endin

instr 4
	ain inch 1
	ain *= ampdbfs(12)
	ain = (ain *512) + 512
	ain table ain, giwav 
	ain *= ampdbfs(-6)
	out ain, ain
endin

</CsInstruments>
<CsScore>
i4 0 30
</CsScore>
</CsoundSynthesizer>
