S = csvread("arabica_sweetness.csv");
T = csvread("arabica_total cup point.csv");
A= csvread("arabica_aftertaste.csv");
length(S);
minS = min(S);
maxS = max(S);
means = mean(S);
medS = median(S);
stdS = std(S);
modeS = mode(S);
varS = var(S);
pisaiS = range(S);

%***** Histogram *****
figure
histogram(S)
title("Sweetness Histogram")
xlabel("Sweetness (points)")
ylabel("Samples")

%***** Box plot w/ outlier *****
figure
boxplot(S)
title("Sweetness Boxplot")
ylabel("Sweeness (point)")

%***** Box plot w/o outlier *****
S_trimmed = csvread("arabica_sweetness_trimmed.csv");
meanS_trm = mean(S_trimmed);
figure
boxplot(S_trimmed)
title("Sweetness Boxplot (trimmed)")
ylabel("Sweeness (point)")

%***** PMF *****
figure
histogram(S, 'Normalization', 'probability') %pmf
title("Sweetness PMF")
xlabel("Sweetness (points)")
ylabel("Probability mass")

%***** CDF *****
figure
histogram(S, 'Normalization', 'cdf') %cdf
title("Sweetness CDF")
xlabel("Sweetness (points)")
ylabel("Probability")

%***** Stem and leaf *****
stemleafplot(S*10)

%***** Scatterplot Sweetness *****
figure
scatter(S,T)
title("Scatter plot Sweetness-Points")
xlabel("Sweetness (points)")
ylabel("Total cup point (points)")

%***** Scatterplot Aftertaste *****
figure
scatter(A,T)
title("Scatter plot Aftertaste-Points")
xlabel("Aftertaste (points)")
ylabel("Total cup point (points)")

%***** Linear regression *****
% y = ax + b
% sigma(x^2)a + sigma(x)b = sigma(xy)
% sigma(x)a   + Nb        = sigma(y)
x2 = [];
xy = [];
for i = 1:1310
    xy = [xy, S(i,1)*T(i,1)];
    x2 = [x2, power(S(i,1),2)];
end

syms a b
eq1 = sum(x2)*a + sum(S)*b == sum(xy);
eq2 = sum(S)*a  + 1310*b   == sum(T);
[X,Y] = equationsToMatrix([eq1, eq2], [a,b]);
W = linsolve(X,Y)

a = -0.3267;
b = 85.4169;

y_hat = a*S + b;
scatter(S,T,'b')
hold on
plot(S,y_hat,'-r');
title("Sweetness-Total cup point Linear regression");
xlabel("Sweetness (points)");
ylabel("Total cup point (points)");

