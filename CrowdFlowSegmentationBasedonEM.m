clc;
close all;
clear all;

mvx = load('mvx_eff2.mat');
mvy = load('mvy_eff2.mat');
 
mvx=mvx.mvx_eff2;
mvy=mvy.mvy_eff2;
figure(1),quiver(squeeze(mvx),squeeze(mvy),0); 
axis ij; 

max_mvx = max(mvx(:));
max_mvy = max(mvy(:));

min_mvx = min(mvx(:));
min_mvy = min(mvy(:));

if (max_mvx-min_mvx == 0)
    mvx = mvx*0;
else
    mvx = (2*(mvx-min_mvx)/(max_mvx-min_mvx))-1;
end
if (max_mvy-min_mvy == 0)
    mvy = mvy*0;
else
    mvy = (2*(mvy-min_mvy)/(max_mvy-min_mvy))-1;
end

mvx_d=mvx(:);
mvy_d=mvy(:);

dataPoints = [mvx_d mvy_d];

[nor noc] = size(mvx);

noModels = 4;
noDim = 2;
noData = nor*noc;

modelParams = [0.0001 0.0034; -0.0496 0.3483; -0.5456 0.6375; 0.5578 -0.4323];
modelParams
resid = zeros(noModels, noData);
weightEM = zeros(noModels, noData);
for iter = 1:5
    iter
    %%%% E Step
    for i=1:noData
        for j=1:noModels
            resid(j,i) = ((modelParams(j,1)- dataPoints(i,1))^2)+((modelParams(j,2)- dataPoints(i,2))^2);
        end
        denom = 0;
        for j=1:noModels
            denom = denom + exp((-1*resid(j,i)*resid(j,i))/0.01);
        end
        if(denom == 0)
            denom = 1;
        end
        for j=1:noModels
            weightEM(j,i) = exp((-1*resid(j,i)*resid(j,i))/0.01) / denom;
        end
    end
    
    %%%% M Step
    for j=1:noModels
        a1 = 0; a2 = 0; a3 = 0; a4 = 0; a5 = 0; a6 = 0;
        for i=1:noData
            a1 = a1 + weightEM(j,i);
            a2 = 0;
            a3 = 0;
            a4 = a1;
            a5 = a5 + (weightEM(j,i)*dataPoints(i,1));
            a6 = a6 + (weightEM(j,i)*dataPoints(i,2));
        end
        A=[a1 a2; a3 a4];
        B=[a5; a6];
        modelParams(j,:)= linsolve(A,B);
    end
    modelParams
end

contourPoints = zeros(noData,1);

for j=1:noData
    resScoreP = zeros(noModels, 1);
    weightEM = zeros(noModels, 1);
	for k=1:noModels
		resScoreP(k) = (modelParams(k,1)- dataPoints(j,1))^2+(modelParams(k,2)- dataPoints(j,2))^2;
    end
    denom = 0;
    for k=1:noModels
        denom = denom + exp((-1*resScoreP(k)*resScoreP(k))/0.01);
    end
    for k=1:noModels
        weightEM(k) = exp((-1*resScoreP(k)*resScoreP(k))/0.01) / denom;
    end
    [tempVal contourPoints(j) ] = max(weightEM);
end
final=zeros(size(mvx,1),size(mvx,2));
for k=1:noData
    final(k) = contourPoints(k);
end

%%%%%%%%%%%%%for merging%%%%%%%%%%%%%%%%%%%%%%%
angle=atan2(mvy,mvx)*(180/pi);
angle_eff_3=[];
angle_eff_2=[];

for i=2:size(final,1)-1
    for j=2:size(final,2)-1
		if(final(i,j)==3)
			if(final(i-1,j-1)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i-1,j)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i-1,j+1)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i,j-1)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i,j+1)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i+1,j-1)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i+1,j)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			elseif(final(i-1,j+1)==2)
				angle_eff_3=[angle_eff_3 angle(i,j)];
			end
			
		elseif(final(i,j)==2)
			if(final(i-1,j-1)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i-1,j)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i-1,j+1)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i,j-1)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i,j+1)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i+1,j-1)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i+1,j)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			elseif(final(i-1,j+1)==3)
				angle_eff_2=[angle_eff_2 angle(i,j)];
			end        
		end
    end
end

EDGES=-179:1:180;
A = histc((angle_eff_2+2),EDGES);
B = histc(angle_eff_3,EDGES);

x=A./size(angle_eff_2,2);
y=B./size(angle_eff_3,2);
sum=0;
for i=1:size(x,2)
    sum=sum + sqrt(x(i)*y(i))
end