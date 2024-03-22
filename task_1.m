%% load the file
clc; 
close all;
load HH_20170206135645_5
load('NoiseFile.mat');

%% Range Slow Time image

time_ind = 1:30000;
img_file ="Noise";
hfig=figure;
imagesc(time_ind,range,db(abs(Data_out')))
colormap(jet(256))
colorbar;
set(gca,'clim',[25,80])
set(gca,'ydir','norm')
desired_aspect_ratio = 0.6; % For example, a height twice the width
set(gca, 'PlotBoxAspectRatio', [1, desired_aspect_ratio, 1]);
xlabel('Slow time, ms')
ylabel('Range, m')
% % title(['{',title_str,'}'])
print(hfig,'-dpng',img_file);
close(hfig);

%% Doppler Image

N_Doppler=16; j=1; 
start_time=1+N_Doppler*(j-1);
x=Data_out(start_time:start_time+N_Doppler-1,:);
RD=fftshift(fft(x, N_Doppler),1);
frequency=[-500:1000/(N_Doppler+1):500]; % how this has to be changed for diff PRF?
hfig=figure;
imagesc(frequency,range,db(abs(RD')))
colormap(jet(256))
colorbar
set(gca,'ydir','norm')
set(gca,'clim',[40,110]) % If you do not see the range-Doppler plane similar to slide 10,
% comment (or edit) the codeline set(gca,'clim',[10,70])
xlabel('Doppler frequency, Hz')
ylabel('Range, m')
% title(['{',title_str,' 1ms, burst ',num2str(j),'}'])

%% Generate the video


writerObj = VideoWriter('C:\Users\19670\Videos\16.avi');
open(writerObj);
for j = 1:59
    N_Doppler=16; 
    start_time=1+N_Doppler*(j-1);
    x=Data_out(start_time:start_time+N_Doppler-1,:);
    RD=fftshift(fft(x, N_Doppler),1);
    frequency=[-500:1000/(N_Doppler+1):500]; % how this has to be changed for diff PRF?
    hfig=figure;
    imagesc(frequency,range,db(abs(RD')))
    colormap(jet(256))
    colorbar
    set(gca,'ydir','norm')
    set(gca,'clim',[30,100]) % If you do not see the range-Doppler plane similar to slide 10,
    % comment (or edit) the codeline set(gca,'clim',[10,70])
    xlabel('Doppler frequency, Hz')
    ylabel('Range, m')
    frame = getframe(hfig);
    writeVideo(writerObj,frame);
    close all
end
close(writerObj);






