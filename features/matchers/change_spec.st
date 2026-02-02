"Feature: change matcher"

Namespace current: ShellStone [

Describe the: 'change matcher' do: [:spec |
  spec context: 'basic change detection' do: [:ctx |
    ctx it: 'passes when value changes' do: [
      | counter |
      counter := 0.
      [counter := counter + 1] should change: [counter].
    ].

    ctx it: 'detects string changes' do: [
      | str |
      str := 'hello'.
      [str := str, ' world'] should change: [str].
    ].

    ctx it: 'detects collection changes' do: [
      | coll |
      coll := OrderedCollection new.
      [coll add: 1] should change: [coll size].
    ].
  ].
].

]
