function [res] = dp_average_query(data,original_data,epsilon)
% function to compute the average age of diabetic patients with
% differential privacy mechanism
% Here data is the input dataset
res = 0;
k = 0;
for i = 1:1:length(data)
    if (data(i,2) == 1)
        res = res + data(i,1);
        k = k + 1;
    end
end
res = (res/k) + laplace_noise(original_data,epsilon);
end

