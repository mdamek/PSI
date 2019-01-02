close all; clear all; clc;

input = iris_dataset; %Standardowe dane wejsciowe dostarczane przez Matlab
% I i II kolumna dane o d�ugo�ci i szeroko�ci dzia�ki kielicha, 
% III i IV kolumna dlugosc i szerokosc p�atka
plot(input(1, :) ,input(2, :), 'r.', input(3, :), input(4, :), 'g.');
hold on; grid on; 

dimensions = [10 10]; % wymiary wektora  
coverstep = 100; %etapy szkolenia w celu pokrycia przestrzeni wej�ciowej
initNeighbor = 0; % wej�ciowy rozmiar s�siedztwa
topologyFcn = 'hextop'; %ksztalt funkcji topologicznej
distanceFcn = 'dist'; %odleglosc miedzy neuronami

net = selforgmap(dimensions, coverstep, initNeighbor, topologyFcn, distanceFcn); %tworzenie mapy samoorganizacji 
net.trainFcn = 'trainbu'; %uczenie bez nauczyciela
net.trainParam.epochs = 600;
net.trainParam.lr = 0.8; %wsp�czynnik uczenia
[net, tr] = train(net, input); %trening 
y = net(input); %testowanie