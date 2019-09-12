package cn.hxy.inspect.entity;

public class BaseResponse<T> {

    int code;
    String message;
    T data;

    BaseResponse(int code, String message) {
        this.code = code;
        this.message = message;
    }
    BaseResponse(int code, String message,T data) {
        this.code = code;
        this.message = message;
        this.data=data;
    }

    static void success(){

    }
}
