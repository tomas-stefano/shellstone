"Feature: before and after hooks"

Namespace current: ShellStone [

Describe the: 'hooks' do: [:spec |
  spec context: 'before each' do: [:ctx |
    | counter |

    ctx before: #each do: [
      counter := 0.
    ].

    ctx it: 'runs before each example - first' do: [
      counter should equal: 0.
      counter := counter + 1.
      counter should equal: 1.
    ].

    ctx it: 'runs before each example - second' do: [
      counter should equal: 0.
      counter := counter + 5.
      counter should equal: 5.
    ].

    ctx it: 'runs before each example - third' do: [
      counter should equal: 0.
    ].
  ].

  spec context: 'multiple before hooks' do: [:ctx |
    | log |

    ctx before: #each do: [
      log := OrderedCollection new.
      log add: 'first before'.
    ].

    ctx before: #each do: [
      log add: 'second before'.
    ].

    ctx it: 'runs hooks in order' do: [
      log should include: 'first before'.
      log should include: 'second before'.
      log size should equal: 2.
    ].
  ].

  spec context: 'inherited hooks' do: [:ctx |
    | outerLog |

    ctx before: #each do: [
      outerLog := OrderedCollection new.
      outerLog add: 'outer'.
    ].

    ctx context: 'inner context' do: [:inner |
      inner before: #each do: [
        outerLog add: 'inner'.
      ].

      inner it: 'runs outer hook first then inner' do: [
        outerLog should include: 'outer'.
        outerLog should include: 'inner'.
      ].
    ].
  ].
].

]
