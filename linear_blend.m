function img3 = linear_blend( img1_warp,img2_warp,matches )

[H1,W1]=size(img1_warp);
[H2,W2]=size(img2_warp);

if H1<=H2
    H3=H2*3+2;
else
    H3=H1*3+2;
end

if W1<=W2
    W3=W2*3+2;
else
    W3=W1*3+2;
end

img3=zeros(H3,W3);

dw=round(sum( matches(:,4)-matches(:,2) )/size(matches,1));
dh=round(sum( matches(:,3)-matches(:,1) )/size(matches,1)); 

A_left_corner_H=round((H3-H1)/2)+1;
A_left_corner_W=round((W3-W1)/2)+1;
A_right_corner_H=round((H3-H1)/2)+1;
A_right_corner_W=round((W3-W1)/2)+W1;

B_left_corner_H=round((H3-H2)/2)+1-dh;
B_left_corner_W=A_right_corner_W+1-dw;

if A_left_corner_W< B_left_corner_W
    overlap_left=B_left_corner_W;
    overlap_right=A_right_corner_W;
else
    overlap_left=A_left_corner_W;
    overlap_right=B_right_corner_W;
end

dis=overlap_right-overlap_left+1; 

if A_left_corner_W< B_left_corner_W
    U10=ones(1,W1);
    for i=1:dis
        U10(W1-dis+i)=1-1/dis*i;
    end
    U10=repmat(U10,[H1,1]);
    img1_warp=img1_warp.*U10;
    
    U01=ones(1,W2);
    for i=1:dis
        U01(i)=1/dis*i;
    end
    U01=repmat(U01,[H2,1]);
    img2_warp=img2_warp.*U01;
else
    U10=ones(1,W2);
    for i=1:dis
        U10(W2-dis+i)=1-1/dis*i;
    end
    U10=repmat(U10,[H2,1]);
    img2_warp=img2_warp.*U10;
    
    U01=ones(1,W1);
    for i=1:dis
        U01(i)=1/dis*i;
    end
    U01=repmat(U01,[H1,1]);
    img1_warp=img1_warp.*U01;
end

img3( A_left_corner_H : A_left_corner_H+H1-1, A_left_corner_W : A_left_corner_W+W1-1 )=img1_warp;
img3( B_left_corner_H : B_left_corner_H+H2-1, B_left_corner_W : B_left_corner_W+W2-1 )=img3( B_left_corner_H : B_left_corner_H+H2-1,  B_left_corner_W : B_left_corner_W+W2-1 )+img2_warp;

img3(all(img3==0,2),:) = [];
img3(:,all(img3==0,1)) = [];

end

