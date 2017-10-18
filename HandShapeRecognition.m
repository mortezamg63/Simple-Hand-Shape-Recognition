function HandShapeRecognition()
mainimage=imread('D:\morteza private\Downloads\Computer Vision\images\newimage\7.jpg');
filt=fspecial('average',[3 3]);
mainimage=imfilter(mainimage,filt);in image. The code is implemented in Matlab program.
[rows,cols,height]=size(mainimage);
i=double(mainimage);
r=i(:,:,1);
g=i(:,:,2);
b=i(:,:,3);
[m n] = size( r );
temp1=ones(m,n);
temp2=zeros(m,n);
for x=1:m
    for y=1:n
      normR(x,y)=(r(x,y)/(r(x,y)+g(x,y)+b(x,y)))*255;%normR=r./(r+g+b).*255;
      normG(x,y)=(g(x,y)/(r(x,y)+g(x,y)+b(x,y)))*255;%normG=g./(r+g+b).*255;
     
      if ((93.0<normR(x,y)&&(normR(x,y)<145.0)&& (60.0<normG(x,y))&& ...
      (normG(x,y)<100.0)))
         temp2(x,y)=1;%i(x,y); 
      end
    end
end
newimage=temp2;
subplot(2,2,1);imshow(mainimage);title('(1) main image');
subplot(2,2,2);imshow(newimage);title(' (2) binary image');
%------- main computations -------------------------
N=0;
Xg=0;
Yg=0;
for i=1:rows
    for j=1:cols
        if(newimage(i,j)==1)
            N=N+1;
            Xg=Xg+i;
            Yg=Yg+j;            
        end
    end
end
Xg=Xg/N;
Yg=Yg/N;
mainimage(Xg-5:Xg+5,Yg-5:Yg+5)=0;
subplot(3,2,4);
imshow(mainimage);xlabel('(3) show center of gravity in main image');
[M02,M11,M20]=Mpq(Xg,Yg,rows,cols,newimage);
teta_angle=atand((2*round(M11))/(round(M20)-round(M02)))/2;
 
disp(teta_angle);
subplot(3,2,5);
edgeimage=edge(newimage);
imshow(edgeimage);xlabel('(5) edge extracted from binary image');
cuted_edgeimage=edgeimage(1:round(Xg),:);
[crows,ccols]=size(cuted_edgeimage);
%------ obtain fingertips  ---------------
 
Dreg=zeros(1,5);
index=2;
dmax=0;
maxPos=[0;0];
maxPosreg=[crows;1];
interval=0;
isFalling=false;
dprev=0;
 
isfirst=0;% check for first pixel with value==1
for jcol=1:ccols
  
    irow=1;
    
    while(cuted_edgeimage(irow,jcol)==0 && irow<crows)
    
        irow=irow+1;
        
    end
    
    if(irow<crows || size(maxPosreg,2)<2)
    
        isfirst=1;                
        X=[irow-Xg; jcol-Yg];
        d=X'*X;        
        
        if(d>=dmax)
            
            dmax=d;            
            maxPos=[irow;jcol];
            interval = 0;
            dprev=d;
            isFalling=false;
            
        else if(interval>=10 && isFalling)
            
            if((maxPos(1)~=maxPosreg(1,index-1) || maxPos(2)~=maxPosreg(2,index-1)) && (dmax>30000))               
                
                Dreg(index-1)=dmax;
                maxPosreg=[maxPosreg maxPos];
                index=index+1;    
                interval=0;
                
            end
            
            dmax=d;   
            dprev=d;
            
            else
                
                if (d<dprev)
                
                    isFalling=true;
                    
                else
                    
                    isFalling=false;
                    
                end
                
                dprev=d;
                interval=interval+1;
                
            end
        end
    else if(isfirst)
            
            if(interval>1 && dmax>30000 &&(maxPos(1)~=maxPosreg(1,index-1) || maxPos(2)~=maxPosreg(2,index-1)))
            
                Dreg(index-1)=dmax;
                maxPosreg=[maxPosreg maxPos];
                
            end
            break;
        end     
        
    end
    close
end
 
c=size(maxPosreg,2);
temp=cuted_edgeimage;
 
for k=1:c
    
    temp(maxPosreg(1,k):maxPosreg(1,k)+5,maxPosreg(2,k):maxPosreg(2,k)+5)=1;
    
end
 
temp(Xg-5:Xg,Yg-5:Yg)=1; %fill COG with a Rectangle 5x5
figure;imshow(temp);
 
%%
 
[x,y]=size(maxPosreg);
 
for i=1:y
    
    line([maxPosreg(2,i) Yg],[maxPosreg(1,i) Xg],'Marker','.','LineStyle','-');   
    slope(i)=(maxPosreg(2,i)-Yg)/(maxPosreg(1,i)-Xg);
    
end
%------- compute angle between lines  -----
sizeSlope=size(maxPosreg,2);
 
if(sizeSlope>1)
   
    for i=2:sizeSlope
 
        teta(i-1)=atand((slope(i-1)-slope(i))/(1+(slope(i-1)*slope(i))));
 
    end
    
end
switch(sizeSlope-1)
    
    case 1
        % -------------------------------------
        msgbox('type1');
        % -------------------------------------
        
    case 2
       % -------------------------------------
        for i=2:sizeSlope%2:sizeSlope
            teta(i-1)=atand((slope(i-1)-slope(i))/(1+(slope(i-1)*slope(i))));        
        end
        if(teta(2)>36)
            msgbox('type 6');
        else
            msgbox('type 2');
        end
        %--------------------------------------
        
    case 3
        % -------------------------------------        
        for i=2:sizeSlope
            
            teta(i-1)=atand((slope(i-1)-slope(i))/(1+(slope(i-1)*slope(i))));        
        
        end
        if(teta(2)>36)
        
            msgbox('type 7');
        
        else
            
            msgbox('type 3');
       
        end
        % -------------------------------------
        
    case 4
        % -------------------------------------
        msgbox('type 4');
        % -------------------------------------
    
    case 5
        % -------------------------------------
        msgbox('type 5');
        % -------------------------------------
end
 
msgbox(num2str(teta_angle));
 
end
 
 
function [M02,M11,M20]=Mpq(Xg,Yg,rows,cols,newimage)
m11=0;m20=0;m02=0;
for x=1:rows
    for y=1:cols
        if(newimage(x,y)==1)
            m11=m11+(x-Xg)*(y-Yg);
            m20=m20+((x-Xg)^2);
            m02=m02+((y-Yg)^2);
        end
    end    
end
M11=m11;
M02=m02;
M20=m20;
end