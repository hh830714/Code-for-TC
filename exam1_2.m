%%This file is to simulate the Example 1 under ETM (53) and (54).%%%
clear;clc
x_0=2;%%%%%%%%initial state
h=0.001;%%%%%%%%%%%step=h
x_result=x_0;
xmid=x_0;
t_k=0;%%%%%%%%initial instant
x_k=2;
T_k2=[];%%%%%%%%%record event-triggering instants
delta=0.19;%%%%%%%%%sampling interval
k=1;
tend=40;%%%%%%%%%%%The lifespan of system
t_delta=delta;
x_delta=x_0;
t_result=0:h:tend;
for t=h:h:tend
    xmid=xmid+cos(t)*xmid*h+0.3*xmid*randn*sqrt(h);%%%%%%%%%system dynamics 
    if  abs(t-t_delta)<=0.0001%%%%%%%%判断t是否等于t_delta不能直接用==
        k=k+1;
        t_delta=k*delta;
        x_delta=xmid;
        if (t-t_k>=0.19&&x_delta'*x_delta>=exp(0.4)*x_k'*x_k)||t-t_k>=50*delta%%%%%%%%%%%%%%%checK ETM
            t_k=t;
            T_k2=[T_k2;t_k];
            xmid=exp(-0.9)*xmid;
            x_k=xmid;
        end
    end
    x_result=[x_result,xmid];
end
plot(t_result,x_result,'-r','linewidth',1.2);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_0=2;
x_result=x_0;
xmid=x_0;
t_k=0;
x_k=2;
T_k1=[];
k=1;
t_delta=delta;
x_delta=x_0;
for t=h:h:tend
    xmid=xmid+cos(t)*xmid*h+0.3*xmid*randn*sqrt(h);
    if  abs(t-t_delta)<=0.0001
        k=k+1;
        t_delta=k*delta;
        x_delta=xmid;
        if  t-t_k>=0.19&&x_delta'*x_delta>=exp(0.4)*x_k'*x_k
            t_k=t;
            T_k1=[T_k1;t_k];
            xmid=exp(-0.9)*xmid;
            x_k=xmid;
        end
    end
    x_result=[x_result,xmid];
end
plot(t_result,x_result,'-b','linewidth',1.2);
hold on
%%%%%%%%%%%%%%%%%%%%%%%
xlabel('$t$','Interpreter','latex','FontSize',14,'FontWeight','bold');
ylabel('$x(t)$','Interpreter','latex','FontSize',14,'FontWeight','bold'); 
%%%%%%%%%%%%%%%%%%%%%%%%
y2=2*ones(1,length(T_k2));
plot(T_k2,y2,'r.','linewidth',1)
hold on
y1=ones(1,length(T_k1));
plot(T_k1,y1,'b*','linewidth',0.8)
hold on
legend({'$x(t)~in~ETM~(53)$','$x(t)~in~ETM~(54)$','$\zeta_k~in~ETM~(53)$','$\zeta_k~in~ETM~(54)$'},'Interpreter','latex','FontSize',12,'FontWeight','bold'); 