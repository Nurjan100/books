// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.bmtech.books.domain;

import com.bmtech.books.domain.User;
import java.util.Date;

privileged aspect User_Roo_JavaBean {
    
    public String User.getFirstName() {
        return this.firstName;
    }
    
    public void User.setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String User.getLastName() {
        return this.lastName;
    }
    
    public void User.setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String User.getEmailAddress() {
        return this.emailAddress;
    }
    
    public void User.setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
    
    public String User.getPassword() {
        return this.password;
    }
    
    public void User.setPassword(String password) {
        this.password = password;
    }
    
    public Date User.getActivationDate() {
        return this.activationDate;
    }
    
    public void User.setActivationDate(Date activationDate) {
        this.activationDate = activationDate;
    }
    
    public String User.getActivationKey() {
        return this.activationKey;
    }
    
    public void User.setActivationKey(String activationKey) {
        this.activationKey = activationKey;
    }
    
    public Boolean User.getEnabled() {
        return this.enabled;
    }
    
    public void User.setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
    
    public Boolean User.getLocked() {
        return this.locked;
    }
    
    public void User.setLocked(Boolean locked) {
        this.locked = locked;
    }
    
}
