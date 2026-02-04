# ShellStone

A cross-platform testing framework for Smalltalk inspired by RSpec.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [GNU Smalltalk](#gnu-smalltalk)
- [Pharo](#pharo)
- [Matchers Reference](#matchers-reference)
- [CLI](#cli)
- [Development](#development)
- [License](#license)

## Installation

### Pharo

```smalltalk
Metacello new
  baseline: 'ShellStone';
  repository: 'github://tomas-stefano/shellstone:main/pharo-src';
  load.
```

### GNU Smalltalk

```bash
git clone https://github.com/tomas-stefano/shellstone.git
cd shellstone
make gnu-install
```

---

## Quick Start

### Pharo

```smalltalk
Sh describe: 'Calculator' do: [ :spec |
  spec it: 'adds two numbers' do: [
    (Sh expect: 1 + 1) to equal: 2
  ].

  spec it: 'multiplies numbers' do: [
    (Sh expect: 3 * 4) to equal: 12
  ]
].
```

### GNU Smalltalk

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

---

## GNU Smalltalk

### Expectation Syntax

ShellStone supports two syntaxes: **expect** (recommended) and **should** (legacy).

```smalltalk
"Expect syntax (recommended)"
(self expect: actual) to matcher.
(self expect: actual) toNot matcher.

"Should syntax (legacy)"
actual should matcher.
actual shouldNot matcher.
```

### Structure

```smalltalk
Describe the: 'MyClass' do: [:spec |
  spec context: 'when initialized' do: [:ctx |
    ctx it: 'has default values' do: [
      (self expect: MyClass new value) to equal: 0.
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

### Test Doubles

```smalltalk
"Doubles"
db := ShellStone.Double named: 'database'.
db stub: #find: andReturn: 'user'.
(self expect: (db find: 1)) to equal: 'user'.

"Spies"
list := OrderedCollection new.
spy := ShellStone.Spy on: list.
spy add: 1.
spy add: 2.
(self expect: (spy received: #add: times: 2)) to beTrue.
```

### Running Tests

```bash
bin/shellstone           # Run specs
make gnu-spec            # Run specs via make
make gnu-spec-doc        # Documentation format
```

---

## Pharo

### DSL Entry Point

All DSL entry points go through the `Sh` class:

```smalltalk
Sh describe: 'Calculator' do: [ :spec |
  spec it: 'adds two numbers' do: [
    (Sh expect: 1 + 1) to equal: 2
  ]
].
```

### Test Doubles

```smalltalk
"Doubles"
db := Sh double: 'database'.
db stub: #find: andReturn: 'user'.
(Sh expect: (db find: 1)) to equal: 'user'.

"Spies"
list := OrderedCollection new.
spy := Sh spyOn: list.
spy add: 1.
(Sh expect: (spy received: #add:)) to beTrue.
```

### Running Tests

```bash
# Via make (auto-downloads Pharo)
make pharo-spec
PHARO_VERSION=110 make pharo-spec

# Via Pharo CLI
./pharo Pharo.image shellstone
./pharo Pharo.image shellstone --help
```

---

## Matchers Reference

| Matcher | Example |
|---------|---------|
| `equal:` | `(Sh expect: 1) to equal: 1` |
| `beA:` / `beAn:` | `(Sh expect: 'hi') to beA: String` |
| `beKindOf:` | `(Sh expect: 42) to beKindOf: Number` |
| `beTrue` / `beFalse` | `(Sh expect: true) to beTrue` |
| `beTruthy` / `beFalsy` | `(Sh expect: 1) to beTruthy` |
| `beNil` | `(Sh expect: nil) to beNil` |
| `beGreaterThan:` | `(Sh expect: 10) to beGreaterThan: 5` |
| `beLessThan:` | `(Sh expect: 5) to beLessThan: 10` |
| `beGreaterThanOrEqualTo:` | `(Sh expect: 5) to beGreaterThanOrEqualTo: 5` |
| `beLessThanOrEqualTo:` | `(Sh expect: 5) to beLessThanOrEqualTo: 5` |
| `include:` | `(Sh expect: #(1 2 3)) to include: 2` |
| `match:` | `(Sh expect: 'hello') to match: 'ell'` |
| `respondTo:` | `(Sh expect: 'hi') to respondTo: #size` |
| `raiseError` | `(Sh expect: [1/0]) to raiseError` |
| `raiseError:` | `(Sh expect: [1/0]) to raiseError: ZeroDivide` |
| `change:` | `(Sh expect: [x := x + 1]) to change: [x]` |

All matchers support negation with `toNot` (or `shouldNot` in GNU Smalltalk).

---

## CLI

### GNU Smalltalk

```bash
bin/shellstone                    # Run specs in current directory
bin/shellstone spec/              # Run specs in specific directory
```

### Pharo

```bash
./pharo Pharo.image shellstone           # Run specs
./pharo Pharo.image shellstone --help    # Show help
./pharo Pharo.image shellstone --version # Show version
```

---

## Development

### Make Commands

```bash
make                # Run all specs (GNU + Pharo)
make gnu-spec       # GNU Smalltalk specs
make pharo-spec     # Pharo specs
make clean          # Remove tmp/
make help           # Show all commands
```

### Adding New Files

For GNU Smalltalk, edit `package.xml`:

```xml
<filein>gnu-src/your/new_file.st</filein>
```

For Pharo, add classes to `pharo-src/` in Tonel format.

## License

MIT
