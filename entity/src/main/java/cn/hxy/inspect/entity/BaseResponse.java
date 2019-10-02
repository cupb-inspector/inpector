package cn.hxy.inspect.entity;

import lombok.AllArgsConstructor;

public class BaseResponse<T> {

    int code;
    String message;
    T data;

    public BaseResponse(int code, String message) {
        this.code = code;
        this.message = message;
    }
    public  BaseResponse(int code, String message,T data) {
        this.code = code;
        this.message = message;
        this.data=data;
    }

    static void success(){

    }
}
