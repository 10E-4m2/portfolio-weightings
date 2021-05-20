# CAPM Portfolio Balancing

The CAPM portfolio balancing tool attempts to create a portfolio 
weighting scheme in two steps: 

1) the Treynor ratios of sector ETFs (benchmarked against total market and risk free asset) are used to assign portfolio sector weightings
2) the Treynor ratios of individual assets (benchmarked against sector ETF and risk free asset) are used to determine asset weightings within the sector's share of the portfolio

## Installation

Then included .Rmd workbook contains all code required to run the tool and includes explicit install commands for all required R packages

## Support

I can be reached at calvin.m.miller@gmail.com

## Roadmap

In the future, I intend to add a Python implementation of the same code

Future work efforts may also seek to:
1) automate generation of list of potential assets and their sector assignments
2) allow for more substantial testing by assessing Treynor ratios for periods starting earlier (e.g. maybe 2010 and forward)
3) if defining portfolio weights starting from an earlier period, develop more comprehensive test metrics (fit portfolio with returns from 2013, compare portfolio's performance for 2014 to market performance, repeat for 2014 data informing portfolio to be used for 2015, etc.)
4) if testing becomes more mature, allow for optimization of parameter used to scale Treynor ratios (TR**k, where k=1 by default; can weight training period's performance more/less highly) as well as optimization of stock screening criteria
5) explore whether Treynor ratios from simple CAPM are more/less effective than Treynor ratios from a factor model (e.g. Fama-French 3 factor model)

## License
[MIT](https://choosealicense.com/licenses/mit/)
