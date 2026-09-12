% Clustering with k-means

% Load the data
data = load("data/iris.txt");

X = data(:, 1:4);
y = data(:, 5);

k = 3;
max_iter = 15;


function j = compute_j(X, c, z) 
  n = size(X, 1);
  j = 0;
  for i = 1:n
    c_i = c(i, :);
    x_i = X(i, :)';
    z_j = z(c_i, :)';
    j = j + ((x_i - z_j)' * (x_i - z_j));
  endfor
endfunction


function z = init_random_z (X, k)
  n = size(X, 1);
  z = zeros(k, size(X, 2));
  for i = 1:k
    random_i = randi(n);
    z(i, :) = X(random_i, :);
  endfor
endfunction


function d = square_dist (a, b)
  d = ((a-b)'*(a-b));
endfunction


function new_c = assign_class (X, z)
  n = size(X, 1);
  k = size(z, 1);
  new_c = ones(n, 1);

  for i = 1:n
    dist = zeros(k, 1);  % distances from the ith vector to the centroids
    x_i = X(i, :)';

    for j = 1:k
      z_j = z(j, :)';
      dist(j, 1) = square_dist(x_i, z_j);
    endfor

    [~, min_i] = min(dist);
    new_c(i, 1) = min_i;
  endfor
endfunction


function z = update_centroids(X, c, k)
  z = init_random_z(X, k);
  for j = 1:k
    x = X(c == j, :);
    if (size(x, 1) > 0)
      z(j, :) = mean(x);
    endif
  endfor
endfunction


function [y_hat, j_history] = kmeans(X, k, max_iter)
  n = size(X, 1);

  z = init_random_z(X, k);
  c = ones(n, 1);

  y_hat = c;
  j_history = zeros(max_iter, 2);

  for i = 1:max_iter
    c = assign_class(X, z);
    z = update_centroids(X, c, k);
    j_history(i, :) = [i, compute_j(X, c, z)];
  endfor

  y_hat = c;
endfunction


[y_hat, j_history] = kmeans(X, k, max_iter);


dlmwrite("data/outputs/classified.dat", [data, y_hat], "delimiter", " ", "precision", "%.3f");
dlmwrite("data/outputs/j_history.dat", j_history, "delimiter", " ", "precision", '%.3f');
