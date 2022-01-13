function response = harris_corners( img )

if length(size(img))==3
    img = rgb2gray(double(img)/255);
end

[row,col]=size(img); 
kernel_size=3;
k=0.04;
border=10; 

response=zeros(row,col);
process=response;

hx = fspecial('sobel');
hy = hx';
dx=conv2(img,hx,'same'); 
dy=conv2(img,hy,'same'); 
kernel=fspecial('gaussian',[kernel_size,kernel_size],1); 
mxx=conv2(dx.*dx,kernel,'same');
myy=conv2(dy.*dy,kernel,'same');
mxy=conv2(dx.*dy,kernel,'same'); 

for i=1:row
    for j=1:col
        M=[mxx(i,j),mxy(i,j);mxy(i,j),myy(i,j)];
        process(i, j) =det(M) - k *(trace(M)^2);
    end
end

Max=max(process(:));
t=Max*0.01;
process=padarray(process,[1 1],'both');

for i=2:row+1
    for j=2:col+1
        if process(i,j)<t
            process(i,j)=0;
        end
    end
end

for i=2:row+1
    for j=2:col+1
        if process(i,j)~=0
            neighbors=get_neighbors(process,i,j);
            if process(i,j)<max(neighbors(:))
                process(i,j)=0;
            end
        end
    end
end

response=process(2:row+1,2:col+1);
response(1:border,:)=0;
response(:,1:border)=0;
response(row-border+1:row,:)=0;
response(:,col-border+1:col)=0;

response(response~=0)=1;
end

function neighbors=get_neighbors(m,x,y)
neighbors =[m(x-1,y-1),m(x-1,y),m(x-1,y+1),m(x,y-1),
    m(x,y+1),m(x+1,y-1),m(x+1,y),m(x+1,y+1)];
end

