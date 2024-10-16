(define (domain sokoban)
  (:requirements :strips :typing :conditional-effects :negative-preconditions)

  (:types 
    player 
    box 
    position
    direction)

  (:constants
    up down left right - direction)

  (:predicates 
    (player-at ?p - player ?pos - position)
    (box-at ?b - box ?pos - position)
    (free ?pos - position)
    (goal ?pos - position)
    (at-goal ?b - box)
    (adjacent ?pos1 ?pos2 - position ?dir - direction))

  

  (:action move-up
    :parameters (?p - player ?from ?to - position)
    :precondition (and (player-at ?p ?from)
                       (free ?to)
                       (adjacent ?from ?to up))
    :effect (and (player-at ?p ?to)
                 (free ?from)
                 (not (player-at ?p ?from))
                 (not (free ?to))))

  (:action move-down
    :parameters (?p - player ?from ?to - position)
    :precondition (and (player-at ?p ?from)
                       (free ?to)
                       (adjacent ?from ?to down))
    :effect (and (player-at ?p ?to)
                 (free ?from)
                 (not (player-at ?p ?from))
                 (not (free ?to))))

  (:action move-right
    :parameters (?p - player ?from ?to - position)
    :precondition (and (player-at ?p ?from)
                       (free ?to)
                       (adjacent ?from ?to right))
    :effect (and (player-at ?p ?to)
                 (free ?from)
                 (not (player-at ?p ?from))
                 (not (free ?to))))

  (:action move-left
    :parameters (?p - player ?from ?to - position)
    :precondition (and (player-at ?p ?from)
                       (free ?to)
                       (adjacent ?from ?to left))
    :effect (and (player-at ?p ?to)
                 (free ?from)
                 (not (player-at ?p ?from))
                 (not (free ?to))))

  (:action push-up
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to up)
        (adjacent ?to ?box-to up)
        (not (at-goal ?b)))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))))

    (:action push-down
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to down)
        (adjacent ?to ?box-to down)
        (not (at-goal ?b)))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))))

    (:action push-right
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to right)
        (adjacent ?to ?box-to right)
        (not (at-goal ?b)))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))))

    (:action push-left
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to left)
        (adjacent ?to ?box-to left)
        (not (at-goal ?b)))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))))

    (:action push-to-goal-up
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to up)
        (adjacent ?to ?box-to up)
        (goal ?box-to))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))
        (at-goal ?b)))

    (:action push-to-goal-down
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to down)
        (adjacent ?to ?box-to down)
        (goal ?box-to))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))
        (at-goal ?b)))

    (:action push-to-goal-right
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to right)
        (adjacent ?to ?box-to right)
        (goal ?box-to))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))
        (at-goal ?b)))

    (:action push-to-goal-left
    :parameters (?p - player ?b - box ?from ?to ?box-to - position)
    :precondition (and 
        (player-at ?p ?from)
        (box-at ?b ?to)
        (free ?box-to)
        (adjacent ?from ?to left)
        (adjacent ?to ?box-to left)
        (goal ?box-to))
    :effect (and 
        (box-at ?b ?box-to)
        (player-at ?p ?to)
        (free ?from)
        (not (box-at ?b ?to))
        (not (player-at ?p ?from))
        (not (free ?to))
        (not (free ?box-to))
        (at-goal ?b)))
)
