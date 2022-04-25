m = 1;
L = 2;
g = -10;

d = 1;
init_theta = pi;

tspan = 0:.1:10;
y0 = [init_theta; .5];

%% poles
% poles = [-1.5, -4.5]; % slow
poles = [-2.5, -5.5]; % good
% poles = [-3.5, -6.5]; % good
% poles = [-7.5, -10.5]; % aggressive

Au = [0 1; -1 0];
B = [0; 1];
k = place(Au, B, poles);
fixed = [0; 0];
%%
[t,y] = ode45(@(t,y)pend_function(y,m,L,d,g, -k*(y - fixed)),tspan,y0);

figure
plot(t,y(:,1),'-r','LineWidth',1.5);
hold on
plot(t,y(:,2),'-b','LineWidth',1.5);
legend('Angle','Angular Velocity');
xlabel('Time(s)');
ylabel('Angle (Rad)');
grid on
set(gca,'GridLineStyle','--','GridAlpha',0.55, 'LineWidth',1.5, 'FontSize', 13);
hold off

% get u vector
us = [];
for i=1:length(t)
    u = -k*(y(i,:)' - fixed);
    us = [us; u];
end

figure
grid on
plot(t, us, '-r', 'LineWidth', 1.5);
grid on
set(gca,'GridLineStyle','--','GridAlpha',0.55, 'LineWidth',1.5, 'FontSize', 13);
legend('Control');
ylabel('Torque (Nm)');
xlabel('Time (s)');
hold off

figure
for ti=1:length(t)
    vis_pendulum(y(ti,:),m,L);
    if ti==1
        pause(2)
    end
end

%% integration function
function dx = pend_function(x,m,L,d,g,u)
    Sx = sin(x(1));
    dx(1,1) = x(2);
%     dx(2,1) = x(2) +  0.1*rand(1);
    dx(2,1) = -(g/L)*Sx - d*x(2) ;
end

%% visualize
function vis = vis_pendulum(state,m,L)
    th = state(1);
    mr = .3*sqrt(m);
    pendx = L*sin(th);
    pendy = L*cos(th);
    plot([0 pendx],[0 pendy],'k','LineWidth',2);
    rectangle('Position',[pendx-mr/2,pendy-mr/2,mr,mr],'Curvature',1,'FaceColor',[1 0.1 .1],'LineWidth',1.5);
    grid on
    axis([-6 6 -2 2.5]);
    axis equal
    set(gca,'GridLineStyle','--','GridAlpha',0.55, 'LineWidth',1.5, 'FontSize', 13);
    drawnow, hold off
end