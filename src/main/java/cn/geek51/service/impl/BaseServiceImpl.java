package cn.geek51.service.impl;

import cn.geek51.dao.BaseRepository;
import cn.geek51.service.AbstractIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * BaseServiceImpl
 * 业务方法实现基类
 * 实现AbstractIService: 业务方法的公共接口
 */
@Service
@Transactional
public class BaseServiceImpl<T> implements AbstractIService<T> {
    // 这里Spring自动从工厂注入了子类, 与具体的DAO进行了关联
    public String actualClassName;

    @Autowired
    @Qualifier("baseRepository")
    protected BaseRepository<T> baseRepository;

    public void refreshActualClassName() {
        Class<T> tClass = (Class<T>)((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        this.actualClassName = tClass.getName() + ".";
    }

    @Override
    public int save(Object object) {
        refreshActualClassName();
        return baseRepository.insertSelective(object, this.actualClassName);
    }

    @Override
    @Transactional(readOnly = true)
    public T listOneById(Integer id) {
        refreshActualClassName();
        return baseRepository.selectOneByPrimaryKey(id, this.actualClassName);
    }

    @Override
    @Transactional(readOnly = true)
    public List<T> listAll(Object object) {
        refreshActualClassName();
        return baseRepository.selectAllByParams(object, this.actualClassName);
    }


    @Override
    @Transactional(readOnly = true)
    public List<T> listAll() {
        return listAll(null);
    }

    @Override
    public int update(Object object) {
        refreshActualClassName();
        return baseRepository.updateByPrimaryKeySelective(object, this.actualClassName);
    }

    @Override
    public int delete(Object object) {
        refreshActualClassName();
        Map<Object, Object> map;
        if (object instanceof Integer) {
            map = new HashMap<>();
            map.put("id", object);
            return baseRepository.deleteOneByParams(map, this.actualClassName);
        }
        return baseRepository.deleteOneByParams(object, this.actualClassName);
    }

    @Override
    public int count() {
        refreshActualClassName();
        return baseRepository.getCount(this.actualClassName);
    }

}
