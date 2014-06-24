// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.bmtech.books.domain;

import com.bmtech.books.domain.UserBook;
import com.bmtech.books.domain.UserBookDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect UserBookDataOnDemand_Roo_DataOnDemand {
    
    declare @type: UserBookDataOnDemand: @Component;
    
    private Random UserBookDataOnDemand.rnd = new SecureRandom();
    
    private List<UserBook> UserBookDataOnDemand.data;
    
    public UserBook UserBookDataOnDemand.getNewTransientUserBook(int index) {
        UserBook obj = new UserBook();
        setAdded(obj, index);
        setBookId(obj, index);
        setCurrentPage(obj, index);
        setLastOpened(obj, index);
        setOpenCounts(obj, index);
        setStatus(obj, index);
        setUserId(obj, index);
        return obj;
    }
    
    public void UserBookDataOnDemand.setAdded(UserBook obj, int index) {
        Date added = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setAdded(added);
    }
    
    public void UserBookDataOnDemand.setBookId(UserBook obj, int index) {
        Long bookId = new Integer(index).longValue();
        obj.setBookId(bookId);
    }
    
    public void UserBookDataOnDemand.setCurrentPage(UserBook obj, int index) {
        Long currentPage = new Integer(index).longValue();
        obj.setCurrentPage(currentPage);
    }
    
    public void UserBookDataOnDemand.setLastOpened(UserBook obj, int index) {
        Date lastOpened = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setLastOpened(lastOpened);
    }
    
    public void UserBookDataOnDemand.setOpenCounts(UserBook obj, int index) {
        Long openCounts = new Integer(index).longValue();
        obj.setOpenCounts(openCounts);
    }
    
    public void UserBookDataOnDemand.setStatus(UserBook obj, int index) {
        Long status = new Integer(index).longValue();
        obj.setStatus(status);
    }
    
    public void UserBookDataOnDemand.setUserId(UserBook obj, int index) {
        Long userId = new Integer(index).longValue();
        obj.setUserId(userId);
    }
    
    public UserBook UserBookDataOnDemand.getSpecificUserBook(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        UserBook obj = data.get(index);
        Long id = obj.getId();
        return UserBook.findUserBook(id);
    }
    
    public UserBook UserBookDataOnDemand.getRandomUserBook() {
        init();
        UserBook obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return UserBook.findUserBook(id);
    }
    
    public boolean UserBookDataOnDemand.modifyUserBook(UserBook obj) {
        return false;
    }
    
    public void UserBookDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = UserBook.findUserBookEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'UserBook' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<UserBook>();
        for (int i = 0; i < 10; i++) {
            UserBook obj = getNewTransientUserBook(i);
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
            data.add(obj);
        }
    }
    
}
