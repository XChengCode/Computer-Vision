img1 = imread('1.1.jpg');%在这里更换图片
img2 = imread('1.2.jpg');
img1 = rgb2gray(double(img1)/255);
img2 = rgb2gray(double(img2)/255);
keypoints1 = harris_corners(img1);
keypoints2 = harris_corners(img2);
figure
imshow(img1);title('keypoints1','FontSize',20);
[x,y]=find(keypoints1==1);
hold on;
plot(y,x,'rx','LineWidth',1,'MarkerSize',6,'Color','b');
figure
imshow(img2);title('keypoints2','FontSize',20);
[x,y]=find(keypoints2==1);
hold on;
plot(y,x,'rx','LineWidth',1,'MarkerSize',6,'Color','b');

descriptorMode=1;
patch_size=6;
desc1 = keypoint_description_simple(img1, keypoints1, descriptorMode, patch_size);
desc2 = keypoint_description_simple(img2, keypoints2, descriptorMode, patch_size);
threshold=0.65; 
matches = match_descriptors(desc1,desc2,threshold);
matches(:,4)=matches(:,4)+size(img1,2);
plot_match(matches,img1,img2);
add=ones(size(matches,1),1);
matches_A=[matches(:,1:2),add];
matches_B=[matches(:,3:4),add];

H1=fit_affine_matrix(matches_A, matches_B)
tform = affine2d(H1)
img2_warp=imwarp(img2,tform);
img1_warp=img1;
figure
imshow(img1_warp);title('Image 1 warped','FontSize',20);
figure
imshow(img2_warp);title('Image 2 warped','FontSize',20);
imageAdd(img1_warp,img2_warp,matches);

k=500; 
sample=5; 
threshold=0.5; 
H=ransac(matches,sample,k,threshold)
tform = affine2d(H)
img2_warp=imwarp(img2,tform);
img1_warp=img1;
figure
imshow(img1_warp);title('Image 1 warped','FontSize',20);
figure
imshow(img2_warp);title('Image 2 warped','FontSize',20);
imageAdd(img1_warp,img2_warp,matches);

descriptorMode=2;
patch_size=16;
desc1 = keypoint_description_simple(img1, keypoints1, descriptorMode, patch_size);
desc2 = keypoint_description_simple(img2, keypoints2, descriptorMode, patch_size);
threshold=0.6; 
matches = match_descriptors(desc1,desc2,threshold);
matches(:,4)=matches(:,4)+size(img1,2);
plot_match(matches,img1,img2);
k=500; 
sample=5;
threshold=0.6;
H=ransac(matches,sample,k,threshold)
tform = affine2d(H)
img2_warp=imwarp(img2,tform);
img1_warp=img1;
figure
imshow(img1_warp);title('Image 1 warped','FontSize',20);
figure
imshow(img2_warp);title('Image 2 warped','FontSize',20);
imageAdd(img1_warp,img2_warp,matches);

img_final=linear_blend(img1_warp,img2_warp,matches);
imshow(img_final);title('final','FontSize',20);
