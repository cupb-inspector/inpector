package cn.hxy.inspect.admin.controller;

import cn.hxy.inspect.admin.service.AccountService;
import cn.hxy.inspect.admin.service.CusUserService;
import cn.hxy.inspect.entity.Account;
import cn.hxy.inspect.entity.admin.AdminUser;
import cn.hxy.inspect.entity.customer.CusUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/")
public class AccountController {
	private final static Logger logger = LoggerFactory.getLogger(AccountController.class);

	@RequestMapping(value = "/payment-details", method = RequestMethod.GET)
	public String cusInsertOrder(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 获取用户是否登录
		AdminUser user = (AdminUser) request.getSession().getAttribute("user");
		if (user != null) {
			String id = request.getParameter("id");
			AccountService accountService = new AccountService();
			try {
				Account account = accountService.selectAccountById(id);

				model.addAttribute("photo", account.getFileUuid());
				model.addAttribute("ordersId", account.getId());
				model.addAttribute("status", account.getTypeString());
				model.addAttribute("value", account.getValue());
				model.addAttribute("date", account.getTime());

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "finance/payment-details";
	}

	@RequestMapping(value = "/account-verify", method = RequestMethod.POST)
	public void accountVerify(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 获取用户是否登录
		AdminUser user = (AdminUser) request.getSession().getAttribute("user");
		int resultCode = 0;
		int resulStatus = 0;// 最后的状态
		if (user != null) {
			String id = request.getParameter("id");
			String flag = request.getParameter("flag");
			AccountService accountService = new AccountService();

			try {
				boolean f = false;
				Account account2 = new Account();
				account2 = accountService.selectAccountById(id);
				account2.setStatus("1");
				String userId = account2.getUserId();
				CusUserService ca = new CusUserService();
				CusUser cusUser = ca.selectUserById(userId);
				if (cusUser != null) {
					int money = cusUser.getCusMoney();
					int temMoney = cusUser.getCusTempMoney();
					int value = account2.getValue();

					String op = account2.getOperate().trim();
					int a = -1;
					int b = 0;
					logger.info(flag+"操作："+op+"过渡余额" + cusUser.getCusTempMoney() + "流水：" + account2.getValue());
					if ("conform".equals(flag)) {
						// 充值
						if ("1".equals(op)) {
							a = money + value;
							// 过渡余额需要减

							b = temMoney - value;
							logger.info("最后结果：" + b);
							f = true;
							account2.setResult(2);
							resulStatus = 2;

						}
						// 减,提现
						else if ("2".equals(op)) {
							logger.info("用户提现");
							if (money >= value) {
								a = money - value;
								f = true;
								account2.setResult(4);
								resulStatus = 4;
							} else {
								resultCode = 699;// 逻辑错误
								// 这个时候发现用户的余额是不满足提现额度的，即使管理员通过后，提现依旧失败！
								// 失败：用户真正余额不变，但是临时余额增加
								account2.setResult(3);
								resulStatus = 3;
							}
							b = temMoney + value;
							logger.info("最后结果：" + b);

						} else {
							logger.info("未知加减");

						}

						if (a != -1) {
							cusUser.setCusMoney(a);
							cusUser.setCusTempMoney(b);

						}

					} else if ("cancel".equals(flag)) {
						logger.info("管理员拒绝通过充值");
						account2.setId(id);
						account2.setStatus("2");
						// 这时候过度余额就需要纠正了

						// 充值
						if ("1".equals(op)) {
							// 过渡余额需要减
							b = temMoney - value;
							account2.setResult(1);
							resulStatus = 1;
						}
						// 减,提现
						else if ("2".equals(op)) {
							b = temMoney + value;
							account2.setResult(3);
							resulStatus = 3;
						}
						logger.info("最后结果：" + b);
						cusUser.setCusTempMoney(b);
						f = true;

					}else {
						logger.info("不是通过也不是拒绝？");
					}

					if (1 == ca.update(cusUser)) {
						resultCode = 200;
						f = true;
					} else {
						resultCode = 599;// 数据库操作失败
						f = false;
					}

				} else {
					resultCode = 404;
				}

				if (f == true && 1 == accountService.updateStatus(account2)) {
					resultCode = 200;
				} else
					resultCode = 599;// 数据库操作失败

			} catch (IOException e) {
				e.printStackTrace();
				resultCode = 598;// 数据库内部错误
			}
		}
		logger.info("返回注册信息");

		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("resultStatus", resulStatus);
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().append(jsonStr2);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
