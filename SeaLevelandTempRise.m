%Jerad King, Toby Haight, Mitchtell Bonvillian, Brad Jennings


%Obsv Climate Data, 1880-2019
ncid1 = netcdf.open ("gistemp1200.nc");
ncdisp("gistemp1200.nc");
ncinfo("gistemp1200.nc");
filename = 'gistemp1200.nc';
variables_to_load = {'time', 'lat', 'lon', 'time_bnds', 'tempanomaly'};
j=1:numel(variables_to_load);
var = variables_to_load{j};
data_struct.(var) = ncread(filename,var);
isa(data_struct.(var),'single');
data_struct.(var) = double(data_struct.(var));
temp = ncread('gistemp1200.nc','tempanomaly');
TS = [1:140];
%Obsv data Permute
m = permute(temp, [3,1,2]);
n = nanmean(m, 3);
t = nanmean(n, 2);
xx=reshape(t(1:1680),12,[]);
tf = sum(xx)/12;
%%
%Projected climate data 
ncid1 = netcdf.open ("TSamon.nc");
ncdisp("TSamon.nc");
ncinfo("TSamon.nc");
filename = 'TSamon.nc';
variables_to_load = {'time','time_bnds', 'lat','lat_bnds', 'lon','lon_bnds', 'ts'};
ncid1 = netcdf.open ("TSamon.nc");
ncdisp("TSamon.nc");
ncinfo("TSamon.nc");
filename = 'TSamon.nc';
variables_to_load = {'time','time_bnds', 'lat','lat_bnds', 'lon','lon_bnds', 'ts'};
% loop over the variables
for j=1:numel(variables_to_load);

% extract the jth variable (type = string)
var = variables_to_load{j};

% use dynamic field name to add this to the structure
data_struct.(var) = ncread(filename,var);

% convert from single to double, if that matters to you (it does to me)
if isa(data_struct.(var),'single');
data_struct.(var) = double(data_struct.(var));
end
end
temp = ncread(filename,'ts');
%Projected permute
m1 = permute(temp, [3,1,2]);
n1 = nanmean(m1, 3);
t1 = nanmean(n1, 2);
%%
%Obsv Fit
tfTemp = tf([21:126]);
TStemp = TS([21:126]);
%Projection Poly Fit
xx1=reshape(t1(1:1140),12,[]);
yy1 = (sum(xx1,1)./size(xx1,1)-277);
tt1 = [1:95];
TTemp = [tf(21:126), yy1(1:95)];
TempYear = [1:201];
TempProjPOLYFIT = polyfit(TempYear, TTemp,7);
p1 =  -2.604e-14;  
p2 =   2.002e-11;  
p3 =  -6.254e-09; 
p4 =   9.904e-07; 
p5 =  -8.003e-05;  
p6 =    0.003054;  
p7 =    -0.03766;  
p8 =     -0.2366; 
TempProjFit = p1.*TempYear.^7 + p2.*TempYear.^6 + p3.*TempYear.^5 + p4.*TempYear.^4 + p5.*TempYear.^3 + p6.*TempYear.^2 + p7.*TempYear + p8;
%%
%Temp Projection Plot
figure(1)
plot(TempYear(1:106), TTemp(1:106), '-b', 'linewidth', 1.8)
hold on
plot(TempYear, TempProjFit, '-r', 'linewidth',1.25)
hold off
xticklabels({1900:50:2100})
xlim([0 200])
ylabel('Temperature (C)')
xlabel('Year')
legend('Obs', 'BAU','Location','northwest')
title('Observed and Simulated Global Mean Surface Temperature')
legend boxoff
%%
GMSL = importdata('GMSLyear.txt');
TwentyGMSL = (((GMSL(21:121, 2)))/10)+13.1;
ntf = tf(21:121);
years = [1:101];
figure(2)
plot(years, TwentyGMSL,'-b','linewidth',1.5)
xticklabels({1900:20:2000})
xlim([0 100])
xlabel('Year')
ylabel('GMSL (cm)')
title('20th Century Global Mean Sea Level') 
%%
%Observed SLRR
Htdt1 = TwentyGMSL(:);
year = years(:);
Htdt2 = diff(Htdt1);
Htdt = Htdt2(:);
Gt1 = ntf(1:100);
Gt = Gt1(:);
Gto = .1390;
Gtdt1 = diff(Gt1)./diff(year);
Gtdt = Gtdt(:);
a1 = Htdt(:)./(Gt(:)-Gto);
a = mean(a1);
b = (Htdt - (a.*(Gt-Gto)))./Gtdt;
b = -mean(b);
%%
%SLRR Projection
SLRpYears = TempYear;
SLRpTemp = TempProjFit;
GtdtP = SLRpTemp./SLRpYears;
GtoP = ((SLRpTemp([1:201])-SLRpTemp(1)));
%SLRR to SLR Conversion
SLRRP = ((a.*(GtoP)+b.*(GtdtP)));
SLRP = movsum(SLRRP, [201 1]);
%%
%SLR Projection Plot
figure(3)
plot(TempYear, (SLRP-1.5), '-r','linewidth',1.7)
hold on
plot(TempYear(1:101), TwentyGMSL, '-b', 'LineWidth', 1.4)
ylabel('SLR (cm)')
xlabel('Year')
xticklabels({1900:50:2100})
xlim([0 200])
ylim([-5 160])
legend('BAU','Obs','location','northwest')
legend boxoff
title('Observed and Simulated Global Mean Sea Level Rise')