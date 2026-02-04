"Specs for the Describe DSL entry point"
Class {
	#name : #ShDescribeSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShDescribeSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'Describe DSL' do: [ :spec |
		spec it: 'creates an example group' do: [
			(Sh expect: ShWorld instance groups) toNot beNil
		].

		spec it: 'allows string descriptions' do: [
			(Sh expect: true) to beTrue
		].

		spec context: 'nested contexts' do: [ :ctx |
			ctx it: 'supports nested describe blocks' do: [
				(Sh expect: true) to beTrue
			].

			ctx context: 'deeply nested' do: [ :inner |
				inner it: 'can nest multiple levels' do: [
					(Sh expect: true) to beTrue
				]
			]
		]
	].

	self collectExamples
]
