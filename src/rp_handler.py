import runpod
import os
import json
import subprocess

def handler(job):
    # Get the workflow from the job input
    workflow = job["input"].get("workflow", {})
    
    # Save workflow to a temporary file
    with open("/tmp/workflow.json", "w") as f:
        json.dump(workflow, f)
    
    # Run ComfyUI with the workflow
    subprocess.run(["python", "main.py", "--input", "/tmp/workflow.json", "--output", "/tmp/output"])
    
    # Return the result (modify based on your needs)
    with open("/tmp/output/output.png", "rb") as f:
        output = f.read()
    return {"output": output.hex()}

runpod.serverless.start({"handler": handler})
