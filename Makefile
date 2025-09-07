default: serve

serve-venv:
ifeq ($(OS),Windows_NT)
	@python -m venv venv && venv\Scripts\activate && pip install -r requirements.txt && mkdocs serve
else
	@python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && mkdocs serve
endif

serve:
	@pip install -r requirements.txt \
	&& mkdocs serve
