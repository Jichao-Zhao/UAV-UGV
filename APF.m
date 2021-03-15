% �˹��Ƴ�����
clear
clc

% �Ա���������
% ������Ӱ�����


% �������룺d
% ��Ч���룺R
% ��ǰ���룺dij

% syms d R dij real
% Vij = (dij - d)^2 * (R - dij) / ( dij       + d^2 * (R-dij) )...
%     + (dij - d)^2 * (dij)     / ( (R - dij) + dij * (R-d)^2 );


d = 10;
R = 0;
xi = 1;
rho = 10;
ij = linspace(0,10,100);   % ����

for time = 1:length(ij)
    dij = ij(1,time);
    
    Vij(1,time)     = (dij - d)^2 * (R - dij) / ( dij       + d^2 * (R-dij) )...
        + (dij - d)^2 * (dij)     / ( (R - dij) + dij * (R-d)^2 );
    VFij(1,time)    = (2*dij*(2*d - 2*dij))/(- dij*d^2 + dij) - (2*(d - dij)^2)/(- dij*d^2 + dij) - (2*dij*(d^2 - 1)*(d - dij)^2)/(dij - d^2*dij)^2;
    
    % ����һ���ˣ����ٸ���
    Vij(1,time)     = (dij-d)^2 / (dij+d)^2 ;
    VFij(1,time)    = (- (2*d - 2*dij)/(d + dij)^2 - (2*(d - dij)^2)/(d + dij)^3);
        
    Tij(1,time)     = (1/dij - 1/rho)^2;
    TFij(1,time)    = -( xi * (1/dij - 1/rho))/dij^2;
    
    V2ij(1,time)    = 1/(dij^2) + 1/(1^2-dij^2);
    V2Fij(1,time)   = (2*dij)/(R^2 - dij^2)^2 - 2/dij^3;
    
    VLij(1,time)    = ( min(0,(dij^2-R^2)/(dij^2-d^2)) )^2;
    VLFij(1,time)   = (4*dij*(R^2 - dij^2)^2)/(d^2 - dij^2)^3 - (4*dij*(R^2 - dij^2))/(d^2 - dij^2)^2;

end

% syms xi dij rho real
% Tij = 0.5 * xi * (1/dij - 1/rho)^2;

% ��ͳ�ĳ����㷨

% Tij = 0.5 * xi * (1/dij - 1/rho)^2;
% TFij = -( xi * (1/dij - 1/rho))/dij^2;

% ��Ϊ�Ƴ������Ǹ�������Ŀ��ľ�����Ϊ�Ա�����
% �����Ҫ�ȼ���������룬֮������Ƴ���Ȼ���ټ�������Ŀ�����



huitu = 1;

if huitu == 1
    plot(ij,Vij,'linewidth',1); 
    xlabel('d_{ij}');
    ylabel('U(d_{ij})');
    title('Potential Field Function');
    plot(ij,VFij); hold on 
%     plot(ij,Tij); hold on
%     plot(ij,TFij); hold on
%     plot(ij,V2ij); hold on
%     plot(ij,V2Fij); hold on
%     plot(ij,VLij); hold on
%     plot(ij,VLFij); hold on
end

do = 5;
maxF = 10;
x = linspace(0,10,100);
U = ((x.^2./(x.^2-do.^2)).^2 );
F = ( ( 1./(x.^2-do.^2) ) .^2 );
% F = 1./(x-5).^2;
% F = ((4*x.^3)./(do^2 - x.^2).^2 + (4.*x.^5)/(do^2 - x.^2).^3);
% plot(x,U,x,F)

(4*d^3)/(R^2 - d^2)^2 + (4*d^5)/(R^2 - d^2)^3

