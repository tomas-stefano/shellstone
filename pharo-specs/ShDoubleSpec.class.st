"Specs for test doubles using ShellStone DSL"
Class {
	#name : #ShDoubleSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShDoubleSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'Double' do: [ :spec |
		spec context: 'stubbing' do: [ :ctx |
			ctx it: 'returns stubbed value' do: [
				| double |
				double := Sh double: 'api'.
				double stub: #fetch andReturn: 'data'.
				(Sh expect: double fetch) to equal: 'data'
			].

			ctx it: 'records received messages' do: [
				| double |
				double := Sh double: 'service'.
				double process.
				(Sh expect: (double received: #process)) to beTrue
			].

			ctx it: 'counts received messages' do: [
				| double |
				double := Sh double: 'counter'.
				double increment.
				double increment.
				double increment.
				(Sh expect: (double received: #increment times: 3)) to beTrue
			].

			ctx it: 'can stub multiple methods' do: [
				| api |
				api := Sh double: 'api'.
				api stub: #get andReturn: 'data'.
				api stub: #post andReturn: 'created'.
				(Sh expect: api get) to equal: 'data'.
				(Sh expect: api post) to equal: 'created'
			]
		]
	].

	Sh describe: 'Spy' do: [ :spec |
		spec context: 'wrapping objects' do: [ :ctx |
			ctx it: 'forwards to real object' do: [
				| list spy |
				list := OrderedCollection new.
				spy := Sh spyOn: list.
				spy add: 1.
				spy add: 2.
				(Sh expect: list size) to equal: 2
			].

			ctx it: 'records calls' do: [
				| list spy |
				list := OrderedCollection new.
				spy := Sh spyOn: list.
				spy add: 'item'.
				(Sh expect: (spy received: #add:)) to beTrue
			]
		]
	].

	self collectExamples
]
