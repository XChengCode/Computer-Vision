function H = ransac(matches,sample,k,threshold)
matches_size=size(matches,1); 

matches_A=[matches(:,1:2),ones(matches_size,1)];
matches_B=[matches(:,3:4),ones(matches_size,1)];
countMap=zeros(k,10); 
for i=1:k
    %随机选某几组matches
    rander=ceil(rand(sample,1)*matches_size); 
    matches_choice=matches( rander(:),: );
    add=ones(sample,1);
    matches_a=[matches_choice(:,1:2),add];
    matches_b=[matches_choice(:,3:4),add];
    
    H=fit_affine_matrix(matches_a, matches_b); 
    matches_C=matches_A*H;
    dis =( matches_C(:,1)-matches_B(:,1) ).^2+( matches_C(:,2)-matches_B(:,2) ).^2;
    count=sum(dis(:)<threshold);
    countMap(i,1)=count;
    countMap(i,2:10)=reshape(H,1,9);
    
    countMap=sortrows(countMap,-1);
end

H=countMap(1,2:10);
H=reshape(H,3,3);
H(:,3)=[0 0 1];
end

