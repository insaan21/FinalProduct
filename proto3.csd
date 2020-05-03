

\<Cabbage> bounds(0, 0, 0, 0)

form caption("Guitar Pedal") size(800, 600), colour(58, 110, 182), pluginid("def1") 
groupbox bounds(0, 0, 400, 200) text("Reverb")  outlinecolour(130, 42, 42, 255) colour(7, 0, 87, 164)
rslider bounds(50, 60, 100, 100) range(0, 1, 0.1, 1, 0.1) channel("size") trackercolour(255, 255, 255, 255) text("Size") outlinecolour(0, 0, 0, 255) fontcolour(130, 87, 87, 255) textboxoutlinecolour(255, 255, 255, 178) 
rslider bounds(250, 60, 100, 100) range(1000, 10000, 2000, 1, 0.1)  trackercolour(255, 255, 255, 255) text("Frequency") channel("reverbFreq") outlinecolour(0, 0, 0, 255)



groupbox bounds(400, 0, 400, 200) colour(52, 78, 207, 198) text("Delay")
rslider bounds(450, 65, 80, 80) range(0, 1, 0.05, 1, 0.1) trackercolour(255, 255, 255, 255) text("Left Time")  channel("lDelay")
rslider bounds(680, 65, 80, 80) range(0, 1, 0.1, 1, 0.1) trackercolour(255, 255, 255, 255) text("Right Time") channel("rDelay")
vslider bounds(575, 25, 50, 175) range(-12, -1, -12, 1, 0.5) trackercolour(255, 255, 255, 255) text("Feedback") channel("dFeedback") velocity(0.41)

groupbox bounds(0, 200, 800, 150) colour(164, 157, 157, 195) text("Tremolo") outlinecolour(183, 82, 82, 255) fontcolour(0, 0, 0, 255)
hslider bounds(50, 250, 250, 50) range(0, 1, 0.5, 1, 0.1) velocity(0.19) trackercolour(250, 250, 250, 255) text("Speed") channel("tSpeed") fontcolour(221, 17, 17, 255) textcolour(0, 0, 0, 255) 
hslider bounds(420, 252, 250, 50) range(0, 100, 80, 1, 10) trackercolour(255, 255, 255, 255) text("Depth") channel("tDepth") fontcolour(94, 46, 46, 255) textcolour(0, 0, 0, 255) textboxcolour(0, 0, 0, 0) textboxoutlinecolour(0, 0, 0, 0)




groupbox bounds(0, 350, 800, 250) text("Filter") colour(255, 255, 255, 255) fontcolour(130, 125, 125, 255)
rslider bounds(112, 374, 150, 80) range(1, 10, 0, 1, 0.001) trackercolour(255, 255, 255, 255) text("Rate") outlinecolour(253, 113, 113, 255) colour(241, 241, 241, 255) markercolour(255, 0, 0, 255) channel("Rate")
rslider bounds(512, 374, 150, 80) range(500, 10000, 1000, 1, 0.001) outlinecolour(255, 89, 89, 255) colour(255, 255, 255, 255) markercolour(255, 0, 0, 255) trackercolour(255, 255, 255, 255) text("Cutoff") channel("Cof")

groupbox bounds(0, 450, 400, 150) colour(255, 255, 255, 255) text("Left")
rslider bounds(25, 500, 75, 70) range(0, 1, 0, 1, 0.001) outlinecolour(255, 79, 79, 255) markercolour(255, 0, 0, 255) trackercolour(255, 255, 255, 255) text("Intensity") channel("lInt")
rslider bounds(275, 500, 75, 70) range(0, 100, 1, 1, 0.001) markercolour(255, 0, 0, 255) outlinecolour(255, 119, 119, 255) trackercolour(255, 255, 255, 255) text("Resonance") channel("lRes")
rslider bounds(130, 490, 124, 98) range(-12, -1, -12, 1, 0.5) outlinecolour(253, 114, 114, 255) markercolour(255, 0, 0, 255) trackercolour(255, 255, 255, 255) text("Mix") channel("lMix")

groupbox bounds(400, 450, 400, 150) colour(255, 255, 255, 255) text("Right")
rslider bounds(425, 500, 75, 70) range(0, 1, 0.5, 1, 0.001) outlinecolour(255, 79, 79, 255) markercolour(255, 0, 0, 255) trackercolour(255, 255, 255, 255) text("Intensity") channel("rInt") colour(255, 251, 251, 255)
rslider bounds(675, 500, 75, 70) range(0, 100, 10, 1, 0.001) markercolour(255, 0, 0, 255) outlinecolour(255, 119, 119, 255) trackercolour(255, 255, 255, 255) text("Resonance") channel("rRes")
rslider bounds(530, 490, 124, 98) range(-12, -1, -12, 1, 0.5) outlinecolour(253, 114, 114, 255) markercolour(255, 0, 0, 255) trackercolour(255, 255, 255, 255) text("Mix") channel("rMix")

combobox bounds(400, 580, 100, 20), channel("combobox"), populate("*.snaps")
filebutton bounds(340, 580, 60, 20), channel("but1"), text("Save", "Save"), mode("snapshot")


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
	klforate chnget "Rate"
	kcof chnget "Cof"

	kAint chnget "lInt"
	kAres chnget "lRes"
	kAmix chnget "lMix"

	kBint chnget "rInt"
	kBres chnget "rRes"
	kBmix chnget "rMix"

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

	alfo oscil 1, klforate, gisquare ; -1 to 1
	alfo = alfo * 0.5 + 0.5 ; 0 to 1


	;cof in hz -> double normal cof
	aAlfo = (alfo*kAint)*kcof*3 + kcof 
	aBlfo = (alfo*kBint)*kcof*3 + kcof

	aAsnd rezzy ain, aAlfo, kAres
	aBsnd rezzy ain, aBlfo, kBres

 
    amix = (aAsnd * ampdbfs(kAmix)) + (aBsnd * ampdbfs(kBmix)) + (ain * iDry)  ;+ (aoctave * ampdbfs(-12))

	
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