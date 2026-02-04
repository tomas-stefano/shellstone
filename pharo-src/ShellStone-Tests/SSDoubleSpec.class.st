"Specs for test doubles using ShellStone DSL"
Class {
	#name : #SSDoubleSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSDoubleSpec class >> loadSpecs [
	SSWorld reset.

	SSDescribe the: 'Double' do: [ :spec |
		spec context: 'stubbing' do: [ :ctx |
			ctx it: 'returns stubbed value' do: [
				| double |
				double := SSDouble named: 'api'.
				double stub: #fetch andReturn: 'data'.
				(SSExpectationTarget for: double fetch) to equal: 'data'
			].

			ctx it: 'records received messages' do: [
				| double |
				double := SSDouble named: 'service'.
				double process.
				(SSExpectationTarget for: (double received: #process)) to beTrue
			].

			ctx it: 'counts received messages' do: [
				| double |
				double := SSDouble named: 'counter'.
				double increment.
				double increment.
				double increment.
				(SSExpectationTarget for: (double received: #increment times: 3)) to beTrue
			]
		]
	].

	SSDescribe the: 'Spy' do: [ :spec |
		spec context: 'wrapping objects' do: [ :ctx |
			ctx it: 'forwards to real object' do: [
				| list spy |
				list := OrderedCollection new.
				spy := SSSpy on: list.
				spy add: 1.
				spy add: 2.
				(SSExpectationTarget for: list size) to equal: 2
			].

			ctx it: 'records calls' do: [
				| list spy |
				list := OrderedCollection new.
				spy := SSSpy on: list.
				spy add: 'item'.
				(SSExpectationTarget for: (spy received: #add:)) to beTrue
			]
		]
	].

	self collectExamples
]
