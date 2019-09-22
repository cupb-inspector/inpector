package cn.hxy.inspect.inspector.controller;

import cn.hxy.inspect.entity.inspector.Inspector;
import cn.hxy.inspect.inspector.service.UserService;
import jdk.nashorn.internal.ir.IdentNode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
public class PersonController {
    @Resource
    UserService userService;

    @RequestMapping(value = "wallet")
    public String wallet(Model model ,HttpServletRequest httpServletRequest) throws IOException {
        Inspector inspector = (Inspector)httpServletRequest.getSession().getAttribute("user");
        inspector=	userService.findUserById(inspector.getUserId());
        model.addAttribute("inspector",inspector);
        return "wallet";
    }

    @RequestMapping(value = "personal")
    public String personal(Model model ,HttpServletRequest httpServletRequest) throws IOException {
        Inspector inspector = (Inspector)httpServletRequest.getSession().getAttribute("user");
        inspector=	userService.findUserById(inspector.getUserId());
        model.addAttribute("inspector",inspector);
        return "personal";
    }


}
