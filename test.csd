<CsoundSynthesizer>

<CsInstruments>
sr = 44100
ksmps = 10
nchnls = 2
0dbfs = 1.0

giwav ftgen 0,0,1024,10,1,0.5,0.333,0.25,0.2,0.167,0.149,0.125,0.111,0.1 ; sawtooth
gitri ftgen 0,0,1024,7,-1, 512, 1, 512, -1 ;triangle
gisquare ftgen  0 , 0, 1024, 10, 1, 0, 0.3, 0, 0.2, 0, 0.14, 0, .111  ;square


instr 1 
	ain inch 1
	ain *= 0.1
	out ain, ain
endin

instr 2
	ainL inch 1 
	ainR inch 2
	aenv linsegr 0, 0.01, 1, 0.4, 0.2, 0.2, 0
	afenv linsegr 0, 0.5, 1, 0.4, 0.2, 0.2, 0
	asnd oscil aenv, 100, gisquare
	asnd = (asnd * 0.5 + 0.5) * 6000 + 100
	asndL rezzy ainL, asnd, 10
	asndR rezzy ainR, 100 + 6000*afenv, 10
	out asndL, asndR
endin

instr 3
	ainL inch 1
	ainR inch 2

	al oscil 1, 0.3
	al = (al * 0.5 + 0.5) * 3000 + 500

	asndL rezzy ainL, al, 30
	asndR rezzy ainR, al, 30

	out asndL, asndR
endin

instr 4
	ilforate = 0.7
	icof = 1000

	iAint = 1.0
	iAres = 10
	iAMix = ampdbfs(-12)

	iBint = 0.3
	iBres = 50
	iBMix = ampdbfs(-11)

	iDry = ampdbfs(-12)

	ain inch 1

	alfo oscil 1, ilforate, gisquare ; -1 to 1
	alfo = alfo * 0.5 + 0.5 ; 0 to 1


	;cof in hz -> double normal cof
	aAlfo = (alfo*iAint)*icof*3 + icof 
	aBlfo = (alfo*iBint)*icof*3 + icof

	aAsnd rezzy ain, aAlfo, iAres
	aBsnd rezzy ain, aBlfo, iBres

	amix = (aAsnd * iAMix) + (aBsnd * iBMix) + (ain * iDry)
	out amix, amix

endin

</CsInstruments>

<CsScore>
i4 0 500
</CsScore>

</CsoundSynthesizer>


