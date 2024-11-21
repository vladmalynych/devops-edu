from flask import Flask, render_template
# import debugpy
# debugpy.listen(("0.0.0.0", 5555))
# print("Debugger is listening on port 5555. Attach your debugger to continue.")
# debugpy.wait_for_client()
# debugpy.breakpoint()

app = Flask(__name__)

@app.route("/")
def index():
    # import web_pdb; web_pdb.set_trace()
    return render_template("index.html")

if __name__ == "__main__":
    app.run(port=8000, use_reloader=True)
