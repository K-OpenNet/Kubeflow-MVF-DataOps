import subprocess
import sys
import os
import requests

from flask import Flask
app = Flask(__name__)

@app.route('/hello')
def hello_world():
  #cmd = "kubectl get nodes"
  #out = subprocess.check_output([cmd], shell=True)
  #print(out)
  #print(type(out))
  return 'hello world'

if __name__ == '__main__':
  app.run(host="203.237.53.192", port=5001)

