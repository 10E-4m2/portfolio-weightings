getReturns <- function(symbol_list, date_from, date_to){
  # takes list of ticker symbols (maybe ending with a benchmark ETF or index)
  # uses quantmod to pull weekly stock return data for each of those tickers
  # creates an XTS object containing return data for all tickers
  # sets column names of this XTS matrix to the relevant ticker symbols
  # returns this object
  
  # load data
  d = length(symbol_list)
  for(i in 1:d){
    getSymbols(symbol_list[i], from = date_from, to = date_to)
  }
  if(symbol_list[d] == "^GSPC"){symbol_list[d] = "GSPC"} ## Change ^GSPC to GSPC
  
  # Calculate returns
  rt = weeklyReturn(Ad(get(symbol_list[1])), type = "arithmetic")[-1]
  for(i in 2:d){
    rt = cbind(rt,weeklyReturn(Ad(get(symbol_list[i])), type = "arithmetic")[-1])
    Sys.sleep(0.3)
  }
  colnames(rt) = symbol_list
  
  return(rt)
  
}

getTreynorInputs <- function(rt_mat, rf){
  # input 1: matrix of asset returns, with the last column being a benchmark
  # input 2: series of returns from risk free asset
  # then calculates the beta and risk premium for each asset
  
  
  # number equities (number of columns-1, since benchmark excluded)
  num_equity = dim(rt_mat)[2]-1
  
  # initialize vectors
  beta_calc = rep(1,num_equity)
  risk_prem = rep(1,num_equity)
  
  # calculate vectors
  for(i in 1:num_equity){
    beta_calc[i] = cov(rt_mat[,i],rt_mat[,num_equity+1])/var(rt_mat[,num_equity+1])
    risk_prem[i] = mean(rt_mat[,i])-mean(rf)
  }
  
  out_Treynor = cbind(beta_calc, risk_prem)
  colnames(out_Treynor) = c("beta_calc", "risk_prem")
  
  return(out_Treynor)
  
}

getTreynorRatios <- function(beta, risk_prem, mark_risk_prem, k=1){
  # input 1: vector of betas
  # input 2: vector of risk premiums
  # input 3: risk premium for benchmark asset (for which beta defined as 1)
  # input 4: optional, used to scale amount that Treynor ratio affects weights
  # calculates Treynor ratio for each asset
  # calculates a truncated Treynor ratio for each asset (require non negative)
  # calculates weights (for asset within benchmark)
      # e.g. sector weight within portfolio = sector ETF within total market
      # e.g. asset weight within sector
  
  treynor_ratio = as.array(risk_prem/(beta_calc*mark_risk_prem))
  treynor_ratio_truncated = apply(treynor_ratio, MARGIN = 1, FUN = function(x) ifelse(is.na(x) == TRUE, 0.1, ifelse(x>0, x, 0.1))) # cap at lower bound
  # k is optional parameter which scales emphasis on each sector up/down (>1 overweights those with positive Treynor ratios)
  treynor_ratio_weights = (treynor_ratio_truncated[treynor_ratio_truncated>0]^k)/sum(treynor_ratio_truncated[treynor_ratio_truncated>0]^k)
  
  out_Treynor = cbind(treynor_ratio, treynor_ratio_truncated, treynor_ratio_weights)
  return(out_Treynor)
  
}

getValues <- function(symbol_list, date_from, date_to){
  # takes list of ticker symbols (maybe ending with a benchmark ETF or index)
  # uses quantmod to pull weekly stock return data for each of those tickers
  # creates an XTS object containing adjusted closing price for all tickers
  # sets column names of this XTS matrix to the relevant ticker symbols
  # returns this object
  
  # load data
  d = length(symbol_list)
  for(i in 1:d){
    getSymbols(symbol_list[i], from = date_from, to = date_to)
  }
  if(symbol_list[d] == "^GSPC"){symbol_list[d] = "GSPC"} ## Change ^GSPC to GSPC
  
  # Calculate returns
  val = Ad(get(symbol_list[1]))[-1]
  for(i in 2:d){
    val = cbind(val,Ad(get(symbol_list[i]))[-1])
    Sys.sleep(0.3)
  }
  colnames(val) = symbol_list
  
  return(val)
  
}