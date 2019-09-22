package cn.hxy.inspect.inspector.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.hxy.inspect.entity.Orders;
import cn.hxy.inspect.entity.inspector.Inspector;
import cn.hxy.inspect.inspector.service.OrderService;
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

@Controller
@RequestMapping("/")
public class ReportController {
	private final static Logger logger = LoggerFactory.getLogger(ReportController.class);


	@RequestMapping(value = "reports-unfinished")
	public String unfinished(ModelMap model, HttpServletRequest request) throws IOException {
		//枚举模板，只要是迭代类型变量都可以
		Inspector inspector = (Inspector)request.getSession().getAttribute("user");
		List<Integer> odUD=new Vector<Integer>();int[]temp = new int[]{1,2,3,4,5};for(int i:temp)odUD.add(i);
		OrderService orderService = new OrderService();
		List<Orders> ls = orderService.findOrdersByStatusAndInspector(odUD,inspector.getUserId());

		model.addAttribute("list",ls);

		return "report/reports-unfinished";
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
				String uuid = UUID.randomUUID().toString().replace("-", "");;// 全球唯一标识码

				String reportfileuuid = uuid + fileName;
				logger.info("Length of reportFileUUID:"+reportfileuuid.length());

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
					orders.setStatus(4);
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
}
