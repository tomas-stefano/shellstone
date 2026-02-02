"Feature: describe and context blocks"

Namespace current: ShellStone [

Describe the: 'describe blocks' do: [:spec |
  spec context: 'basic structure' do: [:ctx |
    ctx it: 'runs examples inside describe' do: [
      true should equal: true.
    ].

    ctx it: 'can have multiple examples' do: [
      1 should equal: 1.
    ].

    ctx it: 'examples are independent' do: [
      2 should equal: 2.
    ].
  ].

  spec context: 'nested contexts' do: [:ctx |
    ctx context: 'first level' do: [:inner |
      inner it: 'works at first level' do: [
        'first' should equal: 'first'.
      ].

      inner context: 'second level' do: [:deeper |
        deeper it: 'works at second level' do: [
          'second' should equal: 'second'.
        ].

        deeper context: 'third level' do: [:deepest |
          deepest it: 'works at third level' do: [
            'third' should equal: 'third'.
          ].
        ].
      ].
    ].
  ].

  spec context: 'variable isolation' do: [:ctx |
    | sharedVar |

    ctx before: #each do: [
      sharedVar := 0.
    ].

    ctx it: 'starts with initial value' do: [
      sharedVar should equal: 0.
      sharedVar := 10.
    ].

    ctx it: 'resets between examples' do: [
      sharedVar should equal: 0.
    ].
  ].

  spec context: 'with strings as descriptions' do: [:ctx |
    ctx it: 'accepts string descriptions' do: [
      'works' should equal: 'works'.
    ].
  ].
].

Describe the: 'another describe block' do: [:spec |
  spec it: 'can have multiple describe blocks' do: [
    true should equal: true.
  ].
].

]
