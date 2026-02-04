"Specs for beKindOf matcher using ShellStone DSL"
Class {
	#name : #ShBeKindOfMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShBeKindOfMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'beKindOf matcher' do: [ :spec |
		spec context: 'beA' do: [ :ctx |
			ctx it: 'passes for exact class match' do: [
				(Sh expect: 'hello') to beA: String
			].

			ctx it: 'passes for superclass match' do: [
				(Sh expect: 42) to beA: Number
			].

			ctx it: 'fails for wrong class' do: [
				(Sh expect: 'hello') toNot beA: Number
			]
		].

		spec context: 'beAn' do: [ :ctx |
			ctx it: 'works as alias for beA' do: [
				(Sh expect: #(1 2 3)) to beAn: Array
			]
		].

		spec context: 'beKindOf' do: [ :ctx |
			ctx it: 'passes for kind of class' do: [
				(Sh expect: 3.14) to beKindOf: Number
			].

			ctx it: 'passes for collection subclass' do: [
				(Sh expect: OrderedCollection new) to beKindOf: Collection
			]
		]
	].

	self collectExamples
]
