function keypoint_desc = keypoint_description_simple( image,keypoint,descriptorMode,patch_size )

if length(size(image))==3
    image = rgb2gray(double(image)/255);
end

keypoint_desc = [];

count=0;
[H,W]=size(keypoint);
for i=1:H
    for j=1:W
        if keypoint(i,j)==1
            count=count+1;
        end
    end
end

[x,y]=find(keypoint==1);

for i=1:count
    if descriptorMode==1
        patch=image( (x(i)-patch_size/2) : (x(i)+patch_size/2) , (y(i)-patch_size/2) : (y(i)+patch_size/2) );
        description = [x(i),y(i),simple_descriptor(patch)]; 
    elseif descriptorMode==2
        patch=image( (x(i)-patch_size/2+1) : (x(i)+patch_size/2) , (y(i)-patch_size/2+1) : (y(i)+patch_size/2) );
        description = [x(i),y(i),HOG_descriptor(patch,patch_size)]; 
    end
    keypoint_desc=[keypoint_desc;description];
end

end

