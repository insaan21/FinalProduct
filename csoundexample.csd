<CsoundSynthesizer>

<CsInstruments>
sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1.0


giwav ftgen 0,0,1024,10,1,0.5,0.333,0.25,0.2,0.167,0.149,0.125,0.111,0.1

gitri ftgen 0,0,1024,7,-1,512,1,512,-1


; semicolons are comments in CSOUND
; pass input to output with reduced volume
instr 1
	ain inch 1
	ain *= 0.1
	out ain,ain
endin

; wavetable oscillator, resonant filter, multiple linseg envelopes
instr 2
	aenv linsegr 0, 0.01, 1, 0.4, 0.2, 0.2, 0
	afenv linsegr 0,0.5,1,0.4,0.2,0.2,0
	asnd oscil aenv,100,giwav
	asnd rezzy asnd,100 + 6000*afenv,10
	out asnd,asnd
endin

; process input with filter driven by sinewave LFO
instr 3
	ainL inch 1
	ainR inch 2

	al oscil 1, 0.3
	al = (al*0.5 + 0.5)*3000 + 500


	asndL rezzy ainL,al,30
	asndR rezzy ainR,al,30

	out asndL,asndR
endin


;my first attempt at Interstellar Orbiter Dual Res Filter
instr 4
	ilforate = 0.3
	icof = 2000

	iAint = 1.0
	iARes = 10
	iAMix = ampdbfs(-12)

	iBint = 0.3
	iBRes = 50
	iBMix = ampdbfs(-12)

	iDry = ampdbfs(-12)

	ain inch 1

	alfo oscil 1,ilforate,gitri ; bipolar audio signal (-1 1)
	alfo = alfo*0.5 + 0.5 ; monopolar (0 1)

	alfo = alfo*alfo

	; // icofhz -> icof*2
	aAlfo = (alfo*iAint)*icof*3 + icof
	aBlfo = (alfo*iBint)*icof*3 + icof
	

	aAsnd rezzy ain,aAlfo,iARes
	aBsnd rezzy ain,aBlfo,iBRes

	amix = aAsnd*iAMix + aBsnd*iBMix + ain*iDry
	out amix,amix
endin


</CsInstruments>

<CsScore>
i4  0 500
</CsScore>

</CsoundSynthesizer>