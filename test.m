x=0.0001:0.0001:1;
y=x./((log(2)*(1+x)));
y2=log2(1+x);
plot(x,y2,'r')
hold on;
plot(x,y,'b')