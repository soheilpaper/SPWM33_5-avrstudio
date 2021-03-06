//-----------------------------------------------------------------------------
// Copyright:      www.KnowledgePlus.ir
// Author:         OZHAN KD modified by Sh. Nourbakhsh Rad
// Remarks:        
// known Problems: none
// Version:        1.0.0
// Description:    Timer value Table ...
//-----------------------------------------------------------------------------

#ifndef _TIMERVAL_TBL_H_
	#define _TIMERVAL_TBL_H_

	/********************************************/
	/* 	CPU Frq. :										8000000		*/
	/* 	Timer Prescaler : 						1					*/
	/* 	SIN Points (resolution): 			256				*/
	/* 	Timer OVF Frq.  x10 : 				312500		*/
	/********************************************/
	
	PROGMEM unsigned int Timer_Value[997] = {
			0,	//dummy value for speed=1
			
			62500 ,	52083 ,	44643 ,	39063 ,	34722 ,	31250 ,	28409 ,	26042 ,	24038 ,	22321 ,
			20833 ,	19531 ,	18382 ,	17361 ,	16447 ,	15625 ,	14881 ,	14205 ,	13587 ,	13021 ,
			12500 ,	12019 ,	11574 ,	11161 ,	10776 ,	10417 ,	10081 ,	9766 	,	9470 	,	9191 	,
			8929 	,	8681 	,	8446 	,	8224 	,	8013 	,	7813 	,	7622 	,	7440 	,	7267 	,	7102 	,
			6944 	,	6793 	,	6649 	,	6510 	,	6378 	,	6250 	,	6127 	,	6010 	,	5896 	,	5787 	,
			5682 	,	5580 	,	5482 	,	5388 	,	5297 	,	5208 	,	5123 	,	5040 	,	4960 	,	4883 	,
			4808 	,	4735 	,	4664 	,	4596 	,	4529 	,	4464 	,	4401 	,	4340 	,	4281 	,	4223 	,
			4167 	,	4112 	,	4058 	,	4006 	,	3956 	,	3906 	,	3858 	,	3811 	,	3765 	,	3720 	,
			3676 	,	3634 	,	3592 	,	3551 	,	3511 	,	3472 	,	3434 	,	3397 	,	3360 	,	3324 	,
			3289 	,	3255 	,	3222 	,	3189 	,	3157 	,	3125 	,	3094 	,	3064 	,	3034 	,	3005 	,
			2976 	,	2948 	,	2921 	,	2894 	,	2867 	,	2841 	,	2815 	,	2790 	,	2765 	,	2741 	,
			2717 	,	2694 	,	2671 	,	2648 	,	2626 	,	2604 	,	2583 	,	2561 	,	2541 	,	2520 	,
			2500 	,	2480 	,	2461 	,	2441 	,	2422 	,	2404 	,	2385 	,	2367 	,	2350 	,	2332 	,
			2315 	,	2298 	,	2281 	,	2264 	,	2248 	,	2232 	,	2216 	,	2201 	,	2185 	,	2170 	,
			2155 	,	2140 	,	2126 	,	2111 	,	2097 	,	2083 	,	2070 	,	2056 	,	2042 	,	2029 	,
			2016 	,	2003 	,	1990 	,	1978 	,	1965 	,	1953 	,	1941 	,	1929 	,	1917 	,	1905 	,
			1894 	,	1883 	,	1871 	,	1860 	,	1849 	,	1838 	,	1827 	,	1817 	,	1806 	,	1796 	,
			1786 	,	1776 	,	1766 	,	1756 	,	1746 	,	1736 	,	1727 	,	1717 	,	1708 	,	1698 	,
			1689 	,	1680 	,	1671 	,	1662 	,	1653 	,	1645 	,	1636 	,	1628 	,	1619 	,	1611 	,
			1603 	,	1594 	,	1586 	,	1578 	,	1570 	,	3125 	,	3109 	,	3094 	,	3079 	,	3064 	,
			3049 	,	3034 	,	3019 	,	3005 	,	2990 	,	2976 	,	2962 	,	2948 	,	2934 	,	2921 	,
			2907 	,	2894 	,	2880 	,	2867 	,	2854 	,	2841 	,	2828 	,	2815 	,	2803 	,	2790 	,
			2778 	,	2765 	,	2753 	,	2741 	,	2729 	,	2717 	,	2706 	,	2694 	,	2682 	,	2671 	,
			2660 	,	2648 	,	2637 	,	2626 	,	2615 	,	2604 	,	2593 	,	2583 	,	2572 	,	2561 	,
			2551 	,	2541 	,	2530 	,	2520 	,	2510 	,	2500 	,	2490 	,	2480 	,	2470 	,	2461 	,
			2451 	,	2441 	,	2432 	,	2422 	,	2413 	,	2404 	,	2395 	,	2385 	,	2376 	,	2367 	,
			2358 	,	2350 	,	2341 	,	2332 	,	2323 	,	2315 	,	2306 	,	2298 	,	2289 	,	2281 	,
			2273 	,	2264 	,	2256 	,	2248 	,	2240 	,	2232 	,	2224 	,	2216 	,	2208 	,	2201 	,
			2193 	,	2185 	,	2178 	,	2170 	,	2163 	,	2155 	,	2148 	,	2140 	,	2133 	,	2126 	,
			2119 	,	2111 	,	2104 	,	2097 	,	2090 	,	2083 	,	2076 	,	2070 	,	2063 	,	2056 	,
			2049 	,	2042 	,	2036 	,	2029 	,	2023 	,	2016 	,	2010 	,	2003 	,	1997 	,	1990 	,
			1984 	,	1978 	,	1972 	,	1965 	,	1959 	,	1953 	,	1947 	,	1941 	,	1935 	,	1929 	,
			1923 	,	1917 	,	1911 	,	1905 	,	1900 	,	1894 	,	1888 	,	1883 	,	1877 	,	1871 	,
			1866 	,	1860 	,	1855 	,	1849 	,	1844 	,	1838 	,	1833 	,	1827 	,	1822 	,	1817 	,
			1812 	,	1806 	,	1801 	,	1796 	,	1791 	,	1786 	,	1781 	,	1776 	,	1771 	,	1766 	,
			1761 	,	1756 	,	1751 	,	1746 	,	1741 	,	1736 	,	1731 	,	1727 	,	1722 	,	1717 	,
			1712 	,	1708 	,	1703 	,	1698 	,	1694 	,	1689 	,	1685 	,	1680 	,	1676 	,	1671 	,
			1667 	,	1662 	,	1658 	,	1653 	,	1649 	,	1645 	,	1640 	,	1636 	,	1632 	,	1628 	,
			1623 	,	1619 	,	1615 	,	1611 	,	1607 	,	1603 	,	1598 	,	1594 	,	1590 	,	1586 	,
			1582 	,	1578 	,	1574 	,	1570 	,	1566 	,	3125 	,	3117 	,	3109 	,	3102 	,	3094 	,
			3086 	,	3079 	,	3071 	,	3064 	,	3056 	,	3049 	,	3041 	,	3034 	,	3027 	,	3019 	,
			3012 	,	3005 	,	2998 	,	2990 	,	2983 	,	2976 	,	2969 	,	2962 	,	2955 	,	2948 	,
			2941 	,	2934 	,	2927 	,	2921 	,	2914 	,	2907 	,	2900 	,	2894 	,	2887 	,	2880 	,
			2874 	,	2867 	,	2860 	,	2854 	,	2847 	,	2841 	,	2834 	,	2828 	,	2822 	,	2815 	,
			2809 	,	2803 	,	2796 	,	2790 	,	2784 	,	2778 	,	2772 	,	2765 	,	2759 	,	2753 	,
			2747 	,	2741 	,	2735 	,	2729 	,	2723 	,	2717 	,	2711 	,	2706 	,	2700 	,	2694 	,
			2688 	,	2682 	,	2677 	,	2671 	,	2665 	,	2660 	,	2654 	,	2648 	,	2643 	,	2637 	,
			2632 	,	2626 	,	2621 	,	2615 	,	2610 	,	2604 	,	2599 	,	2593 	,	2588 	,	2583 	,
			2577 	,	2572 	,	2567 	,	2561 	,	2556 	,	2551 	,	2546 	,	2541 	,	2535 	,	2530 	,
			2525 	,	2520 	,	2515 	,	2510 	,	2505 	,	2500 	,	2495 	,	2490 	,	2485 	,	2480 	,
			2475 	,	2470 	,	2465 	,	2461 	,	2456 	,	2451 	,	2446 	,	2441 	,	2437 	,	2432 	,
			2427 	,	2422 	,	2418 	,	2413 	,	2408 	,	2404 	,	2399 	,	2395 	,	2390 	,	2385 	,
			2381 	,	2376 	,	2372 	,	2367 	,	2363 	,	2358 	,	2354 	,	2350 	,	2345 	,	2341 	,
			2336 	,	2332 	,	2328 	,	2323 	,	2319 	,	2315 	,	2311 	,	2306 	,	2302 	,	2298 	,
			2294 	,	2289 	,	2285 	,	2281 	,	2277 	,	2273 	,	2269 	,	2264 	,	2260 	,	2256 	,
			2252 	,	2248 	,	2244 	,	2240 	,	2236 	,	2232 	,	2228 	,	2224 	,	2220 	,	2216 	,
			2212 	,	2208 	,	2205 	,	2201 	,	2197 	,	2193 	,	2189 	,	2185 	,	2182 	,	2178 	,
			2174 	,	2170 	,	2166 	,	2163 	,	2159 	,	2155 	,	2151 	,	2148 	,	2144 	,	2140 	,
			2137 	,	2133 	,	2129 	,	2126 	,	2122 	,	2119 	,	2115 	,	2111 	,	2108 	,	2104 	,
			2101 	,	2097 	,	2094 	,	2090 	,	2087 	,	4167 	,	4160 	,	4153 	,	4146 	,	4139 	,
			4132 	,	4125 	,	4119 	,	4112 	,	4105 	,	4098 	,	4092 	,	4085 	,	4078 	,	4072 	,
			4065 	,	4058 	,	4052 	,	4045 	,	4039 	,	4032 	,	4026 	,	4019 	,	4013 	,	4006 	,
			4000 	,	3994 	,	3987 	,	3981 	,	3975 	,	3968 	,	3962 	,	3956 	,	3949 	,	3943 	,
			3937 	,	3931 	,	3925 	,	3918 	,	3912 	,	3906 	,	3900 	,	3894 	,	3888 	,	3882 	,
			3876 	,	3870 	,	3864 	,	3858 	,	3852 	,	3846 	,	3840 	,	3834 	,	3828 	,	3823 	,
			3817 	,	3811 	,	3805 	,	3799 	,	3794 	,	3788 	,	3782 	,	3776 	,	3771 	,	3765 	,
			3759 	,	3754 	,	3748 	,	3743 	,	3737 	,	3731 	,	3726 	,	3720 	,	3715 	,	3709 	,
			3704 	,	3698 	,	3693 	,	3687 	,	3682 	,	3676 	,	3671 	,	3666 	,	3660 	,	3655 	,
			3650 	,	3644 	,	3639 	,	3634 	,	3628 	,	3623 	,	3618 	,	3613 	,	3608 	,	3602 	,
			3597 	,	3592 	,	3587 	,	3582 	,	3577 	,	3571 	,	3566 	,	3561 	,	3556 	,	3551 	,
			3546 	,	3541 	,	3536 	,	3531 	,	3526 	,	3521 	,	3516 	,	3511 	,	3506 	,	3501 	,
			3497 	,	3492 	,	3487 	,	3482 	,	3477 	,	3472 	,	3467 	,	3463 	,	3458 	,	3453 	,
			3448 	,	3444 	,	3439 	,	3434 	,	3429 	,	3425 	,	3420 	,	3415 	,	3411 	,	3406 	,
			3401 	,	3397 	,	3392 	,	3388 	,	3383 	,	3378 	,	3374 	,	3369 	,	3365 	,	3360 	,
			3356 	,	3351 	,	3347 	,	3342 	,	3338 	,	3333 	,	3329 	,	3324 	,	3320 	,	3316 	,
			3311 	,	3307 	,	3303 	,	3298 	,	3294 	,	3289 	,	3285 	,	3281 	,	3277 	,	3272 	,
			3268 	,	3264 	,	3259 	,	3255 	,	3251 	,	3247 	,	3243 	,	3238 	,	3234 	,	3230 	,
			3226 	,	3222 	,	3218 	,	3213 	,	3209 	,	3205 	,	3201 	,	3197 	,	3193 	,	3189 	,
			3185 	,	3181 	,	3177 	,	3173 	,	3169 	,	3165 	,	3161 	,	3157 	,	3153 	,	3149 	,
			3145 	,	3141 	,	3137 	,	3133 	,	3129 	,	6250 	,	6242 	,	6234 	,	6227 	,	6219 	,
			6211 	,	6203 	,	6196 	,	6188 	,	6180 	,	6173 	,	6165 	,	6158 	,	6150 	,	6143 	,
			6135 	,	6127 	,	6120 	,	6112 	,	6105 	,	6098 	,	6090 	,	6083 	,	6075 	,	6068 	,
			6061 	,	6053 	,	6046 	,	6039 	,	6031 	,	6024 	,	6017 	,	6010 	,	6002 	,	5995 	,
			5988 	,	5981 	,	5974 	,	5967 	,	5959 	,	5952 	,	5945 	,	5938 	,	5931 	,	5924 	,
			5917 	,	5910 	,	5903 	,	5896 	,	5889 	,	5882 	,	5875 	,	5869 	,	5862 	,	5855 	,
			5848 	,	5841 	,	5834 	,	5828 	,	5821 	,	5814 	,	5807 	,	5800 	,	5794 	,	5787 	,
			5780 	,	5774 	,	5767 	,	5760 	,	5754 	,	5747 	,	5741 	,	5734 	,	5727 	,	5721 	,
			5714 	,	5708 	,	5701 	,	5695 	,	5688 	,	5682 	,	5675 	,	5669 	,	5663 	,	5656 	,
			5650 	,	5643 	,	5637 	,	5631 	,	5624 	,	5618 	,	5612 	,	5605 	,	5599 	,	5593 	,
			5587 	,	5580 	,	5574 	,	5568 	,	5562 	,	5556 	,	5549 	,	5543 	,	5537 	,	5531 	,
			5525 	,	5519 	,	5513 	,	5507 	,	5501 	,	5495 	,	5488 	,	5482 	,	5476 	,	5470 	,
			5464 	,	5459 	,	5453 	,	5447 	,	5441 	,	5435 	,	5429 	,	5423 	,	5417 	,	5411 	,
			5405 	,	5400 	,	5394 	,	5388 	,	5382 	,	5376 	,	5371 	,	5365 	,	5359 	,	5353 	,
			5348 	,	5342 	,	5336 	,	5330 	,	5325 	,	5319 	,	5313 	,	5308 	,	5302 	,	5297 	,
			5291 	,	5285 	,	5280 	,	5274 	,	5269 	,	5263 	,	5258 	,	5252 	,	5247 	,	5241 	,
			5236 	,	5230 	,	5225 	,	5219 	,	5214 	,	5208 	,	5203 	,	5198 	,	5192 	,	5187 	,
			5181 	,	5176 	,	5171 	,	5165 	,	5160 	,	5155 	,	5149 	,	5144 	,	5139 	,	5133 	,
			5128 	,	5123 	,	5118 	,	5112 	,	5107 	,	5102 	,	5097 	,	5092 	,	5086 	,	5081 	,
			5076 	,	5071 	,	5066 	,	5061 	,	5056 	,	5051 	,	5045 	,	5040 	,	5035 	,	5030 	,
			5025 	,	5020 	,	5015 	,	5010 	,	5005 	,	5000
			};
#else
	#error "Timer_tbl.h already included!!!"
#endif	//_TIMERVAL_TBL_H_
