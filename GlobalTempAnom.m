%Project by: Jerad King, Brad Jennings, Mitchell Bonvillian, Tobin Haight  
%Variable assigning
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
%%
%Global Permute
m = permute(temp, [3,1,2]);
n = nanmean(m, 3);
t = nanmean(n, 2);
xx=reshape(t(1:1680),12,[]);
tf = sum(xx)/12;
%%
%Global Average Plot
figure(1)
gaPlot = plot(TS, tf,'-s','markersize',5,'color','k','displayname','Annual Mean');
set(gaPlot, 'markerfacecolor', 'k')
ylabel('Temperature Anomaly (C)')
xticklabels({1880 1900 1920 1940 1960 1980 2000 2020})
SGA = smoothdata(tf);
hold on
plot(TS,SGA,'-r','displayname','Moving Average')
erb1GA = tf(TS==10);
erb2GA = tf(TS==70);
erb3GA = tf(TS==130);
GAer1 = erf(tf(TS==10));
GAer2 = erf(tf(TS==70));
GAer3 = erf(tf(TS==130));
errorbar(10,erb1GA, GAer1,'color','b')
errorbar(70,erb2GA, GAer2,'color','b')
errorbar(130,erb3GA, GAer3,'color','b')
hold off
legend('Annual Mean','Moving Average','Location','northwest')
text(105,-0.75,'NASA GISS')
title('Global Mean Estimates based on Land and Ocean Data')
%% 
%Northern Hempishpere permute
tempNorth = temp(:,[46:90],:);
mNorth = permute(tempNorth, [3,1,2]);
nNorth = nanmean(mNorth, 3);
tNorth = nanmean(nNorth, 2);
xxNorth=reshape(tNorth(1:1680),12,[]);
tfNorth = sum(xxNorth)/12;
%%
%Northern Hemisphere Plot
figure(2)
nhPlot = plot(TS, tfNorth,'-s','markersize',5,'color','k','displayname','Annual Mean');
set(nhPlot, 'markerfacecolor', 'k')
ylabel('Temperature Anomaly (C)')
xticklabels({1880 1900 1920 1940 1960 1980 2000 2020})
SNH = smoothdata(tf);
hold on
plot(TS,SNH,'-r','displayname','Moving Average')
erb1NH = tfNorth(TS==10);
erb2NH = tfNorth(TS==70);
erb3NH = tfNorth(TS==130);
NHer1 = erf(tfNorth(TS==10));
NHer2 = erf(tfNorth(TS==70));
NHer3 = erf(tfNorth(TS==130));
errorbar(10,erb1NH, NHer1,'color','b')
errorbar(70,erb2NH, NHer2,'color','b')
errorbar(130,erb3NH, NHer3,'color','b')
hold off
legend('Annual Mean','Moving Average','Location','northwest')
text(105,-0.7,'NASA GISS')
title('Northern Hemisphere Mean Estimates based on Land and Ocean Data')
%%
%Continental US Permute 
tempUS = temp([28:57],[58:69],:);
mUS = permute(tempUS, [3,1,2]);
nUS = nanmean(mUS, 3);
tUS = nanmean(nUS, 2);
xxUS=reshape(tUS(1:1680),12,[]);
tfUS = sum(xxUS)/12;
%%
%Continental US Plot
figure(3)
USPlot = plot(TS, tfUS,'-s','markersize',5,'color','k','displayname','Annual Mean');
set(USPlot, 'markerfacecolor', 'k')
ylabel('Temperature Anomaly (C)')
xticklabels({1880 1900 1920 1940 1960 1980 2000 2020})
SUS = smoothdata(tf);
hold on
plot(TS,SUS,'-r','displayname','Moving Average')
erb1US = tfUS(TS==10);
erb2US = tfUS(TS==70);
erb3US = tfUS(TS==130);
USer1 = erf(tfUS(TS==10));
USer2 = erf(tfUS(TS==70));
USer3 = erf(tfUS(TS==130));
errorbar(10,erb1US, USer1,'color','b')
errorbar(70,erb2US, USer2,'color','b')
errorbar(130,erb3US, USer3,'color','b')
hold off
legend('Annual Mean','Moving Average','Location','northwest')
text(105,-0.65,'NASA GISS')
title('US Continental Mean Estimates based on Land and Ocean Data')
%%
%Texas Permute
tempTX = temp([37:48], [58:65],:);
mTX = permute(tempTX, [3,1,2]);
nTX = nanmean(mTX, 3);
tTX = nanmean(nTX, 2);
xxTX=reshape(tTX(1:1680),12,[]);
tfTX = sum(xxTX)/12;
%%
%Texas Plot
figure(4)
TXPlot = plot(TS, tfTX,'-s','markersize',5,'color','k','displayname','Annual Mean');
set(TXPlot, 'markerfacecolor', 'k')
ylabel('Temperature Anomaly (C)')
xticklabels({1880 1900 1920 1940 1960 1980 2000 2020})
STX = smoothdata(tf);
hold on
plot(TS,STX,'-r','displayname','Moving Average')
erb1TX = tfTX(TS==10);
erb2TX = tfTX(TS==70);
erb3TX = tfTX(TS==130);
TXer1 = erf(tfTX(TS==10));
TXer2 = erf(tfTX(TS==70));
TXer3 = erf(tfTX(TS==130));
errorbar(10,erb1TX, TXer1,'color','b')
errorbar(70,erb2TX, TXer2,'color','b')
errorbar(130,erb3TX, TXer3,'color','b')
hold off
legend('Annual Mean','Moving Average','Location','northwest')
text(110,-0.75,'NASA GISS')
title('Texas Mean Estimates based on Land and Ocean Data')
