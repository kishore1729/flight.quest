clear
clc
hidden = 11;
correctcount = zeros(100,1);
for epoch = 1:100
    X = rand(100,1);
    Y = rand(100,1);
    B = ones(100,1);
    a = 0.5; b = 0.6; r = 0.4;
    % (x-a)^2 + (y-b)^2 < r^2
    label = ((((X-a).^2 + (Y-b).^2 < r.^2).*2)-1);
    
    w = rand(hidden,4);
    for multi=1:100
        for i=1:100
            wsum = w(:,1).*B(i,1)+w(:,2).*X(i,1)+w(:,3).*Y(i,1);
            h = (1 - exp(-1.*wsum))./(1 + exp(-1.*wsum));
            output = (1 - exp(-1.*(h'*w(:,4))))./(1 + exp(-1.*h'*w(:,4)));
            if (output > 0 && label(i,1) < 0) || (output < 0 && label(i,1) > 0)
                update_out=(label(i,1)-output)*(1-output)*(1+output)/2;
                w(:,4) = w(:,4) + update_out*h;
                update_hid = update_out*(1-h).*(1+h)/2;
                w(:,3) = w(:,3) + update_hid*Y(i,1);
                w(:,2) = w(:,2) + update_hid*X(i,1);
                w(:,1) = w(:,1) + update_hid*B(i,1);
            end
        end
    end
    
    %testing
    testX = rand(100,1);
    testY = rand(100,1);
    testlabel = ((((testX-a).^2 + (testY-b).^2 < r.^2).*2)-1);
    testoutput = zeros(100,1);
    for i=1:100
        h = w(:,1)+w(:,2).*testX(i,1)+w(:,3).*testY(i,1);
        output = (1 - exp(-1.*(h'*w(:,4))))./(1 + exp(-1.*h'*w(:,4)));
        if output > 0
            testoutput(i,1) = 1;
        else
            testoutput(i,1) = -1;
        end
    end

    for i=1:100
        if testoutput(i,1)==testlabel(i,1)
            correctcount(epoch,1) = correctcount(epoch,1) + 1;
        end
    end
end