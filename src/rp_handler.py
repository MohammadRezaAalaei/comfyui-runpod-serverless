import runpod
import os
import json
import subprocess

def handler(job):
    workflow = job["input"].get("workflow", {})
    with open("/tmp/workflow.json", "w") as f:
        json.dump(workflow, f)
    
    # Models are preloaded in /comfyui/models, no download needed
    subprocess.run(["python", "main.py", "--input", "/tmp/workflow.json", "--output", "/tmp/output"])
    
    with open("/tmp/output/output.png", "rb") as f:
        output = f.read()
    return {"output": output.hex()}

runpod.serverless.start({"handler": handler})
