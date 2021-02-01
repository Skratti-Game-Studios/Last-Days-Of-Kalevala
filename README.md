

'# Last-Days-Of-Kalevala ' Adventurous metroidvania open world game based on Finnish pantheon of gods and ancienct Finnish mythology. What will you do at the end of everything? Sisulla 'siitä selviää!

'GPL license only applys to code -- not graphics, sound, music, video or other multimedia.

'Trying to make my code organized enough to be readable, and organized in a way that everything is not coded in the main loop. 'This version is organized in a way to keep the main game loop easy to understand. It doesn't do much yet, but just in case my laptop gives up on me... 'For readability it has different variables for our main characters, but it should be trivial to turn it in to an 2D platformer engine that reads every 'characters and objects behavior, animations, attributes, and dialog from a file -- and doesn't actually care what or where controls which character.

'... here it is

'Code is written in QB64, and should be in some .bas file.

'Last Days Of Kalevala

'DIM allowGL AS _BYTE

DIM camera_x AS INTEGER DIM camera_y AS INTEGER DIM tile(1000, 1000) AS INTEGER DIM anna_x AS INTEGER DIM anna_y AS INTEGER DIM anna_width AS INTEGER DIM anna_height AS INTEGER

'perform startup routines like loading assets needed before game

setup: rendermode = 1

IF rendermode = 0 THEN 'allowGL = -1 'sets allowGL to true so SUB _GL can run END IF

screenRes_x = 1280 'Real horizontal resolution of the screen screenRes_y = 720 'Real vertical resolution of the screen widescreen = 1 '0 if 4:3 virtualRes_x = 320 virtualRes_y = 180 IF screenRes_x / screenRes_y > 1.5 THEN virtualRes_y = 240 AND widescreen = 0 'use 240 for 4:3 displays HW_images = 32 '33 if using HW images, 32 if not

area = 0

gameimage& = _NEWIMAGE(320, 180, HW_images) gamewin& = _NEWIMAGE(1280, 720, HW_images) anna_sprites&(50) = _NEWIMAGE(32, 64, HW_images) 'USE (xx, yy, 33) for hardware images

area: IF area = 0 THEN area = 1 ' "Start new game"/"Continue", etc comes here...

END IF

newgame: 'CHOOSE YOUR PLAYER BULL comes here... active_player$ = "anna"

change_area: IF area = 1 THEN 'put this stuff in to a file

mapfile$ = "./LevelData/map1.csv"
background$ = "./graphics/nightsky.png"
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
anna_sprites&(20) = _LOADIMAGE("./sprites/anna/Anna21.png", HW_images)
anna_sprites&(21) = _LOADIMAGE("./sprites/anna/Anna22.png", HW_images)
anna_sprites&(22) = _LOADIMAGE("./sprites/anna/Anna23.png", HW_images)
anna_sprites&(23) = _LOADIMAGE("./sprites/anna/Anna24.png", HW_images)
anna_sprites&(24) = _LOADIMAGE("./sprites/anna/Anna25.png", HW_images)
anna_sprites&(25) = _LOADIMAGE("./sprites/anna/Anna26.png", HW_images)

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


backlayer& = _LOADIMAGE("./nightsky.png", HW_images)

END IF anna_x = 3200 anna_y = 448 anna_width = 32 anna_height = 64

main: DO

LOOP

SUB RENDER 'Software render code here

END SUB

'SUB _GL ' IF NOT allowGL THEN EXIT SUB 'used to bypass running the code below until ' startup routines are done in the main module

'OpenGL code starts here 'The code in this area will be run automatically at ~60fps 'END SUB

FUNCTION RectColl (Ax1, Ay1, Ax2, Ay2, Bx1, By1, Bx2, By2) RectColl = 0 IF Ax2 >= Bx1 AND Ax1 <= Bx2 THEN 'first check if on the same x-axis IF Ay2 >= By1 AND Ay1 <= By2 THEN RectColl = 1 END IF END IF END FUNCTION



