clear all;
clc;
% This script shows the effect of using differential privacy.
age_min = 21; % minimum age of the patients
age_max = 70; % maximum age of the patients
size_of_data = 1000; % total no. of patients
epsilon = 2; 

% Generating an original data-set
original_data = generate_data(age_min,age_max,size_of_data);

% Generating data-set 1 which adds 1 additional diabetic patient to the original data-set
data1 = [original_data;randi([age_min age_max],1,1),1];

% Generating data-set 2 which adds 1 additional non-diabetic patient to the original data-set
data2 = [original_data;randi([age_min age_max],1,1),0];

% Generating data-set 3 which removes 1 diabetic patient from the original data-set
for i = 1:1:length(original_data)
    if original_data(i,2) == 1
        break;
    end
end
if i > 1
    data3 = [original_data(1:i-1,1:2);original_data(i+1:end,1:2)];
else
    data3 = original_data(2:end,1:2);
end

% Generating data-set 4 which removes 1 non-diabetic patient from the orginal data-set
for j = 1:1:length(original_data)
    if original_data(j,2) == 0
        break;
    end
end
if j > 1
    data4 = [original_data(1:j-1,1:2);original_data(j+1:end,1:2)];
else
    data4 = original_data(2:end,1:2);
end

% Normal query-results
res_original = average_query(original_data);
res_data1 = average_query(data1);
res_data2 = average_query(data2);
res_data3 = average_query(data3);
res_data4 = average_query(data4);

% Differential privacy mechanism results - 1
dp_res_original = dp_average_query(original_data,original_data,epsilon);
dp_res_data1 = dp_average_query(data1,original_data,epsilon);
dp_res_data2 = dp_average_query(data2,original_data,epsilon);
dp_res_data3 = dp_average_query(data3,original_data,epsilon);
dp_res_data4 = dp_average_query(data4,original_data,epsilon);

% Differential privacy mechanism results - 2
dp_res2_original = dp_average_query(original_data,original_data,epsilon);
dp_res2_data1 = dp_average_query(data1,original_data,epsilon);
dp_res2_data2 = dp_average_query(data2,original_data,epsilon);
dp_res2_data3 = dp_average_query(data3,original_data,epsilon);
dp_res2_data4 = dp_average_query(data4,original_data,epsilon);

Y = [res_original,res_data1,res_data2,res_data3,res_data4];
Z = [dp_res_original,dp_res_data1,dp_res_data2,dp_res_data3,dp_res_data4];
W = [dp_res2_original,dp_res2_data1,dp_res2_data2,dp_res2_data3,dp_res2_data4];

epsilon1 = 0.1;
epsilon2 = 1;
epsilon3 = 10;

% Differential privacy mechanism results with epsilon = 0.1
dp_res3_original = dp_average_query(original_data,original_data,epsilon1);
dp_res3_data1 = dp_average_query(data1,original_data,epsilon1);
dp_res3_data2 = dp_average_query(data2,original_data,epsilon1);
dp_res3_data3 = dp_average_query(data3,original_data,epsilon1);
dp_res3_data4 = dp_average_query(data4,original_data,epsilon1);

% Differential privacy mechanism results with epsilon = 1
dp_res4_original = dp_average_query(original_data,original_data,epsilon2);
dp_res4_data1 = dp_average_query(data1,original_data,epsilon2);
dp_res4_data2 = dp_average_query(data2,original_data,epsilon2);
dp_res4_data3 = dp_average_query(data3,original_data,epsilon2);
dp_res4_data4 = dp_average_query(data4,original_data,epsilon2);

% Differential privacy mechanism results with epsilon = 10
dp_res5_original = dp_average_query(original_data,original_data,epsilon3);
dp_res5_data1 = dp_average_query(data1,original_data,epsilon3);
dp_res5_data2 = dp_average_query(data2,original_data,epsilon3);
dp_res5_data3 = dp_average_query(data3,original_data,epsilon3);
dp_res5_data4 = dp_average_query(data4,original_data,epsilon3);

X1 = [dp_res3_original,dp_res3_data1,dp_res3_data2,dp_res3_data3,dp_res3_data4];
X2 = [dp_res4_original,dp_res4_data1,dp_res4_data2,dp_res4_data3,dp_res4_data4];
X3 = [dp_res5_original,dp_res5_data1,dp_res5_data2,dp_res5_data3,dp_res5_data4];

% Generating the plots
x = [0,1,2,3,4,5,6];
ticks = {'-';'Original data-set';'Data-set1';'Data-set2';'Data-set3';'Data-set4';'-'};
figure;
title('Query response without using differential privacy');
plot(Y,'d', 'linewidth',2);
grid on;
axis([0,6, min(Y)-0.1, max(Y)+0.1]);
xlabel('datasets');
ylabel('Average age');
set(gca,'XTick',x);
set(gca,'XTickLabel',ticks);
legend('Query response without differential privacy');

figure;
plot(Z,'d', 'linewidth',2);
hold on;
plot(W,'dr', 'linewidth',2);
grid on;
axis([0,6,min(min(Z),min(W))-0.1,max(max(Z),max(W))+0.1]);
xlabel('datasets');
ylabel('Average age');
set(gca,'XTick',x);
set(gca,'XTickLabel',ticks);
legend('First time Query response with differential privacy','Second time Query response with differential privacy');
hold off;

figure;
plot(Y,'d', 'linewidth',2);
grid on;
hold on;
plot(X1,'dg', 'linewidth',2);
plot(X2,'dr', 'linewidth',2);
plot(X3,'dk', 'linewidth',2);
axis([0,6,min(min(min(Y),min(X1)),min(min(X2),min(X3)))-0.1, max(max(max(Y),max(X1)),max(max(X2),max(X3)))+0.1]);
xlabel('dataset');
ylabel('Average age');
set(gca,'XTick',x);
set(gca,'XTickLabel',ticks);
legend('Query response without differential privacy','Query response with differential privacy epsilon = 0.1','Query response with differential privacy epsilon = 1','Query response with differential privacy epsilon = 10');
hold off;

x = 1:1000;
X = original_data;
class1 = X(:,2) == 1;
figure;
scatter(x(class1),X(class1,1), 'rx', 'linewidth',2);
hold on;
scatter(x(~class1),X(~class1,1), 'bo', 'linewidth',2);
grid on;
axis([0 1001 15 85]);
xlabel('Patients');
ylabel('Age of patients');
legend('Patients having type-2 diabetes','Normal patients');
hold off;