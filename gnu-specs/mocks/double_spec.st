"Specs for test doubles"

ShellStone.Describe the: 'Double' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx context: 'stubbing' do: [:inner |
            inner it: 'returns stubbed value' do: [
                | db |
                db := ShellStone.Double named: 'database'.
                db stub: #find: andReturn: 'user'.
                (self expect: (db find: 1)) to equal: 'user'.
            ].

            inner it: 'can stub multiple methods' do: [
                | api |
                api := ShellStone.Double named: 'api'.
                api stub: #get andReturn: 'data'.
                api stub: #post andReturn: 'created'.
                (self expect: api get) to equal: 'data'.
                (self expect: api post) to equal: 'created'.
            ].
        ].

        ctx context: 'recording calls' do: [:inner |
            inner it: 'records received messages' do: [
                | obj |
                obj := ShellStone.Double named: 'object'.
                obj stub: #doSomething andReturn: nil.
                obj doSomething.
                (self expect: (obj received: #doSomething)) to beTrue.
            ].

            inner it: 'tracks call count' do: [
                | counter |
                counter := ShellStone.Double named: 'counter'.
                counter stub: #increment andReturn: nil.
                counter increment.
                counter increment.
                counter increment.
                (self expect: (counter received: #increment times: 3)) to beTrue.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx context: 'stubbing' do: [:inner |
            inner it: 'returns stubbed value' do: [
                | db |
                db := ShellStone.Double named: 'database'.
                db stub: #find: andReturn: 'user'.
                (db find: 1) should equal: 'user'.
            ].

            inner it: 'can stub multiple methods' do: [
                | api |
                api := ShellStone.Double named: 'api'.
                api stub: #get andReturn: 'data'.
                api stub: #post andReturn: 'created'.
                api get should equal: 'data'.
                api post should equal: 'created'.
            ].
        ].

        ctx context: 'recording calls' do: [:inner |
            inner it: 'records received messages' do: [
                | obj |
                obj := ShellStone.Double named: 'object'.
                obj stub: #doSomething andReturn: nil.
                obj doSomething.
                (obj received: #doSomething) should beTrue.
            ].

            inner it: 'tracks call count' do: [
                | counter |
                counter := ShellStone.Double named: 'counter'.
                counter stub: #increment andReturn: nil.
                counter increment.
                counter increment.
                counter increment.
                (counter received: #increment times: 3) should beTrue.
            ].
        ].
    ].
].
