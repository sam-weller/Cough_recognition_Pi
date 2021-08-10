r = raspberrypi();

board = targetHardware('Raspberry Pi');

board.CoderConfig.TargetLang = 'C++';
board.CoderConfig.GenCodeOnly = true;

dlcfg = coder.DeepLearningConfig('arm-compute');
dlcfg.ArmArchitecture = 'armv7';

r.system('strings $ARM_COMPUTELIB/lib/libarm_compute.so | grep arm_compute_versio | cut -d\  -f 1');

dlcfg.ArmComputeVersion = '19.05';%'20.02.1';

board.CoderConfig.DeepLearningConfig = dlcfg;

deploy(board,'raspi_model')

copyfile('main.cpp',[pwd,'\codegen\exe\raspi_model'])

board.CoderConfig.CustomSource = ['codegen',filesep,'exe',filesep,'raspi_model',filesep,'main.cpp'];
board.CoderConfig.GenerateExampleMain = 'DoNotGenerate';

board.CoderConfig.GenCodeOnly = false;

deploy(board,'raspi_model')


