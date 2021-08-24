Files=dir('Input Audio/**/*.wav');
pauseExecution = false; % change to true when submitting

for k=1:length(Files)
   filename=Files(k).name;
   folder = Files(k).folder;
   C = strsplit(folder,'/');
   folder = C(length(C));
   Phase1_Task3(folder(1), filename, pauseExecution);
end
