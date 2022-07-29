%This skript is an extension for the Skull analysis described in the paper:
%Sex differences and risk factors for bleeding in 1 Alagille syndrome
%The input data are already pre-processed in the VG Studio Max software
%according to the methodology described in the paper.
%This script serves for the filling of the spongy bone, to obtain the
%full-bone-thickness.
clear all, clc

Sample_name='WT_male_P30_1410' %Name of the sample in the database
Path=dir('Q:\Hankeova\Allagile_skull_thickness\22_07_06\WT_male_P30_1410\Skull_extracted\*.tif'); % Path to the folder with CT data
vx=0.0128101808950305^3;

%Reading the data into the memory
for i=1:length(Path)
    Image_name=Path(i,1).name;
    CT(:,:,i)=imread([Image_name]);
end

CT_BW=imbinarize(CT); % Preprocessed CT data binarisation

SE = strel("cube",7); %Structuring element for morphologic closing
C = imclose(CT_BW,SE); %Morphologic closing
Vol=sum(sum(sum(C))); %Computation of the filled bone volume

Volume=Vol*vx; %Normalisation according to the voxel size of the scan
disp(Volume)

%Write data to the disc for further evaluation

for j=1:9;

    imwrite(C(:,:,j),([Sample_name '_0000' num2str(j) ,'.bmp'])) ;

end

for j=10:99;

    imwrite(C(:,:,j),([Sample_name '_000' num2str(j) '.bmp'])) ;

end
for j=100:999;

    imwrite(C(:,:,j),([Sample_name '_00' num2str(j) '.bmp'])) ;

end
for j=1000:size(C,3);

    imwrite(C(:,:,j),([Sample_name '_0' num2str(j) '.bmp'])) ;

end

