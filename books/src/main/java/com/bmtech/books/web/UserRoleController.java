package com.bmtech.books.web;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.bmtech.books.domain.UserRole;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;

@RequestMapping("/admin/userRoles")
@Controller
@RooWebScaffold(path = "admin/userRoles", formBackingObject = UserRole.class)
public class UserRoleController {
}
