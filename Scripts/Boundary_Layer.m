%%
clearvars;
closeALL;
clc;

%%
exp                = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/experimental_jitter_BL3.mat');
stitch             = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/stitch_jitter_BL2.mat');
stitch_expdata     = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/stitch_jitter_expdata_BL6.mat');
adam_model         = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/adam_model.mat');

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

%% Everything
z = Ap./delta;
x = jitter_rms_f(z > 0.95 & z < 1.05)./exp.jitter(1);
xx = mean(x);
c = cubehelix(7, [0.5,-1.5,1,1], [0.2,0.8], [0.3,0.7]);
figure();
set(gcf,'units','normalized','position',[0 0 0.145 0.21]);
h1 = semilogy(stitch.Ap, stitch.jitter, '--+', 'color',  c(1, :),'LineWidth', 1);
hold on
h2 = semilogy([0 stitch.Ap(1)], [3.423e-6 stitch.jitter(1)], '--+', 'color',  c(1, :), 'LineWidth', 1, 'MarkerSize', 8);
h3 = semilogy(exp.Ap, exp.jitter, '--s','color',  c(2, :), 'LineWidth', 2);
ylim([10^-9 10^-7]);
h4 = semilogy([0 exp.Ap(1)], [4.5588e-6 exp.jitter(1)], '--s','color',  c(2, :),  'LineWidth', 1, 'MarkerSize', 8);
h5 = semilogy(stitch_expdata.Ap.one, stitch_expdata.jitter.one, '--*','color',  c(3, :),  'LineWidth', 1, 'MarkerSize', 8);
h6 = semilogy(stitch_expdata.Ap.two, stitch_expdata.jitter.two, '--o','color',  c(4, :),  'LineWidth', 1, 'MarkerSize', 8);
h7 = semilogy(stitch_expdata.Ap.three, stitch_expdata.jitter.three, '--^','color',  c(5, :),  'LineWidth', 1, 'MarkerSize', 8);
h8 = semilogy(stitch_expdata.Ap.six, stitch_expdata.jitter.six, '--X','color',  c(6, :),  'LineWidth', 1, 'MarkerSize', 8);
h9 = semilogy(z, ((1/xx).*(jitter_rms_f)), '-.','color',  c(7, :), 'LineWidth', 2);
xlabel('$Ap/\delta$', 'interpreter', 'latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot M^2 + (\Delta T/T_{\infty})}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs $Ap$', 'interpreter', 'latex');
hleg = legend([h1, h3, h5, h6, h7, h8, h9], {'Stitching Method - Unheated', 'Experimental', 'Stitched Experimental - $1\delta$', 'Stitched Experimental - $2\delta$', 'Stitched Experimental - $3\delta$', 'Stitched Experimental - $6\delta$', 'Filter Model'});
set(hleg, 'interpreter', 'latex');

%% Stitching Comparison
c = cubehelix(7, [0.5,-1.5,1,1], [0.2,0.8], [0.3,0.7]);
figure();
set(gcf,'units','normalized','position',[0 0.28 0.145 0.21]);
p1 = semilogy(stitch.Ap, stitch.jitter, '--+', 'color',  c(1, :),'LineWidth', 1, 'MarkerSize', 8);
hold on
p2 = semilogy([0 stitch.Ap(1)], [3.423e-6 stitch.jitter(1)], '--+', 'color',  c(1, :), 'LineWidth', 1, 'MarkerSize', 8);
p3 = semilogy(stitch_expdata.Ap.one, stitch_expdata.jitter.one, '--*','color',  c(3, :), 'LineWidth', 1, 'MarkerSize', 8);
p4 = semilogy(stitch_expdata.Ap.two, stitch_expdata.jitter.two, '--o','color',  c(4, :), 'LineWidth', 1, 'MarkerSize', 8);
p5 = semilogy(stitch_expdata.Ap.three, stitch_expdata.jitter.three, '--^','color',  c(5, :), 'LineWidth', 1, 'MarkerSize', 8);
p6 = semilogy(stitch_expdata.Ap.six, stitch_expdata.jitter.six, '--X','color',  c(6, :), 'LineWidth', 1, 'MarkerSize', 8);
xlabel('$Ap/\delta$', 'interpreter', 'latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot M^2 + (\Delta T/T_{\infty})}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs $Ap$', 'interpreter', 'latex');
hleg = legend([p1, p3, p4, p5, p6], {'Stitching Method - Unheated', 'Stitched Experimental - $1\delta$', 'Stitched Experimental - $2\delta$', 'Stitched Experimental - $3\delta$', 'Stitched Experimental - $6\delta$'});
set(hleg, 'interpreter', 'latex');

%% Selected Stitch and model
z = Ap./delta;
x = jitter_rms_f(z > 0.95 & z < 1.05)./exp.jitter(1);
xx = mean(x);
c = cubehelix(7, [0.5,-1.5,1,1], [0.2,0.8], [0.3,0.7]);
figure();
set(gcf,'units','normalized','position',[0 0.56 0.145 0.21]);
f1 = semilogy(stitch.Ap, stitch.jitter, '--+', 'color',  c(1, :), 'LineWidth', 1, 'MarkerSize', 8);
hold on
f2 = semilogy([0 stitch.Ap(1)], [3.423e-6 stitch.jitter(1)], '--+', 'color',  c(1, :), 'LineWidth', 1, 'MarkerSize', 8);
f3 = semilogy(exp.Ap, exp.jitter, '--s','color',  c(2, :), 'LineWidth', 2);
f4 = semilogy([0 exp.Ap(1)], [4.5588e-6 exp.jitter(1)], '--s','color',  c(2, :), 'LineWidth', 1, 'MarkerSize', 8);
f5 = semilogy(stitch_expdata.Ap.three, stitch_expdata.jitter.three, '--^','color',  c(5, :), 'LineWidth', 1, 'MarkerSize', 8);
f6 = semilogy(stitch_expdata.Ap.six, stitch_expdata.jitter.six, '--X','color',  c(6, :), 'LineWidth', 1, 'MarkerSize', 8);
f7 = semilogy(z, ((1/xx).*(jitter_rms_f)), '-.','color',  c(7, :), 'LineWidth', 1, 'MarkerSize', 8);
xlabel('$Ap/\delta$', 'interpreter', 'latex');
ylabel('$\frac{\theta_{rms}}{(\rho_{\infty}/\rho_{SL}) \cdot M^2 + (\Delta T/T_{\infty})}$', 'Interpreter', 'Latex');
title('Normalized $\theta_{rms}$ vs $Ap$', 'interpreter', 'latex');
hleg = legend([f1, f3, f5, f6, f7], {'Stitching Method - Unheated', 'Experimental', 'Stitched Experimental - $3\delta$', 'Stitched Experimental - $6\delta$', 'Filter Model'});
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