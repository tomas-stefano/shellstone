# History

## 0.1.0

Cross-platform release supporting both GNU Smalltalk and Pharo.

### Cross-Platform Support

ShellStone now runs on both GNU Smalltalk and Pharo with a consistent API:

```smalltalk
"Pharo"
Sh describe: 'Calculator' do: [ :spec |
  spec it: 'adds numbers' do: [
    (Sh expect: 1 + 1) to equal: 2
  ]
].

"GNU Smalltalk"
Describe the: 'Calculator' do: [:spec |
  spec it: 'adds numbers' do: [
    (self expect: 1 + 1) to equal: 2.
  ].
].
```

### Features

**Matchers** - Full set of RSpec-style matchers:
- `equal:`, `beA:`, `beKindOf:`, `beNil`
- `beTruthy`, `beFalsy`, `beTrue`, `beFalse`
- `beGreaterThan:`, `beLessThan:`, `beGreaterThanOrEqualTo:`, `beLessThanOrEqualTo:`
- `include:`, `match:`, `respondTo:`
- `raiseError`, `raiseError:`
- `change:`

**Structure** - Nested `describe`/`context` blocks with hooks:

```smalltalk
Sh describe: 'User' do: [ :spec |
  spec before: #each do: [ user := User new ].
  spec context: 'when new' do: [ :ctx |
    ctx it: 'has no name' do: [
      (Sh expect: user name) to beNil
    ]
  ]
].
```

**Test Doubles** - Mocks and spies:

```smalltalk
db := Sh double: 'database'.
db stub: #find: andReturn: 'user'.

spy := Sh spyOn: list.
spy add: 1.
(Sh expect: (spy received: #add:)) to beTrue.
```

**CLI** - Command-line interface for both platforms:

```bash
# GNU Smalltalk
bin/shellstone

# Pharo
./pharo Pharo.image shellstone
```

**CI Ready** - GitHub Actions workflow for both platforms:
- GNU Smalltalk on Ubuntu
- Pharo 11 and 12

### Project Structure

```
shellstone/
├── gnu-src/        # GNU Smalltalk source
├── gnu-specs/      # GNU Smalltalk specs
├── pharo-src/      # Pharo source (Tonel)
├── pharo-specs/    # Pharo specs
└── bin/            # CLI scripts
```
