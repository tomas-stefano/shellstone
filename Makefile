# ShellStone Makefile
# GNU Smalltalk testing framework

GST = gst
GST_PACKAGE = gst-package
PACKAGE_XML = package.xml

# Source directories
SRC_DIR = shellstone
SPEC_DIR = spec
FEATURES_DIR = features

# Source files in load order (dependencies first)
SRC_FILES = \
	shellstone/support/color_output.st \
	shellstone/support/example_result.st \
	shellstone/expectations/expectation_failed.st \
	shellstone/expectations/matchers/base_matcher.st \
	shellstone/expectations/matchers/equal.st \
	shellstone/expectations/matchers/be.st \
	shellstone/expectations/matchers/be_kind_of.st \
	shellstone/expectations/matchers/respond_to.st \
	shellstone/expectations/matchers/include.st \
	shellstone/expectations/matchers/match.st \
	shellstone/expectations/matchers/raise_error.st \
	shellstone/expectations/matchers/change.st \
	shellstone/expectations/matchers/comparison.st \
	shellstone/expectations/expectation_target.st \
	shellstone/expectations/positive_handler.st \
	shellstone/expectations/negative_handler.st \
	shellstone/expectations/should.st \
	shellstone/core/metadata.st \
	shellstone/core/pending.st \
	shellstone/core/let_definition.st \
	shellstone/core/hooks.st \
	shellstone/core/example.st \
	shellstone/core/example_group.st \
	shellstone/core/world.st \
	shellstone/core/describe.st \
	shellstone/mocks/method_stub.st \
	shellstone/mocks/message_expectation.st \
	shellstone/mocks/double.st \
	shellstone/mocks/spy.st \
	shellstone/support/formatters/base_formatter.st \
	shellstone/support/formatters/progress_formatter.st \
	shellstone/support/formatters/documentation_formatter.st \
	shellstone/support/formatters/html_formatter.st \
	shellstone/support/formatters/json_formatter.st \
	shellstone/support/formatters/failures_formatter.st \
	shellstone/support/filter_manager.st \
	shellstone/support/ordering.st \
	shellstone/support/profiler.st \
	shellstone/support/reporter.st \
	shellstone/support/options_parser.st \
	shellstone/support/runner.st

# Find spec files
SPEC_FILES := $(shell find $(SPEC_DIR) -name '*_spec.st' | sort)
FEATURE_FILES := $(shell find $(FEATURES_DIR) -name '*_spec.st' | sort)

.PHONY: all test spec features package clean help validate install uninstall

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

# Update package.xml with proper ordering
package:
	@echo "Updating $(PACKAGE_XML)..."
	@$(GST) scripts/generate_package.st

# Validate package loads correctly
validate:
	@echo "Validating package..."
	@$(GST) $(SRC_FILES) scripts/validate.st

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
	@echo "  package       Update package.xml with proper ordering"
	@echo "  validate      Validate package loads correctly"
	@echo "  install       Install package to ~/.st"
	@echo "  uninstall     Uninstall package"
	@echo "  clean         Remove generated files"
	@echo "  help          Show this help"
