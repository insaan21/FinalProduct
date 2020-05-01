<CsoundSynthesizer>
<CsOptions>
-iadc0 -odac1 -B512 -b128
</CsOptions>
<CsInstruments>

sr = 44100 ;set sample rate to 44100 Hz
ksmps = 32 ;number of samples per control cycle
nchnls = 2 ;use two audio channels
0dbfs = 1 ;set maximum level as 1

gitri ftgen 0,0,1024,7,-1, 512, 1, 512, -1 ;triangle
gisquare ftgen  0 , 0, 1024, 10, 1, 0, 0.3, 0, 0.2, 0, 0.14, 0, .111  ;square



instr 1
	

	;changing values for dual res filter
	ilforate = 0.7
	icof = 1000

	iAint = 0.7
	iAres = 10
	iAMix = ampdbfs(-12)

	iBint = 0.3
	iBres = 30
	iBMix = ampdbfs(-11)

	iDry = ampdbfs(-12)


	;changing values for tremolo
	ilfospeed = 0.1
	ilfodepth  = 100


	;changing values for delay 
	irDelayTime = 0.21
	ilDelayTime = 0.2

	;changing values for reverb
	ireverbIntensity = 0.001
	icofFreq = 10000
	ipitchm = 1

	ain inch 2

	alfo oscil 1, ilforate, gisquare ; -1 to 1
	alfo = alfo * 0.5 + 0.5 ; 0 to 1


	;cof in hz -> double normal cof
	aAlfo = (alfo*iAint)*icof*3 + icof 
	aBlfo = (alfo*iBint)*icof*3 + icof

	aAsnd rezzy ain, aAlfo, iAres
	aBsnd rezzy ain, aBlfo, iBres

 
    amix = (aAsnd * iAMix) + (aBsnd * iBMix) + (ain * iDry)  ;+ (aoctave * ampdbfs(-12))

	
	adelayoscil oscil 1, ilfospeed, gitri
	aunused delayr 0.5
	adelayed deltapi (ilfodepth * adelayoscil + ilfodepth + ksmps + 1) / sr
	delayw amix
	aout = adelayed


	adelayR init 0

	adelayL delayr irDelayTime
	awriteInputL butterlp aout + (adelayL * ampdbfs(-12)) + (adelayR * ampdbfs(-12)), 4000
	delayw awriteInputL
	aoutL = aout + (adelayL * ampdbfs(-6))

	adelayR delayr ilDelayTime
	awriteInputR butterlp aout + (adelayR * ampdbfs(-12)) + (adelayL * ampdbfs(-12)), 4000
	delayw awriteInputR
	aoutR = aout + (adelayR * ampdbfs(-6))

	al, aR  reverbsc aoutL, aoutR, ireverbIntensity, icofFreq, sr, ipitchm

	outs aoutL + al, aoutR + aR


endin

</CsInstruments>
<CsScore>
i1 0 3600
</CsScore>
</CsoundSynthesizer>