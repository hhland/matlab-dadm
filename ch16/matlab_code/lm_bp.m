function[ppre] = lm_bp()
p = [-1 -1 2 2;0 5 0 5];
t = [-1 -1 1 1];
net = newff(p,t,3,{},'trainlm');
net.trainParam.show = 50; 
net.trainParam.lr = 0.05; 
net.trainParam.mc = 0.9; 
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-3; 
net.trainParam.showWindow = false;
net = init(net);

net = train(net,p,t);
y = sim(net,p);
ppre = y

end
