"Feature: tags (metadata)"

Namespace current: ShellStone [

Describe the: 'tags' do: [:spec |
  spec context: 'tagging examples' do: [:ctx |
    ctx it: 'untagged example runs normally' do: [
      true should equal: true.
    ].

    ctx it: 'single tag' tags: #(slow) do: [
      true should equal: true.
    ].

    ctx it: 'multiple tags' tags: #(slow integration database) do: [
      true should equal: true.
    ].

    ctx it: 'unit tag' tags: #(unit fast) do: [
      true should equal: true.
    ].
  ].

  spec context: 'filtering by tags' tags: #(integration) do: [:ctx |
    ctx it: 'inherits context tags' do: [
      true should equal: true.
    ].

    ctx it: 'can add more tags' tags: #(database) do: [
      true should equal: true.
    ].
  ].

  spec context: 'common tag categories' do: [:ctx |
    ctx it: 'speed tags' tags: #(fast) do: [
      true should equal: true.
    ].

    ctx it: 'type tags' tags: #(unit) do: [
      true should equal: true.
    ].

    ctx it: 'feature tags' tags: #(authentication) do: [
      true should equal: true.
    ].

    ctx it: 'focus tag' tags: #(focus) do: [
      true should equal: true.
    ].

    ctx it: 'skip tag' tags: #(skip) do: [
      true should equal: true.
    ].
  ].
].

]
