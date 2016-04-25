% Function to limit a between the positive and negative limit. 
function a = lim(a,limit)
    if a > (limit)
        a = limit;
    elseif a < (-limit)
        a = -limit;
    end
end
