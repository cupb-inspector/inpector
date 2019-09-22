package cn.hxy.inspect.admin.controller;

import cn.hxy.inspect.admin.service.AdminUserService;
import cn.hxy.inspect.admin.service.InspectorService;
import cn.hxy.inspect.entity.admin.AdminUser;
import cn.hxy.inspect.entity.inspector.Inspector;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
//@RequestMapping("/people")
public class PeopleController {
    private final static Logger logger = LoggerFactory.getLogger(PeopleController.class);
    @Resource
    AdminUserService adminUserService;
    @Resource
    InspectorService inspectorService;

    @RequestMapping(value = "/client", method = RequestMethod.GET)
    public String client(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        return "people/clients";
    }

    @RequestMapping(value = "/manager", method = RequestMethod.GET)
    public String manager(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<AdminUser> ls = adminUserService.selectAll();
        model.addAttribute("list", ls);
        return "people/managers";
    }

    @RequestMapping(value = "/surveyor", method = RequestMethod.GET)
    public String sureyor(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Inspector> ls = inspectorService.selectAll();

        model.addAttribute("list", ls);

        return "people/surveyor";
    }
}
