A = csvread("arabica_aftertaste.csv");
T = csvread("arabica_total cup point.csv");
length(A);
minA = min(A);
maxA = max(A);
meanA = mean(A);
medA = median(A);
stdA = std(A);
modeA = mode(A);
varA = var(A);
pisaiA = range(A);

%***** Histogram *****
figure
histogram(A)
title("Aftertaste Histogram")
xlabel("Aftertaste (points)")
ylabel("Samples")

%***** Box plot w/ outlier *****
figure
boxplot(A)
title("Aftertaste Boxplot")
ylabel("Aftertaste (points)")

%***** Box plot w/o outlier *****
A_trimmed = csvread("arabica_aftertaste_trimmed.csv");
meanA_trm = mean(A_trimmed);
figure
boxplot(A_trimmed)
title("Aftertaste Boxplot (trimmed)")
ylabel("Aftertaste (points)")

%***** PMF *****
figure
histogram(A, 'Normalization', 'probability') %pmf
title("Aftertaste PMF")
xlabel("Aftertaste (points)")
ylabel("Probability mass")

%***** CDF *****
figure
histogram(A, 'Normalization', 'cdf') %cdf
title("Aftertaste CDF")
xlabel("Aftertaste (points)")
ylabel("Probability")

%***** Stem and leaf *****
stemleafplot(A*10)

%***** Linear regression *****
% y = ax + b
% sigma(x^2)a + sigma(x)b = sigma(xy)
% sigma(x)a   + Nb        = sigma(y)
x2 = [];
xy = [];
for i = 1:1310
    xy = [xy, A(i,1)*T(i,1)];
    x2 = [x2, power(A(i,1),2)];
end

syms a b
eq1 = sum(x2)*a + sum(A)*b == sum(xy);
eq2 = sum(A)*a  + 1310*b   == sum(T);
[X,Y] = equationsToMatrix([eq1, eq2], [a,b]);
W = linsolve(X,Y);

a = 6.29;
b = 35.601;

y_hat = aA + b;
scatter(A,T,'b')
hold on
plot(A,y_hat,'-r');
title("Aftertaste-Total cup point Linear regression");
xlabel("Aftertaste (points)");
ylabel("Total cup point (points)");
