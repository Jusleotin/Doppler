clc; 
close all;
load HH_20170206135645_5

c = 3*1e8;
f = 3.315*1e9;
lambda = c / f;

%% Doppler Image

PRI = 1;
R_max = c * PRI*1e-3 / 2;
v_max = lambda / (4 * PRI*1e-3);
disp(['Range ambiguity is: ', num2str(R_max), 'meters']);
disp(['Velocity ambiguity is: ', num2str(v_max), 'meters per second']);
N_Doppler=512; j=5; 
start_time=1+N_Doppler*(j-1);
x=Data_out(start_time:PRI:start_time+PRI*N_Doppler-1,:);
RD=fftshift(fft(x, N_Doppler),1);
frequency=[-500/PRI:1000/(N_Doppler+1):500/PRI]; % how this has to be changed for diff PRF?
hfig=figure;
imagesc(frequency,range,db(abs(RD')))
colormap(jet(256))
colorbar
set(gca,'ydir','norm')
set(gca,'clim',[40,110]) 
xlabel('Doppler frequency, Hz')
ylabel('Range, m')

%% Generate the video


writerObj = VideoWriter('C:\Users\19670\Videos\PRI_4.avi');
open(writerObj);
for j = 1:56
    N_Doppler=512; 
    start_time=1+N_Doppler*(j-1);
    x=Data_out(start_time:PRI:start_time+PRI*N_Doppler-1,:);
    RD=fftshift(fft(x, N_Doppler),1);
    frequency=[-500/PRI:1000/(N_Doppler+1):500/PRI]; 
    hfig=figure;
    imagesc(frequency,range,db(abs(RD')))
    colormap(jet(256))
    colorbar
    set(gca,'ydir','norm')
    set(gca,'clim',[40,110]) 
    xlabel('Doppler frequency, Hz')
    ylabel('Range, m')
    frame = getframe(hfig);
    writeVideo(writerObj,frame);
    close all
end
close(writerObj);