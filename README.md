# ShellStone

A cross-platform testing framework for Smalltalk inspired by RSpec.

## Table of Contents

- [Installation](#installation)
- [GNU Smalltalk](#gnu-smalltalk)
  - [Quick Start](#quick-start)
  - [Expectation Syntax](#expectation-syntax)
  - [Structure](#structure)
  - [Test Doubles](#test-doubles)
  - [Running Tests](#running-tests)
- [Pharo](#pharo)
  - [Installation](#pharo-installation)
  - [Quick Start](#pharo-quick-start)
  - [Running Tests](#pharo-running-tests)
- [Matchers Reference](#matchers-reference)
- [Development](#development)
- [License](#license)

## Installation

```bash
git clone https://github.com/tomas-stefano/shellstone.git
```

---

## GNU Smalltalk

### Quick Start

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

### Expectation Syntax

ShellStone supports two syntaxes: **expect** (recommended) and **should** (legacy).

#### Expect Syntax (Recommended)

```smalltalk
(self expect: actual) to matcher.
(self expect: actual) toNot matcher.
```

#### Should Syntax (Legacy)

```smalltalk
actual should matcher.
actual shouldNot matcher.
```

### Structure

#### Describe and Context

```smalltalk
Describe the: 'MyClass' do: [:spec |
  spec context: 'when initialized' do: [:ctx |
    ctx it: 'has default values' do: [
      (self expect: MyClass new value) to equal: 0.
    ].
  ].
].
```

#### Hooks

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

#### Let (Memoized Helpers)

```smalltalk
Describe the: 'User' do: [:spec |
  spec let: #user do: [User named: 'Alice'].

  spec it: 'has a name' do: [
    (self expect: spec user name) to equal: 'Alice'.
  ].
].
```

#### Pending Examples

```smalltalk
spec it: 'will be implemented later'.  "No block = pending"

spec it: 'is explicitly pending' do: [
  self pending: 'Not implemented yet'.
].
```

### Test Doubles

#### Doubles (Mocks)

```smalltalk
| db |
db := ShellStone.Double named: 'database'.
db stub: #find: andReturn: 'user'.

(self expect: (db find: 1)) to equal: 'user'.
```

#### Spies

```smalltalk
| list spy |
list := OrderedCollection new.
spy := ShellStone.Spy on: list.

spy add: 1.
spy add: 2.

(self expect: (spy received: #add:)) to beTrue.
(self expect: (spy received: #add: times: 2)) to beTrue.
```

### Running Tests

```bash
make test        # Run unit specs
make spec-doc    # Run with documentation format
make validate    # Validate package loads
make install     # Install to ~/.st
```

---

## Pharo

### Pharo Installation

Using Metacello:

```smalltalk
Metacello new
  baseline: 'ShellStone';
  repository: 'github://tomas-stefano/shellstone:main/pharo-src';
  load.
```

### Pharo Quick Start

All DSL entry points go through the `SS` class:

```smalltalk
SS describe: 'Calculator' do: [ :spec |
  spec it: 'adds two numbers' do: [
    (SS expect: 1 + 1) to equal: 2.
  ].

  spec it: 'multiplies numbers' do: [
    (SS expect: 3 * 4) to equal: 12.
  ].
].
```

#### Test Doubles in Pharo

```smalltalk
| db |
db := SS double: 'database'.
db stub: #find: andReturn: 'user'.

(SS expect: (db find: 1)) to equal: 'user'.

| list spy |
list := OrderedCollection new.
spy := SS spyOn: list.
spy add: 1.

(SS expect: (spy received: #add:)) to beTrue.
```

### Pharo Running Tests

```bash
# Requires smalltalkCI (https://github.com/hpi-swa/smalltalkCI)
make pharo-spec

# Specify Pharo version
PHARO_VERSION=110 make pharo-spec

# Run all platforms
make test-all
```

---

## Matchers Reference

| Matcher | Example |
|---------|---------|
| `equal:` | `(SS expect: 1) to equal: 1` |
| `beA:` / `beAn:` | `(SS expect: 'hi') to beA: String` |
| `beKindOf:` | `(SS expect: 42) to beKindOf: Number` |
| `beTrue` / `beFalse` | `(SS expect: true) to beTrue` |
| `beTruthy` / `beFalsy` | `(SS expect: 1) to beTruthy` |
| `beNil` | `(SS expect: nil) to beNil` |
| `beGreaterThan:` | `(SS expect: 10) to beGreaterThan: 5` |
| `beLessThan:` | `(SS expect: 5) to beLessThan: 10` |
| `beGreaterThanOrEqualTo:` | `(SS expect: 5) to beGreaterThanOrEqualTo: 5` |
| `beLessThanOrEqualTo:` | `(SS expect: 5) to beLessThanOrEqualTo: 5` |
| `include:` | `(SS expect: #(1 2 3)) to include: 2` |
| `match:` | `(SS expect: 'hello') to match: 'ell'` |
| `respondTo:` | `(SS expect: 'hi') to respondTo: #size` |
| `raiseError` | `(SS expect: [1/0]) to raiseError` |
| `raiseError:` | `(SS expect: [1/0]) to raiseError: ZeroDivide` |
| `change:` | `(SS expect: [x := x + 1]) to change: [x]` |

All matchers support negation with `toNot` (or `shouldNot` in GNU Smalltalk).

---

## Development

### Project Structure

```
shellstone/
├── gnu-src/        # GNU Smalltalk source
├── pharo-src/      # Pharo source (Tonel format)
├── spec/           # GNU Smalltalk specs
├── package.xml     # GNU Smalltalk package definition
├── .smalltalk.ston # Pharo CI configuration
└── Makefile
```

### Adding New Files

For GNU Smalltalk, edit `package.xml`:

```xml
<filein>gnu-src/your/new_file.st</filein>
```

For Pharo, add classes to `pharo-src/` in Tonel format.

### Available Commands

```bash
make help    # Show all available commands
```

## License

MIT
