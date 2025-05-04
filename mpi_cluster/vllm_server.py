#!/usr/bin/env python3
"""
Run vLLM’s OpenAI‑compatible server *and* expose /shutdown on the **same port**.

Usage (identical to `vllm serve`):

  python vllm_single_port.py \
      --model mistralai/Mistral-7B-Instruct-v0.2 \
      --gpu-memory-utilization 0.85 \
      --max-model-len 4096 \
      --port 8000                  # <‑ only one port!
"""
import os
import signal
import threading
import uvicorn
from argparse import Namespace, ArgumentParser
from vllm.entrypoints.openai.cli_args import (
    make_arg_parser, validate_parsed_serve_args
)
from vllm.entrypoints.openai.api_server import build_app   # ← correct helper

# ---------------------------------------------------------------------
# 1. Parse exactly the same arguments that `vllm serve` understands
# ---------------------------------------------------------------------
parser: ArgumentParser = make_arg_parser(ArgumentParser())
args: Namespace = parser.parse_args()
validate_parsed_serve_args(args)          # enforces required flags

# ---------------------------------------------------------------------
# 2. Build the vLLM FastAPI app
# ---------------------------------------------------------------------
app = build_app(args)                     # <- creates the complete API

# ---------------------------------------------------------------------
# 3. Add your own endpoint(s) on the SAME app
# ---------------------------------------------------------------------
@app.post("/shutdown")
async def shutdown():
    """Gracefully stop Uvicorn and the engine."""
    def _stop():
        print("Shutting down vLLM …")
        os.kill(os.getpid(), signal.SIGINT)   # lets Uvicorn close cleanly
    threading.Thread(target=_stop).start()
    return {"message": "Server is shutting down..."}

# ---------------------------------------------------------------------
# 4. Launch Uvicorn on the single port the user requested
# ---------------------------------------------------------------------
if __name__ == "__main__":
    uvicorn.run(
        app,
        host=args.host or "0.0.0.0",
        port=args.port,
        log_level=args.uvicorn_log_level,
        access_log=not args.disable_uvicorn_access_log,
        ssl_keyfile=args.ssl_keyfile,
        ssl_certfile=args.ssl_certfile,
        ssl_ca_certs=args.ssl_ca_certs,
    )
