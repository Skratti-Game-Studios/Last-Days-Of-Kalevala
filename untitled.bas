back& = _LOADIMAGE("./graphics/nightsky.png", 32)
gamescreen& = _NEWIMAGE(1280, 720, 32)
_SOURCE back&
_DEST gamescreen&
_PUTIMAGE
SCREEN gamescreen&
SLEEP 1

