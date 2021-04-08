%% Research area
% .shp file is in directory: supporting files

lonmin=105;lonmax=125;
latmin=0;latmax=25;
figure
hold on
set(gcf, 'color', 'white','Units', 'normalized','position', [0.06 0.06 0.7 0.7]);
m_proj('Mercator','lon',[lonmin lonmax],'lat',[latmin latmax]);
m_gshhs_h('patch',[.7 .7 .7],'edgecolor',[.4 .4 .4]);  % Coastline
m_grid('linestyle','none','tickdir','in','linewidth',1.2,...
    'FontName','Times New Roman','FontSize',12);


% ����ʡ����
M = shaperead('provinces.shp');
provi_boudry_lon = [M(:).X];
provi_boudry_lat = [M(:).Y];
m_plot(provi_boudry_lon, provi_boudry_lat, 'k');
hold on

% text some points
m_line(126.5, 33.5,'marker','p','MarkerFaceColor','m','markersize',16,'color','k');
m_text(126.5, 34, '���ݵ�', 'color', 'k', 'fontsize', 16, 'fontweight', 'bold');
