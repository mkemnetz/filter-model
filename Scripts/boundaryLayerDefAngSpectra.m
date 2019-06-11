%%
clearvars;
closeALL;
clc;

%%
heated_exp    = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Stitch Data/11-31 Data Small5/data.mat');
heated_stitch = load('/Volumes/LaCie/MATLAB/Research/Five Inch BL Experiment - Heated/Processed/Stitch Data/11-31 Data Small5/stitched_variable_ap.mat');

%%
dx.heated_exp.one   = (heated_exp.data_jitter.one.x(1, 2, 1) - heated_exp.data_jitter.one.x(1, 1, 1)).*15.6e-3;
dx.heated_exp.two   = (heated_exp.data_jitter.two.x(1, 2, 1) - heated_exp.data_jitter.two.x(1, 1, 1)).*15.6e-3;
dx.heated_exp.three = (heated_exp.data_jitter.three.x(1, 2, 1) - heated_exp.data_jitter.three.x(1, 1, 1)).*15.6e-3;
dx.heated_exp.four  = (heated_exp.data_jitter.four.x(1, 2, 1) - heated_exp.data_jitter.four.x(1, 1, 1)).*15.6e-3;
dx.heated_exp.five  = (heated_exp.data_jitter.five.x(1, 2, 1) - heated_exp.data_jitter.five.x(1, 1, 1)).*15.6e-3;
dx.heated_exp.six   = (heated_exp.data_jitter.six.x(1, 2, 1) - heated_exp.data_jitter.six.x(1, 1, 1)).*15.6e-3;


%
[gradx.heated_exp.one,   grady.heated_exp.one]   = gradient(heated_exp.data_jitter.one.phase./1e6, dx.heated_exp.one);
[gradx.heated_exp.two,   grady.heated_exp.two]   = gradient(heated_exp.data_jitter.two.phase./1e6, dx.heated_exp.two);
[gradx.heated_exp.three, grady.heated_exp.three] = gradient(heated_exp.data_jitter.three.phase./1e6, dx.heated_exp.three);
[gradx.heated_exp.four,  grady.heated_exp.four]  = gradient(heated_exp.data_jitter.four.phase./1e6, dx.heated_exp.four);
[gradx.heated_exp.five,  grady.heated_exp.five]  = gradient(heated_exp.data_jitter.five.phase./1e6, dx.heated_exp.five);
[gradx.heated_exp.six,   grady.heated_exp.six]   = gradient(heated_exp.data_jitter.six.phase./1e6, dx.heated_exp.six);

%
fsamp = 40307;
NN    = 100;
[Sxx.heated_exp.one,   freq.heated_exp.one]   = psdfun(gradx.heated_exp.one(15, 5, :),NN,fsamp);
[Sxx.heated_exp.two,   freq.heated_exp.two]   = psdfun(gradx.heated_exp.two(15, 9, :),NN,fsamp);
[Sxx.heated_exp.three, freq.heated_exp.three] = psdfun(gradx.heated_exp.three(15, 13, :),NN,fsamp);
[Sxx.heated_exp.four,  freq.heated_exp.four]  = psdfun(gradx.heated_exp.four(15, 16, :),NN,fsamp);
[Sxx.heated_exp.five,  freq.heated_exp.five]  = psdfun(gradx.heated_exp.five(15, 21, :),NN,fsamp);
[Sxx.heated_exp.six,   freq.heated_exp.six]  = psdfun(gradx.heated_exp.six(15, 25, :),NN,fsamp);

%
figure();
semilogy(freq.heated_exp.one, Sxx.heated_exp.one);
hold on;
semilogy(freq.heated_exp.two, Sxx.heated_exp.two);
semilogy(freq.heated_exp.three, Sxx.heated_exp.three);
semilogy(freq.heated_exp.four, Sxx.heated_exp.four);
semilogy(freq.heated_exp.five, Sxx.heated_exp.five);
semilogy(freq.heated_exp.six, Sxx.heated_exp.six);
legend('1', '2', '3', '4', '5', '6');

%%
dx.heated_stitch.six.one    = (heated_stitch.x_ts.six.one(1, 2, 1) - heated_stitch.x_ts.six.one(1, 1, 1)).*15.6e-3;
dx.heated_stitch.six.three  = (heated_stitch.x_ts.six.three(1, 2, 1) - heated_stitch.x_ts.six.three(1, 1, 1)).*15.6e-3;
dx.heated_stitch.six.five   = (heated_stitch.x_ts.six.five(1, 2, 1) - heated_stitch.x_ts.six.five(1, 1, 1)).*15.6e-3;
dx.heated_stitch.six.ten    = (heated_stitch.x_ts.six.ten(1, 2, 1) - heated_stitch.x_ts.six.ten(1, 1, 1)).*15.6e-3;
dx.heated_stitch.six.twenty = (heated_stitch.x_ts.six.twenty(1, 2, 1) - heated_stitch.x_ts.six.twenty(1, 1, 1)).*15.6e-3;

dy.heated_stitch.six.one    = (heated_stitch.y_ts.six.one(1, 2, 1) - heated_stitch.y_ts.six.one(1, 1, 1)).*15.6e-3;
dy.heated_stitch.six.three  = (heated_stitch.y_ts.six.three(1, 2, 1) - heated_stitch.y_ts.six.three(1, 1, 1)).*15.6e-3;
dy.heated_stitch.six.five   = (heated_stitch.y_ts.six.five(1, 2, 1) - heated_stitch.y_ts.six.five(1, 1, 1)).*15.6e-3;
dy.heated_stitch.six.ten    = (heated_stitch.y_ts.six.ten(1, 2, 1) - heated_stitch.y_ts.six.ten(1, 1, 1)).*15.6e-3;
dy.heated_stitch.six.twenty = (heated_stitch.y_ts.six.twenty(1, 2, 1) - heated_stitch.y_ts.six.twenty(1, 1, 1)).*15.6e-3;

%
[gradx.heated_stitch.six.one,    grady.heated_stitch.six.one]    = gradient(heated_stitch.WF_ts.six.one./1e6, dx.heated_stitch.six.one, dy.heated_stitch.six.one, 1);
[gradx.heated_stitch.six.three,  grady.heated_stitch.six.three]  = gradient(heated_stitch.WF_ts.six.three./1e6, dx.heated_stitch.six.three, dy.heated_stitch.six.three,1);
[gradx.heated_stitch.six.five,   grady.heated_stitch.six.five]   = gradient(heated_stitch.WF_ts.six.five./1e6, dx.heated_stitch.six.five, dy.heated_stitch.six.five, 1);
[gradx.heated_stitch.six.ten,    grady.heated_stitch.six.ten]    = gradient(heated_stitch.WF_ts.six.ten./1e6, dx.heated_stitch.six.ten, dy.heated_stitch.six.ten, 1);
[gradx.heated_stitch.six.twenty, grady.heated_stitch.six.twenty] = gradient(heated_stitch.WF_ts.six.twenty./1e6, dx.heated_stitch.six.twenty, dy.heated_stitch.six.twenty, 1);


%
fsamp = 97771;
NN    = 1000;
[Sxx.heated_stitch.six.one,    freq.heated_stitch.six.one]    = psdfun(gradx.heated_stitch.six.one(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.six.three,  freq.heated_stitch.six.three]  = psdfun(gradx.heated_stitch.six.three(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.six.five,   freq.heated_stitch.six.five]   = psdfun(gradx.heated_stitch.six.five(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.six.ten,    freq.heated_stitch.six.ten]    = psdfun(gradx.heated_stitch.six.ten(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.six.twenty, freq.heated_stitch.six.twenty] = psdfun(gradx.heated_stitch.six.twenty(50, 50, :),NN,fsamp);

%
delta                        = 0.0156;
Uc                           = 0.8*machToVel(0.2, 78);
Std.heated_stitch.six.one    = (freq.heated_stitch.six.one.*delta)./Uc;
Std.heated_stitch.six.three  = (freq.heated_stitch.six.one.*delta)./Uc;
Std.heated_stitch.six.five   = (freq.heated_stitch.six.one.*delta)./Uc;
Std.heated_stitch.six.ten    = (freq.heated_stitch.six.one.*delta)./Uc;
Std.heated_stitch.six.twenty = (freq.heated_stitch.six.one.*delta)./Uc;

figure();
semilogy(freq.heated_stitch.six.one, Sxx.heated_stitch.six.one);
hold on;
semilogy(freq.heated_stitch.six.three, Sxx.heated_stitch.six.three);
semilogy(freq.heated_stitch.six.five, Sxx.heated_stitch.six.five);
semilogy(freq.heated_stitch.six.ten, Sxx.heated_stitch.six.ten);
semilogy(freq.heated_stitch.six.twenty, Sxx.heated_stitch.six.twenty);

legend('6-1', '6-3', '6-5', '6-10', '6-20');

figure();
loglog(Std.heated_stitch.six.one, Sxx.heated_stitch.six.one);
hold on;
loglog(Std.heated_stitch.six.three, Sxx.heated_stitch.six.three);
loglog(Std.heated_stitch.six.five, Sxx.heated_stitch.six.five);
loglog(Std.heated_stitch.six.ten, Sxx.heated_stitch.six.ten);
loglog(Std.heated_stitch.six.twenty, Sxx.heated_stitch.six.twenty);
xlabel('$St_{\delta}$', 'Interpreter','Latex');
legend('6-1', '6-3', '6-5', '6-10', '6-20');

%%
dx.heated_stitch.two.one    = (heated_stitch.x_ts.two.one(1, 2, 1) - heated_stitch.x_ts.two.one(1, 1, 1)).*15.6e-3;
dx.heated_stitch.two.three  = (heated_stitch.x_ts.two.three(1, 2, 1) - heated_stitch.x_ts.two.three(1, 1, 1)).*15.6e-3;
dx.heated_stitch.two.five   = (heated_stitch.x_ts.two.five(1, 2, 1) - heated_stitch.x_ts.two.five(1, 1, 1)).*15.6e-3;
dx.heated_stitch.two.ten    = (heated_stitch.x_ts.two.ten(1, 2, 1) - heated_stitch.x_ts.two.ten(1, 1, 1)).*15.6e-3;
dx.heated_stitch.two.twenty = (heated_stitch.x_ts.two.twenty(1, 2, 1) - heated_stitch.x_ts.two.twenty(1, 1, 1)).*15.6e-3;

%
[gradx.heated_stitch.two.one,    grady.heated_stitch.two.one]    = gradient(heated_stitch.WF_ts.two.one./1e6, dx.heated_stitch.two.one);
[gradx.heated_stitch.two.three,  grady.heated_stitch.two.three]  = gradient(heated_stitch.WF_ts.two.three./1e6, dx.heated_stitch.two.three);
[gradx.heated_stitch.two.five,   grady.heated_stitch.two.five]   = gradient(heated_stitch.WF_ts.two.five./1e6, dx.heated_stitch.two.five);
[gradx.heated_stitch.two.ten,    grady.heated_stitch.two.ten]    = gradient(heated_stitch.WF_ts.two.ten./1e6, dx.heated_stitch.two.ten);
[gradx.heated_stitch.two.twenty, grady.heated_stitch.two.twenty] = gradient(heated_stitch.WF_ts.two.twenty./1e6, dx.heated_stitch.two.twenty);

%
fsamp = 97771;
NN    = 100;
[Sxx.heated_stitch.two.one,    freq.heated_stitch.two.one]    = psdfun(gradx.heated_stitch.two.one(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.two.three,  freq.heated_stitch.two.three]  = psdfun(gradx.heated_stitch.two.three(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.two.five,   freq.heated_stitch.two.five]   = psdfun(gradx.heated_stitch.two.five(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.two.ten,    freq.heated_stitch.two.ten]    = psdfun(gradx.heated_stitch.two.ten(50, 50, :),NN,fsamp);
[Sxx.heated_stitch.two.twenty, freq.heated_stitch.two.twenty] = psdfun(gradx.heated_stitch.two.twenty(50, 50, :),NN,fsamp);

%
figure();
semilogy(freq.heated_stitch.two.one, Sxx.heated_stitch.two.one);
hold on;
semilogy(freq.heated_stitch.two.three, Sxx.heated_stitch.two.three);
semilogy(freq.heated_stitch.two.five, Sxx.heated_stitch.two.five);
semilogy(freq.heated_stitch.two.ten, Sxx.heated_stitch.two.ten);
semilogy(freq.heated_stitch.two.twenty, Sxx.heated_stitch.two.twenty);

legend('2-1', '2-3', '2-5', '2-10', '2-20');

%%
figure();
semilogy(freq.heated_stitch.two.one, Sxx.heated_stitch.two.one);
hold on;
semilogy(freq.heated_stitch.two.three, Sxx.heated_stitch.two.three);
semilogy(freq.heated_stitch.two.five, Sxx.heated_stitch.two.five);
semilogy(freq.heated_stitch.two.ten, Sxx.heated_stitch.two.ten);
semilogy(freq.heated_stitch.two.twenty, Sxx.heated_stitch.two.twenty);
semilogy(freq.heated_stitch.six.one, Sxx.heated_stitch.six.one);
semilogy(freq.heated_stitch.six.three, Sxx.heated_stitch.six.three);
semilogy(freq.heated_stitch.six.five, Sxx.heated_stitch.six.five);
semilogy(freq.heated_stitch.six.ten, Sxx.heated_stitch.six.ten);
semilogy(freq.heated_stitch.six.twenty, Sxx.heated_stitch.six.twenty);

legend('2-1', '2-3', '2-5', '2-10', '2-20', '6-1', '6-3', '6-5', '6-10', '6-20');


