from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route('/run-script', methods=['GET'])
def run_script():
    script_name = request.args.get('script')
    file_path = request.args.get('path')  # ✅ Get the path from the request

    script_path = os.path.join("/app/scripts", script_name)

    if not os.path.isfile(script_path):
        return jsonify({"error": f"Path {script_path} does not exist!"}), 404

    try:
        # ✅ Pass the file path as an argument
        output = subprocess.check_output(["bash", script_path, file_path], stderr=subprocess.STDOUT)
        return jsonify({"output": output.decode('utf-8'), "success": True})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": e.output.decode('utf-8'), "success": False}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

