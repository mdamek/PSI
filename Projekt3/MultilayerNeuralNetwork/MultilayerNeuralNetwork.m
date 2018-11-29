

dataIn = [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2];
dataOut = [1.6633e+03, 1.6800e+03, 1.7329e+03, 1.7820e+03, 0, 1.9484e+03, 2.0655e+03, 2.1782e+03, 2.3262e+03];

testowe = zeros(1);

network = feedforwardnet(2); 
network.trainFcn = 'traingd';
network.trainParam.lr = 0.01; 
network.trainParam.mc = 1;
network = train(network, dataIn, dataOut);
wyniki = zeros(size(network));

for i = 1:9
    testowe(i) = Rastrigin(dataIn(i)); 
    wyniki(i) = sim(network, dataIn(i));
    
end  


function fx = Rastrigin(x)
    if x == 0
        fx = 0;
    else
        A = 10;
        n = 100;
        x1 = x;
        dx = (5.12-x)/n;
        fx = A * n;
        for i = 1:n
            x = x1 + (i * dx);
            fx = fx + (x^2) - (A * cos(2 * pi * x));
        end
    end
end