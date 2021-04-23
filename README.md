# Chatterino Wiki

This is the source code of the wiki hosted at https://wiki.chatterino.com

## Making changes

This source code of this wiki is managed through `git`.
Search for a guide for making a pull request on GitHub if you are new to the process.

## Running locally

In case you want to try and run the wiki locally follow these steps (requires python 3):

- You can use `make serve` or `make serve-venv` to use a virtual environment.

Or you can run these commands manually:

- _Optionally_ create and enter a virtual environment: `python3 -m venv venv && source venv/bin/activate`
- Run `pip install -r requirements.txt`
- Run `mkdocs serve`
- Navigate to `localhost:8000` in your browser
