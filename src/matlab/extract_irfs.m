% -------------------------------------------------------------------------
% extract_irfs.m: prepares impulse response series
% -------------------------------------------------------------------------
% authors:         Rohan Kekre and Moritz Lenel
% for updates see: https://github.com/KekreLenel/MPR
% -------------------------------------------------------------------------
function [irf_data, irf_idxs, irf_titles] = extract_irfs(irf_series, prms)

temp_series = irf_series;
extract_series;

irf_data = zeros(198,14);
irf_data(:,1)   = 10000*(treas_1y_series(3:200)-treas_1y_series(1));    irf_idxs.t1y   = 1 ;  irf_titles{1}  ="$i_{1y}$";
irf_data(:,2)   = 10000*(E_rf_series(3:200)-E_rf_series(1));            irf_idxs.Er   = 2 ;  irf_titles{2}  = "$E[r]$";          
irf_data(:,3)   = 10000*(E_excA_series(3:200)-E_excA_series(1));        irf_idxs.Eexc = 3 ;  irf_titles{3}  = "$E[r^e-r]$";      
irf_data(:,4)   = 10000*(exc_retA_series(3:200)-exc_retA_series(1));    irf_idxs.exc  = 4 ;  irf_titles{4}  = "$r^e-r$";        
irf_data(:,5)   = 10000*(s_a_series(3:200)-s_a_series(1));          irf_idxs.sa   = 5 ;  irf_titles{5}  = "$s^a$";           
irf_data(:,6)   = 10000*(log(infl_series(3:200))-log(infl_series(1)));  irf_idxs.infl = 6 ;  irf_titles{6}  = "$\log(P/P_{-1})$"; 
irf_data(:,7)   = 10000*(logq_series(3:200)-logq_series(1));            irf_idxs.q    = 7 ;  irf_titles{7}  = "$\log(q)$";        
irf_data(:,8)   = 10000*(logw_series(3:200)-logw_series(1));            irf_idxs.w    = 8 ;  irf_titles{8}  = "$\log(w)$";        
irf_data(:,9)   = 10000*(logl_series(3:200)-logl_series(1));            irf_idxs.l    = 9 ;  irf_titles{9}  = "$\log(l)$";        
irf_data(:,10)  = 10000*(loginv_series(3:200)-loginv_series(1));        irf_idxs.x    = 10;  irf_titles{10} = "$\log(x)$";        
irf_data(:,11)  = 10000*(logc_series(3:200)-logc_series(1));            irf_idxs.c    = 11;  irf_titles{11} = "$\log(c)$";        
irf_data(:,12)  = 10000*(logy_series(3:200)-logy_series(1));            irf_idxs.y    = 12;  irf_titles{12} = "$\log(y)$";        
irf_data(:,13)  = 10000*(nom_i_series(3:200)-nom_i_series(1));          irf_idxs.i    = 13;  irf_titles{13} = "$i$";             

end
