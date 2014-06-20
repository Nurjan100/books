// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.bmtech.books.domain;

import com.bmtech.books.domain.Book;
import com.bmtech.books.domain.BookDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect BookDataOnDemand_Roo_DataOnDemand {
    
    declare @type: BookDataOnDemand: @Component;
    
    private Random BookDataOnDemand.rnd = new SecureRandom();
    
    private List<Book> BookDataOnDemand.data;
    
    public Book BookDataOnDemand.getNewTransientBook(int index) {
        Book obj = new Book();
        setAuthor(obj, index);
        setBookPlace(obj, index);
        setCategoryId(obj, index);
        setCover(obj, index);
        setDescription(obj, index);
        setFileFormat(obj, index);
        setFileSize(obj, index);
        setIsbn(obj, index);
        setOwnerId(obj, index);
        setPagesCount(obj, index);
        setPublicationYear(obj, index);
        setPublishing(obj, index);
        setSectionId(obj, index);
        setTitle(obj, index);
        return obj;
    }
    
    public void BookDataOnDemand.setAuthor(Book obj, int index) {
        String author = "author_" + index;
        obj.setAuthor(author);
    }
    
    public void BookDataOnDemand.setBookPlace(Book obj, int index) {
        String bookPlace = "bookPlace_" + index;
        if (bookPlace.length() > 100) {
            bookPlace = bookPlace.substring(0, 100);
        }
        obj.setBookPlace(bookPlace);
    }
    
    public void BookDataOnDemand.setCategoryId(Book obj, int index) {
        Long categoryId = new Integer(index).longValue();
        obj.setCategoryId(categoryId);
    }
    
    public void BookDataOnDemand.setCover(Book obj, int index) {
        String cover = "cover_" + index;
        if (cover.length() > 100) {
            cover = cover.substring(0, 100);
        }
        obj.setCover(cover);
    }
    
    public void BookDataOnDemand.setDescription(Book obj, int index) {
        String description = "description_" + index;
        obj.setDescription(description);
    }
    
    public void BookDataOnDemand.setFileFormat(Book obj, int index) {
        String fileFormat = "fileFormat_" + index;
        if (fileFormat.length() > 20) {
            fileFormat = fileFormat.substring(0, 20);
        }
        obj.setFileFormat(fileFormat);
    }
    
    public void BookDataOnDemand.setFileSize(Book obj, int index) {
        Float fileSize = new Integer(index).floatValue();
        obj.setFileSize(fileSize);
    }
    
    public void BookDataOnDemand.setIsbn(Book obj, int index) {
        String isbn = "isbn_" + index;
        if (isbn.length() > 100) {
            isbn = isbn.substring(0, 100);
        }
        obj.setIsbn(isbn);
    }
    
    public void BookDataOnDemand.setOwnerId(Book obj, int index) {
        Long ownerId = new Integer(index).longValue();
        obj.setOwnerId(ownerId);
    }
    
    public void BookDataOnDemand.setPagesCount(Book obj, int index) {
        Integer pagesCount = new Integer(index);
        obj.setPagesCount(pagesCount);
    }
    
    public void BookDataOnDemand.setPublicationYear(Book obj, int index) {
        Integer publicationYear = new Integer(index);
        obj.setPublicationYear(publicationYear);
    }
    
    public void BookDataOnDemand.setPublishing(Book obj, int index) {
        String publishing = "publishing_" + index;
        obj.setPublishing(publishing);
    }
    
    public void BookDataOnDemand.setSectionId(Book obj, int index) {
        Long sectionId = new Integer(index).longValue();
        obj.setSectionId(sectionId);
    }
    
    public void BookDataOnDemand.setTitle(Book obj, int index) {
        String title = "title_" + index;
        obj.setTitle(title);
    }
    
    public Book BookDataOnDemand.getSpecificBook(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Book obj = data.get(index);
        Long id = obj.getId();
        return Book.findBook(id);
    }
    
    public Book BookDataOnDemand.getRandomBook() {
        init();
        Book obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Book.findBook(id);
    }
    
    public boolean BookDataOnDemand.modifyBook(Book obj) {
        return false;
    }
    
    public void BookDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Book.findBookEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Book' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Book>();
        for (int i = 0; i < 10; i++) {
            Book obj = getNewTransientBook(i);
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
