$(function (){
	var $wrapper = $('#div-table-container');
	var $table = $('#table-user');
	var _table = $table.dataTable($.extend(true,{},CONSTANT.DATA_TABLES.DEFAULT_OPTION, {
		ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
			//手动控制遮罩
			$wrapper.spinModal();
			//封装请求参数
			var param = userManage.getQueryCondition(data);
			$.ajax({
		            type: "GET",
		            url: "selectReport",
		            cache : false,	//禁用缓存
		            data: param,	//传入已封装的参数
		            dataType: "json",
		            success: function(result) {
		            	//setTimeout仅为测试遮罩效果
		            	setTimeout(function(){
		            		//异常判断与处理
		            		if (result.errorCode) {
		            			$.dialog.alert("查询失败。错误码："+result.errorCode);
		            			return;
							}
		            		//封装返回数据，这里仅演示了修改属性名
		            		var returnData = {};
			            	returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
			            	returnData.recordsTotal = result.total;
			            	returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
			            	
			            	
			        		var data1 = [
			    			    [
			    			        "Tiger Nixon",
			    			        "System Architect",
			    			        "Edinburgh"
			    			    ],
			    			    [
			    			        "Garrett Winters",
			    			        "好的",
			    			        "编辑"
			    			    ]
			    			]
			        	 	ParsedObject=	result.pageData;
			        		//不知道是缺少什么东西，代码不能自动解析这个对象，导致一直错误。，等待研究具体原因
			        		var	data2=[];
			            	for (var i=0; i< ParsedObject.length; i++) {
			            	    var temp_item = ParsedObject[i]; //new row data
			            		console.log("查看结果项"+temp_item.name);
			            		data2.push(
			   						 [
			   							temp_item.id,
			   							temp_item.goods,
			   							temp_item.name,
			   							temp_item.date, 
			   							temp_item.reportfile,
			   							temp_item.excedate
			   						    ]
			   				);
//			            	    table.fnAddData(temp_item.name, temp_item.position, temp_item.status); //adds new row to datatable
			            	}
			            	returnData.data=data2;
//			        		returnData.data=data1;
//			            	returnData.data = result.pageData;
			            	console.log("查看结果"+returnData.data);
			           
			 
			            	
			            	//关闭遮罩
			            	$wrapper.spinModal(false);
			            	//调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
			            	//此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
			            	callback(returnData);
		            	},200);
		            },
		            error: function(XMLHttpRequest, textStatus, errorThrown) {
		                $.dialog.alert("查询失败");
		                $wrapper.spinModal(false);
		            }
		        });
		}
 
	})).api();//此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象

});

var userManage = {
	currentItem : null,
	fuzzySearch : true,
	getQueryCondition : function(data) {
		var param = {};
		//组装排序参数
		if (data.order&&data.order.length&&data.order[0]) {
			switch (data.order[0].column) {
			case 1:
				param.orderColumn = "name";
				break;
			case 2:
				param.orderColumn = "position";
				break;
			case 3:
				param.orderColumn = "status";
				break;
			default:
				param.orderColumn = "name";
				break;
			}
			param.orderDir = data.order[0].dir;
		}
		//组装查询参数
		param.fuzzySearch = userManage.fuzzySearch;
		if (userManage.fuzzySearch) {
			param.fuzzy = $("#fuzzy-search").val();
		}else{
			param.name = $("#name-search").val();
			param.position = $("#position-search").val();
			param.office = $("#office-search").val();
			param.extn = $("#extn-search").val();
			param.status = $("#status-search").val();
			param.role = $("#role-search").val();
		}
		//组装分页参数
		param.startIndex = data.start;
		param.pageSize = data.length;
		
		param.draw = data.draw;
		
		return param;
	}
};