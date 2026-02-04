"Pending example support"

Namespace current: ShellStone [

Error subclass: PendingExample [
  | message |

  PendingExample class >> new [
    ^super new initialize
  ]

  PendingExample class >> message: aString [
    ^self new message: aString; yourself
  ]

  initialize [
    message := 'Not yet implemented'.
  ]

  message [ ^message ]
  message: aString [ message := aString ]

  description [
    ^'PendingExample'
  ]

  messageText [
    ^message
  ]
]

]

"Helper method to mark examples as pending"
Object extend [
  pending [
    ShellStone.PendingExample new signal.
  ]

  pending: aMessage [
    (ShellStone.PendingExample message: aMessage) signal.
  ]
]
