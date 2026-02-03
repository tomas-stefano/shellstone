# ShellStone Makefile
# GNU Smalltalk testing framework

GST = gst
GST_PACKAGE = gst-package
PACKAGE_XML = package.xml

# Source directories
SPEC_DIR = spec
FEATURES_DIR = features

# Extract source files from package.xml (single source of truth)
SRC_FILES := $(shell grep '<filein>' $(PACKAGE_XML) | sed 's/.*<filein>\(.*\)<\/filein>/\1/')

# Find spec files
SPEC_FILES := $(shell find $(SPEC_DIR) -name '*_spec.st' | sort)
FEATURE_FILES := $(shell find $(FEATURES_DIR) -name '*_spec.st' | sort)

.PHONY: all test spec features clean help validate install uninstall

# Default target
all: test

# Run all specs
test: spec

# Run unit specs
spec:
	@echo "Running specs..."
	@$(GST) $(SRC_FILES) $(SPEC_DIR)/spec_helper.st $(SPEC_FILES) scripts/run_specs.st

# Run feature specs
features:
	@echo "Running feature specs..."
	@$(GST) $(SRC_FILES) $(FEATURE_FILES) scripts/run_specs.st

# Run all tests (specs + features)
all-tests: spec features

# Run specs with documentation format
spec-doc:
	@echo "Running specs (documentation format)..."
	@$(GST) $(SRC_FILES) $(SPEC_DIR)/spec_helper.st $(SPEC_FILES) scripts/run_specs_doc.st

# Validate package loads correctly
validate:
	@echo "Validating package..."
	@$(GST) $(SRC_FILES) scripts/validate.st

# List source files (useful for debugging)
list-files:
	@echo "Source files from package.xml:"
	@for f in $(SRC_FILES); do echo "  $$f"; done

# Clean generated files
clean:
	@rm -f *.log
	@rm -f coverage.html
	@echo "Cleaned."

# Install package to system
install:
	@echo "Installing ShellStone..."
	@$(GST_PACKAGE) -t ~/.st $(PACKAGE_XML)

# Uninstall package from system
uninstall:
	@echo "Uninstalling ShellStone..."
	@$(GST_PACKAGE) -t ~/.st --uninstall ShellStone

# Show help
help:
	@echo "ShellStone Makefile"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  test          Run unit specs (default)"
	@echo "  spec          Run unit specs"
	@echo "  spec-doc      Run specs with documentation format"
	@echo "  features      Run feature specs"
	@echo "  all-tests     Run all tests (specs + features)"
	@echo "  validate      Validate package loads correctly"
	@echo "  list-files    Show source files from package.xml"
	@echo "  install       Install package to ~/.st"
	@echo "  uninstall     Uninstall package"
	@echo "  clean         Remove generated files"
	@echo "  help          Show this help"
