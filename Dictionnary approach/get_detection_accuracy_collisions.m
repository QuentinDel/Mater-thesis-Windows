    
function [thresh, F1] = get_detection_accuracy_collisions(UE_dos, detect_init, detect, training_part)
stream_col=detect-detect_init; % get stream of jamming collisions 1 means jamming collision

packet_size=40;
pat= 1*ones(1,packet_size);
jam=strfind(stream_col,pat); % get positions of jamming collisions

pat= 2*ones(1,packet_size);
col=strfind(detect,pat); %  get positions of all collisions in detect streams
col(2,1)=0;%create 2nd string

for i=1:length(jam)
    for j=1:length(col) 
        if jam(i)==col(1,j)
            col(2,j)=1; % set to 1 if a collision is a jamming collision
        end
    end    
end



n_c=sum(detect(1,training_part:end )==2)/40; %get the slot number when the jamming has started.

col_rel=col(:,end-n_c+1:end  ); %take only those collision which happened  after the jamming started.
UE_dos_rel=UE_dos(:,end-n_c+1:end  ); %take only anomaly scores for collisions which happened  after the jamming started.

%THR=0:0.25:80; % make a range of threholds values

[thresh, F1] = selectThreshold(col_rel(2,:), UE_dos_rel);

% for i=1:length(THR) % for each threholds value check the number of detected jamming collisions and the number of missdetected healthy collisions 
% thr=THR(i);
% anomaly=double(UE_dos_rel>thr);
% anomaly_cor=and(col_rel(2,:), anomaly);
% anomaly_false=((anomaly-col_rel(2,:))==1)  ;
% RATIO(i,1:3)=  [thr, sum( anomaly_cor ),sum( anomaly_false ) ];
end