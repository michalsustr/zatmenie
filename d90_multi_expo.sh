#!/bin/bash

# Skript na nastavenie expozície zo zatmenia. Používa utilitu gphoto2
# Zoznam podporovaných foťákov: http://www.gphoto.org/proj/libgphoto2/support.php
# Odporúčam googliť niečo ako "gphoto2 solar eclipse"

# Z foťáku pripojenému k laptopu sa dajú vytiahnuť rôzne nastavenia (ako mám dole nižšie)
# Sú dosť divne indexované, napr shutterspeed=0 zodpovedá 0,0002s, takže 1/5000
# Najprv sa v skripte nastavia obecné veci, a potom nejaké špecifické v "cycle"
# "Cycle" opakovane robí fotky s rôznymi expozičnými časmi a ukladá ich na disk pod rôznymi názvami.

# Dalo by sa s presnými hodinami a GPSkou spraviť aj skript špecifický pre konkrétne zatmenie slnka
# napr. pre bailyho perly a podobne.


# Použitá expozícia:
# f/5,6:  1/4000, 1/1000, 1/250, 1/60, 1/15, 1/8, 1/4

# Robilo sa ručne niekým iným:
# f/11:  1/4000 baily
#        1/2000 chromo
# f/22:  1/1000 baily
#        1/500  chromo
# najprv 1/1000, potom 1/500


gphoto2 \
    --set-config /main/imgsettings/whitebalance=Daylight \
    --set-config /main/imgsettings/colorspace=sRGB \
    --set-config /main/capturesettings/dlighting=Off \
    --set-config /main/capturesettings/highisonr=Off \
    --set-config /main/capturesettings/imagequality=NEF+Basic \
    --set-config /main/capturesettings/longexpnr=Off \
    --set-config /main/capturesettings/assistlight=Off \
    --set-config /main/capturesettings/exposurecompensation=0 \
    --set-config /main/capturesettings/exposurecompensation2=Off \
    --set-config capturetarget=0 \
    --set-config /main/imgsettings/iso=200 \
    --set-config /main/capturesettings/f-number=3 \


function cycle() {
    # 1/4000
    gphoto2 --set-config /main/capturesettings/shutterspeed=0
    gphoto2 --capture-image-and-download --filename="$1_1_4000.nef" --force-overwrite

    # 1/1000
    gphoto2 --set-config /main/capturesettings/shutterspeed=4
    gphoto2 --capture-image-and-download --filename="$1_1_1000.nef" --force-overwrite

    # 1/250
    gphoto2 --set-config /main/capturesettings/shutterspeed=8
    gphoto2 --capture-image-and-download --filename="$1_1_250.nef" --force-overwrite

    # 1/60
    gphoto2 --set-config /main/capturesettings/shutterspeed=12
    gphoto2 --capture-image-and-download --filename="$1_1_60.nef" --force-overwrite

    # 1/15
    gphoto2 --set-config /main/capturesettings/shutterspeed=16
    gphoto2 --capture-image-and-download --filename="$1_1_15.nef" --force-overwrite

    # 1/8
    gphoto2 --set-config /main/capturesettings/shutterspeed=18
    gphoto2 --capture-image-and-download --filename="$1_1_8.nef" --force-overwrite

    # 1/4
    gphoto2 --set-config /main/capturesettings/shutterspeed=20
    gphoto2 --capture-image-and-download --filename="$1_1_4.nef" --force-overwrite
}

cycle "1"
cycle "2"
cycle "3"
cycle "4"
cycle "5"
cycle "6"


gphoto2 --set-config /main/capturesettings/shutterspeed=6 \
        --set-config /main/capturesettings/f-number=22


# ➜  zatmenie gphoto2 --get-config /main/capturesettings/shutterspeed
#Current: 0,0500s
#Choice: 0 0,0002s
#Choice: 1 0,0003s
#Choice: 2 0,0005s
#Choice: 3 0,0006s
#Choice: 4 0,0010s
#Choice: 5 0,0013s
#Choice: 6 0,0020s
#Choice: 7 0,0028s
#Choice: 8 0,0040s
#Choice: 9 0,0055s
#Choice: 10 0,0080s
#Choice: 11 0,0111s
#Choice: 12 0,0166s
#Choice: 13 0,0222s
#Choice: 14 0,0333s
#Choice: 15 0,0500s
#Choice: 16 0,0666s
#Choice: 17 0,1000s
#Choice: 18 0,1250s
#Choice: 19 0,1666s
#Choice: 20 0,2500s
#Choice: 21 0,3333s
#Choice: 22 0,5000s
#Choice: 23 0,6666s
#Choice: 24 1,0000s
#Choice: 25 1,5000s
#Choice: 26 2,0000s
#Choice: 27 3,0000s
#Choice: 28 4,0000s
#Choice: 29 6,0000s
#Choice: 30 8,0000s
#Choice: 31 10,0000s
#Choice: 32 15,0000s
#Choice: 33 20,0000s
#Choice: 34 30,0000s

# ➜  zatmenie gphoto2 --get-config /main/capturesettings/f-number
#Current: f/22
#Choice: 0 f/3,5
#Choice: 1 f/4
#Choice: 2 f/4,8
#Choice: 3 f/5,6
#Choice: 4 f/6,7
#Choice: 5 f/8
#Choice: 6 f/9,5
#Choice: 7 f/11
#Choice: 8 f/13
#Choice: 9 f/16
#Choice: 10 f/19
#Choice: 11 f/22


#➜  zatmenie gphoto2 --list-config
#/main/actions/autofocusdrive
#/main/actions/manualfocusdrive
#/main/actions/changeafarea
#/main/actions/controlmode
#/main/actions/viewfinder
#/main/actions/opcode
#/main/settings/meterofftime
#/main/settings/datetime
#/main/settings/imagecomment
#/main/settings/imagecommentenable
#/main/settings/recordingmedia
#/main/settings/reversedial
#/main/settings/ccdnumber
#/main/settings/menusandplayback
#/main/settings/fastfs
#/main/settings/capturetarget
#/main/settings/autofocus
#/main/status/serialnumber
#/main/status/manufacturer
#/main/status/cameramodel
#/main/status/deviceversion
#/main/status/vendorextension
#/main/status/acpower
#/main/status/externalflash
#/main/status/batterylevel
#/main/status/orientation
#/main/status/flashopen
#/main/status/flashcharged
#/main/status/minfocallength
#/main/status/maxfocallength
#/main/status/apertureatminfocallength
#/main/status/apertureatmaxfocallength
#/main/status/lowlight
#/main/status/lightmeter
#/main/status/aflocked
#/main/status/aelocked
#/main/status/fvlocked
#/main/imgsettings/imagesize
#/main/imgsettings/iso
#/main/imgsettings/isoauto
#/main/imgsettings/whitebalance
#/main/imgsettings/colorspace
#/main/imgsettings/autoiso
#/main/capturesettings/minimumshutterspeed
#/main/capturesettings/isoautohilimit
#/main/capturesettings/dlighting
#/main/capturesettings/highisonr
#/main/capturesettings/imagequality
#/main/capturesettings/shootingspeed
#/main/capturesettings/moviequality
#/main/capturesettings/flashshutterspeed
#/main/capturesettings/longexpnr
#/main/capturesettings/assistlight
#/main/capturesettings/exposurecompensation
#/main/capturesettings/exposurecompensation2
#/main/capturesettings/flashmode
#/main/capturesettings/nikonflashmode
#/main/capturesettings/flashcommandchannel
#/main/capturesettings/flashcommandselfmode
#/main/capturesettings/flashcommandselfcompensation
#/main/capturesettings/flashcommandselfvalue
#/main/capturesettings/flashcommandamode
#/main/capturesettings/flashcommandacompensation
#/main/capturesettings/flashcommandavalue
#/main/capturesettings/flashcommandbmode
#/main/capturesettings/flashcommandbcompensation
#/main/capturesettings/flashcommandbvalue
#/main/capturesettings/af-area-illumination
#/main/capturesettings/afbeep
#/main/capturesettings/f-number
#/main/capturesettings/flexibleprogram
#/main/capturesettings/focallength
#/main/capturesettings/focusmode
#/main/capturesettings/focusmode2
#/main/capturesettings/expprogram
#/main/capturesettings/capturemode
#/main/capturesettings/focusmetermode
#/main/capturesettings/exposuremetermode
#/main/capturesettings/shutterspeed
#/main/capturesettings/shutterspeed2
#/main/capturesettings/focusareawrap
#/main/capturesettings/exposuredelaymode
#/main/capturesettings/exposurelock
#/main/capturesettings/aelaflmode
#/main/capturesettings/liveviewafmode
#/main/capturesettings/filenrsequencing
#/main/capturesettings/flashsign
#/main/capturesettings/modelflash
#/main/capturesettings/viewfindergrid
#/main/capturesettings/imagerotationflag
#/main/capturesettings/nocfcardrelease
#/main/capturesettings/flashmodemanualpower
#/main/capturesettings/autofocusarea
#/main/capturesettings/flashexposurecompensation
#/main/capturesettings/bracketing
#/main/capturesettings/evstep
#/main/capturesettings/bracketset
#/main/capturesettings/bracketorder
#/main/capturesettings/burstnumber
#/main/capturesettings/maximumshots
#/main/capturesettings/autowhitebias
#/main/capturesettings/tungstenwhitebias
#/main/capturesettings/flourescentwhitebias
#/main/capturesettings/daylightwhitebias
#/main/capturesettings/flashwhitebias
#/main/capturesettings/cloudywhitebias
#/main/capturesettings/shadewhitebias
#/main/capturesettings/whitebiaspresetno
#/main/capturesettings/whitebiaspreset0
#/main/capturesettings/whitebiaspreset1
#/main/capturesettings/whitebiaspreset2
#/main/capturesettings/whitebiaspreset3
#/main/capturesettings/whitebiaspreset4
#/main/capturesettings/selftimerdelay
#/main/capturesettings/centerweightsize
#/main/capturesettings/remotetimeout
#/main/capturesettings/moviesound
#/main/capturesettings/reverseindicators
