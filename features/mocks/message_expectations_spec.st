"Feature: message expectations (shouldReceive)"

Namespace current: ShellStone [

Describe the: 'message expectations' do: [:spec |
  spec context: 'basic expectations' do: [:ctx |
    ctx it: 'verifies method was called' do: [
      | dbl |
      dbl := Double named: 'service'.
      dbl shouldReceive: #process.

      dbl process.

      "verify returns self, raises if failed"
      dbl verify.
      (self expect: true) to equal: true.
    ].

    ctx it: 'verifies method with argument was called' do: [
      | dbl |
      dbl := Double named: 'repo'.
      dbl shouldReceive: #save:.

      dbl save: 'data'.

      dbl verify.
      (self expect: true) to equal: true.
    ].
  ].

  spec context: 'call count expectations' do: [:ctx |
    ctx it: 'verifies exact call count' do: [
      | dbl |
      dbl := Double named: 'counter'.
      dbl shouldReceive: #increment times: 3.

      dbl increment.
      dbl increment.
      dbl increment.

      dbl verify.
      (self expect: true) to equal: true.
    ].

    ctx it: 'verifies called once' do: [
      | dbl |
      dbl := Double named: 'once'.
      dbl shouldReceive: #doOnce times: 1.

      dbl doOnce.

      dbl verify.
      (self expect: true) to equal: true.
    ].
  ].

  spec context: 'argument expectations' do: [:ctx |
    ctx it: 'verifies specific arguments' do: [
      | dbl |
      dbl := Double named: 'logger'.
      dbl shouldReceive: #log: withArgs: #('error message').

      dbl log: 'error message'.

      dbl verify.
      (self expect: true) to equal: true.
    ].
  ].

  spec context: 'failure cases' do: [:ctx |
    ctx it: 'fails when expected method not called' do: [
      | dbl |
      dbl := Double named: 'unused'.
      dbl shouldReceive: #neverCalled.

      (self expect: [dbl verify]) to raiseError.
    ].
  ].
].

]
