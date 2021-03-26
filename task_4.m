clearvars;
close all;
load A1_data.mat

lambda = 1.0;
[N, M] = size(X);

lambdas = [0.1, 10, 2];

for i = 1:3
    lambda = lambdas(i);
    what = lasso_ccd(t, X, lambda);

    subplot(3,1,i);
    plot(n, t, 'x');
    hold on
    plot(n, X*what, 'o');
    plot(ninterp, Xinterp*what, '-');
    xlabel('time (units unclear)');
    title(['Lambda ' num2str(lambda)]);
    legend({'Noisy points', 'Reconstructed points', 'Reconstructed interpolated function'});

    count_nonzero = sum(abs(what)>0);
    disp([lambda, count_nonzero])
end