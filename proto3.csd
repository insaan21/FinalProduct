<Cabbage> bounds(0, 0, 0, 0)

form caption("Guitar Pedal") size(400, 300), colour(58, 110, 182), pluginid("def1") 
groupbox bounds(0, 0, 182, 159) text("Reverb")  outlinecolour(130, 42, 42, 255) colour(60, 21, 21, 255)
rslider bounds(20, 54, 60, 60) range(0, 1, 0.1, 1, 0.1) channel("size") text("Size")
rslider bounds(106, 54, 60, 60) range(1000, 10000, 2000, 1, 0.1)  text("Frequency") channel("reverbFreq")



groupbox bounds(184, 0, 215, 161) colour(66, 123, 130, 255) text("Delay")
rslider bounds(202, 40, 60, 60) range(0, 1, 0.05, 1, 0.1) text("Left Time")  channel("lDelay")
rslider bounds(316, 38, 60, 60) range(0, 1, 0.1, 1, 0.1) text("Right Time") channel("rDelay")


groupbox bounds(18, 162, 373, 98) colour(55, 47, 82, 255) text("Tremolo") outlinecolour(183, 82, 82, 255)
hslider bounds(34, 198, 119, 48) range(0, 1, 0.5, 1, 0.1) velocity(0.19) text("Speed") channel("tSpeed")
hslider bounds(218, 198, 130, 43) range(0, 100, 80, 1, 10) text("Depth") channel("tDepth")
hslider bounds(220, 100, 150, 60) range(-12, -1, -12, 1, 0.5) text("Feedback") channel("dFeedback") velocity(0.41)

combobox bounds(192, 266, 107, 32), channel("combobox"), populate("*.snaps")
filebutton bounds(116, 264, 60, 36), channel("but1"), text("Save", "Save"), mode("snapshot")
</Cabbage>


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

gkrDelayTime init 0.2
gklDelayTime init 0.2


instr 1

    ;changing values for dual res filter
	ilforate = 1
	icof = 1000

	iAint = 1.0
	iAres = 10
	iAMix = ampdbfs(-12)

	iBint = 0.3
	iBres = 40
	iBMix = ampdbfs(-11)

	iDry = ampdbfs(-12)

	irMaxDelayTime  = 1.0
    ilMaxDelayTime= 1.0
    
    ;changing delay values 
    krDelayTime chnget "rDelay"
    klDelayTime chnget "lDelay"
    kdFeedback chnget "dFeedback"
	

	;changing values for tremolo
	klfospeed chnget "tspeed"
	klfodepth chnget "tDepth"
   
	
    
    ;changing values for reverb
	kreverbIntensity chnget "size"
    kcofFreq chnget "reverbFreq"
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

	
	adelayoscil oscil 1, klfospeed, gitri
	aunused delayr 0.5
	adelayed deltapi (klfodepth * adelayoscil + klfodepth + ksmps + 1) / sr
	delayw amix
	aout = adelayed


	adelayR init 0

	adummyL delayr ilMaxDelayTime
	adelayL deltapi klDelayTime
	awriteInputL butterlp aout + (adelayL*ampdbfs(kdFeedback)) + (adelayR*ampdbfs(kdFeedback)), 4000
	delayw awriteInputL
	aoutL = aout + (adelayL * ampdbfs(-6))

	adummyR delayr irMaxDelayTime
	adelayR deltapi krDelayTime
	awriteInputR butterlp aout + (adelayR*ampdbfs(kdFeedback)) + (adelayL*ampdbfs(kdFeedback)), 4000
	delayw awriteInputR
	aoutR = aout + (adelayR* ampdbfs(-6))

	al, aR  reverbsc aoutL, aoutR, kreverbIntensity, kcofFreq, sr, ipitchm
    
    
	outs aoutL + al, aoutR + aR
	


endin

</CsInstruments>
<CsScore>
i1 0 3600
</CsScore>
</CsoundSynthesizer>