# History

## 0.1.0

Initial release of ShellStone, a testing framework for GNU Smalltalk inspired by RSpec.

### Features

**Dual expectation syntax** - Both modern `expect` and legacy `should` styles:

```smalltalk
(self expect: 1 + 1) to equal: 2.
(1 + 1) should equal: 2.
```

**Matchers** - `equal:`, `beA:`, `beNil`, `beTruthy`, `beFalsy`, `beTrue`, `beFalse`, `beGreaterThan:`, `beLessThan:`, `include:`, `match:`, `respondTo:`, `raiseError`, `change:`

**Structure** - Nested `describe`/`context` blocks with `before:`/`after:` hooks:

```smalltalk
Describe the: 'Calculator' do: [:spec |
  spec before: #each do: [ calc := Calculator new ].
  spec it: 'adds numbers' do: [
    (self expect: (calc add: 2 to: 3)) to equal: 5.
  ].
].
```

**Test doubles** - Doubles, spies, and message expectations:

```smalltalk
db := Double named: 'database'.
db stub: #find: andReturn: 'user'.
```

**CLI** - Formatters (`progress`, `documentation`, `json`, `html`), tags, fail-fast, random ordering

**Makefile** - `make spec`, `make spec-doc`, `make install`
