#ajouter la selection du type de données entre yahoo ou my_raw_data
#' Title
#'
#' @param num_start 
#' @param nb_sample 
#' @param nb_sample_test 
#'
#' @return
#' @export
#'
#' @examples
trianing <- function(num_start, nb_sample, nb_sample_test){
  num_last_train <- num_start + nb_sample_test - 1
}

#' Title
#'
#' @param num_start 
#' @param nb_sample_train 
#' @param nb_sample_test 
#'
#' @return
#' @export
#'
#' @examples
Simu_Historique_unif <- function(num_start,nb_sample_train,nb_sample_test){
  
  num_last_train <- num_start + nb_sample_train - 1
  num_start_test <- num_last_train + 1
  num_last_test <- num_start_test + nb_sample_test - 1
  my_raw_data <- .GlobalEnv$my_raw_data
  
  if(!is.null(my_raw_data)){
    vec_price_close_row = rev(my_raw_data$"Adj Close")
 
  vec_price_all <- vec_price_close_row[num_start:num_last_test]
  vec_price_train<- vec_price_close_row[num_start:num_last_train]
  vec_price_test <- vec_price_close_row[num_start_test:num_last_test]
  vec_return_train = (vec_price_train[2:nb_sample_train]/
                        vec_price_train[1:(nb_sample_train-1)])-1
  
  spot_pres <- vec_price_train[nb_sample_train]
  spot_next_actual <- vec_price_test[1]
  vec_spot_next_scen <- spot_pres*(1+vec_return_train)

  
  spot_pred_prob_unif <- mean(vec_spot_next_scen)
  err_abs_prob_unif <- abs(spot_next_actual-spot_pred_prob_unif)
  err_rel_prob_unif <- err_abs_prob_unif/spot_pres
  err_rel_prob_unif_perc <- 100*err_rel_prob_unif
  
  #regarder ce qui est vraiment util de renvoyer 
  rslt <- list("vec_price_all"       = vec_price_all,
               "vec_price_train"     = vec_price_train,
               "vec_price_test"      = vec_price_test,
               "vec_spot_next_scen"  = vec_spot_next_scen,
               "spot_pred_prob_unif" = spot_pred_prob_unif,
               "err_abs_prob_unif"   = err_abs_prob_unif,
               "err_rel_prob_unif"   = err_rel_prob_unif)
  # names(rslt) = c("vec_price_all",
  #                 "vec_price_train",
  #                 "vec_price_test",
  #                 "vec_spot_next_scen",
  #                 "spot_pred_prob_unif",
  #                 "err_abs_prob_unif",
  #                 "err_rel_prob_unif")
  return(rslt)
  }
  
}


#' Title
#'
#' @param window 
#' @param num_start 
#' @param num_sample_train 
#' @param num_sample_test 
#'
#' @return
#' @export
#'
#' @examples
Simu_Historique_MA <- function(window,num_start,num_sample_train,num_sample_test){
  
  num_last_train <- num_start + nb_sample_train - 1
  num_start_test <- num_last_train + 1
  num_last_test <- num_start_test + nb_sample_test - 1
  
  vec_price_all <- vec_price_close_row[num_start:num_last_test]
  vec_price_train<- vec_price_close_row[num_start:num_last_train]
  vec_price_test <- vec_price_close_row[num_start_test:num_last_test]
  vec_return_train <- (vec_price_train[2:nb_sample_train]/
                         vec_price_train[1:(nb_sample_train-1)])-1
  
  spot_pres <- vec_price_train[nb_sample_train]
  spot_next_actual <- vec_price_test[1]
  vec_spot_next_scen <- spot_pres*(1+vec_return_train)
  
  
  spot_MA <- mean(vec_price_train[(nb_sample_train-len_window):nb_sample_train])
  spot_ref <- spot_MA
  vec_dist_spot_scen_to_spot_ref <- abs(vec_spot_next_scen-spot_ref)
  vec_prob_ref <- exp(-vec_dist_spot_scen_to_spot_ref)/sum(exp(-vec_dist_spot_scen_to_spot_ref))
  
  
  spot_pred_prob_ref <- sum(vec_spot_next_scen*vec_prob_ref)
  var_spot_pred_prob_ref <- sum((vec_spot_next_scen-spot_pred_prob_ref)^2*vec_prob_ref)/spot_pres^2
  std_spot_pred_prob_ref <- sqrt(var_spot_pred_prob_ref)
  
  err_abs_prob_ref <- abs(spot_next_actual-spot_pred_prob_ref)
  err_rel_prob_ref <- err_abs_prob_ref/spot_pres
  err_rel_prob_ref_prec <- 100*err_rel_prob_ref
  std_spot_pred_prob_ref_perc <- 100*std_spot_pred_prob_ref
  
  # rgarder ce que l'on a rellement besoin de renvoyer 
  rslt <- rbind(
    vec_price_all,
    vec_price_train,
    vec_price_test,
    vec_spot_next_scen,
    spot_ref,
    vec_dist_spot_scen_to_spot_ref,
    spot_pred_prob_ref
  )
}


#' Title
#'
#' @param spot_pres 
#' @param ref 
#'
#' @return
#' @export
#'
#' @examples
Err_absolu <- function(spot_pres,ref){
  return(abs(spot_pres-ref))
}

#' Title
#'
#' @param spot_pres 
#' @param ref 
#'
#' @return
#' @export
#'
#' @examples
Err_relative <- function(spot_pres,ref){
  return((spot_pres - ref)/spot_pres)
  
}


