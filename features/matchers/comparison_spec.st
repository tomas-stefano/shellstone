"Feature: comparison matchers (>, <, >=, <=)"

Namespace current: ShellStone [

Describe the: 'comparison matchers' do: [:spec |
  spec context: 'beGreaterThan' do: [:ctx |
    ctx it: 'passes when value is greater' do: [
      (self expect: 10) to beGreaterThan: 5.
      (self expect: 100) to beGreaterThan: 99.
      (self expect: 1) to beGreaterThan: 0.
    ].

    ctx it: 'fails when value is equal' do: [
      (self expect: 5) toNot beGreaterThan: 5.
    ].

    ctx it: 'fails when value is less' do: [
      (self expect: 5) toNot beGreaterThan: 10.
    ].

    ctx it: 'works with negative numbers' do: [
      (self expect: 0) to beGreaterThan: -1.
      (self expect: -1) to beGreaterThan: -10.
    ].

    ctx it: 'works with floats' do: [
      (self expect: 3.14) to beGreaterThan: 3.0.
      (self expect: 2.5) to beGreaterThan: 2.
    ].
  ].

  spec context: 'beLessThan' do: [:ctx |
    ctx it: 'passes when value is less' do: [
      (self expect: 5) to beLessThan: 10.
      (self expect: 0) to beLessThan: 1.
      (self expect: -10) to beLessThan: -5.
    ].

    ctx it: 'fails when value is equal' do: [
      (self expect: 5) toNot beLessThan: 5.
    ].

    ctx it: 'fails when value is greater' do: [
      (self expect: 10) toNot beLessThan: 5.
    ].

    ctx it: 'works with floats' do: [
      (self expect: 3.0) to beLessThan: 3.14.
      (self expect: 0.5) to beLessThan: 1.
    ].
  ].

  spec context: 'beGreaterThanOrEqualTo' do: [:ctx |
    ctx it: 'passes when value is greater' do: [
      (self expect: 10) to beGreaterThanOrEqualTo: 5.
    ].

    ctx it: 'passes when value is equal' do: [
      (self expect: 5) to beGreaterThanOrEqualTo: 5.
    ].

    ctx it: 'fails when value is less' do: [
      (self expect: 5) toNot beGreaterThanOrEqualTo: 10.
    ].
  ].

  spec context: 'beLessThanOrEqualTo' do: [:ctx |
    ctx it: 'passes when value is less' do: [
      (self expect: 5) to beLessThanOrEqualTo: 10.
    ].

    ctx it: 'passes when value is equal' do: [
      (self expect: 5) to beLessThanOrEqualTo: 5.
    ].

    ctx it: 'fails when value is greater' do: [
      (self expect: 10) toNot beLessThanOrEqualTo: 5.
    ].
  ].

  spec context: 'chained comparisons' do: [:ctx |
    ctx it: 'can use multiple comparisons in one example' do: [
      | value |
      value := 50.

      (self expect: value) to beGreaterThan: 0.
      (self expect: value) to beLessThan: 100.
      (self expect: value) to beGreaterThanOrEqualTo: 50.
      (self expect: value) to beLessThanOrEqualTo: 50.
    ].
  ].
].

]
