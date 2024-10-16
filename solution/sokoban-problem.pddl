(define (problem sokoban-problem)
(:domain sokoban)
(:objects
pos1_3 - position
pos1_4 - position
pos2_3 - position
pos2_4 - position
pos3_1 - position
pos3_2 - position
pos3_3 - position
pos3_4 - position
pos4_1 - position
pos4_3 - position
pos4_4 - position
pos5_1 - position
pos5_2 - position
pos5_3 - position
pos5_4 - position
pos6_2 - position
pos6_3 - position
pos6_4 - position
player1 - player
box1 - box
box2 - box
box3 - box
)
(:init
(player-at player1 pos4_3)
(free pos1_3)
(free pos1_4)
(free pos2_3)
(free pos2_4)
(goal pos2_4)
(free pos3_1)
(free pos3_2)
(box-at box1 pos3_3)
(goal pos3_3)
(free pos3_4)
(free pos4_1)
(free pos4_4)
(free pos5_1)
(box-at box2 pos5_2)
(box-at box3 pos5_3)
(goal pos5_3)
(free pos5_4)
(free pos6_2)
(free pos6_3)
(free pos6_4)
(adjacent pos1_3 pos1_4 right)
(adjacent pos1_4 pos1_3 left)
(adjacent pos1_3 pos2_3 down)
(adjacent pos2_3 pos1_3 up)
(adjacent pos1_4 pos2_4 down)
(adjacent pos2_4 pos1_4 up)
(adjacent pos2_3 pos2_4 right)
(adjacent pos2_4 pos2_3 left)
(adjacent pos2_3 pos3_3 down)
(adjacent pos3_3 pos2_3 up)
(adjacent pos2_4 pos3_4 down)
(adjacent pos3_4 pos2_4 up)
(adjacent pos3_1 pos3_2 right)
(adjacent pos3_2 pos3_1 left)
(adjacent pos3_1 pos4_1 down)
(adjacent pos4_1 pos3_1 up)
(adjacent pos3_2 pos3_3 right)
(adjacent pos3_3 pos3_2 left)
(adjacent pos3_3 pos3_4 right)
(adjacent pos3_4 pos3_3 left)
(adjacent pos3_3 pos4_3 down)
(adjacent pos4_3 pos3_3 up)
(adjacent pos3_4 pos4_4 down)
(adjacent pos4_4 pos3_4 up)
(adjacent pos4_1 pos5_1 down)
(adjacent pos5_1 pos4_1 up)
(adjacent pos4_3 pos4_4 right)
(adjacent pos4_4 pos4_3 left)
(adjacent pos4_3 pos5_3 down)
(adjacent pos5_3 pos4_3 up)
(adjacent pos4_4 pos5_4 down)
(adjacent pos5_4 pos4_4 up)
(adjacent pos5_1 pos5_2 right)
(adjacent pos5_2 pos5_1 left)
(adjacent pos5_2 pos5_3 right)
(adjacent pos5_3 pos5_2 left)
(adjacent pos5_2 pos6_2 down)
(adjacent pos6_2 pos5_2 up)
(adjacent pos5_3 pos5_4 right)
(adjacent pos5_4 pos5_3 left)
(adjacent pos5_3 pos6_3 down)
(adjacent pos6_3 pos5_3 up)
(adjacent pos5_4 pos6_4 down)
(adjacent pos6_4 pos5_4 up)
(adjacent pos6_2 pos6_3 right)
(adjacent pos6_3 pos6_2 left)
(adjacent pos6_3 pos6_4 right)
(adjacent pos6_4 pos6_3 left)
)
(:goal (and 
(at-goal box1)
(at-goal box2)
(at-goal box3)
))
)
