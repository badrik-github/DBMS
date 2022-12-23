# How loans are calculated

Loans are of two type **Fixed** rate loan and **Floating** rate loan. The interest rate are fixed for the complete tenure of loan and loan pre payment charges are applied on the loan amount if loan is pre paid before the completion period. While as floating rate loan the interest rate is not fixed it varies based on the market condition and no loan pre payment charges are applied.

## Interest calculation

### How to calculate the monthly EMI for a loan.<br/>

A = Periodic EMI amount<br/>
P = Principal borrowed<br/>
r = Periodic interest rate (annual interest rate/12)<br/>
n = Total number of payment (number of months during the loan tenure)<br/>

$A = P * (r(1+r)^n/(1+r)^n-1)$
<br/>

### How the EMI is split into interest and the base amount.

Let's take a scenario where the loan is take for **p = 100,000**, **Annual interest = 6%**, **P = 0.5**, **n = (12*3)**. Based on this provided values and using the above mentioned formula we come to an EMI of **3,042** every month for 3 years.<br/>

Interest per month = Remaining base amount * P<br/>
**Interest per month = (100,000 * 0.5%) = 500**<br/>

So form the EMI of value **3,042$** which is paid for the one month, **500$** will be the interest and remaining will be deducted from the base amount after this EMI the complete picture will be like this.<br/>

**Remaining loan amount = 100,000 - (3,042-500) = 97,458**<br/>
**Interest Collected till date = 500$**<br/>
**Principal payment made till date = 2,542$**<br/>


## Below table represents the complete example and the calculation of the loan.

| No. | Principal Amount(Starting balance) | Interest Amount | Principal Repayment | EMI | Principal Amount(Ending balance)|
| :--: | :--:    | :--: | :--:   | :--:  | :--:   |
|1     | 100,000 |	500 |	2,542| 	3,042|	97,458|
|2     |  97,458 |  487 |  	2,555|	3,042|	94,903|
|3     |  94,903 |  475 |  	2,568|	3,042|	92,335|
|4     |  92,335 |  462 |  	2,581|	3,042|	89,755|
|5     |  89,755 |  449 |  	2,593|	3,042|	87,161|
|6     |  87,161 |  436 |  	2,606|	3,042|	84,555|
|7     |  84,555 |  423 |  	2,619|	3,042|	81,935|
|8     |  81,935 |  410 |  	2,633|	3,042|	79,303|
|9     |  79,303 |  397 |  	2,646|	3,042|	76,657|
|10    |  76,657 |  383 |  	2,659|	3,042|	73,998|
|11    |  73,998 |  370 |  	2,672|	3,042|	71,326|
|12    |  71,326 |  357 |  	2,686|	3,042|	68,641|
|13    |  68,641 |  343 |  	2,699|	3,042|	65,942|
|14    |  65,942 |  330 |  	2,712|	3,042|	63,229|
|15    |  63,229 |  316 |  	2,726|	3,042|	60,503|
|16    |  60,503 |  303 |  	2,740|	3,042|	57,763|
|17    |  57,763 |  289 |  	2,753|	3,042|	55,010|
|18    |  55,010 |  275 |  	2,767|	3,042|	52,243|
|19    |  52,243 |  261 |  	2,781|	3,042|	49,462|
|20    |  49,462 |  247 |  	2,795|	3,042|	46,667|
|21    |  46,667 |  233 |  	2,809|	3,042|	43,858|
|22    |  43,858 |  219 |  	2,823|	3,042|	41,035|
|23    |  41,035 |  205 |  	2,837|	3,042|	38,198|
|24    |  38,198 |  191 |  	2,851|	3,042|	35,347|
|25    |  35,347 |  177 |  	2,865|	3,042|	32,482|
|26    |  32,482 |  162 |  	2,880|	3,042|	29,602|
|27    |  29,602 |  148 |  	2,894|	3,042|	26,708|
|28    |  26,708 |  134 |  	2,909|	3,042|	23,799|
|29    |  23,799 |  119 |  	2,923|	3,042|	20,876|
|30    |  20,876 |  104 |  	2,938|	3,042|	17,938|
|31    |  17,938 |  90	|   2,953|	3,042|	14,985|
|32    |  14,985 |  75	|   2,967|	3,042|	12,018|
|33    |  12.018 |  60	|   2,982|	3,042|	 9,036|
|34    |  9,036	 |  45	|   2,997|	3,042|	 6,039|
|35    |  6,039	 |  30	|   3,012|	3,042|	 3,027|
|36    |  3,027	 |  15	|   3,027|	3,042|	    0 |
