package cn.hxy.inspect.admin.controller;

import cn.hxy.inspect.admin.service.AccountService;
import cn.hxy.inspect.entity.Account;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
//@RequestMapping("/finance")
public class FinanceController {
    private final static Logger logger = LoggerFactory.getLogger(FinanceController.class);
    @Resource
    AccountService accountService;

    @RequestMapping(value = "/payment", method = RequestMethod.GET)
    public String payment(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Account> ls= accountService.selectAllByType("1");
        model.addAttribute("list",ls);
        return "finance/payment";
    }

    /**
     * 提现
     * @param model
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/withdraw", method = RequestMethod.GET)
    public String withdraw(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Account> ls= accountService.selectAllByType("2");
        model.addAttribute("list",ls);
        return "finance/withdraw";
    }
}
