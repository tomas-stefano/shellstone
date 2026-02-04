"Specs for test doubles using ShellStone DSL"
Class {
	#name : #SSDoubleSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSDoubleSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'Double' do: [ :spec |
		spec context: 'stubbing' do: [ :ctx |
			ctx it: 'returns stubbed value' do: [
				| double |
				double := SS double: 'api'.
				double stub: #fetch andReturn: 'data'.
				(SS expect: double fetch) to equal: 'data'
			].

			ctx it: 'records received messages' do: [
				| double |
				double := SS double: 'service'.
				double process.
				(SS expect: (double received: #process)) to beTrue
			].

			ctx it: 'counts received messages' do: [
				| double |
				double := SS double: 'counter'.
				double increment.
				double increment.
				double increment.
				(SS expect: (double received: #increment times: 3)) to beTrue
			].

			ctx it: 'can stub multiple methods' do: [
				| api |
				api := SS double: 'api'.
				api stub: #get andReturn: 'data'.
				api stub: #post andReturn: 'created'.
				(SS expect: api get) to equal: 'data'.
				(SS expect: api post) to equal: 'created'
			]
		]
	].

	SS describe: 'Spy' do: [ :spec |
		spec context: 'wrapping objects' do: [ :ctx |
			ctx it: 'forwards to real object' do: [
				| list spy |
				list := OrderedCollection new.
				spy := SS spyOn: list.
				spy add: 1.
				spy add: 2.
				(SS expect: list size) to equal: 2
			].

			ctx it: 'records calls' do: [
				| list spy |
				list := OrderedCollection new.
				spy := SS spyOn: list.
				spy add: 'item'.
				(SS expect: (spy received: #add:)) to beTrue
			]
		]
	].

	self collectExamples
]
