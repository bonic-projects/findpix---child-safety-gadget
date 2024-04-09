import serial
import time

# Define the COM port and baud rate
COM_PORT = 'COM16'
BAUD_RATE = 115200

# Function to send 'ATA' command when a call is received
def handle_incoming_call(serial_port):
    # Wait for 'RING' text
    while True:
        if serial_port.in_waiting > 0:
            try:
                incoming_data = serial_port.readline().decode('utf-8', errors='ignore').strip()
                print("Raw data:", incoming_data)  # Print raw data for debugging
                if 'RING' in incoming_data:
                    print("Incoming call detected.")
                    serial_port.write(b'ATA\r\n')
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
