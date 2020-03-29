<CsoundSynthesizer>
<CsOptions>
-iadc1 -odac1 
-+rtaudio=CoreAudio
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

instr 1
	ain inch 1
	acompressed compress ain, ain, 0, 48, 60, 4, 0.1 , 0.5 , 0.02
	out acompressed, acompressed
endin

instr 2
	ain inch 1
	acompressed compress2 ain, ain, 0, 20, 20, 4, 0.1 , 0.5 , 0.02
	out acompressed, acompressed
endin

instr 3
	avoice inch 1
	ain1, ain2 diskin2 "purple haze.wav", 1, 0, 1
	amix = (ain1*0.5) + (ain2 * 0.5)
	acompressed compress amix, avoice, 0, 48, 60, 4, 0.1 , 0.5 , 0.02
	outs acompressed, acompressed
endin

</CsInstruments>
<CsScore>
i2 0 30
</CsScore>
</CsoundSynthesizer>