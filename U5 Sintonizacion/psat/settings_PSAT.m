function settings_PSAT()

global Settings Theme

Settings.absvalues = 'off';
Settings.beep = 0;
Settings.checkdelta = 0;
Settings.chunk = 100;
Settings.coi = 0;
Settings.conv = 1;
Settings.date = 'January 6, 2013';
Settings.deltadelta = 180;
Settings.deltat = 6.2178e-17;
Settings.deltatmax = 0.125;
Settings.deltatmin = 0.00039063;
Settings.distrsw = 0;
Settings.donotask = 0;
Settings.dynmit = 20;
Settings.dyntol = 1e-05;
Settings.error = 1;
Settings.export = 'txt';
Settings.fixt = 0;
Settings.forcepq = 0;
Settings.format = 2;
Settings.freq = 50;
Settings.hostver = 7.00;
Settings.init = 0;
Settings.iter = 4;
Settings.lfmit = 20;
Settings.lftime = 0.45836;
Settings.lftol = 1e-05;
Settings.local = 1;
Settings.locksnap = 0;
Settings.matlab = 1;
Settings.maxvar = 1500;
Settings.maxsimout = 15;
Settings.maxsimin = 15;
Settings.method = 2;
Settings.mv = 1.117;
Settings.mva = 100;
Settings.multipvswitch = 0;
Settings.noarrows = 1;
Settings.nseries = 0;
Settings.octave = 0;
Settings.ok = 1;
Settings.pfsolver = 1;
Settings.platform = 'UNIX';
Settings.plot = 0;
Settings.plottype = 1;
Settings.pq2z = 0;
Settings.pv2pq = 0;
Settings.pv2pqniter = 0;
Settings.report = 0;
Settings.resetangles = 1;
Settings.show = 1;
Settings.showlf = 0;
Settings.simtd = 0;
Settings.static = 0;
Settings.status = 1;
Settings.switch2nr = 0;
Settings.t0 = 0;
Settings.tf = 20;
Settings.tstep = 0.05;
Settings.tviewer = '!cat ';
Settings.usedegree = 0;
Settings.usehertz = 0;
Settings.userelspeed = 0;
Settings.version = '2.1.7';
Settings.violations = 'off';
Settings.vs = 0;
Settings.xlabel = 'time (s)';
Settings.zoom = '';

Theme.color01 = [0.68235     0.69804     0.76471];
Theme.color02 = [0.68235     0.69804     0.76471];
Theme.color03 = [0.44314      0.5451     0.64706];
Theme.color04 = [0.94118     0.92549     0.88235];
Theme.color05 = [0  0  0];
Theme.color06 = [1  1  1];
Theme.color07 = [0.75           0           0];
Theme.color08 = [0.69804     0.30196     0.47843];
Theme.color09 = [1  1  1];
Theme.color10 = [1  1  1];
Theme.color11 = [0.94118     0.92549     0.88235];

if strncmp(computer,'PC',2) && usejava('jvm')
  Theme.font01 = 'Helvetica';
  Theme.font02 = 'Helvetica';
  Theme.font03 = 'Helvetica';
  Theme.font04 = 'Helvetica';
else
  Theme.font01 = 'Arial';
  Theme.font02 = 'Arial';
  Theme.font03 = 'Arial';
  Theme.font04 = 'Arial'; 
end

Theme.hdl = zeros(18,1);
