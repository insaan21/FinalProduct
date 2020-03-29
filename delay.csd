<CsoundSynthesizer>
<CsOptions>
-iadc1 -odac1
-+rtaudio=CoreAudio
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1.0

;slap echo
instr 1
	ain inch 1
	adelay delay ain, 0.2
	ain += adelay*ampdbfs(-6)
	out ain, ain
endin

instr 2
	ain inch 1
	adelay delayr 0.5
	delayw ain + (adelay * ampdbfs(-12))
	aout = ain + adelay
	out aout, aout
endin


;stereo echo
instr 3
	ain inch 1

	adelayL delayr 0.501
	delayw ain + (adelayL * ampdbfs(-12))
	aoutL = ain + adelayL

	adelayR delayr 0.5
	delayw ain + (adelayR * ampdbfs(-12))
	aoutR = ain + adelayR

	out aoutL, aoutR
endin


;crosstalk
instr 4
	ain inch 1

	adelayR init 0

	adelayL delayr 0.501
	delayw ain + (adelayL * ampdbfs(-12)) + (adelayR * ampdbfs(-12))
	aoutL = ain + adelayL

	adelayR delayr 0.5
	delayw ain + (adelayR * ampdbfs(-12)) + (adelayL * ampdbfs(-12))
	aoutR = ain + adelayR

	out aoutL, aoutR
endin

;lopass filter
instr 5
	ain inch 1

	adelayR init 0

	adelayL delayr 0.1
	awriteInputL butterlp ain + (adelayL * ampdbfs(-12)) + (adelayR * ampdbfs(-12)), 4000
	delayw awriteInputL
	aoutL = ain + (adelayL * ampdbfs(-6))

	adelayR delayr 0.11
	awriteInputR butterlp ain + (adelayR * ampdbfs(-12)) + (adelayL * ampdbfs(-12)), 4000
	delayw awriteInputR
	aoutR = ain + (adelayR * ampdbfs(-6))

	outch 1, aoutL, 2, aoutR
endin


</CsInstruments>

<CsScore>
i 5 0 3600
</CsScore>

</CsoundSynthesizer>