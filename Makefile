# Ensure pip and pytest can only be called from within a python virtual environment
ifndef VIRTUAL_ENV
VIRTUALENV_HELP := Use 'make venv' to automatically create a pre-configured virtualenv.
endif

# -----------------------
# Functions
# -----------------------

define ERROR
	(echo -en "\nERROR: [$@]: $(1)\n\n" && exit 1)
endef

# ---------
# Variables
# ---------

PROJECT := ernaie

# -------
# Targets
# -------

# optional: create virtualenv in working directory
venv:
	@echo "Creating pre-configured virtualenv ..."
	python3.8 -m venv venv
	./venv/bin/pip install --upgrade pip
	@echo "Use 'source venv/bin/activate' to activate the virtualenv."

# install requirements and project in python environment
init.marker: setup.py setup.cfg
	$(pip) install --upgrade "pip==19.3.1" "setuptools==51.1.0"
	$(pip) install -e .[test] && touch init.marker
init: init.marker
.PHONY: init

# remove unecessary files and directories as well as the python virtual environment if not active
clean:
	@rm -rfv *.marker .cache .coverage coverage.xml $(PROJECT).egg-info docs/_build dist build $(PROJECT)-*.whl `find $(PROJECT) -name __pycache__ -or -name *.pyc` rpmbuild
	@if [ "$(VIRTUAL_ENV)" = "$(shell pwd)/venv" ]; then \
		echo "Automatically created virtualenv is still active. Use 'deactivate' and run 'make $@' again."; \
	else \
		rm -rfv venv; \
	fi
