"Feature: comparison matchers (>, <, >=, <=)"

Namespace current: ShellStone [

Describe the: 'comparison matchers' do: [:spec |
  spec context: 'beGreaterThan' do: [:ctx |
    ctx it: 'passes when value is greater' do: [
      10 should beGreaterThan: 5.
      100 should beGreaterThan: 99.
      1 should beGreaterThan: 0.
    ].

    ctx it: 'fails when value is equal' do: [
      5 shouldNot beGreaterThan: 5.
    ].

    ctx it: 'fails when value is less' do: [
      5 shouldNot beGreaterThan: 10.
    ].

    ctx it: 'works with negative numbers' do: [
      0 should beGreaterThan: -1.
      -1 should beGreaterThan: -10.
    ].

    ctx it: 'works with floats' do: [
      3.14 should beGreaterThan: 3.0.
      2.5 should beGreaterThan: 2.
    ].
  ].

  spec context: 'beLessThan' do: [:ctx |
    ctx it: 'passes when value is less' do: [
      5 should beLessThan: 10.
      0 should beLessThan: 1.
      -10 should beLessThan: -5.
    ].

    ctx it: 'fails when value is equal' do: [
      5 shouldNot beLessThan: 5.
    ].

    ctx it: 'fails when value is greater' do: [
      10 shouldNot beLessThan: 5.
    ].

    ctx it: 'works with floats' do: [
      3.0 should beLessThan: 3.14.
      0.5 should beLessThan: 1.
    ].
  ].

  spec context: 'beGreaterThanOrEqualTo' do: [:ctx |
    ctx it: 'passes when value is greater' do: [
      10 should beGreaterThanOrEqualTo: 5.
    ].

    ctx it: 'passes when value is equal' do: [
      5 should beGreaterThanOrEqualTo: 5.
    ].

    ctx it: 'fails when value is less' do: [
      5 shouldNot beGreaterThanOrEqualTo: 10.
    ].
  ].

  spec context: 'beLessThanOrEqualTo' do: [:ctx |
    ctx it: 'passes when value is less' do: [
      5 should beLessThanOrEqualTo: 10.
    ].

    ctx it: 'passes when value is equal' do: [
      5 should beLessThanOrEqualTo: 5.
    ].

    ctx it: 'fails when value is greater' do: [
      10 shouldNot beLessThanOrEqualTo: 5.
    ].
  ].

  spec context: 'chained comparisons' do: [:ctx |
    ctx it: 'can use multiple comparisons in one example' do: [
      | value |
      value := 50.

      value should beGreaterThan: 0.
      value should beLessThan: 100.
      value should beGreaterThanOrEqualTo: 50.
      value should beLessThanOrEqualTo: 50.
    ].
  ].
].

]
