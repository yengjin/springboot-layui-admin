package cn.geek51.service;

import java.util.List;

public interface AbstractIService<T> {
    /**
     * 增加元素
     * @param object
     */
    int save(T object);

    /**
     * 查询所有元素
     */
    List<T> listAll();
    List<T> listAll(Object object);

    T listOneById(Integer id);

    /**
     * 更改指定元素
     * @param object
     */
    int update(Object object);

    /**
     * 根据ID删除指定元素
     * @param object
     */
    int delete(Object object);

    /**
     * 获取所有数据的总条数
     * @return
     */
    int count();
}
