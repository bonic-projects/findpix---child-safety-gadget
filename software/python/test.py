import serial
import time

# Define the COM port and baud rate
COM_PORT = 'COM16'
BAUD_RATE = 115200

# Function to send a command and receive response
def send_command(serial_port, command):
    # Send command
    serial_port.write(command.encode('utf-8') + b'\r\n')
    print("Command sent:", command)

    # Wait for response
    response = b''
    while True:
        if serial_port.in_waiting > 0:
            response += serial_port.read(serial_port.in_waiting)
            if b'\r\n' in response:
                break

    # Decode and return response
    response = response.decode('utf-8').strip()
    print("Response:", response)
    return response

# Main function
def main():
    # Open serial port
    try:
        ser = serial.Serial(COM_PORT, BAUD_RATE, timeout=1)
        print(f"Serial port {COM_PORT} opened successfully.")
    except serial.SerialException:
        print(f"Failed to open serial port {COM_PORT}.")
        return

    # Test: Send a command and receive response
    command = "AT"
    response = send_command(ser, command)
    print(response)

    # Close serial port
    ser.close()
    print("Serial port closed.")

if __name__ == "__main__":
    main()
