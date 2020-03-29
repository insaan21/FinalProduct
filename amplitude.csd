<CsoundSynthesizer>

<CsInstruments>

sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

instr 1
	ain inch 1
	asine oscil 1, 300, -1
	ain = ain * asine
	out ain, ain
endin


</CsInstruments>

<CsScore>
i1 0 30
</CsScore>

</CsoundSynthesizer>
