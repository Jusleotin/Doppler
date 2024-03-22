clc; 
close all;
load HH_20170206135645_5

c = 3*1e8;
f = 3.315*1e9;
lambda = c / f;
b = [1,-1];
a = 1;
data = filter(b,a,Data_out);

PRI = 1;
R_max = c * PRI*1e-3 / 2;
v_max = lambda / (4 * PRI*1e-3);
disp(['Range ambiguity is: ', num2str(R_max), 'meters']);
disp(['Velocity ambiguity is: ', num2str(v_max), 'meters per second']);
N_Doppler=512; j=1; 
start_time=1+N_Doppler*(j-1);
x=data(start_time:PRI:start_time+PRI*N_Doppler-1,:);
RD=fftshift(fft(x, N_Doppler),1);
frequency=[-500/PRI:1000/(N_Doppler+1):500/PRI]; % how this has to be changed for diff PRF?
hfig=figure;
imagesc(frequency,range,db(abs(RD')))
colormap(jet(256))
colorbar
set(gca,'ydir','norm')
set(gca,'clim',[40,110]) % If you do not see the range-Doppler plane similar to slide 10,
% comment (or edit) the codeline set(gca,'clim',[10,70])
xlabel('Doppler frequency, Hz')
ylabel('Range, m')