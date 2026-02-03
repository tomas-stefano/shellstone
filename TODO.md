# TODO

## Full BDD Support (Cucumber-like)

- [ ] Gherkin parser for `.feature` files
- [ ] Given/When/Then step definitions
- [ ] Step definition matching (regex or string)
- [ ] Scenario outlines with examples tables
- [ ] Background support
- [ ] Tags for features and scenarios
- [ ] Feature file discovery
- [ ] Step definition generator (missing steps)
- [ ] Gherkin formatter output

## More Matchers

- [ ] `beEmpty` - empty collections/strings
- [ ] `haveSize:` / `haveLength:` - collection size
- [ ] `startWith:` / `endWith:` - string prefix/suffix
- [ ] `beWithin:of:` - numeric delta comparison
- [ ] `haveKey:` / `haveValue:` - dictionary matchers
- [ ] `satisfy:` - custom block matcher
- [ ] `all:` - all elements match
- [ ] `containExactly:` - exact collection contents (any order)
- [ ] `beBetween:and:` - range matcher
- [ ] `beSameAs:` - identity (==) vs equality (=)

## Shared Examples

- [ ] `sharedExamples:do:` - define reusable example groups
- [ ] `itBehavesLike:` - include shared examples
- [ ] `includeContext:` - shared context with let/hooks

## Hooks

- [ ] `before: #all` / `after: #all` - run once per group
- [ ] `around:` - wrap example execution

## Mocking Improvements

- [ ] Argument matchers: `any`, `anything`, `instanceOf:`
- [ ] `allowAnyInstance:` - stub all instances of a class
- [ ] Ordered message expectations
- [ ] `andCallOriginal` - partial mocks
- [ ] `andRaise:` - stub to raise error

## Runner Features

- [ ] Focused tests: `fit:`, `fdescribe:`, `fcontext:`
- [ ] Skip tests: `xit:`, `xdescribe:`, `xcontext:`
- [ ] Filter by line number (`spec/foo_spec.st:42`)
- [ ] `--only-failures` - rerun failed specs
- [ ] Watch mode - rerun on file changes
- [ ] Parallel execution
- [ ] Aggregate failures (collect all failures in one example)

## Output & Reporting

- [ ] Diff output for failed equality
- [ ] Code coverage report
- [ ] JUnit XML formatter (CI integration)
- [ ] TAP formatter
- [ ] Summary of slowest files (not just examples)

## API Improvements

- [ ] `subject` - implicit subject under test
- [ ] `described_class` - reference to class being tested
- [ ] Custom matcher DSL
- [ ] Metadata on examples (beyond tags)
