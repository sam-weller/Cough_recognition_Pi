import os
import shutil


if __name__ == '__main__':
    folders = os.listdir() # Finds all files in dir
    coughs_counter = 0 # Counter for coughs
    breath_counter = 0 # Counter for breath

    matching = [s for s in folders if "." in s] # Finds all non folders

    # Find only folders
    for i in range(len(matching)):
        folders.remove(matching[i])

    # Main Loop
    for i in range(len(folders)):
        files = os.listdir(folders[i])
        matching = [s for s in files if "." in s] # Check if in right folder

        if(len(matching) == 0):
            for j in range(len(files)):
                dirs = folders[i] + '/' + files[j] # new directory
                files2 = os.listdir(dirs) # Find files

                # Loop through files
                for k in range(len(files2)):
                    # Check if .wav file
                    if(files2[k].endswith(".wav")):
                        src = dirs + '/' + files2[k] # Source directory

                        # If it is a cough file
                        if(files2[k].find("cough") != -1):
                            coughs_counter -=- 1 # Add to counter
                            dst_cough = 'Data/cough/cough_' + str(coughs_counter) + '.wav'# Destination for coughs and rename
                            shutil.copyfile(src, dst_cough) # Copy file

                        # If it is a breath file
                        elif(files2[k].find("breath") != -1):
                            breath_counter -=- 1 # Add to counter
                            dst_breath = 'Data/breath/breath_' + str(breath_counter) + '.wav' # Destination for breaths and rename
                            shutil.copyfile(src, dst_breath) # Copy file



