function makeMontage(filename, nSlices) 
% make montage of images and make a simple image montage for 3D data
% ce 2019-03-14

% load in niftifile
%use montage () function in matlab to do work 
% think about how to change number of slices?
% think about the image brightness/contrast?

data = niftiread (filename);
if ndims(data)~= 3
    error ('we can only deal with 3D data')
end 

% image brightness 5th & 95th prctile to ensure the best greyscale contrast
% robustRange = prctile(data(:)[5,95]); 
robustRange = prctile(data(:),[5 95]); 
% the function displays sagital and not axial view so needs to be
% reorientated and swap the 2nd & 3rd dimension 
% reorientate the cube of data to get axial as displaying sagital as more
% sagital slices than axial
% this might be different for a different data set 

dataP = permute(data,[2,1,3,4]);
% this allows to swap dimensions around and not just columns and rows 
% montage (dataP,'displayRange',robustRange)
% but want to be able to select which slices we view and not the whole data
% set 
% which slices should we display? 
actualNslices = size(dataP,3); 
% the actual number of slices is equal to the size of permuted data in the
% 3D data 
% for example if the user would like 25 slices...need to go from
% 1-actualNslices in 25 steps 
whichSlices = round(linspace(1,actualNslices,nSlices)); 
% the problem without the round before linspace is you can request numbers
% such as 11.50...slice 11.56 doesnt exist but slice 11/12 does so need to
% make sure the numbers get rounded up
montage(dataP,'DisplayRange',robustRange,'Indices',whichSlices)
% type in command window makeMontage('mprage.nii') 