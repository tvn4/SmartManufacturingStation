%% Array Animation Creation Script
% By DLZ
close all; clear all; clc;

world = vrworld('.\Animation\Final_DT_3D_World.x3d');
fig_vr = vrfigure(world);

block_1 = vrnode(world,'Square_bas1_Transform');

%% Following section only needs to be run once to make and save all the 
% Arrays needed to animate actuation 

%% Coordinates for initial and final positions

% Rate of change
% diff = 5;

% Starting actuation coordinates
coordsFor_init = [338, 140, 220]; % Z-axis actuation
coordsVer_init = [325, 200, 72]; % Y-axis actuation
coordsTranf_init = [345, 170, 60]; % X-axis actuation
coordsRej_init = [100, 150, 20]; % Z-axis actuation 

% Final actuation coordinates
coordsFor_fin = [338, 140, 125];
coordsVer_fin = [325, 170, 72];
coordsTranf_fin = [125, 170, 60];
coordsRej_fin = [100, 150, 35];

% Rate Calculator (End - Initial)/ (Number of samples)
samp_For = 2;
samp_Ver = 1;
samp_Tranf = 3;
samp_Rej = 1;

diff_for = (coordsFor_fin(3) - coordsFor_init(3))/samp_For;
diff_Ver = (coordsVer_fin(2) - coordsVer_init(2))/samp_Ver;
diff_Tranf = (coordsTranf_fin(1) - coordsTranf_init(1))/samp_Tranf;
diff_Rej = (coordsRej_fin(3) - coordsRej_init(3))/samp_Rej;

%%

% Non-MV Block animations
% For Accepted Parts
coordsBlockSpawn_accept = [275, 140, 150];
coordsBlockVer_accept = [275, 140, 65];
coordsBlockFinal_accept = [60,140,65];

% For Defective Parts
coordsBlockVer_defect = [275, 172, 130];
coordsBlockFinal_defect = [60, 172, 130];

% Rate Calculator (End - Initial)/ (Number of samples of actuator responsible)
diff_blockSpawn = (coordsBlockVer_accept(3) - coordsBlockSpawn_accept(3))/samp_For; % Relies on Forward Actuator
diff_blockVerFin_accept = (coordsBlockFinal_accept(1) - coordsBlockVer_accept(1))/samp_Tranf; % Relies on Transfer
diff_blockVerFin_defect = (coordsBlockFinal_defect(1) - coordsBlockVer_defect(1))/samp_Tranf; % Relies on Transfer

%% For forward actuator

% Creating the arrays responsible for initial 'ON'
actFor_z1 = coordsFor_init(3):diff_for:coordsFor_fin(3); % Main axis of actuation
actFor_y1 = coordsFor_init(2) + zeros(size(actFor_z1));
actFor_x1 = coordsFor_init(1) + zeros(size(actFor_z1));

% Concatenating 3D ON translations into one array
actFor_3D_ON = cat(1,actFor_x1,actFor_y1,actFor_z1);

%% For verification actuator
% Forward
actVer_y1 = coordsVer_init(2):diff_Ver:coordsVer_fin(2); % Main axis of actuation
actVer_z1 = coordsVer_init(3) + zeros(size(actVer_y1));
actVer_x1 = coordsVer_init(1) + zeros(size(actVer_y1));

% Concatenating 3D ON translations into one array
actVer_3D_ON = cat(1,actVer_x1,actVer_y1,actVer_z1);

% % Concatenating 3D OFF trnaslations into one array
% actVer_3D_OFF = cat(1,actVer_x2,actVer_y2,actVer_z2);

%% For transfer actuator
% Forward
actTranf_x1 = coordsTranf_init(1):diff_Tranf:coordsTranf_fin(1); % Main axis of actuation
actTranf_y1 = coordsTranf_init(2) + zeros(size(actTranf_x1));
actTranf_z1 = coordsTranf_init(3) + zeros(size(actTranf_x1));

% Concatenating 3D ON translations into one array
actTranf_3D_ON = cat(1,actTranf_x1,actTranf_y1,actTranf_z1);

%% For Rejection Actuator
% Forward
actRej_z1 = coordsRej_init(3):diff_Rej:coordsRej_fin(3); %Main axis of actuation
actRej_x1 = coordsRej_init(1) + zeros(size(actRej_z1));
actRej_y1 = coordsRej_init(2) + zeros(size(actRej_z1));

% Concatenating 3D ON translations into one array
actRej_3D_ON = cat(1,actRej_x1,actRej_y1,actRej_z1);

% % Concatenating 3D OFF translations into one array
% actRej_3D_OFF = cat(1,actRej_x2,actRej_y2,actRej_z2);

%% Block animations

% For Spawn-Verification Block Animation
blockFor_z1 = coordsBlockSpawn_accept(3):diff_blockSpawn:coordsBlockVer_accept(3); % Main axis of actuation
blockFor_y1 = coordsBlockSpawn_accept(2) + zeros(size(blockFor_z1));
blockFor_x1 = coordsBlockSpawn_accept(1) + zeros(size(blockFor_z1));

% Concatenating 3D translations for Forward-Verification animation into one array
blockForVer_3D = cat(1,blockFor_x1,blockFor_y1,blockFor_z1);

% For Accepted Verification-Final Block Animation
blockTranf_x1 = coordsBlockVer_accept(1):diff_blockVerFin_accept:coordsBlockFinal_accept(1); % Main axis of actuation
blockTranf_y1 = coordsBlockVer_accept(2) + zeros(size(blockTranf_x1));
blockTranf_z1 = coordsBlockVer_accept(3) + zeros(size(blockTranf_x1));

% Concatenating 3D translations for Accepted Verification-Final animation into one array
blockVerFin_3D_accept = cat(1,blockTranf_x1,blockTranf_y1,blockTranf_z1);

% For Defective Verification-Final Block Animation
blockTranf_x2 = coordsBlockVer_defect(1):diff_blockVerFin_defect:coordsBlockFinal_defect(1); % Main axis of actuation
blockTranf_y2 = coordsBlockVer_defect(2) + zeros(size(blockTranf_x2));
blockTranf_z2 = coordsBlockVer_defect(3) + zeros(size(blockTranf_x2));

% Concatenating 3D translations for Defective Verification-Final animation into one array
blockVerFin_3D_defect = cat(1,blockTranf_x2,blockTranf_y2,blockTranf_z2);

%% Saving the separate ON and OFF translations

save('Actuators ON-OFF Animations.mat', ...
    'actFor_3D_ON',...
    'actVer_3D_ON', ...
    'actTranf_3D_ON', ...
    'actRej_3D_ON',...
    'blockForVer_3D',...
    'blockVerFin_3D_accept',...
    'blockVerFin_3D_defect');