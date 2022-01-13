function feature = simple_descriptor( patch )
feature=[];
patch=patch';
patch=patch(:)';
    Mean = mean(patch);
    delta = std(patch); 
    if delta > 0.0
        patch = (patch - Mean) / delta; 
    else
        patch = patch - Mean;
    end
    feature = patch;
end

