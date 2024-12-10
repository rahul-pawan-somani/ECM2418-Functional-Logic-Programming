main
    : - generator4 (X) , selector4 (X) , write (X).
    
generator4 ([[ M1, D1, S1 ], [ M2, D2, S2 ]])
    : - between (1, 12, M1),
        days (M1, D1),
        addWrap12 ( M1 , 1 , M2),
        days (M2, D2),
        between (1 , 7 , S1),
        T is D1 mod 7,
        addWrap7 (S1, T, S2).

days ( 1 , 31) . % January
days ( 2 , 28) . % February
days ( 2 , 29) . % February (Leap)
days ( 3 , 31) . % March
days ( 4 , 30) . % April
days ( 5 , 31) . % May
days ( 6 , 30) . % June
days ( 7 , 31) . % July
days ( 8 , 31) . % August
days ( 9 , 30) . % September
days (10 , 31) . % October
days (11 , 30) . % November
days (12 , 31) . % December

addWrap12 (P , Q , R )
    : - T is P + Q ,
        ( T > 12 -> R is T - 12; R is T ).

addWrap7 (P , Q , R )
    : - T is P + Q ,
        ( T > 7 -> R is T - 7; R is T ).

selector4 ([[ M1 , D1 , S1 ] ,[ M2 , D2 , S2 ]])
    : - measure ( M1 , D1 , S1 , T1 , T2 , T3 , T4 , T5 ),
        measure ( M2 , D2 , S2 , U1 , U2 , U3 , U4 , U5 ),
        T1 =\= U1 , T2 =\= U2 , T3 =\= U3 , T4 =\= U4 , T5 =\= U5,
        TA is T1 + T2 + T3 + T4 + T5,
        UA is U1 + U2 + U3 + U4 + U5,
        prime ( TA ),
        prime ( UA ).

measure (M , D , S , D , V2 , V3 , V4 , V5 )
    : - letters (M , V2 ),
        primes (D , V3 ),
        mondays (D , S , TS ) , length ( TS , V4 ),
        primeSaturdays (D , S , US ) , length ( US , V5 ).

                    % 123456789
letters ( 1 , 7) . % January
letters ( 2 , 8) . % February
letters ( 3 , 5) . % March
letters ( 4 , 5) . % April
letters ( 5 , 3) . % May
letters ( 6 , 4) . % June
letters ( 7 , 4) . % July
letters ( 8 , 6) . % August
letters ( 9 , 9) . % September
letters (10 , 7) . % October
letters (11 , 8) . % November
letters (12 , 8) . % December

% 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11
% - -+ - -+ - -+ - -+ - -+ - -+ - -+ - -+ - -+ - -+ - -
% 2| 3| 5| 7|11|13|17|19|23|29|31
primes (28 , 9).
primes (29 , 10).
primes (30 , 10).
primes (31 , 11).

mondays (D , S , TS )
    : - T is 7 - S ,
        addWrap7 (T , 2 , I ),
        fromToStep (I , D , 7 , TS ).

saturdays (D , S , TS )
    : - T is 7 - S,
        addWrap7 (T , 0 , I ),
        fromToStep (I , D , 7 , TS ).

fromToStep (I , D , _ , [])
    : - I > D.
fromToStep (I , D , S , [ I |IS ])
    : - I = < D,
        I1 is I + S,
        fromToStep ( I1 , D , S , IS).

primeSaturdays (D , S , US )
    : - saturdays (D , S , TS ),
        intersection ( TS , [2 ,3 ,5 ,7 ,11 ,13 ,17 ,19 ,23 ,29 ,31] , US ).

prime ( N )
    : - N < 2, false.
prime ( N )
    : - N >= 2,
        \+ factorisable (N , 2).

factorisable (N , F )
    : - N < F * F , false.
factorisable (N , F )
    : - N >= F * F,
        0 is N mod F.
factorisable (N , F )
    : - N >= F * F,
        F1 is F + 1,
        factorisable (N , F1 ).
