from flask import Flask, request

import subprocess

app = Flask(__name__)

# ✅ Add a home route to prevent 404 errors
@app.route('/')
def home():
    return "Flask server is running! Use /run-script?script=your_script.sh"

@app.route('/run-script', methods=['GET'])
def run_script():
    script_name = request.args.get('script')
    try:
        output = subprocess.check_output(["bash", f"./scripts/{script_name}"], stderr=subprocess.STDOUT)
        return output.decode('utf-8')
    except subprocess.CalledProcessError as e:
        return f"Error: {e.output.decode('utf-8')}", 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
