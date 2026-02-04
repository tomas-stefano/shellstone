Class {
	#name : #BaselineOfShellStone,
	#superclass : #BaselineOf,
	#category : #BaselineOfShellStone
}

{ #category : #baselines }
BaselineOfShellStone >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'ShellStone-Core';
			package: 'ShellStone-Matchers' with: [ spec requires: #('ShellStone-Core') ];
			package: 'ShellStone-Expectations' with: [ spec requires: #('ShellStone-Matchers') ];
			package: 'ShellStone-Mocks' with: [ spec requires: #('ShellStone-Core') ];
			package: 'ShellStone-Support' with: [ spec requires: #('ShellStone-Expectations' 'ShellStone-Mocks') ];
			package: 'ShellStone-Tests' with: [ spec requires: #('ShellStone-Support') ] ]
]
