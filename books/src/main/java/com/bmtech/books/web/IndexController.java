package com.bmtech.books.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.bmtech.books.domain.Book;

@RequestMapping("/")
@Controller
public class IndexController {

	@RequestMapping(method = RequestMethod.GET)
	public String defaultAfterLogin(HttpServletRequest request, Model uiModel) {
		uiModel.addAttribute("data", Book.findAllBooks());
        return "index";
    }
}
