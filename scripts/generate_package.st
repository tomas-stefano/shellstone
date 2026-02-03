#!/usr/bin/env gst
"Generate package.xml with proper load ordering"

| categories files stream |

"Define load order by category (dependencies must come first)"
categories := OrderedCollection new
    add: #('Support utilities' 'shellstone/support/color_output.st' 'shellstone/support/example_result.st');
    add: #('Expectations - base classes' 'shellstone/expectations/expectation_failed.st' 'shellstone/expectations/matchers/base_matcher.st');
    add: #('Matchers'
        'shellstone/expectations/matchers/equal.st'
        'shellstone/expectations/matchers/be.st'
        'shellstone/expectations/matchers/be_kind_of.st'
        'shellstone/expectations/matchers/respond_to.st'
        'shellstone/expectations/matchers/include.st'
        'shellstone/expectations/matchers/match.st'
        'shellstone/expectations/matchers/raise_error.st'
        'shellstone/expectations/matchers/change.st'
        'shellstone/expectations/matchers/comparison.st');
    add: #('Expectation handlers'
        'shellstone/expectations/expectation_target.st'
        'shellstone/expectations/positive_handler.st'
        'shellstone/expectations/negative_handler.st'
        'shellstone/expectations/should.st');
    add: #('Core DSL'
        'shellstone/core/metadata.st'
        'shellstone/core/pending.st'
        'shellstone/core/let_definition.st'
        'shellstone/core/hooks.st'
        'shellstone/core/example.st'
        'shellstone/core/example_group.st'
        'shellstone/core/world.st'
        'shellstone/core/describe.st');
    add: #('Mocks'
        'shellstone/mocks/method_stub.st'
        'shellstone/mocks/message_expectation.st'
        'shellstone/mocks/double.st'
        'shellstone/mocks/spy.st');
    add: #('Formatters'
        'shellstone/support/formatters/base_formatter.st'
        'shellstone/support/formatters/progress_formatter.st'
        'shellstone/support/formatters/documentation_formatter.st'
        'shellstone/support/formatters/html_formatter.st'
        'shellstone/support/formatters/json_formatter.st'
        'shellstone/support/formatters/failures_formatter.st');
    add: #('Support - CLI and runner'
        'shellstone/support/filter_manager.st'
        'shellstone/support/ordering.st'
        'shellstone/support/profiler.st'
        'shellstone/support/reporter.st'
        'shellstone/support/options_parser.st'
        'shellstone/support/runner.st');
    yourself.

"Collect all files in order"
files := OrderedCollection new.
categories do: [:cat |
    cat allButFirst do: [:f | files add: f]
].

"Generate package.xml"
stream := 'package.xml' asFile writeStream.

stream nextPutAll: '<package>'; nl.
stream nextPutAll: '  <name>ShellStone</name>'; nl.
stream nextPutAll: '  <namespace>ShellStone</namespace>'; nl.

"Write filein entries grouped by category"
categories do: [:cat | | comment |
    comment := cat first.
    stream nl.
    stream nextPutAll: '  <!-- '; nextPutAll: comment; nextPutAll: ' -->'; nl.
    cat allButFirst do: [:f |
        stream nextPutAll: '  <filein>'; nextPutAll: f; nextPutAll: '</filein>'; nl
    ].
].

"Write file entries for distribution"
stream nl.
stream nextPutAll: '  <!-- Package files for distribution -->'; nl.
files do: [:f |
    stream nextPutAll: '  <file>'; nextPutAll: f; nextPutAll: '</file>'; nl
].

stream nextPutAll: '</package>'; nl.
stream close.

'package.xml generated successfully.' displayNl.
