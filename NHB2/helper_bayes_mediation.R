# ==============================================================================
# Function to compute output from a Bayesian mediation analysis with 
# multiple predictors
# ==============================================================================

#' Function to allocate participants to groups
#' @param model A fitted brms model object for the mediation
#' @param abpaths A matrix object specifying the paths (a and b are columns)
#' @param directpath A character vector specifying the direct path name
#' @param ... Other arguments passed to

reportbayesmediation <- function(model, abpaths, directpath, ...){
  
  # Initiate results object
  results <- data.frame("a" = abpaths[,1],
                        "b" = abpaths[,2])
  # Extract samples
  samples <- as_draws_array(model)
  
  # Compute indirect effects from samples
  indirect <- array(NA, dim = c(dim(samples)[1:2], nrow(abpaths)))
  for(i in 1:nrow(abpaths)){
    indirect[,,i] <- samples[,,paste0("b_", abpaths[i,1])]*samples[,,paste0("b_", abpaths[i,2])]
  }
  
  results$estimate <- apply(indirect, 3, mean)
  results$CI_lower <- apply(indirect, 3, function(x) quantile(x, probs = 0.025))
  results$CI_upper <- apply(indirect, 3, function(x) quantile(x, probs = 0.975))
  results$CI_lower90 <- apply(indirect, 3, function(x) quantile(x, probs = 0.05))
  results$CI_upper90 <- apply(indirect, 3, function(x) quantile(x, probs = 0.95))
  results$postProb <- apply(indirect, 3, function(x) sum(x > 0.1)/prod(dim(indirect)[1:2]))
  
  height_posterior <- apply(indirect, 3, function(x) dlogspline(0, logspline(x)))
  height_prior <- rep(dlogspline(0, logspline(rnorm(prod(dim(samples)[1:2]),0,0.5))), nrow(abpaths))
  results$bf10 <- height_prior/height_posterior

  # Compute other effects
  otherEffects <- array(0, dim = c(dim(samples)[1:2], 4+nrow(abpaths)))
  
    # Compute total indirect effect
    for(i in 1:nrow(abpaths)) otherEffects[,,1] <- otherEffects[,,1] + indirect[,,i]
    
    # Extract direct effect
    otherEffects[,,2] <- samples[,,paste0("b_", directpath)]
    
    # Compute total effect
    otherEffects[,,3] <- otherEffects[,,1] + otherEffects[,,2]
    
    # Calculate proportion mediated by all mediators (sum(all ab)/total)
    otherEffects[,,4] <- otherEffects[,,1]/otherEffects[,,3]
    
    # Calculate proportion mediated by individual mediators (ab/total)
    for(i in seq(5, nrow(abpaths)+4)) otherEffects[,,i] <- indirect[,,i-4]/otherEffects[,,3]
    results$propMediated <- apply(otherEffects[,,5:dim(otherEffects)[3]], 3, mean)
  
  # Summarize other effects
    results2 <- data.frame("effect" = c("Total indirect", "Direct", "Total", "Proportion Mediated"),
                           "estimate" = rep(NA, 4),
                           "CI_lower" = rep(NA, 4),
                           "CI_upper" = rep(NA, 4),
                           "CI_lower90" = rep(NA, 4),
                           "CI_upper90" = rep(NA, 4),
                           "postProb" = rep(NA, 4))
    
    results2$estimate <- apply(otherEffects[,,1:4], 3, mean)
    results2$CI_lower <- apply(otherEffects[,,1:4], 3, function(x) quantile(x, probs = 0.025))
    results2$CI_upper <- apply(otherEffects[,,1:4], 3, function(x) quantile(x, probs = 0.975))
    results2$CI_lower90 <- apply(otherEffects[,,1:4], 3, function(x) quantile(x, probs = 0.05))
    results2$CI_upper90 <- apply(otherEffects[,,1:4], 3, function(x) quantile(x, probs = 0.95))
    results2$postProb <- apply(otherEffects[,,1:4], 3, function(x) sum(x > 0.1)/prod(dim(otherEffects)[1:2]))
    
    # Round results
    results[, 3:ncol(results)] <- round(results[, 3:ncol(results)], 3)
    results2[, 2:7] <- round(results2[, 2:7], 3)
    
    return(list("Indirect Effects" = results, "Global Mediation Effects" = results2))
  
}
