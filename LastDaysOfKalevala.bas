'Last Days Of Kalevala

'DIM allowGL AS _BYTE

DIM camera_x AS INTEGER
DIM camera_y AS INTEGER
DIM tile(1000, 1000) AS INTEGER
DIM anna_x AS INTEGER
DIM anna_y AS INTEGER
DIM anna_width AS INTEGER
DIM anna_height AS INTEGER
DIM key$





'perform startup routines like loading assets

setup:
rendermode = 1

IF rendermode = 0 THEN
    'allowGL = -1 'sets allowGL to true so SUB _GL can run
END IF


screenRes_x = 1280 'Real horizontal resolution of the screen
screenRes_y = 720 'Real vertical resolution of the screen
widescreen = 1 '0 if 4:3
virtualRes_x = 320
virtualRes_y = 180
IF screenRes_x / screenRes_y > 1.5 THEN virtualRes_y = 240 AND widescreen = 0 'use 240 for 4:3 displays
HW_images = 32 '33 if using HW images, 32 if not

area = 0

'gameimage& = _NEWIMAGE(virtualRes_x, virtualRes_y, HW_images)
'gamewin& = _NEWIMAGE(screeRes_x, screenRes_y, HW_images)
gameimage& = _NEWIMAGE(320, 180, 32)
gamewin& = _NEWIMAGE(1280, 720, 32)

DIM anna_sprites&(50)
anna_sprites&(50) = _NEWIMAGE(32, 64, 32) 'USE (xx, yy, 33) for hardware images

SCREEN gamewin&

area:
IF area = 0 THEN
    area = 1
    ' "Start new game"/"Continue", etc comes here...

END IF

newgame:
'CHOOSE YOUR PLAYER BULL comes here...
active_player$ = "anna"

change_area:
IF area = 1 THEN
    'put this stuff in to a file

    mapfile$ = "./LevelData/map1.png"
    'TILED won't export in format that could be just a memory block, so just for the time being i'm revertin back to full bitmaps
    'Do a CSV to bytemap converter (8-bit bitmap) and use tilebased maps later

    background$ = "./graphics/nightsky.png"

    map& = mapfile
    'anim_a$ = "anim_a1.png"
    'anim_b$ = "anim_b1.png"
    'anim_c$ = "anim_c1.png"
    'parallax_a$ = "para_a1.png"
    'parallax_b$ = "para_b1.png"
    'parallax_c$ = "para_c1.png"

    'PUT THIS SHIT IN A SUB AND DO THE SAME TO OTHER CHARACTER AND OBJECT DEFINITIONS
    anna_sprites&(0) = _LOADIMAGE("./sprites/anna/Anna1.png", HW_images) '
    anna_sprites&(1) = _LOADIMAGE("./sprites/anna/Anna2.png", HW_images)
    anna_sprites&(2) = _LOADIMAGE("./sprites/anna/Anna3.png", HW_images)
    anna_sprites&(3) = _LOADIMAGE("./sprites/anna/Anna4.png", HW_images)
    anna_sprites&(4) = _LOADIMAGE("./sprites/anna/Anna5.png", HW_images)
    anna_sprites&(5) = _LOADIMAGE("./sprites/anna/Anna6.png", HW_images)
    anna_sprites&(6) = _LOADIMAGE("./sprites/anna/Anna7.png", HW_images)
    anna_sprites&(7) = _LOADIMAGE("./sprites/anna/Anna8.png", HW_images)
    anna_sprites&(8) = _LOADIMAGE("./sprites/anna/Anna9.png", HW_images)
    anna_sprites&(9) = _LOADIMAGE("./sprites/anna/Anna10.png", HW_images)
    anna_sprites&(10) = _LOADIMAGE("./sprites/anna/Anna11.png", HW_images)
    anna_sprites&(11) = _LOADIMAGE("./sprites/anna/Anna12.png", HW_images)
    anna_sprites&(12) = _LOADIMAGE("./sprites/anna/Anna13.png", HW_images)
    anna_sprites&(13) = _LOADIMAGE("./sprites/anna/Anna14.png", HW_images)
    anna_sprites&(14) = _LOADIMAGE("./sprites/anna/Anna15.png", HW_images)
    anna_sprites&(15) = _LOADIMAGE("./sprites/anna/Anna16.png", HW_images)
    anna_sprites&(16) = _LOADIMAGE("./sprites/anna/Anna17.png", HW_images)
    anna_sprites&(17) = _LOADIMAGE("./sprites/anna/Anna18.png", HW_images)
    anna_sprites&(18) = _LOADIMAGE("./sprites/anna/Anna19.png", HW_images)
    anna_sprites&(19) = _LOADIMAGE("./sprites/anna/Anna20.png", HW_images)
    anna_sprites&(20) = _LOADIMAGE("./sprites/anna/Anna_idle1.png", HW_images)
    anna_sprites&(21) = _LOADIMAGE("./sprites/anna/Anna_idle2.png", HW_images)
    anna_sprites&(22) = _LOADIMAGE("./sprites/anna/Anna_idle3.png", HW_images)
    anna_sprites&(23) = _LOADIMAGE("./sprites/anna/Anna_idle4.png", HW_images)
    'anna_sprites&(24) = _LOADIMAGE("./sprites/anna/Anna25.png", HW_images)
    'anna_sprites&(25) = _LOADIMAGE("./sprites/anna/Anna26.png", HW_images)

    DIM anna_idle_frames AS INTEGER
    DIM anna_walk_frames AS INTEGER
    DIM anna_jump_frames AS INTEGER
    'prehigh is only 1 frame between jump and high (first high frame)
    DIM anna_high_frames AS INTEGER
    'posthigh is 1 frame between high and fall (first fall frame)
    DIM anna_fall_frames AS INTEGER
    'landing is 1 frame between fall and idle (first idle)
    anna_idle_frames = 4
    anna_walk_frames = 8
    anna_jump_frames = 3
    anna_high_frames = 5
    anna_fall_frames = 2

    DIM anna_idle_anim(anna_idle_frames - 1) AS INTEGER 'as in frame number
    DIM anna_idle_anim_t(anna_idle_frames - 1) AS INTEGER 'as in how many frames

    anna_idle_anim(0) = 22
    anna_idle_anim_t(0) = 3
    anna_idle_anim(1) = 23
    anna_idle_anim_t(1) = 3
    anna_idle_anim(2) = 24
    anna_idle_anim_t(2) = 3
    anna_idle_anim(3) = 25
    anna_idle_anim_t(3) = 3


    DIM anna_walk_anim(anna_walk_frames - 1) AS INTEGER
    DIM anna_walk_anim_t(anna_walk_frames - 1) AS INTEGER

    DIM anna_jump_anim(anna_jump_frames - 1) AS INTEGER 'CHECK
    DIM anna_jump_anim_t(anna_jump_frames - 1) AS INTEGER

    DIM anna_prehigh_anim AS INTEGER
    DIM anna_prehigh_anim_t AS INTEGER

    DIM anna_high_anim(anna_high_frames - 1) AS INTEGER
    DIM anna_high_anim_t(anna_high_frames - 1) AS INTEGER

    DIM anna_posthigh_anim AS INTEGER
    DIM anna_posthigh_anim_t AS INTEGER

    DIM anna_fall_anim(anna_fall_frames - 1) AS INTEGER
    DIM anna_fall_anim_t(anna_fall_frames - 1) AS INTEGER

    DIM anna_landing_anim AS INTEGER 'Can't do anything when landing, walljumping or doublejump-frame is active
    DIM anna_landing_anim_t AS INTEGER

    DIM anna_walljump_anim AS INTEGER
    DIM anna_walljump_anim_t AS INTEGER

    DIM anna_doublejump_anim AS INTEGER
    DIM anna_doublejump_anim_t AS INTEGER

    '''LOAD AREAS DEF FILE area1.def -- def files list npc files to load
    '''LOAD NPC files -- npc files have animations for states and scripts that define behavior between npc and reactions to player characters



    map& = _LOADIMAGE("./LevelData/map1.png", 32)
    back& = _LOADIMAGE("./graphics/nightsky.png", 32)
    parallax& = _LOADIMAGE("./graphics/paskatausta2.png", 32)


    anna_x = 3200
    anna_y = 580
    anna_width = 32
    anna_height = 64
    anna_current% = 0 'current sprite nro.
    anna_heading = 1 'right left=-1


END IF

SCREEN gamewin&
main:
DO
    softrender: 'this stuff belongs to a sub
    _SOURCE back&
    _DEST gameimage&
    _PUTIMAGE
    '_SOURCE map&
    cam_x = anna_x - 136
    cam_y = anna_y - 57
    IF cam_x < 0 THEN cam_x = 0
    IF cam_y < 0 THEN cam_y = 0
    parallax_x = INT(cam_x / 4)
    parallax_y = INT(cam_y / 4)
    _PUTIMAGE (0, 0)-(319, 179), parallax&, gameimage&, (parallax_x, parallax_y)-(parallax_x + 319, parallax_y + 179)
    _PUTIMAGE (0, 0)-(319, 179), map&, gameimage&, (cam_x, cam_y)-(cam_x + 319, cam_y + 179)

    _SOURCE gameimage&
    _DEST gamewin&
    _PUTIMAGE

    animate_anna:
    IF anna_state = 1 THEN 'idle

        IF annacount% = anna_idle_anim_t(anna_current%) THEN
            annacount% = 0
            anna_current% = anna_current% + 1
            IF anna_current% = anna_idle_frames THEN anna_current% = 0
        END IF
    ELSEIF anna_state = 2 THEN 'walk
        'walk
    ELSEIF anna_state = 3 THEN 'jump
        'jump
    END IF

    _PUTIMAGE (136, 57), anna_sprites&(anna_current%), gameimage& 'Wont work right near the level borders!!!
    'annacount% = annacount% + 1
    'IF annacount% = 5 THEN
    '    anna_current% = anna_current% + 1
    '    IF anna_current% = 20 THEN anna_current% = 0
    '    annacount% = 0
    'END IF






    IF key$ = "a" THEN anna_x = anna_x - 1
    IF key$ = "d" THEN anna_x = anna_x + 1
    IF key$ = "w" THEN anna_y = anna_y - 1
    IF key$ = "s" THEN anna_y = anna_y + 1

    checkinput:
    key$ = INKEY$
    'anna_state values 1=idle, 2=walk, 3=jump
    'IF _KEYDOWN(CVI(CHR$(0) + "P")) THEN y = y + 1 '_KEYDOWN(20480)
    IF _KEYDOWN(CVI(CHR$(0) + "H")) THEN next_anna_state = 3 '_KEYDOWN(18432)
    IF _KEYDOWN(CVI(CHR$(0) + "K")) THEN '_KEYDOWN(19200)
        anna_x = anna_x - 1
        IF anna_state < 3 THEN anna_state = 2
        anna_heading = -1 'left

    ELSEIF _KEYDOWN(CVI(CHR$(0) + "M")) THEN '_KEYDOWN(19712)
        anna_x = anna_x + 1
        IF anna_state < 3 THEN anna_state = 2
        anna_heading = 1 'right
    ELSE
        IF anna_state < 3 THEN anna_state = 1
    END IF

    'check inputs that control player characters
    npc_turn:
    'VM that controls npc's according to their script file
    'files in gameX are written every time game is saved, or
    'npc script-files are something like this:
    '
    'type
    'name
    'affiliation
    'hp 100
    'anna neutral 'affiliations fame is added when in contact
    'jonne neutral
    'start XXXX YYYY heading
    '
    'newstate state1
    'allstates
    '
    'state1
    'idle right
    'newstate state2 5 600 '' means 5% prob every 600 frames to change to state2
    '
    'end1
    'state2
    'walk left downstairs 'if any stairs happen to be on the way use ones you can go down
    'when stop state3
    'when 1240 state3
    '
    'state3
    'backtostart
    '
    DO
        npc_count% = 0
        count% = 1
    LOOP UNTIL count% > npc_count%
    enemy_turn:
    'Minor, non-story and respawning enemies that have no interactions or dialog


    _DISPLAY
LOOP UNTIL key$ = CHR$(27)


SUB RENDER
    'Software render code here

END SUB

'SUB _GL
'    IF NOT allowGL THEN EXIT SUB 'used to bypass running the code below until
'                             startup routines are done in the main module

'OpenGL code starts here
'The code in this area will be run automatically at ~60fps
'END SUB

FUNCTION RectColl (Ax1, Ay1, Ax2, Ay2, Bx1, By1, Bx2, By2)
    RectColl = 0
    IF Ax2 >= Bx1 AND Ax1 <= Bx2 THEN 'first check if on the same x-axis
        IF Ay2 >= By1 AND Ay1 <= By2 THEN
            RectColl = 1
        END IF
    END IF
END FUNCTION



