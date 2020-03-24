my_data_raw = read.csv("data/Data_29Jan2019.csv", header = TRUE)

dim(my_data_raw)

head(my_data_raw)

tail(my_data_raw)

vec_price_close_row = rev(my_data_raw$Adj.Close)

plot(vec_price_close_row, type = "l" , col = "blue")

num_start = 3500
nb_sample_train = 600
nb_sample_test = 10

num_last_train = num_start + nb_sample_train - 1

num_start_test = num_last_train + 1

num_last_test = num_start_test + nb_sample_test - 1


vec_price_all = vec_price_close_row[num_start:num_last_test]
plot( vec_price_all, type ="l" , col = "red")

vec_price_train = vec_price_close_row[num_start:num_last_train]
plot( vec_price_train,type ="l", col = "purple")

vec_price_test = vec_price_close_row[num_start_test:num_last_test]
plot( vec_price_test,type ="l", col = "pink")


# fin du cours 1

vec_price_close_raw[num_start_test:num_last_test]

plot(vec_price_test,col='red')



#calcul des rendements
vec_return_train = (vec_price_train[2:nb_sample_train]/vec_price_train[1:(nb_sample_train-1)]) -1

plot(vec_return_train,col="purple")
abline(h=mean(vec_return_train),col='red')
summary(vec_return_train)

spot_pres = vec_price_train[nb_sample_train]

spot_next_actual = vec_price_test[1]

vec_spot_next_scen = spot_pres*(1+vec_return_train)

plot(vec_spot_next_scen)

hist(vec_spot_next_scen)
abline(v=spot_pres)
abline(v = spot_pres)
abline(v= spot_next_actual)


spot_pred_prod_unif = mean(vec_spot_next_scen)
spot_pred_prod_unif

err_abs_prob_unif = abs(spot_next_actual-spot_pred_prod_unif)
err_abs_prob_unif

err_rel_prob_unif = err_abs_prob_unif/spot_pres
err_rel_prob_unif

err_rel_prob_unif_perc = 100* err_rel_prob_unif
err_rel_prob_unif_perc

#fin 



len_window = 4

spot_MA = mean(vec_price_train[(nb_sample_train-len_window):nb_sample_train])
spot_ref = spot_MA

vec_dist_spot_scen_to_spot_ref = abs(vec_spot_next_scen - spot_ref)

plot(vec_dist_spot_scen_to_spot_ref)

vec_prob_ref = exp(-vec_dist_spot_scen_to_spot_ref)/sum(exp(-vec_dist_spot_scen_to_spot_ref))

sum(vec_prob_ref)

hist(vec_prob_ref)

plot(vec_prob_ref)

spot_pred_prob_ref=sum(vec_spot_next_scen*vec_prob_ref)

var_spot_pred_prob_ref = sum((vec_spot_next_scen - spot_pred_prob_ref)^2*vec_prob_ref)/spot_pres^2

std_spot_pred_prob_ref = sqrt(var_spot_pred_prob_ref)

err_abs_prob_ref = abs(spot_next_actual-spot_pred_prob_ref)

err_rel_prob_ref = err_abs_prob_ref/spot_pres

err_rel_prob_ref_perc = 100* err_rel_prob_ref

std_spot_pred_prob_ref_perc = 100* std_spot_pred_prob_ref

########################################################################@


result = rbind(spot_pres,
               sport_next_actual,
               len_window,
               spot_pred_prod_unif,
               spot_pred_prob_ref,
               err_rel_prob_unif_perc,
               err_rel_prob_ref_perc,
               std_spot_pred_prob_ref_perc)

print(result)

########################################################################@########################################################################@

nb_len_window_max = 30

vec_err_rel_prob_ref_perc = rep(NA,nb_len_window_max)

vec_std_spot_pred_prob_ref_perc = rep(NA,nb_len_window_max)

for( l in 1:nb_len_window_max)
{
  len_window = l
  spot_MA = mean(vec_price_train[(nb_sample_train - len_window): nb_sample_train])
  
  spot_ref = spot_MA
  
  vec_dist_spot_scen_to_spot_ref = abs(vec_spot_next_scen - spot_ref)
  
  vec_prob_ref = exp(-vec_dist_spot_scen_to_spot_ref)/sum(exp(-vec_dist_spot_scen_to_spot_ref))
  
  spot_pred_prob_ref = sum(vec_spot_next_scen * vec_prob_ref)
  
  err_abs_prob_ref = abs(spot_next_actual-spot_pred_prob_ref)
  err_rel_prob_ref = err_abs_prob_ref/spot_pres
  err_rel_prob_ref_perc = 100* err_rel_prob_ref
  
  vec_err_rel_prob_ref_perc[l] = err_rel_prob_ref_perc
  
  var_spot_pred_prob_ref = sum((vec_spot_next_scen - spot_pred_prob_ref)^2*vec_prob_ref)/spot_pres^2
  
  std_spot_pred_prob_ref = sqrt(var_spot_pred_prob_ref)
  
  std_spot_pred_prob_ref_perc = 100* std_spot_pred_prob_ref
  
  vec_std_spot_pred_prob_ref_perc[l] = std_spot_pred_prob_ref_perc
  
}


plot(
  vec_err_rel_prob_ref_perc,
  type="l",
  col="purple",
  lwd = 2,
  xlab = "len-window",
  main="error ex post"
)

plot(
  vec_std_spot_pred_prob_ref_perc,
  type="l",
  col="purple",
  lwd = 2,
  xlab = "len-window",
  main="error ante post"
)


matplot(
  cbind(vec_err_rel_prob_ref_perc,
        vec_std_spot_pred_prob_ref_perc),
  type = "l",
  col = c("purple","blue"),
  lwd = 2,
  main = "errors ex post and ex ante"
)


####################################################################################################################################################################################


vec_price_train_MA = rep(NA,length(vec_price_train))

for(k in 1:length(vec_price_train_MA))
{
  
  vec_price_train_MA[k] = mean(vec_price_all[k:k+(len_window-1)])
  
}

the_two_price = cbind(vec_price_train,vec_price_train_MA)

matplot(
  the_two_price,
  type = "l",
  col = c("blue","red")
  
)







