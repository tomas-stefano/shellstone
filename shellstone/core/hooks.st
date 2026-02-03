"Before/after hooks support"

Namespace current: ShellStone [

Object subclass: Hook [
  | scope block |

  "Scopes: #each (run for each example) or #all (run once for group)"
  Hook class >> scope: aSymbol block: aBlock [
    ^self new
      scope: aSymbol;
      block: aBlock;
      yourself
  ]

  scope [ ^scope ]
  scope: aSymbol [ scope := aSymbol ]
  block [ ^block ]
  block: aBlock [ block := aBlock ]

  run [
    block value.
  ]

  isEach [ ^scope = #each ]
  isAll [ ^scope = #all ]
]

Object subclass: HookCollection [
  | beforeAll beforeEach afterAll afterEach |

  HookCollection class >> new [
    ^super new initialize
  ]

  initialize [
    beforeAll := OrderedCollection new.
    beforeEach := OrderedCollection new.
    afterAll := OrderedCollection new.
    afterEach := OrderedCollection new.
  ]

  beforeAll [ ^beforeAll ]
  beforeEach [ ^beforeEach ]
  afterAll [ ^afterAll ]
  afterEach [ ^afterEach ]

  addBefore: aScope do: aBlock [
    | hook |
    hook := Hook scope: aScope block: aBlock.
    aScope = #all
      ifTrue: [ beforeAll add: hook ]
      ifFalse: [ beforeEach add: hook ].
  ]

  addAfter: aScope do: aBlock [
    | hook |
    hook := Hook scope: aScope block: aBlock.
    aScope = #all
      ifTrue: [ afterAll add: hook ]
      ifFalse: [ afterEach add: hook ].
  ]

  runBeforeAll [
    beforeAll do: [:hook | hook run].
  ]

  runBeforeEach [
    beforeEach do: [:hook | hook run].
  ]

  runAfterAll [
    afterAll do: [:hook | hook run].
  ]

  runAfterEach [
    afterEach do: [:hook | hook run].
  ]

  merge: aHookCollection [
    "Merge hooks from parent (parent hooks run first)"
    | merged |
    merged := HookCollection new.
    "Parent before hooks run first"
    aHookCollection beforeAll do: [:h | merged beforeAll add: h].
    beforeAll do: [:h | merged beforeAll add: h].
    aHookCollection beforeEach do: [:h | merged beforeEach add: h].
    beforeEach do: [:h | merged beforeEach add: h].
    "Child after hooks run first (reverse order)"
    afterAll do: [:h | merged afterAll add: h].
    aHookCollection afterAll do: [:h | merged afterAll add: h].
    afterEach do: [:h | merged afterEach add: h].
    aHookCollection afterEach do: [:h | merged afterEach add: h].
    ^merged
  ]
]

]
