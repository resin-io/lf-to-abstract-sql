test = require('./test')()
expect = require('chai').expect
{TableSpace, term, verb, factType, conceptType, termForm, referenceScheme, necessity, rule, conceptType, note, definitionEnum, synonym} = require('./sbvr-helper')
{Table, attribute} = TableSpace()
has = verb 'has'

person = term 'person'
homoSapiens = term 'homo sapiens'
educationalInstitution = term 'educational institution'
age = term 'age'
student = term 'student'
schoolYearEnrollment = term 'school year enrollment'

describe 'students', ->
	# T: person
	test Table person
	# 	Synonym: homo sapiens
	test synonym homoSapiens
	# T: educational institution
	test Table educationalInstitution
	#	Definition: "UniS" or "UWE"
	test definitionEnum 'UniS', 'UWE'
	# T: age
	test Table age
	# F: person is enrolled in educational institution
	test Table factType person, verb('is enrolled in'), educationalInstitution

	# F: person is enrolled in educational institution for age
	test Table factType person, verb('is enrolled in'), educationalInstitution, verb('for'), age
	# 	Term Form: school year enrollment
	test attribute termForm schoolYearEnrollment
	# Fact type: school year enrollment is for age
	test Table factType schoolYearEnrollment, verb('is for'), age
	#     Necessity: each school year enrollment is for exactly one age.
	test attribute necessity 'each', schoolYearEnrollment, verb('is for'), ['at most', 'one'], age
	test {
		property: 'tables.school_year_enrollment.fields[2].required'
		matches: false
		se: '-- should have set the age to not required'
	}

	# Vocabulary: other
	test 'Vocabulary: other'
	# Term: other term
	test Table term 'other term'