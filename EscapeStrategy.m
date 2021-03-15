% ���ܲ��ԣ���������
clear
clc

% ģ�ͳ�ʼ������������
p0(:,1) = [10,5]';
theta0   = 1.0517;
v0(1,1)  = 4.0315;


% ʱ�����
tBegin = 0;
tEnd   = 10;
dT     = 0.2;
times  = (tEnd-tBegin)/dT;
t(1,1) = 0;

% ����ѡ��
strategyType = 2;
huitu = 1;


for time = 1:times
    if strategyType == 1
        % 1. ��ֹ����
        theta0   = 1.0517;
        v0(1,1)  = 0;
        u0       = 0;
    end

    if strategyType == 2 && t(1,time)<5
        % 2. ����ֱ���˶�
        theta0   = 1.0517;
        v0(1,1)  = 5;
        u0       = 1;
    end

    if strategyType == 3
        % 3. ���׷���ߵ��ٶȷ���
        theta0   = 1.0517;
        v0(1,1)  = 5;
        u0       = 0;
    end

    if strategyType == 4
        % 4. ����׷���ߵı�׼���ٶ�ʸ����
        theta0   = 1.0517;
        v0(1,1)  = 5;
        u0       = 1;
    end

    % ��¼Ŀ��켣
%     v0(1,time+1) = v0(1,time) + dT * u0;
    p0(1,time+1) = p0(1,time) + dT * v0 * cos(theta0);
    p0(2,time+1) = p0(2,time) + dT * v0 * sin(theta0);
    
    % ��¼ʱ��
    t(1, time+1) = t(1,time) + dT;
    
end

if huitu == 1
    % ����
    figure(1)
    plot(p0(1,:),p0(2,:),'>','color','r'); hold on
    legend('target 0');
    xlabel('X axis');
    ylabel('Y axis');
    axis([0,50, 0,50]); 
    axis equal;
    title('Fixed direction');
end

