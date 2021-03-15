% �ٶȹ۲���
clear
clc

% Ŀ���˶��켣
target1 = 0;
target2 = 0;
target3 = 0;
target4 = 0;

% Ŀ�����ݷ���1����ֹ����
if target1 == 1
    v0 = 0;
    u0 = 0;
end
% Ŀ�����ݷ���2�������˶�
if target2 == 1
    v0 = 1;
    u0 = 0;
end
% Ŀ�����ݷ���3
if target3 == 1
end
% Ŀ�����ݷ���4
if target4 == 1
end

p0(:,1) = [10;5];  
% theta0 = 0;
% v0(:,1) = 0 * [cos(theta0); sin(theta0);];
v0(:,1) = [0,0]';

% UAV �˶��켣
pA(:,1) = [0;0]; vA(:,1) = [0*cos(0);0*sin(0)]; thetaA(1,1) = 0;

% ʱ�����
tBegin = 0;
tEnd   = 30;
dT     = 0.01;
times  = (tEnd-tBegin)/dT;
t(1,1) = 0;

% �����ؼ�����
K = 1;          % �ٶȹ۲���
kappa = 0.0;

huitu = 1;
huitu2= 0;

% ���� UGV ��άͼ������Ϣ
z1(1,1) = 0;
zA(1,1) = 0;

for time = 1:times
    % Ŀ����ٶ�
    if t(1,time)>=0 && t(1,time)<1      % 45��б����
        u0 = [3,3]';
    elseif t(1,time)>=1 && t(1,time)<2  % ����
        u0 = [0,-3]';   
    elseif t(1,time)>=2 && t(1,time)<4 % ˮƽ����
        u0 = [0,0]';
    elseif t(1,time)>=4 && t(1,time)<5 % ����
        u0 = [-3,3]';   
    elseif t(1,time)>=5 && t(1,time)<7 % ��ֱ����
        u0 = [0,0]';
    elseif t(1,time)>=7 && t(1,time)<8 % 
        u0 = [-3,-3]';
    elseif t(1,time)>=8 && t(1,time)<10
        u0 = [0,0]';
    elseif t(1,time)>=10 && t(1,time)<11
        u0 = [3,-2.5]';
    elseif t(1,time)>=11 && t(1,time)<13
        u0 = [0,0]';
    elseif t(1,time)>=13 && t(1,time)<14
        u0 = [0,2.5]';    
    elseif t(1,time)>=14 && t(1,time)<15
        u0 = [3,0]';
    elseif t(1,time)>=16 && t(1,time)<23
        u0 = [-3*sin(t(1,time)-16),3*cos(t(1,time)-16)]';
    else
        u0=0;
    end
    % Ŀ��Ĺ켣
    v0(:,time+1) = v0(:,time) + dT .* u0;
    p0(:,time+1) = p0(:,time) + dT * v0(:,time+1);
    
    % UAV �Ĺ켣����Ҫ���ݹ۲⵽���ٶ�
    vA(:,time+1) = K * (p0(:,time)-pA(:,time)) + kappa * vA(:,time);
    pA(:,time+1) = pA(:,time) + dT * vA(:,time+1);
    % ����ֵ
    vE(:,time+1) = vA(:,time+1) - K * (p0(:,time)-pA(:,time));
    
    % ��¼ʱ����Ϣ
    t(1,time+1) = t(1,time) + dT;
    
    % ������ͼ��Ϣ
    z1(1,time+1) = z1(1,time) + dT * 0;
    if zA(1,time)<15
        uA = 30;
    else
        uA = 0;
    end
    zA(1,time+1) = zA(1,time) + dT * uA;
    
end

if huitu == 1
    figure(1)
    % ��ͼ Velocity Observer

    subplot(2,2,1)
    plot3(p0(1,:),p0(2,:),z1,'linewidth',1,'MarkerIndices',1:60:length(t)); hold on
    plot3(pA(1,:),pA(2,:),zA,'-+','linewidth',1,'MarkerIndices',1:60:length(t)); hold on
    axis([0,40, 0,30, 0,30]);
%     title('Trajectory'); 
    title('(a)','position',[0,0,-8]);
    legend("target trajectory", "UAV trajectory"); 
    xlabel('X Position');ylabel('Y Position');zlabel('Height'); grid on;
    set(gca,'FontName','Times New Roman','position', [0.05 0.575 0.40 0.40]);
    
    subplot(2,2,2)
%     plot(pA(1,:),pA(2,:),'linewidth',1.5,'color','g'); hold on
%     plot(t, p0(1,:)-pA(1,:),'linewidth',1.5,'color','r'); hold on
%     plot(t, p0(2,:)-pA(2,:),'linewidth',1.5,'color','g'); hold on
    p0A = sqrt( (p0(1,:)-pA(1,:)).^2 + (p0(2,:)-pA(2,:)).^2 );
    plot(t, p0A,'linewidth',1); hold on
    axis([0,tEnd, -10,40]);
%     title('Position Difference - Time'); %legend('x ��λ�ò�ֵ', 'y ��λ�ò�ֵ'); 
    title('(b)','position',[15,-18]);
    xlabel('Time');ylabel('Position Difference');zlabel('Height'); grid on;
    set(gca,'FontName','Times New Roman','position', [0.55 0.575 0.40 0.40]);

    subplot(2,2,3)
    v0V = sqrt( (v0(1,:)).^2 + (v0(2,:)).^2 );
    vAV = sqrt( (vA(1,:)).^2 + (vA(2,:)).^2 );
    plot(t, v0V,'linewidth',1,'MarkerIndices',1:60:length(t)); hold on
    plot(t, vAV,'-+','linewidth',1,'MarkerIndices',1:60:length(t)); hold on
    axis([0,tEnd, -10,40]);
%     title('Velocity'); 
    title('(c)','position',[15,-18]);
    legend("target velocity", "UAV velocity");
    xlabel('Time');ylabel('Velocity');zlabel('Height'); grid on;
    set(gca,'FontName','Times New Roman','position', [0.05 0.075 0.40 0.40]);
    
    subplot(2,2,4)
    v0V = sqrt( (v0(1,:)).^2 + (v0(2,:)).^2 );
    vAV = sqrt( (vA(1,:)).^2 + (vA(2,:)).^2 );
    plot(t, vAV-v0V,'linewidth',1); hold on
%     plot(t, v0(1,:)-vA(1,:),'linewidth',1.5,'color','r'); hold on
%     plot(t, v0(2,:)-vA(2,:),'linewidth',1.5,'color','g'); hold on
%     plot(t, vA(1,:),'linewidth',1.5,'color','b'); hold on
%     plot(t, vA(2,:),'linewidth',1.5,'color','c'); hold on
    axis([0,tEnd, -10,40]);
%     title('Velocity Difference - Time'); 
    title('(d)','position',[15,-18]);
    %legend('UAV X�ٶ�', 'UAV Y�ٶ�'); 
    xlabel('Time');ylabel('Velocity Difference');zlabel('Height'); grid on;
    set(gca,'FontName','Times New Roman','Position',[0.55 0.075 0.40 0.40]);
    
end

if huitu2 == 1
    figure(2)
    % ��ͼ Velocity Observer
    subplot(2,2,1)
    plot(p0(1,:),p0(2,:),'linewidth',1.5,'color','r'); hold on
    title('Position'); legend('Targetλ��', 'UAVλ��'); 
    xlabel('X Position');ylabel('Y Position');zlabel('Height'); grid on;
    
    subplot(2,2,2)
    plot(pA(1,:),pA(2,:),'linewidth',1.5,'color','g'); hold on
    title('Position'); legend('Targetλ��', 'UAVλ��'); 
    xlabel('X Position');ylabel('Y Position');zlabel('Height'); grid on;

    subplot(2,2,3)
    v0V = sqrt( (v0(1,:)).^2 + (v0(2,:)).^2 );
    plot(t, v0V,'linewidth',1.5,'color','r'); hold on
    title('Velocity'); legend('Ŀ���ٶ�', 'UAV �ٶ�');
    xlabel('Time');ylabel('Velocity');zlabel('Height'); grid on
    
    subplot(2,2,4)
    vAV = sqrt( (vA(1,:)).^2 + (vA(2,:)).^2 );
    plot(t, vAV,'linewidth',1.5,'color','g'); hold on
    title('Velocity'); legend('Ŀ���ٶ�', 'UAV �ٶ�');
    xlabel('Time');ylabel('Velocity');zlabel('Height'); grid on
end

% pause(0.5)
% end