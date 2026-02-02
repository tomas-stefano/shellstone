# ShellStone

An RSpec-like BDD testing framework for GNU Smalltalk.

## Installation

```bash
# Install GNU Smalltalk
brew install gnu-smalltalk  # macOS
apt-get install gnu-smalltalk  # Debian/Ubuntu

# Build the package
gst-package -t ~/.st package.xml

# Run tests
./bin/shellstone spec/
```

## Quick Start

Create a spec file `spec/calculator_spec.st`:

```smalltalk
ShellStone.Describe the: 'Calculator' do: [:example |
  example it: 'adds two numbers' do: [
    (2 + 3) should equal: 5.
  ].

  example it: 'multiplies numbers' do: [
    (4 * 5) should equal: 20.
  ].
].
```

Run it:

```bash
./bin/shellstone spec/calculator_spec.st
```

## DSL

### Describe and Context

Group related tests with `describe` and `context`:

```smalltalk
ShellStone.Describe the: 'User' do: [:example |
  example context: 'when logged in' do: [:ctx |
    ctx it: 'shows the dashboard' do: [
      "test here"
    ].
  ].

  example context: 'when logged out' do: [:ctx |
    ctx it: 'redirects to login' do: [
      "test here"
    ].
  ].
].
```

### Examples (it)

Define individual test cases with `it`:

```smalltalk
example it: 'does something' do: [
  actual should equal: expected.
].
```

### Pending Examples

Mark tests as pending (not yet implemented):

```smalltalk
"No block = pending"
example it: 'will be implemented later'.

"Or explicitly"
example pending: 'needs database setup' do: [
  "this won't run"
].
```

### Hooks

Run setup/teardown code before or after examples:

```smalltalk
ShellStone.Describe the: 'Database' do: [:example |
  "Run once before all examples in this group"
  example before: #all do: [
    connection := Database connect.
  ].

  "Run before each example"
  example before: #each do: [
    connection beginTransaction.
  ].

  "Run after each example"
  example after: #each do: [
    connection rollback.
  ].

  "Run once after all examples"
  example after: #all do: [
    connection disconnect.
  ].
].
```

### Let (Memoized Helpers)

Define lazy-evaluated, memoized values:

```smalltalk
ShellStone.Describe the: 'Order' do: [:example |
  example let: #user do: [User new name: 'Alice'].
  example let: #order do: [Order new user: (example user)].

  example it: 'belongs to user' do: [
    (example order) user name should equal: 'Alice'.
  ].
].
```

Values are cached per example and reset between examples.

### Tags (Metadata)

Tag examples for filtering:

```smalltalk
example it: 'is slow' tags: #(slow integration) do: [
  "expensive test"
].

example it: 'is fast' tags: #(unit) do: [
  "quick test"
].
```

Run only tagged tests:

```bash
./bin/shellstone -t slow spec/
./bin/shellstone -t unit spec/
```

## Matchers

### Equality

```smalltalk
actual should equal: expected.
actual shouldNot equal: other.
```

### Truthiness

```smalltalk
value should be truthy.
value should be falsy.
value should be nil.
value shouldNot be nil.
```

### Type Checking

```smalltalk
object should beA: String.
object should beKindOf: Collection.
```

### Method Response

```smalltalk
object should respondTo: #size.
object should respondTo: #at:put:.
```

### Collections

```smalltalk
collection should include: item.
collection should include: item1 and: item2.
collection should include: item1 and: item2 and: item3.
'hello world' should include: 'world'.
```

### Pattern Matching

```smalltalk
string should match: 'pattern'.
email should match: '.*@.*\.com'.
```

### Comparisons

```smalltalk
value should beGreaterThan: 5.
value should beLessThan: 10.
value should beGreaterThanOrEqualTo: 5.
value should beLessThanOrEqualTo: 10.
```

### Exceptions

```smalltalk
[self doSomethingDangerous] should raiseError.
[self divideByZero] should raiseError: ZeroDivide.
[self safeOperation] shouldNot raiseError.
```

### Change

```smalltalk
[counter increment] should change: [counter value].
[counter increment] should change: [counter value] by: 1.
[counter reset] should change: [counter value] from: 5 to: 0.
```

## Mocks and Doubles

### Test Doubles

Create fake objects for testing:

```smalltalk
database := ShellStone.Double named: 'database'.
```

### Stubbing

Define return values for methods:

```smalltalk
database := ShellStone.Double named: 'database'.
database stub: #find: andReturn: user.
database stub: #count andReturn: 42.

"Now use it"
database find: 1.  "Returns user"
database count.    "Returns 42"
```

### Message Expectations

Verify methods are called:

```smalltalk
mailer := ShellStone.Double named: 'mailer'.
mailer shouldReceive: #send:.
mailer shouldReceive: #send: times: 2.
mailer shouldReceive: #send: withArgs: #(email).

"Exercise the code"
mailer send: email.

"Verify at end"
mailer verify.
```

### Spies

Record all messages for later verification:

```smalltalk
spy := ShellStone.Spy on: realObject.

"Use the spy"
spy doSomething: arg.
spy doAnotherThing.

"Verify"
spy received: #doSomething:.                    "true"
spy received: #doSomething: withArgs: #(arg).   "true"
spy receivedCount: #doSomething:.               "1"
```

## Command Line

```
Usage: shellstone [options] [files or directories]

Options:
  -f, --format FORMATTER   Output format (progress, documentation, html, json, failures)
  -o, --out FILE           Output to file instead of stdout
  --order TYPE[:SEED]      Run order (defined, random, random:SEED)
  --seed SEED              Equivalent to --order random:SEED
  --fail-fast              Abort on first failure
  -e, --example STRING     Filter by description pattern
  -t, --tag TAG            Filter by tag
  -P, --pattern PATTERN    File pattern (default: **/*_spec.st)
  -p, --profile [COUNT]    Show slowest examples (default: 10)
  --dry-run                List examples without running
  -v, --version            Show version
  -h, --help               Show this help
  --no-color               Disable colored output
```

### Examples

```bash
# Run all specs
./bin/shellstone spec/

# Run specific file
./bin/shellstone spec/models/user_spec.st

# Documentation format (nested output)
./bin/shellstone -f documentation spec/

# Run in random order with seed
./bin/shellstone --order random:12345 spec/

# Stop on first failure
./bin/shellstone --fail-fast spec/

# Filter by name
./bin/shellstone -e "adds numbers" spec/

# Filter by tag
./bin/shellstone -t integration spec/

# Show 5 slowest tests
./bin/shellstone -p 5 spec/

# Output to file
./bin/shellstone -f html -o results.html spec/

# List tests without running
./bin/shellstone --dry-run spec/
```

## Output Formats

### Progress (default)

```
....F..P...

Failures:
  1) Calculator divides by zero
     Expected no error but got ZeroDivide
     # spec/calculator_spec.st:25

Finished in 0.12 seconds
11 examples, 1 failure, 1 pending
```

### Documentation

```
Calculator
  addition
    adds positive numbers
    adds negative numbers
  subtraction
    subtracts numbers
  division
    divides numbers
    handles zero (FAILED)
    pending feature (PENDING)

Failures:
  1) Calculator division handles zero
     Expected no error but got ZeroDivide
     # spec/calculator_spec.st:25

6 examples, 1 failure, 1 pending
```

### HTML

Generates a styled HTML report with expandable sections.

### JSON

```json
{
  "examples": [
    {"description": "adds numbers", "status": "passed", "duration": 0.001},
    {"description": "handles errors", "status": "failed", "message": "..."}
  ],
  "summary": {"total": 2, "passed": 1, "failed": 1, "pending": 0}
}
```

### Failures

Simple file:line:message format for editor integration:

```
spec/calculator_spec.st:25:Calculator divides by zero:Expected no error but got ZeroDivide
```

## Configuration

Create `spec/spec_helper.st` for shared setup:

```smalltalk
"spec/spec_helper.st"
Namespace current: ShellStone [
  "Add custom matchers, shared examples, etc."
].
```

The spec helper is automatically loaded before specs.

## Project Structure

```
myproject/
  src/
    my_class.st
  spec/
    spec_helper.st
    my_class_spec.st
    models/
      user_spec.st
  package.xml
```

## License

MIT
