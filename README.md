# AI Assignment 2: Coast Guard Plan
- [AI Assignment 2: Coast Guard Plan](#ai-assignment-2-coast-guard-plan)
  - [1. Fluent used](#1-fluent-used)
    - [1.1. agent](#11-agent)
    - [1.2. helper](#12-helper)
  - [2. Successor state axioms](#2-successor-state-axioms)
    - [2.1. When the action is **up**, **down**, **left**, **right**](#21-when-the-action-is-up-down-left-right)
    - [2.2. When the action is **pickup**](#22-when-the-action-is-pickup)
    - [2.3. When the action is **drop**](#23-when-the-action-is-drop)
  - [3. Test Cases](#3-test-cases)
    - [3.1. KB.pl](#31-kbpl)
    - [3.2. KB2.pl](#32-kb2pl)


## 1. Fluent used

### 1.1. agent
this fluent contains the successor state axiom for the coast guard decisions it has 5 arguments
1. The x cooardinate of the coast guard boat
2. The y cooardinate of the coast guard boat
3. The list of ships that have a passenger
4. The current avialable capacity of the coast guard boat
5. result(A,S), which contains the action and previous states
### 1.2. helper 
This acts a the goal condition for the search problem. It states that the goal condition is that the current action is drop and the list of ships with passengers is empty and the location of the coast guard agent is same as the station location.

## 2. Successor state axioms
One successor state axiom was implemented 
### 2.1. When the action is **up**, **down**, **left**, **right**
we check wether the action is valid within the coordinates of the grid.
### 2.2. When the action is **pickup**
we chech wether the loaction of the coast gauard boat is contained in the list of ships with passengers, then the current ship is removed from said list and capacity is decremneted
### 2.3. When the action is **drop**
we check wether we are in the same location as the station, wether we are holding any passenfers to drop, and the capacity is reset to the original defined in the KB

## 3. Test Cases
### 3.1. KB.pl
1. goal(S).
    - Result: S = result(drop, result(up, result(left, result(pickup, result(down, result(right, result(drop, result(left, result(pickup, result(down, result(right, s0)))))))))))
    - Time: 65.02 sec
2. goal(result(drop, result(up, result(left, result(pickup, result(right, result(down, result(drop, result(left, result(pickup, result(right, result(down, s0)))))))))))).
    - Result: true
    - Time: 24 Sec
3. goal(result(up,result(down,s0))).
    - Result: false..
    - Time: 0 sec
### 3.2. KB2.pl
1. goal(S).
    - Result: S = result(drop, result(up, result(up, result(left, result(pickup, result(down, result(down, result(pickup, result(down, s0))))))))) .
    - Time: 2.35 sec
2. goal(result(drop,result(left,result(up,result(up, result(pickup, result(right, result(down, result(down, result(drop, result(left, result(pickup, result(down, s0)))))))))))))
    - Result: true
    - Time: 148 sec
3. goal(result(left,result(up,result(up, result(pickup, result(right, result(down, result(down, result(drop, result(left, result(pickup, result(down, s0)))))))))))).
    - Result: false..
    - Time: 0 sec