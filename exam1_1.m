%%This file is to simulate the Example 1 under ETM (51) and (52).%%%
clear;clc
x_0=2;%%%%%%%%initial state
h=0.001;%%%%%%%%%%%step=h
tend=40;%%%%%%%%%%%The lifespan of system
x_result=x_0;
t_result=0:h:tend;
xmid=x_0;
t_k=0;%%%%%%%%initial instant
x_k=2;
T_k2=[];%%%%%%%%%record event-triggering instants
for t=h:h:tend
xmid=xmid+cos(t)*xmid*h+0.3*xmid*randn*sqrt(h);
 if (t-t_k>0.19&&xmid'*xmid>=exp(0.4)*x_k'*x_k)||t-t_k>=9.5
     t_k=t;
     T_k2=[T_k2;t_k];
     xmid=exp(-0.25)*xmid;
     x_k=xmid;
 end
 x_result=[x_result,xmid];
end
plot(t_result,x_result,'-r','linewidth',1.2);
xlabel('$t$','Interpreter','latex','FontSize',14,'FontWeight','bold');
ylabel('$x(t)$','Interpreter','latex','FontSize',14,'FontWeight','bold'); 
% subplot(2,1,2)
hold on
x_0=2;
x_result=x_0;
xmid=x_0;
t_k=0;
x_k=2;
T_k1=[];%%%%%%%%%record event-triggering instants
for t=h:h:tend
xmid=xmid+cos(t)*xmid*h+0.3*xmid*randn*sqrt(h);
 if t-t_k>0.19&&xmid'*xmid>=exp(0.4)*x_k'*x_k
     t_k=t;
     T_k1=[T_k1;t_k];
     xmid=exp(-0.25)*xmid;
     x_k=xmid;
 end
 x_result=[x_result,xmid];
end
plot(t_result,x_result,'-b','linewidth',1.2);
hold on
y2=2*ones(1,length(T_k2));
plot(T_k2,y2,'r.','linewidth',1)
hold on
y1=ones(1,length(T_k1));
plot(T_k1,y1,'b*','linewidth',0.8)
hold on
legend({'$x(t)~in~ETM~(51)$','$x(t)~in~ETM~(52)$','$\zeta_k~in~ETM~(51)$','$\zeta_k~in~ETM~(52)$'},'Interpreter','latex','FontSize',14,'FontWeight','bold'); 