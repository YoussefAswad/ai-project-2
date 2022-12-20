:- include('KB.pl').

agent(X,Y,L,C,s0):-
    agent_loc(X,Y),ships_loc(L),capacity(C).

agent(X2,Y2,L,C,result(A,S)) :-
        (agent(X,Y,L,C,S), A = up, X > 0, X2 is X-1 , Y2 = Y);
        (agent(X,Y,L,C,S), grid(M,_),A = down, X < M, X2 is X+1 , Y2 = Y);
        (agent(X,Y,L,C,S), A = left, Y > 0, Y2 is Y-1 , X2 = X);
        (agent(X,Y,L,C,S),grid(_,N),A = right, Y < N, Y2 is Y+1 , X2 = X);
        (agent(X,Y,L2,C2,S), A = pickup,member([X,Y], L2),C2>0, C is C2-1,deleteFromList([X,Y],L2, L), X2 = X, Y2 = Y);
        (agent(X,Y,L,C2,S), A = drop,station(X,Y),capacity(C),C2 \== C ,X2 = X ,Y2 = Y).

helper(result(drop, S)):-
    agent(X, Y, [], _, S),
    station(X, Y).

goal(result(A, S)):-
    ids(A,S,0).

deleteFromList(A, [A|B], B).
    deleteFromList(A, [B, C|D], [B|E]) :-
        deleteFromList(A, [C|D], E).

ids(A,S,L):-
    (call_with_depth_limit(helper(result(A,S)),L,R), number(R));
    (call_with_depth_limit(helper(result(A,S)),L,R), R=depth_limit_exceeded,L1 is L+1, ids(A,S,L1)).