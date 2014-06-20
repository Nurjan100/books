package com.bmtech.books.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.Size;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Book {

    /**
     * ID of book category
     */
    private Long categoryId;

    /**
     * ID of book section
     */
    private Long sectionId;

    /**
     * Web-link to cover picture
     */
    @Size(max = 100)
    private String cover;

    /**
     * Title of book
     */
    private String title;

    /**
     * Author of book
     */
    private String author;

    /**
     * Publishing house
     */
    private String publishing;

    /**
     * Year of publication
     */
    private Integer publicationYear;

    /**
     * Count of pages
     */
    private Integer pagesCount;

    /**
     * Short description
     */
    private String description;

    /**
     * Size of original file
     */
    private Float fileSize;

    /**
     * Original file format
     */
    @Size(max = 20)
    private String fileFormat;

    /**
     * Book ISBN
     */
    @Size(max = 100)
    private String isbn;

    /**
     * Web-link to real book place
     */
    @Size(max = 100)
    private String bookPlace;

    /**
     * Owner of book
     */
    private Long ownerId;
}
