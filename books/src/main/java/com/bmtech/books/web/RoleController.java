package com.bmtech.books.web;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.bmtech.books.domain.Role;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;

@RequestMapping("/admin/roles")
@Controller
@RooWebScaffold(path = "admin/roles", formBackingObject = Role.class)
public class RoleController {
}
