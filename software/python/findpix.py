import serial
import time
import numpy as np
import pyaudio
import wave

# Define the COM port and baud rate
COM_PORT = 'COM16'
BAUD_RATE = 115200

# Global variable to indicate recording status
RECORDING = False

# Audio recording parameters
CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 2
RATE = 44100
RECORDING_DURATION = 10  # Duration in seconds

# Function to start audio recording
def start_recording():
    global RECORDING
    RECORDING = True
    print("Recording started.")
    frames = []
    try:
        audio = pyaudio.PyAudio()
        stream = audio.open(format=FORMAT,
                            channels=CHANNELS,
                            rate=RATE,
                            input=True,
                            frames_per_buffer=CHUNK)

        start_time = time.time()
        while RECORDING:
            data = stream.read(CHUNK)
            frames.append(data)
            if time.time() - start_time >= RECORDING_DURATION:
                stop_recording()
                break

        stream.stop_stream()
        stream.close()
        audio.terminate()

        audio_data = np.frombuffer(b''.join(frames), dtype=np.int16)
        return audio_data
    except Exception as e:
        print("Error during recording:", e)
        return None

# Function to stop audio recording
def stop_recording():
    global RECORDING
    RECORDING = False
    print("Recording stopped.")

# Function to save audio data as WAV file
def save_as_wav(audio_data):
    try:
        with wave.open('recorded_audio.wav', 'wb') as wf:
            wf.setnchannels(CHANNELS)
            wf.setsampwidth(2)  # 16-bit audio
            wf.setframerate(RATE)
            wf.writeframes(audio_data.tobytes())
        print("Audio saved as WAV.")
    except Exception as e:
        print("Error saving audio as WAV:", e)

# Function to send 'ATA' command when a call is received
def handle_incoming_call(serial_port):
    global RECORDING
    # Wait for 'RING' text
    while True:
        if serial_port.in_waiting > 0:
            try:
                incoming_data = serial_port.readline().decode('utf-8', errors='ignore').strip()
                print("Raw data:", incoming_data)  # Print raw data for debugging
                if 'RING' in incoming_data:
                    print("Incoming call detected.")
                    serial_port.write(b'ATA\r\n')
                    audio_data = start_recording()  # Start audio recording when call is attended
                    if audio_data is None:
                        print("Failed to start recording.")
                    else:
                        stop_recording()  # Stop audio recording when call ends
                        save_as_wav(audio_data)  # Save recorded audio as WAV
                elif 'NO CARRIER' in incoming_data:
                    print("Call ended.")
                    if RECORDING:
                        stop_recording()  # Stop audio recording when call ends
                        save_as_wav(audio_data)  # Save recorded audio as WAV
                    break
            except UnicodeDecodeError:
                print("Error decoding incoming data.")
                continue

# Main function
def main():
    # Open serial port
    try:
        ser = serial.Serial(COM_PORT, BAUD_RATE, timeout=1)
        print(f"Serial port {COM_PORT} opened successfully.")
    except serial.SerialException:
        print(f"Failed to open serial port {COM_PORT}.")
        return

    # Main loop
    while True:
        handle_incoming_call(ser)
        time.sleep(1)  # Adjust sleep time as needed

    # Close serial port
    ser.close()
    print("Serial port closed.")

if __name__ == "__main__":
    main()
