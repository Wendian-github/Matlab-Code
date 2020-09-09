%% Read Chla from modis .nc files (in batch)

datadir=''; %ָ�������������ڵ��ļ���
filelist=dir([datadir,'*.nc']); %ָ���������ݵ�����
k=length(filelist); %nc�ļ�����

for s = 1:k
    datadir='*\'; %ָ�������������ڵ��ļ���
    filelist=dir([datadir,'*.nc']); %ָ���������ݵ�����
    k=length(filelist); %nc�ļ�����
    
    filename=[datadir,filelist(s).name];
    Chla=ncread(filename,'chlor_a'); %�������chla
    LonData  = ncread(filename,'lon'); %�������lon
    LatData  = ncread(filename,'lat')'; %�������lat
    
    value=Chla;% ȷ�������Ȥ������
    
    lonmin=117; lonmax=131;
    latmin=25; latmax=42;
    
    in1=find(LonData>=lonmin & LonData<=lonmax);
    in2=find(LatData>=latmin & LatData<=latmax);
    
    value_sub=value(in1,in2)';
    lon=LonData(in1);
    lat=LatData(in2);
    [LonData_re_sub,LatData_re_sub]=meshgrid(lon,lat);
    
    % �����м���Chla
    str = sprintf('Chla Month%d',s);%ͼ���ļ�������
    save(str,'value_sub');
    
    %��ͼ
    m_proj('mercator','lon',[lonmin lonmax],'lat',[latmin latmax]);
    hold on;
    h=m_pcolor(LonData_re_sub,LatData_re_sub,log10(value_sub));
    %h=m_pcolor(LonData_re,LatData_re,value);
    shading flat;
    
    caxis([log10(0.01) log10(65)]);
    colormap(jet)
    hc=colorbar;
    set(get(hc,'Title'),'string',' Chl a','fontname','Times New Roman');
    YT=[ log10(0.01) log10(0.1) log10(1) log10(10) log10(65)];
    set(hc,'YTick',YT,'YTickLabel',{'0.01','0.1','1','10','65'});
    
    m_gshhs_h('patch',[.5 .5 .5],'edgecolor','k');
    m_grid('box','fancy','tickdir','in');
    hold off
    str=sprintf('Month%d',s);%ͼ���ļ�������
    figurename=[datadir,str];%ͼ���ļ�������
    saveas(h,figurename,'tif'); %����ͼ��
    close all
    clear
end