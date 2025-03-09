from flask import Flask, request, send_from_directory, jsonify
import subprocess
import os

app = Flask(__name__, static_folder='static')

# ✅ Serve index.html as the homepage
@app.route('/')
def home():
    return send_from_directory('.', 'index.html')  # Ensure '.' is used correctly

# ✅ Serve static files (CSS, JS, etc.)
@app.route('/static/<path:filename>')
def serve_static(filename):
    return send_from_directory('static', filename)

# ✅ Route to execute scripts
@app.route('/run-script', methods=['GET'])
def run_script():
    script_name = request.args.get('script')

    # ✅ Ensure the script exists
    script_path = os.path.join("scripts", script_name)
    if not os.path.isfile(script_path):
        return jsonify({"error": f"Script {script_name} not found"}), 404

    try:
        # ✅ Execute script and return output
        output = subprocess.check_output(["bash", script_path], stderr=subprocess.STDOUT)
        return jsonify({"success": True, "output": output.decode('utf-8')})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": e.output.decode('utf-8')}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
