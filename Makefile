default: serve

serve-venv:
ifeq ($(OS),Windows_NT)
	@python -m venv venv && venv\Scripts\activate && pip install -e . && zensical serve
else
	@python3 -m venv venv && source venv/bin/activate && pip install -e . && zensical serve
endif

serve:
	@pip install -e . \
	&& zensical serve
