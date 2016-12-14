function [data] = generate_data(age_min,age_max,size_of_data)
% the function generates two data streams data1 and data2 which differ at most one record
u = randi([age_min age_max], size_of_data, 1);
v = randi([0 1], size_of_data, 1);
data = [u,v];
end

