x=1:1:iter_num;
y=U_map;
plot(x,y,'r-')
axis([0 iter_num 1.1 1.3])
grid on;
xlabel('Step')
ylabel('Reward')
legend('with varying epsilon')