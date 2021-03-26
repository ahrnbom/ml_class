
clearvars
close all

load A1_data.mat

lambda_min = 0.0001;
lambda_max = max(abs(X'*t));
N_lambdas = 64;
lambdas = exp(linspace( log(lambda_min), log(lambda_max), N_lambdas));
K = 5;
[wopt, lambda, RMSE_val,RMSE_est] = lasso_cv(t, X, lambdas, K);

figure('Renderer', 'painters', 'Position', [100 10 900 600])
semilogx(lambdas, RMSE_val, 'o-');
hold on 
semilogx(lambdas, RMSE_est, 'x-');

ma = max([RMSE_val, RMSE_est]);
mi = min([RMSE_val, RMSE_est]);
semilogx([lambda, lambda], [mi, ma], '--');

legend({'RMSE_{val}', 'RMSE_{est}', 'Chosen \lambda'},...
    'Orientation', 'horizontal', 'Location', 'southoutside');
xlabel('\lambda')

figure('Renderer', 'painters', 'Position', [100 10 800 600])
plot(n, t, 'go');
hold on 

w = lasso_ccd(t, X, lambda);
y = X*w;
plot(n, y, 'rx')

yinterp = Xinterp*w;
plot(ninterp, yinterp, '-', 'Color', [0.9,0.6,0]);

xlabel('time (n)')
legend({'Original points', 'Reconstructed points', 'Reconstructed curve'}', ...
    'Orientation', 'Vertical', 'Location', 'Southoutside');
title(['Reconstruction with \lambda = ' num2str(lambda)])

% Count number of zeros in w, compare with "optimal"/"true" number (4)
nwnz = sum(abs(w)>0);
disp(['lambda = ' num2str(lambda) ', number of non-zero w-values: ' num2str(nwnz)])
