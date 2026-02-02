"Feature: match matcher (string patterns)"

Namespace current: ShellStone [

Describe the: 'match matcher' do: [:spec |
  spec context: 'basic patterns' do: [:ctx |
    ctx it: 'matches literal strings' do: [
      'hello world' should match: 'hello'.
      'hello world' should match: 'world'.
    ].

    ctx it: 'matches anywhere in string' do: [
      'hello world' should match: 'lo wo'.
    ].

    ctx it: 'fails when pattern not found' do: [
      'hello world' shouldNot match: 'foo'.
    ].
  ].

  spec context: 'common use cases' do: [:ctx |
    ctx it: 'matches substrings' do: [
      'user@example.com' should match: '@example'.
      'user@example.com' should match: '.com'.
    ].

    ctx it: 'matches prefixes' do: [
      'hello world' should match: 'hello'.
    ].

    ctx it: 'matches suffixes' do: [
      'hello world' should match: 'world'.
    ].
  ].
].

]
