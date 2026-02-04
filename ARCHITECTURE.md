# ShellStone Architecture

## GNU Smalltalk

### Table of Contents

| Package | Class | Purpose |
|---------|-------|---------|
| **core** | `Describe` | DSL entry point (`Describe the: 'Subject' do:`) |
| | `ExampleGroup` | Container for examples and nested groups |
| | `Example` | Single test case (`it: 'does X' do:`) |
| | `World` | Singleton registry of all example groups |
| | `HookCollection` | Manages before/after hooks |
| | `LetContainer` | Lazy-evaluated let bindings |
| | `Metadata` | Tags and location info |
| | `Pending` | Signal for pending examples |
| **expectations** | `ExpectationTarget` | Wraps actual value (`expect: value`) |
| | `PositiveHandler` | Handles `to` assertions |
| | `NegativeHandler` | Handles `toNot` assertions |
| | `ExpectationFailed` | Exception for failed assertions |
| **matchers** | `BaseMatcher` | Abstract matcher base |
| | `EqualMatcher` | `equal:` |
| | `BeMatcher` | `beTrue`, `beFalsy`, `beNil` |
| | `BeKindOfMatcher` | `beA:`, `beKindOf:` |
| | `ComparisonMatcher` | `beGreaterThan:`, `beLessThan:` |
| | `IncludeMatcher` | `include:` |
| | `MatchMatcher` | `match:` (regex) |
| | `RaiseErrorMatcher` | `raiseError`, `raiseError:` |
| | `RespondToMatcher` | `respondTo:` |
| | `ChangeMatcher` | `change:` |
| **mocks** | `Double` | Test double with stubbed methods |
| | `Spy` | Wraps real object, records calls |
| | `MethodStub` | Single stubbed method |
| | `MessageExpectation` | Expected message call |
| **support** | `Runner` | CLI entry point, orchestrates execution |
| | `ExampleResult` | Pass/fail/pending result |
| | `Reporter` | Collects and reports results |
| | `ColorOutput` | ANSI terminal colors |
| | `OptionsParser` | CLI argument parsing |
| | `FilterManager` | Filters examples by tag/pattern |
| | `Profiler` | Tracks slowest examples |
| **formatters** | `BaseFormatter` | Abstract output formatter |
| | `ProgressFormatter` | Dots output (default) |
| | `DocumentationFormatter` | Nested descriptions |
| | `FailuresFormatter` | Only failures |
| | `JsonFormatter` | JSON output |
| | `HtmlFormatter` | HTML report |

### Flow

```
Describe the: → ExampleGroup → Example(s)
                    ↓
               World.register
                    ↓
Runner.start → World.runAll → ExampleGroup.run → Example.runWithHooks
                    ↓                                    ↓
               Reporter.add                     PositiveHandler.handleMatcher
                    ↓                                    ↓
          ProgressFormatter.print              Matcher.matches → pass/fail
```

---

## Pharo

### Table of Contents

| Package | Class | Purpose |
|---------|-------|---------|
| **ShellStone-Support** | `Sh` | DSL entry point (`Sh describe:`, `Sh expect:`) |
| | `ShRunner` | Colored CLI output, runs all specs |
| | `ShSpecRunner` | Bridges ShellStone to SUnit TestCase |
| | `ShCommandLineHandler` | `./pharo Pharo.image shellstone` |
| **ShellStone-Core** | `ShDescribe` | Creates example groups |
| | `ShExampleGroup` | Container for examples and nested groups |
| | `ShExample` | Single test case |
| | `ShWorld` | Singleton registry (same pattern as GNU) |
| | `ShHook` | Single hook (before/after) |
| | `ShHookCollection` | Manages hooks |
| | `ShLetContainer` | Lazy-evaluated let bindings |
| | `ShLetDefinition` | Single let binding |
| | `ShMetadata` | Tags and location info |
| | `ShExampleResult` | Pass/fail/pending result |
| | `ShExpectationFailed` | Exception for failed assertions |
| | `ShPendingExample` | Exception for pending |
| **ShellStone-Expectations** | `ShExpectationTarget` | Wraps actual value |
| | `ShPositiveHandler` | Handles `to` assertions |
| | `ShNegativeHandler` | Handles `toNot` assertions |
| **ShellStone-Matchers** | `ShBaseMatcher` | Abstract matcher base |
| | `ShEqualMatcher` | `equal:` |
| | `ShBeMatcher` | `beTrue`, `beFalsy`, `beNil` |
| | `ShBeKindOfMatcher` | `beA:`, `beKindOf:` |
| | `ShComparisonMatcher` | `beGreaterThan:`, `beLessThan:` |
| | `ShIncludeMatcher` | `include:` |
| | `ShMatchMatcher` | `match:` |
| | `ShRaiseErrorMatcher` | `raiseError`, `raiseError:` |
| | `ShRespondToMatcher` | `respondTo:` |
| | `ShChangeMatcher` | `change:` |
| **ShellStone-Mocks** | `ShDouble` | Test double |
| | `ShSpy` | Spy on real objects |
| | `ShMethodStub` | Stubbed method |
| | `ShMessageExpectation` | Expected call |
| **BaselineOfShellStone** | `BaselineOfShellStone` | Metacello package config |

### Flow

```
Sh describe: → ShDescribe.the: → ShExampleGroup → ShExample(s)
                                      ↓
                               ShWorld.register
                                      ↓
      ShRunner.run → ShWorld.allExamples → ShExample.runWithHooks
            ↓                                     ↓
    colored output                      ShPositiveHandler.handleMatcher
                                                  ↓
                                        ShMatcher.matches → pass/fail
```

### Pharo-Specific: SUnit Bridge

`ShSpecRunner` extends `TestCase` to integrate with Pharo's test infrastructure:

1. `loadSpecs` - Loads spec files, registers in `ShWorld`
2. `collectExamples` - Pulls examples from `ShWorld` into class var
3. `buildSuiteFromMethods` - Creates synthetic test methods from examples
4. `runCase` - Runs single example with hooks from group hierarchy

---

## Key Differences

| Aspect | GNU Smalltalk | Pharo |
|--------|---------------|-------|
| Namespace | `ShellStone.` prefix | `Sh` prefix on classes |
| Entry point | `Describe the:` | `Sh describe:` |
| Expect syntax | `self expect:` in block | `Sh expect:` |
| CLI | `bin/shellstone` (gst) | `ShCommandLineHandler` |
| Test integration | Standalone `Runner` | Bridges to `SUnit` |
| Exception chaining | `on: A do: on: B do:` | `on: A, B do:` |
