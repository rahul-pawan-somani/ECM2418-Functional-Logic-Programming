main
	: - generator3 (X), selector3 (X), write (X).

generator3 ([AS, BS])
	: - permutation ([1, 2, 3, 4, 5, 6, 7, 8, 9] ,XS),
		splits (XS, AS, BS) .

splits (XS, AS, BS)
	: - length (XS, N) ,
		N1 is N - 1 ,
		between (1, N1, I) ,
		splitAt (I, XS, AS, BS) .

splitAt (_, [], [], []) .
splitAt (0, XS, [], XS ) .
splitAt (N, [ X | XS ], [ X | V ], W )
	: - N > 0,
		N1 is N - 1,
		splitAt (N1, XS, V, W) .

selector3 ([AS, BS])
	: - number (AS, A),
		number (BS, B),
		T is A * B,
		digits (T, TS),
		palindrome (TS) ,
		starts4 (TS),
		M is min (A, B),
		digits (M, MS),
		ends3 (MS),
		U is A + B + 100,
		digits (U, US ),
		palindrome (US).

number (XS, N)
	: - reverse (XS, YS),
		numberLoop (YS, N) .

numberLoop ([] , 0) .
numberLoop ([ X | XS ] , W )
	: - numberLoop ( XS , V ) ,
		W is X + 10 * V .

digits (N , [ N ])
	: - N < 10.
digits (N , W )
	: - N >= 10 ,
		divMod (N, 10, D,M),
		digits (D, R),
		append (R, [M], W).

divMod (A, B, D, M)
	: - D is A div B,
		M is A mod B.

palindrome (XS)
	: - reverse (XS, XS).

ends3 (XS)
	: - last (XS, 3).

starts4 ([4| _ ]).