clear all; close all; clc;

start = [0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
         0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;];
     
ilosc_wyjsc = 64;

net = newff(start, ilosc_wyjsc, {'tansig'}, 'trainlm', 'learnh');
   
 wejscie = [ 0 0 0 0;
             0 0 0 0;
             1 1 1 1;
             1 1 1 1;
             1 1 1 1;
             1 1 1 1;
             0 0 0 0;
             0 0 0 0;
             0 0 0 0;
             1 1 1 1;
             0 0 0 0;
             0 0 0 0;
             0 0 0 0;
             0 0 0 0;
             1 1 1 1;
             0 0 0 0;
             1 1 1 1;
             0 0 1 0;
             1 1 1 1;
             0 0 0 0;
             0 0 0 0;
             1 1 1 1;
             0 0 1 0;
             1 1 1 1;
             1 1 1 1;
             0 0 0 0;
             0 0 1 0;
             0 0 0 0;
             0 0 0 0;
             0 0 1 0;
             0 0 0 0;
             1 1 1 1;
             1 1 1 1;
             0 0 0 0;
             1 0 1 1;
             0 1 0 1;
             0 1 0 1;
             1 0 1 1;
             0 0 0 0;
             1 1 1 1;
             1 1 1 1;
             0 0 0 0;
             0 1 1 0;
             1 0 0 1;
             1 0 0 1;
             0 1 1 0;
             0 0 0 0;
             1 1 1 1;
             0 0 0 0;
             1 1 1 1;
             0 0 0 0;
             0 0 1 0;
             0 0 1 0;
             0 0 0 0;
             1 1 1 1;
             0 0 0 0;
             0 0 0 0;
             0 0 0 0;
             1 1 1 1;
             1 1 1 1;
             1 1 1 1;
             1 1 1 1;
             0 0 0 0;
             0 0 0 0;];
             
                   
 wyjscie = [ 1 0 0 0;
             0 1 0 0;
             0 0 1 0;
             0 0 0 1;];
             
           
 lp.dr = 0.7;
 lp.lr = 0.7;
 
 wagiHebba = learnh(0, wejscie, 0, 0, wyjscie, 0, 0, 0, 0, 0, lp, 0);
 
 
 net.trainParam.epochs = 1000;
 net.trainParam.goal = 0.01;
 abc = wagiHebba';
 net = train(net, wejscie, abc);
 
  usmiechTestowy = [0 0 1 1 1 1 0 0;
                    0 1 0 0 0 0 1 0;
                    1 0 1 0 0 1 0 1;
                    1 0 0 0 0 0 0 1;
                    1 0 1 0 0 1 0 1;
                    1 0 0 1 1 0 0 1;
                    0 1 0 0 0 0 1 0;
                    0 0 1 1 1 1 0 0;];

smutekTestowy =[0 0 1 1 1 1 0 0;
                0 1 0 0 0 0 1 0;
                1 0 1 0 0 1 0 1;
                1 0 0 0 0 0 0 1;
                1 0 0 1 1 0 0 1;
                1 0 1 0 0 1 0 1;
                0 1 0 0 0 0 1 0;
                0 0 1 1 1 1 0 0;];

placzTestowy = [0 0 1 1 1 1 0 0;
                0 1 0 0 0 0 1 0;
                1 1 1 0 0 1 1 1;
                1 0 1 0 0 1 0 1;
                1 0 1 0 0 1 0 1;
                1 0 1 0 0 1 0 1;
                0 1 0 1 1 0 1 0;
                0 0 1 1 1 1 0 0;];

duzyUsmiechTestowy=[0 0 1 1 1 1 0 0;
                    0 1 0 0 0 0 1 0;
                    1 0 1 0 0 1 0 1;
                    1 0 0 0 0 0 0 1;
                    1 0 1 1 1 1 0 1;
                    1 0 0 1 1 0 0 1;
                    0 1 0 0 0 0 1 0;
                    0 0 1 1 1 1 0 0;];
 
 efektHebba = wagiHebba;
 wynikUsmiech = sim(net, usmiechTestowy);
 wynikSmutek = sim(net, smutekTestowy);
 wynikPlacz = sim(net, placzTestowy);
 wynikDuzyUsmiech = sim(net, duzyUsmiechTestowy);
 
 disp('Usmiech: '), disp(wynikUsmiech(1));
 disp('Smutek: '), disp(wynikSmutek(1));
 disp('Placz: '), disp(wynikPlacz(1));
 disp('Duzy Usmiech: '), disp(wynikDuzyUsmiech(1));
 
 