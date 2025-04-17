clear; close all;

%%%% Spatial parameters %%%%
nz = 24; dz = 0.75;                  % Number of grid points and spacing in z-direction
nx = 49; dx = 0.75;                  % Number of grid points and spacing in x-direction
z = 0:dz:(nz-1)*dz;                  % Depth axis
x = 0:dx:(nx-1)*dx;                  % Horizontal axis
pad = 20;                            % Padding for FDTD simulation

%%% Source locations %%%
sx = 1:4:49;                         % Source positions in x-direction (every other point)
nsx = length(sx); Ns = nsx;         % Number of sources
Sz = 1*ones(Ns,1);                  % Fixed z-index for all sources
Sx = zeros(Ns,1);                   % x-indices to be filled

for j = 1:nsx
    Sx(j) = sx(j);
end

S = [Sz, Sx];                        % Source positions as [z, x]

%%% Receiver locations %%%
rx = 2:2:48;                         % Receiver positions in x-direction (evenly spaced)
nrx = length(rx); Nr = nrx;         % Number of receivers
Rz = 1*ones(Nr,1);                  % Fixed z-index for all receivers
Rx = zeros(Nr,1);

for j = 1:nrx
    Rx(j) = rx(j);
end

R = [Rz, Rx];                        % Receiver positions as [z, x]
dr = 2 * dx;                         % Receiver spacing in meters
R_rm = 0;                            % Receiver removal threshold (if needed)

%%% Source-receiver distances %%%
distance = zeros(Ns, Nr);
for i = 1:Ns
    distance(i,:) = sqrt((Rx - Sx(i)).^2 * dx^2 + (Rz - Sz(i)).^2 * dz^2)';
    for j = 1:Nr
        if distance(i,j) == 0
            distance(i,j) = dx;      % Avoid zero distance
        end
    end
end

%%% Step 1: Define the True Model %%%
Vs = 300 * ones(nz,nx);             % Initialize Vs as constant

% Create a void (low-velocity zone) in the model
void_nz = 3; void_nx = 3;                              % Size of the void
start_z = round(nz/3 - void_nz/3);                      % Starting z-index
start_x = round(nx/2 - void_nx/2);                      % Starting x-index
Vs(start_z:(start_z+void_nz-1), start_x:(start_x+void_nx-1)) = 10;  % Low velocity for void

Vs = imgaussfilt(Vs, 0.5);                                % Smooth model using Gaussian filter

rho = 1250 + 0.62 * Vs;                                 % Empirical relationship for density

Vs_True = Vs;
rho_True = rho;

% %%% Time parameters for wavefield simulation %%%
tmax = 0.35;                         % Max simulation time (s)
Vmax = max(Vs(:));                 % Max shear velocity
dts = 0.9 / (Vmax * sqrt(1/dx^2 + 1/dz^2));  % Stable time step
ts = 0:dts:tmax; nts = length(ts);           % Time axis

load('seismic_wavefield_void.mat')

%%% Plot recorded data for the first source %%%
figure(2);
set(gcf, 'Color', 'w');
RR_test = D(:,:,6);
RR_test = RR_test / max(abs(RR_test(:)));
scale = 3;

hold on
for i = 1:Nr
    plot(RR_test(:,i) * scale + i, ts, 'k');
end
hold off
title('Measured data (Scaled)')
axis([0 Nr+1 min(ts) max(ts)]);
xticks(1:1:Nr);
ylabel('Time (s)'); xlabel('Receiver Number');
set(gca, 'YDir', 'reverse');

%% === STEP 1: Prepare ANN Training Data ===
[nT, nR, nS] = size(D);
source_x = S(:,2);       % Source x-indices
receiver_x = Rx(:)';     % Receiver x-indices (row vector)

% Compute distance between each source and all receivers
Input_dist = abs(source_x - receiver_x);      % [Ns x Nr]
Input_dist = normalize(Input_dist, 2);        % Row-wise normalization to [0,1]

% Reshape 3D wavefield to 2D matrix for ANN target output
Y_output = zeros(nS, nT * nR);
for i = 1:nS
    temp = squeeze(D(:,:,i));
    Y_output(i,:) = temp(:)';
end

% Normalize output
Y_mean = mean(Y_output, 1);
Y_std = std(Y_output, [], 1);
Y_output_norm = (Y_output - Y_mean) ./ Y_std;

%% === Define and Train the Neural Network ===
layers = [
    featureInputLayer(nR)
    fullyConnectedLayer(512)
    reluLayer
    fullyConnectedLayer(1024)
    reluLayer
    fullyConnectedLayer(2048)
    reluLayer
    fullyConnectedLayer(nT * nR)
    regressionLayer
    ];

options = trainingOptions('adam', ...
    'MaxEpochs', 500, ...
    'MiniBatchSize', 4, ...
    'InitialLearnRate',1e-3, ...
    'Shuffle', 'every-epoch', ...
    'Verbose', false, ...
    'Plots','training-progress');

net = trainNetwork(Input_dist, Y_output_norm, layers, options);

%% === Predict surface wavefield across all horizontal grid points ===
x_src_new = 24;                       % Example: fixed source index
D_pred = zeros(nT, nx);              % Predicted wavefield across surface

for ix = 1:nx
    dist_tmp = abs(x_src_new - receiver_x);
    dist_tmp = normalize(dist_tmp);
    
    Y_pred_norm = predict(net, dist_tmp);
    Y_pred = Y_pred_norm .* Y_std + Y_mean;
    D_temp = reshape(Y_pred, [nT, nR]);
    
    [~, idx_closest] = min(abs(receiver_x - ix));
    D_pred(:,ix) = D_temp(:,idx_closest);
end

% Plot predicted surface wavefield
D_pred_norm = D_pred / max(abs(D_pred(:)));
scale = 3;

figure(3); clf;
set(gcf, 'Color', 'w');
hold on;
for i = 1:nx
    plot(D_pred_norm(:,i) * scale + i, ts, 'k');
end
hold off;
title('Predicted surface wavefield (Scaled)');
xlabel('Grid index x'); ylabel('Time (s)');
set(gca, 'YDir', 'reverse');
axis([0 nx+1 min(ts) max(ts)]);
xticks(0:5:nx-1);
