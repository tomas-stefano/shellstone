"Feature: be matcher (truthy/falsy/nil)"

Namespace current: ShellStone [

Describe the: 'be matcher' do: [:spec |
  spec context: 'truthy' do: [:ctx |
    ctx it: 'passes for true' do: [
      true should beTruthy.
    ].

    ctx it: 'passes for non-nil objects' do: [
      'string' should beTruthy.
      1 should beTruthy.
      #symbol should beTruthy.
    ].

    ctx it: 'passes for non-empty collections' do: [
      #(1 2 3) should beTruthy.
      (OrderedCollection with: 1) should beTruthy.
    ].

    ctx it: 'fails for false with shouldNot' do: [
      false shouldNot beTruthy.
    ].

    ctx it: 'fails for nil with shouldNot' do: [
      nil shouldNot beTruthy.
    ].
  ].

  spec context: 'falsy' do: [:ctx |
    ctx it: 'passes for false' do: [
      false should beFalsy.
    ].

    ctx it: 'passes for nil' do: [
      nil should beFalsy.
    ].

    ctx it: 'fails for true with shouldNot' do: [
      true shouldNot beFalsy.
    ].

    ctx it: 'fails for objects with shouldNot' do: [
      'string' shouldNot beFalsy.
      1 shouldNot beFalsy.
    ].
  ].

  spec context: 'nil' do: [:ctx |
    ctx it: 'passes for nil' do: [
      nil should beNil.
    ].

    ctx it: 'fails for non-nil with shouldNot' do: [
      'string' shouldNot beNil.
      0 shouldNot beNil.
      false shouldNot beNil.
    ].
  ].
].

]
