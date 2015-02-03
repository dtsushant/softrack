package com.softrack

import softrack.Project

class User {

	transient springSecurityService

	String username
	String password
    String firstName
    String middleName
    String lastName
    String email
    String contact_no
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    static hasMany = [project: Project]


	static constraints = {
		username blank: false, unique: true
		password blank: false
        contact_no nullable: true
        middleName nullable:true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
