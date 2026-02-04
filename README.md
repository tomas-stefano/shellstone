# ShellStone

A testing framework for GNU Smalltalk inspired by RSpec.

## Installation

```bash
git clone https://github.com/tomas-stefano/shellstone.git
```

## Quick Start

```smalltalk
Namespace current: ShellStone [

Describe the: 'Calculator' do: [:spec |
  spec it: 'adds two numbers' do: [
    (self expect: 1 + 1) to equal: 2.
  ].

  spec it: 'multiplies numbers' do: [
    (self expect: 3 * 4) to equal: 12.
  ].
].

]
```

## Expectation Syntax

ShellStone supports two expectation syntaxes: the modern **expect syntax** (recommended) and the legacy **should syntax**.

---

### Expect Syntax (Recommended)

The expect syntax is the modern RSpec 3+ style. It's explicit and avoids monkey-patching issues with proxy objects.

```smalltalk
(self expect: actual) to matcher.
(self expect: actual) toNot matcher.
```

#### Basic Expectations

```smalltalk
"Equality"
(self expect: 1) to equal: 1.
(self expect: 'hello') to equal: 'hello'.
(self expect: #(1 2 3)) to equal: #(1 2 3).

"Negation"
(self expect: 1) toNot equal: 2.
(self expect: 'hello') toNot equal: 'world'.
```

#### Type Checking

```smalltalk
(self expect: 'hello') to beA: String.
(self expect: 42) to beKindOf: Number.
(self expect: #(1 2 3)) to beAn: Array.
```

#### Truthiness

```smalltalk
(self expect: true) to beTruthy.
(self expect: false) to beFalsy.
(self expect: nil) to beNil.
(self expect: true) to beTrue.
(self expect: false) to beFalse.
```

#### Comparisons

```smalltalk
(self expect: 10) to beGreaterThan: 5.
(self expect: 5) to beLessThan: 10.
(self expect: 5) to beGreaterThanOrEqualTo: 5.
(self expect: 5) to beLessThanOrEqualTo: 5.
```

#### Collections

```smalltalk
(self expect: #(1 2 3)) to include: 2.
(self expect: 'hello world') to include: 'world'.
```

#### Strings

```smalltalk
(self expect: 'hello world') to match: 'hello'.
(self expect: 'user@example.com') to match: '@example'.
```

#### Respond To

```smalltalk
(self expect: 'hello') to respondTo: #size.
(self expect: 42) toNot respondTo: #asUppercase.
```

#### Exceptions

```smalltalk
(self expect: [self error: 'boom']) to raiseError.
(self expect: [1 / 0]) to raiseError: ZeroDivide.
(self expect: [1 + 1]) toNot raiseError.
```

#### Change

```smalltalk
| counter |
counter := 0.
(self expect: [counter := counter + 1]) to change: [counter].
```

#### Negation Aliases

All these are equivalent:

```smalltalk
(self expect: 1) toNot equal: 2.
(self expect: 1) notTo equal: 2.
(self expect: 1) to_not equal: 2.
(self expect: 1) not_to equal: 2.
```

---

### Should Syntax (Legacy)

The should syntax is the classic RSpec 1.x/2.x style. It works by extending `Object` directly.

```smalltalk
actual should matcher.
actual shouldNot matcher.
```

#### Basic Expectations

```smalltalk
"Equality"
1 should equal: 1.
'hello' should equal: 'hello'.
#(1 2 3) should equal: #(1 2 3).

"Negation"
1 shouldNot equal: 2.
'hello' shouldNot equal: 'world'.
```

#### Type Checking

```smalltalk
'hello' should beA: String.
42 should beKindOf: Number.
#(1 2 3) should beAn: Array.
```

#### Truthiness

```smalltalk
true should beTruthy.
false should beFalsy.
nil should beNil.
true should beTrue.
false should beFalse.
```

#### Comparisons

```smalltalk
10 should beGreaterThan: 5.
5 should beLessThan: 10.
5 should beGreaterThanOrEqualTo: 5.
5 should beLessThanOrEqualTo: 5.
```

#### Collections

```smalltalk
#(1 2 3) should include: 2.
'hello world' should include: 'world'.
```

#### Strings

```smalltalk
'hello world' should match: 'hello'.
'user@example.com' should match: '@example'.
```

#### Respond To

```smalltalk
'hello' should respondTo: #size.
42 shouldNot respondTo: #asUppercase.
```

#### Exceptions

```smalltalk
[self error: 'boom'] should raiseError.
[1 / 0] should raiseError: ZeroDivide.
[1 + 1] shouldNot raiseError.
```

#### Change

```smalltalk
| counter |
counter := 0.
[counter := counter + 1] should change: [counter].
```

#### Snake Case Alias

```smalltalk
1 should_not equal: 2.  "Same as shouldNot"
```

---

## Structure

### Describe and Context

```smalltalk
Describe the: 'MyClass' do: [:spec |
  spec context: 'when initialized' do: [:ctx |
    ctx it: 'has default values' do: [
      (self expect: MyClass new value) to equal: 0.
    ].
  ].

  spec context: 'when modified' do: [:ctx |
    ctx it: 'updates the value' do: [
      | obj |
      obj := MyClass new.
      obj value: 42.
      (self expect: obj value) to equal: 42.
    ].
  ].
].
```

### Hooks

```smalltalk
Describe the: 'Database' do: [:spec |
  | connection |

  spec before: #each do: [
    connection := Database connect.
  ].

  spec after: #each do: [
    connection close.
  ].

  spec it: 'queries data' do: [
    (self expect: (connection query: 'SELECT 1')) toNot beNil.
  ].
].
```

### Let (Memoized Helpers)

```smalltalk
Describe the: 'User' do: [:spec |
  spec context: 'with let' do: [:ctx |
    ctx let: #user do: [User named: 'Alice'].

    ctx it: 'has a name' do: [
      (self expect: ctx user name) to equal: 'Alice'.
    ].
  ].
].
```

### Pending Examples

```smalltalk
spec it: 'will be implemented later'.  "No block = pending"

spec it: 'is explicitly pending' do: [
  self pending: 'Not implemented yet'.
].
```

### Tags

```smalltalk
spec it: 'is slow' tags: #(slow integration) do: [
  "..."
].

spec context: 'database tests' tags: #(database) do: [:ctx |
  "..."
].
```

## Test Doubles

### Doubles (Mocks)

```smalltalk
| db |
db := ShellStone.Double named: 'database'.
db stub: #find: andReturn: 'user'.

(self expect: (db find: 1)) to equal: 'user'.
```

### Spies

```smalltalk
| list spy |
list := OrderedCollection new.
spy := ShellStone.Spy on: list.

spy add: 1.
spy add: 2.

(self expect: (spy received: #add:)) to equal: true.
(self expect: (spy received: #add: times: 2)) to equal: true.
```

### Message Expectations

```smalltalk
| service |
service := ShellStone.Double named: 'service'.
service shouldReceive: #process.

service process.

service verify.  "Raises if not called"
```

## Running Tests

Use the provided Makefile:

```bash
# Run unit specs
make test

# Run specs with documentation format
make spec-doc

# Run feature specs
make features

# Run all tests
make all-tests

# Validate package loads
make validate
```

## Development

### Adding New Files

Edit `package.xml` directly - it's the single source of truth. Add your file in the correct load order (dependencies first):

```xml
<filein>gnu-src/your/new_file.st</filein>
```

The Makefile automatically extracts the file list from package.xml.

### Other Commands

```bash
# Install to system
make install

# Show all available commands
make help

# List source files (from package.xml)
make list-files
```

## License

MIT
