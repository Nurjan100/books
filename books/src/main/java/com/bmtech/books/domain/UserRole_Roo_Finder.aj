// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.bmtech.books.domain;

import com.bmtech.books.domain.User;
import com.bmtech.books.domain.UserRole;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

privileged aspect UserRole_Roo_Finder {
    
    public static Long UserRole.countFindUserRolesByUserEntry(User userEntry) {
        if (userEntry == null) throw new IllegalArgumentException("The userEntry argument is required");
        EntityManager em = UserRole.entityManager();
        TypedQuery q = em.createQuery("SELECT COUNT(o) FROM UserRole AS o WHERE o.userEntry = :userEntry", Long.class);
        q.setParameter("userEntry", userEntry);
        return ((Long) q.getSingleResult());
    }
    
    public static TypedQuery<UserRole> UserRole.findUserRolesByUserEntry(User userEntry) {
        if (userEntry == null) throw new IllegalArgumentException("The userEntry argument is required");
        EntityManager em = UserRole.entityManager();
        TypedQuery<UserRole> q = em.createQuery("SELECT o FROM UserRole AS o WHERE o.userEntry = :userEntry", UserRole.class);
        q.setParameter("userEntry", userEntry);
        return q;
    }
    
    public static TypedQuery<UserRole> UserRole.findUserRolesByUserEntry(User userEntry, String sortFieldName, String sortOrder) {
        if (userEntry == null) throw new IllegalArgumentException("The userEntry argument is required");
        EntityManager em = UserRole.entityManager();
        String jpaQuery = "SELECT o FROM UserRole AS o WHERE o.userEntry = :userEntry";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        TypedQuery<UserRole> q = em.createQuery(jpaQuery, UserRole.class);
        q.setParameter("userEntry", userEntry);
        return q;
    }
    
}
