"Feature: be matcher (truthy/falsy/nil)"

Namespace current: ShellStone [

Describe the: 'be matcher' do: [:spec |
  spec context: 'truthy' do: [:ctx |
    ctx it: 'passes for true' do: [
      (self expect: true) to beTruthy.
    ].

    ctx it: 'passes for non-nil objects' do: [
      (self expect: 'string') to beTruthy.
      (self expect: 1) to beTruthy.
      (self expect: #symbol) to beTruthy.
    ].

    ctx it: 'passes for non-empty collections' do: [
      (self expect: #(1 2 3)) to beTruthy.
      (self expect: (OrderedCollection with: 1)) to beTruthy.
    ].

    ctx it: 'fails for false with toNot' do: [
      (self expect: false) toNot beTruthy.
    ].

    ctx it: 'fails for nil with toNot' do: [
      (self expect: nil) toNot beTruthy.
    ].
  ].

  spec context: 'falsy' do: [:ctx |
    ctx it: 'passes for false' do: [
      (self expect: false) to beFalsy.
    ].

    ctx it: 'passes for nil' do: [
      (self expect: nil) to beFalsy.
    ].

    ctx it: 'fails for true with toNot' do: [
      (self expect: true) toNot beFalsy.
    ].

    ctx it: 'fails for objects with toNot' do: [
      (self expect: 'string') toNot beFalsy.
      (self expect: 1) toNot beFalsy.
    ].
  ].

  spec context: 'nil' do: [:ctx |
    ctx it: 'passes for nil' do: [
      (self expect: nil) to beNil.
    ].

    ctx it: 'fails for non-nil with toNot' do: [
      (self expect: 'string') toNot beNil.
      (self expect: 0) toNot beNil.
      (self expect: false) toNot beNil.
    ].
  ].
].

]
