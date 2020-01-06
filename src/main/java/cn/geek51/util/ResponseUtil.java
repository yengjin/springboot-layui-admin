package cn.geek51.util;

import java.util.HashMap;
import java.util.Map;

public class ResponseUtil {
    public static final int CODE_OK = 200;
    public static final int CODE_ERROR = 402;
    public static final int CODE_EXCEPTION = 405;

    public static Map<Object,Object> general_response(Integer statusCode, String msg, Object data, Map<Object, Object> args) {
        Map<Object, Object> map = new HashMap<>();
        map.put("code", statusCode);
        map.put("msg", msg);
        map.put("data", data);
        if (args != null) {
            for (Map.Entry<Object, Object> entry : args.entrySet()) {
                map.put(entry.getKey(), entry.getValue());
            }
        }
        return map;
    }

    public static Map<Object,Object> general_response(String msg, Object data) {
        return general_response(200, msg, data, null);
    }

    public static Map<Object,Object> general_response(Integer statusCode, String msg) {
        return general_response(statusCode, msg, null, null);
    }

    public static Map<Object,Object> general_response(String msg) {
        return general_response(200, msg, null, null);
    }

    public static Map<Object,Object> general_response(Object data) {
        return general_response(200, "success", data, null);
    }

    public static Map<Object,Object> general_response(String msg, Object data, Map<Object, Object> args) {
        return general_response(200, msg, data, args);
    }

    public static Map<Object,Object> general_response(Integer statusCode, String msg, Map<Object, Object> args) {
        return general_response(statusCode, msg, null, args);
    }

    public static Map<Object,Object> general_response(String msg, Map<Object, Object> args) {
        return general_response(200, msg, null, args);
    }

    public static Map<Object,Object> general_response(Object data, Map<Object, Object> args) {
        return general_response(200, "success", data, args);
    }
}
