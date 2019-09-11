package cn.hxy.inspect.customer.controller;

import cn.hxy.inspect.customer.service.AccountService;
import cn.hxy.inspect.entity.Account;
import cn.hxy.inspect.entity.customer.User;
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
import java.io.UnsupportedEncodingException;
import java.util.List;


@Controller
@RequestMapping("/")
public class PersonalController {
    private final static Logger logger = LoggerFactory.getLogger(PersonalController.class);
    @Resource
    AccountService accountService;

    @RequestMapping(value = "/wallet", method = RequestMethod.GET)
    public String wallet(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 返回页面防止出现中文乱码
        request.setCharacterEncoding("UTF-8");
        // 获取用户是否登录
        User user = (User) request.getSession().getAttribute("user");
        List<Account> ls = accountService.selectAllByUserId(user.getCusid());
        //查找客户的钱包信息
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("list", ls);
        }
        return "account/wallet";

    }

    @RequestMapping(value = "/personal", method = RequestMethod.GET)
    public String personal(ModelMap model, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 返回页面防止出现中文乱码
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        // 获取用户是否登录
        User user = (User) request.getSession().getAttribute("user");

        //查找客户的钱包信息
        if (user != null) {
            model.addAttribute("user", user);
        }
        return "account/personal";

    }

}
