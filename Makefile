# ShellStone Makefile
# Cross-platform testing framework for Smalltalk

#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------

PHARO_VERSION ?= 120
GST           ?= gst
GST_PACKAGE   ?= gst-package
TMP_DIR       := tmp

#------------------------------------------------------------------------------
# Default target - run specs on all platforms
#------------------------------------------------------------------------------

.PHONY: all
all: test-all

#------------------------------------------------------------------------------
# Pharo targets
#------------------------------------------------------------------------------

.PHONY: pharo-spec pharo-clean

# Absolute path to project root
PROJECT_ROOT := $(shell pwd)

# Run Pharo specs
pharo-spec:
	@echo "Running Pharo specs..."
	@mkdir -p $(TMP_DIR)
	@if [ ! -f $(TMP_DIR)/Pharo.image ]; then \
		echo "Downloading Pharo $(PHARO_VERSION)..."; \
		cd $(TMP_DIR) && curl -sL https://get.pharo.org/$(PHARO_VERSION)+vm | bash > /dev/null 2>&1; \
	fi
	@cd $(TMP_DIR) && ./pharo Pharo.image eval --save \
		"Metacello new baseline: 'ShellStone'; repository: 'tonel://$(PROJECT_ROOT)/pharo-src'; load." 2>&1 | grep -v "^MetacelloNotification" || true
	@cd $(TMP_DIR) && ./pharo Pharo.image eval "SSRunner run > 0 ifTrue: [Smalltalk exit: 1]"

# Clean temporary files (Pharo downloads, etc.)
pharo-clean:
	@rm -rf $(TMP_DIR)
	@echo "Cleaned tmp/"

#------------------------------------------------------------------------------
# GNU Smalltalk targets
#------------------------------------------------------------------------------

.PHONY: gnu-spec gnu-spec-doc gnu-features gnu-validate gnu-install gnu-uninstall

# Source and spec files (extracted from package.xml)
GNU_SRC   := $(shell grep '<filein>' package.xml | sed 's/.*<filein>\(.*\)<\/filein>/\1/')
GNU_SPECS := $(shell find gnu-specs -name '*_spec.st' 2>/dev/null | sort)
GNU_FEATURES := $(shell find features -name '*_spec.st' 2>/dev/null | sort)

# Run GNU Smalltalk specs
gnu-spec:
	@echo "Running GNU Smalltalk specs..."
	@echo "ShellStone.Runner new start." | $(GST) $(GNU_SRC) gnu-specs/spec_helper.st $(GNU_SPECS) /dev/stdin

# Run specs with documentation format
gnu-spec-doc:
	@echo "Running GNU Smalltalk specs (documentation format)..."
	@echo "| r | r := ShellStone.Runner new. r options format: 'documentation'. r start." | \
		$(GST) $(GNU_SRC) gnu-specs/spec_helper.st $(GNU_SPECS) /dev/stdin

# Run feature specs
gnu-features:
	@echo "Running GNU Smalltalk feature specs..."
	@echo "ShellStone.Runner new start." | $(GST) $(GNU_SRC) $(GNU_FEATURES) /dev/stdin

# Validate package loads
gnu-validate:
	@echo "Validating GNU Smalltalk package..."
	@echo "'Package loaded successfully.' displayNl." | $(GST) $(GNU_SRC) /dev/stdin

# Install to system
gnu-install:
	@echo "Installing ShellStone to ~/.st..."
	@$(GST_PACKAGE) -t ~/.st package.xml

# Uninstall from system
gnu-uninstall:
	@echo "Uninstalling ShellStone..."
	@$(GST_PACKAGE) -t ~/.st --uninstall ShellStone

#------------------------------------------------------------------------------
# Cross-platform targets
#------------------------------------------------------------------------------

.PHONY: test test-all clean

# Alias for test-all
test: test-all

# Run tests on all platforms
test-all: gnu-spec pharo-spec

# Clean all generated files
clean:
	@rm -rf $(TMP_DIR) *.log coverage.html package-cache
	@echo "Cleaned."

#------------------------------------------------------------------------------
# Help
#------------------------------------------------------------------------------

.PHONY: help

help:
	@echo "ShellStone - Cross-platform Smalltalk testing framework"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Pharo (default):"
	@echo "  pharo-spec     Run Pharo specs (default target)"
	@echo "  pharo-clean    Remove Pharo files"
	@echo ""
	@echo "GNU Smalltalk:"
	@echo "  gnu-spec       Run specs"
	@echo "  gnu-spec-doc   Run specs with documentation format"
	@echo "  gnu-features   Run feature specs"
	@echo "  gnu-validate   Validate package loads"
	@echo "  gnu-install    Install to ~/.st"
	@echo "  gnu-uninstall  Uninstall"
	@echo ""
	@echo "Cross-platform:"
	@echo "  test           Run all specs (default)"
	@echo "  test-all       Run all specs (alias)"
	@echo "  clean          Remove all generated files"
	@echo ""
	@echo "Configuration:"
	@echo "  PHARO_VERSION  Pharo version (default: $(PHARO_VERSION))"
	@echo "  GST            GNU Smalltalk binary (default: gst)"
