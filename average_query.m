function [res] = average_query(data)
% function to compute the average age of patients 
% having type-2 diabetes without differential pri-
% vacy mechanism.

% data is the input dataset
res = 0;
k = 0;
for i = 1:1:length(data)
    if (data(i,2) == 1)
        res = res + data(i,1);
        k = k + 1;
    end
end
res = res/k;
end

