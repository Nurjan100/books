// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.bmtech.books.domain;

import com.bmtech.books.domain.UserBook;
import com.bmtech.books.domain.UserBookDataOnDemand;
import com.bmtech.books.domain.UserBookIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect UserBookIntegrationTest_Roo_IntegrationTest {
    
    declare @type: UserBookIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: UserBookIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: UserBookIntegrationTest: @Transactional;
    
    @Autowired
    UserBookDataOnDemand UserBookIntegrationTest.dod;
    
    @Test
    public void UserBookIntegrationTest.testCountUserBooks() {
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", dod.getRandomUserBook());
        long count = UserBook.countUserBooks();
        Assert.assertTrue("Counter for 'UserBook' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void UserBookIntegrationTest.testFindUserBook() {
        UserBook obj = dod.getRandomUserBook();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to provide an identifier", id);
        obj = UserBook.findUserBook(id);
        Assert.assertNotNull("Find method for 'UserBook' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'UserBook' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void UserBookIntegrationTest.testFindAllUserBooks() {
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", dod.getRandomUserBook());
        long count = UserBook.countUserBooks();
        Assert.assertTrue("Too expensive to perform a find all test for 'UserBook', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<UserBook> result = UserBook.findAllUserBooks();
        Assert.assertNotNull("Find all method for 'UserBook' illegally returned null", result);
        Assert.assertTrue("Find all method for 'UserBook' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void UserBookIntegrationTest.testFindUserBookEntries() {
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", dod.getRandomUserBook());
        long count = UserBook.countUserBooks();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<UserBook> result = UserBook.findUserBookEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'UserBook' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'UserBook' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void UserBookIntegrationTest.testFlush() {
        UserBook obj = dod.getRandomUserBook();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to provide an identifier", id);
        obj = UserBook.findUserBook(id);
        Assert.assertNotNull("Find method for 'UserBook' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyUserBook(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'UserBook' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void UserBookIntegrationTest.testMergeUpdate() {
        UserBook obj = dod.getRandomUserBook();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to provide an identifier", id);
        obj = UserBook.findUserBook(id);
        boolean modified =  dod.modifyUserBook(obj);
        Integer currentVersion = obj.getVersion();
        UserBook merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'UserBook' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void UserBookIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", dod.getRandomUserBook());
        UserBook obj = dod.getNewTransientUserBook(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'UserBook' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'UserBook' identifier to be null", obj.getId());
        try {
            obj.persist();
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        obj.flush();
        Assert.assertNotNull("Expected 'UserBook' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void UserBookIntegrationTest.testRemove() {
        UserBook obj = dod.getRandomUserBook();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'UserBook' failed to provide an identifier", id);
        obj = UserBook.findUserBook(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'UserBook' with identifier '" + id + "'", UserBook.findUserBook(id));
    }
    
}
