
%matlab tests should be a folder that contains all your subjects -> the
%output from the bash scripts that was run before.

cd '/projects/rutwik/2017/STOP-PD/new_tests/testing_errors';
D = dir;

%use counters to ensure numbers are correct
num = 0;
counter =1;

%outer for loop that loops through the output_STOPPD... subject folders
for i = 3:length(D)
    
    %current = D(i).name;
    
    current = fullfile(pwd,D(i).name);
    num = num + 1;
    cd(current);
    
    %find the path to important directories--------------------------------
    
    dcm1_path = fullfile(pwd,'dcmdir1');
    fprintf('the path to dcmdir 1 is: %s\n',dcm1_path);
    
    %this path is not the final path, as there are subfolders in dcmdir2
    dcm2_path = fullfile(pwd,'dcmdir2');
    % fprintf('the path to dcmdir 2 is: %s\n',dcm2_path)
    
    %the moveout path is where the subfolders from dcmdir2 will get copied
    %once they are read, this prevents them interfering with the other
    %subfolders in that directory
    moveout_path = fullfile(pwd,'from_matlab');
    % fprintf('the path to move out is: %s\n',moveout_path)

    %-------------------------------------------------------------------------
    
%     %getting the list of the .7 files in the current directory
%     seven_files = dir('*.7');
 
%      for k=1:length(seven_files)
%         np= seven_files(k).name;
        
%         %need to rename the header and the .7 file to P##### format, the
%         %line below finds the corresponding header file
%         corresponding_header= strcat(np,'.hdr');
        
        
        
%         %changes to the .7 & the header files
%         %----------------------------------------------------------
%         %have to split by delimiter to maintain correct naming convention
%         adjusted_np= strsplit(np,'_');
%         wanted_file = adjusted_np(3);
%         %convert from cell to numeric matrix
%         final_7 =  cell2mat(wanted_file);
        
%         %do the same thing for headers
%         corrected_header = strcat(final_7,'.hdr');
%         %----------------------------------------------------------
        
%         %rename the .7 file to the correct P#####.7 format
%         movefile( np, final_7 );
        
%         %rename the .hdr file to correct format;
%         movefile( corresponding_header, corrected_header);
        
    
%      end
    
    %cycle over the .7 files
    for k=1:length(seven_files)
        np= seven_files(k).name;
        
          
                %create the path for the pfile 
                p_path = fullfile(pwd,np);  
    
        cd(dcm2_path);
        
        D3 = dir;
        for j = 3:length(D3)
            %counter;
            dcm2_sub = D3(j).name;
            %counter = counter+1;
            
            %add the subfolders in dcmdir 2 to path
            dcm2_sub_path = fullfile(pwd,dcm2_sub);
            
            fprintf('the path to p_file is is: %s\n',p_path);

            fprintf('the path to dcmdir 2 is: %s\n',dcm2_sub_path);
            
            %run the main scripts that create the nifti files--------------
            
             %generate the mask nifti files  
             MRS_struct = GannetLoad({p_path});  
             MRS_struct = GannetMask_GE(p_path,dcm1_path,MRS_struct,dcm2_sub_path,1);
             
             
             %save the output image for QC purposes. This figure extraction
             %tool uses a third party function called export_fig, which can
             %be found in a separate folder. Refer to the readme doc for
             %more information
             export_fig( gcf, ...      % figure handle
                 np,... % name of output file without extension
                 '-painters', ...      % renderer
                 '-jpg', ...           % file format
                 '-r72' );             % resolution in dpi
             %--------------------------------------------------------------
             
             %move the subdirectory of dcmdir2 to a different folder so it
             %doesn't interfere with the next iteration of the loop
             movefile (D3(j).name, moveout_path)
             
             %since at the beginning of the loop we changed to dcmdir2, at
             %the end we must change back to the parent directory 
             cd ..
             %need to break the inner loop so the program only checks the
             %first file that is in the dcmdir2 folder
             break
            
        end % end of loop that loops over subdir in dcmdir2
        
    end %end of loop that loops over the .7 files in each subjects folder
    
    %before going to the next subject, move the files from dcmdir 1 to
    %dcmdir 2 because that's where all the outputs are stored
    
    cd(dcm1_path);
    nifti_files = dir('*.nii');
    for m=1:length(nifti_files)
        movefile (nifti_files(m).name, dcm2_path)
    end
       
    
cd '/projects/rutwik/2017/STOP-PD/new_tests/testing_errors';
  
end %end of loop that goes through all subjects in a folder

