function feature = HOG_descriptor(patch,patch_size )
[m n]=size(patch);
patch=sqrt(patch);    

%Çó±ßÔµ
fy=[-1 0 1];        
fx=fy';             
Iy=imfilter(patch,fy,'replicate');   
Ix=imfilter(patch,fx,'replicate');    
Ied=sqrt(Ix.^2+Iy.^2);              
Iphase=Iy./Ix;              

%Çócell
step=patch_size/2;    
orient=9;               
range=360/orient;      
Cell=cell(2,2);            
jj=1;
for i=1:step:m         
    ii=1;
    for j=1:step:n     
        tmpx=Ix(i:i+step-1,j:j+step-1); 
        tmped=Ied(i:i+step-1,j:j+step-1);
        tmped=tmped/sum(sum(tmped));   
        tmpphase=Iphase(i:i+step-1,j:j+step-1);
        Hist=zeros(1,orient);
        for p=1:step
            for q=1:step
                if isnan(tmpphase(p,q))==1  
                    tmpphase(p,q)=0;
                end
                ang=atan(tmpphase(p,q));    
                ang=mod(ang*180/pi,360);    
                if tmpx(p,q)<0             
                    if ang<90               
                        ang=ang+180;       
                    end
                    if ang>270              
                        ang=ang-180;       
                    end
                end
                ang=ang+0.0000001;          
                Hist(ceil(ang/range))=Hist(ceil(ang/range))+tmped(p,q);
            end
        end
        Hist=Hist/sum(Hist);   
        Cell{ii,jj}=Hist;       
        ii=ii+1;                
    end
    jj=jj+1;                   
end


feature=[Cell{1,1}(:)', Cell{1,2}(:)',  Cell{2,1}(:)',  Cell{2,1}(:)'];

end

