clc; clear;

% -------------------------------------------------------------
% IMPORT ANALYTICAL TENSOR COMPONENTS
% -------------------------------------------------------------
G = 1;
rho = 1;

L = 2.0; B = 2.0; D = 2.0;
X_0 = 0.0; Y_0 = 0.0; Z_0 = 0.0;   % Cube centered at origin
z_plane = Z_0;

a = L/2; 
b = B/2;
c = D/2;

% -------------------------------------------------------------
% GRID FOR x-y PLANE 
% -------------------------------------------------------------
x_vals = linspace(X_0 - L*0.75, X_0 + L*0.75, 300);
y_vals = linspace(Y_0 - B*0.75, Y_0 + B*0.75, 300);
[X, Y] = meshgrid(x_vals, y_vals);

laplace_vals = zeros(size(X));

% -------------------------------------------------------------
% ANALYTICAL LAPLACIAN = Vxx + Vyy + Vzz
% -------------------------------------------------------------
for i = 1:size(X,1)
    for j = 1:size(X,2)

        x_rel = X(i,j) - X_0;
        y_rel = Y(i,j) - Y_0;
        z_rel = z_plane - Z_0;

        Vxx = GravCuboidTensor.Vxx(x_rel, y_rel, z_rel, a, b, c, rho, G);
        Vyy = GravCuboidTensor.Vyy(x_rel, y_rel, z_rel, a, b, c, rho, G);
        Vzz = GravCuboidTensor.Vzz(x_rel, y_rel, z_rel, a, b, c, rho, G);

        laplace_vals(i,j) = Vxx + Vyy + Vzz;
    end
end

% -------------------------------------------------------------
% CREATE DISCRETE COLORMAP
% -------------------------------------------------------------
N = 50;
colors = zeros(N,3);

% First color = (0.1, 0.4, 1)
colors(1,:) = [0.1, 0.4, 1];

% Middle colors
for i = 2:N-1
    ratio = (i-2) / (N-3);
    r = ratio;
    g = 1.0;
    b = 1.0 - ratio;
    colors(i,:) = [r, g, b];
end

% Last color = red
colors(N,:) = [1, 0, 0];

cmap_discrete = colors;

vmin = -4*pi;
vmax = 0;
bounds = linspace(vmin, vmax, N+1);

% -------------------------------------------------------------
% PLOTTING
% -------------------------------------------------------------
fig = figure('Units','inches','Position',[1 1 8 7],'Color','w');
ax = axes(fig);

im = imagesc(ax, x_vals, y_vals, laplace_vals);
set(ax,'YDir','normal');
colormap(ax, cmap_discrete);

% Manual boundary normalization (equivalent to BoundaryNorm)
caxis(ax, [vmin vmax]);

% Colorbar
cbar = colorbar(ax);

tick_positions = [-12, -10, -8, -6, -4, -2, 0];
cbar.Ticks = tick_positions;
cbar.TickLabels = string(tick_positions);
cbar.Label.String = '\nabla^2 V';
cbar.Label.FontSize = 14;

% -------------------------------------------------------------
% CUBE BOUNDARY (white)
% -------------------------------------------------------------
x_min = X_0 - L/2;
x_max = X_0 + L/2;
y_min = Y_0 - B/2;
y_max = Y_0 + B/2;

hold(ax,'on');
plot(ax, ...
    [x_min x_max x_max x_min x_min], ...
    [y_min y_min y_max y_max y_min], ...
    'w-', 'LineWidth', 2, ...
    'DisplayName','Cube Boundary');

lg = legend(ax,'Location','southwest');
lg.Box = 'off';
lg.TextColor = 'white';
lg.FontSize = 16;

% -------------------------------------------------------------
% TEXT LABELS
% -------------------------------------------------------------
text(ax, 0, 0, '\nabla^2 V = -4\pi', ...
    'Color','white', ...
    'FontSize',20, 'FontWeight','bold', ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle');

outside_x = X_0 + L*0.6;
outside_y = Y_0 + B*0.6;

text(ax, 0, outside_y, '\nabla^2 V = 0', ...
    'Color','white', ...
    'FontSize',20, 'FontWeight','bold', ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle');

% -------------------------------------------------------------
% TITLES AND LABELS
% -------------------------------------------------------------
title(ax, "Laplacian Test in the x-y Plane Through the Cube", 'FontSize',17);
xlabel(ax, 'x', 'FontSize',16);
ylabel(ax, 'y', 'FontSize',16);
grid(ax,'off');

% -------------------------------------------------------------
% SAVE IMAGE
% -------------------------------------------------------------
saveas(fig, "laplacian_plot.png");
