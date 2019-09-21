package cn.hxy.inspect.inspector.controller;


import cn.hxy.inspect.entity.inspector.Inspector;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/")
public class IndexController {
    @RequestMapping(value = "/index-content", method = RequestMethod.GET)
    public String index(ModelMap model, HttpServletRequest request){
        Inspector inspector = (Inspector)request.getSession().getAttribute("user");

        model.addAttribute("user",inspector);

        return "index-content";
    }
}
