close all; clear all; clc;

input = iris_dataset; %Standardowe dane wejsciowe dostarczane przez Matlab
% I i II kolumna dane o d³ugoœci i szerokoœci dzia³ki kielicha, 
% III i IV kolumna dlugosc i szerokosc p³atka
plot(input(1, :) ,input(2, :), 'r.', input(3, :), input(4, :), 'g.');
hold on; grid on; 

dimensions = [10 10]; % wymiary wektora  
coverstep = 100; %etapy szkolenia w celu pokrycia przestrzeni wejœciowej
initNeighbor = 0; % wejœciowy rozmiar s¹siedztwa
topologyFcn = 'hextop'; %ksztalt funkcji topologicznej
distanceFcn = 'dist'; %odleglosc miedzy neuronami

net = selforgmap(dimensions, coverstep, initNeighbor, topologyFcn, distanceFcn); %tworzenie mapy samoorganizacji 
net.trainFcn = 'trainbu'; %uczenie bez nauczyciela
net.trainParam.epochs = 600;
net.trainParam.lr = 0.8; %wspó³czynnik uczenia
[net, tr] = train(net, input); %trening 
y = net(input); %testowanie