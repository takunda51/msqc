%%
clear classes;
%root = 'c:\dave\apoly\msqc\';
load(['data\ethane\ethane2\data3.mat']);
%%
clear classes;
load('data\ethane\ethane3\data.mat');
%% set up the pca data
hold on;
dataSize = size( HL );
for ifrag = 1:dataSize( 1 )
    frag1 = HL{ifrag,1};
    nenv = frag1.nenv;
    ind = find(frag1.basisAtom == 1);
    nbasis = size(ind,1);
    X = zeros(nenv, nbasis^2);
    for ienv = 1:nenv
      den = frag1.density(ienv);
      den1 = den(ind,ind);
      X(ienv,:) = reshape(den1, [1,nbasis^2]);
    end
    means = mean(X,1);
    for ienv=1:nenv
        X(ienv,:) = X(ienv,:)-means;
    end
    [coef, score, latent] = princomp(X, 'econ');
    LnLatent = log(latent);
    cutoff = find( latent < 10^-25, 1, 'first' );
    if size( cutoff, 1 ) > 0
        LnLatent = LnLatent( 1:cutoff, : );
    end
    figure( 67 );
    plot( LnLatent, 'b' );
end
hold off;