import sounddevice as sd
import numpy as np
import os
import shutil

if __name__ == '__main__':
	for i in range(1):
		fs = 8000  # Sample rate
		seconds = 1  # Duration of recording
		data = sd.rec(int(seconds * fs), samplerate=fs, channels=1)
		sd.wait()  # Wait until recording is finished
		data = data.astype('float32')
		np.savetxt("data.csv", data, delimiter=",")
		x = os.system("./raspi_model.elf")
		if(x == 256):
			dirs = os.listdir("Coughs")
			cough_count = len(dirs)
			src = 'data.csv'
			dst = 'Coughs/Cough_' + str(cough_count + 1) + '.csv'
			shutil.copyfile(src, dst)
