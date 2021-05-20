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
a) automate generation of list of potential assets and their sector assignments
b) allow for more substantial testing by assessing Treynor ratios for periods starting earlier (e.g. maybe 2010 and forward)
c) if defining portfolio weights starting from an earlier period, develop more comprehensive test metrics (fit portfolio with returns from 2013, compare portfolio's performance for 2014 to market performance, repeat for 2014 data informing portfolio to be used for 2015, etc.)
d) if testing becomes more mature, allow for optimization of parameter used to scale Treynor ratios (TR**k, where k=1 by default; can weight training period's performance more/less highly) as well as optimization of stock screening criteria
