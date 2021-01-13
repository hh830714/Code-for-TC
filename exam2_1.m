clear;clc
%%solve the LMI of Example 2.%%
A=[-1 -2 -2;0 -1 1;1 0 1];
sigma=0.85;
L=[1.2 0 -1.2 0 0;-1.5 1.5 0 0 0 ;0 -2 2 0 0;-1.8 0 0 1.8 0;0 0 0 0 0];
B=diag([1 0 0 0 2],0);
I5=eye(5);
lambda=2;
nu=exp(-0.21);
H=L+B;
P=sdpvar(3)
K_=sdpvar(5,1)
K=diag(K_)
LMIs=[P>=0,K>=0,P*A+A'*P+sigma^2*P-lambda*P<=0,[-nu*I5 I5-H'*K;I5-K*H -I5]<=0]; 
options=sdpsettings('solver','mosek','verbose',1); 
sol=optimize(LMIs,[],options); 
P=value(P)
K=value(K)
eig(P*A+A'*P+sigma^2*P-lambda*P)%%%%%%%verify the obtained P 
eig([-nu*I5 I5-H'*K;I5-K*H -I5])%%%%%%%%%verify the obtained K



x0_0=[-11;2;3];x1_0=[-4;5;2];x2_0=[3;-4;7];x3_0=[-9;10;-5];x4_0=[6;3;5];x5_0=[-1;2;3];
X_0=[x1_0;x2_0;x3_0;x4_0;x5_0];
%%%%%%%%%%%%%%%%initial state
e_0=[x1_0-x0_0;x2_0-x0_0;x3_0-x0_0;x4_0-x0_0;x5_0-x0_0];
h=0.001;
tend=30;
x_result=X_0;
t_result=0:h:tend;
x0mid=x0_0;
xmid=X_0;
emid=e_0;
t_k=0;
e_k=e_0;
T_k=[];%%%%%%%record event-triggering instants
e_result=e_0;
enorm=[norm(x1_0-x0_0);norm(x2_0-x0_0);norm(x3_0-x0_0);norm(x4_0-x0_0);norm(x5_0-x0_0)];
 for t=h:h:tend
     omega=randn;
     emid=emid+kron(I5,A)*emid*h+sigma*emid*omega*sqrt(h);%%%%%%%%error dynamics
     enormmid=[norm(emid(1:3));norm(emid(4:6));norm(emid(7:9));norm(emid(10:12));norm(emid(13:15))];%%%%%%record the value of e(t)
     if (t-t_k>=0.1&&emid'*kron(I5,P)*emid>=exp(0.2)*e_k'*kron(I5,P)*e_k)||t-t_k>=5%%%%%%%%%%%%%check ETM
         t_k=t;
         T_k=[T_k;t_k];
         emid=emid-kron(K*H,eye(3))*emid;
         e_k=emid;
         enormmid=[norm(emid(1:3));norm(emid(4:6));norm(emid(7:9));norm(emid(10:12));norm(emid(13:15))];
     end
     e_result=[e_result,emid];
     enorm=[enorm,enormmid];
 end
plot(t_result,enorm,'linewidth',1.2);
hold on
xlabel('$t$','Interpreter','latex','FontSize',14,'FontWeight','bold');
ylabel('$\|e_i(t)\|$','Interpreter','latex','FontSize',14,'FontWeight','bold'); 
y2=19*ones(1,length(T_k));
plot(T_k,y2,'r.','linewidth',1)
legend({'$\|e_1(t)\|$','$\|e_2(t)\|$','$\|e_3(t)\|$','$\|e_4(t)\|$','$\|e_5(t)\|$','$\zeta_k$'},'Interpreter','latex','FontSize',12,'FontWeight','bold');
