clear all;
clc
NUMBER_OF_GROUPS = 11;
TEST_CASE_COUNT = 5000;
TRAINING_COUNT = 20000;
indata=load('finalNumericFile');
inlabel=load('groupedClasses');
inlabel(inlabel<1)=-1;
joinarray = [indata, inlabel];
shufarray = joinarray(randperm(size(joinarray,1)),:);
% shufarray = joinarray;

fulldata = shufarray(:,(1:size(indata,2)));
fulllabel = shufarray(:,(size(indata,2)+1:end));
clear joinarray;
clear shufarray;
clear indata;
clear inlabel;

data = fulldata(1:TRAINING_COUNT,:);
label = fulllabel(1:TRAINING_COUNT,:);

data = -(data.*data);

svmStruct1=svmtrain(data,label(:,1),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct2=svmtrain(data,label(:,2),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct3=svmtrain(data,label(:,3),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct4=svmtrain(data,label(:,4),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct5=svmtrain(data,label(:,5),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct6=svmtrain(data,label(:,6),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct7=svmtrain(data,label(:,7),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct8=svmtrain(data,label(:,8),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct9=svmtrain(data,label(:,9),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct10=svmtrain(data,label(:,10),'method','SMO','autoscale','true','kernel_function','rbf');
svmStruct11=svmtrain(data,label(:,11),'method','SMO','autoscale','true','kernel_function','rbf');
%svmStruct12=svmtrain(data,label(:,12),'method','SMO','autoscale','true','kernel_function','rbf');

OFFSET_COUNT=50000;

testdata = fulldata(TRAINING_COUNT+OFFSET_COUNT:TRAINING_COUNT+OFFSET_COUNT+TEST_CASE_COUNT,:);
testlabel = fulllabel(TRAINING_COUNT+OFFSET_COUNT:TRAINING_COUNT+OFFSET_COUNT+TEST_CASE_COUNT,:);

testdata = -(testdata.*testdata);

tempoutputarray=zeros(NUMBER_OF_GROUPS,max(size(testdata)));

tempoutputarray(1,:)=svmclassify(svmStruct1,testdata);
tempoutputarray(2,:)=svmclassify(svmStruct2,testdata);
tempoutputarray(3,:)=svmclassify(svmStruct3,testdata);
tempoutputarray(4,:)=svmclassify(svmStruct4,testdata);
tempoutputarray(5,:)=svmclassify(svmStruct5,testdata);
tempoutputarray(6,:)=svmclassify(svmStruct6,testdata);
tempoutputarray(7,:)=svmclassify(svmStruct7,testdata);
tempoutputarray(8,:)=svmclassify(svmStruct8,testdata);
tempoutputarray(9,:)=svmclassify(svmStruct9,testdata);
tempoutputarray(10,:)=svmclassify(svmStruct10,testdata);
tempoutputarray(11,:)=svmclassify(svmStruct11,testdata);
% tempoutputarray(12,:)=svmclassify(svmStruct12,testdata);

outputarray=zeros(max(size(testdata)),1);
for i=1:max(size(testdata))
    for j=1:NUMBER_OF_GROUPS
        if(tempoutputarray(j,i)==1)
            outputarray(i,1)=j;
        end
    end
end
correctcount =0;
for i=1:max(size(testdata))
    if(outputarray(i,1)~=0)
        if(testlabel(i,outputarray(i,1))~=0)
            correctcount=correctcount+1;
        end
    end
end

Accuracy = correctcount*100/TEST_CASE_COUNT;
testlabel0=testlabel;
testlabel0(testlabel0<1)=0;
outlabel=zeros(size(testlabel0));
for i=1:max(size(testdata))
    if(outputarray(i,1)~=0)
        outlabel(i,outputarray(i,1))=1;
    end
end
accu=zeros(11,1);
sumt=sum(testlabel0);
sumo=sum(outlabel);
for i=1:11
    accu(i,1)=(sumo(i)*100)/(sumt(i));
end