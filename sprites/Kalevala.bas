'Last Days Of Kalevala

DIM allowGL AS _BYTE

DIM active_player AS _BYTE
DIM camera_x AS INTEGER
DIM camera_y AS INTEGER
DIM x(255) AS INTEGER
DIM y(255) AS INTEGER
'perform startup routines like loading assets

setup:
softRender = -1 'If true game will render in software instead of OpenGL.. ie. use "SUB nonGL" instead of "SUB _GL"

allowGL = -1 'sets allowGL to true so SUB _GL can run

screenRes_x = 1920 'Real horizontal resolution of the screen
screenRes_y = 1080 'Real vertical resolution of the screen
virtualRes_x = 320
virtualRes_y = 180 'use 240 for 4:3 displays
area = 0

SCREEN _NEWIMAGE(1280, 720, 32)


area:
IF area = 0 THEN
    area = 1
    ' "Start new game"/"Continue", etc comes here...

END IF


change_area:
IF area = 1 THEN
    'put this stuff in to a file

    mapfile$ = "map1.png"
    background$ = "background1.png"
    anim_a$ = "anim_a1.png"
    anim_b$ = "anim_b1.png"
    anim_c$ = "anim_c1.png"
    parallax_a$ = "para_a1.png"
    parallax_b$ = "para_b1.png"
    parallax_c$ = "para_c1.png"
END IF


main:
DO

LOOP

SUB RENDER
    'Software render code here

END SUB

SUB _GL
    IF NOT allowGL THEN EXIT SUB 'used to bypass running the code below until
    '                             startup routines are done in the main module

    'OpenGL code starts here
    'The code in this area will be run automatically at ~60fps
END SUB



