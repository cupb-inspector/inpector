package cn.hxy.inspect.entity.customer.controller;

import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.entity.customer.User;
import cn.hxy.inspect.entity.customer.service.OrderService;
import cn.hxy.inspect.util.Configuration;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/")
public class ReportController {
	private final static Logger logger = LoggerFactory.getLogger(OrderController.class);

	@RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
	public void downloadReport(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

//		request.setCharacterEncoding("utf-8");
		// 得到要下载的文件名
		String fileName = request.getParameter("fileuuid"); // 2323928392489-美人鱼.avi
		// 处理文件名
		String realName = request.getParameter("filename");
		fileName = new String(fileName.getBytes("iso8859-1"), "UTF-8");
		logger.info("解析后的文件名：" + fileName);
		realName = new String(realName.getBytes("iso8859-1"), "UTF-8");
		logger.info("下载文件名：" + fileName);
		// 上传的文件都是保存在/WEB-INF/upload目录下的子目录当中
//		String fileSaveRootPath = this.getServletContext().getRealPath("/WEB-INF/upload");
		File fileFolder = new File("reports");
		if (!fileFolder.exists()) {
			fileFolder.mkdirs();
		}
		Configuration.FILE_ROOT_DIR = fileFolder.getAbsolutePath();
		// 得到要下载的文件
		File file = new File(Configuration.FILE_ROOT_DIR + "/" + fileName);
		logger.info("下载文件：" + file);
		// 如果文件不存在
		if (!file.exists()) {
			request.setAttribute("message", "您要下载的资源已被删除！！");
			request.getRequestDispatcher("/message.jsp").forward(request, response);
			return;
		}
		// 设置响应头，控制浏览器下载该文件
		response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realName, "UTF-8"));
		// 读取要下载的文件，保存到文件输入流
		FileInputStream in = new FileInputStream(file);
		// 创建输出流
		OutputStream out = response.getOutputStream();
		// 创建缓冲区
		byte buffer[] = new byte[1024];
		int len = 0;
		// 循环将输入流中的内容读取到缓冲区当中
		while ((len = in.read(buffer)) > 0) {
			// 输出缓冲区的内容到浏览器，实现文件下载
			out.write(buffer, 0, len);
		}
		// 关闭文件输入流
		in.close();
		// 关闭输出流
		out.close();

	}

	@RequestMapping(value = "/submitReport", method = RequestMethod.POST)
	public void submitReport(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		// 接收报告文件和订单的id，修改订单的报告位置

		logger.info("开始报告");

		String resultCode = "";
		String ordersId = null;
//		doGet(request, response);
		// 使用Apache文件上传组件处理文件上传步骤：
		// 1、创建一个DiskFileItemFactory工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 2、创建一个文件上传解析器
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 解决上传文件名的中文乱码
		upload.setHeaderEncoding("UTF-8");
		// 3、判断提交上来的数据是否是上传表单的数据
		if (!ServletFileUpload.isMultipartContent(request)) {
			// 按照传统方式获取数据
			return;
		}

		// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项

		List<FileItem> list = null;

		// 解决：https://blog.csdn.net/sinat_34104446/article/details/82755403

		RequestContext context = new ServletRequestContext(request);
		try {
			list = upload.parseRequest(context);
			logger.info("遍历的大小" + list.size());
		} catch (FileUploadException e) {
			e.printStackTrace();
		}

		for (FileItem item : list) {
			logger.info("遍历文件");

			// 如果fileitem中封装的是普通输入项的数据
			// System.out.println("名字："+item.getName());

			if (item.isFormField()) {
				logger.info(item.getFieldName());
				String name = item.getFieldName();
				// 解决普通输入项的数据的中文乱码问题
				String value = item.getString("UTF-8");
				logger.info(name + "\t" + value);
				if ("id".equals(name)) {
					ordersId = value;
				}

			} else {
				String fileName = item.getName();
				String uuid = UUID.randomUUID().toString().replace("-", "");
				;// 全球唯一标识码

				String reportfileuuid = uuid + fileName;

				File fileFolder = new File("reports");
				if (!fileFolder.exists()) {
					fileFolder.mkdirs();
				}
				Configuration.FILE_ROOT_DIR = fileFolder.getAbsolutePath();

				File file = new File(Configuration.FILE_ROOT_DIR, reportfileuuid);

				try { // 创建一个文件输出流
					InputStream in = item.getInputStream();
					FileOutputStream out = new FileOutputStream(file);
					// 创建一个缓冲区
					byte buffer[] = new byte[1024]; // 判断输入流中的数据是否已经读完的标识
					int len = 0;
					// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
					while ((len = in.read(buffer)) > 0) {
						out.write(buffer, 0, len);
					} // 关闭输入流
					in.close();
					// 关闭输出流
					out.close(); // 删除处理文件上传时生成的临时文件
					item.delete();
					resultCode = "200";

					// 更新订单，报告
					Orders orders = new Orders();
					orders.setOrderid(ordersId);
					orders.setReportfile(fileName);
					orders.setReportfileuuid(reportfileuuid);
					orders.setStatus(Configuration.BILL_SUBMITTED);
					OrderService orderService = new OrderService();
					orderService.updateReport(orders);

				} catch (FileNotFoundException e) {
					e.printStackTrace();
					resultCode = "601";// 错误
				}
				logger.info("文件名路径：" + file.getAbsolutePath());
			}
		}
		// 返回信息
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("key2", "today4");
		user_data.put("key3", "today2");
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append(jsonStr2);

	}

	@RequestMapping(value = "/verifyReport2", method = RequestMethod.POST)
	public void conformOrders(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		// 获取用户是否登录
		User user = (User) request.getSession().getAttribute("user");

		int resultCode = -1;
		if (user != null) {
			String id = request.getParameter("id").trim();// 执行日期
			String flag = request.getParameter("flag").trim();// 执行日期
			Orders order = new Orders();
			order.setOrderid(id);

			if ("cancel".equals(flag)) {
				logger.info("用户拒绝了报告");
				order.setStatus(Configuration.BILL_REPORT_UNPASSED);// 报告不通过接着重新提交报告
			} else if ("conform".equals(flag)) {
				logger.info("用户接受了报告");
				order.setStatus(Configuration.BILL_REPORT_PASSED);// 报告审核通过
			}

//			为该用户更新订单，依据订单的id查找订单，修改质检员的电话号码
			OrderService orderService = new OrderService();
			if (orderService.updateStatus(order)) {
				resultCode = 200;
			} else {
				resultCode = 500;
			}
			;
		} else {

		}
		logger.info("返回注册信息");
		org.json.JSONObject user_data = new org.json.JSONObject();
		user_data.put("resultCode", resultCode);
		user_data.put("key2", "today4");
		user_data.put("key3", "today2");
		String jsonStr2 = user_data.toString();
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().append(jsonStr2);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/selectReport", method = RequestMethod.GET)
	public HashMap<String, Object> selectReport(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		// 获取用户是否登录
		User user = (User) request.getSession().getAttribute("user");
		HashMap<String, Object> hashMap = new HashMap<>();
		int resultCode = -1;
		if (user != null) {
//			分页加载的实现技术
			String fuzzySearch = request.getParameter("fuzzySearch").trim();// 是否模糊搜索
			String startIndex = request.getParameter("startIndex").trim();// 分页加载的起点
			String pageSize = request.getParameter("pageSize").trim();// 分页加载的页面大小
			String draw = request.getParameter("draw").trim();// 视图
			logger.info(String.format("分页加载的参数%s\t%s\t%s\t%s", fuzzySearch, startIndex, pageSize, draw));
			HashMap<String, Object> hashMap2 = new HashMap<>();
			hashMap2.put("start", Integer.parseInt(startIndex));
			hashMap2.put("size", Integer.parseInt(pageSize));
			hashMap2.put("cusId", user.getCusid());
			hashMap2.put("status", Configuration.BILL_REPORT_VERIFIED);
			logger.info(hashMap2.toString());
//			查找该用户的报告，在订单表里面查找状态字和用户的tel
			Orders orders = new Orders();
			orders.setCusId(user.getCusid());
			orders.setStatus(Configuration.BILL_REPORT_SUBMIT);

			OrderService orderService = new OrderService();
			try {

				List<Orders> list = orderService.findByPage(hashMap2);
				logger.info("list" + list.toString());
				List<HashMap<String, String>> list2 = new ArrayList<HashMap<String, String>>();
				for (Orders orders2 : list) {
					HashMap<String, String> hashMa2p = new HashMap<>();
					hashMa2p.put("name", orders2.getFactoryname());
					hashMa2p.put("date", orders2.getDate());
					hashMa2p.put("goods", orders2.getGoods());
					hashMa2p.put("excedate", orders2.getExcedate());
					hashMa2p.put("reportfile", orders2.getReportfile());
					hashMa2p.put("reportfileuuid", orders2.getReportfileuuid());
					hashMa2p.put("id", orders2.getOrderid());
//					hashMa2p.put("role",orders2.getExcedate());
					list2.add(hashMa2p);
				}
				logger.info(list2.toString());
				hashMap.put("pageData", list2);
				hashMap.put("total", list.size());
//				hashMap.put("draw", list.size());
			} catch (IOException e) {
				e.printStackTrace();
			}
			;
		} else {
			resultCode = 404;
		}
		logger.info("返回报告信息");
		hashMap.put("resultCode", resultCode);

		return hashMap;
	}

}
