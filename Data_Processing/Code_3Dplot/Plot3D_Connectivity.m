function Plot3D_Connectivity(intensity,pair,MNIcoord,color_bar,viewangle,cmin,cmax)
% This function plots the connection as lines on a 3D brain template

if nargin<4
    cmin=-1;
    cmax=1;
    color_bar=1;
    viewangle=[0 90];
end

load('MNI152_downsampled.mat');
% [vertices,faces]=removeisolatednode(vertices,faces);

x_translate=100;
y_translate=140;
z_translate=80;

% MNIcoord=MNIcoord+repmat([x_translate y_translate z_translate],size(MNIcoord,1),1);
p=patch('faces',faces,'vertices',vertices, 'facecolor', [.8 .8 .8],  'edgecolor', 'none', 'facealpha', .2);
hold on

colcount=200;
scalemin=cmin;
scalemax=cmax;
colscale=jet(colcount);

for i=1:size(pair,1)
    intcol=(intensity(i)-scalemin)/(scalemax-scalemin);
    col=round(intcol*colcount);
    line([MNIcoord(pair(i,1),1) MNIcoord(pair(i,2),1)],...
        [MNIcoord(pair(i,1),2) MNIcoord(pair(i,2),2)],...
        [MNIcoord(pair(i,1),3) MNIcoord(pair(i,2),3)],'Color',colscale(col,:),'LineWidth',5);
    hold on
end

if color_bar
    colormap(colscale(101:200,:));
    caxis([0 1]);
    colorbar('Ticks',[0,1]);
end

daspect([.8 .8 .8])
view(3); axis tight
view([50 -40 100])

axis off;
set(gcf, 'InvertHardCopy', 'off');


view(viewangle);
camlight('headlight','infinite');
lighting gouraud
material dull;

end

