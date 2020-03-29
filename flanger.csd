<CsoundSynthesizer>

<CsInstruments>

sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

gitri ftgen 0,0,1024,7,-1, 512, 1, 512, -1 ;triangle


//basic flanger
instr 1
	ilfospeed = 0.1
	ifundfreq = 100
	ilfodepth = 0.2
	ifeedbackAmount = 0.8
	iwetMix = ampdbfs(-6)
	ain inch 1
	adelayoscil oscil 1, ilfospeed, gitri
	aunused delayr 0.5
	adelayed deltapi (1 / ifundfreq) * (ilfodepth * adelayoscil + 1)
	delayw ain + (adelayed * ifeedbackAmount)
	aout = (ain + adelayed * iwetMix)
	out aout, aout
endin

//tremolo
instr 2
	ilfospeed = 7
	ilfodepth = 100
	ain inch 1
	adelayoscil oscil 1, ilfospeed, gitri
	aunused delayr 0.5
	adelayed deltapi (ilfodepth * adelayoscil + ilfodepth + ksmps + 1) / sr
	delayw ain
	aout = adelayed
	out aout, aout
endin

</CsInstruments>

<CsScore>
i2 0 30
</CsScore>

</CsoundSynthesizer>
