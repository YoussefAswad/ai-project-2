:- include('KB.pl').

%result(_,s0).

agent(0,1,[[2,2],[1,2]],1,result(up,s0)).
agent(X,Y,L,C,result(A,S)) :- 
       ( agent(X,Y,L,C,result(A,S)), 
        (A = up, (X=0)) ;
        (A = down, (X=2));
        (A = left, (Y=0));
        (A = right, (Y=2)) ;
        (A = pickup,not(member([X,Y], L));C=0);
        (A = drop,not(station(X,Y)),capacity(C))
    )
        ;
        (agent(X2,Y,L,C,result(A, S)), A = up, X > 0, X2 is X-1);
        (agent(X2,Y,L,C,result(A, S)), A = down, X < 2, X2 is X+1);
        (agent(X,Y2,L,C,result(A, S)), A = left, Y > 0, Y2 is Y-1);
        (agent(X,Y2,L,C,result(A, S)), A = right, Y < 2, Y2 is Y+1);
        (agent(X,Y,L2,C2,result(A, S)), A = pickup,member([X,Y], L),C>0, C2 is C-1,delete((L),[X,Y], L2));
        (agent(X,Y,L2,C2,result(A, S)), A = drop,station(X,Y),not(capacity(C)),capacity(C2)).

    goal(S) :- capacity(C), agent(X,Y,L,C,S),L = [].

ids(X,Y,L,C,S,Li):-
(call_with_depth_limit(agent(X,Y,L,C,S),Li,R), number(R));
(call_with_depth_limit(agent(X,Y,L,C,S),Li,R), R=depth_limit_exceeded,
L1 is Li+1, ids(X,Y,L,C,S,L1)).
