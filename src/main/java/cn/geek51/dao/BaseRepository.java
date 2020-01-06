package cn.geek51.dao;

import cn.geek51.domain.Post;
import com.sun.org.apache.xml.internal.utils.NameSpace;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 持久层基类 - 抽象模版设计模式
 */
@Repository
public class BaseRepository<T> {
    private String nameSpace = this.getClass().getName() + ".";

    public String getClassName() {
        Class<T> tClass = (Class<T>)((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        return tClass.getName();
    }

    @Autowired
    protected SqlSessionTemplate sqlSessionTemplate;

    /**
     * 插入数据
     * @param param
     * @return
     */
    public int insertSelective(Object param, String nameSpace) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        return sqlSessionTemplate.insert(nameSpace + methodName, param);
    }

    /**
     * 根据给定参数删除数据
     * @param param
     * @return 执行返回值
     */
    public int deleteOneByParams(Object param, String nameSpace) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        return sqlSessionTemplate.delete(nameSpace + methodName, param);
    }

    /**
     * 查询数据
     */
    public T selectOneByPrimaryKey(Object id, String nameSpace) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        return sqlSessionTemplate.selectOne(nameSpace + methodName, id);
    }
    public List<T> selectAllByParams(Object param, String namespace) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        return sqlSessionTemplate.selectList(namespace + methodName, param);
    }

    /**
     * 更新数据
     * 可选参数
     */
    public int updateByPrimaryKeySelective(Object param, String nameSpace) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        return sqlSessionTemplate.update(nameSpace + methodName, param);
    }

    public int getCount(String nameSpace) {
        String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
        return sqlSessionTemplate.selectOne(nameSpace + methodName);
    }
}
