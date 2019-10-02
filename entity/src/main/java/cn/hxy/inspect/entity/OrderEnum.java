package cn.hxy.inspect.entity;

public enum OrderEnum {

    BILL_UNPAY(50, "订单未付款", "订单未支付", ""),
    BILL_PAY(100, "订单已付款", "订单支付成功", ""),
    BILL_ASSIGNING(150,"分配中","订单已处理","订单确认中");

    private int code;
    private String adminStatus;
    private String cusStatus;
    private String inspectorStatus;

    OrderEnum(int code, String adminStatus, String cusStatus, String inspectorStatus) {
        this.code = code;
        this.adminStatus = adminStatus;
        this.inspectorStatus = inspectorStatus;
        this.cusStatus = cusStatus;
    }

    public int getCode() {
        return code;
    }

    public String getAdminStatus() {
        return this.adminStatus;
    }

    public String getCusStatus() {
        return cusStatus;
    }

    public String getInspectorStatus() {
        return inspectorStatus;
    }

}
