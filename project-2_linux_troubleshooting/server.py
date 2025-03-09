from flask import Flask, request
import subprocess
import os

app = Flask(__name__)

# ✅ Home route to verify server is running
@app.route('/')
def home():
    return "Flask server is running! Use /run-script?script=your_script.sh"

# ✅ Route to execute scripts
@app.route('/run-script', methods=['GET'])
def run_script():
    script_name = request.args.get('script')

    # ✅ Ensure the script exists
    script_path = os.path.join("scripts", script_name)
    if not os.path.isfile(script_path):
        return f"Error: Script {script_name} not found", 404

    try:
        output = subprocess.check_output(["bash", script_path], stderr=subprocess.STDOUT)
        return output.decode('utf-8')
    except subprocess.CalledProcessError as e:
        return f"Error: {e.output.decode('utf-8')}", 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

