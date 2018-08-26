%%
clearvars;
close all;
clc;

%%
exp        = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/experimental_jitter_BL3.mat');
stitch     = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/stitch_jitter_BL2.mat');
adam_model = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/adam_model.mat');

%% Adam's spectra (frequency space)
f                        = 0:1:1e5;
theta_modeled_f          = (modelf(f, 1));
theta_modeled_filtered_f = theta_modeled_f.*(Gf(1, f, 0.8*machToVel(0.4, 70)));

figure();
semilogy(f, theta_modeled_f);
hold on;
semilogy(f, theta_modeled_filtered_f.^2);

delta           = 0.24;
Ap              = 0:1e-2:20*delta;

jitter_rms_f      = zeros(1, length(Ap));
for i = 1:length(Ap)
    theta_modeled_filtered_f  = theta_modeled_f.*(Gf(Ap(i), f, 0.8*machToVel(0.4, 70)));
    jitter_rms_f(1, i) = sqrt(sum(theta_modeled_filtered_f.^2));
end

%%
z = Ap./delta;
x = jitter_rms_f(z > 0.95 & z < 1.05)./exp.jitter(1);
xx = mean(x);
figure();
set(gcf,'units','normalized','position',[0 0.56 0.145 0.21]);
semilogy(stitch.Ap, stitch.jitter, 'b-+');
hold on
semilogy(exp.Ap, exp.jitter, 'g--+', 'LineWidth', 2);
semilogy([0 exp.Ap(1)], [4.5588e-6 exp.jitter(1)], 'g--+', 'LineWidth', 2);
semilogy(z, ((1/xx).*(jitter_rms_f)), 'r-.','LineWidth', 2);
xlabel('$Ap/\delta$', 'interpreter', 'latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot M^2 + (\Delta T/T_{\infty})}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs $Ap$', 'interpreter', 'latex');
hleg = legend('Stitching Method', 'Experimental', 'Filter Model');
set(hleg, 'interpreter', 'latex');

%%  Filter function based on Strouhol number
function g = G(z)
% G Filter function.

%    g = (z == 0).*1 + (z > 0).*((3*(sin(pi.*z)-pi.*z.*cos(pi.*z)))./(pi.*z).^3);
   g = ((3*(sin(pi.*z)-pi.*z.*cos(pi.*z)))./(pi.*z).^3);
   g(z == 0) = 1;
   

end

function z = Zst(Ap, St, delta)
% Z z definition.

    z = (Ap./delta).*St*1.20;
end


function gst = Gst(Ap, St, delta)
% Gf Composite function.

    gst = G(Zst(Ap, St, delta));
end

%% Filter functions based on frequency
function z = Zf(Ap, f, Uc)
% Z z definition.

    z = (Ap.*f)./Uc;
end

function gf = Gf(Ap, f, Uc)
% Gf Composite function.

    gf = G(Zf(Ap, f, Uc));
end

%% Adam's deflection angle analytical model
function theta = model(St, thetaPeak)
% Gf Composite function.

    theta = St./(1+(St/0.75).^(5/3));
    theta = theta.*thetaPeak;
    
end

function theta = modelf(f, thetaPeak)
% Gf Composite function.
    
    delta = 0.24;
    Uinf  = machToVel(0.4, 70);
    St    = (f.*delta)./Uinf;
    theta = St./(1+(St/0.75).^(5/3));
    theta = theta.*thetaPeak;
    
end