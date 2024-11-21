from flask import Flask, render_template
app = Flask(__name__)

@app.route("/")
def index():
    # import web_pdb; web_pdb.set_trace()
    return render_template("index.html")

if __name__ == "__main__":
    app.run(port=8000, use_reloader=True)
