function loader
myday='2012_12_10'; make(myday);
end

function make(myday)
if ~isdir('matflight')
    mkdir('matflight')
end
if ~isdir(['matflight/' myday])
    mkdir(['matflight/' myday])
end

eval(['save matflight/' myday '/myday.mat myday'])

foldout=['matflight/' myday];
list4=dir([myday '/FlightHistory/*.csv']);

for i=1:size(list4,1)
    namein=list4(i).name(1:end-4);
    foldin=[myday '/FlightHistory'];
    nameout=[myday '_FlightHistory_' namein];
    csv2mat(namein, foldin, nameout, foldout); 
end

end

function csv2mat(namein, foldin, nameout, foldout)

block_size = 10000; % number of line for each subfile, adjust at will
fid = fopen([foldin '/' namein '.csv']);
line=fgetl(fid);
seph=find(line==',');
nbsep=size(seph,2);

switch nbsep
    case 0
        head(1).er = line; %#ok<NASGU>
    case 1
        head(1).er = line(1:seph(1)-1);
        head(2).er = line(seph(1)+1:end); %#ok<NASGU>
    otherwise
        format='%s%s';
        head(1).er = line(1:seph(1)-1);
        for i=2:nbsep
            format=[format '%s']; %#ok<AGROW>
            head(i).er=line(seph(i-1)+1:seph(i)-1); %#ok<AGROW>
        end
        head(i+1).er = line(seph(i)+1:end); %#ok<NASGU>
end

cp=0; clear segarray;
while ~feof(fid)
   cp=cp+1;
   blk_ctl =1;
   output = zeros(block_size, nbsep,100);
   while((blk_ctl<=block_size)&& ~feof(fid))
       line=fgetl(fid);
       seph=find(line==',');
       output(blk_ctl,1,1) = str2num(line(1:seph(1)-1));
       for cnt = 2:nbsep
           sizeofstr = size(line(seph(cnt-1)+1:seph(cnt)-1),2);
           output(blk_ctl,cnt,:)=line(seph(cnt-1)+1:seph(cnt)-1)+zeros(100-sizeofstr);
       end
   end
   save([foldout '/' nameout '_' int2str(block_size) '_' int2str(cp) '.mat'], output);
end

fclose(fid);

end

