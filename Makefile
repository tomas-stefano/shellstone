# ShellStone Makefile
# Cross-Smalltalk testing framework

GST = gst
GST_PACKAGE = gst-package
PACKAGE_XML = package.xml
PHARO_VERSION ?= 120

# Source directories
SPEC_DIR = gnu-specs
FEATURES_DIR = features

# Extract source files from package.xml (single source of truth)
SRC_FILES := $(shell grep '<filein>' $(PACKAGE_XML) | sed 's/.*<filein>\(.*\)<\/filein>/\1/')

# Find spec files
SPEC_FILES := $(shell find $(SPEC_DIR) -name '*_spec.st' | sort)
FEATURE_FILES := $(shell find $(FEATURES_DIR) -name '*_spec.st' | sort)

.PHONY: all test spec features clean help validate install uninstall pharo-spec pharo-test

# Default target
all: test

# Run all specs (GNU Smalltalk)
test: spec

# Run unit specs
spec:
	@echo "Running specs..."
	@echo "ShellStone.Runner new start." | $(GST) $(SRC_FILES) $(SPEC_DIR)/spec_helper.st $(SPEC_FILES) /dev/stdin

# Run feature specs
features:
	@echo "Running feature specs..."
	@echo "ShellStone.Runner new start." | $(GST) $(SRC_FILES) $(FEATURE_FILES) /dev/stdin

# Run all tests (specs + features)
all-tests: spec features

# Run specs with documentation format
spec-doc:
	@echo "Running specs (documentation format)..."
	@echo "| r | r := ShellStone.Runner new. r options format: 'documentation'. r start." | $(GST) $(SRC_FILES) $(SPEC_DIR)/spec_helper.st $(SPEC_FILES) /dev/stdin

# Validate package loads correctly
validate:
	@echo "Validating package..."
	@echo "'Package loaded successfully.' displayNl." | $(GST) $(SRC_FILES) /dev/stdin

# List source files (useful for debugging)
list-files:
	@echo "Source files from package.xml:"
	@for f in $(SRC_FILES); do echo "  $$f"; done

# Run Pharo specs
pharo-spec:
	@echo "Running Pharo specs..."
	@if [ ! -f Pharo.image ]; then \
		echo "Downloading Pharo $(PHARO_VERSION)..."; \
		curl -sL https://get.pharo.org/$(PHARO_VERSION) | bash > /dev/null 2>&1; \
	fi
	@./pharo Pharo.image eval --save "Metacello new baseline: 'ShellStone'; repository: 'tonel://$(shell pwd)/pharo-src'; load." 2>/dev/null || true
	@./pharo Pharo.image eval " \
		| passed failed pending | \
		passed := 0. failed := 0. pending := 0. \
		SSSpecRunner allSubclasses do: [ :specClass | \
			specClass buildSuiteFromMethods tests do: [ :test | \
				test currentExample ifNotNil: [ :ex | \
					ex isPending \
						ifTrue: [ pending := pending + 1 ] \
						ifFalse: [ \
							[ test runCase. passed := passed + 1 ] \
								on: Error, TestFailure \
								do: [ :e | failed := failed + 1. \
									Transcript show: 'F'. \
									Transcript show: ex fullDescription; show: ' FAILED: '; show: e messageText; cr ] ] ] ] ]. \
		Transcript cr; show: passed; show: ' passed, '; show: failed; show: ' failed, '; show: pending; show: ' pending'; cr. \
		failed > 0 ifTrue: [ Smalltalk exit: 1 ]"

# Alias for pharo-spec
pharo-test: pharo-spec

# Run tests on all platforms
test-all: spec pharo-spec

# Clean generated files
clean:
	@rm -f *.log
	@rm -f coverage.html
	@rm -rf Pharo* pharo* *.image *.changes package-cache
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
	@echo "GNU Smalltalk:"
	@echo "  test          Run unit specs (default)"
	@echo "  spec          Run unit specs"
	@echo "  spec-doc      Run specs with documentation format"
	@echo "  features      Run feature specs"
	@echo "  validate      Validate package loads correctly"
	@echo "  install       Install package to ~/.st"
	@echo "  uninstall     Uninstall package"
	@echo ""
	@echo "Pharo:"
	@echo "  pharo-spec    Run Pharo specs (requires smalltalkCI)"
	@echo ""
	@echo "Cross-platform:"
	@echo "  test-all      Run tests on all platforms"
	@echo ""
	@echo "Other:"
	@echo "  list-files    Show source files from package.xml"
	@echo "  clean         Remove generated files"
	@echo "  help          Show this help"
	@echo ""
	@echo "Set PHARO_VERSION to change Pharo version (default: 120)"
