function H = fit_affine_matrix( p1,p2)
H=p1\p2;
H(:,3)=[0 0 1];
end

