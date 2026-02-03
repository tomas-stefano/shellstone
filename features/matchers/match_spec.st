"Feature: match matcher (string patterns)"

Namespace current: ShellStone [

Describe the: 'match matcher' do: [:spec |
  spec context: 'basic patterns' do: [:ctx |
    ctx it: 'matches literal strings' do: [
      (self expect: 'hello world') to match: 'hello'.
      (self expect: 'hello world') to match: 'world'.
    ].

    ctx it: 'matches anywhere in string' do: [
      (self expect: 'hello world') to match: 'lo wo'.
    ].

    ctx it: 'fails when pattern not found' do: [
      (self expect: 'hello world') toNot match: 'foo'.
    ].
  ].

  spec context: 'common use cases' do: [:ctx |
    ctx it: 'matches substrings' do: [
      (self expect: 'user@example.com') to match: '@example'.
      (self expect: 'user@example.com') to match: '.com'.
    ].

    ctx it: 'matches prefixes' do: [
      (self expect: 'hello world') to match: 'hello'.
    ].

    ctx it: 'matches suffixes' do: [
      (self expect: 'hello world') to match: 'world'.
    ].
  ].
].

]
